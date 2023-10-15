
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
80100028:	bc 10 71 11 80       	mov    $0x80117110,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
8010002d:	b8 10 37 10 80       	mov    $0x80103710,%eax
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
80100040:	55                   	push   %ebp
80100041:	89 e5                	mov    %esp,%ebp
80100043:	53                   	push   %ebx

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100044:	bb 54 b5 10 80       	mov    $0x8010b554,%ebx
{
80100049:	83 ec 0c             	sub    $0xc,%esp
  initlock(&bcache.lock, "bcache");
8010004c:	68 40 78 10 80       	push   $0x80107840
80100051:	68 20 b5 10 80       	push   $0x8010b520
80100056:	e8 25 4a 00 00       	call   80104a80 <initlock>
  bcache.head.next = &bcache.head;
8010005b:	83 c4 10             	add    $0x10,%esp
8010005e:	b8 1c fc 10 80       	mov    $0x8010fc1c,%eax
  bcache.head.prev = &bcache.head;
80100063:	c7 05 6c fc 10 80 1c 	movl   $0x8010fc1c,0x8010fc6c
8010006a:	fc 10 80 
  bcache.head.next = &bcache.head;
8010006d:	c7 05 70 fc 10 80 1c 	movl   $0x8010fc1c,0x8010fc70
80100074:	fc 10 80 
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100077:	eb 09                	jmp    80100082 <binit+0x42>
80100079:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100080:	89 d3                	mov    %edx,%ebx
    b->next = bcache.head.next;
80100082:	89 43 54             	mov    %eax,0x54(%ebx)
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
80100085:	83 ec 08             	sub    $0x8,%esp
80100088:	8d 43 0c             	lea    0xc(%ebx),%eax
    b->prev = &bcache.head;
8010008b:	c7 43 50 1c fc 10 80 	movl   $0x8010fc1c,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
80100092:	68 47 78 10 80       	push   $0x80107847
80100097:	50                   	push   %eax
80100098:	e8 b3 48 00 00       	call   80104950 <initsleeplock>
    bcache.head.next->prev = b;
8010009d:	a1 70 fc 10 80       	mov    0x8010fc70,%eax
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000a2:	8d 93 5c 02 00 00    	lea    0x25c(%ebx),%edx
801000a8:	83 c4 10             	add    $0x10,%esp
    bcache.head.next->prev = b;
801000ab:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
801000ae:	89 d8                	mov    %ebx,%eax
801000b0:	89 1d 70 fc 10 80    	mov    %ebx,0x8010fc70
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000b6:	81 fb c0 f9 10 80    	cmp    $0x8010f9c0,%ebx
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
801000d0:	55                   	push   %ebp
801000d1:	89 e5                	mov    %esp,%ebp
801000d3:	57                   	push   %edi
801000d4:	56                   	push   %esi
801000d5:	53                   	push   %ebx
801000d6:	83 ec 18             	sub    $0x18,%esp
801000d9:	8b 75 08             	mov    0x8(%ebp),%esi
801000dc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  acquire(&bcache.lock);
801000df:	68 20 b5 10 80       	push   $0x8010b520
801000e4:	e8 67 4b 00 00       	call   80104c50 <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000e9:	8b 1d 70 fc 10 80    	mov    0x8010fc70,%ebx
801000ef:	83 c4 10             	add    $0x10,%esp
801000f2:	81 fb 1c fc 10 80    	cmp    $0x8010fc1c,%ebx
801000f8:	75 11                	jne    8010010b <bread+0x3b>
801000fa:	eb 24                	jmp    80100120 <bread+0x50>
801000fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100100:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100103:	81 fb 1c fc 10 80    	cmp    $0x8010fc1c,%ebx
80100109:	74 15                	je     80100120 <bread+0x50>
    if(b->dev == dev && b->blockno == blockno){
8010010b:	3b 73 04             	cmp    0x4(%ebx),%esi
8010010e:	75 f0                	jne    80100100 <bread+0x30>
80100110:	3b 7b 08             	cmp    0x8(%ebx),%edi
80100113:	75 eb                	jne    80100100 <bread+0x30>
      b->refcnt++;
80100115:	83 43 4c 01          	addl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
80100119:	eb 3f                	jmp    8010015a <bread+0x8a>
8010011b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010011f:	90                   	nop
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100120:	8b 1d 6c fc 10 80    	mov    0x8010fc6c,%ebx
80100126:	81 fb 1c fc 10 80    	cmp    $0x8010fc1c,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x6b>
8010012e:	eb 6e                	jmp    8010019e <bread+0xce>
80100130:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100133:	81 fb 1c fc 10 80    	cmp    $0x8010fc1c,%ebx
80100139:	74 63                	je     8010019e <bread+0xce>
    if(b->refcnt == 0 && (b->flags & B_DIRTY) == 0) {
8010013b:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010013e:	85 c0                	test   %eax,%eax
80100140:	75 ee                	jne    80100130 <bread+0x60>
80100142:	f6 03 04             	testb  $0x4,(%ebx)
80100145:	75 e9                	jne    80100130 <bread+0x60>
      b->dev = dev;
80100147:	89 73 04             	mov    %esi,0x4(%ebx)
      b->blockno = blockno;
8010014a:	89 7b 08             	mov    %edi,0x8(%ebx)
      b->flags = 0;
8010014d:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
      b->refcnt = 1;
80100153:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
8010015a:	83 ec 0c             	sub    $0xc,%esp
8010015d:	68 20 b5 10 80       	push   $0x8010b520
80100162:	e8 89 4a 00 00       	call   80104bf0 <release>
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
8010018c:	e8 ff 27 00 00       	call   80102990 <iderw>
80100191:	83 c4 10             	add    $0x10,%esp
}
80100194:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100197:	89 d8                	mov    %ebx,%eax
80100199:	5b                   	pop    %ebx
8010019a:	5e                   	pop    %esi
8010019b:	5f                   	pop    %edi
8010019c:	5d                   	pop    %ebp
8010019d:	c3                   	ret    
  panic("bget: no buffers");
8010019e:	83 ec 0c             	sub    $0xc,%esp
801001a1:	68 4e 78 10 80       	push   $0x8010784e
801001a6:	e8 f5 01 00 00       	call   801003a0 <panic>
801001ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801001af:	90                   	nop

801001b0 <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
801001b0:	55                   	push   %ebp
801001b1:	89 e5                	mov    %esp,%ebp
801001b3:	53                   	push   %ebx
801001b4:	83 ec 10             	sub    $0x10,%esp
801001b7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001ba:	8d 43 0c             	lea    0xc(%ebx),%eax
801001bd:	50                   	push   %eax
801001be:	e8 6d 48 00 00       	call   80104a30 <holdingsleep>
801001c3:	83 c4 10             	add    $0x10,%esp
801001c6:	85 c0                	test   %eax,%eax
801001c8:	74 0f                	je     801001d9 <bwrite+0x29>
    panic("bwrite");
  b->flags |= B_DIRTY;
801001ca:	83 0b 04             	orl    $0x4,(%ebx)
  iderw(b);
801001cd:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801001d0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801001d3:	c9                   	leave  
  iderw(b);
801001d4:	e9 b7 27 00 00       	jmp    80102990 <iderw>
    panic("bwrite");
801001d9:	83 ec 0c             	sub    $0xc,%esp
801001dc:	68 5f 78 10 80       	push   $0x8010785f
801001e1:	e8 ba 01 00 00       	call   801003a0 <panic>
801001e6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801001ed:	8d 76 00             	lea    0x0(%esi),%esi

801001f0 <brelse>:

// Release a locked buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
801001f0:	55                   	push   %ebp
801001f1:	89 e5                	mov    %esp,%ebp
801001f3:	56                   	push   %esi
801001f4:	53                   	push   %ebx
801001f5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001f8:	8d 73 0c             	lea    0xc(%ebx),%esi
801001fb:	83 ec 0c             	sub    $0xc,%esp
801001fe:	56                   	push   %esi
801001ff:	e8 2c 48 00 00       	call   80104a30 <holdingsleep>
80100204:	83 c4 10             	add    $0x10,%esp
80100207:	85 c0                	test   %eax,%eax
80100209:	74 66                	je     80100271 <brelse+0x81>
    panic("brelse");

  releasesleep(&b->lock);
8010020b:	83 ec 0c             	sub    $0xc,%esp
8010020e:	56                   	push   %esi
8010020f:	e8 dc 47 00 00       	call   801049f0 <releasesleep>

  acquire(&bcache.lock);
80100214:	c7 04 24 20 b5 10 80 	movl   $0x8010b520,(%esp)
8010021b:	e8 30 4a 00 00       	call   80104c50 <acquire>
  b->refcnt--;
80100220:	8b 43 4c             	mov    0x4c(%ebx),%eax
  if (b->refcnt == 0) {
80100223:	83 c4 10             	add    $0x10,%esp
  b->refcnt--;
80100226:	83 e8 01             	sub    $0x1,%eax
80100229:	89 43 4c             	mov    %eax,0x4c(%ebx)
  if (b->refcnt == 0) {
8010022c:	85 c0                	test   %eax,%eax
8010022e:	75 2f                	jne    8010025f <brelse+0x6f>
    // no one is waiting for it.
    b->next->prev = b->prev;
80100230:	8b 43 54             	mov    0x54(%ebx),%eax
80100233:	8b 53 50             	mov    0x50(%ebx),%edx
80100236:	89 50 50             	mov    %edx,0x50(%eax)
    b->prev->next = b->next;
80100239:	8b 43 50             	mov    0x50(%ebx),%eax
8010023c:	8b 53 54             	mov    0x54(%ebx),%edx
8010023f:	89 50 54             	mov    %edx,0x54(%eax)
    b->next = bcache.head.next;
80100242:	a1 70 fc 10 80       	mov    0x8010fc70,%eax
    b->prev = &bcache.head;
80100247:	c7 43 50 1c fc 10 80 	movl   $0x8010fc1c,0x50(%ebx)
    b->next = bcache.head.next;
8010024e:	89 43 54             	mov    %eax,0x54(%ebx)
    bcache.head.next->prev = b;
80100251:	a1 70 fc 10 80       	mov    0x8010fc70,%eax
80100256:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
80100259:	89 1d 70 fc 10 80    	mov    %ebx,0x8010fc70
  }
  
  release(&bcache.lock);
8010025f:	c7 45 08 20 b5 10 80 	movl   $0x8010b520,0x8(%ebp)
}
80100266:	8d 65 f8             	lea    -0x8(%ebp),%esp
80100269:	5b                   	pop    %ebx
8010026a:	5e                   	pop    %esi
8010026b:	5d                   	pop    %ebp
  release(&bcache.lock);
8010026c:	e9 7f 49 00 00       	jmp    80104bf0 <release>
    panic("brelse");
80100271:	83 ec 0c             	sub    $0xc,%esp
80100274:	68 66 78 10 80       	push   $0x80107866
80100279:	e8 22 01 00 00       	call   801003a0 <panic>
8010027e:	66 90                	xchg   %ax,%ax

80100280 <consoleread>:
    procdump(); // now call procdump() wo. cons.lock held
  }
}

int consoleread(struct inode *ip, char *dst, int n)
{
80100280:	55                   	push   %ebp
80100281:	89 e5                	mov    %esp,%ebp
80100283:	57                   	push   %edi
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
    }
    c = input.buf[input.r++ % INPUT_BUF];
80100284:	bf d3 20 0d d2       	mov    $0xd20d20d3,%edi
{
80100289:	56                   	push   %esi
8010028a:	53                   	push   %ebx
8010028b:	83 ec 28             	sub    $0x28,%esp
8010028e:	8b 5d 10             	mov    0x10(%ebp),%ebx
80100291:	8b 75 0c             	mov    0xc(%ebp),%esi
  iunlock(ip);
80100294:	ff 75 08             	push   0x8(%ebp)
80100297:	e8 74 1c 00 00       	call   80101f10 <iunlock>
  acquire(&cons.lock);
8010029c:	c7 04 24 60 0b 11 80 	movl   $0x80110b60,(%esp)
  target = n;
801002a3:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
  acquire(&cons.lock);
801002a6:	e8 a5 49 00 00       	call   80104c50 <acquire>
  while (n > 0)
801002ab:	83 c4 10             	add    $0x10,%esp
801002ae:	85 db                	test   %ebx,%ebx
801002b0:	0f 8e aa 00 00 00    	jle    80100360 <consoleread+0xe0>
    while (input.r == input.w)
801002b6:	8b 0d d0 fe 10 80    	mov    0x8010fed0,%ecx
801002bc:	3b 0d d4 fe 10 80    	cmp    0x8010fed4,%ecx
801002c2:	74 2f                	je     801002f3 <consoleread+0x73>
801002c4:	eb 62                	jmp    80100328 <consoleread+0xa8>
801002c6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801002cd:	8d 76 00             	lea    0x0(%esi),%esi
      sleep(&input.r, &cons.lock);
801002d0:	83 ec 08             	sub    $0x8,%esp
801002d3:	68 60 0b 11 80       	push   $0x80110b60
801002d8:	68 d0 fe 10 80       	push   $0x8010fed0
801002dd:	e8 0e 44 00 00       	call   801046f0 <sleep>
    while (input.r == input.w)
801002e2:	8b 0d d0 fe 10 80    	mov    0x8010fed0,%ecx
801002e8:	83 c4 10             	add    $0x10,%esp
801002eb:	3b 0d d4 fe 10 80    	cmp    0x8010fed4,%ecx
801002f1:	75 35                	jne    80100328 <consoleread+0xa8>
      if (myproc()->killed)
801002f3:	e8 28 3d 00 00       	call   80104020 <myproc>
801002f8:	8b 48 24             	mov    0x24(%eax),%ecx
801002fb:	85 c9                	test   %ecx,%ecx
801002fd:	74 d1                	je     801002d0 <consoleread+0x50>
        release(&cons.lock);
801002ff:	83 ec 0c             	sub    $0xc,%esp
80100302:	68 60 0b 11 80       	push   $0x80110b60
80100307:	e8 e4 48 00 00       	call   80104bf0 <release>
        ilock(ip);
8010030c:	5a                   	pop    %edx
8010030d:	ff 75 08             	push   0x8(%ebp)
80100310:	e8 1b 1b 00 00       	call   80101e30 <ilock>
        return -1;
80100315:	83 c4 10             	add    $0x10,%esp
  }
  release(&cons.lock);
  ilock(ip);

  return target - n;
}
80100318:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return -1;
8010031b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100320:	5b                   	pop    %ebx
80100321:	5e                   	pop    %esi
80100322:	5f                   	pop    %edi
80100323:	5d                   	pop    %ebp
80100324:	c3                   	ret    
80100325:	8d 76 00             	lea    0x0(%esi),%esi
    c = input.buf[input.r++ % INPUT_BUF];
80100328:	89 ca                	mov    %ecx,%edx
8010032a:	8d 41 01             	lea    0x1(%ecx),%eax
8010032d:	d1 ea                	shr    %edx
8010032f:	a3 d0 fe 10 80       	mov    %eax,0x8010fed0
80100334:	89 d0                	mov    %edx,%eax
80100336:	f7 e7                	mul    %edi
80100338:	89 c8                	mov    %ecx,%eax
8010033a:	c1 ea 05             	shr    $0x5,%edx
8010033d:	6b d2 4e             	imul   $0x4e,%edx,%edx
80100340:	29 d0                	sub    %edx,%eax
80100342:	0f be 90 80 fe 10 80 	movsbl -0x7fef0180(%eax),%edx
    if (c == C('D'))
80100349:	80 fa 04             	cmp    $0x4,%dl
8010034c:	74 38                	je     80100386 <consoleread+0x106>
    *dst++ = c;
8010034e:	83 c6 01             	add    $0x1,%esi
    --n;
80100351:	83 eb 01             	sub    $0x1,%ebx
    *dst++ = c;
80100354:	88 56 ff             	mov    %dl,-0x1(%esi)
    if (c == '\n')
80100357:	83 fa 0a             	cmp    $0xa,%edx
8010035a:	0f 85 4e ff ff ff    	jne    801002ae <consoleread+0x2e>
  release(&cons.lock);
80100360:	83 ec 0c             	sub    $0xc,%esp
80100363:	68 60 0b 11 80       	push   $0x80110b60
80100368:	e8 83 48 00 00       	call   80104bf0 <release>
  ilock(ip);
8010036d:	58                   	pop    %eax
8010036e:	ff 75 08             	push   0x8(%ebp)
80100371:	e8 ba 1a 00 00       	call   80101e30 <ilock>
  return target - n;
80100376:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100379:	83 c4 10             	add    $0x10,%esp
}
8010037c:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return target - n;
8010037f:	29 d8                	sub    %ebx,%eax
}
80100381:	5b                   	pop    %ebx
80100382:	5e                   	pop    %esi
80100383:	5f                   	pop    %edi
80100384:	5d                   	pop    %ebp
80100385:	c3                   	ret    
      if (n < target)
80100386:	3b 5d e4             	cmp    -0x1c(%ebp),%ebx
80100389:	73 d5                	jae    80100360 <consoleread+0xe0>
        input.r--;
8010038b:	89 0d d0 fe 10 80    	mov    %ecx,0x8010fed0
80100391:	eb cd                	jmp    80100360 <consoleread+0xe0>
80100393:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010039a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801003a0 <panic>:
{
801003a0:	55                   	push   %ebp
801003a1:	89 e5                	mov    %esp,%ebp
801003a3:	56                   	push   %esi
801003a4:	53                   	push   %ebx
801003a5:	83 ec 30             	sub    $0x30,%esp
}

static inline void
cli(void)
{
  asm volatile("cli");
801003a8:	fa                   	cli    
  cons.locking = 0;
801003a9:	c7 05 94 0b 11 80 00 	movl   $0x0,0x80110b94
801003b0:	00 00 00 
  getcallerpcs(&s, pcs);
801003b3:	8d 5d d0             	lea    -0x30(%ebp),%ebx
801003b6:	8d 75 f8             	lea    -0x8(%ebp),%esi
  cprintf("lapicid %d: panic: ", lapicid());
801003b9:	e8 e2 2b 00 00       	call   80102fa0 <lapicid>
801003be:	83 ec 08             	sub    $0x8,%esp
801003c1:	50                   	push   %eax
801003c2:	68 6d 78 10 80       	push   $0x8010786d
801003c7:	e8 84 03 00 00       	call   80100750 <cprintf>
  cprintf(s);
801003cc:	58                   	pop    %eax
801003cd:	ff 75 08             	push   0x8(%ebp)
801003d0:	e8 7b 03 00 00       	call   80100750 <cprintf>
  cprintf("\n");
801003d5:	c7 04 24 f7 81 10 80 	movl   $0x801081f7,(%esp)
801003dc:	e8 6f 03 00 00       	call   80100750 <cprintf>
  getcallerpcs(&s, pcs);
801003e1:	8d 45 08             	lea    0x8(%ebp),%eax
801003e4:	5a                   	pop    %edx
801003e5:	59                   	pop    %ecx
801003e6:	53                   	push   %ebx
801003e7:	50                   	push   %eax
801003e8:	e8 b3 46 00 00       	call   80104aa0 <getcallerpcs>
  for (i = 0; i < 10; i++)
801003ed:	83 c4 10             	add    $0x10,%esp
    cprintf(" %p", pcs[i]);
801003f0:	83 ec 08             	sub    $0x8,%esp
801003f3:	ff 33                	push   (%ebx)
  for (i = 0; i < 10; i++)
801003f5:	83 c3 04             	add    $0x4,%ebx
    cprintf(" %p", pcs[i]);
801003f8:	68 81 78 10 80       	push   $0x80107881
801003fd:	e8 4e 03 00 00       	call   80100750 <cprintf>
  for (i = 0; i < 10; i++)
80100402:	83 c4 10             	add    $0x10,%esp
80100405:	39 f3                	cmp    %esi,%ebx
80100407:	75 e7                	jne    801003f0 <panic+0x50>
  panicked = 1; // freeze other CPU
80100409:	c7 05 98 0b 11 80 01 	movl   $0x1,0x80110b98
80100410:	00 00 00 
  for (;;)
80100413:	eb fe                	jmp    80100413 <panic+0x73>
80100415:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010041c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100420 <cgaputc>:
{
80100420:	55                   	push   %ebp
80100421:	89 e5                	mov    %esp,%ebp
80100423:	57                   	push   %edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100424:	bf d4 03 00 00       	mov    $0x3d4,%edi
80100429:	56                   	push   %esi
8010042a:	89 fa                	mov    %edi,%edx
8010042c:	89 c6                	mov    %eax,%esi
8010042e:	b8 0e 00 00 00       	mov    $0xe,%eax
80100433:	53                   	push   %ebx
80100434:	83 ec 0c             	sub    $0xc,%esp
80100437:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100438:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
8010043d:	89 ca                	mov    %ecx,%edx
8010043f:	ec                   	in     (%dx),%al
  pos = inb(CRTPORT + 1) << 8;
80100440:	0f b6 d8             	movzbl %al,%ebx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100443:	89 fa                	mov    %edi,%edx
80100445:	b8 0f 00 00 00       	mov    $0xf,%eax
8010044a:	c1 e3 08             	shl    $0x8,%ebx
8010044d:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010044e:	89 ca                	mov    %ecx,%edx
80100450:	ec                   	in     (%dx),%al
  pos |= inb(CRTPORT + 1);
80100451:	0f b6 c8             	movzbl %al,%ecx
80100454:	09 d9                	or     %ebx,%ecx
  if (c == '\n')
80100456:	83 fe 0a             	cmp    $0xa,%esi
80100459:	0f 84 31 01 00 00    	je     80100590 <cgaputc+0x170>
  else if (c == BACKSPACE)
8010045f:	81 fe 00 01 00 00    	cmp    $0x100,%esi
80100465:	0f 84 e5 00 00 00    	je     80100550 <cgaputc+0x130>
  else if (c == BACKWARD)
8010046b:	81 fe 01 01 00 00    	cmp    $0x101,%esi
80100471:	0f 84 39 01 00 00    	je     801005b0 <cgaputc+0x190>
    ++pos;
80100477:	8d 59 01             	lea    0x1(%ecx),%ebx
  else if (c == FORWARD)
8010047a:	81 fe 02 01 00 00    	cmp    $0x102,%esi
80100480:	74 49                	je     801004cb <cgaputc+0xab>
  else if (c == CLEAR)
80100482:	81 fe 03 01 00 00    	cmp    $0x103,%esi
80100488:	0f 84 3a 01 00 00    	je     801005c8 <cgaputc+0x1a8>
    for (int i = 25 * 80 - 1; i > pos; i--)
8010048e:	8d 9c 09 fe 7f 0b 80 	lea    -0x7ff48002(%ecx,%ecx,1),%ebx
80100495:	b8 9c 8f 0b 80       	mov    $0x800b8f9c,%eax
8010049a:	81 f9 ce 07 00 00    	cmp    $0x7ce,%ecx
801004a0:	7f 14                	jg     801004b6 <cgaputc+0x96>
801004a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      crt[i] = crt[i - 1];
801004a8:	0f b7 10             	movzwl (%eax),%edx
    for (int i = 25 * 80 - 1; i > pos; i--)
801004ab:	83 e8 02             	sub    $0x2,%eax
      crt[i] = crt[i - 1];
801004ae:	66 89 50 04          	mov    %dx,0x4(%eax)
    for (int i = 25 * 80 - 1; i > pos; i--)
801004b2:	39 c3                	cmp    %eax,%ebx
801004b4:	75 f2                	jne    801004a8 <cgaputc+0x88>
    crt[pos++] = (c & 0xff) | 0x0700;
801004b6:	89 f0                	mov    %esi,%eax
801004b8:	8d 59 01             	lea    0x1(%ecx),%ebx
801004bb:	0f b6 f0             	movzbl %al,%esi
801004be:	66 81 ce 00 07       	or     $0x700,%si
801004c3:	66 89 b4 09 00 80 0b 	mov    %si,-0x7ff48000(%ecx,%ecx,1)
801004ca:	80 
  if (pos < 0 || pos > 25 * 80)
801004cb:	81 fb d0 07 00 00    	cmp    $0x7d0,%ebx
801004d1:	0f 8f 3b 01 00 00    	jg     80100612 <cgaputc+0x1f2>
  outb(CRTPORT + 1, pos >> 8);
801004d7:	0f b6 f7             	movzbl %bh,%esi
  if ((pos / 80) >= 24)
801004da:	81 fb 7f 07 00 00    	cmp    $0x77f,%ebx
801004e0:	7e 3e                	jle    80100520 <cgaputc+0x100>
    memmove(crt, crt + 80, sizeof(crt[0]) * 23 * 80);
801004e2:	83 ec 04             	sub    $0x4,%esp
    pos -= 80;
801004e5:	83 eb 50             	sub    $0x50,%ebx
  outb(CRTPORT + 1, pos);
801004e8:	be 07 00 00 00       	mov    $0x7,%esi
    memmove(crt, crt + 80, sizeof(crt[0]) * 23 * 80);
801004ed:	68 60 0e 00 00       	push   $0xe60
801004f2:	68 a0 80 0b 80       	push   $0x800b80a0
801004f7:	68 00 80 0b 80       	push   $0x800b8000
801004fc:	e8 af 48 00 00       	call   80104db0 <memmove>
    memset(crt + pos, 0, sizeof(crt[0]) * (24 * 80 - pos));
80100501:	b8 80 07 00 00       	mov    $0x780,%eax
80100506:	83 c4 0c             	add    $0xc,%esp
80100509:	29 d8                	sub    %ebx,%eax
8010050b:	01 c0                	add    %eax,%eax
8010050d:	50                   	push   %eax
8010050e:	8d 84 1b 00 80 0b 80 	lea    -0x7ff48000(%ebx,%ebx,1),%eax
80100515:	6a 00                	push   $0x0
80100517:	50                   	push   %eax
80100518:	e8 f3 47 00 00       	call   80104d10 <memset>
  outb(CRTPORT + 1, pos);
8010051d:	83 c4 10             	add    $0x10,%esp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100520:	bf d4 03 00 00       	mov    $0x3d4,%edi
80100525:	b8 0e 00 00 00       	mov    $0xe,%eax
8010052a:	89 fa                	mov    %edi,%edx
8010052c:	ee                   	out    %al,(%dx)
8010052d:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
80100532:	89 f0                	mov    %esi,%eax
80100534:	89 ca                	mov    %ecx,%edx
80100536:	ee                   	out    %al,(%dx)
80100537:	b8 0f 00 00 00       	mov    $0xf,%eax
8010053c:	89 fa                	mov    %edi,%edx
8010053e:	ee                   	out    %al,(%dx)
8010053f:	89 d8                	mov    %ebx,%eax
80100541:	89 ca                	mov    %ecx,%edx
80100543:	ee                   	out    %al,(%dx)
}
80100544:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100547:	5b                   	pop    %ebx
80100548:	5e                   	pop    %esi
80100549:	5f                   	pop    %edi
8010054a:	5d                   	pop    %ebp
8010054b:	c3                   	ret    
8010054c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if (pos > 0)
80100550:	85 c9                	test   %ecx,%ecx
80100552:	74 67                	je     801005bb <cgaputc+0x19b>
      --pos;
80100554:	8d 59 ff             	lea    -0x1(%ecx),%ebx
      for (int i = pos; i < 25 * 80 - 1; i++)
80100557:	81 fb ce 07 00 00    	cmp    $0x7ce,%ebx
8010055d:	0f 8f 68 ff ff ff    	jg     801004cb <cgaputc+0xab>
80100563:	8d 94 09 00 80 0b 80 	lea    -0x7ff48000(%ecx,%ecx,1),%edx
8010056a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        crt[i] = crt[i + 1];
80100570:	0f b7 02             	movzwl (%edx),%eax
      for (int i = pos; i < 25 * 80 - 1; i++)
80100573:	83 c2 02             	add    $0x2,%edx
        crt[i] = crt[i + 1];
80100576:	66 89 42 fc          	mov    %ax,-0x4(%edx)
      for (int i = pos; i < 25 * 80 - 1; i++)
8010057a:	81 fa a0 8f 0b 80    	cmp    $0x800b8fa0,%edx
80100580:	75 ee                	jne    80100570 <cgaputc+0x150>
80100582:	e9 50 ff ff ff       	jmp    801004d7 <cgaputc+0xb7>
80100587:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010058e:	66 90                	xchg   %ax,%ax
    pos += 80 - pos % 80;
80100590:	89 c8                	mov    %ecx,%eax
80100592:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
80100597:	f7 e2                	mul    %edx
80100599:	c1 ea 06             	shr    $0x6,%edx
8010059c:	8d 04 92             	lea    (%edx,%edx,4),%eax
8010059f:	c1 e0 04             	shl    $0x4,%eax
801005a2:	8d 58 50             	lea    0x50(%eax),%ebx
801005a5:	e9 21 ff ff ff       	jmp    801004cb <cgaputc+0xab>
801005aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      --pos;
801005b0:	8d 59 ff             	lea    -0x1(%ecx),%ebx
    if (pos > 0)
801005b3:	85 c9                	test   %ecx,%ecx
801005b5:	0f 85 10 ff ff ff    	jne    801004cb <cgaputc+0xab>
801005bb:	31 db                	xor    %ebx,%ebx
801005bd:	31 f6                	xor    %esi,%esi
801005bf:	e9 5c ff ff ff       	jmp    80100520 <cgaputc+0x100>
801005c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    int rows = pos / 80;
801005c8:	89 c8                	mov    %ecx,%eax
801005ca:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
    memmove(crt, crt + rows * 80, sizeof(crt[0]) * 2);
801005cf:	83 ec 04             	sub    $0x4,%esp
    memset(crt + pos, 0, sizeof(crt[0]) * (25 * 80 - pos));
801005d2:	bb 02 00 00 00       	mov    $0x2,%ebx
    int rows = pos / 80;
801005d7:	f7 e2                	mul    %edx
    memmove(crt, crt + rows * 80, sizeof(crt[0]) * 2);
801005d9:	6a 04                	push   $0x4
    memset(crt + pos, 0, sizeof(crt[0]) * (25 * 80 - pos));
801005db:	31 f6                	xor    %esi,%esi
    int rows = pos / 80;
801005dd:	c1 ea 06             	shr    $0x6,%edx
    memmove(crt, crt + rows * 80, sizeof(crt[0]) * 2);
801005e0:	8d 04 92             	lea    (%edx,%edx,4),%eax
801005e3:	c1 e0 05             	shl    $0x5,%eax
801005e6:	2d 00 80 f4 7f       	sub    $0x7ff48000,%eax
801005eb:	50                   	push   %eax
801005ec:	68 00 80 0b 80       	push   $0x800b8000
801005f1:	e8 ba 47 00 00       	call   80104db0 <memmove>
    memset(crt + pos, 0, sizeof(crt[0]) * (25 * 80 - pos));
801005f6:	83 c4 0c             	add    $0xc,%esp
801005f9:	68 9c 0f 00 00       	push   $0xf9c
801005fe:	6a 00                	push   $0x0
80100600:	68 04 80 0b 80       	push   $0x800b8004
80100605:	e8 06 47 00 00       	call   80104d10 <memset>
8010060a:	83 c4 10             	add    $0x10,%esp
8010060d:	e9 0e ff ff ff       	jmp    80100520 <cgaputc+0x100>
    panic("pos under/overflow");
80100612:	83 ec 0c             	sub    $0xc,%esp
80100615:	68 85 78 10 80       	push   $0x80107885
8010061a:	e8 81 fd ff ff       	call   801003a0 <panic>
8010061f:	90                   	nop

80100620 <consolewrite>:

int consolewrite(struct inode *ip, char *buf, int n)
{
80100620:	55                   	push   %ebp
80100621:	89 e5                	mov    %esp,%ebp
80100623:	57                   	push   %edi
80100624:	56                   	push   %esi
80100625:	53                   	push   %ebx
80100626:	83 ec 28             	sub    $0x28,%esp
  int i;

  iunlock(ip);
80100629:	ff 75 08             	push   0x8(%ebp)
{
8010062c:	8b 75 10             	mov    0x10(%ebp),%esi
  iunlock(ip);
8010062f:	e8 dc 18 00 00       	call   80101f10 <iunlock>
  acquire(&cons.lock);
80100634:	c7 04 24 60 0b 11 80 	movl   $0x80110b60,(%esp)
8010063b:	e8 10 46 00 00       	call   80104c50 <acquire>
  for (i = 0; i < n; i++)
80100640:	83 c4 10             	add    $0x10,%esp
80100643:	85 f6                	test   %esi,%esi
80100645:	7e 37                	jle    8010067e <consolewrite+0x5e>
80100647:	8b 5d 0c             	mov    0xc(%ebp),%ebx
8010064a:	8d 3c 33             	lea    (%ebx,%esi,1),%edi
  if (panicked)
8010064d:	8b 15 98 0b 11 80    	mov    0x80110b98,%edx
    consputc(buf[i] & 0xff);
80100653:	0f b6 03             	movzbl (%ebx),%eax
  if (panicked)
80100656:	85 d2                	test   %edx,%edx
80100658:	74 06                	je     80100660 <consolewrite+0x40>
  asm volatile("cli");
8010065a:	fa                   	cli    
    for (;;)
8010065b:	eb fe                	jmp    8010065b <consolewrite+0x3b>
8010065d:	8d 76 00             	lea    0x0(%esi),%esi
    uartputc(c);
80100660:	83 ec 0c             	sub    $0xc,%esp
80100663:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for (i = 0; i < n; i++)
80100666:	83 c3 01             	add    $0x1,%ebx
    uartputc(c);
80100669:	50                   	push   %eax
8010066a:	e8 f1 5c 00 00       	call   80106360 <uartputc>
  cgaputc(c);
8010066f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100672:	e8 a9 fd ff ff       	call   80100420 <cgaputc>
  for (i = 0; i < n; i++)
80100677:	83 c4 10             	add    $0x10,%esp
8010067a:	39 df                	cmp    %ebx,%edi
8010067c:	75 cf                	jne    8010064d <consolewrite+0x2d>
  release(&cons.lock);
8010067e:	83 ec 0c             	sub    $0xc,%esp
80100681:	68 60 0b 11 80       	push   $0x80110b60
80100686:	e8 65 45 00 00       	call   80104bf0 <release>
  ilock(ip);
8010068b:	58                   	pop    %eax
8010068c:	ff 75 08             	push   0x8(%ebp)
8010068f:	e8 9c 17 00 00       	call   80101e30 <ilock>

  return n;
}
80100694:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100697:	89 f0                	mov    %esi,%eax
80100699:	5b                   	pop    %ebx
8010069a:	5e                   	pop    %esi
8010069b:	5f                   	pop    %edi
8010069c:	5d                   	pop    %ebp
8010069d:	c3                   	ret    
8010069e:	66 90                	xchg   %ax,%ax

801006a0 <printint>:
{
801006a0:	55                   	push   %ebp
801006a1:	89 e5                	mov    %esp,%ebp
801006a3:	57                   	push   %edi
801006a4:	56                   	push   %esi
801006a5:	53                   	push   %ebx
801006a6:	83 ec 2c             	sub    $0x2c,%esp
801006a9:	89 55 d4             	mov    %edx,-0x2c(%ebp)
801006ac:	89 4d d0             	mov    %ecx,-0x30(%ebp)
  if (sign && (sign = xx < 0))
801006af:	85 c9                	test   %ecx,%ecx
801006b1:	74 04                	je     801006b7 <printint+0x17>
801006b3:	85 c0                	test   %eax,%eax
801006b5:	78 7e                	js     80100735 <printint+0x95>
    x = xx;
801006b7:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
801006be:	89 c1                	mov    %eax,%ecx
  i = 0;
801006c0:	31 db                	xor    %ebx,%ebx
801006c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    buf[i++] = digits[x % base];
801006c8:	89 c8                	mov    %ecx,%eax
801006ca:	31 d2                	xor    %edx,%edx
801006cc:	89 de                	mov    %ebx,%esi
801006ce:	89 cf                	mov    %ecx,%edi
801006d0:	f7 75 d4             	divl   -0x2c(%ebp)
801006d3:	8d 5b 01             	lea    0x1(%ebx),%ebx
801006d6:	0f b6 92 08 79 10 80 	movzbl -0x7fef86f8(%edx),%edx
  } while ((x /= base) != 0);
801006dd:	89 c1                	mov    %eax,%ecx
    buf[i++] = digits[x % base];
801006df:	88 54 1d d7          	mov    %dl,-0x29(%ebp,%ebx,1)
  } while ((x /= base) != 0);
801006e3:	3b 7d d4             	cmp    -0x2c(%ebp),%edi
801006e6:	73 e0                	jae    801006c8 <printint+0x28>
  if (sign)
801006e8:	8b 4d d0             	mov    -0x30(%ebp),%ecx
801006eb:	85 c9                	test   %ecx,%ecx
801006ed:	74 0c                	je     801006fb <printint+0x5b>
    buf[i++] = '-';
801006ef:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
801006f4:	89 de                	mov    %ebx,%esi
    buf[i++] = '-';
801006f6:	ba 2d 00 00 00       	mov    $0x2d,%edx
  while (--i >= 0)
801006fb:	8d 5c 35 d7          	lea    -0x29(%ebp,%esi,1),%ebx
  if (panicked)
801006ff:	a1 98 0b 11 80       	mov    0x80110b98,%eax
80100704:	85 c0                	test   %eax,%eax
80100706:	74 08                	je     80100710 <printint+0x70>
80100708:	fa                   	cli    
    for (;;)
80100709:	eb fe                	jmp    80100709 <printint+0x69>
8010070b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010070f:	90                   	nop
    consputc(buf[i]);
80100710:	0f be f2             	movsbl %dl,%esi
    uartputc(c);
80100713:	83 ec 0c             	sub    $0xc,%esp
80100716:	56                   	push   %esi
80100717:	e8 44 5c 00 00       	call   80106360 <uartputc>
  cgaputc(c);
8010071c:	89 f0                	mov    %esi,%eax
8010071e:	e8 fd fc ff ff       	call   80100420 <cgaputc>
  while (--i >= 0)
80100723:	8d 45 d7             	lea    -0x29(%ebp),%eax
80100726:	83 c4 10             	add    $0x10,%esp
80100729:	39 d8                	cmp    %ebx,%eax
8010072b:	74 0e                	je     8010073b <printint+0x9b>
    consputc(buf[i]);
8010072d:	0f b6 13             	movzbl (%ebx),%edx
80100730:	83 eb 01             	sub    $0x1,%ebx
80100733:	eb ca                	jmp    801006ff <printint+0x5f>
    x = -xx;
80100735:	f7 d8                	neg    %eax
80100737:	89 c1                	mov    %eax,%ecx
80100739:	eb 85                	jmp    801006c0 <printint+0x20>
}
8010073b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010073e:	5b                   	pop    %ebx
8010073f:	5e                   	pop    %esi
80100740:	5f                   	pop    %edi
80100741:	5d                   	pop    %ebp
80100742:	c3                   	ret    
80100743:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010074a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100750 <cprintf>:
{
80100750:	55                   	push   %ebp
80100751:	89 e5                	mov    %esp,%ebp
80100753:	57                   	push   %edi
80100754:	56                   	push   %esi
80100755:	53                   	push   %ebx
80100756:	83 ec 1c             	sub    $0x1c,%esp
  locking = cons.locking;
80100759:	a1 94 0b 11 80       	mov    0x80110b94,%eax
8010075e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if (locking)
80100761:	85 c0                	test   %eax,%eax
80100763:	0f 85 37 01 00 00    	jne    801008a0 <cprintf+0x150>
  if (fmt == 0)
80100769:	8b 75 08             	mov    0x8(%ebp),%esi
8010076c:	85 f6                	test   %esi,%esi
8010076e:	0f 84 3d 02 00 00    	je     801009b1 <cprintf+0x261>
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++)
80100774:	0f b6 06             	movzbl (%esi),%eax
  argp = (uint *)(void *)(&fmt + 1);
80100777:	8d 7d 0c             	lea    0xc(%ebp),%edi
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++)
8010077a:	31 db                	xor    %ebx,%ebx
8010077c:	85 c0                	test   %eax,%eax
8010077e:	74 56                	je     801007d6 <cprintf+0x86>
    if (c != '%')
80100780:	83 f8 25             	cmp    $0x25,%eax
80100783:	0f 85 d7 00 00 00    	jne    80100860 <cprintf+0x110>
    c = fmt[++i] & 0xff;
80100789:	83 c3 01             	add    $0x1,%ebx
8010078c:	0f b6 14 1e          	movzbl (%esi,%ebx,1),%edx
    if (c == 0)
80100790:	85 d2                	test   %edx,%edx
80100792:	74 42                	je     801007d6 <cprintf+0x86>
    switch (c)
80100794:	83 fa 70             	cmp    $0x70,%edx
80100797:	0f 84 94 00 00 00    	je     80100831 <cprintf+0xe1>
8010079d:	7f 51                	jg     801007f0 <cprintf+0xa0>
8010079f:	83 fa 25             	cmp    $0x25,%edx
801007a2:	0f 84 48 01 00 00    	je     801008f0 <cprintf+0x1a0>
801007a8:	83 fa 64             	cmp    $0x64,%edx
801007ab:	0f 85 04 01 00 00    	jne    801008b5 <cprintf+0x165>
      printint(*argp++, 10, 1);
801007b1:	8d 47 04             	lea    0x4(%edi),%eax
801007b4:	b9 01 00 00 00       	mov    $0x1,%ecx
801007b9:	ba 0a 00 00 00       	mov    $0xa,%edx
801007be:	89 45 e0             	mov    %eax,-0x20(%ebp)
801007c1:	8b 07                	mov    (%edi),%eax
801007c3:	e8 d8 fe ff ff       	call   801006a0 <printint>
801007c8:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++)
801007cb:	83 c3 01             	add    $0x1,%ebx
801007ce:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
801007d2:	85 c0                	test   %eax,%eax
801007d4:	75 aa                	jne    80100780 <cprintf+0x30>
  if (locking)
801007d6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801007d9:	85 c0                	test   %eax,%eax
801007db:	0f 85 b3 01 00 00    	jne    80100994 <cprintf+0x244>
}
801007e1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801007e4:	5b                   	pop    %ebx
801007e5:	5e                   	pop    %esi
801007e6:	5f                   	pop    %edi
801007e7:	5d                   	pop    %ebp
801007e8:	c3                   	ret    
801007e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    switch (c)
801007f0:	83 fa 73             	cmp    $0x73,%edx
801007f3:	75 33                	jne    80100828 <cprintf+0xd8>
      if ((s = (char *)*argp++) == 0)
801007f5:	8d 47 04             	lea    0x4(%edi),%eax
801007f8:	8b 3f                	mov    (%edi),%edi
801007fa:	89 45 e0             	mov    %eax,-0x20(%ebp)
801007fd:	85 ff                	test   %edi,%edi
801007ff:	0f 85 33 01 00 00    	jne    80100938 <cprintf+0x1e8>
        s = "(null)";
80100805:	bf 98 78 10 80       	mov    $0x80107898,%edi
      for (; *s; s++)
8010080a:	89 5d dc             	mov    %ebx,-0x24(%ebp)
8010080d:	b8 28 00 00 00       	mov    $0x28,%eax
80100812:	89 fb                	mov    %edi,%ebx
  if (panicked)
80100814:	8b 15 98 0b 11 80    	mov    0x80110b98,%edx
8010081a:	85 d2                	test   %edx,%edx
8010081c:	0f 84 27 01 00 00    	je     80100949 <cprintf+0x1f9>
80100822:	fa                   	cli    
    for (;;)
80100823:	eb fe                	jmp    80100823 <cprintf+0xd3>
80100825:	8d 76 00             	lea    0x0(%esi),%esi
    switch (c)
80100828:	83 fa 78             	cmp    $0x78,%edx
8010082b:	0f 85 84 00 00 00    	jne    801008b5 <cprintf+0x165>
      printint(*argp++, 16, 0);
80100831:	8d 47 04             	lea    0x4(%edi),%eax
80100834:	31 c9                	xor    %ecx,%ecx
80100836:	ba 10 00 00 00       	mov    $0x10,%edx
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++)
8010083b:	83 c3 01             	add    $0x1,%ebx
      printint(*argp++, 16, 0);
8010083e:	89 45 e0             	mov    %eax,-0x20(%ebp)
80100841:	8b 07                	mov    (%edi),%eax
80100843:	e8 58 fe ff ff       	call   801006a0 <printint>
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++)
80100848:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
      printint(*argp++, 16, 0);
8010084c:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++)
8010084f:	85 c0                	test   %eax,%eax
80100851:	0f 85 29 ff ff ff    	jne    80100780 <cprintf+0x30>
80100857:	e9 7a ff ff ff       	jmp    801007d6 <cprintf+0x86>
8010085c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if (panicked)
80100860:	8b 0d 98 0b 11 80    	mov    0x80110b98,%ecx
80100866:	85 c9                	test   %ecx,%ecx
80100868:	74 06                	je     80100870 <cprintf+0x120>
8010086a:	fa                   	cli    
    for (;;)
8010086b:	eb fe                	jmp    8010086b <cprintf+0x11b>
8010086d:	8d 76 00             	lea    0x0(%esi),%esi
    uartputc(c);
80100870:	83 ec 0c             	sub    $0xc,%esp
80100873:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++)
80100876:	83 c3 01             	add    $0x1,%ebx
    uartputc(c);
80100879:	50                   	push   %eax
8010087a:	e8 e1 5a 00 00       	call   80106360 <uartputc>
  cgaputc(c);
8010087f:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100882:	e8 99 fb ff ff       	call   80100420 <cgaputc>
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++)
80100887:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
      continue;
8010088b:	83 c4 10             	add    $0x10,%esp
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++)
8010088e:	85 c0                	test   %eax,%eax
80100890:	0f 85 ea fe ff ff    	jne    80100780 <cprintf+0x30>
80100896:	e9 3b ff ff ff       	jmp    801007d6 <cprintf+0x86>
8010089b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010089f:	90                   	nop
    acquire(&cons.lock);
801008a0:	83 ec 0c             	sub    $0xc,%esp
801008a3:	68 60 0b 11 80       	push   $0x80110b60
801008a8:	e8 a3 43 00 00       	call   80104c50 <acquire>
801008ad:	83 c4 10             	add    $0x10,%esp
801008b0:	e9 b4 fe ff ff       	jmp    80100769 <cprintf+0x19>
  if (panicked)
801008b5:	8b 0d 98 0b 11 80    	mov    0x80110b98,%ecx
801008bb:	85 c9                	test   %ecx,%ecx
801008bd:	75 71                	jne    80100930 <cprintf+0x1e0>
    uartputc(c);
801008bf:	83 ec 0c             	sub    $0xc,%esp
801008c2:	89 55 e0             	mov    %edx,-0x20(%ebp)
801008c5:	6a 25                	push   $0x25
801008c7:	e8 94 5a 00 00       	call   80106360 <uartputc>
  cgaputc(c);
801008cc:	b8 25 00 00 00       	mov    $0x25,%eax
801008d1:	e8 4a fb ff ff       	call   80100420 <cgaputc>
  if (panicked)
801008d6:	8b 15 98 0b 11 80    	mov    0x80110b98,%edx
801008dc:	83 c4 10             	add    $0x10,%esp
801008df:	85 d2                	test   %edx,%edx
801008e1:	8b 55 e0             	mov    -0x20(%ebp),%edx
801008e4:	0f 84 8e 00 00 00    	je     80100978 <cprintf+0x228>
801008ea:	fa                   	cli    
    for (;;)
801008eb:	eb fe                	jmp    801008eb <cprintf+0x19b>
801008ed:	8d 76 00             	lea    0x0(%esi),%esi
  if (panicked)
801008f0:	a1 98 0b 11 80       	mov    0x80110b98,%eax
801008f5:	85 c0                	test   %eax,%eax
801008f7:	74 07                	je     80100900 <cprintf+0x1b0>
801008f9:	fa                   	cli    
    for (;;)
801008fa:	eb fe                	jmp    801008fa <cprintf+0x1aa>
801008fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    uartputc(c);
80100900:	83 ec 0c             	sub    $0xc,%esp
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++)
80100903:	83 c3 01             	add    $0x1,%ebx
    uartputc(c);
80100906:	6a 25                	push   $0x25
80100908:	e8 53 5a 00 00       	call   80106360 <uartputc>
  cgaputc(c);
8010090d:	b8 25 00 00 00       	mov    $0x25,%eax
80100912:	e8 09 fb ff ff       	call   80100420 <cgaputc>
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++)
80100917:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
}
8010091b:	83 c4 10             	add    $0x10,%esp
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++)
8010091e:	85 c0                	test   %eax,%eax
80100920:	0f 85 5a fe ff ff    	jne    80100780 <cprintf+0x30>
80100926:	e9 ab fe ff ff       	jmp    801007d6 <cprintf+0x86>
8010092b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010092f:	90                   	nop
80100930:	fa                   	cli    
    for (;;)
80100931:	eb fe                	jmp    80100931 <cprintf+0x1e1>
80100933:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100937:	90                   	nop
      for (; *s; s++)
80100938:	0f b6 07             	movzbl (%edi),%eax
8010093b:	84 c0                	test   %al,%al
8010093d:	74 6a                	je     801009a9 <cprintf+0x259>
8010093f:	89 5d dc             	mov    %ebx,-0x24(%ebp)
80100942:	89 fb                	mov    %edi,%ebx
80100944:	e9 cb fe ff ff       	jmp    80100814 <cprintf+0xc4>
    uartputc(c);
80100949:	83 ec 0c             	sub    $0xc,%esp
        consputc(*s);
8010094c:	0f be f8             	movsbl %al,%edi
      for (; *s; s++)
8010094f:	83 c3 01             	add    $0x1,%ebx
    uartputc(c);
80100952:	57                   	push   %edi
80100953:	e8 08 5a 00 00       	call   80106360 <uartputc>
  cgaputc(c);
80100958:	89 f8                	mov    %edi,%eax
8010095a:	e8 c1 fa ff ff       	call   80100420 <cgaputc>
      for (; *s; s++)
8010095f:	0f b6 03             	movzbl (%ebx),%eax
80100962:	83 c4 10             	add    $0x10,%esp
80100965:	84 c0                	test   %al,%al
80100967:	0f 85 a7 fe ff ff    	jne    80100814 <cprintf+0xc4>
      if ((s = (char *)*argp++) == 0)
8010096d:	8b 5d dc             	mov    -0x24(%ebp),%ebx
80100970:	8b 7d e0             	mov    -0x20(%ebp),%edi
80100973:	e9 53 fe ff ff       	jmp    801007cb <cprintf+0x7b>
    uartputc(c);
80100978:	83 ec 0c             	sub    $0xc,%esp
8010097b:	89 55 e0             	mov    %edx,-0x20(%ebp)
8010097e:	52                   	push   %edx
8010097f:	e8 dc 59 00 00       	call   80106360 <uartputc>
  cgaputc(c);
80100984:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100987:	e8 94 fa ff ff       	call   80100420 <cgaputc>
}
8010098c:	83 c4 10             	add    $0x10,%esp
8010098f:	e9 37 fe ff ff       	jmp    801007cb <cprintf+0x7b>
    release(&cons.lock);
80100994:	83 ec 0c             	sub    $0xc,%esp
80100997:	68 60 0b 11 80       	push   $0x80110b60
8010099c:	e8 4f 42 00 00       	call   80104bf0 <release>
801009a1:	83 c4 10             	add    $0x10,%esp
}
801009a4:	e9 38 fe ff ff       	jmp    801007e1 <cprintf+0x91>
      if ((s = (char *)*argp++) == 0)
801009a9:	8b 7d e0             	mov    -0x20(%ebp),%edi
801009ac:	e9 1a fe ff ff       	jmp    801007cb <cprintf+0x7b>
    panic("null fmt");
801009b1:	83 ec 0c             	sub    $0xc,%esp
801009b4:	68 9f 78 10 80       	push   $0x8010789f
801009b9:	e8 e2 f9 ff ff       	call   801003a0 <panic>
801009be:	66 90                	xchg   %ax,%ax

801009c0 <currentIndex>:
  return input.e - input.w;
801009c0:	a1 d8 fe 10 80       	mov    0x8010fed8,%eax
801009c5:	2b 05 d4 fe 10 80    	sub    0x8010fed4,%eax
}
801009cb:	c3                   	ret    
801009cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801009d0 <BackToStart>:
  return input.e - input.w;
801009d0:	a1 d8 fe 10 80       	mov    0x8010fed8,%eax
801009d5:	89 c2                	mov    %eax,%edx
801009d7:	2b 15 d4 fe 10 80    	sub    0x8010fed4,%edx
  while (currentIndex() > 0)
801009dd:	85 d2                	test   %edx,%edx
801009df:	7e 3c                	jle    80100a1d <BackToStart+0x4d>
{
801009e1:	55                   	push   %ebp
801009e2:	89 e5                	mov    %esp,%ebp
801009e4:	83 ec 08             	sub    $0x8,%esp
    input.e--;
801009e7:	83 e8 01             	sub    $0x1,%eax
801009ea:	a3 d8 fe 10 80       	mov    %eax,0x8010fed8
  if (panicked)
801009ef:	a1 98 0b 11 80       	mov    0x80110b98,%eax
801009f4:	85 c0                	test   %eax,%eax
801009f6:	74 08                	je     80100a00 <BackToStart+0x30>
801009f8:	fa                   	cli    
    for (;;)
801009f9:	eb fe                	jmp    801009f9 <BackToStart+0x29>
801009fb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801009ff:	90                   	nop
  cgaputc(c);
80100a00:	b8 01 01 00 00       	mov    $0x101,%eax
80100a05:	e8 16 fa ff ff       	call   80100420 <cgaputc>
  return input.e - input.w;
80100a0a:	a1 d8 fe 10 80       	mov    0x8010fed8,%eax
80100a0f:	89 c2                	mov    %eax,%edx
80100a11:	2b 15 d4 fe 10 80    	sub    0x8010fed4,%edx
  while (currentIndex() > 0)
80100a17:	85 d2                	test   %edx,%edx
80100a19:	7f cc                	jg     801009e7 <BackToStart+0x17>
}
80100a1b:	c9                   	leave  
80100a1c:	c3                   	ret    
80100a1d:	c3                   	ret    
80100a1e:	66 90                	xchg   %ax,%ax

80100a20 <GoEndLine>:
  return input.e - input.w;
80100a20:	a1 d8 fe 10 80       	mov    0x8010fed8,%eax
80100a25:	89 c2                	mov    %eax,%edx
80100a27:	2b 15 d4 fe 10 80    	sub    0x8010fed4,%edx
  while (currentIndex() < lineLength)
80100a2d:	3b 15 54 0b 11 80    	cmp    0x80110b54,%edx
80100a33:	7d 3c                	jge    80100a71 <GoEndLine+0x51>
{
80100a35:	55                   	push   %ebp
80100a36:	89 e5                	mov    %esp,%ebp
80100a38:	83 ec 08             	sub    $0x8,%esp
    input.e++;
80100a3b:	83 c0 01             	add    $0x1,%eax
80100a3e:	a3 d8 fe 10 80       	mov    %eax,0x8010fed8
  if (panicked)
80100a43:	a1 98 0b 11 80       	mov    0x80110b98,%eax
80100a48:	85 c0                	test   %eax,%eax
80100a4a:	74 04                	je     80100a50 <GoEndLine+0x30>
80100a4c:	fa                   	cli    
    for (;;)
80100a4d:	eb fe                	jmp    80100a4d <GoEndLine+0x2d>
80100a4f:	90                   	nop
  cgaputc(c);
80100a50:	b8 02 01 00 00       	mov    $0x102,%eax
80100a55:	e8 c6 f9 ff ff       	call   80100420 <cgaputc>
  return input.e - input.w;
80100a5a:	a1 d8 fe 10 80       	mov    0x8010fed8,%eax
80100a5f:	89 c2                	mov    %eax,%edx
80100a61:	2b 15 d4 fe 10 80    	sub    0x8010fed4,%edx
  while (currentIndex() < lineLength)
80100a67:	39 15 54 0b 11 80    	cmp    %edx,0x80110b54
80100a6d:	7f cc                	jg     80100a3b <GoEndLine+0x1b>
}
80100a6f:	c9                   	leave  
80100a70:	c3                   	ret    
80100a71:	c3                   	ret    
80100a72:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100a79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80100a80 <KillLine>:
{
80100a80:	55                   	push   %ebp
80100a81:	89 e5                	mov    %esp,%ebp
80100a83:	83 ec 08             	sub    $0x8,%esp
  return input.e - input.w;
80100a86:	a1 d8 fe 10 80       	mov    0x8010fed8,%eax
80100a8b:	89 c2                	mov    %eax,%edx
80100a8d:	2b 15 d4 fe 10 80    	sub    0x8010fed4,%edx
  while (currentIndex() < lineLength)
80100a93:	3b 15 54 0b 11 80    	cmp    0x80110b54,%edx
80100a99:	7d 45                	jge    80100ae0 <KillLine+0x60>
  if (panicked)
80100a9b:	8b 15 98 0b 11 80    	mov    0x80110b98,%edx
    input.e++;
80100aa1:	83 c0 01             	add    $0x1,%eax
80100aa4:	a3 d8 fe 10 80       	mov    %eax,0x8010fed8
  if (panicked)
80100aa9:	85 d2                	test   %edx,%edx
80100aab:	74 03                	je     80100ab0 <KillLine+0x30>
80100aad:	fa                   	cli    
    for (;;)
80100aae:	eb fe                	jmp    80100aae <KillLine+0x2e>
  cgaputc(c);
80100ab0:	b8 02 01 00 00       	mov    $0x102,%eax
80100ab5:	e8 66 f9 ff ff       	call   80100420 <cgaputc>
  return input.e - input.w;
80100aba:	eb ca                	jmp    80100a86 <KillLine+0x6>
    uartputc('\b');
80100abc:	83 ec 0c             	sub    $0xc,%esp
80100abf:	6a 08                	push   $0x8
80100ac1:	e8 9a 58 00 00       	call   80106360 <uartputc>
  cgaputc(c);
80100ac6:	b8 00 01 00 00       	mov    $0x100,%eax
80100acb:	e8 50 f9 ff ff       	call   80100420 <cgaputc>
  return input.e - input.w;
80100ad0:	a1 d8 fe 10 80       	mov    0x8010fed8,%eax
  while (currentIndex() > 0) //&& input.buf[(input.e - 1) % INPUT_BUF] != '\n')
80100ad5:	83 c4 10             	add    $0x10,%esp
  return input.e - input.w;
80100ad8:	89 c2                	mov    %eax,%edx
80100ada:	2b 15 d4 fe 10 80    	sub    0x8010fed4,%edx
  while (currentIndex() > 0) //&& input.buf[(input.e - 1) % INPUT_BUF] != '\n')
80100ae0:	85 d2                	test   %edx,%edx
80100ae2:	7e 1c                	jle    80100b00 <KillLine+0x80>
    input.buf[input.e--] = 0;
80100ae4:	8d 50 ff             	lea    -0x1(%eax),%edx
80100ae7:	c6 80 80 fe 10 80 00 	movb   $0x0,-0x7fef0180(%eax)
  if (panicked)
80100aee:	a1 98 0b 11 80       	mov    0x80110b98,%eax
    input.buf[input.e--] = 0;
80100af3:	89 15 d8 fe 10 80    	mov    %edx,0x8010fed8
  if (panicked)
80100af9:	85 c0                	test   %eax,%eax
80100afb:	74 bf                	je     80100abc <KillLine+0x3c>
80100afd:	fa                   	cli    
    for (;;)
80100afe:	eb fe                	jmp    80100afe <KillLine+0x7e>
  lineLength = 0;
80100b00:	c7 05 54 0b 11 80 00 	movl   $0x0,0x80110b54
80100b07:	00 00 00 
}
80100b0a:	c9                   	leave  
80100b0b:	c3                   	ret    
80100b0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100b10 <Change>:
{
80100b10:	55                   	push   %ebp
80100b11:	89 e5                	mov    %esp,%ebp
80100b13:	56                   	push   %esi
80100b14:	53                   	push   %ebx
  KillLine();
80100b15:	e8 66 ff ff ff       	call   80100a80 <KillLine>
  memset(input.buf, 0, INPUT_BUF * sizeof(input.buf[0]));
80100b1a:	83 ec 04             	sub    $0x4,%esp
  lineLength = lineLengths[current];
80100b1d:	a1 00 90 10 80       	mov    0x80109000,%eax
  memset(input.buf, 0, INPUT_BUF * sizeof(input.buf[0]));
80100b22:	6a 4e                	push   $0x4e
80100b24:	6a 00                	push   $0x0
  lineLength = lineLengths[current];
80100b26:	8b 04 85 e0 fe 10 80 	mov    -0x7fef0120(,%eax,4),%eax
  memset(input.buf, 0, INPUT_BUF * sizeof(input.buf[0]));
80100b2d:	68 80 fe 10 80       	push   $0x8010fe80
  lineLength = lineLengths[current];
80100b32:	a3 54 0b 11 80       	mov    %eax,0x80110b54
  memset(input.buf, 0, INPUT_BUF * sizeof(input.buf[0]));
80100b37:	e8 d4 41 00 00       	call   80104d10 <memset>
  for (int i = 0; i < lineLength; i++)
80100b3c:	8b 0d 54 0b 11 80    	mov    0x80110b54,%ecx
80100b42:	83 c4 10             	add    $0x10,%esp
80100b45:	85 c9                	test   %ecx,%ecx
80100b47:	0f 8e 9f 00 00 00    	jle    80100bec <Change+0xdc>
80100b4d:	69 1d 00 90 10 80 38 	imul   $0x138,0x80109000,%ebx
80100b54:	01 00 00 
80100b57:	31 c0                	xor    %eax,%eax
80100b59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    input.buf[i] = commands[current][i];
80100b60:	8b 94 83 20 ff 10 80 	mov    -0x7fef00e0(%ebx,%eax,4),%edx
  for (int i = 0; i < lineLength; i++)
80100b67:	83 c0 01             	add    $0x1,%eax
    input.buf[i] = commands[current][i];
80100b6a:	88 90 7f fe 10 80    	mov    %dl,-0x7fef0181(%eax)
  for (int i = 0; i < lineLength; i++)
80100b70:	39 c8                	cmp    %ecx,%eax
80100b72:	75 ec                	jne    80100b60 <Change+0x50>
  input.e = input.w + lineLength;
80100b74:	03 05 d4 fe 10 80    	add    0x8010fed4,%eax
80100b7a:	31 db                	xor    %ebx,%ebx
80100b7c:	a3 d8 fe 10 80       	mov    %eax,0x8010fed8
  if (panicked)
80100b81:	8b 15 98 0b 11 80    	mov    0x80110b98,%edx
    consputc(input.buf[i]);
80100b87:	0f b6 83 80 fe 10 80 	movzbl -0x7fef0180(%ebx),%eax
  if (panicked)
80100b8e:	85 d2                	test   %edx,%edx
80100b90:	74 06                	je     80100b98 <Change+0x88>
80100b92:	fa                   	cli    
    for (;;)
80100b93:	eb fe                	jmp    80100b93 <Change+0x83>
80100b95:	8d 76 00             	lea    0x0(%esi),%esi
    uartputc(c);
80100b98:	83 ec 0c             	sub    $0xc,%esp
    consputc(input.buf[i]);
80100b9b:	0f be f0             	movsbl %al,%esi
  for (int i = 0; i < lineLength; i++)
80100b9e:	83 c3 01             	add    $0x1,%ebx
    uartputc(c);
80100ba1:	56                   	push   %esi
80100ba2:	e8 b9 57 00 00       	call   80106360 <uartputc>
  cgaputc(c);
80100ba7:	89 f0                	mov    %esi,%eax
80100ba9:	e8 72 f8 ff ff       	call   80100420 <cgaputc>
  for (int i = 0; i < lineLength; i++)
80100bae:	83 c4 10             	add    $0x10,%esp
80100bb1:	39 1d 54 0b 11 80    	cmp    %ebx,0x80110b54
80100bb7:	7f c8                	jg     80100b81 <Change+0x71>
  return input.e - input.w;
80100bb9:	a1 d8 fe 10 80       	mov    0x8010fed8,%eax
80100bbe:	89 c2                	mov    %eax,%edx
80100bc0:	2b 15 d4 fe 10 80    	sub    0x8010fed4,%edx
  while (currentIndex() > 0)
80100bc6:	85 d2                	test   %edx,%edx
80100bc8:	7e 2e                	jle    80100bf8 <Change+0xe8>
    input.e--;
80100bca:	83 e8 01             	sub    $0x1,%eax
80100bcd:	a3 d8 fe 10 80       	mov    %eax,0x8010fed8
  if (panicked)
80100bd2:	a1 98 0b 11 80       	mov    0x80110b98,%eax
80100bd7:	85 c0                	test   %eax,%eax
80100bd9:	74 05                	je     80100be0 <Change+0xd0>
80100bdb:	fa                   	cli    
    for (;;)
80100bdc:	eb fe                	jmp    80100bdc <Change+0xcc>
80100bde:	66 90                	xchg   %ax,%ax
  cgaputc(c);
80100be0:	b8 01 01 00 00       	mov    $0x101,%eax
80100be5:	e8 36 f8 ff ff       	call   80100420 <cgaputc>
  return input.e - input.w;
80100bea:	eb cd                	jmp    80100bb9 <Change+0xa9>
  input.e = input.w + lineLength;
80100bec:	03 0d d4 fe 10 80    	add    0x8010fed4,%ecx
80100bf2:	89 0d d8 fe 10 80    	mov    %ecx,0x8010fed8
}
80100bf8:	8d 65 f8             	lea    -0x8(%ebp),%esp
80100bfb:	5b                   	pop    %ebx
80100bfc:	5e                   	pop    %esi
80100bfd:	5d                   	pop    %ebp
80100bfe:	c3                   	ret    
80100bff:	90                   	nop

80100c00 <BackSpace>:
  return input.e - input.w;
80100c00:	a1 d8 fe 10 80       	mov    0x8010fed8,%eax
80100c05:	8b 15 d4 fe 10 80    	mov    0x8010fed4,%edx
80100c0b:	89 c1                	mov    %eax,%ecx
80100c0d:	29 d1                	sub    %edx,%ecx
  if (currentIndex() > 0)
80100c0f:	85 c9                	test   %ecx,%ecx
80100c11:	7e 5d                	jle    80100c70 <BackSpace+0x70>
    input.e--;
80100c13:	83 e8 01             	sub    $0x1,%eax
80100c16:	a3 d8 fe 10 80       	mov    %eax,0x8010fed8
  return input.e - input.w;
80100c1b:	29 d0                	sub    %edx,%eax
    for (int i = currentIndex(); i < INPUT_BUF - 1; i++)
80100c1d:	83 f8 4c             	cmp    $0x4c,%eax
80100c20:	7f 1b                	jg     80100c3d <BackSpace+0x3d>
80100c22:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      input.buf[i] = input.buf[i + 1];
80100c28:	0f b6 90 81 fe 10 80 	movzbl -0x7fef017f(%eax),%edx
80100c2f:	83 c0 01             	add    $0x1,%eax
80100c32:	88 90 7f fe 10 80    	mov    %dl,-0x7fef0181(%eax)
    for (int i = currentIndex(); i < INPUT_BUF - 1; i++)
80100c38:	83 f8 4d             	cmp    $0x4d,%eax
80100c3b:	75 eb                	jne    80100c28 <BackSpace+0x28>
  if (panicked)
80100c3d:	a1 98 0b 11 80       	mov    0x80110b98,%eax
    lineLength--;
80100c42:	83 2d 54 0b 11 80 01 	subl   $0x1,0x80110b54
  if (panicked)
80100c49:	85 c0                	test   %eax,%eax
80100c4b:	74 03                	je     80100c50 <BackSpace+0x50>
80100c4d:	fa                   	cli    
    for (;;)
80100c4e:	eb fe                	jmp    80100c4e <BackSpace+0x4e>
{
80100c50:	55                   	push   %ebp
80100c51:	89 e5                	mov    %esp,%ebp
80100c53:	83 ec 14             	sub    $0x14,%esp
    uartputc('\b');
80100c56:	6a 08                	push   $0x8
80100c58:	e8 03 57 00 00       	call   80106360 <uartputc>
  cgaputc(c);
80100c5d:	83 c4 10             	add    $0x10,%esp
80100c60:	b8 00 01 00 00       	mov    $0x100,%eax
}
80100c65:	c9                   	leave  
  cgaputc(c);
80100c66:	e9 b5 f7 ff ff       	jmp    80100420 <cgaputc>
80100c6b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100c6f:	90                   	nop
80100c70:	c3                   	ret    
80100c71:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100c78:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100c7f:	90                   	nop

80100c80 <SubmitCommand>:
{
80100c80:	55                   	push   %ebp
80100c81:	b9 40 f6 ff ff       	mov    $0xfffff640,%ecx
80100c86:	89 e5                	mov    %esp,%ebp
80100c88:	57                   	push   %edi
  for (int i = 8; i >= 0; i--)
80100c89:	bf 08 00 00 00       	mov    $0x8,%edi
{
80100c8e:	56                   	push   %esi
80100c8f:	53                   	push   %ebx
80100c90:	bb f8 0a 00 00       	mov    $0xaf8,%ebx
80100c95:	83 ec 1c             	sub    $0x1c,%esp
80100c98:	c7 45 e4 18 0a 11 80 	movl   $0x80110a18,-0x1c(%ebp)
80100c9f:	90                   	nop
    for (int j = 0; j < INPUT_BUF; j++)
80100ca0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100ca3:	89 7d e0             	mov    %edi,-0x20(%ebp)
80100ca6:	89 c6                	mov    %eax,%esi
80100ca8:	2d 38 01 00 00       	sub    $0x138,%eax
80100cad:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      commands[i + 1][j] = commands[i][j];
80100cb0:	8b 38                	mov    (%eax),%edi
80100cb2:	8d 14 08             	lea    (%eax,%ecx,1),%edx
    for (int j = 0; j < INPUT_BUF; j++)
80100cb5:	83 c0 04             	add    $0x4,%eax
      commands[i + 1][j] = commands[i][j];
80100cb8:	89 3c 1a             	mov    %edi,(%edx,%ebx,1)
    for (int j = 0; j < INPUT_BUF; j++)
80100cbb:	39 f0                	cmp    %esi,%eax
80100cbd:	75 f1                	jne    80100cb0 <SubmitCommand+0x30>
    lineLengths[i + 1] = lineLengths[i];
80100cbf:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for (int i = 8; i >= 0; i--)
80100cc2:	81 c1 38 01 00 00    	add    $0x138,%ecx
80100cc8:	81 eb 38 01 00 00    	sub    $0x138,%ebx
    lineLengths[i + 1] = lineLengths[i];
80100cce:	8b 04 bd e0 fe 10 80 	mov    -0x7fef0120(,%edi,4),%eax
80100cd5:	89 04 bd e4 fe 10 80 	mov    %eax,-0x7fef011c(,%edi,4)
  for (int i = 8; i >= 0; i--)
80100cdc:	83 ef 01             	sub    $0x1,%edi
80100cdf:	83 ff ff             	cmp    $0xffffffff,%edi
80100ce2:	75 bc                	jne    80100ca0 <SubmitCommand+0x20>
  for (int j = 0; j < INPUT_BUF; j++)
80100ce4:	31 c0                	xor    %eax,%eax
80100ce6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100ced:	8d 76 00             	lea    0x0(%esi),%esi
    commands[0][j] = input.buf[j];
80100cf0:	0f be 90 80 fe 10 80 	movsbl -0x7fef0180(%eax),%edx
80100cf7:	89 14 85 20 ff 10 80 	mov    %edx,-0x7fef00e0(,%eax,4)
  for (int j = 0; j < INPUT_BUF; j++)
80100cfe:	83 c0 01             	add    $0x1,%eax
80100d01:	83 f8 4e             	cmp    $0x4e,%eax
80100d04:	75 ea                	jne    80100cf0 <SubmitCommand+0x70>
  lineLengths[0] = lineLength;
80100d06:	a1 54 0b 11 80       	mov    0x80110b54,%eax
  input.buf[currentIndex()] = c;
80100d0b:	8b 55 08             	mov    0x8(%ebp),%edx
80100d0e:	88 90 80 fe 10 80    	mov    %dl,-0x7fef0180(%eax)
  input.e++;
80100d14:	8b 15 d4 fe 10 80    	mov    0x8010fed4,%edx
  lineLengths[0] = lineLength;
80100d1a:	a3 e0 fe 10 80       	mov    %eax,0x8010fee0
  input.e++;
80100d1f:	8d 44 10 01          	lea    0x1(%eax,%edx,1),%eax
  maxCommands = maxCommands == 10 ? 10 : (maxCommands + 1);
80100d23:	31 d2                	xor    %edx,%edx
  input.e++;
80100d25:	a3 d8 fe 10 80       	mov    %eax,0x8010fed8
  input.w = input.e;
80100d2a:	a3 d4 fe 10 80       	mov    %eax,0x8010fed4
  maxCommands = maxCommands == 10 ? 10 : (maxCommands + 1);
80100d2f:	a1 50 0b 11 80       	mov    0x80110b50,%eax
80100d34:	83 f8 0a             	cmp    $0xa,%eax
80100d37:	0f 95 c2             	setne  %dl
  wakeup(&input.r);
80100d3a:	83 ec 0c             	sub    $0xc,%esp
80100d3d:	68 d0 fe 10 80       	push   $0x8010fed0
  maxCommands = maxCommands == 10 ? 10 : (maxCommands + 1);
80100d42:	01 d0                	add    %edx,%eax
80100d44:	a3 50 0b 11 80       	mov    %eax,0x80110b50
  wakeup(&input.r);
80100d49:	e8 62 3a 00 00       	call   801047b0 <wakeup>
}
80100d4e:	83 c4 10             	add    $0x10,%esp
  lineLength = 0;
80100d51:	c7 05 54 0b 11 80 00 	movl   $0x0,0x80110b54
80100d58:	00 00 00 
}
80100d5b:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100d5e:	5b                   	pop    %ebx
80100d5f:	5e                   	pop    %esi
80100d60:	5f                   	pop    %edi
80100d61:	5d                   	pop    %ebp
80100d62:	c3                   	ret    
80100d63:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100d6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100d70 <consoleintr>:
{
80100d70:	55                   	push   %ebp
80100d71:	89 e5                	mov    %esp,%ebp
80100d73:	57                   	push   %edi
  int c, doprocdump = 0;
80100d74:	31 ff                	xor    %edi,%edi
{
80100d76:	56                   	push   %esi
80100d77:	53                   	push   %ebx
80100d78:	83 ec 28             	sub    $0x28,%esp
80100d7b:	8b 75 08             	mov    0x8(%ebp),%esi
  acquire(&cons.lock);
80100d7e:	68 60 0b 11 80       	push   $0x80110b60
80100d83:	e8 c8 3e 00 00       	call   80104c50 <acquire>
  while ((c = getc()) >= 0)
80100d88:	83 c4 10             	add    $0x10,%esp
80100d8b:	ff d6                	call   *%esi
80100d8d:	89 c2                	mov    %eax,%edx
80100d8f:	85 c0                	test   %eax,%eax
80100d91:	78 6d                	js     80100e00 <consoleintr+0x90>
    switch (c)
80100d93:	83 fa 15             	cmp    $0x15,%edx
80100d96:	7f 18                	jg     80100db0 <consoleintr+0x40>
80100d98:	83 fa 01             	cmp    $0x1,%edx
80100d9b:	0f 8e 7f 00 00 00    	jle    80100e20 <consoleintr+0xb0>
80100da1:	83 fa 15             	cmp    $0x15,%edx
80100da4:	77 7a                	ja     80100e20 <consoleintr+0xb0>
80100da6:	ff 24 95 b0 78 10 80 	jmp    *-0x7fef8750(,%edx,4)
80100dad:	8d 76 00             	lea    0x0(%esi),%esi
80100db0:	81 fa e2 00 00 00    	cmp    $0xe2,%edx
80100db6:	0f 84 f4 01 00 00    	je     80100fb0 <consoleintr+0x240>
80100dbc:	81 fa e3 00 00 00    	cmp    $0xe3,%edx
80100dc2:	75 24                	jne    80100de8 <consoleintr+0x78>
      if (current > 0)
80100dc4:	a1 00 90 10 80       	mov    0x80109000,%eax
80100dc9:	85 c0                	test   %eax,%eax
80100dcb:	0f 8f 49 02 00 00    	jg     8010101a <consoleintr+0x2aa>
      else if (current == 0)
80100dd1:	75 b8                	jne    80100d8b <consoleintr+0x1b>
        current--;
80100dd3:	c7 05 00 90 10 80 ff 	movl   $0xffffffff,0x80109000
80100dda:	ff ff ff 
        KillLine();
80100ddd:	e8 9e fc ff ff       	call   80100a80 <KillLine>
80100de2:	eb a7                	jmp    80100d8b <consoleintr+0x1b>
80100de4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    switch (c)
80100de8:	83 fa 7f             	cmp    $0x7f,%edx
80100deb:	75 3b                	jne    80100e28 <consoleintr+0xb8>
      BackSpace();
80100ded:	e8 0e fe ff ff       	call   80100c00 <BackSpace>
  while ((c = getc()) >= 0)
80100df2:	ff d6                	call   *%esi
80100df4:	89 c2                	mov    %eax,%edx
80100df6:	85 c0                	test   %eax,%eax
80100df8:	79 99                	jns    80100d93 <consoleintr+0x23>
80100dfa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  release(&cons.lock);
80100e00:	83 ec 0c             	sub    $0xc,%esp
80100e03:	68 60 0b 11 80       	push   $0x80110b60
80100e08:	e8 e3 3d 00 00       	call   80104bf0 <release>
  if (doprocdump)
80100e0d:	83 c4 10             	add    $0x10,%esp
80100e10:	85 ff                	test   %edi,%edi
80100e12:	0f 85 14 02 00 00    	jne    8010102c <consoleintr+0x2bc>
}
80100e18:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100e1b:	5b                   	pop    %ebx
80100e1c:	5e                   	pop    %esi
80100e1d:	5f                   	pop    %edi
80100e1e:	5d                   	pop    %ebp
80100e1f:	c3                   	ret    
      if (c != 0 && input.e - input.r < INPUT_BUF)
80100e20:	85 d2                	test   %edx,%edx
80100e22:	0f 84 63 ff ff ff    	je     80100d8b <consoleintr+0x1b>
80100e28:	a1 d8 fe 10 80       	mov    0x8010fed8,%eax
80100e2d:	2b 05 d0 fe 10 80    	sub    0x8010fed0,%eax
80100e33:	83 f8 4d             	cmp    $0x4d,%eax
80100e36:	0f 87 4f ff ff ff    	ja     80100d8b <consoleintr+0x1b>
  if (panicked)
80100e3c:	a1 98 0b 11 80       	mov    0x80110b98,%eax
        c = (c == '\r') ? '\n' : c;
80100e41:	83 fa 0d             	cmp    $0xd,%edx
80100e44:	0f 84 0c 02 00 00    	je     80101056 <consoleintr+0x2e6>
  if (panicked)
80100e4a:	85 c0                	test   %eax,%eax
80100e4c:	0f 85 29 02 00 00    	jne    8010107b <consoleintr+0x30b>
  if (c == BACKSPACE)
80100e52:	81 fa 00 01 00 00    	cmp    $0x100,%edx
80100e58:	0f 84 64 02 00 00    	je     801010c2 <consoleintr+0x352>
        if (c == '\n' || c == C('D') || input.e == input.r + INPUT_BUF)
80100e5e:	83 fa 0a             	cmp    $0xa,%edx
80100e61:	0f 94 c3             	sete   %bl
80100e64:	83 fa 04             	cmp    $0x4,%edx
80100e67:	0f 94 c0             	sete   %al
80100e6a:	09 c3                	or     %eax,%ebx
  else if (c < BACKSPACE)
80100e6c:	81 fa ff 00 00 00    	cmp    $0xff,%edx
80100e72:	0f 8e 6c 02 00 00    	jle    801010e4 <consoleintr+0x374>
  cgaputc(c);
80100e78:	89 d0                	mov    %edx,%eax
80100e7a:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80100e7d:	e8 9e f5 ff ff       	call   80100420 <cgaputc>
        if (c == '\n' || c == C('D') || input.e == input.r + INPUT_BUF)
80100e82:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80100e85:	a1 d0 fe 10 80       	mov    0x8010fed0,%eax
80100e8a:	8b 0d d8 fe 10 80    	mov    0x8010fed8,%ecx
80100e90:	83 c0 4e             	add    $0x4e,%eax
80100e93:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80100e96:	39 c1                	cmp    %eax,%ecx
80100e98:	0f 85 e2 01 00 00    	jne    80101080 <consoleintr+0x310>
          SubmitCommand(c);
80100e9e:	83 ec 0c             	sub    $0xc,%esp
80100ea1:	52                   	push   %edx
80100ea2:	e8 d9 fd ff ff       	call   80100c80 <SubmitCommand>
80100ea7:	83 c4 10             	add    $0x10,%esp
80100eaa:	e9 dc fe ff ff       	jmp    80100d8b <consoleintr+0x1b>
  cgaputc(c);
80100eaf:	b8 01 01 00 00       	mov    $0x101,%eax
80100eb4:	e8 67 f5 ff ff       	call   80100420 <cgaputc>
  return input.e - input.w;
80100eb9:	a1 d8 fe 10 80       	mov    0x8010fed8,%eax
80100ebe:	89 c2                	mov    %eax,%edx
80100ec0:	2b 15 d4 fe 10 80    	sub    0x8010fed4,%edx
  while (currentIndex() > 0)
80100ec6:	85 d2                	test   %edx,%edx
80100ec8:	0f 8e bd fe ff ff    	jle    80100d8b <consoleintr+0x1b>
    input.e--;
80100ece:	83 e8 01             	sub    $0x1,%eax
80100ed1:	a3 d8 fe 10 80       	mov    %eax,0x8010fed8
  if (panicked)
80100ed6:	a1 98 0b 11 80       	mov    0x80110b98,%eax
80100edb:	85 c0                	test   %eax,%eax
80100edd:	74 d0                	je     80100eaf <consoleintr+0x13f>
80100edf:	fa                   	cli    
    for (;;)
80100ee0:	eb fe                	jmp    80100ee0 <consoleintr+0x170>
80100ee2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      KillLine();
80100ee8:	e8 93 fb ff ff       	call   80100a80 <KillLine>
      break;
80100eed:	e9 99 fe ff ff       	jmp    80100d8b <consoleintr+0x1b>
      input.e = input.w;
80100ef2:	a1 d4 fe 10 80       	mov    0x8010fed4,%eax
  if (panicked)
80100ef7:	8b 0d 98 0b 11 80    	mov    0x80110b98,%ecx
      input.e = input.w;
80100efd:	a3 d8 fe 10 80       	mov    %eax,0x8010fed8
  if (panicked)
80100f02:	85 c9                	test   %ecx,%ecx
80100f04:	0f 84 01 01 00 00    	je     8010100b <consoleintr+0x29b>
80100f0a:	fa                   	cli    
    for (;;)
80100f0b:	eb fe                	jmp    80100f0b <consoleintr+0x19b>
80100f0d:	8d 76 00             	lea    0x0(%esi),%esi
  return input.e - input.w;
80100f10:	a1 d8 fe 10 80       	mov    0x8010fed8,%eax
80100f15:	89 c2                	mov    %eax,%edx
80100f17:	2b 15 d4 fe 10 80    	sub    0x8010fed4,%edx
      if (currentIndex() < lineLength)
80100f1d:	39 15 54 0b 11 80    	cmp    %edx,0x80110b54
80100f23:	0f 8e 62 fe ff ff    	jle    80100d8b <consoleintr+0x1b>
        input.e++;
80100f29:	83 c0 01             	add    $0x1,%eax
80100f2c:	a3 d8 fe 10 80       	mov    %eax,0x8010fed8
  if (panicked)
80100f31:	a1 98 0b 11 80       	mov    0x80110b98,%eax
80100f36:	85 c0                	test   %eax,%eax
80100f38:	0f 84 09 01 00 00    	je     80101047 <consoleintr+0x2d7>
80100f3e:	fa                   	cli    
    for (;;)
80100f3f:	eb fe                	jmp    80100f3f <consoleintr+0x1cf>
80100f41:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return input.e - input.w;
80100f48:	a1 d8 fe 10 80       	mov    0x8010fed8,%eax
80100f4d:	89 c2                	mov    %eax,%edx
80100f4f:	2b 15 d4 fe 10 80    	sub    0x8010fed4,%edx
  while (currentIndex() < lineLength)
80100f55:	39 15 54 0b 11 80    	cmp    %edx,0x80110b54
80100f5b:	0f 8e 2a fe ff ff    	jle    80100d8b <consoleintr+0x1b>
  if (panicked)
80100f61:	8b 1d 98 0b 11 80    	mov    0x80110b98,%ebx
    input.e++;
80100f67:	83 c0 01             	add    $0x1,%eax
80100f6a:	a3 d8 fe 10 80       	mov    %eax,0x8010fed8
  if (panicked)
80100f6f:	85 db                	test   %ebx,%ebx
80100f71:	74 66                	je     80100fd9 <consoleintr+0x269>
80100f73:	fa                   	cli    
    for (;;)
80100f74:	eb fe                	jmp    80100f74 <consoleintr+0x204>
80100f76:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100f7d:	8d 76 00             	lea    0x0(%esi),%esi
  return input.e - input.w;
80100f80:	a1 d8 fe 10 80       	mov    0x8010fed8,%eax
80100f85:	89 c2                	mov    %eax,%edx
80100f87:	2b 15 d4 fe 10 80    	sub    0x8010fed4,%edx
      if (currentIndex() > 0)
80100f8d:	85 d2                	test   %edx,%edx
80100f8f:	0f 8e f6 fd ff ff    	jle    80100d8b <consoleintr+0x1b>
  if (panicked)
80100f95:	8b 15 98 0b 11 80    	mov    0x80110b98,%edx
        input.e--;
80100f9b:	83 e8 01             	sub    $0x1,%eax
80100f9e:	a3 d8 fe 10 80       	mov    %eax,0x8010fed8
  if (panicked)
80100fa3:	85 d2                	test   %edx,%edx
80100fa5:	0f 84 8d 00 00 00    	je     80101038 <consoleintr+0x2c8>
80100fab:	fa                   	cli    
    for (;;)
80100fac:	eb fe                	jmp    80100fac <consoleintr+0x23c>
80100fae:	66 90                	xchg   %ax,%ax
      if (current < maxCommands - 1)
80100fb0:	a1 50 0b 11 80       	mov    0x80110b50,%eax
80100fb5:	8b 15 00 90 10 80    	mov    0x80109000,%edx
80100fbb:	83 e8 01             	sub    $0x1,%eax
80100fbe:	39 d0                	cmp    %edx,%eax
80100fc0:	0f 8e c5 fd ff ff    	jle    80100d8b <consoleintr+0x1b>
        current++;
80100fc6:	83 c2 01             	add    $0x1,%edx
80100fc9:	89 15 00 90 10 80    	mov    %edx,0x80109000
        Change();
80100fcf:	e8 3c fb ff ff       	call   80100b10 <Change>
80100fd4:	e9 b2 fd ff ff       	jmp    80100d8b <consoleintr+0x1b>
  cgaputc(c);
80100fd9:	b8 02 01 00 00       	mov    $0x102,%eax
80100fde:	e8 3d f4 ff ff       	call   80100420 <cgaputc>
  return input.e - input.w;
80100fe3:	a1 d8 fe 10 80       	mov    0x8010fed8,%eax
80100fe8:	89 c2                	mov    %eax,%edx
80100fea:	2b 15 d4 fe 10 80    	sub    0x8010fed4,%edx
  while (currentIndex() < lineLength)
80100ff0:	3b 15 54 0b 11 80    	cmp    0x80110b54,%edx
80100ff6:	0f 8c 65 ff ff ff    	jl     80100f61 <consoleintr+0x1f1>
80100ffc:	e9 8a fd ff ff       	jmp    80100d8b <consoleintr+0x1b>
    switch (c)
80101001:	bf 01 00 00 00       	mov    $0x1,%edi
80101006:	e9 80 fd ff ff       	jmp    80100d8b <consoleintr+0x1b>
  cgaputc(c);
8010100b:	b8 03 01 00 00       	mov    $0x103,%eax
80101010:	e8 0b f4 ff ff       	call   80100420 <cgaputc>
}
80101015:	e9 71 fd ff ff       	jmp    80100d8b <consoleintr+0x1b>
        current--;
8010101a:	83 e8 01             	sub    $0x1,%eax
8010101d:	a3 00 90 10 80       	mov    %eax,0x80109000
        Change();
80101022:	e8 e9 fa ff ff       	call   80100b10 <Change>
80101027:	e9 5f fd ff ff       	jmp    80100d8b <consoleintr+0x1b>
}
8010102c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010102f:	5b                   	pop    %ebx
80101030:	5e                   	pop    %esi
80101031:	5f                   	pop    %edi
80101032:	5d                   	pop    %ebp
    procdump(); // now call procdump() wo. cons.lock held
80101033:	e9 58 38 00 00       	jmp    80104890 <procdump>
  cgaputc(c);
80101038:	b8 01 01 00 00       	mov    $0x101,%eax
8010103d:	e8 de f3 ff ff       	call   80100420 <cgaputc>
}
80101042:	e9 44 fd ff ff       	jmp    80100d8b <consoleintr+0x1b>
  cgaputc(c);
80101047:	b8 02 01 00 00       	mov    $0x102,%eax
8010104c:	e8 cf f3 ff ff       	call   80100420 <cgaputc>
}
80101051:	e9 35 fd ff ff       	jmp    80100d8b <consoleintr+0x1b>
  if (panicked)
80101056:	85 c0                	test   %eax,%eax
80101058:	75 21                	jne    8010107b <consoleintr+0x30b>
    uartputc(c);
8010105a:	83 ec 0c             	sub    $0xc,%esp
8010105d:	6a 0a                	push   $0xa
8010105f:	e8 fc 52 00 00       	call   80106360 <uartputc>
  cgaputc(c);
80101064:	b8 0a 00 00 00       	mov    $0xa,%eax
80101069:	e8 b2 f3 ff ff       	call   80100420 <cgaputc>
8010106e:	83 c4 10             	add    $0x10,%esp
        c = (c == '\r') ? '\n' : c;
80101071:	ba 0a 00 00 00       	mov    $0xa,%edx
80101076:	e9 23 fe ff ff       	jmp    80100e9e <consoleintr+0x12e>
8010107b:	fa                   	cli    
    for (;;)
8010107c:	eb fe                	jmp    8010107c <consoleintr+0x30c>
8010107e:	66 90                	xchg   %ax,%ax
  return input.e - input.w;
80101080:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80101083:	2b 0d d4 fe 10 80    	sub    0x8010fed4,%ecx
          lineLength++;
80101089:	83 05 54 0b 11 80 01 	addl   $0x1,0x80110b54
          for (int i = currentIndex(); i < INPUT_BUF - 1; i++)
80101090:	83 f9 4c             	cmp    $0x4c,%ecx
80101093:	7f 17                	jg     801010ac <consoleintr+0x33c>
            input.buf[i + 1] = input.buf[i];
80101095:	0f b6 99 80 fe 10 80 	movzbl -0x7fef0180(%ecx),%ebx
8010109c:	89 c8                	mov    %ecx,%eax
8010109e:	83 c0 01             	add    $0x1,%eax
801010a1:	88 98 80 fe 10 80    	mov    %bl,-0x7fef0180(%eax)
          for (int i = currentIndex(); i < INPUT_BUF - 1; i++)
801010a7:	83 f8 4d             	cmp    $0x4d,%eax
801010aa:	75 f2                	jne    8010109e <consoleintr+0x32e>
          input.e++;
801010ac:	8b 45 e4             	mov    -0x1c(%ebp),%eax
          input.buf[currentIndex()] = c;
801010af:	88 91 80 fe 10 80    	mov    %dl,-0x7fef0180(%ecx)
          input.e++;
801010b5:	83 c0 01             	add    $0x1,%eax
801010b8:	a3 d8 fe 10 80       	mov    %eax,0x8010fed8
801010bd:	e9 c9 fc ff ff       	jmp    80100d8b <consoleintr+0x1b>
    uartputc('\b');
801010c2:	83 ec 0c             	sub    $0xc,%esp
801010c5:	89 55 e4             	mov    %edx,-0x1c(%ebp)
801010c8:	6a 08                	push   $0x8
801010ca:	e8 91 52 00 00       	call   80106360 <uartputc>
  cgaputc(c);
801010cf:	b8 00 01 00 00       	mov    $0x100,%eax
801010d4:	e8 47 f3 ff ff       	call   80100420 <cgaputc>
        if (c == '\n' || c == C('D') || input.e == input.r + INPUT_BUF)
801010d9:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  cgaputc(c);
801010dc:	83 c4 10             	add    $0x10,%esp
801010df:	e9 a1 fd ff ff       	jmp    80100e85 <consoleintr+0x115>
    uartputc(c);
801010e4:	83 ec 0c             	sub    $0xc,%esp
801010e7:	89 55 e4             	mov    %edx,-0x1c(%ebp)
801010ea:	52                   	push   %edx
801010eb:	e8 70 52 00 00       	call   80106360 <uartputc>
  cgaputc(c);
801010f0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801010f3:	e8 28 f3 ff ff       	call   80100420 <cgaputc>
        if (c == '\n' || c == C('D') || input.e == input.r + INPUT_BUF)
801010f8:	83 c4 10             	add    $0x10,%esp
801010fb:	84 db                	test   %bl,%bl
801010fd:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101100:	0f 85 98 fd ff ff    	jne    80100e9e <consoleintr+0x12e>
80101106:	e9 7a fd ff ff       	jmp    80100e85 <consoleintr+0x115>
8010110b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010110f:	90                   	nop

80101110 <consoleinit>:

void consoleinit(void)
{
80101110:	55                   	push   %ebp
80101111:	89 e5                	mov    %esp,%ebp
80101113:	83 ec 10             	sub    $0x10,%esp
  initlock(&cons.lock, "console");
80101116:	68 a8 78 10 80       	push   $0x801078a8
8010111b:	68 60 0b 11 80       	push   $0x80110b60
80101120:	e8 5b 39 00 00       	call   80104a80 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  ioapicenable(IRQ_KBD, 0);
80101125:	58                   	pop    %eax
80101126:	5a                   	pop    %edx
80101127:	6a 00                	push   $0x0
80101129:	6a 01                	push   $0x1
  devsw[CONSOLE].write = consolewrite;
8010112b:	c7 05 4c 15 11 80 20 	movl   $0x80100620,0x8011154c
80101132:	06 10 80 
  devsw[CONSOLE].read = consoleread;
80101135:	c7 05 48 15 11 80 80 	movl   $0x80100280,0x80111548
8010113c:	02 10 80 
  cons.locking = 1;
8010113f:	c7 05 94 0b 11 80 01 	movl   $0x1,0x80110b94
80101146:	00 00 00 
  ioapicenable(IRQ_KBD, 0);
80101149:	e8 e2 19 00 00       	call   80102b30 <ioapicenable>
}
8010114e:	83 c4 10             	add    $0x10,%esp
80101151:	c9                   	leave  
80101152:	c3                   	ret    
80101153:	66 90                	xchg   %ax,%ax
80101155:	66 90                	xchg   %ax,%ax
80101157:	66 90                	xchg   %ax,%ax
80101159:	66 90                	xchg   %ax,%ax
8010115b:	66 90                	xchg   %ax,%ax
8010115d:	66 90                	xchg   %ax,%ax
8010115f:	90                   	nop

80101160 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
80101160:	55                   	push   %ebp
80101161:	89 e5                	mov    %esp,%ebp
80101163:	57                   	push   %edi
80101164:	56                   	push   %esi
80101165:	53                   	push   %ebx
80101166:	81 ec 0c 01 00 00    	sub    $0x10c,%esp
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
8010116c:	e8 af 2e 00 00       	call   80104020 <myproc>
80101171:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)

  begin_op();
80101177:	e8 94 22 00 00       	call   80103410 <begin_op>

  if((ip = namei(path)) == 0){
8010117c:	83 ec 0c             	sub    $0xc,%esp
8010117f:	ff 75 08             	push   0x8(%ebp)
80101182:	e8 c9 15 00 00       	call   80102750 <namei>
80101187:	83 c4 10             	add    $0x10,%esp
8010118a:	85 c0                	test   %eax,%eax
8010118c:	0f 84 02 03 00 00    	je     80101494 <exec+0x334>
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
80101192:	83 ec 0c             	sub    $0xc,%esp
80101195:	89 c3                	mov    %eax,%ebx
80101197:	50                   	push   %eax
80101198:	e8 93 0c 00 00       	call   80101e30 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
8010119d:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
801011a3:	6a 34                	push   $0x34
801011a5:	6a 00                	push   $0x0
801011a7:	50                   	push   %eax
801011a8:	53                   	push   %ebx
801011a9:	e8 92 0f 00 00       	call   80102140 <readi>
801011ae:	83 c4 20             	add    $0x20,%esp
801011b1:	83 f8 34             	cmp    $0x34,%eax
801011b4:	74 22                	je     801011d8 <exec+0x78>

 bad:
  if(pgdir)
    freevm(pgdir);
  if(ip){
    iunlockput(ip);
801011b6:	83 ec 0c             	sub    $0xc,%esp
801011b9:	53                   	push   %ebx
801011ba:	e8 01 0f 00 00       	call   801020c0 <iunlockput>
    end_op();
801011bf:	e8 bc 22 00 00       	call   80103480 <end_op>
801011c4:	83 c4 10             	add    $0x10,%esp
  }
  return -1;
801011c7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801011cc:	8d 65 f4             	lea    -0xc(%ebp),%esp
801011cf:	5b                   	pop    %ebx
801011d0:	5e                   	pop    %esi
801011d1:	5f                   	pop    %edi
801011d2:	5d                   	pop    %ebp
801011d3:	c3                   	ret    
801011d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(elf.magic != ELF_MAGIC)
801011d8:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
801011df:	45 4c 46 
801011e2:	75 d2                	jne    801011b6 <exec+0x56>
  if((pgdir = setupkvm()) == 0)
801011e4:	e8 07 63 00 00       	call   801074f0 <setupkvm>
801011e9:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)
801011ef:	85 c0                	test   %eax,%eax
801011f1:	74 c3                	je     801011b6 <exec+0x56>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
801011f3:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
801011fa:	00 
801011fb:	8b b5 40 ff ff ff    	mov    -0xc0(%ebp),%esi
80101201:	0f 84 ac 02 00 00    	je     801014b3 <exec+0x353>
  sz = 0;
80101207:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
8010120e:	00 00 00 
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80101211:	31 ff                	xor    %edi,%edi
80101213:	e9 8e 00 00 00       	jmp    801012a6 <exec+0x146>
80101218:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010121f:	90                   	nop
    if(ph.type != ELF_PROG_LOAD)
80101220:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80101227:	75 6c                	jne    80101295 <exec+0x135>
    if(ph.memsz < ph.filesz)
80101229:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
8010122f:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80101235:	0f 82 87 00 00 00    	jb     801012c2 <exec+0x162>
    if(ph.vaddr + ph.memsz < ph.vaddr)
8010123b:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80101241:	72 7f                	jb     801012c2 <exec+0x162>
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80101243:	83 ec 04             	sub    $0x4,%esp
80101246:	50                   	push   %eax
80101247:	ff b5 f0 fe ff ff    	push   -0x110(%ebp)
8010124d:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80101253:	e8 b8 60 00 00       	call   80107310 <allocuvm>
80101258:	83 c4 10             	add    $0x10,%esp
8010125b:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80101261:	85 c0                	test   %eax,%eax
80101263:	74 5d                	je     801012c2 <exec+0x162>
    if(ph.vaddr % PGSIZE != 0)
80101265:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
8010126b:	a9 ff 0f 00 00       	test   $0xfff,%eax
80101270:	75 50                	jne    801012c2 <exec+0x162>
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80101272:	83 ec 0c             	sub    $0xc,%esp
80101275:	ff b5 14 ff ff ff    	push   -0xec(%ebp)
8010127b:	ff b5 08 ff ff ff    	push   -0xf8(%ebp)
80101281:	53                   	push   %ebx
80101282:	50                   	push   %eax
80101283:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80101289:	e8 92 5f 00 00       	call   80107220 <loaduvm>
8010128e:	83 c4 20             	add    $0x20,%esp
80101291:	85 c0                	test   %eax,%eax
80101293:	78 2d                	js     801012c2 <exec+0x162>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80101295:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
8010129c:	83 c7 01             	add    $0x1,%edi
8010129f:	83 c6 20             	add    $0x20,%esi
801012a2:	39 f8                	cmp    %edi,%eax
801012a4:	7e 3a                	jle    801012e0 <exec+0x180>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
801012a6:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
801012ac:	6a 20                	push   $0x20
801012ae:	56                   	push   %esi
801012af:	50                   	push   %eax
801012b0:	53                   	push   %ebx
801012b1:	e8 8a 0e 00 00       	call   80102140 <readi>
801012b6:	83 c4 10             	add    $0x10,%esp
801012b9:	83 f8 20             	cmp    $0x20,%eax
801012bc:	0f 84 5e ff ff ff    	je     80101220 <exec+0xc0>
    freevm(pgdir);
801012c2:	83 ec 0c             	sub    $0xc,%esp
801012c5:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
801012cb:	e8 a0 61 00 00       	call   80107470 <freevm>
  if(ip){
801012d0:	83 c4 10             	add    $0x10,%esp
801012d3:	e9 de fe ff ff       	jmp    801011b6 <exec+0x56>
801012d8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801012df:	90                   	nop
  sz = PGROUNDUP(sz);
801012e0:	8b bd f0 fe ff ff    	mov    -0x110(%ebp),%edi
801012e6:	81 c7 ff 0f 00 00    	add    $0xfff,%edi
801012ec:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
801012f2:	8d b7 00 20 00 00    	lea    0x2000(%edi),%esi
  iunlockput(ip);
801012f8:	83 ec 0c             	sub    $0xc,%esp
801012fb:	53                   	push   %ebx
801012fc:	e8 bf 0d 00 00       	call   801020c0 <iunlockput>
  end_op();
80101301:	e8 7a 21 00 00       	call   80103480 <end_op>
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80101306:	83 c4 0c             	add    $0xc,%esp
80101309:	56                   	push   %esi
8010130a:	57                   	push   %edi
8010130b:	8b bd f4 fe ff ff    	mov    -0x10c(%ebp),%edi
80101311:	57                   	push   %edi
80101312:	e8 f9 5f 00 00       	call   80107310 <allocuvm>
80101317:	83 c4 10             	add    $0x10,%esp
8010131a:	89 c6                	mov    %eax,%esi
8010131c:	85 c0                	test   %eax,%eax
8010131e:	0f 84 94 00 00 00    	je     801013b8 <exec+0x258>
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80101324:	83 ec 08             	sub    $0x8,%esp
80101327:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
  for(argc = 0; argv[argc]; argc++) {
8010132d:	89 f3                	mov    %esi,%ebx
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
8010132f:	50                   	push   %eax
80101330:	57                   	push   %edi
  for(argc = 0; argv[argc]; argc++) {
80101331:	31 ff                	xor    %edi,%edi
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80101333:	e8 58 62 00 00       	call   80107590 <clearpteu>
  for(argc = 0; argv[argc]; argc++) {
80101338:	8b 45 0c             	mov    0xc(%ebp),%eax
8010133b:	83 c4 10             	add    $0x10,%esp
8010133e:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
80101344:	8b 00                	mov    (%eax),%eax
80101346:	85 c0                	test   %eax,%eax
80101348:	0f 84 8b 00 00 00    	je     801013d9 <exec+0x279>
8010134e:	89 b5 f0 fe ff ff    	mov    %esi,-0x110(%ebp)
80101354:	8b b5 f4 fe ff ff    	mov    -0x10c(%ebp),%esi
8010135a:	eb 23                	jmp    8010137f <exec+0x21f>
8010135c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101360:	8b 45 0c             	mov    0xc(%ebp),%eax
    ustack[3+argc] = sp;
80101363:	89 9c bd 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%edi,4)
  for(argc = 0; argv[argc]; argc++) {
8010136a:	83 c7 01             	add    $0x1,%edi
    ustack[3+argc] = sp;
8010136d:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
  for(argc = 0; argv[argc]; argc++) {
80101373:	8b 04 b8             	mov    (%eax,%edi,4),%eax
80101376:	85 c0                	test   %eax,%eax
80101378:	74 59                	je     801013d3 <exec+0x273>
    if(argc >= MAXARG)
8010137a:	83 ff 20             	cmp    $0x20,%edi
8010137d:	74 39                	je     801013b8 <exec+0x258>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
8010137f:	83 ec 0c             	sub    $0xc,%esp
80101382:	50                   	push   %eax
80101383:	e8 88 3b 00 00       	call   80104f10 <strlen>
80101388:	29 c3                	sub    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
8010138a:	58                   	pop    %eax
8010138b:	8b 45 0c             	mov    0xc(%ebp),%eax
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
8010138e:	83 eb 01             	sub    $0x1,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80101391:	ff 34 b8             	push   (%eax,%edi,4)
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80101394:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80101397:	e8 74 3b 00 00       	call   80104f10 <strlen>
8010139c:	83 c0 01             	add    $0x1,%eax
8010139f:	50                   	push   %eax
801013a0:	8b 45 0c             	mov    0xc(%ebp),%eax
801013a3:	ff 34 b8             	push   (%eax,%edi,4)
801013a6:	53                   	push   %ebx
801013a7:	56                   	push   %esi
801013a8:	e8 b3 63 00 00       	call   80107760 <copyout>
801013ad:	83 c4 20             	add    $0x20,%esp
801013b0:	85 c0                	test   %eax,%eax
801013b2:	79 ac                	jns    80101360 <exec+0x200>
801013b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    freevm(pgdir);
801013b8:	83 ec 0c             	sub    $0xc,%esp
801013bb:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
801013c1:	e8 aa 60 00 00       	call   80107470 <freevm>
801013c6:	83 c4 10             	add    $0x10,%esp
  return -1;
801013c9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801013ce:	e9 f9 fd ff ff       	jmp    801011cc <exec+0x6c>
801013d3:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
  ustack[2] = sp - (argc+1)*4;  // argv pointer
801013d9:	8d 04 bd 04 00 00 00 	lea    0x4(,%edi,4),%eax
801013e0:	89 d9                	mov    %ebx,%ecx
  ustack[3+argc] = 0;
801013e2:	c7 84 bd 64 ff ff ff 	movl   $0x0,-0x9c(%ebp,%edi,4)
801013e9:	00 00 00 00 
  ustack[2] = sp - (argc+1)*4;  // argv pointer
801013ed:	29 c1                	sub    %eax,%ecx
  sp -= (3+argc+1) * 4;
801013ef:	83 c0 0c             	add    $0xc,%eax
  ustack[1] = argc;
801013f2:	89 bd 5c ff ff ff    	mov    %edi,-0xa4(%ebp)
  sp -= (3+argc+1) * 4;
801013f8:	29 c3                	sub    %eax,%ebx
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
801013fa:	50                   	push   %eax
801013fb:	52                   	push   %edx
801013fc:	53                   	push   %ebx
801013fd:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
  ustack[0] = 0xffffffff;  // fake return PC
80101403:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
8010140a:	ff ff ff 
  ustack[2] = sp - (argc+1)*4;  // argv pointer
8010140d:	89 8d 60 ff ff ff    	mov    %ecx,-0xa0(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80101413:	e8 48 63 00 00       	call   80107760 <copyout>
80101418:	83 c4 10             	add    $0x10,%esp
8010141b:	85 c0                	test   %eax,%eax
8010141d:	78 99                	js     801013b8 <exec+0x258>
  for(last=s=path; *s; s++)
8010141f:	8b 45 08             	mov    0x8(%ebp),%eax
80101422:	8b 55 08             	mov    0x8(%ebp),%edx
80101425:	0f b6 00             	movzbl (%eax),%eax
80101428:	84 c0                	test   %al,%al
8010142a:	74 13                	je     8010143f <exec+0x2df>
8010142c:	89 d1                	mov    %edx,%ecx
8010142e:	66 90                	xchg   %ax,%ax
      last = s+1;
80101430:	83 c1 01             	add    $0x1,%ecx
80101433:	3c 2f                	cmp    $0x2f,%al
  for(last=s=path; *s; s++)
80101435:	0f b6 01             	movzbl (%ecx),%eax
      last = s+1;
80101438:	0f 44 d1             	cmove  %ecx,%edx
  for(last=s=path; *s; s++)
8010143b:	84 c0                	test   %al,%al
8010143d:	75 f1                	jne    80101430 <exec+0x2d0>
  safestrcpy(curproc->name, last, sizeof(curproc->name));
8010143f:	8b bd ec fe ff ff    	mov    -0x114(%ebp),%edi
80101445:	83 ec 04             	sub    $0x4,%esp
80101448:	6a 10                	push   $0x10
8010144a:	89 f8                	mov    %edi,%eax
8010144c:	52                   	push   %edx
8010144d:	83 c0 6c             	add    $0x6c,%eax
80101450:	50                   	push   %eax
80101451:	e8 7a 3a 00 00       	call   80104ed0 <safestrcpy>
  curproc->pgdir = pgdir;
80101456:	8b 8d f4 fe ff ff    	mov    -0x10c(%ebp),%ecx
  oldpgdir = curproc->pgdir;
8010145c:	89 f8                	mov    %edi,%eax
8010145e:	8b 7f 04             	mov    0x4(%edi),%edi
  curproc->sz = sz;
80101461:	89 30                	mov    %esi,(%eax)
  curproc->pgdir = pgdir;
80101463:	89 48 04             	mov    %ecx,0x4(%eax)
  curproc->tf->eip = elf.entry;  // main
80101466:	89 c1                	mov    %eax,%ecx
80101468:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
8010146e:	8b 40 18             	mov    0x18(%eax),%eax
80101471:	89 50 38             	mov    %edx,0x38(%eax)
  curproc->tf->esp = sp;
80101474:	8b 41 18             	mov    0x18(%ecx),%eax
80101477:	89 58 44             	mov    %ebx,0x44(%eax)
  switchuvm(curproc);
8010147a:	89 0c 24             	mov    %ecx,(%esp)
8010147d:	e8 0e 5c 00 00       	call   80107090 <switchuvm>
  freevm(oldpgdir);
80101482:	89 3c 24             	mov    %edi,(%esp)
80101485:	e8 e6 5f 00 00       	call   80107470 <freevm>
  return 0;
8010148a:	83 c4 10             	add    $0x10,%esp
8010148d:	31 c0                	xor    %eax,%eax
8010148f:	e9 38 fd ff ff       	jmp    801011cc <exec+0x6c>
    end_op();
80101494:	e8 e7 1f 00 00       	call   80103480 <end_op>
    cprintf("exec: fail\n");
80101499:	83 ec 0c             	sub    $0xc,%esp
8010149c:	68 19 79 10 80       	push   $0x80107919
801014a1:	e8 aa f2 ff ff       	call   80100750 <cprintf>
    return -1;
801014a6:	83 c4 10             	add    $0x10,%esp
801014a9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801014ae:	e9 19 fd ff ff       	jmp    801011cc <exec+0x6c>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
801014b3:	be 00 20 00 00       	mov    $0x2000,%esi
801014b8:	31 ff                	xor    %edi,%edi
801014ba:	e9 39 fe ff ff       	jmp    801012f8 <exec+0x198>
801014bf:	90                   	nop

801014c0 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
801014c0:	55                   	push   %ebp
801014c1:	89 e5                	mov    %esp,%ebp
801014c3:	83 ec 10             	sub    $0x10,%esp
  initlock(&ftable.lock, "ftable");
801014c6:	68 25 79 10 80       	push   $0x80107925
801014cb:	68 a0 0b 11 80       	push   $0x80110ba0
801014d0:	e8 ab 35 00 00       	call   80104a80 <initlock>
}
801014d5:	83 c4 10             	add    $0x10,%esp
801014d8:	c9                   	leave  
801014d9:	c3                   	ret    
801014da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801014e0 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
801014e0:	55                   	push   %ebp
801014e1:	89 e5                	mov    %esp,%ebp
801014e3:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
801014e4:	bb d4 0b 11 80       	mov    $0x80110bd4,%ebx
{
801014e9:	83 ec 10             	sub    $0x10,%esp
  acquire(&ftable.lock);
801014ec:	68 a0 0b 11 80       	push   $0x80110ba0
801014f1:	e8 5a 37 00 00       	call   80104c50 <acquire>
801014f6:	83 c4 10             	add    $0x10,%esp
801014f9:	eb 10                	jmp    8010150b <filealloc+0x2b>
801014fb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801014ff:	90                   	nop
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80101500:	83 c3 18             	add    $0x18,%ebx
80101503:	81 fb 34 15 11 80    	cmp    $0x80111534,%ebx
80101509:	74 25                	je     80101530 <filealloc+0x50>
    if(f->ref == 0){
8010150b:	8b 43 04             	mov    0x4(%ebx),%eax
8010150e:	85 c0                	test   %eax,%eax
80101510:	75 ee                	jne    80101500 <filealloc+0x20>
      f->ref = 1;
      release(&ftable.lock);
80101512:	83 ec 0c             	sub    $0xc,%esp
      f->ref = 1;
80101515:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
8010151c:	68 a0 0b 11 80       	push   $0x80110ba0
80101521:	e8 ca 36 00 00       	call   80104bf0 <release>
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
}
80101526:	89 d8                	mov    %ebx,%eax
      return f;
80101528:	83 c4 10             	add    $0x10,%esp
}
8010152b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010152e:	c9                   	leave  
8010152f:	c3                   	ret    
  release(&ftable.lock);
80101530:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80101533:	31 db                	xor    %ebx,%ebx
  release(&ftable.lock);
80101535:	68 a0 0b 11 80       	push   $0x80110ba0
8010153a:	e8 b1 36 00 00       	call   80104bf0 <release>
}
8010153f:	89 d8                	mov    %ebx,%eax
  return 0;
80101541:	83 c4 10             	add    $0x10,%esp
}
80101544:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101547:	c9                   	leave  
80101548:	c3                   	ret    
80101549:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101550 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80101550:	55                   	push   %ebp
80101551:	89 e5                	mov    %esp,%ebp
80101553:	53                   	push   %ebx
80101554:	83 ec 10             	sub    $0x10,%esp
80101557:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
8010155a:	68 a0 0b 11 80       	push   $0x80110ba0
8010155f:	e8 ec 36 00 00       	call   80104c50 <acquire>
  if(f->ref < 1)
80101564:	8b 43 04             	mov    0x4(%ebx),%eax
80101567:	83 c4 10             	add    $0x10,%esp
8010156a:	85 c0                	test   %eax,%eax
8010156c:	7e 1a                	jle    80101588 <filedup+0x38>
    panic("filedup");
  f->ref++;
8010156e:	83 c0 01             	add    $0x1,%eax
  release(&ftable.lock);
80101571:	83 ec 0c             	sub    $0xc,%esp
  f->ref++;
80101574:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80101577:	68 a0 0b 11 80       	push   $0x80110ba0
8010157c:	e8 6f 36 00 00       	call   80104bf0 <release>
  return f;
}
80101581:	89 d8                	mov    %ebx,%eax
80101583:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101586:	c9                   	leave  
80101587:	c3                   	ret    
    panic("filedup");
80101588:	83 ec 0c             	sub    $0xc,%esp
8010158b:	68 2c 79 10 80       	push   $0x8010792c
80101590:	e8 0b ee ff ff       	call   801003a0 <panic>
80101595:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010159c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801015a0 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
801015a0:	55                   	push   %ebp
801015a1:	89 e5                	mov    %esp,%ebp
801015a3:	57                   	push   %edi
801015a4:	56                   	push   %esi
801015a5:	53                   	push   %ebx
801015a6:	83 ec 28             	sub    $0x28,%esp
801015a9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct file ff;

  acquire(&ftable.lock);
801015ac:	68 a0 0b 11 80       	push   $0x80110ba0
801015b1:	e8 9a 36 00 00       	call   80104c50 <acquire>
  if(f->ref < 1)
801015b6:	8b 53 04             	mov    0x4(%ebx),%edx
801015b9:	83 c4 10             	add    $0x10,%esp
801015bc:	85 d2                	test   %edx,%edx
801015be:	0f 8e a5 00 00 00    	jle    80101669 <fileclose+0xc9>
    panic("fileclose");
  if(--f->ref > 0){
801015c4:	83 ea 01             	sub    $0x1,%edx
801015c7:	89 53 04             	mov    %edx,0x4(%ebx)
801015ca:	75 44                	jne    80101610 <fileclose+0x70>
    release(&ftable.lock);
    return;
  }
  ff = *f;
801015cc:	0f b6 43 09          	movzbl 0x9(%ebx),%eax
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
801015d0:	83 ec 0c             	sub    $0xc,%esp
  ff = *f;
801015d3:	8b 3b                	mov    (%ebx),%edi
  f->type = FD_NONE;
801015d5:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  ff = *f;
801015db:	8b 73 0c             	mov    0xc(%ebx),%esi
801015de:	88 45 e7             	mov    %al,-0x19(%ebp)
801015e1:	8b 43 10             	mov    0x10(%ebx),%eax
  release(&ftable.lock);
801015e4:	68 a0 0b 11 80       	push   $0x80110ba0
  ff = *f;
801015e9:	89 45 e0             	mov    %eax,-0x20(%ebp)
  release(&ftable.lock);
801015ec:	e8 ff 35 00 00       	call   80104bf0 <release>

  if(ff.type == FD_PIPE)
801015f1:	83 c4 10             	add    $0x10,%esp
801015f4:	83 ff 01             	cmp    $0x1,%edi
801015f7:	74 57                	je     80101650 <fileclose+0xb0>
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
801015f9:	83 ff 02             	cmp    $0x2,%edi
801015fc:	74 2a                	je     80101628 <fileclose+0x88>
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
801015fe:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101601:	5b                   	pop    %ebx
80101602:	5e                   	pop    %esi
80101603:	5f                   	pop    %edi
80101604:	5d                   	pop    %ebp
80101605:	c3                   	ret    
80101606:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010160d:	8d 76 00             	lea    0x0(%esi),%esi
    release(&ftable.lock);
80101610:	c7 45 08 a0 0b 11 80 	movl   $0x80110ba0,0x8(%ebp)
}
80101617:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010161a:	5b                   	pop    %ebx
8010161b:	5e                   	pop    %esi
8010161c:	5f                   	pop    %edi
8010161d:	5d                   	pop    %ebp
    release(&ftable.lock);
8010161e:	e9 cd 35 00 00       	jmp    80104bf0 <release>
80101623:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101627:	90                   	nop
    begin_op();
80101628:	e8 e3 1d 00 00       	call   80103410 <begin_op>
    iput(ff.ip);
8010162d:	83 ec 0c             	sub    $0xc,%esp
80101630:	ff 75 e0             	push   -0x20(%ebp)
80101633:	e8 28 09 00 00       	call   80101f60 <iput>
    end_op();
80101638:	83 c4 10             	add    $0x10,%esp
}
8010163b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010163e:	5b                   	pop    %ebx
8010163f:	5e                   	pop    %esi
80101640:	5f                   	pop    %edi
80101641:	5d                   	pop    %ebp
    end_op();
80101642:	e9 39 1e 00 00       	jmp    80103480 <end_op>
80101647:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010164e:	66 90                	xchg   %ax,%ax
    pipeclose(ff.pipe, ff.writable);
80101650:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
80101654:	83 ec 08             	sub    $0x8,%esp
80101657:	53                   	push   %ebx
80101658:	56                   	push   %esi
80101659:	e8 82 25 00 00       	call   80103be0 <pipeclose>
8010165e:	83 c4 10             	add    $0x10,%esp
}
80101661:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101664:	5b                   	pop    %ebx
80101665:	5e                   	pop    %esi
80101666:	5f                   	pop    %edi
80101667:	5d                   	pop    %ebp
80101668:	c3                   	ret    
    panic("fileclose");
80101669:	83 ec 0c             	sub    $0xc,%esp
8010166c:	68 34 79 10 80       	push   $0x80107934
80101671:	e8 2a ed ff ff       	call   801003a0 <panic>
80101676:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010167d:	8d 76 00             	lea    0x0(%esi),%esi

80101680 <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80101680:	55                   	push   %ebp
80101681:	89 e5                	mov    %esp,%ebp
80101683:	53                   	push   %ebx
80101684:	83 ec 04             	sub    $0x4,%esp
80101687:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
8010168a:	83 3b 02             	cmpl   $0x2,(%ebx)
8010168d:	75 31                	jne    801016c0 <filestat+0x40>
    ilock(f->ip);
8010168f:	83 ec 0c             	sub    $0xc,%esp
80101692:	ff 73 10             	push   0x10(%ebx)
80101695:	e8 96 07 00 00       	call   80101e30 <ilock>
    stati(f->ip, st);
8010169a:	58                   	pop    %eax
8010169b:	5a                   	pop    %edx
8010169c:	ff 75 0c             	push   0xc(%ebp)
8010169f:	ff 73 10             	push   0x10(%ebx)
801016a2:	e8 69 0a 00 00       	call   80102110 <stati>
    iunlock(f->ip);
801016a7:	59                   	pop    %ecx
801016a8:	ff 73 10             	push   0x10(%ebx)
801016ab:	e8 60 08 00 00       	call   80101f10 <iunlock>
    return 0;
  }
  return -1;
}
801016b0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return 0;
801016b3:	83 c4 10             	add    $0x10,%esp
801016b6:	31 c0                	xor    %eax,%eax
}
801016b8:	c9                   	leave  
801016b9:	c3                   	ret    
801016ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801016c0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return -1;
801016c3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801016c8:	c9                   	leave  
801016c9:	c3                   	ret    
801016ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801016d0 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
801016d0:	55                   	push   %ebp
801016d1:	89 e5                	mov    %esp,%ebp
801016d3:	57                   	push   %edi
801016d4:	56                   	push   %esi
801016d5:	53                   	push   %ebx
801016d6:	83 ec 0c             	sub    $0xc,%esp
801016d9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801016dc:	8b 75 0c             	mov    0xc(%ebp),%esi
801016df:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
801016e2:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
801016e6:	74 60                	je     80101748 <fileread+0x78>
    return -1;
  if(f->type == FD_PIPE)
801016e8:	8b 03                	mov    (%ebx),%eax
801016ea:	83 f8 01             	cmp    $0x1,%eax
801016ed:	74 41                	je     80101730 <fileread+0x60>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
801016ef:	83 f8 02             	cmp    $0x2,%eax
801016f2:	75 5b                	jne    8010174f <fileread+0x7f>
    ilock(f->ip);
801016f4:	83 ec 0c             	sub    $0xc,%esp
801016f7:	ff 73 10             	push   0x10(%ebx)
801016fa:	e8 31 07 00 00       	call   80101e30 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
801016ff:	57                   	push   %edi
80101700:	ff 73 14             	push   0x14(%ebx)
80101703:	56                   	push   %esi
80101704:	ff 73 10             	push   0x10(%ebx)
80101707:	e8 34 0a 00 00       	call   80102140 <readi>
8010170c:	83 c4 20             	add    $0x20,%esp
8010170f:	89 c6                	mov    %eax,%esi
80101711:	85 c0                	test   %eax,%eax
80101713:	7e 03                	jle    80101718 <fileread+0x48>
      f->off += r;
80101715:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
80101718:	83 ec 0c             	sub    $0xc,%esp
8010171b:	ff 73 10             	push   0x10(%ebx)
8010171e:	e8 ed 07 00 00       	call   80101f10 <iunlock>
    return r;
80101723:	83 c4 10             	add    $0x10,%esp
  }
  panic("fileread");
}
80101726:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101729:	89 f0                	mov    %esi,%eax
8010172b:	5b                   	pop    %ebx
8010172c:	5e                   	pop    %esi
8010172d:	5f                   	pop    %edi
8010172e:	5d                   	pop    %ebp
8010172f:	c3                   	ret    
    return piperead(f->pipe, addr, n);
80101730:	8b 43 0c             	mov    0xc(%ebx),%eax
80101733:	89 45 08             	mov    %eax,0x8(%ebp)
}
80101736:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101739:	5b                   	pop    %ebx
8010173a:	5e                   	pop    %esi
8010173b:	5f                   	pop    %edi
8010173c:	5d                   	pop    %ebp
    return piperead(f->pipe, addr, n);
8010173d:	e9 3e 26 00 00       	jmp    80103d80 <piperead>
80101742:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80101748:	be ff ff ff ff       	mov    $0xffffffff,%esi
8010174d:	eb d7                	jmp    80101726 <fileread+0x56>
  panic("fileread");
8010174f:	83 ec 0c             	sub    $0xc,%esp
80101752:	68 3e 79 10 80       	push   $0x8010793e
80101757:	e8 44 ec ff ff       	call   801003a0 <panic>
8010175c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101760 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80101760:	55                   	push   %ebp
80101761:	89 e5                	mov    %esp,%ebp
80101763:	57                   	push   %edi
80101764:	56                   	push   %esi
80101765:	53                   	push   %ebx
80101766:	83 ec 1c             	sub    $0x1c,%esp
80101769:	8b 45 0c             	mov    0xc(%ebp),%eax
8010176c:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010176f:	89 45 dc             	mov    %eax,-0x24(%ebp)
80101772:	8b 45 10             	mov    0x10(%ebp),%eax
  int r;

  if(f->writable == 0)
80101775:	80 7b 09 00          	cmpb   $0x0,0x9(%ebx)
{
80101779:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(f->writable == 0)
8010177c:	0f 84 bd 00 00 00    	je     8010183f <filewrite+0xdf>
    return -1;
  if(f->type == FD_PIPE)
80101782:	8b 03                	mov    (%ebx),%eax
80101784:	83 f8 01             	cmp    $0x1,%eax
80101787:	0f 84 bf 00 00 00    	je     8010184c <filewrite+0xec>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
8010178d:	83 f8 02             	cmp    $0x2,%eax
80101790:	0f 85 c8 00 00 00    	jne    8010185e <filewrite+0xfe>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
80101796:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    int i = 0;
80101799:	31 f6                	xor    %esi,%esi
    while(i < n){
8010179b:	85 c0                	test   %eax,%eax
8010179d:	7f 30                	jg     801017cf <filewrite+0x6f>
8010179f:	e9 94 00 00 00       	jmp    80101838 <filewrite+0xd8>
801017a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
801017a8:	01 43 14             	add    %eax,0x14(%ebx)
      iunlock(f->ip);
801017ab:	83 ec 0c             	sub    $0xc,%esp
801017ae:	ff 73 10             	push   0x10(%ebx)
        f->off += r;
801017b1:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
801017b4:	e8 57 07 00 00       	call   80101f10 <iunlock>
      end_op();
801017b9:	e8 c2 1c 00 00       	call   80103480 <end_op>

      if(r < 0)
        break;
      if(r != n1)
801017be:	8b 45 e0             	mov    -0x20(%ebp),%eax
801017c1:	83 c4 10             	add    $0x10,%esp
801017c4:	39 c7                	cmp    %eax,%edi
801017c6:	75 5c                	jne    80101824 <filewrite+0xc4>
        panic("short filewrite");
      i += r;
801017c8:	01 fe                	add    %edi,%esi
    while(i < n){
801017ca:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
801017cd:	7e 69                	jle    80101838 <filewrite+0xd8>
      int n1 = n - i;
801017cf:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801017d2:	b8 00 06 00 00       	mov    $0x600,%eax
801017d7:	29 f7                	sub    %esi,%edi
801017d9:	39 c7                	cmp    %eax,%edi
801017db:	0f 4f f8             	cmovg  %eax,%edi
      begin_op();
801017de:	e8 2d 1c 00 00       	call   80103410 <begin_op>
      ilock(f->ip);
801017e3:	83 ec 0c             	sub    $0xc,%esp
801017e6:	ff 73 10             	push   0x10(%ebx)
801017e9:	e8 42 06 00 00       	call   80101e30 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
801017ee:	8b 45 dc             	mov    -0x24(%ebp),%eax
801017f1:	57                   	push   %edi
801017f2:	ff 73 14             	push   0x14(%ebx)
801017f5:	01 f0                	add    %esi,%eax
801017f7:	50                   	push   %eax
801017f8:	ff 73 10             	push   0x10(%ebx)
801017fb:	e8 40 0a 00 00       	call   80102240 <writei>
80101800:	83 c4 20             	add    $0x20,%esp
80101803:	85 c0                	test   %eax,%eax
80101805:	7f a1                	jg     801017a8 <filewrite+0x48>
      iunlock(f->ip);
80101807:	83 ec 0c             	sub    $0xc,%esp
8010180a:	ff 73 10             	push   0x10(%ebx)
8010180d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101810:	e8 fb 06 00 00       	call   80101f10 <iunlock>
      end_op();
80101815:	e8 66 1c 00 00       	call   80103480 <end_op>
      if(r < 0)
8010181a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010181d:	83 c4 10             	add    $0x10,%esp
80101820:	85 c0                	test   %eax,%eax
80101822:	75 1b                	jne    8010183f <filewrite+0xdf>
        panic("short filewrite");
80101824:	83 ec 0c             	sub    $0xc,%esp
80101827:	68 47 79 10 80       	push   $0x80107947
8010182c:	e8 6f eb ff ff       	call   801003a0 <panic>
80101831:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    }
    return i == n ? n : -1;
80101838:	89 f0                	mov    %esi,%eax
8010183a:	3b 75 e4             	cmp    -0x1c(%ebp),%esi
8010183d:	74 05                	je     80101844 <filewrite+0xe4>
8010183f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  panic("filewrite");
}
80101844:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101847:	5b                   	pop    %ebx
80101848:	5e                   	pop    %esi
80101849:	5f                   	pop    %edi
8010184a:	5d                   	pop    %ebp
8010184b:	c3                   	ret    
    return pipewrite(f->pipe, addr, n);
8010184c:	8b 43 0c             	mov    0xc(%ebx),%eax
8010184f:	89 45 08             	mov    %eax,0x8(%ebp)
}
80101852:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101855:	5b                   	pop    %ebx
80101856:	5e                   	pop    %esi
80101857:	5f                   	pop    %edi
80101858:	5d                   	pop    %ebp
    return pipewrite(f->pipe, addr, n);
80101859:	e9 22 24 00 00       	jmp    80103c80 <pipewrite>
  panic("filewrite");
8010185e:	83 ec 0c             	sub    $0xc,%esp
80101861:	68 4d 79 10 80       	push   $0x8010794d
80101866:	e8 35 eb ff ff       	call   801003a0 <panic>
8010186b:	66 90                	xchg   %ax,%ax
8010186d:	66 90                	xchg   %ax,%ax
8010186f:	90                   	nop

80101870 <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
80101870:	55                   	push   %ebp
80101871:	89 c1                	mov    %eax,%ecx
  struct buf *bp;
  int bi, m;

  bp = bread(dev, BBLOCK(b, sb));
80101873:	89 d0                	mov    %edx,%eax
80101875:	c1 e8 0c             	shr    $0xc,%eax
80101878:	03 05 0c 32 11 80    	add    0x8011320c,%eax
{
8010187e:	89 e5                	mov    %esp,%ebp
80101880:	56                   	push   %esi
80101881:	53                   	push   %ebx
80101882:	89 d3                	mov    %edx,%ebx
  bp = bread(dev, BBLOCK(b, sb));
80101884:	83 ec 08             	sub    $0x8,%esp
80101887:	50                   	push   %eax
80101888:	51                   	push   %ecx
80101889:	e8 42 e8 ff ff       	call   801000d0 <bread>
  bi = b % BPB;
  m = 1 << (bi % 8);
8010188e:	89 d9                	mov    %ebx,%ecx
  if((bp->data[bi/8] & m) == 0)
80101890:	c1 fb 03             	sar    $0x3,%ebx
80101893:	83 c4 10             	add    $0x10,%esp
  bp = bread(dev, BBLOCK(b, sb));
80101896:	89 c6                	mov    %eax,%esi
  m = 1 << (bi % 8);
80101898:	83 e1 07             	and    $0x7,%ecx
8010189b:	b8 01 00 00 00       	mov    $0x1,%eax
  if((bp->data[bi/8] & m) == 0)
801018a0:	81 e3 ff 01 00 00    	and    $0x1ff,%ebx
  m = 1 << (bi % 8);
801018a6:	d3 e0                	shl    %cl,%eax
  if((bp->data[bi/8] & m) == 0)
801018a8:	0f b6 4c 1e 5c       	movzbl 0x5c(%esi,%ebx,1),%ecx
801018ad:	85 c1                	test   %eax,%ecx
801018af:	74 23                	je     801018d4 <bfree+0x64>
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
801018b1:	f7 d0                	not    %eax
  log_write(bp);
801018b3:	83 ec 0c             	sub    $0xc,%esp
  bp->data[bi/8] &= ~m;
801018b6:	21 c8                	and    %ecx,%eax
801018b8:	88 44 1e 5c          	mov    %al,0x5c(%esi,%ebx,1)
  log_write(bp);
801018bc:	56                   	push   %esi
801018bd:	e8 2e 1d 00 00       	call   801035f0 <log_write>
  brelse(bp);
801018c2:	89 34 24             	mov    %esi,(%esp)
801018c5:	e8 26 e9 ff ff       	call   801001f0 <brelse>
}
801018ca:	83 c4 10             	add    $0x10,%esp
801018cd:	8d 65 f8             	lea    -0x8(%ebp),%esp
801018d0:	5b                   	pop    %ebx
801018d1:	5e                   	pop    %esi
801018d2:	5d                   	pop    %ebp
801018d3:	c3                   	ret    
    panic("freeing free block");
801018d4:	83 ec 0c             	sub    $0xc,%esp
801018d7:	68 57 79 10 80       	push   $0x80107957
801018dc:	e8 bf ea ff ff       	call   801003a0 <panic>
801018e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801018e8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801018ef:	90                   	nop

801018f0 <balloc>:
{
801018f0:	55                   	push   %ebp
801018f1:	89 e5                	mov    %esp,%ebp
801018f3:	57                   	push   %edi
801018f4:	56                   	push   %esi
801018f5:	53                   	push   %ebx
801018f6:	83 ec 1c             	sub    $0x1c,%esp
  for(b = 0; b < sb.size; b += BPB){
801018f9:	8b 0d f4 31 11 80    	mov    0x801131f4,%ecx
{
801018ff:	89 45 d8             	mov    %eax,-0x28(%ebp)
  for(b = 0; b < sb.size; b += BPB){
80101902:	85 c9                	test   %ecx,%ecx
80101904:	0f 84 87 00 00 00    	je     80101991 <balloc+0xa1>
8010190a:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    bp = bread(dev, BBLOCK(b, sb));
80101911:	8b 75 dc             	mov    -0x24(%ebp),%esi
80101914:	83 ec 08             	sub    $0x8,%esp
80101917:	89 f0                	mov    %esi,%eax
80101919:	c1 f8 0c             	sar    $0xc,%eax
8010191c:	03 05 0c 32 11 80    	add    0x8011320c,%eax
80101922:	50                   	push   %eax
80101923:	ff 75 d8             	push   -0x28(%ebp)
80101926:	e8 a5 e7 ff ff       	call   801000d0 <bread>
8010192b:	83 c4 10             	add    $0x10,%esp
8010192e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
80101931:	a1 f4 31 11 80       	mov    0x801131f4,%eax
80101936:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101939:	31 c0                	xor    %eax,%eax
8010193b:	eb 2f                	jmp    8010196c <balloc+0x7c>
8010193d:	8d 76 00             	lea    0x0(%esi),%esi
      m = 1 << (bi % 8);
80101940:	89 c1                	mov    %eax,%ecx
80101942:	bb 01 00 00 00       	mov    $0x1,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
80101947:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      m = 1 << (bi % 8);
8010194a:	83 e1 07             	and    $0x7,%ecx
8010194d:	d3 e3                	shl    %cl,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
8010194f:	89 c1                	mov    %eax,%ecx
80101951:	c1 f9 03             	sar    $0x3,%ecx
80101954:	0f b6 7c 0a 5c       	movzbl 0x5c(%edx,%ecx,1),%edi
80101959:	89 fa                	mov    %edi,%edx
8010195b:	85 df                	test   %ebx,%edi
8010195d:	74 41                	je     801019a0 <balloc+0xb0>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
8010195f:	83 c0 01             	add    $0x1,%eax
80101962:	83 c6 01             	add    $0x1,%esi
80101965:	3d 00 10 00 00       	cmp    $0x1000,%eax
8010196a:	74 05                	je     80101971 <balloc+0x81>
8010196c:	39 75 e0             	cmp    %esi,-0x20(%ebp)
8010196f:	77 cf                	ja     80101940 <balloc+0x50>
    brelse(bp);
80101971:	83 ec 0c             	sub    $0xc,%esp
80101974:	ff 75 e4             	push   -0x1c(%ebp)
80101977:	e8 74 e8 ff ff       	call   801001f0 <brelse>
  for(b = 0; b < sb.size; b += BPB){
8010197c:	81 45 dc 00 10 00 00 	addl   $0x1000,-0x24(%ebp)
80101983:	83 c4 10             	add    $0x10,%esp
80101986:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101989:	39 05 f4 31 11 80    	cmp    %eax,0x801131f4
8010198f:	77 80                	ja     80101911 <balloc+0x21>
  panic("balloc: out of blocks");
80101991:	83 ec 0c             	sub    $0xc,%esp
80101994:	68 6a 79 10 80       	push   $0x8010796a
80101999:	e8 02 ea ff ff       	call   801003a0 <panic>
8010199e:	66 90                	xchg   %ax,%ax
        bp->data[bi/8] |= m;  // Mark block in use.
801019a0:	8b 7d e4             	mov    -0x1c(%ebp),%edi
        log_write(bp);
801019a3:	83 ec 0c             	sub    $0xc,%esp
        bp->data[bi/8] |= m;  // Mark block in use.
801019a6:	09 da                	or     %ebx,%edx
801019a8:	88 54 0f 5c          	mov    %dl,0x5c(%edi,%ecx,1)
        log_write(bp);
801019ac:	57                   	push   %edi
801019ad:	e8 3e 1c 00 00       	call   801035f0 <log_write>
        brelse(bp);
801019b2:	89 3c 24             	mov    %edi,(%esp)
801019b5:	e8 36 e8 ff ff       	call   801001f0 <brelse>
  bp = bread(dev, bno);
801019ba:	58                   	pop    %eax
801019bb:	5a                   	pop    %edx
801019bc:	56                   	push   %esi
801019bd:	ff 75 d8             	push   -0x28(%ebp)
801019c0:	e8 0b e7 ff ff       	call   801000d0 <bread>
  memset(bp->data, 0, BSIZE);
801019c5:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, bno);
801019c8:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
801019ca:	8d 40 5c             	lea    0x5c(%eax),%eax
801019cd:	68 00 02 00 00       	push   $0x200
801019d2:	6a 00                	push   $0x0
801019d4:	50                   	push   %eax
801019d5:	e8 36 33 00 00       	call   80104d10 <memset>
  log_write(bp);
801019da:	89 1c 24             	mov    %ebx,(%esp)
801019dd:	e8 0e 1c 00 00       	call   801035f0 <log_write>
  brelse(bp);
801019e2:	89 1c 24             	mov    %ebx,(%esp)
801019e5:	e8 06 e8 ff ff       	call   801001f0 <brelse>
}
801019ea:	8d 65 f4             	lea    -0xc(%ebp),%esp
801019ed:	89 f0                	mov    %esi,%eax
801019ef:	5b                   	pop    %ebx
801019f0:	5e                   	pop    %esi
801019f1:	5f                   	pop    %edi
801019f2:	5d                   	pop    %ebp
801019f3:	c3                   	ret    
801019f4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801019fb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801019ff:	90                   	nop

80101a00 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
80101a00:	55                   	push   %ebp
80101a01:	89 e5                	mov    %esp,%ebp
80101a03:	57                   	push   %edi
80101a04:	89 c7                	mov    %eax,%edi
80101a06:	56                   	push   %esi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
80101a07:	31 f6                	xor    %esi,%esi
{
80101a09:	53                   	push   %ebx
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101a0a:	bb d4 15 11 80       	mov    $0x801115d4,%ebx
{
80101a0f:	83 ec 28             	sub    $0x28,%esp
80101a12:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  acquire(&icache.lock);
80101a15:	68 a0 15 11 80       	push   $0x801115a0
80101a1a:	e8 31 32 00 00       	call   80104c50 <acquire>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101a1f:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  acquire(&icache.lock);
80101a22:	83 c4 10             	add    $0x10,%esp
80101a25:	eb 1b                	jmp    80101a42 <iget+0x42>
80101a27:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101a2e:	66 90                	xchg   %ax,%ax
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101a30:	39 3b                	cmp    %edi,(%ebx)
80101a32:	74 6c                	je     80101aa0 <iget+0xa0>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101a34:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101a3a:	81 fb f4 31 11 80    	cmp    $0x801131f4,%ebx
80101a40:	73 26                	jae    80101a68 <iget+0x68>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101a42:	8b 43 08             	mov    0x8(%ebx),%eax
80101a45:	85 c0                	test   %eax,%eax
80101a47:	7f e7                	jg     80101a30 <iget+0x30>
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80101a49:	85 f6                	test   %esi,%esi
80101a4b:	75 e7                	jne    80101a34 <iget+0x34>
80101a4d:	85 c0                	test   %eax,%eax
80101a4f:	75 76                	jne    80101ac7 <iget+0xc7>
80101a51:	89 de                	mov    %ebx,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101a53:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101a59:	81 fb f4 31 11 80    	cmp    $0x801131f4,%ebx
80101a5f:	72 e1                	jb     80101a42 <iget+0x42>
80101a61:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
80101a68:	85 f6                	test   %esi,%esi
80101a6a:	74 79                	je     80101ae5 <iget+0xe5>
  ip = empty;
  ip->dev = dev;
  ip->inum = inum;
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);
80101a6c:	83 ec 0c             	sub    $0xc,%esp
  ip->dev = dev;
80101a6f:	89 3e                	mov    %edi,(%esi)
  ip->inum = inum;
80101a71:	89 56 04             	mov    %edx,0x4(%esi)
  ip->ref = 1;
80101a74:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->valid = 0;
80101a7b:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
  release(&icache.lock);
80101a82:	68 a0 15 11 80       	push   $0x801115a0
80101a87:	e8 64 31 00 00       	call   80104bf0 <release>

  return ip;
80101a8c:	83 c4 10             	add    $0x10,%esp
}
80101a8f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101a92:	89 f0                	mov    %esi,%eax
80101a94:	5b                   	pop    %ebx
80101a95:	5e                   	pop    %esi
80101a96:	5f                   	pop    %edi
80101a97:	5d                   	pop    %ebp
80101a98:	c3                   	ret    
80101a99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101aa0:	39 53 04             	cmp    %edx,0x4(%ebx)
80101aa3:	75 8f                	jne    80101a34 <iget+0x34>
      release(&icache.lock);
80101aa5:	83 ec 0c             	sub    $0xc,%esp
      ip->ref++;
80101aa8:	83 c0 01             	add    $0x1,%eax
      return ip;
80101aab:	89 de                	mov    %ebx,%esi
      release(&icache.lock);
80101aad:	68 a0 15 11 80       	push   $0x801115a0
      ip->ref++;
80101ab2:	89 43 08             	mov    %eax,0x8(%ebx)
      release(&icache.lock);
80101ab5:	e8 36 31 00 00       	call   80104bf0 <release>
      return ip;
80101aba:	83 c4 10             	add    $0x10,%esp
}
80101abd:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101ac0:	89 f0                	mov    %esi,%eax
80101ac2:	5b                   	pop    %ebx
80101ac3:	5e                   	pop    %esi
80101ac4:	5f                   	pop    %edi
80101ac5:	5d                   	pop    %ebp
80101ac6:	c3                   	ret    
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101ac7:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101acd:	81 fb f4 31 11 80    	cmp    $0x801131f4,%ebx
80101ad3:	73 10                	jae    80101ae5 <iget+0xe5>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101ad5:	8b 43 08             	mov    0x8(%ebx),%eax
80101ad8:	85 c0                	test   %eax,%eax
80101ada:	0f 8f 50 ff ff ff    	jg     80101a30 <iget+0x30>
80101ae0:	e9 68 ff ff ff       	jmp    80101a4d <iget+0x4d>
    panic("iget: no inodes");
80101ae5:	83 ec 0c             	sub    $0xc,%esp
80101ae8:	68 80 79 10 80       	push   $0x80107980
80101aed:	e8 ae e8 ff ff       	call   801003a0 <panic>
80101af2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101af9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101b00 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
80101b00:	55                   	push   %ebp
80101b01:	89 e5                	mov    %esp,%ebp
80101b03:	57                   	push   %edi
80101b04:	56                   	push   %esi
80101b05:	89 c6                	mov    %eax,%esi
80101b07:	53                   	push   %ebx
80101b08:	83 ec 1c             	sub    $0x1c,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
80101b0b:	83 fa 0b             	cmp    $0xb,%edx
80101b0e:	0f 86 8c 00 00 00    	jbe    80101ba0 <bmap+0xa0>
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
    return addr;
  }
  bn -= NDIRECT;
80101b14:	8d 5a f4             	lea    -0xc(%edx),%ebx

  if(bn < NINDIRECT){
80101b17:	83 fb 7f             	cmp    $0x7f,%ebx
80101b1a:	0f 87 a2 00 00 00    	ja     80101bc2 <bmap+0xc2>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
80101b20:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
80101b26:	85 c0                	test   %eax,%eax
80101b28:	74 5e                	je     80101b88 <bmap+0x88>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
80101b2a:	83 ec 08             	sub    $0x8,%esp
80101b2d:	50                   	push   %eax
80101b2e:	ff 36                	push   (%esi)
80101b30:	e8 9b e5 ff ff       	call   801000d0 <bread>
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
80101b35:	83 c4 10             	add    $0x10,%esp
80101b38:	8d 5c 98 5c          	lea    0x5c(%eax,%ebx,4),%ebx
    bp = bread(ip->dev, addr);
80101b3c:	89 c2                	mov    %eax,%edx
    if((addr = a[bn]) == 0){
80101b3e:	8b 3b                	mov    (%ebx),%edi
80101b40:	85 ff                	test   %edi,%edi
80101b42:	74 1c                	je     80101b60 <bmap+0x60>
      a[bn] = addr = balloc(ip->dev);
      log_write(bp);
    }
    brelse(bp);
80101b44:	83 ec 0c             	sub    $0xc,%esp
80101b47:	52                   	push   %edx
80101b48:	e8 a3 e6 ff ff       	call   801001f0 <brelse>
80101b4d:	83 c4 10             	add    $0x10,%esp
    return addr;
  }

  panic("bmap: out of range");
}
80101b50:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b53:	89 f8                	mov    %edi,%eax
80101b55:	5b                   	pop    %ebx
80101b56:	5e                   	pop    %esi
80101b57:	5f                   	pop    %edi
80101b58:	5d                   	pop    %ebp
80101b59:	c3                   	ret    
80101b5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101b60:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      a[bn] = addr = balloc(ip->dev);
80101b63:	8b 06                	mov    (%esi),%eax
80101b65:	e8 86 fd ff ff       	call   801018f0 <balloc>
      log_write(bp);
80101b6a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101b6d:	83 ec 0c             	sub    $0xc,%esp
      a[bn] = addr = balloc(ip->dev);
80101b70:	89 03                	mov    %eax,(%ebx)
80101b72:	89 c7                	mov    %eax,%edi
      log_write(bp);
80101b74:	52                   	push   %edx
80101b75:	e8 76 1a 00 00       	call   801035f0 <log_write>
80101b7a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101b7d:	83 c4 10             	add    $0x10,%esp
80101b80:	eb c2                	jmp    80101b44 <bmap+0x44>
80101b82:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
80101b88:	8b 06                	mov    (%esi),%eax
80101b8a:	e8 61 fd ff ff       	call   801018f0 <balloc>
80101b8f:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
80101b95:	eb 93                	jmp    80101b2a <bmap+0x2a>
80101b97:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101b9e:	66 90                	xchg   %ax,%ax
    if((addr = ip->addrs[bn]) == 0)
80101ba0:	8d 5a 14             	lea    0x14(%edx),%ebx
80101ba3:	8b 7c 98 0c          	mov    0xc(%eax,%ebx,4),%edi
80101ba7:	85 ff                	test   %edi,%edi
80101ba9:	75 a5                	jne    80101b50 <bmap+0x50>
      ip->addrs[bn] = addr = balloc(ip->dev);
80101bab:	8b 00                	mov    (%eax),%eax
80101bad:	e8 3e fd ff ff       	call   801018f0 <balloc>
80101bb2:	89 44 9e 0c          	mov    %eax,0xc(%esi,%ebx,4)
80101bb6:	89 c7                	mov    %eax,%edi
}
80101bb8:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101bbb:	5b                   	pop    %ebx
80101bbc:	89 f8                	mov    %edi,%eax
80101bbe:	5e                   	pop    %esi
80101bbf:	5f                   	pop    %edi
80101bc0:	5d                   	pop    %ebp
80101bc1:	c3                   	ret    
  panic("bmap: out of range");
80101bc2:	83 ec 0c             	sub    $0xc,%esp
80101bc5:	68 90 79 10 80       	push   $0x80107990
80101bca:	e8 d1 e7 ff ff       	call   801003a0 <panic>
80101bcf:	90                   	nop

80101bd0 <readsb>:
{
80101bd0:	55                   	push   %ebp
80101bd1:	89 e5                	mov    %esp,%ebp
80101bd3:	56                   	push   %esi
80101bd4:	53                   	push   %ebx
80101bd5:	8b 75 0c             	mov    0xc(%ebp),%esi
  bp = bread(dev, 1);
80101bd8:	83 ec 08             	sub    $0x8,%esp
80101bdb:	6a 01                	push   $0x1
80101bdd:	ff 75 08             	push   0x8(%ebp)
80101be0:	e8 eb e4 ff ff       	call   801000d0 <bread>
  memmove(sb, bp->data, sizeof(*sb));
80101be5:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, 1);
80101be8:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
80101bea:	8d 40 5c             	lea    0x5c(%eax),%eax
80101bed:	6a 1c                	push   $0x1c
80101bef:	50                   	push   %eax
80101bf0:	56                   	push   %esi
80101bf1:	e8 ba 31 00 00       	call   80104db0 <memmove>
  brelse(bp);
80101bf6:	89 5d 08             	mov    %ebx,0x8(%ebp)
80101bf9:	83 c4 10             	add    $0x10,%esp
}
80101bfc:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101bff:	5b                   	pop    %ebx
80101c00:	5e                   	pop    %esi
80101c01:	5d                   	pop    %ebp
  brelse(bp);
80101c02:	e9 e9 e5 ff ff       	jmp    801001f0 <brelse>
80101c07:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101c0e:	66 90                	xchg   %ax,%ax

80101c10 <iinit>:
{
80101c10:	55                   	push   %ebp
80101c11:	89 e5                	mov    %esp,%ebp
80101c13:	53                   	push   %ebx
80101c14:	bb e0 15 11 80       	mov    $0x801115e0,%ebx
80101c19:	83 ec 0c             	sub    $0xc,%esp
  initlock(&icache.lock, "icache");
80101c1c:	68 a3 79 10 80       	push   $0x801079a3
80101c21:	68 a0 15 11 80       	push   $0x801115a0
80101c26:	e8 55 2e 00 00       	call   80104a80 <initlock>
  for(i = 0; i < NINODE; i++) {
80101c2b:	83 c4 10             	add    $0x10,%esp
80101c2e:	66 90                	xchg   %ax,%ax
    initsleeplock(&icache.inode[i].lock, "inode");
80101c30:	83 ec 08             	sub    $0x8,%esp
80101c33:	68 aa 79 10 80       	push   $0x801079aa
80101c38:	53                   	push   %ebx
  for(i = 0; i < NINODE; i++) {
80101c39:	81 c3 90 00 00 00    	add    $0x90,%ebx
    initsleeplock(&icache.inode[i].lock, "inode");
80101c3f:	e8 0c 2d 00 00       	call   80104950 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
80101c44:	83 c4 10             	add    $0x10,%esp
80101c47:	81 fb 00 32 11 80    	cmp    $0x80113200,%ebx
80101c4d:	75 e1                	jne    80101c30 <iinit+0x20>
  bp = bread(dev, 1);
80101c4f:	83 ec 08             	sub    $0x8,%esp
80101c52:	6a 01                	push   $0x1
80101c54:	ff 75 08             	push   0x8(%ebp)
80101c57:	e8 74 e4 ff ff       	call   801000d0 <bread>
  memmove(sb, bp->data, sizeof(*sb));
80101c5c:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, 1);
80101c5f:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
80101c61:	8d 40 5c             	lea    0x5c(%eax),%eax
80101c64:	6a 1c                	push   $0x1c
80101c66:	50                   	push   %eax
80101c67:	68 f4 31 11 80       	push   $0x801131f4
80101c6c:	e8 3f 31 00 00       	call   80104db0 <memmove>
  brelse(bp);
80101c71:	89 1c 24             	mov    %ebx,(%esp)
80101c74:	e8 77 e5 ff ff       	call   801001f0 <brelse>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
80101c79:	ff 35 0c 32 11 80    	push   0x8011320c
80101c7f:	ff 35 08 32 11 80    	push   0x80113208
80101c85:	ff 35 04 32 11 80    	push   0x80113204
80101c8b:	ff 35 00 32 11 80    	push   0x80113200
80101c91:	ff 35 fc 31 11 80    	push   0x801131fc
80101c97:	ff 35 f8 31 11 80    	push   0x801131f8
80101c9d:	ff 35 f4 31 11 80    	push   0x801131f4
80101ca3:	68 10 7a 10 80       	push   $0x80107a10
80101ca8:	e8 a3 ea ff ff       	call   80100750 <cprintf>
}
80101cad:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101cb0:	83 c4 30             	add    $0x30,%esp
80101cb3:	c9                   	leave  
80101cb4:	c3                   	ret    
80101cb5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101cbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101cc0 <ialloc>:
{
80101cc0:	55                   	push   %ebp
80101cc1:	89 e5                	mov    %esp,%ebp
80101cc3:	57                   	push   %edi
80101cc4:	56                   	push   %esi
80101cc5:	53                   	push   %ebx
80101cc6:	83 ec 1c             	sub    $0x1c,%esp
80101cc9:	8b 45 0c             	mov    0xc(%ebp),%eax
  for(inum = 1; inum < sb.ninodes; inum++){
80101ccc:	83 3d fc 31 11 80 01 	cmpl   $0x1,0x801131fc
{
80101cd3:	8b 75 08             	mov    0x8(%ebp),%esi
80101cd6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(inum = 1; inum < sb.ninodes; inum++){
80101cd9:	0f 86 91 00 00 00    	jbe    80101d70 <ialloc+0xb0>
80101cdf:	bf 01 00 00 00       	mov    $0x1,%edi
80101ce4:	eb 21                	jmp    80101d07 <ialloc+0x47>
80101ce6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101ced:	8d 76 00             	lea    0x0(%esi),%esi
    brelse(bp);
80101cf0:	83 ec 0c             	sub    $0xc,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
80101cf3:	83 c7 01             	add    $0x1,%edi
    brelse(bp);
80101cf6:	53                   	push   %ebx
80101cf7:	e8 f4 e4 ff ff       	call   801001f0 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
80101cfc:	83 c4 10             	add    $0x10,%esp
80101cff:	3b 3d fc 31 11 80    	cmp    0x801131fc,%edi
80101d05:	73 69                	jae    80101d70 <ialloc+0xb0>
    bp = bread(dev, IBLOCK(inum, sb));
80101d07:	89 f8                	mov    %edi,%eax
80101d09:	83 ec 08             	sub    $0x8,%esp
80101d0c:	c1 e8 03             	shr    $0x3,%eax
80101d0f:	03 05 08 32 11 80    	add    0x80113208,%eax
80101d15:	50                   	push   %eax
80101d16:	56                   	push   %esi
80101d17:	e8 b4 e3 ff ff       	call   801000d0 <bread>
    if(dip->type == 0){  // a free inode
80101d1c:	83 c4 10             	add    $0x10,%esp
    bp = bread(dev, IBLOCK(inum, sb));
80101d1f:	89 c3                	mov    %eax,%ebx
    dip = (struct dinode*)bp->data + inum%IPB;
80101d21:	89 f8                	mov    %edi,%eax
80101d23:	83 e0 07             	and    $0x7,%eax
80101d26:	c1 e0 06             	shl    $0x6,%eax
80101d29:	8d 4c 03 5c          	lea    0x5c(%ebx,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
80101d2d:	66 83 39 00          	cmpw   $0x0,(%ecx)
80101d31:	75 bd                	jne    80101cf0 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
80101d33:	83 ec 04             	sub    $0x4,%esp
80101d36:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80101d39:	6a 40                	push   $0x40
80101d3b:	6a 00                	push   $0x0
80101d3d:	51                   	push   %ecx
80101d3e:	e8 cd 2f 00 00       	call   80104d10 <memset>
      dip->type = type;
80101d43:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
80101d47:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80101d4a:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
80101d4d:	89 1c 24             	mov    %ebx,(%esp)
80101d50:	e8 9b 18 00 00       	call   801035f0 <log_write>
      brelse(bp);
80101d55:	89 1c 24             	mov    %ebx,(%esp)
80101d58:	e8 93 e4 ff ff       	call   801001f0 <brelse>
      return iget(dev, inum);
80101d5d:	83 c4 10             	add    $0x10,%esp
}
80101d60:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return iget(dev, inum);
80101d63:	89 fa                	mov    %edi,%edx
}
80101d65:	5b                   	pop    %ebx
      return iget(dev, inum);
80101d66:	89 f0                	mov    %esi,%eax
}
80101d68:	5e                   	pop    %esi
80101d69:	5f                   	pop    %edi
80101d6a:	5d                   	pop    %ebp
      return iget(dev, inum);
80101d6b:	e9 90 fc ff ff       	jmp    80101a00 <iget>
  panic("ialloc: no inodes");
80101d70:	83 ec 0c             	sub    $0xc,%esp
80101d73:	68 b0 79 10 80       	push   $0x801079b0
80101d78:	e8 23 e6 ff ff       	call   801003a0 <panic>
80101d7d:	8d 76 00             	lea    0x0(%esi),%esi

80101d80 <iupdate>:
{
80101d80:	55                   	push   %ebp
80101d81:	89 e5                	mov    %esp,%ebp
80101d83:	56                   	push   %esi
80101d84:	53                   	push   %ebx
80101d85:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101d88:	8b 43 04             	mov    0x4(%ebx),%eax
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101d8b:	83 c3 5c             	add    $0x5c,%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101d8e:	83 ec 08             	sub    $0x8,%esp
80101d91:	c1 e8 03             	shr    $0x3,%eax
80101d94:	03 05 08 32 11 80    	add    0x80113208,%eax
80101d9a:	50                   	push   %eax
80101d9b:	ff 73 a4             	push   -0x5c(%ebx)
80101d9e:	e8 2d e3 ff ff       	call   801000d0 <bread>
  dip->type = ip->type;
80101da3:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101da7:	83 c4 0c             	add    $0xc,%esp
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101daa:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
80101dac:	8b 43 a8             	mov    -0x58(%ebx),%eax
80101daf:	83 e0 07             	and    $0x7,%eax
80101db2:	c1 e0 06             	shl    $0x6,%eax
80101db5:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
  dip->type = ip->type;
80101db9:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
80101dbc:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101dc0:	83 c0 0c             	add    $0xc,%eax
  dip->major = ip->major;
80101dc3:	66 89 50 f6          	mov    %dx,-0xa(%eax)
  dip->minor = ip->minor;
80101dc7:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
80101dcb:	66 89 50 f8          	mov    %dx,-0x8(%eax)
  dip->nlink = ip->nlink;
80101dcf:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
80101dd3:	66 89 50 fa          	mov    %dx,-0x6(%eax)
  dip->size = ip->size;
80101dd7:	8b 53 fc             	mov    -0x4(%ebx),%edx
80101dda:	89 50 fc             	mov    %edx,-0x4(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101ddd:	6a 34                	push   $0x34
80101ddf:	53                   	push   %ebx
80101de0:	50                   	push   %eax
80101de1:	e8 ca 2f 00 00       	call   80104db0 <memmove>
  log_write(bp);
80101de6:	89 34 24             	mov    %esi,(%esp)
80101de9:	e8 02 18 00 00       	call   801035f0 <log_write>
  brelse(bp);
80101dee:	89 75 08             	mov    %esi,0x8(%ebp)
80101df1:	83 c4 10             	add    $0x10,%esp
}
80101df4:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101df7:	5b                   	pop    %ebx
80101df8:	5e                   	pop    %esi
80101df9:	5d                   	pop    %ebp
  brelse(bp);
80101dfa:	e9 f1 e3 ff ff       	jmp    801001f0 <brelse>
80101dff:	90                   	nop

80101e00 <idup>:
{
80101e00:	55                   	push   %ebp
80101e01:	89 e5                	mov    %esp,%ebp
80101e03:	53                   	push   %ebx
80101e04:	83 ec 10             	sub    $0x10,%esp
80101e07:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
80101e0a:	68 a0 15 11 80       	push   $0x801115a0
80101e0f:	e8 3c 2e 00 00       	call   80104c50 <acquire>
  ip->ref++;
80101e14:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
80101e18:	c7 04 24 a0 15 11 80 	movl   $0x801115a0,(%esp)
80101e1f:	e8 cc 2d 00 00       	call   80104bf0 <release>
}
80101e24:	89 d8                	mov    %ebx,%eax
80101e26:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101e29:	c9                   	leave  
80101e2a:	c3                   	ret    
80101e2b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101e2f:	90                   	nop

80101e30 <ilock>:
{
80101e30:	55                   	push   %ebp
80101e31:	89 e5                	mov    %esp,%ebp
80101e33:	56                   	push   %esi
80101e34:	53                   	push   %ebx
80101e35:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || ip->ref < 1)
80101e38:	85 db                	test   %ebx,%ebx
80101e3a:	0f 84 b7 00 00 00    	je     80101ef7 <ilock+0xc7>
80101e40:	8b 53 08             	mov    0x8(%ebx),%edx
80101e43:	85 d2                	test   %edx,%edx
80101e45:	0f 8e ac 00 00 00    	jle    80101ef7 <ilock+0xc7>
  acquiresleep(&ip->lock);
80101e4b:	83 ec 0c             	sub    $0xc,%esp
80101e4e:	8d 43 0c             	lea    0xc(%ebx),%eax
80101e51:	50                   	push   %eax
80101e52:	e8 39 2b 00 00       	call   80104990 <acquiresleep>
  if(ip->valid == 0){
80101e57:	8b 43 4c             	mov    0x4c(%ebx),%eax
80101e5a:	83 c4 10             	add    $0x10,%esp
80101e5d:	85 c0                	test   %eax,%eax
80101e5f:	74 0f                	je     80101e70 <ilock+0x40>
}
80101e61:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101e64:	5b                   	pop    %ebx
80101e65:	5e                   	pop    %esi
80101e66:	5d                   	pop    %ebp
80101e67:	c3                   	ret    
80101e68:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101e6f:	90                   	nop
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101e70:	8b 43 04             	mov    0x4(%ebx),%eax
80101e73:	83 ec 08             	sub    $0x8,%esp
80101e76:	c1 e8 03             	shr    $0x3,%eax
80101e79:	03 05 08 32 11 80    	add    0x80113208,%eax
80101e7f:	50                   	push   %eax
80101e80:	ff 33                	push   (%ebx)
80101e82:	e8 49 e2 ff ff       	call   801000d0 <bread>
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101e87:	83 c4 0c             	add    $0xc,%esp
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101e8a:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
80101e8c:	8b 43 04             	mov    0x4(%ebx),%eax
80101e8f:	83 e0 07             	and    $0x7,%eax
80101e92:	c1 e0 06             	shl    $0x6,%eax
80101e95:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    ip->type = dip->type;
80101e99:	0f b7 10             	movzwl (%eax),%edx
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101e9c:	83 c0 0c             	add    $0xc,%eax
    ip->type = dip->type;
80101e9f:	66 89 53 50          	mov    %dx,0x50(%ebx)
    ip->major = dip->major;
80101ea3:	0f b7 50 f6          	movzwl -0xa(%eax),%edx
80101ea7:	66 89 53 52          	mov    %dx,0x52(%ebx)
    ip->minor = dip->minor;
80101eab:	0f b7 50 f8          	movzwl -0x8(%eax),%edx
80101eaf:	66 89 53 54          	mov    %dx,0x54(%ebx)
    ip->nlink = dip->nlink;
80101eb3:	0f b7 50 fa          	movzwl -0x6(%eax),%edx
80101eb7:	66 89 53 56          	mov    %dx,0x56(%ebx)
    ip->size = dip->size;
80101ebb:	8b 50 fc             	mov    -0x4(%eax),%edx
80101ebe:	89 53 58             	mov    %edx,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101ec1:	6a 34                	push   $0x34
80101ec3:	50                   	push   %eax
80101ec4:	8d 43 5c             	lea    0x5c(%ebx),%eax
80101ec7:	50                   	push   %eax
80101ec8:	e8 e3 2e 00 00       	call   80104db0 <memmove>
    brelse(bp);
80101ecd:	89 34 24             	mov    %esi,(%esp)
80101ed0:	e8 1b e3 ff ff       	call   801001f0 <brelse>
    if(ip->type == 0)
80101ed5:	83 c4 10             	add    $0x10,%esp
80101ed8:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
    ip->valid = 1;
80101edd:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if(ip->type == 0)
80101ee4:	0f 85 77 ff ff ff    	jne    80101e61 <ilock+0x31>
      panic("ilock: no type");
80101eea:	83 ec 0c             	sub    $0xc,%esp
80101eed:	68 c8 79 10 80       	push   $0x801079c8
80101ef2:	e8 a9 e4 ff ff       	call   801003a0 <panic>
    panic("ilock");
80101ef7:	83 ec 0c             	sub    $0xc,%esp
80101efa:	68 c2 79 10 80       	push   $0x801079c2
80101eff:	e8 9c e4 ff ff       	call   801003a0 <panic>
80101f04:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101f0b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101f0f:	90                   	nop

80101f10 <iunlock>:
{
80101f10:	55                   	push   %ebp
80101f11:	89 e5                	mov    %esp,%ebp
80101f13:	56                   	push   %esi
80101f14:	53                   	push   %ebx
80101f15:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101f18:	85 db                	test   %ebx,%ebx
80101f1a:	74 28                	je     80101f44 <iunlock+0x34>
80101f1c:	83 ec 0c             	sub    $0xc,%esp
80101f1f:	8d 73 0c             	lea    0xc(%ebx),%esi
80101f22:	56                   	push   %esi
80101f23:	e8 08 2b 00 00       	call   80104a30 <holdingsleep>
80101f28:	83 c4 10             	add    $0x10,%esp
80101f2b:	85 c0                	test   %eax,%eax
80101f2d:	74 15                	je     80101f44 <iunlock+0x34>
80101f2f:	8b 43 08             	mov    0x8(%ebx),%eax
80101f32:	85 c0                	test   %eax,%eax
80101f34:	7e 0e                	jle    80101f44 <iunlock+0x34>
  releasesleep(&ip->lock);
80101f36:	89 75 08             	mov    %esi,0x8(%ebp)
}
80101f39:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101f3c:	5b                   	pop    %ebx
80101f3d:	5e                   	pop    %esi
80101f3e:	5d                   	pop    %ebp
  releasesleep(&ip->lock);
80101f3f:	e9 ac 2a 00 00       	jmp    801049f0 <releasesleep>
    panic("iunlock");
80101f44:	83 ec 0c             	sub    $0xc,%esp
80101f47:	68 d7 79 10 80       	push   $0x801079d7
80101f4c:	e8 4f e4 ff ff       	call   801003a0 <panic>
80101f51:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101f58:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101f5f:	90                   	nop

80101f60 <iput>:
{
80101f60:	55                   	push   %ebp
80101f61:	89 e5                	mov    %esp,%ebp
80101f63:	57                   	push   %edi
80101f64:	56                   	push   %esi
80101f65:	53                   	push   %ebx
80101f66:	83 ec 28             	sub    $0x28,%esp
80101f69:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquiresleep(&ip->lock);
80101f6c:	8d 7b 0c             	lea    0xc(%ebx),%edi
80101f6f:	57                   	push   %edi
80101f70:	e8 1b 2a 00 00       	call   80104990 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
80101f75:	8b 53 4c             	mov    0x4c(%ebx),%edx
80101f78:	83 c4 10             	add    $0x10,%esp
80101f7b:	85 d2                	test   %edx,%edx
80101f7d:	74 07                	je     80101f86 <iput+0x26>
80101f7f:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80101f84:	74 32                	je     80101fb8 <iput+0x58>
  releasesleep(&ip->lock);
80101f86:	83 ec 0c             	sub    $0xc,%esp
80101f89:	57                   	push   %edi
80101f8a:	e8 61 2a 00 00       	call   801049f0 <releasesleep>
  acquire(&icache.lock);
80101f8f:	c7 04 24 a0 15 11 80 	movl   $0x801115a0,(%esp)
80101f96:	e8 b5 2c 00 00       	call   80104c50 <acquire>
  ip->ref--;
80101f9b:	83 6b 08 01          	subl   $0x1,0x8(%ebx)
  release(&icache.lock);
80101f9f:	83 c4 10             	add    $0x10,%esp
80101fa2:	c7 45 08 a0 15 11 80 	movl   $0x801115a0,0x8(%ebp)
}
80101fa9:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101fac:	5b                   	pop    %ebx
80101fad:	5e                   	pop    %esi
80101fae:	5f                   	pop    %edi
80101faf:	5d                   	pop    %ebp
  release(&icache.lock);
80101fb0:	e9 3b 2c 00 00       	jmp    80104bf0 <release>
80101fb5:	8d 76 00             	lea    0x0(%esi),%esi
    acquire(&icache.lock);
80101fb8:	83 ec 0c             	sub    $0xc,%esp
80101fbb:	68 a0 15 11 80       	push   $0x801115a0
80101fc0:	e8 8b 2c 00 00       	call   80104c50 <acquire>
    int r = ip->ref;
80101fc5:	8b 73 08             	mov    0x8(%ebx),%esi
    release(&icache.lock);
80101fc8:	c7 04 24 a0 15 11 80 	movl   $0x801115a0,(%esp)
80101fcf:	e8 1c 2c 00 00       	call   80104bf0 <release>
    if(r == 1){
80101fd4:	83 c4 10             	add    $0x10,%esp
80101fd7:	83 fe 01             	cmp    $0x1,%esi
80101fda:	75 aa                	jne    80101f86 <iput+0x26>
80101fdc:	8d 8b 8c 00 00 00    	lea    0x8c(%ebx),%ecx
80101fe2:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80101fe5:	8d 73 5c             	lea    0x5c(%ebx),%esi
80101fe8:	89 cf                	mov    %ecx,%edi
80101fea:	eb 0b                	jmp    80101ff7 <iput+0x97>
80101fec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101ff0:	83 c6 04             	add    $0x4,%esi
80101ff3:	39 fe                	cmp    %edi,%esi
80101ff5:	74 19                	je     80102010 <iput+0xb0>
    if(ip->addrs[i]){
80101ff7:	8b 16                	mov    (%esi),%edx
80101ff9:	85 d2                	test   %edx,%edx
80101ffb:	74 f3                	je     80101ff0 <iput+0x90>
      bfree(ip->dev, ip->addrs[i]);
80101ffd:	8b 03                	mov    (%ebx),%eax
80101fff:	e8 6c f8 ff ff       	call   80101870 <bfree>
      ip->addrs[i] = 0;
80102004:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
8010200a:	eb e4                	jmp    80101ff0 <iput+0x90>
8010200c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  if(ip->addrs[NDIRECT]){
80102010:	8b 83 8c 00 00 00    	mov    0x8c(%ebx),%eax
80102016:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80102019:	85 c0                	test   %eax,%eax
8010201b:	75 2d                	jne    8010204a <iput+0xea>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
  iupdate(ip);
8010201d:	83 ec 0c             	sub    $0xc,%esp
  ip->size = 0;
80102020:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  iupdate(ip);
80102027:	53                   	push   %ebx
80102028:	e8 53 fd ff ff       	call   80101d80 <iupdate>
      ip->type = 0;
8010202d:	31 c0                	xor    %eax,%eax
8010202f:	66 89 43 50          	mov    %ax,0x50(%ebx)
      iupdate(ip);
80102033:	89 1c 24             	mov    %ebx,(%esp)
80102036:	e8 45 fd ff ff       	call   80101d80 <iupdate>
      ip->valid = 0;
8010203b:	c7 43 4c 00 00 00 00 	movl   $0x0,0x4c(%ebx)
80102042:	83 c4 10             	add    $0x10,%esp
80102045:	e9 3c ff ff ff       	jmp    80101f86 <iput+0x26>
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
8010204a:	83 ec 08             	sub    $0x8,%esp
8010204d:	50                   	push   %eax
8010204e:	ff 33                	push   (%ebx)
80102050:	e8 7b e0 ff ff       	call   801000d0 <bread>
80102055:	89 7d e0             	mov    %edi,-0x20(%ebp)
80102058:	83 c4 10             	add    $0x10,%esp
8010205b:	8d 88 5c 02 00 00    	lea    0x25c(%eax),%ecx
80102061:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(j = 0; j < NINDIRECT; j++){
80102064:	8d 70 5c             	lea    0x5c(%eax),%esi
80102067:	89 cf                	mov    %ecx,%edi
80102069:	eb 0c                	jmp    80102077 <iput+0x117>
8010206b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010206f:	90                   	nop
80102070:	83 c6 04             	add    $0x4,%esi
80102073:	39 f7                	cmp    %esi,%edi
80102075:	74 0f                	je     80102086 <iput+0x126>
      if(a[j])
80102077:	8b 16                	mov    (%esi),%edx
80102079:	85 d2                	test   %edx,%edx
8010207b:	74 f3                	je     80102070 <iput+0x110>
        bfree(ip->dev, a[j]);
8010207d:	8b 03                	mov    (%ebx),%eax
8010207f:	e8 ec f7 ff ff       	call   80101870 <bfree>
80102084:	eb ea                	jmp    80102070 <iput+0x110>
    brelse(bp);
80102086:	83 ec 0c             	sub    $0xc,%esp
80102089:	ff 75 e4             	push   -0x1c(%ebp)
8010208c:	8b 7d e0             	mov    -0x20(%ebp),%edi
8010208f:	e8 5c e1 ff ff       	call   801001f0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
80102094:	8b 93 8c 00 00 00    	mov    0x8c(%ebx),%edx
8010209a:	8b 03                	mov    (%ebx),%eax
8010209c:	e8 cf f7 ff ff       	call   80101870 <bfree>
    ip->addrs[NDIRECT] = 0;
801020a1:	83 c4 10             	add    $0x10,%esp
801020a4:	c7 83 8c 00 00 00 00 	movl   $0x0,0x8c(%ebx)
801020ab:	00 00 00 
801020ae:	e9 6a ff ff ff       	jmp    8010201d <iput+0xbd>
801020b3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801020ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801020c0 <iunlockput>:
{
801020c0:	55                   	push   %ebp
801020c1:	89 e5                	mov    %esp,%ebp
801020c3:	56                   	push   %esi
801020c4:	53                   	push   %ebx
801020c5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
801020c8:	85 db                	test   %ebx,%ebx
801020ca:	74 34                	je     80102100 <iunlockput+0x40>
801020cc:	83 ec 0c             	sub    $0xc,%esp
801020cf:	8d 73 0c             	lea    0xc(%ebx),%esi
801020d2:	56                   	push   %esi
801020d3:	e8 58 29 00 00       	call   80104a30 <holdingsleep>
801020d8:	83 c4 10             	add    $0x10,%esp
801020db:	85 c0                	test   %eax,%eax
801020dd:	74 21                	je     80102100 <iunlockput+0x40>
801020df:	8b 43 08             	mov    0x8(%ebx),%eax
801020e2:	85 c0                	test   %eax,%eax
801020e4:	7e 1a                	jle    80102100 <iunlockput+0x40>
  releasesleep(&ip->lock);
801020e6:	83 ec 0c             	sub    $0xc,%esp
801020e9:	56                   	push   %esi
801020ea:	e8 01 29 00 00       	call   801049f0 <releasesleep>
  iput(ip);
801020ef:	89 5d 08             	mov    %ebx,0x8(%ebp)
801020f2:	83 c4 10             	add    $0x10,%esp
}
801020f5:	8d 65 f8             	lea    -0x8(%ebp),%esp
801020f8:	5b                   	pop    %ebx
801020f9:	5e                   	pop    %esi
801020fa:	5d                   	pop    %ebp
  iput(ip);
801020fb:	e9 60 fe ff ff       	jmp    80101f60 <iput>
    panic("iunlock");
80102100:	83 ec 0c             	sub    $0xc,%esp
80102103:	68 d7 79 10 80       	push   $0x801079d7
80102108:	e8 93 e2 ff ff       	call   801003a0 <panic>
8010210d:	8d 76 00             	lea    0x0(%esi),%esi

80102110 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
80102110:	55                   	push   %ebp
80102111:	89 e5                	mov    %esp,%ebp
80102113:	8b 55 08             	mov    0x8(%ebp),%edx
80102116:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
80102119:	8b 0a                	mov    (%edx),%ecx
8010211b:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
8010211e:	8b 4a 04             	mov    0x4(%edx),%ecx
80102121:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
80102124:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
80102128:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
8010212b:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
8010212f:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
80102133:	8b 52 58             	mov    0x58(%edx),%edx
80102136:	89 50 10             	mov    %edx,0x10(%eax)
}
80102139:	5d                   	pop    %ebp
8010213a:	c3                   	ret    
8010213b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010213f:	90                   	nop

80102140 <readi>:
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80102140:	55                   	push   %ebp
80102141:	89 e5                	mov    %esp,%ebp
80102143:	57                   	push   %edi
80102144:	56                   	push   %esi
80102145:	53                   	push   %ebx
80102146:	83 ec 1c             	sub    $0x1c,%esp
80102149:	8b 7d 0c             	mov    0xc(%ebp),%edi
8010214c:	8b 45 08             	mov    0x8(%ebp),%eax
8010214f:	8b 75 10             	mov    0x10(%ebp),%esi
80102152:	89 7d e0             	mov    %edi,-0x20(%ebp)
80102155:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80102158:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
8010215d:	89 45 d8             	mov    %eax,-0x28(%ebp)
80102160:	89 7d e4             	mov    %edi,-0x1c(%ebp)
  if(ip->type == T_DEV){
80102163:	0f 84 a7 00 00 00    	je     80102210 <readi+0xd0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
80102169:	8b 45 d8             	mov    -0x28(%ebp),%eax
8010216c:	8b 40 58             	mov    0x58(%eax),%eax
8010216f:	39 c6                	cmp    %eax,%esi
80102171:	0f 87 ba 00 00 00    	ja     80102231 <readi+0xf1>
80102177:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
8010217a:	31 c9                	xor    %ecx,%ecx
8010217c:	89 da                	mov    %ebx,%edx
8010217e:	01 f2                	add    %esi,%edx
80102180:	0f 92 c1             	setb   %cl
80102183:	89 cf                	mov    %ecx,%edi
80102185:	0f 82 a6 00 00 00    	jb     80102231 <readi+0xf1>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
8010218b:	89 c1                	mov    %eax,%ecx
8010218d:	29 f1                	sub    %esi,%ecx
8010218f:	39 d0                	cmp    %edx,%eax
80102191:	0f 43 cb             	cmovae %ebx,%ecx
80102194:	89 4d e4             	mov    %ecx,-0x1c(%ebp)

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80102197:	85 c9                	test   %ecx,%ecx
80102199:	74 67                	je     80102202 <readi+0xc2>
8010219b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010219f:	90                   	nop
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
801021a0:	8b 5d d8             	mov    -0x28(%ebp),%ebx
801021a3:	89 f2                	mov    %esi,%edx
801021a5:	c1 ea 09             	shr    $0x9,%edx
801021a8:	89 d8                	mov    %ebx,%eax
801021aa:	e8 51 f9 ff ff       	call   80101b00 <bmap>
801021af:	83 ec 08             	sub    $0x8,%esp
801021b2:	50                   	push   %eax
801021b3:	ff 33                	push   (%ebx)
801021b5:	e8 16 df ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
801021ba:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
801021bd:	b9 00 02 00 00       	mov    $0x200,%ecx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
801021c2:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
801021c4:	89 f0                	mov    %esi,%eax
801021c6:	25 ff 01 00 00       	and    $0x1ff,%eax
801021cb:	29 fb                	sub    %edi,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
801021cd:	89 55 dc             	mov    %edx,-0x24(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
801021d0:	29 c1                	sub    %eax,%ecx
    memmove(dst, bp->data + off%BSIZE, m);
801021d2:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
801021d6:	39 d9                	cmp    %ebx,%ecx
801021d8:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
801021db:	83 c4 0c             	add    $0xc,%esp
801021de:	53                   	push   %ebx
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
801021df:	01 df                	add    %ebx,%edi
801021e1:	01 de                	add    %ebx,%esi
    memmove(dst, bp->data + off%BSIZE, m);
801021e3:	50                   	push   %eax
801021e4:	ff 75 e0             	push   -0x20(%ebp)
801021e7:	e8 c4 2b 00 00       	call   80104db0 <memmove>
    brelse(bp);
801021ec:	8b 55 dc             	mov    -0x24(%ebp),%edx
801021ef:	89 14 24             	mov    %edx,(%esp)
801021f2:	e8 f9 df ff ff       	call   801001f0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
801021f7:	01 5d e0             	add    %ebx,-0x20(%ebp)
801021fa:	83 c4 10             	add    $0x10,%esp
801021fd:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80102200:	77 9e                	ja     801021a0 <readi+0x60>
  }
  return n;
80102202:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
80102205:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102208:	5b                   	pop    %ebx
80102209:	5e                   	pop    %esi
8010220a:	5f                   	pop    %edi
8010220b:	5d                   	pop    %ebp
8010220c:	c3                   	ret    
8010220d:	8d 76 00             	lea    0x0(%esi),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80102210:	0f bf 40 52          	movswl 0x52(%eax),%eax
80102214:	66 83 f8 09          	cmp    $0x9,%ax
80102218:	77 17                	ja     80102231 <readi+0xf1>
8010221a:	8b 04 c5 40 15 11 80 	mov    -0x7feeeac0(,%eax,8),%eax
80102221:	85 c0                	test   %eax,%eax
80102223:	74 0c                	je     80102231 <readi+0xf1>
    return devsw[ip->major].read(ip, dst, n);
80102225:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80102228:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010222b:	5b                   	pop    %ebx
8010222c:	5e                   	pop    %esi
8010222d:	5f                   	pop    %edi
8010222e:	5d                   	pop    %ebp
    return devsw[ip->major].read(ip, dst, n);
8010222f:	ff e0                	jmp    *%eax
      return -1;
80102231:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102236:	eb cd                	jmp    80102205 <readi+0xc5>
80102238:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010223f:	90                   	nop

80102240 <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80102240:	55                   	push   %ebp
80102241:	89 e5                	mov    %esp,%ebp
80102243:	57                   	push   %edi
80102244:	56                   	push   %esi
80102245:	53                   	push   %ebx
80102246:	83 ec 1c             	sub    $0x1c,%esp
80102249:	8b 45 08             	mov    0x8(%ebp),%eax
8010224c:	8b 75 0c             	mov    0xc(%ebp),%esi
8010224f:	8b 55 14             	mov    0x14(%ebp),%edx
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80102252:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80102257:	89 75 dc             	mov    %esi,-0x24(%ebp)
8010225a:	89 45 d8             	mov    %eax,-0x28(%ebp)
8010225d:	8b 75 10             	mov    0x10(%ebp),%esi
80102260:	89 55 e0             	mov    %edx,-0x20(%ebp)
  if(ip->type == T_DEV){
80102263:	0f 84 b7 00 00 00    	je     80102320 <writei+0xe0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
80102269:	8b 45 d8             	mov    -0x28(%ebp),%eax
8010226c:	3b 70 58             	cmp    0x58(%eax),%esi
8010226f:	0f 87 e7 00 00 00    	ja     8010235c <writei+0x11c>
80102275:	8b 7d e0             	mov    -0x20(%ebp),%edi
80102278:	31 d2                	xor    %edx,%edx
8010227a:	89 f8                	mov    %edi,%eax
8010227c:	01 f0                	add    %esi,%eax
8010227e:	0f 92 c2             	setb   %dl
    return -1;
  if(off + n > MAXFILE*BSIZE)
80102281:	3d 00 18 01 00       	cmp    $0x11800,%eax
80102286:	0f 87 d0 00 00 00    	ja     8010235c <writei+0x11c>
8010228c:	85 d2                	test   %edx,%edx
8010228e:	0f 85 c8 00 00 00    	jne    8010235c <writei+0x11c>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80102294:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
8010229b:	85 ff                	test   %edi,%edi
8010229d:	74 72                	je     80102311 <writei+0xd1>
8010229f:	90                   	nop
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
801022a0:	8b 7d d8             	mov    -0x28(%ebp),%edi
801022a3:	89 f2                	mov    %esi,%edx
801022a5:	c1 ea 09             	shr    $0x9,%edx
801022a8:	89 f8                	mov    %edi,%eax
801022aa:	e8 51 f8 ff ff       	call   80101b00 <bmap>
801022af:	83 ec 08             	sub    $0x8,%esp
801022b2:	50                   	push   %eax
801022b3:	ff 37                	push   (%edi)
801022b5:	e8 16 de ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
801022ba:	b9 00 02 00 00       	mov    $0x200,%ecx
801022bf:	8b 5d e0             	mov    -0x20(%ebp),%ebx
801022c2:	2b 5d e4             	sub    -0x1c(%ebp),%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
801022c5:	89 c7                	mov    %eax,%edi
    m = min(n - tot, BSIZE - off%BSIZE);
801022c7:	89 f0                	mov    %esi,%eax
801022c9:	25 ff 01 00 00       	and    $0x1ff,%eax
801022ce:	29 c1                	sub    %eax,%ecx
    memmove(bp->data + off%BSIZE, src, m);
801022d0:	8d 44 07 5c          	lea    0x5c(%edi,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
801022d4:	39 d9                	cmp    %ebx,%ecx
801022d6:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(bp->data + off%BSIZE, src, m);
801022d9:	83 c4 0c             	add    $0xc,%esp
801022dc:	53                   	push   %ebx
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
801022dd:	01 de                	add    %ebx,%esi
    memmove(bp->data + off%BSIZE, src, m);
801022df:	ff 75 dc             	push   -0x24(%ebp)
801022e2:	50                   	push   %eax
801022e3:	e8 c8 2a 00 00       	call   80104db0 <memmove>
    log_write(bp);
801022e8:	89 3c 24             	mov    %edi,(%esp)
801022eb:	e8 00 13 00 00       	call   801035f0 <log_write>
    brelse(bp);
801022f0:	89 3c 24             	mov    %edi,(%esp)
801022f3:	e8 f8 de ff ff       	call   801001f0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
801022f8:	01 5d e4             	add    %ebx,-0x1c(%ebp)
801022fb:	83 c4 10             	add    $0x10,%esp
801022fe:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80102301:	01 5d dc             	add    %ebx,-0x24(%ebp)
80102304:	39 45 e0             	cmp    %eax,-0x20(%ebp)
80102307:	77 97                	ja     801022a0 <writei+0x60>
  }

  if(n > 0 && off > ip->size){
80102309:	8b 45 d8             	mov    -0x28(%ebp),%eax
8010230c:	3b 70 58             	cmp    0x58(%eax),%esi
8010230f:	77 37                	ja     80102348 <writei+0x108>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80102311:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80102314:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102317:	5b                   	pop    %ebx
80102318:	5e                   	pop    %esi
80102319:	5f                   	pop    %edi
8010231a:	5d                   	pop    %ebp
8010231b:	c3                   	ret    
8010231c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80102320:	0f bf 40 52          	movswl 0x52(%eax),%eax
80102324:	66 83 f8 09          	cmp    $0x9,%ax
80102328:	77 32                	ja     8010235c <writei+0x11c>
8010232a:	8b 04 c5 44 15 11 80 	mov    -0x7feeeabc(,%eax,8),%eax
80102331:	85 c0                	test   %eax,%eax
80102333:	74 27                	je     8010235c <writei+0x11c>
    return devsw[ip->major].write(ip, src, n);
80102335:	89 55 10             	mov    %edx,0x10(%ebp)
}
80102338:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010233b:	5b                   	pop    %ebx
8010233c:	5e                   	pop    %esi
8010233d:	5f                   	pop    %edi
8010233e:	5d                   	pop    %ebp
    return devsw[ip->major].write(ip, src, n);
8010233f:	ff e0                	jmp    *%eax
80102341:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    ip->size = off;
80102348:	8b 45 d8             	mov    -0x28(%ebp),%eax
    iupdate(ip);
8010234b:	83 ec 0c             	sub    $0xc,%esp
    ip->size = off;
8010234e:	89 70 58             	mov    %esi,0x58(%eax)
    iupdate(ip);
80102351:	50                   	push   %eax
80102352:	e8 29 fa ff ff       	call   80101d80 <iupdate>
80102357:	83 c4 10             	add    $0x10,%esp
8010235a:	eb b5                	jmp    80102311 <writei+0xd1>
      return -1;
8010235c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102361:	eb b1                	jmp    80102314 <writei+0xd4>
80102363:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010236a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102370 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80102370:	55                   	push   %ebp
80102371:	89 e5                	mov    %esp,%ebp
80102373:	83 ec 0c             	sub    $0xc,%esp
  return strncmp(s, t, DIRSIZ);
80102376:	6a 0e                	push   $0xe
80102378:	ff 75 0c             	push   0xc(%ebp)
8010237b:	ff 75 08             	push   0x8(%ebp)
8010237e:	e8 9d 2a 00 00       	call   80104e20 <strncmp>
}
80102383:	c9                   	leave  
80102384:	c3                   	ret    
80102385:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010238c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102390 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80102390:	55                   	push   %ebp
80102391:	89 e5                	mov    %esp,%ebp
80102393:	57                   	push   %edi
80102394:	56                   	push   %esi
80102395:	53                   	push   %ebx
80102396:	83 ec 1c             	sub    $0x1c,%esp
80102399:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
8010239c:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801023a1:	0f 85 85 00 00 00    	jne    8010242c <dirlookup+0x9c>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
801023a7:	8b 53 58             	mov    0x58(%ebx),%edx
801023aa:	31 ff                	xor    %edi,%edi
801023ac:	8d 75 d8             	lea    -0x28(%ebp),%esi
801023af:	85 d2                	test   %edx,%edx
801023b1:	74 3e                	je     801023f1 <dirlookup+0x61>
801023b3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801023b7:	90                   	nop
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801023b8:	6a 10                	push   $0x10
801023ba:	57                   	push   %edi
801023bb:	56                   	push   %esi
801023bc:	53                   	push   %ebx
801023bd:	e8 7e fd ff ff       	call   80102140 <readi>
801023c2:	83 c4 10             	add    $0x10,%esp
801023c5:	83 f8 10             	cmp    $0x10,%eax
801023c8:	75 55                	jne    8010241f <dirlookup+0x8f>
      panic("dirlookup read");
    if(de.inum == 0)
801023ca:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
801023cf:	74 18                	je     801023e9 <dirlookup+0x59>
  return strncmp(s, t, DIRSIZ);
801023d1:	83 ec 04             	sub    $0x4,%esp
801023d4:	8d 45 da             	lea    -0x26(%ebp),%eax
801023d7:	6a 0e                	push   $0xe
801023d9:	50                   	push   %eax
801023da:	ff 75 0c             	push   0xc(%ebp)
801023dd:	e8 3e 2a 00 00       	call   80104e20 <strncmp>
      continue;
    if(namecmp(name, de.name) == 0){
801023e2:	83 c4 10             	add    $0x10,%esp
801023e5:	85 c0                	test   %eax,%eax
801023e7:	74 17                	je     80102400 <dirlookup+0x70>
  for(off = 0; off < dp->size; off += sizeof(de)){
801023e9:	83 c7 10             	add    $0x10,%edi
801023ec:	3b 7b 58             	cmp    0x58(%ebx),%edi
801023ef:	72 c7                	jb     801023b8 <dirlookup+0x28>
      return iget(dp->dev, inum);
    }
  }

  return 0;
}
801023f1:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801023f4:	31 c0                	xor    %eax,%eax
}
801023f6:	5b                   	pop    %ebx
801023f7:	5e                   	pop    %esi
801023f8:	5f                   	pop    %edi
801023f9:	5d                   	pop    %ebp
801023fa:	c3                   	ret    
801023fb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801023ff:	90                   	nop
      if(poff)
80102400:	8b 45 10             	mov    0x10(%ebp),%eax
80102403:	85 c0                	test   %eax,%eax
80102405:	74 05                	je     8010240c <dirlookup+0x7c>
        *poff = off;
80102407:	8b 45 10             	mov    0x10(%ebp),%eax
8010240a:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
8010240c:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
      return iget(dp->dev, inum);
80102410:	8b 03                	mov    (%ebx),%eax
80102412:	e8 e9 f5 ff ff       	call   80101a00 <iget>
}
80102417:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010241a:	5b                   	pop    %ebx
8010241b:	5e                   	pop    %esi
8010241c:	5f                   	pop    %edi
8010241d:	5d                   	pop    %ebp
8010241e:	c3                   	ret    
      panic("dirlookup read");
8010241f:	83 ec 0c             	sub    $0xc,%esp
80102422:	68 f1 79 10 80       	push   $0x801079f1
80102427:	e8 74 df ff ff       	call   801003a0 <panic>
    panic("dirlookup not DIR");
8010242c:	83 ec 0c             	sub    $0xc,%esp
8010242f:	68 df 79 10 80       	push   $0x801079df
80102434:	e8 67 df ff ff       	call   801003a0 <panic>
80102439:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102440 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80102440:	55                   	push   %ebp
80102441:	89 e5                	mov    %esp,%ebp
80102443:	57                   	push   %edi
80102444:	56                   	push   %esi
80102445:	53                   	push   %ebx
80102446:	89 c3                	mov    %eax,%ebx
80102448:	83 ec 1c             	sub    $0x1c,%esp
  struct inode *ip, *next;

  if(*path == '/')
8010244b:	80 38 2f             	cmpb   $0x2f,(%eax)
{
8010244e:	89 55 dc             	mov    %edx,-0x24(%ebp)
80102451:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  if(*path == '/')
80102454:	0f 84 64 01 00 00    	je     801025be <namex+0x17e>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
8010245a:	e8 c1 1b 00 00       	call   80104020 <myproc>
  acquire(&icache.lock);
8010245f:	83 ec 0c             	sub    $0xc,%esp
    ip = idup(myproc()->cwd);
80102462:	8b 70 68             	mov    0x68(%eax),%esi
  acquire(&icache.lock);
80102465:	68 a0 15 11 80       	push   $0x801115a0
8010246a:	e8 e1 27 00 00       	call   80104c50 <acquire>
  ip->ref++;
8010246f:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80102473:	c7 04 24 a0 15 11 80 	movl   $0x801115a0,(%esp)
8010247a:	e8 71 27 00 00       	call   80104bf0 <release>
8010247f:	83 c4 10             	add    $0x10,%esp
80102482:	eb 07                	jmp    8010248b <namex+0x4b>
80102484:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
80102488:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
8010248b:	0f b6 03             	movzbl (%ebx),%eax
8010248e:	3c 2f                	cmp    $0x2f,%al
80102490:	74 f6                	je     80102488 <namex+0x48>
  if(*path == 0)
80102492:	84 c0                	test   %al,%al
80102494:	0f 84 06 01 00 00    	je     801025a0 <namex+0x160>
  while(*path != '/' && *path != 0)
8010249a:	0f b6 03             	movzbl (%ebx),%eax
8010249d:	84 c0                	test   %al,%al
8010249f:	0f 84 10 01 00 00    	je     801025b5 <namex+0x175>
801024a5:	89 df                	mov    %ebx,%edi
801024a7:	3c 2f                	cmp    $0x2f,%al
801024a9:	0f 84 06 01 00 00    	je     801025b5 <namex+0x175>
801024af:	90                   	nop
801024b0:	0f b6 47 01          	movzbl 0x1(%edi),%eax
    path++;
801024b4:	83 c7 01             	add    $0x1,%edi
  while(*path != '/' && *path != 0)
801024b7:	3c 2f                	cmp    $0x2f,%al
801024b9:	74 04                	je     801024bf <namex+0x7f>
801024bb:	84 c0                	test   %al,%al
801024bd:	75 f1                	jne    801024b0 <namex+0x70>
  len = path - s;
801024bf:	89 f8                	mov    %edi,%eax
801024c1:	29 d8                	sub    %ebx,%eax
  if(len >= DIRSIZ)
801024c3:	83 f8 0d             	cmp    $0xd,%eax
801024c6:	0f 8e ac 00 00 00    	jle    80102578 <namex+0x138>
    memmove(name, s, DIRSIZ);
801024cc:	83 ec 04             	sub    $0x4,%esp
801024cf:	6a 0e                	push   $0xe
801024d1:	53                   	push   %ebx
    path++;
801024d2:	89 fb                	mov    %edi,%ebx
    memmove(name, s, DIRSIZ);
801024d4:	ff 75 e4             	push   -0x1c(%ebp)
801024d7:	e8 d4 28 00 00       	call   80104db0 <memmove>
801024dc:	83 c4 10             	add    $0x10,%esp
  while(*path == '/')
801024df:	80 3f 2f             	cmpb   $0x2f,(%edi)
801024e2:	75 0c                	jne    801024f0 <namex+0xb0>
801024e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
801024e8:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
801024eb:	80 3b 2f             	cmpb   $0x2f,(%ebx)
801024ee:	74 f8                	je     801024e8 <namex+0xa8>

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
801024f0:	83 ec 0c             	sub    $0xc,%esp
801024f3:	56                   	push   %esi
801024f4:	e8 37 f9 ff ff       	call   80101e30 <ilock>
    if(ip->type != T_DIR){
801024f9:	83 c4 10             	add    $0x10,%esp
801024fc:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80102501:	0f 85 cd 00 00 00    	jne    801025d4 <namex+0x194>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80102507:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010250a:	85 c0                	test   %eax,%eax
8010250c:	74 09                	je     80102517 <namex+0xd7>
8010250e:	80 3b 00             	cmpb   $0x0,(%ebx)
80102511:	0f 84 22 01 00 00    	je     80102639 <namex+0x1f9>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80102517:	83 ec 04             	sub    $0x4,%esp
8010251a:	6a 00                	push   $0x0
8010251c:	ff 75 e4             	push   -0x1c(%ebp)
8010251f:	56                   	push   %esi
80102520:	e8 6b fe ff ff       	call   80102390 <dirlookup>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80102525:	8d 56 0c             	lea    0xc(%esi),%edx
    if((next = dirlookup(ip, name, 0)) == 0){
80102528:	83 c4 10             	add    $0x10,%esp
8010252b:	89 c7                	mov    %eax,%edi
8010252d:	85 c0                	test   %eax,%eax
8010252f:	0f 84 e1 00 00 00    	je     80102616 <namex+0x1d6>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80102535:	83 ec 0c             	sub    $0xc,%esp
80102538:	89 55 e0             	mov    %edx,-0x20(%ebp)
8010253b:	52                   	push   %edx
8010253c:	e8 ef 24 00 00       	call   80104a30 <holdingsleep>
80102541:	83 c4 10             	add    $0x10,%esp
80102544:	85 c0                	test   %eax,%eax
80102546:	0f 84 30 01 00 00    	je     8010267c <namex+0x23c>
8010254c:	8b 56 08             	mov    0x8(%esi),%edx
8010254f:	85 d2                	test   %edx,%edx
80102551:	0f 8e 25 01 00 00    	jle    8010267c <namex+0x23c>
  releasesleep(&ip->lock);
80102557:	8b 55 e0             	mov    -0x20(%ebp),%edx
8010255a:	83 ec 0c             	sub    $0xc,%esp
8010255d:	52                   	push   %edx
8010255e:	e8 8d 24 00 00       	call   801049f0 <releasesleep>
  iput(ip);
80102563:	89 34 24             	mov    %esi,(%esp)
80102566:	89 fe                	mov    %edi,%esi
80102568:	e8 f3 f9 ff ff       	call   80101f60 <iput>
8010256d:	83 c4 10             	add    $0x10,%esp
80102570:	e9 16 ff ff ff       	jmp    8010248b <namex+0x4b>
80102575:	8d 76 00             	lea    0x0(%esi),%esi
    name[len] = 0;
80102578:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
8010257b:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    memmove(name, s, len);
8010257e:	83 ec 04             	sub    $0x4,%esp
80102581:	89 55 e0             	mov    %edx,-0x20(%ebp)
80102584:	50                   	push   %eax
80102585:	53                   	push   %ebx
    name[len] = 0;
80102586:	89 fb                	mov    %edi,%ebx
    memmove(name, s, len);
80102588:	ff 75 e4             	push   -0x1c(%ebp)
8010258b:	e8 20 28 00 00       	call   80104db0 <memmove>
    name[len] = 0;
80102590:	8b 55 e0             	mov    -0x20(%ebp),%edx
80102593:	83 c4 10             	add    $0x10,%esp
80102596:	c6 02 00             	movb   $0x0,(%edx)
80102599:	e9 41 ff ff ff       	jmp    801024df <namex+0x9f>
8010259e:	66 90                	xchg   %ax,%ax
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
801025a0:	8b 45 dc             	mov    -0x24(%ebp),%eax
801025a3:	85 c0                	test   %eax,%eax
801025a5:	0f 85 be 00 00 00    	jne    80102669 <namex+0x229>
    iput(ip);
    return 0;
  }
  return ip;
}
801025ab:	8d 65 f4             	lea    -0xc(%ebp),%esp
801025ae:	89 f0                	mov    %esi,%eax
801025b0:	5b                   	pop    %ebx
801025b1:	5e                   	pop    %esi
801025b2:	5f                   	pop    %edi
801025b3:	5d                   	pop    %ebp
801025b4:	c3                   	ret    
  while(*path != '/' && *path != 0)
801025b5:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801025b8:	89 df                	mov    %ebx,%edi
801025ba:	31 c0                	xor    %eax,%eax
801025bc:	eb c0                	jmp    8010257e <namex+0x13e>
    ip = iget(ROOTDEV, ROOTINO);
801025be:	ba 01 00 00 00       	mov    $0x1,%edx
801025c3:	b8 01 00 00 00       	mov    $0x1,%eax
801025c8:	e8 33 f4 ff ff       	call   80101a00 <iget>
801025cd:	89 c6                	mov    %eax,%esi
801025cf:	e9 b7 fe ff ff       	jmp    8010248b <namex+0x4b>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
801025d4:	83 ec 0c             	sub    $0xc,%esp
801025d7:	8d 5e 0c             	lea    0xc(%esi),%ebx
801025da:	53                   	push   %ebx
801025db:	e8 50 24 00 00       	call   80104a30 <holdingsleep>
801025e0:	83 c4 10             	add    $0x10,%esp
801025e3:	85 c0                	test   %eax,%eax
801025e5:	0f 84 91 00 00 00    	je     8010267c <namex+0x23c>
801025eb:	8b 46 08             	mov    0x8(%esi),%eax
801025ee:	85 c0                	test   %eax,%eax
801025f0:	0f 8e 86 00 00 00    	jle    8010267c <namex+0x23c>
  releasesleep(&ip->lock);
801025f6:	83 ec 0c             	sub    $0xc,%esp
801025f9:	53                   	push   %ebx
801025fa:	e8 f1 23 00 00       	call   801049f0 <releasesleep>
  iput(ip);
801025ff:	89 34 24             	mov    %esi,(%esp)
      return 0;
80102602:	31 f6                	xor    %esi,%esi
  iput(ip);
80102604:	e8 57 f9 ff ff       	call   80101f60 <iput>
      return 0;
80102609:	83 c4 10             	add    $0x10,%esp
}
8010260c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010260f:	89 f0                	mov    %esi,%eax
80102611:	5b                   	pop    %ebx
80102612:	5e                   	pop    %esi
80102613:	5f                   	pop    %edi
80102614:	5d                   	pop    %ebp
80102615:	c3                   	ret    
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80102616:	83 ec 0c             	sub    $0xc,%esp
80102619:	89 55 e4             	mov    %edx,-0x1c(%ebp)
8010261c:	52                   	push   %edx
8010261d:	e8 0e 24 00 00       	call   80104a30 <holdingsleep>
80102622:	83 c4 10             	add    $0x10,%esp
80102625:	85 c0                	test   %eax,%eax
80102627:	74 53                	je     8010267c <namex+0x23c>
80102629:	8b 4e 08             	mov    0x8(%esi),%ecx
8010262c:	85 c9                	test   %ecx,%ecx
8010262e:	7e 4c                	jle    8010267c <namex+0x23c>
  releasesleep(&ip->lock);
80102630:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80102633:	83 ec 0c             	sub    $0xc,%esp
80102636:	52                   	push   %edx
80102637:	eb c1                	jmp    801025fa <namex+0x1ba>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80102639:	83 ec 0c             	sub    $0xc,%esp
8010263c:	8d 5e 0c             	lea    0xc(%esi),%ebx
8010263f:	53                   	push   %ebx
80102640:	e8 eb 23 00 00       	call   80104a30 <holdingsleep>
80102645:	83 c4 10             	add    $0x10,%esp
80102648:	85 c0                	test   %eax,%eax
8010264a:	74 30                	je     8010267c <namex+0x23c>
8010264c:	8b 7e 08             	mov    0x8(%esi),%edi
8010264f:	85 ff                	test   %edi,%edi
80102651:	7e 29                	jle    8010267c <namex+0x23c>
  releasesleep(&ip->lock);
80102653:	83 ec 0c             	sub    $0xc,%esp
80102656:	53                   	push   %ebx
80102657:	e8 94 23 00 00       	call   801049f0 <releasesleep>
}
8010265c:	83 c4 10             	add    $0x10,%esp
}
8010265f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102662:	89 f0                	mov    %esi,%eax
80102664:	5b                   	pop    %ebx
80102665:	5e                   	pop    %esi
80102666:	5f                   	pop    %edi
80102667:	5d                   	pop    %ebp
80102668:	c3                   	ret    
    iput(ip);
80102669:	83 ec 0c             	sub    $0xc,%esp
8010266c:	56                   	push   %esi
    return 0;
8010266d:	31 f6                	xor    %esi,%esi
    iput(ip);
8010266f:	e8 ec f8 ff ff       	call   80101f60 <iput>
    return 0;
80102674:	83 c4 10             	add    $0x10,%esp
80102677:	e9 2f ff ff ff       	jmp    801025ab <namex+0x16b>
    panic("iunlock");
8010267c:	83 ec 0c             	sub    $0xc,%esp
8010267f:	68 d7 79 10 80       	push   $0x801079d7
80102684:	e8 17 dd ff ff       	call   801003a0 <panic>
80102689:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102690 <dirlink>:
{
80102690:	55                   	push   %ebp
80102691:	89 e5                	mov    %esp,%ebp
80102693:	57                   	push   %edi
80102694:	56                   	push   %esi
80102695:	53                   	push   %ebx
80102696:	83 ec 20             	sub    $0x20,%esp
80102699:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((ip = dirlookup(dp, name, 0)) != 0){
8010269c:	6a 00                	push   $0x0
8010269e:	ff 75 0c             	push   0xc(%ebp)
801026a1:	53                   	push   %ebx
801026a2:	e8 e9 fc ff ff       	call   80102390 <dirlookup>
801026a7:	83 c4 10             	add    $0x10,%esp
801026aa:	85 c0                	test   %eax,%eax
801026ac:	75 67                	jne    80102715 <dirlink+0x85>
  for(off = 0; off < dp->size; off += sizeof(de)){
801026ae:	8b 7b 58             	mov    0x58(%ebx),%edi
801026b1:	8d 75 d8             	lea    -0x28(%ebp),%esi
801026b4:	85 ff                	test   %edi,%edi
801026b6:	74 29                	je     801026e1 <dirlink+0x51>
801026b8:	31 ff                	xor    %edi,%edi
801026ba:	8d 75 d8             	lea    -0x28(%ebp),%esi
801026bd:	eb 09                	jmp    801026c8 <dirlink+0x38>
801026bf:	90                   	nop
801026c0:	83 c7 10             	add    $0x10,%edi
801026c3:	3b 7b 58             	cmp    0x58(%ebx),%edi
801026c6:	73 19                	jae    801026e1 <dirlink+0x51>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801026c8:	6a 10                	push   $0x10
801026ca:	57                   	push   %edi
801026cb:	56                   	push   %esi
801026cc:	53                   	push   %ebx
801026cd:	e8 6e fa ff ff       	call   80102140 <readi>
801026d2:	83 c4 10             	add    $0x10,%esp
801026d5:	83 f8 10             	cmp    $0x10,%eax
801026d8:	75 4e                	jne    80102728 <dirlink+0x98>
    if(de.inum == 0)
801026da:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
801026df:	75 df                	jne    801026c0 <dirlink+0x30>
  strncpy(de.name, name, DIRSIZ);
801026e1:	83 ec 04             	sub    $0x4,%esp
801026e4:	8d 45 da             	lea    -0x26(%ebp),%eax
801026e7:	6a 0e                	push   $0xe
801026e9:	ff 75 0c             	push   0xc(%ebp)
801026ec:	50                   	push   %eax
801026ed:	e8 7e 27 00 00       	call   80104e70 <strncpy>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801026f2:	6a 10                	push   $0x10
  de.inum = inum;
801026f4:	8b 45 10             	mov    0x10(%ebp),%eax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801026f7:	57                   	push   %edi
801026f8:	56                   	push   %esi
801026f9:	53                   	push   %ebx
  de.inum = inum;
801026fa:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801026fe:	e8 3d fb ff ff       	call   80102240 <writei>
80102703:	83 c4 20             	add    $0x20,%esp
80102706:	83 f8 10             	cmp    $0x10,%eax
80102709:	75 2a                	jne    80102735 <dirlink+0xa5>
  return 0;
8010270b:	31 c0                	xor    %eax,%eax
}
8010270d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102710:	5b                   	pop    %ebx
80102711:	5e                   	pop    %esi
80102712:	5f                   	pop    %edi
80102713:	5d                   	pop    %ebp
80102714:	c3                   	ret    
    iput(ip);
80102715:	83 ec 0c             	sub    $0xc,%esp
80102718:	50                   	push   %eax
80102719:	e8 42 f8 ff ff       	call   80101f60 <iput>
    return -1;
8010271e:	83 c4 10             	add    $0x10,%esp
80102721:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102726:	eb e5                	jmp    8010270d <dirlink+0x7d>
      panic("dirlink read");
80102728:	83 ec 0c             	sub    $0xc,%esp
8010272b:	68 00 7a 10 80       	push   $0x80107a00
80102730:	e8 6b dc ff ff       	call   801003a0 <panic>
    panic("dirlink");
80102735:	83 ec 0c             	sub    $0xc,%esp
80102738:	68 de 7f 10 80       	push   $0x80107fde
8010273d:	e8 5e dc ff ff       	call   801003a0 <panic>
80102742:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102749:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102750 <namei>:

struct inode*
namei(char *path)
{
80102750:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
80102751:	31 d2                	xor    %edx,%edx
{
80102753:	89 e5                	mov    %esp,%ebp
80102755:	83 ec 18             	sub    $0x18,%esp
  return namex(path, 0, name);
80102758:	8b 45 08             	mov    0x8(%ebp),%eax
8010275b:	8d 4d ea             	lea    -0x16(%ebp),%ecx
8010275e:	e8 dd fc ff ff       	call   80102440 <namex>
}
80102763:	c9                   	leave  
80102764:	c3                   	ret    
80102765:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010276c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102770 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80102770:	55                   	push   %ebp
  return namex(path, 1, name);
80102771:	ba 01 00 00 00       	mov    $0x1,%edx
{
80102776:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
80102778:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010277b:	8b 45 08             	mov    0x8(%ebp),%eax
}
8010277e:	5d                   	pop    %ebp
  return namex(path, 1, name);
8010277f:	e9 bc fc ff ff       	jmp    80102440 <namex>
80102784:	66 90                	xchg   %ax,%ax
80102786:	66 90                	xchg   %ax,%ax
80102788:	66 90                	xchg   %ax,%ax
8010278a:	66 90                	xchg   %ax,%ax
8010278c:	66 90                	xchg   %ax,%ax
8010278e:	66 90                	xchg   %ax,%ax

80102790 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80102790:	55                   	push   %ebp
80102791:	89 e5                	mov    %esp,%ebp
80102793:	57                   	push   %edi
80102794:	56                   	push   %esi
80102795:	53                   	push   %ebx
80102796:	83 ec 0c             	sub    $0xc,%esp
  if(b == 0)
80102799:	85 c0                	test   %eax,%eax
8010279b:	0f 84 b4 00 00 00    	je     80102855 <idestart+0xc5>
    panic("idestart");
  if(b->blockno >= FSSIZE)
801027a1:	8b 70 08             	mov    0x8(%eax),%esi
801027a4:	89 c3                	mov    %eax,%ebx
801027a6:	81 fe e7 03 00 00    	cmp    $0x3e7,%esi
801027ac:	0f 87 96 00 00 00    	ja     80102848 <idestart+0xb8>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801027b2:	b9 f7 01 00 00       	mov    $0x1f7,%ecx
801027b7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801027be:	66 90                	xchg   %ax,%ax
801027c0:	89 ca                	mov    %ecx,%edx
801027c2:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
801027c3:	83 e0 c0             	and    $0xffffffc0,%eax
801027c6:	3c 40                	cmp    $0x40,%al
801027c8:	75 f6                	jne    801027c0 <idestart+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801027ca:	31 ff                	xor    %edi,%edi
801027cc:	ba f6 03 00 00       	mov    $0x3f6,%edx
801027d1:	89 f8                	mov    %edi,%eax
801027d3:	ee                   	out    %al,(%dx)
801027d4:	b8 01 00 00 00       	mov    $0x1,%eax
801027d9:	ba f2 01 00 00       	mov    $0x1f2,%edx
801027de:	ee                   	out    %al,(%dx)
801027df:	ba f3 01 00 00       	mov    $0x1f3,%edx
801027e4:	89 f0                	mov    %esi,%eax
801027e6:	ee                   	out    %al,(%dx)

  idewait(0);
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
801027e7:	89 f0                	mov    %esi,%eax
801027e9:	ba f4 01 00 00       	mov    $0x1f4,%edx
801027ee:	c1 f8 08             	sar    $0x8,%eax
801027f1:	ee                   	out    %al,(%dx)
801027f2:	ba f5 01 00 00       	mov    $0x1f5,%edx
801027f7:	89 f8                	mov    %edi,%eax
801027f9:	ee                   	out    %al,(%dx)
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
801027fa:	0f b6 43 04          	movzbl 0x4(%ebx),%eax
801027fe:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102803:	c1 e0 04             	shl    $0x4,%eax
80102806:	83 e0 10             	and    $0x10,%eax
80102809:	83 c8 e0             	or     $0xffffffe0,%eax
8010280c:	ee                   	out    %al,(%dx)
  if(b->flags & B_DIRTY){
8010280d:	f6 03 04             	testb  $0x4,(%ebx)
80102810:	75 16                	jne    80102828 <idestart+0x98>
80102812:	b8 20 00 00 00       	mov    $0x20,%eax
80102817:	89 ca                	mov    %ecx,%edx
80102819:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
8010281a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010281d:	5b                   	pop    %ebx
8010281e:	5e                   	pop    %esi
8010281f:	5f                   	pop    %edi
80102820:	5d                   	pop    %ebp
80102821:	c3                   	ret    
80102822:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102828:	b8 30 00 00 00       	mov    $0x30,%eax
8010282d:	89 ca                	mov    %ecx,%edx
8010282f:	ee                   	out    %al,(%dx)
  asm volatile("cld; rep outsl" :
80102830:	b9 80 00 00 00       	mov    $0x80,%ecx
    outsl(0x1f0, b->data, BSIZE/4);
80102835:	8d 73 5c             	lea    0x5c(%ebx),%esi
80102838:	ba f0 01 00 00       	mov    $0x1f0,%edx
8010283d:	fc                   	cld    
8010283e:	f3 6f                	rep outsl %ds:(%esi),(%dx)
}
80102840:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102843:	5b                   	pop    %ebx
80102844:	5e                   	pop    %esi
80102845:	5f                   	pop    %edi
80102846:	5d                   	pop    %ebp
80102847:	c3                   	ret    
    panic("incorrect blockno");
80102848:	83 ec 0c             	sub    $0xc,%esp
8010284b:	68 6c 7a 10 80       	push   $0x80107a6c
80102850:	e8 4b db ff ff       	call   801003a0 <panic>
    panic("idestart");
80102855:	83 ec 0c             	sub    $0xc,%esp
80102858:	68 63 7a 10 80       	push   $0x80107a63
8010285d:	e8 3e db ff ff       	call   801003a0 <panic>
80102862:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102869:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102870 <ideinit>:
{
80102870:	55                   	push   %ebp
80102871:	89 e5                	mov    %esp,%ebp
80102873:	83 ec 10             	sub    $0x10,%esp
  initlock(&idelock, "ide");
80102876:	68 7e 7a 10 80       	push   $0x80107a7e
8010287b:	68 40 32 11 80       	push   $0x80113240
80102880:	e8 fb 21 00 00       	call   80104a80 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
80102885:	58                   	pop    %eax
80102886:	a1 c4 33 11 80       	mov    0x801133c4,%eax
8010288b:	5a                   	pop    %edx
8010288c:	83 e8 01             	sub    $0x1,%eax
8010288f:	50                   	push   %eax
80102890:	6a 0e                	push   $0xe
80102892:	e8 99 02 00 00       	call   80102b30 <ioapicenable>
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102897:	83 c4 10             	add    $0x10,%esp
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010289a:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010289f:	90                   	nop
801028a0:	ec                   	in     (%dx),%al
801028a1:	83 e0 c0             	and    $0xffffffc0,%eax
801028a4:	3c 40                	cmp    $0x40,%al
801028a6:	75 f8                	jne    801028a0 <ideinit+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028a8:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
801028ad:	ba f6 01 00 00       	mov    $0x1f6,%edx
801028b2:	ee                   	out    %al,(%dx)
801028b3:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028b8:	ba f7 01 00 00       	mov    $0x1f7,%edx
801028bd:	eb 06                	jmp    801028c5 <ideinit+0x55>
801028bf:	90                   	nop
  for(i=0; i<1000; i++){
801028c0:	83 e9 01             	sub    $0x1,%ecx
801028c3:	74 0f                	je     801028d4 <ideinit+0x64>
801028c5:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
801028c6:	84 c0                	test   %al,%al
801028c8:	74 f6                	je     801028c0 <ideinit+0x50>
      havedisk1 = 1;
801028ca:	c7 05 20 32 11 80 01 	movl   $0x1,0x80113220
801028d1:	00 00 00 
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028d4:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
801028d9:	ba f6 01 00 00       	mov    $0x1f6,%edx
801028de:	ee                   	out    %al,(%dx)
}
801028df:	c9                   	leave  
801028e0:	c3                   	ret    
801028e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801028e8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801028ef:	90                   	nop

801028f0 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
801028f0:	55                   	push   %ebp
801028f1:	89 e5                	mov    %esp,%ebp
801028f3:	57                   	push   %edi
801028f4:	56                   	push   %esi
801028f5:	53                   	push   %ebx
801028f6:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
801028f9:	68 40 32 11 80       	push   $0x80113240
801028fe:	e8 4d 23 00 00       	call   80104c50 <acquire>

  if((b = idequeue) == 0){
80102903:	8b 1d 24 32 11 80    	mov    0x80113224,%ebx
80102909:	83 c4 10             	add    $0x10,%esp
8010290c:	85 db                	test   %ebx,%ebx
8010290e:	74 63                	je     80102973 <ideintr+0x83>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
80102910:	8b 43 58             	mov    0x58(%ebx),%eax
80102913:	a3 24 32 11 80       	mov    %eax,0x80113224

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
80102918:	8b 33                	mov    (%ebx),%esi
8010291a:	f7 c6 04 00 00 00    	test   $0x4,%esi
80102920:	75 2f                	jne    80102951 <ideintr+0x61>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102922:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102927:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010292e:	66 90                	xchg   %ax,%ax
80102930:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102931:	89 c1                	mov    %eax,%ecx
80102933:	83 e1 c0             	and    $0xffffffc0,%ecx
80102936:	80 f9 40             	cmp    $0x40,%cl
80102939:	75 f5                	jne    80102930 <ideintr+0x40>
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
8010293b:	a8 21                	test   $0x21,%al
8010293d:	75 12                	jne    80102951 <ideintr+0x61>
    insl(0x1f0, b->data, BSIZE/4);
8010293f:	8d 7b 5c             	lea    0x5c(%ebx),%edi
  asm volatile("cld; rep insl" :
80102942:	b9 80 00 00 00       	mov    $0x80,%ecx
80102947:	ba f0 01 00 00       	mov    $0x1f0,%edx
8010294c:	fc                   	cld    
8010294d:	f3 6d                	rep insl (%dx),%es:(%edi)

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
8010294f:	8b 33                	mov    (%ebx),%esi
  b->flags &= ~B_DIRTY;
80102951:	83 e6 fb             	and    $0xfffffffb,%esi
  wakeup(b);
80102954:	83 ec 0c             	sub    $0xc,%esp
  b->flags &= ~B_DIRTY;
80102957:	83 ce 02             	or     $0x2,%esi
8010295a:	89 33                	mov    %esi,(%ebx)
  wakeup(b);
8010295c:	53                   	push   %ebx
8010295d:	e8 4e 1e 00 00       	call   801047b0 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
80102962:	a1 24 32 11 80       	mov    0x80113224,%eax
80102967:	83 c4 10             	add    $0x10,%esp
8010296a:	85 c0                	test   %eax,%eax
8010296c:	74 05                	je     80102973 <ideintr+0x83>
    idestart(idequeue);
8010296e:	e8 1d fe ff ff       	call   80102790 <idestart>
    release(&idelock);
80102973:	83 ec 0c             	sub    $0xc,%esp
80102976:	68 40 32 11 80       	push   $0x80113240
8010297b:	e8 70 22 00 00       	call   80104bf0 <release>

  release(&idelock);
}
80102980:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102983:	5b                   	pop    %ebx
80102984:	5e                   	pop    %esi
80102985:	5f                   	pop    %edi
80102986:	5d                   	pop    %ebp
80102987:	c3                   	ret    
80102988:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010298f:	90                   	nop

80102990 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
80102990:	55                   	push   %ebp
80102991:	89 e5                	mov    %esp,%ebp
80102993:	53                   	push   %ebx
80102994:	83 ec 10             	sub    $0x10,%esp
80102997:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
8010299a:	8d 43 0c             	lea    0xc(%ebx),%eax
8010299d:	50                   	push   %eax
8010299e:	e8 8d 20 00 00       	call   80104a30 <holdingsleep>
801029a3:	83 c4 10             	add    $0x10,%esp
801029a6:	85 c0                	test   %eax,%eax
801029a8:	0f 84 c3 00 00 00    	je     80102a71 <iderw+0xe1>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
801029ae:	8b 03                	mov    (%ebx),%eax
801029b0:	83 e0 06             	and    $0x6,%eax
801029b3:	83 f8 02             	cmp    $0x2,%eax
801029b6:	0f 84 a8 00 00 00    	je     80102a64 <iderw+0xd4>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
801029bc:	8b 53 04             	mov    0x4(%ebx),%edx
801029bf:	85 d2                	test   %edx,%edx
801029c1:	74 0d                	je     801029d0 <iderw+0x40>
801029c3:	a1 20 32 11 80       	mov    0x80113220,%eax
801029c8:	85 c0                	test   %eax,%eax
801029ca:	0f 84 87 00 00 00    	je     80102a57 <iderw+0xc7>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
801029d0:	83 ec 0c             	sub    $0xc,%esp
801029d3:	68 40 32 11 80       	push   $0x80113240
801029d8:	e8 73 22 00 00       	call   80104c50 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801029dd:	a1 24 32 11 80       	mov    0x80113224,%eax
  b->qnext = 0;
801029e2:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801029e9:	83 c4 10             	add    $0x10,%esp
801029ec:	85 c0                	test   %eax,%eax
801029ee:	74 60                	je     80102a50 <iderw+0xc0>
801029f0:	89 c2                	mov    %eax,%edx
801029f2:	8b 40 58             	mov    0x58(%eax),%eax
801029f5:	85 c0                	test   %eax,%eax
801029f7:	75 f7                	jne    801029f0 <iderw+0x60>
801029f9:	83 c2 58             	add    $0x58,%edx
    ;
  *pp = b;
801029fc:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
801029fe:	39 1d 24 32 11 80    	cmp    %ebx,0x80113224
80102a04:	74 3a                	je     80102a40 <iderw+0xb0>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
80102a06:	8b 03                	mov    (%ebx),%eax
80102a08:	83 e0 06             	and    $0x6,%eax
80102a0b:	83 f8 02             	cmp    $0x2,%eax
80102a0e:	74 1b                	je     80102a2b <iderw+0x9b>
    sleep(b, &idelock);
80102a10:	83 ec 08             	sub    $0x8,%esp
80102a13:	68 40 32 11 80       	push   $0x80113240
80102a18:	53                   	push   %ebx
80102a19:	e8 d2 1c 00 00       	call   801046f0 <sleep>
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
80102a1e:	8b 03                	mov    (%ebx),%eax
80102a20:	83 c4 10             	add    $0x10,%esp
80102a23:	83 e0 06             	and    $0x6,%eax
80102a26:	83 f8 02             	cmp    $0x2,%eax
80102a29:	75 e5                	jne    80102a10 <iderw+0x80>
  }


  release(&idelock);
80102a2b:	c7 45 08 40 32 11 80 	movl   $0x80113240,0x8(%ebp)
}
80102a32:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102a35:	c9                   	leave  
  release(&idelock);
80102a36:	e9 b5 21 00 00       	jmp    80104bf0 <release>
80102a3b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102a3f:	90                   	nop
    idestart(b);
80102a40:	89 d8                	mov    %ebx,%eax
80102a42:	e8 49 fd ff ff       	call   80102790 <idestart>
80102a47:	eb bd                	jmp    80102a06 <iderw+0x76>
80102a49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102a50:	ba 24 32 11 80       	mov    $0x80113224,%edx
80102a55:	eb a5                	jmp    801029fc <iderw+0x6c>
    panic("iderw: ide disk 1 not present");
80102a57:	83 ec 0c             	sub    $0xc,%esp
80102a5a:	68 ad 7a 10 80       	push   $0x80107aad
80102a5f:	e8 3c d9 ff ff       	call   801003a0 <panic>
    panic("iderw: nothing to do");
80102a64:	83 ec 0c             	sub    $0xc,%esp
80102a67:	68 98 7a 10 80       	push   $0x80107a98
80102a6c:	e8 2f d9 ff ff       	call   801003a0 <panic>
    panic("iderw: buf not locked");
80102a71:	83 ec 0c             	sub    $0xc,%esp
80102a74:	68 82 7a 10 80       	push   $0x80107a82
80102a79:	e8 22 d9 ff ff       	call   801003a0 <panic>
80102a7e:	66 90                	xchg   %ax,%ax

80102a80 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
80102a80:	55                   	push   %ebp
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
80102a81:	c7 05 74 32 11 80 00 	movl   $0xfec00000,0x80113274
80102a88:	00 c0 fe 
{
80102a8b:	89 e5                	mov    %esp,%ebp
80102a8d:	56                   	push   %esi
80102a8e:	53                   	push   %ebx
  ioapic->reg = reg;
80102a8f:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
80102a96:	00 00 00 
  return ioapic->data;
80102a99:	8b 15 74 32 11 80    	mov    0x80113274,%edx
80102a9f:	8b 72 10             	mov    0x10(%edx),%esi
  ioapic->reg = reg;
80102aa2:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
  return ioapic->data;
80102aa8:	8b 0d 74 32 11 80    	mov    0x80113274,%ecx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
80102aae:	0f b6 15 c0 33 11 80 	movzbl 0x801133c0,%edx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
80102ab5:	c1 ee 10             	shr    $0x10,%esi
80102ab8:	89 f0                	mov    %esi,%eax
80102aba:	0f b6 f0             	movzbl %al,%esi
  return ioapic->data;
80102abd:	8b 41 10             	mov    0x10(%ecx),%eax
  id = ioapicread(REG_ID) >> 24;
80102ac0:	c1 e8 18             	shr    $0x18,%eax
  if(id != ioapicid)
80102ac3:	39 c2                	cmp    %eax,%edx
80102ac5:	74 16                	je     80102add <ioapicinit+0x5d>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
80102ac7:	83 ec 0c             	sub    $0xc,%esp
80102aca:	68 cc 7a 10 80       	push   $0x80107acc
80102acf:	e8 7c dc ff ff       	call   80100750 <cprintf>
  ioapic->reg = reg;
80102ad4:	8b 0d 74 32 11 80    	mov    0x80113274,%ecx
80102ada:	83 c4 10             	add    $0x10,%esp
80102add:	83 c6 21             	add    $0x21,%esi
{
80102ae0:	ba 10 00 00 00       	mov    $0x10,%edx
80102ae5:	b8 20 00 00 00       	mov    $0x20,%eax
80102aea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  ioapic->reg = reg;
80102af0:	89 11                	mov    %edx,(%ecx)

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
80102af2:	89 c3                	mov    %eax,%ebx
  ioapic->data = data;
80102af4:	8b 0d 74 32 11 80    	mov    0x80113274,%ecx
  for(i = 0; i <= maxintr; i++){
80102afa:	83 c0 01             	add    $0x1,%eax
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
80102afd:	81 cb 00 00 01 00    	or     $0x10000,%ebx
  ioapic->data = data;
80102b03:	89 59 10             	mov    %ebx,0x10(%ecx)
  ioapic->reg = reg;
80102b06:	8d 5a 01             	lea    0x1(%edx),%ebx
  for(i = 0; i <= maxintr; i++){
80102b09:	83 c2 02             	add    $0x2,%edx
  ioapic->reg = reg;
80102b0c:	89 19                	mov    %ebx,(%ecx)
  ioapic->data = data;
80102b0e:	8b 0d 74 32 11 80    	mov    0x80113274,%ecx
80102b14:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
  for(i = 0; i <= maxintr; i++){
80102b1b:	39 f0                	cmp    %esi,%eax
80102b1d:	75 d1                	jne    80102af0 <ioapicinit+0x70>
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
80102b1f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102b22:	5b                   	pop    %ebx
80102b23:	5e                   	pop    %esi
80102b24:	5d                   	pop    %ebp
80102b25:	c3                   	ret    
80102b26:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102b2d:	8d 76 00             	lea    0x0(%esi),%esi

80102b30 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
80102b30:	55                   	push   %ebp
  ioapic->reg = reg;
80102b31:	8b 0d 74 32 11 80    	mov    0x80113274,%ecx
{
80102b37:	89 e5                	mov    %esp,%ebp
80102b39:	8b 45 08             	mov    0x8(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
80102b3c:	8d 50 20             	lea    0x20(%eax),%edx
80102b3f:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
  ioapic->reg = reg;
80102b43:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80102b45:	8b 0d 74 32 11 80    	mov    0x80113274,%ecx
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
80102b4b:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
80102b4e:	89 51 10             	mov    %edx,0x10(%ecx)
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
80102b51:	8b 55 0c             	mov    0xc(%ebp),%edx
  ioapic->reg = reg;
80102b54:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80102b56:	a1 74 32 11 80       	mov    0x80113274,%eax
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
80102b5b:	c1 e2 18             	shl    $0x18,%edx
  ioapic->data = data;
80102b5e:	89 50 10             	mov    %edx,0x10(%eax)
}
80102b61:	5d                   	pop    %ebp
80102b62:	c3                   	ret    
80102b63:	66 90                	xchg   %ax,%ax
80102b65:	66 90                	xchg   %ax,%ax
80102b67:	66 90                	xchg   %ax,%ax
80102b69:	66 90                	xchg   %ax,%ax
80102b6b:	66 90                	xchg   %ax,%ax
80102b6d:	66 90                	xchg   %ax,%ax
80102b6f:	90                   	nop

80102b70 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
80102b70:	55                   	push   %ebp
80102b71:	89 e5                	mov    %esp,%ebp
80102b73:	53                   	push   %ebx
80102b74:	83 ec 04             	sub    $0x4,%esp
80102b77:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
80102b7a:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
80102b80:	75 76                	jne    80102bf8 <kfree+0x88>
80102b82:	81 fb 10 71 11 80    	cmp    $0x80117110,%ebx
80102b88:	72 6e                	jb     80102bf8 <kfree+0x88>
80102b8a:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80102b90:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80102b95:	77 61                	ja     80102bf8 <kfree+0x88>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
80102b97:	83 ec 04             	sub    $0x4,%esp
80102b9a:	68 00 10 00 00       	push   $0x1000
80102b9f:	6a 01                	push   $0x1
80102ba1:	53                   	push   %ebx
80102ba2:	e8 69 21 00 00       	call   80104d10 <memset>

  if(kmem.use_lock)
80102ba7:	8b 15 b4 32 11 80    	mov    0x801132b4,%edx
80102bad:	83 c4 10             	add    $0x10,%esp
80102bb0:	85 d2                	test   %edx,%edx
80102bb2:	75 1c                	jne    80102bd0 <kfree+0x60>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
80102bb4:	a1 b8 32 11 80       	mov    0x801132b8,%eax
80102bb9:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
80102bbb:	a1 b4 32 11 80       	mov    0x801132b4,%eax
  kmem.freelist = r;
80102bc0:	89 1d b8 32 11 80    	mov    %ebx,0x801132b8
  if(kmem.use_lock)
80102bc6:	85 c0                	test   %eax,%eax
80102bc8:	75 1e                	jne    80102be8 <kfree+0x78>
    release(&kmem.lock);
}
80102bca:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102bcd:	c9                   	leave  
80102bce:	c3                   	ret    
80102bcf:	90                   	nop
    acquire(&kmem.lock);
80102bd0:	83 ec 0c             	sub    $0xc,%esp
80102bd3:	68 80 32 11 80       	push   $0x80113280
80102bd8:	e8 73 20 00 00       	call   80104c50 <acquire>
80102bdd:	83 c4 10             	add    $0x10,%esp
80102be0:	eb d2                	jmp    80102bb4 <kfree+0x44>
80102be2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    release(&kmem.lock);
80102be8:	c7 45 08 80 32 11 80 	movl   $0x80113280,0x8(%ebp)
}
80102bef:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102bf2:	c9                   	leave  
    release(&kmem.lock);
80102bf3:	e9 f8 1f 00 00       	jmp    80104bf0 <release>
    panic("kfree");
80102bf8:	83 ec 0c             	sub    $0xc,%esp
80102bfb:	68 fe 7a 10 80       	push   $0x80107afe
80102c00:	e8 9b d7 ff ff       	call   801003a0 <panic>
80102c05:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102c0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102c10 <freerange>:
{
80102c10:	55                   	push   %ebp
80102c11:	89 e5                	mov    %esp,%ebp
80102c13:	56                   	push   %esi
  p = (char*)PGROUNDUP((uint)vstart);
80102c14:	8b 45 08             	mov    0x8(%ebp),%eax
{
80102c17:	8b 75 0c             	mov    0xc(%ebp),%esi
80102c1a:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
80102c1b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102c21:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102c27:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80102c2d:	39 de                	cmp    %ebx,%esi
80102c2f:	72 23                	jb     80102c54 <freerange+0x44>
80102c31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80102c38:	83 ec 0c             	sub    $0xc,%esp
80102c3b:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102c41:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102c47:	50                   	push   %eax
80102c48:	e8 23 ff ff ff       	call   80102b70 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102c4d:	83 c4 10             	add    $0x10,%esp
80102c50:	39 f3                	cmp    %esi,%ebx
80102c52:	76 e4                	jbe    80102c38 <freerange+0x28>
}
80102c54:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102c57:	5b                   	pop    %ebx
80102c58:	5e                   	pop    %esi
80102c59:	5d                   	pop    %ebp
80102c5a:	c3                   	ret    
80102c5b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102c5f:	90                   	nop

80102c60 <kinit2>:
{
80102c60:	55                   	push   %ebp
80102c61:	89 e5                	mov    %esp,%ebp
80102c63:	56                   	push   %esi
  p = (char*)PGROUNDUP((uint)vstart);
80102c64:	8b 45 08             	mov    0x8(%ebp),%eax
{
80102c67:	8b 75 0c             	mov    0xc(%ebp),%esi
80102c6a:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
80102c6b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102c71:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102c77:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80102c7d:	39 de                	cmp    %ebx,%esi
80102c7f:	72 23                	jb     80102ca4 <kinit2+0x44>
80102c81:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80102c88:	83 ec 0c             	sub    $0xc,%esp
80102c8b:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102c91:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102c97:	50                   	push   %eax
80102c98:	e8 d3 fe ff ff       	call   80102b70 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102c9d:	83 c4 10             	add    $0x10,%esp
80102ca0:	39 de                	cmp    %ebx,%esi
80102ca2:	73 e4                	jae    80102c88 <kinit2+0x28>
  kmem.use_lock = 1;
80102ca4:	c7 05 b4 32 11 80 01 	movl   $0x1,0x801132b4
80102cab:	00 00 00 
}
80102cae:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102cb1:	5b                   	pop    %ebx
80102cb2:	5e                   	pop    %esi
80102cb3:	5d                   	pop    %ebp
80102cb4:	c3                   	ret    
80102cb5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102cbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102cc0 <kinit1>:
{
80102cc0:	55                   	push   %ebp
80102cc1:	89 e5                	mov    %esp,%ebp
80102cc3:	56                   	push   %esi
80102cc4:	53                   	push   %ebx
80102cc5:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
80102cc8:	83 ec 08             	sub    $0x8,%esp
80102ccb:	68 04 7b 10 80       	push   $0x80107b04
80102cd0:	68 80 32 11 80       	push   $0x80113280
80102cd5:	e8 a6 1d 00 00       	call   80104a80 <initlock>
  p = (char*)PGROUNDUP((uint)vstart);
80102cda:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102cdd:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 0;
80102ce0:	c7 05 b4 32 11 80 00 	movl   $0x0,0x801132b4
80102ce7:	00 00 00 
  p = (char*)PGROUNDUP((uint)vstart);
80102cea:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102cf0:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102cf6:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80102cfc:	39 de                	cmp    %ebx,%esi
80102cfe:	72 1c                	jb     80102d1c <kinit1+0x5c>
    kfree(p);
80102d00:	83 ec 0c             	sub    $0xc,%esp
80102d03:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102d09:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102d0f:	50                   	push   %eax
80102d10:	e8 5b fe ff ff       	call   80102b70 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102d15:	83 c4 10             	add    $0x10,%esp
80102d18:	39 de                	cmp    %ebx,%esi
80102d1a:	73 e4                	jae    80102d00 <kinit1+0x40>
}
80102d1c:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102d1f:	5b                   	pop    %ebx
80102d20:	5e                   	pop    %esi
80102d21:	5d                   	pop    %ebp
80102d22:	c3                   	ret    
80102d23:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102d2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102d30 <kalloc>:
char*
kalloc(void)
{
  struct run *r;

  if(kmem.use_lock)
80102d30:	a1 b4 32 11 80       	mov    0x801132b4,%eax
80102d35:	85 c0                	test   %eax,%eax
80102d37:	75 1f                	jne    80102d58 <kalloc+0x28>
    acquire(&kmem.lock);
  r = kmem.freelist;
80102d39:	a1 b8 32 11 80       	mov    0x801132b8,%eax
  if(r)
80102d3e:	85 c0                	test   %eax,%eax
80102d40:	74 0e                	je     80102d50 <kalloc+0x20>
    kmem.freelist = r->next;
80102d42:	8b 10                	mov    (%eax),%edx
80102d44:	89 15 b8 32 11 80    	mov    %edx,0x801132b8
  if(kmem.use_lock)
80102d4a:	c3                   	ret    
80102d4b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102d4f:	90                   	nop
    release(&kmem.lock);
  return (char*)r;
}
80102d50:	c3                   	ret    
80102d51:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
80102d58:	55                   	push   %ebp
80102d59:	89 e5                	mov    %esp,%ebp
80102d5b:	83 ec 24             	sub    $0x24,%esp
    acquire(&kmem.lock);
80102d5e:	68 80 32 11 80       	push   $0x80113280
80102d63:	e8 e8 1e 00 00       	call   80104c50 <acquire>
  r = kmem.freelist;
80102d68:	a1 b8 32 11 80       	mov    0x801132b8,%eax
  if(kmem.use_lock)
80102d6d:	8b 15 b4 32 11 80    	mov    0x801132b4,%edx
  if(r)
80102d73:	83 c4 10             	add    $0x10,%esp
80102d76:	85 c0                	test   %eax,%eax
80102d78:	74 08                	je     80102d82 <kalloc+0x52>
    kmem.freelist = r->next;
80102d7a:	8b 08                	mov    (%eax),%ecx
80102d7c:	89 0d b8 32 11 80    	mov    %ecx,0x801132b8
  if(kmem.use_lock)
80102d82:	85 d2                	test   %edx,%edx
80102d84:	74 16                	je     80102d9c <kalloc+0x6c>
    release(&kmem.lock);
80102d86:	83 ec 0c             	sub    $0xc,%esp
80102d89:	89 45 f4             	mov    %eax,-0xc(%ebp)
80102d8c:	68 80 32 11 80       	push   $0x80113280
80102d91:	e8 5a 1e 00 00       	call   80104bf0 <release>
  return (char*)r;
80102d96:	8b 45 f4             	mov    -0xc(%ebp),%eax
    release(&kmem.lock);
80102d99:	83 c4 10             	add    $0x10,%esp
}
80102d9c:	c9                   	leave  
80102d9d:	c3                   	ret    
80102d9e:	66 90                	xchg   %ax,%ax

80102da0 <kbdgetc>:
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102da0:	ba 64 00 00 00       	mov    $0x64,%edx
80102da5:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
80102da6:	a8 01                	test   $0x1,%al
80102da8:	0f 84 c2 00 00 00    	je     80102e70 <kbdgetc+0xd0>
{
80102dae:	55                   	push   %ebp
80102daf:	ba 60 00 00 00       	mov    $0x60,%edx
80102db4:	89 e5                	mov    %esp,%ebp
80102db6:	53                   	push   %ebx
80102db7:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
80102db8:	8b 1d bc 32 11 80    	mov    0x801132bc,%ebx
  data = inb(KBDATAP);
80102dbe:	0f b6 c8             	movzbl %al,%ecx
  if(data == 0xE0){
80102dc1:	3c e0                	cmp    $0xe0,%al
80102dc3:	74 5b                	je     80102e20 <kbdgetc+0x80>
    return 0;
  } else if(data & 0x80){
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
80102dc5:	89 da                	mov    %ebx,%edx
80102dc7:	83 e2 40             	and    $0x40,%edx
  } else if(data & 0x80){
80102dca:	84 c0                	test   %al,%al
80102dcc:	78 62                	js     80102e30 <kbdgetc+0x90>
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
80102dce:	85 d2                	test   %edx,%edx
80102dd0:	74 09                	je     80102ddb <kbdgetc+0x3b>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
80102dd2:	83 c8 80             	or     $0xffffff80,%eax
    shift &= ~E0ESC;
80102dd5:	83 e3 bf             	and    $0xffffffbf,%ebx
    data |= 0x80;
80102dd8:	0f b6 c8             	movzbl %al,%ecx
  }

  shift |= shiftcode[data];
80102ddb:	0f b6 91 40 7c 10 80 	movzbl -0x7fef83c0(%ecx),%edx
  shift ^= togglecode[data];
80102de2:	0f b6 81 40 7b 10 80 	movzbl -0x7fef84c0(%ecx),%eax
  shift |= shiftcode[data];
80102de9:	09 da                	or     %ebx,%edx
  shift ^= togglecode[data];
80102deb:	31 c2                	xor    %eax,%edx
  c = charcode[shift & (CTL | SHIFT)][data];
80102ded:	89 d0                	mov    %edx,%eax
  shift ^= togglecode[data];
80102def:	89 15 bc 32 11 80    	mov    %edx,0x801132bc
  c = charcode[shift & (CTL | SHIFT)][data];
80102df5:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
80102df8:	83 e2 08             	and    $0x8,%edx
  c = charcode[shift & (CTL | SHIFT)][data];
80102dfb:	8b 04 85 20 7b 10 80 	mov    -0x7fef84e0(,%eax,4),%eax
80102e02:	0f b6 04 08          	movzbl (%eax,%ecx,1),%eax
  if(shift & CAPSLOCK){
80102e06:	74 0b                	je     80102e13 <kbdgetc+0x73>
    if('a' <= c && c <= 'z')
80102e08:	8d 50 9f             	lea    -0x61(%eax),%edx
80102e0b:	83 fa 19             	cmp    $0x19,%edx
80102e0e:	77 48                	ja     80102e58 <kbdgetc+0xb8>
      c += 'A' - 'a';
80102e10:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
80102e13:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102e16:	c9                   	leave  
80102e17:	c3                   	ret    
80102e18:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102e1f:	90                   	nop
    shift |= E0ESC;
80102e20:	83 cb 40             	or     $0x40,%ebx
    return 0;
80102e23:	31 c0                	xor    %eax,%eax
    shift |= E0ESC;
80102e25:	89 1d bc 32 11 80    	mov    %ebx,0x801132bc
}
80102e2b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102e2e:	c9                   	leave  
80102e2f:	c3                   	ret    
    data = (shift & E0ESC ? data : data & 0x7F);
80102e30:	83 e0 7f             	and    $0x7f,%eax
80102e33:	85 d2                	test   %edx,%edx
80102e35:	0f 44 c8             	cmove  %eax,%ecx
    shift &= ~(shiftcode[data] | E0ESC);
80102e38:	0f b6 81 40 7c 10 80 	movzbl -0x7fef83c0(%ecx),%eax
80102e3f:	83 c8 40             	or     $0x40,%eax
80102e42:	0f b6 c0             	movzbl %al,%eax
80102e45:	f7 d0                	not    %eax
80102e47:	21 d8                	and    %ebx,%eax
}
80102e49:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    shift &= ~(shiftcode[data] | E0ESC);
80102e4c:	a3 bc 32 11 80       	mov    %eax,0x801132bc
    return 0;
80102e51:	31 c0                	xor    %eax,%eax
}
80102e53:	c9                   	leave  
80102e54:	c3                   	ret    
80102e55:	8d 76 00             	lea    0x0(%esi),%esi
    else if('A' <= c && c <= 'Z')
80102e58:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
80102e5b:	8d 50 20             	lea    0x20(%eax),%edx
}
80102e5e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102e61:	c9                   	leave  
      c += 'a' - 'A';
80102e62:	83 f9 1a             	cmp    $0x1a,%ecx
80102e65:	0f 42 c2             	cmovb  %edx,%eax
}
80102e68:	c3                   	ret    
80102e69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80102e70:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80102e75:	c3                   	ret    
80102e76:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102e7d:	8d 76 00             	lea    0x0(%esi),%esi

80102e80 <kbdintr>:

void
kbdintr(void)
{
80102e80:	55                   	push   %ebp
80102e81:	89 e5                	mov    %esp,%ebp
80102e83:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
80102e86:	68 a0 2d 10 80       	push   $0x80102da0
80102e8b:	e8 e0 de ff ff       	call   80100d70 <consoleintr>
}
80102e90:	83 c4 10             	add    $0x10,%esp
80102e93:	c9                   	leave  
80102e94:	c3                   	ret    
80102e95:	66 90                	xchg   %ax,%ax
80102e97:	66 90                	xchg   %ax,%ax
80102e99:	66 90                	xchg   %ax,%ax
80102e9b:	66 90                	xchg   %ax,%ax
80102e9d:	66 90                	xchg   %ax,%ax
80102e9f:	90                   	nop

80102ea0 <lapicinit>:
}

void
lapicinit(void)
{
  if(!lapic)
80102ea0:	a1 c0 32 11 80       	mov    0x801132c0,%eax
80102ea5:	85 c0                	test   %eax,%eax
80102ea7:	0f 84 cb 00 00 00    	je     80102f78 <lapicinit+0xd8>
  lapic[index] = value;
80102ead:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
80102eb4:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102eb7:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102eba:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
80102ec1:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102ec4:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102ec7:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
80102ece:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
80102ed1:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102ed4:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
80102edb:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
80102ede:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102ee1:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
80102ee8:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102eeb:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102eee:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
80102ef5:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102ef8:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
80102efb:	8b 50 30             	mov    0x30(%eax),%edx
80102efe:	c1 ea 10             	shr    $0x10,%edx
80102f01:	81 e2 fc 00 00 00    	and    $0xfc,%edx
80102f07:	75 77                	jne    80102f80 <lapicinit+0xe0>
  lapic[index] = value;
80102f09:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
80102f10:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102f13:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102f16:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
80102f1d:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102f20:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102f23:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
80102f2a:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102f2d:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102f30:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102f37:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102f3a:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102f3d:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
80102f44:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102f47:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102f4a:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
80102f51:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
80102f54:	8b 50 20             	mov    0x20(%eax),%edx
80102f57:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102f5e:	66 90                	xchg   %ax,%ax
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
80102f60:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
80102f66:	80 e6 10             	and    $0x10,%dh
80102f69:	75 f5                	jne    80102f60 <lapicinit+0xc0>
  lapic[index] = value;
80102f6b:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
80102f72:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102f75:	8b 40 20             	mov    0x20(%eax),%eax
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
80102f78:	c3                   	ret    
80102f79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  lapic[index] = value;
80102f80:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
80102f87:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102f8a:	8b 50 20             	mov    0x20(%eax),%edx
}
80102f8d:	e9 77 ff ff ff       	jmp    80102f09 <lapicinit+0x69>
80102f92:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102f99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102fa0 <lapicid>:

int
lapicid(void)
{
  if (!lapic)
80102fa0:	a1 c0 32 11 80       	mov    0x801132c0,%eax
80102fa5:	85 c0                	test   %eax,%eax
80102fa7:	74 07                	je     80102fb0 <lapicid+0x10>
    return 0;
  return lapic[ID] >> 24;
80102fa9:	8b 40 20             	mov    0x20(%eax),%eax
80102fac:	c1 e8 18             	shr    $0x18,%eax
80102faf:	c3                   	ret    
    return 0;
80102fb0:	31 c0                	xor    %eax,%eax
}
80102fb2:	c3                   	ret    
80102fb3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102fba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102fc0 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
80102fc0:	a1 c0 32 11 80       	mov    0x801132c0,%eax
80102fc5:	85 c0                	test   %eax,%eax
80102fc7:	74 0d                	je     80102fd6 <lapiceoi+0x16>
  lapic[index] = value;
80102fc9:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102fd0:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102fd3:	8b 40 20             	mov    0x20(%eax),%eax
    lapicw(EOI, 0);
}
80102fd6:	c3                   	ret    
80102fd7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102fde:	66 90                	xchg   %ax,%ax

80102fe0 <microdelay>:
// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
}
80102fe0:	c3                   	ret    
80102fe1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102fe8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102fef:	90                   	nop

80102ff0 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80102ff0:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102ff1:	b8 0f 00 00 00       	mov    $0xf,%eax
80102ff6:	ba 70 00 00 00       	mov    $0x70,%edx
80102ffb:	89 e5                	mov    %esp,%ebp
80102ffd:	53                   	push   %ebx
80102ffe:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80103001:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103004:	ee                   	out    %al,(%dx)
80103005:	b8 0a 00 00 00       	mov    $0xa,%eax
8010300a:	ba 71 00 00 00       	mov    $0x71,%edx
8010300f:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
80103010:	31 c0                	xor    %eax,%eax
  wrv[1] = addr >> 4;

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
80103012:	c1 e3 18             	shl    $0x18,%ebx
  wrv[0] = 0;
80103015:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
8010301b:	89 c8                	mov    %ecx,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
8010301d:	c1 e9 0c             	shr    $0xc,%ecx
  lapicw(ICRHI, apicid<<24);
80103020:	89 da                	mov    %ebx,%edx
  wrv[1] = addr >> 4;
80103022:	c1 e8 04             	shr    $0x4,%eax
    lapicw(ICRLO, STARTUP | (addr>>12));
80103025:	80 cd 06             	or     $0x6,%ch
  wrv[1] = addr >> 4;
80103028:	66 a3 69 04 00 80    	mov    %ax,0x80000469
  lapic[index] = value;
8010302e:	a1 c0 32 11 80       	mov    0x801132c0,%eax
80103033:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80103039:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
8010303c:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
80103043:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
80103046:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80103049:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
80103050:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
80103053:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80103056:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
8010305c:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
8010305f:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80103065:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80103068:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
8010306e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80103071:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80103077:	8b 40 20             	mov    0x20(%eax),%eax
    microdelay(200);
  }
}
8010307a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010307d:	c9                   	leave  
8010307e:	c3                   	ret    
8010307f:	90                   	nop

80103080 <cmostime>:
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void
cmostime(struct rtcdate *r)
{
80103080:	55                   	push   %ebp
80103081:	b8 0b 00 00 00       	mov    $0xb,%eax
80103086:	ba 70 00 00 00       	mov    $0x70,%edx
8010308b:	89 e5                	mov    %esp,%ebp
8010308d:	57                   	push   %edi
8010308e:	56                   	push   %esi
8010308f:	53                   	push   %ebx
80103090:	83 ec 4c             	sub    $0x4c,%esp
80103093:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103094:	ba 71 00 00 00       	mov    $0x71,%edx
80103099:	ec                   	in     (%dx),%al
  struct rtcdate t1, t2;
  int sb, bcd;

  sb = cmos_read(CMOS_STATB);

  bcd = (sb & (1 << 2)) == 0;
8010309a:	83 e0 04             	and    $0x4,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010309d:	bb 70 00 00 00       	mov    $0x70,%ebx
801030a2:	88 45 b3             	mov    %al,-0x4d(%ebp)
801030a5:	8d 76 00             	lea    0x0(%esi),%esi
801030a8:	31 c0                	xor    %eax,%eax
801030aa:	89 da                	mov    %ebx,%edx
801030ac:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801030ad:	b9 71 00 00 00       	mov    $0x71,%ecx
801030b2:	89 ca                	mov    %ecx,%edx
801030b4:	ec                   	in     (%dx),%al
801030b5:	88 45 b7             	mov    %al,-0x49(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801030b8:	89 da                	mov    %ebx,%edx
801030ba:	b8 02 00 00 00       	mov    $0x2,%eax
801030bf:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801030c0:	89 ca                	mov    %ecx,%edx
801030c2:	ec                   	in     (%dx),%al
801030c3:	88 45 b6             	mov    %al,-0x4a(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801030c6:	89 da                	mov    %ebx,%edx
801030c8:	b8 04 00 00 00       	mov    $0x4,%eax
801030cd:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801030ce:	89 ca                	mov    %ecx,%edx
801030d0:	ec                   	in     (%dx),%al
801030d1:	88 45 b5             	mov    %al,-0x4b(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801030d4:	89 da                	mov    %ebx,%edx
801030d6:	b8 07 00 00 00       	mov    $0x7,%eax
801030db:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801030dc:	89 ca                	mov    %ecx,%edx
801030de:	ec                   	in     (%dx),%al
801030df:	88 45 b4             	mov    %al,-0x4c(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801030e2:	89 da                	mov    %ebx,%edx
801030e4:	b8 08 00 00 00       	mov    $0x8,%eax
801030e9:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801030ea:	89 ca                	mov    %ecx,%edx
801030ec:	ec                   	in     (%dx),%al
801030ed:	89 c7                	mov    %eax,%edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801030ef:	89 da                	mov    %ebx,%edx
801030f1:	b8 09 00 00 00       	mov    $0x9,%eax
801030f6:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801030f7:	89 ca                	mov    %ecx,%edx
801030f9:	ec                   	in     (%dx),%al
801030fa:	89 c6                	mov    %eax,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801030fc:	89 da                	mov    %ebx,%edx
801030fe:	b8 0a 00 00 00       	mov    $0xa,%eax
80103103:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103104:	89 ca                	mov    %ecx,%edx
80103106:	ec                   	in     (%dx),%al

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
80103107:	84 c0                	test   %al,%al
80103109:	78 9d                	js     801030a8 <cmostime+0x28>
  return inb(CMOS_RETURN);
8010310b:	0f b6 45 b7          	movzbl -0x49(%ebp),%eax
8010310f:	89 fa                	mov    %edi,%edx
80103111:	0f b6 fa             	movzbl %dl,%edi
80103114:	89 f2                	mov    %esi,%edx
80103116:	89 45 b8             	mov    %eax,-0x48(%ebp)
80103119:	0f b6 45 b6          	movzbl -0x4a(%ebp),%eax
8010311d:	0f b6 f2             	movzbl %dl,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103120:	89 da                	mov    %ebx,%edx
80103122:	89 7d c8             	mov    %edi,-0x38(%ebp)
80103125:	89 45 bc             	mov    %eax,-0x44(%ebp)
80103128:	0f b6 45 b5          	movzbl -0x4b(%ebp),%eax
8010312c:	89 75 cc             	mov    %esi,-0x34(%ebp)
8010312f:	89 45 c0             	mov    %eax,-0x40(%ebp)
80103132:	0f b6 45 b4          	movzbl -0x4c(%ebp),%eax
80103136:	89 45 c4             	mov    %eax,-0x3c(%ebp)
80103139:	31 c0                	xor    %eax,%eax
8010313b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010313c:	89 ca                	mov    %ecx,%edx
8010313e:	ec                   	in     (%dx),%al
8010313f:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103142:	89 da                	mov    %ebx,%edx
80103144:	89 45 d0             	mov    %eax,-0x30(%ebp)
80103147:	b8 02 00 00 00       	mov    $0x2,%eax
8010314c:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010314d:	89 ca                	mov    %ecx,%edx
8010314f:	ec                   	in     (%dx),%al
80103150:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103153:	89 da                	mov    %ebx,%edx
80103155:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80103158:	b8 04 00 00 00       	mov    $0x4,%eax
8010315d:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010315e:	89 ca                	mov    %ecx,%edx
80103160:	ec                   	in     (%dx),%al
80103161:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103164:	89 da                	mov    %ebx,%edx
80103166:	89 45 d8             	mov    %eax,-0x28(%ebp)
80103169:	b8 07 00 00 00       	mov    $0x7,%eax
8010316e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010316f:	89 ca                	mov    %ecx,%edx
80103171:	ec                   	in     (%dx),%al
80103172:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103175:	89 da                	mov    %ebx,%edx
80103177:	89 45 dc             	mov    %eax,-0x24(%ebp)
8010317a:	b8 08 00 00 00       	mov    $0x8,%eax
8010317f:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103180:	89 ca                	mov    %ecx,%edx
80103182:	ec                   	in     (%dx),%al
80103183:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103186:	89 da                	mov    %ebx,%edx
80103188:	89 45 e0             	mov    %eax,-0x20(%ebp)
8010318b:	b8 09 00 00 00       	mov    $0x9,%eax
80103190:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103191:	89 ca                	mov    %ecx,%edx
80103193:	ec                   	in     (%dx),%al
80103194:	0f b6 c0             	movzbl %al,%eax
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80103197:	83 ec 04             	sub    $0x4,%esp
  return inb(CMOS_RETURN);
8010319a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
8010319d:	8d 45 d0             	lea    -0x30(%ebp),%eax
801031a0:	6a 18                	push   $0x18
801031a2:	50                   	push   %eax
801031a3:	8d 45 b8             	lea    -0x48(%ebp),%eax
801031a6:	50                   	push   %eax
801031a7:	e8 b4 1b 00 00       	call   80104d60 <memcmp>
801031ac:	83 c4 10             	add    $0x10,%esp
801031af:	85 c0                	test   %eax,%eax
801031b1:	0f 85 f1 fe ff ff    	jne    801030a8 <cmostime+0x28>
      break;
  }

  // convert
  if(bcd) {
801031b7:	80 7d b3 00          	cmpb   $0x0,-0x4d(%ebp)
801031bb:	75 78                	jne    80103235 <cmostime+0x1b5>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
801031bd:	8b 45 b8             	mov    -0x48(%ebp),%eax
801031c0:	89 c2                	mov    %eax,%edx
801031c2:	83 e0 0f             	and    $0xf,%eax
801031c5:	c1 ea 04             	shr    $0x4,%edx
801031c8:	8d 14 92             	lea    (%edx,%edx,4),%edx
801031cb:	8d 04 50             	lea    (%eax,%edx,2),%eax
801031ce:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
801031d1:	8b 45 bc             	mov    -0x44(%ebp),%eax
801031d4:	89 c2                	mov    %eax,%edx
801031d6:	83 e0 0f             	and    $0xf,%eax
801031d9:	c1 ea 04             	shr    $0x4,%edx
801031dc:	8d 14 92             	lea    (%edx,%edx,4),%edx
801031df:	8d 04 50             	lea    (%eax,%edx,2),%eax
801031e2:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
801031e5:	8b 45 c0             	mov    -0x40(%ebp),%eax
801031e8:	89 c2                	mov    %eax,%edx
801031ea:	83 e0 0f             	and    $0xf,%eax
801031ed:	c1 ea 04             	shr    $0x4,%edx
801031f0:	8d 14 92             	lea    (%edx,%edx,4),%edx
801031f3:	8d 04 50             	lea    (%eax,%edx,2),%eax
801031f6:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
801031f9:	8b 45 c4             	mov    -0x3c(%ebp),%eax
801031fc:	89 c2                	mov    %eax,%edx
801031fe:	83 e0 0f             	and    $0xf,%eax
80103201:	c1 ea 04             	shr    $0x4,%edx
80103204:	8d 14 92             	lea    (%edx,%edx,4),%edx
80103207:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010320a:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
8010320d:	8b 45 c8             	mov    -0x38(%ebp),%eax
80103210:	89 c2                	mov    %eax,%edx
80103212:	83 e0 0f             	and    $0xf,%eax
80103215:	c1 ea 04             	shr    $0x4,%edx
80103218:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010321b:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010321e:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
80103221:	8b 45 cc             	mov    -0x34(%ebp),%eax
80103224:	89 c2                	mov    %eax,%edx
80103226:	83 e0 0f             	and    $0xf,%eax
80103229:	c1 ea 04             	shr    $0x4,%edx
8010322c:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010322f:	8d 04 50             	lea    (%eax,%edx,2),%eax
80103232:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
80103235:	8b 75 08             	mov    0x8(%ebp),%esi
80103238:	8b 45 b8             	mov    -0x48(%ebp),%eax
8010323b:	89 06                	mov    %eax,(%esi)
8010323d:	8b 45 bc             	mov    -0x44(%ebp),%eax
80103240:	89 46 04             	mov    %eax,0x4(%esi)
80103243:	8b 45 c0             	mov    -0x40(%ebp),%eax
80103246:	89 46 08             	mov    %eax,0x8(%esi)
80103249:	8b 45 c4             	mov    -0x3c(%ebp),%eax
8010324c:	89 46 0c             	mov    %eax,0xc(%esi)
8010324f:	8b 45 c8             	mov    -0x38(%ebp),%eax
80103252:	89 46 10             	mov    %eax,0x10(%esi)
80103255:	8b 45 cc             	mov    -0x34(%ebp),%eax
80103258:	89 46 14             	mov    %eax,0x14(%esi)
  r->year += 2000;
8010325b:	81 46 14 d0 07 00 00 	addl   $0x7d0,0x14(%esi)
}
80103262:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103265:	5b                   	pop    %ebx
80103266:	5e                   	pop    %esi
80103267:	5f                   	pop    %edi
80103268:	5d                   	pop    %ebp
80103269:	c3                   	ret    
8010326a:	66 90                	xchg   %ax,%ax
8010326c:	66 90                	xchg   %ax,%ax
8010326e:	66 90                	xchg   %ax,%ax

80103270 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80103270:	8b 0d 28 33 11 80    	mov    0x80113328,%ecx
80103276:	85 c9                	test   %ecx,%ecx
80103278:	0f 8e 8a 00 00 00    	jle    80103308 <install_trans+0x98>
{
8010327e:	55                   	push   %ebp
8010327f:	89 e5                	mov    %esp,%ebp
80103281:	57                   	push   %edi
  for (tail = 0; tail < log.lh.n; tail++) {
80103282:	31 ff                	xor    %edi,%edi
{
80103284:	56                   	push   %esi
80103285:	53                   	push   %ebx
80103286:	83 ec 0c             	sub    $0xc,%esp
80103289:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80103290:	a1 14 33 11 80       	mov    0x80113314,%eax
80103295:	83 ec 08             	sub    $0x8,%esp
80103298:	01 f8                	add    %edi,%eax
8010329a:	83 c0 01             	add    $0x1,%eax
8010329d:	50                   	push   %eax
8010329e:	ff 35 24 33 11 80    	push   0x80113324
801032a4:	e8 27 ce ff ff       	call   801000d0 <bread>
801032a9:	89 c6                	mov    %eax,%esi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
801032ab:	58                   	pop    %eax
801032ac:	5a                   	pop    %edx
801032ad:	ff 34 bd 2c 33 11 80 	push   -0x7feeccd4(,%edi,4)
801032b4:	ff 35 24 33 11 80    	push   0x80113324
  for (tail = 0; tail < log.lh.n; tail++) {
801032ba:	83 c7 01             	add    $0x1,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
801032bd:	e8 0e ce ff ff       	call   801000d0 <bread>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
801032c2:	83 c4 0c             	add    $0xc,%esp
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
801032c5:	89 c3                	mov    %eax,%ebx
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
801032c7:	8d 46 5c             	lea    0x5c(%esi),%eax
801032ca:	68 00 02 00 00       	push   $0x200
801032cf:	50                   	push   %eax
801032d0:	8d 43 5c             	lea    0x5c(%ebx),%eax
801032d3:	50                   	push   %eax
801032d4:	e8 d7 1a 00 00       	call   80104db0 <memmove>
    bwrite(dbuf);  // write dst to disk
801032d9:	89 1c 24             	mov    %ebx,(%esp)
801032dc:	e8 cf ce ff ff       	call   801001b0 <bwrite>
    brelse(lbuf);
801032e1:	89 34 24             	mov    %esi,(%esp)
801032e4:	e8 07 cf ff ff       	call   801001f0 <brelse>
    brelse(dbuf);
801032e9:	89 1c 24             	mov    %ebx,(%esp)
801032ec:	e8 ff ce ff ff       	call   801001f0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
801032f1:	83 c4 10             	add    $0x10,%esp
801032f4:	39 3d 28 33 11 80    	cmp    %edi,0x80113328
801032fa:	7f 94                	jg     80103290 <install_trans+0x20>
  }
}
801032fc:	8d 65 f4             	lea    -0xc(%ebp),%esp
801032ff:	5b                   	pop    %ebx
80103300:	5e                   	pop    %esi
80103301:	5f                   	pop    %edi
80103302:	5d                   	pop    %ebp
80103303:	c3                   	ret    
80103304:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103308:	c3                   	ret    
80103309:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103310 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80103310:	55                   	push   %ebp
80103311:	89 e5                	mov    %esp,%ebp
80103313:	53                   	push   %ebx
80103314:	83 ec 0c             	sub    $0xc,%esp
  struct buf *buf = bread(log.dev, log.start);
80103317:	ff 35 14 33 11 80    	push   0x80113314
8010331d:	ff 35 24 33 11 80    	push   0x80113324
80103323:	e8 a8 cd ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
80103328:	83 c4 10             	add    $0x10,%esp
  struct buf *buf = bread(log.dev, log.start);
8010332b:	89 c3                	mov    %eax,%ebx
  hb->n = log.lh.n;
8010332d:	a1 28 33 11 80       	mov    0x80113328,%eax
80103332:	89 43 5c             	mov    %eax,0x5c(%ebx)
  for (i = 0; i < log.lh.n; i++) {
80103335:	85 c0                	test   %eax,%eax
80103337:	7e 19                	jle    80103352 <write_head+0x42>
80103339:	31 d2                	xor    %edx,%edx
8010333b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010333f:	90                   	nop
    hb->block[i] = log.lh.block[i];
80103340:	8b 0c 95 2c 33 11 80 	mov    -0x7feeccd4(,%edx,4),%ecx
80103347:	89 4c 93 60          	mov    %ecx,0x60(%ebx,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
8010334b:	83 c2 01             	add    $0x1,%edx
8010334e:	39 d0                	cmp    %edx,%eax
80103350:	75 ee                	jne    80103340 <write_head+0x30>
  }
  bwrite(buf);
80103352:	83 ec 0c             	sub    $0xc,%esp
80103355:	53                   	push   %ebx
80103356:	e8 55 ce ff ff       	call   801001b0 <bwrite>
  brelse(buf);
8010335b:	89 1c 24             	mov    %ebx,(%esp)
8010335e:	e8 8d ce ff ff       	call   801001f0 <brelse>
}
80103363:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103366:	83 c4 10             	add    $0x10,%esp
80103369:	c9                   	leave  
8010336a:	c3                   	ret    
8010336b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010336f:	90                   	nop

80103370 <initlog>:
{
80103370:	55                   	push   %ebp
80103371:	89 e5                	mov    %esp,%ebp
80103373:	53                   	push   %ebx
80103374:	83 ec 2c             	sub    $0x2c,%esp
80103377:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&log.lock, "log");
8010337a:	68 40 7d 10 80       	push   $0x80107d40
8010337f:	68 e0 32 11 80       	push   $0x801132e0
80103384:	e8 f7 16 00 00       	call   80104a80 <initlock>
  readsb(dev, &sb);
80103389:	58                   	pop    %eax
8010338a:	8d 45 dc             	lea    -0x24(%ebp),%eax
8010338d:	5a                   	pop    %edx
8010338e:	50                   	push   %eax
8010338f:	53                   	push   %ebx
80103390:	e8 3b e8 ff ff       	call   80101bd0 <readsb>
  log.start = sb.logstart;
80103395:	8b 45 ec             	mov    -0x14(%ebp),%eax
  struct buf *buf = bread(log.dev, log.start);
80103398:	59                   	pop    %ecx
  log.dev = dev;
80103399:	89 1d 24 33 11 80    	mov    %ebx,0x80113324
  log.size = sb.nlog;
8010339f:	8b 55 e8             	mov    -0x18(%ebp),%edx
  log.start = sb.logstart;
801033a2:	a3 14 33 11 80       	mov    %eax,0x80113314
  log.size = sb.nlog;
801033a7:	89 15 18 33 11 80    	mov    %edx,0x80113318
  struct buf *buf = bread(log.dev, log.start);
801033ad:	5a                   	pop    %edx
801033ae:	50                   	push   %eax
801033af:	53                   	push   %ebx
801033b0:	e8 1b cd ff ff       	call   801000d0 <bread>
  for (i = 0; i < log.lh.n; i++) {
801033b5:	83 c4 10             	add    $0x10,%esp
  log.lh.n = lh->n;
801033b8:	8b 58 5c             	mov    0x5c(%eax),%ebx
801033bb:	89 1d 28 33 11 80    	mov    %ebx,0x80113328
  for (i = 0; i < log.lh.n; i++) {
801033c1:	85 db                	test   %ebx,%ebx
801033c3:	7e 1d                	jle    801033e2 <initlog+0x72>
801033c5:	31 d2                	xor    %edx,%edx
801033c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801033ce:	66 90                	xchg   %ax,%ax
    log.lh.block[i] = lh->block[i];
801033d0:	8b 4c 90 60          	mov    0x60(%eax,%edx,4),%ecx
801033d4:	89 0c 95 2c 33 11 80 	mov    %ecx,-0x7feeccd4(,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
801033db:	83 c2 01             	add    $0x1,%edx
801033de:	39 d3                	cmp    %edx,%ebx
801033e0:	75 ee                	jne    801033d0 <initlog+0x60>
  brelse(buf);
801033e2:	83 ec 0c             	sub    $0xc,%esp
801033e5:	50                   	push   %eax
801033e6:	e8 05 ce ff ff       	call   801001f0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
801033eb:	e8 80 fe ff ff       	call   80103270 <install_trans>
  log.lh.n = 0;
801033f0:	c7 05 28 33 11 80 00 	movl   $0x0,0x80113328
801033f7:	00 00 00 
  write_head(); // clear the log
801033fa:	e8 11 ff ff ff       	call   80103310 <write_head>
}
801033ff:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103402:	83 c4 10             	add    $0x10,%esp
80103405:	c9                   	leave  
80103406:	c3                   	ret    
80103407:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010340e:	66 90                	xchg   %ax,%ax

80103410 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80103410:	55                   	push   %ebp
80103411:	89 e5                	mov    %esp,%ebp
80103413:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
80103416:	68 e0 32 11 80       	push   $0x801132e0
8010341b:	e8 30 18 00 00       	call   80104c50 <acquire>
80103420:	83 c4 10             	add    $0x10,%esp
80103423:	eb 18                	jmp    8010343d <begin_op+0x2d>
80103425:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80103428:	83 ec 08             	sub    $0x8,%esp
8010342b:	68 e0 32 11 80       	push   $0x801132e0
80103430:	68 e0 32 11 80       	push   $0x801132e0
80103435:	e8 b6 12 00 00       	call   801046f0 <sleep>
8010343a:	83 c4 10             	add    $0x10,%esp
    if(log.committing){
8010343d:	a1 20 33 11 80       	mov    0x80113320,%eax
80103442:	85 c0                	test   %eax,%eax
80103444:	75 e2                	jne    80103428 <begin_op+0x18>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80103446:	a1 1c 33 11 80       	mov    0x8011331c,%eax
8010344b:	8b 15 28 33 11 80    	mov    0x80113328,%edx
80103451:	83 c0 01             	add    $0x1,%eax
80103454:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80103457:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
8010345a:	83 fa 1e             	cmp    $0x1e,%edx
8010345d:	7f c9                	jg     80103428 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
8010345f:	83 ec 0c             	sub    $0xc,%esp
      log.outstanding += 1;
80103462:	a3 1c 33 11 80       	mov    %eax,0x8011331c
      release(&log.lock);
80103467:	68 e0 32 11 80       	push   $0x801132e0
8010346c:	e8 7f 17 00 00       	call   80104bf0 <release>
      break;
    }
  }
}
80103471:	83 c4 10             	add    $0x10,%esp
80103474:	c9                   	leave  
80103475:	c3                   	ret    
80103476:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010347d:	8d 76 00             	lea    0x0(%esi),%esi

80103480 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80103480:	55                   	push   %ebp
80103481:	89 e5                	mov    %esp,%ebp
80103483:	57                   	push   %edi
80103484:	56                   	push   %esi
80103485:	53                   	push   %ebx
80103486:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;

  acquire(&log.lock);
80103489:	68 e0 32 11 80       	push   $0x801132e0
8010348e:	e8 bd 17 00 00       	call   80104c50 <acquire>
  log.outstanding -= 1;
80103493:	a1 1c 33 11 80       	mov    0x8011331c,%eax
  if(log.committing)
80103498:	8b 35 20 33 11 80    	mov    0x80113320,%esi
8010349e:	83 c4 10             	add    $0x10,%esp
  log.outstanding -= 1;
801034a1:	8d 58 ff             	lea    -0x1(%eax),%ebx
801034a4:	89 1d 1c 33 11 80    	mov    %ebx,0x8011331c
  if(log.committing)
801034aa:	85 f6                	test   %esi,%esi
801034ac:	0f 85 22 01 00 00    	jne    801035d4 <end_op+0x154>
    panic("log.committing");
  if(log.outstanding == 0){
801034b2:	85 db                	test   %ebx,%ebx
801034b4:	0f 85 f6 00 00 00    	jne    801035b0 <end_op+0x130>
    do_commit = 1;
    log.committing = 1;
801034ba:	c7 05 20 33 11 80 01 	movl   $0x1,0x80113320
801034c1:	00 00 00 
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
801034c4:	83 ec 0c             	sub    $0xc,%esp
801034c7:	68 e0 32 11 80       	push   $0x801132e0
801034cc:	e8 1f 17 00 00       	call   80104bf0 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
801034d1:	8b 0d 28 33 11 80    	mov    0x80113328,%ecx
801034d7:	83 c4 10             	add    $0x10,%esp
801034da:	85 c9                	test   %ecx,%ecx
801034dc:	7f 42                	jg     80103520 <end_op+0xa0>
    acquire(&log.lock);
801034de:	83 ec 0c             	sub    $0xc,%esp
801034e1:	68 e0 32 11 80       	push   $0x801132e0
801034e6:	e8 65 17 00 00       	call   80104c50 <acquire>
    wakeup(&log);
801034eb:	c7 04 24 e0 32 11 80 	movl   $0x801132e0,(%esp)
    log.committing = 0;
801034f2:	c7 05 20 33 11 80 00 	movl   $0x0,0x80113320
801034f9:	00 00 00 
    wakeup(&log);
801034fc:	e8 af 12 00 00       	call   801047b0 <wakeup>
    release(&log.lock);
80103501:	c7 04 24 e0 32 11 80 	movl   $0x801132e0,(%esp)
80103508:	e8 e3 16 00 00       	call   80104bf0 <release>
8010350d:	83 c4 10             	add    $0x10,%esp
}
80103510:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103513:	5b                   	pop    %ebx
80103514:	5e                   	pop    %esi
80103515:	5f                   	pop    %edi
80103516:	5d                   	pop    %ebp
80103517:	c3                   	ret    
80103518:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010351f:	90                   	nop
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80103520:	a1 14 33 11 80       	mov    0x80113314,%eax
80103525:	83 ec 08             	sub    $0x8,%esp
80103528:	01 d8                	add    %ebx,%eax
8010352a:	83 c0 01             	add    $0x1,%eax
8010352d:	50                   	push   %eax
8010352e:	ff 35 24 33 11 80    	push   0x80113324
80103534:	e8 97 cb ff ff       	call   801000d0 <bread>
80103539:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
8010353b:	58                   	pop    %eax
8010353c:	5a                   	pop    %edx
8010353d:	ff 34 9d 2c 33 11 80 	push   -0x7feeccd4(,%ebx,4)
80103544:	ff 35 24 33 11 80    	push   0x80113324
  for (tail = 0; tail < log.lh.n; tail++) {
8010354a:	83 c3 01             	add    $0x1,%ebx
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
8010354d:	e8 7e cb ff ff       	call   801000d0 <bread>
    memmove(to->data, from->data, BSIZE);
80103552:	83 c4 0c             	add    $0xc,%esp
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80103555:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80103557:	8d 40 5c             	lea    0x5c(%eax),%eax
8010355a:	68 00 02 00 00       	push   $0x200
8010355f:	50                   	push   %eax
80103560:	8d 46 5c             	lea    0x5c(%esi),%eax
80103563:	50                   	push   %eax
80103564:	e8 47 18 00 00       	call   80104db0 <memmove>
    bwrite(to);  // write the log
80103569:	89 34 24             	mov    %esi,(%esp)
8010356c:	e8 3f cc ff ff       	call   801001b0 <bwrite>
    brelse(from);
80103571:	89 3c 24             	mov    %edi,(%esp)
80103574:	e8 77 cc ff ff       	call   801001f0 <brelse>
    brelse(to);
80103579:	89 34 24             	mov    %esi,(%esp)
8010357c:	e8 6f cc ff ff       	call   801001f0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80103581:	83 c4 10             	add    $0x10,%esp
80103584:	3b 1d 28 33 11 80    	cmp    0x80113328,%ebx
8010358a:	7c 94                	jl     80103520 <end_op+0xa0>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
8010358c:	e8 7f fd ff ff       	call   80103310 <write_head>
    install_trans(); // Now install writes to home locations
80103591:	e8 da fc ff ff       	call   80103270 <install_trans>
    log.lh.n = 0;
80103596:	c7 05 28 33 11 80 00 	movl   $0x0,0x80113328
8010359d:	00 00 00 
    write_head();    // Erase the transaction from the log
801035a0:	e8 6b fd ff ff       	call   80103310 <write_head>
801035a5:	e9 34 ff ff ff       	jmp    801034de <end_op+0x5e>
801035aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    wakeup(&log);
801035b0:	83 ec 0c             	sub    $0xc,%esp
801035b3:	68 e0 32 11 80       	push   $0x801132e0
801035b8:	e8 f3 11 00 00       	call   801047b0 <wakeup>
  release(&log.lock);
801035bd:	c7 04 24 e0 32 11 80 	movl   $0x801132e0,(%esp)
801035c4:	e8 27 16 00 00       	call   80104bf0 <release>
801035c9:	83 c4 10             	add    $0x10,%esp
}
801035cc:	8d 65 f4             	lea    -0xc(%ebp),%esp
801035cf:	5b                   	pop    %ebx
801035d0:	5e                   	pop    %esi
801035d1:	5f                   	pop    %edi
801035d2:	5d                   	pop    %ebp
801035d3:	c3                   	ret    
    panic("log.committing");
801035d4:	83 ec 0c             	sub    $0xc,%esp
801035d7:	68 44 7d 10 80       	push   $0x80107d44
801035dc:	e8 bf cd ff ff       	call   801003a0 <panic>
801035e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801035e8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801035ef:	90                   	nop

801035f0 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
801035f0:	55                   	push   %ebp
801035f1:	89 e5                	mov    %esp,%ebp
801035f3:	53                   	push   %ebx
801035f4:	83 ec 04             	sub    $0x4,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
801035f7:	8b 15 28 33 11 80    	mov    0x80113328,%edx
{
801035fd:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80103600:	83 fa 1d             	cmp    $0x1d,%edx
80103603:	0f 8f 85 00 00 00    	jg     8010368e <log_write+0x9e>
80103609:	a1 18 33 11 80       	mov    0x80113318,%eax
8010360e:	83 e8 01             	sub    $0x1,%eax
80103611:	39 c2                	cmp    %eax,%edx
80103613:	7d 79                	jge    8010368e <log_write+0x9e>
    panic("too big a transaction");
  if (log.outstanding < 1)
80103615:	a1 1c 33 11 80       	mov    0x8011331c,%eax
8010361a:	85 c0                	test   %eax,%eax
8010361c:	7e 7d                	jle    8010369b <log_write+0xab>
    panic("log_write outside of trans");

  acquire(&log.lock);
8010361e:	83 ec 0c             	sub    $0xc,%esp
80103621:	68 e0 32 11 80       	push   $0x801132e0
80103626:	e8 25 16 00 00       	call   80104c50 <acquire>
  for (i = 0; i < log.lh.n; i++) {
8010362b:	8b 15 28 33 11 80    	mov    0x80113328,%edx
80103631:	83 c4 10             	add    $0x10,%esp
80103634:	85 d2                	test   %edx,%edx
80103636:	7e 4a                	jle    80103682 <log_write+0x92>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80103638:	8b 4b 08             	mov    0x8(%ebx),%ecx
  for (i = 0; i < log.lh.n; i++) {
8010363b:	31 c0                	xor    %eax,%eax
8010363d:	eb 08                	jmp    80103647 <log_write+0x57>
8010363f:	90                   	nop
80103640:	83 c0 01             	add    $0x1,%eax
80103643:	39 c2                	cmp    %eax,%edx
80103645:	74 29                	je     80103670 <log_write+0x80>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80103647:	39 0c 85 2c 33 11 80 	cmp    %ecx,-0x7feeccd4(,%eax,4)
8010364e:	75 f0                	jne    80103640 <log_write+0x50>
      break;
  }
  log.lh.block[i] = b->blockno;
80103650:	89 0c 85 2c 33 11 80 	mov    %ecx,-0x7feeccd4(,%eax,4)
  if (i == log.lh.n)
    log.lh.n++;
  b->flags |= B_DIRTY; // prevent eviction
80103657:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
}
8010365a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  release(&log.lock);
8010365d:	c7 45 08 e0 32 11 80 	movl   $0x801132e0,0x8(%ebp)
}
80103664:	c9                   	leave  
  release(&log.lock);
80103665:	e9 86 15 00 00       	jmp    80104bf0 <release>
8010366a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  log.lh.block[i] = b->blockno;
80103670:	89 0c 95 2c 33 11 80 	mov    %ecx,-0x7feeccd4(,%edx,4)
    log.lh.n++;
80103677:	83 c2 01             	add    $0x1,%edx
8010367a:	89 15 28 33 11 80    	mov    %edx,0x80113328
80103680:	eb d5                	jmp    80103657 <log_write+0x67>
  log.lh.block[i] = b->blockno;
80103682:	8b 43 08             	mov    0x8(%ebx),%eax
80103685:	a3 2c 33 11 80       	mov    %eax,0x8011332c
  if (i == log.lh.n)
8010368a:	75 cb                	jne    80103657 <log_write+0x67>
8010368c:	eb e9                	jmp    80103677 <log_write+0x87>
    panic("too big a transaction");
8010368e:	83 ec 0c             	sub    $0xc,%esp
80103691:	68 53 7d 10 80       	push   $0x80107d53
80103696:	e8 05 cd ff ff       	call   801003a0 <panic>
    panic("log_write outside of trans");
8010369b:	83 ec 0c             	sub    $0xc,%esp
8010369e:	68 69 7d 10 80       	push   $0x80107d69
801036a3:	e8 f8 cc ff ff       	call   801003a0 <panic>
801036a8:	66 90                	xchg   %ax,%ax
801036aa:	66 90                	xchg   %ax,%ax
801036ac:	66 90                	xchg   %ax,%ax
801036ae:	66 90                	xchg   %ax,%ax

801036b0 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
801036b0:	55                   	push   %ebp
801036b1:	89 e5                	mov    %esp,%ebp
801036b3:	53                   	push   %ebx
801036b4:	83 ec 04             	sub    $0x4,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
801036b7:	e8 44 09 00 00       	call   80104000 <cpuid>
801036bc:	89 c3                	mov    %eax,%ebx
801036be:	e8 3d 09 00 00       	call   80104000 <cpuid>
801036c3:	83 ec 04             	sub    $0x4,%esp
801036c6:	53                   	push   %ebx
801036c7:	50                   	push   %eax
801036c8:	68 84 7d 10 80       	push   $0x80107d84
801036cd:	e8 7e d0 ff ff       	call   80100750 <cprintf>
  idtinit();       // load idt register
801036d2:	e8 b9 28 00 00       	call   80105f90 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
801036d7:	e8 c4 08 00 00       	call   80103fa0 <mycpu>
801036dc:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
801036de:	b8 01 00 00 00       	mov    $0x1,%eax
801036e3:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
801036ea:	e8 f1 0b 00 00       	call   801042e0 <scheduler>
801036ef:	90                   	nop

801036f0 <mpenter>:
{
801036f0:	55                   	push   %ebp
801036f1:	89 e5                	mov    %esp,%ebp
801036f3:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
801036f6:	e8 85 39 00 00       	call   80107080 <switchkvm>
  seginit();
801036fb:	e8 f0 38 00 00       	call   80106ff0 <seginit>
  lapicinit();
80103700:	e8 9b f7 ff ff       	call   80102ea0 <lapicinit>
  mpmain();
80103705:	e8 a6 ff ff ff       	call   801036b0 <mpmain>
8010370a:	66 90                	xchg   %ax,%ax
8010370c:	66 90                	xchg   %ax,%ax
8010370e:	66 90                	xchg   %ax,%ax

80103710 <main>:
{
80103710:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80103714:	83 e4 f0             	and    $0xfffffff0,%esp
80103717:	ff 71 fc             	push   -0x4(%ecx)
8010371a:	55                   	push   %ebp
8010371b:	89 e5                	mov    %esp,%ebp
8010371d:	53                   	push   %ebx
8010371e:	51                   	push   %ecx
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
8010371f:	83 ec 08             	sub    $0x8,%esp
80103722:	68 00 00 40 80       	push   $0x80400000
80103727:	68 10 71 11 80       	push   $0x80117110
8010372c:	e8 8f f5 ff ff       	call   80102cc0 <kinit1>
  kvmalloc();      // kernel page table
80103731:	e8 3a 3e 00 00       	call   80107570 <kvmalloc>
  mpinit();        // detect other processors
80103736:	e8 85 01 00 00       	call   801038c0 <mpinit>
  lapicinit();     // interrupt controller
8010373b:	e8 60 f7 ff ff       	call   80102ea0 <lapicinit>
  seginit();       // segment descriptors
80103740:	e8 ab 38 00 00       	call   80106ff0 <seginit>
  picinit();       // disable pic
80103745:	e8 76 03 00 00       	call   80103ac0 <picinit>
  ioapicinit();    // another interrupt controller
8010374a:	e8 31 f3 ff ff       	call   80102a80 <ioapicinit>
  consoleinit();   // console hardware
8010374f:	e8 bc d9 ff ff       	call   80101110 <consoleinit>
  uartinit();      // serial port
80103754:	e8 27 2b 00 00       	call   80106280 <uartinit>
  pinit();         // process table
80103759:	e8 22 08 00 00       	call   80103f80 <pinit>
  tvinit();        // trap vectors
8010375e:	e8 ad 27 00 00       	call   80105f10 <tvinit>
  binit();         // buffer cache
80103763:	e8 d8 c8 ff ff       	call   80100040 <binit>
  fileinit();      // file table
80103768:	e8 53 dd ff ff       	call   801014c0 <fileinit>
  ideinit();       // disk 
8010376d:	e8 fe f0 ff ff       	call   80102870 <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80103772:	83 c4 0c             	add    $0xc,%esp
80103775:	68 8a 00 00 00       	push   $0x8a
8010377a:	68 8c b4 10 80       	push   $0x8010b48c
8010377f:	68 00 70 00 80       	push   $0x80007000
80103784:	e8 27 16 00 00       	call   80104db0 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
80103789:	83 c4 10             	add    $0x10,%esp
8010378c:	69 05 c4 33 11 80 b0 	imul   $0xb0,0x801133c4,%eax
80103793:	00 00 00 
80103796:	05 e0 33 11 80       	add    $0x801133e0,%eax
8010379b:	3d e0 33 11 80       	cmp    $0x801133e0,%eax
801037a0:	76 7e                	jbe    80103820 <main+0x110>
801037a2:	bb e0 33 11 80       	mov    $0x801133e0,%ebx
801037a7:	eb 20                	jmp    801037c9 <main+0xb9>
801037a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801037b0:	69 05 c4 33 11 80 b0 	imul   $0xb0,0x801133c4,%eax
801037b7:	00 00 00 
801037ba:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
801037c0:	05 e0 33 11 80       	add    $0x801133e0,%eax
801037c5:	39 c3                	cmp    %eax,%ebx
801037c7:	73 57                	jae    80103820 <main+0x110>
    if(c == mycpu())  // We've started already.
801037c9:	e8 d2 07 00 00       	call   80103fa0 <mycpu>
801037ce:	39 c3                	cmp    %eax,%ebx
801037d0:	74 de                	je     801037b0 <main+0xa0>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
801037d2:	e8 59 f5 ff ff       	call   80102d30 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
    *(void(**)(void))(code-8) = mpenter;
    *(int**)(code-12) = (void *) V2P(entrypgdir);

    lapicstartap(c->apicid, V2P(code));
801037d7:	83 ec 08             	sub    $0x8,%esp
    *(void(**)(void))(code-8) = mpenter;
801037da:	c7 05 f8 6f 00 80 f0 	movl   $0x801036f0,0x80006ff8
801037e1:	36 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
801037e4:	c7 05 f4 6f 00 80 00 	movl   $0x10a000,0x80006ff4
801037eb:	a0 10 00 
    *(void**)(code-4) = stack + KSTACKSIZE;
801037ee:	05 00 10 00 00       	add    $0x1000,%eax
801037f3:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc
    lapicstartap(c->apicid, V2P(code));
801037f8:	0f b6 03             	movzbl (%ebx),%eax
801037fb:	68 00 70 00 00       	push   $0x7000
80103800:	50                   	push   %eax
80103801:	e8 ea f7 ff ff       	call   80102ff0 <lapicstartap>

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80103806:	83 c4 10             	add    $0x10,%esp
80103809:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103810:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80103816:	85 c0                	test   %eax,%eax
80103818:	74 f6                	je     80103810 <main+0x100>
8010381a:	eb 94                	jmp    801037b0 <main+0xa0>
8010381c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80103820:	83 ec 08             	sub    $0x8,%esp
80103823:	68 00 00 00 8e       	push   $0x8e000000
80103828:	68 00 00 40 80       	push   $0x80400000
8010382d:	e8 2e f4 ff ff       	call   80102c60 <kinit2>
  userinit();      // first user process
80103832:	e8 19 08 00 00       	call   80104050 <userinit>
  mpmain();        // finish this processor's setup
80103837:	e8 74 fe ff ff       	call   801036b0 <mpmain>
8010383c:	66 90                	xchg   %ax,%ax
8010383e:	66 90                	xchg   %ax,%ax

80103840 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80103840:	55                   	push   %ebp
80103841:	89 e5                	mov    %esp,%ebp
80103843:	57                   	push   %edi
80103844:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
80103845:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
{
8010384b:	53                   	push   %ebx
  e = addr+len;
8010384c:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
{
8010384f:	83 ec 0c             	sub    $0xc,%esp
  for(p = addr; p < e; p += sizeof(struct mp))
80103852:	39 de                	cmp    %ebx,%esi
80103854:	72 10                	jb     80103866 <mpsearch1+0x26>
80103856:	eb 50                	jmp    801038a8 <mpsearch1+0x68>
80103858:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010385f:	90                   	nop
80103860:	89 fe                	mov    %edi,%esi
80103862:	39 fb                	cmp    %edi,%ebx
80103864:	76 42                	jbe    801038a8 <mpsearch1+0x68>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103866:	83 ec 04             	sub    $0x4,%esp
80103869:	8d 7e 10             	lea    0x10(%esi),%edi
8010386c:	6a 04                	push   $0x4
8010386e:	68 98 7d 10 80       	push   $0x80107d98
80103873:	56                   	push   %esi
80103874:	e8 e7 14 00 00       	call   80104d60 <memcmp>
80103879:	83 c4 10             	add    $0x10,%esp
8010387c:	85 c0                	test   %eax,%eax
8010387e:	75 e0                	jne    80103860 <mpsearch1+0x20>
80103880:	89 f2                	mov    %esi,%edx
80103882:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    sum += addr[i];
80103888:	0f b6 0a             	movzbl (%edx),%ecx
  for(i=0; i<len; i++)
8010388b:	83 c2 01             	add    $0x1,%edx
    sum += addr[i];
8010388e:	01 c8                	add    %ecx,%eax
  for(i=0; i<len; i++)
80103890:	39 fa                	cmp    %edi,%edx
80103892:	75 f4                	jne    80103888 <mpsearch1+0x48>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103894:	84 c0                	test   %al,%al
80103896:	75 c8                	jne    80103860 <mpsearch1+0x20>
      return (struct mp*)p;
  return 0;
}
80103898:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010389b:	89 f0                	mov    %esi,%eax
8010389d:	5b                   	pop    %ebx
8010389e:	5e                   	pop    %esi
8010389f:	5f                   	pop    %edi
801038a0:	5d                   	pop    %ebp
801038a1:	c3                   	ret    
801038a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801038a8:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801038ab:	31 f6                	xor    %esi,%esi
}
801038ad:	5b                   	pop    %ebx
801038ae:	89 f0                	mov    %esi,%eax
801038b0:	5e                   	pop    %esi
801038b1:	5f                   	pop    %edi
801038b2:	5d                   	pop    %ebp
801038b3:	c3                   	ret    
801038b4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801038bb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801038bf:	90                   	nop

801038c0 <mpinit>:
  return conf;
}

void
mpinit(void)
{
801038c0:	55                   	push   %ebp
801038c1:	89 e5                	mov    %esp,%ebp
801038c3:	57                   	push   %edi
801038c4:	56                   	push   %esi
801038c5:	53                   	push   %ebx
801038c6:	83 ec 1c             	sub    $0x1c,%esp
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
801038c9:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
801038d0:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
801038d7:	c1 e0 08             	shl    $0x8,%eax
801038da:	09 d0                	or     %edx,%eax
801038dc:	c1 e0 04             	shl    $0x4,%eax
801038df:	75 1b                	jne    801038fc <mpinit+0x3c>
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
801038e1:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
801038e8:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
801038ef:	c1 e0 08             	shl    $0x8,%eax
801038f2:	09 d0                	or     %edx,%eax
801038f4:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
801038f7:	2d 00 04 00 00       	sub    $0x400,%eax
    if((mp = mpsearch1(p, 1024)))
801038fc:	ba 00 04 00 00       	mov    $0x400,%edx
80103901:	e8 3a ff ff ff       	call   80103840 <mpsearch1>
80103906:	89 c3                	mov    %eax,%ebx
80103908:	85 c0                	test   %eax,%eax
8010390a:	0f 84 40 01 00 00    	je     80103a50 <mpinit+0x190>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103910:	8b 73 04             	mov    0x4(%ebx),%esi
80103913:	85 f6                	test   %esi,%esi
80103915:	0f 84 25 01 00 00    	je     80103a40 <mpinit+0x180>
  if(memcmp(conf, "PCMP", 4) != 0)
8010391b:	83 ec 04             	sub    $0x4,%esp
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
8010391e:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
  if(memcmp(conf, "PCMP", 4) != 0)
80103924:	6a 04                	push   $0x4
80103926:	68 9d 7d 10 80       	push   $0x80107d9d
8010392b:	50                   	push   %eax
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
8010392c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(memcmp(conf, "PCMP", 4) != 0)
8010392f:	e8 2c 14 00 00       	call   80104d60 <memcmp>
80103934:	83 c4 10             	add    $0x10,%esp
80103937:	85 c0                	test   %eax,%eax
80103939:	0f 85 01 01 00 00    	jne    80103a40 <mpinit+0x180>
  if(conf->version != 1 && conf->version != 4)
8010393f:	0f b6 86 06 00 00 80 	movzbl -0x7ffffffa(%esi),%eax
80103946:	3c 01                	cmp    $0x1,%al
80103948:	74 08                	je     80103952 <mpinit+0x92>
8010394a:	3c 04                	cmp    $0x4,%al
8010394c:	0f 85 ee 00 00 00    	jne    80103a40 <mpinit+0x180>
  if(sum((uchar*)conf, conf->length) != 0)
80103952:	0f b7 96 04 00 00 80 	movzwl -0x7ffffffc(%esi),%edx
  for(i=0; i<len; i++)
80103959:	66 85 d2             	test   %dx,%dx
8010395c:	74 22                	je     80103980 <mpinit+0xc0>
8010395e:	8d 3c 32             	lea    (%edx,%esi,1),%edi
80103961:	89 f0                	mov    %esi,%eax
  sum = 0;
80103963:	31 d2                	xor    %edx,%edx
80103965:	8d 76 00             	lea    0x0(%esi),%esi
    sum += addr[i];
80103968:	0f b6 88 00 00 00 80 	movzbl -0x80000000(%eax),%ecx
  for(i=0; i<len; i++)
8010396f:	83 c0 01             	add    $0x1,%eax
    sum += addr[i];
80103972:	01 ca                	add    %ecx,%edx
  for(i=0; i<len; i++)
80103974:	39 c7                	cmp    %eax,%edi
80103976:	75 f0                	jne    80103968 <mpinit+0xa8>
  if(sum((uchar*)conf, conf->length) != 0)
80103978:	84 d2                	test   %dl,%dl
8010397a:	0f 85 c0 00 00 00    	jne    80103a40 <mpinit+0x180>
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
80103980:	8b 86 24 00 00 80    	mov    -0x7fffffdc(%esi),%eax
80103986:	a3 c0 32 11 80       	mov    %eax,0x801132c0
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
8010398b:	0f b7 96 04 00 00 80 	movzwl -0x7ffffffc(%esi),%edx
80103992:	8d 86 2c 00 00 80    	lea    -0x7fffffd4(%esi),%eax
  ismp = 1;
80103998:	be 01 00 00 00       	mov    $0x1,%esi
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
8010399d:	03 55 e4             	add    -0x1c(%ebp),%edx
801039a0:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
801039a3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801039a7:	90                   	nop
801039a8:	39 d0                	cmp    %edx,%eax
801039aa:	73 15                	jae    801039c1 <mpinit+0x101>
    switch(*p){
801039ac:	0f b6 08             	movzbl (%eax),%ecx
801039af:	80 f9 02             	cmp    $0x2,%cl
801039b2:	74 4c                	je     80103a00 <mpinit+0x140>
801039b4:	77 3a                	ja     801039f0 <mpinit+0x130>
801039b6:	84 c9                	test   %cl,%cl
801039b8:	74 56                	je     80103a10 <mpinit+0x150>
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
801039ba:	83 c0 08             	add    $0x8,%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801039bd:	39 d0                	cmp    %edx,%eax
801039bf:	72 eb                	jb     801039ac <mpinit+0xec>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
801039c1:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
801039c4:	85 f6                	test   %esi,%esi
801039c6:	0f 84 d9 00 00 00    	je     80103aa5 <mpinit+0x1e5>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
801039cc:	80 7b 0c 00          	cmpb   $0x0,0xc(%ebx)
801039d0:	74 15                	je     801039e7 <mpinit+0x127>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801039d2:	b8 70 00 00 00       	mov    $0x70,%eax
801039d7:	ba 22 00 00 00       	mov    $0x22,%edx
801039dc:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801039dd:	ba 23 00 00 00       	mov    $0x23,%edx
801039e2:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
801039e3:	83 c8 01             	or     $0x1,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801039e6:	ee                   	out    %al,(%dx)
  }
}
801039e7:	8d 65 f4             	lea    -0xc(%ebp),%esp
801039ea:	5b                   	pop    %ebx
801039eb:	5e                   	pop    %esi
801039ec:	5f                   	pop    %edi
801039ed:	5d                   	pop    %ebp
801039ee:	c3                   	ret    
801039ef:	90                   	nop
    switch(*p){
801039f0:	83 e9 03             	sub    $0x3,%ecx
801039f3:	80 f9 01             	cmp    $0x1,%cl
801039f6:	76 c2                	jbe    801039ba <mpinit+0xfa>
801039f8:	31 f6                	xor    %esi,%esi
801039fa:	eb ac                	jmp    801039a8 <mpinit+0xe8>
801039fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      ioapicid = ioapic->apicno;
80103a00:	0f b6 48 01          	movzbl 0x1(%eax),%ecx
      p += sizeof(struct mpioapic);
80103a04:	83 c0 08             	add    $0x8,%eax
      ioapicid = ioapic->apicno;
80103a07:	88 0d c0 33 11 80    	mov    %cl,0x801133c0
      continue;
80103a0d:	eb 99                	jmp    801039a8 <mpinit+0xe8>
80103a0f:	90                   	nop
      if(ncpu < NCPU) {
80103a10:	8b 0d c4 33 11 80    	mov    0x801133c4,%ecx
80103a16:	83 f9 07             	cmp    $0x7,%ecx
80103a19:	7f 19                	jg     80103a34 <mpinit+0x174>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80103a1b:	69 f9 b0 00 00 00    	imul   $0xb0,%ecx,%edi
80103a21:	0f b6 58 01          	movzbl 0x1(%eax),%ebx
        ncpu++;
80103a25:	83 c1 01             	add    $0x1,%ecx
80103a28:	89 0d c4 33 11 80    	mov    %ecx,0x801133c4
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80103a2e:	88 9f e0 33 11 80    	mov    %bl,-0x7feecc20(%edi)
      p += sizeof(struct mpproc);
80103a34:	83 c0 14             	add    $0x14,%eax
      continue;
80103a37:	e9 6c ff ff ff       	jmp    801039a8 <mpinit+0xe8>
80103a3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    panic("Expect to run on an SMP");
80103a40:	83 ec 0c             	sub    $0xc,%esp
80103a43:	68 a2 7d 10 80       	push   $0x80107da2
80103a48:	e8 53 c9 ff ff       	call   801003a0 <panic>
80103a4d:	8d 76 00             	lea    0x0(%esi),%esi
{
80103a50:	bb 00 00 0f 80       	mov    $0x800f0000,%ebx
80103a55:	eb 13                	jmp    80103a6a <mpinit+0x1aa>
80103a57:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103a5e:	66 90                	xchg   %ax,%ax
  for(p = addr; p < e; p += sizeof(struct mp))
80103a60:	89 f3                	mov    %esi,%ebx
80103a62:	81 fe 00 00 10 80    	cmp    $0x80100000,%esi
80103a68:	74 d6                	je     80103a40 <mpinit+0x180>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103a6a:	83 ec 04             	sub    $0x4,%esp
80103a6d:	8d 73 10             	lea    0x10(%ebx),%esi
80103a70:	6a 04                	push   $0x4
80103a72:	68 98 7d 10 80       	push   $0x80107d98
80103a77:	53                   	push   %ebx
80103a78:	e8 e3 12 00 00       	call   80104d60 <memcmp>
80103a7d:	83 c4 10             	add    $0x10,%esp
80103a80:	85 c0                	test   %eax,%eax
80103a82:	75 dc                	jne    80103a60 <mpinit+0x1a0>
80103a84:	89 da                	mov    %ebx,%edx
80103a86:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103a8d:	8d 76 00             	lea    0x0(%esi),%esi
    sum += addr[i];
80103a90:	0f b6 0a             	movzbl (%edx),%ecx
  for(i=0; i<len; i++)
80103a93:	83 c2 01             	add    $0x1,%edx
    sum += addr[i];
80103a96:	01 c8                	add    %ecx,%eax
  for(i=0; i<len; i++)
80103a98:	39 d6                	cmp    %edx,%esi
80103a9a:	75 f4                	jne    80103a90 <mpinit+0x1d0>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103a9c:	84 c0                	test   %al,%al
80103a9e:	75 c0                	jne    80103a60 <mpinit+0x1a0>
80103aa0:	e9 6b fe ff ff       	jmp    80103910 <mpinit+0x50>
    panic("Didn't find a suitable machine");
80103aa5:	83 ec 0c             	sub    $0xc,%esp
80103aa8:	68 bc 7d 10 80       	push   $0x80107dbc
80103aad:	e8 ee c8 ff ff       	call   801003a0 <panic>
80103ab2:	66 90                	xchg   %ax,%ax
80103ab4:	66 90                	xchg   %ax,%ax
80103ab6:	66 90                	xchg   %ax,%ax
80103ab8:	66 90                	xchg   %ax,%ax
80103aba:	66 90                	xchg   %ax,%ax
80103abc:	66 90                	xchg   %ax,%ax
80103abe:	66 90                	xchg   %ax,%ax

80103ac0 <picinit>:
80103ac0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103ac5:	ba 21 00 00 00       	mov    $0x21,%edx
80103aca:	ee                   	out    %al,(%dx)
80103acb:	ba a1 00 00 00       	mov    $0xa1,%edx
80103ad0:	ee                   	out    %al,(%dx)
picinit(void)
{
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
80103ad1:	c3                   	ret    
80103ad2:	66 90                	xchg   %ax,%ax
80103ad4:	66 90                	xchg   %ax,%ax
80103ad6:	66 90                	xchg   %ax,%ax
80103ad8:	66 90                	xchg   %ax,%ax
80103ada:	66 90                	xchg   %ax,%ax
80103adc:	66 90                	xchg   %ax,%ax
80103ade:	66 90                	xchg   %ax,%ax

80103ae0 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80103ae0:	55                   	push   %ebp
80103ae1:	89 e5                	mov    %esp,%ebp
80103ae3:	57                   	push   %edi
80103ae4:	56                   	push   %esi
80103ae5:	53                   	push   %ebx
80103ae6:	83 ec 0c             	sub    $0xc,%esp
80103ae9:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103aec:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
80103aef:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80103af5:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
80103afb:	e8 e0 d9 ff ff       	call   801014e0 <filealloc>
80103b00:	89 03                	mov    %eax,(%ebx)
80103b02:	85 c0                	test   %eax,%eax
80103b04:	0f 84 a8 00 00 00    	je     80103bb2 <pipealloc+0xd2>
80103b0a:	e8 d1 d9 ff ff       	call   801014e0 <filealloc>
80103b0f:	89 06                	mov    %eax,(%esi)
80103b11:	85 c0                	test   %eax,%eax
80103b13:	0f 84 87 00 00 00    	je     80103ba0 <pipealloc+0xc0>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80103b19:	e8 12 f2 ff ff       	call   80102d30 <kalloc>
80103b1e:	89 c7                	mov    %eax,%edi
80103b20:	85 c0                	test   %eax,%eax
80103b22:	0f 84 b0 00 00 00    	je     80103bd8 <pipealloc+0xf8>
    goto bad;
  p->readopen = 1;
80103b28:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
80103b2f:	00 00 00 
  p->writeopen = 1;
  p->nwrite = 0;
  p->nread = 0;
  initlock(&p->lock, "pipe");
80103b32:	83 ec 08             	sub    $0x8,%esp
  p->writeopen = 1;
80103b35:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
80103b3c:	00 00 00 
  p->nwrite = 0;
80103b3f:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
80103b46:	00 00 00 
  p->nread = 0;
80103b49:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
80103b50:	00 00 00 
  initlock(&p->lock, "pipe");
80103b53:	68 db 7d 10 80       	push   $0x80107ddb
80103b58:	50                   	push   %eax
80103b59:	e8 22 0f 00 00       	call   80104a80 <initlock>
  (*f0)->type = FD_PIPE;
80103b5e:	8b 03                	mov    (%ebx),%eax
  (*f0)->pipe = p;
  (*f1)->type = FD_PIPE;
  (*f1)->readable = 0;
  (*f1)->writable = 1;
  (*f1)->pipe = p;
  return 0;
80103b60:	83 c4 10             	add    $0x10,%esp
  (*f0)->type = FD_PIPE;
80103b63:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
80103b69:	8b 03                	mov    (%ebx),%eax
80103b6b:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
80103b6f:	8b 03                	mov    (%ebx),%eax
80103b71:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
80103b75:	8b 03                	mov    (%ebx),%eax
80103b77:	89 78 0c             	mov    %edi,0xc(%eax)
  (*f1)->type = FD_PIPE;
80103b7a:	8b 06                	mov    (%esi),%eax
80103b7c:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
80103b82:	8b 06                	mov    (%esi),%eax
80103b84:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
80103b88:	8b 06                	mov    (%esi),%eax
80103b8a:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
80103b8e:	8b 06                	mov    (%esi),%eax
80103b90:	89 78 0c             	mov    %edi,0xc(%eax)
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
80103b93:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80103b96:	31 c0                	xor    %eax,%eax
}
80103b98:	5b                   	pop    %ebx
80103b99:	5e                   	pop    %esi
80103b9a:	5f                   	pop    %edi
80103b9b:	5d                   	pop    %ebp
80103b9c:	c3                   	ret    
80103b9d:	8d 76 00             	lea    0x0(%esi),%esi
  if(*f0)
80103ba0:	8b 03                	mov    (%ebx),%eax
80103ba2:	85 c0                	test   %eax,%eax
80103ba4:	74 1e                	je     80103bc4 <pipealloc+0xe4>
    fileclose(*f0);
80103ba6:	83 ec 0c             	sub    $0xc,%esp
80103ba9:	50                   	push   %eax
80103baa:	e8 f1 d9 ff ff       	call   801015a0 <fileclose>
80103baf:	83 c4 10             	add    $0x10,%esp
  if(*f1)
80103bb2:	8b 06                	mov    (%esi),%eax
80103bb4:	85 c0                	test   %eax,%eax
80103bb6:	74 0c                	je     80103bc4 <pipealloc+0xe4>
    fileclose(*f1);
80103bb8:	83 ec 0c             	sub    $0xc,%esp
80103bbb:	50                   	push   %eax
80103bbc:	e8 df d9 ff ff       	call   801015a0 <fileclose>
80103bc1:	83 c4 10             	add    $0x10,%esp
}
80103bc4:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
80103bc7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80103bcc:	5b                   	pop    %ebx
80103bcd:	5e                   	pop    %esi
80103bce:	5f                   	pop    %edi
80103bcf:	5d                   	pop    %ebp
80103bd0:	c3                   	ret    
80103bd1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(*f0)
80103bd8:	8b 03                	mov    (%ebx),%eax
80103bda:	85 c0                	test   %eax,%eax
80103bdc:	75 c8                	jne    80103ba6 <pipealloc+0xc6>
80103bde:	eb d2                	jmp    80103bb2 <pipealloc+0xd2>

80103be0 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
80103be0:	55                   	push   %ebp
80103be1:	89 e5                	mov    %esp,%ebp
80103be3:	56                   	push   %esi
80103be4:	53                   	push   %ebx
80103be5:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103be8:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
80103beb:	83 ec 0c             	sub    $0xc,%esp
80103bee:	53                   	push   %ebx
80103bef:	e8 5c 10 00 00       	call   80104c50 <acquire>
  if(writable){
80103bf4:	83 c4 10             	add    $0x10,%esp
80103bf7:	85 f6                	test   %esi,%esi
80103bf9:	74 65                	je     80103c60 <pipeclose+0x80>
    p->writeopen = 0;
    wakeup(&p->nread);
80103bfb:	83 ec 0c             	sub    $0xc,%esp
80103bfe:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
    p->writeopen = 0;
80103c04:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
80103c0b:	00 00 00 
    wakeup(&p->nread);
80103c0e:	50                   	push   %eax
80103c0f:	e8 9c 0b 00 00       	call   801047b0 <wakeup>
80103c14:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
80103c17:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
80103c1d:	85 d2                	test   %edx,%edx
80103c1f:	75 0a                	jne    80103c2b <pipeclose+0x4b>
80103c21:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
80103c27:	85 c0                	test   %eax,%eax
80103c29:	74 15                	je     80103c40 <pipeclose+0x60>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
80103c2b:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80103c2e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103c31:	5b                   	pop    %ebx
80103c32:	5e                   	pop    %esi
80103c33:	5d                   	pop    %ebp
    release(&p->lock);
80103c34:	e9 b7 0f 00 00       	jmp    80104bf0 <release>
80103c39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    release(&p->lock);
80103c40:	83 ec 0c             	sub    $0xc,%esp
80103c43:	53                   	push   %ebx
80103c44:	e8 a7 0f 00 00       	call   80104bf0 <release>
    kfree((char*)p);
80103c49:	89 5d 08             	mov    %ebx,0x8(%ebp)
80103c4c:	83 c4 10             	add    $0x10,%esp
}
80103c4f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103c52:	5b                   	pop    %ebx
80103c53:	5e                   	pop    %esi
80103c54:	5d                   	pop    %ebp
    kfree((char*)p);
80103c55:	e9 16 ef ff ff       	jmp    80102b70 <kfree>
80103c5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    wakeup(&p->nwrite);
80103c60:	83 ec 0c             	sub    $0xc,%esp
80103c63:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
    p->readopen = 0;
80103c69:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
80103c70:	00 00 00 
    wakeup(&p->nwrite);
80103c73:	50                   	push   %eax
80103c74:	e8 37 0b 00 00       	call   801047b0 <wakeup>
80103c79:	83 c4 10             	add    $0x10,%esp
80103c7c:	eb 99                	jmp    80103c17 <pipeclose+0x37>
80103c7e:	66 90                	xchg   %ax,%ax

80103c80 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
80103c80:	55                   	push   %ebp
80103c81:	89 e5                	mov    %esp,%ebp
80103c83:	57                   	push   %edi
80103c84:	56                   	push   %esi
80103c85:	53                   	push   %ebx
80103c86:	83 ec 28             	sub    $0x28,%esp
80103c89:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  acquire(&p->lock);
80103c8c:	53                   	push   %ebx
80103c8d:	e8 be 0f 00 00       	call   80104c50 <acquire>
  for(i = 0; i < n; i++){
80103c92:	8b 45 10             	mov    0x10(%ebp),%eax
80103c95:	83 c4 10             	add    $0x10,%esp
80103c98:	85 c0                	test   %eax,%eax
80103c9a:	0f 8e c0 00 00 00    	jle    80103d60 <pipewrite+0xe0>
80103ca0:	8b 45 0c             	mov    0xc(%ebp),%eax
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103ca3:	8b 8b 38 02 00 00    	mov    0x238(%ebx),%ecx
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
80103ca9:	8d bb 34 02 00 00    	lea    0x234(%ebx),%edi
80103caf:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103cb2:	03 45 10             	add    0x10(%ebp),%eax
80103cb5:	89 45 e0             	mov    %eax,-0x20(%ebp)
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103cb8:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103cbe:	8d b3 38 02 00 00    	lea    0x238(%ebx),%esi
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103cc4:	89 ca                	mov    %ecx,%edx
80103cc6:	05 00 02 00 00       	add    $0x200,%eax
80103ccb:	39 c1                	cmp    %eax,%ecx
80103ccd:	74 3f                	je     80103d0e <pipewrite+0x8e>
80103ccf:	eb 67                	jmp    80103d38 <pipewrite+0xb8>
80103cd1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(p->readopen == 0 || myproc()->killed){
80103cd8:	e8 43 03 00 00       	call   80104020 <myproc>
80103cdd:	8b 48 24             	mov    0x24(%eax),%ecx
80103ce0:	85 c9                	test   %ecx,%ecx
80103ce2:	75 34                	jne    80103d18 <pipewrite+0x98>
      wakeup(&p->nread);
80103ce4:	83 ec 0c             	sub    $0xc,%esp
80103ce7:	57                   	push   %edi
80103ce8:	e8 c3 0a 00 00       	call   801047b0 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103ced:	58                   	pop    %eax
80103cee:	5a                   	pop    %edx
80103cef:	53                   	push   %ebx
80103cf0:	56                   	push   %esi
80103cf1:	e8 fa 09 00 00       	call   801046f0 <sleep>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103cf6:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
80103cfc:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
80103d02:	83 c4 10             	add    $0x10,%esp
80103d05:	05 00 02 00 00       	add    $0x200,%eax
80103d0a:	39 c2                	cmp    %eax,%edx
80103d0c:	75 2a                	jne    80103d38 <pipewrite+0xb8>
      if(p->readopen == 0 || myproc()->killed){
80103d0e:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
80103d14:	85 c0                	test   %eax,%eax
80103d16:	75 c0                	jne    80103cd8 <pipewrite+0x58>
        release(&p->lock);
80103d18:	83 ec 0c             	sub    $0xc,%esp
80103d1b:	53                   	push   %ebx
80103d1c:	e8 cf 0e 00 00       	call   80104bf0 <release>
        return -1;
80103d21:	83 c4 10             	add    $0x10,%esp
80103d24:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
80103d29:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103d2c:	5b                   	pop    %ebx
80103d2d:	5e                   	pop    %esi
80103d2e:	5f                   	pop    %edi
80103d2f:	5d                   	pop    %ebp
80103d30:	c3                   	ret    
80103d31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80103d38:	8b 75 e4             	mov    -0x1c(%ebp),%esi
80103d3b:	8d 4a 01             	lea    0x1(%edx),%ecx
80103d3e:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
80103d44:	89 8b 38 02 00 00    	mov    %ecx,0x238(%ebx)
80103d4a:	0f b6 06             	movzbl (%esi),%eax
  for(i = 0; i < n; i++){
80103d4d:	83 c6 01             	add    $0x1,%esi
80103d50:	89 75 e4             	mov    %esi,-0x1c(%ebp)
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80103d53:	88 44 13 34          	mov    %al,0x34(%ebx,%edx,1)
  for(i = 0; i < n; i++){
80103d57:	3b 75 e0             	cmp    -0x20(%ebp),%esi
80103d5a:	0f 85 58 ff ff ff    	jne    80103cb8 <pipewrite+0x38>
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
80103d60:	83 ec 0c             	sub    $0xc,%esp
80103d63:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80103d69:	50                   	push   %eax
80103d6a:	e8 41 0a 00 00       	call   801047b0 <wakeup>
  release(&p->lock);
80103d6f:	89 1c 24             	mov    %ebx,(%esp)
80103d72:	e8 79 0e 00 00       	call   80104bf0 <release>
  return n;
80103d77:	8b 45 10             	mov    0x10(%ebp),%eax
80103d7a:	83 c4 10             	add    $0x10,%esp
80103d7d:	eb aa                	jmp    80103d29 <pipewrite+0xa9>
80103d7f:	90                   	nop

80103d80 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
80103d80:	55                   	push   %ebp
80103d81:	89 e5                	mov    %esp,%ebp
80103d83:	57                   	push   %edi
80103d84:	56                   	push   %esi
80103d85:	53                   	push   %ebx
80103d86:	83 ec 18             	sub    $0x18,%esp
80103d89:	8b 75 08             	mov    0x8(%ebp),%esi
80103d8c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
80103d8f:	56                   	push   %esi
80103d90:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
80103d96:	e8 b5 0e 00 00       	call   80104c50 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80103d9b:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
80103da1:	83 c4 10             	add    $0x10,%esp
80103da4:	39 86 38 02 00 00    	cmp    %eax,0x238(%esi)
80103daa:	74 2f                	je     80103ddb <piperead+0x5b>
80103dac:	eb 37                	jmp    80103de5 <piperead+0x65>
80103dae:	66 90                	xchg   %ax,%ax
    if(myproc()->killed){
80103db0:	e8 6b 02 00 00       	call   80104020 <myproc>
80103db5:	8b 48 24             	mov    0x24(%eax),%ecx
80103db8:	85 c9                	test   %ecx,%ecx
80103dba:	0f 85 80 00 00 00    	jne    80103e40 <piperead+0xc0>
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
80103dc0:	83 ec 08             	sub    $0x8,%esp
80103dc3:	56                   	push   %esi
80103dc4:	53                   	push   %ebx
80103dc5:	e8 26 09 00 00       	call   801046f0 <sleep>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80103dca:	8b 86 38 02 00 00    	mov    0x238(%esi),%eax
80103dd0:	83 c4 10             	add    $0x10,%esp
80103dd3:	39 86 34 02 00 00    	cmp    %eax,0x234(%esi)
80103dd9:	75 0a                	jne    80103de5 <piperead+0x65>
80103ddb:	8b 86 40 02 00 00    	mov    0x240(%esi),%eax
80103de1:	85 c0                	test   %eax,%eax
80103de3:	75 cb                	jne    80103db0 <piperead+0x30>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103de5:	8b 55 10             	mov    0x10(%ebp),%edx
80103de8:	31 db                	xor    %ebx,%ebx
80103dea:	85 d2                	test   %edx,%edx
80103dec:	7f 20                	jg     80103e0e <piperead+0x8e>
80103dee:	eb 2c                	jmp    80103e1c <piperead+0x9c>
    if(p->nread == p->nwrite)
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
80103df0:	8d 48 01             	lea    0x1(%eax),%ecx
80103df3:	25 ff 01 00 00       	and    $0x1ff,%eax
80103df8:	89 8e 34 02 00 00    	mov    %ecx,0x234(%esi)
80103dfe:	0f b6 44 06 34       	movzbl 0x34(%esi,%eax,1),%eax
80103e03:	88 04 1f             	mov    %al,(%edi,%ebx,1)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103e06:	83 c3 01             	add    $0x1,%ebx
80103e09:	39 5d 10             	cmp    %ebx,0x10(%ebp)
80103e0c:	74 0e                	je     80103e1c <piperead+0x9c>
    if(p->nread == p->nwrite)
80103e0e:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
80103e14:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
80103e1a:	75 d4                	jne    80103df0 <piperead+0x70>
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
80103e1c:	83 ec 0c             	sub    $0xc,%esp
80103e1f:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
80103e25:	50                   	push   %eax
80103e26:	e8 85 09 00 00       	call   801047b0 <wakeup>
  release(&p->lock);
80103e2b:	89 34 24             	mov    %esi,(%esp)
80103e2e:	e8 bd 0d 00 00       	call   80104bf0 <release>
  return i;
80103e33:	83 c4 10             	add    $0x10,%esp
}
80103e36:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103e39:	89 d8                	mov    %ebx,%eax
80103e3b:	5b                   	pop    %ebx
80103e3c:	5e                   	pop    %esi
80103e3d:	5f                   	pop    %edi
80103e3e:	5d                   	pop    %ebp
80103e3f:	c3                   	ret    
      release(&p->lock);
80103e40:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80103e43:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
      release(&p->lock);
80103e48:	56                   	push   %esi
80103e49:	e8 a2 0d 00 00       	call   80104bf0 <release>
      return -1;
80103e4e:	83 c4 10             	add    $0x10,%esp
}
80103e51:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103e54:	89 d8                	mov    %ebx,%eax
80103e56:	5b                   	pop    %ebx
80103e57:	5e                   	pop    %esi
80103e58:	5f                   	pop    %edi
80103e59:	5d                   	pop    %ebp
80103e5a:	c3                   	ret    
80103e5b:	66 90                	xchg   %ax,%ax
80103e5d:	66 90                	xchg   %ax,%ax
80103e5f:	90                   	nop

80103e60 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
80103e60:	55                   	push   %ebp
80103e61:	89 e5                	mov    %esp,%ebp
80103e63:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103e64:	bb 94 39 11 80       	mov    $0x80113994,%ebx
{
80103e69:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);
80103e6c:	68 60 39 11 80       	push   $0x80113960
80103e71:	e8 da 0d 00 00       	call   80104c50 <acquire>
80103e76:	83 c4 10             	add    $0x10,%esp
80103e79:	eb 10                	jmp    80103e8b <allocproc+0x2b>
80103e7b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103e7f:	90                   	nop
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103e80:	83 c3 7c             	add    $0x7c,%ebx
80103e83:	81 fb 94 58 11 80    	cmp    $0x80115894,%ebx
80103e89:	74 75                	je     80103f00 <allocproc+0xa0>
    if(p->state == UNUSED)
80103e8b:	8b 43 0c             	mov    0xc(%ebx),%eax
80103e8e:	85 c0                	test   %eax,%eax
80103e90:	75 ee                	jne    80103e80 <allocproc+0x20>
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
80103e92:	a1 04 b0 10 80       	mov    0x8010b004,%eax

  release(&ptable.lock);
80103e97:	83 ec 0c             	sub    $0xc,%esp
  p->state = EMBRYO;
80103e9a:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->pid = nextpid++;
80103ea1:	89 43 10             	mov    %eax,0x10(%ebx)
80103ea4:	8d 50 01             	lea    0x1(%eax),%edx
  release(&ptable.lock);
80103ea7:	68 60 39 11 80       	push   $0x80113960
  p->pid = nextpid++;
80103eac:	89 15 04 b0 10 80    	mov    %edx,0x8010b004
  release(&ptable.lock);
80103eb2:	e8 39 0d 00 00       	call   80104bf0 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
80103eb7:	e8 74 ee ff ff       	call   80102d30 <kalloc>
80103ebc:	83 c4 10             	add    $0x10,%esp
80103ebf:	89 43 08             	mov    %eax,0x8(%ebx)
80103ec2:	85 c0                	test   %eax,%eax
80103ec4:	74 53                	je     80103f19 <allocproc+0xb9>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
80103ec6:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
80103ecc:	83 ec 04             	sub    $0x4,%esp
  sp -= sizeof *p->context;
80103ecf:	05 9c 0f 00 00       	add    $0xf9c,%eax
  sp -= sizeof *p->tf;
80103ed4:	89 53 18             	mov    %edx,0x18(%ebx)
  *(uint*)sp = (uint)trapret;
80103ed7:	c7 40 14 02 5f 10 80 	movl   $0x80105f02,0x14(%eax)
  p->context = (struct context*)sp;
80103ede:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
80103ee1:	6a 14                	push   $0x14
80103ee3:	6a 00                	push   $0x0
80103ee5:	50                   	push   %eax
80103ee6:	e8 25 0e 00 00       	call   80104d10 <memset>
  p->context->eip = (uint)forkret;
80103eeb:	8b 43 1c             	mov    0x1c(%ebx),%eax

  return p;
80103eee:	83 c4 10             	add    $0x10,%esp
  p->context->eip = (uint)forkret;
80103ef1:	c7 40 10 30 3f 10 80 	movl   $0x80103f30,0x10(%eax)
}
80103ef8:	89 d8                	mov    %ebx,%eax
80103efa:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103efd:	c9                   	leave  
80103efe:	c3                   	ret    
80103eff:	90                   	nop
  release(&ptable.lock);
80103f00:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80103f03:	31 db                	xor    %ebx,%ebx
  release(&ptable.lock);
80103f05:	68 60 39 11 80       	push   $0x80113960
80103f0a:	e8 e1 0c 00 00       	call   80104bf0 <release>
}
80103f0f:	89 d8                	mov    %ebx,%eax
  return 0;
80103f11:	83 c4 10             	add    $0x10,%esp
}
80103f14:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103f17:	c9                   	leave  
80103f18:	c3                   	ret    
    p->state = UNUSED;
80103f19:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return 0;
80103f20:	31 db                	xor    %ebx,%ebx
}
80103f22:	89 d8                	mov    %ebx,%eax
80103f24:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103f27:	c9                   	leave  
80103f28:	c3                   	ret    
80103f29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103f30 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
80103f30:	55                   	push   %ebp
80103f31:	89 e5                	mov    %esp,%ebp
80103f33:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
80103f36:	68 60 39 11 80       	push   $0x80113960
80103f3b:	e8 b0 0c 00 00       	call   80104bf0 <release>

  if (first) {
80103f40:	a1 00 b0 10 80       	mov    0x8010b000,%eax
80103f45:	83 c4 10             	add    $0x10,%esp
80103f48:	85 c0                	test   %eax,%eax
80103f4a:	75 04                	jne    80103f50 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
80103f4c:	c9                   	leave  
80103f4d:	c3                   	ret    
80103f4e:	66 90                	xchg   %ax,%ax
    first = 0;
80103f50:	c7 05 00 b0 10 80 00 	movl   $0x0,0x8010b000
80103f57:	00 00 00 
    iinit(ROOTDEV);
80103f5a:	83 ec 0c             	sub    $0xc,%esp
80103f5d:	6a 01                	push   $0x1
80103f5f:	e8 ac dc ff ff       	call   80101c10 <iinit>
    initlog(ROOTDEV);
80103f64:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80103f6b:	e8 00 f4 ff ff       	call   80103370 <initlog>
}
80103f70:	83 c4 10             	add    $0x10,%esp
80103f73:	c9                   	leave  
80103f74:	c3                   	ret    
80103f75:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103f7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103f80 <pinit>:
{
80103f80:	55                   	push   %ebp
80103f81:	89 e5                	mov    %esp,%ebp
80103f83:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
80103f86:	68 e0 7d 10 80       	push   $0x80107de0
80103f8b:	68 60 39 11 80       	push   $0x80113960
80103f90:	e8 eb 0a 00 00       	call   80104a80 <initlock>
}
80103f95:	83 c4 10             	add    $0x10,%esp
80103f98:	c9                   	leave  
80103f99:	c3                   	ret    
80103f9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103fa0 <mycpu>:
{
80103fa0:	55                   	push   %ebp
80103fa1:	89 e5                	mov    %esp,%ebp
80103fa3:	56                   	push   %esi
80103fa4:	53                   	push   %ebx
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103fa5:	9c                   	pushf  
80103fa6:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103fa7:	f6 c4 02             	test   $0x2,%ah
80103faa:	75 46                	jne    80103ff2 <mycpu+0x52>
  apicid = lapicid();
80103fac:	e8 ef ef ff ff       	call   80102fa0 <lapicid>
  for (i = 0; i < ncpu; ++i) {
80103fb1:	8b 35 c4 33 11 80    	mov    0x801133c4,%esi
80103fb7:	85 f6                	test   %esi,%esi
80103fb9:	7e 2a                	jle    80103fe5 <mycpu+0x45>
80103fbb:	31 d2                	xor    %edx,%edx
80103fbd:	eb 08                	jmp    80103fc7 <mycpu+0x27>
80103fbf:	90                   	nop
80103fc0:	83 c2 01             	add    $0x1,%edx
80103fc3:	39 f2                	cmp    %esi,%edx
80103fc5:	74 1e                	je     80103fe5 <mycpu+0x45>
    if (cpus[i].apicid == apicid)
80103fc7:	69 ca b0 00 00 00    	imul   $0xb0,%edx,%ecx
80103fcd:	0f b6 99 e0 33 11 80 	movzbl -0x7feecc20(%ecx),%ebx
80103fd4:	39 c3                	cmp    %eax,%ebx
80103fd6:	75 e8                	jne    80103fc0 <mycpu+0x20>
}
80103fd8:	8d 65 f8             	lea    -0x8(%ebp),%esp
      return &cpus[i];
80103fdb:	8d 81 e0 33 11 80    	lea    -0x7feecc20(%ecx),%eax
}
80103fe1:	5b                   	pop    %ebx
80103fe2:	5e                   	pop    %esi
80103fe3:	5d                   	pop    %ebp
80103fe4:	c3                   	ret    
  panic("unknown apicid\n");
80103fe5:	83 ec 0c             	sub    $0xc,%esp
80103fe8:	68 e7 7d 10 80       	push   $0x80107de7
80103fed:	e8 ae c3 ff ff       	call   801003a0 <panic>
    panic("mycpu called with interrupts enabled\n");
80103ff2:	83 ec 0c             	sub    $0xc,%esp
80103ff5:	68 c4 7e 10 80       	push   $0x80107ec4
80103ffa:	e8 a1 c3 ff ff       	call   801003a0 <panic>
80103fff:	90                   	nop

80104000 <cpuid>:
cpuid() {
80104000:	55                   	push   %ebp
80104001:	89 e5                	mov    %esp,%ebp
80104003:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
80104006:	e8 95 ff ff ff       	call   80103fa0 <mycpu>
}
8010400b:	c9                   	leave  
  return mycpu()-cpus;
8010400c:	2d e0 33 11 80       	sub    $0x801133e0,%eax
80104011:	c1 f8 04             	sar    $0x4,%eax
80104014:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
8010401a:	c3                   	ret    
8010401b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010401f:	90                   	nop

80104020 <myproc>:
myproc(void) {
80104020:	55                   	push   %ebp
80104021:	89 e5                	mov    %esp,%ebp
80104023:	53                   	push   %ebx
80104024:	83 ec 04             	sub    $0x4,%esp
  pushcli();
80104027:	e8 d4 0a 00 00       	call   80104b00 <pushcli>
  c = mycpu();
8010402c:	e8 6f ff ff ff       	call   80103fa0 <mycpu>
  p = c->proc;
80104031:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104037:	e8 14 0b 00 00       	call   80104b50 <popcli>
}
8010403c:	89 d8                	mov    %ebx,%eax
8010403e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104041:	c9                   	leave  
80104042:	c3                   	ret    
80104043:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010404a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104050 <userinit>:
{
80104050:	55                   	push   %ebp
80104051:	89 e5                	mov    %esp,%ebp
80104053:	53                   	push   %ebx
80104054:	83 ec 04             	sub    $0x4,%esp
  p = allocproc();
80104057:	e8 04 fe ff ff       	call   80103e60 <allocproc>
8010405c:	89 c3                	mov    %eax,%ebx
  initproc = p;
8010405e:	a3 94 58 11 80       	mov    %eax,0x80115894
  if((p->pgdir = setupkvm()) == 0)
80104063:	e8 88 34 00 00       	call   801074f0 <setupkvm>
80104068:	89 43 04             	mov    %eax,0x4(%ebx)
8010406b:	85 c0                	test   %eax,%eax
8010406d:	0f 84 bd 00 00 00    	je     80104130 <userinit+0xe0>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80104073:	83 ec 04             	sub    $0x4,%esp
80104076:	68 2c 00 00 00       	push   $0x2c
8010407b:	68 60 b4 10 80       	push   $0x8010b460
80104080:	50                   	push   %eax
80104081:	e8 1a 31 00 00       	call   801071a0 <inituvm>
  memset(p->tf, 0, sizeof(*p->tf));
80104086:	83 c4 0c             	add    $0xc,%esp
  p->sz = PGSIZE;
80104089:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
8010408f:	6a 4c                	push   $0x4c
80104091:	6a 00                	push   $0x0
80104093:	ff 73 18             	push   0x18(%ebx)
80104096:	e8 75 0c 00 00       	call   80104d10 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
8010409b:	8b 43 18             	mov    0x18(%ebx),%eax
8010409e:	ba 1b 00 00 00       	mov    $0x1b,%edx
  safestrcpy(p->name, "initcode", sizeof(p->name));
801040a3:	83 c4 0c             	add    $0xc,%esp
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
801040a6:	b9 23 00 00 00       	mov    $0x23,%ecx
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
801040ab:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
801040af:	8b 43 18             	mov    0x18(%ebx),%eax
801040b2:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
801040b6:	8b 43 18             	mov    0x18(%ebx),%eax
801040b9:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
801040bd:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
801040c1:	8b 43 18             	mov    0x18(%ebx),%eax
801040c4:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
801040c8:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
801040cc:	8b 43 18             	mov    0x18(%ebx),%eax
801040cf:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
801040d6:	8b 43 18             	mov    0x18(%ebx),%eax
801040d9:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
801040e0:	8b 43 18             	mov    0x18(%ebx),%eax
801040e3:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  safestrcpy(p->name, "initcode", sizeof(p->name));
801040ea:	8d 43 6c             	lea    0x6c(%ebx),%eax
801040ed:	6a 10                	push   $0x10
801040ef:	68 10 7e 10 80       	push   $0x80107e10
801040f4:	50                   	push   %eax
801040f5:	e8 d6 0d 00 00       	call   80104ed0 <safestrcpy>
  p->cwd = namei("/");
801040fa:	c7 04 24 19 7e 10 80 	movl   $0x80107e19,(%esp)
80104101:	e8 4a e6 ff ff       	call   80102750 <namei>
80104106:	89 43 68             	mov    %eax,0x68(%ebx)
  acquire(&ptable.lock);
80104109:	c7 04 24 60 39 11 80 	movl   $0x80113960,(%esp)
80104110:	e8 3b 0b 00 00       	call   80104c50 <acquire>
  p->state = RUNNABLE;
80104115:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
8010411c:	c7 04 24 60 39 11 80 	movl   $0x80113960,(%esp)
80104123:	e8 c8 0a 00 00       	call   80104bf0 <release>
}
80104128:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010412b:	83 c4 10             	add    $0x10,%esp
8010412e:	c9                   	leave  
8010412f:	c3                   	ret    
    panic("userinit: out of memory?");
80104130:	83 ec 0c             	sub    $0xc,%esp
80104133:	68 f7 7d 10 80       	push   $0x80107df7
80104138:	e8 63 c2 ff ff       	call   801003a0 <panic>
8010413d:	8d 76 00             	lea    0x0(%esi),%esi

80104140 <growproc>:
{
80104140:	55                   	push   %ebp
80104141:	89 e5                	mov    %esp,%ebp
80104143:	56                   	push   %esi
80104144:	53                   	push   %ebx
80104145:	8b 75 08             	mov    0x8(%ebp),%esi
  pushcli();
80104148:	e8 b3 09 00 00       	call   80104b00 <pushcli>
  c = mycpu();
8010414d:	e8 4e fe ff ff       	call   80103fa0 <mycpu>
  p = c->proc;
80104152:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104158:	e8 f3 09 00 00       	call   80104b50 <popcli>
  sz = curproc->sz;
8010415d:	8b 03                	mov    (%ebx),%eax
  if(n > 0){
8010415f:	85 f6                	test   %esi,%esi
80104161:	7f 1d                	jg     80104180 <growproc+0x40>
  } else if(n < 0){
80104163:	75 3b                	jne    801041a0 <growproc+0x60>
  switchuvm(curproc);
80104165:	83 ec 0c             	sub    $0xc,%esp
  curproc->sz = sz;
80104168:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
8010416a:	53                   	push   %ebx
8010416b:	e8 20 2f 00 00       	call   80107090 <switchuvm>
  return 0;
80104170:	83 c4 10             	add    $0x10,%esp
80104173:	31 c0                	xor    %eax,%eax
}
80104175:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104178:	5b                   	pop    %ebx
80104179:	5e                   	pop    %esi
8010417a:	5d                   	pop    %ebp
8010417b:	c3                   	ret    
8010417c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
80104180:	83 ec 04             	sub    $0x4,%esp
80104183:	01 c6                	add    %eax,%esi
80104185:	56                   	push   %esi
80104186:	50                   	push   %eax
80104187:	ff 73 04             	push   0x4(%ebx)
8010418a:	e8 81 31 00 00       	call   80107310 <allocuvm>
8010418f:	83 c4 10             	add    $0x10,%esp
80104192:	85 c0                	test   %eax,%eax
80104194:	75 cf                	jne    80104165 <growproc+0x25>
      return -1;
80104196:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010419b:	eb d8                	jmp    80104175 <growproc+0x35>
8010419d:	8d 76 00             	lea    0x0(%esi),%esi
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
801041a0:	83 ec 04             	sub    $0x4,%esp
801041a3:	01 c6                	add    %eax,%esi
801041a5:	56                   	push   %esi
801041a6:	50                   	push   %eax
801041a7:	ff 73 04             	push   0x4(%ebx)
801041aa:	e8 91 32 00 00       	call   80107440 <deallocuvm>
801041af:	83 c4 10             	add    $0x10,%esp
801041b2:	85 c0                	test   %eax,%eax
801041b4:	75 af                	jne    80104165 <growproc+0x25>
801041b6:	eb de                	jmp    80104196 <growproc+0x56>
801041b8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801041bf:	90                   	nop

801041c0 <fork>:
{
801041c0:	55                   	push   %ebp
801041c1:	89 e5                	mov    %esp,%ebp
801041c3:	57                   	push   %edi
801041c4:	56                   	push   %esi
801041c5:	53                   	push   %ebx
801041c6:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
801041c9:	e8 32 09 00 00       	call   80104b00 <pushcli>
  c = mycpu();
801041ce:	e8 cd fd ff ff       	call   80103fa0 <mycpu>
  p = c->proc;
801041d3:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801041d9:	e8 72 09 00 00       	call   80104b50 <popcli>
  if((np = allocproc()) == 0){
801041de:	e8 7d fc ff ff       	call   80103e60 <allocproc>
801041e3:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801041e6:	85 c0                	test   %eax,%eax
801041e8:	0f 84 b7 00 00 00    	je     801042a5 <fork+0xe5>
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
801041ee:	83 ec 08             	sub    $0x8,%esp
801041f1:	ff 33                	push   (%ebx)
801041f3:	89 c7                	mov    %eax,%edi
801041f5:	ff 73 04             	push   0x4(%ebx)
801041f8:	e8 e3 33 00 00       	call   801075e0 <copyuvm>
801041fd:	83 c4 10             	add    $0x10,%esp
80104200:	89 47 04             	mov    %eax,0x4(%edi)
80104203:	85 c0                	test   %eax,%eax
80104205:	0f 84 a1 00 00 00    	je     801042ac <fork+0xec>
  np->sz = curproc->sz;
8010420b:	8b 03                	mov    (%ebx),%eax
8010420d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80104210:	89 01                	mov    %eax,(%ecx)
  *np->tf = *curproc->tf;
80104212:	8b 79 18             	mov    0x18(%ecx),%edi
  np->parent = curproc;
80104215:	89 c8                	mov    %ecx,%eax
80104217:	89 59 14             	mov    %ebx,0x14(%ecx)
  *np->tf = *curproc->tf;
8010421a:	b9 13 00 00 00       	mov    $0x13,%ecx
8010421f:	8b 73 18             	mov    0x18(%ebx),%esi
80104222:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  for(i = 0; i < NOFILE; i++)
80104224:	31 f6                	xor    %esi,%esi
  np->tf->eax = 0;
80104226:	8b 40 18             	mov    0x18(%eax),%eax
80104229:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
    if(curproc->ofile[i])
80104230:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
80104234:	85 c0                	test   %eax,%eax
80104236:	74 13                	je     8010424b <fork+0x8b>
      np->ofile[i] = filedup(curproc->ofile[i]);
80104238:	83 ec 0c             	sub    $0xc,%esp
8010423b:	50                   	push   %eax
8010423c:	e8 0f d3 ff ff       	call   80101550 <filedup>
80104241:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80104244:	83 c4 10             	add    $0x10,%esp
80104247:	89 44 b2 28          	mov    %eax,0x28(%edx,%esi,4)
  for(i = 0; i < NOFILE; i++)
8010424b:	83 c6 01             	add    $0x1,%esi
8010424e:	83 fe 10             	cmp    $0x10,%esi
80104251:	75 dd                	jne    80104230 <fork+0x70>
  np->cwd = idup(curproc->cwd);
80104253:	83 ec 0c             	sub    $0xc,%esp
80104256:	ff 73 68             	push   0x68(%ebx)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80104259:	83 c3 6c             	add    $0x6c,%ebx
  np->cwd = idup(curproc->cwd);
8010425c:	e8 9f db ff ff       	call   80101e00 <idup>
80104261:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80104264:	83 c4 0c             	add    $0xc,%esp
  np->cwd = idup(curproc->cwd);
80104267:	89 47 68             	mov    %eax,0x68(%edi)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
8010426a:	8d 47 6c             	lea    0x6c(%edi),%eax
8010426d:	6a 10                	push   $0x10
8010426f:	53                   	push   %ebx
80104270:	50                   	push   %eax
80104271:	e8 5a 0c 00 00       	call   80104ed0 <safestrcpy>
  pid = np->pid;
80104276:	8b 5f 10             	mov    0x10(%edi),%ebx
  acquire(&ptable.lock);
80104279:	c7 04 24 60 39 11 80 	movl   $0x80113960,(%esp)
80104280:	e8 cb 09 00 00       	call   80104c50 <acquire>
  np->state = RUNNABLE;
80104285:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)
  release(&ptable.lock);
8010428c:	c7 04 24 60 39 11 80 	movl   $0x80113960,(%esp)
80104293:	e8 58 09 00 00       	call   80104bf0 <release>
  return pid;
80104298:	83 c4 10             	add    $0x10,%esp
}
8010429b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010429e:	89 d8                	mov    %ebx,%eax
801042a0:	5b                   	pop    %ebx
801042a1:	5e                   	pop    %esi
801042a2:	5f                   	pop    %edi
801042a3:	5d                   	pop    %ebp
801042a4:	c3                   	ret    
    return -1;
801042a5:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801042aa:	eb ef                	jmp    8010429b <fork+0xdb>
    kfree(np->kstack);
801042ac:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
801042af:	83 ec 0c             	sub    $0xc,%esp
801042b2:	ff 73 08             	push   0x8(%ebx)
801042b5:	e8 b6 e8 ff ff       	call   80102b70 <kfree>
    np->kstack = 0;
801042ba:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
    return -1;
801042c1:	83 c4 10             	add    $0x10,%esp
    np->state = UNUSED;
801042c4:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return -1;
801042cb:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801042d0:	eb c9                	jmp    8010429b <fork+0xdb>
801042d2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801042d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801042e0 <scheduler>:
{
801042e0:	55                   	push   %ebp
801042e1:	89 e5                	mov    %esp,%ebp
801042e3:	57                   	push   %edi
801042e4:	56                   	push   %esi
801042e5:	53                   	push   %ebx
801042e6:	83 ec 0c             	sub    $0xc,%esp
  struct cpu *c = mycpu();
801042e9:	e8 b2 fc ff ff       	call   80103fa0 <mycpu>
  c->proc = 0;
801042ee:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
801042f5:	00 00 00 
  struct cpu *c = mycpu();
801042f8:	89 c6                	mov    %eax,%esi
  c->proc = 0;
801042fa:	8d 78 04             	lea    0x4(%eax),%edi
801042fd:	8d 76 00             	lea    0x0(%esi),%esi
  asm volatile("sti");
80104300:	fb                   	sti    
    acquire(&ptable.lock);
80104301:	83 ec 0c             	sub    $0xc,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104304:	bb 94 39 11 80       	mov    $0x80113994,%ebx
    acquire(&ptable.lock);
80104309:	68 60 39 11 80       	push   $0x80113960
8010430e:	e8 3d 09 00 00       	call   80104c50 <acquire>
80104313:	83 c4 10             	add    $0x10,%esp
80104316:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010431d:	8d 76 00             	lea    0x0(%esi),%esi
      if(p->state != RUNNABLE)
80104320:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
80104324:	75 33                	jne    80104359 <scheduler+0x79>
      switchuvm(p);
80104326:	83 ec 0c             	sub    $0xc,%esp
      c->proc = p;
80104329:	89 9e ac 00 00 00    	mov    %ebx,0xac(%esi)
      switchuvm(p);
8010432f:	53                   	push   %ebx
80104330:	e8 5b 2d 00 00       	call   80107090 <switchuvm>
      swtch(&(c->scheduler), p->context);
80104335:	58                   	pop    %eax
80104336:	5a                   	pop    %edx
80104337:	ff 73 1c             	push   0x1c(%ebx)
8010433a:	57                   	push   %edi
      p->state = RUNNING;
8010433b:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
      swtch(&(c->scheduler), p->context);
80104342:	e8 e4 0b 00 00       	call   80104f2b <swtch>
      switchkvm();
80104347:	e8 34 2d 00 00       	call   80107080 <switchkvm>
      c->proc = 0;
8010434c:	83 c4 10             	add    $0x10,%esp
8010434f:	c7 86 ac 00 00 00 00 	movl   $0x0,0xac(%esi)
80104356:	00 00 00 
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104359:	83 c3 7c             	add    $0x7c,%ebx
8010435c:	81 fb 94 58 11 80    	cmp    $0x80115894,%ebx
80104362:	75 bc                	jne    80104320 <scheduler+0x40>
    release(&ptable.lock);
80104364:	83 ec 0c             	sub    $0xc,%esp
80104367:	68 60 39 11 80       	push   $0x80113960
8010436c:	e8 7f 08 00 00       	call   80104bf0 <release>
    sti();
80104371:	83 c4 10             	add    $0x10,%esp
80104374:	eb 8a                	jmp    80104300 <scheduler+0x20>
80104376:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010437d:	8d 76 00             	lea    0x0(%esi),%esi

80104380 <sched>:
{
80104380:	55                   	push   %ebp
80104381:	89 e5                	mov    %esp,%ebp
80104383:	56                   	push   %esi
80104384:	53                   	push   %ebx
  pushcli();
80104385:	e8 76 07 00 00       	call   80104b00 <pushcli>
  c = mycpu();
8010438a:	e8 11 fc ff ff       	call   80103fa0 <mycpu>
  p = c->proc;
8010438f:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104395:	e8 b6 07 00 00       	call   80104b50 <popcli>
  if(!holding(&ptable.lock))
8010439a:	83 ec 0c             	sub    $0xc,%esp
8010439d:	68 60 39 11 80       	push   $0x80113960
801043a2:	e8 09 08 00 00       	call   80104bb0 <holding>
801043a7:	83 c4 10             	add    $0x10,%esp
801043aa:	85 c0                	test   %eax,%eax
801043ac:	74 4f                	je     801043fd <sched+0x7d>
  if(mycpu()->ncli != 1)
801043ae:	e8 ed fb ff ff       	call   80103fa0 <mycpu>
801043b3:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
801043ba:	75 68                	jne    80104424 <sched+0xa4>
  if(p->state == RUNNING)
801043bc:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
801043c0:	74 55                	je     80104417 <sched+0x97>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801043c2:	9c                   	pushf  
801043c3:	58                   	pop    %eax
  if(readeflags()&FL_IF)
801043c4:	f6 c4 02             	test   $0x2,%ah
801043c7:	75 41                	jne    8010440a <sched+0x8a>
  intena = mycpu()->intena;
801043c9:	e8 d2 fb ff ff       	call   80103fa0 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
801043ce:	83 c3 1c             	add    $0x1c,%ebx
  intena = mycpu()->intena;
801043d1:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
801043d7:	e8 c4 fb ff ff       	call   80103fa0 <mycpu>
801043dc:	83 ec 08             	sub    $0x8,%esp
801043df:	ff 70 04             	push   0x4(%eax)
801043e2:	53                   	push   %ebx
801043e3:	e8 43 0b 00 00       	call   80104f2b <swtch>
  mycpu()->intena = intena;
801043e8:	e8 b3 fb ff ff       	call   80103fa0 <mycpu>
}
801043ed:	83 c4 10             	add    $0x10,%esp
  mycpu()->intena = intena;
801043f0:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
801043f6:	8d 65 f8             	lea    -0x8(%ebp),%esp
801043f9:	5b                   	pop    %ebx
801043fa:	5e                   	pop    %esi
801043fb:	5d                   	pop    %ebp
801043fc:	c3                   	ret    
    panic("sched ptable.lock");
801043fd:	83 ec 0c             	sub    $0xc,%esp
80104400:	68 1b 7e 10 80       	push   $0x80107e1b
80104405:	e8 96 bf ff ff       	call   801003a0 <panic>
    panic("sched interruptible");
8010440a:	83 ec 0c             	sub    $0xc,%esp
8010440d:	68 47 7e 10 80       	push   $0x80107e47
80104412:	e8 89 bf ff ff       	call   801003a0 <panic>
    panic("sched running");
80104417:	83 ec 0c             	sub    $0xc,%esp
8010441a:	68 39 7e 10 80       	push   $0x80107e39
8010441f:	e8 7c bf ff ff       	call   801003a0 <panic>
    panic("sched locks");
80104424:	83 ec 0c             	sub    $0xc,%esp
80104427:	68 2d 7e 10 80       	push   $0x80107e2d
8010442c:	e8 6f bf ff ff       	call   801003a0 <panic>
80104431:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104438:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010443f:	90                   	nop

80104440 <exit>:
{
80104440:	55                   	push   %ebp
80104441:	89 e5                	mov    %esp,%ebp
80104443:	57                   	push   %edi
80104444:	56                   	push   %esi
80104445:	53                   	push   %ebx
80104446:	83 ec 0c             	sub    $0xc,%esp
  struct proc *curproc = myproc();
80104449:	e8 d2 fb ff ff       	call   80104020 <myproc>
  if(curproc == initproc)
8010444e:	39 05 94 58 11 80    	cmp    %eax,0x80115894
80104454:	0f 84 fd 00 00 00    	je     80104557 <exit+0x117>
8010445a:	89 c3                	mov    %eax,%ebx
8010445c:	8d 70 28             	lea    0x28(%eax),%esi
8010445f:	8d 78 68             	lea    0x68(%eax),%edi
80104462:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(curproc->ofile[fd]){
80104468:	8b 06                	mov    (%esi),%eax
8010446a:	85 c0                	test   %eax,%eax
8010446c:	74 12                	je     80104480 <exit+0x40>
      fileclose(curproc->ofile[fd]);
8010446e:	83 ec 0c             	sub    $0xc,%esp
80104471:	50                   	push   %eax
80104472:	e8 29 d1 ff ff       	call   801015a0 <fileclose>
      curproc->ofile[fd] = 0;
80104477:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
8010447d:	83 c4 10             	add    $0x10,%esp
  for(fd = 0; fd < NOFILE; fd++){
80104480:	83 c6 04             	add    $0x4,%esi
80104483:	39 f7                	cmp    %esi,%edi
80104485:	75 e1                	jne    80104468 <exit+0x28>
  begin_op();
80104487:	e8 84 ef ff ff       	call   80103410 <begin_op>
  iput(curproc->cwd);
8010448c:	83 ec 0c             	sub    $0xc,%esp
8010448f:	ff 73 68             	push   0x68(%ebx)
80104492:	e8 c9 da ff ff       	call   80101f60 <iput>
  end_op();
80104497:	e8 e4 ef ff ff       	call   80103480 <end_op>
  curproc->cwd = 0;
8010449c:	c7 43 68 00 00 00 00 	movl   $0x0,0x68(%ebx)
  acquire(&ptable.lock);
801044a3:	c7 04 24 60 39 11 80 	movl   $0x80113960,(%esp)
801044aa:	e8 a1 07 00 00       	call   80104c50 <acquire>
  wakeup1(curproc->parent);
801044af:	8b 53 14             	mov    0x14(%ebx),%edx
801044b2:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801044b5:	b8 94 39 11 80       	mov    $0x80113994,%eax
801044ba:	eb 0e                	jmp    801044ca <exit+0x8a>
801044bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801044c0:	83 c0 7c             	add    $0x7c,%eax
801044c3:	3d 94 58 11 80       	cmp    $0x80115894,%eax
801044c8:	74 1c                	je     801044e6 <exit+0xa6>
    if(p->state == SLEEPING && p->chan == chan)
801044ca:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
801044ce:	75 f0                	jne    801044c0 <exit+0x80>
801044d0:	3b 50 20             	cmp    0x20(%eax),%edx
801044d3:	75 eb                	jne    801044c0 <exit+0x80>
      p->state = RUNNABLE;
801044d5:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801044dc:	83 c0 7c             	add    $0x7c,%eax
801044df:	3d 94 58 11 80       	cmp    $0x80115894,%eax
801044e4:	75 e4                	jne    801044ca <exit+0x8a>
      p->parent = initproc;
801044e6:	8b 0d 94 58 11 80    	mov    0x80115894,%ecx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801044ec:	ba 94 39 11 80       	mov    $0x80113994,%edx
801044f1:	eb 10                	jmp    80104503 <exit+0xc3>
801044f3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801044f7:	90                   	nop
801044f8:	83 c2 7c             	add    $0x7c,%edx
801044fb:	81 fa 94 58 11 80    	cmp    $0x80115894,%edx
80104501:	74 3b                	je     8010453e <exit+0xfe>
    if(p->parent == curproc){
80104503:	39 5a 14             	cmp    %ebx,0x14(%edx)
80104506:	75 f0                	jne    801044f8 <exit+0xb8>
      if(p->state == ZOMBIE)
80104508:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
      p->parent = initproc;
8010450c:	89 4a 14             	mov    %ecx,0x14(%edx)
      if(p->state == ZOMBIE)
8010450f:	75 e7                	jne    801044f8 <exit+0xb8>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104511:	b8 94 39 11 80       	mov    $0x80113994,%eax
80104516:	eb 12                	jmp    8010452a <exit+0xea>
80104518:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010451f:	90                   	nop
80104520:	83 c0 7c             	add    $0x7c,%eax
80104523:	3d 94 58 11 80       	cmp    $0x80115894,%eax
80104528:	74 ce                	je     801044f8 <exit+0xb8>
    if(p->state == SLEEPING && p->chan == chan)
8010452a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
8010452e:	75 f0                	jne    80104520 <exit+0xe0>
80104530:	3b 48 20             	cmp    0x20(%eax),%ecx
80104533:	75 eb                	jne    80104520 <exit+0xe0>
      p->state = RUNNABLE;
80104535:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
8010453c:	eb e2                	jmp    80104520 <exit+0xe0>
  curproc->state = ZOMBIE;
8010453e:	c7 43 0c 05 00 00 00 	movl   $0x5,0xc(%ebx)
  sched();
80104545:	e8 36 fe ff ff       	call   80104380 <sched>
  panic("zombie exit");
8010454a:	83 ec 0c             	sub    $0xc,%esp
8010454d:	68 68 7e 10 80       	push   $0x80107e68
80104552:	e8 49 be ff ff       	call   801003a0 <panic>
    panic("init exiting");
80104557:	83 ec 0c             	sub    $0xc,%esp
8010455a:	68 5b 7e 10 80       	push   $0x80107e5b
8010455f:	e8 3c be ff ff       	call   801003a0 <panic>
80104564:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010456b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010456f:	90                   	nop

80104570 <wait>:
{
80104570:	55                   	push   %ebp
80104571:	89 e5                	mov    %esp,%ebp
80104573:	56                   	push   %esi
80104574:	53                   	push   %ebx
  pushcli();
80104575:	e8 86 05 00 00       	call   80104b00 <pushcli>
  c = mycpu();
8010457a:	e8 21 fa ff ff       	call   80103fa0 <mycpu>
  p = c->proc;
8010457f:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80104585:	e8 c6 05 00 00       	call   80104b50 <popcli>
  acquire(&ptable.lock);
8010458a:	83 ec 0c             	sub    $0xc,%esp
8010458d:	68 60 39 11 80       	push   $0x80113960
80104592:	e8 b9 06 00 00       	call   80104c50 <acquire>
80104597:	83 c4 10             	add    $0x10,%esp
    havekids = 0;
8010459a:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010459c:	bb 94 39 11 80       	mov    $0x80113994,%ebx
801045a1:	eb 10                	jmp    801045b3 <wait+0x43>
801045a3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801045a7:	90                   	nop
801045a8:	83 c3 7c             	add    $0x7c,%ebx
801045ab:	81 fb 94 58 11 80    	cmp    $0x80115894,%ebx
801045b1:	74 1b                	je     801045ce <wait+0x5e>
      if(p->parent != curproc)
801045b3:	39 73 14             	cmp    %esi,0x14(%ebx)
801045b6:	75 f0                	jne    801045a8 <wait+0x38>
      if(p->state == ZOMBIE){
801045b8:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
801045bc:	74 62                	je     80104620 <wait+0xb0>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801045be:	83 c3 7c             	add    $0x7c,%ebx
      havekids = 1;
801045c1:	b8 01 00 00 00       	mov    $0x1,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801045c6:	81 fb 94 58 11 80    	cmp    $0x80115894,%ebx
801045cc:	75 e5                	jne    801045b3 <wait+0x43>
    if(!havekids || curproc->killed){
801045ce:	85 c0                	test   %eax,%eax
801045d0:	0f 84 a0 00 00 00    	je     80104676 <wait+0x106>
801045d6:	8b 46 24             	mov    0x24(%esi),%eax
801045d9:	85 c0                	test   %eax,%eax
801045db:	0f 85 95 00 00 00    	jne    80104676 <wait+0x106>
  pushcli();
801045e1:	e8 1a 05 00 00       	call   80104b00 <pushcli>
  c = mycpu();
801045e6:	e8 b5 f9 ff ff       	call   80103fa0 <mycpu>
  p = c->proc;
801045eb:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801045f1:	e8 5a 05 00 00       	call   80104b50 <popcli>
  if(p == 0)
801045f6:	85 db                	test   %ebx,%ebx
801045f8:	0f 84 8f 00 00 00    	je     8010468d <wait+0x11d>
  p->chan = chan;
801045fe:	89 73 20             	mov    %esi,0x20(%ebx)
  p->state = SLEEPING;
80104601:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80104608:	e8 73 fd ff ff       	call   80104380 <sched>
  p->chan = 0;
8010460d:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
80104614:	eb 84                	jmp    8010459a <wait+0x2a>
80104616:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010461d:	8d 76 00             	lea    0x0(%esi),%esi
        kfree(p->kstack);
80104620:	83 ec 0c             	sub    $0xc,%esp
        pid = p->pid;
80104623:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80104626:	ff 73 08             	push   0x8(%ebx)
80104629:	e8 42 e5 ff ff       	call   80102b70 <kfree>
        p->kstack = 0;
8010462e:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80104635:	5a                   	pop    %edx
80104636:	ff 73 04             	push   0x4(%ebx)
80104639:	e8 32 2e 00 00       	call   80107470 <freevm>
        p->pid = 0;
8010463e:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
80104645:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
8010464c:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
80104650:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
80104657:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
8010465e:	c7 04 24 60 39 11 80 	movl   $0x80113960,(%esp)
80104665:	e8 86 05 00 00       	call   80104bf0 <release>
        return pid;
8010466a:	83 c4 10             	add    $0x10,%esp
}
8010466d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104670:	89 f0                	mov    %esi,%eax
80104672:	5b                   	pop    %ebx
80104673:	5e                   	pop    %esi
80104674:	5d                   	pop    %ebp
80104675:	c3                   	ret    
      release(&ptable.lock);
80104676:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80104679:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
8010467e:	68 60 39 11 80       	push   $0x80113960
80104683:	e8 68 05 00 00       	call   80104bf0 <release>
      return -1;
80104688:	83 c4 10             	add    $0x10,%esp
8010468b:	eb e0                	jmp    8010466d <wait+0xfd>
    panic("sleep");
8010468d:	83 ec 0c             	sub    $0xc,%esp
80104690:	68 74 7e 10 80       	push   $0x80107e74
80104695:	e8 06 bd ff ff       	call   801003a0 <panic>
8010469a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801046a0 <yield>:
{
801046a0:	55                   	push   %ebp
801046a1:	89 e5                	mov    %esp,%ebp
801046a3:	53                   	push   %ebx
801046a4:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
801046a7:	68 60 39 11 80       	push   $0x80113960
801046ac:	e8 9f 05 00 00       	call   80104c50 <acquire>
  pushcli();
801046b1:	e8 4a 04 00 00       	call   80104b00 <pushcli>
  c = mycpu();
801046b6:	e8 e5 f8 ff ff       	call   80103fa0 <mycpu>
  p = c->proc;
801046bb:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801046c1:	e8 8a 04 00 00       	call   80104b50 <popcli>
  myproc()->state = RUNNABLE;
801046c6:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  sched();
801046cd:	e8 ae fc ff ff       	call   80104380 <sched>
  release(&ptable.lock);
801046d2:	c7 04 24 60 39 11 80 	movl   $0x80113960,(%esp)
801046d9:	e8 12 05 00 00       	call   80104bf0 <release>
}
801046de:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801046e1:	83 c4 10             	add    $0x10,%esp
801046e4:	c9                   	leave  
801046e5:	c3                   	ret    
801046e6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801046ed:	8d 76 00             	lea    0x0(%esi),%esi

801046f0 <sleep>:
{
801046f0:	55                   	push   %ebp
801046f1:	89 e5                	mov    %esp,%ebp
801046f3:	57                   	push   %edi
801046f4:	56                   	push   %esi
801046f5:	53                   	push   %ebx
801046f6:	83 ec 0c             	sub    $0xc,%esp
801046f9:	8b 7d 08             	mov    0x8(%ebp),%edi
801046fc:	8b 75 0c             	mov    0xc(%ebp),%esi
  pushcli();
801046ff:	e8 fc 03 00 00       	call   80104b00 <pushcli>
  c = mycpu();
80104704:	e8 97 f8 ff ff       	call   80103fa0 <mycpu>
  p = c->proc;
80104709:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
8010470f:	e8 3c 04 00 00       	call   80104b50 <popcli>
  if(p == 0)
80104714:	85 db                	test   %ebx,%ebx
80104716:	0f 84 87 00 00 00    	je     801047a3 <sleep+0xb3>
  if(lk == 0)
8010471c:	85 f6                	test   %esi,%esi
8010471e:	74 76                	je     80104796 <sleep+0xa6>
  if(lk != &ptable.lock){  //DOC: sleeplock0
80104720:	81 fe 60 39 11 80    	cmp    $0x80113960,%esi
80104726:	74 50                	je     80104778 <sleep+0x88>
    acquire(&ptable.lock);  //DOC: sleeplock1
80104728:	83 ec 0c             	sub    $0xc,%esp
8010472b:	68 60 39 11 80       	push   $0x80113960
80104730:	e8 1b 05 00 00       	call   80104c50 <acquire>
    release(lk);
80104735:	89 34 24             	mov    %esi,(%esp)
80104738:	e8 b3 04 00 00       	call   80104bf0 <release>
  p->chan = chan;
8010473d:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80104740:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80104747:	e8 34 fc ff ff       	call   80104380 <sched>
  p->chan = 0;
8010474c:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
    release(&ptable.lock);
80104753:	c7 04 24 60 39 11 80 	movl   $0x80113960,(%esp)
8010475a:	e8 91 04 00 00       	call   80104bf0 <release>
    acquire(lk);
8010475f:	89 75 08             	mov    %esi,0x8(%ebp)
80104762:	83 c4 10             	add    $0x10,%esp
}
80104765:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104768:	5b                   	pop    %ebx
80104769:	5e                   	pop    %esi
8010476a:	5f                   	pop    %edi
8010476b:	5d                   	pop    %ebp
    acquire(lk);
8010476c:	e9 df 04 00 00       	jmp    80104c50 <acquire>
80104771:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  p->chan = chan;
80104778:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
8010477b:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80104782:	e8 f9 fb ff ff       	call   80104380 <sched>
  p->chan = 0;
80104787:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
8010478e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104791:	5b                   	pop    %ebx
80104792:	5e                   	pop    %esi
80104793:	5f                   	pop    %edi
80104794:	5d                   	pop    %ebp
80104795:	c3                   	ret    
    panic("sleep without lk");
80104796:	83 ec 0c             	sub    $0xc,%esp
80104799:	68 7a 7e 10 80       	push   $0x80107e7a
8010479e:	e8 fd bb ff ff       	call   801003a0 <panic>
    panic("sleep");
801047a3:	83 ec 0c             	sub    $0xc,%esp
801047a6:	68 74 7e 10 80       	push   $0x80107e74
801047ab:	e8 f0 bb ff ff       	call   801003a0 <panic>

801047b0 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
801047b0:	55                   	push   %ebp
801047b1:	89 e5                	mov    %esp,%ebp
801047b3:	53                   	push   %ebx
801047b4:	83 ec 10             	sub    $0x10,%esp
801047b7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
801047ba:	68 60 39 11 80       	push   $0x80113960
801047bf:	e8 8c 04 00 00       	call   80104c50 <acquire>
801047c4:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801047c7:	b8 94 39 11 80       	mov    $0x80113994,%eax
801047cc:	eb 0c                	jmp    801047da <wakeup+0x2a>
801047ce:	66 90                	xchg   %ax,%ax
801047d0:	83 c0 7c             	add    $0x7c,%eax
801047d3:	3d 94 58 11 80       	cmp    $0x80115894,%eax
801047d8:	74 1c                	je     801047f6 <wakeup+0x46>
    if(p->state == SLEEPING && p->chan == chan)
801047da:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
801047de:	75 f0                	jne    801047d0 <wakeup+0x20>
801047e0:	3b 58 20             	cmp    0x20(%eax),%ebx
801047e3:	75 eb                	jne    801047d0 <wakeup+0x20>
      p->state = RUNNABLE;
801047e5:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801047ec:	83 c0 7c             	add    $0x7c,%eax
801047ef:	3d 94 58 11 80       	cmp    $0x80115894,%eax
801047f4:	75 e4                	jne    801047da <wakeup+0x2a>
  wakeup1(chan);
  release(&ptable.lock);
801047f6:	c7 45 08 60 39 11 80 	movl   $0x80113960,0x8(%ebp)
}
801047fd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104800:	c9                   	leave  
  release(&ptable.lock);
80104801:	e9 ea 03 00 00       	jmp    80104bf0 <release>
80104806:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010480d:	8d 76 00             	lea    0x0(%esi),%esi

80104810 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80104810:	55                   	push   %ebp
80104811:	89 e5                	mov    %esp,%ebp
80104813:	53                   	push   %ebx
80104814:	83 ec 10             	sub    $0x10,%esp
80104817:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
8010481a:	68 60 39 11 80       	push   $0x80113960
8010481f:	e8 2c 04 00 00       	call   80104c50 <acquire>
80104824:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104827:	b8 94 39 11 80       	mov    $0x80113994,%eax
8010482c:	eb 0c                	jmp    8010483a <kill+0x2a>
8010482e:	66 90                	xchg   %ax,%ax
80104830:	83 c0 7c             	add    $0x7c,%eax
80104833:	3d 94 58 11 80       	cmp    $0x80115894,%eax
80104838:	74 36                	je     80104870 <kill+0x60>
    if(p->pid == pid){
8010483a:	39 58 10             	cmp    %ebx,0x10(%eax)
8010483d:	75 f1                	jne    80104830 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
8010483f:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
      p->killed = 1;
80104843:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      if(p->state == SLEEPING)
8010484a:	75 07                	jne    80104853 <kill+0x43>
        p->state = RUNNABLE;
8010484c:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      release(&ptable.lock);
80104853:	83 ec 0c             	sub    $0xc,%esp
80104856:	68 60 39 11 80       	push   $0x80113960
8010485b:	e8 90 03 00 00       	call   80104bf0 <release>
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
}
80104860:	8b 5d fc             	mov    -0x4(%ebp),%ebx
      return 0;
80104863:	83 c4 10             	add    $0x10,%esp
80104866:	31 c0                	xor    %eax,%eax
}
80104868:	c9                   	leave  
80104869:	c3                   	ret    
8010486a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  release(&ptable.lock);
80104870:	83 ec 0c             	sub    $0xc,%esp
80104873:	68 60 39 11 80       	push   $0x80113960
80104878:	e8 73 03 00 00       	call   80104bf0 <release>
}
8010487d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return -1;
80104880:	83 c4 10             	add    $0x10,%esp
80104883:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104888:	c9                   	leave  
80104889:	c3                   	ret    
8010488a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104890 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80104890:	55                   	push   %ebp
80104891:	89 e5                	mov    %esp,%ebp
80104893:	57                   	push   %edi
80104894:	56                   	push   %esi
80104895:	8d 75 e8             	lea    -0x18(%ebp),%esi
80104898:	53                   	push   %ebx
80104899:	bb 00 3a 11 80       	mov    $0x80113a00,%ebx
8010489e:	83 ec 3c             	sub    $0x3c,%esp
801048a1:	eb 24                	jmp    801048c7 <procdump+0x37>
801048a3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801048a7:	90                   	nop
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
801048a8:	83 ec 0c             	sub    $0xc,%esp
801048ab:	68 f7 81 10 80       	push   $0x801081f7
801048b0:	e8 9b be ff ff       	call   80100750 <cprintf>
801048b5:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801048b8:	83 c3 7c             	add    $0x7c,%ebx
801048bb:	81 fb 00 59 11 80    	cmp    $0x80115900,%ebx
801048c1:	0f 84 81 00 00 00    	je     80104948 <procdump+0xb8>
    if(p->state == UNUSED)
801048c7:	8b 43 a0             	mov    -0x60(%ebx),%eax
801048ca:	85 c0                	test   %eax,%eax
801048cc:	74 ea                	je     801048b8 <procdump+0x28>
      state = "???";
801048ce:	ba 8b 7e 10 80       	mov    $0x80107e8b,%edx
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
801048d3:	83 f8 05             	cmp    $0x5,%eax
801048d6:	77 11                	ja     801048e9 <procdump+0x59>
801048d8:	8b 14 85 ec 7e 10 80 	mov    -0x7fef8114(,%eax,4),%edx
      state = "???";
801048df:	b8 8b 7e 10 80       	mov    $0x80107e8b,%eax
801048e4:	85 d2                	test   %edx,%edx
801048e6:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
801048e9:	53                   	push   %ebx
801048ea:	52                   	push   %edx
801048eb:	ff 73 a4             	push   -0x5c(%ebx)
801048ee:	68 8f 7e 10 80       	push   $0x80107e8f
801048f3:	e8 58 be ff ff       	call   80100750 <cprintf>
    if(p->state == SLEEPING){
801048f8:	83 c4 10             	add    $0x10,%esp
801048fb:	83 7b a0 02          	cmpl   $0x2,-0x60(%ebx)
801048ff:	75 a7                	jne    801048a8 <procdump+0x18>
      getcallerpcs((uint*)p->context->ebp+2, pc);
80104901:	83 ec 08             	sub    $0x8,%esp
80104904:	8d 45 c0             	lea    -0x40(%ebp),%eax
80104907:	8d 7d c0             	lea    -0x40(%ebp),%edi
8010490a:	50                   	push   %eax
8010490b:	8b 43 b0             	mov    -0x50(%ebx),%eax
8010490e:	8b 40 0c             	mov    0xc(%eax),%eax
80104911:	83 c0 08             	add    $0x8,%eax
80104914:	50                   	push   %eax
80104915:	e8 86 01 00 00       	call   80104aa0 <getcallerpcs>
      for(i=0; i<10 && pc[i] != 0; i++)
8010491a:	83 c4 10             	add    $0x10,%esp
8010491d:	8d 76 00             	lea    0x0(%esi),%esi
80104920:	8b 17                	mov    (%edi),%edx
80104922:	85 d2                	test   %edx,%edx
80104924:	74 82                	je     801048a8 <procdump+0x18>
        cprintf(" %p", pc[i]);
80104926:	83 ec 08             	sub    $0x8,%esp
      for(i=0; i<10 && pc[i] != 0; i++)
80104929:	83 c7 04             	add    $0x4,%edi
        cprintf(" %p", pc[i]);
8010492c:	52                   	push   %edx
8010492d:	68 81 78 10 80       	push   $0x80107881
80104932:	e8 19 be ff ff       	call   80100750 <cprintf>
      for(i=0; i<10 && pc[i] != 0; i++)
80104937:	83 c4 10             	add    $0x10,%esp
8010493a:	39 fe                	cmp    %edi,%esi
8010493c:	75 e2                	jne    80104920 <procdump+0x90>
8010493e:	e9 65 ff ff ff       	jmp    801048a8 <procdump+0x18>
80104943:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104947:	90                   	nop
  }
}
80104948:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010494b:	5b                   	pop    %ebx
8010494c:	5e                   	pop    %esi
8010494d:	5f                   	pop    %edi
8010494e:	5d                   	pop    %ebp
8010494f:	c3                   	ret    

80104950 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80104950:	55                   	push   %ebp
80104951:	89 e5                	mov    %esp,%ebp
80104953:	53                   	push   %ebx
80104954:	83 ec 0c             	sub    $0xc,%esp
80104957:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
8010495a:	68 04 7f 10 80       	push   $0x80107f04
8010495f:	8d 43 04             	lea    0x4(%ebx),%eax
80104962:	50                   	push   %eax
80104963:	e8 18 01 00 00       	call   80104a80 <initlock>
  lk->name = name;
80104968:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
8010496b:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
80104971:	83 c4 10             	add    $0x10,%esp
  lk->pid = 0;
80104974:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
8010497b:	89 43 38             	mov    %eax,0x38(%ebx)
}
8010497e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104981:	c9                   	leave  
80104982:	c3                   	ret    
80104983:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010498a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104990 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80104990:	55                   	push   %ebp
80104991:	89 e5                	mov    %esp,%ebp
80104993:	56                   	push   %esi
80104994:	53                   	push   %ebx
80104995:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104998:	8d 73 04             	lea    0x4(%ebx),%esi
8010499b:	83 ec 0c             	sub    $0xc,%esp
8010499e:	56                   	push   %esi
8010499f:	e8 ac 02 00 00       	call   80104c50 <acquire>
  while (lk->locked) {
801049a4:	8b 13                	mov    (%ebx),%edx
801049a6:	83 c4 10             	add    $0x10,%esp
801049a9:	85 d2                	test   %edx,%edx
801049ab:	74 16                	je     801049c3 <acquiresleep+0x33>
801049ad:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
801049b0:	83 ec 08             	sub    $0x8,%esp
801049b3:	56                   	push   %esi
801049b4:	53                   	push   %ebx
801049b5:	e8 36 fd ff ff       	call   801046f0 <sleep>
  while (lk->locked) {
801049ba:	8b 03                	mov    (%ebx),%eax
801049bc:	83 c4 10             	add    $0x10,%esp
801049bf:	85 c0                	test   %eax,%eax
801049c1:	75 ed                	jne    801049b0 <acquiresleep+0x20>
  }
  lk->locked = 1;
801049c3:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
801049c9:	e8 52 f6 ff ff       	call   80104020 <myproc>
801049ce:	8b 40 10             	mov    0x10(%eax),%eax
801049d1:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
801049d4:	89 75 08             	mov    %esi,0x8(%ebp)
}
801049d7:	8d 65 f8             	lea    -0x8(%ebp),%esp
801049da:	5b                   	pop    %ebx
801049db:	5e                   	pop    %esi
801049dc:	5d                   	pop    %ebp
  release(&lk->lk);
801049dd:	e9 0e 02 00 00       	jmp    80104bf0 <release>
801049e2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801049e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801049f0 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
801049f0:	55                   	push   %ebp
801049f1:	89 e5                	mov    %esp,%ebp
801049f3:	56                   	push   %esi
801049f4:	53                   	push   %ebx
801049f5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
801049f8:	8d 73 04             	lea    0x4(%ebx),%esi
801049fb:	83 ec 0c             	sub    $0xc,%esp
801049fe:	56                   	push   %esi
801049ff:	e8 4c 02 00 00       	call   80104c50 <acquire>
  lk->locked = 0;
80104a04:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
80104a0a:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
80104a11:	89 1c 24             	mov    %ebx,(%esp)
80104a14:	e8 97 fd ff ff       	call   801047b0 <wakeup>
  release(&lk->lk);
80104a19:	89 75 08             	mov    %esi,0x8(%ebp)
80104a1c:	83 c4 10             	add    $0x10,%esp
}
80104a1f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104a22:	5b                   	pop    %ebx
80104a23:	5e                   	pop    %esi
80104a24:	5d                   	pop    %ebp
  release(&lk->lk);
80104a25:	e9 c6 01 00 00       	jmp    80104bf0 <release>
80104a2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104a30 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
80104a30:	55                   	push   %ebp
80104a31:	89 e5                	mov    %esp,%ebp
80104a33:	57                   	push   %edi
80104a34:	31 ff                	xor    %edi,%edi
80104a36:	56                   	push   %esi
80104a37:	53                   	push   %ebx
80104a38:	83 ec 18             	sub    $0x18,%esp
80104a3b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;
  
  acquire(&lk->lk);
80104a3e:	8d 73 04             	lea    0x4(%ebx),%esi
80104a41:	56                   	push   %esi
80104a42:	e8 09 02 00 00       	call   80104c50 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
80104a47:	8b 03                	mov    (%ebx),%eax
80104a49:	83 c4 10             	add    $0x10,%esp
80104a4c:	85 c0                	test   %eax,%eax
80104a4e:	75 18                	jne    80104a68 <holdingsleep+0x38>
  release(&lk->lk);
80104a50:	83 ec 0c             	sub    $0xc,%esp
80104a53:	56                   	push   %esi
80104a54:	e8 97 01 00 00       	call   80104bf0 <release>
  return r;
}
80104a59:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104a5c:	89 f8                	mov    %edi,%eax
80104a5e:	5b                   	pop    %ebx
80104a5f:	5e                   	pop    %esi
80104a60:	5f                   	pop    %edi
80104a61:	5d                   	pop    %ebp
80104a62:	c3                   	ret    
80104a63:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104a67:	90                   	nop
  r = lk->locked && (lk->pid == myproc()->pid);
80104a68:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
80104a6b:	e8 b0 f5 ff ff       	call   80104020 <myproc>
80104a70:	39 58 10             	cmp    %ebx,0x10(%eax)
80104a73:	0f 94 c0             	sete   %al
80104a76:	0f b6 c0             	movzbl %al,%eax
80104a79:	89 c7                	mov    %eax,%edi
80104a7b:	eb d3                	jmp    80104a50 <holdingsleep+0x20>
80104a7d:	66 90                	xchg   %ax,%ax
80104a7f:	90                   	nop

80104a80 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80104a80:	55                   	push   %ebp
80104a81:	89 e5                	mov    %esp,%ebp
80104a83:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80104a86:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
80104a89:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
80104a8f:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
80104a92:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80104a99:	5d                   	pop    %ebp
80104a9a:	c3                   	ret    
80104a9b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104a9f:	90                   	nop

80104aa0 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80104aa0:	55                   	push   %ebp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104aa1:	31 d2                	xor    %edx,%edx
{
80104aa3:	89 e5                	mov    %esp,%ebp
80104aa5:	53                   	push   %ebx
  ebp = (uint*)v - 2;
80104aa6:	8b 45 08             	mov    0x8(%ebp),%eax
{
80104aa9:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  ebp = (uint*)v - 2;
80104aac:	83 e8 08             	sub    $0x8,%eax
  for(i = 0; i < 10; i++){
80104aaf:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104ab0:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
80104ab6:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
80104abc:	77 1a                	ja     80104ad8 <getcallerpcs+0x38>
      break;
    pcs[i] = ebp[1];     // saved %eip
80104abe:	8b 58 04             	mov    0x4(%eax),%ebx
80104ac1:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
80104ac4:	83 c2 01             	add    $0x1,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
80104ac7:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80104ac9:	83 fa 0a             	cmp    $0xa,%edx
80104acc:	75 e2                	jne    80104ab0 <getcallerpcs+0x10>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
80104ace:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104ad1:	c9                   	leave  
80104ad2:	c3                   	ret    
80104ad3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104ad7:	90                   	nop
  for(; i < 10; i++)
80104ad8:	8d 04 91             	lea    (%ecx,%edx,4),%eax
80104adb:	8d 51 28             	lea    0x28(%ecx),%edx
80104ade:	66 90                	xchg   %ax,%ax
    pcs[i] = 0;
80104ae0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
80104ae6:	83 c0 04             	add    $0x4,%eax
80104ae9:	39 d0                	cmp    %edx,%eax
80104aeb:	75 f3                	jne    80104ae0 <getcallerpcs+0x40>
}
80104aed:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104af0:	c9                   	leave  
80104af1:	c3                   	ret    
80104af2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104af9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104b00 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80104b00:	55                   	push   %ebp
80104b01:	89 e5                	mov    %esp,%ebp
80104b03:	53                   	push   %ebx
80104b04:	83 ec 04             	sub    $0x4,%esp
80104b07:	9c                   	pushf  
80104b08:	5b                   	pop    %ebx
  asm volatile("cli");
80104b09:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
80104b0a:	e8 91 f4 ff ff       	call   80103fa0 <mycpu>
80104b0f:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
80104b15:	85 c0                	test   %eax,%eax
80104b17:	74 17                	je     80104b30 <pushcli+0x30>
    mycpu()->intena = eflags & FL_IF;
  mycpu()->ncli += 1;
80104b19:	e8 82 f4 ff ff       	call   80103fa0 <mycpu>
80104b1e:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
80104b25:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104b28:	c9                   	leave  
80104b29:	c3                   	ret    
80104b2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    mycpu()->intena = eflags & FL_IF;
80104b30:	e8 6b f4 ff ff       	call   80103fa0 <mycpu>
80104b35:	81 e3 00 02 00 00    	and    $0x200,%ebx
80104b3b:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
80104b41:	eb d6                	jmp    80104b19 <pushcli+0x19>
80104b43:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104b4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104b50 <popcli>:

void
popcli(void)
{
80104b50:	55                   	push   %ebp
80104b51:	89 e5                	mov    %esp,%ebp
80104b53:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104b56:	9c                   	pushf  
80104b57:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104b58:	f6 c4 02             	test   $0x2,%ah
80104b5b:	75 35                	jne    80104b92 <popcli+0x42>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
80104b5d:	e8 3e f4 ff ff       	call   80103fa0 <mycpu>
80104b62:	83 a8 a4 00 00 00 01 	subl   $0x1,0xa4(%eax)
80104b69:	78 34                	js     80104b9f <popcli+0x4f>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104b6b:	e8 30 f4 ff ff       	call   80103fa0 <mycpu>
80104b70:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80104b76:	85 d2                	test   %edx,%edx
80104b78:	74 06                	je     80104b80 <popcli+0x30>
    sti();
}
80104b7a:	c9                   	leave  
80104b7b:	c3                   	ret    
80104b7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104b80:	e8 1b f4 ff ff       	call   80103fa0 <mycpu>
80104b85:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
80104b8b:	85 c0                	test   %eax,%eax
80104b8d:	74 eb                	je     80104b7a <popcli+0x2a>
  asm volatile("sti");
80104b8f:	fb                   	sti    
}
80104b90:	c9                   	leave  
80104b91:	c3                   	ret    
    panic("popcli - interruptible");
80104b92:	83 ec 0c             	sub    $0xc,%esp
80104b95:	68 0f 7f 10 80       	push   $0x80107f0f
80104b9a:	e8 01 b8 ff ff       	call   801003a0 <panic>
    panic("popcli");
80104b9f:	83 ec 0c             	sub    $0xc,%esp
80104ba2:	68 26 7f 10 80       	push   $0x80107f26
80104ba7:	e8 f4 b7 ff ff       	call   801003a0 <panic>
80104bac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104bb0 <holding>:
{
80104bb0:	55                   	push   %ebp
80104bb1:	89 e5                	mov    %esp,%ebp
80104bb3:	56                   	push   %esi
80104bb4:	53                   	push   %ebx
80104bb5:	8b 75 08             	mov    0x8(%ebp),%esi
80104bb8:	31 db                	xor    %ebx,%ebx
  pushcli();
80104bba:	e8 41 ff ff ff       	call   80104b00 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
80104bbf:	8b 06                	mov    (%esi),%eax
80104bc1:	85 c0                	test   %eax,%eax
80104bc3:	75 0b                	jne    80104bd0 <holding+0x20>
  popcli();
80104bc5:	e8 86 ff ff ff       	call   80104b50 <popcli>
}
80104bca:	89 d8                	mov    %ebx,%eax
80104bcc:	5b                   	pop    %ebx
80104bcd:	5e                   	pop    %esi
80104bce:	5d                   	pop    %ebp
80104bcf:	c3                   	ret    
  r = lock->locked && lock->cpu == mycpu();
80104bd0:	8b 5e 08             	mov    0x8(%esi),%ebx
80104bd3:	e8 c8 f3 ff ff       	call   80103fa0 <mycpu>
80104bd8:	39 c3                	cmp    %eax,%ebx
80104bda:	0f 94 c3             	sete   %bl
  popcli();
80104bdd:	e8 6e ff ff ff       	call   80104b50 <popcli>
  r = lock->locked && lock->cpu == mycpu();
80104be2:	0f b6 db             	movzbl %bl,%ebx
}
80104be5:	89 d8                	mov    %ebx,%eax
80104be7:	5b                   	pop    %ebx
80104be8:	5e                   	pop    %esi
80104be9:	5d                   	pop    %ebp
80104bea:	c3                   	ret    
80104beb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104bef:	90                   	nop

80104bf0 <release>:
{
80104bf0:	55                   	push   %ebp
80104bf1:	89 e5                	mov    %esp,%ebp
80104bf3:	56                   	push   %esi
80104bf4:	53                   	push   %ebx
80104bf5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pushcli();
80104bf8:	e8 03 ff ff ff       	call   80104b00 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
80104bfd:	8b 03                	mov    (%ebx),%eax
80104bff:	85 c0                	test   %eax,%eax
80104c01:	75 15                	jne    80104c18 <release+0x28>
  popcli();
80104c03:	e8 48 ff ff ff       	call   80104b50 <popcli>
    panic("release");
80104c08:	83 ec 0c             	sub    $0xc,%esp
80104c0b:	68 2d 7f 10 80       	push   $0x80107f2d
80104c10:	e8 8b b7 ff ff       	call   801003a0 <panic>
80104c15:	8d 76 00             	lea    0x0(%esi),%esi
  r = lock->locked && lock->cpu == mycpu();
80104c18:	8b 73 08             	mov    0x8(%ebx),%esi
80104c1b:	e8 80 f3 ff ff       	call   80103fa0 <mycpu>
80104c20:	39 c6                	cmp    %eax,%esi
80104c22:	75 df                	jne    80104c03 <release+0x13>
  popcli();
80104c24:	e8 27 ff ff ff       	call   80104b50 <popcli>
  lk->pcs[0] = 0;
80104c29:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
80104c30:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
80104c37:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
80104c3c:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
80104c42:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104c45:	5b                   	pop    %ebx
80104c46:	5e                   	pop    %esi
80104c47:	5d                   	pop    %ebp
  popcli();
80104c48:	e9 03 ff ff ff       	jmp    80104b50 <popcli>
80104c4d:	8d 76 00             	lea    0x0(%esi),%esi

80104c50 <acquire>:
{
80104c50:	55                   	push   %ebp
80104c51:	89 e5                	mov    %esp,%ebp
80104c53:	53                   	push   %ebx
80104c54:	83 ec 04             	sub    $0x4,%esp
  pushcli(); // disable interrupts to avoid deadlock.
80104c57:	e8 a4 fe ff ff       	call   80104b00 <pushcli>
  if(holding(lk))
80104c5c:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pushcli();
80104c5f:	e8 9c fe ff ff       	call   80104b00 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
80104c64:	8b 03                	mov    (%ebx),%eax
80104c66:	85 c0                	test   %eax,%eax
80104c68:	75 7e                	jne    80104ce8 <acquire+0x98>
  popcli();
80104c6a:	e8 e1 fe ff ff       	call   80104b50 <popcli>
  asm volatile("lock; xchgl %0, %1" :
80104c6f:	b9 01 00 00 00       	mov    $0x1,%ecx
80104c74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while(xchg(&lk->locked, 1) != 0)
80104c78:	8b 55 08             	mov    0x8(%ebp),%edx
80104c7b:	89 c8                	mov    %ecx,%eax
80104c7d:	f0 87 02             	lock xchg %eax,(%edx)
80104c80:	85 c0                	test   %eax,%eax
80104c82:	75 f4                	jne    80104c78 <acquire+0x28>
  __sync_synchronize();
80104c84:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
80104c89:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104c8c:	e8 0f f3 ff ff       	call   80103fa0 <mycpu>
  getcallerpcs(&lk, lk->pcs);
80104c91:	8b 4d 08             	mov    0x8(%ebp),%ecx
  ebp = (uint*)v - 2;
80104c94:	89 ea                	mov    %ebp,%edx
  lk->cpu = mycpu();
80104c96:	89 43 08             	mov    %eax,0x8(%ebx)
  for(i = 0; i < 10; i++){
80104c99:	31 c0                	xor    %eax,%eax
80104c9b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104c9f:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104ca0:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
80104ca6:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
80104cac:	77 1a                	ja     80104cc8 <acquire+0x78>
    pcs[i] = ebp[1];     // saved %eip
80104cae:	8b 5a 04             	mov    0x4(%edx),%ebx
80104cb1:	89 5c 81 0c          	mov    %ebx,0xc(%ecx,%eax,4)
  for(i = 0; i < 10; i++){
80104cb5:	83 c0 01             	add    $0x1,%eax
    ebp = (uint*)ebp[0]; // saved %ebp
80104cb8:	8b 12                	mov    (%edx),%edx
  for(i = 0; i < 10; i++){
80104cba:	83 f8 0a             	cmp    $0xa,%eax
80104cbd:	75 e1                	jne    80104ca0 <acquire+0x50>
}
80104cbf:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104cc2:	c9                   	leave  
80104cc3:	c3                   	ret    
80104cc4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(; i < 10; i++)
80104cc8:	8d 44 81 0c          	lea    0xc(%ecx,%eax,4),%eax
80104ccc:	8d 51 34             	lea    0x34(%ecx),%edx
80104ccf:	90                   	nop
    pcs[i] = 0;
80104cd0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
80104cd6:	83 c0 04             	add    $0x4,%eax
80104cd9:	39 c2                	cmp    %eax,%edx
80104cdb:	75 f3                	jne    80104cd0 <acquire+0x80>
}
80104cdd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104ce0:	c9                   	leave  
80104ce1:	c3                   	ret    
80104ce2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  r = lock->locked && lock->cpu == mycpu();
80104ce8:	8b 5b 08             	mov    0x8(%ebx),%ebx
80104ceb:	e8 b0 f2 ff ff       	call   80103fa0 <mycpu>
80104cf0:	39 c3                	cmp    %eax,%ebx
80104cf2:	0f 85 72 ff ff ff    	jne    80104c6a <acquire+0x1a>
  popcli();
80104cf8:	e8 53 fe ff ff       	call   80104b50 <popcli>
    panic("acquire");
80104cfd:	83 ec 0c             	sub    $0xc,%esp
80104d00:	68 35 7f 10 80       	push   $0x80107f35
80104d05:	e8 96 b6 ff ff       	call   801003a0 <panic>
80104d0a:	66 90                	xchg   %ax,%ax
80104d0c:	66 90                	xchg   %ax,%ax
80104d0e:	66 90                	xchg   %ax,%ax

80104d10 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80104d10:	55                   	push   %ebp
80104d11:	89 e5                	mov    %esp,%ebp
80104d13:	57                   	push   %edi
80104d14:	8b 55 08             	mov    0x8(%ebp),%edx
80104d17:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104d1a:	53                   	push   %ebx
80104d1b:	8b 45 0c             	mov    0xc(%ebp),%eax
  if ((int)dst%4 == 0 && n%4 == 0){
80104d1e:	89 d7                	mov    %edx,%edi
80104d20:	09 cf                	or     %ecx,%edi
80104d22:	83 e7 03             	and    $0x3,%edi
80104d25:	75 29                	jne    80104d50 <memset+0x40>
    c &= 0xFF;
80104d27:	0f b6 f8             	movzbl %al,%edi
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
80104d2a:	c1 e0 18             	shl    $0x18,%eax
80104d2d:	89 fb                	mov    %edi,%ebx
80104d2f:	c1 e9 02             	shr    $0x2,%ecx
80104d32:	c1 e3 10             	shl    $0x10,%ebx
80104d35:	09 d8                	or     %ebx,%eax
80104d37:	09 f8                	or     %edi,%eax
80104d39:	c1 e7 08             	shl    $0x8,%edi
80104d3c:	09 f8                	or     %edi,%eax
  asm volatile("cld; rep stosl" :
80104d3e:	89 d7                	mov    %edx,%edi
80104d40:	fc                   	cld    
80104d41:	f3 ab                	rep stos %eax,%es:(%edi)
  } else
    stosb(dst, c, n);
  return dst;
}
80104d43:	5b                   	pop    %ebx
80104d44:	89 d0                	mov    %edx,%eax
80104d46:	5f                   	pop    %edi
80104d47:	5d                   	pop    %ebp
80104d48:	c3                   	ret    
80104d49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  asm volatile("cld; rep stosb" :
80104d50:	89 d7                	mov    %edx,%edi
80104d52:	fc                   	cld    
80104d53:	f3 aa                	rep stos %al,%es:(%edi)
80104d55:	5b                   	pop    %ebx
80104d56:	89 d0                	mov    %edx,%eax
80104d58:	5f                   	pop    %edi
80104d59:	5d                   	pop    %ebp
80104d5a:	c3                   	ret    
80104d5b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104d5f:	90                   	nop

80104d60 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80104d60:	55                   	push   %ebp
80104d61:	89 e5                	mov    %esp,%ebp
80104d63:	56                   	push   %esi
80104d64:	8b 75 10             	mov    0x10(%ebp),%esi
80104d67:	8b 55 08             	mov    0x8(%ebp),%edx
80104d6a:	53                   	push   %ebx
80104d6b:	8b 45 0c             	mov    0xc(%ebp),%eax
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
80104d6e:	85 f6                	test   %esi,%esi
80104d70:	74 2e                	je     80104da0 <memcmp+0x40>
80104d72:	01 c6                	add    %eax,%esi
80104d74:	eb 14                	jmp    80104d8a <memcmp+0x2a>
80104d76:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104d7d:	8d 76 00             	lea    0x0(%esi),%esi
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
80104d80:	83 c0 01             	add    $0x1,%eax
80104d83:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0){
80104d86:	39 f0                	cmp    %esi,%eax
80104d88:	74 16                	je     80104da0 <memcmp+0x40>
    if(*s1 != *s2)
80104d8a:	0f b6 0a             	movzbl (%edx),%ecx
80104d8d:	0f b6 18             	movzbl (%eax),%ebx
80104d90:	38 d9                	cmp    %bl,%cl
80104d92:	74 ec                	je     80104d80 <memcmp+0x20>
      return *s1 - *s2;
80104d94:	0f b6 c1             	movzbl %cl,%eax
80104d97:	29 d8                	sub    %ebx,%eax
  }

  return 0;
}
80104d99:	5b                   	pop    %ebx
80104d9a:	5e                   	pop    %esi
80104d9b:	5d                   	pop    %ebp
80104d9c:	c3                   	ret    
80104d9d:	8d 76 00             	lea    0x0(%esi),%esi
80104da0:	5b                   	pop    %ebx
  return 0;
80104da1:	31 c0                	xor    %eax,%eax
}
80104da3:	5e                   	pop    %esi
80104da4:	5d                   	pop    %ebp
80104da5:	c3                   	ret    
80104da6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104dad:	8d 76 00             	lea    0x0(%esi),%esi

80104db0 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80104db0:	55                   	push   %ebp
80104db1:	89 e5                	mov    %esp,%ebp
80104db3:	57                   	push   %edi
80104db4:	8b 55 08             	mov    0x8(%ebp),%edx
80104db7:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104dba:	56                   	push   %esi
80104dbb:	8b 75 0c             	mov    0xc(%ebp),%esi
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
80104dbe:	39 d6                	cmp    %edx,%esi
80104dc0:	73 26                	jae    80104de8 <memmove+0x38>
80104dc2:	8d 3c 0e             	lea    (%esi,%ecx,1),%edi
80104dc5:	39 fa                	cmp    %edi,%edx
80104dc7:	73 1f                	jae    80104de8 <memmove+0x38>
80104dc9:	8d 41 ff             	lea    -0x1(%ecx),%eax
    s += n;
    d += n;
    while(n-- > 0)
80104dcc:	85 c9                	test   %ecx,%ecx
80104dce:	74 0c                	je     80104ddc <memmove+0x2c>
      *--d = *--s;
80104dd0:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
80104dd4:	88 0c 02             	mov    %cl,(%edx,%eax,1)
    while(n-- > 0)
80104dd7:	83 e8 01             	sub    $0x1,%eax
80104dda:	73 f4                	jae    80104dd0 <memmove+0x20>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
80104ddc:	5e                   	pop    %esi
80104ddd:	89 d0                	mov    %edx,%eax
80104ddf:	5f                   	pop    %edi
80104de0:	5d                   	pop    %ebp
80104de1:	c3                   	ret    
80104de2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    while(n-- > 0)
80104de8:	8d 04 0e             	lea    (%esi,%ecx,1),%eax
80104deb:	89 d7                	mov    %edx,%edi
80104ded:	85 c9                	test   %ecx,%ecx
80104def:	74 eb                	je     80104ddc <memmove+0x2c>
80104df1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      *d++ = *s++;
80104df8:	a4                   	movsb  %ds:(%esi),%es:(%edi)
    while(n-- > 0)
80104df9:	39 c6                	cmp    %eax,%esi
80104dfb:	75 fb                	jne    80104df8 <memmove+0x48>
}
80104dfd:	5e                   	pop    %esi
80104dfe:	89 d0                	mov    %edx,%eax
80104e00:	5f                   	pop    %edi
80104e01:	5d                   	pop    %ebp
80104e02:	c3                   	ret    
80104e03:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104e0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104e10 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
  return memmove(dst, src, n);
80104e10:	eb 9e                	jmp    80104db0 <memmove>
80104e12:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104e19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104e20 <strncmp>:
}

int
strncmp(const char *p, const char *q, uint n)
{
80104e20:	55                   	push   %ebp
80104e21:	89 e5                	mov    %esp,%ebp
80104e23:	56                   	push   %esi
80104e24:	8b 75 10             	mov    0x10(%ebp),%esi
80104e27:	8b 4d 08             	mov    0x8(%ebp),%ecx
80104e2a:	53                   	push   %ebx
80104e2b:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(n > 0 && *p && *p == *q)
80104e2e:	85 f6                	test   %esi,%esi
80104e30:	74 2e                	je     80104e60 <strncmp+0x40>
80104e32:	01 d6                	add    %edx,%esi
80104e34:	eb 18                	jmp    80104e4e <strncmp+0x2e>
80104e36:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104e3d:	8d 76 00             	lea    0x0(%esi),%esi
80104e40:	38 d8                	cmp    %bl,%al
80104e42:	75 14                	jne    80104e58 <strncmp+0x38>
    n--, p++, q++;
80104e44:	83 c2 01             	add    $0x1,%edx
80104e47:	83 c1 01             	add    $0x1,%ecx
  while(n > 0 && *p && *p == *q)
80104e4a:	39 f2                	cmp    %esi,%edx
80104e4c:	74 12                	je     80104e60 <strncmp+0x40>
80104e4e:	0f b6 01             	movzbl (%ecx),%eax
80104e51:	0f b6 1a             	movzbl (%edx),%ebx
80104e54:	84 c0                	test   %al,%al
80104e56:	75 e8                	jne    80104e40 <strncmp+0x20>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
80104e58:	29 d8                	sub    %ebx,%eax
}
80104e5a:	5b                   	pop    %ebx
80104e5b:	5e                   	pop    %esi
80104e5c:	5d                   	pop    %ebp
80104e5d:	c3                   	ret    
80104e5e:	66 90                	xchg   %ax,%ax
80104e60:	5b                   	pop    %ebx
    return 0;
80104e61:	31 c0                	xor    %eax,%eax
}
80104e63:	5e                   	pop    %esi
80104e64:	5d                   	pop    %ebp
80104e65:	c3                   	ret    
80104e66:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104e6d:	8d 76 00             	lea    0x0(%esi),%esi

80104e70 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80104e70:	55                   	push   %ebp
80104e71:	89 e5                	mov    %esp,%ebp
80104e73:	57                   	push   %edi
80104e74:	56                   	push   %esi
80104e75:	8b 75 08             	mov    0x8(%ebp),%esi
80104e78:	53                   	push   %ebx
80104e79:	8b 4d 10             	mov    0x10(%ebp),%ecx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
80104e7c:	89 f0                	mov    %esi,%eax
80104e7e:	eb 15                	jmp    80104e95 <strncpy+0x25>
80104e80:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
80104e84:	8b 7d 0c             	mov    0xc(%ebp),%edi
80104e87:	83 c0 01             	add    $0x1,%eax
80104e8a:	0f b6 57 ff          	movzbl -0x1(%edi),%edx
80104e8e:	88 50 ff             	mov    %dl,-0x1(%eax)
80104e91:	84 d2                	test   %dl,%dl
80104e93:	74 09                	je     80104e9e <strncpy+0x2e>
80104e95:	89 cb                	mov    %ecx,%ebx
80104e97:	83 e9 01             	sub    $0x1,%ecx
80104e9a:	85 db                	test   %ebx,%ebx
80104e9c:	7f e2                	jg     80104e80 <strncpy+0x10>
    ;
  while(n-- > 0)
80104e9e:	89 c2                	mov    %eax,%edx
80104ea0:	85 c9                	test   %ecx,%ecx
80104ea2:	7e 17                	jle    80104ebb <strncpy+0x4b>
80104ea4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *s++ = 0;
80104ea8:	83 c2 01             	add    $0x1,%edx
80104eab:	89 c1                	mov    %eax,%ecx
80104ead:	c6 42 ff 00          	movb   $0x0,-0x1(%edx)
  while(n-- > 0)
80104eb1:	29 d1                	sub    %edx,%ecx
80104eb3:	8d 4c 0b ff          	lea    -0x1(%ebx,%ecx,1),%ecx
80104eb7:	85 c9                	test   %ecx,%ecx
80104eb9:	7f ed                	jg     80104ea8 <strncpy+0x38>
  return os;
}
80104ebb:	5b                   	pop    %ebx
80104ebc:	89 f0                	mov    %esi,%eax
80104ebe:	5e                   	pop    %esi
80104ebf:	5f                   	pop    %edi
80104ec0:	5d                   	pop    %ebp
80104ec1:	c3                   	ret    
80104ec2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104ec9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104ed0 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80104ed0:	55                   	push   %ebp
80104ed1:	89 e5                	mov    %esp,%ebp
80104ed3:	56                   	push   %esi
80104ed4:	8b 55 10             	mov    0x10(%ebp),%edx
80104ed7:	8b 75 08             	mov    0x8(%ebp),%esi
80104eda:	53                   	push   %ebx
80104edb:	8b 45 0c             	mov    0xc(%ebp),%eax
  char *os;

  os = s;
  if(n <= 0)
80104ede:	85 d2                	test   %edx,%edx
80104ee0:	7e 25                	jle    80104f07 <safestrcpy+0x37>
80104ee2:	8d 5c 10 ff          	lea    -0x1(%eax,%edx,1),%ebx
80104ee6:	89 f2                	mov    %esi,%edx
80104ee8:	eb 16                	jmp    80104f00 <safestrcpy+0x30>
80104eea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80104ef0:	0f b6 08             	movzbl (%eax),%ecx
80104ef3:	83 c0 01             	add    $0x1,%eax
80104ef6:	83 c2 01             	add    $0x1,%edx
80104ef9:	88 4a ff             	mov    %cl,-0x1(%edx)
80104efc:	84 c9                	test   %cl,%cl
80104efe:	74 04                	je     80104f04 <safestrcpy+0x34>
80104f00:	39 d8                	cmp    %ebx,%eax
80104f02:	75 ec                	jne    80104ef0 <safestrcpy+0x20>
    ;
  *s = 0;
80104f04:	c6 02 00             	movb   $0x0,(%edx)
  return os;
}
80104f07:	89 f0                	mov    %esi,%eax
80104f09:	5b                   	pop    %ebx
80104f0a:	5e                   	pop    %esi
80104f0b:	5d                   	pop    %ebp
80104f0c:	c3                   	ret    
80104f0d:	8d 76 00             	lea    0x0(%esi),%esi

80104f10 <strlen>:

int
strlen(const char *s)
{
80104f10:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80104f11:	31 c0                	xor    %eax,%eax
{
80104f13:	89 e5                	mov    %esp,%ebp
80104f15:	8b 55 08             	mov    0x8(%ebp),%edx
  for(n = 0; s[n]; n++)
80104f18:	80 3a 00             	cmpb   $0x0,(%edx)
80104f1b:	74 0c                	je     80104f29 <strlen+0x19>
80104f1d:	8d 76 00             	lea    0x0(%esi),%esi
80104f20:	83 c0 01             	add    $0x1,%eax
80104f23:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80104f27:	75 f7                	jne    80104f20 <strlen+0x10>
    ;
  return n;
}
80104f29:	5d                   	pop    %ebp
80104f2a:	c3                   	ret    

80104f2b <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
80104f2b:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
80104f2f:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-saved registers
  pushl %ebp
80104f33:	55                   	push   %ebp
  pushl %ebx
80104f34:	53                   	push   %ebx
  pushl %esi
80104f35:	56                   	push   %esi
  pushl %edi
80104f36:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
80104f37:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
80104f39:	89 d4                	mov    %edx,%esp

  # Load new callee-saved registers
  popl %edi
80104f3b:	5f                   	pop    %edi
  popl %esi
80104f3c:	5e                   	pop    %esi
  popl %ebx
80104f3d:	5b                   	pop    %ebx
  popl %ebp
80104f3e:	5d                   	pop    %ebp
  ret
80104f3f:	c3                   	ret    

80104f40 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80104f40:	55                   	push   %ebp
80104f41:	89 e5                	mov    %esp,%ebp
80104f43:	53                   	push   %ebx
80104f44:	83 ec 04             	sub    $0x4,%esp
80104f47:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
80104f4a:	e8 d1 f0 ff ff       	call   80104020 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104f4f:	8b 00                	mov    (%eax),%eax
80104f51:	39 d8                	cmp    %ebx,%eax
80104f53:	76 1b                	jbe    80104f70 <fetchint+0x30>
80104f55:	8d 53 04             	lea    0x4(%ebx),%edx
80104f58:	39 d0                	cmp    %edx,%eax
80104f5a:	72 14                	jb     80104f70 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
80104f5c:	8b 45 0c             	mov    0xc(%ebp),%eax
80104f5f:	8b 13                	mov    (%ebx),%edx
80104f61:	89 10                	mov    %edx,(%eax)
  return 0;
80104f63:	31 c0                	xor    %eax,%eax
}
80104f65:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104f68:	c9                   	leave  
80104f69:	c3                   	ret    
80104f6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80104f70:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104f75:	eb ee                	jmp    80104f65 <fetchint+0x25>
80104f77:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104f7e:	66 90                	xchg   %ax,%ax

80104f80 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80104f80:	55                   	push   %ebp
80104f81:	89 e5                	mov    %esp,%ebp
80104f83:	53                   	push   %ebx
80104f84:	83 ec 04             	sub    $0x4,%esp
80104f87:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
80104f8a:	e8 91 f0 ff ff       	call   80104020 <myproc>

  if(addr >= curproc->sz)
80104f8f:	39 18                	cmp    %ebx,(%eax)
80104f91:	76 2d                	jbe    80104fc0 <fetchstr+0x40>
    return -1;
  *pp = (char*)addr;
80104f93:	8b 55 0c             	mov    0xc(%ebp),%edx
80104f96:	89 1a                	mov    %ebx,(%edx)
  ep = (char*)curproc->sz;
80104f98:	8b 10                	mov    (%eax),%edx
  for(s = *pp; s < ep; s++){
80104f9a:	39 d3                	cmp    %edx,%ebx
80104f9c:	73 22                	jae    80104fc0 <fetchstr+0x40>
80104f9e:	89 d8                	mov    %ebx,%eax
80104fa0:	eb 0d                	jmp    80104faf <fetchstr+0x2f>
80104fa2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104fa8:	83 c0 01             	add    $0x1,%eax
80104fab:	39 c2                	cmp    %eax,%edx
80104fad:	76 11                	jbe    80104fc0 <fetchstr+0x40>
    if(*s == 0)
80104faf:	80 38 00             	cmpb   $0x0,(%eax)
80104fb2:	75 f4                	jne    80104fa8 <fetchstr+0x28>
      return s - *pp;
80104fb4:	29 d8                	sub    %ebx,%eax
  }
  return -1;
}
80104fb6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104fb9:	c9                   	leave  
80104fba:	c3                   	ret    
80104fbb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104fbf:	90                   	nop
80104fc0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return -1;
80104fc3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104fc8:	c9                   	leave  
80104fc9:	c3                   	ret    
80104fca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104fd0 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80104fd0:	55                   	push   %ebp
80104fd1:	89 e5                	mov    %esp,%ebp
80104fd3:	56                   	push   %esi
80104fd4:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104fd5:	e8 46 f0 ff ff       	call   80104020 <myproc>
80104fda:	8b 55 08             	mov    0x8(%ebp),%edx
80104fdd:	8b 40 18             	mov    0x18(%eax),%eax
80104fe0:	8b 40 44             	mov    0x44(%eax),%eax
80104fe3:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80104fe6:	e8 35 f0 ff ff       	call   80104020 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104feb:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104fee:	8b 00                	mov    (%eax),%eax
80104ff0:	39 c6                	cmp    %eax,%esi
80104ff2:	73 1c                	jae    80105010 <argint+0x40>
80104ff4:	8d 53 08             	lea    0x8(%ebx),%edx
80104ff7:	39 d0                	cmp    %edx,%eax
80104ff9:	72 15                	jb     80105010 <argint+0x40>
  *ip = *(int*)(addr);
80104ffb:	8b 45 0c             	mov    0xc(%ebp),%eax
80104ffe:	8b 53 04             	mov    0x4(%ebx),%edx
80105001:	89 10                	mov    %edx,(%eax)
  return 0;
80105003:	31 c0                	xor    %eax,%eax
}
80105005:	5b                   	pop    %ebx
80105006:	5e                   	pop    %esi
80105007:	5d                   	pop    %ebp
80105008:	c3                   	ret    
80105009:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105010:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80105015:	eb ee                	jmp    80105005 <argint+0x35>
80105017:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010501e:	66 90                	xchg   %ax,%ax

80105020 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80105020:	55                   	push   %ebp
80105021:	89 e5                	mov    %esp,%ebp
80105023:	57                   	push   %edi
80105024:	56                   	push   %esi
80105025:	53                   	push   %ebx
80105026:	83 ec 0c             	sub    $0xc,%esp
  int i;
  struct proc *curproc = myproc();
80105029:	e8 f2 ef ff ff       	call   80104020 <myproc>
8010502e:	89 c6                	mov    %eax,%esi
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80105030:	e8 eb ef ff ff       	call   80104020 <myproc>
80105035:	8b 55 08             	mov    0x8(%ebp),%edx
80105038:	8b 40 18             	mov    0x18(%eax),%eax
8010503b:	8b 40 44             	mov    0x44(%eax),%eax
8010503e:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80105041:	e8 da ef ff ff       	call   80104020 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80105046:	8d 7b 04             	lea    0x4(%ebx),%edi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80105049:	8b 00                	mov    (%eax),%eax
8010504b:	39 c7                	cmp    %eax,%edi
8010504d:	73 31                	jae    80105080 <argptr+0x60>
8010504f:	8d 4b 08             	lea    0x8(%ebx),%ecx
80105052:	39 c8                	cmp    %ecx,%eax
80105054:	72 2a                	jb     80105080 <argptr+0x60>
 
  if(argint(n, &i) < 0)
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80105056:	8b 55 10             	mov    0x10(%ebp),%edx
  *ip = *(int*)(addr);
80105059:	8b 43 04             	mov    0x4(%ebx),%eax
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
8010505c:	85 d2                	test   %edx,%edx
8010505e:	78 20                	js     80105080 <argptr+0x60>
80105060:	8b 16                	mov    (%esi),%edx
80105062:	39 c2                	cmp    %eax,%edx
80105064:	76 1a                	jbe    80105080 <argptr+0x60>
80105066:	8b 5d 10             	mov    0x10(%ebp),%ebx
80105069:	01 c3                	add    %eax,%ebx
8010506b:	39 da                	cmp    %ebx,%edx
8010506d:	72 11                	jb     80105080 <argptr+0x60>
    return -1;
  *pp = (char*)i;
8010506f:	8b 55 0c             	mov    0xc(%ebp),%edx
80105072:	89 02                	mov    %eax,(%edx)
  return 0;
80105074:	31 c0                	xor    %eax,%eax
}
80105076:	83 c4 0c             	add    $0xc,%esp
80105079:	5b                   	pop    %ebx
8010507a:	5e                   	pop    %esi
8010507b:	5f                   	pop    %edi
8010507c:	5d                   	pop    %ebp
8010507d:	c3                   	ret    
8010507e:	66 90                	xchg   %ax,%ax
    return -1;
80105080:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105085:	eb ef                	jmp    80105076 <argptr+0x56>
80105087:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010508e:	66 90                	xchg   %ax,%ax

80105090 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80105090:	55                   	push   %ebp
80105091:	89 e5                	mov    %esp,%ebp
80105093:	56                   	push   %esi
80105094:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80105095:	e8 86 ef ff ff       	call   80104020 <myproc>
8010509a:	8b 55 08             	mov    0x8(%ebp),%edx
8010509d:	8b 40 18             	mov    0x18(%eax),%eax
801050a0:	8b 40 44             	mov    0x44(%eax),%eax
801050a3:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
801050a6:	e8 75 ef ff ff       	call   80104020 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801050ab:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
801050ae:	8b 00                	mov    (%eax),%eax
801050b0:	39 c6                	cmp    %eax,%esi
801050b2:	73 44                	jae    801050f8 <argstr+0x68>
801050b4:	8d 53 08             	lea    0x8(%ebx),%edx
801050b7:	39 d0                	cmp    %edx,%eax
801050b9:	72 3d                	jb     801050f8 <argstr+0x68>
  *ip = *(int*)(addr);
801050bb:	8b 5b 04             	mov    0x4(%ebx),%ebx
  struct proc *curproc = myproc();
801050be:	e8 5d ef ff ff       	call   80104020 <myproc>
  if(addr >= curproc->sz)
801050c3:	3b 18                	cmp    (%eax),%ebx
801050c5:	73 31                	jae    801050f8 <argstr+0x68>
  *pp = (char*)addr;
801050c7:	8b 55 0c             	mov    0xc(%ebp),%edx
801050ca:	89 1a                	mov    %ebx,(%edx)
  ep = (char*)curproc->sz;
801050cc:	8b 10                	mov    (%eax),%edx
  for(s = *pp; s < ep; s++){
801050ce:	39 d3                	cmp    %edx,%ebx
801050d0:	73 26                	jae    801050f8 <argstr+0x68>
801050d2:	89 d8                	mov    %ebx,%eax
801050d4:	eb 11                	jmp    801050e7 <argstr+0x57>
801050d6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801050dd:	8d 76 00             	lea    0x0(%esi),%esi
801050e0:	83 c0 01             	add    $0x1,%eax
801050e3:	39 c2                	cmp    %eax,%edx
801050e5:	76 11                	jbe    801050f8 <argstr+0x68>
    if(*s == 0)
801050e7:	80 38 00             	cmpb   $0x0,(%eax)
801050ea:	75 f4                	jne    801050e0 <argstr+0x50>
      return s - *pp;
801050ec:	29 d8                	sub    %ebx,%eax
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
  return fetchstr(addr, pp);
}
801050ee:	5b                   	pop    %ebx
801050ef:	5e                   	pop    %esi
801050f0:	5d                   	pop    %ebp
801050f1:	c3                   	ret    
801050f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801050f8:	5b                   	pop    %ebx
    return -1;
801050f9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801050fe:	5e                   	pop    %esi
801050ff:	5d                   	pop    %ebp
80105100:	c3                   	ret    
80105101:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105108:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010510f:	90                   	nop

80105110 <syscall>:
[SYS_close]   sys_close,
};

void
syscall(void)
{
80105110:	55                   	push   %ebp
80105111:	89 e5                	mov    %esp,%ebp
80105113:	53                   	push   %ebx
80105114:	83 ec 04             	sub    $0x4,%esp
  int num;
  struct proc *curproc = myproc();
80105117:	e8 04 ef ff ff       	call   80104020 <myproc>
8010511c:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax;
8010511e:	8b 40 18             	mov    0x18(%eax),%eax
80105121:	8b 40 1c             	mov    0x1c(%eax),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80105124:	8d 50 ff             	lea    -0x1(%eax),%edx
80105127:	83 fa 14             	cmp    $0x14,%edx
8010512a:	77 24                	ja     80105150 <syscall+0x40>
8010512c:	8b 14 85 60 7f 10 80 	mov    -0x7fef80a0(,%eax,4),%edx
80105133:	85 d2                	test   %edx,%edx
80105135:	74 19                	je     80105150 <syscall+0x40>
    curproc->tf->eax = syscalls[num]();
80105137:	ff d2                	call   *%edx
80105139:	89 c2                	mov    %eax,%edx
8010513b:	8b 43 18             	mov    0x18(%ebx),%eax
8010513e:	89 50 1c             	mov    %edx,0x1c(%eax)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
80105141:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105144:	c9                   	leave  
80105145:	c3                   	ret    
80105146:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010514d:	8d 76 00             	lea    0x0(%esi),%esi
    cprintf("%d %s: unknown sys call %d\n",
80105150:	50                   	push   %eax
            curproc->pid, curproc->name, num);
80105151:	8d 43 6c             	lea    0x6c(%ebx),%eax
    cprintf("%d %s: unknown sys call %d\n",
80105154:	50                   	push   %eax
80105155:	ff 73 10             	push   0x10(%ebx)
80105158:	68 3d 7f 10 80       	push   $0x80107f3d
8010515d:	e8 ee b5 ff ff       	call   80100750 <cprintf>
    curproc->tf->eax = -1;
80105162:	8b 43 18             	mov    0x18(%ebx),%eax
80105165:	83 c4 10             	add    $0x10,%esp
80105168:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
8010516f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105172:	c9                   	leave  
80105173:	c3                   	ret    
80105174:	66 90                	xchg   %ax,%ax
80105176:	66 90                	xchg   %ax,%ax
80105178:	66 90                	xchg   %ax,%ax
8010517a:	66 90                	xchg   %ax,%ax
8010517c:	66 90                	xchg   %ax,%ax
8010517e:	66 90                	xchg   %ax,%ax

80105180 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80105180:	55                   	push   %ebp
80105181:	89 e5                	mov    %esp,%ebp
80105183:	57                   	push   %edi
80105184:	56                   	push   %esi
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80105185:	8d 7d da             	lea    -0x26(%ebp),%edi
{
80105188:	53                   	push   %ebx
80105189:	83 ec 34             	sub    $0x34,%esp
8010518c:	89 4d d0             	mov    %ecx,-0x30(%ebp)
8010518f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  if((dp = nameiparent(path, name)) == 0)
80105192:	57                   	push   %edi
80105193:	50                   	push   %eax
{
80105194:	89 55 d4             	mov    %edx,-0x2c(%ebp)
80105197:	89 4d cc             	mov    %ecx,-0x34(%ebp)
  if((dp = nameiparent(path, name)) == 0)
8010519a:	e8 d1 d5 ff ff       	call   80102770 <nameiparent>
8010519f:	83 c4 10             	add    $0x10,%esp
801051a2:	85 c0                	test   %eax,%eax
801051a4:	0f 84 46 01 00 00    	je     801052f0 <create+0x170>
    return 0;
  ilock(dp);
801051aa:	83 ec 0c             	sub    $0xc,%esp
801051ad:	89 c3                	mov    %eax,%ebx
801051af:	50                   	push   %eax
801051b0:	e8 7b cc ff ff       	call   80101e30 <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
801051b5:	83 c4 0c             	add    $0xc,%esp
801051b8:	6a 00                	push   $0x0
801051ba:	57                   	push   %edi
801051bb:	53                   	push   %ebx
801051bc:	e8 cf d1 ff ff       	call   80102390 <dirlookup>
801051c1:	83 c4 10             	add    $0x10,%esp
801051c4:	89 c6                	mov    %eax,%esi
801051c6:	85 c0                	test   %eax,%eax
801051c8:	74 56                	je     80105220 <create+0xa0>
    iunlockput(dp);
801051ca:	83 ec 0c             	sub    $0xc,%esp
801051cd:	53                   	push   %ebx
801051ce:	e8 ed ce ff ff       	call   801020c0 <iunlockput>
    ilock(ip);
801051d3:	89 34 24             	mov    %esi,(%esp)
801051d6:	e8 55 cc ff ff       	call   80101e30 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
801051db:	83 c4 10             	add    $0x10,%esp
801051de:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
801051e3:	75 1b                	jne    80105200 <create+0x80>
801051e5:	66 83 7e 50 02       	cmpw   $0x2,0x50(%esi)
801051ea:	75 14                	jne    80105200 <create+0x80>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
801051ec:	8d 65 f4             	lea    -0xc(%ebp),%esp
801051ef:	89 f0                	mov    %esi,%eax
801051f1:	5b                   	pop    %ebx
801051f2:	5e                   	pop    %esi
801051f3:	5f                   	pop    %edi
801051f4:	5d                   	pop    %ebp
801051f5:	c3                   	ret    
801051f6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801051fd:	8d 76 00             	lea    0x0(%esi),%esi
    iunlockput(ip);
80105200:	83 ec 0c             	sub    $0xc,%esp
80105203:	56                   	push   %esi
    return 0;
80105204:	31 f6                	xor    %esi,%esi
    iunlockput(ip);
80105206:	e8 b5 ce ff ff       	call   801020c0 <iunlockput>
    return 0;
8010520b:	83 c4 10             	add    $0x10,%esp
}
8010520e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105211:	89 f0                	mov    %esi,%eax
80105213:	5b                   	pop    %ebx
80105214:	5e                   	pop    %esi
80105215:	5f                   	pop    %edi
80105216:	5d                   	pop    %ebp
80105217:	c3                   	ret    
80105218:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010521f:	90                   	nop
  if((ip = ialloc(dp->dev, type)) == 0)
80105220:	0f bf 45 d4          	movswl -0x2c(%ebp),%eax
80105224:	83 ec 08             	sub    $0x8,%esp
80105227:	50                   	push   %eax
80105228:	ff 33                	push   (%ebx)
8010522a:	e8 91 ca ff ff       	call   80101cc0 <ialloc>
8010522f:	83 c4 10             	add    $0x10,%esp
80105232:	89 c6                	mov    %eax,%esi
80105234:	85 c0                	test   %eax,%eax
80105236:	0f 84 cd 00 00 00    	je     80105309 <create+0x189>
  ilock(ip);
8010523c:	83 ec 0c             	sub    $0xc,%esp
8010523f:	50                   	push   %eax
80105240:	e8 eb cb ff ff       	call   80101e30 <ilock>
  ip->major = major;
80105245:	0f b7 45 d0          	movzwl -0x30(%ebp),%eax
80105249:	66 89 46 52          	mov    %ax,0x52(%esi)
  ip->minor = minor;
8010524d:	0f b7 45 cc          	movzwl -0x34(%ebp),%eax
80105251:	66 89 46 54          	mov    %ax,0x54(%esi)
  ip->nlink = 1;
80105255:	b8 01 00 00 00       	mov    $0x1,%eax
8010525a:	66 89 46 56          	mov    %ax,0x56(%esi)
  iupdate(ip);
8010525e:	89 34 24             	mov    %esi,(%esp)
80105261:	e8 1a cb ff ff       	call   80101d80 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
80105266:	83 c4 10             	add    $0x10,%esp
80105269:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
8010526e:	74 30                	je     801052a0 <create+0x120>
  if(dirlink(dp, name, ip->inum) < 0)
80105270:	83 ec 04             	sub    $0x4,%esp
80105273:	ff 76 04             	push   0x4(%esi)
80105276:	57                   	push   %edi
80105277:	53                   	push   %ebx
80105278:	e8 13 d4 ff ff       	call   80102690 <dirlink>
8010527d:	83 c4 10             	add    $0x10,%esp
80105280:	85 c0                	test   %eax,%eax
80105282:	78 78                	js     801052fc <create+0x17c>
  iunlockput(dp);
80105284:	83 ec 0c             	sub    $0xc,%esp
80105287:	53                   	push   %ebx
80105288:	e8 33 ce ff ff       	call   801020c0 <iunlockput>
  return ip;
8010528d:	83 c4 10             	add    $0x10,%esp
}
80105290:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105293:	89 f0                	mov    %esi,%eax
80105295:	5b                   	pop    %ebx
80105296:	5e                   	pop    %esi
80105297:	5f                   	pop    %edi
80105298:	5d                   	pop    %ebp
80105299:	c3                   	ret    
8010529a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iupdate(dp);
801052a0:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink++;  // for ".."
801052a3:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
    iupdate(dp);
801052a8:	53                   	push   %ebx
801052a9:	e8 d2 ca ff ff       	call   80101d80 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
801052ae:	83 c4 0c             	add    $0xc,%esp
801052b1:	ff 76 04             	push   0x4(%esi)
801052b4:	68 d4 7f 10 80       	push   $0x80107fd4
801052b9:	56                   	push   %esi
801052ba:	e8 d1 d3 ff ff       	call   80102690 <dirlink>
801052bf:	83 c4 10             	add    $0x10,%esp
801052c2:	85 c0                	test   %eax,%eax
801052c4:	78 18                	js     801052de <create+0x15e>
801052c6:	83 ec 04             	sub    $0x4,%esp
801052c9:	ff 73 04             	push   0x4(%ebx)
801052cc:	68 d3 7f 10 80       	push   $0x80107fd3
801052d1:	56                   	push   %esi
801052d2:	e8 b9 d3 ff ff       	call   80102690 <dirlink>
801052d7:	83 c4 10             	add    $0x10,%esp
801052da:	85 c0                	test   %eax,%eax
801052dc:	79 92                	jns    80105270 <create+0xf0>
      panic("create dots");
801052de:	83 ec 0c             	sub    $0xc,%esp
801052e1:	68 c7 7f 10 80       	push   $0x80107fc7
801052e6:	e8 b5 b0 ff ff       	call   801003a0 <panic>
801052eb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801052ef:	90                   	nop
}
801052f0:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
801052f3:	31 f6                	xor    %esi,%esi
}
801052f5:	5b                   	pop    %ebx
801052f6:	89 f0                	mov    %esi,%eax
801052f8:	5e                   	pop    %esi
801052f9:	5f                   	pop    %edi
801052fa:	5d                   	pop    %ebp
801052fb:	c3                   	ret    
    panic("create: dirlink");
801052fc:	83 ec 0c             	sub    $0xc,%esp
801052ff:	68 d6 7f 10 80       	push   $0x80107fd6
80105304:	e8 97 b0 ff ff       	call   801003a0 <panic>
    panic("create: ialloc");
80105309:	83 ec 0c             	sub    $0xc,%esp
8010530c:	68 b8 7f 10 80       	push   $0x80107fb8
80105311:	e8 8a b0 ff ff       	call   801003a0 <panic>
80105316:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010531d:	8d 76 00             	lea    0x0(%esi),%esi

80105320 <sys_dup>:
{
80105320:	55                   	push   %ebp
80105321:	89 e5                	mov    %esp,%ebp
80105323:	56                   	push   %esi
80105324:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80105325:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105328:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
8010532b:	50                   	push   %eax
8010532c:	6a 00                	push   $0x0
8010532e:	e8 9d fc ff ff       	call   80104fd0 <argint>
80105333:	83 c4 10             	add    $0x10,%esp
80105336:	85 c0                	test   %eax,%eax
80105338:	78 36                	js     80105370 <sys_dup+0x50>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
8010533a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
8010533e:	77 30                	ja     80105370 <sys_dup+0x50>
80105340:	e8 db ec ff ff       	call   80104020 <myproc>
80105345:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105348:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
8010534c:	85 f6                	test   %esi,%esi
8010534e:	74 20                	je     80105370 <sys_dup+0x50>
  struct proc *curproc = myproc();
80105350:	e8 cb ec ff ff       	call   80104020 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80105355:	31 db                	xor    %ebx,%ebx
80105357:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010535e:	66 90                	xchg   %ax,%ax
    if(curproc->ofile[fd] == 0){
80105360:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105364:	85 d2                	test   %edx,%edx
80105366:	74 18                	je     80105380 <sys_dup+0x60>
  for(fd = 0; fd < NOFILE; fd++){
80105368:	83 c3 01             	add    $0x1,%ebx
8010536b:	83 fb 10             	cmp    $0x10,%ebx
8010536e:	75 f0                	jne    80105360 <sys_dup+0x40>
}
80105370:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return -1;
80105373:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
80105378:	89 d8                	mov    %ebx,%eax
8010537a:	5b                   	pop    %ebx
8010537b:	5e                   	pop    %esi
8010537c:	5d                   	pop    %ebp
8010537d:	c3                   	ret    
8010537e:	66 90                	xchg   %ax,%ax
  filedup(f);
80105380:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
80105383:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)
  filedup(f);
80105387:	56                   	push   %esi
80105388:	e8 c3 c1 ff ff       	call   80101550 <filedup>
  return fd;
8010538d:	83 c4 10             	add    $0x10,%esp
}
80105390:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105393:	89 d8                	mov    %ebx,%eax
80105395:	5b                   	pop    %ebx
80105396:	5e                   	pop    %esi
80105397:	5d                   	pop    %ebp
80105398:	c3                   	ret    
80105399:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801053a0 <sys_read>:
{
801053a0:	55                   	push   %ebp
801053a1:	89 e5                	mov    %esp,%ebp
801053a3:	56                   	push   %esi
801053a4:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
801053a5:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
801053a8:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
801053ab:	53                   	push   %ebx
801053ac:	6a 00                	push   $0x0
801053ae:	e8 1d fc ff ff       	call   80104fd0 <argint>
801053b3:	83 c4 10             	add    $0x10,%esp
801053b6:	85 c0                	test   %eax,%eax
801053b8:	78 5e                	js     80105418 <sys_read+0x78>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
801053ba:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
801053be:	77 58                	ja     80105418 <sys_read+0x78>
801053c0:	e8 5b ec ff ff       	call   80104020 <myproc>
801053c5:	8b 55 f4             	mov    -0xc(%ebp),%edx
801053c8:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
801053cc:	85 f6                	test   %esi,%esi
801053ce:	74 48                	je     80105418 <sys_read+0x78>
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
801053d0:	83 ec 08             	sub    $0x8,%esp
801053d3:	8d 45 f0             	lea    -0x10(%ebp),%eax
801053d6:	50                   	push   %eax
801053d7:	6a 02                	push   $0x2
801053d9:	e8 f2 fb ff ff       	call   80104fd0 <argint>
801053de:	83 c4 10             	add    $0x10,%esp
801053e1:	85 c0                	test   %eax,%eax
801053e3:	78 33                	js     80105418 <sys_read+0x78>
801053e5:	83 ec 04             	sub    $0x4,%esp
801053e8:	ff 75 f0             	push   -0x10(%ebp)
801053eb:	53                   	push   %ebx
801053ec:	6a 01                	push   $0x1
801053ee:	e8 2d fc ff ff       	call   80105020 <argptr>
801053f3:	83 c4 10             	add    $0x10,%esp
801053f6:	85 c0                	test   %eax,%eax
801053f8:	78 1e                	js     80105418 <sys_read+0x78>
  return fileread(f, p, n);
801053fa:	83 ec 04             	sub    $0x4,%esp
801053fd:	ff 75 f0             	push   -0x10(%ebp)
80105400:	ff 75 f4             	push   -0xc(%ebp)
80105403:	56                   	push   %esi
80105404:	e8 c7 c2 ff ff       	call   801016d0 <fileread>
80105409:	83 c4 10             	add    $0x10,%esp
}
8010540c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010540f:	5b                   	pop    %ebx
80105410:	5e                   	pop    %esi
80105411:	5d                   	pop    %ebp
80105412:	c3                   	ret    
80105413:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105417:	90                   	nop
    return -1;
80105418:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010541d:	eb ed                	jmp    8010540c <sys_read+0x6c>
8010541f:	90                   	nop

80105420 <sys_write>:
{
80105420:	55                   	push   %ebp
80105421:	89 e5                	mov    %esp,%ebp
80105423:	56                   	push   %esi
80105424:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80105425:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
80105428:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
8010542b:	53                   	push   %ebx
8010542c:	6a 00                	push   $0x0
8010542e:	e8 9d fb ff ff       	call   80104fd0 <argint>
80105433:	83 c4 10             	add    $0x10,%esp
80105436:	85 c0                	test   %eax,%eax
80105438:	78 5e                	js     80105498 <sys_write+0x78>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
8010543a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
8010543e:	77 58                	ja     80105498 <sys_write+0x78>
80105440:	e8 db eb ff ff       	call   80104020 <myproc>
80105445:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105448:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
8010544c:	85 f6                	test   %esi,%esi
8010544e:	74 48                	je     80105498 <sys_write+0x78>
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105450:	83 ec 08             	sub    $0x8,%esp
80105453:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105456:	50                   	push   %eax
80105457:	6a 02                	push   $0x2
80105459:	e8 72 fb ff ff       	call   80104fd0 <argint>
8010545e:	83 c4 10             	add    $0x10,%esp
80105461:	85 c0                	test   %eax,%eax
80105463:	78 33                	js     80105498 <sys_write+0x78>
80105465:	83 ec 04             	sub    $0x4,%esp
80105468:	ff 75 f0             	push   -0x10(%ebp)
8010546b:	53                   	push   %ebx
8010546c:	6a 01                	push   $0x1
8010546e:	e8 ad fb ff ff       	call   80105020 <argptr>
80105473:	83 c4 10             	add    $0x10,%esp
80105476:	85 c0                	test   %eax,%eax
80105478:	78 1e                	js     80105498 <sys_write+0x78>
  return filewrite(f, p, n);
8010547a:	83 ec 04             	sub    $0x4,%esp
8010547d:	ff 75 f0             	push   -0x10(%ebp)
80105480:	ff 75 f4             	push   -0xc(%ebp)
80105483:	56                   	push   %esi
80105484:	e8 d7 c2 ff ff       	call   80101760 <filewrite>
80105489:	83 c4 10             	add    $0x10,%esp
}
8010548c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010548f:	5b                   	pop    %ebx
80105490:	5e                   	pop    %esi
80105491:	5d                   	pop    %ebp
80105492:	c3                   	ret    
80105493:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105497:	90                   	nop
    return -1;
80105498:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010549d:	eb ed                	jmp    8010548c <sys_write+0x6c>
8010549f:	90                   	nop

801054a0 <sys_close>:
{
801054a0:	55                   	push   %ebp
801054a1:	89 e5                	mov    %esp,%ebp
801054a3:	56                   	push   %esi
801054a4:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
801054a5:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
801054a8:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
801054ab:	50                   	push   %eax
801054ac:	6a 00                	push   $0x0
801054ae:	e8 1d fb ff ff       	call   80104fd0 <argint>
801054b3:	83 c4 10             	add    $0x10,%esp
801054b6:	85 c0                	test   %eax,%eax
801054b8:	78 3e                	js     801054f8 <sys_close+0x58>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
801054ba:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
801054be:	77 38                	ja     801054f8 <sys_close+0x58>
801054c0:	e8 5b eb ff ff       	call   80104020 <myproc>
801054c5:	8b 55 f4             	mov    -0xc(%ebp),%edx
801054c8:	8d 5a 08             	lea    0x8(%edx),%ebx
801054cb:	8b 74 98 08          	mov    0x8(%eax,%ebx,4),%esi
801054cf:	85 f6                	test   %esi,%esi
801054d1:	74 25                	je     801054f8 <sys_close+0x58>
  myproc()->ofile[fd] = 0;
801054d3:	e8 48 eb ff ff       	call   80104020 <myproc>
  fileclose(f);
801054d8:	83 ec 0c             	sub    $0xc,%esp
  myproc()->ofile[fd] = 0;
801054db:	c7 44 98 08 00 00 00 	movl   $0x0,0x8(%eax,%ebx,4)
801054e2:	00 
  fileclose(f);
801054e3:	56                   	push   %esi
801054e4:	e8 b7 c0 ff ff       	call   801015a0 <fileclose>
  return 0;
801054e9:	83 c4 10             	add    $0x10,%esp
801054ec:	31 c0                	xor    %eax,%eax
}
801054ee:	8d 65 f8             	lea    -0x8(%ebp),%esp
801054f1:	5b                   	pop    %ebx
801054f2:	5e                   	pop    %esi
801054f3:	5d                   	pop    %ebp
801054f4:	c3                   	ret    
801054f5:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
801054f8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801054fd:	eb ef                	jmp    801054ee <sys_close+0x4e>
801054ff:	90                   	nop

80105500 <sys_fstat>:
{
80105500:	55                   	push   %ebp
80105501:	89 e5                	mov    %esp,%ebp
80105503:	56                   	push   %esi
80105504:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80105505:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
80105508:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
8010550b:	53                   	push   %ebx
8010550c:	6a 00                	push   $0x0
8010550e:	e8 bd fa ff ff       	call   80104fd0 <argint>
80105513:	83 c4 10             	add    $0x10,%esp
80105516:	85 c0                	test   %eax,%eax
80105518:	78 46                	js     80105560 <sys_fstat+0x60>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
8010551a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
8010551e:	77 40                	ja     80105560 <sys_fstat+0x60>
80105520:	e8 fb ea ff ff       	call   80104020 <myproc>
80105525:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105528:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
8010552c:	85 f6                	test   %esi,%esi
8010552e:	74 30                	je     80105560 <sys_fstat+0x60>
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80105530:	83 ec 04             	sub    $0x4,%esp
80105533:	6a 14                	push   $0x14
80105535:	53                   	push   %ebx
80105536:	6a 01                	push   $0x1
80105538:	e8 e3 fa ff ff       	call   80105020 <argptr>
8010553d:	83 c4 10             	add    $0x10,%esp
80105540:	85 c0                	test   %eax,%eax
80105542:	78 1c                	js     80105560 <sys_fstat+0x60>
  return filestat(f, st);
80105544:	83 ec 08             	sub    $0x8,%esp
80105547:	ff 75 f4             	push   -0xc(%ebp)
8010554a:	56                   	push   %esi
8010554b:	e8 30 c1 ff ff       	call   80101680 <filestat>
80105550:	83 c4 10             	add    $0x10,%esp
}
80105553:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105556:	5b                   	pop    %ebx
80105557:	5e                   	pop    %esi
80105558:	5d                   	pop    %ebp
80105559:	c3                   	ret    
8010555a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80105560:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105565:	eb ec                	jmp    80105553 <sys_fstat+0x53>
80105567:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010556e:	66 90                	xchg   %ax,%ax

80105570 <sys_link>:
{
80105570:	55                   	push   %ebp
80105571:	89 e5                	mov    %esp,%ebp
80105573:	57                   	push   %edi
80105574:	56                   	push   %esi
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80105575:	8d 45 d4             	lea    -0x2c(%ebp),%eax
{
80105578:	53                   	push   %ebx
80105579:	83 ec 34             	sub    $0x34,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
8010557c:	50                   	push   %eax
8010557d:	6a 00                	push   $0x0
8010557f:	e8 0c fb ff ff       	call   80105090 <argstr>
80105584:	83 c4 10             	add    $0x10,%esp
80105587:	85 c0                	test   %eax,%eax
80105589:	0f 88 fb 00 00 00    	js     8010568a <sys_link+0x11a>
8010558f:	83 ec 08             	sub    $0x8,%esp
80105592:	8d 45 d0             	lea    -0x30(%ebp),%eax
80105595:	50                   	push   %eax
80105596:	6a 01                	push   $0x1
80105598:	e8 f3 fa ff ff       	call   80105090 <argstr>
8010559d:	83 c4 10             	add    $0x10,%esp
801055a0:	85 c0                	test   %eax,%eax
801055a2:	0f 88 e2 00 00 00    	js     8010568a <sys_link+0x11a>
  begin_op();
801055a8:	e8 63 de ff ff       	call   80103410 <begin_op>
  if((ip = namei(old)) == 0){
801055ad:	83 ec 0c             	sub    $0xc,%esp
801055b0:	ff 75 d4             	push   -0x2c(%ebp)
801055b3:	e8 98 d1 ff ff       	call   80102750 <namei>
801055b8:	83 c4 10             	add    $0x10,%esp
801055bb:	89 c3                	mov    %eax,%ebx
801055bd:	85 c0                	test   %eax,%eax
801055bf:	0f 84 e4 00 00 00    	je     801056a9 <sys_link+0x139>
  ilock(ip);
801055c5:	83 ec 0c             	sub    $0xc,%esp
801055c8:	50                   	push   %eax
801055c9:	e8 62 c8 ff ff       	call   80101e30 <ilock>
  if(ip->type == T_DIR){
801055ce:	83 c4 10             	add    $0x10,%esp
801055d1:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801055d6:	0f 84 b5 00 00 00    	je     80105691 <sys_link+0x121>
  iupdate(ip);
801055dc:	83 ec 0c             	sub    $0xc,%esp
  ip->nlink++;
801055df:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  if((dp = nameiparent(new, name)) == 0)
801055e4:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
801055e7:	53                   	push   %ebx
801055e8:	e8 93 c7 ff ff       	call   80101d80 <iupdate>
  iunlock(ip);
801055ed:	89 1c 24             	mov    %ebx,(%esp)
801055f0:	e8 1b c9 ff ff       	call   80101f10 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
801055f5:	58                   	pop    %eax
801055f6:	5a                   	pop    %edx
801055f7:	57                   	push   %edi
801055f8:	ff 75 d0             	push   -0x30(%ebp)
801055fb:	e8 70 d1 ff ff       	call   80102770 <nameiparent>
80105600:	83 c4 10             	add    $0x10,%esp
80105603:	89 c6                	mov    %eax,%esi
80105605:	85 c0                	test   %eax,%eax
80105607:	74 5b                	je     80105664 <sys_link+0xf4>
  ilock(dp);
80105609:	83 ec 0c             	sub    $0xc,%esp
8010560c:	50                   	push   %eax
8010560d:	e8 1e c8 ff ff       	call   80101e30 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80105612:	8b 03                	mov    (%ebx),%eax
80105614:	83 c4 10             	add    $0x10,%esp
80105617:	39 06                	cmp    %eax,(%esi)
80105619:	75 3d                	jne    80105658 <sys_link+0xe8>
8010561b:	83 ec 04             	sub    $0x4,%esp
8010561e:	ff 73 04             	push   0x4(%ebx)
80105621:	57                   	push   %edi
80105622:	56                   	push   %esi
80105623:	e8 68 d0 ff ff       	call   80102690 <dirlink>
80105628:	83 c4 10             	add    $0x10,%esp
8010562b:	85 c0                	test   %eax,%eax
8010562d:	78 29                	js     80105658 <sys_link+0xe8>
  iunlockput(dp);
8010562f:	83 ec 0c             	sub    $0xc,%esp
80105632:	56                   	push   %esi
80105633:	e8 88 ca ff ff       	call   801020c0 <iunlockput>
  iput(ip);
80105638:	89 1c 24             	mov    %ebx,(%esp)
8010563b:	e8 20 c9 ff ff       	call   80101f60 <iput>
  end_op();
80105640:	e8 3b de ff ff       	call   80103480 <end_op>
  return 0;
80105645:	83 c4 10             	add    $0x10,%esp
80105648:	31 c0                	xor    %eax,%eax
}
8010564a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010564d:	5b                   	pop    %ebx
8010564e:	5e                   	pop    %esi
8010564f:	5f                   	pop    %edi
80105650:	5d                   	pop    %ebp
80105651:	c3                   	ret    
80105652:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(dp);
80105658:	83 ec 0c             	sub    $0xc,%esp
8010565b:	56                   	push   %esi
8010565c:	e8 5f ca ff ff       	call   801020c0 <iunlockput>
    goto bad;
80105661:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
80105664:	83 ec 0c             	sub    $0xc,%esp
80105667:	53                   	push   %ebx
80105668:	e8 c3 c7 ff ff       	call   80101e30 <ilock>
  ip->nlink--;
8010566d:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80105672:	89 1c 24             	mov    %ebx,(%esp)
80105675:	e8 06 c7 ff ff       	call   80101d80 <iupdate>
  iunlockput(ip);
8010567a:	89 1c 24             	mov    %ebx,(%esp)
8010567d:	e8 3e ca ff ff       	call   801020c0 <iunlockput>
  end_op();
80105682:	e8 f9 dd ff ff       	call   80103480 <end_op>
  return -1;
80105687:	83 c4 10             	add    $0x10,%esp
8010568a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010568f:	eb b9                	jmp    8010564a <sys_link+0xda>
    iunlockput(ip);
80105691:	83 ec 0c             	sub    $0xc,%esp
80105694:	53                   	push   %ebx
80105695:	e8 26 ca ff ff       	call   801020c0 <iunlockput>
    end_op();
8010569a:	e8 e1 dd ff ff       	call   80103480 <end_op>
    return -1;
8010569f:	83 c4 10             	add    $0x10,%esp
801056a2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801056a7:	eb a1                	jmp    8010564a <sys_link+0xda>
    end_op();
801056a9:	e8 d2 dd ff ff       	call   80103480 <end_op>
    return -1;
801056ae:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801056b3:	eb 95                	jmp    8010564a <sys_link+0xda>
801056b5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801056bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801056c0 <sys_unlink>:
{
801056c0:	55                   	push   %ebp
801056c1:	89 e5                	mov    %esp,%ebp
801056c3:	57                   	push   %edi
801056c4:	56                   	push   %esi
  if(argstr(0, &path) < 0)
801056c5:	8d 45 c0             	lea    -0x40(%ebp),%eax
{
801056c8:	53                   	push   %ebx
801056c9:	83 ec 54             	sub    $0x54,%esp
  if(argstr(0, &path) < 0)
801056cc:	50                   	push   %eax
801056cd:	6a 00                	push   $0x0
801056cf:	e8 bc f9 ff ff       	call   80105090 <argstr>
801056d4:	83 c4 10             	add    $0x10,%esp
801056d7:	85 c0                	test   %eax,%eax
801056d9:	0f 88 7a 01 00 00    	js     80105859 <sys_unlink+0x199>
  begin_op();
801056df:	e8 2c dd ff ff       	call   80103410 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
801056e4:	8d 5d ca             	lea    -0x36(%ebp),%ebx
801056e7:	83 ec 08             	sub    $0x8,%esp
801056ea:	53                   	push   %ebx
801056eb:	ff 75 c0             	push   -0x40(%ebp)
801056ee:	e8 7d d0 ff ff       	call   80102770 <nameiparent>
801056f3:	83 c4 10             	add    $0x10,%esp
801056f6:	89 45 b4             	mov    %eax,-0x4c(%ebp)
801056f9:	85 c0                	test   %eax,%eax
801056fb:	0f 84 62 01 00 00    	je     80105863 <sys_unlink+0x1a3>
  ilock(dp);
80105701:	8b 7d b4             	mov    -0x4c(%ebp),%edi
80105704:	83 ec 0c             	sub    $0xc,%esp
80105707:	57                   	push   %edi
80105708:	e8 23 c7 ff ff       	call   80101e30 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
8010570d:	58                   	pop    %eax
8010570e:	5a                   	pop    %edx
8010570f:	68 d4 7f 10 80       	push   $0x80107fd4
80105714:	53                   	push   %ebx
80105715:	e8 56 cc ff ff       	call   80102370 <namecmp>
8010571a:	83 c4 10             	add    $0x10,%esp
8010571d:	85 c0                	test   %eax,%eax
8010571f:	0f 84 fb 00 00 00    	je     80105820 <sys_unlink+0x160>
80105725:	83 ec 08             	sub    $0x8,%esp
80105728:	68 d3 7f 10 80       	push   $0x80107fd3
8010572d:	53                   	push   %ebx
8010572e:	e8 3d cc ff ff       	call   80102370 <namecmp>
80105733:	83 c4 10             	add    $0x10,%esp
80105736:	85 c0                	test   %eax,%eax
80105738:	0f 84 e2 00 00 00    	je     80105820 <sys_unlink+0x160>
  if((ip = dirlookup(dp, name, &off)) == 0)
8010573e:	83 ec 04             	sub    $0x4,%esp
80105741:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80105744:	50                   	push   %eax
80105745:	53                   	push   %ebx
80105746:	57                   	push   %edi
80105747:	e8 44 cc ff ff       	call   80102390 <dirlookup>
8010574c:	83 c4 10             	add    $0x10,%esp
8010574f:	89 c3                	mov    %eax,%ebx
80105751:	85 c0                	test   %eax,%eax
80105753:	0f 84 c7 00 00 00    	je     80105820 <sys_unlink+0x160>
  ilock(ip);
80105759:	83 ec 0c             	sub    $0xc,%esp
8010575c:	50                   	push   %eax
8010575d:	e8 ce c6 ff ff       	call   80101e30 <ilock>
  if(ip->nlink < 1)
80105762:	83 c4 10             	add    $0x10,%esp
80105765:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
8010576a:	0f 8e 1c 01 00 00    	jle    8010588c <sys_unlink+0x1cc>
  if(ip->type == T_DIR && !isdirempty(ip)){
80105770:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105775:	8d 7d d8             	lea    -0x28(%ebp),%edi
80105778:	74 66                	je     801057e0 <sys_unlink+0x120>
  memset(&de, 0, sizeof(de));
8010577a:	83 ec 04             	sub    $0x4,%esp
8010577d:	6a 10                	push   $0x10
8010577f:	6a 00                	push   $0x0
80105781:	57                   	push   %edi
80105782:	e8 89 f5 ff ff       	call   80104d10 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105787:	6a 10                	push   $0x10
80105789:	ff 75 c4             	push   -0x3c(%ebp)
8010578c:	57                   	push   %edi
8010578d:	ff 75 b4             	push   -0x4c(%ebp)
80105790:	e8 ab ca ff ff       	call   80102240 <writei>
80105795:	83 c4 20             	add    $0x20,%esp
80105798:	83 f8 10             	cmp    $0x10,%eax
8010579b:	0f 85 de 00 00 00    	jne    8010587f <sys_unlink+0x1bf>
  if(ip->type == T_DIR){
801057a1:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801057a6:	0f 84 94 00 00 00    	je     80105840 <sys_unlink+0x180>
  iunlockput(dp);
801057ac:	83 ec 0c             	sub    $0xc,%esp
801057af:	ff 75 b4             	push   -0x4c(%ebp)
801057b2:	e8 09 c9 ff ff       	call   801020c0 <iunlockput>
  ip->nlink--;
801057b7:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
801057bc:	89 1c 24             	mov    %ebx,(%esp)
801057bf:	e8 bc c5 ff ff       	call   80101d80 <iupdate>
  iunlockput(ip);
801057c4:	89 1c 24             	mov    %ebx,(%esp)
801057c7:	e8 f4 c8 ff ff       	call   801020c0 <iunlockput>
  end_op();
801057cc:	e8 af dc ff ff       	call   80103480 <end_op>
  return 0;
801057d1:	83 c4 10             	add    $0x10,%esp
801057d4:	31 c0                	xor    %eax,%eax
}
801057d6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801057d9:	5b                   	pop    %ebx
801057da:	5e                   	pop    %esi
801057db:	5f                   	pop    %edi
801057dc:	5d                   	pop    %ebp
801057dd:	c3                   	ret    
801057de:	66 90                	xchg   %ax,%ax
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
801057e0:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
801057e4:	76 94                	jbe    8010577a <sys_unlink+0xba>
801057e6:	be 20 00 00 00       	mov    $0x20,%esi
801057eb:	eb 0b                	jmp    801057f8 <sys_unlink+0x138>
801057ed:	8d 76 00             	lea    0x0(%esi),%esi
801057f0:	83 c6 10             	add    $0x10,%esi
801057f3:	3b 73 58             	cmp    0x58(%ebx),%esi
801057f6:	73 82                	jae    8010577a <sys_unlink+0xba>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801057f8:	6a 10                	push   $0x10
801057fa:	56                   	push   %esi
801057fb:	57                   	push   %edi
801057fc:	53                   	push   %ebx
801057fd:	e8 3e c9 ff ff       	call   80102140 <readi>
80105802:	83 c4 10             	add    $0x10,%esp
80105805:	83 f8 10             	cmp    $0x10,%eax
80105808:	75 68                	jne    80105872 <sys_unlink+0x1b2>
    if(de.inum != 0)
8010580a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
8010580f:	74 df                	je     801057f0 <sys_unlink+0x130>
    iunlockput(ip);
80105811:	83 ec 0c             	sub    $0xc,%esp
80105814:	53                   	push   %ebx
80105815:	e8 a6 c8 ff ff       	call   801020c0 <iunlockput>
    goto bad;
8010581a:	83 c4 10             	add    $0x10,%esp
8010581d:	8d 76 00             	lea    0x0(%esi),%esi
  iunlockput(dp);
80105820:	83 ec 0c             	sub    $0xc,%esp
80105823:	ff 75 b4             	push   -0x4c(%ebp)
80105826:	e8 95 c8 ff ff       	call   801020c0 <iunlockput>
  end_op();
8010582b:	e8 50 dc ff ff       	call   80103480 <end_op>
  return -1;
80105830:	83 c4 10             	add    $0x10,%esp
80105833:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105838:	eb 9c                	jmp    801057d6 <sys_unlink+0x116>
8010583a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    dp->nlink--;
80105840:	8b 45 b4             	mov    -0x4c(%ebp),%eax
    iupdate(dp);
80105843:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink--;
80105846:	66 83 68 56 01       	subw   $0x1,0x56(%eax)
    iupdate(dp);
8010584b:	50                   	push   %eax
8010584c:	e8 2f c5 ff ff       	call   80101d80 <iupdate>
80105851:	83 c4 10             	add    $0x10,%esp
80105854:	e9 53 ff ff ff       	jmp    801057ac <sys_unlink+0xec>
    return -1;
80105859:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010585e:	e9 73 ff ff ff       	jmp    801057d6 <sys_unlink+0x116>
    end_op();
80105863:	e8 18 dc ff ff       	call   80103480 <end_op>
    return -1;
80105868:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010586d:	e9 64 ff ff ff       	jmp    801057d6 <sys_unlink+0x116>
      panic("isdirempty: readi");
80105872:	83 ec 0c             	sub    $0xc,%esp
80105875:	68 f8 7f 10 80       	push   $0x80107ff8
8010587a:	e8 21 ab ff ff       	call   801003a0 <panic>
    panic("unlink: writei");
8010587f:	83 ec 0c             	sub    $0xc,%esp
80105882:	68 0a 80 10 80       	push   $0x8010800a
80105887:	e8 14 ab ff ff       	call   801003a0 <panic>
    panic("unlink: nlink < 1");
8010588c:	83 ec 0c             	sub    $0xc,%esp
8010588f:	68 e6 7f 10 80       	push   $0x80107fe6
80105894:	e8 07 ab ff ff       	call   801003a0 <panic>
80105899:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801058a0 <sys_open>:

int
sys_open(void)
{
801058a0:	55                   	push   %ebp
801058a1:	89 e5                	mov    %esp,%ebp
801058a3:	57                   	push   %edi
801058a4:	56                   	push   %esi
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
801058a5:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
801058a8:	53                   	push   %ebx
801058a9:	83 ec 24             	sub    $0x24,%esp
  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
801058ac:	50                   	push   %eax
801058ad:	6a 00                	push   $0x0
801058af:	e8 dc f7 ff ff       	call   80105090 <argstr>
801058b4:	83 c4 10             	add    $0x10,%esp
801058b7:	85 c0                	test   %eax,%eax
801058b9:	0f 88 8e 00 00 00    	js     8010594d <sys_open+0xad>
801058bf:	83 ec 08             	sub    $0x8,%esp
801058c2:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801058c5:	50                   	push   %eax
801058c6:	6a 01                	push   $0x1
801058c8:	e8 03 f7 ff ff       	call   80104fd0 <argint>
801058cd:	83 c4 10             	add    $0x10,%esp
801058d0:	85 c0                	test   %eax,%eax
801058d2:	78 79                	js     8010594d <sys_open+0xad>
    return -1;

  begin_op();
801058d4:	e8 37 db ff ff       	call   80103410 <begin_op>

  if(omode & O_CREATE){
801058d9:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
801058dd:	75 79                	jne    80105958 <sys_open+0xb8>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
801058df:	83 ec 0c             	sub    $0xc,%esp
801058e2:	ff 75 e0             	push   -0x20(%ebp)
801058e5:	e8 66 ce ff ff       	call   80102750 <namei>
801058ea:	83 c4 10             	add    $0x10,%esp
801058ed:	89 c6                	mov    %eax,%esi
801058ef:	85 c0                	test   %eax,%eax
801058f1:	0f 84 7e 00 00 00    	je     80105975 <sys_open+0xd5>
      end_op();
      return -1;
    }
    ilock(ip);
801058f7:	83 ec 0c             	sub    $0xc,%esp
801058fa:	50                   	push   %eax
801058fb:	e8 30 c5 ff ff       	call   80101e30 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
80105900:	83 c4 10             	add    $0x10,%esp
80105903:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80105908:	0f 84 c2 00 00 00    	je     801059d0 <sys_open+0x130>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
8010590e:	e8 cd bb ff ff       	call   801014e0 <filealloc>
80105913:	89 c7                	mov    %eax,%edi
80105915:	85 c0                	test   %eax,%eax
80105917:	74 23                	je     8010593c <sys_open+0x9c>
  struct proc *curproc = myproc();
80105919:	e8 02 e7 ff ff       	call   80104020 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
8010591e:	31 db                	xor    %ebx,%ebx
    if(curproc->ofile[fd] == 0){
80105920:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105924:	85 d2                	test   %edx,%edx
80105926:	74 60                	je     80105988 <sys_open+0xe8>
  for(fd = 0; fd < NOFILE; fd++){
80105928:	83 c3 01             	add    $0x1,%ebx
8010592b:	83 fb 10             	cmp    $0x10,%ebx
8010592e:	75 f0                	jne    80105920 <sys_open+0x80>
    if(f)
      fileclose(f);
80105930:	83 ec 0c             	sub    $0xc,%esp
80105933:	57                   	push   %edi
80105934:	e8 67 bc ff ff       	call   801015a0 <fileclose>
80105939:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
8010593c:	83 ec 0c             	sub    $0xc,%esp
8010593f:	56                   	push   %esi
80105940:	e8 7b c7 ff ff       	call   801020c0 <iunlockput>
    end_op();
80105945:	e8 36 db ff ff       	call   80103480 <end_op>
    return -1;
8010594a:	83 c4 10             	add    $0x10,%esp
8010594d:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105952:	eb 6d                	jmp    801059c1 <sys_open+0x121>
80105954:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ip = create(path, T_FILE, 0, 0);
80105958:	83 ec 0c             	sub    $0xc,%esp
8010595b:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010595e:	31 c9                	xor    %ecx,%ecx
80105960:	ba 02 00 00 00       	mov    $0x2,%edx
80105965:	6a 00                	push   $0x0
80105967:	e8 14 f8 ff ff       	call   80105180 <create>
    if(ip == 0){
8010596c:	83 c4 10             	add    $0x10,%esp
    ip = create(path, T_FILE, 0, 0);
8010596f:	89 c6                	mov    %eax,%esi
    if(ip == 0){
80105971:	85 c0                	test   %eax,%eax
80105973:	75 99                	jne    8010590e <sys_open+0x6e>
      end_op();
80105975:	e8 06 db ff ff       	call   80103480 <end_op>
      return -1;
8010597a:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
8010597f:	eb 40                	jmp    801059c1 <sys_open+0x121>
80105981:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  }
  iunlock(ip);
80105988:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
8010598b:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
  iunlock(ip);
8010598f:	56                   	push   %esi
80105990:	e8 7b c5 ff ff       	call   80101f10 <iunlock>
  end_op();
80105995:	e8 e6 da ff ff       	call   80103480 <end_op>

  f->type = FD_INODE;
8010599a:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
801059a0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801059a3:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
801059a6:	89 77 10             	mov    %esi,0x10(%edi)
  f->readable = !(omode & O_WRONLY);
801059a9:	89 d0                	mov    %edx,%eax
  f->off = 0;
801059ab:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
801059b2:	f7 d0                	not    %eax
801059b4:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801059b7:	83 e2 03             	and    $0x3,%edx
  f->readable = !(omode & O_WRONLY);
801059ba:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801059bd:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
}
801059c1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801059c4:	89 d8                	mov    %ebx,%eax
801059c6:	5b                   	pop    %ebx
801059c7:	5e                   	pop    %esi
801059c8:	5f                   	pop    %edi
801059c9:	5d                   	pop    %ebp
801059ca:	c3                   	ret    
801059cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801059cf:	90                   	nop
    if(ip->type == T_DIR && omode != O_RDONLY){
801059d0:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801059d3:	85 c9                	test   %ecx,%ecx
801059d5:	0f 84 33 ff ff ff    	je     8010590e <sys_open+0x6e>
801059db:	e9 5c ff ff ff       	jmp    8010593c <sys_open+0x9c>

801059e0 <sys_mkdir>:

int
sys_mkdir(void)
{
801059e0:	55                   	push   %ebp
801059e1:	89 e5                	mov    %esp,%ebp
801059e3:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
801059e6:	e8 25 da ff ff       	call   80103410 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
801059eb:	83 ec 08             	sub    $0x8,%esp
801059ee:	8d 45 f4             	lea    -0xc(%ebp),%eax
801059f1:	50                   	push   %eax
801059f2:	6a 00                	push   $0x0
801059f4:	e8 97 f6 ff ff       	call   80105090 <argstr>
801059f9:	83 c4 10             	add    $0x10,%esp
801059fc:	85 c0                	test   %eax,%eax
801059fe:	78 30                	js     80105a30 <sys_mkdir+0x50>
80105a00:	83 ec 0c             	sub    $0xc,%esp
80105a03:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105a06:	31 c9                	xor    %ecx,%ecx
80105a08:	ba 01 00 00 00       	mov    $0x1,%edx
80105a0d:	6a 00                	push   $0x0
80105a0f:	e8 6c f7 ff ff       	call   80105180 <create>
80105a14:	83 c4 10             	add    $0x10,%esp
80105a17:	85 c0                	test   %eax,%eax
80105a19:	74 15                	je     80105a30 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
80105a1b:	83 ec 0c             	sub    $0xc,%esp
80105a1e:	50                   	push   %eax
80105a1f:	e8 9c c6 ff ff       	call   801020c0 <iunlockput>
  end_op();
80105a24:	e8 57 da ff ff       	call   80103480 <end_op>
  return 0;
80105a29:	83 c4 10             	add    $0x10,%esp
80105a2c:	31 c0                	xor    %eax,%eax
}
80105a2e:	c9                   	leave  
80105a2f:	c3                   	ret    
    end_op();
80105a30:	e8 4b da ff ff       	call   80103480 <end_op>
    return -1;
80105a35:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105a3a:	c9                   	leave  
80105a3b:	c3                   	ret    
80105a3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105a40 <sys_mknod>:

int
sys_mknod(void)
{
80105a40:	55                   	push   %ebp
80105a41:	89 e5                	mov    %esp,%ebp
80105a43:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80105a46:	e8 c5 d9 ff ff       	call   80103410 <begin_op>
  if((argstr(0, &path)) < 0 ||
80105a4b:	83 ec 08             	sub    $0x8,%esp
80105a4e:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105a51:	50                   	push   %eax
80105a52:	6a 00                	push   $0x0
80105a54:	e8 37 f6 ff ff       	call   80105090 <argstr>
80105a59:	83 c4 10             	add    $0x10,%esp
80105a5c:	85 c0                	test   %eax,%eax
80105a5e:	78 60                	js     80105ac0 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
80105a60:	83 ec 08             	sub    $0x8,%esp
80105a63:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105a66:	50                   	push   %eax
80105a67:	6a 01                	push   $0x1
80105a69:	e8 62 f5 ff ff       	call   80104fd0 <argint>
  if((argstr(0, &path)) < 0 ||
80105a6e:	83 c4 10             	add    $0x10,%esp
80105a71:	85 c0                	test   %eax,%eax
80105a73:	78 4b                	js     80105ac0 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
80105a75:	83 ec 08             	sub    $0x8,%esp
80105a78:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105a7b:	50                   	push   %eax
80105a7c:	6a 02                	push   $0x2
80105a7e:	e8 4d f5 ff ff       	call   80104fd0 <argint>
     argint(1, &major) < 0 ||
80105a83:	83 c4 10             	add    $0x10,%esp
80105a86:	85 c0                	test   %eax,%eax
80105a88:	78 36                	js     80105ac0 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
80105a8a:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
80105a8e:	83 ec 0c             	sub    $0xc,%esp
80105a91:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
80105a95:	ba 03 00 00 00       	mov    $0x3,%edx
80105a9a:	50                   	push   %eax
80105a9b:	8b 45 ec             	mov    -0x14(%ebp),%eax
80105a9e:	e8 dd f6 ff ff       	call   80105180 <create>
     argint(2, &minor) < 0 ||
80105aa3:	83 c4 10             	add    $0x10,%esp
80105aa6:	85 c0                	test   %eax,%eax
80105aa8:	74 16                	je     80105ac0 <sys_mknod+0x80>
    end_op();
    return -1;
  }
  iunlockput(ip);
80105aaa:	83 ec 0c             	sub    $0xc,%esp
80105aad:	50                   	push   %eax
80105aae:	e8 0d c6 ff ff       	call   801020c0 <iunlockput>
  end_op();
80105ab3:	e8 c8 d9 ff ff       	call   80103480 <end_op>
  return 0;
80105ab8:	83 c4 10             	add    $0x10,%esp
80105abb:	31 c0                	xor    %eax,%eax
}
80105abd:	c9                   	leave  
80105abe:	c3                   	ret    
80105abf:	90                   	nop
    end_op();
80105ac0:	e8 bb d9 ff ff       	call   80103480 <end_op>
    return -1;
80105ac5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105aca:	c9                   	leave  
80105acb:	c3                   	ret    
80105acc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105ad0 <sys_chdir>:

int
sys_chdir(void)
{
80105ad0:	55                   	push   %ebp
80105ad1:	89 e5                	mov    %esp,%ebp
80105ad3:	56                   	push   %esi
80105ad4:	53                   	push   %ebx
80105ad5:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
80105ad8:	e8 43 e5 ff ff       	call   80104020 <myproc>
80105add:	89 c6                	mov    %eax,%esi
  
  begin_op();
80105adf:	e8 2c d9 ff ff       	call   80103410 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
80105ae4:	83 ec 08             	sub    $0x8,%esp
80105ae7:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105aea:	50                   	push   %eax
80105aeb:	6a 00                	push   $0x0
80105aed:	e8 9e f5 ff ff       	call   80105090 <argstr>
80105af2:	83 c4 10             	add    $0x10,%esp
80105af5:	85 c0                	test   %eax,%eax
80105af7:	78 77                	js     80105b70 <sys_chdir+0xa0>
80105af9:	83 ec 0c             	sub    $0xc,%esp
80105afc:	ff 75 f4             	push   -0xc(%ebp)
80105aff:	e8 4c cc ff ff       	call   80102750 <namei>
80105b04:	83 c4 10             	add    $0x10,%esp
80105b07:	89 c3                	mov    %eax,%ebx
80105b09:	85 c0                	test   %eax,%eax
80105b0b:	74 63                	je     80105b70 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
80105b0d:	83 ec 0c             	sub    $0xc,%esp
80105b10:	50                   	push   %eax
80105b11:	e8 1a c3 ff ff       	call   80101e30 <ilock>
  if(ip->type != T_DIR){
80105b16:	83 c4 10             	add    $0x10,%esp
80105b19:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105b1e:	75 30                	jne    80105b50 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105b20:	83 ec 0c             	sub    $0xc,%esp
80105b23:	53                   	push   %ebx
80105b24:	e8 e7 c3 ff ff       	call   80101f10 <iunlock>
  iput(curproc->cwd);
80105b29:	58                   	pop    %eax
80105b2a:	ff 76 68             	push   0x68(%esi)
80105b2d:	e8 2e c4 ff ff       	call   80101f60 <iput>
  end_op();
80105b32:	e8 49 d9 ff ff       	call   80103480 <end_op>
  curproc->cwd = ip;
80105b37:	89 5e 68             	mov    %ebx,0x68(%esi)
  return 0;
80105b3a:	83 c4 10             	add    $0x10,%esp
80105b3d:	31 c0                	xor    %eax,%eax
}
80105b3f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105b42:	5b                   	pop    %ebx
80105b43:	5e                   	pop    %esi
80105b44:	5d                   	pop    %ebp
80105b45:	c3                   	ret    
80105b46:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105b4d:	8d 76 00             	lea    0x0(%esi),%esi
    iunlockput(ip);
80105b50:	83 ec 0c             	sub    $0xc,%esp
80105b53:	53                   	push   %ebx
80105b54:	e8 67 c5 ff ff       	call   801020c0 <iunlockput>
    end_op();
80105b59:	e8 22 d9 ff ff       	call   80103480 <end_op>
    return -1;
80105b5e:	83 c4 10             	add    $0x10,%esp
80105b61:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105b66:	eb d7                	jmp    80105b3f <sys_chdir+0x6f>
80105b68:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105b6f:	90                   	nop
    end_op();
80105b70:	e8 0b d9 ff ff       	call   80103480 <end_op>
    return -1;
80105b75:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105b7a:	eb c3                	jmp    80105b3f <sys_chdir+0x6f>
80105b7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105b80 <sys_exec>:

int
sys_exec(void)
{
80105b80:	55                   	push   %ebp
80105b81:	89 e5                	mov    %esp,%ebp
80105b83:	57                   	push   %edi
80105b84:	56                   	push   %esi
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105b85:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
{
80105b8b:	53                   	push   %ebx
80105b8c:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105b92:	50                   	push   %eax
80105b93:	6a 00                	push   $0x0
80105b95:	e8 f6 f4 ff ff       	call   80105090 <argstr>
80105b9a:	83 c4 10             	add    $0x10,%esp
80105b9d:	85 c0                	test   %eax,%eax
80105b9f:	0f 88 87 00 00 00    	js     80105c2c <sys_exec+0xac>
80105ba5:	83 ec 08             	sub    $0x8,%esp
80105ba8:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
80105bae:	50                   	push   %eax
80105baf:	6a 01                	push   $0x1
80105bb1:	e8 1a f4 ff ff       	call   80104fd0 <argint>
80105bb6:	83 c4 10             	add    $0x10,%esp
80105bb9:	85 c0                	test   %eax,%eax
80105bbb:	78 6f                	js     80105c2c <sys_exec+0xac>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
80105bbd:	83 ec 04             	sub    $0x4,%esp
80105bc0:	8d b5 68 ff ff ff    	lea    -0x98(%ebp),%esi
  for(i=0;; i++){
80105bc6:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
80105bc8:	68 80 00 00 00       	push   $0x80
80105bcd:	6a 00                	push   $0x0
80105bcf:	56                   	push   %esi
80105bd0:	e8 3b f1 ff ff       	call   80104d10 <memset>
80105bd5:	83 c4 10             	add    $0x10,%esp
80105bd8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105bdf:	90                   	nop
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
80105be0:	83 ec 08             	sub    $0x8,%esp
80105be3:	8d 85 64 ff ff ff    	lea    -0x9c(%ebp),%eax
80105be9:	8d 3c 9d 00 00 00 00 	lea    0x0(,%ebx,4),%edi
80105bf0:	50                   	push   %eax
80105bf1:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
80105bf7:	01 f8                	add    %edi,%eax
80105bf9:	50                   	push   %eax
80105bfa:	e8 41 f3 ff ff       	call   80104f40 <fetchint>
80105bff:	83 c4 10             	add    $0x10,%esp
80105c02:	85 c0                	test   %eax,%eax
80105c04:	78 26                	js     80105c2c <sys_exec+0xac>
      return -1;
    if(uarg == 0){
80105c06:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80105c0c:	85 c0                	test   %eax,%eax
80105c0e:	74 30                	je     80105c40 <sys_exec+0xc0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
80105c10:	83 ec 08             	sub    $0x8,%esp
80105c13:	8d 14 3e             	lea    (%esi,%edi,1),%edx
80105c16:	52                   	push   %edx
80105c17:	50                   	push   %eax
80105c18:	e8 63 f3 ff ff       	call   80104f80 <fetchstr>
80105c1d:	83 c4 10             	add    $0x10,%esp
80105c20:	85 c0                	test   %eax,%eax
80105c22:	78 08                	js     80105c2c <sys_exec+0xac>
  for(i=0;; i++){
80105c24:	83 c3 01             	add    $0x1,%ebx
    if(i >= NELEM(argv))
80105c27:	83 fb 20             	cmp    $0x20,%ebx
80105c2a:	75 b4                	jne    80105be0 <sys_exec+0x60>
      return -1;
  }
  return exec(path, argv);
}
80105c2c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
80105c2f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105c34:	5b                   	pop    %ebx
80105c35:	5e                   	pop    %esi
80105c36:	5f                   	pop    %edi
80105c37:	5d                   	pop    %ebp
80105c38:	c3                   	ret    
80105c39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      argv[i] = 0;
80105c40:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
80105c47:	00 00 00 00 
  return exec(path, argv);
80105c4b:	83 ec 08             	sub    $0x8,%esp
80105c4e:	56                   	push   %esi
80105c4f:	ff b5 5c ff ff ff    	push   -0xa4(%ebp)
80105c55:	e8 06 b5 ff ff       	call   80101160 <exec>
80105c5a:	83 c4 10             	add    $0x10,%esp
}
80105c5d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105c60:	5b                   	pop    %ebx
80105c61:	5e                   	pop    %esi
80105c62:	5f                   	pop    %edi
80105c63:	5d                   	pop    %ebp
80105c64:	c3                   	ret    
80105c65:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105c6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105c70 <sys_pipe>:

int
sys_pipe(void)
{
80105c70:	55                   	push   %ebp
80105c71:	89 e5                	mov    %esp,%ebp
80105c73:	57                   	push   %edi
80105c74:	56                   	push   %esi
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105c75:	8d 45 dc             	lea    -0x24(%ebp),%eax
{
80105c78:	53                   	push   %ebx
80105c79:	83 ec 20             	sub    $0x20,%esp
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105c7c:	6a 08                	push   $0x8
80105c7e:	50                   	push   %eax
80105c7f:	6a 00                	push   $0x0
80105c81:	e8 9a f3 ff ff       	call   80105020 <argptr>
80105c86:	83 c4 10             	add    $0x10,%esp
80105c89:	85 c0                	test   %eax,%eax
80105c8b:	78 4a                	js     80105cd7 <sys_pipe+0x67>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
80105c8d:	83 ec 08             	sub    $0x8,%esp
80105c90:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105c93:	50                   	push   %eax
80105c94:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105c97:	50                   	push   %eax
80105c98:	e8 43 de ff ff       	call   80103ae0 <pipealloc>
80105c9d:	83 c4 10             	add    $0x10,%esp
80105ca0:	85 c0                	test   %eax,%eax
80105ca2:	78 33                	js     80105cd7 <sys_pipe+0x67>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105ca4:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(fd = 0; fd < NOFILE; fd++){
80105ca7:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
80105ca9:	e8 72 e3 ff ff       	call   80104020 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80105cae:	66 90                	xchg   %ax,%ax
    if(curproc->ofile[fd] == 0){
80105cb0:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
80105cb4:	85 f6                	test   %esi,%esi
80105cb6:	74 28                	je     80105ce0 <sys_pipe+0x70>
  for(fd = 0; fd < NOFILE; fd++){
80105cb8:	83 c3 01             	add    $0x1,%ebx
80105cbb:	83 fb 10             	cmp    $0x10,%ebx
80105cbe:	75 f0                	jne    80105cb0 <sys_pipe+0x40>
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
80105cc0:	83 ec 0c             	sub    $0xc,%esp
80105cc3:	ff 75 e0             	push   -0x20(%ebp)
80105cc6:	e8 d5 b8 ff ff       	call   801015a0 <fileclose>
    fileclose(wf);
80105ccb:	58                   	pop    %eax
80105ccc:	ff 75 e4             	push   -0x1c(%ebp)
80105ccf:	e8 cc b8 ff ff       	call   801015a0 <fileclose>
    return -1;
80105cd4:	83 c4 10             	add    $0x10,%esp
80105cd7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105cdc:	eb 53                	jmp    80105d31 <sys_pipe+0xc1>
80105cde:	66 90                	xchg   %ax,%ax
      curproc->ofile[fd] = f;
80105ce0:	8d 73 08             	lea    0x8(%ebx),%esi
80105ce3:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105ce7:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  struct proc *curproc = myproc();
80105cea:	e8 31 e3 ff ff       	call   80104020 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80105cef:	31 d2                	xor    %edx,%edx
80105cf1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[fd] == 0){
80105cf8:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
80105cfc:	85 c9                	test   %ecx,%ecx
80105cfe:	74 20                	je     80105d20 <sys_pipe+0xb0>
  for(fd = 0; fd < NOFILE; fd++){
80105d00:	83 c2 01             	add    $0x1,%edx
80105d03:	83 fa 10             	cmp    $0x10,%edx
80105d06:	75 f0                	jne    80105cf8 <sys_pipe+0x88>
      myproc()->ofile[fd0] = 0;
80105d08:	e8 13 e3 ff ff       	call   80104020 <myproc>
80105d0d:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
80105d14:	00 
80105d15:	eb a9                	jmp    80105cc0 <sys_pipe+0x50>
80105d17:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105d1e:	66 90                	xchg   %ax,%ax
      curproc->ofile[fd] = f;
80105d20:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
  }
  fd[0] = fd0;
80105d24:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105d27:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
80105d29:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105d2c:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
80105d2f:	31 c0                	xor    %eax,%eax
}
80105d31:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105d34:	5b                   	pop    %ebx
80105d35:	5e                   	pop    %esi
80105d36:	5f                   	pop    %edi
80105d37:	5d                   	pop    %ebp
80105d38:	c3                   	ret    
80105d39:	66 90                	xchg   %ax,%ax
80105d3b:	66 90                	xchg   %ax,%ax
80105d3d:	66 90                	xchg   %ax,%ax
80105d3f:	90                   	nop

80105d40 <sys_fork>:
#include "proc.h"

int
sys_fork(void)
{
  return fork();
80105d40:	e9 7b e4 ff ff       	jmp    801041c0 <fork>
80105d45:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105d4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105d50 <sys_exit>:
}

int
sys_exit(void)
{
80105d50:	55                   	push   %ebp
80105d51:	89 e5                	mov    %esp,%ebp
80105d53:	83 ec 08             	sub    $0x8,%esp
  exit();
80105d56:	e8 e5 e6 ff ff       	call   80104440 <exit>
  return 0;  // not reached
}
80105d5b:	31 c0                	xor    %eax,%eax
80105d5d:	c9                   	leave  
80105d5e:	c3                   	ret    
80105d5f:	90                   	nop

80105d60 <sys_wait>:

int
sys_wait(void)
{
  return wait();
80105d60:	e9 0b e8 ff ff       	jmp    80104570 <wait>
80105d65:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105d6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105d70 <sys_kill>:
}

int
sys_kill(void)
{
80105d70:	55                   	push   %ebp
80105d71:	89 e5                	mov    %esp,%ebp
80105d73:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
80105d76:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105d79:	50                   	push   %eax
80105d7a:	6a 00                	push   $0x0
80105d7c:	e8 4f f2 ff ff       	call   80104fd0 <argint>
80105d81:	83 c4 10             	add    $0x10,%esp
80105d84:	85 c0                	test   %eax,%eax
80105d86:	78 18                	js     80105da0 <sys_kill+0x30>
    return -1;
  return kill(pid);
80105d88:	83 ec 0c             	sub    $0xc,%esp
80105d8b:	ff 75 f4             	push   -0xc(%ebp)
80105d8e:	e8 7d ea ff ff       	call   80104810 <kill>
80105d93:	83 c4 10             	add    $0x10,%esp
}
80105d96:	c9                   	leave  
80105d97:	c3                   	ret    
80105d98:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105d9f:	90                   	nop
80105da0:	c9                   	leave  
    return -1;
80105da1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105da6:	c3                   	ret    
80105da7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105dae:	66 90                	xchg   %ax,%ax

80105db0 <sys_getpid>:

int
sys_getpid(void)
{
80105db0:	55                   	push   %ebp
80105db1:	89 e5                	mov    %esp,%ebp
80105db3:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
80105db6:	e8 65 e2 ff ff       	call   80104020 <myproc>
80105dbb:	8b 40 10             	mov    0x10(%eax),%eax
}
80105dbe:	c9                   	leave  
80105dbf:	c3                   	ret    

80105dc0 <sys_sbrk>:

int
sys_sbrk(void)
{
80105dc0:	55                   	push   %ebp
80105dc1:	89 e5                	mov    %esp,%ebp
80105dc3:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
80105dc4:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105dc7:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
80105dca:	50                   	push   %eax
80105dcb:	6a 00                	push   $0x0
80105dcd:	e8 fe f1 ff ff       	call   80104fd0 <argint>
80105dd2:	83 c4 10             	add    $0x10,%esp
80105dd5:	85 c0                	test   %eax,%eax
80105dd7:	78 27                	js     80105e00 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
80105dd9:	e8 42 e2 ff ff       	call   80104020 <myproc>
  if(growproc(n) < 0)
80105dde:	83 ec 0c             	sub    $0xc,%esp
  addr = myproc()->sz;
80105de1:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80105de3:	ff 75 f4             	push   -0xc(%ebp)
80105de6:	e8 55 e3 ff ff       	call   80104140 <growproc>
80105deb:	83 c4 10             	add    $0x10,%esp
80105dee:	85 c0                	test   %eax,%eax
80105df0:	78 0e                	js     80105e00 <sys_sbrk+0x40>
    return -1;
  return addr;
}
80105df2:	89 d8                	mov    %ebx,%eax
80105df4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105df7:	c9                   	leave  
80105df8:	c3                   	ret    
80105df9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105e00:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105e05:	eb eb                	jmp    80105df2 <sys_sbrk+0x32>
80105e07:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105e0e:	66 90                	xchg   %ax,%ax

80105e10 <sys_sleep>:

int
sys_sleep(void)
{
80105e10:	55                   	push   %ebp
80105e11:	89 e5                	mov    %esp,%ebp
80105e13:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80105e14:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105e17:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
80105e1a:	50                   	push   %eax
80105e1b:	6a 00                	push   $0x0
80105e1d:	e8 ae f1 ff ff       	call   80104fd0 <argint>
80105e22:	83 c4 10             	add    $0x10,%esp
80105e25:	85 c0                	test   %eax,%eax
80105e27:	0f 88 8a 00 00 00    	js     80105eb7 <sys_sleep+0xa7>
    return -1;
  acquire(&tickslock);
80105e2d:	83 ec 0c             	sub    $0xc,%esp
80105e30:	68 c0 58 11 80       	push   $0x801158c0
80105e35:	e8 16 ee ff ff       	call   80104c50 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
80105e3a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  ticks0 = ticks;
80105e3d:	8b 1d a0 58 11 80    	mov    0x801158a0,%ebx
  while(ticks - ticks0 < n){
80105e43:	83 c4 10             	add    $0x10,%esp
80105e46:	85 d2                	test   %edx,%edx
80105e48:	75 27                	jne    80105e71 <sys_sleep+0x61>
80105e4a:	eb 54                	jmp    80105ea0 <sys_sleep+0x90>
80105e4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80105e50:	83 ec 08             	sub    $0x8,%esp
80105e53:	68 c0 58 11 80       	push   $0x801158c0
80105e58:	68 a0 58 11 80       	push   $0x801158a0
80105e5d:	e8 8e e8 ff ff       	call   801046f0 <sleep>
  while(ticks - ticks0 < n){
80105e62:	a1 a0 58 11 80       	mov    0x801158a0,%eax
80105e67:	83 c4 10             	add    $0x10,%esp
80105e6a:	29 d8                	sub    %ebx,%eax
80105e6c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80105e6f:	73 2f                	jae    80105ea0 <sys_sleep+0x90>
    if(myproc()->killed){
80105e71:	e8 aa e1 ff ff       	call   80104020 <myproc>
80105e76:	8b 40 24             	mov    0x24(%eax),%eax
80105e79:	85 c0                	test   %eax,%eax
80105e7b:	74 d3                	je     80105e50 <sys_sleep+0x40>
      release(&tickslock);
80105e7d:	83 ec 0c             	sub    $0xc,%esp
80105e80:	68 c0 58 11 80       	push   $0x801158c0
80105e85:	e8 66 ed ff ff       	call   80104bf0 <release>
  }
  release(&tickslock);
  return 0;
}
80105e8a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
      return -1;
80105e8d:	83 c4 10             	add    $0x10,%esp
80105e90:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105e95:	c9                   	leave  
80105e96:	c3                   	ret    
80105e97:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105e9e:	66 90                	xchg   %ax,%ax
  release(&tickslock);
80105ea0:	83 ec 0c             	sub    $0xc,%esp
80105ea3:	68 c0 58 11 80       	push   $0x801158c0
80105ea8:	e8 43 ed ff ff       	call   80104bf0 <release>
  return 0;
80105ead:	83 c4 10             	add    $0x10,%esp
80105eb0:	31 c0                	xor    %eax,%eax
}
80105eb2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105eb5:	c9                   	leave  
80105eb6:	c3                   	ret    
    return -1;
80105eb7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105ebc:	eb f4                	jmp    80105eb2 <sys_sleep+0xa2>
80105ebe:	66 90                	xchg   %ax,%ax

80105ec0 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80105ec0:	55                   	push   %ebp
80105ec1:	89 e5                	mov    %esp,%ebp
80105ec3:	53                   	push   %ebx
80105ec4:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
80105ec7:	68 c0 58 11 80       	push   $0x801158c0
80105ecc:	e8 7f ed ff ff       	call   80104c50 <acquire>
  xticks = ticks;
80105ed1:	8b 1d a0 58 11 80    	mov    0x801158a0,%ebx
  release(&tickslock);
80105ed7:	c7 04 24 c0 58 11 80 	movl   $0x801158c0,(%esp)
80105ede:	e8 0d ed ff ff       	call   80104bf0 <release>
  return xticks;
}
80105ee3:	89 d8                	mov    %ebx,%eax
80105ee5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105ee8:	c9                   	leave  
80105ee9:	c3                   	ret    

80105eea <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
80105eea:	1e                   	push   %ds
  pushl %es
80105eeb:	06                   	push   %es
  pushl %fs
80105eec:	0f a0                	push   %fs
  pushl %gs
80105eee:	0f a8                	push   %gs
  pushal
80105ef0:	60                   	pusha  
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
80105ef1:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
80105ef5:	8e d8                	mov    %eax,%ds
  movw %ax, %es
80105ef7:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
80105ef9:	54                   	push   %esp
  call trap
80105efa:	e8 c1 00 00 00       	call   80105fc0 <trap>
  addl $4, %esp
80105eff:	83 c4 04             	add    $0x4,%esp

80105f02 <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
80105f02:	61                   	popa   
  popl %gs
80105f03:	0f a9                	pop    %gs
  popl %fs
80105f05:	0f a1                	pop    %fs
  popl %es
80105f07:	07                   	pop    %es
  popl %ds
80105f08:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
80105f09:	83 c4 08             	add    $0x8,%esp
  iret
80105f0c:	cf                   	iret   
80105f0d:	66 90                	xchg   %ax,%ax
80105f0f:	90                   	nop

80105f10 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80105f10:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
80105f11:	31 c0                	xor    %eax,%eax
{
80105f13:	89 e5                	mov    %esp,%ebp
80105f15:	83 ec 08             	sub    $0x8,%esp
80105f18:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105f1f:	90                   	nop
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80105f20:	8b 14 85 08 b0 10 80 	mov    -0x7fef4ff8(,%eax,4),%edx
80105f27:	c7 04 c5 02 59 11 80 	movl   $0x8e000008,-0x7feea6fe(,%eax,8)
80105f2e:	08 00 00 8e 
80105f32:	66 89 14 c5 00 59 11 	mov    %dx,-0x7feea700(,%eax,8)
80105f39:	80 
80105f3a:	c1 ea 10             	shr    $0x10,%edx
80105f3d:	66 89 14 c5 06 59 11 	mov    %dx,-0x7feea6fa(,%eax,8)
80105f44:	80 
  for(i = 0; i < 256; i++)
80105f45:	83 c0 01             	add    $0x1,%eax
80105f48:	3d 00 01 00 00       	cmp    $0x100,%eax
80105f4d:	75 d1                	jne    80105f20 <tvinit+0x10>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);

  initlock(&tickslock, "time");
80105f4f:	83 ec 08             	sub    $0x8,%esp
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105f52:	a1 08 b1 10 80       	mov    0x8010b108,%eax
80105f57:	c7 05 02 5b 11 80 08 	movl   $0xef000008,0x80115b02
80105f5e:	00 00 ef 
  initlock(&tickslock, "time");
80105f61:	68 19 80 10 80       	push   $0x80108019
80105f66:	68 c0 58 11 80       	push   $0x801158c0
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105f6b:	66 a3 00 5b 11 80    	mov    %ax,0x80115b00
80105f71:	c1 e8 10             	shr    $0x10,%eax
80105f74:	66 a3 06 5b 11 80    	mov    %ax,0x80115b06
  initlock(&tickslock, "time");
80105f7a:	e8 01 eb ff ff       	call   80104a80 <initlock>
}
80105f7f:	83 c4 10             	add    $0x10,%esp
80105f82:	c9                   	leave  
80105f83:	c3                   	ret    
80105f84:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105f8b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105f8f:	90                   	nop

80105f90 <idtinit>:

void
idtinit(void)
{
80105f90:	55                   	push   %ebp
  pd[0] = size-1;
80105f91:	b8 ff 07 00 00       	mov    $0x7ff,%eax
80105f96:	89 e5                	mov    %esp,%ebp
80105f98:	83 ec 10             	sub    $0x10,%esp
80105f9b:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
80105f9f:	b8 00 59 11 80       	mov    $0x80115900,%eax
80105fa4:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80105fa8:	c1 e8 10             	shr    $0x10,%eax
80105fab:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
80105faf:	8d 45 fa             	lea    -0x6(%ebp),%eax
80105fb2:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80105fb5:	c9                   	leave  
80105fb6:	c3                   	ret    
80105fb7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105fbe:	66 90                	xchg   %ax,%ax

80105fc0 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80105fc0:	55                   	push   %ebp
80105fc1:	89 e5                	mov    %esp,%ebp
80105fc3:	57                   	push   %edi
80105fc4:	56                   	push   %esi
80105fc5:	53                   	push   %ebx
80105fc6:	83 ec 1c             	sub    $0x1c,%esp
80105fc9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(tf->trapno == T_SYSCALL){
80105fcc:	8b 43 30             	mov    0x30(%ebx),%eax
80105fcf:	83 f8 40             	cmp    $0x40,%eax
80105fd2:	0f 84 68 01 00 00    	je     80106140 <trap+0x180>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
80105fd8:	83 e8 20             	sub    $0x20,%eax
80105fdb:	83 f8 1f             	cmp    $0x1f,%eax
80105fde:	0f 87 8c 00 00 00    	ja     80106070 <trap+0xb0>
80105fe4:	ff 24 85 c0 80 10 80 	jmp    *-0x7fef7f40(,%eax,4)
80105feb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105fef:	90                   	nop
      release(&tickslock);
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
80105ff0:	e8 fb c8 ff ff       	call   801028f0 <ideintr>
    lapiceoi();
80105ff5:	e8 c6 cf ff ff       	call   80102fc0 <lapiceoi>
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105ffa:	e8 21 e0 ff ff       	call   80104020 <myproc>
80105fff:	85 c0                	test   %eax,%eax
80106001:	74 1d                	je     80106020 <trap+0x60>
80106003:	e8 18 e0 ff ff       	call   80104020 <myproc>
80106008:	8b 50 24             	mov    0x24(%eax),%edx
8010600b:	85 d2                	test   %edx,%edx
8010600d:	74 11                	je     80106020 <trap+0x60>
8010600f:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80106013:	83 e0 03             	and    $0x3,%eax
80106016:	66 83 f8 03          	cmp    $0x3,%ax
8010601a:	0f 84 e8 01 00 00    	je     80106208 <trap+0x248>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80106020:	e8 fb df ff ff       	call   80104020 <myproc>
80106025:	85 c0                	test   %eax,%eax
80106027:	74 0f                	je     80106038 <trap+0x78>
80106029:	e8 f2 df ff ff       	call   80104020 <myproc>
8010602e:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80106032:	0f 84 b8 00 00 00    	je     801060f0 <trap+0x130>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106038:	e8 e3 df ff ff       	call   80104020 <myproc>
8010603d:	85 c0                	test   %eax,%eax
8010603f:	74 1d                	je     8010605e <trap+0x9e>
80106041:	e8 da df ff ff       	call   80104020 <myproc>
80106046:	8b 40 24             	mov    0x24(%eax),%eax
80106049:	85 c0                	test   %eax,%eax
8010604b:	74 11                	je     8010605e <trap+0x9e>
8010604d:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80106051:	83 e0 03             	and    $0x3,%eax
80106054:	66 83 f8 03          	cmp    $0x3,%ax
80106058:	0f 84 0f 01 00 00    	je     8010616d <trap+0x1ad>
    exit();
}
8010605e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106061:	5b                   	pop    %ebx
80106062:	5e                   	pop    %esi
80106063:	5f                   	pop    %edi
80106064:	5d                   	pop    %ebp
80106065:	c3                   	ret    
80106066:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010606d:	8d 76 00             	lea    0x0(%esi),%esi
    if(myproc() == 0 || (tf->cs&3) == 0){
80106070:	e8 ab df ff ff       	call   80104020 <myproc>
80106075:	8b 7b 38             	mov    0x38(%ebx),%edi
80106078:	85 c0                	test   %eax,%eax
8010607a:	0f 84 a2 01 00 00    	je     80106222 <trap+0x262>
80106080:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
80106084:	0f 84 98 01 00 00    	je     80106222 <trap+0x262>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
8010608a:	0f 20 d1             	mov    %cr2,%ecx
8010608d:	89 4d d8             	mov    %ecx,-0x28(%ebp)
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106090:	e8 6b df ff ff       	call   80104000 <cpuid>
80106095:	8b 73 30             	mov    0x30(%ebx),%esi
80106098:	89 45 dc             	mov    %eax,-0x24(%ebp)
8010609b:	8b 43 34             	mov    0x34(%ebx),%eax
8010609e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            myproc()->pid, myproc()->name, tf->trapno,
801060a1:	e8 7a df ff ff       	call   80104020 <myproc>
801060a6:	89 45 e0             	mov    %eax,-0x20(%ebp)
801060a9:	e8 72 df ff ff       	call   80104020 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801060ae:	8b 4d d8             	mov    -0x28(%ebp),%ecx
801060b1:	8b 55 dc             	mov    -0x24(%ebp),%edx
801060b4:	51                   	push   %ecx
801060b5:	57                   	push   %edi
801060b6:	52                   	push   %edx
801060b7:	ff 75 e4             	push   -0x1c(%ebp)
801060ba:	56                   	push   %esi
            myproc()->pid, myproc()->name, tf->trapno,
801060bb:	8b 75 e0             	mov    -0x20(%ebp),%esi
801060be:	83 c6 6c             	add    $0x6c,%esi
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801060c1:	56                   	push   %esi
801060c2:	ff 70 10             	push   0x10(%eax)
801060c5:	68 7c 80 10 80       	push   $0x8010807c
801060ca:	e8 81 a6 ff ff       	call   80100750 <cprintf>
    myproc()->killed = 1;
801060cf:	83 c4 20             	add    $0x20,%esp
801060d2:	e8 49 df ff ff       	call   80104020 <myproc>
801060d7:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801060de:	e8 3d df ff ff       	call   80104020 <myproc>
801060e3:	85 c0                	test   %eax,%eax
801060e5:	0f 85 18 ff ff ff    	jne    80106003 <trap+0x43>
801060eb:	e9 30 ff ff ff       	jmp    80106020 <trap+0x60>
  if(myproc() && myproc()->state == RUNNING &&
801060f0:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
801060f4:	0f 85 3e ff ff ff    	jne    80106038 <trap+0x78>
    yield();
801060fa:	e8 a1 e5 ff ff       	call   801046a0 <yield>
801060ff:	e9 34 ff ff ff       	jmp    80106038 <trap+0x78>
80106104:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80106108:	8b 7b 38             	mov    0x38(%ebx),%edi
8010610b:	0f b7 73 3c          	movzwl 0x3c(%ebx),%esi
8010610f:	e8 ec de ff ff       	call   80104000 <cpuid>
80106114:	57                   	push   %edi
80106115:	56                   	push   %esi
80106116:	50                   	push   %eax
80106117:	68 24 80 10 80       	push   $0x80108024
8010611c:	e8 2f a6 ff ff       	call   80100750 <cprintf>
    lapiceoi();
80106121:	e8 9a ce ff ff       	call   80102fc0 <lapiceoi>
    break;
80106126:	83 c4 10             	add    $0x10,%esp
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106129:	e8 f2 de ff ff       	call   80104020 <myproc>
8010612e:	85 c0                	test   %eax,%eax
80106130:	0f 85 cd fe ff ff    	jne    80106003 <trap+0x43>
80106136:	e9 e5 fe ff ff       	jmp    80106020 <trap+0x60>
8010613b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010613f:	90                   	nop
    if(myproc()->killed)
80106140:	e8 db de ff ff       	call   80104020 <myproc>
80106145:	8b 70 24             	mov    0x24(%eax),%esi
80106148:	85 f6                	test   %esi,%esi
8010614a:	0f 85 c8 00 00 00    	jne    80106218 <trap+0x258>
    myproc()->tf = tf;
80106150:	e8 cb de ff ff       	call   80104020 <myproc>
80106155:	89 58 18             	mov    %ebx,0x18(%eax)
    syscall();
80106158:	e8 b3 ef ff ff       	call   80105110 <syscall>
    if(myproc()->killed)
8010615d:	e8 be de ff ff       	call   80104020 <myproc>
80106162:	8b 48 24             	mov    0x24(%eax),%ecx
80106165:	85 c9                	test   %ecx,%ecx
80106167:	0f 84 f1 fe ff ff    	je     8010605e <trap+0x9e>
}
8010616d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106170:	5b                   	pop    %ebx
80106171:	5e                   	pop    %esi
80106172:	5f                   	pop    %edi
80106173:	5d                   	pop    %ebp
      exit();
80106174:	e9 c7 e2 ff ff       	jmp    80104440 <exit>
80106179:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    uartintr();
80106180:	e8 3b 02 00 00       	call   801063c0 <uartintr>
    lapiceoi();
80106185:	e8 36 ce ff ff       	call   80102fc0 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010618a:	e8 91 de ff ff       	call   80104020 <myproc>
8010618f:	85 c0                	test   %eax,%eax
80106191:	0f 85 6c fe ff ff    	jne    80106003 <trap+0x43>
80106197:	e9 84 fe ff ff       	jmp    80106020 <trap+0x60>
8010619c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    kbdintr();
801061a0:	e8 db cc ff ff       	call   80102e80 <kbdintr>
    lapiceoi();
801061a5:	e8 16 ce ff ff       	call   80102fc0 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801061aa:	e8 71 de ff ff       	call   80104020 <myproc>
801061af:	85 c0                	test   %eax,%eax
801061b1:	0f 85 4c fe ff ff    	jne    80106003 <trap+0x43>
801061b7:	e9 64 fe ff ff       	jmp    80106020 <trap+0x60>
801061bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(cpuid() == 0){
801061c0:	e8 3b de ff ff       	call   80104000 <cpuid>
801061c5:	85 c0                	test   %eax,%eax
801061c7:	0f 85 28 fe ff ff    	jne    80105ff5 <trap+0x35>
      acquire(&tickslock);
801061cd:	83 ec 0c             	sub    $0xc,%esp
801061d0:	68 c0 58 11 80       	push   $0x801158c0
801061d5:	e8 76 ea ff ff       	call   80104c50 <acquire>
      wakeup(&ticks);
801061da:	c7 04 24 a0 58 11 80 	movl   $0x801158a0,(%esp)
      ticks++;
801061e1:	83 05 a0 58 11 80 01 	addl   $0x1,0x801158a0
      wakeup(&ticks);
801061e8:	e8 c3 e5 ff ff       	call   801047b0 <wakeup>
      release(&tickslock);
801061ed:	c7 04 24 c0 58 11 80 	movl   $0x801158c0,(%esp)
801061f4:	e8 f7 e9 ff ff       	call   80104bf0 <release>
801061f9:	83 c4 10             	add    $0x10,%esp
    lapiceoi();
801061fc:	e9 f4 fd ff ff       	jmp    80105ff5 <trap+0x35>
80106201:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    exit();
80106208:	e8 33 e2 ff ff       	call   80104440 <exit>
8010620d:	e9 0e fe ff ff       	jmp    80106020 <trap+0x60>
80106212:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      exit();
80106218:	e8 23 e2 ff ff       	call   80104440 <exit>
8010621d:	e9 2e ff ff ff       	jmp    80106150 <trap+0x190>
80106222:	0f 20 d6             	mov    %cr2,%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80106225:	e8 d6 dd ff ff       	call   80104000 <cpuid>
8010622a:	83 ec 0c             	sub    $0xc,%esp
8010622d:	56                   	push   %esi
8010622e:	57                   	push   %edi
8010622f:	50                   	push   %eax
80106230:	ff 73 30             	push   0x30(%ebx)
80106233:	68 48 80 10 80       	push   $0x80108048
80106238:	e8 13 a5 ff ff       	call   80100750 <cprintf>
      panic("trap");
8010623d:	83 c4 14             	add    $0x14,%esp
80106240:	68 1e 80 10 80       	push   $0x8010801e
80106245:	e8 56 a1 ff ff       	call   801003a0 <panic>
8010624a:	66 90                	xchg   %ax,%ax
8010624c:	66 90                	xchg   %ax,%ax
8010624e:	66 90                	xchg   %ax,%ax

80106250 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80106250:	a1 00 61 11 80       	mov    0x80116100,%eax
80106255:	85 c0                	test   %eax,%eax
80106257:	74 17                	je     80106270 <uartgetc+0x20>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80106259:	ba fd 03 00 00       	mov    $0x3fd,%edx
8010625e:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
8010625f:	a8 01                	test   $0x1,%al
80106261:	74 0d                	je     80106270 <uartgetc+0x20>
80106263:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106268:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
80106269:	0f b6 c0             	movzbl %al,%eax
8010626c:	c3                   	ret    
8010626d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80106270:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106275:	c3                   	ret    
80106276:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010627d:	8d 76 00             	lea    0x0(%esi),%esi

80106280 <uartinit>:
{
80106280:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106281:	31 c9                	xor    %ecx,%ecx
80106283:	89 c8                	mov    %ecx,%eax
80106285:	89 e5                	mov    %esp,%ebp
80106287:	57                   	push   %edi
80106288:	bf fa 03 00 00       	mov    $0x3fa,%edi
8010628d:	56                   	push   %esi
8010628e:	89 fa                	mov    %edi,%edx
80106290:	53                   	push   %ebx
80106291:	83 ec 1c             	sub    $0x1c,%esp
80106294:	ee                   	out    %al,(%dx)
80106295:	be fb 03 00 00       	mov    $0x3fb,%esi
8010629a:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
8010629f:	89 f2                	mov    %esi,%edx
801062a1:	ee                   	out    %al,(%dx)
801062a2:	b8 0c 00 00 00       	mov    $0xc,%eax
801062a7:	ba f8 03 00 00       	mov    $0x3f8,%edx
801062ac:	ee                   	out    %al,(%dx)
801062ad:	bb f9 03 00 00       	mov    $0x3f9,%ebx
801062b2:	89 c8                	mov    %ecx,%eax
801062b4:	89 da                	mov    %ebx,%edx
801062b6:	ee                   	out    %al,(%dx)
801062b7:	b8 03 00 00 00       	mov    $0x3,%eax
801062bc:	89 f2                	mov    %esi,%edx
801062be:	ee                   	out    %al,(%dx)
801062bf:	ba fc 03 00 00       	mov    $0x3fc,%edx
801062c4:	89 c8                	mov    %ecx,%eax
801062c6:	ee                   	out    %al,(%dx)
801062c7:	b8 01 00 00 00       	mov    $0x1,%eax
801062cc:	89 da                	mov    %ebx,%edx
801062ce:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801062cf:	ba fd 03 00 00       	mov    $0x3fd,%edx
801062d4:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
801062d5:	3c ff                	cmp    $0xff,%al
801062d7:	74 78                	je     80106351 <uartinit+0xd1>
  uart = 1;
801062d9:	c7 05 00 61 11 80 01 	movl   $0x1,0x80116100
801062e0:	00 00 00 
801062e3:	89 fa                	mov    %edi,%edx
801062e5:	ec                   	in     (%dx),%al
801062e6:	ba f8 03 00 00       	mov    $0x3f8,%edx
801062eb:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
801062ec:	83 ec 08             	sub    $0x8,%esp
  for(p="xv6...\n"; *p; p++)
801062ef:	bf 40 81 10 80       	mov    $0x80108140,%edi
801062f4:	be fd 03 00 00       	mov    $0x3fd,%esi
  ioapicenable(IRQ_COM1, 0);
801062f9:	6a 00                	push   $0x0
801062fb:	6a 04                	push   $0x4
801062fd:	e8 2e c8 ff ff       	call   80102b30 <ioapicenable>
  for(p="xv6...\n"; *p; p++)
80106302:	c6 45 e7 78          	movb   $0x78,-0x19(%ebp)
  ioapicenable(IRQ_COM1, 0);
80106306:	83 c4 10             	add    $0x10,%esp
80106309:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(!uart)
80106310:	a1 00 61 11 80       	mov    0x80116100,%eax
80106315:	bb 80 00 00 00       	mov    $0x80,%ebx
8010631a:	85 c0                	test   %eax,%eax
8010631c:	75 14                	jne    80106332 <uartinit+0xb2>
8010631e:	eb 23                	jmp    80106343 <uartinit+0xc3>
    microdelay(10);
80106320:	83 ec 0c             	sub    $0xc,%esp
80106323:	6a 0a                	push   $0xa
80106325:	e8 b6 cc ff ff       	call   80102fe0 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
8010632a:	83 c4 10             	add    $0x10,%esp
8010632d:	83 eb 01             	sub    $0x1,%ebx
80106330:	74 07                	je     80106339 <uartinit+0xb9>
80106332:	89 f2                	mov    %esi,%edx
80106334:	ec                   	in     (%dx),%al
80106335:	a8 20                	test   $0x20,%al
80106337:	74 e7                	je     80106320 <uartinit+0xa0>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106339:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
8010633d:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106342:	ee                   	out    %al,(%dx)
  for(p="xv6...\n"; *p; p++)
80106343:	0f b6 47 01          	movzbl 0x1(%edi),%eax
80106347:	83 c7 01             	add    $0x1,%edi
8010634a:	88 45 e7             	mov    %al,-0x19(%ebp)
8010634d:	84 c0                	test   %al,%al
8010634f:	75 bf                	jne    80106310 <uartinit+0x90>
}
80106351:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106354:	5b                   	pop    %ebx
80106355:	5e                   	pop    %esi
80106356:	5f                   	pop    %edi
80106357:	5d                   	pop    %ebp
80106358:	c3                   	ret    
80106359:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106360 <uartputc>:
  if(!uart)
80106360:	a1 00 61 11 80       	mov    0x80116100,%eax
80106365:	85 c0                	test   %eax,%eax
80106367:	74 47                	je     801063b0 <uartputc+0x50>
{
80106369:	55                   	push   %ebp
8010636a:	89 e5                	mov    %esp,%ebp
8010636c:	56                   	push   %esi
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010636d:	be fd 03 00 00       	mov    $0x3fd,%esi
80106372:	53                   	push   %ebx
80106373:	bb 80 00 00 00       	mov    $0x80,%ebx
80106378:	eb 18                	jmp    80106392 <uartputc+0x32>
8010637a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    microdelay(10);
80106380:	83 ec 0c             	sub    $0xc,%esp
80106383:	6a 0a                	push   $0xa
80106385:	e8 56 cc ff ff       	call   80102fe0 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
8010638a:	83 c4 10             	add    $0x10,%esp
8010638d:	83 eb 01             	sub    $0x1,%ebx
80106390:	74 07                	je     80106399 <uartputc+0x39>
80106392:	89 f2                	mov    %esi,%edx
80106394:	ec                   	in     (%dx),%al
80106395:	a8 20                	test   $0x20,%al
80106397:	74 e7                	je     80106380 <uartputc+0x20>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106399:	8b 45 08             	mov    0x8(%ebp),%eax
8010639c:	ba f8 03 00 00       	mov    $0x3f8,%edx
801063a1:	ee                   	out    %al,(%dx)
}
801063a2:	8d 65 f8             	lea    -0x8(%ebp),%esp
801063a5:	5b                   	pop    %ebx
801063a6:	5e                   	pop    %esi
801063a7:	5d                   	pop    %ebp
801063a8:	c3                   	ret    
801063a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801063b0:	c3                   	ret    
801063b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801063b8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801063bf:	90                   	nop

801063c0 <uartintr>:

void
uartintr(void)
{
801063c0:	55                   	push   %ebp
801063c1:	89 e5                	mov    %esp,%ebp
801063c3:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
801063c6:	68 50 62 10 80       	push   $0x80106250
801063cb:	e8 a0 a9 ff ff       	call   80100d70 <consoleintr>
}
801063d0:	83 c4 10             	add    $0x10,%esp
801063d3:	c9                   	leave  
801063d4:	c3                   	ret    

801063d5 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
801063d5:	6a 00                	push   $0x0
  pushl $0
801063d7:	6a 00                	push   $0x0
  jmp alltraps
801063d9:	e9 0c fb ff ff       	jmp    80105eea <alltraps>

801063de <vector1>:
.globl vector1
vector1:
  pushl $0
801063de:	6a 00                	push   $0x0
  pushl $1
801063e0:	6a 01                	push   $0x1
  jmp alltraps
801063e2:	e9 03 fb ff ff       	jmp    80105eea <alltraps>

801063e7 <vector2>:
.globl vector2
vector2:
  pushl $0
801063e7:	6a 00                	push   $0x0
  pushl $2
801063e9:	6a 02                	push   $0x2
  jmp alltraps
801063eb:	e9 fa fa ff ff       	jmp    80105eea <alltraps>

801063f0 <vector3>:
.globl vector3
vector3:
  pushl $0
801063f0:	6a 00                	push   $0x0
  pushl $3
801063f2:	6a 03                	push   $0x3
  jmp alltraps
801063f4:	e9 f1 fa ff ff       	jmp    80105eea <alltraps>

801063f9 <vector4>:
.globl vector4
vector4:
  pushl $0
801063f9:	6a 00                	push   $0x0
  pushl $4
801063fb:	6a 04                	push   $0x4
  jmp alltraps
801063fd:	e9 e8 fa ff ff       	jmp    80105eea <alltraps>

80106402 <vector5>:
.globl vector5
vector5:
  pushl $0
80106402:	6a 00                	push   $0x0
  pushl $5
80106404:	6a 05                	push   $0x5
  jmp alltraps
80106406:	e9 df fa ff ff       	jmp    80105eea <alltraps>

8010640b <vector6>:
.globl vector6
vector6:
  pushl $0
8010640b:	6a 00                	push   $0x0
  pushl $6
8010640d:	6a 06                	push   $0x6
  jmp alltraps
8010640f:	e9 d6 fa ff ff       	jmp    80105eea <alltraps>

80106414 <vector7>:
.globl vector7
vector7:
  pushl $0
80106414:	6a 00                	push   $0x0
  pushl $7
80106416:	6a 07                	push   $0x7
  jmp alltraps
80106418:	e9 cd fa ff ff       	jmp    80105eea <alltraps>

8010641d <vector8>:
.globl vector8
vector8:
  pushl $8
8010641d:	6a 08                	push   $0x8
  jmp alltraps
8010641f:	e9 c6 fa ff ff       	jmp    80105eea <alltraps>

80106424 <vector9>:
.globl vector9
vector9:
  pushl $0
80106424:	6a 00                	push   $0x0
  pushl $9
80106426:	6a 09                	push   $0x9
  jmp alltraps
80106428:	e9 bd fa ff ff       	jmp    80105eea <alltraps>

8010642d <vector10>:
.globl vector10
vector10:
  pushl $10
8010642d:	6a 0a                	push   $0xa
  jmp alltraps
8010642f:	e9 b6 fa ff ff       	jmp    80105eea <alltraps>

80106434 <vector11>:
.globl vector11
vector11:
  pushl $11
80106434:	6a 0b                	push   $0xb
  jmp alltraps
80106436:	e9 af fa ff ff       	jmp    80105eea <alltraps>

8010643b <vector12>:
.globl vector12
vector12:
  pushl $12
8010643b:	6a 0c                	push   $0xc
  jmp alltraps
8010643d:	e9 a8 fa ff ff       	jmp    80105eea <alltraps>

80106442 <vector13>:
.globl vector13
vector13:
  pushl $13
80106442:	6a 0d                	push   $0xd
  jmp alltraps
80106444:	e9 a1 fa ff ff       	jmp    80105eea <alltraps>

80106449 <vector14>:
.globl vector14
vector14:
  pushl $14
80106449:	6a 0e                	push   $0xe
  jmp alltraps
8010644b:	e9 9a fa ff ff       	jmp    80105eea <alltraps>

80106450 <vector15>:
.globl vector15
vector15:
  pushl $0
80106450:	6a 00                	push   $0x0
  pushl $15
80106452:	6a 0f                	push   $0xf
  jmp alltraps
80106454:	e9 91 fa ff ff       	jmp    80105eea <alltraps>

80106459 <vector16>:
.globl vector16
vector16:
  pushl $0
80106459:	6a 00                	push   $0x0
  pushl $16
8010645b:	6a 10                	push   $0x10
  jmp alltraps
8010645d:	e9 88 fa ff ff       	jmp    80105eea <alltraps>

80106462 <vector17>:
.globl vector17
vector17:
  pushl $17
80106462:	6a 11                	push   $0x11
  jmp alltraps
80106464:	e9 81 fa ff ff       	jmp    80105eea <alltraps>

80106469 <vector18>:
.globl vector18
vector18:
  pushl $0
80106469:	6a 00                	push   $0x0
  pushl $18
8010646b:	6a 12                	push   $0x12
  jmp alltraps
8010646d:	e9 78 fa ff ff       	jmp    80105eea <alltraps>

80106472 <vector19>:
.globl vector19
vector19:
  pushl $0
80106472:	6a 00                	push   $0x0
  pushl $19
80106474:	6a 13                	push   $0x13
  jmp alltraps
80106476:	e9 6f fa ff ff       	jmp    80105eea <alltraps>

8010647b <vector20>:
.globl vector20
vector20:
  pushl $0
8010647b:	6a 00                	push   $0x0
  pushl $20
8010647d:	6a 14                	push   $0x14
  jmp alltraps
8010647f:	e9 66 fa ff ff       	jmp    80105eea <alltraps>

80106484 <vector21>:
.globl vector21
vector21:
  pushl $0
80106484:	6a 00                	push   $0x0
  pushl $21
80106486:	6a 15                	push   $0x15
  jmp alltraps
80106488:	e9 5d fa ff ff       	jmp    80105eea <alltraps>

8010648d <vector22>:
.globl vector22
vector22:
  pushl $0
8010648d:	6a 00                	push   $0x0
  pushl $22
8010648f:	6a 16                	push   $0x16
  jmp alltraps
80106491:	e9 54 fa ff ff       	jmp    80105eea <alltraps>

80106496 <vector23>:
.globl vector23
vector23:
  pushl $0
80106496:	6a 00                	push   $0x0
  pushl $23
80106498:	6a 17                	push   $0x17
  jmp alltraps
8010649a:	e9 4b fa ff ff       	jmp    80105eea <alltraps>

8010649f <vector24>:
.globl vector24
vector24:
  pushl $0
8010649f:	6a 00                	push   $0x0
  pushl $24
801064a1:	6a 18                	push   $0x18
  jmp alltraps
801064a3:	e9 42 fa ff ff       	jmp    80105eea <alltraps>

801064a8 <vector25>:
.globl vector25
vector25:
  pushl $0
801064a8:	6a 00                	push   $0x0
  pushl $25
801064aa:	6a 19                	push   $0x19
  jmp alltraps
801064ac:	e9 39 fa ff ff       	jmp    80105eea <alltraps>

801064b1 <vector26>:
.globl vector26
vector26:
  pushl $0
801064b1:	6a 00                	push   $0x0
  pushl $26
801064b3:	6a 1a                	push   $0x1a
  jmp alltraps
801064b5:	e9 30 fa ff ff       	jmp    80105eea <alltraps>

801064ba <vector27>:
.globl vector27
vector27:
  pushl $0
801064ba:	6a 00                	push   $0x0
  pushl $27
801064bc:	6a 1b                	push   $0x1b
  jmp alltraps
801064be:	e9 27 fa ff ff       	jmp    80105eea <alltraps>

801064c3 <vector28>:
.globl vector28
vector28:
  pushl $0
801064c3:	6a 00                	push   $0x0
  pushl $28
801064c5:	6a 1c                	push   $0x1c
  jmp alltraps
801064c7:	e9 1e fa ff ff       	jmp    80105eea <alltraps>

801064cc <vector29>:
.globl vector29
vector29:
  pushl $0
801064cc:	6a 00                	push   $0x0
  pushl $29
801064ce:	6a 1d                	push   $0x1d
  jmp alltraps
801064d0:	e9 15 fa ff ff       	jmp    80105eea <alltraps>

801064d5 <vector30>:
.globl vector30
vector30:
  pushl $0
801064d5:	6a 00                	push   $0x0
  pushl $30
801064d7:	6a 1e                	push   $0x1e
  jmp alltraps
801064d9:	e9 0c fa ff ff       	jmp    80105eea <alltraps>

801064de <vector31>:
.globl vector31
vector31:
  pushl $0
801064de:	6a 00                	push   $0x0
  pushl $31
801064e0:	6a 1f                	push   $0x1f
  jmp alltraps
801064e2:	e9 03 fa ff ff       	jmp    80105eea <alltraps>

801064e7 <vector32>:
.globl vector32
vector32:
  pushl $0
801064e7:	6a 00                	push   $0x0
  pushl $32
801064e9:	6a 20                	push   $0x20
  jmp alltraps
801064eb:	e9 fa f9 ff ff       	jmp    80105eea <alltraps>

801064f0 <vector33>:
.globl vector33
vector33:
  pushl $0
801064f0:	6a 00                	push   $0x0
  pushl $33
801064f2:	6a 21                	push   $0x21
  jmp alltraps
801064f4:	e9 f1 f9 ff ff       	jmp    80105eea <alltraps>

801064f9 <vector34>:
.globl vector34
vector34:
  pushl $0
801064f9:	6a 00                	push   $0x0
  pushl $34
801064fb:	6a 22                	push   $0x22
  jmp alltraps
801064fd:	e9 e8 f9 ff ff       	jmp    80105eea <alltraps>

80106502 <vector35>:
.globl vector35
vector35:
  pushl $0
80106502:	6a 00                	push   $0x0
  pushl $35
80106504:	6a 23                	push   $0x23
  jmp alltraps
80106506:	e9 df f9 ff ff       	jmp    80105eea <alltraps>

8010650b <vector36>:
.globl vector36
vector36:
  pushl $0
8010650b:	6a 00                	push   $0x0
  pushl $36
8010650d:	6a 24                	push   $0x24
  jmp alltraps
8010650f:	e9 d6 f9 ff ff       	jmp    80105eea <alltraps>

80106514 <vector37>:
.globl vector37
vector37:
  pushl $0
80106514:	6a 00                	push   $0x0
  pushl $37
80106516:	6a 25                	push   $0x25
  jmp alltraps
80106518:	e9 cd f9 ff ff       	jmp    80105eea <alltraps>

8010651d <vector38>:
.globl vector38
vector38:
  pushl $0
8010651d:	6a 00                	push   $0x0
  pushl $38
8010651f:	6a 26                	push   $0x26
  jmp alltraps
80106521:	e9 c4 f9 ff ff       	jmp    80105eea <alltraps>

80106526 <vector39>:
.globl vector39
vector39:
  pushl $0
80106526:	6a 00                	push   $0x0
  pushl $39
80106528:	6a 27                	push   $0x27
  jmp alltraps
8010652a:	e9 bb f9 ff ff       	jmp    80105eea <alltraps>

8010652f <vector40>:
.globl vector40
vector40:
  pushl $0
8010652f:	6a 00                	push   $0x0
  pushl $40
80106531:	6a 28                	push   $0x28
  jmp alltraps
80106533:	e9 b2 f9 ff ff       	jmp    80105eea <alltraps>

80106538 <vector41>:
.globl vector41
vector41:
  pushl $0
80106538:	6a 00                	push   $0x0
  pushl $41
8010653a:	6a 29                	push   $0x29
  jmp alltraps
8010653c:	e9 a9 f9 ff ff       	jmp    80105eea <alltraps>

80106541 <vector42>:
.globl vector42
vector42:
  pushl $0
80106541:	6a 00                	push   $0x0
  pushl $42
80106543:	6a 2a                	push   $0x2a
  jmp alltraps
80106545:	e9 a0 f9 ff ff       	jmp    80105eea <alltraps>

8010654a <vector43>:
.globl vector43
vector43:
  pushl $0
8010654a:	6a 00                	push   $0x0
  pushl $43
8010654c:	6a 2b                	push   $0x2b
  jmp alltraps
8010654e:	e9 97 f9 ff ff       	jmp    80105eea <alltraps>

80106553 <vector44>:
.globl vector44
vector44:
  pushl $0
80106553:	6a 00                	push   $0x0
  pushl $44
80106555:	6a 2c                	push   $0x2c
  jmp alltraps
80106557:	e9 8e f9 ff ff       	jmp    80105eea <alltraps>

8010655c <vector45>:
.globl vector45
vector45:
  pushl $0
8010655c:	6a 00                	push   $0x0
  pushl $45
8010655e:	6a 2d                	push   $0x2d
  jmp alltraps
80106560:	e9 85 f9 ff ff       	jmp    80105eea <alltraps>

80106565 <vector46>:
.globl vector46
vector46:
  pushl $0
80106565:	6a 00                	push   $0x0
  pushl $46
80106567:	6a 2e                	push   $0x2e
  jmp alltraps
80106569:	e9 7c f9 ff ff       	jmp    80105eea <alltraps>

8010656e <vector47>:
.globl vector47
vector47:
  pushl $0
8010656e:	6a 00                	push   $0x0
  pushl $47
80106570:	6a 2f                	push   $0x2f
  jmp alltraps
80106572:	e9 73 f9 ff ff       	jmp    80105eea <alltraps>

80106577 <vector48>:
.globl vector48
vector48:
  pushl $0
80106577:	6a 00                	push   $0x0
  pushl $48
80106579:	6a 30                	push   $0x30
  jmp alltraps
8010657b:	e9 6a f9 ff ff       	jmp    80105eea <alltraps>

80106580 <vector49>:
.globl vector49
vector49:
  pushl $0
80106580:	6a 00                	push   $0x0
  pushl $49
80106582:	6a 31                	push   $0x31
  jmp alltraps
80106584:	e9 61 f9 ff ff       	jmp    80105eea <alltraps>

80106589 <vector50>:
.globl vector50
vector50:
  pushl $0
80106589:	6a 00                	push   $0x0
  pushl $50
8010658b:	6a 32                	push   $0x32
  jmp alltraps
8010658d:	e9 58 f9 ff ff       	jmp    80105eea <alltraps>

80106592 <vector51>:
.globl vector51
vector51:
  pushl $0
80106592:	6a 00                	push   $0x0
  pushl $51
80106594:	6a 33                	push   $0x33
  jmp alltraps
80106596:	e9 4f f9 ff ff       	jmp    80105eea <alltraps>

8010659b <vector52>:
.globl vector52
vector52:
  pushl $0
8010659b:	6a 00                	push   $0x0
  pushl $52
8010659d:	6a 34                	push   $0x34
  jmp alltraps
8010659f:	e9 46 f9 ff ff       	jmp    80105eea <alltraps>

801065a4 <vector53>:
.globl vector53
vector53:
  pushl $0
801065a4:	6a 00                	push   $0x0
  pushl $53
801065a6:	6a 35                	push   $0x35
  jmp alltraps
801065a8:	e9 3d f9 ff ff       	jmp    80105eea <alltraps>

801065ad <vector54>:
.globl vector54
vector54:
  pushl $0
801065ad:	6a 00                	push   $0x0
  pushl $54
801065af:	6a 36                	push   $0x36
  jmp alltraps
801065b1:	e9 34 f9 ff ff       	jmp    80105eea <alltraps>

801065b6 <vector55>:
.globl vector55
vector55:
  pushl $0
801065b6:	6a 00                	push   $0x0
  pushl $55
801065b8:	6a 37                	push   $0x37
  jmp alltraps
801065ba:	e9 2b f9 ff ff       	jmp    80105eea <alltraps>

801065bf <vector56>:
.globl vector56
vector56:
  pushl $0
801065bf:	6a 00                	push   $0x0
  pushl $56
801065c1:	6a 38                	push   $0x38
  jmp alltraps
801065c3:	e9 22 f9 ff ff       	jmp    80105eea <alltraps>

801065c8 <vector57>:
.globl vector57
vector57:
  pushl $0
801065c8:	6a 00                	push   $0x0
  pushl $57
801065ca:	6a 39                	push   $0x39
  jmp alltraps
801065cc:	e9 19 f9 ff ff       	jmp    80105eea <alltraps>

801065d1 <vector58>:
.globl vector58
vector58:
  pushl $0
801065d1:	6a 00                	push   $0x0
  pushl $58
801065d3:	6a 3a                	push   $0x3a
  jmp alltraps
801065d5:	e9 10 f9 ff ff       	jmp    80105eea <alltraps>

801065da <vector59>:
.globl vector59
vector59:
  pushl $0
801065da:	6a 00                	push   $0x0
  pushl $59
801065dc:	6a 3b                	push   $0x3b
  jmp alltraps
801065de:	e9 07 f9 ff ff       	jmp    80105eea <alltraps>

801065e3 <vector60>:
.globl vector60
vector60:
  pushl $0
801065e3:	6a 00                	push   $0x0
  pushl $60
801065e5:	6a 3c                	push   $0x3c
  jmp alltraps
801065e7:	e9 fe f8 ff ff       	jmp    80105eea <alltraps>

801065ec <vector61>:
.globl vector61
vector61:
  pushl $0
801065ec:	6a 00                	push   $0x0
  pushl $61
801065ee:	6a 3d                	push   $0x3d
  jmp alltraps
801065f0:	e9 f5 f8 ff ff       	jmp    80105eea <alltraps>

801065f5 <vector62>:
.globl vector62
vector62:
  pushl $0
801065f5:	6a 00                	push   $0x0
  pushl $62
801065f7:	6a 3e                	push   $0x3e
  jmp alltraps
801065f9:	e9 ec f8 ff ff       	jmp    80105eea <alltraps>

801065fe <vector63>:
.globl vector63
vector63:
  pushl $0
801065fe:	6a 00                	push   $0x0
  pushl $63
80106600:	6a 3f                	push   $0x3f
  jmp alltraps
80106602:	e9 e3 f8 ff ff       	jmp    80105eea <alltraps>

80106607 <vector64>:
.globl vector64
vector64:
  pushl $0
80106607:	6a 00                	push   $0x0
  pushl $64
80106609:	6a 40                	push   $0x40
  jmp alltraps
8010660b:	e9 da f8 ff ff       	jmp    80105eea <alltraps>

80106610 <vector65>:
.globl vector65
vector65:
  pushl $0
80106610:	6a 00                	push   $0x0
  pushl $65
80106612:	6a 41                	push   $0x41
  jmp alltraps
80106614:	e9 d1 f8 ff ff       	jmp    80105eea <alltraps>

80106619 <vector66>:
.globl vector66
vector66:
  pushl $0
80106619:	6a 00                	push   $0x0
  pushl $66
8010661b:	6a 42                	push   $0x42
  jmp alltraps
8010661d:	e9 c8 f8 ff ff       	jmp    80105eea <alltraps>

80106622 <vector67>:
.globl vector67
vector67:
  pushl $0
80106622:	6a 00                	push   $0x0
  pushl $67
80106624:	6a 43                	push   $0x43
  jmp alltraps
80106626:	e9 bf f8 ff ff       	jmp    80105eea <alltraps>

8010662b <vector68>:
.globl vector68
vector68:
  pushl $0
8010662b:	6a 00                	push   $0x0
  pushl $68
8010662d:	6a 44                	push   $0x44
  jmp alltraps
8010662f:	e9 b6 f8 ff ff       	jmp    80105eea <alltraps>

80106634 <vector69>:
.globl vector69
vector69:
  pushl $0
80106634:	6a 00                	push   $0x0
  pushl $69
80106636:	6a 45                	push   $0x45
  jmp alltraps
80106638:	e9 ad f8 ff ff       	jmp    80105eea <alltraps>

8010663d <vector70>:
.globl vector70
vector70:
  pushl $0
8010663d:	6a 00                	push   $0x0
  pushl $70
8010663f:	6a 46                	push   $0x46
  jmp alltraps
80106641:	e9 a4 f8 ff ff       	jmp    80105eea <alltraps>

80106646 <vector71>:
.globl vector71
vector71:
  pushl $0
80106646:	6a 00                	push   $0x0
  pushl $71
80106648:	6a 47                	push   $0x47
  jmp alltraps
8010664a:	e9 9b f8 ff ff       	jmp    80105eea <alltraps>

8010664f <vector72>:
.globl vector72
vector72:
  pushl $0
8010664f:	6a 00                	push   $0x0
  pushl $72
80106651:	6a 48                	push   $0x48
  jmp alltraps
80106653:	e9 92 f8 ff ff       	jmp    80105eea <alltraps>

80106658 <vector73>:
.globl vector73
vector73:
  pushl $0
80106658:	6a 00                	push   $0x0
  pushl $73
8010665a:	6a 49                	push   $0x49
  jmp alltraps
8010665c:	e9 89 f8 ff ff       	jmp    80105eea <alltraps>

80106661 <vector74>:
.globl vector74
vector74:
  pushl $0
80106661:	6a 00                	push   $0x0
  pushl $74
80106663:	6a 4a                	push   $0x4a
  jmp alltraps
80106665:	e9 80 f8 ff ff       	jmp    80105eea <alltraps>

8010666a <vector75>:
.globl vector75
vector75:
  pushl $0
8010666a:	6a 00                	push   $0x0
  pushl $75
8010666c:	6a 4b                	push   $0x4b
  jmp alltraps
8010666e:	e9 77 f8 ff ff       	jmp    80105eea <alltraps>

80106673 <vector76>:
.globl vector76
vector76:
  pushl $0
80106673:	6a 00                	push   $0x0
  pushl $76
80106675:	6a 4c                	push   $0x4c
  jmp alltraps
80106677:	e9 6e f8 ff ff       	jmp    80105eea <alltraps>

8010667c <vector77>:
.globl vector77
vector77:
  pushl $0
8010667c:	6a 00                	push   $0x0
  pushl $77
8010667e:	6a 4d                	push   $0x4d
  jmp alltraps
80106680:	e9 65 f8 ff ff       	jmp    80105eea <alltraps>

80106685 <vector78>:
.globl vector78
vector78:
  pushl $0
80106685:	6a 00                	push   $0x0
  pushl $78
80106687:	6a 4e                	push   $0x4e
  jmp alltraps
80106689:	e9 5c f8 ff ff       	jmp    80105eea <alltraps>

8010668e <vector79>:
.globl vector79
vector79:
  pushl $0
8010668e:	6a 00                	push   $0x0
  pushl $79
80106690:	6a 4f                	push   $0x4f
  jmp alltraps
80106692:	e9 53 f8 ff ff       	jmp    80105eea <alltraps>

80106697 <vector80>:
.globl vector80
vector80:
  pushl $0
80106697:	6a 00                	push   $0x0
  pushl $80
80106699:	6a 50                	push   $0x50
  jmp alltraps
8010669b:	e9 4a f8 ff ff       	jmp    80105eea <alltraps>

801066a0 <vector81>:
.globl vector81
vector81:
  pushl $0
801066a0:	6a 00                	push   $0x0
  pushl $81
801066a2:	6a 51                	push   $0x51
  jmp alltraps
801066a4:	e9 41 f8 ff ff       	jmp    80105eea <alltraps>

801066a9 <vector82>:
.globl vector82
vector82:
  pushl $0
801066a9:	6a 00                	push   $0x0
  pushl $82
801066ab:	6a 52                	push   $0x52
  jmp alltraps
801066ad:	e9 38 f8 ff ff       	jmp    80105eea <alltraps>

801066b2 <vector83>:
.globl vector83
vector83:
  pushl $0
801066b2:	6a 00                	push   $0x0
  pushl $83
801066b4:	6a 53                	push   $0x53
  jmp alltraps
801066b6:	e9 2f f8 ff ff       	jmp    80105eea <alltraps>

801066bb <vector84>:
.globl vector84
vector84:
  pushl $0
801066bb:	6a 00                	push   $0x0
  pushl $84
801066bd:	6a 54                	push   $0x54
  jmp alltraps
801066bf:	e9 26 f8 ff ff       	jmp    80105eea <alltraps>

801066c4 <vector85>:
.globl vector85
vector85:
  pushl $0
801066c4:	6a 00                	push   $0x0
  pushl $85
801066c6:	6a 55                	push   $0x55
  jmp alltraps
801066c8:	e9 1d f8 ff ff       	jmp    80105eea <alltraps>

801066cd <vector86>:
.globl vector86
vector86:
  pushl $0
801066cd:	6a 00                	push   $0x0
  pushl $86
801066cf:	6a 56                	push   $0x56
  jmp alltraps
801066d1:	e9 14 f8 ff ff       	jmp    80105eea <alltraps>

801066d6 <vector87>:
.globl vector87
vector87:
  pushl $0
801066d6:	6a 00                	push   $0x0
  pushl $87
801066d8:	6a 57                	push   $0x57
  jmp alltraps
801066da:	e9 0b f8 ff ff       	jmp    80105eea <alltraps>

801066df <vector88>:
.globl vector88
vector88:
  pushl $0
801066df:	6a 00                	push   $0x0
  pushl $88
801066e1:	6a 58                	push   $0x58
  jmp alltraps
801066e3:	e9 02 f8 ff ff       	jmp    80105eea <alltraps>

801066e8 <vector89>:
.globl vector89
vector89:
  pushl $0
801066e8:	6a 00                	push   $0x0
  pushl $89
801066ea:	6a 59                	push   $0x59
  jmp alltraps
801066ec:	e9 f9 f7 ff ff       	jmp    80105eea <alltraps>

801066f1 <vector90>:
.globl vector90
vector90:
  pushl $0
801066f1:	6a 00                	push   $0x0
  pushl $90
801066f3:	6a 5a                	push   $0x5a
  jmp alltraps
801066f5:	e9 f0 f7 ff ff       	jmp    80105eea <alltraps>

801066fa <vector91>:
.globl vector91
vector91:
  pushl $0
801066fa:	6a 00                	push   $0x0
  pushl $91
801066fc:	6a 5b                	push   $0x5b
  jmp alltraps
801066fe:	e9 e7 f7 ff ff       	jmp    80105eea <alltraps>

80106703 <vector92>:
.globl vector92
vector92:
  pushl $0
80106703:	6a 00                	push   $0x0
  pushl $92
80106705:	6a 5c                	push   $0x5c
  jmp alltraps
80106707:	e9 de f7 ff ff       	jmp    80105eea <alltraps>

8010670c <vector93>:
.globl vector93
vector93:
  pushl $0
8010670c:	6a 00                	push   $0x0
  pushl $93
8010670e:	6a 5d                	push   $0x5d
  jmp alltraps
80106710:	e9 d5 f7 ff ff       	jmp    80105eea <alltraps>

80106715 <vector94>:
.globl vector94
vector94:
  pushl $0
80106715:	6a 00                	push   $0x0
  pushl $94
80106717:	6a 5e                	push   $0x5e
  jmp alltraps
80106719:	e9 cc f7 ff ff       	jmp    80105eea <alltraps>

8010671e <vector95>:
.globl vector95
vector95:
  pushl $0
8010671e:	6a 00                	push   $0x0
  pushl $95
80106720:	6a 5f                	push   $0x5f
  jmp alltraps
80106722:	e9 c3 f7 ff ff       	jmp    80105eea <alltraps>

80106727 <vector96>:
.globl vector96
vector96:
  pushl $0
80106727:	6a 00                	push   $0x0
  pushl $96
80106729:	6a 60                	push   $0x60
  jmp alltraps
8010672b:	e9 ba f7 ff ff       	jmp    80105eea <alltraps>

80106730 <vector97>:
.globl vector97
vector97:
  pushl $0
80106730:	6a 00                	push   $0x0
  pushl $97
80106732:	6a 61                	push   $0x61
  jmp alltraps
80106734:	e9 b1 f7 ff ff       	jmp    80105eea <alltraps>

80106739 <vector98>:
.globl vector98
vector98:
  pushl $0
80106739:	6a 00                	push   $0x0
  pushl $98
8010673b:	6a 62                	push   $0x62
  jmp alltraps
8010673d:	e9 a8 f7 ff ff       	jmp    80105eea <alltraps>

80106742 <vector99>:
.globl vector99
vector99:
  pushl $0
80106742:	6a 00                	push   $0x0
  pushl $99
80106744:	6a 63                	push   $0x63
  jmp alltraps
80106746:	e9 9f f7 ff ff       	jmp    80105eea <alltraps>

8010674b <vector100>:
.globl vector100
vector100:
  pushl $0
8010674b:	6a 00                	push   $0x0
  pushl $100
8010674d:	6a 64                	push   $0x64
  jmp alltraps
8010674f:	e9 96 f7 ff ff       	jmp    80105eea <alltraps>

80106754 <vector101>:
.globl vector101
vector101:
  pushl $0
80106754:	6a 00                	push   $0x0
  pushl $101
80106756:	6a 65                	push   $0x65
  jmp alltraps
80106758:	e9 8d f7 ff ff       	jmp    80105eea <alltraps>

8010675d <vector102>:
.globl vector102
vector102:
  pushl $0
8010675d:	6a 00                	push   $0x0
  pushl $102
8010675f:	6a 66                	push   $0x66
  jmp alltraps
80106761:	e9 84 f7 ff ff       	jmp    80105eea <alltraps>

80106766 <vector103>:
.globl vector103
vector103:
  pushl $0
80106766:	6a 00                	push   $0x0
  pushl $103
80106768:	6a 67                	push   $0x67
  jmp alltraps
8010676a:	e9 7b f7 ff ff       	jmp    80105eea <alltraps>

8010676f <vector104>:
.globl vector104
vector104:
  pushl $0
8010676f:	6a 00                	push   $0x0
  pushl $104
80106771:	6a 68                	push   $0x68
  jmp alltraps
80106773:	e9 72 f7 ff ff       	jmp    80105eea <alltraps>

80106778 <vector105>:
.globl vector105
vector105:
  pushl $0
80106778:	6a 00                	push   $0x0
  pushl $105
8010677a:	6a 69                	push   $0x69
  jmp alltraps
8010677c:	e9 69 f7 ff ff       	jmp    80105eea <alltraps>

80106781 <vector106>:
.globl vector106
vector106:
  pushl $0
80106781:	6a 00                	push   $0x0
  pushl $106
80106783:	6a 6a                	push   $0x6a
  jmp alltraps
80106785:	e9 60 f7 ff ff       	jmp    80105eea <alltraps>

8010678a <vector107>:
.globl vector107
vector107:
  pushl $0
8010678a:	6a 00                	push   $0x0
  pushl $107
8010678c:	6a 6b                	push   $0x6b
  jmp alltraps
8010678e:	e9 57 f7 ff ff       	jmp    80105eea <alltraps>

80106793 <vector108>:
.globl vector108
vector108:
  pushl $0
80106793:	6a 00                	push   $0x0
  pushl $108
80106795:	6a 6c                	push   $0x6c
  jmp alltraps
80106797:	e9 4e f7 ff ff       	jmp    80105eea <alltraps>

8010679c <vector109>:
.globl vector109
vector109:
  pushl $0
8010679c:	6a 00                	push   $0x0
  pushl $109
8010679e:	6a 6d                	push   $0x6d
  jmp alltraps
801067a0:	e9 45 f7 ff ff       	jmp    80105eea <alltraps>

801067a5 <vector110>:
.globl vector110
vector110:
  pushl $0
801067a5:	6a 00                	push   $0x0
  pushl $110
801067a7:	6a 6e                	push   $0x6e
  jmp alltraps
801067a9:	e9 3c f7 ff ff       	jmp    80105eea <alltraps>

801067ae <vector111>:
.globl vector111
vector111:
  pushl $0
801067ae:	6a 00                	push   $0x0
  pushl $111
801067b0:	6a 6f                	push   $0x6f
  jmp alltraps
801067b2:	e9 33 f7 ff ff       	jmp    80105eea <alltraps>

801067b7 <vector112>:
.globl vector112
vector112:
  pushl $0
801067b7:	6a 00                	push   $0x0
  pushl $112
801067b9:	6a 70                	push   $0x70
  jmp alltraps
801067bb:	e9 2a f7 ff ff       	jmp    80105eea <alltraps>

801067c0 <vector113>:
.globl vector113
vector113:
  pushl $0
801067c0:	6a 00                	push   $0x0
  pushl $113
801067c2:	6a 71                	push   $0x71
  jmp alltraps
801067c4:	e9 21 f7 ff ff       	jmp    80105eea <alltraps>

801067c9 <vector114>:
.globl vector114
vector114:
  pushl $0
801067c9:	6a 00                	push   $0x0
  pushl $114
801067cb:	6a 72                	push   $0x72
  jmp alltraps
801067cd:	e9 18 f7 ff ff       	jmp    80105eea <alltraps>

801067d2 <vector115>:
.globl vector115
vector115:
  pushl $0
801067d2:	6a 00                	push   $0x0
  pushl $115
801067d4:	6a 73                	push   $0x73
  jmp alltraps
801067d6:	e9 0f f7 ff ff       	jmp    80105eea <alltraps>

801067db <vector116>:
.globl vector116
vector116:
  pushl $0
801067db:	6a 00                	push   $0x0
  pushl $116
801067dd:	6a 74                	push   $0x74
  jmp alltraps
801067df:	e9 06 f7 ff ff       	jmp    80105eea <alltraps>

801067e4 <vector117>:
.globl vector117
vector117:
  pushl $0
801067e4:	6a 00                	push   $0x0
  pushl $117
801067e6:	6a 75                	push   $0x75
  jmp alltraps
801067e8:	e9 fd f6 ff ff       	jmp    80105eea <alltraps>

801067ed <vector118>:
.globl vector118
vector118:
  pushl $0
801067ed:	6a 00                	push   $0x0
  pushl $118
801067ef:	6a 76                	push   $0x76
  jmp alltraps
801067f1:	e9 f4 f6 ff ff       	jmp    80105eea <alltraps>

801067f6 <vector119>:
.globl vector119
vector119:
  pushl $0
801067f6:	6a 00                	push   $0x0
  pushl $119
801067f8:	6a 77                	push   $0x77
  jmp alltraps
801067fa:	e9 eb f6 ff ff       	jmp    80105eea <alltraps>

801067ff <vector120>:
.globl vector120
vector120:
  pushl $0
801067ff:	6a 00                	push   $0x0
  pushl $120
80106801:	6a 78                	push   $0x78
  jmp alltraps
80106803:	e9 e2 f6 ff ff       	jmp    80105eea <alltraps>

80106808 <vector121>:
.globl vector121
vector121:
  pushl $0
80106808:	6a 00                	push   $0x0
  pushl $121
8010680a:	6a 79                	push   $0x79
  jmp alltraps
8010680c:	e9 d9 f6 ff ff       	jmp    80105eea <alltraps>

80106811 <vector122>:
.globl vector122
vector122:
  pushl $0
80106811:	6a 00                	push   $0x0
  pushl $122
80106813:	6a 7a                	push   $0x7a
  jmp alltraps
80106815:	e9 d0 f6 ff ff       	jmp    80105eea <alltraps>

8010681a <vector123>:
.globl vector123
vector123:
  pushl $0
8010681a:	6a 00                	push   $0x0
  pushl $123
8010681c:	6a 7b                	push   $0x7b
  jmp alltraps
8010681e:	e9 c7 f6 ff ff       	jmp    80105eea <alltraps>

80106823 <vector124>:
.globl vector124
vector124:
  pushl $0
80106823:	6a 00                	push   $0x0
  pushl $124
80106825:	6a 7c                	push   $0x7c
  jmp alltraps
80106827:	e9 be f6 ff ff       	jmp    80105eea <alltraps>

8010682c <vector125>:
.globl vector125
vector125:
  pushl $0
8010682c:	6a 00                	push   $0x0
  pushl $125
8010682e:	6a 7d                	push   $0x7d
  jmp alltraps
80106830:	e9 b5 f6 ff ff       	jmp    80105eea <alltraps>

80106835 <vector126>:
.globl vector126
vector126:
  pushl $0
80106835:	6a 00                	push   $0x0
  pushl $126
80106837:	6a 7e                	push   $0x7e
  jmp alltraps
80106839:	e9 ac f6 ff ff       	jmp    80105eea <alltraps>

8010683e <vector127>:
.globl vector127
vector127:
  pushl $0
8010683e:	6a 00                	push   $0x0
  pushl $127
80106840:	6a 7f                	push   $0x7f
  jmp alltraps
80106842:	e9 a3 f6 ff ff       	jmp    80105eea <alltraps>

80106847 <vector128>:
.globl vector128
vector128:
  pushl $0
80106847:	6a 00                	push   $0x0
  pushl $128
80106849:	68 80 00 00 00       	push   $0x80
  jmp alltraps
8010684e:	e9 97 f6 ff ff       	jmp    80105eea <alltraps>

80106853 <vector129>:
.globl vector129
vector129:
  pushl $0
80106853:	6a 00                	push   $0x0
  pushl $129
80106855:	68 81 00 00 00       	push   $0x81
  jmp alltraps
8010685a:	e9 8b f6 ff ff       	jmp    80105eea <alltraps>

8010685f <vector130>:
.globl vector130
vector130:
  pushl $0
8010685f:	6a 00                	push   $0x0
  pushl $130
80106861:	68 82 00 00 00       	push   $0x82
  jmp alltraps
80106866:	e9 7f f6 ff ff       	jmp    80105eea <alltraps>

8010686b <vector131>:
.globl vector131
vector131:
  pushl $0
8010686b:	6a 00                	push   $0x0
  pushl $131
8010686d:	68 83 00 00 00       	push   $0x83
  jmp alltraps
80106872:	e9 73 f6 ff ff       	jmp    80105eea <alltraps>

80106877 <vector132>:
.globl vector132
vector132:
  pushl $0
80106877:	6a 00                	push   $0x0
  pushl $132
80106879:	68 84 00 00 00       	push   $0x84
  jmp alltraps
8010687e:	e9 67 f6 ff ff       	jmp    80105eea <alltraps>

80106883 <vector133>:
.globl vector133
vector133:
  pushl $0
80106883:	6a 00                	push   $0x0
  pushl $133
80106885:	68 85 00 00 00       	push   $0x85
  jmp alltraps
8010688a:	e9 5b f6 ff ff       	jmp    80105eea <alltraps>

8010688f <vector134>:
.globl vector134
vector134:
  pushl $0
8010688f:	6a 00                	push   $0x0
  pushl $134
80106891:	68 86 00 00 00       	push   $0x86
  jmp alltraps
80106896:	e9 4f f6 ff ff       	jmp    80105eea <alltraps>

8010689b <vector135>:
.globl vector135
vector135:
  pushl $0
8010689b:	6a 00                	push   $0x0
  pushl $135
8010689d:	68 87 00 00 00       	push   $0x87
  jmp alltraps
801068a2:	e9 43 f6 ff ff       	jmp    80105eea <alltraps>

801068a7 <vector136>:
.globl vector136
vector136:
  pushl $0
801068a7:	6a 00                	push   $0x0
  pushl $136
801068a9:	68 88 00 00 00       	push   $0x88
  jmp alltraps
801068ae:	e9 37 f6 ff ff       	jmp    80105eea <alltraps>

801068b3 <vector137>:
.globl vector137
vector137:
  pushl $0
801068b3:	6a 00                	push   $0x0
  pushl $137
801068b5:	68 89 00 00 00       	push   $0x89
  jmp alltraps
801068ba:	e9 2b f6 ff ff       	jmp    80105eea <alltraps>

801068bf <vector138>:
.globl vector138
vector138:
  pushl $0
801068bf:	6a 00                	push   $0x0
  pushl $138
801068c1:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
801068c6:	e9 1f f6 ff ff       	jmp    80105eea <alltraps>

801068cb <vector139>:
.globl vector139
vector139:
  pushl $0
801068cb:	6a 00                	push   $0x0
  pushl $139
801068cd:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
801068d2:	e9 13 f6 ff ff       	jmp    80105eea <alltraps>

801068d7 <vector140>:
.globl vector140
vector140:
  pushl $0
801068d7:	6a 00                	push   $0x0
  pushl $140
801068d9:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
801068de:	e9 07 f6 ff ff       	jmp    80105eea <alltraps>

801068e3 <vector141>:
.globl vector141
vector141:
  pushl $0
801068e3:	6a 00                	push   $0x0
  pushl $141
801068e5:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
801068ea:	e9 fb f5 ff ff       	jmp    80105eea <alltraps>

801068ef <vector142>:
.globl vector142
vector142:
  pushl $0
801068ef:	6a 00                	push   $0x0
  pushl $142
801068f1:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
801068f6:	e9 ef f5 ff ff       	jmp    80105eea <alltraps>

801068fb <vector143>:
.globl vector143
vector143:
  pushl $0
801068fb:	6a 00                	push   $0x0
  pushl $143
801068fd:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
80106902:	e9 e3 f5 ff ff       	jmp    80105eea <alltraps>

80106907 <vector144>:
.globl vector144
vector144:
  pushl $0
80106907:	6a 00                	push   $0x0
  pushl $144
80106909:	68 90 00 00 00       	push   $0x90
  jmp alltraps
8010690e:	e9 d7 f5 ff ff       	jmp    80105eea <alltraps>

80106913 <vector145>:
.globl vector145
vector145:
  pushl $0
80106913:	6a 00                	push   $0x0
  pushl $145
80106915:	68 91 00 00 00       	push   $0x91
  jmp alltraps
8010691a:	e9 cb f5 ff ff       	jmp    80105eea <alltraps>

8010691f <vector146>:
.globl vector146
vector146:
  pushl $0
8010691f:	6a 00                	push   $0x0
  pushl $146
80106921:	68 92 00 00 00       	push   $0x92
  jmp alltraps
80106926:	e9 bf f5 ff ff       	jmp    80105eea <alltraps>

8010692b <vector147>:
.globl vector147
vector147:
  pushl $0
8010692b:	6a 00                	push   $0x0
  pushl $147
8010692d:	68 93 00 00 00       	push   $0x93
  jmp alltraps
80106932:	e9 b3 f5 ff ff       	jmp    80105eea <alltraps>

80106937 <vector148>:
.globl vector148
vector148:
  pushl $0
80106937:	6a 00                	push   $0x0
  pushl $148
80106939:	68 94 00 00 00       	push   $0x94
  jmp alltraps
8010693e:	e9 a7 f5 ff ff       	jmp    80105eea <alltraps>

80106943 <vector149>:
.globl vector149
vector149:
  pushl $0
80106943:	6a 00                	push   $0x0
  pushl $149
80106945:	68 95 00 00 00       	push   $0x95
  jmp alltraps
8010694a:	e9 9b f5 ff ff       	jmp    80105eea <alltraps>

8010694f <vector150>:
.globl vector150
vector150:
  pushl $0
8010694f:	6a 00                	push   $0x0
  pushl $150
80106951:	68 96 00 00 00       	push   $0x96
  jmp alltraps
80106956:	e9 8f f5 ff ff       	jmp    80105eea <alltraps>

8010695b <vector151>:
.globl vector151
vector151:
  pushl $0
8010695b:	6a 00                	push   $0x0
  pushl $151
8010695d:	68 97 00 00 00       	push   $0x97
  jmp alltraps
80106962:	e9 83 f5 ff ff       	jmp    80105eea <alltraps>

80106967 <vector152>:
.globl vector152
vector152:
  pushl $0
80106967:	6a 00                	push   $0x0
  pushl $152
80106969:	68 98 00 00 00       	push   $0x98
  jmp alltraps
8010696e:	e9 77 f5 ff ff       	jmp    80105eea <alltraps>

80106973 <vector153>:
.globl vector153
vector153:
  pushl $0
80106973:	6a 00                	push   $0x0
  pushl $153
80106975:	68 99 00 00 00       	push   $0x99
  jmp alltraps
8010697a:	e9 6b f5 ff ff       	jmp    80105eea <alltraps>

8010697f <vector154>:
.globl vector154
vector154:
  pushl $0
8010697f:	6a 00                	push   $0x0
  pushl $154
80106981:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
80106986:	e9 5f f5 ff ff       	jmp    80105eea <alltraps>

8010698b <vector155>:
.globl vector155
vector155:
  pushl $0
8010698b:	6a 00                	push   $0x0
  pushl $155
8010698d:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
80106992:	e9 53 f5 ff ff       	jmp    80105eea <alltraps>

80106997 <vector156>:
.globl vector156
vector156:
  pushl $0
80106997:	6a 00                	push   $0x0
  pushl $156
80106999:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
8010699e:	e9 47 f5 ff ff       	jmp    80105eea <alltraps>

801069a3 <vector157>:
.globl vector157
vector157:
  pushl $0
801069a3:	6a 00                	push   $0x0
  pushl $157
801069a5:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
801069aa:	e9 3b f5 ff ff       	jmp    80105eea <alltraps>

801069af <vector158>:
.globl vector158
vector158:
  pushl $0
801069af:	6a 00                	push   $0x0
  pushl $158
801069b1:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
801069b6:	e9 2f f5 ff ff       	jmp    80105eea <alltraps>

801069bb <vector159>:
.globl vector159
vector159:
  pushl $0
801069bb:	6a 00                	push   $0x0
  pushl $159
801069bd:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
801069c2:	e9 23 f5 ff ff       	jmp    80105eea <alltraps>

801069c7 <vector160>:
.globl vector160
vector160:
  pushl $0
801069c7:	6a 00                	push   $0x0
  pushl $160
801069c9:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
801069ce:	e9 17 f5 ff ff       	jmp    80105eea <alltraps>

801069d3 <vector161>:
.globl vector161
vector161:
  pushl $0
801069d3:	6a 00                	push   $0x0
  pushl $161
801069d5:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
801069da:	e9 0b f5 ff ff       	jmp    80105eea <alltraps>

801069df <vector162>:
.globl vector162
vector162:
  pushl $0
801069df:	6a 00                	push   $0x0
  pushl $162
801069e1:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
801069e6:	e9 ff f4 ff ff       	jmp    80105eea <alltraps>

801069eb <vector163>:
.globl vector163
vector163:
  pushl $0
801069eb:	6a 00                	push   $0x0
  pushl $163
801069ed:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
801069f2:	e9 f3 f4 ff ff       	jmp    80105eea <alltraps>

801069f7 <vector164>:
.globl vector164
vector164:
  pushl $0
801069f7:	6a 00                	push   $0x0
  pushl $164
801069f9:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
801069fe:	e9 e7 f4 ff ff       	jmp    80105eea <alltraps>

80106a03 <vector165>:
.globl vector165
vector165:
  pushl $0
80106a03:	6a 00                	push   $0x0
  pushl $165
80106a05:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
80106a0a:	e9 db f4 ff ff       	jmp    80105eea <alltraps>

80106a0f <vector166>:
.globl vector166
vector166:
  pushl $0
80106a0f:	6a 00                	push   $0x0
  pushl $166
80106a11:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
80106a16:	e9 cf f4 ff ff       	jmp    80105eea <alltraps>

80106a1b <vector167>:
.globl vector167
vector167:
  pushl $0
80106a1b:	6a 00                	push   $0x0
  pushl $167
80106a1d:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
80106a22:	e9 c3 f4 ff ff       	jmp    80105eea <alltraps>

80106a27 <vector168>:
.globl vector168
vector168:
  pushl $0
80106a27:	6a 00                	push   $0x0
  pushl $168
80106a29:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
80106a2e:	e9 b7 f4 ff ff       	jmp    80105eea <alltraps>

80106a33 <vector169>:
.globl vector169
vector169:
  pushl $0
80106a33:	6a 00                	push   $0x0
  pushl $169
80106a35:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
80106a3a:	e9 ab f4 ff ff       	jmp    80105eea <alltraps>

80106a3f <vector170>:
.globl vector170
vector170:
  pushl $0
80106a3f:	6a 00                	push   $0x0
  pushl $170
80106a41:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
80106a46:	e9 9f f4 ff ff       	jmp    80105eea <alltraps>

80106a4b <vector171>:
.globl vector171
vector171:
  pushl $0
80106a4b:	6a 00                	push   $0x0
  pushl $171
80106a4d:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
80106a52:	e9 93 f4 ff ff       	jmp    80105eea <alltraps>

80106a57 <vector172>:
.globl vector172
vector172:
  pushl $0
80106a57:	6a 00                	push   $0x0
  pushl $172
80106a59:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
80106a5e:	e9 87 f4 ff ff       	jmp    80105eea <alltraps>

80106a63 <vector173>:
.globl vector173
vector173:
  pushl $0
80106a63:	6a 00                	push   $0x0
  pushl $173
80106a65:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
80106a6a:	e9 7b f4 ff ff       	jmp    80105eea <alltraps>

80106a6f <vector174>:
.globl vector174
vector174:
  pushl $0
80106a6f:	6a 00                	push   $0x0
  pushl $174
80106a71:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
80106a76:	e9 6f f4 ff ff       	jmp    80105eea <alltraps>

80106a7b <vector175>:
.globl vector175
vector175:
  pushl $0
80106a7b:	6a 00                	push   $0x0
  pushl $175
80106a7d:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
80106a82:	e9 63 f4 ff ff       	jmp    80105eea <alltraps>

80106a87 <vector176>:
.globl vector176
vector176:
  pushl $0
80106a87:	6a 00                	push   $0x0
  pushl $176
80106a89:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
80106a8e:	e9 57 f4 ff ff       	jmp    80105eea <alltraps>

80106a93 <vector177>:
.globl vector177
vector177:
  pushl $0
80106a93:	6a 00                	push   $0x0
  pushl $177
80106a95:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
80106a9a:	e9 4b f4 ff ff       	jmp    80105eea <alltraps>

80106a9f <vector178>:
.globl vector178
vector178:
  pushl $0
80106a9f:	6a 00                	push   $0x0
  pushl $178
80106aa1:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
80106aa6:	e9 3f f4 ff ff       	jmp    80105eea <alltraps>

80106aab <vector179>:
.globl vector179
vector179:
  pushl $0
80106aab:	6a 00                	push   $0x0
  pushl $179
80106aad:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
80106ab2:	e9 33 f4 ff ff       	jmp    80105eea <alltraps>

80106ab7 <vector180>:
.globl vector180
vector180:
  pushl $0
80106ab7:	6a 00                	push   $0x0
  pushl $180
80106ab9:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
80106abe:	e9 27 f4 ff ff       	jmp    80105eea <alltraps>

80106ac3 <vector181>:
.globl vector181
vector181:
  pushl $0
80106ac3:	6a 00                	push   $0x0
  pushl $181
80106ac5:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
80106aca:	e9 1b f4 ff ff       	jmp    80105eea <alltraps>

80106acf <vector182>:
.globl vector182
vector182:
  pushl $0
80106acf:	6a 00                	push   $0x0
  pushl $182
80106ad1:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
80106ad6:	e9 0f f4 ff ff       	jmp    80105eea <alltraps>

80106adb <vector183>:
.globl vector183
vector183:
  pushl $0
80106adb:	6a 00                	push   $0x0
  pushl $183
80106add:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
80106ae2:	e9 03 f4 ff ff       	jmp    80105eea <alltraps>

80106ae7 <vector184>:
.globl vector184
vector184:
  pushl $0
80106ae7:	6a 00                	push   $0x0
  pushl $184
80106ae9:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
80106aee:	e9 f7 f3 ff ff       	jmp    80105eea <alltraps>

80106af3 <vector185>:
.globl vector185
vector185:
  pushl $0
80106af3:	6a 00                	push   $0x0
  pushl $185
80106af5:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
80106afa:	e9 eb f3 ff ff       	jmp    80105eea <alltraps>

80106aff <vector186>:
.globl vector186
vector186:
  pushl $0
80106aff:	6a 00                	push   $0x0
  pushl $186
80106b01:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
80106b06:	e9 df f3 ff ff       	jmp    80105eea <alltraps>

80106b0b <vector187>:
.globl vector187
vector187:
  pushl $0
80106b0b:	6a 00                	push   $0x0
  pushl $187
80106b0d:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
80106b12:	e9 d3 f3 ff ff       	jmp    80105eea <alltraps>

80106b17 <vector188>:
.globl vector188
vector188:
  pushl $0
80106b17:	6a 00                	push   $0x0
  pushl $188
80106b19:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
80106b1e:	e9 c7 f3 ff ff       	jmp    80105eea <alltraps>

80106b23 <vector189>:
.globl vector189
vector189:
  pushl $0
80106b23:	6a 00                	push   $0x0
  pushl $189
80106b25:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
80106b2a:	e9 bb f3 ff ff       	jmp    80105eea <alltraps>

80106b2f <vector190>:
.globl vector190
vector190:
  pushl $0
80106b2f:	6a 00                	push   $0x0
  pushl $190
80106b31:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
80106b36:	e9 af f3 ff ff       	jmp    80105eea <alltraps>

80106b3b <vector191>:
.globl vector191
vector191:
  pushl $0
80106b3b:	6a 00                	push   $0x0
  pushl $191
80106b3d:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
80106b42:	e9 a3 f3 ff ff       	jmp    80105eea <alltraps>

80106b47 <vector192>:
.globl vector192
vector192:
  pushl $0
80106b47:	6a 00                	push   $0x0
  pushl $192
80106b49:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
80106b4e:	e9 97 f3 ff ff       	jmp    80105eea <alltraps>

80106b53 <vector193>:
.globl vector193
vector193:
  pushl $0
80106b53:	6a 00                	push   $0x0
  pushl $193
80106b55:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
80106b5a:	e9 8b f3 ff ff       	jmp    80105eea <alltraps>

80106b5f <vector194>:
.globl vector194
vector194:
  pushl $0
80106b5f:	6a 00                	push   $0x0
  pushl $194
80106b61:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
80106b66:	e9 7f f3 ff ff       	jmp    80105eea <alltraps>

80106b6b <vector195>:
.globl vector195
vector195:
  pushl $0
80106b6b:	6a 00                	push   $0x0
  pushl $195
80106b6d:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
80106b72:	e9 73 f3 ff ff       	jmp    80105eea <alltraps>

80106b77 <vector196>:
.globl vector196
vector196:
  pushl $0
80106b77:	6a 00                	push   $0x0
  pushl $196
80106b79:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
80106b7e:	e9 67 f3 ff ff       	jmp    80105eea <alltraps>

80106b83 <vector197>:
.globl vector197
vector197:
  pushl $0
80106b83:	6a 00                	push   $0x0
  pushl $197
80106b85:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
80106b8a:	e9 5b f3 ff ff       	jmp    80105eea <alltraps>

80106b8f <vector198>:
.globl vector198
vector198:
  pushl $0
80106b8f:	6a 00                	push   $0x0
  pushl $198
80106b91:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
80106b96:	e9 4f f3 ff ff       	jmp    80105eea <alltraps>

80106b9b <vector199>:
.globl vector199
vector199:
  pushl $0
80106b9b:	6a 00                	push   $0x0
  pushl $199
80106b9d:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
80106ba2:	e9 43 f3 ff ff       	jmp    80105eea <alltraps>

80106ba7 <vector200>:
.globl vector200
vector200:
  pushl $0
80106ba7:	6a 00                	push   $0x0
  pushl $200
80106ba9:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
80106bae:	e9 37 f3 ff ff       	jmp    80105eea <alltraps>

80106bb3 <vector201>:
.globl vector201
vector201:
  pushl $0
80106bb3:	6a 00                	push   $0x0
  pushl $201
80106bb5:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
80106bba:	e9 2b f3 ff ff       	jmp    80105eea <alltraps>

80106bbf <vector202>:
.globl vector202
vector202:
  pushl $0
80106bbf:	6a 00                	push   $0x0
  pushl $202
80106bc1:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
80106bc6:	e9 1f f3 ff ff       	jmp    80105eea <alltraps>

80106bcb <vector203>:
.globl vector203
vector203:
  pushl $0
80106bcb:	6a 00                	push   $0x0
  pushl $203
80106bcd:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
80106bd2:	e9 13 f3 ff ff       	jmp    80105eea <alltraps>

80106bd7 <vector204>:
.globl vector204
vector204:
  pushl $0
80106bd7:	6a 00                	push   $0x0
  pushl $204
80106bd9:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
80106bde:	e9 07 f3 ff ff       	jmp    80105eea <alltraps>

80106be3 <vector205>:
.globl vector205
vector205:
  pushl $0
80106be3:	6a 00                	push   $0x0
  pushl $205
80106be5:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
80106bea:	e9 fb f2 ff ff       	jmp    80105eea <alltraps>

80106bef <vector206>:
.globl vector206
vector206:
  pushl $0
80106bef:	6a 00                	push   $0x0
  pushl $206
80106bf1:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
80106bf6:	e9 ef f2 ff ff       	jmp    80105eea <alltraps>

80106bfb <vector207>:
.globl vector207
vector207:
  pushl $0
80106bfb:	6a 00                	push   $0x0
  pushl $207
80106bfd:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
80106c02:	e9 e3 f2 ff ff       	jmp    80105eea <alltraps>

80106c07 <vector208>:
.globl vector208
vector208:
  pushl $0
80106c07:	6a 00                	push   $0x0
  pushl $208
80106c09:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
80106c0e:	e9 d7 f2 ff ff       	jmp    80105eea <alltraps>

80106c13 <vector209>:
.globl vector209
vector209:
  pushl $0
80106c13:	6a 00                	push   $0x0
  pushl $209
80106c15:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
80106c1a:	e9 cb f2 ff ff       	jmp    80105eea <alltraps>

80106c1f <vector210>:
.globl vector210
vector210:
  pushl $0
80106c1f:	6a 00                	push   $0x0
  pushl $210
80106c21:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80106c26:	e9 bf f2 ff ff       	jmp    80105eea <alltraps>

80106c2b <vector211>:
.globl vector211
vector211:
  pushl $0
80106c2b:	6a 00                	push   $0x0
  pushl $211
80106c2d:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80106c32:	e9 b3 f2 ff ff       	jmp    80105eea <alltraps>

80106c37 <vector212>:
.globl vector212
vector212:
  pushl $0
80106c37:	6a 00                	push   $0x0
  pushl $212
80106c39:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
80106c3e:	e9 a7 f2 ff ff       	jmp    80105eea <alltraps>

80106c43 <vector213>:
.globl vector213
vector213:
  pushl $0
80106c43:	6a 00                	push   $0x0
  pushl $213
80106c45:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
80106c4a:	e9 9b f2 ff ff       	jmp    80105eea <alltraps>

80106c4f <vector214>:
.globl vector214
vector214:
  pushl $0
80106c4f:	6a 00                	push   $0x0
  pushl $214
80106c51:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80106c56:	e9 8f f2 ff ff       	jmp    80105eea <alltraps>

80106c5b <vector215>:
.globl vector215
vector215:
  pushl $0
80106c5b:	6a 00                	push   $0x0
  pushl $215
80106c5d:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80106c62:	e9 83 f2 ff ff       	jmp    80105eea <alltraps>

80106c67 <vector216>:
.globl vector216
vector216:
  pushl $0
80106c67:	6a 00                	push   $0x0
  pushl $216
80106c69:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
80106c6e:	e9 77 f2 ff ff       	jmp    80105eea <alltraps>

80106c73 <vector217>:
.globl vector217
vector217:
  pushl $0
80106c73:	6a 00                	push   $0x0
  pushl $217
80106c75:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
80106c7a:	e9 6b f2 ff ff       	jmp    80105eea <alltraps>

80106c7f <vector218>:
.globl vector218
vector218:
  pushl $0
80106c7f:	6a 00                	push   $0x0
  pushl $218
80106c81:	68 da 00 00 00       	push   $0xda
  jmp alltraps
80106c86:	e9 5f f2 ff ff       	jmp    80105eea <alltraps>

80106c8b <vector219>:
.globl vector219
vector219:
  pushl $0
80106c8b:	6a 00                	push   $0x0
  pushl $219
80106c8d:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
80106c92:	e9 53 f2 ff ff       	jmp    80105eea <alltraps>

80106c97 <vector220>:
.globl vector220
vector220:
  pushl $0
80106c97:	6a 00                	push   $0x0
  pushl $220
80106c99:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
80106c9e:	e9 47 f2 ff ff       	jmp    80105eea <alltraps>

80106ca3 <vector221>:
.globl vector221
vector221:
  pushl $0
80106ca3:	6a 00                	push   $0x0
  pushl $221
80106ca5:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
80106caa:	e9 3b f2 ff ff       	jmp    80105eea <alltraps>

80106caf <vector222>:
.globl vector222
vector222:
  pushl $0
80106caf:	6a 00                	push   $0x0
  pushl $222
80106cb1:	68 de 00 00 00       	push   $0xde
  jmp alltraps
80106cb6:	e9 2f f2 ff ff       	jmp    80105eea <alltraps>

80106cbb <vector223>:
.globl vector223
vector223:
  pushl $0
80106cbb:	6a 00                	push   $0x0
  pushl $223
80106cbd:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
80106cc2:	e9 23 f2 ff ff       	jmp    80105eea <alltraps>

80106cc7 <vector224>:
.globl vector224
vector224:
  pushl $0
80106cc7:	6a 00                	push   $0x0
  pushl $224
80106cc9:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
80106cce:	e9 17 f2 ff ff       	jmp    80105eea <alltraps>

80106cd3 <vector225>:
.globl vector225
vector225:
  pushl $0
80106cd3:	6a 00                	push   $0x0
  pushl $225
80106cd5:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
80106cda:	e9 0b f2 ff ff       	jmp    80105eea <alltraps>

80106cdf <vector226>:
.globl vector226
vector226:
  pushl $0
80106cdf:	6a 00                	push   $0x0
  pushl $226
80106ce1:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
80106ce6:	e9 ff f1 ff ff       	jmp    80105eea <alltraps>

80106ceb <vector227>:
.globl vector227
vector227:
  pushl $0
80106ceb:	6a 00                	push   $0x0
  pushl $227
80106ced:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
80106cf2:	e9 f3 f1 ff ff       	jmp    80105eea <alltraps>

80106cf7 <vector228>:
.globl vector228
vector228:
  pushl $0
80106cf7:	6a 00                	push   $0x0
  pushl $228
80106cf9:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
80106cfe:	e9 e7 f1 ff ff       	jmp    80105eea <alltraps>

80106d03 <vector229>:
.globl vector229
vector229:
  pushl $0
80106d03:	6a 00                	push   $0x0
  pushl $229
80106d05:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
80106d0a:	e9 db f1 ff ff       	jmp    80105eea <alltraps>

80106d0f <vector230>:
.globl vector230
vector230:
  pushl $0
80106d0f:	6a 00                	push   $0x0
  pushl $230
80106d11:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80106d16:	e9 cf f1 ff ff       	jmp    80105eea <alltraps>

80106d1b <vector231>:
.globl vector231
vector231:
  pushl $0
80106d1b:	6a 00                	push   $0x0
  pushl $231
80106d1d:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80106d22:	e9 c3 f1 ff ff       	jmp    80105eea <alltraps>

80106d27 <vector232>:
.globl vector232
vector232:
  pushl $0
80106d27:	6a 00                	push   $0x0
  pushl $232
80106d29:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
80106d2e:	e9 b7 f1 ff ff       	jmp    80105eea <alltraps>

80106d33 <vector233>:
.globl vector233
vector233:
  pushl $0
80106d33:	6a 00                	push   $0x0
  pushl $233
80106d35:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
80106d3a:	e9 ab f1 ff ff       	jmp    80105eea <alltraps>

80106d3f <vector234>:
.globl vector234
vector234:
  pushl $0
80106d3f:	6a 00                	push   $0x0
  pushl $234
80106d41:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80106d46:	e9 9f f1 ff ff       	jmp    80105eea <alltraps>

80106d4b <vector235>:
.globl vector235
vector235:
  pushl $0
80106d4b:	6a 00                	push   $0x0
  pushl $235
80106d4d:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80106d52:	e9 93 f1 ff ff       	jmp    80105eea <alltraps>

80106d57 <vector236>:
.globl vector236
vector236:
  pushl $0
80106d57:	6a 00                	push   $0x0
  pushl $236
80106d59:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
80106d5e:	e9 87 f1 ff ff       	jmp    80105eea <alltraps>

80106d63 <vector237>:
.globl vector237
vector237:
  pushl $0
80106d63:	6a 00                	push   $0x0
  pushl $237
80106d65:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
80106d6a:	e9 7b f1 ff ff       	jmp    80105eea <alltraps>

80106d6f <vector238>:
.globl vector238
vector238:
  pushl $0
80106d6f:	6a 00                	push   $0x0
  pushl $238
80106d71:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
80106d76:	e9 6f f1 ff ff       	jmp    80105eea <alltraps>

80106d7b <vector239>:
.globl vector239
vector239:
  pushl $0
80106d7b:	6a 00                	push   $0x0
  pushl $239
80106d7d:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
80106d82:	e9 63 f1 ff ff       	jmp    80105eea <alltraps>

80106d87 <vector240>:
.globl vector240
vector240:
  pushl $0
80106d87:	6a 00                	push   $0x0
  pushl $240
80106d89:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
80106d8e:	e9 57 f1 ff ff       	jmp    80105eea <alltraps>

80106d93 <vector241>:
.globl vector241
vector241:
  pushl $0
80106d93:	6a 00                	push   $0x0
  pushl $241
80106d95:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
80106d9a:	e9 4b f1 ff ff       	jmp    80105eea <alltraps>

80106d9f <vector242>:
.globl vector242
vector242:
  pushl $0
80106d9f:	6a 00                	push   $0x0
  pushl $242
80106da1:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
80106da6:	e9 3f f1 ff ff       	jmp    80105eea <alltraps>

80106dab <vector243>:
.globl vector243
vector243:
  pushl $0
80106dab:	6a 00                	push   $0x0
  pushl $243
80106dad:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
80106db2:	e9 33 f1 ff ff       	jmp    80105eea <alltraps>

80106db7 <vector244>:
.globl vector244
vector244:
  pushl $0
80106db7:	6a 00                	push   $0x0
  pushl $244
80106db9:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
80106dbe:	e9 27 f1 ff ff       	jmp    80105eea <alltraps>

80106dc3 <vector245>:
.globl vector245
vector245:
  pushl $0
80106dc3:	6a 00                	push   $0x0
  pushl $245
80106dc5:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
80106dca:	e9 1b f1 ff ff       	jmp    80105eea <alltraps>

80106dcf <vector246>:
.globl vector246
vector246:
  pushl $0
80106dcf:	6a 00                	push   $0x0
  pushl $246
80106dd1:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
80106dd6:	e9 0f f1 ff ff       	jmp    80105eea <alltraps>

80106ddb <vector247>:
.globl vector247
vector247:
  pushl $0
80106ddb:	6a 00                	push   $0x0
  pushl $247
80106ddd:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
80106de2:	e9 03 f1 ff ff       	jmp    80105eea <alltraps>

80106de7 <vector248>:
.globl vector248
vector248:
  pushl $0
80106de7:	6a 00                	push   $0x0
  pushl $248
80106de9:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
80106dee:	e9 f7 f0 ff ff       	jmp    80105eea <alltraps>

80106df3 <vector249>:
.globl vector249
vector249:
  pushl $0
80106df3:	6a 00                	push   $0x0
  pushl $249
80106df5:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
80106dfa:	e9 eb f0 ff ff       	jmp    80105eea <alltraps>

80106dff <vector250>:
.globl vector250
vector250:
  pushl $0
80106dff:	6a 00                	push   $0x0
  pushl $250
80106e01:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80106e06:	e9 df f0 ff ff       	jmp    80105eea <alltraps>

80106e0b <vector251>:
.globl vector251
vector251:
  pushl $0
80106e0b:	6a 00                	push   $0x0
  pushl $251
80106e0d:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80106e12:	e9 d3 f0 ff ff       	jmp    80105eea <alltraps>

80106e17 <vector252>:
.globl vector252
vector252:
  pushl $0
80106e17:	6a 00                	push   $0x0
  pushl $252
80106e19:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
80106e1e:	e9 c7 f0 ff ff       	jmp    80105eea <alltraps>

80106e23 <vector253>:
.globl vector253
vector253:
  pushl $0
80106e23:	6a 00                	push   $0x0
  pushl $253
80106e25:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
80106e2a:	e9 bb f0 ff ff       	jmp    80105eea <alltraps>

80106e2f <vector254>:
.globl vector254
vector254:
  pushl $0
80106e2f:	6a 00                	push   $0x0
  pushl $254
80106e31:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80106e36:	e9 af f0 ff ff       	jmp    80105eea <alltraps>

80106e3b <vector255>:
.globl vector255
vector255:
  pushl $0
80106e3b:	6a 00                	push   $0x0
  pushl $255
80106e3d:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80106e42:	e9 a3 f0 ff ff       	jmp    80105eea <alltraps>
80106e47:	66 90                	xchg   %ax,%ax
80106e49:	66 90                	xchg   %ax,%ax
80106e4b:	66 90                	xchg   %ax,%ax
80106e4d:	66 90                	xchg   %ax,%ax
80106e4f:	90                   	nop

80106e50 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106e50:	55                   	push   %ebp
80106e51:	89 e5                	mov    %esp,%ebp
80106e53:	57                   	push   %edi
80106e54:	56                   	push   %esi
80106e55:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80106e56:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
80106e5c:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106e62:	83 ec 1c             	sub    $0x1c,%esp
80106e65:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  for(; a  < oldsz; a += PGSIZE){
80106e68:	39 d3                	cmp    %edx,%ebx
80106e6a:	73 49                	jae    80106eb5 <deallocuvm.part.0+0x65>
80106e6c:	89 c7                	mov    %eax,%edi
80106e6e:	eb 0c                	jmp    80106e7c <deallocuvm.part.0+0x2c>
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
80106e70:	83 c0 01             	add    $0x1,%eax
80106e73:	c1 e0 16             	shl    $0x16,%eax
80106e76:	89 c3                	mov    %eax,%ebx
  for(; a  < oldsz; a += PGSIZE){
80106e78:	39 da                	cmp    %ebx,%edx
80106e7a:	76 39                	jbe    80106eb5 <deallocuvm.part.0+0x65>
  pde = &pgdir[PDX(va)];
80106e7c:	89 d8                	mov    %ebx,%eax
80106e7e:	c1 e8 16             	shr    $0x16,%eax
  if(*pde & PTE_P){
80106e81:	8b 0c 87             	mov    (%edi,%eax,4),%ecx
80106e84:	f6 c1 01             	test   $0x1,%cl
80106e87:	74 e7                	je     80106e70 <deallocuvm.part.0+0x20>
  return &pgtab[PTX(va)];
80106e89:	89 de                	mov    %ebx,%esi
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106e8b:	81 e1 00 f0 ff ff    	and    $0xfffff000,%ecx
  return &pgtab[PTX(va)];
80106e91:	c1 ee 0a             	shr    $0xa,%esi
80106e94:	81 e6 fc 0f 00 00    	and    $0xffc,%esi
80106e9a:	8d b4 31 00 00 00 80 	lea    -0x80000000(%ecx,%esi,1),%esi
    if(!pte)
80106ea1:	85 f6                	test   %esi,%esi
80106ea3:	74 cb                	je     80106e70 <deallocuvm.part.0+0x20>
    else if((*pte & PTE_P) != 0){
80106ea5:	8b 06                	mov    (%esi),%eax
80106ea7:	a8 01                	test   $0x1,%al
80106ea9:	75 15                	jne    80106ec0 <deallocuvm.part.0+0x70>
  for(; a  < oldsz; a += PGSIZE){
80106eab:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106eb1:	39 da                	cmp    %ebx,%edx
80106eb3:	77 c7                	ja     80106e7c <deallocuvm.part.0+0x2c>
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
}
80106eb5:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106eb8:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106ebb:	5b                   	pop    %ebx
80106ebc:	5e                   	pop    %esi
80106ebd:	5f                   	pop    %edi
80106ebe:	5d                   	pop    %ebp
80106ebf:	c3                   	ret    
      if(pa == 0)
80106ec0:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106ec5:	74 25                	je     80106eec <deallocuvm.part.0+0x9c>
      kfree(v);
80106ec7:	83 ec 0c             	sub    $0xc,%esp
      char *v = P2V(pa);
80106eca:	05 00 00 00 80       	add    $0x80000000,%eax
80106ecf:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  for(; a  < oldsz; a += PGSIZE){
80106ed2:	81 c3 00 10 00 00    	add    $0x1000,%ebx
      kfree(v);
80106ed8:	50                   	push   %eax
80106ed9:	e8 92 bc ff ff       	call   80102b70 <kfree>
      *pte = 0;
80106ede:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
  for(; a  < oldsz; a += PGSIZE){
80106ee4:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80106ee7:	83 c4 10             	add    $0x10,%esp
80106eea:	eb 8c                	jmp    80106e78 <deallocuvm.part.0+0x28>
        panic("kfree");
80106eec:	83 ec 0c             	sub    $0xc,%esp
80106eef:	68 fe 7a 10 80       	push   $0x80107afe
80106ef4:	e8 a7 94 ff ff       	call   801003a0 <panic>
80106ef9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106f00 <mappages>:
{
80106f00:	55                   	push   %ebp
80106f01:	89 e5                	mov    %esp,%ebp
80106f03:	57                   	push   %edi
80106f04:	56                   	push   %esi
80106f05:	53                   	push   %ebx
  a = (char*)PGROUNDDOWN((uint)va);
80106f06:	89 d3                	mov    %edx,%ebx
80106f08:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
{
80106f0e:	83 ec 1c             	sub    $0x1c,%esp
80106f11:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80106f14:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
80106f18:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106f1d:	89 45 dc             	mov    %eax,-0x24(%ebp)
80106f20:	8b 45 08             	mov    0x8(%ebp),%eax
80106f23:	29 d8                	sub    %ebx,%eax
80106f25:	89 45 e0             	mov    %eax,-0x20(%ebp)
80106f28:	eb 3d                	jmp    80106f67 <mappages+0x67>
80106f2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return &pgtab[PTX(va)];
80106f30:	89 da                	mov    %ebx,%edx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106f32:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
80106f37:	c1 ea 0a             	shr    $0xa,%edx
80106f3a:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80106f40:	8d 84 10 00 00 00 80 	lea    -0x80000000(%eax,%edx,1),%eax
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80106f47:	85 c0                	test   %eax,%eax
80106f49:	74 75                	je     80106fc0 <mappages+0xc0>
    if(*pte & PTE_P)
80106f4b:	f6 00 01             	testb  $0x1,(%eax)
80106f4e:	0f 85 86 00 00 00    	jne    80106fda <mappages+0xda>
    *pte = pa | perm | PTE_P;
80106f54:	0b 75 0c             	or     0xc(%ebp),%esi
80106f57:	83 ce 01             	or     $0x1,%esi
80106f5a:	89 30                	mov    %esi,(%eax)
    if(a == last)
80106f5c:	3b 5d dc             	cmp    -0x24(%ebp),%ebx
80106f5f:	74 6f                	je     80106fd0 <mappages+0xd0>
    a += PGSIZE;
80106f61:	81 c3 00 10 00 00    	add    $0x1000,%ebx
  for(;;){
80106f67:	8b 45 e0             	mov    -0x20(%ebp),%eax
  pde = &pgdir[PDX(va)];
80106f6a:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80106f6d:	8d 34 18             	lea    (%eax,%ebx,1),%esi
80106f70:	89 d8                	mov    %ebx,%eax
80106f72:	c1 e8 16             	shr    $0x16,%eax
80106f75:	8d 3c 81             	lea    (%ecx,%eax,4),%edi
  if(*pde & PTE_P){
80106f78:	8b 07                	mov    (%edi),%eax
80106f7a:	a8 01                	test   $0x1,%al
80106f7c:	75 b2                	jne    80106f30 <mappages+0x30>
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80106f7e:	e8 ad bd ff ff       	call   80102d30 <kalloc>
80106f83:	85 c0                	test   %eax,%eax
80106f85:	74 39                	je     80106fc0 <mappages+0xc0>
    memset(pgtab, 0, PGSIZE);
80106f87:	83 ec 04             	sub    $0x4,%esp
80106f8a:	89 45 d8             	mov    %eax,-0x28(%ebp)
80106f8d:	68 00 10 00 00       	push   $0x1000
80106f92:	6a 00                	push   $0x0
80106f94:	50                   	push   %eax
80106f95:	e8 76 dd ff ff       	call   80104d10 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
80106f9a:	8b 55 d8             	mov    -0x28(%ebp),%edx
  return &pgtab[PTX(va)];
80106f9d:	83 c4 10             	add    $0x10,%esp
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
80106fa0:	8d 82 00 00 00 80    	lea    -0x80000000(%edx),%eax
80106fa6:	83 c8 07             	or     $0x7,%eax
80106fa9:	89 07                	mov    %eax,(%edi)
  return &pgtab[PTX(va)];
80106fab:	89 d8                	mov    %ebx,%eax
80106fad:	c1 e8 0a             	shr    $0xa,%eax
80106fb0:	25 fc 0f 00 00       	and    $0xffc,%eax
80106fb5:	01 d0                	add    %edx,%eax
80106fb7:	eb 92                	jmp    80106f4b <mappages+0x4b>
80106fb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
}
80106fc0:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80106fc3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106fc8:	5b                   	pop    %ebx
80106fc9:	5e                   	pop    %esi
80106fca:	5f                   	pop    %edi
80106fcb:	5d                   	pop    %ebp
80106fcc:	c3                   	ret    
80106fcd:	8d 76 00             	lea    0x0(%esi),%esi
80106fd0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80106fd3:	31 c0                	xor    %eax,%eax
}
80106fd5:	5b                   	pop    %ebx
80106fd6:	5e                   	pop    %esi
80106fd7:	5f                   	pop    %edi
80106fd8:	5d                   	pop    %ebp
80106fd9:	c3                   	ret    
      panic("remap");
80106fda:	83 ec 0c             	sub    $0xc,%esp
80106fdd:	68 48 81 10 80       	push   $0x80108148
80106fe2:	e8 b9 93 ff ff       	call   801003a0 <panic>
80106fe7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106fee:	66 90                	xchg   %ax,%ax

80106ff0 <seginit>:
{
80106ff0:	55                   	push   %ebp
80106ff1:	89 e5                	mov    %esp,%ebp
80106ff3:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
80106ff6:	e8 05 d0 ff ff       	call   80104000 <cpuid>
  pd[0] = size-1;
80106ffb:	ba 2f 00 00 00       	mov    $0x2f,%edx
80107000:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
80107006:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
8010700a:	c7 80 58 34 11 80 ff 	movl   $0xffff,-0x7feecba8(%eax)
80107011:	ff 00 00 
80107014:	c7 80 5c 34 11 80 00 	movl   $0xcf9a00,-0x7feecba4(%eax)
8010701b:	9a cf 00 
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
8010701e:	c7 80 60 34 11 80 ff 	movl   $0xffff,-0x7feecba0(%eax)
80107025:	ff 00 00 
80107028:	c7 80 64 34 11 80 00 	movl   $0xcf9200,-0x7feecb9c(%eax)
8010702f:	92 cf 00 
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80107032:	c7 80 68 34 11 80 ff 	movl   $0xffff,-0x7feecb98(%eax)
80107039:	ff 00 00 
8010703c:	c7 80 6c 34 11 80 00 	movl   $0xcffa00,-0x7feecb94(%eax)
80107043:	fa cf 00 
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80107046:	c7 80 70 34 11 80 ff 	movl   $0xffff,-0x7feecb90(%eax)
8010704d:	ff 00 00 
80107050:	c7 80 74 34 11 80 00 	movl   $0xcff200,-0x7feecb8c(%eax)
80107057:	f2 cf 00 
  lgdt(c->gdt, sizeof(c->gdt));
8010705a:	05 50 34 11 80       	add    $0x80113450,%eax
  pd[1] = (uint)p;
8010705f:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80107063:	c1 e8 10             	shr    $0x10,%eax
80107066:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
8010706a:	8d 45 f2             	lea    -0xe(%ebp),%eax
8010706d:	0f 01 10             	lgdtl  (%eax)
}
80107070:	c9                   	leave  
80107071:	c3                   	ret    
80107072:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107079:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107080 <switchkvm>:
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80107080:	a1 04 61 11 80       	mov    0x80116104,%eax
80107085:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
8010708a:	0f 22 d8             	mov    %eax,%cr3
}
8010708d:	c3                   	ret    
8010708e:	66 90                	xchg   %ax,%ax

80107090 <switchuvm>:
{
80107090:	55                   	push   %ebp
80107091:	89 e5                	mov    %esp,%ebp
80107093:	57                   	push   %edi
80107094:	56                   	push   %esi
80107095:	53                   	push   %ebx
80107096:	83 ec 1c             	sub    $0x1c,%esp
80107099:	8b 75 08             	mov    0x8(%ebp),%esi
  if(p == 0)
8010709c:	85 f6                	test   %esi,%esi
8010709e:	0f 84 cb 00 00 00    	je     8010716f <switchuvm+0xdf>
  if(p->kstack == 0)
801070a4:	8b 46 08             	mov    0x8(%esi),%eax
801070a7:	85 c0                	test   %eax,%eax
801070a9:	0f 84 da 00 00 00    	je     80107189 <switchuvm+0xf9>
  if(p->pgdir == 0)
801070af:	8b 46 04             	mov    0x4(%esi),%eax
801070b2:	85 c0                	test   %eax,%eax
801070b4:	0f 84 c2 00 00 00    	je     8010717c <switchuvm+0xec>
  pushcli();
801070ba:	e8 41 da ff ff       	call   80104b00 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
801070bf:	e8 dc ce ff ff       	call   80103fa0 <mycpu>
801070c4:	89 c3                	mov    %eax,%ebx
801070c6:	e8 d5 ce ff ff       	call   80103fa0 <mycpu>
801070cb:	89 c7                	mov    %eax,%edi
801070cd:	e8 ce ce ff ff       	call   80103fa0 <mycpu>
801070d2:	83 c7 08             	add    $0x8,%edi
801070d5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801070d8:	e8 c3 ce ff ff       	call   80103fa0 <mycpu>
801070dd:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801070e0:	ba 67 00 00 00       	mov    $0x67,%edx
801070e5:	66 89 bb 9a 00 00 00 	mov    %di,0x9a(%ebx)
801070ec:	83 c0 08             	add    $0x8,%eax
801070ef:	66 89 93 98 00 00 00 	mov    %dx,0x98(%ebx)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
801070f6:	bf ff ff ff ff       	mov    $0xffffffff,%edi
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
801070fb:	83 c1 08             	add    $0x8,%ecx
801070fe:	c1 e8 18             	shr    $0x18,%eax
80107101:	c1 e9 10             	shr    $0x10,%ecx
80107104:	88 83 9f 00 00 00    	mov    %al,0x9f(%ebx)
8010710a:	88 8b 9c 00 00 00    	mov    %cl,0x9c(%ebx)
80107110:	b9 99 40 00 00       	mov    $0x4099,%ecx
80107115:	66 89 8b 9d 00 00 00 	mov    %cx,0x9d(%ebx)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
8010711c:	bb 10 00 00 00       	mov    $0x10,%ebx
  mycpu()->gdt[SEG_TSS].s = 0;
80107121:	e8 7a ce ff ff       	call   80103fa0 <mycpu>
80107126:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
8010712d:	e8 6e ce ff ff       	call   80103fa0 <mycpu>
80107132:	66 89 58 10          	mov    %bx,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
80107136:	8b 5e 08             	mov    0x8(%esi),%ebx
80107139:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010713f:	e8 5c ce ff ff       	call   80103fa0 <mycpu>
80107144:	89 58 0c             	mov    %ebx,0xc(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80107147:	e8 54 ce ff ff       	call   80103fa0 <mycpu>
8010714c:	66 89 78 6e          	mov    %di,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
80107150:	b8 28 00 00 00       	mov    $0x28,%eax
80107155:	0f 00 d8             	ltr    %ax
  lcr3(V2P(p->pgdir));  // switch to process's address space
80107158:	8b 46 04             	mov    0x4(%esi),%eax
8010715b:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
80107160:	0f 22 d8             	mov    %eax,%cr3
}
80107163:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107166:	5b                   	pop    %ebx
80107167:	5e                   	pop    %esi
80107168:	5f                   	pop    %edi
80107169:	5d                   	pop    %ebp
  popcli();
8010716a:	e9 e1 d9 ff ff       	jmp    80104b50 <popcli>
    panic("switchuvm: no process");
8010716f:	83 ec 0c             	sub    $0xc,%esp
80107172:	68 4e 81 10 80       	push   $0x8010814e
80107177:	e8 24 92 ff ff       	call   801003a0 <panic>
    panic("switchuvm: no pgdir");
8010717c:	83 ec 0c             	sub    $0xc,%esp
8010717f:	68 79 81 10 80       	push   $0x80108179
80107184:	e8 17 92 ff ff       	call   801003a0 <panic>
    panic("switchuvm: no kstack");
80107189:	83 ec 0c             	sub    $0xc,%esp
8010718c:	68 64 81 10 80       	push   $0x80108164
80107191:	e8 0a 92 ff ff       	call   801003a0 <panic>
80107196:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010719d:	8d 76 00             	lea    0x0(%esi),%esi

801071a0 <inituvm>:
{
801071a0:	55                   	push   %ebp
801071a1:	89 e5                	mov    %esp,%ebp
801071a3:	57                   	push   %edi
801071a4:	56                   	push   %esi
801071a5:	53                   	push   %ebx
801071a6:	83 ec 1c             	sub    $0x1c,%esp
801071a9:	8b 45 0c             	mov    0xc(%ebp),%eax
801071ac:	8b 75 10             	mov    0x10(%ebp),%esi
801071af:	8b 7d 08             	mov    0x8(%ebp),%edi
801071b2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(sz >= PGSIZE)
801071b5:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
801071bb:	77 4b                	ja     80107208 <inituvm+0x68>
  mem = kalloc();
801071bd:	e8 6e bb ff ff       	call   80102d30 <kalloc>
  memset(mem, 0, PGSIZE);
801071c2:	83 ec 04             	sub    $0x4,%esp
801071c5:	68 00 10 00 00       	push   $0x1000
  mem = kalloc();
801071ca:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
801071cc:	6a 00                	push   $0x0
801071ce:	50                   	push   %eax
801071cf:	e8 3c db ff ff       	call   80104d10 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
801071d4:	58                   	pop    %eax
801071d5:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801071db:	5a                   	pop    %edx
801071dc:	6a 06                	push   $0x6
801071de:	b9 00 10 00 00       	mov    $0x1000,%ecx
801071e3:	31 d2                	xor    %edx,%edx
801071e5:	50                   	push   %eax
801071e6:	89 f8                	mov    %edi,%eax
801071e8:	e8 13 fd ff ff       	call   80106f00 <mappages>
  memmove(mem, init, sz);
801071ed:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801071f0:	89 75 10             	mov    %esi,0x10(%ebp)
801071f3:	83 c4 10             	add    $0x10,%esp
801071f6:	89 5d 08             	mov    %ebx,0x8(%ebp)
801071f9:	89 45 0c             	mov    %eax,0xc(%ebp)
}
801071fc:	8d 65 f4             	lea    -0xc(%ebp),%esp
801071ff:	5b                   	pop    %ebx
80107200:	5e                   	pop    %esi
80107201:	5f                   	pop    %edi
80107202:	5d                   	pop    %ebp
  memmove(mem, init, sz);
80107203:	e9 a8 db ff ff       	jmp    80104db0 <memmove>
    panic("inituvm: more than a page");
80107208:	83 ec 0c             	sub    $0xc,%esp
8010720b:	68 8d 81 10 80       	push   $0x8010818d
80107210:	e8 8b 91 ff ff       	call   801003a0 <panic>
80107215:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010721c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80107220 <loaduvm>:
{
80107220:	55                   	push   %ebp
80107221:	89 e5                	mov    %esp,%ebp
80107223:	57                   	push   %edi
80107224:	56                   	push   %esi
80107225:	53                   	push   %ebx
80107226:	83 ec 1c             	sub    $0x1c,%esp
80107229:	8b 45 0c             	mov    0xc(%ebp),%eax
8010722c:	8b 75 18             	mov    0x18(%ebp),%esi
  if((uint) addr % PGSIZE != 0)
8010722f:	a9 ff 0f 00 00       	test   $0xfff,%eax
80107234:	0f 85 bb 00 00 00    	jne    801072f5 <loaduvm+0xd5>
  for(i = 0; i < sz; i += PGSIZE){
8010723a:	01 f0                	add    %esi,%eax
8010723c:	89 f3                	mov    %esi,%ebx
8010723e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(readi(ip, P2V(pa), offset+i, n) != n)
80107241:	8b 45 14             	mov    0x14(%ebp),%eax
80107244:	01 f0                	add    %esi,%eax
80107246:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(i = 0; i < sz; i += PGSIZE){
80107249:	85 f6                	test   %esi,%esi
8010724b:	0f 84 87 00 00 00    	je     801072d8 <loaduvm+0xb8>
80107251:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  pde = &pgdir[PDX(va)];
80107258:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  if(*pde & PTE_P){
8010725b:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010725e:	29 d8                	sub    %ebx,%eax
  pde = &pgdir[PDX(va)];
80107260:	89 c2                	mov    %eax,%edx
80107262:	c1 ea 16             	shr    $0x16,%edx
  if(*pde & PTE_P){
80107265:	8b 14 91             	mov    (%ecx,%edx,4),%edx
80107268:	f6 c2 01             	test   $0x1,%dl
8010726b:	75 13                	jne    80107280 <loaduvm+0x60>
      panic("loaduvm: address should exist");
8010726d:	83 ec 0c             	sub    $0xc,%esp
80107270:	68 a7 81 10 80       	push   $0x801081a7
80107275:	e8 26 91 ff ff       	call   801003a0 <panic>
8010727a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return &pgtab[PTX(va)];
80107280:	c1 e8 0a             	shr    $0xa,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107283:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  return &pgtab[PTX(va)];
80107289:	25 fc 0f 00 00       	and    $0xffc,%eax
8010728e:	8d 84 02 00 00 00 80 	lea    -0x80000000(%edx,%eax,1),%eax
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80107295:	85 c0                	test   %eax,%eax
80107297:	74 d4                	je     8010726d <loaduvm+0x4d>
    pa = PTE_ADDR(*pte);
80107299:	8b 00                	mov    (%eax),%eax
    if(readi(ip, P2V(pa), offset+i, n) != n)
8010729b:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    if(sz - i < PGSIZE)
8010729e:	bf 00 10 00 00       	mov    $0x1000,%edi
    pa = PTE_ADDR(*pte);
801072a3:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
801072a8:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
801072ae:	0f 46 fb             	cmovbe %ebx,%edi
    if(readi(ip, P2V(pa), offset+i, n) != n)
801072b1:	29 d9                	sub    %ebx,%ecx
801072b3:	05 00 00 00 80       	add    $0x80000000,%eax
801072b8:	57                   	push   %edi
801072b9:	51                   	push   %ecx
801072ba:	50                   	push   %eax
801072bb:	ff 75 10             	push   0x10(%ebp)
801072be:	e8 7d ae ff ff       	call   80102140 <readi>
801072c3:	83 c4 10             	add    $0x10,%esp
801072c6:	39 f8                	cmp    %edi,%eax
801072c8:	75 1e                	jne    801072e8 <loaduvm+0xc8>
  for(i = 0; i < sz; i += PGSIZE){
801072ca:	81 eb 00 10 00 00    	sub    $0x1000,%ebx
801072d0:	89 f0                	mov    %esi,%eax
801072d2:	29 d8                	sub    %ebx,%eax
801072d4:	39 c6                	cmp    %eax,%esi
801072d6:	77 80                	ja     80107258 <loaduvm+0x38>
}
801072d8:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801072db:	31 c0                	xor    %eax,%eax
}
801072dd:	5b                   	pop    %ebx
801072de:	5e                   	pop    %esi
801072df:	5f                   	pop    %edi
801072e0:	5d                   	pop    %ebp
801072e1:	c3                   	ret    
801072e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801072e8:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
801072eb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801072f0:	5b                   	pop    %ebx
801072f1:	5e                   	pop    %esi
801072f2:	5f                   	pop    %edi
801072f3:	5d                   	pop    %ebp
801072f4:	c3                   	ret    
    panic("loaduvm: addr must be page aligned");
801072f5:	83 ec 0c             	sub    $0xc,%esp
801072f8:	68 48 82 10 80       	push   $0x80108248
801072fd:	e8 9e 90 ff ff       	call   801003a0 <panic>
80107302:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107309:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107310 <allocuvm>:
{
80107310:	55                   	push   %ebp
80107311:	89 e5                	mov    %esp,%ebp
80107313:	57                   	push   %edi
80107314:	56                   	push   %esi
80107315:	53                   	push   %ebx
80107316:	83 ec 1c             	sub    $0x1c,%esp
  if(newsz >= KERNBASE)
80107319:	8b 45 10             	mov    0x10(%ebp),%eax
{
8010731c:	8b 7d 08             	mov    0x8(%ebp),%edi
  if(newsz >= KERNBASE)
8010731f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107322:	85 c0                	test   %eax,%eax
80107324:	0f 88 b6 00 00 00    	js     801073e0 <allocuvm+0xd0>
  if(newsz < oldsz)
8010732a:	3b 45 0c             	cmp    0xc(%ebp),%eax
    return oldsz;
8010732d:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(newsz < oldsz)
80107330:	0f 82 9a 00 00 00    	jb     801073d0 <allocuvm+0xc0>
  a = PGROUNDUP(oldsz);
80107336:	8d b0 ff 0f 00 00    	lea    0xfff(%eax),%esi
8010733c:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
  for(; a < newsz; a += PGSIZE){
80107342:	39 75 10             	cmp    %esi,0x10(%ebp)
80107345:	77 44                	ja     8010738b <allocuvm+0x7b>
80107347:	e9 87 00 00 00       	jmp    801073d3 <allocuvm+0xc3>
8010734c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    memset(mem, 0, PGSIZE);
80107350:	83 ec 04             	sub    $0x4,%esp
80107353:	68 00 10 00 00       	push   $0x1000
80107358:	6a 00                	push   $0x0
8010735a:	50                   	push   %eax
8010735b:	e8 b0 d9 ff ff       	call   80104d10 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80107360:	58                   	pop    %eax
80107361:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80107367:	5a                   	pop    %edx
80107368:	6a 06                	push   $0x6
8010736a:	b9 00 10 00 00       	mov    $0x1000,%ecx
8010736f:	89 f2                	mov    %esi,%edx
80107371:	50                   	push   %eax
80107372:	89 f8                	mov    %edi,%eax
80107374:	e8 87 fb ff ff       	call   80106f00 <mappages>
80107379:	83 c4 10             	add    $0x10,%esp
8010737c:	85 c0                	test   %eax,%eax
8010737e:	78 78                	js     801073f8 <allocuvm+0xe8>
  for(; a < newsz; a += PGSIZE){
80107380:	81 c6 00 10 00 00    	add    $0x1000,%esi
80107386:	39 75 10             	cmp    %esi,0x10(%ebp)
80107389:	76 48                	jbe    801073d3 <allocuvm+0xc3>
    mem = kalloc();
8010738b:	e8 a0 b9 ff ff       	call   80102d30 <kalloc>
80107390:	89 c3                	mov    %eax,%ebx
    if(mem == 0){
80107392:	85 c0                	test   %eax,%eax
80107394:	75 ba                	jne    80107350 <allocuvm+0x40>
      cprintf("allocuvm out of memory\n");
80107396:	83 ec 0c             	sub    $0xc,%esp
80107399:	68 c5 81 10 80       	push   $0x801081c5
8010739e:	e8 ad 93 ff ff       	call   80100750 <cprintf>
  if(newsz >= oldsz)
801073a3:	8b 45 0c             	mov    0xc(%ebp),%eax
801073a6:	83 c4 10             	add    $0x10,%esp
801073a9:	39 45 10             	cmp    %eax,0x10(%ebp)
801073ac:	74 32                	je     801073e0 <allocuvm+0xd0>
801073ae:	8b 55 10             	mov    0x10(%ebp),%edx
801073b1:	89 c1                	mov    %eax,%ecx
801073b3:	89 f8                	mov    %edi,%eax
801073b5:	e8 96 fa ff ff       	call   80106e50 <deallocuvm.part.0>
      return 0;
801073ba:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
}
801073c1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801073c4:	8d 65 f4             	lea    -0xc(%ebp),%esp
801073c7:	5b                   	pop    %ebx
801073c8:	5e                   	pop    %esi
801073c9:	5f                   	pop    %edi
801073ca:	5d                   	pop    %ebp
801073cb:	c3                   	ret    
801073cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return oldsz;
801073d0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
}
801073d3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801073d6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801073d9:	5b                   	pop    %ebx
801073da:	5e                   	pop    %esi
801073db:	5f                   	pop    %edi
801073dc:	5d                   	pop    %ebp
801073dd:	c3                   	ret    
801073de:	66 90                	xchg   %ax,%ax
    return 0;
801073e0:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
}
801073e7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801073ea:	8d 65 f4             	lea    -0xc(%ebp),%esp
801073ed:	5b                   	pop    %ebx
801073ee:	5e                   	pop    %esi
801073ef:	5f                   	pop    %edi
801073f0:	5d                   	pop    %ebp
801073f1:	c3                   	ret    
801073f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      cprintf("allocuvm out of memory (2)\n");
801073f8:	83 ec 0c             	sub    $0xc,%esp
801073fb:	68 dd 81 10 80       	push   $0x801081dd
80107400:	e8 4b 93 ff ff       	call   80100750 <cprintf>
  if(newsz >= oldsz)
80107405:	8b 45 0c             	mov    0xc(%ebp),%eax
80107408:	83 c4 10             	add    $0x10,%esp
8010740b:	39 45 10             	cmp    %eax,0x10(%ebp)
8010740e:	74 0c                	je     8010741c <allocuvm+0x10c>
80107410:	8b 55 10             	mov    0x10(%ebp),%edx
80107413:	89 c1                	mov    %eax,%ecx
80107415:	89 f8                	mov    %edi,%eax
80107417:	e8 34 fa ff ff       	call   80106e50 <deallocuvm.part.0>
      kfree(mem);
8010741c:	83 ec 0c             	sub    $0xc,%esp
8010741f:	53                   	push   %ebx
80107420:	e8 4b b7 ff ff       	call   80102b70 <kfree>
      return 0;
80107425:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
8010742c:	83 c4 10             	add    $0x10,%esp
}
8010742f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107432:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107435:	5b                   	pop    %ebx
80107436:	5e                   	pop    %esi
80107437:	5f                   	pop    %edi
80107438:	5d                   	pop    %ebp
80107439:	c3                   	ret    
8010743a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107440 <deallocuvm>:
{
80107440:	55                   	push   %ebp
80107441:	89 e5                	mov    %esp,%ebp
80107443:	8b 55 0c             	mov    0xc(%ebp),%edx
80107446:	8b 4d 10             	mov    0x10(%ebp),%ecx
80107449:	8b 45 08             	mov    0x8(%ebp),%eax
  if(newsz >= oldsz)
8010744c:	39 d1                	cmp    %edx,%ecx
8010744e:	73 10                	jae    80107460 <deallocuvm+0x20>
}
80107450:	5d                   	pop    %ebp
80107451:	e9 fa f9 ff ff       	jmp    80106e50 <deallocuvm.part.0>
80107456:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010745d:	8d 76 00             	lea    0x0(%esi),%esi
80107460:	89 d0                	mov    %edx,%eax
80107462:	5d                   	pop    %ebp
80107463:	c3                   	ret    
80107464:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010746b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010746f:	90                   	nop

80107470 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80107470:	55                   	push   %ebp
80107471:	89 e5                	mov    %esp,%ebp
80107473:	57                   	push   %edi
80107474:	56                   	push   %esi
80107475:	53                   	push   %ebx
80107476:	83 ec 0c             	sub    $0xc,%esp
80107479:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
8010747c:	85 f6                	test   %esi,%esi
8010747e:	74 59                	je     801074d9 <freevm+0x69>
  if(newsz >= oldsz)
80107480:	31 c9                	xor    %ecx,%ecx
80107482:	ba 00 00 00 80       	mov    $0x80000000,%edx
80107487:	89 f0                	mov    %esi,%eax
80107489:	89 f3                	mov    %esi,%ebx
8010748b:	e8 c0 f9 ff ff       	call   80106e50 <deallocuvm.part.0>
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80107490:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
80107496:	eb 0f                	jmp    801074a7 <freevm+0x37>
80107498:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010749f:	90                   	nop
801074a0:	83 c3 04             	add    $0x4,%ebx
801074a3:	39 df                	cmp    %ebx,%edi
801074a5:	74 23                	je     801074ca <freevm+0x5a>
    if(pgdir[i] & PTE_P){
801074a7:	8b 03                	mov    (%ebx),%eax
801074a9:	a8 01                	test   $0x1,%al
801074ab:	74 f3                	je     801074a0 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
801074ad:	25 00 f0 ff ff       	and    $0xfffff000,%eax
      kfree(v);
801074b2:	83 ec 0c             	sub    $0xc,%esp
  for(i = 0; i < NPDENTRIES; i++){
801074b5:	83 c3 04             	add    $0x4,%ebx
      char * v = P2V(PTE_ADDR(pgdir[i]));
801074b8:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
801074bd:	50                   	push   %eax
801074be:	e8 ad b6 ff ff       	call   80102b70 <kfree>
801074c3:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
801074c6:	39 df                	cmp    %ebx,%edi
801074c8:	75 dd                	jne    801074a7 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
801074ca:	89 75 08             	mov    %esi,0x8(%ebp)
}
801074cd:	8d 65 f4             	lea    -0xc(%ebp),%esp
801074d0:	5b                   	pop    %ebx
801074d1:	5e                   	pop    %esi
801074d2:	5f                   	pop    %edi
801074d3:	5d                   	pop    %ebp
  kfree((char*)pgdir);
801074d4:	e9 97 b6 ff ff       	jmp    80102b70 <kfree>
    panic("freevm: no pgdir");
801074d9:	83 ec 0c             	sub    $0xc,%esp
801074dc:	68 f9 81 10 80       	push   $0x801081f9
801074e1:	e8 ba 8e ff ff       	call   801003a0 <panic>
801074e6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801074ed:	8d 76 00             	lea    0x0(%esi),%esi

801074f0 <setupkvm>:
{
801074f0:	55                   	push   %ebp
801074f1:	89 e5                	mov    %esp,%ebp
801074f3:	56                   	push   %esi
801074f4:	53                   	push   %ebx
  if((pgdir = (pde_t*)kalloc()) == 0)
801074f5:	e8 36 b8 ff ff       	call   80102d30 <kalloc>
801074fa:	89 c6                	mov    %eax,%esi
801074fc:	85 c0                	test   %eax,%eax
801074fe:	74 42                	je     80107542 <setupkvm+0x52>
  memset(pgdir, 0, PGSIZE);
80107500:	83 ec 04             	sub    $0x4,%esp
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107503:	bb 20 b4 10 80       	mov    $0x8010b420,%ebx
  memset(pgdir, 0, PGSIZE);
80107508:	68 00 10 00 00       	push   $0x1000
8010750d:	6a 00                	push   $0x0
8010750f:	50                   	push   %eax
80107510:	e8 fb d7 ff ff       	call   80104d10 <memset>
80107515:	83 c4 10             	add    $0x10,%esp
                (uint)k->phys_start, k->perm) < 0) {
80107518:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
8010751b:	83 ec 08             	sub    $0x8,%esp
8010751e:	8b 4b 08             	mov    0x8(%ebx),%ecx
80107521:	ff 73 0c             	push   0xc(%ebx)
80107524:	8b 13                	mov    (%ebx),%edx
80107526:	50                   	push   %eax
80107527:	29 c1                	sub    %eax,%ecx
80107529:	89 f0                	mov    %esi,%eax
8010752b:	e8 d0 f9 ff ff       	call   80106f00 <mappages>
80107530:	83 c4 10             	add    $0x10,%esp
80107533:	85 c0                	test   %eax,%eax
80107535:	78 19                	js     80107550 <setupkvm+0x60>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107537:	83 c3 10             	add    $0x10,%ebx
8010753a:	81 fb 60 b4 10 80    	cmp    $0x8010b460,%ebx
80107540:	75 d6                	jne    80107518 <setupkvm+0x28>
}
80107542:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107545:	89 f0                	mov    %esi,%eax
80107547:	5b                   	pop    %ebx
80107548:	5e                   	pop    %esi
80107549:	5d                   	pop    %ebp
8010754a:	c3                   	ret    
8010754b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010754f:	90                   	nop
      freevm(pgdir);
80107550:	83 ec 0c             	sub    $0xc,%esp
80107553:	56                   	push   %esi
      return 0;
80107554:	31 f6                	xor    %esi,%esi
      freevm(pgdir);
80107556:	e8 15 ff ff ff       	call   80107470 <freevm>
      return 0;
8010755b:	83 c4 10             	add    $0x10,%esp
}
8010755e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107561:	89 f0                	mov    %esi,%eax
80107563:	5b                   	pop    %ebx
80107564:	5e                   	pop    %esi
80107565:	5d                   	pop    %ebp
80107566:	c3                   	ret    
80107567:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010756e:	66 90                	xchg   %ax,%ax

80107570 <kvmalloc>:
{
80107570:	55                   	push   %ebp
80107571:	89 e5                	mov    %esp,%ebp
80107573:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80107576:	e8 75 ff ff ff       	call   801074f0 <setupkvm>
8010757b:	a3 04 61 11 80       	mov    %eax,0x80116104
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80107580:	05 00 00 00 80       	add    $0x80000000,%eax
80107585:	0f 22 d8             	mov    %eax,%cr3
}
80107588:	c9                   	leave  
80107589:	c3                   	ret    
8010758a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107590 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80107590:	55                   	push   %ebp
80107591:	89 e5                	mov    %esp,%ebp
80107593:	83 ec 08             	sub    $0x8,%esp
80107596:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(*pde & PTE_P){
80107599:	8b 55 08             	mov    0x8(%ebp),%edx
  pde = &pgdir[PDX(va)];
8010759c:	89 c1                	mov    %eax,%ecx
8010759e:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
801075a1:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
801075a4:	f6 c2 01             	test   $0x1,%dl
801075a7:	75 17                	jne    801075c0 <clearpteu+0x30>
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
  if(pte == 0)
    panic("clearpteu");
801075a9:	83 ec 0c             	sub    $0xc,%esp
801075ac:	68 0a 82 10 80       	push   $0x8010820a
801075b1:	e8 ea 8d ff ff       	call   801003a0 <panic>
801075b6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801075bd:	8d 76 00             	lea    0x0(%esi),%esi
  return &pgtab[PTX(va)];
801075c0:	c1 e8 0a             	shr    $0xa,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
801075c3:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  return &pgtab[PTX(va)];
801075c9:	25 fc 0f 00 00       	and    $0xffc,%eax
801075ce:	8d 84 02 00 00 00 80 	lea    -0x80000000(%edx,%eax,1),%eax
  if(pte == 0)
801075d5:	85 c0                	test   %eax,%eax
801075d7:	74 d0                	je     801075a9 <clearpteu+0x19>
  *pte &= ~PTE_U;
801075d9:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
801075dc:	c9                   	leave  
801075dd:	c3                   	ret    
801075de:	66 90                	xchg   %ax,%ax

801075e0 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
801075e0:	55                   	push   %ebp
801075e1:	89 e5                	mov    %esp,%ebp
801075e3:	57                   	push   %edi
801075e4:	56                   	push   %esi
801075e5:	53                   	push   %ebx
801075e6:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
801075e9:	e8 02 ff ff ff       	call   801074f0 <setupkvm>
801075ee:	89 45 e0             	mov    %eax,-0x20(%ebp)
801075f1:	85 c0                	test   %eax,%eax
801075f3:	0f 84 bd 00 00 00    	je     801076b6 <copyuvm+0xd6>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
801075f9:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801075fc:	85 c9                	test   %ecx,%ecx
801075fe:	0f 84 b2 00 00 00    	je     801076b6 <copyuvm+0xd6>
80107604:	31 f6                	xor    %esi,%esi
80107606:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010760d:	8d 76 00             	lea    0x0(%esi),%esi
  if(*pde & PTE_P){
80107610:	8b 4d 08             	mov    0x8(%ebp),%ecx
  pde = &pgdir[PDX(va)];
80107613:	89 f0                	mov    %esi,%eax
80107615:	c1 e8 16             	shr    $0x16,%eax
  if(*pde & PTE_P){
80107618:	8b 04 81             	mov    (%ecx,%eax,4),%eax
8010761b:	a8 01                	test   $0x1,%al
8010761d:	75 11                	jne    80107630 <copyuvm+0x50>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
8010761f:	83 ec 0c             	sub    $0xc,%esp
80107622:	68 14 82 10 80       	push   $0x80108214
80107627:	e8 74 8d ff ff       	call   801003a0 <panic>
8010762c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  return &pgtab[PTX(va)];
80107630:	89 f2                	mov    %esi,%edx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107632:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
80107637:	c1 ea 0a             	shr    $0xa,%edx
8010763a:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80107640:	8d 84 10 00 00 00 80 	lea    -0x80000000(%eax,%edx,1),%eax
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80107647:	85 c0                	test   %eax,%eax
80107649:	74 d4                	je     8010761f <copyuvm+0x3f>
    if(!(*pte & PTE_P))
8010764b:	8b 00                	mov    (%eax),%eax
8010764d:	a8 01                	test   $0x1,%al
8010764f:	0f 84 9f 00 00 00    	je     801076f4 <copyuvm+0x114>
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
80107655:	89 c7                	mov    %eax,%edi
    flags = PTE_FLAGS(*pte);
80107657:	25 ff 0f 00 00       	and    $0xfff,%eax
8010765c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    pa = PTE_ADDR(*pte);
8010765f:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
    if((mem = kalloc()) == 0)
80107665:	e8 c6 b6 ff ff       	call   80102d30 <kalloc>
8010766a:	89 c3                	mov    %eax,%ebx
8010766c:	85 c0                	test   %eax,%eax
8010766e:	74 64                	je     801076d4 <copyuvm+0xf4>
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80107670:	83 ec 04             	sub    $0x4,%esp
80107673:	81 c7 00 00 00 80    	add    $0x80000000,%edi
80107679:	68 00 10 00 00       	push   $0x1000
8010767e:	57                   	push   %edi
8010767f:	50                   	push   %eax
80107680:	e8 2b d7 ff ff       	call   80104db0 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
80107685:	58                   	pop    %eax
80107686:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
8010768c:	5a                   	pop    %edx
8010768d:	ff 75 e4             	push   -0x1c(%ebp)
80107690:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107695:	89 f2                	mov    %esi,%edx
80107697:	50                   	push   %eax
80107698:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010769b:	e8 60 f8 ff ff       	call   80106f00 <mappages>
801076a0:	83 c4 10             	add    $0x10,%esp
801076a3:	85 c0                	test   %eax,%eax
801076a5:	78 21                	js     801076c8 <copyuvm+0xe8>
  for(i = 0; i < sz; i += PGSIZE){
801076a7:	81 c6 00 10 00 00    	add    $0x1000,%esi
801076ad:	39 75 0c             	cmp    %esi,0xc(%ebp)
801076b0:	0f 87 5a ff ff ff    	ja     80107610 <copyuvm+0x30>
  return d;

bad:
  freevm(d);
  return 0;
}
801076b6:	8b 45 e0             	mov    -0x20(%ebp),%eax
801076b9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801076bc:	5b                   	pop    %ebx
801076bd:	5e                   	pop    %esi
801076be:	5f                   	pop    %edi
801076bf:	5d                   	pop    %ebp
801076c0:	c3                   	ret    
801076c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      kfree(mem);
801076c8:	83 ec 0c             	sub    $0xc,%esp
801076cb:	53                   	push   %ebx
801076cc:	e8 9f b4 ff ff       	call   80102b70 <kfree>
      goto bad;
801076d1:	83 c4 10             	add    $0x10,%esp
  freevm(d);
801076d4:	83 ec 0c             	sub    $0xc,%esp
801076d7:	ff 75 e0             	push   -0x20(%ebp)
801076da:	e8 91 fd ff ff       	call   80107470 <freevm>
  return 0;
801076df:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
801076e6:	83 c4 10             	add    $0x10,%esp
}
801076e9:	8b 45 e0             	mov    -0x20(%ebp),%eax
801076ec:	8d 65 f4             	lea    -0xc(%ebp),%esp
801076ef:	5b                   	pop    %ebx
801076f0:	5e                   	pop    %esi
801076f1:	5f                   	pop    %edi
801076f2:	5d                   	pop    %ebp
801076f3:	c3                   	ret    
      panic("copyuvm: page not present");
801076f4:	83 ec 0c             	sub    $0xc,%esp
801076f7:	68 2e 82 10 80       	push   $0x8010822e
801076fc:	e8 9f 8c ff ff       	call   801003a0 <panic>
80107701:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107708:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010770f:	90                   	nop

80107710 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80107710:	55                   	push   %ebp
80107711:	89 e5                	mov    %esp,%ebp
80107713:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(*pde & PTE_P){
80107716:	8b 55 08             	mov    0x8(%ebp),%edx
  pde = &pgdir[PDX(va)];
80107719:	89 c1                	mov    %eax,%ecx
8010771b:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
8010771e:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
80107721:	f6 c2 01             	test   $0x1,%dl
80107724:	0f 84 00 01 00 00    	je     8010782a <uva2ka.cold>
  return &pgtab[PTX(va)];
8010772a:	c1 e8 0c             	shr    $0xc,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
8010772d:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  if((*pte & PTE_P) == 0)
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
}
80107733:	5d                   	pop    %ebp
  return &pgtab[PTX(va)];
80107734:	25 ff 03 00 00       	and    $0x3ff,%eax
  if((*pte & PTE_P) == 0)
80107739:	8b 84 82 00 00 00 80 	mov    -0x80000000(%edx,%eax,4),%eax
  if((*pte & PTE_U) == 0)
80107740:	89 c2                	mov    %eax,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80107742:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((*pte & PTE_U) == 0)
80107747:	83 e2 05             	and    $0x5,%edx
  return (char*)P2V(PTE_ADDR(*pte));
8010774a:	05 00 00 00 80       	add    $0x80000000,%eax
8010774f:	83 fa 05             	cmp    $0x5,%edx
80107752:	ba 00 00 00 00       	mov    $0x0,%edx
80107757:	0f 45 c2             	cmovne %edx,%eax
}
8010775a:	c3                   	ret    
8010775b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010775f:	90                   	nop

80107760 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80107760:	55                   	push   %ebp
80107761:	89 e5                	mov    %esp,%ebp
80107763:	57                   	push   %edi
80107764:	56                   	push   %esi
80107765:	53                   	push   %ebx
80107766:	83 ec 0c             	sub    $0xc,%esp
80107769:	8b 75 14             	mov    0x14(%ebp),%esi
8010776c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010776f:	8b 55 10             	mov    0x10(%ebp),%edx
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80107772:	85 f6                	test   %esi,%esi
80107774:	75 51                	jne    801077c7 <copyout+0x67>
80107776:	e9 a5 00 00 00       	jmp    80107820 <copyout+0xc0>
8010777b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010777f:	90                   	nop
  return (char*)P2V(PTE_ADDR(*pte));
80107780:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
80107786:	8d 8b 00 00 00 80    	lea    -0x80000000(%ebx),%ecx
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
8010778c:	81 fb 00 00 00 80    	cmp    $0x80000000,%ebx
80107792:	74 75                	je     80107809 <copyout+0xa9>
      return -1;
    n = PGSIZE - (va - va0);
80107794:	89 fb                	mov    %edi,%ebx
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80107796:	89 55 10             	mov    %edx,0x10(%ebp)
    n = PGSIZE - (va - va0);
80107799:	29 c3                	sub    %eax,%ebx
8010779b:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801077a1:	39 f3                	cmp    %esi,%ebx
801077a3:	0f 47 de             	cmova  %esi,%ebx
    memmove(pa0 + (va - va0), buf, n);
801077a6:	29 f8                	sub    %edi,%eax
801077a8:	83 ec 04             	sub    $0x4,%esp
801077ab:	01 c1                	add    %eax,%ecx
801077ad:	53                   	push   %ebx
801077ae:	52                   	push   %edx
801077af:	51                   	push   %ecx
801077b0:	e8 fb d5 ff ff       	call   80104db0 <memmove>
    len -= n;
    buf += n;
801077b5:	8b 55 10             	mov    0x10(%ebp),%edx
    va = va0 + PGSIZE;
801077b8:	8d 87 00 10 00 00    	lea    0x1000(%edi),%eax
  while(len > 0){
801077be:	83 c4 10             	add    $0x10,%esp
    buf += n;
801077c1:	01 da                	add    %ebx,%edx
  while(len > 0){
801077c3:	29 de                	sub    %ebx,%esi
801077c5:	74 59                	je     80107820 <copyout+0xc0>
  if(*pde & PTE_P){
801077c7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pde = &pgdir[PDX(va)];
801077ca:	89 c1                	mov    %eax,%ecx
    va0 = (uint)PGROUNDDOWN(va);
801077cc:	89 c7                	mov    %eax,%edi
  pde = &pgdir[PDX(va)];
801077ce:	c1 e9 16             	shr    $0x16,%ecx
    va0 = (uint)PGROUNDDOWN(va);
801077d1:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
  if(*pde & PTE_P){
801077d7:	8b 0c 8b             	mov    (%ebx,%ecx,4),%ecx
801077da:	f6 c1 01             	test   $0x1,%cl
801077dd:	0f 84 4e 00 00 00    	je     80107831 <copyout.cold>
  return &pgtab[PTX(va)];
801077e3:	89 fb                	mov    %edi,%ebx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
801077e5:	81 e1 00 f0 ff ff    	and    $0xfffff000,%ecx
  return &pgtab[PTX(va)];
801077eb:	c1 eb 0c             	shr    $0xc,%ebx
801077ee:	81 e3 ff 03 00 00    	and    $0x3ff,%ebx
  if((*pte & PTE_P) == 0)
801077f4:	8b 9c 99 00 00 00 80 	mov    -0x80000000(%ecx,%ebx,4),%ebx
  if((*pte & PTE_U) == 0)
801077fb:	89 d9                	mov    %ebx,%ecx
801077fd:	83 e1 05             	and    $0x5,%ecx
80107800:	83 f9 05             	cmp    $0x5,%ecx
80107803:	0f 84 77 ff ff ff    	je     80107780 <copyout+0x20>
  }
  return 0;
}
80107809:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
8010780c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107811:	5b                   	pop    %ebx
80107812:	5e                   	pop    %esi
80107813:	5f                   	pop    %edi
80107814:	5d                   	pop    %ebp
80107815:	c3                   	ret    
80107816:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010781d:	8d 76 00             	lea    0x0(%esi),%esi
80107820:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80107823:	31 c0                	xor    %eax,%eax
}
80107825:	5b                   	pop    %ebx
80107826:	5e                   	pop    %esi
80107827:	5f                   	pop    %edi
80107828:	5d                   	pop    %ebp
80107829:	c3                   	ret    

8010782a <uva2ka.cold>:
  if((*pte & PTE_P) == 0)
8010782a:	a1 00 00 00 00       	mov    0x0,%eax
8010782f:	0f 0b                	ud2    

80107831 <copyout.cold>:
80107831:	a1 00 00 00 00       	mov    0x0,%eax
80107836:	0f 0b                	ud2    
