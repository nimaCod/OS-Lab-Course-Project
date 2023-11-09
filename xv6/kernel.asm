
kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4                   	.byte 0xe4

8010000c <entry>:

# Entering xv6 on boot processor, with paging off.
.globl entry
entry:
  # Turn on page size extension for 4Mbyte pages
  movl    %cr4, %eax
8010000c:	0f 20 e0             	mov    %cr4,%eax
  orl     $(CR4_PSE), %eax
8010000f:	83 c8 10             	or     $0x10,%eax
  movl    %eax, %cr4
80100012:	0f 22 e0             	mov    %eax,%cr4
  # Set page directory
  movl    $(V2P_WO(entrypgdir)), %eax
80100015:	b8 00 a0 10 00       	mov    $0x10a000,%eax
  movl    %eax, %cr3
8010001a:	0f 22 d8             	mov    %eax,%cr3
  # Turn on paging.
  movl    %cr0, %eax
8010001d:	0f 20 c0             	mov    %cr0,%eax
  orl     $(CR0_PG|CR0_WP), %eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
  movl    %eax, %cr0
80100025:	0f 22 c0             	mov    %eax,%cr0

  # Set up the stack pointer.
  movl $(stack + KSTACKSIZE), %esp
80100028:	bc 40 d2 10 80       	mov    $0x8010d240,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
8010002d:	b8 80 36 10 80       	mov    $0x80103680,%eax
  jmp *%eax
80100032:	ff e0                	jmp    *%eax
80100034:	66 90                	xchg   %ax,%ax
80100036:	66 90                	xchg   %ax,%ax
80100038:	66 90                	xchg   %ax,%ax
8010003a:	66 90                	xchg   %ax,%ax
8010003c:	66 90                	xchg   %ax,%ax
8010003e:	66 90                	xchg   %ax,%ax

80100040 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
80100040:	f3 0f 1e fb          	endbr32 
80100044:	55                   	push   %ebp
80100045:	89 e5                	mov    %esp,%ebp
80100047:	53                   	push   %ebx

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100048:	bb 74 d2 10 80       	mov    $0x8010d274,%ebx
{
8010004d:	83 ec 0c             	sub    $0xc,%esp
  initlock(&bcache.lock, "bcache");
80100050:	68 00 79 10 80       	push   $0x80107900
80100055:	68 40 d2 10 80       	push   $0x8010d240
8010005a:	e8 a1 4a 00 00       	call   80104b00 <initlock>
  bcache.head.next = &bcache.head;
8010005f:	83 c4 10             	add    $0x10,%esp
80100062:	b8 3c 19 11 80       	mov    $0x8011193c,%eax
  bcache.head.prev = &bcache.head;
80100067:	c7 05 8c 19 11 80 3c 	movl   $0x8011193c,0x8011198c
8010006e:	19 11 80 
  bcache.head.next = &bcache.head;
80100071:	c7 05 90 19 11 80 3c 	movl   $0x8011193c,0x80111990
80100078:	19 11 80 
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
8010007b:	eb 05                	jmp    80100082 <binit+0x42>
8010007d:	8d 76 00             	lea    0x0(%esi),%esi
80100080:	89 d3                	mov    %edx,%ebx
    b->next = bcache.head.next;
80100082:	89 43 54             	mov    %eax,0x54(%ebx)
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
80100085:	83 ec 08             	sub    $0x8,%esp
80100088:	8d 43 0c             	lea    0xc(%ebx),%eax
    b->prev = &bcache.head;
8010008b:	c7 43 50 3c 19 11 80 	movl   $0x8011193c,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
80100092:	68 07 79 10 80       	push   $0x80107907
80100097:	50                   	push   %eax
80100098:	e8 23 49 00 00       	call   801049c0 <initsleeplock>
    bcache.head.next->prev = b;
8010009d:	a1 90 19 11 80       	mov    0x80111990,%eax
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000a2:	8d 93 5c 02 00 00    	lea    0x25c(%ebx),%edx
801000a8:	83 c4 10             	add    $0x10,%esp
    bcache.head.next->prev = b;
801000ab:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
801000ae:	89 d8                	mov    %ebx,%eax
801000b0:	89 1d 90 19 11 80    	mov    %ebx,0x80111990
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000b6:	81 fb e0 16 11 80    	cmp    $0x801116e0,%ebx
801000bc:	75 c2                	jne    80100080 <binit+0x40>
  }
}
801000be:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801000c1:	c9                   	leave  
801000c2:	c3                   	ret    
801000c3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801000ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801000d0 <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
801000d0:	f3 0f 1e fb          	endbr32 
801000d4:	55                   	push   %ebp
801000d5:	89 e5                	mov    %esp,%ebp
801000d7:	57                   	push   %edi
801000d8:	56                   	push   %esi
801000d9:	53                   	push   %ebx
801000da:	83 ec 18             	sub    $0x18,%esp
801000dd:	8b 7d 08             	mov    0x8(%ebp),%edi
801000e0:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&bcache.lock);
801000e3:	68 40 d2 10 80       	push   $0x8010d240
801000e8:	e8 93 4b 00 00       	call   80104c80 <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000ed:	8b 1d 90 19 11 80    	mov    0x80111990,%ebx
801000f3:	83 c4 10             	add    $0x10,%esp
801000f6:	81 fb 3c 19 11 80    	cmp    $0x8011193c,%ebx
801000fc:	75 0d                	jne    8010010b <bread+0x3b>
801000fe:	eb 20                	jmp    80100120 <bread+0x50>
80100100:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100103:	81 fb 3c 19 11 80    	cmp    $0x8011193c,%ebx
80100109:	74 15                	je     80100120 <bread+0x50>
    if(b->dev == dev && b->blockno == blockno){
8010010b:	3b 7b 04             	cmp    0x4(%ebx),%edi
8010010e:	75 f0                	jne    80100100 <bread+0x30>
80100110:	3b 73 08             	cmp    0x8(%ebx),%esi
80100113:	75 eb                	jne    80100100 <bread+0x30>
      b->refcnt++;
80100115:	83 43 4c 01          	addl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
80100119:	eb 3f                	jmp    8010015a <bread+0x8a>
8010011b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010011f:	90                   	nop
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100120:	8b 1d 8c 19 11 80    	mov    0x8011198c,%ebx
80100126:	81 fb 3c 19 11 80    	cmp    $0x8011193c,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x6b>
8010012e:	eb 70                	jmp    801001a0 <bread+0xd0>
80100130:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100133:	81 fb 3c 19 11 80    	cmp    $0x8011193c,%ebx
80100139:	74 65                	je     801001a0 <bread+0xd0>
    if(b->refcnt == 0 && (b->flags & B_DIRTY) == 0) {
8010013b:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010013e:	85 c0                	test   %eax,%eax
80100140:	75 ee                	jne    80100130 <bread+0x60>
80100142:	f6 03 04             	testb  $0x4,(%ebx)
80100145:	75 e9                	jne    80100130 <bread+0x60>
      b->dev = dev;
80100147:	89 7b 04             	mov    %edi,0x4(%ebx)
      b->blockno = blockno;
8010014a:	89 73 08             	mov    %esi,0x8(%ebx)
      b->flags = 0;
8010014d:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
      b->refcnt = 1;
80100153:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
8010015a:	83 ec 0c             	sub    $0xc,%esp
8010015d:	68 40 d2 10 80       	push   $0x8010d240
80100162:	e8 d9 4b 00 00       	call   80104d40 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 8e 48 00 00       	call   80104a00 <acquiresleep>
      return b;
80100172:	83 c4 10             	add    $0x10,%esp
  struct buf *b;

  b = bget(dev, blockno);
  if((b->flags & B_VALID) == 0) {
80100175:	f6 03 02             	testb  $0x2,(%ebx)
80100178:	74 0e                	je     80100188 <bread+0xb8>
    iderw(b);
  }
  return b;
}
8010017a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010017d:	89 d8                	mov    %ebx,%eax
8010017f:	5b                   	pop    %ebx
80100180:	5e                   	pop    %esi
80100181:	5f                   	pop    %edi
80100182:	5d                   	pop    %ebp
80100183:	c3                   	ret    
80100184:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    iderw(b);
80100188:	83 ec 0c             	sub    $0xc,%esp
8010018b:	53                   	push   %ebx
8010018c:	e8 2f 27 00 00       	call   801028c0 <iderw>
80100191:	83 c4 10             	add    $0x10,%esp
}
80100194:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100197:	89 d8                	mov    %ebx,%eax
80100199:	5b                   	pop    %ebx
8010019a:	5e                   	pop    %esi
8010019b:	5f                   	pop    %edi
8010019c:	5d                   	pop    %ebp
8010019d:	c3                   	ret    
8010019e:	66 90                	xchg   %ax,%ax
  panic("bget: no buffers");
801001a0:	83 ec 0c             	sub    $0xc,%esp
801001a3:	68 0e 79 10 80       	push   $0x8010790e
801001a8:	e8 03 02 00 00       	call   801003b0 <panic>
801001ad:	8d 76 00             	lea    0x0(%esi),%esi

801001b0 <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
801001b0:	f3 0f 1e fb          	endbr32 
801001b4:	55                   	push   %ebp
801001b5:	89 e5                	mov    %esp,%ebp
801001b7:	53                   	push   %ebx
801001b8:	83 ec 10             	sub    $0x10,%esp
801001bb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001be:	8d 43 0c             	lea    0xc(%ebx),%eax
801001c1:	50                   	push   %eax
801001c2:	e8 d9 48 00 00       	call   80104aa0 <holdingsleep>
801001c7:	83 c4 10             	add    $0x10,%esp
801001ca:	85 c0                	test   %eax,%eax
801001cc:	74 0f                	je     801001dd <bwrite+0x2d>
    panic("bwrite");
  b->flags |= B_DIRTY;
801001ce:	83 0b 04             	orl    $0x4,(%ebx)
  iderw(b);
801001d1:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801001d4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801001d7:	c9                   	leave  
  iderw(b);
801001d8:	e9 e3 26 00 00       	jmp    801028c0 <iderw>
    panic("bwrite");
801001dd:	83 ec 0c             	sub    $0xc,%esp
801001e0:	68 1f 79 10 80       	push   $0x8010791f
801001e5:	e8 c6 01 00 00       	call   801003b0 <panic>
801001ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801001f0 <brelse>:

// Release a locked buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
801001f0:	f3 0f 1e fb          	endbr32 
801001f4:	55                   	push   %ebp
801001f5:	89 e5                	mov    %esp,%ebp
801001f7:	56                   	push   %esi
801001f8:	53                   	push   %ebx
801001f9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001fc:	8d 73 0c             	lea    0xc(%ebx),%esi
801001ff:	83 ec 0c             	sub    $0xc,%esp
80100202:	56                   	push   %esi
80100203:	e8 98 48 00 00       	call   80104aa0 <holdingsleep>
80100208:	83 c4 10             	add    $0x10,%esp
8010020b:	85 c0                	test   %eax,%eax
8010020d:	74 66                	je     80100275 <brelse+0x85>
    panic("brelse");

  releasesleep(&b->lock);
8010020f:	83 ec 0c             	sub    $0xc,%esp
80100212:	56                   	push   %esi
80100213:	e8 48 48 00 00       	call   80104a60 <releasesleep>

  acquire(&bcache.lock);
80100218:	c7 04 24 40 d2 10 80 	movl   $0x8010d240,(%esp)
8010021f:	e8 5c 4a 00 00       	call   80104c80 <acquire>
  b->refcnt--;
80100224:	8b 43 4c             	mov    0x4c(%ebx),%eax
  if (b->refcnt == 0) {
80100227:	83 c4 10             	add    $0x10,%esp
  b->refcnt--;
8010022a:	83 e8 01             	sub    $0x1,%eax
8010022d:	89 43 4c             	mov    %eax,0x4c(%ebx)
  if (b->refcnt == 0) {
80100230:	85 c0                	test   %eax,%eax
80100232:	75 2f                	jne    80100263 <brelse+0x73>
    // no one is waiting for it.
    b->next->prev = b->prev;
80100234:	8b 43 54             	mov    0x54(%ebx),%eax
80100237:	8b 53 50             	mov    0x50(%ebx),%edx
8010023a:	89 50 50             	mov    %edx,0x50(%eax)
    b->prev->next = b->next;
8010023d:	8b 43 50             	mov    0x50(%ebx),%eax
80100240:	8b 53 54             	mov    0x54(%ebx),%edx
80100243:	89 50 54             	mov    %edx,0x54(%eax)
    b->next = bcache.head.next;
80100246:	a1 90 19 11 80       	mov    0x80111990,%eax
    b->prev = &bcache.head;
8010024b:	c7 43 50 3c 19 11 80 	movl   $0x8011193c,0x50(%ebx)
    b->next = bcache.head.next;
80100252:	89 43 54             	mov    %eax,0x54(%ebx)
    bcache.head.next->prev = b;
80100255:	a1 90 19 11 80       	mov    0x80111990,%eax
8010025a:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
8010025d:	89 1d 90 19 11 80    	mov    %ebx,0x80111990
  }
  
  release(&bcache.lock);
80100263:	c7 45 08 40 d2 10 80 	movl   $0x8010d240,0x8(%ebp)
}
8010026a:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010026d:	5b                   	pop    %ebx
8010026e:	5e                   	pop    %esi
8010026f:	5d                   	pop    %ebp
  release(&bcache.lock);
80100270:	e9 cb 4a 00 00       	jmp    80104d40 <release>
    panic("brelse");
80100275:	83 ec 0c             	sub    $0xc,%esp
80100278:	68 26 79 10 80       	push   $0x80107926
8010027d:	e8 2e 01 00 00       	call   801003b0 <panic>
80100282:	66 90                	xchg   %ax,%ax
80100284:	66 90                	xchg   %ax,%ax
80100286:	66 90                	xchg   %ax,%ax
80100288:	66 90                	xchg   %ax,%ax
8010028a:	66 90                	xchg   %ax,%ax
8010028c:	66 90                	xchg   %ax,%ax
8010028e:	66 90                	xchg   %ax,%ax

80100290 <consoleread>:
    procdump(); // now call procdump() wo. cons.lock held
  }
}

int consoleread(struct inode *ip, char *dst, int n)
{
80100290:	f3 0f 1e fb          	endbr32 
80100294:	55                   	push   %ebp
80100295:	89 e5                	mov    %esp,%ebp
80100297:	57                   	push   %edi
80100298:	56                   	push   %esi
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
    }
    c = input.buf[input.r++ % INPUT_BUF];
80100299:	be d3 20 0d d2       	mov    $0xd20d20d3,%esi
{
8010029e:	53                   	push   %ebx
8010029f:	83 ec 28             	sub    $0x28,%esp
  iunlock(ip);
801002a2:	ff 75 08             	pushl  0x8(%ebp)
{
801002a5:	8b 5d 10             	mov    0x10(%ebp),%ebx
  iunlock(ip);
801002a8:	e8 d3 1b 00 00       	call   80101e80 <iunlock>
  acquire(&cons.lock);
801002ad:	c7 04 24 a0 c1 10 80 	movl   $0x8010c1a0,(%esp)
  target = n;
801002b4:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
  acquire(&cons.lock);
801002b7:	e8 c4 49 00 00       	call   80104c80 <acquire>
        // caller gets a 0-byte result.
        input.r--;
      }
      break;
    }
    *dst++ = c;
801002bc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  while (n > 0)
801002bf:	83 c4 10             	add    $0x10,%esp
    *dst++ = c;
801002c2:	01 df                	add    %ebx,%edi
  while (n > 0)
801002c4:	85 db                	test   %ebx,%ebx
801002c6:	0f 8e a5 00 00 00    	jle    80100371 <consoleread+0xe1>
    while (input.r == input.w)
801002cc:	8b 0d f0 1b 11 80    	mov    0x80111bf0,%ecx
801002d2:	3b 0d f4 1b 11 80    	cmp    0x80111bf4,%ecx
801002d8:	74 29                	je     80100303 <consoleread+0x73>
801002da:	eb 5c                	jmp    80100338 <consoleread+0xa8>
801002dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      sleep(&input.r, &cons.lock);
801002e0:	83 ec 08             	sub    $0x8,%esp
801002e3:	68 a0 c1 10 80       	push   $0x8010c1a0
801002e8:	68 f0 1b 11 80       	push   $0x80111bf0
801002ed:	e8 9e 42 00 00       	call   80104590 <sleep>
    while (input.r == input.w)
801002f2:	8b 0d f0 1b 11 80    	mov    0x80111bf0,%ecx
801002f8:	83 c4 10             	add    $0x10,%esp
801002fb:	3b 0d f4 1b 11 80    	cmp    0x80111bf4,%ecx
80100301:	75 35                	jne    80100338 <consoleread+0xa8>
      if (myproc()->killed)
80100303:	e8 98 3c 00 00       	call   80103fa0 <myproc>
80100308:	8b 48 24             	mov    0x24(%eax),%ecx
8010030b:	85 c9                	test   %ecx,%ecx
8010030d:	74 d1                	je     801002e0 <consoleread+0x50>
        release(&cons.lock);
8010030f:	83 ec 0c             	sub    $0xc,%esp
80100312:	68 a0 c1 10 80       	push   $0x8010c1a0
80100317:	e8 24 4a 00 00       	call   80104d40 <release>
        ilock(ip);
8010031c:	5a                   	pop    %edx
8010031d:	ff 75 08             	pushl  0x8(%ebp)
80100320:	e8 7b 1a 00 00       	call   80101da0 <ilock>
        return -1;
80100325:	83 c4 10             	add    $0x10,%esp
  }
  release(&cons.lock);
  ilock(ip);

  return target - n;
}
80100328:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return -1;
8010032b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100330:	5b                   	pop    %ebx
80100331:	5e                   	pop    %esi
80100332:	5f                   	pop    %edi
80100333:	5d                   	pop    %ebp
80100334:	c3                   	ret    
80100335:	8d 76 00             	lea    0x0(%esi),%esi
    c = input.buf[input.r++ % INPUT_BUF];
80100338:	89 ca                	mov    %ecx,%edx
8010033a:	8d 41 01             	lea    0x1(%ecx),%eax
8010033d:	d1 ea                	shr    %edx
8010033f:	a3 f0 1b 11 80       	mov    %eax,0x80111bf0
80100344:	89 d0                	mov    %edx,%eax
80100346:	f7 e6                	mul    %esi
80100348:	89 c8                	mov    %ecx,%eax
8010034a:	c1 ea 05             	shr    $0x5,%edx
8010034d:	6b d2 4e             	imul   $0x4e,%edx,%edx
80100350:	29 d0                	sub    %edx,%eax
80100352:	0f be 90 a0 1b 11 80 	movsbl -0x7feee460(%eax),%edx
    if (c == C('D'))
80100359:	80 fa 04             	cmp    $0x4,%dl
8010035c:	74 39                	je     80100397 <consoleread+0x107>
    *dst++ = c;
8010035e:	89 d9                	mov    %ebx,%ecx
    --n;
80100360:	83 eb 01             	sub    $0x1,%ebx
    *dst++ = c;
80100363:	f7 d9                	neg    %ecx
80100365:	88 14 0f             	mov    %dl,(%edi,%ecx,1)
    if (c == '\n')
80100368:	83 fa 0a             	cmp    $0xa,%edx
8010036b:	0f 85 53 ff ff ff    	jne    801002c4 <consoleread+0x34>
  release(&cons.lock);
80100371:	83 ec 0c             	sub    $0xc,%esp
80100374:	68 a0 c1 10 80       	push   $0x8010c1a0
80100379:	e8 c2 49 00 00       	call   80104d40 <release>
  ilock(ip);
8010037e:	58                   	pop    %eax
8010037f:	ff 75 08             	pushl  0x8(%ebp)
80100382:	e8 19 1a 00 00       	call   80101da0 <ilock>
  return target - n;
80100387:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010038a:	83 c4 10             	add    $0x10,%esp
}
8010038d:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return target - n;
80100390:	29 d8                	sub    %ebx,%eax
}
80100392:	5b                   	pop    %ebx
80100393:	5e                   	pop    %esi
80100394:	5f                   	pop    %edi
80100395:	5d                   	pop    %ebp
80100396:	c3                   	ret    
      if (n < target)
80100397:	3b 5d e4             	cmp    -0x1c(%ebp),%ebx
8010039a:	73 d5                	jae    80100371 <consoleread+0xe1>
        input.r--;
8010039c:	89 0d f0 1b 11 80    	mov    %ecx,0x80111bf0
801003a2:	eb cd                	jmp    80100371 <consoleread+0xe1>
801003a4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801003ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801003af:	90                   	nop

801003b0 <panic>:
{
801003b0:	f3 0f 1e fb          	endbr32 
801003b4:	55                   	push   %ebp
801003b5:	89 e5                	mov    %esp,%ebp
801003b7:	56                   	push   %esi
801003b8:	53                   	push   %ebx
801003b9:	83 ec 30             	sub    $0x30,%esp
}

static inline void
cli(void)
{
  asm volatile("cli");
801003bc:	fa                   	cli    
  cons.locking = 0;
801003bd:	c7 05 d4 c1 10 80 00 	movl   $0x0,0x8010c1d4
801003c4:	00 00 00 
  getcallerpcs(&s, pcs);
801003c7:	8d 5d d0             	lea    -0x30(%ebp),%ebx
801003ca:	8d 75 f8             	lea    -0x8(%ebp),%esi
  cprintf("lapicid %d: panic: ", lapicid());
801003cd:	e8 0e 2b 00 00       	call   80102ee0 <lapicid>
801003d2:	83 ec 08             	sub    $0x8,%esp
801003d5:	50                   	push   %eax
801003d6:	68 2d 79 10 80       	push   $0x8010792d
801003db:	e8 c0 03 00 00       	call   801007a0 <cprintf>
  cprintf(s);
801003e0:	58                   	pop    %eax
801003e1:	ff 75 08             	pushl  0x8(%ebp)
801003e4:	e8 b7 03 00 00       	call   801007a0 <cprintf>
  cprintf("\n");
801003e9:	c7 04 24 4f 83 10 80 	movl   $0x8010834f,(%esp)
801003f0:	e8 ab 03 00 00       	call   801007a0 <cprintf>
  getcallerpcs(&s, pcs);
801003f5:	8d 45 08             	lea    0x8(%ebp),%eax
801003f8:	5a                   	pop    %edx
801003f9:	59                   	pop    %ecx
801003fa:	53                   	push   %ebx
801003fb:	50                   	push   %eax
801003fc:	e8 1f 47 00 00       	call   80104b20 <getcallerpcs>
  for (i = 0; i < 10; i++)
80100401:	83 c4 10             	add    $0x10,%esp
    cprintf(" %p", pcs[i]);
80100404:	83 ec 08             	sub    $0x8,%esp
80100407:	ff 33                	pushl  (%ebx)
80100409:	83 c3 04             	add    $0x4,%ebx
8010040c:	68 41 79 10 80       	push   $0x80107941
80100411:	e8 8a 03 00 00       	call   801007a0 <cprintf>
  for (i = 0; i < 10; i++)
80100416:	83 c4 10             	add    $0x10,%esp
80100419:	39 f3                	cmp    %esi,%ebx
8010041b:	75 e7                	jne    80100404 <panic+0x54>
  panicked = 1; // freeze other CPU
8010041d:	c7 05 d8 c1 10 80 01 	movl   $0x1,0x8010c1d8
80100424:	00 00 00 
  for (;;)
80100427:	eb fe                	jmp    80100427 <panic+0x77>
80100429:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80100430 <cgaputc>:
{
80100430:	55                   	push   %ebp
80100431:	89 e5                	mov    %esp,%ebp
80100433:	57                   	push   %edi
  asm volatile("out %0,%1" : : "a"(data), "d"(port));
80100434:	bf d4 03 00 00       	mov    $0x3d4,%edi
80100439:	56                   	push   %esi
8010043a:	89 fa                	mov    %edi,%edx
8010043c:	53                   	push   %ebx
8010043d:	89 c3                	mov    %eax,%ebx
8010043f:	b8 0e 00 00 00       	mov    $0xe,%eax
80100444:	83 ec 0c             	sub    $0xc,%esp
80100447:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a"(data) : "d"(port));
80100448:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
8010044d:	89 ca                	mov    %ecx,%edx
8010044f:	ec                   	in     (%dx),%al
  pos = inb(CRTPORT + 1) << 8;
80100450:	0f b6 f0             	movzbl %al,%esi
  asm volatile("out %0,%1" : : "a"(data), "d"(port));
80100453:	89 fa                	mov    %edi,%edx
80100455:	b8 0f 00 00 00       	mov    $0xf,%eax
8010045a:	c1 e6 08             	shl    $0x8,%esi
8010045d:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a"(data) : "d"(port));
8010045e:	89 ca                	mov    %ecx,%edx
80100460:	ec                   	in     (%dx),%al
  pos |= inb(CRTPORT + 1);
80100461:	0f b6 c8             	movzbl %al,%ecx
80100464:	09 f1                	or     %esi,%ecx
  if (c == '\n')
80100466:	83 fb 0a             	cmp    $0xa,%ebx
80100469:	0f 84 e9 00 00 00    	je     80100558 <cgaputc+0x128>
  else if (c == BACKSPACE)
8010046f:	81 fb 00 01 00 00    	cmp    $0x100,%ebx
80100475:	0f 84 a5 00 00 00    	je     80100520 <cgaputc+0xf0>
  else if (c == BACKWARD)
8010047b:	81 fb 01 01 00 00    	cmp    $0x101,%ebx
80100481:	0f 84 39 01 00 00    	je     801005c0 <cgaputc+0x190>
    ++pos;
80100487:	8d 71 01             	lea    0x1(%ecx),%esi
  else if (c == FORWARD)
8010048a:	81 fb 02 01 00 00    	cmp    $0x102,%ebx
80100490:	74 45                	je     801004d7 <cgaputc+0xa7>
  else if (c == CLEAR)
80100492:	81 fb 03 01 00 00    	cmp    $0x103,%ebx
80100498:	0f 84 3a 01 00 00    	je     801005d8 <cgaputc+0x1a8>
    for (int i = 25 * 80 - 1; i > pos; i--)
8010049e:	8d b4 09 fe 7f 0b 80 	lea    -0x7ff48002(%ecx,%ecx,1),%esi
801004a5:	b8 9c 8f 0b 80       	mov    $0x800b8f9c,%eax
801004aa:	81 f9 ce 07 00 00    	cmp    $0x7ce,%ecx
801004b0:	7f 14                	jg     801004c6 <cgaputc+0x96>
801004b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      crt[i] = crt[i - 1];
801004b8:	0f b7 10             	movzwl (%eax),%edx
801004bb:	83 e8 02             	sub    $0x2,%eax
801004be:	66 89 50 04          	mov    %dx,0x4(%eax)
    for (int i = 25 * 80 - 1; i > pos; i--)
801004c2:	39 c6                	cmp    %eax,%esi
801004c4:	75 f2                	jne    801004b8 <cgaputc+0x88>
    crt[pos++] = (c & 0xff) | 0x0700;
801004c6:	0f b6 db             	movzbl %bl,%ebx
801004c9:	8d 71 01             	lea    0x1(%ecx),%esi
801004cc:	80 cf 07             	or     $0x7,%bh
801004cf:	66 89 9c 09 00 80 0b 	mov    %bx,-0x7ff48000(%ecx,%ecx,1)
801004d6:	80 
  if (pos < 0 || pos > 25 * 80)
801004d7:	81 fe d0 07 00 00    	cmp    $0x7d0,%esi
801004dd:	0f 8f 3f 01 00 00    	jg     80100622 <cgaputc+0x1f2>
  if ((pos / 80) >= 24)
801004e3:	81 fe 7f 07 00 00    	cmp    $0x77f,%esi
801004e9:	0f 8f 89 00 00 00    	jg     80100578 <cgaputc+0x148>
801004ef:	89 f0                	mov    %esi,%eax
801004f1:	0f b6 dc             	movzbl %ah,%ebx
  asm volatile("out %0,%1" : : "a"(data), "d"(port));
801004f4:	bf d4 03 00 00       	mov    $0x3d4,%edi
801004f9:	b8 0e 00 00 00       	mov    $0xe,%eax
801004fe:	89 fa                	mov    %edi,%edx
80100500:	ee                   	out    %al,(%dx)
80100501:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
80100506:	89 d8                	mov    %ebx,%eax
80100508:	89 ca                	mov    %ecx,%edx
8010050a:	ee                   	out    %al,(%dx)
8010050b:	b8 0f 00 00 00       	mov    $0xf,%eax
80100510:	89 fa                	mov    %edi,%edx
80100512:	ee                   	out    %al,(%dx)
80100513:	89 f0                	mov    %esi,%eax
80100515:	89 ca                	mov    %ecx,%edx
80100517:	ee                   	out    %al,(%dx)
}
80100518:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010051b:	5b                   	pop    %ebx
8010051c:	5e                   	pop    %esi
8010051d:	5f                   	pop    %edi
8010051e:	5d                   	pop    %ebp
8010051f:	c3                   	ret    
    if (pos > 0)
80100520:	85 c9                	test   %ecx,%ecx
80100522:	0f 84 a3 00 00 00    	je     801005cb <cgaputc+0x19b>
      --pos;
80100528:	8d 71 ff             	lea    -0x1(%ecx),%esi
      for (int i = pos; i < 25 * 80 - 1; i++)
8010052b:	81 fe ce 07 00 00    	cmp    $0x7ce,%esi
80100531:	7f a4                	jg     801004d7 <cgaputc+0xa7>
80100533:	8d 84 09 00 80 0b 80 	lea    -0x7ff48000(%ecx,%ecx,1),%eax
8010053a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        crt[i] = crt[i + 1];
80100540:	0f b7 10             	movzwl (%eax),%edx
80100543:	83 c0 02             	add    $0x2,%eax
80100546:	66 89 50 fc          	mov    %dx,-0x4(%eax)
      for (int i = pos; i < 25 * 80 - 1; i++)
8010054a:	3d a0 8f 0b 80       	cmp    $0x800b8fa0,%eax
8010054f:	75 ef                	jne    80100540 <cgaputc+0x110>
80100551:	eb 90                	jmp    801004e3 <cgaputc+0xb3>
80100553:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100557:	90                   	nop
    pos += 80 - pos % 80;
80100558:	89 c8                	mov    %ecx,%eax
8010055a:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
8010055f:	f7 e2                	mul    %edx
80100561:	c1 ea 06             	shr    $0x6,%edx
80100564:	8d 04 92             	lea    (%edx,%edx,4),%eax
80100567:	c1 e0 04             	shl    $0x4,%eax
8010056a:	8d 70 50             	lea    0x50(%eax),%esi
8010056d:	e9 65 ff ff ff       	jmp    801004d7 <cgaputc+0xa7>
80100572:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    memmove(crt, crt + 80, sizeof(crt[0]) * 23 * 80);
80100578:	83 ec 04             	sub    $0x4,%esp
    pos -= 80;
8010057b:	83 ee 50             	sub    $0x50,%esi
    memset(crt + pos, 0, sizeof(crt[0]) * (24 * 80 - pos));
8010057e:	bb 07 00 00 00       	mov    $0x7,%ebx
    memmove(crt, crt + 80, sizeof(crt[0]) * 23 * 80);
80100583:	68 60 0e 00 00       	push   $0xe60
80100588:	68 a0 80 0b 80       	push   $0x800b80a0
8010058d:	68 00 80 0b 80       	push   $0x800b8000
80100592:	e8 99 48 00 00       	call   80104e30 <memmove>
    memset(crt + pos, 0, sizeof(crt[0]) * (24 * 80 - pos));
80100597:	b8 80 07 00 00       	mov    $0x780,%eax
8010059c:	83 c4 0c             	add    $0xc,%esp
8010059f:	29 f0                	sub    %esi,%eax
801005a1:	01 c0                	add    %eax,%eax
801005a3:	50                   	push   %eax
801005a4:	8d 84 36 00 80 0b 80 	lea    -0x7ff48000(%esi,%esi,1),%eax
801005ab:	6a 00                	push   $0x0
801005ad:	50                   	push   %eax
801005ae:	e8 dd 47 00 00       	call   80104d90 <memset>
801005b3:	83 c4 10             	add    $0x10,%esp
801005b6:	e9 39 ff ff ff       	jmp    801004f4 <cgaputc+0xc4>
801005bb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801005bf:	90                   	nop
      --pos;
801005c0:	8d 71 ff             	lea    -0x1(%ecx),%esi
    if (pos > 0)
801005c3:	85 c9                	test   %ecx,%ecx
801005c5:	0f 85 0c ff ff ff    	jne    801004d7 <cgaputc+0xa7>
801005cb:	31 f6                	xor    %esi,%esi
801005cd:	31 db                	xor    %ebx,%ebx
801005cf:	e9 20 ff ff ff       	jmp    801004f4 <cgaputc+0xc4>
801005d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    int rows = pos / 80;
801005d8:	89 c8                	mov    %ecx,%eax
801005da:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
    memmove(crt, crt + rows * 80, sizeof(crt[0]) * 2);
801005df:	83 ec 04             	sub    $0x4,%esp
    memset(crt + pos, 0, sizeof(crt[0]) * (25 * 80 - pos));
801005e2:	be 02 00 00 00       	mov    $0x2,%esi
    int rows = pos / 80;
801005e7:	f7 e2                	mul    %edx
    memmove(crt, crt + rows * 80, sizeof(crt[0]) * 2);
801005e9:	6a 04                	push   $0x4
    memset(crt + pos, 0, sizeof(crt[0]) * (25 * 80 - pos));
801005eb:	31 db                	xor    %ebx,%ebx
    int rows = pos / 80;
801005ed:	c1 ea 06             	shr    $0x6,%edx
    memmove(crt, crt + rows * 80, sizeof(crt[0]) * 2);
801005f0:	8d 04 92             	lea    (%edx,%edx,4),%eax
801005f3:	c1 e0 05             	shl    $0x5,%eax
801005f6:	2d 00 80 f4 7f       	sub    $0x7ff48000,%eax
801005fb:	50                   	push   %eax
801005fc:	68 00 80 0b 80       	push   $0x800b8000
80100601:	e8 2a 48 00 00       	call   80104e30 <memmove>
    memset(crt + pos, 0, sizeof(crt[0]) * (25 * 80 - pos));
80100606:	83 c4 0c             	add    $0xc,%esp
80100609:	68 9c 0f 00 00       	push   $0xf9c
8010060e:	6a 00                	push   $0x0
80100610:	68 04 80 0b 80       	push   $0x800b8004
80100615:	e8 76 47 00 00       	call   80104d90 <memset>
8010061a:	83 c4 10             	add    $0x10,%esp
8010061d:	e9 d2 fe ff ff       	jmp    801004f4 <cgaputc+0xc4>
    panic("pos under/overflow");
80100622:	83 ec 0c             	sub    $0xc,%esp
80100625:	68 45 79 10 80       	push   $0x80107945
8010062a:	e8 81 fd ff ff       	call   801003b0 <panic>
8010062f:	90                   	nop

80100630 <consputc.part.0>:
void consputc(int c)
80100630:	55                   	push   %ebp
80100631:	89 e5                	mov    %esp,%ebp
80100633:	83 ec 18             	sub    $0x18,%esp
  if (c == BACKSPACE)
80100636:	3d 00 01 00 00       	cmp    $0x100,%eax
8010063b:	74 33                	je     80100670 <consputc.part.0+0x40>
  else if (c < BACKSPACE)
8010063d:	3d ff 00 00 00       	cmp    $0xff,%eax
80100642:	7e 0c                	jle    80100650 <consputc.part.0+0x20>
}
80100644:	c9                   	leave  
  cgaputc(c);
80100645:	e9 e6 fd ff ff       	jmp    80100430 <cgaputc>
8010064a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    uartputc(c);
80100650:	83 ec 0c             	sub    $0xc,%esp
80100653:	89 45 f4             	mov    %eax,-0xc(%ebp)
80100656:	50                   	push   %eax
80100657:	e8 a4 5e 00 00       	call   80106500 <uartputc>
8010065c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010065f:	83 c4 10             	add    $0x10,%esp
}
80100662:	c9                   	leave  
  cgaputc(c);
80100663:	e9 c8 fd ff ff       	jmp    80100430 <cgaputc>
80100668:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010066f:	90                   	nop
    uartputc('\b');
80100670:	83 ec 0c             	sub    $0xc,%esp
80100673:	89 45 f4             	mov    %eax,-0xc(%ebp)
80100676:	6a 08                	push   $0x8
80100678:	e8 83 5e 00 00       	call   80106500 <uartputc>
8010067d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  cgaputc(c);
80100680:	83 c4 10             	add    $0x10,%esp
}
80100683:	c9                   	leave  
  cgaputc(c);
80100684:	e9 a7 fd ff ff       	jmp    80100430 <cgaputc>
80100689:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80100690 <printint>:
{
80100690:	55                   	push   %ebp
80100691:	89 e5                	mov    %esp,%ebp
80100693:	57                   	push   %edi
80100694:	56                   	push   %esi
80100695:	53                   	push   %ebx
80100696:	83 ec 2c             	sub    $0x2c,%esp
80100699:	89 55 d4             	mov    %edx,-0x2c(%ebp)
  if (sign && (sign = xx < 0))
8010069c:	85 c9                	test   %ecx,%ecx
8010069e:	74 04                	je     801006a4 <printint+0x14>
801006a0:	85 c0                	test   %eax,%eax
801006a2:	78 6d                	js     80100711 <printint+0x81>
    x = xx;
801006a4:	89 c1                	mov    %eax,%ecx
801006a6:	31 f6                	xor    %esi,%esi
  i = 0;
801006a8:	89 75 cc             	mov    %esi,-0x34(%ebp)
801006ab:	31 db                	xor    %ebx,%ebx
801006ad:	8d 7d d7             	lea    -0x29(%ebp),%edi
    buf[i++] = digits[x % base];
801006b0:	89 c8                	mov    %ecx,%eax
801006b2:	31 d2                	xor    %edx,%edx
801006b4:	89 ce                	mov    %ecx,%esi
801006b6:	f7 75 d4             	divl   -0x2c(%ebp)
801006b9:	0f b6 92 c8 79 10 80 	movzbl -0x7fef8638(%edx),%edx
801006c0:	89 45 d0             	mov    %eax,-0x30(%ebp)
801006c3:	89 d8                	mov    %ebx,%eax
801006c5:	8d 5b 01             	lea    0x1(%ebx),%ebx
  } while ((x /= base) != 0);
801006c8:	8b 4d d0             	mov    -0x30(%ebp),%ecx
801006cb:	89 75 d0             	mov    %esi,-0x30(%ebp)
    buf[i++] = digits[x % base];
801006ce:	88 14 1f             	mov    %dl,(%edi,%ebx,1)
  } while ((x /= base) != 0);
801006d1:	8b 75 d4             	mov    -0x2c(%ebp),%esi
801006d4:	39 75 d0             	cmp    %esi,-0x30(%ebp)
801006d7:	73 d7                	jae    801006b0 <printint+0x20>
801006d9:	8b 75 cc             	mov    -0x34(%ebp),%esi
  if (sign)
801006dc:	85 f6                	test   %esi,%esi
801006de:	74 0c                	je     801006ec <printint+0x5c>
    buf[i++] = '-';
801006e0:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
801006e5:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
801006e7:	ba 2d 00 00 00       	mov    $0x2d,%edx
  while (--i >= 0)
801006ec:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
801006f0:	0f be c2             	movsbl %dl,%eax
  if (panicked)
801006f3:	8b 15 d8 c1 10 80    	mov    0x8010c1d8,%edx
801006f9:	85 d2                	test   %edx,%edx
801006fb:	74 03                	je     80100700 <printint+0x70>
  asm volatile("cli");
801006fd:	fa                   	cli    
    for (;;)
801006fe:	eb fe                	jmp    801006fe <printint+0x6e>
80100700:	e8 2b ff ff ff       	call   80100630 <consputc.part.0>
  while (--i >= 0)
80100705:	39 fb                	cmp    %edi,%ebx
80100707:	74 10                	je     80100719 <printint+0x89>
80100709:	0f be 03             	movsbl (%ebx),%eax
8010070c:	83 eb 01             	sub    $0x1,%ebx
8010070f:	eb e2                	jmp    801006f3 <printint+0x63>
    x = -xx;
80100711:	f7 d8                	neg    %eax
80100713:	89 ce                	mov    %ecx,%esi
80100715:	89 c1                	mov    %eax,%ecx
80100717:	eb 8f                	jmp    801006a8 <printint+0x18>
}
80100719:	83 c4 2c             	add    $0x2c,%esp
8010071c:	5b                   	pop    %ebx
8010071d:	5e                   	pop    %esi
8010071e:	5f                   	pop    %edi
8010071f:	5d                   	pop    %ebp
80100720:	c3                   	ret    
80100721:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100728:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010072f:	90                   	nop

80100730 <consolewrite>:

int consolewrite(struct inode *ip, char *buf, int n)
{
80100730:	f3 0f 1e fb          	endbr32 
80100734:	55                   	push   %ebp
80100735:	89 e5                	mov    %esp,%ebp
80100737:	57                   	push   %edi
80100738:	56                   	push   %esi
80100739:	53                   	push   %ebx
8010073a:	83 ec 18             	sub    $0x18,%esp
  int i;

  iunlock(ip);
8010073d:	ff 75 08             	pushl  0x8(%ebp)
{
80100740:	8b 5d 10             	mov    0x10(%ebp),%ebx
  iunlock(ip);
80100743:	e8 38 17 00 00       	call   80101e80 <iunlock>
  acquire(&cons.lock);
80100748:	c7 04 24 a0 c1 10 80 	movl   $0x8010c1a0,(%esp)
8010074f:	e8 2c 45 00 00       	call   80104c80 <acquire>
  for (i = 0; i < n; i++)
80100754:	83 c4 10             	add    $0x10,%esp
80100757:	85 db                	test   %ebx,%ebx
80100759:	7e 24                	jle    8010077f <consolewrite+0x4f>
8010075b:	8b 7d 0c             	mov    0xc(%ebp),%edi
8010075e:	8d 34 1f             	lea    (%edi,%ebx,1),%esi
  if (panicked)
80100761:	8b 15 d8 c1 10 80    	mov    0x8010c1d8,%edx
80100767:	85 d2                	test   %edx,%edx
80100769:	74 05                	je     80100770 <consolewrite+0x40>
8010076b:	fa                   	cli    
    for (;;)
8010076c:	eb fe                	jmp    8010076c <consolewrite+0x3c>
8010076e:	66 90                	xchg   %ax,%ax
    consputc(buf[i] & 0xff);
80100770:	0f b6 07             	movzbl (%edi),%eax
80100773:	83 c7 01             	add    $0x1,%edi
80100776:	e8 b5 fe ff ff       	call   80100630 <consputc.part.0>
  for (i = 0; i < n; i++)
8010077b:	39 fe                	cmp    %edi,%esi
8010077d:	75 e2                	jne    80100761 <consolewrite+0x31>
  release(&cons.lock);
8010077f:	83 ec 0c             	sub    $0xc,%esp
80100782:	68 a0 c1 10 80       	push   $0x8010c1a0
80100787:	e8 b4 45 00 00       	call   80104d40 <release>
  ilock(ip);
8010078c:	58                   	pop    %eax
8010078d:	ff 75 08             	pushl  0x8(%ebp)
80100790:	e8 0b 16 00 00       	call   80101da0 <ilock>

  return n;
}
80100795:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100798:	89 d8                	mov    %ebx,%eax
8010079a:	5b                   	pop    %ebx
8010079b:	5e                   	pop    %esi
8010079c:	5f                   	pop    %edi
8010079d:	5d                   	pop    %ebp
8010079e:	c3                   	ret    
8010079f:	90                   	nop

801007a0 <cprintf>:
{
801007a0:	f3 0f 1e fb          	endbr32 
801007a4:	55                   	push   %ebp
801007a5:	89 e5                	mov    %esp,%ebp
801007a7:	57                   	push   %edi
801007a8:	56                   	push   %esi
801007a9:	53                   	push   %ebx
801007aa:	83 ec 1c             	sub    $0x1c,%esp
  locking = cons.locking;
801007ad:	a1 d4 c1 10 80       	mov    0x8010c1d4,%eax
801007b2:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if (locking)
801007b5:	85 c0                	test   %eax,%eax
801007b7:	0f 85 e8 00 00 00    	jne    801008a5 <cprintf+0x105>
  if (fmt == 0)
801007bd:	8b 45 08             	mov    0x8(%ebp),%eax
801007c0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801007c3:	85 c0                	test   %eax,%eax
801007c5:	0f 84 5a 01 00 00    	je     80100925 <cprintf+0x185>
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++)
801007cb:	0f b6 00             	movzbl (%eax),%eax
801007ce:	85 c0                	test   %eax,%eax
801007d0:	74 36                	je     80100808 <cprintf+0x68>
  argp = (uint *)(void *)(&fmt + 1);
801007d2:	8d 5d 0c             	lea    0xc(%ebp),%ebx
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++)
801007d5:	31 f6                	xor    %esi,%esi
    if (c != '%')
801007d7:	83 f8 25             	cmp    $0x25,%eax
801007da:	74 44                	je     80100820 <cprintf+0x80>
  if (panicked)
801007dc:	8b 0d d8 c1 10 80    	mov    0x8010c1d8,%ecx
801007e2:	85 c9                	test   %ecx,%ecx
801007e4:	74 0f                	je     801007f5 <cprintf+0x55>
801007e6:	fa                   	cli    
    for (;;)
801007e7:	eb fe                	jmp    801007e7 <cprintf+0x47>
801007e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801007f0:	b8 25 00 00 00       	mov    $0x25,%eax
801007f5:	e8 36 fe ff ff       	call   80100630 <consputc.part.0>
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++)
801007fa:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801007fd:	83 c6 01             	add    $0x1,%esi
80100800:	0f b6 04 30          	movzbl (%eax,%esi,1),%eax
80100804:	85 c0                	test   %eax,%eax
80100806:	75 cf                	jne    801007d7 <cprintf+0x37>
  if (locking)
80100808:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010080b:	85 c0                	test   %eax,%eax
8010080d:	0f 85 fd 00 00 00    	jne    80100910 <cprintf+0x170>
}
80100813:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100816:	5b                   	pop    %ebx
80100817:	5e                   	pop    %esi
80100818:	5f                   	pop    %edi
80100819:	5d                   	pop    %ebp
8010081a:	c3                   	ret    
8010081b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010081f:	90                   	nop
    c = fmt[++i] & 0xff;
80100820:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100823:	83 c6 01             	add    $0x1,%esi
80100826:	0f b6 3c 30          	movzbl (%eax,%esi,1),%edi
    if (c == 0)
8010082a:	85 ff                	test   %edi,%edi
8010082c:	74 da                	je     80100808 <cprintf+0x68>
    switch (c)
8010082e:	83 ff 70             	cmp    $0x70,%edi
80100831:	74 5a                	je     8010088d <cprintf+0xed>
80100833:	7f 2a                	jg     8010085f <cprintf+0xbf>
80100835:	83 ff 25             	cmp    $0x25,%edi
80100838:	0f 84 92 00 00 00    	je     801008d0 <cprintf+0x130>
8010083e:	83 ff 64             	cmp    $0x64,%edi
80100841:	0f 85 a1 00 00 00    	jne    801008e8 <cprintf+0x148>
      printint(*argp++, 10, 1);
80100847:	8b 03                	mov    (%ebx),%eax
80100849:	8d 7b 04             	lea    0x4(%ebx),%edi
8010084c:	b9 01 00 00 00       	mov    $0x1,%ecx
80100851:	ba 0a 00 00 00       	mov    $0xa,%edx
80100856:	89 fb                	mov    %edi,%ebx
80100858:	e8 33 fe ff ff       	call   80100690 <printint>
      break;
8010085d:	eb 9b                	jmp    801007fa <cprintf+0x5a>
    switch (c)
8010085f:	83 ff 73             	cmp    $0x73,%edi
80100862:	75 24                	jne    80100888 <cprintf+0xe8>
      if ((s = (char *)*argp++) == 0)
80100864:	8d 7b 04             	lea    0x4(%ebx),%edi
80100867:	8b 1b                	mov    (%ebx),%ebx
80100869:	85 db                	test   %ebx,%ebx
8010086b:	75 55                	jne    801008c2 <cprintf+0x122>
        s = "(null)";
8010086d:	bb 58 79 10 80       	mov    $0x80107958,%ebx
      for (; *s; s++)
80100872:	b8 28 00 00 00       	mov    $0x28,%eax
  if (panicked)
80100877:	8b 15 d8 c1 10 80    	mov    0x8010c1d8,%edx
8010087d:	85 d2                	test   %edx,%edx
8010087f:	74 39                	je     801008ba <cprintf+0x11a>
80100881:	fa                   	cli    
    for (;;)
80100882:	eb fe                	jmp    80100882 <cprintf+0xe2>
80100884:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    switch (c)
80100888:	83 ff 78             	cmp    $0x78,%edi
8010088b:	75 5b                	jne    801008e8 <cprintf+0x148>
      printint(*argp++, 16, 0);
8010088d:	8b 03                	mov    (%ebx),%eax
8010088f:	8d 7b 04             	lea    0x4(%ebx),%edi
80100892:	31 c9                	xor    %ecx,%ecx
80100894:	ba 10 00 00 00       	mov    $0x10,%edx
80100899:	89 fb                	mov    %edi,%ebx
8010089b:	e8 f0 fd ff ff       	call   80100690 <printint>
      break;
801008a0:	e9 55 ff ff ff       	jmp    801007fa <cprintf+0x5a>
    acquire(&cons.lock);
801008a5:	83 ec 0c             	sub    $0xc,%esp
801008a8:	68 a0 c1 10 80       	push   $0x8010c1a0
801008ad:	e8 ce 43 00 00       	call   80104c80 <acquire>
801008b2:	83 c4 10             	add    $0x10,%esp
801008b5:	e9 03 ff ff ff       	jmp    801007bd <cprintf+0x1d>
801008ba:	e8 71 fd ff ff       	call   80100630 <consputc.part.0>
      for (; *s; s++)
801008bf:	83 c3 01             	add    $0x1,%ebx
801008c2:	0f be 03             	movsbl (%ebx),%eax
801008c5:	84 c0                	test   %al,%al
801008c7:	75 ae                	jne    80100877 <cprintf+0xd7>
      if ((s = (char *)*argp++) == 0)
801008c9:	89 fb                	mov    %edi,%ebx
801008cb:	e9 2a ff ff ff       	jmp    801007fa <cprintf+0x5a>
  if (panicked)
801008d0:	8b 3d d8 c1 10 80    	mov    0x8010c1d8,%edi
801008d6:	85 ff                	test   %edi,%edi
801008d8:	0f 84 12 ff ff ff    	je     801007f0 <cprintf+0x50>
801008de:	fa                   	cli    
    for (;;)
801008df:	eb fe                	jmp    801008df <cprintf+0x13f>
801008e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if (panicked)
801008e8:	8b 0d d8 c1 10 80    	mov    0x8010c1d8,%ecx
801008ee:	85 c9                	test   %ecx,%ecx
801008f0:	74 06                	je     801008f8 <cprintf+0x158>
801008f2:	fa                   	cli    
    for (;;)
801008f3:	eb fe                	jmp    801008f3 <cprintf+0x153>
801008f5:	8d 76 00             	lea    0x0(%esi),%esi
801008f8:	b8 25 00 00 00       	mov    $0x25,%eax
801008fd:	e8 2e fd ff ff       	call   80100630 <consputc.part.0>
  if (panicked)
80100902:	8b 15 d8 c1 10 80    	mov    0x8010c1d8,%edx
80100908:	85 d2                	test   %edx,%edx
8010090a:	74 2c                	je     80100938 <cprintf+0x198>
8010090c:	fa                   	cli    
    for (;;)
8010090d:	eb fe                	jmp    8010090d <cprintf+0x16d>
8010090f:	90                   	nop
    release(&cons.lock);
80100910:	83 ec 0c             	sub    $0xc,%esp
80100913:	68 a0 c1 10 80       	push   $0x8010c1a0
80100918:	e8 23 44 00 00       	call   80104d40 <release>
8010091d:	83 c4 10             	add    $0x10,%esp
}
80100920:	e9 ee fe ff ff       	jmp    80100813 <cprintf+0x73>
    panic("null fmt");
80100925:	83 ec 0c             	sub    $0xc,%esp
80100928:	68 5f 79 10 80       	push   $0x8010795f
8010092d:	e8 7e fa ff ff       	call   801003b0 <panic>
80100932:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100938:	89 f8                	mov    %edi,%eax
8010093a:	e8 f1 fc ff ff       	call   80100630 <consputc.part.0>
8010093f:	e9 b6 fe ff ff       	jmp    801007fa <cprintf+0x5a>
80100944:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010094b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010094f:	90                   	nop

80100950 <currentIndex>:
{
80100950:	f3 0f 1e fb          	endbr32 
  return input.e - input.w;
80100954:	a1 f8 1b 11 80       	mov    0x80111bf8,%eax
80100959:	2b 05 f4 1b 11 80    	sub    0x80111bf4,%eax
}
8010095f:	c3                   	ret    

80100960 <BackToStart>:
{
80100960:	f3 0f 1e fb          	endbr32 
  return input.e - input.w;
80100964:	a1 f8 1b 11 80       	mov    0x80111bf8,%eax
80100969:	89 c2                	mov    %eax,%edx
8010096b:	2b 15 f4 1b 11 80    	sub    0x80111bf4,%edx
  while (currentIndex() > 0)
80100971:	85 d2                	test   %edx,%edx
80100973:	7e 38                	jle    801009ad <BackToStart+0x4d>
{
80100975:	55                   	push   %ebp
80100976:	89 e5                	mov    %esp,%ebp
80100978:	83 ec 08             	sub    $0x8,%esp
    input.e--;
8010097b:	83 e8 01             	sub    $0x1,%eax
8010097e:	a3 f8 1b 11 80       	mov    %eax,0x80111bf8
  if (panicked)
80100983:	a1 d8 c1 10 80       	mov    0x8010c1d8,%eax
80100988:	85 c0                	test   %eax,%eax
8010098a:	74 04                	je     80100990 <BackToStart+0x30>
8010098c:	fa                   	cli    
    for (;;)
8010098d:	eb fe                	jmp    8010098d <BackToStart+0x2d>
8010098f:	90                   	nop
  cgaputc(c);
80100990:	b8 01 01 00 00       	mov    $0x101,%eax
80100995:	e8 96 fa ff ff       	call   80100430 <cgaputc>
  return input.e - input.w;
8010099a:	a1 f8 1b 11 80       	mov    0x80111bf8,%eax
8010099f:	89 c2                	mov    %eax,%edx
801009a1:	2b 15 f4 1b 11 80    	sub    0x80111bf4,%edx
  while (currentIndex() > 0)
801009a7:	85 d2                	test   %edx,%edx
801009a9:	7f d0                	jg     8010097b <BackToStart+0x1b>
}
801009ab:	c9                   	leave  
801009ac:	c3                   	ret    
801009ad:	c3                   	ret    
801009ae:	66 90                	xchg   %ax,%ax

801009b0 <GoEndLine>:
{
801009b0:	f3 0f 1e fb          	endbr32 
  return input.e - input.w;
801009b4:	a1 f8 1b 11 80       	mov    0x80111bf8,%eax
801009b9:	89 c2                	mov    %eax,%edx
801009bb:	2b 15 f4 1b 11 80    	sub    0x80111bf4,%edx
  while (currentIndex() < lineLength)
801009c1:	3b 15 94 c1 10 80    	cmp    0x8010c194,%edx
801009c7:	7d 40                	jge    80100a09 <GoEndLine+0x59>
{
801009c9:	55                   	push   %ebp
801009ca:	89 e5                	mov    %esp,%ebp
801009cc:	83 ec 08             	sub    $0x8,%esp
    input.e++;
801009cf:	83 c0 01             	add    $0x1,%eax
801009d2:	a3 f8 1b 11 80       	mov    %eax,0x80111bf8
  if (panicked)
801009d7:	a1 d8 c1 10 80       	mov    0x8010c1d8,%eax
801009dc:	85 c0                	test   %eax,%eax
801009de:	74 08                	je     801009e8 <GoEndLine+0x38>
801009e0:	fa                   	cli    
    for (;;)
801009e1:	eb fe                	jmp    801009e1 <GoEndLine+0x31>
801009e3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801009e7:	90                   	nop
  cgaputc(c);
801009e8:	b8 02 01 00 00       	mov    $0x102,%eax
801009ed:	e8 3e fa ff ff       	call   80100430 <cgaputc>
  return input.e - input.w;
801009f2:	a1 f8 1b 11 80       	mov    0x80111bf8,%eax
801009f7:	89 c2                	mov    %eax,%edx
801009f9:	2b 15 f4 1b 11 80    	sub    0x80111bf4,%edx
  while (currentIndex() < lineLength)
801009ff:	39 15 94 c1 10 80    	cmp    %edx,0x8010c194
80100a05:	7f c8                	jg     801009cf <GoEndLine+0x1f>
}
80100a07:	c9                   	leave  
80100a08:	c3                   	ret    
80100a09:	c3                   	ret    
80100a0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100a10 <BackSpace>:
{
80100a10:	f3 0f 1e fb          	endbr32 
  return input.e - input.w;
80100a14:	8b 0d f8 1b 11 80    	mov    0x80111bf8,%ecx
80100a1a:	a1 f4 1b 11 80       	mov    0x80111bf4,%eax
80100a1f:	89 ca                	mov    %ecx,%edx
80100a21:	29 c2                	sub    %eax,%edx
  if (currentIndex() > 0)
80100a23:	85 d2                	test   %edx,%edx
80100a25:	0f 8e 9e 00 00 00    	jle    80100ac9 <BackSpace+0xb9>
{
80100a2b:	55                   	push   %ebp
    input.e--;
80100a2c:	83 e9 01             	sub    $0x1,%ecx
{
80100a2f:	89 e5                	mov    %esp,%ebp
80100a31:	57                   	push   %edi
80100a32:	56                   	push   %esi
80100a33:	53                   	push   %ebx
80100a34:	83 ec 1c             	sub    $0x1c,%esp
    for (int i = input.e; i < input.w + lineLength - 1; i++)
80100a37:	8b 35 94 c1 10 80    	mov    0x8010c194,%esi
    input.e--;
80100a3d:	89 0d f8 1b 11 80    	mov    %ecx,0x80111bf8
    for (int i = input.e; i < input.w + lineLength - 1; i++)
80100a43:	8d 7c 30 ff          	lea    -0x1(%eax,%esi,1),%edi
80100a47:	39 f9                	cmp    %edi,%ecx
80100a49:	73 51                	jae    80100a9c <BackSpace+0x8c>
      input.buf[i % INPUT_BUF] = input.buf[(i + 1) % INPUT_BUF];
80100a4b:	89 cb                	mov    %ecx,%ebx
80100a4d:	b8 d3 20 0d d2       	mov    $0xd20d20d3,%eax
80100a52:	83 c1 01             	add    $0x1,%ecx
80100a55:	f7 e9                	imul   %ecx
80100a57:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
80100a5a:	89 ca                	mov    %ecx,%edx
80100a5c:	c1 fa 1f             	sar    $0x1f,%edx
80100a5f:	c1 f8 06             	sar    $0x6,%eax
80100a62:	29 d0                	sub    %edx,%eax
80100a64:	89 ca                	mov    %ecx,%edx
80100a66:	6b c0 4e             	imul   $0x4e,%eax,%eax
80100a69:	29 c2                	sub    %eax,%edx
80100a6b:	0f b6 82 a0 1b 11 80 	movzbl -0x7feee460(%edx),%eax
80100a72:	88 45 e7             	mov    %al,-0x19(%ebp)
80100a75:	b8 d3 20 0d d2       	mov    $0xd20d20d3,%eax
80100a7a:	f7 eb                	imul   %ebx
80100a7c:	8d 04 1a             	lea    (%edx,%ebx,1),%eax
80100a7f:	89 da                	mov    %ebx,%edx
80100a81:	c1 f8 06             	sar    $0x6,%eax
80100a84:	c1 fa 1f             	sar    $0x1f,%edx
80100a87:	29 d0                	sub    %edx,%eax
80100a89:	6b c0 4e             	imul   $0x4e,%eax,%eax
80100a8c:	29 c3                	sub    %eax,%ebx
80100a8e:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
80100a92:	88 83 a0 1b 11 80    	mov    %al,-0x7feee460(%ebx)
    for (int i = input.e; i < input.w + lineLength - 1; i++)
80100a98:	39 f9                	cmp    %edi,%ecx
80100a9a:	75 af                	jne    80100a4b <BackSpace+0x3b>
  if (panicked)
80100a9c:	a1 d8 c1 10 80       	mov    0x8010c1d8,%eax
    lineLength--;
80100aa1:	83 ee 01             	sub    $0x1,%esi
80100aa4:	89 35 94 c1 10 80    	mov    %esi,0x8010c194
  if (panicked)
80100aaa:	85 c0                	test   %eax,%eax
80100aac:	74 0a                	je     80100ab8 <BackSpace+0xa8>
80100aae:	fa                   	cli    
    for (;;)
80100aaf:	eb fe                	jmp    80100aaf <BackSpace+0x9f>
80100ab1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
}
80100ab8:	83 c4 1c             	add    $0x1c,%esp
80100abb:	b8 00 01 00 00       	mov    $0x100,%eax
80100ac0:	5b                   	pop    %ebx
80100ac1:	5e                   	pop    %esi
80100ac2:	5f                   	pop    %edi
80100ac3:	5d                   	pop    %ebp
80100ac4:	e9 67 fb ff ff       	jmp    80100630 <consputc.part.0>
80100ac9:	c3                   	ret    
80100aca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100ad0 <KillLine>:
{
80100ad0:	f3 0f 1e fb          	endbr32 
80100ad4:	55                   	push   %ebp
80100ad5:	89 e5                	mov    %esp,%ebp
80100ad7:	53                   	push   %ebx
80100ad8:	83 ec 04             	sub    $0x4,%esp
  GoEndLine();
80100adb:	e8 d0 fe ff ff       	call   801009b0 <GoEndLine>
  return input.e - input.w;
80100ae0:	a1 f4 1b 11 80       	mov    0x80111bf4,%eax
80100ae5:	8b 1d f8 1b 11 80    	mov    0x80111bf8,%ebx
80100aeb:	29 c3                	sub    %eax,%ebx
  for (int i = currentIndex(); i > 0; i--)
80100aed:	85 db                	test   %ebx,%ebx
80100aef:	7e 23                	jle    80100b14 <KillLine+0x44>
  if (panicked)
80100af1:	a1 d8 c1 10 80       	mov    0x8010c1d8,%eax
80100af6:	85 c0                	test   %eax,%eax
80100af8:	74 06                	je     80100b00 <KillLine+0x30>
80100afa:	fa                   	cli    
    for (;;)
80100afb:	eb fe                	jmp    80100afb <KillLine+0x2b>
80100afd:	8d 76 00             	lea    0x0(%esi),%esi
80100b00:	b8 00 01 00 00       	mov    $0x100,%eax
80100b05:	e8 26 fb ff ff       	call   80100630 <consputc.part.0>
  for (int i = currentIndex(); i > 0; i--)
80100b0a:	83 eb 01             	sub    $0x1,%ebx
80100b0d:	75 e2                	jne    80100af1 <KillLine+0x21>
80100b0f:	a1 f4 1b 11 80       	mov    0x80111bf4,%eax
  input.e = input.w;
80100b14:	a3 f8 1b 11 80       	mov    %eax,0x80111bf8
  lineLength = 0;
80100b19:	c7 05 94 c1 10 80 00 	movl   $0x0,0x8010c194
80100b20:	00 00 00 
}
80100b23:	83 c4 04             	add    $0x4,%esp
80100b26:	5b                   	pop    %ebx
80100b27:	5d                   	pop    %ebp
80100b28:	c3                   	ret    
80100b29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80100b30 <Change>:
{
80100b30:	f3 0f 1e fb          	endbr32 
80100b34:	55                   	push   %ebp
80100b35:	89 e5                	mov    %esp,%ebp
80100b37:	57                   	push   %edi
80100b38:	56                   	push   %esi
80100b39:	53                   	push   %ebx
80100b3a:	83 ec 0c             	sub    $0xc,%esp
  KillLine();
80100b3d:	e8 8e ff ff ff       	call   80100ad0 <KillLine>
  memset(input.buf, 0, INPUT_BUF * sizeof(input.buf[0]));
80100b42:	83 ec 04             	sub    $0x4,%esp
  lineLength = lineLengths[current];
80100b45:	a1 00 90 10 80       	mov    0x80109000,%eax
  memset(input.buf, 0, INPUT_BUF * sizeof(input.buf[0]));
80100b4a:	6a 4e                	push   $0x4e
80100b4c:	6a 00                	push   $0x0
  lineLength = lineLengths[current];
80100b4e:	8b 04 85 20 b5 10 80 	mov    -0x7fef4ae0(,%eax,4),%eax
  memset(input.buf, 0, INPUT_BUF * sizeof(input.buf[0]));
80100b55:	68 a0 1b 11 80       	push   $0x80111ba0
  lineLength = lineLengths[current];
80100b5a:	a3 94 c1 10 80       	mov    %eax,0x8010c194
  memset(input.buf, 0, INPUT_BUF * sizeof(input.buf[0]));
80100b5f:	e8 2c 42 00 00       	call   80104d90 <memset>
  for (int i = 0; i < lineLength; i++)
80100b64:	a1 94 c1 10 80       	mov    0x8010c194,%eax
80100b69:	83 c4 10             	add    $0x10,%esp
80100b6c:	85 c0                	test   %eax,%eax
80100b6e:	7e 5c                	jle    80100bcc <Change+0x9c>
80100b70:	31 db                	xor    %ebx,%ebx
    consputc(input.buf[(i + input.w) % INPUT_BUF] = commands[current][i]);
80100b72:	be d3 20 0d d2       	mov    $0xd20d20d3,%esi
80100b77:	8b 3d f4 1b 11 80    	mov    0x80111bf4,%edi
80100b7d:	6b 05 00 90 10 80 4e 	imul   $0x4e,0x80109000,%eax
80100b84:	01 df                	add    %ebx,%edi
80100b86:	89 fa                	mov    %edi,%edx
80100b88:	01 d8                	add    %ebx,%eax
80100b8a:	d1 ea                	shr    %edx
80100b8c:	8b 0c 85 60 b5 10 80 	mov    -0x7fef4aa0(,%eax,4),%ecx
80100b93:	89 d0                	mov    %edx,%eax
80100b95:	f7 e6                	mul    %esi
80100b97:	89 d0                	mov    %edx,%eax
80100b99:	c1 e8 05             	shr    $0x5,%eax
80100b9c:	6b c0 4e             	imul   $0x4e,%eax,%eax
80100b9f:	29 c7                	sub    %eax,%edi
  if (panicked)
80100ba1:	a1 d8 c1 10 80       	mov    0x8010c1d8,%eax
    consputc(input.buf[(i + input.w) % INPUT_BUF] = commands[current][i]);
80100ba6:	88 8f a0 1b 11 80    	mov    %cl,-0x7feee460(%edi)
  if (panicked)
80100bac:	85 c0                	test   %eax,%eax
80100bae:	74 08                	je     80100bb8 <Change+0x88>
80100bb0:	fa                   	cli    
    for (;;)
80100bb1:	eb fe                	jmp    80100bb1 <Change+0x81>
80100bb3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100bb7:	90                   	nop
    consputc(input.buf[(i + input.w) % INPUT_BUF] = commands[current][i]);
80100bb8:	0f be c1             	movsbl %cl,%eax
  for (int i = 0; i < lineLength; i++)
80100bbb:	83 c3 01             	add    $0x1,%ebx
80100bbe:	e8 6d fa ff ff       	call   80100630 <consputc.part.0>
80100bc3:	a1 94 c1 10 80       	mov    0x8010c194,%eax
80100bc8:	39 d8                	cmp    %ebx,%eax
80100bca:	7f ab                	jg     80100b77 <Change+0x47>
  input.e = input.w + lineLength;
80100bcc:	03 05 f4 1b 11 80    	add    0x80111bf4,%eax
80100bd2:	a3 f8 1b 11 80       	mov    %eax,0x80111bf8
}
80100bd7:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100bda:	5b                   	pop    %ebx
80100bdb:	5e                   	pop    %esi
80100bdc:	5f                   	pop    %edi
80100bdd:	5d                   	pop    %ebp
80100bde:	c3                   	ret    
80100bdf:	90                   	nop

80100be0 <SubmitCommand>:
{
80100be0:	f3 0f 1e fb          	endbr32 
80100be4:	55                   	push   %ebp
80100be5:	b9 40 f6 ff ff       	mov    $0xfffff640,%ecx
80100bea:	89 e5                	mov    %esp,%ebp
80100bec:	57                   	push   %edi
  for (int i = MAXCOMMANDS - 1; i > 0; i--)
80100bed:	bf 09 00 00 00       	mov    $0x9,%edi
{
80100bf2:	56                   	push   %esi
80100bf3:	be 58 c0 10 80       	mov    $0x8010c058,%esi
80100bf8:	53                   	push   %ebx
80100bf9:	bb f8 0a 00 00       	mov    $0xaf8,%ebx
80100bfe:	83 ec 1c             	sub    $0x1c,%esp
80100c01:	8b 45 08             	mov    0x8(%ebp),%eax
80100c04:	89 45 e0             	mov    %eax,-0x20(%ebp)
80100c07:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100c0e:	66 90                	xchg   %ax,%ax
    for (int j = 0; j < INPUT_BUF; j++)
80100c10:	83 ef 01             	sub    $0x1,%edi
80100c13:	8d 86 c8 fe ff ff    	lea    -0x138(%esi),%eax
80100c19:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80100c1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      commands[i][j] = commands[i - 1][j];
80100c20:	8b 38                	mov    (%eax),%edi
80100c22:	8d 14 08             	lea    (%eax,%ecx,1),%edx
80100c25:	83 c0 04             	add    $0x4,%eax
80100c28:	89 3c 1a             	mov    %edi,(%edx,%ebx,1)
    for (int j = 0; j < INPUT_BUF; j++)
80100c2b:	39 f0                	cmp    %esi,%eax
80100c2d:	75 f1                	jne    80100c20 <SubmitCommand+0x40>
80100c2f:	8b 7d e4             	mov    -0x1c(%ebp),%edi
    lineLengths[i] = lineLengths[i - 1];
80100c32:	81 c1 38 01 00 00    	add    $0x138,%ecx
80100c38:	81 eb 38 01 00 00    	sub    $0x138,%ebx
80100c3e:	8d b0 c8 fe ff ff    	lea    -0x138(%eax),%esi
80100c44:	8b 14 bd 20 b5 10 80 	mov    -0x7fef4ae0(,%edi,4),%edx
80100c4b:	89 14 bd 24 b5 10 80 	mov    %edx,-0x7fef4adc(,%edi,4)
  for (int i = MAXCOMMANDS - 1; i > 0; i--)
80100c52:	85 ff                	test   %edi,%edi
80100c54:	75 ba                	jne    80100c10 <SubmitCommand+0x30>
  memset(commands[0], 0, INPUT_BUF * sizeof(int));
80100c56:	83 ec 04             	sub    $0x4,%esp
80100c59:	68 38 01 00 00       	push   $0x138
80100c5e:	6a 00                	push   $0x0
80100c60:	68 60 b5 10 80       	push   $0x8010b560
80100c65:	e8 26 41 00 00       	call   80104d90 <memset>
  for (int j = 0; j < lineLength; j++)
80100c6a:	a1 94 c1 10 80       	mov    0x8010c194,%eax
80100c6f:	83 c4 10             	add    $0x10,%esp
80100c72:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100c75:	85 c0                	test   %eax,%eax
80100c77:	0f 8e b5 00 00 00    	jle    80100d32 <SubmitCommand+0x152>
    commands[0][j] = input.buf[(j + input.w) % INPUT_BUF];
80100c7d:	8b 0d f4 1b 11 80    	mov    0x80111bf4,%ecx
80100c83:	bf d3 20 0d d2       	mov    $0xd20d20d3,%edi
80100c88:	89 ce                	mov    %ecx,%esi
80100c8a:	8d 1c 08             	lea    (%eax,%ecx,1),%ebx
80100c8d:	f7 de                	neg    %esi
80100c8f:	c1 e6 02             	shl    $0x2,%esi
80100c92:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100c98:	89 ca                	mov    %ecx,%edx
80100c9a:	d1 ea                	shr    %edx
80100c9c:	89 d0                	mov    %edx,%eax
80100c9e:	f7 e7                	mul    %edi
80100ca0:	c1 ea 05             	shr    $0x5,%edx
80100ca3:	6b c2 4e             	imul   $0x4e,%edx,%eax
80100ca6:	89 ca                	mov    %ecx,%edx
80100ca8:	29 c2                	sub    %eax,%edx
80100caa:	0f be 82 a0 1b 11 80 	movsbl -0x7feee460(%edx),%eax
80100cb1:	89 84 8e 60 b5 10 80 	mov    %eax,-0x7fef4aa0(%esi,%ecx,4)
  for (int j = 0; j < lineLength; j++)
80100cb8:	83 c1 01             	add    $0x1,%ecx
80100cbb:	39 d9                	cmp    %ebx,%ecx
80100cbd:	75 d9                	jne    80100c98 <SubmitCommand+0xb8>
  lineLengths[0] = lineLength;
80100cbf:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  input.buf[input.e++ % INPUT_BUF] = c;
80100cc2:	89 da                	mov    %ebx,%edx
80100cc4:	be d3 20 0d d2       	mov    $0xd20d20d3,%esi
80100cc9:	8d 4b 01             	lea    0x1(%ebx),%ecx
80100ccc:	d1 ea                	shr    %edx
  wakeup(&input.r);
80100cce:	c7 45 08 f0 1b 11 80 	movl   $0x80111bf0,0x8(%ebp)
  lineLengths[0] = lineLength;
80100cd5:	a3 20 b5 10 80       	mov    %eax,0x8010b520
  input.buf[input.e++ % INPUT_BUF] = c;
80100cda:	89 d0                	mov    %edx,%eax
80100cdc:	f7 e6                	mul    %esi
80100cde:	89 0d f8 1b 11 80    	mov    %ecx,0x80111bf8
  input.w = input.e;
80100ce4:	89 0d f4 1b 11 80    	mov    %ecx,0x80111bf4
  lineLength = 0;
80100cea:	c7 05 94 c1 10 80 00 	movl   $0x0,0x8010c194
80100cf1:	00 00 00 
  current = -1;
80100cf4:	c7 05 00 90 10 80 ff 	movl   $0xffffffff,0x80109000
80100cfb:	ff ff ff 
  input.buf[input.e++ % INPUT_BUF] = c;
80100cfe:	89 d0                	mov    %edx,%eax
  maxCommands = maxCommands == MAXCOMMANDS ? MAXCOMMANDS : (maxCommands + 1);
80100d00:	31 d2                	xor    %edx,%edx
  input.buf[input.e++ % INPUT_BUF] = c;
80100d02:	c1 e8 05             	shr    $0x5,%eax
80100d05:	6b c0 4e             	imul   $0x4e,%eax,%eax
80100d08:	29 c3                	sub    %eax,%ebx
80100d0a:	0f b6 45 e0          	movzbl -0x20(%ebp),%eax
80100d0e:	88 83 a0 1b 11 80    	mov    %al,-0x7feee460(%ebx)
  maxCommands = maxCommands == MAXCOMMANDS ? MAXCOMMANDS : (maxCommands + 1);
80100d14:	a1 90 c1 10 80       	mov    0x8010c190,%eax
80100d19:	83 f8 0a             	cmp    $0xa,%eax
80100d1c:	0f 95 c2             	setne  %dl
80100d1f:	01 d0                	add    %edx,%eax
80100d21:	a3 90 c1 10 80       	mov    %eax,0x8010c190
}
80100d26:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100d29:	5b                   	pop    %ebx
80100d2a:	5e                   	pop    %esi
80100d2b:	5f                   	pop    %edi
80100d2c:	5d                   	pop    %ebp
  wakeup(&input.r);
80100d2d:	e9 1e 3a 00 00       	jmp    80104750 <wakeup>
80100d32:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80100d35:	03 1d f4 1b 11 80    	add    0x80111bf4,%ebx
80100d3b:	eb 82                	jmp    80100cbf <SubmitCommand+0xdf>
80100d3d:	8d 76 00             	lea    0x0(%esi),%esi

80100d40 <consoleintr>:
{
80100d40:	f3 0f 1e fb          	endbr32 
80100d44:	55                   	push   %ebp
80100d45:	89 e5                	mov    %esp,%ebp
80100d47:	57                   	push   %edi
80100d48:	56                   	push   %esi
  int c, doprocdump = 0;
80100d49:	31 f6                	xor    %esi,%esi
{
80100d4b:	53                   	push   %ebx
80100d4c:	83 ec 28             	sub    $0x28,%esp
80100d4f:	8b 45 08             	mov    0x8(%ebp),%eax
  acquire(&cons.lock);
80100d52:	68 a0 c1 10 80       	push   $0x8010c1a0
{
80100d57:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  acquire(&cons.lock);
80100d5a:	e8 21 3f 00 00       	call   80104c80 <acquire>
  while ((c = getc()) >= 0)
80100d5f:	83 c4 10             	add    $0x10,%esp
80100d62:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100d65:	ff d0                	call   *%eax
80100d67:	89 c3                	mov    %eax,%ebx
80100d69:	85 c0                	test   %eax,%eax
80100d6b:	78 33                	js     80100da0 <consoleintr+0x60>
    switch (c)
80100d6d:	83 fb 15             	cmp    $0x15,%ebx
80100d70:	0f 8f 69 01 00 00    	jg     80100edf <consoleintr+0x19f>
80100d76:	83 fb 01             	cmp    $0x1,%ebx
80100d79:	0f 8e e1 00 00 00    	jle    80100e60 <consoleintr+0x120>
80100d7f:	83 fb 15             	cmp    $0x15,%ebx
80100d82:	0f 87 d8 00 00 00    	ja     80100e60 <consoleintr+0x120>
80100d88:	3e ff 24 9d 70 79 10 	notrack jmp *-0x7fef8690(,%ebx,4)
80100d8f:	80 
  while ((c = getc()) >= 0)
80100d90:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    switch (c)
80100d93:	be 01 00 00 00       	mov    $0x1,%esi
  while ((c = getc()) >= 0)
80100d98:	ff d0                	call   *%eax
80100d9a:	89 c3                	mov    %eax,%ebx
80100d9c:	85 c0                	test   %eax,%eax
80100d9e:	79 cd                	jns    80100d6d <consoleintr+0x2d>
  release(&cons.lock);
80100da0:	83 ec 0c             	sub    $0xc,%esp
80100da3:	68 a0 c1 10 80       	push   $0x8010c1a0
80100da8:	e8 93 3f 00 00       	call   80104d40 <release>
  if (doprocdump)
80100dad:	83 c4 10             	add    $0x10,%esp
80100db0:	85 f6                	test   %esi,%esi
80100db2:	0f 85 d0 01 00 00    	jne    80100f88 <consoleintr+0x248>
}
80100db8:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100dbb:	5b                   	pop    %ebx
80100dbc:	5e                   	pop    %esi
80100dbd:	5f                   	pop    %edi
80100dbe:	5d                   	pop    %ebp
80100dbf:	c3                   	ret    
      input.e = input.w;
80100dc0:	a1 f4 1b 11 80       	mov    0x80111bf4,%eax
  if (panicked)
80100dc5:	8b 0d d8 c1 10 80    	mov    0x8010c1d8,%ecx
      lineLength = 0;
80100dcb:	c7 05 94 c1 10 80 00 	movl   $0x0,0x8010c194
80100dd2:	00 00 00 
      input.e = input.w;
80100dd5:	a3 f8 1b 11 80       	mov    %eax,0x80111bf8
  if (panicked)
80100dda:	85 c9                	test   %ecx,%ecx
80100ddc:	0f 84 6b 01 00 00    	je     80100f4d <consoleintr+0x20d>
80100de2:	fa                   	cli    
    for (;;)
80100de3:	eb fe                	jmp    80100de3 <consoleintr+0xa3>
80100de5:	8d 76 00             	lea    0x0(%esi),%esi
    switch (c)
80100de8:	83 fb 7f             	cmp    $0x7f,%ebx
80100deb:	75 7b                	jne    80100e68 <consoleintr+0x128>
      BackSpace();
80100ded:	e8 1e fc ff ff       	call   80100a10 <BackSpace>
      break;
80100df2:	e9 6b ff ff ff       	jmp    80100d62 <consoleintr+0x22>
  return input.e - input.w;
80100df7:	a1 f8 1b 11 80       	mov    0x80111bf8,%eax
80100dfc:	89 c2                	mov    %eax,%edx
80100dfe:	2b 15 f4 1b 11 80    	sub    0x80111bf4,%edx
      if (currentIndex() < lineLength) //
80100e04:	39 15 94 c1 10 80    	cmp    %edx,0x8010c194
80100e0a:	0f 8e 52 ff ff ff    	jle    80100d62 <consoleintr+0x22>
        input.e++;
80100e10:	83 c0 01             	add    $0x1,%eax
80100e13:	a3 f8 1b 11 80       	mov    %eax,0x80111bf8
  if (panicked)
80100e18:	a1 d8 c1 10 80       	mov    0x8010c1d8,%eax
80100e1d:	85 c0                	test   %eax,%eax
80100e1f:	0f 84 46 01 00 00    	je     80100f6b <consoleintr+0x22b>
80100e25:	fa                   	cli    
    for (;;)
80100e26:	eb fe                	jmp    80100e26 <consoleintr+0xe6>
      GoEndLine();
80100e28:	e8 83 fb ff ff       	call   801009b0 <GoEndLine>
      break;
80100e2d:	e9 30 ff ff ff       	jmp    80100d62 <consoleintr+0x22>
  return input.e - input.w;
80100e32:	a1 f8 1b 11 80       	mov    0x80111bf8,%eax
80100e37:	89 c2                	mov    %eax,%edx
80100e39:	2b 15 f4 1b 11 80    	sub    0x80111bf4,%edx
      if (currentIndex() > 0) //
80100e3f:	85 d2                	test   %edx,%edx
80100e41:	0f 8e 1b ff ff ff    	jle    80100d62 <consoleintr+0x22>
  if (panicked)
80100e47:	8b 15 d8 c1 10 80    	mov    0x8010c1d8,%edx
        input.e--;
80100e4d:	83 e8 01             	sub    $0x1,%eax
80100e50:	a3 f8 1b 11 80       	mov    %eax,0x80111bf8
  if (panicked)
80100e55:	85 d2                	test   %edx,%edx
80100e57:	0f 84 ff 00 00 00    	je     80100f5c <consoleintr+0x21c>
80100e5d:	fa                   	cli    
    for (;;)
80100e5e:	eb fe                	jmp    80100e5e <consoleintr+0x11e>
      if (c != 0 && input.e - input.r < INPUT_BUF)
80100e60:	85 db                	test   %ebx,%ebx
80100e62:	0f 84 fa fe ff ff    	je     80100d62 <consoleintr+0x22>
80100e68:	a1 f8 1b 11 80       	mov    0x80111bf8,%eax
80100e6d:	2b 05 f0 1b 11 80    	sub    0x80111bf0,%eax
80100e73:	83 f8 4d             	cmp    $0x4d,%eax
80100e76:	0f 87 e6 fe ff ff    	ja     80100d62 <consoleintr+0x22>
        c = (c == '\r') ? '\n' : c;
80100e7c:	a1 d8 c1 10 80       	mov    0x8010c1d8,%eax
80100e81:	83 fb 0d             	cmp    $0xd,%ebx
80100e84:	0f 84 f0 00 00 00    	je     80100f7a <consoleintr+0x23a>
  if (panicked)
80100e8a:	85 c0                	test   %eax,%eax
80100e8c:	0f 85 ec 00 00 00    	jne    80100f7e <consoleintr+0x23e>
80100e92:	89 d8                	mov    %ebx,%eax
80100e94:	e8 97 f7 ff ff       	call   80100630 <consputc.part.0>
        int isEnd = input.e == input.r + INPUT_BUF - 2;
80100e99:	a1 f0 1b 11 80       	mov    0x80111bf0,%eax
80100e9e:	8b 3d f8 1b 11 80    	mov    0x80111bf8,%edi
80100ea4:	83 c0 4c             	add    $0x4c,%eax
        if (c == '\n' || c == C('D') || isEnd)
80100ea7:	83 fb 0a             	cmp    $0xa,%ebx
80100eaa:	0f 84 01 01 00 00    	je     80100fb1 <consoleintr+0x271>
80100eb0:	83 fb 04             	cmp    $0x4,%ebx
80100eb3:	0f 84 f8 00 00 00    	je     80100fb1 <consoleintr+0x271>
80100eb9:	39 c7                	cmp    %eax,%edi
80100ebb:	0f 85 09 01 00 00    	jne    80100fca <consoleintr+0x28a>
          SubmitCommand(isEnd ? '\n' : c);
80100ec1:	bb 0a 00 00 00       	mov    $0xa,%ebx
80100ec6:	e9 ee 00 00 00       	jmp    80100fb9 <consoleintr+0x279>
      KillLine();
80100ecb:	e8 00 fc ff ff       	call   80100ad0 <KillLine>
      break;
80100ed0:	e9 8d fe ff ff       	jmp    80100d62 <consoleintr+0x22>
      BackToStart();
80100ed5:	e8 86 fa ff ff       	call   80100960 <BackToStart>
      break;
80100eda:	e9 83 fe ff ff       	jmp    80100d62 <consoleintr+0x22>
    switch (c)
80100edf:	81 fb e2 00 00 00    	cmp    $0xe2,%ebx
80100ee5:	74 2c                	je     80100f13 <consoleintr+0x1d3>
80100ee7:	81 fb e3 00 00 00    	cmp    $0xe3,%ebx
80100eed:	0f 85 f5 fe ff ff    	jne    80100de8 <consoleintr+0xa8>
      if (current > 0)
80100ef3:	a1 00 90 10 80       	mov    0x80109000,%eax
80100ef8:	85 c0                	test   %eax,%eax
80100efa:	7f 3f                	jg     80100f3b <consoleintr+0x1fb>
      else if (current == 0)
80100efc:	0f 85 60 fe ff ff    	jne    80100d62 <consoleintr+0x22>
        KillLine();
80100f02:	e8 c9 fb ff ff       	call   80100ad0 <KillLine>
        current--;
80100f07:	83 2d 00 90 10 80 01 	subl   $0x1,0x80109000
80100f0e:	e9 4f fe ff ff       	jmp    80100d62 <consoleintr+0x22>
      if (current < maxCommands - 1)
80100f13:	8b 0d 90 c1 10 80    	mov    0x8010c190,%ecx
80100f19:	a1 00 90 10 80       	mov    0x80109000,%eax
80100f1e:	8d 51 ff             	lea    -0x1(%ecx),%edx
80100f21:	39 c2                	cmp    %eax,%edx
80100f23:	0f 8e 39 fe ff ff    	jle    80100d62 <consoleintr+0x22>
        current++;
80100f29:	83 c0 01             	add    $0x1,%eax
80100f2c:	a3 00 90 10 80       	mov    %eax,0x80109000
        Change();
80100f31:	e8 fa fb ff ff       	call   80100b30 <Change>
80100f36:	e9 27 fe ff ff       	jmp    80100d62 <consoleintr+0x22>
        current--;
80100f3b:	83 e8 01             	sub    $0x1,%eax
80100f3e:	a3 00 90 10 80       	mov    %eax,0x80109000
        Change();
80100f43:	e8 e8 fb ff ff       	call   80100b30 <Change>
80100f48:	e9 15 fe ff ff       	jmp    80100d62 <consoleintr+0x22>
  cgaputc(c);
80100f4d:	b8 03 01 00 00       	mov    $0x103,%eax
80100f52:	e8 d9 f4 ff ff       	call   80100430 <cgaputc>
}
80100f57:	e9 06 fe ff ff       	jmp    80100d62 <consoleintr+0x22>
  cgaputc(c);
80100f5c:	b8 01 01 00 00       	mov    $0x101,%eax
80100f61:	e8 ca f4 ff ff       	call   80100430 <cgaputc>
}
80100f66:	e9 f7 fd ff ff       	jmp    80100d62 <consoleintr+0x22>
  cgaputc(c);
80100f6b:	b8 02 01 00 00       	mov    $0x102,%eax
80100f70:	e8 bb f4 ff ff       	call   80100430 <cgaputc>
}
80100f75:	e9 e8 fd ff ff       	jmp    80100d62 <consoleintr+0x22>
  if (panicked)
80100f7a:	85 c0                	test   %eax,%eax
80100f7c:	74 16                	je     80100f94 <consoleintr+0x254>
80100f7e:	fa                   	cli    
    for (;;)
80100f7f:	eb fe                	jmp    80100f7f <consoleintr+0x23f>
80100f81:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
}
80100f88:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100f8b:	5b                   	pop    %ebx
80100f8c:	5e                   	pop    %esi
80100f8d:	5f                   	pop    %edi
80100f8e:	5d                   	pop    %ebp
    procdump(); // now call procdump() wo. cons.lock held
80100f8f:	e9 ac 38 00 00       	jmp    80104840 <procdump>
80100f94:	b8 0a 00 00 00       	mov    $0xa,%eax
        c = (c == '\r') ? '\n' : c;
80100f99:	bb 0a 00 00 00       	mov    $0xa,%ebx
80100f9e:	e8 8d f6 ff ff       	call   80100630 <consputc.part.0>
        int isEnd = input.e == input.r + INPUT_BUF - 2;
80100fa3:	a1 f0 1b 11 80       	mov    0x80111bf0,%eax
80100fa8:	8b 3d f8 1b 11 80    	mov    0x80111bf8,%edi
80100fae:	83 c0 4c             	add    $0x4c,%eax
          SubmitCommand(isEnd ? '\n' : c);
80100fb1:	39 c7                	cmp    %eax,%edi
80100fb3:	0f 84 08 ff ff ff    	je     80100ec1 <consoleintr+0x181>
80100fb9:	83 ec 0c             	sub    $0xc,%esp
80100fbc:	53                   	push   %ebx
80100fbd:	e8 1e fc ff ff       	call   80100be0 <SubmitCommand>
80100fc2:	83 c4 10             	add    $0x10,%esp
80100fc5:	e9 98 fd ff ff       	jmp    80100d62 <consoleintr+0x22>
          lineLength++;
80100fca:	a1 94 c1 10 80       	mov    0x8010c194,%eax
80100fcf:	83 c0 01             	add    $0x1,%eax
80100fd2:	a3 94 c1 10 80       	mov    %eax,0x8010c194
          for (int i = input.w + lineLength; i > input.e; i--)
80100fd7:	03 05 f4 1b 11 80    	add    0x80111bf4,%eax
80100fdd:	89 c1                	mov    %eax,%ecx
80100fdf:	39 c7                	cmp    %eax,%edi
80100fe1:	73 57                	jae    8010103a <consoleintr+0x2fa>
80100fe3:	89 75 dc             	mov    %esi,-0x24(%ebp)
            input.buf[i % INPUT_BUF] = input.buf[(i - 1) % INPUT_BUF];
80100fe6:	89 ce                	mov    %ecx,%esi
80100fe8:	b8 d3 20 0d d2       	mov    $0xd20d20d3,%eax
80100fed:	83 e9 01             	sub    $0x1,%ecx
80100ff0:	f7 e9                	imul   %ecx
80100ff2:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
80100ff5:	89 ca                	mov    %ecx,%edx
80100ff7:	c1 fa 1f             	sar    $0x1f,%edx
80100ffa:	c1 f8 06             	sar    $0x6,%eax
80100ffd:	29 d0                	sub    %edx,%eax
80100fff:	89 ca                	mov    %ecx,%edx
80101001:	6b c0 4e             	imul   $0x4e,%eax,%eax
80101004:	29 c2                	sub    %eax,%edx
80101006:	0f b6 82 a0 1b 11 80 	movzbl -0x7feee460(%edx),%eax
8010100d:	88 45 e3             	mov    %al,-0x1d(%ebp)
80101010:	b8 d3 20 0d d2       	mov    $0xd20d20d3,%eax
80101015:	f7 ee                	imul   %esi
80101017:	8d 04 32             	lea    (%edx,%esi,1),%eax
8010101a:	89 f2                	mov    %esi,%edx
8010101c:	c1 f8 06             	sar    $0x6,%eax
8010101f:	c1 fa 1f             	sar    $0x1f,%edx
80101022:	29 d0                	sub    %edx,%eax
80101024:	6b c0 4e             	imul   $0x4e,%eax,%eax
80101027:	29 c6                	sub    %eax,%esi
80101029:	0f b6 45 e3          	movzbl -0x1d(%ebp),%eax
8010102d:	88 86 a0 1b 11 80    	mov    %al,-0x7feee460(%esi)
          for (int i = input.w + lineLength; i > input.e; i--)
80101033:	39 cf                	cmp    %ecx,%edi
80101035:	72 af                	jb     80100fe6 <consoleintr+0x2a6>
80101037:	8b 75 dc             	mov    -0x24(%ebp),%esi
          input.buf[input.e++ % INPUT_BUF] = c;
8010103a:	8d 47 01             	lea    0x1(%edi),%eax
8010103d:	89 fa                	mov    %edi,%edx
8010103f:	a3 f8 1b 11 80       	mov    %eax,0x80111bf8
80101044:	d1 ea                	shr    %edx
80101046:	b8 d3 20 0d d2       	mov    $0xd20d20d3,%eax
8010104b:	f7 e2                	mul    %edx
8010104d:	89 d0                	mov    %edx,%eax
8010104f:	c1 e8 05             	shr    $0x5,%eax
80101052:	6b c0 4e             	imul   $0x4e,%eax,%eax
80101055:	29 c7                	sub    %eax,%edi
80101057:	88 9f a0 1b 11 80    	mov    %bl,-0x7feee460(%edi)
8010105d:	e9 00 fd ff ff       	jmp    80100d62 <consoleintr+0x22>
80101062:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101069:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101070 <consoleinit>:

void consoleinit(void)
{
80101070:	f3 0f 1e fb          	endbr32 
80101074:	55                   	push   %ebp
80101075:	89 e5                	mov    %esp,%ebp
80101077:	83 ec 10             	sub    $0x10,%esp
  initlock(&cons.lock, "console");
8010107a:	68 68 79 10 80       	push   $0x80107968
8010107f:	68 a0 c1 10 80       	push   $0x8010c1a0
80101084:	e8 77 3a 00 00       	call   80104b00 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  ioapicenable(IRQ_KBD, 0);
80101089:	58                   	pop    %eax
8010108a:	5a                   	pop    %edx
8010108b:	6a 00                	push   $0x0
8010108d:	6a 01                	push   $0x1
  devsw[CONSOLE].write = consolewrite;
8010108f:	c7 05 ac 25 11 80 30 	movl   $0x80100730,0x801125ac
80101096:	07 10 80 
  devsw[CONSOLE].read = consoleread;
80101099:	c7 05 a8 25 11 80 90 	movl   $0x80100290,0x801125a8
801010a0:	02 10 80 
  cons.locking = 1;
801010a3:	c7 05 d4 c1 10 80 01 	movl   $0x1,0x8010c1d4
801010aa:	00 00 00 
  ioapicenable(IRQ_KBD, 0);
801010ad:	e8 be 19 00 00       	call   80102a70 <ioapicenable>
}
801010b2:	83 c4 10             	add    $0x10,%esp
801010b5:	c9                   	leave  
801010b6:	c3                   	ret    
801010b7:	66 90                	xchg   %ax,%ax
801010b9:	66 90                	xchg   %ax,%ax
801010bb:	66 90                	xchg   %ax,%ax
801010bd:	66 90                	xchg   %ax,%ax
801010bf:	90                   	nop

801010c0 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
801010c0:	f3 0f 1e fb          	endbr32 
801010c4:	55                   	push   %ebp
801010c5:	89 e5                	mov    %esp,%ebp
801010c7:	57                   	push   %edi
801010c8:	56                   	push   %esi
801010c9:	53                   	push   %ebx
801010ca:	81 ec 0c 01 00 00    	sub    $0x10c,%esp
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
801010d0:	e8 cb 2e 00 00       	call   80103fa0 <myproc>
801010d5:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)

  begin_op();
801010db:	e8 90 22 00 00       	call   80103370 <begin_op>

  if((ip = namei(path)) == 0){
801010e0:	83 ec 0c             	sub    $0xc,%esp
801010e3:	ff 75 08             	pushl  0x8(%ebp)
801010e6:	e8 85 15 00 00       	call   80102670 <namei>
801010eb:	83 c4 10             	add    $0x10,%esp
801010ee:	85 c0                	test   %eax,%eax
801010f0:	0f 84 fe 02 00 00    	je     801013f4 <exec+0x334>
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
801010f6:	83 ec 0c             	sub    $0xc,%esp
801010f9:	89 c3                	mov    %eax,%ebx
801010fb:	50                   	push   %eax
801010fc:	e8 9f 0c 00 00       	call   80101da0 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
80101101:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80101107:	6a 34                	push   $0x34
80101109:	6a 00                	push   $0x0
8010110b:	50                   	push   %eax
8010110c:	53                   	push   %ebx
8010110d:	e8 8e 0f 00 00       	call   801020a0 <readi>
80101112:	83 c4 20             	add    $0x20,%esp
80101115:	83 f8 34             	cmp    $0x34,%eax
80101118:	74 26                	je     80101140 <exec+0x80>

 bad:
  if(pgdir)
    freevm(pgdir);
  if(ip){
    iunlockput(ip);
8010111a:	83 ec 0c             	sub    $0xc,%esp
8010111d:	53                   	push   %ebx
8010111e:	e8 1d 0f 00 00       	call   80102040 <iunlockput>
    end_op();
80101123:	e8 b8 22 00 00       	call   801033e0 <end_op>
80101128:	83 c4 10             	add    $0x10,%esp
  }
  return -1;
8010112b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80101130:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101133:	5b                   	pop    %ebx
80101134:	5e                   	pop    %esi
80101135:	5f                   	pop    %edi
80101136:	5d                   	pop    %ebp
80101137:	c3                   	ret    
80101138:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010113f:	90                   	nop
  if(elf.magic != ELF_MAGIC)
80101140:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80101147:	45 4c 46 
8010114a:	75 ce                	jne    8010111a <exec+0x5a>
  if((pgdir = setupkvm()) == 0)
8010114c:	e8 1f 65 00 00       	call   80107670 <setupkvm>
80101151:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)
80101157:	85 c0                	test   %eax,%eax
80101159:	74 bf                	je     8010111a <exec+0x5a>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
8010115b:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80101162:	00 
80101163:	8b b5 40 ff ff ff    	mov    -0xc0(%ebp),%esi
80101169:	0f 84 a4 02 00 00    	je     80101413 <exec+0x353>
  sz = 0;
8010116f:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
80101176:	00 00 00 
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80101179:	31 ff                	xor    %edi,%edi
8010117b:	e9 86 00 00 00       	jmp    80101206 <exec+0x146>
    if(ph.type != ELF_PROG_LOAD)
80101180:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80101187:	75 6c                	jne    801011f5 <exec+0x135>
    if(ph.memsz < ph.filesz)
80101189:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
8010118f:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80101195:	0f 82 87 00 00 00    	jb     80101222 <exec+0x162>
    if(ph.vaddr + ph.memsz < ph.vaddr)
8010119b:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
801011a1:	72 7f                	jb     80101222 <exec+0x162>
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
801011a3:	83 ec 04             	sub    $0x4,%esp
801011a6:	50                   	push   %eax
801011a7:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
801011ad:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
801011b3:	e8 d8 62 00 00       	call   80107490 <allocuvm>
801011b8:	83 c4 10             	add    $0x10,%esp
801011bb:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
801011c1:	85 c0                	test   %eax,%eax
801011c3:	74 5d                	je     80101222 <exec+0x162>
    if(ph.vaddr % PGSIZE != 0)
801011c5:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
801011cb:	a9 ff 0f 00 00       	test   $0xfff,%eax
801011d0:	75 50                	jne    80101222 <exec+0x162>
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
801011d2:	83 ec 0c             	sub    $0xc,%esp
801011d5:	ff b5 14 ff ff ff    	pushl  -0xec(%ebp)
801011db:	ff b5 08 ff ff ff    	pushl  -0xf8(%ebp)
801011e1:	53                   	push   %ebx
801011e2:	50                   	push   %eax
801011e3:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
801011e9:	e8 d2 61 00 00       	call   801073c0 <loaduvm>
801011ee:	83 c4 20             	add    $0x20,%esp
801011f1:	85 c0                	test   %eax,%eax
801011f3:	78 2d                	js     80101222 <exec+0x162>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
801011f5:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
801011fc:	83 c7 01             	add    $0x1,%edi
801011ff:	83 c6 20             	add    $0x20,%esi
80101202:	39 f8                	cmp    %edi,%eax
80101204:	7e 3a                	jle    80101240 <exec+0x180>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80101206:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
8010120c:	6a 20                	push   $0x20
8010120e:	56                   	push   %esi
8010120f:	50                   	push   %eax
80101210:	53                   	push   %ebx
80101211:	e8 8a 0e 00 00       	call   801020a0 <readi>
80101216:	83 c4 10             	add    $0x10,%esp
80101219:	83 f8 20             	cmp    $0x20,%eax
8010121c:	0f 84 5e ff ff ff    	je     80101180 <exec+0xc0>
    freevm(pgdir);
80101222:	83 ec 0c             	sub    $0xc,%esp
80101225:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
8010122b:	e8 c0 63 00 00       	call   801075f0 <freevm>
  if(ip){
80101230:	83 c4 10             	add    $0x10,%esp
80101233:	e9 e2 fe ff ff       	jmp    8010111a <exec+0x5a>
80101238:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010123f:	90                   	nop
80101240:	8b bd f0 fe ff ff    	mov    -0x110(%ebp),%edi
80101246:	81 c7 ff 0f 00 00    	add    $0xfff,%edi
8010124c:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
80101252:	8d b7 00 20 00 00    	lea    0x2000(%edi),%esi
  iunlockput(ip);
80101258:	83 ec 0c             	sub    $0xc,%esp
8010125b:	53                   	push   %ebx
8010125c:	e8 df 0d 00 00       	call   80102040 <iunlockput>
  end_op();
80101261:	e8 7a 21 00 00       	call   801033e0 <end_op>
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80101266:	83 c4 0c             	add    $0xc,%esp
80101269:	56                   	push   %esi
8010126a:	57                   	push   %edi
8010126b:	8b bd f4 fe ff ff    	mov    -0x10c(%ebp),%edi
80101271:	57                   	push   %edi
80101272:	e8 19 62 00 00       	call   80107490 <allocuvm>
80101277:	83 c4 10             	add    $0x10,%esp
8010127a:	89 c6                	mov    %eax,%esi
8010127c:	85 c0                	test   %eax,%eax
8010127e:	0f 84 94 00 00 00    	je     80101318 <exec+0x258>
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80101284:	83 ec 08             	sub    $0x8,%esp
80101287:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
  for(argc = 0; argv[argc]; argc++) {
8010128d:	89 f3                	mov    %esi,%ebx
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
8010128f:	50                   	push   %eax
80101290:	57                   	push   %edi
  for(argc = 0; argv[argc]; argc++) {
80101291:	31 ff                	xor    %edi,%edi
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80101293:	e8 78 64 00 00       	call   80107710 <clearpteu>
  for(argc = 0; argv[argc]; argc++) {
80101298:	8b 45 0c             	mov    0xc(%ebp),%eax
8010129b:	83 c4 10             	add    $0x10,%esp
8010129e:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
801012a4:	8b 00                	mov    (%eax),%eax
801012a6:	85 c0                	test   %eax,%eax
801012a8:	0f 84 8b 00 00 00    	je     80101339 <exec+0x279>
801012ae:	89 b5 f0 fe ff ff    	mov    %esi,-0x110(%ebp)
801012b4:	8b b5 f4 fe ff ff    	mov    -0x10c(%ebp),%esi
801012ba:	eb 23                	jmp    801012df <exec+0x21f>
801012bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801012c0:	8b 45 0c             	mov    0xc(%ebp),%eax
    ustack[3+argc] = sp;
801012c3:	89 9c bd 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%edi,4)
  for(argc = 0; argv[argc]; argc++) {
801012ca:	83 c7 01             	add    $0x1,%edi
    ustack[3+argc] = sp;
801012cd:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
  for(argc = 0; argv[argc]; argc++) {
801012d3:	8b 04 b8             	mov    (%eax,%edi,4),%eax
801012d6:	85 c0                	test   %eax,%eax
801012d8:	74 59                	je     80101333 <exec+0x273>
    if(argc >= MAXARG)
801012da:	83 ff 20             	cmp    $0x20,%edi
801012dd:	74 39                	je     80101318 <exec+0x258>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
801012df:	83 ec 0c             	sub    $0xc,%esp
801012e2:	50                   	push   %eax
801012e3:	e8 a8 3c 00 00       	call   80104f90 <strlen>
801012e8:	f7 d0                	not    %eax
801012ea:	01 c3                	add    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
801012ec:	58                   	pop    %eax
801012ed:	8b 45 0c             	mov    0xc(%ebp),%eax
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
801012f0:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
801012f3:	ff 34 b8             	pushl  (%eax,%edi,4)
801012f6:	e8 95 3c 00 00       	call   80104f90 <strlen>
801012fb:	83 c0 01             	add    $0x1,%eax
801012fe:	50                   	push   %eax
801012ff:	8b 45 0c             	mov    0xc(%ebp),%eax
80101302:	ff 34 b8             	pushl  (%eax,%edi,4)
80101305:	53                   	push   %ebx
80101306:	56                   	push   %esi
80101307:	e8 64 65 00 00       	call   80107870 <copyout>
8010130c:	83 c4 20             	add    $0x20,%esp
8010130f:	85 c0                	test   %eax,%eax
80101311:	79 ad                	jns    801012c0 <exec+0x200>
80101313:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101317:	90                   	nop
    freevm(pgdir);
80101318:	83 ec 0c             	sub    $0xc,%esp
8010131b:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80101321:	e8 ca 62 00 00       	call   801075f0 <freevm>
80101326:	83 c4 10             	add    $0x10,%esp
  return -1;
80101329:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010132e:	e9 fd fd ff ff       	jmp    80101130 <exec+0x70>
80101333:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80101339:	8d 04 bd 04 00 00 00 	lea    0x4(,%edi,4),%eax
80101340:	89 d9                	mov    %ebx,%ecx
  ustack[3+argc] = 0;
80101342:	c7 84 bd 64 ff ff ff 	movl   $0x0,-0x9c(%ebp,%edi,4)
80101349:	00 00 00 00 
  ustack[2] = sp - (argc+1)*4;  // argv pointer
8010134d:	29 c1                	sub    %eax,%ecx
  sp -= (3+argc+1) * 4;
8010134f:	83 c0 0c             	add    $0xc,%eax
  ustack[1] = argc;
80101352:	89 bd 5c ff ff ff    	mov    %edi,-0xa4(%ebp)
  sp -= (3+argc+1) * 4;
80101358:	29 c3                	sub    %eax,%ebx
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
8010135a:	50                   	push   %eax
8010135b:	52                   	push   %edx
8010135c:	53                   	push   %ebx
8010135d:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
  ustack[0] = 0xffffffff;  // fake return PC
80101363:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
8010136a:	ff ff ff 
  ustack[2] = sp - (argc+1)*4;  // argv pointer
8010136d:	89 8d 60 ff ff ff    	mov    %ecx,-0xa0(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80101373:	e8 f8 64 00 00       	call   80107870 <copyout>
80101378:	83 c4 10             	add    $0x10,%esp
8010137b:	85 c0                	test   %eax,%eax
8010137d:	78 99                	js     80101318 <exec+0x258>
  for(last=s=path; *s; s++)
8010137f:	8b 45 08             	mov    0x8(%ebp),%eax
80101382:	8b 55 08             	mov    0x8(%ebp),%edx
80101385:	0f b6 00             	movzbl (%eax),%eax
80101388:	84 c0                	test   %al,%al
8010138a:	74 13                	je     8010139f <exec+0x2df>
8010138c:	89 d1                	mov    %edx,%ecx
8010138e:	66 90                	xchg   %ax,%ax
    if(*s == '/')
80101390:	83 c1 01             	add    $0x1,%ecx
80101393:	3c 2f                	cmp    $0x2f,%al
  for(last=s=path; *s; s++)
80101395:	0f b6 01             	movzbl (%ecx),%eax
    if(*s == '/')
80101398:	0f 44 d1             	cmove  %ecx,%edx
  for(last=s=path; *s; s++)
8010139b:	84 c0                	test   %al,%al
8010139d:	75 f1                	jne    80101390 <exec+0x2d0>
  safestrcpy(curproc->name, last, sizeof(curproc->name));
8010139f:	8b bd ec fe ff ff    	mov    -0x114(%ebp),%edi
801013a5:	83 ec 04             	sub    $0x4,%esp
801013a8:	6a 10                	push   $0x10
801013aa:	89 f8                	mov    %edi,%eax
801013ac:	52                   	push   %edx
801013ad:	83 c0 70             	add    $0x70,%eax
801013b0:	50                   	push   %eax
801013b1:	e8 9a 3b 00 00       	call   80104f50 <safestrcpy>
  curproc->pgdir = pgdir;
801013b6:	8b 8d f4 fe ff ff    	mov    -0x10c(%ebp),%ecx
  oldpgdir = curproc->pgdir;
801013bc:	89 f8                	mov    %edi,%eax
801013be:	8b 7f 04             	mov    0x4(%edi),%edi
  curproc->sz = sz;
801013c1:	89 30                	mov    %esi,(%eax)
  curproc->pgdir = pgdir;
801013c3:	89 48 04             	mov    %ecx,0x4(%eax)
  curproc->tf->eip = elf.entry;  // main
801013c6:	89 c1                	mov    %eax,%ecx
801013c8:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
801013ce:	8b 40 18             	mov    0x18(%eax),%eax
801013d1:	89 50 38             	mov    %edx,0x38(%eax)
  curproc->tf->esp = sp;
801013d4:	8b 41 18             	mov    0x18(%ecx),%eax
801013d7:	89 58 44             	mov    %ebx,0x44(%eax)
  switchuvm(curproc);
801013da:	89 0c 24             	mov    %ecx,(%esp)
801013dd:	e8 4e 5e 00 00       	call   80107230 <switchuvm>
  freevm(oldpgdir);
801013e2:	89 3c 24             	mov    %edi,(%esp)
801013e5:	e8 06 62 00 00       	call   801075f0 <freevm>
  return 0;
801013ea:	83 c4 10             	add    $0x10,%esp
801013ed:	31 c0                	xor    %eax,%eax
801013ef:	e9 3c fd ff ff       	jmp    80101130 <exec+0x70>
    end_op();
801013f4:	e8 e7 1f 00 00       	call   801033e0 <end_op>
    cprintf("exec: fail\n");
801013f9:	83 ec 0c             	sub    $0xc,%esp
801013fc:	68 d9 79 10 80       	push   $0x801079d9
80101401:	e8 9a f3 ff ff       	call   801007a0 <cprintf>
    return -1;
80101406:	83 c4 10             	add    $0x10,%esp
80101409:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010140e:	e9 1d fd ff ff       	jmp    80101130 <exec+0x70>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80101413:	31 ff                	xor    %edi,%edi
80101415:	be 00 20 00 00       	mov    $0x2000,%esi
8010141a:	e9 39 fe ff ff       	jmp    80101258 <exec+0x198>
8010141f:	90                   	nop

80101420 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80101420:	f3 0f 1e fb          	endbr32 
80101424:	55                   	push   %ebp
80101425:	89 e5                	mov    %esp,%ebp
80101427:	83 ec 10             	sub    $0x10,%esp
  initlock(&ftable.lock, "ftable");
8010142a:	68 e5 79 10 80       	push   $0x801079e5
8010142f:	68 00 1c 11 80       	push   $0x80111c00
80101434:	e8 c7 36 00 00       	call   80104b00 <initlock>
}
80101439:	83 c4 10             	add    $0x10,%esp
8010143c:	c9                   	leave  
8010143d:	c3                   	ret    
8010143e:	66 90                	xchg   %ax,%ax

80101440 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80101440:	f3 0f 1e fb          	endbr32 
80101444:	55                   	push   %ebp
80101445:	89 e5                	mov    %esp,%ebp
80101447:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80101448:	bb 34 1c 11 80       	mov    $0x80111c34,%ebx
{
8010144d:	83 ec 10             	sub    $0x10,%esp
  acquire(&ftable.lock);
80101450:	68 00 1c 11 80       	push   $0x80111c00
80101455:	e8 26 38 00 00       	call   80104c80 <acquire>
8010145a:	83 c4 10             	add    $0x10,%esp
8010145d:	eb 0c                	jmp    8010146b <filealloc+0x2b>
8010145f:	90                   	nop
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80101460:	83 c3 18             	add    $0x18,%ebx
80101463:	81 fb 94 25 11 80    	cmp    $0x80112594,%ebx
80101469:	74 25                	je     80101490 <filealloc+0x50>
    if(f->ref == 0){
8010146b:	8b 43 04             	mov    0x4(%ebx),%eax
8010146e:	85 c0                	test   %eax,%eax
80101470:	75 ee                	jne    80101460 <filealloc+0x20>
      f->ref = 1;
      release(&ftable.lock);
80101472:	83 ec 0c             	sub    $0xc,%esp
      f->ref = 1;
80101475:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
8010147c:	68 00 1c 11 80       	push   $0x80111c00
80101481:	e8 ba 38 00 00       	call   80104d40 <release>
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
}
80101486:	89 d8                	mov    %ebx,%eax
      return f;
80101488:	83 c4 10             	add    $0x10,%esp
}
8010148b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010148e:	c9                   	leave  
8010148f:	c3                   	ret    
  release(&ftable.lock);
80101490:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80101493:	31 db                	xor    %ebx,%ebx
  release(&ftable.lock);
80101495:	68 00 1c 11 80       	push   $0x80111c00
8010149a:	e8 a1 38 00 00       	call   80104d40 <release>
}
8010149f:	89 d8                	mov    %ebx,%eax
  return 0;
801014a1:	83 c4 10             	add    $0x10,%esp
}
801014a4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801014a7:	c9                   	leave  
801014a8:	c3                   	ret    
801014a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801014b0 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
801014b0:	f3 0f 1e fb          	endbr32 
801014b4:	55                   	push   %ebp
801014b5:	89 e5                	mov    %esp,%ebp
801014b7:	53                   	push   %ebx
801014b8:	83 ec 10             	sub    $0x10,%esp
801014bb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
801014be:	68 00 1c 11 80       	push   $0x80111c00
801014c3:	e8 b8 37 00 00       	call   80104c80 <acquire>
  if(f->ref < 1)
801014c8:	8b 43 04             	mov    0x4(%ebx),%eax
801014cb:	83 c4 10             	add    $0x10,%esp
801014ce:	85 c0                	test   %eax,%eax
801014d0:	7e 1a                	jle    801014ec <filedup+0x3c>
    panic("filedup");
  f->ref++;
801014d2:	83 c0 01             	add    $0x1,%eax
  release(&ftable.lock);
801014d5:	83 ec 0c             	sub    $0xc,%esp
  f->ref++;
801014d8:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
801014db:	68 00 1c 11 80       	push   $0x80111c00
801014e0:	e8 5b 38 00 00       	call   80104d40 <release>
  return f;
}
801014e5:	89 d8                	mov    %ebx,%eax
801014e7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801014ea:	c9                   	leave  
801014eb:	c3                   	ret    
    panic("filedup");
801014ec:	83 ec 0c             	sub    $0xc,%esp
801014ef:	68 ec 79 10 80       	push   $0x801079ec
801014f4:	e8 b7 ee ff ff       	call   801003b0 <panic>
801014f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101500 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80101500:	f3 0f 1e fb          	endbr32 
80101504:	55                   	push   %ebp
80101505:	89 e5                	mov    %esp,%ebp
80101507:	57                   	push   %edi
80101508:	56                   	push   %esi
80101509:	53                   	push   %ebx
8010150a:	83 ec 28             	sub    $0x28,%esp
8010150d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct file ff;

  acquire(&ftable.lock);
80101510:	68 00 1c 11 80       	push   $0x80111c00
80101515:	e8 66 37 00 00       	call   80104c80 <acquire>
  if(f->ref < 1)
8010151a:	8b 53 04             	mov    0x4(%ebx),%edx
8010151d:	83 c4 10             	add    $0x10,%esp
80101520:	85 d2                	test   %edx,%edx
80101522:	0f 8e a1 00 00 00    	jle    801015c9 <fileclose+0xc9>
    panic("fileclose");
  if(--f->ref > 0){
80101528:	83 ea 01             	sub    $0x1,%edx
8010152b:	89 53 04             	mov    %edx,0x4(%ebx)
8010152e:	75 40                	jne    80101570 <fileclose+0x70>
    release(&ftable.lock);
    return;
  }
  ff = *f;
80101530:	0f b6 43 09          	movzbl 0x9(%ebx),%eax
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
80101534:	83 ec 0c             	sub    $0xc,%esp
  ff = *f;
80101537:	8b 3b                	mov    (%ebx),%edi
  f->type = FD_NONE;
80101539:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  ff = *f;
8010153f:	8b 73 0c             	mov    0xc(%ebx),%esi
80101542:	88 45 e7             	mov    %al,-0x19(%ebp)
80101545:	8b 43 10             	mov    0x10(%ebx),%eax
  release(&ftable.lock);
80101548:	68 00 1c 11 80       	push   $0x80111c00
  ff = *f;
8010154d:	89 45 e0             	mov    %eax,-0x20(%ebp)
  release(&ftable.lock);
80101550:	e8 eb 37 00 00       	call   80104d40 <release>

  if(ff.type == FD_PIPE)
80101555:	83 c4 10             	add    $0x10,%esp
80101558:	83 ff 01             	cmp    $0x1,%edi
8010155b:	74 53                	je     801015b0 <fileclose+0xb0>
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
8010155d:	83 ff 02             	cmp    $0x2,%edi
80101560:	74 26                	je     80101588 <fileclose+0x88>
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80101562:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101565:	5b                   	pop    %ebx
80101566:	5e                   	pop    %esi
80101567:	5f                   	pop    %edi
80101568:	5d                   	pop    %ebp
80101569:	c3                   	ret    
8010156a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    release(&ftable.lock);
80101570:	c7 45 08 00 1c 11 80 	movl   $0x80111c00,0x8(%ebp)
}
80101577:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010157a:	5b                   	pop    %ebx
8010157b:	5e                   	pop    %esi
8010157c:	5f                   	pop    %edi
8010157d:	5d                   	pop    %ebp
    release(&ftable.lock);
8010157e:	e9 bd 37 00 00       	jmp    80104d40 <release>
80101583:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101587:	90                   	nop
    begin_op();
80101588:	e8 e3 1d 00 00       	call   80103370 <begin_op>
    iput(ff.ip);
8010158d:	83 ec 0c             	sub    $0xc,%esp
80101590:	ff 75 e0             	pushl  -0x20(%ebp)
80101593:	e8 38 09 00 00       	call   80101ed0 <iput>
    end_op();
80101598:	83 c4 10             	add    $0x10,%esp
}
8010159b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010159e:	5b                   	pop    %ebx
8010159f:	5e                   	pop    %esi
801015a0:	5f                   	pop    %edi
801015a1:	5d                   	pop    %ebp
    end_op();
801015a2:	e9 39 1e 00 00       	jmp    801033e0 <end_op>
801015a7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801015ae:	66 90                	xchg   %ax,%ax
    pipeclose(ff.pipe, ff.writable);
801015b0:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
801015b4:	83 ec 08             	sub    $0x8,%esp
801015b7:	53                   	push   %ebx
801015b8:	56                   	push   %esi
801015b9:	e8 82 25 00 00       	call   80103b40 <pipeclose>
801015be:	83 c4 10             	add    $0x10,%esp
}
801015c1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801015c4:	5b                   	pop    %ebx
801015c5:	5e                   	pop    %esi
801015c6:	5f                   	pop    %edi
801015c7:	5d                   	pop    %ebp
801015c8:	c3                   	ret    
    panic("fileclose");
801015c9:	83 ec 0c             	sub    $0xc,%esp
801015cc:	68 f4 79 10 80       	push   $0x801079f4
801015d1:	e8 da ed ff ff       	call   801003b0 <panic>
801015d6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801015dd:	8d 76 00             	lea    0x0(%esi),%esi

801015e0 <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
801015e0:	f3 0f 1e fb          	endbr32 
801015e4:	55                   	push   %ebp
801015e5:	89 e5                	mov    %esp,%ebp
801015e7:	53                   	push   %ebx
801015e8:	83 ec 04             	sub    $0x4,%esp
801015eb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
801015ee:	83 3b 02             	cmpl   $0x2,(%ebx)
801015f1:	75 2d                	jne    80101620 <filestat+0x40>
    ilock(f->ip);
801015f3:	83 ec 0c             	sub    $0xc,%esp
801015f6:	ff 73 10             	pushl  0x10(%ebx)
801015f9:	e8 a2 07 00 00       	call   80101da0 <ilock>
    stati(f->ip, st);
801015fe:	58                   	pop    %eax
801015ff:	5a                   	pop    %edx
80101600:	ff 75 0c             	pushl  0xc(%ebp)
80101603:	ff 73 10             	pushl  0x10(%ebx)
80101606:	e8 65 0a 00 00       	call   80102070 <stati>
    iunlock(f->ip);
8010160b:	59                   	pop    %ecx
8010160c:	ff 73 10             	pushl  0x10(%ebx)
8010160f:	e8 6c 08 00 00       	call   80101e80 <iunlock>
    return 0;
  }
  return -1;
}
80101614:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return 0;
80101617:	83 c4 10             	add    $0x10,%esp
8010161a:	31 c0                	xor    %eax,%eax
}
8010161c:	c9                   	leave  
8010161d:	c3                   	ret    
8010161e:	66 90                	xchg   %ax,%ax
80101620:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return -1;
80101623:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80101628:	c9                   	leave  
80101629:	c3                   	ret    
8010162a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101630 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80101630:	f3 0f 1e fb          	endbr32 
80101634:	55                   	push   %ebp
80101635:	89 e5                	mov    %esp,%ebp
80101637:	57                   	push   %edi
80101638:	56                   	push   %esi
80101639:	53                   	push   %ebx
8010163a:	83 ec 0c             	sub    $0xc,%esp
8010163d:	8b 5d 08             	mov    0x8(%ebp),%ebx
80101640:	8b 75 0c             	mov    0xc(%ebp),%esi
80101643:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
80101646:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
8010164a:	74 64                	je     801016b0 <fileread+0x80>
    return -1;
  if(f->type == FD_PIPE)
8010164c:	8b 03                	mov    (%ebx),%eax
8010164e:	83 f8 01             	cmp    $0x1,%eax
80101651:	74 45                	je     80101698 <fileread+0x68>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
80101653:	83 f8 02             	cmp    $0x2,%eax
80101656:	75 5f                	jne    801016b7 <fileread+0x87>
    ilock(f->ip);
80101658:	83 ec 0c             	sub    $0xc,%esp
8010165b:	ff 73 10             	pushl  0x10(%ebx)
8010165e:	e8 3d 07 00 00       	call   80101da0 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
80101663:	57                   	push   %edi
80101664:	ff 73 14             	pushl  0x14(%ebx)
80101667:	56                   	push   %esi
80101668:	ff 73 10             	pushl  0x10(%ebx)
8010166b:	e8 30 0a 00 00       	call   801020a0 <readi>
80101670:	83 c4 20             	add    $0x20,%esp
80101673:	89 c6                	mov    %eax,%esi
80101675:	85 c0                	test   %eax,%eax
80101677:	7e 03                	jle    8010167c <fileread+0x4c>
      f->off += r;
80101679:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
8010167c:	83 ec 0c             	sub    $0xc,%esp
8010167f:	ff 73 10             	pushl  0x10(%ebx)
80101682:	e8 f9 07 00 00       	call   80101e80 <iunlock>
    return r;
80101687:	83 c4 10             	add    $0x10,%esp
  }
  panic("fileread");
}
8010168a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010168d:	89 f0                	mov    %esi,%eax
8010168f:	5b                   	pop    %ebx
80101690:	5e                   	pop    %esi
80101691:	5f                   	pop    %edi
80101692:	5d                   	pop    %ebp
80101693:	c3                   	ret    
80101694:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return piperead(f->pipe, addr, n);
80101698:	8b 43 0c             	mov    0xc(%ebx),%eax
8010169b:	89 45 08             	mov    %eax,0x8(%ebp)
}
8010169e:	8d 65 f4             	lea    -0xc(%ebp),%esp
801016a1:	5b                   	pop    %ebx
801016a2:	5e                   	pop    %esi
801016a3:	5f                   	pop    %edi
801016a4:	5d                   	pop    %ebp
    return piperead(f->pipe, addr, n);
801016a5:	e9 36 26 00 00       	jmp    80103ce0 <piperead>
801016aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
801016b0:	be ff ff ff ff       	mov    $0xffffffff,%esi
801016b5:	eb d3                	jmp    8010168a <fileread+0x5a>
  panic("fileread");
801016b7:	83 ec 0c             	sub    $0xc,%esp
801016ba:	68 fe 79 10 80       	push   $0x801079fe
801016bf:	e8 ec ec ff ff       	call   801003b0 <panic>
801016c4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801016cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801016cf:	90                   	nop

801016d0 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
801016d0:	f3 0f 1e fb          	endbr32 
801016d4:	55                   	push   %ebp
801016d5:	89 e5                	mov    %esp,%ebp
801016d7:	57                   	push   %edi
801016d8:	56                   	push   %esi
801016d9:	53                   	push   %ebx
801016da:	83 ec 1c             	sub    $0x1c,%esp
801016dd:	8b 45 0c             	mov    0xc(%ebp),%eax
801016e0:	8b 75 08             	mov    0x8(%ebp),%esi
801016e3:	89 45 dc             	mov    %eax,-0x24(%ebp)
801016e6:	8b 45 10             	mov    0x10(%ebp),%eax
  int r;

  if(f->writable == 0)
801016e9:	80 7e 09 00          	cmpb   $0x0,0x9(%esi)
{
801016ed:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(f->writable == 0)
801016f0:	0f 84 c1 00 00 00    	je     801017b7 <filewrite+0xe7>
    return -1;
  if(f->type == FD_PIPE)
801016f6:	8b 06                	mov    (%esi),%eax
801016f8:	83 f8 01             	cmp    $0x1,%eax
801016fb:	0f 84 c3 00 00 00    	je     801017c4 <filewrite+0xf4>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
80101701:	83 f8 02             	cmp    $0x2,%eax
80101704:	0f 85 cc 00 00 00    	jne    801017d6 <filewrite+0x106>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
8010170a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    int i = 0;
8010170d:	31 ff                	xor    %edi,%edi
    while(i < n){
8010170f:	85 c0                	test   %eax,%eax
80101711:	7f 34                	jg     80101747 <filewrite+0x77>
80101713:	e9 98 00 00 00       	jmp    801017b0 <filewrite+0xe0>
80101718:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010171f:	90                   	nop
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
80101720:	01 46 14             	add    %eax,0x14(%esi)
      iunlock(f->ip);
80101723:	83 ec 0c             	sub    $0xc,%esp
80101726:	ff 76 10             	pushl  0x10(%esi)
        f->off += r;
80101729:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
8010172c:	e8 4f 07 00 00       	call   80101e80 <iunlock>
      end_op();
80101731:	e8 aa 1c 00 00       	call   801033e0 <end_op>

      if(r < 0)
        break;
      if(r != n1)
80101736:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101739:	83 c4 10             	add    $0x10,%esp
8010173c:	39 c3                	cmp    %eax,%ebx
8010173e:	75 60                	jne    801017a0 <filewrite+0xd0>
        panic("short filewrite");
      i += r;
80101740:	01 df                	add    %ebx,%edi
    while(i < n){
80101742:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101745:	7e 69                	jle    801017b0 <filewrite+0xe0>
      int n1 = n - i;
80101747:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
8010174a:	b8 00 06 00 00       	mov    $0x600,%eax
8010174f:	29 fb                	sub    %edi,%ebx
      if(n1 > max)
80101751:	81 fb 00 06 00 00    	cmp    $0x600,%ebx
80101757:	0f 4f d8             	cmovg  %eax,%ebx
      begin_op();
8010175a:	e8 11 1c 00 00       	call   80103370 <begin_op>
      ilock(f->ip);
8010175f:	83 ec 0c             	sub    $0xc,%esp
80101762:	ff 76 10             	pushl  0x10(%esi)
80101765:	e8 36 06 00 00       	call   80101da0 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
8010176a:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010176d:	53                   	push   %ebx
8010176e:	ff 76 14             	pushl  0x14(%esi)
80101771:	01 f8                	add    %edi,%eax
80101773:	50                   	push   %eax
80101774:	ff 76 10             	pushl  0x10(%esi)
80101777:	e8 24 0a 00 00       	call   801021a0 <writei>
8010177c:	83 c4 20             	add    $0x20,%esp
8010177f:	85 c0                	test   %eax,%eax
80101781:	7f 9d                	jg     80101720 <filewrite+0x50>
      iunlock(f->ip);
80101783:	83 ec 0c             	sub    $0xc,%esp
80101786:	ff 76 10             	pushl  0x10(%esi)
80101789:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010178c:	e8 ef 06 00 00       	call   80101e80 <iunlock>
      end_op();
80101791:	e8 4a 1c 00 00       	call   801033e0 <end_op>
      if(r < 0)
80101796:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101799:	83 c4 10             	add    $0x10,%esp
8010179c:	85 c0                	test   %eax,%eax
8010179e:	75 17                	jne    801017b7 <filewrite+0xe7>
        panic("short filewrite");
801017a0:	83 ec 0c             	sub    $0xc,%esp
801017a3:	68 07 7a 10 80       	push   $0x80107a07
801017a8:	e8 03 ec ff ff       	call   801003b0 <panic>
801017ad:	8d 76 00             	lea    0x0(%esi),%esi
    }
    return i == n ? n : -1;
801017b0:	89 f8                	mov    %edi,%eax
801017b2:	3b 7d e4             	cmp    -0x1c(%ebp),%edi
801017b5:	74 05                	je     801017bc <filewrite+0xec>
801017b7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  panic("filewrite");
}
801017bc:	8d 65 f4             	lea    -0xc(%ebp),%esp
801017bf:	5b                   	pop    %ebx
801017c0:	5e                   	pop    %esi
801017c1:	5f                   	pop    %edi
801017c2:	5d                   	pop    %ebp
801017c3:	c3                   	ret    
    return pipewrite(f->pipe, addr, n);
801017c4:	8b 46 0c             	mov    0xc(%esi),%eax
801017c7:	89 45 08             	mov    %eax,0x8(%ebp)
}
801017ca:	8d 65 f4             	lea    -0xc(%ebp),%esp
801017cd:	5b                   	pop    %ebx
801017ce:	5e                   	pop    %esi
801017cf:	5f                   	pop    %edi
801017d0:	5d                   	pop    %ebp
    return pipewrite(f->pipe, addr, n);
801017d1:	e9 0a 24 00 00       	jmp    80103be0 <pipewrite>
  panic("filewrite");
801017d6:	83 ec 0c             	sub    $0xc,%esp
801017d9:	68 0d 7a 10 80       	push   $0x80107a0d
801017de:	e8 cd eb ff ff       	call   801003b0 <panic>
801017e3:	66 90                	xchg   %ax,%ax
801017e5:	66 90                	xchg   %ax,%ax
801017e7:	66 90                	xchg   %ax,%ax
801017e9:	66 90                	xchg   %ax,%ax
801017eb:	66 90                	xchg   %ax,%ax
801017ed:	66 90                	xchg   %ax,%ax
801017ef:	90                   	nop

801017f0 <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
801017f0:	55                   	push   %ebp
801017f1:	89 c1                	mov    %eax,%ecx
  struct buf *bp;
  int bi, m;

  bp = bread(dev, BBLOCK(b, sb));
801017f3:	89 d0                	mov    %edx,%eax
801017f5:	c1 e8 0c             	shr    $0xc,%eax
801017f8:	03 05 18 26 11 80    	add    0x80112618,%eax
{
801017fe:	89 e5                	mov    %esp,%ebp
80101800:	56                   	push   %esi
80101801:	53                   	push   %ebx
80101802:	89 d3                	mov    %edx,%ebx
  bp = bread(dev, BBLOCK(b, sb));
80101804:	83 ec 08             	sub    $0x8,%esp
80101807:	50                   	push   %eax
80101808:	51                   	push   %ecx
80101809:	e8 c2 e8 ff ff       	call   801000d0 <bread>
  bi = b % BPB;
  m = 1 << (bi % 8);
8010180e:	89 d9                	mov    %ebx,%ecx
  if((bp->data[bi/8] & m) == 0)
80101810:	c1 fb 03             	sar    $0x3,%ebx
  m = 1 << (bi % 8);
80101813:	ba 01 00 00 00       	mov    $0x1,%edx
80101818:	83 e1 07             	and    $0x7,%ecx
  if((bp->data[bi/8] & m) == 0)
8010181b:	81 e3 ff 01 00 00    	and    $0x1ff,%ebx
80101821:	83 c4 10             	add    $0x10,%esp
  m = 1 << (bi % 8);
80101824:	d3 e2                	shl    %cl,%edx
  if((bp->data[bi/8] & m) == 0)
80101826:	0f b6 4c 18 5c       	movzbl 0x5c(%eax,%ebx,1),%ecx
8010182b:	85 d1                	test   %edx,%ecx
8010182d:	74 25                	je     80101854 <bfree+0x64>
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
8010182f:	f7 d2                	not    %edx
  log_write(bp);
80101831:	83 ec 0c             	sub    $0xc,%esp
80101834:	89 c6                	mov    %eax,%esi
  bp->data[bi/8] &= ~m;
80101836:	21 ca                	and    %ecx,%edx
80101838:	88 54 18 5c          	mov    %dl,0x5c(%eax,%ebx,1)
  log_write(bp);
8010183c:	50                   	push   %eax
8010183d:	e8 0e 1d 00 00       	call   80103550 <log_write>
  brelse(bp);
80101842:	89 34 24             	mov    %esi,(%esp)
80101845:	e8 a6 e9 ff ff       	call   801001f0 <brelse>
}
8010184a:	83 c4 10             	add    $0x10,%esp
8010184d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101850:	5b                   	pop    %ebx
80101851:	5e                   	pop    %esi
80101852:	5d                   	pop    %ebp
80101853:	c3                   	ret    
    panic("freeing free block");
80101854:	83 ec 0c             	sub    $0xc,%esp
80101857:	68 17 7a 10 80       	push   $0x80107a17
8010185c:	e8 4f eb ff ff       	call   801003b0 <panic>
80101861:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101868:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010186f:	90                   	nop

80101870 <balloc>:
{
80101870:	55                   	push   %ebp
80101871:	89 e5                	mov    %esp,%ebp
80101873:	57                   	push   %edi
80101874:	56                   	push   %esi
80101875:	53                   	push   %ebx
80101876:	83 ec 1c             	sub    $0x1c,%esp
  for(b = 0; b < sb.size; b += BPB){
80101879:	8b 0d 00 26 11 80    	mov    0x80112600,%ecx
{
8010187f:	89 45 d8             	mov    %eax,-0x28(%ebp)
  for(b = 0; b < sb.size; b += BPB){
80101882:	85 c9                	test   %ecx,%ecx
80101884:	0f 84 87 00 00 00    	je     80101911 <balloc+0xa1>
8010188a:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    bp = bread(dev, BBLOCK(b, sb));
80101891:	8b 75 dc             	mov    -0x24(%ebp),%esi
80101894:	83 ec 08             	sub    $0x8,%esp
80101897:	89 f0                	mov    %esi,%eax
80101899:	c1 f8 0c             	sar    $0xc,%eax
8010189c:	03 05 18 26 11 80    	add    0x80112618,%eax
801018a2:	50                   	push   %eax
801018a3:	ff 75 d8             	pushl  -0x28(%ebp)
801018a6:	e8 25 e8 ff ff       	call   801000d0 <bread>
801018ab:	83 c4 10             	add    $0x10,%esp
801018ae:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
801018b1:	a1 00 26 11 80       	mov    0x80112600,%eax
801018b6:	89 45 e0             	mov    %eax,-0x20(%ebp)
801018b9:	31 c0                	xor    %eax,%eax
801018bb:	eb 2f                	jmp    801018ec <balloc+0x7c>
801018bd:	8d 76 00             	lea    0x0(%esi),%esi
      m = 1 << (bi % 8);
801018c0:	89 c1                	mov    %eax,%ecx
801018c2:	bb 01 00 00 00       	mov    $0x1,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
801018c7:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      m = 1 << (bi % 8);
801018ca:	83 e1 07             	and    $0x7,%ecx
801018cd:	d3 e3                	shl    %cl,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
801018cf:	89 c1                	mov    %eax,%ecx
801018d1:	c1 f9 03             	sar    $0x3,%ecx
801018d4:	0f b6 7c 0a 5c       	movzbl 0x5c(%edx,%ecx,1),%edi
801018d9:	89 fa                	mov    %edi,%edx
801018db:	85 df                	test   %ebx,%edi
801018dd:	74 41                	je     80101920 <balloc+0xb0>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
801018df:	83 c0 01             	add    $0x1,%eax
801018e2:	83 c6 01             	add    $0x1,%esi
801018e5:	3d 00 10 00 00       	cmp    $0x1000,%eax
801018ea:	74 05                	je     801018f1 <balloc+0x81>
801018ec:	39 75 e0             	cmp    %esi,-0x20(%ebp)
801018ef:	77 cf                	ja     801018c0 <balloc+0x50>
    brelse(bp);
801018f1:	83 ec 0c             	sub    $0xc,%esp
801018f4:	ff 75 e4             	pushl  -0x1c(%ebp)
801018f7:	e8 f4 e8 ff ff       	call   801001f0 <brelse>
  for(b = 0; b < sb.size; b += BPB){
801018fc:	81 45 dc 00 10 00 00 	addl   $0x1000,-0x24(%ebp)
80101903:	83 c4 10             	add    $0x10,%esp
80101906:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101909:	39 05 00 26 11 80    	cmp    %eax,0x80112600
8010190f:	77 80                	ja     80101891 <balloc+0x21>
  panic("balloc: out of blocks");
80101911:	83 ec 0c             	sub    $0xc,%esp
80101914:	68 2a 7a 10 80       	push   $0x80107a2a
80101919:	e8 92 ea ff ff       	call   801003b0 <panic>
8010191e:	66 90                	xchg   %ax,%ax
        bp->data[bi/8] |= m;  // Mark block in use.
80101920:	8b 7d e4             	mov    -0x1c(%ebp),%edi
        log_write(bp);
80101923:	83 ec 0c             	sub    $0xc,%esp
        bp->data[bi/8] |= m;  // Mark block in use.
80101926:	09 da                	or     %ebx,%edx
80101928:	88 54 0f 5c          	mov    %dl,0x5c(%edi,%ecx,1)
        log_write(bp);
8010192c:	57                   	push   %edi
8010192d:	e8 1e 1c 00 00       	call   80103550 <log_write>
        brelse(bp);
80101932:	89 3c 24             	mov    %edi,(%esp)
80101935:	e8 b6 e8 ff ff       	call   801001f0 <brelse>
  bp = bread(dev, bno);
8010193a:	58                   	pop    %eax
8010193b:	5a                   	pop    %edx
8010193c:	56                   	push   %esi
8010193d:	ff 75 d8             	pushl  -0x28(%ebp)
80101940:	e8 8b e7 ff ff       	call   801000d0 <bread>
  memset(bp->data, 0, BSIZE);
80101945:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, bno);
80101948:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
8010194a:	8d 40 5c             	lea    0x5c(%eax),%eax
8010194d:	68 00 02 00 00       	push   $0x200
80101952:	6a 00                	push   $0x0
80101954:	50                   	push   %eax
80101955:	e8 36 34 00 00       	call   80104d90 <memset>
  log_write(bp);
8010195a:	89 1c 24             	mov    %ebx,(%esp)
8010195d:	e8 ee 1b 00 00       	call   80103550 <log_write>
  brelse(bp);
80101962:	89 1c 24             	mov    %ebx,(%esp)
80101965:	e8 86 e8 ff ff       	call   801001f0 <brelse>
}
8010196a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010196d:	89 f0                	mov    %esi,%eax
8010196f:	5b                   	pop    %ebx
80101970:	5e                   	pop    %esi
80101971:	5f                   	pop    %edi
80101972:	5d                   	pop    %ebp
80101973:	c3                   	ret    
80101974:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010197b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010197f:	90                   	nop

80101980 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
80101980:	55                   	push   %ebp
80101981:	89 e5                	mov    %esp,%ebp
80101983:	57                   	push   %edi
80101984:	89 c7                	mov    %eax,%edi
80101986:	56                   	push   %esi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
80101987:	31 f6                	xor    %esi,%esi
{
80101989:	53                   	push   %ebx
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010198a:	bb 54 26 11 80       	mov    $0x80112654,%ebx
{
8010198f:	83 ec 28             	sub    $0x28,%esp
80101992:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  acquire(&icache.lock);
80101995:	68 20 26 11 80       	push   $0x80112620
8010199a:	e8 e1 32 00 00       	call   80104c80 <acquire>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010199f:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  acquire(&icache.lock);
801019a2:	83 c4 10             	add    $0x10,%esp
801019a5:	eb 1b                	jmp    801019c2 <iget+0x42>
801019a7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801019ae:	66 90                	xchg   %ax,%ax
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801019b0:	39 3b                	cmp    %edi,(%ebx)
801019b2:	74 6c                	je     80101a20 <iget+0xa0>
801019b4:	81 c3 90 00 00 00    	add    $0x90,%ebx
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801019ba:	81 fb 74 42 11 80    	cmp    $0x80114274,%ebx
801019c0:	73 26                	jae    801019e8 <iget+0x68>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801019c2:	8b 4b 08             	mov    0x8(%ebx),%ecx
801019c5:	85 c9                	test   %ecx,%ecx
801019c7:	7f e7                	jg     801019b0 <iget+0x30>
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
801019c9:	85 f6                	test   %esi,%esi
801019cb:	75 e7                	jne    801019b4 <iget+0x34>
801019cd:	89 d8                	mov    %ebx,%eax
801019cf:	81 c3 90 00 00 00    	add    $0x90,%ebx
801019d5:	85 c9                	test   %ecx,%ecx
801019d7:	75 6e                	jne    80101a47 <iget+0xc7>
801019d9:	89 c6                	mov    %eax,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801019db:	81 fb 74 42 11 80    	cmp    $0x80114274,%ebx
801019e1:	72 df                	jb     801019c2 <iget+0x42>
801019e3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801019e7:	90                   	nop
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
801019e8:	85 f6                	test   %esi,%esi
801019ea:	74 73                	je     80101a5f <iget+0xdf>
  ip = empty;
  ip->dev = dev;
  ip->inum = inum;
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);
801019ec:	83 ec 0c             	sub    $0xc,%esp
  ip->dev = dev;
801019ef:	89 3e                	mov    %edi,(%esi)
  ip->inum = inum;
801019f1:	89 56 04             	mov    %edx,0x4(%esi)
  ip->ref = 1;
801019f4:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->valid = 0;
801019fb:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
  release(&icache.lock);
80101a02:	68 20 26 11 80       	push   $0x80112620
80101a07:	e8 34 33 00 00       	call   80104d40 <release>

  return ip;
80101a0c:	83 c4 10             	add    $0x10,%esp
}
80101a0f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101a12:	89 f0                	mov    %esi,%eax
80101a14:	5b                   	pop    %ebx
80101a15:	5e                   	pop    %esi
80101a16:	5f                   	pop    %edi
80101a17:	5d                   	pop    %ebp
80101a18:	c3                   	ret    
80101a19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101a20:	39 53 04             	cmp    %edx,0x4(%ebx)
80101a23:	75 8f                	jne    801019b4 <iget+0x34>
      release(&icache.lock);
80101a25:	83 ec 0c             	sub    $0xc,%esp
      ip->ref++;
80101a28:	83 c1 01             	add    $0x1,%ecx
      return ip;
80101a2b:	89 de                	mov    %ebx,%esi
      release(&icache.lock);
80101a2d:	68 20 26 11 80       	push   $0x80112620
      ip->ref++;
80101a32:	89 4b 08             	mov    %ecx,0x8(%ebx)
      release(&icache.lock);
80101a35:	e8 06 33 00 00       	call   80104d40 <release>
      return ip;
80101a3a:	83 c4 10             	add    $0x10,%esp
}
80101a3d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101a40:	89 f0                	mov    %esi,%eax
80101a42:	5b                   	pop    %ebx
80101a43:	5e                   	pop    %esi
80101a44:	5f                   	pop    %edi
80101a45:	5d                   	pop    %ebp
80101a46:	c3                   	ret    
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101a47:	81 fb 74 42 11 80    	cmp    $0x80114274,%ebx
80101a4d:	73 10                	jae    80101a5f <iget+0xdf>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101a4f:	8b 4b 08             	mov    0x8(%ebx),%ecx
80101a52:	85 c9                	test   %ecx,%ecx
80101a54:	0f 8f 56 ff ff ff    	jg     801019b0 <iget+0x30>
80101a5a:	e9 6e ff ff ff       	jmp    801019cd <iget+0x4d>
    panic("iget: no inodes");
80101a5f:	83 ec 0c             	sub    $0xc,%esp
80101a62:	68 40 7a 10 80       	push   $0x80107a40
80101a67:	e8 44 e9 ff ff       	call   801003b0 <panic>
80101a6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101a70 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
80101a70:	55                   	push   %ebp
80101a71:	89 e5                	mov    %esp,%ebp
80101a73:	57                   	push   %edi
80101a74:	56                   	push   %esi
80101a75:	89 c6                	mov    %eax,%esi
80101a77:	53                   	push   %ebx
80101a78:	83 ec 1c             	sub    $0x1c,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
80101a7b:	83 fa 0b             	cmp    $0xb,%edx
80101a7e:	0f 86 84 00 00 00    	jbe    80101b08 <bmap+0x98>
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
    return addr;
  }
  bn -= NDIRECT;
80101a84:	8d 5a f4             	lea    -0xc(%edx),%ebx

  if(bn < NINDIRECT){
80101a87:	83 fb 7f             	cmp    $0x7f,%ebx
80101a8a:	0f 87 98 00 00 00    	ja     80101b28 <bmap+0xb8>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
80101a90:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
80101a96:	8b 16                	mov    (%esi),%edx
80101a98:	85 c0                	test   %eax,%eax
80101a9a:	74 54                	je     80101af0 <bmap+0x80>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
80101a9c:	83 ec 08             	sub    $0x8,%esp
80101a9f:	50                   	push   %eax
80101aa0:	52                   	push   %edx
80101aa1:	e8 2a e6 ff ff       	call   801000d0 <bread>
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
80101aa6:	83 c4 10             	add    $0x10,%esp
80101aa9:	8d 54 98 5c          	lea    0x5c(%eax,%ebx,4),%edx
    bp = bread(ip->dev, addr);
80101aad:	89 c7                	mov    %eax,%edi
    if((addr = a[bn]) == 0){
80101aaf:	8b 1a                	mov    (%edx),%ebx
80101ab1:	85 db                	test   %ebx,%ebx
80101ab3:	74 1b                	je     80101ad0 <bmap+0x60>
      a[bn] = addr = balloc(ip->dev);
      log_write(bp);
    }
    brelse(bp);
80101ab5:	83 ec 0c             	sub    $0xc,%esp
80101ab8:	57                   	push   %edi
80101ab9:	e8 32 e7 ff ff       	call   801001f0 <brelse>
    return addr;
80101abe:	83 c4 10             	add    $0x10,%esp
  }

  panic("bmap: out of range");
}
80101ac1:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101ac4:	89 d8                	mov    %ebx,%eax
80101ac6:	5b                   	pop    %ebx
80101ac7:	5e                   	pop    %esi
80101ac8:	5f                   	pop    %edi
80101ac9:	5d                   	pop    %ebp
80101aca:	c3                   	ret    
80101acb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101acf:	90                   	nop
      a[bn] = addr = balloc(ip->dev);
80101ad0:	8b 06                	mov    (%esi),%eax
80101ad2:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101ad5:	e8 96 fd ff ff       	call   80101870 <balloc>
80101ada:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      log_write(bp);
80101add:	83 ec 0c             	sub    $0xc,%esp
      a[bn] = addr = balloc(ip->dev);
80101ae0:	89 c3                	mov    %eax,%ebx
80101ae2:	89 02                	mov    %eax,(%edx)
      log_write(bp);
80101ae4:	57                   	push   %edi
80101ae5:	e8 66 1a 00 00       	call   80103550 <log_write>
80101aea:	83 c4 10             	add    $0x10,%esp
80101aed:	eb c6                	jmp    80101ab5 <bmap+0x45>
80101aef:	90                   	nop
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
80101af0:	89 d0                	mov    %edx,%eax
80101af2:	e8 79 fd ff ff       	call   80101870 <balloc>
80101af7:	8b 16                	mov    (%esi),%edx
80101af9:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
80101aff:	eb 9b                	jmp    80101a9c <bmap+0x2c>
80101b01:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if((addr = ip->addrs[bn]) == 0)
80101b08:	8d 3c 90             	lea    (%eax,%edx,4),%edi
80101b0b:	8b 5f 5c             	mov    0x5c(%edi),%ebx
80101b0e:	85 db                	test   %ebx,%ebx
80101b10:	75 af                	jne    80101ac1 <bmap+0x51>
      ip->addrs[bn] = addr = balloc(ip->dev);
80101b12:	8b 00                	mov    (%eax),%eax
80101b14:	e8 57 fd ff ff       	call   80101870 <balloc>
80101b19:	89 47 5c             	mov    %eax,0x5c(%edi)
80101b1c:	89 c3                	mov    %eax,%ebx
}
80101b1e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b21:	89 d8                	mov    %ebx,%eax
80101b23:	5b                   	pop    %ebx
80101b24:	5e                   	pop    %esi
80101b25:	5f                   	pop    %edi
80101b26:	5d                   	pop    %ebp
80101b27:	c3                   	ret    
  panic("bmap: out of range");
80101b28:	83 ec 0c             	sub    $0xc,%esp
80101b2b:	68 50 7a 10 80       	push   $0x80107a50
80101b30:	e8 7b e8 ff ff       	call   801003b0 <panic>
80101b35:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101b3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101b40 <readsb>:
{
80101b40:	f3 0f 1e fb          	endbr32 
80101b44:	55                   	push   %ebp
80101b45:	89 e5                	mov    %esp,%ebp
80101b47:	56                   	push   %esi
80101b48:	53                   	push   %ebx
80101b49:	8b 75 0c             	mov    0xc(%ebp),%esi
  bp = bread(dev, 1);
80101b4c:	83 ec 08             	sub    $0x8,%esp
80101b4f:	6a 01                	push   $0x1
80101b51:	ff 75 08             	pushl  0x8(%ebp)
80101b54:	e8 77 e5 ff ff       	call   801000d0 <bread>
  memmove(sb, bp->data, sizeof(*sb));
80101b59:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, 1);
80101b5c:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
80101b5e:	8d 40 5c             	lea    0x5c(%eax),%eax
80101b61:	6a 1c                	push   $0x1c
80101b63:	50                   	push   %eax
80101b64:	56                   	push   %esi
80101b65:	e8 c6 32 00 00       	call   80104e30 <memmove>
  brelse(bp);
80101b6a:	89 5d 08             	mov    %ebx,0x8(%ebp)
80101b6d:	83 c4 10             	add    $0x10,%esp
}
80101b70:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101b73:	5b                   	pop    %ebx
80101b74:	5e                   	pop    %esi
80101b75:	5d                   	pop    %ebp
  brelse(bp);
80101b76:	e9 75 e6 ff ff       	jmp    801001f0 <brelse>
80101b7b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101b7f:	90                   	nop

80101b80 <iinit>:
{
80101b80:	f3 0f 1e fb          	endbr32 
80101b84:	55                   	push   %ebp
80101b85:	89 e5                	mov    %esp,%ebp
80101b87:	53                   	push   %ebx
80101b88:	bb 60 26 11 80       	mov    $0x80112660,%ebx
80101b8d:	83 ec 0c             	sub    $0xc,%esp
  initlock(&icache.lock, "icache");
80101b90:	68 63 7a 10 80       	push   $0x80107a63
80101b95:	68 20 26 11 80       	push   $0x80112620
80101b9a:	e8 61 2f 00 00       	call   80104b00 <initlock>
  for(i = 0; i < NINODE; i++) {
80101b9f:	83 c4 10             	add    $0x10,%esp
80101ba2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    initsleeplock(&icache.inode[i].lock, "inode");
80101ba8:	83 ec 08             	sub    $0x8,%esp
80101bab:	68 6a 7a 10 80       	push   $0x80107a6a
80101bb0:	53                   	push   %ebx
80101bb1:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101bb7:	e8 04 2e 00 00       	call   801049c0 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
80101bbc:	83 c4 10             	add    $0x10,%esp
80101bbf:	81 fb 80 42 11 80    	cmp    $0x80114280,%ebx
80101bc5:	75 e1                	jne    80101ba8 <iinit+0x28>
  readsb(dev, &sb);
80101bc7:	83 ec 08             	sub    $0x8,%esp
80101bca:	68 00 26 11 80       	push   $0x80112600
80101bcf:	ff 75 08             	pushl  0x8(%ebp)
80101bd2:	e8 69 ff ff ff       	call   80101b40 <readsb>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
80101bd7:	ff 35 18 26 11 80    	pushl  0x80112618
80101bdd:	ff 35 14 26 11 80    	pushl  0x80112614
80101be3:	ff 35 10 26 11 80    	pushl  0x80112610
80101be9:	ff 35 0c 26 11 80    	pushl  0x8011260c
80101bef:	ff 35 08 26 11 80    	pushl  0x80112608
80101bf5:	ff 35 04 26 11 80    	pushl  0x80112604
80101bfb:	ff 35 00 26 11 80    	pushl  0x80112600
80101c01:	68 d0 7a 10 80       	push   $0x80107ad0
80101c06:	e8 95 eb ff ff       	call   801007a0 <cprintf>
}
80101c0b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101c0e:	83 c4 30             	add    $0x30,%esp
80101c11:	c9                   	leave  
80101c12:	c3                   	ret    
80101c13:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101c1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101c20 <ialloc>:
{
80101c20:	f3 0f 1e fb          	endbr32 
80101c24:	55                   	push   %ebp
80101c25:	89 e5                	mov    %esp,%ebp
80101c27:	57                   	push   %edi
80101c28:	56                   	push   %esi
80101c29:	53                   	push   %ebx
80101c2a:	83 ec 1c             	sub    $0x1c,%esp
80101c2d:	8b 45 0c             	mov    0xc(%ebp),%eax
  for(inum = 1; inum < sb.ninodes; inum++){
80101c30:	83 3d 08 26 11 80 01 	cmpl   $0x1,0x80112608
{
80101c37:	8b 75 08             	mov    0x8(%ebp),%esi
80101c3a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(inum = 1; inum < sb.ninodes; inum++){
80101c3d:	0f 86 8d 00 00 00    	jbe    80101cd0 <ialloc+0xb0>
80101c43:	bf 01 00 00 00       	mov    $0x1,%edi
80101c48:	eb 1d                	jmp    80101c67 <ialloc+0x47>
80101c4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    brelse(bp);
80101c50:	83 ec 0c             	sub    $0xc,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
80101c53:	83 c7 01             	add    $0x1,%edi
    brelse(bp);
80101c56:	53                   	push   %ebx
80101c57:	e8 94 e5 ff ff       	call   801001f0 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
80101c5c:	83 c4 10             	add    $0x10,%esp
80101c5f:	3b 3d 08 26 11 80    	cmp    0x80112608,%edi
80101c65:	73 69                	jae    80101cd0 <ialloc+0xb0>
    bp = bread(dev, IBLOCK(inum, sb));
80101c67:	89 f8                	mov    %edi,%eax
80101c69:	83 ec 08             	sub    $0x8,%esp
80101c6c:	c1 e8 03             	shr    $0x3,%eax
80101c6f:	03 05 14 26 11 80    	add    0x80112614,%eax
80101c75:	50                   	push   %eax
80101c76:	56                   	push   %esi
80101c77:	e8 54 e4 ff ff       	call   801000d0 <bread>
    if(dip->type == 0){  // a free inode
80101c7c:	83 c4 10             	add    $0x10,%esp
    bp = bread(dev, IBLOCK(inum, sb));
80101c7f:	89 c3                	mov    %eax,%ebx
    dip = (struct dinode*)bp->data + inum%IPB;
80101c81:	89 f8                	mov    %edi,%eax
80101c83:	83 e0 07             	and    $0x7,%eax
80101c86:	c1 e0 06             	shl    $0x6,%eax
80101c89:	8d 4c 03 5c          	lea    0x5c(%ebx,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
80101c8d:	66 83 39 00          	cmpw   $0x0,(%ecx)
80101c91:	75 bd                	jne    80101c50 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
80101c93:	83 ec 04             	sub    $0x4,%esp
80101c96:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80101c99:	6a 40                	push   $0x40
80101c9b:	6a 00                	push   $0x0
80101c9d:	51                   	push   %ecx
80101c9e:	e8 ed 30 00 00       	call   80104d90 <memset>
      dip->type = type;
80101ca3:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
80101ca7:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80101caa:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
80101cad:	89 1c 24             	mov    %ebx,(%esp)
80101cb0:	e8 9b 18 00 00       	call   80103550 <log_write>
      brelse(bp);
80101cb5:	89 1c 24             	mov    %ebx,(%esp)
80101cb8:	e8 33 e5 ff ff       	call   801001f0 <brelse>
      return iget(dev, inum);
80101cbd:	83 c4 10             	add    $0x10,%esp
}
80101cc0:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return iget(dev, inum);
80101cc3:	89 fa                	mov    %edi,%edx
}
80101cc5:	5b                   	pop    %ebx
      return iget(dev, inum);
80101cc6:	89 f0                	mov    %esi,%eax
}
80101cc8:	5e                   	pop    %esi
80101cc9:	5f                   	pop    %edi
80101cca:	5d                   	pop    %ebp
      return iget(dev, inum);
80101ccb:	e9 b0 fc ff ff       	jmp    80101980 <iget>
  panic("ialloc: no inodes");
80101cd0:	83 ec 0c             	sub    $0xc,%esp
80101cd3:	68 70 7a 10 80       	push   $0x80107a70
80101cd8:	e8 d3 e6 ff ff       	call   801003b0 <panic>
80101cdd:	8d 76 00             	lea    0x0(%esi),%esi

80101ce0 <iupdate>:
{
80101ce0:	f3 0f 1e fb          	endbr32 
80101ce4:	55                   	push   %ebp
80101ce5:	89 e5                	mov    %esp,%ebp
80101ce7:	56                   	push   %esi
80101ce8:	53                   	push   %ebx
80101ce9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101cec:	8b 43 04             	mov    0x4(%ebx),%eax
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101cef:	83 c3 5c             	add    $0x5c,%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101cf2:	83 ec 08             	sub    $0x8,%esp
80101cf5:	c1 e8 03             	shr    $0x3,%eax
80101cf8:	03 05 14 26 11 80    	add    0x80112614,%eax
80101cfe:	50                   	push   %eax
80101cff:	ff 73 a4             	pushl  -0x5c(%ebx)
80101d02:	e8 c9 e3 ff ff       	call   801000d0 <bread>
  dip->type = ip->type;
80101d07:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101d0b:	83 c4 0c             	add    $0xc,%esp
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101d0e:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
80101d10:	8b 43 a8             	mov    -0x58(%ebx),%eax
80101d13:	83 e0 07             	and    $0x7,%eax
80101d16:	c1 e0 06             	shl    $0x6,%eax
80101d19:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
  dip->type = ip->type;
80101d1d:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
80101d20:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101d24:	83 c0 0c             	add    $0xc,%eax
  dip->major = ip->major;
80101d27:	66 89 50 f6          	mov    %dx,-0xa(%eax)
  dip->minor = ip->minor;
80101d2b:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
80101d2f:	66 89 50 f8          	mov    %dx,-0x8(%eax)
  dip->nlink = ip->nlink;
80101d33:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
80101d37:	66 89 50 fa          	mov    %dx,-0x6(%eax)
  dip->size = ip->size;
80101d3b:	8b 53 fc             	mov    -0x4(%ebx),%edx
80101d3e:	89 50 fc             	mov    %edx,-0x4(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101d41:	6a 34                	push   $0x34
80101d43:	53                   	push   %ebx
80101d44:	50                   	push   %eax
80101d45:	e8 e6 30 00 00       	call   80104e30 <memmove>
  log_write(bp);
80101d4a:	89 34 24             	mov    %esi,(%esp)
80101d4d:	e8 fe 17 00 00       	call   80103550 <log_write>
  brelse(bp);
80101d52:	89 75 08             	mov    %esi,0x8(%ebp)
80101d55:	83 c4 10             	add    $0x10,%esp
}
80101d58:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101d5b:	5b                   	pop    %ebx
80101d5c:	5e                   	pop    %esi
80101d5d:	5d                   	pop    %ebp
  brelse(bp);
80101d5e:	e9 8d e4 ff ff       	jmp    801001f0 <brelse>
80101d63:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101d6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101d70 <idup>:
{
80101d70:	f3 0f 1e fb          	endbr32 
80101d74:	55                   	push   %ebp
80101d75:	89 e5                	mov    %esp,%ebp
80101d77:	53                   	push   %ebx
80101d78:	83 ec 10             	sub    $0x10,%esp
80101d7b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
80101d7e:	68 20 26 11 80       	push   $0x80112620
80101d83:	e8 f8 2e 00 00       	call   80104c80 <acquire>
  ip->ref++;
80101d88:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
80101d8c:	c7 04 24 20 26 11 80 	movl   $0x80112620,(%esp)
80101d93:	e8 a8 2f 00 00       	call   80104d40 <release>
}
80101d98:	89 d8                	mov    %ebx,%eax
80101d9a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101d9d:	c9                   	leave  
80101d9e:	c3                   	ret    
80101d9f:	90                   	nop

80101da0 <ilock>:
{
80101da0:	f3 0f 1e fb          	endbr32 
80101da4:	55                   	push   %ebp
80101da5:	89 e5                	mov    %esp,%ebp
80101da7:	56                   	push   %esi
80101da8:	53                   	push   %ebx
80101da9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || ip->ref < 1)
80101dac:	85 db                	test   %ebx,%ebx
80101dae:	0f 84 b3 00 00 00    	je     80101e67 <ilock+0xc7>
80101db4:	8b 53 08             	mov    0x8(%ebx),%edx
80101db7:	85 d2                	test   %edx,%edx
80101db9:	0f 8e a8 00 00 00    	jle    80101e67 <ilock+0xc7>
  acquiresleep(&ip->lock);
80101dbf:	83 ec 0c             	sub    $0xc,%esp
80101dc2:	8d 43 0c             	lea    0xc(%ebx),%eax
80101dc5:	50                   	push   %eax
80101dc6:	e8 35 2c 00 00       	call   80104a00 <acquiresleep>
  if(ip->valid == 0){
80101dcb:	8b 43 4c             	mov    0x4c(%ebx),%eax
80101dce:	83 c4 10             	add    $0x10,%esp
80101dd1:	85 c0                	test   %eax,%eax
80101dd3:	74 0b                	je     80101de0 <ilock+0x40>
}
80101dd5:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101dd8:	5b                   	pop    %ebx
80101dd9:	5e                   	pop    %esi
80101dda:	5d                   	pop    %ebp
80101ddb:	c3                   	ret    
80101ddc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101de0:	8b 43 04             	mov    0x4(%ebx),%eax
80101de3:	83 ec 08             	sub    $0x8,%esp
80101de6:	c1 e8 03             	shr    $0x3,%eax
80101de9:	03 05 14 26 11 80    	add    0x80112614,%eax
80101def:	50                   	push   %eax
80101df0:	ff 33                	pushl  (%ebx)
80101df2:	e8 d9 e2 ff ff       	call   801000d0 <bread>
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101df7:	83 c4 0c             	add    $0xc,%esp
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101dfa:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
80101dfc:	8b 43 04             	mov    0x4(%ebx),%eax
80101dff:	83 e0 07             	and    $0x7,%eax
80101e02:	c1 e0 06             	shl    $0x6,%eax
80101e05:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    ip->type = dip->type;
80101e09:	0f b7 10             	movzwl (%eax),%edx
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101e0c:	83 c0 0c             	add    $0xc,%eax
    ip->type = dip->type;
80101e0f:	66 89 53 50          	mov    %dx,0x50(%ebx)
    ip->major = dip->major;
80101e13:	0f b7 50 f6          	movzwl -0xa(%eax),%edx
80101e17:	66 89 53 52          	mov    %dx,0x52(%ebx)
    ip->minor = dip->minor;
80101e1b:	0f b7 50 f8          	movzwl -0x8(%eax),%edx
80101e1f:	66 89 53 54          	mov    %dx,0x54(%ebx)
    ip->nlink = dip->nlink;
80101e23:	0f b7 50 fa          	movzwl -0x6(%eax),%edx
80101e27:	66 89 53 56          	mov    %dx,0x56(%ebx)
    ip->size = dip->size;
80101e2b:	8b 50 fc             	mov    -0x4(%eax),%edx
80101e2e:	89 53 58             	mov    %edx,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101e31:	6a 34                	push   $0x34
80101e33:	50                   	push   %eax
80101e34:	8d 43 5c             	lea    0x5c(%ebx),%eax
80101e37:	50                   	push   %eax
80101e38:	e8 f3 2f 00 00       	call   80104e30 <memmove>
    brelse(bp);
80101e3d:	89 34 24             	mov    %esi,(%esp)
80101e40:	e8 ab e3 ff ff       	call   801001f0 <brelse>
    if(ip->type == 0)
80101e45:	83 c4 10             	add    $0x10,%esp
80101e48:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
    ip->valid = 1;
80101e4d:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if(ip->type == 0)
80101e54:	0f 85 7b ff ff ff    	jne    80101dd5 <ilock+0x35>
      panic("ilock: no type");
80101e5a:	83 ec 0c             	sub    $0xc,%esp
80101e5d:	68 88 7a 10 80       	push   $0x80107a88
80101e62:	e8 49 e5 ff ff       	call   801003b0 <panic>
    panic("ilock");
80101e67:	83 ec 0c             	sub    $0xc,%esp
80101e6a:	68 82 7a 10 80       	push   $0x80107a82
80101e6f:	e8 3c e5 ff ff       	call   801003b0 <panic>
80101e74:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101e7b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101e7f:	90                   	nop

80101e80 <iunlock>:
{
80101e80:	f3 0f 1e fb          	endbr32 
80101e84:	55                   	push   %ebp
80101e85:	89 e5                	mov    %esp,%ebp
80101e87:	56                   	push   %esi
80101e88:	53                   	push   %ebx
80101e89:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101e8c:	85 db                	test   %ebx,%ebx
80101e8e:	74 28                	je     80101eb8 <iunlock+0x38>
80101e90:	83 ec 0c             	sub    $0xc,%esp
80101e93:	8d 73 0c             	lea    0xc(%ebx),%esi
80101e96:	56                   	push   %esi
80101e97:	e8 04 2c 00 00       	call   80104aa0 <holdingsleep>
80101e9c:	83 c4 10             	add    $0x10,%esp
80101e9f:	85 c0                	test   %eax,%eax
80101ea1:	74 15                	je     80101eb8 <iunlock+0x38>
80101ea3:	8b 43 08             	mov    0x8(%ebx),%eax
80101ea6:	85 c0                	test   %eax,%eax
80101ea8:	7e 0e                	jle    80101eb8 <iunlock+0x38>
  releasesleep(&ip->lock);
80101eaa:	89 75 08             	mov    %esi,0x8(%ebp)
}
80101ead:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101eb0:	5b                   	pop    %ebx
80101eb1:	5e                   	pop    %esi
80101eb2:	5d                   	pop    %ebp
  releasesleep(&ip->lock);
80101eb3:	e9 a8 2b 00 00       	jmp    80104a60 <releasesleep>
    panic("iunlock");
80101eb8:	83 ec 0c             	sub    $0xc,%esp
80101ebb:	68 97 7a 10 80       	push   $0x80107a97
80101ec0:	e8 eb e4 ff ff       	call   801003b0 <panic>
80101ec5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101ecc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101ed0 <iput>:
{
80101ed0:	f3 0f 1e fb          	endbr32 
80101ed4:	55                   	push   %ebp
80101ed5:	89 e5                	mov    %esp,%ebp
80101ed7:	57                   	push   %edi
80101ed8:	56                   	push   %esi
80101ed9:	53                   	push   %ebx
80101eda:	83 ec 28             	sub    $0x28,%esp
80101edd:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquiresleep(&ip->lock);
80101ee0:	8d 7b 0c             	lea    0xc(%ebx),%edi
80101ee3:	57                   	push   %edi
80101ee4:	e8 17 2b 00 00       	call   80104a00 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
80101ee9:	8b 53 4c             	mov    0x4c(%ebx),%edx
80101eec:	83 c4 10             	add    $0x10,%esp
80101eef:	85 d2                	test   %edx,%edx
80101ef1:	74 07                	je     80101efa <iput+0x2a>
80101ef3:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80101ef8:	74 36                	je     80101f30 <iput+0x60>
  releasesleep(&ip->lock);
80101efa:	83 ec 0c             	sub    $0xc,%esp
80101efd:	57                   	push   %edi
80101efe:	e8 5d 2b 00 00       	call   80104a60 <releasesleep>
  acquire(&icache.lock);
80101f03:	c7 04 24 20 26 11 80 	movl   $0x80112620,(%esp)
80101f0a:	e8 71 2d 00 00       	call   80104c80 <acquire>
  ip->ref--;
80101f0f:	83 6b 08 01          	subl   $0x1,0x8(%ebx)
  release(&icache.lock);
80101f13:	83 c4 10             	add    $0x10,%esp
80101f16:	c7 45 08 20 26 11 80 	movl   $0x80112620,0x8(%ebp)
}
80101f1d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101f20:	5b                   	pop    %ebx
80101f21:	5e                   	pop    %esi
80101f22:	5f                   	pop    %edi
80101f23:	5d                   	pop    %ebp
  release(&icache.lock);
80101f24:	e9 17 2e 00 00       	jmp    80104d40 <release>
80101f29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    acquire(&icache.lock);
80101f30:	83 ec 0c             	sub    $0xc,%esp
80101f33:	68 20 26 11 80       	push   $0x80112620
80101f38:	e8 43 2d 00 00       	call   80104c80 <acquire>
    int r = ip->ref;
80101f3d:	8b 73 08             	mov    0x8(%ebx),%esi
    release(&icache.lock);
80101f40:	c7 04 24 20 26 11 80 	movl   $0x80112620,(%esp)
80101f47:	e8 f4 2d 00 00       	call   80104d40 <release>
    if(r == 1){
80101f4c:	83 c4 10             	add    $0x10,%esp
80101f4f:	83 fe 01             	cmp    $0x1,%esi
80101f52:	75 a6                	jne    80101efa <iput+0x2a>
80101f54:	8d 8b 8c 00 00 00    	lea    0x8c(%ebx),%ecx
80101f5a:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80101f5d:	8d 73 5c             	lea    0x5c(%ebx),%esi
80101f60:	89 cf                	mov    %ecx,%edi
80101f62:	eb 0b                	jmp    80101f6f <iput+0x9f>
80101f64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101f68:	83 c6 04             	add    $0x4,%esi
80101f6b:	39 fe                	cmp    %edi,%esi
80101f6d:	74 19                	je     80101f88 <iput+0xb8>
    if(ip->addrs[i]){
80101f6f:	8b 16                	mov    (%esi),%edx
80101f71:	85 d2                	test   %edx,%edx
80101f73:	74 f3                	je     80101f68 <iput+0x98>
      bfree(ip->dev, ip->addrs[i]);
80101f75:	8b 03                	mov    (%ebx),%eax
80101f77:	e8 74 f8 ff ff       	call   801017f0 <bfree>
      ip->addrs[i] = 0;
80101f7c:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80101f82:	eb e4                	jmp    80101f68 <iput+0x98>
80101f84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  if(ip->addrs[NDIRECT]){
80101f88:	8b 83 8c 00 00 00    	mov    0x8c(%ebx),%eax
80101f8e:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101f91:	85 c0                	test   %eax,%eax
80101f93:	75 33                	jne    80101fc8 <iput+0xf8>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
  iupdate(ip);
80101f95:	83 ec 0c             	sub    $0xc,%esp
  ip->size = 0;
80101f98:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  iupdate(ip);
80101f9f:	53                   	push   %ebx
80101fa0:	e8 3b fd ff ff       	call   80101ce0 <iupdate>
      ip->type = 0;
80101fa5:	31 c0                	xor    %eax,%eax
80101fa7:	66 89 43 50          	mov    %ax,0x50(%ebx)
      iupdate(ip);
80101fab:	89 1c 24             	mov    %ebx,(%esp)
80101fae:	e8 2d fd ff ff       	call   80101ce0 <iupdate>
      ip->valid = 0;
80101fb3:	c7 43 4c 00 00 00 00 	movl   $0x0,0x4c(%ebx)
80101fba:	83 c4 10             	add    $0x10,%esp
80101fbd:	e9 38 ff ff ff       	jmp    80101efa <iput+0x2a>
80101fc2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
80101fc8:	83 ec 08             	sub    $0x8,%esp
80101fcb:	50                   	push   %eax
80101fcc:	ff 33                	pushl  (%ebx)
80101fce:	e8 fd e0 ff ff       	call   801000d0 <bread>
80101fd3:	89 7d e0             	mov    %edi,-0x20(%ebp)
80101fd6:	83 c4 10             	add    $0x10,%esp
80101fd9:	8d 88 5c 02 00 00    	lea    0x25c(%eax),%ecx
80101fdf:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(j = 0; j < NINDIRECT; j++){
80101fe2:	8d 70 5c             	lea    0x5c(%eax),%esi
80101fe5:	89 cf                	mov    %ecx,%edi
80101fe7:	eb 0e                	jmp    80101ff7 <iput+0x127>
80101fe9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101ff0:	83 c6 04             	add    $0x4,%esi
80101ff3:	39 f7                	cmp    %esi,%edi
80101ff5:	74 19                	je     80102010 <iput+0x140>
      if(a[j])
80101ff7:	8b 16                	mov    (%esi),%edx
80101ff9:	85 d2                	test   %edx,%edx
80101ffb:	74 f3                	je     80101ff0 <iput+0x120>
        bfree(ip->dev, a[j]);
80101ffd:	8b 03                	mov    (%ebx),%eax
80101fff:	e8 ec f7 ff ff       	call   801017f0 <bfree>
80102004:	eb ea                	jmp    80101ff0 <iput+0x120>
80102006:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010200d:	8d 76 00             	lea    0x0(%esi),%esi
    brelse(bp);
80102010:	83 ec 0c             	sub    $0xc,%esp
80102013:	ff 75 e4             	pushl  -0x1c(%ebp)
80102016:	8b 7d e0             	mov    -0x20(%ebp),%edi
80102019:	e8 d2 e1 ff ff       	call   801001f0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
8010201e:	8b 93 8c 00 00 00    	mov    0x8c(%ebx),%edx
80102024:	8b 03                	mov    (%ebx),%eax
80102026:	e8 c5 f7 ff ff       	call   801017f0 <bfree>
    ip->addrs[NDIRECT] = 0;
8010202b:	83 c4 10             	add    $0x10,%esp
8010202e:	c7 83 8c 00 00 00 00 	movl   $0x0,0x8c(%ebx)
80102035:	00 00 00 
80102038:	e9 58 ff ff ff       	jmp    80101f95 <iput+0xc5>
8010203d:	8d 76 00             	lea    0x0(%esi),%esi

80102040 <iunlockput>:
{
80102040:	f3 0f 1e fb          	endbr32 
80102044:	55                   	push   %ebp
80102045:	89 e5                	mov    %esp,%ebp
80102047:	53                   	push   %ebx
80102048:	83 ec 10             	sub    $0x10,%esp
8010204b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  iunlock(ip);
8010204e:	53                   	push   %ebx
8010204f:	e8 2c fe ff ff       	call   80101e80 <iunlock>
  iput(ip);
80102054:	89 5d 08             	mov    %ebx,0x8(%ebp)
80102057:	83 c4 10             	add    $0x10,%esp
}
8010205a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010205d:	c9                   	leave  
  iput(ip);
8010205e:	e9 6d fe ff ff       	jmp    80101ed0 <iput>
80102063:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010206a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102070 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
80102070:	f3 0f 1e fb          	endbr32 
80102074:	55                   	push   %ebp
80102075:	89 e5                	mov    %esp,%ebp
80102077:	8b 55 08             	mov    0x8(%ebp),%edx
8010207a:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
8010207d:	8b 0a                	mov    (%edx),%ecx
8010207f:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
80102082:	8b 4a 04             	mov    0x4(%edx),%ecx
80102085:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
80102088:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
8010208c:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
8010208f:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
80102093:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
80102097:	8b 52 58             	mov    0x58(%edx),%edx
8010209a:	89 50 10             	mov    %edx,0x10(%eax)
}
8010209d:	5d                   	pop    %ebp
8010209e:	c3                   	ret    
8010209f:	90                   	nop

801020a0 <readi>:
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
801020a0:	f3 0f 1e fb          	endbr32 
801020a4:	55                   	push   %ebp
801020a5:	89 e5                	mov    %esp,%ebp
801020a7:	57                   	push   %edi
801020a8:	56                   	push   %esi
801020a9:	53                   	push   %ebx
801020aa:	83 ec 1c             	sub    $0x1c,%esp
801020ad:	8b 7d 0c             	mov    0xc(%ebp),%edi
801020b0:	8b 45 08             	mov    0x8(%ebp),%eax
801020b3:	8b 75 10             	mov    0x10(%ebp),%esi
801020b6:	89 7d e0             	mov    %edi,-0x20(%ebp)
801020b9:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
801020bc:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
801020c1:	89 45 d8             	mov    %eax,-0x28(%ebp)
801020c4:	89 7d e4             	mov    %edi,-0x1c(%ebp)
  if(ip->type == T_DEV){
801020c7:	0f 84 a3 00 00 00    	je     80102170 <readi+0xd0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
801020cd:	8b 45 d8             	mov    -0x28(%ebp),%eax
801020d0:	8b 40 58             	mov    0x58(%eax),%eax
801020d3:	39 c6                	cmp    %eax,%esi
801020d5:	0f 87 b6 00 00 00    	ja     80102191 <readi+0xf1>
801020db:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
801020de:	31 c9                	xor    %ecx,%ecx
801020e0:	89 da                	mov    %ebx,%edx
801020e2:	01 f2                	add    %esi,%edx
801020e4:	0f 92 c1             	setb   %cl
801020e7:	89 cf                	mov    %ecx,%edi
801020e9:	0f 82 a2 00 00 00    	jb     80102191 <readi+0xf1>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
801020ef:	89 c1                	mov    %eax,%ecx
801020f1:	29 f1                	sub    %esi,%ecx
801020f3:	39 d0                	cmp    %edx,%eax
801020f5:	0f 43 cb             	cmovae %ebx,%ecx
801020f8:	89 4d e4             	mov    %ecx,-0x1c(%ebp)

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
801020fb:	85 c9                	test   %ecx,%ecx
801020fd:	74 63                	je     80102162 <readi+0xc2>
801020ff:	90                   	nop
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80102100:	8b 5d d8             	mov    -0x28(%ebp),%ebx
80102103:	89 f2                	mov    %esi,%edx
80102105:	c1 ea 09             	shr    $0x9,%edx
80102108:	89 d8                	mov    %ebx,%eax
8010210a:	e8 61 f9 ff ff       	call   80101a70 <bmap>
8010210f:	83 ec 08             	sub    $0x8,%esp
80102112:	50                   	push   %eax
80102113:	ff 33                	pushl  (%ebx)
80102115:	e8 b6 df ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
8010211a:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
8010211d:	b9 00 02 00 00       	mov    $0x200,%ecx
80102122:	83 c4 0c             	add    $0xc,%esp
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80102125:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80102127:	89 f0                	mov    %esi,%eax
80102129:	25 ff 01 00 00       	and    $0x1ff,%eax
8010212e:	29 fb                	sub    %edi,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80102130:	89 55 dc             	mov    %edx,-0x24(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
80102133:	29 c1                	sub    %eax,%ecx
    memmove(dst, bp->data + off%BSIZE, m);
80102135:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80102139:	39 d9                	cmp    %ebx,%ecx
8010213b:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
8010213e:	53                   	push   %ebx
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
8010213f:	01 df                	add    %ebx,%edi
80102141:	01 de                	add    %ebx,%esi
    memmove(dst, bp->data + off%BSIZE, m);
80102143:	50                   	push   %eax
80102144:	ff 75 e0             	pushl  -0x20(%ebp)
80102147:	e8 e4 2c 00 00       	call   80104e30 <memmove>
    brelse(bp);
8010214c:	8b 55 dc             	mov    -0x24(%ebp),%edx
8010214f:	89 14 24             	mov    %edx,(%esp)
80102152:	e8 99 e0 ff ff       	call   801001f0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80102157:	01 5d e0             	add    %ebx,-0x20(%ebp)
8010215a:	83 c4 10             	add    $0x10,%esp
8010215d:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80102160:	77 9e                	ja     80102100 <readi+0x60>
  }
  return n;
80102162:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
80102165:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102168:	5b                   	pop    %ebx
80102169:	5e                   	pop    %esi
8010216a:	5f                   	pop    %edi
8010216b:	5d                   	pop    %ebp
8010216c:	c3                   	ret    
8010216d:	8d 76 00             	lea    0x0(%esi),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80102170:	0f bf 40 52          	movswl 0x52(%eax),%eax
80102174:	66 83 f8 09          	cmp    $0x9,%ax
80102178:	77 17                	ja     80102191 <readi+0xf1>
8010217a:	8b 04 c5 a0 25 11 80 	mov    -0x7feeda60(,%eax,8),%eax
80102181:	85 c0                	test   %eax,%eax
80102183:	74 0c                	je     80102191 <readi+0xf1>
    return devsw[ip->major].read(ip, dst, n);
80102185:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80102188:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010218b:	5b                   	pop    %ebx
8010218c:	5e                   	pop    %esi
8010218d:	5f                   	pop    %edi
8010218e:	5d                   	pop    %ebp
    return devsw[ip->major].read(ip, dst, n);
8010218f:	ff e0                	jmp    *%eax
      return -1;
80102191:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102196:	eb cd                	jmp    80102165 <readi+0xc5>
80102198:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010219f:	90                   	nop

801021a0 <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
801021a0:	f3 0f 1e fb          	endbr32 
801021a4:	55                   	push   %ebp
801021a5:	89 e5                	mov    %esp,%ebp
801021a7:	57                   	push   %edi
801021a8:	56                   	push   %esi
801021a9:	53                   	push   %ebx
801021aa:	83 ec 1c             	sub    $0x1c,%esp
801021ad:	8b 45 08             	mov    0x8(%ebp),%eax
801021b0:	8b 75 0c             	mov    0xc(%ebp),%esi
801021b3:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
801021b6:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
801021bb:	89 75 dc             	mov    %esi,-0x24(%ebp)
801021be:	89 45 d8             	mov    %eax,-0x28(%ebp)
801021c1:	8b 75 10             	mov    0x10(%ebp),%esi
801021c4:	89 7d e0             	mov    %edi,-0x20(%ebp)
  if(ip->type == T_DEV){
801021c7:	0f 84 b3 00 00 00    	je     80102280 <writei+0xe0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
801021cd:	8b 45 d8             	mov    -0x28(%ebp),%eax
801021d0:	39 70 58             	cmp    %esi,0x58(%eax)
801021d3:	0f 82 e3 00 00 00    	jb     801022bc <writei+0x11c>
    return -1;
  if(off + n > MAXFILE*BSIZE)
801021d9:	8b 7d e0             	mov    -0x20(%ebp),%edi
801021dc:	89 f8                	mov    %edi,%eax
801021de:	01 f0                	add    %esi,%eax
801021e0:	0f 82 d6 00 00 00    	jb     801022bc <writei+0x11c>
801021e6:	3d 00 18 01 00       	cmp    $0x11800,%eax
801021eb:	0f 87 cb 00 00 00    	ja     801022bc <writei+0x11c>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
801021f1:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
801021f8:	85 ff                	test   %edi,%edi
801021fa:	74 75                	je     80102271 <writei+0xd1>
801021fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80102200:	8b 7d d8             	mov    -0x28(%ebp),%edi
80102203:	89 f2                	mov    %esi,%edx
80102205:	c1 ea 09             	shr    $0x9,%edx
80102208:	89 f8                	mov    %edi,%eax
8010220a:	e8 61 f8 ff ff       	call   80101a70 <bmap>
8010220f:	83 ec 08             	sub    $0x8,%esp
80102212:	50                   	push   %eax
80102213:	ff 37                	pushl  (%edi)
80102215:	e8 b6 de ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
8010221a:	b9 00 02 00 00       	mov    $0x200,%ecx
8010221f:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80102222:	2b 5d e4             	sub    -0x1c(%ebp),%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80102225:	89 c7                	mov    %eax,%edi
    m = min(n - tot, BSIZE - off%BSIZE);
80102227:	89 f0                	mov    %esi,%eax
80102229:	83 c4 0c             	add    $0xc,%esp
8010222c:	25 ff 01 00 00       	and    $0x1ff,%eax
80102231:	29 c1                	sub    %eax,%ecx
    memmove(bp->data + off%BSIZE, src, m);
80102233:	8d 44 07 5c          	lea    0x5c(%edi,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80102237:	39 d9                	cmp    %ebx,%ecx
80102239:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(bp->data + off%BSIZE, src, m);
8010223c:	53                   	push   %ebx
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
8010223d:	01 de                	add    %ebx,%esi
    memmove(bp->data + off%BSIZE, src, m);
8010223f:	ff 75 dc             	pushl  -0x24(%ebp)
80102242:	50                   	push   %eax
80102243:	e8 e8 2b 00 00       	call   80104e30 <memmove>
    log_write(bp);
80102248:	89 3c 24             	mov    %edi,(%esp)
8010224b:	e8 00 13 00 00       	call   80103550 <log_write>
    brelse(bp);
80102250:	89 3c 24             	mov    %edi,(%esp)
80102253:	e8 98 df ff ff       	call   801001f0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80102258:	01 5d e4             	add    %ebx,-0x1c(%ebp)
8010225b:	83 c4 10             	add    $0x10,%esp
8010225e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80102261:	01 5d dc             	add    %ebx,-0x24(%ebp)
80102264:	39 45 e0             	cmp    %eax,-0x20(%ebp)
80102267:	77 97                	ja     80102200 <writei+0x60>
  }

  if(n > 0 && off > ip->size){
80102269:	8b 45 d8             	mov    -0x28(%ebp),%eax
8010226c:	3b 70 58             	cmp    0x58(%eax),%esi
8010226f:	77 37                	ja     801022a8 <writei+0x108>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80102271:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80102274:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102277:	5b                   	pop    %ebx
80102278:	5e                   	pop    %esi
80102279:	5f                   	pop    %edi
8010227a:	5d                   	pop    %ebp
8010227b:	c3                   	ret    
8010227c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80102280:	0f bf 40 52          	movswl 0x52(%eax),%eax
80102284:	66 83 f8 09          	cmp    $0x9,%ax
80102288:	77 32                	ja     801022bc <writei+0x11c>
8010228a:	8b 04 c5 a4 25 11 80 	mov    -0x7feeda5c(,%eax,8),%eax
80102291:	85 c0                	test   %eax,%eax
80102293:	74 27                	je     801022bc <writei+0x11c>
    return devsw[ip->major].write(ip, src, n);
80102295:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80102298:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010229b:	5b                   	pop    %ebx
8010229c:	5e                   	pop    %esi
8010229d:	5f                   	pop    %edi
8010229e:	5d                   	pop    %ebp
    return devsw[ip->major].write(ip, src, n);
8010229f:	ff e0                	jmp    *%eax
801022a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    ip->size = off;
801022a8:	8b 45 d8             	mov    -0x28(%ebp),%eax
    iupdate(ip);
801022ab:	83 ec 0c             	sub    $0xc,%esp
    ip->size = off;
801022ae:	89 70 58             	mov    %esi,0x58(%eax)
    iupdate(ip);
801022b1:	50                   	push   %eax
801022b2:	e8 29 fa ff ff       	call   80101ce0 <iupdate>
801022b7:	83 c4 10             	add    $0x10,%esp
801022ba:	eb b5                	jmp    80102271 <writei+0xd1>
      return -1;
801022bc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801022c1:	eb b1                	jmp    80102274 <writei+0xd4>
801022c3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801022ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801022d0 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
801022d0:	f3 0f 1e fb          	endbr32 
801022d4:	55                   	push   %ebp
801022d5:	89 e5                	mov    %esp,%ebp
801022d7:	83 ec 0c             	sub    $0xc,%esp
  return strncmp(s, t, DIRSIZ);
801022da:	6a 0e                	push   $0xe
801022dc:	ff 75 0c             	pushl  0xc(%ebp)
801022df:	ff 75 08             	pushl  0x8(%ebp)
801022e2:	e8 b9 2b 00 00       	call   80104ea0 <strncmp>
}
801022e7:	c9                   	leave  
801022e8:	c3                   	ret    
801022e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801022f0 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
801022f0:	f3 0f 1e fb          	endbr32 
801022f4:	55                   	push   %ebp
801022f5:	89 e5                	mov    %esp,%ebp
801022f7:	57                   	push   %edi
801022f8:	56                   	push   %esi
801022f9:	53                   	push   %ebx
801022fa:	83 ec 1c             	sub    $0x1c,%esp
801022fd:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80102300:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80102305:	0f 85 89 00 00 00    	jne    80102394 <dirlookup+0xa4>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
8010230b:	8b 53 58             	mov    0x58(%ebx),%edx
8010230e:	31 ff                	xor    %edi,%edi
80102310:	8d 75 d8             	lea    -0x28(%ebp),%esi
80102313:	85 d2                	test   %edx,%edx
80102315:	74 42                	je     80102359 <dirlookup+0x69>
80102317:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010231e:	66 90                	xchg   %ax,%ax
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102320:	6a 10                	push   $0x10
80102322:	57                   	push   %edi
80102323:	56                   	push   %esi
80102324:	53                   	push   %ebx
80102325:	e8 76 fd ff ff       	call   801020a0 <readi>
8010232a:	83 c4 10             	add    $0x10,%esp
8010232d:	83 f8 10             	cmp    $0x10,%eax
80102330:	75 55                	jne    80102387 <dirlookup+0x97>
      panic("dirlookup read");
    if(de.inum == 0)
80102332:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80102337:	74 18                	je     80102351 <dirlookup+0x61>
  return strncmp(s, t, DIRSIZ);
80102339:	83 ec 04             	sub    $0x4,%esp
8010233c:	8d 45 da             	lea    -0x26(%ebp),%eax
8010233f:	6a 0e                	push   $0xe
80102341:	50                   	push   %eax
80102342:	ff 75 0c             	pushl  0xc(%ebp)
80102345:	e8 56 2b 00 00       	call   80104ea0 <strncmp>
      continue;
    if(namecmp(name, de.name) == 0){
8010234a:	83 c4 10             	add    $0x10,%esp
8010234d:	85 c0                	test   %eax,%eax
8010234f:	74 17                	je     80102368 <dirlookup+0x78>
  for(off = 0; off < dp->size; off += sizeof(de)){
80102351:	83 c7 10             	add    $0x10,%edi
80102354:	3b 7b 58             	cmp    0x58(%ebx),%edi
80102357:	72 c7                	jb     80102320 <dirlookup+0x30>
      return iget(dp->dev, inum);
    }
  }

  return 0;
}
80102359:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010235c:	31 c0                	xor    %eax,%eax
}
8010235e:	5b                   	pop    %ebx
8010235f:	5e                   	pop    %esi
80102360:	5f                   	pop    %edi
80102361:	5d                   	pop    %ebp
80102362:	c3                   	ret    
80102363:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102367:	90                   	nop
      if(poff)
80102368:	8b 45 10             	mov    0x10(%ebp),%eax
8010236b:	85 c0                	test   %eax,%eax
8010236d:	74 05                	je     80102374 <dirlookup+0x84>
        *poff = off;
8010236f:	8b 45 10             	mov    0x10(%ebp),%eax
80102372:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
80102374:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
      return iget(dp->dev, inum);
80102378:	8b 03                	mov    (%ebx),%eax
8010237a:	e8 01 f6 ff ff       	call   80101980 <iget>
}
8010237f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102382:	5b                   	pop    %ebx
80102383:	5e                   	pop    %esi
80102384:	5f                   	pop    %edi
80102385:	5d                   	pop    %ebp
80102386:	c3                   	ret    
      panic("dirlookup read");
80102387:	83 ec 0c             	sub    $0xc,%esp
8010238a:	68 b1 7a 10 80       	push   $0x80107ab1
8010238f:	e8 1c e0 ff ff       	call   801003b0 <panic>
    panic("dirlookup not DIR");
80102394:	83 ec 0c             	sub    $0xc,%esp
80102397:	68 9f 7a 10 80       	push   $0x80107a9f
8010239c:	e8 0f e0 ff ff       	call   801003b0 <panic>
801023a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801023a8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801023af:	90                   	nop

801023b0 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
801023b0:	55                   	push   %ebp
801023b1:	89 e5                	mov    %esp,%ebp
801023b3:	57                   	push   %edi
801023b4:	56                   	push   %esi
801023b5:	53                   	push   %ebx
801023b6:	89 c3                	mov    %eax,%ebx
801023b8:	83 ec 1c             	sub    $0x1c,%esp
  struct inode *ip, *next;

  if(*path == '/')
801023bb:	80 38 2f             	cmpb   $0x2f,(%eax)
{
801023be:	89 55 e0             	mov    %edx,-0x20(%ebp)
801023c1:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  if(*path == '/')
801023c4:	0f 84 86 01 00 00    	je     80102550 <namex+0x1a0>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
801023ca:	e8 d1 1b 00 00       	call   80103fa0 <myproc>
  acquire(&icache.lock);
801023cf:	83 ec 0c             	sub    $0xc,%esp
801023d2:	89 df                	mov    %ebx,%edi
    ip = idup(myproc()->cwd);
801023d4:	8b 70 68             	mov    0x68(%eax),%esi
  acquire(&icache.lock);
801023d7:	68 20 26 11 80       	push   $0x80112620
801023dc:	e8 9f 28 00 00       	call   80104c80 <acquire>
  ip->ref++;
801023e1:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
801023e5:	c7 04 24 20 26 11 80 	movl   $0x80112620,(%esp)
801023ec:	e8 4f 29 00 00       	call   80104d40 <release>
801023f1:	83 c4 10             	add    $0x10,%esp
801023f4:	eb 0d                	jmp    80102403 <namex+0x53>
801023f6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801023fd:	8d 76 00             	lea    0x0(%esi),%esi
    path++;
80102400:	83 c7 01             	add    $0x1,%edi
  while(*path == '/')
80102403:	0f b6 07             	movzbl (%edi),%eax
80102406:	3c 2f                	cmp    $0x2f,%al
80102408:	74 f6                	je     80102400 <namex+0x50>
  if(*path == 0)
8010240a:	84 c0                	test   %al,%al
8010240c:	0f 84 ee 00 00 00    	je     80102500 <namex+0x150>
  while(*path != '/' && *path != 0)
80102412:	0f b6 07             	movzbl (%edi),%eax
80102415:	84 c0                	test   %al,%al
80102417:	0f 84 fb 00 00 00    	je     80102518 <namex+0x168>
8010241d:	89 fb                	mov    %edi,%ebx
8010241f:	3c 2f                	cmp    $0x2f,%al
80102421:	0f 84 f1 00 00 00    	je     80102518 <namex+0x168>
80102427:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010242e:	66 90                	xchg   %ax,%ax
80102430:	0f b6 43 01          	movzbl 0x1(%ebx),%eax
    path++;
80102434:	83 c3 01             	add    $0x1,%ebx
  while(*path != '/' && *path != 0)
80102437:	3c 2f                	cmp    $0x2f,%al
80102439:	74 04                	je     8010243f <namex+0x8f>
8010243b:	84 c0                	test   %al,%al
8010243d:	75 f1                	jne    80102430 <namex+0x80>
  len = path - s;
8010243f:	89 d8                	mov    %ebx,%eax
80102441:	29 f8                	sub    %edi,%eax
  if(len >= DIRSIZ)
80102443:	83 f8 0d             	cmp    $0xd,%eax
80102446:	0f 8e 84 00 00 00    	jle    801024d0 <namex+0x120>
    memmove(name, s, DIRSIZ);
8010244c:	83 ec 04             	sub    $0x4,%esp
8010244f:	6a 0e                	push   $0xe
80102451:	57                   	push   %edi
    path++;
80102452:	89 df                	mov    %ebx,%edi
    memmove(name, s, DIRSIZ);
80102454:	ff 75 e4             	pushl  -0x1c(%ebp)
80102457:	e8 d4 29 00 00       	call   80104e30 <memmove>
8010245c:	83 c4 10             	add    $0x10,%esp
  while(*path == '/')
8010245f:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80102462:	75 0c                	jne    80102470 <namex+0xc0>
80102464:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
80102468:	83 c7 01             	add    $0x1,%edi
  while(*path == '/')
8010246b:	80 3f 2f             	cmpb   $0x2f,(%edi)
8010246e:	74 f8                	je     80102468 <namex+0xb8>

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
80102470:	83 ec 0c             	sub    $0xc,%esp
80102473:	56                   	push   %esi
80102474:	e8 27 f9 ff ff       	call   80101da0 <ilock>
    if(ip->type != T_DIR){
80102479:	83 c4 10             	add    $0x10,%esp
8010247c:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80102481:	0f 85 a1 00 00 00    	jne    80102528 <namex+0x178>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80102487:	8b 55 e0             	mov    -0x20(%ebp),%edx
8010248a:	85 d2                	test   %edx,%edx
8010248c:	74 09                	je     80102497 <namex+0xe7>
8010248e:	80 3f 00             	cmpb   $0x0,(%edi)
80102491:	0f 84 d9 00 00 00    	je     80102570 <namex+0x1c0>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80102497:	83 ec 04             	sub    $0x4,%esp
8010249a:	6a 00                	push   $0x0
8010249c:	ff 75 e4             	pushl  -0x1c(%ebp)
8010249f:	56                   	push   %esi
801024a0:	e8 4b fe ff ff       	call   801022f0 <dirlookup>
801024a5:	83 c4 10             	add    $0x10,%esp
801024a8:	89 c3                	mov    %eax,%ebx
801024aa:	85 c0                	test   %eax,%eax
801024ac:	74 7a                	je     80102528 <namex+0x178>
  iunlock(ip);
801024ae:	83 ec 0c             	sub    $0xc,%esp
801024b1:	56                   	push   %esi
801024b2:	e8 c9 f9 ff ff       	call   80101e80 <iunlock>
  iput(ip);
801024b7:	89 34 24             	mov    %esi,(%esp)
801024ba:	89 de                	mov    %ebx,%esi
801024bc:	e8 0f fa ff ff       	call   80101ed0 <iput>
801024c1:	83 c4 10             	add    $0x10,%esp
801024c4:	e9 3a ff ff ff       	jmp    80102403 <namex+0x53>
801024c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801024d0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801024d3:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
801024d6:	89 4d dc             	mov    %ecx,-0x24(%ebp)
    memmove(name, s, len);
801024d9:	83 ec 04             	sub    $0x4,%esp
801024dc:	50                   	push   %eax
801024dd:	57                   	push   %edi
    name[len] = 0;
801024de:	89 df                	mov    %ebx,%edi
    memmove(name, s, len);
801024e0:	ff 75 e4             	pushl  -0x1c(%ebp)
801024e3:	e8 48 29 00 00       	call   80104e30 <memmove>
    name[len] = 0;
801024e8:	8b 45 dc             	mov    -0x24(%ebp),%eax
801024eb:	83 c4 10             	add    $0x10,%esp
801024ee:	c6 00 00             	movb   $0x0,(%eax)
801024f1:	e9 69 ff ff ff       	jmp    8010245f <namex+0xaf>
801024f6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801024fd:	8d 76 00             	lea    0x0(%esi),%esi
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
80102500:	8b 45 e0             	mov    -0x20(%ebp),%eax
80102503:	85 c0                	test   %eax,%eax
80102505:	0f 85 85 00 00 00    	jne    80102590 <namex+0x1e0>
    iput(ip);
    return 0;
  }
  return ip;
}
8010250b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010250e:	89 f0                	mov    %esi,%eax
80102510:	5b                   	pop    %ebx
80102511:	5e                   	pop    %esi
80102512:	5f                   	pop    %edi
80102513:	5d                   	pop    %ebp
80102514:	c3                   	ret    
80102515:	8d 76 00             	lea    0x0(%esi),%esi
  while(*path != '/' && *path != 0)
80102518:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010251b:	89 fb                	mov    %edi,%ebx
8010251d:	89 45 dc             	mov    %eax,-0x24(%ebp)
80102520:	31 c0                	xor    %eax,%eax
80102522:	eb b5                	jmp    801024d9 <namex+0x129>
80102524:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  iunlock(ip);
80102528:	83 ec 0c             	sub    $0xc,%esp
8010252b:	56                   	push   %esi
8010252c:	e8 4f f9 ff ff       	call   80101e80 <iunlock>
  iput(ip);
80102531:	89 34 24             	mov    %esi,(%esp)
      return 0;
80102534:	31 f6                	xor    %esi,%esi
  iput(ip);
80102536:	e8 95 f9 ff ff       	call   80101ed0 <iput>
      return 0;
8010253b:	83 c4 10             	add    $0x10,%esp
}
8010253e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102541:	89 f0                	mov    %esi,%eax
80102543:	5b                   	pop    %ebx
80102544:	5e                   	pop    %esi
80102545:	5f                   	pop    %edi
80102546:	5d                   	pop    %ebp
80102547:	c3                   	ret    
80102548:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010254f:	90                   	nop
    ip = iget(ROOTDEV, ROOTINO);
80102550:	ba 01 00 00 00       	mov    $0x1,%edx
80102555:	b8 01 00 00 00       	mov    $0x1,%eax
8010255a:	89 df                	mov    %ebx,%edi
8010255c:	e8 1f f4 ff ff       	call   80101980 <iget>
80102561:	89 c6                	mov    %eax,%esi
80102563:	e9 9b fe ff ff       	jmp    80102403 <namex+0x53>
80102568:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010256f:	90                   	nop
      iunlock(ip);
80102570:	83 ec 0c             	sub    $0xc,%esp
80102573:	56                   	push   %esi
80102574:	e8 07 f9 ff ff       	call   80101e80 <iunlock>
      return ip;
80102579:	83 c4 10             	add    $0x10,%esp
}
8010257c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010257f:	89 f0                	mov    %esi,%eax
80102581:	5b                   	pop    %ebx
80102582:	5e                   	pop    %esi
80102583:	5f                   	pop    %edi
80102584:	5d                   	pop    %ebp
80102585:	c3                   	ret    
80102586:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010258d:	8d 76 00             	lea    0x0(%esi),%esi
    iput(ip);
80102590:	83 ec 0c             	sub    $0xc,%esp
80102593:	56                   	push   %esi
    return 0;
80102594:	31 f6                	xor    %esi,%esi
    iput(ip);
80102596:	e8 35 f9 ff ff       	call   80101ed0 <iput>
    return 0;
8010259b:	83 c4 10             	add    $0x10,%esp
8010259e:	e9 68 ff ff ff       	jmp    8010250b <namex+0x15b>
801025a3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801025aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801025b0 <dirlink>:
{
801025b0:	f3 0f 1e fb          	endbr32 
801025b4:	55                   	push   %ebp
801025b5:	89 e5                	mov    %esp,%ebp
801025b7:	57                   	push   %edi
801025b8:	56                   	push   %esi
801025b9:	53                   	push   %ebx
801025ba:	83 ec 20             	sub    $0x20,%esp
801025bd:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((ip = dirlookup(dp, name, 0)) != 0){
801025c0:	6a 00                	push   $0x0
801025c2:	ff 75 0c             	pushl  0xc(%ebp)
801025c5:	53                   	push   %ebx
801025c6:	e8 25 fd ff ff       	call   801022f0 <dirlookup>
801025cb:	83 c4 10             	add    $0x10,%esp
801025ce:	85 c0                	test   %eax,%eax
801025d0:	75 6b                	jne    8010263d <dirlink+0x8d>
  for(off = 0; off < dp->size; off += sizeof(de)){
801025d2:	8b 7b 58             	mov    0x58(%ebx),%edi
801025d5:	8d 75 d8             	lea    -0x28(%ebp),%esi
801025d8:	85 ff                	test   %edi,%edi
801025da:	74 2d                	je     80102609 <dirlink+0x59>
801025dc:	31 ff                	xor    %edi,%edi
801025de:	8d 75 d8             	lea    -0x28(%ebp),%esi
801025e1:	eb 0d                	jmp    801025f0 <dirlink+0x40>
801025e3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801025e7:	90                   	nop
801025e8:	83 c7 10             	add    $0x10,%edi
801025eb:	3b 7b 58             	cmp    0x58(%ebx),%edi
801025ee:	73 19                	jae    80102609 <dirlink+0x59>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801025f0:	6a 10                	push   $0x10
801025f2:	57                   	push   %edi
801025f3:	56                   	push   %esi
801025f4:	53                   	push   %ebx
801025f5:	e8 a6 fa ff ff       	call   801020a0 <readi>
801025fa:	83 c4 10             	add    $0x10,%esp
801025fd:	83 f8 10             	cmp    $0x10,%eax
80102600:	75 4e                	jne    80102650 <dirlink+0xa0>
    if(de.inum == 0)
80102602:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80102607:	75 df                	jne    801025e8 <dirlink+0x38>
  strncpy(de.name, name, DIRSIZ);
80102609:	83 ec 04             	sub    $0x4,%esp
8010260c:	8d 45 da             	lea    -0x26(%ebp),%eax
8010260f:	6a 0e                	push   $0xe
80102611:	ff 75 0c             	pushl  0xc(%ebp)
80102614:	50                   	push   %eax
80102615:	e8 d6 28 00 00       	call   80104ef0 <strncpy>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
8010261a:	6a 10                	push   $0x10
  de.inum = inum;
8010261c:	8b 45 10             	mov    0x10(%ebp),%eax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
8010261f:	57                   	push   %edi
80102620:	56                   	push   %esi
80102621:	53                   	push   %ebx
  de.inum = inum;
80102622:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102626:	e8 75 fb ff ff       	call   801021a0 <writei>
8010262b:	83 c4 20             	add    $0x20,%esp
8010262e:	83 f8 10             	cmp    $0x10,%eax
80102631:	75 2a                	jne    8010265d <dirlink+0xad>
  return 0;
80102633:	31 c0                	xor    %eax,%eax
}
80102635:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102638:	5b                   	pop    %ebx
80102639:	5e                   	pop    %esi
8010263a:	5f                   	pop    %edi
8010263b:	5d                   	pop    %ebp
8010263c:	c3                   	ret    
    iput(ip);
8010263d:	83 ec 0c             	sub    $0xc,%esp
80102640:	50                   	push   %eax
80102641:	e8 8a f8 ff ff       	call   80101ed0 <iput>
    return -1;
80102646:	83 c4 10             	add    $0x10,%esp
80102649:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010264e:	eb e5                	jmp    80102635 <dirlink+0x85>
      panic("dirlink read");
80102650:	83 ec 0c             	sub    $0xc,%esp
80102653:	68 c0 7a 10 80       	push   $0x80107ac0
80102658:	e8 53 dd ff ff       	call   801003b0 <panic>
    panic("dirlink");
8010265d:	83 ec 0c             	sub    $0xc,%esp
80102660:	68 ee 80 10 80       	push   $0x801080ee
80102665:	e8 46 dd ff ff       	call   801003b0 <panic>
8010266a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102670 <namei>:

struct inode*
namei(char *path)
{
80102670:	f3 0f 1e fb          	endbr32 
80102674:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
80102675:	31 d2                	xor    %edx,%edx
{
80102677:	89 e5                	mov    %esp,%ebp
80102679:	83 ec 18             	sub    $0x18,%esp
  return namex(path, 0, name);
8010267c:	8b 45 08             	mov    0x8(%ebp),%eax
8010267f:	8d 4d ea             	lea    -0x16(%ebp),%ecx
80102682:	e8 29 fd ff ff       	call   801023b0 <namex>
}
80102687:	c9                   	leave  
80102688:	c3                   	ret    
80102689:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102690 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80102690:	f3 0f 1e fb          	endbr32 
80102694:	55                   	push   %ebp
  return namex(path, 1, name);
80102695:	ba 01 00 00 00       	mov    $0x1,%edx
{
8010269a:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
8010269c:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010269f:	8b 45 08             	mov    0x8(%ebp),%eax
}
801026a2:	5d                   	pop    %ebp
  return namex(path, 1, name);
801026a3:	e9 08 fd ff ff       	jmp    801023b0 <namex>
801026a8:	66 90                	xchg   %ax,%ax
801026aa:	66 90                	xchg   %ax,%ax
801026ac:	66 90                	xchg   %ax,%ax
801026ae:	66 90                	xchg   %ax,%ax

801026b0 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
801026b0:	55                   	push   %ebp
801026b1:	89 e5                	mov    %esp,%ebp
801026b3:	57                   	push   %edi
801026b4:	56                   	push   %esi
801026b5:	53                   	push   %ebx
801026b6:	83 ec 0c             	sub    $0xc,%esp
  if(b == 0)
801026b9:	85 c0                	test   %eax,%eax
801026bb:	0f 84 b4 00 00 00    	je     80102775 <idestart+0xc5>
    panic("idestart");
  if(b->blockno >= FSSIZE)
801026c1:	8b 70 08             	mov    0x8(%eax),%esi
801026c4:	89 c3                	mov    %eax,%ebx
801026c6:	81 fe e7 03 00 00    	cmp    $0x3e7,%esi
801026cc:	0f 87 96 00 00 00    	ja     80102768 <idestart+0xb8>
  asm volatile("in %1,%0" : "=a"(data) : "d"(port));
801026d2:	b9 f7 01 00 00       	mov    $0x1f7,%ecx
801026d7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801026de:	66 90                	xchg   %ax,%ax
801026e0:	89 ca                	mov    %ecx,%edx
801026e2:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
801026e3:	83 e0 c0             	and    $0xffffffc0,%eax
801026e6:	3c 40                	cmp    $0x40,%al
801026e8:	75 f6                	jne    801026e0 <idestart+0x30>
  asm volatile("out %0,%1" : : "a"(data), "d"(port));
801026ea:	31 ff                	xor    %edi,%edi
801026ec:	ba f6 03 00 00       	mov    $0x3f6,%edx
801026f1:	89 f8                	mov    %edi,%eax
801026f3:	ee                   	out    %al,(%dx)
801026f4:	b8 01 00 00 00       	mov    $0x1,%eax
801026f9:	ba f2 01 00 00       	mov    $0x1f2,%edx
801026fe:	ee                   	out    %al,(%dx)
801026ff:	ba f3 01 00 00       	mov    $0x1f3,%edx
80102704:	89 f0                	mov    %esi,%eax
80102706:	ee                   	out    %al,(%dx)

  idewait(0);
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
80102707:	89 f0                	mov    %esi,%eax
80102709:	ba f4 01 00 00       	mov    $0x1f4,%edx
8010270e:	c1 f8 08             	sar    $0x8,%eax
80102711:	ee                   	out    %al,(%dx)
80102712:	ba f5 01 00 00       	mov    $0x1f5,%edx
80102717:	89 f8                	mov    %edi,%eax
80102719:	ee                   	out    %al,(%dx)
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
8010271a:	0f b6 43 04          	movzbl 0x4(%ebx),%eax
8010271e:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102723:	c1 e0 04             	shl    $0x4,%eax
80102726:	83 e0 10             	and    $0x10,%eax
80102729:	83 c8 e0             	or     $0xffffffe0,%eax
8010272c:	ee                   	out    %al,(%dx)
  if(b->flags & B_DIRTY){
8010272d:	f6 03 04             	testb  $0x4,(%ebx)
80102730:	75 16                	jne    80102748 <idestart+0x98>
80102732:	b8 20 00 00 00       	mov    $0x20,%eax
80102737:	89 ca                	mov    %ecx,%edx
80102739:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
8010273a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010273d:	5b                   	pop    %ebx
8010273e:	5e                   	pop    %esi
8010273f:	5f                   	pop    %edi
80102740:	5d                   	pop    %ebp
80102741:	c3                   	ret    
80102742:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102748:	b8 30 00 00 00       	mov    $0x30,%eax
8010274d:	89 ca                	mov    %ecx,%edx
8010274f:	ee                   	out    %al,(%dx)
  asm volatile("cld; rep outsl" : "=S"(addr), "=c"(cnt) : "d"(port), "0"(addr), "1"(cnt) : "cc");
80102750:	b9 80 00 00 00       	mov    $0x80,%ecx
    outsl(0x1f0, b->data, BSIZE/4);
80102755:	8d 73 5c             	lea    0x5c(%ebx),%esi
80102758:	ba f0 01 00 00       	mov    $0x1f0,%edx
8010275d:	fc                   	cld    
8010275e:	f3 6f                	rep outsl %ds:(%esi),(%dx)
}
80102760:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102763:	5b                   	pop    %ebx
80102764:	5e                   	pop    %esi
80102765:	5f                   	pop    %edi
80102766:	5d                   	pop    %ebp
80102767:	c3                   	ret    
    panic("incorrect blockno");
80102768:	83 ec 0c             	sub    $0xc,%esp
8010276b:	68 2c 7b 10 80       	push   $0x80107b2c
80102770:	e8 3b dc ff ff       	call   801003b0 <panic>
    panic("idestart");
80102775:	83 ec 0c             	sub    $0xc,%esp
80102778:	68 23 7b 10 80       	push   $0x80107b23
8010277d:	e8 2e dc ff ff       	call   801003b0 <panic>
80102782:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102789:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102790 <ideinit>:
{
80102790:	f3 0f 1e fb          	endbr32 
80102794:	55                   	push   %ebp
80102795:	89 e5                	mov    %esp,%ebp
80102797:	83 ec 10             	sub    $0x10,%esp
  initlock(&idelock, "ide");
8010279a:	68 3e 7b 10 80       	push   $0x80107b3e
8010279f:	68 00 c2 10 80       	push   $0x8010c200
801027a4:	e8 57 23 00 00       	call   80104b00 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
801027a9:	58                   	pop    %eax
801027aa:	a1 40 49 11 80       	mov    0x80114940,%eax
801027af:	5a                   	pop    %edx
801027b0:	83 e8 01             	sub    $0x1,%eax
801027b3:	50                   	push   %eax
801027b4:	6a 0e                	push   $0xe
801027b6:	e8 b5 02 00 00       	call   80102a70 <ioapicenable>
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
801027bb:	83 c4 10             	add    $0x10,%esp
  asm volatile("in %1,%0" : "=a"(data) : "d"(port));
801027be:	ba f7 01 00 00       	mov    $0x1f7,%edx
801027c3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801027c7:	90                   	nop
801027c8:	ec                   	in     (%dx),%al
801027c9:	83 e0 c0             	and    $0xffffffc0,%eax
801027cc:	3c 40                	cmp    $0x40,%al
801027ce:	75 f8                	jne    801027c8 <ideinit+0x38>
  asm volatile("out %0,%1" : : "a"(data), "d"(port));
801027d0:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
801027d5:	ba f6 01 00 00       	mov    $0x1f6,%edx
801027da:	ee                   	out    %al,(%dx)
801027db:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
  asm volatile("in %1,%0" : "=a"(data) : "d"(port));
801027e0:	ba f7 01 00 00       	mov    $0x1f7,%edx
801027e5:	eb 0e                	jmp    801027f5 <ideinit+0x65>
801027e7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801027ee:	66 90                	xchg   %ax,%ax
  for(i=0; i<1000; i++){
801027f0:	83 e9 01             	sub    $0x1,%ecx
801027f3:	74 0f                	je     80102804 <ideinit+0x74>
801027f5:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
801027f6:	84 c0                	test   %al,%al
801027f8:	74 f6                	je     801027f0 <ideinit+0x60>
      havedisk1 = 1;
801027fa:	c7 05 e0 c1 10 80 01 	movl   $0x1,0x8010c1e0
80102801:	00 00 00 
  asm volatile("out %0,%1" : : "a"(data), "d"(port));
80102804:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
80102809:	ba f6 01 00 00       	mov    $0x1f6,%edx
8010280e:	ee                   	out    %al,(%dx)
}
8010280f:	c9                   	leave  
80102810:	c3                   	ret    
80102811:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102818:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010281f:	90                   	nop

80102820 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
80102820:	f3 0f 1e fb          	endbr32 
80102824:	55                   	push   %ebp
80102825:	89 e5                	mov    %esp,%ebp
80102827:	57                   	push   %edi
80102828:	56                   	push   %esi
80102829:	53                   	push   %ebx
8010282a:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
8010282d:	68 00 c2 10 80       	push   $0x8010c200
80102832:	e8 49 24 00 00       	call   80104c80 <acquire>

  if((b = idequeue) == 0){
80102837:	8b 1d e4 c1 10 80    	mov    0x8010c1e4,%ebx
8010283d:	83 c4 10             	add    $0x10,%esp
80102840:	85 db                	test   %ebx,%ebx
80102842:	74 5f                	je     801028a3 <ideintr+0x83>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
80102844:	8b 43 58             	mov    0x58(%ebx),%eax
80102847:	a3 e4 c1 10 80       	mov    %eax,0x8010c1e4

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
8010284c:	8b 33                	mov    (%ebx),%esi
8010284e:	f7 c6 04 00 00 00    	test   $0x4,%esi
80102854:	75 2b                	jne    80102881 <ideintr+0x61>
  asm volatile("in %1,%0" : "=a"(data) : "d"(port));
80102856:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010285b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010285f:	90                   	nop
80102860:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102861:	89 c1                	mov    %eax,%ecx
80102863:	83 e1 c0             	and    $0xffffffc0,%ecx
80102866:	80 f9 40             	cmp    $0x40,%cl
80102869:	75 f5                	jne    80102860 <ideintr+0x40>
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
8010286b:	a8 21                	test   $0x21,%al
8010286d:	75 12                	jne    80102881 <ideintr+0x61>
    insl(0x1f0, b->data, BSIZE/4);
8010286f:	8d 7b 5c             	lea    0x5c(%ebx),%edi
  asm volatile("cld; rep insl" : "=D"(addr), "=c"(cnt) : "d"(port), "0"(addr), "1"(cnt) : "memory", "cc");
80102872:	b9 80 00 00 00       	mov    $0x80,%ecx
80102877:	ba f0 01 00 00       	mov    $0x1f0,%edx
8010287c:	fc                   	cld    
8010287d:	f3 6d                	rep insl (%dx),%es:(%edi)
8010287f:	8b 33                	mov    (%ebx),%esi

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
80102881:	83 e6 fb             	and    $0xfffffffb,%esi
  wakeup(b);
80102884:	83 ec 0c             	sub    $0xc,%esp
  b->flags &= ~B_DIRTY;
80102887:	83 ce 02             	or     $0x2,%esi
8010288a:	89 33                	mov    %esi,(%ebx)
  wakeup(b);
8010288c:	53                   	push   %ebx
8010288d:	e8 be 1e 00 00       	call   80104750 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
80102892:	a1 e4 c1 10 80       	mov    0x8010c1e4,%eax
80102897:	83 c4 10             	add    $0x10,%esp
8010289a:	85 c0                	test   %eax,%eax
8010289c:	74 05                	je     801028a3 <ideintr+0x83>
    idestart(idequeue);
8010289e:	e8 0d fe ff ff       	call   801026b0 <idestart>
    release(&idelock);
801028a3:	83 ec 0c             	sub    $0xc,%esp
801028a6:	68 00 c2 10 80       	push   $0x8010c200
801028ab:	e8 90 24 00 00       	call   80104d40 <release>

  release(&idelock);
}
801028b0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801028b3:	5b                   	pop    %ebx
801028b4:	5e                   	pop    %esi
801028b5:	5f                   	pop    %edi
801028b6:	5d                   	pop    %ebp
801028b7:	c3                   	ret    
801028b8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801028bf:	90                   	nop

801028c0 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
801028c0:	f3 0f 1e fb          	endbr32 
801028c4:	55                   	push   %ebp
801028c5:	89 e5                	mov    %esp,%ebp
801028c7:	53                   	push   %ebx
801028c8:	83 ec 10             	sub    $0x10,%esp
801028cb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
801028ce:	8d 43 0c             	lea    0xc(%ebx),%eax
801028d1:	50                   	push   %eax
801028d2:	e8 c9 21 00 00       	call   80104aa0 <holdingsleep>
801028d7:	83 c4 10             	add    $0x10,%esp
801028da:	85 c0                	test   %eax,%eax
801028dc:	0f 84 cf 00 00 00    	je     801029b1 <iderw+0xf1>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
801028e2:	8b 03                	mov    (%ebx),%eax
801028e4:	83 e0 06             	and    $0x6,%eax
801028e7:	83 f8 02             	cmp    $0x2,%eax
801028ea:	0f 84 b4 00 00 00    	je     801029a4 <iderw+0xe4>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
801028f0:	8b 53 04             	mov    0x4(%ebx),%edx
801028f3:	85 d2                	test   %edx,%edx
801028f5:	74 0d                	je     80102904 <iderw+0x44>
801028f7:	a1 e0 c1 10 80       	mov    0x8010c1e0,%eax
801028fc:	85 c0                	test   %eax,%eax
801028fe:	0f 84 93 00 00 00    	je     80102997 <iderw+0xd7>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
80102904:	83 ec 0c             	sub    $0xc,%esp
80102907:	68 00 c2 10 80       	push   $0x8010c200
8010290c:	e8 6f 23 00 00       	call   80104c80 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102911:	a1 e4 c1 10 80       	mov    0x8010c1e4,%eax
  b->qnext = 0;
80102916:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010291d:	83 c4 10             	add    $0x10,%esp
80102920:	85 c0                	test   %eax,%eax
80102922:	74 6c                	je     80102990 <iderw+0xd0>
80102924:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102928:	89 c2                	mov    %eax,%edx
8010292a:	8b 40 58             	mov    0x58(%eax),%eax
8010292d:	85 c0                	test   %eax,%eax
8010292f:	75 f7                	jne    80102928 <iderw+0x68>
80102931:	83 c2 58             	add    $0x58,%edx
    ;
  *pp = b;
80102934:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
80102936:	39 1d e4 c1 10 80    	cmp    %ebx,0x8010c1e4
8010293c:	74 42                	je     80102980 <iderw+0xc0>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
8010293e:	8b 03                	mov    (%ebx),%eax
80102940:	83 e0 06             	and    $0x6,%eax
80102943:	83 f8 02             	cmp    $0x2,%eax
80102946:	74 23                	je     8010296b <iderw+0xab>
80102948:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010294f:	90                   	nop
    sleep(b, &idelock);
80102950:	83 ec 08             	sub    $0x8,%esp
80102953:	68 00 c2 10 80       	push   $0x8010c200
80102958:	53                   	push   %ebx
80102959:	e8 32 1c 00 00       	call   80104590 <sleep>
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
8010295e:	8b 03                	mov    (%ebx),%eax
80102960:	83 c4 10             	add    $0x10,%esp
80102963:	83 e0 06             	and    $0x6,%eax
80102966:	83 f8 02             	cmp    $0x2,%eax
80102969:	75 e5                	jne    80102950 <iderw+0x90>
  }


  release(&idelock);
8010296b:	c7 45 08 00 c2 10 80 	movl   $0x8010c200,0x8(%ebp)
}
80102972:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102975:	c9                   	leave  
  release(&idelock);
80102976:	e9 c5 23 00 00       	jmp    80104d40 <release>
8010297b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010297f:	90                   	nop
    idestart(b);
80102980:	89 d8                	mov    %ebx,%eax
80102982:	e8 29 fd ff ff       	call   801026b0 <idestart>
80102987:	eb b5                	jmp    8010293e <iderw+0x7e>
80102989:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102990:	ba e4 c1 10 80       	mov    $0x8010c1e4,%edx
80102995:	eb 9d                	jmp    80102934 <iderw+0x74>
    panic("iderw: ide disk 1 not present");
80102997:	83 ec 0c             	sub    $0xc,%esp
8010299a:	68 6d 7b 10 80       	push   $0x80107b6d
8010299f:	e8 0c da ff ff       	call   801003b0 <panic>
    panic("iderw: nothing to do");
801029a4:	83 ec 0c             	sub    $0xc,%esp
801029a7:	68 58 7b 10 80       	push   $0x80107b58
801029ac:	e8 ff d9 ff ff       	call   801003b0 <panic>
    panic("iderw: buf not locked");
801029b1:	83 ec 0c             	sub    $0xc,%esp
801029b4:	68 42 7b 10 80       	push   $0x80107b42
801029b9:	e8 f2 d9 ff ff       	call   801003b0 <panic>
801029be:	66 90                	xchg   %ax,%ax

801029c0 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
801029c0:	f3 0f 1e fb          	endbr32 
801029c4:	55                   	push   %ebp
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
801029c5:	c7 05 74 42 11 80 00 	movl   $0xfec00000,0x80114274
801029cc:	00 c0 fe 
{
801029cf:	89 e5                	mov    %esp,%ebp
801029d1:	56                   	push   %esi
801029d2:	53                   	push   %ebx
  ioapic->reg = reg;
801029d3:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
801029da:	00 00 00 
  return ioapic->data;
801029dd:	8b 15 74 42 11 80    	mov    0x80114274,%edx
801029e3:	8b 72 10             	mov    0x10(%edx),%esi
  ioapic->reg = reg;
801029e6:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
  return ioapic->data;
801029ec:	8b 0d 74 42 11 80    	mov    0x80114274,%ecx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
801029f2:	0f b6 15 a0 43 11 80 	movzbl 0x801143a0,%edx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
801029f9:	c1 ee 10             	shr    $0x10,%esi
801029fc:	89 f0                	mov    %esi,%eax
801029fe:	0f b6 f0             	movzbl %al,%esi
  return ioapic->data;
80102a01:	8b 41 10             	mov    0x10(%ecx),%eax
  id = ioapicread(REG_ID) >> 24;
80102a04:	c1 e8 18             	shr    $0x18,%eax
  if(id != ioapicid)
80102a07:	39 c2                	cmp    %eax,%edx
80102a09:	74 16                	je     80102a21 <ioapicinit+0x61>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
80102a0b:	83 ec 0c             	sub    $0xc,%esp
80102a0e:	68 8c 7b 10 80       	push   $0x80107b8c
80102a13:	e8 88 dd ff ff       	call   801007a0 <cprintf>
80102a18:	8b 0d 74 42 11 80    	mov    0x80114274,%ecx
80102a1e:	83 c4 10             	add    $0x10,%esp
80102a21:	83 c6 21             	add    $0x21,%esi
{
80102a24:	ba 10 00 00 00       	mov    $0x10,%edx
80102a29:	b8 20 00 00 00       	mov    $0x20,%eax
80102a2e:	66 90                	xchg   %ax,%ax
  ioapic->reg = reg;
80102a30:	89 11                	mov    %edx,(%ecx)

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
80102a32:	89 c3                	mov    %eax,%ebx
  ioapic->data = data;
80102a34:	8b 0d 74 42 11 80    	mov    0x80114274,%ecx
80102a3a:	83 c0 01             	add    $0x1,%eax
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
80102a3d:	81 cb 00 00 01 00    	or     $0x10000,%ebx
  ioapic->data = data;
80102a43:	89 59 10             	mov    %ebx,0x10(%ecx)
  ioapic->reg = reg;
80102a46:	8d 5a 01             	lea    0x1(%edx),%ebx
80102a49:	83 c2 02             	add    $0x2,%edx
80102a4c:	89 19                	mov    %ebx,(%ecx)
  ioapic->data = data;
80102a4e:	8b 0d 74 42 11 80    	mov    0x80114274,%ecx
80102a54:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
  for(i = 0; i <= maxintr; i++){
80102a5b:	39 f0                	cmp    %esi,%eax
80102a5d:	75 d1                	jne    80102a30 <ioapicinit+0x70>
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
80102a5f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102a62:	5b                   	pop    %ebx
80102a63:	5e                   	pop    %esi
80102a64:	5d                   	pop    %ebp
80102a65:	c3                   	ret    
80102a66:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102a6d:	8d 76 00             	lea    0x0(%esi),%esi

80102a70 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
80102a70:	f3 0f 1e fb          	endbr32 
80102a74:	55                   	push   %ebp
  ioapic->reg = reg;
80102a75:	8b 0d 74 42 11 80    	mov    0x80114274,%ecx
{
80102a7b:	89 e5                	mov    %esp,%ebp
80102a7d:	8b 45 08             	mov    0x8(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
80102a80:	8d 50 20             	lea    0x20(%eax),%edx
80102a83:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
  ioapic->reg = reg;
80102a87:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80102a89:	8b 0d 74 42 11 80    	mov    0x80114274,%ecx
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
80102a8f:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
80102a92:	89 51 10             	mov    %edx,0x10(%ecx)
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
80102a95:	8b 55 0c             	mov    0xc(%ebp),%edx
  ioapic->reg = reg;
80102a98:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80102a9a:	a1 74 42 11 80       	mov    0x80114274,%eax
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
80102a9f:	c1 e2 18             	shl    $0x18,%edx
  ioapic->data = data;
80102aa2:	89 50 10             	mov    %edx,0x10(%eax)
}
80102aa5:	5d                   	pop    %ebp
80102aa6:	c3                   	ret    
80102aa7:	66 90                	xchg   %ax,%ax
80102aa9:	66 90                	xchg   %ax,%ax
80102aab:	66 90                	xchg   %ax,%ax
80102aad:	66 90                	xchg   %ax,%ax
80102aaf:	90                   	nop

80102ab0 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
80102ab0:	f3 0f 1e fb          	endbr32 
80102ab4:	55                   	push   %ebp
80102ab5:	89 e5                	mov    %esp,%ebp
80102ab7:	53                   	push   %ebx
80102ab8:	83 ec 04             	sub    $0x4,%esp
80102abb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
80102abe:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
80102ac4:	75 7a                	jne    80102b40 <kfree+0x90>
80102ac6:	81 fb e8 71 11 80    	cmp    $0x801171e8,%ebx
80102acc:	72 72                	jb     80102b40 <kfree+0x90>
80102ace:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80102ad4:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80102ad9:	77 65                	ja     80102b40 <kfree+0x90>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
80102adb:	83 ec 04             	sub    $0x4,%esp
80102ade:	68 00 10 00 00       	push   $0x1000
80102ae3:	6a 01                	push   $0x1
80102ae5:	53                   	push   %ebx
80102ae6:	e8 a5 22 00 00       	call   80104d90 <memset>

  if(kmem.use_lock)
80102aeb:	8b 15 b4 42 11 80    	mov    0x801142b4,%edx
80102af1:	83 c4 10             	add    $0x10,%esp
80102af4:	85 d2                	test   %edx,%edx
80102af6:	75 20                	jne    80102b18 <kfree+0x68>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
80102af8:	a1 b8 42 11 80       	mov    0x801142b8,%eax
80102afd:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
80102aff:	a1 b4 42 11 80       	mov    0x801142b4,%eax
  kmem.freelist = r;
80102b04:	89 1d b8 42 11 80    	mov    %ebx,0x801142b8
  if(kmem.use_lock)
80102b0a:	85 c0                	test   %eax,%eax
80102b0c:	75 22                	jne    80102b30 <kfree+0x80>
    release(&kmem.lock);
}
80102b0e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102b11:	c9                   	leave  
80102b12:	c3                   	ret    
80102b13:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102b17:	90                   	nop
    acquire(&kmem.lock);
80102b18:	83 ec 0c             	sub    $0xc,%esp
80102b1b:	68 80 42 11 80       	push   $0x80114280
80102b20:	e8 5b 21 00 00       	call   80104c80 <acquire>
80102b25:	83 c4 10             	add    $0x10,%esp
80102b28:	eb ce                	jmp    80102af8 <kfree+0x48>
80102b2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    release(&kmem.lock);
80102b30:	c7 45 08 80 42 11 80 	movl   $0x80114280,0x8(%ebp)
}
80102b37:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102b3a:	c9                   	leave  
    release(&kmem.lock);
80102b3b:	e9 00 22 00 00       	jmp    80104d40 <release>
    panic("kfree");
80102b40:	83 ec 0c             	sub    $0xc,%esp
80102b43:	68 be 7b 10 80       	push   $0x80107bbe
80102b48:	e8 63 d8 ff ff       	call   801003b0 <panic>
80102b4d:	8d 76 00             	lea    0x0(%esi),%esi

80102b50 <freerange>:
{
80102b50:	f3 0f 1e fb          	endbr32 
80102b54:	55                   	push   %ebp
80102b55:	89 e5                	mov    %esp,%ebp
80102b57:	56                   	push   %esi
  p = (char*)PGROUNDUP((uint)vstart);
80102b58:	8b 45 08             	mov    0x8(%ebp),%eax
{
80102b5b:	8b 75 0c             	mov    0xc(%ebp),%esi
80102b5e:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
80102b5f:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102b65:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102b6b:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80102b71:	39 de                	cmp    %ebx,%esi
80102b73:	72 1f                	jb     80102b94 <freerange+0x44>
80102b75:	8d 76 00             	lea    0x0(%esi),%esi
    kfree(p);
80102b78:	83 ec 0c             	sub    $0xc,%esp
80102b7b:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102b81:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102b87:	50                   	push   %eax
80102b88:	e8 23 ff ff ff       	call   80102ab0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102b8d:	83 c4 10             	add    $0x10,%esp
80102b90:	39 f3                	cmp    %esi,%ebx
80102b92:	76 e4                	jbe    80102b78 <freerange+0x28>
}
80102b94:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102b97:	5b                   	pop    %ebx
80102b98:	5e                   	pop    %esi
80102b99:	5d                   	pop    %ebp
80102b9a:	c3                   	ret    
80102b9b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102b9f:	90                   	nop

80102ba0 <kinit1>:
{
80102ba0:	f3 0f 1e fb          	endbr32 
80102ba4:	55                   	push   %ebp
80102ba5:	89 e5                	mov    %esp,%ebp
80102ba7:	56                   	push   %esi
80102ba8:	53                   	push   %ebx
80102ba9:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
80102bac:	83 ec 08             	sub    $0x8,%esp
80102baf:	68 c4 7b 10 80       	push   $0x80107bc4
80102bb4:	68 80 42 11 80       	push   $0x80114280
80102bb9:	e8 42 1f 00 00       	call   80104b00 <initlock>
  p = (char*)PGROUNDUP((uint)vstart);
80102bbe:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102bc1:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 0;
80102bc4:	c7 05 b4 42 11 80 00 	movl   $0x0,0x801142b4
80102bcb:	00 00 00 
  p = (char*)PGROUNDUP((uint)vstart);
80102bce:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102bd4:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102bda:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80102be0:	39 de                	cmp    %ebx,%esi
80102be2:	72 20                	jb     80102c04 <kinit1+0x64>
80102be4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80102be8:	83 ec 0c             	sub    $0xc,%esp
80102beb:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102bf1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102bf7:	50                   	push   %eax
80102bf8:	e8 b3 fe ff ff       	call   80102ab0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102bfd:	83 c4 10             	add    $0x10,%esp
80102c00:	39 de                	cmp    %ebx,%esi
80102c02:	73 e4                	jae    80102be8 <kinit1+0x48>
}
80102c04:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102c07:	5b                   	pop    %ebx
80102c08:	5e                   	pop    %esi
80102c09:	5d                   	pop    %ebp
80102c0a:	c3                   	ret    
80102c0b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102c0f:	90                   	nop

80102c10 <kinit2>:
{
80102c10:	f3 0f 1e fb          	endbr32 
80102c14:	55                   	push   %ebp
80102c15:	89 e5                	mov    %esp,%ebp
80102c17:	56                   	push   %esi
  p = (char*)PGROUNDUP((uint)vstart);
80102c18:	8b 45 08             	mov    0x8(%ebp),%eax
{
80102c1b:	8b 75 0c             	mov    0xc(%ebp),%esi
80102c1e:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
80102c1f:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102c25:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102c2b:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80102c31:	39 de                	cmp    %ebx,%esi
80102c33:	72 1f                	jb     80102c54 <kinit2+0x44>
80102c35:	8d 76 00             	lea    0x0(%esi),%esi
    kfree(p);
80102c38:	83 ec 0c             	sub    $0xc,%esp
80102c3b:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102c41:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102c47:	50                   	push   %eax
80102c48:	e8 63 fe ff ff       	call   80102ab0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102c4d:	83 c4 10             	add    $0x10,%esp
80102c50:	39 de                	cmp    %ebx,%esi
80102c52:	73 e4                	jae    80102c38 <kinit2+0x28>
  kmem.use_lock = 1;
80102c54:	c7 05 b4 42 11 80 01 	movl   $0x1,0x801142b4
80102c5b:	00 00 00 
}
80102c5e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102c61:	5b                   	pop    %ebx
80102c62:	5e                   	pop    %esi
80102c63:	5d                   	pop    %ebp
80102c64:	c3                   	ret    
80102c65:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102c6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102c70 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
80102c70:	f3 0f 1e fb          	endbr32 
  struct run *r;

  if(kmem.use_lock)
80102c74:	a1 b4 42 11 80       	mov    0x801142b4,%eax
80102c79:	85 c0                	test   %eax,%eax
80102c7b:	75 1b                	jne    80102c98 <kalloc+0x28>
    acquire(&kmem.lock);
  r = kmem.freelist;
80102c7d:	a1 b8 42 11 80       	mov    0x801142b8,%eax
  if(r)
80102c82:	85 c0                	test   %eax,%eax
80102c84:	74 0a                	je     80102c90 <kalloc+0x20>
    kmem.freelist = r->next;
80102c86:	8b 10                	mov    (%eax),%edx
80102c88:	89 15 b8 42 11 80    	mov    %edx,0x801142b8
  if(kmem.use_lock)
80102c8e:	c3                   	ret    
80102c8f:	90                   	nop
    release(&kmem.lock);
  return (char*)r;
}
80102c90:	c3                   	ret    
80102c91:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
80102c98:	55                   	push   %ebp
80102c99:	89 e5                	mov    %esp,%ebp
80102c9b:	83 ec 24             	sub    $0x24,%esp
    acquire(&kmem.lock);
80102c9e:	68 80 42 11 80       	push   $0x80114280
80102ca3:	e8 d8 1f 00 00       	call   80104c80 <acquire>
  r = kmem.freelist;
80102ca8:	a1 b8 42 11 80       	mov    0x801142b8,%eax
  if(r)
80102cad:	8b 15 b4 42 11 80    	mov    0x801142b4,%edx
80102cb3:	83 c4 10             	add    $0x10,%esp
80102cb6:	85 c0                	test   %eax,%eax
80102cb8:	74 08                	je     80102cc2 <kalloc+0x52>
    kmem.freelist = r->next;
80102cba:	8b 08                	mov    (%eax),%ecx
80102cbc:	89 0d b8 42 11 80    	mov    %ecx,0x801142b8
  if(kmem.use_lock)
80102cc2:	85 d2                	test   %edx,%edx
80102cc4:	74 16                	je     80102cdc <kalloc+0x6c>
    release(&kmem.lock);
80102cc6:	83 ec 0c             	sub    $0xc,%esp
80102cc9:	89 45 f4             	mov    %eax,-0xc(%ebp)
80102ccc:	68 80 42 11 80       	push   $0x80114280
80102cd1:	e8 6a 20 00 00       	call   80104d40 <release>
  return (char*)r;
80102cd6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    release(&kmem.lock);
80102cd9:	83 c4 10             	add    $0x10,%esp
}
80102cdc:	c9                   	leave  
80102cdd:	c3                   	ret    
80102cde:	66 90                	xchg   %ax,%ax

80102ce0 <kbdgetc>:
#include "defs.h"
#include "kbd.h"

int
kbdgetc(void)
{
80102ce0:	f3 0f 1e fb          	endbr32 
  asm volatile("in %1,%0" : "=a"(data) : "d"(port));
80102ce4:	ba 64 00 00 00       	mov    $0x64,%edx
80102ce9:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
80102cea:	a8 01                	test   $0x1,%al
80102cec:	0f 84 be 00 00 00    	je     80102db0 <kbdgetc+0xd0>
{
80102cf2:	55                   	push   %ebp
80102cf3:	ba 60 00 00 00       	mov    $0x60,%edx
80102cf8:	89 e5                	mov    %esp,%ebp
80102cfa:	53                   	push   %ebx
80102cfb:	ec                   	in     (%dx),%al
  return data;
80102cfc:	8b 1d 34 c2 10 80    	mov    0x8010c234,%ebx
    return -1;
  data = inb(KBDATAP);
80102d02:	0f b6 d0             	movzbl %al,%edx

  if(data == 0xE0){
80102d05:	3c e0                	cmp    $0xe0,%al
80102d07:	74 57                	je     80102d60 <kbdgetc+0x80>
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
80102d09:	89 d9                	mov    %ebx,%ecx
80102d0b:	83 e1 40             	and    $0x40,%ecx
80102d0e:	84 c0                	test   %al,%al
80102d10:	78 5e                	js     80102d70 <kbdgetc+0x90>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
80102d12:	85 c9                	test   %ecx,%ecx
80102d14:	74 09                	je     80102d1f <kbdgetc+0x3f>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
80102d16:	83 c8 80             	or     $0xffffff80,%eax
    shift &= ~E0ESC;
80102d19:	83 e3 bf             	and    $0xffffffbf,%ebx
    data |= 0x80;
80102d1c:	0f b6 d0             	movzbl %al,%edx
  }

  shift |= shiftcode[data];
80102d1f:	0f b6 8a 00 7d 10 80 	movzbl -0x7fef8300(%edx),%ecx
  shift ^= togglecode[data];
80102d26:	0f b6 82 00 7c 10 80 	movzbl -0x7fef8400(%edx),%eax
  shift |= shiftcode[data];
80102d2d:	09 d9                	or     %ebx,%ecx
  shift ^= togglecode[data];
80102d2f:	31 c1                	xor    %eax,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
80102d31:	89 c8                	mov    %ecx,%eax
  shift ^= togglecode[data];
80102d33:	89 0d 34 c2 10 80    	mov    %ecx,0x8010c234
  c = charcode[shift & (CTL | SHIFT)][data];
80102d39:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
80102d3c:	83 e1 08             	and    $0x8,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
80102d3f:	8b 04 85 e0 7b 10 80 	mov    -0x7fef8420(,%eax,4),%eax
80102d46:	0f b6 04 10          	movzbl (%eax,%edx,1),%eax
  if(shift & CAPSLOCK){
80102d4a:	74 0b                	je     80102d57 <kbdgetc+0x77>
    if('a' <= c && c <= 'z')
80102d4c:	8d 50 9f             	lea    -0x61(%eax),%edx
80102d4f:	83 fa 19             	cmp    $0x19,%edx
80102d52:	77 44                	ja     80102d98 <kbdgetc+0xb8>
      c += 'A' - 'a';
80102d54:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
80102d57:	5b                   	pop    %ebx
80102d58:	5d                   	pop    %ebp
80102d59:	c3                   	ret    
80102d5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    shift |= E0ESC;
80102d60:	83 cb 40             	or     $0x40,%ebx
    return 0;
80102d63:	31 c0                	xor    %eax,%eax
    shift |= E0ESC;
80102d65:	89 1d 34 c2 10 80    	mov    %ebx,0x8010c234
}
80102d6b:	5b                   	pop    %ebx
80102d6c:	5d                   	pop    %ebp
80102d6d:	c3                   	ret    
80102d6e:	66 90                	xchg   %ax,%ax
    data = (shift & E0ESC ? data : data & 0x7F);
80102d70:	83 e0 7f             	and    $0x7f,%eax
80102d73:	85 c9                	test   %ecx,%ecx
80102d75:	0f 44 d0             	cmove  %eax,%edx
    return 0;
80102d78:	31 c0                	xor    %eax,%eax
    shift &= ~(shiftcode[data] | E0ESC);
80102d7a:	0f b6 8a 00 7d 10 80 	movzbl -0x7fef8300(%edx),%ecx
80102d81:	83 c9 40             	or     $0x40,%ecx
80102d84:	0f b6 c9             	movzbl %cl,%ecx
80102d87:	f7 d1                	not    %ecx
80102d89:	21 d9                	and    %ebx,%ecx
}
80102d8b:	5b                   	pop    %ebx
80102d8c:	5d                   	pop    %ebp
    shift &= ~(shiftcode[data] | E0ESC);
80102d8d:	89 0d 34 c2 10 80    	mov    %ecx,0x8010c234
}
80102d93:	c3                   	ret    
80102d94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    else if('A' <= c && c <= 'Z')
80102d98:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
80102d9b:	8d 50 20             	lea    0x20(%eax),%edx
}
80102d9e:	5b                   	pop    %ebx
80102d9f:	5d                   	pop    %ebp
      c += 'a' - 'A';
80102da0:	83 f9 1a             	cmp    $0x1a,%ecx
80102da3:	0f 42 c2             	cmovb  %edx,%eax
}
80102da6:	c3                   	ret    
80102da7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102dae:	66 90                	xchg   %ax,%ax
    return -1;
80102db0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80102db5:	c3                   	ret    
80102db6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102dbd:	8d 76 00             	lea    0x0(%esi),%esi

80102dc0 <kbdintr>:

void
kbdintr(void)
{
80102dc0:	f3 0f 1e fb          	endbr32 
80102dc4:	55                   	push   %ebp
80102dc5:	89 e5                	mov    %esp,%ebp
80102dc7:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
80102dca:	68 e0 2c 10 80       	push   $0x80102ce0
80102dcf:	e8 6c df ff ff       	call   80100d40 <consoleintr>
}
80102dd4:	83 c4 10             	add    $0x10,%esp
80102dd7:	c9                   	leave  
80102dd8:	c3                   	ret    
80102dd9:	66 90                	xchg   %ax,%ax
80102ddb:	66 90                	xchg   %ax,%ax
80102ddd:	66 90                	xchg   %ax,%ax
80102ddf:	90                   	nop

80102de0 <lapicinit>:
  lapic[ID];  // wait for write to finish, by reading
}

void
lapicinit(void)
{
80102de0:	f3 0f 1e fb          	endbr32 
  if(!lapic)
80102de4:	a1 bc 42 11 80       	mov    0x801142bc,%eax
80102de9:	85 c0                	test   %eax,%eax
80102deb:	0f 84 c7 00 00 00    	je     80102eb8 <lapicinit+0xd8>
  lapic[index] = value;
80102df1:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
80102df8:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102dfb:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102dfe:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
80102e05:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102e08:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102e0b:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
80102e12:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
80102e15:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102e18:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
80102e1f:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
80102e22:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102e25:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
80102e2c:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102e2f:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102e32:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
80102e39:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102e3c:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
80102e3f:	8b 50 30             	mov    0x30(%eax),%edx
80102e42:	c1 ea 10             	shr    $0x10,%edx
80102e45:	81 e2 fc 00 00 00    	and    $0xfc,%edx
80102e4b:	75 73                	jne    80102ec0 <lapicinit+0xe0>
  lapic[index] = value;
80102e4d:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
80102e54:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102e57:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102e5a:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
80102e61:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102e64:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102e67:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
80102e6e:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102e71:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102e74:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102e7b:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102e7e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102e81:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
80102e88:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102e8b:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102e8e:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
80102e95:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
80102e98:	8b 50 20             	mov    0x20(%eax),%edx
80102e9b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102e9f:	90                   	nop
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
80102ea0:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
80102ea6:	80 e6 10             	and    $0x10,%dh
80102ea9:	75 f5                	jne    80102ea0 <lapicinit+0xc0>
  lapic[index] = value;
80102eab:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
80102eb2:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102eb5:	8b 40 20             	mov    0x20(%eax),%eax
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
80102eb8:	c3                   	ret    
80102eb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  lapic[index] = value;
80102ec0:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
80102ec7:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102eca:	8b 50 20             	mov    0x20(%eax),%edx
}
80102ecd:	e9 7b ff ff ff       	jmp    80102e4d <lapicinit+0x6d>
80102ed2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102ed9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102ee0 <lapicid>:

int
lapicid(void)
{
80102ee0:	f3 0f 1e fb          	endbr32 
  if (!lapic)
80102ee4:	a1 bc 42 11 80       	mov    0x801142bc,%eax
80102ee9:	85 c0                	test   %eax,%eax
80102eeb:	74 0b                	je     80102ef8 <lapicid+0x18>
    return 0;
  return lapic[ID] >> 24;
80102eed:	8b 40 20             	mov    0x20(%eax),%eax
80102ef0:	c1 e8 18             	shr    $0x18,%eax
80102ef3:	c3                   	ret    
80102ef4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return 0;
80102ef8:	31 c0                	xor    %eax,%eax
}
80102efa:	c3                   	ret    
80102efb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102eff:	90                   	nop

80102f00 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
80102f00:	f3 0f 1e fb          	endbr32 
  if(lapic)
80102f04:	a1 bc 42 11 80       	mov    0x801142bc,%eax
80102f09:	85 c0                	test   %eax,%eax
80102f0b:	74 0d                	je     80102f1a <lapiceoi+0x1a>
  lapic[index] = value;
80102f0d:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102f14:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102f17:	8b 40 20             	mov    0x20(%eax),%eax
    lapicw(EOI, 0);
}
80102f1a:	c3                   	ret    
80102f1b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102f1f:	90                   	nop

80102f20 <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
80102f20:	f3 0f 1e fb          	endbr32 
}
80102f24:	c3                   	ret    
80102f25:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102f2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102f30 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80102f30:	f3 0f 1e fb          	endbr32 
80102f34:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a"(data), "d"(port));
80102f35:	b8 0f 00 00 00       	mov    $0xf,%eax
80102f3a:	ba 70 00 00 00       	mov    $0x70,%edx
80102f3f:	89 e5                	mov    %esp,%ebp
80102f41:	53                   	push   %ebx
80102f42:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102f45:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102f48:	ee                   	out    %al,(%dx)
80102f49:	b8 0a 00 00 00       	mov    $0xa,%eax
80102f4e:	ba 71 00 00 00       	mov    $0x71,%edx
80102f53:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
80102f54:	31 c0                	xor    %eax,%eax
  wrv[1] = addr >> 4;

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
80102f56:	c1 e3 18             	shl    $0x18,%ebx
  wrv[0] = 0;
80102f59:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
80102f5f:	89 c8                	mov    %ecx,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
80102f61:	c1 e9 0c             	shr    $0xc,%ecx
  lapicw(ICRHI, apicid<<24);
80102f64:	89 da                	mov    %ebx,%edx
  wrv[1] = addr >> 4;
80102f66:	c1 e8 04             	shr    $0x4,%eax
    lapicw(ICRLO, STARTUP | (addr>>12));
80102f69:	80 cd 06             	or     $0x6,%ch
  wrv[1] = addr >> 4;
80102f6c:	66 a3 69 04 00 80    	mov    %ax,0x80000469
  lapic[index] = value;
80102f72:	a1 bc 42 11 80       	mov    0x801142bc,%eax
80102f77:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102f7d:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102f80:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
80102f87:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102f8a:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102f8d:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
80102f94:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102f97:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102f9a:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102fa0:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102fa3:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102fa9:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102fac:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102fb2:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102fb5:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
    microdelay(200);
  }
}
80102fbb:	5b                   	pop    %ebx
  lapic[ID];  // wait for write to finish, by reading
80102fbc:	8b 40 20             	mov    0x20(%eax),%eax
}
80102fbf:	5d                   	pop    %ebp
80102fc0:	c3                   	ret    
80102fc1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102fc8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102fcf:	90                   	nop

80102fd0 <cmostime>:
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void
cmostime(struct rtcdate *r)
{
80102fd0:	f3 0f 1e fb          	endbr32 
80102fd4:	55                   	push   %ebp
80102fd5:	b8 0b 00 00 00       	mov    $0xb,%eax
80102fda:	ba 70 00 00 00       	mov    $0x70,%edx
80102fdf:	89 e5                	mov    %esp,%ebp
80102fe1:	57                   	push   %edi
80102fe2:	56                   	push   %esi
80102fe3:	53                   	push   %ebx
80102fe4:	83 ec 4c             	sub    $0x4c,%esp
80102fe7:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a"(data) : "d"(port));
80102fe8:	ba 71 00 00 00       	mov    $0x71,%edx
80102fed:	ec                   	in     (%dx),%al
  struct rtcdate t1, t2;
  int sb, bcd;

  sb = cmos_read(CMOS_STATB);

  bcd = (sb & (1 << 2)) == 0;
80102fee:	83 e0 04             	and    $0x4,%eax
  asm volatile("out %0,%1" : : "a"(data), "d"(port));
80102ff1:	bb 70 00 00 00       	mov    $0x70,%ebx
80102ff6:	88 45 b3             	mov    %al,-0x4d(%ebp)
80102ff9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103000:	31 c0                	xor    %eax,%eax
80103002:	89 da                	mov    %ebx,%edx
80103004:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a"(data) : "d"(port));
80103005:	b9 71 00 00 00       	mov    $0x71,%ecx
8010300a:	89 ca                	mov    %ecx,%edx
8010300c:	ec                   	in     (%dx),%al
8010300d:	88 45 b7             	mov    %al,-0x49(%ebp)
  asm volatile("out %0,%1" : : "a"(data), "d"(port));
80103010:	89 da                	mov    %ebx,%edx
80103012:	b8 02 00 00 00       	mov    $0x2,%eax
80103017:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a"(data) : "d"(port));
80103018:	89 ca                	mov    %ecx,%edx
8010301a:	ec                   	in     (%dx),%al
8010301b:	88 45 b6             	mov    %al,-0x4a(%ebp)
  asm volatile("out %0,%1" : : "a"(data), "d"(port));
8010301e:	89 da                	mov    %ebx,%edx
80103020:	b8 04 00 00 00       	mov    $0x4,%eax
80103025:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a"(data) : "d"(port));
80103026:	89 ca                	mov    %ecx,%edx
80103028:	ec                   	in     (%dx),%al
80103029:	88 45 b5             	mov    %al,-0x4b(%ebp)
  asm volatile("out %0,%1" : : "a"(data), "d"(port));
8010302c:	89 da                	mov    %ebx,%edx
8010302e:	b8 07 00 00 00       	mov    $0x7,%eax
80103033:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a"(data) : "d"(port));
80103034:	89 ca                	mov    %ecx,%edx
80103036:	ec                   	in     (%dx),%al
80103037:	88 45 b4             	mov    %al,-0x4c(%ebp)
  asm volatile("out %0,%1" : : "a"(data), "d"(port));
8010303a:	89 da                	mov    %ebx,%edx
8010303c:	b8 08 00 00 00       	mov    $0x8,%eax
80103041:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a"(data) : "d"(port));
80103042:	89 ca                	mov    %ecx,%edx
80103044:	ec                   	in     (%dx),%al
80103045:	89 c7                	mov    %eax,%edi
  asm volatile("out %0,%1" : : "a"(data), "d"(port));
80103047:	89 da                	mov    %ebx,%edx
80103049:	b8 09 00 00 00       	mov    $0x9,%eax
8010304e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a"(data) : "d"(port));
8010304f:	89 ca                	mov    %ecx,%edx
80103051:	ec                   	in     (%dx),%al
80103052:	89 c6                	mov    %eax,%esi
  asm volatile("out %0,%1" : : "a"(data), "d"(port));
80103054:	89 da                	mov    %ebx,%edx
80103056:	b8 0a 00 00 00       	mov    $0xa,%eax
8010305b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a"(data) : "d"(port));
8010305c:	89 ca                	mov    %ecx,%edx
8010305e:	ec                   	in     (%dx),%al

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
8010305f:	84 c0                	test   %al,%al
80103061:	78 9d                	js     80103000 <cmostime+0x30>
  return inb(CMOS_RETURN);
80103063:	0f b6 45 b7          	movzbl -0x49(%ebp),%eax
80103067:	89 fa                	mov    %edi,%edx
80103069:	0f b6 fa             	movzbl %dl,%edi
8010306c:	89 f2                	mov    %esi,%edx
8010306e:	89 45 b8             	mov    %eax,-0x48(%ebp)
80103071:	0f b6 45 b6          	movzbl -0x4a(%ebp),%eax
80103075:	0f b6 f2             	movzbl %dl,%esi
  asm volatile("out %0,%1" : : "a"(data), "d"(port));
80103078:	89 da                	mov    %ebx,%edx
8010307a:	89 7d c8             	mov    %edi,-0x38(%ebp)
8010307d:	89 45 bc             	mov    %eax,-0x44(%ebp)
80103080:	0f b6 45 b5          	movzbl -0x4b(%ebp),%eax
80103084:	89 75 cc             	mov    %esi,-0x34(%ebp)
80103087:	89 45 c0             	mov    %eax,-0x40(%ebp)
8010308a:	0f b6 45 b4          	movzbl -0x4c(%ebp),%eax
8010308e:	89 45 c4             	mov    %eax,-0x3c(%ebp)
80103091:	31 c0                	xor    %eax,%eax
80103093:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a"(data) : "d"(port));
80103094:	89 ca                	mov    %ecx,%edx
80103096:	ec                   	in     (%dx),%al
80103097:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a"(data), "d"(port));
8010309a:	89 da                	mov    %ebx,%edx
8010309c:	89 45 d0             	mov    %eax,-0x30(%ebp)
8010309f:	b8 02 00 00 00       	mov    $0x2,%eax
801030a4:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a"(data) : "d"(port));
801030a5:	89 ca                	mov    %ecx,%edx
801030a7:	ec                   	in     (%dx),%al
801030a8:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a"(data), "d"(port));
801030ab:	89 da                	mov    %ebx,%edx
801030ad:	89 45 d4             	mov    %eax,-0x2c(%ebp)
801030b0:	b8 04 00 00 00       	mov    $0x4,%eax
801030b5:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a"(data) : "d"(port));
801030b6:	89 ca                	mov    %ecx,%edx
801030b8:	ec                   	in     (%dx),%al
801030b9:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a"(data), "d"(port));
801030bc:	89 da                	mov    %ebx,%edx
801030be:	89 45 d8             	mov    %eax,-0x28(%ebp)
801030c1:	b8 07 00 00 00       	mov    $0x7,%eax
801030c6:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a"(data) : "d"(port));
801030c7:	89 ca                	mov    %ecx,%edx
801030c9:	ec                   	in     (%dx),%al
801030ca:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a"(data), "d"(port));
801030cd:	89 da                	mov    %ebx,%edx
801030cf:	89 45 dc             	mov    %eax,-0x24(%ebp)
801030d2:	b8 08 00 00 00       	mov    $0x8,%eax
801030d7:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a"(data) : "d"(port));
801030d8:	89 ca                	mov    %ecx,%edx
801030da:	ec                   	in     (%dx),%al
801030db:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a"(data), "d"(port));
801030de:	89 da                	mov    %ebx,%edx
801030e0:	89 45 e0             	mov    %eax,-0x20(%ebp)
801030e3:	b8 09 00 00 00       	mov    $0x9,%eax
801030e8:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a"(data) : "d"(port));
801030e9:	89 ca                	mov    %ecx,%edx
801030eb:	ec                   	in     (%dx),%al
801030ec:	0f b6 c0             	movzbl %al,%eax
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
801030ef:	83 ec 04             	sub    $0x4,%esp
  return inb(CMOS_RETURN);
801030f2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
801030f5:	8d 45 d0             	lea    -0x30(%ebp),%eax
801030f8:	6a 18                	push   $0x18
801030fa:	50                   	push   %eax
801030fb:	8d 45 b8             	lea    -0x48(%ebp),%eax
801030fe:	50                   	push   %eax
801030ff:	e8 dc 1c 00 00       	call   80104de0 <memcmp>
80103104:	83 c4 10             	add    $0x10,%esp
80103107:	85 c0                	test   %eax,%eax
80103109:	0f 85 f1 fe ff ff    	jne    80103000 <cmostime+0x30>
      break;
  }

  // convert
  if(bcd) {
8010310f:	80 7d b3 00          	cmpb   $0x0,-0x4d(%ebp)
80103113:	75 78                	jne    8010318d <cmostime+0x1bd>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
80103115:	8b 45 b8             	mov    -0x48(%ebp),%eax
80103118:	89 c2                	mov    %eax,%edx
8010311a:	83 e0 0f             	and    $0xf,%eax
8010311d:	c1 ea 04             	shr    $0x4,%edx
80103120:	8d 14 92             	lea    (%edx,%edx,4),%edx
80103123:	8d 04 50             	lea    (%eax,%edx,2),%eax
80103126:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
80103129:	8b 45 bc             	mov    -0x44(%ebp),%eax
8010312c:	89 c2                	mov    %eax,%edx
8010312e:	83 e0 0f             	and    $0xf,%eax
80103131:	c1 ea 04             	shr    $0x4,%edx
80103134:	8d 14 92             	lea    (%edx,%edx,4),%edx
80103137:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010313a:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
8010313d:	8b 45 c0             	mov    -0x40(%ebp),%eax
80103140:	89 c2                	mov    %eax,%edx
80103142:	83 e0 0f             	and    $0xf,%eax
80103145:	c1 ea 04             	shr    $0x4,%edx
80103148:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010314b:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010314e:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
80103151:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80103154:	89 c2                	mov    %eax,%edx
80103156:	83 e0 0f             	and    $0xf,%eax
80103159:	c1 ea 04             	shr    $0x4,%edx
8010315c:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010315f:	8d 04 50             	lea    (%eax,%edx,2),%eax
80103162:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
80103165:	8b 45 c8             	mov    -0x38(%ebp),%eax
80103168:	89 c2                	mov    %eax,%edx
8010316a:	83 e0 0f             	and    $0xf,%eax
8010316d:	c1 ea 04             	shr    $0x4,%edx
80103170:	8d 14 92             	lea    (%edx,%edx,4),%edx
80103173:	8d 04 50             	lea    (%eax,%edx,2),%eax
80103176:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
80103179:	8b 45 cc             	mov    -0x34(%ebp),%eax
8010317c:	89 c2                	mov    %eax,%edx
8010317e:	83 e0 0f             	and    $0xf,%eax
80103181:	c1 ea 04             	shr    $0x4,%edx
80103184:	8d 14 92             	lea    (%edx,%edx,4),%edx
80103187:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010318a:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
8010318d:	8b 75 08             	mov    0x8(%ebp),%esi
80103190:	8b 45 b8             	mov    -0x48(%ebp),%eax
80103193:	89 06                	mov    %eax,(%esi)
80103195:	8b 45 bc             	mov    -0x44(%ebp),%eax
80103198:	89 46 04             	mov    %eax,0x4(%esi)
8010319b:	8b 45 c0             	mov    -0x40(%ebp),%eax
8010319e:	89 46 08             	mov    %eax,0x8(%esi)
801031a1:	8b 45 c4             	mov    -0x3c(%ebp),%eax
801031a4:	89 46 0c             	mov    %eax,0xc(%esi)
801031a7:	8b 45 c8             	mov    -0x38(%ebp),%eax
801031aa:	89 46 10             	mov    %eax,0x10(%esi)
801031ad:	8b 45 cc             	mov    -0x34(%ebp),%eax
801031b0:	89 46 14             	mov    %eax,0x14(%esi)
  r->year += 2000;
801031b3:	81 46 14 d0 07 00 00 	addl   $0x7d0,0x14(%esi)
}
801031ba:	8d 65 f4             	lea    -0xc(%ebp),%esp
801031bd:	5b                   	pop    %ebx
801031be:	5e                   	pop    %esi
801031bf:	5f                   	pop    %edi
801031c0:	5d                   	pop    %ebp
801031c1:	c3                   	ret    
801031c2:	66 90                	xchg   %ax,%ax
801031c4:	66 90                	xchg   %ax,%ax
801031c6:	66 90                	xchg   %ax,%ax
801031c8:	66 90                	xchg   %ax,%ax
801031ca:	66 90                	xchg   %ax,%ax
801031cc:	66 90                	xchg   %ax,%ax
801031ce:	66 90                	xchg   %ax,%ax

801031d0 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
801031d0:	8b 0d 08 43 11 80    	mov    0x80114308,%ecx
801031d6:	85 c9                	test   %ecx,%ecx
801031d8:	0f 8e 8a 00 00 00    	jle    80103268 <install_trans+0x98>
{
801031de:	55                   	push   %ebp
801031df:	89 e5                	mov    %esp,%ebp
801031e1:	57                   	push   %edi
  for (tail = 0; tail < log.lh.n; tail++) {
801031e2:	31 ff                	xor    %edi,%edi
{
801031e4:	56                   	push   %esi
801031e5:	53                   	push   %ebx
801031e6:	83 ec 0c             	sub    $0xc,%esp
801031e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
801031f0:	a1 f4 42 11 80       	mov    0x801142f4,%eax
801031f5:	83 ec 08             	sub    $0x8,%esp
801031f8:	01 f8                	add    %edi,%eax
801031fa:	83 c0 01             	add    $0x1,%eax
801031fd:	50                   	push   %eax
801031fe:	ff 35 04 43 11 80    	pushl  0x80114304
80103204:	e8 c7 ce ff ff       	call   801000d0 <bread>
80103209:	89 c6                	mov    %eax,%esi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
8010320b:	58                   	pop    %eax
8010320c:	5a                   	pop    %edx
8010320d:	ff 34 bd 0c 43 11 80 	pushl  -0x7feebcf4(,%edi,4)
80103214:	ff 35 04 43 11 80    	pushl  0x80114304
  for (tail = 0; tail < log.lh.n; tail++) {
8010321a:	83 c7 01             	add    $0x1,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
8010321d:	e8 ae ce ff ff       	call   801000d0 <bread>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80103222:	83 c4 0c             	add    $0xc,%esp
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80103225:	89 c3                	mov    %eax,%ebx
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80103227:	8d 46 5c             	lea    0x5c(%esi),%eax
8010322a:	68 00 02 00 00       	push   $0x200
8010322f:	50                   	push   %eax
80103230:	8d 43 5c             	lea    0x5c(%ebx),%eax
80103233:	50                   	push   %eax
80103234:	e8 f7 1b 00 00       	call   80104e30 <memmove>
    bwrite(dbuf);  // write dst to disk
80103239:	89 1c 24             	mov    %ebx,(%esp)
8010323c:	e8 6f cf ff ff       	call   801001b0 <bwrite>
    brelse(lbuf);
80103241:	89 34 24             	mov    %esi,(%esp)
80103244:	e8 a7 cf ff ff       	call   801001f0 <brelse>
    brelse(dbuf);
80103249:	89 1c 24             	mov    %ebx,(%esp)
8010324c:	e8 9f cf ff ff       	call   801001f0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80103251:	83 c4 10             	add    $0x10,%esp
80103254:	39 3d 08 43 11 80    	cmp    %edi,0x80114308
8010325a:	7f 94                	jg     801031f0 <install_trans+0x20>
  }
}
8010325c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010325f:	5b                   	pop    %ebx
80103260:	5e                   	pop    %esi
80103261:	5f                   	pop    %edi
80103262:	5d                   	pop    %ebp
80103263:	c3                   	ret    
80103264:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103268:	c3                   	ret    
80103269:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103270 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80103270:	55                   	push   %ebp
80103271:	89 e5                	mov    %esp,%ebp
80103273:	53                   	push   %ebx
80103274:	83 ec 0c             	sub    $0xc,%esp
  struct buf *buf = bread(log.dev, log.start);
80103277:	ff 35 f4 42 11 80    	pushl  0x801142f4
8010327d:	ff 35 04 43 11 80    	pushl  0x80114304
80103283:	e8 48 ce ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
80103288:	83 c4 10             	add    $0x10,%esp
  struct buf *buf = bread(log.dev, log.start);
8010328b:	89 c3                	mov    %eax,%ebx
  hb->n = log.lh.n;
8010328d:	a1 08 43 11 80       	mov    0x80114308,%eax
80103292:	89 43 5c             	mov    %eax,0x5c(%ebx)
  for (i = 0; i < log.lh.n; i++) {
80103295:	85 c0                	test   %eax,%eax
80103297:	7e 19                	jle    801032b2 <write_head+0x42>
80103299:	31 d2                	xor    %edx,%edx
8010329b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010329f:	90                   	nop
    hb->block[i] = log.lh.block[i];
801032a0:	8b 0c 95 0c 43 11 80 	mov    -0x7feebcf4(,%edx,4),%ecx
801032a7:	89 4c 93 60          	mov    %ecx,0x60(%ebx,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
801032ab:	83 c2 01             	add    $0x1,%edx
801032ae:	39 d0                	cmp    %edx,%eax
801032b0:	75 ee                	jne    801032a0 <write_head+0x30>
  }
  bwrite(buf);
801032b2:	83 ec 0c             	sub    $0xc,%esp
801032b5:	53                   	push   %ebx
801032b6:	e8 f5 ce ff ff       	call   801001b0 <bwrite>
  brelse(buf);
801032bb:	89 1c 24             	mov    %ebx,(%esp)
801032be:	e8 2d cf ff ff       	call   801001f0 <brelse>
}
801032c3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801032c6:	83 c4 10             	add    $0x10,%esp
801032c9:	c9                   	leave  
801032ca:	c3                   	ret    
801032cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801032cf:	90                   	nop

801032d0 <initlog>:
{
801032d0:	f3 0f 1e fb          	endbr32 
801032d4:	55                   	push   %ebp
801032d5:	89 e5                	mov    %esp,%ebp
801032d7:	53                   	push   %ebx
801032d8:	83 ec 2c             	sub    $0x2c,%esp
801032db:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&log.lock, "log");
801032de:	68 00 7e 10 80       	push   $0x80107e00
801032e3:	68 c0 42 11 80       	push   $0x801142c0
801032e8:	e8 13 18 00 00       	call   80104b00 <initlock>
  readsb(dev, &sb);
801032ed:	58                   	pop    %eax
801032ee:	8d 45 dc             	lea    -0x24(%ebp),%eax
801032f1:	5a                   	pop    %edx
801032f2:	50                   	push   %eax
801032f3:	53                   	push   %ebx
801032f4:	e8 47 e8 ff ff       	call   80101b40 <readsb>
  log.start = sb.logstart;
801032f9:	8b 45 ec             	mov    -0x14(%ebp),%eax
  struct buf *buf = bread(log.dev, log.start);
801032fc:	59                   	pop    %ecx
  log.dev = dev;
801032fd:	89 1d 04 43 11 80    	mov    %ebx,0x80114304
  log.size = sb.nlog;
80103303:	8b 55 e8             	mov    -0x18(%ebp),%edx
  log.start = sb.logstart;
80103306:	a3 f4 42 11 80       	mov    %eax,0x801142f4
  log.size = sb.nlog;
8010330b:	89 15 f8 42 11 80    	mov    %edx,0x801142f8
  struct buf *buf = bread(log.dev, log.start);
80103311:	5a                   	pop    %edx
80103312:	50                   	push   %eax
80103313:	53                   	push   %ebx
80103314:	e8 b7 cd ff ff       	call   801000d0 <bread>
  for (i = 0; i < log.lh.n; i++) {
80103319:	83 c4 10             	add    $0x10,%esp
  log.lh.n = lh->n;
8010331c:	8b 48 5c             	mov    0x5c(%eax),%ecx
8010331f:	89 0d 08 43 11 80    	mov    %ecx,0x80114308
  for (i = 0; i < log.lh.n; i++) {
80103325:	85 c9                	test   %ecx,%ecx
80103327:	7e 19                	jle    80103342 <initlog+0x72>
80103329:	31 d2                	xor    %edx,%edx
8010332b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010332f:	90                   	nop
    log.lh.block[i] = lh->block[i];
80103330:	8b 5c 90 60          	mov    0x60(%eax,%edx,4),%ebx
80103334:	89 1c 95 0c 43 11 80 	mov    %ebx,-0x7feebcf4(,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
8010333b:	83 c2 01             	add    $0x1,%edx
8010333e:	39 d1                	cmp    %edx,%ecx
80103340:	75 ee                	jne    80103330 <initlog+0x60>
  brelse(buf);
80103342:	83 ec 0c             	sub    $0xc,%esp
80103345:	50                   	push   %eax
80103346:	e8 a5 ce ff ff       	call   801001f0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
8010334b:	e8 80 fe ff ff       	call   801031d0 <install_trans>
  log.lh.n = 0;
80103350:	c7 05 08 43 11 80 00 	movl   $0x0,0x80114308
80103357:	00 00 00 
  write_head(); // clear the log
8010335a:	e8 11 ff ff ff       	call   80103270 <write_head>
}
8010335f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103362:	83 c4 10             	add    $0x10,%esp
80103365:	c9                   	leave  
80103366:	c3                   	ret    
80103367:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010336e:	66 90                	xchg   %ax,%ax

80103370 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80103370:	f3 0f 1e fb          	endbr32 
80103374:	55                   	push   %ebp
80103375:	89 e5                	mov    %esp,%ebp
80103377:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
8010337a:	68 c0 42 11 80       	push   $0x801142c0
8010337f:	e8 fc 18 00 00       	call   80104c80 <acquire>
80103384:	83 c4 10             	add    $0x10,%esp
80103387:	eb 1c                	jmp    801033a5 <begin_op+0x35>
80103389:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80103390:	83 ec 08             	sub    $0x8,%esp
80103393:	68 c0 42 11 80       	push   $0x801142c0
80103398:	68 c0 42 11 80       	push   $0x801142c0
8010339d:	e8 ee 11 00 00       	call   80104590 <sleep>
801033a2:	83 c4 10             	add    $0x10,%esp
    if(log.committing){
801033a5:	a1 00 43 11 80       	mov    0x80114300,%eax
801033aa:	85 c0                	test   %eax,%eax
801033ac:	75 e2                	jne    80103390 <begin_op+0x20>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
801033ae:	a1 fc 42 11 80       	mov    0x801142fc,%eax
801033b3:	8b 15 08 43 11 80    	mov    0x80114308,%edx
801033b9:	83 c0 01             	add    $0x1,%eax
801033bc:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
801033bf:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
801033c2:	83 fa 1e             	cmp    $0x1e,%edx
801033c5:	7f c9                	jg     80103390 <begin_op+0x20>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
801033c7:	83 ec 0c             	sub    $0xc,%esp
      log.outstanding += 1;
801033ca:	a3 fc 42 11 80       	mov    %eax,0x801142fc
      release(&log.lock);
801033cf:	68 c0 42 11 80       	push   $0x801142c0
801033d4:	e8 67 19 00 00       	call   80104d40 <release>
      break;
    }
  }
}
801033d9:	83 c4 10             	add    $0x10,%esp
801033dc:	c9                   	leave  
801033dd:	c3                   	ret    
801033de:	66 90                	xchg   %ax,%ax

801033e0 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
801033e0:	f3 0f 1e fb          	endbr32 
801033e4:	55                   	push   %ebp
801033e5:	89 e5                	mov    %esp,%ebp
801033e7:	57                   	push   %edi
801033e8:	56                   	push   %esi
801033e9:	53                   	push   %ebx
801033ea:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;

  acquire(&log.lock);
801033ed:	68 c0 42 11 80       	push   $0x801142c0
801033f2:	e8 89 18 00 00       	call   80104c80 <acquire>
  log.outstanding -= 1;
801033f7:	a1 fc 42 11 80       	mov    0x801142fc,%eax
  if(log.committing)
801033fc:	8b 35 00 43 11 80    	mov    0x80114300,%esi
80103402:	83 c4 10             	add    $0x10,%esp
  log.outstanding -= 1;
80103405:	8d 58 ff             	lea    -0x1(%eax),%ebx
80103408:	89 1d fc 42 11 80    	mov    %ebx,0x801142fc
  if(log.committing)
8010340e:	85 f6                	test   %esi,%esi
80103410:	0f 85 1e 01 00 00    	jne    80103534 <end_op+0x154>
    panic("log.committing");
  if(log.outstanding == 0){
80103416:	85 db                	test   %ebx,%ebx
80103418:	0f 85 f2 00 00 00    	jne    80103510 <end_op+0x130>
    do_commit = 1;
    log.committing = 1;
8010341e:	c7 05 00 43 11 80 01 	movl   $0x1,0x80114300
80103425:	00 00 00 
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80103428:	83 ec 0c             	sub    $0xc,%esp
8010342b:	68 c0 42 11 80       	push   $0x801142c0
80103430:	e8 0b 19 00 00       	call   80104d40 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80103435:	8b 0d 08 43 11 80    	mov    0x80114308,%ecx
8010343b:	83 c4 10             	add    $0x10,%esp
8010343e:	85 c9                	test   %ecx,%ecx
80103440:	7f 3e                	jg     80103480 <end_op+0xa0>
    acquire(&log.lock);
80103442:	83 ec 0c             	sub    $0xc,%esp
80103445:	68 c0 42 11 80       	push   $0x801142c0
8010344a:	e8 31 18 00 00       	call   80104c80 <acquire>
    wakeup(&log);
8010344f:	c7 04 24 c0 42 11 80 	movl   $0x801142c0,(%esp)
    log.committing = 0;
80103456:	c7 05 00 43 11 80 00 	movl   $0x0,0x80114300
8010345d:	00 00 00 
    wakeup(&log);
80103460:	e8 eb 12 00 00       	call   80104750 <wakeup>
    release(&log.lock);
80103465:	c7 04 24 c0 42 11 80 	movl   $0x801142c0,(%esp)
8010346c:	e8 cf 18 00 00       	call   80104d40 <release>
80103471:	83 c4 10             	add    $0x10,%esp
}
80103474:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103477:	5b                   	pop    %ebx
80103478:	5e                   	pop    %esi
80103479:	5f                   	pop    %edi
8010347a:	5d                   	pop    %ebp
8010347b:	c3                   	ret    
8010347c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80103480:	a1 f4 42 11 80       	mov    0x801142f4,%eax
80103485:	83 ec 08             	sub    $0x8,%esp
80103488:	01 d8                	add    %ebx,%eax
8010348a:	83 c0 01             	add    $0x1,%eax
8010348d:	50                   	push   %eax
8010348e:	ff 35 04 43 11 80    	pushl  0x80114304
80103494:	e8 37 cc ff ff       	call   801000d0 <bread>
80103499:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
8010349b:	58                   	pop    %eax
8010349c:	5a                   	pop    %edx
8010349d:	ff 34 9d 0c 43 11 80 	pushl  -0x7feebcf4(,%ebx,4)
801034a4:	ff 35 04 43 11 80    	pushl  0x80114304
  for (tail = 0; tail < log.lh.n; tail++) {
801034aa:	83 c3 01             	add    $0x1,%ebx
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
801034ad:	e8 1e cc ff ff       	call   801000d0 <bread>
    memmove(to->data, from->data, BSIZE);
801034b2:	83 c4 0c             	add    $0xc,%esp
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
801034b5:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
801034b7:	8d 40 5c             	lea    0x5c(%eax),%eax
801034ba:	68 00 02 00 00       	push   $0x200
801034bf:	50                   	push   %eax
801034c0:	8d 46 5c             	lea    0x5c(%esi),%eax
801034c3:	50                   	push   %eax
801034c4:	e8 67 19 00 00       	call   80104e30 <memmove>
    bwrite(to);  // write the log
801034c9:	89 34 24             	mov    %esi,(%esp)
801034cc:	e8 df cc ff ff       	call   801001b0 <bwrite>
    brelse(from);
801034d1:	89 3c 24             	mov    %edi,(%esp)
801034d4:	e8 17 cd ff ff       	call   801001f0 <brelse>
    brelse(to);
801034d9:	89 34 24             	mov    %esi,(%esp)
801034dc:	e8 0f cd ff ff       	call   801001f0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
801034e1:	83 c4 10             	add    $0x10,%esp
801034e4:	3b 1d 08 43 11 80    	cmp    0x80114308,%ebx
801034ea:	7c 94                	jl     80103480 <end_op+0xa0>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
801034ec:	e8 7f fd ff ff       	call   80103270 <write_head>
    install_trans(); // Now install writes to home locations
801034f1:	e8 da fc ff ff       	call   801031d0 <install_trans>
    log.lh.n = 0;
801034f6:	c7 05 08 43 11 80 00 	movl   $0x0,0x80114308
801034fd:	00 00 00 
    write_head();    // Erase the transaction from the log
80103500:	e8 6b fd ff ff       	call   80103270 <write_head>
80103505:	e9 38 ff ff ff       	jmp    80103442 <end_op+0x62>
8010350a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    wakeup(&log);
80103510:	83 ec 0c             	sub    $0xc,%esp
80103513:	68 c0 42 11 80       	push   $0x801142c0
80103518:	e8 33 12 00 00       	call   80104750 <wakeup>
  release(&log.lock);
8010351d:	c7 04 24 c0 42 11 80 	movl   $0x801142c0,(%esp)
80103524:	e8 17 18 00 00       	call   80104d40 <release>
80103529:	83 c4 10             	add    $0x10,%esp
}
8010352c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010352f:	5b                   	pop    %ebx
80103530:	5e                   	pop    %esi
80103531:	5f                   	pop    %edi
80103532:	5d                   	pop    %ebp
80103533:	c3                   	ret    
    panic("log.committing");
80103534:	83 ec 0c             	sub    $0xc,%esp
80103537:	68 04 7e 10 80       	push   $0x80107e04
8010353c:	e8 6f ce ff ff       	call   801003b0 <panic>
80103541:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103548:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010354f:	90                   	nop

80103550 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80103550:	f3 0f 1e fb          	endbr32 
80103554:	55                   	push   %ebp
80103555:	89 e5                	mov    %esp,%ebp
80103557:	53                   	push   %ebx
80103558:	83 ec 04             	sub    $0x4,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
8010355b:	8b 15 08 43 11 80    	mov    0x80114308,%edx
{
80103561:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80103564:	83 fa 1d             	cmp    $0x1d,%edx
80103567:	0f 8f 91 00 00 00    	jg     801035fe <log_write+0xae>
8010356d:	a1 f8 42 11 80       	mov    0x801142f8,%eax
80103572:	83 e8 01             	sub    $0x1,%eax
80103575:	39 c2                	cmp    %eax,%edx
80103577:	0f 8d 81 00 00 00    	jge    801035fe <log_write+0xae>
    panic("too big a transaction");
  if (log.outstanding < 1)
8010357d:	a1 fc 42 11 80       	mov    0x801142fc,%eax
80103582:	85 c0                	test   %eax,%eax
80103584:	0f 8e 81 00 00 00    	jle    8010360b <log_write+0xbb>
    panic("log_write outside of trans");

  acquire(&log.lock);
8010358a:	83 ec 0c             	sub    $0xc,%esp
8010358d:	68 c0 42 11 80       	push   $0x801142c0
80103592:	e8 e9 16 00 00       	call   80104c80 <acquire>
  for (i = 0; i < log.lh.n; i++) {
80103597:	8b 15 08 43 11 80    	mov    0x80114308,%edx
8010359d:	83 c4 10             	add    $0x10,%esp
801035a0:	85 d2                	test   %edx,%edx
801035a2:	7e 4e                	jle    801035f2 <log_write+0xa2>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
801035a4:	8b 4b 08             	mov    0x8(%ebx),%ecx
  for (i = 0; i < log.lh.n; i++) {
801035a7:	31 c0                	xor    %eax,%eax
801035a9:	eb 0c                	jmp    801035b7 <log_write+0x67>
801035ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801035af:	90                   	nop
801035b0:	83 c0 01             	add    $0x1,%eax
801035b3:	39 c2                	cmp    %eax,%edx
801035b5:	74 29                	je     801035e0 <log_write+0x90>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
801035b7:	39 0c 85 0c 43 11 80 	cmp    %ecx,-0x7feebcf4(,%eax,4)
801035be:	75 f0                	jne    801035b0 <log_write+0x60>
      break;
  }
  log.lh.block[i] = b->blockno;
801035c0:	89 0c 85 0c 43 11 80 	mov    %ecx,-0x7feebcf4(,%eax,4)
  if (i == log.lh.n)
    log.lh.n++;
  b->flags |= B_DIRTY; // prevent eviction
801035c7:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
}
801035ca:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  release(&log.lock);
801035cd:	c7 45 08 c0 42 11 80 	movl   $0x801142c0,0x8(%ebp)
}
801035d4:	c9                   	leave  
  release(&log.lock);
801035d5:	e9 66 17 00 00       	jmp    80104d40 <release>
801035da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  log.lh.block[i] = b->blockno;
801035e0:	89 0c 95 0c 43 11 80 	mov    %ecx,-0x7feebcf4(,%edx,4)
    log.lh.n++;
801035e7:	83 c2 01             	add    $0x1,%edx
801035ea:	89 15 08 43 11 80    	mov    %edx,0x80114308
801035f0:	eb d5                	jmp    801035c7 <log_write+0x77>
  log.lh.block[i] = b->blockno;
801035f2:	8b 43 08             	mov    0x8(%ebx),%eax
801035f5:	a3 0c 43 11 80       	mov    %eax,0x8011430c
  if (i == log.lh.n)
801035fa:	75 cb                	jne    801035c7 <log_write+0x77>
801035fc:	eb e9                	jmp    801035e7 <log_write+0x97>
    panic("too big a transaction");
801035fe:	83 ec 0c             	sub    $0xc,%esp
80103601:	68 13 7e 10 80       	push   $0x80107e13
80103606:	e8 a5 cd ff ff       	call   801003b0 <panic>
    panic("log_write outside of trans");
8010360b:	83 ec 0c             	sub    $0xc,%esp
8010360e:	68 29 7e 10 80       	push   $0x80107e29
80103613:	e8 98 cd ff ff       	call   801003b0 <panic>
80103618:	66 90                	xchg   %ax,%ax
8010361a:	66 90                	xchg   %ax,%ax
8010361c:	66 90                	xchg   %ax,%ax
8010361e:	66 90                	xchg   %ax,%ax

80103620 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80103620:	55                   	push   %ebp
80103621:	89 e5                	mov    %esp,%ebp
80103623:	53                   	push   %ebx
80103624:	83 ec 04             	sub    $0x4,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
80103627:	e8 54 09 00 00       	call   80103f80 <cpuid>
8010362c:	89 c3                	mov    %eax,%ebx
8010362e:	e8 4d 09 00 00       	call   80103f80 <cpuid>
80103633:	83 ec 04             	sub    $0x4,%esp
80103636:	53                   	push   %ebx
80103637:	50                   	push   %eax
80103638:	68 44 7e 10 80       	push   $0x80107e44
8010363d:	e8 5e d1 ff ff       	call   801007a0 <cprintf>
  idtinit();       // load idt register
80103642:	e8 f9 2a 00 00       	call   80106140 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
80103647:	e8 c4 08 00 00       	call   80103f10 <mycpu>
8010364c:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" : "+m"(*addr), "=a"(result) : "1"(newval) : "cc");
8010364e:	b8 01 00 00 00       	mov    $0x1,%eax
80103653:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
8010365a:	e8 41 0c 00 00       	call   801042a0 <scheduler>
8010365f:	90                   	nop

80103660 <mpenter>:
{
80103660:	f3 0f 1e fb          	endbr32 
80103664:	55                   	push   %ebp
80103665:	89 e5                	mov    %esp,%ebp
80103667:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
8010366a:	e8 a1 3b 00 00       	call   80107210 <switchkvm>
  seginit();
8010366f:	e8 0c 3b 00 00       	call   80107180 <seginit>
  lapicinit();
80103674:	e8 67 f7 ff ff       	call   80102de0 <lapicinit>
  mpmain();
80103679:	e8 a2 ff ff ff       	call   80103620 <mpmain>
8010367e:	66 90                	xchg   %ax,%ax

80103680 <main>:
{
80103680:	f3 0f 1e fb          	endbr32 
80103684:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80103688:	83 e4 f0             	and    $0xfffffff0,%esp
8010368b:	ff 71 fc             	pushl  -0x4(%ecx)
8010368e:	55                   	push   %ebp
8010368f:	89 e5                	mov    %esp,%ebp
80103691:	53                   	push   %ebx
80103692:	51                   	push   %ecx
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
80103693:	83 ec 08             	sub    $0x8,%esp
80103696:	68 00 00 40 80       	push   $0x80400000
8010369b:	68 e8 71 11 80       	push   $0x801171e8
801036a0:	e8 fb f4 ff ff       	call   80102ba0 <kinit1>
  kvmalloc();      // kernel page table
801036a5:	e8 46 40 00 00       	call   801076f0 <kvmalloc>
  mpinit();        // detect other processors
801036aa:	e8 81 01 00 00       	call   80103830 <mpinit>
  lapicinit();     // interrupt controller
801036af:	e8 2c f7 ff ff       	call   80102de0 <lapicinit>
  seginit();       // segment descriptors
801036b4:	e8 c7 3a 00 00       	call   80107180 <seginit>
  picinit();       // disable pic
801036b9:	e8 52 03 00 00       	call   80103a10 <picinit>
  ioapicinit();    // another interrupt controller
801036be:	e8 fd f2 ff ff       	call   801029c0 <ioapicinit>
  consoleinit();   // console hardware
801036c3:	e8 a8 d9 ff ff       	call   80101070 <consoleinit>
  uartinit();      // serial port
801036c8:	e8 73 2d 00 00       	call   80106440 <uartinit>
  pinit();         // process table
801036cd:	e8 1e 08 00 00       	call   80103ef0 <pinit>
  tvinit();        // trap vectors
801036d2:	e8 e9 29 00 00       	call   801060c0 <tvinit>
  binit();         // buffer cache
801036d7:	e8 64 c9 ff ff       	call   80100040 <binit>
  fileinit();      // file table
801036dc:	e8 3f dd ff ff       	call   80101420 <fileinit>
  ideinit();       // disk 
801036e1:	e8 aa f0 ff ff       	call   80102790 <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
801036e6:	83 c4 0c             	add    $0xc,%esp
801036e9:	68 8a 00 00 00       	push   $0x8a
801036ee:	68 8c b4 10 80       	push   $0x8010b48c
801036f3:	68 00 70 00 80       	push   $0x80007000
801036f8:	e8 33 17 00 00       	call   80104e30 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
801036fd:	83 c4 10             	add    $0x10,%esp
80103700:	69 05 40 49 11 80 b0 	imul   $0xb0,0x80114940,%eax
80103707:	00 00 00 
8010370a:	05 c0 43 11 80       	add    $0x801143c0,%eax
8010370f:	3d c0 43 11 80       	cmp    $0x801143c0,%eax
80103714:	76 7a                	jbe    80103790 <main+0x110>
80103716:	bb c0 43 11 80       	mov    $0x801143c0,%ebx
8010371b:	eb 1c                	jmp    80103739 <main+0xb9>
8010371d:	8d 76 00             	lea    0x0(%esi),%esi
80103720:	69 05 40 49 11 80 b0 	imul   $0xb0,0x80114940,%eax
80103727:	00 00 00 
8010372a:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
80103730:	05 c0 43 11 80       	add    $0x801143c0,%eax
80103735:	39 c3                	cmp    %eax,%ebx
80103737:	73 57                	jae    80103790 <main+0x110>
    if(c == mycpu())  // We've started already.
80103739:	e8 d2 07 00 00       	call   80103f10 <mycpu>
8010373e:	39 c3                	cmp    %eax,%ebx
80103740:	74 de                	je     80103720 <main+0xa0>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80103742:	e8 29 f5 ff ff       	call   80102c70 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
    *(void(**)(void))(code-8) = mpenter;
    *(int**)(code-12) = (void *) V2P(entrypgdir);

    lapicstartap(c->apicid, V2P(code));
80103747:	83 ec 08             	sub    $0x8,%esp
    *(void(**)(void))(code-8) = mpenter;
8010374a:	c7 05 f8 6f 00 80 60 	movl   $0x80103660,0x80006ff8
80103751:	36 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
80103754:	c7 05 f4 6f 00 80 00 	movl   $0x10a000,0x80006ff4
8010375b:	a0 10 00 
    *(void**)(code-4) = stack + KSTACKSIZE;
8010375e:	05 00 10 00 00       	add    $0x1000,%eax
80103763:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc
    lapicstartap(c->apicid, V2P(code));
80103768:	0f b6 03             	movzbl (%ebx),%eax
8010376b:	68 00 70 00 00       	push   $0x7000
80103770:	50                   	push   %eax
80103771:	e8 ba f7 ff ff       	call   80102f30 <lapicstartap>

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80103776:	83 c4 10             	add    $0x10,%esp
80103779:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103780:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80103786:	85 c0                	test   %eax,%eax
80103788:	74 f6                	je     80103780 <main+0x100>
8010378a:	eb 94                	jmp    80103720 <main+0xa0>
8010378c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80103790:	83 ec 08             	sub    $0x8,%esp
80103793:	68 00 00 00 8e       	push   $0x8e000000
80103798:	68 00 00 40 80       	push   $0x80400000
8010379d:	e8 6e f4 ff ff       	call   80102c10 <kinit2>
  userinit();      // first user process
801037a2:	e8 29 08 00 00       	call   80103fd0 <userinit>
  mpmain();        // finish this processor's setup
801037a7:	e8 74 fe ff ff       	call   80103620 <mpmain>
801037ac:	66 90                	xchg   %ax,%ax
801037ae:	66 90                	xchg   %ax,%ax

801037b0 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
801037b0:	55                   	push   %ebp
801037b1:	89 e5                	mov    %esp,%ebp
801037b3:	57                   	push   %edi
801037b4:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
801037b5:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
{
801037bb:	53                   	push   %ebx
  e = addr+len;
801037bc:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
{
801037bf:	83 ec 0c             	sub    $0xc,%esp
  for(p = addr; p < e; p += sizeof(struct mp))
801037c2:	39 de                	cmp    %ebx,%esi
801037c4:	72 10                	jb     801037d6 <mpsearch1+0x26>
801037c6:	eb 50                	jmp    80103818 <mpsearch1+0x68>
801037c8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801037cf:	90                   	nop
801037d0:	89 fe                	mov    %edi,%esi
801037d2:	39 fb                	cmp    %edi,%ebx
801037d4:	76 42                	jbe    80103818 <mpsearch1+0x68>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801037d6:	83 ec 04             	sub    $0x4,%esp
801037d9:	8d 7e 10             	lea    0x10(%esi),%edi
801037dc:	6a 04                	push   $0x4
801037de:	68 58 7e 10 80       	push   $0x80107e58
801037e3:	56                   	push   %esi
801037e4:	e8 f7 15 00 00       	call   80104de0 <memcmp>
801037e9:	83 c4 10             	add    $0x10,%esp
801037ec:	85 c0                	test   %eax,%eax
801037ee:	75 e0                	jne    801037d0 <mpsearch1+0x20>
801037f0:	89 f2                	mov    %esi,%edx
801037f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    sum += addr[i];
801037f8:	0f b6 0a             	movzbl (%edx),%ecx
801037fb:	83 c2 01             	add    $0x1,%edx
801037fe:	01 c8                	add    %ecx,%eax
  for(i=0; i<len; i++)
80103800:	39 fa                	cmp    %edi,%edx
80103802:	75 f4                	jne    801037f8 <mpsearch1+0x48>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103804:	84 c0                	test   %al,%al
80103806:	75 c8                	jne    801037d0 <mpsearch1+0x20>
      return (struct mp*)p;
  return 0;
}
80103808:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010380b:	89 f0                	mov    %esi,%eax
8010380d:	5b                   	pop    %ebx
8010380e:	5e                   	pop    %esi
8010380f:	5f                   	pop    %edi
80103810:	5d                   	pop    %ebp
80103811:	c3                   	ret    
80103812:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103818:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010381b:	31 f6                	xor    %esi,%esi
}
8010381d:	5b                   	pop    %ebx
8010381e:	89 f0                	mov    %esi,%eax
80103820:	5e                   	pop    %esi
80103821:	5f                   	pop    %edi
80103822:	5d                   	pop    %ebp
80103823:	c3                   	ret    
80103824:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010382b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010382f:	90                   	nop

80103830 <mpinit>:
  return conf;
}

void
mpinit(void)
{
80103830:	f3 0f 1e fb          	endbr32 
80103834:	55                   	push   %ebp
80103835:	89 e5                	mov    %esp,%ebp
80103837:	57                   	push   %edi
80103838:	56                   	push   %esi
80103839:	53                   	push   %ebx
8010383a:	83 ec 1c             	sub    $0x1c,%esp
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
8010383d:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
80103844:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
8010384b:	c1 e0 08             	shl    $0x8,%eax
8010384e:	09 d0                	or     %edx,%eax
80103850:	c1 e0 04             	shl    $0x4,%eax
80103853:	75 1b                	jne    80103870 <mpinit+0x40>
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
80103855:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
8010385c:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
80103863:	c1 e0 08             	shl    $0x8,%eax
80103866:	09 d0                	or     %edx,%eax
80103868:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
8010386b:	2d 00 04 00 00       	sub    $0x400,%eax
    if((mp = mpsearch1(p, 1024)))
80103870:	ba 00 04 00 00       	mov    $0x400,%edx
80103875:	e8 36 ff ff ff       	call   801037b0 <mpsearch1>
8010387a:	89 c6                	mov    %eax,%esi
8010387c:	85 c0                	test   %eax,%eax
8010387e:	0f 84 4c 01 00 00    	je     801039d0 <mpinit+0x1a0>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103884:	8b 5e 04             	mov    0x4(%esi),%ebx
80103887:	85 db                	test   %ebx,%ebx
80103889:	0f 84 61 01 00 00    	je     801039f0 <mpinit+0x1c0>
  if(memcmp(conf, "PCMP", 4) != 0)
8010388f:	83 ec 04             	sub    $0x4,%esp
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
80103892:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
  if(memcmp(conf, "PCMP", 4) != 0)
80103898:	6a 04                	push   $0x4
8010389a:	68 5d 7e 10 80       	push   $0x80107e5d
8010389f:	50                   	push   %eax
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
801038a0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(memcmp(conf, "PCMP", 4) != 0)
801038a3:	e8 38 15 00 00       	call   80104de0 <memcmp>
801038a8:	83 c4 10             	add    $0x10,%esp
801038ab:	85 c0                	test   %eax,%eax
801038ad:	0f 85 3d 01 00 00    	jne    801039f0 <mpinit+0x1c0>
  if(conf->version != 1 && conf->version != 4)
801038b3:	0f b6 83 06 00 00 80 	movzbl -0x7ffffffa(%ebx),%eax
801038ba:	3c 01                	cmp    $0x1,%al
801038bc:	74 08                	je     801038c6 <mpinit+0x96>
801038be:	3c 04                	cmp    $0x4,%al
801038c0:	0f 85 2a 01 00 00    	jne    801039f0 <mpinit+0x1c0>
  if(sum((uchar*)conf, conf->length) != 0)
801038c6:	0f b7 93 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edx
  for(i=0; i<len; i++)
801038cd:	66 85 d2             	test   %dx,%dx
801038d0:	74 26                	je     801038f8 <mpinit+0xc8>
801038d2:	8d 3c 1a             	lea    (%edx,%ebx,1),%edi
801038d5:	89 d8                	mov    %ebx,%eax
  sum = 0;
801038d7:	31 d2                	xor    %edx,%edx
801038d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    sum += addr[i];
801038e0:	0f b6 88 00 00 00 80 	movzbl -0x80000000(%eax),%ecx
801038e7:	83 c0 01             	add    $0x1,%eax
801038ea:	01 ca                	add    %ecx,%edx
  for(i=0; i<len; i++)
801038ec:	39 f8                	cmp    %edi,%eax
801038ee:	75 f0                	jne    801038e0 <mpinit+0xb0>
  if(sum((uchar*)conf, conf->length) != 0)
801038f0:	84 d2                	test   %dl,%dl
801038f2:	0f 85 f8 00 00 00    	jne    801039f0 <mpinit+0x1c0>
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
801038f8:	8b 83 24 00 00 80    	mov    -0x7fffffdc(%ebx),%eax
801038fe:	a3 bc 42 11 80       	mov    %eax,0x801142bc
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103903:	8d 83 2c 00 00 80    	lea    -0x7fffffd4(%ebx),%eax
80103909:	0f b7 93 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edx
  ismp = 1;
80103910:	bb 01 00 00 00       	mov    $0x1,%ebx
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103915:	03 55 e4             	add    -0x1c(%ebp),%edx
80103918:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
8010391b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010391f:	90                   	nop
80103920:	39 c2                	cmp    %eax,%edx
80103922:	76 15                	jbe    80103939 <mpinit+0x109>
    switch(*p){
80103924:	0f b6 08             	movzbl (%eax),%ecx
80103927:	80 f9 02             	cmp    $0x2,%cl
8010392a:	74 5c                	je     80103988 <mpinit+0x158>
8010392c:	77 42                	ja     80103970 <mpinit+0x140>
8010392e:	84 c9                	test   %cl,%cl
80103930:	74 6e                	je     801039a0 <mpinit+0x170>
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
80103932:	83 c0 08             	add    $0x8,%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103935:	39 c2                	cmp    %eax,%edx
80103937:	77 eb                	ja     80103924 <mpinit+0xf4>
80103939:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
8010393c:	85 db                	test   %ebx,%ebx
8010393e:	0f 84 b9 00 00 00    	je     801039fd <mpinit+0x1cd>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
80103944:	80 7e 0c 00          	cmpb   $0x0,0xc(%esi)
80103948:	74 15                	je     8010395f <mpinit+0x12f>
  asm volatile("out %0,%1" : : "a"(data), "d"(port));
8010394a:	b8 70 00 00 00       	mov    $0x70,%eax
8010394f:	ba 22 00 00 00       	mov    $0x22,%edx
80103954:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a"(data) : "d"(port));
80103955:	ba 23 00 00 00       	mov    $0x23,%edx
8010395a:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
8010395b:	83 c8 01             	or     $0x1,%eax
  asm volatile("out %0,%1" : : "a"(data), "d"(port));
8010395e:	ee                   	out    %al,(%dx)
  }
}
8010395f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103962:	5b                   	pop    %ebx
80103963:	5e                   	pop    %esi
80103964:	5f                   	pop    %edi
80103965:	5d                   	pop    %ebp
80103966:	c3                   	ret    
80103967:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010396e:	66 90                	xchg   %ax,%ax
    switch(*p){
80103970:	83 e9 03             	sub    $0x3,%ecx
80103973:	80 f9 01             	cmp    $0x1,%cl
80103976:	76 ba                	jbe    80103932 <mpinit+0x102>
80103978:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
8010397f:	eb 9f                	jmp    80103920 <mpinit+0xf0>
80103981:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      ioapicid = ioapic->apicno;
80103988:	0f b6 48 01          	movzbl 0x1(%eax),%ecx
      p += sizeof(struct mpioapic);
8010398c:	83 c0 08             	add    $0x8,%eax
      ioapicid = ioapic->apicno;
8010398f:	88 0d a0 43 11 80    	mov    %cl,0x801143a0
      continue;
80103995:	eb 89                	jmp    80103920 <mpinit+0xf0>
80103997:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010399e:	66 90                	xchg   %ax,%ax
      if(ncpu < NCPU) {
801039a0:	8b 0d 40 49 11 80    	mov    0x80114940,%ecx
801039a6:	83 f9 07             	cmp    $0x7,%ecx
801039a9:	7f 19                	jg     801039c4 <mpinit+0x194>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
801039ab:	69 f9 b0 00 00 00    	imul   $0xb0,%ecx,%edi
801039b1:	0f b6 58 01          	movzbl 0x1(%eax),%ebx
        ncpu++;
801039b5:	83 c1 01             	add    $0x1,%ecx
801039b8:	89 0d 40 49 11 80    	mov    %ecx,0x80114940
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
801039be:	88 9f c0 43 11 80    	mov    %bl,-0x7feebc40(%edi)
      p += sizeof(struct mpproc);
801039c4:	83 c0 14             	add    $0x14,%eax
      continue;
801039c7:	e9 54 ff ff ff       	jmp    80103920 <mpinit+0xf0>
801039cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  return mpsearch1(0xF0000, 0x10000);
801039d0:	ba 00 00 01 00       	mov    $0x10000,%edx
801039d5:	b8 00 00 0f 00       	mov    $0xf0000,%eax
801039da:	e8 d1 fd ff ff       	call   801037b0 <mpsearch1>
801039df:	89 c6                	mov    %eax,%esi
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801039e1:	85 c0                	test   %eax,%eax
801039e3:	0f 85 9b fe ff ff    	jne    80103884 <mpinit+0x54>
801039e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    panic("Expect to run on an SMP");
801039f0:	83 ec 0c             	sub    $0xc,%esp
801039f3:	68 62 7e 10 80       	push   $0x80107e62
801039f8:	e8 b3 c9 ff ff       	call   801003b0 <panic>
    panic("Didn't find a suitable machine");
801039fd:	83 ec 0c             	sub    $0xc,%esp
80103a00:	68 7c 7e 10 80       	push   $0x80107e7c
80103a05:	e8 a6 c9 ff ff       	call   801003b0 <panic>
80103a0a:	66 90                	xchg   %ax,%ax
80103a0c:	66 90                	xchg   %ax,%ax
80103a0e:	66 90                	xchg   %ax,%ax

80103a10 <picinit>:
#define IO_PIC2         0xA0    // Slave (IRQs 8-15)

// Don't use the 8259A interrupt controllers.  Xv6 assumes SMP hardware.
void
picinit(void)
{
80103a10:	f3 0f 1e fb          	endbr32 
80103a14:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103a19:	ba 21 00 00 00       	mov    $0x21,%edx
80103a1e:	ee                   	out    %al,(%dx)
80103a1f:	ba a1 00 00 00       	mov    $0xa1,%edx
80103a24:	ee                   	out    %al,(%dx)
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
80103a25:	c3                   	ret    
80103a26:	66 90                	xchg   %ax,%ax
80103a28:	66 90                	xchg   %ax,%ax
80103a2a:	66 90                	xchg   %ax,%ax
80103a2c:	66 90                	xchg   %ax,%ax
80103a2e:	66 90                	xchg   %ax,%ax

80103a30 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80103a30:	f3 0f 1e fb          	endbr32 
80103a34:	55                   	push   %ebp
80103a35:	89 e5                	mov    %esp,%ebp
80103a37:	57                   	push   %edi
80103a38:	56                   	push   %esi
80103a39:	53                   	push   %ebx
80103a3a:	83 ec 0c             	sub    $0xc,%esp
80103a3d:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103a40:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
80103a43:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80103a49:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
80103a4f:	e8 ec d9 ff ff       	call   80101440 <filealloc>
80103a54:	89 03                	mov    %eax,(%ebx)
80103a56:	85 c0                	test   %eax,%eax
80103a58:	0f 84 ac 00 00 00    	je     80103b0a <pipealloc+0xda>
80103a5e:	e8 dd d9 ff ff       	call   80101440 <filealloc>
80103a63:	89 06                	mov    %eax,(%esi)
80103a65:	85 c0                	test   %eax,%eax
80103a67:	0f 84 8b 00 00 00    	je     80103af8 <pipealloc+0xc8>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80103a6d:	e8 fe f1 ff ff       	call   80102c70 <kalloc>
80103a72:	89 c7                	mov    %eax,%edi
80103a74:	85 c0                	test   %eax,%eax
80103a76:	0f 84 b4 00 00 00    	je     80103b30 <pipealloc+0x100>
    goto bad;
  p->readopen = 1;
80103a7c:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
80103a83:	00 00 00 
  p->writeopen = 1;
  p->nwrite = 0;
  p->nread = 0;
  initlock(&p->lock, "pipe");
80103a86:	83 ec 08             	sub    $0x8,%esp
  p->writeopen = 1;
80103a89:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
80103a90:	00 00 00 
  p->nwrite = 0;
80103a93:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
80103a9a:	00 00 00 
  p->nread = 0;
80103a9d:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
80103aa4:	00 00 00 
  initlock(&p->lock, "pipe");
80103aa7:	68 9b 7e 10 80       	push   $0x80107e9b
80103aac:	50                   	push   %eax
80103aad:	e8 4e 10 00 00       	call   80104b00 <initlock>
  (*f0)->type = FD_PIPE;
80103ab2:	8b 03                	mov    (%ebx),%eax
  (*f0)->pipe = p;
  (*f1)->type = FD_PIPE;
  (*f1)->readable = 0;
  (*f1)->writable = 1;
  (*f1)->pipe = p;
  return 0;
80103ab4:	83 c4 10             	add    $0x10,%esp
  (*f0)->type = FD_PIPE;
80103ab7:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
80103abd:	8b 03                	mov    (%ebx),%eax
80103abf:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
80103ac3:	8b 03                	mov    (%ebx),%eax
80103ac5:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
80103ac9:	8b 03                	mov    (%ebx),%eax
80103acb:	89 78 0c             	mov    %edi,0xc(%eax)
  (*f1)->type = FD_PIPE;
80103ace:	8b 06                	mov    (%esi),%eax
80103ad0:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
80103ad6:	8b 06                	mov    (%esi),%eax
80103ad8:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
80103adc:	8b 06                	mov    (%esi),%eax
80103ade:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
80103ae2:	8b 06                	mov    (%esi),%eax
80103ae4:	89 78 0c             	mov    %edi,0xc(%eax)
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
80103ae7:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80103aea:	31 c0                	xor    %eax,%eax
}
80103aec:	5b                   	pop    %ebx
80103aed:	5e                   	pop    %esi
80103aee:	5f                   	pop    %edi
80103aef:	5d                   	pop    %ebp
80103af0:	c3                   	ret    
80103af1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(*f0)
80103af8:	8b 03                	mov    (%ebx),%eax
80103afa:	85 c0                	test   %eax,%eax
80103afc:	74 1e                	je     80103b1c <pipealloc+0xec>
    fileclose(*f0);
80103afe:	83 ec 0c             	sub    $0xc,%esp
80103b01:	50                   	push   %eax
80103b02:	e8 f9 d9 ff ff       	call   80101500 <fileclose>
80103b07:	83 c4 10             	add    $0x10,%esp
  if(*f1)
80103b0a:	8b 06                	mov    (%esi),%eax
80103b0c:	85 c0                	test   %eax,%eax
80103b0e:	74 0c                	je     80103b1c <pipealloc+0xec>
    fileclose(*f1);
80103b10:	83 ec 0c             	sub    $0xc,%esp
80103b13:	50                   	push   %eax
80103b14:	e8 e7 d9 ff ff       	call   80101500 <fileclose>
80103b19:	83 c4 10             	add    $0x10,%esp
}
80103b1c:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
80103b1f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80103b24:	5b                   	pop    %ebx
80103b25:	5e                   	pop    %esi
80103b26:	5f                   	pop    %edi
80103b27:	5d                   	pop    %ebp
80103b28:	c3                   	ret    
80103b29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(*f0)
80103b30:	8b 03                	mov    (%ebx),%eax
80103b32:	85 c0                	test   %eax,%eax
80103b34:	75 c8                	jne    80103afe <pipealloc+0xce>
80103b36:	eb d2                	jmp    80103b0a <pipealloc+0xda>
80103b38:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103b3f:	90                   	nop

80103b40 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
80103b40:	f3 0f 1e fb          	endbr32 
80103b44:	55                   	push   %ebp
80103b45:	89 e5                	mov    %esp,%ebp
80103b47:	56                   	push   %esi
80103b48:	53                   	push   %ebx
80103b49:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103b4c:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
80103b4f:	83 ec 0c             	sub    $0xc,%esp
80103b52:	53                   	push   %ebx
80103b53:	e8 28 11 00 00       	call   80104c80 <acquire>
  if(writable){
80103b58:	83 c4 10             	add    $0x10,%esp
80103b5b:	85 f6                	test   %esi,%esi
80103b5d:	74 41                	je     80103ba0 <pipeclose+0x60>
    p->writeopen = 0;
    wakeup(&p->nread);
80103b5f:	83 ec 0c             	sub    $0xc,%esp
80103b62:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
    p->writeopen = 0;
80103b68:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
80103b6f:	00 00 00 
    wakeup(&p->nread);
80103b72:	50                   	push   %eax
80103b73:	e8 d8 0b 00 00       	call   80104750 <wakeup>
80103b78:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
80103b7b:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
80103b81:	85 d2                	test   %edx,%edx
80103b83:	75 0a                	jne    80103b8f <pipeclose+0x4f>
80103b85:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
80103b8b:	85 c0                	test   %eax,%eax
80103b8d:	74 31                	je     80103bc0 <pipeclose+0x80>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
80103b8f:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80103b92:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103b95:	5b                   	pop    %ebx
80103b96:	5e                   	pop    %esi
80103b97:	5d                   	pop    %ebp
    release(&p->lock);
80103b98:	e9 a3 11 00 00       	jmp    80104d40 <release>
80103b9d:	8d 76 00             	lea    0x0(%esi),%esi
    wakeup(&p->nwrite);
80103ba0:	83 ec 0c             	sub    $0xc,%esp
80103ba3:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
    p->readopen = 0;
80103ba9:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
80103bb0:	00 00 00 
    wakeup(&p->nwrite);
80103bb3:	50                   	push   %eax
80103bb4:	e8 97 0b 00 00       	call   80104750 <wakeup>
80103bb9:	83 c4 10             	add    $0x10,%esp
80103bbc:	eb bd                	jmp    80103b7b <pipeclose+0x3b>
80103bbe:	66 90                	xchg   %ax,%ax
    release(&p->lock);
80103bc0:	83 ec 0c             	sub    $0xc,%esp
80103bc3:	53                   	push   %ebx
80103bc4:	e8 77 11 00 00       	call   80104d40 <release>
    kfree((char*)p);
80103bc9:	89 5d 08             	mov    %ebx,0x8(%ebp)
80103bcc:	83 c4 10             	add    $0x10,%esp
}
80103bcf:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103bd2:	5b                   	pop    %ebx
80103bd3:	5e                   	pop    %esi
80103bd4:	5d                   	pop    %ebp
    kfree((char*)p);
80103bd5:	e9 d6 ee ff ff       	jmp    80102ab0 <kfree>
80103bda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103be0 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
80103be0:	f3 0f 1e fb          	endbr32 
80103be4:	55                   	push   %ebp
80103be5:	89 e5                	mov    %esp,%ebp
80103be7:	57                   	push   %edi
80103be8:	56                   	push   %esi
80103be9:	53                   	push   %ebx
80103bea:	83 ec 28             	sub    $0x28,%esp
80103bed:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  acquire(&p->lock);
80103bf0:	53                   	push   %ebx
80103bf1:	e8 8a 10 00 00       	call   80104c80 <acquire>
  for(i = 0; i < n; i++){
80103bf6:	8b 45 10             	mov    0x10(%ebp),%eax
80103bf9:	83 c4 10             	add    $0x10,%esp
80103bfc:	85 c0                	test   %eax,%eax
80103bfe:	0f 8e bc 00 00 00    	jle    80103cc0 <pipewrite+0xe0>
80103c04:	8b 45 0c             	mov    0xc(%ebp),%eax
80103c07:	8b 8b 38 02 00 00    	mov    0x238(%ebx),%ecx
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
80103c0d:	8d bb 34 02 00 00    	lea    0x234(%ebx),%edi
80103c13:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103c16:	03 45 10             	add    0x10(%ebp),%eax
80103c19:	89 45 e0             	mov    %eax,-0x20(%ebp)
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103c1c:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103c22:	8d b3 38 02 00 00    	lea    0x238(%ebx),%esi
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103c28:	89 ca                	mov    %ecx,%edx
80103c2a:	05 00 02 00 00       	add    $0x200,%eax
80103c2f:	39 c1                	cmp    %eax,%ecx
80103c31:	74 3b                	je     80103c6e <pipewrite+0x8e>
80103c33:	eb 63                	jmp    80103c98 <pipewrite+0xb8>
80103c35:	8d 76 00             	lea    0x0(%esi),%esi
      if(p->readopen == 0 || myproc()->killed){
80103c38:	e8 63 03 00 00       	call   80103fa0 <myproc>
80103c3d:	8b 48 24             	mov    0x24(%eax),%ecx
80103c40:	85 c9                	test   %ecx,%ecx
80103c42:	75 34                	jne    80103c78 <pipewrite+0x98>
      wakeup(&p->nread);
80103c44:	83 ec 0c             	sub    $0xc,%esp
80103c47:	57                   	push   %edi
80103c48:	e8 03 0b 00 00       	call   80104750 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103c4d:	58                   	pop    %eax
80103c4e:	5a                   	pop    %edx
80103c4f:	53                   	push   %ebx
80103c50:	56                   	push   %esi
80103c51:	e8 3a 09 00 00       	call   80104590 <sleep>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103c56:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
80103c5c:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
80103c62:	83 c4 10             	add    $0x10,%esp
80103c65:	05 00 02 00 00       	add    $0x200,%eax
80103c6a:	39 c2                	cmp    %eax,%edx
80103c6c:	75 2a                	jne    80103c98 <pipewrite+0xb8>
      if(p->readopen == 0 || myproc()->killed){
80103c6e:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
80103c74:	85 c0                	test   %eax,%eax
80103c76:	75 c0                	jne    80103c38 <pipewrite+0x58>
        release(&p->lock);
80103c78:	83 ec 0c             	sub    $0xc,%esp
80103c7b:	53                   	push   %ebx
80103c7c:	e8 bf 10 00 00       	call   80104d40 <release>
        return -1;
80103c81:	83 c4 10             	add    $0x10,%esp
80103c84:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
80103c89:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103c8c:	5b                   	pop    %ebx
80103c8d:	5e                   	pop    %esi
80103c8e:	5f                   	pop    %edi
80103c8f:	5d                   	pop    %ebp
80103c90:	c3                   	ret    
80103c91:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80103c98:	8b 75 e4             	mov    -0x1c(%ebp),%esi
80103c9b:	8d 4a 01             	lea    0x1(%edx),%ecx
80103c9e:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
80103ca4:	89 8b 38 02 00 00    	mov    %ecx,0x238(%ebx)
80103caa:	0f b6 06             	movzbl (%esi),%eax
80103cad:	83 c6 01             	add    $0x1,%esi
80103cb0:	89 75 e4             	mov    %esi,-0x1c(%ebp)
80103cb3:	88 44 13 34          	mov    %al,0x34(%ebx,%edx,1)
  for(i = 0; i < n; i++){
80103cb7:	3b 75 e0             	cmp    -0x20(%ebp),%esi
80103cba:	0f 85 5c ff ff ff    	jne    80103c1c <pipewrite+0x3c>
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
80103cc0:	83 ec 0c             	sub    $0xc,%esp
80103cc3:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80103cc9:	50                   	push   %eax
80103cca:	e8 81 0a 00 00       	call   80104750 <wakeup>
  release(&p->lock);
80103ccf:	89 1c 24             	mov    %ebx,(%esp)
80103cd2:	e8 69 10 00 00       	call   80104d40 <release>
  return n;
80103cd7:	8b 45 10             	mov    0x10(%ebp),%eax
80103cda:	83 c4 10             	add    $0x10,%esp
80103cdd:	eb aa                	jmp    80103c89 <pipewrite+0xa9>
80103cdf:	90                   	nop

80103ce0 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
80103ce0:	f3 0f 1e fb          	endbr32 
80103ce4:	55                   	push   %ebp
80103ce5:	89 e5                	mov    %esp,%ebp
80103ce7:	57                   	push   %edi
80103ce8:	56                   	push   %esi
80103ce9:	53                   	push   %ebx
80103cea:	83 ec 18             	sub    $0x18,%esp
80103ced:	8b 75 08             	mov    0x8(%ebp),%esi
80103cf0:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
80103cf3:	56                   	push   %esi
80103cf4:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
80103cfa:	e8 81 0f 00 00       	call   80104c80 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80103cff:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
80103d05:	83 c4 10             	add    $0x10,%esp
80103d08:	39 86 38 02 00 00    	cmp    %eax,0x238(%esi)
80103d0e:	74 33                	je     80103d43 <piperead+0x63>
80103d10:	eb 3b                	jmp    80103d4d <piperead+0x6d>
80103d12:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(myproc()->killed){
80103d18:	e8 83 02 00 00       	call   80103fa0 <myproc>
80103d1d:	8b 48 24             	mov    0x24(%eax),%ecx
80103d20:	85 c9                	test   %ecx,%ecx
80103d22:	0f 85 88 00 00 00    	jne    80103db0 <piperead+0xd0>
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
80103d28:	83 ec 08             	sub    $0x8,%esp
80103d2b:	56                   	push   %esi
80103d2c:	53                   	push   %ebx
80103d2d:	e8 5e 08 00 00       	call   80104590 <sleep>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80103d32:	8b 86 38 02 00 00    	mov    0x238(%esi),%eax
80103d38:	83 c4 10             	add    $0x10,%esp
80103d3b:	39 86 34 02 00 00    	cmp    %eax,0x234(%esi)
80103d41:	75 0a                	jne    80103d4d <piperead+0x6d>
80103d43:	8b 86 40 02 00 00    	mov    0x240(%esi),%eax
80103d49:	85 c0                	test   %eax,%eax
80103d4b:	75 cb                	jne    80103d18 <piperead+0x38>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103d4d:	8b 55 10             	mov    0x10(%ebp),%edx
80103d50:	31 db                	xor    %ebx,%ebx
80103d52:	85 d2                	test   %edx,%edx
80103d54:	7f 28                	jg     80103d7e <piperead+0x9e>
80103d56:	eb 34                	jmp    80103d8c <piperead+0xac>
80103d58:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103d5f:	90                   	nop
    if(p->nread == p->nwrite)
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
80103d60:	8d 48 01             	lea    0x1(%eax),%ecx
80103d63:	25 ff 01 00 00       	and    $0x1ff,%eax
80103d68:	89 8e 34 02 00 00    	mov    %ecx,0x234(%esi)
80103d6e:	0f b6 44 06 34       	movzbl 0x34(%esi,%eax,1),%eax
80103d73:	88 04 1f             	mov    %al,(%edi,%ebx,1)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103d76:	83 c3 01             	add    $0x1,%ebx
80103d79:	39 5d 10             	cmp    %ebx,0x10(%ebp)
80103d7c:	74 0e                	je     80103d8c <piperead+0xac>
    if(p->nread == p->nwrite)
80103d7e:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
80103d84:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
80103d8a:	75 d4                	jne    80103d60 <piperead+0x80>
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
80103d8c:	83 ec 0c             	sub    $0xc,%esp
80103d8f:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
80103d95:	50                   	push   %eax
80103d96:	e8 b5 09 00 00       	call   80104750 <wakeup>
  release(&p->lock);
80103d9b:	89 34 24             	mov    %esi,(%esp)
80103d9e:	e8 9d 0f 00 00       	call   80104d40 <release>
  return i;
80103da3:	83 c4 10             	add    $0x10,%esp
}
80103da6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103da9:	89 d8                	mov    %ebx,%eax
80103dab:	5b                   	pop    %ebx
80103dac:	5e                   	pop    %esi
80103dad:	5f                   	pop    %edi
80103dae:	5d                   	pop    %ebp
80103daf:	c3                   	ret    
      release(&p->lock);
80103db0:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80103db3:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
      release(&p->lock);
80103db8:	56                   	push   %esi
80103db9:	e8 82 0f 00 00       	call   80104d40 <release>
      return -1;
80103dbe:	83 c4 10             	add    $0x10,%esp
}
80103dc1:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103dc4:	89 d8                	mov    %ebx,%eax
80103dc6:	5b                   	pop    %ebx
80103dc7:	5e                   	pop    %esi
80103dc8:	5f                   	pop    %edi
80103dc9:	5d                   	pop    %ebp
80103dca:	c3                   	ret    
80103dcb:	66 90                	xchg   %ax,%ax
80103dcd:	66 90                	xchg   %ax,%ax
80103dcf:	90                   	nop

80103dd0 <allocproc>:
//  If found, change state to EMBRYO and initialize
//  state required to run in the kernel.
//  Otherwise return 0.
static struct proc *
allocproc(void)
{
80103dd0:	55                   	push   %ebp
80103dd1:	89 e5                	mov    %esp,%ebp
80103dd3:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103dd4:	bb 94 49 11 80       	mov    $0x80114994,%ebx
{
80103dd9:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);
80103ddc:	68 60 49 11 80       	push   $0x80114960
80103de1:	e8 9a 0e 00 00       	call   80104c80 <acquire>
80103de6:	83 c4 10             	add    $0x10,%esp
80103de9:	eb 10                	jmp    80103dfb <allocproc+0x2b>
80103deb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103def:	90                   	nop
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103df0:	83 eb 80             	sub    $0xffffff80,%ebx
80103df3:	81 fb 94 69 11 80    	cmp    $0x80116994,%ebx
80103df9:	74 75                	je     80103e70 <allocproc+0xa0>
    if (p->state == UNUSED)
80103dfb:	8b 43 0c             	mov    0xc(%ebx),%eax
80103dfe:	85 c0                	test   %eax,%eax
80103e00:	75 ee                	jne    80103df0 <allocproc+0x20>
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
80103e02:	a1 04 b0 10 80       	mov    0x8010b004,%eax

  release(&ptable.lock);
80103e07:	83 ec 0c             	sub    $0xc,%esp
  p->state = EMBRYO;
80103e0a:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->pid = nextpid++;
80103e11:	89 43 10             	mov    %eax,0x10(%ebx)
80103e14:	8d 50 01             	lea    0x1(%eax),%edx
  release(&ptable.lock);
80103e17:	68 60 49 11 80       	push   $0x80114960
  p->pid = nextpid++;
80103e1c:	89 15 04 b0 10 80    	mov    %edx,0x8010b004
  release(&ptable.lock);
80103e22:	e8 19 0f 00 00       	call   80104d40 <release>

  // Allocate kernel stack.
  if ((p->kstack = kalloc()) == 0)
80103e27:	e8 44 ee ff ff       	call   80102c70 <kalloc>
80103e2c:	83 c4 10             	add    $0x10,%esp
80103e2f:	89 43 08             	mov    %eax,0x8(%ebx)
80103e32:	85 c0                	test   %eax,%eax
80103e34:	74 53                	je     80103e89 <allocproc+0xb9>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
80103e36:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint *)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context *)sp;
  memset(p->context, 0, sizeof *p->context);
80103e3c:	83 ec 04             	sub    $0x4,%esp
  sp -= sizeof *p->context;
80103e3f:	05 9c 0f 00 00       	add    $0xf9c,%eax
  sp -= sizeof *p->tf;
80103e44:	89 53 18             	mov    %edx,0x18(%ebx)
  *(uint *)sp = (uint)trapret;
80103e47:	c7 40 14 b5 60 10 80 	movl   $0x801060b5,0x14(%eax)
  p->context = (struct context *)sp;
80103e4e:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
80103e51:	6a 14                	push   $0x14
80103e53:	6a 00                	push   $0x0
80103e55:	50                   	push   %eax
80103e56:	e8 35 0f 00 00       	call   80104d90 <memset>
  p->context->eip = (uint)forkret;
80103e5b:	8b 43 1c             	mov    0x1c(%ebx),%eax

  return p;
80103e5e:	83 c4 10             	add    $0x10,%esp
  p->context->eip = (uint)forkret;
80103e61:	c7 40 10 a0 3e 10 80 	movl   $0x80103ea0,0x10(%eax)
}
80103e68:	89 d8                	mov    %ebx,%eax
80103e6a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103e6d:	c9                   	leave  
80103e6e:	c3                   	ret    
80103e6f:	90                   	nop
  release(&ptable.lock);
80103e70:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80103e73:	31 db                	xor    %ebx,%ebx
  release(&ptable.lock);
80103e75:	68 60 49 11 80       	push   $0x80114960
80103e7a:	e8 c1 0e 00 00       	call   80104d40 <release>
}
80103e7f:	89 d8                	mov    %ebx,%eax
  return 0;
80103e81:	83 c4 10             	add    $0x10,%esp
}
80103e84:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103e87:	c9                   	leave  
80103e88:	c3                   	ret    
    p->state = UNUSED;
80103e89:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return 0;
80103e90:	31 db                	xor    %ebx,%ebx
}
80103e92:	89 d8                	mov    %ebx,%eax
80103e94:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103e97:	c9                   	leave  
80103e98:	c3                   	ret    
80103e99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103ea0 <forkret>:
}

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void forkret(void)
{
80103ea0:	f3 0f 1e fb          	endbr32 
80103ea4:	55                   	push   %ebp
80103ea5:	89 e5                	mov    %esp,%ebp
80103ea7:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
80103eaa:	68 60 49 11 80       	push   $0x80114960
80103eaf:	e8 8c 0e 00 00       	call   80104d40 <release>

  if (first)
80103eb4:	a1 00 b0 10 80       	mov    0x8010b000,%eax
80103eb9:	83 c4 10             	add    $0x10,%esp
80103ebc:	85 c0                	test   %eax,%eax
80103ebe:	75 08                	jne    80103ec8 <forkret+0x28>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
80103ec0:	c9                   	leave  
80103ec1:	c3                   	ret    
80103ec2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    first = 0;
80103ec8:	c7 05 00 b0 10 80 00 	movl   $0x0,0x8010b000
80103ecf:	00 00 00 
    iinit(ROOTDEV);
80103ed2:	83 ec 0c             	sub    $0xc,%esp
80103ed5:	6a 01                	push   $0x1
80103ed7:	e8 a4 dc ff ff       	call   80101b80 <iinit>
    initlog(ROOTDEV);
80103edc:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80103ee3:	e8 e8 f3 ff ff       	call   801032d0 <initlog>
}
80103ee8:	83 c4 10             	add    $0x10,%esp
80103eeb:	c9                   	leave  
80103eec:	c3                   	ret    
80103eed:	8d 76 00             	lea    0x0(%esi),%esi

80103ef0 <pinit>:
{
80103ef0:	f3 0f 1e fb          	endbr32 
80103ef4:	55                   	push   %ebp
80103ef5:	89 e5                	mov    %esp,%ebp
80103ef7:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
80103efa:	68 a0 7e 10 80       	push   $0x80107ea0
80103eff:	68 60 49 11 80       	push   $0x80114960
80103f04:	e8 f7 0b 00 00       	call   80104b00 <initlock>
}
80103f09:	83 c4 10             	add    $0x10,%esp
80103f0c:	c9                   	leave  
80103f0d:	c3                   	ret    
80103f0e:	66 90                	xchg   %ax,%ax

80103f10 <mycpu>:
{
80103f10:	f3 0f 1e fb          	endbr32 
80103f14:	55                   	push   %ebp
80103f15:	89 e5                	mov    %esp,%ebp
80103f17:	56                   	push   %esi
80103f18:	53                   	push   %ebx
  asm volatile("pushfl; popl %0" : "=r"(eflags));
80103f19:	9c                   	pushf  
80103f1a:	58                   	pop    %eax
  if (readeflags() & FL_IF)
80103f1b:	f6 c4 02             	test   $0x2,%ah
80103f1e:	75 4a                	jne    80103f6a <mycpu+0x5a>
  apicid = lapicid();
80103f20:	e8 bb ef ff ff       	call   80102ee0 <lapicid>
  for (i = 0; i < ncpu; ++i)
80103f25:	8b 35 40 49 11 80    	mov    0x80114940,%esi
  apicid = lapicid();
80103f2b:	89 c3                	mov    %eax,%ebx
  for (i = 0; i < ncpu; ++i)
80103f2d:	85 f6                	test   %esi,%esi
80103f2f:	7e 2c                	jle    80103f5d <mycpu+0x4d>
80103f31:	31 d2                	xor    %edx,%edx
80103f33:	eb 0a                	jmp    80103f3f <mycpu+0x2f>
80103f35:	8d 76 00             	lea    0x0(%esi),%esi
80103f38:	83 c2 01             	add    $0x1,%edx
80103f3b:	39 f2                	cmp    %esi,%edx
80103f3d:	74 1e                	je     80103f5d <mycpu+0x4d>
    if (cpus[i].apicid == apicid)
80103f3f:	69 ca b0 00 00 00    	imul   $0xb0,%edx,%ecx
80103f45:	0f b6 81 c0 43 11 80 	movzbl -0x7feebc40(%ecx),%eax
80103f4c:	39 d8                	cmp    %ebx,%eax
80103f4e:	75 e8                	jne    80103f38 <mycpu+0x28>
}
80103f50:	8d 65 f8             	lea    -0x8(%ebp),%esp
      return &cpus[i];
80103f53:	8d 81 c0 43 11 80    	lea    -0x7feebc40(%ecx),%eax
}
80103f59:	5b                   	pop    %ebx
80103f5a:	5e                   	pop    %esi
80103f5b:	5d                   	pop    %ebp
80103f5c:	c3                   	ret    
  panic("unknown apicid\n");
80103f5d:	83 ec 0c             	sub    $0xc,%esp
80103f60:	68 a7 7e 10 80       	push   $0x80107ea7
80103f65:	e8 46 c4 ff ff       	call   801003b0 <panic>
    panic("mycpu called with interrupts enabled\n");
80103f6a:	83 ec 0c             	sub    $0xc,%esp
80103f6d:	68 84 7f 10 80       	push   $0x80107f84
80103f72:	e8 39 c4 ff ff       	call   801003b0 <panic>
80103f77:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103f7e:	66 90                	xchg   %ax,%ax

80103f80 <cpuid>:
{
80103f80:	f3 0f 1e fb          	endbr32 
80103f84:	55                   	push   %ebp
80103f85:	89 e5                	mov    %esp,%ebp
80103f87:	83 ec 08             	sub    $0x8,%esp
  return mycpu() - cpus;
80103f8a:	e8 81 ff ff ff       	call   80103f10 <mycpu>
}
80103f8f:	c9                   	leave  
  return mycpu() - cpus;
80103f90:	2d c0 43 11 80       	sub    $0x801143c0,%eax
80103f95:	c1 f8 04             	sar    $0x4,%eax
80103f98:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
80103f9e:	c3                   	ret    
80103f9f:	90                   	nop

80103fa0 <myproc>:
{
80103fa0:	f3 0f 1e fb          	endbr32 
80103fa4:	55                   	push   %ebp
80103fa5:	89 e5                	mov    %esp,%ebp
80103fa7:	53                   	push   %ebx
80103fa8:	83 ec 04             	sub    $0x4,%esp
  pushcli();
80103fab:	e8 d0 0b 00 00       	call   80104b80 <pushcli>
  c = mycpu();
80103fb0:	e8 5b ff ff ff       	call   80103f10 <mycpu>
  p = c->proc;
80103fb5:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103fbb:	e8 10 0c 00 00       	call   80104bd0 <popcli>
}
80103fc0:	83 c4 04             	add    $0x4,%esp
80103fc3:	89 d8                	mov    %ebx,%eax
80103fc5:	5b                   	pop    %ebx
80103fc6:	5d                   	pop    %ebp
80103fc7:	c3                   	ret    
80103fc8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103fcf:	90                   	nop

80103fd0 <userinit>:
{
80103fd0:	f3 0f 1e fb          	endbr32 
80103fd4:	55                   	push   %ebp
80103fd5:	89 e5                	mov    %esp,%ebp
80103fd7:	53                   	push   %ebx
80103fd8:	83 ec 04             	sub    $0x4,%esp
  p = allocproc();
80103fdb:	e8 f0 fd ff ff       	call   80103dd0 <allocproc>
80103fe0:	89 c3                	mov    %eax,%ebx
  initproc = p;
80103fe2:	a3 38 c2 10 80       	mov    %eax,0x8010c238
  if ((p->pgdir = setupkvm()) == 0)
80103fe7:	e8 84 36 00 00       	call   80107670 <setupkvm>
80103fec:	89 43 04             	mov    %eax,0x4(%ebx)
80103fef:	85 c0                	test   %eax,%eax
80103ff1:	0f 84 bd 00 00 00    	je     801040b4 <userinit+0xe4>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80103ff7:	83 ec 04             	sub    $0x4,%esp
80103ffa:	68 2c 00 00 00       	push   $0x2c
80103fff:	68 60 b4 10 80       	push   $0x8010b460
80104004:	50                   	push   %eax
80104005:	e8 36 33 00 00       	call   80107340 <inituvm>
  memset(p->tf, 0, sizeof(*p->tf));
8010400a:	83 c4 0c             	add    $0xc,%esp
  p->sz = PGSIZE;
8010400d:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
80104013:	6a 4c                	push   $0x4c
80104015:	6a 00                	push   $0x0
80104017:	ff 73 18             	pushl  0x18(%ebx)
8010401a:	e8 71 0d 00 00       	call   80104d90 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
8010401f:	8b 43 18             	mov    0x18(%ebx),%eax
80104022:	ba 1b 00 00 00       	mov    $0x1b,%edx
  safestrcpy(p->name, "initcode", sizeof(p->name));
80104027:	83 c4 0c             	add    $0xc,%esp
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
8010402a:	b9 23 00 00 00       	mov    $0x23,%ecx
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
8010402f:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80104033:	8b 43 18             	mov    0x18(%ebx),%eax
80104036:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
8010403a:	8b 43 18             	mov    0x18(%ebx),%eax
8010403d:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80104041:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80104045:	8b 43 18             	mov    0x18(%ebx),%eax
80104048:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
8010404c:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
80104050:	8b 43 18             	mov    0x18(%ebx),%eax
80104053:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
8010405a:	8b 43 18             	mov    0x18(%ebx),%eax
8010405d:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0; // beginning of initcode.S
80104064:	8b 43 18             	mov    0x18(%ebx),%eax
80104067:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  safestrcpy(p->name, "initcode", sizeof(p->name));
8010406e:	8d 43 70             	lea    0x70(%ebx),%eax
80104071:	6a 10                	push   $0x10
80104073:	68 d0 7e 10 80       	push   $0x80107ed0
80104078:	50                   	push   %eax
80104079:	e8 d2 0e 00 00       	call   80104f50 <safestrcpy>
  p->cwd = namei("/");
8010407e:	c7 04 24 d9 7e 10 80 	movl   $0x80107ed9,(%esp)
80104085:	e8 e6 e5 ff ff       	call   80102670 <namei>
8010408a:	89 43 68             	mov    %eax,0x68(%ebx)
  acquire(&ptable.lock);
8010408d:	c7 04 24 60 49 11 80 	movl   $0x80114960,(%esp)
80104094:	e8 e7 0b 00 00       	call   80104c80 <acquire>
  p->state = RUNNABLE;
80104099:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
801040a0:	c7 04 24 60 49 11 80 	movl   $0x80114960,(%esp)
801040a7:	e8 94 0c 00 00       	call   80104d40 <release>
}
801040ac:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801040af:	83 c4 10             	add    $0x10,%esp
801040b2:	c9                   	leave  
801040b3:	c3                   	ret    
    panic("userinit: out of memory?");
801040b4:	83 ec 0c             	sub    $0xc,%esp
801040b7:	68 b7 7e 10 80       	push   $0x80107eb7
801040bc:	e8 ef c2 ff ff       	call   801003b0 <panic>
801040c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801040c8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801040cf:	90                   	nop

801040d0 <growproc>:
{
801040d0:	f3 0f 1e fb          	endbr32 
801040d4:	55                   	push   %ebp
801040d5:	89 e5                	mov    %esp,%ebp
801040d7:	56                   	push   %esi
801040d8:	53                   	push   %ebx
801040d9:	8b 75 08             	mov    0x8(%ebp),%esi
  pushcli();
801040dc:	e8 9f 0a 00 00       	call   80104b80 <pushcli>
  c = mycpu();
801040e1:	e8 2a fe ff ff       	call   80103f10 <mycpu>
  p = c->proc;
801040e6:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801040ec:	e8 df 0a 00 00       	call   80104bd0 <popcli>
  sz = curproc->sz;
801040f1:	8b 03                	mov    (%ebx),%eax
  if (n > 0)
801040f3:	85 f6                	test   %esi,%esi
801040f5:	7f 19                	jg     80104110 <growproc+0x40>
  else if (n < 0)
801040f7:	75 37                	jne    80104130 <growproc+0x60>
  switchuvm(curproc);
801040f9:	83 ec 0c             	sub    $0xc,%esp
  curproc->sz = sz;
801040fc:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
801040fe:	53                   	push   %ebx
801040ff:	e8 2c 31 00 00       	call   80107230 <switchuvm>
  return 0;
80104104:	83 c4 10             	add    $0x10,%esp
80104107:	31 c0                	xor    %eax,%eax
}
80104109:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010410c:	5b                   	pop    %ebx
8010410d:	5e                   	pop    %esi
8010410e:	5d                   	pop    %ebp
8010410f:	c3                   	ret    
    if ((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
80104110:	83 ec 04             	sub    $0x4,%esp
80104113:	01 c6                	add    %eax,%esi
80104115:	56                   	push   %esi
80104116:	50                   	push   %eax
80104117:	ff 73 04             	pushl  0x4(%ebx)
8010411a:	e8 71 33 00 00       	call   80107490 <allocuvm>
8010411f:	83 c4 10             	add    $0x10,%esp
80104122:	85 c0                	test   %eax,%eax
80104124:	75 d3                	jne    801040f9 <growproc+0x29>
      return -1;
80104126:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010412b:	eb dc                	jmp    80104109 <growproc+0x39>
8010412d:	8d 76 00             	lea    0x0(%esi),%esi
    if ((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
80104130:	83 ec 04             	sub    $0x4,%esp
80104133:	01 c6                	add    %eax,%esi
80104135:	56                   	push   %esi
80104136:	50                   	push   %eax
80104137:	ff 73 04             	pushl  0x4(%ebx)
8010413a:	e8 81 34 00 00       	call   801075c0 <deallocuvm>
8010413f:	83 c4 10             	add    $0x10,%esp
80104142:	85 c0                	test   %eax,%eax
80104144:	75 b3                	jne    801040f9 <growproc+0x29>
80104146:	eb de                	jmp    80104126 <growproc+0x56>
80104148:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010414f:	90                   	nop

80104150 <fork>:
{
80104150:	f3 0f 1e fb          	endbr32 
80104154:	55                   	push   %ebp
80104155:	89 e5                	mov    %esp,%ebp
80104157:	57                   	push   %edi
80104158:	56                   	push   %esi
80104159:	53                   	push   %ebx
8010415a:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
8010415d:	e8 1e 0a 00 00       	call   80104b80 <pushcli>
  c = mycpu();
80104162:	e8 a9 fd ff ff       	call   80103f10 <mycpu>
  p = c->proc;
80104167:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
8010416d:	e8 5e 0a 00 00       	call   80104bd0 <popcli>
  if ((np = allocproc()) == 0)
80104172:	e8 59 fc ff ff       	call   80103dd0 <allocproc>
80104177:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010417a:	85 c0                	test   %eax,%eax
8010417c:	0f 84 e3 00 00 00    	je     80104265 <fork+0x115>
  if ((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0)
80104182:	83 ec 08             	sub    $0x8,%esp
80104185:	ff 33                	pushl  (%ebx)
80104187:	89 c7                	mov    %eax,%edi
80104189:	ff 73 04             	pushl  0x4(%ebx)
8010418c:	e8 af 35 00 00       	call   80107740 <copyuvm>
80104191:	83 c4 10             	add    $0x10,%esp
80104194:	89 47 04             	mov    %eax,0x4(%edi)
80104197:	85 c0                	test   %eax,%eax
80104199:	0f 84 cd 00 00 00    	je     8010426c <fork+0x11c>
  acquire(&tickslock);
8010419f:	83 ec 0c             	sub    $0xc,%esp
801041a2:	68 a0 69 11 80       	push   $0x801169a0
801041a7:	e8 d4 0a 00 00       	call   80104c80 <acquire>
  np->xticks = ticks; // creation time for this process
801041ac:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801041af:	a1 e0 71 11 80       	mov    0x801171e0,%eax
801041b4:	89 47 6c             	mov    %eax,0x6c(%edi)
  release(&tickslock);
801041b7:	c7 04 24 a0 69 11 80 	movl   $0x801169a0,(%esp)
801041be:	e8 7d 0b 00 00       	call   80104d40 <release>
  np->sz = curproc->sz;
801041c3:	8b 03                	mov    (%ebx),%eax
  *np->tf = *curproc->tf;
801041c5:	b9 13 00 00 00       	mov    $0x13,%ecx
  np->parent = curproc;
801041ca:	89 5f 14             	mov    %ebx,0x14(%edi)
  np->tf->eax = 0;
801041cd:	83 c4 10             	add    $0x10,%esp
  np->sz = curproc->sz;
801041d0:	89 07                	mov    %eax,(%edi)
  np->parent = curproc;
801041d2:	89 f8                	mov    %edi,%eax
  *np->tf = *curproc->tf;
801041d4:	8b 73 18             	mov    0x18(%ebx),%esi
801041d7:	8b 7f 18             	mov    0x18(%edi),%edi
801041da:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  for (i = 0; i < NOFILE; i++)
801041dc:	31 f6                	xor    %esi,%esi
  np->tf->eax = 0;
801041de:	8b 40 18             	mov    0x18(%eax),%eax
801041e1:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
  for (i = 0; i < NOFILE; i++)
801041e8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801041ef:	90                   	nop
    if (curproc->ofile[i])
801041f0:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
801041f4:	85 c0                	test   %eax,%eax
801041f6:	74 13                	je     8010420b <fork+0xbb>
      np->ofile[i] = filedup(curproc->ofile[i]);
801041f8:	83 ec 0c             	sub    $0xc,%esp
801041fb:	50                   	push   %eax
801041fc:	e8 af d2 ff ff       	call   801014b0 <filedup>
80104201:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80104204:	83 c4 10             	add    $0x10,%esp
80104207:	89 44 b2 28          	mov    %eax,0x28(%edx,%esi,4)
  for (i = 0; i < NOFILE; i++)
8010420b:	83 c6 01             	add    $0x1,%esi
8010420e:	83 fe 10             	cmp    $0x10,%esi
80104211:	75 dd                	jne    801041f0 <fork+0xa0>
  np->cwd = idup(curproc->cwd);
80104213:	83 ec 0c             	sub    $0xc,%esp
80104216:	ff 73 68             	pushl  0x68(%ebx)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80104219:	83 c3 70             	add    $0x70,%ebx
  np->cwd = idup(curproc->cwd);
8010421c:	e8 4f db ff ff       	call   80101d70 <idup>
80104221:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80104224:	83 c4 0c             	add    $0xc,%esp
  np->cwd = idup(curproc->cwd);
80104227:	89 47 68             	mov    %eax,0x68(%edi)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
8010422a:	8d 47 70             	lea    0x70(%edi),%eax
8010422d:	6a 10                	push   $0x10
8010422f:	53                   	push   %ebx
80104230:	50                   	push   %eax
80104231:	e8 1a 0d 00 00       	call   80104f50 <safestrcpy>
  pid = np->pid;
80104236:	8b 5f 10             	mov    0x10(%edi),%ebx
  acquire(&ptable.lock);
80104239:	c7 04 24 60 49 11 80 	movl   $0x80114960,(%esp)
80104240:	e8 3b 0a 00 00       	call   80104c80 <acquire>
  np->state = RUNNABLE;
80104245:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)
  release(&ptable.lock);
8010424c:	c7 04 24 60 49 11 80 	movl   $0x80114960,(%esp)
80104253:	e8 e8 0a 00 00       	call   80104d40 <release>
  return pid;
80104258:	83 c4 10             	add    $0x10,%esp
}
8010425b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010425e:	89 d8                	mov    %ebx,%eax
80104260:	5b                   	pop    %ebx
80104261:	5e                   	pop    %esi
80104262:	5f                   	pop    %edi
80104263:	5d                   	pop    %ebp
80104264:	c3                   	ret    
    return -1;
80104265:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
8010426a:	eb ef                	jmp    8010425b <fork+0x10b>
    kfree(np->kstack);
8010426c:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
8010426f:	83 ec 0c             	sub    $0xc,%esp
80104272:	ff 73 08             	pushl  0x8(%ebx)
80104275:	e8 36 e8 ff ff       	call   80102ab0 <kfree>
    np->kstack = 0;
8010427a:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
    return -1;
80104281:	83 c4 10             	add    $0x10,%esp
    np->state = UNUSED;
80104284:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return -1;
8010428b:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80104290:	eb c9                	jmp    8010425b <fork+0x10b>
80104292:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104299:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801042a0 <scheduler>:
{
801042a0:	f3 0f 1e fb          	endbr32 
801042a4:	55                   	push   %ebp
801042a5:	89 e5                	mov    %esp,%ebp
801042a7:	57                   	push   %edi
801042a8:	56                   	push   %esi
801042a9:	53                   	push   %ebx
801042aa:	83 ec 0c             	sub    $0xc,%esp
  struct cpu *c = mycpu();
801042ad:	e8 5e fc ff ff       	call   80103f10 <mycpu>
  c->proc = 0;
801042b2:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
801042b9:	00 00 00 
  struct cpu *c = mycpu();
801042bc:	89 c6                	mov    %eax,%esi
  c->proc = 0;
801042be:	8d 78 04             	lea    0x4(%eax),%edi
801042c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  asm volatile("sti");
801042c8:	fb                   	sti    
    acquire(&ptable.lock);
801042c9:	83 ec 0c             	sub    $0xc,%esp
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801042cc:	bb 94 49 11 80       	mov    $0x80114994,%ebx
    acquire(&ptable.lock);
801042d1:	68 60 49 11 80       	push   $0x80114960
801042d6:	e8 a5 09 00 00       	call   80104c80 <acquire>
801042db:	83 c4 10             	add    $0x10,%esp
801042de:	66 90                	xchg   %ax,%ax
      if (p->state != RUNNABLE)
801042e0:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
801042e4:	75 33                	jne    80104319 <scheduler+0x79>
      switchuvm(p);
801042e6:	83 ec 0c             	sub    $0xc,%esp
      c->proc = p;
801042e9:	89 9e ac 00 00 00    	mov    %ebx,0xac(%esi)
      switchuvm(p);
801042ef:	53                   	push   %ebx
801042f0:	e8 3b 2f 00 00       	call   80107230 <switchuvm>
      swtch(&(c->scheduler), p->context);
801042f5:	58                   	pop    %eax
801042f6:	5a                   	pop    %edx
801042f7:	ff 73 1c             	pushl  0x1c(%ebx)
801042fa:	57                   	push   %edi
      p->state = RUNNING;
801042fb:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
      swtch(&(c->scheduler), p->context);
80104302:	e8 ac 0c 00 00       	call   80104fb3 <swtch>
      switchkvm();
80104307:	e8 04 2f 00 00       	call   80107210 <switchkvm>
      c->proc = 0;
8010430c:	83 c4 10             	add    $0x10,%esp
8010430f:	c7 86 ac 00 00 00 00 	movl   $0x0,0xac(%esi)
80104316:	00 00 00 
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104319:	83 eb 80             	sub    $0xffffff80,%ebx
8010431c:	81 fb 94 69 11 80    	cmp    $0x80116994,%ebx
80104322:	75 bc                	jne    801042e0 <scheduler+0x40>
    release(&ptable.lock);
80104324:	83 ec 0c             	sub    $0xc,%esp
80104327:	68 60 49 11 80       	push   $0x80114960
8010432c:	e8 0f 0a 00 00       	call   80104d40 <release>
    sti();
80104331:	83 c4 10             	add    $0x10,%esp
80104334:	eb 92                	jmp    801042c8 <scheduler+0x28>
80104336:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010433d:	8d 76 00             	lea    0x0(%esi),%esi

80104340 <sched>:
{
80104340:	f3 0f 1e fb          	endbr32 
80104344:	55                   	push   %ebp
80104345:	89 e5                	mov    %esp,%ebp
80104347:	56                   	push   %esi
80104348:	53                   	push   %ebx
  pushcli();
80104349:	e8 32 08 00 00       	call   80104b80 <pushcli>
  c = mycpu();
8010434e:	e8 bd fb ff ff       	call   80103f10 <mycpu>
  p = c->proc;
80104353:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104359:	e8 72 08 00 00       	call   80104bd0 <popcli>
  if (!holding(&ptable.lock))
8010435e:	83 ec 0c             	sub    $0xc,%esp
80104361:	68 60 49 11 80       	push   $0x80114960
80104366:	e8 c5 08 00 00       	call   80104c30 <holding>
8010436b:	83 c4 10             	add    $0x10,%esp
8010436e:	85 c0                	test   %eax,%eax
80104370:	74 4f                	je     801043c1 <sched+0x81>
  if (mycpu()->ncli != 1)
80104372:	e8 99 fb ff ff       	call   80103f10 <mycpu>
80104377:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
8010437e:	75 68                	jne    801043e8 <sched+0xa8>
  if (p->state == RUNNING)
80104380:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
80104384:	74 55                	je     801043db <sched+0x9b>
  asm volatile("pushfl; popl %0" : "=r"(eflags));
80104386:	9c                   	pushf  
80104387:	58                   	pop    %eax
  if (readeflags() & FL_IF)
80104388:	f6 c4 02             	test   $0x2,%ah
8010438b:	75 41                	jne    801043ce <sched+0x8e>
  intena = mycpu()->intena;
8010438d:	e8 7e fb ff ff       	call   80103f10 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
80104392:	83 c3 1c             	add    $0x1c,%ebx
  intena = mycpu()->intena;
80104395:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
8010439b:	e8 70 fb ff ff       	call   80103f10 <mycpu>
801043a0:	83 ec 08             	sub    $0x8,%esp
801043a3:	ff 70 04             	pushl  0x4(%eax)
801043a6:	53                   	push   %ebx
801043a7:	e8 07 0c 00 00       	call   80104fb3 <swtch>
  mycpu()->intena = intena;
801043ac:	e8 5f fb ff ff       	call   80103f10 <mycpu>
}
801043b1:	83 c4 10             	add    $0x10,%esp
  mycpu()->intena = intena;
801043b4:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
801043ba:	8d 65 f8             	lea    -0x8(%ebp),%esp
801043bd:	5b                   	pop    %ebx
801043be:	5e                   	pop    %esi
801043bf:	5d                   	pop    %ebp
801043c0:	c3                   	ret    
    panic("sched ptable.lock");
801043c1:	83 ec 0c             	sub    $0xc,%esp
801043c4:	68 db 7e 10 80       	push   $0x80107edb
801043c9:	e8 e2 bf ff ff       	call   801003b0 <panic>
    panic("sched interruptible");
801043ce:	83 ec 0c             	sub    $0xc,%esp
801043d1:	68 07 7f 10 80       	push   $0x80107f07
801043d6:	e8 d5 bf ff ff       	call   801003b0 <panic>
    panic("sched running");
801043db:	83 ec 0c             	sub    $0xc,%esp
801043de:	68 f9 7e 10 80       	push   $0x80107ef9
801043e3:	e8 c8 bf ff ff       	call   801003b0 <panic>
    panic("sched locks");
801043e8:	83 ec 0c             	sub    $0xc,%esp
801043eb:	68 ed 7e 10 80       	push   $0x80107eed
801043f0:	e8 bb bf ff ff       	call   801003b0 <panic>
801043f5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801043fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104400 <exit>:
{
80104400:	f3 0f 1e fb          	endbr32 
80104404:	55                   	push   %ebp
80104405:	89 e5                	mov    %esp,%ebp
80104407:	57                   	push   %edi
80104408:	56                   	push   %esi
80104409:	53                   	push   %ebx
8010440a:	83 ec 0c             	sub    $0xc,%esp
  pushcli();
8010440d:	e8 6e 07 00 00       	call   80104b80 <pushcli>
  c = mycpu();
80104412:	e8 f9 fa ff ff       	call   80103f10 <mycpu>
  p = c->proc;
80104417:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
8010441d:	e8 ae 07 00 00       	call   80104bd0 <popcli>
  if (curproc == initproc)
80104422:	8d 5e 28             	lea    0x28(%esi),%ebx
80104425:	8d 7e 68             	lea    0x68(%esi),%edi
80104428:	39 35 38 c2 10 80    	cmp    %esi,0x8010c238
8010442e:	0f 84 f3 00 00 00    	je     80104527 <exit+0x127>
80104434:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if (curproc->ofile[fd])
80104438:	8b 03                	mov    (%ebx),%eax
8010443a:	85 c0                	test   %eax,%eax
8010443c:	74 12                	je     80104450 <exit+0x50>
      fileclose(curproc->ofile[fd]);
8010443e:	83 ec 0c             	sub    $0xc,%esp
80104441:	50                   	push   %eax
80104442:	e8 b9 d0 ff ff       	call   80101500 <fileclose>
      curproc->ofile[fd] = 0;
80104447:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
8010444d:	83 c4 10             	add    $0x10,%esp
  for (fd = 0; fd < NOFILE; fd++)
80104450:	83 c3 04             	add    $0x4,%ebx
80104453:	39 df                	cmp    %ebx,%edi
80104455:	75 e1                	jne    80104438 <exit+0x38>
  begin_op();
80104457:	e8 14 ef ff ff       	call   80103370 <begin_op>
  iput(curproc->cwd);
8010445c:	83 ec 0c             	sub    $0xc,%esp
8010445f:	ff 76 68             	pushl  0x68(%esi)
80104462:	e8 69 da ff ff       	call   80101ed0 <iput>
  end_op();
80104467:	e8 74 ef ff ff       	call   801033e0 <end_op>
  curproc->cwd = 0;
8010446c:	c7 46 68 00 00 00 00 	movl   $0x0,0x68(%esi)
  acquire(&ptable.lock);
80104473:	c7 04 24 60 49 11 80 	movl   $0x80114960,(%esp)
8010447a:	e8 01 08 00 00       	call   80104c80 <acquire>
  wakeup1(curproc->parent);
8010447f:	8b 56 14             	mov    0x14(%esi),%edx
80104482:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104485:	b8 94 49 11 80       	mov    $0x80114994,%eax
8010448a:	eb 0e                	jmp    8010449a <exit+0x9a>
8010448c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104490:	83 e8 80             	sub    $0xffffff80,%eax
80104493:	3d 94 69 11 80       	cmp    $0x80116994,%eax
80104498:	74 1c                	je     801044b6 <exit+0xb6>
    if (p->state == SLEEPING && p->chan == chan)
8010449a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
8010449e:	75 f0                	jne    80104490 <exit+0x90>
801044a0:	3b 50 20             	cmp    0x20(%eax),%edx
801044a3:	75 eb                	jne    80104490 <exit+0x90>
      p->state = RUNNABLE;
801044a5:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801044ac:	83 e8 80             	sub    $0xffffff80,%eax
801044af:	3d 94 69 11 80       	cmp    $0x80116994,%eax
801044b4:	75 e4                	jne    8010449a <exit+0x9a>
      p->parent = initproc;
801044b6:	8b 0d 38 c2 10 80    	mov    0x8010c238,%ecx
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801044bc:	ba 94 49 11 80       	mov    $0x80114994,%edx
801044c1:	eb 10                	jmp    801044d3 <exit+0xd3>
801044c3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801044c7:	90                   	nop
801044c8:	83 ea 80             	sub    $0xffffff80,%edx
801044cb:	81 fa 94 69 11 80    	cmp    $0x80116994,%edx
801044d1:	74 3b                	je     8010450e <exit+0x10e>
    if (p->parent == curproc)
801044d3:	39 72 14             	cmp    %esi,0x14(%edx)
801044d6:	75 f0                	jne    801044c8 <exit+0xc8>
      if (p->state == ZOMBIE)
801044d8:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
      p->parent = initproc;
801044dc:	89 4a 14             	mov    %ecx,0x14(%edx)
      if (p->state == ZOMBIE)
801044df:	75 e7                	jne    801044c8 <exit+0xc8>
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801044e1:	b8 94 49 11 80       	mov    $0x80114994,%eax
801044e6:	eb 12                	jmp    801044fa <exit+0xfa>
801044e8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801044ef:	90                   	nop
801044f0:	83 e8 80             	sub    $0xffffff80,%eax
801044f3:	3d 94 69 11 80       	cmp    $0x80116994,%eax
801044f8:	74 ce                	je     801044c8 <exit+0xc8>
    if (p->state == SLEEPING && p->chan == chan)
801044fa:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
801044fe:	75 f0                	jne    801044f0 <exit+0xf0>
80104500:	3b 48 20             	cmp    0x20(%eax),%ecx
80104503:	75 eb                	jne    801044f0 <exit+0xf0>
      p->state = RUNNABLE;
80104505:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
8010450c:	eb e2                	jmp    801044f0 <exit+0xf0>
  curproc->state = ZOMBIE;
8010450e:	c7 46 0c 05 00 00 00 	movl   $0x5,0xc(%esi)
  sched();
80104515:	e8 26 fe ff ff       	call   80104340 <sched>
  panic("zombie exit");
8010451a:	83 ec 0c             	sub    $0xc,%esp
8010451d:	68 28 7f 10 80       	push   $0x80107f28
80104522:	e8 89 be ff ff       	call   801003b0 <panic>
    panic("init exiting");
80104527:	83 ec 0c             	sub    $0xc,%esp
8010452a:	68 1b 7f 10 80       	push   $0x80107f1b
8010452f:	e8 7c be ff ff       	call   801003b0 <panic>
80104534:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010453b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010453f:	90                   	nop

80104540 <yield>:
{
80104540:	f3 0f 1e fb          	endbr32 
80104544:	55                   	push   %ebp
80104545:	89 e5                	mov    %esp,%ebp
80104547:	53                   	push   %ebx
80104548:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock); // DOC: yieldlock
8010454b:	68 60 49 11 80       	push   $0x80114960
80104550:	e8 2b 07 00 00       	call   80104c80 <acquire>
  pushcli();
80104555:	e8 26 06 00 00       	call   80104b80 <pushcli>
  c = mycpu();
8010455a:	e8 b1 f9 ff ff       	call   80103f10 <mycpu>
  p = c->proc;
8010455f:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104565:	e8 66 06 00 00       	call   80104bd0 <popcli>
  myproc()->state = RUNNABLE;
8010456a:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  sched();
80104571:	e8 ca fd ff ff       	call   80104340 <sched>
  release(&ptable.lock);
80104576:	c7 04 24 60 49 11 80 	movl   $0x80114960,(%esp)
8010457d:	e8 be 07 00 00       	call   80104d40 <release>
}
80104582:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104585:	83 c4 10             	add    $0x10,%esp
80104588:	c9                   	leave  
80104589:	c3                   	ret    
8010458a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104590 <sleep>:
{
80104590:	f3 0f 1e fb          	endbr32 
80104594:	55                   	push   %ebp
80104595:	89 e5                	mov    %esp,%ebp
80104597:	57                   	push   %edi
80104598:	56                   	push   %esi
80104599:	53                   	push   %ebx
8010459a:	83 ec 0c             	sub    $0xc,%esp
8010459d:	8b 7d 08             	mov    0x8(%ebp),%edi
801045a0:	8b 75 0c             	mov    0xc(%ebp),%esi
  pushcli();
801045a3:	e8 d8 05 00 00       	call   80104b80 <pushcli>
  c = mycpu();
801045a8:	e8 63 f9 ff ff       	call   80103f10 <mycpu>
  p = c->proc;
801045ad:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801045b3:	e8 18 06 00 00       	call   80104bd0 <popcli>
  if (p == 0)
801045b8:	85 db                	test   %ebx,%ebx
801045ba:	0f 84 83 00 00 00    	je     80104643 <sleep+0xb3>
  if (lk == 0)
801045c0:	85 f6                	test   %esi,%esi
801045c2:	74 72                	je     80104636 <sleep+0xa6>
  if (lk != &ptable.lock)
801045c4:	81 fe 60 49 11 80    	cmp    $0x80114960,%esi
801045ca:	74 4c                	je     80104618 <sleep+0x88>
    acquire(&ptable.lock); // DOC: sleeplock1
801045cc:	83 ec 0c             	sub    $0xc,%esp
801045cf:	68 60 49 11 80       	push   $0x80114960
801045d4:	e8 a7 06 00 00       	call   80104c80 <acquire>
    release(lk);
801045d9:	89 34 24             	mov    %esi,(%esp)
801045dc:	e8 5f 07 00 00       	call   80104d40 <release>
  p->chan = chan;
801045e1:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
801045e4:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
801045eb:	e8 50 fd ff ff       	call   80104340 <sched>
  p->chan = 0;
801045f0:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
    release(&ptable.lock);
801045f7:	c7 04 24 60 49 11 80 	movl   $0x80114960,(%esp)
801045fe:	e8 3d 07 00 00       	call   80104d40 <release>
    acquire(lk);
80104603:	89 75 08             	mov    %esi,0x8(%ebp)
80104606:	83 c4 10             	add    $0x10,%esp
}
80104609:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010460c:	5b                   	pop    %ebx
8010460d:	5e                   	pop    %esi
8010460e:	5f                   	pop    %edi
8010460f:	5d                   	pop    %ebp
    acquire(lk);
80104610:	e9 6b 06 00 00       	jmp    80104c80 <acquire>
80104615:	8d 76 00             	lea    0x0(%esi),%esi
  p->chan = chan;
80104618:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
8010461b:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80104622:	e8 19 fd ff ff       	call   80104340 <sched>
  p->chan = 0;
80104627:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
8010462e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104631:	5b                   	pop    %ebx
80104632:	5e                   	pop    %esi
80104633:	5f                   	pop    %edi
80104634:	5d                   	pop    %ebp
80104635:	c3                   	ret    
    panic("sleep without lk");
80104636:	83 ec 0c             	sub    $0xc,%esp
80104639:	68 3a 7f 10 80       	push   $0x80107f3a
8010463e:	e8 6d bd ff ff       	call   801003b0 <panic>
    panic("sleep");
80104643:	83 ec 0c             	sub    $0xc,%esp
80104646:	68 34 7f 10 80       	push   $0x80107f34
8010464b:	e8 60 bd ff ff       	call   801003b0 <panic>

80104650 <wait>:
{
80104650:	f3 0f 1e fb          	endbr32 
80104654:	55                   	push   %ebp
80104655:	89 e5                	mov    %esp,%ebp
80104657:	56                   	push   %esi
80104658:	53                   	push   %ebx
  pushcli();
80104659:	e8 22 05 00 00       	call   80104b80 <pushcli>
  c = mycpu();
8010465e:	e8 ad f8 ff ff       	call   80103f10 <mycpu>
  p = c->proc;
80104663:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80104669:	e8 62 05 00 00       	call   80104bd0 <popcli>
  acquire(&ptable.lock);
8010466e:	83 ec 0c             	sub    $0xc,%esp
80104671:	68 60 49 11 80       	push   $0x80114960
80104676:	e8 05 06 00 00       	call   80104c80 <acquire>
8010467b:	83 c4 10             	add    $0x10,%esp
    havekids = 0;
8010467e:	31 c0                	xor    %eax,%eax
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104680:	bb 94 49 11 80       	mov    $0x80114994,%ebx
80104685:	eb 14                	jmp    8010469b <wait+0x4b>
80104687:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010468e:	66 90                	xchg   %ax,%ax
80104690:	83 eb 80             	sub    $0xffffff80,%ebx
80104693:	81 fb 94 69 11 80    	cmp    $0x80116994,%ebx
80104699:	74 1b                	je     801046b6 <wait+0x66>
      if (p->parent != curproc)
8010469b:	39 73 14             	cmp    %esi,0x14(%ebx)
8010469e:	75 f0                	jne    80104690 <wait+0x40>
      if (p->state == ZOMBIE)
801046a0:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
801046a4:	74 32                	je     801046d8 <wait+0x88>
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801046a6:	83 eb 80             	sub    $0xffffff80,%ebx
      havekids = 1;
801046a9:	b8 01 00 00 00       	mov    $0x1,%eax
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801046ae:	81 fb 94 69 11 80    	cmp    $0x80116994,%ebx
801046b4:	75 e5                	jne    8010469b <wait+0x4b>
    if (!havekids || curproc->killed)
801046b6:	85 c0                	test   %eax,%eax
801046b8:	74 74                	je     8010472e <wait+0xde>
801046ba:	8b 46 24             	mov    0x24(%esi),%eax
801046bd:	85 c0                	test   %eax,%eax
801046bf:	75 6d                	jne    8010472e <wait+0xde>
    sleep(curproc, &ptable.lock); // DOC: wait-sleep
801046c1:	83 ec 08             	sub    $0x8,%esp
801046c4:	68 60 49 11 80       	push   $0x80114960
801046c9:	56                   	push   %esi
801046ca:	e8 c1 fe ff ff       	call   80104590 <sleep>
    havekids = 0;
801046cf:	83 c4 10             	add    $0x10,%esp
801046d2:	eb aa                	jmp    8010467e <wait+0x2e>
801046d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        kfree(p->kstack);
801046d8:	83 ec 0c             	sub    $0xc,%esp
801046db:	ff 73 08             	pushl  0x8(%ebx)
        pid = p->pid;
801046de:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
801046e1:	e8 ca e3 ff ff       	call   80102ab0 <kfree>
        freevm(p->pgdir);
801046e6:	5a                   	pop    %edx
801046e7:	ff 73 04             	pushl  0x4(%ebx)
        p->kstack = 0;
801046ea:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
801046f1:	e8 fa 2e 00 00       	call   801075f0 <freevm>
        release(&ptable.lock);
801046f6:	c7 04 24 60 49 11 80 	movl   $0x80114960,(%esp)
        p->pid = 0;
801046fd:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
80104704:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
8010470b:	c6 43 70 00          	movb   $0x0,0x70(%ebx)
        p->killed = 0;
8010470f:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
80104716:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
8010471d:	e8 1e 06 00 00       	call   80104d40 <release>
        return pid;
80104722:	83 c4 10             	add    $0x10,%esp
}
80104725:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104728:	89 f0                	mov    %esi,%eax
8010472a:	5b                   	pop    %ebx
8010472b:	5e                   	pop    %esi
8010472c:	5d                   	pop    %ebp
8010472d:	c3                   	ret    
      release(&ptable.lock);
8010472e:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80104731:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
80104736:	68 60 49 11 80       	push   $0x80114960
8010473b:	e8 00 06 00 00       	call   80104d40 <release>
      return -1;
80104740:	83 c4 10             	add    $0x10,%esp
80104743:	eb e0                	jmp    80104725 <wait+0xd5>
80104745:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010474c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104750 <wakeup>:
}

// Wake up all processes sleeping on chan.
void wakeup(void *chan)
{
80104750:	f3 0f 1e fb          	endbr32 
80104754:	55                   	push   %ebp
80104755:	89 e5                	mov    %esp,%ebp
80104757:	53                   	push   %ebx
80104758:	83 ec 10             	sub    $0x10,%esp
8010475b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
8010475e:	68 60 49 11 80       	push   $0x80114960
80104763:	e8 18 05 00 00       	call   80104c80 <acquire>
80104768:	83 c4 10             	add    $0x10,%esp
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010476b:	b8 94 49 11 80       	mov    $0x80114994,%eax
80104770:	eb 10                	jmp    80104782 <wakeup+0x32>
80104772:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104778:	83 e8 80             	sub    $0xffffff80,%eax
8010477b:	3d 94 69 11 80       	cmp    $0x80116994,%eax
80104780:	74 1c                	je     8010479e <wakeup+0x4e>
    if (p->state == SLEEPING && p->chan == chan)
80104782:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104786:	75 f0                	jne    80104778 <wakeup+0x28>
80104788:	3b 58 20             	cmp    0x20(%eax),%ebx
8010478b:	75 eb                	jne    80104778 <wakeup+0x28>
      p->state = RUNNABLE;
8010478d:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104794:	83 e8 80             	sub    $0xffffff80,%eax
80104797:	3d 94 69 11 80       	cmp    $0x80116994,%eax
8010479c:	75 e4                	jne    80104782 <wakeup+0x32>
  wakeup1(chan);
  release(&ptable.lock);
8010479e:	c7 45 08 60 49 11 80 	movl   $0x80114960,0x8(%ebp)
}
801047a5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801047a8:	c9                   	leave  
  release(&ptable.lock);
801047a9:	e9 92 05 00 00       	jmp    80104d40 <release>
801047ae:	66 90                	xchg   %ax,%ax

801047b0 <kill>:

// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int kill(int pid)
{
801047b0:	f3 0f 1e fb          	endbr32 
801047b4:	55                   	push   %ebp
801047b5:	89 e5                	mov    %esp,%ebp
801047b7:	53                   	push   %ebx
801047b8:	83 ec 10             	sub    $0x10,%esp
801047bb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
801047be:	68 60 49 11 80       	push   $0x80114960
801047c3:	e8 b8 04 00 00       	call   80104c80 <acquire>
801047c8:	83 c4 10             	add    $0x10,%esp
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801047cb:	b8 94 49 11 80       	mov    $0x80114994,%eax
801047d0:	eb 10                	jmp    801047e2 <kill+0x32>
801047d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801047d8:	83 e8 80             	sub    $0xffffff80,%eax
801047db:	3d 94 69 11 80       	cmp    $0x80116994,%eax
801047e0:	74 36                	je     80104818 <kill+0x68>
  {
    if (p->pid == pid)
801047e2:	39 58 10             	cmp    %ebx,0x10(%eax)
801047e5:	75 f1                	jne    801047d8 <kill+0x28>
    {
      p->killed = 1;
      // Wake process from sleep if necessary.
      if (p->state == SLEEPING)
801047e7:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
      p->killed = 1;
801047eb:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      if (p->state == SLEEPING)
801047f2:	75 07                	jne    801047fb <kill+0x4b>
        p->state = RUNNABLE;
801047f4:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      release(&ptable.lock);
801047fb:	83 ec 0c             	sub    $0xc,%esp
801047fe:	68 60 49 11 80       	push   $0x80114960
80104803:	e8 38 05 00 00       	call   80104d40 <release>
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
}
80104808:	8b 5d fc             	mov    -0x4(%ebp),%ebx
      return 0;
8010480b:	83 c4 10             	add    $0x10,%esp
8010480e:	31 c0                	xor    %eax,%eax
}
80104810:	c9                   	leave  
80104811:	c3                   	ret    
80104812:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  release(&ptable.lock);
80104818:	83 ec 0c             	sub    $0xc,%esp
8010481b:	68 60 49 11 80       	push   $0x80114960
80104820:	e8 1b 05 00 00       	call   80104d40 <release>
}
80104825:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return -1;
80104828:	83 c4 10             	add    $0x10,%esp
8010482b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104830:	c9                   	leave  
80104831:	c3                   	ret    
80104832:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104839:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104840 <procdump>:
// PAGEBREAK: 36
//  Print a process listing to console.  For debugging.
//  Runs when user types ^P on console.
//  No lock to avoid wedging a stuck machine further.
void procdump(void)
{
80104840:	f3 0f 1e fb          	endbr32 
80104844:	55                   	push   %ebp
80104845:	89 e5                	mov    %esp,%ebp
80104847:	57                   	push   %edi
80104848:	56                   	push   %esi
80104849:	8d 75 e8             	lea    -0x18(%ebp),%esi
8010484c:	53                   	push   %ebx
8010484d:	bb 04 4a 11 80       	mov    $0x80114a04,%ebx
80104852:	83 ec 3c             	sub    $0x3c,%esp
80104855:	eb 28                	jmp    8010487f <procdump+0x3f>
80104857:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010485e:	66 90                	xchg   %ax,%ax
    {
      getcallerpcs((uint *)p->context->ebp + 2, pc);
      for (i = 0; i < 10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80104860:	83 ec 0c             	sub    $0xc,%esp
80104863:	68 4f 83 10 80       	push   $0x8010834f
80104868:	e8 33 bf ff ff       	call   801007a0 <cprintf>
8010486d:	83 c4 10             	add    $0x10,%esp
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104870:	83 eb 80             	sub    $0xffffff80,%ebx
80104873:	81 fb 04 6a 11 80    	cmp    $0x80116a04,%ebx
80104879:	0f 84 81 00 00 00    	je     80104900 <procdump+0xc0>
    if (p->state == UNUSED)
8010487f:	8b 43 9c             	mov    -0x64(%ebx),%eax
80104882:	85 c0                	test   %eax,%eax
80104884:	74 ea                	je     80104870 <procdump+0x30>
      state = "???";
80104886:	ba 4b 7f 10 80       	mov    $0x80107f4b,%edx
    if (p->state >= 0 && p->state < NELEM(states) && states[p->state])
8010488b:	83 f8 05             	cmp    $0x5,%eax
8010488e:	77 11                	ja     801048a1 <procdump+0x61>
80104890:	8b 14 85 d4 7f 10 80 	mov    -0x7fef802c(,%eax,4),%edx
      state = "???";
80104897:	b8 4b 7f 10 80       	mov    $0x80107f4b,%eax
8010489c:	85 d2                	test   %edx,%edx
8010489e:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
801048a1:	53                   	push   %ebx
801048a2:	52                   	push   %edx
801048a3:	ff 73 a0             	pushl  -0x60(%ebx)
801048a6:	68 4f 7f 10 80       	push   $0x80107f4f
801048ab:	e8 f0 be ff ff       	call   801007a0 <cprintf>
    if (p->state == SLEEPING)
801048b0:	83 c4 10             	add    $0x10,%esp
801048b3:	83 7b 9c 02          	cmpl   $0x2,-0x64(%ebx)
801048b7:	75 a7                	jne    80104860 <procdump+0x20>
      getcallerpcs((uint *)p->context->ebp + 2, pc);
801048b9:	83 ec 08             	sub    $0x8,%esp
801048bc:	8d 45 c0             	lea    -0x40(%ebp),%eax
801048bf:	8d 7d c0             	lea    -0x40(%ebp),%edi
801048c2:	50                   	push   %eax
801048c3:	8b 43 ac             	mov    -0x54(%ebx),%eax
801048c6:	8b 40 0c             	mov    0xc(%eax),%eax
801048c9:	83 c0 08             	add    $0x8,%eax
801048cc:	50                   	push   %eax
801048cd:	e8 4e 02 00 00       	call   80104b20 <getcallerpcs>
      for (i = 0; i < 10 && pc[i] != 0; i++)
801048d2:	83 c4 10             	add    $0x10,%esp
801048d5:	8d 76 00             	lea    0x0(%esi),%esi
801048d8:	8b 17                	mov    (%edi),%edx
801048da:	85 d2                	test   %edx,%edx
801048dc:	74 82                	je     80104860 <procdump+0x20>
        cprintf(" %p", pc[i]);
801048de:	83 ec 08             	sub    $0x8,%esp
801048e1:	83 c7 04             	add    $0x4,%edi
801048e4:	52                   	push   %edx
801048e5:	68 41 79 10 80       	push   $0x80107941
801048ea:	e8 b1 be ff ff       	call   801007a0 <cprintf>
      for (i = 0; i < 10 && pc[i] != 0; i++)
801048ef:	83 c4 10             	add    $0x10,%esp
801048f2:	39 fe                	cmp    %edi,%esi
801048f4:	75 e2                	jne    801048d8 <procdump+0x98>
801048f6:	e9 65 ff ff ff       	jmp    80104860 <procdump+0x20>
801048fb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801048ff:	90                   	nop
  }
}
80104900:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104903:	5b                   	pop    %ebx
80104904:	5e                   	pop    %esi
80104905:	5f                   	pop    %edi
80104906:	5d                   	pop    %ebp
80104907:	c3                   	ret    
80104908:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010490f:	90                   	nop

80104910 <sys_get_uncle_count>:
// this function iteretes trhough all
// proc and if their parent is same as
// current process grand parent then it
// is uncle of proc
int sys_get_uncle_count(void)
{
80104910:	f3 0f 1e fb          	endbr32 
80104914:	55                   	push   %ebp
80104915:	89 e5                	mov    %esp,%ebp
80104917:	57                   	push   %edi
80104918:	56                   	push   %esi
  acquire(&ptable.lock);
  int count = 0;
80104919:	31 f6                	xor    %esi,%esi
{
8010491b:	53                   	push   %ebx
  struct proc *my_proc = myproc(); // Get the current process
  struct proc *curr_proc;

  for (curr_proc = ptable.proc; curr_proc < &ptable.proc[NPROC]; curr_proc++)
8010491c:	bb 94 49 11 80       	mov    $0x80114994,%ebx
{
80104921:	83 ec 18             	sub    $0x18,%esp
  acquire(&ptable.lock);
80104924:	68 60 49 11 80       	push   $0x80114960
80104929:	e8 52 03 00 00       	call   80104c80 <acquire>
  pushcli();
8010492e:	e8 4d 02 00 00       	call   80104b80 <pushcli>
  c = mycpu();
80104933:	e8 d8 f5 ff ff       	call   80103f10 <mycpu>
  p = c->proc;
80104938:	8b b8 ac 00 00 00    	mov    0xac(%eax),%edi
  popcli();
8010493e:	e8 8d 02 00 00       	call   80104bd0 <popcli>
80104943:	83 c4 10             	add    $0x10,%esp
80104946:	eb 13                	jmp    8010495b <sys_get_uncle_count+0x4b>
80104948:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010494f:	90                   	nop
  for (curr_proc = ptable.proc; curr_proc < &ptable.proc[NPROC]; curr_proc++)
80104950:	83 eb 80             	sub    $0xffffff80,%ebx
80104953:	81 fb 94 69 11 80    	cmp    $0x80116994,%ebx
80104959:	74 4b                	je     801049a6 <sys_get_uncle_count+0x96>
  {
    if (curr_proc->state == UNUSED || curr_proc->state == EMBRYO || curr_proc->pid == my_proc->pid || curr_proc->pid == my_proc->parent->pid) // escaping incomplete proc
8010495b:	83 7b 0c 01          	cmpl   $0x1,0xc(%ebx)
8010495f:	76 ef                	jbe    80104950 <sys_get_uncle_count+0x40>
80104961:	8b 43 10             	mov    0x10(%ebx),%eax
80104964:	3b 47 10             	cmp    0x10(%edi),%eax
80104967:	74 e7                	je     80104950 <sys_get_uncle_count+0x40>
80104969:	8b 57 14             	mov    0x14(%edi),%edx
8010496c:	3b 42 10             	cmp    0x10(%edx),%eax
8010496f:	74 df                	je     80104950 <sys_get_uncle_count+0x40>
      continue;

    if (curr_proc->parent &&  curr_proc->parent->pid == my_proc->parent->parent->pid)
80104971:	8b 4b 14             	mov    0x14(%ebx),%ecx
80104974:	85 c9                	test   %ecx,%ecx
80104976:	74 d8                	je     80104950 <sys_get_uncle_count+0x40>
80104978:	8b 52 14             	mov    0x14(%edx),%edx
8010497b:	8b 52 10             	mov    0x10(%edx),%edx
8010497e:	39 51 10             	cmp    %edx,0x10(%ecx)
80104981:	75 cd                	jne    80104950 <sys_get_uncle_count+0x40>
    {
      cprintf("Found uncle with pid:%d and name: %s\n",curr_proc->pid,curr_proc->name);
80104983:	83 ec 04             	sub    $0x4,%esp
80104986:	8d 53 70             	lea    0x70(%ebx),%edx
  for (curr_proc = ptable.proc; curr_proc < &ptable.proc[NPROC]; curr_proc++)
80104989:	83 eb 80             	sub    $0xffffff80,%ebx
      count++;
8010498c:	83 c6 01             	add    $0x1,%esi
      cprintf("Found uncle with pid:%d and name: %s\n",curr_proc->pid,curr_proc->name);
8010498f:	52                   	push   %edx
80104990:	50                   	push   %eax
80104991:	68 ac 7f 10 80       	push   $0x80107fac
80104996:	e8 05 be ff ff       	call   801007a0 <cprintf>
      count++;
8010499b:	83 c4 10             	add    $0x10,%esp
  for (curr_proc = ptable.proc; curr_proc < &ptable.proc[NPROC]; curr_proc++)
8010499e:	81 fb 94 69 11 80    	cmp    $0x80116994,%ebx
801049a4:	75 b5                	jne    8010495b <sys_get_uncle_count+0x4b>
    }
  }
  release(&ptable.lock);
801049a6:	83 ec 0c             	sub    $0xc,%esp
801049a9:	68 60 49 11 80       	push   $0x80114960
801049ae:	e8 8d 03 00 00       	call   80104d40 <release>

  return count;
}
801049b3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801049b6:	89 f0                	mov    %esi,%eax
801049b8:	5b                   	pop    %ebx
801049b9:	5e                   	pop    %esi
801049ba:	5f                   	pop    %edi
801049bb:	5d                   	pop    %ebp
801049bc:	c3                   	ret    
801049bd:	66 90                	xchg   %ax,%ax
801049bf:	90                   	nop

801049c0 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
801049c0:	f3 0f 1e fb          	endbr32 
801049c4:	55                   	push   %ebp
801049c5:	89 e5                	mov    %esp,%ebp
801049c7:	53                   	push   %ebx
801049c8:	83 ec 0c             	sub    $0xc,%esp
801049cb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
801049ce:	68 ec 7f 10 80       	push   $0x80107fec
801049d3:	8d 43 04             	lea    0x4(%ebx),%eax
801049d6:	50                   	push   %eax
801049d7:	e8 24 01 00 00       	call   80104b00 <initlock>
  lk->name = name;
801049dc:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
801049df:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
801049e5:	83 c4 10             	add    $0x10,%esp
  lk->pid = 0;
801049e8:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
801049ef:	89 43 38             	mov    %eax,0x38(%ebx)
}
801049f2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801049f5:	c9                   	leave  
801049f6:	c3                   	ret    
801049f7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801049fe:	66 90                	xchg   %ax,%ax

80104a00 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80104a00:	f3 0f 1e fb          	endbr32 
80104a04:	55                   	push   %ebp
80104a05:	89 e5                	mov    %esp,%ebp
80104a07:	56                   	push   %esi
80104a08:	53                   	push   %ebx
80104a09:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104a0c:	8d 73 04             	lea    0x4(%ebx),%esi
80104a0f:	83 ec 0c             	sub    $0xc,%esp
80104a12:	56                   	push   %esi
80104a13:	e8 68 02 00 00       	call   80104c80 <acquire>
  while (lk->locked) {
80104a18:	8b 13                	mov    (%ebx),%edx
80104a1a:	83 c4 10             	add    $0x10,%esp
80104a1d:	85 d2                	test   %edx,%edx
80104a1f:	74 1a                	je     80104a3b <acquiresleep+0x3b>
80104a21:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    sleep(lk, &lk->lk);
80104a28:	83 ec 08             	sub    $0x8,%esp
80104a2b:	56                   	push   %esi
80104a2c:	53                   	push   %ebx
80104a2d:	e8 5e fb ff ff       	call   80104590 <sleep>
  while (lk->locked) {
80104a32:	8b 03                	mov    (%ebx),%eax
80104a34:	83 c4 10             	add    $0x10,%esp
80104a37:	85 c0                	test   %eax,%eax
80104a39:	75 ed                	jne    80104a28 <acquiresleep+0x28>
  }
  lk->locked = 1;
80104a3b:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
80104a41:	e8 5a f5 ff ff       	call   80103fa0 <myproc>
80104a46:	8b 40 10             	mov    0x10(%eax),%eax
80104a49:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
80104a4c:	89 75 08             	mov    %esi,0x8(%ebp)
}
80104a4f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104a52:	5b                   	pop    %ebx
80104a53:	5e                   	pop    %esi
80104a54:	5d                   	pop    %ebp
  release(&lk->lk);
80104a55:	e9 e6 02 00 00       	jmp    80104d40 <release>
80104a5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104a60 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
80104a60:	f3 0f 1e fb          	endbr32 
80104a64:	55                   	push   %ebp
80104a65:	89 e5                	mov    %esp,%ebp
80104a67:	56                   	push   %esi
80104a68:	53                   	push   %ebx
80104a69:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104a6c:	8d 73 04             	lea    0x4(%ebx),%esi
80104a6f:	83 ec 0c             	sub    $0xc,%esp
80104a72:	56                   	push   %esi
80104a73:	e8 08 02 00 00       	call   80104c80 <acquire>
  lk->locked = 0;
80104a78:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
80104a7e:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
80104a85:	89 1c 24             	mov    %ebx,(%esp)
80104a88:	e8 c3 fc ff ff       	call   80104750 <wakeup>
  release(&lk->lk);
80104a8d:	89 75 08             	mov    %esi,0x8(%ebp)
80104a90:	83 c4 10             	add    $0x10,%esp
}
80104a93:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104a96:	5b                   	pop    %ebx
80104a97:	5e                   	pop    %esi
80104a98:	5d                   	pop    %ebp
  release(&lk->lk);
80104a99:	e9 a2 02 00 00       	jmp    80104d40 <release>
80104a9e:	66 90                	xchg   %ax,%ax

80104aa0 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
80104aa0:	f3 0f 1e fb          	endbr32 
80104aa4:	55                   	push   %ebp
80104aa5:	89 e5                	mov    %esp,%ebp
80104aa7:	57                   	push   %edi
80104aa8:	31 ff                	xor    %edi,%edi
80104aaa:	56                   	push   %esi
80104aab:	53                   	push   %ebx
80104aac:	83 ec 18             	sub    $0x18,%esp
80104aaf:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;
  
  acquire(&lk->lk);
80104ab2:	8d 73 04             	lea    0x4(%ebx),%esi
80104ab5:	56                   	push   %esi
80104ab6:	e8 c5 01 00 00       	call   80104c80 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
80104abb:	8b 03                	mov    (%ebx),%eax
80104abd:	83 c4 10             	add    $0x10,%esp
80104ac0:	85 c0                	test   %eax,%eax
80104ac2:	75 1c                	jne    80104ae0 <holdingsleep+0x40>
  release(&lk->lk);
80104ac4:	83 ec 0c             	sub    $0xc,%esp
80104ac7:	56                   	push   %esi
80104ac8:	e8 73 02 00 00       	call   80104d40 <release>
  return r;
}
80104acd:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104ad0:	89 f8                	mov    %edi,%eax
80104ad2:	5b                   	pop    %ebx
80104ad3:	5e                   	pop    %esi
80104ad4:	5f                   	pop    %edi
80104ad5:	5d                   	pop    %ebp
80104ad6:	c3                   	ret    
80104ad7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104ade:	66 90                	xchg   %ax,%ax
  r = lk->locked && (lk->pid == myproc()->pid);
80104ae0:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
80104ae3:	e8 b8 f4 ff ff       	call   80103fa0 <myproc>
80104ae8:	39 58 10             	cmp    %ebx,0x10(%eax)
80104aeb:	0f 94 c0             	sete   %al
80104aee:	0f b6 c0             	movzbl %al,%eax
80104af1:	89 c7                	mov    %eax,%edi
80104af3:	eb cf                	jmp    80104ac4 <holdingsleep+0x24>
80104af5:	66 90                	xchg   %ax,%ax
80104af7:	66 90                	xchg   %ax,%ax
80104af9:	66 90                	xchg   %ax,%ax
80104afb:	66 90                	xchg   %ax,%ax
80104afd:	66 90                	xchg   %ax,%ax
80104aff:	90                   	nop

80104b00 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80104b00:	f3 0f 1e fb          	endbr32 
80104b04:	55                   	push   %ebp
80104b05:	89 e5                	mov    %esp,%ebp
80104b07:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80104b0a:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
80104b0d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
80104b13:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
80104b16:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80104b1d:	5d                   	pop    %ebp
80104b1e:	c3                   	ret    
80104b1f:	90                   	nop

80104b20 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80104b20:	f3 0f 1e fb          	endbr32 
80104b24:	55                   	push   %ebp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104b25:	31 d2                	xor    %edx,%edx
{
80104b27:	89 e5                	mov    %esp,%ebp
80104b29:	53                   	push   %ebx
  ebp = (uint*)v - 2;
80104b2a:	8b 45 08             	mov    0x8(%ebp),%eax
{
80104b2d:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  ebp = (uint*)v - 2;
80104b30:	83 e8 08             	sub    $0x8,%eax
  for(i = 0; i < 10; i++){
80104b33:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104b37:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104b38:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
80104b3e:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
80104b44:	77 1a                	ja     80104b60 <getcallerpcs+0x40>
      break;
    pcs[i] = ebp[1];     // saved %eip
80104b46:	8b 58 04             	mov    0x4(%eax),%ebx
80104b49:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
80104b4c:	83 c2 01             	add    $0x1,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
80104b4f:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80104b51:	83 fa 0a             	cmp    $0xa,%edx
80104b54:	75 e2                	jne    80104b38 <getcallerpcs+0x18>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
80104b56:	5b                   	pop    %ebx
80104b57:	5d                   	pop    %ebp
80104b58:	c3                   	ret    
80104b59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(; i < 10; i++)
80104b60:	8d 04 91             	lea    (%ecx,%edx,4),%eax
80104b63:	8d 51 28             	lea    0x28(%ecx),%edx
80104b66:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104b6d:	8d 76 00             	lea    0x0(%esi),%esi
    pcs[i] = 0;
80104b70:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
80104b76:	83 c0 04             	add    $0x4,%eax
80104b79:	39 d0                	cmp    %edx,%eax
80104b7b:	75 f3                	jne    80104b70 <getcallerpcs+0x50>
}
80104b7d:	5b                   	pop    %ebx
80104b7e:	5d                   	pop    %ebp
80104b7f:	c3                   	ret    

80104b80 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80104b80:	f3 0f 1e fb          	endbr32 
80104b84:	55                   	push   %ebp
80104b85:	89 e5                	mov    %esp,%ebp
80104b87:	53                   	push   %ebx
80104b88:	83 ec 04             	sub    $0x4,%esp
80104b8b:	9c                   	pushf  
80104b8c:	5b                   	pop    %ebx
  asm volatile("cli");
80104b8d:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
80104b8e:	e8 7d f3 ff ff       	call   80103f10 <mycpu>
80104b93:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
80104b99:	85 c0                	test   %eax,%eax
80104b9b:	74 13                	je     80104bb0 <pushcli+0x30>
    mycpu()->intena = eflags & FL_IF;
  mycpu()->ncli += 1;
80104b9d:	e8 6e f3 ff ff       	call   80103f10 <mycpu>
80104ba2:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
80104ba9:	83 c4 04             	add    $0x4,%esp
80104bac:	5b                   	pop    %ebx
80104bad:	5d                   	pop    %ebp
80104bae:	c3                   	ret    
80104baf:	90                   	nop
    mycpu()->intena = eflags & FL_IF;
80104bb0:	e8 5b f3 ff ff       	call   80103f10 <mycpu>
80104bb5:	81 e3 00 02 00 00    	and    $0x200,%ebx
80104bbb:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
80104bc1:	eb da                	jmp    80104b9d <pushcli+0x1d>
80104bc3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104bca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104bd0 <popcli>:

void
popcli(void)
{
80104bd0:	f3 0f 1e fb          	endbr32 
80104bd4:	55                   	push   %ebp
80104bd5:	89 e5                	mov    %esp,%ebp
80104bd7:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r"(eflags));
80104bda:	9c                   	pushf  
80104bdb:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104bdc:	f6 c4 02             	test   $0x2,%ah
80104bdf:	75 31                	jne    80104c12 <popcli+0x42>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
80104be1:	e8 2a f3 ff ff       	call   80103f10 <mycpu>
80104be6:	83 a8 a4 00 00 00 01 	subl   $0x1,0xa4(%eax)
80104bed:	78 30                	js     80104c1f <popcli+0x4f>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104bef:	e8 1c f3 ff ff       	call   80103f10 <mycpu>
80104bf4:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80104bfa:	85 d2                	test   %edx,%edx
80104bfc:	74 02                	je     80104c00 <popcli+0x30>
    sti();
}
80104bfe:	c9                   	leave  
80104bff:	c3                   	ret    
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104c00:	e8 0b f3 ff ff       	call   80103f10 <mycpu>
80104c05:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
80104c0b:	85 c0                	test   %eax,%eax
80104c0d:	74 ef                	je     80104bfe <popcli+0x2e>
  asm volatile("sti");
80104c0f:	fb                   	sti    
}
80104c10:	c9                   	leave  
80104c11:	c3                   	ret    
    panic("popcli - interruptible");
80104c12:	83 ec 0c             	sub    $0xc,%esp
80104c15:	68 f7 7f 10 80       	push   $0x80107ff7
80104c1a:	e8 91 b7 ff ff       	call   801003b0 <panic>
    panic("popcli");
80104c1f:	83 ec 0c             	sub    $0xc,%esp
80104c22:	68 0e 80 10 80       	push   $0x8010800e
80104c27:	e8 84 b7 ff ff       	call   801003b0 <panic>
80104c2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104c30 <holding>:
{
80104c30:	f3 0f 1e fb          	endbr32 
80104c34:	55                   	push   %ebp
80104c35:	89 e5                	mov    %esp,%ebp
80104c37:	56                   	push   %esi
80104c38:	53                   	push   %ebx
80104c39:	8b 75 08             	mov    0x8(%ebp),%esi
80104c3c:	31 db                	xor    %ebx,%ebx
  pushcli();
80104c3e:	e8 3d ff ff ff       	call   80104b80 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
80104c43:	8b 06                	mov    (%esi),%eax
80104c45:	85 c0                	test   %eax,%eax
80104c47:	75 0f                	jne    80104c58 <holding+0x28>
  popcli();
80104c49:	e8 82 ff ff ff       	call   80104bd0 <popcli>
}
80104c4e:	89 d8                	mov    %ebx,%eax
80104c50:	5b                   	pop    %ebx
80104c51:	5e                   	pop    %esi
80104c52:	5d                   	pop    %ebp
80104c53:	c3                   	ret    
80104c54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  r = lock->locked && lock->cpu == mycpu();
80104c58:	8b 5e 08             	mov    0x8(%esi),%ebx
80104c5b:	e8 b0 f2 ff ff       	call   80103f10 <mycpu>
80104c60:	39 c3                	cmp    %eax,%ebx
80104c62:	0f 94 c3             	sete   %bl
  popcli();
80104c65:	e8 66 ff ff ff       	call   80104bd0 <popcli>
  r = lock->locked && lock->cpu == mycpu();
80104c6a:	0f b6 db             	movzbl %bl,%ebx
}
80104c6d:	89 d8                	mov    %ebx,%eax
80104c6f:	5b                   	pop    %ebx
80104c70:	5e                   	pop    %esi
80104c71:	5d                   	pop    %ebp
80104c72:	c3                   	ret    
80104c73:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104c7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104c80 <acquire>:
{
80104c80:	f3 0f 1e fb          	endbr32 
80104c84:	55                   	push   %ebp
80104c85:	89 e5                	mov    %esp,%ebp
80104c87:	56                   	push   %esi
80104c88:	53                   	push   %ebx
  pushcli(); // disable interrupts to avoid deadlock.
80104c89:	e8 f2 fe ff ff       	call   80104b80 <pushcli>
  if(holding(lk))
80104c8e:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104c91:	83 ec 0c             	sub    $0xc,%esp
80104c94:	53                   	push   %ebx
80104c95:	e8 96 ff ff ff       	call   80104c30 <holding>
80104c9a:	83 c4 10             	add    $0x10,%esp
80104c9d:	85 c0                	test   %eax,%eax
80104c9f:	0f 85 7f 00 00 00    	jne    80104d24 <acquire+0xa4>
80104ca5:	89 c6                	mov    %eax,%esi
  asm volatile("lock; xchgl %0, %1" : "+m"(*addr), "=a"(result) : "1"(newval) : "cc");
80104ca7:	ba 01 00 00 00       	mov    $0x1,%edx
80104cac:	eb 05                	jmp    80104cb3 <acquire+0x33>
80104cae:	66 90                	xchg   %ax,%ax
80104cb0:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104cb3:	89 d0                	mov    %edx,%eax
80104cb5:	f0 87 03             	lock xchg %eax,(%ebx)
  while(xchg(&lk->locked, 1) != 0)
80104cb8:	85 c0                	test   %eax,%eax
80104cba:	75 f4                	jne    80104cb0 <acquire+0x30>
  __sync_synchronize();
80104cbc:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
80104cc1:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104cc4:	e8 47 f2 ff ff       	call   80103f10 <mycpu>
80104cc9:	89 43 08             	mov    %eax,0x8(%ebx)
  ebp = (uint*)v - 2;
80104ccc:	89 e8                	mov    %ebp,%eax
80104cce:	66 90                	xchg   %ax,%ax
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104cd0:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
80104cd6:	81 fa fe ff ff 7f    	cmp    $0x7ffffffe,%edx
80104cdc:	77 22                	ja     80104d00 <acquire+0x80>
    pcs[i] = ebp[1];     // saved %eip
80104cde:	8b 50 04             	mov    0x4(%eax),%edx
80104ce1:	89 54 b3 0c          	mov    %edx,0xc(%ebx,%esi,4)
  for(i = 0; i < 10; i++){
80104ce5:	83 c6 01             	add    $0x1,%esi
    ebp = (uint*)ebp[0]; // saved %ebp
80104ce8:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80104cea:	83 fe 0a             	cmp    $0xa,%esi
80104ced:	75 e1                	jne    80104cd0 <acquire+0x50>
}
80104cef:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104cf2:	5b                   	pop    %ebx
80104cf3:	5e                   	pop    %esi
80104cf4:	5d                   	pop    %ebp
80104cf5:	c3                   	ret    
80104cf6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104cfd:	8d 76 00             	lea    0x0(%esi),%esi
  for(; i < 10; i++)
80104d00:	8d 44 b3 0c          	lea    0xc(%ebx,%esi,4),%eax
80104d04:	83 c3 34             	add    $0x34,%ebx
80104d07:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104d0e:	66 90                	xchg   %ax,%ax
    pcs[i] = 0;
80104d10:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
80104d16:	83 c0 04             	add    $0x4,%eax
80104d19:	39 d8                	cmp    %ebx,%eax
80104d1b:	75 f3                	jne    80104d10 <acquire+0x90>
}
80104d1d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104d20:	5b                   	pop    %ebx
80104d21:	5e                   	pop    %esi
80104d22:	5d                   	pop    %ebp
80104d23:	c3                   	ret    
    panic("acquire");
80104d24:	83 ec 0c             	sub    $0xc,%esp
80104d27:	68 15 80 10 80       	push   $0x80108015
80104d2c:	e8 7f b6 ff ff       	call   801003b0 <panic>
80104d31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104d38:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104d3f:	90                   	nop

80104d40 <release>:
{
80104d40:	f3 0f 1e fb          	endbr32 
80104d44:	55                   	push   %ebp
80104d45:	89 e5                	mov    %esp,%ebp
80104d47:	53                   	push   %ebx
80104d48:	83 ec 10             	sub    $0x10,%esp
80104d4b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holding(lk))
80104d4e:	53                   	push   %ebx
80104d4f:	e8 dc fe ff ff       	call   80104c30 <holding>
80104d54:	83 c4 10             	add    $0x10,%esp
80104d57:	85 c0                	test   %eax,%eax
80104d59:	74 22                	je     80104d7d <release+0x3d>
  lk->pcs[0] = 0;
80104d5b:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
80104d62:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
80104d69:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
80104d6e:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
80104d74:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104d77:	c9                   	leave  
  popcli();
80104d78:	e9 53 fe ff ff       	jmp    80104bd0 <popcli>
    panic("release");
80104d7d:	83 ec 0c             	sub    $0xc,%esp
80104d80:	68 1d 80 10 80       	push   $0x8010801d
80104d85:	e8 26 b6 ff ff       	call   801003b0 <panic>
80104d8a:	66 90                	xchg   %ax,%ax
80104d8c:	66 90                	xchg   %ax,%ax
80104d8e:	66 90                	xchg   %ax,%ax

80104d90 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80104d90:	f3 0f 1e fb          	endbr32 
80104d94:	55                   	push   %ebp
80104d95:	89 e5                	mov    %esp,%ebp
80104d97:	57                   	push   %edi
80104d98:	8b 55 08             	mov    0x8(%ebp),%edx
80104d9b:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104d9e:	53                   	push   %ebx
80104d9f:	8b 45 0c             	mov    0xc(%ebp),%eax
  if ((int)dst%4 == 0 && n%4 == 0){
80104da2:	89 d7                	mov    %edx,%edi
80104da4:	09 cf                	or     %ecx,%edi
80104da6:	83 e7 03             	and    $0x3,%edi
80104da9:	75 25                	jne    80104dd0 <memset+0x40>
    c &= 0xFF;
80104dab:	0f b6 f8             	movzbl %al,%edi
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
80104dae:	c1 e0 18             	shl    $0x18,%eax
80104db1:	89 fb                	mov    %edi,%ebx
80104db3:	c1 e9 02             	shr    $0x2,%ecx
80104db6:	c1 e3 10             	shl    $0x10,%ebx
80104db9:	09 d8                	or     %ebx,%eax
80104dbb:	09 f8                	or     %edi,%eax
80104dbd:	c1 e7 08             	shl    $0x8,%edi
80104dc0:	09 f8                	or     %edi,%eax
  asm volatile("cld; rep stosl" : "=D"(addr), "=c"(cnt) : "0"(addr), "1"(cnt), "a"(data) : "memory", "cc");
80104dc2:	89 d7                	mov    %edx,%edi
80104dc4:	fc                   	cld    
80104dc5:	f3 ab                	rep stos %eax,%es:(%edi)
  } else
    stosb(dst, c, n);
  return dst;
}
80104dc7:	5b                   	pop    %ebx
80104dc8:	89 d0                	mov    %edx,%eax
80104dca:	5f                   	pop    %edi
80104dcb:	5d                   	pop    %ebp
80104dcc:	c3                   	ret    
80104dcd:	8d 76 00             	lea    0x0(%esi),%esi
  asm volatile("cld; rep stosb" : "=D"(addr), "=c"(cnt) : "0"(addr), "1"(cnt), "a"(data) : "memory", "cc");
80104dd0:	89 d7                	mov    %edx,%edi
80104dd2:	fc                   	cld    
80104dd3:	f3 aa                	rep stos %al,%es:(%edi)
80104dd5:	5b                   	pop    %ebx
80104dd6:	89 d0                	mov    %edx,%eax
80104dd8:	5f                   	pop    %edi
80104dd9:	5d                   	pop    %ebp
80104dda:	c3                   	ret    
80104ddb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104ddf:	90                   	nop

80104de0 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80104de0:	f3 0f 1e fb          	endbr32 
80104de4:	55                   	push   %ebp
80104de5:	89 e5                	mov    %esp,%ebp
80104de7:	56                   	push   %esi
80104de8:	8b 75 10             	mov    0x10(%ebp),%esi
80104deb:	8b 55 08             	mov    0x8(%ebp),%edx
80104dee:	53                   	push   %ebx
80104def:	8b 45 0c             	mov    0xc(%ebp),%eax
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
80104df2:	85 f6                	test   %esi,%esi
80104df4:	74 2a                	je     80104e20 <memcmp+0x40>
80104df6:	01 c6                	add    %eax,%esi
80104df8:	eb 10                	jmp    80104e0a <memcmp+0x2a>
80104dfa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
80104e00:	83 c0 01             	add    $0x1,%eax
80104e03:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0){
80104e06:	39 f0                	cmp    %esi,%eax
80104e08:	74 16                	je     80104e20 <memcmp+0x40>
    if(*s1 != *s2)
80104e0a:	0f b6 0a             	movzbl (%edx),%ecx
80104e0d:	0f b6 18             	movzbl (%eax),%ebx
80104e10:	38 d9                	cmp    %bl,%cl
80104e12:	74 ec                	je     80104e00 <memcmp+0x20>
      return *s1 - *s2;
80104e14:	0f b6 c1             	movzbl %cl,%eax
80104e17:	29 d8                	sub    %ebx,%eax
  }

  return 0;
}
80104e19:	5b                   	pop    %ebx
80104e1a:	5e                   	pop    %esi
80104e1b:	5d                   	pop    %ebp
80104e1c:	c3                   	ret    
80104e1d:	8d 76 00             	lea    0x0(%esi),%esi
80104e20:	5b                   	pop    %ebx
  return 0;
80104e21:	31 c0                	xor    %eax,%eax
}
80104e23:	5e                   	pop    %esi
80104e24:	5d                   	pop    %ebp
80104e25:	c3                   	ret    
80104e26:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104e2d:	8d 76 00             	lea    0x0(%esi),%esi

80104e30 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80104e30:	f3 0f 1e fb          	endbr32 
80104e34:	55                   	push   %ebp
80104e35:	89 e5                	mov    %esp,%ebp
80104e37:	57                   	push   %edi
80104e38:	8b 55 08             	mov    0x8(%ebp),%edx
80104e3b:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104e3e:	56                   	push   %esi
80104e3f:	8b 75 0c             	mov    0xc(%ebp),%esi
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
80104e42:	39 d6                	cmp    %edx,%esi
80104e44:	73 2a                	jae    80104e70 <memmove+0x40>
80104e46:	8d 3c 0e             	lea    (%esi,%ecx,1),%edi
80104e49:	39 fa                	cmp    %edi,%edx
80104e4b:	73 23                	jae    80104e70 <memmove+0x40>
80104e4d:	8d 41 ff             	lea    -0x1(%ecx),%eax
    s += n;
    d += n;
    while(n-- > 0)
80104e50:	85 c9                	test   %ecx,%ecx
80104e52:	74 13                	je     80104e67 <memmove+0x37>
80104e54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      *--d = *--s;
80104e58:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
80104e5c:	88 0c 02             	mov    %cl,(%edx,%eax,1)
    while(n-- > 0)
80104e5f:	83 e8 01             	sub    $0x1,%eax
80104e62:	83 f8 ff             	cmp    $0xffffffff,%eax
80104e65:	75 f1                	jne    80104e58 <memmove+0x28>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
80104e67:	5e                   	pop    %esi
80104e68:	89 d0                	mov    %edx,%eax
80104e6a:	5f                   	pop    %edi
80104e6b:	5d                   	pop    %ebp
80104e6c:	c3                   	ret    
80104e6d:	8d 76 00             	lea    0x0(%esi),%esi
    while(n-- > 0)
80104e70:	8d 04 0e             	lea    (%esi,%ecx,1),%eax
80104e73:	89 d7                	mov    %edx,%edi
80104e75:	85 c9                	test   %ecx,%ecx
80104e77:	74 ee                	je     80104e67 <memmove+0x37>
80104e79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      *d++ = *s++;
80104e80:	a4                   	movsb  %ds:(%esi),%es:(%edi)
    while(n-- > 0)
80104e81:	39 f0                	cmp    %esi,%eax
80104e83:	75 fb                	jne    80104e80 <memmove+0x50>
}
80104e85:	5e                   	pop    %esi
80104e86:	89 d0                	mov    %edx,%eax
80104e88:	5f                   	pop    %edi
80104e89:	5d                   	pop    %ebp
80104e8a:	c3                   	ret    
80104e8b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104e8f:	90                   	nop

80104e90 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
80104e90:	f3 0f 1e fb          	endbr32 
  return memmove(dst, src, n);
80104e94:	eb 9a                	jmp    80104e30 <memmove>
80104e96:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104e9d:	8d 76 00             	lea    0x0(%esi),%esi

80104ea0 <strncmp>:
}

int
strncmp(const char *p, const char *q, uint n)
{
80104ea0:	f3 0f 1e fb          	endbr32 
80104ea4:	55                   	push   %ebp
80104ea5:	89 e5                	mov    %esp,%ebp
80104ea7:	56                   	push   %esi
80104ea8:	8b 75 10             	mov    0x10(%ebp),%esi
80104eab:	8b 4d 08             	mov    0x8(%ebp),%ecx
80104eae:	53                   	push   %ebx
80104eaf:	8b 45 0c             	mov    0xc(%ebp),%eax
  while(n > 0 && *p && *p == *q)
80104eb2:	85 f6                	test   %esi,%esi
80104eb4:	74 32                	je     80104ee8 <strncmp+0x48>
80104eb6:	01 c6                	add    %eax,%esi
80104eb8:	eb 14                	jmp    80104ece <strncmp+0x2e>
80104eba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104ec0:	38 da                	cmp    %bl,%dl
80104ec2:	75 14                	jne    80104ed8 <strncmp+0x38>
    n--, p++, q++;
80104ec4:	83 c0 01             	add    $0x1,%eax
80104ec7:	83 c1 01             	add    $0x1,%ecx
  while(n > 0 && *p && *p == *q)
80104eca:	39 f0                	cmp    %esi,%eax
80104ecc:	74 1a                	je     80104ee8 <strncmp+0x48>
80104ece:	0f b6 11             	movzbl (%ecx),%edx
80104ed1:	0f b6 18             	movzbl (%eax),%ebx
80104ed4:	84 d2                	test   %dl,%dl
80104ed6:	75 e8                	jne    80104ec0 <strncmp+0x20>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
80104ed8:	0f b6 c2             	movzbl %dl,%eax
80104edb:	29 d8                	sub    %ebx,%eax
}
80104edd:	5b                   	pop    %ebx
80104ede:	5e                   	pop    %esi
80104edf:	5d                   	pop    %ebp
80104ee0:	c3                   	ret    
80104ee1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104ee8:	5b                   	pop    %ebx
    return 0;
80104ee9:	31 c0                	xor    %eax,%eax
}
80104eeb:	5e                   	pop    %esi
80104eec:	5d                   	pop    %ebp
80104eed:	c3                   	ret    
80104eee:	66 90                	xchg   %ax,%ax

80104ef0 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80104ef0:	f3 0f 1e fb          	endbr32 
80104ef4:	55                   	push   %ebp
80104ef5:	89 e5                	mov    %esp,%ebp
80104ef7:	57                   	push   %edi
80104ef8:	56                   	push   %esi
80104ef9:	8b 75 08             	mov    0x8(%ebp),%esi
80104efc:	53                   	push   %ebx
80104efd:	8b 45 10             	mov    0x10(%ebp),%eax
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
80104f00:	89 f2                	mov    %esi,%edx
80104f02:	eb 1b                	jmp    80104f1f <strncpy+0x2f>
80104f04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104f08:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
80104f0c:	8b 7d 0c             	mov    0xc(%ebp),%edi
80104f0f:	83 c2 01             	add    $0x1,%edx
80104f12:	0f b6 7f ff          	movzbl -0x1(%edi),%edi
80104f16:	89 f9                	mov    %edi,%ecx
80104f18:	88 4a ff             	mov    %cl,-0x1(%edx)
80104f1b:	84 c9                	test   %cl,%cl
80104f1d:	74 09                	je     80104f28 <strncpy+0x38>
80104f1f:	89 c3                	mov    %eax,%ebx
80104f21:	83 e8 01             	sub    $0x1,%eax
80104f24:	85 db                	test   %ebx,%ebx
80104f26:	7f e0                	jg     80104f08 <strncpy+0x18>
    ;
  while(n-- > 0)
80104f28:	89 d1                	mov    %edx,%ecx
80104f2a:	85 c0                	test   %eax,%eax
80104f2c:	7e 15                	jle    80104f43 <strncpy+0x53>
80104f2e:	66 90                	xchg   %ax,%ax
    *s++ = 0;
80104f30:	83 c1 01             	add    $0x1,%ecx
80104f33:	c6 41 ff 00          	movb   $0x0,-0x1(%ecx)
  while(n-- > 0)
80104f37:	89 c8                	mov    %ecx,%eax
80104f39:	f7 d0                	not    %eax
80104f3b:	01 d0                	add    %edx,%eax
80104f3d:	01 d8                	add    %ebx,%eax
80104f3f:	85 c0                	test   %eax,%eax
80104f41:	7f ed                	jg     80104f30 <strncpy+0x40>
  return os;
}
80104f43:	5b                   	pop    %ebx
80104f44:	89 f0                	mov    %esi,%eax
80104f46:	5e                   	pop    %esi
80104f47:	5f                   	pop    %edi
80104f48:	5d                   	pop    %ebp
80104f49:	c3                   	ret    
80104f4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104f50 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80104f50:	f3 0f 1e fb          	endbr32 
80104f54:	55                   	push   %ebp
80104f55:	89 e5                	mov    %esp,%ebp
80104f57:	56                   	push   %esi
80104f58:	8b 55 10             	mov    0x10(%ebp),%edx
80104f5b:	8b 75 08             	mov    0x8(%ebp),%esi
80104f5e:	53                   	push   %ebx
80104f5f:	8b 45 0c             	mov    0xc(%ebp),%eax
  char *os;

  os = s;
  if(n <= 0)
80104f62:	85 d2                	test   %edx,%edx
80104f64:	7e 21                	jle    80104f87 <safestrcpy+0x37>
80104f66:	8d 5c 10 ff          	lea    -0x1(%eax,%edx,1),%ebx
80104f6a:	89 f2                	mov    %esi,%edx
80104f6c:	eb 12                	jmp    80104f80 <safestrcpy+0x30>
80104f6e:	66 90                	xchg   %ax,%ax
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80104f70:	0f b6 08             	movzbl (%eax),%ecx
80104f73:	83 c0 01             	add    $0x1,%eax
80104f76:	83 c2 01             	add    $0x1,%edx
80104f79:	88 4a ff             	mov    %cl,-0x1(%edx)
80104f7c:	84 c9                	test   %cl,%cl
80104f7e:	74 04                	je     80104f84 <safestrcpy+0x34>
80104f80:	39 d8                	cmp    %ebx,%eax
80104f82:	75 ec                	jne    80104f70 <safestrcpy+0x20>
    ;
  *s = 0;
80104f84:	c6 02 00             	movb   $0x0,(%edx)
  return os;
}
80104f87:	89 f0                	mov    %esi,%eax
80104f89:	5b                   	pop    %ebx
80104f8a:	5e                   	pop    %esi
80104f8b:	5d                   	pop    %ebp
80104f8c:	c3                   	ret    
80104f8d:	8d 76 00             	lea    0x0(%esi),%esi

80104f90 <strlen>:

int
strlen(const char *s)
{
80104f90:	f3 0f 1e fb          	endbr32 
80104f94:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80104f95:	31 c0                	xor    %eax,%eax
{
80104f97:	89 e5                	mov    %esp,%ebp
80104f99:	8b 55 08             	mov    0x8(%ebp),%edx
  for(n = 0; s[n]; n++)
80104f9c:	80 3a 00             	cmpb   $0x0,(%edx)
80104f9f:	74 10                	je     80104fb1 <strlen+0x21>
80104fa1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104fa8:	83 c0 01             	add    $0x1,%eax
80104fab:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80104faf:	75 f7                	jne    80104fa8 <strlen+0x18>
    ;
  return n;
}
80104fb1:	5d                   	pop    %ebp
80104fb2:	c3                   	ret    

80104fb3 <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
80104fb3:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
80104fb7:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-saved registers
  pushl %ebp
80104fbb:	55                   	push   %ebp
  pushl %ebx
80104fbc:	53                   	push   %ebx
  pushl %esi
80104fbd:	56                   	push   %esi
  pushl %edi
80104fbe:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
80104fbf:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
80104fc1:	89 d4                	mov    %edx,%esp

  # Load new callee-saved registers
  popl %edi
80104fc3:	5f                   	pop    %edi
  popl %esi
80104fc4:	5e                   	pop    %esi
  popl %ebx
80104fc5:	5b                   	pop    %ebx
  popl %ebp
80104fc6:	5d                   	pop    %ebp
  ret
80104fc7:	c3                   	ret    
80104fc8:	66 90                	xchg   %ax,%ax
80104fca:	66 90                	xchg   %ax,%ax
80104fcc:	66 90                	xchg   %ax,%ax
80104fce:	66 90                	xchg   %ax,%ax

80104fd0 <fetchint>:
// library system call function. The saved user %esp points
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int fetchint(uint addr, int *ip)
{
80104fd0:	f3 0f 1e fb          	endbr32 
80104fd4:	55                   	push   %ebp
80104fd5:	89 e5                	mov    %esp,%ebp
80104fd7:	53                   	push   %ebx
80104fd8:	83 ec 04             	sub    $0x4,%esp
80104fdb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
80104fde:	e8 bd ef ff ff       	call   80103fa0 <myproc>

  if (addr >= curproc->sz || addr + 4 > curproc->sz)
80104fe3:	8b 00                	mov    (%eax),%eax
80104fe5:	39 d8                	cmp    %ebx,%eax
80104fe7:	76 17                	jbe    80105000 <fetchint+0x30>
80104fe9:	8d 53 04             	lea    0x4(%ebx),%edx
80104fec:	39 d0                	cmp    %edx,%eax
80104fee:	72 10                	jb     80105000 <fetchint+0x30>
    return -1;
  *ip = *(int *)(addr);
80104ff0:	8b 45 0c             	mov    0xc(%ebp),%eax
80104ff3:	8b 13                	mov    (%ebx),%edx
80104ff5:	89 10                	mov    %edx,(%eax)
  return 0;
80104ff7:	31 c0                	xor    %eax,%eax
}
80104ff9:	83 c4 04             	add    $0x4,%esp
80104ffc:	5b                   	pop    %ebx
80104ffd:	5d                   	pop    %ebp
80104ffe:	c3                   	ret    
80104fff:	90                   	nop
    return -1;
80105000:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105005:	eb f2                	jmp    80104ff9 <fetchint+0x29>
80105007:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010500e:	66 90                	xchg   %ax,%ax

80105010 <fetchstr>:

// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int fetchstr(uint addr, char **pp)
{
80105010:	f3 0f 1e fb          	endbr32 
80105014:	55                   	push   %ebp
80105015:	89 e5                	mov    %esp,%ebp
80105017:	53                   	push   %ebx
80105018:	83 ec 04             	sub    $0x4,%esp
8010501b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
8010501e:	e8 7d ef ff ff       	call   80103fa0 <myproc>

  if (addr >= curproc->sz)
80105023:	39 18                	cmp    %ebx,(%eax)
80105025:	76 31                	jbe    80105058 <fetchstr+0x48>
    return -1;
  *pp = (char *)addr;
80105027:	8b 55 0c             	mov    0xc(%ebp),%edx
8010502a:	89 1a                	mov    %ebx,(%edx)
  ep = (char *)curproc->sz;
8010502c:	8b 10                	mov    (%eax),%edx
  for (s = *pp; s < ep; s++)
8010502e:	39 d3                	cmp    %edx,%ebx
80105030:	73 26                	jae    80105058 <fetchstr+0x48>
80105032:	89 d8                	mov    %ebx,%eax
80105034:	eb 11                	jmp    80105047 <fetchstr+0x37>
80105036:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010503d:	8d 76 00             	lea    0x0(%esi),%esi
80105040:	83 c0 01             	add    $0x1,%eax
80105043:	39 c2                	cmp    %eax,%edx
80105045:	76 11                	jbe    80105058 <fetchstr+0x48>
  {
    if (*s == 0)
80105047:	80 38 00             	cmpb   $0x0,(%eax)
8010504a:	75 f4                	jne    80105040 <fetchstr+0x30>
      return s - *pp;
  }
  return -1;
}
8010504c:	83 c4 04             	add    $0x4,%esp
      return s - *pp;
8010504f:	29 d8                	sub    %ebx,%eax
}
80105051:	5b                   	pop    %ebx
80105052:	5d                   	pop    %ebp
80105053:	c3                   	ret    
80105054:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105058:	83 c4 04             	add    $0x4,%esp
    return -1;
8010505b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105060:	5b                   	pop    %ebx
80105061:	5d                   	pop    %ebp
80105062:	c3                   	ret    
80105063:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010506a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105070 <argint>:

// Fetch the nth 32-bit system call argument.
int argint(int n, int *ip)
{
80105070:	f3 0f 1e fb          	endbr32 
80105074:	55                   	push   %ebp
80105075:	89 e5                	mov    %esp,%ebp
80105077:	56                   	push   %esi
80105078:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4 * n, ip);
80105079:	e8 22 ef ff ff       	call   80103fa0 <myproc>
8010507e:	8b 55 08             	mov    0x8(%ebp),%edx
80105081:	8b 40 18             	mov    0x18(%eax),%eax
80105084:	8b 40 44             	mov    0x44(%eax),%eax
80105087:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
8010508a:	e8 11 ef ff ff       	call   80103fa0 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4 * n, ip);
8010508f:	8d 73 04             	lea    0x4(%ebx),%esi
  if (addr >= curproc->sz || addr + 4 > curproc->sz)
80105092:	8b 00                	mov    (%eax),%eax
80105094:	39 c6                	cmp    %eax,%esi
80105096:	73 18                	jae    801050b0 <argint+0x40>
80105098:	8d 53 08             	lea    0x8(%ebx),%edx
8010509b:	39 d0                	cmp    %edx,%eax
8010509d:	72 11                	jb     801050b0 <argint+0x40>
  *ip = *(int *)(addr);
8010509f:	8b 45 0c             	mov    0xc(%ebp),%eax
801050a2:	8b 53 04             	mov    0x4(%ebx),%edx
801050a5:	89 10                	mov    %edx,(%eax)
  return 0;
801050a7:	31 c0                	xor    %eax,%eax
}
801050a9:	5b                   	pop    %ebx
801050aa:	5e                   	pop    %esi
801050ab:	5d                   	pop    %ebp
801050ac:	c3                   	ret    
801050ad:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
801050b0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchint((myproc()->tf->esp) + 4 + 4 * n, ip);
801050b5:	eb f2                	jmp    801050a9 <argint+0x39>
801050b7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801050be:	66 90                	xchg   %ax,%ax

801050c0 <argptr>:

// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int argptr(int n, char **pp, int size)
{
801050c0:	f3 0f 1e fb          	endbr32 
801050c4:	55                   	push   %ebp
801050c5:	89 e5                	mov    %esp,%ebp
801050c7:	56                   	push   %esi
801050c8:	53                   	push   %ebx
801050c9:	83 ec 10             	sub    $0x10,%esp
801050cc:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int i;
  struct proc *curproc = myproc();
801050cf:	e8 cc ee ff ff       	call   80103fa0 <myproc>

  if (argint(n, &i) < 0)
801050d4:	83 ec 08             	sub    $0x8,%esp
  struct proc *curproc = myproc();
801050d7:	89 c6                	mov    %eax,%esi
  if (argint(n, &i) < 0)
801050d9:	8d 45 f4             	lea    -0xc(%ebp),%eax
801050dc:	50                   	push   %eax
801050dd:	ff 75 08             	pushl  0x8(%ebp)
801050e0:	e8 8b ff ff ff       	call   80105070 <argint>
    return -1;
  if (size < 0 || (uint)i >= curproc->sz || (uint)i + size > curproc->sz)
801050e5:	83 c4 10             	add    $0x10,%esp
801050e8:	85 c0                	test   %eax,%eax
801050ea:	78 24                	js     80105110 <argptr+0x50>
801050ec:	85 db                	test   %ebx,%ebx
801050ee:	78 20                	js     80105110 <argptr+0x50>
801050f0:	8b 16                	mov    (%esi),%edx
801050f2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801050f5:	39 c2                	cmp    %eax,%edx
801050f7:	76 17                	jbe    80105110 <argptr+0x50>
801050f9:	01 c3                	add    %eax,%ebx
801050fb:	39 da                	cmp    %ebx,%edx
801050fd:	72 11                	jb     80105110 <argptr+0x50>
    return -1;
  *pp = (char *)i;
801050ff:	8b 55 0c             	mov    0xc(%ebp),%edx
80105102:	89 02                	mov    %eax,(%edx)
  return 0;
80105104:	31 c0                	xor    %eax,%eax
}
80105106:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105109:	5b                   	pop    %ebx
8010510a:	5e                   	pop    %esi
8010510b:	5d                   	pop    %ebp
8010510c:	c3                   	ret    
8010510d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80105110:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105115:	eb ef                	jmp    80105106 <argptr+0x46>
80105117:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010511e:	66 90                	xchg   %ax,%ax

80105120 <argstr>:
// Fetch the nth word-sized system call argument as a string pointer.
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int argstr(int n, char **pp)
{
80105120:	f3 0f 1e fb          	endbr32 
80105124:	55                   	push   %ebp
80105125:	89 e5                	mov    %esp,%ebp
80105127:	83 ec 20             	sub    $0x20,%esp
  int addr;
  if (argint(n, &addr) < 0)
8010512a:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010512d:	50                   	push   %eax
8010512e:	ff 75 08             	pushl  0x8(%ebp)
80105131:	e8 3a ff ff ff       	call   80105070 <argint>
80105136:	83 c4 10             	add    $0x10,%esp
80105139:	85 c0                	test   %eax,%eax
8010513b:	78 13                	js     80105150 <argstr+0x30>
    return -1;
  return fetchstr(addr, pp);
8010513d:	83 ec 08             	sub    $0x8,%esp
80105140:	ff 75 0c             	pushl  0xc(%ebp)
80105143:	ff 75 f4             	pushl  -0xc(%ebp)
80105146:	e8 c5 fe ff ff       	call   80105010 <fetchstr>
8010514b:	83 c4 10             	add    $0x10,%esp
}
8010514e:	c9                   	leave  
8010514f:	c3                   	ret    
80105150:	c9                   	leave  
    return -1;
80105151:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105156:	c3                   	ret    
80105157:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010515e:	66 90                	xchg   %ax,%ax

80105160 <syscall>:
    [SYS_get_uncle_count] sys_get_uncle_count,
    [SYS_lifetime] sys_lifetime,
};

void syscall(void)
{
80105160:	f3 0f 1e fb          	endbr32 
80105164:	55                   	push   %ebp
80105165:	89 e5                	mov    %esp,%ebp
80105167:	53                   	push   %ebx
80105168:	83 ec 04             	sub    $0x4,%esp
  int num;
  struct proc *curproc = myproc();
8010516b:	e8 30 ee ff ff       	call   80103fa0 <myproc>
80105170:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax;
80105172:	8b 40 18             	mov    0x18(%eax),%eax
80105175:	8b 40 1c             	mov    0x1c(%eax),%eax
  if (num > 0 && num < NELEM(syscalls) && syscalls[num])
80105178:	8d 50 ff             	lea    -0x1(%eax),%edx
8010517b:	83 fa 18             	cmp    $0x18,%edx
8010517e:	77 20                	ja     801051a0 <syscall+0x40>
80105180:	8b 14 85 60 80 10 80 	mov    -0x7fef7fa0(,%eax,4),%edx
80105187:	85 d2                	test   %edx,%edx
80105189:	74 15                	je     801051a0 <syscall+0x40>
  {
    curproc->tf->eax = syscalls[num]();
8010518b:	ff d2                	call   *%edx
8010518d:	89 c2                	mov    %eax,%edx
8010518f:	8b 43 18             	mov    0x18(%ebx),%eax
80105192:	89 50 1c             	mov    %edx,0x1c(%eax)
  {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
80105195:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105198:	c9                   	leave  
80105199:	c3                   	ret    
8010519a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cprintf("%d %s: unknown sys call %d\n",
801051a0:	50                   	push   %eax
            curproc->pid, curproc->name, num);
801051a1:	8d 43 70             	lea    0x70(%ebx),%eax
    cprintf("%d %s: unknown sys call %d\n",
801051a4:	50                   	push   %eax
801051a5:	ff 73 10             	pushl  0x10(%ebx)
801051a8:	68 25 80 10 80       	push   $0x80108025
801051ad:	e8 ee b5 ff ff       	call   801007a0 <cprintf>
    curproc->tf->eax = -1;
801051b2:	8b 43 18             	mov    0x18(%ebx),%eax
801051b5:	83 c4 10             	add    $0x10,%esp
801051b8:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
801051bf:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801051c2:	c9                   	leave  
801051c3:	c3                   	ret    
801051c4:	66 90                	xchg   %ax,%ax
801051c6:	66 90                	xchg   %ax,%ax
801051c8:	66 90                	xchg   %ax,%ax
801051ca:	66 90                	xchg   %ax,%ax
801051cc:	66 90                	xchg   %ax,%ax
801051ce:	66 90                	xchg   %ax,%ax

801051d0 <create>:
  return -1;
}

static struct inode *
create(char *path, short type, short major, short minor)
{
801051d0:	55                   	push   %ebp
801051d1:	89 e5                	mov    %esp,%ebp
801051d3:	57                   	push   %edi
801051d4:	56                   	push   %esi
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if ((dp = nameiparent(path, name)) == 0)
801051d5:	8d 7d da             	lea    -0x26(%ebp),%edi
{
801051d8:	53                   	push   %ebx
801051d9:	83 ec 34             	sub    $0x34,%esp
801051dc:	89 4d d0             	mov    %ecx,-0x30(%ebp)
801051df:	8b 4d 08             	mov    0x8(%ebp),%ecx
  if ((dp = nameiparent(path, name)) == 0)
801051e2:	57                   	push   %edi
801051e3:	50                   	push   %eax
{
801051e4:	89 55 d4             	mov    %edx,-0x2c(%ebp)
801051e7:	89 4d cc             	mov    %ecx,-0x34(%ebp)
  if ((dp = nameiparent(path, name)) == 0)
801051ea:	e8 a1 d4 ff ff       	call   80102690 <nameiparent>
801051ef:	83 c4 10             	add    $0x10,%esp
801051f2:	85 c0                	test   %eax,%eax
801051f4:	0f 84 46 01 00 00    	je     80105340 <create+0x170>
    return 0;
  ilock(dp);
801051fa:	83 ec 0c             	sub    $0xc,%esp
801051fd:	89 c3                	mov    %eax,%ebx
801051ff:	50                   	push   %eax
80105200:	e8 9b cb ff ff       	call   80101da0 <ilock>

  if ((ip = dirlookup(dp, name, 0)) != 0)
80105205:	83 c4 0c             	add    $0xc,%esp
80105208:	6a 00                	push   $0x0
8010520a:	57                   	push   %edi
8010520b:	53                   	push   %ebx
8010520c:	e8 df d0 ff ff       	call   801022f0 <dirlookup>
80105211:	83 c4 10             	add    $0x10,%esp
80105214:	89 c6                	mov    %eax,%esi
80105216:	85 c0                	test   %eax,%eax
80105218:	74 56                	je     80105270 <create+0xa0>
  {
    iunlockput(dp);
8010521a:	83 ec 0c             	sub    $0xc,%esp
8010521d:	53                   	push   %ebx
8010521e:	e8 1d ce ff ff       	call   80102040 <iunlockput>
    ilock(ip);
80105223:	89 34 24             	mov    %esi,(%esp)
80105226:	e8 75 cb ff ff       	call   80101da0 <ilock>
    if (type == T_FILE && ip->type == T_FILE)
8010522b:	83 c4 10             	add    $0x10,%esp
8010522e:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
80105233:	75 1b                	jne    80105250 <create+0x80>
80105235:	66 83 7e 50 02       	cmpw   $0x2,0x50(%esi)
8010523a:	75 14                	jne    80105250 <create+0x80>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
8010523c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010523f:	89 f0                	mov    %esi,%eax
80105241:	5b                   	pop    %ebx
80105242:	5e                   	pop    %esi
80105243:	5f                   	pop    %edi
80105244:	5d                   	pop    %ebp
80105245:	c3                   	ret    
80105246:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010524d:	8d 76 00             	lea    0x0(%esi),%esi
    iunlockput(ip);
80105250:	83 ec 0c             	sub    $0xc,%esp
80105253:	56                   	push   %esi
    return 0;
80105254:	31 f6                	xor    %esi,%esi
    iunlockput(ip);
80105256:	e8 e5 cd ff ff       	call   80102040 <iunlockput>
    return 0;
8010525b:	83 c4 10             	add    $0x10,%esp
}
8010525e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105261:	89 f0                	mov    %esi,%eax
80105263:	5b                   	pop    %ebx
80105264:	5e                   	pop    %esi
80105265:	5f                   	pop    %edi
80105266:	5d                   	pop    %ebp
80105267:	c3                   	ret    
80105268:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010526f:	90                   	nop
  if ((ip = ialloc(dp->dev, type)) == 0)
80105270:	0f bf 45 d4          	movswl -0x2c(%ebp),%eax
80105274:	83 ec 08             	sub    $0x8,%esp
80105277:	50                   	push   %eax
80105278:	ff 33                	pushl  (%ebx)
8010527a:	e8 a1 c9 ff ff       	call   80101c20 <ialloc>
8010527f:	83 c4 10             	add    $0x10,%esp
80105282:	89 c6                	mov    %eax,%esi
80105284:	85 c0                	test   %eax,%eax
80105286:	0f 84 cd 00 00 00    	je     80105359 <create+0x189>
  ilock(ip);
8010528c:	83 ec 0c             	sub    $0xc,%esp
8010528f:	50                   	push   %eax
80105290:	e8 0b cb ff ff       	call   80101da0 <ilock>
  ip->major = major;
80105295:	0f b7 45 d0          	movzwl -0x30(%ebp),%eax
80105299:	66 89 46 52          	mov    %ax,0x52(%esi)
  ip->minor = minor;
8010529d:	0f b7 45 cc          	movzwl -0x34(%ebp),%eax
801052a1:	66 89 46 54          	mov    %ax,0x54(%esi)
  ip->nlink = 1;
801052a5:	b8 01 00 00 00       	mov    $0x1,%eax
801052aa:	66 89 46 56          	mov    %ax,0x56(%esi)
  iupdate(ip);
801052ae:	89 34 24             	mov    %esi,(%esp)
801052b1:	e8 2a ca ff ff       	call   80101ce0 <iupdate>
  if (type == T_DIR)
801052b6:	83 c4 10             	add    $0x10,%esp
801052b9:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
801052be:	74 30                	je     801052f0 <create+0x120>
  if (dirlink(dp, name, ip->inum) < 0)
801052c0:	83 ec 04             	sub    $0x4,%esp
801052c3:	ff 76 04             	pushl  0x4(%esi)
801052c6:	57                   	push   %edi
801052c7:	53                   	push   %ebx
801052c8:	e8 e3 d2 ff ff       	call   801025b0 <dirlink>
801052cd:	83 c4 10             	add    $0x10,%esp
801052d0:	85 c0                	test   %eax,%eax
801052d2:	78 78                	js     8010534c <create+0x17c>
  iunlockput(dp);
801052d4:	83 ec 0c             	sub    $0xc,%esp
801052d7:	53                   	push   %ebx
801052d8:	e8 63 cd ff ff       	call   80102040 <iunlockput>
  return ip;
801052dd:	83 c4 10             	add    $0x10,%esp
}
801052e0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801052e3:	89 f0                	mov    %esi,%eax
801052e5:	5b                   	pop    %ebx
801052e6:	5e                   	pop    %esi
801052e7:	5f                   	pop    %edi
801052e8:	5d                   	pop    %ebp
801052e9:	c3                   	ret    
801052ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iupdate(dp);
801052f0:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink++; // for ".."
801052f3:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
    iupdate(dp);
801052f8:	53                   	push   %ebx
801052f9:	e8 e2 c9 ff ff       	call   80101ce0 <iupdate>
    if (dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
801052fe:	83 c4 0c             	add    $0xc,%esp
80105301:	ff 76 04             	pushl  0x4(%esi)
80105304:	68 e4 80 10 80       	push   $0x801080e4
80105309:	56                   	push   %esi
8010530a:	e8 a1 d2 ff ff       	call   801025b0 <dirlink>
8010530f:	83 c4 10             	add    $0x10,%esp
80105312:	85 c0                	test   %eax,%eax
80105314:	78 18                	js     8010532e <create+0x15e>
80105316:	83 ec 04             	sub    $0x4,%esp
80105319:	ff 73 04             	pushl  0x4(%ebx)
8010531c:	68 e3 80 10 80       	push   $0x801080e3
80105321:	56                   	push   %esi
80105322:	e8 89 d2 ff ff       	call   801025b0 <dirlink>
80105327:	83 c4 10             	add    $0x10,%esp
8010532a:	85 c0                	test   %eax,%eax
8010532c:	79 92                	jns    801052c0 <create+0xf0>
      panic("create dots");
8010532e:	83 ec 0c             	sub    $0xc,%esp
80105331:	68 d7 80 10 80       	push   $0x801080d7
80105336:	e8 75 b0 ff ff       	call   801003b0 <panic>
8010533b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010533f:	90                   	nop
}
80105340:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
80105343:	31 f6                	xor    %esi,%esi
}
80105345:	5b                   	pop    %ebx
80105346:	89 f0                	mov    %esi,%eax
80105348:	5e                   	pop    %esi
80105349:	5f                   	pop    %edi
8010534a:	5d                   	pop    %ebp
8010534b:	c3                   	ret    
    panic("create: dirlink");
8010534c:	83 ec 0c             	sub    $0xc,%esp
8010534f:	68 e6 80 10 80       	push   $0x801080e6
80105354:	e8 57 b0 ff ff       	call   801003b0 <panic>
    panic("create: ialloc");
80105359:	83 ec 0c             	sub    $0xc,%esp
8010535c:	68 c8 80 10 80       	push   $0x801080c8
80105361:	e8 4a b0 ff ff       	call   801003b0 <panic>
80105366:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010536d:	8d 76 00             	lea    0x0(%esi),%esi

80105370 <argfd.constprop.0>:
argfd(int n, int *pfd, struct file **pf)
80105370:	55                   	push   %ebp
80105371:	89 e5                	mov    %esp,%ebp
80105373:	56                   	push   %esi
80105374:	89 d6                	mov    %edx,%esi
80105376:	53                   	push   %ebx
80105377:	89 c3                	mov    %eax,%ebx
  if (argint(n, &fd) < 0)
80105379:	8d 45 f4             	lea    -0xc(%ebp),%eax
argfd(int n, int *pfd, struct file **pf)
8010537c:	83 ec 18             	sub    $0x18,%esp
  if (argint(n, &fd) < 0)
8010537f:	50                   	push   %eax
80105380:	6a 00                	push   $0x0
80105382:	e8 e9 fc ff ff       	call   80105070 <argint>
80105387:	83 c4 10             	add    $0x10,%esp
8010538a:	85 c0                	test   %eax,%eax
8010538c:	78 2a                	js     801053b8 <argfd.constprop.0+0x48>
  if (fd < 0 || fd >= NOFILE || (f = myproc()->ofile[fd]) == 0)
8010538e:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80105392:	77 24                	ja     801053b8 <argfd.constprop.0+0x48>
80105394:	e8 07 ec ff ff       	call   80103fa0 <myproc>
80105399:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010539c:	8b 44 90 28          	mov    0x28(%eax,%edx,4),%eax
801053a0:	85 c0                	test   %eax,%eax
801053a2:	74 14                	je     801053b8 <argfd.constprop.0+0x48>
  if (pfd)
801053a4:	85 db                	test   %ebx,%ebx
801053a6:	74 02                	je     801053aa <argfd.constprop.0+0x3a>
    *pfd = fd;
801053a8:	89 13                	mov    %edx,(%ebx)
    *pf = f;
801053aa:	89 06                	mov    %eax,(%esi)
  return 0;
801053ac:	31 c0                	xor    %eax,%eax
}
801053ae:	8d 65 f8             	lea    -0x8(%ebp),%esp
801053b1:	5b                   	pop    %ebx
801053b2:	5e                   	pop    %esi
801053b3:	5d                   	pop    %ebp
801053b4:	c3                   	ret    
801053b5:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
801053b8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801053bd:	eb ef                	jmp    801053ae <argfd.constprop.0+0x3e>
801053bf:	90                   	nop

801053c0 <sys_dup>:
{
801053c0:	f3 0f 1e fb          	endbr32 
801053c4:	55                   	push   %ebp
  if (argfd(0, 0, &f) < 0)
801053c5:	31 c0                	xor    %eax,%eax
{
801053c7:	89 e5                	mov    %esp,%ebp
801053c9:	56                   	push   %esi
801053ca:	53                   	push   %ebx
  if (argfd(0, 0, &f) < 0)
801053cb:	8d 55 f4             	lea    -0xc(%ebp),%edx
{
801053ce:	83 ec 10             	sub    $0x10,%esp
  if (argfd(0, 0, &f) < 0)
801053d1:	e8 9a ff ff ff       	call   80105370 <argfd.constprop.0>
801053d6:	85 c0                	test   %eax,%eax
801053d8:	78 1e                	js     801053f8 <sys_dup+0x38>
  if ((fd = fdalloc(f)) < 0)
801053da:	8b 75 f4             	mov    -0xc(%ebp),%esi
  for (fd = 0; fd < NOFILE; fd++)
801053dd:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
801053df:	e8 bc eb ff ff       	call   80103fa0 <myproc>
  for (fd = 0; fd < NOFILE; fd++)
801053e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if (curproc->ofile[fd] == 0)
801053e8:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
801053ec:	85 d2                	test   %edx,%edx
801053ee:	74 20                	je     80105410 <sys_dup+0x50>
  for (fd = 0; fd < NOFILE; fd++)
801053f0:	83 c3 01             	add    $0x1,%ebx
801053f3:	83 fb 10             	cmp    $0x10,%ebx
801053f6:	75 f0                	jne    801053e8 <sys_dup+0x28>
}
801053f8:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return -1;
801053fb:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
80105400:	89 d8                	mov    %ebx,%eax
80105402:	5b                   	pop    %ebx
80105403:	5e                   	pop    %esi
80105404:	5d                   	pop    %ebp
80105405:	c3                   	ret    
80105406:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010540d:	8d 76 00             	lea    0x0(%esi),%esi
      curproc->ofile[fd] = f;
80105410:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)
  filedup(f);
80105414:	83 ec 0c             	sub    $0xc,%esp
80105417:	ff 75 f4             	pushl  -0xc(%ebp)
8010541a:	e8 91 c0 ff ff       	call   801014b0 <filedup>
  return fd;
8010541f:	83 c4 10             	add    $0x10,%esp
}
80105422:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105425:	89 d8                	mov    %ebx,%eax
80105427:	5b                   	pop    %ebx
80105428:	5e                   	pop    %esi
80105429:	5d                   	pop    %ebp
8010542a:	c3                   	ret    
8010542b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010542f:	90                   	nop

80105430 <sys_read>:
{
80105430:	f3 0f 1e fb          	endbr32 
80105434:	55                   	push   %ebp
  if (argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105435:	31 c0                	xor    %eax,%eax
{
80105437:	89 e5                	mov    %esp,%ebp
80105439:	83 ec 18             	sub    $0x18,%esp
  if (argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
8010543c:	8d 55 ec             	lea    -0x14(%ebp),%edx
8010543f:	e8 2c ff ff ff       	call   80105370 <argfd.constprop.0>
80105444:	85 c0                	test   %eax,%eax
80105446:	78 48                	js     80105490 <sys_read+0x60>
80105448:	83 ec 08             	sub    $0x8,%esp
8010544b:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010544e:	50                   	push   %eax
8010544f:	6a 02                	push   $0x2
80105451:	e8 1a fc ff ff       	call   80105070 <argint>
80105456:	83 c4 10             	add    $0x10,%esp
80105459:	85 c0                	test   %eax,%eax
8010545b:	78 33                	js     80105490 <sys_read+0x60>
8010545d:	83 ec 04             	sub    $0x4,%esp
80105460:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105463:	ff 75 f0             	pushl  -0x10(%ebp)
80105466:	50                   	push   %eax
80105467:	6a 01                	push   $0x1
80105469:	e8 52 fc ff ff       	call   801050c0 <argptr>
8010546e:	83 c4 10             	add    $0x10,%esp
80105471:	85 c0                	test   %eax,%eax
80105473:	78 1b                	js     80105490 <sys_read+0x60>
  return fileread(f, p, n);
80105475:	83 ec 04             	sub    $0x4,%esp
80105478:	ff 75 f0             	pushl  -0x10(%ebp)
8010547b:	ff 75 f4             	pushl  -0xc(%ebp)
8010547e:	ff 75 ec             	pushl  -0x14(%ebp)
80105481:	e8 aa c1 ff ff       	call   80101630 <fileread>
80105486:	83 c4 10             	add    $0x10,%esp
}
80105489:	c9                   	leave  
8010548a:	c3                   	ret    
8010548b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010548f:	90                   	nop
80105490:	c9                   	leave  
    return -1;
80105491:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105496:	c3                   	ret    
80105497:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010549e:	66 90                	xchg   %ax,%ax

801054a0 <sys_write>:
{
801054a0:	f3 0f 1e fb          	endbr32 
801054a4:	55                   	push   %ebp
  if (argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
801054a5:	31 c0                	xor    %eax,%eax
{
801054a7:	89 e5                	mov    %esp,%ebp
801054a9:	83 ec 18             	sub    $0x18,%esp
  if (argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
801054ac:	8d 55 ec             	lea    -0x14(%ebp),%edx
801054af:	e8 bc fe ff ff       	call   80105370 <argfd.constprop.0>
801054b4:	85 c0                	test   %eax,%eax
801054b6:	78 48                	js     80105500 <sys_write+0x60>
801054b8:	83 ec 08             	sub    $0x8,%esp
801054bb:	8d 45 f0             	lea    -0x10(%ebp),%eax
801054be:	50                   	push   %eax
801054bf:	6a 02                	push   $0x2
801054c1:	e8 aa fb ff ff       	call   80105070 <argint>
801054c6:	83 c4 10             	add    $0x10,%esp
801054c9:	85 c0                	test   %eax,%eax
801054cb:	78 33                	js     80105500 <sys_write+0x60>
801054cd:	83 ec 04             	sub    $0x4,%esp
801054d0:	8d 45 f4             	lea    -0xc(%ebp),%eax
801054d3:	ff 75 f0             	pushl  -0x10(%ebp)
801054d6:	50                   	push   %eax
801054d7:	6a 01                	push   $0x1
801054d9:	e8 e2 fb ff ff       	call   801050c0 <argptr>
801054de:	83 c4 10             	add    $0x10,%esp
801054e1:	85 c0                	test   %eax,%eax
801054e3:	78 1b                	js     80105500 <sys_write+0x60>
  return filewrite(f, p, n);
801054e5:	83 ec 04             	sub    $0x4,%esp
801054e8:	ff 75 f0             	pushl  -0x10(%ebp)
801054eb:	ff 75 f4             	pushl  -0xc(%ebp)
801054ee:	ff 75 ec             	pushl  -0x14(%ebp)
801054f1:	e8 da c1 ff ff       	call   801016d0 <filewrite>
801054f6:	83 c4 10             	add    $0x10,%esp
}
801054f9:	c9                   	leave  
801054fa:	c3                   	ret    
801054fb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801054ff:	90                   	nop
80105500:	c9                   	leave  
    return -1;
80105501:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105506:	c3                   	ret    
80105507:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010550e:	66 90                	xchg   %ax,%ax

80105510 <sys_close>:
{
80105510:	f3 0f 1e fb          	endbr32 
80105514:	55                   	push   %ebp
80105515:	89 e5                	mov    %esp,%ebp
80105517:	83 ec 18             	sub    $0x18,%esp
  if (argfd(0, &fd, &f) < 0)
8010551a:	8d 55 f4             	lea    -0xc(%ebp),%edx
8010551d:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105520:	e8 4b fe ff ff       	call   80105370 <argfd.constprop.0>
80105525:	85 c0                	test   %eax,%eax
80105527:	78 27                	js     80105550 <sys_close+0x40>
  myproc()->ofile[fd] = 0;
80105529:	e8 72 ea ff ff       	call   80103fa0 <myproc>
8010552e:	8b 55 f0             	mov    -0x10(%ebp),%edx
  fileclose(f);
80105531:	83 ec 0c             	sub    $0xc,%esp
  myproc()->ofile[fd] = 0;
80105534:	c7 44 90 28 00 00 00 	movl   $0x0,0x28(%eax,%edx,4)
8010553b:	00 
  fileclose(f);
8010553c:	ff 75 f4             	pushl  -0xc(%ebp)
8010553f:	e8 bc bf ff ff       	call   80101500 <fileclose>
  return 0;
80105544:	83 c4 10             	add    $0x10,%esp
80105547:	31 c0                	xor    %eax,%eax
}
80105549:	c9                   	leave  
8010554a:	c3                   	ret    
8010554b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010554f:	90                   	nop
80105550:	c9                   	leave  
    return -1;
80105551:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105556:	c3                   	ret    
80105557:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010555e:	66 90                	xchg   %ax,%ax

80105560 <sys_fstat>:
{
80105560:	f3 0f 1e fb          	endbr32 
80105564:	55                   	push   %ebp
  if (argfd(0, 0, &f) < 0 || argptr(1, (void *)&st, sizeof(*st)) < 0)
80105565:	31 c0                	xor    %eax,%eax
{
80105567:	89 e5                	mov    %esp,%ebp
80105569:	83 ec 18             	sub    $0x18,%esp
  if (argfd(0, 0, &f) < 0 || argptr(1, (void *)&st, sizeof(*st)) < 0)
8010556c:	8d 55 f0             	lea    -0x10(%ebp),%edx
8010556f:	e8 fc fd ff ff       	call   80105370 <argfd.constprop.0>
80105574:	85 c0                	test   %eax,%eax
80105576:	78 30                	js     801055a8 <sys_fstat+0x48>
80105578:	83 ec 04             	sub    $0x4,%esp
8010557b:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010557e:	6a 14                	push   $0x14
80105580:	50                   	push   %eax
80105581:	6a 01                	push   $0x1
80105583:	e8 38 fb ff ff       	call   801050c0 <argptr>
80105588:	83 c4 10             	add    $0x10,%esp
8010558b:	85 c0                	test   %eax,%eax
8010558d:	78 19                	js     801055a8 <sys_fstat+0x48>
  return filestat(f, st);
8010558f:	83 ec 08             	sub    $0x8,%esp
80105592:	ff 75 f4             	pushl  -0xc(%ebp)
80105595:	ff 75 f0             	pushl  -0x10(%ebp)
80105598:	e8 43 c0 ff ff       	call   801015e0 <filestat>
8010559d:	83 c4 10             	add    $0x10,%esp
}
801055a0:	c9                   	leave  
801055a1:	c3                   	ret    
801055a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801055a8:	c9                   	leave  
    return -1;
801055a9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801055ae:	c3                   	ret    
801055af:	90                   	nop

801055b0 <sys_link>:
{
801055b0:	f3 0f 1e fb          	endbr32 
801055b4:	55                   	push   %ebp
801055b5:	89 e5                	mov    %esp,%ebp
801055b7:	57                   	push   %edi
801055b8:	56                   	push   %esi
  if (argstr(0, &old) < 0 || argstr(1, &new) < 0)
801055b9:	8d 45 d4             	lea    -0x2c(%ebp),%eax
{
801055bc:	53                   	push   %ebx
801055bd:	83 ec 34             	sub    $0x34,%esp
  if (argstr(0, &old) < 0 || argstr(1, &new) < 0)
801055c0:	50                   	push   %eax
801055c1:	6a 00                	push   $0x0
801055c3:	e8 58 fb ff ff       	call   80105120 <argstr>
801055c8:	83 c4 10             	add    $0x10,%esp
801055cb:	85 c0                	test   %eax,%eax
801055cd:	0f 88 ff 00 00 00    	js     801056d2 <sys_link+0x122>
801055d3:	83 ec 08             	sub    $0x8,%esp
801055d6:	8d 45 d0             	lea    -0x30(%ebp),%eax
801055d9:	50                   	push   %eax
801055da:	6a 01                	push   $0x1
801055dc:	e8 3f fb ff ff       	call   80105120 <argstr>
801055e1:	83 c4 10             	add    $0x10,%esp
801055e4:	85 c0                	test   %eax,%eax
801055e6:	0f 88 e6 00 00 00    	js     801056d2 <sys_link+0x122>
  begin_op();
801055ec:	e8 7f dd ff ff       	call   80103370 <begin_op>
  if ((ip = namei(old)) == 0)
801055f1:	83 ec 0c             	sub    $0xc,%esp
801055f4:	ff 75 d4             	pushl  -0x2c(%ebp)
801055f7:	e8 74 d0 ff ff       	call   80102670 <namei>
801055fc:	83 c4 10             	add    $0x10,%esp
801055ff:	89 c3                	mov    %eax,%ebx
80105601:	85 c0                	test   %eax,%eax
80105603:	0f 84 e8 00 00 00    	je     801056f1 <sys_link+0x141>
  ilock(ip);
80105609:	83 ec 0c             	sub    $0xc,%esp
8010560c:	50                   	push   %eax
8010560d:	e8 8e c7 ff ff       	call   80101da0 <ilock>
  if (ip->type == T_DIR)
80105612:	83 c4 10             	add    $0x10,%esp
80105615:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
8010561a:	0f 84 b9 00 00 00    	je     801056d9 <sys_link+0x129>
  iupdate(ip);
80105620:	83 ec 0c             	sub    $0xc,%esp
  ip->nlink++;
80105623:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  if ((dp = nameiparent(new, name)) == 0)
80105628:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
8010562b:	53                   	push   %ebx
8010562c:	e8 af c6 ff ff       	call   80101ce0 <iupdate>
  iunlock(ip);
80105631:	89 1c 24             	mov    %ebx,(%esp)
80105634:	e8 47 c8 ff ff       	call   80101e80 <iunlock>
  if ((dp = nameiparent(new, name)) == 0)
80105639:	58                   	pop    %eax
8010563a:	5a                   	pop    %edx
8010563b:	57                   	push   %edi
8010563c:	ff 75 d0             	pushl  -0x30(%ebp)
8010563f:	e8 4c d0 ff ff       	call   80102690 <nameiparent>
80105644:	83 c4 10             	add    $0x10,%esp
80105647:	89 c6                	mov    %eax,%esi
80105649:	85 c0                	test   %eax,%eax
8010564b:	74 5f                	je     801056ac <sys_link+0xfc>
  ilock(dp);
8010564d:	83 ec 0c             	sub    $0xc,%esp
80105650:	50                   	push   %eax
80105651:	e8 4a c7 ff ff       	call   80101da0 <ilock>
  if (dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0)
80105656:	8b 03                	mov    (%ebx),%eax
80105658:	83 c4 10             	add    $0x10,%esp
8010565b:	39 06                	cmp    %eax,(%esi)
8010565d:	75 41                	jne    801056a0 <sys_link+0xf0>
8010565f:	83 ec 04             	sub    $0x4,%esp
80105662:	ff 73 04             	pushl  0x4(%ebx)
80105665:	57                   	push   %edi
80105666:	56                   	push   %esi
80105667:	e8 44 cf ff ff       	call   801025b0 <dirlink>
8010566c:	83 c4 10             	add    $0x10,%esp
8010566f:	85 c0                	test   %eax,%eax
80105671:	78 2d                	js     801056a0 <sys_link+0xf0>
  iunlockput(dp);
80105673:	83 ec 0c             	sub    $0xc,%esp
80105676:	56                   	push   %esi
80105677:	e8 c4 c9 ff ff       	call   80102040 <iunlockput>
  iput(ip);
8010567c:	89 1c 24             	mov    %ebx,(%esp)
8010567f:	e8 4c c8 ff ff       	call   80101ed0 <iput>
  end_op();
80105684:	e8 57 dd ff ff       	call   801033e0 <end_op>
  return 0;
80105689:	83 c4 10             	add    $0x10,%esp
8010568c:	31 c0                	xor    %eax,%eax
}
8010568e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105691:	5b                   	pop    %ebx
80105692:	5e                   	pop    %esi
80105693:	5f                   	pop    %edi
80105694:	5d                   	pop    %ebp
80105695:	c3                   	ret    
80105696:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010569d:	8d 76 00             	lea    0x0(%esi),%esi
    iunlockput(dp);
801056a0:	83 ec 0c             	sub    $0xc,%esp
801056a3:	56                   	push   %esi
801056a4:	e8 97 c9 ff ff       	call   80102040 <iunlockput>
    goto bad;
801056a9:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
801056ac:	83 ec 0c             	sub    $0xc,%esp
801056af:	53                   	push   %ebx
801056b0:	e8 eb c6 ff ff       	call   80101da0 <ilock>
  ip->nlink--;
801056b5:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
801056ba:	89 1c 24             	mov    %ebx,(%esp)
801056bd:	e8 1e c6 ff ff       	call   80101ce0 <iupdate>
  iunlockput(ip);
801056c2:	89 1c 24             	mov    %ebx,(%esp)
801056c5:	e8 76 c9 ff ff       	call   80102040 <iunlockput>
  end_op();
801056ca:	e8 11 dd ff ff       	call   801033e0 <end_op>
  return -1;
801056cf:	83 c4 10             	add    $0x10,%esp
801056d2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801056d7:	eb b5                	jmp    8010568e <sys_link+0xde>
    iunlockput(ip);
801056d9:	83 ec 0c             	sub    $0xc,%esp
801056dc:	53                   	push   %ebx
801056dd:	e8 5e c9 ff ff       	call   80102040 <iunlockput>
    end_op();
801056e2:	e8 f9 dc ff ff       	call   801033e0 <end_op>
    return -1;
801056e7:	83 c4 10             	add    $0x10,%esp
801056ea:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801056ef:	eb 9d                	jmp    8010568e <sys_link+0xde>
    end_op();
801056f1:	e8 ea dc ff ff       	call   801033e0 <end_op>
    return -1;
801056f6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801056fb:	eb 91                	jmp    8010568e <sys_link+0xde>
801056fd:	8d 76 00             	lea    0x0(%esi),%esi

80105700 <sys_unlink>:
{
80105700:	f3 0f 1e fb          	endbr32 
80105704:	55                   	push   %ebp
80105705:	89 e5                	mov    %esp,%ebp
80105707:	57                   	push   %edi
80105708:	56                   	push   %esi
  if (argstr(0, &path) < 0)
80105709:	8d 45 c0             	lea    -0x40(%ebp),%eax
{
8010570c:	53                   	push   %ebx
8010570d:	83 ec 54             	sub    $0x54,%esp
  if (argstr(0, &path) < 0)
80105710:	50                   	push   %eax
80105711:	6a 00                	push   $0x0
80105713:	e8 08 fa ff ff       	call   80105120 <argstr>
80105718:	83 c4 10             	add    $0x10,%esp
8010571b:	85 c0                	test   %eax,%eax
8010571d:	0f 88 7d 01 00 00    	js     801058a0 <sys_unlink+0x1a0>
  begin_op();
80105723:	e8 48 dc ff ff       	call   80103370 <begin_op>
  if ((dp = nameiparent(path, name)) == 0)
80105728:	8d 5d ca             	lea    -0x36(%ebp),%ebx
8010572b:	83 ec 08             	sub    $0x8,%esp
8010572e:	53                   	push   %ebx
8010572f:	ff 75 c0             	pushl  -0x40(%ebp)
80105732:	e8 59 cf ff ff       	call   80102690 <nameiparent>
80105737:	83 c4 10             	add    $0x10,%esp
8010573a:	89 c6                	mov    %eax,%esi
8010573c:	85 c0                	test   %eax,%eax
8010573e:	0f 84 66 01 00 00    	je     801058aa <sys_unlink+0x1aa>
  ilock(dp);
80105744:	83 ec 0c             	sub    $0xc,%esp
80105747:	50                   	push   %eax
80105748:	e8 53 c6 ff ff       	call   80101da0 <ilock>
  if (namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
8010574d:	58                   	pop    %eax
8010574e:	5a                   	pop    %edx
8010574f:	68 e4 80 10 80       	push   $0x801080e4
80105754:	53                   	push   %ebx
80105755:	e8 76 cb ff ff       	call   801022d0 <namecmp>
8010575a:	83 c4 10             	add    $0x10,%esp
8010575d:	85 c0                	test   %eax,%eax
8010575f:	0f 84 03 01 00 00    	je     80105868 <sys_unlink+0x168>
80105765:	83 ec 08             	sub    $0x8,%esp
80105768:	68 e3 80 10 80       	push   $0x801080e3
8010576d:	53                   	push   %ebx
8010576e:	e8 5d cb ff ff       	call   801022d0 <namecmp>
80105773:	83 c4 10             	add    $0x10,%esp
80105776:	85 c0                	test   %eax,%eax
80105778:	0f 84 ea 00 00 00    	je     80105868 <sys_unlink+0x168>
  if ((ip = dirlookup(dp, name, &off)) == 0)
8010577e:	83 ec 04             	sub    $0x4,%esp
80105781:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80105784:	50                   	push   %eax
80105785:	53                   	push   %ebx
80105786:	56                   	push   %esi
80105787:	e8 64 cb ff ff       	call   801022f0 <dirlookup>
8010578c:	83 c4 10             	add    $0x10,%esp
8010578f:	89 c3                	mov    %eax,%ebx
80105791:	85 c0                	test   %eax,%eax
80105793:	0f 84 cf 00 00 00    	je     80105868 <sys_unlink+0x168>
  ilock(ip);
80105799:	83 ec 0c             	sub    $0xc,%esp
8010579c:	50                   	push   %eax
8010579d:	e8 fe c5 ff ff       	call   80101da0 <ilock>
  if (ip->nlink < 1)
801057a2:	83 c4 10             	add    $0x10,%esp
801057a5:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
801057aa:	0f 8e 23 01 00 00    	jle    801058d3 <sys_unlink+0x1d3>
  if (ip->type == T_DIR && !isdirempty(ip))
801057b0:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801057b5:	8d 7d d8             	lea    -0x28(%ebp),%edi
801057b8:	74 66                	je     80105820 <sys_unlink+0x120>
  memset(&de, 0, sizeof(de));
801057ba:	83 ec 04             	sub    $0x4,%esp
801057bd:	6a 10                	push   $0x10
801057bf:	6a 00                	push   $0x0
801057c1:	57                   	push   %edi
801057c2:	e8 c9 f5 ff ff       	call   80104d90 <memset>
  if (writei(dp, (char *)&de, off, sizeof(de)) != sizeof(de))
801057c7:	6a 10                	push   $0x10
801057c9:	ff 75 c4             	pushl  -0x3c(%ebp)
801057cc:	57                   	push   %edi
801057cd:	56                   	push   %esi
801057ce:	e8 cd c9 ff ff       	call   801021a0 <writei>
801057d3:	83 c4 20             	add    $0x20,%esp
801057d6:	83 f8 10             	cmp    $0x10,%eax
801057d9:	0f 85 e7 00 00 00    	jne    801058c6 <sys_unlink+0x1c6>
  if (ip->type == T_DIR)
801057df:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801057e4:	0f 84 96 00 00 00    	je     80105880 <sys_unlink+0x180>
  iunlockput(dp);
801057ea:	83 ec 0c             	sub    $0xc,%esp
801057ed:	56                   	push   %esi
801057ee:	e8 4d c8 ff ff       	call   80102040 <iunlockput>
  ip->nlink--;
801057f3:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
801057f8:	89 1c 24             	mov    %ebx,(%esp)
801057fb:	e8 e0 c4 ff ff       	call   80101ce0 <iupdate>
  iunlockput(ip);
80105800:	89 1c 24             	mov    %ebx,(%esp)
80105803:	e8 38 c8 ff ff       	call   80102040 <iunlockput>
  end_op();
80105808:	e8 d3 db ff ff       	call   801033e0 <end_op>
  return 0;
8010580d:	83 c4 10             	add    $0x10,%esp
80105810:	31 c0                	xor    %eax,%eax
}
80105812:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105815:	5b                   	pop    %ebx
80105816:	5e                   	pop    %esi
80105817:	5f                   	pop    %edi
80105818:	5d                   	pop    %ebp
80105819:	c3                   	ret    
8010581a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for (off = 2 * sizeof(de); off < dp->size; off += sizeof(de))
80105820:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
80105824:	76 94                	jbe    801057ba <sys_unlink+0xba>
80105826:	ba 20 00 00 00       	mov    $0x20,%edx
8010582b:	eb 0b                	jmp    80105838 <sys_unlink+0x138>
8010582d:	8d 76 00             	lea    0x0(%esi),%esi
80105830:	83 c2 10             	add    $0x10,%edx
80105833:	39 53 58             	cmp    %edx,0x58(%ebx)
80105836:	76 82                	jbe    801057ba <sys_unlink+0xba>
    if (readi(dp, (char *)&de, off, sizeof(de)) != sizeof(de))
80105838:	6a 10                	push   $0x10
8010583a:	52                   	push   %edx
8010583b:	57                   	push   %edi
8010583c:	53                   	push   %ebx
8010583d:	89 55 b4             	mov    %edx,-0x4c(%ebp)
80105840:	e8 5b c8 ff ff       	call   801020a0 <readi>
80105845:	83 c4 10             	add    $0x10,%esp
80105848:	8b 55 b4             	mov    -0x4c(%ebp),%edx
8010584b:	83 f8 10             	cmp    $0x10,%eax
8010584e:	75 69                	jne    801058b9 <sys_unlink+0x1b9>
    if (de.inum != 0)
80105850:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80105855:	74 d9                	je     80105830 <sys_unlink+0x130>
    iunlockput(ip);
80105857:	83 ec 0c             	sub    $0xc,%esp
8010585a:	53                   	push   %ebx
8010585b:	e8 e0 c7 ff ff       	call   80102040 <iunlockput>
    goto bad;
80105860:	83 c4 10             	add    $0x10,%esp
80105863:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105867:	90                   	nop
  iunlockput(dp);
80105868:	83 ec 0c             	sub    $0xc,%esp
8010586b:	56                   	push   %esi
8010586c:	e8 cf c7 ff ff       	call   80102040 <iunlockput>
  end_op();
80105871:	e8 6a db ff ff       	call   801033e0 <end_op>
  return -1;
80105876:	83 c4 10             	add    $0x10,%esp
80105879:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010587e:	eb 92                	jmp    80105812 <sys_unlink+0x112>
    iupdate(dp);
80105880:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink--;
80105883:	66 83 6e 56 01       	subw   $0x1,0x56(%esi)
    iupdate(dp);
80105888:	56                   	push   %esi
80105889:	e8 52 c4 ff ff       	call   80101ce0 <iupdate>
8010588e:	83 c4 10             	add    $0x10,%esp
80105891:	e9 54 ff ff ff       	jmp    801057ea <sys_unlink+0xea>
80105896:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010589d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
801058a0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801058a5:	e9 68 ff ff ff       	jmp    80105812 <sys_unlink+0x112>
    end_op();
801058aa:	e8 31 db ff ff       	call   801033e0 <end_op>
    return -1;
801058af:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801058b4:	e9 59 ff ff ff       	jmp    80105812 <sys_unlink+0x112>
      panic("isdirempty: readi");
801058b9:	83 ec 0c             	sub    $0xc,%esp
801058bc:	68 08 81 10 80       	push   $0x80108108
801058c1:	e8 ea aa ff ff       	call   801003b0 <panic>
    panic("unlink: writei");
801058c6:	83 ec 0c             	sub    $0xc,%esp
801058c9:	68 1a 81 10 80       	push   $0x8010811a
801058ce:	e8 dd aa ff ff       	call   801003b0 <panic>
    panic("unlink: nlink < 1");
801058d3:	83 ec 0c             	sub    $0xc,%esp
801058d6:	68 f6 80 10 80       	push   $0x801080f6
801058db:	e8 d0 aa ff ff       	call   801003b0 <panic>

801058e0 <sys_copy_file>:

// copy src to dest
// return 0 on success and -1 on error
int sys_copy_file(void)
{
801058e0:	f3 0f 1e fb          	endbr32 
801058e4:	55                   	push   %ebp
801058e5:	89 e5                	mov    %esp,%ebp
801058e7:	83 ec 20             	sub    $0x20,%esp
  char *src, *dest;
  if (argstr(0, &src) < 0)
801058ea:	8d 45 f0             	lea    -0x10(%ebp),%eax
801058ed:	50                   	push   %eax
801058ee:	6a 00                	push   $0x0
801058f0:	e8 2b f8 ff ff       	call   80105120 <argstr>
801058f5:	83 c4 10             	add    $0x10,%esp
801058f8:	85 c0                	test   %eax,%eax
801058fa:	78 1c                	js     80105918 <sys_copy_file+0x38>
    return -1;
  if (argstr(1, &dest) < 0)
801058fc:	83 ec 08             	sub    $0x8,%esp
801058ff:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105902:	50                   	push   %eax
80105903:	6a 01                	push   $0x1
80105905:	e8 16 f8 ff ff       	call   80105120 <argstr>
8010590a:	83 c4 10             	add    $0x10,%esp
    return -1;
  return 0;
}
8010590d:	c9                   	leave  
  if (argstr(1, &dest) < 0)
8010590e:	c1 f8 1f             	sar    $0x1f,%eax
}
80105911:	c3                   	ret    
80105912:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105918:	c9                   	leave  
    return -1;
80105919:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010591e:	c3                   	ret    
8010591f:	90                   	nop

80105920 <sys_open>:

int sys_open(void)
{
80105920:	f3 0f 1e fb          	endbr32 
80105924:	55                   	push   %ebp
80105925:	89 e5                	mov    %esp,%ebp
80105927:	57                   	push   %edi
80105928:	56                   	push   %esi
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if (argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105929:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
8010592c:	53                   	push   %ebx
8010592d:	83 ec 24             	sub    $0x24,%esp
  if (argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105930:	50                   	push   %eax
80105931:	6a 00                	push   $0x0
80105933:	e8 e8 f7 ff ff       	call   80105120 <argstr>
80105938:	83 c4 10             	add    $0x10,%esp
8010593b:	85 c0                	test   %eax,%eax
8010593d:	0f 88 8a 00 00 00    	js     801059cd <sys_open+0xad>
80105943:	83 ec 08             	sub    $0x8,%esp
80105946:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105949:	50                   	push   %eax
8010594a:	6a 01                	push   $0x1
8010594c:	e8 1f f7 ff ff       	call   80105070 <argint>
80105951:	83 c4 10             	add    $0x10,%esp
80105954:	85 c0                	test   %eax,%eax
80105956:	78 75                	js     801059cd <sys_open+0xad>
    return -1;

  begin_op();
80105958:	e8 13 da ff ff       	call   80103370 <begin_op>

  if (omode & O_CREATE)
8010595d:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
80105961:	75 75                	jne    801059d8 <sys_open+0xb8>
      return -1;
    }
  }
  else
  {
    if ((ip = namei(path)) == 0)
80105963:	83 ec 0c             	sub    $0xc,%esp
80105966:	ff 75 e0             	pushl  -0x20(%ebp)
80105969:	e8 02 cd ff ff       	call   80102670 <namei>
8010596e:	83 c4 10             	add    $0x10,%esp
80105971:	89 c6                	mov    %eax,%esi
80105973:	85 c0                	test   %eax,%eax
80105975:	74 7e                	je     801059f5 <sys_open+0xd5>
    {
      end_op();
      return -1;
    }
    ilock(ip);
80105977:	83 ec 0c             	sub    $0xc,%esp
8010597a:	50                   	push   %eax
8010597b:	e8 20 c4 ff ff       	call   80101da0 <ilock>
    if (ip->type == T_DIR && omode != O_RDONLY)
80105980:	83 c4 10             	add    $0x10,%esp
80105983:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80105988:	0f 84 c2 00 00 00    	je     80105a50 <sys_open+0x130>
      end_op();
      return -1;
    }
  }

  if ((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0)
8010598e:	e8 ad ba ff ff       	call   80101440 <filealloc>
80105993:	89 c7                	mov    %eax,%edi
80105995:	85 c0                	test   %eax,%eax
80105997:	74 23                	je     801059bc <sys_open+0x9c>
  struct proc *curproc = myproc();
80105999:	e8 02 e6 ff ff       	call   80103fa0 <myproc>
  for (fd = 0; fd < NOFILE; fd++)
8010599e:	31 db                	xor    %ebx,%ebx
    if (curproc->ofile[fd] == 0)
801059a0:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
801059a4:	85 d2                	test   %edx,%edx
801059a6:	74 60                	je     80105a08 <sys_open+0xe8>
  for (fd = 0; fd < NOFILE; fd++)
801059a8:	83 c3 01             	add    $0x1,%ebx
801059ab:	83 fb 10             	cmp    $0x10,%ebx
801059ae:	75 f0                	jne    801059a0 <sys_open+0x80>
  {
    if (f)
      fileclose(f);
801059b0:	83 ec 0c             	sub    $0xc,%esp
801059b3:	57                   	push   %edi
801059b4:	e8 47 bb ff ff       	call   80101500 <fileclose>
801059b9:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
801059bc:	83 ec 0c             	sub    $0xc,%esp
801059bf:	56                   	push   %esi
801059c0:	e8 7b c6 ff ff       	call   80102040 <iunlockput>
    end_op();
801059c5:	e8 16 da ff ff       	call   801033e0 <end_op>
    return -1;
801059ca:	83 c4 10             	add    $0x10,%esp
801059cd:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801059d2:	eb 6d                	jmp    80105a41 <sys_open+0x121>
801059d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ip = create(path, T_FILE, 0, 0);
801059d8:	83 ec 0c             	sub    $0xc,%esp
801059db:	8b 45 e0             	mov    -0x20(%ebp),%eax
801059de:	31 c9                	xor    %ecx,%ecx
801059e0:	ba 02 00 00 00       	mov    $0x2,%edx
801059e5:	6a 00                	push   $0x0
801059e7:	e8 e4 f7 ff ff       	call   801051d0 <create>
    if (ip == 0)
801059ec:	83 c4 10             	add    $0x10,%esp
    ip = create(path, T_FILE, 0, 0);
801059ef:	89 c6                	mov    %eax,%esi
    if (ip == 0)
801059f1:	85 c0                	test   %eax,%eax
801059f3:	75 99                	jne    8010598e <sys_open+0x6e>
      end_op();
801059f5:	e8 e6 d9 ff ff       	call   801033e0 <end_op>
      return -1;
801059fa:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801059ff:	eb 40                	jmp    80105a41 <sys_open+0x121>
80105a01:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  }
  iunlock(ip);
80105a08:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
80105a0b:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
  iunlock(ip);
80105a0f:	56                   	push   %esi
80105a10:	e8 6b c4 ff ff       	call   80101e80 <iunlock>
  end_op();
80105a15:	e8 c6 d9 ff ff       	call   801033e0 <end_op>

  f->type = FD_INODE;
80105a1a:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
80105a20:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105a23:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
80105a26:	89 77 10             	mov    %esi,0x10(%edi)
  f->readable = !(omode & O_WRONLY);
80105a29:	89 d0                	mov    %edx,%eax
  f->off = 0;
80105a2b:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
80105a32:	f7 d0                	not    %eax
80105a34:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105a37:	83 e2 03             	and    $0x3,%edx
  f->readable = !(omode & O_WRONLY);
80105a3a:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105a3d:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
}
80105a41:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105a44:	89 d8                	mov    %ebx,%eax
80105a46:	5b                   	pop    %ebx
80105a47:	5e                   	pop    %esi
80105a48:	5f                   	pop    %edi
80105a49:	5d                   	pop    %ebp
80105a4a:	c3                   	ret    
80105a4b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105a4f:	90                   	nop
    if (ip->type == T_DIR && omode != O_RDONLY)
80105a50:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80105a53:	85 c9                	test   %ecx,%ecx
80105a55:	0f 84 33 ff ff ff    	je     8010598e <sys_open+0x6e>
80105a5b:	e9 5c ff ff ff       	jmp    801059bc <sys_open+0x9c>

80105a60 <sys_mkdir>:

int sys_mkdir(void)
{
80105a60:	f3 0f 1e fb          	endbr32 
80105a64:	55                   	push   %ebp
80105a65:	89 e5                	mov    %esp,%ebp
80105a67:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
80105a6a:	e8 01 d9 ff ff       	call   80103370 <begin_op>
  if (argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0)
80105a6f:	83 ec 08             	sub    $0x8,%esp
80105a72:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105a75:	50                   	push   %eax
80105a76:	6a 00                	push   $0x0
80105a78:	e8 a3 f6 ff ff       	call   80105120 <argstr>
80105a7d:	83 c4 10             	add    $0x10,%esp
80105a80:	85 c0                	test   %eax,%eax
80105a82:	78 34                	js     80105ab8 <sys_mkdir+0x58>
80105a84:	83 ec 0c             	sub    $0xc,%esp
80105a87:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105a8a:	31 c9                	xor    %ecx,%ecx
80105a8c:	ba 01 00 00 00       	mov    $0x1,%edx
80105a91:	6a 00                	push   $0x0
80105a93:	e8 38 f7 ff ff       	call   801051d0 <create>
80105a98:	83 c4 10             	add    $0x10,%esp
80105a9b:	85 c0                	test   %eax,%eax
80105a9d:	74 19                	je     80105ab8 <sys_mkdir+0x58>
  {
    end_op();
    return -1;
  }
  iunlockput(ip);
80105a9f:	83 ec 0c             	sub    $0xc,%esp
80105aa2:	50                   	push   %eax
80105aa3:	e8 98 c5 ff ff       	call   80102040 <iunlockput>
  end_op();
80105aa8:	e8 33 d9 ff ff       	call   801033e0 <end_op>
  return 0;
80105aad:	83 c4 10             	add    $0x10,%esp
80105ab0:	31 c0                	xor    %eax,%eax
}
80105ab2:	c9                   	leave  
80105ab3:	c3                   	ret    
80105ab4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    end_op();
80105ab8:	e8 23 d9 ff ff       	call   801033e0 <end_op>
    return -1;
80105abd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105ac2:	c9                   	leave  
80105ac3:	c3                   	ret    
80105ac4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105acb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105acf:	90                   	nop

80105ad0 <sys_mknod>:

int sys_mknod(void)
{
80105ad0:	f3 0f 1e fb          	endbr32 
80105ad4:	55                   	push   %ebp
80105ad5:	89 e5                	mov    %esp,%ebp
80105ad7:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80105ada:	e8 91 d8 ff ff       	call   80103370 <begin_op>
  if ((argstr(0, &path)) < 0 ||
80105adf:	83 ec 08             	sub    $0x8,%esp
80105ae2:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105ae5:	50                   	push   %eax
80105ae6:	6a 00                	push   $0x0
80105ae8:	e8 33 f6 ff ff       	call   80105120 <argstr>
80105aed:	83 c4 10             	add    $0x10,%esp
80105af0:	85 c0                	test   %eax,%eax
80105af2:	78 64                	js     80105b58 <sys_mknod+0x88>
      argint(1, &major) < 0 ||
80105af4:	83 ec 08             	sub    $0x8,%esp
80105af7:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105afa:	50                   	push   %eax
80105afb:	6a 01                	push   $0x1
80105afd:	e8 6e f5 ff ff       	call   80105070 <argint>
  if ((argstr(0, &path)) < 0 ||
80105b02:	83 c4 10             	add    $0x10,%esp
80105b05:	85 c0                	test   %eax,%eax
80105b07:	78 4f                	js     80105b58 <sys_mknod+0x88>
      argint(2, &minor) < 0 ||
80105b09:	83 ec 08             	sub    $0x8,%esp
80105b0c:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105b0f:	50                   	push   %eax
80105b10:	6a 02                	push   $0x2
80105b12:	e8 59 f5 ff ff       	call   80105070 <argint>
      argint(1, &major) < 0 ||
80105b17:	83 c4 10             	add    $0x10,%esp
80105b1a:	85 c0                	test   %eax,%eax
80105b1c:	78 3a                	js     80105b58 <sys_mknod+0x88>
      (ip = create(path, T_DEV, major, minor)) == 0)
80105b1e:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
80105b22:	83 ec 0c             	sub    $0xc,%esp
80105b25:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
80105b29:	ba 03 00 00 00       	mov    $0x3,%edx
80105b2e:	50                   	push   %eax
80105b2f:	8b 45 ec             	mov    -0x14(%ebp),%eax
80105b32:	e8 99 f6 ff ff       	call   801051d0 <create>
      argint(2, &minor) < 0 ||
80105b37:	83 c4 10             	add    $0x10,%esp
80105b3a:	85 c0                	test   %eax,%eax
80105b3c:	74 1a                	je     80105b58 <sys_mknod+0x88>
  {
    end_op();
    return -1;
  }
  iunlockput(ip);
80105b3e:	83 ec 0c             	sub    $0xc,%esp
80105b41:	50                   	push   %eax
80105b42:	e8 f9 c4 ff ff       	call   80102040 <iunlockput>
  end_op();
80105b47:	e8 94 d8 ff ff       	call   801033e0 <end_op>
  return 0;
80105b4c:	83 c4 10             	add    $0x10,%esp
80105b4f:	31 c0                	xor    %eax,%eax
}
80105b51:	c9                   	leave  
80105b52:	c3                   	ret    
80105b53:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105b57:	90                   	nop
    end_op();
80105b58:	e8 83 d8 ff ff       	call   801033e0 <end_op>
    return -1;
80105b5d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105b62:	c9                   	leave  
80105b63:	c3                   	ret    
80105b64:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105b6b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105b6f:	90                   	nop

80105b70 <sys_chdir>:

int sys_chdir(void)
{
80105b70:	f3 0f 1e fb          	endbr32 
80105b74:	55                   	push   %ebp
80105b75:	89 e5                	mov    %esp,%ebp
80105b77:	56                   	push   %esi
80105b78:	53                   	push   %ebx
80105b79:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
80105b7c:	e8 1f e4 ff ff       	call   80103fa0 <myproc>
80105b81:	89 c6                	mov    %eax,%esi

  begin_op();
80105b83:	e8 e8 d7 ff ff       	call   80103370 <begin_op>
  if (argstr(0, &path) < 0 || (ip = namei(path)) == 0)
80105b88:	83 ec 08             	sub    $0x8,%esp
80105b8b:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105b8e:	50                   	push   %eax
80105b8f:	6a 00                	push   $0x0
80105b91:	e8 8a f5 ff ff       	call   80105120 <argstr>
80105b96:	83 c4 10             	add    $0x10,%esp
80105b99:	85 c0                	test   %eax,%eax
80105b9b:	78 73                	js     80105c10 <sys_chdir+0xa0>
80105b9d:	83 ec 0c             	sub    $0xc,%esp
80105ba0:	ff 75 f4             	pushl  -0xc(%ebp)
80105ba3:	e8 c8 ca ff ff       	call   80102670 <namei>
80105ba8:	83 c4 10             	add    $0x10,%esp
80105bab:	89 c3                	mov    %eax,%ebx
80105bad:	85 c0                	test   %eax,%eax
80105baf:	74 5f                	je     80105c10 <sys_chdir+0xa0>
  {
    end_op();
    return -1;
  }
  ilock(ip);
80105bb1:	83 ec 0c             	sub    $0xc,%esp
80105bb4:	50                   	push   %eax
80105bb5:	e8 e6 c1 ff ff       	call   80101da0 <ilock>
  if (ip->type != T_DIR)
80105bba:	83 c4 10             	add    $0x10,%esp
80105bbd:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105bc2:	75 2c                	jne    80105bf0 <sys_chdir+0x80>
  {
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105bc4:	83 ec 0c             	sub    $0xc,%esp
80105bc7:	53                   	push   %ebx
80105bc8:	e8 b3 c2 ff ff       	call   80101e80 <iunlock>
  iput(curproc->cwd);
80105bcd:	58                   	pop    %eax
80105bce:	ff 76 68             	pushl  0x68(%esi)
80105bd1:	e8 fa c2 ff ff       	call   80101ed0 <iput>
  end_op();
80105bd6:	e8 05 d8 ff ff       	call   801033e0 <end_op>
  curproc->cwd = ip;
80105bdb:	89 5e 68             	mov    %ebx,0x68(%esi)
  return 0;
80105bde:	83 c4 10             	add    $0x10,%esp
80105be1:	31 c0                	xor    %eax,%eax
}
80105be3:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105be6:	5b                   	pop    %ebx
80105be7:	5e                   	pop    %esi
80105be8:	5d                   	pop    %ebp
80105be9:	c3                   	ret    
80105bea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(ip);
80105bf0:	83 ec 0c             	sub    $0xc,%esp
80105bf3:	53                   	push   %ebx
80105bf4:	e8 47 c4 ff ff       	call   80102040 <iunlockput>
    end_op();
80105bf9:	e8 e2 d7 ff ff       	call   801033e0 <end_op>
    return -1;
80105bfe:	83 c4 10             	add    $0x10,%esp
80105c01:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105c06:	eb db                	jmp    80105be3 <sys_chdir+0x73>
80105c08:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105c0f:	90                   	nop
    end_op();
80105c10:	e8 cb d7 ff ff       	call   801033e0 <end_op>
    return -1;
80105c15:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105c1a:	eb c7                	jmp    80105be3 <sys_chdir+0x73>
80105c1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105c20 <sys_exec>:

int sys_exec(void)
{
80105c20:	f3 0f 1e fb          	endbr32 
80105c24:	55                   	push   %ebp
80105c25:	89 e5                	mov    %esp,%ebp
80105c27:	57                   	push   %edi
80105c28:	56                   	push   %esi
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if (argstr(0, &path) < 0 || argint(1, (int *)&uargv) < 0)
80105c29:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
{
80105c2f:	53                   	push   %ebx
80105c30:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  if (argstr(0, &path) < 0 || argint(1, (int *)&uargv) < 0)
80105c36:	50                   	push   %eax
80105c37:	6a 00                	push   $0x0
80105c39:	e8 e2 f4 ff ff       	call   80105120 <argstr>
80105c3e:	83 c4 10             	add    $0x10,%esp
80105c41:	85 c0                	test   %eax,%eax
80105c43:	0f 88 8b 00 00 00    	js     80105cd4 <sys_exec+0xb4>
80105c49:	83 ec 08             	sub    $0x8,%esp
80105c4c:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
80105c52:	50                   	push   %eax
80105c53:	6a 01                	push   $0x1
80105c55:	e8 16 f4 ff ff       	call   80105070 <argint>
80105c5a:	83 c4 10             	add    $0x10,%esp
80105c5d:	85 c0                	test   %eax,%eax
80105c5f:	78 73                	js     80105cd4 <sys_exec+0xb4>
  {
    return -1;
  }
  memset(argv, 0, sizeof(argv));
80105c61:	83 ec 04             	sub    $0x4,%esp
80105c64:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
  for (i = 0;; i++)
80105c6a:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
80105c6c:	68 80 00 00 00       	push   $0x80
80105c71:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
80105c77:	6a 00                	push   $0x0
80105c79:	50                   	push   %eax
80105c7a:	e8 11 f1 ff ff       	call   80104d90 <memset>
80105c7f:	83 c4 10             	add    $0x10,%esp
80105c82:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  {
    if (i >= NELEM(argv))
      return -1;
    if (fetchint(uargv + 4 * i, (int *)&uarg) < 0)
80105c88:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
80105c8e:	8d 34 9d 00 00 00 00 	lea    0x0(,%ebx,4),%esi
80105c95:	83 ec 08             	sub    $0x8,%esp
80105c98:	57                   	push   %edi
80105c99:	01 f0                	add    %esi,%eax
80105c9b:	50                   	push   %eax
80105c9c:	e8 2f f3 ff ff       	call   80104fd0 <fetchint>
80105ca1:	83 c4 10             	add    $0x10,%esp
80105ca4:	85 c0                	test   %eax,%eax
80105ca6:	78 2c                	js     80105cd4 <sys_exec+0xb4>
      return -1;
    if (uarg == 0)
80105ca8:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80105cae:	85 c0                	test   %eax,%eax
80105cb0:	74 36                	je     80105ce8 <sys_exec+0xc8>
    {
      argv[i] = 0;
      break;
    }
    if (fetchstr(uarg, &argv[i]) < 0)
80105cb2:	8d 8d 68 ff ff ff    	lea    -0x98(%ebp),%ecx
80105cb8:	83 ec 08             	sub    $0x8,%esp
80105cbb:	8d 14 31             	lea    (%ecx,%esi,1),%edx
80105cbe:	52                   	push   %edx
80105cbf:	50                   	push   %eax
80105cc0:	e8 4b f3 ff ff       	call   80105010 <fetchstr>
80105cc5:	83 c4 10             	add    $0x10,%esp
80105cc8:	85 c0                	test   %eax,%eax
80105cca:	78 08                	js     80105cd4 <sys_exec+0xb4>
  for (i = 0;; i++)
80105ccc:	83 c3 01             	add    $0x1,%ebx
    if (i >= NELEM(argv))
80105ccf:	83 fb 20             	cmp    $0x20,%ebx
80105cd2:	75 b4                	jne    80105c88 <sys_exec+0x68>
      return -1;
  }
  return exec(path, argv);
}
80105cd4:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
80105cd7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105cdc:	5b                   	pop    %ebx
80105cdd:	5e                   	pop    %esi
80105cde:	5f                   	pop    %edi
80105cdf:	5d                   	pop    %ebp
80105ce0:	c3                   	ret    
80105ce1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return exec(path, argv);
80105ce8:	83 ec 08             	sub    $0x8,%esp
80105ceb:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
      argv[i] = 0;
80105cf1:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
80105cf8:	00 00 00 00 
  return exec(path, argv);
80105cfc:	50                   	push   %eax
80105cfd:	ff b5 5c ff ff ff    	pushl  -0xa4(%ebp)
80105d03:	e8 b8 b3 ff ff       	call   801010c0 <exec>
80105d08:	83 c4 10             	add    $0x10,%esp
}
80105d0b:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105d0e:	5b                   	pop    %ebx
80105d0f:	5e                   	pop    %esi
80105d10:	5f                   	pop    %edi
80105d11:	5d                   	pop    %ebp
80105d12:	c3                   	ret    
80105d13:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105d1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105d20 <sys_pipe>:

int sys_pipe(void)
{
80105d20:	f3 0f 1e fb          	endbr32 
80105d24:	55                   	push   %ebp
80105d25:	89 e5                	mov    %esp,%ebp
80105d27:	57                   	push   %edi
80105d28:	56                   	push   %esi
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if (argptr(0, (void *)&fd, 2 * sizeof(fd[0])) < 0)
80105d29:	8d 45 dc             	lea    -0x24(%ebp),%eax
{
80105d2c:	53                   	push   %ebx
80105d2d:	83 ec 20             	sub    $0x20,%esp
  if (argptr(0, (void *)&fd, 2 * sizeof(fd[0])) < 0)
80105d30:	6a 08                	push   $0x8
80105d32:	50                   	push   %eax
80105d33:	6a 00                	push   $0x0
80105d35:	e8 86 f3 ff ff       	call   801050c0 <argptr>
80105d3a:	83 c4 10             	add    $0x10,%esp
80105d3d:	85 c0                	test   %eax,%eax
80105d3f:	78 4e                	js     80105d8f <sys_pipe+0x6f>
    return -1;
  if (pipealloc(&rf, &wf) < 0)
80105d41:	83 ec 08             	sub    $0x8,%esp
80105d44:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105d47:	50                   	push   %eax
80105d48:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105d4b:	50                   	push   %eax
80105d4c:	e8 df dc ff ff       	call   80103a30 <pipealloc>
80105d51:	83 c4 10             	add    $0x10,%esp
80105d54:	85 c0                	test   %eax,%eax
80105d56:	78 37                	js     80105d8f <sys_pipe+0x6f>
    return -1;
  fd0 = -1;
  if ((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0)
80105d58:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for (fd = 0; fd < NOFILE; fd++)
80105d5b:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
80105d5d:	e8 3e e2 ff ff       	call   80103fa0 <myproc>
  for (fd = 0; fd < NOFILE; fd++)
80105d62:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if (curproc->ofile[fd] == 0)
80105d68:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
80105d6c:	85 f6                	test   %esi,%esi
80105d6e:	74 30                	je     80105da0 <sys_pipe+0x80>
  for (fd = 0; fd < NOFILE; fd++)
80105d70:	83 c3 01             	add    $0x1,%ebx
80105d73:	83 fb 10             	cmp    $0x10,%ebx
80105d76:	75 f0                	jne    80105d68 <sys_pipe+0x48>
  {
    if (fd0 >= 0)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
80105d78:	83 ec 0c             	sub    $0xc,%esp
80105d7b:	ff 75 e0             	pushl  -0x20(%ebp)
80105d7e:	e8 7d b7 ff ff       	call   80101500 <fileclose>
    fileclose(wf);
80105d83:	58                   	pop    %eax
80105d84:	ff 75 e4             	pushl  -0x1c(%ebp)
80105d87:	e8 74 b7 ff ff       	call   80101500 <fileclose>
    return -1;
80105d8c:	83 c4 10             	add    $0x10,%esp
80105d8f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105d94:	eb 5b                	jmp    80105df1 <sys_pipe+0xd1>
80105d96:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105d9d:	8d 76 00             	lea    0x0(%esi),%esi
      curproc->ofile[fd] = f;
80105da0:	8d 73 08             	lea    0x8(%ebx),%esi
80105da3:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if ((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0)
80105da7:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  struct proc *curproc = myproc();
80105daa:	e8 f1 e1 ff ff       	call   80103fa0 <myproc>
  for (fd = 0; fd < NOFILE; fd++)
80105daf:	31 d2                	xor    %edx,%edx
80105db1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if (curproc->ofile[fd] == 0)
80105db8:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
80105dbc:	85 c9                	test   %ecx,%ecx
80105dbe:	74 20                	je     80105de0 <sys_pipe+0xc0>
  for (fd = 0; fd < NOFILE; fd++)
80105dc0:	83 c2 01             	add    $0x1,%edx
80105dc3:	83 fa 10             	cmp    $0x10,%edx
80105dc6:	75 f0                	jne    80105db8 <sys_pipe+0x98>
      myproc()->ofile[fd0] = 0;
80105dc8:	e8 d3 e1 ff ff       	call   80103fa0 <myproc>
80105dcd:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
80105dd4:	00 
80105dd5:	eb a1                	jmp    80105d78 <sys_pipe+0x58>
80105dd7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105dde:	66 90                	xchg   %ax,%ax
      curproc->ofile[fd] = f;
80105de0:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
  }
  fd[0] = fd0;
80105de4:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105de7:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
80105de9:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105dec:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
80105def:	31 c0                	xor    %eax,%eax
}
80105df1:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105df4:	5b                   	pop    %ebx
80105df5:	5e                   	pop    %esi
80105df6:	5f                   	pop    %edi
80105df7:	5d                   	pop    %ebp
80105df8:	c3                   	ret    
80105df9:	66 90                	xchg   %ax,%ax
80105dfb:	66 90                	xchg   %ax,%ax
80105dfd:	66 90                	xchg   %ax,%ax
80105dff:	90                   	nop

80105e00 <sys_fork>:
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"

int sys_fork(void)
{
80105e00:	f3 0f 1e fb          	endbr32 
	return fork();
80105e04:	e9 47 e3 ff ff       	jmp    80104150 <fork>
80105e09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105e10 <sys_exit>:
}

int sys_exit(void)
{
80105e10:	f3 0f 1e fb          	endbr32 
80105e14:	55                   	push   %ebp
80105e15:	89 e5                	mov    %esp,%ebp
80105e17:	83 ec 08             	sub    $0x8,%esp
	exit();
80105e1a:	e8 e1 e5 ff ff       	call   80104400 <exit>
	return 0; // not reached
}
80105e1f:	31 c0                	xor    %eax,%eax
80105e21:	c9                   	leave  
80105e22:	c3                   	ret    
80105e23:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105e2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105e30 <sys_wait>:

int sys_wait(void)
{
80105e30:	f3 0f 1e fb          	endbr32 
	return wait();
80105e34:	e9 17 e8 ff ff       	jmp    80104650 <wait>
80105e39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105e40 <sys_kill>:
}

int sys_kill(void)
{
80105e40:	f3 0f 1e fb          	endbr32 
80105e44:	55                   	push   %ebp
80105e45:	89 e5                	mov    %esp,%ebp
80105e47:	83 ec 20             	sub    $0x20,%esp
	int pid;

	if (argint(0, &pid) < 0)
80105e4a:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105e4d:	50                   	push   %eax
80105e4e:	6a 00                	push   $0x0
80105e50:	e8 1b f2 ff ff       	call   80105070 <argint>
80105e55:	83 c4 10             	add    $0x10,%esp
80105e58:	85 c0                	test   %eax,%eax
80105e5a:	78 14                	js     80105e70 <sys_kill+0x30>
		return -1;
	return kill(pid);
80105e5c:	83 ec 0c             	sub    $0xc,%esp
80105e5f:	ff 75 f4             	pushl  -0xc(%ebp)
80105e62:	e8 49 e9 ff ff       	call   801047b0 <kill>
80105e67:	83 c4 10             	add    $0x10,%esp
}
80105e6a:	c9                   	leave  
80105e6b:	c3                   	ret    
80105e6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105e70:	c9                   	leave  
		return -1;
80105e71:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105e76:	c3                   	ret    
80105e77:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105e7e:	66 90                	xchg   %ax,%ax

80105e80 <sys_getpid>:

int sys_getpid(void)
{
80105e80:	f3 0f 1e fb          	endbr32 
80105e84:	55                   	push   %ebp
80105e85:	89 e5                	mov    %esp,%ebp
80105e87:	83 ec 08             	sub    $0x8,%esp
	return myproc()->pid;
80105e8a:	e8 11 e1 ff ff       	call   80103fa0 <myproc>
80105e8f:	8b 40 10             	mov    0x10(%eax),%eax
}
80105e92:	c9                   	leave  
80105e93:	c3                   	ret    
80105e94:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105e9b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105e9f:	90                   	nop

80105ea0 <sys_sbrk>:

int sys_sbrk(void)
{
80105ea0:	f3 0f 1e fb          	endbr32 
80105ea4:	55                   	push   %ebp
80105ea5:	89 e5                	mov    %esp,%ebp
80105ea7:	53                   	push   %ebx
	int addr;
	int n;

	if (argint(0, &n) < 0)
80105ea8:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105eab:	83 ec 1c             	sub    $0x1c,%esp
	if (argint(0, &n) < 0)
80105eae:	50                   	push   %eax
80105eaf:	6a 00                	push   $0x0
80105eb1:	e8 ba f1 ff ff       	call   80105070 <argint>
80105eb6:	83 c4 10             	add    $0x10,%esp
80105eb9:	85 c0                	test   %eax,%eax
80105ebb:	78 23                	js     80105ee0 <sys_sbrk+0x40>
		return -1;
	addr = myproc()->sz;
80105ebd:	e8 de e0 ff ff       	call   80103fa0 <myproc>
	if (growproc(n) < 0)
80105ec2:	83 ec 0c             	sub    $0xc,%esp
	addr = myproc()->sz;
80105ec5:	8b 18                	mov    (%eax),%ebx
	if (growproc(n) < 0)
80105ec7:	ff 75 f4             	pushl  -0xc(%ebp)
80105eca:	e8 01 e2 ff ff       	call   801040d0 <growproc>
80105ecf:	83 c4 10             	add    $0x10,%esp
80105ed2:	85 c0                	test   %eax,%eax
80105ed4:	78 0a                	js     80105ee0 <sys_sbrk+0x40>
		return -1;
	return addr;
}
80105ed6:	89 d8                	mov    %ebx,%eax
80105ed8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105edb:	c9                   	leave  
80105edc:	c3                   	ret    
80105edd:	8d 76 00             	lea    0x0(%esi),%esi
		return -1;
80105ee0:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105ee5:	eb ef                	jmp    80105ed6 <sys_sbrk+0x36>
80105ee7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105eee:	66 90                	xchg   %ax,%ax

80105ef0 <sys_sleep>:

int sys_sleep(void)
{
80105ef0:	f3 0f 1e fb          	endbr32 
80105ef4:	55                   	push   %ebp
80105ef5:	89 e5                	mov    %esp,%ebp
80105ef7:	53                   	push   %ebx
	int n;
	uint ticks0;

	if (argint(0, &n) < 0)
80105ef8:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105efb:	83 ec 1c             	sub    $0x1c,%esp
	if (argint(0, &n) < 0)
80105efe:	50                   	push   %eax
80105eff:	6a 00                	push   $0x0
80105f01:	e8 6a f1 ff ff       	call   80105070 <argint>
80105f06:	83 c4 10             	add    $0x10,%esp
80105f09:	85 c0                	test   %eax,%eax
80105f0b:	0f 88 86 00 00 00    	js     80105f97 <sys_sleep+0xa7>
		return -1;
	acquire(&tickslock);
80105f11:	83 ec 0c             	sub    $0xc,%esp
80105f14:	68 a0 69 11 80       	push   $0x801169a0
80105f19:	e8 62 ed ff ff       	call   80104c80 <acquire>
	ticks0 = ticks;
	while (ticks - ticks0 < n)
80105f1e:	8b 55 f4             	mov    -0xc(%ebp),%edx
	ticks0 = ticks;
80105f21:	8b 1d e0 71 11 80    	mov    0x801171e0,%ebx
	while (ticks - ticks0 < n)
80105f27:	83 c4 10             	add    $0x10,%esp
80105f2a:	85 d2                	test   %edx,%edx
80105f2c:	75 23                	jne    80105f51 <sys_sleep+0x61>
80105f2e:	eb 50                	jmp    80105f80 <sys_sleep+0x90>
		if (myproc()->killed)
		{
			release(&tickslock);
			return -1;
		}
		sleep(&ticks, &tickslock);
80105f30:	83 ec 08             	sub    $0x8,%esp
80105f33:	68 a0 69 11 80       	push   $0x801169a0
80105f38:	68 e0 71 11 80       	push   $0x801171e0
80105f3d:	e8 4e e6 ff ff       	call   80104590 <sleep>
	while (ticks - ticks0 < n)
80105f42:	a1 e0 71 11 80       	mov    0x801171e0,%eax
80105f47:	83 c4 10             	add    $0x10,%esp
80105f4a:	29 d8                	sub    %ebx,%eax
80105f4c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80105f4f:	73 2f                	jae    80105f80 <sys_sleep+0x90>
		if (myproc()->killed)
80105f51:	e8 4a e0 ff ff       	call   80103fa0 <myproc>
80105f56:	8b 40 24             	mov    0x24(%eax),%eax
80105f59:	85 c0                	test   %eax,%eax
80105f5b:	74 d3                	je     80105f30 <sys_sleep+0x40>
			release(&tickslock);
80105f5d:	83 ec 0c             	sub    $0xc,%esp
80105f60:	68 a0 69 11 80       	push   $0x801169a0
80105f65:	e8 d6 ed ff ff       	call   80104d40 <release>
	}
	release(&tickslock);
	return 0;
}
80105f6a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
			return -1;
80105f6d:	83 c4 10             	add    $0x10,%esp
80105f70:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105f75:	c9                   	leave  
80105f76:	c3                   	ret    
80105f77:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105f7e:	66 90                	xchg   %ax,%ax
	release(&tickslock);
80105f80:	83 ec 0c             	sub    $0xc,%esp
80105f83:	68 a0 69 11 80       	push   $0x801169a0
80105f88:	e8 b3 ed ff ff       	call   80104d40 <release>
	return 0;
80105f8d:	83 c4 10             	add    $0x10,%esp
80105f90:	31 c0                	xor    %eax,%eax
}
80105f92:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105f95:	c9                   	leave  
80105f96:	c3                   	ret    
		return -1;
80105f97:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105f9c:	eb f4                	jmp    80105f92 <sys_sleep+0xa2>
80105f9e:	66 90                	xchg   %ax,%ax

80105fa0 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int sys_uptime(void)
{
80105fa0:	f3 0f 1e fb          	endbr32 
80105fa4:	55                   	push   %ebp
80105fa5:	89 e5                	mov    %esp,%ebp
80105fa7:	53                   	push   %ebx
80105fa8:	83 ec 10             	sub    $0x10,%esp
	uint xticks;

	acquire(&tickslock);
80105fab:	68 a0 69 11 80       	push   $0x801169a0
80105fb0:	e8 cb ec ff ff       	call   80104c80 <acquire>
	xticks = ticks;
80105fb5:	8b 1d e0 71 11 80    	mov    0x801171e0,%ebx
	release(&tickslock);
80105fbb:	c7 04 24 a0 69 11 80 	movl   $0x801169a0,(%esp)
80105fc2:	e8 79 ed ff ff       	call   80104d40 <release>
	return xticks;
}
80105fc7:	89 d8                	mov    %ebx,%eax
80105fc9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105fcc:	c9                   	leave  
80105fcd:	c3                   	ret    
80105fce:	66 90                	xchg   %ax,%ax

80105fd0 <sys_lifetime>:

// this function returns time in seconds since process
// created.
uint sys_lifetime(void){
80105fd0:	f3 0f 1e fb          	endbr32 
80105fd4:	55                   	push   %ebp
80105fd5:	89 e5                	mov    %esp,%ebp
80105fd7:	56                   	push   %esi
80105fd8:	53                   	push   %ebx
	uint xticks;

	acquire(&tickslock);
80105fd9:	83 ec 0c             	sub    $0xc,%esp
80105fdc:	68 a0 69 11 80       	push   $0x801169a0
80105fe1:	e8 9a ec ff ff       	call   80104c80 <acquire>
	xticks = ticks;
80105fe6:	8b 1d e0 71 11 80    	mov    0x801171e0,%ebx
	release(&tickslock);
80105fec:	c7 04 24 a0 69 11 80 	movl   $0x801169a0,(%esp)
80105ff3:	e8 48 ed ff ff       	call   80104d40 <release>
	
  	struct proc *my_proc = myproc(); // Get the current process
80105ff8:	e8 a3 df ff ff       	call   80103fa0 <myproc>

	cprintf("[sys_lifetime] Current time  is: %d this app creation time is: %d\n",xticks,my_proc->xticks);
80105ffd:	83 c4 0c             	add    $0xc,%esp
80106000:	ff 70 6c             	pushl  0x6c(%eax)
  	struct proc *my_proc = myproc(); // Get the current process
80106003:	89 c6                	mov    %eax,%esi
	cprintf("[sys_lifetime] Current time  is: %d this app creation time is: %d\n",xticks,my_proc->xticks);
80106005:	53                   	push   %ebx
80106006:	68 2c 81 10 80       	push   $0x8010812c
8010600b:	e8 90 a7 ff ff       	call   801007a0 <cprintf>
	return (xticks-my_proc->xticks)/100;
80106010:	2b 5e 6c             	sub    0x6c(%esi),%ebx
80106013:	ba 1f 85 eb 51       	mov    $0x51eb851f,%edx

80106018:	8d 65 f8             	lea    -0x8(%ebp),%esp
	return (xticks-my_proc->xticks)/100;
8010601b:	89 d8                	mov    %ebx,%eax
8010601d:	5b                   	pop    %ebx
8010601e:	5e                   	pop    %esi
	return (xticks-my_proc->xticks)/100;
8010601f:	f7 e2                	mul    %edx
80106021:	5d                   	pop    %ebp
	return (xticks-my_proc->xticks)/100;
80106022:	89 d0                	mov    %edx,%eax
80106024:	c1 e8 05             	shr    $0x5,%eax
80106027:	c3                   	ret    
80106028:	66 90                	xchg   %ax,%ax
8010602a:	66 90                	xchg   %ax,%ax
8010602c:	66 90                	xchg   %ax,%ax
8010602e:	66 90                	xchg   %ax,%ax

80106030 <sys_find_digital_root>:
#include "mmu.h"
#include "proc.h"

// return digital root of number given
int sys_find_digital_root(void)
{
80106030:	f3 0f 1e fb          	endbr32 
80106034:	55                   	push   %ebp
80106035:	89 e5                	mov    %esp,%ebp
80106037:	56                   	push   %esi
80106038:	53                   	push   %ebx
    int n = myproc()->tf->ebx;
80106039:	e8 62 df ff ff       	call   80103fa0 <myproc>
    int res = 0;
8010603e:	31 c9                	xor    %ecx,%ecx
    int n = myproc()->tf->ebx;
80106040:	8b 40 18             	mov    0x18(%eax),%eax
80106043:	8b 70 10             	mov    0x10(%eax),%esi
    while (n > 0)
80106046:	85 f6                	test   %esi,%esi
80106048:	7e 4d                	jle    80106097 <sys_find_digital_root+0x67>
    {
        res += n % 10;
8010604a:	89 f0                	mov    %esi,%eax
8010604c:	ba 67 66 66 66       	mov    $0x66666667,%edx
80106051:	f7 ea                	imul   %edx
80106053:	89 f0                	mov    %esi,%eax
80106055:	c1 f8 1f             	sar    $0x1f,%eax
80106058:	c1 fa 02             	sar    $0x2,%edx
8010605b:	89 d1                	mov    %edx,%ecx
8010605d:	29 c1                	sub    %eax,%ecx
8010605f:	8d 04 89             	lea    (%ecx,%ecx,4),%eax
80106062:	89 cb                	mov    %ecx,%ebx
80106064:	01 c0                	add    %eax,%eax
80106066:	29 c6                	sub    %eax,%esi
80106068:	89 f1                	mov    %esi,%ecx
8010606a:	be cd cc cc cc       	mov    $0xcccccccd,%esi
8010606f:	eb 22                	jmp    80106093 <sys_find_digital_root+0x63>
80106071:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106078:	89 d8                	mov    %ebx,%eax
8010607a:	f7 e6                	mul    %esi
8010607c:	c1 ea 03             	shr    $0x3,%edx
8010607f:	8d 04 92             	lea    (%edx,%edx,4),%eax
80106082:	01 c0                	add    %eax,%eax
80106084:	29 c3                	sub    %eax,%ebx
80106086:	01 d9                	add    %ebx,%ecx
        n /= 10;
80106088:	89 d3                	mov    %edx,%ebx
        if (res > 9)
            res -= 9;
8010608a:	8d 41 f7             	lea    -0x9(%ecx),%eax
8010608d:	83 f9 09             	cmp    $0x9,%ecx
80106090:	0f 4f c8             	cmovg  %eax,%ecx
    while (n > 0)
80106093:	85 db                	test   %ebx,%ebx
80106095:	75 e1                	jne    80106078 <sys_find_digital_root+0x48>
    }
    return res;
80106097:	5b                   	pop    %ebx
80106098:	89 c8                	mov    %ecx,%eax
8010609a:	5e                   	pop    %esi
8010609b:	5d                   	pop    %ebp
8010609c:	c3                   	ret    

8010609d <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
8010609d:	1e                   	push   %ds
  pushl %es
8010609e:	06                   	push   %es
  pushl %fs
8010609f:	0f a0                	push   %fs
  pushl %gs
801060a1:	0f a8                	push   %gs
  pushal
801060a3:	60                   	pusha  
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
801060a4:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
801060a8:	8e d8                	mov    %eax,%ds
  movw %ax, %es
801060aa:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
801060ac:	54                   	push   %esp
  call trap
801060ad:	e8 be 00 00 00       	call   80106170 <trap>
  addl $4, %esp
801060b2:	83 c4 04             	add    $0x4,%esp

801060b5 <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
801060b5:	61                   	popa   
  popl %gs
801060b6:	0f a9                	pop    %gs
  popl %fs
801060b8:	0f a1                	pop    %fs
  popl %es
801060ba:	07                   	pop    %es
  popl %ds
801060bb:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
801060bc:	83 c4 08             	add    $0x8,%esp
  iret
801060bf:	cf                   	iret   

801060c0 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
801060c0:	f3 0f 1e fb          	endbr32 
801060c4:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
801060c5:	31 c0                	xor    %eax,%eax
{
801060c7:	89 e5                	mov    %esp,%ebp
801060c9:	83 ec 08             	sub    $0x8,%esp
801060cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
801060d0:	8b 14 85 08 b0 10 80 	mov    -0x7fef4ff8(,%eax,4),%edx
801060d7:	c7 04 c5 e2 69 11 80 	movl   $0x8e000008,-0x7fee961e(,%eax,8)
801060de:	08 00 00 8e 
801060e2:	66 89 14 c5 e0 69 11 	mov    %dx,-0x7fee9620(,%eax,8)
801060e9:	80 
801060ea:	c1 ea 10             	shr    $0x10,%edx
801060ed:	66 89 14 c5 e6 69 11 	mov    %dx,-0x7fee961a(,%eax,8)
801060f4:	80 
  for(i = 0; i < 256; i++)
801060f5:	83 c0 01             	add    $0x1,%eax
801060f8:	3d 00 01 00 00       	cmp    $0x100,%eax
801060fd:	75 d1                	jne    801060d0 <tvinit+0x10>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);

  initlock(&tickslock, "time");
801060ff:	83 ec 08             	sub    $0x8,%esp
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80106102:	a1 08 b1 10 80       	mov    0x8010b108,%eax
80106107:	c7 05 e2 6b 11 80 08 	movl   $0xef000008,0x80116be2
8010610e:	00 00 ef 
  initlock(&tickslock, "time");
80106111:	68 6f 81 10 80       	push   $0x8010816f
80106116:	68 a0 69 11 80       	push   $0x801169a0
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
8010611b:	66 a3 e0 6b 11 80    	mov    %ax,0x80116be0
80106121:	c1 e8 10             	shr    $0x10,%eax
80106124:	66 a3 e6 6b 11 80    	mov    %ax,0x80116be6
  initlock(&tickslock, "time");
8010612a:	e8 d1 e9 ff ff       	call   80104b00 <initlock>
}
8010612f:	83 c4 10             	add    $0x10,%esp
80106132:	c9                   	leave  
80106133:	c3                   	ret    
80106134:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010613b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010613f:	90                   	nop

80106140 <idtinit>:

void
idtinit(void)
{
80106140:	f3 0f 1e fb          	endbr32 
80106144:	55                   	push   %ebp
  pd[0] = size - 1;
80106145:	b8 ff 07 00 00       	mov    $0x7ff,%eax
8010614a:	89 e5                	mov    %esp,%ebp
8010614c:	83 ec 10             	sub    $0x10,%esp
8010614f:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
80106153:	b8 e0 69 11 80       	mov    $0x801169e0,%eax
80106158:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
8010615c:	c1 e8 10             	shr    $0x10,%eax
8010615f:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r"(pd));
80106163:	8d 45 fa             	lea    -0x6(%ebp),%eax
80106166:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80106169:	c9                   	leave  
8010616a:	c3                   	ret    
8010616b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010616f:	90                   	nop

80106170 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80106170:	f3 0f 1e fb          	endbr32 
80106174:	55                   	push   %ebp
80106175:	89 e5                	mov    %esp,%ebp
80106177:	57                   	push   %edi
80106178:	56                   	push   %esi
80106179:	53                   	push   %ebx
8010617a:	83 ec 1c             	sub    $0x1c,%esp
8010617d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(tf->trapno == T_SYSCALL){
80106180:	8b 43 30             	mov    0x30(%ebx),%eax
80106183:	83 f8 40             	cmp    $0x40,%eax
80106186:	0f 84 bc 01 00 00    	je     80106348 <trap+0x1d8>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
8010618c:	83 e8 20             	sub    $0x20,%eax
8010618f:	83 f8 1f             	cmp    $0x1f,%eax
80106192:	77 08                	ja     8010619c <trap+0x2c>
80106194:	3e ff 24 85 18 82 10 	notrack jmp *-0x7fef7de8(,%eax,4)
8010619b:	80 
    lapiceoi();
    break;

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
8010619c:	e8 ff dd ff ff       	call   80103fa0 <myproc>
801061a1:	8b 7b 38             	mov    0x38(%ebx),%edi
801061a4:	85 c0                	test   %eax,%eax
801061a6:	0f 84 eb 01 00 00    	je     80106397 <trap+0x227>
801061ac:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
801061b0:	0f 84 e1 01 00 00    	je     80106397 <trap+0x227>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r"(val));
801061b6:	0f 20 d1             	mov    %cr2,%ecx
801061b9:	89 4d d8             	mov    %ecx,-0x28(%ebp)
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801061bc:	e8 bf dd ff ff       	call   80103f80 <cpuid>
801061c1:	8b 73 30             	mov    0x30(%ebx),%esi
801061c4:	89 45 dc             	mov    %eax,-0x24(%ebp)
801061c7:	8b 43 34             	mov    0x34(%ebx),%eax
801061ca:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
801061cd:	e8 ce dd ff ff       	call   80103fa0 <myproc>
801061d2:	89 45 e0             	mov    %eax,-0x20(%ebp)
801061d5:	e8 c6 dd ff ff       	call   80103fa0 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801061da:	8b 4d d8             	mov    -0x28(%ebp),%ecx
801061dd:	8b 55 dc             	mov    -0x24(%ebp),%edx
801061e0:	51                   	push   %ecx
801061e1:	57                   	push   %edi
801061e2:	52                   	push   %edx
801061e3:	ff 75 e4             	pushl  -0x1c(%ebp)
801061e6:	56                   	push   %esi
            myproc()->pid, myproc()->name, tf->trapno,
801061e7:	8b 75 e0             	mov    -0x20(%ebp),%esi
801061ea:	83 c6 70             	add    $0x70,%esi
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801061ed:	56                   	push   %esi
801061ee:	ff 70 10             	pushl  0x10(%eax)
801061f1:	68 d4 81 10 80       	push   $0x801081d4
801061f6:	e8 a5 a5 ff ff       	call   801007a0 <cprintf>
            tf->err, cpuid(), tf->eip, rcr2());
    myproc()->killed = 1;
801061fb:	83 c4 20             	add    $0x20,%esp
801061fe:	e8 9d dd ff ff       	call   80103fa0 <myproc>
80106203:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010620a:	e8 91 dd ff ff       	call   80103fa0 <myproc>
8010620f:	85 c0                	test   %eax,%eax
80106211:	74 1d                	je     80106230 <trap+0xc0>
80106213:	e8 88 dd ff ff       	call   80103fa0 <myproc>
80106218:	8b 50 24             	mov    0x24(%eax),%edx
8010621b:	85 d2                	test   %edx,%edx
8010621d:	74 11                	je     80106230 <trap+0xc0>
8010621f:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80106223:	83 e0 03             	and    $0x3,%eax
80106226:	66 83 f8 03          	cmp    $0x3,%ax
8010622a:	0f 84 50 01 00 00    	je     80106380 <trap+0x210>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80106230:	e8 6b dd ff ff       	call   80103fa0 <myproc>
80106235:	85 c0                	test   %eax,%eax
80106237:	74 0f                	je     80106248 <trap+0xd8>
80106239:	e8 62 dd ff ff       	call   80103fa0 <myproc>
8010623e:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80106242:	0f 84 e8 00 00 00    	je     80106330 <trap+0x1c0>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106248:	e8 53 dd ff ff       	call   80103fa0 <myproc>
8010624d:	85 c0                	test   %eax,%eax
8010624f:	74 1d                	je     8010626e <trap+0xfe>
80106251:	e8 4a dd ff ff       	call   80103fa0 <myproc>
80106256:	8b 40 24             	mov    0x24(%eax),%eax
80106259:	85 c0                	test   %eax,%eax
8010625b:	74 11                	je     8010626e <trap+0xfe>
8010625d:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80106261:	83 e0 03             	and    $0x3,%eax
80106264:	66 83 f8 03          	cmp    $0x3,%ax
80106268:	0f 84 03 01 00 00    	je     80106371 <trap+0x201>
    exit();
}
8010626e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106271:	5b                   	pop    %ebx
80106272:	5e                   	pop    %esi
80106273:	5f                   	pop    %edi
80106274:	5d                   	pop    %ebp
80106275:	c3                   	ret    
    ideintr();
80106276:	e8 a5 c5 ff ff       	call   80102820 <ideintr>
    lapiceoi();
8010627b:	e8 80 cc ff ff       	call   80102f00 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106280:	e8 1b dd ff ff       	call   80103fa0 <myproc>
80106285:	85 c0                	test   %eax,%eax
80106287:	75 8a                	jne    80106213 <trap+0xa3>
80106289:	eb a5                	jmp    80106230 <trap+0xc0>
    if(cpuid() == 0){
8010628b:	e8 f0 dc ff ff       	call   80103f80 <cpuid>
80106290:	85 c0                	test   %eax,%eax
80106292:	75 e7                	jne    8010627b <trap+0x10b>
      acquire(&tickslock);
80106294:	83 ec 0c             	sub    $0xc,%esp
80106297:	68 a0 69 11 80       	push   $0x801169a0
8010629c:	e8 df e9 ff ff       	call   80104c80 <acquire>
      wakeup(&ticks);
801062a1:	c7 04 24 e0 71 11 80 	movl   $0x801171e0,(%esp)
      ticks++;
801062a8:	83 05 e0 71 11 80 01 	addl   $0x1,0x801171e0
      wakeup(&ticks);
801062af:	e8 9c e4 ff ff       	call   80104750 <wakeup>
      release(&tickslock);
801062b4:	c7 04 24 a0 69 11 80 	movl   $0x801169a0,(%esp)
801062bb:	e8 80 ea ff ff       	call   80104d40 <release>
801062c0:	83 c4 10             	add    $0x10,%esp
    lapiceoi();
801062c3:	eb b6                	jmp    8010627b <trap+0x10b>
    kbdintr();
801062c5:	e8 f6 ca ff ff       	call   80102dc0 <kbdintr>
    lapiceoi();
801062ca:	e8 31 cc ff ff       	call   80102f00 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801062cf:	e8 cc dc ff ff       	call   80103fa0 <myproc>
801062d4:	85 c0                	test   %eax,%eax
801062d6:	0f 85 37 ff ff ff    	jne    80106213 <trap+0xa3>
801062dc:	e9 4f ff ff ff       	jmp    80106230 <trap+0xc0>
    uartintr();
801062e1:	e8 4a 02 00 00       	call   80106530 <uartintr>
    lapiceoi();
801062e6:	e8 15 cc ff ff       	call   80102f00 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801062eb:	e8 b0 dc ff ff       	call   80103fa0 <myproc>
801062f0:	85 c0                	test   %eax,%eax
801062f2:	0f 85 1b ff ff ff    	jne    80106213 <trap+0xa3>
801062f8:	e9 33 ff ff ff       	jmp    80106230 <trap+0xc0>
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
801062fd:	8b 7b 38             	mov    0x38(%ebx),%edi
80106300:	0f b7 73 3c          	movzwl 0x3c(%ebx),%esi
80106304:	e8 77 dc ff ff       	call   80103f80 <cpuid>
80106309:	57                   	push   %edi
8010630a:	56                   	push   %esi
8010630b:	50                   	push   %eax
8010630c:	68 7c 81 10 80       	push   $0x8010817c
80106311:	e8 8a a4 ff ff       	call   801007a0 <cprintf>
    lapiceoi();
80106316:	e8 e5 cb ff ff       	call   80102f00 <lapiceoi>
    break;
8010631b:	83 c4 10             	add    $0x10,%esp
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010631e:	e8 7d dc ff ff       	call   80103fa0 <myproc>
80106323:	85 c0                	test   %eax,%eax
80106325:	0f 85 e8 fe ff ff    	jne    80106213 <trap+0xa3>
8010632b:	e9 00 ff ff ff       	jmp    80106230 <trap+0xc0>
  if(myproc() && myproc()->state == RUNNING &&
80106330:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
80106334:	0f 85 0e ff ff ff    	jne    80106248 <trap+0xd8>
    yield();
8010633a:	e8 01 e2 ff ff       	call   80104540 <yield>
8010633f:	e9 04 ff ff ff       	jmp    80106248 <trap+0xd8>
80106344:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed)
80106348:	e8 53 dc ff ff       	call   80103fa0 <myproc>
8010634d:	8b 70 24             	mov    0x24(%eax),%esi
80106350:	85 f6                	test   %esi,%esi
80106352:	75 3c                	jne    80106390 <trap+0x220>
    myproc()->tf = tf;
80106354:	e8 47 dc ff ff       	call   80103fa0 <myproc>
80106359:	89 58 18             	mov    %ebx,0x18(%eax)
    syscall();
8010635c:	e8 ff ed ff ff       	call   80105160 <syscall>
    if(myproc()->killed)
80106361:	e8 3a dc ff ff       	call   80103fa0 <myproc>
80106366:	8b 48 24             	mov    0x24(%eax),%ecx
80106369:	85 c9                	test   %ecx,%ecx
8010636b:	0f 84 fd fe ff ff    	je     8010626e <trap+0xfe>
}
80106371:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106374:	5b                   	pop    %ebx
80106375:	5e                   	pop    %esi
80106376:	5f                   	pop    %edi
80106377:	5d                   	pop    %ebp
      exit();
80106378:	e9 83 e0 ff ff       	jmp    80104400 <exit>
8010637d:	8d 76 00             	lea    0x0(%esi),%esi
    exit();
80106380:	e8 7b e0 ff ff       	call   80104400 <exit>
80106385:	e9 a6 fe ff ff       	jmp    80106230 <trap+0xc0>
8010638a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      exit();
80106390:	e8 6b e0 ff ff       	call   80104400 <exit>
80106395:	eb bd                	jmp    80106354 <trap+0x1e4>
80106397:	0f 20 d6             	mov    %cr2,%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
8010639a:	e8 e1 db ff ff       	call   80103f80 <cpuid>
8010639f:	83 ec 0c             	sub    $0xc,%esp
801063a2:	56                   	push   %esi
801063a3:	57                   	push   %edi
801063a4:	50                   	push   %eax
801063a5:	ff 73 30             	pushl  0x30(%ebx)
801063a8:	68 a0 81 10 80       	push   $0x801081a0
801063ad:	e8 ee a3 ff ff       	call   801007a0 <cprintf>
      panic("trap");
801063b2:	83 c4 14             	add    $0x14,%esp
801063b5:	68 74 81 10 80       	push   $0x80108174
801063ba:	e8 f1 9f ff ff       	call   801003b0 <panic>
801063bf:	90                   	nop

801063c0 <uartgetc>:
  outb(COM1+0, c);
}

static int
uartgetc(void)
{
801063c0:	f3 0f 1e fb          	endbr32 
  if(!uart)
801063c4:	a1 3c c2 10 80       	mov    0x8010c23c,%eax
801063c9:	85 c0                	test   %eax,%eax
801063cb:	74 1b                	je     801063e8 <uartgetc+0x28>
  asm volatile("in %1,%0" : "=a"(data) : "d"(port));
801063cd:	ba fd 03 00 00       	mov    $0x3fd,%edx
801063d2:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
801063d3:	a8 01                	test   $0x1,%al
801063d5:	74 11                	je     801063e8 <uartgetc+0x28>
801063d7:	ba f8 03 00 00       	mov    $0x3f8,%edx
801063dc:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
801063dd:	0f b6 c0             	movzbl %al,%eax
801063e0:	c3                   	ret    
801063e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801063e8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801063ed:	c3                   	ret    
801063ee:	66 90                	xchg   %ax,%ax

801063f0 <uartputc.part.0>:
uartputc(int c)
801063f0:	55                   	push   %ebp
801063f1:	89 e5                	mov    %esp,%ebp
801063f3:	57                   	push   %edi
801063f4:	89 c7                	mov    %eax,%edi
801063f6:	56                   	push   %esi
801063f7:	be fd 03 00 00       	mov    $0x3fd,%esi
801063fc:	53                   	push   %ebx
801063fd:	bb 80 00 00 00       	mov    $0x80,%ebx
80106402:	83 ec 0c             	sub    $0xc,%esp
80106405:	eb 1b                	jmp    80106422 <uartputc.part.0+0x32>
80106407:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010640e:	66 90                	xchg   %ax,%ax
    microdelay(10);
80106410:	83 ec 0c             	sub    $0xc,%esp
80106413:	6a 0a                	push   $0xa
80106415:	e8 06 cb ff ff       	call   80102f20 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
8010641a:	83 c4 10             	add    $0x10,%esp
8010641d:	83 eb 01             	sub    $0x1,%ebx
80106420:	74 07                	je     80106429 <uartputc.part.0+0x39>
80106422:	89 f2                	mov    %esi,%edx
80106424:	ec                   	in     (%dx),%al
80106425:	a8 20                	test   $0x20,%al
80106427:	74 e7                	je     80106410 <uartputc.part.0+0x20>
  asm volatile("out %0,%1" : : "a"(data), "d"(port));
80106429:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010642e:	89 f8                	mov    %edi,%eax
80106430:	ee                   	out    %al,(%dx)
}
80106431:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106434:	5b                   	pop    %ebx
80106435:	5e                   	pop    %esi
80106436:	5f                   	pop    %edi
80106437:	5d                   	pop    %ebp
80106438:	c3                   	ret    
80106439:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106440 <uartinit>:
{
80106440:	f3 0f 1e fb          	endbr32 
80106444:	55                   	push   %ebp
80106445:	31 c9                	xor    %ecx,%ecx
80106447:	89 c8                	mov    %ecx,%eax
80106449:	89 e5                	mov    %esp,%ebp
8010644b:	57                   	push   %edi
8010644c:	56                   	push   %esi
8010644d:	53                   	push   %ebx
8010644e:	bb fa 03 00 00       	mov    $0x3fa,%ebx
80106453:	89 da                	mov    %ebx,%edx
80106455:	83 ec 0c             	sub    $0xc,%esp
80106458:	ee                   	out    %al,(%dx)
80106459:	bf fb 03 00 00       	mov    $0x3fb,%edi
8010645e:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
80106463:	89 fa                	mov    %edi,%edx
80106465:	ee                   	out    %al,(%dx)
80106466:	b8 0c 00 00 00       	mov    $0xc,%eax
8010646b:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106470:	ee                   	out    %al,(%dx)
80106471:	be f9 03 00 00       	mov    $0x3f9,%esi
80106476:	89 c8                	mov    %ecx,%eax
80106478:	89 f2                	mov    %esi,%edx
8010647a:	ee                   	out    %al,(%dx)
8010647b:	b8 03 00 00 00       	mov    $0x3,%eax
80106480:	89 fa                	mov    %edi,%edx
80106482:	ee                   	out    %al,(%dx)
80106483:	ba fc 03 00 00       	mov    $0x3fc,%edx
80106488:	89 c8                	mov    %ecx,%eax
8010648a:	ee                   	out    %al,(%dx)
8010648b:	b8 01 00 00 00       	mov    $0x1,%eax
80106490:	89 f2                	mov    %esi,%edx
80106492:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a"(data) : "d"(port));
80106493:	ba fd 03 00 00       	mov    $0x3fd,%edx
80106498:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
80106499:	3c ff                	cmp    $0xff,%al
8010649b:	74 52                	je     801064ef <uartinit+0xaf>
  uart = 1;
8010649d:	c7 05 3c c2 10 80 01 	movl   $0x1,0x8010c23c
801064a4:	00 00 00 
801064a7:	89 da                	mov    %ebx,%edx
801064a9:	ec                   	in     (%dx),%al
801064aa:	ba f8 03 00 00       	mov    $0x3f8,%edx
801064af:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
801064b0:	83 ec 08             	sub    $0x8,%esp
801064b3:	be 76 00 00 00       	mov    $0x76,%esi
  for(p="xv6...\n"; *p; p++)
801064b8:	bb 98 82 10 80       	mov    $0x80108298,%ebx
  ioapicenable(IRQ_COM1, 0);
801064bd:	6a 00                	push   $0x0
801064bf:	6a 04                	push   $0x4
801064c1:	e8 aa c5 ff ff       	call   80102a70 <ioapicenable>
801064c6:	83 c4 10             	add    $0x10,%esp
  for(p="xv6...\n"; *p; p++)
801064c9:	b8 78 00 00 00       	mov    $0x78,%eax
801064ce:	eb 04                	jmp    801064d4 <uartinit+0x94>
801064d0:	0f b6 73 01          	movzbl 0x1(%ebx),%esi
  if(!uart)
801064d4:	8b 15 3c c2 10 80    	mov    0x8010c23c,%edx
801064da:	85 d2                	test   %edx,%edx
801064dc:	74 08                	je     801064e6 <uartinit+0xa6>
    uartputc(*p);
801064de:	0f be c0             	movsbl %al,%eax
801064e1:	e8 0a ff ff ff       	call   801063f0 <uartputc.part.0>
  for(p="xv6...\n"; *p; p++)
801064e6:	89 f0                	mov    %esi,%eax
801064e8:	83 c3 01             	add    $0x1,%ebx
801064eb:	84 c0                	test   %al,%al
801064ed:	75 e1                	jne    801064d0 <uartinit+0x90>
}
801064ef:	8d 65 f4             	lea    -0xc(%ebp),%esp
801064f2:	5b                   	pop    %ebx
801064f3:	5e                   	pop    %esi
801064f4:	5f                   	pop    %edi
801064f5:	5d                   	pop    %ebp
801064f6:	c3                   	ret    
801064f7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801064fe:	66 90                	xchg   %ax,%ax

80106500 <uartputc>:
{
80106500:	f3 0f 1e fb          	endbr32 
80106504:	55                   	push   %ebp
  if(!uart)
80106505:	8b 15 3c c2 10 80    	mov    0x8010c23c,%edx
{
8010650b:	89 e5                	mov    %esp,%ebp
8010650d:	8b 45 08             	mov    0x8(%ebp),%eax
  if(!uart)
80106510:	85 d2                	test   %edx,%edx
80106512:	74 0c                	je     80106520 <uartputc+0x20>
}
80106514:	5d                   	pop    %ebp
80106515:	e9 d6 fe ff ff       	jmp    801063f0 <uartputc.part.0>
8010651a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106520:	5d                   	pop    %ebp
80106521:	c3                   	ret    
80106522:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106529:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106530 <uartintr>:

void
uartintr(void)
{
80106530:	f3 0f 1e fb          	endbr32 
80106534:	55                   	push   %ebp
80106535:	89 e5                	mov    %esp,%ebp
80106537:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
8010653a:	68 c0 63 10 80       	push   $0x801063c0
8010653f:	e8 fc a7 ff ff       	call   80100d40 <consoleintr>
}
80106544:	83 c4 10             	add    $0x10,%esp
80106547:	c9                   	leave  
80106548:	c3                   	ret    

80106549 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80106549:	6a 00                	push   $0x0
  pushl $0
8010654b:	6a 00                	push   $0x0
  jmp alltraps
8010654d:	e9 4b fb ff ff       	jmp    8010609d <alltraps>

80106552 <vector1>:
.globl vector1
vector1:
  pushl $0
80106552:	6a 00                	push   $0x0
  pushl $1
80106554:	6a 01                	push   $0x1
  jmp alltraps
80106556:	e9 42 fb ff ff       	jmp    8010609d <alltraps>

8010655b <vector2>:
.globl vector2
vector2:
  pushl $0
8010655b:	6a 00                	push   $0x0
  pushl $2
8010655d:	6a 02                	push   $0x2
  jmp alltraps
8010655f:	e9 39 fb ff ff       	jmp    8010609d <alltraps>

80106564 <vector3>:
.globl vector3
vector3:
  pushl $0
80106564:	6a 00                	push   $0x0
  pushl $3
80106566:	6a 03                	push   $0x3
  jmp alltraps
80106568:	e9 30 fb ff ff       	jmp    8010609d <alltraps>

8010656d <vector4>:
.globl vector4
vector4:
  pushl $0
8010656d:	6a 00                	push   $0x0
  pushl $4
8010656f:	6a 04                	push   $0x4
  jmp alltraps
80106571:	e9 27 fb ff ff       	jmp    8010609d <alltraps>

80106576 <vector5>:
.globl vector5
vector5:
  pushl $0
80106576:	6a 00                	push   $0x0
  pushl $5
80106578:	6a 05                	push   $0x5
  jmp alltraps
8010657a:	e9 1e fb ff ff       	jmp    8010609d <alltraps>

8010657f <vector6>:
.globl vector6
vector6:
  pushl $0
8010657f:	6a 00                	push   $0x0
  pushl $6
80106581:	6a 06                	push   $0x6
  jmp alltraps
80106583:	e9 15 fb ff ff       	jmp    8010609d <alltraps>

80106588 <vector7>:
.globl vector7
vector7:
  pushl $0
80106588:	6a 00                	push   $0x0
  pushl $7
8010658a:	6a 07                	push   $0x7
  jmp alltraps
8010658c:	e9 0c fb ff ff       	jmp    8010609d <alltraps>

80106591 <vector8>:
.globl vector8
vector8:
  pushl $8
80106591:	6a 08                	push   $0x8
  jmp alltraps
80106593:	e9 05 fb ff ff       	jmp    8010609d <alltraps>

80106598 <vector9>:
.globl vector9
vector9:
  pushl $0
80106598:	6a 00                	push   $0x0
  pushl $9
8010659a:	6a 09                	push   $0x9
  jmp alltraps
8010659c:	e9 fc fa ff ff       	jmp    8010609d <alltraps>

801065a1 <vector10>:
.globl vector10
vector10:
  pushl $10
801065a1:	6a 0a                	push   $0xa
  jmp alltraps
801065a3:	e9 f5 fa ff ff       	jmp    8010609d <alltraps>

801065a8 <vector11>:
.globl vector11
vector11:
  pushl $11
801065a8:	6a 0b                	push   $0xb
  jmp alltraps
801065aa:	e9 ee fa ff ff       	jmp    8010609d <alltraps>

801065af <vector12>:
.globl vector12
vector12:
  pushl $12
801065af:	6a 0c                	push   $0xc
  jmp alltraps
801065b1:	e9 e7 fa ff ff       	jmp    8010609d <alltraps>

801065b6 <vector13>:
.globl vector13
vector13:
  pushl $13
801065b6:	6a 0d                	push   $0xd
  jmp alltraps
801065b8:	e9 e0 fa ff ff       	jmp    8010609d <alltraps>

801065bd <vector14>:
.globl vector14
vector14:
  pushl $14
801065bd:	6a 0e                	push   $0xe
  jmp alltraps
801065bf:	e9 d9 fa ff ff       	jmp    8010609d <alltraps>

801065c4 <vector15>:
.globl vector15
vector15:
  pushl $0
801065c4:	6a 00                	push   $0x0
  pushl $15
801065c6:	6a 0f                	push   $0xf
  jmp alltraps
801065c8:	e9 d0 fa ff ff       	jmp    8010609d <alltraps>

801065cd <vector16>:
.globl vector16
vector16:
  pushl $0
801065cd:	6a 00                	push   $0x0
  pushl $16
801065cf:	6a 10                	push   $0x10
  jmp alltraps
801065d1:	e9 c7 fa ff ff       	jmp    8010609d <alltraps>

801065d6 <vector17>:
.globl vector17
vector17:
  pushl $17
801065d6:	6a 11                	push   $0x11
  jmp alltraps
801065d8:	e9 c0 fa ff ff       	jmp    8010609d <alltraps>

801065dd <vector18>:
.globl vector18
vector18:
  pushl $0
801065dd:	6a 00                	push   $0x0
  pushl $18
801065df:	6a 12                	push   $0x12
  jmp alltraps
801065e1:	e9 b7 fa ff ff       	jmp    8010609d <alltraps>

801065e6 <vector19>:
.globl vector19
vector19:
  pushl $0
801065e6:	6a 00                	push   $0x0
  pushl $19
801065e8:	6a 13                	push   $0x13
  jmp alltraps
801065ea:	e9 ae fa ff ff       	jmp    8010609d <alltraps>

801065ef <vector20>:
.globl vector20
vector20:
  pushl $0
801065ef:	6a 00                	push   $0x0
  pushl $20
801065f1:	6a 14                	push   $0x14
  jmp alltraps
801065f3:	e9 a5 fa ff ff       	jmp    8010609d <alltraps>

801065f8 <vector21>:
.globl vector21
vector21:
  pushl $0
801065f8:	6a 00                	push   $0x0
  pushl $21
801065fa:	6a 15                	push   $0x15
  jmp alltraps
801065fc:	e9 9c fa ff ff       	jmp    8010609d <alltraps>

80106601 <vector22>:
.globl vector22
vector22:
  pushl $0
80106601:	6a 00                	push   $0x0
  pushl $22
80106603:	6a 16                	push   $0x16
  jmp alltraps
80106605:	e9 93 fa ff ff       	jmp    8010609d <alltraps>

8010660a <vector23>:
.globl vector23
vector23:
  pushl $0
8010660a:	6a 00                	push   $0x0
  pushl $23
8010660c:	6a 17                	push   $0x17
  jmp alltraps
8010660e:	e9 8a fa ff ff       	jmp    8010609d <alltraps>

80106613 <vector24>:
.globl vector24
vector24:
  pushl $0
80106613:	6a 00                	push   $0x0
  pushl $24
80106615:	6a 18                	push   $0x18
  jmp alltraps
80106617:	e9 81 fa ff ff       	jmp    8010609d <alltraps>

8010661c <vector25>:
.globl vector25
vector25:
  pushl $0
8010661c:	6a 00                	push   $0x0
  pushl $25
8010661e:	6a 19                	push   $0x19
  jmp alltraps
80106620:	e9 78 fa ff ff       	jmp    8010609d <alltraps>

80106625 <vector26>:
.globl vector26
vector26:
  pushl $0
80106625:	6a 00                	push   $0x0
  pushl $26
80106627:	6a 1a                	push   $0x1a
  jmp alltraps
80106629:	e9 6f fa ff ff       	jmp    8010609d <alltraps>

8010662e <vector27>:
.globl vector27
vector27:
  pushl $0
8010662e:	6a 00                	push   $0x0
  pushl $27
80106630:	6a 1b                	push   $0x1b
  jmp alltraps
80106632:	e9 66 fa ff ff       	jmp    8010609d <alltraps>

80106637 <vector28>:
.globl vector28
vector28:
  pushl $0
80106637:	6a 00                	push   $0x0
  pushl $28
80106639:	6a 1c                	push   $0x1c
  jmp alltraps
8010663b:	e9 5d fa ff ff       	jmp    8010609d <alltraps>

80106640 <vector29>:
.globl vector29
vector29:
  pushl $0
80106640:	6a 00                	push   $0x0
  pushl $29
80106642:	6a 1d                	push   $0x1d
  jmp alltraps
80106644:	e9 54 fa ff ff       	jmp    8010609d <alltraps>

80106649 <vector30>:
.globl vector30
vector30:
  pushl $0
80106649:	6a 00                	push   $0x0
  pushl $30
8010664b:	6a 1e                	push   $0x1e
  jmp alltraps
8010664d:	e9 4b fa ff ff       	jmp    8010609d <alltraps>

80106652 <vector31>:
.globl vector31
vector31:
  pushl $0
80106652:	6a 00                	push   $0x0
  pushl $31
80106654:	6a 1f                	push   $0x1f
  jmp alltraps
80106656:	e9 42 fa ff ff       	jmp    8010609d <alltraps>

8010665b <vector32>:
.globl vector32
vector32:
  pushl $0
8010665b:	6a 00                	push   $0x0
  pushl $32
8010665d:	6a 20                	push   $0x20
  jmp alltraps
8010665f:	e9 39 fa ff ff       	jmp    8010609d <alltraps>

80106664 <vector33>:
.globl vector33
vector33:
  pushl $0
80106664:	6a 00                	push   $0x0
  pushl $33
80106666:	6a 21                	push   $0x21
  jmp alltraps
80106668:	e9 30 fa ff ff       	jmp    8010609d <alltraps>

8010666d <vector34>:
.globl vector34
vector34:
  pushl $0
8010666d:	6a 00                	push   $0x0
  pushl $34
8010666f:	6a 22                	push   $0x22
  jmp alltraps
80106671:	e9 27 fa ff ff       	jmp    8010609d <alltraps>

80106676 <vector35>:
.globl vector35
vector35:
  pushl $0
80106676:	6a 00                	push   $0x0
  pushl $35
80106678:	6a 23                	push   $0x23
  jmp alltraps
8010667a:	e9 1e fa ff ff       	jmp    8010609d <alltraps>

8010667f <vector36>:
.globl vector36
vector36:
  pushl $0
8010667f:	6a 00                	push   $0x0
  pushl $36
80106681:	6a 24                	push   $0x24
  jmp alltraps
80106683:	e9 15 fa ff ff       	jmp    8010609d <alltraps>

80106688 <vector37>:
.globl vector37
vector37:
  pushl $0
80106688:	6a 00                	push   $0x0
  pushl $37
8010668a:	6a 25                	push   $0x25
  jmp alltraps
8010668c:	e9 0c fa ff ff       	jmp    8010609d <alltraps>

80106691 <vector38>:
.globl vector38
vector38:
  pushl $0
80106691:	6a 00                	push   $0x0
  pushl $38
80106693:	6a 26                	push   $0x26
  jmp alltraps
80106695:	e9 03 fa ff ff       	jmp    8010609d <alltraps>

8010669a <vector39>:
.globl vector39
vector39:
  pushl $0
8010669a:	6a 00                	push   $0x0
  pushl $39
8010669c:	6a 27                	push   $0x27
  jmp alltraps
8010669e:	e9 fa f9 ff ff       	jmp    8010609d <alltraps>

801066a3 <vector40>:
.globl vector40
vector40:
  pushl $0
801066a3:	6a 00                	push   $0x0
  pushl $40
801066a5:	6a 28                	push   $0x28
  jmp alltraps
801066a7:	e9 f1 f9 ff ff       	jmp    8010609d <alltraps>

801066ac <vector41>:
.globl vector41
vector41:
  pushl $0
801066ac:	6a 00                	push   $0x0
  pushl $41
801066ae:	6a 29                	push   $0x29
  jmp alltraps
801066b0:	e9 e8 f9 ff ff       	jmp    8010609d <alltraps>

801066b5 <vector42>:
.globl vector42
vector42:
  pushl $0
801066b5:	6a 00                	push   $0x0
  pushl $42
801066b7:	6a 2a                	push   $0x2a
  jmp alltraps
801066b9:	e9 df f9 ff ff       	jmp    8010609d <alltraps>

801066be <vector43>:
.globl vector43
vector43:
  pushl $0
801066be:	6a 00                	push   $0x0
  pushl $43
801066c0:	6a 2b                	push   $0x2b
  jmp alltraps
801066c2:	e9 d6 f9 ff ff       	jmp    8010609d <alltraps>

801066c7 <vector44>:
.globl vector44
vector44:
  pushl $0
801066c7:	6a 00                	push   $0x0
  pushl $44
801066c9:	6a 2c                	push   $0x2c
  jmp alltraps
801066cb:	e9 cd f9 ff ff       	jmp    8010609d <alltraps>

801066d0 <vector45>:
.globl vector45
vector45:
  pushl $0
801066d0:	6a 00                	push   $0x0
  pushl $45
801066d2:	6a 2d                	push   $0x2d
  jmp alltraps
801066d4:	e9 c4 f9 ff ff       	jmp    8010609d <alltraps>

801066d9 <vector46>:
.globl vector46
vector46:
  pushl $0
801066d9:	6a 00                	push   $0x0
  pushl $46
801066db:	6a 2e                	push   $0x2e
  jmp alltraps
801066dd:	e9 bb f9 ff ff       	jmp    8010609d <alltraps>

801066e2 <vector47>:
.globl vector47
vector47:
  pushl $0
801066e2:	6a 00                	push   $0x0
  pushl $47
801066e4:	6a 2f                	push   $0x2f
  jmp alltraps
801066e6:	e9 b2 f9 ff ff       	jmp    8010609d <alltraps>

801066eb <vector48>:
.globl vector48
vector48:
  pushl $0
801066eb:	6a 00                	push   $0x0
  pushl $48
801066ed:	6a 30                	push   $0x30
  jmp alltraps
801066ef:	e9 a9 f9 ff ff       	jmp    8010609d <alltraps>

801066f4 <vector49>:
.globl vector49
vector49:
  pushl $0
801066f4:	6a 00                	push   $0x0
  pushl $49
801066f6:	6a 31                	push   $0x31
  jmp alltraps
801066f8:	e9 a0 f9 ff ff       	jmp    8010609d <alltraps>

801066fd <vector50>:
.globl vector50
vector50:
  pushl $0
801066fd:	6a 00                	push   $0x0
  pushl $50
801066ff:	6a 32                	push   $0x32
  jmp alltraps
80106701:	e9 97 f9 ff ff       	jmp    8010609d <alltraps>

80106706 <vector51>:
.globl vector51
vector51:
  pushl $0
80106706:	6a 00                	push   $0x0
  pushl $51
80106708:	6a 33                	push   $0x33
  jmp alltraps
8010670a:	e9 8e f9 ff ff       	jmp    8010609d <alltraps>

8010670f <vector52>:
.globl vector52
vector52:
  pushl $0
8010670f:	6a 00                	push   $0x0
  pushl $52
80106711:	6a 34                	push   $0x34
  jmp alltraps
80106713:	e9 85 f9 ff ff       	jmp    8010609d <alltraps>

80106718 <vector53>:
.globl vector53
vector53:
  pushl $0
80106718:	6a 00                	push   $0x0
  pushl $53
8010671a:	6a 35                	push   $0x35
  jmp alltraps
8010671c:	e9 7c f9 ff ff       	jmp    8010609d <alltraps>

80106721 <vector54>:
.globl vector54
vector54:
  pushl $0
80106721:	6a 00                	push   $0x0
  pushl $54
80106723:	6a 36                	push   $0x36
  jmp alltraps
80106725:	e9 73 f9 ff ff       	jmp    8010609d <alltraps>

8010672a <vector55>:
.globl vector55
vector55:
  pushl $0
8010672a:	6a 00                	push   $0x0
  pushl $55
8010672c:	6a 37                	push   $0x37
  jmp alltraps
8010672e:	e9 6a f9 ff ff       	jmp    8010609d <alltraps>

80106733 <vector56>:
.globl vector56
vector56:
  pushl $0
80106733:	6a 00                	push   $0x0
  pushl $56
80106735:	6a 38                	push   $0x38
  jmp alltraps
80106737:	e9 61 f9 ff ff       	jmp    8010609d <alltraps>

8010673c <vector57>:
.globl vector57
vector57:
  pushl $0
8010673c:	6a 00                	push   $0x0
  pushl $57
8010673e:	6a 39                	push   $0x39
  jmp alltraps
80106740:	e9 58 f9 ff ff       	jmp    8010609d <alltraps>

80106745 <vector58>:
.globl vector58
vector58:
  pushl $0
80106745:	6a 00                	push   $0x0
  pushl $58
80106747:	6a 3a                	push   $0x3a
  jmp alltraps
80106749:	e9 4f f9 ff ff       	jmp    8010609d <alltraps>

8010674e <vector59>:
.globl vector59
vector59:
  pushl $0
8010674e:	6a 00                	push   $0x0
  pushl $59
80106750:	6a 3b                	push   $0x3b
  jmp alltraps
80106752:	e9 46 f9 ff ff       	jmp    8010609d <alltraps>

80106757 <vector60>:
.globl vector60
vector60:
  pushl $0
80106757:	6a 00                	push   $0x0
  pushl $60
80106759:	6a 3c                	push   $0x3c
  jmp alltraps
8010675b:	e9 3d f9 ff ff       	jmp    8010609d <alltraps>

80106760 <vector61>:
.globl vector61
vector61:
  pushl $0
80106760:	6a 00                	push   $0x0
  pushl $61
80106762:	6a 3d                	push   $0x3d
  jmp alltraps
80106764:	e9 34 f9 ff ff       	jmp    8010609d <alltraps>

80106769 <vector62>:
.globl vector62
vector62:
  pushl $0
80106769:	6a 00                	push   $0x0
  pushl $62
8010676b:	6a 3e                	push   $0x3e
  jmp alltraps
8010676d:	e9 2b f9 ff ff       	jmp    8010609d <alltraps>

80106772 <vector63>:
.globl vector63
vector63:
  pushl $0
80106772:	6a 00                	push   $0x0
  pushl $63
80106774:	6a 3f                	push   $0x3f
  jmp alltraps
80106776:	e9 22 f9 ff ff       	jmp    8010609d <alltraps>

8010677b <vector64>:
.globl vector64
vector64:
  pushl $0
8010677b:	6a 00                	push   $0x0
  pushl $64
8010677d:	6a 40                	push   $0x40
  jmp alltraps
8010677f:	e9 19 f9 ff ff       	jmp    8010609d <alltraps>

80106784 <vector65>:
.globl vector65
vector65:
  pushl $0
80106784:	6a 00                	push   $0x0
  pushl $65
80106786:	6a 41                	push   $0x41
  jmp alltraps
80106788:	e9 10 f9 ff ff       	jmp    8010609d <alltraps>

8010678d <vector66>:
.globl vector66
vector66:
  pushl $0
8010678d:	6a 00                	push   $0x0
  pushl $66
8010678f:	6a 42                	push   $0x42
  jmp alltraps
80106791:	e9 07 f9 ff ff       	jmp    8010609d <alltraps>

80106796 <vector67>:
.globl vector67
vector67:
  pushl $0
80106796:	6a 00                	push   $0x0
  pushl $67
80106798:	6a 43                	push   $0x43
  jmp alltraps
8010679a:	e9 fe f8 ff ff       	jmp    8010609d <alltraps>

8010679f <vector68>:
.globl vector68
vector68:
  pushl $0
8010679f:	6a 00                	push   $0x0
  pushl $68
801067a1:	6a 44                	push   $0x44
  jmp alltraps
801067a3:	e9 f5 f8 ff ff       	jmp    8010609d <alltraps>

801067a8 <vector69>:
.globl vector69
vector69:
  pushl $0
801067a8:	6a 00                	push   $0x0
  pushl $69
801067aa:	6a 45                	push   $0x45
  jmp alltraps
801067ac:	e9 ec f8 ff ff       	jmp    8010609d <alltraps>

801067b1 <vector70>:
.globl vector70
vector70:
  pushl $0
801067b1:	6a 00                	push   $0x0
  pushl $70
801067b3:	6a 46                	push   $0x46
  jmp alltraps
801067b5:	e9 e3 f8 ff ff       	jmp    8010609d <alltraps>

801067ba <vector71>:
.globl vector71
vector71:
  pushl $0
801067ba:	6a 00                	push   $0x0
  pushl $71
801067bc:	6a 47                	push   $0x47
  jmp alltraps
801067be:	e9 da f8 ff ff       	jmp    8010609d <alltraps>

801067c3 <vector72>:
.globl vector72
vector72:
  pushl $0
801067c3:	6a 00                	push   $0x0
  pushl $72
801067c5:	6a 48                	push   $0x48
  jmp alltraps
801067c7:	e9 d1 f8 ff ff       	jmp    8010609d <alltraps>

801067cc <vector73>:
.globl vector73
vector73:
  pushl $0
801067cc:	6a 00                	push   $0x0
  pushl $73
801067ce:	6a 49                	push   $0x49
  jmp alltraps
801067d0:	e9 c8 f8 ff ff       	jmp    8010609d <alltraps>

801067d5 <vector74>:
.globl vector74
vector74:
  pushl $0
801067d5:	6a 00                	push   $0x0
  pushl $74
801067d7:	6a 4a                	push   $0x4a
  jmp alltraps
801067d9:	e9 bf f8 ff ff       	jmp    8010609d <alltraps>

801067de <vector75>:
.globl vector75
vector75:
  pushl $0
801067de:	6a 00                	push   $0x0
  pushl $75
801067e0:	6a 4b                	push   $0x4b
  jmp alltraps
801067e2:	e9 b6 f8 ff ff       	jmp    8010609d <alltraps>

801067e7 <vector76>:
.globl vector76
vector76:
  pushl $0
801067e7:	6a 00                	push   $0x0
  pushl $76
801067e9:	6a 4c                	push   $0x4c
  jmp alltraps
801067eb:	e9 ad f8 ff ff       	jmp    8010609d <alltraps>

801067f0 <vector77>:
.globl vector77
vector77:
  pushl $0
801067f0:	6a 00                	push   $0x0
  pushl $77
801067f2:	6a 4d                	push   $0x4d
  jmp alltraps
801067f4:	e9 a4 f8 ff ff       	jmp    8010609d <alltraps>

801067f9 <vector78>:
.globl vector78
vector78:
  pushl $0
801067f9:	6a 00                	push   $0x0
  pushl $78
801067fb:	6a 4e                	push   $0x4e
  jmp alltraps
801067fd:	e9 9b f8 ff ff       	jmp    8010609d <alltraps>

80106802 <vector79>:
.globl vector79
vector79:
  pushl $0
80106802:	6a 00                	push   $0x0
  pushl $79
80106804:	6a 4f                	push   $0x4f
  jmp alltraps
80106806:	e9 92 f8 ff ff       	jmp    8010609d <alltraps>

8010680b <vector80>:
.globl vector80
vector80:
  pushl $0
8010680b:	6a 00                	push   $0x0
  pushl $80
8010680d:	6a 50                	push   $0x50
  jmp alltraps
8010680f:	e9 89 f8 ff ff       	jmp    8010609d <alltraps>

80106814 <vector81>:
.globl vector81
vector81:
  pushl $0
80106814:	6a 00                	push   $0x0
  pushl $81
80106816:	6a 51                	push   $0x51
  jmp alltraps
80106818:	e9 80 f8 ff ff       	jmp    8010609d <alltraps>

8010681d <vector82>:
.globl vector82
vector82:
  pushl $0
8010681d:	6a 00                	push   $0x0
  pushl $82
8010681f:	6a 52                	push   $0x52
  jmp alltraps
80106821:	e9 77 f8 ff ff       	jmp    8010609d <alltraps>

80106826 <vector83>:
.globl vector83
vector83:
  pushl $0
80106826:	6a 00                	push   $0x0
  pushl $83
80106828:	6a 53                	push   $0x53
  jmp alltraps
8010682a:	e9 6e f8 ff ff       	jmp    8010609d <alltraps>

8010682f <vector84>:
.globl vector84
vector84:
  pushl $0
8010682f:	6a 00                	push   $0x0
  pushl $84
80106831:	6a 54                	push   $0x54
  jmp alltraps
80106833:	e9 65 f8 ff ff       	jmp    8010609d <alltraps>

80106838 <vector85>:
.globl vector85
vector85:
  pushl $0
80106838:	6a 00                	push   $0x0
  pushl $85
8010683a:	6a 55                	push   $0x55
  jmp alltraps
8010683c:	e9 5c f8 ff ff       	jmp    8010609d <alltraps>

80106841 <vector86>:
.globl vector86
vector86:
  pushl $0
80106841:	6a 00                	push   $0x0
  pushl $86
80106843:	6a 56                	push   $0x56
  jmp alltraps
80106845:	e9 53 f8 ff ff       	jmp    8010609d <alltraps>

8010684a <vector87>:
.globl vector87
vector87:
  pushl $0
8010684a:	6a 00                	push   $0x0
  pushl $87
8010684c:	6a 57                	push   $0x57
  jmp alltraps
8010684e:	e9 4a f8 ff ff       	jmp    8010609d <alltraps>

80106853 <vector88>:
.globl vector88
vector88:
  pushl $0
80106853:	6a 00                	push   $0x0
  pushl $88
80106855:	6a 58                	push   $0x58
  jmp alltraps
80106857:	e9 41 f8 ff ff       	jmp    8010609d <alltraps>

8010685c <vector89>:
.globl vector89
vector89:
  pushl $0
8010685c:	6a 00                	push   $0x0
  pushl $89
8010685e:	6a 59                	push   $0x59
  jmp alltraps
80106860:	e9 38 f8 ff ff       	jmp    8010609d <alltraps>

80106865 <vector90>:
.globl vector90
vector90:
  pushl $0
80106865:	6a 00                	push   $0x0
  pushl $90
80106867:	6a 5a                	push   $0x5a
  jmp alltraps
80106869:	e9 2f f8 ff ff       	jmp    8010609d <alltraps>

8010686e <vector91>:
.globl vector91
vector91:
  pushl $0
8010686e:	6a 00                	push   $0x0
  pushl $91
80106870:	6a 5b                	push   $0x5b
  jmp alltraps
80106872:	e9 26 f8 ff ff       	jmp    8010609d <alltraps>

80106877 <vector92>:
.globl vector92
vector92:
  pushl $0
80106877:	6a 00                	push   $0x0
  pushl $92
80106879:	6a 5c                	push   $0x5c
  jmp alltraps
8010687b:	e9 1d f8 ff ff       	jmp    8010609d <alltraps>

80106880 <vector93>:
.globl vector93
vector93:
  pushl $0
80106880:	6a 00                	push   $0x0
  pushl $93
80106882:	6a 5d                	push   $0x5d
  jmp alltraps
80106884:	e9 14 f8 ff ff       	jmp    8010609d <alltraps>

80106889 <vector94>:
.globl vector94
vector94:
  pushl $0
80106889:	6a 00                	push   $0x0
  pushl $94
8010688b:	6a 5e                	push   $0x5e
  jmp alltraps
8010688d:	e9 0b f8 ff ff       	jmp    8010609d <alltraps>

80106892 <vector95>:
.globl vector95
vector95:
  pushl $0
80106892:	6a 00                	push   $0x0
  pushl $95
80106894:	6a 5f                	push   $0x5f
  jmp alltraps
80106896:	e9 02 f8 ff ff       	jmp    8010609d <alltraps>

8010689b <vector96>:
.globl vector96
vector96:
  pushl $0
8010689b:	6a 00                	push   $0x0
  pushl $96
8010689d:	6a 60                	push   $0x60
  jmp alltraps
8010689f:	e9 f9 f7 ff ff       	jmp    8010609d <alltraps>

801068a4 <vector97>:
.globl vector97
vector97:
  pushl $0
801068a4:	6a 00                	push   $0x0
  pushl $97
801068a6:	6a 61                	push   $0x61
  jmp alltraps
801068a8:	e9 f0 f7 ff ff       	jmp    8010609d <alltraps>

801068ad <vector98>:
.globl vector98
vector98:
  pushl $0
801068ad:	6a 00                	push   $0x0
  pushl $98
801068af:	6a 62                	push   $0x62
  jmp alltraps
801068b1:	e9 e7 f7 ff ff       	jmp    8010609d <alltraps>

801068b6 <vector99>:
.globl vector99
vector99:
  pushl $0
801068b6:	6a 00                	push   $0x0
  pushl $99
801068b8:	6a 63                	push   $0x63
  jmp alltraps
801068ba:	e9 de f7 ff ff       	jmp    8010609d <alltraps>

801068bf <vector100>:
.globl vector100
vector100:
  pushl $0
801068bf:	6a 00                	push   $0x0
  pushl $100
801068c1:	6a 64                	push   $0x64
  jmp alltraps
801068c3:	e9 d5 f7 ff ff       	jmp    8010609d <alltraps>

801068c8 <vector101>:
.globl vector101
vector101:
  pushl $0
801068c8:	6a 00                	push   $0x0
  pushl $101
801068ca:	6a 65                	push   $0x65
  jmp alltraps
801068cc:	e9 cc f7 ff ff       	jmp    8010609d <alltraps>

801068d1 <vector102>:
.globl vector102
vector102:
  pushl $0
801068d1:	6a 00                	push   $0x0
  pushl $102
801068d3:	6a 66                	push   $0x66
  jmp alltraps
801068d5:	e9 c3 f7 ff ff       	jmp    8010609d <alltraps>

801068da <vector103>:
.globl vector103
vector103:
  pushl $0
801068da:	6a 00                	push   $0x0
  pushl $103
801068dc:	6a 67                	push   $0x67
  jmp alltraps
801068de:	e9 ba f7 ff ff       	jmp    8010609d <alltraps>

801068e3 <vector104>:
.globl vector104
vector104:
  pushl $0
801068e3:	6a 00                	push   $0x0
  pushl $104
801068e5:	6a 68                	push   $0x68
  jmp alltraps
801068e7:	e9 b1 f7 ff ff       	jmp    8010609d <alltraps>

801068ec <vector105>:
.globl vector105
vector105:
  pushl $0
801068ec:	6a 00                	push   $0x0
  pushl $105
801068ee:	6a 69                	push   $0x69
  jmp alltraps
801068f0:	e9 a8 f7 ff ff       	jmp    8010609d <alltraps>

801068f5 <vector106>:
.globl vector106
vector106:
  pushl $0
801068f5:	6a 00                	push   $0x0
  pushl $106
801068f7:	6a 6a                	push   $0x6a
  jmp alltraps
801068f9:	e9 9f f7 ff ff       	jmp    8010609d <alltraps>

801068fe <vector107>:
.globl vector107
vector107:
  pushl $0
801068fe:	6a 00                	push   $0x0
  pushl $107
80106900:	6a 6b                	push   $0x6b
  jmp alltraps
80106902:	e9 96 f7 ff ff       	jmp    8010609d <alltraps>

80106907 <vector108>:
.globl vector108
vector108:
  pushl $0
80106907:	6a 00                	push   $0x0
  pushl $108
80106909:	6a 6c                	push   $0x6c
  jmp alltraps
8010690b:	e9 8d f7 ff ff       	jmp    8010609d <alltraps>

80106910 <vector109>:
.globl vector109
vector109:
  pushl $0
80106910:	6a 00                	push   $0x0
  pushl $109
80106912:	6a 6d                	push   $0x6d
  jmp alltraps
80106914:	e9 84 f7 ff ff       	jmp    8010609d <alltraps>

80106919 <vector110>:
.globl vector110
vector110:
  pushl $0
80106919:	6a 00                	push   $0x0
  pushl $110
8010691b:	6a 6e                	push   $0x6e
  jmp alltraps
8010691d:	e9 7b f7 ff ff       	jmp    8010609d <alltraps>

80106922 <vector111>:
.globl vector111
vector111:
  pushl $0
80106922:	6a 00                	push   $0x0
  pushl $111
80106924:	6a 6f                	push   $0x6f
  jmp alltraps
80106926:	e9 72 f7 ff ff       	jmp    8010609d <alltraps>

8010692b <vector112>:
.globl vector112
vector112:
  pushl $0
8010692b:	6a 00                	push   $0x0
  pushl $112
8010692d:	6a 70                	push   $0x70
  jmp alltraps
8010692f:	e9 69 f7 ff ff       	jmp    8010609d <alltraps>

80106934 <vector113>:
.globl vector113
vector113:
  pushl $0
80106934:	6a 00                	push   $0x0
  pushl $113
80106936:	6a 71                	push   $0x71
  jmp alltraps
80106938:	e9 60 f7 ff ff       	jmp    8010609d <alltraps>

8010693d <vector114>:
.globl vector114
vector114:
  pushl $0
8010693d:	6a 00                	push   $0x0
  pushl $114
8010693f:	6a 72                	push   $0x72
  jmp alltraps
80106941:	e9 57 f7 ff ff       	jmp    8010609d <alltraps>

80106946 <vector115>:
.globl vector115
vector115:
  pushl $0
80106946:	6a 00                	push   $0x0
  pushl $115
80106948:	6a 73                	push   $0x73
  jmp alltraps
8010694a:	e9 4e f7 ff ff       	jmp    8010609d <alltraps>

8010694f <vector116>:
.globl vector116
vector116:
  pushl $0
8010694f:	6a 00                	push   $0x0
  pushl $116
80106951:	6a 74                	push   $0x74
  jmp alltraps
80106953:	e9 45 f7 ff ff       	jmp    8010609d <alltraps>

80106958 <vector117>:
.globl vector117
vector117:
  pushl $0
80106958:	6a 00                	push   $0x0
  pushl $117
8010695a:	6a 75                	push   $0x75
  jmp alltraps
8010695c:	e9 3c f7 ff ff       	jmp    8010609d <alltraps>

80106961 <vector118>:
.globl vector118
vector118:
  pushl $0
80106961:	6a 00                	push   $0x0
  pushl $118
80106963:	6a 76                	push   $0x76
  jmp alltraps
80106965:	e9 33 f7 ff ff       	jmp    8010609d <alltraps>

8010696a <vector119>:
.globl vector119
vector119:
  pushl $0
8010696a:	6a 00                	push   $0x0
  pushl $119
8010696c:	6a 77                	push   $0x77
  jmp alltraps
8010696e:	e9 2a f7 ff ff       	jmp    8010609d <alltraps>

80106973 <vector120>:
.globl vector120
vector120:
  pushl $0
80106973:	6a 00                	push   $0x0
  pushl $120
80106975:	6a 78                	push   $0x78
  jmp alltraps
80106977:	e9 21 f7 ff ff       	jmp    8010609d <alltraps>

8010697c <vector121>:
.globl vector121
vector121:
  pushl $0
8010697c:	6a 00                	push   $0x0
  pushl $121
8010697e:	6a 79                	push   $0x79
  jmp alltraps
80106980:	e9 18 f7 ff ff       	jmp    8010609d <alltraps>

80106985 <vector122>:
.globl vector122
vector122:
  pushl $0
80106985:	6a 00                	push   $0x0
  pushl $122
80106987:	6a 7a                	push   $0x7a
  jmp alltraps
80106989:	e9 0f f7 ff ff       	jmp    8010609d <alltraps>

8010698e <vector123>:
.globl vector123
vector123:
  pushl $0
8010698e:	6a 00                	push   $0x0
  pushl $123
80106990:	6a 7b                	push   $0x7b
  jmp alltraps
80106992:	e9 06 f7 ff ff       	jmp    8010609d <alltraps>

80106997 <vector124>:
.globl vector124
vector124:
  pushl $0
80106997:	6a 00                	push   $0x0
  pushl $124
80106999:	6a 7c                	push   $0x7c
  jmp alltraps
8010699b:	e9 fd f6 ff ff       	jmp    8010609d <alltraps>

801069a0 <vector125>:
.globl vector125
vector125:
  pushl $0
801069a0:	6a 00                	push   $0x0
  pushl $125
801069a2:	6a 7d                	push   $0x7d
  jmp alltraps
801069a4:	e9 f4 f6 ff ff       	jmp    8010609d <alltraps>

801069a9 <vector126>:
.globl vector126
vector126:
  pushl $0
801069a9:	6a 00                	push   $0x0
  pushl $126
801069ab:	6a 7e                	push   $0x7e
  jmp alltraps
801069ad:	e9 eb f6 ff ff       	jmp    8010609d <alltraps>

801069b2 <vector127>:
.globl vector127
vector127:
  pushl $0
801069b2:	6a 00                	push   $0x0
  pushl $127
801069b4:	6a 7f                	push   $0x7f
  jmp alltraps
801069b6:	e9 e2 f6 ff ff       	jmp    8010609d <alltraps>

801069bb <vector128>:
.globl vector128
vector128:
  pushl $0
801069bb:	6a 00                	push   $0x0
  pushl $128
801069bd:	68 80 00 00 00       	push   $0x80
  jmp alltraps
801069c2:	e9 d6 f6 ff ff       	jmp    8010609d <alltraps>

801069c7 <vector129>:
.globl vector129
vector129:
  pushl $0
801069c7:	6a 00                	push   $0x0
  pushl $129
801069c9:	68 81 00 00 00       	push   $0x81
  jmp alltraps
801069ce:	e9 ca f6 ff ff       	jmp    8010609d <alltraps>

801069d3 <vector130>:
.globl vector130
vector130:
  pushl $0
801069d3:	6a 00                	push   $0x0
  pushl $130
801069d5:	68 82 00 00 00       	push   $0x82
  jmp alltraps
801069da:	e9 be f6 ff ff       	jmp    8010609d <alltraps>

801069df <vector131>:
.globl vector131
vector131:
  pushl $0
801069df:	6a 00                	push   $0x0
  pushl $131
801069e1:	68 83 00 00 00       	push   $0x83
  jmp alltraps
801069e6:	e9 b2 f6 ff ff       	jmp    8010609d <alltraps>

801069eb <vector132>:
.globl vector132
vector132:
  pushl $0
801069eb:	6a 00                	push   $0x0
  pushl $132
801069ed:	68 84 00 00 00       	push   $0x84
  jmp alltraps
801069f2:	e9 a6 f6 ff ff       	jmp    8010609d <alltraps>

801069f7 <vector133>:
.globl vector133
vector133:
  pushl $0
801069f7:	6a 00                	push   $0x0
  pushl $133
801069f9:	68 85 00 00 00       	push   $0x85
  jmp alltraps
801069fe:	e9 9a f6 ff ff       	jmp    8010609d <alltraps>

80106a03 <vector134>:
.globl vector134
vector134:
  pushl $0
80106a03:	6a 00                	push   $0x0
  pushl $134
80106a05:	68 86 00 00 00       	push   $0x86
  jmp alltraps
80106a0a:	e9 8e f6 ff ff       	jmp    8010609d <alltraps>

80106a0f <vector135>:
.globl vector135
vector135:
  pushl $0
80106a0f:	6a 00                	push   $0x0
  pushl $135
80106a11:	68 87 00 00 00       	push   $0x87
  jmp alltraps
80106a16:	e9 82 f6 ff ff       	jmp    8010609d <alltraps>

80106a1b <vector136>:
.globl vector136
vector136:
  pushl $0
80106a1b:	6a 00                	push   $0x0
  pushl $136
80106a1d:	68 88 00 00 00       	push   $0x88
  jmp alltraps
80106a22:	e9 76 f6 ff ff       	jmp    8010609d <alltraps>

80106a27 <vector137>:
.globl vector137
vector137:
  pushl $0
80106a27:	6a 00                	push   $0x0
  pushl $137
80106a29:	68 89 00 00 00       	push   $0x89
  jmp alltraps
80106a2e:	e9 6a f6 ff ff       	jmp    8010609d <alltraps>

80106a33 <vector138>:
.globl vector138
vector138:
  pushl $0
80106a33:	6a 00                	push   $0x0
  pushl $138
80106a35:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
80106a3a:	e9 5e f6 ff ff       	jmp    8010609d <alltraps>

80106a3f <vector139>:
.globl vector139
vector139:
  pushl $0
80106a3f:	6a 00                	push   $0x0
  pushl $139
80106a41:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
80106a46:	e9 52 f6 ff ff       	jmp    8010609d <alltraps>

80106a4b <vector140>:
.globl vector140
vector140:
  pushl $0
80106a4b:	6a 00                	push   $0x0
  pushl $140
80106a4d:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
80106a52:	e9 46 f6 ff ff       	jmp    8010609d <alltraps>

80106a57 <vector141>:
.globl vector141
vector141:
  pushl $0
80106a57:	6a 00                	push   $0x0
  pushl $141
80106a59:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
80106a5e:	e9 3a f6 ff ff       	jmp    8010609d <alltraps>

80106a63 <vector142>:
.globl vector142
vector142:
  pushl $0
80106a63:	6a 00                	push   $0x0
  pushl $142
80106a65:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
80106a6a:	e9 2e f6 ff ff       	jmp    8010609d <alltraps>

80106a6f <vector143>:
.globl vector143
vector143:
  pushl $0
80106a6f:	6a 00                	push   $0x0
  pushl $143
80106a71:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
80106a76:	e9 22 f6 ff ff       	jmp    8010609d <alltraps>

80106a7b <vector144>:
.globl vector144
vector144:
  pushl $0
80106a7b:	6a 00                	push   $0x0
  pushl $144
80106a7d:	68 90 00 00 00       	push   $0x90
  jmp alltraps
80106a82:	e9 16 f6 ff ff       	jmp    8010609d <alltraps>

80106a87 <vector145>:
.globl vector145
vector145:
  pushl $0
80106a87:	6a 00                	push   $0x0
  pushl $145
80106a89:	68 91 00 00 00       	push   $0x91
  jmp alltraps
80106a8e:	e9 0a f6 ff ff       	jmp    8010609d <alltraps>

80106a93 <vector146>:
.globl vector146
vector146:
  pushl $0
80106a93:	6a 00                	push   $0x0
  pushl $146
80106a95:	68 92 00 00 00       	push   $0x92
  jmp alltraps
80106a9a:	e9 fe f5 ff ff       	jmp    8010609d <alltraps>

80106a9f <vector147>:
.globl vector147
vector147:
  pushl $0
80106a9f:	6a 00                	push   $0x0
  pushl $147
80106aa1:	68 93 00 00 00       	push   $0x93
  jmp alltraps
80106aa6:	e9 f2 f5 ff ff       	jmp    8010609d <alltraps>

80106aab <vector148>:
.globl vector148
vector148:
  pushl $0
80106aab:	6a 00                	push   $0x0
  pushl $148
80106aad:	68 94 00 00 00       	push   $0x94
  jmp alltraps
80106ab2:	e9 e6 f5 ff ff       	jmp    8010609d <alltraps>

80106ab7 <vector149>:
.globl vector149
vector149:
  pushl $0
80106ab7:	6a 00                	push   $0x0
  pushl $149
80106ab9:	68 95 00 00 00       	push   $0x95
  jmp alltraps
80106abe:	e9 da f5 ff ff       	jmp    8010609d <alltraps>

80106ac3 <vector150>:
.globl vector150
vector150:
  pushl $0
80106ac3:	6a 00                	push   $0x0
  pushl $150
80106ac5:	68 96 00 00 00       	push   $0x96
  jmp alltraps
80106aca:	e9 ce f5 ff ff       	jmp    8010609d <alltraps>

80106acf <vector151>:
.globl vector151
vector151:
  pushl $0
80106acf:	6a 00                	push   $0x0
  pushl $151
80106ad1:	68 97 00 00 00       	push   $0x97
  jmp alltraps
80106ad6:	e9 c2 f5 ff ff       	jmp    8010609d <alltraps>

80106adb <vector152>:
.globl vector152
vector152:
  pushl $0
80106adb:	6a 00                	push   $0x0
  pushl $152
80106add:	68 98 00 00 00       	push   $0x98
  jmp alltraps
80106ae2:	e9 b6 f5 ff ff       	jmp    8010609d <alltraps>

80106ae7 <vector153>:
.globl vector153
vector153:
  pushl $0
80106ae7:	6a 00                	push   $0x0
  pushl $153
80106ae9:	68 99 00 00 00       	push   $0x99
  jmp alltraps
80106aee:	e9 aa f5 ff ff       	jmp    8010609d <alltraps>

80106af3 <vector154>:
.globl vector154
vector154:
  pushl $0
80106af3:	6a 00                	push   $0x0
  pushl $154
80106af5:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
80106afa:	e9 9e f5 ff ff       	jmp    8010609d <alltraps>

80106aff <vector155>:
.globl vector155
vector155:
  pushl $0
80106aff:	6a 00                	push   $0x0
  pushl $155
80106b01:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
80106b06:	e9 92 f5 ff ff       	jmp    8010609d <alltraps>

80106b0b <vector156>:
.globl vector156
vector156:
  pushl $0
80106b0b:	6a 00                	push   $0x0
  pushl $156
80106b0d:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
80106b12:	e9 86 f5 ff ff       	jmp    8010609d <alltraps>

80106b17 <vector157>:
.globl vector157
vector157:
  pushl $0
80106b17:	6a 00                	push   $0x0
  pushl $157
80106b19:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
80106b1e:	e9 7a f5 ff ff       	jmp    8010609d <alltraps>

80106b23 <vector158>:
.globl vector158
vector158:
  pushl $0
80106b23:	6a 00                	push   $0x0
  pushl $158
80106b25:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
80106b2a:	e9 6e f5 ff ff       	jmp    8010609d <alltraps>

80106b2f <vector159>:
.globl vector159
vector159:
  pushl $0
80106b2f:	6a 00                	push   $0x0
  pushl $159
80106b31:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
80106b36:	e9 62 f5 ff ff       	jmp    8010609d <alltraps>

80106b3b <vector160>:
.globl vector160
vector160:
  pushl $0
80106b3b:	6a 00                	push   $0x0
  pushl $160
80106b3d:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
80106b42:	e9 56 f5 ff ff       	jmp    8010609d <alltraps>

80106b47 <vector161>:
.globl vector161
vector161:
  pushl $0
80106b47:	6a 00                	push   $0x0
  pushl $161
80106b49:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
80106b4e:	e9 4a f5 ff ff       	jmp    8010609d <alltraps>

80106b53 <vector162>:
.globl vector162
vector162:
  pushl $0
80106b53:	6a 00                	push   $0x0
  pushl $162
80106b55:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
80106b5a:	e9 3e f5 ff ff       	jmp    8010609d <alltraps>

80106b5f <vector163>:
.globl vector163
vector163:
  pushl $0
80106b5f:	6a 00                	push   $0x0
  pushl $163
80106b61:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
80106b66:	e9 32 f5 ff ff       	jmp    8010609d <alltraps>

80106b6b <vector164>:
.globl vector164
vector164:
  pushl $0
80106b6b:	6a 00                	push   $0x0
  pushl $164
80106b6d:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
80106b72:	e9 26 f5 ff ff       	jmp    8010609d <alltraps>

80106b77 <vector165>:
.globl vector165
vector165:
  pushl $0
80106b77:	6a 00                	push   $0x0
  pushl $165
80106b79:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
80106b7e:	e9 1a f5 ff ff       	jmp    8010609d <alltraps>

80106b83 <vector166>:
.globl vector166
vector166:
  pushl $0
80106b83:	6a 00                	push   $0x0
  pushl $166
80106b85:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
80106b8a:	e9 0e f5 ff ff       	jmp    8010609d <alltraps>

80106b8f <vector167>:
.globl vector167
vector167:
  pushl $0
80106b8f:	6a 00                	push   $0x0
  pushl $167
80106b91:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
80106b96:	e9 02 f5 ff ff       	jmp    8010609d <alltraps>

80106b9b <vector168>:
.globl vector168
vector168:
  pushl $0
80106b9b:	6a 00                	push   $0x0
  pushl $168
80106b9d:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
80106ba2:	e9 f6 f4 ff ff       	jmp    8010609d <alltraps>

80106ba7 <vector169>:
.globl vector169
vector169:
  pushl $0
80106ba7:	6a 00                	push   $0x0
  pushl $169
80106ba9:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
80106bae:	e9 ea f4 ff ff       	jmp    8010609d <alltraps>

80106bb3 <vector170>:
.globl vector170
vector170:
  pushl $0
80106bb3:	6a 00                	push   $0x0
  pushl $170
80106bb5:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
80106bba:	e9 de f4 ff ff       	jmp    8010609d <alltraps>

80106bbf <vector171>:
.globl vector171
vector171:
  pushl $0
80106bbf:	6a 00                	push   $0x0
  pushl $171
80106bc1:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
80106bc6:	e9 d2 f4 ff ff       	jmp    8010609d <alltraps>

80106bcb <vector172>:
.globl vector172
vector172:
  pushl $0
80106bcb:	6a 00                	push   $0x0
  pushl $172
80106bcd:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
80106bd2:	e9 c6 f4 ff ff       	jmp    8010609d <alltraps>

80106bd7 <vector173>:
.globl vector173
vector173:
  pushl $0
80106bd7:	6a 00                	push   $0x0
  pushl $173
80106bd9:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
80106bde:	e9 ba f4 ff ff       	jmp    8010609d <alltraps>

80106be3 <vector174>:
.globl vector174
vector174:
  pushl $0
80106be3:	6a 00                	push   $0x0
  pushl $174
80106be5:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
80106bea:	e9 ae f4 ff ff       	jmp    8010609d <alltraps>

80106bef <vector175>:
.globl vector175
vector175:
  pushl $0
80106bef:	6a 00                	push   $0x0
  pushl $175
80106bf1:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
80106bf6:	e9 a2 f4 ff ff       	jmp    8010609d <alltraps>

80106bfb <vector176>:
.globl vector176
vector176:
  pushl $0
80106bfb:	6a 00                	push   $0x0
  pushl $176
80106bfd:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
80106c02:	e9 96 f4 ff ff       	jmp    8010609d <alltraps>

80106c07 <vector177>:
.globl vector177
vector177:
  pushl $0
80106c07:	6a 00                	push   $0x0
  pushl $177
80106c09:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
80106c0e:	e9 8a f4 ff ff       	jmp    8010609d <alltraps>

80106c13 <vector178>:
.globl vector178
vector178:
  pushl $0
80106c13:	6a 00                	push   $0x0
  pushl $178
80106c15:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
80106c1a:	e9 7e f4 ff ff       	jmp    8010609d <alltraps>

80106c1f <vector179>:
.globl vector179
vector179:
  pushl $0
80106c1f:	6a 00                	push   $0x0
  pushl $179
80106c21:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
80106c26:	e9 72 f4 ff ff       	jmp    8010609d <alltraps>

80106c2b <vector180>:
.globl vector180
vector180:
  pushl $0
80106c2b:	6a 00                	push   $0x0
  pushl $180
80106c2d:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
80106c32:	e9 66 f4 ff ff       	jmp    8010609d <alltraps>

80106c37 <vector181>:
.globl vector181
vector181:
  pushl $0
80106c37:	6a 00                	push   $0x0
  pushl $181
80106c39:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
80106c3e:	e9 5a f4 ff ff       	jmp    8010609d <alltraps>

80106c43 <vector182>:
.globl vector182
vector182:
  pushl $0
80106c43:	6a 00                	push   $0x0
  pushl $182
80106c45:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
80106c4a:	e9 4e f4 ff ff       	jmp    8010609d <alltraps>

80106c4f <vector183>:
.globl vector183
vector183:
  pushl $0
80106c4f:	6a 00                	push   $0x0
  pushl $183
80106c51:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
80106c56:	e9 42 f4 ff ff       	jmp    8010609d <alltraps>

80106c5b <vector184>:
.globl vector184
vector184:
  pushl $0
80106c5b:	6a 00                	push   $0x0
  pushl $184
80106c5d:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
80106c62:	e9 36 f4 ff ff       	jmp    8010609d <alltraps>

80106c67 <vector185>:
.globl vector185
vector185:
  pushl $0
80106c67:	6a 00                	push   $0x0
  pushl $185
80106c69:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
80106c6e:	e9 2a f4 ff ff       	jmp    8010609d <alltraps>

80106c73 <vector186>:
.globl vector186
vector186:
  pushl $0
80106c73:	6a 00                	push   $0x0
  pushl $186
80106c75:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
80106c7a:	e9 1e f4 ff ff       	jmp    8010609d <alltraps>

80106c7f <vector187>:
.globl vector187
vector187:
  pushl $0
80106c7f:	6a 00                	push   $0x0
  pushl $187
80106c81:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
80106c86:	e9 12 f4 ff ff       	jmp    8010609d <alltraps>

80106c8b <vector188>:
.globl vector188
vector188:
  pushl $0
80106c8b:	6a 00                	push   $0x0
  pushl $188
80106c8d:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
80106c92:	e9 06 f4 ff ff       	jmp    8010609d <alltraps>

80106c97 <vector189>:
.globl vector189
vector189:
  pushl $0
80106c97:	6a 00                	push   $0x0
  pushl $189
80106c99:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
80106c9e:	e9 fa f3 ff ff       	jmp    8010609d <alltraps>

80106ca3 <vector190>:
.globl vector190
vector190:
  pushl $0
80106ca3:	6a 00                	push   $0x0
  pushl $190
80106ca5:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
80106caa:	e9 ee f3 ff ff       	jmp    8010609d <alltraps>

80106caf <vector191>:
.globl vector191
vector191:
  pushl $0
80106caf:	6a 00                	push   $0x0
  pushl $191
80106cb1:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
80106cb6:	e9 e2 f3 ff ff       	jmp    8010609d <alltraps>

80106cbb <vector192>:
.globl vector192
vector192:
  pushl $0
80106cbb:	6a 00                	push   $0x0
  pushl $192
80106cbd:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
80106cc2:	e9 d6 f3 ff ff       	jmp    8010609d <alltraps>

80106cc7 <vector193>:
.globl vector193
vector193:
  pushl $0
80106cc7:	6a 00                	push   $0x0
  pushl $193
80106cc9:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
80106cce:	e9 ca f3 ff ff       	jmp    8010609d <alltraps>

80106cd3 <vector194>:
.globl vector194
vector194:
  pushl $0
80106cd3:	6a 00                	push   $0x0
  pushl $194
80106cd5:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
80106cda:	e9 be f3 ff ff       	jmp    8010609d <alltraps>

80106cdf <vector195>:
.globl vector195
vector195:
  pushl $0
80106cdf:	6a 00                	push   $0x0
  pushl $195
80106ce1:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
80106ce6:	e9 b2 f3 ff ff       	jmp    8010609d <alltraps>

80106ceb <vector196>:
.globl vector196
vector196:
  pushl $0
80106ceb:	6a 00                	push   $0x0
  pushl $196
80106ced:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
80106cf2:	e9 a6 f3 ff ff       	jmp    8010609d <alltraps>

80106cf7 <vector197>:
.globl vector197
vector197:
  pushl $0
80106cf7:	6a 00                	push   $0x0
  pushl $197
80106cf9:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
80106cfe:	e9 9a f3 ff ff       	jmp    8010609d <alltraps>

80106d03 <vector198>:
.globl vector198
vector198:
  pushl $0
80106d03:	6a 00                	push   $0x0
  pushl $198
80106d05:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
80106d0a:	e9 8e f3 ff ff       	jmp    8010609d <alltraps>

80106d0f <vector199>:
.globl vector199
vector199:
  pushl $0
80106d0f:	6a 00                	push   $0x0
  pushl $199
80106d11:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
80106d16:	e9 82 f3 ff ff       	jmp    8010609d <alltraps>

80106d1b <vector200>:
.globl vector200
vector200:
  pushl $0
80106d1b:	6a 00                	push   $0x0
  pushl $200
80106d1d:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
80106d22:	e9 76 f3 ff ff       	jmp    8010609d <alltraps>

80106d27 <vector201>:
.globl vector201
vector201:
  pushl $0
80106d27:	6a 00                	push   $0x0
  pushl $201
80106d29:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
80106d2e:	e9 6a f3 ff ff       	jmp    8010609d <alltraps>

80106d33 <vector202>:
.globl vector202
vector202:
  pushl $0
80106d33:	6a 00                	push   $0x0
  pushl $202
80106d35:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
80106d3a:	e9 5e f3 ff ff       	jmp    8010609d <alltraps>

80106d3f <vector203>:
.globl vector203
vector203:
  pushl $0
80106d3f:	6a 00                	push   $0x0
  pushl $203
80106d41:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
80106d46:	e9 52 f3 ff ff       	jmp    8010609d <alltraps>

80106d4b <vector204>:
.globl vector204
vector204:
  pushl $0
80106d4b:	6a 00                	push   $0x0
  pushl $204
80106d4d:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
80106d52:	e9 46 f3 ff ff       	jmp    8010609d <alltraps>

80106d57 <vector205>:
.globl vector205
vector205:
  pushl $0
80106d57:	6a 00                	push   $0x0
  pushl $205
80106d59:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
80106d5e:	e9 3a f3 ff ff       	jmp    8010609d <alltraps>

80106d63 <vector206>:
.globl vector206
vector206:
  pushl $0
80106d63:	6a 00                	push   $0x0
  pushl $206
80106d65:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
80106d6a:	e9 2e f3 ff ff       	jmp    8010609d <alltraps>

80106d6f <vector207>:
.globl vector207
vector207:
  pushl $0
80106d6f:	6a 00                	push   $0x0
  pushl $207
80106d71:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
80106d76:	e9 22 f3 ff ff       	jmp    8010609d <alltraps>

80106d7b <vector208>:
.globl vector208
vector208:
  pushl $0
80106d7b:	6a 00                	push   $0x0
  pushl $208
80106d7d:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
80106d82:	e9 16 f3 ff ff       	jmp    8010609d <alltraps>

80106d87 <vector209>:
.globl vector209
vector209:
  pushl $0
80106d87:	6a 00                	push   $0x0
  pushl $209
80106d89:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
80106d8e:	e9 0a f3 ff ff       	jmp    8010609d <alltraps>

80106d93 <vector210>:
.globl vector210
vector210:
  pushl $0
80106d93:	6a 00                	push   $0x0
  pushl $210
80106d95:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80106d9a:	e9 fe f2 ff ff       	jmp    8010609d <alltraps>

80106d9f <vector211>:
.globl vector211
vector211:
  pushl $0
80106d9f:	6a 00                	push   $0x0
  pushl $211
80106da1:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80106da6:	e9 f2 f2 ff ff       	jmp    8010609d <alltraps>

80106dab <vector212>:
.globl vector212
vector212:
  pushl $0
80106dab:	6a 00                	push   $0x0
  pushl $212
80106dad:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
80106db2:	e9 e6 f2 ff ff       	jmp    8010609d <alltraps>

80106db7 <vector213>:
.globl vector213
vector213:
  pushl $0
80106db7:	6a 00                	push   $0x0
  pushl $213
80106db9:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
80106dbe:	e9 da f2 ff ff       	jmp    8010609d <alltraps>

80106dc3 <vector214>:
.globl vector214
vector214:
  pushl $0
80106dc3:	6a 00                	push   $0x0
  pushl $214
80106dc5:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80106dca:	e9 ce f2 ff ff       	jmp    8010609d <alltraps>

80106dcf <vector215>:
.globl vector215
vector215:
  pushl $0
80106dcf:	6a 00                	push   $0x0
  pushl $215
80106dd1:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80106dd6:	e9 c2 f2 ff ff       	jmp    8010609d <alltraps>

80106ddb <vector216>:
.globl vector216
vector216:
  pushl $0
80106ddb:	6a 00                	push   $0x0
  pushl $216
80106ddd:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
80106de2:	e9 b6 f2 ff ff       	jmp    8010609d <alltraps>

80106de7 <vector217>:
.globl vector217
vector217:
  pushl $0
80106de7:	6a 00                	push   $0x0
  pushl $217
80106de9:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
80106dee:	e9 aa f2 ff ff       	jmp    8010609d <alltraps>

80106df3 <vector218>:
.globl vector218
vector218:
  pushl $0
80106df3:	6a 00                	push   $0x0
  pushl $218
80106df5:	68 da 00 00 00       	push   $0xda
  jmp alltraps
80106dfa:	e9 9e f2 ff ff       	jmp    8010609d <alltraps>

80106dff <vector219>:
.globl vector219
vector219:
  pushl $0
80106dff:	6a 00                	push   $0x0
  pushl $219
80106e01:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
80106e06:	e9 92 f2 ff ff       	jmp    8010609d <alltraps>

80106e0b <vector220>:
.globl vector220
vector220:
  pushl $0
80106e0b:	6a 00                	push   $0x0
  pushl $220
80106e0d:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
80106e12:	e9 86 f2 ff ff       	jmp    8010609d <alltraps>

80106e17 <vector221>:
.globl vector221
vector221:
  pushl $0
80106e17:	6a 00                	push   $0x0
  pushl $221
80106e19:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
80106e1e:	e9 7a f2 ff ff       	jmp    8010609d <alltraps>

80106e23 <vector222>:
.globl vector222
vector222:
  pushl $0
80106e23:	6a 00                	push   $0x0
  pushl $222
80106e25:	68 de 00 00 00       	push   $0xde
  jmp alltraps
80106e2a:	e9 6e f2 ff ff       	jmp    8010609d <alltraps>

80106e2f <vector223>:
.globl vector223
vector223:
  pushl $0
80106e2f:	6a 00                	push   $0x0
  pushl $223
80106e31:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
80106e36:	e9 62 f2 ff ff       	jmp    8010609d <alltraps>

80106e3b <vector224>:
.globl vector224
vector224:
  pushl $0
80106e3b:	6a 00                	push   $0x0
  pushl $224
80106e3d:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
80106e42:	e9 56 f2 ff ff       	jmp    8010609d <alltraps>

80106e47 <vector225>:
.globl vector225
vector225:
  pushl $0
80106e47:	6a 00                	push   $0x0
  pushl $225
80106e49:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
80106e4e:	e9 4a f2 ff ff       	jmp    8010609d <alltraps>

80106e53 <vector226>:
.globl vector226
vector226:
  pushl $0
80106e53:	6a 00                	push   $0x0
  pushl $226
80106e55:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
80106e5a:	e9 3e f2 ff ff       	jmp    8010609d <alltraps>

80106e5f <vector227>:
.globl vector227
vector227:
  pushl $0
80106e5f:	6a 00                	push   $0x0
  pushl $227
80106e61:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
80106e66:	e9 32 f2 ff ff       	jmp    8010609d <alltraps>

80106e6b <vector228>:
.globl vector228
vector228:
  pushl $0
80106e6b:	6a 00                	push   $0x0
  pushl $228
80106e6d:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
80106e72:	e9 26 f2 ff ff       	jmp    8010609d <alltraps>

80106e77 <vector229>:
.globl vector229
vector229:
  pushl $0
80106e77:	6a 00                	push   $0x0
  pushl $229
80106e79:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
80106e7e:	e9 1a f2 ff ff       	jmp    8010609d <alltraps>

80106e83 <vector230>:
.globl vector230
vector230:
  pushl $0
80106e83:	6a 00                	push   $0x0
  pushl $230
80106e85:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80106e8a:	e9 0e f2 ff ff       	jmp    8010609d <alltraps>

80106e8f <vector231>:
.globl vector231
vector231:
  pushl $0
80106e8f:	6a 00                	push   $0x0
  pushl $231
80106e91:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80106e96:	e9 02 f2 ff ff       	jmp    8010609d <alltraps>

80106e9b <vector232>:
.globl vector232
vector232:
  pushl $0
80106e9b:	6a 00                	push   $0x0
  pushl $232
80106e9d:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
80106ea2:	e9 f6 f1 ff ff       	jmp    8010609d <alltraps>

80106ea7 <vector233>:
.globl vector233
vector233:
  pushl $0
80106ea7:	6a 00                	push   $0x0
  pushl $233
80106ea9:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
80106eae:	e9 ea f1 ff ff       	jmp    8010609d <alltraps>

80106eb3 <vector234>:
.globl vector234
vector234:
  pushl $0
80106eb3:	6a 00                	push   $0x0
  pushl $234
80106eb5:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80106eba:	e9 de f1 ff ff       	jmp    8010609d <alltraps>

80106ebf <vector235>:
.globl vector235
vector235:
  pushl $0
80106ebf:	6a 00                	push   $0x0
  pushl $235
80106ec1:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80106ec6:	e9 d2 f1 ff ff       	jmp    8010609d <alltraps>

80106ecb <vector236>:
.globl vector236
vector236:
  pushl $0
80106ecb:	6a 00                	push   $0x0
  pushl $236
80106ecd:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
80106ed2:	e9 c6 f1 ff ff       	jmp    8010609d <alltraps>

80106ed7 <vector237>:
.globl vector237
vector237:
  pushl $0
80106ed7:	6a 00                	push   $0x0
  pushl $237
80106ed9:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
80106ede:	e9 ba f1 ff ff       	jmp    8010609d <alltraps>

80106ee3 <vector238>:
.globl vector238
vector238:
  pushl $0
80106ee3:	6a 00                	push   $0x0
  pushl $238
80106ee5:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
80106eea:	e9 ae f1 ff ff       	jmp    8010609d <alltraps>

80106eef <vector239>:
.globl vector239
vector239:
  pushl $0
80106eef:	6a 00                	push   $0x0
  pushl $239
80106ef1:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
80106ef6:	e9 a2 f1 ff ff       	jmp    8010609d <alltraps>

80106efb <vector240>:
.globl vector240
vector240:
  pushl $0
80106efb:	6a 00                	push   $0x0
  pushl $240
80106efd:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
80106f02:	e9 96 f1 ff ff       	jmp    8010609d <alltraps>

80106f07 <vector241>:
.globl vector241
vector241:
  pushl $0
80106f07:	6a 00                	push   $0x0
  pushl $241
80106f09:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
80106f0e:	e9 8a f1 ff ff       	jmp    8010609d <alltraps>

80106f13 <vector242>:
.globl vector242
vector242:
  pushl $0
80106f13:	6a 00                	push   $0x0
  pushl $242
80106f15:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
80106f1a:	e9 7e f1 ff ff       	jmp    8010609d <alltraps>

80106f1f <vector243>:
.globl vector243
vector243:
  pushl $0
80106f1f:	6a 00                	push   $0x0
  pushl $243
80106f21:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
80106f26:	e9 72 f1 ff ff       	jmp    8010609d <alltraps>

80106f2b <vector244>:
.globl vector244
vector244:
  pushl $0
80106f2b:	6a 00                	push   $0x0
  pushl $244
80106f2d:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
80106f32:	e9 66 f1 ff ff       	jmp    8010609d <alltraps>

80106f37 <vector245>:
.globl vector245
vector245:
  pushl $0
80106f37:	6a 00                	push   $0x0
  pushl $245
80106f39:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
80106f3e:	e9 5a f1 ff ff       	jmp    8010609d <alltraps>

80106f43 <vector246>:
.globl vector246
vector246:
  pushl $0
80106f43:	6a 00                	push   $0x0
  pushl $246
80106f45:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
80106f4a:	e9 4e f1 ff ff       	jmp    8010609d <alltraps>

80106f4f <vector247>:
.globl vector247
vector247:
  pushl $0
80106f4f:	6a 00                	push   $0x0
  pushl $247
80106f51:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
80106f56:	e9 42 f1 ff ff       	jmp    8010609d <alltraps>

80106f5b <vector248>:
.globl vector248
vector248:
  pushl $0
80106f5b:	6a 00                	push   $0x0
  pushl $248
80106f5d:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
80106f62:	e9 36 f1 ff ff       	jmp    8010609d <alltraps>

80106f67 <vector249>:
.globl vector249
vector249:
  pushl $0
80106f67:	6a 00                	push   $0x0
  pushl $249
80106f69:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
80106f6e:	e9 2a f1 ff ff       	jmp    8010609d <alltraps>

80106f73 <vector250>:
.globl vector250
vector250:
  pushl $0
80106f73:	6a 00                	push   $0x0
  pushl $250
80106f75:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80106f7a:	e9 1e f1 ff ff       	jmp    8010609d <alltraps>

80106f7f <vector251>:
.globl vector251
vector251:
  pushl $0
80106f7f:	6a 00                	push   $0x0
  pushl $251
80106f81:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80106f86:	e9 12 f1 ff ff       	jmp    8010609d <alltraps>

80106f8b <vector252>:
.globl vector252
vector252:
  pushl $0
80106f8b:	6a 00                	push   $0x0
  pushl $252
80106f8d:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
80106f92:	e9 06 f1 ff ff       	jmp    8010609d <alltraps>

80106f97 <vector253>:
.globl vector253
vector253:
  pushl $0
80106f97:	6a 00                	push   $0x0
  pushl $253
80106f99:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
80106f9e:	e9 fa f0 ff ff       	jmp    8010609d <alltraps>

80106fa3 <vector254>:
.globl vector254
vector254:
  pushl $0
80106fa3:	6a 00                	push   $0x0
  pushl $254
80106fa5:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80106faa:	e9 ee f0 ff ff       	jmp    8010609d <alltraps>

80106faf <vector255>:
.globl vector255
vector255:
  pushl $0
80106faf:	6a 00                	push   $0x0
  pushl $255
80106fb1:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80106fb6:	e9 e2 f0 ff ff       	jmp    8010609d <alltraps>
80106fbb:	66 90                	xchg   %ax,%ax
80106fbd:	66 90                	xchg   %ax,%ax
80106fbf:	90                   	nop

80106fc0 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80106fc0:	55                   	push   %ebp
80106fc1:	89 e5                	mov    %esp,%ebp
80106fc3:	57                   	push   %edi
80106fc4:	56                   	push   %esi
80106fc5:	89 d6                	mov    %edx,%esi
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80106fc7:	c1 ea 16             	shr    $0x16,%edx
{
80106fca:	53                   	push   %ebx
  pde = &pgdir[PDX(va)];
80106fcb:	8d 3c 90             	lea    (%eax,%edx,4),%edi
{
80106fce:	83 ec 0c             	sub    $0xc,%esp
  if(*pde & PTE_P){
80106fd1:	8b 1f                	mov    (%edi),%ebx
80106fd3:	f6 c3 01             	test   $0x1,%bl
80106fd6:	74 28                	je     80107000 <walkpgdir+0x40>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106fd8:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
80106fde:	81 c3 00 00 00 80    	add    $0x80000000,%ebx
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
80106fe4:	89 f0                	mov    %esi,%eax
}
80106fe6:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return &pgtab[PTX(va)];
80106fe9:	c1 e8 0a             	shr    $0xa,%eax
80106fec:	25 fc 0f 00 00       	and    $0xffc,%eax
80106ff1:	01 d8                	add    %ebx,%eax
}
80106ff3:	5b                   	pop    %ebx
80106ff4:	5e                   	pop    %esi
80106ff5:	5f                   	pop    %edi
80106ff6:	5d                   	pop    %ebp
80106ff7:	c3                   	ret    
80106ff8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106fff:	90                   	nop
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80107000:	85 c9                	test   %ecx,%ecx
80107002:	74 2c                	je     80107030 <walkpgdir+0x70>
80107004:	e8 67 bc ff ff       	call   80102c70 <kalloc>
80107009:	89 c3                	mov    %eax,%ebx
8010700b:	85 c0                	test   %eax,%eax
8010700d:	74 21                	je     80107030 <walkpgdir+0x70>
    memset(pgtab, 0, PGSIZE);
8010700f:	83 ec 04             	sub    $0x4,%esp
80107012:	68 00 10 00 00       	push   $0x1000
80107017:	6a 00                	push   $0x0
80107019:	50                   	push   %eax
8010701a:	e8 71 dd ff ff       	call   80104d90 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
8010701f:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80107025:	83 c4 10             	add    $0x10,%esp
80107028:	83 c8 07             	or     $0x7,%eax
8010702b:	89 07                	mov    %eax,(%edi)
8010702d:	eb b5                	jmp    80106fe4 <walkpgdir+0x24>
8010702f:	90                   	nop
}
80107030:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return 0;
80107033:	31 c0                	xor    %eax,%eax
}
80107035:	5b                   	pop    %ebx
80107036:	5e                   	pop    %esi
80107037:	5f                   	pop    %edi
80107038:	5d                   	pop    %ebp
80107039:	c3                   	ret    
8010703a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107040 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80107040:	55                   	push   %ebp
80107041:	89 e5                	mov    %esp,%ebp
80107043:	57                   	push   %edi
80107044:	89 c7                	mov    %eax,%edi
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80107046:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
{
8010704a:	56                   	push   %esi
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
8010704b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  a = (char*)PGROUNDDOWN((uint)va);
80107050:	89 d6                	mov    %edx,%esi
{
80107052:	53                   	push   %ebx
  a = (char*)PGROUNDDOWN((uint)va);
80107053:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
{
80107059:	83 ec 1c             	sub    $0x1c,%esp
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
8010705c:	89 45 e0             	mov    %eax,-0x20(%ebp)
8010705f:	8b 45 08             	mov    0x8(%ebp),%eax
80107062:	29 f0                	sub    %esi,%eax
80107064:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107067:	eb 1f                	jmp    80107088 <mappages+0x48>
80107069:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
80107070:	f6 00 01             	testb  $0x1,(%eax)
80107073:	75 45                	jne    801070ba <mappages+0x7a>
      panic("remap");
    *pte = pa | perm | PTE_P;
80107075:	0b 5d 0c             	or     0xc(%ebp),%ebx
80107078:	83 cb 01             	or     $0x1,%ebx
8010707b:	89 18                	mov    %ebx,(%eax)
    if(a == last)
8010707d:	3b 75 e0             	cmp    -0x20(%ebp),%esi
80107080:	74 2e                	je     801070b0 <mappages+0x70>
      break;
    a += PGSIZE;
80107082:	81 c6 00 10 00 00    	add    $0x1000,%esi
  for(;;){
80107088:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
8010708b:	b9 01 00 00 00       	mov    $0x1,%ecx
80107090:	89 f2                	mov    %esi,%edx
80107092:	8d 1c 06             	lea    (%esi,%eax,1),%ebx
80107095:	89 f8                	mov    %edi,%eax
80107097:	e8 24 ff ff ff       	call   80106fc0 <walkpgdir>
8010709c:	85 c0                	test   %eax,%eax
8010709e:	75 d0                	jne    80107070 <mappages+0x30>
    pa += PGSIZE;
  }
  return 0;
}
801070a0:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
801070a3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801070a8:	5b                   	pop    %ebx
801070a9:	5e                   	pop    %esi
801070aa:	5f                   	pop    %edi
801070ab:	5d                   	pop    %ebp
801070ac:	c3                   	ret    
801070ad:	8d 76 00             	lea    0x0(%esi),%esi
801070b0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801070b3:	31 c0                	xor    %eax,%eax
}
801070b5:	5b                   	pop    %ebx
801070b6:	5e                   	pop    %esi
801070b7:	5f                   	pop    %edi
801070b8:	5d                   	pop    %ebp
801070b9:	c3                   	ret    
      panic("remap");
801070ba:	83 ec 0c             	sub    $0xc,%esp
801070bd:	68 a0 82 10 80       	push   $0x801082a0
801070c2:	e8 e9 92 ff ff       	call   801003b0 <panic>
801070c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801070ce:	66 90                	xchg   %ax,%ax

801070d0 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
801070d0:	55                   	push   %ebp
801070d1:	89 e5                	mov    %esp,%ebp
801070d3:	57                   	push   %edi
801070d4:	56                   	push   %esi
801070d5:	89 c6                	mov    %eax,%esi
801070d7:	53                   	push   %ebx
801070d8:	89 d3                	mov    %edx,%ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
801070da:	8d 91 ff 0f 00 00    	lea    0xfff(%ecx),%edx
801070e0:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
801070e6:	83 ec 1c             	sub    $0x1c,%esp
801070e9:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  for(; a  < oldsz; a += PGSIZE){
801070ec:	39 da                	cmp    %ebx,%edx
801070ee:	73 5b                	jae    8010714b <deallocuvm.part.0+0x7b>
801070f0:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
801070f3:	89 d7                	mov    %edx,%edi
801070f5:	eb 14                	jmp    8010710b <deallocuvm.part.0+0x3b>
801070f7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801070fe:	66 90                	xchg   %ax,%ax
80107100:	81 c7 00 10 00 00    	add    $0x1000,%edi
80107106:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80107109:	76 40                	jbe    8010714b <deallocuvm.part.0+0x7b>
    pte = walkpgdir(pgdir, (char*)a, 0);
8010710b:	31 c9                	xor    %ecx,%ecx
8010710d:	89 fa                	mov    %edi,%edx
8010710f:	89 f0                	mov    %esi,%eax
80107111:	e8 aa fe ff ff       	call   80106fc0 <walkpgdir>
80107116:	89 c3                	mov    %eax,%ebx
    if(!pte)
80107118:	85 c0                	test   %eax,%eax
8010711a:	74 44                	je     80107160 <deallocuvm.part.0+0x90>
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
8010711c:	8b 00                	mov    (%eax),%eax
8010711e:	a8 01                	test   $0x1,%al
80107120:	74 de                	je     80107100 <deallocuvm.part.0+0x30>
      pa = PTE_ADDR(*pte);
      if(pa == 0)
80107122:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107127:	74 47                	je     80107170 <deallocuvm.part.0+0xa0>
        panic("kfree");
      char *v = P2V(pa);
      kfree(v);
80107129:	83 ec 0c             	sub    $0xc,%esp
      char *v = P2V(pa);
8010712c:	05 00 00 00 80       	add    $0x80000000,%eax
80107131:	81 c7 00 10 00 00    	add    $0x1000,%edi
      kfree(v);
80107137:	50                   	push   %eax
80107138:	e8 73 b9 ff ff       	call   80102ab0 <kfree>
      *pte = 0;
8010713d:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80107143:	83 c4 10             	add    $0x10,%esp
  for(; a  < oldsz; a += PGSIZE){
80107146:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80107149:	77 c0                	ja     8010710b <deallocuvm.part.0+0x3b>
    }
  }
  return newsz;
}
8010714b:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010714e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107151:	5b                   	pop    %ebx
80107152:	5e                   	pop    %esi
80107153:	5f                   	pop    %edi
80107154:	5d                   	pop    %ebp
80107155:	c3                   	ret    
80107156:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010715d:	8d 76 00             	lea    0x0(%esi),%esi
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
80107160:	89 fa                	mov    %edi,%edx
80107162:	81 e2 00 00 c0 ff    	and    $0xffc00000,%edx
80107168:	8d ba 00 00 40 00    	lea    0x400000(%edx),%edi
8010716e:	eb 96                	jmp    80107106 <deallocuvm.part.0+0x36>
        panic("kfree");
80107170:	83 ec 0c             	sub    $0xc,%esp
80107173:	68 be 7b 10 80       	push   $0x80107bbe
80107178:	e8 33 92 ff ff       	call   801003b0 <panic>
8010717d:	8d 76 00             	lea    0x0(%esi),%esi

80107180 <seginit>:
{
80107180:	f3 0f 1e fb          	endbr32 
80107184:	55                   	push   %ebp
80107185:	89 e5                	mov    %esp,%ebp
80107187:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
8010718a:	e8 f1 cd ff ff       	call   80103f80 <cpuid>
  pd[0] = size - 1;
8010718f:	ba 2f 00 00 00       	mov    $0x2f,%edx
80107194:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
8010719a:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
8010719e:	c7 80 38 44 11 80 ff 	movl   $0xffff,-0x7feebbc8(%eax)
801071a5:	ff 00 00 
801071a8:	c7 80 3c 44 11 80 00 	movl   $0xcf9a00,-0x7feebbc4(%eax)
801071af:	9a cf 00 
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
801071b2:	c7 80 40 44 11 80 ff 	movl   $0xffff,-0x7feebbc0(%eax)
801071b9:	ff 00 00 
801071bc:	c7 80 44 44 11 80 00 	movl   $0xcf9200,-0x7feebbbc(%eax)
801071c3:	92 cf 00 
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
801071c6:	c7 80 48 44 11 80 ff 	movl   $0xffff,-0x7feebbb8(%eax)
801071cd:	ff 00 00 
801071d0:	c7 80 4c 44 11 80 00 	movl   $0xcffa00,-0x7feebbb4(%eax)
801071d7:	fa cf 00 
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
801071da:	c7 80 50 44 11 80 ff 	movl   $0xffff,-0x7feebbb0(%eax)
801071e1:	ff 00 00 
801071e4:	c7 80 54 44 11 80 00 	movl   $0xcff200,-0x7feebbac(%eax)
801071eb:	f2 cf 00 
  lgdt(c->gdt, sizeof(c->gdt));
801071ee:	05 30 44 11 80       	add    $0x80114430,%eax
  pd[1] = (uint)p;
801071f3:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
801071f7:	c1 e8 10             	shr    $0x10,%eax
801071fa:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r"(pd));
801071fe:	8d 45 f2             	lea    -0xe(%ebp),%eax
80107201:	0f 01 10             	lgdtl  (%eax)
}
80107204:	c9                   	leave  
80107205:	c3                   	ret    
80107206:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010720d:	8d 76 00             	lea    0x0(%esi),%esi

80107210 <switchkvm>:
{
80107210:	f3 0f 1e fb          	endbr32 
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80107214:	a1 e4 71 11 80       	mov    0x801171e4,%eax
80107219:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r"(val));
8010721e:	0f 22 d8             	mov    %eax,%cr3
}
80107221:	c3                   	ret    
80107222:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107229:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107230 <switchuvm>:
{
80107230:	f3 0f 1e fb          	endbr32 
80107234:	55                   	push   %ebp
80107235:	89 e5                	mov    %esp,%ebp
80107237:	57                   	push   %edi
80107238:	56                   	push   %esi
80107239:	53                   	push   %ebx
8010723a:	83 ec 1c             	sub    $0x1c,%esp
8010723d:	8b 75 08             	mov    0x8(%ebp),%esi
  if(p == 0)
80107240:	85 f6                	test   %esi,%esi
80107242:	0f 84 cb 00 00 00    	je     80107313 <switchuvm+0xe3>
  if(p->kstack == 0)
80107248:	8b 46 08             	mov    0x8(%esi),%eax
8010724b:	85 c0                	test   %eax,%eax
8010724d:	0f 84 da 00 00 00    	je     8010732d <switchuvm+0xfd>
  if(p->pgdir == 0)
80107253:	8b 46 04             	mov    0x4(%esi),%eax
80107256:	85 c0                	test   %eax,%eax
80107258:	0f 84 c2 00 00 00    	je     80107320 <switchuvm+0xf0>
  pushcli();
8010725e:	e8 1d d9 ff ff       	call   80104b80 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80107263:	e8 a8 cc ff ff       	call   80103f10 <mycpu>
80107268:	89 c3                	mov    %eax,%ebx
8010726a:	e8 a1 cc ff ff       	call   80103f10 <mycpu>
8010726f:	89 c7                	mov    %eax,%edi
80107271:	e8 9a cc ff ff       	call   80103f10 <mycpu>
80107276:	83 c7 08             	add    $0x8,%edi
80107279:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010727c:	e8 8f cc ff ff       	call   80103f10 <mycpu>
80107281:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80107284:	ba 67 00 00 00       	mov    $0x67,%edx
80107289:	66 89 bb 9a 00 00 00 	mov    %di,0x9a(%ebx)
80107290:	83 c0 08             	add    $0x8,%eax
80107293:	66 89 93 98 00 00 00 	mov    %dx,0x98(%ebx)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
8010729a:	bf ff ff ff ff       	mov    $0xffffffff,%edi
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
8010729f:	83 c1 08             	add    $0x8,%ecx
801072a2:	c1 e8 18             	shr    $0x18,%eax
801072a5:	c1 e9 10             	shr    $0x10,%ecx
801072a8:	88 83 9f 00 00 00    	mov    %al,0x9f(%ebx)
801072ae:	88 8b 9c 00 00 00    	mov    %cl,0x9c(%ebx)
801072b4:	b9 99 40 00 00       	mov    $0x4099,%ecx
801072b9:	66 89 8b 9d 00 00 00 	mov    %cx,0x9d(%ebx)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
801072c0:	bb 10 00 00 00       	mov    $0x10,%ebx
  mycpu()->gdt[SEG_TSS].s = 0;
801072c5:	e8 46 cc ff ff       	call   80103f10 <mycpu>
801072ca:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
801072d1:	e8 3a cc ff ff       	call   80103f10 <mycpu>
801072d6:	66 89 58 10          	mov    %bx,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
801072da:	8b 5e 08             	mov    0x8(%esi),%ebx
801072dd:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801072e3:	e8 28 cc ff ff       	call   80103f10 <mycpu>
801072e8:	89 58 0c             	mov    %ebx,0xc(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
801072eb:	e8 20 cc ff ff       	call   80103f10 <mycpu>
801072f0:	66 89 78 6e          	mov    %di,0x6e(%eax)
  asm volatile("ltr %0" : : "r"(sel));
801072f4:	b8 28 00 00 00       	mov    $0x28,%eax
801072f9:	0f 00 d8             	ltr    %ax
  lcr3(V2P(p->pgdir));  // switch to process's address space
801072fc:	8b 46 04             	mov    0x4(%esi),%eax
801072ff:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r"(val));
80107304:	0f 22 d8             	mov    %eax,%cr3
}
80107307:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010730a:	5b                   	pop    %ebx
8010730b:	5e                   	pop    %esi
8010730c:	5f                   	pop    %edi
8010730d:	5d                   	pop    %ebp
  popcli();
8010730e:	e9 bd d8 ff ff       	jmp    80104bd0 <popcli>
    panic("switchuvm: no process");
80107313:	83 ec 0c             	sub    $0xc,%esp
80107316:	68 a6 82 10 80       	push   $0x801082a6
8010731b:	e8 90 90 ff ff       	call   801003b0 <panic>
    panic("switchuvm: no pgdir");
80107320:	83 ec 0c             	sub    $0xc,%esp
80107323:	68 d1 82 10 80       	push   $0x801082d1
80107328:	e8 83 90 ff ff       	call   801003b0 <panic>
    panic("switchuvm: no kstack");
8010732d:	83 ec 0c             	sub    $0xc,%esp
80107330:	68 bc 82 10 80       	push   $0x801082bc
80107335:	e8 76 90 ff ff       	call   801003b0 <panic>
8010733a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107340 <inituvm>:
{
80107340:	f3 0f 1e fb          	endbr32 
80107344:	55                   	push   %ebp
80107345:	89 e5                	mov    %esp,%ebp
80107347:	57                   	push   %edi
80107348:	56                   	push   %esi
80107349:	53                   	push   %ebx
8010734a:	83 ec 1c             	sub    $0x1c,%esp
8010734d:	8b 45 0c             	mov    0xc(%ebp),%eax
80107350:	8b 75 10             	mov    0x10(%ebp),%esi
80107353:	8b 7d 08             	mov    0x8(%ebp),%edi
80107356:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(sz >= PGSIZE)
80107359:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
8010735f:	77 4b                	ja     801073ac <inituvm+0x6c>
  mem = kalloc();
80107361:	e8 0a b9 ff ff       	call   80102c70 <kalloc>
  memset(mem, 0, PGSIZE);
80107366:	83 ec 04             	sub    $0x4,%esp
80107369:	68 00 10 00 00       	push   $0x1000
  mem = kalloc();
8010736e:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
80107370:	6a 00                	push   $0x0
80107372:	50                   	push   %eax
80107373:	e8 18 da ff ff       	call   80104d90 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80107378:	58                   	pop    %eax
80107379:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
8010737f:	5a                   	pop    %edx
80107380:	6a 06                	push   $0x6
80107382:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107387:	31 d2                	xor    %edx,%edx
80107389:	50                   	push   %eax
8010738a:	89 f8                	mov    %edi,%eax
8010738c:	e8 af fc ff ff       	call   80107040 <mappages>
  memmove(mem, init, sz);
80107391:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107394:	89 75 10             	mov    %esi,0x10(%ebp)
80107397:	83 c4 10             	add    $0x10,%esp
8010739a:	89 5d 08             	mov    %ebx,0x8(%ebp)
8010739d:	89 45 0c             	mov    %eax,0xc(%ebp)
}
801073a0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801073a3:	5b                   	pop    %ebx
801073a4:	5e                   	pop    %esi
801073a5:	5f                   	pop    %edi
801073a6:	5d                   	pop    %ebp
  memmove(mem, init, sz);
801073a7:	e9 84 da ff ff       	jmp    80104e30 <memmove>
    panic("inituvm: more than a page");
801073ac:	83 ec 0c             	sub    $0xc,%esp
801073af:	68 e5 82 10 80       	push   $0x801082e5
801073b4:	e8 f7 8f ff ff       	call   801003b0 <panic>
801073b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801073c0 <loaduvm>:
{
801073c0:	f3 0f 1e fb          	endbr32 
801073c4:	55                   	push   %ebp
801073c5:	89 e5                	mov    %esp,%ebp
801073c7:	57                   	push   %edi
801073c8:	56                   	push   %esi
801073c9:	53                   	push   %ebx
801073ca:	83 ec 1c             	sub    $0x1c,%esp
801073cd:	8b 45 0c             	mov    0xc(%ebp),%eax
801073d0:	8b 75 18             	mov    0x18(%ebp),%esi
  if((uint) addr % PGSIZE != 0)
801073d3:	a9 ff 0f 00 00       	test   $0xfff,%eax
801073d8:	0f 85 99 00 00 00    	jne    80107477 <loaduvm+0xb7>
  for(i = 0; i < sz; i += PGSIZE){
801073de:	01 f0                	add    %esi,%eax
801073e0:	89 f3                	mov    %esi,%ebx
801073e2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(readi(ip, P2V(pa), offset+i, n) != n)
801073e5:	8b 45 14             	mov    0x14(%ebp),%eax
801073e8:	01 f0                	add    %esi,%eax
801073ea:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(i = 0; i < sz; i += PGSIZE){
801073ed:	85 f6                	test   %esi,%esi
801073ef:	75 15                	jne    80107406 <loaduvm+0x46>
801073f1:	eb 6d                	jmp    80107460 <loaduvm+0xa0>
801073f3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801073f7:	90                   	nop
801073f8:	81 eb 00 10 00 00    	sub    $0x1000,%ebx
801073fe:	89 f0                	mov    %esi,%eax
80107400:	29 d8                	sub    %ebx,%eax
80107402:	39 c6                	cmp    %eax,%esi
80107404:	76 5a                	jbe    80107460 <loaduvm+0xa0>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80107406:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80107409:	8b 45 08             	mov    0x8(%ebp),%eax
8010740c:	31 c9                	xor    %ecx,%ecx
8010740e:	29 da                	sub    %ebx,%edx
80107410:	e8 ab fb ff ff       	call   80106fc0 <walkpgdir>
80107415:	85 c0                	test   %eax,%eax
80107417:	74 51                	je     8010746a <loaduvm+0xaa>
    pa = PTE_ADDR(*pte);
80107419:	8b 00                	mov    (%eax),%eax
    if(readi(ip, P2V(pa), offset+i, n) != n)
8010741b:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    if(sz - i < PGSIZE)
8010741e:	bf 00 10 00 00       	mov    $0x1000,%edi
    pa = PTE_ADDR(*pte);
80107423:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
80107428:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
8010742e:	0f 46 fb             	cmovbe %ebx,%edi
    if(readi(ip, P2V(pa), offset+i, n) != n)
80107431:	29 d9                	sub    %ebx,%ecx
80107433:	05 00 00 00 80       	add    $0x80000000,%eax
80107438:	57                   	push   %edi
80107439:	51                   	push   %ecx
8010743a:	50                   	push   %eax
8010743b:	ff 75 10             	pushl  0x10(%ebp)
8010743e:	e8 5d ac ff ff       	call   801020a0 <readi>
80107443:	83 c4 10             	add    $0x10,%esp
80107446:	39 f8                	cmp    %edi,%eax
80107448:	74 ae                	je     801073f8 <loaduvm+0x38>
}
8010744a:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
8010744d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107452:	5b                   	pop    %ebx
80107453:	5e                   	pop    %esi
80107454:	5f                   	pop    %edi
80107455:	5d                   	pop    %ebp
80107456:	c3                   	ret    
80107457:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010745e:	66 90                	xchg   %ax,%ax
80107460:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80107463:	31 c0                	xor    %eax,%eax
}
80107465:	5b                   	pop    %ebx
80107466:	5e                   	pop    %esi
80107467:	5f                   	pop    %edi
80107468:	5d                   	pop    %ebp
80107469:	c3                   	ret    
      panic("loaduvm: address should exist");
8010746a:	83 ec 0c             	sub    $0xc,%esp
8010746d:	68 ff 82 10 80       	push   $0x801082ff
80107472:	e8 39 8f ff ff       	call   801003b0 <panic>
    panic("loaduvm: addr must be page aligned");
80107477:	83 ec 0c             	sub    $0xc,%esp
8010747a:	68 a0 83 10 80       	push   $0x801083a0
8010747f:	e8 2c 8f ff ff       	call   801003b0 <panic>
80107484:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010748b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010748f:	90                   	nop

80107490 <allocuvm>:
{
80107490:	f3 0f 1e fb          	endbr32 
80107494:	55                   	push   %ebp
80107495:	89 e5                	mov    %esp,%ebp
80107497:	57                   	push   %edi
80107498:	56                   	push   %esi
80107499:	53                   	push   %ebx
8010749a:	83 ec 1c             	sub    $0x1c,%esp
  if(newsz >= KERNBASE)
8010749d:	8b 45 10             	mov    0x10(%ebp),%eax
{
801074a0:	8b 7d 08             	mov    0x8(%ebp),%edi
  if(newsz >= KERNBASE)
801074a3:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801074a6:	85 c0                	test   %eax,%eax
801074a8:	0f 88 b2 00 00 00    	js     80107560 <allocuvm+0xd0>
  if(newsz < oldsz)
801074ae:	3b 45 0c             	cmp    0xc(%ebp),%eax
    return oldsz;
801074b1:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(newsz < oldsz)
801074b4:	0f 82 96 00 00 00    	jb     80107550 <allocuvm+0xc0>
  a = PGROUNDUP(oldsz);
801074ba:	8d b0 ff 0f 00 00    	lea    0xfff(%eax),%esi
801074c0:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
  for(; a < newsz; a += PGSIZE){
801074c6:	39 75 10             	cmp    %esi,0x10(%ebp)
801074c9:	77 40                	ja     8010750b <allocuvm+0x7b>
801074cb:	e9 83 00 00 00       	jmp    80107553 <allocuvm+0xc3>
    memset(mem, 0, PGSIZE);
801074d0:	83 ec 04             	sub    $0x4,%esp
801074d3:	68 00 10 00 00       	push   $0x1000
801074d8:	6a 00                	push   $0x0
801074da:	50                   	push   %eax
801074db:	e8 b0 d8 ff ff       	call   80104d90 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
801074e0:	58                   	pop    %eax
801074e1:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801074e7:	5a                   	pop    %edx
801074e8:	6a 06                	push   $0x6
801074ea:	b9 00 10 00 00       	mov    $0x1000,%ecx
801074ef:	89 f2                	mov    %esi,%edx
801074f1:	50                   	push   %eax
801074f2:	89 f8                	mov    %edi,%eax
801074f4:	e8 47 fb ff ff       	call   80107040 <mappages>
801074f9:	83 c4 10             	add    $0x10,%esp
801074fc:	85 c0                	test   %eax,%eax
801074fe:	78 78                	js     80107578 <allocuvm+0xe8>
  for(; a < newsz; a += PGSIZE){
80107500:	81 c6 00 10 00 00    	add    $0x1000,%esi
80107506:	39 75 10             	cmp    %esi,0x10(%ebp)
80107509:	76 48                	jbe    80107553 <allocuvm+0xc3>
    mem = kalloc();
8010750b:	e8 60 b7 ff ff       	call   80102c70 <kalloc>
80107510:	89 c3                	mov    %eax,%ebx
    if(mem == 0){
80107512:	85 c0                	test   %eax,%eax
80107514:	75 ba                	jne    801074d0 <allocuvm+0x40>
      cprintf("allocuvm out of memory\n");
80107516:	83 ec 0c             	sub    $0xc,%esp
80107519:	68 1d 83 10 80       	push   $0x8010831d
8010751e:	e8 7d 92 ff ff       	call   801007a0 <cprintf>
  if(newsz >= oldsz)
80107523:	8b 45 0c             	mov    0xc(%ebp),%eax
80107526:	83 c4 10             	add    $0x10,%esp
80107529:	39 45 10             	cmp    %eax,0x10(%ebp)
8010752c:	74 32                	je     80107560 <allocuvm+0xd0>
8010752e:	8b 55 10             	mov    0x10(%ebp),%edx
80107531:	89 c1                	mov    %eax,%ecx
80107533:	89 f8                	mov    %edi,%eax
80107535:	e8 96 fb ff ff       	call   801070d0 <deallocuvm.part.0>
      return 0;
8010753a:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
}
80107541:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107544:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107547:	5b                   	pop    %ebx
80107548:	5e                   	pop    %esi
80107549:	5f                   	pop    %edi
8010754a:	5d                   	pop    %ebp
8010754b:	c3                   	ret    
8010754c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return oldsz;
80107550:	89 45 e4             	mov    %eax,-0x1c(%ebp)
}
80107553:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107556:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107559:	5b                   	pop    %ebx
8010755a:	5e                   	pop    %esi
8010755b:	5f                   	pop    %edi
8010755c:	5d                   	pop    %ebp
8010755d:	c3                   	ret    
8010755e:	66 90                	xchg   %ax,%ax
    return 0;
80107560:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
}
80107567:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010756a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010756d:	5b                   	pop    %ebx
8010756e:	5e                   	pop    %esi
8010756f:	5f                   	pop    %edi
80107570:	5d                   	pop    %ebp
80107571:	c3                   	ret    
80107572:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      cprintf("allocuvm out of memory (2)\n");
80107578:	83 ec 0c             	sub    $0xc,%esp
8010757b:	68 35 83 10 80       	push   $0x80108335
80107580:	e8 1b 92 ff ff       	call   801007a0 <cprintf>
  if(newsz >= oldsz)
80107585:	8b 45 0c             	mov    0xc(%ebp),%eax
80107588:	83 c4 10             	add    $0x10,%esp
8010758b:	39 45 10             	cmp    %eax,0x10(%ebp)
8010758e:	74 0c                	je     8010759c <allocuvm+0x10c>
80107590:	8b 55 10             	mov    0x10(%ebp),%edx
80107593:	89 c1                	mov    %eax,%ecx
80107595:	89 f8                	mov    %edi,%eax
80107597:	e8 34 fb ff ff       	call   801070d0 <deallocuvm.part.0>
      kfree(mem);
8010759c:	83 ec 0c             	sub    $0xc,%esp
8010759f:	53                   	push   %ebx
801075a0:	e8 0b b5 ff ff       	call   80102ab0 <kfree>
      return 0;
801075a5:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
801075ac:	83 c4 10             	add    $0x10,%esp
}
801075af:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801075b2:	8d 65 f4             	lea    -0xc(%ebp),%esp
801075b5:	5b                   	pop    %ebx
801075b6:	5e                   	pop    %esi
801075b7:	5f                   	pop    %edi
801075b8:	5d                   	pop    %ebp
801075b9:	c3                   	ret    
801075ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801075c0 <deallocuvm>:
{
801075c0:	f3 0f 1e fb          	endbr32 
801075c4:	55                   	push   %ebp
801075c5:	89 e5                	mov    %esp,%ebp
801075c7:	8b 55 0c             	mov    0xc(%ebp),%edx
801075ca:	8b 4d 10             	mov    0x10(%ebp),%ecx
801075cd:	8b 45 08             	mov    0x8(%ebp),%eax
  if(newsz >= oldsz)
801075d0:	39 d1                	cmp    %edx,%ecx
801075d2:	73 0c                	jae    801075e0 <deallocuvm+0x20>
}
801075d4:	5d                   	pop    %ebp
801075d5:	e9 f6 fa ff ff       	jmp    801070d0 <deallocuvm.part.0>
801075da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801075e0:	89 d0                	mov    %edx,%eax
801075e2:	5d                   	pop    %ebp
801075e3:	c3                   	ret    
801075e4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801075eb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801075ef:	90                   	nop

801075f0 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
801075f0:	f3 0f 1e fb          	endbr32 
801075f4:	55                   	push   %ebp
801075f5:	89 e5                	mov    %esp,%ebp
801075f7:	57                   	push   %edi
801075f8:	56                   	push   %esi
801075f9:	53                   	push   %ebx
801075fa:	83 ec 0c             	sub    $0xc,%esp
801075fd:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
80107600:	85 f6                	test   %esi,%esi
80107602:	74 55                	je     80107659 <freevm+0x69>
  if(newsz >= oldsz)
80107604:	31 c9                	xor    %ecx,%ecx
80107606:	ba 00 00 00 80       	mov    $0x80000000,%edx
8010760b:	89 f0                	mov    %esi,%eax
8010760d:	89 f3                	mov    %esi,%ebx
8010760f:	e8 bc fa ff ff       	call   801070d0 <deallocuvm.part.0>
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80107614:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
8010761a:	eb 0b                	jmp    80107627 <freevm+0x37>
8010761c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107620:	83 c3 04             	add    $0x4,%ebx
80107623:	39 df                	cmp    %ebx,%edi
80107625:	74 23                	je     8010764a <freevm+0x5a>
    if(pgdir[i] & PTE_P){
80107627:	8b 03                	mov    (%ebx),%eax
80107629:	a8 01                	test   $0x1,%al
8010762b:	74 f3                	je     80107620 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
8010762d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
      kfree(v);
80107632:	83 ec 0c             	sub    $0xc,%esp
80107635:	83 c3 04             	add    $0x4,%ebx
      char * v = P2V(PTE_ADDR(pgdir[i]));
80107638:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
8010763d:	50                   	push   %eax
8010763e:	e8 6d b4 ff ff       	call   80102ab0 <kfree>
80107643:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
80107646:	39 df                	cmp    %ebx,%edi
80107648:	75 dd                	jne    80107627 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
8010764a:	89 75 08             	mov    %esi,0x8(%ebp)
}
8010764d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107650:	5b                   	pop    %ebx
80107651:	5e                   	pop    %esi
80107652:	5f                   	pop    %edi
80107653:	5d                   	pop    %ebp
  kfree((char*)pgdir);
80107654:	e9 57 b4 ff ff       	jmp    80102ab0 <kfree>
    panic("freevm: no pgdir");
80107659:	83 ec 0c             	sub    $0xc,%esp
8010765c:	68 51 83 10 80       	push   $0x80108351
80107661:	e8 4a 8d ff ff       	call   801003b0 <panic>
80107666:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010766d:	8d 76 00             	lea    0x0(%esi),%esi

80107670 <setupkvm>:
{
80107670:	f3 0f 1e fb          	endbr32 
80107674:	55                   	push   %ebp
80107675:	89 e5                	mov    %esp,%ebp
80107677:	56                   	push   %esi
80107678:	53                   	push   %ebx
  if((pgdir = (pde_t*)kalloc()) == 0)
80107679:	e8 f2 b5 ff ff       	call   80102c70 <kalloc>
8010767e:	89 c6                	mov    %eax,%esi
80107680:	85 c0                	test   %eax,%eax
80107682:	74 42                	je     801076c6 <setupkvm+0x56>
  memset(pgdir, 0, PGSIZE);
80107684:	83 ec 04             	sub    $0x4,%esp
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107687:	bb 20 b4 10 80       	mov    $0x8010b420,%ebx
  memset(pgdir, 0, PGSIZE);
8010768c:	68 00 10 00 00       	push   $0x1000
80107691:	6a 00                	push   $0x0
80107693:	50                   	push   %eax
80107694:	e8 f7 d6 ff ff       	call   80104d90 <memset>
80107699:	83 c4 10             	add    $0x10,%esp
                (uint)k->phys_start, k->perm) < 0) {
8010769c:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
8010769f:	83 ec 08             	sub    $0x8,%esp
801076a2:	8b 4b 08             	mov    0x8(%ebx),%ecx
801076a5:	ff 73 0c             	pushl  0xc(%ebx)
801076a8:	8b 13                	mov    (%ebx),%edx
801076aa:	50                   	push   %eax
801076ab:	29 c1                	sub    %eax,%ecx
801076ad:	89 f0                	mov    %esi,%eax
801076af:	e8 8c f9 ff ff       	call   80107040 <mappages>
801076b4:	83 c4 10             	add    $0x10,%esp
801076b7:	85 c0                	test   %eax,%eax
801076b9:	78 15                	js     801076d0 <setupkvm+0x60>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
801076bb:	83 c3 10             	add    $0x10,%ebx
801076be:	81 fb 60 b4 10 80    	cmp    $0x8010b460,%ebx
801076c4:	75 d6                	jne    8010769c <setupkvm+0x2c>
}
801076c6:	8d 65 f8             	lea    -0x8(%ebp),%esp
801076c9:	89 f0                	mov    %esi,%eax
801076cb:	5b                   	pop    %ebx
801076cc:	5e                   	pop    %esi
801076cd:	5d                   	pop    %ebp
801076ce:	c3                   	ret    
801076cf:	90                   	nop
      freevm(pgdir);
801076d0:	83 ec 0c             	sub    $0xc,%esp
801076d3:	56                   	push   %esi
      return 0;
801076d4:	31 f6                	xor    %esi,%esi
      freevm(pgdir);
801076d6:	e8 15 ff ff ff       	call   801075f0 <freevm>
      return 0;
801076db:	83 c4 10             	add    $0x10,%esp
}
801076de:	8d 65 f8             	lea    -0x8(%ebp),%esp
801076e1:	89 f0                	mov    %esi,%eax
801076e3:	5b                   	pop    %ebx
801076e4:	5e                   	pop    %esi
801076e5:	5d                   	pop    %ebp
801076e6:	c3                   	ret    
801076e7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801076ee:	66 90                	xchg   %ax,%ax

801076f0 <kvmalloc>:
{
801076f0:	f3 0f 1e fb          	endbr32 
801076f4:	55                   	push   %ebp
801076f5:	89 e5                	mov    %esp,%ebp
801076f7:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
801076fa:	e8 71 ff ff ff       	call   80107670 <setupkvm>
801076ff:	a3 e4 71 11 80       	mov    %eax,0x801171e4
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80107704:	05 00 00 00 80       	add    $0x80000000,%eax
80107709:	0f 22 d8             	mov    %eax,%cr3
}
8010770c:	c9                   	leave  
8010770d:	c3                   	ret    
8010770e:	66 90                	xchg   %ax,%ax

80107710 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80107710:	f3 0f 1e fb          	endbr32 
80107714:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107715:	31 c9                	xor    %ecx,%ecx
{
80107717:	89 e5                	mov    %esp,%ebp
80107719:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
8010771c:	8b 55 0c             	mov    0xc(%ebp),%edx
8010771f:	8b 45 08             	mov    0x8(%ebp),%eax
80107722:	e8 99 f8 ff ff       	call   80106fc0 <walkpgdir>
  if(pte == 0)
80107727:	85 c0                	test   %eax,%eax
80107729:	74 05                	je     80107730 <clearpteu+0x20>
    panic("clearpteu");
  *pte &= ~PTE_U;
8010772b:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
8010772e:	c9                   	leave  
8010772f:	c3                   	ret    
    panic("clearpteu");
80107730:	83 ec 0c             	sub    $0xc,%esp
80107733:	68 62 83 10 80       	push   $0x80108362
80107738:	e8 73 8c ff ff       	call   801003b0 <panic>
8010773d:	8d 76 00             	lea    0x0(%esi),%esi

80107740 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80107740:	f3 0f 1e fb          	endbr32 
80107744:	55                   	push   %ebp
80107745:	89 e5                	mov    %esp,%ebp
80107747:	57                   	push   %edi
80107748:	56                   	push   %esi
80107749:	53                   	push   %ebx
8010774a:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
8010774d:	e8 1e ff ff ff       	call   80107670 <setupkvm>
80107752:	89 45 e0             	mov    %eax,-0x20(%ebp)
80107755:	85 c0                	test   %eax,%eax
80107757:	0f 84 9b 00 00 00    	je     801077f8 <copyuvm+0xb8>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
8010775d:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80107760:	85 c9                	test   %ecx,%ecx
80107762:	0f 84 90 00 00 00    	je     801077f8 <copyuvm+0xb8>
80107768:	31 f6                	xor    %esi,%esi
8010776a:	eb 46                	jmp    801077b2 <copyuvm+0x72>
8010776c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80107770:	83 ec 04             	sub    $0x4,%esp
80107773:	81 c7 00 00 00 80    	add    $0x80000000,%edi
80107779:	68 00 10 00 00       	push   $0x1000
8010777e:	57                   	push   %edi
8010777f:	50                   	push   %eax
80107780:	e8 ab d6 ff ff       	call   80104e30 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
80107785:	58                   	pop    %eax
80107786:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
8010778c:	5a                   	pop    %edx
8010778d:	ff 75 e4             	pushl  -0x1c(%ebp)
80107790:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107795:	89 f2                	mov    %esi,%edx
80107797:	50                   	push   %eax
80107798:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010779b:	e8 a0 f8 ff ff       	call   80107040 <mappages>
801077a0:	83 c4 10             	add    $0x10,%esp
801077a3:	85 c0                	test   %eax,%eax
801077a5:	78 61                	js     80107808 <copyuvm+0xc8>
  for(i = 0; i < sz; i += PGSIZE){
801077a7:	81 c6 00 10 00 00    	add    $0x1000,%esi
801077ad:	39 75 0c             	cmp    %esi,0xc(%ebp)
801077b0:	76 46                	jbe    801077f8 <copyuvm+0xb8>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
801077b2:	8b 45 08             	mov    0x8(%ebp),%eax
801077b5:	31 c9                	xor    %ecx,%ecx
801077b7:	89 f2                	mov    %esi,%edx
801077b9:	e8 02 f8 ff ff       	call   80106fc0 <walkpgdir>
801077be:	85 c0                	test   %eax,%eax
801077c0:	74 61                	je     80107823 <copyuvm+0xe3>
    if(!(*pte & PTE_P))
801077c2:	8b 00                	mov    (%eax),%eax
801077c4:	a8 01                	test   $0x1,%al
801077c6:	74 4e                	je     80107816 <copyuvm+0xd6>
    pa = PTE_ADDR(*pte);
801077c8:	89 c7                	mov    %eax,%edi
    flags = PTE_FLAGS(*pte);
801077ca:	25 ff 0f 00 00       	and    $0xfff,%eax
801077cf:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    pa = PTE_ADDR(*pte);
801077d2:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
    if((mem = kalloc()) == 0)
801077d8:	e8 93 b4 ff ff       	call   80102c70 <kalloc>
801077dd:	89 c3                	mov    %eax,%ebx
801077df:	85 c0                	test   %eax,%eax
801077e1:	75 8d                	jne    80107770 <copyuvm+0x30>
    }
  }
  return d;

bad:
  freevm(d);
801077e3:	83 ec 0c             	sub    $0xc,%esp
801077e6:	ff 75 e0             	pushl  -0x20(%ebp)
801077e9:	e8 02 fe ff ff       	call   801075f0 <freevm>
  return 0;
801077ee:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
801077f5:	83 c4 10             	add    $0x10,%esp
}
801077f8:	8b 45 e0             	mov    -0x20(%ebp),%eax
801077fb:	8d 65 f4             	lea    -0xc(%ebp),%esp
801077fe:	5b                   	pop    %ebx
801077ff:	5e                   	pop    %esi
80107800:	5f                   	pop    %edi
80107801:	5d                   	pop    %ebp
80107802:	c3                   	ret    
80107803:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107807:	90                   	nop
      kfree(mem);
80107808:	83 ec 0c             	sub    $0xc,%esp
8010780b:	53                   	push   %ebx
8010780c:	e8 9f b2 ff ff       	call   80102ab0 <kfree>
      goto bad;
80107811:	83 c4 10             	add    $0x10,%esp
80107814:	eb cd                	jmp    801077e3 <copyuvm+0xa3>
      panic("copyuvm: page not present");
80107816:	83 ec 0c             	sub    $0xc,%esp
80107819:	68 86 83 10 80       	push   $0x80108386
8010781e:	e8 8d 8b ff ff       	call   801003b0 <panic>
      panic("copyuvm: pte should exist");
80107823:	83 ec 0c             	sub    $0xc,%esp
80107826:	68 6c 83 10 80       	push   $0x8010836c
8010782b:	e8 80 8b ff ff       	call   801003b0 <panic>

80107830 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80107830:	f3 0f 1e fb          	endbr32 
80107834:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107835:	31 c9                	xor    %ecx,%ecx
{
80107837:	89 e5                	mov    %esp,%ebp
80107839:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
8010783c:	8b 55 0c             	mov    0xc(%ebp),%edx
8010783f:	8b 45 08             	mov    0x8(%ebp),%eax
80107842:	e8 79 f7 ff ff       	call   80106fc0 <walkpgdir>
  if((*pte & PTE_P) == 0)
80107847:	8b 00                	mov    (%eax),%eax
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
}
80107849:	c9                   	leave  
  if((*pte & PTE_U) == 0)
8010784a:	89 c2                	mov    %eax,%edx
  return (char*)P2V(PTE_ADDR(*pte));
8010784c:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((*pte & PTE_U) == 0)
80107851:	83 e2 05             	and    $0x5,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80107854:	05 00 00 00 80       	add    $0x80000000,%eax
80107859:	83 fa 05             	cmp    $0x5,%edx
8010785c:	ba 00 00 00 00       	mov    $0x0,%edx
80107861:	0f 45 c2             	cmovne %edx,%eax
}
80107864:	c3                   	ret    
80107865:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010786c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80107870 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80107870:	f3 0f 1e fb          	endbr32 
80107874:	55                   	push   %ebp
80107875:	89 e5                	mov    %esp,%ebp
80107877:	57                   	push   %edi
80107878:	56                   	push   %esi
80107879:	53                   	push   %ebx
8010787a:	83 ec 0c             	sub    $0xc,%esp
8010787d:	8b 75 14             	mov    0x14(%ebp),%esi
80107880:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80107883:	85 f6                	test   %esi,%esi
80107885:	75 3c                	jne    801078c3 <copyout+0x53>
80107887:	eb 67                	jmp    801078f0 <copyout+0x80>
80107889:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
80107890:	8b 55 0c             	mov    0xc(%ebp),%edx
80107893:	89 fb                	mov    %edi,%ebx
80107895:	29 d3                	sub    %edx,%ebx
80107897:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    if(n > len)
8010789d:	39 f3                	cmp    %esi,%ebx
8010789f:	0f 47 de             	cmova  %esi,%ebx
      n = len;
    memmove(pa0 + (va - va0), buf, n);
801078a2:	29 fa                	sub    %edi,%edx
801078a4:	83 ec 04             	sub    $0x4,%esp
801078a7:	01 c2                	add    %eax,%edx
801078a9:	53                   	push   %ebx
801078aa:	ff 75 10             	pushl  0x10(%ebp)
801078ad:	52                   	push   %edx
801078ae:	e8 7d d5 ff ff       	call   80104e30 <memmove>
    len -= n;
    buf += n;
801078b3:	01 5d 10             	add    %ebx,0x10(%ebp)
    va = va0 + PGSIZE;
801078b6:	8d 97 00 10 00 00    	lea    0x1000(%edi),%edx
  while(len > 0){
801078bc:	83 c4 10             	add    $0x10,%esp
801078bf:	29 de                	sub    %ebx,%esi
801078c1:	74 2d                	je     801078f0 <copyout+0x80>
    va0 = (uint)PGROUNDDOWN(va);
801078c3:	89 d7                	mov    %edx,%edi
    pa0 = uva2ka(pgdir, (char*)va0);
801078c5:	83 ec 08             	sub    $0x8,%esp
    va0 = (uint)PGROUNDDOWN(va);
801078c8:	89 55 0c             	mov    %edx,0xc(%ebp)
801078cb:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
    pa0 = uva2ka(pgdir, (char*)va0);
801078d1:	57                   	push   %edi
801078d2:	ff 75 08             	pushl  0x8(%ebp)
801078d5:	e8 56 ff ff ff       	call   80107830 <uva2ka>
    if(pa0 == 0)
801078da:	83 c4 10             	add    $0x10,%esp
801078dd:	85 c0                	test   %eax,%eax
801078df:	75 af                	jne    80107890 <copyout+0x20>
  }
  return 0;
}
801078e1:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
801078e4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801078e9:	5b                   	pop    %ebx
801078ea:	5e                   	pop    %esi
801078eb:	5f                   	pop    %edi
801078ec:	5d                   	pop    %ebp
801078ed:	c3                   	ret    
801078ee:	66 90                	xchg   %ax,%ax
801078f0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801078f3:	31 c0                	xor    %eax,%eax
}
801078f5:	5b                   	pop    %ebx
801078f6:	5e                   	pop    %esi
801078f7:	5f                   	pop    %edi
801078f8:	5d                   	pop    %ebp
801078f9:	c3                   	ret    
