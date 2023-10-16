// Console input and output.
// Input is from the keyboard or serial port.
// Output is written to the screen and serial port.

#include "types.h"
#include "defs.h"
#include "param.h"
#include "traps.h"
#include "spinlock.h"
#include "sleeplock.h"
#include "fs.h"
#include "file.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"
#include "x86.h"

static void consputc(int);

static int panicked = 0;

static struct
{
  struct spinlock lock;
  int locking;
} cons;

static void
printint(int xx, int base, int sign)
{
  static char digits[] = "0123456789abcdef";
  char buf[16];
  int i;
  uint x;

  if (sign && (sign = xx < 0))
    x = -xx;
  else
    x = xx;

  i = 0;
  do
  {
    buf[i++] = digits[x % base];
  } while ((x /= base) != 0);

  if (sign)
    buf[i++] = '-';

  while (--i >= 0)
    consputc(buf[i]);
}
// PAGEBREAK: 50

// Print to the console. only understands %d, %x, %p, %s.
void cprintf(char *fmt, ...)
{
  int i, c, locking;
  uint *argp;
  char *s;

  locking = cons.locking;
  if (locking)
    acquire(&cons.lock);

  if (fmt == 0)
    panic("null fmt");

  argp = (uint *)(void *)(&fmt + 1);
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++)
  {
    if (c != '%')
    {
      consputc(c);
      continue;
    }
    c = fmt[++i] & 0xff;
    if (c == 0)
      break;
    switch (c)
    {
    case 'd':
      printint(*argp++, 10, 1);
      break;
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
      break;
    case 's':
      if ((s = (char *)*argp++) == 0)
        s = "(null)";
      for (; *s; s++)
        consputc(*s);
      break;
    case '%':
      consputc('%');
      break;
    default:
      // Print unknown % sequence to draw attention.
      consputc('%');
      consputc(c);
      break;
    }
  }

  if (locking)
    release(&cons.lock);
}

void panic(char *s)
{
  int i;
  uint pcs[10];

  cli();
  cons.locking = 0;
  // use lapiccpunum so that we can call panic from mycpu()
  cprintf("lapicid %d: panic: ", lapicid());
  cprintf(s);
  cprintf("\n");
  getcallerpcs(&s, pcs);
  for (i = 0; i < 10; i++)
    cprintf(" %p", pcs[i]);
  panicked = 1; // freeze other CPU
  for (;;)
    ;
}

// PAGEBREAK: 50
#define BACKSPACE 0x100
#define BACKWARD 0x101
#define FORWARD 0x102
#define CLEAR 0x103
#define CRTPORT 0x3d4
#define INPUT_BUF 78

static ushort *crt = (ushort *)P2V(0xb8000); // CGA memory
static int lineLength = 0;
static int current = -1;
static int maxCommands = 0;
static int commands[10][INPUT_BUF];
static int lineLengths[10];

static void cgaputc(int c)
{
  int pos;

  // Cursor position: col + 80*row.
  outb(CRTPORT, 14);
  pos = inb(CRTPORT + 1) << 8;
  outb(CRTPORT, 15);
  pos |= inb(CRTPORT + 1);

  if (c == '\n')
    pos += 80 - pos % 80;
  else if (c == BACKSPACE)
  {
    if (pos > 0)
    {
      --pos;
      for (int i = pos; i < 25 * 80 - 1; i++)
        crt[i] = crt[i + 1];
    }
  }
  else if (c == BACKWARD)
  {
    if (pos > 0)
      --pos;
  }
  else if (c == FORWARD)
    ++pos;
  else if (c == CLEAR)
  {
    int rows = pos / 80;
    memmove(crt, crt + rows * 80, sizeof(crt[0]) * 2);
    pos = 2;
    memset(crt + pos, 0, sizeof(crt[0]) * (25 * 80 - pos));
  }
  else
  {
    for (int i = 25 * 80 - 1; i > pos; i--)
    {
      crt[i] = crt[i - 1];
    }
    crt[pos++] = (c & 0xff) | 0x0700;
  } // black on white

  if (pos < 0 || pos > 25 * 80)
    panic("pos under/overflow");

  if ((pos / 80) >= 24)
  { // Scroll up.
    memmove(crt, crt + 80, sizeof(crt[0]) * 23 * 80);
    pos -= 80;
    memset(crt + pos, 0, sizeof(crt[0]) * (24 * 80 - pos));
  }

  outb(CRTPORT, 14);
  outb(CRTPORT + 1, pos >> 8);
  outb(CRTPORT, 15);
  outb(CRTPORT + 1, pos);
}

void consputc(int c)
{
  if (panicked)
  {
    cli();
    for (;;)
      ;
  }

  if (c == BACKSPACE)
    uartputc('\b');
  else if (c < BACKSPACE)
    uartputc(c);
  cgaputc(c);
}

struct
{
  char buf[INPUT_BUF];
  uint r; // Read index
  uint w; // Write index
  uint e; // Edit index
} input;

#define C(x) ((x) - '@') // Control-x

int currentIndex()
{
  return input.e - input.w;
}

void BackToStart()
{
  while (currentIndex() > 0)
  {
    input.e--;
    consputc(BACKWARD);
  }
}

void GoEndLine()
{
  while (currentIndex() < lineLength)
  {
    input.e++;
    consputc(FORWARD);
  }
}

void KillLine()
{
  GoEndLine();
  while (currentIndex() > 0) //
  //&& input.buf[(input.e - 1) % INPUT_BUF] != '\n')
  {
    input.buf[input.e--] = 0;
    consputc(BACKSPACE);
  }
  lineLength = 0;
}

void Change()
{
  KillLine();
  lineLength = lineLengths[current];
  memset(input.buf, 0, INPUT_BUF * sizeof(input.buf[0]));
  for (int i = input.w; i < input.w + lineLength; i++)
    input.buf[i] = commands[current][i - input.w];
  input.e = input.w + lineLength;
  for (int i = 0; i < lineLength; i++)
    consputc(commands[current][i]);
  // BackToStart();
}

void BackSpace()
{
  if (currentIndex() > 0)
  {
    input.e--;
    for (int i = input.e % INPUT_BUF; i < INPUT_BUF - 1; i++)
      input.buf[i] = input.buf[i + 1];

    lineLength--;
    consputc(BACKSPACE);
  }
}

void SubmitCommand(int c)
{
  for (int i = 8; i >= 0; i--)
  {
    for (int j = 0; j < INPUT_BUF; j++)
      commands[i + 1][j] = commands[i][j];
    lineLengths[i + 1] = lineLengths[i];
  }
  memset(commands[0], 0, INPUT_BUF * sizeof(int));
  for (int j = input.w; j < input.w + lineLength; j++)
    commands[0][j - input.w] = input.buf[j];
  lineLengths[0] = lineLength;

  input.e = lineLength + input.w;
  input.buf[input.e++ % INPUT_BUF] = c;
  input.w = input.e;
  maxCommands = maxCommands == 10 ? 10 : (maxCommands + 1);
  wakeup(&input.r);
  lineLength = 0;
  current = -1;
}

void consoleintr(int (*getc)(void))
{
  int c, doprocdump = 0;

  acquire(&cons.lock);
  while ((c = getc()) >= 0)
  {
    switch (c)
    {
    case 226: // UP
      if (current < maxCommands - 1)
      {
        current++;
        Change();
      }
      break;
    case 227:
      if (current > 0)
      {
        current--;
        Change();
      }
      else if (current == 0)
      {
        current--;
        KillLine();
      }
      break;
    case C('P'): // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
      break;
    case C('U'): // Kill line.
      KillLine();
      break;
    case C('Q'):
      BackToStart();
      break;
    case C('E'):
      GoEndLine();
      break;
    case C('L'):
      input.e = input.w;
      consputc(CLEAR);
      break;
    case C('B'):
      if (currentIndex() > 0) //
      {
        input.e--;
        consputc(BACKWARD);
      }
      break;
    case C('F'):
      if (currentIndex() < lineLength) //
      {
        input.e++;
        consputc(FORWARD);
      }
      break;
    case C('H'):
    case '\x7f': // Backspace
      BackSpace();
      break;
    default:
      if (c != 0 && input.e - input.r < INPUT_BUF)
      {
        c = (c == '\r') ? '\n' : c;
        consputc(c);
        if (c == '\n' || c == C('D') || input.e == input.r + INPUT_BUF)
          SubmitCommand(c);
        else
        {
          lineLength++;
          for (int i = input.e % INPUT_BUF; i < INPUT_BUF - 1; i++)
            input.buf[i + 1] = input.buf[i];

          input.buf[input.e % INPUT_BUF] = c;
          input.e++;
        }
      }
      break;
    }
  }
  release(&cons.lock);
  if (doprocdump)
  {
    procdump(); // now call procdump() wo. cons.lock held
  }
}

int consoleread(struct inode *ip, char *dst, int n)
{
  uint target;
  int c;

  iunlock(ip);
  target = n;
  acquire(&cons.lock);
  while (n > 0)
  {
    while (input.r == input.w)
    {
      if (myproc()->killed)
      {
        release(&cons.lock);
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
    }
    c = input.buf[input.r++ % INPUT_BUF];
    if (c == C('D'))
    { // EOF
      if (n < target)
      {
        // Save ^D for next time, to make sure
        // caller gets a 0-byte result.
        input.r--;
      }
      break;
    }
    *dst++ = c;
    --n;
    if (c == '\n')
      break;
  }
  release(&cons.lock);
  ilock(ip);

  return target - n;
}

int consolewrite(struct inode *ip, char *buf, int n)
{
  int i;

  iunlock(ip);
  acquire(&cons.lock);
  for (i = 0; i < n; i++)
    consputc(buf[i] & 0xff);
  release(&cons.lock);
  ilock(ip);

  return n;
}

void consoleinit(void)
{
  initlock(&cons.lock, "console");

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  ioapicenable(IRQ_KBD, 0);
}
