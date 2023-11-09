
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
80100050:	68 e0 78 10 80       	push   $0x801078e0
80100055:	68 40 d2 10 80       	push   $0x8010d240
8010005a:	e8 71 4a 00 00       	call   80104ad0 <initlock>
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
80100092:	68 e7 78 10 80       	push   $0x801078e7
80100097:	50                   	push   %eax
80100098:	e8 f3 48 00 00       	call   80104990 <initsleeplock>
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
801000e8:	e8 63 4b 00 00       	call   80104c50 <acquire>
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
80100162:	e8 a9 4b 00 00       	call   80104d10 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 5e 48 00 00       	call   801049d0 <acquiresleep>
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
801001a3:	68 ee 78 10 80       	push   $0x801078ee
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
801001c2:	e8 a9 48 00 00       	call   80104a70 <holdingsleep>
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
801001e0:	68 ff 78 10 80       	push   $0x801078ff
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
80100203:	e8 68 48 00 00       	call   80104a70 <holdingsleep>
80100208:	83 c4 10             	add    $0x10,%esp
8010020b:	85 c0                	test   %eax,%eax
8010020d:	74 66                	je     80100275 <brelse+0x85>
    panic("brelse");

  releasesleep(&b->lock);
8010020f:	83 ec 0c             	sub    $0xc,%esp
80100212:	56                   	push   %esi
80100213:	e8 18 48 00 00       	call   80104a30 <releasesleep>

  acquire(&bcache.lock);
80100218:	c7 04 24 40 d2 10 80 	movl   $0x8010d240,(%esp)
8010021f:	e8 2c 4a 00 00       	call   80104c50 <acquire>
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
80100270:	e9 9b 4a 00 00       	jmp    80104d10 <release>
    panic("brelse");
80100275:	83 ec 0c             	sub    $0xc,%esp
80100278:	68 06 79 10 80       	push   $0x80107906
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
801002b7:	e8 94 49 00 00       	call   80104c50 <acquire>
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
80100317:	e8 f4 49 00 00       	call   80104d10 <release>
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
80100379:	e8 92 49 00 00       	call   80104d10 <release>
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
801003d6:	68 0d 79 10 80       	push   $0x8010790d
801003db:	e8 c0 03 00 00       	call   801007a0 <cprintf>
  cprintf(s);
801003e0:	58                   	pop    %eax
801003e1:	ff 75 08             	pushl  0x8(%ebp)
801003e4:	e8 b7 03 00 00       	call   801007a0 <cprintf>
  cprintf("\n");
801003e9:	c7 04 24 ef 82 10 80 	movl   $0x801082ef,(%esp)
801003f0:	e8 ab 03 00 00       	call   801007a0 <cprintf>
  getcallerpcs(&s, pcs);
801003f5:	8d 45 08             	lea    0x8(%ebp),%eax
801003f8:	5a                   	pop    %edx
801003f9:	59                   	pop    %ecx
801003fa:	53                   	push   %ebx
801003fb:	50                   	push   %eax
801003fc:	e8 ef 46 00 00       	call   80104af0 <getcallerpcs>
  for (i = 0; i < 10; i++)
80100401:	83 c4 10             	add    $0x10,%esp
    cprintf(" %p", pcs[i]);
80100404:	83 ec 08             	sub    $0x8,%esp
80100407:	ff 33                	pushl  (%ebx)
80100409:	83 c3 04             	add    $0x4,%ebx
8010040c:	68 21 79 10 80       	push   $0x80107921
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
80100592:	e8 69 48 00 00       	call   80104e00 <memmove>
    memset(crt + pos, 0, sizeof(crt[0]) * (24 * 80 - pos));
80100597:	b8 80 07 00 00       	mov    $0x780,%eax
8010059c:	83 c4 0c             	add    $0xc,%esp
8010059f:	29 f0                	sub    %esi,%eax
801005a1:	01 c0                	add    %eax,%eax
801005a3:	50                   	push   %eax
801005a4:	8d 84 36 00 80 0b 80 	lea    -0x7ff48000(%esi,%esi,1),%eax
801005ab:	6a 00                	push   $0x0
801005ad:	50                   	push   %eax
801005ae:	e8 ad 47 00 00       	call   80104d60 <memset>
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
80100601:	e8 fa 47 00 00       	call   80104e00 <memmove>
    memset(crt + pos, 0, sizeof(crt[0]) * (25 * 80 - pos));
80100606:	83 c4 0c             	add    $0xc,%esp
80100609:	68 9c 0f 00 00       	push   $0xf9c
8010060e:	6a 00                	push   $0x0
80100610:	68 04 80 0b 80       	push   $0x800b8004
80100615:	e8 46 47 00 00       	call   80104d60 <memset>
8010061a:	83 c4 10             	add    $0x10,%esp
8010061d:	e9 d2 fe ff ff       	jmp    801004f4 <cgaputc+0xc4>
    panic("pos under/overflow");
80100622:	83 ec 0c             	sub    $0xc,%esp
80100625:	68 25 79 10 80       	push   $0x80107925
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
80100657:	e8 74 5e 00 00       	call   801064d0 <uartputc>
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
80100678:	e8 53 5e 00 00       	call   801064d0 <uartputc>
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
801006b9:	0f b6 92 a8 79 10 80 	movzbl -0x7fef8658(%edx),%edx
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
8010074f:	e8 fc 44 00 00       	call   80104c50 <acquire>
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
80100787:	e8 84 45 00 00       	call   80104d10 <release>
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
8010086d:	bb 38 79 10 80       	mov    $0x80107938,%ebx
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
801008ad:	e8 9e 43 00 00       	call   80104c50 <acquire>
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
80100918:	e8 f3 43 00 00       	call   80104d10 <release>
8010091d:	83 c4 10             	add    $0x10,%esp
}
80100920:	e9 ee fe ff ff       	jmp    80100813 <cprintf+0x73>
    panic("null fmt");
80100925:	83 ec 0c             	sub    $0xc,%esp
80100928:	68 3f 79 10 80       	push   $0x8010793f
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
80100b5f:	e8 fc 41 00 00       	call   80104d60 <memset>
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
80100c65:	e8 f6 40 00 00       	call   80104d60 <memset>
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
80100d5a:	e8 f1 3e 00 00       	call   80104c50 <acquire>
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
80100d88:	3e ff 24 9d 50 79 10 	notrack jmp *-0x7fef86b0(,%ebx,4)
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
80100da8:	e8 63 3f 00 00       	call   80104d10 <release>
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
8010107a:	68 48 79 10 80       	push   $0x80107948
8010107f:	68 a0 c1 10 80       	push   $0x8010c1a0
80101084:	e8 47 3a 00 00       	call   80104ad0 <initlock>

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
8010114c:	e8 ef 64 00 00       	call   80107640 <setupkvm>
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
801011b3:	e8 a8 62 00 00       	call   80107460 <allocuvm>
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
801011e9:	e8 a2 61 00 00       	call   80107390 <loaduvm>
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
8010122b:	e8 90 63 00 00       	call   801075c0 <freevm>
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
80101272:	e8 e9 61 00 00       	call   80107460 <allocuvm>
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
80101293:	e8 48 64 00 00       	call   801076e0 <clearpteu>
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
801012e3:	e8 78 3c 00 00       	call   80104f60 <strlen>
801012e8:	f7 d0                	not    %eax
801012ea:	01 c3                	add    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
801012ec:	58                   	pop    %eax
801012ed:	8b 45 0c             	mov    0xc(%ebp),%eax
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
801012f0:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
801012f3:	ff 34 b8             	pushl  (%eax,%edi,4)
801012f6:	e8 65 3c 00 00       	call   80104f60 <strlen>
801012fb:	83 c0 01             	add    $0x1,%eax
801012fe:	50                   	push   %eax
801012ff:	8b 45 0c             	mov    0xc(%ebp),%eax
80101302:	ff 34 b8             	pushl  (%eax,%edi,4)
80101305:	53                   	push   %ebx
80101306:	56                   	push   %esi
80101307:	e8 34 65 00 00       	call   80107840 <copyout>
8010130c:	83 c4 20             	add    $0x20,%esp
8010130f:	85 c0                	test   %eax,%eax
80101311:	79 ad                	jns    801012c0 <exec+0x200>
80101313:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101317:	90                   	nop
    freevm(pgdir);
80101318:	83 ec 0c             	sub    $0xc,%esp
8010131b:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80101321:	e8 9a 62 00 00       	call   801075c0 <freevm>
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
80101373:	e8 c8 64 00 00       	call   80107840 <copyout>
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
801013b1:	e8 6a 3b 00 00       	call   80104f20 <safestrcpy>
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
801013dd:	e8 1e 5e 00 00       	call   80107200 <switchuvm>
  freevm(oldpgdir);
801013e2:	89 3c 24             	mov    %edi,(%esp)
801013e5:	e8 d6 61 00 00       	call   801075c0 <freevm>
  return 0;
801013ea:	83 c4 10             	add    $0x10,%esp
801013ed:	31 c0                	xor    %eax,%eax
801013ef:	e9 3c fd ff ff       	jmp    80101130 <exec+0x70>
    end_op();
801013f4:	e8 e7 1f 00 00       	call   801033e0 <end_op>
    cprintf("exec: fail\n");
801013f9:	83 ec 0c             	sub    $0xc,%esp
801013fc:	68 b9 79 10 80       	push   $0x801079b9
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
8010142a:	68 c5 79 10 80       	push   $0x801079c5
8010142f:	68 00 1c 11 80       	push   $0x80111c00
80101434:	e8 97 36 00 00       	call   80104ad0 <initlock>
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
80101455:	e8 f6 37 00 00       	call   80104c50 <acquire>
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
80101481:	e8 8a 38 00 00       	call   80104d10 <release>
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
8010149a:	e8 71 38 00 00       	call   80104d10 <release>
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
801014c3:	e8 88 37 00 00       	call   80104c50 <acquire>
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
801014e0:	e8 2b 38 00 00       	call   80104d10 <release>
  return f;
}
801014e5:	89 d8                	mov    %ebx,%eax
801014e7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801014ea:	c9                   	leave  
801014eb:	c3                   	ret    
    panic("filedup");
801014ec:	83 ec 0c             	sub    $0xc,%esp
801014ef:	68 cc 79 10 80       	push   $0x801079cc
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
80101515:	e8 36 37 00 00       	call   80104c50 <acquire>
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
80101550:	e8 bb 37 00 00       	call   80104d10 <release>

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
8010157e:	e9 8d 37 00 00       	jmp    80104d10 <release>
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
801015cc:	68 d4 79 10 80       	push   $0x801079d4
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
801016ba:	68 de 79 10 80       	push   $0x801079de
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
801017a3:	68 e7 79 10 80       	push   $0x801079e7
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
801017d9:	68 ed 79 10 80       	push   $0x801079ed
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
80101857:	68 f7 79 10 80       	push   $0x801079f7
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
80101914:	68 0a 7a 10 80       	push   $0x80107a0a
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
80101955:	e8 06 34 00 00       	call   80104d60 <memset>
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
8010199a:	e8 b1 32 00 00       	call   80104c50 <acquire>
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
80101a07:	e8 04 33 00 00       	call   80104d10 <release>

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
80101a35:	e8 d6 32 00 00       	call   80104d10 <release>
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
80101a62:	68 20 7a 10 80       	push   $0x80107a20
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
80101b2b:	68 30 7a 10 80       	push   $0x80107a30
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
80101b65:	e8 96 32 00 00       	call   80104e00 <memmove>
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
80101b90:	68 43 7a 10 80       	push   $0x80107a43
80101b95:	68 20 26 11 80       	push   $0x80112620
80101b9a:	e8 31 2f 00 00       	call   80104ad0 <initlock>
  for(i = 0; i < NINODE; i++) {
80101b9f:	83 c4 10             	add    $0x10,%esp
80101ba2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    initsleeplock(&icache.inode[i].lock, "inode");
80101ba8:	83 ec 08             	sub    $0x8,%esp
80101bab:	68 4a 7a 10 80       	push   $0x80107a4a
80101bb0:	53                   	push   %ebx
80101bb1:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101bb7:	e8 d4 2d 00 00       	call   80104990 <initsleeplock>
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
80101c01:	68 b0 7a 10 80       	push   $0x80107ab0
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
80101c9e:	e8 bd 30 00 00       	call   80104d60 <memset>
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
80101cd3:	68 50 7a 10 80       	push   $0x80107a50
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
80101d45:	e8 b6 30 00 00       	call   80104e00 <memmove>
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
80101d83:	e8 c8 2e 00 00       	call   80104c50 <acquire>
  ip->ref++;
80101d88:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
80101d8c:	c7 04 24 20 26 11 80 	movl   $0x80112620,(%esp)
80101d93:	e8 78 2f 00 00       	call   80104d10 <release>
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
80101dc6:	e8 05 2c 00 00       	call   801049d0 <acquiresleep>
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
80101e38:	e8 c3 2f 00 00       	call   80104e00 <memmove>
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
80101e5d:	68 68 7a 10 80       	push   $0x80107a68
80101e62:	e8 49 e5 ff ff       	call   801003b0 <panic>
    panic("ilock");
80101e67:	83 ec 0c             	sub    $0xc,%esp
80101e6a:	68 62 7a 10 80       	push   $0x80107a62
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
80101e97:	e8 d4 2b 00 00       	call   80104a70 <holdingsleep>
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
80101eb3:	e9 78 2b 00 00       	jmp    80104a30 <releasesleep>
    panic("iunlock");
80101eb8:	83 ec 0c             	sub    $0xc,%esp
80101ebb:	68 77 7a 10 80       	push   $0x80107a77
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
80101ee4:	e8 e7 2a 00 00       	call   801049d0 <acquiresleep>
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
80101efe:	e8 2d 2b 00 00       	call   80104a30 <releasesleep>
  acquire(&icache.lock);
80101f03:	c7 04 24 20 26 11 80 	movl   $0x80112620,(%esp)
80101f0a:	e8 41 2d 00 00       	call   80104c50 <acquire>
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
80101f24:	e9 e7 2d 00 00       	jmp    80104d10 <release>
80101f29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    acquire(&icache.lock);
80101f30:	83 ec 0c             	sub    $0xc,%esp
80101f33:	68 20 26 11 80       	push   $0x80112620
80101f38:	e8 13 2d 00 00       	call   80104c50 <acquire>
    int r = ip->ref;
80101f3d:	8b 73 08             	mov    0x8(%ebx),%esi
    release(&icache.lock);
80101f40:	c7 04 24 20 26 11 80 	movl   $0x80112620,(%esp)
80101f47:	e8 c4 2d 00 00       	call   80104d10 <release>
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
80102147:	e8 b4 2c 00 00       	call   80104e00 <memmove>
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
80102243:	e8 b8 2b 00 00       	call   80104e00 <memmove>
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
801022e2:	e8 89 2b 00 00       	call   80104e70 <strncmp>
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
80102345:	e8 26 2b 00 00       	call   80104e70 <strncmp>
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
8010238a:	68 91 7a 10 80       	push   $0x80107a91
8010238f:	e8 1c e0 ff ff       	call   801003b0 <panic>
    panic("dirlookup not DIR");
80102394:	83 ec 0c             	sub    $0xc,%esp
80102397:	68 7f 7a 10 80       	push   $0x80107a7f
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
801023dc:	e8 6f 28 00 00       	call   80104c50 <acquire>
  ip->ref++;
801023e1:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
801023e5:	c7 04 24 20 26 11 80 	movl   $0x80112620,(%esp)
801023ec:	e8 1f 29 00 00       	call   80104d10 <release>
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
80102457:	e8 a4 29 00 00       	call   80104e00 <memmove>
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
801024e3:	e8 18 29 00 00       	call   80104e00 <memmove>
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
80102615:	e8 a6 28 00 00       	call   80104ec0 <strncpy>
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
80102653:	68 a0 7a 10 80       	push   $0x80107aa0
80102658:	e8 53 dd ff ff       	call   801003b0 <panic>
    panic("dirlink");
8010265d:	83 ec 0c             	sub    $0xc,%esp
80102660:	68 8e 80 10 80       	push   $0x8010808e
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
8010276b:	68 0c 7b 10 80       	push   $0x80107b0c
80102770:	e8 3b dc ff ff       	call   801003b0 <panic>
    panic("idestart");
80102775:	83 ec 0c             	sub    $0xc,%esp
80102778:	68 03 7b 10 80       	push   $0x80107b03
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
8010279a:	68 1e 7b 10 80       	push   $0x80107b1e
8010279f:	68 00 c2 10 80       	push   $0x8010c200
801027a4:	e8 27 23 00 00       	call   80104ad0 <initlock>
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
80102832:	e8 19 24 00 00       	call   80104c50 <acquire>

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
801028ab:	e8 60 24 00 00       	call   80104d10 <release>

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
801028d2:	e8 99 21 00 00       	call   80104a70 <holdingsleep>
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
8010290c:	e8 3f 23 00 00       	call   80104c50 <acquire>

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
80102976:	e9 95 23 00 00       	jmp    80104d10 <release>
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
8010299a:	68 4d 7b 10 80       	push   $0x80107b4d
8010299f:	e8 0c da ff ff       	call   801003b0 <panic>
    panic("iderw: nothing to do");
801029a4:	83 ec 0c             	sub    $0xc,%esp
801029a7:	68 38 7b 10 80       	push   $0x80107b38
801029ac:	e8 ff d9 ff ff       	call   801003b0 <panic>
    panic("iderw: buf not locked");
801029b1:	83 ec 0c             	sub    $0xc,%esp
801029b4:	68 22 7b 10 80       	push   $0x80107b22
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
80102a0e:	68 6c 7b 10 80       	push   $0x80107b6c
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
80102ae6:	e8 75 22 00 00       	call   80104d60 <memset>

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
80102b20:	e8 2b 21 00 00       	call   80104c50 <acquire>
80102b25:	83 c4 10             	add    $0x10,%esp
80102b28:	eb ce                	jmp    80102af8 <kfree+0x48>
80102b2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    release(&kmem.lock);
80102b30:	c7 45 08 80 42 11 80 	movl   $0x80114280,0x8(%ebp)
}
80102b37:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102b3a:	c9                   	leave  
    release(&kmem.lock);
80102b3b:	e9 d0 21 00 00       	jmp    80104d10 <release>
    panic("kfree");
80102b40:	83 ec 0c             	sub    $0xc,%esp
80102b43:	68 9e 7b 10 80       	push   $0x80107b9e
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
80102baf:	68 a4 7b 10 80       	push   $0x80107ba4
80102bb4:	68 80 42 11 80       	push   $0x80114280
80102bb9:	e8 12 1f 00 00       	call   80104ad0 <initlock>
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
80102ca3:	e8 a8 1f 00 00       	call   80104c50 <acquire>
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
80102cd1:	e8 3a 20 00 00       	call   80104d10 <release>
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
80102d1f:	0f b6 8a e0 7c 10 80 	movzbl -0x7fef8320(%edx),%ecx
  shift ^= togglecode[data];
80102d26:	0f b6 82 e0 7b 10 80 	movzbl -0x7fef8420(%edx),%eax
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
80102d3f:	8b 04 85 c0 7b 10 80 	mov    -0x7fef8440(,%eax,4),%eax
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
80102d7a:	0f b6 8a e0 7c 10 80 	movzbl -0x7fef8320(%edx),%ecx
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
801030ff:	e8 ac 1c 00 00       	call   80104db0 <memcmp>
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
80103234:	e8 c7 1b 00 00       	call   80104e00 <memmove>
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
801032de:	68 e0 7d 10 80       	push   $0x80107de0
801032e3:	68 c0 42 11 80       	push   $0x801142c0
801032e8:	e8 e3 17 00 00       	call   80104ad0 <initlock>
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
8010337f:	e8 cc 18 00 00       	call   80104c50 <acquire>
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
801033d4:	e8 37 19 00 00       	call   80104d10 <release>
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
801033f2:	e8 59 18 00 00       	call   80104c50 <acquire>
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
80103430:	e8 db 18 00 00       	call   80104d10 <release>
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
8010344a:	e8 01 18 00 00       	call   80104c50 <acquire>
    wakeup(&log);
8010344f:	c7 04 24 c0 42 11 80 	movl   $0x801142c0,(%esp)
    log.committing = 0;
80103456:	c7 05 00 43 11 80 00 	movl   $0x0,0x80114300
8010345d:	00 00 00 
    wakeup(&log);
80103460:	e8 eb 12 00 00       	call   80104750 <wakeup>
    release(&log.lock);
80103465:	c7 04 24 c0 42 11 80 	movl   $0x801142c0,(%esp)
8010346c:	e8 9f 18 00 00       	call   80104d10 <release>
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
801034c4:	e8 37 19 00 00       	call   80104e00 <memmove>
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
80103524:	e8 e7 17 00 00       	call   80104d10 <release>
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
80103537:	68 e4 7d 10 80       	push   $0x80107de4
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
80103592:	e8 b9 16 00 00       	call   80104c50 <acquire>
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
801035d5:	e9 36 17 00 00       	jmp    80104d10 <release>
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
80103601:	68 f3 7d 10 80       	push   $0x80107df3
80103606:	e8 a5 cd ff ff       	call   801003b0 <panic>
    panic("log_write outside of trans");
8010360b:	83 ec 0c             	sub    $0xc,%esp
8010360e:	68 09 7e 10 80       	push   $0x80107e09
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
80103638:	68 24 7e 10 80       	push   $0x80107e24
8010363d:	e8 5e d1 ff ff       	call   801007a0 <cprintf>
  idtinit();       // load idt register
80103642:	e8 c9 2a 00 00       	call   80106110 <idtinit>
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
8010366a:	e8 71 3b 00 00       	call   801071e0 <switchkvm>
  seginit();
8010366f:	e8 dc 3a 00 00       	call   80107150 <seginit>
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
801036a5:	e8 16 40 00 00       	call   801076c0 <kvmalloc>
  mpinit();        // detect other processors
801036aa:	e8 81 01 00 00       	call   80103830 <mpinit>
  lapicinit();     // interrupt controller
801036af:	e8 2c f7 ff ff       	call   80102de0 <lapicinit>
  seginit();       // segment descriptors
801036b4:	e8 97 3a 00 00       	call   80107150 <seginit>
  picinit();       // disable pic
801036b9:	e8 52 03 00 00       	call   80103a10 <picinit>
  ioapicinit();    // another interrupt controller
801036be:	e8 fd f2 ff ff       	call   801029c0 <ioapicinit>
  consoleinit();   // console hardware
801036c3:	e8 a8 d9 ff ff       	call   80101070 <consoleinit>
  uartinit();      // serial port
801036c8:	e8 43 2d 00 00       	call   80106410 <uartinit>
  pinit();         // process table
801036cd:	e8 1e 08 00 00       	call   80103ef0 <pinit>
  tvinit();        // trap vectors
801036d2:	e8 b9 29 00 00       	call   80106090 <tvinit>
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
801036f8:	e8 03 17 00 00       	call   80104e00 <memmove>

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
801037de:	68 38 7e 10 80       	push   $0x80107e38
801037e3:	56                   	push   %esi
801037e4:	e8 c7 15 00 00       	call   80104db0 <memcmp>
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
8010389a:	68 3d 7e 10 80       	push   $0x80107e3d
8010389f:	50                   	push   %eax
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
801038a0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(memcmp(conf, "PCMP", 4) != 0)
801038a3:	e8 08 15 00 00       	call   80104db0 <memcmp>
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
801039f3:	68 42 7e 10 80       	push   $0x80107e42
801039f8:	e8 b3 c9 ff ff       	call   801003b0 <panic>
    panic("Didn't find a suitable machine");
801039fd:	83 ec 0c             	sub    $0xc,%esp
80103a00:	68 5c 7e 10 80       	push   $0x80107e5c
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
80103aa7:	68 7b 7e 10 80       	push   $0x80107e7b
80103aac:	50                   	push   %eax
80103aad:	e8 1e 10 00 00       	call   80104ad0 <initlock>
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
80103b53:	e8 f8 10 00 00       	call   80104c50 <acquire>
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
80103b98:	e9 73 11 00 00       	jmp    80104d10 <release>
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
80103bc4:	e8 47 11 00 00       	call   80104d10 <release>
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
80103bf1:	e8 5a 10 00 00       	call   80104c50 <acquire>
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
80103c7c:	e8 8f 10 00 00       	call   80104d10 <release>
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
80103cd2:	e8 39 10 00 00       	call   80104d10 <release>
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
80103cfa:	e8 51 0f 00 00       	call   80104c50 <acquire>
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
80103d9e:	e8 6d 0f 00 00       	call   80104d10 <release>
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
80103db9:	e8 52 0f 00 00       	call   80104d10 <release>
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
80103de1:	e8 6a 0e 00 00       	call   80104c50 <acquire>
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
80103e22:	e8 e9 0e 00 00       	call   80104d10 <release>

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
80103e47:	c7 40 14 85 60 10 80 	movl   $0x80106085,0x14(%eax)
  p->context = (struct context *)sp;
80103e4e:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
80103e51:	6a 14                	push   $0x14
80103e53:	6a 00                	push   $0x0
80103e55:	50                   	push   %eax
80103e56:	e8 05 0f 00 00       	call   80104d60 <memset>
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
80103e7a:	e8 91 0e 00 00       	call   80104d10 <release>
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
80103eaf:	e8 5c 0e 00 00       	call   80104d10 <release>

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
80103efa:	68 80 7e 10 80       	push   $0x80107e80
80103eff:	68 60 49 11 80       	push   $0x80114960
80103f04:	e8 c7 0b 00 00       	call   80104ad0 <initlock>
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
80103f60:	68 87 7e 10 80       	push   $0x80107e87
80103f65:	e8 46 c4 ff ff       	call   801003b0 <panic>
    panic("mycpu called with interrupts enabled\n");
80103f6a:	83 ec 0c             	sub    $0xc,%esp
80103f6d:	68 64 7f 10 80       	push   $0x80107f64
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
80103fab:	e8 a0 0b 00 00       	call   80104b50 <pushcli>
  c = mycpu();
80103fb0:	e8 5b ff ff ff       	call   80103f10 <mycpu>
  p = c->proc;
80103fb5:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103fbb:	e8 e0 0b 00 00       	call   80104ba0 <popcli>
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
80103fe7:	e8 54 36 00 00       	call   80107640 <setupkvm>
80103fec:	89 43 04             	mov    %eax,0x4(%ebx)
80103fef:	85 c0                	test   %eax,%eax
80103ff1:	0f 84 bd 00 00 00    	je     801040b4 <userinit+0xe4>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80103ff7:	83 ec 04             	sub    $0x4,%esp
80103ffa:	68 2c 00 00 00       	push   $0x2c
80103fff:	68 60 b4 10 80       	push   $0x8010b460
80104004:	50                   	push   %eax
80104005:	e8 06 33 00 00       	call   80107310 <inituvm>
  memset(p->tf, 0, sizeof(*p->tf));
8010400a:	83 c4 0c             	add    $0xc,%esp
  p->sz = PGSIZE;
8010400d:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
80104013:	6a 4c                	push   $0x4c
80104015:	6a 00                	push   $0x0
80104017:	ff 73 18             	pushl  0x18(%ebx)
8010401a:	e8 41 0d 00 00       	call   80104d60 <memset>
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
80104073:	68 b0 7e 10 80       	push   $0x80107eb0
80104078:	50                   	push   %eax
80104079:	e8 a2 0e 00 00       	call   80104f20 <safestrcpy>
  p->cwd = namei("/");
8010407e:	c7 04 24 b9 7e 10 80 	movl   $0x80107eb9,(%esp)
80104085:	e8 e6 e5 ff ff       	call   80102670 <namei>
8010408a:	89 43 68             	mov    %eax,0x68(%ebx)
  acquire(&ptable.lock);
8010408d:	c7 04 24 60 49 11 80 	movl   $0x80114960,(%esp)
80104094:	e8 b7 0b 00 00       	call   80104c50 <acquire>
  p->state = RUNNABLE;
80104099:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
801040a0:	c7 04 24 60 49 11 80 	movl   $0x80114960,(%esp)
801040a7:	e8 64 0c 00 00       	call   80104d10 <release>
}
801040ac:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801040af:	83 c4 10             	add    $0x10,%esp
801040b2:	c9                   	leave  
801040b3:	c3                   	ret    
    panic("userinit: out of memory?");
801040b4:	83 ec 0c             	sub    $0xc,%esp
801040b7:	68 97 7e 10 80       	push   $0x80107e97
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
801040dc:	e8 6f 0a 00 00       	call   80104b50 <pushcli>
  c = mycpu();
801040e1:	e8 2a fe ff ff       	call   80103f10 <mycpu>
  p = c->proc;
801040e6:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801040ec:	e8 af 0a 00 00       	call   80104ba0 <popcli>
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
801040ff:	e8 fc 30 00 00       	call   80107200 <switchuvm>
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
8010411a:	e8 41 33 00 00       	call   80107460 <allocuvm>
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
8010413a:	e8 51 34 00 00       	call   80107590 <deallocuvm>
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
8010415d:	e8 ee 09 00 00       	call   80104b50 <pushcli>
  c = mycpu();
80104162:	e8 a9 fd ff ff       	call   80103f10 <mycpu>
  p = c->proc;
80104167:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
8010416d:	e8 2e 0a 00 00       	call   80104ba0 <popcli>
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
8010418c:	e8 7f 35 00 00       	call   80107710 <copyuvm>
80104191:	83 c4 10             	add    $0x10,%esp
80104194:	89 47 04             	mov    %eax,0x4(%edi)
80104197:	85 c0                	test   %eax,%eax
80104199:	0f 84 cd 00 00 00    	je     8010426c <fork+0x11c>
  	acquire(&tickslock);
8010419f:	83 ec 0c             	sub    $0xc,%esp
801041a2:	68 a0 69 11 80       	push   $0x801169a0
801041a7:	e8 a4 0a 00 00       	call   80104c50 <acquire>
    np->xticks=ticks; // creation time for this process
801041ac:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801041af:	a1 e0 71 11 80       	mov    0x801171e0,%eax
801041b4:	89 47 6c             	mov    %eax,0x6c(%edi)
	  release(&tickslock);
801041b7:	c7 04 24 a0 69 11 80 	movl   $0x801169a0,(%esp)
801041be:	e8 4d 0b 00 00       	call   80104d10 <release>
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
80104231:	e8 ea 0c 00 00       	call   80104f20 <safestrcpy>
  pid = np->pid;
80104236:	8b 5f 10             	mov    0x10(%edi),%ebx
  acquire(&ptable.lock);
80104239:	c7 04 24 60 49 11 80 	movl   $0x80114960,(%esp)
80104240:	e8 0b 0a 00 00       	call   80104c50 <acquire>
  np->state = RUNNABLE;
80104245:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)
  release(&ptable.lock);
8010424c:	c7 04 24 60 49 11 80 	movl   $0x80114960,(%esp)
80104253:	e8 b8 0a 00 00       	call   80104d10 <release>
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
801042d6:	e8 75 09 00 00       	call   80104c50 <acquire>
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
801042f0:	e8 0b 2f 00 00       	call   80107200 <switchuvm>
      swtch(&(c->scheduler), p->context);
801042f5:	58                   	pop    %eax
801042f6:	5a                   	pop    %edx
801042f7:	ff 73 1c             	pushl  0x1c(%ebx)
801042fa:	57                   	push   %edi
      p->state = RUNNING;
801042fb:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
      swtch(&(c->scheduler), p->context);
80104302:	e8 7c 0c 00 00       	call   80104f83 <swtch>
      switchkvm();
80104307:	e8 d4 2e 00 00       	call   801071e0 <switchkvm>
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
8010432c:	e8 df 09 00 00       	call   80104d10 <release>
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
80104349:	e8 02 08 00 00       	call   80104b50 <pushcli>
  c = mycpu();
8010434e:	e8 bd fb ff ff       	call   80103f10 <mycpu>
  p = c->proc;
80104353:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104359:	e8 42 08 00 00       	call   80104ba0 <popcli>
  if (!holding(&ptable.lock))
8010435e:	83 ec 0c             	sub    $0xc,%esp
80104361:	68 60 49 11 80       	push   $0x80114960
80104366:	e8 95 08 00 00       	call   80104c00 <holding>
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
801043a7:	e8 d7 0b 00 00       	call   80104f83 <swtch>
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
801043c4:	68 bb 7e 10 80       	push   $0x80107ebb
801043c9:	e8 e2 bf ff ff       	call   801003b0 <panic>
    panic("sched interruptible");
801043ce:	83 ec 0c             	sub    $0xc,%esp
801043d1:	68 e7 7e 10 80       	push   $0x80107ee7
801043d6:	e8 d5 bf ff ff       	call   801003b0 <panic>
    panic("sched running");
801043db:	83 ec 0c             	sub    $0xc,%esp
801043de:	68 d9 7e 10 80       	push   $0x80107ed9
801043e3:	e8 c8 bf ff ff       	call   801003b0 <panic>
    panic("sched locks");
801043e8:	83 ec 0c             	sub    $0xc,%esp
801043eb:	68 cd 7e 10 80       	push   $0x80107ecd
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
8010440d:	e8 3e 07 00 00       	call   80104b50 <pushcli>
  c = mycpu();
80104412:	e8 f9 fa ff ff       	call   80103f10 <mycpu>
  p = c->proc;
80104417:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
8010441d:	e8 7e 07 00 00       	call   80104ba0 <popcli>
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
8010447a:	e8 d1 07 00 00       	call   80104c50 <acquire>
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
8010451d:	68 08 7f 10 80       	push   $0x80107f08
80104522:	e8 89 be ff ff       	call   801003b0 <panic>
    panic("init exiting");
80104527:	83 ec 0c             	sub    $0xc,%esp
8010452a:	68 fb 7e 10 80       	push   $0x80107efb
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
80104550:	e8 fb 06 00 00       	call   80104c50 <acquire>
  pushcli();
80104555:	e8 f6 05 00 00       	call   80104b50 <pushcli>
  c = mycpu();
8010455a:	e8 b1 f9 ff ff       	call   80103f10 <mycpu>
  p = c->proc;
8010455f:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104565:	e8 36 06 00 00       	call   80104ba0 <popcli>
  myproc()->state = RUNNABLE;
8010456a:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  sched();
80104571:	e8 ca fd ff ff       	call   80104340 <sched>
  release(&ptable.lock);
80104576:	c7 04 24 60 49 11 80 	movl   $0x80114960,(%esp)
8010457d:	e8 8e 07 00 00       	call   80104d10 <release>
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
801045a3:	e8 a8 05 00 00       	call   80104b50 <pushcli>
  c = mycpu();
801045a8:	e8 63 f9 ff ff       	call   80103f10 <mycpu>
  p = c->proc;
801045ad:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801045b3:	e8 e8 05 00 00       	call   80104ba0 <popcli>
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
801045d4:	e8 77 06 00 00       	call   80104c50 <acquire>
    release(lk);
801045d9:	89 34 24             	mov    %esi,(%esp)
801045dc:	e8 2f 07 00 00       	call   80104d10 <release>
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
801045fe:	e8 0d 07 00 00       	call   80104d10 <release>
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
80104610:	e9 3b 06 00 00       	jmp    80104c50 <acquire>
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
80104639:	68 1a 7f 10 80       	push   $0x80107f1a
8010463e:	e8 6d bd ff ff       	call   801003b0 <panic>
    panic("sleep");
80104643:	83 ec 0c             	sub    $0xc,%esp
80104646:	68 14 7f 10 80       	push   $0x80107f14
8010464b:	e8 60 bd ff ff       	call   801003b0 <panic>

80104650 <wait>:
{
80104650:	f3 0f 1e fb          	endbr32 
80104654:	55                   	push   %ebp
80104655:	89 e5                	mov    %esp,%ebp
80104657:	56                   	push   %esi
80104658:	53                   	push   %ebx
  pushcli();
80104659:	e8 f2 04 00 00       	call   80104b50 <pushcli>
  c = mycpu();
8010465e:	e8 ad f8 ff ff       	call   80103f10 <mycpu>
  p = c->proc;
80104663:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80104669:	e8 32 05 00 00       	call   80104ba0 <popcli>
  acquire(&ptable.lock);
8010466e:	83 ec 0c             	sub    $0xc,%esp
80104671:	68 60 49 11 80       	push   $0x80114960
80104676:	e8 d5 05 00 00       	call   80104c50 <acquire>
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
801046f1:	e8 ca 2e 00 00       	call   801075c0 <freevm>
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
8010471d:	e8 ee 05 00 00       	call   80104d10 <release>
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
8010473b:	e8 d0 05 00 00       	call   80104d10 <release>
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
80104763:	e8 e8 04 00 00       	call   80104c50 <acquire>
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
801047a9:	e9 62 05 00 00       	jmp    80104d10 <release>
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
801047c3:	e8 88 04 00 00       	call   80104c50 <acquire>
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
80104803:	e8 08 05 00 00       	call   80104d10 <release>
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
80104820:	e8 eb 04 00 00       	call   80104d10 <release>
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
80104863:	68 ef 82 10 80       	push   $0x801082ef
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
80104886:	ba 2b 7f 10 80       	mov    $0x80107f2b,%edx
    if (p->state >= 0 && p->state < NELEM(states) && states[p->state])
8010488b:	83 f8 05             	cmp    $0x5,%eax
8010488e:	77 11                	ja     801048a1 <procdump+0x61>
80104890:	8b 14 85 8c 7f 10 80 	mov    -0x7fef8074(,%eax,4),%edx
      state = "???";
80104897:	b8 2b 7f 10 80       	mov    $0x80107f2b,%eax
8010489c:	85 d2                	test   %edx,%edx
8010489e:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
801048a1:	53                   	push   %ebx
801048a2:	52                   	push   %edx
801048a3:	ff 73 a0             	pushl  -0x60(%ebx)
801048a6:	68 2f 7f 10 80       	push   $0x80107f2f
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
801048cd:	e8 1e 02 00 00       	call   80104af0 <getcallerpcs>
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
801048e5:	68 21 79 10 80       	push   $0x80107921
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

int sys_get_uncle_count(void)
{
80104910:	f3 0f 1e fb          	endbr32 
80104914:	55                   	push   %ebp
80104915:	89 e5                	mov    %esp,%ebp
80104917:	56                   	push   %esi
  // cprintf("inside get_uncle\n");
  acquire(&ptable.lock);
  int count = 0;
80104918:	31 f6                	xor    %esi,%esi
{
8010491a:	53                   	push   %ebx
  acquire(&ptable.lock);
8010491b:	83 ec 0c             	sub    $0xc,%esp
8010491e:	68 60 49 11 80       	push   $0x80114960
80104923:	e8 28 03 00 00       	call   80104c50 <acquire>
  pushcli();
80104928:	e8 23 02 00 00       	call   80104b50 <pushcli>
  c = mycpu();
8010492d:	e8 de f5 ff ff       	call   80103f10 <mycpu>
  p = c->proc;
80104932:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104938:	e8 63 02 00 00       	call   80104ba0 <popcli>
8010493d:	83 c4 10             	add    $0x10,%esp
  struct proc *my_proc = myproc(); // Get the current process
  // cprintf("currenct pid: %d\n",my_proc->pid);
  struct proc *curr_proc;

  for (curr_proc = ptable.proc; curr_proc < &ptable.proc[NPROC]; curr_proc++)
80104940:	b8 94 49 11 80       	mov    $0x80114994,%eax
80104945:	8d 76 00             	lea    0x0(%esi),%esi
  {
    if (curr_proc->state == UNUSED || curr_proc->state == EMBRYO || curr_proc->pid == my_proc->pid)
80104948:	83 78 0c 01          	cmpl   $0x1,0xc(%eax)
8010494c:	76 21                	jbe    8010496f <sys_get_uncle_count+0x5f>
8010494e:	8b 4b 10             	mov    0x10(%ebx),%ecx
80104951:	39 48 10             	cmp    %ecx,0x10(%eax)
80104954:	74 19                	je     8010496f <sys_get_uncle_count+0x5f>
      continue;
    // cprintf("in for loop for pid:%d\n",curr_proc->pid);
    if (curr_proc->parent && curr_proc->parent->parent && curr_proc->parent->parent == my_proc)
80104956:	8b 50 14             	mov    0x14(%eax),%edx
80104959:	85 d2                	test   %edx,%edx
8010495b:	74 12                	je     8010496f <sys_get_uncle_count+0x5f>
8010495d:	8b 52 14             	mov    0x14(%edx),%edx
80104960:	85 d2                	test   %edx,%edx
80104962:	74 0b                	je     8010496f <sys_get_uncle_count+0x5f>
80104964:	39 da                	cmp    %ebx,%edx
80104966:	0f 94 c2             	sete   %dl
    {
      count++;
80104969:	80 fa 01             	cmp    $0x1,%dl
8010496c:	83 de ff             	sbb    $0xffffffff,%esi
  for (curr_proc = ptable.proc; curr_proc < &ptable.proc[NPROC]; curr_proc++)
8010496f:	83 e8 80             	sub    $0xffffff80,%eax
80104972:	3d 94 69 11 80       	cmp    $0x80116994,%eax
80104977:	75 cf                	jne    80104948 <sys_get_uncle_count+0x38>
    }
  }
  release(&ptable.lock);
80104979:	83 ec 0c             	sub    $0xc,%esp
8010497c:	68 60 49 11 80       	push   $0x80114960
80104981:	e8 8a 03 00 00       	call   80104d10 <release>

  // cprintf("done\n");
  return count;
}
80104986:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104989:	89 f0                	mov    %esi,%eax
8010498b:	5b                   	pop    %ebx
8010498c:	5e                   	pop    %esi
8010498d:	5d                   	pop    %ebp
8010498e:	c3                   	ret    
8010498f:	90                   	nop

80104990 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80104990:	f3 0f 1e fb          	endbr32 
80104994:	55                   	push   %ebp
80104995:	89 e5                	mov    %esp,%ebp
80104997:	53                   	push   %ebx
80104998:	83 ec 0c             	sub    $0xc,%esp
8010499b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
8010499e:	68 a4 7f 10 80       	push   $0x80107fa4
801049a3:	8d 43 04             	lea    0x4(%ebx),%eax
801049a6:	50                   	push   %eax
801049a7:	e8 24 01 00 00       	call   80104ad0 <initlock>
  lk->name = name;
801049ac:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
801049af:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
801049b5:	83 c4 10             	add    $0x10,%esp
  lk->pid = 0;
801049b8:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
801049bf:	89 43 38             	mov    %eax,0x38(%ebx)
}
801049c2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801049c5:	c9                   	leave  
801049c6:	c3                   	ret    
801049c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801049ce:	66 90                	xchg   %ax,%ax

801049d0 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
801049d0:	f3 0f 1e fb          	endbr32 
801049d4:	55                   	push   %ebp
801049d5:	89 e5                	mov    %esp,%ebp
801049d7:	56                   	push   %esi
801049d8:	53                   	push   %ebx
801049d9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
801049dc:	8d 73 04             	lea    0x4(%ebx),%esi
801049df:	83 ec 0c             	sub    $0xc,%esp
801049e2:	56                   	push   %esi
801049e3:	e8 68 02 00 00       	call   80104c50 <acquire>
  while (lk->locked) {
801049e8:	8b 13                	mov    (%ebx),%edx
801049ea:	83 c4 10             	add    $0x10,%esp
801049ed:	85 d2                	test   %edx,%edx
801049ef:	74 1a                	je     80104a0b <acquiresleep+0x3b>
801049f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    sleep(lk, &lk->lk);
801049f8:	83 ec 08             	sub    $0x8,%esp
801049fb:	56                   	push   %esi
801049fc:	53                   	push   %ebx
801049fd:	e8 8e fb ff ff       	call   80104590 <sleep>
  while (lk->locked) {
80104a02:	8b 03                	mov    (%ebx),%eax
80104a04:	83 c4 10             	add    $0x10,%esp
80104a07:	85 c0                	test   %eax,%eax
80104a09:	75 ed                	jne    801049f8 <acquiresleep+0x28>
  }
  lk->locked = 1;
80104a0b:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
80104a11:	e8 8a f5 ff ff       	call   80103fa0 <myproc>
80104a16:	8b 40 10             	mov    0x10(%eax),%eax
80104a19:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
80104a1c:	89 75 08             	mov    %esi,0x8(%ebp)
}
80104a1f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104a22:	5b                   	pop    %ebx
80104a23:	5e                   	pop    %esi
80104a24:	5d                   	pop    %ebp
  release(&lk->lk);
80104a25:	e9 e6 02 00 00       	jmp    80104d10 <release>
80104a2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104a30 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
80104a30:	f3 0f 1e fb          	endbr32 
80104a34:	55                   	push   %ebp
80104a35:	89 e5                	mov    %esp,%ebp
80104a37:	56                   	push   %esi
80104a38:	53                   	push   %ebx
80104a39:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104a3c:	8d 73 04             	lea    0x4(%ebx),%esi
80104a3f:	83 ec 0c             	sub    $0xc,%esp
80104a42:	56                   	push   %esi
80104a43:	e8 08 02 00 00       	call   80104c50 <acquire>
  lk->locked = 0;
80104a48:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
80104a4e:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
80104a55:	89 1c 24             	mov    %ebx,(%esp)
80104a58:	e8 f3 fc ff ff       	call   80104750 <wakeup>
  release(&lk->lk);
80104a5d:	89 75 08             	mov    %esi,0x8(%ebp)
80104a60:	83 c4 10             	add    $0x10,%esp
}
80104a63:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104a66:	5b                   	pop    %ebx
80104a67:	5e                   	pop    %esi
80104a68:	5d                   	pop    %ebp
  release(&lk->lk);
80104a69:	e9 a2 02 00 00       	jmp    80104d10 <release>
80104a6e:	66 90                	xchg   %ax,%ax

80104a70 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
80104a70:	f3 0f 1e fb          	endbr32 
80104a74:	55                   	push   %ebp
80104a75:	89 e5                	mov    %esp,%ebp
80104a77:	57                   	push   %edi
80104a78:	31 ff                	xor    %edi,%edi
80104a7a:	56                   	push   %esi
80104a7b:	53                   	push   %ebx
80104a7c:	83 ec 18             	sub    $0x18,%esp
80104a7f:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;
  
  acquire(&lk->lk);
80104a82:	8d 73 04             	lea    0x4(%ebx),%esi
80104a85:	56                   	push   %esi
80104a86:	e8 c5 01 00 00       	call   80104c50 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
80104a8b:	8b 03                	mov    (%ebx),%eax
80104a8d:	83 c4 10             	add    $0x10,%esp
80104a90:	85 c0                	test   %eax,%eax
80104a92:	75 1c                	jne    80104ab0 <holdingsleep+0x40>
  release(&lk->lk);
80104a94:	83 ec 0c             	sub    $0xc,%esp
80104a97:	56                   	push   %esi
80104a98:	e8 73 02 00 00       	call   80104d10 <release>
  return r;
}
80104a9d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104aa0:	89 f8                	mov    %edi,%eax
80104aa2:	5b                   	pop    %ebx
80104aa3:	5e                   	pop    %esi
80104aa4:	5f                   	pop    %edi
80104aa5:	5d                   	pop    %ebp
80104aa6:	c3                   	ret    
80104aa7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104aae:	66 90                	xchg   %ax,%ax
  r = lk->locked && (lk->pid == myproc()->pid);
80104ab0:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
80104ab3:	e8 e8 f4 ff ff       	call   80103fa0 <myproc>
80104ab8:	39 58 10             	cmp    %ebx,0x10(%eax)
80104abb:	0f 94 c0             	sete   %al
80104abe:	0f b6 c0             	movzbl %al,%eax
80104ac1:	89 c7                	mov    %eax,%edi
80104ac3:	eb cf                	jmp    80104a94 <holdingsleep+0x24>
80104ac5:	66 90                	xchg   %ax,%ax
80104ac7:	66 90                	xchg   %ax,%ax
80104ac9:	66 90                	xchg   %ax,%ax
80104acb:	66 90                	xchg   %ax,%ax
80104acd:	66 90                	xchg   %ax,%ax
80104acf:	90                   	nop

80104ad0 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80104ad0:	f3 0f 1e fb          	endbr32 
80104ad4:	55                   	push   %ebp
80104ad5:	89 e5                	mov    %esp,%ebp
80104ad7:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80104ada:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
80104add:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
80104ae3:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
80104ae6:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80104aed:	5d                   	pop    %ebp
80104aee:	c3                   	ret    
80104aef:	90                   	nop

80104af0 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80104af0:	f3 0f 1e fb          	endbr32 
80104af4:	55                   	push   %ebp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104af5:	31 d2                	xor    %edx,%edx
{
80104af7:	89 e5                	mov    %esp,%ebp
80104af9:	53                   	push   %ebx
  ebp = (uint*)v - 2;
80104afa:	8b 45 08             	mov    0x8(%ebp),%eax
{
80104afd:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  ebp = (uint*)v - 2;
80104b00:	83 e8 08             	sub    $0x8,%eax
  for(i = 0; i < 10; i++){
80104b03:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104b07:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104b08:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
80104b0e:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
80104b14:	77 1a                	ja     80104b30 <getcallerpcs+0x40>
      break;
    pcs[i] = ebp[1];     // saved %eip
80104b16:	8b 58 04             	mov    0x4(%eax),%ebx
80104b19:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
80104b1c:	83 c2 01             	add    $0x1,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
80104b1f:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80104b21:	83 fa 0a             	cmp    $0xa,%edx
80104b24:	75 e2                	jne    80104b08 <getcallerpcs+0x18>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
80104b26:	5b                   	pop    %ebx
80104b27:	5d                   	pop    %ebp
80104b28:	c3                   	ret    
80104b29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(; i < 10; i++)
80104b30:	8d 04 91             	lea    (%ecx,%edx,4),%eax
80104b33:	8d 51 28             	lea    0x28(%ecx),%edx
80104b36:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104b3d:	8d 76 00             	lea    0x0(%esi),%esi
    pcs[i] = 0;
80104b40:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
80104b46:	83 c0 04             	add    $0x4,%eax
80104b49:	39 d0                	cmp    %edx,%eax
80104b4b:	75 f3                	jne    80104b40 <getcallerpcs+0x50>
}
80104b4d:	5b                   	pop    %ebx
80104b4e:	5d                   	pop    %ebp
80104b4f:	c3                   	ret    

80104b50 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80104b50:	f3 0f 1e fb          	endbr32 
80104b54:	55                   	push   %ebp
80104b55:	89 e5                	mov    %esp,%ebp
80104b57:	53                   	push   %ebx
80104b58:	83 ec 04             	sub    $0x4,%esp
80104b5b:	9c                   	pushf  
80104b5c:	5b                   	pop    %ebx
  asm volatile("cli");
80104b5d:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
80104b5e:	e8 ad f3 ff ff       	call   80103f10 <mycpu>
80104b63:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
80104b69:	85 c0                	test   %eax,%eax
80104b6b:	74 13                	je     80104b80 <pushcli+0x30>
    mycpu()->intena = eflags & FL_IF;
  mycpu()->ncli += 1;
80104b6d:	e8 9e f3 ff ff       	call   80103f10 <mycpu>
80104b72:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
80104b79:	83 c4 04             	add    $0x4,%esp
80104b7c:	5b                   	pop    %ebx
80104b7d:	5d                   	pop    %ebp
80104b7e:	c3                   	ret    
80104b7f:	90                   	nop
    mycpu()->intena = eflags & FL_IF;
80104b80:	e8 8b f3 ff ff       	call   80103f10 <mycpu>
80104b85:	81 e3 00 02 00 00    	and    $0x200,%ebx
80104b8b:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
80104b91:	eb da                	jmp    80104b6d <pushcli+0x1d>
80104b93:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104b9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104ba0 <popcli>:

void
popcli(void)
{
80104ba0:	f3 0f 1e fb          	endbr32 
80104ba4:	55                   	push   %ebp
80104ba5:	89 e5                	mov    %esp,%ebp
80104ba7:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r"(eflags));
80104baa:	9c                   	pushf  
80104bab:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104bac:	f6 c4 02             	test   $0x2,%ah
80104baf:	75 31                	jne    80104be2 <popcli+0x42>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
80104bb1:	e8 5a f3 ff ff       	call   80103f10 <mycpu>
80104bb6:	83 a8 a4 00 00 00 01 	subl   $0x1,0xa4(%eax)
80104bbd:	78 30                	js     80104bef <popcli+0x4f>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104bbf:	e8 4c f3 ff ff       	call   80103f10 <mycpu>
80104bc4:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80104bca:	85 d2                	test   %edx,%edx
80104bcc:	74 02                	je     80104bd0 <popcli+0x30>
    sti();
}
80104bce:	c9                   	leave  
80104bcf:	c3                   	ret    
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104bd0:	e8 3b f3 ff ff       	call   80103f10 <mycpu>
80104bd5:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
80104bdb:	85 c0                	test   %eax,%eax
80104bdd:	74 ef                	je     80104bce <popcli+0x2e>
  asm volatile("sti");
80104bdf:	fb                   	sti    
}
80104be0:	c9                   	leave  
80104be1:	c3                   	ret    
    panic("popcli - interruptible");
80104be2:	83 ec 0c             	sub    $0xc,%esp
80104be5:	68 af 7f 10 80       	push   $0x80107faf
80104bea:	e8 c1 b7 ff ff       	call   801003b0 <panic>
    panic("popcli");
80104bef:	83 ec 0c             	sub    $0xc,%esp
80104bf2:	68 c6 7f 10 80       	push   $0x80107fc6
80104bf7:	e8 b4 b7 ff ff       	call   801003b0 <panic>
80104bfc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104c00 <holding>:
{
80104c00:	f3 0f 1e fb          	endbr32 
80104c04:	55                   	push   %ebp
80104c05:	89 e5                	mov    %esp,%ebp
80104c07:	56                   	push   %esi
80104c08:	53                   	push   %ebx
80104c09:	8b 75 08             	mov    0x8(%ebp),%esi
80104c0c:	31 db                	xor    %ebx,%ebx
  pushcli();
80104c0e:	e8 3d ff ff ff       	call   80104b50 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
80104c13:	8b 06                	mov    (%esi),%eax
80104c15:	85 c0                	test   %eax,%eax
80104c17:	75 0f                	jne    80104c28 <holding+0x28>
  popcli();
80104c19:	e8 82 ff ff ff       	call   80104ba0 <popcli>
}
80104c1e:	89 d8                	mov    %ebx,%eax
80104c20:	5b                   	pop    %ebx
80104c21:	5e                   	pop    %esi
80104c22:	5d                   	pop    %ebp
80104c23:	c3                   	ret    
80104c24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  r = lock->locked && lock->cpu == mycpu();
80104c28:	8b 5e 08             	mov    0x8(%esi),%ebx
80104c2b:	e8 e0 f2 ff ff       	call   80103f10 <mycpu>
80104c30:	39 c3                	cmp    %eax,%ebx
80104c32:	0f 94 c3             	sete   %bl
  popcli();
80104c35:	e8 66 ff ff ff       	call   80104ba0 <popcli>
  r = lock->locked && lock->cpu == mycpu();
80104c3a:	0f b6 db             	movzbl %bl,%ebx
}
80104c3d:	89 d8                	mov    %ebx,%eax
80104c3f:	5b                   	pop    %ebx
80104c40:	5e                   	pop    %esi
80104c41:	5d                   	pop    %ebp
80104c42:	c3                   	ret    
80104c43:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104c4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104c50 <acquire>:
{
80104c50:	f3 0f 1e fb          	endbr32 
80104c54:	55                   	push   %ebp
80104c55:	89 e5                	mov    %esp,%ebp
80104c57:	56                   	push   %esi
80104c58:	53                   	push   %ebx
  pushcli(); // disable interrupts to avoid deadlock.
80104c59:	e8 f2 fe ff ff       	call   80104b50 <pushcli>
  if(holding(lk))
80104c5e:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104c61:	83 ec 0c             	sub    $0xc,%esp
80104c64:	53                   	push   %ebx
80104c65:	e8 96 ff ff ff       	call   80104c00 <holding>
80104c6a:	83 c4 10             	add    $0x10,%esp
80104c6d:	85 c0                	test   %eax,%eax
80104c6f:	0f 85 7f 00 00 00    	jne    80104cf4 <acquire+0xa4>
80104c75:	89 c6                	mov    %eax,%esi
  asm volatile("lock; xchgl %0, %1" : "+m"(*addr), "=a"(result) : "1"(newval) : "cc");
80104c77:	ba 01 00 00 00       	mov    $0x1,%edx
80104c7c:	eb 05                	jmp    80104c83 <acquire+0x33>
80104c7e:	66 90                	xchg   %ax,%ax
80104c80:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104c83:	89 d0                	mov    %edx,%eax
80104c85:	f0 87 03             	lock xchg %eax,(%ebx)
  while(xchg(&lk->locked, 1) != 0)
80104c88:	85 c0                	test   %eax,%eax
80104c8a:	75 f4                	jne    80104c80 <acquire+0x30>
  __sync_synchronize();
80104c8c:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
80104c91:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104c94:	e8 77 f2 ff ff       	call   80103f10 <mycpu>
80104c99:	89 43 08             	mov    %eax,0x8(%ebx)
  ebp = (uint*)v - 2;
80104c9c:	89 e8                	mov    %ebp,%eax
80104c9e:	66 90                	xchg   %ax,%ax
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104ca0:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
80104ca6:	81 fa fe ff ff 7f    	cmp    $0x7ffffffe,%edx
80104cac:	77 22                	ja     80104cd0 <acquire+0x80>
    pcs[i] = ebp[1];     // saved %eip
80104cae:	8b 50 04             	mov    0x4(%eax),%edx
80104cb1:	89 54 b3 0c          	mov    %edx,0xc(%ebx,%esi,4)
  for(i = 0; i < 10; i++){
80104cb5:	83 c6 01             	add    $0x1,%esi
    ebp = (uint*)ebp[0]; // saved %ebp
80104cb8:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80104cba:	83 fe 0a             	cmp    $0xa,%esi
80104cbd:	75 e1                	jne    80104ca0 <acquire+0x50>
}
80104cbf:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104cc2:	5b                   	pop    %ebx
80104cc3:	5e                   	pop    %esi
80104cc4:	5d                   	pop    %ebp
80104cc5:	c3                   	ret    
80104cc6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104ccd:	8d 76 00             	lea    0x0(%esi),%esi
  for(; i < 10; i++)
80104cd0:	8d 44 b3 0c          	lea    0xc(%ebx,%esi,4),%eax
80104cd4:	83 c3 34             	add    $0x34,%ebx
80104cd7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104cde:	66 90                	xchg   %ax,%ax
    pcs[i] = 0;
80104ce0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
80104ce6:	83 c0 04             	add    $0x4,%eax
80104ce9:	39 d8                	cmp    %ebx,%eax
80104ceb:	75 f3                	jne    80104ce0 <acquire+0x90>
}
80104ced:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104cf0:	5b                   	pop    %ebx
80104cf1:	5e                   	pop    %esi
80104cf2:	5d                   	pop    %ebp
80104cf3:	c3                   	ret    
    panic("acquire");
80104cf4:	83 ec 0c             	sub    $0xc,%esp
80104cf7:	68 cd 7f 10 80       	push   $0x80107fcd
80104cfc:	e8 af b6 ff ff       	call   801003b0 <panic>
80104d01:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104d08:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104d0f:	90                   	nop

80104d10 <release>:
{
80104d10:	f3 0f 1e fb          	endbr32 
80104d14:	55                   	push   %ebp
80104d15:	89 e5                	mov    %esp,%ebp
80104d17:	53                   	push   %ebx
80104d18:	83 ec 10             	sub    $0x10,%esp
80104d1b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holding(lk))
80104d1e:	53                   	push   %ebx
80104d1f:	e8 dc fe ff ff       	call   80104c00 <holding>
80104d24:	83 c4 10             	add    $0x10,%esp
80104d27:	85 c0                	test   %eax,%eax
80104d29:	74 22                	je     80104d4d <release+0x3d>
  lk->pcs[0] = 0;
80104d2b:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
80104d32:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
80104d39:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
80104d3e:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
80104d44:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104d47:	c9                   	leave  
  popcli();
80104d48:	e9 53 fe ff ff       	jmp    80104ba0 <popcli>
    panic("release");
80104d4d:	83 ec 0c             	sub    $0xc,%esp
80104d50:	68 d5 7f 10 80       	push   $0x80107fd5
80104d55:	e8 56 b6 ff ff       	call   801003b0 <panic>
80104d5a:	66 90                	xchg   %ax,%ax
80104d5c:	66 90                	xchg   %ax,%ax
80104d5e:	66 90                	xchg   %ax,%ax

80104d60 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80104d60:	f3 0f 1e fb          	endbr32 
80104d64:	55                   	push   %ebp
80104d65:	89 e5                	mov    %esp,%ebp
80104d67:	57                   	push   %edi
80104d68:	8b 55 08             	mov    0x8(%ebp),%edx
80104d6b:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104d6e:	53                   	push   %ebx
80104d6f:	8b 45 0c             	mov    0xc(%ebp),%eax
  if ((int)dst%4 == 0 && n%4 == 0){
80104d72:	89 d7                	mov    %edx,%edi
80104d74:	09 cf                	or     %ecx,%edi
80104d76:	83 e7 03             	and    $0x3,%edi
80104d79:	75 25                	jne    80104da0 <memset+0x40>
    c &= 0xFF;
80104d7b:	0f b6 f8             	movzbl %al,%edi
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
80104d7e:	c1 e0 18             	shl    $0x18,%eax
80104d81:	89 fb                	mov    %edi,%ebx
80104d83:	c1 e9 02             	shr    $0x2,%ecx
80104d86:	c1 e3 10             	shl    $0x10,%ebx
80104d89:	09 d8                	or     %ebx,%eax
80104d8b:	09 f8                	or     %edi,%eax
80104d8d:	c1 e7 08             	shl    $0x8,%edi
80104d90:	09 f8                	or     %edi,%eax
  asm volatile("cld; rep stosl" : "=D"(addr), "=c"(cnt) : "0"(addr), "1"(cnt), "a"(data) : "memory", "cc");
80104d92:	89 d7                	mov    %edx,%edi
80104d94:	fc                   	cld    
80104d95:	f3 ab                	rep stos %eax,%es:(%edi)
  } else
    stosb(dst, c, n);
  return dst;
}
80104d97:	5b                   	pop    %ebx
80104d98:	89 d0                	mov    %edx,%eax
80104d9a:	5f                   	pop    %edi
80104d9b:	5d                   	pop    %ebp
80104d9c:	c3                   	ret    
80104d9d:	8d 76 00             	lea    0x0(%esi),%esi
  asm volatile("cld; rep stosb" : "=D"(addr), "=c"(cnt) : "0"(addr), "1"(cnt), "a"(data) : "memory", "cc");
80104da0:	89 d7                	mov    %edx,%edi
80104da2:	fc                   	cld    
80104da3:	f3 aa                	rep stos %al,%es:(%edi)
80104da5:	5b                   	pop    %ebx
80104da6:	89 d0                	mov    %edx,%eax
80104da8:	5f                   	pop    %edi
80104da9:	5d                   	pop    %ebp
80104daa:	c3                   	ret    
80104dab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104daf:	90                   	nop

80104db0 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80104db0:	f3 0f 1e fb          	endbr32 
80104db4:	55                   	push   %ebp
80104db5:	89 e5                	mov    %esp,%ebp
80104db7:	56                   	push   %esi
80104db8:	8b 75 10             	mov    0x10(%ebp),%esi
80104dbb:	8b 55 08             	mov    0x8(%ebp),%edx
80104dbe:	53                   	push   %ebx
80104dbf:	8b 45 0c             	mov    0xc(%ebp),%eax
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
80104dc2:	85 f6                	test   %esi,%esi
80104dc4:	74 2a                	je     80104df0 <memcmp+0x40>
80104dc6:	01 c6                	add    %eax,%esi
80104dc8:	eb 10                	jmp    80104dda <memcmp+0x2a>
80104dca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
80104dd0:	83 c0 01             	add    $0x1,%eax
80104dd3:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0){
80104dd6:	39 f0                	cmp    %esi,%eax
80104dd8:	74 16                	je     80104df0 <memcmp+0x40>
    if(*s1 != *s2)
80104dda:	0f b6 0a             	movzbl (%edx),%ecx
80104ddd:	0f b6 18             	movzbl (%eax),%ebx
80104de0:	38 d9                	cmp    %bl,%cl
80104de2:	74 ec                	je     80104dd0 <memcmp+0x20>
      return *s1 - *s2;
80104de4:	0f b6 c1             	movzbl %cl,%eax
80104de7:	29 d8                	sub    %ebx,%eax
  }

  return 0;
}
80104de9:	5b                   	pop    %ebx
80104dea:	5e                   	pop    %esi
80104deb:	5d                   	pop    %ebp
80104dec:	c3                   	ret    
80104ded:	8d 76 00             	lea    0x0(%esi),%esi
80104df0:	5b                   	pop    %ebx
  return 0;
80104df1:	31 c0                	xor    %eax,%eax
}
80104df3:	5e                   	pop    %esi
80104df4:	5d                   	pop    %ebp
80104df5:	c3                   	ret    
80104df6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104dfd:	8d 76 00             	lea    0x0(%esi),%esi

80104e00 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80104e00:	f3 0f 1e fb          	endbr32 
80104e04:	55                   	push   %ebp
80104e05:	89 e5                	mov    %esp,%ebp
80104e07:	57                   	push   %edi
80104e08:	8b 55 08             	mov    0x8(%ebp),%edx
80104e0b:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104e0e:	56                   	push   %esi
80104e0f:	8b 75 0c             	mov    0xc(%ebp),%esi
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
80104e12:	39 d6                	cmp    %edx,%esi
80104e14:	73 2a                	jae    80104e40 <memmove+0x40>
80104e16:	8d 3c 0e             	lea    (%esi,%ecx,1),%edi
80104e19:	39 fa                	cmp    %edi,%edx
80104e1b:	73 23                	jae    80104e40 <memmove+0x40>
80104e1d:	8d 41 ff             	lea    -0x1(%ecx),%eax
    s += n;
    d += n;
    while(n-- > 0)
80104e20:	85 c9                	test   %ecx,%ecx
80104e22:	74 13                	je     80104e37 <memmove+0x37>
80104e24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      *--d = *--s;
80104e28:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
80104e2c:	88 0c 02             	mov    %cl,(%edx,%eax,1)
    while(n-- > 0)
80104e2f:	83 e8 01             	sub    $0x1,%eax
80104e32:	83 f8 ff             	cmp    $0xffffffff,%eax
80104e35:	75 f1                	jne    80104e28 <memmove+0x28>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
80104e37:	5e                   	pop    %esi
80104e38:	89 d0                	mov    %edx,%eax
80104e3a:	5f                   	pop    %edi
80104e3b:	5d                   	pop    %ebp
80104e3c:	c3                   	ret    
80104e3d:	8d 76 00             	lea    0x0(%esi),%esi
    while(n-- > 0)
80104e40:	8d 04 0e             	lea    (%esi,%ecx,1),%eax
80104e43:	89 d7                	mov    %edx,%edi
80104e45:	85 c9                	test   %ecx,%ecx
80104e47:	74 ee                	je     80104e37 <memmove+0x37>
80104e49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      *d++ = *s++;
80104e50:	a4                   	movsb  %ds:(%esi),%es:(%edi)
    while(n-- > 0)
80104e51:	39 f0                	cmp    %esi,%eax
80104e53:	75 fb                	jne    80104e50 <memmove+0x50>
}
80104e55:	5e                   	pop    %esi
80104e56:	89 d0                	mov    %edx,%eax
80104e58:	5f                   	pop    %edi
80104e59:	5d                   	pop    %ebp
80104e5a:	c3                   	ret    
80104e5b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104e5f:	90                   	nop

80104e60 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
80104e60:	f3 0f 1e fb          	endbr32 
  return memmove(dst, src, n);
80104e64:	eb 9a                	jmp    80104e00 <memmove>
80104e66:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104e6d:	8d 76 00             	lea    0x0(%esi),%esi

80104e70 <strncmp>:
}

int
strncmp(const char *p, const char *q, uint n)
{
80104e70:	f3 0f 1e fb          	endbr32 
80104e74:	55                   	push   %ebp
80104e75:	89 e5                	mov    %esp,%ebp
80104e77:	56                   	push   %esi
80104e78:	8b 75 10             	mov    0x10(%ebp),%esi
80104e7b:	8b 4d 08             	mov    0x8(%ebp),%ecx
80104e7e:	53                   	push   %ebx
80104e7f:	8b 45 0c             	mov    0xc(%ebp),%eax
  while(n > 0 && *p && *p == *q)
80104e82:	85 f6                	test   %esi,%esi
80104e84:	74 32                	je     80104eb8 <strncmp+0x48>
80104e86:	01 c6                	add    %eax,%esi
80104e88:	eb 14                	jmp    80104e9e <strncmp+0x2e>
80104e8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104e90:	38 da                	cmp    %bl,%dl
80104e92:	75 14                	jne    80104ea8 <strncmp+0x38>
    n--, p++, q++;
80104e94:	83 c0 01             	add    $0x1,%eax
80104e97:	83 c1 01             	add    $0x1,%ecx
  while(n > 0 && *p && *p == *q)
80104e9a:	39 f0                	cmp    %esi,%eax
80104e9c:	74 1a                	je     80104eb8 <strncmp+0x48>
80104e9e:	0f b6 11             	movzbl (%ecx),%edx
80104ea1:	0f b6 18             	movzbl (%eax),%ebx
80104ea4:	84 d2                	test   %dl,%dl
80104ea6:	75 e8                	jne    80104e90 <strncmp+0x20>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
80104ea8:	0f b6 c2             	movzbl %dl,%eax
80104eab:	29 d8                	sub    %ebx,%eax
}
80104ead:	5b                   	pop    %ebx
80104eae:	5e                   	pop    %esi
80104eaf:	5d                   	pop    %ebp
80104eb0:	c3                   	ret    
80104eb1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104eb8:	5b                   	pop    %ebx
    return 0;
80104eb9:	31 c0                	xor    %eax,%eax
}
80104ebb:	5e                   	pop    %esi
80104ebc:	5d                   	pop    %ebp
80104ebd:	c3                   	ret    
80104ebe:	66 90                	xchg   %ax,%ax

80104ec0 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80104ec0:	f3 0f 1e fb          	endbr32 
80104ec4:	55                   	push   %ebp
80104ec5:	89 e5                	mov    %esp,%ebp
80104ec7:	57                   	push   %edi
80104ec8:	56                   	push   %esi
80104ec9:	8b 75 08             	mov    0x8(%ebp),%esi
80104ecc:	53                   	push   %ebx
80104ecd:	8b 45 10             	mov    0x10(%ebp),%eax
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
80104ed0:	89 f2                	mov    %esi,%edx
80104ed2:	eb 1b                	jmp    80104eef <strncpy+0x2f>
80104ed4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104ed8:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
80104edc:	8b 7d 0c             	mov    0xc(%ebp),%edi
80104edf:	83 c2 01             	add    $0x1,%edx
80104ee2:	0f b6 7f ff          	movzbl -0x1(%edi),%edi
80104ee6:	89 f9                	mov    %edi,%ecx
80104ee8:	88 4a ff             	mov    %cl,-0x1(%edx)
80104eeb:	84 c9                	test   %cl,%cl
80104eed:	74 09                	je     80104ef8 <strncpy+0x38>
80104eef:	89 c3                	mov    %eax,%ebx
80104ef1:	83 e8 01             	sub    $0x1,%eax
80104ef4:	85 db                	test   %ebx,%ebx
80104ef6:	7f e0                	jg     80104ed8 <strncpy+0x18>
    ;
  while(n-- > 0)
80104ef8:	89 d1                	mov    %edx,%ecx
80104efa:	85 c0                	test   %eax,%eax
80104efc:	7e 15                	jle    80104f13 <strncpy+0x53>
80104efe:	66 90                	xchg   %ax,%ax
    *s++ = 0;
80104f00:	83 c1 01             	add    $0x1,%ecx
80104f03:	c6 41 ff 00          	movb   $0x0,-0x1(%ecx)
  while(n-- > 0)
80104f07:	89 c8                	mov    %ecx,%eax
80104f09:	f7 d0                	not    %eax
80104f0b:	01 d0                	add    %edx,%eax
80104f0d:	01 d8                	add    %ebx,%eax
80104f0f:	85 c0                	test   %eax,%eax
80104f11:	7f ed                	jg     80104f00 <strncpy+0x40>
  return os;
}
80104f13:	5b                   	pop    %ebx
80104f14:	89 f0                	mov    %esi,%eax
80104f16:	5e                   	pop    %esi
80104f17:	5f                   	pop    %edi
80104f18:	5d                   	pop    %ebp
80104f19:	c3                   	ret    
80104f1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104f20 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80104f20:	f3 0f 1e fb          	endbr32 
80104f24:	55                   	push   %ebp
80104f25:	89 e5                	mov    %esp,%ebp
80104f27:	56                   	push   %esi
80104f28:	8b 55 10             	mov    0x10(%ebp),%edx
80104f2b:	8b 75 08             	mov    0x8(%ebp),%esi
80104f2e:	53                   	push   %ebx
80104f2f:	8b 45 0c             	mov    0xc(%ebp),%eax
  char *os;

  os = s;
  if(n <= 0)
80104f32:	85 d2                	test   %edx,%edx
80104f34:	7e 21                	jle    80104f57 <safestrcpy+0x37>
80104f36:	8d 5c 10 ff          	lea    -0x1(%eax,%edx,1),%ebx
80104f3a:	89 f2                	mov    %esi,%edx
80104f3c:	eb 12                	jmp    80104f50 <safestrcpy+0x30>
80104f3e:	66 90                	xchg   %ax,%ax
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80104f40:	0f b6 08             	movzbl (%eax),%ecx
80104f43:	83 c0 01             	add    $0x1,%eax
80104f46:	83 c2 01             	add    $0x1,%edx
80104f49:	88 4a ff             	mov    %cl,-0x1(%edx)
80104f4c:	84 c9                	test   %cl,%cl
80104f4e:	74 04                	je     80104f54 <safestrcpy+0x34>
80104f50:	39 d8                	cmp    %ebx,%eax
80104f52:	75 ec                	jne    80104f40 <safestrcpy+0x20>
    ;
  *s = 0;
80104f54:	c6 02 00             	movb   $0x0,(%edx)
  return os;
}
80104f57:	89 f0                	mov    %esi,%eax
80104f59:	5b                   	pop    %ebx
80104f5a:	5e                   	pop    %esi
80104f5b:	5d                   	pop    %ebp
80104f5c:	c3                   	ret    
80104f5d:	8d 76 00             	lea    0x0(%esi),%esi

80104f60 <strlen>:

int
strlen(const char *s)
{
80104f60:	f3 0f 1e fb          	endbr32 
80104f64:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80104f65:	31 c0                	xor    %eax,%eax
{
80104f67:	89 e5                	mov    %esp,%ebp
80104f69:	8b 55 08             	mov    0x8(%ebp),%edx
  for(n = 0; s[n]; n++)
80104f6c:	80 3a 00             	cmpb   $0x0,(%edx)
80104f6f:	74 10                	je     80104f81 <strlen+0x21>
80104f71:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104f78:	83 c0 01             	add    $0x1,%eax
80104f7b:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80104f7f:	75 f7                	jne    80104f78 <strlen+0x18>
    ;
  return n;
}
80104f81:	5d                   	pop    %ebp
80104f82:	c3                   	ret    

80104f83 <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
80104f83:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
80104f87:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-saved registers
  pushl %ebp
80104f8b:	55                   	push   %ebp
  pushl %ebx
80104f8c:	53                   	push   %ebx
  pushl %esi
80104f8d:	56                   	push   %esi
  pushl %edi
80104f8e:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
80104f8f:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
80104f91:	89 d4                	mov    %edx,%esp

  # Load new callee-saved registers
  popl %edi
80104f93:	5f                   	pop    %edi
  popl %esi
80104f94:	5e                   	pop    %esi
  popl %ebx
80104f95:	5b                   	pop    %ebx
  popl %ebp
80104f96:	5d                   	pop    %ebp
  ret
80104f97:	c3                   	ret    
80104f98:	66 90                	xchg   %ax,%ax
80104f9a:	66 90                	xchg   %ax,%ax
80104f9c:	66 90                	xchg   %ax,%ax
80104f9e:	66 90                	xchg   %ax,%ax

80104fa0 <fetchint>:
// library system call function. The saved user %esp points
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int fetchint(uint addr, int *ip)
{
80104fa0:	f3 0f 1e fb          	endbr32 
80104fa4:	55                   	push   %ebp
80104fa5:	89 e5                	mov    %esp,%ebp
80104fa7:	53                   	push   %ebx
80104fa8:	83 ec 04             	sub    $0x4,%esp
80104fab:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
80104fae:	e8 ed ef ff ff       	call   80103fa0 <myproc>

  if (addr >= curproc->sz || addr + 4 > curproc->sz)
80104fb3:	8b 00                	mov    (%eax),%eax
80104fb5:	39 d8                	cmp    %ebx,%eax
80104fb7:	76 17                	jbe    80104fd0 <fetchint+0x30>
80104fb9:	8d 53 04             	lea    0x4(%ebx),%edx
80104fbc:	39 d0                	cmp    %edx,%eax
80104fbe:	72 10                	jb     80104fd0 <fetchint+0x30>
    return -1;
  *ip = *(int *)(addr);
80104fc0:	8b 45 0c             	mov    0xc(%ebp),%eax
80104fc3:	8b 13                	mov    (%ebx),%edx
80104fc5:	89 10                	mov    %edx,(%eax)
  return 0;
80104fc7:	31 c0                	xor    %eax,%eax
}
80104fc9:	83 c4 04             	add    $0x4,%esp
80104fcc:	5b                   	pop    %ebx
80104fcd:	5d                   	pop    %ebp
80104fce:	c3                   	ret    
80104fcf:	90                   	nop
    return -1;
80104fd0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104fd5:	eb f2                	jmp    80104fc9 <fetchint+0x29>
80104fd7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104fde:	66 90                	xchg   %ax,%ax

80104fe0 <fetchstr>:

// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int fetchstr(uint addr, char **pp)
{
80104fe0:	f3 0f 1e fb          	endbr32 
80104fe4:	55                   	push   %ebp
80104fe5:	89 e5                	mov    %esp,%ebp
80104fe7:	53                   	push   %ebx
80104fe8:	83 ec 04             	sub    $0x4,%esp
80104feb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
80104fee:	e8 ad ef ff ff       	call   80103fa0 <myproc>

  if (addr >= curproc->sz)
80104ff3:	39 18                	cmp    %ebx,(%eax)
80104ff5:	76 31                	jbe    80105028 <fetchstr+0x48>
    return -1;
  *pp = (char *)addr;
80104ff7:	8b 55 0c             	mov    0xc(%ebp),%edx
80104ffa:	89 1a                	mov    %ebx,(%edx)
  ep = (char *)curproc->sz;
80104ffc:	8b 10                	mov    (%eax),%edx
  for (s = *pp; s < ep; s++)
80104ffe:	39 d3                	cmp    %edx,%ebx
80105000:	73 26                	jae    80105028 <fetchstr+0x48>
80105002:	89 d8                	mov    %ebx,%eax
80105004:	eb 11                	jmp    80105017 <fetchstr+0x37>
80105006:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010500d:	8d 76 00             	lea    0x0(%esi),%esi
80105010:	83 c0 01             	add    $0x1,%eax
80105013:	39 c2                	cmp    %eax,%edx
80105015:	76 11                	jbe    80105028 <fetchstr+0x48>
  {
    if (*s == 0)
80105017:	80 38 00             	cmpb   $0x0,(%eax)
8010501a:	75 f4                	jne    80105010 <fetchstr+0x30>
      return s - *pp;
  }
  return -1;
}
8010501c:	83 c4 04             	add    $0x4,%esp
      return s - *pp;
8010501f:	29 d8                	sub    %ebx,%eax
}
80105021:	5b                   	pop    %ebx
80105022:	5d                   	pop    %ebp
80105023:	c3                   	ret    
80105024:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105028:	83 c4 04             	add    $0x4,%esp
    return -1;
8010502b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105030:	5b                   	pop    %ebx
80105031:	5d                   	pop    %ebp
80105032:	c3                   	ret    
80105033:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010503a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105040 <argint>:

// Fetch the nth 32-bit system call argument.
int argint(int n, int *ip)
{
80105040:	f3 0f 1e fb          	endbr32 
80105044:	55                   	push   %ebp
80105045:	89 e5                	mov    %esp,%ebp
80105047:	56                   	push   %esi
80105048:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4 * n, ip);
80105049:	e8 52 ef ff ff       	call   80103fa0 <myproc>
8010504e:	8b 55 08             	mov    0x8(%ebp),%edx
80105051:	8b 40 18             	mov    0x18(%eax),%eax
80105054:	8b 40 44             	mov    0x44(%eax),%eax
80105057:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
8010505a:	e8 41 ef ff ff       	call   80103fa0 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4 * n, ip);
8010505f:	8d 73 04             	lea    0x4(%ebx),%esi
  if (addr >= curproc->sz || addr + 4 > curproc->sz)
80105062:	8b 00                	mov    (%eax),%eax
80105064:	39 c6                	cmp    %eax,%esi
80105066:	73 18                	jae    80105080 <argint+0x40>
80105068:	8d 53 08             	lea    0x8(%ebx),%edx
8010506b:	39 d0                	cmp    %edx,%eax
8010506d:	72 11                	jb     80105080 <argint+0x40>
  *ip = *(int *)(addr);
8010506f:	8b 45 0c             	mov    0xc(%ebp),%eax
80105072:	8b 53 04             	mov    0x4(%ebx),%edx
80105075:	89 10                	mov    %edx,(%eax)
  return 0;
80105077:	31 c0                	xor    %eax,%eax
}
80105079:	5b                   	pop    %ebx
8010507a:	5e                   	pop    %esi
8010507b:	5d                   	pop    %ebp
8010507c:	c3                   	ret    
8010507d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80105080:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchint((myproc()->tf->esp) + 4 + 4 * n, ip);
80105085:	eb f2                	jmp    80105079 <argint+0x39>
80105087:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010508e:	66 90                	xchg   %ax,%ax

80105090 <argptr>:

// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int argptr(int n, char **pp, int size)
{
80105090:	f3 0f 1e fb          	endbr32 
80105094:	55                   	push   %ebp
80105095:	89 e5                	mov    %esp,%ebp
80105097:	56                   	push   %esi
80105098:	53                   	push   %ebx
80105099:	83 ec 10             	sub    $0x10,%esp
8010509c:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int i;
  struct proc *curproc = myproc();
8010509f:	e8 fc ee ff ff       	call   80103fa0 <myproc>

  if (argint(n, &i) < 0)
801050a4:	83 ec 08             	sub    $0x8,%esp
  struct proc *curproc = myproc();
801050a7:	89 c6                	mov    %eax,%esi
  if (argint(n, &i) < 0)
801050a9:	8d 45 f4             	lea    -0xc(%ebp),%eax
801050ac:	50                   	push   %eax
801050ad:	ff 75 08             	pushl  0x8(%ebp)
801050b0:	e8 8b ff ff ff       	call   80105040 <argint>
    return -1;
  if (size < 0 || (uint)i >= curproc->sz || (uint)i + size > curproc->sz)
801050b5:	83 c4 10             	add    $0x10,%esp
801050b8:	85 c0                	test   %eax,%eax
801050ba:	78 24                	js     801050e0 <argptr+0x50>
801050bc:	85 db                	test   %ebx,%ebx
801050be:	78 20                	js     801050e0 <argptr+0x50>
801050c0:	8b 16                	mov    (%esi),%edx
801050c2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801050c5:	39 c2                	cmp    %eax,%edx
801050c7:	76 17                	jbe    801050e0 <argptr+0x50>
801050c9:	01 c3                	add    %eax,%ebx
801050cb:	39 da                	cmp    %ebx,%edx
801050cd:	72 11                	jb     801050e0 <argptr+0x50>
    return -1;
  *pp = (char *)i;
801050cf:	8b 55 0c             	mov    0xc(%ebp),%edx
801050d2:	89 02                	mov    %eax,(%edx)
  return 0;
801050d4:	31 c0                	xor    %eax,%eax
}
801050d6:	8d 65 f8             	lea    -0x8(%ebp),%esp
801050d9:	5b                   	pop    %ebx
801050da:	5e                   	pop    %esi
801050db:	5d                   	pop    %ebp
801050dc:	c3                   	ret    
801050dd:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
801050e0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801050e5:	eb ef                	jmp    801050d6 <argptr+0x46>
801050e7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801050ee:	66 90                	xchg   %ax,%ax

801050f0 <argstr>:
// Fetch the nth word-sized system call argument as a string pointer.
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int argstr(int n, char **pp)
{
801050f0:	f3 0f 1e fb          	endbr32 
801050f4:	55                   	push   %ebp
801050f5:	89 e5                	mov    %esp,%ebp
801050f7:	83 ec 20             	sub    $0x20,%esp
  int addr;
  if (argint(n, &addr) < 0)
801050fa:	8d 45 f4             	lea    -0xc(%ebp),%eax
801050fd:	50                   	push   %eax
801050fe:	ff 75 08             	pushl  0x8(%ebp)
80105101:	e8 3a ff ff ff       	call   80105040 <argint>
80105106:	83 c4 10             	add    $0x10,%esp
80105109:	85 c0                	test   %eax,%eax
8010510b:	78 13                	js     80105120 <argstr+0x30>
    return -1;
  return fetchstr(addr, pp);
8010510d:	83 ec 08             	sub    $0x8,%esp
80105110:	ff 75 0c             	pushl  0xc(%ebp)
80105113:	ff 75 f4             	pushl  -0xc(%ebp)
80105116:	e8 c5 fe ff ff       	call   80104fe0 <fetchstr>
8010511b:	83 c4 10             	add    $0x10,%esp
}
8010511e:	c9                   	leave  
8010511f:	c3                   	ret    
80105120:	c9                   	leave  
    return -1;
80105121:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105126:	c3                   	ret    
80105127:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010512e:	66 90                	xchg   %ax,%ax

80105130 <syscall>:
    [SYS_get_uncle_count] sys_get_uncle_count,
    [SYS_lifetime] sys_lifetime,
};

void syscall(void)
{
80105130:	f3 0f 1e fb          	endbr32 
80105134:	55                   	push   %ebp
80105135:	89 e5                	mov    %esp,%ebp
80105137:	53                   	push   %ebx
80105138:	83 ec 04             	sub    $0x4,%esp
  int num;
  struct proc *curproc = myproc();
8010513b:	e8 60 ee ff ff       	call   80103fa0 <myproc>
80105140:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax;
80105142:	8b 40 18             	mov    0x18(%eax),%eax
80105145:	8b 40 1c             	mov    0x1c(%eax),%eax
  if (num > 0 && num < NELEM(syscalls) && syscalls[num])
80105148:	8d 50 ff             	lea    -0x1(%eax),%edx
8010514b:	83 fa 18             	cmp    $0x18,%edx
8010514e:	77 20                	ja     80105170 <syscall+0x40>
80105150:	8b 14 85 00 80 10 80 	mov    -0x7fef8000(,%eax,4),%edx
80105157:	85 d2                	test   %edx,%edx
80105159:	74 15                	je     80105170 <syscall+0x40>
  {
    curproc->tf->eax = syscalls[num]();
8010515b:	ff d2                	call   *%edx
8010515d:	89 c2                	mov    %eax,%edx
8010515f:	8b 43 18             	mov    0x18(%ebx),%eax
80105162:	89 50 1c             	mov    %edx,0x1c(%eax)
  {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
80105165:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105168:	c9                   	leave  
80105169:	c3                   	ret    
8010516a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cprintf("%d %s: unknown sys call %d\n",
80105170:	50                   	push   %eax
            curproc->pid, curproc->name, num);
80105171:	8d 43 70             	lea    0x70(%ebx),%eax
    cprintf("%d %s: unknown sys call %d\n",
80105174:	50                   	push   %eax
80105175:	ff 73 10             	pushl  0x10(%ebx)
80105178:	68 dd 7f 10 80       	push   $0x80107fdd
8010517d:	e8 1e b6 ff ff       	call   801007a0 <cprintf>
    curproc->tf->eax = -1;
80105182:	8b 43 18             	mov    0x18(%ebx),%eax
80105185:	83 c4 10             	add    $0x10,%esp
80105188:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
8010518f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105192:	c9                   	leave  
80105193:	c3                   	ret    
80105194:	66 90                	xchg   %ax,%ax
80105196:	66 90                	xchg   %ax,%ax
80105198:	66 90                	xchg   %ax,%ax
8010519a:	66 90                	xchg   %ax,%ax
8010519c:	66 90                	xchg   %ax,%ax
8010519e:	66 90                	xchg   %ax,%ax

801051a0 <create>:
  return -1;
}

static struct inode *
create(char *path, short type, short major, short minor)
{
801051a0:	55                   	push   %ebp
801051a1:	89 e5                	mov    %esp,%ebp
801051a3:	57                   	push   %edi
801051a4:	56                   	push   %esi
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if ((dp = nameiparent(path, name)) == 0)
801051a5:	8d 7d da             	lea    -0x26(%ebp),%edi
{
801051a8:	53                   	push   %ebx
801051a9:	83 ec 34             	sub    $0x34,%esp
801051ac:	89 4d d0             	mov    %ecx,-0x30(%ebp)
801051af:	8b 4d 08             	mov    0x8(%ebp),%ecx
  if ((dp = nameiparent(path, name)) == 0)
801051b2:	57                   	push   %edi
801051b3:	50                   	push   %eax
{
801051b4:	89 55 d4             	mov    %edx,-0x2c(%ebp)
801051b7:	89 4d cc             	mov    %ecx,-0x34(%ebp)
  if ((dp = nameiparent(path, name)) == 0)
801051ba:	e8 d1 d4 ff ff       	call   80102690 <nameiparent>
801051bf:	83 c4 10             	add    $0x10,%esp
801051c2:	85 c0                	test   %eax,%eax
801051c4:	0f 84 46 01 00 00    	je     80105310 <create+0x170>
    return 0;
  ilock(dp);
801051ca:	83 ec 0c             	sub    $0xc,%esp
801051cd:	89 c3                	mov    %eax,%ebx
801051cf:	50                   	push   %eax
801051d0:	e8 cb cb ff ff       	call   80101da0 <ilock>

  if ((ip = dirlookup(dp, name, 0)) != 0)
801051d5:	83 c4 0c             	add    $0xc,%esp
801051d8:	6a 00                	push   $0x0
801051da:	57                   	push   %edi
801051db:	53                   	push   %ebx
801051dc:	e8 0f d1 ff ff       	call   801022f0 <dirlookup>
801051e1:	83 c4 10             	add    $0x10,%esp
801051e4:	89 c6                	mov    %eax,%esi
801051e6:	85 c0                	test   %eax,%eax
801051e8:	74 56                	je     80105240 <create+0xa0>
  {
    iunlockput(dp);
801051ea:	83 ec 0c             	sub    $0xc,%esp
801051ed:	53                   	push   %ebx
801051ee:	e8 4d ce ff ff       	call   80102040 <iunlockput>
    ilock(ip);
801051f3:	89 34 24             	mov    %esi,(%esp)
801051f6:	e8 a5 cb ff ff       	call   80101da0 <ilock>
    if (type == T_FILE && ip->type == T_FILE)
801051fb:	83 c4 10             	add    $0x10,%esp
801051fe:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
80105203:	75 1b                	jne    80105220 <create+0x80>
80105205:	66 83 7e 50 02       	cmpw   $0x2,0x50(%esi)
8010520a:	75 14                	jne    80105220 <create+0x80>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
8010520c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010520f:	89 f0                	mov    %esi,%eax
80105211:	5b                   	pop    %ebx
80105212:	5e                   	pop    %esi
80105213:	5f                   	pop    %edi
80105214:	5d                   	pop    %ebp
80105215:	c3                   	ret    
80105216:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010521d:	8d 76 00             	lea    0x0(%esi),%esi
    iunlockput(ip);
80105220:	83 ec 0c             	sub    $0xc,%esp
80105223:	56                   	push   %esi
    return 0;
80105224:	31 f6                	xor    %esi,%esi
    iunlockput(ip);
80105226:	e8 15 ce ff ff       	call   80102040 <iunlockput>
    return 0;
8010522b:	83 c4 10             	add    $0x10,%esp
}
8010522e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105231:	89 f0                	mov    %esi,%eax
80105233:	5b                   	pop    %ebx
80105234:	5e                   	pop    %esi
80105235:	5f                   	pop    %edi
80105236:	5d                   	pop    %ebp
80105237:	c3                   	ret    
80105238:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010523f:	90                   	nop
  if ((ip = ialloc(dp->dev, type)) == 0)
80105240:	0f bf 45 d4          	movswl -0x2c(%ebp),%eax
80105244:	83 ec 08             	sub    $0x8,%esp
80105247:	50                   	push   %eax
80105248:	ff 33                	pushl  (%ebx)
8010524a:	e8 d1 c9 ff ff       	call   80101c20 <ialloc>
8010524f:	83 c4 10             	add    $0x10,%esp
80105252:	89 c6                	mov    %eax,%esi
80105254:	85 c0                	test   %eax,%eax
80105256:	0f 84 cd 00 00 00    	je     80105329 <create+0x189>
  ilock(ip);
8010525c:	83 ec 0c             	sub    $0xc,%esp
8010525f:	50                   	push   %eax
80105260:	e8 3b cb ff ff       	call   80101da0 <ilock>
  ip->major = major;
80105265:	0f b7 45 d0          	movzwl -0x30(%ebp),%eax
80105269:	66 89 46 52          	mov    %ax,0x52(%esi)
  ip->minor = minor;
8010526d:	0f b7 45 cc          	movzwl -0x34(%ebp),%eax
80105271:	66 89 46 54          	mov    %ax,0x54(%esi)
  ip->nlink = 1;
80105275:	b8 01 00 00 00       	mov    $0x1,%eax
8010527a:	66 89 46 56          	mov    %ax,0x56(%esi)
  iupdate(ip);
8010527e:	89 34 24             	mov    %esi,(%esp)
80105281:	e8 5a ca ff ff       	call   80101ce0 <iupdate>
  if (type == T_DIR)
80105286:	83 c4 10             	add    $0x10,%esp
80105289:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
8010528e:	74 30                	je     801052c0 <create+0x120>
  if (dirlink(dp, name, ip->inum) < 0)
80105290:	83 ec 04             	sub    $0x4,%esp
80105293:	ff 76 04             	pushl  0x4(%esi)
80105296:	57                   	push   %edi
80105297:	53                   	push   %ebx
80105298:	e8 13 d3 ff ff       	call   801025b0 <dirlink>
8010529d:	83 c4 10             	add    $0x10,%esp
801052a0:	85 c0                	test   %eax,%eax
801052a2:	78 78                	js     8010531c <create+0x17c>
  iunlockput(dp);
801052a4:	83 ec 0c             	sub    $0xc,%esp
801052a7:	53                   	push   %ebx
801052a8:	e8 93 cd ff ff       	call   80102040 <iunlockput>
  return ip;
801052ad:	83 c4 10             	add    $0x10,%esp
}
801052b0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801052b3:	89 f0                	mov    %esi,%eax
801052b5:	5b                   	pop    %ebx
801052b6:	5e                   	pop    %esi
801052b7:	5f                   	pop    %edi
801052b8:	5d                   	pop    %ebp
801052b9:	c3                   	ret    
801052ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iupdate(dp);
801052c0:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink++; // for ".."
801052c3:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
    iupdate(dp);
801052c8:	53                   	push   %ebx
801052c9:	e8 12 ca ff ff       	call   80101ce0 <iupdate>
    if (dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
801052ce:	83 c4 0c             	add    $0xc,%esp
801052d1:	ff 76 04             	pushl  0x4(%esi)
801052d4:	68 84 80 10 80       	push   $0x80108084
801052d9:	56                   	push   %esi
801052da:	e8 d1 d2 ff ff       	call   801025b0 <dirlink>
801052df:	83 c4 10             	add    $0x10,%esp
801052e2:	85 c0                	test   %eax,%eax
801052e4:	78 18                	js     801052fe <create+0x15e>
801052e6:	83 ec 04             	sub    $0x4,%esp
801052e9:	ff 73 04             	pushl  0x4(%ebx)
801052ec:	68 83 80 10 80       	push   $0x80108083
801052f1:	56                   	push   %esi
801052f2:	e8 b9 d2 ff ff       	call   801025b0 <dirlink>
801052f7:	83 c4 10             	add    $0x10,%esp
801052fa:	85 c0                	test   %eax,%eax
801052fc:	79 92                	jns    80105290 <create+0xf0>
      panic("create dots");
801052fe:	83 ec 0c             	sub    $0xc,%esp
80105301:	68 77 80 10 80       	push   $0x80108077
80105306:	e8 a5 b0 ff ff       	call   801003b0 <panic>
8010530b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010530f:	90                   	nop
}
80105310:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
80105313:	31 f6                	xor    %esi,%esi
}
80105315:	5b                   	pop    %ebx
80105316:	89 f0                	mov    %esi,%eax
80105318:	5e                   	pop    %esi
80105319:	5f                   	pop    %edi
8010531a:	5d                   	pop    %ebp
8010531b:	c3                   	ret    
    panic("create: dirlink");
8010531c:	83 ec 0c             	sub    $0xc,%esp
8010531f:	68 86 80 10 80       	push   $0x80108086
80105324:	e8 87 b0 ff ff       	call   801003b0 <panic>
    panic("create: ialloc");
80105329:	83 ec 0c             	sub    $0xc,%esp
8010532c:	68 68 80 10 80       	push   $0x80108068
80105331:	e8 7a b0 ff ff       	call   801003b0 <panic>
80105336:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010533d:	8d 76 00             	lea    0x0(%esi),%esi

80105340 <argfd.constprop.0>:
argfd(int n, int *pfd, struct file **pf)
80105340:	55                   	push   %ebp
80105341:	89 e5                	mov    %esp,%ebp
80105343:	56                   	push   %esi
80105344:	89 d6                	mov    %edx,%esi
80105346:	53                   	push   %ebx
80105347:	89 c3                	mov    %eax,%ebx
  if (argint(n, &fd) < 0)
80105349:	8d 45 f4             	lea    -0xc(%ebp),%eax
argfd(int n, int *pfd, struct file **pf)
8010534c:	83 ec 18             	sub    $0x18,%esp
  if (argint(n, &fd) < 0)
8010534f:	50                   	push   %eax
80105350:	6a 00                	push   $0x0
80105352:	e8 e9 fc ff ff       	call   80105040 <argint>
80105357:	83 c4 10             	add    $0x10,%esp
8010535a:	85 c0                	test   %eax,%eax
8010535c:	78 2a                	js     80105388 <argfd.constprop.0+0x48>
  if (fd < 0 || fd >= NOFILE || (f = myproc()->ofile[fd]) == 0)
8010535e:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80105362:	77 24                	ja     80105388 <argfd.constprop.0+0x48>
80105364:	e8 37 ec ff ff       	call   80103fa0 <myproc>
80105369:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010536c:	8b 44 90 28          	mov    0x28(%eax,%edx,4),%eax
80105370:	85 c0                	test   %eax,%eax
80105372:	74 14                	je     80105388 <argfd.constprop.0+0x48>
  if (pfd)
80105374:	85 db                	test   %ebx,%ebx
80105376:	74 02                	je     8010537a <argfd.constprop.0+0x3a>
    *pfd = fd;
80105378:	89 13                	mov    %edx,(%ebx)
    *pf = f;
8010537a:	89 06                	mov    %eax,(%esi)
  return 0;
8010537c:	31 c0                	xor    %eax,%eax
}
8010537e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105381:	5b                   	pop    %ebx
80105382:	5e                   	pop    %esi
80105383:	5d                   	pop    %ebp
80105384:	c3                   	ret    
80105385:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80105388:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010538d:	eb ef                	jmp    8010537e <argfd.constprop.0+0x3e>
8010538f:	90                   	nop

80105390 <sys_dup>:
{
80105390:	f3 0f 1e fb          	endbr32 
80105394:	55                   	push   %ebp
  if (argfd(0, 0, &f) < 0)
80105395:	31 c0                	xor    %eax,%eax
{
80105397:	89 e5                	mov    %esp,%ebp
80105399:	56                   	push   %esi
8010539a:	53                   	push   %ebx
  if (argfd(0, 0, &f) < 0)
8010539b:	8d 55 f4             	lea    -0xc(%ebp),%edx
{
8010539e:	83 ec 10             	sub    $0x10,%esp
  if (argfd(0, 0, &f) < 0)
801053a1:	e8 9a ff ff ff       	call   80105340 <argfd.constprop.0>
801053a6:	85 c0                	test   %eax,%eax
801053a8:	78 1e                	js     801053c8 <sys_dup+0x38>
  if ((fd = fdalloc(f)) < 0)
801053aa:	8b 75 f4             	mov    -0xc(%ebp),%esi
  for (fd = 0; fd < NOFILE; fd++)
801053ad:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
801053af:	e8 ec eb ff ff       	call   80103fa0 <myproc>
  for (fd = 0; fd < NOFILE; fd++)
801053b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if (curproc->ofile[fd] == 0)
801053b8:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
801053bc:	85 d2                	test   %edx,%edx
801053be:	74 20                	je     801053e0 <sys_dup+0x50>
  for (fd = 0; fd < NOFILE; fd++)
801053c0:	83 c3 01             	add    $0x1,%ebx
801053c3:	83 fb 10             	cmp    $0x10,%ebx
801053c6:	75 f0                	jne    801053b8 <sys_dup+0x28>
}
801053c8:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return -1;
801053cb:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
801053d0:	89 d8                	mov    %ebx,%eax
801053d2:	5b                   	pop    %ebx
801053d3:	5e                   	pop    %esi
801053d4:	5d                   	pop    %ebp
801053d5:	c3                   	ret    
801053d6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801053dd:	8d 76 00             	lea    0x0(%esi),%esi
      curproc->ofile[fd] = f;
801053e0:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)
  filedup(f);
801053e4:	83 ec 0c             	sub    $0xc,%esp
801053e7:	ff 75 f4             	pushl  -0xc(%ebp)
801053ea:	e8 c1 c0 ff ff       	call   801014b0 <filedup>
  return fd;
801053ef:	83 c4 10             	add    $0x10,%esp
}
801053f2:	8d 65 f8             	lea    -0x8(%ebp),%esp
801053f5:	89 d8                	mov    %ebx,%eax
801053f7:	5b                   	pop    %ebx
801053f8:	5e                   	pop    %esi
801053f9:	5d                   	pop    %ebp
801053fa:	c3                   	ret    
801053fb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801053ff:	90                   	nop

80105400 <sys_read>:
{
80105400:	f3 0f 1e fb          	endbr32 
80105404:	55                   	push   %ebp
  if (argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105405:	31 c0                	xor    %eax,%eax
{
80105407:	89 e5                	mov    %esp,%ebp
80105409:	83 ec 18             	sub    $0x18,%esp
  if (argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
8010540c:	8d 55 ec             	lea    -0x14(%ebp),%edx
8010540f:	e8 2c ff ff ff       	call   80105340 <argfd.constprop.0>
80105414:	85 c0                	test   %eax,%eax
80105416:	78 48                	js     80105460 <sys_read+0x60>
80105418:	83 ec 08             	sub    $0x8,%esp
8010541b:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010541e:	50                   	push   %eax
8010541f:	6a 02                	push   $0x2
80105421:	e8 1a fc ff ff       	call   80105040 <argint>
80105426:	83 c4 10             	add    $0x10,%esp
80105429:	85 c0                	test   %eax,%eax
8010542b:	78 33                	js     80105460 <sys_read+0x60>
8010542d:	83 ec 04             	sub    $0x4,%esp
80105430:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105433:	ff 75 f0             	pushl  -0x10(%ebp)
80105436:	50                   	push   %eax
80105437:	6a 01                	push   $0x1
80105439:	e8 52 fc ff ff       	call   80105090 <argptr>
8010543e:	83 c4 10             	add    $0x10,%esp
80105441:	85 c0                	test   %eax,%eax
80105443:	78 1b                	js     80105460 <sys_read+0x60>
  return fileread(f, p, n);
80105445:	83 ec 04             	sub    $0x4,%esp
80105448:	ff 75 f0             	pushl  -0x10(%ebp)
8010544b:	ff 75 f4             	pushl  -0xc(%ebp)
8010544e:	ff 75 ec             	pushl  -0x14(%ebp)
80105451:	e8 da c1 ff ff       	call   80101630 <fileread>
80105456:	83 c4 10             	add    $0x10,%esp
}
80105459:	c9                   	leave  
8010545a:	c3                   	ret    
8010545b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010545f:	90                   	nop
80105460:	c9                   	leave  
    return -1;
80105461:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105466:	c3                   	ret    
80105467:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010546e:	66 90                	xchg   %ax,%ax

80105470 <sys_write>:
{
80105470:	f3 0f 1e fb          	endbr32 
80105474:	55                   	push   %ebp
  if (argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105475:	31 c0                	xor    %eax,%eax
{
80105477:	89 e5                	mov    %esp,%ebp
80105479:	83 ec 18             	sub    $0x18,%esp
  if (argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
8010547c:	8d 55 ec             	lea    -0x14(%ebp),%edx
8010547f:	e8 bc fe ff ff       	call   80105340 <argfd.constprop.0>
80105484:	85 c0                	test   %eax,%eax
80105486:	78 48                	js     801054d0 <sys_write+0x60>
80105488:	83 ec 08             	sub    $0x8,%esp
8010548b:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010548e:	50                   	push   %eax
8010548f:	6a 02                	push   $0x2
80105491:	e8 aa fb ff ff       	call   80105040 <argint>
80105496:	83 c4 10             	add    $0x10,%esp
80105499:	85 c0                	test   %eax,%eax
8010549b:	78 33                	js     801054d0 <sys_write+0x60>
8010549d:	83 ec 04             	sub    $0x4,%esp
801054a0:	8d 45 f4             	lea    -0xc(%ebp),%eax
801054a3:	ff 75 f0             	pushl  -0x10(%ebp)
801054a6:	50                   	push   %eax
801054a7:	6a 01                	push   $0x1
801054a9:	e8 e2 fb ff ff       	call   80105090 <argptr>
801054ae:	83 c4 10             	add    $0x10,%esp
801054b1:	85 c0                	test   %eax,%eax
801054b3:	78 1b                	js     801054d0 <sys_write+0x60>
  return filewrite(f, p, n);
801054b5:	83 ec 04             	sub    $0x4,%esp
801054b8:	ff 75 f0             	pushl  -0x10(%ebp)
801054bb:	ff 75 f4             	pushl  -0xc(%ebp)
801054be:	ff 75 ec             	pushl  -0x14(%ebp)
801054c1:	e8 0a c2 ff ff       	call   801016d0 <filewrite>
801054c6:	83 c4 10             	add    $0x10,%esp
}
801054c9:	c9                   	leave  
801054ca:	c3                   	ret    
801054cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801054cf:	90                   	nop
801054d0:	c9                   	leave  
    return -1;
801054d1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801054d6:	c3                   	ret    
801054d7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801054de:	66 90                	xchg   %ax,%ax

801054e0 <sys_close>:
{
801054e0:	f3 0f 1e fb          	endbr32 
801054e4:	55                   	push   %ebp
801054e5:	89 e5                	mov    %esp,%ebp
801054e7:	83 ec 18             	sub    $0x18,%esp
  if (argfd(0, &fd, &f) < 0)
801054ea:	8d 55 f4             	lea    -0xc(%ebp),%edx
801054ed:	8d 45 f0             	lea    -0x10(%ebp),%eax
801054f0:	e8 4b fe ff ff       	call   80105340 <argfd.constprop.0>
801054f5:	85 c0                	test   %eax,%eax
801054f7:	78 27                	js     80105520 <sys_close+0x40>
  myproc()->ofile[fd] = 0;
801054f9:	e8 a2 ea ff ff       	call   80103fa0 <myproc>
801054fe:	8b 55 f0             	mov    -0x10(%ebp),%edx
  fileclose(f);
80105501:	83 ec 0c             	sub    $0xc,%esp
  myproc()->ofile[fd] = 0;
80105504:	c7 44 90 28 00 00 00 	movl   $0x0,0x28(%eax,%edx,4)
8010550b:	00 
  fileclose(f);
8010550c:	ff 75 f4             	pushl  -0xc(%ebp)
8010550f:	e8 ec bf ff ff       	call   80101500 <fileclose>
  return 0;
80105514:	83 c4 10             	add    $0x10,%esp
80105517:	31 c0                	xor    %eax,%eax
}
80105519:	c9                   	leave  
8010551a:	c3                   	ret    
8010551b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010551f:	90                   	nop
80105520:	c9                   	leave  
    return -1;
80105521:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105526:	c3                   	ret    
80105527:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010552e:	66 90                	xchg   %ax,%ax

80105530 <sys_fstat>:
{
80105530:	f3 0f 1e fb          	endbr32 
80105534:	55                   	push   %ebp
  if (argfd(0, 0, &f) < 0 || argptr(1, (void *)&st, sizeof(*st)) < 0)
80105535:	31 c0                	xor    %eax,%eax
{
80105537:	89 e5                	mov    %esp,%ebp
80105539:	83 ec 18             	sub    $0x18,%esp
  if (argfd(0, 0, &f) < 0 || argptr(1, (void *)&st, sizeof(*st)) < 0)
8010553c:	8d 55 f0             	lea    -0x10(%ebp),%edx
8010553f:	e8 fc fd ff ff       	call   80105340 <argfd.constprop.0>
80105544:	85 c0                	test   %eax,%eax
80105546:	78 30                	js     80105578 <sys_fstat+0x48>
80105548:	83 ec 04             	sub    $0x4,%esp
8010554b:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010554e:	6a 14                	push   $0x14
80105550:	50                   	push   %eax
80105551:	6a 01                	push   $0x1
80105553:	e8 38 fb ff ff       	call   80105090 <argptr>
80105558:	83 c4 10             	add    $0x10,%esp
8010555b:	85 c0                	test   %eax,%eax
8010555d:	78 19                	js     80105578 <sys_fstat+0x48>
  return filestat(f, st);
8010555f:	83 ec 08             	sub    $0x8,%esp
80105562:	ff 75 f4             	pushl  -0xc(%ebp)
80105565:	ff 75 f0             	pushl  -0x10(%ebp)
80105568:	e8 73 c0 ff ff       	call   801015e0 <filestat>
8010556d:	83 c4 10             	add    $0x10,%esp
}
80105570:	c9                   	leave  
80105571:	c3                   	ret    
80105572:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105578:	c9                   	leave  
    return -1;
80105579:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010557e:	c3                   	ret    
8010557f:	90                   	nop

80105580 <sys_link>:
{
80105580:	f3 0f 1e fb          	endbr32 
80105584:	55                   	push   %ebp
80105585:	89 e5                	mov    %esp,%ebp
80105587:	57                   	push   %edi
80105588:	56                   	push   %esi
  if (argstr(0, &old) < 0 || argstr(1, &new) < 0)
80105589:	8d 45 d4             	lea    -0x2c(%ebp),%eax
{
8010558c:	53                   	push   %ebx
8010558d:	83 ec 34             	sub    $0x34,%esp
  if (argstr(0, &old) < 0 || argstr(1, &new) < 0)
80105590:	50                   	push   %eax
80105591:	6a 00                	push   $0x0
80105593:	e8 58 fb ff ff       	call   801050f0 <argstr>
80105598:	83 c4 10             	add    $0x10,%esp
8010559b:	85 c0                	test   %eax,%eax
8010559d:	0f 88 ff 00 00 00    	js     801056a2 <sys_link+0x122>
801055a3:	83 ec 08             	sub    $0x8,%esp
801055a6:	8d 45 d0             	lea    -0x30(%ebp),%eax
801055a9:	50                   	push   %eax
801055aa:	6a 01                	push   $0x1
801055ac:	e8 3f fb ff ff       	call   801050f0 <argstr>
801055b1:	83 c4 10             	add    $0x10,%esp
801055b4:	85 c0                	test   %eax,%eax
801055b6:	0f 88 e6 00 00 00    	js     801056a2 <sys_link+0x122>
  begin_op();
801055bc:	e8 af dd ff ff       	call   80103370 <begin_op>
  if ((ip = namei(old)) == 0)
801055c1:	83 ec 0c             	sub    $0xc,%esp
801055c4:	ff 75 d4             	pushl  -0x2c(%ebp)
801055c7:	e8 a4 d0 ff ff       	call   80102670 <namei>
801055cc:	83 c4 10             	add    $0x10,%esp
801055cf:	89 c3                	mov    %eax,%ebx
801055d1:	85 c0                	test   %eax,%eax
801055d3:	0f 84 e8 00 00 00    	je     801056c1 <sys_link+0x141>
  ilock(ip);
801055d9:	83 ec 0c             	sub    $0xc,%esp
801055dc:	50                   	push   %eax
801055dd:	e8 be c7 ff ff       	call   80101da0 <ilock>
  if (ip->type == T_DIR)
801055e2:	83 c4 10             	add    $0x10,%esp
801055e5:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801055ea:	0f 84 b9 00 00 00    	je     801056a9 <sys_link+0x129>
  iupdate(ip);
801055f0:	83 ec 0c             	sub    $0xc,%esp
  ip->nlink++;
801055f3:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  if ((dp = nameiparent(new, name)) == 0)
801055f8:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
801055fb:	53                   	push   %ebx
801055fc:	e8 df c6 ff ff       	call   80101ce0 <iupdate>
  iunlock(ip);
80105601:	89 1c 24             	mov    %ebx,(%esp)
80105604:	e8 77 c8 ff ff       	call   80101e80 <iunlock>
  if ((dp = nameiparent(new, name)) == 0)
80105609:	58                   	pop    %eax
8010560a:	5a                   	pop    %edx
8010560b:	57                   	push   %edi
8010560c:	ff 75 d0             	pushl  -0x30(%ebp)
8010560f:	e8 7c d0 ff ff       	call   80102690 <nameiparent>
80105614:	83 c4 10             	add    $0x10,%esp
80105617:	89 c6                	mov    %eax,%esi
80105619:	85 c0                	test   %eax,%eax
8010561b:	74 5f                	je     8010567c <sys_link+0xfc>
  ilock(dp);
8010561d:	83 ec 0c             	sub    $0xc,%esp
80105620:	50                   	push   %eax
80105621:	e8 7a c7 ff ff       	call   80101da0 <ilock>
  if (dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0)
80105626:	8b 03                	mov    (%ebx),%eax
80105628:	83 c4 10             	add    $0x10,%esp
8010562b:	39 06                	cmp    %eax,(%esi)
8010562d:	75 41                	jne    80105670 <sys_link+0xf0>
8010562f:	83 ec 04             	sub    $0x4,%esp
80105632:	ff 73 04             	pushl  0x4(%ebx)
80105635:	57                   	push   %edi
80105636:	56                   	push   %esi
80105637:	e8 74 cf ff ff       	call   801025b0 <dirlink>
8010563c:	83 c4 10             	add    $0x10,%esp
8010563f:	85 c0                	test   %eax,%eax
80105641:	78 2d                	js     80105670 <sys_link+0xf0>
  iunlockput(dp);
80105643:	83 ec 0c             	sub    $0xc,%esp
80105646:	56                   	push   %esi
80105647:	e8 f4 c9 ff ff       	call   80102040 <iunlockput>
  iput(ip);
8010564c:	89 1c 24             	mov    %ebx,(%esp)
8010564f:	e8 7c c8 ff ff       	call   80101ed0 <iput>
  end_op();
80105654:	e8 87 dd ff ff       	call   801033e0 <end_op>
  return 0;
80105659:	83 c4 10             	add    $0x10,%esp
8010565c:	31 c0                	xor    %eax,%eax
}
8010565e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105661:	5b                   	pop    %ebx
80105662:	5e                   	pop    %esi
80105663:	5f                   	pop    %edi
80105664:	5d                   	pop    %ebp
80105665:	c3                   	ret    
80105666:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010566d:	8d 76 00             	lea    0x0(%esi),%esi
    iunlockput(dp);
80105670:	83 ec 0c             	sub    $0xc,%esp
80105673:	56                   	push   %esi
80105674:	e8 c7 c9 ff ff       	call   80102040 <iunlockput>
    goto bad;
80105679:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
8010567c:	83 ec 0c             	sub    $0xc,%esp
8010567f:	53                   	push   %ebx
80105680:	e8 1b c7 ff ff       	call   80101da0 <ilock>
  ip->nlink--;
80105685:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
8010568a:	89 1c 24             	mov    %ebx,(%esp)
8010568d:	e8 4e c6 ff ff       	call   80101ce0 <iupdate>
  iunlockput(ip);
80105692:	89 1c 24             	mov    %ebx,(%esp)
80105695:	e8 a6 c9 ff ff       	call   80102040 <iunlockput>
  end_op();
8010569a:	e8 41 dd ff ff       	call   801033e0 <end_op>
  return -1;
8010569f:	83 c4 10             	add    $0x10,%esp
801056a2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801056a7:	eb b5                	jmp    8010565e <sys_link+0xde>
    iunlockput(ip);
801056a9:	83 ec 0c             	sub    $0xc,%esp
801056ac:	53                   	push   %ebx
801056ad:	e8 8e c9 ff ff       	call   80102040 <iunlockput>
    end_op();
801056b2:	e8 29 dd ff ff       	call   801033e0 <end_op>
    return -1;
801056b7:	83 c4 10             	add    $0x10,%esp
801056ba:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801056bf:	eb 9d                	jmp    8010565e <sys_link+0xde>
    end_op();
801056c1:	e8 1a dd ff ff       	call   801033e0 <end_op>
    return -1;
801056c6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801056cb:	eb 91                	jmp    8010565e <sys_link+0xde>
801056cd:	8d 76 00             	lea    0x0(%esi),%esi

801056d0 <sys_unlink>:
{
801056d0:	f3 0f 1e fb          	endbr32 
801056d4:	55                   	push   %ebp
801056d5:	89 e5                	mov    %esp,%ebp
801056d7:	57                   	push   %edi
801056d8:	56                   	push   %esi
  if (argstr(0, &path) < 0)
801056d9:	8d 45 c0             	lea    -0x40(%ebp),%eax
{
801056dc:	53                   	push   %ebx
801056dd:	83 ec 54             	sub    $0x54,%esp
  if (argstr(0, &path) < 0)
801056e0:	50                   	push   %eax
801056e1:	6a 00                	push   $0x0
801056e3:	e8 08 fa ff ff       	call   801050f0 <argstr>
801056e8:	83 c4 10             	add    $0x10,%esp
801056eb:	85 c0                	test   %eax,%eax
801056ed:	0f 88 7d 01 00 00    	js     80105870 <sys_unlink+0x1a0>
  begin_op();
801056f3:	e8 78 dc ff ff       	call   80103370 <begin_op>
  if ((dp = nameiparent(path, name)) == 0)
801056f8:	8d 5d ca             	lea    -0x36(%ebp),%ebx
801056fb:	83 ec 08             	sub    $0x8,%esp
801056fe:	53                   	push   %ebx
801056ff:	ff 75 c0             	pushl  -0x40(%ebp)
80105702:	e8 89 cf ff ff       	call   80102690 <nameiparent>
80105707:	83 c4 10             	add    $0x10,%esp
8010570a:	89 c6                	mov    %eax,%esi
8010570c:	85 c0                	test   %eax,%eax
8010570e:	0f 84 66 01 00 00    	je     8010587a <sys_unlink+0x1aa>
  ilock(dp);
80105714:	83 ec 0c             	sub    $0xc,%esp
80105717:	50                   	push   %eax
80105718:	e8 83 c6 ff ff       	call   80101da0 <ilock>
  if (namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
8010571d:	58                   	pop    %eax
8010571e:	5a                   	pop    %edx
8010571f:	68 84 80 10 80       	push   $0x80108084
80105724:	53                   	push   %ebx
80105725:	e8 a6 cb ff ff       	call   801022d0 <namecmp>
8010572a:	83 c4 10             	add    $0x10,%esp
8010572d:	85 c0                	test   %eax,%eax
8010572f:	0f 84 03 01 00 00    	je     80105838 <sys_unlink+0x168>
80105735:	83 ec 08             	sub    $0x8,%esp
80105738:	68 83 80 10 80       	push   $0x80108083
8010573d:	53                   	push   %ebx
8010573e:	e8 8d cb ff ff       	call   801022d0 <namecmp>
80105743:	83 c4 10             	add    $0x10,%esp
80105746:	85 c0                	test   %eax,%eax
80105748:	0f 84 ea 00 00 00    	je     80105838 <sys_unlink+0x168>
  if ((ip = dirlookup(dp, name, &off)) == 0)
8010574e:	83 ec 04             	sub    $0x4,%esp
80105751:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80105754:	50                   	push   %eax
80105755:	53                   	push   %ebx
80105756:	56                   	push   %esi
80105757:	e8 94 cb ff ff       	call   801022f0 <dirlookup>
8010575c:	83 c4 10             	add    $0x10,%esp
8010575f:	89 c3                	mov    %eax,%ebx
80105761:	85 c0                	test   %eax,%eax
80105763:	0f 84 cf 00 00 00    	je     80105838 <sys_unlink+0x168>
  ilock(ip);
80105769:	83 ec 0c             	sub    $0xc,%esp
8010576c:	50                   	push   %eax
8010576d:	e8 2e c6 ff ff       	call   80101da0 <ilock>
  if (ip->nlink < 1)
80105772:	83 c4 10             	add    $0x10,%esp
80105775:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
8010577a:	0f 8e 23 01 00 00    	jle    801058a3 <sys_unlink+0x1d3>
  if (ip->type == T_DIR && !isdirempty(ip))
80105780:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105785:	8d 7d d8             	lea    -0x28(%ebp),%edi
80105788:	74 66                	je     801057f0 <sys_unlink+0x120>
  memset(&de, 0, sizeof(de));
8010578a:	83 ec 04             	sub    $0x4,%esp
8010578d:	6a 10                	push   $0x10
8010578f:	6a 00                	push   $0x0
80105791:	57                   	push   %edi
80105792:	e8 c9 f5 ff ff       	call   80104d60 <memset>
  if (writei(dp, (char *)&de, off, sizeof(de)) != sizeof(de))
80105797:	6a 10                	push   $0x10
80105799:	ff 75 c4             	pushl  -0x3c(%ebp)
8010579c:	57                   	push   %edi
8010579d:	56                   	push   %esi
8010579e:	e8 fd c9 ff ff       	call   801021a0 <writei>
801057a3:	83 c4 20             	add    $0x20,%esp
801057a6:	83 f8 10             	cmp    $0x10,%eax
801057a9:	0f 85 e7 00 00 00    	jne    80105896 <sys_unlink+0x1c6>
  if (ip->type == T_DIR)
801057af:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801057b4:	0f 84 96 00 00 00    	je     80105850 <sys_unlink+0x180>
  iunlockput(dp);
801057ba:	83 ec 0c             	sub    $0xc,%esp
801057bd:	56                   	push   %esi
801057be:	e8 7d c8 ff ff       	call   80102040 <iunlockput>
  ip->nlink--;
801057c3:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
801057c8:	89 1c 24             	mov    %ebx,(%esp)
801057cb:	e8 10 c5 ff ff       	call   80101ce0 <iupdate>
  iunlockput(ip);
801057d0:	89 1c 24             	mov    %ebx,(%esp)
801057d3:	e8 68 c8 ff ff       	call   80102040 <iunlockput>
  end_op();
801057d8:	e8 03 dc ff ff       	call   801033e0 <end_op>
  return 0;
801057dd:	83 c4 10             	add    $0x10,%esp
801057e0:	31 c0                	xor    %eax,%eax
}
801057e2:	8d 65 f4             	lea    -0xc(%ebp),%esp
801057e5:	5b                   	pop    %ebx
801057e6:	5e                   	pop    %esi
801057e7:	5f                   	pop    %edi
801057e8:	5d                   	pop    %ebp
801057e9:	c3                   	ret    
801057ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for (off = 2 * sizeof(de); off < dp->size; off += sizeof(de))
801057f0:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
801057f4:	76 94                	jbe    8010578a <sys_unlink+0xba>
801057f6:	ba 20 00 00 00       	mov    $0x20,%edx
801057fb:	eb 0b                	jmp    80105808 <sys_unlink+0x138>
801057fd:	8d 76 00             	lea    0x0(%esi),%esi
80105800:	83 c2 10             	add    $0x10,%edx
80105803:	39 53 58             	cmp    %edx,0x58(%ebx)
80105806:	76 82                	jbe    8010578a <sys_unlink+0xba>
    if (readi(dp, (char *)&de, off, sizeof(de)) != sizeof(de))
80105808:	6a 10                	push   $0x10
8010580a:	52                   	push   %edx
8010580b:	57                   	push   %edi
8010580c:	53                   	push   %ebx
8010580d:	89 55 b4             	mov    %edx,-0x4c(%ebp)
80105810:	e8 8b c8 ff ff       	call   801020a0 <readi>
80105815:	83 c4 10             	add    $0x10,%esp
80105818:	8b 55 b4             	mov    -0x4c(%ebp),%edx
8010581b:	83 f8 10             	cmp    $0x10,%eax
8010581e:	75 69                	jne    80105889 <sys_unlink+0x1b9>
    if (de.inum != 0)
80105820:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80105825:	74 d9                	je     80105800 <sys_unlink+0x130>
    iunlockput(ip);
80105827:	83 ec 0c             	sub    $0xc,%esp
8010582a:	53                   	push   %ebx
8010582b:	e8 10 c8 ff ff       	call   80102040 <iunlockput>
    goto bad;
80105830:	83 c4 10             	add    $0x10,%esp
80105833:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105837:	90                   	nop
  iunlockput(dp);
80105838:	83 ec 0c             	sub    $0xc,%esp
8010583b:	56                   	push   %esi
8010583c:	e8 ff c7 ff ff       	call   80102040 <iunlockput>
  end_op();
80105841:	e8 9a db ff ff       	call   801033e0 <end_op>
  return -1;
80105846:	83 c4 10             	add    $0x10,%esp
80105849:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010584e:	eb 92                	jmp    801057e2 <sys_unlink+0x112>
    iupdate(dp);
80105850:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink--;
80105853:	66 83 6e 56 01       	subw   $0x1,0x56(%esi)
    iupdate(dp);
80105858:	56                   	push   %esi
80105859:	e8 82 c4 ff ff       	call   80101ce0 <iupdate>
8010585e:	83 c4 10             	add    $0x10,%esp
80105861:	e9 54 ff ff ff       	jmp    801057ba <sys_unlink+0xea>
80105866:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010586d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80105870:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105875:	e9 68 ff ff ff       	jmp    801057e2 <sys_unlink+0x112>
    end_op();
8010587a:	e8 61 db ff ff       	call   801033e0 <end_op>
    return -1;
8010587f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105884:	e9 59 ff ff ff       	jmp    801057e2 <sys_unlink+0x112>
      panic("isdirempty: readi");
80105889:	83 ec 0c             	sub    $0xc,%esp
8010588c:	68 a8 80 10 80       	push   $0x801080a8
80105891:	e8 1a ab ff ff       	call   801003b0 <panic>
    panic("unlink: writei");
80105896:	83 ec 0c             	sub    $0xc,%esp
80105899:	68 ba 80 10 80       	push   $0x801080ba
8010589e:	e8 0d ab ff ff       	call   801003b0 <panic>
    panic("unlink: nlink < 1");
801058a3:	83 ec 0c             	sub    $0xc,%esp
801058a6:	68 96 80 10 80       	push   $0x80108096
801058ab:	e8 00 ab ff ff       	call   801003b0 <panic>

801058b0 <sys_copy_file>:

// copy src to dest
// return 0 on success and -1 on error
int sys_copy_file(void)
{
801058b0:	f3 0f 1e fb          	endbr32 
801058b4:	55                   	push   %ebp
801058b5:	89 e5                	mov    %esp,%ebp
801058b7:	83 ec 20             	sub    $0x20,%esp
  char *src, *dest;
  if (argstr(0, &src) < 0)
801058ba:	8d 45 f0             	lea    -0x10(%ebp),%eax
801058bd:	50                   	push   %eax
801058be:	6a 00                	push   $0x0
801058c0:	e8 2b f8 ff ff       	call   801050f0 <argstr>
801058c5:	83 c4 10             	add    $0x10,%esp
801058c8:	85 c0                	test   %eax,%eax
801058ca:	78 1c                	js     801058e8 <sys_copy_file+0x38>
    return -1;
  if (argstr(1, &dest) < 0)
801058cc:	83 ec 08             	sub    $0x8,%esp
801058cf:	8d 45 f4             	lea    -0xc(%ebp),%eax
801058d2:	50                   	push   %eax
801058d3:	6a 01                	push   $0x1
801058d5:	e8 16 f8 ff ff       	call   801050f0 <argstr>
801058da:	83 c4 10             	add    $0x10,%esp
    return -1;
  return 0;
}
801058dd:	c9                   	leave  
  if (argstr(1, &dest) < 0)
801058de:	c1 f8 1f             	sar    $0x1f,%eax
}
801058e1:	c3                   	ret    
801058e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801058e8:	c9                   	leave  
    return -1;
801058e9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801058ee:	c3                   	ret    
801058ef:	90                   	nop

801058f0 <sys_open>:

int sys_open(void)
{
801058f0:	f3 0f 1e fb          	endbr32 
801058f4:	55                   	push   %ebp
801058f5:	89 e5                	mov    %esp,%ebp
801058f7:	57                   	push   %edi
801058f8:	56                   	push   %esi
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if (argstr(0, &path) < 0 || argint(1, &omode) < 0)
801058f9:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
801058fc:	53                   	push   %ebx
801058fd:	83 ec 24             	sub    $0x24,%esp
  if (argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105900:	50                   	push   %eax
80105901:	6a 00                	push   $0x0
80105903:	e8 e8 f7 ff ff       	call   801050f0 <argstr>
80105908:	83 c4 10             	add    $0x10,%esp
8010590b:	85 c0                	test   %eax,%eax
8010590d:	0f 88 8a 00 00 00    	js     8010599d <sys_open+0xad>
80105913:	83 ec 08             	sub    $0x8,%esp
80105916:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105919:	50                   	push   %eax
8010591a:	6a 01                	push   $0x1
8010591c:	e8 1f f7 ff ff       	call   80105040 <argint>
80105921:	83 c4 10             	add    $0x10,%esp
80105924:	85 c0                	test   %eax,%eax
80105926:	78 75                	js     8010599d <sys_open+0xad>
    return -1;

  begin_op();
80105928:	e8 43 da ff ff       	call   80103370 <begin_op>

  if (omode & O_CREATE)
8010592d:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
80105931:	75 75                	jne    801059a8 <sys_open+0xb8>
      return -1;
    }
  }
  else
  {
    if ((ip = namei(path)) == 0)
80105933:	83 ec 0c             	sub    $0xc,%esp
80105936:	ff 75 e0             	pushl  -0x20(%ebp)
80105939:	e8 32 cd ff ff       	call   80102670 <namei>
8010593e:	83 c4 10             	add    $0x10,%esp
80105941:	89 c6                	mov    %eax,%esi
80105943:	85 c0                	test   %eax,%eax
80105945:	74 7e                	je     801059c5 <sys_open+0xd5>
    {
      end_op();
      return -1;
    }
    ilock(ip);
80105947:	83 ec 0c             	sub    $0xc,%esp
8010594a:	50                   	push   %eax
8010594b:	e8 50 c4 ff ff       	call   80101da0 <ilock>
    if (ip->type == T_DIR && omode != O_RDONLY)
80105950:	83 c4 10             	add    $0x10,%esp
80105953:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80105958:	0f 84 c2 00 00 00    	je     80105a20 <sys_open+0x130>
      end_op();
      return -1;
    }
  }

  if ((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0)
8010595e:	e8 dd ba ff ff       	call   80101440 <filealloc>
80105963:	89 c7                	mov    %eax,%edi
80105965:	85 c0                	test   %eax,%eax
80105967:	74 23                	je     8010598c <sys_open+0x9c>
  struct proc *curproc = myproc();
80105969:	e8 32 e6 ff ff       	call   80103fa0 <myproc>
  for (fd = 0; fd < NOFILE; fd++)
8010596e:	31 db                	xor    %ebx,%ebx
    if (curproc->ofile[fd] == 0)
80105970:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105974:	85 d2                	test   %edx,%edx
80105976:	74 60                	je     801059d8 <sys_open+0xe8>
  for (fd = 0; fd < NOFILE; fd++)
80105978:	83 c3 01             	add    $0x1,%ebx
8010597b:	83 fb 10             	cmp    $0x10,%ebx
8010597e:	75 f0                	jne    80105970 <sys_open+0x80>
  {
    if (f)
      fileclose(f);
80105980:	83 ec 0c             	sub    $0xc,%esp
80105983:	57                   	push   %edi
80105984:	e8 77 bb ff ff       	call   80101500 <fileclose>
80105989:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
8010598c:	83 ec 0c             	sub    $0xc,%esp
8010598f:	56                   	push   %esi
80105990:	e8 ab c6 ff ff       	call   80102040 <iunlockput>
    end_op();
80105995:	e8 46 da ff ff       	call   801033e0 <end_op>
    return -1;
8010599a:	83 c4 10             	add    $0x10,%esp
8010599d:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801059a2:	eb 6d                	jmp    80105a11 <sys_open+0x121>
801059a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ip = create(path, T_FILE, 0, 0);
801059a8:	83 ec 0c             	sub    $0xc,%esp
801059ab:	8b 45 e0             	mov    -0x20(%ebp),%eax
801059ae:	31 c9                	xor    %ecx,%ecx
801059b0:	ba 02 00 00 00       	mov    $0x2,%edx
801059b5:	6a 00                	push   $0x0
801059b7:	e8 e4 f7 ff ff       	call   801051a0 <create>
    if (ip == 0)
801059bc:	83 c4 10             	add    $0x10,%esp
    ip = create(path, T_FILE, 0, 0);
801059bf:	89 c6                	mov    %eax,%esi
    if (ip == 0)
801059c1:	85 c0                	test   %eax,%eax
801059c3:	75 99                	jne    8010595e <sys_open+0x6e>
      end_op();
801059c5:	e8 16 da ff ff       	call   801033e0 <end_op>
      return -1;
801059ca:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801059cf:	eb 40                	jmp    80105a11 <sys_open+0x121>
801059d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  }
  iunlock(ip);
801059d8:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
801059db:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
  iunlock(ip);
801059df:	56                   	push   %esi
801059e0:	e8 9b c4 ff ff       	call   80101e80 <iunlock>
  end_op();
801059e5:	e8 f6 d9 ff ff       	call   801033e0 <end_op>

  f->type = FD_INODE;
801059ea:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
801059f0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801059f3:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
801059f6:	89 77 10             	mov    %esi,0x10(%edi)
  f->readable = !(omode & O_WRONLY);
801059f9:	89 d0                	mov    %edx,%eax
  f->off = 0;
801059fb:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
80105a02:	f7 d0                	not    %eax
80105a04:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105a07:	83 e2 03             	and    $0x3,%edx
  f->readable = !(omode & O_WRONLY);
80105a0a:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105a0d:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
}
80105a11:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105a14:	89 d8                	mov    %ebx,%eax
80105a16:	5b                   	pop    %ebx
80105a17:	5e                   	pop    %esi
80105a18:	5f                   	pop    %edi
80105a19:	5d                   	pop    %ebp
80105a1a:	c3                   	ret    
80105a1b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105a1f:	90                   	nop
    if (ip->type == T_DIR && omode != O_RDONLY)
80105a20:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80105a23:	85 c9                	test   %ecx,%ecx
80105a25:	0f 84 33 ff ff ff    	je     8010595e <sys_open+0x6e>
80105a2b:	e9 5c ff ff ff       	jmp    8010598c <sys_open+0x9c>

80105a30 <sys_mkdir>:

int sys_mkdir(void)
{
80105a30:	f3 0f 1e fb          	endbr32 
80105a34:	55                   	push   %ebp
80105a35:	89 e5                	mov    %esp,%ebp
80105a37:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
80105a3a:	e8 31 d9 ff ff       	call   80103370 <begin_op>
  if (argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0)
80105a3f:	83 ec 08             	sub    $0x8,%esp
80105a42:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105a45:	50                   	push   %eax
80105a46:	6a 00                	push   $0x0
80105a48:	e8 a3 f6 ff ff       	call   801050f0 <argstr>
80105a4d:	83 c4 10             	add    $0x10,%esp
80105a50:	85 c0                	test   %eax,%eax
80105a52:	78 34                	js     80105a88 <sys_mkdir+0x58>
80105a54:	83 ec 0c             	sub    $0xc,%esp
80105a57:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105a5a:	31 c9                	xor    %ecx,%ecx
80105a5c:	ba 01 00 00 00       	mov    $0x1,%edx
80105a61:	6a 00                	push   $0x0
80105a63:	e8 38 f7 ff ff       	call   801051a0 <create>
80105a68:	83 c4 10             	add    $0x10,%esp
80105a6b:	85 c0                	test   %eax,%eax
80105a6d:	74 19                	je     80105a88 <sys_mkdir+0x58>
  {
    end_op();
    return -1;
  }
  iunlockput(ip);
80105a6f:	83 ec 0c             	sub    $0xc,%esp
80105a72:	50                   	push   %eax
80105a73:	e8 c8 c5 ff ff       	call   80102040 <iunlockput>
  end_op();
80105a78:	e8 63 d9 ff ff       	call   801033e0 <end_op>
  return 0;
80105a7d:	83 c4 10             	add    $0x10,%esp
80105a80:	31 c0                	xor    %eax,%eax
}
80105a82:	c9                   	leave  
80105a83:	c3                   	ret    
80105a84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    end_op();
80105a88:	e8 53 d9 ff ff       	call   801033e0 <end_op>
    return -1;
80105a8d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105a92:	c9                   	leave  
80105a93:	c3                   	ret    
80105a94:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105a9b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105a9f:	90                   	nop

80105aa0 <sys_mknod>:

int sys_mknod(void)
{
80105aa0:	f3 0f 1e fb          	endbr32 
80105aa4:	55                   	push   %ebp
80105aa5:	89 e5                	mov    %esp,%ebp
80105aa7:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80105aaa:	e8 c1 d8 ff ff       	call   80103370 <begin_op>
  if ((argstr(0, &path)) < 0 ||
80105aaf:	83 ec 08             	sub    $0x8,%esp
80105ab2:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105ab5:	50                   	push   %eax
80105ab6:	6a 00                	push   $0x0
80105ab8:	e8 33 f6 ff ff       	call   801050f0 <argstr>
80105abd:	83 c4 10             	add    $0x10,%esp
80105ac0:	85 c0                	test   %eax,%eax
80105ac2:	78 64                	js     80105b28 <sys_mknod+0x88>
      argint(1, &major) < 0 ||
80105ac4:	83 ec 08             	sub    $0x8,%esp
80105ac7:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105aca:	50                   	push   %eax
80105acb:	6a 01                	push   $0x1
80105acd:	e8 6e f5 ff ff       	call   80105040 <argint>
  if ((argstr(0, &path)) < 0 ||
80105ad2:	83 c4 10             	add    $0x10,%esp
80105ad5:	85 c0                	test   %eax,%eax
80105ad7:	78 4f                	js     80105b28 <sys_mknod+0x88>
      argint(2, &minor) < 0 ||
80105ad9:	83 ec 08             	sub    $0x8,%esp
80105adc:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105adf:	50                   	push   %eax
80105ae0:	6a 02                	push   $0x2
80105ae2:	e8 59 f5 ff ff       	call   80105040 <argint>
      argint(1, &major) < 0 ||
80105ae7:	83 c4 10             	add    $0x10,%esp
80105aea:	85 c0                	test   %eax,%eax
80105aec:	78 3a                	js     80105b28 <sys_mknod+0x88>
      (ip = create(path, T_DEV, major, minor)) == 0)
80105aee:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
80105af2:	83 ec 0c             	sub    $0xc,%esp
80105af5:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
80105af9:	ba 03 00 00 00       	mov    $0x3,%edx
80105afe:	50                   	push   %eax
80105aff:	8b 45 ec             	mov    -0x14(%ebp),%eax
80105b02:	e8 99 f6 ff ff       	call   801051a0 <create>
      argint(2, &minor) < 0 ||
80105b07:	83 c4 10             	add    $0x10,%esp
80105b0a:	85 c0                	test   %eax,%eax
80105b0c:	74 1a                	je     80105b28 <sys_mknod+0x88>
  {
    end_op();
    return -1;
  }
  iunlockput(ip);
80105b0e:	83 ec 0c             	sub    $0xc,%esp
80105b11:	50                   	push   %eax
80105b12:	e8 29 c5 ff ff       	call   80102040 <iunlockput>
  end_op();
80105b17:	e8 c4 d8 ff ff       	call   801033e0 <end_op>
  return 0;
80105b1c:	83 c4 10             	add    $0x10,%esp
80105b1f:	31 c0                	xor    %eax,%eax
}
80105b21:	c9                   	leave  
80105b22:	c3                   	ret    
80105b23:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105b27:	90                   	nop
    end_op();
80105b28:	e8 b3 d8 ff ff       	call   801033e0 <end_op>
    return -1;
80105b2d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105b32:	c9                   	leave  
80105b33:	c3                   	ret    
80105b34:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105b3b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105b3f:	90                   	nop

80105b40 <sys_chdir>:

int sys_chdir(void)
{
80105b40:	f3 0f 1e fb          	endbr32 
80105b44:	55                   	push   %ebp
80105b45:	89 e5                	mov    %esp,%ebp
80105b47:	56                   	push   %esi
80105b48:	53                   	push   %ebx
80105b49:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
80105b4c:	e8 4f e4 ff ff       	call   80103fa0 <myproc>
80105b51:	89 c6                	mov    %eax,%esi

  begin_op();
80105b53:	e8 18 d8 ff ff       	call   80103370 <begin_op>
  if (argstr(0, &path) < 0 || (ip = namei(path)) == 0)
80105b58:	83 ec 08             	sub    $0x8,%esp
80105b5b:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105b5e:	50                   	push   %eax
80105b5f:	6a 00                	push   $0x0
80105b61:	e8 8a f5 ff ff       	call   801050f0 <argstr>
80105b66:	83 c4 10             	add    $0x10,%esp
80105b69:	85 c0                	test   %eax,%eax
80105b6b:	78 73                	js     80105be0 <sys_chdir+0xa0>
80105b6d:	83 ec 0c             	sub    $0xc,%esp
80105b70:	ff 75 f4             	pushl  -0xc(%ebp)
80105b73:	e8 f8 ca ff ff       	call   80102670 <namei>
80105b78:	83 c4 10             	add    $0x10,%esp
80105b7b:	89 c3                	mov    %eax,%ebx
80105b7d:	85 c0                	test   %eax,%eax
80105b7f:	74 5f                	je     80105be0 <sys_chdir+0xa0>
  {
    end_op();
    return -1;
  }
  ilock(ip);
80105b81:	83 ec 0c             	sub    $0xc,%esp
80105b84:	50                   	push   %eax
80105b85:	e8 16 c2 ff ff       	call   80101da0 <ilock>
  if (ip->type != T_DIR)
80105b8a:	83 c4 10             	add    $0x10,%esp
80105b8d:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105b92:	75 2c                	jne    80105bc0 <sys_chdir+0x80>
  {
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105b94:	83 ec 0c             	sub    $0xc,%esp
80105b97:	53                   	push   %ebx
80105b98:	e8 e3 c2 ff ff       	call   80101e80 <iunlock>
  iput(curproc->cwd);
80105b9d:	58                   	pop    %eax
80105b9e:	ff 76 68             	pushl  0x68(%esi)
80105ba1:	e8 2a c3 ff ff       	call   80101ed0 <iput>
  end_op();
80105ba6:	e8 35 d8 ff ff       	call   801033e0 <end_op>
  curproc->cwd = ip;
80105bab:	89 5e 68             	mov    %ebx,0x68(%esi)
  return 0;
80105bae:	83 c4 10             	add    $0x10,%esp
80105bb1:	31 c0                	xor    %eax,%eax
}
80105bb3:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105bb6:	5b                   	pop    %ebx
80105bb7:	5e                   	pop    %esi
80105bb8:	5d                   	pop    %ebp
80105bb9:	c3                   	ret    
80105bba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(ip);
80105bc0:	83 ec 0c             	sub    $0xc,%esp
80105bc3:	53                   	push   %ebx
80105bc4:	e8 77 c4 ff ff       	call   80102040 <iunlockput>
    end_op();
80105bc9:	e8 12 d8 ff ff       	call   801033e0 <end_op>
    return -1;
80105bce:	83 c4 10             	add    $0x10,%esp
80105bd1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105bd6:	eb db                	jmp    80105bb3 <sys_chdir+0x73>
80105bd8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105bdf:	90                   	nop
    end_op();
80105be0:	e8 fb d7 ff ff       	call   801033e0 <end_op>
    return -1;
80105be5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105bea:	eb c7                	jmp    80105bb3 <sys_chdir+0x73>
80105bec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105bf0 <sys_exec>:

int sys_exec(void)
{
80105bf0:	f3 0f 1e fb          	endbr32 
80105bf4:	55                   	push   %ebp
80105bf5:	89 e5                	mov    %esp,%ebp
80105bf7:	57                   	push   %edi
80105bf8:	56                   	push   %esi
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if (argstr(0, &path) < 0 || argint(1, (int *)&uargv) < 0)
80105bf9:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
{
80105bff:	53                   	push   %ebx
80105c00:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  if (argstr(0, &path) < 0 || argint(1, (int *)&uargv) < 0)
80105c06:	50                   	push   %eax
80105c07:	6a 00                	push   $0x0
80105c09:	e8 e2 f4 ff ff       	call   801050f0 <argstr>
80105c0e:	83 c4 10             	add    $0x10,%esp
80105c11:	85 c0                	test   %eax,%eax
80105c13:	0f 88 8b 00 00 00    	js     80105ca4 <sys_exec+0xb4>
80105c19:	83 ec 08             	sub    $0x8,%esp
80105c1c:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
80105c22:	50                   	push   %eax
80105c23:	6a 01                	push   $0x1
80105c25:	e8 16 f4 ff ff       	call   80105040 <argint>
80105c2a:	83 c4 10             	add    $0x10,%esp
80105c2d:	85 c0                	test   %eax,%eax
80105c2f:	78 73                	js     80105ca4 <sys_exec+0xb4>
  {
    return -1;
  }
  memset(argv, 0, sizeof(argv));
80105c31:	83 ec 04             	sub    $0x4,%esp
80105c34:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
  for (i = 0;; i++)
80105c3a:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
80105c3c:	68 80 00 00 00       	push   $0x80
80105c41:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
80105c47:	6a 00                	push   $0x0
80105c49:	50                   	push   %eax
80105c4a:	e8 11 f1 ff ff       	call   80104d60 <memset>
80105c4f:	83 c4 10             	add    $0x10,%esp
80105c52:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  {
    if (i >= NELEM(argv))
      return -1;
    if (fetchint(uargv + 4 * i, (int *)&uarg) < 0)
80105c58:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
80105c5e:	8d 34 9d 00 00 00 00 	lea    0x0(,%ebx,4),%esi
80105c65:	83 ec 08             	sub    $0x8,%esp
80105c68:	57                   	push   %edi
80105c69:	01 f0                	add    %esi,%eax
80105c6b:	50                   	push   %eax
80105c6c:	e8 2f f3 ff ff       	call   80104fa0 <fetchint>
80105c71:	83 c4 10             	add    $0x10,%esp
80105c74:	85 c0                	test   %eax,%eax
80105c76:	78 2c                	js     80105ca4 <sys_exec+0xb4>
      return -1;
    if (uarg == 0)
80105c78:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80105c7e:	85 c0                	test   %eax,%eax
80105c80:	74 36                	je     80105cb8 <sys_exec+0xc8>
    {
      argv[i] = 0;
      break;
    }
    if (fetchstr(uarg, &argv[i]) < 0)
80105c82:	8d 8d 68 ff ff ff    	lea    -0x98(%ebp),%ecx
80105c88:	83 ec 08             	sub    $0x8,%esp
80105c8b:	8d 14 31             	lea    (%ecx,%esi,1),%edx
80105c8e:	52                   	push   %edx
80105c8f:	50                   	push   %eax
80105c90:	e8 4b f3 ff ff       	call   80104fe0 <fetchstr>
80105c95:	83 c4 10             	add    $0x10,%esp
80105c98:	85 c0                	test   %eax,%eax
80105c9a:	78 08                	js     80105ca4 <sys_exec+0xb4>
  for (i = 0;; i++)
80105c9c:	83 c3 01             	add    $0x1,%ebx
    if (i >= NELEM(argv))
80105c9f:	83 fb 20             	cmp    $0x20,%ebx
80105ca2:	75 b4                	jne    80105c58 <sys_exec+0x68>
      return -1;
  }
  return exec(path, argv);
}
80105ca4:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
80105ca7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105cac:	5b                   	pop    %ebx
80105cad:	5e                   	pop    %esi
80105cae:	5f                   	pop    %edi
80105caf:	5d                   	pop    %ebp
80105cb0:	c3                   	ret    
80105cb1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return exec(path, argv);
80105cb8:	83 ec 08             	sub    $0x8,%esp
80105cbb:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
      argv[i] = 0;
80105cc1:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
80105cc8:	00 00 00 00 
  return exec(path, argv);
80105ccc:	50                   	push   %eax
80105ccd:	ff b5 5c ff ff ff    	pushl  -0xa4(%ebp)
80105cd3:	e8 e8 b3 ff ff       	call   801010c0 <exec>
80105cd8:	83 c4 10             	add    $0x10,%esp
}
80105cdb:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105cde:	5b                   	pop    %ebx
80105cdf:	5e                   	pop    %esi
80105ce0:	5f                   	pop    %edi
80105ce1:	5d                   	pop    %ebp
80105ce2:	c3                   	ret    
80105ce3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105cea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105cf0 <sys_pipe>:

int sys_pipe(void)
{
80105cf0:	f3 0f 1e fb          	endbr32 
80105cf4:	55                   	push   %ebp
80105cf5:	89 e5                	mov    %esp,%ebp
80105cf7:	57                   	push   %edi
80105cf8:	56                   	push   %esi
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if (argptr(0, (void *)&fd, 2 * sizeof(fd[0])) < 0)
80105cf9:	8d 45 dc             	lea    -0x24(%ebp),%eax
{
80105cfc:	53                   	push   %ebx
80105cfd:	83 ec 20             	sub    $0x20,%esp
  if (argptr(0, (void *)&fd, 2 * sizeof(fd[0])) < 0)
80105d00:	6a 08                	push   $0x8
80105d02:	50                   	push   %eax
80105d03:	6a 00                	push   $0x0
80105d05:	e8 86 f3 ff ff       	call   80105090 <argptr>
80105d0a:	83 c4 10             	add    $0x10,%esp
80105d0d:	85 c0                	test   %eax,%eax
80105d0f:	78 4e                	js     80105d5f <sys_pipe+0x6f>
    return -1;
  if (pipealloc(&rf, &wf) < 0)
80105d11:	83 ec 08             	sub    $0x8,%esp
80105d14:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105d17:	50                   	push   %eax
80105d18:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105d1b:	50                   	push   %eax
80105d1c:	e8 0f dd ff ff       	call   80103a30 <pipealloc>
80105d21:	83 c4 10             	add    $0x10,%esp
80105d24:	85 c0                	test   %eax,%eax
80105d26:	78 37                	js     80105d5f <sys_pipe+0x6f>
    return -1;
  fd0 = -1;
  if ((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0)
80105d28:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for (fd = 0; fd < NOFILE; fd++)
80105d2b:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
80105d2d:	e8 6e e2 ff ff       	call   80103fa0 <myproc>
  for (fd = 0; fd < NOFILE; fd++)
80105d32:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if (curproc->ofile[fd] == 0)
80105d38:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
80105d3c:	85 f6                	test   %esi,%esi
80105d3e:	74 30                	je     80105d70 <sys_pipe+0x80>
  for (fd = 0; fd < NOFILE; fd++)
80105d40:	83 c3 01             	add    $0x1,%ebx
80105d43:	83 fb 10             	cmp    $0x10,%ebx
80105d46:	75 f0                	jne    80105d38 <sys_pipe+0x48>
  {
    if (fd0 >= 0)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
80105d48:	83 ec 0c             	sub    $0xc,%esp
80105d4b:	ff 75 e0             	pushl  -0x20(%ebp)
80105d4e:	e8 ad b7 ff ff       	call   80101500 <fileclose>
    fileclose(wf);
80105d53:	58                   	pop    %eax
80105d54:	ff 75 e4             	pushl  -0x1c(%ebp)
80105d57:	e8 a4 b7 ff ff       	call   80101500 <fileclose>
    return -1;
80105d5c:	83 c4 10             	add    $0x10,%esp
80105d5f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105d64:	eb 5b                	jmp    80105dc1 <sys_pipe+0xd1>
80105d66:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105d6d:	8d 76 00             	lea    0x0(%esi),%esi
      curproc->ofile[fd] = f;
80105d70:	8d 73 08             	lea    0x8(%ebx),%esi
80105d73:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if ((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0)
80105d77:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  struct proc *curproc = myproc();
80105d7a:	e8 21 e2 ff ff       	call   80103fa0 <myproc>
  for (fd = 0; fd < NOFILE; fd++)
80105d7f:	31 d2                	xor    %edx,%edx
80105d81:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if (curproc->ofile[fd] == 0)
80105d88:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
80105d8c:	85 c9                	test   %ecx,%ecx
80105d8e:	74 20                	je     80105db0 <sys_pipe+0xc0>
  for (fd = 0; fd < NOFILE; fd++)
80105d90:	83 c2 01             	add    $0x1,%edx
80105d93:	83 fa 10             	cmp    $0x10,%edx
80105d96:	75 f0                	jne    80105d88 <sys_pipe+0x98>
      myproc()->ofile[fd0] = 0;
80105d98:	e8 03 e2 ff ff       	call   80103fa0 <myproc>
80105d9d:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
80105da4:	00 
80105da5:	eb a1                	jmp    80105d48 <sys_pipe+0x58>
80105da7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105dae:	66 90                	xchg   %ax,%ax
      curproc->ofile[fd] = f;
80105db0:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
  }
  fd[0] = fd0;
80105db4:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105db7:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
80105db9:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105dbc:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
80105dbf:	31 c0                	xor    %eax,%eax
}
80105dc1:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105dc4:	5b                   	pop    %ebx
80105dc5:	5e                   	pop    %esi
80105dc6:	5f                   	pop    %edi
80105dc7:	5d                   	pop    %ebp
80105dc8:	c3                   	ret    
80105dc9:	66 90                	xchg   %ax,%ax
80105dcb:	66 90                	xchg   %ax,%ax
80105dcd:	66 90                	xchg   %ax,%ax
80105dcf:	90                   	nop

80105dd0 <sys_fork>:
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"

int sys_fork(void)
{
80105dd0:	f3 0f 1e fb          	endbr32 
	return fork();
80105dd4:	e9 77 e3 ff ff       	jmp    80104150 <fork>
80105dd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105de0 <sys_exit>:
}

int sys_exit(void)
{
80105de0:	f3 0f 1e fb          	endbr32 
80105de4:	55                   	push   %ebp
80105de5:	89 e5                	mov    %esp,%ebp
80105de7:	83 ec 08             	sub    $0x8,%esp
	exit();
80105dea:	e8 11 e6 ff ff       	call   80104400 <exit>
	return 0; // not reached
}
80105def:	31 c0                	xor    %eax,%eax
80105df1:	c9                   	leave  
80105df2:	c3                   	ret    
80105df3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105dfa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105e00 <sys_wait>:

int sys_wait(void)
{
80105e00:	f3 0f 1e fb          	endbr32 
	return wait();
80105e04:	e9 47 e8 ff ff       	jmp    80104650 <wait>
80105e09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105e10 <sys_kill>:
}

int sys_kill(void)
{
80105e10:	f3 0f 1e fb          	endbr32 
80105e14:	55                   	push   %ebp
80105e15:	89 e5                	mov    %esp,%ebp
80105e17:	83 ec 20             	sub    $0x20,%esp
	int pid;

	if (argint(0, &pid) < 0)
80105e1a:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105e1d:	50                   	push   %eax
80105e1e:	6a 00                	push   $0x0
80105e20:	e8 1b f2 ff ff       	call   80105040 <argint>
80105e25:	83 c4 10             	add    $0x10,%esp
80105e28:	85 c0                	test   %eax,%eax
80105e2a:	78 14                	js     80105e40 <sys_kill+0x30>
		return -1;
	return kill(pid);
80105e2c:	83 ec 0c             	sub    $0xc,%esp
80105e2f:	ff 75 f4             	pushl  -0xc(%ebp)
80105e32:	e8 79 e9 ff ff       	call   801047b0 <kill>
80105e37:	83 c4 10             	add    $0x10,%esp
}
80105e3a:	c9                   	leave  
80105e3b:	c3                   	ret    
80105e3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105e40:	c9                   	leave  
		return -1;
80105e41:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105e46:	c3                   	ret    
80105e47:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105e4e:	66 90                	xchg   %ax,%ax

80105e50 <sys_getpid>:

int sys_getpid(void)
{
80105e50:	f3 0f 1e fb          	endbr32 
80105e54:	55                   	push   %ebp
80105e55:	89 e5                	mov    %esp,%ebp
80105e57:	83 ec 08             	sub    $0x8,%esp
	return myproc()->pid;
80105e5a:	e8 41 e1 ff ff       	call   80103fa0 <myproc>
80105e5f:	8b 40 10             	mov    0x10(%eax),%eax
}
80105e62:	c9                   	leave  
80105e63:	c3                   	ret    
80105e64:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105e6b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105e6f:	90                   	nop

80105e70 <sys_sbrk>:

int sys_sbrk(void)
{
80105e70:	f3 0f 1e fb          	endbr32 
80105e74:	55                   	push   %ebp
80105e75:	89 e5                	mov    %esp,%ebp
80105e77:	53                   	push   %ebx
	int addr;
	int n;

	if (argint(0, &n) < 0)
80105e78:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105e7b:	83 ec 1c             	sub    $0x1c,%esp
	if (argint(0, &n) < 0)
80105e7e:	50                   	push   %eax
80105e7f:	6a 00                	push   $0x0
80105e81:	e8 ba f1 ff ff       	call   80105040 <argint>
80105e86:	83 c4 10             	add    $0x10,%esp
80105e89:	85 c0                	test   %eax,%eax
80105e8b:	78 23                	js     80105eb0 <sys_sbrk+0x40>
		return -1;
	addr = myproc()->sz;
80105e8d:	e8 0e e1 ff ff       	call   80103fa0 <myproc>
	if (growproc(n) < 0)
80105e92:	83 ec 0c             	sub    $0xc,%esp
	addr = myproc()->sz;
80105e95:	8b 18                	mov    (%eax),%ebx
	if (growproc(n) < 0)
80105e97:	ff 75 f4             	pushl  -0xc(%ebp)
80105e9a:	e8 31 e2 ff ff       	call   801040d0 <growproc>
80105e9f:	83 c4 10             	add    $0x10,%esp
80105ea2:	85 c0                	test   %eax,%eax
80105ea4:	78 0a                	js     80105eb0 <sys_sbrk+0x40>
		return -1;
	return addr;
}
80105ea6:	89 d8                	mov    %ebx,%eax
80105ea8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105eab:	c9                   	leave  
80105eac:	c3                   	ret    
80105ead:	8d 76 00             	lea    0x0(%esi),%esi
		return -1;
80105eb0:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105eb5:	eb ef                	jmp    80105ea6 <sys_sbrk+0x36>
80105eb7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105ebe:	66 90                	xchg   %ax,%ax

80105ec0 <sys_sleep>:

int sys_sleep(void)
{
80105ec0:	f3 0f 1e fb          	endbr32 
80105ec4:	55                   	push   %ebp
80105ec5:	89 e5                	mov    %esp,%ebp
80105ec7:	53                   	push   %ebx
	int n;
	uint ticks0;

	if (argint(0, &n) < 0)
80105ec8:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105ecb:	83 ec 1c             	sub    $0x1c,%esp
	if (argint(0, &n) < 0)
80105ece:	50                   	push   %eax
80105ecf:	6a 00                	push   $0x0
80105ed1:	e8 6a f1 ff ff       	call   80105040 <argint>
80105ed6:	83 c4 10             	add    $0x10,%esp
80105ed9:	85 c0                	test   %eax,%eax
80105edb:	0f 88 86 00 00 00    	js     80105f67 <sys_sleep+0xa7>
		return -1;
	acquire(&tickslock);
80105ee1:	83 ec 0c             	sub    $0xc,%esp
80105ee4:	68 a0 69 11 80       	push   $0x801169a0
80105ee9:	e8 62 ed ff ff       	call   80104c50 <acquire>
	ticks0 = ticks;
	while (ticks - ticks0 < n)
80105eee:	8b 55 f4             	mov    -0xc(%ebp),%edx
	ticks0 = ticks;
80105ef1:	8b 1d e0 71 11 80    	mov    0x801171e0,%ebx
	while (ticks - ticks0 < n)
80105ef7:	83 c4 10             	add    $0x10,%esp
80105efa:	85 d2                	test   %edx,%edx
80105efc:	75 23                	jne    80105f21 <sys_sleep+0x61>
80105efe:	eb 50                	jmp    80105f50 <sys_sleep+0x90>
		if (myproc()->killed)
		{
			release(&tickslock);
			return -1;
		}
		sleep(&ticks, &tickslock);
80105f00:	83 ec 08             	sub    $0x8,%esp
80105f03:	68 a0 69 11 80       	push   $0x801169a0
80105f08:	68 e0 71 11 80       	push   $0x801171e0
80105f0d:	e8 7e e6 ff ff       	call   80104590 <sleep>
	while (ticks - ticks0 < n)
80105f12:	a1 e0 71 11 80       	mov    0x801171e0,%eax
80105f17:	83 c4 10             	add    $0x10,%esp
80105f1a:	29 d8                	sub    %ebx,%eax
80105f1c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80105f1f:	73 2f                	jae    80105f50 <sys_sleep+0x90>
		if (myproc()->killed)
80105f21:	e8 7a e0 ff ff       	call   80103fa0 <myproc>
80105f26:	8b 40 24             	mov    0x24(%eax),%eax
80105f29:	85 c0                	test   %eax,%eax
80105f2b:	74 d3                	je     80105f00 <sys_sleep+0x40>
			release(&tickslock);
80105f2d:	83 ec 0c             	sub    $0xc,%esp
80105f30:	68 a0 69 11 80       	push   $0x801169a0
80105f35:	e8 d6 ed ff ff       	call   80104d10 <release>
	}
	release(&tickslock);
	return 0;
}
80105f3a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
			return -1;
80105f3d:	83 c4 10             	add    $0x10,%esp
80105f40:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105f45:	c9                   	leave  
80105f46:	c3                   	ret    
80105f47:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105f4e:	66 90                	xchg   %ax,%ax
	release(&tickslock);
80105f50:	83 ec 0c             	sub    $0xc,%esp
80105f53:	68 a0 69 11 80       	push   $0x801169a0
80105f58:	e8 b3 ed ff ff       	call   80104d10 <release>
	return 0;
80105f5d:	83 c4 10             	add    $0x10,%esp
80105f60:	31 c0                	xor    %eax,%eax
}
80105f62:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105f65:	c9                   	leave  
80105f66:	c3                   	ret    
		return -1;
80105f67:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105f6c:	eb f4                	jmp    80105f62 <sys_sleep+0xa2>
80105f6e:	66 90                	xchg   %ax,%ax

80105f70 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int sys_uptime(void)
{
80105f70:	f3 0f 1e fb          	endbr32 
80105f74:	55                   	push   %ebp
80105f75:	89 e5                	mov    %esp,%ebp
80105f77:	53                   	push   %ebx
80105f78:	83 ec 10             	sub    $0x10,%esp
	uint xticks;

	acquire(&tickslock);
80105f7b:	68 a0 69 11 80       	push   $0x801169a0
80105f80:	e8 cb ec ff ff       	call   80104c50 <acquire>
	xticks = ticks;
80105f85:	8b 1d e0 71 11 80    	mov    0x801171e0,%ebx
	release(&tickslock);
80105f8b:	c7 04 24 a0 69 11 80 	movl   $0x801169a0,(%esp)
80105f92:	e8 79 ed ff ff       	call   80104d10 <release>
	return xticks;
}
80105f97:	89 d8                	mov    %ebx,%eax
80105f99:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105f9c:	c9                   	leave  
80105f9d:	c3                   	ret    
80105f9e:	66 90                	xchg   %ax,%ax

80105fa0 <sys_lifetime>:

uint sys_lifetime(void){
80105fa0:	f3 0f 1e fb          	endbr32 
80105fa4:	55                   	push   %ebp
80105fa5:	89 e5                	mov    %esp,%ebp
80105fa7:	56                   	push   %esi
80105fa8:	53                   	push   %ebx
	uint xticks;

	acquire(&tickslock);
80105fa9:	83 ec 0c             	sub    $0xc,%esp
80105fac:	68 a0 69 11 80       	push   $0x801169a0
80105fb1:	e8 9a ec ff ff       	call   80104c50 <acquire>
	xticks = ticks;
80105fb6:	8b 1d e0 71 11 80    	mov    0x801171e0,%ebx
	release(&tickslock);
80105fbc:	c7 04 24 a0 69 11 80 	movl   $0x801169a0,(%esp)
80105fc3:	e8 48 ed ff ff       	call   80104d10 <release>
	
  	struct proc *my_proc = myproc(); // Get the current process
80105fc8:	e8 d3 df ff ff       	call   80103fa0 <myproc>

	cprintf("[sys_lifetime] Current time  is: %d this app creation time is: %d\n",xticks,my_proc->xticks);
80105fcd:	83 c4 0c             	add    $0xc,%esp
80105fd0:	ff 70 6c             	pushl  0x6c(%eax)
  	struct proc *my_proc = myproc(); // Get the current process
80105fd3:	89 c6                	mov    %eax,%esi
	cprintf("[sys_lifetime] Current time  is: %d this app creation time is: %d\n",xticks,my_proc->xticks);
80105fd5:	53                   	push   %ebx
80105fd6:	68 cc 80 10 80       	push   $0x801080cc
80105fdb:	e8 c0 a7 ff ff       	call   801007a0 <cprintf>
	return (xticks-my_proc->xticks)/100;
80105fe0:	2b 5e 6c             	sub    0x6c(%esi),%ebx
80105fe3:	ba 1f 85 eb 51       	mov    $0x51eb851f,%edx

80105fe8:	8d 65 f8             	lea    -0x8(%ebp),%esp
	return (xticks-my_proc->xticks)/100;
80105feb:	89 d8                	mov    %ebx,%eax
80105fed:	5b                   	pop    %ebx
80105fee:	5e                   	pop    %esi
	return (xticks-my_proc->xticks)/100;
80105fef:	f7 e2                	mul    %edx
80105ff1:	5d                   	pop    %ebp
	return (xticks-my_proc->xticks)/100;
80105ff2:	89 d0                	mov    %edx,%eax
80105ff4:	c1 e8 05             	shr    $0x5,%eax
80105ff7:	c3                   	ret    
80105ff8:	66 90                	xchg   %ax,%ax
80105ffa:	66 90                	xchg   %ax,%ax
80105ffc:	66 90                	xchg   %ax,%ax
80105ffe:	66 90                	xchg   %ax,%ax

80106000 <sys_find_digital_root>:
#include "mmu.h"
#include "proc.h"

// return digital root of number given
int sys_find_digital_root(void)
{
80106000:	f3 0f 1e fb          	endbr32 
80106004:	55                   	push   %ebp
80106005:	89 e5                	mov    %esp,%ebp
80106007:	56                   	push   %esi
80106008:	53                   	push   %ebx
    int n = myproc()->tf->ebx;
80106009:	e8 92 df ff ff       	call   80103fa0 <myproc>
    int res = 0;
8010600e:	31 c9                	xor    %ecx,%ecx
    int n = myproc()->tf->ebx;
80106010:	8b 40 18             	mov    0x18(%eax),%eax
80106013:	8b 70 10             	mov    0x10(%eax),%esi
    while (n > 0)
80106016:	85 f6                	test   %esi,%esi
80106018:	7e 4d                	jle    80106067 <sys_find_digital_root+0x67>
    {
        res += n % 10;
8010601a:	89 f0                	mov    %esi,%eax
8010601c:	ba 67 66 66 66       	mov    $0x66666667,%edx
80106021:	f7 ea                	imul   %edx
80106023:	89 f0                	mov    %esi,%eax
80106025:	c1 f8 1f             	sar    $0x1f,%eax
80106028:	c1 fa 02             	sar    $0x2,%edx
8010602b:	89 d1                	mov    %edx,%ecx
8010602d:	29 c1                	sub    %eax,%ecx
8010602f:	8d 04 89             	lea    (%ecx,%ecx,4),%eax
80106032:	89 cb                	mov    %ecx,%ebx
80106034:	01 c0                	add    %eax,%eax
80106036:	29 c6                	sub    %eax,%esi
80106038:	89 f1                	mov    %esi,%ecx
8010603a:	be cd cc cc cc       	mov    $0xcccccccd,%esi
8010603f:	eb 22                	jmp    80106063 <sys_find_digital_root+0x63>
80106041:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106048:	89 d8                	mov    %ebx,%eax
8010604a:	f7 e6                	mul    %esi
8010604c:	c1 ea 03             	shr    $0x3,%edx
8010604f:	8d 04 92             	lea    (%edx,%edx,4),%eax
80106052:	01 c0                	add    %eax,%eax
80106054:	29 c3                	sub    %eax,%ebx
80106056:	01 d9                	add    %ebx,%ecx
        n /= 10;
80106058:	89 d3                	mov    %edx,%ebx
        if (res > 9)
            res -= 9;
8010605a:	8d 41 f7             	lea    -0x9(%ecx),%eax
8010605d:	83 f9 09             	cmp    $0x9,%ecx
80106060:	0f 4f c8             	cmovg  %eax,%ecx
    while (n > 0)
80106063:	85 db                	test   %ebx,%ebx
80106065:	75 e1                	jne    80106048 <sys_find_digital_root+0x48>
    }
    return res;
80106067:	5b                   	pop    %ebx
80106068:	89 c8                	mov    %ecx,%eax
8010606a:	5e                   	pop    %esi
8010606b:	5d                   	pop    %ebp
8010606c:	c3                   	ret    

8010606d <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
8010606d:	1e                   	push   %ds
  pushl %es
8010606e:	06                   	push   %es
  pushl %fs
8010606f:	0f a0                	push   %fs
  pushl %gs
80106071:	0f a8                	push   %gs
  pushal
80106073:	60                   	pusha  
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
80106074:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
80106078:	8e d8                	mov    %eax,%ds
  movw %ax, %es
8010607a:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
8010607c:	54                   	push   %esp
  call trap
8010607d:	e8 be 00 00 00       	call   80106140 <trap>
  addl $4, %esp
80106082:	83 c4 04             	add    $0x4,%esp

80106085 <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
80106085:	61                   	popa   
  popl %gs
80106086:	0f a9                	pop    %gs
  popl %fs
80106088:	0f a1                	pop    %fs
  popl %es
8010608a:	07                   	pop    %es
  popl %ds
8010608b:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
8010608c:	83 c4 08             	add    $0x8,%esp
  iret
8010608f:	cf                   	iret   

80106090 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80106090:	f3 0f 1e fb          	endbr32 
80106094:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
80106095:	31 c0                	xor    %eax,%eax
{
80106097:	89 e5                	mov    %esp,%ebp
80106099:	83 ec 08             	sub    $0x8,%esp
8010609c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
801060a0:	8b 14 85 08 b0 10 80 	mov    -0x7fef4ff8(,%eax,4),%edx
801060a7:	c7 04 c5 e2 69 11 80 	movl   $0x8e000008,-0x7fee961e(,%eax,8)
801060ae:	08 00 00 8e 
801060b2:	66 89 14 c5 e0 69 11 	mov    %dx,-0x7fee9620(,%eax,8)
801060b9:	80 
801060ba:	c1 ea 10             	shr    $0x10,%edx
801060bd:	66 89 14 c5 e6 69 11 	mov    %dx,-0x7fee961a(,%eax,8)
801060c4:	80 
  for(i = 0; i < 256; i++)
801060c5:	83 c0 01             	add    $0x1,%eax
801060c8:	3d 00 01 00 00       	cmp    $0x100,%eax
801060cd:	75 d1                	jne    801060a0 <tvinit+0x10>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);

  initlock(&tickslock, "time");
801060cf:	83 ec 08             	sub    $0x8,%esp
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
801060d2:	a1 08 b1 10 80       	mov    0x8010b108,%eax
801060d7:	c7 05 e2 6b 11 80 08 	movl   $0xef000008,0x80116be2
801060de:	00 00 ef 
  initlock(&tickslock, "time");
801060e1:	68 0f 81 10 80       	push   $0x8010810f
801060e6:	68 a0 69 11 80       	push   $0x801169a0
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
801060eb:	66 a3 e0 6b 11 80    	mov    %ax,0x80116be0
801060f1:	c1 e8 10             	shr    $0x10,%eax
801060f4:	66 a3 e6 6b 11 80    	mov    %ax,0x80116be6
  initlock(&tickslock, "time");
801060fa:	e8 d1 e9 ff ff       	call   80104ad0 <initlock>
}
801060ff:	83 c4 10             	add    $0x10,%esp
80106102:	c9                   	leave  
80106103:	c3                   	ret    
80106104:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010610b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010610f:	90                   	nop

80106110 <idtinit>:

void
idtinit(void)
{
80106110:	f3 0f 1e fb          	endbr32 
80106114:	55                   	push   %ebp
  pd[0] = size - 1;
80106115:	b8 ff 07 00 00       	mov    $0x7ff,%eax
8010611a:	89 e5                	mov    %esp,%ebp
8010611c:	83 ec 10             	sub    $0x10,%esp
8010611f:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
80106123:	b8 e0 69 11 80       	mov    $0x801169e0,%eax
80106128:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
8010612c:	c1 e8 10             	shr    $0x10,%eax
8010612f:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r"(pd));
80106133:	8d 45 fa             	lea    -0x6(%ebp),%eax
80106136:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80106139:	c9                   	leave  
8010613a:	c3                   	ret    
8010613b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010613f:	90                   	nop

80106140 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80106140:	f3 0f 1e fb          	endbr32 
80106144:	55                   	push   %ebp
80106145:	89 e5                	mov    %esp,%ebp
80106147:	57                   	push   %edi
80106148:	56                   	push   %esi
80106149:	53                   	push   %ebx
8010614a:	83 ec 1c             	sub    $0x1c,%esp
8010614d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(tf->trapno == T_SYSCALL){
80106150:	8b 43 30             	mov    0x30(%ebx),%eax
80106153:	83 f8 40             	cmp    $0x40,%eax
80106156:	0f 84 bc 01 00 00    	je     80106318 <trap+0x1d8>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
8010615c:	83 e8 20             	sub    $0x20,%eax
8010615f:	83 f8 1f             	cmp    $0x1f,%eax
80106162:	77 08                	ja     8010616c <trap+0x2c>
80106164:	3e ff 24 85 b8 81 10 	notrack jmp *-0x7fef7e48(,%eax,4)
8010616b:	80 
    lapiceoi();
    break;

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
8010616c:	e8 2f de ff ff       	call   80103fa0 <myproc>
80106171:	8b 7b 38             	mov    0x38(%ebx),%edi
80106174:	85 c0                	test   %eax,%eax
80106176:	0f 84 eb 01 00 00    	je     80106367 <trap+0x227>
8010617c:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
80106180:	0f 84 e1 01 00 00    	je     80106367 <trap+0x227>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r"(val));
80106186:	0f 20 d1             	mov    %cr2,%ecx
80106189:	89 4d d8             	mov    %ecx,-0x28(%ebp)
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
8010618c:	e8 ef dd ff ff       	call   80103f80 <cpuid>
80106191:	8b 73 30             	mov    0x30(%ebx),%esi
80106194:	89 45 dc             	mov    %eax,-0x24(%ebp)
80106197:	8b 43 34             	mov    0x34(%ebx),%eax
8010619a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
8010619d:	e8 fe dd ff ff       	call   80103fa0 <myproc>
801061a2:	89 45 e0             	mov    %eax,-0x20(%ebp)
801061a5:	e8 f6 dd ff ff       	call   80103fa0 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801061aa:	8b 4d d8             	mov    -0x28(%ebp),%ecx
801061ad:	8b 55 dc             	mov    -0x24(%ebp),%edx
801061b0:	51                   	push   %ecx
801061b1:	57                   	push   %edi
801061b2:	52                   	push   %edx
801061b3:	ff 75 e4             	pushl  -0x1c(%ebp)
801061b6:	56                   	push   %esi
            myproc()->pid, myproc()->name, tf->trapno,
801061b7:	8b 75 e0             	mov    -0x20(%ebp),%esi
801061ba:	83 c6 70             	add    $0x70,%esi
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801061bd:	56                   	push   %esi
801061be:	ff 70 10             	pushl  0x10(%eax)
801061c1:	68 74 81 10 80       	push   $0x80108174
801061c6:	e8 d5 a5 ff ff       	call   801007a0 <cprintf>
            tf->err, cpuid(), tf->eip, rcr2());
    myproc()->killed = 1;
801061cb:	83 c4 20             	add    $0x20,%esp
801061ce:	e8 cd dd ff ff       	call   80103fa0 <myproc>
801061d3:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801061da:	e8 c1 dd ff ff       	call   80103fa0 <myproc>
801061df:	85 c0                	test   %eax,%eax
801061e1:	74 1d                	je     80106200 <trap+0xc0>
801061e3:	e8 b8 dd ff ff       	call   80103fa0 <myproc>
801061e8:	8b 50 24             	mov    0x24(%eax),%edx
801061eb:	85 d2                	test   %edx,%edx
801061ed:	74 11                	je     80106200 <trap+0xc0>
801061ef:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
801061f3:	83 e0 03             	and    $0x3,%eax
801061f6:	66 83 f8 03          	cmp    $0x3,%ax
801061fa:	0f 84 50 01 00 00    	je     80106350 <trap+0x210>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80106200:	e8 9b dd ff ff       	call   80103fa0 <myproc>
80106205:	85 c0                	test   %eax,%eax
80106207:	74 0f                	je     80106218 <trap+0xd8>
80106209:	e8 92 dd ff ff       	call   80103fa0 <myproc>
8010620e:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80106212:	0f 84 e8 00 00 00    	je     80106300 <trap+0x1c0>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106218:	e8 83 dd ff ff       	call   80103fa0 <myproc>
8010621d:	85 c0                	test   %eax,%eax
8010621f:	74 1d                	je     8010623e <trap+0xfe>
80106221:	e8 7a dd ff ff       	call   80103fa0 <myproc>
80106226:	8b 40 24             	mov    0x24(%eax),%eax
80106229:	85 c0                	test   %eax,%eax
8010622b:	74 11                	je     8010623e <trap+0xfe>
8010622d:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80106231:	83 e0 03             	and    $0x3,%eax
80106234:	66 83 f8 03          	cmp    $0x3,%ax
80106238:	0f 84 03 01 00 00    	je     80106341 <trap+0x201>
    exit();
}
8010623e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106241:	5b                   	pop    %ebx
80106242:	5e                   	pop    %esi
80106243:	5f                   	pop    %edi
80106244:	5d                   	pop    %ebp
80106245:	c3                   	ret    
    ideintr();
80106246:	e8 d5 c5 ff ff       	call   80102820 <ideintr>
    lapiceoi();
8010624b:	e8 b0 cc ff ff       	call   80102f00 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106250:	e8 4b dd ff ff       	call   80103fa0 <myproc>
80106255:	85 c0                	test   %eax,%eax
80106257:	75 8a                	jne    801061e3 <trap+0xa3>
80106259:	eb a5                	jmp    80106200 <trap+0xc0>
    if(cpuid() == 0){
8010625b:	e8 20 dd ff ff       	call   80103f80 <cpuid>
80106260:	85 c0                	test   %eax,%eax
80106262:	75 e7                	jne    8010624b <trap+0x10b>
      acquire(&tickslock);
80106264:	83 ec 0c             	sub    $0xc,%esp
80106267:	68 a0 69 11 80       	push   $0x801169a0
8010626c:	e8 df e9 ff ff       	call   80104c50 <acquire>
      wakeup(&ticks);
80106271:	c7 04 24 e0 71 11 80 	movl   $0x801171e0,(%esp)
      ticks++;
80106278:	83 05 e0 71 11 80 01 	addl   $0x1,0x801171e0
      wakeup(&ticks);
8010627f:	e8 cc e4 ff ff       	call   80104750 <wakeup>
      release(&tickslock);
80106284:	c7 04 24 a0 69 11 80 	movl   $0x801169a0,(%esp)
8010628b:	e8 80 ea ff ff       	call   80104d10 <release>
80106290:	83 c4 10             	add    $0x10,%esp
    lapiceoi();
80106293:	eb b6                	jmp    8010624b <trap+0x10b>
    kbdintr();
80106295:	e8 26 cb ff ff       	call   80102dc0 <kbdintr>
    lapiceoi();
8010629a:	e8 61 cc ff ff       	call   80102f00 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010629f:	e8 fc dc ff ff       	call   80103fa0 <myproc>
801062a4:	85 c0                	test   %eax,%eax
801062a6:	0f 85 37 ff ff ff    	jne    801061e3 <trap+0xa3>
801062ac:	e9 4f ff ff ff       	jmp    80106200 <trap+0xc0>
    uartintr();
801062b1:	e8 4a 02 00 00       	call   80106500 <uartintr>
    lapiceoi();
801062b6:	e8 45 cc ff ff       	call   80102f00 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801062bb:	e8 e0 dc ff ff       	call   80103fa0 <myproc>
801062c0:	85 c0                	test   %eax,%eax
801062c2:	0f 85 1b ff ff ff    	jne    801061e3 <trap+0xa3>
801062c8:	e9 33 ff ff ff       	jmp    80106200 <trap+0xc0>
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
801062cd:	8b 7b 38             	mov    0x38(%ebx),%edi
801062d0:	0f b7 73 3c          	movzwl 0x3c(%ebx),%esi
801062d4:	e8 a7 dc ff ff       	call   80103f80 <cpuid>
801062d9:	57                   	push   %edi
801062da:	56                   	push   %esi
801062db:	50                   	push   %eax
801062dc:	68 1c 81 10 80       	push   $0x8010811c
801062e1:	e8 ba a4 ff ff       	call   801007a0 <cprintf>
    lapiceoi();
801062e6:	e8 15 cc ff ff       	call   80102f00 <lapiceoi>
    break;
801062eb:	83 c4 10             	add    $0x10,%esp
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801062ee:	e8 ad dc ff ff       	call   80103fa0 <myproc>
801062f3:	85 c0                	test   %eax,%eax
801062f5:	0f 85 e8 fe ff ff    	jne    801061e3 <trap+0xa3>
801062fb:	e9 00 ff ff ff       	jmp    80106200 <trap+0xc0>
  if(myproc() && myproc()->state == RUNNING &&
80106300:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
80106304:	0f 85 0e ff ff ff    	jne    80106218 <trap+0xd8>
    yield();
8010630a:	e8 31 e2 ff ff       	call   80104540 <yield>
8010630f:	e9 04 ff ff ff       	jmp    80106218 <trap+0xd8>
80106314:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed)
80106318:	e8 83 dc ff ff       	call   80103fa0 <myproc>
8010631d:	8b 70 24             	mov    0x24(%eax),%esi
80106320:	85 f6                	test   %esi,%esi
80106322:	75 3c                	jne    80106360 <trap+0x220>
    myproc()->tf = tf;
80106324:	e8 77 dc ff ff       	call   80103fa0 <myproc>
80106329:	89 58 18             	mov    %ebx,0x18(%eax)
    syscall();
8010632c:	e8 ff ed ff ff       	call   80105130 <syscall>
    if(myproc()->killed)
80106331:	e8 6a dc ff ff       	call   80103fa0 <myproc>
80106336:	8b 48 24             	mov    0x24(%eax),%ecx
80106339:	85 c9                	test   %ecx,%ecx
8010633b:	0f 84 fd fe ff ff    	je     8010623e <trap+0xfe>
}
80106341:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106344:	5b                   	pop    %ebx
80106345:	5e                   	pop    %esi
80106346:	5f                   	pop    %edi
80106347:	5d                   	pop    %ebp
      exit();
80106348:	e9 b3 e0 ff ff       	jmp    80104400 <exit>
8010634d:	8d 76 00             	lea    0x0(%esi),%esi
    exit();
80106350:	e8 ab e0 ff ff       	call   80104400 <exit>
80106355:	e9 a6 fe ff ff       	jmp    80106200 <trap+0xc0>
8010635a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      exit();
80106360:	e8 9b e0 ff ff       	call   80104400 <exit>
80106365:	eb bd                	jmp    80106324 <trap+0x1e4>
80106367:	0f 20 d6             	mov    %cr2,%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
8010636a:	e8 11 dc ff ff       	call   80103f80 <cpuid>
8010636f:	83 ec 0c             	sub    $0xc,%esp
80106372:	56                   	push   %esi
80106373:	57                   	push   %edi
80106374:	50                   	push   %eax
80106375:	ff 73 30             	pushl  0x30(%ebx)
80106378:	68 40 81 10 80       	push   $0x80108140
8010637d:	e8 1e a4 ff ff       	call   801007a0 <cprintf>
      panic("trap");
80106382:	83 c4 14             	add    $0x14,%esp
80106385:	68 14 81 10 80       	push   $0x80108114
8010638a:	e8 21 a0 ff ff       	call   801003b0 <panic>
8010638f:	90                   	nop

80106390 <uartgetc>:
  outb(COM1+0, c);
}

static int
uartgetc(void)
{
80106390:	f3 0f 1e fb          	endbr32 
  if(!uart)
80106394:	a1 3c c2 10 80       	mov    0x8010c23c,%eax
80106399:	85 c0                	test   %eax,%eax
8010639b:	74 1b                	je     801063b8 <uartgetc+0x28>
  asm volatile("in %1,%0" : "=a"(data) : "d"(port));
8010639d:	ba fd 03 00 00       	mov    $0x3fd,%edx
801063a2:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
801063a3:	a8 01                	test   $0x1,%al
801063a5:	74 11                	je     801063b8 <uartgetc+0x28>
801063a7:	ba f8 03 00 00       	mov    $0x3f8,%edx
801063ac:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
801063ad:	0f b6 c0             	movzbl %al,%eax
801063b0:	c3                   	ret    
801063b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801063b8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801063bd:	c3                   	ret    
801063be:	66 90                	xchg   %ax,%ax

801063c0 <uartputc.part.0>:
uartputc(int c)
801063c0:	55                   	push   %ebp
801063c1:	89 e5                	mov    %esp,%ebp
801063c3:	57                   	push   %edi
801063c4:	89 c7                	mov    %eax,%edi
801063c6:	56                   	push   %esi
801063c7:	be fd 03 00 00       	mov    $0x3fd,%esi
801063cc:	53                   	push   %ebx
801063cd:	bb 80 00 00 00       	mov    $0x80,%ebx
801063d2:	83 ec 0c             	sub    $0xc,%esp
801063d5:	eb 1b                	jmp    801063f2 <uartputc.part.0+0x32>
801063d7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801063de:	66 90                	xchg   %ax,%ax
    microdelay(10);
801063e0:	83 ec 0c             	sub    $0xc,%esp
801063e3:	6a 0a                	push   $0xa
801063e5:	e8 36 cb ff ff       	call   80102f20 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
801063ea:	83 c4 10             	add    $0x10,%esp
801063ed:	83 eb 01             	sub    $0x1,%ebx
801063f0:	74 07                	je     801063f9 <uartputc.part.0+0x39>
801063f2:	89 f2                	mov    %esi,%edx
801063f4:	ec                   	in     (%dx),%al
801063f5:	a8 20                	test   $0x20,%al
801063f7:	74 e7                	je     801063e0 <uartputc.part.0+0x20>
  asm volatile("out %0,%1" : : "a"(data), "d"(port));
801063f9:	ba f8 03 00 00       	mov    $0x3f8,%edx
801063fe:	89 f8                	mov    %edi,%eax
80106400:	ee                   	out    %al,(%dx)
}
80106401:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106404:	5b                   	pop    %ebx
80106405:	5e                   	pop    %esi
80106406:	5f                   	pop    %edi
80106407:	5d                   	pop    %ebp
80106408:	c3                   	ret    
80106409:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106410 <uartinit>:
{
80106410:	f3 0f 1e fb          	endbr32 
80106414:	55                   	push   %ebp
80106415:	31 c9                	xor    %ecx,%ecx
80106417:	89 c8                	mov    %ecx,%eax
80106419:	89 e5                	mov    %esp,%ebp
8010641b:	57                   	push   %edi
8010641c:	56                   	push   %esi
8010641d:	53                   	push   %ebx
8010641e:	bb fa 03 00 00       	mov    $0x3fa,%ebx
80106423:	89 da                	mov    %ebx,%edx
80106425:	83 ec 0c             	sub    $0xc,%esp
80106428:	ee                   	out    %al,(%dx)
80106429:	bf fb 03 00 00       	mov    $0x3fb,%edi
8010642e:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
80106433:	89 fa                	mov    %edi,%edx
80106435:	ee                   	out    %al,(%dx)
80106436:	b8 0c 00 00 00       	mov    $0xc,%eax
8010643b:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106440:	ee                   	out    %al,(%dx)
80106441:	be f9 03 00 00       	mov    $0x3f9,%esi
80106446:	89 c8                	mov    %ecx,%eax
80106448:	89 f2                	mov    %esi,%edx
8010644a:	ee                   	out    %al,(%dx)
8010644b:	b8 03 00 00 00       	mov    $0x3,%eax
80106450:	89 fa                	mov    %edi,%edx
80106452:	ee                   	out    %al,(%dx)
80106453:	ba fc 03 00 00       	mov    $0x3fc,%edx
80106458:	89 c8                	mov    %ecx,%eax
8010645a:	ee                   	out    %al,(%dx)
8010645b:	b8 01 00 00 00       	mov    $0x1,%eax
80106460:	89 f2                	mov    %esi,%edx
80106462:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a"(data) : "d"(port));
80106463:	ba fd 03 00 00       	mov    $0x3fd,%edx
80106468:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
80106469:	3c ff                	cmp    $0xff,%al
8010646b:	74 52                	je     801064bf <uartinit+0xaf>
  uart = 1;
8010646d:	c7 05 3c c2 10 80 01 	movl   $0x1,0x8010c23c
80106474:	00 00 00 
80106477:	89 da                	mov    %ebx,%edx
80106479:	ec                   	in     (%dx),%al
8010647a:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010647f:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
80106480:	83 ec 08             	sub    $0x8,%esp
80106483:	be 76 00 00 00       	mov    $0x76,%esi
  for(p="xv6...\n"; *p; p++)
80106488:	bb 38 82 10 80       	mov    $0x80108238,%ebx
  ioapicenable(IRQ_COM1, 0);
8010648d:	6a 00                	push   $0x0
8010648f:	6a 04                	push   $0x4
80106491:	e8 da c5 ff ff       	call   80102a70 <ioapicenable>
80106496:	83 c4 10             	add    $0x10,%esp
  for(p="xv6...\n"; *p; p++)
80106499:	b8 78 00 00 00       	mov    $0x78,%eax
8010649e:	eb 04                	jmp    801064a4 <uartinit+0x94>
801064a0:	0f b6 73 01          	movzbl 0x1(%ebx),%esi
  if(!uart)
801064a4:	8b 15 3c c2 10 80    	mov    0x8010c23c,%edx
801064aa:	85 d2                	test   %edx,%edx
801064ac:	74 08                	je     801064b6 <uartinit+0xa6>
    uartputc(*p);
801064ae:	0f be c0             	movsbl %al,%eax
801064b1:	e8 0a ff ff ff       	call   801063c0 <uartputc.part.0>
  for(p="xv6...\n"; *p; p++)
801064b6:	89 f0                	mov    %esi,%eax
801064b8:	83 c3 01             	add    $0x1,%ebx
801064bb:	84 c0                	test   %al,%al
801064bd:	75 e1                	jne    801064a0 <uartinit+0x90>
}
801064bf:	8d 65 f4             	lea    -0xc(%ebp),%esp
801064c2:	5b                   	pop    %ebx
801064c3:	5e                   	pop    %esi
801064c4:	5f                   	pop    %edi
801064c5:	5d                   	pop    %ebp
801064c6:	c3                   	ret    
801064c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801064ce:	66 90                	xchg   %ax,%ax

801064d0 <uartputc>:
{
801064d0:	f3 0f 1e fb          	endbr32 
801064d4:	55                   	push   %ebp
  if(!uart)
801064d5:	8b 15 3c c2 10 80    	mov    0x8010c23c,%edx
{
801064db:	89 e5                	mov    %esp,%ebp
801064dd:	8b 45 08             	mov    0x8(%ebp),%eax
  if(!uart)
801064e0:	85 d2                	test   %edx,%edx
801064e2:	74 0c                	je     801064f0 <uartputc+0x20>
}
801064e4:	5d                   	pop    %ebp
801064e5:	e9 d6 fe ff ff       	jmp    801063c0 <uartputc.part.0>
801064ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801064f0:	5d                   	pop    %ebp
801064f1:	c3                   	ret    
801064f2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801064f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106500 <uartintr>:

void
uartintr(void)
{
80106500:	f3 0f 1e fb          	endbr32 
80106504:	55                   	push   %ebp
80106505:	89 e5                	mov    %esp,%ebp
80106507:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
8010650a:	68 90 63 10 80       	push   $0x80106390
8010650f:	e8 2c a8 ff ff       	call   80100d40 <consoleintr>
}
80106514:	83 c4 10             	add    $0x10,%esp
80106517:	c9                   	leave  
80106518:	c3                   	ret    

80106519 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80106519:	6a 00                	push   $0x0
  pushl $0
8010651b:	6a 00                	push   $0x0
  jmp alltraps
8010651d:	e9 4b fb ff ff       	jmp    8010606d <alltraps>

80106522 <vector1>:
.globl vector1
vector1:
  pushl $0
80106522:	6a 00                	push   $0x0
  pushl $1
80106524:	6a 01                	push   $0x1
  jmp alltraps
80106526:	e9 42 fb ff ff       	jmp    8010606d <alltraps>

8010652b <vector2>:
.globl vector2
vector2:
  pushl $0
8010652b:	6a 00                	push   $0x0
  pushl $2
8010652d:	6a 02                	push   $0x2
  jmp alltraps
8010652f:	e9 39 fb ff ff       	jmp    8010606d <alltraps>

80106534 <vector3>:
.globl vector3
vector3:
  pushl $0
80106534:	6a 00                	push   $0x0
  pushl $3
80106536:	6a 03                	push   $0x3
  jmp alltraps
80106538:	e9 30 fb ff ff       	jmp    8010606d <alltraps>

8010653d <vector4>:
.globl vector4
vector4:
  pushl $0
8010653d:	6a 00                	push   $0x0
  pushl $4
8010653f:	6a 04                	push   $0x4
  jmp alltraps
80106541:	e9 27 fb ff ff       	jmp    8010606d <alltraps>

80106546 <vector5>:
.globl vector5
vector5:
  pushl $0
80106546:	6a 00                	push   $0x0
  pushl $5
80106548:	6a 05                	push   $0x5
  jmp alltraps
8010654a:	e9 1e fb ff ff       	jmp    8010606d <alltraps>

8010654f <vector6>:
.globl vector6
vector6:
  pushl $0
8010654f:	6a 00                	push   $0x0
  pushl $6
80106551:	6a 06                	push   $0x6
  jmp alltraps
80106553:	e9 15 fb ff ff       	jmp    8010606d <alltraps>

80106558 <vector7>:
.globl vector7
vector7:
  pushl $0
80106558:	6a 00                	push   $0x0
  pushl $7
8010655a:	6a 07                	push   $0x7
  jmp alltraps
8010655c:	e9 0c fb ff ff       	jmp    8010606d <alltraps>

80106561 <vector8>:
.globl vector8
vector8:
  pushl $8
80106561:	6a 08                	push   $0x8
  jmp alltraps
80106563:	e9 05 fb ff ff       	jmp    8010606d <alltraps>

80106568 <vector9>:
.globl vector9
vector9:
  pushl $0
80106568:	6a 00                	push   $0x0
  pushl $9
8010656a:	6a 09                	push   $0x9
  jmp alltraps
8010656c:	e9 fc fa ff ff       	jmp    8010606d <alltraps>

80106571 <vector10>:
.globl vector10
vector10:
  pushl $10
80106571:	6a 0a                	push   $0xa
  jmp alltraps
80106573:	e9 f5 fa ff ff       	jmp    8010606d <alltraps>

80106578 <vector11>:
.globl vector11
vector11:
  pushl $11
80106578:	6a 0b                	push   $0xb
  jmp alltraps
8010657a:	e9 ee fa ff ff       	jmp    8010606d <alltraps>

8010657f <vector12>:
.globl vector12
vector12:
  pushl $12
8010657f:	6a 0c                	push   $0xc
  jmp alltraps
80106581:	e9 e7 fa ff ff       	jmp    8010606d <alltraps>

80106586 <vector13>:
.globl vector13
vector13:
  pushl $13
80106586:	6a 0d                	push   $0xd
  jmp alltraps
80106588:	e9 e0 fa ff ff       	jmp    8010606d <alltraps>

8010658d <vector14>:
.globl vector14
vector14:
  pushl $14
8010658d:	6a 0e                	push   $0xe
  jmp alltraps
8010658f:	e9 d9 fa ff ff       	jmp    8010606d <alltraps>

80106594 <vector15>:
.globl vector15
vector15:
  pushl $0
80106594:	6a 00                	push   $0x0
  pushl $15
80106596:	6a 0f                	push   $0xf
  jmp alltraps
80106598:	e9 d0 fa ff ff       	jmp    8010606d <alltraps>

8010659d <vector16>:
.globl vector16
vector16:
  pushl $0
8010659d:	6a 00                	push   $0x0
  pushl $16
8010659f:	6a 10                	push   $0x10
  jmp alltraps
801065a1:	e9 c7 fa ff ff       	jmp    8010606d <alltraps>

801065a6 <vector17>:
.globl vector17
vector17:
  pushl $17
801065a6:	6a 11                	push   $0x11
  jmp alltraps
801065a8:	e9 c0 fa ff ff       	jmp    8010606d <alltraps>

801065ad <vector18>:
.globl vector18
vector18:
  pushl $0
801065ad:	6a 00                	push   $0x0
  pushl $18
801065af:	6a 12                	push   $0x12
  jmp alltraps
801065b1:	e9 b7 fa ff ff       	jmp    8010606d <alltraps>

801065b6 <vector19>:
.globl vector19
vector19:
  pushl $0
801065b6:	6a 00                	push   $0x0
  pushl $19
801065b8:	6a 13                	push   $0x13
  jmp alltraps
801065ba:	e9 ae fa ff ff       	jmp    8010606d <alltraps>

801065bf <vector20>:
.globl vector20
vector20:
  pushl $0
801065bf:	6a 00                	push   $0x0
  pushl $20
801065c1:	6a 14                	push   $0x14
  jmp alltraps
801065c3:	e9 a5 fa ff ff       	jmp    8010606d <alltraps>

801065c8 <vector21>:
.globl vector21
vector21:
  pushl $0
801065c8:	6a 00                	push   $0x0
  pushl $21
801065ca:	6a 15                	push   $0x15
  jmp alltraps
801065cc:	e9 9c fa ff ff       	jmp    8010606d <alltraps>

801065d1 <vector22>:
.globl vector22
vector22:
  pushl $0
801065d1:	6a 00                	push   $0x0
  pushl $22
801065d3:	6a 16                	push   $0x16
  jmp alltraps
801065d5:	e9 93 fa ff ff       	jmp    8010606d <alltraps>

801065da <vector23>:
.globl vector23
vector23:
  pushl $0
801065da:	6a 00                	push   $0x0
  pushl $23
801065dc:	6a 17                	push   $0x17
  jmp alltraps
801065de:	e9 8a fa ff ff       	jmp    8010606d <alltraps>

801065e3 <vector24>:
.globl vector24
vector24:
  pushl $0
801065e3:	6a 00                	push   $0x0
  pushl $24
801065e5:	6a 18                	push   $0x18
  jmp alltraps
801065e7:	e9 81 fa ff ff       	jmp    8010606d <alltraps>

801065ec <vector25>:
.globl vector25
vector25:
  pushl $0
801065ec:	6a 00                	push   $0x0
  pushl $25
801065ee:	6a 19                	push   $0x19
  jmp alltraps
801065f0:	e9 78 fa ff ff       	jmp    8010606d <alltraps>

801065f5 <vector26>:
.globl vector26
vector26:
  pushl $0
801065f5:	6a 00                	push   $0x0
  pushl $26
801065f7:	6a 1a                	push   $0x1a
  jmp alltraps
801065f9:	e9 6f fa ff ff       	jmp    8010606d <alltraps>

801065fe <vector27>:
.globl vector27
vector27:
  pushl $0
801065fe:	6a 00                	push   $0x0
  pushl $27
80106600:	6a 1b                	push   $0x1b
  jmp alltraps
80106602:	e9 66 fa ff ff       	jmp    8010606d <alltraps>

80106607 <vector28>:
.globl vector28
vector28:
  pushl $0
80106607:	6a 00                	push   $0x0
  pushl $28
80106609:	6a 1c                	push   $0x1c
  jmp alltraps
8010660b:	e9 5d fa ff ff       	jmp    8010606d <alltraps>

80106610 <vector29>:
.globl vector29
vector29:
  pushl $0
80106610:	6a 00                	push   $0x0
  pushl $29
80106612:	6a 1d                	push   $0x1d
  jmp alltraps
80106614:	e9 54 fa ff ff       	jmp    8010606d <alltraps>

80106619 <vector30>:
.globl vector30
vector30:
  pushl $0
80106619:	6a 00                	push   $0x0
  pushl $30
8010661b:	6a 1e                	push   $0x1e
  jmp alltraps
8010661d:	e9 4b fa ff ff       	jmp    8010606d <alltraps>

80106622 <vector31>:
.globl vector31
vector31:
  pushl $0
80106622:	6a 00                	push   $0x0
  pushl $31
80106624:	6a 1f                	push   $0x1f
  jmp alltraps
80106626:	e9 42 fa ff ff       	jmp    8010606d <alltraps>

8010662b <vector32>:
.globl vector32
vector32:
  pushl $0
8010662b:	6a 00                	push   $0x0
  pushl $32
8010662d:	6a 20                	push   $0x20
  jmp alltraps
8010662f:	e9 39 fa ff ff       	jmp    8010606d <alltraps>

80106634 <vector33>:
.globl vector33
vector33:
  pushl $0
80106634:	6a 00                	push   $0x0
  pushl $33
80106636:	6a 21                	push   $0x21
  jmp alltraps
80106638:	e9 30 fa ff ff       	jmp    8010606d <alltraps>

8010663d <vector34>:
.globl vector34
vector34:
  pushl $0
8010663d:	6a 00                	push   $0x0
  pushl $34
8010663f:	6a 22                	push   $0x22
  jmp alltraps
80106641:	e9 27 fa ff ff       	jmp    8010606d <alltraps>

80106646 <vector35>:
.globl vector35
vector35:
  pushl $0
80106646:	6a 00                	push   $0x0
  pushl $35
80106648:	6a 23                	push   $0x23
  jmp alltraps
8010664a:	e9 1e fa ff ff       	jmp    8010606d <alltraps>

8010664f <vector36>:
.globl vector36
vector36:
  pushl $0
8010664f:	6a 00                	push   $0x0
  pushl $36
80106651:	6a 24                	push   $0x24
  jmp alltraps
80106653:	e9 15 fa ff ff       	jmp    8010606d <alltraps>

80106658 <vector37>:
.globl vector37
vector37:
  pushl $0
80106658:	6a 00                	push   $0x0
  pushl $37
8010665a:	6a 25                	push   $0x25
  jmp alltraps
8010665c:	e9 0c fa ff ff       	jmp    8010606d <alltraps>

80106661 <vector38>:
.globl vector38
vector38:
  pushl $0
80106661:	6a 00                	push   $0x0
  pushl $38
80106663:	6a 26                	push   $0x26
  jmp alltraps
80106665:	e9 03 fa ff ff       	jmp    8010606d <alltraps>

8010666a <vector39>:
.globl vector39
vector39:
  pushl $0
8010666a:	6a 00                	push   $0x0
  pushl $39
8010666c:	6a 27                	push   $0x27
  jmp alltraps
8010666e:	e9 fa f9 ff ff       	jmp    8010606d <alltraps>

80106673 <vector40>:
.globl vector40
vector40:
  pushl $0
80106673:	6a 00                	push   $0x0
  pushl $40
80106675:	6a 28                	push   $0x28
  jmp alltraps
80106677:	e9 f1 f9 ff ff       	jmp    8010606d <alltraps>

8010667c <vector41>:
.globl vector41
vector41:
  pushl $0
8010667c:	6a 00                	push   $0x0
  pushl $41
8010667e:	6a 29                	push   $0x29
  jmp alltraps
80106680:	e9 e8 f9 ff ff       	jmp    8010606d <alltraps>

80106685 <vector42>:
.globl vector42
vector42:
  pushl $0
80106685:	6a 00                	push   $0x0
  pushl $42
80106687:	6a 2a                	push   $0x2a
  jmp alltraps
80106689:	e9 df f9 ff ff       	jmp    8010606d <alltraps>

8010668e <vector43>:
.globl vector43
vector43:
  pushl $0
8010668e:	6a 00                	push   $0x0
  pushl $43
80106690:	6a 2b                	push   $0x2b
  jmp alltraps
80106692:	e9 d6 f9 ff ff       	jmp    8010606d <alltraps>

80106697 <vector44>:
.globl vector44
vector44:
  pushl $0
80106697:	6a 00                	push   $0x0
  pushl $44
80106699:	6a 2c                	push   $0x2c
  jmp alltraps
8010669b:	e9 cd f9 ff ff       	jmp    8010606d <alltraps>

801066a0 <vector45>:
.globl vector45
vector45:
  pushl $0
801066a0:	6a 00                	push   $0x0
  pushl $45
801066a2:	6a 2d                	push   $0x2d
  jmp alltraps
801066a4:	e9 c4 f9 ff ff       	jmp    8010606d <alltraps>

801066a9 <vector46>:
.globl vector46
vector46:
  pushl $0
801066a9:	6a 00                	push   $0x0
  pushl $46
801066ab:	6a 2e                	push   $0x2e
  jmp alltraps
801066ad:	e9 bb f9 ff ff       	jmp    8010606d <alltraps>

801066b2 <vector47>:
.globl vector47
vector47:
  pushl $0
801066b2:	6a 00                	push   $0x0
  pushl $47
801066b4:	6a 2f                	push   $0x2f
  jmp alltraps
801066b6:	e9 b2 f9 ff ff       	jmp    8010606d <alltraps>

801066bb <vector48>:
.globl vector48
vector48:
  pushl $0
801066bb:	6a 00                	push   $0x0
  pushl $48
801066bd:	6a 30                	push   $0x30
  jmp alltraps
801066bf:	e9 a9 f9 ff ff       	jmp    8010606d <alltraps>

801066c4 <vector49>:
.globl vector49
vector49:
  pushl $0
801066c4:	6a 00                	push   $0x0
  pushl $49
801066c6:	6a 31                	push   $0x31
  jmp alltraps
801066c8:	e9 a0 f9 ff ff       	jmp    8010606d <alltraps>

801066cd <vector50>:
.globl vector50
vector50:
  pushl $0
801066cd:	6a 00                	push   $0x0
  pushl $50
801066cf:	6a 32                	push   $0x32
  jmp alltraps
801066d1:	e9 97 f9 ff ff       	jmp    8010606d <alltraps>

801066d6 <vector51>:
.globl vector51
vector51:
  pushl $0
801066d6:	6a 00                	push   $0x0
  pushl $51
801066d8:	6a 33                	push   $0x33
  jmp alltraps
801066da:	e9 8e f9 ff ff       	jmp    8010606d <alltraps>

801066df <vector52>:
.globl vector52
vector52:
  pushl $0
801066df:	6a 00                	push   $0x0
  pushl $52
801066e1:	6a 34                	push   $0x34
  jmp alltraps
801066e3:	e9 85 f9 ff ff       	jmp    8010606d <alltraps>

801066e8 <vector53>:
.globl vector53
vector53:
  pushl $0
801066e8:	6a 00                	push   $0x0
  pushl $53
801066ea:	6a 35                	push   $0x35
  jmp alltraps
801066ec:	e9 7c f9 ff ff       	jmp    8010606d <alltraps>

801066f1 <vector54>:
.globl vector54
vector54:
  pushl $0
801066f1:	6a 00                	push   $0x0
  pushl $54
801066f3:	6a 36                	push   $0x36
  jmp alltraps
801066f5:	e9 73 f9 ff ff       	jmp    8010606d <alltraps>

801066fa <vector55>:
.globl vector55
vector55:
  pushl $0
801066fa:	6a 00                	push   $0x0
  pushl $55
801066fc:	6a 37                	push   $0x37
  jmp alltraps
801066fe:	e9 6a f9 ff ff       	jmp    8010606d <alltraps>

80106703 <vector56>:
.globl vector56
vector56:
  pushl $0
80106703:	6a 00                	push   $0x0
  pushl $56
80106705:	6a 38                	push   $0x38
  jmp alltraps
80106707:	e9 61 f9 ff ff       	jmp    8010606d <alltraps>

8010670c <vector57>:
.globl vector57
vector57:
  pushl $0
8010670c:	6a 00                	push   $0x0
  pushl $57
8010670e:	6a 39                	push   $0x39
  jmp alltraps
80106710:	e9 58 f9 ff ff       	jmp    8010606d <alltraps>

80106715 <vector58>:
.globl vector58
vector58:
  pushl $0
80106715:	6a 00                	push   $0x0
  pushl $58
80106717:	6a 3a                	push   $0x3a
  jmp alltraps
80106719:	e9 4f f9 ff ff       	jmp    8010606d <alltraps>

8010671e <vector59>:
.globl vector59
vector59:
  pushl $0
8010671e:	6a 00                	push   $0x0
  pushl $59
80106720:	6a 3b                	push   $0x3b
  jmp alltraps
80106722:	e9 46 f9 ff ff       	jmp    8010606d <alltraps>

80106727 <vector60>:
.globl vector60
vector60:
  pushl $0
80106727:	6a 00                	push   $0x0
  pushl $60
80106729:	6a 3c                	push   $0x3c
  jmp alltraps
8010672b:	e9 3d f9 ff ff       	jmp    8010606d <alltraps>

80106730 <vector61>:
.globl vector61
vector61:
  pushl $0
80106730:	6a 00                	push   $0x0
  pushl $61
80106732:	6a 3d                	push   $0x3d
  jmp alltraps
80106734:	e9 34 f9 ff ff       	jmp    8010606d <alltraps>

80106739 <vector62>:
.globl vector62
vector62:
  pushl $0
80106739:	6a 00                	push   $0x0
  pushl $62
8010673b:	6a 3e                	push   $0x3e
  jmp alltraps
8010673d:	e9 2b f9 ff ff       	jmp    8010606d <alltraps>

80106742 <vector63>:
.globl vector63
vector63:
  pushl $0
80106742:	6a 00                	push   $0x0
  pushl $63
80106744:	6a 3f                	push   $0x3f
  jmp alltraps
80106746:	e9 22 f9 ff ff       	jmp    8010606d <alltraps>

8010674b <vector64>:
.globl vector64
vector64:
  pushl $0
8010674b:	6a 00                	push   $0x0
  pushl $64
8010674d:	6a 40                	push   $0x40
  jmp alltraps
8010674f:	e9 19 f9 ff ff       	jmp    8010606d <alltraps>

80106754 <vector65>:
.globl vector65
vector65:
  pushl $0
80106754:	6a 00                	push   $0x0
  pushl $65
80106756:	6a 41                	push   $0x41
  jmp alltraps
80106758:	e9 10 f9 ff ff       	jmp    8010606d <alltraps>

8010675d <vector66>:
.globl vector66
vector66:
  pushl $0
8010675d:	6a 00                	push   $0x0
  pushl $66
8010675f:	6a 42                	push   $0x42
  jmp alltraps
80106761:	e9 07 f9 ff ff       	jmp    8010606d <alltraps>

80106766 <vector67>:
.globl vector67
vector67:
  pushl $0
80106766:	6a 00                	push   $0x0
  pushl $67
80106768:	6a 43                	push   $0x43
  jmp alltraps
8010676a:	e9 fe f8 ff ff       	jmp    8010606d <alltraps>

8010676f <vector68>:
.globl vector68
vector68:
  pushl $0
8010676f:	6a 00                	push   $0x0
  pushl $68
80106771:	6a 44                	push   $0x44
  jmp alltraps
80106773:	e9 f5 f8 ff ff       	jmp    8010606d <alltraps>

80106778 <vector69>:
.globl vector69
vector69:
  pushl $0
80106778:	6a 00                	push   $0x0
  pushl $69
8010677a:	6a 45                	push   $0x45
  jmp alltraps
8010677c:	e9 ec f8 ff ff       	jmp    8010606d <alltraps>

80106781 <vector70>:
.globl vector70
vector70:
  pushl $0
80106781:	6a 00                	push   $0x0
  pushl $70
80106783:	6a 46                	push   $0x46
  jmp alltraps
80106785:	e9 e3 f8 ff ff       	jmp    8010606d <alltraps>

8010678a <vector71>:
.globl vector71
vector71:
  pushl $0
8010678a:	6a 00                	push   $0x0
  pushl $71
8010678c:	6a 47                	push   $0x47
  jmp alltraps
8010678e:	e9 da f8 ff ff       	jmp    8010606d <alltraps>

80106793 <vector72>:
.globl vector72
vector72:
  pushl $0
80106793:	6a 00                	push   $0x0
  pushl $72
80106795:	6a 48                	push   $0x48
  jmp alltraps
80106797:	e9 d1 f8 ff ff       	jmp    8010606d <alltraps>

8010679c <vector73>:
.globl vector73
vector73:
  pushl $0
8010679c:	6a 00                	push   $0x0
  pushl $73
8010679e:	6a 49                	push   $0x49
  jmp alltraps
801067a0:	e9 c8 f8 ff ff       	jmp    8010606d <alltraps>

801067a5 <vector74>:
.globl vector74
vector74:
  pushl $0
801067a5:	6a 00                	push   $0x0
  pushl $74
801067a7:	6a 4a                	push   $0x4a
  jmp alltraps
801067a9:	e9 bf f8 ff ff       	jmp    8010606d <alltraps>

801067ae <vector75>:
.globl vector75
vector75:
  pushl $0
801067ae:	6a 00                	push   $0x0
  pushl $75
801067b0:	6a 4b                	push   $0x4b
  jmp alltraps
801067b2:	e9 b6 f8 ff ff       	jmp    8010606d <alltraps>

801067b7 <vector76>:
.globl vector76
vector76:
  pushl $0
801067b7:	6a 00                	push   $0x0
  pushl $76
801067b9:	6a 4c                	push   $0x4c
  jmp alltraps
801067bb:	e9 ad f8 ff ff       	jmp    8010606d <alltraps>

801067c0 <vector77>:
.globl vector77
vector77:
  pushl $0
801067c0:	6a 00                	push   $0x0
  pushl $77
801067c2:	6a 4d                	push   $0x4d
  jmp alltraps
801067c4:	e9 a4 f8 ff ff       	jmp    8010606d <alltraps>

801067c9 <vector78>:
.globl vector78
vector78:
  pushl $0
801067c9:	6a 00                	push   $0x0
  pushl $78
801067cb:	6a 4e                	push   $0x4e
  jmp alltraps
801067cd:	e9 9b f8 ff ff       	jmp    8010606d <alltraps>

801067d2 <vector79>:
.globl vector79
vector79:
  pushl $0
801067d2:	6a 00                	push   $0x0
  pushl $79
801067d4:	6a 4f                	push   $0x4f
  jmp alltraps
801067d6:	e9 92 f8 ff ff       	jmp    8010606d <alltraps>

801067db <vector80>:
.globl vector80
vector80:
  pushl $0
801067db:	6a 00                	push   $0x0
  pushl $80
801067dd:	6a 50                	push   $0x50
  jmp alltraps
801067df:	e9 89 f8 ff ff       	jmp    8010606d <alltraps>

801067e4 <vector81>:
.globl vector81
vector81:
  pushl $0
801067e4:	6a 00                	push   $0x0
  pushl $81
801067e6:	6a 51                	push   $0x51
  jmp alltraps
801067e8:	e9 80 f8 ff ff       	jmp    8010606d <alltraps>

801067ed <vector82>:
.globl vector82
vector82:
  pushl $0
801067ed:	6a 00                	push   $0x0
  pushl $82
801067ef:	6a 52                	push   $0x52
  jmp alltraps
801067f1:	e9 77 f8 ff ff       	jmp    8010606d <alltraps>

801067f6 <vector83>:
.globl vector83
vector83:
  pushl $0
801067f6:	6a 00                	push   $0x0
  pushl $83
801067f8:	6a 53                	push   $0x53
  jmp alltraps
801067fa:	e9 6e f8 ff ff       	jmp    8010606d <alltraps>

801067ff <vector84>:
.globl vector84
vector84:
  pushl $0
801067ff:	6a 00                	push   $0x0
  pushl $84
80106801:	6a 54                	push   $0x54
  jmp alltraps
80106803:	e9 65 f8 ff ff       	jmp    8010606d <alltraps>

80106808 <vector85>:
.globl vector85
vector85:
  pushl $0
80106808:	6a 00                	push   $0x0
  pushl $85
8010680a:	6a 55                	push   $0x55
  jmp alltraps
8010680c:	e9 5c f8 ff ff       	jmp    8010606d <alltraps>

80106811 <vector86>:
.globl vector86
vector86:
  pushl $0
80106811:	6a 00                	push   $0x0
  pushl $86
80106813:	6a 56                	push   $0x56
  jmp alltraps
80106815:	e9 53 f8 ff ff       	jmp    8010606d <alltraps>

8010681a <vector87>:
.globl vector87
vector87:
  pushl $0
8010681a:	6a 00                	push   $0x0
  pushl $87
8010681c:	6a 57                	push   $0x57
  jmp alltraps
8010681e:	e9 4a f8 ff ff       	jmp    8010606d <alltraps>

80106823 <vector88>:
.globl vector88
vector88:
  pushl $0
80106823:	6a 00                	push   $0x0
  pushl $88
80106825:	6a 58                	push   $0x58
  jmp alltraps
80106827:	e9 41 f8 ff ff       	jmp    8010606d <alltraps>

8010682c <vector89>:
.globl vector89
vector89:
  pushl $0
8010682c:	6a 00                	push   $0x0
  pushl $89
8010682e:	6a 59                	push   $0x59
  jmp alltraps
80106830:	e9 38 f8 ff ff       	jmp    8010606d <alltraps>

80106835 <vector90>:
.globl vector90
vector90:
  pushl $0
80106835:	6a 00                	push   $0x0
  pushl $90
80106837:	6a 5a                	push   $0x5a
  jmp alltraps
80106839:	e9 2f f8 ff ff       	jmp    8010606d <alltraps>

8010683e <vector91>:
.globl vector91
vector91:
  pushl $0
8010683e:	6a 00                	push   $0x0
  pushl $91
80106840:	6a 5b                	push   $0x5b
  jmp alltraps
80106842:	e9 26 f8 ff ff       	jmp    8010606d <alltraps>

80106847 <vector92>:
.globl vector92
vector92:
  pushl $0
80106847:	6a 00                	push   $0x0
  pushl $92
80106849:	6a 5c                	push   $0x5c
  jmp alltraps
8010684b:	e9 1d f8 ff ff       	jmp    8010606d <alltraps>

80106850 <vector93>:
.globl vector93
vector93:
  pushl $0
80106850:	6a 00                	push   $0x0
  pushl $93
80106852:	6a 5d                	push   $0x5d
  jmp alltraps
80106854:	e9 14 f8 ff ff       	jmp    8010606d <alltraps>

80106859 <vector94>:
.globl vector94
vector94:
  pushl $0
80106859:	6a 00                	push   $0x0
  pushl $94
8010685b:	6a 5e                	push   $0x5e
  jmp alltraps
8010685d:	e9 0b f8 ff ff       	jmp    8010606d <alltraps>

80106862 <vector95>:
.globl vector95
vector95:
  pushl $0
80106862:	6a 00                	push   $0x0
  pushl $95
80106864:	6a 5f                	push   $0x5f
  jmp alltraps
80106866:	e9 02 f8 ff ff       	jmp    8010606d <alltraps>

8010686b <vector96>:
.globl vector96
vector96:
  pushl $0
8010686b:	6a 00                	push   $0x0
  pushl $96
8010686d:	6a 60                	push   $0x60
  jmp alltraps
8010686f:	e9 f9 f7 ff ff       	jmp    8010606d <alltraps>

80106874 <vector97>:
.globl vector97
vector97:
  pushl $0
80106874:	6a 00                	push   $0x0
  pushl $97
80106876:	6a 61                	push   $0x61
  jmp alltraps
80106878:	e9 f0 f7 ff ff       	jmp    8010606d <alltraps>

8010687d <vector98>:
.globl vector98
vector98:
  pushl $0
8010687d:	6a 00                	push   $0x0
  pushl $98
8010687f:	6a 62                	push   $0x62
  jmp alltraps
80106881:	e9 e7 f7 ff ff       	jmp    8010606d <alltraps>

80106886 <vector99>:
.globl vector99
vector99:
  pushl $0
80106886:	6a 00                	push   $0x0
  pushl $99
80106888:	6a 63                	push   $0x63
  jmp alltraps
8010688a:	e9 de f7 ff ff       	jmp    8010606d <alltraps>

8010688f <vector100>:
.globl vector100
vector100:
  pushl $0
8010688f:	6a 00                	push   $0x0
  pushl $100
80106891:	6a 64                	push   $0x64
  jmp alltraps
80106893:	e9 d5 f7 ff ff       	jmp    8010606d <alltraps>

80106898 <vector101>:
.globl vector101
vector101:
  pushl $0
80106898:	6a 00                	push   $0x0
  pushl $101
8010689a:	6a 65                	push   $0x65
  jmp alltraps
8010689c:	e9 cc f7 ff ff       	jmp    8010606d <alltraps>

801068a1 <vector102>:
.globl vector102
vector102:
  pushl $0
801068a1:	6a 00                	push   $0x0
  pushl $102
801068a3:	6a 66                	push   $0x66
  jmp alltraps
801068a5:	e9 c3 f7 ff ff       	jmp    8010606d <alltraps>

801068aa <vector103>:
.globl vector103
vector103:
  pushl $0
801068aa:	6a 00                	push   $0x0
  pushl $103
801068ac:	6a 67                	push   $0x67
  jmp alltraps
801068ae:	e9 ba f7 ff ff       	jmp    8010606d <alltraps>

801068b3 <vector104>:
.globl vector104
vector104:
  pushl $0
801068b3:	6a 00                	push   $0x0
  pushl $104
801068b5:	6a 68                	push   $0x68
  jmp alltraps
801068b7:	e9 b1 f7 ff ff       	jmp    8010606d <alltraps>

801068bc <vector105>:
.globl vector105
vector105:
  pushl $0
801068bc:	6a 00                	push   $0x0
  pushl $105
801068be:	6a 69                	push   $0x69
  jmp alltraps
801068c0:	e9 a8 f7 ff ff       	jmp    8010606d <alltraps>

801068c5 <vector106>:
.globl vector106
vector106:
  pushl $0
801068c5:	6a 00                	push   $0x0
  pushl $106
801068c7:	6a 6a                	push   $0x6a
  jmp alltraps
801068c9:	e9 9f f7 ff ff       	jmp    8010606d <alltraps>

801068ce <vector107>:
.globl vector107
vector107:
  pushl $0
801068ce:	6a 00                	push   $0x0
  pushl $107
801068d0:	6a 6b                	push   $0x6b
  jmp alltraps
801068d2:	e9 96 f7 ff ff       	jmp    8010606d <alltraps>

801068d7 <vector108>:
.globl vector108
vector108:
  pushl $0
801068d7:	6a 00                	push   $0x0
  pushl $108
801068d9:	6a 6c                	push   $0x6c
  jmp alltraps
801068db:	e9 8d f7 ff ff       	jmp    8010606d <alltraps>

801068e0 <vector109>:
.globl vector109
vector109:
  pushl $0
801068e0:	6a 00                	push   $0x0
  pushl $109
801068e2:	6a 6d                	push   $0x6d
  jmp alltraps
801068e4:	e9 84 f7 ff ff       	jmp    8010606d <alltraps>

801068e9 <vector110>:
.globl vector110
vector110:
  pushl $0
801068e9:	6a 00                	push   $0x0
  pushl $110
801068eb:	6a 6e                	push   $0x6e
  jmp alltraps
801068ed:	e9 7b f7 ff ff       	jmp    8010606d <alltraps>

801068f2 <vector111>:
.globl vector111
vector111:
  pushl $0
801068f2:	6a 00                	push   $0x0
  pushl $111
801068f4:	6a 6f                	push   $0x6f
  jmp alltraps
801068f6:	e9 72 f7 ff ff       	jmp    8010606d <alltraps>

801068fb <vector112>:
.globl vector112
vector112:
  pushl $0
801068fb:	6a 00                	push   $0x0
  pushl $112
801068fd:	6a 70                	push   $0x70
  jmp alltraps
801068ff:	e9 69 f7 ff ff       	jmp    8010606d <alltraps>

80106904 <vector113>:
.globl vector113
vector113:
  pushl $0
80106904:	6a 00                	push   $0x0
  pushl $113
80106906:	6a 71                	push   $0x71
  jmp alltraps
80106908:	e9 60 f7 ff ff       	jmp    8010606d <alltraps>

8010690d <vector114>:
.globl vector114
vector114:
  pushl $0
8010690d:	6a 00                	push   $0x0
  pushl $114
8010690f:	6a 72                	push   $0x72
  jmp alltraps
80106911:	e9 57 f7 ff ff       	jmp    8010606d <alltraps>

80106916 <vector115>:
.globl vector115
vector115:
  pushl $0
80106916:	6a 00                	push   $0x0
  pushl $115
80106918:	6a 73                	push   $0x73
  jmp alltraps
8010691a:	e9 4e f7 ff ff       	jmp    8010606d <alltraps>

8010691f <vector116>:
.globl vector116
vector116:
  pushl $0
8010691f:	6a 00                	push   $0x0
  pushl $116
80106921:	6a 74                	push   $0x74
  jmp alltraps
80106923:	e9 45 f7 ff ff       	jmp    8010606d <alltraps>

80106928 <vector117>:
.globl vector117
vector117:
  pushl $0
80106928:	6a 00                	push   $0x0
  pushl $117
8010692a:	6a 75                	push   $0x75
  jmp alltraps
8010692c:	e9 3c f7 ff ff       	jmp    8010606d <alltraps>

80106931 <vector118>:
.globl vector118
vector118:
  pushl $0
80106931:	6a 00                	push   $0x0
  pushl $118
80106933:	6a 76                	push   $0x76
  jmp alltraps
80106935:	e9 33 f7 ff ff       	jmp    8010606d <alltraps>

8010693a <vector119>:
.globl vector119
vector119:
  pushl $0
8010693a:	6a 00                	push   $0x0
  pushl $119
8010693c:	6a 77                	push   $0x77
  jmp alltraps
8010693e:	e9 2a f7 ff ff       	jmp    8010606d <alltraps>

80106943 <vector120>:
.globl vector120
vector120:
  pushl $0
80106943:	6a 00                	push   $0x0
  pushl $120
80106945:	6a 78                	push   $0x78
  jmp alltraps
80106947:	e9 21 f7 ff ff       	jmp    8010606d <alltraps>

8010694c <vector121>:
.globl vector121
vector121:
  pushl $0
8010694c:	6a 00                	push   $0x0
  pushl $121
8010694e:	6a 79                	push   $0x79
  jmp alltraps
80106950:	e9 18 f7 ff ff       	jmp    8010606d <alltraps>

80106955 <vector122>:
.globl vector122
vector122:
  pushl $0
80106955:	6a 00                	push   $0x0
  pushl $122
80106957:	6a 7a                	push   $0x7a
  jmp alltraps
80106959:	e9 0f f7 ff ff       	jmp    8010606d <alltraps>

8010695e <vector123>:
.globl vector123
vector123:
  pushl $0
8010695e:	6a 00                	push   $0x0
  pushl $123
80106960:	6a 7b                	push   $0x7b
  jmp alltraps
80106962:	e9 06 f7 ff ff       	jmp    8010606d <alltraps>

80106967 <vector124>:
.globl vector124
vector124:
  pushl $0
80106967:	6a 00                	push   $0x0
  pushl $124
80106969:	6a 7c                	push   $0x7c
  jmp alltraps
8010696b:	e9 fd f6 ff ff       	jmp    8010606d <alltraps>

80106970 <vector125>:
.globl vector125
vector125:
  pushl $0
80106970:	6a 00                	push   $0x0
  pushl $125
80106972:	6a 7d                	push   $0x7d
  jmp alltraps
80106974:	e9 f4 f6 ff ff       	jmp    8010606d <alltraps>

80106979 <vector126>:
.globl vector126
vector126:
  pushl $0
80106979:	6a 00                	push   $0x0
  pushl $126
8010697b:	6a 7e                	push   $0x7e
  jmp alltraps
8010697d:	e9 eb f6 ff ff       	jmp    8010606d <alltraps>

80106982 <vector127>:
.globl vector127
vector127:
  pushl $0
80106982:	6a 00                	push   $0x0
  pushl $127
80106984:	6a 7f                	push   $0x7f
  jmp alltraps
80106986:	e9 e2 f6 ff ff       	jmp    8010606d <alltraps>

8010698b <vector128>:
.globl vector128
vector128:
  pushl $0
8010698b:	6a 00                	push   $0x0
  pushl $128
8010698d:	68 80 00 00 00       	push   $0x80
  jmp alltraps
80106992:	e9 d6 f6 ff ff       	jmp    8010606d <alltraps>

80106997 <vector129>:
.globl vector129
vector129:
  pushl $0
80106997:	6a 00                	push   $0x0
  pushl $129
80106999:	68 81 00 00 00       	push   $0x81
  jmp alltraps
8010699e:	e9 ca f6 ff ff       	jmp    8010606d <alltraps>

801069a3 <vector130>:
.globl vector130
vector130:
  pushl $0
801069a3:	6a 00                	push   $0x0
  pushl $130
801069a5:	68 82 00 00 00       	push   $0x82
  jmp alltraps
801069aa:	e9 be f6 ff ff       	jmp    8010606d <alltraps>

801069af <vector131>:
.globl vector131
vector131:
  pushl $0
801069af:	6a 00                	push   $0x0
  pushl $131
801069b1:	68 83 00 00 00       	push   $0x83
  jmp alltraps
801069b6:	e9 b2 f6 ff ff       	jmp    8010606d <alltraps>

801069bb <vector132>:
.globl vector132
vector132:
  pushl $0
801069bb:	6a 00                	push   $0x0
  pushl $132
801069bd:	68 84 00 00 00       	push   $0x84
  jmp alltraps
801069c2:	e9 a6 f6 ff ff       	jmp    8010606d <alltraps>

801069c7 <vector133>:
.globl vector133
vector133:
  pushl $0
801069c7:	6a 00                	push   $0x0
  pushl $133
801069c9:	68 85 00 00 00       	push   $0x85
  jmp alltraps
801069ce:	e9 9a f6 ff ff       	jmp    8010606d <alltraps>

801069d3 <vector134>:
.globl vector134
vector134:
  pushl $0
801069d3:	6a 00                	push   $0x0
  pushl $134
801069d5:	68 86 00 00 00       	push   $0x86
  jmp alltraps
801069da:	e9 8e f6 ff ff       	jmp    8010606d <alltraps>

801069df <vector135>:
.globl vector135
vector135:
  pushl $0
801069df:	6a 00                	push   $0x0
  pushl $135
801069e1:	68 87 00 00 00       	push   $0x87
  jmp alltraps
801069e6:	e9 82 f6 ff ff       	jmp    8010606d <alltraps>

801069eb <vector136>:
.globl vector136
vector136:
  pushl $0
801069eb:	6a 00                	push   $0x0
  pushl $136
801069ed:	68 88 00 00 00       	push   $0x88
  jmp alltraps
801069f2:	e9 76 f6 ff ff       	jmp    8010606d <alltraps>

801069f7 <vector137>:
.globl vector137
vector137:
  pushl $0
801069f7:	6a 00                	push   $0x0
  pushl $137
801069f9:	68 89 00 00 00       	push   $0x89
  jmp alltraps
801069fe:	e9 6a f6 ff ff       	jmp    8010606d <alltraps>

80106a03 <vector138>:
.globl vector138
vector138:
  pushl $0
80106a03:	6a 00                	push   $0x0
  pushl $138
80106a05:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
80106a0a:	e9 5e f6 ff ff       	jmp    8010606d <alltraps>

80106a0f <vector139>:
.globl vector139
vector139:
  pushl $0
80106a0f:	6a 00                	push   $0x0
  pushl $139
80106a11:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
80106a16:	e9 52 f6 ff ff       	jmp    8010606d <alltraps>

80106a1b <vector140>:
.globl vector140
vector140:
  pushl $0
80106a1b:	6a 00                	push   $0x0
  pushl $140
80106a1d:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
80106a22:	e9 46 f6 ff ff       	jmp    8010606d <alltraps>

80106a27 <vector141>:
.globl vector141
vector141:
  pushl $0
80106a27:	6a 00                	push   $0x0
  pushl $141
80106a29:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
80106a2e:	e9 3a f6 ff ff       	jmp    8010606d <alltraps>

80106a33 <vector142>:
.globl vector142
vector142:
  pushl $0
80106a33:	6a 00                	push   $0x0
  pushl $142
80106a35:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
80106a3a:	e9 2e f6 ff ff       	jmp    8010606d <alltraps>

80106a3f <vector143>:
.globl vector143
vector143:
  pushl $0
80106a3f:	6a 00                	push   $0x0
  pushl $143
80106a41:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
80106a46:	e9 22 f6 ff ff       	jmp    8010606d <alltraps>

80106a4b <vector144>:
.globl vector144
vector144:
  pushl $0
80106a4b:	6a 00                	push   $0x0
  pushl $144
80106a4d:	68 90 00 00 00       	push   $0x90
  jmp alltraps
80106a52:	e9 16 f6 ff ff       	jmp    8010606d <alltraps>

80106a57 <vector145>:
.globl vector145
vector145:
  pushl $0
80106a57:	6a 00                	push   $0x0
  pushl $145
80106a59:	68 91 00 00 00       	push   $0x91
  jmp alltraps
80106a5e:	e9 0a f6 ff ff       	jmp    8010606d <alltraps>

80106a63 <vector146>:
.globl vector146
vector146:
  pushl $0
80106a63:	6a 00                	push   $0x0
  pushl $146
80106a65:	68 92 00 00 00       	push   $0x92
  jmp alltraps
80106a6a:	e9 fe f5 ff ff       	jmp    8010606d <alltraps>

80106a6f <vector147>:
.globl vector147
vector147:
  pushl $0
80106a6f:	6a 00                	push   $0x0
  pushl $147
80106a71:	68 93 00 00 00       	push   $0x93
  jmp alltraps
80106a76:	e9 f2 f5 ff ff       	jmp    8010606d <alltraps>

80106a7b <vector148>:
.globl vector148
vector148:
  pushl $0
80106a7b:	6a 00                	push   $0x0
  pushl $148
80106a7d:	68 94 00 00 00       	push   $0x94
  jmp alltraps
80106a82:	e9 e6 f5 ff ff       	jmp    8010606d <alltraps>

80106a87 <vector149>:
.globl vector149
vector149:
  pushl $0
80106a87:	6a 00                	push   $0x0
  pushl $149
80106a89:	68 95 00 00 00       	push   $0x95
  jmp alltraps
80106a8e:	e9 da f5 ff ff       	jmp    8010606d <alltraps>

80106a93 <vector150>:
.globl vector150
vector150:
  pushl $0
80106a93:	6a 00                	push   $0x0
  pushl $150
80106a95:	68 96 00 00 00       	push   $0x96
  jmp alltraps
80106a9a:	e9 ce f5 ff ff       	jmp    8010606d <alltraps>

80106a9f <vector151>:
.globl vector151
vector151:
  pushl $0
80106a9f:	6a 00                	push   $0x0
  pushl $151
80106aa1:	68 97 00 00 00       	push   $0x97
  jmp alltraps
80106aa6:	e9 c2 f5 ff ff       	jmp    8010606d <alltraps>

80106aab <vector152>:
.globl vector152
vector152:
  pushl $0
80106aab:	6a 00                	push   $0x0
  pushl $152
80106aad:	68 98 00 00 00       	push   $0x98
  jmp alltraps
80106ab2:	e9 b6 f5 ff ff       	jmp    8010606d <alltraps>

80106ab7 <vector153>:
.globl vector153
vector153:
  pushl $0
80106ab7:	6a 00                	push   $0x0
  pushl $153
80106ab9:	68 99 00 00 00       	push   $0x99
  jmp alltraps
80106abe:	e9 aa f5 ff ff       	jmp    8010606d <alltraps>

80106ac3 <vector154>:
.globl vector154
vector154:
  pushl $0
80106ac3:	6a 00                	push   $0x0
  pushl $154
80106ac5:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
80106aca:	e9 9e f5 ff ff       	jmp    8010606d <alltraps>

80106acf <vector155>:
.globl vector155
vector155:
  pushl $0
80106acf:	6a 00                	push   $0x0
  pushl $155
80106ad1:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
80106ad6:	e9 92 f5 ff ff       	jmp    8010606d <alltraps>

80106adb <vector156>:
.globl vector156
vector156:
  pushl $0
80106adb:	6a 00                	push   $0x0
  pushl $156
80106add:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
80106ae2:	e9 86 f5 ff ff       	jmp    8010606d <alltraps>

80106ae7 <vector157>:
.globl vector157
vector157:
  pushl $0
80106ae7:	6a 00                	push   $0x0
  pushl $157
80106ae9:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
80106aee:	e9 7a f5 ff ff       	jmp    8010606d <alltraps>

80106af3 <vector158>:
.globl vector158
vector158:
  pushl $0
80106af3:	6a 00                	push   $0x0
  pushl $158
80106af5:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
80106afa:	e9 6e f5 ff ff       	jmp    8010606d <alltraps>

80106aff <vector159>:
.globl vector159
vector159:
  pushl $0
80106aff:	6a 00                	push   $0x0
  pushl $159
80106b01:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
80106b06:	e9 62 f5 ff ff       	jmp    8010606d <alltraps>

80106b0b <vector160>:
.globl vector160
vector160:
  pushl $0
80106b0b:	6a 00                	push   $0x0
  pushl $160
80106b0d:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
80106b12:	e9 56 f5 ff ff       	jmp    8010606d <alltraps>

80106b17 <vector161>:
.globl vector161
vector161:
  pushl $0
80106b17:	6a 00                	push   $0x0
  pushl $161
80106b19:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
80106b1e:	e9 4a f5 ff ff       	jmp    8010606d <alltraps>

80106b23 <vector162>:
.globl vector162
vector162:
  pushl $0
80106b23:	6a 00                	push   $0x0
  pushl $162
80106b25:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
80106b2a:	e9 3e f5 ff ff       	jmp    8010606d <alltraps>

80106b2f <vector163>:
.globl vector163
vector163:
  pushl $0
80106b2f:	6a 00                	push   $0x0
  pushl $163
80106b31:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
80106b36:	e9 32 f5 ff ff       	jmp    8010606d <alltraps>

80106b3b <vector164>:
.globl vector164
vector164:
  pushl $0
80106b3b:	6a 00                	push   $0x0
  pushl $164
80106b3d:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
80106b42:	e9 26 f5 ff ff       	jmp    8010606d <alltraps>

80106b47 <vector165>:
.globl vector165
vector165:
  pushl $0
80106b47:	6a 00                	push   $0x0
  pushl $165
80106b49:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
80106b4e:	e9 1a f5 ff ff       	jmp    8010606d <alltraps>

80106b53 <vector166>:
.globl vector166
vector166:
  pushl $0
80106b53:	6a 00                	push   $0x0
  pushl $166
80106b55:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
80106b5a:	e9 0e f5 ff ff       	jmp    8010606d <alltraps>

80106b5f <vector167>:
.globl vector167
vector167:
  pushl $0
80106b5f:	6a 00                	push   $0x0
  pushl $167
80106b61:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
80106b66:	e9 02 f5 ff ff       	jmp    8010606d <alltraps>

80106b6b <vector168>:
.globl vector168
vector168:
  pushl $0
80106b6b:	6a 00                	push   $0x0
  pushl $168
80106b6d:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
80106b72:	e9 f6 f4 ff ff       	jmp    8010606d <alltraps>

80106b77 <vector169>:
.globl vector169
vector169:
  pushl $0
80106b77:	6a 00                	push   $0x0
  pushl $169
80106b79:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
80106b7e:	e9 ea f4 ff ff       	jmp    8010606d <alltraps>

80106b83 <vector170>:
.globl vector170
vector170:
  pushl $0
80106b83:	6a 00                	push   $0x0
  pushl $170
80106b85:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
80106b8a:	e9 de f4 ff ff       	jmp    8010606d <alltraps>

80106b8f <vector171>:
.globl vector171
vector171:
  pushl $0
80106b8f:	6a 00                	push   $0x0
  pushl $171
80106b91:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
80106b96:	e9 d2 f4 ff ff       	jmp    8010606d <alltraps>

80106b9b <vector172>:
.globl vector172
vector172:
  pushl $0
80106b9b:	6a 00                	push   $0x0
  pushl $172
80106b9d:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
80106ba2:	e9 c6 f4 ff ff       	jmp    8010606d <alltraps>

80106ba7 <vector173>:
.globl vector173
vector173:
  pushl $0
80106ba7:	6a 00                	push   $0x0
  pushl $173
80106ba9:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
80106bae:	e9 ba f4 ff ff       	jmp    8010606d <alltraps>

80106bb3 <vector174>:
.globl vector174
vector174:
  pushl $0
80106bb3:	6a 00                	push   $0x0
  pushl $174
80106bb5:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
80106bba:	e9 ae f4 ff ff       	jmp    8010606d <alltraps>

80106bbf <vector175>:
.globl vector175
vector175:
  pushl $0
80106bbf:	6a 00                	push   $0x0
  pushl $175
80106bc1:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
80106bc6:	e9 a2 f4 ff ff       	jmp    8010606d <alltraps>

80106bcb <vector176>:
.globl vector176
vector176:
  pushl $0
80106bcb:	6a 00                	push   $0x0
  pushl $176
80106bcd:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
80106bd2:	e9 96 f4 ff ff       	jmp    8010606d <alltraps>

80106bd7 <vector177>:
.globl vector177
vector177:
  pushl $0
80106bd7:	6a 00                	push   $0x0
  pushl $177
80106bd9:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
80106bde:	e9 8a f4 ff ff       	jmp    8010606d <alltraps>

80106be3 <vector178>:
.globl vector178
vector178:
  pushl $0
80106be3:	6a 00                	push   $0x0
  pushl $178
80106be5:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
80106bea:	e9 7e f4 ff ff       	jmp    8010606d <alltraps>

80106bef <vector179>:
.globl vector179
vector179:
  pushl $0
80106bef:	6a 00                	push   $0x0
  pushl $179
80106bf1:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
80106bf6:	e9 72 f4 ff ff       	jmp    8010606d <alltraps>

80106bfb <vector180>:
.globl vector180
vector180:
  pushl $0
80106bfb:	6a 00                	push   $0x0
  pushl $180
80106bfd:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
80106c02:	e9 66 f4 ff ff       	jmp    8010606d <alltraps>

80106c07 <vector181>:
.globl vector181
vector181:
  pushl $0
80106c07:	6a 00                	push   $0x0
  pushl $181
80106c09:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
80106c0e:	e9 5a f4 ff ff       	jmp    8010606d <alltraps>

80106c13 <vector182>:
.globl vector182
vector182:
  pushl $0
80106c13:	6a 00                	push   $0x0
  pushl $182
80106c15:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
80106c1a:	e9 4e f4 ff ff       	jmp    8010606d <alltraps>

80106c1f <vector183>:
.globl vector183
vector183:
  pushl $0
80106c1f:	6a 00                	push   $0x0
  pushl $183
80106c21:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
80106c26:	e9 42 f4 ff ff       	jmp    8010606d <alltraps>

80106c2b <vector184>:
.globl vector184
vector184:
  pushl $0
80106c2b:	6a 00                	push   $0x0
  pushl $184
80106c2d:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
80106c32:	e9 36 f4 ff ff       	jmp    8010606d <alltraps>

80106c37 <vector185>:
.globl vector185
vector185:
  pushl $0
80106c37:	6a 00                	push   $0x0
  pushl $185
80106c39:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
80106c3e:	e9 2a f4 ff ff       	jmp    8010606d <alltraps>

80106c43 <vector186>:
.globl vector186
vector186:
  pushl $0
80106c43:	6a 00                	push   $0x0
  pushl $186
80106c45:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
80106c4a:	e9 1e f4 ff ff       	jmp    8010606d <alltraps>

80106c4f <vector187>:
.globl vector187
vector187:
  pushl $0
80106c4f:	6a 00                	push   $0x0
  pushl $187
80106c51:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
80106c56:	e9 12 f4 ff ff       	jmp    8010606d <alltraps>

80106c5b <vector188>:
.globl vector188
vector188:
  pushl $0
80106c5b:	6a 00                	push   $0x0
  pushl $188
80106c5d:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
80106c62:	e9 06 f4 ff ff       	jmp    8010606d <alltraps>

80106c67 <vector189>:
.globl vector189
vector189:
  pushl $0
80106c67:	6a 00                	push   $0x0
  pushl $189
80106c69:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
80106c6e:	e9 fa f3 ff ff       	jmp    8010606d <alltraps>

80106c73 <vector190>:
.globl vector190
vector190:
  pushl $0
80106c73:	6a 00                	push   $0x0
  pushl $190
80106c75:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
80106c7a:	e9 ee f3 ff ff       	jmp    8010606d <alltraps>

80106c7f <vector191>:
.globl vector191
vector191:
  pushl $0
80106c7f:	6a 00                	push   $0x0
  pushl $191
80106c81:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
80106c86:	e9 e2 f3 ff ff       	jmp    8010606d <alltraps>

80106c8b <vector192>:
.globl vector192
vector192:
  pushl $0
80106c8b:	6a 00                	push   $0x0
  pushl $192
80106c8d:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
80106c92:	e9 d6 f3 ff ff       	jmp    8010606d <alltraps>

80106c97 <vector193>:
.globl vector193
vector193:
  pushl $0
80106c97:	6a 00                	push   $0x0
  pushl $193
80106c99:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
80106c9e:	e9 ca f3 ff ff       	jmp    8010606d <alltraps>

80106ca3 <vector194>:
.globl vector194
vector194:
  pushl $0
80106ca3:	6a 00                	push   $0x0
  pushl $194
80106ca5:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
80106caa:	e9 be f3 ff ff       	jmp    8010606d <alltraps>

80106caf <vector195>:
.globl vector195
vector195:
  pushl $0
80106caf:	6a 00                	push   $0x0
  pushl $195
80106cb1:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
80106cb6:	e9 b2 f3 ff ff       	jmp    8010606d <alltraps>

80106cbb <vector196>:
.globl vector196
vector196:
  pushl $0
80106cbb:	6a 00                	push   $0x0
  pushl $196
80106cbd:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
80106cc2:	e9 a6 f3 ff ff       	jmp    8010606d <alltraps>

80106cc7 <vector197>:
.globl vector197
vector197:
  pushl $0
80106cc7:	6a 00                	push   $0x0
  pushl $197
80106cc9:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
80106cce:	e9 9a f3 ff ff       	jmp    8010606d <alltraps>

80106cd3 <vector198>:
.globl vector198
vector198:
  pushl $0
80106cd3:	6a 00                	push   $0x0
  pushl $198
80106cd5:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
80106cda:	e9 8e f3 ff ff       	jmp    8010606d <alltraps>

80106cdf <vector199>:
.globl vector199
vector199:
  pushl $0
80106cdf:	6a 00                	push   $0x0
  pushl $199
80106ce1:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
80106ce6:	e9 82 f3 ff ff       	jmp    8010606d <alltraps>

80106ceb <vector200>:
.globl vector200
vector200:
  pushl $0
80106ceb:	6a 00                	push   $0x0
  pushl $200
80106ced:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
80106cf2:	e9 76 f3 ff ff       	jmp    8010606d <alltraps>

80106cf7 <vector201>:
.globl vector201
vector201:
  pushl $0
80106cf7:	6a 00                	push   $0x0
  pushl $201
80106cf9:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
80106cfe:	e9 6a f3 ff ff       	jmp    8010606d <alltraps>

80106d03 <vector202>:
.globl vector202
vector202:
  pushl $0
80106d03:	6a 00                	push   $0x0
  pushl $202
80106d05:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
80106d0a:	e9 5e f3 ff ff       	jmp    8010606d <alltraps>

80106d0f <vector203>:
.globl vector203
vector203:
  pushl $0
80106d0f:	6a 00                	push   $0x0
  pushl $203
80106d11:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
80106d16:	e9 52 f3 ff ff       	jmp    8010606d <alltraps>

80106d1b <vector204>:
.globl vector204
vector204:
  pushl $0
80106d1b:	6a 00                	push   $0x0
  pushl $204
80106d1d:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
80106d22:	e9 46 f3 ff ff       	jmp    8010606d <alltraps>

80106d27 <vector205>:
.globl vector205
vector205:
  pushl $0
80106d27:	6a 00                	push   $0x0
  pushl $205
80106d29:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
80106d2e:	e9 3a f3 ff ff       	jmp    8010606d <alltraps>

80106d33 <vector206>:
.globl vector206
vector206:
  pushl $0
80106d33:	6a 00                	push   $0x0
  pushl $206
80106d35:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
80106d3a:	e9 2e f3 ff ff       	jmp    8010606d <alltraps>

80106d3f <vector207>:
.globl vector207
vector207:
  pushl $0
80106d3f:	6a 00                	push   $0x0
  pushl $207
80106d41:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
80106d46:	e9 22 f3 ff ff       	jmp    8010606d <alltraps>

80106d4b <vector208>:
.globl vector208
vector208:
  pushl $0
80106d4b:	6a 00                	push   $0x0
  pushl $208
80106d4d:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
80106d52:	e9 16 f3 ff ff       	jmp    8010606d <alltraps>

80106d57 <vector209>:
.globl vector209
vector209:
  pushl $0
80106d57:	6a 00                	push   $0x0
  pushl $209
80106d59:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
80106d5e:	e9 0a f3 ff ff       	jmp    8010606d <alltraps>

80106d63 <vector210>:
.globl vector210
vector210:
  pushl $0
80106d63:	6a 00                	push   $0x0
  pushl $210
80106d65:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80106d6a:	e9 fe f2 ff ff       	jmp    8010606d <alltraps>

80106d6f <vector211>:
.globl vector211
vector211:
  pushl $0
80106d6f:	6a 00                	push   $0x0
  pushl $211
80106d71:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80106d76:	e9 f2 f2 ff ff       	jmp    8010606d <alltraps>

80106d7b <vector212>:
.globl vector212
vector212:
  pushl $0
80106d7b:	6a 00                	push   $0x0
  pushl $212
80106d7d:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
80106d82:	e9 e6 f2 ff ff       	jmp    8010606d <alltraps>

80106d87 <vector213>:
.globl vector213
vector213:
  pushl $0
80106d87:	6a 00                	push   $0x0
  pushl $213
80106d89:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
80106d8e:	e9 da f2 ff ff       	jmp    8010606d <alltraps>

80106d93 <vector214>:
.globl vector214
vector214:
  pushl $0
80106d93:	6a 00                	push   $0x0
  pushl $214
80106d95:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80106d9a:	e9 ce f2 ff ff       	jmp    8010606d <alltraps>

80106d9f <vector215>:
.globl vector215
vector215:
  pushl $0
80106d9f:	6a 00                	push   $0x0
  pushl $215
80106da1:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80106da6:	e9 c2 f2 ff ff       	jmp    8010606d <alltraps>

80106dab <vector216>:
.globl vector216
vector216:
  pushl $0
80106dab:	6a 00                	push   $0x0
  pushl $216
80106dad:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
80106db2:	e9 b6 f2 ff ff       	jmp    8010606d <alltraps>

80106db7 <vector217>:
.globl vector217
vector217:
  pushl $0
80106db7:	6a 00                	push   $0x0
  pushl $217
80106db9:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
80106dbe:	e9 aa f2 ff ff       	jmp    8010606d <alltraps>

80106dc3 <vector218>:
.globl vector218
vector218:
  pushl $0
80106dc3:	6a 00                	push   $0x0
  pushl $218
80106dc5:	68 da 00 00 00       	push   $0xda
  jmp alltraps
80106dca:	e9 9e f2 ff ff       	jmp    8010606d <alltraps>

80106dcf <vector219>:
.globl vector219
vector219:
  pushl $0
80106dcf:	6a 00                	push   $0x0
  pushl $219
80106dd1:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
80106dd6:	e9 92 f2 ff ff       	jmp    8010606d <alltraps>

80106ddb <vector220>:
.globl vector220
vector220:
  pushl $0
80106ddb:	6a 00                	push   $0x0
  pushl $220
80106ddd:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
80106de2:	e9 86 f2 ff ff       	jmp    8010606d <alltraps>

80106de7 <vector221>:
.globl vector221
vector221:
  pushl $0
80106de7:	6a 00                	push   $0x0
  pushl $221
80106de9:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
80106dee:	e9 7a f2 ff ff       	jmp    8010606d <alltraps>

80106df3 <vector222>:
.globl vector222
vector222:
  pushl $0
80106df3:	6a 00                	push   $0x0
  pushl $222
80106df5:	68 de 00 00 00       	push   $0xde
  jmp alltraps
80106dfa:	e9 6e f2 ff ff       	jmp    8010606d <alltraps>

80106dff <vector223>:
.globl vector223
vector223:
  pushl $0
80106dff:	6a 00                	push   $0x0
  pushl $223
80106e01:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
80106e06:	e9 62 f2 ff ff       	jmp    8010606d <alltraps>

80106e0b <vector224>:
.globl vector224
vector224:
  pushl $0
80106e0b:	6a 00                	push   $0x0
  pushl $224
80106e0d:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
80106e12:	e9 56 f2 ff ff       	jmp    8010606d <alltraps>

80106e17 <vector225>:
.globl vector225
vector225:
  pushl $0
80106e17:	6a 00                	push   $0x0
  pushl $225
80106e19:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
80106e1e:	e9 4a f2 ff ff       	jmp    8010606d <alltraps>

80106e23 <vector226>:
.globl vector226
vector226:
  pushl $0
80106e23:	6a 00                	push   $0x0
  pushl $226
80106e25:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
80106e2a:	e9 3e f2 ff ff       	jmp    8010606d <alltraps>

80106e2f <vector227>:
.globl vector227
vector227:
  pushl $0
80106e2f:	6a 00                	push   $0x0
  pushl $227
80106e31:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
80106e36:	e9 32 f2 ff ff       	jmp    8010606d <alltraps>

80106e3b <vector228>:
.globl vector228
vector228:
  pushl $0
80106e3b:	6a 00                	push   $0x0
  pushl $228
80106e3d:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
80106e42:	e9 26 f2 ff ff       	jmp    8010606d <alltraps>

80106e47 <vector229>:
.globl vector229
vector229:
  pushl $0
80106e47:	6a 00                	push   $0x0
  pushl $229
80106e49:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
80106e4e:	e9 1a f2 ff ff       	jmp    8010606d <alltraps>

80106e53 <vector230>:
.globl vector230
vector230:
  pushl $0
80106e53:	6a 00                	push   $0x0
  pushl $230
80106e55:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80106e5a:	e9 0e f2 ff ff       	jmp    8010606d <alltraps>

80106e5f <vector231>:
.globl vector231
vector231:
  pushl $0
80106e5f:	6a 00                	push   $0x0
  pushl $231
80106e61:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80106e66:	e9 02 f2 ff ff       	jmp    8010606d <alltraps>

80106e6b <vector232>:
.globl vector232
vector232:
  pushl $0
80106e6b:	6a 00                	push   $0x0
  pushl $232
80106e6d:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
80106e72:	e9 f6 f1 ff ff       	jmp    8010606d <alltraps>

80106e77 <vector233>:
.globl vector233
vector233:
  pushl $0
80106e77:	6a 00                	push   $0x0
  pushl $233
80106e79:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
80106e7e:	e9 ea f1 ff ff       	jmp    8010606d <alltraps>

80106e83 <vector234>:
.globl vector234
vector234:
  pushl $0
80106e83:	6a 00                	push   $0x0
  pushl $234
80106e85:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80106e8a:	e9 de f1 ff ff       	jmp    8010606d <alltraps>

80106e8f <vector235>:
.globl vector235
vector235:
  pushl $0
80106e8f:	6a 00                	push   $0x0
  pushl $235
80106e91:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80106e96:	e9 d2 f1 ff ff       	jmp    8010606d <alltraps>

80106e9b <vector236>:
.globl vector236
vector236:
  pushl $0
80106e9b:	6a 00                	push   $0x0
  pushl $236
80106e9d:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
80106ea2:	e9 c6 f1 ff ff       	jmp    8010606d <alltraps>

80106ea7 <vector237>:
.globl vector237
vector237:
  pushl $0
80106ea7:	6a 00                	push   $0x0
  pushl $237
80106ea9:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
80106eae:	e9 ba f1 ff ff       	jmp    8010606d <alltraps>

80106eb3 <vector238>:
.globl vector238
vector238:
  pushl $0
80106eb3:	6a 00                	push   $0x0
  pushl $238
80106eb5:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
80106eba:	e9 ae f1 ff ff       	jmp    8010606d <alltraps>

80106ebf <vector239>:
.globl vector239
vector239:
  pushl $0
80106ebf:	6a 00                	push   $0x0
  pushl $239
80106ec1:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
80106ec6:	e9 a2 f1 ff ff       	jmp    8010606d <alltraps>

80106ecb <vector240>:
.globl vector240
vector240:
  pushl $0
80106ecb:	6a 00                	push   $0x0
  pushl $240
80106ecd:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
80106ed2:	e9 96 f1 ff ff       	jmp    8010606d <alltraps>

80106ed7 <vector241>:
.globl vector241
vector241:
  pushl $0
80106ed7:	6a 00                	push   $0x0
  pushl $241
80106ed9:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
80106ede:	e9 8a f1 ff ff       	jmp    8010606d <alltraps>

80106ee3 <vector242>:
.globl vector242
vector242:
  pushl $0
80106ee3:	6a 00                	push   $0x0
  pushl $242
80106ee5:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
80106eea:	e9 7e f1 ff ff       	jmp    8010606d <alltraps>

80106eef <vector243>:
.globl vector243
vector243:
  pushl $0
80106eef:	6a 00                	push   $0x0
  pushl $243
80106ef1:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
80106ef6:	e9 72 f1 ff ff       	jmp    8010606d <alltraps>

80106efb <vector244>:
.globl vector244
vector244:
  pushl $0
80106efb:	6a 00                	push   $0x0
  pushl $244
80106efd:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
80106f02:	e9 66 f1 ff ff       	jmp    8010606d <alltraps>

80106f07 <vector245>:
.globl vector245
vector245:
  pushl $0
80106f07:	6a 00                	push   $0x0
  pushl $245
80106f09:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
80106f0e:	e9 5a f1 ff ff       	jmp    8010606d <alltraps>

80106f13 <vector246>:
.globl vector246
vector246:
  pushl $0
80106f13:	6a 00                	push   $0x0
  pushl $246
80106f15:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
80106f1a:	e9 4e f1 ff ff       	jmp    8010606d <alltraps>

80106f1f <vector247>:
.globl vector247
vector247:
  pushl $0
80106f1f:	6a 00                	push   $0x0
  pushl $247
80106f21:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
80106f26:	e9 42 f1 ff ff       	jmp    8010606d <alltraps>

80106f2b <vector248>:
.globl vector248
vector248:
  pushl $0
80106f2b:	6a 00                	push   $0x0
  pushl $248
80106f2d:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
80106f32:	e9 36 f1 ff ff       	jmp    8010606d <alltraps>

80106f37 <vector249>:
.globl vector249
vector249:
  pushl $0
80106f37:	6a 00                	push   $0x0
  pushl $249
80106f39:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
80106f3e:	e9 2a f1 ff ff       	jmp    8010606d <alltraps>

80106f43 <vector250>:
.globl vector250
vector250:
  pushl $0
80106f43:	6a 00                	push   $0x0
  pushl $250
80106f45:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80106f4a:	e9 1e f1 ff ff       	jmp    8010606d <alltraps>

80106f4f <vector251>:
.globl vector251
vector251:
  pushl $0
80106f4f:	6a 00                	push   $0x0
  pushl $251
80106f51:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80106f56:	e9 12 f1 ff ff       	jmp    8010606d <alltraps>

80106f5b <vector252>:
.globl vector252
vector252:
  pushl $0
80106f5b:	6a 00                	push   $0x0
  pushl $252
80106f5d:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
80106f62:	e9 06 f1 ff ff       	jmp    8010606d <alltraps>

80106f67 <vector253>:
.globl vector253
vector253:
  pushl $0
80106f67:	6a 00                	push   $0x0
  pushl $253
80106f69:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
80106f6e:	e9 fa f0 ff ff       	jmp    8010606d <alltraps>

80106f73 <vector254>:
.globl vector254
vector254:
  pushl $0
80106f73:	6a 00                	push   $0x0
  pushl $254
80106f75:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80106f7a:	e9 ee f0 ff ff       	jmp    8010606d <alltraps>

80106f7f <vector255>:
.globl vector255
vector255:
  pushl $0
80106f7f:	6a 00                	push   $0x0
  pushl $255
80106f81:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80106f86:	e9 e2 f0 ff ff       	jmp    8010606d <alltraps>
80106f8b:	66 90                	xchg   %ax,%ax
80106f8d:	66 90                	xchg   %ax,%ax
80106f8f:	90                   	nop

80106f90 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80106f90:	55                   	push   %ebp
80106f91:	89 e5                	mov    %esp,%ebp
80106f93:	57                   	push   %edi
80106f94:	56                   	push   %esi
80106f95:	89 d6                	mov    %edx,%esi
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80106f97:	c1 ea 16             	shr    $0x16,%edx
{
80106f9a:	53                   	push   %ebx
  pde = &pgdir[PDX(va)];
80106f9b:	8d 3c 90             	lea    (%eax,%edx,4),%edi
{
80106f9e:	83 ec 0c             	sub    $0xc,%esp
  if(*pde & PTE_P){
80106fa1:	8b 1f                	mov    (%edi),%ebx
80106fa3:	f6 c3 01             	test   $0x1,%bl
80106fa6:	74 28                	je     80106fd0 <walkpgdir+0x40>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106fa8:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
80106fae:	81 c3 00 00 00 80    	add    $0x80000000,%ebx
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
80106fb4:	89 f0                	mov    %esi,%eax
}
80106fb6:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return &pgtab[PTX(va)];
80106fb9:	c1 e8 0a             	shr    $0xa,%eax
80106fbc:	25 fc 0f 00 00       	and    $0xffc,%eax
80106fc1:	01 d8                	add    %ebx,%eax
}
80106fc3:	5b                   	pop    %ebx
80106fc4:	5e                   	pop    %esi
80106fc5:	5f                   	pop    %edi
80106fc6:	5d                   	pop    %ebp
80106fc7:	c3                   	ret    
80106fc8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106fcf:	90                   	nop
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80106fd0:	85 c9                	test   %ecx,%ecx
80106fd2:	74 2c                	je     80107000 <walkpgdir+0x70>
80106fd4:	e8 97 bc ff ff       	call   80102c70 <kalloc>
80106fd9:	89 c3                	mov    %eax,%ebx
80106fdb:	85 c0                	test   %eax,%eax
80106fdd:	74 21                	je     80107000 <walkpgdir+0x70>
    memset(pgtab, 0, PGSIZE);
80106fdf:	83 ec 04             	sub    $0x4,%esp
80106fe2:	68 00 10 00 00       	push   $0x1000
80106fe7:	6a 00                	push   $0x0
80106fe9:	50                   	push   %eax
80106fea:	e8 71 dd ff ff       	call   80104d60 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
80106fef:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106ff5:	83 c4 10             	add    $0x10,%esp
80106ff8:	83 c8 07             	or     $0x7,%eax
80106ffb:	89 07                	mov    %eax,(%edi)
80106ffd:	eb b5                	jmp    80106fb4 <walkpgdir+0x24>
80106fff:	90                   	nop
}
80107000:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return 0;
80107003:	31 c0                	xor    %eax,%eax
}
80107005:	5b                   	pop    %ebx
80107006:	5e                   	pop    %esi
80107007:	5f                   	pop    %edi
80107008:	5d                   	pop    %ebp
80107009:	c3                   	ret    
8010700a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107010 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80107010:	55                   	push   %ebp
80107011:	89 e5                	mov    %esp,%ebp
80107013:	57                   	push   %edi
80107014:	89 c7                	mov    %eax,%edi
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80107016:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
{
8010701a:	56                   	push   %esi
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
8010701b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  a = (char*)PGROUNDDOWN((uint)va);
80107020:	89 d6                	mov    %edx,%esi
{
80107022:	53                   	push   %ebx
  a = (char*)PGROUNDDOWN((uint)va);
80107023:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
{
80107029:	83 ec 1c             	sub    $0x1c,%esp
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
8010702c:	89 45 e0             	mov    %eax,-0x20(%ebp)
8010702f:	8b 45 08             	mov    0x8(%ebp),%eax
80107032:	29 f0                	sub    %esi,%eax
80107034:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107037:	eb 1f                	jmp    80107058 <mappages+0x48>
80107039:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
80107040:	f6 00 01             	testb  $0x1,(%eax)
80107043:	75 45                	jne    8010708a <mappages+0x7a>
      panic("remap");
    *pte = pa | perm | PTE_P;
80107045:	0b 5d 0c             	or     0xc(%ebp),%ebx
80107048:	83 cb 01             	or     $0x1,%ebx
8010704b:	89 18                	mov    %ebx,(%eax)
    if(a == last)
8010704d:	3b 75 e0             	cmp    -0x20(%ebp),%esi
80107050:	74 2e                	je     80107080 <mappages+0x70>
      break;
    a += PGSIZE;
80107052:	81 c6 00 10 00 00    	add    $0x1000,%esi
  for(;;){
80107058:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
8010705b:	b9 01 00 00 00       	mov    $0x1,%ecx
80107060:	89 f2                	mov    %esi,%edx
80107062:	8d 1c 06             	lea    (%esi,%eax,1),%ebx
80107065:	89 f8                	mov    %edi,%eax
80107067:	e8 24 ff ff ff       	call   80106f90 <walkpgdir>
8010706c:	85 c0                	test   %eax,%eax
8010706e:	75 d0                	jne    80107040 <mappages+0x30>
    pa += PGSIZE;
  }
  return 0;
}
80107070:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80107073:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107078:	5b                   	pop    %ebx
80107079:	5e                   	pop    %esi
8010707a:	5f                   	pop    %edi
8010707b:	5d                   	pop    %ebp
8010707c:	c3                   	ret    
8010707d:	8d 76 00             	lea    0x0(%esi),%esi
80107080:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80107083:	31 c0                	xor    %eax,%eax
}
80107085:	5b                   	pop    %ebx
80107086:	5e                   	pop    %esi
80107087:	5f                   	pop    %edi
80107088:	5d                   	pop    %ebp
80107089:	c3                   	ret    
      panic("remap");
8010708a:	83 ec 0c             	sub    $0xc,%esp
8010708d:	68 40 82 10 80       	push   $0x80108240
80107092:	e8 19 93 ff ff       	call   801003b0 <panic>
80107097:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010709e:	66 90                	xchg   %ax,%ax

801070a0 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
801070a0:	55                   	push   %ebp
801070a1:	89 e5                	mov    %esp,%ebp
801070a3:	57                   	push   %edi
801070a4:	56                   	push   %esi
801070a5:	89 c6                	mov    %eax,%esi
801070a7:	53                   	push   %ebx
801070a8:	89 d3                	mov    %edx,%ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
801070aa:	8d 91 ff 0f 00 00    	lea    0xfff(%ecx),%edx
801070b0:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
801070b6:	83 ec 1c             	sub    $0x1c,%esp
801070b9:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  for(; a  < oldsz; a += PGSIZE){
801070bc:	39 da                	cmp    %ebx,%edx
801070be:	73 5b                	jae    8010711b <deallocuvm.part.0+0x7b>
801070c0:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
801070c3:	89 d7                	mov    %edx,%edi
801070c5:	eb 14                	jmp    801070db <deallocuvm.part.0+0x3b>
801070c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801070ce:	66 90                	xchg   %ax,%ax
801070d0:	81 c7 00 10 00 00    	add    $0x1000,%edi
801070d6:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
801070d9:	76 40                	jbe    8010711b <deallocuvm.part.0+0x7b>
    pte = walkpgdir(pgdir, (char*)a, 0);
801070db:	31 c9                	xor    %ecx,%ecx
801070dd:	89 fa                	mov    %edi,%edx
801070df:	89 f0                	mov    %esi,%eax
801070e1:	e8 aa fe ff ff       	call   80106f90 <walkpgdir>
801070e6:	89 c3                	mov    %eax,%ebx
    if(!pte)
801070e8:	85 c0                	test   %eax,%eax
801070ea:	74 44                	je     80107130 <deallocuvm.part.0+0x90>
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
801070ec:	8b 00                	mov    (%eax),%eax
801070ee:	a8 01                	test   $0x1,%al
801070f0:	74 de                	je     801070d0 <deallocuvm.part.0+0x30>
      pa = PTE_ADDR(*pte);
      if(pa == 0)
801070f2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801070f7:	74 47                	je     80107140 <deallocuvm.part.0+0xa0>
        panic("kfree");
      char *v = P2V(pa);
      kfree(v);
801070f9:	83 ec 0c             	sub    $0xc,%esp
      char *v = P2V(pa);
801070fc:	05 00 00 00 80       	add    $0x80000000,%eax
80107101:	81 c7 00 10 00 00    	add    $0x1000,%edi
      kfree(v);
80107107:	50                   	push   %eax
80107108:	e8 a3 b9 ff ff       	call   80102ab0 <kfree>
      *pte = 0;
8010710d:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80107113:	83 c4 10             	add    $0x10,%esp
  for(; a  < oldsz; a += PGSIZE){
80107116:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80107119:	77 c0                	ja     801070db <deallocuvm.part.0+0x3b>
    }
  }
  return newsz;
}
8010711b:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010711e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107121:	5b                   	pop    %ebx
80107122:	5e                   	pop    %esi
80107123:	5f                   	pop    %edi
80107124:	5d                   	pop    %ebp
80107125:	c3                   	ret    
80107126:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010712d:	8d 76 00             	lea    0x0(%esi),%esi
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
80107130:	89 fa                	mov    %edi,%edx
80107132:	81 e2 00 00 c0 ff    	and    $0xffc00000,%edx
80107138:	8d ba 00 00 40 00    	lea    0x400000(%edx),%edi
8010713e:	eb 96                	jmp    801070d6 <deallocuvm.part.0+0x36>
        panic("kfree");
80107140:	83 ec 0c             	sub    $0xc,%esp
80107143:	68 9e 7b 10 80       	push   $0x80107b9e
80107148:	e8 63 92 ff ff       	call   801003b0 <panic>
8010714d:	8d 76 00             	lea    0x0(%esi),%esi

80107150 <seginit>:
{
80107150:	f3 0f 1e fb          	endbr32 
80107154:	55                   	push   %ebp
80107155:	89 e5                	mov    %esp,%ebp
80107157:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
8010715a:	e8 21 ce ff ff       	call   80103f80 <cpuid>
  pd[0] = size - 1;
8010715f:	ba 2f 00 00 00       	mov    $0x2f,%edx
80107164:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
8010716a:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
8010716e:	c7 80 38 44 11 80 ff 	movl   $0xffff,-0x7feebbc8(%eax)
80107175:	ff 00 00 
80107178:	c7 80 3c 44 11 80 00 	movl   $0xcf9a00,-0x7feebbc4(%eax)
8010717f:	9a cf 00 
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80107182:	c7 80 40 44 11 80 ff 	movl   $0xffff,-0x7feebbc0(%eax)
80107189:	ff 00 00 
8010718c:	c7 80 44 44 11 80 00 	movl   $0xcf9200,-0x7feebbbc(%eax)
80107193:	92 cf 00 
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80107196:	c7 80 48 44 11 80 ff 	movl   $0xffff,-0x7feebbb8(%eax)
8010719d:	ff 00 00 
801071a0:	c7 80 4c 44 11 80 00 	movl   $0xcffa00,-0x7feebbb4(%eax)
801071a7:	fa cf 00 
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
801071aa:	c7 80 50 44 11 80 ff 	movl   $0xffff,-0x7feebbb0(%eax)
801071b1:	ff 00 00 
801071b4:	c7 80 54 44 11 80 00 	movl   $0xcff200,-0x7feebbac(%eax)
801071bb:	f2 cf 00 
  lgdt(c->gdt, sizeof(c->gdt));
801071be:	05 30 44 11 80       	add    $0x80114430,%eax
  pd[1] = (uint)p;
801071c3:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
801071c7:	c1 e8 10             	shr    $0x10,%eax
801071ca:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r"(pd));
801071ce:	8d 45 f2             	lea    -0xe(%ebp),%eax
801071d1:	0f 01 10             	lgdtl  (%eax)
}
801071d4:	c9                   	leave  
801071d5:	c3                   	ret    
801071d6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801071dd:	8d 76 00             	lea    0x0(%esi),%esi

801071e0 <switchkvm>:
{
801071e0:	f3 0f 1e fb          	endbr32 
  lcr3(V2P(kpgdir));   // switch to the kernel page table
801071e4:	a1 e4 71 11 80       	mov    0x801171e4,%eax
801071e9:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r"(val));
801071ee:	0f 22 d8             	mov    %eax,%cr3
}
801071f1:	c3                   	ret    
801071f2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801071f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107200 <switchuvm>:
{
80107200:	f3 0f 1e fb          	endbr32 
80107204:	55                   	push   %ebp
80107205:	89 e5                	mov    %esp,%ebp
80107207:	57                   	push   %edi
80107208:	56                   	push   %esi
80107209:	53                   	push   %ebx
8010720a:	83 ec 1c             	sub    $0x1c,%esp
8010720d:	8b 75 08             	mov    0x8(%ebp),%esi
  if(p == 0)
80107210:	85 f6                	test   %esi,%esi
80107212:	0f 84 cb 00 00 00    	je     801072e3 <switchuvm+0xe3>
  if(p->kstack == 0)
80107218:	8b 46 08             	mov    0x8(%esi),%eax
8010721b:	85 c0                	test   %eax,%eax
8010721d:	0f 84 da 00 00 00    	je     801072fd <switchuvm+0xfd>
  if(p->pgdir == 0)
80107223:	8b 46 04             	mov    0x4(%esi),%eax
80107226:	85 c0                	test   %eax,%eax
80107228:	0f 84 c2 00 00 00    	je     801072f0 <switchuvm+0xf0>
  pushcli();
8010722e:	e8 1d d9 ff ff       	call   80104b50 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80107233:	e8 d8 cc ff ff       	call   80103f10 <mycpu>
80107238:	89 c3                	mov    %eax,%ebx
8010723a:	e8 d1 cc ff ff       	call   80103f10 <mycpu>
8010723f:	89 c7                	mov    %eax,%edi
80107241:	e8 ca cc ff ff       	call   80103f10 <mycpu>
80107246:	83 c7 08             	add    $0x8,%edi
80107249:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010724c:	e8 bf cc ff ff       	call   80103f10 <mycpu>
80107251:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80107254:	ba 67 00 00 00       	mov    $0x67,%edx
80107259:	66 89 bb 9a 00 00 00 	mov    %di,0x9a(%ebx)
80107260:	83 c0 08             	add    $0x8,%eax
80107263:	66 89 93 98 00 00 00 	mov    %dx,0x98(%ebx)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
8010726a:	bf ff ff ff ff       	mov    $0xffffffff,%edi
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
8010726f:	83 c1 08             	add    $0x8,%ecx
80107272:	c1 e8 18             	shr    $0x18,%eax
80107275:	c1 e9 10             	shr    $0x10,%ecx
80107278:	88 83 9f 00 00 00    	mov    %al,0x9f(%ebx)
8010727e:	88 8b 9c 00 00 00    	mov    %cl,0x9c(%ebx)
80107284:	b9 99 40 00 00       	mov    $0x4099,%ecx
80107289:	66 89 8b 9d 00 00 00 	mov    %cx,0x9d(%ebx)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80107290:	bb 10 00 00 00       	mov    $0x10,%ebx
  mycpu()->gdt[SEG_TSS].s = 0;
80107295:	e8 76 cc ff ff       	call   80103f10 <mycpu>
8010729a:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
801072a1:	e8 6a cc ff ff       	call   80103f10 <mycpu>
801072a6:	66 89 58 10          	mov    %bx,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
801072aa:	8b 5e 08             	mov    0x8(%esi),%ebx
801072ad:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801072b3:	e8 58 cc ff ff       	call   80103f10 <mycpu>
801072b8:	89 58 0c             	mov    %ebx,0xc(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
801072bb:	e8 50 cc ff ff       	call   80103f10 <mycpu>
801072c0:	66 89 78 6e          	mov    %di,0x6e(%eax)
  asm volatile("ltr %0" : : "r"(sel));
801072c4:	b8 28 00 00 00       	mov    $0x28,%eax
801072c9:	0f 00 d8             	ltr    %ax
  lcr3(V2P(p->pgdir));  // switch to process's address space
801072cc:	8b 46 04             	mov    0x4(%esi),%eax
801072cf:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r"(val));
801072d4:	0f 22 d8             	mov    %eax,%cr3
}
801072d7:	8d 65 f4             	lea    -0xc(%ebp),%esp
801072da:	5b                   	pop    %ebx
801072db:	5e                   	pop    %esi
801072dc:	5f                   	pop    %edi
801072dd:	5d                   	pop    %ebp
  popcli();
801072de:	e9 bd d8 ff ff       	jmp    80104ba0 <popcli>
    panic("switchuvm: no process");
801072e3:	83 ec 0c             	sub    $0xc,%esp
801072e6:	68 46 82 10 80       	push   $0x80108246
801072eb:	e8 c0 90 ff ff       	call   801003b0 <panic>
    panic("switchuvm: no pgdir");
801072f0:	83 ec 0c             	sub    $0xc,%esp
801072f3:	68 71 82 10 80       	push   $0x80108271
801072f8:	e8 b3 90 ff ff       	call   801003b0 <panic>
    panic("switchuvm: no kstack");
801072fd:	83 ec 0c             	sub    $0xc,%esp
80107300:	68 5c 82 10 80       	push   $0x8010825c
80107305:	e8 a6 90 ff ff       	call   801003b0 <panic>
8010730a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107310 <inituvm>:
{
80107310:	f3 0f 1e fb          	endbr32 
80107314:	55                   	push   %ebp
80107315:	89 e5                	mov    %esp,%ebp
80107317:	57                   	push   %edi
80107318:	56                   	push   %esi
80107319:	53                   	push   %ebx
8010731a:	83 ec 1c             	sub    $0x1c,%esp
8010731d:	8b 45 0c             	mov    0xc(%ebp),%eax
80107320:	8b 75 10             	mov    0x10(%ebp),%esi
80107323:	8b 7d 08             	mov    0x8(%ebp),%edi
80107326:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(sz >= PGSIZE)
80107329:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
8010732f:	77 4b                	ja     8010737c <inituvm+0x6c>
  mem = kalloc();
80107331:	e8 3a b9 ff ff       	call   80102c70 <kalloc>
  memset(mem, 0, PGSIZE);
80107336:	83 ec 04             	sub    $0x4,%esp
80107339:	68 00 10 00 00       	push   $0x1000
  mem = kalloc();
8010733e:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
80107340:	6a 00                	push   $0x0
80107342:	50                   	push   %eax
80107343:	e8 18 da ff ff       	call   80104d60 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80107348:	58                   	pop    %eax
80107349:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
8010734f:	5a                   	pop    %edx
80107350:	6a 06                	push   $0x6
80107352:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107357:	31 d2                	xor    %edx,%edx
80107359:	50                   	push   %eax
8010735a:	89 f8                	mov    %edi,%eax
8010735c:	e8 af fc ff ff       	call   80107010 <mappages>
  memmove(mem, init, sz);
80107361:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107364:	89 75 10             	mov    %esi,0x10(%ebp)
80107367:	83 c4 10             	add    $0x10,%esp
8010736a:	89 5d 08             	mov    %ebx,0x8(%ebp)
8010736d:	89 45 0c             	mov    %eax,0xc(%ebp)
}
80107370:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107373:	5b                   	pop    %ebx
80107374:	5e                   	pop    %esi
80107375:	5f                   	pop    %edi
80107376:	5d                   	pop    %ebp
  memmove(mem, init, sz);
80107377:	e9 84 da ff ff       	jmp    80104e00 <memmove>
    panic("inituvm: more than a page");
8010737c:	83 ec 0c             	sub    $0xc,%esp
8010737f:	68 85 82 10 80       	push   $0x80108285
80107384:	e8 27 90 ff ff       	call   801003b0 <panic>
80107389:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107390 <loaduvm>:
{
80107390:	f3 0f 1e fb          	endbr32 
80107394:	55                   	push   %ebp
80107395:	89 e5                	mov    %esp,%ebp
80107397:	57                   	push   %edi
80107398:	56                   	push   %esi
80107399:	53                   	push   %ebx
8010739a:	83 ec 1c             	sub    $0x1c,%esp
8010739d:	8b 45 0c             	mov    0xc(%ebp),%eax
801073a0:	8b 75 18             	mov    0x18(%ebp),%esi
  if((uint) addr % PGSIZE != 0)
801073a3:	a9 ff 0f 00 00       	test   $0xfff,%eax
801073a8:	0f 85 99 00 00 00    	jne    80107447 <loaduvm+0xb7>
  for(i = 0; i < sz; i += PGSIZE){
801073ae:	01 f0                	add    %esi,%eax
801073b0:	89 f3                	mov    %esi,%ebx
801073b2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(readi(ip, P2V(pa), offset+i, n) != n)
801073b5:	8b 45 14             	mov    0x14(%ebp),%eax
801073b8:	01 f0                	add    %esi,%eax
801073ba:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(i = 0; i < sz; i += PGSIZE){
801073bd:	85 f6                	test   %esi,%esi
801073bf:	75 15                	jne    801073d6 <loaduvm+0x46>
801073c1:	eb 6d                	jmp    80107430 <loaduvm+0xa0>
801073c3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801073c7:	90                   	nop
801073c8:	81 eb 00 10 00 00    	sub    $0x1000,%ebx
801073ce:	89 f0                	mov    %esi,%eax
801073d0:	29 d8                	sub    %ebx,%eax
801073d2:	39 c6                	cmp    %eax,%esi
801073d4:	76 5a                	jbe    80107430 <loaduvm+0xa0>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
801073d6:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801073d9:	8b 45 08             	mov    0x8(%ebp),%eax
801073dc:	31 c9                	xor    %ecx,%ecx
801073de:	29 da                	sub    %ebx,%edx
801073e0:	e8 ab fb ff ff       	call   80106f90 <walkpgdir>
801073e5:	85 c0                	test   %eax,%eax
801073e7:	74 51                	je     8010743a <loaduvm+0xaa>
    pa = PTE_ADDR(*pte);
801073e9:	8b 00                	mov    (%eax),%eax
    if(readi(ip, P2V(pa), offset+i, n) != n)
801073eb:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    if(sz - i < PGSIZE)
801073ee:	bf 00 10 00 00       	mov    $0x1000,%edi
    pa = PTE_ADDR(*pte);
801073f3:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
801073f8:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
801073fe:	0f 46 fb             	cmovbe %ebx,%edi
    if(readi(ip, P2V(pa), offset+i, n) != n)
80107401:	29 d9                	sub    %ebx,%ecx
80107403:	05 00 00 00 80       	add    $0x80000000,%eax
80107408:	57                   	push   %edi
80107409:	51                   	push   %ecx
8010740a:	50                   	push   %eax
8010740b:	ff 75 10             	pushl  0x10(%ebp)
8010740e:	e8 8d ac ff ff       	call   801020a0 <readi>
80107413:	83 c4 10             	add    $0x10,%esp
80107416:	39 f8                	cmp    %edi,%eax
80107418:	74 ae                	je     801073c8 <loaduvm+0x38>
}
8010741a:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
8010741d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107422:	5b                   	pop    %ebx
80107423:	5e                   	pop    %esi
80107424:	5f                   	pop    %edi
80107425:	5d                   	pop    %ebp
80107426:	c3                   	ret    
80107427:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010742e:	66 90                	xchg   %ax,%ax
80107430:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80107433:	31 c0                	xor    %eax,%eax
}
80107435:	5b                   	pop    %ebx
80107436:	5e                   	pop    %esi
80107437:	5f                   	pop    %edi
80107438:	5d                   	pop    %ebp
80107439:	c3                   	ret    
      panic("loaduvm: address should exist");
8010743a:	83 ec 0c             	sub    $0xc,%esp
8010743d:	68 9f 82 10 80       	push   $0x8010829f
80107442:	e8 69 8f ff ff       	call   801003b0 <panic>
    panic("loaduvm: addr must be page aligned");
80107447:	83 ec 0c             	sub    $0xc,%esp
8010744a:	68 40 83 10 80       	push   $0x80108340
8010744f:	e8 5c 8f ff ff       	call   801003b0 <panic>
80107454:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010745b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010745f:	90                   	nop

80107460 <allocuvm>:
{
80107460:	f3 0f 1e fb          	endbr32 
80107464:	55                   	push   %ebp
80107465:	89 e5                	mov    %esp,%ebp
80107467:	57                   	push   %edi
80107468:	56                   	push   %esi
80107469:	53                   	push   %ebx
8010746a:	83 ec 1c             	sub    $0x1c,%esp
  if(newsz >= KERNBASE)
8010746d:	8b 45 10             	mov    0x10(%ebp),%eax
{
80107470:	8b 7d 08             	mov    0x8(%ebp),%edi
  if(newsz >= KERNBASE)
80107473:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107476:	85 c0                	test   %eax,%eax
80107478:	0f 88 b2 00 00 00    	js     80107530 <allocuvm+0xd0>
  if(newsz < oldsz)
8010747e:	3b 45 0c             	cmp    0xc(%ebp),%eax
    return oldsz;
80107481:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(newsz < oldsz)
80107484:	0f 82 96 00 00 00    	jb     80107520 <allocuvm+0xc0>
  a = PGROUNDUP(oldsz);
8010748a:	8d b0 ff 0f 00 00    	lea    0xfff(%eax),%esi
80107490:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
  for(; a < newsz; a += PGSIZE){
80107496:	39 75 10             	cmp    %esi,0x10(%ebp)
80107499:	77 40                	ja     801074db <allocuvm+0x7b>
8010749b:	e9 83 00 00 00       	jmp    80107523 <allocuvm+0xc3>
    memset(mem, 0, PGSIZE);
801074a0:	83 ec 04             	sub    $0x4,%esp
801074a3:	68 00 10 00 00       	push   $0x1000
801074a8:	6a 00                	push   $0x0
801074aa:	50                   	push   %eax
801074ab:	e8 b0 d8 ff ff       	call   80104d60 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
801074b0:	58                   	pop    %eax
801074b1:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801074b7:	5a                   	pop    %edx
801074b8:	6a 06                	push   $0x6
801074ba:	b9 00 10 00 00       	mov    $0x1000,%ecx
801074bf:	89 f2                	mov    %esi,%edx
801074c1:	50                   	push   %eax
801074c2:	89 f8                	mov    %edi,%eax
801074c4:	e8 47 fb ff ff       	call   80107010 <mappages>
801074c9:	83 c4 10             	add    $0x10,%esp
801074cc:	85 c0                	test   %eax,%eax
801074ce:	78 78                	js     80107548 <allocuvm+0xe8>
  for(; a < newsz; a += PGSIZE){
801074d0:	81 c6 00 10 00 00    	add    $0x1000,%esi
801074d6:	39 75 10             	cmp    %esi,0x10(%ebp)
801074d9:	76 48                	jbe    80107523 <allocuvm+0xc3>
    mem = kalloc();
801074db:	e8 90 b7 ff ff       	call   80102c70 <kalloc>
801074e0:	89 c3                	mov    %eax,%ebx
    if(mem == 0){
801074e2:	85 c0                	test   %eax,%eax
801074e4:	75 ba                	jne    801074a0 <allocuvm+0x40>
      cprintf("allocuvm out of memory\n");
801074e6:	83 ec 0c             	sub    $0xc,%esp
801074e9:	68 bd 82 10 80       	push   $0x801082bd
801074ee:	e8 ad 92 ff ff       	call   801007a0 <cprintf>
  if(newsz >= oldsz)
801074f3:	8b 45 0c             	mov    0xc(%ebp),%eax
801074f6:	83 c4 10             	add    $0x10,%esp
801074f9:	39 45 10             	cmp    %eax,0x10(%ebp)
801074fc:	74 32                	je     80107530 <allocuvm+0xd0>
801074fe:	8b 55 10             	mov    0x10(%ebp),%edx
80107501:	89 c1                	mov    %eax,%ecx
80107503:	89 f8                	mov    %edi,%eax
80107505:	e8 96 fb ff ff       	call   801070a0 <deallocuvm.part.0>
      return 0;
8010750a:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
}
80107511:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107514:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107517:	5b                   	pop    %ebx
80107518:	5e                   	pop    %esi
80107519:	5f                   	pop    %edi
8010751a:	5d                   	pop    %ebp
8010751b:	c3                   	ret    
8010751c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return oldsz;
80107520:	89 45 e4             	mov    %eax,-0x1c(%ebp)
}
80107523:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107526:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107529:	5b                   	pop    %ebx
8010752a:	5e                   	pop    %esi
8010752b:	5f                   	pop    %edi
8010752c:	5d                   	pop    %ebp
8010752d:	c3                   	ret    
8010752e:	66 90                	xchg   %ax,%ax
    return 0;
80107530:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
}
80107537:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010753a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010753d:	5b                   	pop    %ebx
8010753e:	5e                   	pop    %esi
8010753f:	5f                   	pop    %edi
80107540:	5d                   	pop    %ebp
80107541:	c3                   	ret    
80107542:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      cprintf("allocuvm out of memory (2)\n");
80107548:	83 ec 0c             	sub    $0xc,%esp
8010754b:	68 d5 82 10 80       	push   $0x801082d5
80107550:	e8 4b 92 ff ff       	call   801007a0 <cprintf>
  if(newsz >= oldsz)
80107555:	8b 45 0c             	mov    0xc(%ebp),%eax
80107558:	83 c4 10             	add    $0x10,%esp
8010755b:	39 45 10             	cmp    %eax,0x10(%ebp)
8010755e:	74 0c                	je     8010756c <allocuvm+0x10c>
80107560:	8b 55 10             	mov    0x10(%ebp),%edx
80107563:	89 c1                	mov    %eax,%ecx
80107565:	89 f8                	mov    %edi,%eax
80107567:	e8 34 fb ff ff       	call   801070a0 <deallocuvm.part.0>
      kfree(mem);
8010756c:	83 ec 0c             	sub    $0xc,%esp
8010756f:	53                   	push   %ebx
80107570:	e8 3b b5 ff ff       	call   80102ab0 <kfree>
      return 0;
80107575:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
8010757c:	83 c4 10             	add    $0x10,%esp
}
8010757f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107582:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107585:	5b                   	pop    %ebx
80107586:	5e                   	pop    %esi
80107587:	5f                   	pop    %edi
80107588:	5d                   	pop    %ebp
80107589:	c3                   	ret    
8010758a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107590 <deallocuvm>:
{
80107590:	f3 0f 1e fb          	endbr32 
80107594:	55                   	push   %ebp
80107595:	89 e5                	mov    %esp,%ebp
80107597:	8b 55 0c             	mov    0xc(%ebp),%edx
8010759a:	8b 4d 10             	mov    0x10(%ebp),%ecx
8010759d:	8b 45 08             	mov    0x8(%ebp),%eax
  if(newsz >= oldsz)
801075a0:	39 d1                	cmp    %edx,%ecx
801075a2:	73 0c                	jae    801075b0 <deallocuvm+0x20>
}
801075a4:	5d                   	pop    %ebp
801075a5:	e9 f6 fa ff ff       	jmp    801070a0 <deallocuvm.part.0>
801075aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801075b0:	89 d0                	mov    %edx,%eax
801075b2:	5d                   	pop    %ebp
801075b3:	c3                   	ret    
801075b4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801075bb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801075bf:	90                   	nop

801075c0 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
801075c0:	f3 0f 1e fb          	endbr32 
801075c4:	55                   	push   %ebp
801075c5:	89 e5                	mov    %esp,%ebp
801075c7:	57                   	push   %edi
801075c8:	56                   	push   %esi
801075c9:	53                   	push   %ebx
801075ca:	83 ec 0c             	sub    $0xc,%esp
801075cd:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
801075d0:	85 f6                	test   %esi,%esi
801075d2:	74 55                	je     80107629 <freevm+0x69>
  if(newsz >= oldsz)
801075d4:	31 c9                	xor    %ecx,%ecx
801075d6:	ba 00 00 00 80       	mov    $0x80000000,%edx
801075db:	89 f0                	mov    %esi,%eax
801075dd:	89 f3                	mov    %esi,%ebx
801075df:	e8 bc fa ff ff       	call   801070a0 <deallocuvm.part.0>
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
801075e4:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
801075ea:	eb 0b                	jmp    801075f7 <freevm+0x37>
801075ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801075f0:	83 c3 04             	add    $0x4,%ebx
801075f3:	39 df                	cmp    %ebx,%edi
801075f5:	74 23                	je     8010761a <freevm+0x5a>
    if(pgdir[i] & PTE_P){
801075f7:	8b 03                	mov    (%ebx),%eax
801075f9:	a8 01                	test   $0x1,%al
801075fb:	74 f3                	je     801075f0 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
801075fd:	25 00 f0 ff ff       	and    $0xfffff000,%eax
      kfree(v);
80107602:	83 ec 0c             	sub    $0xc,%esp
80107605:	83 c3 04             	add    $0x4,%ebx
      char * v = P2V(PTE_ADDR(pgdir[i]));
80107608:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
8010760d:	50                   	push   %eax
8010760e:	e8 9d b4 ff ff       	call   80102ab0 <kfree>
80107613:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
80107616:	39 df                	cmp    %ebx,%edi
80107618:	75 dd                	jne    801075f7 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
8010761a:	89 75 08             	mov    %esi,0x8(%ebp)
}
8010761d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107620:	5b                   	pop    %ebx
80107621:	5e                   	pop    %esi
80107622:	5f                   	pop    %edi
80107623:	5d                   	pop    %ebp
  kfree((char*)pgdir);
80107624:	e9 87 b4 ff ff       	jmp    80102ab0 <kfree>
    panic("freevm: no pgdir");
80107629:	83 ec 0c             	sub    $0xc,%esp
8010762c:	68 f1 82 10 80       	push   $0x801082f1
80107631:	e8 7a 8d ff ff       	call   801003b0 <panic>
80107636:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010763d:	8d 76 00             	lea    0x0(%esi),%esi

80107640 <setupkvm>:
{
80107640:	f3 0f 1e fb          	endbr32 
80107644:	55                   	push   %ebp
80107645:	89 e5                	mov    %esp,%ebp
80107647:	56                   	push   %esi
80107648:	53                   	push   %ebx
  if((pgdir = (pde_t*)kalloc()) == 0)
80107649:	e8 22 b6 ff ff       	call   80102c70 <kalloc>
8010764e:	89 c6                	mov    %eax,%esi
80107650:	85 c0                	test   %eax,%eax
80107652:	74 42                	je     80107696 <setupkvm+0x56>
  memset(pgdir, 0, PGSIZE);
80107654:	83 ec 04             	sub    $0x4,%esp
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107657:	bb 20 b4 10 80       	mov    $0x8010b420,%ebx
  memset(pgdir, 0, PGSIZE);
8010765c:	68 00 10 00 00       	push   $0x1000
80107661:	6a 00                	push   $0x0
80107663:	50                   	push   %eax
80107664:	e8 f7 d6 ff ff       	call   80104d60 <memset>
80107669:	83 c4 10             	add    $0x10,%esp
                (uint)k->phys_start, k->perm) < 0) {
8010766c:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
8010766f:	83 ec 08             	sub    $0x8,%esp
80107672:	8b 4b 08             	mov    0x8(%ebx),%ecx
80107675:	ff 73 0c             	pushl  0xc(%ebx)
80107678:	8b 13                	mov    (%ebx),%edx
8010767a:	50                   	push   %eax
8010767b:	29 c1                	sub    %eax,%ecx
8010767d:	89 f0                	mov    %esi,%eax
8010767f:	e8 8c f9 ff ff       	call   80107010 <mappages>
80107684:	83 c4 10             	add    $0x10,%esp
80107687:	85 c0                	test   %eax,%eax
80107689:	78 15                	js     801076a0 <setupkvm+0x60>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
8010768b:	83 c3 10             	add    $0x10,%ebx
8010768e:	81 fb 60 b4 10 80    	cmp    $0x8010b460,%ebx
80107694:	75 d6                	jne    8010766c <setupkvm+0x2c>
}
80107696:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107699:	89 f0                	mov    %esi,%eax
8010769b:	5b                   	pop    %ebx
8010769c:	5e                   	pop    %esi
8010769d:	5d                   	pop    %ebp
8010769e:	c3                   	ret    
8010769f:	90                   	nop
      freevm(pgdir);
801076a0:	83 ec 0c             	sub    $0xc,%esp
801076a3:	56                   	push   %esi
      return 0;
801076a4:	31 f6                	xor    %esi,%esi
      freevm(pgdir);
801076a6:	e8 15 ff ff ff       	call   801075c0 <freevm>
      return 0;
801076ab:	83 c4 10             	add    $0x10,%esp
}
801076ae:	8d 65 f8             	lea    -0x8(%ebp),%esp
801076b1:	89 f0                	mov    %esi,%eax
801076b3:	5b                   	pop    %ebx
801076b4:	5e                   	pop    %esi
801076b5:	5d                   	pop    %ebp
801076b6:	c3                   	ret    
801076b7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801076be:	66 90                	xchg   %ax,%ax

801076c0 <kvmalloc>:
{
801076c0:	f3 0f 1e fb          	endbr32 
801076c4:	55                   	push   %ebp
801076c5:	89 e5                	mov    %esp,%ebp
801076c7:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
801076ca:	e8 71 ff ff ff       	call   80107640 <setupkvm>
801076cf:	a3 e4 71 11 80       	mov    %eax,0x801171e4
  lcr3(V2P(kpgdir));   // switch to the kernel page table
801076d4:	05 00 00 00 80       	add    $0x80000000,%eax
801076d9:	0f 22 d8             	mov    %eax,%cr3
}
801076dc:	c9                   	leave  
801076dd:	c3                   	ret    
801076de:	66 90                	xchg   %ax,%ax

801076e0 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
801076e0:	f3 0f 1e fb          	endbr32 
801076e4:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
801076e5:	31 c9                	xor    %ecx,%ecx
{
801076e7:	89 e5                	mov    %esp,%ebp
801076e9:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
801076ec:	8b 55 0c             	mov    0xc(%ebp),%edx
801076ef:	8b 45 08             	mov    0x8(%ebp),%eax
801076f2:	e8 99 f8 ff ff       	call   80106f90 <walkpgdir>
  if(pte == 0)
801076f7:	85 c0                	test   %eax,%eax
801076f9:	74 05                	je     80107700 <clearpteu+0x20>
    panic("clearpteu");
  *pte &= ~PTE_U;
801076fb:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
801076fe:	c9                   	leave  
801076ff:	c3                   	ret    
    panic("clearpteu");
80107700:	83 ec 0c             	sub    $0xc,%esp
80107703:	68 02 83 10 80       	push   $0x80108302
80107708:	e8 a3 8c ff ff       	call   801003b0 <panic>
8010770d:	8d 76 00             	lea    0x0(%esi),%esi

80107710 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80107710:	f3 0f 1e fb          	endbr32 
80107714:	55                   	push   %ebp
80107715:	89 e5                	mov    %esp,%ebp
80107717:	57                   	push   %edi
80107718:	56                   	push   %esi
80107719:	53                   	push   %ebx
8010771a:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
8010771d:	e8 1e ff ff ff       	call   80107640 <setupkvm>
80107722:	89 45 e0             	mov    %eax,-0x20(%ebp)
80107725:	85 c0                	test   %eax,%eax
80107727:	0f 84 9b 00 00 00    	je     801077c8 <copyuvm+0xb8>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
8010772d:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80107730:	85 c9                	test   %ecx,%ecx
80107732:	0f 84 90 00 00 00    	je     801077c8 <copyuvm+0xb8>
80107738:	31 f6                	xor    %esi,%esi
8010773a:	eb 46                	jmp    80107782 <copyuvm+0x72>
8010773c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80107740:	83 ec 04             	sub    $0x4,%esp
80107743:	81 c7 00 00 00 80    	add    $0x80000000,%edi
80107749:	68 00 10 00 00       	push   $0x1000
8010774e:	57                   	push   %edi
8010774f:	50                   	push   %eax
80107750:	e8 ab d6 ff ff       	call   80104e00 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
80107755:	58                   	pop    %eax
80107756:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
8010775c:	5a                   	pop    %edx
8010775d:	ff 75 e4             	pushl  -0x1c(%ebp)
80107760:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107765:	89 f2                	mov    %esi,%edx
80107767:	50                   	push   %eax
80107768:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010776b:	e8 a0 f8 ff ff       	call   80107010 <mappages>
80107770:	83 c4 10             	add    $0x10,%esp
80107773:	85 c0                	test   %eax,%eax
80107775:	78 61                	js     801077d8 <copyuvm+0xc8>
  for(i = 0; i < sz; i += PGSIZE){
80107777:	81 c6 00 10 00 00    	add    $0x1000,%esi
8010777d:	39 75 0c             	cmp    %esi,0xc(%ebp)
80107780:	76 46                	jbe    801077c8 <copyuvm+0xb8>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80107782:	8b 45 08             	mov    0x8(%ebp),%eax
80107785:	31 c9                	xor    %ecx,%ecx
80107787:	89 f2                	mov    %esi,%edx
80107789:	e8 02 f8 ff ff       	call   80106f90 <walkpgdir>
8010778e:	85 c0                	test   %eax,%eax
80107790:	74 61                	je     801077f3 <copyuvm+0xe3>
    if(!(*pte & PTE_P))
80107792:	8b 00                	mov    (%eax),%eax
80107794:	a8 01                	test   $0x1,%al
80107796:	74 4e                	je     801077e6 <copyuvm+0xd6>
    pa = PTE_ADDR(*pte);
80107798:	89 c7                	mov    %eax,%edi
    flags = PTE_FLAGS(*pte);
8010779a:	25 ff 0f 00 00       	and    $0xfff,%eax
8010779f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    pa = PTE_ADDR(*pte);
801077a2:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
    if((mem = kalloc()) == 0)
801077a8:	e8 c3 b4 ff ff       	call   80102c70 <kalloc>
801077ad:	89 c3                	mov    %eax,%ebx
801077af:	85 c0                	test   %eax,%eax
801077b1:	75 8d                	jne    80107740 <copyuvm+0x30>
    }
  }
  return d;

bad:
  freevm(d);
801077b3:	83 ec 0c             	sub    $0xc,%esp
801077b6:	ff 75 e0             	pushl  -0x20(%ebp)
801077b9:	e8 02 fe ff ff       	call   801075c0 <freevm>
  return 0;
801077be:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
801077c5:	83 c4 10             	add    $0x10,%esp
}
801077c8:	8b 45 e0             	mov    -0x20(%ebp),%eax
801077cb:	8d 65 f4             	lea    -0xc(%ebp),%esp
801077ce:	5b                   	pop    %ebx
801077cf:	5e                   	pop    %esi
801077d0:	5f                   	pop    %edi
801077d1:	5d                   	pop    %ebp
801077d2:	c3                   	ret    
801077d3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801077d7:	90                   	nop
      kfree(mem);
801077d8:	83 ec 0c             	sub    $0xc,%esp
801077db:	53                   	push   %ebx
801077dc:	e8 cf b2 ff ff       	call   80102ab0 <kfree>
      goto bad;
801077e1:	83 c4 10             	add    $0x10,%esp
801077e4:	eb cd                	jmp    801077b3 <copyuvm+0xa3>
      panic("copyuvm: page not present");
801077e6:	83 ec 0c             	sub    $0xc,%esp
801077e9:	68 26 83 10 80       	push   $0x80108326
801077ee:	e8 bd 8b ff ff       	call   801003b0 <panic>
      panic("copyuvm: pte should exist");
801077f3:	83 ec 0c             	sub    $0xc,%esp
801077f6:	68 0c 83 10 80       	push   $0x8010830c
801077fb:	e8 b0 8b ff ff       	call   801003b0 <panic>

80107800 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80107800:	f3 0f 1e fb          	endbr32 
80107804:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107805:	31 c9                	xor    %ecx,%ecx
{
80107807:	89 e5                	mov    %esp,%ebp
80107809:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
8010780c:	8b 55 0c             	mov    0xc(%ebp),%edx
8010780f:	8b 45 08             	mov    0x8(%ebp),%eax
80107812:	e8 79 f7 ff ff       	call   80106f90 <walkpgdir>
  if((*pte & PTE_P) == 0)
80107817:	8b 00                	mov    (%eax),%eax
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
}
80107819:	c9                   	leave  
  if((*pte & PTE_U) == 0)
8010781a:	89 c2                	mov    %eax,%edx
  return (char*)P2V(PTE_ADDR(*pte));
8010781c:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((*pte & PTE_U) == 0)
80107821:	83 e2 05             	and    $0x5,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80107824:	05 00 00 00 80       	add    $0x80000000,%eax
80107829:	83 fa 05             	cmp    $0x5,%edx
8010782c:	ba 00 00 00 00       	mov    $0x0,%edx
80107831:	0f 45 c2             	cmovne %edx,%eax
}
80107834:	c3                   	ret    
80107835:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010783c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80107840 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80107840:	f3 0f 1e fb          	endbr32 
80107844:	55                   	push   %ebp
80107845:	89 e5                	mov    %esp,%ebp
80107847:	57                   	push   %edi
80107848:	56                   	push   %esi
80107849:	53                   	push   %ebx
8010784a:	83 ec 0c             	sub    $0xc,%esp
8010784d:	8b 75 14             	mov    0x14(%ebp),%esi
80107850:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80107853:	85 f6                	test   %esi,%esi
80107855:	75 3c                	jne    80107893 <copyout+0x53>
80107857:	eb 67                	jmp    801078c0 <copyout+0x80>
80107859:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
80107860:	8b 55 0c             	mov    0xc(%ebp),%edx
80107863:	89 fb                	mov    %edi,%ebx
80107865:	29 d3                	sub    %edx,%ebx
80107867:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    if(n > len)
8010786d:	39 f3                	cmp    %esi,%ebx
8010786f:	0f 47 de             	cmova  %esi,%ebx
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80107872:	29 fa                	sub    %edi,%edx
80107874:	83 ec 04             	sub    $0x4,%esp
80107877:	01 c2                	add    %eax,%edx
80107879:	53                   	push   %ebx
8010787a:	ff 75 10             	pushl  0x10(%ebp)
8010787d:	52                   	push   %edx
8010787e:	e8 7d d5 ff ff       	call   80104e00 <memmove>
    len -= n;
    buf += n;
80107883:	01 5d 10             	add    %ebx,0x10(%ebp)
    va = va0 + PGSIZE;
80107886:	8d 97 00 10 00 00    	lea    0x1000(%edi),%edx
  while(len > 0){
8010788c:	83 c4 10             	add    $0x10,%esp
8010788f:	29 de                	sub    %ebx,%esi
80107891:	74 2d                	je     801078c0 <copyout+0x80>
    va0 = (uint)PGROUNDDOWN(va);
80107893:	89 d7                	mov    %edx,%edi
    pa0 = uva2ka(pgdir, (char*)va0);
80107895:	83 ec 08             	sub    $0x8,%esp
    va0 = (uint)PGROUNDDOWN(va);
80107898:	89 55 0c             	mov    %edx,0xc(%ebp)
8010789b:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
    pa0 = uva2ka(pgdir, (char*)va0);
801078a1:	57                   	push   %edi
801078a2:	ff 75 08             	pushl  0x8(%ebp)
801078a5:	e8 56 ff ff ff       	call   80107800 <uva2ka>
    if(pa0 == 0)
801078aa:	83 c4 10             	add    $0x10,%esp
801078ad:	85 c0                	test   %eax,%eax
801078af:	75 af                	jne    80107860 <copyout+0x20>
  }
  return 0;
}
801078b1:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
801078b4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801078b9:	5b                   	pop    %ebx
801078ba:	5e                   	pop    %esi
801078bb:	5f                   	pop    %edi
801078bc:	5d                   	pop    %ebp
801078bd:	c3                   	ret    
801078be:	66 90                	xchg   %ax,%ax
801078c0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801078c3:	31 c0                	xor    %eax,%eax
}
801078c5:	5b                   	pop    %ebx
801078c6:	5e                   	pop    %esi
801078c7:	5f                   	pop    %edi
801078c8:	5d                   	pop    %ebp
801078c9:	c3                   	ret    
