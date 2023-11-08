
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
80100050:	68 40 78 10 80       	push   $0x80107840
80100055:	68 40 d2 10 80       	push   $0x8010d240
8010005a:	e8 31 4a 00 00       	call   80104a90 <initlock>
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
80100092:	68 47 78 10 80       	push   $0x80107847
80100097:	50                   	push   %eax
80100098:	e8 b3 48 00 00       	call   80104950 <initsleeplock>
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
801000e8:	e8 23 4b 00 00       	call   80104c10 <acquire>
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
80100162:	e8 69 4b 00 00       	call   80104cd0 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 1e 48 00 00       	call   80104990 <acquiresleep>
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
801001a3:	68 4e 78 10 80       	push   $0x8010784e
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
801001c2:	e8 69 48 00 00       	call   80104a30 <holdingsleep>
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
801001e0:	68 5f 78 10 80       	push   $0x8010785f
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
80100203:	e8 28 48 00 00       	call   80104a30 <holdingsleep>
80100208:	83 c4 10             	add    $0x10,%esp
8010020b:	85 c0                	test   %eax,%eax
8010020d:	74 66                	je     80100275 <brelse+0x85>
    panic("brelse");

  releasesleep(&b->lock);
8010020f:	83 ec 0c             	sub    $0xc,%esp
80100212:	56                   	push   %esi
80100213:	e8 d8 47 00 00       	call   801049f0 <releasesleep>

  acquire(&bcache.lock);
80100218:	c7 04 24 40 d2 10 80 	movl   $0x8010d240,(%esp)
8010021f:	e8 ec 49 00 00       	call   80104c10 <acquire>
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
80100270:	e9 5b 4a 00 00       	jmp    80104cd0 <release>
    panic("brelse");
80100275:	83 ec 0c             	sub    $0xc,%esp
80100278:	68 66 78 10 80       	push   $0x80107866
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
801002b7:	e8 54 49 00 00       	call   80104c10 <acquire>
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
801002ed:	e8 6e 42 00 00       	call   80104560 <sleep>
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
80100317:	e8 b4 49 00 00       	call   80104cd0 <release>
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
80100379:	e8 52 49 00 00       	call   80104cd0 <release>
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
801003d6:	68 6d 78 10 80       	push   $0x8010786d
801003db:	e8 c0 03 00 00       	call   801007a0 <cprintf>
  cprintf(s);
801003e0:	58                   	pop    %eax
801003e1:	ff 75 08             	pushl  0x8(%ebp)
801003e4:	e8 b7 03 00 00       	call   801007a0 <cprintf>
  cprintf("\n");
801003e9:	c7 04 24 03 82 10 80 	movl   $0x80108203,(%esp)
801003f0:	e8 ab 03 00 00       	call   801007a0 <cprintf>
  getcallerpcs(&s, pcs);
801003f5:	8d 45 08             	lea    0x8(%ebp),%eax
801003f8:	5a                   	pop    %edx
801003f9:	59                   	pop    %ecx
801003fa:	53                   	push   %ebx
801003fb:	50                   	push   %eax
801003fc:	e8 af 46 00 00       	call   80104ab0 <getcallerpcs>
  for (i = 0; i < 10; i++)
80100401:	83 c4 10             	add    $0x10,%esp
    cprintf(" %p", pcs[i]);
80100404:	83 ec 08             	sub    $0x8,%esp
80100407:	ff 33                	pushl  (%ebx)
80100409:	83 c3 04             	add    $0x4,%ebx
8010040c:	68 81 78 10 80       	push   $0x80107881
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
80100592:	e8 29 48 00 00       	call   80104dc0 <memmove>
    memset(crt + pos, 0, sizeof(crt[0]) * (24 * 80 - pos));
80100597:	b8 80 07 00 00       	mov    $0x780,%eax
8010059c:	83 c4 0c             	add    $0xc,%esp
8010059f:	29 f0                	sub    %esi,%eax
801005a1:	01 c0                	add    %eax,%eax
801005a3:	50                   	push   %eax
801005a4:	8d 84 36 00 80 0b 80 	lea    -0x7ff48000(%esi,%esi,1),%eax
801005ab:	6a 00                	push   $0x0
801005ad:	50                   	push   %eax
801005ae:	e8 6d 47 00 00       	call   80104d20 <memset>
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
80100601:	e8 ba 47 00 00       	call   80104dc0 <memmove>
    memset(crt + pos, 0, sizeof(crt[0]) * (25 * 80 - pos));
80100606:	83 c4 0c             	add    $0xc,%esp
80100609:	68 9c 0f 00 00       	push   $0xf9c
8010060e:	6a 00                	push   $0x0
80100610:	68 04 80 0b 80       	push   $0x800b8004
80100615:	e8 06 47 00 00       	call   80104d20 <memset>
8010061a:	83 c4 10             	add    $0x10,%esp
8010061d:	e9 d2 fe ff ff       	jmp    801004f4 <cgaputc+0xc4>
    panic("pos under/overflow");
80100622:	83 ec 0c             	sub    $0xc,%esp
80100625:	68 85 78 10 80       	push   $0x80107885
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
80100657:	e8 d4 5d 00 00       	call   80106430 <uartputc>
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
80100678:	e8 b3 5d 00 00       	call   80106430 <uartputc>
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
801006b9:	0f b6 92 08 79 10 80 	movzbl -0x7fef86f8(%edx),%edx
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
8010074f:	e8 bc 44 00 00       	call   80104c10 <acquire>
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
80100787:	e8 44 45 00 00       	call   80104cd0 <release>
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
8010086d:	bb 98 78 10 80       	mov    $0x80107898,%ebx
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
801008ad:	e8 5e 43 00 00       	call   80104c10 <acquire>
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
80100918:	e8 b3 43 00 00       	call   80104cd0 <release>
8010091d:	83 c4 10             	add    $0x10,%esp
}
80100920:	e9 ee fe ff ff       	jmp    80100813 <cprintf+0x73>
    panic("null fmt");
80100925:	83 ec 0c             	sub    $0xc,%esp
80100928:	68 9f 78 10 80       	push   $0x8010789f
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
80100b5f:	e8 bc 41 00 00       	call   80104d20 <memset>
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
80100c65:	e8 b6 40 00 00       	call   80104d20 <memset>
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
80100d2d:	e9 ee 39 00 00       	jmp    80104720 <wakeup>
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
80100d5a:	e8 b1 3e 00 00       	call   80104c10 <acquire>
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
80100d88:	3e ff 24 9d b0 78 10 	notrack jmp *-0x7fef8750(,%ebx,4)
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
80100da8:	e8 23 3f 00 00       	call   80104cd0 <release>
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
80100f8f:	e9 7c 38 00 00       	jmp    80104810 <procdump>
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
8010107a:	68 a8 78 10 80       	push   $0x801078a8
8010107f:	68 a0 c1 10 80       	push   $0x8010c1a0
80101084:	e8 07 3a 00 00       	call   80104a90 <initlock>

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
8010114c:	e8 4f 64 00 00       	call   801075a0 <setupkvm>
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
801011b3:	e8 08 62 00 00       	call   801073c0 <allocuvm>
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
801011e9:	e8 02 61 00 00       	call   801072f0 <loaduvm>
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
8010122b:	e8 f0 62 00 00       	call   80107520 <freevm>
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
80101272:	e8 49 61 00 00       	call   801073c0 <allocuvm>
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
80101293:	e8 a8 63 00 00       	call   80107640 <clearpteu>
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
801012e3:	e8 38 3c 00 00       	call   80104f20 <strlen>
801012e8:	f7 d0                	not    %eax
801012ea:	01 c3                	add    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
801012ec:	58                   	pop    %eax
801012ed:	8b 45 0c             	mov    0xc(%ebp),%eax
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
801012f0:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
801012f3:	ff 34 b8             	pushl  (%eax,%edi,4)
801012f6:	e8 25 3c 00 00       	call   80104f20 <strlen>
801012fb:	83 c0 01             	add    $0x1,%eax
801012fe:	50                   	push   %eax
801012ff:	8b 45 0c             	mov    0xc(%ebp),%eax
80101302:	ff 34 b8             	pushl  (%eax,%edi,4)
80101305:	53                   	push   %ebx
80101306:	56                   	push   %esi
80101307:	e8 94 64 00 00       	call   801077a0 <copyout>
8010130c:	83 c4 20             	add    $0x20,%esp
8010130f:	85 c0                	test   %eax,%eax
80101311:	79 ad                	jns    801012c0 <exec+0x200>
80101313:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101317:	90                   	nop
    freevm(pgdir);
80101318:	83 ec 0c             	sub    $0xc,%esp
8010131b:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80101321:	e8 fa 61 00 00       	call   80107520 <freevm>
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
80101373:	e8 28 64 00 00       	call   801077a0 <copyout>
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
801013ad:	83 c0 6c             	add    $0x6c,%eax
801013b0:	50                   	push   %eax
801013b1:	e8 2a 3b 00 00       	call   80104ee0 <safestrcpy>
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
801013dd:	e8 7e 5d 00 00       	call   80107160 <switchuvm>
  freevm(oldpgdir);
801013e2:	89 3c 24             	mov    %edi,(%esp)
801013e5:	e8 36 61 00 00       	call   80107520 <freevm>
  return 0;
801013ea:	83 c4 10             	add    $0x10,%esp
801013ed:	31 c0                	xor    %eax,%eax
801013ef:	e9 3c fd ff ff       	jmp    80101130 <exec+0x70>
    end_op();
801013f4:	e8 e7 1f 00 00       	call   801033e0 <end_op>
    cprintf("exec: fail\n");
801013f9:	83 ec 0c             	sub    $0xc,%esp
801013fc:	68 19 79 10 80       	push   $0x80107919
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
8010142a:	68 25 79 10 80       	push   $0x80107925
8010142f:	68 00 1c 11 80       	push   $0x80111c00
80101434:	e8 57 36 00 00       	call   80104a90 <initlock>
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
80101455:	e8 b6 37 00 00       	call   80104c10 <acquire>
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
80101481:	e8 4a 38 00 00       	call   80104cd0 <release>
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
8010149a:	e8 31 38 00 00       	call   80104cd0 <release>
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
801014c3:	e8 48 37 00 00       	call   80104c10 <acquire>
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
801014e0:	e8 eb 37 00 00       	call   80104cd0 <release>
  return f;
}
801014e5:	89 d8                	mov    %ebx,%eax
801014e7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801014ea:	c9                   	leave  
801014eb:	c3                   	ret    
    panic("filedup");
801014ec:	83 ec 0c             	sub    $0xc,%esp
801014ef:	68 2c 79 10 80       	push   $0x8010792c
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
80101515:	e8 f6 36 00 00       	call   80104c10 <acquire>
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
80101550:	e8 7b 37 00 00       	call   80104cd0 <release>

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
8010157e:	e9 4d 37 00 00       	jmp    80104cd0 <release>
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
801015cc:	68 34 79 10 80       	push   $0x80107934
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
801016ba:	68 3e 79 10 80       	push   $0x8010793e
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
801017a3:	68 47 79 10 80       	push   $0x80107947
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
801017d9:	68 4d 79 10 80       	push   $0x8010794d
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
80101857:	68 57 79 10 80       	push   $0x80107957
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
80101914:	68 6a 79 10 80       	push   $0x8010796a
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
80101955:	e8 c6 33 00 00       	call   80104d20 <memset>
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
8010199a:	e8 71 32 00 00       	call   80104c10 <acquire>
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
80101a07:	e8 c4 32 00 00       	call   80104cd0 <release>

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
80101a35:	e8 96 32 00 00       	call   80104cd0 <release>
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
80101a62:	68 80 79 10 80       	push   $0x80107980
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
80101b2b:	68 90 79 10 80       	push   $0x80107990
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
80101b65:	e8 56 32 00 00       	call   80104dc0 <memmove>
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
80101b90:	68 a3 79 10 80       	push   $0x801079a3
80101b95:	68 20 26 11 80       	push   $0x80112620
80101b9a:	e8 f1 2e 00 00       	call   80104a90 <initlock>
  for(i = 0; i < NINODE; i++) {
80101b9f:	83 c4 10             	add    $0x10,%esp
80101ba2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    initsleeplock(&icache.inode[i].lock, "inode");
80101ba8:	83 ec 08             	sub    $0x8,%esp
80101bab:	68 aa 79 10 80       	push   $0x801079aa
80101bb0:	53                   	push   %ebx
80101bb1:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101bb7:	e8 94 2d 00 00       	call   80104950 <initsleeplock>
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
80101c01:	68 10 7a 10 80       	push   $0x80107a10
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
80101c9e:	e8 7d 30 00 00       	call   80104d20 <memset>
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
80101cd3:	68 b0 79 10 80       	push   $0x801079b0
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
80101d45:	e8 76 30 00 00       	call   80104dc0 <memmove>
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
80101d83:	e8 88 2e 00 00       	call   80104c10 <acquire>
  ip->ref++;
80101d88:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
80101d8c:	c7 04 24 20 26 11 80 	movl   $0x80112620,(%esp)
80101d93:	e8 38 2f 00 00       	call   80104cd0 <release>
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
80101dc6:	e8 c5 2b 00 00       	call   80104990 <acquiresleep>
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
80101e38:	e8 83 2f 00 00       	call   80104dc0 <memmove>
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
80101e5d:	68 c8 79 10 80       	push   $0x801079c8
80101e62:	e8 49 e5 ff ff       	call   801003b0 <panic>
    panic("ilock");
80101e67:	83 ec 0c             	sub    $0xc,%esp
80101e6a:	68 c2 79 10 80       	push   $0x801079c2
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
80101e97:	e8 94 2b 00 00       	call   80104a30 <holdingsleep>
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
80101eb3:	e9 38 2b 00 00       	jmp    801049f0 <releasesleep>
    panic("iunlock");
80101eb8:	83 ec 0c             	sub    $0xc,%esp
80101ebb:	68 d7 79 10 80       	push   $0x801079d7
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
80101ee4:	e8 a7 2a 00 00       	call   80104990 <acquiresleep>
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
80101efe:	e8 ed 2a 00 00       	call   801049f0 <releasesleep>
  acquire(&icache.lock);
80101f03:	c7 04 24 20 26 11 80 	movl   $0x80112620,(%esp)
80101f0a:	e8 01 2d 00 00       	call   80104c10 <acquire>
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
80101f24:	e9 a7 2d 00 00       	jmp    80104cd0 <release>
80101f29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    acquire(&icache.lock);
80101f30:	83 ec 0c             	sub    $0xc,%esp
80101f33:	68 20 26 11 80       	push   $0x80112620
80101f38:	e8 d3 2c 00 00       	call   80104c10 <acquire>
    int r = ip->ref;
80101f3d:	8b 73 08             	mov    0x8(%ebx),%esi
    release(&icache.lock);
80101f40:	c7 04 24 20 26 11 80 	movl   $0x80112620,(%esp)
80101f47:	e8 84 2d 00 00       	call   80104cd0 <release>
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
80102147:	e8 74 2c 00 00       	call   80104dc0 <memmove>
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
80102243:	e8 78 2b 00 00       	call   80104dc0 <memmove>
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
801022e2:	e8 49 2b 00 00       	call   80104e30 <strncmp>
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
80102345:	e8 e6 2a 00 00       	call   80104e30 <strncmp>
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
8010238a:	68 f1 79 10 80       	push   $0x801079f1
8010238f:	e8 1c e0 ff ff       	call   801003b0 <panic>
    panic("dirlookup not DIR");
80102394:	83 ec 0c             	sub    $0xc,%esp
80102397:	68 df 79 10 80       	push   $0x801079df
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
801023dc:	e8 2f 28 00 00       	call   80104c10 <acquire>
  ip->ref++;
801023e1:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
801023e5:	c7 04 24 20 26 11 80 	movl   $0x80112620,(%esp)
801023ec:	e8 df 28 00 00       	call   80104cd0 <release>
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
80102457:	e8 64 29 00 00       	call   80104dc0 <memmove>
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
801024e3:	e8 d8 28 00 00       	call   80104dc0 <memmove>
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
80102615:	e8 66 28 00 00       	call   80104e80 <strncpy>
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
80102653:	68 00 7a 10 80       	push   $0x80107a00
80102658:	e8 53 dd ff ff       	call   801003b0 <panic>
    panic("dirlink");
8010265d:	83 ec 0c             	sub    $0xc,%esp
80102660:	68 ea 7f 10 80       	push   $0x80107fea
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
8010276b:	68 6c 7a 10 80       	push   $0x80107a6c
80102770:	e8 3b dc ff ff       	call   801003b0 <panic>
    panic("idestart");
80102775:	83 ec 0c             	sub    $0xc,%esp
80102778:	68 63 7a 10 80       	push   $0x80107a63
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
8010279a:	68 7e 7a 10 80       	push   $0x80107a7e
8010279f:	68 00 c2 10 80       	push   $0x8010c200
801027a4:	e8 e7 22 00 00       	call   80104a90 <initlock>
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
80102832:	e8 d9 23 00 00       	call   80104c10 <acquire>

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
8010288d:	e8 8e 1e 00 00       	call   80104720 <wakeup>

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
801028ab:	e8 20 24 00 00       	call   80104cd0 <release>

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
801028d2:	e8 59 21 00 00       	call   80104a30 <holdingsleep>
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
8010290c:	e8 ff 22 00 00       	call   80104c10 <acquire>

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
80102959:	e8 02 1c 00 00       	call   80104560 <sleep>
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
80102976:	e9 55 23 00 00       	jmp    80104cd0 <release>
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
8010299a:	68 ad 7a 10 80       	push   $0x80107aad
8010299f:	e8 0c da ff ff       	call   801003b0 <panic>
    panic("iderw: nothing to do");
801029a4:	83 ec 0c             	sub    $0xc,%esp
801029a7:	68 98 7a 10 80       	push   $0x80107a98
801029ac:	e8 ff d9 ff ff       	call   801003b0 <panic>
    panic("iderw: buf not locked");
801029b1:	83 ec 0c             	sub    $0xc,%esp
801029b4:	68 82 7a 10 80       	push   $0x80107a82
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
80102a0e:	68 cc 7a 10 80       	push   $0x80107acc
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
80102ac6:	81 fb e8 70 11 80    	cmp    $0x801170e8,%ebx
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
80102ae6:	e8 35 22 00 00       	call   80104d20 <memset>

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
80102b20:	e8 eb 20 00 00       	call   80104c10 <acquire>
80102b25:	83 c4 10             	add    $0x10,%esp
80102b28:	eb ce                	jmp    80102af8 <kfree+0x48>
80102b2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    release(&kmem.lock);
80102b30:	c7 45 08 80 42 11 80 	movl   $0x80114280,0x8(%ebp)
}
80102b37:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102b3a:	c9                   	leave  
    release(&kmem.lock);
80102b3b:	e9 90 21 00 00       	jmp    80104cd0 <release>
    panic("kfree");
80102b40:	83 ec 0c             	sub    $0xc,%esp
80102b43:	68 fe 7a 10 80       	push   $0x80107afe
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
80102baf:	68 04 7b 10 80       	push   $0x80107b04
80102bb4:	68 80 42 11 80       	push   $0x80114280
80102bb9:	e8 d2 1e 00 00       	call   80104a90 <initlock>
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
80102ca3:	e8 68 1f 00 00       	call   80104c10 <acquire>
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
80102cd1:	e8 fa 1f 00 00       	call   80104cd0 <release>
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
80102d1f:	0f b6 8a 40 7c 10 80 	movzbl -0x7fef83c0(%edx),%ecx
  shift ^= togglecode[data];
80102d26:	0f b6 82 40 7b 10 80 	movzbl -0x7fef84c0(%edx),%eax
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
80102d3f:	8b 04 85 20 7b 10 80 	mov    -0x7fef84e0(,%eax,4),%eax
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
80102d7a:	0f b6 8a 40 7c 10 80 	movzbl -0x7fef83c0(%edx),%ecx
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
801030ff:	e8 6c 1c 00 00       	call   80104d70 <memcmp>
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
80103234:	e8 87 1b 00 00       	call   80104dc0 <memmove>
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
801032de:	68 40 7d 10 80       	push   $0x80107d40
801032e3:	68 c0 42 11 80       	push   $0x801142c0
801032e8:	e8 a3 17 00 00       	call   80104a90 <initlock>
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
8010337f:	e8 8c 18 00 00       	call   80104c10 <acquire>
80103384:	83 c4 10             	add    $0x10,%esp
80103387:	eb 1c                	jmp    801033a5 <begin_op+0x35>
80103389:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80103390:	83 ec 08             	sub    $0x8,%esp
80103393:	68 c0 42 11 80       	push   $0x801142c0
80103398:	68 c0 42 11 80       	push   $0x801142c0
8010339d:	e8 be 11 00 00       	call   80104560 <sleep>
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
801033d4:	e8 f7 18 00 00       	call   80104cd0 <release>
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
801033f2:	e8 19 18 00 00       	call   80104c10 <acquire>
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
80103430:	e8 9b 18 00 00       	call   80104cd0 <release>
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
8010344a:	e8 c1 17 00 00       	call   80104c10 <acquire>
    wakeup(&log);
8010344f:	c7 04 24 c0 42 11 80 	movl   $0x801142c0,(%esp)
    log.committing = 0;
80103456:	c7 05 00 43 11 80 00 	movl   $0x0,0x80114300
8010345d:	00 00 00 
    wakeup(&log);
80103460:	e8 bb 12 00 00       	call   80104720 <wakeup>
    release(&log.lock);
80103465:	c7 04 24 c0 42 11 80 	movl   $0x801142c0,(%esp)
8010346c:	e8 5f 18 00 00       	call   80104cd0 <release>
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
801034c4:	e8 f7 18 00 00       	call   80104dc0 <memmove>
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
80103518:	e8 03 12 00 00       	call   80104720 <wakeup>
  release(&log.lock);
8010351d:	c7 04 24 c0 42 11 80 	movl   $0x801142c0,(%esp)
80103524:	e8 a7 17 00 00       	call   80104cd0 <release>
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
80103537:	68 44 7d 10 80       	push   $0x80107d44
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
80103592:	e8 79 16 00 00       	call   80104c10 <acquire>
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
801035d5:	e9 f6 16 00 00       	jmp    80104cd0 <release>
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
80103601:	68 53 7d 10 80       	push   $0x80107d53
80103606:	e8 a5 cd ff ff       	call   801003b0 <panic>
    panic("log_write outside of trans");
8010360b:	83 ec 0c             	sub    $0xc,%esp
8010360e:	68 69 7d 10 80       	push   $0x80107d69
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
80103638:	68 84 7d 10 80       	push   $0x80107d84
8010363d:	e8 5e d1 ff ff       	call   801007a0 <cprintf>
  idtinit();       // load idt register
80103642:	e8 29 2a 00 00       	call   80106070 <idtinit>
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
8010365a:	e8 11 0c 00 00       	call   80104270 <scheduler>
8010365f:	90                   	nop

80103660 <mpenter>:
{
80103660:	f3 0f 1e fb          	endbr32 
80103664:	55                   	push   %ebp
80103665:	89 e5                	mov    %esp,%ebp
80103667:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
8010366a:	e8 d1 3a 00 00       	call   80107140 <switchkvm>
  seginit();
8010366f:	e8 3c 3a 00 00       	call   801070b0 <seginit>
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
8010369b:	68 e8 70 11 80       	push   $0x801170e8
801036a0:	e8 fb f4 ff ff       	call   80102ba0 <kinit1>
  kvmalloc();      // kernel page table
801036a5:	e8 76 3f 00 00       	call   80107620 <kvmalloc>
  mpinit();        // detect other processors
801036aa:	e8 81 01 00 00       	call   80103830 <mpinit>
  lapicinit();     // interrupt controller
801036af:	e8 2c f7 ff ff       	call   80102de0 <lapicinit>
  seginit();       // segment descriptors
801036b4:	e8 f7 39 00 00       	call   801070b0 <seginit>
  picinit();       // disable pic
801036b9:	e8 52 03 00 00       	call   80103a10 <picinit>
  ioapicinit();    // another interrupt controller
801036be:	e8 fd f2 ff ff       	call   801029c0 <ioapicinit>
  consoleinit();   // console hardware
801036c3:	e8 a8 d9 ff ff       	call   80101070 <consoleinit>
  uartinit();      // serial port
801036c8:	e8 a3 2c 00 00       	call   80106370 <uartinit>
  pinit();         // process table
801036cd:	e8 1e 08 00 00       	call   80103ef0 <pinit>
  tvinit();        // trap vectors
801036d2:	e8 19 29 00 00       	call   80105ff0 <tvinit>
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
801036f8:	e8 c3 16 00 00       	call   80104dc0 <memmove>

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
801037de:	68 98 7d 10 80       	push   $0x80107d98
801037e3:	56                   	push   %esi
801037e4:	e8 87 15 00 00       	call   80104d70 <memcmp>
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
8010389a:	68 9d 7d 10 80       	push   $0x80107d9d
8010389f:	50                   	push   %eax
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
801038a0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(memcmp(conf, "PCMP", 4) != 0)
801038a3:	e8 c8 14 00 00       	call   80104d70 <memcmp>
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
801039f3:	68 a2 7d 10 80       	push   $0x80107da2
801039f8:	e8 b3 c9 ff ff       	call   801003b0 <panic>
    panic("Didn't find a suitable machine");
801039fd:	83 ec 0c             	sub    $0xc,%esp
80103a00:	68 bc 7d 10 80       	push   $0x80107dbc
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
80103aa7:	68 db 7d 10 80       	push   $0x80107ddb
80103aac:	50                   	push   %eax
80103aad:	e8 de 0f 00 00       	call   80104a90 <initlock>
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
80103b53:	e8 b8 10 00 00       	call   80104c10 <acquire>
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
80103b73:	e8 a8 0b 00 00       	call   80104720 <wakeup>
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
80103b98:	e9 33 11 00 00       	jmp    80104cd0 <release>
80103b9d:	8d 76 00             	lea    0x0(%esi),%esi
    wakeup(&p->nwrite);
80103ba0:	83 ec 0c             	sub    $0xc,%esp
80103ba3:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
    p->readopen = 0;
80103ba9:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
80103bb0:	00 00 00 
    wakeup(&p->nwrite);
80103bb3:	50                   	push   %eax
80103bb4:	e8 67 0b 00 00       	call   80104720 <wakeup>
80103bb9:	83 c4 10             	add    $0x10,%esp
80103bbc:	eb bd                	jmp    80103b7b <pipeclose+0x3b>
80103bbe:	66 90                	xchg   %ax,%ax
    release(&p->lock);
80103bc0:	83 ec 0c             	sub    $0xc,%esp
80103bc3:	53                   	push   %ebx
80103bc4:	e8 07 11 00 00       	call   80104cd0 <release>
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
80103bf1:	e8 1a 10 00 00       	call   80104c10 <acquire>
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
80103c48:	e8 d3 0a 00 00       	call   80104720 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103c4d:	58                   	pop    %eax
80103c4e:	5a                   	pop    %edx
80103c4f:	53                   	push   %ebx
80103c50:	56                   	push   %esi
80103c51:	e8 0a 09 00 00       	call   80104560 <sleep>
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
80103c7c:	e8 4f 10 00 00       	call   80104cd0 <release>
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
80103cca:	e8 51 0a 00 00       	call   80104720 <wakeup>
  release(&p->lock);
80103ccf:	89 1c 24             	mov    %ebx,(%esp)
80103cd2:	e8 f9 0f 00 00       	call   80104cd0 <release>
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
80103cfa:	e8 11 0f 00 00       	call   80104c10 <acquire>
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
80103d2d:	e8 2e 08 00 00       	call   80104560 <sleep>
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
80103d96:	e8 85 09 00 00       	call   80104720 <wakeup>
  release(&p->lock);
80103d9b:	89 34 24             	mov    %esi,(%esp)
80103d9e:	e8 2d 0f 00 00       	call   80104cd0 <release>
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
80103db9:	e8 12 0f 00 00       	call   80104cd0 <release>
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
80103de1:	e8 2a 0e 00 00       	call   80104c10 <acquire>
80103de6:	83 c4 10             	add    $0x10,%esp
80103de9:	eb 10                	jmp    80103dfb <allocproc+0x2b>
80103deb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103def:	90                   	nop
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103df0:	83 c3 7c             	add    $0x7c,%ebx
80103df3:	81 fb 94 68 11 80    	cmp    $0x80116894,%ebx
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
80103e22:	e8 a9 0e 00 00       	call   80104cd0 <release>

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
80103e47:	c7 40 14 e5 5f 10 80 	movl   $0x80105fe5,0x14(%eax)
  p->context = (struct context *)sp;
80103e4e:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
80103e51:	6a 14                	push   $0x14
80103e53:	6a 00                	push   $0x0
80103e55:	50                   	push   %eax
80103e56:	e8 c5 0e 00 00       	call   80104d20 <memset>
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
80103e7a:	e8 51 0e 00 00       	call   80104cd0 <release>
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
80103eaf:	e8 1c 0e 00 00       	call   80104cd0 <release>

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
80103efa:	68 e0 7d 10 80       	push   $0x80107de0
80103eff:	68 60 49 11 80       	push   $0x80114960
80103f04:	e8 87 0b 00 00       	call   80104a90 <initlock>
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
80103f60:	68 e7 7d 10 80       	push   $0x80107de7
80103f65:	e8 46 c4 ff ff       	call   801003b0 <panic>
    panic("mycpu called with interrupts enabled\n");
80103f6a:	83 ec 0c             	sub    $0xc,%esp
80103f6d:	68 c4 7e 10 80       	push   $0x80107ec4
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
80103fab:	e8 60 0b 00 00       	call   80104b10 <pushcli>
  c = mycpu();
80103fb0:	e8 5b ff ff ff       	call   80103f10 <mycpu>
  p = c->proc;
80103fb5:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103fbb:	e8 a0 0b 00 00       	call   80104b60 <popcli>
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
80103fe7:	e8 b4 35 00 00       	call   801075a0 <setupkvm>
80103fec:	89 43 04             	mov    %eax,0x4(%ebx)
80103fef:	85 c0                	test   %eax,%eax
80103ff1:	0f 84 bd 00 00 00    	je     801040b4 <userinit+0xe4>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80103ff7:	83 ec 04             	sub    $0x4,%esp
80103ffa:	68 2c 00 00 00       	push   $0x2c
80103fff:	68 60 b4 10 80       	push   $0x8010b460
80104004:	50                   	push   %eax
80104005:	e8 66 32 00 00       	call   80107270 <inituvm>
  memset(p->tf, 0, sizeof(*p->tf));
8010400a:	83 c4 0c             	add    $0xc,%esp
  p->sz = PGSIZE;
8010400d:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
80104013:	6a 4c                	push   $0x4c
80104015:	6a 00                	push   $0x0
80104017:	ff 73 18             	pushl  0x18(%ebx)
8010401a:	e8 01 0d 00 00       	call   80104d20 <memset>
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
8010406e:	8d 43 6c             	lea    0x6c(%ebx),%eax
80104071:	6a 10                	push   $0x10
80104073:	68 10 7e 10 80       	push   $0x80107e10
80104078:	50                   	push   %eax
80104079:	e8 62 0e 00 00       	call   80104ee0 <safestrcpy>
  p->cwd = namei("/");
8010407e:	c7 04 24 19 7e 10 80 	movl   $0x80107e19,(%esp)
80104085:	e8 e6 e5 ff ff       	call   80102670 <namei>
8010408a:	89 43 68             	mov    %eax,0x68(%ebx)
  acquire(&ptable.lock);
8010408d:	c7 04 24 60 49 11 80 	movl   $0x80114960,(%esp)
80104094:	e8 77 0b 00 00       	call   80104c10 <acquire>
  p->state = RUNNABLE;
80104099:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
801040a0:	c7 04 24 60 49 11 80 	movl   $0x80114960,(%esp)
801040a7:	e8 24 0c 00 00       	call   80104cd0 <release>
}
801040ac:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801040af:	83 c4 10             	add    $0x10,%esp
801040b2:	c9                   	leave  
801040b3:	c3                   	ret    
    panic("userinit: out of memory?");
801040b4:	83 ec 0c             	sub    $0xc,%esp
801040b7:	68 f7 7d 10 80       	push   $0x80107df7
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
801040dc:	e8 2f 0a 00 00       	call   80104b10 <pushcli>
  c = mycpu();
801040e1:	e8 2a fe ff ff       	call   80103f10 <mycpu>
  p = c->proc;
801040e6:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801040ec:	e8 6f 0a 00 00       	call   80104b60 <popcli>
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
801040ff:	e8 5c 30 00 00       	call   80107160 <switchuvm>
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
8010411a:	e8 a1 32 00 00       	call   801073c0 <allocuvm>
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
8010413a:	e8 b1 33 00 00       	call   801074f0 <deallocuvm>
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
8010415d:	e8 ae 09 00 00       	call   80104b10 <pushcli>
  c = mycpu();
80104162:	e8 a9 fd ff ff       	call   80103f10 <mycpu>
  p = c->proc;
80104167:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
8010416d:	e8 ee 09 00 00       	call   80104b60 <popcli>
  if ((np = allocproc()) == 0)
80104172:	e8 59 fc ff ff       	call   80103dd0 <allocproc>
80104177:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010417a:	85 c0                	test   %eax,%eax
8010417c:	0f 84 bb 00 00 00    	je     8010423d <fork+0xed>
  if ((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0)
80104182:	83 ec 08             	sub    $0x8,%esp
80104185:	ff 33                	pushl  (%ebx)
80104187:	89 c7                	mov    %eax,%edi
80104189:	ff 73 04             	pushl  0x4(%ebx)
8010418c:	e8 df 34 00 00       	call   80107670 <copyuvm>
80104191:	83 c4 10             	add    $0x10,%esp
80104194:	89 47 04             	mov    %eax,0x4(%edi)
80104197:	85 c0                	test   %eax,%eax
80104199:	0f 84 a5 00 00 00    	je     80104244 <fork+0xf4>
  np->sz = curproc->sz;
8010419f:	8b 03                	mov    (%ebx),%eax
801041a1:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801041a4:	89 01                	mov    %eax,(%ecx)
  *np->tf = *curproc->tf;
801041a6:	8b 79 18             	mov    0x18(%ecx),%edi
  np->parent = curproc;
801041a9:	89 c8                	mov    %ecx,%eax
801041ab:	89 59 14             	mov    %ebx,0x14(%ecx)
  *np->tf = *curproc->tf;
801041ae:	b9 13 00 00 00       	mov    $0x13,%ecx
801041b3:	8b 73 18             	mov    0x18(%ebx),%esi
801041b6:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  for (i = 0; i < NOFILE; i++)
801041b8:	31 f6                	xor    %esi,%esi
  np->tf->eax = 0;
801041ba:	8b 40 18             	mov    0x18(%eax),%eax
801041bd:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
  for (i = 0; i < NOFILE; i++)
801041c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if (curproc->ofile[i])
801041c8:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
801041cc:	85 c0                	test   %eax,%eax
801041ce:	74 13                	je     801041e3 <fork+0x93>
      np->ofile[i] = filedup(curproc->ofile[i]);
801041d0:	83 ec 0c             	sub    $0xc,%esp
801041d3:	50                   	push   %eax
801041d4:	e8 d7 d2 ff ff       	call   801014b0 <filedup>
801041d9:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801041dc:	83 c4 10             	add    $0x10,%esp
801041df:	89 44 b2 28          	mov    %eax,0x28(%edx,%esi,4)
  for (i = 0; i < NOFILE; i++)
801041e3:	83 c6 01             	add    $0x1,%esi
801041e6:	83 fe 10             	cmp    $0x10,%esi
801041e9:	75 dd                	jne    801041c8 <fork+0x78>
  np->cwd = idup(curproc->cwd);
801041eb:	83 ec 0c             	sub    $0xc,%esp
801041ee:	ff 73 68             	pushl  0x68(%ebx)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
801041f1:	83 c3 6c             	add    $0x6c,%ebx
  np->cwd = idup(curproc->cwd);
801041f4:	e8 77 db ff ff       	call   80101d70 <idup>
801041f9:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
801041fc:	83 c4 0c             	add    $0xc,%esp
  np->cwd = idup(curproc->cwd);
801041ff:	89 47 68             	mov    %eax,0x68(%edi)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80104202:	8d 47 6c             	lea    0x6c(%edi),%eax
80104205:	6a 10                	push   $0x10
80104207:	53                   	push   %ebx
80104208:	50                   	push   %eax
80104209:	e8 d2 0c 00 00       	call   80104ee0 <safestrcpy>
  pid = np->pid;
8010420e:	8b 5f 10             	mov    0x10(%edi),%ebx
  acquire(&ptable.lock);
80104211:	c7 04 24 60 49 11 80 	movl   $0x80114960,(%esp)
80104218:	e8 f3 09 00 00       	call   80104c10 <acquire>
  np->state = RUNNABLE;
8010421d:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)
  release(&ptable.lock);
80104224:	c7 04 24 60 49 11 80 	movl   $0x80114960,(%esp)
8010422b:	e8 a0 0a 00 00       	call   80104cd0 <release>
  return pid;
80104230:	83 c4 10             	add    $0x10,%esp
}
80104233:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104236:	89 d8                	mov    %ebx,%eax
80104238:	5b                   	pop    %ebx
80104239:	5e                   	pop    %esi
8010423a:	5f                   	pop    %edi
8010423b:	5d                   	pop    %ebp
8010423c:	c3                   	ret    
    return -1;
8010423d:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80104242:	eb ef                	jmp    80104233 <fork+0xe3>
    kfree(np->kstack);
80104244:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80104247:	83 ec 0c             	sub    $0xc,%esp
8010424a:	ff 73 08             	pushl  0x8(%ebx)
8010424d:	e8 5e e8 ff ff       	call   80102ab0 <kfree>
    np->kstack = 0;
80104252:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
    return -1;
80104259:	83 c4 10             	add    $0x10,%esp
    np->state = UNUSED;
8010425c:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return -1;
80104263:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80104268:	eb c9                	jmp    80104233 <fork+0xe3>
8010426a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104270 <scheduler>:
{
80104270:	f3 0f 1e fb          	endbr32 
80104274:	55                   	push   %ebp
80104275:	89 e5                	mov    %esp,%ebp
80104277:	57                   	push   %edi
80104278:	56                   	push   %esi
80104279:	53                   	push   %ebx
8010427a:	83 ec 0c             	sub    $0xc,%esp
  struct cpu *c = mycpu();
8010427d:	e8 8e fc ff ff       	call   80103f10 <mycpu>
  c->proc = 0;
80104282:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80104289:	00 00 00 
  struct cpu *c = mycpu();
8010428c:	89 c6                	mov    %eax,%esi
  c->proc = 0;
8010428e:	8d 78 04             	lea    0x4(%eax),%edi
80104291:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  asm volatile("sti");
80104298:	fb                   	sti    
    acquire(&ptable.lock);
80104299:	83 ec 0c             	sub    $0xc,%esp
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010429c:	bb 94 49 11 80       	mov    $0x80114994,%ebx
    acquire(&ptable.lock);
801042a1:	68 60 49 11 80       	push   $0x80114960
801042a6:	e8 65 09 00 00       	call   80104c10 <acquire>
801042ab:	83 c4 10             	add    $0x10,%esp
801042ae:	66 90                	xchg   %ax,%ax
      if (p->state != RUNNABLE)
801042b0:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
801042b4:	75 33                	jne    801042e9 <scheduler+0x79>
      switchuvm(p);
801042b6:	83 ec 0c             	sub    $0xc,%esp
      c->proc = p;
801042b9:	89 9e ac 00 00 00    	mov    %ebx,0xac(%esi)
      switchuvm(p);
801042bf:	53                   	push   %ebx
801042c0:	e8 9b 2e 00 00       	call   80107160 <switchuvm>
      swtch(&(c->scheduler), p->context);
801042c5:	58                   	pop    %eax
801042c6:	5a                   	pop    %edx
801042c7:	ff 73 1c             	pushl  0x1c(%ebx)
801042ca:	57                   	push   %edi
      p->state = RUNNING;
801042cb:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
      swtch(&(c->scheduler), p->context);
801042d2:	e8 6c 0c 00 00       	call   80104f43 <swtch>
      switchkvm();
801042d7:	e8 64 2e 00 00       	call   80107140 <switchkvm>
      c->proc = 0;
801042dc:	83 c4 10             	add    $0x10,%esp
801042df:	c7 86 ac 00 00 00 00 	movl   $0x0,0xac(%esi)
801042e6:	00 00 00 
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801042e9:	83 c3 7c             	add    $0x7c,%ebx
801042ec:	81 fb 94 68 11 80    	cmp    $0x80116894,%ebx
801042f2:	75 bc                	jne    801042b0 <scheduler+0x40>
    release(&ptable.lock);
801042f4:	83 ec 0c             	sub    $0xc,%esp
801042f7:	68 60 49 11 80       	push   $0x80114960
801042fc:	e8 cf 09 00 00       	call   80104cd0 <release>
    sti();
80104301:	83 c4 10             	add    $0x10,%esp
80104304:	eb 92                	jmp    80104298 <scheduler+0x28>
80104306:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010430d:	8d 76 00             	lea    0x0(%esi),%esi

80104310 <sched>:
{
80104310:	f3 0f 1e fb          	endbr32 
80104314:	55                   	push   %ebp
80104315:	89 e5                	mov    %esp,%ebp
80104317:	56                   	push   %esi
80104318:	53                   	push   %ebx
  pushcli();
80104319:	e8 f2 07 00 00       	call   80104b10 <pushcli>
  c = mycpu();
8010431e:	e8 ed fb ff ff       	call   80103f10 <mycpu>
  p = c->proc;
80104323:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104329:	e8 32 08 00 00       	call   80104b60 <popcli>
  if (!holding(&ptable.lock))
8010432e:	83 ec 0c             	sub    $0xc,%esp
80104331:	68 60 49 11 80       	push   $0x80114960
80104336:	e8 85 08 00 00       	call   80104bc0 <holding>
8010433b:	83 c4 10             	add    $0x10,%esp
8010433e:	85 c0                	test   %eax,%eax
80104340:	74 4f                	je     80104391 <sched+0x81>
  if (mycpu()->ncli != 1)
80104342:	e8 c9 fb ff ff       	call   80103f10 <mycpu>
80104347:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
8010434e:	75 68                	jne    801043b8 <sched+0xa8>
  if (p->state == RUNNING)
80104350:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
80104354:	74 55                	je     801043ab <sched+0x9b>
  asm volatile("pushfl; popl %0" : "=r"(eflags));
80104356:	9c                   	pushf  
80104357:	58                   	pop    %eax
  if (readeflags() & FL_IF)
80104358:	f6 c4 02             	test   $0x2,%ah
8010435b:	75 41                	jne    8010439e <sched+0x8e>
  intena = mycpu()->intena;
8010435d:	e8 ae fb ff ff       	call   80103f10 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
80104362:	83 c3 1c             	add    $0x1c,%ebx
  intena = mycpu()->intena;
80104365:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
8010436b:	e8 a0 fb ff ff       	call   80103f10 <mycpu>
80104370:	83 ec 08             	sub    $0x8,%esp
80104373:	ff 70 04             	pushl  0x4(%eax)
80104376:	53                   	push   %ebx
80104377:	e8 c7 0b 00 00       	call   80104f43 <swtch>
  mycpu()->intena = intena;
8010437c:	e8 8f fb ff ff       	call   80103f10 <mycpu>
}
80104381:	83 c4 10             	add    $0x10,%esp
  mycpu()->intena = intena;
80104384:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
8010438a:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010438d:	5b                   	pop    %ebx
8010438e:	5e                   	pop    %esi
8010438f:	5d                   	pop    %ebp
80104390:	c3                   	ret    
    panic("sched ptable.lock");
80104391:	83 ec 0c             	sub    $0xc,%esp
80104394:	68 1b 7e 10 80       	push   $0x80107e1b
80104399:	e8 12 c0 ff ff       	call   801003b0 <panic>
    panic("sched interruptible");
8010439e:	83 ec 0c             	sub    $0xc,%esp
801043a1:	68 47 7e 10 80       	push   $0x80107e47
801043a6:	e8 05 c0 ff ff       	call   801003b0 <panic>
    panic("sched running");
801043ab:	83 ec 0c             	sub    $0xc,%esp
801043ae:	68 39 7e 10 80       	push   $0x80107e39
801043b3:	e8 f8 bf ff ff       	call   801003b0 <panic>
    panic("sched locks");
801043b8:	83 ec 0c             	sub    $0xc,%esp
801043bb:	68 2d 7e 10 80       	push   $0x80107e2d
801043c0:	e8 eb bf ff ff       	call   801003b0 <panic>
801043c5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801043cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801043d0 <exit>:
{
801043d0:	f3 0f 1e fb          	endbr32 
801043d4:	55                   	push   %ebp
801043d5:	89 e5                	mov    %esp,%ebp
801043d7:	57                   	push   %edi
801043d8:	56                   	push   %esi
801043d9:	53                   	push   %ebx
801043da:	83 ec 0c             	sub    $0xc,%esp
  pushcli();
801043dd:	e8 2e 07 00 00       	call   80104b10 <pushcli>
  c = mycpu();
801043e2:	e8 29 fb ff ff       	call   80103f10 <mycpu>
  p = c->proc;
801043e7:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
801043ed:	e8 6e 07 00 00       	call   80104b60 <popcli>
  if (curproc == initproc)
801043f2:	8d 5e 28             	lea    0x28(%esi),%ebx
801043f5:	8d 7e 68             	lea    0x68(%esi),%edi
801043f8:	39 35 38 c2 10 80    	cmp    %esi,0x8010c238
801043fe:	0f 84 f3 00 00 00    	je     801044f7 <exit+0x127>
80104404:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if (curproc->ofile[fd])
80104408:	8b 03                	mov    (%ebx),%eax
8010440a:	85 c0                	test   %eax,%eax
8010440c:	74 12                	je     80104420 <exit+0x50>
      fileclose(curproc->ofile[fd]);
8010440e:	83 ec 0c             	sub    $0xc,%esp
80104411:	50                   	push   %eax
80104412:	e8 e9 d0 ff ff       	call   80101500 <fileclose>
      curproc->ofile[fd] = 0;
80104417:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
8010441d:	83 c4 10             	add    $0x10,%esp
  for (fd = 0; fd < NOFILE; fd++)
80104420:	83 c3 04             	add    $0x4,%ebx
80104423:	39 df                	cmp    %ebx,%edi
80104425:	75 e1                	jne    80104408 <exit+0x38>
  begin_op();
80104427:	e8 44 ef ff ff       	call   80103370 <begin_op>
  iput(curproc->cwd);
8010442c:	83 ec 0c             	sub    $0xc,%esp
8010442f:	ff 76 68             	pushl  0x68(%esi)
80104432:	e8 99 da ff ff       	call   80101ed0 <iput>
  end_op();
80104437:	e8 a4 ef ff ff       	call   801033e0 <end_op>
  curproc->cwd = 0;
8010443c:	c7 46 68 00 00 00 00 	movl   $0x0,0x68(%esi)
  acquire(&ptable.lock);
80104443:	c7 04 24 60 49 11 80 	movl   $0x80114960,(%esp)
8010444a:	e8 c1 07 00 00       	call   80104c10 <acquire>
  wakeup1(curproc->parent);
8010444f:	8b 56 14             	mov    0x14(%esi),%edx
80104452:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104455:	b8 94 49 11 80       	mov    $0x80114994,%eax
8010445a:	eb 0e                	jmp    8010446a <exit+0x9a>
8010445c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104460:	83 c0 7c             	add    $0x7c,%eax
80104463:	3d 94 68 11 80       	cmp    $0x80116894,%eax
80104468:	74 1c                	je     80104486 <exit+0xb6>
    if (p->state == SLEEPING && p->chan == chan)
8010446a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
8010446e:	75 f0                	jne    80104460 <exit+0x90>
80104470:	3b 50 20             	cmp    0x20(%eax),%edx
80104473:	75 eb                	jne    80104460 <exit+0x90>
      p->state = RUNNABLE;
80104475:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010447c:	83 c0 7c             	add    $0x7c,%eax
8010447f:	3d 94 68 11 80       	cmp    $0x80116894,%eax
80104484:	75 e4                	jne    8010446a <exit+0x9a>
      p->parent = initproc;
80104486:	8b 0d 38 c2 10 80    	mov    0x8010c238,%ecx
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010448c:	ba 94 49 11 80       	mov    $0x80114994,%edx
80104491:	eb 10                	jmp    801044a3 <exit+0xd3>
80104493:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104497:	90                   	nop
80104498:	83 c2 7c             	add    $0x7c,%edx
8010449b:	81 fa 94 68 11 80    	cmp    $0x80116894,%edx
801044a1:	74 3b                	je     801044de <exit+0x10e>
    if (p->parent == curproc)
801044a3:	39 72 14             	cmp    %esi,0x14(%edx)
801044a6:	75 f0                	jne    80104498 <exit+0xc8>
      if (p->state == ZOMBIE)
801044a8:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
      p->parent = initproc;
801044ac:	89 4a 14             	mov    %ecx,0x14(%edx)
      if (p->state == ZOMBIE)
801044af:	75 e7                	jne    80104498 <exit+0xc8>
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801044b1:	b8 94 49 11 80       	mov    $0x80114994,%eax
801044b6:	eb 12                	jmp    801044ca <exit+0xfa>
801044b8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801044bf:	90                   	nop
801044c0:	83 c0 7c             	add    $0x7c,%eax
801044c3:	3d 94 68 11 80       	cmp    $0x80116894,%eax
801044c8:	74 ce                	je     80104498 <exit+0xc8>
    if (p->state == SLEEPING && p->chan == chan)
801044ca:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
801044ce:	75 f0                	jne    801044c0 <exit+0xf0>
801044d0:	3b 48 20             	cmp    0x20(%eax),%ecx
801044d3:	75 eb                	jne    801044c0 <exit+0xf0>
      p->state = RUNNABLE;
801044d5:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
801044dc:	eb e2                	jmp    801044c0 <exit+0xf0>
  curproc->state = ZOMBIE;
801044de:	c7 46 0c 05 00 00 00 	movl   $0x5,0xc(%esi)
  sched();
801044e5:	e8 26 fe ff ff       	call   80104310 <sched>
  panic("zombie exit");
801044ea:	83 ec 0c             	sub    $0xc,%esp
801044ed:	68 68 7e 10 80       	push   $0x80107e68
801044f2:	e8 b9 be ff ff       	call   801003b0 <panic>
    panic("init exiting");
801044f7:	83 ec 0c             	sub    $0xc,%esp
801044fa:	68 5b 7e 10 80       	push   $0x80107e5b
801044ff:	e8 ac be ff ff       	call   801003b0 <panic>
80104504:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010450b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010450f:	90                   	nop

80104510 <yield>:
{
80104510:	f3 0f 1e fb          	endbr32 
80104514:	55                   	push   %ebp
80104515:	89 e5                	mov    %esp,%ebp
80104517:	53                   	push   %ebx
80104518:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock); // DOC: yieldlock
8010451b:	68 60 49 11 80       	push   $0x80114960
80104520:	e8 eb 06 00 00       	call   80104c10 <acquire>
  pushcli();
80104525:	e8 e6 05 00 00       	call   80104b10 <pushcli>
  c = mycpu();
8010452a:	e8 e1 f9 ff ff       	call   80103f10 <mycpu>
  p = c->proc;
8010452f:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104535:	e8 26 06 00 00       	call   80104b60 <popcli>
  myproc()->state = RUNNABLE;
8010453a:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  sched();
80104541:	e8 ca fd ff ff       	call   80104310 <sched>
  release(&ptable.lock);
80104546:	c7 04 24 60 49 11 80 	movl   $0x80114960,(%esp)
8010454d:	e8 7e 07 00 00       	call   80104cd0 <release>
}
80104552:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104555:	83 c4 10             	add    $0x10,%esp
80104558:	c9                   	leave  
80104559:	c3                   	ret    
8010455a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104560 <sleep>:
{
80104560:	f3 0f 1e fb          	endbr32 
80104564:	55                   	push   %ebp
80104565:	89 e5                	mov    %esp,%ebp
80104567:	57                   	push   %edi
80104568:	56                   	push   %esi
80104569:	53                   	push   %ebx
8010456a:	83 ec 0c             	sub    $0xc,%esp
8010456d:	8b 7d 08             	mov    0x8(%ebp),%edi
80104570:	8b 75 0c             	mov    0xc(%ebp),%esi
  pushcli();
80104573:	e8 98 05 00 00       	call   80104b10 <pushcli>
  c = mycpu();
80104578:	e8 93 f9 ff ff       	call   80103f10 <mycpu>
  p = c->proc;
8010457d:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104583:	e8 d8 05 00 00       	call   80104b60 <popcli>
  if (p == 0)
80104588:	85 db                	test   %ebx,%ebx
8010458a:	0f 84 83 00 00 00    	je     80104613 <sleep+0xb3>
  if (lk == 0)
80104590:	85 f6                	test   %esi,%esi
80104592:	74 72                	je     80104606 <sleep+0xa6>
  if (lk != &ptable.lock)
80104594:	81 fe 60 49 11 80    	cmp    $0x80114960,%esi
8010459a:	74 4c                	je     801045e8 <sleep+0x88>
    acquire(&ptable.lock); // DOC: sleeplock1
8010459c:	83 ec 0c             	sub    $0xc,%esp
8010459f:	68 60 49 11 80       	push   $0x80114960
801045a4:	e8 67 06 00 00       	call   80104c10 <acquire>
    release(lk);
801045a9:	89 34 24             	mov    %esi,(%esp)
801045ac:	e8 1f 07 00 00       	call   80104cd0 <release>
  p->chan = chan;
801045b1:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
801045b4:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
801045bb:	e8 50 fd ff ff       	call   80104310 <sched>
  p->chan = 0;
801045c0:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
    release(&ptable.lock);
801045c7:	c7 04 24 60 49 11 80 	movl   $0x80114960,(%esp)
801045ce:	e8 fd 06 00 00       	call   80104cd0 <release>
    acquire(lk);
801045d3:	89 75 08             	mov    %esi,0x8(%ebp)
801045d6:	83 c4 10             	add    $0x10,%esp
}
801045d9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801045dc:	5b                   	pop    %ebx
801045dd:	5e                   	pop    %esi
801045de:	5f                   	pop    %edi
801045df:	5d                   	pop    %ebp
    acquire(lk);
801045e0:	e9 2b 06 00 00       	jmp    80104c10 <acquire>
801045e5:	8d 76 00             	lea    0x0(%esi),%esi
  p->chan = chan;
801045e8:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
801045eb:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
801045f2:	e8 19 fd ff ff       	call   80104310 <sched>
  p->chan = 0;
801045f7:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
801045fe:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104601:	5b                   	pop    %ebx
80104602:	5e                   	pop    %esi
80104603:	5f                   	pop    %edi
80104604:	5d                   	pop    %ebp
80104605:	c3                   	ret    
    panic("sleep without lk");
80104606:	83 ec 0c             	sub    $0xc,%esp
80104609:	68 7a 7e 10 80       	push   $0x80107e7a
8010460e:	e8 9d bd ff ff       	call   801003b0 <panic>
    panic("sleep");
80104613:	83 ec 0c             	sub    $0xc,%esp
80104616:	68 74 7e 10 80       	push   $0x80107e74
8010461b:	e8 90 bd ff ff       	call   801003b0 <panic>

80104620 <wait>:
{
80104620:	f3 0f 1e fb          	endbr32 
80104624:	55                   	push   %ebp
80104625:	89 e5                	mov    %esp,%ebp
80104627:	56                   	push   %esi
80104628:	53                   	push   %ebx
  pushcli();
80104629:	e8 e2 04 00 00       	call   80104b10 <pushcli>
  c = mycpu();
8010462e:	e8 dd f8 ff ff       	call   80103f10 <mycpu>
  p = c->proc;
80104633:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80104639:	e8 22 05 00 00       	call   80104b60 <popcli>
  acquire(&ptable.lock);
8010463e:	83 ec 0c             	sub    $0xc,%esp
80104641:	68 60 49 11 80       	push   $0x80114960
80104646:	e8 c5 05 00 00       	call   80104c10 <acquire>
8010464b:	83 c4 10             	add    $0x10,%esp
    havekids = 0;
8010464e:	31 c0                	xor    %eax,%eax
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104650:	bb 94 49 11 80       	mov    $0x80114994,%ebx
80104655:	eb 14                	jmp    8010466b <wait+0x4b>
80104657:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010465e:	66 90                	xchg   %ax,%ax
80104660:	83 c3 7c             	add    $0x7c,%ebx
80104663:	81 fb 94 68 11 80    	cmp    $0x80116894,%ebx
80104669:	74 1b                	je     80104686 <wait+0x66>
      if (p->parent != curproc)
8010466b:	39 73 14             	cmp    %esi,0x14(%ebx)
8010466e:	75 f0                	jne    80104660 <wait+0x40>
      if (p->state == ZOMBIE)
80104670:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
80104674:	74 32                	je     801046a8 <wait+0x88>
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104676:	83 c3 7c             	add    $0x7c,%ebx
      havekids = 1;
80104679:	b8 01 00 00 00       	mov    $0x1,%eax
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010467e:	81 fb 94 68 11 80    	cmp    $0x80116894,%ebx
80104684:	75 e5                	jne    8010466b <wait+0x4b>
    if (!havekids || curproc->killed)
80104686:	85 c0                	test   %eax,%eax
80104688:	74 74                	je     801046fe <wait+0xde>
8010468a:	8b 46 24             	mov    0x24(%esi),%eax
8010468d:	85 c0                	test   %eax,%eax
8010468f:	75 6d                	jne    801046fe <wait+0xde>
    sleep(curproc, &ptable.lock); // DOC: wait-sleep
80104691:	83 ec 08             	sub    $0x8,%esp
80104694:	68 60 49 11 80       	push   $0x80114960
80104699:	56                   	push   %esi
8010469a:	e8 c1 fe ff ff       	call   80104560 <sleep>
    havekids = 0;
8010469f:	83 c4 10             	add    $0x10,%esp
801046a2:	eb aa                	jmp    8010464e <wait+0x2e>
801046a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        kfree(p->kstack);
801046a8:	83 ec 0c             	sub    $0xc,%esp
801046ab:	ff 73 08             	pushl  0x8(%ebx)
        pid = p->pid;
801046ae:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
801046b1:	e8 fa e3 ff ff       	call   80102ab0 <kfree>
        freevm(p->pgdir);
801046b6:	5a                   	pop    %edx
801046b7:	ff 73 04             	pushl  0x4(%ebx)
        p->kstack = 0;
801046ba:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
801046c1:	e8 5a 2e 00 00       	call   80107520 <freevm>
        release(&ptable.lock);
801046c6:	c7 04 24 60 49 11 80 	movl   $0x80114960,(%esp)
        p->pid = 0;
801046cd:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
801046d4:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
801046db:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
801046df:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
801046e6:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
801046ed:	e8 de 05 00 00       	call   80104cd0 <release>
        return pid;
801046f2:	83 c4 10             	add    $0x10,%esp
}
801046f5:	8d 65 f8             	lea    -0x8(%ebp),%esp
801046f8:	89 f0                	mov    %esi,%eax
801046fa:	5b                   	pop    %ebx
801046fb:	5e                   	pop    %esi
801046fc:	5d                   	pop    %ebp
801046fd:	c3                   	ret    
      release(&ptable.lock);
801046fe:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80104701:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
80104706:	68 60 49 11 80       	push   $0x80114960
8010470b:	e8 c0 05 00 00       	call   80104cd0 <release>
      return -1;
80104710:	83 c4 10             	add    $0x10,%esp
80104713:	eb e0                	jmp    801046f5 <wait+0xd5>
80104715:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010471c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104720 <wakeup>:
}

// Wake up all processes sleeping on chan.
void wakeup(void *chan)
{
80104720:	f3 0f 1e fb          	endbr32 
80104724:	55                   	push   %ebp
80104725:	89 e5                	mov    %esp,%ebp
80104727:	53                   	push   %ebx
80104728:	83 ec 10             	sub    $0x10,%esp
8010472b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
8010472e:	68 60 49 11 80       	push   $0x80114960
80104733:	e8 d8 04 00 00       	call   80104c10 <acquire>
80104738:	83 c4 10             	add    $0x10,%esp
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010473b:	b8 94 49 11 80       	mov    $0x80114994,%eax
80104740:	eb 10                	jmp    80104752 <wakeup+0x32>
80104742:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104748:	83 c0 7c             	add    $0x7c,%eax
8010474b:	3d 94 68 11 80       	cmp    $0x80116894,%eax
80104750:	74 1c                	je     8010476e <wakeup+0x4e>
    if (p->state == SLEEPING && p->chan == chan)
80104752:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104756:	75 f0                	jne    80104748 <wakeup+0x28>
80104758:	3b 58 20             	cmp    0x20(%eax),%ebx
8010475b:	75 eb                	jne    80104748 <wakeup+0x28>
      p->state = RUNNABLE;
8010475d:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104764:	83 c0 7c             	add    $0x7c,%eax
80104767:	3d 94 68 11 80       	cmp    $0x80116894,%eax
8010476c:	75 e4                	jne    80104752 <wakeup+0x32>
  wakeup1(chan);
  release(&ptable.lock);
8010476e:	c7 45 08 60 49 11 80 	movl   $0x80114960,0x8(%ebp)
}
80104775:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104778:	c9                   	leave  
  release(&ptable.lock);
80104779:	e9 52 05 00 00       	jmp    80104cd0 <release>
8010477e:	66 90                	xchg   %ax,%ax

80104780 <kill>:

// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int kill(int pid)
{
80104780:	f3 0f 1e fb          	endbr32 
80104784:	55                   	push   %ebp
80104785:	89 e5                	mov    %esp,%ebp
80104787:	53                   	push   %ebx
80104788:	83 ec 10             	sub    $0x10,%esp
8010478b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
8010478e:	68 60 49 11 80       	push   $0x80114960
80104793:	e8 78 04 00 00       	call   80104c10 <acquire>
80104798:	83 c4 10             	add    $0x10,%esp
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010479b:	b8 94 49 11 80       	mov    $0x80114994,%eax
801047a0:	eb 10                	jmp    801047b2 <kill+0x32>
801047a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801047a8:	83 c0 7c             	add    $0x7c,%eax
801047ab:	3d 94 68 11 80       	cmp    $0x80116894,%eax
801047b0:	74 36                	je     801047e8 <kill+0x68>
  {
    if (p->pid == pid)
801047b2:	39 58 10             	cmp    %ebx,0x10(%eax)
801047b5:	75 f1                	jne    801047a8 <kill+0x28>
    {
      p->killed = 1;
      // Wake process from sleep if necessary.
      if (p->state == SLEEPING)
801047b7:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
      p->killed = 1;
801047bb:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      if (p->state == SLEEPING)
801047c2:	75 07                	jne    801047cb <kill+0x4b>
        p->state = RUNNABLE;
801047c4:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      release(&ptable.lock);
801047cb:	83 ec 0c             	sub    $0xc,%esp
801047ce:	68 60 49 11 80       	push   $0x80114960
801047d3:	e8 f8 04 00 00       	call   80104cd0 <release>
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
}
801047d8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
      return 0;
801047db:	83 c4 10             	add    $0x10,%esp
801047de:	31 c0                	xor    %eax,%eax
}
801047e0:	c9                   	leave  
801047e1:	c3                   	ret    
801047e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  release(&ptable.lock);
801047e8:	83 ec 0c             	sub    $0xc,%esp
801047eb:	68 60 49 11 80       	push   $0x80114960
801047f0:	e8 db 04 00 00       	call   80104cd0 <release>
}
801047f5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return -1;
801047f8:	83 c4 10             	add    $0x10,%esp
801047fb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104800:	c9                   	leave  
80104801:	c3                   	ret    
80104802:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104809:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104810 <procdump>:
// PAGEBREAK: 36
//  Print a process listing to console.  For debugging.
//  Runs when user types ^P on console.
//  No lock to avoid wedging a stuck machine further.
void procdump(void)
{
80104810:	f3 0f 1e fb          	endbr32 
80104814:	55                   	push   %ebp
80104815:	89 e5                	mov    %esp,%ebp
80104817:	57                   	push   %edi
80104818:	56                   	push   %esi
80104819:	8d 75 e8             	lea    -0x18(%ebp),%esi
8010481c:	53                   	push   %ebx
8010481d:	bb 00 4a 11 80       	mov    $0x80114a00,%ebx
80104822:	83 ec 3c             	sub    $0x3c,%esp
80104825:	eb 28                	jmp    8010484f <procdump+0x3f>
80104827:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010482e:	66 90                	xchg   %ax,%ax
    {
      getcallerpcs((uint *)p->context->ebp + 2, pc);
      for (i = 0; i < 10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80104830:	83 ec 0c             	sub    $0xc,%esp
80104833:	68 03 82 10 80       	push   $0x80108203
80104838:	e8 63 bf ff ff       	call   801007a0 <cprintf>
8010483d:	83 c4 10             	add    $0x10,%esp
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104840:	83 c3 7c             	add    $0x7c,%ebx
80104843:	81 fb 00 69 11 80    	cmp    $0x80116900,%ebx
80104849:	0f 84 81 00 00 00    	je     801048d0 <procdump+0xc0>
    if (p->state == UNUSED)
8010484f:	8b 43 a0             	mov    -0x60(%ebx),%eax
80104852:	85 c0                	test   %eax,%eax
80104854:	74 ea                	je     80104840 <procdump+0x30>
      state = "???";
80104856:	ba 8b 7e 10 80       	mov    $0x80107e8b,%edx
    if (p->state >= 0 && p->state < NELEM(states) && states[p->state])
8010485b:	83 f8 05             	cmp    $0x5,%eax
8010485e:	77 11                	ja     80104871 <procdump+0x61>
80104860:	8b 14 85 ec 7e 10 80 	mov    -0x7fef8114(,%eax,4),%edx
      state = "???";
80104867:	b8 8b 7e 10 80       	mov    $0x80107e8b,%eax
8010486c:	85 d2                	test   %edx,%edx
8010486e:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
80104871:	53                   	push   %ebx
80104872:	52                   	push   %edx
80104873:	ff 73 a4             	pushl  -0x5c(%ebx)
80104876:	68 8f 7e 10 80       	push   $0x80107e8f
8010487b:	e8 20 bf ff ff       	call   801007a0 <cprintf>
    if (p->state == SLEEPING)
80104880:	83 c4 10             	add    $0x10,%esp
80104883:	83 7b a0 02          	cmpl   $0x2,-0x60(%ebx)
80104887:	75 a7                	jne    80104830 <procdump+0x20>
      getcallerpcs((uint *)p->context->ebp + 2, pc);
80104889:	83 ec 08             	sub    $0x8,%esp
8010488c:	8d 45 c0             	lea    -0x40(%ebp),%eax
8010488f:	8d 7d c0             	lea    -0x40(%ebp),%edi
80104892:	50                   	push   %eax
80104893:	8b 43 b0             	mov    -0x50(%ebx),%eax
80104896:	8b 40 0c             	mov    0xc(%eax),%eax
80104899:	83 c0 08             	add    $0x8,%eax
8010489c:	50                   	push   %eax
8010489d:	e8 0e 02 00 00       	call   80104ab0 <getcallerpcs>
      for (i = 0; i < 10 && pc[i] != 0; i++)
801048a2:	83 c4 10             	add    $0x10,%esp
801048a5:	8d 76 00             	lea    0x0(%esi),%esi
801048a8:	8b 17                	mov    (%edi),%edx
801048aa:	85 d2                	test   %edx,%edx
801048ac:	74 82                	je     80104830 <procdump+0x20>
        cprintf(" %p", pc[i]);
801048ae:	83 ec 08             	sub    $0x8,%esp
801048b1:	83 c7 04             	add    $0x4,%edi
801048b4:	52                   	push   %edx
801048b5:	68 81 78 10 80       	push   $0x80107881
801048ba:	e8 e1 be ff ff       	call   801007a0 <cprintf>
      for (i = 0; i < 10 && pc[i] != 0; i++)
801048bf:	83 c4 10             	add    $0x10,%esp
801048c2:	39 fe                	cmp    %edi,%esi
801048c4:	75 e2                	jne    801048a8 <procdump+0x98>
801048c6:	e9 65 ff ff ff       	jmp    80104830 <procdump+0x20>
801048cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801048cf:	90                   	nop
  }
}
801048d0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801048d3:	5b                   	pop    %ebx
801048d4:	5e                   	pop    %esi
801048d5:	5f                   	pop    %edi
801048d6:	5d                   	pop    %ebp
801048d7:	c3                   	ret    
801048d8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801048df:	90                   	nop

801048e0 <sys_get_uncle_count>:

int sys_get_uncle_count(void){
801048e0:	f3 0f 1e fb          	endbr32 
801048e4:	55                   	push   %ebp
801048e5:	89 e5                	mov    %esp,%ebp
801048e7:	53                   	push   %ebx
801048e8:	83 ec 04             	sub    $0x4,%esp
  pushcli();
801048eb:	e8 20 02 00 00       	call   80104b10 <pushcli>
  c = mycpu();
801048f0:	e8 1b f6 ff ff       	call   80103f10 <mycpu>
  p = c->proc;
801048f5:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801048fb:	e8 60 02 00 00       	call   80104b60 <popcli>
  int count = 0;
  struct proc *my_proc = myproc();  // Get the current process
  // cprintf("currenct pid: %d\n",my_proc->pid);
  struct proc *curr_proc;

  for (curr_proc = ptable.proc; curr_proc < &ptable.proc[NPROC]; curr_proc++){
80104900:	b8 94 49 11 80       	mov    $0x80114994,%eax
  int count = 0;
80104905:	31 c9                	xor    %ecx,%ecx
80104907:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010490e:	66 90                	xchg   %ax,%ax
    if (curr_proc->state == UNUSED || curr_proc->state == EMBRYO || curr_proc->pid == my_proc->pid)
80104910:	83 78 0c 01          	cmpl   $0x1,0xc(%eax)
80104914:	76 21                	jbe    80104937 <sys_get_uncle_count+0x57>
80104916:	8b 53 10             	mov    0x10(%ebx),%edx
80104919:	39 50 10             	cmp    %edx,0x10(%eax)
8010491c:	74 19                	je     80104937 <sys_get_uncle_count+0x57>
      continue;
    // cprintf("in for loop for pid:%d\n",curr_proc->pid);
    if (curr_proc->parent && curr_proc->parent->parent && curr_proc->parent->parent == my_proc) {
8010491e:	8b 50 14             	mov    0x14(%eax),%edx
80104921:	85 d2                	test   %edx,%edx
80104923:	74 12                	je     80104937 <sys_get_uncle_count+0x57>
80104925:	8b 52 14             	mov    0x14(%edx),%edx
80104928:	85 d2                	test   %edx,%edx
8010492a:	74 0b                	je     80104937 <sys_get_uncle_count+0x57>
8010492c:	39 da                	cmp    %ebx,%edx
8010492e:	0f 94 c2             	sete   %dl
      count++;
80104931:	80 fa 01             	cmp    $0x1,%dl
80104934:	83 d9 ff             	sbb    $0xffffffff,%ecx
  for (curr_proc = ptable.proc; curr_proc < &ptable.proc[NPROC]; curr_proc++){
80104937:	83 c0 7c             	add    $0x7c,%eax
8010493a:	3d 94 68 11 80       	cmp    $0x80116894,%eax
8010493f:	75 cf                	jne    80104910 <sys_get_uncle_count+0x30>
    }
  }
  // cprintf("done\n");
  return count;
}
80104941:	83 c4 04             	add    $0x4,%esp
80104944:	89 c8                	mov    %ecx,%eax
80104946:	5b                   	pop    %ebx
80104947:	5d                   	pop    %ebp
80104948:	c3                   	ret    
80104949:	66 90                	xchg   %ax,%ax
8010494b:	66 90                	xchg   %ax,%ax
8010494d:	66 90                	xchg   %ax,%ax
8010494f:	90                   	nop

80104950 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80104950:	f3 0f 1e fb          	endbr32 
80104954:	55                   	push   %ebp
80104955:	89 e5                	mov    %esp,%ebp
80104957:	53                   	push   %ebx
80104958:	83 ec 0c             	sub    $0xc,%esp
8010495b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
8010495e:	68 04 7f 10 80       	push   $0x80107f04
80104963:	8d 43 04             	lea    0x4(%ebx),%eax
80104966:	50                   	push   %eax
80104967:	e8 24 01 00 00       	call   80104a90 <initlock>
  lk->name = name;
8010496c:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
8010496f:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
80104975:	83 c4 10             	add    $0x10,%esp
  lk->pid = 0;
80104978:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
8010497f:	89 43 38             	mov    %eax,0x38(%ebx)
}
80104982:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104985:	c9                   	leave  
80104986:	c3                   	ret    
80104987:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010498e:	66 90                	xchg   %ax,%ax

80104990 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80104990:	f3 0f 1e fb          	endbr32 
80104994:	55                   	push   %ebp
80104995:	89 e5                	mov    %esp,%ebp
80104997:	56                   	push   %esi
80104998:	53                   	push   %ebx
80104999:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
8010499c:	8d 73 04             	lea    0x4(%ebx),%esi
8010499f:	83 ec 0c             	sub    $0xc,%esp
801049a2:	56                   	push   %esi
801049a3:	e8 68 02 00 00       	call   80104c10 <acquire>
  while (lk->locked) {
801049a8:	8b 13                	mov    (%ebx),%edx
801049aa:	83 c4 10             	add    $0x10,%esp
801049ad:	85 d2                	test   %edx,%edx
801049af:	74 1a                	je     801049cb <acquiresleep+0x3b>
801049b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    sleep(lk, &lk->lk);
801049b8:	83 ec 08             	sub    $0x8,%esp
801049bb:	56                   	push   %esi
801049bc:	53                   	push   %ebx
801049bd:	e8 9e fb ff ff       	call   80104560 <sleep>
  while (lk->locked) {
801049c2:	8b 03                	mov    (%ebx),%eax
801049c4:	83 c4 10             	add    $0x10,%esp
801049c7:	85 c0                	test   %eax,%eax
801049c9:	75 ed                	jne    801049b8 <acquiresleep+0x28>
  }
  lk->locked = 1;
801049cb:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
801049d1:	e8 ca f5 ff ff       	call   80103fa0 <myproc>
801049d6:	8b 40 10             	mov    0x10(%eax),%eax
801049d9:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
801049dc:	89 75 08             	mov    %esi,0x8(%ebp)
}
801049df:	8d 65 f8             	lea    -0x8(%ebp),%esp
801049e2:	5b                   	pop    %ebx
801049e3:	5e                   	pop    %esi
801049e4:	5d                   	pop    %ebp
  release(&lk->lk);
801049e5:	e9 e6 02 00 00       	jmp    80104cd0 <release>
801049ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801049f0 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
801049f0:	f3 0f 1e fb          	endbr32 
801049f4:	55                   	push   %ebp
801049f5:	89 e5                	mov    %esp,%ebp
801049f7:	56                   	push   %esi
801049f8:	53                   	push   %ebx
801049f9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
801049fc:	8d 73 04             	lea    0x4(%ebx),%esi
801049ff:	83 ec 0c             	sub    $0xc,%esp
80104a02:	56                   	push   %esi
80104a03:	e8 08 02 00 00       	call   80104c10 <acquire>
  lk->locked = 0;
80104a08:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
80104a0e:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
80104a15:	89 1c 24             	mov    %ebx,(%esp)
80104a18:	e8 03 fd ff ff       	call   80104720 <wakeup>
  release(&lk->lk);
80104a1d:	89 75 08             	mov    %esi,0x8(%ebp)
80104a20:	83 c4 10             	add    $0x10,%esp
}
80104a23:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104a26:	5b                   	pop    %ebx
80104a27:	5e                   	pop    %esi
80104a28:	5d                   	pop    %ebp
  release(&lk->lk);
80104a29:	e9 a2 02 00 00       	jmp    80104cd0 <release>
80104a2e:	66 90                	xchg   %ax,%ax

80104a30 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
80104a30:	f3 0f 1e fb          	endbr32 
80104a34:	55                   	push   %ebp
80104a35:	89 e5                	mov    %esp,%ebp
80104a37:	57                   	push   %edi
80104a38:	31 ff                	xor    %edi,%edi
80104a3a:	56                   	push   %esi
80104a3b:	53                   	push   %ebx
80104a3c:	83 ec 18             	sub    $0x18,%esp
80104a3f:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;
  
  acquire(&lk->lk);
80104a42:	8d 73 04             	lea    0x4(%ebx),%esi
80104a45:	56                   	push   %esi
80104a46:	e8 c5 01 00 00       	call   80104c10 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
80104a4b:	8b 03                	mov    (%ebx),%eax
80104a4d:	83 c4 10             	add    $0x10,%esp
80104a50:	85 c0                	test   %eax,%eax
80104a52:	75 1c                	jne    80104a70 <holdingsleep+0x40>
  release(&lk->lk);
80104a54:	83 ec 0c             	sub    $0xc,%esp
80104a57:	56                   	push   %esi
80104a58:	e8 73 02 00 00       	call   80104cd0 <release>
  return r;
}
80104a5d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104a60:	89 f8                	mov    %edi,%eax
80104a62:	5b                   	pop    %ebx
80104a63:	5e                   	pop    %esi
80104a64:	5f                   	pop    %edi
80104a65:	5d                   	pop    %ebp
80104a66:	c3                   	ret    
80104a67:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104a6e:	66 90                	xchg   %ax,%ax
  r = lk->locked && (lk->pid == myproc()->pid);
80104a70:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
80104a73:	e8 28 f5 ff ff       	call   80103fa0 <myproc>
80104a78:	39 58 10             	cmp    %ebx,0x10(%eax)
80104a7b:	0f 94 c0             	sete   %al
80104a7e:	0f b6 c0             	movzbl %al,%eax
80104a81:	89 c7                	mov    %eax,%edi
80104a83:	eb cf                	jmp    80104a54 <holdingsleep+0x24>
80104a85:	66 90                	xchg   %ax,%ax
80104a87:	66 90                	xchg   %ax,%ax
80104a89:	66 90                	xchg   %ax,%ax
80104a8b:	66 90                	xchg   %ax,%ax
80104a8d:	66 90                	xchg   %ax,%ax
80104a8f:	90                   	nop

80104a90 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80104a90:	f3 0f 1e fb          	endbr32 
80104a94:	55                   	push   %ebp
80104a95:	89 e5                	mov    %esp,%ebp
80104a97:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80104a9a:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
80104a9d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
80104aa3:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
80104aa6:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80104aad:	5d                   	pop    %ebp
80104aae:	c3                   	ret    
80104aaf:	90                   	nop

80104ab0 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80104ab0:	f3 0f 1e fb          	endbr32 
80104ab4:	55                   	push   %ebp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104ab5:	31 d2                	xor    %edx,%edx
{
80104ab7:	89 e5                	mov    %esp,%ebp
80104ab9:	53                   	push   %ebx
  ebp = (uint*)v - 2;
80104aba:	8b 45 08             	mov    0x8(%ebp),%eax
{
80104abd:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  ebp = (uint*)v - 2;
80104ac0:	83 e8 08             	sub    $0x8,%eax
  for(i = 0; i < 10; i++){
80104ac3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104ac7:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104ac8:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
80104ace:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
80104ad4:	77 1a                	ja     80104af0 <getcallerpcs+0x40>
      break;
    pcs[i] = ebp[1];     // saved %eip
80104ad6:	8b 58 04             	mov    0x4(%eax),%ebx
80104ad9:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
80104adc:	83 c2 01             	add    $0x1,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
80104adf:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80104ae1:	83 fa 0a             	cmp    $0xa,%edx
80104ae4:	75 e2                	jne    80104ac8 <getcallerpcs+0x18>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
80104ae6:	5b                   	pop    %ebx
80104ae7:	5d                   	pop    %ebp
80104ae8:	c3                   	ret    
80104ae9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(; i < 10; i++)
80104af0:	8d 04 91             	lea    (%ecx,%edx,4),%eax
80104af3:	8d 51 28             	lea    0x28(%ecx),%edx
80104af6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104afd:	8d 76 00             	lea    0x0(%esi),%esi
    pcs[i] = 0;
80104b00:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
80104b06:	83 c0 04             	add    $0x4,%eax
80104b09:	39 d0                	cmp    %edx,%eax
80104b0b:	75 f3                	jne    80104b00 <getcallerpcs+0x50>
}
80104b0d:	5b                   	pop    %ebx
80104b0e:	5d                   	pop    %ebp
80104b0f:	c3                   	ret    

80104b10 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80104b10:	f3 0f 1e fb          	endbr32 
80104b14:	55                   	push   %ebp
80104b15:	89 e5                	mov    %esp,%ebp
80104b17:	53                   	push   %ebx
80104b18:	83 ec 04             	sub    $0x4,%esp
80104b1b:	9c                   	pushf  
80104b1c:	5b                   	pop    %ebx
  asm volatile("cli");
80104b1d:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
80104b1e:	e8 ed f3 ff ff       	call   80103f10 <mycpu>
80104b23:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
80104b29:	85 c0                	test   %eax,%eax
80104b2b:	74 13                	je     80104b40 <pushcli+0x30>
    mycpu()->intena = eflags & FL_IF;
  mycpu()->ncli += 1;
80104b2d:	e8 de f3 ff ff       	call   80103f10 <mycpu>
80104b32:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
80104b39:	83 c4 04             	add    $0x4,%esp
80104b3c:	5b                   	pop    %ebx
80104b3d:	5d                   	pop    %ebp
80104b3e:	c3                   	ret    
80104b3f:	90                   	nop
    mycpu()->intena = eflags & FL_IF;
80104b40:	e8 cb f3 ff ff       	call   80103f10 <mycpu>
80104b45:	81 e3 00 02 00 00    	and    $0x200,%ebx
80104b4b:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
80104b51:	eb da                	jmp    80104b2d <pushcli+0x1d>
80104b53:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104b5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104b60 <popcli>:

void
popcli(void)
{
80104b60:	f3 0f 1e fb          	endbr32 
80104b64:	55                   	push   %ebp
80104b65:	89 e5                	mov    %esp,%ebp
80104b67:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r"(eflags));
80104b6a:	9c                   	pushf  
80104b6b:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104b6c:	f6 c4 02             	test   $0x2,%ah
80104b6f:	75 31                	jne    80104ba2 <popcli+0x42>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
80104b71:	e8 9a f3 ff ff       	call   80103f10 <mycpu>
80104b76:	83 a8 a4 00 00 00 01 	subl   $0x1,0xa4(%eax)
80104b7d:	78 30                	js     80104baf <popcli+0x4f>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104b7f:	e8 8c f3 ff ff       	call   80103f10 <mycpu>
80104b84:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80104b8a:	85 d2                	test   %edx,%edx
80104b8c:	74 02                	je     80104b90 <popcli+0x30>
    sti();
}
80104b8e:	c9                   	leave  
80104b8f:	c3                   	ret    
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104b90:	e8 7b f3 ff ff       	call   80103f10 <mycpu>
80104b95:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
80104b9b:	85 c0                	test   %eax,%eax
80104b9d:	74 ef                	je     80104b8e <popcli+0x2e>
  asm volatile("sti");
80104b9f:	fb                   	sti    
}
80104ba0:	c9                   	leave  
80104ba1:	c3                   	ret    
    panic("popcli - interruptible");
80104ba2:	83 ec 0c             	sub    $0xc,%esp
80104ba5:	68 0f 7f 10 80       	push   $0x80107f0f
80104baa:	e8 01 b8 ff ff       	call   801003b0 <panic>
    panic("popcli");
80104baf:	83 ec 0c             	sub    $0xc,%esp
80104bb2:	68 26 7f 10 80       	push   $0x80107f26
80104bb7:	e8 f4 b7 ff ff       	call   801003b0 <panic>
80104bbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104bc0 <holding>:
{
80104bc0:	f3 0f 1e fb          	endbr32 
80104bc4:	55                   	push   %ebp
80104bc5:	89 e5                	mov    %esp,%ebp
80104bc7:	56                   	push   %esi
80104bc8:	53                   	push   %ebx
80104bc9:	8b 75 08             	mov    0x8(%ebp),%esi
80104bcc:	31 db                	xor    %ebx,%ebx
  pushcli();
80104bce:	e8 3d ff ff ff       	call   80104b10 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
80104bd3:	8b 06                	mov    (%esi),%eax
80104bd5:	85 c0                	test   %eax,%eax
80104bd7:	75 0f                	jne    80104be8 <holding+0x28>
  popcli();
80104bd9:	e8 82 ff ff ff       	call   80104b60 <popcli>
}
80104bde:	89 d8                	mov    %ebx,%eax
80104be0:	5b                   	pop    %ebx
80104be1:	5e                   	pop    %esi
80104be2:	5d                   	pop    %ebp
80104be3:	c3                   	ret    
80104be4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  r = lock->locked && lock->cpu == mycpu();
80104be8:	8b 5e 08             	mov    0x8(%esi),%ebx
80104beb:	e8 20 f3 ff ff       	call   80103f10 <mycpu>
80104bf0:	39 c3                	cmp    %eax,%ebx
80104bf2:	0f 94 c3             	sete   %bl
  popcli();
80104bf5:	e8 66 ff ff ff       	call   80104b60 <popcli>
  r = lock->locked && lock->cpu == mycpu();
80104bfa:	0f b6 db             	movzbl %bl,%ebx
}
80104bfd:	89 d8                	mov    %ebx,%eax
80104bff:	5b                   	pop    %ebx
80104c00:	5e                   	pop    %esi
80104c01:	5d                   	pop    %ebp
80104c02:	c3                   	ret    
80104c03:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104c0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104c10 <acquire>:
{
80104c10:	f3 0f 1e fb          	endbr32 
80104c14:	55                   	push   %ebp
80104c15:	89 e5                	mov    %esp,%ebp
80104c17:	56                   	push   %esi
80104c18:	53                   	push   %ebx
  pushcli(); // disable interrupts to avoid deadlock.
80104c19:	e8 f2 fe ff ff       	call   80104b10 <pushcli>
  if(holding(lk))
80104c1e:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104c21:	83 ec 0c             	sub    $0xc,%esp
80104c24:	53                   	push   %ebx
80104c25:	e8 96 ff ff ff       	call   80104bc0 <holding>
80104c2a:	83 c4 10             	add    $0x10,%esp
80104c2d:	85 c0                	test   %eax,%eax
80104c2f:	0f 85 7f 00 00 00    	jne    80104cb4 <acquire+0xa4>
80104c35:	89 c6                	mov    %eax,%esi
  asm volatile("lock; xchgl %0, %1" : "+m"(*addr), "=a"(result) : "1"(newval) : "cc");
80104c37:	ba 01 00 00 00       	mov    $0x1,%edx
80104c3c:	eb 05                	jmp    80104c43 <acquire+0x33>
80104c3e:	66 90                	xchg   %ax,%ax
80104c40:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104c43:	89 d0                	mov    %edx,%eax
80104c45:	f0 87 03             	lock xchg %eax,(%ebx)
  while(xchg(&lk->locked, 1) != 0)
80104c48:	85 c0                	test   %eax,%eax
80104c4a:	75 f4                	jne    80104c40 <acquire+0x30>
  __sync_synchronize();
80104c4c:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
80104c51:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104c54:	e8 b7 f2 ff ff       	call   80103f10 <mycpu>
80104c59:	89 43 08             	mov    %eax,0x8(%ebx)
  ebp = (uint*)v - 2;
80104c5c:	89 e8                	mov    %ebp,%eax
80104c5e:	66 90                	xchg   %ax,%ax
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104c60:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
80104c66:	81 fa fe ff ff 7f    	cmp    $0x7ffffffe,%edx
80104c6c:	77 22                	ja     80104c90 <acquire+0x80>
    pcs[i] = ebp[1];     // saved %eip
80104c6e:	8b 50 04             	mov    0x4(%eax),%edx
80104c71:	89 54 b3 0c          	mov    %edx,0xc(%ebx,%esi,4)
  for(i = 0; i < 10; i++){
80104c75:	83 c6 01             	add    $0x1,%esi
    ebp = (uint*)ebp[0]; // saved %ebp
80104c78:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80104c7a:	83 fe 0a             	cmp    $0xa,%esi
80104c7d:	75 e1                	jne    80104c60 <acquire+0x50>
}
80104c7f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104c82:	5b                   	pop    %ebx
80104c83:	5e                   	pop    %esi
80104c84:	5d                   	pop    %ebp
80104c85:	c3                   	ret    
80104c86:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104c8d:	8d 76 00             	lea    0x0(%esi),%esi
  for(; i < 10; i++)
80104c90:	8d 44 b3 0c          	lea    0xc(%ebx,%esi,4),%eax
80104c94:	83 c3 34             	add    $0x34,%ebx
80104c97:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104c9e:	66 90                	xchg   %ax,%ax
    pcs[i] = 0;
80104ca0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
80104ca6:	83 c0 04             	add    $0x4,%eax
80104ca9:	39 d8                	cmp    %ebx,%eax
80104cab:	75 f3                	jne    80104ca0 <acquire+0x90>
}
80104cad:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104cb0:	5b                   	pop    %ebx
80104cb1:	5e                   	pop    %esi
80104cb2:	5d                   	pop    %ebp
80104cb3:	c3                   	ret    
    panic("acquire");
80104cb4:	83 ec 0c             	sub    $0xc,%esp
80104cb7:	68 2d 7f 10 80       	push   $0x80107f2d
80104cbc:	e8 ef b6 ff ff       	call   801003b0 <panic>
80104cc1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104cc8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104ccf:	90                   	nop

80104cd0 <release>:
{
80104cd0:	f3 0f 1e fb          	endbr32 
80104cd4:	55                   	push   %ebp
80104cd5:	89 e5                	mov    %esp,%ebp
80104cd7:	53                   	push   %ebx
80104cd8:	83 ec 10             	sub    $0x10,%esp
80104cdb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holding(lk))
80104cde:	53                   	push   %ebx
80104cdf:	e8 dc fe ff ff       	call   80104bc0 <holding>
80104ce4:	83 c4 10             	add    $0x10,%esp
80104ce7:	85 c0                	test   %eax,%eax
80104ce9:	74 22                	je     80104d0d <release+0x3d>
  lk->pcs[0] = 0;
80104ceb:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
80104cf2:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
80104cf9:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
80104cfe:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
80104d04:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104d07:	c9                   	leave  
  popcli();
80104d08:	e9 53 fe ff ff       	jmp    80104b60 <popcli>
    panic("release");
80104d0d:	83 ec 0c             	sub    $0xc,%esp
80104d10:	68 35 7f 10 80       	push   $0x80107f35
80104d15:	e8 96 b6 ff ff       	call   801003b0 <panic>
80104d1a:	66 90                	xchg   %ax,%ax
80104d1c:	66 90                	xchg   %ax,%ax
80104d1e:	66 90                	xchg   %ax,%ax

80104d20 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80104d20:	f3 0f 1e fb          	endbr32 
80104d24:	55                   	push   %ebp
80104d25:	89 e5                	mov    %esp,%ebp
80104d27:	57                   	push   %edi
80104d28:	8b 55 08             	mov    0x8(%ebp),%edx
80104d2b:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104d2e:	53                   	push   %ebx
80104d2f:	8b 45 0c             	mov    0xc(%ebp),%eax
  if ((int)dst%4 == 0 && n%4 == 0){
80104d32:	89 d7                	mov    %edx,%edi
80104d34:	09 cf                	or     %ecx,%edi
80104d36:	83 e7 03             	and    $0x3,%edi
80104d39:	75 25                	jne    80104d60 <memset+0x40>
    c &= 0xFF;
80104d3b:	0f b6 f8             	movzbl %al,%edi
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
80104d3e:	c1 e0 18             	shl    $0x18,%eax
80104d41:	89 fb                	mov    %edi,%ebx
80104d43:	c1 e9 02             	shr    $0x2,%ecx
80104d46:	c1 e3 10             	shl    $0x10,%ebx
80104d49:	09 d8                	or     %ebx,%eax
80104d4b:	09 f8                	or     %edi,%eax
80104d4d:	c1 e7 08             	shl    $0x8,%edi
80104d50:	09 f8                	or     %edi,%eax
  asm volatile("cld; rep stosl" : "=D"(addr), "=c"(cnt) : "0"(addr), "1"(cnt), "a"(data) : "memory", "cc");
80104d52:	89 d7                	mov    %edx,%edi
80104d54:	fc                   	cld    
80104d55:	f3 ab                	rep stos %eax,%es:(%edi)
  } else
    stosb(dst, c, n);
  return dst;
}
80104d57:	5b                   	pop    %ebx
80104d58:	89 d0                	mov    %edx,%eax
80104d5a:	5f                   	pop    %edi
80104d5b:	5d                   	pop    %ebp
80104d5c:	c3                   	ret    
80104d5d:	8d 76 00             	lea    0x0(%esi),%esi
  asm volatile("cld; rep stosb" : "=D"(addr), "=c"(cnt) : "0"(addr), "1"(cnt), "a"(data) : "memory", "cc");
80104d60:	89 d7                	mov    %edx,%edi
80104d62:	fc                   	cld    
80104d63:	f3 aa                	rep stos %al,%es:(%edi)
80104d65:	5b                   	pop    %ebx
80104d66:	89 d0                	mov    %edx,%eax
80104d68:	5f                   	pop    %edi
80104d69:	5d                   	pop    %ebp
80104d6a:	c3                   	ret    
80104d6b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104d6f:	90                   	nop

80104d70 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80104d70:	f3 0f 1e fb          	endbr32 
80104d74:	55                   	push   %ebp
80104d75:	89 e5                	mov    %esp,%ebp
80104d77:	56                   	push   %esi
80104d78:	8b 75 10             	mov    0x10(%ebp),%esi
80104d7b:	8b 55 08             	mov    0x8(%ebp),%edx
80104d7e:	53                   	push   %ebx
80104d7f:	8b 45 0c             	mov    0xc(%ebp),%eax
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
80104d82:	85 f6                	test   %esi,%esi
80104d84:	74 2a                	je     80104db0 <memcmp+0x40>
80104d86:	01 c6                	add    %eax,%esi
80104d88:	eb 10                	jmp    80104d9a <memcmp+0x2a>
80104d8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
80104d90:	83 c0 01             	add    $0x1,%eax
80104d93:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0){
80104d96:	39 f0                	cmp    %esi,%eax
80104d98:	74 16                	je     80104db0 <memcmp+0x40>
    if(*s1 != *s2)
80104d9a:	0f b6 0a             	movzbl (%edx),%ecx
80104d9d:	0f b6 18             	movzbl (%eax),%ebx
80104da0:	38 d9                	cmp    %bl,%cl
80104da2:	74 ec                	je     80104d90 <memcmp+0x20>
      return *s1 - *s2;
80104da4:	0f b6 c1             	movzbl %cl,%eax
80104da7:	29 d8                	sub    %ebx,%eax
  }

  return 0;
}
80104da9:	5b                   	pop    %ebx
80104daa:	5e                   	pop    %esi
80104dab:	5d                   	pop    %ebp
80104dac:	c3                   	ret    
80104dad:	8d 76 00             	lea    0x0(%esi),%esi
80104db0:	5b                   	pop    %ebx
  return 0;
80104db1:	31 c0                	xor    %eax,%eax
}
80104db3:	5e                   	pop    %esi
80104db4:	5d                   	pop    %ebp
80104db5:	c3                   	ret    
80104db6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104dbd:	8d 76 00             	lea    0x0(%esi),%esi

80104dc0 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80104dc0:	f3 0f 1e fb          	endbr32 
80104dc4:	55                   	push   %ebp
80104dc5:	89 e5                	mov    %esp,%ebp
80104dc7:	57                   	push   %edi
80104dc8:	8b 55 08             	mov    0x8(%ebp),%edx
80104dcb:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104dce:	56                   	push   %esi
80104dcf:	8b 75 0c             	mov    0xc(%ebp),%esi
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
80104dd2:	39 d6                	cmp    %edx,%esi
80104dd4:	73 2a                	jae    80104e00 <memmove+0x40>
80104dd6:	8d 3c 0e             	lea    (%esi,%ecx,1),%edi
80104dd9:	39 fa                	cmp    %edi,%edx
80104ddb:	73 23                	jae    80104e00 <memmove+0x40>
80104ddd:	8d 41 ff             	lea    -0x1(%ecx),%eax
    s += n;
    d += n;
    while(n-- > 0)
80104de0:	85 c9                	test   %ecx,%ecx
80104de2:	74 13                	je     80104df7 <memmove+0x37>
80104de4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      *--d = *--s;
80104de8:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
80104dec:	88 0c 02             	mov    %cl,(%edx,%eax,1)
    while(n-- > 0)
80104def:	83 e8 01             	sub    $0x1,%eax
80104df2:	83 f8 ff             	cmp    $0xffffffff,%eax
80104df5:	75 f1                	jne    80104de8 <memmove+0x28>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
80104df7:	5e                   	pop    %esi
80104df8:	89 d0                	mov    %edx,%eax
80104dfa:	5f                   	pop    %edi
80104dfb:	5d                   	pop    %ebp
80104dfc:	c3                   	ret    
80104dfd:	8d 76 00             	lea    0x0(%esi),%esi
    while(n-- > 0)
80104e00:	8d 04 0e             	lea    (%esi,%ecx,1),%eax
80104e03:	89 d7                	mov    %edx,%edi
80104e05:	85 c9                	test   %ecx,%ecx
80104e07:	74 ee                	je     80104df7 <memmove+0x37>
80104e09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      *d++ = *s++;
80104e10:	a4                   	movsb  %ds:(%esi),%es:(%edi)
    while(n-- > 0)
80104e11:	39 f0                	cmp    %esi,%eax
80104e13:	75 fb                	jne    80104e10 <memmove+0x50>
}
80104e15:	5e                   	pop    %esi
80104e16:	89 d0                	mov    %edx,%eax
80104e18:	5f                   	pop    %edi
80104e19:	5d                   	pop    %ebp
80104e1a:	c3                   	ret    
80104e1b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104e1f:	90                   	nop

80104e20 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
80104e20:	f3 0f 1e fb          	endbr32 
  return memmove(dst, src, n);
80104e24:	eb 9a                	jmp    80104dc0 <memmove>
80104e26:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104e2d:	8d 76 00             	lea    0x0(%esi),%esi

80104e30 <strncmp>:
}

int
strncmp(const char *p, const char *q, uint n)
{
80104e30:	f3 0f 1e fb          	endbr32 
80104e34:	55                   	push   %ebp
80104e35:	89 e5                	mov    %esp,%ebp
80104e37:	56                   	push   %esi
80104e38:	8b 75 10             	mov    0x10(%ebp),%esi
80104e3b:	8b 4d 08             	mov    0x8(%ebp),%ecx
80104e3e:	53                   	push   %ebx
80104e3f:	8b 45 0c             	mov    0xc(%ebp),%eax
  while(n > 0 && *p && *p == *q)
80104e42:	85 f6                	test   %esi,%esi
80104e44:	74 32                	je     80104e78 <strncmp+0x48>
80104e46:	01 c6                	add    %eax,%esi
80104e48:	eb 14                	jmp    80104e5e <strncmp+0x2e>
80104e4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104e50:	38 da                	cmp    %bl,%dl
80104e52:	75 14                	jne    80104e68 <strncmp+0x38>
    n--, p++, q++;
80104e54:	83 c0 01             	add    $0x1,%eax
80104e57:	83 c1 01             	add    $0x1,%ecx
  while(n > 0 && *p && *p == *q)
80104e5a:	39 f0                	cmp    %esi,%eax
80104e5c:	74 1a                	je     80104e78 <strncmp+0x48>
80104e5e:	0f b6 11             	movzbl (%ecx),%edx
80104e61:	0f b6 18             	movzbl (%eax),%ebx
80104e64:	84 d2                	test   %dl,%dl
80104e66:	75 e8                	jne    80104e50 <strncmp+0x20>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
80104e68:	0f b6 c2             	movzbl %dl,%eax
80104e6b:	29 d8                	sub    %ebx,%eax
}
80104e6d:	5b                   	pop    %ebx
80104e6e:	5e                   	pop    %esi
80104e6f:	5d                   	pop    %ebp
80104e70:	c3                   	ret    
80104e71:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104e78:	5b                   	pop    %ebx
    return 0;
80104e79:	31 c0                	xor    %eax,%eax
}
80104e7b:	5e                   	pop    %esi
80104e7c:	5d                   	pop    %ebp
80104e7d:	c3                   	ret    
80104e7e:	66 90                	xchg   %ax,%ax

80104e80 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80104e80:	f3 0f 1e fb          	endbr32 
80104e84:	55                   	push   %ebp
80104e85:	89 e5                	mov    %esp,%ebp
80104e87:	57                   	push   %edi
80104e88:	56                   	push   %esi
80104e89:	8b 75 08             	mov    0x8(%ebp),%esi
80104e8c:	53                   	push   %ebx
80104e8d:	8b 45 10             	mov    0x10(%ebp),%eax
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
80104e90:	89 f2                	mov    %esi,%edx
80104e92:	eb 1b                	jmp    80104eaf <strncpy+0x2f>
80104e94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104e98:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
80104e9c:	8b 7d 0c             	mov    0xc(%ebp),%edi
80104e9f:	83 c2 01             	add    $0x1,%edx
80104ea2:	0f b6 7f ff          	movzbl -0x1(%edi),%edi
80104ea6:	89 f9                	mov    %edi,%ecx
80104ea8:	88 4a ff             	mov    %cl,-0x1(%edx)
80104eab:	84 c9                	test   %cl,%cl
80104ead:	74 09                	je     80104eb8 <strncpy+0x38>
80104eaf:	89 c3                	mov    %eax,%ebx
80104eb1:	83 e8 01             	sub    $0x1,%eax
80104eb4:	85 db                	test   %ebx,%ebx
80104eb6:	7f e0                	jg     80104e98 <strncpy+0x18>
    ;
  while(n-- > 0)
80104eb8:	89 d1                	mov    %edx,%ecx
80104eba:	85 c0                	test   %eax,%eax
80104ebc:	7e 15                	jle    80104ed3 <strncpy+0x53>
80104ebe:	66 90                	xchg   %ax,%ax
    *s++ = 0;
80104ec0:	83 c1 01             	add    $0x1,%ecx
80104ec3:	c6 41 ff 00          	movb   $0x0,-0x1(%ecx)
  while(n-- > 0)
80104ec7:	89 c8                	mov    %ecx,%eax
80104ec9:	f7 d0                	not    %eax
80104ecb:	01 d0                	add    %edx,%eax
80104ecd:	01 d8                	add    %ebx,%eax
80104ecf:	85 c0                	test   %eax,%eax
80104ed1:	7f ed                	jg     80104ec0 <strncpy+0x40>
  return os;
}
80104ed3:	5b                   	pop    %ebx
80104ed4:	89 f0                	mov    %esi,%eax
80104ed6:	5e                   	pop    %esi
80104ed7:	5f                   	pop    %edi
80104ed8:	5d                   	pop    %ebp
80104ed9:	c3                   	ret    
80104eda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104ee0 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80104ee0:	f3 0f 1e fb          	endbr32 
80104ee4:	55                   	push   %ebp
80104ee5:	89 e5                	mov    %esp,%ebp
80104ee7:	56                   	push   %esi
80104ee8:	8b 55 10             	mov    0x10(%ebp),%edx
80104eeb:	8b 75 08             	mov    0x8(%ebp),%esi
80104eee:	53                   	push   %ebx
80104eef:	8b 45 0c             	mov    0xc(%ebp),%eax
  char *os;

  os = s;
  if(n <= 0)
80104ef2:	85 d2                	test   %edx,%edx
80104ef4:	7e 21                	jle    80104f17 <safestrcpy+0x37>
80104ef6:	8d 5c 10 ff          	lea    -0x1(%eax,%edx,1),%ebx
80104efa:	89 f2                	mov    %esi,%edx
80104efc:	eb 12                	jmp    80104f10 <safestrcpy+0x30>
80104efe:	66 90                	xchg   %ax,%ax
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80104f00:	0f b6 08             	movzbl (%eax),%ecx
80104f03:	83 c0 01             	add    $0x1,%eax
80104f06:	83 c2 01             	add    $0x1,%edx
80104f09:	88 4a ff             	mov    %cl,-0x1(%edx)
80104f0c:	84 c9                	test   %cl,%cl
80104f0e:	74 04                	je     80104f14 <safestrcpy+0x34>
80104f10:	39 d8                	cmp    %ebx,%eax
80104f12:	75 ec                	jne    80104f00 <safestrcpy+0x20>
    ;
  *s = 0;
80104f14:	c6 02 00             	movb   $0x0,(%edx)
  return os;
}
80104f17:	89 f0                	mov    %esi,%eax
80104f19:	5b                   	pop    %ebx
80104f1a:	5e                   	pop    %esi
80104f1b:	5d                   	pop    %ebp
80104f1c:	c3                   	ret    
80104f1d:	8d 76 00             	lea    0x0(%esi),%esi

80104f20 <strlen>:

int
strlen(const char *s)
{
80104f20:	f3 0f 1e fb          	endbr32 
80104f24:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80104f25:	31 c0                	xor    %eax,%eax
{
80104f27:	89 e5                	mov    %esp,%ebp
80104f29:	8b 55 08             	mov    0x8(%ebp),%edx
  for(n = 0; s[n]; n++)
80104f2c:	80 3a 00             	cmpb   $0x0,(%edx)
80104f2f:	74 10                	je     80104f41 <strlen+0x21>
80104f31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104f38:	83 c0 01             	add    $0x1,%eax
80104f3b:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80104f3f:	75 f7                	jne    80104f38 <strlen+0x18>
    ;
  return n;
}
80104f41:	5d                   	pop    %ebp
80104f42:	c3                   	ret    

80104f43 <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
80104f43:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
80104f47:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-saved registers
  pushl %ebp
80104f4b:	55                   	push   %ebp
  pushl %ebx
80104f4c:	53                   	push   %ebx
  pushl %esi
80104f4d:	56                   	push   %esi
  pushl %edi
80104f4e:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
80104f4f:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
80104f51:	89 d4                	mov    %edx,%esp

  # Load new callee-saved registers
  popl %edi
80104f53:	5f                   	pop    %edi
  popl %esi
80104f54:	5e                   	pop    %esi
  popl %ebx
80104f55:	5b                   	pop    %ebx
  popl %ebp
80104f56:	5d                   	pop    %ebp
  ret
80104f57:	c3                   	ret    
80104f58:	66 90                	xchg   %ax,%ax
80104f5a:	66 90                	xchg   %ax,%ax
80104f5c:	66 90                	xchg   %ax,%ax
80104f5e:	66 90                	xchg   %ax,%ax

80104f60 <fetchint>:
// library system call function. The saved user %esp points
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int fetchint(uint addr, int *ip)
{
80104f60:	f3 0f 1e fb          	endbr32 
80104f64:	55                   	push   %ebp
80104f65:	89 e5                	mov    %esp,%ebp
80104f67:	53                   	push   %ebx
80104f68:	83 ec 04             	sub    $0x4,%esp
80104f6b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
80104f6e:	e8 2d f0 ff ff       	call   80103fa0 <myproc>

  if (addr >= curproc->sz || addr + 4 > curproc->sz)
80104f73:	8b 00                	mov    (%eax),%eax
80104f75:	39 d8                	cmp    %ebx,%eax
80104f77:	76 17                	jbe    80104f90 <fetchint+0x30>
80104f79:	8d 53 04             	lea    0x4(%ebx),%edx
80104f7c:	39 d0                	cmp    %edx,%eax
80104f7e:	72 10                	jb     80104f90 <fetchint+0x30>
    return -1;
  *ip = *(int *)(addr);
80104f80:	8b 45 0c             	mov    0xc(%ebp),%eax
80104f83:	8b 13                	mov    (%ebx),%edx
80104f85:	89 10                	mov    %edx,(%eax)
  return 0;
80104f87:	31 c0                	xor    %eax,%eax
}
80104f89:	83 c4 04             	add    $0x4,%esp
80104f8c:	5b                   	pop    %ebx
80104f8d:	5d                   	pop    %ebp
80104f8e:	c3                   	ret    
80104f8f:	90                   	nop
    return -1;
80104f90:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104f95:	eb f2                	jmp    80104f89 <fetchint+0x29>
80104f97:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104f9e:	66 90                	xchg   %ax,%ax

80104fa0 <fetchstr>:

// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int fetchstr(uint addr, char **pp)
{
80104fa0:	f3 0f 1e fb          	endbr32 
80104fa4:	55                   	push   %ebp
80104fa5:	89 e5                	mov    %esp,%ebp
80104fa7:	53                   	push   %ebx
80104fa8:	83 ec 04             	sub    $0x4,%esp
80104fab:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
80104fae:	e8 ed ef ff ff       	call   80103fa0 <myproc>

  if (addr >= curproc->sz)
80104fb3:	39 18                	cmp    %ebx,(%eax)
80104fb5:	76 31                	jbe    80104fe8 <fetchstr+0x48>
    return -1;
  *pp = (char *)addr;
80104fb7:	8b 55 0c             	mov    0xc(%ebp),%edx
80104fba:	89 1a                	mov    %ebx,(%edx)
  ep = (char *)curproc->sz;
80104fbc:	8b 10                	mov    (%eax),%edx
  for (s = *pp; s < ep; s++)
80104fbe:	39 d3                	cmp    %edx,%ebx
80104fc0:	73 26                	jae    80104fe8 <fetchstr+0x48>
80104fc2:	89 d8                	mov    %ebx,%eax
80104fc4:	eb 11                	jmp    80104fd7 <fetchstr+0x37>
80104fc6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104fcd:	8d 76 00             	lea    0x0(%esi),%esi
80104fd0:	83 c0 01             	add    $0x1,%eax
80104fd3:	39 c2                	cmp    %eax,%edx
80104fd5:	76 11                	jbe    80104fe8 <fetchstr+0x48>
  {
    if (*s == 0)
80104fd7:	80 38 00             	cmpb   $0x0,(%eax)
80104fda:	75 f4                	jne    80104fd0 <fetchstr+0x30>
      return s - *pp;
  }
  return -1;
}
80104fdc:	83 c4 04             	add    $0x4,%esp
      return s - *pp;
80104fdf:	29 d8                	sub    %ebx,%eax
}
80104fe1:	5b                   	pop    %ebx
80104fe2:	5d                   	pop    %ebp
80104fe3:	c3                   	ret    
80104fe4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104fe8:	83 c4 04             	add    $0x4,%esp
    return -1;
80104feb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104ff0:	5b                   	pop    %ebx
80104ff1:	5d                   	pop    %ebp
80104ff2:	c3                   	ret    
80104ff3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104ffa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105000 <argint>:

// Fetch the nth 32-bit system call argument.
int argint(int n, int *ip)
{
80105000:	f3 0f 1e fb          	endbr32 
80105004:	55                   	push   %ebp
80105005:	89 e5                	mov    %esp,%ebp
80105007:	56                   	push   %esi
80105008:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4 * n, ip);
80105009:	e8 92 ef ff ff       	call   80103fa0 <myproc>
8010500e:	8b 55 08             	mov    0x8(%ebp),%edx
80105011:	8b 40 18             	mov    0x18(%eax),%eax
80105014:	8b 40 44             	mov    0x44(%eax),%eax
80105017:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
8010501a:	e8 81 ef ff ff       	call   80103fa0 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4 * n, ip);
8010501f:	8d 73 04             	lea    0x4(%ebx),%esi
  if (addr >= curproc->sz || addr + 4 > curproc->sz)
80105022:	8b 00                	mov    (%eax),%eax
80105024:	39 c6                	cmp    %eax,%esi
80105026:	73 18                	jae    80105040 <argint+0x40>
80105028:	8d 53 08             	lea    0x8(%ebx),%edx
8010502b:	39 d0                	cmp    %edx,%eax
8010502d:	72 11                	jb     80105040 <argint+0x40>
  *ip = *(int *)(addr);
8010502f:	8b 45 0c             	mov    0xc(%ebp),%eax
80105032:	8b 53 04             	mov    0x4(%ebx),%edx
80105035:	89 10                	mov    %edx,(%eax)
  return 0;
80105037:	31 c0                	xor    %eax,%eax
}
80105039:	5b                   	pop    %ebx
8010503a:	5e                   	pop    %esi
8010503b:	5d                   	pop    %ebp
8010503c:	c3                   	ret    
8010503d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80105040:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchint((myproc()->tf->esp) + 4 + 4 * n, ip);
80105045:	eb f2                	jmp    80105039 <argint+0x39>
80105047:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010504e:	66 90                	xchg   %ax,%ax

80105050 <argptr>:

// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int argptr(int n, char **pp, int size)
{
80105050:	f3 0f 1e fb          	endbr32 
80105054:	55                   	push   %ebp
80105055:	89 e5                	mov    %esp,%ebp
80105057:	56                   	push   %esi
80105058:	53                   	push   %ebx
80105059:	83 ec 10             	sub    $0x10,%esp
8010505c:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int i;
  struct proc *curproc = myproc();
8010505f:	e8 3c ef ff ff       	call   80103fa0 <myproc>

  if (argint(n, &i) < 0)
80105064:	83 ec 08             	sub    $0x8,%esp
  struct proc *curproc = myproc();
80105067:	89 c6                	mov    %eax,%esi
  if (argint(n, &i) < 0)
80105069:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010506c:	50                   	push   %eax
8010506d:	ff 75 08             	pushl  0x8(%ebp)
80105070:	e8 8b ff ff ff       	call   80105000 <argint>
    return -1;
  if (size < 0 || (uint)i >= curproc->sz || (uint)i + size > curproc->sz)
80105075:	83 c4 10             	add    $0x10,%esp
80105078:	85 c0                	test   %eax,%eax
8010507a:	78 24                	js     801050a0 <argptr+0x50>
8010507c:	85 db                	test   %ebx,%ebx
8010507e:	78 20                	js     801050a0 <argptr+0x50>
80105080:	8b 16                	mov    (%esi),%edx
80105082:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105085:	39 c2                	cmp    %eax,%edx
80105087:	76 17                	jbe    801050a0 <argptr+0x50>
80105089:	01 c3                	add    %eax,%ebx
8010508b:	39 da                	cmp    %ebx,%edx
8010508d:	72 11                	jb     801050a0 <argptr+0x50>
    return -1;
  *pp = (char *)i;
8010508f:	8b 55 0c             	mov    0xc(%ebp),%edx
80105092:	89 02                	mov    %eax,(%edx)
  return 0;
80105094:	31 c0                	xor    %eax,%eax
}
80105096:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105099:	5b                   	pop    %ebx
8010509a:	5e                   	pop    %esi
8010509b:	5d                   	pop    %ebp
8010509c:	c3                   	ret    
8010509d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
801050a0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801050a5:	eb ef                	jmp    80105096 <argptr+0x46>
801050a7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801050ae:	66 90                	xchg   %ax,%ax

801050b0 <argstr>:
// Fetch the nth word-sized system call argument as a string pointer.
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int argstr(int n, char **pp)
{
801050b0:	f3 0f 1e fb          	endbr32 
801050b4:	55                   	push   %ebp
801050b5:	89 e5                	mov    %esp,%ebp
801050b7:	83 ec 20             	sub    $0x20,%esp
  int addr;
  if (argint(n, &addr) < 0)
801050ba:	8d 45 f4             	lea    -0xc(%ebp),%eax
801050bd:	50                   	push   %eax
801050be:	ff 75 08             	pushl  0x8(%ebp)
801050c1:	e8 3a ff ff ff       	call   80105000 <argint>
801050c6:	83 c4 10             	add    $0x10,%esp
801050c9:	85 c0                	test   %eax,%eax
801050cb:	78 13                	js     801050e0 <argstr+0x30>
    return -1;
  return fetchstr(addr, pp);
801050cd:	83 ec 08             	sub    $0x8,%esp
801050d0:	ff 75 0c             	pushl  0xc(%ebp)
801050d3:	ff 75 f4             	pushl  -0xc(%ebp)
801050d6:	e8 c5 fe ff ff       	call   80104fa0 <fetchstr>
801050db:	83 c4 10             	add    $0x10,%esp
}
801050de:	c9                   	leave  
801050df:	c3                   	ret    
801050e0:	c9                   	leave  
    return -1;
801050e1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801050e6:	c3                   	ret    
801050e7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801050ee:	66 90                	xchg   %ax,%ax

801050f0 <syscall>:
    [SYS_copy_file] sys_copy_file,
    [SYS_get_uncle_count] sys_get_uncle_count,
};

void syscall(void)
{
801050f0:	f3 0f 1e fb          	endbr32 
801050f4:	55                   	push   %ebp
801050f5:	89 e5                	mov    %esp,%ebp
801050f7:	53                   	push   %ebx
801050f8:	83 ec 04             	sub    $0x4,%esp
  int num;
  struct proc *curproc = myproc();
801050fb:	e8 a0 ee ff ff       	call   80103fa0 <myproc>
80105100:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax;
80105102:	8b 40 18             	mov    0x18(%eax),%eax
80105105:	8b 40 1c             	mov    0x1c(%eax),%eax
  if (num > 0 && num < NELEM(syscalls) && syscalls[num])
80105108:	8d 50 ff             	lea    -0x1(%eax),%edx
8010510b:	83 fa 17             	cmp    $0x17,%edx
8010510e:	77 20                	ja     80105130 <syscall+0x40>
80105110:	8b 14 85 60 7f 10 80 	mov    -0x7fef80a0(,%eax,4),%edx
80105117:	85 d2                	test   %edx,%edx
80105119:	74 15                	je     80105130 <syscall+0x40>
  {
    curproc->tf->eax = syscalls[num]();
8010511b:	ff d2                	call   *%edx
8010511d:	89 c2                	mov    %eax,%edx
8010511f:	8b 43 18             	mov    0x18(%ebx),%eax
80105122:	89 50 1c             	mov    %edx,0x1c(%eax)
  {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
80105125:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105128:	c9                   	leave  
80105129:	c3                   	ret    
8010512a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cprintf("%d %s: unknown sys call %d\n",
80105130:	50                   	push   %eax
            curproc->pid, curproc->name, num);
80105131:	8d 43 6c             	lea    0x6c(%ebx),%eax
    cprintf("%d %s: unknown sys call %d\n",
80105134:	50                   	push   %eax
80105135:	ff 73 10             	pushl  0x10(%ebx)
80105138:	68 3d 7f 10 80       	push   $0x80107f3d
8010513d:	e8 5e b6 ff ff       	call   801007a0 <cprintf>
    curproc->tf->eax = -1;
80105142:	8b 43 18             	mov    0x18(%ebx),%eax
80105145:	83 c4 10             	add    $0x10,%esp
80105148:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
8010514f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105152:	c9                   	leave  
80105153:	c3                   	ret    
80105154:	66 90                	xchg   %ax,%ax
80105156:	66 90                	xchg   %ax,%ax
80105158:	66 90                	xchg   %ax,%ax
8010515a:	66 90                	xchg   %ax,%ax
8010515c:	66 90                	xchg   %ax,%ax
8010515e:	66 90                	xchg   %ax,%ax

80105160 <create>:
  return -1;
}

static struct inode *
create(char *path, short type, short major, short minor)
{
80105160:	55                   	push   %ebp
80105161:	89 e5                	mov    %esp,%ebp
80105163:	57                   	push   %edi
80105164:	56                   	push   %esi
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if ((dp = nameiparent(path, name)) == 0)
80105165:	8d 7d da             	lea    -0x26(%ebp),%edi
{
80105168:	53                   	push   %ebx
80105169:	83 ec 34             	sub    $0x34,%esp
8010516c:	89 4d d0             	mov    %ecx,-0x30(%ebp)
8010516f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  if ((dp = nameiparent(path, name)) == 0)
80105172:	57                   	push   %edi
80105173:	50                   	push   %eax
{
80105174:	89 55 d4             	mov    %edx,-0x2c(%ebp)
80105177:	89 4d cc             	mov    %ecx,-0x34(%ebp)
  if ((dp = nameiparent(path, name)) == 0)
8010517a:	e8 11 d5 ff ff       	call   80102690 <nameiparent>
8010517f:	83 c4 10             	add    $0x10,%esp
80105182:	85 c0                	test   %eax,%eax
80105184:	0f 84 46 01 00 00    	je     801052d0 <create+0x170>
    return 0;
  ilock(dp);
8010518a:	83 ec 0c             	sub    $0xc,%esp
8010518d:	89 c3                	mov    %eax,%ebx
8010518f:	50                   	push   %eax
80105190:	e8 0b cc ff ff       	call   80101da0 <ilock>

  if ((ip = dirlookup(dp, name, 0)) != 0)
80105195:	83 c4 0c             	add    $0xc,%esp
80105198:	6a 00                	push   $0x0
8010519a:	57                   	push   %edi
8010519b:	53                   	push   %ebx
8010519c:	e8 4f d1 ff ff       	call   801022f0 <dirlookup>
801051a1:	83 c4 10             	add    $0x10,%esp
801051a4:	89 c6                	mov    %eax,%esi
801051a6:	85 c0                	test   %eax,%eax
801051a8:	74 56                	je     80105200 <create+0xa0>
  {
    iunlockput(dp);
801051aa:	83 ec 0c             	sub    $0xc,%esp
801051ad:	53                   	push   %ebx
801051ae:	e8 8d ce ff ff       	call   80102040 <iunlockput>
    ilock(ip);
801051b3:	89 34 24             	mov    %esi,(%esp)
801051b6:	e8 e5 cb ff ff       	call   80101da0 <ilock>
    if (type == T_FILE && ip->type == T_FILE)
801051bb:	83 c4 10             	add    $0x10,%esp
801051be:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
801051c3:	75 1b                	jne    801051e0 <create+0x80>
801051c5:	66 83 7e 50 02       	cmpw   $0x2,0x50(%esi)
801051ca:	75 14                	jne    801051e0 <create+0x80>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
801051cc:	8d 65 f4             	lea    -0xc(%ebp),%esp
801051cf:	89 f0                	mov    %esi,%eax
801051d1:	5b                   	pop    %ebx
801051d2:	5e                   	pop    %esi
801051d3:	5f                   	pop    %edi
801051d4:	5d                   	pop    %ebp
801051d5:	c3                   	ret    
801051d6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801051dd:	8d 76 00             	lea    0x0(%esi),%esi
    iunlockput(ip);
801051e0:	83 ec 0c             	sub    $0xc,%esp
801051e3:	56                   	push   %esi
    return 0;
801051e4:	31 f6                	xor    %esi,%esi
    iunlockput(ip);
801051e6:	e8 55 ce ff ff       	call   80102040 <iunlockput>
    return 0;
801051eb:	83 c4 10             	add    $0x10,%esp
}
801051ee:	8d 65 f4             	lea    -0xc(%ebp),%esp
801051f1:	89 f0                	mov    %esi,%eax
801051f3:	5b                   	pop    %ebx
801051f4:	5e                   	pop    %esi
801051f5:	5f                   	pop    %edi
801051f6:	5d                   	pop    %ebp
801051f7:	c3                   	ret    
801051f8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801051ff:	90                   	nop
  if ((ip = ialloc(dp->dev, type)) == 0)
80105200:	0f bf 45 d4          	movswl -0x2c(%ebp),%eax
80105204:	83 ec 08             	sub    $0x8,%esp
80105207:	50                   	push   %eax
80105208:	ff 33                	pushl  (%ebx)
8010520a:	e8 11 ca ff ff       	call   80101c20 <ialloc>
8010520f:	83 c4 10             	add    $0x10,%esp
80105212:	89 c6                	mov    %eax,%esi
80105214:	85 c0                	test   %eax,%eax
80105216:	0f 84 cd 00 00 00    	je     801052e9 <create+0x189>
  ilock(ip);
8010521c:	83 ec 0c             	sub    $0xc,%esp
8010521f:	50                   	push   %eax
80105220:	e8 7b cb ff ff       	call   80101da0 <ilock>
  ip->major = major;
80105225:	0f b7 45 d0          	movzwl -0x30(%ebp),%eax
80105229:	66 89 46 52          	mov    %ax,0x52(%esi)
  ip->minor = minor;
8010522d:	0f b7 45 cc          	movzwl -0x34(%ebp),%eax
80105231:	66 89 46 54          	mov    %ax,0x54(%esi)
  ip->nlink = 1;
80105235:	b8 01 00 00 00       	mov    $0x1,%eax
8010523a:	66 89 46 56          	mov    %ax,0x56(%esi)
  iupdate(ip);
8010523e:	89 34 24             	mov    %esi,(%esp)
80105241:	e8 9a ca ff ff       	call   80101ce0 <iupdate>
  if (type == T_DIR)
80105246:	83 c4 10             	add    $0x10,%esp
80105249:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
8010524e:	74 30                	je     80105280 <create+0x120>
  if (dirlink(dp, name, ip->inum) < 0)
80105250:	83 ec 04             	sub    $0x4,%esp
80105253:	ff 76 04             	pushl  0x4(%esi)
80105256:	57                   	push   %edi
80105257:	53                   	push   %ebx
80105258:	e8 53 d3 ff ff       	call   801025b0 <dirlink>
8010525d:	83 c4 10             	add    $0x10,%esp
80105260:	85 c0                	test   %eax,%eax
80105262:	78 78                	js     801052dc <create+0x17c>
  iunlockput(dp);
80105264:	83 ec 0c             	sub    $0xc,%esp
80105267:	53                   	push   %ebx
80105268:	e8 d3 cd ff ff       	call   80102040 <iunlockput>
  return ip;
8010526d:	83 c4 10             	add    $0x10,%esp
}
80105270:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105273:	89 f0                	mov    %esi,%eax
80105275:	5b                   	pop    %ebx
80105276:	5e                   	pop    %esi
80105277:	5f                   	pop    %edi
80105278:	5d                   	pop    %ebp
80105279:	c3                   	ret    
8010527a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iupdate(dp);
80105280:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink++; // for ".."
80105283:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
    iupdate(dp);
80105288:	53                   	push   %ebx
80105289:	e8 52 ca ff ff       	call   80101ce0 <iupdate>
    if (dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
8010528e:	83 c4 0c             	add    $0xc,%esp
80105291:	ff 76 04             	pushl  0x4(%esi)
80105294:	68 e0 7f 10 80       	push   $0x80107fe0
80105299:	56                   	push   %esi
8010529a:	e8 11 d3 ff ff       	call   801025b0 <dirlink>
8010529f:	83 c4 10             	add    $0x10,%esp
801052a2:	85 c0                	test   %eax,%eax
801052a4:	78 18                	js     801052be <create+0x15e>
801052a6:	83 ec 04             	sub    $0x4,%esp
801052a9:	ff 73 04             	pushl  0x4(%ebx)
801052ac:	68 df 7f 10 80       	push   $0x80107fdf
801052b1:	56                   	push   %esi
801052b2:	e8 f9 d2 ff ff       	call   801025b0 <dirlink>
801052b7:	83 c4 10             	add    $0x10,%esp
801052ba:	85 c0                	test   %eax,%eax
801052bc:	79 92                	jns    80105250 <create+0xf0>
      panic("create dots");
801052be:	83 ec 0c             	sub    $0xc,%esp
801052c1:	68 d3 7f 10 80       	push   $0x80107fd3
801052c6:	e8 e5 b0 ff ff       	call   801003b0 <panic>
801052cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801052cf:	90                   	nop
}
801052d0:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
801052d3:	31 f6                	xor    %esi,%esi
}
801052d5:	5b                   	pop    %ebx
801052d6:	89 f0                	mov    %esi,%eax
801052d8:	5e                   	pop    %esi
801052d9:	5f                   	pop    %edi
801052da:	5d                   	pop    %ebp
801052db:	c3                   	ret    
    panic("create: dirlink");
801052dc:	83 ec 0c             	sub    $0xc,%esp
801052df:	68 e2 7f 10 80       	push   $0x80107fe2
801052e4:	e8 c7 b0 ff ff       	call   801003b0 <panic>
    panic("create: ialloc");
801052e9:	83 ec 0c             	sub    $0xc,%esp
801052ec:	68 c4 7f 10 80       	push   $0x80107fc4
801052f1:	e8 ba b0 ff ff       	call   801003b0 <panic>
801052f6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801052fd:	8d 76 00             	lea    0x0(%esi),%esi

80105300 <argfd.constprop.0>:
argfd(int n, int *pfd, struct file **pf)
80105300:	55                   	push   %ebp
80105301:	89 e5                	mov    %esp,%ebp
80105303:	56                   	push   %esi
80105304:	89 d6                	mov    %edx,%esi
80105306:	53                   	push   %ebx
80105307:	89 c3                	mov    %eax,%ebx
  if (argint(n, &fd) < 0)
80105309:	8d 45 f4             	lea    -0xc(%ebp),%eax
argfd(int n, int *pfd, struct file **pf)
8010530c:	83 ec 18             	sub    $0x18,%esp
  if (argint(n, &fd) < 0)
8010530f:	50                   	push   %eax
80105310:	6a 00                	push   $0x0
80105312:	e8 e9 fc ff ff       	call   80105000 <argint>
80105317:	83 c4 10             	add    $0x10,%esp
8010531a:	85 c0                	test   %eax,%eax
8010531c:	78 2a                	js     80105348 <argfd.constprop.0+0x48>
  if (fd < 0 || fd >= NOFILE || (f = myproc()->ofile[fd]) == 0)
8010531e:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80105322:	77 24                	ja     80105348 <argfd.constprop.0+0x48>
80105324:	e8 77 ec ff ff       	call   80103fa0 <myproc>
80105329:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010532c:	8b 44 90 28          	mov    0x28(%eax,%edx,4),%eax
80105330:	85 c0                	test   %eax,%eax
80105332:	74 14                	je     80105348 <argfd.constprop.0+0x48>
  if (pfd)
80105334:	85 db                	test   %ebx,%ebx
80105336:	74 02                	je     8010533a <argfd.constprop.0+0x3a>
    *pfd = fd;
80105338:	89 13                	mov    %edx,(%ebx)
    *pf = f;
8010533a:	89 06                	mov    %eax,(%esi)
  return 0;
8010533c:	31 c0                	xor    %eax,%eax
}
8010533e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105341:	5b                   	pop    %ebx
80105342:	5e                   	pop    %esi
80105343:	5d                   	pop    %ebp
80105344:	c3                   	ret    
80105345:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80105348:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010534d:	eb ef                	jmp    8010533e <argfd.constprop.0+0x3e>
8010534f:	90                   	nop

80105350 <sys_dup>:
{
80105350:	f3 0f 1e fb          	endbr32 
80105354:	55                   	push   %ebp
  if (argfd(0, 0, &f) < 0)
80105355:	31 c0                	xor    %eax,%eax
{
80105357:	89 e5                	mov    %esp,%ebp
80105359:	56                   	push   %esi
8010535a:	53                   	push   %ebx
  if (argfd(0, 0, &f) < 0)
8010535b:	8d 55 f4             	lea    -0xc(%ebp),%edx
{
8010535e:	83 ec 10             	sub    $0x10,%esp
  if (argfd(0, 0, &f) < 0)
80105361:	e8 9a ff ff ff       	call   80105300 <argfd.constprop.0>
80105366:	85 c0                	test   %eax,%eax
80105368:	78 1e                	js     80105388 <sys_dup+0x38>
  if ((fd = fdalloc(f)) < 0)
8010536a:	8b 75 f4             	mov    -0xc(%ebp),%esi
  for (fd = 0; fd < NOFILE; fd++)
8010536d:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
8010536f:	e8 2c ec ff ff       	call   80103fa0 <myproc>
  for (fd = 0; fd < NOFILE; fd++)
80105374:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if (curproc->ofile[fd] == 0)
80105378:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
8010537c:	85 d2                	test   %edx,%edx
8010537e:	74 20                	je     801053a0 <sys_dup+0x50>
  for (fd = 0; fd < NOFILE; fd++)
80105380:	83 c3 01             	add    $0x1,%ebx
80105383:	83 fb 10             	cmp    $0x10,%ebx
80105386:	75 f0                	jne    80105378 <sys_dup+0x28>
}
80105388:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return -1;
8010538b:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
80105390:	89 d8                	mov    %ebx,%eax
80105392:	5b                   	pop    %ebx
80105393:	5e                   	pop    %esi
80105394:	5d                   	pop    %ebp
80105395:	c3                   	ret    
80105396:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010539d:	8d 76 00             	lea    0x0(%esi),%esi
      curproc->ofile[fd] = f;
801053a0:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)
  filedup(f);
801053a4:	83 ec 0c             	sub    $0xc,%esp
801053a7:	ff 75 f4             	pushl  -0xc(%ebp)
801053aa:	e8 01 c1 ff ff       	call   801014b0 <filedup>
  return fd;
801053af:	83 c4 10             	add    $0x10,%esp
}
801053b2:	8d 65 f8             	lea    -0x8(%ebp),%esp
801053b5:	89 d8                	mov    %ebx,%eax
801053b7:	5b                   	pop    %ebx
801053b8:	5e                   	pop    %esi
801053b9:	5d                   	pop    %ebp
801053ba:	c3                   	ret    
801053bb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801053bf:	90                   	nop

801053c0 <sys_read>:
{
801053c0:	f3 0f 1e fb          	endbr32 
801053c4:	55                   	push   %ebp
  if (argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
801053c5:	31 c0                	xor    %eax,%eax
{
801053c7:	89 e5                	mov    %esp,%ebp
801053c9:	83 ec 18             	sub    $0x18,%esp
  if (argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
801053cc:	8d 55 ec             	lea    -0x14(%ebp),%edx
801053cf:	e8 2c ff ff ff       	call   80105300 <argfd.constprop.0>
801053d4:	85 c0                	test   %eax,%eax
801053d6:	78 48                	js     80105420 <sys_read+0x60>
801053d8:	83 ec 08             	sub    $0x8,%esp
801053db:	8d 45 f0             	lea    -0x10(%ebp),%eax
801053de:	50                   	push   %eax
801053df:	6a 02                	push   $0x2
801053e1:	e8 1a fc ff ff       	call   80105000 <argint>
801053e6:	83 c4 10             	add    $0x10,%esp
801053e9:	85 c0                	test   %eax,%eax
801053eb:	78 33                	js     80105420 <sys_read+0x60>
801053ed:	83 ec 04             	sub    $0x4,%esp
801053f0:	8d 45 f4             	lea    -0xc(%ebp),%eax
801053f3:	ff 75 f0             	pushl  -0x10(%ebp)
801053f6:	50                   	push   %eax
801053f7:	6a 01                	push   $0x1
801053f9:	e8 52 fc ff ff       	call   80105050 <argptr>
801053fe:	83 c4 10             	add    $0x10,%esp
80105401:	85 c0                	test   %eax,%eax
80105403:	78 1b                	js     80105420 <sys_read+0x60>
  return fileread(f, p, n);
80105405:	83 ec 04             	sub    $0x4,%esp
80105408:	ff 75 f0             	pushl  -0x10(%ebp)
8010540b:	ff 75 f4             	pushl  -0xc(%ebp)
8010540e:	ff 75 ec             	pushl  -0x14(%ebp)
80105411:	e8 1a c2 ff ff       	call   80101630 <fileread>
80105416:	83 c4 10             	add    $0x10,%esp
}
80105419:	c9                   	leave  
8010541a:	c3                   	ret    
8010541b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010541f:	90                   	nop
80105420:	c9                   	leave  
    return -1;
80105421:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105426:	c3                   	ret    
80105427:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010542e:	66 90                	xchg   %ax,%ax

80105430 <sys_write>:
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
8010543f:	e8 bc fe ff ff       	call   80105300 <argfd.constprop.0>
80105444:	85 c0                	test   %eax,%eax
80105446:	78 48                	js     80105490 <sys_write+0x60>
80105448:	83 ec 08             	sub    $0x8,%esp
8010544b:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010544e:	50                   	push   %eax
8010544f:	6a 02                	push   $0x2
80105451:	e8 aa fb ff ff       	call   80105000 <argint>
80105456:	83 c4 10             	add    $0x10,%esp
80105459:	85 c0                	test   %eax,%eax
8010545b:	78 33                	js     80105490 <sys_write+0x60>
8010545d:	83 ec 04             	sub    $0x4,%esp
80105460:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105463:	ff 75 f0             	pushl  -0x10(%ebp)
80105466:	50                   	push   %eax
80105467:	6a 01                	push   $0x1
80105469:	e8 e2 fb ff ff       	call   80105050 <argptr>
8010546e:	83 c4 10             	add    $0x10,%esp
80105471:	85 c0                	test   %eax,%eax
80105473:	78 1b                	js     80105490 <sys_write+0x60>
  return filewrite(f, p, n);
80105475:	83 ec 04             	sub    $0x4,%esp
80105478:	ff 75 f0             	pushl  -0x10(%ebp)
8010547b:	ff 75 f4             	pushl  -0xc(%ebp)
8010547e:	ff 75 ec             	pushl  -0x14(%ebp)
80105481:	e8 4a c2 ff ff       	call   801016d0 <filewrite>
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

801054a0 <sys_close>:
{
801054a0:	f3 0f 1e fb          	endbr32 
801054a4:	55                   	push   %ebp
801054a5:	89 e5                	mov    %esp,%ebp
801054a7:	83 ec 18             	sub    $0x18,%esp
  if (argfd(0, &fd, &f) < 0)
801054aa:	8d 55 f4             	lea    -0xc(%ebp),%edx
801054ad:	8d 45 f0             	lea    -0x10(%ebp),%eax
801054b0:	e8 4b fe ff ff       	call   80105300 <argfd.constprop.0>
801054b5:	85 c0                	test   %eax,%eax
801054b7:	78 27                	js     801054e0 <sys_close+0x40>
  myproc()->ofile[fd] = 0;
801054b9:	e8 e2 ea ff ff       	call   80103fa0 <myproc>
801054be:	8b 55 f0             	mov    -0x10(%ebp),%edx
  fileclose(f);
801054c1:	83 ec 0c             	sub    $0xc,%esp
  myproc()->ofile[fd] = 0;
801054c4:	c7 44 90 28 00 00 00 	movl   $0x0,0x28(%eax,%edx,4)
801054cb:	00 
  fileclose(f);
801054cc:	ff 75 f4             	pushl  -0xc(%ebp)
801054cf:	e8 2c c0 ff ff       	call   80101500 <fileclose>
  return 0;
801054d4:	83 c4 10             	add    $0x10,%esp
801054d7:	31 c0                	xor    %eax,%eax
}
801054d9:	c9                   	leave  
801054da:	c3                   	ret    
801054db:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801054df:	90                   	nop
801054e0:	c9                   	leave  
    return -1;
801054e1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801054e6:	c3                   	ret    
801054e7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801054ee:	66 90                	xchg   %ax,%ax

801054f0 <sys_fstat>:
{
801054f0:	f3 0f 1e fb          	endbr32 
801054f4:	55                   	push   %ebp
  if (argfd(0, 0, &f) < 0 || argptr(1, (void *)&st, sizeof(*st)) < 0)
801054f5:	31 c0                	xor    %eax,%eax
{
801054f7:	89 e5                	mov    %esp,%ebp
801054f9:	83 ec 18             	sub    $0x18,%esp
  if (argfd(0, 0, &f) < 0 || argptr(1, (void *)&st, sizeof(*st)) < 0)
801054fc:	8d 55 f0             	lea    -0x10(%ebp),%edx
801054ff:	e8 fc fd ff ff       	call   80105300 <argfd.constprop.0>
80105504:	85 c0                	test   %eax,%eax
80105506:	78 30                	js     80105538 <sys_fstat+0x48>
80105508:	83 ec 04             	sub    $0x4,%esp
8010550b:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010550e:	6a 14                	push   $0x14
80105510:	50                   	push   %eax
80105511:	6a 01                	push   $0x1
80105513:	e8 38 fb ff ff       	call   80105050 <argptr>
80105518:	83 c4 10             	add    $0x10,%esp
8010551b:	85 c0                	test   %eax,%eax
8010551d:	78 19                	js     80105538 <sys_fstat+0x48>
  return filestat(f, st);
8010551f:	83 ec 08             	sub    $0x8,%esp
80105522:	ff 75 f4             	pushl  -0xc(%ebp)
80105525:	ff 75 f0             	pushl  -0x10(%ebp)
80105528:	e8 b3 c0 ff ff       	call   801015e0 <filestat>
8010552d:	83 c4 10             	add    $0x10,%esp
}
80105530:	c9                   	leave  
80105531:	c3                   	ret    
80105532:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105538:	c9                   	leave  
    return -1;
80105539:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010553e:	c3                   	ret    
8010553f:	90                   	nop

80105540 <sys_link>:
{
80105540:	f3 0f 1e fb          	endbr32 
80105544:	55                   	push   %ebp
80105545:	89 e5                	mov    %esp,%ebp
80105547:	57                   	push   %edi
80105548:	56                   	push   %esi
  if (argstr(0, &old) < 0 || argstr(1, &new) < 0)
80105549:	8d 45 d4             	lea    -0x2c(%ebp),%eax
{
8010554c:	53                   	push   %ebx
8010554d:	83 ec 34             	sub    $0x34,%esp
  if (argstr(0, &old) < 0 || argstr(1, &new) < 0)
80105550:	50                   	push   %eax
80105551:	6a 00                	push   $0x0
80105553:	e8 58 fb ff ff       	call   801050b0 <argstr>
80105558:	83 c4 10             	add    $0x10,%esp
8010555b:	85 c0                	test   %eax,%eax
8010555d:	0f 88 ff 00 00 00    	js     80105662 <sys_link+0x122>
80105563:	83 ec 08             	sub    $0x8,%esp
80105566:	8d 45 d0             	lea    -0x30(%ebp),%eax
80105569:	50                   	push   %eax
8010556a:	6a 01                	push   $0x1
8010556c:	e8 3f fb ff ff       	call   801050b0 <argstr>
80105571:	83 c4 10             	add    $0x10,%esp
80105574:	85 c0                	test   %eax,%eax
80105576:	0f 88 e6 00 00 00    	js     80105662 <sys_link+0x122>
  begin_op();
8010557c:	e8 ef dd ff ff       	call   80103370 <begin_op>
  if ((ip = namei(old)) == 0)
80105581:	83 ec 0c             	sub    $0xc,%esp
80105584:	ff 75 d4             	pushl  -0x2c(%ebp)
80105587:	e8 e4 d0 ff ff       	call   80102670 <namei>
8010558c:	83 c4 10             	add    $0x10,%esp
8010558f:	89 c3                	mov    %eax,%ebx
80105591:	85 c0                	test   %eax,%eax
80105593:	0f 84 e8 00 00 00    	je     80105681 <sys_link+0x141>
  ilock(ip);
80105599:	83 ec 0c             	sub    $0xc,%esp
8010559c:	50                   	push   %eax
8010559d:	e8 fe c7 ff ff       	call   80101da0 <ilock>
  if (ip->type == T_DIR)
801055a2:	83 c4 10             	add    $0x10,%esp
801055a5:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801055aa:	0f 84 b9 00 00 00    	je     80105669 <sys_link+0x129>
  iupdate(ip);
801055b0:	83 ec 0c             	sub    $0xc,%esp
  ip->nlink++;
801055b3:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  if ((dp = nameiparent(new, name)) == 0)
801055b8:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
801055bb:	53                   	push   %ebx
801055bc:	e8 1f c7 ff ff       	call   80101ce0 <iupdate>
  iunlock(ip);
801055c1:	89 1c 24             	mov    %ebx,(%esp)
801055c4:	e8 b7 c8 ff ff       	call   80101e80 <iunlock>
  if ((dp = nameiparent(new, name)) == 0)
801055c9:	58                   	pop    %eax
801055ca:	5a                   	pop    %edx
801055cb:	57                   	push   %edi
801055cc:	ff 75 d0             	pushl  -0x30(%ebp)
801055cf:	e8 bc d0 ff ff       	call   80102690 <nameiparent>
801055d4:	83 c4 10             	add    $0x10,%esp
801055d7:	89 c6                	mov    %eax,%esi
801055d9:	85 c0                	test   %eax,%eax
801055db:	74 5f                	je     8010563c <sys_link+0xfc>
  ilock(dp);
801055dd:	83 ec 0c             	sub    $0xc,%esp
801055e0:	50                   	push   %eax
801055e1:	e8 ba c7 ff ff       	call   80101da0 <ilock>
  if (dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0)
801055e6:	8b 03                	mov    (%ebx),%eax
801055e8:	83 c4 10             	add    $0x10,%esp
801055eb:	39 06                	cmp    %eax,(%esi)
801055ed:	75 41                	jne    80105630 <sys_link+0xf0>
801055ef:	83 ec 04             	sub    $0x4,%esp
801055f2:	ff 73 04             	pushl  0x4(%ebx)
801055f5:	57                   	push   %edi
801055f6:	56                   	push   %esi
801055f7:	e8 b4 cf ff ff       	call   801025b0 <dirlink>
801055fc:	83 c4 10             	add    $0x10,%esp
801055ff:	85 c0                	test   %eax,%eax
80105601:	78 2d                	js     80105630 <sys_link+0xf0>
  iunlockput(dp);
80105603:	83 ec 0c             	sub    $0xc,%esp
80105606:	56                   	push   %esi
80105607:	e8 34 ca ff ff       	call   80102040 <iunlockput>
  iput(ip);
8010560c:	89 1c 24             	mov    %ebx,(%esp)
8010560f:	e8 bc c8 ff ff       	call   80101ed0 <iput>
  end_op();
80105614:	e8 c7 dd ff ff       	call   801033e0 <end_op>
  return 0;
80105619:	83 c4 10             	add    $0x10,%esp
8010561c:	31 c0                	xor    %eax,%eax
}
8010561e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105621:	5b                   	pop    %ebx
80105622:	5e                   	pop    %esi
80105623:	5f                   	pop    %edi
80105624:	5d                   	pop    %ebp
80105625:	c3                   	ret    
80105626:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010562d:	8d 76 00             	lea    0x0(%esi),%esi
    iunlockput(dp);
80105630:	83 ec 0c             	sub    $0xc,%esp
80105633:	56                   	push   %esi
80105634:	e8 07 ca ff ff       	call   80102040 <iunlockput>
    goto bad;
80105639:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
8010563c:	83 ec 0c             	sub    $0xc,%esp
8010563f:	53                   	push   %ebx
80105640:	e8 5b c7 ff ff       	call   80101da0 <ilock>
  ip->nlink--;
80105645:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
8010564a:	89 1c 24             	mov    %ebx,(%esp)
8010564d:	e8 8e c6 ff ff       	call   80101ce0 <iupdate>
  iunlockput(ip);
80105652:	89 1c 24             	mov    %ebx,(%esp)
80105655:	e8 e6 c9 ff ff       	call   80102040 <iunlockput>
  end_op();
8010565a:	e8 81 dd ff ff       	call   801033e0 <end_op>
  return -1;
8010565f:	83 c4 10             	add    $0x10,%esp
80105662:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105667:	eb b5                	jmp    8010561e <sys_link+0xde>
    iunlockput(ip);
80105669:	83 ec 0c             	sub    $0xc,%esp
8010566c:	53                   	push   %ebx
8010566d:	e8 ce c9 ff ff       	call   80102040 <iunlockput>
    end_op();
80105672:	e8 69 dd ff ff       	call   801033e0 <end_op>
    return -1;
80105677:	83 c4 10             	add    $0x10,%esp
8010567a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010567f:	eb 9d                	jmp    8010561e <sys_link+0xde>
    end_op();
80105681:	e8 5a dd ff ff       	call   801033e0 <end_op>
    return -1;
80105686:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010568b:	eb 91                	jmp    8010561e <sys_link+0xde>
8010568d:	8d 76 00             	lea    0x0(%esi),%esi

80105690 <sys_unlink>:
{
80105690:	f3 0f 1e fb          	endbr32 
80105694:	55                   	push   %ebp
80105695:	89 e5                	mov    %esp,%ebp
80105697:	57                   	push   %edi
80105698:	56                   	push   %esi
  if (argstr(0, &path) < 0)
80105699:	8d 45 c0             	lea    -0x40(%ebp),%eax
{
8010569c:	53                   	push   %ebx
8010569d:	83 ec 54             	sub    $0x54,%esp
  if (argstr(0, &path) < 0)
801056a0:	50                   	push   %eax
801056a1:	6a 00                	push   $0x0
801056a3:	e8 08 fa ff ff       	call   801050b0 <argstr>
801056a8:	83 c4 10             	add    $0x10,%esp
801056ab:	85 c0                	test   %eax,%eax
801056ad:	0f 88 7d 01 00 00    	js     80105830 <sys_unlink+0x1a0>
  begin_op();
801056b3:	e8 b8 dc ff ff       	call   80103370 <begin_op>
  if ((dp = nameiparent(path, name)) == 0)
801056b8:	8d 5d ca             	lea    -0x36(%ebp),%ebx
801056bb:	83 ec 08             	sub    $0x8,%esp
801056be:	53                   	push   %ebx
801056bf:	ff 75 c0             	pushl  -0x40(%ebp)
801056c2:	e8 c9 cf ff ff       	call   80102690 <nameiparent>
801056c7:	83 c4 10             	add    $0x10,%esp
801056ca:	89 c6                	mov    %eax,%esi
801056cc:	85 c0                	test   %eax,%eax
801056ce:	0f 84 66 01 00 00    	je     8010583a <sys_unlink+0x1aa>
  ilock(dp);
801056d4:	83 ec 0c             	sub    $0xc,%esp
801056d7:	50                   	push   %eax
801056d8:	e8 c3 c6 ff ff       	call   80101da0 <ilock>
  if (namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
801056dd:	58                   	pop    %eax
801056de:	5a                   	pop    %edx
801056df:	68 e0 7f 10 80       	push   $0x80107fe0
801056e4:	53                   	push   %ebx
801056e5:	e8 e6 cb ff ff       	call   801022d0 <namecmp>
801056ea:	83 c4 10             	add    $0x10,%esp
801056ed:	85 c0                	test   %eax,%eax
801056ef:	0f 84 03 01 00 00    	je     801057f8 <sys_unlink+0x168>
801056f5:	83 ec 08             	sub    $0x8,%esp
801056f8:	68 df 7f 10 80       	push   $0x80107fdf
801056fd:	53                   	push   %ebx
801056fe:	e8 cd cb ff ff       	call   801022d0 <namecmp>
80105703:	83 c4 10             	add    $0x10,%esp
80105706:	85 c0                	test   %eax,%eax
80105708:	0f 84 ea 00 00 00    	je     801057f8 <sys_unlink+0x168>
  if ((ip = dirlookup(dp, name, &off)) == 0)
8010570e:	83 ec 04             	sub    $0x4,%esp
80105711:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80105714:	50                   	push   %eax
80105715:	53                   	push   %ebx
80105716:	56                   	push   %esi
80105717:	e8 d4 cb ff ff       	call   801022f0 <dirlookup>
8010571c:	83 c4 10             	add    $0x10,%esp
8010571f:	89 c3                	mov    %eax,%ebx
80105721:	85 c0                	test   %eax,%eax
80105723:	0f 84 cf 00 00 00    	je     801057f8 <sys_unlink+0x168>
  ilock(ip);
80105729:	83 ec 0c             	sub    $0xc,%esp
8010572c:	50                   	push   %eax
8010572d:	e8 6e c6 ff ff       	call   80101da0 <ilock>
  if (ip->nlink < 1)
80105732:	83 c4 10             	add    $0x10,%esp
80105735:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
8010573a:	0f 8e 23 01 00 00    	jle    80105863 <sys_unlink+0x1d3>
  if (ip->type == T_DIR && !isdirempty(ip))
80105740:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105745:	8d 7d d8             	lea    -0x28(%ebp),%edi
80105748:	74 66                	je     801057b0 <sys_unlink+0x120>
  memset(&de, 0, sizeof(de));
8010574a:	83 ec 04             	sub    $0x4,%esp
8010574d:	6a 10                	push   $0x10
8010574f:	6a 00                	push   $0x0
80105751:	57                   	push   %edi
80105752:	e8 c9 f5 ff ff       	call   80104d20 <memset>
  if (writei(dp, (char *)&de, off, sizeof(de)) != sizeof(de))
80105757:	6a 10                	push   $0x10
80105759:	ff 75 c4             	pushl  -0x3c(%ebp)
8010575c:	57                   	push   %edi
8010575d:	56                   	push   %esi
8010575e:	e8 3d ca ff ff       	call   801021a0 <writei>
80105763:	83 c4 20             	add    $0x20,%esp
80105766:	83 f8 10             	cmp    $0x10,%eax
80105769:	0f 85 e7 00 00 00    	jne    80105856 <sys_unlink+0x1c6>
  if (ip->type == T_DIR)
8010576f:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105774:	0f 84 96 00 00 00    	je     80105810 <sys_unlink+0x180>
  iunlockput(dp);
8010577a:	83 ec 0c             	sub    $0xc,%esp
8010577d:	56                   	push   %esi
8010577e:	e8 bd c8 ff ff       	call   80102040 <iunlockput>
  ip->nlink--;
80105783:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80105788:	89 1c 24             	mov    %ebx,(%esp)
8010578b:	e8 50 c5 ff ff       	call   80101ce0 <iupdate>
  iunlockput(ip);
80105790:	89 1c 24             	mov    %ebx,(%esp)
80105793:	e8 a8 c8 ff ff       	call   80102040 <iunlockput>
  end_op();
80105798:	e8 43 dc ff ff       	call   801033e0 <end_op>
  return 0;
8010579d:	83 c4 10             	add    $0x10,%esp
801057a0:	31 c0                	xor    %eax,%eax
}
801057a2:	8d 65 f4             	lea    -0xc(%ebp),%esp
801057a5:	5b                   	pop    %ebx
801057a6:	5e                   	pop    %esi
801057a7:	5f                   	pop    %edi
801057a8:	5d                   	pop    %ebp
801057a9:	c3                   	ret    
801057aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for (off = 2 * sizeof(de); off < dp->size; off += sizeof(de))
801057b0:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
801057b4:	76 94                	jbe    8010574a <sys_unlink+0xba>
801057b6:	ba 20 00 00 00       	mov    $0x20,%edx
801057bb:	eb 0b                	jmp    801057c8 <sys_unlink+0x138>
801057bd:	8d 76 00             	lea    0x0(%esi),%esi
801057c0:	83 c2 10             	add    $0x10,%edx
801057c3:	39 53 58             	cmp    %edx,0x58(%ebx)
801057c6:	76 82                	jbe    8010574a <sys_unlink+0xba>
    if (readi(dp, (char *)&de, off, sizeof(de)) != sizeof(de))
801057c8:	6a 10                	push   $0x10
801057ca:	52                   	push   %edx
801057cb:	57                   	push   %edi
801057cc:	53                   	push   %ebx
801057cd:	89 55 b4             	mov    %edx,-0x4c(%ebp)
801057d0:	e8 cb c8 ff ff       	call   801020a0 <readi>
801057d5:	83 c4 10             	add    $0x10,%esp
801057d8:	8b 55 b4             	mov    -0x4c(%ebp),%edx
801057db:	83 f8 10             	cmp    $0x10,%eax
801057de:	75 69                	jne    80105849 <sys_unlink+0x1b9>
    if (de.inum != 0)
801057e0:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
801057e5:	74 d9                	je     801057c0 <sys_unlink+0x130>
    iunlockput(ip);
801057e7:	83 ec 0c             	sub    $0xc,%esp
801057ea:	53                   	push   %ebx
801057eb:	e8 50 c8 ff ff       	call   80102040 <iunlockput>
    goto bad;
801057f0:	83 c4 10             	add    $0x10,%esp
801057f3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801057f7:	90                   	nop
  iunlockput(dp);
801057f8:	83 ec 0c             	sub    $0xc,%esp
801057fb:	56                   	push   %esi
801057fc:	e8 3f c8 ff ff       	call   80102040 <iunlockput>
  end_op();
80105801:	e8 da db ff ff       	call   801033e0 <end_op>
  return -1;
80105806:	83 c4 10             	add    $0x10,%esp
80105809:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010580e:	eb 92                	jmp    801057a2 <sys_unlink+0x112>
    iupdate(dp);
80105810:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink--;
80105813:	66 83 6e 56 01       	subw   $0x1,0x56(%esi)
    iupdate(dp);
80105818:	56                   	push   %esi
80105819:	e8 c2 c4 ff ff       	call   80101ce0 <iupdate>
8010581e:	83 c4 10             	add    $0x10,%esp
80105821:	e9 54 ff ff ff       	jmp    8010577a <sys_unlink+0xea>
80105826:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010582d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80105830:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105835:	e9 68 ff ff ff       	jmp    801057a2 <sys_unlink+0x112>
    end_op();
8010583a:	e8 a1 db ff ff       	call   801033e0 <end_op>
    return -1;
8010583f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105844:	e9 59 ff ff ff       	jmp    801057a2 <sys_unlink+0x112>
      panic("isdirempty: readi");
80105849:	83 ec 0c             	sub    $0xc,%esp
8010584c:	68 04 80 10 80       	push   $0x80108004
80105851:	e8 5a ab ff ff       	call   801003b0 <panic>
    panic("unlink: writei");
80105856:	83 ec 0c             	sub    $0xc,%esp
80105859:	68 16 80 10 80       	push   $0x80108016
8010585e:	e8 4d ab ff ff       	call   801003b0 <panic>
    panic("unlink: nlink < 1");
80105863:	83 ec 0c             	sub    $0xc,%esp
80105866:	68 f2 7f 10 80       	push   $0x80107ff2
8010586b:	e8 40 ab ff ff       	call   801003b0 <panic>

80105870 <sys_copy_file>:

// copy src to dest
// return 0 on success and -1 on error
int sys_copy_file(void)
{
80105870:	f3 0f 1e fb          	endbr32 
80105874:	55                   	push   %ebp
80105875:	89 e5                	mov    %esp,%ebp
80105877:	83 ec 20             	sub    $0x20,%esp
  char *src, *dest;
  if (argstr(0, &src) < 0)
8010587a:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010587d:	50                   	push   %eax
8010587e:	6a 00                	push   $0x0
80105880:	e8 2b f8 ff ff       	call   801050b0 <argstr>
80105885:	83 c4 10             	add    $0x10,%esp
80105888:	85 c0                	test   %eax,%eax
8010588a:	78 1c                	js     801058a8 <sys_copy_file+0x38>
    return -1;
  if (argstr(1, &dest) < 0)
8010588c:	83 ec 08             	sub    $0x8,%esp
8010588f:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105892:	50                   	push   %eax
80105893:	6a 01                	push   $0x1
80105895:	e8 16 f8 ff ff       	call   801050b0 <argstr>
8010589a:	83 c4 10             	add    $0x10,%esp
    return -1;
  return 0;
}
8010589d:	c9                   	leave  
  if (argstr(1, &dest) < 0)
8010589e:	c1 f8 1f             	sar    $0x1f,%eax
}
801058a1:	c3                   	ret    
801058a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801058a8:	c9                   	leave  
    return -1;
801058a9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801058ae:	c3                   	ret    
801058af:	90                   	nop

801058b0 <sys_open>:

int sys_open(void)
{
801058b0:	f3 0f 1e fb          	endbr32 
801058b4:	55                   	push   %ebp
801058b5:	89 e5                	mov    %esp,%ebp
801058b7:	57                   	push   %edi
801058b8:	56                   	push   %esi
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if (argstr(0, &path) < 0 || argint(1, &omode) < 0)
801058b9:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
801058bc:	53                   	push   %ebx
801058bd:	83 ec 24             	sub    $0x24,%esp
  if (argstr(0, &path) < 0 || argint(1, &omode) < 0)
801058c0:	50                   	push   %eax
801058c1:	6a 00                	push   $0x0
801058c3:	e8 e8 f7 ff ff       	call   801050b0 <argstr>
801058c8:	83 c4 10             	add    $0x10,%esp
801058cb:	85 c0                	test   %eax,%eax
801058cd:	0f 88 8a 00 00 00    	js     8010595d <sys_open+0xad>
801058d3:	83 ec 08             	sub    $0x8,%esp
801058d6:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801058d9:	50                   	push   %eax
801058da:	6a 01                	push   $0x1
801058dc:	e8 1f f7 ff ff       	call   80105000 <argint>
801058e1:	83 c4 10             	add    $0x10,%esp
801058e4:	85 c0                	test   %eax,%eax
801058e6:	78 75                	js     8010595d <sys_open+0xad>
    return -1;

  begin_op();
801058e8:	e8 83 da ff ff       	call   80103370 <begin_op>

  if (omode & O_CREATE)
801058ed:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
801058f1:	75 75                	jne    80105968 <sys_open+0xb8>
      return -1;
    }
  }
  else
  {
    if ((ip = namei(path)) == 0)
801058f3:	83 ec 0c             	sub    $0xc,%esp
801058f6:	ff 75 e0             	pushl  -0x20(%ebp)
801058f9:	e8 72 cd ff ff       	call   80102670 <namei>
801058fe:	83 c4 10             	add    $0x10,%esp
80105901:	89 c6                	mov    %eax,%esi
80105903:	85 c0                	test   %eax,%eax
80105905:	74 7e                	je     80105985 <sys_open+0xd5>
    {
      end_op();
      return -1;
    }
    ilock(ip);
80105907:	83 ec 0c             	sub    $0xc,%esp
8010590a:	50                   	push   %eax
8010590b:	e8 90 c4 ff ff       	call   80101da0 <ilock>
    if (ip->type == T_DIR && omode != O_RDONLY)
80105910:	83 c4 10             	add    $0x10,%esp
80105913:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80105918:	0f 84 c2 00 00 00    	je     801059e0 <sys_open+0x130>
      end_op();
      return -1;
    }
  }

  if ((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0)
8010591e:	e8 1d bb ff ff       	call   80101440 <filealloc>
80105923:	89 c7                	mov    %eax,%edi
80105925:	85 c0                	test   %eax,%eax
80105927:	74 23                	je     8010594c <sys_open+0x9c>
  struct proc *curproc = myproc();
80105929:	e8 72 e6 ff ff       	call   80103fa0 <myproc>
  for (fd = 0; fd < NOFILE; fd++)
8010592e:	31 db                	xor    %ebx,%ebx
    if (curproc->ofile[fd] == 0)
80105930:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105934:	85 d2                	test   %edx,%edx
80105936:	74 60                	je     80105998 <sys_open+0xe8>
  for (fd = 0; fd < NOFILE; fd++)
80105938:	83 c3 01             	add    $0x1,%ebx
8010593b:	83 fb 10             	cmp    $0x10,%ebx
8010593e:	75 f0                	jne    80105930 <sys_open+0x80>
  {
    if (f)
      fileclose(f);
80105940:	83 ec 0c             	sub    $0xc,%esp
80105943:	57                   	push   %edi
80105944:	e8 b7 bb ff ff       	call   80101500 <fileclose>
80105949:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
8010594c:	83 ec 0c             	sub    $0xc,%esp
8010594f:	56                   	push   %esi
80105950:	e8 eb c6 ff ff       	call   80102040 <iunlockput>
    end_op();
80105955:	e8 86 da ff ff       	call   801033e0 <end_op>
    return -1;
8010595a:	83 c4 10             	add    $0x10,%esp
8010595d:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105962:	eb 6d                	jmp    801059d1 <sys_open+0x121>
80105964:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ip = create(path, T_FILE, 0, 0);
80105968:	83 ec 0c             	sub    $0xc,%esp
8010596b:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010596e:	31 c9                	xor    %ecx,%ecx
80105970:	ba 02 00 00 00       	mov    $0x2,%edx
80105975:	6a 00                	push   $0x0
80105977:	e8 e4 f7 ff ff       	call   80105160 <create>
    if (ip == 0)
8010597c:	83 c4 10             	add    $0x10,%esp
    ip = create(path, T_FILE, 0, 0);
8010597f:	89 c6                	mov    %eax,%esi
    if (ip == 0)
80105981:	85 c0                	test   %eax,%eax
80105983:	75 99                	jne    8010591e <sys_open+0x6e>
      end_op();
80105985:	e8 56 da ff ff       	call   801033e0 <end_op>
      return -1;
8010598a:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
8010598f:	eb 40                	jmp    801059d1 <sys_open+0x121>
80105991:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  }
  iunlock(ip);
80105998:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
8010599b:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
  iunlock(ip);
8010599f:	56                   	push   %esi
801059a0:	e8 db c4 ff ff       	call   80101e80 <iunlock>
  end_op();
801059a5:	e8 36 da ff ff       	call   801033e0 <end_op>

  f->type = FD_INODE;
801059aa:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
801059b0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801059b3:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
801059b6:	89 77 10             	mov    %esi,0x10(%edi)
  f->readable = !(omode & O_WRONLY);
801059b9:	89 d0                	mov    %edx,%eax
  f->off = 0;
801059bb:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
801059c2:	f7 d0                	not    %eax
801059c4:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801059c7:	83 e2 03             	and    $0x3,%edx
  f->readable = !(omode & O_WRONLY);
801059ca:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801059cd:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
}
801059d1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801059d4:	89 d8                	mov    %ebx,%eax
801059d6:	5b                   	pop    %ebx
801059d7:	5e                   	pop    %esi
801059d8:	5f                   	pop    %edi
801059d9:	5d                   	pop    %ebp
801059da:	c3                   	ret    
801059db:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801059df:	90                   	nop
    if (ip->type == T_DIR && omode != O_RDONLY)
801059e0:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801059e3:	85 c9                	test   %ecx,%ecx
801059e5:	0f 84 33 ff ff ff    	je     8010591e <sys_open+0x6e>
801059eb:	e9 5c ff ff ff       	jmp    8010594c <sys_open+0x9c>

801059f0 <sys_mkdir>:

int sys_mkdir(void)
{
801059f0:	f3 0f 1e fb          	endbr32 
801059f4:	55                   	push   %ebp
801059f5:	89 e5                	mov    %esp,%ebp
801059f7:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
801059fa:	e8 71 d9 ff ff       	call   80103370 <begin_op>
  if (argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0)
801059ff:	83 ec 08             	sub    $0x8,%esp
80105a02:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105a05:	50                   	push   %eax
80105a06:	6a 00                	push   $0x0
80105a08:	e8 a3 f6 ff ff       	call   801050b0 <argstr>
80105a0d:	83 c4 10             	add    $0x10,%esp
80105a10:	85 c0                	test   %eax,%eax
80105a12:	78 34                	js     80105a48 <sys_mkdir+0x58>
80105a14:	83 ec 0c             	sub    $0xc,%esp
80105a17:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105a1a:	31 c9                	xor    %ecx,%ecx
80105a1c:	ba 01 00 00 00       	mov    $0x1,%edx
80105a21:	6a 00                	push   $0x0
80105a23:	e8 38 f7 ff ff       	call   80105160 <create>
80105a28:	83 c4 10             	add    $0x10,%esp
80105a2b:	85 c0                	test   %eax,%eax
80105a2d:	74 19                	je     80105a48 <sys_mkdir+0x58>
  {
    end_op();
    return -1;
  }
  iunlockput(ip);
80105a2f:	83 ec 0c             	sub    $0xc,%esp
80105a32:	50                   	push   %eax
80105a33:	e8 08 c6 ff ff       	call   80102040 <iunlockput>
  end_op();
80105a38:	e8 a3 d9 ff ff       	call   801033e0 <end_op>
  return 0;
80105a3d:	83 c4 10             	add    $0x10,%esp
80105a40:	31 c0                	xor    %eax,%eax
}
80105a42:	c9                   	leave  
80105a43:	c3                   	ret    
80105a44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    end_op();
80105a48:	e8 93 d9 ff ff       	call   801033e0 <end_op>
    return -1;
80105a4d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105a52:	c9                   	leave  
80105a53:	c3                   	ret    
80105a54:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105a5b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105a5f:	90                   	nop

80105a60 <sys_mknod>:

int sys_mknod(void)
{
80105a60:	f3 0f 1e fb          	endbr32 
80105a64:	55                   	push   %ebp
80105a65:	89 e5                	mov    %esp,%ebp
80105a67:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80105a6a:	e8 01 d9 ff ff       	call   80103370 <begin_op>
  if ((argstr(0, &path)) < 0 ||
80105a6f:	83 ec 08             	sub    $0x8,%esp
80105a72:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105a75:	50                   	push   %eax
80105a76:	6a 00                	push   $0x0
80105a78:	e8 33 f6 ff ff       	call   801050b0 <argstr>
80105a7d:	83 c4 10             	add    $0x10,%esp
80105a80:	85 c0                	test   %eax,%eax
80105a82:	78 64                	js     80105ae8 <sys_mknod+0x88>
      argint(1, &major) < 0 ||
80105a84:	83 ec 08             	sub    $0x8,%esp
80105a87:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105a8a:	50                   	push   %eax
80105a8b:	6a 01                	push   $0x1
80105a8d:	e8 6e f5 ff ff       	call   80105000 <argint>
  if ((argstr(0, &path)) < 0 ||
80105a92:	83 c4 10             	add    $0x10,%esp
80105a95:	85 c0                	test   %eax,%eax
80105a97:	78 4f                	js     80105ae8 <sys_mknod+0x88>
      argint(2, &minor) < 0 ||
80105a99:	83 ec 08             	sub    $0x8,%esp
80105a9c:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105a9f:	50                   	push   %eax
80105aa0:	6a 02                	push   $0x2
80105aa2:	e8 59 f5 ff ff       	call   80105000 <argint>
      argint(1, &major) < 0 ||
80105aa7:	83 c4 10             	add    $0x10,%esp
80105aaa:	85 c0                	test   %eax,%eax
80105aac:	78 3a                	js     80105ae8 <sys_mknod+0x88>
      (ip = create(path, T_DEV, major, minor)) == 0)
80105aae:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
80105ab2:	83 ec 0c             	sub    $0xc,%esp
80105ab5:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
80105ab9:	ba 03 00 00 00       	mov    $0x3,%edx
80105abe:	50                   	push   %eax
80105abf:	8b 45 ec             	mov    -0x14(%ebp),%eax
80105ac2:	e8 99 f6 ff ff       	call   80105160 <create>
      argint(2, &minor) < 0 ||
80105ac7:	83 c4 10             	add    $0x10,%esp
80105aca:	85 c0                	test   %eax,%eax
80105acc:	74 1a                	je     80105ae8 <sys_mknod+0x88>
  {
    end_op();
    return -1;
  }
  iunlockput(ip);
80105ace:	83 ec 0c             	sub    $0xc,%esp
80105ad1:	50                   	push   %eax
80105ad2:	e8 69 c5 ff ff       	call   80102040 <iunlockput>
  end_op();
80105ad7:	e8 04 d9 ff ff       	call   801033e0 <end_op>
  return 0;
80105adc:	83 c4 10             	add    $0x10,%esp
80105adf:	31 c0                	xor    %eax,%eax
}
80105ae1:	c9                   	leave  
80105ae2:	c3                   	ret    
80105ae3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105ae7:	90                   	nop
    end_op();
80105ae8:	e8 f3 d8 ff ff       	call   801033e0 <end_op>
    return -1;
80105aed:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105af2:	c9                   	leave  
80105af3:	c3                   	ret    
80105af4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105afb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105aff:	90                   	nop

80105b00 <sys_chdir>:

int sys_chdir(void)
{
80105b00:	f3 0f 1e fb          	endbr32 
80105b04:	55                   	push   %ebp
80105b05:	89 e5                	mov    %esp,%ebp
80105b07:	56                   	push   %esi
80105b08:	53                   	push   %ebx
80105b09:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
80105b0c:	e8 8f e4 ff ff       	call   80103fa0 <myproc>
80105b11:	89 c6                	mov    %eax,%esi

  begin_op();
80105b13:	e8 58 d8 ff ff       	call   80103370 <begin_op>
  if (argstr(0, &path) < 0 || (ip = namei(path)) == 0)
80105b18:	83 ec 08             	sub    $0x8,%esp
80105b1b:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105b1e:	50                   	push   %eax
80105b1f:	6a 00                	push   $0x0
80105b21:	e8 8a f5 ff ff       	call   801050b0 <argstr>
80105b26:	83 c4 10             	add    $0x10,%esp
80105b29:	85 c0                	test   %eax,%eax
80105b2b:	78 73                	js     80105ba0 <sys_chdir+0xa0>
80105b2d:	83 ec 0c             	sub    $0xc,%esp
80105b30:	ff 75 f4             	pushl  -0xc(%ebp)
80105b33:	e8 38 cb ff ff       	call   80102670 <namei>
80105b38:	83 c4 10             	add    $0x10,%esp
80105b3b:	89 c3                	mov    %eax,%ebx
80105b3d:	85 c0                	test   %eax,%eax
80105b3f:	74 5f                	je     80105ba0 <sys_chdir+0xa0>
  {
    end_op();
    return -1;
  }
  ilock(ip);
80105b41:	83 ec 0c             	sub    $0xc,%esp
80105b44:	50                   	push   %eax
80105b45:	e8 56 c2 ff ff       	call   80101da0 <ilock>
  if (ip->type != T_DIR)
80105b4a:	83 c4 10             	add    $0x10,%esp
80105b4d:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105b52:	75 2c                	jne    80105b80 <sys_chdir+0x80>
  {
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105b54:	83 ec 0c             	sub    $0xc,%esp
80105b57:	53                   	push   %ebx
80105b58:	e8 23 c3 ff ff       	call   80101e80 <iunlock>
  iput(curproc->cwd);
80105b5d:	58                   	pop    %eax
80105b5e:	ff 76 68             	pushl  0x68(%esi)
80105b61:	e8 6a c3 ff ff       	call   80101ed0 <iput>
  end_op();
80105b66:	e8 75 d8 ff ff       	call   801033e0 <end_op>
  curproc->cwd = ip;
80105b6b:	89 5e 68             	mov    %ebx,0x68(%esi)
  return 0;
80105b6e:	83 c4 10             	add    $0x10,%esp
80105b71:	31 c0                	xor    %eax,%eax
}
80105b73:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105b76:	5b                   	pop    %ebx
80105b77:	5e                   	pop    %esi
80105b78:	5d                   	pop    %ebp
80105b79:	c3                   	ret    
80105b7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(ip);
80105b80:	83 ec 0c             	sub    $0xc,%esp
80105b83:	53                   	push   %ebx
80105b84:	e8 b7 c4 ff ff       	call   80102040 <iunlockput>
    end_op();
80105b89:	e8 52 d8 ff ff       	call   801033e0 <end_op>
    return -1;
80105b8e:	83 c4 10             	add    $0x10,%esp
80105b91:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105b96:	eb db                	jmp    80105b73 <sys_chdir+0x73>
80105b98:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105b9f:	90                   	nop
    end_op();
80105ba0:	e8 3b d8 ff ff       	call   801033e0 <end_op>
    return -1;
80105ba5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105baa:	eb c7                	jmp    80105b73 <sys_chdir+0x73>
80105bac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105bb0 <sys_exec>:

int sys_exec(void)
{
80105bb0:	f3 0f 1e fb          	endbr32 
80105bb4:	55                   	push   %ebp
80105bb5:	89 e5                	mov    %esp,%ebp
80105bb7:	57                   	push   %edi
80105bb8:	56                   	push   %esi
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if (argstr(0, &path) < 0 || argint(1, (int *)&uargv) < 0)
80105bb9:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
{
80105bbf:	53                   	push   %ebx
80105bc0:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  if (argstr(0, &path) < 0 || argint(1, (int *)&uargv) < 0)
80105bc6:	50                   	push   %eax
80105bc7:	6a 00                	push   $0x0
80105bc9:	e8 e2 f4 ff ff       	call   801050b0 <argstr>
80105bce:	83 c4 10             	add    $0x10,%esp
80105bd1:	85 c0                	test   %eax,%eax
80105bd3:	0f 88 8b 00 00 00    	js     80105c64 <sys_exec+0xb4>
80105bd9:	83 ec 08             	sub    $0x8,%esp
80105bdc:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
80105be2:	50                   	push   %eax
80105be3:	6a 01                	push   $0x1
80105be5:	e8 16 f4 ff ff       	call   80105000 <argint>
80105bea:	83 c4 10             	add    $0x10,%esp
80105bed:	85 c0                	test   %eax,%eax
80105bef:	78 73                	js     80105c64 <sys_exec+0xb4>
  {
    return -1;
  }
  memset(argv, 0, sizeof(argv));
80105bf1:	83 ec 04             	sub    $0x4,%esp
80105bf4:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
  for (i = 0;; i++)
80105bfa:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
80105bfc:	68 80 00 00 00       	push   $0x80
80105c01:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
80105c07:	6a 00                	push   $0x0
80105c09:	50                   	push   %eax
80105c0a:	e8 11 f1 ff ff       	call   80104d20 <memset>
80105c0f:	83 c4 10             	add    $0x10,%esp
80105c12:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  {
    if (i >= NELEM(argv))
      return -1;
    if (fetchint(uargv + 4 * i, (int *)&uarg) < 0)
80105c18:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
80105c1e:	8d 34 9d 00 00 00 00 	lea    0x0(,%ebx,4),%esi
80105c25:	83 ec 08             	sub    $0x8,%esp
80105c28:	57                   	push   %edi
80105c29:	01 f0                	add    %esi,%eax
80105c2b:	50                   	push   %eax
80105c2c:	e8 2f f3 ff ff       	call   80104f60 <fetchint>
80105c31:	83 c4 10             	add    $0x10,%esp
80105c34:	85 c0                	test   %eax,%eax
80105c36:	78 2c                	js     80105c64 <sys_exec+0xb4>
      return -1;
    if (uarg == 0)
80105c38:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80105c3e:	85 c0                	test   %eax,%eax
80105c40:	74 36                	je     80105c78 <sys_exec+0xc8>
    {
      argv[i] = 0;
      break;
    }
    if (fetchstr(uarg, &argv[i]) < 0)
80105c42:	8d 8d 68 ff ff ff    	lea    -0x98(%ebp),%ecx
80105c48:	83 ec 08             	sub    $0x8,%esp
80105c4b:	8d 14 31             	lea    (%ecx,%esi,1),%edx
80105c4e:	52                   	push   %edx
80105c4f:	50                   	push   %eax
80105c50:	e8 4b f3 ff ff       	call   80104fa0 <fetchstr>
80105c55:	83 c4 10             	add    $0x10,%esp
80105c58:	85 c0                	test   %eax,%eax
80105c5a:	78 08                	js     80105c64 <sys_exec+0xb4>
  for (i = 0;; i++)
80105c5c:	83 c3 01             	add    $0x1,%ebx
    if (i >= NELEM(argv))
80105c5f:	83 fb 20             	cmp    $0x20,%ebx
80105c62:	75 b4                	jne    80105c18 <sys_exec+0x68>
      return -1;
  }
  return exec(path, argv);
}
80105c64:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
80105c67:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105c6c:	5b                   	pop    %ebx
80105c6d:	5e                   	pop    %esi
80105c6e:	5f                   	pop    %edi
80105c6f:	5d                   	pop    %ebp
80105c70:	c3                   	ret    
80105c71:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return exec(path, argv);
80105c78:	83 ec 08             	sub    $0x8,%esp
80105c7b:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
      argv[i] = 0;
80105c81:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
80105c88:	00 00 00 00 
  return exec(path, argv);
80105c8c:	50                   	push   %eax
80105c8d:	ff b5 5c ff ff ff    	pushl  -0xa4(%ebp)
80105c93:	e8 28 b4 ff ff       	call   801010c0 <exec>
80105c98:	83 c4 10             	add    $0x10,%esp
}
80105c9b:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105c9e:	5b                   	pop    %ebx
80105c9f:	5e                   	pop    %esi
80105ca0:	5f                   	pop    %edi
80105ca1:	5d                   	pop    %ebp
80105ca2:	c3                   	ret    
80105ca3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105caa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105cb0 <sys_pipe>:

int sys_pipe(void)
{
80105cb0:	f3 0f 1e fb          	endbr32 
80105cb4:	55                   	push   %ebp
80105cb5:	89 e5                	mov    %esp,%ebp
80105cb7:	57                   	push   %edi
80105cb8:	56                   	push   %esi
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if (argptr(0, (void *)&fd, 2 * sizeof(fd[0])) < 0)
80105cb9:	8d 45 dc             	lea    -0x24(%ebp),%eax
{
80105cbc:	53                   	push   %ebx
80105cbd:	83 ec 20             	sub    $0x20,%esp
  if (argptr(0, (void *)&fd, 2 * sizeof(fd[0])) < 0)
80105cc0:	6a 08                	push   $0x8
80105cc2:	50                   	push   %eax
80105cc3:	6a 00                	push   $0x0
80105cc5:	e8 86 f3 ff ff       	call   80105050 <argptr>
80105cca:	83 c4 10             	add    $0x10,%esp
80105ccd:	85 c0                	test   %eax,%eax
80105ccf:	78 4e                	js     80105d1f <sys_pipe+0x6f>
    return -1;
  if (pipealloc(&rf, &wf) < 0)
80105cd1:	83 ec 08             	sub    $0x8,%esp
80105cd4:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105cd7:	50                   	push   %eax
80105cd8:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105cdb:	50                   	push   %eax
80105cdc:	e8 4f dd ff ff       	call   80103a30 <pipealloc>
80105ce1:	83 c4 10             	add    $0x10,%esp
80105ce4:	85 c0                	test   %eax,%eax
80105ce6:	78 37                	js     80105d1f <sys_pipe+0x6f>
    return -1;
  fd0 = -1;
  if ((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0)
80105ce8:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for (fd = 0; fd < NOFILE; fd++)
80105ceb:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
80105ced:	e8 ae e2 ff ff       	call   80103fa0 <myproc>
  for (fd = 0; fd < NOFILE; fd++)
80105cf2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if (curproc->ofile[fd] == 0)
80105cf8:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
80105cfc:	85 f6                	test   %esi,%esi
80105cfe:	74 30                	je     80105d30 <sys_pipe+0x80>
  for (fd = 0; fd < NOFILE; fd++)
80105d00:	83 c3 01             	add    $0x1,%ebx
80105d03:	83 fb 10             	cmp    $0x10,%ebx
80105d06:	75 f0                	jne    80105cf8 <sys_pipe+0x48>
  {
    if (fd0 >= 0)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
80105d08:	83 ec 0c             	sub    $0xc,%esp
80105d0b:	ff 75 e0             	pushl  -0x20(%ebp)
80105d0e:	e8 ed b7 ff ff       	call   80101500 <fileclose>
    fileclose(wf);
80105d13:	58                   	pop    %eax
80105d14:	ff 75 e4             	pushl  -0x1c(%ebp)
80105d17:	e8 e4 b7 ff ff       	call   80101500 <fileclose>
    return -1;
80105d1c:	83 c4 10             	add    $0x10,%esp
80105d1f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105d24:	eb 5b                	jmp    80105d81 <sys_pipe+0xd1>
80105d26:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105d2d:	8d 76 00             	lea    0x0(%esi),%esi
      curproc->ofile[fd] = f;
80105d30:	8d 73 08             	lea    0x8(%ebx),%esi
80105d33:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if ((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0)
80105d37:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  struct proc *curproc = myproc();
80105d3a:	e8 61 e2 ff ff       	call   80103fa0 <myproc>
  for (fd = 0; fd < NOFILE; fd++)
80105d3f:	31 d2                	xor    %edx,%edx
80105d41:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if (curproc->ofile[fd] == 0)
80105d48:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
80105d4c:	85 c9                	test   %ecx,%ecx
80105d4e:	74 20                	je     80105d70 <sys_pipe+0xc0>
  for (fd = 0; fd < NOFILE; fd++)
80105d50:	83 c2 01             	add    $0x1,%edx
80105d53:	83 fa 10             	cmp    $0x10,%edx
80105d56:	75 f0                	jne    80105d48 <sys_pipe+0x98>
      myproc()->ofile[fd0] = 0;
80105d58:	e8 43 e2 ff ff       	call   80103fa0 <myproc>
80105d5d:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
80105d64:	00 
80105d65:	eb a1                	jmp    80105d08 <sys_pipe+0x58>
80105d67:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105d6e:	66 90                	xchg   %ax,%ax
      curproc->ofile[fd] = f;
80105d70:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
  }
  fd[0] = fd0;
80105d74:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105d77:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
80105d79:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105d7c:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
80105d7f:	31 c0                	xor    %eax,%eax
}
80105d81:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105d84:	5b                   	pop    %ebx
80105d85:	5e                   	pop    %esi
80105d86:	5f                   	pop    %edi
80105d87:	5d                   	pop    %ebp
80105d88:	c3                   	ret    
80105d89:	66 90                	xchg   %ax,%ax
80105d8b:	66 90                	xchg   %ax,%ax
80105d8d:	66 90                	xchg   %ax,%ax
80105d8f:	90                   	nop

80105d90 <sys_fork>:
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"

int sys_fork(void)
{
80105d90:	f3 0f 1e fb          	endbr32 
	return fork();
80105d94:	e9 b7 e3 ff ff       	jmp    80104150 <fork>
80105d99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105da0 <sys_exit>:
}

int sys_exit(void)
{
80105da0:	f3 0f 1e fb          	endbr32 
80105da4:	55                   	push   %ebp
80105da5:	89 e5                	mov    %esp,%ebp
80105da7:	83 ec 08             	sub    $0x8,%esp
	exit();
80105daa:	e8 21 e6 ff ff       	call   801043d0 <exit>
	return 0; // not reached
}
80105daf:	31 c0                	xor    %eax,%eax
80105db1:	c9                   	leave  
80105db2:	c3                   	ret    
80105db3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105dba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105dc0 <sys_wait>:

int sys_wait(void)
{
80105dc0:	f3 0f 1e fb          	endbr32 
	return wait();
80105dc4:	e9 57 e8 ff ff       	jmp    80104620 <wait>
80105dc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105dd0 <sys_kill>:
}

int sys_kill(void)
{
80105dd0:	f3 0f 1e fb          	endbr32 
80105dd4:	55                   	push   %ebp
80105dd5:	89 e5                	mov    %esp,%ebp
80105dd7:	83 ec 20             	sub    $0x20,%esp
	int pid;

	if (argint(0, &pid) < 0)
80105dda:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105ddd:	50                   	push   %eax
80105dde:	6a 00                	push   $0x0
80105de0:	e8 1b f2 ff ff       	call   80105000 <argint>
80105de5:	83 c4 10             	add    $0x10,%esp
80105de8:	85 c0                	test   %eax,%eax
80105dea:	78 14                	js     80105e00 <sys_kill+0x30>
		return -1;
	return kill(pid);
80105dec:	83 ec 0c             	sub    $0xc,%esp
80105def:	ff 75 f4             	pushl  -0xc(%ebp)
80105df2:	e8 89 e9 ff ff       	call   80104780 <kill>
80105df7:	83 c4 10             	add    $0x10,%esp
}
80105dfa:	c9                   	leave  
80105dfb:	c3                   	ret    
80105dfc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105e00:	c9                   	leave  
		return -1;
80105e01:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105e06:	c3                   	ret    
80105e07:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105e0e:	66 90                	xchg   %ax,%ax

80105e10 <sys_getpid>:

int sys_getpid(void)
{
80105e10:	f3 0f 1e fb          	endbr32 
80105e14:	55                   	push   %ebp
80105e15:	89 e5                	mov    %esp,%ebp
80105e17:	83 ec 08             	sub    $0x8,%esp
	return myproc()->pid;
80105e1a:	e8 81 e1 ff ff       	call   80103fa0 <myproc>
80105e1f:	8b 40 10             	mov    0x10(%eax),%eax
}
80105e22:	c9                   	leave  
80105e23:	c3                   	ret    
80105e24:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105e2b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105e2f:	90                   	nop

80105e30 <sys_sbrk>:

int sys_sbrk(void)
{
80105e30:	f3 0f 1e fb          	endbr32 
80105e34:	55                   	push   %ebp
80105e35:	89 e5                	mov    %esp,%ebp
80105e37:	53                   	push   %ebx
	int addr;
	int n;

	if (argint(0, &n) < 0)
80105e38:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105e3b:	83 ec 1c             	sub    $0x1c,%esp
	if (argint(0, &n) < 0)
80105e3e:	50                   	push   %eax
80105e3f:	6a 00                	push   $0x0
80105e41:	e8 ba f1 ff ff       	call   80105000 <argint>
80105e46:	83 c4 10             	add    $0x10,%esp
80105e49:	85 c0                	test   %eax,%eax
80105e4b:	78 23                	js     80105e70 <sys_sbrk+0x40>
		return -1;
	addr = myproc()->sz;
80105e4d:	e8 4e e1 ff ff       	call   80103fa0 <myproc>
	if (growproc(n) < 0)
80105e52:	83 ec 0c             	sub    $0xc,%esp
	addr = myproc()->sz;
80105e55:	8b 18                	mov    (%eax),%ebx
	if (growproc(n) < 0)
80105e57:	ff 75 f4             	pushl  -0xc(%ebp)
80105e5a:	e8 71 e2 ff ff       	call   801040d0 <growproc>
80105e5f:	83 c4 10             	add    $0x10,%esp
80105e62:	85 c0                	test   %eax,%eax
80105e64:	78 0a                	js     80105e70 <sys_sbrk+0x40>
		return -1;
	return addr;
}
80105e66:	89 d8                	mov    %ebx,%eax
80105e68:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105e6b:	c9                   	leave  
80105e6c:	c3                   	ret    
80105e6d:	8d 76 00             	lea    0x0(%esi),%esi
		return -1;
80105e70:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105e75:	eb ef                	jmp    80105e66 <sys_sbrk+0x36>
80105e77:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105e7e:	66 90                	xchg   %ax,%ax

80105e80 <sys_sleep>:

int sys_sleep(void)
{
80105e80:	f3 0f 1e fb          	endbr32 
80105e84:	55                   	push   %ebp
80105e85:	89 e5                	mov    %esp,%ebp
80105e87:	53                   	push   %ebx
	int n;
	uint ticks0;

	if (argint(0, &n) < 0)
80105e88:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105e8b:	83 ec 1c             	sub    $0x1c,%esp
	if (argint(0, &n) < 0)
80105e8e:	50                   	push   %eax
80105e8f:	6a 00                	push   $0x0
80105e91:	e8 6a f1 ff ff       	call   80105000 <argint>
80105e96:	83 c4 10             	add    $0x10,%esp
80105e99:	85 c0                	test   %eax,%eax
80105e9b:	0f 88 86 00 00 00    	js     80105f27 <sys_sleep+0xa7>
		return -1;
	acquire(&tickslock);
80105ea1:	83 ec 0c             	sub    $0xc,%esp
80105ea4:	68 a0 68 11 80       	push   $0x801168a0
80105ea9:	e8 62 ed ff ff       	call   80104c10 <acquire>
	ticks0 = ticks;
	while (ticks - ticks0 < n)
80105eae:	8b 55 f4             	mov    -0xc(%ebp),%edx
	ticks0 = ticks;
80105eb1:	8b 1d e0 70 11 80    	mov    0x801170e0,%ebx
	while (ticks - ticks0 < n)
80105eb7:	83 c4 10             	add    $0x10,%esp
80105eba:	85 d2                	test   %edx,%edx
80105ebc:	75 23                	jne    80105ee1 <sys_sleep+0x61>
80105ebe:	eb 50                	jmp    80105f10 <sys_sleep+0x90>
		if (myproc()->killed)
		{
			release(&tickslock);
			return -1;
		}
		sleep(&ticks, &tickslock);
80105ec0:	83 ec 08             	sub    $0x8,%esp
80105ec3:	68 a0 68 11 80       	push   $0x801168a0
80105ec8:	68 e0 70 11 80       	push   $0x801170e0
80105ecd:	e8 8e e6 ff ff       	call   80104560 <sleep>
	while (ticks - ticks0 < n)
80105ed2:	a1 e0 70 11 80       	mov    0x801170e0,%eax
80105ed7:	83 c4 10             	add    $0x10,%esp
80105eda:	29 d8                	sub    %ebx,%eax
80105edc:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80105edf:	73 2f                	jae    80105f10 <sys_sleep+0x90>
		if (myproc()->killed)
80105ee1:	e8 ba e0 ff ff       	call   80103fa0 <myproc>
80105ee6:	8b 40 24             	mov    0x24(%eax),%eax
80105ee9:	85 c0                	test   %eax,%eax
80105eeb:	74 d3                	je     80105ec0 <sys_sleep+0x40>
			release(&tickslock);
80105eed:	83 ec 0c             	sub    $0xc,%esp
80105ef0:	68 a0 68 11 80       	push   $0x801168a0
80105ef5:	e8 d6 ed ff ff       	call   80104cd0 <release>
	}
	release(&tickslock);
	return 0;
}
80105efa:	8b 5d fc             	mov    -0x4(%ebp),%ebx
			return -1;
80105efd:	83 c4 10             	add    $0x10,%esp
80105f00:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105f05:	c9                   	leave  
80105f06:	c3                   	ret    
80105f07:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105f0e:	66 90                	xchg   %ax,%ax
	release(&tickslock);
80105f10:	83 ec 0c             	sub    $0xc,%esp
80105f13:	68 a0 68 11 80       	push   $0x801168a0
80105f18:	e8 b3 ed ff ff       	call   80104cd0 <release>
	return 0;
80105f1d:	83 c4 10             	add    $0x10,%esp
80105f20:	31 c0                	xor    %eax,%eax
}
80105f22:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105f25:	c9                   	leave  
80105f26:	c3                   	ret    
		return -1;
80105f27:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105f2c:	eb f4                	jmp    80105f22 <sys_sleep+0xa2>
80105f2e:	66 90                	xchg   %ax,%ax

80105f30 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int sys_uptime(void)
{
80105f30:	f3 0f 1e fb          	endbr32 
80105f34:	55                   	push   %ebp
80105f35:	89 e5                	mov    %esp,%ebp
80105f37:	53                   	push   %ebx
80105f38:	83 ec 10             	sub    $0x10,%esp
	uint xticks;

	acquire(&tickslock);
80105f3b:	68 a0 68 11 80       	push   $0x801168a0
80105f40:	e8 cb ec ff ff       	call   80104c10 <acquire>
	xticks = ticks;
80105f45:	8b 1d e0 70 11 80    	mov    0x801170e0,%ebx
	release(&tickslock);
80105f4b:	c7 04 24 a0 68 11 80 	movl   $0x801168a0,(%esp)
80105f52:	e8 79 ed ff ff       	call   80104cd0 <release>
	return xticks;
}
80105f57:	89 d8                	mov    %ebx,%eax
80105f59:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105f5c:	c9                   	leave  
80105f5d:	c3                   	ret    
80105f5e:	66 90                	xchg   %ax,%ax

80105f60 <sys_find_digital_root>:
#include "mmu.h"
#include "proc.h"

// return digital root of number given
int sys_find_digital_root(void)
{
80105f60:	f3 0f 1e fb          	endbr32 
80105f64:	55                   	push   %ebp
80105f65:	89 e5                	mov    %esp,%ebp
80105f67:	56                   	push   %esi
80105f68:	53                   	push   %ebx
    int n = myproc()->tf->ebx;
80105f69:	e8 32 e0 ff ff       	call   80103fa0 <myproc>
    int res = 0;
80105f6e:	31 c9                	xor    %ecx,%ecx
    int n = myproc()->tf->ebx;
80105f70:	8b 40 18             	mov    0x18(%eax),%eax
80105f73:	8b 70 10             	mov    0x10(%eax),%esi
    while (n > 0)
80105f76:	85 f6                	test   %esi,%esi
80105f78:	7e 4d                	jle    80105fc7 <sys_find_digital_root+0x67>
    {
        res += n % 10;
80105f7a:	89 f0                	mov    %esi,%eax
80105f7c:	ba 67 66 66 66       	mov    $0x66666667,%edx
80105f81:	f7 ea                	imul   %edx
80105f83:	89 f0                	mov    %esi,%eax
80105f85:	c1 f8 1f             	sar    $0x1f,%eax
80105f88:	c1 fa 02             	sar    $0x2,%edx
80105f8b:	89 d1                	mov    %edx,%ecx
80105f8d:	29 c1                	sub    %eax,%ecx
80105f8f:	8d 04 89             	lea    (%ecx,%ecx,4),%eax
80105f92:	89 cb                	mov    %ecx,%ebx
80105f94:	01 c0                	add    %eax,%eax
80105f96:	29 c6                	sub    %eax,%esi
80105f98:	89 f1                	mov    %esi,%ecx
80105f9a:	be cd cc cc cc       	mov    $0xcccccccd,%esi
80105f9f:	eb 22                	jmp    80105fc3 <sys_find_digital_root+0x63>
80105fa1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105fa8:	89 d8                	mov    %ebx,%eax
80105faa:	f7 e6                	mul    %esi
80105fac:	c1 ea 03             	shr    $0x3,%edx
80105faf:	8d 04 92             	lea    (%edx,%edx,4),%eax
80105fb2:	01 c0                	add    %eax,%eax
80105fb4:	29 c3                	sub    %eax,%ebx
80105fb6:	01 d9                	add    %ebx,%ecx
        n /= 10;
80105fb8:	89 d3                	mov    %edx,%ebx
        if (res > 9)
            res -= 9;
80105fba:	8d 41 f7             	lea    -0x9(%ecx),%eax
80105fbd:	83 f9 09             	cmp    $0x9,%ecx
80105fc0:	0f 4f c8             	cmovg  %eax,%ecx
    while (n > 0)
80105fc3:	85 db                	test   %ebx,%ebx
80105fc5:	75 e1                	jne    80105fa8 <sys_find_digital_root+0x48>
    }
    return res;
80105fc7:	5b                   	pop    %ebx
80105fc8:	89 c8                	mov    %ecx,%eax
80105fca:	5e                   	pop    %esi
80105fcb:	5d                   	pop    %ebp
80105fcc:	c3                   	ret    

80105fcd <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
80105fcd:	1e                   	push   %ds
  pushl %es
80105fce:	06                   	push   %es
  pushl %fs
80105fcf:	0f a0                	push   %fs
  pushl %gs
80105fd1:	0f a8                	push   %gs
  pushal
80105fd3:	60                   	pusha  
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
80105fd4:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
80105fd8:	8e d8                	mov    %eax,%ds
  movw %ax, %es
80105fda:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
80105fdc:	54                   	push   %esp
  call trap
80105fdd:	e8 be 00 00 00       	call   801060a0 <trap>
  addl $4, %esp
80105fe2:	83 c4 04             	add    $0x4,%esp

80105fe5 <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
80105fe5:	61                   	popa   
  popl %gs
80105fe6:	0f a9                	pop    %gs
  popl %fs
80105fe8:	0f a1                	pop    %fs
  popl %es
80105fea:	07                   	pop    %es
  popl %ds
80105feb:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
80105fec:	83 c4 08             	add    $0x8,%esp
  iret
80105fef:	cf                   	iret   

80105ff0 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80105ff0:	f3 0f 1e fb          	endbr32 
80105ff4:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
80105ff5:	31 c0                	xor    %eax,%eax
{
80105ff7:	89 e5                	mov    %esp,%ebp
80105ff9:	83 ec 08             	sub    $0x8,%esp
80105ffc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80106000:	8b 14 85 08 b0 10 80 	mov    -0x7fef4ff8(,%eax,4),%edx
80106007:	c7 04 c5 e2 68 11 80 	movl   $0x8e000008,-0x7fee971e(,%eax,8)
8010600e:	08 00 00 8e 
80106012:	66 89 14 c5 e0 68 11 	mov    %dx,-0x7fee9720(,%eax,8)
80106019:	80 
8010601a:	c1 ea 10             	shr    $0x10,%edx
8010601d:	66 89 14 c5 e6 68 11 	mov    %dx,-0x7fee971a(,%eax,8)
80106024:	80 
  for(i = 0; i < 256; i++)
80106025:	83 c0 01             	add    $0x1,%eax
80106028:	3d 00 01 00 00       	cmp    $0x100,%eax
8010602d:	75 d1                	jne    80106000 <tvinit+0x10>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);

  initlock(&tickslock, "time");
8010602f:	83 ec 08             	sub    $0x8,%esp
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80106032:	a1 08 b1 10 80       	mov    0x8010b108,%eax
80106037:	c7 05 e2 6a 11 80 08 	movl   $0xef000008,0x80116ae2
8010603e:	00 00 ef 
  initlock(&tickslock, "time");
80106041:	68 25 80 10 80       	push   $0x80108025
80106046:	68 a0 68 11 80       	push   $0x801168a0
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
8010604b:	66 a3 e0 6a 11 80    	mov    %ax,0x80116ae0
80106051:	c1 e8 10             	shr    $0x10,%eax
80106054:	66 a3 e6 6a 11 80    	mov    %ax,0x80116ae6
  initlock(&tickslock, "time");
8010605a:	e8 31 ea ff ff       	call   80104a90 <initlock>
}
8010605f:	83 c4 10             	add    $0x10,%esp
80106062:	c9                   	leave  
80106063:	c3                   	ret    
80106064:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010606b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010606f:	90                   	nop

80106070 <idtinit>:

void
idtinit(void)
{
80106070:	f3 0f 1e fb          	endbr32 
80106074:	55                   	push   %ebp
  pd[0] = size - 1;
80106075:	b8 ff 07 00 00       	mov    $0x7ff,%eax
8010607a:	89 e5                	mov    %esp,%ebp
8010607c:	83 ec 10             	sub    $0x10,%esp
8010607f:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
80106083:	b8 e0 68 11 80       	mov    $0x801168e0,%eax
80106088:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
8010608c:	c1 e8 10             	shr    $0x10,%eax
8010608f:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r"(pd));
80106093:	8d 45 fa             	lea    -0x6(%ebp),%eax
80106096:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80106099:	c9                   	leave  
8010609a:	c3                   	ret    
8010609b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010609f:	90                   	nop

801060a0 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
801060a0:	f3 0f 1e fb          	endbr32 
801060a4:	55                   	push   %ebp
801060a5:	89 e5                	mov    %esp,%ebp
801060a7:	57                   	push   %edi
801060a8:	56                   	push   %esi
801060a9:	53                   	push   %ebx
801060aa:	83 ec 1c             	sub    $0x1c,%esp
801060ad:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(tf->trapno == T_SYSCALL){
801060b0:	8b 43 30             	mov    0x30(%ebx),%eax
801060b3:	83 f8 40             	cmp    $0x40,%eax
801060b6:	0f 84 bc 01 00 00    	je     80106278 <trap+0x1d8>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
801060bc:	83 e8 20             	sub    $0x20,%eax
801060bf:	83 f8 1f             	cmp    $0x1f,%eax
801060c2:	77 08                	ja     801060cc <trap+0x2c>
801060c4:	3e ff 24 85 cc 80 10 	notrack jmp *-0x7fef7f34(,%eax,4)
801060cb:	80 
    lapiceoi();
    break;

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
801060cc:	e8 cf de ff ff       	call   80103fa0 <myproc>
801060d1:	8b 7b 38             	mov    0x38(%ebx),%edi
801060d4:	85 c0                	test   %eax,%eax
801060d6:	0f 84 eb 01 00 00    	je     801062c7 <trap+0x227>
801060dc:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
801060e0:	0f 84 e1 01 00 00    	je     801062c7 <trap+0x227>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r"(val));
801060e6:	0f 20 d1             	mov    %cr2,%ecx
801060e9:	89 4d d8             	mov    %ecx,-0x28(%ebp)
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801060ec:	e8 8f de ff ff       	call   80103f80 <cpuid>
801060f1:	8b 73 30             	mov    0x30(%ebx),%esi
801060f4:	89 45 dc             	mov    %eax,-0x24(%ebp)
801060f7:	8b 43 34             	mov    0x34(%ebx),%eax
801060fa:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
801060fd:	e8 9e de ff ff       	call   80103fa0 <myproc>
80106102:	89 45 e0             	mov    %eax,-0x20(%ebp)
80106105:	e8 96 de ff ff       	call   80103fa0 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
8010610a:	8b 4d d8             	mov    -0x28(%ebp),%ecx
8010610d:	8b 55 dc             	mov    -0x24(%ebp),%edx
80106110:	51                   	push   %ecx
80106111:	57                   	push   %edi
80106112:	52                   	push   %edx
80106113:	ff 75 e4             	pushl  -0x1c(%ebp)
80106116:	56                   	push   %esi
            myproc()->pid, myproc()->name, tf->trapno,
80106117:	8b 75 e0             	mov    -0x20(%ebp),%esi
8010611a:	83 c6 6c             	add    $0x6c,%esi
    cprintf("pid %d %s: trap %d err %d on cpu %d "
8010611d:	56                   	push   %esi
8010611e:	ff 70 10             	pushl  0x10(%eax)
80106121:	68 88 80 10 80       	push   $0x80108088
80106126:	e8 75 a6 ff ff       	call   801007a0 <cprintf>
            tf->err, cpuid(), tf->eip, rcr2());
    myproc()->killed = 1;
8010612b:	83 c4 20             	add    $0x20,%esp
8010612e:	e8 6d de ff ff       	call   80103fa0 <myproc>
80106133:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010613a:	e8 61 de ff ff       	call   80103fa0 <myproc>
8010613f:	85 c0                	test   %eax,%eax
80106141:	74 1d                	je     80106160 <trap+0xc0>
80106143:	e8 58 de ff ff       	call   80103fa0 <myproc>
80106148:	8b 50 24             	mov    0x24(%eax),%edx
8010614b:	85 d2                	test   %edx,%edx
8010614d:	74 11                	je     80106160 <trap+0xc0>
8010614f:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80106153:	83 e0 03             	and    $0x3,%eax
80106156:	66 83 f8 03          	cmp    $0x3,%ax
8010615a:	0f 84 50 01 00 00    	je     801062b0 <trap+0x210>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80106160:	e8 3b de ff ff       	call   80103fa0 <myproc>
80106165:	85 c0                	test   %eax,%eax
80106167:	74 0f                	je     80106178 <trap+0xd8>
80106169:	e8 32 de ff ff       	call   80103fa0 <myproc>
8010616e:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80106172:	0f 84 e8 00 00 00    	je     80106260 <trap+0x1c0>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106178:	e8 23 de ff ff       	call   80103fa0 <myproc>
8010617d:	85 c0                	test   %eax,%eax
8010617f:	74 1d                	je     8010619e <trap+0xfe>
80106181:	e8 1a de ff ff       	call   80103fa0 <myproc>
80106186:	8b 40 24             	mov    0x24(%eax),%eax
80106189:	85 c0                	test   %eax,%eax
8010618b:	74 11                	je     8010619e <trap+0xfe>
8010618d:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80106191:	83 e0 03             	and    $0x3,%eax
80106194:	66 83 f8 03          	cmp    $0x3,%ax
80106198:	0f 84 03 01 00 00    	je     801062a1 <trap+0x201>
    exit();
}
8010619e:	8d 65 f4             	lea    -0xc(%ebp),%esp
801061a1:	5b                   	pop    %ebx
801061a2:	5e                   	pop    %esi
801061a3:	5f                   	pop    %edi
801061a4:	5d                   	pop    %ebp
801061a5:	c3                   	ret    
    ideintr();
801061a6:	e8 75 c6 ff ff       	call   80102820 <ideintr>
    lapiceoi();
801061ab:	e8 50 cd ff ff       	call   80102f00 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801061b0:	e8 eb dd ff ff       	call   80103fa0 <myproc>
801061b5:	85 c0                	test   %eax,%eax
801061b7:	75 8a                	jne    80106143 <trap+0xa3>
801061b9:	eb a5                	jmp    80106160 <trap+0xc0>
    if(cpuid() == 0){
801061bb:	e8 c0 dd ff ff       	call   80103f80 <cpuid>
801061c0:	85 c0                	test   %eax,%eax
801061c2:	75 e7                	jne    801061ab <trap+0x10b>
      acquire(&tickslock);
801061c4:	83 ec 0c             	sub    $0xc,%esp
801061c7:	68 a0 68 11 80       	push   $0x801168a0
801061cc:	e8 3f ea ff ff       	call   80104c10 <acquire>
      wakeup(&ticks);
801061d1:	c7 04 24 e0 70 11 80 	movl   $0x801170e0,(%esp)
      ticks++;
801061d8:	83 05 e0 70 11 80 01 	addl   $0x1,0x801170e0
      wakeup(&ticks);
801061df:	e8 3c e5 ff ff       	call   80104720 <wakeup>
      release(&tickslock);
801061e4:	c7 04 24 a0 68 11 80 	movl   $0x801168a0,(%esp)
801061eb:	e8 e0 ea ff ff       	call   80104cd0 <release>
801061f0:	83 c4 10             	add    $0x10,%esp
    lapiceoi();
801061f3:	eb b6                	jmp    801061ab <trap+0x10b>
    kbdintr();
801061f5:	e8 c6 cb ff ff       	call   80102dc0 <kbdintr>
    lapiceoi();
801061fa:	e8 01 cd ff ff       	call   80102f00 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801061ff:	e8 9c dd ff ff       	call   80103fa0 <myproc>
80106204:	85 c0                	test   %eax,%eax
80106206:	0f 85 37 ff ff ff    	jne    80106143 <trap+0xa3>
8010620c:	e9 4f ff ff ff       	jmp    80106160 <trap+0xc0>
    uartintr();
80106211:	e8 4a 02 00 00       	call   80106460 <uartintr>
    lapiceoi();
80106216:	e8 e5 cc ff ff       	call   80102f00 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010621b:	e8 80 dd ff ff       	call   80103fa0 <myproc>
80106220:	85 c0                	test   %eax,%eax
80106222:	0f 85 1b ff ff ff    	jne    80106143 <trap+0xa3>
80106228:	e9 33 ff ff ff       	jmp    80106160 <trap+0xc0>
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
8010622d:	8b 7b 38             	mov    0x38(%ebx),%edi
80106230:	0f b7 73 3c          	movzwl 0x3c(%ebx),%esi
80106234:	e8 47 dd ff ff       	call   80103f80 <cpuid>
80106239:	57                   	push   %edi
8010623a:	56                   	push   %esi
8010623b:	50                   	push   %eax
8010623c:	68 30 80 10 80       	push   $0x80108030
80106241:	e8 5a a5 ff ff       	call   801007a0 <cprintf>
    lapiceoi();
80106246:	e8 b5 cc ff ff       	call   80102f00 <lapiceoi>
    break;
8010624b:	83 c4 10             	add    $0x10,%esp
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010624e:	e8 4d dd ff ff       	call   80103fa0 <myproc>
80106253:	85 c0                	test   %eax,%eax
80106255:	0f 85 e8 fe ff ff    	jne    80106143 <trap+0xa3>
8010625b:	e9 00 ff ff ff       	jmp    80106160 <trap+0xc0>
  if(myproc() && myproc()->state == RUNNING &&
80106260:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
80106264:	0f 85 0e ff ff ff    	jne    80106178 <trap+0xd8>
    yield();
8010626a:	e8 a1 e2 ff ff       	call   80104510 <yield>
8010626f:	e9 04 ff ff ff       	jmp    80106178 <trap+0xd8>
80106274:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed)
80106278:	e8 23 dd ff ff       	call   80103fa0 <myproc>
8010627d:	8b 70 24             	mov    0x24(%eax),%esi
80106280:	85 f6                	test   %esi,%esi
80106282:	75 3c                	jne    801062c0 <trap+0x220>
    myproc()->tf = tf;
80106284:	e8 17 dd ff ff       	call   80103fa0 <myproc>
80106289:	89 58 18             	mov    %ebx,0x18(%eax)
    syscall();
8010628c:	e8 5f ee ff ff       	call   801050f0 <syscall>
    if(myproc()->killed)
80106291:	e8 0a dd ff ff       	call   80103fa0 <myproc>
80106296:	8b 48 24             	mov    0x24(%eax),%ecx
80106299:	85 c9                	test   %ecx,%ecx
8010629b:	0f 84 fd fe ff ff    	je     8010619e <trap+0xfe>
}
801062a1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801062a4:	5b                   	pop    %ebx
801062a5:	5e                   	pop    %esi
801062a6:	5f                   	pop    %edi
801062a7:	5d                   	pop    %ebp
      exit();
801062a8:	e9 23 e1 ff ff       	jmp    801043d0 <exit>
801062ad:	8d 76 00             	lea    0x0(%esi),%esi
    exit();
801062b0:	e8 1b e1 ff ff       	call   801043d0 <exit>
801062b5:	e9 a6 fe ff ff       	jmp    80106160 <trap+0xc0>
801062ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      exit();
801062c0:	e8 0b e1 ff ff       	call   801043d0 <exit>
801062c5:	eb bd                	jmp    80106284 <trap+0x1e4>
801062c7:	0f 20 d6             	mov    %cr2,%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
801062ca:	e8 b1 dc ff ff       	call   80103f80 <cpuid>
801062cf:	83 ec 0c             	sub    $0xc,%esp
801062d2:	56                   	push   %esi
801062d3:	57                   	push   %edi
801062d4:	50                   	push   %eax
801062d5:	ff 73 30             	pushl  0x30(%ebx)
801062d8:	68 54 80 10 80       	push   $0x80108054
801062dd:	e8 be a4 ff ff       	call   801007a0 <cprintf>
      panic("trap");
801062e2:	83 c4 14             	add    $0x14,%esp
801062e5:	68 2a 80 10 80       	push   $0x8010802a
801062ea:	e8 c1 a0 ff ff       	call   801003b0 <panic>
801062ef:	90                   	nop

801062f0 <uartgetc>:
  outb(COM1+0, c);
}

static int
uartgetc(void)
{
801062f0:	f3 0f 1e fb          	endbr32 
  if(!uart)
801062f4:	a1 3c c2 10 80       	mov    0x8010c23c,%eax
801062f9:	85 c0                	test   %eax,%eax
801062fb:	74 1b                	je     80106318 <uartgetc+0x28>
  asm volatile("in %1,%0" : "=a"(data) : "d"(port));
801062fd:	ba fd 03 00 00       	mov    $0x3fd,%edx
80106302:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
80106303:	a8 01                	test   $0x1,%al
80106305:	74 11                	je     80106318 <uartgetc+0x28>
80106307:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010630c:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
8010630d:	0f b6 c0             	movzbl %al,%eax
80106310:	c3                   	ret    
80106311:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80106318:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010631d:	c3                   	ret    
8010631e:	66 90                	xchg   %ax,%ax

80106320 <uartputc.part.0>:
uartputc(int c)
80106320:	55                   	push   %ebp
80106321:	89 e5                	mov    %esp,%ebp
80106323:	57                   	push   %edi
80106324:	89 c7                	mov    %eax,%edi
80106326:	56                   	push   %esi
80106327:	be fd 03 00 00       	mov    $0x3fd,%esi
8010632c:	53                   	push   %ebx
8010632d:	bb 80 00 00 00       	mov    $0x80,%ebx
80106332:	83 ec 0c             	sub    $0xc,%esp
80106335:	eb 1b                	jmp    80106352 <uartputc.part.0+0x32>
80106337:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010633e:	66 90                	xchg   %ax,%ax
    microdelay(10);
80106340:	83 ec 0c             	sub    $0xc,%esp
80106343:	6a 0a                	push   $0xa
80106345:	e8 d6 cb ff ff       	call   80102f20 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
8010634a:	83 c4 10             	add    $0x10,%esp
8010634d:	83 eb 01             	sub    $0x1,%ebx
80106350:	74 07                	je     80106359 <uartputc.part.0+0x39>
80106352:	89 f2                	mov    %esi,%edx
80106354:	ec                   	in     (%dx),%al
80106355:	a8 20                	test   $0x20,%al
80106357:	74 e7                	je     80106340 <uartputc.part.0+0x20>
  asm volatile("out %0,%1" : : "a"(data), "d"(port));
80106359:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010635e:	89 f8                	mov    %edi,%eax
80106360:	ee                   	out    %al,(%dx)
}
80106361:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106364:	5b                   	pop    %ebx
80106365:	5e                   	pop    %esi
80106366:	5f                   	pop    %edi
80106367:	5d                   	pop    %ebp
80106368:	c3                   	ret    
80106369:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106370 <uartinit>:
{
80106370:	f3 0f 1e fb          	endbr32 
80106374:	55                   	push   %ebp
80106375:	31 c9                	xor    %ecx,%ecx
80106377:	89 c8                	mov    %ecx,%eax
80106379:	89 e5                	mov    %esp,%ebp
8010637b:	57                   	push   %edi
8010637c:	56                   	push   %esi
8010637d:	53                   	push   %ebx
8010637e:	bb fa 03 00 00       	mov    $0x3fa,%ebx
80106383:	89 da                	mov    %ebx,%edx
80106385:	83 ec 0c             	sub    $0xc,%esp
80106388:	ee                   	out    %al,(%dx)
80106389:	bf fb 03 00 00       	mov    $0x3fb,%edi
8010638e:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
80106393:	89 fa                	mov    %edi,%edx
80106395:	ee                   	out    %al,(%dx)
80106396:	b8 0c 00 00 00       	mov    $0xc,%eax
8010639b:	ba f8 03 00 00       	mov    $0x3f8,%edx
801063a0:	ee                   	out    %al,(%dx)
801063a1:	be f9 03 00 00       	mov    $0x3f9,%esi
801063a6:	89 c8                	mov    %ecx,%eax
801063a8:	89 f2                	mov    %esi,%edx
801063aa:	ee                   	out    %al,(%dx)
801063ab:	b8 03 00 00 00       	mov    $0x3,%eax
801063b0:	89 fa                	mov    %edi,%edx
801063b2:	ee                   	out    %al,(%dx)
801063b3:	ba fc 03 00 00       	mov    $0x3fc,%edx
801063b8:	89 c8                	mov    %ecx,%eax
801063ba:	ee                   	out    %al,(%dx)
801063bb:	b8 01 00 00 00       	mov    $0x1,%eax
801063c0:	89 f2                	mov    %esi,%edx
801063c2:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a"(data) : "d"(port));
801063c3:	ba fd 03 00 00       	mov    $0x3fd,%edx
801063c8:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
801063c9:	3c ff                	cmp    $0xff,%al
801063cb:	74 52                	je     8010641f <uartinit+0xaf>
  uart = 1;
801063cd:	c7 05 3c c2 10 80 01 	movl   $0x1,0x8010c23c
801063d4:	00 00 00 
801063d7:	89 da                	mov    %ebx,%edx
801063d9:	ec                   	in     (%dx),%al
801063da:	ba f8 03 00 00       	mov    $0x3f8,%edx
801063df:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
801063e0:	83 ec 08             	sub    $0x8,%esp
801063e3:	be 76 00 00 00       	mov    $0x76,%esi
  for(p="xv6...\n"; *p; p++)
801063e8:	bb 4c 81 10 80       	mov    $0x8010814c,%ebx
  ioapicenable(IRQ_COM1, 0);
801063ed:	6a 00                	push   $0x0
801063ef:	6a 04                	push   $0x4
801063f1:	e8 7a c6 ff ff       	call   80102a70 <ioapicenable>
801063f6:	83 c4 10             	add    $0x10,%esp
  for(p="xv6...\n"; *p; p++)
801063f9:	b8 78 00 00 00       	mov    $0x78,%eax
801063fe:	eb 04                	jmp    80106404 <uartinit+0x94>
80106400:	0f b6 73 01          	movzbl 0x1(%ebx),%esi
  if(!uart)
80106404:	8b 15 3c c2 10 80    	mov    0x8010c23c,%edx
8010640a:	85 d2                	test   %edx,%edx
8010640c:	74 08                	je     80106416 <uartinit+0xa6>
    uartputc(*p);
8010640e:	0f be c0             	movsbl %al,%eax
80106411:	e8 0a ff ff ff       	call   80106320 <uartputc.part.0>
  for(p="xv6...\n"; *p; p++)
80106416:	89 f0                	mov    %esi,%eax
80106418:	83 c3 01             	add    $0x1,%ebx
8010641b:	84 c0                	test   %al,%al
8010641d:	75 e1                	jne    80106400 <uartinit+0x90>
}
8010641f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106422:	5b                   	pop    %ebx
80106423:	5e                   	pop    %esi
80106424:	5f                   	pop    %edi
80106425:	5d                   	pop    %ebp
80106426:	c3                   	ret    
80106427:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010642e:	66 90                	xchg   %ax,%ax

80106430 <uartputc>:
{
80106430:	f3 0f 1e fb          	endbr32 
80106434:	55                   	push   %ebp
  if(!uart)
80106435:	8b 15 3c c2 10 80    	mov    0x8010c23c,%edx
{
8010643b:	89 e5                	mov    %esp,%ebp
8010643d:	8b 45 08             	mov    0x8(%ebp),%eax
  if(!uart)
80106440:	85 d2                	test   %edx,%edx
80106442:	74 0c                	je     80106450 <uartputc+0x20>
}
80106444:	5d                   	pop    %ebp
80106445:	e9 d6 fe ff ff       	jmp    80106320 <uartputc.part.0>
8010644a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106450:	5d                   	pop    %ebp
80106451:	c3                   	ret    
80106452:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106459:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106460 <uartintr>:

void
uartintr(void)
{
80106460:	f3 0f 1e fb          	endbr32 
80106464:	55                   	push   %ebp
80106465:	89 e5                	mov    %esp,%ebp
80106467:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
8010646a:	68 f0 62 10 80       	push   $0x801062f0
8010646f:	e8 cc a8 ff ff       	call   80100d40 <consoleintr>
}
80106474:	83 c4 10             	add    $0x10,%esp
80106477:	c9                   	leave  
80106478:	c3                   	ret    

80106479 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80106479:	6a 00                	push   $0x0
  pushl $0
8010647b:	6a 00                	push   $0x0
  jmp alltraps
8010647d:	e9 4b fb ff ff       	jmp    80105fcd <alltraps>

80106482 <vector1>:
.globl vector1
vector1:
  pushl $0
80106482:	6a 00                	push   $0x0
  pushl $1
80106484:	6a 01                	push   $0x1
  jmp alltraps
80106486:	e9 42 fb ff ff       	jmp    80105fcd <alltraps>

8010648b <vector2>:
.globl vector2
vector2:
  pushl $0
8010648b:	6a 00                	push   $0x0
  pushl $2
8010648d:	6a 02                	push   $0x2
  jmp alltraps
8010648f:	e9 39 fb ff ff       	jmp    80105fcd <alltraps>

80106494 <vector3>:
.globl vector3
vector3:
  pushl $0
80106494:	6a 00                	push   $0x0
  pushl $3
80106496:	6a 03                	push   $0x3
  jmp alltraps
80106498:	e9 30 fb ff ff       	jmp    80105fcd <alltraps>

8010649d <vector4>:
.globl vector4
vector4:
  pushl $0
8010649d:	6a 00                	push   $0x0
  pushl $4
8010649f:	6a 04                	push   $0x4
  jmp alltraps
801064a1:	e9 27 fb ff ff       	jmp    80105fcd <alltraps>

801064a6 <vector5>:
.globl vector5
vector5:
  pushl $0
801064a6:	6a 00                	push   $0x0
  pushl $5
801064a8:	6a 05                	push   $0x5
  jmp alltraps
801064aa:	e9 1e fb ff ff       	jmp    80105fcd <alltraps>

801064af <vector6>:
.globl vector6
vector6:
  pushl $0
801064af:	6a 00                	push   $0x0
  pushl $6
801064b1:	6a 06                	push   $0x6
  jmp alltraps
801064b3:	e9 15 fb ff ff       	jmp    80105fcd <alltraps>

801064b8 <vector7>:
.globl vector7
vector7:
  pushl $0
801064b8:	6a 00                	push   $0x0
  pushl $7
801064ba:	6a 07                	push   $0x7
  jmp alltraps
801064bc:	e9 0c fb ff ff       	jmp    80105fcd <alltraps>

801064c1 <vector8>:
.globl vector8
vector8:
  pushl $8
801064c1:	6a 08                	push   $0x8
  jmp alltraps
801064c3:	e9 05 fb ff ff       	jmp    80105fcd <alltraps>

801064c8 <vector9>:
.globl vector9
vector9:
  pushl $0
801064c8:	6a 00                	push   $0x0
  pushl $9
801064ca:	6a 09                	push   $0x9
  jmp alltraps
801064cc:	e9 fc fa ff ff       	jmp    80105fcd <alltraps>

801064d1 <vector10>:
.globl vector10
vector10:
  pushl $10
801064d1:	6a 0a                	push   $0xa
  jmp alltraps
801064d3:	e9 f5 fa ff ff       	jmp    80105fcd <alltraps>

801064d8 <vector11>:
.globl vector11
vector11:
  pushl $11
801064d8:	6a 0b                	push   $0xb
  jmp alltraps
801064da:	e9 ee fa ff ff       	jmp    80105fcd <alltraps>

801064df <vector12>:
.globl vector12
vector12:
  pushl $12
801064df:	6a 0c                	push   $0xc
  jmp alltraps
801064e1:	e9 e7 fa ff ff       	jmp    80105fcd <alltraps>

801064e6 <vector13>:
.globl vector13
vector13:
  pushl $13
801064e6:	6a 0d                	push   $0xd
  jmp alltraps
801064e8:	e9 e0 fa ff ff       	jmp    80105fcd <alltraps>

801064ed <vector14>:
.globl vector14
vector14:
  pushl $14
801064ed:	6a 0e                	push   $0xe
  jmp alltraps
801064ef:	e9 d9 fa ff ff       	jmp    80105fcd <alltraps>

801064f4 <vector15>:
.globl vector15
vector15:
  pushl $0
801064f4:	6a 00                	push   $0x0
  pushl $15
801064f6:	6a 0f                	push   $0xf
  jmp alltraps
801064f8:	e9 d0 fa ff ff       	jmp    80105fcd <alltraps>

801064fd <vector16>:
.globl vector16
vector16:
  pushl $0
801064fd:	6a 00                	push   $0x0
  pushl $16
801064ff:	6a 10                	push   $0x10
  jmp alltraps
80106501:	e9 c7 fa ff ff       	jmp    80105fcd <alltraps>

80106506 <vector17>:
.globl vector17
vector17:
  pushl $17
80106506:	6a 11                	push   $0x11
  jmp alltraps
80106508:	e9 c0 fa ff ff       	jmp    80105fcd <alltraps>

8010650d <vector18>:
.globl vector18
vector18:
  pushl $0
8010650d:	6a 00                	push   $0x0
  pushl $18
8010650f:	6a 12                	push   $0x12
  jmp alltraps
80106511:	e9 b7 fa ff ff       	jmp    80105fcd <alltraps>

80106516 <vector19>:
.globl vector19
vector19:
  pushl $0
80106516:	6a 00                	push   $0x0
  pushl $19
80106518:	6a 13                	push   $0x13
  jmp alltraps
8010651a:	e9 ae fa ff ff       	jmp    80105fcd <alltraps>

8010651f <vector20>:
.globl vector20
vector20:
  pushl $0
8010651f:	6a 00                	push   $0x0
  pushl $20
80106521:	6a 14                	push   $0x14
  jmp alltraps
80106523:	e9 a5 fa ff ff       	jmp    80105fcd <alltraps>

80106528 <vector21>:
.globl vector21
vector21:
  pushl $0
80106528:	6a 00                	push   $0x0
  pushl $21
8010652a:	6a 15                	push   $0x15
  jmp alltraps
8010652c:	e9 9c fa ff ff       	jmp    80105fcd <alltraps>

80106531 <vector22>:
.globl vector22
vector22:
  pushl $0
80106531:	6a 00                	push   $0x0
  pushl $22
80106533:	6a 16                	push   $0x16
  jmp alltraps
80106535:	e9 93 fa ff ff       	jmp    80105fcd <alltraps>

8010653a <vector23>:
.globl vector23
vector23:
  pushl $0
8010653a:	6a 00                	push   $0x0
  pushl $23
8010653c:	6a 17                	push   $0x17
  jmp alltraps
8010653e:	e9 8a fa ff ff       	jmp    80105fcd <alltraps>

80106543 <vector24>:
.globl vector24
vector24:
  pushl $0
80106543:	6a 00                	push   $0x0
  pushl $24
80106545:	6a 18                	push   $0x18
  jmp alltraps
80106547:	e9 81 fa ff ff       	jmp    80105fcd <alltraps>

8010654c <vector25>:
.globl vector25
vector25:
  pushl $0
8010654c:	6a 00                	push   $0x0
  pushl $25
8010654e:	6a 19                	push   $0x19
  jmp alltraps
80106550:	e9 78 fa ff ff       	jmp    80105fcd <alltraps>

80106555 <vector26>:
.globl vector26
vector26:
  pushl $0
80106555:	6a 00                	push   $0x0
  pushl $26
80106557:	6a 1a                	push   $0x1a
  jmp alltraps
80106559:	e9 6f fa ff ff       	jmp    80105fcd <alltraps>

8010655e <vector27>:
.globl vector27
vector27:
  pushl $0
8010655e:	6a 00                	push   $0x0
  pushl $27
80106560:	6a 1b                	push   $0x1b
  jmp alltraps
80106562:	e9 66 fa ff ff       	jmp    80105fcd <alltraps>

80106567 <vector28>:
.globl vector28
vector28:
  pushl $0
80106567:	6a 00                	push   $0x0
  pushl $28
80106569:	6a 1c                	push   $0x1c
  jmp alltraps
8010656b:	e9 5d fa ff ff       	jmp    80105fcd <alltraps>

80106570 <vector29>:
.globl vector29
vector29:
  pushl $0
80106570:	6a 00                	push   $0x0
  pushl $29
80106572:	6a 1d                	push   $0x1d
  jmp alltraps
80106574:	e9 54 fa ff ff       	jmp    80105fcd <alltraps>

80106579 <vector30>:
.globl vector30
vector30:
  pushl $0
80106579:	6a 00                	push   $0x0
  pushl $30
8010657b:	6a 1e                	push   $0x1e
  jmp alltraps
8010657d:	e9 4b fa ff ff       	jmp    80105fcd <alltraps>

80106582 <vector31>:
.globl vector31
vector31:
  pushl $0
80106582:	6a 00                	push   $0x0
  pushl $31
80106584:	6a 1f                	push   $0x1f
  jmp alltraps
80106586:	e9 42 fa ff ff       	jmp    80105fcd <alltraps>

8010658b <vector32>:
.globl vector32
vector32:
  pushl $0
8010658b:	6a 00                	push   $0x0
  pushl $32
8010658d:	6a 20                	push   $0x20
  jmp alltraps
8010658f:	e9 39 fa ff ff       	jmp    80105fcd <alltraps>

80106594 <vector33>:
.globl vector33
vector33:
  pushl $0
80106594:	6a 00                	push   $0x0
  pushl $33
80106596:	6a 21                	push   $0x21
  jmp alltraps
80106598:	e9 30 fa ff ff       	jmp    80105fcd <alltraps>

8010659d <vector34>:
.globl vector34
vector34:
  pushl $0
8010659d:	6a 00                	push   $0x0
  pushl $34
8010659f:	6a 22                	push   $0x22
  jmp alltraps
801065a1:	e9 27 fa ff ff       	jmp    80105fcd <alltraps>

801065a6 <vector35>:
.globl vector35
vector35:
  pushl $0
801065a6:	6a 00                	push   $0x0
  pushl $35
801065a8:	6a 23                	push   $0x23
  jmp alltraps
801065aa:	e9 1e fa ff ff       	jmp    80105fcd <alltraps>

801065af <vector36>:
.globl vector36
vector36:
  pushl $0
801065af:	6a 00                	push   $0x0
  pushl $36
801065b1:	6a 24                	push   $0x24
  jmp alltraps
801065b3:	e9 15 fa ff ff       	jmp    80105fcd <alltraps>

801065b8 <vector37>:
.globl vector37
vector37:
  pushl $0
801065b8:	6a 00                	push   $0x0
  pushl $37
801065ba:	6a 25                	push   $0x25
  jmp alltraps
801065bc:	e9 0c fa ff ff       	jmp    80105fcd <alltraps>

801065c1 <vector38>:
.globl vector38
vector38:
  pushl $0
801065c1:	6a 00                	push   $0x0
  pushl $38
801065c3:	6a 26                	push   $0x26
  jmp alltraps
801065c5:	e9 03 fa ff ff       	jmp    80105fcd <alltraps>

801065ca <vector39>:
.globl vector39
vector39:
  pushl $0
801065ca:	6a 00                	push   $0x0
  pushl $39
801065cc:	6a 27                	push   $0x27
  jmp alltraps
801065ce:	e9 fa f9 ff ff       	jmp    80105fcd <alltraps>

801065d3 <vector40>:
.globl vector40
vector40:
  pushl $0
801065d3:	6a 00                	push   $0x0
  pushl $40
801065d5:	6a 28                	push   $0x28
  jmp alltraps
801065d7:	e9 f1 f9 ff ff       	jmp    80105fcd <alltraps>

801065dc <vector41>:
.globl vector41
vector41:
  pushl $0
801065dc:	6a 00                	push   $0x0
  pushl $41
801065de:	6a 29                	push   $0x29
  jmp alltraps
801065e0:	e9 e8 f9 ff ff       	jmp    80105fcd <alltraps>

801065e5 <vector42>:
.globl vector42
vector42:
  pushl $0
801065e5:	6a 00                	push   $0x0
  pushl $42
801065e7:	6a 2a                	push   $0x2a
  jmp alltraps
801065e9:	e9 df f9 ff ff       	jmp    80105fcd <alltraps>

801065ee <vector43>:
.globl vector43
vector43:
  pushl $0
801065ee:	6a 00                	push   $0x0
  pushl $43
801065f0:	6a 2b                	push   $0x2b
  jmp alltraps
801065f2:	e9 d6 f9 ff ff       	jmp    80105fcd <alltraps>

801065f7 <vector44>:
.globl vector44
vector44:
  pushl $0
801065f7:	6a 00                	push   $0x0
  pushl $44
801065f9:	6a 2c                	push   $0x2c
  jmp alltraps
801065fb:	e9 cd f9 ff ff       	jmp    80105fcd <alltraps>

80106600 <vector45>:
.globl vector45
vector45:
  pushl $0
80106600:	6a 00                	push   $0x0
  pushl $45
80106602:	6a 2d                	push   $0x2d
  jmp alltraps
80106604:	e9 c4 f9 ff ff       	jmp    80105fcd <alltraps>

80106609 <vector46>:
.globl vector46
vector46:
  pushl $0
80106609:	6a 00                	push   $0x0
  pushl $46
8010660b:	6a 2e                	push   $0x2e
  jmp alltraps
8010660d:	e9 bb f9 ff ff       	jmp    80105fcd <alltraps>

80106612 <vector47>:
.globl vector47
vector47:
  pushl $0
80106612:	6a 00                	push   $0x0
  pushl $47
80106614:	6a 2f                	push   $0x2f
  jmp alltraps
80106616:	e9 b2 f9 ff ff       	jmp    80105fcd <alltraps>

8010661b <vector48>:
.globl vector48
vector48:
  pushl $0
8010661b:	6a 00                	push   $0x0
  pushl $48
8010661d:	6a 30                	push   $0x30
  jmp alltraps
8010661f:	e9 a9 f9 ff ff       	jmp    80105fcd <alltraps>

80106624 <vector49>:
.globl vector49
vector49:
  pushl $0
80106624:	6a 00                	push   $0x0
  pushl $49
80106626:	6a 31                	push   $0x31
  jmp alltraps
80106628:	e9 a0 f9 ff ff       	jmp    80105fcd <alltraps>

8010662d <vector50>:
.globl vector50
vector50:
  pushl $0
8010662d:	6a 00                	push   $0x0
  pushl $50
8010662f:	6a 32                	push   $0x32
  jmp alltraps
80106631:	e9 97 f9 ff ff       	jmp    80105fcd <alltraps>

80106636 <vector51>:
.globl vector51
vector51:
  pushl $0
80106636:	6a 00                	push   $0x0
  pushl $51
80106638:	6a 33                	push   $0x33
  jmp alltraps
8010663a:	e9 8e f9 ff ff       	jmp    80105fcd <alltraps>

8010663f <vector52>:
.globl vector52
vector52:
  pushl $0
8010663f:	6a 00                	push   $0x0
  pushl $52
80106641:	6a 34                	push   $0x34
  jmp alltraps
80106643:	e9 85 f9 ff ff       	jmp    80105fcd <alltraps>

80106648 <vector53>:
.globl vector53
vector53:
  pushl $0
80106648:	6a 00                	push   $0x0
  pushl $53
8010664a:	6a 35                	push   $0x35
  jmp alltraps
8010664c:	e9 7c f9 ff ff       	jmp    80105fcd <alltraps>

80106651 <vector54>:
.globl vector54
vector54:
  pushl $0
80106651:	6a 00                	push   $0x0
  pushl $54
80106653:	6a 36                	push   $0x36
  jmp alltraps
80106655:	e9 73 f9 ff ff       	jmp    80105fcd <alltraps>

8010665a <vector55>:
.globl vector55
vector55:
  pushl $0
8010665a:	6a 00                	push   $0x0
  pushl $55
8010665c:	6a 37                	push   $0x37
  jmp alltraps
8010665e:	e9 6a f9 ff ff       	jmp    80105fcd <alltraps>

80106663 <vector56>:
.globl vector56
vector56:
  pushl $0
80106663:	6a 00                	push   $0x0
  pushl $56
80106665:	6a 38                	push   $0x38
  jmp alltraps
80106667:	e9 61 f9 ff ff       	jmp    80105fcd <alltraps>

8010666c <vector57>:
.globl vector57
vector57:
  pushl $0
8010666c:	6a 00                	push   $0x0
  pushl $57
8010666e:	6a 39                	push   $0x39
  jmp alltraps
80106670:	e9 58 f9 ff ff       	jmp    80105fcd <alltraps>

80106675 <vector58>:
.globl vector58
vector58:
  pushl $0
80106675:	6a 00                	push   $0x0
  pushl $58
80106677:	6a 3a                	push   $0x3a
  jmp alltraps
80106679:	e9 4f f9 ff ff       	jmp    80105fcd <alltraps>

8010667e <vector59>:
.globl vector59
vector59:
  pushl $0
8010667e:	6a 00                	push   $0x0
  pushl $59
80106680:	6a 3b                	push   $0x3b
  jmp alltraps
80106682:	e9 46 f9 ff ff       	jmp    80105fcd <alltraps>

80106687 <vector60>:
.globl vector60
vector60:
  pushl $0
80106687:	6a 00                	push   $0x0
  pushl $60
80106689:	6a 3c                	push   $0x3c
  jmp alltraps
8010668b:	e9 3d f9 ff ff       	jmp    80105fcd <alltraps>

80106690 <vector61>:
.globl vector61
vector61:
  pushl $0
80106690:	6a 00                	push   $0x0
  pushl $61
80106692:	6a 3d                	push   $0x3d
  jmp alltraps
80106694:	e9 34 f9 ff ff       	jmp    80105fcd <alltraps>

80106699 <vector62>:
.globl vector62
vector62:
  pushl $0
80106699:	6a 00                	push   $0x0
  pushl $62
8010669b:	6a 3e                	push   $0x3e
  jmp alltraps
8010669d:	e9 2b f9 ff ff       	jmp    80105fcd <alltraps>

801066a2 <vector63>:
.globl vector63
vector63:
  pushl $0
801066a2:	6a 00                	push   $0x0
  pushl $63
801066a4:	6a 3f                	push   $0x3f
  jmp alltraps
801066a6:	e9 22 f9 ff ff       	jmp    80105fcd <alltraps>

801066ab <vector64>:
.globl vector64
vector64:
  pushl $0
801066ab:	6a 00                	push   $0x0
  pushl $64
801066ad:	6a 40                	push   $0x40
  jmp alltraps
801066af:	e9 19 f9 ff ff       	jmp    80105fcd <alltraps>

801066b4 <vector65>:
.globl vector65
vector65:
  pushl $0
801066b4:	6a 00                	push   $0x0
  pushl $65
801066b6:	6a 41                	push   $0x41
  jmp alltraps
801066b8:	e9 10 f9 ff ff       	jmp    80105fcd <alltraps>

801066bd <vector66>:
.globl vector66
vector66:
  pushl $0
801066bd:	6a 00                	push   $0x0
  pushl $66
801066bf:	6a 42                	push   $0x42
  jmp alltraps
801066c1:	e9 07 f9 ff ff       	jmp    80105fcd <alltraps>

801066c6 <vector67>:
.globl vector67
vector67:
  pushl $0
801066c6:	6a 00                	push   $0x0
  pushl $67
801066c8:	6a 43                	push   $0x43
  jmp alltraps
801066ca:	e9 fe f8 ff ff       	jmp    80105fcd <alltraps>

801066cf <vector68>:
.globl vector68
vector68:
  pushl $0
801066cf:	6a 00                	push   $0x0
  pushl $68
801066d1:	6a 44                	push   $0x44
  jmp alltraps
801066d3:	e9 f5 f8 ff ff       	jmp    80105fcd <alltraps>

801066d8 <vector69>:
.globl vector69
vector69:
  pushl $0
801066d8:	6a 00                	push   $0x0
  pushl $69
801066da:	6a 45                	push   $0x45
  jmp alltraps
801066dc:	e9 ec f8 ff ff       	jmp    80105fcd <alltraps>

801066e1 <vector70>:
.globl vector70
vector70:
  pushl $0
801066e1:	6a 00                	push   $0x0
  pushl $70
801066e3:	6a 46                	push   $0x46
  jmp alltraps
801066e5:	e9 e3 f8 ff ff       	jmp    80105fcd <alltraps>

801066ea <vector71>:
.globl vector71
vector71:
  pushl $0
801066ea:	6a 00                	push   $0x0
  pushl $71
801066ec:	6a 47                	push   $0x47
  jmp alltraps
801066ee:	e9 da f8 ff ff       	jmp    80105fcd <alltraps>

801066f3 <vector72>:
.globl vector72
vector72:
  pushl $0
801066f3:	6a 00                	push   $0x0
  pushl $72
801066f5:	6a 48                	push   $0x48
  jmp alltraps
801066f7:	e9 d1 f8 ff ff       	jmp    80105fcd <alltraps>

801066fc <vector73>:
.globl vector73
vector73:
  pushl $0
801066fc:	6a 00                	push   $0x0
  pushl $73
801066fe:	6a 49                	push   $0x49
  jmp alltraps
80106700:	e9 c8 f8 ff ff       	jmp    80105fcd <alltraps>

80106705 <vector74>:
.globl vector74
vector74:
  pushl $0
80106705:	6a 00                	push   $0x0
  pushl $74
80106707:	6a 4a                	push   $0x4a
  jmp alltraps
80106709:	e9 bf f8 ff ff       	jmp    80105fcd <alltraps>

8010670e <vector75>:
.globl vector75
vector75:
  pushl $0
8010670e:	6a 00                	push   $0x0
  pushl $75
80106710:	6a 4b                	push   $0x4b
  jmp alltraps
80106712:	e9 b6 f8 ff ff       	jmp    80105fcd <alltraps>

80106717 <vector76>:
.globl vector76
vector76:
  pushl $0
80106717:	6a 00                	push   $0x0
  pushl $76
80106719:	6a 4c                	push   $0x4c
  jmp alltraps
8010671b:	e9 ad f8 ff ff       	jmp    80105fcd <alltraps>

80106720 <vector77>:
.globl vector77
vector77:
  pushl $0
80106720:	6a 00                	push   $0x0
  pushl $77
80106722:	6a 4d                	push   $0x4d
  jmp alltraps
80106724:	e9 a4 f8 ff ff       	jmp    80105fcd <alltraps>

80106729 <vector78>:
.globl vector78
vector78:
  pushl $0
80106729:	6a 00                	push   $0x0
  pushl $78
8010672b:	6a 4e                	push   $0x4e
  jmp alltraps
8010672d:	e9 9b f8 ff ff       	jmp    80105fcd <alltraps>

80106732 <vector79>:
.globl vector79
vector79:
  pushl $0
80106732:	6a 00                	push   $0x0
  pushl $79
80106734:	6a 4f                	push   $0x4f
  jmp alltraps
80106736:	e9 92 f8 ff ff       	jmp    80105fcd <alltraps>

8010673b <vector80>:
.globl vector80
vector80:
  pushl $0
8010673b:	6a 00                	push   $0x0
  pushl $80
8010673d:	6a 50                	push   $0x50
  jmp alltraps
8010673f:	e9 89 f8 ff ff       	jmp    80105fcd <alltraps>

80106744 <vector81>:
.globl vector81
vector81:
  pushl $0
80106744:	6a 00                	push   $0x0
  pushl $81
80106746:	6a 51                	push   $0x51
  jmp alltraps
80106748:	e9 80 f8 ff ff       	jmp    80105fcd <alltraps>

8010674d <vector82>:
.globl vector82
vector82:
  pushl $0
8010674d:	6a 00                	push   $0x0
  pushl $82
8010674f:	6a 52                	push   $0x52
  jmp alltraps
80106751:	e9 77 f8 ff ff       	jmp    80105fcd <alltraps>

80106756 <vector83>:
.globl vector83
vector83:
  pushl $0
80106756:	6a 00                	push   $0x0
  pushl $83
80106758:	6a 53                	push   $0x53
  jmp alltraps
8010675a:	e9 6e f8 ff ff       	jmp    80105fcd <alltraps>

8010675f <vector84>:
.globl vector84
vector84:
  pushl $0
8010675f:	6a 00                	push   $0x0
  pushl $84
80106761:	6a 54                	push   $0x54
  jmp alltraps
80106763:	e9 65 f8 ff ff       	jmp    80105fcd <alltraps>

80106768 <vector85>:
.globl vector85
vector85:
  pushl $0
80106768:	6a 00                	push   $0x0
  pushl $85
8010676a:	6a 55                	push   $0x55
  jmp alltraps
8010676c:	e9 5c f8 ff ff       	jmp    80105fcd <alltraps>

80106771 <vector86>:
.globl vector86
vector86:
  pushl $0
80106771:	6a 00                	push   $0x0
  pushl $86
80106773:	6a 56                	push   $0x56
  jmp alltraps
80106775:	e9 53 f8 ff ff       	jmp    80105fcd <alltraps>

8010677a <vector87>:
.globl vector87
vector87:
  pushl $0
8010677a:	6a 00                	push   $0x0
  pushl $87
8010677c:	6a 57                	push   $0x57
  jmp alltraps
8010677e:	e9 4a f8 ff ff       	jmp    80105fcd <alltraps>

80106783 <vector88>:
.globl vector88
vector88:
  pushl $0
80106783:	6a 00                	push   $0x0
  pushl $88
80106785:	6a 58                	push   $0x58
  jmp alltraps
80106787:	e9 41 f8 ff ff       	jmp    80105fcd <alltraps>

8010678c <vector89>:
.globl vector89
vector89:
  pushl $0
8010678c:	6a 00                	push   $0x0
  pushl $89
8010678e:	6a 59                	push   $0x59
  jmp alltraps
80106790:	e9 38 f8 ff ff       	jmp    80105fcd <alltraps>

80106795 <vector90>:
.globl vector90
vector90:
  pushl $0
80106795:	6a 00                	push   $0x0
  pushl $90
80106797:	6a 5a                	push   $0x5a
  jmp alltraps
80106799:	e9 2f f8 ff ff       	jmp    80105fcd <alltraps>

8010679e <vector91>:
.globl vector91
vector91:
  pushl $0
8010679e:	6a 00                	push   $0x0
  pushl $91
801067a0:	6a 5b                	push   $0x5b
  jmp alltraps
801067a2:	e9 26 f8 ff ff       	jmp    80105fcd <alltraps>

801067a7 <vector92>:
.globl vector92
vector92:
  pushl $0
801067a7:	6a 00                	push   $0x0
  pushl $92
801067a9:	6a 5c                	push   $0x5c
  jmp alltraps
801067ab:	e9 1d f8 ff ff       	jmp    80105fcd <alltraps>

801067b0 <vector93>:
.globl vector93
vector93:
  pushl $0
801067b0:	6a 00                	push   $0x0
  pushl $93
801067b2:	6a 5d                	push   $0x5d
  jmp alltraps
801067b4:	e9 14 f8 ff ff       	jmp    80105fcd <alltraps>

801067b9 <vector94>:
.globl vector94
vector94:
  pushl $0
801067b9:	6a 00                	push   $0x0
  pushl $94
801067bb:	6a 5e                	push   $0x5e
  jmp alltraps
801067bd:	e9 0b f8 ff ff       	jmp    80105fcd <alltraps>

801067c2 <vector95>:
.globl vector95
vector95:
  pushl $0
801067c2:	6a 00                	push   $0x0
  pushl $95
801067c4:	6a 5f                	push   $0x5f
  jmp alltraps
801067c6:	e9 02 f8 ff ff       	jmp    80105fcd <alltraps>

801067cb <vector96>:
.globl vector96
vector96:
  pushl $0
801067cb:	6a 00                	push   $0x0
  pushl $96
801067cd:	6a 60                	push   $0x60
  jmp alltraps
801067cf:	e9 f9 f7 ff ff       	jmp    80105fcd <alltraps>

801067d4 <vector97>:
.globl vector97
vector97:
  pushl $0
801067d4:	6a 00                	push   $0x0
  pushl $97
801067d6:	6a 61                	push   $0x61
  jmp alltraps
801067d8:	e9 f0 f7 ff ff       	jmp    80105fcd <alltraps>

801067dd <vector98>:
.globl vector98
vector98:
  pushl $0
801067dd:	6a 00                	push   $0x0
  pushl $98
801067df:	6a 62                	push   $0x62
  jmp alltraps
801067e1:	e9 e7 f7 ff ff       	jmp    80105fcd <alltraps>

801067e6 <vector99>:
.globl vector99
vector99:
  pushl $0
801067e6:	6a 00                	push   $0x0
  pushl $99
801067e8:	6a 63                	push   $0x63
  jmp alltraps
801067ea:	e9 de f7 ff ff       	jmp    80105fcd <alltraps>

801067ef <vector100>:
.globl vector100
vector100:
  pushl $0
801067ef:	6a 00                	push   $0x0
  pushl $100
801067f1:	6a 64                	push   $0x64
  jmp alltraps
801067f3:	e9 d5 f7 ff ff       	jmp    80105fcd <alltraps>

801067f8 <vector101>:
.globl vector101
vector101:
  pushl $0
801067f8:	6a 00                	push   $0x0
  pushl $101
801067fa:	6a 65                	push   $0x65
  jmp alltraps
801067fc:	e9 cc f7 ff ff       	jmp    80105fcd <alltraps>

80106801 <vector102>:
.globl vector102
vector102:
  pushl $0
80106801:	6a 00                	push   $0x0
  pushl $102
80106803:	6a 66                	push   $0x66
  jmp alltraps
80106805:	e9 c3 f7 ff ff       	jmp    80105fcd <alltraps>

8010680a <vector103>:
.globl vector103
vector103:
  pushl $0
8010680a:	6a 00                	push   $0x0
  pushl $103
8010680c:	6a 67                	push   $0x67
  jmp alltraps
8010680e:	e9 ba f7 ff ff       	jmp    80105fcd <alltraps>

80106813 <vector104>:
.globl vector104
vector104:
  pushl $0
80106813:	6a 00                	push   $0x0
  pushl $104
80106815:	6a 68                	push   $0x68
  jmp alltraps
80106817:	e9 b1 f7 ff ff       	jmp    80105fcd <alltraps>

8010681c <vector105>:
.globl vector105
vector105:
  pushl $0
8010681c:	6a 00                	push   $0x0
  pushl $105
8010681e:	6a 69                	push   $0x69
  jmp alltraps
80106820:	e9 a8 f7 ff ff       	jmp    80105fcd <alltraps>

80106825 <vector106>:
.globl vector106
vector106:
  pushl $0
80106825:	6a 00                	push   $0x0
  pushl $106
80106827:	6a 6a                	push   $0x6a
  jmp alltraps
80106829:	e9 9f f7 ff ff       	jmp    80105fcd <alltraps>

8010682e <vector107>:
.globl vector107
vector107:
  pushl $0
8010682e:	6a 00                	push   $0x0
  pushl $107
80106830:	6a 6b                	push   $0x6b
  jmp alltraps
80106832:	e9 96 f7 ff ff       	jmp    80105fcd <alltraps>

80106837 <vector108>:
.globl vector108
vector108:
  pushl $0
80106837:	6a 00                	push   $0x0
  pushl $108
80106839:	6a 6c                	push   $0x6c
  jmp alltraps
8010683b:	e9 8d f7 ff ff       	jmp    80105fcd <alltraps>

80106840 <vector109>:
.globl vector109
vector109:
  pushl $0
80106840:	6a 00                	push   $0x0
  pushl $109
80106842:	6a 6d                	push   $0x6d
  jmp alltraps
80106844:	e9 84 f7 ff ff       	jmp    80105fcd <alltraps>

80106849 <vector110>:
.globl vector110
vector110:
  pushl $0
80106849:	6a 00                	push   $0x0
  pushl $110
8010684b:	6a 6e                	push   $0x6e
  jmp alltraps
8010684d:	e9 7b f7 ff ff       	jmp    80105fcd <alltraps>

80106852 <vector111>:
.globl vector111
vector111:
  pushl $0
80106852:	6a 00                	push   $0x0
  pushl $111
80106854:	6a 6f                	push   $0x6f
  jmp alltraps
80106856:	e9 72 f7 ff ff       	jmp    80105fcd <alltraps>

8010685b <vector112>:
.globl vector112
vector112:
  pushl $0
8010685b:	6a 00                	push   $0x0
  pushl $112
8010685d:	6a 70                	push   $0x70
  jmp alltraps
8010685f:	e9 69 f7 ff ff       	jmp    80105fcd <alltraps>

80106864 <vector113>:
.globl vector113
vector113:
  pushl $0
80106864:	6a 00                	push   $0x0
  pushl $113
80106866:	6a 71                	push   $0x71
  jmp alltraps
80106868:	e9 60 f7 ff ff       	jmp    80105fcd <alltraps>

8010686d <vector114>:
.globl vector114
vector114:
  pushl $0
8010686d:	6a 00                	push   $0x0
  pushl $114
8010686f:	6a 72                	push   $0x72
  jmp alltraps
80106871:	e9 57 f7 ff ff       	jmp    80105fcd <alltraps>

80106876 <vector115>:
.globl vector115
vector115:
  pushl $0
80106876:	6a 00                	push   $0x0
  pushl $115
80106878:	6a 73                	push   $0x73
  jmp alltraps
8010687a:	e9 4e f7 ff ff       	jmp    80105fcd <alltraps>

8010687f <vector116>:
.globl vector116
vector116:
  pushl $0
8010687f:	6a 00                	push   $0x0
  pushl $116
80106881:	6a 74                	push   $0x74
  jmp alltraps
80106883:	e9 45 f7 ff ff       	jmp    80105fcd <alltraps>

80106888 <vector117>:
.globl vector117
vector117:
  pushl $0
80106888:	6a 00                	push   $0x0
  pushl $117
8010688a:	6a 75                	push   $0x75
  jmp alltraps
8010688c:	e9 3c f7 ff ff       	jmp    80105fcd <alltraps>

80106891 <vector118>:
.globl vector118
vector118:
  pushl $0
80106891:	6a 00                	push   $0x0
  pushl $118
80106893:	6a 76                	push   $0x76
  jmp alltraps
80106895:	e9 33 f7 ff ff       	jmp    80105fcd <alltraps>

8010689a <vector119>:
.globl vector119
vector119:
  pushl $0
8010689a:	6a 00                	push   $0x0
  pushl $119
8010689c:	6a 77                	push   $0x77
  jmp alltraps
8010689e:	e9 2a f7 ff ff       	jmp    80105fcd <alltraps>

801068a3 <vector120>:
.globl vector120
vector120:
  pushl $0
801068a3:	6a 00                	push   $0x0
  pushl $120
801068a5:	6a 78                	push   $0x78
  jmp alltraps
801068a7:	e9 21 f7 ff ff       	jmp    80105fcd <alltraps>

801068ac <vector121>:
.globl vector121
vector121:
  pushl $0
801068ac:	6a 00                	push   $0x0
  pushl $121
801068ae:	6a 79                	push   $0x79
  jmp alltraps
801068b0:	e9 18 f7 ff ff       	jmp    80105fcd <alltraps>

801068b5 <vector122>:
.globl vector122
vector122:
  pushl $0
801068b5:	6a 00                	push   $0x0
  pushl $122
801068b7:	6a 7a                	push   $0x7a
  jmp alltraps
801068b9:	e9 0f f7 ff ff       	jmp    80105fcd <alltraps>

801068be <vector123>:
.globl vector123
vector123:
  pushl $0
801068be:	6a 00                	push   $0x0
  pushl $123
801068c0:	6a 7b                	push   $0x7b
  jmp alltraps
801068c2:	e9 06 f7 ff ff       	jmp    80105fcd <alltraps>

801068c7 <vector124>:
.globl vector124
vector124:
  pushl $0
801068c7:	6a 00                	push   $0x0
  pushl $124
801068c9:	6a 7c                	push   $0x7c
  jmp alltraps
801068cb:	e9 fd f6 ff ff       	jmp    80105fcd <alltraps>

801068d0 <vector125>:
.globl vector125
vector125:
  pushl $0
801068d0:	6a 00                	push   $0x0
  pushl $125
801068d2:	6a 7d                	push   $0x7d
  jmp alltraps
801068d4:	e9 f4 f6 ff ff       	jmp    80105fcd <alltraps>

801068d9 <vector126>:
.globl vector126
vector126:
  pushl $0
801068d9:	6a 00                	push   $0x0
  pushl $126
801068db:	6a 7e                	push   $0x7e
  jmp alltraps
801068dd:	e9 eb f6 ff ff       	jmp    80105fcd <alltraps>

801068e2 <vector127>:
.globl vector127
vector127:
  pushl $0
801068e2:	6a 00                	push   $0x0
  pushl $127
801068e4:	6a 7f                	push   $0x7f
  jmp alltraps
801068e6:	e9 e2 f6 ff ff       	jmp    80105fcd <alltraps>

801068eb <vector128>:
.globl vector128
vector128:
  pushl $0
801068eb:	6a 00                	push   $0x0
  pushl $128
801068ed:	68 80 00 00 00       	push   $0x80
  jmp alltraps
801068f2:	e9 d6 f6 ff ff       	jmp    80105fcd <alltraps>

801068f7 <vector129>:
.globl vector129
vector129:
  pushl $0
801068f7:	6a 00                	push   $0x0
  pushl $129
801068f9:	68 81 00 00 00       	push   $0x81
  jmp alltraps
801068fe:	e9 ca f6 ff ff       	jmp    80105fcd <alltraps>

80106903 <vector130>:
.globl vector130
vector130:
  pushl $0
80106903:	6a 00                	push   $0x0
  pushl $130
80106905:	68 82 00 00 00       	push   $0x82
  jmp alltraps
8010690a:	e9 be f6 ff ff       	jmp    80105fcd <alltraps>

8010690f <vector131>:
.globl vector131
vector131:
  pushl $0
8010690f:	6a 00                	push   $0x0
  pushl $131
80106911:	68 83 00 00 00       	push   $0x83
  jmp alltraps
80106916:	e9 b2 f6 ff ff       	jmp    80105fcd <alltraps>

8010691b <vector132>:
.globl vector132
vector132:
  pushl $0
8010691b:	6a 00                	push   $0x0
  pushl $132
8010691d:	68 84 00 00 00       	push   $0x84
  jmp alltraps
80106922:	e9 a6 f6 ff ff       	jmp    80105fcd <alltraps>

80106927 <vector133>:
.globl vector133
vector133:
  pushl $0
80106927:	6a 00                	push   $0x0
  pushl $133
80106929:	68 85 00 00 00       	push   $0x85
  jmp alltraps
8010692e:	e9 9a f6 ff ff       	jmp    80105fcd <alltraps>

80106933 <vector134>:
.globl vector134
vector134:
  pushl $0
80106933:	6a 00                	push   $0x0
  pushl $134
80106935:	68 86 00 00 00       	push   $0x86
  jmp alltraps
8010693a:	e9 8e f6 ff ff       	jmp    80105fcd <alltraps>

8010693f <vector135>:
.globl vector135
vector135:
  pushl $0
8010693f:	6a 00                	push   $0x0
  pushl $135
80106941:	68 87 00 00 00       	push   $0x87
  jmp alltraps
80106946:	e9 82 f6 ff ff       	jmp    80105fcd <alltraps>

8010694b <vector136>:
.globl vector136
vector136:
  pushl $0
8010694b:	6a 00                	push   $0x0
  pushl $136
8010694d:	68 88 00 00 00       	push   $0x88
  jmp alltraps
80106952:	e9 76 f6 ff ff       	jmp    80105fcd <alltraps>

80106957 <vector137>:
.globl vector137
vector137:
  pushl $0
80106957:	6a 00                	push   $0x0
  pushl $137
80106959:	68 89 00 00 00       	push   $0x89
  jmp alltraps
8010695e:	e9 6a f6 ff ff       	jmp    80105fcd <alltraps>

80106963 <vector138>:
.globl vector138
vector138:
  pushl $0
80106963:	6a 00                	push   $0x0
  pushl $138
80106965:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
8010696a:	e9 5e f6 ff ff       	jmp    80105fcd <alltraps>

8010696f <vector139>:
.globl vector139
vector139:
  pushl $0
8010696f:	6a 00                	push   $0x0
  pushl $139
80106971:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
80106976:	e9 52 f6 ff ff       	jmp    80105fcd <alltraps>

8010697b <vector140>:
.globl vector140
vector140:
  pushl $0
8010697b:	6a 00                	push   $0x0
  pushl $140
8010697d:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
80106982:	e9 46 f6 ff ff       	jmp    80105fcd <alltraps>

80106987 <vector141>:
.globl vector141
vector141:
  pushl $0
80106987:	6a 00                	push   $0x0
  pushl $141
80106989:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
8010698e:	e9 3a f6 ff ff       	jmp    80105fcd <alltraps>

80106993 <vector142>:
.globl vector142
vector142:
  pushl $0
80106993:	6a 00                	push   $0x0
  pushl $142
80106995:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
8010699a:	e9 2e f6 ff ff       	jmp    80105fcd <alltraps>

8010699f <vector143>:
.globl vector143
vector143:
  pushl $0
8010699f:	6a 00                	push   $0x0
  pushl $143
801069a1:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
801069a6:	e9 22 f6 ff ff       	jmp    80105fcd <alltraps>

801069ab <vector144>:
.globl vector144
vector144:
  pushl $0
801069ab:	6a 00                	push   $0x0
  pushl $144
801069ad:	68 90 00 00 00       	push   $0x90
  jmp alltraps
801069b2:	e9 16 f6 ff ff       	jmp    80105fcd <alltraps>

801069b7 <vector145>:
.globl vector145
vector145:
  pushl $0
801069b7:	6a 00                	push   $0x0
  pushl $145
801069b9:	68 91 00 00 00       	push   $0x91
  jmp alltraps
801069be:	e9 0a f6 ff ff       	jmp    80105fcd <alltraps>

801069c3 <vector146>:
.globl vector146
vector146:
  pushl $0
801069c3:	6a 00                	push   $0x0
  pushl $146
801069c5:	68 92 00 00 00       	push   $0x92
  jmp alltraps
801069ca:	e9 fe f5 ff ff       	jmp    80105fcd <alltraps>

801069cf <vector147>:
.globl vector147
vector147:
  pushl $0
801069cf:	6a 00                	push   $0x0
  pushl $147
801069d1:	68 93 00 00 00       	push   $0x93
  jmp alltraps
801069d6:	e9 f2 f5 ff ff       	jmp    80105fcd <alltraps>

801069db <vector148>:
.globl vector148
vector148:
  pushl $0
801069db:	6a 00                	push   $0x0
  pushl $148
801069dd:	68 94 00 00 00       	push   $0x94
  jmp alltraps
801069e2:	e9 e6 f5 ff ff       	jmp    80105fcd <alltraps>

801069e7 <vector149>:
.globl vector149
vector149:
  pushl $0
801069e7:	6a 00                	push   $0x0
  pushl $149
801069e9:	68 95 00 00 00       	push   $0x95
  jmp alltraps
801069ee:	e9 da f5 ff ff       	jmp    80105fcd <alltraps>

801069f3 <vector150>:
.globl vector150
vector150:
  pushl $0
801069f3:	6a 00                	push   $0x0
  pushl $150
801069f5:	68 96 00 00 00       	push   $0x96
  jmp alltraps
801069fa:	e9 ce f5 ff ff       	jmp    80105fcd <alltraps>

801069ff <vector151>:
.globl vector151
vector151:
  pushl $0
801069ff:	6a 00                	push   $0x0
  pushl $151
80106a01:	68 97 00 00 00       	push   $0x97
  jmp alltraps
80106a06:	e9 c2 f5 ff ff       	jmp    80105fcd <alltraps>

80106a0b <vector152>:
.globl vector152
vector152:
  pushl $0
80106a0b:	6a 00                	push   $0x0
  pushl $152
80106a0d:	68 98 00 00 00       	push   $0x98
  jmp alltraps
80106a12:	e9 b6 f5 ff ff       	jmp    80105fcd <alltraps>

80106a17 <vector153>:
.globl vector153
vector153:
  pushl $0
80106a17:	6a 00                	push   $0x0
  pushl $153
80106a19:	68 99 00 00 00       	push   $0x99
  jmp alltraps
80106a1e:	e9 aa f5 ff ff       	jmp    80105fcd <alltraps>

80106a23 <vector154>:
.globl vector154
vector154:
  pushl $0
80106a23:	6a 00                	push   $0x0
  pushl $154
80106a25:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
80106a2a:	e9 9e f5 ff ff       	jmp    80105fcd <alltraps>

80106a2f <vector155>:
.globl vector155
vector155:
  pushl $0
80106a2f:	6a 00                	push   $0x0
  pushl $155
80106a31:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
80106a36:	e9 92 f5 ff ff       	jmp    80105fcd <alltraps>

80106a3b <vector156>:
.globl vector156
vector156:
  pushl $0
80106a3b:	6a 00                	push   $0x0
  pushl $156
80106a3d:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
80106a42:	e9 86 f5 ff ff       	jmp    80105fcd <alltraps>

80106a47 <vector157>:
.globl vector157
vector157:
  pushl $0
80106a47:	6a 00                	push   $0x0
  pushl $157
80106a49:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
80106a4e:	e9 7a f5 ff ff       	jmp    80105fcd <alltraps>

80106a53 <vector158>:
.globl vector158
vector158:
  pushl $0
80106a53:	6a 00                	push   $0x0
  pushl $158
80106a55:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
80106a5a:	e9 6e f5 ff ff       	jmp    80105fcd <alltraps>

80106a5f <vector159>:
.globl vector159
vector159:
  pushl $0
80106a5f:	6a 00                	push   $0x0
  pushl $159
80106a61:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
80106a66:	e9 62 f5 ff ff       	jmp    80105fcd <alltraps>

80106a6b <vector160>:
.globl vector160
vector160:
  pushl $0
80106a6b:	6a 00                	push   $0x0
  pushl $160
80106a6d:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
80106a72:	e9 56 f5 ff ff       	jmp    80105fcd <alltraps>

80106a77 <vector161>:
.globl vector161
vector161:
  pushl $0
80106a77:	6a 00                	push   $0x0
  pushl $161
80106a79:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
80106a7e:	e9 4a f5 ff ff       	jmp    80105fcd <alltraps>

80106a83 <vector162>:
.globl vector162
vector162:
  pushl $0
80106a83:	6a 00                	push   $0x0
  pushl $162
80106a85:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
80106a8a:	e9 3e f5 ff ff       	jmp    80105fcd <alltraps>

80106a8f <vector163>:
.globl vector163
vector163:
  pushl $0
80106a8f:	6a 00                	push   $0x0
  pushl $163
80106a91:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
80106a96:	e9 32 f5 ff ff       	jmp    80105fcd <alltraps>

80106a9b <vector164>:
.globl vector164
vector164:
  pushl $0
80106a9b:	6a 00                	push   $0x0
  pushl $164
80106a9d:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
80106aa2:	e9 26 f5 ff ff       	jmp    80105fcd <alltraps>

80106aa7 <vector165>:
.globl vector165
vector165:
  pushl $0
80106aa7:	6a 00                	push   $0x0
  pushl $165
80106aa9:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
80106aae:	e9 1a f5 ff ff       	jmp    80105fcd <alltraps>

80106ab3 <vector166>:
.globl vector166
vector166:
  pushl $0
80106ab3:	6a 00                	push   $0x0
  pushl $166
80106ab5:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
80106aba:	e9 0e f5 ff ff       	jmp    80105fcd <alltraps>

80106abf <vector167>:
.globl vector167
vector167:
  pushl $0
80106abf:	6a 00                	push   $0x0
  pushl $167
80106ac1:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
80106ac6:	e9 02 f5 ff ff       	jmp    80105fcd <alltraps>

80106acb <vector168>:
.globl vector168
vector168:
  pushl $0
80106acb:	6a 00                	push   $0x0
  pushl $168
80106acd:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
80106ad2:	e9 f6 f4 ff ff       	jmp    80105fcd <alltraps>

80106ad7 <vector169>:
.globl vector169
vector169:
  pushl $0
80106ad7:	6a 00                	push   $0x0
  pushl $169
80106ad9:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
80106ade:	e9 ea f4 ff ff       	jmp    80105fcd <alltraps>

80106ae3 <vector170>:
.globl vector170
vector170:
  pushl $0
80106ae3:	6a 00                	push   $0x0
  pushl $170
80106ae5:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
80106aea:	e9 de f4 ff ff       	jmp    80105fcd <alltraps>

80106aef <vector171>:
.globl vector171
vector171:
  pushl $0
80106aef:	6a 00                	push   $0x0
  pushl $171
80106af1:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
80106af6:	e9 d2 f4 ff ff       	jmp    80105fcd <alltraps>

80106afb <vector172>:
.globl vector172
vector172:
  pushl $0
80106afb:	6a 00                	push   $0x0
  pushl $172
80106afd:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
80106b02:	e9 c6 f4 ff ff       	jmp    80105fcd <alltraps>

80106b07 <vector173>:
.globl vector173
vector173:
  pushl $0
80106b07:	6a 00                	push   $0x0
  pushl $173
80106b09:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
80106b0e:	e9 ba f4 ff ff       	jmp    80105fcd <alltraps>

80106b13 <vector174>:
.globl vector174
vector174:
  pushl $0
80106b13:	6a 00                	push   $0x0
  pushl $174
80106b15:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
80106b1a:	e9 ae f4 ff ff       	jmp    80105fcd <alltraps>

80106b1f <vector175>:
.globl vector175
vector175:
  pushl $0
80106b1f:	6a 00                	push   $0x0
  pushl $175
80106b21:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
80106b26:	e9 a2 f4 ff ff       	jmp    80105fcd <alltraps>

80106b2b <vector176>:
.globl vector176
vector176:
  pushl $0
80106b2b:	6a 00                	push   $0x0
  pushl $176
80106b2d:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
80106b32:	e9 96 f4 ff ff       	jmp    80105fcd <alltraps>

80106b37 <vector177>:
.globl vector177
vector177:
  pushl $0
80106b37:	6a 00                	push   $0x0
  pushl $177
80106b39:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
80106b3e:	e9 8a f4 ff ff       	jmp    80105fcd <alltraps>

80106b43 <vector178>:
.globl vector178
vector178:
  pushl $0
80106b43:	6a 00                	push   $0x0
  pushl $178
80106b45:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
80106b4a:	e9 7e f4 ff ff       	jmp    80105fcd <alltraps>

80106b4f <vector179>:
.globl vector179
vector179:
  pushl $0
80106b4f:	6a 00                	push   $0x0
  pushl $179
80106b51:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
80106b56:	e9 72 f4 ff ff       	jmp    80105fcd <alltraps>

80106b5b <vector180>:
.globl vector180
vector180:
  pushl $0
80106b5b:	6a 00                	push   $0x0
  pushl $180
80106b5d:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
80106b62:	e9 66 f4 ff ff       	jmp    80105fcd <alltraps>

80106b67 <vector181>:
.globl vector181
vector181:
  pushl $0
80106b67:	6a 00                	push   $0x0
  pushl $181
80106b69:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
80106b6e:	e9 5a f4 ff ff       	jmp    80105fcd <alltraps>

80106b73 <vector182>:
.globl vector182
vector182:
  pushl $0
80106b73:	6a 00                	push   $0x0
  pushl $182
80106b75:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
80106b7a:	e9 4e f4 ff ff       	jmp    80105fcd <alltraps>

80106b7f <vector183>:
.globl vector183
vector183:
  pushl $0
80106b7f:	6a 00                	push   $0x0
  pushl $183
80106b81:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
80106b86:	e9 42 f4 ff ff       	jmp    80105fcd <alltraps>

80106b8b <vector184>:
.globl vector184
vector184:
  pushl $0
80106b8b:	6a 00                	push   $0x0
  pushl $184
80106b8d:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
80106b92:	e9 36 f4 ff ff       	jmp    80105fcd <alltraps>

80106b97 <vector185>:
.globl vector185
vector185:
  pushl $0
80106b97:	6a 00                	push   $0x0
  pushl $185
80106b99:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
80106b9e:	e9 2a f4 ff ff       	jmp    80105fcd <alltraps>

80106ba3 <vector186>:
.globl vector186
vector186:
  pushl $0
80106ba3:	6a 00                	push   $0x0
  pushl $186
80106ba5:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
80106baa:	e9 1e f4 ff ff       	jmp    80105fcd <alltraps>

80106baf <vector187>:
.globl vector187
vector187:
  pushl $0
80106baf:	6a 00                	push   $0x0
  pushl $187
80106bb1:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
80106bb6:	e9 12 f4 ff ff       	jmp    80105fcd <alltraps>

80106bbb <vector188>:
.globl vector188
vector188:
  pushl $0
80106bbb:	6a 00                	push   $0x0
  pushl $188
80106bbd:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
80106bc2:	e9 06 f4 ff ff       	jmp    80105fcd <alltraps>

80106bc7 <vector189>:
.globl vector189
vector189:
  pushl $0
80106bc7:	6a 00                	push   $0x0
  pushl $189
80106bc9:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
80106bce:	e9 fa f3 ff ff       	jmp    80105fcd <alltraps>

80106bd3 <vector190>:
.globl vector190
vector190:
  pushl $0
80106bd3:	6a 00                	push   $0x0
  pushl $190
80106bd5:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
80106bda:	e9 ee f3 ff ff       	jmp    80105fcd <alltraps>

80106bdf <vector191>:
.globl vector191
vector191:
  pushl $0
80106bdf:	6a 00                	push   $0x0
  pushl $191
80106be1:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
80106be6:	e9 e2 f3 ff ff       	jmp    80105fcd <alltraps>

80106beb <vector192>:
.globl vector192
vector192:
  pushl $0
80106beb:	6a 00                	push   $0x0
  pushl $192
80106bed:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
80106bf2:	e9 d6 f3 ff ff       	jmp    80105fcd <alltraps>

80106bf7 <vector193>:
.globl vector193
vector193:
  pushl $0
80106bf7:	6a 00                	push   $0x0
  pushl $193
80106bf9:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
80106bfe:	e9 ca f3 ff ff       	jmp    80105fcd <alltraps>

80106c03 <vector194>:
.globl vector194
vector194:
  pushl $0
80106c03:	6a 00                	push   $0x0
  pushl $194
80106c05:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
80106c0a:	e9 be f3 ff ff       	jmp    80105fcd <alltraps>

80106c0f <vector195>:
.globl vector195
vector195:
  pushl $0
80106c0f:	6a 00                	push   $0x0
  pushl $195
80106c11:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
80106c16:	e9 b2 f3 ff ff       	jmp    80105fcd <alltraps>

80106c1b <vector196>:
.globl vector196
vector196:
  pushl $0
80106c1b:	6a 00                	push   $0x0
  pushl $196
80106c1d:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
80106c22:	e9 a6 f3 ff ff       	jmp    80105fcd <alltraps>

80106c27 <vector197>:
.globl vector197
vector197:
  pushl $0
80106c27:	6a 00                	push   $0x0
  pushl $197
80106c29:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
80106c2e:	e9 9a f3 ff ff       	jmp    80105fcd <alltraps>

80106c33 <vector198>:
.globl vector198
vector198:
  pushl $0
80106c33:	6a 00                	push   $0x0
  pushl $198
80106c35:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
80106c3a:	e9 8e f3 ff ff       	jmp    80105fcd <alltraps>

80106c3f <vector199>:
.globl vector199
vector199:
  pushl $0
80106c3f:	6a 00                	push   $0x0
  pushl $199
80106c41:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
80106c46:	e9 82 f3 ff ff       	jmp    80105fcd <alltraps>

80106c4b <vector200>:
.globl vector200
vector200:
  pushl $0
80106c4b:	6a 00                	push   $0x0
  pushl $200
80106c4d:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
80106c52:	e9 76 f3 ff ff       	jmp    80105fcd <alltraps>

80106c57 <vector201>:
.globl vector201
vector201:
  pushl $0
80106c57:	6a 00                	push   $0x0
  pushl $201
80106c59:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
80106c5e:	e9 6a f3 ff ff       	jmp    80105fcd <alltraps>

80106c63 <vector202>:
.globl vector202
vector202:
  pushl $0
80106c63:	6a 00                	push   $0x0
  pushl $202
80106c65:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
80106c6a:	e9 5e f3 ff ff       	jmp    80105fcd <alltraps>

80106c6f <vector203>:
.globl vector203
vector203:
  pushl $0
80106c6f:	6a 00                	push   $0x0
  pushl $203
80106c71:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
80106c76:	e9 52 f3 ff ff       	jmp    80105fcd <alltraps>

80106c7b <vector204>:
.globl vector204
vector204:
  pushl $0
80106c7b:	6a 00                	push   $0x0
  pushl $204
80106c7d:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
80106c82:	e9 46 f3 ff ff       	jmp    80105fcd <alltraps>

80106c87 <vector205>:
.globl vector205
vector205:
  pushl $0
80106c87:	6a 00                	push   $0x0
  pushl $205
80106c89:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
80106c8e:	e9 3a f3 ff ff       	jmp    80105fcd <alltraps>

80106c93 <vector206>:
.globl vector206
vector206:
  pushl $0
80106c93:	6a 00                	push   $0x0
  pushl $206
80106c95:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
80106c9a:	e9 2e f3 ff ff       	jmp    80105fcd <alltraps>

80106c9f <vector207>:
.globl vector207
vector207:
  pushl $0
80106c9f:	6a 00                	push   $0x0
  pushl $207
80106ca1:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
80106ca6:	e9 22 f3 ff ff       	jmp    80105fcd <alltraps>

80106cab <vector208>:
.globl vector208
vector208:
  pushl $0
80106cab:	6a 00                	push   $0x0
  pushl $208
80106cad:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
80106cb2:	e9 16 f3 ff ff       	jmp    80105fcd <alltraps>

80106cb7 <vector209>:
.globl vector209
vector209:
  pushl $0
80106cb7:	6a 00                	push   $0x0
  pushl $209
80106cb9:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
80106cbe:	e9 0a f3 ff ff       	jmp    80105fcd <alltraps>

80106cc3 <vector210>:
.globl vector210
vector210:
  pushl $0
80106cc3:	6a 00                	push   $0x0
  pushl $210
80106cc5:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80106cca:	e9 fe f2 ff ff       	jmp    80105fcd <alltraps>

80106ccf <vector211>:
.globl vector211
vector211:
  pushl $0
80106ccf:	6a 00                	push   $0x0
  pushl $211
80106cd1:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80106cd6:	e9 f2 f2 ff ff       	jmp    80105fcd <alltraps>

80106cdb <vector212>:
.globl vector212
vector212:
  pushl $0
80106cdb:	6a 00                	push   $0x0
  pushl $212
80106cdd:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
80106ce2:	e9 e6 f2 ff ff       	jmp    80105fcd <alltraps>

80106ce7 <vector213>:
.globl vector213
vector213:
  pushl $0
80106ce7:	6a 00                	push   $0x0
  pushl $213
80106ce9:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
80106cee:	e9 da f2 ff ff       	jmp    80105fcd <alltraps>

80106cf3 <vector214>:
.globl vector214
vector214:
  pushl $0
80106cf3:	6a 00                	push   $0x0
  pushl $214
80106cf5:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80106cfa:	e9 ce f2 ff ff       	jmp    80105fcd <alltraps>

80106cff <vector215>:
.globl vector215
vector215:
  pushl $0
80106cff:	6a 00                	push   $0x0
  pushl $215
80106d01:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80106d06:	e9 c2 f2 ff ff       	jmp    80105fcd <alltraps>

80106d0b <vector216>:
.globl vector216
vector216:
  pushl $0
80106d0b:	6a 00                	push   $0x0
  pushl $216
80106d0d:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
80106d12:	e9 b6 f2 ff ff       	jmp    80105fcd <alltraps>

80106d17 <vector217>:
.globl vector217
vector217:
  pushl $0
80106d17:	6a 00                	push   $0x0
  pushl $217
80106d19:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
80106d1e:	e9 aa f2 ff ff       	jmp    80105fcd <alltraps>

80106d23 <vector218>:
.globl vector218
vector218:
  pushl $0
80106d23:	6a 00                	push   $0x0
  pushl $218
80106d25:	68 da 00 00 00       	push   $0xda
  jmp alltraps
80106d2a:	e9 9e f2 ff ff       	jmp    80105fcd <alltraps>

80106d2f <vector219>:
.globl vector219
vector219:
  pushl $0
80106d2f:	6a 00                	push   $0x0
  pushl $219
80106d31:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
80106d36:	e9 92 f2 ff ff       	jmp    80105fcd <alltraps>

80106d3b <vector220>:
.globl vector220
vector220:
  pushl $0
80106d3b:	6a 00                	push   $0x0
  pushl $220
80106d3d:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
80106d42:	e9 86 f2 ff ff       	jmp    80105fcd <alltraps>

80106d47 <vector221>:
.globl vector221
vector221:
  pushl $0
80106d47:	6a 00                	push   $0x0
  pushl $221
80106d49:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
80106d4e:	e9 7a f2 ff ff       	jmp    80105fcd <alltraps>

80106d53 <vector222>:
.globl vector222
vector222:
  pushl $0
80106d53:	6a 00                	push   $0x0
  pushl $222
80106d55:	68 de 00 00 00       	push   $0xde
  jmp alltraps
80106d5a:	e9 6e f2 ff ff       	jmp    80105fcd <alltraps>

80106d5f <vector223>:
.globl vector223
vector223:
  pushl $0
80106d5f:	6a 00                	push   $0x0
  pushl $223
80106d61:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
80106d66:	e9 62 f2 ff ff       	jmp    80105fcd <alltraps>

80106d6b <vector224>:
.globl vector224
vector224:
  pushl $0
80106d6b:	6a 00                	push   $0x0
  pushl $224
80106d6d:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
80106d72:	e9 56 f2 ff ff       	jmp    80105fcd <alltraps>

80106d77 <vector225>:
.globl vector225
vector225:
  pushl $0
80106d77:	6a 00                	push   $0x0
  pushl $225
80106d79:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
80106d7e:	e9 4a f2 ff ff       	jmp    80105fcd <alltraps>

80106d83 <vector226>:
.globl vector226
vector226:
  pushl $0
80106d83:	6a 00                	push   $0x0
  pushl $226
80106d85:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
80106d8a:	e9 3e f2 ff ff       	jmp    80105fcd <alltraps>

80106d8f <vector227>:
.globl vector227
vector227:
  pushl $0
80106d8f:	6a 00                	push   $0x0
  pushl $227
80106d91:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
80106d96:	e9 32 f2 ff ff       	jmp    80105fcd <alltraps>

80106d9b <vector228>:
.globl vector228
vector228:
  pushl $0
80106d9b:	6a 00                	push   $0x0
  pushl $228
80106d9d:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
80106da2:	e9 26 f2 ff ff       	jmp    80105fcd <alltraps>

80106da7 <vector229>:
.globl vector229
vector229:
  pushl $0
80106da7:	6a 00                	push   $0x0
  pushl $229
80106da9:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
80106dae:	e9 1a f2 ff ff       	jmp    80105fcd <alltraps>

80106db3 <vector230>:
.globl vector230
vector230:
  pushl $0
80106db3:	6a 00                	push   $0x0
  pushl $230
80106db5:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80106dba:	e9 0e f2 ff ff       	jmp    80105fcd <alltraps>

80106dbf <vector231>:
.globl vector231
vector231:
  pushl $0
80106dbf:	6a 00                	push   $0x0
  pushl $231
80106dc1:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80106dc6:	e9 02 f2 ff ff       	jmp    80105fcd <alltraps>

80106dcb <vector232>:
.globl vector232
vector232:
  pushl $0
80106dcb:	6a 00                	push   $0x0
  pushl $232
80106dcd:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
80106dd2:	e9 f6 f1 ff ff       	jmp    80105fcd <alltraps>

80106dd7 <vector233>:
.globl vector233
vector233:
  pushl $0
80106dd7:	6a 00                	push   $0x0
  pushl $233
80106dd9:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
80106dde:	e9 ea f1 ff ff       	jmp    80105fcd <alltraps>

80106de3 <vector234>:
.globl vector234
vector234:
  pushl $0
80106de3:	6a 00                	push   $0x0
  pushl $234
80106de5:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80106dea:	e9 de f1 ff ff       	jmp    80105fcd <alltraps>

80106def <vector235>:
.globl vector235
vector235:
  pushl $0
80106def:	6a 00                	push   $0x0
  pushl $235
80106df1:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80106df6:	e9 d2 f1 ff ff       	jmp    80105fcd <alltraps>

80106dfb <vector236>:
.globl vector236
vector236:
  pushl $0
80106dfb:	6a 00                	push   $0x0
  pushl $236
80106dfd:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
80106e02:	e9 c6 f1 ff ff       	jmp    80105fcd <alltraps>

80106e07 <vector237>:
.globl vector237
vector237:
  pushl $0
80106e07:	6a 00                	push   $0x0
  pushl $237
80106e09:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
80106e0e:	e9 ba f1 ff ff       	jmp    80105fcd <alltraps>

80106e13 <vector238>:
.globl vector238
vector238:
  pushl $0
80106e13:	6a 00                	push   $0x0
  pushl $238
80106e15:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
80106e1a:	e9 ae f1 ff ff       	jmp    80105fcd <alltraps>

80106e1f <vector239>:
.globl vector239
vector239:
  pushl $0
80106e1f:	6a 00                	push   $0x0
  pushl $239
80106e21:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
80106e26:	e9 a2 f1 ff ff       	jmp    80105fcd <alltraps>

80106e2b <vector240>:
.globl vector240
vector240:
  pushl $0
80106e2b:	6a 00                	push   $0x0
  pushl $240
80106e2d:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
80106e32:	e9 96 f1 ff ff       	jmp    80105fcd <alltraps>

80106e37 <vector241>:
.globl vector241
vector241:
  pushl $0
80106e37:	6a 00                	push   $0x0
  pushl $241
80106e39:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
80106e3e:	e9 8a f1 ff ff       	jmp    80105fcd <alltraps>

80106e43 <vector242>:
.globl vector242
vector242:
  pushl $0
80106e43:	6a 00                	push   $0x0
  pushl $242
80106e45:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
80106e4a:	e9 7e f1 ff ff       	jmp    80105fcd <alltraps>

80106e4f <vector243>:
.globl vector243
vector243:
  pushl $0
80106e4f:	6a 00                	push   $0x0
  pushl $243
80106e51:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
80106e56:	e9 72 f1 ff ff       	jmp    80105fcd <alltraps>

80106e5b <vector244>:
.globl vector244
vector244:
  pushl $0
80106e5b:	6a 00                	push   $0x0
  pushl $244
80106e5d:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
80106e62:	e9 66 f1 ff ff       	jmp    80105fcd <alltraps>

80106e67 <vector245>:
.globl vector245
vector245:
  pushl $0
80106e67:	6a 00                	push   $0x0
  pushl $245
80106e69:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
80106e6e:	e9 5a f1 ff ff       	jmp    80105fcd <alltraps>

80106e73 <vector246>:
.globl vector246
vector246:
  pushl $0
80106e73:	6a 00                	push   $0x0
  pushl $246
80106e75:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
80106e7a:	e9 4e f1 ff ff       	jmp    80105fcd <alltraps>

80106e7f <vector247>:
.globl vector247
vector247:
  pushl $0
80106e7f:	6a 00                	push   $0x0
  pushl $247
80106e81:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
80106e86:	e9 42 f1 ff ff       	jmp    80105fcd <alltraps>

80106e8b <vector248>:
.globl vector248
vector248:
  pushl $0
80106e8b:	6a 00                	push   $0x0
  pushl $248
80106e8d:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
80106e92:	e9 36 f1 ff ff       	jmp    80105fcd <alltraps>

80106e97 <vector249>:
.globl vector249
vector249:
  pushl $0
80106e97:	6a 00                	push   $0x0
  pushl $249
80106e99:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
80106e9e:	e9 2a f1 ff ff       	jmp    80105fcd <alltraps>

80106ea3 <vector250>:
.globl vector250
vector250:
  pushl $0
80106ea3:	6a 00                	push   $0x0
  pushl $250
80106ea5:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80106eaa:	e9 1e f1 ff ff       	jmp    80105fcd <alltraps>

80106eaf <vector251>:
.globl vector251
vector251:
  pushl $0
80106eaf:	6a 00                	push   $0x0
  pushl $251
80106eb1:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80106eb6:	e9 12 f1 ff ff       	jmp    80105fcd <alltraps>

80106ebb <vector252>:
.globl vector252
vector252:
  pushl $0
80106ebb:	6a 00                	push   $0x0
  pushl $252
80106ebd:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
80106ec2:	e9 06 f1 ff ff       	jmp    80105fcd <alltraps>

80106ec7 <vector253>:
.globl vector253
vector253:
  pushl $0
80106ec7:	6a 00                	push   $0x0
  pushl $253
80106ec9:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
80106ece:	e9 fa f0 ff ff       	jmp    80105fcd <alltraps>

80106ed3 <vector254>:
.globl vector254
vector254:
  pushl $0
80106ed3:	6a 00                	push   $0x0
  pushl $254
80106ed5:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80106eda:	e9 ee f0 ff ff       	jmp    80105fcd <alltraps>

80106edf <vector255>:
.globl vector255
vector255:
  pushl $0
80106edf:	6a 00                	push   $0x0
  pushl $255
80106ee1:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80106ee6:	e9 e2 f0 ff ff       	jmp    80105fcd <alltraps>
80106eeb:	66 90                	xchg   %ax,%ax
80106eed:	66 90                	xchg   %ax,%ax
80106eef:	90                   	nop

80106ef0 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80106ef0:	55                   	push   %ebp
80106ef1:	89 e5                	mov    %esp,%ebp
80106ef3:	57                   	push   %edi
80106ef4:	56                   	push   %esi
80106ef5:	89 d6                	mov    %edx,%esi
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80106ef7:	c1 ea 16             	shr    $0x16,%edx
{
80106efa:	53                   	push   %ebx
  pde = &pgdir[PDX(va)];
80106efb:	8d 3c 90             	lea    (%eax,%edx,4),%edi
{
80106efe:	83 ec 0c             	sub    $0xc,%esp
  if(*pde & PTE_P){
80106f01:	8b 1f                	mov    (%edi),%ebx
80106f03:	f6 c3 01             	test   $0x1,%bl
80106f06:	74 28                	je     80106f30 <walkpgdir+0x40>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106f08:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
80106f0e:	81 c3 00 00 00 80    	add    $0x80000000,%ebx
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
80106f14:	89 f0                	mov    %esi,%eax
}
80106f16:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return &pgtab[PTX(va)];
80106f19:	c1 e8 0a             	shr    $0xa,%eax
80106f1c:	25 fc 0f 00 00       	and    $0xffc,%eax
80106f21:	01 d8                	add    %ebx,%eax
}
80106f23:	5b                   	pop    %ebx
80106f24:	5e                   	pop    %esi
80106f25:	5f                   	pop    %edi
80106f26:	5d                   	pop    %ebp
80106f27:	c3                   	ret    
80106f28:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106f2f:	90                   	nop
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80106f30:	85 c9                	test   %ecx,%ecx
80106f32:	74 2c                	je     80106f60 <walkpgdir+0x70>
80106f34:	e8 37 bd ff ff       	call   80102c70 <kalloc>
80106f39:	89 c3                	mov    %eax,%ebx
80106f3b:	85 c0                	test   %eax,%eax
80106f3d:	74 21                	je     80106f60 <walkpgdir+0x70>
    memset(pgtab, 0, PGSIZE);
80106f3f:	83 ec 04             	sub    $0x4,%esp
80106f42:	68 00 10 00 00       	push   $0x1000
80106f47:	6a 00                	push   $0x0
80106f49:	50                   	push   %eax
80106f4a:	e8 d1 dd ff ff       	call   80104d20 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
80106f4f:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106f55:	83 c4 10             	add    $0x10,%esp
80106f58:	83 c8 07             	or     $0x7,%eax
80106f5b:	89 07                	mov    %eax,(%edi)
80106f5d:	eb b5                	jmp    80106f14 <walkpgdir+0x24>
80106f5f:	90                   	nop
}
80106f60:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return 0;
80106f63:	31 c0                	xor    %eax,%eax
}
80106f65:	5b                   	pop    %ebx
80106f66:	5e                   	pop    %esi
80106f67:	5f                   	pop    %edi
80106f68:	5d                   	pop    %ebp
80106f69:	c3                   	ret    
80106f6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106f70 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80106f70:	55                   	push   %ebp
80106f71:	89 e5                	mov    %esp,%ebp
80106f73:	57                   	push   %edi
80106f74:	89 c7                	mov    %eax,%edi
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80106f76:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
{
80106f7a:	56                   	push   %esi
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80106f7b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  a = (char*)PGROUNDDOWN((uint)va);
80106f80:	89 d6                	mov    %edx,%esi
{
80106f82:	53                   	push   %ebx
  a = (char*)PGROUNDDOWN((uint)va);
80106f83:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
{
80106f89:	83 ec 1c             	sub    $0x1c,%esp
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80106f8c:	89 45 e0             	mov    %eax,-0x20(%ebp)
80106f8f:	8b 45 08             	mov    0x8(%ebp),%eax
80106f92:	29 f0                	sub    %esi,%eax
80106f94:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106f97:	eb 1f                	jmp    80106fb8 <mappages+0x48>
80106f99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
80106fa0:	f6 00 01             	testb  $0x1,(%eax)
80106fa3:	75 45                	jne    80106fea <mappages+0x7a>
      panic("remap");
    *pte = pa | perm | PTE_P;
80106fa5:	0b 5d 0c             	or     0xc(%ebp),%ebx
80106fa8:	83 cb 01             	or     $0x1,%ebx
80106fab:	89 18                	mov    %ebx,(%eax)
    if(a == last)
80106fad:	3b 75 e0             	cmp    -0x20(%ebp),%esi
80106fb0:	74 2e                	je     80106fe0 <mappages+0x70>
      break;
    a += PGSIZE;
80106fb2:	81 c6 00 10 00 00    	add    $0x1000,%esi
  for(;;){
80106fb8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80106fbb:	b9 01 00 00 00       	mov    $0x1,%ecx
80106fc0:	89 f2                	mov    %esi,%edx
80106fc2:	8d 1c 06             	lea    (%esi,%eax,1),%ebx
80106fc5:	89 f8                	mov    %edi,%eax
80106fc7:	e8 24 ff ff ff       	call   80106ef0 <walkpgdir>
80106fcc:	85 c0                	test   %eax,%eax
80106fce:	75 d0                	jne    80106fa0 <mappages+0x30>
    pa += PGSIZE;
  }
  return 0;
}
80106fd0:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80106fd3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106fd8:	5b                   	pop    %ebx
80106fd9:	5e                   	pop    %esi
80106fda:	5f                   	pop    %edi
80106fdb:	5d                   	pop    %ebp
80106fdc:	c3                   	ret    
80106fdd:	8d 76 00             	lea    0x0(%esi),%esi
80106fe0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80106fe3:	31 c0                	xor    %eax,%eax
}
80106fe5:	5b                   	pop    %ebx
80106fe6:	5e                   	pop    %esi
80106fe7:	5f                   	pop    %edi
80106fe8:	5d                   	pop    %ebp
80106fe9:	c3                   	ret    
      panic("remap");
80106fea:	83 ec 0c             	sub    $0xc,%esp
80106fed:	68 54 81 10 80       	push   $0x80108154
80106ff2:	e8 b9 93 ff ff       	call   801003b0 <panic>
80106ff7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106ffe:	66 90                	xchg   %ax,%ax

80107000 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80107000:	55                   	push   %ebp
80107001:	89 e5                	mov    %esp,%ebp
80107003:	57                   	push   %edi
80107004:	56                   	push   %esi
80107005:	89 c6                	mov    %eax,%esi
80107007:	53                   	push   %ebx
80107008:	89 d3                	mov    %edx,%ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
8010700a:	8d 91 ff 0f 00 00    	lea    0xfff(%ecx),%edx
80107010:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80107016:	83 ec 1c             	sub    $0x1c,%esp
80107019:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  for(; a  < oldsz; a += PGSIZE){
8010701c:	39 da                	cmp    %ebx,%edx
8010701e:	73 5b                	jae    8010707b <deallocuvm.part.0+0x7b>
80107020:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
80107023:	89 d7                	mov    %edx,%edi
80107025:	eb 14                	jmp    8010703b <deallocuvm.part.0+0x3b>
80107027:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010702e:	66 90                	xchg   %ax,%ax
80107030:	81 c7 00 10 00 00    	add    $0x1000,%edi
80107036:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80107039:	76 40                	jbe    8010707b <deallocuvm.part.0+0x7b>
    pte = walkpgdir(pgdir, (char*)a, 0);
8010703b:	31 c9                	xor    %ecx,%ecx
8010703d:	89 fa                	mov    %edi,%edx
8010703f:	89 f0                	mov    %esi,%eax
80107041:	e8 aa fe ff ff       	call   80106ef0 <walkpgdir>
80107046:	89 c3                	mov    %eax,%ebx
    if(!pte)
80107048:	85 c0                	test   %eax,%eax
8010704a:	74 44                	je     80107090 <deallocuvm.part.0+0x90>
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
8010704c:	8b 00                	mov    (%eax),%eax
8010704e:	a8 01                	test   $0x1,%al
80107050:	74 de                	je     80107030 <deallocuvm.part.0+0x30>
      pa = PTE_ADDR(*pte);
      if(pa == 0)
80107052:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107057:	74 47                	je     801070a0 <deallocuvm.part.0+0xa0>
        panic("kfree");
      char *v = P2V(pa);
      kfree(v);
80107059:	83 ec 0c             	sub    $0xc,%esp
      char *v = P2V(pa);
8010705c:	05 00 00 00 80       	add    $0x80000000,%eax
80107061:	81 c7 00 10 00 00    	add    $0x1000,%edi
      kfree(v);
80107067:	50                   	push   %eax
80107068:	e8 43 ba ff ff       	call   80102ab0 <kfree>
      *pte = 0;
8010706d:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80107073:	83 c4 10             	add    $0x10,%esp
  for(; a  < oldsz; a += PGSIZE){
80107076:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80107079:	77 c0                	ja     8010703b <deallocuvm.part.0+0x3b>
    }
  }
  return newsz;
}
8010707b:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010707e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107081:	5b                   	pop    %ebx
80107082:	5e                   	pop    %esi
80107083:	5f                   	pop    %edi
80107084:	5d                   	pop    %ebp
80107085:	c3                   	ret    
80107086:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010708d:	8d 76 00             	lea    0x0(%esi),%esi
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
80107090:	89 fa                	mov    %edi,%edx
80107092:	81 e2 00 00 c0 ff    	and    $0xffc00000,%edx
80107098:	8d ba 00 00 40 00    	lea    0x400000(%edx),%edi
8010709e:	eb 96                	jmp    80107036 <deallocuvm.part.0+0x36>
        panic("kfree");
801070a0:	83 ec 0c             	sub    $0xc,%esp
801070a3:	68 fe 7a 10 80       	push   $0x80107afe
801070a8:	e8 03 93 ff ff       	call   801003b0 <panic>
801070ad:	8d 76 00             	lea    0x0(%esi),%esi

801070b0 <seginit>:
{
801070b0:	f3 0f 1e fb          	endbr32 
801070b4:	55                   	push   %ebp
801070b5:	89 e5                	mov    %esp,%ebp
801070b7:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
801070ba:	e8 c1 ce ff ff       	call   80103f80 <cpuid>
  pd[0] = size - 1;
801070bf:	ba 2f 00 00 00       	mov    $0x2f,%edx
801070c4:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
801070ca:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
801070ce:	c7 80 38 44 11 80 ff 	movl   $0xffff,-0x7feebbc8(%eax)
801070d5:	ff 00 00 
801070d8:	c7 80 3c 44 11 80 00 	movl   $0xcf9a00,-0x7feebbc4(%eax)
801070df:	9a cf 00 
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
801070e2:	c7 80 40 44 11 80 ff 	movl   $0xffff,-0x7feebbc0(%eax)
801070e9:	ff 00 00 
801070ec:	c7 80 44 44 11 80 00 	movl   $0xcf9200,-0x7feebbbc(%eax)
801070f3:	92 cf 00 
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
801070f6:	c7 80 48 44 11 80 ff 	movl   $0xffff,-0x7feebbb8(%eax)
801070fd:	ff 00 00 
80107100:	c7 80 4c 44 11 80 00 	movl   $0xcffa00,-0x7feebbb4(%eax)
80107107:	fa cf 00 
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
8010710a:	c7 80 50 44 11 80 ff 	movl   $0xffff,-0x7feebbb0(%eax)
80107111:	ff 00 00 
80107114:	c7 80 54 44 11 80 00 	movl   $0xcff200,-0x7feebbac(%eax)
8010711b:	f2 cf 00 
  lgdt(c->gdt, sizeof(c->gdt));
8010711e:	05 30 44 11 80       	add    $0x80114430,%eax
  pd[1] = (uint)p;
80107123:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80107127:	c1 e8 10             	shr    $0x10,%eax
8010712a:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r"(pd));
8010712e:	8d 45 f2             	lea    -0xe(%ebp),%eax
80107131:	0f 01 10             	lgdtl  (%eax)
}
80107134:	c9                   	leave  
80107135:	c3                   	ret    
80107136:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010713d:	8d 76 00             	lea    0x0(%esi),%esi

80107140 <switchkvm>:
{
80107140:	f3 0f 1e fb          	endbr32 
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80107144:	a1 e4 70 11 80       	mov    0x801170e4,%eax
80107149:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r"(val));
8010714e:	0f 22 d8             	mov    %eax,%cr3
}
80107151:	c3                   	ret    
80107152:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107159:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107160 <switchuvm>:
{
80107160:	f3 0f 1e fb          	endbr32 
80107164:	55                   	push   %ebp
80107165:	89 e5                	mov    %esp,%ebp
80107167:	57                   	push   %edi
80107168:	56                   	push   %esi
80107169:	53                   	push   %ebx
8010716a:	83 ec 1c             	sub    $0x1c,%esp
8010716d:	8b 75 08             	mov    0x8(%ebp),%esi
  if(p == 0)
80107170:	85 f6                	test   %esi,%esi
80107172:	0f 84 cb 00 00 00    	je     80107243 <switchuvm+0xe3>
  if(p->kstack == 0)
80107178:	8b 46 08             	mov    0x8(%esi),%eax
8010717b:	85 c0                	test   %eax,%eax
8010717d:	0f 84 da 00 00 00    	je     8010725d <switchuvm+0xfd>
  if(p->pgdir == 0)
80107183:	8b 46 04             	mov    0x4(%esi),%eax
80107186:	85 c0                	test   %eax,%eax
80107188:	0f 84 c2 00 00 00    	je     80107250 <switchuvm+0xf0>
  pushcli();
8010718e:	e8 7d d9 ff ff       	call   80104b10 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80107193:	e8 78 cd ff ff       	call   80103f10 <mycpu>
80107198:	89 c3                	mov    %eax,%ebx
8010719a:	e8 71 cd ff ff       	call   80103f10 <mycpu>
8010719f:	89 c7                	mov    %eax,%edi
801071a1:	e8 6a cd ff ff       	call   80103f10 <mycpu>
801071a6:	83 c7 08             	add    $0x8,%edi
801071a9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801071ac:	e8 5f cd ff ff       	call   80103f10 <mycpu>
801071b1:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801071b4:	ba 67 00 00 00       	mov    $0x67,%edx
801071b9:	66 89 bb 9a 00 00 00 	mov    %di,0x9a(%ebx)
801071c0:	83 c0 08             	add    $0x8,%eax
801071c3:	66 89 93 98 00 00 00 	mov    %dx,0x98(%ebx)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
801071ca:	bf ff ff ff ff       	mov    $0xffffffff,%edi
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
801071cf:	83 c1 08             	add    $0x8,%ecx
801071d2:	c1 e8 18             	shr    $0x18,%eax
801071d5:	c1 e9 10             	shr    $0x10,%ecx
801071d8:	88 83 9f 00 00 00    	mov    %al,0x9f(%ebx)
801071de:	88 8b 9c 00 00 00    	mov    %cl,0x9c(%ebx)
801071e4:	b9 99 40 00 00       	mov    $0x4099,%ecx
801071e9:	66 89 8b 9d 00 00 00 	mov    %cx,0x9d(%ebx)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
801071f0:	bb 10 00 00 00       	mov    $0x10,%ebx
  mycpu()->gdt[SEG_TSS].s = 0;
801071f5:	e8 16 cd ff ff       	call   80103f10 <mycpu>
801071fa:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80107201:	e8 0a cd ff ff       	call   80103f10 <mycpu>
80107206:	66 89 58 10          	mov    %bx,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
8010720a:	8b 5e 08             	mov    0x8(%esi),%ebx
8010720d:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80107213:	e8 f8 cc ff ff       	call   80103f10 <mycpu>
80107218:	89 58 0c             	mov    %ebx,0xc(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
8010721b:	e8 f0 cc ff ff       	call   80103f10 <mycpu>
80107220:	66 89 78 6e          	mov    %di,0x6e(%eax)
  asm volatile("ltr %0" : : "r"(sel));
80107224:	b8 28 00 00 00       	mov    $0x28,%eax
80107229:	0f 00 d8             	ltr    %ax
  lcr3(V2P(p->pgdir));  // switch to process's address space
8010722c:	8b 46 04             	mov    0x4(%esi),%eax
8010722f:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r"(val));
80107234:	0f 22 d8             	mov    %eax,%cr3
}
80107237:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010723a:	5b                   	pop    %ebx
8010723b:	5e                   	pop    %esi
8010723c:	5f                   	pop    %edi
8010723d:	5d                   	pop    %ebp
  popcli();
8010723e:	e9 1d d9 ff ff       	jmp    80104b60 <popcli>
    panic("switchuvm: no process");
80107243:	83 ec 0c             	sub    $0xc,%esp
80107246:	68 5a 81 10 80       	push   $0x8010815a
8010724b:	e8 60 91 ff ff       	call   801003b0 <panic>
    panic("switchuvm: no pgdir");
80107250:	83 ec 0c             	sub    $0xc,%esp
80107253:	68 85 81 10 80       	push   $0x80108185
80107258:	e8 53 91 ff ff       	call   801003b0 <panic>
    panic("switchuvm: no kstack");
8010725d:	83 ec 0c             	sub    $0xc,%esp
80107260:	68 70 81 10 80       	push   $0x80108170
80107265:	e8 46 91 ff ff       	call   801003b0 <panic>
8010726a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107270 <inituvm>:
{
80107270:	f3 0f 1e fb          	endbr32 
80107274:	55                   	push   %ebp
80107275:	89 e5                	mov    %esp,%ebp
80107277:	57                   	push   %edi
80107278:	56                   	push   %esi
80107279:	53                   	push   %ebx
8010727a:	83 ec 1c             	sub    $0x1c,%esp
8010727d:	8b 45 0c             	mov    0xc(%ebp),%eax
80107280:	8b 75 10             	mov    0x10(%ebp),%esi
80107283:	8b 7d 08             	mov    0x8(%ebp),%edi
80107286:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(sz >= PGSIZE)
80107289:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
8010728f:	77 4b                	ja     801072dc <inituvm+0x6c>
  mem = kalloc();
80107291:	e8 da b9 ff ff       	call   80102c70 <kalloc>
  memset(mem, 0, PGSIZE);
80107296:	83 ec 04             	sub    $0x4,%esp
80107299:	68 00 10 00 00       	push   $0x1000
  mem = kalloc();
8010729e:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
801072a0:	6a 00                	push   $0x0
801072a2:	50                   	push   %eax
801072a3:	e8 78 da ff ff       	call   80104d20 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
801072a8:	58                   	pop    %eax
801072a9:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801072af:	5a                   	pop    %edx
801072b0:	6a 06                	push   $0x6
801072b2:	b9 00 10 00 00       	mov    $0x1000,%ecx
801072b7:	31 d2                	xor    %edx,%edx
801072b9:	50                   	push   %eax
801072ba:	89 f8                	mov    %edi,%eax
801072bc:	e8 af fc ff ff       	call   80106f70 <mappages>
  memmove(mem, init, sz);
801072c1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801072c4:	89 75 10             	mov    %esi,0x10(%ebp)
801072c7:	83 c4 10             	add    $0x10,%esp
801072ca:	89 5d 08             	mov    %ebx,0x8(%ebp)
801072cd:	89 45 0c             	mov    %eax,0xc(%ebp)
}
801072d0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801072d3:	5b                   	pop    %ebx
801072d4:	5e                   	pop    %esi
801072d5:	5f                   	pop    %edi
801072d6:	5d                   	pop    %ebp
  memmove(mem, init, sz);
801072d7:	e9 e4 da ff ff       	jmp    80104dc0 <memmove>
    panic("inituvm: more than a page");
801072dc:	83 ec 0c             	sub    $0xc,%esp
801072df:	68 99 81 10 80       	push   $0x80108199
801072e4:	e8 c7 90 ff ff       	call   801003b0 <panic>
801072e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801072f0 <loaduvm>:
{
801072f0:	f3 0f 1e fb          	endbr32 
801072f4:	55                   	push   %ebp
801072f5:	89 e5                	mov    %esp,%ebp
801072f7:	57                   	push   %edi
801072f8:	56                   	push   %esi
801072f9:	53                   	push   %ebx
801072fa:	83 ec 1c             	sub    $0x1c,%esp
801072fd:	8b 45 0c             	mov    0xc(%ebp),%eax
80107300:	8b 75 18             	mov    0x18(%ebp),%esi
  if((uint) addr % PGSIZE != 0)
80107303:	a9 ff 0f 00 00       	test   $0xfff,%eax
80107308:	0f 85 99 00 00 00    	jne    801073a7 <loaduvm+0xb7>
  for(i = 0; i < sz; i += PGSIZE){
8010730e:	01 f0                	add    %esi,%eax
80107310:	89 f3                	mov    %esi,%ebx
80107312:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(readi(ip, P2V(pa), offset+i, n) != n)
80107315:	8b 45 14             	mov    0x14(%ebp),%eax
80107318:	01 f0                	add    %esi,%eax
8010731a:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(i = 0; i < sz; i += PGSIZE){
8010731d:	85 f6                	test   %esi,%esi
8010731f:	75 15                	jne    80107336 <loaduvm+0x46>
80107321:	eb 6d                	jmp    80107390 <loaduvm+0xa0>
80107323:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107327:	90                   	nop
80107328:	81 eb 00 10 00 00    	sub    $0x1000,%ebx
8010732e:	89 f0                	mov    %esi,%eax
80107330:	29 d8                	sub    %ebx,%eax
80107332:	39 c6                	cmp    %eax,%esi
80107334:	76 5a                	jbe    80107390 <loaduvm+0xa0>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80107336:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80107339:	8b 45 08             	mov    0x8(%ebp),%eax
8010733c:	31 c9                	xor    %ecx,%ecx
8010733e:	29 da                	sub    %ebx,%edx
80107340:	e8 ab fb ff ff       	call   80106ef0 <walkpgdir>
80107345:	85 c0                	test   %eax,%eax
80107347:	74 51                	je     8010739a <loaduvm+0xaa>
    pa = PTE_ADDR(*pte);
80107349:	8b 00                	mov    (%eax),%eax
    if(readi(ip, P2V(pa), offset+i, n) != n)
8010734b:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    if(sz - i < PGSIZE)
8010734e:	bf 00 10 00 00       	mov    $0x1000,%edi
    pa = PTE_ADDR(*pte);
80107353:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
80107358:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
8010735e:	0f 46 fb             	cmovbe %ebx,%edi
    if(readi(ip, P2V(pa), offset+i, n) != n)
80107361:	29 d9                	sub    %ebx,%ecx
80107363:	05 00 00 00 80       	add    $0x80000000,%eax
80107368:	57                   	push   %edi
80107369:	51                   	push   %ecx
8010736a:	50                   	push   %eax
8010736b:	ff 75 10             	pushl  0x10(%ebp)
8010736e:	e8 2d ad ff ff       	call   801020a0 <readi>
80107373:	83 c4 10             	add    $0x10,%esp
80107376:	39 f8                	cmp    %edi,%eax
80107378:	74 ae                	je     80107328 <loaduvm+0x38>
}
8010737a:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
8010737d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107382:	5b                   	pop    %ebx
80107383:	5e                   	pop    %esi
80107384:	5f                   	pop    %edi
80107385:	5d                   	pop    %ebp
80107386:	c3                   	ret    
80107387:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010738e:	66 90                	xchg   %ax,%ax
80107390:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80107393:	31 c0                	xor    %eax,%eax
}
80107395:	5b                   	pop    %ebx
80107396:	5e                   	pop    %esi
80107397:	5f                   	pop    %edi
80107398:	5d                   	pop    %ebp
80107399:	c3                   	ret    
      panic("loaduvm: address should exist");
8010739a:	83 ec 0c             	sub    $0xc,%esp
8010739d:	68 b3 81 10 80       	push   $0x801081b3
801073a2:	e8 09 90 ff ff       	call   801003b0 <panic>
    panic("loaduvm: addr must be page aligned");
801073a7:	83 ec 0c             	sub    $0xc,%esp
801073aa:	68 54 82 10 80       	push   $0x80108254
801073af:	e8 fc 8f ff ff       	call   801003b0 <panic>
801073b4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801073bb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801073bf:	90                   	nop

801073c0 <allocuvm>:
{
801073c0:	f3 0f 1e fb          	endbr32 
801073c4:	55                   	push   %ebp
801073c5:	89 e5                	mov    %esp,%ebp
801073c7:	57                   	push   %edi
801073c8:	56                   	push   %esi
801073c9:	53                   	push   %ebx
801073ca:	83 ec 1c             	sub    $0x1c,%esp
  if(newsz >= KERNBASE)
801073cd:	8b 45 10             	mov    0x10(%ebp),%eax
{
801073d0:	8b 7d 08             	mov    0x8(%ebp),%edi
  if(newsz >= KERNBASE)
801073d3:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801073d6:	85 c0                	test   %eax,%eax
801073d8:	0f 88 b2 00 00 00    	js     80107490 <allocuvm+0xd0>
  if(newsz < oldsz)
801073de:	3b 45 0c             	cmp    0xc(%ebp),%eax
    return oldsz;
801073e1:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(newsz < oldsz)
801073e4:	0f 82 96 00 00 00    	jb     80107480 <allocuvm+0xc0>
  a = PGROUNDUP(oldsz);
801073ea:	8d b0 ff 0f 00 00    	lea    0xfff(%eax),%esi
801073f0:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
  for(; a < newsz; a += PGSIZE){
801073f6:	39 75 10             	cmp    %esi,0x10(%ebp)
801073f9:	77 40                	ja     8010743b <allocuvm+0x7b>
801073fb:	e9 83 00 00 00       	jmp    80107483 <allocuvm+0xc3>
    memset(mem, 0, PGSIZE);
80107400:	83 ec 04             	sub    $0x4,%esp
80107403:	68 00 10 00 00       	push   $0x1000
80107408:	6a 00                	push   $0x0
8010740a:	50                   	push   %eax
8010740b:	e8 10 d9 ff ff       	call   80104d20 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80107410:	58                   	pop    %eax
80107411:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80107417:	5a                   	pop    %edx
80107418:	6a 06                	push   $0x6
8010741a:	b9 00 10 00 00       	mov    $0x1000,%ecx
8010741f:	89 f2                	mov    %esi,%edx
80107421:	50                   	push   %eax
80107422:	89 f8                	mov    %edi,%eax
80107424:	e8 47 fb ff ff       	call   80106f70 <mappages>
80107429:	83 c4 10             	add    $0x10,%esp
8010742c:	85 c0                	test   %eax,%eax
8010742e:	78 78                	js     801074a8 <allocuvm+0xe8>
  for(; a < newsz; a += PGSIZE){
80107430:	81 c6 00 10 00 00    	add    $0x1000,%esi
80107436:	39 75 10             	cmp    %esi,0x10(%ebp)
80107439:	76 48                	jbe    80107483 <allocuvm+0xc3>
    mem = kalloc();
8010743b:	e8 30 b8 ff ff       	call   80102c70 <kalloc>
80107440:	89 c3                	mov    %eax,%ebx
    if(mem == 0){
80107442:	85 c0                	test   %eax,%eax
80107444:	75 ba                	jne    80107400 <allocuvm+0x40>
      cprintf("allocuvm out of memory\n");
80107446:	83 ec 0c             	sub    $0xc,%esp
80107449:	68 d1 81 10 80       	push   $0x801081d1
8010744e:	e8 4d 93 ff ff       	call   801007a0 <cprintf>
  if(newsz >= oldsz)
80107453:	8b 45 0c             	mov    0xc(%ebp),%eax
80107456:	83 c4 10             	add    $0x10,%esp
80107459:	39 45 10             	cmp    %eax,0x10(%ebp)
8010745c:	74 32                	je     80107490 <allocuvm+0xd0>
8010745e:	8b 55 10             	mov    0x10(%ebp),%edx
80107461:	89 c1                	mov    %eax,%ecx
80107463:	89 f8                	mov    %edi,%eax
80107465:	e8 96 fb ff ff       	call   80107000 <deallocuvm.part.0>
      return 0;
8010746a:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
}
80107471:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107474:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107477:	5b                   	pop    %ebx
80107478:	5e                   	pop    %esi
80107479:	5f                   	pop    %edi
8010747a:	5d                   	pop    %ebp
8010747b:	c3                   	ret    
8010747c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return oldsz;
80107480:	89 45 e4             	mov    %eax,-0x1c(%ebp)
}
80107483:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107486:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107489:	5b                   	pop    %ebx
8010748a:	5e                   	pop    %esi
8010748b:	5f                   	pop    %edi
8010748c:	5d                   	pop    %ebp
8010748d:	c3                   	ret    
8010748e:	66 90                	xchg   %ax,%ax
    return 0;
80107490:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
}
80107497:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010749a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010749d:	5b                   	pop    %ebx
8010749e:	5e                   	pop    %esi
8010749f:	5f                   	pop    %edi
801074a0:	5d                   	pop    %ebp
801074a1:	c3                   	ret    
801074a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      cprintf("allocuvm out of memory (2)\n");
801074a8:	83 ec 0c             	sub    $0xc,%esp
801074ab:	68 e9 81 10 80       	push   $0x801081e9
801074b0:	e8 eb 92 ff ff       	call   801007a0 <cprintf>
  if(newsz >= oldsz)
801074b5:	8b 45 0c             	mov    0xc(%ebp),%eax
801074b8:	83 c4 10             	add    $0x10,%esp
801074bb:	39 45 10             	cmp    %eax,0x10(%ebp)
801074be:	74 0c                	je     801074cc <allocuvm+0x10c>
801074c0:	8b 55 10             	mov    0x10(%ebp),%edx
801074c3:	89 c1                	mov    %eax,%ecx
801074c5:	89 f8                	mov    %edi,%eax
801074c7:	e8 34 fb ff ff       	call   80107000 <deallocuvm.part.0>
      kfree(mem);
801074cc:	83 ec 0c             	sub    $0xc,%esp
801074cf:	53                   	push   %ebx
801074d0:	e8 db b5 ff ff       	call   80102ab0 <kfree>
      return 0;
801074d5:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
801074dc:	83 c4 10             	add    $0x10,%esp
}
801074df:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801074e2:	8d 65 f4             	lea    -0xc(%ebp),%esp
801074e5:	5b                   	pop    %ebx
801074e6:	5e                   	pop    %esi
801074e7:	5f                   	pop    %edi
801074e8:	5d                   	pop    %ebp
801074e9:	c3                   	ret    
801074ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801074f0 <deallocuvm>:
{
801074f0:	f3 0f 1e fb          	endbr32 
801074f4:	55                   	push   %ebp
801074f5:	89 e5                	mov    %esp,%ebp
801074f7:	8b 55 0c             	mov    0xc(%ebp),%edx
801074fa:	8b 4d 10             	mov    0x10(%ebp),%ecx
801074fd:	8b 45 08             	mov    0x8(%ebp),%eax
  if(newsz >= oldsz)
80107500:	39 d1                	cmp    %edx,%ecx
80107502:	73 0c                	jae    80107510 <deallocuvm+0x20>
}
80107504:	5d                   	pop    %ebp
80107505:	e9 f6 fa ff ff       	jmp    80107000 <deallocuvm.part.0>
8010750a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107510:	89 d0                	mov    %edx,%eax
80107512:	5d                   	pop    %ebp
80107513:	c3                   	ret    
80107514:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010751b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010751f:	90                   	nop

80107520 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80107520:	f3 0f 1e fb          	endbr32 
80107524:	55                   	push   %ebp
80107525:	89 e5                	mov    %esp,%ebp
80107527:	57                   	push   %edi
80107528:	56                   	push   %esi
80107529:	53                   	push   %ebx
8010752a:	83 ec 0c             	sub    $0xc,%esp
8010752d:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
80107530:	85 f6                	test   %esi,%esi
80107532:	74 55                	je     80107589 <freevm+0x69>
  if(newsz >= oldsz)
80107534:	31 c9                	xor    %ecx,%ecx
80107536:	ba 00 00 00 80       	mov    $0x80000000,%edx
8010753b:	89 f0                	mov    %esi,%eax
8010753d:	89 f3                	mov    %esi,%ebx
8010753f:	e8 bc fa ff ff       	call   80107000 <deallocuvm.part.0>
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80107544:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
8010754a:	eb 0b                	jmp    80107557 <freevm+0x37>
8010754c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107550:	83 c3 04             	add    $0x4,%ebx
80107553:	39 df                	cmp    %ebx,%edi
80107555:	74 23                	je     8010757a <freevm+0x5a>
    if(pgdir[i] & PTE_P){
80107557:	8b 03                	mov    (%ebx),%eax
80107559:	a8 01                	test   $0x1,%al
8010755b:	74 f3                	je     80107550 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
8010755d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
      kfree(v);
80107562:	83 ec 0c             	sub    $0xc,%esp
80107565:	83 c3 04             	add    $0x4,%ebx
      char * v = P2V(PTE_ADDR(pgdir[i]));
80107568:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
8010756d:	50                   	push   %eax
8010756e:	e8 3d b5 ff ff       	call   80102ab0 <kfree>
80107573:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
80107576:	39 df                	cmp    %ebx,%edi
80107578:	75 dd                	jne    80107557 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
8010757a:	89 75 08             	mov    %esi,0x8(%ebp)
}
8010757d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107580:	5b                   	pop    %ebx
80107581:	5e                   	pop    %esi
80107582:	5f                   	pop    %edi
80107583:	5d                   	pop    %ebp
  kfree((char*)pgdir);
80107584:	e9 27 b5 ff ff       	jmp    80102ab0 <kfree>
    panic("freevm: no pgdir");
80107589:	83 ec 0c             	sub    $0xc,%esp
8010758c:	68 05 82 10 80       	push   $0x80108205
80107591:	e8 1a 8e ff ff       	call   801003b0 <panic>
80107596:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010759d:	8d 76 00             	lea    0x0(%esi),%esi

801075a0 <setupkvm>:
{
801075a0:	f3 0f 1e fb          	endbr32 
801075a4:	55                   	push   %ebp
801075a5:	89 e5                	mov    %esp,%ebp
801075a7:	56                   	push   %esi
801075a8:	53                   	push   %ebx
  if((pgdir = (pde_t*)kalloc()) == 0)
801075a9:	e8 c2 b6 ff ff       	call   80102c70 <kalloc>
801075ae:	89 c6                	mov    %eax,%esi
801075b0:	85 c0                	test   %eax,%eax
801075b2:	74 42                	je     801075f6 <setupkvm+0x56>
  memset(pgdir, 0, PGSIZE);
801075b4:	83 ec 04             	sub    $0x4,%esp
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
801075b7:	bb 20 b4 10 80       	mov    $0x8010b420,%ebx
  memset(pgdir, 0, PGSIZE);
801075bc:	68 00 10 00 00       	push   $0x1000
801075c1:	6a 00                	push   $0x0
801075c3:	50                   	push   %eax
801075c4:	e8 57 d7 ff ff       	call   80104d20 <memset>
801075c9:	83 c4 10             	add    $0x10,%esp
                (uint)k->phys_start, k->perm) < 0) {
801075cc:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
801075cf:	83 ec 08             	sub    $0x8,%esp
801075d2:	8b 4b 08             	mov    0x8(%ebx),%ecx
801075d5:	ff 73 0c             	pushl  0xc(%ebx)
801075d8:	8b 13                	mov    (%ebx),%edx
801075da:	50                   	push   %eax
801075db:	29 c1                	sub    %eax,%ecx
801075dd:	89 f0                	mov    %esi,%eax
801075df:	e8 8c f9 ff ff       	call   80106f70 <mappages>
801075e4:	83 c4 10             	add    $0x10,%esp
801075e7:	85 c0                	test   %eax,%eax
801075e9:	78 15                	js     80107600 <setupkvm+0x60>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
801075eb:	83 c3 10             	add    $0x10,%ebx
801075ee:	81 fb 60 b4 10 80    	cmp    $0x8010b460,%ebx
801075f4:	75 d6                	jne    801075cc <setupkvm+0x2c>
}
801075f6:	8d 65 f8             	lea    -0x8(%ebp),%esp
801075f9:	89 f0                	mov    %esi,%eax
801075fb:	5b                   	pop    %ebx
801075fc:	5e                   	pop    %esi
801075fd:	5d                   	pop    %ebp
801075fe:	c3                   	ret    
801075ff:	90                   	nop
      freevm(pgdir);
80107600:	83 ec 0c             	sub    $0xc,%esp
80107603:	56                   	push   %esi
      return 0;
80107604:	31 f6                	xor    %esi,%esi
      freevm(pgdir);
80107606:	e8 15 ff ff ff       	call   80107520 <freevm>
      return 0;
8010760b:	83 c4 10             	add    $0x10,%esp
}
8010760e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107611:	89 f0                	mov    %esi,%eax
80107613:	5b                   	pop    %ebx
80107614:	5e                   	pop    %esi
80107615:	5d                   	pop    %ebp
80107616:	c3                   	ret    
80107617:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010761e:	66 90                	xchg   %ax,%ax

80107620 <kvmalloc>:
{
80107620:	f3 0f 1e fb          	endbr32 
80107624:	55                   	push   %ebp
80107625:	89 e5                	mov    %esp,%ebp
80107627:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
8010762a:	e8 71 ff ff ff       	call   801075a0 <setupkvm>
8010762f:	a3 e4 70 11 80       	mov    %eax,0x801170e4
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80107634:	05 00 00 00 80       	add    $0x80000000,%eax
80107639:	0f 22 d8             	mov    %eax,%cr3
}
8010763c:	c9                   	leave  
8010763d:	c3                   	ret    
8010763e:	66 90                	xchg   %ax,%ax

80107640 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80107640:	f3 0f 1e fb          	endbr32 
80107644:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107645:	31 c9                	xor    %ecx,%ecx
{
80107647:	89 e5                	mov    %esp,%ebp
80107649:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
8010764c:	8b 55 0c             	mov    0xc(%ebp),%edx
8010764f:	8b 45 08             	mov    0x8(%ebp),%eax
80107652:	e8 99 f8 ff ff       	call   80106ef0 <walkpgdir>
  if(pte == 0)
80107657:	85 c0                	test   %eax,%eax
80107659:	74 05                	je     80107660 <clearpteu+0x20>
    panic("clearpteu");
  *pte &= ~PTE_U;
8010765b:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
8010765e:	c9                   	leave  
8010765f:	c3                   	ret    
    panic("clearpteu");
80107660:	83 ec 0c             	sub    $0xc,%esp
80107663:	68 16 82 10 80       	push   $0x80108216
80107668:	e8 43 8d ff ff       	call   801003b0 <panic>
8010766d:	8d 76 00             	lea    0x0(%esi),%esi

80107670 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80107670:	f3 0f 1e fb          	endbr32 
80107674:	55                   	push   %ebp
80107675:	89 e5                	mov    %esp,%ebp
80107677:	57                   	push   %edi
80107678:	56                   	push   %esi
80107679:	53                   	push   %ebx
8010767a:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
8010767d:	e8 1e ff ff ff       	call   801075a0 <setupkvm>
80107682:	89 45 e0             	mov    %eax,-0x20(%ebp)
80107685:	85 c0                	test   %eax,%eax
80107687:	0f 84 9b 00 00 00    	je     80107728 <copyuvm+0xb8>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
8010768d:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80107690:	85 c9                	test   %ecx,%ecx
80107692:	0f 84 90 00 00 00    	je     80107728 <copyuvm+0xb8>
80107698:	31 f6                	xor    %esi,%esi
8010769a:	eb 46                	jmp    801076e2 <copyuvm+0x72>
8010769c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
801076a0:	83 ec 04             	sub    $0x4,%esp
801076a3:	81 c7 00 00 00 80    	add    $0x80000000,%edi
801076a9:	68 00 10 00 00       	push   $0x1000
801076ae:	57                   	push   %edi
801076af:	50                   	push   %eax
801076b0:	e8 0b d7 ff ff       	call   80104dc0 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
801076b5:	58                   	pop    %eax
801076b6:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801076bc:	5a                   	pop    %edx
801076bd:	ff 75 e4             	pushl  -0x1c(%ebp)
801076c0:	b9 00 10 00 00       	mov    $0x1000,%ecx
801076c5:	89 f2                	mov    %esi,%edx
801076c7:	50                   	push   %eax
801076c8:	8b 45 e0             	mov    -0x20(%ebp),%eax
801076cb:	e8 a0 f8 ff ff       	call   80106f70 <mappages>
801076d0:	83 c4 10             	add    $0x10,%esp
801076d3:	85 c0                	test   %eax,%eax
801076d5:	78 61                	js     80107738 <copyuvm+0xc8>
  for(i = 0; i < sz; i += PGSIZE){
801076d7:	81 c6 00 10 00 00    	add    $0x1000,%esi
801076dd:	39 75 0c             	cmp    %esi,0xc(%ebp)
801076e0:	76 46                	jbe    80107728 <copyuvm+0xb8>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
801076e2:	8b 45 08             	mov    0x8(%ebp),%eax
801076e5:	31 c9                	xor    %ecx,%ecx
801076e7:	89 f2                	mov    %esi,%edx
801076e9:	e8 02 f8 ff ff       	call   80106ef0 <walkpgdir>
801076ee:	85 c0                	test   %eax,%eax
801076f0:	74 61                	je     80107753 <copyuvm+0xe3>
    if(!(*pte & PTE_P))
801076f2:	8b 00                	mov    (%eax),%eax
801076f4:	a8 01                	test   $0x1,%al
801076f6:	74 4e                	je     80107746 <copyuvm+0xd6>
    pa = PTE_ADDR(*pte);
801076f8:	89 c7                	mov    %eax,%edi
    flags = PTE_FLAGS(*pte);
801076fa:	25 ff 0f 00 00       	and    $0xfff,%eax
801076ff:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    pa = PTE_ADDR(*pte);
80107702:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
    if((mem = kalloc()) == 0)
80107708:	e8 63 b5 ff ff       	call   80102c70 <kalloc>
8010770d:	89 c3                	mov    %eax,%ebx
8010770f:	85 c0                	test   %eax,%eax
80107711:	75 8d                	jne    801076a0 <copyuvm+0x30>
    }
  }
  return d;

bad:
  freevm(d);
80107713:	83 ec 0c             	sub    $0xc,%esp
80107716:	ff 75 e0             	pushl  -0x20(%ebp)
80107719:	e8 02 fe ff ff       	call   80107520 <freevm>
  return 0;
8010771e:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
80107725:	83 c4 10             	add    $0x10,%esp
}
80107728:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010772b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010772e:	5b                   	pop    %ebx
8010772f:	5e                   	pop    %esi
80107730:	5f                   	pop    %edi
80107731:	5d                   	pop    %ebp
80107732:	c3                   	ret    
80107733:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107737:	90                   	nop
      kfree(mem);
80107738:	83 ec 0c             	sub    $0xc,%esp
8010773b:	53                   	push   %ebx
8010773c:	e8 6f b3 ff ff       	call   80102ab0 <kfree>
      goto bad;
80107741:	83 c4 10             	add    $0x10,%esp
80107744:	eb cd                	jmp    80107713 <copyuvm+0xa3>
      panic("copyuvm: page not present");
80107746:	83 ec 0c             	sub    $0xc,%esp
80107749:	68 3a 82 10 80       	push   $0x8010823a
8010774e:	e8 5d 8c ff ff       	call   801003b0 <panic>
      panic("copyuvm: pte should exist");
80107753:	83 ec 0c             	sub    $0xc,%esp
80107756:	68 20 82 10 80       	push   $0x80108220
8010775b:	e8 50 8c ff ff       	call   801003b0 <panic>

80107760 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80107760:	f3 0f 1e fb          	endbr32 
80107764:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107765:	31 c9                	xor    %ecx,%ecx
{
80107767:	89 e5                	mov    %esp,%ebp
80107769:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
8010776c:	8b 55 0c             	mov    0xc(%ebp),%edx
8010776f:	8b 45 08             	mov    0x8(%ebp),%eax
80107772:	e8 79 f7 ff ff       	call   80106ef0 <walkpgdir>
  if((*pte & PTE_P) == 0)
80107777:	8b 00                	mov    (%eax),%eax
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
}
80107779:	c9                   	leave  
  if((*pte & PTE_U) == 0)
8010777a:	89 c2                	mov    %eax,%edx
  return (char*)P2V(PTE_ADDR(*pte));
8010777c:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((*pte & PTE_U) == 0)
80107781:	83 e2 05             	and    $0x5,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80107784:	05 00 00 00 80       	add    $0x80000000,%eax
80107789:	83 fa 05             	cmp    $0x5,%edx
8010778c:	ba 00 00 00 00       	mov    $0x0,%edx
80107791:	0f 45 c2             	cmovne %edx,%eax
}
80107794:	c3                   	ret    
80107795:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010779c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801077a0 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
801077a0:	f3 0f 1e fb          	endbr32 
801077a4:	55                   	push   %ebp
801077a5:	89 e5                	mov    %esp,%ebp
801077a7:	57                   	push   %edi
801077a8:	56                   	push   %esi
801077a9:	53                   	push   %ebx
801077aa:	83 ec 0c             	sub    $0xc,%esp
801077ad:	8b 75 14             	mov    0x14(%ebp),%esi
801077b0:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
801077b3:	85 f6                	test   %esi,%esi
801077b5:	75 3c                	jne    801077f3 <copyout+0x53>
801077b7:	eb 67                	jmp    80107820 <copyout+0x80>
801077b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
801077c0:	8b 55 0c             	mov    0xc(%ebp),%edx
801077c3:	89 fb                	mov    %edi,%ebx
801077c5:	29 d3                	sub    %edx,%ebx
801077c7:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    if(n > len)
801077cd:	39 f3                	cmp    %esi,%ebx
801077cf:	0f 47 de             	cmova  %esi,%ebx
      n = len;
    memmove(pa0 + (va - va0), buf, n);
801077d2:	29 fa                	sub    %edi,%edx
801077d4:	83 ec 04             	sub    $0x4,%esp
801077d7:	01 c2                	add    %eax,%edx
801077d9:	53                   	push   %ebx
801077da:	ff 75 10             	pushl  0x10(%ebp)
801077dd:	52                   	push   %edx
801077de:	e8 dd d5 ff ff       	call   80104dc0 <memmove>
    len -= n;
    buf += n;
801077e3:	01 5d 10             	add    %ebx,0x10(%ebp)
    va = va0 + PGSIZE;
801077e6:	8d 97 00 10 00 00    	lea    0x1000(%edi),%edx
  while(len > 0){
801077ec:	83 c4 10             	add    $0x10,%esp
801077ef:	29 de                	sub    %ebx,%esi
801077f1:	74 2d                	je     80107820 <copyout+0x80>
    va0 = (uint)PGROUNDDOWN(va);
801077f3:	89 d7                	mov    %edx,%edi
    pa0 = uva2ka(pgdir, (char*)va0);
801077f5:	83 ec 08             	sub    $0x8,%esp
    va0 = (uint)PGROUNDDOWN(va);
801077f8:	89 55 0c             	mov    %edx,0xc(%ebp)
801077fb:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
    pa0 = uva2ka(pgdir, (char*)va0);
80107801:	57                   	push   %edi
80107802:	ff 75 08             	pushl  0x8(%ebp)
80107805:	e8 56 ff ff ff       	call   80107760 <uva2ka>
    if(pa0 == 0)
8010780a:	83 c4 10             	add    $0x10,%esp
8010780d:	85 c0                	test   %eax,%eax
8010780f:	75 af                	jne    801077c0 <copyout+0x20>
  }
  return 0;
}
80107811:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80107814:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107819:	5b                   	pop    %ebx
8010781a:	5e                   	pop    %esi
8010781b:	5f                   	pop    %edi
8010781c:	5d                   	pop    %ebp
8010781d:	c3                   	ret    
8010781e:	66 90                	xchg   %ax,%ax
80107820:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80107823:	31 c0                	xor    %eax,%eax
}
80107825:	5b                   	pop    %ebx
80107826:	5e                   	pop    %esi
80107827:	5f                   	pop    %edi
80107828:	5d                   	pop    %ebp
80107829:	c3                   	ret    
