
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
80100015:	b8 00 90 10 00       	mov    $0x109000,%eax
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
80100028:	bc d0 54 11 80       	mov    $0x801154d0,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
8010002d:	b8 70 33 10 80       	mov    $0x80103370,%eax
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
80100044:	bb 54 a5 10 80       	mov    $0x8010a554,%ebx
{
80100049:	83 ec 0c             	sub    $0xc,%esp
  initlock(&bcache.lock, "bcache");
8010004c:	68 a0 74 10 80       	push   $0x801074a0
80100051:	68 20 a5 10 80       	push   $0x8010a520
80100056:	e8 85 46 00 00       	call   801046e0 <initlock>
  bcache.head.next = &bcache.head;
8010005b:	83 c4 10             	add    $0x10,%esp
8010005e:	b8 1c ec 10 80       	mov    $0x8010ec1c,%eax
  bcache.head.prev = &bcache.head;
80100063:	c7 05 6c ec 10 80 1c 	movl   $0x8010ec1c,0x8010ec6c
8010006a:	ec 10 80 
  bcache.head.next = &bcache.head;
8010006d:	c7 05 70 ec 10 80 1c 	movl   $0x8010ec1c,0x8010ec70
80100074:	ec 10 80 
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
8010008b:	c7 43 50 1c ec 10 80 	movl   $0x8010ec1c,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
80100092:	68 a7 74 10 80       	push   $0x801074a7
80100097:	50                   	push   %eax
80100098:	e8 13 45 00 00       	call   801045b0 <initsleeplock>
    bcache.head.next->prev = b;
8010009d:	a1 70 ec 10 80       	mov    0x8010ec70,%eax
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000a2:	8d 93 5c 02 00 00    	lea    0x25c(%ebx),%edx
801000a8:	83 c4 10             	add    $0x10,%esp
    bcache.head.next->prev = b;
801000ab:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
801000ae:	89 d8                	mov    %ebx,%eax
801000b0:	89 1d 70 ec 10 80    	mov    %ebx,0x8010ec70
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000b6:	81 fb c0 e9 10 80    	cmp    $0x8010e9c0,%ebx
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
801000df:	68 20 a5 10 80       	push   $0x8010a520
801000e4:	e8 c7 47 00 00       	call   801048b0 <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000e9:	8b 1d 70 ec 10 80    	mov    0x8010ec70,%ebx
801000ef:	83 c4 10             	add    $0x10,%esp
801000f2:	81 fb 1c ec 10 80    	cmp    $0x8010ec1c,%ebx
801000f8:	75 11                	jne    8010010b <bread+0x3b>
801000fa:	eb 24                	jmp    80100120 <bread+0x50>
801000fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100100:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100103:	81 fb 1c ec 10 80    	cmp    $0x8010ec1c,%ebx
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
80100120:	8b 1d 6c ec 10 80    	mov    0x8010ec6c,%ebx
80100126:	81 fb 1c ec 10 80    	cmp    $0x8010ec1c,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x6b>
8010012e:	eb 6e                	jmp    8010019e <bread+0xce>
80100130:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100133:	81 fb 1c ec 10 80    	cmp    $0x8010ec1c,%ebx
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
8010015d:	68 20 a5 10 80       	push   $0x8010a520
80100162:	e8 e9 46 00 00       	call   80104850 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 7e 44 00 00       	call   801045f0 <acquiresleep>
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
8010018c:	e8 5f 24 00 00       	call   801025f0 <iderw>
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
801001a1:	68 ae 74 10 80       	push   $0x801074ae
801001a6:	e8 d5 01 00 00       	call   80100380 <panic>
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
801001be:	e8 cd 44 00 00       	call   80104690 <holdingsleep>
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
801001d4:	e9 17 24 00 00       	jmp    801025f0 <iderw>
    panic("bwrite");
801001d9:	83 ec 0c             	sub    $0xc,%esp
801001dc:	68 bf 74 10 80       	push   $0x801074bf
801001e1:	e8 9a 01 00 00       	call   80100380 <panic>
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
801001ff:	e8 8c 44 00 00       	call   80104690 <holdingsleep>
80100204:	83 c4 10             	add    $0x10,%esp
80100207:	85 c0                	test   %eax,%eax
80100209:	74 66                	je     80100271 <brelse+0x81>
    panic("brelse");

  releasesleep(&b->lock);
8010020b:	83 ec 0c             	sub    $0xc,%esp
8010020e:	56                   	push   %esi
8010020f:	e8 3c 44 00 00       	call   80104650 <releasesleep>

  acquire(&bcache.lock);
80100214:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
8010021b:	e8 90 46 00 00       	call   801048b0 <acquire>
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
80100242:	a1 70 ec 10 80       	mov    0x8010ec70,%eax
    b->prev = &bcache.head;
80100247:	c7 43 50 1c ec 10 80 	movl   $0x8010ec1c,0x50(%ebx)
    b->next = bcache.head.next;
8010024e:	89 43 54             	mov    %eax,0x54(%ebx)
    bcache.head.next->prev = b;
80100251:	a1 70 ec 10 80       	mov    0x8010ec70,%eax
80100256:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
80100259:	89 1d 70 ec 10 80    	mov    %ebx,0x8010ec70
  }
  
  release(&bcache.lock);
8010025f:	c7 45 08 20 a5 10 80 	movl   $0x8010a520,0x8(%ebp)
}
80100266:	8d 65 f8             	lea    -0x8(%ebp),%esp
80100269:	5b                   	pop    %ebx
8010026a:	5e                   	pop    %esi
8010026b:	5d                   	pop    %ebp
  release(&bcache.lock);
8010026c:	e9 df 45 00 00       	jmp    80104850 <release>
    panic("brelse");
80100271:	83 ec 0c             	sub    $0xc,%esp
80100274:	68 c6 74 10 80       	push   $0x801074c6
80100279:	e8 02 01 00 00       	call   80100380 <panic>
8010027e:	66 90                	xchg   %ax,%ax

80100280 <consoleread>:
  }
}

int
consoleread(struct inode *ip, char *dst, int n)
{
80100280:	55                   	push   %ebp
80100281:	89 e5                	mov    %esp,%ebp
80100283:	57                   	push   %edi
80100284:	56                   	push   %esi
80100285:	53                   	push   %ebx
80100286:	83 ec 18             	sub    $0x18,%esp
80100289:	8b 5d 10             	mov    0x10(%ebp),%ebx
8010028c:	8b 75 0c             	mov    0xc(%ebp),%esi
  uint target;
  int c;

  iunlock(ip);
8010028f:	ff 75 08             	push   0x8(%ebp)
  target = n;
80100292:	89 df                	mov    %ebx,%edi
  iunlock(ip);
80100294:	e8 d7 18 00 00       	call   80101b70 <iunlock>
  acquire(&cons.lock);
80100299:	c7 04 24 20 ef 10 80 	movl   $0x8010ef20,(%esp)
801002a0:	e8 0b 46 00 00       	call   801048b0 <acquire>
  while(n > 0){
801002a5:	83 c4 10             	add    $0x10,%esp
801002a8:	85 db                	test   %ebx,%ebx
801002aa:	0f 8e 94 00 00 00    	jle    80100344 <consoleread+0xc4>
    while(input.r == input.w){
801002b0:	a1 00 ef 10 80       	mov    0x8010ef00,%eax
801002b5:	3b 05 04 ef 10 80    	cmp    0x8010ef04,%eax
801002bb:	74 25                	je     801002e2 <consoleread+0x62>
801002bd:	eb 59                	jmp    80100318 <consoleread+0x98>
801002bf:	90                   	nop
      if(myproc()->killed){
        release(&cons.lock);
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
801002c0:	83 ec 08             	sub    $0x8,%esp
801002c3:	68 20 ef 10 80       	push   $0x8010ef20
801002c8:	68 00 ef 10 80       	push   $0x8010ef00
801002cd:	e8 7e 40 00 00       	call   80104350 <sleep>
    while(input.r == input.w){
801002d2:	a1 00 ef 10 80       	mov    0x8010ef00,%eax
801002d7:	83 c4 10             	add    $0x10,%esp
801002da:	3b 05 04 ef 10 80    	cmp    0x8010ef04,%eax
801002e0:	75 36                	jne    80100318 <consoleread+0x98>
      if(myproc()->killed){
801002e2:	e8 99 39 00 00       	call   80103c80 <myproc>
801002e7:	8b 48 24             	mov    0x24(%eax),%ecx
801002ea:	85 c9                	test   %ecx,%ecx
801002ec:	74 d2                	je     801002c0 <consoleread+0x40>
        release(&cons.lock);
801002ee:	83 ec 0c             	sub    $0xc,%esp
801002f1:	68 20 ef 10 80       	push   $0x8010ef20
801002f6:	e8 55 45 00 00       	call   80104850 <release>
        ilock(ip);
801002fb:	5a                   	pop    %edx
801002fc:	ff 75 08             	push   0x8(%ebp)
801002ff:	e8 8c 17 00 00       	call   80101a90 <ilock>
        return -1;
80100304:	83 c4 10             	add    $0x10,%esp
  }
  release(&cons.lock);
  ilock(ip);

  return target - n;
}
80100307:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return -1;
8010030a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010030f:	5b                   	pop    %ebx
80100310:	5e                   	pop    %esi
80100311:	5f                   	pop    %edi
80100312:	5d                   	pop    %ebp
80100313:	c3                   	ret    
80100314:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = input.buf[input.r++ % INPUT_BUF];
80100318:	8d 50 01             	lea    0x1(%eax),%edx
8010031b:	89 15 00 ef 10 80    	mov    %edx,0x8010ef00
80100321:	89 c2                	mov    %eax,%edx
80100323:	83 e2 7f             	and    $0x7f,%edx
80100326:	0f be 8a 80 ee 10 80 	movsbl -0x7fef1180(%edx),%ecx
    if(c == C('D')){  // EOF
8010032d:	80 f9 04             	cmp    $0x4,%cl
80100330:	74 37                	je     80100369 <consoleread+0xe9>
    *dst++ = c;
80100332:	83 c6 01             	add    $0x1,%esi
    --n;
80100335:	83 eb 01             	sub    $0x1,%ebx
    *dst++ = c;
80100338:	88 4e ff             	mov    %cl,-0x1(%esi)
    if(c == '\n')
8010033b:	83 f9 0a             	cmp    $0xa,%ecx
8010033e:	0f 85 64 ff ff ff    	jne    801002a8 <consoleread+0x28>
  release(&cons.lock);
80100344:	83 ec 0c             	sub    $0xc,%esp
80100347:	68 20 ef 10 80       	push   $0x8010ef20
8010034c:	e8 ff 44 00 00       	call   80104850 <release>
  ilock(ip);
80100351:	58                   	pop    %eax
80100352:	ff 75 08             	push   0x8(%ebp)
80100355:	e8 36 17 00 00       	call   80101a90 <ilock>
  return target - n;
8010035a:	89 f8                	mov    %edi,%eax
8010035c:	83 c4 10             	add    $0x10,%esp
}
8010035f:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return target - n;
80100362:	29 d8                	sub    %ebx,%eax
}
80100364:	5b                   	pop    %ebx
80100365:	5e                   	pop    %esi
80100366:	5f                   	pop    %edi
80100367:	5d                   	pop    %ebp
80100368:	c3                   	ret    
      if(n < target){
80100369:	39 fb                	cmp    %edi,%ebx
8010036b:	73 d7                	jae    80100344 <consoleread+0xc4>
        input.r--;
8010036d:	a3 00 ef 10 80       	mov    %eax,0x8010ef00
80100372:	eb d0                	jmp    80100344 <consoleread+0xc4>
80100374:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010037b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010037f:	90                   	nop

80100380 <panic>:
{
80100380:	55                   	push   %ebp
80100381:	89 e5                	mov    %esp,%ebp
80100383:	56                   	push   %esi
80100384:	53                   	push   %ebx
80100385:	83 ec 30             	sub    $0x30,%esp
}

static inline void
cli(void)
{
  asm volatile("cli");
80100388:	fa                   	cli    
  cons.locking = 0;
80100389:	c7 05 54 ef 10 80 00 	movl   $0x0,0x8010ef54
80100390:	00 00 00 
  getcallerpcs(&s, pcs);
80100393:	8d 5d d0             	lea    -0x30(%ebp),%ebx
80100396:	8d 75 f8             	lea    -0x8(%ebp),%esi
  cprintf("lapicid %d: panic: ", lapicid());
80100399:	e8 62 28 00 00       	call   80102c00 <lapicid>
8010039e:	83 ec 08             	sub    $0x8,%esp
801003a1:	50                   	push   %eax
801003a2:	68 cd 74 10 80       	push   $0x801074cd
801003a7:	e8 84 03 00 00       	call   80100730 <cprintf>
  cprintf(s);
801003ac:	58                   	pop    %eax
801003ad:	ff 75 08             	push   0x8(%ebp)
801003b0:	e8 7b 03 00 00       	call   80100730 <cprintf>
  cprintf("\n");
801003b5:	c7 04 24 57 7e 10 80 	movl   $0x80107e57,(%esp)
801003bc:	e8 6f 03 00 00       	call   80100730 <cprintf>
  getcallerpcs(&s, pcs);
801003c1:	8d 45 08             	lea    0x8(%ebp),%eax
801003c4:	5a                   	pop    %edx
801003c5:	59                   	pop    %ecx
801003c6:	53                   	push   %ebx
801003c7:	50                   	push   %eax
801003c8:	e8 33 43 00 00       	call   80104700 <getcallerpcs>
  for(i=0; i<10; i++)
801003cd:	83 c4 10             	add    $0x10,%esp
    cprintf(" %p", pcs[i]);
801003d0:	83 ec 08             	sub    $0x8,%esp
801003d3:	ff 33                	push   (%ebx)
  for(i=0; i<10; i++)
801003d5:	83 c3 04             	add    $0x4,%ebx
    cprintf(" %p", pcs[i]);
801003d8:	68 e1 74 10 80       	push   $0x801074e1
801003dd:	e8 4e 03 00 00       	call   80100730 <cprintf>
  for(i=0; i<10; i++)
801003e2:	83 c4 10             	add    $0x10,%esp
801003e5:	39 f3                	cmp    %esi,%ebx
801003e7:	75 e7                	jne    801003d0 <panic+0x50>
  panicked = 1; // freeze other CPU
801003e9:	c7 05 58 ef 10 80 01 	movl   $0x1,0x8010ef58
801003f0:	00 00 00 
  for(;;)
801003f3:	eb fe                	jmp    801003f3 <panic+0x73>
801003f5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801003fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100400 <cgaputc>:
{
80100400:	55                   	push   %ebp
80100401:	89 e5                	mov    %esp,%ebp
80100403:	57                   	push   %edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100404:	bf d4 03 00 00       	mov    $0x3d4,%edi
80100409:	56                   	push   %esi
8010040a:	89 fa                	mov    %edi,%edx
8010040c:	89 c6                	mov    %eax,%esi
8010040e:	b8 0e 00 00 00       	mov    $0xe,%eax
80100413:	53                   	push   %ebx
80100414:	83 ec 0c             	sub    $0xc,%esp
80100417:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100418:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
8010041d:	89 ca                	mov    %ecx,%edx
8010041f:	ec                   	in     (%dx),%al
  pos = inb(CRTPORT+1) << 8;
80100420:	0f b6 d8             	movzbl %al,%ebx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100423:	89 fa                	mov    %edi,%edx
80100425:	b8 0f 00 00 00       	mov    $0xf,%eax
8010042a:	c1 e3 08             	shl    $0x8,%ebx
8010042d:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010042e:	89 ca                	mov    %ecx,%edx
80100430:	ec                   	in     (%dx),%al
  pos |= inb(CRTPORT+1);
80100431:	0f b6 c8             	movzbl %al,%ecx
80100434:	09 d9                	or     %ebx,%ecx
  if(c == '\n')
80100436:	83 fe 0a             	cmp    $0xa,%esi
80100439:	0f 84 31 01 00 00    	je     80100570 <cgaputc+0x170>
  else if(c == BACKSPACE){
8010043f:	81 fe 00 01 00 00    	cmp    $0x100,%esi
80100445:	0f 84 e5 00 00 00    	je     80100530 <cgaputc+0x130>
  }else if(c == BACKWARD){
8010044b:	81 fe 01 01 00 00    	cmp    $0x101,%esi
80100451:	0f 84 39 01 00 00    	je     80100590 <cgaputc+0x190>
    ++pos;
80100457:	8d 59 01             	lea    0x1(%ecx),%ebx
  }else if(c == FORWARD)
8010045a:	81 fe 02 01 00 00    	cmp    $0x102,%esi
80100460:	74 49                	je     801004ab <cgaputc+0xab>
  else if(c == CLEAR){
80100462:	81 fe 03 01 00 00    	cmp    $0x103,%esi
80100468:	0f 84 3a 01 00 00    	je     801005a8 <cgaputc+0x1a8>
      for (int i = 25*80-1; i > pos; i--)
8010046e:	8d 9c 09 fe 7f 0b 80 	lea    -0x7ff48002(%ecx,%ecx,1),%ebx
80100475:	b8 9c 8f 0b 80       	mov    $0x800b8f9c,%eax
8010047a:	81 f9 ce 07 00 00    	cmp    $0x7ce,%ecx
80100480:	7f 14                	jg     80100496 <cgaputc+0x96>
80100482:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        crt[i]=crt[i-1];
80100488:	0f b7 10             	movzwl (%eax),%edx
      for (int i = 25*80-1; i > pos; i--)
8010048b:	83 e8 02             	sub    $0x2,%eax
        crt[i]=crt[i-1];
8010048e:	66 89 50 04          	mov    %dx,0x4(%eax)
      for (int i = 25*80-1; i > pos; i--)
80100492:	39 c3                	cmp    %eax,%ebx
80100494:	75 f2                	jne    80100488 <cgaputc+0x88>
      crt[pos++] = (c&0xff) | 0x0700;
80100496:	89 f0                	mov    %esi,%eax
80100498:	8d 59 01             	lea    0x1(%ecx),%ebx
8010049b:	0f b6 f0             	movzbl %al,%esi
8010049e:	66 81 ce 00 07       	or     $0x700,%si
801004a3:	66 89 b4 09 00 80 0b 	mov    %si,-0x7ff48000(%ecx,%ecx,1)
801004aa:	80 
  if(pos < 0 || pos > 25*80)
801004ab:	81 fb d0 07 00 00    	cmp    $0x7d0,%ebx
801004b1:	0f 8f 3b 01 00 00    	jg     801005f2 <cgaputc+0x1f2>
  outb(CRTPORT+1, pos>>8);
801004b7:	0f b6 f7             	movzbl %bh,%esi
  if((pos/80) >= 24){  // Scroll up.
801004ba:	81 fb 7f 07 00 00    	cmp    $0x77f,%ebx
801004c0:	7e 3e                	jle    80100500 <cgaputc+0x100>
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
801004c2:	83 ec 04             	sub    $0x4,%esp
    pos -= 80;
801004c5:	83 eb 50             	sub    $0x50,%ebx
  outb(CRTPORT+1, pos);
801004c8:	be 07 00 00 00       	mov    $0x7,%esi
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
801004cd:	68 60 0e 00 00       	push   $0xe60
801004d2:	68 a0 80 0b 80       	push   $0x800b80a0
801004d7:	68 00 80 0b 80       	push   $0x800b8000
801004dc:	e8 2f 45 00 00       	call   80104a10 <memmove>
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
801004e1:	b8 80 07 00 00       	mov    $0x780,%eax
801004e6:	83 c4 0c             	add    $0xc,%esp
801004e9:	29 d8                	sub    %ebx,%eax
801004eb:	01 c0                	add    %eax,%eax
801004ed:	50                   	push   %eax
801004ee:	8d 84 1b 00 80 0b 80 	lea    -0x7ff48000(%ebx,%ebx,1),%eax
801004f5:	6a 00                	push   $0x0
801004f7:	50                   	push   %eax
801004f8:	e8 73 44 00 00       	call   80104970 <memset>
  outb(CRTPORT+1, pos);
801004fd:	83 c4 10             	add    $0x10,%esp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100500:	bf d4 03 00 00       	mov    $0x3d4,%edi
80100505:	b8 0e 00 00 00       	mov    $0xe,%eax
8010050a:	89 fa                	mov    %edi,%edx
8010050c:	ee                   	out    %al,(%dx)
8010050d:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
80100512:	89 f0                	mov    %esi,%eax
80100514:	89 ca                	mov    %ecx,%edx
80100516:	ee                   	out    %al,(%dx)
80100517:	b8 0f 00 00 00       	mov    $0xf,%eax
8010051c:	89 fa                	mov    %edi,%edx
8010051e:	ee                   	out    %al,(%dx)
8010051f:	89 d8                	mov    %ebx,%eax
80100521:	89 ca                	mov    %ecx,%edx
80100523:	ee                   	out    %al,(%dx)
}
80100524:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100527:	5b                   	pop    %ebx
80100528:	5e                   	pop    %esi
80100529:	5f                   	pop    %edi
8010052a:	5d                   	pop    %ebp
8010052b:	c3                   	ret    
8010052c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(pos > 0){
80100530:	85 c9                	test   %ecx,%ecx
80100532:	74 67                	je     8010059b <cgaputc+0x19b>
      --pos;
80100534:	8d 59 ff             	lea    -0x1(%ecx),%ebx
      for (int i = pos; i < 25*80-1; i++)
80100537:	81 fb ce 07 00 00    	cmp    $0x7ce,%ebx
8010053d:	0f 8f 68 ff ff ff    	jg     801004ab <cgaputc+0xab>
80100543:	8d 94 09 00 80 0b 80 	lea    -0x7ff48000(%ecx,%ecx,1),%edx
8010054a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        crt[i]=crt[i+1];
80100550:	0f b7 02             	movzwl (%edx),%eax
      for (int i = pos; i < 25*80-1; i++)
80100553:	83 c2 02             	add    $0x2,%edx
        crt[i]=crt[i+1];
80100556:	66 89 42 fc          	mov    %ax,-0x4(%edx)
      for (int i = pos; i < 25*80-1; i++)
8010055a:	81 fa a0 8f 0b 80    	cmp    $0x800b8fa0,%edx
80100560:	75 ee                	jne    80100550 <cgaputc+0x150>
80100562:	e9 50 ff ff ff       	jmp    801004b7 <cgaputc+0xb7>
80100567:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010056e:	66 90                	xchg   %ax,%ax
    pos += 80 - pos%80;
80100570:	89 c8                	mov    %ecx,%eax
80100572:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
80100577:	f7 e2                	mul    %edx
80100579:	c1 ea 06             	shr    $0x6,%edx
8010057c:	8d 04 92             	lea    (%edx,%edx,4),%eax
8010057f:	c1 e0 04             	shl    $0x4,%eax
80100582:	8d 58 50             	lea    0x50(%eax),%ebx
80100585:	e9 21 ff ff ff       	jmp    801004ab <cgaputc+0xab>
8010058a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(pos > 0) --pos;
80100590:	8d 59 ff             	lea    -0x1(%ecx),%ebx
80100593:	85 c9                	test   %ecx,%ecx
80100595:	0f 85 10 ff ff ff    	jne    801004ab <cgaputc+0xab>
8010059b:	31 db                	xor    %ebx,%ebx
8010059d:	31 f6                	xor    %esi,%esi
8010059f:	e9 5c ff ff ff       	jmp    80100500 <cgaputc+0x100>
801005a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    int rows = pos/80;
801005a8:	89 c8                	mov    %ecx,%eax
801005aa:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
    memmove(crt, crt+rows*80, sizeof(crt[0])*2);
801005af:	83 ec 04             	sub    $0x4,%esp
    memset(crt+pos, 0, sizeof(crt[0])*(25*80 - pos));
801005b2:	bb 02 00 00 00       	mov    $0x2,%ebx
    int rows = pos/80;
801005b7:	f7 e2                	mul    %edx
    memmove(crt, crt+rows*80, sizeof(crt[0])*2);
801005b9:	6a 04                	push   $0x4
    memset(crt+pos, 0, sizeof(crt[0])*(25*80 - pos));
801005bb:	31 f6                	xor    %esi,%esi
    int rows = pos/80;
801005bd:	c1 ea 06             	shr    $0x6,%edx
    memmove(crt, crt+rows*80, sizeof(crt[0])*2);
801005c0:	8d 04 92             	lea    (%edx,%edx,4),%eax
801005c3:	c1 e0 05             	shl    $0x5,%eax
801005c6:	2d 00 80 f4 7f       	sub    $0x7ff48000,%eax
801005cb:	50                   	push   %eax
801005cc:	68 00 80 0b 80       	push   $0x800b8000
801005d1:	e8 3a 44 00 00       	call   80104a10 <memmove>
    memset(crt+pos, 0, sizeof(crt[0])*(25*80 - pos));
801005d6:	83 c4 0c             	add    $0xc,%esp
801005d9:	68 9c 0f 00 00       	push   $0xf9c
801005de:	6a 00                	push   $0x0
801005e0:	68 04 80 0b 80       	push   $0x800b8004
801005e5:	e8 86 43 00 00       	call   80104970 <memset>
801005ea:	83 c4 10             	add    $0x10,%esp
801005ed:	e9 0e ff ff ff       	jmp    80100500 <cgaputc+0x100>
    panic("pos under/overflow");
801005f2:	83 ec 0c             	sub    $0xc,%esp
801005f5:	68 e5 74 10 80       	push   $0x801074e5
801005fa:	e8 81 fd ff ff       	call   80100380 <panic>
801005ff:	90                   	nop

80100600 <consolewrite>:

int
consolewrite(struct inode *ip, char *buf, int n)
{
80100600:	55                   	push   %ebp
80100601:	89 e5                	mov    %esp,%ebp
80100603:	57                   	push   %edi
80100604:	56                   	push   %esi
80100605:	53                   	push   %ebx
80100606:	83 ec 28             	sub    $0x28,%esp
  int i;

  iunlock(ip);
80100609:	ff 75 08             	push   0x8(%ebp)
{
8010060c:	8b 75 10             	mov    0x10(%ebp),%esi
  iunlock(ip);
8010060f:	e8 5c 15 00 00       	call   80101b70 <iunlock>
  acquire(&cons.lock);
80100614:	c7 04 24 20 ef 10 80 	movl   $0x8010ef20,(%esp)
8010061b:	e8 90 42 00 00       	call   801048b0 <acquire>
  for(i = 0; i < n; i++)
80100620:	83 c4 10             	add    $0x10,%esp
80100623:	85 f6                	test   %esi,%esi
80100625:	7e 37                	jle    8010065e <consolewrite+0x5e>
80100627:	8b 5d 0c             	mov    0xc(%ebp),%ebx
8010062a:	8d 3c 33             	lea    (%ebx,%esi,1),%edi
  if(panicked){
8010062d:	8b 15 58 ef 10 80    	mov    0x8010ef58,%edx
    consputc(buf[i] & 0xff);
80100633:	0f b6 03             	movzbl (%ebx),%eax
  if(panicked){
80100636:	85 d2                	test   %edx,%edx
80100638:	74 06                	je     80100640 <consolewrite+0x40>
  asm volatile("cli");
8010063a:	fa                   	cli    
    for(;;)
8010063b:	eb fe                	jmp    8010063b <consolewrite+0x3b>
8010063d:	8d 76 00             	lea    0x0(%esi),%esi
    uartputc(c);
80100640:	83 ec 0c             	sub    $0xc,%esp
80100643:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(i = 0; i < n; i++)
80100646:	83 c3 01             	add    $0x1,%ebx
    uartputc(c);
80100649:	50                   	push   %eax
8010064a:	e8 71 59 00 00       	call   80105fc0 <uartputc>
  cgaputc(c);
8010064f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100652:	e8 a9 fd ff ff       	call   80100400 <cgaputc>
  for(i = 0; i < n; i++)
80100657:	83 c4 10             	add    $0x10,%esp
8010065a:	39 df                	cmp    %ebx,%edi
8010065c:	75 cf                	jne    8010062d <consolewrite+0x2d>
  release(&cons.lock);
8010065e:	83 ec 0c             	sub    $0xc,%esp
80100661:	68 20 ef 10 80       	push   $0x8010ef20
80100666:	e8 e5 41 00 00       	call   80104850 <release>
  ilock(ip);
8010066b:	58                   	pop    %eax
8010066c:	ff 75 08             	push   0x8(%ebp)
8010066f:	e8 1c 14 00 00       	call   80101a90 <ilock>

  return n;
}
80100674:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100677:	89 f0                	mov    %esi,%eax
80100679:	5b                   	pop    %ebx
8010067a:	5e                   	pop    %esi
8010067b:	5f                   	pop    %edi
8010067c:	5d                   	pop    %ebp
8010067d:	c3                   	ret    
8010067e:	66 90                	xchg   %ax,%ax

80100680 <printint>:
{
80100680:	55                   	push   %ebp
80100681:	89 e5                	mov    %esp,%ebp
80100683:	57                   	push   %edi
80100684:	56                   	push   %esi
80100685:	53                   	push   %ebx
80100686:	83 ec 2c             	sub    $0x2c,%esp
80100689:	89 55 d4             	mov    %edx,-0x2c(%ebp)
8010068c:	89 4d d0             	mov    %ecx,-0x30(%ebp)
  if(sign && (sign = xx < 0))
8010068f:	85 c9                	test   %ecx,%ecx
80100691:	74 04                	je     80100697 <printint+0x17>
80100693:	85 c0                	test   %eax,%eax
80100695:	78 7e                	js     80100715 <printint+0x95>
    x = xx;
80100697:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
8010069e:	89 c1                	mov    %eax,%ecx
  i = 0;
801006a0:	31 db                	xor    %ebx,%ebx
801006a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    buf[i++] = digits[x % base];
801006a8:	89 c8                	mov    %ecx,%eax
801006aa:	31 d2                	xor    %edx,%edx
801006ac:	89 de                	mov    %ebx,%esi
801006ae:	89 cf                	mov    %ecx,%edi
801006b0:	f7 75 d4             	divl   -0x2c(%ebp)
801006b3:	8d 5b 01             	lea    0x1(%ebx),%ebx
801006b6:	0f b6 92 68 75 10 80 	movzbl -0x7fef8a98(%edx),%edx
  }while((x /= base) != 0);
801006bd:	89 c1                	mov    %eax,%ecx
    buf[i++] = digits[x % base];
801006bf:	88 54 1d d7          	mov    %dl,-0x29(%ebp,%ebx,1)
  }while((x /= base) != 0);
801006c3:	3b 7d d4             	cmp    -0x2c(%ebp),%edi
801006c6:	73 e0                	jae    801006a8 <printint+0x28>
  if(sign)
801006c8:	8b 4d d0             	mov    -0x30(%ebp),%ecx
801006cb:	85 c9                	test   %ecx,%ecx
801006cd:	74 0c                	je     801006db <printint+0x5b>
    buf[i++] = '-';
801006cf:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
801006d4:	89 de                	mov    %ebx,%esi
    buf[i++] = '-';
801006d6:	ba 2d 00 00 00       	mov    $0x2d,%edx
  while(--i >= 0)
801006db:	8d 5c 35 d7          	lea    -0x29(%ebp,%esi,1),%ebx
  if(panicked){
801006df:	a1 58 ef 10 80       	mov    0x8010ef58,%eax
801006e4:	85 c0                	test   %eax,%eax
801006e6:	74 08                	je     801006f0 <printint+0x70>
801006e8:	fa                   	cli    
    for(;;)
801006e9:	eb fe                	jmp    801006e9 <printint+0x69>
801006eb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801006ef:	90                   	nop
    consputc(buf[i]);
801006f0:	0f be f2             	movsbl %dl,%esi
    uartputc(c);
801006f3:	83 ec 0c             	sub    $0xc,%esp
801006f6:	56                   	push   %esi
801006f7:	e8 c4 58 00 00       	call   80105fc0 <uartputc>
  cgaputc(c);
801006fc:	89 f0                	mov    %esi,%eax
801006fe:	e8 fd fc ff ff       	call   80100400 <cgaputc>
  while(--i >= 0)
80100703:	8d 45 d7             	lea    -0x29(%ebp),%eax
80100706:	83 c4 10             	add    $0x10,%esp
80100709:	39 d8                	cmp    %ebx,%eax
8010070b:	74 0e                	je     8010071b <printint+0x9b>
    consputc(buf[i]);
8010070d:	0f b6 13             	movzbl (%ebx),%edx
80100710:	83 eb 01             	sub    $0x1,%ebx
80100713:	eb ca                	jmp    801006df <printint+0x5f>
    x = -xx;
80100715:	f7 d8                	neg    %eax
80100717:	89 c1                	mov    %eax,%ecx
80100719:	eb 85                	jmp    801006a0 <printint+0x20>
}
8010071b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010071e:	5b                   	pop    %ebx
8010071f:	5e                   	pop    %esi
80100720:	5f                   	pop    %edi
80100721:	5d                   	pop    %ebp
80100722:	c3                   	ret    
80100723:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010072a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100730 <cprintf>:
{
80100730:	55                   	push   %ebp
80100731:	89 e5                	mov    %esp,%ebp
80100733:	57                   	push   %edi
80100734:	56                   	push   %esi
80100735:	53                   	push   %ebx
80100736:	83 ec 1c             	sub    $0x1c,%esp
  locking = cons.locking;
80100739:	a1 54 ef 10 80       	mov    0x8010ef54,%eax
8010073e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(locking)
80100741:	85 c0                	test   %eax,%eax
80100743:	0f 85 37 01 00 00    	jne    80100880 <cprintf+0x150>
  if (fmt == 0)
80100749:	8b 75 08             	mov    0x8(%ebp),%esi
8010074c:	85 f6                	test   %esi,%esi
8010074e:	0f 84 3d 02 00 00    	je     80100991 <cprintf+0x261>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100754:	0f b6 06             	movzbl (%esi),%eax
  argp = (uint*)(void*)(&fmt + 1);
80100757:	8d 7d 0c             	lea    0xc(%ebp),%edi
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
8010075a:	31 db                	xor    %ebx,%ebx
8010075c:	85 c0                	test   %eax,%eax
8010075e:	74 56                	je     801007b6 <cprintf+0x86>
    if(c != '%'){
80100760:	83 f8 25             	cmp    $0x25,%eax
80100763:	0f 85 d7 00 00 00    	jne    80100840 <cprintf+0x110>
    c = fmt[++i] & 0xff;
80100769:	83 c3 01             	add    $0x1,%ebx
8010076c:	0f b6 14 1e          	movzbl (%esi,%ebx,1),%edx
    if(c == 0)
80100770:	85 d2                	test   %edx,%edx
80100772:	74 42                	je     801007b6 <cprintf+0x86>
    switch(c){
80100774:	83 fa 70             	cmp    $0x70,%edx
80100777:	0f 84 94 00 00 00    	je     80100811 <cprintf+0xe1>
8010077d:	7f 51                	jg     801007d0 <cprintf+0xa0>
8010077f:	83 fa 25             	cmp    $0x25,%edx
80100782:	0f 84 48 01 00 00    	je     801008d0 <cprintf+0x1a0>
80100788:	83 fa 64             	cmp    $0x64,%edx
8010078b:	0f 85 04 01 00 00    	jne    80100895 <cprintf+0x165>
      printint(*argp++, 10, 1);
80100791:	8d 47 04             	lea    0x4(%edi),%eax
80100794:	b9 01 00 00 00       	mov    $0x1,%ecx
80100799:	ba 0a 00 00 00       	mov    $0xa,%edx
8010079e:	89 45 e0             	mov    %eax,-0x20(%ebp)
801007a1:	8b 07                	mov    (%edi),%eax
801007a3:	e8 d8 fe ff ff       	call   80100680 <printint>
801007a8:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801007ab:	83 c3 01             	add    $0x1,%ebx
801007ae:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
801007b2:	85 c0                	test   %eax,%eax
801007b4:	75 aa                	jne    80100760 <cprintf+0x30>
  if(locking)
801007b6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801007b9:	85 c0                	test   %eax,%eax
801007bb:	0f 85 b3 01 00 00    	jne    80100974 <cprintf+0x244>
}
801007c1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801007c4:	5b                   	pop    %ebx
801007c5:	5e                   	pop    %esi
801007c6:	5f                   	pop    %edi
801007c7:	5d                   	pop    %ebp
801007c8:	c3                   	ret    
801007c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    switch(c){
801007d0:	83 fa 73             	cmp    $0x73,%edx
801007d3:	75 33                	jne    80100808 <cprintf+0xd8>
      if((s = (char*)*argp++) == 0)
801007d5:	8d 47 04             	lea    0x4(%edi),%eax
801007d8:	8b 3f                	mov    (%edi),%edi
801007da:	89 45 e0             	mov    %eax,-0x20(%ebp)
801007dd:	85 ff                	test   %edi,%edi
801007df:	0f 85 33 01 00 00    	jne    80100918 <cprintf+0x1e8>
        s = "(null)";
801007e5:	bf f8 74 10 80       	mov    $0x801074f8,%edi
      for(; *s; s++)
801007ea:	89 5d dc             	mov    %ebx,-0x24(%ebp)
801007ed:	b8 28 00 00 00       	mov    $0x28,%eax
801007f2:	89 fb                	mov    %edi,%ebx
  if(panicked){
801007f4:	8b 15 58 ef 10 80    	mov    0x8010ef58,%edx
801007fa:	85 d2                	test   %edx,%edx
801007fc:	0f 84 27 01 00 00    	je     80100929 <cprintf+0x1f9>
80100802:	fa                   	cli    
    for(;;)
80100803:	eb fe                	jmp    80100803 <cprintf+0xd3>
80100805:	8d 76 00             	lea    0x0(%esi),%esi
    switch(c){
80100808:	83 fa 78             	cmp    $0x78,%edx
8010080b:	0f 85 84 00 00 00    	jne    80100895 <cprintf+0x165>
      printint(*argp++, 16, 0);
80100811:	8d 47 04             	lea    0x4(%edi),%eax
80100814:	31 c9                	xor    %ecx,%ecx
80100816:	ba 10 00 00 00       	mov    $0x10,%edx
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
8010081b:	83 c3 01             	add    $0x1,%ebx
      printint(*argp++, 16, 0);
8010081e:	89 45 e0             	mov    %eax,-0x20(%ebp)
80100821:	8b 07                	mov    (%edi),%eax
80100823:	e8 58 fe ff ff       	call   80100680 <printint>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100828:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
      printint(*argp++, 16, 0);
8010082c:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
8010082f:	85 c0                	test   %eax,%eax
80100831:	0f 85 29 ff ff ff    	jne    80100760 <cprintf+0x30>
80100837:	e9 7a ff ff ff       	jmp    801007b6 <cprintf+0x86>
8010083c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(panicked){
80100840:	8b 0d 58 ef 10 80    	mov    0x8010ef58,%ecx
80100846:	85 c9                	test   %ecx,%ecx
80100848:	74 06                	je     80100850 <cprintf+0x120>
8010084a:	fa                   	cli    
    for(;;)
8010084b:	eb fe                	jmp    8010084b <cprintf+0x11b>
8010084d:	8d 76 00             	lea    0x0(%esi),%esi
    uartputc(c);
80100850:	83 ec 0c             	sub    $0xc,%esp
80100853:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100856:	83 c3 01             	add    $0x1,%ebx
    uartputc(c);
80100859:	50                   	push   %eax
8010085a:	e8 61 57 00 00       	call   80105fc0 <uartputc>
  cgaputc(c);
8010085f:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100862:	e8 99 fb ff ff       	call   80100400 <cgaputc>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100867:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
      continue;
8010086b:	83 c4 10             	add    $0x10,%esp
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
8010086e:	85 c0                	test   %eax,%eax
80100870:	0f 85 ea fe ff ff    	jne    80100760 <cprintf+0x30>
80100876:	e9 3b ff ff ff       	jmp    801007b6 <cprintf+0x86>
8010087b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010087f:	90                   	nop
    acquire(&cons.lock);
80100880:	83 ec 0c             	sub    $0xc,%esp
80100883:	68 20 ef 10 80       	push   $0x8010ef20
80100888:	e8 23 40 00 00       	call   801048b0 <acquire>
8010088d:	83 c4 10             	add    $0x10,%esp
80100890:	e9 b4 fe ff ff       	jmp    80100749 <cprintf+0x19>
  if(panicked){
80100895:	8b 0d 58 ef 10 80    	mov    0x8010ef58,%ecx
8010089b:	85 c9                	test   %ecx,%ecx
8010089d:	75 71                	jne    80100910 <cprintf+0x1e0>
    uartputc(c);
8010089f:	83 ec 0c             	sub    $0xc,%esp
801008a2:	89 55 e0             	mov    %edx,-0x20(%ebp)
801008a5:	6a 25                	push   $0x25
801008a7:	e8 14 57 00 00       	call   80105fc0 <uartputc>
  cgaputc(c);
801008ac:	b8 25 00 00 00       	mov    $0x25,%eax
801008b1:	e8 4a fb ff ff       	call   80100400 <cgaputc>
  if(panicked){
801008b6:	8b 15 58 ef 10 80    	mov    0x8010ef58,%edx
801008bc:	83 c4 10             	add    $0x10,%esp
801008bf:	85 d2                	test   %edx,%edx
801008c1:	8b 55 e0             	mov    -0x20(%ebp),%edx
801008c4:	0f 84 8e 00 00 00    	je     80100958 <cprintf+0x228>
801008ca:	fa                   	cli    
    for(;;)
801008cb:	eb fe                	jmp    801008cb <cprintf+0x19b>
801008cd:	8d 76 00             	lea    0x0(%esi),%esi
  if(panicked){
801008d0:	a1 58 ef 10 80       	mov    0x8010ef58,%eax
801008d5:	85 c0                	test   %eax,%eax
801008d7:	74 07                	je     801008e0 <cprintf+0x1b0>
801008d9:	fa                   	cli    
    for(;;)
801008da:	eb fe                	jmp    801008da <cprintf+0x1aa>
801008dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    uartputc(c);
801008e0:	83 ec 0c             	sub    $0xc,%esp
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801008e3:	83 c3 01             	add    $0x1,%ebx
    uartputc(c);
801008e6:	6a 25                	push   $0x25
801008e8:	e8 d3 56 00 00       	call   80105fc0 <uartputc>
  cgaputc(c);
801008ed:	b8 25 00 00 00       	mov    $0x25,%eax
801008f2:	e8 09 fb ff ff       	call   80100400 <cgaputc>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801008f7:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
}
801008fb:	83 c4 10             	add    $0x10,%esp
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801008fe:	85 c0                	test   %eax,%eax
80100900:	0f 85 5a fe ff ff    	jne    80100760 <cprintf+0x30>
80100906:	e9 ab fe ff ff       	jmp    801007b6 <cprintf+0x86>
8010090b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010090f:	90                   	nop
80100910:	fa                   	cli    
    for(;;)
80100911:	eb fe                	jmp    80100911 <cprintf+0x1e1>
80100913:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100917:	90                   	nop
      for(; *s; s++)
80100918:	0f b6 07             	movzbl (%edi),%eax
8010091b:	84 c0                	test   %al,%al
8010091d:	74 6a                	je     80100989 <cprintf+0x259>
8010091f:	89 5d dc             	mov    %ebx,-0x24(%ebp)
80100922:	89 fb                	mov    %edi,%ebx
80100924:	e9 cb fe ff ff       	jmp    801007f4 <cprintf+0xc4>
    uartputc(c);
80100929:	83 ec 0c             	sub    $0xc,%esp
        consputc(*s);
8010092c:	0f be f8             	movsbl %al,%edi
      for(; *s; s++)
8010092f:	83 c3 01             	add    $0x1,%ebx
    uartputc(c);
80100932:	57                   	push   %edi
80100933:	e8 88 56 00 00       	call   80105fc0 <uartputc>
  cgaputc(c);
80100938:	89 f8                	mov    %edi,%eax
8010093a:	e8 c1 fa ff ff       	call   80100400 <cgaputc>
      for(; *s; s++)
8010093f:	0f b6 03             	movzbl (%ebx),%eax
80100942:	83 c4 10             	add    $0x10,%esp
80100945:	84 c0                	test   %al,%al
80100947:	0f 85 a7 fe ff ff    	jne    801007f4 <cprintf+0xc4>
      if((s = (char*)*argp++) == 0)
8010094d:	8b 5d dc             	mov    -0x24(%ebp),%ebx
80100950:	8b 7d e0             	mov    -0x20(%ebp),%edi
80100953:	e9 53 fe ff ff       	jmp    801007ab <cprintf+0x7b>
    uartputc(c);
80100958:	83 ec 0c             	sub    $0xc,%esp
8010095b:	89 55 e0             	mov    %edx,-0x20(%ebp)
8010095e:	52                   	push   %edx
8010095f:	e8 5c 56 00 00       	call   80105fc0 <uartputc>
  cgaputc(c);
80100964:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100967:	e8 94 fa ff ff       	call   80100400 <cgaputc>
}
8010096c:	83 c4 10             	add    $0x10,%esp
8010096f:	e9 37 fe ff ff       	jmp    801007ab <cprintf+0x7b>
    release(&cons.lock);
80100974:	83 ec 0c             	sub    $0xc,%esp
80100977:	68 20 ef 10 80       	push   $0x8010ef20
8010097c:	e8 cf 3e 00 00       	call   80104850 <release>
80100981:	83 c4 10             	add    $0x10,%esp
}
80100984:	e9 38 fe ff ff       	jmp    801007c1 <cprintf+0x91>
      if((s = (char*)*argp++) == 0)
80100989:	8b 7d e0             	mov    -0x20(%ebp),%edi
8010098c:	e9 1a fe ff ff       	jmp    801007ab <cprintf+0x7b>
    panic("null fmt");
80100991:	83 ec 0c             	sub    $0xc,%esp
80100994:	68 ff 74 10 80       	push   $0x801074ff
80100999:	e8 e2 f9 ff ff       	call   80100380 <panic>
8010099e:	66 90                	xchg   %ax,%ax

801009a0 <consoleintr>:
{
801009a0:	55                   	push   %ebp
801009a1:	89 e5                	mov    %esp,%ebp
801009a3:	57                   	push   %edi
801009a4:	56                   	push   %esi
  int c, doprocdump = 0;
801009a5:	31 f6                	xor    %esi,%esi
{
801009a7:	53                   	push   %ebx
801009a8:	83 ec 28             	sub    $0x28,%esp
801009ab:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&cons.lock);
801009ae:	68 20 ef 10 80       	push   $0x8010ef20
801009b3:	e8 f8 3e 00 00       	call   801048b0 <acquire>
  while((c = getc()) >= 0){
801009b8:	83 c4 10             	add    $0x10,%esp
801009bb:	ff d3                	call   *%ebx
801009bd:	85 c0                	test   %eax,%eax
801009bf:	0f 88 1b 02 00 00    	js     80100be0 <consoleintr+0x240>
    switch(c){
801009c5:	83 f8 15             	cmp    $0x15,%eax
801009c8:	7f 1e                	jg     801009e8 <consoleintr+0x48>
801009ca:	83 f8 01             	cmp    $0x1,%eax
801009cd:	0f 8e 65 02 00 00    	jle    80100c38 <consoleintr+0x298>
801009d3:	83 f8 15             	cmp    $0x15,%eax
801009d6:	0f 87 5c 02 00 00    	ja     80100c38 <consoleintr+0x298>
801009dc:	ff 24 85 10 75 10 80 	jmp    *-0x7fef8af0(,%eax,4)
801009e3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801009e7:	90                   	nop
801009e8:	83 f8 7f             	cmp    $0x7f,%eax
801009eb:	0f 84 37 01 00 00    	je     80100b28 <consoleintr+0x188>
      if(c != 0 && input.e-input.r < INPUT_BUF){
801009f1:	8b 15 08 ef 10 80    	mov    0x8010ef08,%edx
801009f7:	2b 15 00 ef 10 80    	sub    0x8010ef00,%edx
801009fd:	83 fa 7f             	cmp    $0x7f,%edx
80100a00:	77 b9                	ja     801009bb <consoleintr+0x1b>
  if(panicked){
80100a02:	8b 15 58 ef 10 80    	mov    0x8010ef58,%edx
        c = (c == '\r') ? '\n' : c;       
80100a08:	83 f8 0d             	cmp    $0xd,%eax
80100a0b:	0f 84 9f 02 00 00    	je     80100cb0 <consoleintr+0x310>
  if(panicked){
80100a11:	85 d2                	test   %edx,%edx
80100a13:	0f 85 8e 02 00 00    	jne    80100ca7 <consoleintr+0x307>
  if(c == BACKSPACE){
80100a19:	3d 00 01 00 00       	cmp    $0x100,%eax
80100a1e:	0f 84 fc 02 00 00    	je     80100d20 <consoleintr+0x380>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){          
80100a24:	83 f8 0a             	cmp    $0xa,%eax
          input.buf[input.e++ % INPUT_BUF] = c;
80100a27:	89 c7                	mov    %eax,%edi
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){          
80100a29:	0f 94 c1             	sete   %cl
80100a2c:	83 f8 04             	cmp    $0x4,%eax
80100a2f:	0f 94 c2             	sete   %dl
80100a32:	09 d1                	or     %edx,%ecx
80100a34:	88 4d e7             	mov    %cl,-0x19(%ebp)
  } else if(c < BACKSPACE){
80100a37:	3d ff 00 00 00       	cmp    $0xff,%eax
80100a3c:	0f 8e fc 02 00 00    	jle    80100d3e <consoleintr+0x39e>
  cgaputc(c);
80100a42:	e8 b9 f9 ff ff       	call   80100400 <cgaputc>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){          
80100a47:	a1 00 ef 10 80       	mov    0x8010ef00,%eax
80100a4c:	8b 15 08 ef 10 80    	mov    0x8010ef08,%edx
          lineLength++;
80100a52:	8b 0d 0c ef 10 80    	mov    0x8010ef0c,%ecx
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){          
80100a58:	83 e8 80             	sub    $0xffffff80,%eax
80100a5b:	39 c2                	cmp    %eax,%edx
80100a5d:	0f 85 7d 02 00 00    	jne    80100ce0 <consoleintr+0x340>
          wakeup(&input.r);
80100a63:	83 ec 0c             	sub    $0xc,%esp
          input.e += lineLength - input.e % INPUT_BUF;          
80100a66:	83 e0 80             	and    $0xffffff80,%eax
          wakeup(&input.r);
80100a69:	68 00 ef 10 80       	push   $0x8010ef00
          input.e += lineLength - input.e % INPUT_BUF;          
80100a6e:	01 c8                	add    %ecx,%eax
          input.buf[input.e++ % INPUT_BUF] = c;
80100a70:	89 f9                	mov    %edi,%ecx
80100a72:	8d 50 01             	lea    0x1(%eax),%edx
80100a75:	83 e0 7f             	and    $0x7f,%eax
80100a78:	88 88 80 ee 10 80    	mov    %cl,-0x7fef1180(%eax)
80100a7e:	89 15 08 ef 10 80    	mov    %edx,0x8010ef08
          input.w = input.e;
80100a84:	89 15 04 ef 10 80    	mov    %edx,0x8010ef04
          wakeup(&input.r);
80100a8a:	e8 81 39 00 00       	call   80104410 <wakeup>
          lineLength=input.e%INPUT_BUF;
80100a8f:	a1 08 ef 10 80       	mov    0x8010ef08,%eax
80100a94:	83 c4 10             	add    $0x10,%esp
80100a97:	83 e0 7f             	and    $0x7f,%eax
80100a9a:	a3 0c ef 10 80       	mov    %eax,0x8010ef0c
80100a9f:	e9 17 ff ff ff       	jmp    801009bb <consoleintr+0x1b>
80100aa4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      while(input.e != input.w &&
80100aa8:	8b 15 08 ef 10 80    	mov    0x8010ef08,%edx
80100aae:	3b 15 04 ef 10 80    	cmp    0x8010ef04,%edx
80100ab4:	0f 84 6b 01 00 00    	je     80100c25 <consoleintr+0x285>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100aba:	8d 4a ff             	lea    -0x1(%edx),%ecx
80100abd:	89 c8                	mov    %ecx,%eax
80100abf:	83 e0 7f             	and    $0x7f,%eax
      while(input.e != input.w &&
80100ac2:	80 b8 80 ee 10 80 0a 	cmpb   $0xa,-0x7fef1180(%eax)
80100ac9:	0f 84 56 01 00 00    	je     80100c25 <consoleintr+0x285>
        input.e--;
80100acf:	89 0d 08 ef 10 80    	mov    %ecx,0x8010ef08
        for (int i = input.e % INPUT_BUF; i < INPUT_BUF-1; i++)
80100ad5:	83 f8 7f             	cmp    $0x7f,%eax
80100ad8:	74 1b                	je     80100af5 <consoleintr+0x155>
80100ada:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
          input.buf[i]=input.buf[i+1];
80100ae0:	0f b6 90 81 ee 10 80 	movzbl -0x7fef117f(%eax),%edx
80100ae7:	83 c0 01             	add    $0x1,%eax
80100aea:	88 90 7f ee 10 80    	mov    %dl,-0x7fef1181(%eax)
        for (int i = input.e % INPUT_BUF; i < INPUT_BUF-1; i++)
80100af0:	83 f8 7f             	cmp    $0x7f,%eax
80100af3:	75 eb                	jne    80100ae0 <consoleintr+0x140>
  if(panicked){
80100af5:	a1 58 ef 10 80       	mov    0x8010ef58,%eax
80100afa:	85 c0                	test   %eax,%eax
80100afc:	0f 84 fa 00 00 00    	je     80100bfc <consoleintr+0x25c>
80100b02:	fa                   	cli    
    for(;;)
80100b03:	eb fe                	jmp    80100b03 <consoleintr+0x163>
80100b05:	8d 76 00             	lea    0x0(%esi),%esi
      input.e = input.w;        
80100b08:	a1 04 ef 10 80       	mov    0x8010ef04,%eax
  if(panicked){
80100b0d:	8b 3d 58 ef 10 80    	mov    0x8010ef58,%edi
      input.e = input.w;        
80100b13:	a3 08 ef 10 80       	mov    %eax,0x8010ef08
  if(panicked){
80100b18:	85 ff                	test   %edi,%edi
80100b1a:	0f 84 28 01 00 00    	je     80100c48 <consoleintr+0x2a8>
80100b20:	fa                   	cli    
    for(;;)
80100b21:	eb fe                	jmp    80100b21 <consoleintr+0x181>
80100b23:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100b27:	90                   	nop
      if(input.e != input.w){
80100b28:	a1 08 ef 10 80       	mov    0x8010ef08,%eax
80100b2d:	3b 05 04 ef 10 80    	cmp    0x8010ef04,%eax
80100b33:	0f 84 82 fe ff ff    	je     801009bb <consoleintr+0x1b>
        input.e--;
80100b39:	83 e8 01             	sub    $0x1,%eax
80100b3c:	a3 08 ef 10 80       	mov    %eax,0x8010ef08
        for (int i = input.e % INPUT_BUF; i < INPUT_BUF-1; i++)
80100b41:	83 e0 7f             	and    $0x7f,%eax
80100b44:	83 f8 7f             	cmp    $0x7f,%eax
80100b47:	74 1c                	je     80100b65 <consoleintr+0x1c5>
80100b49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
          input.buf[i]=input.buf[i+1];
80100b50:	0f b6 90 81 ee 10 80 	movzbl -0x7fef117f(%eax),%edx
80100b57:	83 c0 01             	add    $0x1,%eax
80100b5a:	88 90 7f ee 10 80    	mov    %dl,-0x7fef1181(%eax)
        for (int i = input.e % INPUT_BUF; i < INPUT_BUF-1; i++)
80100b60:	83 f8 7f             	cmp    $0x7f,%eax
80100b63:	75 eb                	jne    80100b50 <consoleintr+0x1b0>
  if(panicked){
80100b65:	a1 58 ef 10 80       	mov    0x8010ef58,%eax
        lineLength--;
80100b6a:	83 2d 0c ef 10 80 01 	subl   $0x1,0x8010ef0c
  if(panicked){
80100b71:	85 c0                	test   %eax,%eax
80100b73:	0f 84 03 01 00 00    	je     80100c7c <consoleintr+0x2dc>
80100b79:	fa                   	cli    
    for(;;)
80100b7a:	eb fe                	jmp    80100b7a <consoleintr+0x1da>
80100b7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(input.e % INPUT_BUF < lineLength){
80100b80:	a1 08 ef 10 80       	mov    0x8010ef08,%eax
80100b85:	89 c2                	mov    %eax,%edx
80100b87:	83 e2 7f             	and    $0x7f,%edx
80100b8a:	3b 15 0c ef 10 80    	cmp    0x8010ef0c,%edx
80100b90:	0f 83 25 fe ff ff    	jae    801009bb <consoleintr+0x1b>
  if(panicked){
80100b96:	8b 15 58 ef 10 80    	mov    0x8010ef58,%edx
        input.e++;        
80100b9c:	83 c0 01             	add    $0x1,%eax
80100b9f:	a3 08 ef 10 80       	mov    %eax,0x8010ef08
  if(panicked){
80100ba4:	85 d2                	test   %edx,%edx
80100ba6:	0f 84 ec 00 00 00    	je     80100c98 <consoleintr+0x2f8>
80100bac:	fa                   	cli    
    for(;;)
80100bad:	eb fe                	jmp    80100bad <consoleintr+0x20d>
80100baf:	90                   	nop
      if(input.e != input.w){
80100bb0:	a1 08 ef 10 80       	mov    0x8010ef08,%eax
80100bb5:	3b 05 04 ef 10 80    	cmp    0x8010ef04,%eax
80100bbb:	0f 84 fa fd ff ff    	je     801009bb <consoleintr+0x1b>
  if(panicked){
80100bc1:	8b 0d 58 ef 10 80    	mov    0x8010ef58,%ecx
        input.e--;        
80100bc7:	83 e8 01             	sub    $0x1,%eax
80100bca:	a3 08 ef 10 80       	mov    %eax,0x8010ef08
  if(panicked){
80100bcf:	85 c9                	test   %ecx,%ecx
80100bd1:	0f 84 96 00 00 00    	je     80100c6d <consoleintr+0x2cd>
80100bd7:	fa                   	cli    
    for(;;)
80100bd8:	eb fe                	jmp    80100bd8 <consoleintr+0x238>
80100bda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  release(&cons.lock);
80100be0:	83 ec 0c             	sub    $0xc,%esp
80100be3:	68 20 ef 10 80       	push   $0x8010ef20
80100be8:	e8 63 3c 00 00       	call   80104850 <release>
  if(doprocdump) {
80100bed:	83 c4 10             	add    $0x10,%esp
80100bf0:	85 f6                	test   %esi,%esi
80100bf2:	75 6d                	jne    80100c61 <consoleintr+0x2c1>
}
80100bf4:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100bf7:	5b                   	pop    %ebx
80100bf8:	5e                   	pop    %esi
80100bf9:	5f                   	pop    %edi
80100bfa:	5d                   	pop    %ebp
80100bfb:	c3                   	ret    
    uartputc('\b');    
80100bfc:	83 ec 0c             	sub    $0xc,%esp
80100bff:	6a 08                	push   $0x8
80100c01:	e8 ba 53 00 00       	call   80105fc0 <uartputc>
  cgaputc(c);
80100c06:	b8 00 01 00 00       	mov    $0x100,%eax
80100c0b:	e8 f0 f7 ff ff       	call   80100400 <cgaputc>
      while(input.e != input.w &&
80100c10:	8b 15 08 ef 10 80    	mov    0x8010ef08,%edx
80100c16:	83 c4 10             	add    $0x10,%esp
80100c19:	3b 15 04 ef 10 80    	cmp    0x8010ef04,%edx
80100c1f:	0f 85 95 fe ff ff    	jne    80100aba <consoleintr+0x11a>
      lineLength=input.e%INPUT_BUF;
80100c25:	83 e2 7f             	and    $0x7f,%edx
80100c28:	89 15 0c ef 10 80    	mov    %edx,0x8010ef0c
      break;
80100c2e:	e9 88 fd ff ff       	jmp    801009bb <consoleintr+0x1b>
80100c33:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100c37:	90                   	nop
      if(c != 0 && input.e-input.r < INPUT_BUF){
80100c38:	85 c0                	test   %eax,%eax
80100c3a:	0f 84 7b fd ff ff    	je     801009bb <consoleintr+0x1b>
80100c40:	e9 ac fd ff ff       	jmp    801009f1 <consoleintr+0x51>
80100c45:	8d 76 00             	lea    0x0(%esi),%esi
  cgaputc(c);
80100c48:	b8 03 01 00 00       	mov    $0x103,%eax
80100c4d:	e8 ae f7 ff ff       	call   80100400 <cgaputc>
}
80100c52:	e9 64 fd ff ff       	jmp    801009bb <consoleintr+0x1b>
    switch(c){
80100c57:	be 01 00 00 00       	mov    $0x1,%esi
80100c5c:	e9 5a fd ff ff       	jmp    801009bb <consoleintr+0x1b>
}
80100c61:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100c64:	5b                   	pop    %ebx
80100c65:	5e                   	pop    %esi
80100c66:	5f                   	pop    %edi
80100c67:	5d                   	pop    %ebp
    procdump();  // now call procdump() wo. cons.lock held
80100c68:	e9 83 38 00 00       	jmp    801044f0 <procdump>
  cgaputc(c);
80100c6d:	b8 01 01 00 00       	mov    $0x101,%eax
80100c72:	e8 89 f7 ff ff       	call   80100400 <cgaputc>
}
80100c77:	e9 3f fd ff ff       	jmp    801009bb <consoleintr+0x1b>
    uartputc('\b');    
80100c7c:	83 ec 0c             	sub    $0xc,%esp
80100c7f:	6a 08                	push   $0x8
80100c81:	e8 3a 53 00 00       	call   80105fc0 <uartputc>
  cgaputc(c);
80100c86:	b8 00 01 00 00       	mov    $0x100,%eax
80100c8b:	e8 70 f7 ff ff       	call   80100400 <cgaputc>
}
80100c90:	83 c4 10             	add    $0x10,%esp
80100c93:	e9 23 fd ff ff       	jmp    801009bb <consoleintr+0x1b>
  cgaputc(c);
80100c98:	b8 02 01 00 00       	mov    $0x102,%eax
80100c9d:	e8 5e f7 ff ff       	call   80100400 <cgaputc>
}
80100ca2:	e9 14 fd ff ff       	jmp    801009bb <consoleintr+0x1b>
80100ca7:	fa                   	cli    
    for(;;)
80100ca8:	eb fe                	jmp    80100ca8 <consoleintr+0x308>
80100caa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  if(panicked){
80100cb0:	85 d2                	test   %edx,%edx
80100cb2:	75 f3                	jne    80100ca7 <consoleintr+0x307>
    uartputc(c);
80100cb4:	83 ec 0c             	sub    $0xc,%esp
  cgaputc(c);
80100cb7:	bf 0a 00 00 00       	mov    $0xa,%edi
    uartputc(c);
80100cbc:	6a 0a                	push   $0xa
80100cbe:	e8 fd 52 00 00       	call   80105fc0 <uartputc>
  cgaputc(c);
80100cc3:	b8 0a 00 00 00       	mov    $0xa,%eax
80100cc8:	e8 33 f7 ff ff       	call   80100400 <cgaputc>
80100ccd:	83 c4 10             	add    $0x10,%esp
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){          
80100cd0:	a1 08 ef 10 80       	mov    0x8010ef08,%eax
80100cd5:	8b 0d 0c ef 10 80    	mov    0x8010ef0c,%ecx
80100cdb:	e9 83 fd ff ff       	jmp    80100a63 <consoleintr+0xc3>
          for (int i = input.e % INPUT_BUF; i < INPUT_BUF-1; i++){
80100ce0:	89 d0                	mov    %edx,%eax
          lineLength++;
80100ce2:	83 c1 01             	add    $0x1,%ecx
          for (int i = input.e % INPUT_BUF; i < INPUT_BUF-1; i++){
80100ce5:	83 e0 7f             	and    $0x7f,%eax
          lineLength++;
80100ce8:	89 0d 0c ef 10 80    	mov    %ecx,0x8010ef0c
          for (int i = input.e % INPUT_BUF; i < INPUT_BUF-1; i++){
80100cee:	83 f8 7f             	cmp    $0x7f,%eax
80100cf1:	74 15                	je     80100d08 <consoleintr+0x368>
            input.buf[i+1]=input.buf[i];
80100cf3:	0f b6 88 80 ee 10 80 	movzbl -0x7fef1180(%eax),%ecx
80100cfa:	83 c0 01             	add    $0x1,%eax
80100cfd:	88 88 80 ee 10 80    	mov    %cl,-0x7fef1180(%eax)
          for (int i = input.e % INPUT_BUF; i < INPUT_BUF-1; i++){
80100d03:	83 f8 7f             	cmp    $0x7f,%eax
80100d06:	75 f2                	jne    80100cfa <consoleintr+0x35a>
          input.buf[input.e++ % INPUT_BUF] = c;
80100d08:	8d 42 01             	lea    0x1(%edx),%eax
80100d0b:	83 e2 7f             	and    $0x7f,%edx
80100d0e:	a3 08 ef 10 80       	mov    %eax,0x8010ef08
80100d13:	89 f8                	mov    %edi,%eax
80100d15:	88 82 80 ee 10 80    	mov    %al,-0x7fef1180(%edx)
80100d1b:	e9 9b fc ff ff       	jmp    801009bb <consoleintr+0x1b>
    uartputc('\b');    
80100d20:	83 ec 0c             	sub    $0xc,%esp
  cgaputc(c);
80100d23:	31 ff                	xor    %edi,%edi
    uartputc('\b');    
80100d25:	6a 08                	push   $0x8
80100d27:	e8 94 52 00 00       	call   80105fc0 <uartputc>
  cgaputc(c);
80100d2c:	b8 00 01 00 00       	mov    $0x100,%eax
80100d31:	e8 ca f6 ff ff       	call   80100400 <cgaputc>
80100d36:	83 c4 10             	add    $0x10,%esp
80100d39:	e9 09 fd ff ff       	jmp    80100a47 <consoleintr+0xa7>
    uartputc(c);
80100d3e:	83 ec 0c             	sub    $0xc,%esp
80100d41:	89 45 e0             	mov    %eax,-0x20(%ebp)
80100d44:	50                   	push   %eax
80100d45:	e8 76 52 00 00       	call   80105fc0 <uartputc>
  cgaputc(c);
80100d4a:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100d4d:	e8 ae f6 ff ff       	call   80100400 <cgaputc>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){          
80100d52:	83 c4 10             	add    $0x10,%esp
80100d55:	80 7d e7 00          	cmpb   $0x0,-0x19(%ebp)
80100d59:	0f 85 71 ff ff ff    	jne    80100cd0 <consoleintr+0x330>
80100d5f:	e9 e3 fc ff ff       	jmp    80100a47 <consoleintr+0xa7>
80100d64:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100d6b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100d6f:	90                   	nop

80100d70 <consoleinit>:

void
consoleinit(void)
{
80100d70:	55                   	push   %ebp
80100d71:	89 e5                	mov    %esp,%ebp
80100d73:	83 ec 10             	sub    $0x10,%esp
  initlock(&cons.lock, "console");
80100d76:	68 08 75 10 80       	push   $0x80107508
80100d7b:	68 20 ef 10 80       	push   $0x8010ef20
80100d80:	e8 5b 39 00 00       	call   801046e0 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  ioapicenable(IRQ_KBD, 0);
80100d85:	58                   	pop    %eax
80100d86:	5a                   	pop    %edx
80100d87:	6a 00                	push   $0x0
80100d89:	6a 01                	push   $0x1
  devsw[CONSOLE].write = consolewrite;
80100d8b:	c7 05 0c f9 10 80 00 	movl   $0x80100600,0x8010f90c
80100d92:	06 10 80 
  devsw[CONSOLE].read = consoleread;
80100d95:	c7 05 08 f9 10 80 80 	movl   $0x80100280,0x8010f908
80100d9c:	02 10 80 
  cons.locking = 1;
80100d9f:	c7 05 54 ef 10 80 01 	movl   $0x1,0x8010ef54
80100da6:	00 00 00 
  ioapicenable(IRQ_KBD, 0);
80100da9:	e8 e2 19 00 00       	call   80102790 <ioapicenable>
}
80100dae:	83 c4 10             	add    $0x10,%esp
80100db1:	c9                   	leave  
80100db2:	c3                   	ret    
80100db3:	66 90                	xchg   %ax,%ax
80100db5:	66 90                	xchg   %ax,%ax
80100db7:	66 90                	xchg   %ax,%ax
80100db9:	66 90                	xchg   %ax,%ax
80100dbb:	66 90                	xchg   %ax,%ax
80100dbd:	66 90                	xchg   %ax,%ax
80100dbf:	90                   	nop

80100dc0 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
80100dc0:	55                   	push   %ebp
80100dc1:	89 e5                	mov    %esp,%ebp
80100dc3:	57                   	push   %edi
80100dc4:	56                   	push   %esi
80100dc5:	53                   	push   %ebx
80100dc6:	81 ec 0c 01 00 00    	sub    $0x10c,%esp
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
80100dcc:	e8 af 2e 00 00       	call   80103c80 <myproc>
80100dd1:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)

  begin_op();
80100dd7:	e8 94 22 00 00       	call   80103070 <begin_op>

  if((ip = namei(path)) == 0){
80100ddc:	83 ec 0c             	sub    $0xc,%esp
80100ddf:	ff 75 08             	push   0x8(%ebp)
80100de2:	e8 c9 15 00 00       	call   801023b0 <namei>
80100de7:	83 c4 10             	add    $0x10,%esp
80100dea:	85 c0                	test   %eax,%eax
80100dec:	0f 84 02 03 00 00    	je     801010f4 <exec+0x334>
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
80100df2:	83 ec 0c             	sub    $0xc,%esp
80100df5:	89 c3                	mov    %eax,%ebx
80100df7:	50                   	push   %eax
80100df8:	e8 93 0c 00 00       	call   80101a90 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
80100dfd:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80100e03:	6a 34                	push   $0x34
80100e05:	6a 00                	push   $0x0
80100e07:	50                   	push   %eax
80100e08:	53                   	push   %ebx
80100e09:	e8 92 0f 00 00       	call   80101da0 <readi>
80100e0e:	83 c4 20             	add    $0x20,%esp
80100e11:	83 f8 34             	cmp    $0x34,%eax
80100e14:	74 22                	je     80100e38 <exec+0x78>

 bad:
  if(pgdir)
    freevm(pgdir);
  if(ip){
    iunlockput(ip);
80100e16:	83 ec 0c             	sub    $0xc,%esp
80100e19:	53                   	push   %ebx
80100e1a:	e8 01 0f 00 00       	call   80101d20 <iunlockput>
    end_op();
80100e1f:	e8 bc 22 00 00       	call   801030e0 <end_op>
80100e24:	83 c4 10             	add    $0x10,%esp
  }
  return -1;
80100e27:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100e2c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100e2f:	5b                   	pop    %ebx
80100e30:	5e                   	pop    %esi
80100e31:	5f                   	pop    %edi
80100e32:	5d                   	pop    %ebp
80100e33:	c3                   	ret    
80100e34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(elf.magic != ELF_MAGIC)
80100e38:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80100e3f:	45 4c 46 
80100e42:	75 d2                	jne    80100e16 <exec+0x56>
  if((pgdir = setupkvm()) == 0)
80100e44:	e8 07 63 00 00       	call   80107150 <setupkvm>
80100e49:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)
80100e4f:	85 c0                	test   %eax,%eax
80100e51:	74 c3                	je     80100e16 <exec+0x56>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100e53:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80100e5a:	00 
80100e5b:	8b b5 40 ff ff ff    	mov    -0xc0(%ebp),%esi
80100e61:	0f 84 ac 02 00 00    	je     80101113 <exec+0x353>
  sz = 0;
80100e67:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
80100e6e:	00 00 00 
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100e71:	31 ff                	xor    %edi,%edi
80100e73:	e9 8e 00 00 00       	jmp    80100f06 <exec+0x146>
80100e78:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100e7f:	90                   	nop
    if(ph.type != ELF_PROG_LOAD)
80100e80:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80100e87:	75 6c                	jne    80100ef5 <exec+0x135>
    if(ph.memsz < ph.filesz)
80100e89:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
80100e8f:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80100e95:	0f 82 87 00 00 00    	jb     80100f22 <exec+0x162>
    if(ph.vaddr + ph.memsz < ph.vaddr)
80100e9b:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80100ea1:	72 7f                	jb     80100f22 <exec+0x162>
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100ea3:	83 ec 04             	sub    $0x4,%esp
80100ea6:	50                   	push   %eax
80100ea7:	ff b5 f0 fe ff ff    	push   -0x110(%ebp)
80100ead:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100eb3:	e8 b8 60 00 00       	call   80106f70 <allocuvm>
80100eb8:	83 c4 10             	add    $0x10,%esp
80100ebb:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100ec1:	85 c0                	test   %eax,%eax
80100ec3:	74 5d                	je     80100f22 <exec+0x162>
    if(ph.vaddr % PGSIZE != 0)
80100ec5:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100ecb:	a9 ff 0f 00 00       	test   $0xfff,%eax
80100ed0:	75 50                	jne    80100f22 <exec+0x162>
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100ed2:	83 ec 0c             	sub    $0xc,%esp
80100ed5:	ff b5 14 ff ff ff    	push   -0xec(%ebp)
80100edb:	ff b5 08 ff ff ff    	push   -0xf8(%ebp)
80100ee1:	53                   	push   %ebx
80100ee2:	50                   	push   %eax
80100ee3:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100ee9:	e8 92 5f 00 00       	call   80106e80 <loaduvm>
80100eee:	83 c4 20             	add    $0x20,%esp
80100ef1:	85 c0                	test   %eax,%eax
80100ef3:	78 2d                	js     80100f22 <exec+0x162>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100ef5:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
80100efc:	83 c7 01             	add    $0x1,%edi
80100eff:	83 c6 20             	add    $0x20,%esi
80100f02:	39 f8                	cmp    %edi,%eax
80100f04:	7e 3a                	jle    80100f40 <exec+0x180>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100f06:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
80100f0c:	6a 20                	push   $0x20
80100f0e:	56                   	push   %esi
80100f0f:	50                   	push   %eax
80100f10:	53                   	push   %ebx
80100f11:	e8 8a 0e 00 00       	call   80101da0 <readi>
80100f16:	83 c4 10             	add    $0x10,%esp
80100f19:	83 f8 20             	cmp    $0x20,%eax
80100f1c:	0f 84 5e ff ff ff    	je     80100e80 <exec+0xc0>
    freevm(pgdir);
80100f22:	83 ec 0c             	sub    $0xc,%esp
80100f25:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100f2b:	e8 a0 61 00 00       	call   801070d0 <freevm>
  if(ip){
80100f30:	83 c4 10             	add    $0x10,%esp
80100f33:	e9 de fe ff ff       	jmp    80100e16 <exec+0x56>
80100f38:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100f3f:	90                   	nop
  sz = PGROUNDUP(sz);
80100f40:	8b bd f0 fe ff ff    	mov    -0x110(%ebp),%edi
80100f46:	81 c7 ff 0f 00 00    	add    $0xfff,%edi
80100f4c:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100f52:	8d b7 00 20 00 00    	lea    0x2000(%edi),%esi
  iunlockput(ip);
80100f58:	83 ec 0c             	sub    $0xc,%esp
80100f5b:	53                   	push   %ebx
80100f5c:	e8 bf 0d 00 00       	call   80101d20 <iunlockput>
  end_op();
80100f61:	e8 7a 21 00 00       	call   801030e0 <end_op>
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100f66:	83 c4 0c             	add    $0xc,%esp
80100f69:	56                   	push   %esi
80100f6a:	57                   	push   %edi
80100f6b:	8b bd f4 fe ff ff    	mov    -0x10c(%ebp),%edi
80100f71:	57                   	push   %edi
80100f72:	e8 f9 5f 00 00       	call   80106f70 <allocuvm>
80100f77:	83 c4 10             	add    $0x10,%esp
80100f7a:	89 c6                	mov    %eax,%esi
80100f7c:	85 c0                	test   %eax,%eax
80100f7e:	0f 84 94 00 00 00    	je     80101018 <exec+0x258>
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100f84:	83 ec 08             	sub    $0x8,%esp
80100f87:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
  for(argc = 0; argv[argc]; argc++) {
80100f8d:	89 f3                	mov    %esi,%ebx
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100f8f:	50                   	push   %eax
80100f90:	57                   	push   %edi
  for(argc = 0; argv[argc]; argc++) {
80100f91:	31 ff                	xor    %edi,%edi
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100f93:	e8 58 62 00 00       	call   801071f0 <clearpteu>
  for(argc = 0; argv[argc]; argc++) {
80100f98:	8b 45 0c             	mov    0xc(%ebp),%eax
80100f9b:	83 c4 10             	add    $0x10,%esp
80100f9e:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
80100fa4:	8b 00                	mov    (%eax),%eax
80100fa6:	85 c0                	test   %eax,%eax
80100fa8:	0f 84 8b 00 00 00    	je     80101039 <exec+0x279>
80100fae:	89 b5 f0 fe ff ff    	mov    %esi,-0x110(%ebp)
80100fb4:	8b b5 f4 fe ff ff    	mov    -0x10c(%ebp),%esi
80100fba:	eb 23                	jmp    80100fdf <exec+0x21f>
80100fbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100fc0:	8b 45 0c             	mov    0xc(%ebp),%eax
    ustack[3+argc] = sp;
80100fc3:	89 9c bd 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%edi,4)
  for(argc = 0; argv[argc]; argc++) {
80100fca:	83 c7 01             	add    $0x1,%edi
    ustack[3+argc] = sp;
80100fcd:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
  for(argc = 0; argv[argc]; argc++) {
80100fd3:	8b 04 b8             	mov    (%eax,%edi,4),%eax
80100fd6:	85 c0                	test   %eax,%eax
80100fd8:	74 59                	je     80101033 <exec+0x273>
    if(argc >= MAXARG)
80100fda:	83 ff 20             	cmp    $0x20,%edi
80100fdd:	74 39                	je     80101018 <exec+0x258>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100fdf:	83 ec 0c             	sub    $0xc,%esp
80100fe2:	50                   	push   %eax
80100fe3:	e8 88 3b 00 00       	call   80104b70 <strlen>
80100fe8:	29 c3                	sub    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100fea:	58                   	pop    %eax
80100feb:	8b 45 0c             	mov    0xc(%ebp),%eax
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100fee:	83 eb 01             	sub    $0x1,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100ff1:	ff 34 b8             	push   (%eax,%edi,4)
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100ff4:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100ff7:	e8 74 3b 00 00       	call   80104b70 <strlen>
80100ffc:	83 c0 01             	add    $0x1,%eax
80100fff:	50                   	push   %eax
80101000:	8b 45 0c             	mov    0xc(%ebp),%eax
80101003:	ff 34 b8             	push   (%eax,%edi,4)
80101006:	53                   	push   %ebx
80101007:	56                   	push   %esi
80101008:	e8 b3 63 00 00       	call   801073c0 <copyout>
8010100d:	83 c4 20             	add    $0x20,%esp
80101010:	85 c0                	test   %eax,%eax
80101012:	79 ac                	jns    80100fc0 <exec+0x200>
80101014:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    freevm(pgdir);
80101018:	83 ec 0c             	sub    $0xc,%esp
8010101b:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80101021:	e8 aa 60 00 00       	call   801070d0 <freevm>
80101026:	83 c4 10             	add    $0x10,%esp
  return -1;
80101029:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010102e:	e9 f9 fd ff ff       	jmp    80100e2c <exec+0x6c>
80101033:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80101039:	8d 04 bd 04 00 00 00 	lea    0x4(,%edi,4),%eax
80101040:	89 d9                	mov    %ebx,%ecx
  ustack[3+argc] = 0;
80101042:	c7 84 bd 64 ff ff ff 	movl   $0x0,-0x9c(%ebp,%edi,4)
80101049:	00 00 00 00 
  ustack[2] = sp - (argc+1)*4;  // argv pointer
8010104d:	29 c1                	sub    %eax,%ecx
  sp -= (3+argc+1) * 4;
8010104f:	83 c0 0c             	add    $0xc,%eax
  ustack[1] = argc;
80101052:	89 bd 5c ff ff ff    	mov    %edi,-0xa4(%ebp)
  sp -= (3+argc+1) * 4;
80101058:	29 c3                	sub    %eax,%ebx
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
8010105a:	50                   	push   %eax
8010105b:	52                   	push   %edx
8010105c:	53                   	push   %ebx
8010105d:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
  ustack[0] = 0xffffffff;  // fake return PC
80101063:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
8010106a:	ff ff ff 
  ustack[2] = sp - (argc+1)*4;  // argv pointer
8010106d:	89 8d 60 ff ff ff    	mov    %ecx,-0xa0(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80101073:	e8 48 63 00 00       	call   801073c0 <copyout>
80101078:	83 c4 10             	add    $0x10,%esp
8010107b:	85 c0                	test   %eax,%eax
8010107d:	78 99                	js     80101018 <exec+0x258>
  for(last=s=path; *s; s++)
8010107f:	8b 45 08             	mov    0x8(%ebp),%eax
80101082:	8b 55 08             	mov    0x8(%ebp),%edx
80101085:	0f b6 00             	movzbl (%eax),%eax
80101088:	84 c0                	test   %al,%al
8010108a:	74 13                	je     8010109f <exec+0x2df>
8010108c:	89 d1                	mov    %edx,%ecx
8010108e:	66 90                	xchg   %ax,%ax
      last = s+1;
80101090:	83 c1 01             	add    $0x1,%ecx
80101093:	3c 2f                	cmp    $0x2f,%al
  for(last=s=path; *s; s++)
80101095:	0f b6 01             	movzbl (%ecx),%eax
      last = s+1;
80101098:	0f 44 d1             	cmove  %ecx,%edx
  for(last=s=path; *s; s++)
8010109b:	84 c0                	test   %al,%al
8010109d:	75 f1                	jne    80101090 <exec+0x2d0>
  safestrcpy(curproc->name, last, sizeof(curproc->name));
8010109f:	8b bd ec fe ff ff    	mov    -0x114(%ebp),%edi
801010a5:	83 ec 04             	sub    $0x4,%esp
801010a8:	6a 10                	push   $0x10
801010aa:	89 f8                	mov    %edi,%eax
801010ac:	52                   	push   %edx
801010ad:	83 c0 6c             	add    $0x6c,%eax
801010b0:	50                   	push   %eax
801010b1:	e8 7a 3a 00 00       	call   80104b30 <safestrcpy>
  curproc->pgdir = pgdir;
801010b6:	8b 8d f4 fe ff ff    	mov    -0x10c(%ebp),%ecx
  oldpgdir = curproc->pgdir;
801010bc:	89 f8                	mov    %edi,%eax
801010be:	8b 7f 04             	mov    0x4(%edi),%edi
  curproc->sz = sz;
801010c1:	89 30                	mov    %esi,(%eax)
  curproc->pgdir = pgdir;
801010c3:	89 48 04             	mov    %ecx,0x4(%eax)
  curproc->tf->eip = elf.entry;  // main
801010c6:	89 c1                	mov    %eax,%ecx
801010c8:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
801010ce:	8b 40 18             	mov    0x18(%eax),%eax
801010d1:	89 50 38             	mov    %edx,0x38(%eax)
  curproc->tf->esp = sp;
801010d4:	8b 41 18             	mov    0x18(%ecx),%eax
801010d7:	89 58 44             	mov    %ebx,0x44(%eax)
  switchuvm(curproc);
801010da:	89 0c 24             	mov    %ecx,(%esp)
801010dd:	e8 0e 5c 00 00       	call   80106cf0 <switchuvm>
  freevm(oldpgdir);
801010e2:	89 3c 24             	mov    %edi,(%esp)
801010e5:	e8 e6 5f 00 00       	call   801070d0 <freevm>
  return 0;
801010ea:	83 c4 10             	add    $0x10,%esp
801010ed:	31 c0                	xor    %eax,%eax
801010ef:	e9 38 fd ff ff       	jmp    80100e2c <exec+0x6c>
    end_op();
801010f4:	e8 e7 1f 00 00       	call   801030e0 <end_op>
    cprintf("exec: fail\n");
801010f9:	83 ec 0c             	sub    $0xc,%esp
801010fc:	68 79 75 10 80       	push   $0x80107579
80101101:	e8 2a f6 ff ff       	call   80100730 <cprintf>
    return -1;
80101106:	83 c4 10             	add    $0x10,%esp
80101109:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010110e:	e9 19 fd ff ff       	jmp    80100e2c <exec+0x6c>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80101113:	be 00 20 00 00       	mov    $0x2000,%esi
80101118:	31 ff                	xor    %edi,%edi
8010111a:	e9 39 fe ff ff       	jmp    80100f58 <exec+0x198>
8010111f:	90                   	nop

80101120 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80101120:	55                   	push   %ebp
80101121:	89 e5                	mov    %esp,%ebp
80101123:	83 ec 10             	sub    $0x10,%esp
  initlock(&ftable.lock, "ftable");
80101126:	68 85 75 10 80       	push   $0x80107585
8010112b:	68 60 ef 10 80       	push   $0x8010ef60
80101130:	e8 ab 35 00 00       	call   801046e0 <initlock>
}
80101135:	83 c4 10             	add    $0x10,%esp
80101138:	c9                   	leave  
80101139:	c3                   	ret    
8010113a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101140 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80101140:	55                   	push   %ebp
80101141:	89 e5                	mov    %esp,%ebp
80101143:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80101144:	bb 94 ef 10 80       	mov    $0x8010ef94,%ebx
{
80101149:	83 ec 10             	sub    $0x10,%esp
  acquire(&ftable.lock);
8010114c:	68 60 ef 10 80       	push   $0x8010ef60
80101151:	e8 5a 37 00 00       	call   801048b0 <acquire>
80101156:	83 c4 10             	add    $0x10,%esp
80101159:	eb 10                	jmp    8010116b <filealloc+0x2b>
8010115b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010115f:	90                   	nop
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80101160:	83 c3 18             	add    $0x18,%ebx
80101163:	81 fb f4 f8 10 80    	cmp    $0x8010f8f4,%ebx
80101169:	74 25                	je     80101190 <filealloc+0x50>
    if(f->ref == 0){
8010116b:	8b 43 04             	mov    0x4(%ebx),%eax
8010116e:	85 c0                	test   %eax,%eax
80101170:	75 ee                	jne    80101160 <filealloc+0x20>
      f->ref = 1;
      release(&ftable.lock);
80101172:	83 ec 0c             	sub    $0xc,%esp
      f->ref = 1;
80101175:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
8010117c:	68 60 ef 10 80       	push   $0x8010ef60
80101181:	e8 ca 36 00 00       	call   80104850 <release>
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
}
80101186:	89 d8                	mov    %ebx,%eax
      return f;
80101188:	83 c4 10             	add    $0x10,%esp
}
8010118b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010118e:	c9                   	leave  
8010118f:	c3                   	ret    
  release(&ftable.lock);
80101190:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80101193:	31 db                	xor    %ebx,%ebx
  release(&ftable.lock);
80101195:	68 60 ef 10 80       	push   $0x8010ef60
8010119a:	e8 b1 36 00 00       	call   80104850 <release>
}
8010119f:	89 d8                	mov    %ebx,%eax
  return 0;
801011a1:	83 c4 10             	add    $0x10,%esp
}
801011a4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801011a7:	c9                   	leave  
801011a8:	c3                   	ret    
801011a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801011b0 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
801011b0:	55                   	push   %ebp
801011b1:	89 e5                	mov    %esp,%ebp
801011b3:	53                   	push   %ebx
801011b4:	83 ec 10             	sub    $0x10,%esp
801011b7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
801011ba:	68 60 ef 10 80       	push   $0x8010ef60
801011bf:	e8 ec 36 00 00       	call   801048b0 <acquire>
  if(f->ref < 1)
801011c4:	8b 43 04             	mov    0x4(%ebx),%eax
801011c7:	83 c4 10             	add    $0x10,%esp
801011ca:	85 c0                	test   %eax,%eax
801011cc:	7e 1a                	jle    801011e8 <filedup+0x38>
    panic("filedup");
  f->ref++;
801011ce:	83 c0 01             	add    $0x1,%eax
  release(&ftable.lock);
801011d1:	83 ec 0c             	sub    $0xc,%esp
  f->ref++;
801011d4:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
801011d7:	68 60 ef 10 80       	push   $0x8010ef60
801011dc:	e8 6f 36 00 00       	call   80104850 <release>
  return f;
}
801011e1:	89 d8                	mov    %ebx,%eax
801011e3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801011e6:	c9                   	leave  
801011e7:	c3                   	ret    
    panic("filedup");
801011e8:	83 ec 0c             	sub    $0xc,%esp
801011eb:	68 8c 75 10 80       	push   $0x8010758c
801011f0:	e8 8b f1 ff ff       	call   80100380 <panic>
801011f5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801011fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101200 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80101200:	55                   	push   %ebp
80101201:	89 e5                	mov    %esp,%ebp
80101203:	57                   	push   %edi
80101204:	56                   	push   %esi
80101205:	53                   	push   %ebx
80101206:	83 ec 28             	sub    $0x28,%esp
80101209:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct file ff;

  acquire(&ftable.lock);
8010120c:	68 60 ef 10 80       	push   $0x8010ef60
80101211:	e8 9a 36 00 00       	call   801048b0 <acquire>
  if(f->ref < 1)
80101216:	8b 53 04             	mov    0x4(%ebx),%edx
80101219:	83 c4 10             	add    $0x10,%esp
8010121c:	85 d2                	test   %edx,%edx
8010121e:	0f 8e a5 00 00 00    	jle    801012c9 <fileclose+0xc9>
    panic("fileclose");
  if(--f->ref > 0){
80101224:	83 ea 01             	sub    $0x1,%edx
80101227:	89 53 04             	mov    %edx,0x4(%ebx)
8010122a:	75 44                	jne    80101270 <fileclose+0x70>
    release(&ftable.lock);
    return;
  }
  ff = *f;
8010122c:	0f b6 43 09          	movzbl 0x9(%ebx),%eax
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
80101230:	83 ec 0c             	sub    $0xc,%esp
  ff = *f;
80101233:	8b 3b                	mov    (%ebx),%edi
  f->type = FD_NONE;
80101235:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  ff = *f;
8010123b:	8b 73 0c             	mov    0xc(%ebx),%esi
8010123e:	88 45 e7             	mov    %al,-0x19(%ebp)
80101241:	8b 43 10             	mov    0x10(%ebx),%eax
  release(&ftable.lock);
80101244:	68 60 ef 10 80       	push   $0x8010ef60
  ff = *f;
80101249:	89 45 e0             	mov    %eax,-0x20(%ebp)
  release(&ftable.lock);
8010124c:	e8 ff 35 00 00       	call   80104850 <release>

  if(ff.type == FD_PIPE)
80101251:	83 c4 10             	add    $0x10,%esp
80101254:	83 ff 01             	cmp    $0x1,%edi
80101257:	74 57                	je     801012b0 <fileclose+0xb0>
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
80101259:	83 ff 02             	cmp    $0x2,%edi
8010125c:	74 2a                	je     80101288 <fileclose+0x88>
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
8010125e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101261:	5b                   	pop    %ebx
80101262:	5e                   	pop    %esi
80101263:	5f                   	pop    %edi
80101264:	5d                   	pop    %ebp
80101265:	c3                   	ret    
80101266:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010126d:	8d 76 00             	lea    0x0(%esi),%esi
    release(&ftable.lock);
80101270:	c7 45 08 60 ef 10 80 	movl   $0x8010ef60,0x8(%ebp)
}
80101277:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010127a:	5b                   	pop    %ebx
8010127b:	5e                   	pop    %esi
8010127c:	5f                   	pop    %edi
8010127d:	5d                   	pop    %ebp
    release(&ftable.lock);
8010127e:	e9 cd 35 00 00       	jmp    80104850 <release>
80101283:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101287:	90                   	nop
    begin_op();
80101288:	e8 e3 1d 00 00       	call   80103070 <begin_op>
    iput(ff.ip);
8010128d:	83 ec 0c             	sub    $0xc,%esp
80101290:	ff 75 e0             	push   -0x20(%ebp)
80101293:	e8 28 09 00 00       	call   80101bc0 <iput>
    end_op();
80101298:	83 c4 10             	add    $0x10,%esp
}
8010129b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010129e:	5b                   	pop    %ebx
8010129f:	5e                   	pop    %esi
801012a0:	5f                   	pop    %edi
801012a1:	5d                   	pop    %ebp
    end_op();
801012a2:	e9 39 1e 00 00       	jmp    801030e0 <end_op>
801012a7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801012ae:	66 90                	xchg   %ax,%ax
    pipeclose(ff.pipe, ff.writable);
801012b0:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
801012b4:	83 ec 08             	sub    $0x8,%esp
801012b7:	53                   	push   %ebx
801012b8:	56                   	push   %esi
801012b9:	e8 82 25 00 00       	call   80103840 <pipeclose>
801012be:	83 c4 10             	add    $0x10,%esp
}
801012c1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801012c4:	5b                   	pop    %ebx
801012c5:	5e                   	pop    %esi
801012c6:	5f                   	pop    %edi
801012c7:	5d                   	pop    %ebp
801012c8:	c3                   	ret    
    panic("fileclose");
801012c9:	83 ec 0c             	sub    $0xc,%esp
801012cc:	68 94 75 10 80       	push   $0x80107594
801012d1:	e8 aa f0 ff ff       	call   80100380 <panic>
801012d6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801012dd:	8d 76 00             	lea    0x0(%esi),%esi

801012e0 <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
801012e0:	55                   	push   %ebp
801012e1:	89 e5                	mov    %esp,%ebp
801012e3:	53                   	push   %ebx
801012e4:	83 ec 04             	sub    $0x4,%esp
801012e7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
801012ea:	83 3b 02             	cmpl   $0x2,(%ebx)
801012ed:	75 31                	jne    80101320 <filestat+0x40>
    ilock(f->ip);
801012ef:	83 ec 0c             	sub    $0xc,%esp
801012f2:	ff 73 10             	push   0x10(%ebx)
801012f5:	e8 96 07 00 00       	call   80101a90 <ilock>
    stati(f->ip, st);
801012fa:	58                   	pop    %eax
801012fb:	5a                   	pop    %edx
801012fc:	ff 75 0c             	push   0xc(%ebp)
801012ff:	ff 73 10             	push   0x10(%ebx)
80101302:	e8 69 0a 00 00       	call   80101d70 <stati>
    iunlock(f->ip);
80101307:	59                   	pop    %ecx
80101308:	ff 73 10             	push   0x10(%ebx)
8010130b:	e8 60 08 00 00       	call   80101b70 <iunlock>
    return 0;
  }
  return -1;
}
80101310:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return 0;
80101313:	83 c4 10             	add    $0x10,%esp
80101316:	31 c0                	xor    %eax,%eax
}
80101318:	c9                   	leave  
80101319:	c3                   	ret    
8010131a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101320:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return -1;
80101323:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80101328:	c9                   	leave  
80101329:	c3                   	ret    
8010132a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101330 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80101330:	55                   	push   %ebp
80101331:	89 e5                	mov    %esp,%ebp
80101333:	57                   	push   %edi
80101334:	56                   	push   %esi
80101335:	53                   	push   %ebx
80101336:	83 ec 0c             	sub    $0xc,%esp
80101339:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010133c:	8b 75 0c             	mov    0xc(%ebp),%esi
8010133f:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
80101342:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
80101346:	74 60                	je     801013a8 <fileread+0x78>
    return -1;
  if(f->type == FD_PIPE)
80101348:	8b 03                	mov    (%ebx),%eax
8010134a:	83 f8 01             	cmp    $0x1,%eax
8010134d:	74 41                	je     80101390 <fileread+0x60>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
8010134f:	83 f8 02             	cmp    $0x2,%eax
80101352:	75 5b                	jne    801013af <fileread+0x7f>
    ilock(f->ip);
80101354:	83 ec 0c             	sub    $0xc,%esp
80101357:	ff 73 10             	push   0x10(%ebx)
8010135a:	e8 31 07 00 00       	call   80101a90 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
8010135f:	57                   	push   %edi
80101360:	ff 73 14             	push   0x14(%ebx)
80101363:	56                   	push   %esi
80101364:	ff 73 10             	push   0x10(%ebx)
80101367:	e8 34 0a 00 00       	call   80101da0 <readi>
8010136c:	83 c4 20             	add    $0x20,%esp
8010136f:	89 c6                	mov    %eax,%esi
80101371:	85 c0                	test   %eax,%eax
80101373:	7e 03                	jle    80101378 <fileread+0x48>
      f->off += r;
80101375:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
80101378:	83 ec 0c             	sub    $0xc,%esp
8010137b:	ff 73 10             	push   0x10(%ebx)
8010137e:	e8 ed 07 00 00       	call   80101b70 <iunlock>
    return r;
80101383:	83 c4 10             	add    $0x10,%esp
  }
  panic("fileread");
}
80101386:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101389:	89 f0                	mov    %esi,%eax
8010138b:	5b                   	pop    %ebx
8010138c:	5e                   	pop    %esi
8010138d:	5f                   	pop    %edi
8010138e:	5d                   	pop    %ebp
8010138f:	c3                   	ret    
    return piperead(f->pipe, addr, n);
80101390:	8b 43 0c             	mov    0xc(%ebx),%eax
80101393:	89 45 08             	mov    %eax,0x8(%ebp)
}
80101396:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101399:	5b                   	pop    %ebx
8010139a:	5e                   	pop    %esi
8010139b:	5f                   	pop    %edi
8010139c:	5d                   	pop    %ebp
    return piperead(f->pipe, addr, n);
8010139d:	e9 3e 26 00 00       	jmp    801039e0 <piperead>
801013a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
801013a8:	be ff ff ff ff       	mov    $0xffffffff,%esi
801013ad:	eb d7                	jmp    80101386 <fileread+0x56>
  panic("fileread");
801013af:	83 ec 0c             	sub    $0xc,%esp
801013b2:	68 9e 75 10 80       	push   $0x8010759e
801013b7:	e8 c4 ef ff ff       	call   80100380 <panic>
801013bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801013c0 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
801013c0:	55                   	push   %ebp
801013c1:	89 e5                	mov    %esp,%ebp
801013c3:	57                   	push   %edi
801013c4:	56                   	push   %esi
801013c5:	53                   	push   %ebx
801013c6:	83 ec 1c             	sub    $0x1c,%esp
801013c9:	8b 45 0c             	mov    0xc(%ebp),%eax
801013cc:	8b 5d 08             	mov    0x8(%ebp),%ebx
801013cf:	89 45 dc             	mov    %eax,-0x24(%ebp)
801013d2:	8b 45 10             	mov    0x10(%ebp),%eax
  int r;

  if(f->writable == 0)
801013d5:	80 7b 09 00          	cmpb   $0x0,0x9(%ebx)
{
801013d9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(f->writable == 0)
801013dc:	0f 84 bd 00 00 00    	je     8010149f <filewrite+0xdf>
    return -1;
  if(f->type == FD_PIPE)
801013e2:	8b 03                	mov    (%ebx),%eax
801013e4:	83 f8 01             	cmp    $0x1,%eax
801013e7:	0f 84 bf 00 00 00    	je     801014ac <filewrite+0xec>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
801013ed:	83 f8 02             	cmp    $0x2,%eax
801013f0:	0f 85 c8 00 00 00    	jne    801014be <filewrite+0xfe>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
801013f6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    int i = 0;
801013f9:	31 f6                	xor    %esi,%esi
    while(i < n){
801013fb:	85 c0                	test   %eax,%eax
801013fd:	7f 30                	jg     8010142f <filewrite+0x6f>
801013ff:	e9 94 00 00 00       	jmp    80101498 <filewrite+0xd8>
80101404:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
80101408:	01 43 14             	add    %eax,0x14(%ebx)
      iunlock(f->ip);
8010140b:	83 ec 0c             	sub    $0xc,%esp
8010140e:	ff 73 10             	push   0x10(%ebx)
        f->off += r;
80101411:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
80101414:	e8 57 07 00 00       	call   80101b70 <iunlock>
      end_op();
80101419:	e8 c2 1c 00 00       	call   801030e0 <end_op>

      if(r < 0)
        break;
      if(r != n1)
8010141e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101421:	83 c4 10             	add    $0x10,%esp
80101424:	39 c7                	cmp    %eax,%edi
80101426:	75 5c                	jne    80101484 <filewrite+0xc4>
        panic("short filewrite");
      i += r;
80101428:	01 fe                	add    %edi,%esi
    while(i < n){
8010142a:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
8010142d:	7e 69                	jle    80101498 <filewrite+0xd8>
      int n1 = n - i;
8010142f:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101432:	b8 00 06 00 00       	mov    $0x600,%eax
80101437:	29 f7                	sub    %esi,%edi
80101439:	39 c7                	cmp    %eax,%edi
8010143b:	0f 4f f8             	cmovg  %eax,%edi
      begin_op();
8010143e:	e8 2d 1c 00 00       	call   80103070 <begin_op>
      ilock(f->ip);
80101443:	83 ec 0c             	sub    $0xc,%esp
80101446:	ff 73 10             	push   0x10(%ebx)
80101449:	e8 42 06 00 00       	call   80101a90 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
8010144e:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101451:	57                   	push   %edi
80101452:	ff 73 14             	push   0x14(%ebx)
80101455:	01 f0                	add    %esi,%eax
80101457:	50                   	push   %eax
80101458:	ff 73 10             	push   0x10(%ebx)
8010145b:	e8 40 0a 00 00       	call   80101ea0 <writei>
80101460:	83 c4 20             	add    $0x20,%esp
80101463:	85 c0                	test   %eax,%eax
80101465:	7f a1                	jg     80101408 <filewrite+0x48>
      iunlock(f->ip);
80101467:	83 ec 0c             	sub    $0xc,%esp
8010146a:	ff 73 10             	push   0x10(%ebx)
8010146d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101470:	e8 fb 06 00 00       	call   80101b70 <iunlock>
      end_op();
80101475:	e8 66 1c 00 00       	call   801030e0 <end_op>
      if(r < 0)
8010147a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010147d:	83 c4 10             	add    $0x10,%esp
80101480:	85 c0                	test   %eax,%eax
80101482:	75 1b                	jne    8010149f <filewrite+0xdf>
        panic("short filewrite");
80101484:	83 ec 0c             	sub    $0xc,%esp
80101487:	68 a7 75 10 80       	push   $0x801075a7
8010148c:	e8 ef ee ff ff       	call   80100380 <panic>
80101491:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    }
    return i == n ? n : -1;
80101498:	89 f0                	mov    %esi,%eax
8010149a:	3b 75 e4             	cmp    -0x1c(%ebp),%esi
8010149d:	74 05                	je     801014a4 <filewrite+0xe4>
8010149f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  panic("filewrite");
}
801014a4:	8d 65 f4             	lea    -0xc(%ebp),%esp
801014a7:	5b                   	pop    %ebx
801014a8:	5e                   	pop    %esi
801014a9:	5f                   	pop    %edi
801014aa:	5d                   	pop    %ebp
801014ab:	c3                   	ret    
    return pipewrite(f->pipe, addr, n);
801014ac:	8b 43 0c             	mov    0xc(%ebx),%eax
801014af:	89 45 08             	mov    %eax,0x8(%ebp)
}
801014b2:	8d 65 f4             	lea    -0xc(%ebp),%esp
801014b5:	5b                   	pop    %ebx
801014b6:	5e                   	pop    %esi
801014b7:	5f                   	pop    %edi
801014b8:	5d                   	pop    %ebp
    return pipewrite(f->pipe, addr, n);
801014b9:	e9 22 24 00 00       	jmp    801038e0 <pipewrite>
  panic("filewrite");
801014be:	83 ec 0c             	sub    $0xc,%esp
801014c1:	68 ad 75 10 80       	push   $0x801075ad
801014c6:	e8 b5 ee ff ff       	call   80100380 <panic>
801014cb:	66 90                	xchg   %ax,%ax
801014cd:	66 90                	xchg   %ax,%ax
801014cf:	90                   	nop

801014d0 <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
801014d0:	55                   	push   %ebp
801014d1:	89 c1                	mov    %eax,%ecx
  struct buf *bp;
  int bi, m;

  bp = bread(dev, BBLOCK(b, sb));
801014d3:	89 d0                	mov    %edx,%eax
801014d5:	c1 e8 0c             	shr    $0xc,%eax
801014d8:	03 05 cc 15 11 80    	add    0x801115cc,%eax
{
801014de:	89 e5                	mov    %esp,%ebp
801014e0:	56                   	push   %esi
801014e1:	53                   	push   %ebx
801014e2:	89 d3                	mov    %edx,%ebx
  bp = bread(dev, BBLOCK(b, sb));
801014e4:	83 ec 08             	sub    $0x8,%esp
801014e7:	50                   	push   %eax
801014e8:	51                   	push   %ecx
801014e9:	e8 e2 eb ff ff       	call   801000d0 <bread>
  bi = b % BPB;
  m = 1 << (bi % 8);
801014ee:	89 d9                	mov    %ebx,%ecx
  if((bp->data[bi/8] & m) == 0)
801014f0:	c1 fb 03             	sar    $0x3,%ebx
801014f3:	83 c4 10             	add    $0x10,%esp
  bp = bread(dev, BBLOCK(b, sb));
801014f6:	89 c6                	mov    %eax,%esi
  m = 1 << (bi % 8);
801014f8:	83 e1 07             	and    $0x7,%ecx
801014fb:	b8 01 00 00 00       	mov    $0x1,%eax
  if((bp->data[bi/8] & m) == 0)
80101500:	81 e3 ff 01 00 00    	and    $0x1ff,%ebx
  m = 1 << (bi % 8);
80101506:	d3 e0                	shl    %cl,%eax
  if((bp->data[bi/8] & m) == 0)
80101508:	0f b6 4c 1e 5c       	movzbl 0x5c(%esi,%ebx,1),%ecx
8010150d:	85 c1                	test   %eax,%ecx
8010150f:	74 23                	je     80101534 <bfree+0x64>
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
80101511:	f7 d0                	not    %eax
  log_write(bp);
80101513:	83 ec 0c             	sub    $0xc,%esp
  bp->data[bi/8] &= ~m;
80101516:	21 c8                	and    %ecx,%eax
80101518:	88 44 1e 5c          	mov    %al,0x5c(%esi,%ebx,1)
  log_write(bp);
8010151c:	56                   	push   %esi
8010151d:	e8 2e 1d 00 00       	call   80103250 <log_write>
  brelse(bp);
80101522:	89 34 24             	mov    %esi,(%esp)
80101525:	e8 c6 ec ff ff       	call   801001f0 <brelse>
}
8010152a:	83 c4 10             	add    $0x10,%esp
8010152d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101530:	5b                   	pop    %ebx
80101531:	5e                   	pop    %esi
80101532:	5d                   	pop    %ebp
80101533:	c3                   	ret    
    panic("freeing free block");
80101534:	83 ec 0c             	sub    $0xc,%esp
80101537:	68 b7 75 10 80       	push   $0x801075b7
8010153c:	e8 3f ee ff ff       	call   80100380 <panic>
80101541:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101548:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010154f:	90                   	nop

80101550 <balloc>:
{
80101550:	55                   	push   %ebp
80101551:	89 e5                	mov    %esp,%ebp
80101553:	57                   	push   %edi
80101554:	56                   	push   %esi
80101555:	53                   	push   %ebx
80101556:	83 ec 1c             	sub    $0x1c,%esp
  for(b = 0; b < sb.size; b += BPB){
80101559:	8b 0d b4 15 11 80    	mov    0x801115b4,%ecx
{
8010155f:	89 45 d8             	mov    %eax,-0x28(%ebp)
  for(b = 0; b < sb.size; b += BPB){
80101562:	85 c9                	test   %ecx,%ecx
80101564:	0f 84 87 00 00 00    	je     801015f1 <balloc+0xa1>
8010156a:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    bp = bread(dev, BBLOCK(b, sb));
80101571:	8b 75 dc             	mov    -0x24(%ebp),%esi
80101574:	83 ec 08             	sub    $0x8,%esp
80101577:	89 f0                	mov    %esi,%eax
80101579:	c1 f8 0c             	sar    $0xc,%eax
8010157c:	03 05 cc 15 11 80    	add    0x801115cc,%eax
80101582:	50                   	push   %eax
80101583:	ff 75 d8             	push   -0x28(%ebp)
80101586:	e8 45 eb ff ff       	call   801000d0 <bread>
8010158b:	83 c4 10             	add    $0x10,%esp
8010158e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
80101591:	a1 b4 15 11 80       	mov    0x801115b4,%eax
80101596:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101599:	31 c0                	xor    %eax,%eax
8010159b:	eb 2f                	jmp    801015cc <balloc+0x7c>
8010159d:	8d 76 00             	lea    0x0(%esi),%esi
      m = 1 << (bi % 8);
801015a0:	89 c1                	mov    %eax,%ecx
801015a2:	bb 01 00 00 00       	mov    $0x1,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
801015a7:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      m = 1 << (bi % 8);
801015aa:	83 e1 07             	and    $0x7,%ecx
801015ad:	d3 e3                	shl    %cl,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
801015af:	89 c1                	mov    %eax,%ecx
801015b1:	c1 f9 03             	sar    $0x3,%ecx
801015b4:	0f b6 7c 0a 5c       	movzbl 0x5c(%edx,%ecx,1),%edi
801015b9:	89 fa                	mov    %edi,%edx
801015bb:	85 df                	test   %ebx,%edi
801015bd:	74 41                	je     80101600 <balloc+0xb0>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
801015bf:	83 c0 01             	add    $0x1,%eax
801015c2:	83 c6 01             	add    $0x1,%esi
801015c5:	3d 00 10 00 00       	cmp    $0x1000,%eax
801015ca:	74 05                	je     801015d1 <balloc+0x81>
801015cc:	39 75 e0             	cmp    %esi,-0x20(%ebp)
801015cf:	77 cf                	ja     801015a0 <balloc+0x50>
    brelse(bp);
801015d1:	83 ec 0c             	sub    $0xc,%esp
801015d4:	ff 75 e4             	push   -0x1c(%ebp)
801015d7:	e8 14 ec ff ff       	call   801001f0 <brelse>
  for(b = 0; b < sb.size; b += BPB){
801015dc:	81 45 dc 00 10 00 00 	addl   $0x1000,-0x24(%ebp)
801015e3:	83 c4 10             	add    $0x10,%esp
801015e6:	8b 45 dc             	mov    -0x24(%ebp),%eax
801015e9:	39 05 b4 15 11 80    	cmp    %eax,0x801115b4
801015ef:	77 80                	ja     80101571 <balloc+0x21>
  panic("balloc: out of blocks");
801015f1:	83 ec 0c             	sub    $0xc,%esp
801015f4:	68 ca 75 10 80       	push   $0x801075ca
801015f9:	e8 82 ed ff ff       	call   80100380 <panic>
801015fe:	66 90                	xchg   %ax,%ax
        bp->data[bi/8] |= m;  // Mark block in use.
80101600:	8b 7d e4             	mov    -0x1c(%ebp),%edi
        log_write(bp);
80101603:	83 ec 0c             	sub    $0xc,%esp
        bp->data[bi/8] |= m;  // Mark block in use.
80101606:	09 da                	or     %ebx,%edx
80101608:	88 54 0f 5c          	mov    %dl,0x5c(%edi,%ecx,1)
        log_write(bp);
8010160c:	57                   	push   %edi
8010160d:	e8 3e 1c 00 00       	call   80103250 <log_write>
        brelse(bp);
80101612:	89 3c 24             	mov    %edi,(%esp)
80101615:	e8 d6 eb ff ff       	call   801001f0 <brelse>
  bp = bread(dev, bno);
8010161a:	58                   	pop    %eax
8010161b:	5a                   	pop    %edx
8010161c:	56                   	push   %esi
8010161d:	ff 75 d8             	push   -0x28(%ebp)
80101620:	e8 ab ea ff ff       	call   801000d0 <bread>
  memset(bp->data, 0, BSIZE);
80101625:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, bno);
80101628:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
8010162a:	8d 40 5c             	lea    0x5c(%eax),%eax
8010162d:	68 00 02 00 00       	push   $0x200
80101632:	6a 00                	push   $0x0
80101634:	50                   	push   %eax
80101635:	e8 36 33 00 00       	call   80104970 <memset>
  log_write(bp);
8010163a:	89 1c 24             	mov    %ebx,(%esp)
8010163d:	e8 0e 1c 00 00       	call   80103250 <log_write>
  brelse(bp);
80101642:	89 1c 24             	mov    %ebx,(%esp)
80101645:	e8 a6 eb ff ff       	call   801001f0 <brelse>
}
8010164a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010164d:	89 f0                	mov    %esi,%eax
8010164f:	5b                   	pop    %ebx
80101650:	5e                   	pop    %esi
80101651:	5f                   	pop    %edi
80101652:	5d                   	pop    %ebp
80101653:	c3                   	ret    
80101654:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010165b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010165f:	90                   	nop

80101660 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
80101660:	55                   	push   %ebp
80101661:	89 e5                	mov    %esp,%ebp
80101663:	57                   	push   %edi
80101664:	89 c7                	mov    %eax,%edi
80101666:	56                   	push   %esi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
80101667:	31 f6                	xor    %esi,%esi
{
80101669:	53                   	push   %ebx
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010166a:	bb 94 f9 10 80       	mov    $0x8010f994,%ebx
{
8010166f:	83 ec 28             	sub    $0x28,%esp
80101672:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  acquire(&icache.lock);
80101675:	68 60 f9 10 80       	push   $0x8010f960
8010167a:	e8 31 32 00 00       	call   801048b0 <acquire>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010167f:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  acquire(&icache.lock);
80101682:	83 c4 10             	add    $0x10,%esp
80101685:	eb 1b                	jmp    801016a2 <iget+0x42>
80101687:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010168e:	66 90                	xchg   %ax,%ax
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101690:	39 3b                	cmp    %edi,(%ebx)
80101692:	74 6c                	je     80101700 <iget+0xa0>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101694:	81 c3 90 00 00 00    	add    $0x90,%ebx
8010169a:	81 fb b4 15 11 80    	cmp    $0x801115b4,%ebx
801016a0:	73 26                	jae    801016c8 <iget+0x68>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801016a2:	8b 43 08             	mov    0x8(%ebx),%eax
801016a5:	85 c0                	test   %eax,%eax
801016a7:	7f e7                	jg     80101690 <iget+0x30>
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
801016a9:	85 f6                	test   %esi,%esi
801016ab:	75 e7                	jne    80101694 <iget+0x34>
801016ad:	85 c0                	test   %eax,%eax
801016af:	75 76                	jne    80101727 <iget+0xc7>
801016b1:	89 de                	mov    %ebx,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801016b3:	81 c3 90 00 00 00    	add    $0x90,%ebx
801016b9:	81 fb b4 15 11 80    	cmp    $0x801115b4,%ebx
801016bf:	72 e1                	jb     801016a2 <iget+0x42>
801016c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
801016c8:	85 f6                	test   %esi,%esi
801016ca:	74 79                	je     80101745 <iget+0xe5>
  ip = empty;
  ip->dev = dev;
  ip->inum = inum;
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);
801016cc:	83 ec 0c             	sub    $0xc,%esp
  ip->dev = dev;
801016cf:	89 3e                	mov    %edi,(%esi)
  ip->inum = inum;
801016d1:	89 56 04             	mov    %edx,0x4(%esi)
  ip->ref = 1;
801016d4:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->valid = 0;
801016db:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
  release(&icache.lock);
801016e2:	68 60 f9 10 80       	push   $0x8010f960
801016e7:	e8 64 31 00 00       	call   80104850 <release>

  return ip;
801016ec:	83 c4 10             	add    $0x10,%esp
}
801016ef:	8d 65 f4             	lea    -0xc(%ebp),%esp
801016f2:	89 f0                	mov    %esi,%eax
801016f4:	5b                   	pop    %ebx
801016f5:	5e                   	pop    %esi
801016f6:	5f                   	pop    %edi
801016f7:	5d                   	pop    %ebp
801016f8:	c3                   	ret    
801016f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101700:	39 53 04             	cmp    %edx,0x4(%ebx)
80101703:	75 8f                	jne    80101694 <iget+0x34>
      release(&icache.lock);
80101705:	83 ec 0c             	sub    $0xc,%esp
      ip->ref++;
80101708:	83 c0 01             	add    $0x1,%eax
      return ip;
8010170b:	89 de                	mov    %ebx,%esi
      release(&icache.lock);
8010170d:	68 60 f9 10 80       	push   $0x8010f960
      ip->ref++;
80101712:	89 43 08             	mov    %eax,0x8(%ebx)
      release(&icache.lock);
80101715:	e8 36 31 00 00       	call   80104850 <release>
      return ip;
8010171a:	83 c4 10             	add    $0x10,%esp
}
8010171d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101720:	89 f0                	mov    %esi,%eax
80101722:	5b                   	pop    %ebx
80101723:	5e                   	pop    %esi
80101724:	5f                   	pop    %edi
80101725:	5d                   	pop    %ebp
80101726:	c3                   	ret    
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101727:	81 c3 90 00 00 00    	add    $0x90,%ebx
8010172d:	81 fb b4 15 11 80    	cmp    $0x801115b4,%ebx
80101733:	73 10                	jae    80101745 <iget+0xe5>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101735:	8b 43 08             	mov    0x8(%ebx),%eax
80101738:	85 c0                	test   %eax,%eax
8010173a:	0f 8f 50 ff ff ff    	jg     80101690 <iget+0x30>
80101740:	e9 68 ff ff ff       	jmp    801016ad <iget+0x4d>
    panic("iget: no inodes");
80101745:	83 ec 0c             	sub    $0xc,%esp
80101748:	68 e0 75 10 80       	push   $0x801075e0
8010174d:	e8 2e ec ff ff       	call   80100380 <panic>
80101752:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101759:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101760 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
80101760:	55                   	push   %ebp
80101761:	89 e5                	mov    %esp,%ebp
80101763:	57                   	push   %edi
80101764:	56                   	push   %esi
80101765:	89 c6                	mov    %eax,%esi
80101767:	53                   	push   %ebx
80101768:	83 ec 1c             	sub    $0x1c,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
8010176b:	83 fa 0b             	cmp    $0xb,%edx
8010176e:	0f 86 8c 00 00 00    	jbe    80101800 <bmap+0xa0>
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
    return addr;
  }
  bn -= NDIRECT;
80101774:	8d 5a f4             	lea    -0xc(%edx),%ebx

  if(bn < NINDIRECT){
80101777:	83 fb 7f             	cmp    $0x7f,%ebx
8010177a:	0f 87 a2 00 00 00    	ja     80101822 <bmap+0xc2>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
80101780:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
80101786:	85 c0                	test   %eax,%eax
80101788:	74 5e                	je     801017e8 <bmap+0x88>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
8010178a:	83 ec 08             	sub    $0x8,%esp
8010178d:	50                   	push   %eax
8010178e:	ff 36                	push   (%esi)
80101790:	e8 3b e9 ff ff       	call   801000d0 <bread>
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
80101795:	83 c4 10             	add    $0x10,%esp
80101798:	8d 5c 98 5c          	lea    0x5c(%eax,%ebx,4),%ebx
    bp = bread(ip->dev, addr);
8010179c:	89 c2                	mov    %eax,%edx
    if((addr = a[bn]) == 0){
8010179e:	8b 3b                	mov    (%ebx),%edi
801017a0:	85 ff                	test   %edi,%edi
801017a2:	74 1c                	je     801017c0 <bmap+0x60>
      a[bn] = addr = balloc(ip->dev);
      log_write(bp);
    }
    brelse(bp);
801017a4:	83 ec 0c             	sub    $0xc,%esp
801017a7:	52                   	push   %edx
801017a8:	e8 43 ea ff ff       	call   801001f0 <brelse>
801017ad:	83 c4 10             	add    $0x10,%esp
    return addr;
  }

  panic("bmap: out of range");
}
801017b0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801017b3:	89 f8                	mov    %edi,%eax
801017b5:	5b                   	pop    %ebx
801017b6:	5e                   	pop    %esi
801017b7:	5f                   	pop    %edi
801017b8:	5d                   	pop    %ebp
801017b9:	c3                   	ret    
801017ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801017c0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      a[bn] = addr = balloc(ip->dev);
801017c3:	8b 06                	mov    (%esi),%eax
801017c5:	e8 86 fd ff ff       	call   80101550 <balloc>
      log_write(bp);
801017ca:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801017cd:	83 ec 0c             	sub    $0xc,%esp
      a[bn] = addr = balloc(ip->dev);
801017d0:	89 03                	mov    %eax,(%ebx)
801017d2:	89 c7                	mov    %eax,%edi
      log_write(bp);
801017d4:	52                   	push   %edx
801017d5:	e8 76 1a 00 00       	call   80103250 <log_write>
801017da:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801017dd:	83 c4 10             	add    $0x10,%esp
801017e0:	eb c2                	jmp    801017a4 <bmap+0x44>
801017e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
801017e8:	8b 06                	mov    (%esi),%eax
801017ea:	e8 61 fd ff ff       	call   80101550 <balloc>
801017ef:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
801017f5:	eb 93                	jmp    8010178a <bmap+0x2a>
801017f7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801017fe:	66 90                	xchg   %ax,%ax
    if((addr = ip->addrs[bn]) == 0)
80101800:	8d 5a 14             	lea    0x14(%edx),%ebx
80101803:	8b 7c 98 0c          	mov    0xc(%eax,%ebx,4),%edi
80101807:	85 ff                	test   %edi,%edi
80101809:	75 a5                	jne    801017b0 <bmap+0x50>
      ip->addrs[bn] = addr = balloc(ip->dev);
8010180b:	8b 00                	mov    (%eax),%eax
8010180d:	e8 3e fd ff ff       	call   80101550 <balloc>
80101812:	89 44 9e 0c          	mov    %eax,0xc(%esi,%ebx,4)
80101816:	89 c7                	mov    %eax,%edi
}
80101818:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010181b:	5b                   	pop    %ebx
8010181c:	89 f8                	mov    %edi,%eax
8010181e:	5e                   	pop    %esi
8010181f:	5f                   	pop    %edi
80101820:	5d                   	pop    %ebp
80101821:	c3                   	ret    
  panic("bmap: out of range");
80101822:	83 ec 0c             	sub    $0xc,%esp
80101825:	68 f0 75 10 80       	push   $0x801075f0
8010182a:	e8 51 eb ff ff       	call   80100380 <panic>
8010182f:	90                   	nop

80101830 <readsb>:
{
80101830:	55                   	push   %ebp
80101831:	89 e5                	mov    %esp,%ebp
80101833:	56                   	push   %esi
80101834:	53                   	push   %ebx
80101835:	8b 75 0c             	mov    0xc(%ebp),%esi
  bp = bread(dev, 1);
80101838:	83 ec 08             	sub    $0x8,%esp
8010183b:	6a 01                	push   $0x1
8010183d:	ff 75 08             	push   0x8(%ebp)
80101840:	e8 8b e8 ff ff       	call   801000d0 <bread>
  memmove(sb, bp->data, sizeof(*sb));
80101845:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, 1);
80101848:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
8010184a:	8d 40 5c             	lea    0x5c(%eax),%eax
8010184d:	6a 1c                	push   $0x1c
8010184f:	50                   	push   %eax
80101850:	56                   	push   %esi
80101851:	e8 ba 31 00 00       	call   80104a10 <memmove>
  brelse(bp);
80101856:	89 5d 08             	mov    %ebx,0x8(%ebp)
80101859:	83 c4 10             	add    $0x10,%esp
}
8010185c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010185f:	5b                   	pop    %ebx
80101860:	5e                   	pop    %esi
80101861:	5d                   	pop    %ebp
  brelse(bp);
80101862:	e9 89 e9 ff ff       	jmp    801001f0 <brelse>
80101867:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010186e:	66 90                	xchg   %ax,%ax

80101870 <iinit>:
{
80101870:	55                   	push   %ebp
80101871:	89 e5                	mov    %esp,%ebp
80101873:	53                   	push   %ebx
80101874:	bb a0 f9 10 80       	mov    $0x8010f9a0,%ebx
80101879:	83 ec 0c             	sub    $0xc,%esp
  initlock(&icache.lock, "icache");
8010187c:	68 03 76 10 80       	push   $0x80107603
80101881:	68 60 f9 10 80       	push   $0x8010f960
80101886:	e8 55 2e 00 00       	call   801046e0 <initlock>
  for(i = 0; i < NINODE; i++) {
8010188b:	83 c4 10             	add    $0x10,%esp
8010188e:	66 90                	xchg   %ax,%ax
    initsleeplock(&icache.inode[i].lock, "inode");
80101890:	83 ec 08             	sub    $0x8,%esp
80101893:	68 0a 76 10 80       	push   $0x8010760a
80101898:	53                   	push   %ebx
  for(i = 0; i < NINODE; i++) {
80101899:	81 c3 90 00 00 00    	add    $0x90,%ebx
    initsleeplock(&icache.inode[i].lock, "inode");
8010189f:	e8 0c 2d 00 00       	call   801045b0 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
801018a4:	83 c4 10             	add    $0x10,%esp
801018a7:	81 fb c0 15 11 80    	cmp    $0x801115c0,%ebx
801018ad:	75 e1                	jne    80101890 <iinit+0x20>
  bp = bread(dev, 1);
801018af:	83 ec 08             	sub    $0x8,%esp
801018b2:	6a 01                	push   $0x1
801018b4:	ff 75 08             	push   0x8(%ebp)
801018b7:	e8 14 e8 ff ff       	call   801000d0 <bread>
  memmove(sb, bp->data, sizeof(*sb));
801018bc:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, 1);
801018bf:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
801018c1:	8d 40 5c             	lea    0x5c(%eax),%eax
801018c4:	6a 1c                	push   $0x1c
801018c6:	50                   	push   %eax
801018c7:	68 b4 15 11 80       	push   $0x801115b4
801018cc:	e8 3f 31 00 00       	call   80104a10 <memmove>
  brelse(bp);
801018d1:	89 1c 24             	mov    %ebx,(%esp)
801018d4:	e8 17 e9 ff ff       	call   801001f0 <brelse>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
801018d9:	ff 35 cc 15 11 80    	push   0x801115cc
801018df:	ff 35 c8 15 11 80    	push   0x801115c8
801018e5:	ff 35 c4 15 11 80    	push   0x801115c4
801018eb:	ff 35 c0 15 11 80    	push   0x801115c0
801018f1:	ff 35 bc 15 11 80    	push   0x801115bc
801018f7:	ff 35 b8 15 11 80    	push   0x801115b8
801018fd:	ff 35 b4 15 11 80    	push   0x801115b4
80101903:	68 70 76 10 80       	push   $0x80107670
80101908:	e8 23 ee ff ff       	call   80100730 <cprintf>
}
8010190d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101910:	83 c4 30             	add    $0x30,%esp
80101913:	c9                   	leave  
80101914:	c3                   	ret    
80101915:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010191c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101920 <ialloc>:
{
80101920:	55                   	push   %ebp
80101921:	89 e5                	mov    %esp,%ebp
80101923:	57                   	push   %edi
80101924:	56                   	push   %esi
80101925:	53                   	push   %ebx
80101926:	83 ec 1c             	sub    $0x1c,%esp
80101929:	8b 45 0c             	mov    0xc(%ebp),%eax
  for(inum = 1; inum < sb.ninodes; inum++){
8010192c:	83 3d bc 15 11 80 01 	cmpl   $0x1,0x801115bc
{
80101933:	8b 75 08             	mov    0x8(%ebp),%esi
80101936:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(inum = 1; inum < sb.ninodes; inum++){
80101939:	0f 86 91 00 00 00    	jbe    801019d0 <ialloc+0xb0>
8010193f:	bf 01 00 00 00       	mov    $0x1,%edi
80101944:	eb 21                	jmp    80101967 <ialloc+0x47>
80101946:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010194d:	8d 76 00             	lea    0x0(%esi),%esi
    brelse(bp);
80101950:	83 ec 0c             	sub    $0xc,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
80101953:	83 c7 01             	add    $0x1,%edi
    brelse(bp);
80101956:	53                   	push   %ebx
80101957:	e8 94 e8 ff ff       	call   801001f0 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
8010195c:	83 c4 10             	add    $0x10,%esp
8010195f:	3b 3d bc 15 11 80    	cmp    0x801115bc,%edi
80101965:	73 69                	jae    801019d0 <ialloc+0xb0>
    bp = bread(dev, IBLOCK(inum, sb));
80101967:	89 f8                	mov    %edi,%eax
80101969:	83 ec 08             	sub    $0x8,%esp
8010196c:	c1 e8 03             	shr    $0x3,%eax
8010196f:	03 05 c8 15 11 80    	add    0x801115c8,%eax
80101975:	50                   	push   %eax
80101976:	56                   	push   %esi
80101977:	e8 54 e7 ff ff       	call   801000d0 <bread>
    if(dip->type == 0){  // a free inode
8010197c:	83 c4 10             	add    $0x10,%esp
    bp = bread(dev, IBLOCK(inum, sb));
8010197f:	89 c3                	mov    %eax,%ebx
    dip = (struct dinode*)bp->data + inum%IPB;
80101981:	89 f8                	mov    %edi,%eax
80101983:	83 e0 07             	and    $0x7,%eax
80101986:	c1 e0 06             	shl    $0x6,%eax
80101989:	8d 4c 03 5c          	lea    0x5c(%ebx,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
8010198d:	66 83 39 00          	cmpw   $0x0,(%ecx)
80101991:	75 bd                	jne    80101950 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
80101993:	83 ec 04             	sub    $0x4,%esp
80101996:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80101999:	6a 40                	push   $0x40
8010199b:	6a 00                	push   $0x0
8010199d:	51                   	push   %ecx
8010199e:	e8 cd 2f 00 00       	call   80104970 <memset>
      dip->type = type;
801019a3:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
801019a7:	8b 4d e0             	mov    -0x20(%ebp),%ecx
801019aa:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
801019ad:	89 1c 24             	mov    %ebx,(%esp)
801019b0:	e8 9b 18 00 00       	call   80103250 <log_write>
      brelse(bp);
801019b5:	89 1c 24             	mov    %ebx,(%esp)
801019b8:	e8 33 e8 ff ff       	call   801001f0 <brelse>
      return iget(dev, inum);
801019bd:	83 c4 10             	add    $0x10,%esp
}
801019c0:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return iget(dev, inum);
801019c3:	89 fa                	mov    %edi,%edx
}
801019c5:	5b                   	pop    %ebx
      return iget(dev, inum);
801019c6:	89 f0                	mov    %esi,%eax
}
801019c8:	5e                   	pop    %esi
801019c9:	5f                   	pop    %edi
801019ca:	5d                   	pop    %ebp
      return iget(dev, inum);
801019cb:	e9 90 fc ff ff       	jmp    80101660 <iget>
  panic("ialloc: no inodes");
801019d0:	83 ec 0c             	sub    $0xc,%esp
801019d3:	68 10 76 10 80       	push   $0x80107610
801019d8:	e8 a3 e9 ff ff       	call   80100380 <panic>
801019dd:	8d 76 00             	lea    0x0(%esi),%esi

801019e0 <iupdate>:
{
801019e0:	55                   	push   %ebp
801019e1:	89 e5                	mov    %esp,%ebp
801019e3:	56                   	push   %esi
801019e4:	53                   	push   %ebx
801019e5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801019e8:	8b 43 04             	mov    0x4(%ebx),%eax
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801019eb:	83 c3 5c             	add    $0x5c,%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801019ee:	83 ec 08             	sub    $0x8,%esp
801019f1:	c1 e8 03             	shr    $0x3,%eax
801019f4:	03 05 c8 15 11 80    	add    0x801115c8,%eax
801019fa:	50                   	push   %eax
801019fb:	ff 73 a4             	push   -0x5c(%ebx)
801019fe:	e8 cd e6 ff ff       	call   801000d0 <bread>
  dip->type = ip->type;
80101a03:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101a07:	83 c4 0c             	add    $0xc,%esp
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101a0a:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
80101a0c:	8b 43 a8             	mov    -0x58(%ebx),%eax
80101a0f:	83 e0 07             	and    $0x7,%eax
80101a12:	c1 e0 06             	shl    $0x6,%eax
80101a15:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
  dip->type = ip->type;
80101a19:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
80101a1c:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101a20:	83 c0 0c             	add    $0xc,%eax
  dip->major = ip->major;
80101a23:	66 89 50 f6          	mov    %dx,-0xa(%eax)
  dip->minor = ip->minor;
80101a27:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
80101a2b:	66 89 50 f8          	mov    %dx,-0x8(%eax)
  dip->nlink = ip->nlink;
80101a2f:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
80101a33:	66 89 50 fa          	mov    %dx,-0x6(%eax)
  dip->size = ip->size;
80101a37:	8b 53 fc             	mov    -0x4(%ebx),%edx
80101a3a:	89 50 fc             	mov    %edx,-0x4(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101a3d:	6a 34                	push   $0x34
80101a3f:	53                   	push   %ebx
80101a40:	50                   	push   %eax
80101a41:	e8 ca 2f 00 00       	call   80104a10 <memmove>
  log_write(bp);
80101a46:	89 34 24             	mov    %esi,(%esp)
80101a49:	e8 02 18 00 00       	call   80103250 <log_write>
  brelse(bp);
80101a4e:	89 75 08             	mov    %esi,0x8(%ebp)
80101a51:	83 c4 10             	add    $0x10,%esp
}
80101a54:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101a57:	5b                   	pop    %ebx
80101a58:	5e                   	pop    %esi
80101a59:	5d                   	pop    %ebp
  brelse(bp);
80101a5a:	e9 91 e7 ff ff       	jmp    801001f0 <brelse>
80101a5f:	90                   	nop

80101a60 <idup>:
{
80101a60:	55                   	push   %ebp
80101a61:	89 e5                	mov    %esp,%ebp
80101a63:	53                   	push   %ebx
80101a64:	83 ec 10             	sub    $0x10,%esp
80101a67:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
80101a6a:	68 60 f9 10 80       	push   $0x8010f960
80101a6f:	e8 3c 2e 00 00       	call   801048b0 <acquire>
  ip->ref++;
80101a74:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
80101a78:	c7 04 24 60 f9 10 80 	movl   $0x8010f960,(%esp)
80101a7f:	e8 cc 2d 00 00       	call   80104850 <release>
}
80101a84:	89 d8                	mov    %ebx,%eax
80101a86:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101a89:	c9                   	leave  
80101a8a:	c3                   	ret    
80101a8b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101a8f:	90                   	nop

80101a90 <ilock>:
{
80101a90:	55                   	push   %ebp
80101a91:	89 e5                	mov    %esp,%ebp
80101a93:	56                   	push   %esi
80101a94:	53                   	push   %ebx
80101a95:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || ip->ref < 1)
80101a98:	85 db                	test   %ebx,%ebx
80101a9a:	0f 84 b7 00 00 00    	je     80101b57 <ilock+0xc7>
80101aa0:	8b 53 08             	mov    0x8(%ebx),%edx
80101aa3:	85 d2                	test   %edx,%edx
80101aa5:	0f 8e ac 00 00 00    	jle    80101b57 <ilock+0xc7>
  acquiresleep(&ip->lock);
80101aab:	83 ec 0c             	sub    $0xc,%esp
80101aae:	8d 43 0c             	lea    0xc(%ebx),%eax
80101ab1:	50                   	push   %eax
80101ab2:	e8 39 2b 00 00       	call   801045f0 <acquiresleep>
  if(ip->valid == 0){
80101ab7:	8b 43 4c             	mov    0x4c(%ebx),%eax
80101aba:	83 c4 10             	add    $0x10,%esp
80101abd:	85 c0                	test   %eax,%eax
80101abf:	74 0f                	je     80101ad0 <ilock+0x40>
}
80101ac1:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101ac4:	5b                   	pop    %ebx
80101ac5:	5e                   	pop    %esi
80101ac6:	5d                   	pop    %ebp
80101ac7:	c3                   	ret    
80101ac8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101acf:	90                   	nop
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101ad0:	8b 43 04             	mov    0x4(%ebx),%eax
80101ad3:	83 ec 08             	sub    $0x8,%esp
80101ad6:	c1 e8 03             	shr    $0x3,%eax
80101ad9:	03 05 c8 15 11 80    	add    0x801115c8,%eax
80101adf:	50                   	push   %eax
80101ae0:	ff 33                	push   (%ebx)
80101ae2:	e8 e9 e5 ff ff       	call   801000d0 <bread>
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101ae7:	83 c4 0c             	add    $0xc,%esp
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101aea:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
80101aec:	8b 43 04             	mov    0x4(%ebx),%eax
80101aef:	83 e0 07             	and    $0x7,%eax
80101af2:	c1 e0 06             	shl    $0x6,%eax
80101af5:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    ip->type = dip->type;
80101af9:	0f b7 10             	movzwl (%eax),%edx
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101afc:	83 c0 0c             	add    $0xc,%eax
    ip->type = dip->type;
80101aff:	66 89 53 50          	mov    %dx,0x50(%ebx)
    ip->major = dip->major;
80101b03:	0f b7 50 f6          	movzwl -0xa(%eax),%edx
80101b07:	66 89 53 52          	mov    %dx,0x52(%ebx)
    ip->minor = dip->minor;
80101b0b:	0f b7 50 f8          	movzwl -0x8(%eax),%edx
80101b0f:	66 89 53 54          	mov    %dx,0x54(%ebx)
    ip->nlink = dip->nlink;
80101b13:	0f b7 50 fa          	movzwl -0x6(%eax),%edx
80101b17:	66 89 53 56          	mov    %dx,0x56(%ebx)
    ip->size = dip->size;
80101b1b:	8b 50 fc             	mov    -0x4(%eax),%edx
80101b1e:	89 53 58             	mov    %edx,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101b21:	6a 34                	push   $0x34
80101b23:	50                   	push   %eax
80101b24:	8d 43 5c             	lea    0x5c(%ebx),%eax
80101b27:	50                   	push   %eax
80101b28:	e8 e3 2e 00 00       	call   80104a10 <memmove>
    brelse(bp);
80101b2d:	89 34 24             	mov    %esi,(%esp)
80101b30:	e8 bb e6 ff ff       	call   801001f0 <brelse>
    if(ip->type == 0)
80101b35:	83 c4 10             	add    $0x10,%esp
80101b38:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
    ip->valid = 1;
80101b3d:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if(ip->type == 0)
80101b44:	0f 85 77 ff ff ff    	jne    80101ac1 <ilock+0x31>
      panic("ilock: no type");
80101b4a:	83 ec 0c             	sub    $0xc,%esp
80101b4d:	68 28 76 10 80       	push   $0x80107628
80101b52:	e8 29 e8 ff ff       	call   80100380 <panic>
    panic("ilock");
80101b57:	83 ec 0c             	sub    $0xc,%esp
80101b5a:	68 22 76 10 80       	push   $0x80107622
80101b5f:	e8 1c e8 ff ff       	call   80100380 <panic>
80101b64:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101b6b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101b6f:	90                   	nop

80101b70 <iunlock>:
{
80101b70:	55                   	push   %ebp
80101b71:	89 e5                	mov    %esp,%ebp
80101b73:	56                   	push   %esi
80101b74:	53                   	push   %ebx
80101b75:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101b78:	85 db                	test   %ebx,%ebx
80101b7a:	74 28                	je     80101ba4 <iunlock+0x34>
80101b7c:	83 ec 0c             	sub    $0xc,%esp
80101b7f:	8d 73 0c             	lea    0xc(%ebx),%esi
80101b82:	56                   	push   %esi
80101b83:	e8 08 2b 00 00       	call   80104690 <holdingsleep>
80101b88:	83 c4 10             	add    $0x10,%esp
80101b8b:	85 c0                	test   %eax,%eax
80101b8d:	74 15                	je     80101ba4 <iunlock+0x34>
80101b8f:	8b 43 08             	mov    0x8(%ebx),%eax
80101b92:	85 c0                	test   %eax,%eax
80101b94:	7e 0e                	jle    80101ba4 <iunlock+0x34>
  releasesleep(&ip->lock);
80101b96:	89 75 08             	mov    %esi,0x8(%ebp)
}
80101b99:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101b9c:	5b                   	pop    %ebx
80101b9d:	5e                   	pop    %esi
80101b9e:	5d                   	pop    %ebp
  releasesleep(&ip->lock);
80101b9f:	e9 ac 2a 00 00       	jmp    80104650 <releasesleep>
    panic("iunlock");
80101ba4:	83 ec 0c             	sub    $0xc,%esp
80101ba7:	68 37 76 10 80       	push   $0x80107637
80101bac:	e8 cf e7 ff ff       	call   80100380 <panic>
80101bb1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101bb8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101bbf:	90                   	nop

80101bc0 <iput>:
{
80101bc0:	55                   	push   %ebp
80101bc1:	89 e5                	mov    %esp,%ebp
80101bc3:	57                   	push   %edi
80101bc4:	56                   	push   %esi
80101bc5:	53                   	push   %ebx
80101bc6:	83 ec 28             	sub    $0x28,%esp
80101bc9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquiresleep(&ip->lock);
80101bcc:	8d 7b 0c             	lea    0xc(%ebx),%edi
80101bcf:	57                   	push   %edi
80101bd0:	e8 1b 2a 00 00       	call   801045f0 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
80101bd5:	8b 53 4c             	mov    0x4c(%ebx),%edx
80101bd8:	83 c4 10             	add    $0x10,%esp
80101bdb:	85 d2                	test   %edx,%edx
80101bdd:	74 07                	je     80101be6 <iput+0x26>
80101bdf:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80101be4:	74 32                	je     80101c18 <iput+0x58>
  releasesleep(&ip->lock);
80101be6:	83 ec 0c             	sub    $0xc,%esp
80101be9:	57                   	push   %edi
80101bea:	e8 61 2a 00 00       	call   80104650 <releasesleep>
  acquire(&icache.lock);
80101bef:	c7 04 24 60 f9 10 80 	movl   $0x8010f960,(%esp)
80101bf6:	e8 b5 2c 00 00       	call   801048b0 <acquire>
  ip->ref--;
80101bfb:	83 6b 08 01          	subl   $0x1,0x8(%ebx)
  release(&icache.lock);
80101bff:	83 c4 10             	add    $0x10,%esp
80101c02:	c7 45 08 60 f9 10 80 	movl   $0x8010f960,0x8(%ebp)
}
80101c09:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101c0c:	5b                   	pop    %ebx
80101c0d:	5e                   	pop    %esi
80101c0e:	5f                   	pop    %edi
80101c0f:	5d                   	pop    %ebp
  release(&icache.lock);
80101c10:	e9 3b 2c 00 00       	jmp    80104850 <release>
80101c15:	8d 76 00             	lea    0x0(%esi),%esi
    acquire(&icache.lock);
80101c18:	83 ec 0c             	sub    $0xc,%esp
80101c1b:	68 60 f9 10 80       	push   $0x8010f960
80101c20:	e8 8b 2c 00 00       	call   801048b0 <acquire>
    int r = ip->ref;
80101c25:	8b 73 08             	mov    0x8(%ebx),%esi
    release(&icache.lock);
80101c28:	c7 04 24 60 f9 10 80 	movl   $0x8010f960,(%esp)
80101c2f:	e8 1c 2c 00 00       	call   80104850 <release>
    if(r == 1){
80101c34:	83 c4 10             	add    $0x10,%esp
80101c37:	83 fe 01             	cmp    $0x1,%esi
80101c3a:	75 aa                	jne    80101be6 <iput+0x26>
80101c3c:	8d 8b 8c 00 00 00    	lea    0x8c(%ebx),%ecx
80101c42:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80101c45:	8d 73 5c             	lea    0x5c(%ebx),%esi
80101c48:	89 cf                	mov    %ecx,%edi
80101c4a:	eb 0b                	jmp    80101c57 <iput+0x97>
80101c4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101c50:	83 c6 04             	add    $0x4,%esi
80101c53:	39 fe                	cmp    %edi,%esi
80101c55:	74 19                	je     80101c70 <iput+0xb0>
    if(ip->addrs[i]){
80101c57:	8b 16                	mov    (%esi),%edx
80101c59:	85 d2                	test   %edx,%edx
80101c5b:	74 f3                	je     80101c50 <iput+0x90>
      bfree(ip->dev, ip->addrs[i]);
80101c5d:	8b 03                	mov    (%ebx),%eax
80101c5f:	e8 6c f8 ff ff       	call   801014d0 <bfree>
      ip->addrs[i] = 0;
80101c64:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80101c6a:	eb e4                	jmp    80101c50 <iput+0x90>
80101c6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  if(ip->addrs[NDIRECT]){
80101c70:	8b 83 8c 00 00 00    	mov    0x8c(%ebx),%eax
80101c76:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101c79:	85 c0                	test   %eax,%eax
80101c7b:	75 2d                	jne    80101caa <iput+0xea>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
  iupdate(ip);
80101c7d:	83 ec 0c             	sub    $0xc,%esp
  ip->size = 0;
80101c80:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  iupdate(ip);
80101c87:	53                   	push   %ebx
80101c88:	e8 53 fd ff ff       	call   801019e0 <iupdate>
      ip->type = 0;
80101c8d:	31 c0                	xor    %eax,%eax
80101c8f:	66 89 43 50          	mov    %ax,0x50(%ebx)
      iupdate(ip);
80101c93:	89 1c 24             	mov    %ebx,(%esp)
80101c96:	e8 45 fd ff ff       	call   801019e0 <iupdate>
      ip->valid = 0;
80101c9b:	c7 43 4c 00 00 00 00 	movl   $0x0,0x4c(%ebx)
80101ca2:	83 c4 10             	add    $0x10,%esp
80101ca5:	e9 3c ff ff ff       	jmp    80101be6 <iput+0x26>
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
80101caa:	83 ec 08             	sub    $0x8,%esp
80101cad:	50                   	push   %eax
80101cae:	ff 33                	push   (%ebx)
80101cb0:	e8 1b e4 ff ff       	call   801000d0 <bread>
80101cb5:	89 7d e0             	mov    %edi,-0x20(%ebp)
80101cb8:	83 c4 10             	add    $0x10,%esp
80101cbb:	8d 88 5c 02 00 00    	lea    0x25c(%eax),%ecx
80101cc1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(j = 0; j < NINDIRECT; j++){
80101cc4:	8d 70 5c             	lea    0x5c(%eax),%esi
80101cc7:	89 cf                	mov    %ecx,%edi
80101cc9:	eb 0c                	jmp    80101cd7 <iput+0x117>
80101ccb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101ccf:	90                   	nop
80101cd0:	83 c6 04             	add    $0x4,%esi
80101cd3:	39 f7                	cmp    %esi,%edi
80101cd5:	74 0f                	je     80101ce6 <iput+0x126>
      if(a[j])
80101cd7:	8b 16                	mov    (%esi),%edx
80101cd9:	85 d2                	test   %edx,%edx
80101cdb:	74 f3                	je     80101cd0 <iput+0x110>
        bfree(ip->dev, a[j]);
80101cdd:	8b 03                	mov    (%ebx),%eax
80101cdf:	e8 ec f7 ff ff       	call   801014d0 <bfree>
80101ce4:	eb ea                	jmp    80101cd0 <iput+0x110>
    brelse(bp);
80101ce6:	83 ec 0c             	sub    $0xc,%esp
80101ce9:	ff 75 e4             	push   -0x1c(%ebp)
80101cec:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101cef:	e8 fc e4 ff ff       	call   801001f0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
80101cf4:	8b 93 8c 00 00 00    	mov    0x8c(%ebx),%edx
80101cfa:	8b 03                	mov    (%ebx),%eax
80101cfc:	e8 cf f7 ff ff       	call   801014d0 <bfree>
    ip->addrs[NDIRECT] = 0;
80101d01:	83 c4 10             	add    $0x10,%esp
80101d04:	c7 83 8c 00 00 00 00 	movl   $0x0,0x8c(%ebx)
80101d0b:	00 00 00 
80101d0e:	e9 6a ff ff ff       	jmp    80101c7d <iput+0xbd>
80101d13:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101d1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101d20 <iunlockput>:
{
80101d20:	55                   	push   %ebp
80101d21:	89 e5                	mov    %esp,%ebp
80101d23:	56                   	push   %esi
80101d24:	53                   	push   %ebx
80101d25:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101d28:	85 db                	test   %ebx,%ebx
80101d2a:	74 34                	je     80101d60 <iunlockput+0x40>
80101d2c:	83 ec 0c             	sub    $0xc,%esp
80101d2f:	8d 73 0c             	lea    0xc(%ebx),%esi
80101d32:	56                   	push   %esi
80101d33:	e8 58 29 00 00       	call   80104690 <holdingsleep>
80101d38:	83 c4 10             	add    $0x10,%esp
80101d3b:	85 c0                	test   %eax,%eax
80101d3d:	74 21                	je     80101d60 <iunlockput+0x40>
80101d3f:	8b 43 08             	mov    0x8(%ebx),%eax
80101d42:	85 c0                	test   %eax,%eax
80101d44:	7e 1a                	jle    80101d60 <iunlockput+0x40>
  releasesleep(&ip->lock);
80101d46:	83 ec 0c             	sub    $0xc,%esp
80101d49:	56                   	push   %esi
80101d4a:	e8 01 29 00 00       	call   80104650 <releasesleep>
  iput(ip);
80101d4f:	89 5d 08             	mov    %ebx,0x8(%ebp)
80101d52:	83 c4 10             	add    $0x10,%esp
}
80101d55:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101d58:	5b                   	pop    %ebx
80101d59:	5e                   	pop    %esi
80101d5a:	5d                   	pop    %ebp
  iput(ip);
80101d5b:	e9 60 fe ff ff       	jmp    80101bc0 <iput>
    panic("iunlock");
80101d60:	83 ec 0c             	sub    $0xc,%esp
80101d63:	68 37 76 10 80       	push   $0x80107637
80101d68:	e8 13 e6 ff ff       	call   80100380 <panic>
80101d6d:	8d 76 00             	lea    0x0(%esi),%esi

80101d70 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
80101d70:	55                   	push   %ebp
80101d71:	89 e5                	mov    %esp,%ebp
80101d73:	8b 55 08             	mov    0x8(%ebp),%edx
80101d76:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
80101d79:	8b 0a                	mov    (%edx),%ecx
80101d7b:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
80101d7e:	8b 4a 04             	mov    0x4(%edx),%ecx
80101d81:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
80101d84:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
80101d88:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
80101d8b:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
80101d8f:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
80101d93:	8b 52 58             	mov    0x58(%edx),%edx
80101d96:	89 50 10             	mov    %edx,0x10(%eax)
}
80101d99:	5d                   	pop    %ebp
80101d9a:	c3                   	ret    
80101d9b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101d9f:	90                   	nop

80101da0 <readi>:
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101da0:	55                   	push   %ebp
80101da1:	89 e5                	mov    %esp,%ebp
80101da3:	57                   	push   %edi
80101da4:	56                   	push   %esi
80101da5:	53                   	push   %ebx
80101da6:	83 ec 1c             	sub    $0x1c,%esp
80101da9:	8b 7d 0c             	mov    0xc(%ebp),%edi
80101dac:	8b 45 08             	mov    0x8(%ebp),%eax
80101daf:	8b 75 10             	mov    0x10(%ebp),%esi
80101db2:	89 7d e0             	mov    %edi,-0x20(%ebp)
80101db5:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101db8:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80101dbd:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101dc0:	89 7d e4             	mov    %edi,-0x1c(%ebp)
  if(ip->type == T_DEV){
80101dc3:	0f 84 a7 00 00 00    	je     80101e70 <readi+0xd0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
80101dc9:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101dcc:	8b 40 58             	mov    0x58(%eax),%eax
80101dcf:	39 c6                	cmp    %eax,%esi
80101dd1:	0f 87 ba 00 00 00    	ja     80101e91 <readi+0xf1>
80101dd7:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101dda:	31 c9                	xor    %ecx,%ecx
80101ddc:	89 da                	mov    %ebx,%edx
80101dde:	01 f2                	add    %esi,%edx
80101de0:	0f 92 c1             	setb   %cl
80101de3:	89 cf                	mov    %ecx,%edi
80101de5:	0f 82 a6 00 00 00    	jb     80101e91 <readi+0xf1>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
80101deb:	89 c1                	mov    %eax,%ecx
80101ded:	29 f1                	sub    %esi,%ecx
80101def:	39 d0                	cmp    %edx,%eax
80101df1:	0f 43 cb             	cmovae %ebx,%ecx
80101df4:	89 4d e4             	mov    %ecx,-0x1c(%ebp)

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101df7:	85 c9                	test   %ecx,%ecx
80101df9:	74 67                	je     80101e62 <readi+0xc2>
80101dfb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101dff:	90                   	nop
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101e00:	8b 5d d8             	mov    -0x28(%ebp),%ebx
80101e03:	89 f2                	mov    %esi,%edx
80101e05:	c1 ea 09             	shr    $0x9,%edx
80101e08:	89 d8                	mov    %ebx,%eax
80101e0a:	e8 51 f9 ff ff       	call   80101760 <bmap>
80101e0f:	83 ec 08             	sub    $0x8,%esp
80101e12:	50                   	push   %eax
80101e13:	ff 33                	push   (%ebx)
80101e15:	e8 b6 e2 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101e1a:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101e1d:	b9 00 02 00 00       	mov    $0x200,%ecx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101e22:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101e24:	89 f0                	mov    %esi,%eax
80101e26:	25 ff 01 00 00       	and    $0x1ff,%eax
80101e2b:	29 fb                	sub    %edi,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101e2d:	89 55 dc             	mov    %edx,-0x24(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
80101e30:	29 c1                	sub    %eax,%ecx
    memmove(dst, bp->data + off%BSIZE, m);
80101e32:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80101e36:	39 d9                	cmp    %ebx,%ecx
80101e38:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101e3b:	83 c4 0c             	add    $0xc,%esp
80101e3e:	53                   	push   %ebx
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101e3f:	01 df                	add    %ebx,%edi
80101e41:	01 de                	add    %ebx,%esi
    memmove(dst, bp->data + off%BSIZE, m);
80101e43:	50                   	push   %eax
80101e44:	ff 75 e0             	push   -0x20(%ebp)
80101e47:	e8 c4 2b 00 00       	call   80104a10 <memmove>
    brelse(bp);
80101e4c:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101e4f:	89 14 24             	mov    %edx,(%esp)
80101e52:	e8 99 e3 ff ff       	call   801001f0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101e57:	01 5d e0             	add    %ebx,-0x20(%ebp)
80101e5a:	83 c4 10             	add    $0x10,%esp
80101e5d:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101e60:	77 9e                	ja     80101e00 <readi+0x60>
  }
  return n;
80101e62:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
80101e65:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101e68:	5b                   	pop    %ebx
80101e69:	5e                   	pop    %esi
80101e6a:	5f                   	pop    %edi
80101e6b:	5d                   	pop    %ebp
80101e6c:	c3                   	ret    
80101e6d:	8d 76 00             	lea    0x0(%esi),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101e70:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101e74:	66 83 f8 09          	cmp    $0x9,%ax
80101e78:	77 17                	ja     80101e91 <readi+0xf1>
80101e7a:	8b 04 c5 00 f9 10 80 	mov    -0x7fef0700(,%eax,8),%eax
80101e81:	85 c0                	test   %eax,%eax
80101e83:	74 0c                	je     80101e91 <readi+0xf1>
    return devsw[ip->major].read(ip, dst, n);
80101e85:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80101e88:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101e8b:	5b                   	pop    %ebx
80101e8c:	5e                   	pop    %esi
80101e8d:	5f                   	pop    %edi
80101e8e:	5d                   	pop    %ebp
    return devsw[ip->major].read(ip, dst, n);
80101e8f:	ff e0                	jmp    *%eax
      return -1;
80101e91:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101e96:	eb cd                	jmp    80101e65 <readi+0xc5>
80101e98:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101e9f:	90                   	nop

80101ea0 <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101ea0:	55                   	push   %ebp
80101ea1:	89 e5                	mov    %esp,%ebp
80101ea3:	57                   	push   %edi
80101ea4:	56                   	push   %esi
80101ea5:	53                   	push   %ebx
80101ea6:	83 ec 1c             	sub    $0x1c,%esp
80101ea9:	8b 45 08             	mov    0x8(%ebp),%eax
80101eac:	8b 75 0c             	mov    0xc(%ebp),%esi
80101eaf:	8b 55 14             	mov    0x14(%ebp),%edx
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101eb2:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80101eb7:	89 75 dc             	mov    %esi,-0x24(%ebp)
80101eba:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101ebd:	8b 75 10             	mov    0x10(%ebp),%esi
80101ec0:	89 55 e0             	mov    %edx,-0x20(%ebp)
  if(ip->type == T_DEV){
80101ec3:	0f 84 b7 00 00 00    	je     80101f80 <writei+0xe0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
80101ec9:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101ecc:	3b 70 58             	cmp    0x58(%eax),%esi
80101ecf:	0f 87 e7 00 00 00    	ja     80101fbc <writei+0x11c>
80101ed5:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101ed8:	31 d2                	xor    %edx,%edx
80101eda:	89 f8                	mov    %edi,%eax
80101edc:	01 f0                	add    %esi,%eax
80101ede:	0f 92 c2             	setb   %dl
    return -1;
  if(off + n > MAXFILE*BSIZE)
80101ee1:	3d 00 18 01 00       	cmp    $0x11800,%eax
80101ee6:	0f 87 d0 00 00 00    	ja     80101fbc <writei+0x11c>
80101eec:	85 d2                	test   %edx,%edx
80101eee:	0f 85 c8 00 00 00    	jne    80101fbc <writei+0x11c>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101ef4:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80101efb:	85 ff                	test   %edi,%edi
80101efd:	74 72                	je     80101f71 <writei+0xd1>
80101eff:	90                   	nop
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101f00:	8b 7d d8             	mov    -0x28(%ebp),%edi
80101f03:	89 f2                	mov    %esi,%edx
80101f05:	c1 ea 09             	shr    $0x9,%edx
80101f08:	89 f8                	mov    %edi,%eax
80101f0a:	e8 51 f8 ff ff       	call   80101760 <bmap>
80101f0f:	83 ec 08             	sub    $0x8,%esp
80101f12:	50                   	push   %eax
80101f13:	ff 37                	push   (%edi)
80101f15:	e8 b6 e1 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101f1a:	b9 00 02 00 00       	mov    $0x200,%ecx
80101f1f:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80101f22:	2b 5d e4             	sub    -0x1c(%ebp),%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101f25:	89 c7                	mov    %eax,%edi
    m = min(n - tot, BSIZE - off%BSIZE);
80101f27:	89 f0                	mov    %esi,%eax
80101f29:	25 ff 01 00 00       	and    $0x1ff,%eax
80101f2e:	29 c1                	sub    %eax,%ecx
    memmove(bp->data + off%BSIZE, src, m);
80101f30:	8d 44 07 5c          	lea    0x5c(%edi,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80101f34:	39 d9                	cmp    %ebx,%ecx
80101f36:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(bp->data + off%BSIZE, src, m);
80101f39:	83 c4 0c             	add    $0xc,%esp
80101f3c:	53                   	push   %ebx
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101f3d:	01 de                	add    %ebx,%esi
    memmove(bp->data + off%BSIZE, src, m);
80101f3f:	ff 75 dc             	push   -0x24(%ebp)
80101f42:	50                   	push   %eax
80101f43:	e8 c8 2a 00 00       	call   80104a10 <memmove>
    log_write(bp);
80101f48:	89 3c 24             	mov    %edi,(%esp)
80101f4b:	e8 00 13 00 00       	call   80103250 <log_write>
    brelse(bp);
80101f50:	89 3c 24             	mov    %edi,(%esp)
80101f53:	e8 98 e2 ff ff       	call   801001f0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101f58:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80101f5b:	83 c4 10             	add    $0x10,%esp
80101f5e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101f61:	01 5d dc             	add    %ebx,-0x24(%ebp)
80101f64:	39 45 e0             	cmp    %eax,-0x20(%ebp)
80101f67:	77 97                	ja     80101f00 <writei+0x60>
  }

  if(n > 0 && off > ip->size){
80101f69:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101f6c:	3b 70 58             	cmp    0x58(%eax),%esi
80101f6f:	77 37                	ja     80101fa8 <writei+0x108>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80101f71:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80101f74:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101f77:	5b                   	pop    %ebx
80101f78:	5e                   	pop    %esi
80101f79:	5f                   	pop    %edi
80101f7a:	5d                   	pop    %ebp
80101f7b:	c3                   	ret    
80101f7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101f80:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101f84:	66 83 f8 09          	cmp    $0x9,%ax
80101f88:	77 32                	ja     80101fbc <writei+0x11c>
80101f8a:	8b 04 c5 04 f9 10 80 	mov    -0x7fef06fc(,%eax,8),%eax
80101f91:	85 c0                	test   %eax,%eax
80101f93:	74 27                	je     80101fbc <writei+0x11c>
    return devsw[ip->major].write(ip, src, n);
80101f95:	89 55 10             	mov    %edx,0x10(%ebp)
}
80101f98:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101f9b:	5b                   	pop    %ebx
80101f9c:	5e                   	pop    %esi
80101f9d:	5f                   	pop    %edi
80101f9e:	5d                   	pop    %ebp
    return devsw[ip->major].write(ip, src, n);
80101f9f:	ff e0                	jmp    *%eax
80101fa1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    ip->size = off;
80101fa8:	8b 45 d8             	mov    -0x28(%ebp),%eax
    iupdate(ip);
80101fab:	83 ec 0c             	sub    $0xc,%esp
    ip->size = off;
80101fae:	89 70 58             	mov    %esi,0x58(%eax)
    iupdate(ip);
80101fb1:	50                   	push   %eax
80101fb2:	e8 29 fa ff ff       	call   801019e0 <iupdate>
80101fb7:	83 c4 10             	add    $0x10,%esp
80101fba:	eb b5                	jmp    80101f71 <writei+0xd1>
      return -1;
80101fbc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101fc1:	eb b1                	jmp    80101f74 <writei+0xd4>
80101fc3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101fca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101fd0 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80101fd0:	55                   	push   %ebp
80101fd1:	89 e5                	mov    %esp,%ebp
80101fd3:	83 ec 0c             	sub    $0xc,%esp
  return strncmp(s, t, DIRSIZ);
80101fd6:	6a 0e                	push   $0xe
80101fd8:	ff 75 0c             	push   0xc(%ebp)
80101fdb:	ff 75 08             	push   0x8(%ebp)
80101fde:	e8 9d 2a 00 00       	call   80104a80 <strncmp>
}
80101fe3:	c9                   	leave  
80101fe4:	c3                   	ret    
80101fe5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101fec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101ff0 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80101ff0:	55                   	push   %ebp
80101ff1:	89 e5                	mov    %esp,%ebp
80101ff3:	57                   	push   %edi
80101ff4:	56                   	push   %esi
80101ff5:	53                   	push   %ebx
80101ff6:	83 ec 1c             	sub    $0x1c,%esp
80101ff9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80101ffc:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80102001:	0f 85 85 00 00 00    	jne    8010208c <dirlookup+0x9c>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80102007:	8b 53 58             	mov    0x58(%ebx),%edx
8010200a:	31 ff                	xor    %edi,%edi
8010200c:	8d 75 d8             	lea    -0x28(%ebp),%esi
8010200f:	85 d2                	test   %edx,%edx
80102011:	74 3e                	je     80102051 <dirlookup+0x61>
80102013:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102017:	90                   	nop
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102018:	6a 10                	push   $0x10
8010201a:	57                   	push   %edi
8010201b:	56                   	push   %esi
8010201c:	53                   	push   %ebx
8010201d:	e8 7e fd ff ff       	call   80101da0 <readi>
80102022:	83 c4 10             	add    $0x10,%esp
80102025:	83 f8 10             	cmp    $0x10,%eax
80102028:	75 55                	jne    8010207f <dirlookup+0x8f>
      panic("dirlookup read");
    if(de.inum == 0)
8010202a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
8010202f:	74 18                	je     80102049 <dirlookup+0x59>
  return strncmp(s, t, DIRSIZ);
80102031:	83 ec 04             	sub    $0x4,%esp
80102034:	8d 45 da             	lea    -0x26(%ebp),%eax
80102037:	6a 0e                	push   $0xe
80102039:	50                   	push   %eax
8010203a:	ff 75 0c             	push   0xc(%ebp)
8010203d:	e8 3e 2a 00 00       	call   80104a80 <strncmp>
      continue;
    if(namecmp(name, de.name) == 0){
80102042:	83 c4 10             	add    $0x10,%esp
80102045:	85 c0                	test   %eax,%eax
80102047:	74 17                	je     80102060 <dirlookup+0x70>
  for(off = 0; off < dp->size; off += sizeof(de)){
80102049:	83 c7 10             	add    $0x10,%edi
8010204c:	3b 7b 58             	cmp    0x58(%ebx),%edi
8010204f:	72 c7                	jb     80102018 <dirlookup+0x28>
      return iget(dp->dev, inum);
    }
  }

  return 0;
}
80102051:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80102054:	31 c0                	xor    %eax,%eax
}
80102056:	5b                   	pop    %ebx
80102057:	5e                   	pop    %esi
80102058:	5f                   	pop    %edi
80102059:	5d                   	pop    %ebp
8010205a:	c3                   	ret    
8010205b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010205f:	90                   	nop
      if(poff)
80102060:	8b 45 10             	mov    0x10(%ebp),%eax
80102063:	85 c0                	test   %eax,%eax
80102065:	74 05                	je     8010206c <dirlookup+0x7c>
        *poff = off;
80102067:	8b 45 10             	mov    0x10(%ebp),%eax
8010206a:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
8010206c:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
      return iget(dp->dev, inum);
80102070:	8b 03                	mov    (%ebx),%eax
80102072:	e8 e9 f5 ff ff       	call   80101660 <iget>
}
80102077:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010207a:	5b                   	pop    %ebx
8010207b:	5e                   	pop    %esi
8010207c:	5f                   	pop    %edi
8010207d:	5d                   	pop    %ebp
8010207e:	c3                   	ret    
      panic("dirlookup read");
8010207f:	83 ec 0c             	sub    $0xc,%esp
80102082:	68 51 76 10 80       	push   $0x80107651
80102087:	e8 f4 e2 ff ff       	call   80100380 <panic>
    panic("dirlookup not DIR");
8010208c:	83 ec 0c             	sub    $0xc,%esp
8010208f:	68 3f 76 10 80       	push   $0x8010763f
80102094:	e8 e7 e2 ff ff       	call   80100380 <panic>
80102099:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801020a0 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
801020a0:	55                   	push   %ebp
801020a1:	89 e5                	mov    %esp,%ebp
801020a3:	57                   	push   %edi
801020a4:	56                   	push   %esi
801020a5:	53                   	push   %ebx
801020a6:	89 c3                	mov    %eax,%ebx
801020a8:	83 ec 1c             	sub    $0x1c,%esp
  struct inode *ip, *next;

  if(*path == '/')
801020ab:	80 38 2f             	cmpb   $0x2f,(%eax)
{
801020ae:	89 55 dc             	mov    %edx,-0x24(%ebp)
801020b1:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  if(*path == '/')
801020b4:	0f 84 64 01 00 00    	je     8010221e <namex+0x17e>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
801020ba:	e8 c1 1b 00 00       	call   80103c80 <myproc>
  acquire(&icache.lock);
801020bf:	83 ec 0c             	sub    $0xc,%esp
    ip = idup(myproc()->cwd);
801020c2:	8b 70 68             	mov    0x68(%eax),%esi
  acquire(&icache.lock);
801020c5:	68 60 f9 10 80       	push   $0x8010f960
801020ca:	e8 e1 27 00 00       	call   801048b0 <acquire>
  ip->ref++;
801020cf:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
801020d3:	c7 04 24 60 f9 10 80 	movl   $0x8010f960,(%esp)
801020da:	e8 71 27 00 00       	call   80104850 <release>
801020df:	83 c4 10             	add    $0x10,%esp
801020e2:	eb 07                	jmp    801020eb <namex+0x4b>
801020e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
801020e8:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
801020eb:	0f b6 03             	movzbl (%ebx),%eax
801020ee:	3c 2f                	cmp    $0x2f,%al
801020f0:	74 f6                	je     801020e8 <namex+0x48>
  if(*path == 0)
801020f2:	84 c0                	test   %al,%al
801020f4:	0f 84 06 01 00 00    	je     80102200 <namex+0x160>
  while(*path != '/' && *path != 0)
801020fa:	0f b6 03             	movzbl (%ebx),%eax
801020fd:	84 c0                	test   %al,%al
801020ff:	0f 84 10 01 00 00    	je     80102215 <namex+0x175>
80102105:	89 df                	mov    %ebx,%edi
80102107:	3c 2f                	cmp    $0x2f,%al
80102109:	0f 84 06 01 00 00    	je     80102215 <namex+0x175>
8010210f:	90                   	nop
80102110:	0f b6 47 01          	movzbl 0x1(%edi),%eax
    path++;
80102114:	83 c7 01             	add    $0x1,%edi
  while(*path != '/' && *path != 0)
80102117:	3c 2f                	cmp    $0x2f,%al
80102119:	74 04                	je     8010211f <namex+0x7f>
8010211b:	84 c0                	test   %al,%al
8010211d:	75 f1                	jne    80102110 <namex+0x70>
  len = path - s;
8010211f:	89 f8                	mov    %edi,%eax
80102121:	29 d8                	sub    %ebx,%eax
  if(len >= DIRSIZ)
80102123:	83 f8 0d             	cmp    $0xd,%eax
80102126:	0f 8e ac 00 00 00    	jle    801021d8 <namex+0x138>
    memmove(name, s, DIRSIZ);
8010212c:	83 ec 04             	sub    $0x4,%esp
8010212f:	6a 0e                	push   $0xe
80102131:	53                   	push   %ebx
    path++;
80102132:	89 fb                	mov    %edi,%ebx
    memmove(name, s, DIRSIZ);
80102134:	ff 75 e4             	push   -0x1c(%ebp)
80102137:	e8 d4 28 00 00       	call   80104a10 <memmove>
8010213c:	83 c4 10             	add    $0x10,%esp
  while(*path == '/')
8010213f:	80 3f 2f             	cmpb   $0x2f,(%edi)
80102142:	75 0c                	jne    80102150 <namex+0xb0>
80102144:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
80102148:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
8010214b:	80 3b 2f             	cmpb   $0x2f,(%ebx)
8010214e:	74 f8                	je     80102148 <namex+0xa8>

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
80102150:	83 ec 0c             	sub    $0xc,%esp
80102153:	56                   	push   %esi
80102154:	e8 37 f9 ff ff       	call   80101a90 <ilock>
    if(ip->type != T_DIR){
80102159:	83 c4 10             	add    $0x10,%esp
8010215c:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80102161:	0f 85 cd 00 00 00    	jne    80102234 <namex+0x194>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80102167:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010216a:	85 c0                	test   %eax,%eax
8010216c:	74 09                	je     80102177 <namex+0xd7>
8010216e:	80 3b 00             	cmpb   $0x0,(%ebx)
80102171:	0f 84 22 01 00 00    	je     80102299 <namex+0x1f9>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80102177:	83 ec 04             	sub    $0x4,%esp
8010217a:	6a 00                	push   $0x0
8010217c:	ff 75 e4             	push   -0x1c(%ebp)
8010217f:	56                   	push   %esi
80102180:	e8 6b fe ff ff       	call   80101ff0 <dirlookup>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80102185:	8d 56 0c             	lea    0xc(%esi),%edx
    if((next = dirlookup(ip, name, 0)) == 0){
80102188:	83 c4 10             	add    $0x10,%esp
8010218b:	89 c7                	mov    %eax,%edi
8010218d:	85 c0                	test   %eax,%eax
8010218f:	0f 84 e1 00 00 00    	je     80102276 <namex+0x1d6>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80102195:	83 ec 0c             	sub    $0xc,%esp
80102198:	89 55 e0             	mov    %edx,-0x20(%ebp)
8010219b:	52                   	push   %edx
8010219c:	e8 ef 24 00 00       	call   80104690 <holdingsleep>
801021a1:	83 c4 10             	add    $0x10,%esp
801021a4:	85 c0                	test   %eax,%eax
801021a6:	0f 84 30 01 00 00    	je     801022dc <namex+0x23c>
801021ac:	8b 56 08             	mov    0x8(%esi),%edx
801021af:	85 d2                	test   %edx,%edx
801021b1:	0f 8e 25 01 00 00    	jle    801022dc <namex+0x23c>
  releasesleep(&ip->lock);
801021b7:	8b 55 e0             	mov    -0x20(%ebp),%edx
801021ba:	83 ec 0c             	sub    $0xc,%esp
801021bd:	52                   	push   %edx
801021be:	e8 8d 24 00 00       	call   80104650 <releasesleep>
  iput(ip);
801021c3:	89 34 24             	mov    %esi,(%esp)
801021c6:	89 fe                	mov    %edi,%esi
801021c8:	e8 f3 f9 ff ff       	call   80101bc0 <iput>
801021cd:	83 c4 10             	add    $0x10,%esp
801021d0:	e9 16 ff ff ff       	jmp    801020eb <namex+0x4b>
801021d5:	8d 76 00             	lea    0x0(%esi),%esi
    name[len] = 0;
801021d8:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801021db:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    memmove(name, s, len);
801021de:	83 ec 04             	sub    $0x4,%esp
801021e1:	89 55 e0             	mov    %edx,-0x20(%ebp)
801021e4:	50                   	push   %eax
801021e5:	53                   	push   %ebx
    name[len] = 0;
801021e6:	89 fb                	mov    %edi,%ebx
    memmove(name, s, len);
801021e8:	ff 75 e4             	push   -0x1c(%ebp)
801021eb:	e8 20 28 00 00       	call   80104a10 <memmove>
    name[len] = 0;
801021f0:	8b 55 e0             	mov    -0x20(%ebp),%edx
801021f3:	83 c4 10             	add    $0x10,%esp
801021f6:	c6 02 00             	movb   $0x0,(%edx)
801021f9:	e9 41 ff ff ff       	jmp    8010213f <namex+0x9f>
801021fe:	66 90                	xchg   %ax,%ax
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
80102200:	8b 45 dc             	mov    -0x24(%ebp),%eax
80102203:	85 c0                	test   %eax,%eax
80102205:	0f 85 be 00 00 00    	jne    801022c9 <namex+0x229>
    iput(ip);
    return 0;
  }
  return ip;
}
8010220b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010220e:	89 f0                	mov    %esi,%eax
80102210:	5b                   	pop    %ebx
80102211:	5e                   	pop    %esi
80102212:	5f                   	pop    %edi
80102213:	5d                   	pop    %ebp
80102214:	c3                   	ret    
  while(*path != '/' && *path != 0)
80102215:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80102218:	89 df                	mov    %ebx,%edi
8010221a:	31 c0                	xor    %eax,%eax
8010221c:	eb c0                	jmp    801021de <namex+0x13e>
    ip = iget(ROOTDEV, ROOTINO);
8010221e:	ba 01 00 00 00       	mov    $0x1,%edx
80102223:	b8 01 00 00 00       	mov    $0x1,%eax
80102228:	e8 33 f4 ff ff       	call   80101660 <iget>
8010222d:	89 c6                	mov    %eax,%esi
8010222f:	e9 b7 fe ff ff       	jmp    801020eb <namex+0x4b>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80102234:	83 ec 0c             	sub    $0xc,%esp
80102237:	8d 5e 0c             	lea    0xc(%esi),%ebx
8010223a:	53                   	push   %ebx
8010223b:	e8 50 24 00 00       	call   80104690 <holdingsleep>
80102240:	83 c4 10             	add    $0x10,%esp
80102243:	85 c0                	test   %eax,%eax
80102245:	0f 84 91 00 00 00    	je     801022dc <namex+0x23c>
8010224b:	8b 46 08             	mov    0x8(%esi),%eax
8010224e:	85 c0                	test   %eax,%eax
80102250:	0f 8e 86 00 00 00    	jle    801022dc <namex+0x23c>
  releasesleep(&ip->lock);
80102256:	83 ec 0c             	sub    $0xc,%esp
80102259:	53                   	push   %ebx
8010225a:	e8 f1 23 00 00       	call   80104650 <releasesleep>
  iput(ip);
8010225f:	89 34 24             	mov    %esi,(%esp)
      return 0;
80102262:	31 f6                	xor    %esi,%esi
  iput(ip);
80102264:	e8 57 f9 ff ff       	call   80101bc0 <iput>
      return 0;
80102269:	83 c4 10             	add    $0x10,%esp
}
8010226c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010226f:	89 f0                	mov    %esi,%eax
80102271:	5b                   	pop    %ebx
80102272:	5e                   	pop    %esi
80102273:	5f                   	pop    %edi
80102274:	5d                   	pop    %ebp
80102275:	c3                   	ret    
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80102276:	83 ec 0c             	sub    $0xc,%esp
80102279:	89 55 e4             	mov    %edx,-0x1c(%ebp)
8010227c:	52                   	push   %edx
8010227d:	e8 0e 24 00 00       	call   80104690 <holdingsleep>
80102282:	83 c4 10             	add    $0x10,%esp
80102285:	85 c0                	test   %eax,%eax
80102287:	74 53                	je     801022dc <namex+0x23c>
80102289:	8b 4e 08             	mov    0x8(%esi),%ecx
8010228c:	85 c9                	test   %ecx,%ecx
8010228e:	7e 4c                	jle    801022dc <namex+0x23c>
  releasesleep(&ip->lock);
80102290:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80102293:	83 ec 0c             	sub    $0xc,%esp
80102296:	52                   	push   %edx
80102297:	eb c1                	jmp    8010225a <namex+0x1ba>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80102299:	83 ec 0c             	sub    $0xc,%esp
8010229c:	8d 5e 0c             	lea    0xc(%esi),%ebx
8010229f:	53                   	push   %ebx
801022a0:	e8 eb 23 00 00       	call   80104690 <holdingsleep>
801022a5:	83 c4 10             	add    $0x10,%esp
801022a8:	85 c0                	test   %eax,%eax
801022aa:	74 30                	je     801022dc <namex+0x23c>
801022ac:	8b 7e 08             	mov    0x8(%esi),%edi
801022af:	85 ff                	test   %edi,%edi
801022b1:	7e 29                	jle    801022dc <namex+0x23c>
  releasesleep(&ip->lock);
801022b3:	83 ec 0c             	sub    $0xc,%esp
801022b6:	53                   	push   %ebx
801022b7:	e8 94 23 00 00       	call   80104650 <releasesleep>
}
801022bc:	83 c4 10             	add    $0x10,%esp
}
801022bf:	8d 65 f4             	lea    -0xc(%ebp),%esp
801022c2:	89 f0                	mov    %esi,%eax
801022c4:	5b                   	pop    %ebx
801022c5:	5e                   	pop    %esi
801022c6:	5f                   	pop    %edi
801022c7:	5d                   	pop    %ebp
801022c8:	c3                   	ret    
    iput(ip);
801022c9:	83 ec 0c             	sub    $0xc,%esp
801022cc:	56                   	push   %esi
    return 0;
801022cd:	31 f6                	xor    %esi,%esi
    iput(ip);
801022cf:	e8 ec f8 ff ff       	call   80101bc0 <iput>
    return 0;
801022d4:	83 c4 10             	add    $0x10,%esp
801022d7:	e9 2f ff ff ff       	jmp    8010220b <namex+0x16b>
    panic("iunlock");
801022dc:	83 ec 0c             	sub    $0xc,%esp
801022df:	68 37 76 10 80       	push   $0x80107637
801022e4:	e8 97 e0 ff ff       	call   80100380 <panic>
801022e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801022f0 <dirlink>:
{
801022f0:	55                   	push   %ebp
801022f1:	89 e5                	mov    %esp,%ebp
801022f3:	57                   	push   %edi
801022f4:	56                   	push   %esi
801022f5:	53                   	push   %ebx
801022f6:	83 ec 20             	sub    $0x20,%esp
801022f9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((ip = dirlookup(dp, name, 0)) != 0){
801022fc:	6a 00                	push   $0x0
801022fe:	ff 75 0c             	push   0xc(%ebp)
80102301:	53                   	push   %ebx
80102302:	e8 e9 fc ff ff       	call   80101ff0 <dirlookup>
80102307:	83 c4 10             	add    $0x10,%esp
8010230a:	85 c0                	test   %eax,%eax
8010230c:	75 67                	jne    80102375 <dirlink+0x85>
  for(off = 0; off < dp->size; off += sizeof(de)){
8010230e:	8b 7b 58             	mov    0x58(%ebx),%edi
80102311:	8d 75 d8             	lea    -0x28(%ebp),%esi
80102314:	85 ff                	test   %edi,%edi
80102316:	74 29                	je     80102341 <dirlink+0x51>
80102318:	31 ff                	xor    %edi,%edi
8010231a:	8d 75 d8             	lea    -0x28(%ebp),%esi
8010231d:	eb 09                	jmp    80102328 <dirlink+0x38>
8010231f:	90                   	nop
80102320:	83 c7 10             	add    $0x10,%edi
80102323:	3b 7b 58             	cmp    0x58(%ebx),%edi
80102326:	73 19                	jae    80102341 <dirlink+0x51>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102328:	6a 10                	push   $0x10
8010232a:	57                   	push   %edi
8010232b:	56                   	push   %esi
8010232c:	53                   	push   %ebx
8010232d:	e8 6e fa ff ff       	call   80101da0 <readi>
80102332:	83 c4 10             	add    $0x10,%esp
80102335:	83 f8 10             	cmp    $0x10,%eax
80102338:	75 4e                	jne    80102388 <dirlink+0x98>
    if(de.inum == 0)
8010233a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
8010233f:	75 df                	jne    80102320 <dirlink+0x30>
  strncpy(de.name, name, DIRSIZ);
80102341:	83 ec 04             	sub    $0x4,%esp
80102344:	8d 45 da             	lea    -0x26(%ebp),%eax
80102347:	6a 0e                	push   $0xe
80102349:	ff 75 0c             	push   0xc(%ebp)
8010234c:	50                   	push   %eax
8010234d:	e8 7e 27 00 00       	call   80104ad0 <strncpy>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102352:	6a 10                	push   $0x10
  de.inum = inum;
80102354:	8b 45 10             	mov    0x10(%ebp),%eax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102357:	57                   	push   %edi
80102358:	56                   	push   %esi
80102359:	53                   	push   %ebx
  de.inum = inum;
8010235a:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
8010235e:	e8 3d fb ff ff       	call   80101ea0 <writei>
80102363:	83 c4 20             	add    $0x20,%esp
80102366:	83 f8 10             	cmp    $0x10,%eax
80102369:	75 2a                	jne    80102395 <dirlink+0xa5>
  return 0;
8010236b:	31 c0                	xor    %eax,%eax
}
8010236d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102370:	5b                   	pop    %ebx
80102371:	5e                   	pop    %esi
80102372:	5f                   	pop    %edi
80102373:	5d                   	pop    %ebp
80102374:	c3                   	ret    
    iput(ip);
80102375:	83 ec 0c             	sub    $0xc,%esp
80102378:	50                   	push   %eax
80102379:	e8 42 f8 ff ff       	call   80101bc0 <iput>
    return -1;
8010237e:	83 c4 10             	add    $0x10,%esp
80102381:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102386:	eb e5                	jmp    8010236d <dirlink+0x7d>
      panic("dirlink read");
80102388:	83 ec 0c             	sub    $0xc,%esp
8010238b:	68 60 76 10 80       	push   $0x80107660
80102390:	e8 eb df ff ff       	call   80100380 <panic>
    panic("dirlink");
80102395:	83 ec 0c             	sub    $0xc,%esp
80102398:	68 3e 7c 10 80       	push   $0x80107c3e
8010239d:	e8 de df ff ff       	call   80100380 <panic>
801023a2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801023a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801023b0 <namei>:

struct inode*
namei(char *path)
{
801023b0:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
801023b1:	31 d2                	xor    %edx,%edx
{
801023b3:	89 e5                	mov    %esp,%ebp
801023b5:	83 ec 18             	sub    $0x18,%esp
  return namex(path, 0, name);
801023b8:	8b 45 08             	mov    0x8(%ebp),%eax
801023bb:	8d 4d ea             	lea    -0x16(%ebp),%ecx
801023be:	e8 dd fc ff ff       	call   801020a0 <namex>
}
801023c3:	c9                   	leave  
801023c4:	c3                   	ret    
801023c5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801023cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801023d0 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
801023d0:	55                   	push   %ebp
  return namex(path, 1, name);
801023d1:	ba 01 00 00 00       	mov    $0x1,%edx
{
801023d6:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
801023d8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801023db:	8b 45 08             	mov    0x8(%ebp),%eax
}
801023de:	5d                   	pop    %ebp
  return namex(path, 1, name);
801023df:	e9 bc fc ff ff       	jmp    801020a0 <namex>
801023e4:	66 90                	xchg   %ax,%ax
801023e6:	66 90                	xchg   %ax,%ax
801023e8:	66 90                	xchg   %ax,%ax
801023ea:	66 90                	xchg   %ax,%ax
801023ec:	66 90                	xchg   %ax,%ax
801023ee:	66 90                	xchg   %ax,%ax

801023f0 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
801023f0:	55                   	push   %ebp
801023f1:	89 e5                	mov    %esp,%ebp
801023f3:	57                   	push   %edi
801023f4:	56                   	push   %esi
801023f5:	53                   	push   %ebx
801023f6:	83 ec 0c             	sub    $0xc,%esp
  if(b == 0)
801023f9:	85 c0                	test   %eax,%eax
801023fb:	0f 84 b4 00 00 00    	je     801024b5 <idestart+0xc5>
    panic("idestart");
  if(b->blockno >= FSSIZE)
80102401:	8b 70 08             	mov    0x8(%eax),%esi
80102404:	89 c3                	mov    %eax,%ebx
80102406:	81 fe e7 03 00 00    	cmp    $0x3e7,%esi
8010240c:	0f 87 96 00 00 00    	ja     801024a8 <idestart+0xb8>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102412:	b9 f7 01 00 00       	mov    $0x1f7,%ecx
80102417:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010241e:	66 90                	xchg   %ax,%ax
80102420:	89 ca                	mov    %ecx,%edx
80102422:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102423:	83 e0 c0             	and    $0xffffffc0,%eax
80102426:	3c 40                	cmp    $0x40,%al
80102428:	75 f6                	jne    80102420 <idestart+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010242a:	31 ff                	xor    %edi,%edi
8010242c:	ba f6 03 00 00       	mov    $0x3f6,%edx
80102431:	89 f8                	mov    %edi,%eax
80102433:	ee                   	out    %al,(%dx)
80102434:	b8 01 00 00 00       	mov    $0x1,%eax
80102439:	ba f2 01 00 00       	mov    $0x1f2,%edx
8010243e:	ee                   	out    %al,(%dx)
8010243f:	ba f3 01 00 00       	mov    $0x1f3,%edx
80102444:	89 f0                	mov    %esi,%eax
80102446:	ee                   	out    %al,(%dx)

  idewait(0);
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
80102447:	89 f0                	mov    %esi,%eax
80102449:	ba f4 01 00 00       	mov    $0x1f4,%edx
8010244e:	c1 f8 08             	sar    $0x8,%eax
80102451:	ee                   	out    %al,(%dx)
80102452:	ba f5 01 00 00       	mov    $0x1f5,%edx
80102457:	89 f8                	mov    %edi,%eax
80102459:	ee                   	out    %al,(%dx)
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
8010245a:	0f b6 43 04          	movzbl 0x4(%ebx),%eax
8010245e:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102463:	c1 e0 04             	shl    $0x4,%eax
80102466:	83 e0 10             	and    $0x10,%eax
80102469:	83 c8 e0             	or     $0xffffffe0,%eax
8010246c:	ee                   	out    %al,(%dx)
  if(b->flags & B_DIRTY){
8010246d:	f6 03 04             	testb  $0x4,(%ebx)
80102470:	75 16                	jne    80102488 <idestart+0x98>
80102472:	b8 20 00 00 00       	mov    $0x20,%eax
80102477:	89 ca                	mov    %ecx,%edx
80102479:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
8010247a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010247d:	5b                   	pop    %ebx
8010247e:	5e                   	pop    %esi
8010247f:	5f                   	pop    %edi
80102480:	5d                   	pop    %ebp
80102481:	c3                   	ret    
80102482:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102488:	b8 30 00 00 00       	mov    $0x30,%eax
8010248d:	89 ca                	mov    %ecx,%edx
8010248f:	ee                   	out    %al,(%dx)
  asm volatile("cld; rep outsl" :
80102490:	b9 80 00 00 00       	mov    $0x80,%ecx
    outsl(0x1f0, b->data, BSIZE/4);
80102495:	8d 73 5c             	lea    0x5c(%ebx),%esi
80102498:	ba f0 01 00 00       	mov    $0x1f0,%edx
8010249d:	fc                   	cld    
8010249e:	f3 6f                	rep outsl %ds:(%esi),(%dx)
}
801024a0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801024a3:	5b                   	pop    %ebx
801024a4:	5e                   	pop    %esi
801024a5:	5f                   	pop    %edi
801024a6:	5d                   	pop    %ebp
801024a7:	c3                   	ret    
    panic("incorrect blockno");
801024a8:	83 ec 0c             	sub    $0xc,%esp
801024ab:	68 cc 76 10 80       	push   $0x801076cc
801024b0:	e8 cb de ff ff       	call   80100380 <panic>
    panic("idestart");
801024b5:	83 ec 0c             	sub    $0xc,%esp
801024b8:	68 c3 76 10 80       	push   $0x801076c3
801024bd:	e8 be de ff ff       	call   80100380 <panic>
801024c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801024c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801024d0 <ideinit>:
{
801024d0:	55                   	push   %ebp
801024d1:	89 e5                	mov    %esp,%ebp
801024d3:	83 ec 10             	sub    $0x10,%esp
  initlock(&idelock, "ide");
801024d6:	68 de 76 10 80       	push   $0x801076de
801024db:	68 00 16 11 80       	push   $0x80111600
801024e0:	e8 fb 21 00 00       	call   801046e0 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
801024e5:	58                   	pop    %eax
801024e6:	a1 84 17 11 80       	mov    0x80111784,%eax
801024eb:	5a                   	pop    %edx
801024ec:	83 e8 01             	sub    $0x1,%eax
801024ef:	50                   	push   %eax
801024f0:	6a 0e                	push   $0xe
801024f2:	e8 99 02 00 00       	call   80102790 <ioapicenable>
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
801024f7:	83 c4 10             	add    $0x10,%esp
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801024fa:	ba f7 01 00 00       	mov    $0x1f7,%edx
801024ff:	90                   	nop
80102500:	ec                   	in     (%dx),%al
80102501:	83 e0 c0             	and    $0xffffffc0,%eax
80102504:	3c 40                	cmp    $0x40,%al
80102506:	75 f8                	jne    80102500 <ideinit+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102508:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
8010250d:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102512:	ee                   	out    %al,(%dx)
80102513:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102518:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010251d:	eb 06                	jmp    80102525 <ideinit+0x55>
8010251f:	90                   	nop
  for(i=0; i<1000; i++){
80102520:	83 e9 01             	sub    $0x1,%ecx
80102523:	74 0f                	je     80102534 <ideinit+0x64>
80102525:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
80102526:	84 c0                	test   %al,%al
80102528:	74 f6                	je     80102520 <ideinit+0x50>
      havedisk1 = 1;
8010252a:	c7 05 e0 15 11 80 01 	movl   $0x1,0x801115e0
80102531:	00 00 00 
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102534:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
80102539:	ba f6 01 00 00       	mov    $0x1f6,%edx
8010253e:	ee                   	out    %al,(%dx)
}
8010253f:	c9                   	leave  
80102540:	c3                   	ret    
80102541:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102548:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010254f:	90                   	nop

80102550 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
80102550:	55                   	push   %ebp
80102551:	89 e5                	mov    %esp,%ebp
80102553:	57                   	push   %edi
80102554:	56                   	push   %esi
80102555:	53                   	push   %ebx
80102556:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
80102559:	68 00 16 11 80       	push   $0x80111600
8010255e:	e8 4d 23 00 00       	call   801048b0 <acquire>

  if((b = idequeue) == 0){
80102563:	8b 1d e4 15 11 80    	mov    0x801115e4,%ebx
80102569:	83 c4 10             	add    $0x10,%esp
8010256c:	85 db                	test   %ebx,%ebx
8010256e:	74 63                	je     801025d3 <ideintr+0x83>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
80102570:	8b 43 58             	mov    0x58(%ebx),%eax
80102573:	a3 e4 15 11 80       	mov    %eax,0x801115e4

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
80102578:	8b 33                	mov    (%ebx),%esi
8010257a:	f7 c6 04 00 00 00    	test   $0x4,%esi
80102580:	75 2f                	jne    801025b1 <ideintr+0x61>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102582:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102587:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010258e:	66 90                	xchg   %ax,%ax
80102590:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102591:	89 c1                	mov    %eax,%ecx
80102593:	83 e1 c0             	and    $0xffffffc0,%ecx
80102596:	80 f9 40             	cmp    $0x40,%cl
80102599:	75 f5                	jne    80102590 <ideintr+0x40>
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
8010259b:	a8 21                	test   $0x21,%al
8010259d:	75 12                	jne    801025b1 <ideintr+0x61>
    insl(0x1f0, b->data, BSIZE/4);
8010259f:	8d 7b 5c             	lea    0x5c(%ebx),%edi
  asm volatile("cld; rep insl" :
801025a2:	b9 80 00 00 00       	mov    $0x80,%ecx
801025a7:	ba f0 01 00 00       	mov    $0x1f0,%edx
801025ac:	fc                   	cld    
801025ad:	f3 6d                	rep insl (%dx),%es:(%edi)

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
801025af:	8b 33                	mov    (%ebx),%esi
  b->flags &= ~B_DIRTY;
801025b1:	83 e6 fb             	and    $0xfffffffb,%esi
  wakeup(b);
801025b4:	83 ec 0c             	sub    $0xc,%esp
  b->flags &= ~B_DIRTY;
801025b7:	83 ce 02             	or     $0x2,%esi
801025ba:	89 33                	mov    %esi,(%ebx)
  wakeup(b);
801025bc:	53                   	push   %ebx
801025bd:	e8 4e 1e 00 00       	call   80104410 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
801025c2:	a1 e4 15 11 80       	mov    0x801115e4,%eax
801025c7:	83 c4 10             	add    $0x10,%esp
801025ca:	85 c0                	test   %eax,%eax
801025cc:	74 05                	je     801025d3 <ideintr+0x83>
    idestart(idequeue);
801025ce:	e8 1d fe ff ff       	call   801023f0 <idestart>
    release(&idelock);
801025d3:	83 ec 0c             	sub    $0xc,%esp
801025d6:	68 00 16 11 80       	push   $0x80111600
801025db:	e8 70 22 00 00       	call   80104850 <release>

  release(&idelock);
}
801025e0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801025e3:	5b                   	pop    %ebx
801025e4:	5e                   	pop    %esi
801025e5:	5f                   	pop    %edi
801025e6:	5d                   	pop    %ebp
801025e7:	c3                   	ret    
801025e8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801025ef:	90                   	nop

801025f0 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
801025f0:	55                   	push   %ebp
801025f1:	89 e5                	mov    %esp,%ebp
801025f3:	53                   	push   %ebx
801025f4:	83 ec 10             	sub    $0x10,%esp
801025f7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
801025fa:	8d 43 0c             	lea    0xc(%ebx),%eax
801025fd:	50                   	push   %eax
801025fe:	e8 8d 20 00 00       	call   80104690 <holdingsleep>
80102603:	83 c4 10             	add    $0x10,%esp
80102606:	85 c0                	test   %eax,%eax
80102608:	0f 84 c3 00 00 00    	je     801026d1 <iderw+0xe1>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
8010260e:	8b 03                	mov    (%ebx),%eax
80102610:	83 e0 06             	and    $0x6,%eax
80102613:	83 f8 02             	cmp    $0x2,%eax
80102616:	0f 84 a8 00 00 00    	je     801026c4 <iderw+0xd4>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
8010261c:	8b 53 04             	mov    0x4(%ebx),%edx
8010261f:	85 d2                	test   %edx,%edx
80102621:	74 0d                	je     80102630 <iderw+0x40>
80102623:	a1 e0 15 11 80       	mov    0x801115e0,%eax
80102628:	85 c0                	test   %eax,%eax
8010262a:	0f 84 87 00 00 00    	je     801026b7 <iderw+0xc7>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
80102630:	83 ec 0c             	sub    $0xc,%esp
80102633:	68 00 16 11 80       	push   $0x80111600
80102638:	e8 73 22 00 00       	call   801048b0 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010263d:	a1 e4 15 11 80       	mov    0x801115e4,%eax
  b->qnext = 0;
80102642:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102649:	83 c4 10             	add    $0x10,%esp
8010264c:	85 c0                	test   %eax,%eax
8010264e:	74 60                	je     801026b0 <iderw+0xc0>
80102650:	89 c2                	mov    %eax,%edx
80102652:	8b 40 58             	mov    0x58(%eax),%eax
80102655:	85 c0                	test   %eax,%eax
80102657:	75 f7                	jne    80102650 <iderw+0x60>
80102659:	83 c2 58             	add    $0x58,%edx
    ;
  *pp = b;
8010265c:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
8010265e:	39 1d e4 15 11 80    	cmp    %ebx,0x801115e4
80102664:	74 3a                	je     801026a0 <iderw+0xb0>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
80102666:	8b 03                	mov    (%ebx),%eax
80102668:	83 e0 06             	and    $0x6,%eax
8010266b:	83 f8 02             	cmp    $0x2,%eax
8010266e:	74 1b                	je     8010268b <iderw+0x9b>
    sleep(b, &idelock);
80102670:	83 ec 08             	sub    $0x8,%esp
80102673:	68 00 16 11 80       	push   $0x80111600
80102678:	53                   	push   %ebx
80102679:	e8 d2 1c 00 00       	call   80104350 <sleep>
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
8010267e:	8b 03                	mov    (%ebx),%eax
80102680:	83 c4 10             	add    $0x10,%esp
80102683:	83 e0 06             	and    $0x6,%eax
80102686:	83 f8 02             	cmp    $0x2,%eax
80102689:	75 e5                	jne    80102670 <iderw+0x80>
  }


  release(&idelock);
8010268b:	c7 45 08 00 16 11 80 	movl   $0x80111600,0x8(%ebp)
}
80102692:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102695:	c9                   	leave  
  release(&idelock);
80102696:	e9 b5 21 00 00       	jmp    80104850 <release>
8010269b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010269f:	90                   	nop
    idestart(b);
801026a0:	89 d8                	mov    %ebx,%eax
801026a2:	e8 49 fd ff ff       	call   801023f0 <idestart>
801026a7:	eb bd                	jmp    80102666 <iderw+0x76>
801026a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801026b0:	ba e4 15 11 80       	mov    $0x801115e4,%edx
801026b5:	eb a5                	jmp    8010265c <iderw+0x6c>
    panic("iderw: ide disk 1 not present");
801026b7:	83 ec 0c             	sub    $0xc,%esp
801026ba:	68 0d 77 10 80       	push   $0x8010770d
801026bf:	e8 bc dc ff ff       	call   80100380 <panic>
    panic("iderw: nothing to do");
801026c4:	83 ec 0c             	sub    $0xc,%esp
801026c7:	68 f8 76 10 80       	push   $0x801076f8
801026cc:	e8 af dc ff ff       	call   80100380 <panic>
    panic("iderw: buf not locked");
801026d1:	83 ec 0c             	sub    $0xc,%esp
801026d4:	68 e2 76 10 80       	push   $0x801076e2
801026d9:	e8 a2 dc ff ff       	call   80100380 <panic>
801026de:	66 90                	xchg   %ax,%ax

801026e0 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
801026e0:	55                   	push   %ebp
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
801026e1:	c7 05 34 16 11 80 00 	movl   $0xfec00000,0x80111634
801026e8:	00 c0 fe 
{
801026eb:	89 e5                	mov    %esp,%ebp
801026ed:	56                   	push   %esi
801026ee:	53                   	push   %ebx
  ioapic->reg = reg;
801026ef:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
801026f6:	00 00 00 
  return ioapic->data;
801026f9:	8b 15 34 16 11 80    	mov    0x80111634,%edx
801026ff:	8b 72 10             	mov    0x10(%edx),%esi
  ioapic->reg = reg;
80102702:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
  return ioapic->data;
80102708:	8b 0d 34 16 11 80    	mov    0x80111634,%ecx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
8010270e:	0f b6 15 80 17 11 80 	movzbl 0x80111780,%edx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
80102715:	c1 ee 10             	shr    $0x10,%esi
80102718:	89 f0                	mov    %esi,%eax
8010271a:	0f b6 f0             	movzbl %al,%esi
  return ioapic->data;
8010271d:	8b 41 10             	mov    0x10(%ecx),%eax
  id = ioapicread(REG_ID) >> 24;
80102720:	c1 e8 18             	shr    $0x18,%eax
  if(id != ioapicid)
80102723:	39 c2                	cmp    %eax,%edx
80102725:	74 16                	je     8010273d <ioapicinit+0x5d>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
80102727:	83 ec 0c             	sub    $0xc,%esp
8010272a:	68 2c 77 10 80       	push   $0x8010772c
8010272f:	e8 fc df ff ff       	call   80100730 <cprintf>
  ioapic->reg = reg;
80102734:	8b 0d 34 16 11 80    	mov    0x80111634,%ecx
8010273a:	83 c4 10             	add    $0x10,%esp
8010273d:	83 c6 21             	add    $0x21,%esi
{
80102740:	ba 10 00 00 00       	mov    $0x10,%edx
80102745:	b8 20 00 00 00       	mov    $0x20,%eax
8010274a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  ioapic->reg = reg;
80102750:	89 11                	mov    %edx,(%ecx)

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
80102752:	89 c3                	mov    %eax,%ebx
  ioapic->data = data;
80102754:	8b 0d 34 16 11 80    	mov    0x80111634,%ecx
  for(i = 0; i <= maxintr; i++){
8010275a:	83 c0 01             	add    $0x1,%eax
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
8010275d:	81 cb 00 00 01 00    	or     $0x10000,%ebx
  ioapic->data = data;
80102763:	89 59 10             	mov    %ebx,0x10(%ecx)
  ioapic->reg = reg;
80102766:	8d 5a 01             	lea    0x1(%edx),%ebx
  for(i = 0; i <= maxintr; i++){
80102769:	83 c2 02             	add    $0x2,%edx
  ioapic->reg = reg;
8010276c:	89 19                	mov    %ebx,(%ecx)
  ioapic->data = data;
8010276e:	8b 0d 34 16 11 80    	mov    0x80111634,%ecx
80102774:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
  for(i = 0; i <= maxintr; i++){
8010277b:	39 f0                	cmp    %esi,%eax
8010277d:	75 d1                	jne    80102750 <ioapicinit+0x70>
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
8010277f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102782:	5b                   	pop    %ebx
80102783:	5e                   	pop    %esi
80102784:	5d                   	pop    %ebp
80102785:	c3                   	ret    
80102786:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010278d:	8d 76 00             	lea    0x0(%esi),%esi

80102790 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
80102790:	55                   	push   %ebp
  ioapic->reg = reg;
80102791:	8b 0d 34 16 11 80    	mov    0x80111634,%ecx
{
80102797:	89 e5                	mov    %esp,%ebp
80102799:	8b 45 08             	mov    0x8(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
8010279c:	8d 50 20             	lea    0x20(%eax),%edx
8010279f:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
  ioapic->reg = reg;
801027a3:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
801027a5:	8b 0d 34 16 11 80    	mov    0x80111634,%ecx
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801027ab:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
801027ae:	89 51 10             	mov    %edx,0x10(%ecx)
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801027b1:	8b 55 0c             	mov    0xc(%ebp),%edx
  ioapic->reg = reg;
801027b4:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
801027b6:	a1 34 16 11 80       	mov    0x80111634,%eax
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801027bb:	c1 e2 18             	shl    $0x18,%edx
  ioapic->data = data;
801027be:	89 50 10             	mov    %edx,0x10(%eax)
}
801027c1:	5d                   	pop    %ebp
801027c2:	c3                   	ret    
801027c3:	66 90                	xchg   %ax,%ax
801027c5:	66 90                	xchg   %ax,%ax
801027c7:	66 90                	xchg   %ax,%ax
801027c9:	66 90                	xchg   %ax,%ax
801027cb:	66 90                	xchg   %ax,%ax
801027cd:	66 90                	xchg   %ax,%ax
801027cf:	90                   	nop

801027d0 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
801027d0:	55                   	push   %ebp
801027d1:	89 e5                	mov    %esp,%ebp
801027d3:	53                   	push   %ebx
801027d4:	83 ec 04             	sub    $0x4,%esp
801027d7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
801027da:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
801027e0:	75 76                	jne    80102858 <kfree+0x88>
801027e2:	81 fb d0 54 11 80    	cmp    $0x801154d0,%ebx
801027e8:	72 6e                	jb     80102858 <kfree+0x88>
801027ea:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801027f0:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
801027f5:	77 61                	ja     80102858 <kfree+0x88>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
801027f7:	83 ec 04             	sub    $0x4,%esp
801027fa:	68 00 10 00 00       	push   $0x1000
801027ff:	6a 01                	push   $0x1
80102801:	53                   	push   %ebx
80102802:	e8 69 21 00 00       	call   80104970 <memset>

  if(kmem.use_lock)
80102807:	8b 15 74 16 11 80    	mov    0x80111674,%edx
8010280d:	83 c4 10             	add    $0x10,%esp
80102810:	85 d2                	test   %edx,%edx
80102812:	75 1c                	jne    80102830 <kfree+0x60>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
80102814:	a1 78 16 11 80       	mov    0x80111678,%eax
80102819:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
8010281b:	a1 74 16 11 80       	mov    0x80111674,%eax
  kmem.freelist = r;
80102820:	89 1d 78 16 11 80    	mov    %ebx,0x80111678
  if(kmem.use_lock)
80102826:	85 c0                	test   %eax,%eax
80102828:	75 1e                	jne    80102848 <kfree+0x78>
    release(&kmem.lock);
}
8010282a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010282d:	c9                   	leave  
8010282e:	c3                   	ret    
8010282f:	90                   	nop
    acquire(&kmem.lock);
80102830:	83 ec 0c             	sub    $0xc,%esp
80102833:	68 40 16 11 80       	push   $0x80111640
80102838:	e8 73 20 00 00       	call   801048b0 <acquire>
8010283d:	83 c4 10             	add    $0x10,%esp
80102840:	eb d2                	jmp    80102814 <kfree+0x44>
80102842:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    release(&kmem.lock);
80102848:	c7 45 08 40 16 11 80 	movl   $0x80111640,0x8(%ebp)
}
8010284f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102852:	c9                   	leave  
    release(&kmem.lock);
80102853:	e9 f8 1f 00 00       	jmp    80104850 <release>
    panic("kfree");
80102858:	83 ec 0c             	sub    $0xc,%esp
8010285b:	68 5e 77 10 80       	push   $0x8010775e
80102860:	e8 1b db ff ff       	call   80100380 <panic>
80102865:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010286c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102870 <freerange>:
{
80102870:	55                   	push   %ebp
80102871:	89 e5                	mov    %esp,%ebp
80102873:	56                   	push   %esi
  p = (char*)PGROUNDUP((uint)vstart);
80102874:	8b 45 08             	mov    0x8(%ebp),%eax
{
80102877:	8b 75 0c             	mov    0xc(%ebp),%esi
8010287a:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
8010287b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102881:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102887:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010288d:	39 de                	cmp    %ebx,%esi
8010288f:	72 23                	jb     801028b4 <freerange+0x44>
80102891:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80102898:	83 ec 0c             	sub    $0xc,%esp
8010289b:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801028a1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801028a7:	50                   	push   %eax
801028a8:	e8 23 ff ff ff       	call   801027d0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801028ad:	83 c4 10             	add    $0x10,%esp
801028b0:	39 f3                	cmp    %esi,%ebx
801028b2:	76 e4                	jbe    80102898 <freerange+0x28>
}
801028b4:	8d 65 f8             	lea    -0x8(%ebp),%esp
801028b7:	5b                   	pop    %ebx
801028b8:	5e                   	pop    %esi
801028b9:	5d                   	pop    %ebp
801028ba:	c3                   	ret    
801028bb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801028bf:	90                   	nop

801028c0 <kinit2>:
{
801028c0:	55                   	push   %ebp
801028c1:	89 e5                	mov    %esp,%ebp
801028c3:	56                   	push   %esi
  p = (char*)PGROUNDUP((uint)vstart);
801028c4:	8b 45 08             	mov    0x8(%ebp),%eax
{
801028c7:	8b 75 0c             	mov    0xc(%ebp),%esi
801028ca:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
801028cb:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801028d1:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801028d7:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801028dd:	39 de                	cmp    %ebx,%esi
801028df:	72 23                	jb     80102904 <kinit2+0x44>
801028e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
801028e8:	83 ec 0c             	sub    $0xc,%esp
801028eb:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801028f1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801028f7:	50                   	push   %eax
801028f8:	e8 d3 fe ff ff       	call   801027d0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801028fd:	83 c4 10             	add    $0x10,%esp
80102900:	39 de                	cmp    %ebx,%esi
80102902:	73 e4                	jae    801028e8 <kinit2+0x28>
  kmem.use_lock = 1;
80102904:	c7 05 74 16 11 80 01 	movl   $0x1,0x80111674
8010290b:	00 00 00 
}
8010290e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102911:	5b                   	pop    %ebx
80102912:	5e                   	pop    %esi
80102913:	5d                   	pop    %ebp
80102914:	c3                   	ret    
80102915:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010291c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102920 <kinit1>:
{
80102920:	55                   	push   %ebp
80102921:	89 e5                	mov    %esp,%ebp
80102923:	56                   	push   %esi
80102924:	53                   	push   %ebx
80102925:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
80102928:	83 ec 08             	sub    $0x8,%esp
8010292b:	68 64 77 10 80       	push   $0x80107764
80102930:	68 40 16 11 80       	push   $0x80111640
80102935:	e8 a6 1d 00 00       	call   801046e0 <initlock>
  p = (char*)PGROUNDUP((uint)vstart);
8010293a:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010293d:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 0;
80102940:	c7 05 74 16 11 80 00 	movl   $0x0,0x80111674
80102947:	00 00 00 
  p = (char*)PGROUNDUP((uint)vstart);
8010294a:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102950:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102956:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010295c:	39 de                	cmp    %ebx,%esi
8010295e:	72 1c                	jb     8010297c <kinit1+0x5c>
    kfree(p);
80102960:	83 ec 0c             	sub    $0xc,%esp
80102963:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102969:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
8010296f:	50                   	push   %eax
80102970:	e8 5b fe ff ff       	call   801027d0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102975:	83 c4 10             	add    $0x10,%esp
80102978:	39 de                	cmp    %ebx,%esi
8010297a:	73 e4                	jae    80102960 <kinit1+0x40>
}
8010297c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010297f:	5b                   	pop    %ebx
80102980:	5e                   	pop    %esi
80102981:	5d                   	pop    %ebp
80102982:	c3                   	ret    
80102983:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010298a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102990 <kalloc>:
char*
kalloc(void)
{
  struct run *r;

  if(kmem.use_lock)
80102990:	a1 74 16 11 80       	mov    0x80111674,%eax
80102995:	85 c0                	test   %eax,%eax
80102997:	75 1f                	jne    801029b8 <kalloc+0x28>
    acquire(&kmem.lock);
  r = kmem.freelist;
80102999:	a1 78 16 11 80       	mov    0x80111678,%eax
  if(r)
8010299e:	85 c0                	test   %eax,%eax
801029a0:	74 0e                	je     801029b0 <kalloc+0x20>
    kmem.freelist = r->next;
801029a2:	8b 10                	mov    (%eax),%edx
801029a4:	89 15 78 16 11 80    	mov    %edx,0x80111678
  if(kmem.use_lock)
801029aa:	c3                   	ret    
801029ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801029af:	90                   	nop
    release(&kmem.lock);
  return (char*)r;
}
801029b0:	c3                   	ret    
801029b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
801029b8:	55                   	push   %ebp
801029b9:	89 e5                	mov    %esp,%ebp
801029bb:	83 ec 24             	sub    $0x24,%esp
    acquire(&kmem.lock);
801029be:	68 40 16 11 80       	push   $0x80111640
801029c3:	e8 e8 1e 00 00       	call   801048b0 <acquire>
  r = kmem.freelist;
801029c8:	a1 78 16 11 80       	mov    0x80111678,%eax
  if(kmem.use_lock)
801029cd:	8b 15 74 16 11 80    	mov    0x80111674,%edx
  if(r)
801029d3:	83 c4 10             	add    $0x10,%esp
801029d6:	85 c0                	test   %eax,%eax
801029d8:	74 08                	je     801029e2 <kalloc+0x52>
    kmem.freelist = r->next;
801029da:	8b 08                	mov    (%eax),%ecx
801029dc:	89 0d 78 16 11 80    	mov    %ecx,0x80111678
  if(kmem.use_lock)
801029e2:	85 d2                	test   %edx,%edx
801029e4:	74 16                	je     801029fc <kalloc+0x6c>
    release(&kmem.lock);
801029e6:	83 ec 0c             	sub    $0xc,%esp
801029e9:	89 45 f4             	mov    %eax,-0xc(%ebp)
801029ec:	68 40 16 11 80       	push   $0x80111640
801029f1:	e8 5a 1e 00 00       	call   80104850 <release>
  return (char*)r;
801029f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    release(&kmem.lock);
801029f9:	83 c4 10             	add    $0x10,%esp
}
801029fc:	c9                   	leave  
801029fd:	c3                   	ret    
801029fe:	66 90                	xchg   %ax,%ax

80102a00 <kbdgetc>:
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a00:	ba 64 00 00 00       	mov    $0x64,%edx
80102a05:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
80102a06:	a8 01                	test   $0x1,%al
80102a08:	0f 84 c2 00 00 00    	je     80102ad0 <kbdgetc+0xd0>
{
80102a0e:	55                   	push   %ebp
80102a0f:	ba 60 00 00 00       	mov    $0x60,%edx
80102a14:	89 e5                	mov    %esp,%ebp
80102a16:	53                   	push   %ebx
80102a17:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
80102a18:	8b 1d 7c 16 11 80    	mov    0x8011167c,%ebx
  data = inb(KBDATAP);
80102a1e:	0f b6 c8             	movzbl %al,%ecx
  if(data == 0xE0){
80102a21:	3c e0                	cmp    $0xe0,%al
80102a23:	74 5b                	je     80102a80 <kbdgetc+0x80>
    return 0;
  } else if(data & 0x80){
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
80102a25:	89 da                	mov    %ebx,%edx
80102a27:	83 e2 40             	and    $0x40,%edx
  } else if(data & 0x80){
80102a2a:	84 c0                	test   %al,%al
80102a2c:	78 62                	js     80102a90 <kbdgetc+0x90>
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
80102a2e:	85 d2                	test   %edx,%edx
80102a30:	74 09                	je     80102a3b <kbdgetc+0x3b>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
80102a32:	83 c8 80             	or     $0xffffff80,%eax
    shift &= ~E0ESC;
80102a35:	83 e3 bf             	and    $0xffffffbf,%ebx
    data |= 0x80;
80102a38:	0f b6 c8             	movzbl %al,%ecx
  }

  shift |= shiftcode[data];
80102a3b:	0f b6 91 a0 78 10 80 	movzbl -0x7fef8760(%ecx),%edx
  shift ^= togglecode[data];
80102a42:	0f b6 81 a0 77 10 80 	movzbl -0x7fef8860(%ecx),%eax
  shift |= shiftcode[data];
80102a49:	09 da                	or     %ebx,%edx
  shift ^= togglecode[data];
80102a4b:	31 c2                	xor    %eax,%edx
  c = charcode[shift & (CTL | SHIFT)][data];
80102a4d:	89 d0                	mov    %edx,%eax
  shift ^= togglecode[data];
80102a4f:	89 15 7c 16 11 80    	mov    %edx,0x8011167c
  c = charcode[shift & (CTL | SHIFT)][data];
80102a55:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
80102a58:	83 e2 08             	and    $0x8,%edx
  c = charcode[shift & (CTL | SHIFT)][data];
80102a5b:	8b 04 85 80 77 10 80 	mov    -0x7fef8880(,%eax,4),%eax
80102a62:	0f b6 04 08          	movzbl (%eax,%ecx,1),%eax
  if(shift & CAPSLOCK){
80102a66:	74 0b                	je     80102a73 <kbdgetc+0x73>
    if('a' <= c && c <= 'z')
80102a68:	8d 50 9f             	lea    -0x61(%eax),%edx
80102a6b:	83 fa 19             	cmp    $0x19,%edx
80102a6e:	77 48                	ja     80102ab8 <kbdgetc+0xb8>
      c += 'A' - 'a';
80102a70:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
80102a73:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102a76:	c9                   	leave  
80102a77:	c3                   	ret    
80102a78:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102a7f:	90                   	nop
    shift |= E0ESC;
80102a80:	83 cb 40             	or     $0x40,%ebx
    return 0;
80102a83:	31 c0                	xor    %eax,%eax
    shift |= E0ESC;
80102a85:	89 1d 7c 16 11 80    	mov    %ebx,0x8011167c
}
80102a8b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102a8e:	c9                   	leave  
80102a8f:	c3                   	ret    
    data = (shift & E0ESC ? data : data & 0x7F);
80102a90:	83 e0 7f             	and    $0x7f,%eax
80102a93:	85 d2                	test   %edx,%edx
80102a95:	0f 44 c8             	cmove  %eax,%ecx
    shift &= ~(shiftcode[data] | E0ESC);
80102a98:	0f b6 81 a0 78 10 80 	movzbl -0x7fef8760(%ecx),%eax
80102a9f:	83 c8 40             	or     $0x40,%eax
80102aa2:	0f b6 c0             	movzbl %al,%eax
80102aa5:	f7 d0                	not    %eax
80102aa7:	21 d8                	and    %ebx,%eax
}
80102aa9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    shift &= ~(shiftcode[data] | E0ESC);
80102aac:	a3 7c 16 11 80       	mov    %eax,0x8011167c
    return 0;
80102ab1:	31 c0                	xor    %eax,%eax
}
80102ab3:	c9                   	leave  
80102ab4:	c3                   	ret    
80102ab5:	8d 76 00             	lea    0x0(%esi),%esi
    else if('A' <= c && c <= 'Z')
80102ab8:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
80102abb:	8d 50 20             	lea    0x20(%eax),%edx
}
80102abe:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102ac1:	c9                   	leave  
      c += 'a' - 'A';
80102ac2:	83 f9 1a             	cmp    $0x1a,%ecx
80102ac5:	0f 42 c2             	cmovb  %edx,%eax
}
80102ac8:	c3                   	ret    
80102ac9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80102ad0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80102ad5:	c3                   	ret    
80102ad6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102add:	8d 76 00             	lea    0x0(%esi),%esi

80102ae0 <kbdintr>:

void
kbdintr(void)
{
80102ae0:	55                   	push   %ebp
80102ae1:	89 e5                	mov    %esp,%ebp
80102ae3:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
80102ae6:	68 00 2a 10 80       	push   $0x80102a00
80102aeb:	e8 b0 de ff ff       	call   801009a0 <consoleintr>
}
80102af0:	83 c4 10             	add    $0x10,%esp
80102af3:	c9                   	leave  
80102af4:	c3                   	ret    
80102af5:	66 90                	xchg   %ax,%ax
80102af7:	66 90                	xchg   %ax,%ax
80102af9:	66 90                	xchg   %ax,%ax
80102afb:	66 90                	xchg   %ax,%ax
80102afd:	66 90                	xchg   %ax,%ax
80102aff:	90                   	nop

80102b00 <lapicinit>:
}

void
lapicinit(void)
{
  if(!lapic)
80102b00:	a1 80 16 11 80       	mov    0x80111680,%eax
80102b05:	85 c0                	test   %eax,%eax
80102b07:	0f 84 cb 00 00 00    	je     80102bd8 <lapicinit+0xd8>
  lapic[index] = value;
80102b0d:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
80102b14:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102b17:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102b1a:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
80102b21:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102b24:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102b27:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
80102b2e:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
80102b31:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102b34:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
80102b3b:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
80102b3e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102b41:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
80102b48:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102b4b:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102b4e:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
80102b55:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102b58:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
80102b5b:	8b 50 30             	mov    0x30(%eax),%edx
80102b5e:	c1 ea 10             	shr    $0x10,%edx
80102b61:	81 e2 fc 00 00 00    	and    $0xfc,%edx
80102b67:	75 77                	jne    80102be0 <lapicinit+0xe0>
  lapic[index] = value;
80102b69:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
80102b70:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102b73:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102b76:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
80102b7d:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102b80:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102b83:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
80102b8a:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102b8d:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102b90:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102b97:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102b9a:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102b9d:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
80102ba4:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102ba7:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102baa:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
80102bb1:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
80102bb4:	8b 50 20             	mov    0x20(%eax),%edx
80102bb7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102bbe:	66 90                	xchg   %ax,%ax
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
80102bc0:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
80102bc6:	80 e6 10             	and    $0x10,%dh
80102bc9:	75 f5                	jne    80102bc0 <lapicinit+0xc0>
  lapic[index] = value;
80102bcb:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
80102bd2:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102bd5:	8b 40 20             	mov    0x20(%eax),%eax
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
80102bd8:	c3                   	ret    
80102bd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  lapic[index] = value;
80102be0:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
80102be7:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102bea:	8b 50 20             	mov    0x20(%eax),%edx
}
80102bed:	e9 77 ff ff ff       	jmp    80102b69 <lapicinit+0x69>
80102bf2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102bf9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102c00 <lapicid>:

int
lapicid(void)
{
  if (!lapic)
80102c00:	a1 80 16 11 80       	mov    0x80111680,%eax
80102c05:	85 c0                	test   %eax,%eax
80102c07:	74 07                	je     80102c10 <lapicid+0x10>
    return 0;
  return lapic[ID] >> 24;
80102c09:	8b 40 20             	mov    0x20(%eax),%eax
80102c0c:	c1 e8 18             	shr    $0x18,%eax
80102c0f:	c3                   	ret    
    return 0;
80102c10:	31 c0                	xor    %eax,%eax
}
80102c12:	c3                   	ret    
80102c13:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102c1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102c20 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
80102c20:	a1 80 16 11 80       	mov    0x80111680,%eax
80102c25:	85 c0                	test   %eax,%eax
80102c27:	74 0d                	je     80102c36 <lapiceoi+0x16>
  lapic[index] = value;
80102c29:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102c30:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102c33:	8b 40 20             	mov    0x20(%eax),%eax
    lapicw(EOI, 0);
}
80102c36:	c3                   	ret    
80102c37:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102c3e:	66 90                	xchg   %ax,%ax

80102c40 <microdelay>:
// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
}
80102c40:	c3                   	ret    
80102c41:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102c48:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102c4f:	90                   	nop

80102c50 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80102c50:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102c51:	b8 0f 00 00 00       	mov    $0xf,%eax
80102c56:	ba 70 00 00 00       	mov    $0x70,%edx
80102c5b:	89 e5                	mov    %esp,%ebp
80102c5d:	53                   	push   %ebx
80102c5e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102c61:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102c64:	ee                   	out    %al,(%dx)
80102c65:	b8 0a 00 00 00       	mov    $0xa,%eax
80102c6a:	ba 71 00 00 00       	mov    $0x71,%edx
80102c6f:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
80102c70:	31 c0                	xor    %eax,%eax
  wrv[1] = addr >> 4;

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
80102c72:	c1 e3 18             	shl    $0x18,%ebx
  wrv[0] = 0;
80102c75:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
80102c7b:	89 c8                	mov    %ecx,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
80102c7d:	c1 e9 0c             	shr    $0xc,%ecx
  lapicw(ICRHI, apicid<<24);
80102c80:	89 da                	mov    %ebx,%edx
  wrv[1] = addr >> 4;
80102c82:	c1 e8 04             	shr    $0x4,%eax
    lapicw(ICRLO, STARTUP | (addr>>12));
80102c85:	80 cd 06             	or     $0x6,%ch
  wrv[1] = addr >> 4;
80102c88:	66 a3 69 04 00 80    	mov    %ax,0x80000469
  lapic[index] = value;
80102c8e:	a1 80 16 11 80       	mov    0x80111680,%eax
80102c93:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102c99:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102c9c:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
80102ca3:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102ca6:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102ca9:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
80102cb0:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102cb3:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102cb6:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102cbc:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102cbf:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102cc5:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102cc8:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102cce:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102cd1:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102cd7:	8b 40 20             	mov    0x20(%eax),%eax
    microdelay(200);
  }
}
80102cda:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102cdd:	c9                   	leave  
80102cde:	c3                   	ret    
80102cdf:	90                   	nop

80102ce0 <cmostime>:
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void
cmostime(struct rtcdate *r)
{
80102ce0:	55                   	push   %ebp
80102ce1:	b8 0b 00 00 00       	mov    $0xb,%eax
80102ce6:	ba 70 00 00 00       	mov    $0x70,%edx
80102ceb:	89 e5                	mov    %esp,%ebp
80102ced:	57                   	push   %edi
80102cee:	56                   	push   %esi
80102cef:	53                   	push   %ebx
80102cf0:	83 ec 4c             	sub    $0x4c,%esp
80102cf3:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102cf4:	ba 71 00 00 00       	mov    $0x71,%edx
80102cf9:	ec                   	in     (%dx),%al
  struct rtcdate t1, t2;
  int sb, bcd;

  sb = cmos_read(CMOS_STATB);

  bcd = (sb & (1 << 2)) == 0;
80102cfa:	83 e0 04             	and    $0x4,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102cfd:	bb 70 00 00 00       	mov    $0x70,%ebx
80102d02:	88 45 b3             	mov    %al,-0x4d(%ebp)
80102d05:	8d 76 00             	lea    0x0(%esi),%esi
80102d08:	31 c0                	xor    %eax,%eax
80102d0a:	89 da                	mov    %ebx,%edx
80102d0c:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102d0d:	b9 71 00 00 00       	mov    $0x71,%ecx
80102d12:	89 ca                	mov    %ecx,%edx
80102d14:	ec                   	in     (%dx),%al
80102d15:	88 45 b7             	mov    %al,-0x49(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102d18:	89 da                	mov    %ebx,%edx
80102d1a:	b8 02 00 00 00       	mov    $0x2,%eax
80102d1f:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102d20:	89 ca                	mov    %ecx,%edx
80102d22:	ec                   	in     (%dx),%al
80102d23:	88 45 b6             	mov    %al,-0x4a(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102d26:	89 da                	mov    %ebx,%edx
80102d28:	b8 04 00 00 00       	mov    $0x4,%eax
80102d2d:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102d2e:	89 ca                	mov    %ecx,%edx
80102d30:	ec                   	in     (%dx),%al
80102d31:	88 45 b5             	mov    %al,-0x4b(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102d34:	89 da                	mov    %ebx,%edx
80102d36:	b8 07 00 00 00       	mov    $0x7,%eax
80102d3b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102d3c:	89 ca                	mov    %ecx,%edx
80102d3e:	ec                   	in     (%dx),%al
80102d3f:	88 45 b4             	mov    %al,-0x4c(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102d42:	89 da                	mov    %ebx,%edx
80102d44:	b8 08 00 00 00       	mov    $0x8,%eax
80102d49:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102d4a:	89 ca                	mov    %ecx,%edx
80102d4c:	ec                   	in     (%dx),%al
80102d4d:	89 c7                	mov    %eax,%edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102d4f:	89 da                	mov    %ebx,%edx
80102d51:	b8 09 00 00 00       	mov    $0x9,%eax
80102d56:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102d57:	89 ca                	mov    %ecx,%edx
80102d59:	ec                   	in     (%dx),%al
80102d5a:	89 c6                	mov    %eax,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102d5c:	89 da                	mov    %ebx,%edx
80102d5e:	b8 0a 00 00 00       	mov    $0xa,%eax
80102d63:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102d64:	89 ca                	mov    %ecx,%edx
80102d66:	ec                   	in     (%dx),%al

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
80102d67:	84 c0                	test   %al,%al
80102d69:	78 9d                	js     80102d08 <cmostime+0x28>
  return inb(CMOS_RETURN);
80102d6b:	0f b6 45 b7          	movzbl -0x49(%ebp),%eax
80102d6f:	89 fa                	mov    %edi,%edx
80102d71:	0f b6 fa             	movzbl %dl,%edi
80102d74:	89 f2                	mov    %esi,%edx
80102d76:	89 45 b8             	mov    %eax,-0x48(%ebp)
80102d79:	0f b6 45 b6          	movzbl -0x4a(%ebp),%eax
80102d7d:	0f b6 f2             	movzbl %dl,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102d80:	89 da                	mov    %ebx,%edx
80102d82:	89 7d c8             	mov    %edi,-0x38(%ebp)
80102d85:	89 45 bc             	mov    %eax,-0x44(%ebp)
80102d88:	0f b6 45 b5          	movzbl -0x4b(%ebp),%eax
80102d8c:	89 75 cc             	mov    %esi,-0x34(%ebp)
80102d8f:	89 45 c0             	mov    %eax,-0x40(%ebp)
80102d92:	0f b6 45 b4          	movzbl -0x4c(%ebp),%eax
80102d96:	89 45 c4             	mov    %eax,-0x3c(%ebp)
80102d99:	31 c0                	xor    %eax,%eax
80102d9b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102d9c:	89 ca                	mov    %ecx,%edx
80102d9e:	ec                   	in     (%dx),%al
80102d9f:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102da2:	89 da                	mov    %ebx,%edx
80102da4:	89 45 d0             	mov    %eax,-0x30(%ebp)
80102da7:	b8 02 00 00 00       	mov    $0x2,%eax
80102dac:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102dad:	89 ca                	mov    %ecx,%edx
80102daf:	ec                   	in     (%dx),%al
80102db0:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102db3:	89 da                	mov    %ebx,%edx
80102db5:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80102db8:	b8 04 00 00 00       	mov    $0x4,%eax
80102dbd:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102dbe:	89 ca                	mov    %ecx,%edx
80102dc0:	ec                   	in     (%dx),%al
80102dc1:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102dc4:	89 da                	mov    %ebx,%edx
80102dc6:	89 45 d8             	mov    %eax,-0x28(%ebp)
80102dc9:	b8 07 00 00 00       	mov    $0x7,%eax
80102dce:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102dcf:	89 ca                	mov    %ecx,%edx
80102dd1:	ec                   	in     (%dx),%al
80102dd2:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102dd5:	89 da                	mov    %ebx,%edx
80102dd7:	89 45 dc             	mov    %eax,-0x24(%ebp)
80102dda:	b8 08 00 00 00       	mov    $0x8,%eax
80102ddf:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102de0:	89 ca                	mov    %ecx,%edx
80102de2:	ec                   	in     (%dx),%al
80102de3:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102de6:	89 da                	mov    %ebx,%edx
80102de8:	89 45 e0             	mov    %eax,-0x20(%ebp)
80102deb:	b8 09 00 00 00       	mov    $0x9,%eax
80102df0:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102df1:	89 ca                	mov    %ecx,%edx
80102df3:	ec                   	in     (%dx),%al
80102df4:	0f b6 c0             	movzbl %al,%eax
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102df7:	83 ec 04             	sub    $0x4,%esp
  return inb(CMOS_RETURN);
80102dfa:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102dfd:	8d 45 d0             	lea    -0x30(%ebp),%eax
80102e00:	6a 18                	push   $0x18
80102e02:	50                   	push   %eax
80102e03:	8d 45 b8             	lea    -0x48(%ebp),%eax
80102e06:	50                   	push   %eax
80102e07:	e8 b4 1b 00 00       	call   801049c0 <memcmp>
80102e0c:	83 c4 10             	add    $0x10,%esp
80102e0f:	85 c0                	test   %eax,%eax
80102e11:	0f 85 f1 fe ff ff    	jne    80102d08 <cmostime+0x28>
      break;
  }

  // convert
  if(bcd) {
80102e17:	80 7d b3 00          	cmpb   $0x0,-0x4d(%ebp)
80102e1b:	75 78                	jne    80102e95 <cmostime+0x1b5>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
80102e1d:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102e20:	89 c2                	mov    %eax,%edx
80102e22:	83 e0 0f             	and    $0xf,%eax
80102e25:	c1 ea 04             	shr    $0x4,%edx
80102e28:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102e2b:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102e2e:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
80102e31:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102e34:	89 c2                	mov    %eax,%edx
80102e36:	83 e0 0f             	and    $0xf,%eax
80102e39:	c1 ea 04             	shr    $0x4,%edx
80102e3c:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102e3f:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102e42:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
80102e45:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102e48:	89 c2                	mov    %eax,%edx
80102e4a:	83 e0 0f             	and    $0xf,%eax
80102e4d:	c1 ea 04             	shr    $0x4,%edx
80102e50:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102e53:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102e56:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
80102e59:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102e5c:	89 c2                	mov    %eax,%edx
80102e5e:	83 e0 0f             	and    $0xf,%eax
80102e61:	c1 ea 04             	shr    $0x4,%edx
80102e64:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102e67:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102e6a:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
80102e6d:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102e70:	89 c2                	mov    %eax,%edx
80102e72:	83 e0 0f             	and    $0xf,%eax
80102e75:	c1 ea 04             	shr    $0x4,%edx
80102e78:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102e7b:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102e7e:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
80102e81:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102e84:	89 c2                	mov    %eax,%edx
80102e86:	83 e0 0f             	and    $0xf,%eax
80102e89:	c1 ea 04             	shr    $0x4,%edx
80102e8c:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102e8f:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102e92:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
80102e95:	8b 75 08             	mov    0x8(%ebp),%esi
80102e98:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102e9b:	89 06                	mov    %eax,(%esi)
80102e9d:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102ea0:	89 46 04             	mov    %eax,0x4(%esi)
80102ea3:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102ea6:	89 46 08             	mov    %eax,0x8(%esi)
80102ea9:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102eac:	89 46 0c             	mov    %eax,0xc(%esi)
80102eaf:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102eb2:	89 46 10             	mov    %eax,0x10(%esi)
80102eb5:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102eb8:	89 46 14             	mov    %eax,0x14(%esi)
  r->year += 2000;
80102ebb:	81 46 14 d0 07 00 00 	addl   $0x7d0,0x14(%esi)
}
80102ec2:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102ec5:	5b                   	pop    %ebx
80102ec6:	5e                   	pop    %esi
80102ec7:	5f                   	pop    %edi
80102ec8:	5d                   	pop    %ebp
80102ec9:	c3                   	ret    
80102eca:	66 90                	xchg   %ax,%ax
80102ecc:	66 90                	xchg   %ax,%ax
80102ece:	66 90                	xchg   %ax,%ax

80102ed0 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102ed0:	8b 0d e8 16 11 80    	mov    0x801116e8,%ecx
80102ed6:	85 c9                	test   %ecx,%ecx
80102ed8:	0f 8e 8a 00 00 00    	jle    80102f68 <install_trans+0x98>
{
80102ede:	55                   	push   %ebp
80102edf:	89 e5                	mov    %esp,%ebp
80102ee1:	57                   	push   %edi
  for (tail = 0; tail < log.lh.n; tail++) {
80102ee2:	31 ff                	xor    %edi,%edi
{
80102ee4:	56                   	push   %esi
80102ee5:	53                   	push   %ebx
80102ee6:	83 ec 0c             	sub    $0xc,%esp
80102ee9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80102ef0:	a1 d4 16 11 80       	mov    0x801116d4,%eax
80102ef5:	83 ec 08             	sub    $0x8,%esp
80102ef8:	01 f8                	add    %edi,%eax
80102efa:	83 c0 01             	add    $0x1,%eax
80102efd:	50                   	push   %eax
80102efe:	ff 35 e4 16 11 80    	push   0x801116e4
80102f04:	e8 c7 d1 ff ff       	call   801000d0 <bread>
80102f09:	89 c6                	mov    %eax,%esi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102f0b:	58                   	pop    %eax
80102f0c:	5a                   	pop    %edx
80102f0d:	ff 34 bd ec 16 11 80 	push   -0x7feee914(,%edi,4)
80102f14:	ff 35 e4 16 11 80    	push   0x801116e4
  for (tail = 0; tail < log.lh.n; tail++) {
80102f1a:	83 c7 01             	add    $0x1,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102f1d:	e8 ae d1 ff ff       	call   801000d0 <bread>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102f22:	83 c4 0c             	add    $0xc,%esp
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102f25:	89 c3                	mov    %eax,%ebx
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102f27:	8d 46 5c             	lea    0x5c(%esi),%eax
80102f2a:	68 00 02 00 00       	push   $0x200
80102f2f:	50                   	push   %eax
80102f30:	8d 43 5c             	lea    0x5c(%ebx),%eax
80102f33:	50                   	push   %eax
80102f34:	e8 d7 1a 00 00       	call   80104a10 <memmove>
    bwrite(dbuf);  // write dst to disk
80102f39:	89 1c 24             	mov    %ebx,(%esp)
80102f3c:	e8 6f d2 ff ff       	call   801001b0 <bwrite>
    brelse(lbuf);
80102f41:	89 34 24             	mov    %esi,(%esp)
80102f44:	e8 a7 d2 ff ff       	call   801001f0 <brelse>
    brelse(dbuf);
80102f49:	89 1c 24             	mov    %ebx,(%esp)
80102f4c:	e8 9f d2 ff ff       	call   801001f0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102f51:	83 c4 10             	add    $0x10,%esp
80102f54:	39 3d e8 16 11 80    	cmp    %edi,0x801116e8
80102f5a:	7f 94                	jg     80102ef0 <install_trans+0x20>
  }
}
80102f5c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102f5f:	5b                   	pop    %ebx
80102f60:	5e                   	pop    %esi
80102f61:	5f                   	pop    %edi
80102f62:	5d                   	pop    %ebp
80102f63:	c3                   	ret    
80102f64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102f68:	c3                   	ret    
80102f69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102f70 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80102f70:	55                   	push   %ebp
80102f71:	89 e5                	mov    %esp,%ebp
80102f73:	53                   	push   %ebx
80102f74:	83 ec 0c             	sub    $0xc,%esp
  struct buf *buf = bread(log.dev, log.start);
80102f77:	ff 35 d4 16 11 80    	push   0x801116d4
80102f7d:	ff 35 e4 16 11 80    	push   0x801116e4
80102f83:	e8 48 d1 ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
80102f88:	83 c4 10             	add    $0x10,%esp
  struct buf *buf = bread(log.dev, log.start);
80102f8b:	89 c3                	mov    %eax,%ebx
  hb->n = log.lh.n;
80102f8d:	a1 e8 16 11 80       	mov    0x801116e8,%eax
80102f92:	89 43 5c             	mov    %eax,0x5c(%ebx)
  for (i = 0; i < log.lh.n; i++) {
80102f95:	85 c0                	test   %eax,%eax
80102f97:	7e 19                	jle    80102fb2 <write_head+0x42>
80102f99:	31 d2                	xor    %edx,%edx
80102f9b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102f9f:	90                   	nop
    hb->block[i] = log.lh.block[i];
80102fa0:	8b 0c 95 ec 16 11 80 	mov    -0x7feee914(,%edx,4),%ecx
80102fa7:	89 4c 93 60          	mov    %ecx,0x60(%ebx,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
80102fab:	83 c2 01             	add    $0x1,%edx
80102fae:	39 d0                	cmp    %edx,%eax
80102fb0:	75 ee                	jne    80102fa0 <write_head+0x30>
  }
  bwrite(buf);
80102fb2:	83 ec 0c             	sub    $0xc,%esp
80102fb5:	53                   	push   %ebx
80102fb6:	e8 f5 d1 ff ff       	call   801001b0 <bwrite>
  brelse(buf);
80102fbb:	89 1c 24             	mov    %ebx,(%esp)
80102fbe:	e8 2d d2 ff ff       	call   801001f0 <brelse>
}
80102fc3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102fc6:	83 c4 10             	add    $0x10,%esp
80102fc9:	c9                   	leave  
80102fca:	c3                   	ret    
80102fcb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102fcf:	90                   	nop

80102fd0 <initlog>:
{
80102fd0:	55                   	push   %ebp
80102fd1:	89 e5                	mov    %esp,%ebp
80102fd3:	53                   	push   %ebx
80102fd4:	83 ec 2c             	sub    $0x2c,%esp
80102fd7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&log.lock, "log");
80102fda:	68 a0 79 10 80       	push   $0x801079a0
80102fdf:	68 a0 16 11 80       	push   $0x801116a0
80102fe4:	e8 f7 16 00 00       	call   801046e0 <initlock>
  readsb(dev, &sb);
80102fe9:	58                   	pop    %eax
80102fea:	8d 45 dc             	lea    -0x24(%ebp),%eax
80102fed:	5a                   	pop    %edx
80102fee:	50                   	push   %eax
80102fef:	53                   	push   %ebx
80102ff0:	e8 3b e8 ff ff       	call   80101830 <readsb>
  log.start = sb.logstart;
80102ff5:	8b 45 ec             	mov    -0x14(%ebp),%eax
  struct buf *buf = bread(log.dev, log.start);
80102ff8:	59                   	pop    %ecx
  log.dev = dev;
80102ff9:	89 1d e4 16 11 80    	mov    %ebx,0x801116e4
  log.size = sb.nlog;
80102fff:	8b 55 e8             	mov    -0x18(%ebp),%edx
  log.start = sb.logstart;
80103002:	a3 d4 16 11 80       	mov    %eax,0x801116d4
  log.size = sb.nlog;
80103007:	89 15 d8 16 11 80    	mov    %edx,0x801116d8
  struct buf *buf = bread(log.dev, log.start);
8010300d:	5a                   	pop    %edx
8010300e:	50                   	push   %eax
8010300f:	53                   	push   %ebx
80103010:	e8 bb d0 ff ff       	call   801000d0 <bread>
  for (i = 0; i < log.lh.n; i++) {
80103015:	83 c4 10             	add    $0x10,%esp
  log.lh.n = lh->n;
80103018:	8b 58 5c             	mov    0x5c(%eax),%ebx
8010301b:	89 1d e8 16 11 80    	mov    %ebx,0x801116e8
  for (i = 0; i < log.lh.n; i++) {
80103021:	85 db                	test   %ebx,%ebx
80103023:	7e 1d                	jle    80103042 <initlog+0x72>
80103025:	31 d2                	xor    %edx,%edx
80103027:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010302e:	66 90                	xchg   %ax,%ax
    log.lh.block[i] = lh->block[i];
80103030:	8b 4c 90 60          	mov    0x60(%eax,%edx,4),%ecx
80103034:	89 0c 95 ec 16 11 80 	mov    %ecx,-0x7feee914(,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
8010303b:	83 c2 01             	add    $0x1,%edx
8010303e:	39 d3                	cmp    %edx,%ebx
80103040:	75 ee                	jne    80103030 <initlog+0x60>
  brelse(buf);
80103042:	83 ec 0c             	sub    $0xc,%esp
80103045:	50                   	push   %eax
80103046:	e8 a5 d1 ff ff       	call   801001f0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
8010304b:	e8 80 fe ff ff       	call   80102ed0 <install_trans>
  log.lh.n = 0;
80103050:	c7 05 e8 16 11 80 00 	movl   $0x0,0x801116e8
80103057:	00 00 00 
  write_head(); // clear the log
8010305a:	e8 11 ff ff ff       	call   80102f70 <write_head>
}
8010305f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103062:	83 c4 10             	add    $0x10,%esp
80103065:	c9                   	leave  
80103066:	c3                   	ret    
80103067:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010306e:	66 90                	xchg   %ax,%ax

80103070 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80103070:	55                   	push   %ebp
80103071:	89 e5                	mov    %esp,%ebp
80103073:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
80103076:	68 a0 16 11 80       	push   $0x801116a0
8010307b:	e8 30 18 00 00       	call   801048b0 <acquire>
80103080:	83 c4 10             	add    $0x10,%esp
80103083:	eb 18                	jmp    8010309d <begin_op+0x2d>
80103085:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80103088:	83 ec 08             	sub    $0x8,%esp
8010308b:	68 a0 16 11 80       	push   $0x801116a0
80103090:	68 a0 16 11 80       	push   $0x801116a0
80103095:	e8 b6 12 00 00       	call   80104350 <sleep>
8010309a:	83 c4 10             	add    $0x10,%esp
    if(log.committing){
8010309d:	a1 e0 16 11 80       	mov    0x801116e0,%eax
801030a2:	85 c0                	test   %eax,%eax
801030a4:	75 e2                	jne    80103088 <begin_op+0x18>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
801030a6:	a1 dc 16 11 80       	mov    0x801116dc,%eax
801030ab:	8b 15 e8 16 11 80    	mov    0x801116e8,%edx
801030b1:	83 c0 01             	add    $0x1,%eax
801030b4:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
801030b7:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
801030ba:	83 fa 1e             	cmp    $0x1e,%edx
801030bd:	7f c9                	jg     80103088 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
801030bf:	83 ec 0c             	sub    $0xc,%esp
      log.outstanding += 1;
801030c2:	a3 dc 16 11 80       	mov    %eax,0x801116dc
      release(&log.lock);
801030c7:	68 a0 16 11 80       	push   $0x801116a0
801030cc:	e8 7f 17 00 00       	call   80104850 <release>
      break;
    }
  }
}
801030d1:	83 c4 10             	add    $0x10,%esp
801030d4:	c9                   	leave  
801030d5:	c3                   	ret    
801030d6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801030dd:	8d 76 00             	lea    0x0(%esi),%esi

801030e0 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
801030e0:	55                   	push   %ebp
801030e1:	89 e5                	mov    %esp,%ebp
801030e3:	57                   	push   %edi
801030e4:	56                   	push   %esi
801030e5:	53                   	push   %ebx
801030e6:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;

  acquire(&log.lock);
801030e9:	68 a0 16 11 80       	push   $0x801116a0
801030ee:	e8 bd 17 00 00       	call   801048b0 <acquire>
  log.outstanding -= 1;
801030f3:	a1 dc 16 11 80       	mov    0x801116dc,%eax
  if(log.committing)
801030f8:	8b 35 e0 16 11 80    	mov    0x801116e0,%esi
801030fe:	83 c4 10             	add    $0x10,%esp
  log.outstanding -= 1;
80103101:	8d 58 ff             	lea    -0x1(%eax),%ebx
80103104:	89 1d dc 16 11 80    	mov    %ebx,0x801116dc
  if(log.committing)
8010310a:	85 f6                	test   %esi,%esi
8010310c:	0f 85 22 01 00 00    	jne    80103234 <end_op+0x154>
    panic("log.committing");
  if(log.outstanding == 0){
80103112:	85 db                	test   %ebx,%ebx
80103114:	0f 85 f6 00 00 00    	jne    80103210 <end_op+0x130>
    do_commit = 1;
    log.committing = 1;
8010311a:	c7 05 e0 16 11 80 01 	movl   $0x1,0x801116e0
80103121:	00 00 00 
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80103124:	83 ec 0c             	sub    $0xc,%esp
80103127:	68 a0 16 11 80       	push   $0x801116a0
8010312c:	e8 1f 17 00 00       	call   80104850 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80103131:	8b 0d e8 16 11 80    	mov    0x801116e8,%ecx
80103137:	83 c4 10             	add    $0x10,%esp
8010313a:	85 c9                	test   %ecx,%ecx
8010313c:	7f 42                	jg     80103180 <end_op+0xa0>
    acquire(&log.lock);
8010313e:	83 ec 0c             	sub    $0xc,%esp
80103141:	68 a0 16 11 80       	push   $0x801116a0
80103146:	e8 65 17 00 00       	call   801048b0 <acquire>
    wakeup(&log);
8010314b:	c7 04 24 a0 16 11 80 	movl   $0x801116a0,(%esp)
    log.committing = 0;
80103152:	c7 05 e0 16 11 80 00 	movl   $0x0,0x801116e0
80103159:	00 00 00 
    wakeup(&log);
8010315c:	e8 af 12 00 00       	call   80104410 <wakeup>
    release(&log.lock);
80103161:	c7 04 24 a0 16 11 80 	movl   $0x801116a0,(%esp)
80103168:	e8 e3 16 00 00       	call   80104850 <release>
8010316d:	83 c4 10             	add    $0x10,%esp
}
80103170:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103173:	5b                   	pop    %ebx
80103174:	5e                   	pop    %esi
80103175:	5f                   	pop    %edi
80103176:	5d                   	pop    %ebp
80103177:	c3                   	ret    
80103178:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010317f:	90                   	nop
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80103180:	a1 d4 16 11 80       	mov    0x801116d4,%eax
80103185:	83 ec 08             	sub    $0x8,%esp
80103188:	01 d8                	add    %ebx,%eax
8010318a:	83 c0 01             	add    $0x1,%eax
8010318d:	50                   	push   %eax
8010318e:	ff 35 e4 16 11 80    	push   0x801116e4
80103194:	e8 37 cf ff ff       	call   801000d0 <bread>
80103199:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
8010319b:	58                   	pop    %eax
8010319c:	5a                   	pop    %edx
8010319d:	ff 34 9d ec 16 11 80 	push   -0x7feee914(,%ebx,4)
801031a4:	ff 35 e4 16 11 80    	push   0x801116e4
  for (tail = 0; tail < log.lh.n; tail++) {
801031aa:	83 c3 01             	add    $0x1,%ebx
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
801031ad:	e8 1e cf ff ff       	call   801000d0 <bread>
    memmove(to->data, from->data, BSIZE);
801031b2:	83 c4 0c             	add    $0xc,%esp
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
801031b5:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
801031b7:	8d 40 5c             	lea    0x5c(%eax),%eax
801031ba:	68 00 02 00 00       	push   $0x200
801031bf:	50                   	push   %eax
801031c0:	8d 46 5c             	lea    0x5c(%esi),%eax
801031c3:	50                   	push   %eax
801031c4:	e8 47 18 00 00       	call   80104a10 <memmove>
    bwrite(to);  // write the log
801031c9:	89 34 24             	mov    %esi,(%esp)
801031cc:	e8 df cf ff ff       	call   801001b0 <bwrite>
    brelse(from);
801031d1:	89 3c 24             	mov    %edi,(%esp)
801031d4:	e8 17 d0 ff ff       	call   801001f0 <brelse>
    brelse(to);
801031d9:	89 34 24             	mov    %esi,(%esp)
801031dc:	e8 0f d0 ff ff       	call   801001f0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
801031e1:	83 c4 10             	add    $0x10,%esp
801031e4:	3b 1d e8 16 11 80    	cmp    0x801116e8,%ebx
801031ea:	7c 94                	jl     80103180 <end_op+0xa0>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
801031ec:	e8 7f fd ff ff       	call   80102f70 <write_head>
    install_trans(); // Now install writes to home locations
801031f1:	e8 da fc ff ff       	call   80102ed0 <install_trans>
    log.lh.n = 0;
801031f6:	c7 05 e8 16 11 80 00 	movl   $0x0,0x801116e8
801031fd:	00 00 00 
    write_head();    // Erase the transaction from the log
80103200:	e8 6b fd ff ff       	call   80102f70 <write_head>
80103205:	e9 34 ff ff ff       	jmp    8010313e <end_op+0x5e>
8010320a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    wakeup(&log);
80103210:	83 ec 0c             	sub    $0xc,%esp
80103213:	68 a0 16 11 80       	push   $0x801116a0
80103218:	e8 f3 11 00 00       	call   80104410 <wakeup>
  release(&log.lock);
8010321d:	c7 04 24 a0 16 11 80 	movl   $0x801116a0,(%esp)
80103224:	e8 27 16 00 00       	call   80104850 <release>
80103229:	83 c4 10             	add    $0x10,%esp
}
8010322c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010322f:	5b                   	pop    %ebx
80103230:	5e                   	pop    %esi
80103231:	5f                   	pop    %edi
80103232:	5d                   	pop    %ebp
80103233:	c3                   	ret    
    panic("log.committing");
80103234:	83 ec 0c             	sub    $0xc,%esp
80103237:	68 a4 79 10 80       	push   $0x801079a4
8010323c:	e8 3f d1 ff ff       	call   80100380 <panic>
80103241:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103248:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010324f:	90                   	nop

80103250 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80103250:	55                   	push   %ebp
80103251:	89 e5                	mov    %esp,%ebp
80103253:	53                   	push   %ebx
80103254:	83 ec 04             	sub    $0x4,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80103257:	8b 15 e8 16 11 80    	mov    0x801116e8,%edx
{
8010325d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80103260:	83 fa 1d             	cmp    $0x1d,%edx
80103263:	0f 8f 85 00 00 00    	jg     801032ee <log_write+0x9e>
80103269:	a1 d8 16 11 80       	mov    0x801116d8,%eax
8010326e:	83 e8 01             	sub    $0x1,%eax
80103271:	39 c2                	cmp    %eax,%edx
80103273:	7d 79                	jge    801032ee <log_write+0x9e>
    panic("too big a transaction");
  if (log.outstanding < 1)
80103275:	a1 dc 16 11 80       	mov    0x801116dc,%eax
8010327a:	85 c0                	test   %eax,%eax
8010327c:	7e 7d                	jle    801032fb <log_write+0xab>
    panic("log_write outside of trans");

  acquire(&log.lock);
8010327e:	83 ec 0c             	sub    $0xc,%esp
80103281:	68 a0 16 11 80       	push   $0x801116a0
80103286:	e8 25 16 00 00       	call   801048b0 <acquire>
  for (i = 0; i < log.lh.n; i++) {
8010328b:	8b 15 e8 16 11 80    	mov    0x801116e8,%edx
80103291:	83 c4 10             	add    $0x10,%esp
80103294:	85 d2                	test   %edx,%edx
80103296:	7e 4a                	jle    801032e2 <log_write+0x92>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80103298:	8b 4b 08             	mov    0x8(%ebx),%ecx
  for (i = 0; i < log.lh.n; i++) {
8010329b:	31 c0                	xor    %eax,%eax
8010329d:	eb 08                	jmp    801032a7 <log_write+0x57>
8010329f:	90                   	nop
801032a0:	83 c0 01             	add    $0x1,%eax
801032a3:	39 c2                	cmp    %eax,%edx
801032a5:	74 29                	je     801032d0 <log_write+0x80>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
801032a7:	39 0c 85 ec 16 11 80 	cmp    %ecx,-0x7feee914(,%eax,4)
801032ae:	75 f0                	jne    801032a0 <log_write+0x50>
      break;
  }
  log.lh.block[i] = b->blockno;
801032b0:	89 0c 85 ec 16 11 80 	mov    %ecx,-0x7feee914(,%eax,4)
  if (i == log.lh.n)
    log.lh.n++;
  b->flags |= B_DIRTY; // prevent eviction
801032b7:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
}
801032ba:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  release(&log.lock);
801032bd:	c7 45 08 a0 16 11 80 	movl   $0x801116a0,0x8(%ebp)
}
801032c4:	c9                   	leave  
  release(&log.lock);
801032c5:	e9 86 15 00 00       	jmp    80104850 <release>
801032ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  log.lh.block[i] = b->blockno;
801032d0:	89 0c 95 ec 16 11 80 	mov    %ecx,-0x7feee914(,%edx,4)
    log.lh.n++;
801032d7:	83 c2 01             	add    $0x1,%edx
801032da:	89 15 e8 16 11 80    	mov    %edx,0x801116e8
801032e0:	eb d5                	jmp    801032b7 <log_write+0x67>
  log.lh.block[i] = b->blockno;
801032e2:	8b 43 08             	mov    0x8(%ebx),%eax
801032e5:	a3 ec 16 11 80       	mov    %eax,0x801116ec
  if (i == log.lh.n)
801032ea:	75 cb                	jne    801032b7 <log_write+0x67>
801032ec:	eb e9                	jmp    801032d7 <log_write+0x87>
    panic("too big a transaction");
801032ee:	83 ec 0c             	sub    $0xc,%esp
801032f1:	68 b3 79 10 80       	push   $0x801079b3
801032f6:	e8 85 d0 ff ff       	call   80100380 <panic>
    panic("log_write outside of trans");
801032fb:	83 ec 0c             	sub    $0xc,%esp
801032fe:	68 c9 79 10 80       	push   $0x801079c9
80103303:	e8 78 d0 ff ff       	call   80100380 <panic>
80103308:	66 90                	xchg   %ax,%ax
8010330a:	66 90                	xchg   %ax,%ax
8010330c:	66 90                	xchg   %ax,%ax
8010330e:	66 90                	xchg   %ax,%ax

80103310 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80103310:	55                   	push   %ebp
80103311:	89 e5                	mov    %esp,%ebp
80103313:	53                   	push   %ebx
80103314:	83 ec 04             	sub    $0x4,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
80103317:	e8 44 09 00 00       	call   80103c60 <cpuid>
8010331c:	89 c3                	mov    %eax,%ebx
8010331e:	e8 3d 09 00 00       	call   80103c60 <cpuid>
80103323:	83 ec 04             	sub    $0x4,%esp
80103326:	53                   	push   %ebx
80103327:	50                   	push   %eax
80103328:	68 e4 79 10 80       	push   $0x801079e4
8010332d:	e8 fe d3 ff ff       	call   80100730 <cprintf>
  idtinit();       // load idt register
80103332:	e8 b9 28 00 00       	call   80105bf0 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
80103337:	e8 c4 08 00 00       	call   80103c00 <mycpu>
8010333c:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
8010333e:	b8 01 00 00 00       	mov    $0x1,%eax
80103343:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
8010334a:	e8 f1 0b 00 00       	call   80103f40 <scheduler>
8010334f:	90                   	nop

80103350 <mpenter>:
{
80103350:	55                   	push   %ebp
80103351:	89 e5                	mov    %esp,%ebp
80103353:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80103356:	e8 85 39 00 00       	call   80106ce0 <switchkvm>
  seginit();
8010335b:	e8 f0 38 00 00       	call   80106c50 <seginit>
  lapicinit();
80103360:	e8 9b f7 ff ff       	call   80102b00 <lapicinit>
  mpmain();
80103365:	e8 a6 ff ff ff       	call   80103310 <mpmain>
8010336a:	66 90                	xchg   %ax,%ax
8010336c:	66 90                	xchg   %ax,%ax
8010336e:	66 90                	xchg   %ax,%ax

80103370 <main>:
{
80103370:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80103374:	83 e4 f0             	and    $0xfffffff0,%esp
80103377:	ff 71 fc             	push   -0x4(%ecx)
8010337a:	55                   	push   %ebp
8010337b:	89 e5                	mov    %esp,%ebp
8010337d:	53                   	push   %ebx
8010337e:	51                   	push   %ecx
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
8010337f:	83 ec 08             	sub    $0x8,%esp
80103382:	68 00 00 40 80       	push   $0x80400000
80103387:	68 d0 54 11 80       	push   $0x801154d0
8010338c:	e8 8f f5 ff ff       	call   80102920 <kinit1>
  kvmalloc();      // kernel page table
80103391:	e8 3a 3e 00 00       	call   801071d0 <kvmalloc>
  mpinit();        // detect other processors
80103396:	e8 85 01 00 00       	call   80103520 <mpinit>
  lapicinit();     // interrupt controller
8010339b:	e8 60 f7 ff ff       	call   80102b00 <lapicinit>
  seginit();       // segment descriptors
801033a0:	e8 ab 38 00 00       	call   80106c50 <seginit>
  picinit();       // disable pic
801033a5:	e8 76 03 00 00       	call   80103720 <picinit>
  ioapicinit();    // another interrupt controller
801033aa:	e8 31 f3 ff ff       	call   801026e0 <ioapicinit>
  consoleinit();   // console hardware
801033af:	e8 bc d9 ff ff       	call   80100d70 <consoleinit>
  uartinit();      // serial port
801033b4:	e8 27 2b 00 00       	call   80105ee0 <uartinit>
  pinit();         // process table
801033b9:	e8 22 08 00 00       	call   80103be0 <pinit>
  tvinit();        // trap vectors
801033be:	e8 ad 27 00 00       	call   80105b70 <tvinit>
  binit();         // buffer cache
801033c3:	e8 78 cc ff ff       	call   80100040 <binit>
  fileinit();      // file table
801033c8:	e8 53 dd ff ff       	call   80101120 <fileinit>
  ideinit();       // disk 
801033cd:	e8 fe f0 ff ff       	call   801024d0 <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
801033d2:	83 c4 0c             	add    $0xc,%esp
801033d5:	68 8a 00 00 00       	push   $0x8a
801033da:	68 8c a4 10 80       	push   $0x8010a48c
801033df:	68 00 70 00 80       	push   $0x80007000
801033e4:	e8 27 16 00 00       	call   80104a10 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
801033e9:	83 c4 10             	add    $0x10,%esp
801033ec:	69 05 84 17 11 80 b0 	imul   $0xb0,0x80111784,%eax
801033f3:	00 00 00 
801033f6:	05 a0 17 11 80       	add    $0x801117a0,%eax
801033fb:	3d a0 17 11 80       	cmp    $0x801117a0,%eax
80103400:	76 7e                	jbe    80103480 <main+0x110>
80103402:	bb a0 17 11 80       	mov    $0x801117a0,%ebx
80103407:	eb 20                	jmp    80103429 <main+0xb9>
80103409:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103410:	69 05 84 17 11 80 b0 	imul   $0xb0,0x80111784,%eax
80103417:	00 00 00 
8010341a:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
80103420:	05 a0 17 11 80       	add    $0x801117a0,%eax
80103425:	39 c3                	cmp    %eax,%ebx
80103427:	73 57                	jae    80103480 <main+0x110>
    if(c == mycpu())  // We've started already.
80103429:	e8 d2 07 00 00       	call   80103c00 <mycpu>
8010342e:	39 c3                	cmp    %eax,%ebx
80103430:	74 de                	je     80103410 <main+0xa0>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80103432:	e8 59 f5 ff ff       	call   80102990 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
    *(void(**)(void))(code-8) = mpenter;
    *(int**)(code-12) = (void *) V2P(entrypgdir);

    lapicstartap(c->apicid, V2P(code));
80103437:	83 ec 08             	sub    $0x8,%esp
    *(void(**)(void))(code-8) = mpenter;
8010343a:	c7 05 f8 6f 00 80 50 	movl   $0x80103350,0x80006ff8
80103441:	33 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
80103444:	c7 05 f4 6f 00 80 00 	movl   $0x109000,0x80006ff4
8010344b:	90 10 00 
    *(void**)(code-4) = stack + KSTACKSIZE;
8010344e:	05 00 10 00 00       	add    $0x1000,%eax
80103453:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc
    lapicstartap(c->apicid, V2P(code));
80103458:	0f b6 03             	movzbl (%ebx),%eax
8010345b:	68 00 70 00 00       	push   $0x7000
80103460:	50                   	push   %eax
80103461:	e8 ea f7 ff ff       	call   80102c50 <lapicstartap>

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80103466:	83 c4 10             	add    $0x10,%esp
80103469:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103470:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80103476:	85 c0                	test   %eax,%eax
80103478:	74 f6                	je     80103470 <main+0x100>
8010347a:	eb 94                	jmp    80103410 <main+0xa0>
8010347c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80103480:	83 ec 08             	sub    $0x8,%esp
80103483:	68 00 00 00 8e       	push   $0x8e000000
80103488:	68 00 00 40 80       	push   $0x80400000
8010348d:	e8 2e f4 ff ff       	call   801028c0 <kinit2>
  userinit();      // first user process
80103492:	e8 19 08 00 00       	call   80103cb0 <userinit>
  mpmain();        // finish this processor's setup
80103497:	e8 74 fe ff ff       	call   80103310 <mpmain>
8010349c:	66 90                	xchg   %ax,%ax
8010349e:	66 90                	xchg   %ax,%ax

801034a0 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
801034a0:	55                   	push   %ebp
801034a1:	89 e5                	mov    %esp,%ebp
801034a3:	57                   	push   %edi
801034a4:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
801034a5:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
{
801034ab:	53                   	push   %ebx
  e = addr+len;
801034ac:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
{
801034af:	83 ec 0c             	sub    $0xc,%esp
  for(p = addr; p < e; p += sizeof(struct mp))
801034b2:	39 de                	cmp    %ebx,%esi
801034b4:	72 10                	jb     801034c6 <mpsearch1+0x26>
801034b6:	eb 50                	jmp    80103508 <mpsearch1+0x68>
801034b8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801034bf:	90                   	nop
801034c0:	89 fe                	mov    %edi,%esi
801034c2:	39 fb                	cmp    %edi,%ebx
801034c4:	76 42                	jbe    80103508 <mpsearch1+0x68>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801034c6:	83 ec 04             	sub    $0x4,%esp
801034c9:	8d 7e 10             	lea    0x10(%esi),%edi
801034cc:	6a 04                	push   $0x4
801034ce:	68 f8 79 10 80       	push   $0x801079f8
801034d3:	56                   	push   %esi
801034d4:	e8 e7 14 00 00       	call   801049c0 <memcmp>
801034d9:	83 c4 10             	add    $0x10,%esp
801034dc:	85 c0                	test   %eax,%eax
801034de:	75 e0                	jne    801034c0 <mpsearch1+0x20>
801034e0:	89 f2                	mov    %esi,%edx
801034e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    sum += addr[i];
801034e8:	0f b6 0a             	movzbl (%edx),%ecx
  for(i=0; i<len; i++)
801034eb:	83 c2 01             	add    $0x1,%edx
    sum += addr[i];
801034ee:	01 c8                	add    %ecx,%eax
  for(i=0; i<len; i++)
801034f0:	39 fa                	cmp    %edi,%edx
801034f2:	75 f4                	jne    801034e8 <mpsearch1+0x48>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801034f4:	84 c0                	test   %al,%al
801034f6:	75 c8                	jne    801034c0 <mpsearch1+0x20>
      return (struct mp*)p;
  return 0;
}
801034f8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801034fb:	89 f0                	mov    %esi,%eax
801034fd:	5b                   	pop    %ebx
801034fe:	5e                   	pop    %esi
801034ff:	5f                   	pop    %edi
80103500:	5d                   	pop    %ebp
80103501:	c3                   	ret    
80103502:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103508:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010350b:	31 f6                	xor    %esi,%esi
}
8010350d:	5b                   	pop    %ebx
8010350e:	89 f0                	mov    %esi,%eax
80103510:	5e                   	pop    %esi
80103511:	5f                   	pop    %edi
80103512:	5d                   	pop    %ebp
80103513:	c3                   	ret    
80103514:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010351b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010351f:	90                   	nop

80103520 <mpinit>:
  return conf;
}

void
mpinit(void)
{
80103520:	55                   	push   %ebp
80103521:	89 e5                	mov    %esp,%ebp
80103523:	57                   	push   %edi
80103524:	56                   	push   %esi
80103525:	53                   	push   %ebx
80103526:	83 ec 1c             	sub    $0x1c,%esp
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80103529:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
80103530:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
80103537:	c1 e0 08             	shl    $0x8,%eax
8010353a:	09 d0                	or     %edx,%eax
8010353c:	c1 e0 04             	shl    $0x4,%eax
8010353f:	75 1b                	jne    8010355c <mpinit+0x3c>
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
80103541:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
80103548:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
8010354f:	c1 e0 08             	shl    $0x8,%eax
80103552:	09 d0                	or     %edx,%eax
80103554:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
80103557:	2d 00 04 00 00       	sub    $0x400,%eax
    if((mp = mpsearch1(p, 1024)))
8010355c:	ba 00 04 00 00       	mov    $0x400,%edx
80103561:	e8 3a ff ff ff       	call   801034a0 <mpsearch1>
80103566:	89 c3                	mov    %eax,%ebx
80103568:	85 c0                	test   %eax,%eax
8010356a:	0f 84 40 01 00 00    	je     801036b0 <mpinit+0x190>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103570:	8b 73 04             	mov    0x4(%ebx),%esi
80103573:	85 f6                	test   %esi,%esi
80103575:	0f 84 25 01 00 00    	je     801036a0 <mpinit+0x180>
  if(memcmp(conf, "PCMP", 4) != 0)
8010357b:	83 ec 04             	sub    $0x4,%esp
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
8010357e:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
  if(memcmp(conf, "PCMP", 4) != 0)
80103584:	6a 04                	push   $0x4
80103586:	68 fd 79 10 80       	push   $0x801079fd
8010358b:	50                   	push   %eax
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
8010358c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(memcmp(conf, "PCMP", 4) != 0)
8010358f:	e8 2c 14 00 00       	call   801049c0 <memcmp>
80103594:	83 c4 10             	add    $0x10,%esp
80103597:	85 c0                	test   %eax,%eax
80103599:	0f 85 01 01 00 00    	jne    801036a0 <mpinit+0x180>
  if(conf->version != 1 && conf->version != 4)
8010359f:	0f b6 86 06 00 00 80 	movzbl -0x7ffffffa(%esi),%eax
801035a6:	3c 01                	cmp    $0x1,%al
801035a8:	74 08                	je     801035b2 <mpinit+0x92>
801035aa:	3c 04                	cmp    $0x4,%al
801035ac:	0f 85 ee 00 00 00    	jne    801036a0 <mpinit+0x180>
  if(sum((uchar*)conf, conf->length) != 0)
801035b2:	0f b7 96 04 00 00 80 	movzwl -0x7ffffffc(%esi),%edx
  for(i=0; i<len; i++)
801035b9:	66 85 d2             	test   %dx,%dx
801035bc:	74 22                	je     801035e0 <mpinit+0xc0>
801035be:	8d 3c 32             	lea    (%edx,%esi,1),%edi
801035c1:	89 f0                	mov    %esi,%eax
  sum = 0;
801035c3:	31 d2                	xor    %edx,%edx
801035c5:	8d 76 00             	lea    0x0(%esi),%esi
    sum += addr[i];
801035c8:	0f b6 88 00 00 00 80 	movzbl -0x80000000(%eax),%ecx
  for(i=0; i<len; i++)
801035cf:	83 c0 01             	add    $0x1,%eax
    sum += addr[i];
801035d2:	01 ca                	add    %ecx,%edx
  for(i=0; i<len; i++)
801035d4:	39 c7                	cmp    %eax,%edi
801035d6:	75 f0                	jne    801035c8 <mpinit+0xa8>
  if(sum((uchar*)conf, conf->length) != 0)
801035d8:	84 d2                	test   %dl,%dl
801035da:	0f 85 c0 00 00 00    	jne    801036a0 <mpinit+0x180>
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
801035e0:	8b 86 24 00 00 80    	mov    -0x7fffffdc(%esi),%eax
801035e6:	a3 80 16 11 80       	mov    %eax,0x80111680
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801035eb:	0f b7 96 04 00 00 80 	movzwl -0x7ffffffc(%esi),%edx
801035f2:	8d 86 2c 00 00 80    	lea    -0x7fffffd4(%esi),%eax
  ismp = 1;
801035f8:	be 01 00 00 00       	mov    $0x1,%esi
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801035fd:	03 55 e4             	add    -0x1c(%ebp),%edx
80103600:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
80103603:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103607:	90                   	nop
80103608:	39 d0                	cmp    %edx,%eax
8010360a:	73 15                	jae    80103621 <mpinit+0x101>
    switch(*p){
8010360c:	0f b6 08             	movzbl (%eax),%ecx
8010360f:	80 f9 02             	cmp    $0x2,%cl
80103612:	74 4c                	je     80103660 <mpinit+0x140>
80103614:	77 3a                	ja     80103650 <mpinit+0x130>
80103616:	84 c9                	test   %cl,%cl
80103618:	74 56                	je     80103670 <mpinit+0x150>
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
8010361a:	83 c0 08             	add    $0x8,%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
8010361d:	39 d0                	cmp    %edx,%eax
8010361f:	72 eb                	jb     8010360c <mpinit+0xec>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
80103621:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80103624:	85 f6                	test   %esi,%esi
80103626:	0f 84 d9 00 00 00    	je     80103705 <mpinit+0x1e5>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
8010362c:	80 7b 0c 00          	cmpb   $0x0,0xc(%ebx)
80103630:	74 15                	je     80103647 <mpinit+0x127>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103632:	b8 70 00 00 00       	mov    $0x70,%eax
80103637:	ba 22 00 00 00       	mov    $0x22,%edx
8010363c:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010363d:	ba 23 00 00 00       	mov    $0x23,%edx
80103642:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
80103643:	83 c8 01             	or     $0x1,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103646:	ee                   	out    %al,(%dx)
  }
}
80103647:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010364a:	5b                   	pop    %ebx
8010364b:	5e                   	pop    %esi
8010364c:	5f                   	pop    %edi
8010364d:	5d                   	pop    %ebp
8010364e:	c3                   	ret    
8010364f:	90                   	nop
    switch(*p){
80103650:	83 e9 03             	sub    $0x3,%ecx
80103653:	80 f9 01             	cmp    $0x1,%cl
80103656:	76 c2                	jbe    8010361a <mpinit+0xfa>
80103658:	31 f6                	xor    %esi,%esi
8010365a:	eb ac                	jmp    80103608 <mpinit+0xe8>
8010365c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      ioapicid = ioapic->apicno;
80103660:	0f b6 48 01          	movzbl 0x1(%eax),%ecx
      p += sizeof(struct mpioapic);
80103664:	83 c0 08             	add    $0x8,%eax
      ioapicid = ioapic->apicno;
80103667:	88 0d 80 17 11 80    	mov    %cl,0x80111780
      continue;
8010366d:	eb 99                	jmp    80103608 <mpinit+0xe8>
8010366f:	90                   	nop
      if(ncpu < NCPU) {
80103670:	8b 0d 84 17 11 80    	mov    0x80111784,%ecx
80103676:	83 f9 07             	cmp    $0x7,%ecx
80103679:	7f 19                	jg     80103694 <mpinit+0x174>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
8010367b:	69 f9 b0 00 00 00    	imul   $0xb0,%ecx,%edi
80103681:	0f b6 58 01          	movzbl 0x1(%eax),%ebx
        ncpu++;
80103685:	83 c1 01             	add    $0x1,%ecx
80103688:	89 0d 84 17 11 80    	mov    %ecx,0x80111784
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
8010368e:	88 9f a0 17 11 80    	mov    %bl,-0x7feee860(%edi)
      p += sizeof(struct mpproc);
80103694:	83 c0 14             	add    $0x14,%eax
      continue;
80103697:	e9 6c ff ff ff       	jmp    80103608 <mpinit+0xe8>
8010369c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    panic("Expect to run on an SMP");
801036a0:	83 ec 0c             	sub    $0xc,%esp
801036a3:	68 02 7a 10 80       	push   $0x80107a02
801036a8:	e8 d3 cc ff ff       	call   80100380 <panic>
801036ad:	8d 76 00             	lea    0x0(%esi),%esi
{
801036b0:	bb 00 00 0f 80       	mov    $0x800f0000,%ebx
801036b5:	eb 13                	jmp    801036ca <mpinit+0x1aa>
801036b7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801036be:	66 90                	xchg   %ax,%ax
  for(p = addr; p < e; p += sizeof(struct mp))
801036c0:	89 f3                	mov    %esi,%ebx
801036c2:	81 fe 00 00 10 80    	cmp    $0x80100000,%esi
801036c8:	74 d6                	je     801036a0 <mpinit+0x180>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801036ca:	83 ec 04             	sub    $0x4,%esp
801036cd:	8d 73 10             	lea    0x10(%ebx),%esi
801036d0:	6a 04                	push   $0x4
801036d2:	68 f8 79 10 80       	push   $0x801079f8
801036d7:	53                   	push   %ebx
801036d8:	e8 e3 12 00 00       	call   801049c0 <memcmp>
801036dd:	83 c4 10             	add    $0x10,%esp
801036e0:	85 c0                	test   %eax,%eax
801036e2:	75 dc                	jne    801036c0 <mpinit+0x1a0>
801036e4:	89 da                	mov    %ebx,%edx
801036e6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801036ed:	8d 76 00             	lea    0x0(%esi),%esi
    sum += addr[i];
801036f0:	0f b6 0a             	movzbl (%edx),%ecx
  for(i=0; i<len; i++)
801036f3:	83 c2 01             	add    $0x1,%edx
    sum += addr[i];
801036f6:	01 c8                	add    %ecx,%eax
  for(i=0; i<len; i++)
801036f8:	39 d6                	cmp    %edx,%esi
801036fa:	75 f4                	jne    801036f0 <mpinit+0x1d0>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801036fc:	84 c0                	test   %al,%al
801036fe:	75 c0                	jne    801036c0 <mpinit+0x1a0>
80103700:	e9 6b fe ff ff       	jmp    80103570 <mpinit+0x50>
    panic("Didn't find a suitable machine");
80103705:	83 ec 0c             	sub    $0xc,%esp
80103708:	68 1c 7a 10 80       	push   $0x80107a1c
8010370d:	e8 6e cc ff ff       	call   80100380 <panic>
80103712:	66 90                	xchg   %ax,%ax
80103714:	66 90                	xchg   %ax,%ax
80103716:	66 90                	xchg   %ax,%ax
80103718:	66 90                	xchg   %ax,%ax
8010371a:	66 90                	xchg   %ax,%ax
8010371c:	66 90                	xchg   %ax,%ax
8010371e:	66 90                	xchg   %ax,%ax

80103720 <picinit>:
80103720:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103725:	ba 21 00 00 00       	mov    $0x21,%edx
8010372a:	ee                   	out    %al,(%dx)
8010372b:	ba a1 00 00 00       	mov    $0xa1,%edx
80103730:	ee                   	out    %al,(%dx)
picinit(void)
{
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
80103731:	c3                   	ret    
80103732:	66 90                	xchg   %ax,%ax
80103734:	66 90                	xchg   %ax,%ax
80103736:	66 90                	xchg   %ax,%ax
80103738:	66 90                	xchg   %ax,%ax
8010373a:	66 90                	xchg   %ax,%ax
8010373c:	66 90                	xchg   %ax,%ax
8010373e:	66 90                	xchg   %ax,%ax

80103740 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80103740:	55                   	push   %ebp
80103741:	89 e5                	mov    %esp,%ebp
80103743:	57                   	push   %edi
80103744:	56                   	push   %esi
80103745:	53                   	push   %ebx
80103746:	83 ec 0c             	sub    $0xc,%esp
80103749:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010374c:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
8010374f:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80103755:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
8010375b:	e8 e0 d9 ff ff       	call   80101140 <filealloc>
80103760:	89 03                	mov    %eax,(%ebx)
80103762:	85 c0                	test   %eax,%eax
80103764:	0f 84 a8 00 00 00    	je     80103812 <pipealloc+0xd2>
8010376a:	e8 d1 d9 ff ff       	call   80101140 <filealloc>
8010376f:	89 06                	mov    %eax,(%esi)
80103771:	85 c0                	test   %eax,%eax
80103773:	0f 84 87 00 00 00    	je     80103800 <pipealloc+0xc0>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80103779:	e8 12 f2 ff ff       	call   80102990 <kalloc>
8010377e:	89 c7                	mov    %eax,%edi
80103780:	85 c0                	test   %eax,%eax
80103782:	0f 84 b0 00 00 00    	je     80103838 <pipealloc+0xf8>
    goto bad;
  p->readopen = 1;
80103788:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
8010378f:	00 00 00 
  p->writeopen = 1;
  p->nwrite = 0;
  p->nread = 0;
  initlock(&p->lock, "pipe");
80103792:	83 ec 08             	sub    $0x8,%esp
  p->writeopen = 1;
80103795:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
8010379c:	00 00 00 
  p->nwrite = 0;
8010379f:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
801037a6:	00 00 00 
  p->nread = 0;
801037a9:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
801037b0:	00 00 00 
  initlock(&p->lock, "pipe");
801037b3:	68 3b 7a 10 80       	push   $0x80107a3b
801037b8:	50                   	push   %eax
801037b9:	e8 22 0f 00 00       	call   801046e0 <initlock>
  (*f0)->type = FD_PIPE;
801037be:	8b 03                	mov    (%ebx),%eax
  (*f0)->pipe = p;
  (*f1)->type = FD_PIPE;
  (*f1)->readable = 0;
  (*f1)->writable = 1;
  (*f1)->pipe = p;
  return 0;
801037c0:	83 c4 10             	add    $0x10,%esp
  (*f0)->type = FD_PIPE;
801037c3:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
801037c9:	8b 03                	mov    (%ebx),%eax
801037cb:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
801037cf:	8b 03                	mov    (%ebx),%eax
801037d1:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
801037d5:	8b 03                	mov    (%ebx),%eax
801037d7:	89 78 0c             	mov    %edi,0xc(%eax)
  (*f1)->type = FD_PIPE;
801037da:	8b 06                	mov    (%esi),%eax
801037dc:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
801037e2:	8b 06                	mov    (%esi),%eax
801037e4:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
801037e8:	8b 06                	mov    (%esi),%eax
801037ea:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
801037ee:	8b 06                	mov    (%esi),%eax
801037f0:	89 78 0c             	mov    %edi,0xc(%eax)
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
801037f3:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801037f6:	31 c0                	xor    %eax,%eax
}
801037f8:	5b                   	pop    %ebx
801037f9:	5e                   	pop    %esi
801037fa:	5f                   	pop    %edi
801037fb:	5d                   	pop    %ebp
801037fc:	c3                   	ret    
801037fd:	8d 76 00             	lea    0x0(%esi),%esi
  if(*f0)
80103800:	8b 03                	mov    (%ebx),%eax
80103802:	85 c0                	test   %eax,%eax
80103804:	74 1e                	je     80103824 <pipealloc+0xe4>
    fileclose(*f0);
80103806:	83 ec 0c             	sub    $0xc,%esp
80103809:	50                   	push   %eax
8010380a:	e8 f1 d9 ff ff       	call   80101200 <fileclose>
8010380f:	83 c4 10             	add    $0x10,%esp
  if(*f1)
80103812:	8b 06                	mov    (%esi),%eax
80103814:	85 c0                	test   %eax,%eax
80103816:	74 0c                	je     80103824 <pipealloc+0xe4>
    fileclose(*f1);
80103818:	83 ec 0c             	sub    $0xc,%esp
8010381b:	50                   	push   %eax
8010381c:	e8 df d9 ff ff       	call   80101200 <fileclose>
80103821:	83 c4 10             	add    $0x10,%esp
}
80103824:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
80103827:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010382c:	5b                   	pop    %ebx
8010382d:	5e                   	pop    %esi
8010382e:	5f                   	pop    %edi
8010382f:	5d                   	pop    %ebp
80103830:	c3                   	ret    
80103831:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(*f0)
80103838:	8b 03                	mov    (%ebx),%eax
8010383a:	85 c0                	test   %eax,%eax
8010383c:	75 c8                	jne    80103806 <pipealloc+0xc6>
8010383e:	eb d2                	jmp    80103812 <pipealloc+0xd2>

80103840 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
80103840:	55                   	push   %ebp
80103841:	89 e5                	mov    %esp,%ebp
80103843:	56                   	push   %esi
80103844:	53                   	push   %ebx
80103845:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103848:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
8010384b:	83 ec 0c             	sub    $0xc,%esp
8010384e:	53                   	push   %ebx
8010384f:	e8 5c 10 00 00       	call   801048b0 <acquire>
  if(writable){
80103854:	83 c4 10             	add    $0x10,%esp
80103857:	85 f6                	test   %esi,%esi
80103859:	74 65                	je     801038c0 <pipeclose+0x80>
    p->writeopen = 0;
    wakeup(&p->nread);
8010385b:	83 ec 0c             	sub    $0xc,%esp
8010385e:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
    p->writeopen = 0;
80103864:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
8010386b:	00 00 00 
    wakeup(&p->nread);
8010386e:	50                   	push   %eax
8010386f:	e8 9c 0b 00 00       	call   80104410 <wakeup>
80103874:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
80103877:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
8010387d:	85 d2                	test   %edx,%edx
8010387f:	75 0a                	jne    8010388b <pipeclose+0x4b>
80103881:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
80103887:	85 c0                	test   %eax,%eax
80103889:	74 15                	je     801038a0 <pipeclose+0x60>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
8010388b:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010388e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103891:	5b                   	pop    %ebx
80103892:	5e                   	pop    %esi
80103893:	5d                   	pop    %ebp
    release(&p->lock);
80103894:	e9 b7 0f 00 00       	jmp    80104850 <release>
80103899:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    release(&p->lock);
801038a0:	83 ec 0c             	sub    $0xc,%esp
801038a3:	53                   	push   %ebx
801038a4:	e8 a7 0f 00 00       	call   80104850 <release>
    kfree((char*)p);
801038a9:	89 5d 08             	mov    %ebx,0x8(%ebp)
801038ac:	83 c4 10             	add    $0x10,%esp
}
801038af:	8d 65 f8             	lea    -0x8(%ebp),%esp
801038b2:	5b                   	pop    %ebx
801038b3:	5e                   	pop    %esi
801038b4:	5d                   	pop    %ebp
    kfree((char*)p);
801038b5:	e9 16 ef ff ff       	jmp    801027d0 <kfree>
801038ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    wakeup(&p->nwrite);
801038c0:	83 ec 0c             	sub    $0xc,%esp
801038c3:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
    p->readopen = 0;
801038c9:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
801038d0:	00 00 00 
    wakeup(&p->nwrite);
801038d3:	50                   	push   %eax
801038d4:	e8 37 0b 00 00       	call   80104410 <wakeup>
801038d9:	83 c4 10             	add    $0x10,%esp
801038dc:	eb 99                	jmp    80103877 <pipeclose+0x37>
801038de:	66 90                	xchg   %ax,%ax

801038e0 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
801038e0:	55                   	push   %ebp
801038e1:	89 e5                	mov    %esp,%ebp
801038e3:	57                   	push   %edi
801038e4:	56                   	push   %esi
801038e5:	53                   	push   %ebx
801038e6:	83 ec 28             	sub    $0x28,%esp
801038e9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  acquire(&p->lock);
801038ec:	53                   	push   %ebx
801038ed:	e8 be 0f 00 00       	call   801048b0 <acquire>
  for(i = 0; i < n; i++){
801038f2:	8b 45 10             	mov    0x10(%ebp),%eax
801038f5:	83 c4 10             	add    $0x10,%esp
801038f8:	85 c0                	test   %eax,%eax
801038fa:	0f 8e c0 00 00 00    	jle    801039c0 <pipewrite+0xe0>
80103900:	8b 45 0c             	mov    0xc(%ebp),%eax
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103903:	8b 8b 38 02 00 00    	mov    0x238(%ebx),%ecx
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
80103909:	8d bb 34 02 00 00    	lea    0x234(%ebx),%edi
8010390f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103912:	03 45 10             	add    0x10(%ebp),%eax
80103915:	89 45 e0             	mov    %eax,-0x20(%ebp)
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103918:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
8010391e:	8d b3 38 02 00 00    	lea    0x238(%ebx),%esi
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103924:	89 ca                	mov    %ecx,%edx
80103926:	05 00 02 00 00       	add    $0x200,%eax
8010392b:	39 c1                	cmp    %eax,%ecx
8010392d:	74 3f                	je     8010396e <pipewrite+0x8e>
8010392f:	eb 67                	jmp    80103998 <pipewrite+0xb8>
80103931:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(p->readopen == 0 || myproc()->killed){
80103938:	e8 43 03 00 00       	call   80103c80 <myproc>
8010393d:	8b 48 24             	mov    0x24(%eax),%ecx
80103940:	85 c9                	test   %ecx,%ecx
80103942:	75 34                	jne    80103978 <pipewrite+0x98>
      wakeup(&p->nread);
80103944:	83 ec 0c             	sub    $0xc,%esp
80103947:	57                   	push   %edi
80103948:	e8 c3 0a 00 00       	call   80104410 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
8010394d:	58                   	pop    %eax
8010394e:	5a                   	pop    %edx
8010394f:	53                   	push   %ebx
80103950:	56                   	push   %esi
80103951:	e8 fa 09 00 00       	call   80104350 <sleep>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103956:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
8010395c:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
80103962:	83 c4 10             	add    $0x10,%esp
80103965:	05 00 02 00 00       	add    $0x200,%eax
8010396a:	39 c2                	cmp    %eax,%edx
8010396c:	75 2a                	jne    80103998 <pipewrite+0xb8>
      if(p->readopen == 0 || myproc()->killed){
8010396e:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
80103974:	85 c0                	test   %eax,%eax
80103976:	75 c0                	jne    80103938 <pipewrite+0x58>
        release(&p->lock);
80103978:	83 ec 0c             	sub    $0xc,%esp
8010397b:	53                   	push   %ebx
8010397c:	e8 cf 0e 00 00       	call   80104850 <release>
        return -1;
80103981:	83 c4 10             	add    $0x10,%esp
80103984:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
80103989:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010398c:	5b                   	pop    %ebx
8010398d:	5e                   	pop    %esi
8010398e:	5f                   	pop    %edi
8010398f:	5d                   	pop    %ebp
80103990:	c3                   	ret    
80103991:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80103998:	8b 75 e4             	mov    -0x1c(%ebp),%esi
8010399b:	8d 4a 01             	lea    0x1(%edx),%ecx
8010399e:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
801039a4:	89 8b 38 02 00 00    	mov    %ecx,0x238(%ebx)
801039aa:	0f b6 06             	movzbl (%esi),%eax
  for(i = 0; i < n; i++){
801039ad:	83 c6 01             	add    $0x1,%esi
801039b0:	89 75 e4             	mov    %esi,-0x1c(%ebp)
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
801039b3:	88 44 13 34          	mov    %al,0x34(%ebx,%edx,1)
  for(i = 0; i < n; i++){
801039b7:	3b 75 e0             	cmp    -0x20(%ebp),%esi
801039ba:	0f 85 58 ff ff ff    	jne    80103918 <pipewrite+0x38>
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
801039c0:	83 ec 0c             	sub    $0xc,%esp
801039c3:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
801039c9:	50                   	push   %eax
801039ca:	e8 41 0a 00 00       	call   80104410 <wakeup>
  release(&p->lock);
801039cf:	89 1c 24             	mov    %ebx,(%esp)
801039d2:	e8 79 0e 00 00       	call   80104850 <release>
  return n;
801039d7:	8b 45 10             	mov    0x10(%ebp),%eax
801039da:	83 c4 10             	add    $0x10,%esp
801039dd:	eb aa                	jmp    80103989 <pipewrite+0xa9>
801039df:	90                   	nop

801039e0 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
801039e0:	55                   	push   %ebp
801039e1:	89 e5                	mov    %esp,%ebp
801039e3:	57                   	push   %edi
801039e4:	56                   	push   %esi
801039e5:	53                   	push   %ebx
801039e6:	83 ec 18             	sub    $0x18,%esp
801039e9:	8b 75 08             	mov    0x8(%ebp),%esi
801039ec:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
801039ef:	56                   	push   %esi
801039f0:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
801039f6:	e8 b5 0e 00 00       	call   801048b0 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
801039fb:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
80103a01:	83 c4 10             	add    $0x10,%esp
80103a04:	39 86 38 02 00 00    	cmp    %eax,0x238(%esi)
80103a0a:	74 2f                	je     80103a3b <piperead+0x5b>
80103a0c:	eb 37                	jmp    80103a45 <piperead+0x65>
80103a0e:	66 90                	xchg   %ax,%ax
    if(myproc()->killed){
80103a10:	e8 6b 02 00 00       	call   80103c80 <myproc>
80103a15:	8b 48 24             	mov    0x24(%eax),%ecx
80103a18:	85 c9                	test   %ecx,%ecx
80103a1a:	0f 85 80 00 00 00    	jne    80103aa0 <piperead+0xc0>
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
80103a20:	83 ec 08             	sub    $0x8,%esp
80103a23:	56                   	push   %esi
80103a24:	53                   	push   %ebx
80103a25:	e8 26 09 00 00       	call   80104350 <sleep>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80103a2a:	8b 86 38 02 00 00    	mov    0x238(%esi),%eax
80103a30:	83 c4 10             	add    $0x10,%esp
80103a33:	39 86 34 02 00 00    	cmp    %eax,0x234(%esi)
80103a39:	75 0a                	jne    80103a45 <piperead+0x65>
80103a3b:	8b 86 40 02 00 00    	mov    0x240(%esi),%eax
80103a41:	85 c0                	test   %eax,%eax
80103a43:	75 cb                	jne    80103a10 <piperead+0x30>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103a45:	8b 55 10             	mov    0x10(%ebp),%edx
80103a48:	31 db                	xor    %ebx,%ebx
80103a4a:	85 d2                	test   %edx,%edx
80103a4c:	7f 20                	jg     80103a6e <piperead+0x8e>
80103a4e:	eb 2c                	jmp    80103a7c <piperead+0x9c>
    if(p->nread == p->nwrite)
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
80103a50:	8d 48 01             	lea    0x1(%eax),%ecx
80103a53:	25 ff 01 00 00       	and    $0x1ff,%eax
80103a58:	89 8e 34 02 00 00    	mov    %ecx,0x234(%esi)
80103a5e:	0f b6 44 06 34       	movzbl 0x34(%esi,%eax,1),%eax
80103a63:	88 04 1f             	mov    %al,(%edi,%ebx,1)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103a66:	83 c3 01             	add    $0x1,%ebx
80103a69:	39 5d 10             	cmp    %ebx,0x10(%ebp)
80103a6c:	74 0e                	je     80103a7c <piperead+0x9c>
    if(p->nread == p->nwrite)
80103a6e:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
80103a74:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
80103a7a:	75 d4                	jne    80103a50 <piperead+0x70>
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
80103a7c:	83 ec 0c             	sub    $0xc,%esp
80103a7f:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
80103a85:	50                   	push   %eax
80103a86:	e8 85 09 00 00       	call   80104410 <wakeup>
  release(&p->lock);
80103a8b:	89 34 24             	mov    %esi,(%esp)
80103a8e:	e8 bd 0d 00 00       	call   80104850 <release>
  return i;
80103a93:	83 c4 10             	add    $0x10,%esp
}
80103a96:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103a99:	89 d8                	mov    %ebx,%eax
80103a9b:	5b                   	pop    %ebx
80103a9c:	5e                   	pop    %esi
80103a9d:	5f                   	pop    %edi
80103a9e:	5d                   	pop    %ebp
80103a9f:	c3                   	ret    
      release(&p->lock);
80103aa0:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80103aa3:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
      release(&p->lock);
80103aa8:	56                   	push   %esi
80103aa9:	e8 a2 0d 00 00       	call   80104850 <release>
      return -1;
80103aae:	83 c4 10             	add    $0x10,%esp
}
80103ab1:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103ab4:	89 d8                	mov    %ebx,%eax
80103ab6:	5b                   	pop    %ebx
80103ab7:	5e                   	pop    %esi
80103ab8:	5f                   	pop    %edi
80103ab9:	5d                   	pop    %ebp
80103aba:	c3                   	ret    
80103abb:	66 90                	xchg   %ax,%ax
80103abd:	66 90                	xchg   %ax,%ax
80103abf:	90                   	nop

80103ac0 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
80103ac0:	55                   	push   %ebp
80103ac1:	89 e5                	mov    %esp,%ebp
80103ac3:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103ac4:	bb 54 1d 11 80       	mov    $0x80111d54,%ebx
{
80103ac9:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);
80103acc:	68 20 1d 11 80       	push   $0x80111d20
80103ad1:	e8 da 0d 00 00       	call   801048b0 <acquire>
80103ad6:	83 c4 10             	add    $0x10,%esp
80103ad9:	eb 10                	jmp    80103aeb <allocproc+0x2b>
80103adb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103adf:	90                   	nop
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103ae0:	83 c3 7c             	add    $0x7c,%ebx
80103ae3:	81 fb 54 3c 11 80    	cmp    $0x80113c54,%ebx
80103ae9:	74 75                	je     80103b60 <allocproc+0xa0>
    if(p->state == UNUSED)
80103aeb:	8b 43 0c             	mov    0xc(%ebx),%eax
80103aee:	85 c0                	test   %eax,%eax
80103af0:	75 ee                	jne    80103ae0 <allocproc+0x20>
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
80103af2:	a1 04 a0 10 80       	mov    0x8010a004,%eax

  release(&ptable.lock);
80103af7:	83 ec 0c             	sub    $0xc,%esp
  p->state = EMBRYO;
80103afa:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->pid = nextpid++;
80103b01:	89 43 10             	mov    %eax,0x10(%ebx)
80103b04:	8d 50 01             	lea    0x1(%eax),%edx
  release(&ptable.lock);
80103b07:	68 20 1d 11 80       	push   $0x80111d20
  p->pid = nextpid++;
80103b0c:	89 15 04 a0 10 80    	mov    %edx,0x8010a004
  release(&ptable.lock);
80103b12:	e8 39 0d 00 00       	call   80104850 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
80103b17:	e8 74 ee ff ff       	call   80102990 <kalloc>
80103b1c:	83 c4 10             	add    $0x10,%esp
80103b1f:	89 43 08             	mov    %eax,0x8(%ebx)
80103b22:	85 c0                	test   %eax,%eax
80103b24:	74 53                	je     80103b79 <allocproc+0xb9>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
80103b26:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
80103b2c:	83 ec 04             	sub    $0x4,%esp
  sp -= sizeof *p->context;
80103b2f:	05 9c 0f 00 00       	add    $0xf9c,%eax
  sp -= sizeof *p->tf;
80103b34:	89 53 18             	mov    %edx,0x18(%ebx)
  *(uint*)sp = (uint)trapret;
80103b37:	c7 40 14 62 5b 10 80 	movl   $0x80105b62,0x14(%eax)
  p->context = (struct context*)sp;
80103b3e:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
80103b41:	6a 14                	push   $0x14
80103b43:	6a 00                	push   $0x0
80103b45:	50                   	push   %eax
80103b46:	e8 25 0e 00 00       	call   80104970 <memset>
  p->context->eip = (uint)forkret;
80103b4b:	8b 43 1c             	mov    0x1c(%ebx),%eax

  return p;
80103b4e:	83 c4 10             	add    $0x10,%esp
  p->context->eip = (uint)forkret;
80103b51:	c7 40 10 90 3b 10 80 	movl   $0x80103b90,0x10(%eax)
}
80103b58:	89 d8                	mov    %ebx,%eax
80103b5a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103b5d:	c9                   	leave  
80103b5e:	c3                   	ret    
80103b5f:	90                   	nop
  release(&ptable.lock);
80103b60:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80103b63:	31 db                	xor    %ebx,%ebx
  release(&ptable.lock);
80103b65:	68 20 1d 11 80       	push   $0x80111d20
80103b6a:	e8 e1 0c 00 00       	call   80104850 <release>
}
80103b6f:	89 d8                	mov    %ebx,%eax
  return 0;
80103b71:	83 c4 10             	add    $0x10,%esp
}
80103b74:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103b77:	c9                   	leave  
80103b78:	c3                   	ret    
    p->state = UNUSED;
80103b79:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return 0;
80103b80:	31 db                	xor    %ebx,%ebx
}
80103b82:	89 d8                	mov    %ebx,%eax
80103b84:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103b87:	c9                   	leave  
80103b88:	c3                   	ret    
80103b89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103b90 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
80103b90:	55                   	push   %ebp
80103b91:	89 e5                	mov    %esp,%ebp
80103b93:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
80103b96:	68 20 1d 11 80       	push   $0x80111d20
80103b9b:	e8 b0 0c 00 00       	call   80104850 <release>

  if (first) {
80103ba0:	a1 00 a0 10 80       	mov    0x8010a000,%eax
80103ba5:	83 c4 10             	add    $0x10,%esp
80103ba8:	85 c0                	test   %eax,%eax
80103baa:	75 04                	jne    80103bb0 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
80103bac:	c9                   	leave  
80103bad:	c3                   	ret    
80103bae:	66 90                	xchg   %ax,%ax
    first = 0;
80103bb0:	c7 05 00 a0 10 80 00 	movl   $0x0,0x8010a000
80103bb7:	00 00 00 
    iinit(ROOTDEV);
80103bba:	83 ec 0c             	sub    $0xc,%esp
80103bbd:	6a 01                	push   $0x1
80103bbf:	e8 ac dc ff ff       	call   80101870 <iinit>
    initlog(ROOTDEV);
80103bc4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80103bcb:	e8 00 f4 ff ff       	call   80102fd0 <initlog>
}
80103bd0:	83 c4 10             	add    $0x10,%esp
80103bd3:	c9                   	leave  
80103bd4:	c3                   	ret    
80103bd5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103bdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103be0 <pinit>:
{
80103be0:	55                   	push   %ebp
80103be1:	89 e5                	mov    %esp,%ebp
80103be3:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
80103be6:	68 40 7a 10 80       	push   $0x80107a40
80103beb:	68 20 1d 11 80       	push   $0x80111d20
80103bf0:	e8 eb 0a 00 00       	call   801046e0 <initlock>
}
80103bf5:	83 c4 10             	add    $0x10,%esp
80103bf8:	c9                   	leave  
80103bf9:	c3                   	ret    
80103bfa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103c00 <mycpu>:
{
80103c00:	55                   	push   %ebp
80103c01:	89 e5                	mov    %esp,%ebp
80103c03:	56                   	push   %esi
80103c04:	53                   	push   %ebx
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103c05:	9c                   	pushf  
80103c06:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103c07:	f6 c4 02             	test   $0x2,%ah
80103c0a:	75 46                	jne    80103c52 <mycpu+0x52>
  apicid = lapicid();
80103c0c:	e8 ef ef ff ff       	call   80102c00 <lapicid>
  for (i = 0; i < ncpu; ++i) {
80103c11:	8b 35 84 17 11 80    	mov    0x80111784,%esi
80103c17:	85 f6                	test   %esi,%esi
80103c19:	7e 2a                	jle    80103c45 <mycpu+0x45>
80103c1b:	31 d2                	xor    %edx,%edx
80103c1d:	eb 08                	jmp    80103c27 <mycpu+0x27>
80103c1f:	90                   	nop
80103c20:	83 c2 01             	add    $0x1,%edx
80103c23:	39 f2                	cmp    %esi,%edx
80103c25:	74 1e                	je     80103c45 <mycpu+0x45>
    if (cpus[i].apicid == apicid)
80103c27:	69 ca b0 00 00 00    	imul   $0xb0,%edx,%ecx
80103c2d:	0f b6 99 a0 17 11 80 	movzbl -0x7feee860(%ecx),%ebx
80103c34:	39 c3                	cmp    %eax,%ebx
80103c36:	75 e8                	jne    80103c20 <mycpu+0x20>
}
80103c38:	8d 65 f8             	lea    -0x8(%ebp),%esp
      return &cpus[i];
80103c3b:	8d 81 a0 17 11 80    	lea    -0x7feee860(%ecx),%eax
}
80103c41:	5b                   	pop    %ebx
80103c42:	5e                   	pop    %esi
80103c43:	5d                   	pop    %ebp
80103c44:	c3                   	ret    
  panic("unknown apicid\n");
80103c45:	83 ec 0c             	sub    $0xc,%esp
80103c48:	68 47 7a 10 80       	push   $0x80107a47
80103c4d:	e8 2e c7 ff ff       	call   80100380 <panic>
    panic("mycpu called with interrupts enabled\n");
80103c52:	83 ec 0c             	sub    $0xc,%esp
80103c55:	68 24 7b 10 80       	push   $0x80107b24
80103c5a:	e8 21 c7 ff ff       	call   80100380 <panic>
80103c5f:	90                   	nop

80103c60 <cpuid>:
cpuid() {
80103c60:	55                   	push   %ebp
80103c61:	89 e5                	mov    %esp,%ebp
80103c63:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
80103c66:	e8 95 ff ff ff       	call   80103c00 <mycpu>
}
80103c6b:	c9                   	leave  
  return mycpu()-cpus;
80103c6c:	2d a0 17 11 80       	sub    $0x801117a0,%eax
80103c71:	c1 f8 04             	sar    $0x4,%eax
80103c74:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
80103c7a:	c3                   	ret    
80103c7b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103c7f:	90                   	nop

80103c80 <myproc>:
myproc(void) {
80103c80:	55                   	push   %ebp
80103c81:	89 e5                	mov    %esp,%ebp
80103c83:	53                   	push   %ebx
80103c84:	83 ec 04             	sub    $0x4,%esp
  pushcli();
80103c87:	e8 d4 0a 00 00       	call   80104760 <pushcli>
  c = mycpu();
80103c8c:	e8 6f ff ff ff       	call   80103c00 <mycpu>
  p = c->proc;
80103c91:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103c97:	e8 14 0b 00 00       	call   801047b0 <popcli>
}
80103c9c:	89 d8                	mov    %ebx,%eax
80103c9e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103ca1:	c9                   	leave  
80103ca2:	c3                   	ret    
80103ca3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103caa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103cb0 <userinit>:
{
80103cb0:	55                   	push   %ebp
80103cb1:	89 e5                	mov    %esp,%ebp
80103cb3:	53                   	push   %ebx
80103cb4:	83 ec 04             	sub    $0x4,%esp
  p = allocproc();
80103cb7:	e8 04 fe ff ff       	call   80103ac0 <allocproc>
80103cbc:	89 c3                	mov    %eax,%ebx
  initproc = p;
80103cbe:	a3 54 3c 11 80       	mov    %eax,0x80113c54
  if((p->pgdir = setupkvm()) == 0)
80103cc3:	e8 88 34 00 00       	call   80107150 <setupkvm>
80103cc8:	89 43 04             	mov    %eax,0x4(%ebx)
80103ccb:	85 c0                	test   %eax,%eax
80103ccd:	0f 84 bd 00 00 00    	je     80103d90 <userinit+0xe0>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80103cd3:	83 ec 04             	sub    $0x4,%esp
80103cd6:	68 2c 00 00 00       	push   $0x2c
80103cdb:	68 60 a4 10 80       	push   $0x8010a460
80103ce0:	50                   	push   %eax
80103ce1:	e8 1a 31 00 00       	call   80106e00 <inituvm>
  memset(p->tf, 0, sizeof(*p->tf));
80103ce6:	83 c4 0c             	add    $0xc,%esp
  p->sz = PGSIZE;
80103ce9:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
80103cef:	6a 4c                	push   $0x4c
80103cf1:	6a 00                	push   $0x0
80103cf3:	ff 73 18             	push   0x18(%ebx)
80103cf6:	e8 75 0c 00 00       	call   80104970 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103cfb:	8b 43 18             	mov    0x18(%ebx),%eax
80103cfe:	ba 1b 00 00 00       	mov    $0x1b,%edx
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103d03:	83 c4 0c             	add    $0xc,%esp
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103d06:	b9 23 00 00 00       	mov    $0x23,%ecx
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103d0b:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103d0f:	8b 43 18             	mov    0x18(%ebx),%eax
80103d12:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
80103d16:	8b 43 18             	mov    0x18(%ebx),%eax
80103d19:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103d1d:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80103d21:	8b 43 18             	mov    0x18(%ebx),%eax
80103d24:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103d28:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
80103d2c:	8b 43 18             	mov    0x18(%ebx),%eax
80103d2f:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80103d36:	8b 43 18             	mov    0x18(%ebx),%eax
80103d39:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
80103d40:	8b 43 18             	mov    0x18(%ebx),%eax
80103d43:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103d4a:	8d 43 6c             	lea    0x6c(%ebx),%eax
80103d4d:	6a 10                	push   $0x10
80103d4f:	68 70 7a 10 80       	push   $0x80107a70
80103d54:	50                   	push   %eax
80103d55:	e8 d6 0d 00 00       	call   80104b30 <safestrcpy>
  p->cwd = namei("/");
80103d5a:	c7 04 24 79 7a 10 80 	movl   $0x80107a79,(%esp)
80103d61:	e8 4a e6 ff ff       	call   801023b0 <namei>
80103d66:	89 43 68             	mov    %eax,0x68(%ebx)
  acquire(&ptable.lock);
80103d69:	c7 04 24 20 1d 11 80 	movl   $0x80111d20,(%esp)
80103d70:	e8 3b 0b 00 00       	call   801048b0 <acquire>
  p->state = RUNNABLE;
80103d75:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
80103d7c:	c7 04 24 20 1d 11 80 	movl   $0x80111d20,(%esp)
80103d83:	e8 c8 0a 00 00       	call   80104850 <release>
}
80103d88:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103d8b:	83 c4 10             	add    $0x10,%esp
80103d8e:	c9                   	leave  
80103d8f:	c3                   	ret    
    panic("userinit: out of memory?");
80103d90:	83 ec 0c             	sub    $0xc,%esp
80103d93:	68 57 7a 10 80       	push   $0x80107a57
80103d98:	e8 e3 c5 ff ff       	call   80100380 <panic>
80103d9d:	8d 76 00             	lea    0x0(%esi),%esi

80103da0 <growproc>:
{
80103da0:	55                   	push   %ebp
80103da1:	89 e5                	mov    %esp,%ebp
80103da3:	56                   	push   %esi
80103da4:	53                   	push   %ebx
80103da5:	8b 75 08             	mov    0x8(%ebp),%esi
  pushcli();
80103da8:	e8 b3 09 00 00       	call   80104760 <pushcli>
  c = mycpu();
80103dad:	e8 4e fe ff ff       	call   80103c00 <mycpu>
  p = c->proc;
80103db2:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103db8:	e8 f3 09 00 00       	call   801047b0 <popcli>
  sz = curproc->sz;
80103dbd:	8b 03                	mov    (%ebx),%eax
  if(n > 0){
80103dbf:	85 f6                	test   %esi,%esi
80103dc1:	7f 1d                	jg     80103de0 <growproc+0x40>
  } else if(n < 0){
80103dc3:	75 3b                	jne    80103e00 <growproc+0x60>
  switchuvm(curproc);
80103dc5:	83 ec 0c             	sub    $0xc,%esp
  curproc->sz = sz;
80103dc8:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
80103dca:	53                   	push   %ebx
80103dcb:	e8 20 2f 00 00       	call   80106cf0 <switchuvm>
  return 0;
80103dd0:	83 c4 10             	add    $0x10,%esp
80103dd3:	31 c0                	xor    %eax,%eax
}
80103dd5:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103dd8:	5b                   	pop    %ebx
80103dd9:	5e                   	pop    %esi
80103dda:	5d                   	pop    %ebp
80103ddb:	c3                   	ret    
80103ddc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103de0:	83 ec 04             	sub    $0x4,%esp
80103de3:	01 c6                	add    %eax,%esi
80103de5:	56                   	push   %esi
80103de6:	50                   	push   %eax
80103de7:	ff 73 04             	push   0x4(%ebx)
80103dea:	e8 81 31 00 00       	call   80106f70 <allocuvm>
80103def:	83 c4 10             	add    $0x10,%esp
80103df2:	85 c0                	test   %eax,%eax
80103df4:	75 cf                	jne    80103dc5 <growproc+0x25>
      return -1;
80103df6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103dfb:	eb d8                	jmp    80103dd5 <growproc+0x35>
80103dfd:	8d 76 00             	lea    0x0(%esi),%esi
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103e00:	83 ec 04             	sub    $0x4,%esp
80103e03:	01 c6                	add    %eax,%esi
80103e05:	56                   	push   %esi
80103e06:	50                   	push   %eax
80103e07:	ff 73 04             	push   0x4(%ebx)
80103e0a:	e8 91 32 00 00       	call   801070a0 <deallocuvm>
80103e0f:	83 c4 10             	add    $0x10,%esp
80103e12:	85 c0                	test   %eax,%eax
80103e14:	75 af                	jne    80103dc5 <growproc+0x25>
80103e16:	eb de                	jmp    80103df6 <growproc+0x56>
80103e18:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103e1f:	90                   	nop

80103e20 <fork>:
{
80103e20:	55                   	push   %ebp
80103e21:	89 e5                	mov    %esp,%ebp
80103e23:	57                   	push   %edi
80103e24:	56                   	push   %esi
80103e25:	53                   	push   %ebx
80103e26:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
80103e29:	e8 32 09 00 00       	call   80104760 <pushcli>
  c = mycpu();
80103e2e:	e8 cd fd ff ff       	call   80103c00 <mycpu>
  p = c->proc;
80103e33:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103e39:	e8 72 09 00 00       	call   801047b0 <popcli>
  if((np = allocproc()) == 0){
80103e3e:	e8 7d fc ff ff       	call   80103ac0 <allocproc>
80103e43:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103e46:	85 c0                	test   %eax,%eax
80103e48:	0f 84 b7 00 00 00    	je     80103f05 <fork+0xe5>
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
80103e4e:	83 ec 08             	sub    $0x8,%esp
80103e51:	ff 33                	push   (%ebx)
80103e53:	89 c7                	mov    %eax,%edi
80103e55:	ff 73 04             	push   0x4(%ebx)
80103e58:	e8 e3 33 00 00       	call   80107240 <copyuvm>
80103e5d:	83 c4 10             	add    $0x10,%esp
80103e60:	89 47 04             	mov    %eax,0x4(%edi)
80103e63:	85 c0                	test   %eax,%eax
80103e65:	0f 84 a1 00 00 00    	je     80103f0c <fork+0xec>
  np->sz = curproc->sz;
80103e6b:	8b 03                	mov    (%ebx),%eax
80103e6d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80103e70:	89 01                	mov    %eax,(%ecx)
  *np->tf = *curproc->tf;
80103e72:	8b 79 18             	mov    0x18(%ecx),%edi
  np->parent = curproc;
80103e75:	89 c8                	mov    %ecx,%eax
80103e77:	89 59 14             	mov    %ebx,0x14(%ecx)
  *np->tf = *curproc->tf;
80103e7a:	b9 13 00 00 00       	mov    $0x13,%ecx
80103e7f:	8b 73 18             	mov    0x18(%ebx),%esi
80103e82:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  for(i = 0; i < NOFILE; i++)
80103e84:	31 f6                	xor    %esi,%esi
  np->tf->eax = 0;
80103e86:	8b 40 18             	mov    0x18(%eax),%eax
80103e89:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
    if(curproc->ofile[i])
80103e90:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
80103e94:	85 c0                	test   %eax,%eax
80103e96:	74 13                	je     80103eab <fork+0x8b>
      np->ofile[i] = filedup(curproc->ofile[i]);
80103e98:	83 ec 0c             	sub    $0xc,%esp
80103e9b:	50                   	push   %eax
80103e9c:	e8 0f d3 ff ff       	call   801011b0 <filedup>
80103ea1:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103ea4:	83 c4 10             	add    $0x10,%esp
80103ea7:	89 44 b2 28          	mov    %eax,0x28(%edx,%esi,4)
  for(i = 0; i < NOFILE; i++)
80103eab:	83 c6 01             	add    $0x1,%esi
80103eae:	83 fe 10             	cmp    $0x10,%esi
80103eb1:	75 dd                	jne    80103e90 <fork+0x70>
  np->cwd = idup(curproc->cwd);
80103eb3:	83 ec 0c             	sub    $0xc,%esp
80103eb6:	ff 73 68             	push   0x68(%ebx)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103eb9:	83 c3 6c             	add    $0x6c,%ebx
  np->cwd = idup(curproc->cwd);
80103ebc:	e8 9f db ff ff       	call   80101a60 <idup>
80103ec1:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103ec4:	83 c4 0c             	add    $0xc,%esp
  np->cwd = idup(curproc->cwd);
80103ec7:	89 47 68             	mov    %eax,0x68(%edi)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103eca:	8d 47 6c             	lea    0x6c(%edi),%eax
80103ecd:	6a 10                	push   $0x10
80103ecf:	53                   	push   %ebx
80103ed0:	50                   	push   %eax
80103ed1:	e8 5a 0c 00 00       	call   80104b30 <safestrcpy>
  pid = np->pid;
80103ed6:	8b 5f 10             	mov    0x10(%edi),%ebx
  acquire(&ptable.lock);
80103ed9:	c7 04 24 20 1d 11 80 	movl   $0x80111d20,(%esp)
80103ee0:	e8 cb 09 00 00       	call   801048b0 <acquire>
  np->state = RUNNABLE;
80103ee5:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)
  release(&ptable.lock);
80103eec:	c7 04 24 20 1d 11 80 	movl   $0x80111d20,(%esp)
80103ef3:	e8 58 09 00 00       	call   80104850 <release>
  return pid;
80103ef8:	83 c4 10             	add    $0x10,%esp
}
80103efb:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103efe:	89 d8                	mov    %ebx,%eax
80103f00:	5b                   	pop    %ebx
80103f01:	5e                   	pop    %esi
80103f02:	5f                   	pop    %edi
80103f03:	5d                   	pop    %ebp
80103f04:	c3                   	ret    
    return -1;
80103f05:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80103f0a:	eb ef                	jmp    80103efb <fork+0xdb>
    kfree(np->kstack);
80103f0c:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80103f0f:	83 ec 0c             	sub    $0xc,%esp
80103f12:	ff 73 08             	push   0x8(%ebx)
80103f15:	e8 b6 e8 ff ff       	call   801027d0 <kfree>
    np->kstack = 0;
80103f1a:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
    return -1;
80103f21:	83 c4 10             	add    $0x10,%esp
    np->state = UNUSED;
80103f24:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return -1;
80103f2b:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80103f30:	eb c9                	jmp    80103efb <fork+0xdb>
80103f32:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103f39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103f40 <scheduler>:
{
80103f40:	55                   	push   %ebp
80103f41:	89 e5                	mov    %esp,%ebp
80103f43:	57                   	push   %edi
80103f44:	56                   	push   %esi
80103f45:	53                   	push   %ebx
80103f46:	83 ec 0c             	sub    $0xc,%esp
  struct cpu *c = mycpu();
80103f49:	e8 b2 fc ff ff       	call   80103c00 <mycpu>
  c->proc = 0;
80103f4e:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80103f55:	00 00 00 
  struct cpu *c = mycpu();
80103f58:	89 c6                	mov    %eax,%esi
  c->proc = 0;
80103f5a:	8d 78 04             	lea    0x4(%eax),%edi
80103f5d:	8d 76 00             	lea    0x0(%esi),%esi
  asm volatile("sti");
80103f60:	fb                   	sti    
    acquire(&ptable.lock);
80103f61:	83 ec 0c             	sub    $0xc,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103f64:	bb 54 1d 11 80       	mov    $0x80111d54,%ebx
    acquire(&ptable.lock);
80103f69:	68 20 1d 11 80       	push   $0x80111d20
80103f6e:	e8 3d 09 00 00       	call   801048b0 <acquire>
80103f73:	83 c4 10             	add    $0x10,%esp
80103f76:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103f7d:	8d 76 00             	lea    0x0(%esi),%esi
      if(p->state != RUNNABLE)
80103f80:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
80103f84:	75 33                	jne    80103fb9 <scheduler+0x79>
      switchuvm(p);
80103f86:	83 ec 0c             	sub    $0xc,%esp
      c->proc = p;
80103f89:	89 9e ac 00 00 00    	mov    %ebx,0xac(%esi)
      switchuvm(p);
80103f8f:	53                   	push   %ebx
80103f90:	e8 5b 2d 00 00       	call   80106cf0 <switchuvm>
      swtch(&(c->scheduler), p->context);
80103f95:	58                   	pop    %eax
80103f96:	5a                   	pop    %edx
80103f97:	ff 73 1c             	push   0x1c(%ebx)
80103f9a:	57                   	push   %edi
      p->state = RUNNING;
80103f9b:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
      swtch(&(c->scheduler), p->context);
80103fa2:	e8 e4 0b 00 00       	call   80104b8b <swtch>
      switchkvm();
80103fa7:	e8 34 2d 00 00       	call   80106ce0 <switchkvm>
      c->proc = 0;
80103fac:	83 c4 10             	add    $0x10,%esp
80103faf:	c7 86 ac 00 00 00 00 	movl   $0x0,0xac(%esi)
80103fb6:	00 00 00 
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103fb9:	83 c3 7c             	add    $0x7c,%ebx
80103fbc:	81 fb 54 3c 11 80    	cmp    $0x80113c54,%ebx
80103fc2:	75 bc                	jne    80103f80 <scheduler+0x40>
    release(&ptable.lock);
80103fc4:	83 ec 0c             	sub    $0xc,%esp
80103fc7:	68 20 1d 11 80       	push   $0x80111d20
80103fcc:	e8 7f 08 00 00       	call   80104850 <release>
    sti();
80103fd1:	83 c4 10             	add    $0x10,%esp
80103fd4:	eb 8a                	jmp    80103f60 <scheduler+0x20>
80103fd6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103fdd:	8d 76 00             	lea    0x0(%esi),%esi

80103fe0 <sched>:
{
80103fe0:	55                   	push   %ebp
80103fe1:	89 e5                	mov    %esp,%ebp
80103fe3:	56                   	push   %esi
80103fe4:	53                   	push   %ebx
  pushcli();
80103fe5:	e8 76 07 00 00       	call   80104760 <pushcli>
  c = mycpu();
80103fea:	e8 11 fc ff ff       	call   80103c00 <mycpu>
  p = c->proc;
80103fef:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103ff5:	e8 b6 07 00 00       	call   801047b0 <popcli>
  if(!holding(&ptable.lock))
80103ffa:	83 ec 0c             	sub    $0xc,%esp
80103ffd:	68 20 1d 11 80       	push   $0x80111d20
80104002:	e8 09 08 00 00       	call   80104810 <holding>
80104007:	83 c4 10             	add    $0x10,%esp
8010400a:	85 c0                	test   %eax,%eax
8010400c:	74 4f                	je     8010405d <sched+0x7d>
  if(mycpu()->ncli != 1)
8010400e:	e8 ed fb ff ff       	call   80103c00 <mycpu>
80104013:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
8010401a:	75 68                	jne    80104084 <sched+0xa4>
  if(p->state == RUNNING)
8010401c:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
80104020:	74 55                	je     80104077 <sched+0x97>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104022:	9c                   	pushf  
80104023:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104024:	f6 c4 02             	test   $0x2,%ah
80104027:	75 41                	jne    8010406a <sched+0x8a>
  intena = mycpu()->intena;
80104029:	e8 d2 fb ff ff       	call   80103c00 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
8010402e:	83 c3 1c             	add    $0x1c,%ebx
  intena = mycpu()->intena;
80104031:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
80104037:	e8 c4 fb ff ff       	call   80103c00 <mycpu>
8010403c:	83 ec 08             	sub    $0x8,%esp
8010403f:	ff 70 04             	push   0x4(%eax)
80104042:	53                   	push   %ebx
80104043:	e8 43 0b 00 00       	call   80104b8b <swtch>
  mycpu()->intena = intena;
80104048:	e8 b3 fb ff ff       	call   80103c00 <mycpu>
}
8010404d:	83 c4 10             	add    $0x10,%esp
  mycpu()->intena = intena;
80104050:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80104056:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104059:	5b                   	pop    %ebx
8010405a:	5e                   	pop    %esi
8010405b:	5d                   	pop    %ebp
8010405c:	c3                   	ret    
    panic("sched ptable.lock");
8010405d:	83 ec 0c             	sub    $0xc,%esp
80104060:	68 7b 7a 10 80       	push   $0x80107a7b
80104065:	e8 16 c3 ff ff       	call   80100380 <panic>
    panic("sched interruptible");
8010406a:	83 ec 0c             	sub    $0xc,%esp
8010406d:	68 a7 7a 10 80       	push   $0x80107aa7
80104072:	e8 09 c3 ff ff       	call   80100380 <panic>
    panic("sched running");
80104077:	83 ec 0c             	sub    $0xc,%esp
8010407a:	68 99 7a 10 80       	push   $0x80107a99
8010407f:	e8 fc c2 ff ff       	call   80100380 <panic>
    panic("sched locks");
80104084:	83 ec 0c             	sub    $0xc,%esp
80104087:	68 8d 7a 10 80       	push   $0x80107a8d
8010408c:	e8 ef c2 ff ff       	call   80100380 <panic>
80104091:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104098:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010409f:	90                   	nop

801040a0 <exit>:
{
801040a0:	55                   	push   %ebp
801040a1:	89 e5                	mov    %esp,%ebp
801040a3:	57                   	push   %edi
801040a4:	56                   	push   %esi
801040a5:	53                   	push   %ebx
801040a6:	83 ec 0c             	sub    $0xc,%esp
  struct proc *curproc = myproc();
801040a9:	e8 d2 fb ff ff       	call   80103c80 <myproc>
  if(curproc == initproc)
801040ae:	39 05 54 3c 11 80    	cmp    %eax,0x80113c54
801040b4:	0f 84 fd 00 00 00    	je     801041b7 <exit+0x117>
801040ba:	89 c3                	mov    %eax,%ebx
801040bc:	8d 70 28             	lea    0x28(%eax),%esi
801040bf:	8d 78 68             	lea    0x68(%eax),%edi
801040c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(curproc->ofile[fd]){
801040c8:	8b 06                	mov    (%esi),%eax
801040ca:	85 c0                	test   %eax,%eax
801040cc:	74 12                	je     801040e0 <exit+0x40>
      fileclose(curproc->ofile[fd]);
801040ce:	83 ec 0c             	sub    $0xc,%esp
801040d1:	50                   	push   %eax
801040d2:	e8 29 d1 ff ff       	call   80101200 <fileclose>
      curproc->ofile[fd] = 0;
801040d7:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
801040dd:	83 c4 10             	add    $0x10,%esp
  for(fd = 0; fd < NOFILE; fd++){
801040e0:	83 c6 04             	add    $0x4,%esi
801040e3:	39 f7                	cmp    %esi,%edi
801040e5:	75 e1                	jne    801040c8 <exit+0x28>
  begin_op();
801040e7:	e8 84 ef ff ff       	call   80103070 <begin_op>
  iput(curproc->cwd);
801040ec:	83 ec 0c             	sub    $0xc,%esp
801040ef:	ff 73 68             	push   0x68(%ebx)
801040f2:	e8 c9 da ff ff       	call   80101bc0 <iput>
  end_op();
801040f7:	e8 e4 ef ff ff       	call   801030e0 <end_op>
  curproc->cwd = 0;
801040fc:	c7 43 68 00 00 00 00 	movl   $0x0,0x68(%ebx)
  acquire(&ptable.lock);
80104103:	c7 04 24 20 1d 11 80 	movl   $0x80111d20,(%esp)
8010410a:	e8 a1 07 00 00       	call   801048b0 <acquire>
  wakeup1(curproc->parent);
8010410f:	8b 53 14             	mov    0x14(%ebx),%edx
80104112:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104115:	b8 54 1d 11 80       	mov    $0x80111d54,%eax
8010411a:	eb 0e                	jmp    8010412a <exit+0x8a>
8010411c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104120:	83 c0 7c             	add    $0x7c,%eax
80104123:	3d 54 3c 11 80       	cmp    $0x80113c54,%eax
80104128:	74 1c                	je     80104146 <exit+0xa6>
    if(p->state == SLEEPING && p->chan == chan)
8010412a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
8010412e:	75 f0                	jne    80104120 <exit+0x80>
80104130:	3b 50 20             	cmp    0x20(%eax),%edx
80104133:	75 eb                	jne    80104120 <exit+0x80>
      p->state = RUNNABLE;
80104135:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010413c:	83 c0 7c             	add    $0x7c,%eax
8010413f:	3d 54 3c 11 80       	cmp    $0x80113c54,%eax
80104144:	75 e4                	jne    8010412a <exit+0x8a>
      p->parent = initproc;
80104146:	8b 0d 54 3c 11 80    	mov    0x80113c54,%ecx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010414c:	ba 54 1d 11 80       	mov    $0x80111d54,%edx
80104151:	eb 10                	jmp    80104163 <exit+0xc3>
80104153:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104157:	90                   	nop
80104158:	83 c2 7c             	add    $0x7c,%edx
8010415b:	81 fa 54 3c 11 80    	cmp    $0x80113c54,%edx
80104161:	74 3b                	je     8010419e <exit+0xfe>
    if(p->parent == curproc){
80104163:	39 5a 14             	cmp    %ebx,0x14(%edx)
80104166:	75 f0                	jne    80104158 <exit+0xb8>
      if(p->state == ZOMBIE)
80104168:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
      p->parent = initproc;
8010416c:	89 4a 14             	mov    %ecx,0x14(%edx)
      if(p->state == ZOMBIE)
8010416f:	75 e7                	jne    80104158 <exit+0xb8>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104171:	b8 54 1d 11 80       	mov    $0x80111d54,%eax
80104176:	eb 12                	jmp    8010418a <exit+0xea>
80104178:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010417f:	90                   	nop
80104180:	83 c0 7c             	add    $0x7c,%eax
80104183:	3d 54 3c 11 80       	cmp    $0x80113c54,%eax
80104188:	74 ce                	je     80104158 <exit+0xb8>
    if(p->state == SLEEPING && p->chan == chan)
8010418a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
8010418e:	75 f0                	jne    80104180 <exit+0xe0>
80104190:	3b 48 20             	cmp    0x20(%eax),%ecx
80104193:	75 eb                	jne    80104180 <exit+0xe0>
      p->state = RUNNABLE;
80104195:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
8010419c:	eb e2                	jmp    80104180 <exit+0xe0>
  curproc->state = ZOMBIE;
8010419e:	c7 43 0c 05 00 00 00 	movl   $0x5,0xc(%ebx)
  sched();
801041a5:	e8 36 fe ff ff       	call   80103fe0 <sched>
  panic("zombie exit");
801041aa:	83 ec 0c             	sub    $0xc,%esp
801041ad:	68 c8 7a 10 80       	push   $0x80107ac8
801041b2:	e8 c9 c1 ff ff       	call   80100380 <panic>
    panic("init exiting");
801041b7:	83 ec 0c             	sub    $0xc,%esp
801041ba:	68 bb 7a 10 80       	push   $0x80107abb
801041bf:	e8 bc c1 ff ff       	call   80100380 <panic>
801041c4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801041cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801041cf:	90                   	nop

801041d0 <wait>:
{
801041d0:	55                   	push   %ebp
801041d1:	89 e5                	mov    %esp,%ebp
801041d3:	56                   	push   %esi
801041d4:	53                   	push   %ebx
  pushcli();
801041d5:	e8 86 05 00 00       	call   80104760 <pushcli>
  c = mycpu();
801041da:	e8 21 fa ff ff       	call   80103c00 <mycpu>
  p = c->proc;
801041df:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
801041e5:	e8 c6 05 00 00       	call   801047b0 <popcli>
  acquire(&ptable.lock);
801041ea:	83 ec 0c             	sub    $0xc,%esp
801041ed:	68 20 1d 11 80       	push   $0x80111d20
801041f2:	e8 b9 06 00 00       	call   801048b0 <acquire>
801041f7:	83 c4 10             	add    $0x10,%esp
    havekids = 0;
801041fa:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801041fc:	bb 54 1d 11 80       	mov    $0x80111d54,%ebx
80104201:	eb 10                	jmp    80104213 <wait+0x43>
80104203:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104207:	90                   	nop
80104208:	83 c3 7c             	add    $0x7c,%ebx
8010420b:	81 fb 54 3c 11 80    	cmp    $0x80113c54,%ebx
80104211:	74 1b                	je     8010422e <wait+0x5e>
      if(p->parent != curproc)
80104213:	39 73 14             	cmp    %esi,0x14(%ebx)
80104216:	75 f0                	jne    80104208 <wait+0x38>
      if(p->state == ZOMBIE){
80104218:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
8010421c:	74 62                	je     80104280 <wait+0xb0>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010421e:	83 c3 7c             	add    $0x7c,%ebx
      havekids = 1;
80104221:	b8 01 00 00 00       	mov    $0x1,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104226:	81 fb 54 3c 11 80    	cmp    $0x80113c54,%ebx
8010422c:	75 e5                	jne    80104213 <wait+0x43>
    if(!havekids || curproc->killed){
8010422e:	85 c0                	test   %eax,%eax
80104230:	0f 84 a0 00 00 00    	je     801042d6 <wait+0x106>
80104236:	8b 46 24             	mov    0x24(%esi),%eax
80104239:	85 c0                	test   %eax,%eax
8010423b:	0f 85 95 00 00 00    	jne    801042d6 <wait+0x106>
  pushcli();
80104241:	e8 1a 05 00 00       	call   80104760 <pushcli>
  c = mycpu();
80104246:	e8 b5 f9 ff ff       	call   80103c00 <mycpu>
  p = c->proc;
8010424b:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104251:	e8 5a 05 00 00       	call   801047b0 <popcli>
  if(p == 0)
80104256:	85 db                	test   %ebx,%ebx
80104258:	0f 84 8f 00 00 00    	je     801042ed <wait+0x11d>
  p->chan = chan;
8010425e:	89 73 20             	mov    %esi,0x20(%ebx)
  p->state = SLEEPING;
80104261:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80104268:	e8 73 fd ff ff       	call   80103fe0 <sched>
  p->chan = 0;
8010426d:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
80104274:	eb 84                	jmp    801041fa <wait+0x2a>
80104276:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010427d:	8d 76 00             	lea    0x0(%esi),%esi
        kfree(p->kstack);
80104280:	83 ec 0c             	sub    $0xc,%esp
        pid = p->pid;
80104283:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80104286:	ff 73 08             	push   0x8(%ebx)
80104289:	e8 42 e5 ff ff       	call   801027d0 <kfree>
        p->kstack = 0;
8010428e:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80104295:	5a                   	pop    %edx
80104296:	ff 73 04             	push   0x4(%ebx)
80104299:	e8 32 2e 00 00       	call   801070d0 <freevm>
        p->pid = 0;
8010429e:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
801042a5:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
801042ac:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
801042b0:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
801042b7:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
801042be:	c7 04 24 20 1d 11 80 	movl   $0x80111d20,(%esp)
801042c5:	e8 86 05 00 00       	call   80104850 <release>
        return pid;
801042ca:	83 c4 10             	add    $0x10,%esp
}
801042cd:	8d 65 f8             	lea    -0x8(%ebp),%esp
801042d0:	89 f0                	mov    %esi,%eax
801042d2:	5b                   	pop    %ebx
801042d3:	5e                   	pop    %esi
801042d4:	5d                   	pop    %ebp
801042d5:	c3                   	ret    
      release(&ptable.lock);
801042d6:	83 ec 0c             	sub    $0xc,%esp
      return -1;
801042d9:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
801042de:	68 20 1d 11 80       	push   $0x80111d20
801042e3:	e8 68 05 00 00       	call   80104850 <release>
      return -1;
801042e8:	83 c4 10             	add    $0x10,%esp
801042eb:	eb e0                	jmp    801042cd <wait+0xfd>
    panic("sleep");
801042ed:	83 ec 0c             	sub    $0xc,%esp
801042f0:	68 d4 7a 10 80       	push   $0x80107ad4
801042f5:	e8 86 c0 ff ff       	call   80100380 <panic>
801042fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104300 <yield>:
{
80104300:	55                   	push   %ebp
80104301:	89 e5                	mov    %esp,%ebp
80104303:	53                   	push   %ebx
80104304:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80104307:	68 20 1d 11 80       	push   $0x80111d20
8010430c:	e8 9f 05 00 00       	call   801048b0 <acquire>
  pushcli();
80104311:	e8 4a 04 00 00       	call   80104760 <pushcli>
  c = mycpu();
80104316:	e8 e5 f8 ff ff       	call   80103c00 <mycpu>
  p = c->proc;
8010431b:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104321:	e8 8a 04 00 00       	call   801047b0 <popcli>
  myproc()->state = RUNNABLE;
80104326:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  sched();
8010432d:	e8 ae fc ff ff       	call   80103fe0 <sched>
  release(&ptable.lock);
80104332:	c7 04 24 20 1d 11 80 	movl   $0x80111d20,(%esp)
80104339:	e8 12 05 00 00       	call   80104850 <release>
}
8010433e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104341:	83 c4 10             	add    $0x10,%esp
80104344:	c9                   	leave  
80104345:	c3                   	ret    
80104346:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010434d:	8d 76 00             	lea    0x0(%esi),%esi

80104350 <sleep>:
{
80104350:	55                   	push   %ebp
80104351:	89 e5                	mov    %esp,%ebp
80104353:	57                   	push   %edi
80104354:	56                   	push   %esi
80104355:	53                   	push   %ebx
80104356:	83 ec 0c             	sub    $0xc,%esp
80104359:	8b 7d 08             	mov    0x8(%ebp),%edi
8010435c:	8b 75 0c             	mov    0xc(%ebp),%esi
  pushcli();
8010435f:	e8 fc 03 00 00       	call   80104760 <pushcli>
  c = mycpu();
80104364:	e8 97 f8 ff ff       	call   80103c00 <mycpu>
  p = c->proc;
80104369:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
8010436f:	e8 3c 04 00 00       	call   801047b0 <popcli>
  if(p == 0)
80104374:	85 db                	test   %ebx,%ebx
80104376:	0f 84 87 00 00 00    	je     80104403 <sleep+0xb3>
  if(lk == 0)
8010437c:	85 f6                	test   %esi,%esi
8010437e:	74 76                	je     801043f6 <sleep+0xa6>
  if(lk != &ptable.lock){  //DOC: sleeplock0
80104380:	81 fe 20 1d 11 80    	cmp    $0x80111d20,%esi
80104386:	74 50                	je     801043d8 <sleep+0x88>
    acquire(&ptable.lock);  //DOC: sleeplock1
80104388:	83 ec 0c             	sub    $0xc,%esp
8010438b:	68 20 1d 11 80       	push   $0x80111d20
80104390:	e8 1b 05 00 00       	call   801048b0 <acquire>
    release(lk);
80104395:	89 34 24             	mov    %esi,(%esp)
80104398:	e8 b3 04 00 00       	call   80104850 <release>
  p->chan = chan;
8010439d:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
801043a0:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
801043a7:	e8 34 fc ff ff       	call   80103fe0 <sched>
  p->chan = 0;
801043ac:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
    release(&ptable.lock);
801043b3:	c7 04 24 20 1d 11 80 	movl   $0x80111d20,(%esp)
801043ba:	e8 91 04 00 00       	call   80104850 <release>
    acquire(lk);
801043bf:	89 75 08             	mov    %esi,0x8(%ebp)
801043c2:	83 c4 10             	add    $0x10,%esp
}
801043c5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801043c8:	5b                   	pop    %ebx
801043c9:	5e                   	pop    %esi
801043ca:	5f                   	pop    %edi
801043cb:	5d                   	pop    %ebp
    acquire(lk);
801043cc:	e9 df 04 00 00       	jmp    801048b0 <acquire>
801043d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  p->chan = chan;
801043d8:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
801043db:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
801043e2:	e8 f9 fb ff ff       	call   80103fe0 <sched>
  p->chan = 0;
801043e7:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
801043ee:	8d 65 f4             	lea    -0xc(%ebp),%esp
801043f1:	5b                   	pop    %ebx
801043f2:	5e                   	pop    %esi
801043f3:	5f                   	pop    %edi
801043f4:	5d                   	pop    %ebp
801043f5:	c3                   	ret    
    panic("sleep without lk");
801043f6:	83 ec 0c             	sub    $0xc,%esp
801043f9:	68 da 7a 10 80       	push   $0x80107ada
801043fe:	e8 7d bf ff ff       	call   80100380 <panic>
    panic("sleep");
80104403:	83 ec 0c             	sub    $0xc,%esp
80104406:	68 d4 7a 10 80       	push   $0x80107ad4
8010440b:	e8 70 bf ff ff       	call   80100380 <panic>

80104410 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80104410:	55                   	push   %ebp
80104411:	89 e5                	mov    %esp,%ebp
80104413:	53                   	push   %ebx
80104414:	83 ec 10             	sub    $0x10,%esp
80104417:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
8010441a:	68 20 1d 11 80       	push   $0x80111d20
8010441f:	e8 8c 04 00 00       	call   801048b0 <acquire>
80104424:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104427:	b8 54 1d 11 80       	mov    $0x80111d54,%eax
8010442c:	eb 0c                	jmp    8010443a <wakeup+0x2a>
8010442e:	66 90                	xchg   %ax,%ax
80104430:	83 c0 7c             	add    $0x7c,%eax
80104433:	3d 54 3c 11 80       	cmp    $0x80113c54,%eax
80104438:	74 1c                	je     80104456 <wakeup+0x46>
    if(p->state == SLEEPING && p->chan == chan)
8010443a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
8010443e:	75 f0                	jne    80104430 <wakeup+0x20>
80104440:	3b 58 20             	cmp    0x20(%eax),%ebx
80104443:	75 eb                	jne    80104430 <wakeup+0x20>
      p->state = RUNNABLE;
80104445:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010444c:	83 c0 7c             	add    $0x7c,%eax
8010444f:	3d 54 3c 11 80       	cmp    $0x80113c54,%eax
80104454:	75 e4                	jne    8010443a <wakeup+0x2a>
  wakeup1(chan);
  release(&ptable.lock);
80104456:	c7 45 08 20 1d 11 80 	movl   $0x80111d20,0x8(%ebp)
}
8010445d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104460:	c9                   	leave  
  release(&ptable.lock);
80104461:	e9 ea 03 00 00       	jmp    80104850 <release>
80104466:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010446d:	8d 76 00             	lea    0x0(%esi),%esi

80104470 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80104470:	55                   	push   %ebp
80104471:	89 e5                	mov    %esp,%ebp
80104473:	53                   	push   %ebx
80104474:	83 ec 10             	sub    $0x10,%esp
80104477:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
8010447a:	68 20 1d 11 80       	push   $0x80111d20
8010447f:	e8 2c 04 00 00       	call   801048b0 <acquire>
80104484:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104487:	b8 54 1d 11 80       	mov    $0x80111d54,%eax
8010448c:	eb 0c                	jmp    8010449a <kill+0x2a>
8010448e:	66 90                	xchg   %ax,%ax
80104490:	83 c0 7c             	add    $0x7c,%eax
80104493:	3d 54 3c 11 80       	cmp    $0x80113c54,%eax
80104498:	74 36                	je     801044d0 <kill+0x60>
    if(p->pid == pid){
8010449a:	39 58 10             	cmp    %ebx,0x10(%eax)
8010449d:	75 f1                	jne    80104490 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
8010449f:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
      p->killed = 1;
801044a3:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      if(p->state == SLEEPING)
801044aa:	75 07                	jne    801044b3 <kill+0x43>
        p->state = RUNNABLE;
801044ac:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      release(&ptable.lock);
801044b3:	83 ec 0c             	sub    $0xc,%esp
801044b6:	68 20 1d 11 80       	push   $0x80111d20
801044bb:	e8 90 03 00 00       	call   80104850 <release>
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
}
801044c0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
      return 0;
801044c3:	83 c4 10             	add    $0x10,%esp
801044c6:	31 c0                	xor    %eax,%eax
}
801044c8:	c9                   	leave  
801044c9:	c3                   	ret    
801044ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  release(&ptable.lock);
801044d0:	83 ec 0c             	sub    $0xc,%esp
801044d3:	68 20 1d 11 80       	push   $0x80111d20
801044d8:	e8 73 03 00 00       	call   80104850 <release>
}
801044dd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return -1;
801044e0:	83 c4 10             	add    $0x10,%esp
801044e3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801044e8:	c9                   	leave  
801044e9:	c3                   	ret    
801044ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801044f0 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
801044f0:	55                   	push   %ebp
801044f1:	89 e5                	mov    %esp,%ebp
801044f3:	57                   	push   %edi
801044f4:	56                   	push   %esi
801044f5:	8d 75 e8             	lea    -0x18(%ebp),%esi
801044f8:	53                   	push   %ebx
801044f9:	bb c0 1d 11 80       	mov    $0x80111dc0,%ebx
801044fe:	83 ec 3c             	sub    $0x3c,%esp
80104501:	eb 24                	jmp    80104527 <procdump+0x37>
80104503:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104507:	90                   	nop
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80104508:	83 ec 0c             	sub    $0xc,%esp
8010450b:	68 57 7e 10 80       	push   $0x80107e57
80104510:	e8 1b c2 ff ff       	call   80100730 <cprintf>
80104515:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104518:	83 c3 7c             	add    $0x7c,%ebx
8010451b:	81 fb c0 3c 11 80    	cmp    $0x80113cc0,%ebx
80104521:	0f 84 81 00 00 00    	je     801045a8 <procdump+0xb8>
    if(p->state == UNUSED)
80104527:	8b 43 a0             	mov    -0x60(%ebx),%eax
8010452a:	85 c0                	test   %eax,%eax
8010452c:	74 ea                	je     80104518 <procdump+0x28>
      state = "???";
8010452e:	ba eb 7a 10 80       	mov    $0x80107aeb,%edx
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104533:	83 f8 05             	cmp    $0x5,%eax
80104536:	77 11                	ja     80104549 <procdump+0x59>
80104538:	8b 14 85 4c 7b 10 80 	mov    -0x7fef84b4(,%eax,4),%edx
      state = "???";
8010453f:	b8 eb 7a 10 80       	mov    $0x80107aeb,%eax
80104544:	85 d2                	test   %edx,%edx
80104546:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
80104549:	53                   	push   %ebx
8010454a:	52                   	push   %edx
8010454b:	ff 73 a4             	push   -0x5c(%ebx)
8010454e:	68 ef 7a 10 80       	push   $0x80107aef
80104553:	e8 d8 c1 ff ff       	call   80100730 <cprintf>
    if(p->state == SLEEPING){
80104558:	83 c4 10             	add    $0x10,%esp
8010455b:	83 7b a0 02          	cmpl   $0x2,-0x60(%ebx)
8010455f:	75 a7                	jne    80104508 <procdump+0x18>
      getcallerpcs((uint*)p->context->ebp+2, pc);
80104561:	83 ec 08             	sub    $0x8,%esp
80104564:	8d 45 c0             	lea    -0x40(%ebp),%eax
80104567:	8d 7d c0             	lea    -0x40(%ebp),%edi
8010456a:	50                   	push   %eax
8010456b:	8b 43 b0             	mov    -0x50(%ebx),%eax
8010456e:	8b 40 0c             	mov    0xc(%eax),%eax
80104571:	83 c0 08             	add    $0x8,%eax
80104574:	50                   	push   %eax
80104575:	e8 86 01 00 00       	call   80104700 <getcallerpcs>
      for(i=0; i<10 && pc[i] != 0; i++)
8010457a:	83 c4 10             	add    $0x10,%esp
8010457d:	8d 76 00             	lea    0x0(%esi),%esi
80104580:	8b 17                	mov    (%edi),%edx
80104582:	85 d2                	test   %edx,%edx
80104584:	74 82                	je     80104508 <procdump+0x18>
        cprintf(" %p", pc[i]);
80104586:	83 ec 08             	sub    $0x8,%esp
      for(i=0; i<10 && pc[i] != 0; i++)
80104589:	83 c7 04             	add    $0x4,%edi
        cprintf(" %p", pc[i]);
8010458c:	52                   	push   %edx
8010458d:	68 e1 74 10 80       	push   $0x801074e1
80104592:	e8 99 c1 ff ff       	call   80100730 <cprintf>
      for(i=0; i<10 && pc[i] != 0; i++)
80104597:	83 c4 10             	add    $0x10,%esp
8010459a:	39 fe                	cmp    %edi,%esi
8010459c:	75 e2                	jne    80104580 <procdump+0x90>
8010459e:	e9 65 ff ff ff       	jmp    80104508 <procdump+0x18>
801045a3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801045a7:	90                   	nop
  }
}
801045a8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801045ab:	5b                   	pop    %ebx
801045ac:	5e                   	pop    %esi
801045ad:	5f                   	pop    %edi
801045ae:	5d                   	pop    %ebp
801045af:	c3                   	ret    

801045b0 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
801045b0:	55                   	push   %ebp
801045b1:	89 e5                	mov    %esp,%ebp
801045b3:	53                   	push   %ebx
801045b4:	83 ec 0c             	sub    $0xc,%esp
801045b7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
801045ba:	68 64 7b 10 80       	push   $0x80107b64
801045bf:	8d 43 04             	lea    0x4(%ebx),%eax
801045c2:	50                   	push   %eax
801045c3:	e8 18 01 00 00       	call   801046e0 <initlock>
  lk->name = name;
801045c8:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
801045cb:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
801045d1:	83 c4 10             	add    $0x10,%esp
  lk->pid = 0;
801045d4:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
801045db:	89 43 38             	mov    %eax,0x38(%ebx)
}
801045de:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801045e1:	c9                   	leave  
801045e2:	c3                   	ret    
801045e3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801045ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801045f0 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
801045f0:	55                   	push   %ebp
801045f1:	89 e5                	mov    %esp,%ebp
801045f3:	56                   	push   %esi
801045f4:	53                   	push   %ebx
801045f5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
801045f8:	8d 73 04             	lea    0x4(%ebx),%esi
801045fb:	83 ec 0c             	sub    $0xc,%esp
801045fe:	56                   	push   %esi
801045ff:	e8 ac 02 00 00       	call   801048b0 <acquire>
  while (lk->locked) {
80104604:	8b 13                	mov    (%ebx),%edx
80104606:	83 c4 10             	add    $0x10,%esp
80104609:	85 d2                	test   %edx,%edx
8010460b:	74 16                	je     80104623 <acquiresleep+0x33>
8010460d:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
80104610:	83 ec 08             	sub    $0x8,%esp
80104613:	56                   	push   %esi
80104614:	53                   	push   %ebx
80104615:	e8 36 fd ff ff       	call   80104350 <sleep>
  while (lk->locked) {
8010461a:	8b 03                	mov    (%ebx),%eax
8010461c:	83 c4 10             	add    $0x10,%esp
8010461f:	85 c0                	test   %eax,%eax
80104621:	75 ed                	jne    80104610 <acquiresleep+0x20>
  }
  lk->locked = 1;
80104623:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
80104629:	e8 52 f6 ff ff       	call   80103c80 <myproc>
8010462e:	8b 40 10             	mov    0x10(%eax),%eax
80104631:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
80104634:	89 75 08             	mov    %esi,0x8(%ebp)
}
80104637:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010463a:	5b                   	pop    %ebx
8010463b:	5e                   	pop    %esi
8010463c:	5d                   	pop    %ebp
  release(&lk->lk);
8010463d:	e9 0e 02 00 00       	jmp    80104850 <release>
80104642:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104649:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104650 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
80104650:	55                   	push   %ebp
80104651:	89 e5                	mov    %esp,%ebp
80104653:	56                   	push   %esi
80104654:	53                   	push   %ebx
80104655:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104658:	8d 73 04             	lea    0x4(%ebx),%esi
8010465b:	83 ec 0c             	sub    $0xc,%esp
8010465e:	56                   	push   %esi
8010465f:	e8 4c 02 00 00       	call   801048b0 <acquire>
  lk->locked = 0;
80104664:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
8010466a:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
80104671:	89 1c 24             	mov    %ebx,(%esp)
80104674:	e8 97 fd ff ff       	call   80104410 <wakeup>
  release(&lk->lk);
80104679:	89 75 08             	mov    %esi,0x8(%ebp)
8010467c:	83 c4 10             	add    $0x10,%esp
}
8010467f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104682:	5b                   	pop    %ebx
80104683:	5e                   	pop    %esi
80104684:	5d                   	pop    %ebp
  release(&lk->lk);
80104685:	e9 c6 01 00 00       	jmp    80104850 <release>
8010468a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104690 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
80104690:	55                   	push   %ebp
80104691:	89 e5                	mov    %esp,%ebp
80104693:	57                   	push   %edi
80104694:	31 ff                	xor    %edi,%edi
80104696:	56                   	push   %esi
80104697:	53                   	push   %ebx
80104698:	83 ec 18             	sub    $0x18,%esp
8010469b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;
  
  acquire(&lk->lk);
8010469e:	8d 73 04             	lea    0x4(%ebx),%esi
801046a1:	56                   	push   %esi
801046a2:	e8 09 02 00 00       	call   801048b0 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
801046a7:	8b 03                	mov    (%ebx),%eax
801046a9:	83 c4 10             	add    $0x10,%esp
801046ac:	85 c0                	test   %eax,%eax
801046ae:	75 18                	jne    801046c8 <holdingsleep+0x38>
  release(&lk->lk);
801046b0:	83 ec 0c             	sub    $0xc,%esp
801046b3:	56                   	push   %esi
801046b4:	e8 97 01 00 00       	call   80104850 <release>
  return r;
}
801046b9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801046bc:	89 f8                	mov    %edi,%eax
801046be:	5b                   	pop    %ebx
801046bf:	5e                   	pop    %esi
801046c0:	5f                   	pop    %edi
801046c1:	5d                   	pop    %ebp
801046c2:	c3                   	ret    
801046c3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801046c7:	90                   	nop
  r = lk->locked && (lk->pid == myproc()->pid);
801046c8:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
801046cb:	e8 b0 f5 ff ff       	call   80103c80 <myproc>
801046d0:	39 58 10             	cmp    %ebx,0x10(%eax)
801046d3:	0f 94 c0             	sete   %al
801046d6:	0f b6 c0             	movzbl %al,%eax
801046d9:	89 c7                	mov    %eax,%edi
801046db:	eb d3                	jmp    801046b0 <holdingsleep+0x20>
801046dd:	66 90                	xchg   %ax,%ax
801046df:	90                   	nop

801046e0 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
801046e0:	55                   	push   %ebp
801046e1:	89 e5                	mov    %esp,%ebp
801046e3:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
801046e6:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
801046e9:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
801046ef:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
801046f2:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
801046f9:	5d                   	pop    %ebp
801046fa:	c3                   	ret    
801046fb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801046ff:	90                   	nop

80104700 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80104700:	55                   	push   %ebp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104701:	31 d2                	xor    %edx,%edx
{
80104703:	89 e5                	mov    %esp,%ebp
80104705:	53                   	push   %ebx
  ebp = (uint*)v - 2;
80104706:	8b 45 08             	mov    0x8(%ebp),%eax
{
80104709:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  ebp = (uint*)v - 2;
8010470c:	83 e8 08             	sub    $0x8,%eax
  for(i = 0; i < 10; i++){
8010470f:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104710:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
80104716:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
8010471c:	77 1a                	ja     80104738 <getcallerpcs+0x38>
      break;
    pcs[i] = ebp[1];     // saved %eip
8010471e:	8b 58 04             	mov    0x4(%eax),%ebx
80104721:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
80104724:	83 c2 01             	add    $0x1,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
80104727:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80104729:	83 fa 0a             	cmp    $0xa,%edx
8010472c:	75 e2                	jne    80104710 <getcallerpcs+0x10>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
8010472e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104731:	c9                   	leave  
80104732:	c3                   	ret    
80104733:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104737:	90                   	nop
  for(; i < 10; i++)
80104738:	8d 04 91             	lea    (%ecx,%edx,4),%eax
8010473b:	8d 51 28             	lea    0x28(%ecx),%edx
8010473e:	66 90                	xchg   %ax,%ax
    pcs[i] = 0;
80104740:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
80104746:	83 c0 04             	add    $0x4,%eax
80104749:	39 d0                	cmp    %edx,%eax
8010474b:	75 f3                	jne    80104740 <getcallerpcs+0x40>
}
8010474d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104750:	c9                   	leave  
80104751:	c3                   	ret    
80104752:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104759:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104760 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80104760:	55                   	push   %ebp
80104761:	89 e5                	mov    %esp,%ebp
80104763:	53                   	push   %ebx
80104764:	83 ec 04             	sub    $0x4,%esp
80104767:	9c                   	pushf  
80104768:	5b                   	pop    %ebx
  asm volatile("cli");
80104769:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
8010476a:	e8 91 f4 ff ff       	call   80103c00 <mycpu>
8010476f:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
80104775:	85 c0                	test   %eax,%eax
80104777:	74 17                	je     80104790 <pushcli+0x30>
    mycpu()->intena = eflags & FL_IF;
  mycpu()->ncli += 1;
80104779:	e8 82 f4 ff ff       	call   80103c00 <mycpu>
8010477e:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
80104785:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104788:	c9                   	leave  
80104789:	c3                   	ret    
8010478a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    mycpu()->intena = eflags & FL_IF;
80104790:	e8 6b f4 ff ff       	call   80103c00 <mycpu>
80104795:	81 e3 00 02 00 00    	and    $0x200,%ebx
8010479b:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
801047a1:	eb d6                	jmp    80104779 <pushcli+0x19>
801047a3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801047aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801047b0 <popcli>:

void
popcli(void)
{
801047b0:	55                   	push   %ebp
801047b1:	89 e5                	mov    %esp,%ebp
801047b3:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801047b6:	9c                   	pushf  
801047b7:	58                   	pop    %eax
  if(readeflags()&FL_IF)
801047b8:	f6 c4 02             	test   $0x2,%ah
801047bb:	75 35                	jne    801047f2 <popcli+0x42>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
801047bd:	e8 3e f4 ff ff       	call   80103c00 <mycpu>
801047c2:	83 a8 a4 00 00 00 01 	subl   $0x1,0xa4(%eax)
801047c9:	78 34                	js     801047ff <popcli+0x4f>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
801047cb:	e8 30 f4 ff ff       	call   80103c00 <mycpu>
801047d0:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
801047d6:	85 d2                	test   %edx,%edx
801047d8:	74 06                	je     801047e0 <popcli+0x30>
    sti();
}
801047da:	c9                   	leave  
801047db:	c3                   	ret    
801047dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(mycpu()->ncli == 0 && mycpu()->intena)
801047e0:	e8 1b f4 ff ff       	call   80103c00 <mycpu>
801047e5:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
801047eb:	85 c0                	test   %eax,%eax
801047ed:	74 eb                	je     801047da <popcli+0x2a>
  asm volatile("sti");
801047ef:	fb                   	sti    
}
801047f0:	c9                   	leave  
801047f1:	c3                   	ret    
    panic("popcli - interruptible");
801047f2:	83 ec 0c             	sub    $0xc,%esp
801047f5:	68 6f 7b 10 80       	push   $0x80107b6f
801047fa:	e8 81 bb ff ff       	call   80100380 <panic>
    panic("popcli");
801047ff:	83 ec 0c             	sub    $0xc,%esp
80104802:	68 86 7b 10 80       	push   $0x80107b86
80104807:	e8 74 bb ff ff       	call   80100380 <panic>
8010480c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104810 <holding>:
{
80104810:	55                   	push   %ebp
80104811:	89 e5                	mov    %esp,%ebp
80104813:	56                   	push   %esi
80104814:	53                   	push   %ebx
80104815:	8b 75 08             	mov    0x8(%ebp),%esi
80104818:	31 db                	xor    %ebx,%ebx
  pushcli();
8010481a:	e8 41 ff ff ff       	call   80104760 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
8010481f:	8b 06                	mov    (%esi),%eax
80104821:	85 c0                	test   %eax,%eax
80104823:	75 0b                	jne    80104830 <holding+0x20>
  popcli();
80104825:	e8 86 ff ff ff       	call   801047b0 <popcli>
}
8010482a:	89 d8                	mov    %ebx,%eax
8010482c:	5b                   	pop    %ebx
8010482d:	5e                   	pop    %esi
8010482e:	5d                   	pop    %ebp
8010482f:	c3                   	ret    
  r = lock->locked && lock->cpu == mycpu();
80104830:	8b 5e 08             	mov    0x8(%esi),%ebx
80104833:	e8 c8 f3 ff ff       	call   80103c00 <mycpu>
80104838:	39 c3                	cmp    %eax,%ebx
8010483a:	0f 94 c3             	sete   %bl
  popcli();
8010483d:	e8 6e ff ff ff       	call   801047b0 <popcli>
  r = lock->locked && lock->cpu == mycpu();
80104842:	0f b6 db             	movzbl %bl,%ebx
}
80104845:	89 d8                	mov    %ebx,%eax
80104847:	5b                   	pop    %ebx
80104848:	5e                   	pop    %esi
80104849:	5d                   	pop    %ebp
8010484a:	c3                   	ret    
8010484b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010484f:	90                   	nop

80104850 <release>:
{
80104850:	55                   	push   %ebp
80104851:	89 e5                	mov    %esp,%ebp
80104853:	56                   	push   %esi
80104854:	53                   	push   %ebx
80104855:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pushcli();
80104858:	e8 03 ff ff ff       	call   80104760 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
8010485d:	8b 03                	mov    (%ebx),%eax
8010485f:	85 c0                	test   %eax,%eax
80104861:	75 15                	jne    80104878 <release+0x28>
  popcli();
80104863:	e8 48 ff ff ff       	call   801047b0 <popcli>
    panic("release");
80104868:	83 ec 0c             	sub    $0xc,%esp
8010486b:	68 8d 7b 10 80       	push   $0x80107b8d
80104870:	e8 0b bb ff ff       	call   80100380 <panic>
80104875:	8d 76 00             	lea    0x0(%esi),%esi
  r = lock->locked && lock->cpu == mycpu();
80104878:	8b 73 08             	mov    0x8(%ebx),%esi
8010487b:	e8 80 f3 ff ff       	call   80103c00 <mycpu>
80104880:	39 c6                	cmp    %eax,%esi
80104882:	75 df                	jne    80104863 <release+0x13>
  popcli();
80104884:	e8 27 ff ff ff       	call   801047b0 <popcli>
  lk->pcs[0] = 0;
80104889:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
80104890:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
80104897:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
8010489c:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
801048a2:	8d 65 f8             	lea    -0x8(%ebp),%esp
801048a5:	5b                   	pop    %ebx
801048a6:	5e                   	pop    %esi
801048a7:	5d                   	pop    %ebp
  popcli();
801048a8:	e9 03 ff ff ff       	jmp    801047b0 <popcli>
801048ad:	8d 76 00             	lea    0x0(%esi),%esi

801048b0 <acquire>:
{
801048b0:	55                   	push   %ebp
801048b1:	89 e5                	mov    %esp,%ebp
801048b3:	53                   	push   %ebx
801048b4:	83 ec 04             	sub    $0x4,%esp
  pushcli(); // disable interrupts to avoid deadlock.
801048b7:	e8 a4 fe ff ff       	call   80104760 <pushcli>
  if(holding(lk))
801048bc:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pushcli();
801048bf:	e8 9c fe ff ff       	call   80104760 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
801048c4:	8b 03                	mov    (%ebx),%eax
801048c6:	85 c0                	test   %eax,%eax
801048c8:	75 7e                	jne    80104948 <acquire+0x98>
  popcli();
801048ca:	e8 e1 fe ff ff       	call   801047b0 <popcli>
  asm volatile("lock; xchgl %0, %1" :
801048cf:	b9 01 00 00 00       	mov    $0x1,%ecx
801048d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while(xchg(&lk->locked, 1) != 0)
801048d8:	8b 55 08             	mov    0x8(%ebp),%edx
801048db:	89 c8                	mov    %ecx,%eax
801048dd:	f0 87 02             	lock xchg %eax,(%edx)
801048e0:	85 c0                	test   %eax,%eax
801048e2:	75 f4                	jne    801048d8 <acquire+0x28>
  __sync_synchronize();
801048e4:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
801048e9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801048ec:	e8 0f f3 ff ff       	call   80103c00 <mycpu>
  getcallerpcs(&lk, lk->pcs);
801048f1:	8b 4d 08             	mov    0x8(%ebp),%ecx
  ebp = (uint*)v - 2;
801048f4:	89 ea                	mov    %ebp,%edx
  lk->cpu = mycpu();
801048f6:	89 43 08             	mov    %eax,0x8(%ebx)
  for(i = 0; i < 10; i++){
801048f9:	31 c0                	xor    %eax,%eax
801048fb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801048ff:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104900:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
80104906:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
8010490c:	77 1a                	ja     80104928 <acquire+0x78>
    pcs[i] = ebp[1];     // saved %eip
8010490e:	8b 5a 04             	mov    0x4(%edx),%ebx
80104911:	89 5c 81 0c          	mov    %ebx,0xc(%ecx,%eax,4)
  for(i = 0; i < 10; i++){
80104915:	83 c0 01             	add    $0x1,%eax
    ebp = (uint*)ebp[0]; // saved %ebp
80104918:	8b 12                	mov    (%edx),%edx
  for(i = 0; i < 10; i++){
8010491a:	83 f8 0a             	cmp    $0xa,%eax
8010491d:	75 e1                	jne    80104900 <acquire+0x50>
}
8010491f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104922:	c9                   	leave  
80104923:	c3                   	ret    
80104924:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(; i < 10; i++)
80104928:	8d 44 81 0c          	lea    0xc(%ecx,%eax,4),%eax
8010492c:	8d 51 34             	lea    0x34(%ecx),%edx
8010492f:	90                   	nop
    pcs[i] = 0;
80104930:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
80104936:	83 c0 04             	add    $0x4,%eax
80104939:	39 c2                	cmp    %eax,%edx
8010493b:	75 f3                	jne    80104930 <acquire+0x80>
}
8010493d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104940:	c9                   	leave  
80104941:	c3                   	ret    
80104942:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  r = lock->locked && lock->cpu == mycpu();
80104948:	8b 5b 08             	mov    0x8(%ebx),%ebx
8010494b:	e8 b0 f2 ff ff       	call   80103c00 <mycpu>
80104950:	39 c3                	cmp    %eax,%ebx
80104952:	0f 85 72 ff ff ff    	jne    801048ca <acquire+0x1a>
  popcli();
80104958:	e8 53 fe ff ff       	call   801047b0 <popcli>
    panic("acquire");
8010495d:	83 ec 0c             	sub    $0xc,%esp
80104960:	68 95 7b 10 80       	push   $0x80107b95
80104965:	e8 16 ba ff ff       	call   80100380 <panic>
8010496a:	66 90                	xchg   %ax,%ax
8010496c:	66 90                	xchg   %ax,%ax
8010496e:	66 90                	xchg   %ax,%ax

80104970 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80104970:	55                   	push   %ebp
80104971:	89 e5                	mov    %esp,%ebp
80104973:	57                   	push   %edi
80104974:	8b 55 08             	mov    0x8(%ebp),%edx
80104977:	8b 4d 10             	mov    0x10(%ebp),%ecx
8010497a:	53                   	push   %ebx
8010497b:	8b 45 0c             	mov    0xc(%ebp),%eax
  if ((int)dst%4 == 0 && n%4 == 0){
8010497e:	89 d7                	mov    %edx,%edi
80104980:	09 cf                	or     %ecx,%edi
80104982:	83 e7 03             	and    $0x3,%edi
80104985:	75 29                	jne    801049b0 <memset+0x40>
    c &= 0xFF;
80104987:	0f b6 f8             	movzbl %al,%edi
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
8010498a:	c1 e0 18             	shl    $0x18,%eax
8010498d:	89 fb                	mov    %edi,%ebx
8010498f:	c1 e9 02             	shr    $0x2,%ecx
80104992:	c1 e3 10             	shl    $0x10,%ebx
80104995:	09 d8                	or     %ebx,%eax
80104997:	09 f8                	or     %edi,%eax
80104999:	c1 e7 08             	shl    $0x8,%edi
8010499c:	09 f8                	or     %edi,%eax
  asm volatile("cld; rep stosl" :
8010499e:	89 d7                	mov    %edx,%edi
801049a0:	fc                   	cld    
801049a1:	f3 ab                	rep stos %eax,%es:(%edi)
  } else
    stosb(dst, c, n);
  return dst;
}
801049a3:	5b                   	pop    %ebx
801049a4:	89 d0                	mov    %edx,%eax
801049a6:	5f                   	pop    %edi
801049a7:	5d                   	pop    %ebp
801049a8:	c3                   	ret    
801049a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  asm volatile("cld; rep stosb" :
801049b0:	89 d7                	mov    %edx,%edi
801049b2:	fc                   	cld    
801049b3:	f3 aa                	rep stos %al,%es:(%edi)
801049b5:	5b                   	pop    %ebx
801049b6:	89 d0                	mov    %edx,%eax
801049b8:	5f                   	pop    %edi
801049b9:	5d                   	pop    %ebp
801049ba:	c3                   	ret    
801049bb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801049bf:	90                   	nop

801049c0 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
801049c0:	55                   	push   %ebp
801049c1:	89 e5                	mov    %esp,%ebp
801049c3:	56                   	push   %esi
801049c4:	8b 75 10             	mov    0x10(%ebp),%esi
801049c7:	8b 55 08             	mov    0x8(%ebp),%edx
801049ca:	53                   	push   %ebx
801049cb:	8b 45 0c             	mov    0xc(%ebp),%eax
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
801049ce:	85 f6                	test   %esi,%esi
801049d0:	74 2e                	je     80104a00 <memcmp+0x40>
801049d2:	01 c6                	add    %eax,%esi
801049d4:	eb 14                	jmp    801049ea <memcmp+0x2a>
801049d6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801049dd:	8d 76 00             	lea    0x0(%esi),%esi
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
801049e0:	83 c0 01             	add    $0x1,%eax
801049e3:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0){
801049e6:	39 f0                	cmp    %esi,%eax
801049e8:	74 16                	je     80104a00 <memcmp+0x40>
    if(*s1 != *s2)
801049ea:	0f b6 0a             	movzbl (%edx),%ecx
801049ed:	0f b6 18             	movzbl (%eax),%ebx
801049f0:	38 d9                	cmp    %bl,%cl
801049f2:	74 ec                	je     801049e0 <memcmp+0x20>
      return *s1 - *s2;
801049f4:	0f b6 c1             	movzbl %cl,%eax
801049f7:	29 d8                	sub    %ebx,%eax
  }

  return 0;
}
801049f9:	5b                   	pop    %ebx
801049fa:	5e                   	pop    %esi
801049fb:	5d                   	pop    %ebp
801049fc:	c3                   	ret    
801049fd:	8d 76 00             	lea    0x0(%esi),%esi
80104a00:	5b                   	pop    %ebx
  return 0;
80104a01:	31 c0                	xor    %eax,%eax
}
80104a03:	5e                   	pop    %esi
80104a04:	5d                   	pop    %ebp
80104a05:	c3                   	ret    
80104a06:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104a0d:	8d 76 00             	lea    0x0(%esi),%esi

80104a10 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80104a10:	55                   	push   %ebp
80104a11:	89 e5                	mov    %esp,%ebp
80104a13:	57                   	push   %edi
80104a14:	8b 55 08             	mov    0x8(%ebp),%edx
80104a17:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104a1a:	56                   	push   %esi
80104a1b:	8b 75 0c             	mov    0xc(%ebp),%esi
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
80104a1e:	39 d6                	cmp    %edx,%esi
80104a20:	73 26                	jae    80104a48 <memmove+0x38>
80104a22:	8d 3c 0e             	lea    (%esi,%ecx,1),%edi
80104a25:	39 fa                	cmp    %edi,%edx
80104a27:	73 1f                	jae    80104a48 <memmove+0x38>
80104a29:	8d 41 ff             	lea    -0x1(%ecx),%eax
    s += n;
    d += n;
    while(n-- > 0)
80104a2c:	85 c9                	test   %ecx,%ecx
80104a2e:	74 0c                	je     80104a3c <memmove+0x2c>
      *--d = *--s;
80104a30:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
80104a34:	88 0c 02             	mov    %cl,(%edx,%eax,1)
    while(n-- > 0)
80104a37:	83 e8 01             	sub    $0x1,%eax
80104a3a:	73 f4                	jae    80104a30 <memmove+0x20>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
80104a3c:	5e                   	pop    %esi
80104a3d:	89 d0                	mov    %edx,%eax
80104a3f:	5f                   	pop    %edi
80104a40:	5d                   	pop    %ebp
80104a41:	c3                   	ret    
80104a42:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    while(n-- > 0)
80104a48:	8d 04 0e             	lea    (%esi,%ecx,1),%eax
80104a4b:	89 d7                	mov    %edx,%edi
80104a4d:	85 c9                	test   %ecx,%ecx
80104a4f:	74 eb                	je     80104a3c <memmove+0x2c>
80104a51:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      *d++ = *s++;
80104a58:	a4                   	movsb  %ds:(%esi),%es:(%edi)
    while(n-- > 0)
80104a59:	39 c6                	cmp    %eax,%esi
80104a5b:	75 fb                	jne    80104a58 <memmove+0x48>
}
80104a5d:	5e                   	pop    %esi
80104a5e:	89 d0                	mov    %edx,%eax
80104a60:	5f                   	pop    %edi
80104a61:	5d                   	pop    %ebp
80104a62:	c3                   	ret    
80104a63:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104a6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104a70 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
  return memmove(dst, src, n);
80104a70:	eb 9e                	jmp    80104a10 <memmove>
80104a72:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104a79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104a80 <strncmp>:
}

int
strncmp(const char *p, const char *q, uint n)
{
80104a80:	55                   	push   %ebp
80104a81:	89 e5                	mov    %esp,%ebp
80104a83:	56                   	push   %esi
80104a84:	8b 75 10             	mov    0x10(%ebp),%esi
80104a87:	8b 4d 08             	mov    0x8(%ebp),%ecx
80104a8a:	53                   	push   %ebx
80104a8b:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(n > 0 && *p && *p == *q)
80104a8e:	85 f6                	test   %esi,%esi
80104a90:	74 2e                	je     80104ac0 <strncmp+0x40>
80104a92:	01 d6                	add    %edx,%esi
80104a94:	eb 18                	jmp    80104aae <strncmp+0x2e>
80104a96:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104a9d:	8d 76 00             	lea    0x0(%esi),%esi
80104aa0:	38 d8                	cmp    %bl,%al
80104aa2:	75 14                	jne    80104ab8 <strncmp+0x38>
    n--, p++, q++;
80104aa4:	83 c2 01             	add    $0x1,%edx
80104aa7:	83 c1 01             	add    $0x1,%ecx
  while(n > 0 && *p && *p == *q)
80104aaa:	39 f2                	cmp    %esi,%edx
80104aac:	74 12                	je     80104ac0 <strncmp+0x40>
80104aae:	0f b6 01             	movzbl (%ecx),%eax
80104ab1:	0f b6 1a             	movzbl (%edx),%ebx
80104ab4:	84 c0                	test   %al,%al
80104ab6:	75 e8                	jne    80104aa0 <strncmp+0x20>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
80104ab8:	29 d8                	sub    %ebx,%eax
}
80104aba:	5b                   	pop    %ebx
80104abb:	5e                   	pop    %esi
80104abc:	5d                   	pop    %ebp
80104abd:	c3                   	ret    
80104abe:	66 90                	xchg   %ax,%ax
80104ac0:	5b                   	pop    %ebx
    return 0;
80104ac1:	31 c0                	xor    %eax,%eax
}
80104ac3:	5e                   	pop    %esi
80104ac4:	5d                   	pop    %ebp
80104ac5:	c3                   	ret    
80104ac6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104acd:	8d 76 00             	lea    0x0(%esi),%esi

80104ad0 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80104ad0:	55                   	push   %ebp
80104ad1:	89 e5                	mov    %esp,%ebp
80104ad3:	57                   	push   %edi
80104ad4:	56                   	push   %esi
80104ad5:	8b 75 08             	mov    0x8(%ebp),%esi
80104ad8:	53                   	push   %ebx
80104ad9:	8b 4d 10             	mov    0x10(%ebp),%ecx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
80104adc:	89 f0                	mov    %esi,%eax
80104ade:	eb 15                	jmp    80104af5 <strncpy+0x25>
80104ae0:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
80104ae4:	8b 7d 0c             	mov    0xc(%ebp),%edi
80104ae7:	83 c0 01             	add    $0x1,%eax
80104aea:	0f b6 57 ff          	movzbl -0x1(%edi),%edx
80104aee:	88 50 ff             	mov    %dl,-0x1(%eax)
80104af1:	84 d2                	test   %dl,%dl
80104af3:	74 09                	je     80104afe <strncpy+0x2e>
80104af5:	89 cb                	mov    %ecx,%ebx
80104af7:	83 e9 01             	sub    $0x1,%ecx
80104afa:	85 db                	test   %ebx,%ebx
80104afc:	7f e2                	jg     80104ae0 <strncpy+0x10>
    ;
  while(n-- > 0)
80104afe:	89 c2                	mov    %eax,%edx
80104b00:	85 c9                	test   %ecx,%ecx
80104b02:	7e 17                	jle    80104b1b <strncpy+0x4b>
80104b04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *s++ = 0;
80104b08:	83 c2 01             	add    $0x1,%edx
80104b0b:	89 c1                	mov    %eax,%ecx
80104b0d:	c6 42 ff 00          	movb   $0x0,-0x1(%edx)
  while(n-- > 0)
80104b11:	29 d1                	sub    %edx,%ecx
80104b13:	8d 4c 0b ff          	lea    -0x1(%ebx,%ecx,1),%ecx
80104b17:	85 c9                	test   %ecx,%ecx
80104b19:	7f ed                	jg     80104b08 <strncpy+0x38>
  return os;
}
80104b1b:	5b                   	pop    %ebx
80104b1c:	89 f0                	mov    %esi,%eax
80104b1e:	5e                   	pop    %esi
80104b1f:	5f                   	pop    %edi
80104b20:	5d                   	pop    %ebp
80104b21:	c3                   	ret    
80104b22:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104b29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104b30 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80104b30:	55                   	push   %ebp
80104b31:	89 e5                	mov    %esp,%ebp
80104b33:	56                   	push   %esi
80104b34:	8b 55 10             	mov    0x10(%ebp),%edx
80104b37:	8b 75 08             	mov    0x8(%ebp),%esi
80104b3a:	53                   	push   %ebx
80104b3b:	8b 45 0c             	mov    0xc(%ebp),%eax
  char *os;

  os = s;
  if(n <= 0)
80104b3e:	85 d2                	test   %edx,%edx
80104b40:	7e 25                	jle    80104b67 <safestrcpy+0x37>
80104b42:	8d 5c 10 ff          	lea    -0x1(%eax,%edx,1),%ebx
80104b46:	89 f2                	mov    %esi,%edx
80104b48:	eb 16                	jmp    80104b60 <safestrcpy+0x30>
80104b4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80104b50:	0f b6 08             	movzbl (%eax),%ecx
80104b53:	83 c0 01             	add    $0x1,%eax
80104b56:	83 c2 01             	add    $0x1,%edx
80104b59:	88 4a ff             	mov    %cl,-0x1(%edx)
80104b5c:	84 c9                	test   %cl,%cl
80104b5e:	74 04                	je     80104b64 <safestrcpy+0x34>
80104b60:	39 d8                	cmp    %ebx,%eax
80104b62:	75 ec                	jne    80104b50 <safestrcpy+0x20>
    ;
  *s = 0;
80104b64:	c6 02 00             	movb   $0x0,(%edx)
  return os;
}
80104b67:	89 f0                	mov    %esi,%eax
80104b69:	5b                   	pop    %ebx
80104b6a:	5e                   	pop    %esi
80104b6b:	5d                   	pop    %ebp
80104b6c:	c3                   	ret    
80104b6d:	8d 76 00             	lea    0x0(%esi),%esi

80104b70 <strlen>:

int
strlen(const char *s)
{
80104b70:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80104b71:	31 c0                	xor    %eax,%eax
{
80104b73:	89 e5                	mov    %esp,%ebp
80104b75:	8b 55 08             	mov    0x8(%ebp),%edx
  for(n = 0; s[n]; n++)
80104b78:	80 3a 00             	cmpb   $0x0,(%edx)
80104b7b:	74 0c                	je     80104b89 <strlen+0x19>
80104b7d:	8d 76 00             	lea    0x0(%esi),%esi
80104b80:	83 c0 01             	add    $0x1,%eax
80104b83:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80104b87:	75 f7                	jne    80104b80 <strlen+0x10>
    ;
  return n;
}
80104b89:	5d                   	pop    %ebp
80104b8a:	c3                   	ret    

80104b8b <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
80104b8b:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
80104b8f:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-saved registers
  pushl %ebp
80104b93:	55                   	push   %ebp
  pushl %ebx
80104b94:	53                   	push   %ebx
  pushl %esi
80104b95:	56                   	push   %esi
  pushl %edi
80104b96:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
80104b97:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
80104b99:	89 d4                	mov    %edx,%esp

  # Load new callee-saved registers
  popl %edi
80104b9b:	5f                   	pop    %edi
  popl %esi
80104b9c:	5e                   	pop    %esi
  popl %ebx
80104b9d:	5b                   	pop    %ebx
  popl %ebp
80104b9e:	5d                   	pop    %ebp
  ret
80104b9f:	c3                   	ret    

80104ba0 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80104ba0:	55                   	push   %ebp
80104ba1:	89 e5                	mov    %esp,%ebp
80104ba3:	53                   	push   %ebx
80104ba4:	83 ec 04             	sub    $0x4,%esp
80104ba7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
80104baa:	e8 d1 f0 ff ff       	call   80103c80 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104baf:	8b 00                	mov    (%eax),%eax
80104bb1:	39 d8                	cmp    %ebx,%eax
80104bb3:	76 1b                	jbe    80104bd0 <fetchint+0x30>
80104bb5:	8d 53 04             	lea    0x4(%ebx),%edx
80104bb8:	39 d0                	cmp    %edx,%eax
80104bba:	72 14                	jb     80104bd0 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
80104bbc:	8b 45 0c             	mov    0xc(%ebp),%eax
80104bbf:	8b 13                	mov    (%ebx),%edx
80104bc1:	89 10                	mov    %edx,(%eax)
  return 0;
80104bc3:	31 c0                	xor    %eax,%eax
}
80104bc5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104bc8:	c9                   	leave  
80104bc9:	c3                   	ret    
80104bca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80104bd0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104bd5:	eb ee                	jmp    80104bc5 <fetchint+0x25>
80104bd7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104bde:	66 90                	xchg   %ax,%ax

80104be0 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80104be0:	55                   	push   %ebp
80104be1:	89 e5                	mov    %esp,%ebp
80104be3:	53                   	push   %ebx
80104be4:	83 ec 04             	sub    $0x4,%esp
80104be7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
80104bea:	e8 91 f0 ff ff       	call   80103c80 <myproc>

  if(addr >= curproc->sz)
80104bef:	39 18                	cmp    %ebx,(%eax)
80104bf1:	76 2d                	jbe    80104c20 <fetchstr+0x40>
    return -1;
  *pp = (char*)addr;
80104bf3:	8b 55 0c             	mov    0xc(%ebp),%edx
80104bf6:	89 1a                	mov    %ebx,(%edx)
  ep = (char*)curproc->sz;
80104bf8:	8b 10                	mov    (%eax),%edx
  for(s = *pp; s < ep; s++){
80104bfa:	39 d3                	cmp    %edx,%ebx
80104bfc:	73 22                	jae    80104c20 <fetchstr+0x40>
80104bfe:	89 d8                	mov    %ebx,%eax
80104c00:	eb 0d                	jmp    80104c0f <fetchstr+0x2f>
80104c02:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104c08:	83 c0 01             	add    $0x1,%eax
80104c0b:	39 c2                	cmp    %eax,%edx
80104c0d:	76 11                	jbe    80104c20 <fetchstr+0x40>
    if(*s == 0)
80104c0f:	80 38 00             	cmpb   $0x0,(%eax)
80104c12:	75 f4                	jne    80104c08 <fetchstr+0x28>
      return s - *pp;
80104c14:	29 d8                	sub    %ebx,%eax
  }
  return -1;
}
80104c16:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104c19:	c9                   	leave  
80104c1a:	c3                   	ret    
80104c1b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104c1f:	90                   	nop
80104c20:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return -1;
80104c23:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104c28:	c9                   	leave  
80104c29:	c3                   	ret    
80104c2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104c30 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80104c30:	55                   	push   %ebp
80104c31:	89 e5                	mov    %esp,%ebp
80104c33:	56                   	push   %esi
80104c34:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104c35:	e8 46 f0 ff ff       	call   80103c80 <myproc>
80104c3a:	8b 55 08             	mov    0x8(%ebp),%edx
80104c3d:	8b 40 18             	mov    0x18(%eax),%eax
80104c40:	8b 40 44             	mov    0x44(%eax),%eax
80104c43:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80104c46:	e8 35 f0 ff ff       	call   80103c80 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104c4b:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104c4e:	8b 00                	mov    (%eax),%eax
80104c50:	39 c6                	cmp    %eax,%esi
80104c52:	73 1c                	jae    80104c70 <argint+0x40>
80104c54:	8d 53 08             	lea    0x8(%ebx),%edx
80104c57:	39 d0                	cmp    %edx,%eax
80104c59:	72 15                	jb     80104c70 <argint+0x40>
  *ip = *(int*)(addr);
80104c5b:	8b 45 0c             	mov    0xc(%ebp),%eax
80104c5e:	8b 53 04             	mov    0x4(%ebx),%edx
80104c61:	89 10                	mov    %edx,(%eax)
  return 0;
80104c63:	31 c0                	xor    %eax,%eax
}
80104c65:	5b                   	pop    %ebx
80104c66:	5e                   	pop    %esi
80104c67:	5d                   	pop    %ebp
80104c68:	c3                   	ret    
80104c69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104c70:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104c75:	eb ee                	jmp    80104c65 <argint+0x35>
80104c77:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104c7e:	66 90                	xchg   %ax,%ax

80104c80 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80104c80:	55                   	push   %ebp
80104c81:	89 e5                	mov    %esp,%ebp
80104c83:	57                   	push   %edi
80104c84:	56                   	push   %esi
80104c85:	53                   	push   %ebx
80104c86:	83 ec 0c             	sub    $0xc,%esp
  int i;
  struct proc *curproc = myproc();
80104c89:	e8 f2 ef ff ff       	call   80103c80 <myproc>
80104c8e:	89 c6                	mov    %eax,%esi
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104c90:	e8 eb ef ff ff       	call   80103c80 <myproc>
80104c95:	8b 55 08             	mov    0x8(%ebp),%edx
80104c98:	8b 40 18             	mov    0x18(%eax),%eax
80104c9b:	8b 40 44             	mov    0x44(%eax),%eax
80104c9e:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80104ca1:	e8 da ef ff ff       	call   80103c80 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104ca6:	8d 7b 04             	lea    0x4(%ebx),%edi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104ca9:	8b 00                	mov    (%eax),%eax
80104cab:	39 c7                	cmp    %eax,%edi
80104cad:	73 31                	jae    80104ce0 <argptr+0x60>
80104caf:	8d 4b 08             	lea    0x8(%ebx),%ecx
80104cb2:	39 c8                	cmp    %ecx,%eax
80104cb4:	72 2a                	jb     80104ce0 <argptr+0x60>
 
  if(argint(n, &i) < 0)
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80104cb6:	8b 55 10             	mov    0x10(%ebp),%edx
  *ip = *(int*)(addr);
80104cb9:	8b 43 04             	mov    0x4(%ebx),%eax
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80104cbc:	85 d2                	test   %edx,%edx
80104cbe:	78 20                	js     80104ce0 <argptr+0x60>
80104cc0:	8b 16                	mov    (%esi),%edx
80104cc2:	39 c2                	cmp    %eax,%edx
80104cc4:	76 1a                	jbe    80104ce0 <argptr+0x60>
80104cc6:	8b 5d 10             	mov    0x10(%ebp),%ebx
80104cc9:	01 c3                	add    %eax,%ebx
80104ccb:	39 da                	cmp    %ebx,%edx
80104ccd:	72 11                	jb     80104ce0 <argptr+0x60>
    return -1;
  *pp = (char*)i;
80104ccf:	8b 55 0c             	mov    0xc(%ebp),%edx
80104cd2:	89 02                	mov    %eax,(%edx)
  return 0;
80104cd4:	31 c0                	xor    %eax,%eax
}
80104cd6:	83 c4 0c             	add    $0xc,%esp
80104cd9:	5b                   	pop    %ebx
80104cda:	5e                   	pop    %esi
80104cdb:	5f                   	pop    %edi
80104cdc:	5d                   	pop    %ebp
80104cdd:	c3                   	ret    
80104cde:	66 90                	xchg   %ax,%ax
    return -1;
80104ce0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104ce5:	eb ef                	jmp    80104cd6 <argptr+0x56>
80104ce7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104cee:	66 90                	xchg   %ax,%ax

80104cf0 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80104cf0:	55                   	push   %ebp
80104cf1:	89 e5                	mov    %esp,%ebp
80104cf3:	56                   	push   %esi
80104cf4:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104cf5:	e8 86 ef ff ff       	call   80103c80 <myproc>
80104cfa:	8b 55 08             	mov    0x8(%ebp),%edx
80104cfd:	8b 40 18             	mov    0x18(%eax),%eax
80104d00:	8b 40 44             	mov    0x44(%eax),%eax
80104d03:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80104d06:	e8 75 ef ff ff       	call   80103c80 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104d0b:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104d0e:	8b 00                	mov    (%eax),%eax
80104d10:	39 c6                	cmp    %eax,%esi
80104d12:	73 44                	jae    80104d58 <argstr+0x68>
80104d14:	8d 53 08             	lea    0x8(%ebx),%edx
80104d17:	39 d0                	cmp    %edx,%eax
80104d19:	72 3d                	jb     80104d58 <argstr+0x68>
  *ip = *(int*)(addr);
80104d1b:	8b 5b 04             	mov    0x4(%ebx),%ebx
  struct proc *curproc = myproc();
80104d1e:	e8 5d ef ff ff       	call   80103c80 <myproc>
  if(addr >= curproc->sz)
80104d23:	3b 18                	cmp    (%eax),%ebx
80104d25:	73 31                	jae    80104d58 <argstr+0x68>
  *pp = (char*)addr;
80104d27:	8b 55 0c             	mov    0xc(%ebp),%edx
80104d2a:	89 1a                	mov    %ebx,(%edx)
  ep = (char*)curproc->sz;
80104d2c:	8b 10                	mov    (%eax),%edx
  for(s = *pp; s < ep; s++){
80104d2e:	39 d3                	cmp    %edx,%ebx
80104d30:	73 26                	jae    80104d58 <argstr+0x68>
80104d32:	89 d8                	mov    %ebx,%eax
80104d34:	eb 11                	jmp    80104d47 <argstr+0x57>
80104d36:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104d3d:	8d 76 00             	lea    0x0(%esi),%esi
80104d40:	83 c0 01             	add    $0x1,%eax
80104d43:	39 c2                	cmp    %eax,%edx
80104d45:	76 11                	jbe    80104d58 <argstr+0x68>
    if(*s == 0)
80104d47:	80 38 00             	cmpb   $0x0,(%eax)
80104d4a:	75 f4                	jne    80104d40 <argstr+0x50>
      return s - *pp;
80104d4c:	29 d8                	sub    %ebx,%eax
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
  return fetchstr(addr, pp);
}
80104d4e:	5b                   	pop    %ebx
80104d4f:	5e                   	pop    %esi
80104d50:	5d                   	pop    %ebp
80104d51:	c3                   	ret    
80104d52:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104d58:	5b                   	pop    %ebx
    return -1;
80104d59:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104d5e:	5e                   	pop    %esi
80104d5f:	5d                   	pop    %ebp
80104d60:	c3                   	ret    
80104d61:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104d68:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104d6f:	90                   	nop

80104d70 <syscall>:
[SYS_close]   sys_close,
};

void
syscall(void)
{
80104d70:	55                   	push   %ebp
80104d71:	89 e5                	mov    %esp,%ebp
80104d73:	53                   	push   %ebx
80104d74:	83 ec 04             	sub    $0x4,%esp
  int num;
  struct proc *curproc = myproc();
80104d77:	e8 04 ef ff ff       	call   80103c80 <myproc>
80104d7c:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax;
80104d7e:	8b 40 18             	mov    0x18(%eax),%eax
80104d81:	8b 40 1c             	mov    0x1c(%eax),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80104d84:	8d 50 ff             	lea    -0x1(%eax),%edx
80104d87:	83 fa 14             	cmp    $0x14,%edx
80104d8a:	77 24                	ja     80104db0 <syscall+0x40>
80104d8c:	8b 14 85 c0 7b 10 80 	mov    -0x7fef8440(,%eax,4),%edx
80104d93:	85 d2                	test   %edx,%edx
80104d95:	74 19                	je     80104db0 <syscall+0x40>
    curproc->tf->eax = syscalls[num]();
80104d97:	ff d2                	call   *%edx
80104d99:	89 c2                	mov    %eax,%edx
80104d9b:	8b 43 18             	mov    0x18(%ebx),%eax
80104d9e:	89 50 1c             	mov    %edx,0x1c(%eax)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
80104da1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104da4:	c9                   	leave  
80104da5:	c3                   	ret    
80104da6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104dad:	8d 76 00             	lea    0x0(%esi),%esi
    cprintf("%d %s: unknown sys call %d\n",
80104db0:	50                   	push   %eax
            curproc->pid, curproc->name, num);
80104db1:	8d 43 6c             	lea    0x6c(%ebx),%eax
    cprintf("%d %s: unknown sys call %d\n",
80104db4:	50                   	push   %eax
80104db5:	ff 73 10             	push   0x10(%ebx)
80104db8:	68 9d 7b 10 80       	push   $0x80107b9d
80104dbd:	e8 6e b9 ff ff       	call   80100730 <cprintf>
    curproc->tf->eax = -1;
80104dc2:	8b 43 18             	mov    0x18(%ebx),%eax
80104dc5:	83 c4 10             	add    $0x10,%esp
80104dc8:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
80104dcf:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104dd2:	c9                   	leave  
80104dd3:	c3                   	ret    
80104dd4:	66 90                	xchg   %ax,%ax
80104dd6:	66 90                	xchg   %ax,%ax
80104dd8:	66 90                	xchg   %ax,%ax
80104dda:	66 90                	xchg   %ax,%ax
80104ddc:	66 90                	xchg   %ax,%ax
80104dde:	66 90                	xchg   %ax,%ax

80104de0 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104de0:	55                   	push   %ebp
80104de1:	89 e5                	mov    %esp,%ebp
80104de3:	57                   	push   %edi
80104de4:	56                   	push   %esi
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80104de5:	8d 7d da             	lea    -0x26(%ebp),%edi
{
80104de8:	53                   	push   %ebx
80104de9:	83 ec 34             	sub    $0x34,%esp
80104dec:	89 4d d0             	mov    %ecx,-0x30(%ebp)
80104def:	8b 4d 08             	mov    0x8(%ebp),%ecx
  if((dp = nameiparent(path, name)) == 0)
80104df2:	57                   	push   %edi
80104df3:	50                   	push   %eax
{
80104df4:	89 55 d4             	mov    %edx,-0x2c(%ebp)
80104df7:	89 4d cc             	mov    %ecx,-0x34(%ebp)
  if((dp = nameiparent(path, name)) == 0)
80104dfa:	e8 d1 d5 ff ff       	call   801023d0 <nameiparent>
80104dff:	83 c4 10             	add    $0x10,%esp
80104e02:	85 c0                	test   %eax,%eax
80104e04:	0f 84 46 01 00 00    	je     80104f50 <create+0x170>
    return 0;
  ilock(dp);
80104e0a:	83 ec 0c             	sub    $0xc,%esp
80104e0d:	89 c3                	mov    %eax,%ebx
80104e0f:	50                   	push   %eax
80104e10:	e8 7b cc ff ff       	call   80101a90 <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
80104e15:	83 c4 0c             	add    $0xc,%esp
80104e18:	6a 00                	push   $0x0
80104e1a:	57                   	push   %edi
80104e1b:	53                   	push   %ebx
80104e1c:	e8 cf d1 ff ff       	call   80101ff0 <dirlookup>
80104e21:	83 c4 10             	add    $0x10,%esp
80104e24:	89 c6                	mov    %eax,%esi
80104e26:	85 c0                	test   %eax,%eax
80104e28:	74 56                	je     80104e80 <create+0xa0>
    iunlockput(dp);
80104e2a:	83 ec 0c             	sub    $0xc,%esp
80104e2d:	53                   	push   %ebx
80104e2e:	e8 ed ce ff ff       	call   80101d20 <iunlockput>
    ilock(ip);
80104e33:	89 34 24             	mov    %esi,(%esp)
80104e36:	e8 55 cc ff ff       	call   80101a90 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
80104e3b:	83 c4 10             	add    $0x10,%esp
80104e3e:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
80104e43:	75 1b                	jne    80104e60 <create+0x80>
80104e45:	66 83 7e 50 02       	cmpw   $0x2,0x50(%esi)
80104e4a:	75 14                	jne    80104e60 <create+0x80>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80104e4c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104e4f:	89 f0                	mov    %esi,%eax
80104e51:	5b                   	pop    %ebx
80104e52:	5e                   	pop    %esi
80104e53:	5f                   	pop    %edi
80104e54:	5d                   	pop    %ebp
80104e55:	c3                   	ret    
80104e56:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104e5d:	8d 76 00             	lea    0x0(%esi),%esi
    iunlockput(ip);
80104e60:	83 ec 0c             	sub    $0xc,%esp
80104e63:	56                   	push   %esi
    return 0;
80104e64:	31 f6                	xor    %esi,%esi
    iunlockput(ip);
80104e66:	e8 b5 ce ff ff       	call   80101d20 <iunlockput>
    return 0;
80104e6b:	83 c4 10             	add    $0x10,%esp
}
80104e6e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104e71:	89 f0                	mov    %esi,%eax
80104e73:	5b                   	pop    %ebx
80104e74:	5e                   	pop    %esi
80104e75:	5f                   	pop    %edi
80104e76:	5d                   	pop    %ebp
80104e77:	c3                   	ret    
80104e78:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104e7f:	90                   	nop
  if((ip = ialloc(dp->dev, type)) == 0)
80104e80:	0f bf 45 d4          	movswl -0x2c(%ebp),%eax
80104e84:	83 ec 08             	sub    $0x8,%esp
80104e87:	50                   	push   %eax
80104e88:	ff 33                	push   (%ebx)
80104e8a:	e8 91 ca ff ff       	call   80101920 <ialloc>
80104e8f:	83 c4 10             	add    $0x10,%esp
80104e92:	89 c6                	mov    %eax,%esi
80104e94:	85 c0                	test   %eax,%eax
80104e96:	0f 84 cd 00 00 00    	je     80104f69 <create+0x189>
  ilock(ip);
80104e9c:	83 ec 0c             	sub    $0xc,%esp
80104e9f:	50                   	push   %eax
80104ea0:	e8 eb cb ff ff       	call   80101a90 <ilock>
  ip->major = major;
80104ea5:	0f b7 45 d0          	movzwl -0x30(%ebp),%eax
80104ea9:	66 89 46 52          	mov    %ax,0x52(%esi)
  ip->minor = minor;
80104ead:	0f b7 45 cc          	movzwl -0x34(%ebp),%eax
80104eb1:	66 89 46 54          	mov    %ax,0x54(%esi)
  ip->nlink = 1;
80104eb5:	b8 01 00 00 00       	mov    $0x1,%eax
80104eba:	66 89 46 56          	mov    %ax,0x56(%esi)
  iupdate(ip);
80104ebe:	89 34 24             	mov    %esi,(%esp)
80104ec1:	e8 1a cb ff ff       	call   801019e0 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
80104ec6:	83 c4 10             	add    $0x10,%esp
80104ec9:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
80104ece:	74 30                	je     80104f00 <create+0x120>
  if(dirlink(dp, name, ip->inum) < 0)
80104ed0:	83 ec 04             	sub    $0x4,%esp
80104ed3:	ff 76 04             	push   0x4(%esi)
80104ed6:	57                   	push   %edi
80104ed7:	53                   	push   %ebx
80104ed8:	e8 13 d4 ff ff       	call   801022f0 <dirlink>
80104edd:	83 c4 10             	add    $0x10,%esp
80104ee0:	85 c0                	test   %eax,%eax
80104ee2:	78 78                	js     80104f5c <create+0x17c>
  iunlockput(dp);
80104ee4:	83 ec 0c             	sub    $0xc,%esp
80104ee7:	53                   	push   %ebx
80104ee8:	e8 33 ce ff ff       	call   80101d20 <iunlockput>
  return ip;
80104eed:	83 c4 10             	add    $0x10,%esp
}
80104ef0:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104ef3:	89 f0                	mov    %esi,%eax
80104ef5:	5b                   	pop    %ebx
80104ef6:	5e                   	pop    %esi
80104ef7:	5f                   	pop    %edi
80104ef8:	5d                   	pop    %ebp
80104ef9:	c3                   	ret    
80104efa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iupdate(dp);
80104f00:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink++;  // for ".."
80104f03:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
    iupdate(dp);
80104f08:	53                   	push   %ebx
80104f09:	e8 d2 ca ff ff       	call   801019e0 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
80104f0e:	83 c4 0c             	add    $0xc,%esp
80104f11:	ff 76 04             	push   0x4(%esi)
80104f14:	68 34 7c 10 80       	push   $0x80107c34
80104f19:	56                   	push   %esi
80104f1a:	e8 d1 d3 ff ff       	call   801022f0 <dirlink>
80104f1f:	83 c4 10             	add    $0x10,%esp
80104f22:	85 c0                	test   %eax,%eax
80104f24:	78 18                	js     80104f3e <create+0x15e>
80104f26:	83 ec 04             	sub    $0x4,%esp
80104f29:	ff 73 04             	push   0x4(%ebx)
80104f2c:	68 33 7c 10 80       	push   $0x80107c33
80104f31:	56                   	push   %esi
80104f32:	e8 b9 d3 ff ff       	call   801022f0 <dirlink>
80104f37:	83 c4 10             	add    $0x10,%esp
80104f3a:	85 c0                	test   %eax,%eax
80104f3c:	79 92                	jns    80104ed0 <create+0xf0>
      panic("create dots");
80104f3e:	83 ec 0c             	sub    $0xc,%esp
80104f41:	68 27 7c 10 80       	push   $0x80107c27
80104f46:	e8 35 b4 ff ff       	call   80100380 <panic>
80104f4b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104f4f:	90                   	nop
}
80104f50:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
80104f53:	31 f6                	xor    %esi,%esi
}
80104f55:	5b                   	pop    %ebx
80104f56:	89 f0                	mov    %esi,%eax
80104f58:	5e                   	pop    %esi
80104f59:	5f                   	pop    %edi
80104f5a:	5d                   	pop    %ebp
80104f5b:	c3                   	ret    
    panic("create: dirlink");
80104f5c:	83 ec 0c             	sub    $0xc,%esp
80104f5f:	68 36 7c 10 80       	push   $0x80107c36
80104f64:	e8 17 b4 ff ff       	call   80100380 <panic>
    panic("create: ialloc");
80104f69:	83 ec 0c             	sub    $0xc,%esp
80104f6c:	68 18 7c 10 80       	push   $0x80107c18
80104f71:	e8 0a b4 ff ff       	call   80100380 <panic>
80104f76:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104f7d:	8d 76 00             	lea    0x0(%esi),%esi

80104f80 <sys_dup>:
{
80104f80:	55                   	push   %ebp
80104f81:	89 e5                	mov    %esp,%ebp
80104f83:	56                   	push   %esi
80104f84:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80104f85:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80104f88:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80104f8b:	50                   	push   %eax
80104f8c:	6a 00                	push   $0x0
80104f8e:	e8 9d fc ff ff       	call   80104c30 <argint>
80104f93:	83 c4 10             	add    $0x10,%esp
80104f96:	85 c0                	test   %eax,%eax
80104f98:	78 36                	js     80104fd0 <sys_dup+0x50>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80104f9a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80104f9e:	77 30                	ja     80104fd0 <sys_dup+0x50>
80104fa0:	e8 db ec ff ff       	call   80103c80 <myproc>
80104fa5:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104fa8:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
80104fac:	85 f6                	test   %esi,%esi
80104fae:	74 20                	je     80104fd0 <sys_dup+0x50>
  struct proc *curproc = myproc();
80104fb0:	e8 cb ec ff ff       	call   80103c80 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80104fb5:	31 db                	xor    %ebx,%ebx
80104fb7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104fbe:	66 90                	xchg   %ax,%ax
    if(curproc->ofile[fd] == 0){
80104fc0:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80104fc4:	85 d2                	test   %edx,%edx
80104fc6:	74 18                	je     80104fe0 <sys_dup+0x60>
  for(fd = 0; fd < NOFILE; fd++){
80104fc8:	83 c3 01             	add    $0x1,%ebx
80104fcb:	83 fb 10             	cmp    $0x10,%ebx
80104fce:	75 f0                	jne    80104fc0 <sys_dup+0x40>
}
80104fd0:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return -1;
80104fd3:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
80104fd8:	89 d8                	mov    %ebx,%eax
80104fda:	5b                   	pop    %ebx
80104fdb:	5e                   	pop    %esi
80104fdc:	5d                   	pop    %ebp
80104fdd:	c3                   	ret    
80104fde:	66 90                	xchg   %ax,%ax
  filedup(f);
80104fe0:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
80104fe3:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)
  filedup(f);
80104fe7:	56                   	push   %esi
80104fe8:	e8 c3 c1 ff ff       	call   801011b0 <filedup>
  return fd;
80104fed:	83 c4 10             	add    $0x10,%esp
}
80104ff0:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104ff3:	89 d8                	mov    %ebx,%eax
80104ff5:	5b                   	pop    %ebx
80104ff6:	5e                   	pop    %esi
80104ff7:	5d                   	pop    %ebp
80104ff8:	c3                   	ret    
80104ff9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105000 <sys_read>:
{
80105000:	55                   	push   %ebp
80105001:	89 e5                	mov    %esp,%ebp
80105003:	56                   	push   %esi
80105004:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80105005:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
80105008:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
8010500b:	53                   	push   %ebx
8010500c:	6a 00                	push   $0x0
8010500e:	e8 1d fc ff ff       	call   80104c30 <argint>
80105013:	83 c4 10             	add    $0x10,%esp
80105016:	85 c0                	test   %eax,%eax
80105018:	78 5e                	js     80105078 <sys_read+0x78>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
8010501a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
8010501e:	77 58                	ja     80105078 <sys_read+0x78>
80105020:	e8 5b ec ff ff       	call   80103c80 <myproc>
80105025:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105028:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
8010502c:	85 f6                	test   %esi,%esi
8010502e:	74 48                	je     80105078 <sys_read+0x78>
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105030:	83 ec 08             	sub    $0x8,%esp
80105033:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105036:	50                   	push   %eax
80105037:	6a 02                	push   $0x2
80105039:	e8 f2 fb ff ff       	call   80104c30 <argint>
8010503e:	83 c4 10             	add    $0x10,%esp
80105041:	85 c0                	test   %eax,%eax
80105043:	78 33                	js     80105078 <sys_read+0x78>
80105045:	83 ec 04             	sub    $0x4,%esp
80105048:	ff 75 f0             	push   -0x10(%ebp)
8010504b:	53                   	push   %ebx
8010504c:	6a 01                	push   $0x1
8010504e:	e8 2d fc ff ff       	call   80104c80 <argptr>
80105053:	83 c4 10             	add    $0x10,%esp
80105056:	85 c0                	test   %eax,%eax
80105058:	78 1e                	js     80105078 <sys_read+0x78>
  return fileread(f, p, n);
8010505a:	83 ec 04             	sub    $0x4,%esp
8010505d:	ff 75 f0             	push   -0x10(%ebp)
80105060:	ff 75 f4             	push   -0xc(%ebp)
80105063:	56                   	push   %esi
80105064:	e8 c7 c2 ff ff       	call   80101330 <fileread>
80105069:	83 c4 10             	add    $0x10,%esp
}
8010506c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010506f:	5b                   	pop    %ebx
80105070:	5e                   	pop    %esi
80105071:	5d                   	pop    %ebp
80105072:	c3                   	ret    
80105073:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105077:	90                   	nop
    return -1;
80105078:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010507d:	eb ed                	jmp    8010506c <sys_read+0x6c>
8010507f:	90                   	nop

80105080 <sys_write>:
{
80105080:	55                   	push   %ebp
80105081:	89 e5                	mov    %esp,%ebp
80105083:	56                   	push   %esi
80105084:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80105085:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
80105088:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
8010508b:	53                   	push   %ebx
8010508c:	6a 00                	push   $0x0
8010508e:	e8 9d fb ff ff       	call   80104c30 <argint>
80105093:	83 c4 10             	add    $0x10,%esp
80105096:	85 c0                	test   %eax,%eax
80105098:	78 5e                	js     801050f8 <sys_write+0x78>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
8010509a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
8010509e:	77 58                	ja     801050f8 <sys_write+0x78>
801050a0:	e8 db eb ff ff       	call   80103c80 <myproc>
801050a5:	8b 55 f4             	mov    -0xc(%ebp),%edx
801050a8:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
801050ac:	85 f6                	test   %esi,%esi
801050ae:	74 48                	je     801050f8 <sys_write+0x78>
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
801050b0:	83 ec 08             	sub    $0x8,%esp
801050b3:	8d 45 f0             	lea    -0x10(%ebp),%eax
801050b6:	50                   	push   %eax
801050b7:	6a 02                	push   $0x2
801050b9:	e8 72 fb ff ff       	call   80104c30 <argint>
801050be:	83 c4 10             	add    $0x10,%esp
801050c1:	85 c0                	test   %eax,%eax
801050c3:	78 33                	js     801050f8 <sys_write+0x78>
801050c5:	83 ec 04             	sub    $0x4,%esp
801050c8:	ff 75 f0             	push   -0x10(%ebp)
801050cb:	53                   	push   %ebx
801050cc:	6a 01                	push   $0x1
801050ce:	e8 ad fb ff ff       	call   80104c80 <argptr>
801050d3:	83 c4 10             	add    $0x10,%esp
801050d6:	85 c0                	test   %eax,%eax
801050d8:	78 1e                	js     801050f8 <sys_write+0x78>
  return filewrite(f, p, n);
801050da:	83 ec 04             	sub    $0x4,%esp
801050dd:	ff 75 f0             	push   -0x10(%ebp)
801050e0:	ff 75 f4             	push   -0xc(%ebp)
801050e3:	56                   	push   %esi
801050e4:	e8 d7 c2 ff ff       	call   801013c0 <filewrite>
801050e9:	83 c4 10             	add    $0x10,%esp
}
801050ec:	8d 65 f8             	lea    -0x8(%ebp),%esp
801050ef:	5b                   	pop    %ebx
801050f0:	5e                   	pop    %esi
801050f1:	5d                   	pop    %ebp
801050f2:	c3                   	ret    
801050f3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801050f7:	90                   	nop
    return -1;
801050f8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801050fd:	eb ed                	jmp    801050ec <sys_write+0x6c>
801050ff:	90                   	nop

80105100 <sys_close>:
{
80105100:	55                   	push   %ebp
80105101:	89 e5                	mov    %esp,%ebp
80105103:	56                   	push   %esi
80105104:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80105105:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105108:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
8010510b:	50                   	push   %eax
8010510c:	6a 00                	push   $0x0
8010510e:	e8 1d fb ff ff       	call   80104c30 <argint>
80105113:	83 c4 10             	add    $0x10,%esp
80105116:	85 c0                	test   %eax,%eax
80105118:	78 3e                	js     80105158 <sys_close+0x58>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
8010511a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
8010511e:	77 38                	ja     80105158 <sys_close+0x58>
80105120:	e8 5b eb ff ff       	call   80103c80 <myproc>
80105125:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105128:	8d 5a 08             	lea    0x8(%edx),%ebx
8010512b:	8b 74 98 08          	mov    0x8(%eax,%ebx,4),%esi
8010512f:	85 f6                	test   %esi,%esi
80105131:	74 25                	je     80105158 <sys_close+0x58>
  myproc()->ofile[fd] = 0;
80105133:	e8 48 eb ff ff       	call   80103c80 <myproc>
  fileclose(f);
80105138:	83 ec 0c             	sub    $0xc,%esp
  myproc()->ofile[fd] = 0;
8010513b:	c7 44 98 08 00 00 00 	movl   $0x0,0x8(%eax,%ebx,4)
80105142:	00 
  fileclose(f);
80105143:	56                   	push   %esi
80105144:	e8 b7 c0 ff ff       	call   80101200 <fileclose>
  return 0;
80105149:	83 c4 10             	add    $0x10,%esp
8010514c:	31 c0                	xor    %eax,%eax
}
8010514e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105151:	5b                   	pop    %ebx
80105152:	5e                   	pop    %esi
80105153:	5d                   	pop    %ebp
80105154:	c3                   	ret    
80105155:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80105158:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010515d:	eb ef                	jmp    8010514e <sys_close+0x4e>
8010515f:	90                   	nop

80105160 <sys_fstat>:
{
80105160:	55                   	push   %ebp
80105161:	89 e5                	mov    %esp,%ebp
80105163:	56                   	push   %esi
80105164:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80105165:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
80105168:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
8010516b:	53                   	push   %ebx
8010516c:	6a 00                	push   $0x0
8010516e:	e8 bd fa ff ff       	call   80104c30 <argint>
80105173:	83 c4 10             	add    $0x10,%esp
80105176:	85 c0                	test   %eax,%eax
80105178:	78 46                	js     801051c0 <sys_fstat+0x60>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
8010517a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
8010517e:	77 40                	ja     801051c0 <sys_fstat+0x60>
80105180:	e8 fb ea ff ff       	call   80103c80 <myproc>
80105185:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105188:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
8010518c:	85 f6                	test   %esi,%esi
8010518e:	74 30                	je     801051c0 <sys_fstat+0x60>
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80105190:	83 ec 04             	sub    $0x4,%esp
80105193:	6a 14                	push   $0x14
80105195:	53                   	push   %ebx
80105196:	6a 01                	push   $0x1
80105198:	e8 e3 fa ff ff       	call   80104c80 <argptr>
8010519d:	83 c4 10             	add    $0x10,%esp
801051a0:	85 c0                	test   %eax,%eax
801051a2:	78 1c                	js     801051c0 <sys_fstat+0x60>
  return filestat(f, st);
801051a4:	83 ec 08             	sub    $0x8,%esp
801051a7:	ff 75 f4             	push   -0xc(%ebp)
801051aa:	56                   	push   %esi
801051ab:	e8 30 c1 ff ff       	call   801012e0 <filestat>
801051b0:	83 c4 10             	add    $0x10,%esp
}
801051b3:	8d 65 f8             	lea    -0x8(%ebp),%esp
801051b6:	5b                   	pop    %ebx
801051b7:	5e                   	pop    %esi
801051b8:	5d                   	pop    %ebp
801051b9:	c3                   	ret    
801051ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
801051c0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801051c5:	eb ec                	jmp    801051b3 <sys_fstat+0x53>
801051c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801051ce:	66 90                	xchg   %ax,%ax

801051d0 <sys_link>:
{
801051d0:	55                   	push   %ebp
801051d1:	89 e5                	mov    %esp,%ebp
801051d3:	57                   	push   %edi
801051d4:	56                   	push   %esi
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
801051d5:	8d 45 d4             	lea    -0x2c(%ebp),%eax
{
801051d8:	53                   	push   %ebx
801051d9:	83 ec 34             	sub    $0x34,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
801051dc:	50                   	push   %eax
801051dd:	6a 00                	push   $0x0
801051df:	e8 0c fb ff ff       	call   80104cf0 <argstr>
801051e4:	83 c4 10             	add    $0x10,%esp
801051e7:	85 c0                	test   %eax,%eax
801051e9:	0f 88 fb 00 00 00    	js     801052ea <sys_link+0x11a>
801051ef:	83 ec 08             	sub    $0x8,%esp
801051f2:	8d 45 d0             	lea    -0x30(%ebp),%eax
801051f5:	50                   	push   %eax
801051f6:	6a 01                	push   $0x1
801051f8:	e8 f3 fa ff ff       	call   80104cf0 <argstr>
801051fd:	83 c4 10             	add    $0x10,%esp
80105200:	85 c0                	test   %eax,%eax
80105202:	0f 88 e2 00 00 00    	js     801052ea <sys_link+0x11a>
  begin_op();
80105208:	e8 63 de ff ff       	call   80103070 <begin_op>
  if((ip = namei(old)) == 0){
8010520d:	83 ec 0c             	sub    $0xc,%esp
80105210:	ff 75 d4             	push   -0x2c(%ebp)
80105213:	e8 98 d1 ff ff       	call   801023b0 <namei>
80105218:	83 c4 10             	add    $0x10,%esp
8010521b:	89 c3                	mov    %eax,%ebx
8010521d:	85 c0                	test   %eax,%eax
8010521f:	0f 84 e4 00 00 00    	je     80105309 <sys_link+0x139>
  ilock(ip);
80105225:	83 ec 0c             	sub    $0xc,%esp
80105228:	50                   	push   %eax
80105229:	e8 62 c8 ff ff       	call   80101a90 <ilock>
  if(ip->type == T_DIR){
8010522e:	83 c4 10             	add    $0x10,%esp
80105231:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105236:	0f 84 b5 00 00 00    	je     801052f1 <sys_link+0x121>
  iupdate(ip);
8010523c:	83 ec 0c             	sub    $0xc,%esp
  ip->nlink++;
8010523f:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  if((dp = nameiparent(new, name)) == 0)
80105244:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
80105247:	53                   	push   %ebx
80105248:	e8 93 c7 ff ff       	call   801019e0 <iupdate>
  iunlock(ip);
8010524d:	89 1c 24             	mov    %ebx,(%esp)
80105250:	e8 1b c9 ff ff       	call   80101b70 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
80105255:	58                   	pop    %eax
80105256:	5a                   	pop    %edx
80105257:	57                   	push   %edi
80105258:	ff 75 d0             	push   -0x30(%ebp)
8010525b:	e8 70 d1 ff ff       	call   801023d0 <nameiparent>
80105260:	83 c4 10             	add    $0x10,%esp
80105263:	89 c6                	mov    %eax,%esi
80105265:	85 c0                	test   %eax,%eax
80105267:	74 5b                	je     801052c4 <sys_link+0xf4>
  ilock(dp);
80105269:	83 ec 0c             	sub    $0xc,%esp
8010526c:	50                   	push   %eax
8010526d:	e8 1e c8 ff ff       	call   80101a90 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80105272:	8b 03                	mov    (%ebx),%eax
80105274:	83 c4 10             	add    $0x10,%esp
80105277:	39 06                	cmp    %eax,(%esi)
80105279:	75 3d                	jne    801052b8 <sys_link+0xe8>
8010527b:	83 ec 04             	sub    $0x4,%esp
8010527e:	ff 73 04             	push   0x4(%ebx)
80105281:	57                   	push   %edi
80105282:	56                   	push   %esi
80105283:	e8 68 d0 ff ff       	call   801022f0 <dirlink>
80105288:	83 c4 10             	add    $0x10,%esp
8010528b:	85 c0                	test   %eax,%eax
8010528d:	78 29                	js     801052b8 <sys_link+0xe8>
  iunlockput(dp);
8010528f:	83 ec 0c             	sub    $0xc,%esp
80105292:	56                   	push   %esi
80105293:	e8 88 ca ff ff       	call   80101d20 <iunlockput>
  iput(ip);
80105298:	89 1c 24             	mov    %ebx,(%esp)
8010529b:	e8 20 c9 ff ff       	call   80101bc0 <iput>
  end_op();
801052a0:	e8 3b de ff ff       	call   801030e0 <end_op>
  return 0;
801052a5:	83 c4 10             	add    $0x10,%esp
801052a8:	31 c0                	xor    %eax,%eax
}
801052aa:	8d 65 f4             	lea    -0xc(%ebp),%esp
801052ad:	5b                   	pop    %ebx
801052ae:	5e                   	pop    %esi
801052af:	5f                   	pop    %edi
801052b0:	5d                   	pop    %ebp
801052b1:	c3                   	ret    
801052b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(dp);
801052b8:	83 ec 0c             	sub    $0xc,%esp
801052bb:	56                   	push   %esi
801052bc:	e8 5f ca ff ff       	call   80101d20 <iunlockput>
    goto bad;
801052c1:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
801052c4:	83 ec 0c             	sub    $0xc,%esp
801052c7:	53                   	push   %ebx
801052c8:	e8 c3 c7 ff ff       	call   80101a90 <ilock>
  ip->nlink--;
801052cd:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
801052d2:	89 1c 24             	mov    %ebx,(%esp)
801052d5:	e8 06 c7 ff ff       	call   801019e0 <iupdate>
  iunlockput(ip);
801052da:	89 1c 24             	mov    %ebx,(%esp)
801052dd:	e8 3e ca ff ff       	call   80101d20 <iunlockput>
  end_op();
801052e2:	e8 f9 dd ff ff       	call   801030e0 <end_op>
  return -1;
801052e7:	83 c4 10             	add    $0x10,%esp
801052ea:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801052ef:	eb b9                	jmp    801052aa <sys_link+0xda>
    iunlockput(ip);
801052f1:	83 ec 0c             	sub    $0xc,%esp
801052f4:	53                   	push   %ebx
801052f5:	e8 26 ca ff ff       	call   80101d20 <iunlockput>
    end_op();
801052fa:	e8 e1 dd ff ff       	call   801030e0 <end_op>
    return -1;
801052ff:	83 c4 10             	add    $0x10,%esp
80105302:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105307:	eb a1                	jmp    801052aa <sys_link+0xda>
    end_op();
80105309:	e8 d2 dd ff ff       	call   801030e0 <end_op>
    return -1;
8010530e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105313:	eb 95                	jmp    801052aa <sys_link+0xda>
80105315:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010531c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105320 <sys_unlink>:
{
80105320:	55                   	push   %ebp
80105321:	89 e5                	mov    %esp,%ebp
80105323:	57                   	push   %edi
80105324:	56                   	push   %esi
  if(argstr(0, &path) < 0)
80105325:	8d 45 c0             	lea    -0x40(%ebp),%eax
{
80105328:	53                   	push   %ebx
80105329:	83 ec 54             	sub    $0x54,%esp
  if(argstr(0, &path) < 0)
8010532c:	50                   	push   %eax
8010532d:	6a 00                	push   $0x0
8010532f:	e8 bc f9 ff ff       	call   80104cf0 <argstr>
80105334:	83 c4 10             	add    $0x10,%esp
80105337:	85 c0                	test   %eax,%eax
80105339:	0f 88 7a 01 00 00    	js     801054b9 <sys_unlink+0x199>
  begin_op();
8010533f:	e8 2c dd ff ff       	call   80103070 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80105344:	8d 5d ca             	lea    -0x36(%ebp),%ebx
80105347:	83 ec 08             	sub    $0x8,%esp
8010534a:	53                   	push   %ebx
8010534b:	ff 75 c0             	push   -0x40(%ebp)
8010534e:	e8 7d d0 ff ff       	call   801023d0 <nameiparent>
80105353:	83 c4 10             	add    $0x10,%esp
80105356:	89 45 b4             	mov    %eax,-0x4c(%ebp)
80105359:	85 c0                	test   %eax,%eax
8010535b:	0f 84 62 01 00 00    	je     801054c3 <sys_unlink+0x1a3>
  ilock(dp);
80105361:	8b 7d b4             	mov    -0x4c(%ebp),%edi
80105364:	83 ec 0c             	sub    $0xc,%esp
80105367:	57                   	push   %edi
80105368:	e8 23 c7 ff ff       	call   80101a90 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
8010536d:	58                   	pop    %eax
8010536e:	5a                   	pop    %edx
8010536f:	68 34 7c 10 80       	push   $0x80107c34
80105374:	53                   	push   %ebx
80105375:	e8 56 cc ff ff       	call   80101fd0 <namecmp>
8010537a:	83 c4 10             	add    $0x10,%esp
8010537d:	85 c0                	test   %eax,%eax
8010537f:	0f 84 fb 00 00 00    	je     80105480 <sys_unlink+0x160>
80105385:	83 ec 08             	sub    $0x8,%esp
80105388:	68 33 7c 10 80       	push   $0x80107c33
8010538d:	53                   	push   %ebx
8010538e:	e8 3d cc ff ff       	call   80101fd0 <namecmp>
80105393:	83 c4 10             	add    $0x10,%esp
80105396:	85 c0                	test   %eax,%eax
80105398:	0f 84 e2 00 00 00    	je     80105480 <sys_unlink+0x160>
  if((ip = dirlookup(dp, name, &off)) == 0)
8010539e:	83 ec 04             	sub    $0x4,%esp
801053a1:	8d 45 c4             	lea    -0x3c(%ebp),%eax
801053a4:	50                   	push   %eax
801053a5:	53                   	push   %ebx
801053a6:	57                   	push   %edi
801053a7:	e8 44 cc ff ff       	call   80101ff0 <dirlookup>
801053ac:	83 c4 10             	add    $0x10,%esp
801053af:	89 c3                	mov    %eax,%ebx
801053b1:	85 c0                	test   %eax,%eax
801053b3:	0f 84 c7 00 00 00    	je     80105480 <sys_unlink+0x160>
  ilock(ip);
801053b9:	83 ec 0c             	sub    $0xc,%esp
801053bc:	50                   	push   %eax
801053bd:	e8 ce c6 ff ff       	call   80101a90 <ilock>
  if(ip->nlink < 1)
801053c2:	83 c4 10             	add    $0x10,%esp
801053c5:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
801053ca:	0f 8e 1c 01 00 00    	jle    801054ec <sys_unlink+0x1cc>
  if(ip->type == T_DIR && !isdirempty(ip)){
801053d0:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801053d5:	8d 7d d8             	lea    -0x28(%ebp),%edi
801053d8:	74 66                	je     80105440 <sys_unlink+0x120>
  memset(&de, 0, sizeof(de));
801053da:	83 ec 04             	sub    $0x4,%esp
801053dd:	6a 10                	push   $0x10
801053df:	6a 00                	push   $0x0
801053e1:	57                   	push   %edi
801053e2:	e8 89 f5 ff ff       	call   80104970 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801053e7:	6a 10                	push   $0x10
801053e9:	ff 75 c4             	push   -0x3c(%ebp)
801053ec:	57                   	push   %edi
801053ed:	ff 75 b4             	push   -0x4c(%ebp)
801053f0:	e8 ab ca ff ff       	call   80101ea0 <writei>
801053f5:	83 c4 20             	add    $0x20,%esp
801053f8:	83 f8 10             	cmp    $0x10,%eax
801053fb:	0f 85 de 00 00 00    	jne    801054df <sys_unlink+0x1bf>
  if(ip->type == T_DIR){
80105401:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105406:	0f 84 94 00 00 00    	je     801054a0 <sys_unlink+0x180>
  iunlockput(dp);
8010540c:	83 ec 0c             	sub    $0xc,%esp
8010540f:	ff 75 b4             	push   -0x4c(%ebp)
80105412:	e8 09 c9 ff ff       	call   80101d20 <iunlockput>
  ip->nlink--;
80105417:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
8010541c:	89 1c 24             	mov    %ebx,(%esp)
8010541f:	e8 bc c5 ff ff       	call   801019e0 <iupdate>
  iunlockput(ip);
80105424:	89 1c 24             	mov    %ebx,(%esp)
80105427:	e8 f4 c8 ff ff       	call   80101d20 <iunlockput>
  end_op();
8010542c:	e8 af dc ff ff       	call   801030e0 <end_op>
  return 0;
80105431:	83 c4 10             	add    $0x10,%esp
80105434:	31 c0                	xor    %eax,%eax
}
80105436:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105439:	5b                   	pop    %ebx
8010543a:	5e                   	pop    %esi
8010543b:	5f                   	pop    %edi
8010543c:	5d                   	pop    %ebp
8010543d:	c3                   	ret    
8010543e:	66 90                	xchg   %ax,%ax
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80105440:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
80105444:	76 94                	jbe    801053da <sys_unlink+0xba>
80105446:	be 20 00 00 00       	mov    $0x20,%esi
8010544b:	eb 0b                	jmp    80105458 <sys_unlink+0x138>
8010544d:	8d 76 00             	lea    0x0(%esi),%esi
80105450:	83 c6 10             	add    $0x10,%esi
80105453:	3b 73 58             	cmp    0x58(%ebx),%esi
80105456:	73 82                	jae    801053da <sys_unlink+0xba>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105458:	6a 10                	push   $0x10
8010545a:	56                   	push   %esi
8010545b:	57                   	push   %edi
8010545c:	53                   	push   %ebx
8010545d:	e8 3e c9 ff ff       	call   80101da0 <readi>
80105462:	83 c4 10             	add    $0x10,%esp
80105465:	83 f8 10             	cmp    $0x10,%eax
80105468:	75 68                	jne    801054d2 <sys_unlink+0x1b2>
    if(de.inum != 0)
8010546a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
8010546f:	74 df                	je     80105450 <sys_unlink+0x130>
    iunlockput(ip);
80105471:	83 ec 0c             	sub    $0xc,%esp
80105474:	53                   	push   %ebx
80105475:	e8 a6 c8 ff ff       	call   80101d20 <iunlockput>
    goto bad;
8010547a:	83 c4 10             	add    $0x10,%esp
8010547d:	8d 76 00             	lea    0x0(%esi),%esi
  iunlockput(dp);
80105480:	83 ec 0c             	sub    $0xc,%esp
80105483:	ff 75 b4             	push   -0x4c(%ebp)
80105486:	e8 95 c8 ff ff       	call   80101d20 <iunlockput>
  end_op();
8010548b:	e8 50 dc ff ff       	call   801030e0 <end_op>
  return -1;
80105490:	83 c4 10             	add    $0x10,%esp
80105493:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105498:	eb 9c                	jmp    80105436 <sys_unlink+0x116>
8010549a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    dp->nlink--;
801054a0:	8b 45 b4             	mov    -0x4c(%ebp),%eax
    iupdate(dp);
801054a3:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink--;
801054a6:	66 83 68 56 01       	subw   $0x1,0x56(%eax)
    iupdate(dp);
801054ab:	50                   	push   %eax
801054ac:	e8 2f c5 ff ff       	call   801019e0 <iupdate>
801054b1:	83 c4 10             	add    $0x10,%esp
801054b4:	e9 53 ff ff ff       	jmp    8010540c <sys_unlink+0xec>
    return -1;
801054b9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801054be:	e9 73 ff ff ff       	jmp    80105436 <sys_unlink+0x116>
    end_op();
801054c3:	e8 18 dc ff ff       	call   801030e0 <end_op>
    return -1;
801054c8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801054cd:	e9 64 ff ff ff       	jmp    80105436 <sys_unlink+0x116>
      panic("isdirempty: readi");
801054d2:	83 ec 0c             	sub    $0xc,%esp
801054d5:	68 58 7c 10 80       	push   $0x80107c58
801054da:	e8 a1 ae ff ff       	call   80100380 <panic>
    panic("unlink: writei");
801054df:	83 ec 0c             	sub    $0xc,%esp
801054e2:	68 6a 7c 10 80       	push   $0x80107c6a
801054e7:	e8 94 ae ff ff       	call   80100380 <panic>
    panic("unlink: nlink < 1");
801054ec:	83 ec 0c             	sub    $0xc,%esp
801054ef:	68 46 7c 10 80       	push   $0x80107c46
801054f4:	e8 87 ae ff ff       	call   80100380 <panic>
801054f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105500 <sys_open>:

int
sys_open(void)
{
80105500:	55                   	push   %ebp
80105501:	89 e5                	mov    %esp,%ebp
80105503:	57                   	push   %edi
80105504:	56                   	push   %esi
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105505:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
80105508:	53                   	push   %ebx
80105509:	83 ec 24             	sub    $0x24,%esp
  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
8010550c:	50                   	push   %eax
8010550d:	6a 00                	push   $0x0
8010550f:	e8 dc f7 ff ff       	call   80104cf0 <argstr>
80105514:	83 c4 10             	add    $0x10,%esp
80105517:	85 c0                	test   %eax,%eax
80105519:	0f 88 8e 00 00 00    	js     801055ad <sys_open+0xad>
8010551f:	83 ec 08             	sub    $0x8,%esp
80105522:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105525:	50                   	push   %eax
80105526:	6a 01                	push   $0x1
80105528:	e8 03 f7 ff ff       	call   80104c30 <argint>
8010552d:	83 c4 10             	add    $0x10,%esp
80105530:	85 c0                	test   %eax,%eax
80105532:	78 79                	js     801055ad <sys_open+0xad>
    return -1;

  begin_op();
80105534:	e8 37 db ff ff       	call   80103070 <begin_op>

  if(omode & O_CREATE){
80105539:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
8010553d:	75 79                	jne    801055b8 <sys_open+0xb8>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
8010553f:	83 ec 0c             	sub    $0xc,%esp
80105542:	ff 75 e0             	push   -0x20(%ebp)
80105545:	e8 66 ce ff ff       	call   801023b0 <namei>
8010554a:	83 c4 10             	add    $0x10,%esp
8010554d:	89 c6                	mov    %eax,%esi
8010554f:	85 c0                	test   %eax,%eax
80105551:	0f 84 7e 00 00 00    	je     801055d5 <sys_open+0xd5>
      end_op();
      return -1;
    }
    ilock(ip);
80105557:	83 ec 0c             	sub    $0xc,%esp
8010555a:	50                   	push   %eax
8010555b:	e8 30 c5 ff ff       	call   80101a90 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
80105560:	83 c4 10             	add    $0x10,%esp
80105563:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80105568:	0f 84 c2 00 00 00    	je     80105630 <sys_open+0x130>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
8010556e:	e8 cd bb ff ff       	call   80101140 <filealloc>
80105573:	89 c7                	mov    %eax,%edi
80105575:	85 c0                	test   %eax,%eax
80105577:	74 23                	je     8010559c <sys_open+0x9c>
  struct proc *curproc = myproc();
80105579:	e8 02 e7 ff ff       	call   80103c80 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
8010557e:	31 db                	xor    %ebx,%ebx
    if(curproc->ofile[fd] == 0){
80105580:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105584:	85 d2                	test   %edx,%edx
80105586:	74 60                	je     801055e8 <sys_open+0xe8>
  for(fd = 0; fd < NOFILE; fd++){
80105588:	83 c3 01             	add    $0x1,%ebx
8010558b:	83 fb 10             	cmp    $0x10,%ebx
8010558e:	75 f0                	jne    80105580 <sys_open+0x80>
    if(f)
      fileclose(f);
80105590:	83 ec 0c             	sub    $0xc,%esp
80105593:	57                   	push   %edi
80105594:	e8 67 bc ff ff       	call   80101200 <fileclose>
80105599:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
8010559c:	83 ec 0c             	sub    $0xc,%esp
8010559f:	56                   	push   %esi
801055a0:	e8 7b c7 ff ff       	call   80101d20 <iunlockput>
    end_op();
801055a5:	e8 36 db ff ff       	call   801030e0 <end_op>
    return -1;
801055aa:	83 c4 10             	add    $0x10,%esp
801055ad:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801055b2:	eb 6d                	jmp    80105621 <sys_open+0x121>
801055b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ip = create(path, T_FILE, 0, 0);
801055b8:	83 ec 0c             	sub    $0xc,%esp
801055bb:	8b 45 e0             	mov    -0x20(%ebp),%eax
801055be:	31 c9                	xor    %ecx,%ecx
801055c0:	ba 02 00 00 00       	mov    $0x2,%edx
801055c5:	6a 00                	push   $0x0
801055c7:	e8 14 f8 ff ff       	call   80104de0 <create>
    if(ip == 0){
801055cc:	83 c4 10             	add    $0x10,%esp
    ip = create(path, T_FILE, 0, 0);
801055cf:	89 c6                	mov    %eax,%esi
    if(ip == 0){
801055d1:	85 c0                	test   %eax,%eax
801055d3:	75 99                	jne    8010556e <sys_open+0x6e>
      end_op();
801055d5:	e8 06 db ff ff       	call   801030e0 <end_op>
      return -1;
801055da:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801055df:	eb 40                	jmp    80105621 <sys_open+0x121>
801055e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  }
  iunlock(ip);
801055e8:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
801055eb:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
  iunlock(ip);
801055ef:	56                   	push   %esi
801055f0:	e8 7b c5 ff ff       	call   80101b70 <iunlock>
  end_op();
801055f5:	e8 e6 da ff ff       	call   801030e0 <end_op>

  f->type = FD_INODE;
801055fa:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
80105600:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105603:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
80105606:	89 77 10             	mov    %esi,0x10(%edi)
  f->readable = !(omode & O_WRONLY);
80105609:	89 d0                	mov    %edx,%eax
  f->off = 0;
8010560b:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
80105612:	f7 d0                	not    %eax
80105614:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105617:	83 e2 03             	and    $0x3,%edx
  f->readable = !(omode & O_WRONLY);
8010561a:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
8010561d:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
}
80105621:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105624:	89 d8                	mov    %ebx,%eax
80105626:	5b                   	pop    %ebx
80105627:	5e                   	pop    %esi
80105628:	5f                   	pop    %edi
80105629:	5d                   	pop    %ebp
8010562a:	c3                   	ret    
8010562b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010562f:	90                   	nop
    if(ip->type == T_DIR && omode != O_RDONLY){
80105630:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80105633:	85 c9                	test   %ecx,%ecx
80105635:	0f 84 33 ff ff ff    	je     8010556e <sys_open+0x6e>
8010563b:	e9 5c ff ff ff       	jmp    8010559c <sys_open+0x9c>

80105640 <sys_mkdir>:

int
sys_mkdir(void)
{
80105640:	55                   	push   %ebp
80105641:	89 e5                	mov    %esp,%ebp
80105643:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
80105646:	e8 25 da ff ff       	call   80103070 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
8010564b:	83 ec 08             	sub    $0x8,%esp
8010564e:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105651:	50                   	push   %eax
80105652:	6a 00                	push   $0x0
80105654:	e8 97 f6 ff ff       	call   80104cf0 <argstr>
80105659:	83 c4 10             	add    $0x10,%esp
8010565c:	85 c0                	test   %eax,%eax
8010565e:	78 30                	js     80105690 <sys_mkdir+0x50>
80105660:	83 ec 0c             	sub    $0xc,%esp
80105663:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105666:	31 c9                	xor    %ecx,%ecx
80105668:	ba 01 00 00 00       	mov    $0x1,%edx
8010566d:	6a 00                	push   $0x0
8010566f:	e8 6c f7 ff ff       	call   80104de0 <create>
80105674:	83 c4 10             	add    $0x10,%esp
80105677:	85 c0                	test   %eax,%eax
80105679:	74 15                	je     80105690 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010567b:	83 ec 0c             	sub    $0xc,%esp
8010567e:	50                   	push   %eax
8010567f:	e8 9c c6 ff ff       	call   80101d20 <iunlockput>
  end_op();
80105684:	e8 57 da ff ff       	call   801030e0 <end_op>
  return 0;
80105689:	83 c4 10             	add    $0x10,%esp
8010568c:	31 c0                	xor    %eax,%eax
}
8010568e:	c9                   	leave  
8010568f:	c3                   	ret    
    end_op();
80105690:	e8 4b da ff ff       	call   801030e0 <end_op>
    return -1;
80105695:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010569a:	c9                   	leave  
8010569b:	c3                   	ret    
8010569c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801056a0 <sys_mknod>:

int
sys_mknod(void)
{
801056a0:	55                   	push   %ebp
801056a1:	89 e5                	mov    %esp,%ebp
801056a3:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
801056a6:	e8 c5 d9 ff ff       	call   80103070 <begin_op>
  if((argstr(0, &path)) < 0 ||
801056ab:	83 ec 08             	sub    $0x8,%esp
801056ae:	8d 45 ec             	lea    -0x14(%ebp),%eax
801056b1:	50                   	push   %eax
801056b2:	6a 00                	push   $0x0
801056b4:	e8 37 f6 ff ff       	call   80104cf0 <argstr>
801056b9:	83 c4 10             	add    $0x10,%esp
801056bc:	85 c0                	test   %eax,%eax
801056be:	78 60                	js     80105720 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
801056c0:	83 ec 08             	sub    $0x8,%esp
801056c3:	8d 45 f0             	lea    -0x10(%ebp),%eax
801056c6:	50                   	push   %eax
801056c7:	6a 01                	push   $0x1
801056c9:	e8 62 f5 ff ff       	call   80104c30 <argint>
  if((argstr(0, &path)) < 0 ||
801056ce:	83 c4 10             	add    $0x10,%esp
801056d1:	85 c0                	test   %eax,%eax
801056d3:	78 4b                	js     80105720 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
801056d5:	83 ec 08             	sub    $0x8,%esp
801056d8:	8d 45 f4             	lea    -0xc(%ebp),%eax
801056db:	50                   	push   %eax
801056dc:	6a 02                	push   $0x2
801056de:	e8 4d f5 ff ff       	call   80104c30 <argint>
     argint(1, &major) < 0 ||
801056e3:	83 c4 10             	add    $0x10,%esp
801056e6:	85 c0                	test   %eax,%eax
801056e8:	78 36                	js     80105720 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
801056ea:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
801056ee:	83 ec 0c             	sub    $0xc,%esp
801056f1:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
801056f5:	ba 03 00 00 00       	mov    $0x3,%edx
801056fa:	50                   	push   %eax
801056fb:	8b 45 ec             	mov    -0x14(%ebp),%eax
801056fe:	e8 dd f6 ff ff       	call   80104de0 <create>
     argint(2, &minor) < 0 ||
80105703:	83 c4 10             	add    $0x10,%esp
80105706:	85 c0                	test   %eax,%eax
80105708:	74 16                	je     80105720 <sys_mknod+0x80>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010570a:	83 ec 0c             	sub    $0xc,%esp
8010570d:	50                   	push   %eax
8010570e:	e8 0d c6 ff ff       	call   80101d20 <iunlockput>
  end_op();
80105713:	e8 c8 d9 ff ff       	call   801030e0 <end_op>
  return 0;
80105718:	83 c4 10             	add    $0x10,%esp
8010571b:	31 c0                	xor    %eax,%eax
}
8010571d:	c9                   	leave  
8010571e:	c3                   	ret    
8010571f:	90                   	nop
    end_op();
80105720:	e8 bb d9 ff ff       	call   801030e0 <end_op>
    return -1;
80105725:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010572a:	c9                   	leave  
8010572b:	c3                   	ret    
8010572c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105730 <sys_chdir>:

int
sys_chdir(void)
{
80105730:	55                   	push   %ebp
80105731:	89 e5                	mov    %esp,%ebp
80105733:	56                   	push   %esi
80105734:	53                   	push   %ebx
80105735:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
80105738:	e8 43 e5 ff ff       	call   80103c80 <myproc>
8010573d:	89 c6                	mov    %eax,%esi
  
  begin_op();
8010573f:	e8 2c d9 ff ff       	call   80103070 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
80105744:	83 ec 08             	sub    $0x8,%esp
80105747:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010574a:	50                   	push   %eax
8010574b:	6a 00                	push   $0x0
8010574d:	e8 9e f5 ff ff       	call   80104cf0 <argstr>
80105752:	83 c4 10             	add    $0x10,%esp
80105755:	85 c0                	test   %eax,%eax
80105757:	78 77                	js     801057d0 <sys_chdir+0xa0>
80105759:	83 ec 0c             	sub    $0xc,%esp
8010575c:	ff 75 f4             	push   -0xc(%ebp)
8010575f:	e8 4c cc ff ff       	call   801023b0 <namei>
80105764:	83 c4 10             	add    $0x10,%esp
80105767:	89 c3                	mov    %eax,%ebx
80105769:	85 c0                	test   %eax,%eax
8010576b:	74 63                	je     801057d0 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
8010576d:	83 ec 0c             	sub    $0xc,%esp
80105770:	50                   	push   %eax
80105771:	e8 1a c3 ff ff       	call   80101a90 <ilock>
  if(ip->type != T_DIR){
80105776:	83 c4 10             	add    $0x10,%esp
80105779:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
8010577e:	75 30                	jne    801057b0 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105780:	83 ec 0c             	sub    $0xc,%esp
80105783:	53                   	push   %ebx
80105784:	e8 e7 c3 ff ff       	call   80101b70 <iunlock>
  iput(curproc->cwd);
80105789:	58                   	pop    %eax
8010578a:	ff 76 68             	push   0x68(%esi)
8010578d:	e8 2e c4 ff ff       	call   80101bc0 <iput>
  end_op();
80105792:	e8 49 d9 ff ff       	call   801030e0 <end_op>
  curproc->cwd = ip;
80105797:	89 5e 68             	mov    %ebx,0x68(%esi)
  return 0;
8010579a:	83 c4 10             	add    $0x10,%esp
8010579d:	31 c0                	xor    %eax,%eax
}
8010579f:	8d 65 f8             	lea    -0x8(%ebp),%esp
801057a2:	5b                   	pop    %ebx
801057a3:	5e                   	pop    %esi
801057a4:	5d                   	pop    %ebp
801057a5:	c3                   	ret    
801057a6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801057ad:	8d 76 00             	lea    0x0(%esi),%esi
    iunlockput(ip);
801057b0:	83 ec 0c             	sub    $0xc,%esp
801057b3:	53                   	push   %ebx
801057b4:	e8 67 c5 ff ff       	call   80101d20 <iunlockput>
    end_op();
801057b9:	e8 22 d9 ff ff       	call   801030e0 <end_op>
    return -1;
801057be:	83 c4 10             	add    $0x10,%esp
801057c1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801057c6:	eb d7                	jmp    8010579f <sys_chdir+0x6f>
801057c8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801057cf:	90                   	nop
    end_op();
801057d0:	e8 0b d9 ff ff       	call   801030e0 <end_op>
    return -1;
801057d5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801057da:	eb c3                	jmp    8010579f <sys_chdir+0x6f>
801057dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801057e0 <sys_exec>:

int
sys_exec(void)
{
801057e0:	55                   	push   %ebp
801057e1:	89 e5                	mov    %esp,%ebp
801057e3:	57                   	push   %edi
801057e4:	56                   	push   %esi
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
801057e5:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
{
801057eb:	53                   	push   %ebx
801057ec:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
801057f2:	50                   	push   %eax
801057f3:	6a 00                	push   $0x0
801057f5:	e8 f6 f4 ff ff       	call   80104cf0 <argstr>
801057fa:	83 c4 10             	add    $0x10,%esp
801057fd:	85 c0                	test   %eax,%eax
801057ff:	0f 88 87 00 00 00    	js     8010588c <sys_exec+0xac>
80105805:	83 ec 08             	sub    $0x8,%esp
80105808:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
8010580e:	50                   	push   %eax
8010580f:	6a 01                	push   $0x1
80105811:	e8 1a f4 ff ff       	call   80104c30 <argint>
80105816:	83 c4 10             	add    $0x10,%esp
80105819:	85 c0                	test   %eax,%eax
8010581b:	78 6f                	js     8010588c <sys_exec+0xac>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
8010581d:	83 ec 04             	sub    $0x4,%esp
80105820:	8d b5 68 ff ff ff    	lea    -0x98(%ebp),%esi
  for(i=0;; i++){
80105826:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
80105828:	68 80 00 00 00       	push   $0x80
8010582d:	6a 00                	push   $0x0
8010582f:	56                   	push   %esi
80105830:	e8 3b f1 ff ff       	call   80104970 <memset>
80105835:	83 c4 10             	add    $0x10,%esp
80105838:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010583f:	90                   	nop
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
80105840:	83 ec 08             	sub    $0x8,%esp
80105843:	8d 85 64 ff ff ff    	lea    -0x9c(%ebp),%eax
80105849:	8d 3c 9d 00 00 00 00 	lea    0x0(,%ebx,4),%edi
80105850:	50                   	push   %eax
80105851:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
80105857:	01 f8                	add    %edi,%eax
80105859:	50                   	push   %eax
8010585a:	e8 41 f3 ff ff       	call   80104ba0 <fetchint>
8010585f:	83 c4 10             	add    $0x10,%esp
80105862:	85 c0                	test   %eax,%eax
80105864:	78 26                	js     8010588c <sys_exec+0xac>
      return -1;
    if(uarg == 0){
80105866:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
8010586c:	85 c0                	test   %eax,%eax
8010586e:	74 30                	je     801058a0 <sys_exec+0xc0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
80105870:	83 ec 08             	sub    $0x8,%esp
80105873:	8d 14 3e             	lea    (%esi,%edi,1),%edx
80105876:	52                   	push   %edx
80105877:	50                   	push   %eax
80105878:	e8 63 f3 ff ff       	call   80104be0 <fetchstr>
8010587d:	83 c4 10             	add    $0x10,%esp
80105880:	85 c0                	test   %eax,%eax
80105882:	78 08                	js     8010588c <sys_exec+0xac>
  for(i=0;; i++){
80105884:	83 c3 01             	add    $0x1,%ebx
    if(i >= NELEM(argv))
80105887:	83 fb 20             	cmp    $0x20,%ebx
8010588a:	75 b4                	jne    80105840 <sys_exec+0x60>
      return -1;
  }
  return exec(path, argv);
}
8010588c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
8010588f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105894:	5b                   	pop    %ebx
80105895:	5e                   	pop    %esi
80105896:	5f                   	pop    %edi
80105897:	5d                   	pop    %ebp
80105898:	c3                   	ret    
80105899:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      argv[i] = 0;
801058a0:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
801058a7:	00 00 00 00 
  return exec(path, argv);
801058ab:	83 ec 08             	sub    $0x8,%esp
801058ae:	56                   	push   %esi
801058af:	ff b5 5c ff ff ff    	push   -0xa4(%ebp)
801058b5:	e8 06 b5 ff ff       	call   80100dc0 <exec>
801058ba:	83 c4 10             	add    $0x10,%esp
}
801058bd:	8d 65 f4             	lea    -0xc(%ebp),%esp
801058c0:	5b                   	pop    %ebx
801058c1:	5e                   	pop    %esi
801058c2:	5f                   	pop    %edi
801058c3:	5d                   	pop    %ebp
801058c4:	c3                   	ret    
801058c5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801058cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801058d0 <sys_pipe>:

int
sys_pipe(void)
{
801058d0:	55                   	push   %ebp
801058d1:	89 e5                	mov    %esp,%ebp
801058d3:	57                   	push   %edi
801058d4:	56                   	push   %esi
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
801058d5:	8d 45 dc             	lea    -0x24(%ebp),%eax
{
801058d8:	53                   	push   %ebx
801058d9:	83 ec 20             	sub    $0x20,%esp
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
801058dc:	6a 08                	push   $0x8
801058de:	50                   	push   %eax
801058df:	6a 00                	push   $0x0
801058e1:	e8 9a f3 ff ff       	call   80104c80 <argptr>
801058e6:	83 c4 10             	add    $0x10,%esp
801058e9:	85 c0                	test   %eax,%eax
801058eb:	78 4a                	js     80105937 <sys_pipe+0x67>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
801058ed:	83 ec 08             	sub    $0x8,%esp
801058f0:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801058f3:	50                   	push   %eax
801058f4:	8d 45 e0             	lea    -0x20(%ebp),%eax
801058f7:	50                   	push   %eax
801058f8:	e8 43 de ff ff       	call   80103740 <pipealloc>
801058fd:	83 c4 10             	add    $0x10,%esp
80105900:	85 c0                	test   %eax,%eax
80105902:	78 33                	js     80105937 <sys_pipe+0x67>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105904:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(fd = 0; fd < NOFILE; fd++){
80105907:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
80105909:	e8 72 e3 ff ff       	call   80103c80 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
8010590e:	66 90                	xchg   %ax,%ax
    if(curproc->ofile[fd] == 0){
80105910:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
80105914:	85 f6                	test   %esi,%esi
80105916:	74 28                	je     80105940 <sys_pipe+0x70>
  for(fd = 0; fd < NOFILE; fd++){
80105918:	83 c3 01             	add    $0x1,%ebx
8010591b:	83 fb 10             	cmp    $0x10,%ebx
8010591e:	75 f0                	jne    80105910 <sys_pipe+0x40>
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
80105920:	83 ec 0c             	sub    $0xc,%esp
80105923:	ff 75 e0             	push   -0x20(%ebp)
80105926:	e8 d5 b8 ff ff       	call   80101200 <fileclose>
    fileclose(wf);
8010592b:	58                   	pop    %eax
8010592c:	ff 75 e4             	push   -0x1c(%ebp)
8010592f:	e8 cc b8 ff ff       	call   80101200 <fileclose>
    return -1;
80105934:	83 c4 10             	add    $0x10,%esp
80105937:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010593c:	eb 53                	jmp    80105991 <sys_pipe+0xc1>
8010593e:	66 90                	xchg   %ax,%ax
      curproc->ofile[fd] = f;
80105940:	8d 73 08             	lea    0x8(%ebx),%esi
80105943:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105947:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  struct proc *curproc = myproc();
8010594a:	e8 31 e3 ff ff       	call   80103c80 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
8010594f:	31 d2                	xor    %edx,%edx
80105951:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[fd] == 0){
80105958:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
8010595c:	85 c9                	test   %ecx,%ecx
8010595e:	74 20                	je     80105980 <sys_pipe+0xb0>
  for(fd = 0; fd < NOFILE; fd++){
80105960:	83 c2 01             	add    $0x1,%edx
80105963:	83 fa 10             	cmp    $0x10,%edx
80105966:	75 f0                	jne    80105958 <sys_pipe+0x88>
      myproc()->ofile[fd0] = 0;
80105968:	e8 13 e3 ff ff       	call   80103c80 <myproc>
8010596d:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
80105974:	00 
80105975:	eb a9                	jmp    80105920 <sys_pipe+0x50>
80105977:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010597e:	66 90                	xchg   %ax,%ax
      curproc->ofile[fd] = f;
80105980:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
  }
  fd[0] = fd0;
80105984:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105987:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
80105989:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010598c:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
8010598f:	31 c0                	xor    %eax,%eax
}
80105991:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105994:	5b                   	pop    %ebx
80105995:	5e                   	pop    %esi
80105996:	5f                   	pop    %edi
80105997:	5d                   	pop    %ebp
80105998:	c3                   	ret    
80105999:	66 90                	xchg   %ax,%ax
8010599b:	66 90                	xchg   %ax,%ax
8010599d:	66 90                	xchg   %ax,%ax
8010599f:	90                   	nop

801059a0 <sys_fork>:
#include "proc.h"

int
sys_fork(void)
{
  return fork();
801059a0:	e9 7b e4 ff ff       	jmp    80103e20 <fork>
801059a5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801059ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801059b0 <sys_exit>:
}

int
sys_exit(void)
{
801059b0:	55                   	push   %ebp
801059b1:	89 e5                	mov    %esp,%ebp
801059b3:	83 ec 08             	sub    $0x8,%esp
  exit();
801059b6:	e8 e5 e6 ff ff       	call   801040a0 <exit>
  return 0;  // not reached
}
801059bb:	31 c0                	xor    %eax,%eax
801059bd:	c9                   	leave  
801059be:	c3                   	ret    
801059bf:	90                   	nop

801059c0 <sys_wait>:

int
sys_wait(void)
{
  return wait();
801059c0:	e9 0b e8 ff ff       	jmp    801041d0 <wait>
801059c5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801059cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801059d0 <sys_kill>:
}

int
sys_kill(void)
{
801059d0:	55                   	push   %ebp
801059d1:	89 e5                	mov    %esp,%ebp
801059d3:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
801059d6:	8d 45 f4             	lea    -0xc(%ebp),%eax
801059d9:	50                   	push   %eax
801059da:	6a 00                	push   $0x0
801059dc:	e8 4f f2 ff ff       	call   80104c30 <argint>
801059e1:	83 c4 10             	add    $0x10,%esp
801059e4:	85 c0                	test   %eax,%eax
801059e6:	78 18                	js     80105a00 <sys_kill+0x30>
    return -1;
  return kill(pid);
801059e8:	83 ec 0c             	sub    $0xc,%esp
801059eb:	ff 75 f4             	push   -0xc(%ebp)
801059ee:	e8 7d ea ff ff       	call   80104470 <kill>
801059f3:	83 c4 10             	add    $0x10,%esp
}
801059f6:	c9                   	leave  
801059f7:	c3                   	ret    
801059f8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801059ff:	90                   	nop
80105a00:	c9                   	leave  
    return -1;
80105a01:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105a06:	c3                   	ret    
80105a07:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105a0e:	66 90                	xchg   %ax,%ax

80105a10 <sys_getpid>:

int
sys_getpid(void)
{
80105a10:	55                   	push   %ebp
80105a11:	89 e5                	mov    %esp,%ebp
80105a13:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
80105a16:	e8 65 e2 ff ff       	call   80103c80 <myproc>
80105a1b:	8b 40 10             	mov    0x10(%eax),%eax
}
80105a1e:	c9                   	leave  
80105a1f:	c3                   	ret    

80105a20 <sys_sbrk>:

int
sys_sbrk(void)
{
80105a20:	55                   	push   %ebp
80105a21:	89 e5                	mov    %esp,%ebp
80105a23:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
80105a24:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105a27:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
80105a2a:	50                   	push   %eax
80105a2b:	6a 00                	push   $0x0
80105a2d:	e8 fe f1 ff ff       	call   80104c30 <argint>
80105a32:	83 c4 10             	add    $0x10,%esp
80105a35:	85 c0                	test   %eax,%eax
80105a37:	78 27                	js     80105a60 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
80105a39:	e8 42 e2 ff ff       	call   80103c80 <myproc>
  if(growproc(n) < 0)
80105a3e:	83 ec 0c             	sub    $0xc,%esp
  addr = myproc()->sz;
80105a41:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80105a43:	ff 75 f4             	push   -0xc(%ebp)
80105a46:	e8 55 e3 ff ff       	call   80103da0 <growproc>
80105a4b:	83 c4 10             	add    $0x10,%esp
80105a4e:	85 c0                	test   %eax,%eax
80105a50:	78 0e                	js     80105a60 <sys_sbrk+0x40>
    return -1;
  return addr;
}
80105a52:	89 d8                	mov    %ebx,%eax
80105a54:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105a57:	c9                   	leave  
80105a58:	c3                   	ret    
80105a59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105a60:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105a65:	eb eb                	jmp    80105a52 <sys_sbrk+0x32>
80105a67:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105a6e:	66 90                	xchg   %ax,%ax

80105a70 <sys_sleep>:

int
sys_sleep(void)
{
80105a70:	55                   	push   %ebp
80105a71:	89 e5                	mov    %esp,%ebp
80105a73:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80105a74:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105a77:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
80105a7a:	50                   	push   %eax
80105a7b:	6a 00                	push   $0x0
80105a7d:	e8 ae f1 ff ff       	call   80104c30 <argint>
80105a82:	83 c4 10             	add    $0x10,%esp
80105a85:	85 c0                	test   %eax,%eax
80105a87:	0f 88 8a 00 00 00    	js     80105b17 <sys_sleep+0xa7>
    return -1;
  acquire(&tickslock);
80105a8d:	83 ec 0c             	sub    $0xc,%esp
80105a90:	68 80 3c 11 80       	push   $0x80113c80
80105a95:	e8 16 ee ff ff       	call   801048b0 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
80105a9a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  ticks0 = ticks;
80105a9d:	8b 1d 60 3c 11 80    	mov    0x80113c60,%ebx
  while(ticks - ticks0 < n){
80105aa3:	83 c4 10             	add    $0x10,%esp
80105aa6:	85 d2                	test   %edx,%edx
80105aa8:	75 27                	jne    80105ad1 <sys_sleep+0x61>
80105aaa:	eb 54                	jmp    80105b00 <sys_sleep+0x90>
80105aac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80105ab0:	83 ec 08             	sub    $0x8,%esp
80105ab3:	68 80 3c 11 80       	push   $0x80113c80
80105ab8:	68 60 3c 11 80       	push   $0x80113c60
80105abd:	e8 8e e8 ff ff       	call   80104350 <sleep>
  while(ticks - ticks0 < n){
80105ac2:	a1 60 3c 11 80       	mov    0x80113c60,%eax
80105ac7:	83 c4 10             	add    $0x10,%esp
80105aca:	29 d8                	sub    %ebx,%eax
80105acc:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80105acf:	73 2f                	jae    80105b00 <sys_sleep+0x90>
    if(myproc()->killed){
80105ad1:	e8 aa e1 ff ff       	call   80103c80 <myproc>
80105ad6:	8b 40 24             	mov    0x24(%eax),%eax
80105ad9:	85 c0                	test   %eax,%eax
80105adb:	74 d3                	je     80105ab0 <sys_sleep+0x40>
      release(&tickslock);
80105add:	83 ec 0c             	sub    $0xc,%esp
80105ae0:	68 80 3c 11 80       	push   $0x80113c80
80105ae5:	e8 66 ed ff ff       	call   80104850 <release>
  }
  release(&tickslock);
  return 0;
}
80105aea:	8b 5d fc             	mov    -0x4(%ebp),%ebx
      return -1;
80105aed:	83 c4 10             	add    $0x10,%esp
80105af0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105af5:	c9                   	leave  
80105af6:	c3                   	ret    
80105af7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105afe:	66 90                	xchg   %ax,%ax
  release(&tickslock);
80105b00:	83 ec 0c             	sub    $0xc,%esp
80105b03:	68 80 3c 11 80       	push   $0x80113c80
80105b08:	e8 43 ed ff ff       	call   80104850 <release>
  return 0;
80105b0d:	83 c4 10             	add    $0x10,%esp
80105b10:	31 c0                	xor    %eax,%eax
}
80105b12:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105b15:	c9                   	leave  
80105b16:	c3                   	ret    
    return -1;
80105b17:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105b1c:	eb f4                	jmp    80105b12 <sys_sleep+0xa2>
80105b1e:	66 90                	xchg   %ax,%ax

80105b20 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80105b20:	55                   	push   %ebp
80105b21:	89 e5                	mov    %esp,%ebp
80105b23:	53                   	push   %ebx
80105b24:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
80105b27:	68 80 3c 11 80       	push   $0x80113c80
80105b2c:	e8 7f ed ff ff       	call   801048b0 <acquire>
  xticks = ticks;
80105b31:	8b 1d 60 3c 11 80    	mov    0x80113c60,%ebx
  release(&tickslock);
80105b37:	c7 04 24 80 3c 11 80 	movl   $0x80113c80,(%esp)
80105b3e:	e8 0d ed ff ff       	call   80104850 <release>
  return xticks;
}
80105b43:	89 d8                	mov    %ebx,%eax
80105b45:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105b48:	c9                   	leave  
80105b49:	c3                   	ret    

80105b4a <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
80105b4a:	1e                   	push   %ds
  pushl %es
80105b4b:	06                   	push   %es
  pushl %fs
80105b4c:	0f a0                	push   %fs
  pushl %gs
80105b4e:	0f a8                	push   %gs
  pushal
80105b50:	60                   	pusha  
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
80105b51:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
80105b55:	8e d8                	mov    %eax,%ds
  movw %ax, %es
80105b57:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
80105b59:	54                   	push   %esp
  call trap
80105b5a:	e8 c1 00 00 00       	call   80105c20 <trap>
  addl $4, %esp
80105b5f:	83 c4 04             	add    $0x4,%esp

80105b62 <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
80105b62:	61                   	popa   
  popl %gs
80105b63:	0f a9                	pop    %gs
  popl %fs
80105b65:	0f a1                	pop    %fs
  popl %es
80105b67:	07                   	pop    %es
  popl %ds
80105b68:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
80105b69:	83 c4 08             	add    $0x8,%esp
  iret
80105b6c:	cf                   	iret   
80105b6d:	66 90                	xchg   %ax,%ax
80105b6f:	90                   	nop

80105b70 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80105b70:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
80105b71:	31 c0                	xor    %eax,%eax
{
80105b73:	89 e5                	mov    %esp,%ebp
80105b75:	83 ec 08             	sub    $0x8,%esp
80105b78:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105b7f:	90                   	nop
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80105b80:	8b 14 85 08 a0 10 80 	mov    -0x7fef5ff8(,%eax,4),%edx
80105b87:	c7 04 c5 c2 3c 11 80 	movl   $0x8e000008,-0x7feec33e(,%eax,8)
80105b8e:	08 00 00 8e 
80105b92:	66 89 14 c5 c0 3c 11 	mov    %dx,-0x7feec340(,%eax,8)
80105b99:	80 
80105b9a:	c1 ea 10             	shr    $0x10,%edx
80105b9d:	66 89 14 c5 c6 3c 11 	mov    %dx,-0x7feec33a(,%eax,8)
80105ba4:	80 
  for(i = 0; i < 256; i++)
80105ba5:	83 c0 01             	add    $0x1,%eax
80105ba8:	3d 00 01 00 00       	cmp    $0x100,%eax
80105bad:	75 d1                	jne    80105b80 <tvinit+0x10>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);

  initlock(&tickslock, "time");
80105baf:	83 ec 08             	sub    $0x8,%esp
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105bb2:	a1 08 a1 10 80       	mov    0x8010a108,%eax
80105bb7:	c7 05 c2 3e 11 80 08 	movl   $0xef000008,0x80113ec2
80105bbe:	00 00 ef 
  initlock(&tickslock, "time");
80105bc1:	68 79 7c 10 80       	push   $0x80107c79
80105bc6:	68 80 3c 11 80       	push   $0x80113c80
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105bcb:	66 a3 c0 3e 11 80    	mov    %ax,0x80113ec0
80105bd1:	c1 e8 10             	shr    $0x10,%eax
80105bd4:	66 a3 c6 3e 11 80    	mov    %ax,0x80113ec6
  initlock(&tickslock, "time");
80105bda:	e8 01 eb ff ff       	call   801046e0 <initlock>
}
80105bdf:	83 c4 10             	add    $0x10,%esp
80105be2:	c9                   	leave  
80105be3:	c3                   	ret    
80105be4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105beb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105bef:	90                   	nop

80105bf0 <idtinit>:

void
idtinit(void)
{
80105bf0:	55                   	push   %ebp
  pd[0] = size-1;
80105bf1:	b8 ff 07 00 00       	mov    $0x7ff,%eax
80105bf6:	89 e5                	mov    %esp,%ebp
80105bf8:	83 ec 10             	sub    $0x10,%esp
80105bfb:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
80105bff:	b8 c0 3c 11 80       	mov    $0x80113cc0,%eax
80105c04:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80105c08:	c1 e8 10             	shr    $0x10,%eax
80105c0b:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
80105c0f:	8d 45 fa             	lea    -0x6(%ebp),%eax
80105c12:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80105c15:	c9                   	leave  
80105c16:	c3                   	ret    
80105c17:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105c1e:	66 90                	xchg   %ax,%ax

80105c20 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80105c20:	55                   	push   %ebp
80105c21:	89 e5                	mov    %esp,%ebp
80105c23:	57                   	push   %edi
80105c24:	56                   	push   %esi
80105c25:	53                   	push   %ebx
80105c26:	83 ec 1c             	sub    $0x1c,%esp
80105c29:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(tf->trapno == T_SYSCALL){
80105c2c:	8b 43 30             	mov    0x30(%ebx),%eax
80105c2f:	83 f8 40             	cmp    $0x40,%eax
80105c32:	0f 84 68 01 00 00    	je     80105da0 <trap+0x180>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
80105c38:	83 e8 20             	sub    $0x20,%eax
80105c3b:	83 f8 1f             	cmp    $0x1f,%eax
80105c3e:	0f 87 8c 00 00 00    	ja     80105cd0 <trap+0xb0>
80105c44:	ff 24 85 20 7d 10 80 	jmp    *-0x7fef82e0(,%eax,4)
80105c4b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105c4f:	90                   	nop
      release(&tickslock);
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
80105c50:	e8 fb c8 ff ff       	call   80102550 <ideintr>
    lapiceoi();
80105c55:	e8 c6 cf ff ff       	call   80102c20 <lapiceoi>
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105c5a:	e8 21 e0 ff ff       	call   80103c80 <myproc>
80105c5f:	85 c0                	test   %eax,%eax
80105c61:	74 1d                	je     80105c80 <trap+0x60>
80105c63:	e8 18 e0 ff ff       	call   80103c80 <myproc>
80105c68:	8b 50 24             	mov    0x24(%eax),%edx
80105c6b:	85 d2                	test   %edx,%edx
80105c6d:	74 11                	je     80105c80 <trap+0x60>
80105c6f:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80105c73:	83 e0 03             	and    $0x3,%eax
80105c76:	66 83 f8 03          	cmp    $0x3,%ax
80105c7a:	0f 84 e8 01 00 00    	je     80105e68 <trap+0x248>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80105c80:	e8 fb df ff ff       	call   80103c80 <myproc>
80105c85:	85 c0                	test   %eax,%eax
80105c87:	74 0f                	je     80105c98 <trap+0x78>
80105c89:	e8 f2 df ff ff       	call   80103c80 <myproc>
80105c8e:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80105c92:	0f 84 b8 00 00 00    	je     80105d50 <trap+0x130>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105c98:	e8 e3 df ff ff       	call   80103c80 <myproc>
80105c9d:	85 c0                	test   %eax,%eax
80105c9f:	74 1d                	je     80105cbe <trap+0x9e>
80105ca1:	e8 da df ff ff       	call   80103c80 <myproc>
80105ca6:	8b 40 24             	mov    0x24(%eax),%eax
80105ca9:	85 c0                	test   %eax,%eax
80105cab:	74 11                	je     80105cbe <trap+0x9e>
80105cad:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80105cb1:	83 e0 03             	and    $0x3,%eax
80105cb4:	66 83 f8 03          	cmp    $0x3,%ax
80105cb8:	0f 84 0f 01 00 00    	je     80105dcd <trap+0x1ad>
    exit();
}
80105cbe:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105cc1:	5b                   	pop    %ebx
80105cc2:	5e                   	pop    %esi
80105cc3:	5f                   	pop    %edi
80105cc4:	5d                   	pop    %ebp
80105cc5:	c3                   	ret    
80105cc6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105ccd:	8d 76 00             	lea    0x0(%esi),%esi
    if(myproc() == 0 || (tf->cs&3) == 0){
80105cd0:	e8 ab df ff ff       	call   80103c80 <myproc>
80105cd5:	8b 7b 38             	mov    0x38(%ebx),%edi
80105cd8:	85 c0                	test   %eax,%eax
80105cda:	0f 84 a2 01 00 00    	je     80105e82 <trap+0x262>
80105ce0:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
80105ce4:	0f 84 98 01 00 00    	je     80105e82 <trap+0x262>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
80105cea:	0f 20 d1             	mov    %cr2,%ecx
80105ced:	89 4d d8             	mov    %ecx,-0x28(%ebp)
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105cf0:	e8 6b df ff ff       	call   80103c60 <cpuid>
80105cf5:	8b 73 30             	mov    0x30(%ebx),%esi
80105cf8:	89 45 dc             	mov    %eax,-0x24(%ebp)
80105cfb:	8b 43 34             	mov    0x34(%ebx),%eax
80105cfe:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            myproc()->pid, myproc()->name, tf->trapno,
80105d01:	e8 7a df ff ff       	call   80103c80 <myproc>
80105d06:	89 45 e0             	mov    %eax,-0x20(%ebp)
80105d09:	e8 72 df ff ff       	call   80103c80 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105d0e:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80105d11:	8b 55 dc             	mov    -0x24(%ebp),%edx
80105d14:	51                   	push   %ecx
80105d15:	57                   	push   %edi
80105d16:	52                   	push   %edx
80105d17:	ff 75 e4             	push   -0x1c(%ebp)
80105d1a:	56                   	push   %esi
            myproc()->pid, myproc()->name, tf->trapno,
80105d1b:	8b 75 e0             	mov    -0x20(%ebp),%esi
80105d1e:	83 c6 6c             	add    $0x6c,%esi
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105d21:	56                   	push   %esi
80105d22:	ff 70 10             	push   0x10(%eax)
80105d25:	68 dc 7c 10 80       	push   $0x80107cdc
80105d2a:	e8 01 aa ff ff       	call   80100730 <cprintf>
    myproc()->killed = 1;
80105d2f:	83 c4 20             	add    $0x20,%esp
80105d32:	e8 49 df ff ff       	call   80103c80 <myproc>
80105d37:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105d3e:	e8 3d df ff ff       	call   80103c80 <myproc>
80105d43:	85 c0                	test   %eax,%eax
80105d45:	0f 85 18 ff ff ff    	jne    80105c63 <trap+0x43>
80105d4b:	e9 30 ff ff ff       	jmp    80105c80 <trap+0x60>
  if(myproc() && myproc()->state == RUNNING &&
80105d50:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
80105d54:	0f 85 3e ff ff ff    	jne    80105c98 <trap+0x78>
    yield();
80105d5a:	e8 a1 e5 ff ff       	call   80104300 <yield>
80105d5f:	e9 34 ff ff ff       	jmp    80105c98 <trap+0x78>
80105d64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80105d68:	8b 7b 38             	mov    0x38(%ebx),%edi
80105d6b:	0f b7 73 3c          	movzwl 0x3c(%ebx),%esi
80105d6f:	e8 ec de ff ff       	call   80103c60 <cpuid>
80105d74:	57                   	push   %edi
80105d75:	56                   	push   %esi
80105d76:	50                   	push   %eax
80105d77:	68 84 7c 10 80       	push   $0x80107c84
80105d7c:	e8 af a9 ff ff       	call   80100730 <cprintf>
    lapiceoi();
80105d81:	e8 9a ce ff ff       	call   80102c20 <lapiceoi>
    break;
80105d86:	83 c4 10             	add    $0x10,%esp
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105d89:	e8 f2 de ff ff       	call   80103c80 <myproc>
80105d8e:	85 c0                	test   %eax,%eax
80105d90:	0f 85 cd fe ff ff    	jne    80105c63 <trap+0x43>
80105d96:	e9 e5 fe ff ff       	jmp    80105c80 <trap+0x60>
80105d9b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105d9f:	90                   	nop
    if(myproc()->killed)
80105da0:	e8 db de ff ff       	call   80103c80 <myproc>
80105da5:	8b 70 24             	mov    0x24(%eax),%esi
80105da8:	85 f6                	test   %esi,%esi
80105daa:	0f 85 c8 00 00 00    	jne    80105e78 <trap+0x258>
    myproc()->tf = tf;
80105db0:	e8 cb de ff ff       	call   80103c80 <myproc>
80105db5:	89 58 18             	mov    %ebx,0x18(%eax)
    syscall();
80105db8:	e8 b3 ef ff ff       	call   80104d70 <syscall>
    if(myproc()->killed)
80105dbd:	e8 be de ff ff       	call   80103c80 <myproc>
80105dc2:	8b 48 24             	mov    0x24(%eax),%ecx
80105dc5:	85 c9                	test   %ecx,%ecx
80105dc7:	0f 84 f1 fe ff ff    	je     80105cbe <trap+0x9e>
}
80105dcd:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105dd0:	5b                   	pop    %ebx
80105dd1:	5e                   	pop    %esi
80105dd2:	5f                   	pop    %edi
80105dd3:	5d                   	pop    %ebp
      exit();
80105dd4:	e9 c7 e2 ff ff       	jmp    801040a0 <exit>
80105dd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    uartintr();
80105de0:	e8 3b 02 00 00       	call   80106020 <uartintr>
    lapiceoi();
80105de5:	e8 36 ce ff ff       	call   80102c20 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105dea:	e8 91 de ff ff       	call   80103c80 <myproc>
80105def:	85 c0                	test   %eax,%eax
80105df1:	0f 85 6c fe ff ff    	jne    80105c63 <trap+0x43>
80105df7:	e9 84 fe ff ff       	jmp    80105c80 <trap+0x60>
80105dfc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    kbdintr();
80105e00:	e8 db cc ff ff       	call   80102ae0 <kbdintr>
    lapiceoi();
80105e05:	e8 16 ce ff ff       	call   80102c20 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105e0a:	e8 71 de ff ff       	call   80103c80 <myproc>
80105e0f:	85 c0                	test   %eax,%eax
80105e11:	0f 85 4c fe ff ff    	jne    80105c63 <trap+0x43>
80105e17:	e9 64 fe ff ff       	jmp    80105c80 <trap+0x60>
80105e1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(cpuid() == 0){
80105e20:	e8 3b de ff ff       	call   80103c60 <cpuid>
80105e25:	85 c0                	test   %eax,%eax
80105e27:	0f 85 28 fe ff ff    	jne    80105c55 <trap+0x35>
      acquire(&tickslock);
80105e2d:	83 ec 0c             	sub    $0xc,%esp
80105e30:	68 80 3c 11 80       	push   $0x80113c80
80105e35:	e8 76 ea ff ff       	call   801048b0 <acquire>
      wakeup(&ticks);
80105e3a:	c7 04 24 60 3c 11 80 	movl   $0x80113c60,(%esp)
      ticks++;
80105e41:	83 05 60 3c 11 80 01 	addl   $0x1,0x80113c60
      wakeup(&ticks);
80105e48:	e8 c3 e5 ff ff       	call   80104410 <wakeup>
      release(&tickslock);
80105e4d:	c7 04 24 80 3c 11 80 	movl   $0x80113c80,(%esp)
80105e54:	e8 f7 e9 ff ff       	call   80104850 <release>
80105e59:	83 c4 10             	add    $0x10,%esp
    lapiceoi();
80105e5c:	e9 f4 fd ff ff       	jmp    80105c55 <trap+0x35>
80105e61:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    exit();
80105e68:	e8 33 e2 ff ff       	call   801040a0 <exit>
80105e6d:	e9 0e fe ff ff       	jmp    80105c80 <trap+0x60>
80105e72:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      exit();
80105e78:	e8 23 e2 ff ff       	call   801040a0 <exit>
80105e7d:	e9 2e ff ff ff       	jmp    80105db0 <trap+0x190>
80105e82:	0f 20 d6             	mov    %cr2,%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80105e85:	e8 d6 dd ff ff       	call   80103c60 <cpuid>
80105e8a:	83 ec 0c             	sub    $0xc,%esp
80105e8d:	56                   	push   %esi
80105e8e:	57                   	push   %edi
80105e8f:	50                   	push   %eax
80105e90:	ff 73 30             	push   0x30(%ebx)
80105e93:	68 a8 7c 10 80       	push   $0x80107ca8
80105e98:	e8 93 a8 ff ff       	call   80100730 <cprintf>
      panic("trap");
80105e9d:	83 c4 14             	add    $0x14,%esp
80105ea0:	68 7e 7c 10 80       	push   $0x80107c7e
80105ea5:	e8 d6 a4 ff ff       	call   80100380 <panic>
80105eaa:	66 90                	xchg   %ax,%ax
80105eac:	66 90                	xchg   %ax,%ax
80105eae:	66 90                	xchg   %ax,%ax

80105eb0 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80105eb0:	a1 c0 44 11 80       	mov    0x801144c0,%eax
80105eb5:	85 c0                	test   %eax,%eax
80105eb7:	74 17                	je     80105ed0 <uartgetc+0x20>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105eb9:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105ebe:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
80105ebf:	a8 01                	test   $0x1,%al
80105ec1:	74 0d                	je     80105ed0 <uartgetc+0x20>
80105ec3:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105ec8:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
80105ec9:	0f b6 c0             	movzbl %al,%eax
80105ecc:	c3                   	ret    
80105ecd:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80105ed0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105ed5:	c3                   	ret    
80105ed6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105edd:	8d 76 00             	lea    0x0(%esi),%esi

80105ee0 <uartinit>:
{
80105ee0:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80105ee1:	31 c9                	xor    %ecx,%ecx
80105ee3:	89 c8                	mov    %ecx,%eax
80105ee5:	89 e5                	mov    %esp,%ebp
80105ee7:	57                   	push   %edi
80105ee8:	bf fa 03 00 00       	mov    $0x3fa,%edi
80105eed:	56                   	push   %esi
80105eee:	89 fa                	mov    %edi,%edx
80105ef0:	53                   	push   %ebx
80105ef1:	83 ec 1c             	sub    $0x1c,%esp
80105ef4:	ee                   	out    %al,(%dx)
80105ef5:	be fb 03 00 00       	mov    $0x3fb,%esi
80105efa:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
80105eff:	89 f2                	mov    %esi,%edx
80105f01:	ee                   	out    %al,(%dx)
80105f02:	b8 0c 00 00 00       	mov    $0xc,%eax
80105f07:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105f0c:	ee                   	out    %al,(%dx)
80105f0d:	bb f9 03 00 00       	mov    $0x3f9,%ebx
80105f12:	89 c8                	mov    %ecx,%eax
80105f14:	89 da                	mov    %ebx,%edx
80105f16:	ee                   	out    %al,(%dx)
80105f17:	b8 03 00 00 00       	mov    $0x3,%eax
80105f1c:	89 f2                	mov    %esi,%edx
80105f1e:	ee                   	out    %al,(%dx)
80105f1f:	ba fc 03 00 00       	mov    $0x3fc,%edx
80105f24:	89 c8                	mov    %ecx,%eax
80105f26:	ee                   	out    %al,(%dx)
80105f27:	b8 01 00 00 00       	mov    $0x1,%eax
80105f2c:	89 da                	mov    %ebx,%edx
80105f2e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105f2f:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105f34:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
80105f35:	3c ff                	cmp    $0xff,%al
80105f37:	74 78                	je     80105fb1 <uartinit+0xd1>
  uart = 1;
80105f39:	c7 05 c0 44 11 80 01 	movl   $0x1,0x801144c0
80105f40:	00 00 00 
80105f43:	89 fa                	mov    %edi,%edx
80105f45:	ec                   	in     (%dx),%al
80105f46:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105f4b:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
80105f4c:	83 ec 08             	sub    $0x8,%esp
  for(p="xv6...\n"; *p; p++)
80105f4f:	bf a0 7d 10 80       	mov    $0x80107da0,%edi
80105f54:	be fd 03 00 00       	mov    $0x3fd,%esi
  ioapicenable(IRQ_COM1, 0);
80105f59:	6a 00                	push   $0x0
80105f5b:	6a 04                	push   $0x4
80105f5d:	e8 2e c8 ff ff       	call   80102790 <ioapicenable>
  for(p="xv6...\n"; *p; p++)
80105f62:	c6 45 e7 78          	movb   $0x78,-0x19(%ebp)
  ioapicenable(IRQ_COM1, 0);
80105f66:	83 c4 10             	add    $0x10,%esp
80105f69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(!uart)
80105f70:	a1 c0 44 11 80       	mov    0x801144c0,%eax
80105f75:	bb 80 00 00 00       	mov    $0x80,%ebx
80105f7a:	85 c0                	test   %eax,%eax
80105f7c:	75 14                	jne    80105f92 <uartinit+0xb2>
80105f7e:	eb 23                	jmp    80105fa3 <uartinit+0xc3>
    microdelay(10);
80105f80:	83 ec 0c             	sub    $0xc,%esp
80105f83:	6a 0a                	push   $0xa
80105f85:	e8 b6 cc ff ff       	call   80102c40 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80105f8a:	83 c4 10             	add    $0x10,%esp
80105f8d:	83 eb 01             	sub    $0x1,%ebx
80105f90:	74 07                	je     80105f99 <uartinit+0xb9>
80105f92:	89 f2                	mov    %esi,%edx
80105f94:	ec                   	in     (%dx),%al
80105f95:	a8 20                	test   $0x20,%al
80105f97:	74 e7                	je     80105f80 <uartinit+0xa0>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80105f99:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
80105f9d:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105fa2:	ee                   	out    %al,(%dx)
  for(p="xv6...\n"; *p; p++)
80105fa3:	0f b6 47 01          	movzbl 0x1(%edi),%eax
80105fa7:	83 c7 01             	add    $0x1,%edi
80105faa:	88 45 e7             	mov    %al,-0x19(%ebp)
80105fad:	84 c0                	test   %al,%al
80105faf:	75 bf                	jne    80105f70 <uartinit+0x90>
}
80105fb1:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105fb4:	5b                   	pop    %ebx
80105fb5:	5e                   	pop    %esi
80105fb6:	5f                   	pop    %edi
80105fb7:	5d                   	pop    %ebp
80105fb8:	c3                   	ret    
80105fb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105fc0 <uartputc>:
  if(!uart)
80105fc0:	a1 c0 44 11 80       	mov    0x801144c0,%eax
80105fc5:	85 c0                	test   %eax,%eax
80105fc7:	74 47                	je     80106010 <uartputc+0x50>
{
80105fc9:	55                   	push   %ebp
80105fca:	89 e5                	mov    %esp,%ebp
80105fcc:	56                   	push   %esi
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105fcd:	be fd 03 00 00       	mov    $0x3fd,%esi
80105fd2:	53                   	push   %ebx
80105fd3:	bb 80 00 00 00       	mov    $0x80,%ebx
80105fd8:	eb 18                	jmp    80105ff2 <uartputc+0x32>
80105fda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    microdelay(10);
80105fe0:	83 ec 0c             	sub    $0xc,%esp
80105fe3:	6a 0a                	push   $0xa
80105fe5:	e8 56 cc ff ff       	call   80102c40 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80105fea:	83 c4 10             	add    $0x10,%esp
80105fed:	83 eb 01             	sub    $0x1,%ebx
80105ff0:	74 07                	je     80105ff9 <uartputc+0x39>
80105ff2:	89 f2                	mov    %esi,%edx
80105ff4:	ec                   	in     (%dx),%al
80105ff5:	a8 20                	test   $0x20,%al
80105ff7:	74 e7                	je     80105fe0 <uartputc+0x20>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80105ff9:	8b 45 08             	mov    0x8(%ebp),%eax
80105ffc:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106001:	ee                   	out    %al,(%dx)
}
80106002:	8d 65 f8             	lea    -0x8(%ebp),%esp
80106005:	5b                   	pop    %ebx
80106006:	5e                   	pop    %esi
80106007:	5d                   	pop    %ebp
80106008:	c3                   	ret    
80106009:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106010:	c3                   	ret    
80106011:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106018:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010601f:	90                   	nop

80106020 <uartintr>:

void
uartintr(void)
{
80106020:	55                   	push   %ebp
80106021:	89 e5                	mov    %esp,%ebp
80106023:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
80106026:	68 b0 5e 10 80       	push   $0x80105eb0
8010602b:	e8 70 a9 ff ff       	call   801009a0 <consoleintr>
}
80106030:	83 c4 10             	add    $0x10,%esp
80106033:	c9                   	leave  
80106034:	c3                   	ret    

80106035 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80106035:	6a 00                	push   $0x0
  pushl $0
80106037:	6a 00                	push   $0x0
  jmp alltraps
80106039:	e9 0c fb ff ff       	jmp    80105b4a <alltraps>

8010603e <vector1>:
.globl vector1
vector1:
  pushl $0
8010603e:	6a 00                	push   $0x0
  pushl $1
80106040:	6a 01                	push   $0x1
  jmp alltraps
80106042:	e9 03 fb ff ff       	jmp    80105b4a <alltraps>

80106047 <vector2>:
.globl vector2
vector2:
  pushl $0
80106047:	6a 00                	push   $0x0
  pushl $2
80106049:	6a 02                	push   $0x2
  jmp alltraps
8010604b:	e9 fa fa ff ff       	jmp    80105b4a <alltraps>

80106050 <vector3>:
.globl vector3
vector3:
  pushl $0
80106050:	6a 00                	push   $0x0
  pushl $3
80106052:	6a 03                	push   $0x3
  jmp alltraps
80106054:	e9 f1 fa ff ff       	jmp    80105b4a <alltraps>

80106059 <vector4>:
.globl vector4
vector4:
  pushl $0
80106059:	6a 00                	push   $0x0
  pushl $4
8010605b:	6a 04                	push   $0x4
  jmp alltraps
8010605d:	e9 e8 fa ff ff       	jmp    80105b4a <alltraps>

80106062 <vector5>:
.globl vector5
vector5:
  pushl $0
80106062:	6a 00                	push   $0x0
  pushl $5
80106064:	6a 05                	push   $0x5
  jmp alltraps
80106066:	e9 df fa ff ff       	jmp    80105b4a <alltraps>

8010606b <vector6>:
.globl vector6
vector6:
  pushl $0
8010606b:	6a 00                	push   $0x0
  pushl $6
8010606d:	6a 06                	push   $0x6
  jmp alltraps
8010606f:	e9 d6 fa ff ff       	jmp    80105b4a <alltraps>

80106074 <vector7>:
.globl vector7
vector7:
  pushl $0
80106074:	6a 00                	push   $0x0
  pushl $7
80106076:	6a 07                	push   $0x7
  jmp alltraps
80106078:	e9 cd fa ff ff       	jmp    80105b4a <alltraps>

8010607d <vector8>:
.globl vector8
vector8:
  pushl $8
8010607d:	6a 08                	push   $0x8
  jmp alltraps
8010607f:	e9 c6 fa ff ff       	jmp    80105b4a <alltraps>

80106084 <vector9>:
.globl vector9
vector9:
  pushl $0
80106084:	6a 00                	push   $0x0
  pushl $9
80106086:	6a 09                	push   $0x9
  jmp alltraps
80106088:	e9 bd fa ff ff       	jmp    80105b4a <alltraps>

8010608d <vector10>:
.globl vector10
vector10:
  pushl $10
8010608d:	6a 0a                	push   $0xa
  jmp alltraps
8010608f:	e9 b6 fa ff ff       	jmp    80105b4a <alltraps>

80106094 <vector11>:
.globl vector11
vector11:
  pushl $11
80106094:	6a 0b                	push   $0xb
  jmp alltraps
80106096:	e9 af fa ff ff       	jmp    80105b4a <alltraps>

8010609b <vector12>:
.globl vector12
vector12:
  pushl $12
8010609b:	6a 0c                	push   $0xc
  jmp alltraps
8010609d:	e9 a8 fa ff ff       	jmp    80105b4a <alltraps>

801060a2 <vector13>:
.globl vector13
vector13:
  pushl $13
801060a2:	6a 0d                	push   $0xd
  jmp alltraps
801060a4:	e9 a1 fa ff ff       	jmp    80105b4a <alltraps>

801060a9 <vector14>:
.globl vector14
vector14:
  pushl $14
801060a9:	6a 0e                	push   $0xe
  jmp alltraps
801060ab:	e9 9a fa ff ff       	jmp    80105b4a <alltraps>

801060b0 <vector15>:
.globl vector15
vector15:
  pushl $0
801060b0:	6a 00                	push   $0x0
  pushl $15
801060b2:	6a 0f                	push   $0xf
  jmp alltraps
801060b4:	e9 91 fa ff ff       	jmp    80105b4a <alltraps>

801060b9 <vector16>:
.globl vector16
vector16:
  pushl $0
801060b9:	6a 00                	push   $0x0
  pushl $16
801060bb:	6a 10                	push   $0x10
  jmp alltraps
801060bd:	e9 88 fa ff ff       	jmp    80105b4a <alltraps>

801060c2 <vector17>:
.globl vector17
vector17:
  pushl $17
801060c2:	6a 11                	push   $0x11
  jmp alltraps
801060c4:	e9 81 fa ff ff       	jmp    80105b4a <alltraps>

801060c9 <vector18>:
.globl vector18
vector18:
  pushl $0
801060c9:	6a 00                	push   $0x0
  pushl $18
801060cb:	6a 12                	push   $0x12
  jmp alltraps
801060cd:	e9 78 fa ff ff       	jmp    80105b4a <alltraps>

801060d2 <vector19>:
.globl vector19
vector19:
  pushl $0
801060d2:	6a 00                	push   $0x0
  pushl $19
801060d4:	6a 13                	push   $0x13
  jmp alltraps
801060d6:	e9 6f fa ff ff       	jmp    80105b4a <alltraps>

801060db <vector20>:
.globl vector20
vector20:
  pushl $0
801060db:	6a 00                	push   $0x0
  pushl $20
801060dd:	6a 14                	push   $0x14
  jmp alltraps
801060df:	e9 66 fa ff ff       	jmp    80105b4a <alltraps>

801060e4 <vector21>:
.globl vector21
vector21:
  pushl $0
801060e4:	6a 00                	push   $0x0
  pushl $21
801060e6:	6a 15                	push   $0x15
  jmp alltraps
801060e8:	e9 5d fa ff ff       	jmp    80105b4a <alltraps>

801060ed <vector22>:
.globl vector22
vector22:
  pushl $0
801060ed:	6a 00                	push   $0x0
  pushl $22
801060ef:	6a 16                	push   $0x16
  jmp alltraps
801060f1:	e9 54 fa ff ff       	jmp    80105b4a <alltraps>

801060f6 <vector23>:
.globl vector23
vector23:
  pushl $0
801060f6:	6a 00                	push   $0x0
  pushl $23
801060f8:	6a 17                	push   $0x17
  jmp alltraps
801060fa:	e9 4b fa ff ff       	jmp    80105b4a <alltraps>

801060ff <vector24>:
.globl vector24
vector24:
  pushl $0
801060ff:	6a 00                	push   $0x0
  pushl $24
80106101:	6a 18                	push   $0x18
  jmp alltraps
80106103:	e9 42 fa ff ff       	jmp    80105b4a <alltraps>

80106108 <vector25>:
.globl vector25
vector25:
  pushl $0
80106108:	6a 00                	push   $0x0
  pushl $25
8010610a:	6a 19                	push   $0x19
  jmp alltraps
8010610c:	e9 39 fa ff ff       	jmp    80105b4a <alltraps>

80106111 <vector26>:
.globl vector26
vector26:
  pushl $0
80106111:	6a 00                	push   $0x0
  pushl $26
80106113:	6a 1a                	push   $0x1a
  jmp alltraps
80106115:	e9 30 fa ff ff       	jmp    80105b4a <alltraps>

8010611a <vector27>:
.globl vector27
vector27:
  pushl $0
8010611a:	6a 00                	push   $0x0
  pushl $27
8010611c:	6a 1b                	push   $0x1b
  jmp alltraps
8010611e:	e9 27 fa ff ff       	jmp    80105b4a <alltraps>

80106123 <vector28>:
.globl vector28
vector28:
  pushl $0
80106123:	6a 00                	push   $0x0
  pushl $28
80106125:	6a 1c                	push   $0x1c
  jmp alltraps
80106127:	e9 1e fa ff ff       	jmp    80105b4a <alltraps>

8010612c <vector29>:
.globl vector29
vector29:
  pushl $0
8010612c:	6a 00                	push   $0x0
  pushl $29
8010612e:	6a 1d                	push   $0x1d
  jmp alltraps
80106130:	e9 15 fa ff ff       	jmp    80105b4a <alltraps>

80106135 <vector30>:
.globl vector30
vector30:
  pushl $0
80106135:	6a 00                	push   $0x0
  pushl $30
80106137:	6a 1e                	push   $0x1e
  jmp alltraps
80106139:	e9 0c fa ff ff       	jmp    80105b4a <alltraps>

8010613e <vector31>:
.globl vector31
vector31:
  pushl $0
8010613e:	6a 00                	push   $0x0
  pushl $31
80106140:	6a 1f                	push   $0x1f
  jmp alltraps
80106142:	e9 03 fa ff ff       	jmp    80105b4a <alltraps>

80106147 <vector32>:
.globl vector32
vector32:
  pushl $0
80106147:	6a 00                	push   $0x0
  pushl $32
80106149:	6a 20                	push   $0x20
  jmp alltraps
8010614b:	e9 fa f9 ff ff       	jmp    80105b4a <alltraps>

80106150 <vector33>:
.globl vector33
vector33:
  pushl $0
80106150:	6a 00                	push   $0x0
  pushl $33
80106152:	6a 21                	push   $0x21
  jmp alltraps
80106154:	e9 f1 f9 ff ff       	jmp    80105b4a <alltraps>

80106159 <vector34>:
.globl vector34
vector34:
  pushl $0
80106159:	6a 00                	push   $0x0
  pushl $34
8010615b:	6a 22                	push   $0x22
  jmp alltraps
8010615d:	e9 e8 f9 ff ff       	jmp    80105b4a <alltraps>

80106162 <vector35>:
.globl vector35
vector35:
  pushl $0
80106162:	6a 00                	push   $0x0
  pushl $35
80106164:	6a 23                	push   $0x23
  jmp alltraps
80106166:	e9 df f9 ff ff       	jmp    80105b4a <alltraps>

8010616b <vector36>:
.globl vector36
vector36:
  pushl $0
8010616b:	6a 00                	push   $0x0
  pushl $36
8010616d:	6a 24                	push   $0x24
  jmp alltraps
8010616f:	e9 d6 f9 ff ff       	jmp    80105b4a <alltraps>

80106174 <vector37>:
.globl vector37
vector37:
  pushl $0
80106174:	6a 00                	push   $0x0
  pushl $37
80106176:	6a 25                	push   $0x25
  jmp alltraps
80106178:	e9 cd f9 ff ff       	jmp    80105b4a <alltraps>

8010617d <vector38>:
.globl vector38
vector38:
  pushl $0
8010617d:	6a 00                	push   $0x0
  pushl $38
8010617f:	6a 26                	push   $0x26
  jmp alltraps
80106181:	e9 c4 f9 ff ff       	jmp    80105b4a <alltraps>

80106186 <vector39>:
.globl vector39
vector39:
  pushl $0
80106186:	6a 00                	push   $0x0
  pushl $39
80106188:	6a 27                	push   $0x27
  jmp alltraps
8010618a:	e9 bb f9 ff ff       	jmp    80105b4a <alltraps>

8010618f <vector40>:
.globl vector40
vector40:
  pushl $0
8010618f:	6a 00                	push   $0x0
  pushl $40
80106191:	6a 28                	push   $0x28
  jmp alltraps
80106193:	e9 b2 f9 ff ff       	jmp    80105b4a <alltraps>

80106198 <vector41>:
.globl vector41
vector41:
  pushl $0
80106198:	6a 00                	push   $0x0
  pushl $41
8010619a:	6a 29                	push   $0x29
  jmp alltraps
8010619c:	e9 a9 f9 ff ff       	jmp    80105b4a <alltraps>

801061a1 <vector42>:
.globl vector42
vector42:
  pushl $0
801061a1:	6a 00                	push   $0x0
  pushl $42
801061a3:	6a 2a                	push   $0x2a
  jmp alltraps
801061a5:	e9 a0 f9 ff ff       	jmp    80105b4a <alltraps>

801061aa <vector43>:
.globl vector43
vector43:
  pushl $0
801061aa:	6a 00                	push   $0x0
  pushl $43
801061ac:	6a 2b                	push   $0x2b
  jmp alltraps
801061ae:	e9 97 f9 ff ff       	jmp    80105b4a <alltraps>

801061b3 <vector44>:
.globl vector44
vector44:
  pushl $0
801061b3:	6a 00                	push   $0x0
  pushl $44
801061b5:	6a 2c                	push   $0x2c
  jmp alltraps
801061b7:	e9 8e f9 ff ff       	jmp    80105b4a <alltraps>

801061bc <vector45>:
.globl vector45
vector45:
  pushl $0
801061bc:	6a 00                	push   $0x0
  pushl $45
801061be:	6a 2d                	push   $0x2d
  jmp alltraps
801061c0:	e9 85 f9 ff ff       	jmp    80105b4a <alltraps>

801061c5 <vector46>:
.globl vector46
vector46:
  pushl $0
801061c5:	6a 00                	push   $0x0
  pushl $46
801061c7:	6a 2e                	push   $0x2e
  jmp alltraps
801061c9:	e9 7c f9 ff ff       	jmp    80105b4a <alltraps>

801061ce <vector47>:
.globl vector47
vector47:
  pushl $0
801061ce:	6a 00                	push   $0x0
  pushl $47
801061d0:	6a 2f                	push   $0x2f
  jmp alltraps
801061d2:	e9 73 f9 ff ff       	jmp    80105b4a <alltraps>

801061d7 <vector48>:
.globl vector48
vector48:
  pushl $0
801061d7:	6a 00                	push   $0x0
  pushl $48
801061d9:	6a 30                	push   $0x30
  jmp alltraps
801061db:	e9 6a f9 ff ff       	jmp    80105b4a <alltraps>

801061e0 <vector49>:
.globl vector49
vector49:
  pushl $0
801061e0:	6a 00                	push   $0x0
  pushl $49
801061e2:	6a 31                	push   $0x31
  jmp alltraps
801061e4:	e9 61 f9 ff ff       	jmp    80105b4a <alltraps>

801061e9 <vector50>:
.globl vector50
vector50:
  pushl $0
801061e9:	6a 00                	push   $0x0
  pushl $50
801061eb:	6a 32                	push   $0x32
  jmp alltraps
801061ed:	e9 58 f9 ff ff       	jmp    80105b4a <alltraps>

801061f2 <vector51>:
.globl vector51
vector51:
  pushl $0
801061f2:	6a 00                	push   $0x0
  pushl $51
801061f4:	6a 33                	push   $0x33
  jmp alltraps
801061f6:	e9 4f f9 ff ff       	jmp    80105b4a <alltraps>

801061fb <vector52>:
.globl vector52
vector52:
  pushl $0
801061fb:	6a 00                	push   $0x0
  pushl $52
801061fd:	6a 34                	push   $0x34
  jmp alltraps
801061ff:	e9 46 f9 ff ff       	jmp    80105b4a <alltraps>

80106204 <vector53>:
.globl vector53
vector53:
  pushl $0
80106204:	6a 00                	push   $0x0
  pushl $53
80106206:	6a 35                	push   $0x35
  jmp alltraps
80106208:	e9 3d f9 ff ff       	jmp    80105b4a <alltraps>

8010620d <vector54>:
.globl vector54
vector54:
  pushl $0
8010620d:	6a 00                	push   $0x0
  pushl $54
8010620f:	6a 36                	push   $0x36
  jmp alltraps
80106211:	e9 34 f9 ff ff       	jmp    80105b4a <alltraps>

80106216 <vector55>:
.globl vector55
vector55:
  pushl $0
80106216:	6a 00                	push   $0x0
  pushl $55
80106218:	6a 37                	push   $0x37
  jmp alltraps
8010621a:	e9 2b f9 ff ff       	jmp    80105b4a <alltraps>

8010621f <vector56>:
.globl vector56
vector56:
  pushl $0
8010621f:	6a 00                	push   $0x0
  pushl $56
80106221:	6a 38                	push   $0x38
  jmp alltraps
80106223:	e9 22 f9 ff ff       	jmp    80105b4a <alltraps>

80106228 <vector57>:
.globl vector57
vector57:
  pushl $0
80106228:	6a 00                	push   $0x0
  pushl $57
8010622a:	6a 39                	push   $0x39
  jmp alltraps
8010622c:	e9 19 f9 ff ff       	jmp    80105b4a <alltraps>

80106231 <vector58>:
.globl vector58
vector58:
  pushl $0
80106231:	6a 00                	push   $0x0
  pushl $58
80106233:	6a 3a                	push   $0x3a
  jmp alltraps
80106235:	e9 10 f9 ff ff       	jmp    80105b4a <alltraps>

8010623a <vector59>:
.globl vector59
vector59:
  pushl $0
8010623a:	6a 00                	push   $0x0
  pushl $59
8010623c:	6a 3b                	push   $0x3b
  jmp alltraps
8010623e:	e9 07 f9 ff ff       	jmp    80105b4a <alltraps>

80106243 <vector60>:
.globl vector60
vector60:
  pushl $0
80106243:	6a 00                	push   $0x0
  pushl $60
80106245:	6a 3c                	push   $0x3c
  jmp alltraps
80106247:	e9 fe f8 ff ff       	jmp    80105b4a <alltraps>

8010624c <vector61>:
.globl vector61
vector61:
  pushl $0
8010624c:	6a 00                	push   $0x0
  pushl $61
8010624e:	6a 3d                	push   $0x3d
  jmp alltraps
80106250:	e9 f5 f8 ff ff       	jmp    80105b4a <alltraps>

80106255 <vector62>:
.globl vector62
vector62:
  pushl $0
80106255:	6a 00                	push   $0x0
  pushl $62
80106257:	6a 3e                	push   $0x3e
  jmp alltraps
80106259:	e9 ec f8 ff ff       	jmp    80105b4a <alltraps>

8010625e <vector63>:
.globl vector63
vector63:
  pushl $0
8010625e:	6a 00                	push   $0x0
  pushl $63
80106260:	6a 3f                	push   $0x3f
  jmp alltraps
80106262:	e9 e3 f8 ff ff       	jmp    80105b4a <alltraps>

80106267 <vector64>:
.globl vector64
vector64:
  pushl $0
80106267:	6a 00                	push   $0x0
  pushl $64
80106269:	6a 40                	push   $0x40
  jmp alltraps
8010626b:	e9 da f8 ff ff       	jmp    80105b4a <alltraps>

80106270 <vector65>:
.globl vector65
vector65:
  pushl $0
80106270:	6a 00                	push   $0x0
  pushl $65
80106272:	6a 41                	push   $0x41
  jmp alltraps
80106274:	e9 d1 f8 ff ff       	jmp    80105b4a <alltraps>

80106279 <vector66>:
.globl vector66
vector66:
  pushl $0
80106279:	6a 00                	push   $0x0
  pushl $66
8010627b:	6a 42                	push   $0x42
  jmp alltraps
8010627d:	e9 c8 f8 ff ff       	jmp    80105b4a <alltraps>

80106282 <vector67>:
.globl vector67
vector67:
  pushl $0
80106282:	6a 00                	push   $0x0
  pushl $67
80106284:	6a 43                	push   $0x43
  jmp alltraps
80106286:	e9 bf f8 ff ff       	jmp    80105b4a <alltraps>

8010628b <vector68>:
.globl vector68
vector68:
  pushl $0
8010628b:	6a 00                	push   $0x0
  pushl $68
8010628d:	6a 44                	push   $0x44
  jmp alltraps
8010628f:	e9 b6 f8 ff ff       	jmp    80105b4a <alltraps>

80106294 <vector69>:
.globl vector69
vector69:
  pushl $0
80106294:	6a 00                	push   $0x0
  pushl $69
80106296:	6a 45                	push   $0x45
  jmp alltraps
80106298:	e9 ad f8 ff ff       	jmp    80105b4a <alltraps>

8010629d <vector70>:
.globl vector70
vector70:
  pushl $0
8010629d:	6a 00                	push   $0x0
  pushl $70
8010629f:	6a 46                	push   $0x46
  jmp alltraps
801062a1:	e9 a4 f8 ff ff       	jmp    80105b4a <alltraps>

801062a6 <vector71>:
.globl vector71
vector71:
  pushl $0
801062a6:	6a 00                	push   $0x0
  pushl $71
801062a8:	6a 47                	push   $0x47
  jmp alltraps
801062aa:	e9 9b f8 ff ff       	jmp    80105b4a <alltraps>

801062af <vector72>:
.globl vector72
vector72:
  pushl $0
801062af:	6a 00                	push   $0x0
  pushl $72
801062b1:	6a 48                	push   $0x48
  jmp alltraps
801062b3:	e9 92 f8 ff ff       	jmp    80105b4a <alltraps>

801062b8 <vector73>:
.globl vector73
vector73:
  pushl $0
801062b8:	6a 00                	push   $0x0
  pushl $73
801062ba:	6a 49                	push   $0x49
  jmp alltraps
801062bc:	e9 89 f8 ff ff       	jmp    80105b4a <alltraps>

801062c1 <vector74>:
.globl vector74
vector74:
  pushl $0
801062c1:	6a 00                	push   $0x0
  pushl $74
801062c3:	6a 4a                	push   $0x4a
  jmp alltraps
801062c5:	e9 80 f8 ff ff       	jmp    80105b4a <alltraps>

801062ca <vector75>:
.globl vector75
vector75:
  pushl $0
801062ca:	6a 00                	push   $0x0
  pushl $75
801062cc:	6a 4b                	push   $0x4b
  jmp alltraps
801062ce:	e9 77 f8 ff ff       	jmp    80105b4a <alltraps>

801062d3 <vector76>:
.globl vector76
vector76:
  pushl $0
801062d3:	6a 00                	push   $0x0
  pushl $76
801062d5:	6a 4c                	push   $0x4c
  jmp alltraps
801062d7:	e9 6e f8 ff ff       	jmp    80105b4a <alltraps>

801062dc <vector77>:
.globl vector77
vector77:
  pushl $0
801062dc:	6a 00                	push   $0x0
  pushl $77
801062de:	6a 4d                	push   $0x4d
  jmp alltraps
801062e0:	e9 65 f8 ff ff       	jmp    80105b4a <alltraps>

801062e5 <vector78>:
.globl vector78
vector78:
  pushl $0
801062e5:	6a 00                	push   $0x0
  pushl $78
801062e7:	6a 4e                	push   $0x4e
  jmp alltraps
801062e9:	e9 5c f8 ff ff       	jmp    80105b4a <alltraps>

801062ee <vector79>:
.globl vector79
vector79:
  pushl $0
801062ee:	6a 00                	push   $0x0
  pushl $79
801062f0:	6a 4f                	push   $0x4f
  jmp alltraps
801062f2:	e9 53 f8 ff ff       	jmp    80105b4a <alltraps>

801062f7 <vector80>:
.globl vector80
vector80:
  pushl $0
801062f7:	6a 00                	push   $0x0
  pushl $80
801062f9:	6a 50                	push   $0x50
  jmp alltraps
801062fb:	e9 4a f8 ff ff       	jmp    80105b4a <alltraps>

80106300 <vector81>:
.globl vector81
vector81:
  pushl $0
80106300:	6a 00                	push   $0x0
  pushl $81
80106302:	6a 51                	push   $0x51
  jmp alltraps
80106304:	e9 41 f8 ff ff       	jmp    80105b4a <alltraps>

80106309 <vector82>:
.globl vector82
vector82:
  pushl $0
80106309:	6a 00                	push   $0x0
  pushl $82
8010630b:	6a 52                	push   $0x52
  jmp alltraps
8010630d:	e9 38 f8 ff ff       	jmp    80105b4a <alltraps>

80106312 <vector83>:
.globl vector83
vector83:
  pushl $0
80106312:	6a 00                	push   $0x0
  pushl $83
80106314:	6a 53                	push   $0x53
  jmp alltraps
80106316:	e9 2f f8 ff ff       	jmp    80105b4a <alltraps>

8010631b <vector84>:
.globl vector84
vector84:
  pushl $0
8010631b:	6a 00                	push   $0x0
  pushl $84
8010631d:	6a 54                	push   $0x54
  jmp alltraps
8010631f:	e9 26 f8 ff ff       	jmp    80105b4a <alltraps>

80106324 <vector85>:
.globl vector85
vector85:
  pushl $0
80106324:	6a 00                	push   $0x0
  pushl $85
80106326:	6a 55                	push   $0x55
  jmp alltraps
80106328:	e9 1d f8 ff ff       	jmp    80105b4a <alltraps>

8010632d <vector86>:
.globl vector86
vector86:
  pushl $0
8010632d:	6a 00                	push   $0x0
  pushl $86
8010632f:	6a 56                	push   $0x56
  jmp alltraps
80106331:	e9 14 f8 ff ff       	jmp    80105b4a <alltraps>

80106336 <vector87>:
.globl vector87
vector87:
  pushl $0
80106336:	6a 00                	push   $0x0
  pushl $87
80106338:	6a 57                	push   $0x57
  jmp alltraps
8010633a:	e9 0b f8 ff ff       	jmp    80105b4a <alltraps>

8010633f <vector88>:
.globl vector88
vector88:
  pushl $0
8010633f:	6a 00                	push   $0x0
  pushl $88
80106341:	6a 58                	push   $0x58
  jmp alltraps
80106343:	e9 02 f8 ff ff       	jmp    80105b4a <alltraps>

80106348 <vector89>:
.globl vector89
vector89:
  pushl $0
80106348:	6a 00                	push   $0x0
  pushl $89
8010634a:	6a 59                	push   $0x59
  jmp alltraps
8010634c:	e9 f9 f7 ff ff       	jmp    80105b4a <alltraps>

80106351 <vector90>:
.globl vector90
vector90:
  pushl $0
80106351:	6a 00                	push   $0x0
  pushl $90
80106353:	6a 5a                	push   $0x5a
  jmp alltraps
80106355:	e9 f0 f7 ff ff       	jmp    80105b4a <alltraps>

8010635a <vector91>:
.globl vector91
vector91:
  pushl $0
8010635a:	6a 00                	push   $0x0
  pushl $91
8010635c:	6a 5b                	push   $0x5b
  jmp alltraps
8010635e:	e9 e7 f7 ff ff       	jmp    80105b4a <alltraps>

80106363 <vector92>:
.globl vector92
vector92:
  pushl $0
80106363:	6a 00                	push   $0x0
  pushl $92
80106365:	6a 5c                	push   $0x5c
  jmp alltraps
80106367:	e9 de f7 ff ff       	jmp    80105b4a <alltraps>

8010636c <vector93>:
.globl vector93
vector93:
  pushl $0
8010636c:	6a 00                	push   $0x0
  pushl $93
8010636e:	6a 5d                	push   $0x5d
  jmp alltraps
80106370:	e9 d5 f7 ff ff       	jmp    80105b4a <alltraps>

80106375 <vector94>:
.globl vector94
vector94:
  pushl $0
80106375:	6a 00                	push   $0x0
  pushl $94
80106377:	6a 5e                	push   $0x5e
  jmp alltraps
80106379:	e9 cc f7 ff ff       	jmp    80105b4a <alltraps>

8010637e <vector95>:
.globl vector95
vector95:
  pushl $0
8010637e:	6a 00                	push   $0x0
  pushl $95
80106380:	6a 5f                	push   $0x5f
  jmp alltraps
80106382:	e9 c3 f7 ff ff       	jmp    80105b4a <alltraps>

80106387 <vector96>:
.globl vector96
vector96:
  pushl $0
80106387:	6a 00                	push   $0x0
  pushl $96
80106389:	6a 60                	push   $0x60
  jmp alltraps
8010638b:	e9 ba f7 ff ff       	jmp    80105b4a <alltraps>

80106390 <vector97>:
.globl vector97
vector97:
  pushl $0
80106390:	6a 00                	push   $0x0
  pushl $97
80106392:	6a 61                	push   $0x61
  jmp alltraps
80106394:	e9 b1 f7 ff ff       	jmp    80105b4a <alltraps>

80106399 <vector98>:
.globl vector98
vector98:
  pushl $0
80106399:	6a 00                	push   $0x0
  pushl $98
8010639b:	6a 62                	push   $0x62
  jmp alltraps
8010639d:	e9 a8 f7 ff ff       	jmp    80105b4a <alltraps>

801063a2 <vector99>:
.globl vector99
vector99:
  pushl $0
801063a2:	6a 00                	push   $0x0
  pushl $99
801063a4:	6a 63                	push   $0x63
  jmp alltraps
801063a6:	e9 9f f7 ff ff       	jmp    80105b4a <alltraps>

801063ab <vector100>:
.globl vector100
vector100:
  pushl $0
801063ab:	6a 00                	push   $0x0
  pushl $100
801063ad:	6a 64                	push   $0x64
  jmp alltraps
801063af:	e9 96 f7 ff ff       	jmp    80105b4a <alltraps>

801063b4 <vector101>:
.globl vector101
vector101:
  pushl $0
801063b4:	6a 00                	push   $0x0
  pushl $101
801063b6:	6a 65                	push   $0x65
  jmp alltraps
801063b8:	e9 8d f7 ff ff       	jmp    80105b4a <alltraps>

801063bd <vector102>:
.globl vector102
vector102:
  pushl $0
801063bd:	6a 00                	push   $0x0
  pushl $102
801063bf:	6a 66                	push   $0x66
  jmp alltraps
801063c1:	e9 84 f7 ff ff       	jmp    80105b4a <alltraps>

801063c6 <vector103>:
.globl vector103
vector103:
  pushl $0
801063c6:	6a 00                	push   $0x0
  pushl $103
801063c8:	6a 67                	push   $0x67
  jmp alltraps
801063ca:	e9 7b f7 ff ff       	jmp    80105b4a <alltraps>

801063cf <vector104>:
.globl vector104
vector104:
  pushl $0
801063cf:	6a 00                	push   $0x0
  pushl $104
801063d1:	6a 68                	push   $0x68
  jmp alltraps
801063d3:	e9 72 f7 ff ff       	jmp    80105b4a <alltraps>

801063d8 <vector105>:
.globl vector105
vector105:
  pushl $0
801063d8:	6a 00                	push   $0x0
  pushl $105
801063da:	6a 69                	push   $0x69
  jmp alltraps
801063dc:	e9 69 f7 ff ff       	jmp    80105b4a <alltraps>

801063e1 <vector106>:
.globl vector106
vector106:
  pushl $0
801063e1:	6a 00                	push   $0x0
  pushl $106
801063e3:	6a 6a                	push   $0x6a
  jmp alltraps
801063e5:	e9 60 f7 ff ff       	jmp    80105b4a <alltraps>

801063ea <vector107>:
.globl vector107
vector107:
  pushl $0
801063ea:	6a 00                	push   $0x0
  pushl $107
801063ec:	6a 6b                	push   $0x6b
  jmp alltraps
801063ee:	e9 57 f7 ff ff       	jmp    80105b4a <alltraps>

801063f3 <vector108>:
.globl vector108
vector108:
  pushl $0
801063f3:	6a 00                	push   $0x0
  pushl $108
801063f5:	6a 6c                	push   $0x6c
  jmp alltraps
801063f7:	e9 4e f7 ff ff       	jmp    80105b4a <alltraps>

801063fc <vector109>:
.globl vector109
vector109:
  pushl $0
801063fc:	6a 00                	push   $0x0
  pushl $109
801063fe:	6a 6d                	push   $0x6d
  jmp alltraps
80106400:	e9 45 f7 ff ff       	jmp    80105b4a <alltraps>

80106405 <vector110>:
.globl vector110
vector110:
  pushl $0
80106405:	6a 00                	push   $0x0
  pushl $110
80106407:	6a 6e                	push   $0x6e
  jmp alltraps
80106409:	e9 3c f7 ff ff       	jmp    80105b4a <alltraps>

8010640e <vector111>:
.globl vector111
vector111:
  pushl $0
8010640e:	6a 00                	push   $0x0
  pushl $111
80106410:	6a 6f                	push   $0x6f
  jmp alltraps
80106412:	e9 33 f7 ff ff       	jmp    80105b4a <alltraps>

80106417 <vector112>:
.globl vector112
vector112:
  pushl $0
80106417:	6a 00                	push   $0x0
  pushl $112
80106419:	6a 70                	push   $0x70
  jmp alltraps
8010641b:	e9 2a f7 ff ff       	jmp    80105b4a <alltraps>

80106420 <vector113>:
.globl vector113
vector113:
  pushl $0
80106420:	6a 00                	push   $0x0
  pushl $113
80106422:	6a 71                	push   $0x71
  jmp alltraps
80106424:	e9 21 f7 ff ff       	jmp    80105b4a <alltraps>

80106429 <vector114>:
.globl vector114
vector114:
  pushl $0
80106429:	6a 00                	push   $0x0
  pushl $114
8010642b:	6a 72                	push   $0x72
  jmp alltraps
8010642d:	e9 18 f7 ff ff       	jmp    80105b4a <alltraps>

80106432 <vector115>:
.globl vector115
vector115:
  pushl $0
80106432:	6a 00                	push   $0x0
  pushl $115
80106434:	6a 73                	push   $0x73
  jmp alltraps
80106436:	e9 0f f7 ff ff       	jmp    80105b4a <alltraps>

8010643b <vector116>:
.globl vector116
vector116:
  pushl $0
8010643b:	6a 00                	push   $0x0
  pushl $116
8010643d:	6a 74                	push   $0x74
  jmp alltraps
8010643f:	e9 06 f7 ff ff       	jmp    80105b4a <alltraps>

80106444 <vector117>:
.globl vector117
vector117:
  pushl $0
80106444:	6a 00                	push   $0x0
  pushl $117
80106446:	6a 75                	push   $0x75
  jmp alltraps
80106448:	e9 fd f6 ff ff       	jmp    80105b4a <alltraps>

8010644d <vector118>:
.globl vector118
vector118:
  pushl $0
8010644d:	6a 00                	push   $0x0
  pushl $118
8010644f:	6a 76                	push   $0x76
  jmp alltraps
80106451:	e9 f4 f6 ff ff       	jmp    80105b4a <alltraps>

80106456 <vector119>:
.globl vector119
vector119:
  pushl $0
80106456:	6a 00                	push   $0x0
  pushl $119
80106458:	6a 77                	push   $0x77
  jmp alltraps
8010645a:	e9 eb f6 ff ff       	jmp    80105b4a <alltraps>

8010645f <vector120>:
.globl vector120
vector120:
  pushl $0
8010645f:	6a 00                	push   $0x0
  pushl $120
80106461:	6a 78                	push   $0x78
  jmp alltraps
80106463:	e9 e2 f6 ff ff       	jmp    80105b4a <alltraps>

80106468 <vector121>:
.globl vector121
vector121:
  pushl $0
80106468:	6a 00                	push   $0x0
  pushl $121
8010646a:	6a 79                	push   $0x79
  jmp alltraps
8010646c:	e9 d9 f6 ff ff       	jmp    80105b4a <alltraps>

80106471 <vector122>:
.globl vector122
vector122:
  pushl $0
80106471:	6a 00                	push   $0x0
  pushl $122
80106473:	6a 7a                	push   $0x7a
  jmp alltraps
80106475:	e9 d0 f6 ff ff       	jmp    80105b4a <alltraps>

8010647a <vector123>:
.globl vector123
vector123:
  pushl $0
8010647a:	6a 00                	push   $0x0
  pushl $123
8010647c:	6a 7b                	push   $0x7b
  jmp alltraps
8010647e:	e9 c7 f6 ff ff       	jmp    80105b4a <alltraps>

80106483 <vector124>:
.globl vector124
vector124:
  pushl $0
80106483:	6a 00                	push   $0x0
  pushl $124
80106485:	6a 7c                	push   $0x7c
  jmp alltraps
80106487:	e9 be f6 ff ff       	jmp    80105b4a <alltraps>

8010648c <vector125>:
.globl vector125
vector125:
  pushl $0
8010648c:	6a 00                	push   $0x0
  pushl $125
8010648e:	6a 7d                	push   $0x7d
  jmp alltraps
80106490:	e9 b5 f6 ff ff       	jmp    80105b4a <alltraps>

80106495 <vector126>:
.globl vector126
vector126:
  pushl $0
80106495:	6a 00                	push   $0x0
  pushl $126
80106497:	6a 7e                	push   $0x7e
  jmp alltraps
80106499:	e9 ac f6 ff ff       	jmp    80105b4a <alltraps>

8010649e <vector127>:
.globl vector127
vector127:
  pushl $0
8010649e:	6a 00                	push   $0x0
  pushl $127
801064a0:	6a 7f                	push   $0x7f
  jmp alltraps
801064a2:	e9 a3 f6 ff ff       	jmp    80105b4a <alltraps>

801064a7 <vector128>:
.globl vector128
vector128:
  pushl $0
801064a7:	6a 00                	push   $0x0
  pushl $128
801064a9:	68 80 00 00 00       	push   $0x80
  jmp alltraps
801064ae:	e9 97 f6 ff ff       	jmp    80105b4a <alltraps>

801064b3 <vector129>:
.globl vector129
vector129:
  pushl $0
801064b3:	6a 00                	push   $0x0
  pushl $129
801064b5:	68 81 00 00 00       	push   $0x81
  jmp alltraps
801064ba:	e9 8b f6 ff ff       	jmp    80105b4a <alltraps>

801064bf <vector130>:
.globl vector130
vector130:
  pushl $0
801064bf:	6a 00                	push   $0x0
  pushl $130
801064c1:	68 82 00 00 00       	push   $0x82
  jmp alltraps
801064c6:	e9 7f f6 ff ff       	jmp    80105b4a <alltraps>

801064cb <vector131>:
.globl vector131
vector131:
  pushl $0
801064cb:	6a 00                	push   $0x0
  pushl $131
801064cd:	68 83 00 00 00       	push   $0x83
  jmp alltraps
801064d2:	e9 73 f6 ff ff       	jmp    80105b4a <alltraps>

801064d7 <vector132>:
.globl vector132
vector132:
  pushl $0
801064d7:	6a 00                	push   $0x0
  pushl $132
801064d9:	68 84 00 00 00       	push   $0x84
  jmp alltraps
801064de:	e9 67 f6 ff ff       	jmp    80105b4a <alltraps>

801064e3 <vector133>:
.globl vector133
vector133:
  pushl $0
801064e3:	6a 00                	push   $0x0
  pushl $133
801064e5:	68 85 00 00 00       	push   $0x85
  jmp alltraps
801064ea:	e9 5b f6 ff ff       	jmp    80105b4a <alltraps>

801064ef <vector134>:
.globl vector134
vector134:
  pushl $0
801064ef:	6a 00                	push   $0x0
  pushl $134
801064f1:	68 86 00 00 00       	push   $0x86
  jmp alltraps
801064f6:	e9 4f f6 ff ff       	jmp    80105b4a <alltraps>

801064fb <vector135>:
.globl vector135
vector135:
  pushl $0
801064fb:	6a 00                	push   $0x0
  pushl $135
801064fd:	68 87 00 00 00       	push   $0x87
  jmp alltraps
80106502:	e9 43 f6 ff ff       	jmp    80105b4a <alltraps>

80106507 <vector136>:
.globl vector136
vector136:
  pushl $0
80106507:	6a 00                	push   $0x0
  pushl $136
80106509:	68 88 00 00 00       	push   $0x88
  jmp alltraps
8010650e:	e9 37 f6 ff ff       	jmp    80105b4a <alltraps>

80106513 <vector137>:
.globl vector137
vector137:
  pushl $0
80106513:	6a 00                	push   $0x0
  pushl $137
80106515:	68 89 00 00 00       	push   $0x89
  jmp alltraps
8010651a:	e9 2b f6 ff ff       	jmp    80105b4a <alltraps>

8010651f <vector138>:
.globl vector138
vector138:
  pushl $0
8010651f:	6a 00                	push   $0x0
  pushl $138
80106521:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
80106526:	e9 1f f6 ff ff       	jmp    80105b4a <alltraps>

8010652b <vector139>:
.globl vector139
vector139:
  pushl $0
8010652b:	6a 00                	push   $0x0
  pushl $139
8010652d:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
80106532:	e9 13 f6 ff ff       	jmp    80105b4a <alltraps>

80106537 <vector140>:
.globl vector140
vector140:
  pushl $0
80106537:	6a 00                	push   $0x0
  pushl $140
80106539:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
8010653e:	e9 07 f6 ff ff       	jmp    80105b4a <alltraps>

80106543 <vector141>:
.globl vector141
vector141:
  pushl $0
80106543:	6a 00                	push   $0x0
  pushl $141
80106545:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
8010654a:	e9 fb f5 ff ff       	jmp    80105b4a <alltraps>

8010654f <vector142>:
.globl vector142
vector142:
  pushl $0
8010654f:	6a 00                	push   $0x0
  pushl $142
80106551:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
80106556:	e9 ef f5 ff ff       	jmp    80105b4a <alltraps>

8010655b <vector143>:
.globl vector143
vector143:
  pushl $0
8010655b:	6a 00                	push   $0x0
  pushl $143
8010655d:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
80106562:	e9 e3 f5 ff ff       	jmp    80105b4a <alltraps>

80106567 <vector144>:
.globl vector144
vector144:
  pushl $0
80106567:	6a 00                	push   $0x0
  pushl $144
80106569:	68 90 00 00 00       	push   $0x90
  jmp alltraps
8010656e:	e9 d7 f5 ff ff       	jmp    80105b4a <alltraps>

80106573 <vector145>:
.globl vector145
vector145:
  pushl $0
80106573:	6a 00                	push   $0x0
  pushl $145
80106575:	68 91 00 00 00       	push   $0x91
  jmp alltraps
8010657a:	e9 cb f5 ff ff       	jmp    80105b4a <alltraps>

8010657f <vector146>:
.globl vector146
vector146:
  pushl $0
8010657f:	6a 00                	push   $0x0
  pushl $146
80106581:	68 92 00 00 00       	push   $0x92
  jmp alltraps
80106586:	e9 bf f5 ff ff       	jmp    80105b4a <alltraps>

8010658b <vector147>:
.globl vector147
vector147:
  pushl $0
8010658b:	6a 00                	push   $0x0
  pushl $147
8010658d:	68 93 00 00 00       	push   $0x93
  jmp alltraps
80106592:	e9 b3 f5 ff ff       	jmp    80105b4a <alltraps>

80106597 <vector148>:
.globl vector148
vector148:
  pushl $0
80106597:	6a 00                	push   $0x0
  pushl $148
80106599:	68 94 00 00 00       	push   $0x94
  jmp alltraps
8010659e:	e9 a7 f5 ff ff       	jmp    80105b4a <alltraps>

801065a3 <vector149>:
.globl vector149
vector149:
  pushl $0
801065a3:	6a 00                	push   $0x0
  pushl $149
801065a5:	68 95 00 00 00       	push   $0x95
  jmp alltraps
801065aa:	e9 9b f5 ff ff       	jmp    80105b4a <alltraps>

801065af <vector150>:
.globl vector150
vector150:
  pushl $0
801065af:	6a 00                	push   $0x0
  pushl $150
801065b1:	68 96 00 00 00       	push   $0x96
  jmp alltraps
801065b6:	e9 8f f5 ff ff       	jmp    80105b4a <alltraps>

801065bb <vector151>:
.globl vector151
vector151:
  pushl $0
801065bb:	6a 00                	push   $0x0
  pushl $151
801065bd:	68 97 00 00 00       	push   $0x97
  jmp alltraps
801065c2:	e9 83 f5 ff ff       	jmp    80105b4a <alltraps>

801065c7 <vector152>:
.globl vector152
vector152:
  pushl $0
801065c7:	6a 00                	push   $0x0
  pushl $152
801065c9:	68 98 00 00 00       	push   $0x98
  jmp alltraps
801065ce:	e9 77 f5 ff ff       	jmp    80105b4a <alltraps>

801065d3 <vector153>:
.globl vector153
vector153:
  pushl $0
801065d3:	6a 00                	push   $0x0
  pushl $153
801065d5:	68 99 00 00 00       	push   $0x99
  jmp alltraps
801065da:	e9 6b f5 ff ff       	jmp    80105b4a <alltraps>

801065df <vector154>:
.globl vector154
vector154:
  pushl $0
801065df:	6a 00                	push   $0x0
  pushl $154
801065e1:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
801065e6:	e9 5f f5 ff ff       	jmp    80105b4a <alltraps>

801065eb <vector155>:
.globl vector155
vector155:
  pushl $0
801065eb:	6a 00                	push   $0x0
  pushl $155
801065ed:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
801065f2:	e9 53 f5 ff ff       	jmp    80105b4a <alltraps>

801065f7 <vector156>:
.globl vector156
vector156:
  pushl $0
801065f7:	6a 00                	push   $0x0
  pushl $156
801065f9:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
801065fe:	e9 47 f5 ff ff       	jmp    80105b4a <alltraps>

80106603 <vector157>:
.globl vector157
vector157:
  pushl $0
80106603:	6a 00                	push   $0x0
  pushl $157
80106605:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
8010660a:	e9 3b f5 ff ff       	jmp    80105b4a <alltraps>

8010660f <vector158>:
.globl vector158
vector158:
  pushl $0
8010660f:	6a 00                	push   $0x0
  pushl $158
80106611:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
80106616:	e9 2f f5 ff ff       	jmp    80105b4a <alltraps>

8010661b <vector159>:
.globl vector159
vector159:
  pushl $0
8010661b:	6a 00                	push   $0x0
  pushl $159
8010661d:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
80106622:	e9 23 f5 ff ff       	jmp    80105b4a <alltraps>

80106627 <vector160>:
.globl vector160
vector160:
  pushl $0
80106627:	6a 00                	push   $0x0
  pushl $160
80106629:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
8010662e:	e9 17 f5 ff ff       	jmp    80105b4a <alltraps>

80106633 <vector161>:
.globl vector161
vector161:
  pushl $0
80106633:	6a 00                	push   $0x0
  pushl $161
80106635:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
8010663a:	e9 0b f5 ff ff       	jmp    80105b4a <alltraps>

8010663f <vector162>:
.globl vector162
vector162:
  pushl $0
8010663f:	6a 00                	push   $0x0
  pushl $162
80106641:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
80106646:	e9 ff f4 ff ff       	jmp    80105b4a <alltraps>

8010664b <vector163>:
.globl vector163
vector163:
  pushl $0
8010664b:	6a 00                	push   $0x0
  pushl $163
8010664d:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
80106652:	e9 f3 f4 ff ff       	jmp    80105b4a <alltraps>

80106657 <vector164>:
.globl vector164
vector164:
  pushl $0
80106657:	6a 00                	push   $0x0
  pushl $164
80106659:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
8010665e:	e9 e7 f4 ff ff       	jmp    80105b4a <alltraps>

80106663 <vector165>:
.globl vector165
vector165:
  pushl $0
80106663:	6a 00                	push   $0x0
  pushl $165
80106665:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
8010666a:	e9 db f4 ff ff       	jmp    80105b4a <alltraps>

8010666f <vector166>:
.globl vector166
vector166:
  pushl $0
8010666f:	6a 00                	push   $0x0
  pushl $166
80106671:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
80106676:	e9 cf f4 ff ff       	jmp    80105b4a <alltraps>

8010667b <vector167>:
.globl vector167
vector167:
  pushl $0
8010667b:	6a 00                	push   $0x0
  pushl $167
8010667d:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
80106682:	e9 c3 f4 ff ff       	jmp    80105b4a <alltraps>

80106687 <vector168>:
.globl vector168
vector168:
  pushl $0
80106687:	6a 00                	push   $0x0
  pushl $168
80106689:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
8010668e:	e9 b7 f4 ff ff       	jmp    80105b4a <alltraps>

80106693 <vector169>:
.globl vector169
vector169:
  pushl $0
80106693:	6a 00                	push   $0x0
  pushl $169
80106695:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
8010669a:	e9 ab f4 ff ff       	jmp    80105b4a <alltraps>

8010669f <vector170>:
.globl vector170
vector170:
  pushl $0
8010669f:	6a 00                	push   $0x0
  pushl $170
801066a1:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
801066a6:	e9 9f f4 ff ff       	jmp    80105b4a <alltraps>

801066ab <vector171>:
.globl vector171
vector171:
  pushl $0
801066ab:	6a 00                	push   $0x0
  pushl $171
801066ad:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
801066b2:	e9 93 f4 ff ff       	jmp    80105b4a <alltraps>

801066b7 <vector172>:
.globl vector172
vector172:
  pushl $0
801066b7:	6a 00                	push   $0x0
  pushl $172
801066b9:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
801066be:	e9 87 f4 ff ff       	jmp    80105b4a <alltraps>

801066c3 <vector173>:
.globl vector173
vector173:
  pushl $0
801066c3:	6a 00                	push   $0x0
  pushl $173
801066c5:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
801066ca:	e9 7b f4 ff ff       	jmp    80105b4a <alltraps>

801066cf <vector174>:
.globl vector174
vector174:
  pushl $0
801066cf:	6a 00                	push   $0x0
  pushl $174
801066d1:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
801066d6:	e9 6f f4 ff ff       	jmp    80105b4a <alltraps>

801066db <vector175>:
.globl vector175
vector175:
  pushl $0
801066db:	6a 00                	push   $0x0
  pushl $175
801066dd:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
801066e2:	e9 63 f4 ff ff       	jmp    80105b4a <alltraps>

801066e7 <vector176>:
.globl vector176
vector176:
  pushl $0
801066e7:	6a 00                	push   $0x0
  pushl $176
801066e9:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
801066ee:	e9 57 f4 ff ff       	jmp    80105b4a <alltraps>

801066f3 <vector177>:
.globl vector177
vector177:
  pushl $0
801066f3:	6a 00                	push   $0x0
  pushl $177
801066f5:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
801066fa:	e9 4b f4 ff ff       	jmp    80105b4a <alltraps>

801066ff <vector178>:
.globl vector178
vector178:
  pushl $0
801066ff:	6a 00                	push   $0x0
  pushl $178
80106701:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
80106706:	e9 3f f4 ff ff       	jmp    80105b4a <alltraps>

8010670b <vector179>:
.globl vector179
vector179:
  pushl $0
8010670b:	6a 00                	push   $0x0
  pushl $179
8010670d:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
80106712:	e9 33 f4 ff ff       	jmp    80105b4a <alltraps>

80106717 <vector180>:
.globl vector180
vector180:
  pushl $0
80106717:	6a 00                	push   $0x0
  pushl $180
80106719:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
8010671e:	e9 27 f4 ff ff       	jmp    80105b4a <alltraps>

80106723 <vector181>:
.globl vector181
vector181:
  pushl $0
80106723:	6a 00                	push   $0x0
  pushl $181
80106725:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
8010672a:	e9 1b f4 ff ff       	jmp    80105b4a <alltraps>

8010672f <vector182>:
.globl vector182
vector182:
  pushl $0
8010672f:	6a 00                	push   $0x0
  pushl $182
80106731:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
80106736:	e9 0f f4 ff ff       	jmp    80105b4a <alltraps>

8010673b <vector183>:
.globl vector183
vector183:
  pushl $0
8010673b:	6a 00                	push   $0x0
  pushl $183
8010673d:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
80106742:	e9 03 f4 ff ff       	jmp    80105b4a <alltraps>

80106747 <vector184>:
.globl vector184
vector184:
  pushl $0
80106747:	6a 00                	push   $0x0
  pushl $184
80106749:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
8010674e:	e9 f7 f3 ff ff       	jmp    80105b4a <alltraps>

80106753 <vector185>:
.globl vector185
vector185:
  pushl $0
80106753:	6a 00                	push   $0x0
  pushl $185
80106755:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
8010675a:	e9 eb f3 ff ff       	jmp    80105b4a <alltraps>

8010675f <vector186>:
.globl vector186
vector186:
  pushl $0
8010675f:	6a 00                	push   $0x0
  pushl $186
80106761:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
80106766:	e9 df f3 ff ff       	jmp    80105b4a <alltraps>

8010676b <vector187>:
.globl vector187
vector187:
  pushl $0
8010676b:	6a 00                	push   $0x0
  pushl $187
8010676d:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
80106772:	e9 d3 f3 ff ff       	jmp    80105b4a <alltraps>

80106777 <vector188>:
.globl vector188
vector188:
  pushl $0
80106777:	6a 00                	push   $0x0
  pushl $188
80106779:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
8010677e:	e9 c7 f3 ff ff       	jmp    80105b4a <alltraps>

80106783 <vector189>:
.globl vector189
vector189:
  pushl $0
80106783:	6a 00                	push   $0x0
  pushl $189
80106785:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
8010678a:	e9 bb f3 ff ff       	jmp    80105b4a <alltraps>

8010678f <vector190>:
.globl vector190
vector190:
  pushl $0
8010678f:	6a 00                	push   $0x0
  pushl $190
80106791:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
80106796:	e9 af f3 ff ff       	jmp    80105b4a <alltraps>

8010679b <vector191>:
.globl vector191
vector191:
  pushl $0
8010679b:	6a 00                	push   $0x0
  pushl $191
8010679d:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
801067a2:	e9 a3 f3 ff ff       	jmp    80105b4a <alltraps>

801067a7 <vector192>:
.globl vector192
vector192:
  pushl $0
801067a7:	6a 00                	push   $0x0
  pushl $192
801067a9:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
801067ae:	e9 97 f3 ff ff       	jmp    80105b4a <alltraps>

801067b3 <vector193>:
.globl vector193
vector193:
  pushl $0
801067b3:	6a 00                	push   $0x0
  pushl $193
801067b5:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
801067ba:	e9 8b f3 ff ff       	jmp    80105b4a <alltraps>

801067bf <vector194>:
.globl vector194
vector194:
  pushl $0
801067bf:	6a 00                	push   $0x0
  pushl $194
801067c1:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
801067c6:	e9 7f f3 ff ff       	jmp    80105b4a <alltraps>

801067cb <vector195>:
.globl vector195
vector195:
  pushl $0
801067cb:	6a 00                	push   $0x0
  pushl $195
801067cd:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
801067d2:	e9 73 f3 ff ff       	jmp    80105b4a <alltraps>

801067d7 <vector196>:
.globl vector196
vector196:
  pushl $0
801067d7:	6a 00                	push   $0x0
  pushl $196
801067d9:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
801067de:	e9 67 f3 ff ff       	jmp    80105b4a <alltraps>

801067e3 <vector197>:
.globl vector197
vector197:
  pushl $0
801067e3:	6a 00                	push   $0x0
  pushl $197
801067e5:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
801067ea:	e9 5b f3 ff ff       	jmp    80105b4a <alltraps>

801067ef <vector198>:
.globl vector198
vector198:
  pushl $0
801067ef:	6a 00                	push   $0x0
  pushl $198
801067f1:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
801067f6:	e9 4f f3 ff ff       	jmp    80105b4a <alltraps>

801067fb <vector199>:
.globl vector199
vector199:
  pushl $0
801067fb:	6a 00                	push   $0x0
  pushl $199
801067fd:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
80106802:	e9 43 f3 ff ff       	jmp    80105b4a <alltraps>

80106807 <vector200>:
.globl vector200
vector200:
  pushl $0
80106807:	6a 00                	push   $0x0
  pushl $200
80106809:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
8010680e:	e9 37 f3 ff ff       	jmp    80105b4a <alltraps>

80106813 <vector201>:
.globl vector201
vector201:
  pushl $0
80106813:	6a 00                	push   $0x0
  pushl $201
80106815:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
8010681a:	e9 2b f3 ff ff       	jmp    80105b4a <alltraps>

8010681f <vector202>:
.globl vector202
vector202:
  pushl $0
8010681f:	6a 00                	push   $0x0
  pushl $202
80106821:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
80106826:	e9 1f f3 ff ff       	jmp    80105b4a <alltraps>

8010682b <vector203>:
.globl vector203
vector203:
  pushl $0
8010682b:	6a 00                	push   $0x0
  pushl $203
8010682d:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
80106832:	e9 13 f3 ff ff       	jmp    80105b4a <alltraps>

80106837 <vector204>:
.globl vector204
vector204:
  pushl $0
80106837:	6a 00                	push   $0x0
  pushl $204
80106839:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
8010683e:	e9 07 f3 ff ff       	jmp    80105b4a <alltraps>

80106843 <vector205>:
.globl vector205
vector205:
  pushl $0
80106843:	6a 00                	push   $0x0
  pushl $205
80106845:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
8010684a:	e9 fb f2 ff ff       	jmp    80105b4a <alltraps>

8010684f <vector206>:
.globl vector206
vector206:
  pushl $0
8010684f:	6a 00                	push   $0x0
  pushl $206
80106851:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
80106856:	e9 ef f2 ff ff       	jmp    80105b4a <alltraps>

8010685b <vector207>:
.globl vector207
vector207:
  pushl $0
8010685b:	6a 00                	push   $0x0
  pushl $207
8010685d:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
80106862:	e9 e3 f2 ff ff       	jmp    80105b4a <alltraps>

80106867 <vector208>:
.globl vector208
vector208:
  pushl $0
80106867:	6a 00                	push   $0x0
  pushl $208
80106869:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
8010686e:	e9 d7 f2 ff ff       	jmp    80105b4a <alltraps>

80106873 <vector209>:
.globl vector209
vector209:
  pushl $0
80106873:	6a 00                	push   $0x0
  pushl $209
80106875:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
8010687a:	e9 cb f2 ff ff       	jmp    80105b4a <alltraps>

8010687f <vector210>:
.globl vector210
vector210:
  pushl $0
8010687f:	6a 00                	push   $0x0
  pushl $210
80106881:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80106886:	e9 bf f2 ff ff       	jmp    80105b4a <alltraps>

8010688b <vector211>:
.globl vector211
vector211:
  pushl $0
8010688b:	6a 00                	push   $0x0
  pushl $211
8010688d:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80106892:	e9 b3 f2 ff ff       	jmp    80105b4a <alltraps>

80106897 <vector212>:
.globl vector212
vector212:
  pushl $0
80106897:	6a 00                	push   $0x0
  pushl $212
80106899:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
8010689e:	e9 a7 f2 ff ff       	jmp    80105b4a <alltraps>

801068a3 <vector213>:
.globl vector213
vector213:
  pushl $0
801068a3:	6a 00                	push   $0x0
  pushl $213
801068a5:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
801068aa:	e9 9b f2 ff ff       	jmp    80105b4a <alltraps>

801068af <vector214>:
.globl vector214
vector214:
  pushl $0
801068af:	6a 00                	push   $0x0
  pushl $214
801068b1:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
801068b6:	e9 8f f2 ff ff       	jmp    80105b4a <alltraps>

801068bb <vector215>:
.globl vector215
vector215:
  pushl $0
801068bb:	6a 00                	push   $0x0
  pushl $215
801068bd:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
801068c2:	e9 83 f2 ff ff       	jmp    80105b4a <alltraps>

801068c7 <vector216>:
.globl vector216
vector216:
  pushl $0
801068c7:	6a 00                	push   $0x0
  pushl $216
801068c9:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
801068ce:	e9 77 f2 ff ff       	jmp    80105b4a <alltraps>

801068d3 <vector217>:
.globl vector217
vector217:
  pushl $0
801068d3:	6a 00                	push   $0x0
  pushl $217
801068d5:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
801068da:	e9 6b f2 ff ff       	jmp    80105b4a <alltraps>

801068df <vector218>:
.globl vector218
vector218:
  pushl $0
801068df:	6a 00                	push   $0x0
  pushl $218
801068e1:	68 da 00 00 00       	push   $0xda
  jmp alltraps
801068e6:	e9 5f f2 ff ff       	jmp    80105b4a <alltraps>

801068eb <vector219>:
.globl vector219
vector219:
  pushl $0
801068eb:	6a 00                	push   $0x0
  pushl $219
801068ed:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
801068f2:	e9 53 f2 ff ff       	jmp    80105b4a <alltraps>

801068f7 <vector220>:
.globl vector220
vector220:
  pushl $0
801068f7:	6a 00                	push   $0x0
  pushl $220
801068f9:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
801068fe:	e9 47 f2 ff ff       	jmp    80105b4a <alltraps>

80106903 <vector221>:
.globl vector221
vector221:
  pushl $0
80106903:	6a 00                	push   $0x0
  pushl $221
80106905:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
8010690a:	e9 3b f2 ff ff       	jmp    80105b4a <alltraps>

8010690f <vector222>:
.globl vector222
vector222:
  pushl $0
8010690f:	6a 00                	push   $0x0
  pushl $222
80106911:	68 de 00 00 00       	push   $0xde
  jmp alltraps
80106916:	e9 2f f2 ff ff       	jmp    80105b4a <alltraps>

8010691b <vector223>:
.globl vector223
vector223:
  pushl $0
8010691b:	6a 00                	push   $0x0
  pushl $223
8010691d:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
80106922:	e9 23 f2 ff ff       	jmp    80105b4a <alltraps>

80106927 <vector224>:
.globl vector224
vector224:
  pushl $0
80106927:	6a 00                	push   $0x0
  pushl $224
80106929:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
8010692e:	e9 17 f2 ff ff       	jmp    80105b4a <alltraps>

80106933 <vector225>:
.globl vector225
vector225:
  pushl $0
80106933:	6a 00                	push   $0x0
  pushl $225
80106935:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
8010693a:	e9 0b f2 ff ff       	jmp    80105b4a <alltraps>

8010693f <vector226>:
.globl vector226
vector226:
  pushl $0
8010693f:	6a 00                	push   $0x0
  pushl $226
80106941:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
80106946:	e9 ff f1 ff ff       	jmp    80105b4a <alltraps>

8010694b <vector227>:
.globl vector227
vector227:
  pushl $0
8010694b:	6a 00                	push   $0x0
  pushl $227
8010694d:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
80106952:	e9 f3 f1 ff ff       	jmp    80105b4a <alltraps>

80106957 <vector228>:
.globl vector228
vector228:
  pushl $0
80106957:	6a 00                	push   $0x0
  pushl $228
80106959:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
8010695e:	e9 e7 f1 ff ff       	jmp    80105b4a <alltraps>

80106963 <vector229>:
.globl vector229
vector229:
  pushl $0
80106963:	6a 00                	push   $0x0
  pushl $229
80106965:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
8010696a:	e9 db f1 ff ff       	jmp    80105b4a <alltraps>

8010696f <vector230>:
.globl vector230
vector230:
  pushl $0
8010696f:	6a 00                	push   $0x0
  pushl $230
80106971:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80106976:	e9 cf f1 ff ff       	jmp    80105b4a <alltraps>

8010697b <vector231>:
.globl vector231
vector231:
  pushl $0
8010697b:	6a 00                	push   $0x0
  pushl $231
8010697d:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80106982:	e9 c3 f1 ff ff       	jmp    80105b4a <alltraps>

80106987 <vector232>:
.globl vector232
vector232:
  pushl $0
80106987:	6a 00                	push   $0x0
  pushl $232
80106989:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
8010698e:	e9 b7 f1 ff ff       	jmp    80105b4a <alltraps>

80106993 <vector233>:
.globl vector233
vector233:
  pushl $0
80106993:	6a 00                	push   $0x0
  pushl $233
80106995:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
8010699a:	e9 ab f1 ff ff       	jmp    80105b4a <alltraps>

8010699f <vector234>:
.globl vector234
vector234:
  pushl $0
8010699f:	6a 00                	push   $0x0
  pushl $234
801069a1:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
801069a6:	e9 9f f1 ff ff       	jmp    80105b4a <alltraps>

801069ab <vector235>:
.globl vector235
vector235:
  pushl $0
801069ab:	6a 00                	push   $0x0
  pushl $235
801069ad:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
801069b2:	e9 93 f1 ff ff       	jmp    80105b4a <alltraps>

801069b7 <vector236>:
.globl vector236
vector236:
  pushl $0
801069b7:	6a 00                	push   $0x0
  pushl $236
801069b9:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
801069be:	e9 87 f1 ff ff       	jmp    80105b4a <alltraps>

801069c3 <vector237>:
.globl vector237
vector237:
  pushl $0
801069c3:	6a 00                	push   $0x0
  pushl $237
801069c5:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
801069ca:	e9 7b f1 ff ff       	jmp    80105b4a <alltraps>

801069cf <vector238>:
.globl vector238
vector238:
  pushl $0
801069cf:	6a 00                	push   $0x0
  pushl $238
801069d1:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
801069d6:	e9 6f f1 ff ff       	jmp    80105b4a <alltraps>

801069db <vector239>:
.globl vector239
vector239:
  pushl $0
801069db:	6a 00                	push   $0x0
  pushl $239
801069dd:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
801069e2:	e9 63 f1 ff ff       	jmp    80105b4a <alltraps>

801069e7 <vector240>:
.globl vector240
vector240:
  pushl $0
801069e7:	6a 00                	push   $0x0
  pushl $240
801069e9:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
801069ee:	e9 57 f1 ff ff       	jmp    80105b4a <alltraps>

801069f3 <vector241>:
.globl vector241
vector241:
  pushl $0
801069f3:	6a 00                	push   $0x0
  pushl $241
801069f5:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
801069fa:	e9 4b f1 ff ff       	jmp    80105b4a <alltraps>

801069ff <vector242>:
.globl vector242
vector242:
  pushl $0
801069ff:	6a 00                	push   $0x0
  pushl $242
80106a01:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
80106a06:	e9 3f f1 ff ff       	jmp    80105b4a <alltraps>

80106a0b <vector243>:
.globl vector243
vector243:
  pushl $0
80106a0b:	6a 00                	push   $0x0
  pushl $243
80106a0d:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
80106a12:	e9 33 f1 ff ff       	jmp    80105b4a <alltraps>

80106a17 <vector244>:
.globl vector244
vector244:
  pushl $0
80106a17:	6a 00                	push   $0x0
  pushl $244
80106a19:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
80106a1e:	e9 27 f1 ff ff       	jmp    80105b4a <alltraps>

80106a23 <vector245>:
.globl vector245
vector245:
  pushl $0
80106a23:	6a 00                	push   $0x0
  pushl $245
80106a25:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
80106a2a:	e9 1b f1 ff ff       	jmp    80105b4a <alltraps>

80106a2f <vector246>:
.globl vector246
vector246:
  pushl $0
80106a2f:	6a 00                	push   $0x0
  pushl $246
80106a31:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
80106a36:	e9 0f f1 ff ff       	jmp    80105b4a <alltraps>

80106a3b <vector247>:
.globl vector247
vector247:
  pushl $0
80106a3b:	6a 00                	push   $0x0
  pushl $247
80106a3d:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
80106a42:	e9 03 f1 ff ff       	jmp    80105b4a <alltraps>

80106a47 <vector248>:
.globl vector248
vector248:
  pushl $0
80106a47:	6a 00                	push   $0x0
  pushl $248
80106a49:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
80106a4e:	e9 f7 f0 ff ff       	jmp    80105b4a <alltraps>

80106a53 <vector249>:
.globl vector249
vector249:
  pushl $0
80106a53:	6a 00                	push   $0x0
  pushl $249
80106a55:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
80106a5a:	e9 eb f0 ff ff       	jmp    80105b4a <alltraps>

80106a5f <vector250>:
.globl vector250
vector250:
  pushl $0
80106a5f:	6a 00                	push   $0x0
  pushl $250
80106a61:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80106a66:	e9 df f0 ff ff       	jmp    80105b4a <alltraps>

80106a6b <vector251>:
.globl vector251
vector251:
  pushl $0
80106a6b:	6a 00                	push   $0x0
  pushl $251
80106a6d:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80106a72:	e9 d3 f0 ff ff       	jmp    80105b4a <alltraps>

80106a77 <vector252>:
.globl vector252
vector252:
  pushl $0
80106a77:	6a 00                	push   $0x0
  pushl $252
80106a79:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
80106a7e:	e9 c7 f0 ff ff       	jmp    80105b4a <alltraps>

80106a83 <vector253>:
.globl vector253
vector253:
  pushl $0
80106a83:	6a 00                	push   $0x0
  pushl $253
80106a85:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
80106a8a:	e9 bb f0 ff ff       	jmp    80105b4a <alltraps>

80106a8f <vector254>:
.globl vector254
vector254:
  pushl $0
80106a8f:	6a 00                	push   $0x0
  pushl $254
80106a91:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80106a96:	e9 af f0 ff ff       	jmp    80105b4a <alltraps>

80106a9b <vector255>:
.globl vector255
vector255:
  pushl $0
80106a9b:	6a 00                	push   $0x0
  pushl $255
80106a9d:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80106aa2:	e9 a3 f0 ff ff       	jmp    80105b4a <alltraps>
80106aa7:	66 90                	xchg   %ax,%ax
80106aa9:	66 90                	xchg   %ax,%ax
80106aab:	66 90                	xchg   %ax,%ax
80106aad:	66 90                	xchg   %ax,%ax
80106aaf:	90                   	nop

80106ab0 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106ab0:	55                   	push   %ebp
80106ab1:	89 e5                	mov    %esp,%ebp
80106ab3:	57                   	push   %edi
80106ab4:	56                   	push   %esi
80106ab5:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80106ab6:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
80106abc:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106ac2:	83 ec 1c             	sub    $0x1c,%esp
80106ac5:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  for(; a  < oldsz; a += PGSIZE){
80106ac8:	39 d3                	cmp    %edx,%ebx
80106aca:	73 49                	jae    80106b15 <deallocuvm.part.0+0x65>
80106acc:	89 c7                	mov    %eax,%edi
80106ace:	eb 0c                	jmp    80106adc <deallocuvm.part.0+0x2c>
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
80106ad0:	83 c0 01             	add    $0x1,%eax
80106ad3:	c1 e0 16             	shl    $0x16,%eax
80106ad6:	89 c3                	mov    %eax,%ebx
  for(; a  < oldsz; a += PGSIZE){
80106ad8:	39 da                	cmp    %ebx,%edx
80106ada:	76 39                	jbe    80106b15 <deallocuvm.part.0+0x65>
  pde = &pgdir[PDX(va)];
80106adc:	89 d8                	mov    %ebx,%eax
80106ade:	c1 e8 16             	shr    $0x16,%eax
  if(*pde & PTE_P){
80106ae1:	8b 0c 87             	mov    (%edi,%eax,4),%ecx
80106ae4:	f6 c1 01             	test   $0x1,%cl
80106ae7:	74 e7                	je     80106ad0 <deallocuvm.part.0+0x20>
  return &pgtab[PTX(va)];
80106ae9:	89 de                	mov    %ebx,%esi
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106aeb:	81 e1 00 f0 ff ff    	and    $0xfffff000,%ecx
  return &pgtab[PTX(va)];
80106af1:	c1 ee 0a             	shr    $0xa,%esi
80106af4:	81 e6 fc 0f 00 00    	and    $0xffc,%esi
80106afa:	8d b4 31 00 00 00 80 	lea    -0x80000000(%ecx,%esi,1),%esi
    if(!pte)
80106b01:	85 f6                	test   %esi,%esi
80106b03:	74 cb                	je     80106ad0 <deallocuvm.part.0+0x20>
    else if((*pte & PTE_P) != 0){
80106b05:	8b 06                	mov    (%esi),%eax
80106b07:	a8 01                	test   $0x1,%al
80106b09:	75 15                	jne    80106b20 <deallocuvm.part.0+0x70>
  for(; a  < oldsz; a += PGSIZE){
80106b0b:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106b11:	39 da                	cmp    %ebx,%edx
80106b13:	77 c7                	ja     80106adc <deallocuvm.part.0+0x2c>
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
}
80106b15:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106b18:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106b1b:	5b                   	pop    %ebx
80106b1c:	5e                   	pop    %esi
80106b1d:	5f                   	pop    %edi
80106b1e:	5d                   	pop    %ebp
80106b1f:	c3                   	ret    
      if(pa == 0)
80106b20:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106b25:	74 25                	je     80106b4c <deallocuvm.part.0+0x9c>
      kfree(v);
80106b27:	83 ec 0c             	sub    $0xc,%esp
      char *v = P2V(pa);
80106b2a:	05 00 00 00 80       	add    $0x80000000,%eax
80106b2f:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  for(; a  < oldsz; a += PGSIZE){
80106b32:	81 c3 00 10 00 00    	add    $0x1000,%ebx
      kfree(v);
80106b38:	50                   	push   %eax
80106b39:	e8 92 bc ff ff       	call   801027d0 <kfree>
      *pte = 0;
80106b3e:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
  for(; a  < oldsz; a += PGSIZE){
80106b44:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80106b47:	83 c4 10             	add    $0x10,%esp
80106b4a:	eb 8c                	jmp    80106ad8 <deallocuvm.part.0+0x28>
        panic("kfree");
80106b4c:	83 ec 0c             	sub    $0xc,%esp
80106b4f:	68 5e 77 10 80       	push   $0x8010775e
80106b54:	e8 27 98 ff ff       	call   80100380 <panic>
80106b59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106b60 <mappages>:
{
80106b60:	55                   	push   %ebp
80106b61:	89 e5                	mov    %esp,%ebp
80106b63:	57                   	push   %edi
80106b64:	56                   	push   %esi
80106b65:	53                   	push   %ebx
  a = (char*)PGROUNDDOWN((uint)va);
80106b66:	89 d3                	mov    %edx,%ebx
80106b68:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
{
80106b6e:	83 ec 1c             	sub    $0x1c,%esp
80106b71:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80106b74:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
80106b78:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106b7d:	89 45 dc             	mov    %eax,-0x24(%ebp)
80106b80:	8b 45 08             	mov    0x8(%ebp),%eax
80106b83:	29 d8                	sub    %ebx,%eax
80106b85:	89 45 e0             	mov    %eax,-0x20(%ebp)
80106b88:	eb 3d                	jmp    80106bc7 <mappages+0x67>
80106b8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return &pgtab[PTX(va)];
80106b90:	89 da                	mov    %ebx,%edx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106b92:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
80106b97:	c1 ea 0a             	shr    $0xa,%edx
80106b9a:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80106ba0:	8d 84 10 00 00 00 80 	lea    -0x80000000(%eax,%edx,1),%eax
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80106ba7:	85 c0                	test   %eax,%eax
80106ba9:	74 75                	je     80106c20 <mappages+0xc0>
    if(*pte & PTE_P)
80106bab:	f6 00 01             	testb  $0x1,(%eax)
80106bae:	0f 85 86 00 00 00    	jne    80106c3a <mappages+0xda>
    *pte = pa | perm | PTE_P;
80106bb4:	0b 75 0c             	or     0xc(%ebp),%esi
80106bb7:	83 ce 01             	or     $0x1,%esi
80106bba:	89 30                	mov    %esi,(%eax)
    if(a == last)
80106bbc:	3b 5d dc             	cmp    -0x24(%ebp),%ebx
80106bbf:	74 6f                	je     80106c30 <mappages+0xd0>
    a += PGSIZE;
80106bc1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
  for(;;){
80106bc7:	8b 45 e0             	mov    -0x20(%ebp),%eax
  pde = &pgdir[PDX(va)];
80106bca:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80106bcd:	8d 34 18             	lea    (%eax,%ebx,1),%esi
80106bd0:	89 d8                	mov    %ebx,%eax
80106bd2:	c1 e8 16             	shr    $0x16,%eax
80106bd5:	8d 3c 81             	lea    (%ecx,%eax,4),%edi
  if(*pde & PTE_P){
80106bd8:	8b 07                	mov    (%edi),%eax
80106bda:	a8 01                	test   $0x1,%al
80106bdc:	75 b2                	jne    80106b90 <mappages+0x30>
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80106bde:	e8 ad bd ff ff       	call   80102990 <kalloc>
80106be3:	85 c0                	test   %eax,%eax
80106be5:	74 39                	je     80106c20 <mappages+0xc0>
    memset(pgtab, 0, PGSIZE);
80106be7:	83 ec 04             	sub    $0x4,%esp
80106bea:	89 45 d8             	mov    %eax,-0x28(%ebp)
80106bed:	68 00 10 00 00       	push   $0x1000
80106bf2:	6a 00                	push   $0x0
80106bf4:	50                   	push   %eax
80106bf5:	e8 76 dd ff ff       	call   80104970 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
80106bfa:	8b 55 d8             	mov    -0x28(%ebp),%edx
  return &pgtab[PTX(va)];
80106bfd:	83 c4 10             	add    $0x10,%esp
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
80106c00:	8d 82 00 00 00 80    	lea    -0x80000000(%edx),%eax
80106c06:	83 c8 07             	or     $0x7,%eax
80106c09:	89 07                	mov    %eax,(%edi)
  return &pgtab[PTX(va)];
80106c0b:	89 d8                	mov    %ebx,%eax
80106c0d:	c1 e8 0a             	shr    $0xa,%eax
80106c10:	25 fc 0f 00 00       	and    $0xffc,%eax
80106c15:	01 d0                	add    %edx,%eax
80106c17:	eb 92                	jmp    80106bab <mappages+0x4b>
80106c19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
}
80106c20:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80106c23:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106c28:	5b                   	pop    %ebx
80106c29:	5e                   	pop    %esi
80106c2a:	5f                   	pop    %edi
80106c2b:	5d                   	pop    %ebp
80106c2c:	c3                   	ret    
80106c2d:	8d 76 00             	lea    0x0(%esi),%esi
80106c30:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80106c33:	31 c0                	xor    %eax,%eax
}
80106c35:	5b                   	pop    %ebx
80106c36:	5e                   	pop    %esi
80106c37:	5f                   	pop    %edi
80106c38:	5d                   	pop    %ebp
80106c39:	c3                   	ret    
      panic("remap");
80106c3a:	83 ec 0c             	sub    $0xc,%esp
80106c3d:	68 a8 7d 10 80       	push   $0x80107da8
80106c42:	e8 39 97 ff ff       	call   80100380 <panic>
80106c47:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106c4e:	66 90                	xchg   %ax,%ax

80106c50 <seginit>:
{
80106c50:	55                   	push   %ebp
80106c51:	89 e5                	mov    %esp,%ebp
80106c53:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
80106c56:	e8 05 d0 ff ff       	call   80103c60 <cpuid>
  pd[0] = size-1;
80106c5b:	ba 2f 00 00 00       	mov    $0x2f,%edx
80106c60:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
80106c66:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80106c6a:	c7 80 18 18 11 80 ff 	movl   $0xffff,-0x7feee7e8(%eax)
80106c71:	ff 00 00 
80106c74:	c7 80 1c 18 11 80 00 	movl   $0xcf9a00,-0x7feee7e4(%eax)
80106c7b:	9a cf 00 
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106c7e:	c7 80 20 18 11 80 ff 	movl   $0xffff,-0x7feee7e0(%eax)
80106c85:	ff 00 00 
80106c88:	c7 80 24 18 11 80 00 	movl   $0xcf9200,-0x7feee7dc(%eax)
80106c8f:	92 cf 00 
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106c92:	c7 80 28 18 11 80 ff 	movl   $0xffff,-0x7feee7d8(%eax)
80106c99:	ff 00 00 
80106c9c:	c7 80 2c 18 11 80 00 	movl   $0xcffa00,-0x7feee7d4(%eax)
80106ca3:	fa cf 00 
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106ca6:	c7 80 30 18 11 80 ff 	movl   $0xffff,-0x7feee7d0(%eax)
80106cad:	ff 00 00 
80106cb0:	c7 80 34 18 11 80 00 	movl   $0xcff200,-0x7feee7cc(%eax)
80106cb7:	f2 cf 00 
  lgdt(c->gdt, sizeof(c->gdt));
80106cba:	05 10 18 11 80       	add    $0x80111810,%eax
  pd[1] = (uint)p;
80106cbf:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80106cc3:	c1 e8 10             	shr    $0x10,%eax
80106cc6:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
80106cca:	8d 45 f2             	lea    -0xe(%ebp),%eax
80106ccd:	0f 01 10             	lgdtl  (%eax)
}
80106cd0:	c9                   	leave  
80106cd1:	c3                   	ret    
80106cd2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106cd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106ce0 <switchkvm>:
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106ce0:	a1 c4 44 11 80       	mov    0x801144c4,%eax
80106ce5:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106cea:	0f 22 d8             	mov    %eax,%cr3
}
80106ced:	c3                   	ret    
80106cee:	66 90                	xchg   %ax,%ax

80106cf0 <switchuvm>:
{
80106cf0:	55                   	push   %ebp
80106cf1:	89 e5                	mov    %esp,%ebp
80106cf3:	57                   	push   %edi
80106cf4:	56                   	push   %esi
80106cf5:	53                   	push   %ebx
80106cf6:	83 ec 1c             	sub    $0x1c,%esp
80106cf9:	8b 75 08             	mov    0x8(%ebp),%esi
  if(p == 0)
80106cfc:	85 f6                	test   %esi,%esi
80106cfe:	0f 84 cb 00 00 00    	je     80106dcf <switchuvm+0xdf>
  if(p->kstack == 0)
80106d04:	8b 46 08             	mov    0x8(%esi),%eax
80106d07:	85 c0                	test   %eax,%eax
80106d09:	0f 84 da 00 00 00    	je     80106de9 <switchuvm+0xf9>
  if(p->pgdir == 0)
80106d0f:	8b 46 04             	mov    0x4(%esi),%eax
80106d12:	85 c0                	test   %eax,%eax
80106d14:	0f 84 c2 00 00 00    	je     80106ddc <switchuvm+0xec>
  pushcli();
80106d1a:	e8 41 da ff ff       	call   80104760 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80106d1f:	e8 dc ce ff ff       	call   80103c00 <mycpu>
80106d24:	89 c3                	mov    %eax,%ebx
80106d26:	e8 d5 ce ff ff       	call   80103c00 <mycpu>
80106d2b:	89 c7                	mov    %eax,%edi
80106d2d:	e8 ce ce ff ff       	call   80103c00 <mycpu>
80106d32:	83 c7 08             	add    $0x8,%edi
80106d35:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106d38:	e8 c3 ce ff ff       	call   80103c00 <mycpu>
80106d3d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80106d40:	ba 67 00 00 00       	mov    $0x67,%edx
80106d45:	66 89 bb 9a 00 00 00 	mov    %di,0x9a(%ebx)
80106d4c:	83 c0 08             	add    $0x8,%eax
80106d4f:	66 89 93 98 00 00 00 	mov    %dx,0x98(%ebx)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80106d56:	bf ff ff ff ff       	mov    $0xffffffff,%edi
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80106d5b:	83 c1 08             	add    $0x8,%ecx
80106d5e:	c1 e8 18             	shr    $0x18,%eax
80106d61:	c1 e9 10             	shr    $0x10,%ecx
80106d64:	88 83 9f 00 00 00    	mov    %al,0x9f(%ebx)
80106d6a:	88 8b 9c 00 00 00    	mov    %cl,0x9c(%ebx)
80106d70:	b9 99 40 00 00       	mov    $0x4099,%ecx
80106d75:	66 89 8b 9d 00 00 00 	mov    %cx,0x9d(%ebx)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80106d7c:	bb 10 00 00 00       	mov    $0x10,%ebx
  mycpu()->gdt[SEG_TSS].s = 0;
80106d81:	e8 7a ce ff ff       	call   80103c00 <mycpu>
80106d86:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80106d8d:	e8 6e ce ff ff       	call   80103c00 <mycpu>
80106d92:	66 89 58 10          	mov    %bx,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
80106d96:	8b 5e 08             	mov    0x8(%esi),%ebx
80106d99:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106d9f:	e8 5c ce ff ff       	call   80103c00 <mycpu>
80106da4:	89 58 0c             	mov    %ebx,0xc(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80106da7:	e8 54 ce ff ff       	call   80103c00 <mycpu>
80106dac:	66 89 78 6e          	mov    %di,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
80106db0:	b8 28 00 00 00       	mov    $0x28,%eax
80106db5:	0f 00 d8             	ltr    %ax
  lcr3(V2P(p->pgdir));  // switch to process's address space
80106db8:	8b 46 04             	mov    0x4(%esi),%eax
80106dbb:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106dc0:	0f 22 d8             	mov    %eax,%cr3
}
80106dc3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106dc6:	5b                   	pop    %ebx
80106dc7:	5e                   	pop    %esi
80106dc8:	5f                   	pop    %edi
80106dc9:	5d                   	pop    %ebp
  popcli();
80106dca:	e9 e1 d9 ff ff       	jmp    801047b0 <popcli>
    panic("switchuvm: no process");
80106dcf:	83 ec 0c             	sub    $0xc,%esp
80106dd2:	68 ae 7d 10 80       	push   $0x80107dae
80106dd7:	e8 a4 95 ff ff       	call   80100380 <panic>
    panic("switchuvm: no pgdir");
80106ddc:	83 ec 0c             	sub    $0xc,%esp
80106ddf:	68 d9 7d 10 80       	push   $0x80107dd9
80106de4:	e8 97 95 ff ff       	call   80100380 <panic>
    panic("switchuvm: no kstack");
80106de9:	83 ec 0c             	sub    $0xc,%esp
80106dec:	68 c4 7d 10 80       	push   $0x80107dc4
80106df1:	e8 8a 95 ff ff       	call   80100380 <panic>
80106df6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106dfd:	8d 76 00             	lea    0x0(%esi),%esi

80106e00 <inituvm>:
{
80106e00:	55                   	push   %ebp
80106e01:	89 e5                	mov    %esp,%ebp
80106e03:	57                   	push   %edi
80106e04:	56                   	push   %esi
80106e05:	53                   	push   %ebx
80106e06:	83 ec 1c             	sub    $0x1c,%esp
80106e09:	8b 45 0c             	mov    0xc(%ebp),%eax
80106e0c:	8b 75 10             	mov    0x10(%ebp),%esi
80106e0f:	8b 7d 08             	mov    0x8(%ebp),%edi
80106e12:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(sz >= PGSIZE)
80106e15:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
80106e1b:	77 4b                	ja     80106e68 <inituvm+0x68>
  mem = kalloc();
80106e1d:	e8 6e bb ff ff       	call   80102990 <kalloc>
  memset(mem, 0, PGSIZE);
80106e22:	83 ec 04             	sub    $0x4,%esp
80106e25:	68 00 10 00 00       	push   $0x1000
  mem = kalloc();
80106e2a:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
80106e2c:	6a 00                	push   $0x0
80106e2e:	50                   	push   %eax
80106e2f:	e8 3c db ff ff       	call   80104970 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80106e34:	58                   	pop    %eax
80106e35:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106e3b:	5a                   	pop    %edx
80106e3c:	6a 06                	push   $0x6
80106e3e:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106e43:	31 d2                	xor    %edx,%edx
80106e45:	50                   	push   %eax
80106e46:	89 f8                	mov    %edi,%eax
80106e48:	e8 13 fd ff ff       	call   80106b60 <mappages>
  memmove(mem, init, sz);
80106e4d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106e50:	89 75 10             	mov    %esi,0x10(%ebp)
80106e53:	83 c4 10             	add    $0x10,%esp
80106e56:	89 5d 08             	mov    %ebx,0x8(%ebp)
80106e59:	89 45 0c             	mov    %eax,0xc(%ebp)
}
80106e5c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106e5f:	5b                   	pop    %ebx
80106e60:	5e                   	pop    %esi
80106e61:	5f                   	pop    %edi
80106e62:	5d                   	pop    %ebp
  memmove(mem, init, sz);
80106e63:	e9 a8 db ff ff       	jmp    80104a10 <memmove>
    panic("inituvm: more than a page");
80106e68:	83 ec 0c             	sub    $0xc,%esp
80106e6b:	68 ed 7d 10 80       	push   $0x80107ded
80106e70:	e8 0b 95 ff ff       	call   80100380 <panic>
80106e75:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106e7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106e80 <loaduvm>:
{
80106e80:	55                   	push   %ebp
80106e81:	89 e5                	mov    %esp,%ebp
80106e83:	57                   	push   %edi
80106e84:	56                   	push   %esi
80106e85:	53                   	push   %ebx
80106e86:	83 ec 1c             	sub    $0x1c,%esp
80106e89:	8b 45 0c             	mov    0xc(%ebp),%eax
80106e8c:	8b 75 18             	mov    0x18(%ebp),%esi
  if((uint) addr % PGSIZE != 0)
80106e8f:	a9 ff 0f 00 00       	test   $0xfff,%eax
80106e94:	0f 85 bb 00 00 00    	jne    80106f55 <loaduvm+0xd5>
  for(i = 0; i < sz; i += PGSIZE){
80106e9a:	01 f0                	add    %esi,%eax
80106e9c:	89 f3                	mov    %esi,%ebx
80106e9e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106ea1:	8b 45 14             	mov    0x14(%ebp),%eax
80106ea4:	01 f0                	add    %esi,%eax
80106ea6:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(i = 0; i < sz; i += PGSIZE){
80106ea9:	85 f6                	test   %esi,%esi
80106eab:	0f 84 87 00 00 00    	je     80106f38 <loaduvm+0xb8>
80106eb1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  pde = &pgdir[PDX(va)];
80106eb8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  if(*pde & PTE_P){
80106ebb:	8b 4d 08             	mov    0x8(%ebp),%ecx
80106ebe:	29 d8                	sub    %ebx,%eax
  pde = &pgdir[PDX(va)];
80106ec0:	89 c2                	mov    %eax,%edx
80106ec2:	c1 ea 16             	shr    $0x16,%edx
  if(*pde & PTE_P){
80106ec5:	8b 14 91             	mov    (%ecx,%edx,4),%edx
80106ec8:	f6 c2 01             	test   $0x1,%dl
80106ecb:	75 13                	jne    80106ee0 <loaduvm+0x60>
      panic("loaduvm: address should exist");
80106ecd:	83 ec 0c             	sub    $0xc,%esp
80106ed0:	68 07 7e 10 80       	push   $0x80107e07
80106ed5:	e8 a6 94 ff ff       	call   80100380 <panic>
80106eda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return &pgtab[PTX(va)];
80106ee0:	c1 e8 0a             	shr    $0xa,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106ee3:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  return &pgtab[PTX(va)];
80106ee9:	25 fc 0f 00 00       	and    $0xffc,%eax
80106eee:	8d 84 02 00 00 00 80 	lea    -0x80000000(%edx,%eax,1),%eax
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80106ef5:	85 c0                	test   %eax,%eax
80106ef7:	74 d4                	je     80106ecd <loaduvm+0x4d>
    pa = PTE_ADDR(*pte);
80106ef9:	8b 00                	mov    (%eax),%eax
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106efb:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    if(sz - i < PGSIZE)
80106efe:	bf 00 10 00 00       	mov    $0x1000,%edi
    pa = PTE_ADDR(*pte);
80106f03:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
80106f08:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
80106f0e:	0f 46 fb             	cmovbe %ebx,%edi
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106f11:	29 d9                	sub    %ebx,%ecx
80106f13:	05 00 00 00 80       	add    $0x80000000,%eax
80106f18:	57                   	push   %edi
80106f19:	51                   	push   %ecx
80106f1a:	50                   	push   %eax
80106f1b:	ff 75 10             	push   0x10(%ebp)
80106f1e:	e8 7d ae ff ff       	call   80101da0 <readi>
80106f23:	83 c4 10             	add    $0x10,%esp
80106f26:	39 f8                	cmp    %edi,%eax
80106f28:	75 1e                	jne    80106f48 <loaduvm+0xc8>
  for(i = 0; i < sz; i += PGSIZE){
80106f2a:	81 eb 00 10 00 00    	sub    $0x1000,%ebx
80106f30:	89 f0                	mov    %esi,%eax
80106f32:	29 d8                	sub    %ebx,%eax
80106f34:	39 c6                	cmp    %eax,%esi
80106f36:	77 80                	ja     80106eb8 <loaduvm+0x38>
}
80106f38:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80106f3b:	31 c0                	xor    %eax,%eax
}
80106f3d:	5b                   	pop    %ebx
80106f3e:	5e                   	pop    %esi
80106f3f:	5f                   	pop    %edi
80106f40:	5d                   	pop    %ebp
80106f41:	c3                   	ret    
80106f42:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106f48:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80106f4b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106f50:	5b                   	pop    %ebx
80106f51:	5e                   	pop    %esi
80106f52:	5f                   	pop    %edi
80106f53:	5d                   	pop    %ebp
80106f54:	c3                   	ret    
    panic("loaduvm: addr must be page aligned");
80106f55:	83 ec 0c             	sub    $0xc,%esp
80106f58:	68 a8 7e 10 80       	push   $0x80107ea8
80106f5d:	e8 1e 94 ff ff       	call   80100380 <panic>
80106f62:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106f69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106f70 <allocuvm>:
{
80106f70:	55                   	push   %ebp
80106f71:	89 e5                	mov    %esp,%ebp
80106f73:	57                   	push   %edi
80106f74:	56                   	push   %esi
80106f75:	53                   	push   %ebx
80106f76:	83 ec 1c             	sub    $0x1c,%esp
  if(newsz >= KERNBASE)
80106f79:	8b 45 10             	mov    0x10(%ebp),%eax
{
80106f7c:	8b 7d 08             	mov    0x8(%ebp),%edi
  if(newsz >= KERNBASE)
80106f7f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106f82:	85 c0                	test   %eax,%eax
80106f84:	0f 88 b6 00 00 00    	js     80107040 <allocuvm+0xd0>
  if(newsz < oldsz)
80106f8a:	3b 45 0c             	cmp    0xc(%ebp),%eax
    return oldsz;
80106f8d:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(newsz < oldsz)
80106f90:	0f 82 9a 00 00 00    	jb     80107030 <allocuvm+0xc0>
  a = PGROUNDUP(oldsz);
80106f96:	8d b0 ff 0f 00 00    	lea    0xfff(%eax),%esi
80106f9c:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
  for(; a < newsz; a += PGSIZE){
80106fa2:	39 75 10             	cmp    %esi,0x10(%ebp)
80106fa5:	77 44                	ja     80106feb <allocuvm+0x7b>
80106fa7:	e9 87 00 00 00       	jmp    80107033 <allocuvm+0xc3>
80106fac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    memset(mem, 0, PGSIZE);
80106fb0:	83 ec 04             	sub    $0x4,%esp
80106fb3:	68 00 10 00 00       	push   $0x1000
80106fb8:	6a 00                	push   $0x0
80106fba:	50                   	push   %eax
80106fbb:	e8 b0 d9 ff ff       	call   80104970 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80106fc0:	58                   	pop    %eax
80106fc1:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106fc7:	5a                   	pop    %edx
80106fc8:	6a 06                	push   $0x6
80106fca:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106fcf:	89 f2                	mov    %esi,%edx
80106fd1:	50                   	push   %eax
80106fd2:	89 f8                	mov    %edi,%eax
80106fd4:	e8 87 fb ff ff       	call   80106b60 <mappages>
80106fd9:	83 c4 10             	add    $0x10,%esp
80106fdc:	85 c0                	test   %eax,%eax
80106fde:	78 78                	js     80107058 <allocuvm+0xe8>
  for(; a < newsz; a += PGSIZE){
80106fe0:	81 c6 00 10 00 00    	add    $0x1000,%esi
80106fe6:	39 75 10             	cmp    %esi,0x10(%ebp)
80106fe9:	76 48                	jbe    80107033 <allocuvm+0xc3>
    mem = kalloc();
80106feb:	e8 a0 b9 ff ff       	call   80102990 <kalloc>
80106ff0:	89 c3                	mov    %eax,%ebx
    if(mem == 0){
80106ff2:	85 c0                	test   %eax,%eax
80106ff4:	75 ba                	jne    80106fb0 <allocuvm+0x40>
      cprintf("allocuvm out of memory\n");
80106ff6:	83 ec 0c             	sub    $0xc,%esp
80106ff9:	68 25 7e 10 80       	push   $0x80107e25
80106ffe:	e8 2d 97 ff ff       	call   80100730 <cprintf>
  if(newsz >= oldsz)
80107003:	8b 45 0c             	mov    0xc(%ebp),%eax
80107006:	83 c4 10             	add    $0x10,%esp
80107009:	39 45 10             	cmp    %eax,0x10(%ebp)
8010700c:	74 32                	je     80107040 <allocuvm+0xd0>
8010700e:	8b 55 10             	mov    0x10(%ebp),%edx
80107011:	89 c1                	mov    %eax,%ecx
80107013:	89 f8                	mov    %edi,%eax
80107015:	e8 96 fa ff ff       	call   80106ab0 <deallocuvm.part.0>
      return 0;
8010701a:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
}
80107021:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107024:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107027:	5b                   	pop    %ebx
80107028:	5e                   	pop    %esi
80107029:	5f                   	pop    %edi
8010702a:	5d                   	pop    %ebp
8010702b:	c3                   	ret    
8010702c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return oldsz;
80107030:	89 45 e4             	mov    %eax,-0x1c(%ebp)
}
80107033:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107036:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107039:	5b                   	pop    %ebx
8010703a:	5e                   	pop    %esi
8010703b:	5f                   	pop    %edi
8010703c:	5d                   	pop    %ebp
8010703d:	c3                   	ret    
8010703e:	66 90                	xchg   %ax,%ax
    return 0;
80107040:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
}
80107047:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010704a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010704d:	5b                   	pop    %ebx
8010704e:	5e                   	pop    %esi
8010704f:	5f                   	pop    %edi
80107050:	5d                   	pop    %ebp
80107051:	c3                   	ret    
80107052:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      cprintf("allocuvm out of memory (2)\n");
80107058:	83 ec 0c             	sub    $0xc,%esp
8010705b:	68 3d 7e 10 80       	push   $0x80107e3d
80107060:	e8 cb 96 ff ff       	call   80100730 <cprintf>
  if(newsz >= oldsz)
80107065:	8b 45 0c             	mov    0xc(%ebp),%eax
80107068:	83 c4 10             	add    $0x10,%esp
8010706b:	39 45 10             	cmp    %eax,0x10(%ebp)
8010706e:	74 0c                	je     8010707c <allocuvm+0x10c>
80107070:	8b 55 10             	mov    0x10(%ebp),%edx
80107073:	89 c1                	mov    %eax,%ecx
80107075:	89 f8                	mov    %edi,%eax
80107077:	e8 34 fa ff ff       	call   80106ab0 <deallocuvm.part.0>
      kfree(mem);
8010707c:	83 ec 0c             	sub    $0xc,%esp
8010707f:	53                   	push   %ebx
80107080:	e8 4b b7 ff ff       	call   801027d0 <kfree>
      return 0;
80107085:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
8010708c:	83 c4 10             	add    $0x10,%esp
}
8010708f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107092:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107095:	5b                   	pop    %ebx
80107096:	5e                   	pop    %esi
80107097:	5f                   	pop    %edi
80107098:	5d                   	pop    %ebp
80107099:	c3                   	ret    
8010709a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801070a0 <deallocuvm>:
{
801070a0:	55                   	push   %ebp
801070a1:	89 e5                	mov    %esp,%ebp
801070a3:	8b 55 0c             	mov    0xc(%ebp),%edx
801070a6:	8b 4d 10             	mov    0x10(%ebp),%ecx
801070a9:	8b 45 08             	mov    0x8(%ebp),%eax
  if(newsz >= oldsz)
801070ac:	39 d1                	cmp    %edx,%ecx
801070ae:	73 10                	jae    801070c0 <deallocuvm+0x20>
}
801070b0:	5d                   	pop    %ebp
801070b1:	e9 fa f9 ff ff       	jmp    80106ab0 <deallocuvm.part.0>
801070b6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801070bd:	8d 76 00             	lea    0x0(%esi),%esi
801070c0:	89 d0                	mov    %edx,%eax
801070c2:	5d                   	pop    %ebp
801070c3:	c3                   	ret    
801070c4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801070cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801070cf:	90                   	nop

801070d0 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
801070d0:	55                   	push   %ebp
801070d1:	89 e5                	mov    %esp,%ebp
801070d3:	57                   	push   %edi
801070d4:	56                   	push   %esi
801070d5:	53                   	push   %ebx
801070d6:	83 ec 0c             	sub    $0xc,%esp
801070d9:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
801070dc:	85 f6                	test   %esi,%esi
801070de:	74 59                	je     80107139 <freevm+0x69>
  if(newsz >= oldsz)
801070e0:	31 c9                	xor    %ecx,%ecx
801070e2:	ba 00 00 00 80       	mov    $0x80000000,%edx
801070e7:	89 f0                	mov    %esi,%eax
801070e9:	89 f3                	mov    %esi,%ebx
801070eb:	e8 c0 f9 ff ff       	call   80106ab0 <deallocuvm.part.0>
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
801070f0:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
801070f6:	eb 0f                	jmp    80107107 <freevm+0x37>
801070f8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801070ff:	90                   	nop
80107100:	83 c3 04             	add    $0x4,%ebx
80107103:	39 df                	cmp    %ebx,%edi
80107105:	74 23                	je     8010712a <freevm+0x5a>
    if(pgdir[i] & PTE_P){
80107107:	8b 03                	mov    (%ebx),%eax
80107109:	a8 01                	test   $0x1,%al
8010710b:	74 f3                	je     80107100 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
8010710d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
      kfree(v);
80107112:	83 ec 0c             	sub    $0xc,%esp
  for(i = 0; i < NPDENTRIES; i++){
80107115:	83 c3 04             	add    $0x4,%ebx
      char * v = P2V(PTE_ADDR(pgdir[i]));
80107118:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
8010711d:	50                   	push   %eax
8010711e:	e8 ad b6 ff ff       	call   801027d0 <kfree>
80107123:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
80107126:	39 df                	cmp    %ebx,%edi
80107128:	75 dd                	jne    80107107 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
8010712a:	89 75 08             	mov    %esi,0x8(%ebp)
}
8010712d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107130:	5b                   	pop    %ebx
80107131:	5e                   	pop    %esi
80107132:	5f                   	pop    %edi
80107133:	5d                   	pop    %ebp
  kfree((char*)pgdir);
80107134:	e9 97 b6 ff ff       	jmp    801027d0 <kfree>
    panic("freevm: no pgdir");
80107139:	83 ec 0c             	sub    $0xc,%esp
8010713c:	68 59 7e 10 80       	push   $0x80107e59
80107141:	e8 3a 92 ff ff       	call   80100380 <panic>
80107146:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010714d:	8d 76 00             	lea    0x0(%esi),%esi

80107150 <setupkvm>:
{
80107150:	55                   	push   %ebp
80107151:	89 e5                	mov    %esp,%ebp
80107153:	56                   	push   %esi
80107154:	53                   	push   %ebx
  if((pgdir = (pde_t*)kalloc()) == 0)
80107155:	e8 36 b8 ff ff       	call   80102990 <kalloc>
8010715a:	89 c6                	mov    %eax,%esi
8010715c:	85 c0                	test   %eax,%eax
8010715e:	74 42                	je     801071a2 <setupkvm+0x52>
  memset(pgdir, 0, PGSIZE);
80107160:	83 ec 04             	sub    $0x4,%esp
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107163:	bb 20 a4 10 80       	mov    $0x8010a420,%ebx
  memset(pgdir, 0, PGSIZE);
80107168:	68 00 10 00 00       	push   $0x1000
8010716d:	6a 00                	push   $0x0
8010716f:	50                   	push   %eax
80107170:	e8 fb d7 ff ff       	call   80104970 <memset>
80107175:	83 c4 10             	add    $0x10,%esp
                (uint)k->phys_start, k->perm) < 0) {
80107178:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
8010717b:	83 ec 08             	sub    $0x8,%esp
8010717e:	8b 4b 08             	mov    0x8(%ebx),%ecx
80107181:	ff 73 0c             	push   0xc(%ebx)
80107184:	8b 13                	mov    (%ebx),%edx
80107186:	50                   	push   %eax
80107187:	29 c1                	sub    %eax,%ecx
80107189:	89 f0                	mov    %esi,%eax
8010718b:	e8 d0 f9 ff ff       	call   80106b60 <mappages>
80107190:	83 c4 10             	add    $0x10,%esp
80107193:	85 c0                	test   %eax,%eax
80107195:	78 19                	js     801071b0 <setupkvm+0x60>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107197:	83 c3 10             	add    $0x10,%ebx
8010719a:	81 fb 60 a4 10 80    	cmp    $0x8010a460,%ebx
801071a0:	75 d6                	jne    80107178 <setupkvm+0x28>
}
801071a2:	8d 65 f8             	lea    -0x8(%ebp),%esp
801071a5:	89 f0                	mov    %esi,%eax
801071a7:	5b                   	pop    %ebx
801071a8:	5e                   	pop    %esi
801071a9:	5d                   	pop    %ebp
801071aa:	c3                   	ret    
801071ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801071af:	90                   	nop
      freevm(pgdir);
801071b0:	83 ec 0c             	sub    $0xc,%esp
801071b3:	56                   	push   %esi
      return 0;
801071b4:	31 f6                	xor    %esi,%esi
      freevm(pgdir);
801071b6:	e8 15 ff ff ff       	call   801070d0 <freevm>
      return 0;
801071bb:	83 c4 10             	add    $0x10,%esp
}
801071be:	8d 65 f8             	lea    -0x8(%ebp),%esp
801071c1:	89 f0                	mov    %esi,%eax
801071c3:	5b                   	pop    %ebx
801071c4:	5e                   	pop    %esi
801071c5:	5d                   	pop    %ebp
801071c6:	c3                   	ret    
801071c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801071ce:	66 90                	xchg   %ax,%ax

801071d0 <kvmalloc>:
{
801071d0:	55                   	push   %ebp
801071d1:	89 e5                	mov    %esp,%ebp
801071d3:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
801071d6:	e8 75 ff ff ff       	call   80107150 <setupkvm>
801071db:	a3 c4 44 11 80       	mov    %eax,0x801144c4
  lcr3(V2P(kpgdir));   // switch to the kernel page table
801071e0:	05 00 00 00 80       	add    $0x80000000,%eax
801071e5:	0f 22 d8             	mov    %eax,%cr3
}
801071e8:	c9                   	leave  
801071e9:	c3                   	ret    
801071ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801071f0 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
801071f0:	55                   	push   %ebp
801071f1:	89 e5                	mov    %esp,%ebp
801071f3:	83 ec 08             	sub    $0x8,%esp
801071f6:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(*pde & PTE_P){
801071f9:	8b 55 08             	mov    0x8(%ebp),%edx
  pde = &pgdir[PDX(va)];
801071fc:	89 c1                	mov    %eax,%ecx
801071fe:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
80107201:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
80107204:	f6 c2 01             	test   $0x1,%dl
80107207:	75 17                	jne    80107220 <clearpteu+0x30>
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
  if(pte == 0)
    panic("clearpteu");
80107209:	83 ec 0c             	sub    $0xc,%esp
8010720c:	68 6a 7e 10 80       	push   $0x80107e6a
80107211:	e8 6a 91 ff ff       	call   80100380 <panic>
80107216:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010721d:	8d 76 00             	lea    0x0(%esi),%esi
  return &pgtab[PTX(va)];
80107220:	c1 e8 0a             	shr    $0xa,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107223:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  return &pgtab[PTX(va)];
80107229:	25 fc 0f 00 00       	and    $0xffc,%eax
8010722e:	8d 84 02 00 00 00 80 	lea    -0x80000000(%edx,%eax,1),%eax
  if(pte == 0)
80107235:	85 c0                	test   %eax,%eax
80107237:	74 d0                	je     80107209 <clearpteu+0x19>
  *pte &= ~PTE_U;
80107239:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
8010723c:	c9                   	leave  
8010723d:	c3                   	ret    
8010723e:	66 90                	xchg   %ax,%ax

80107240 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80107240:	55                   	push   %ebp
80107241:	89 e5                	mov    %esp,%ebp
80107243:	57                   	push   %edi
80107244:	56                   	push   %esi
80107245:	53                   	push   %ebx
80107246:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80107249:	e8 02 ff ff ff       	call   80107150 <setupkvm>
8010724e:	89 45 e0             	mov    %eax,-0x20(%ebp)
80107251:	85 c0                	test   %eax,%eax
80107253:	0f 84 bd 00 00 00    	je     80107316 <copyuvm+0xd6>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80107259:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010725c:	85 c9                	test   %ecx,%ecx
8010725e:	0f 84 b2 00 00 00    	je     80107316 <copyuvm+0xd6>
80107264:	31 f6                	xor    %esi,%esi
80107266:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010726d:	8d 76 00             	lea    0x0(%esi),%esi
  if(*pde & PTE_P){
80107270:	8b 4d 08             	mov    0x8(%ebp),%ecx
  pde = &pgdir[PDX(va)];
80107273:	89 f0                	mov    %esi,%eax
80107275:	c1 e8 16             	shr    $0x16,%eax
  if(*pde & PTE_P){
80107278:	8b 04 81             	mov    (%ecx,%eax,4),%eax
8010727b:	a8 01                	test   $0x1,%al
8010727d:	75 11                	jne    80107290 <copyuvm+0x50>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
8010727f:	83 ec 0c             	sub    $0xc,%esp
80107282:	68 74 7e 10 80       	push   $0x80107e74
80107287:	e8 f4 90 ff ff       	call   80100380 <panic>
8010728c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  return &pgtab[PTX(va)];
80107290:	89 f2                	mov    %esi,%edx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107292:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
80107297:	c1 ea 0a             	shr    $0xa,%edx
8010729a:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
801072a0:	8d 84 10 00 00 00 80 	lea    -0x80000000(%eax,%edx,1),%eax
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
801072a7:	85 c0                	test   %eax,%eax
801072a9:	74 d4                	je     8010727f <copyuvm+0x3f>
    if(!(*pte & PTE_P))
801072ab:	8b 00                	mov    (%eax),%eax
801072ad:	a8 01                	test   $0x1,%al
801072af:	0f 84 9f 00 00 00    	je     80107354 <copyuvm+0x114>
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
801072b5:	89 c7                	mov    %eax,%edi
    flags = PTE_FLAGS(*pte);
801072b7:	25 ff 0f 00 00       	and    $0xfff,%eax
801072bc:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    pa = PTE_ADDR(*pte);
801072bf:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
    if((mem = kalloc()) == 0)
801072c5:	e8 c6 b6 ff ff       	call   80102990 <kalloc>
801072ca:	89 c3                	mov    %eax,%ebx
801072cc:	85 c0                	test   %eax,%eax
801072ce:	74 64                	je     80107334 <copyuvm+0xf4>
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
801072d0:	83 ec 04             	sub    $0x4,%esp
801072d3:	81 c7 00 00 00 80    	add    $0x80000000,%edi
801072d9:	68 00 10 00 00       	push   $0x1000
801072de:	57                   	push   %edi
801072df:	50                   	push   %eax
801072e0:	e8 2b d7 ff ff       	call   80104a10 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
801072e5:	58                   	pop    %eax
801072e6:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801072ec:	5a                   	pop    %edx
801072ed:	ff 75 e4             	push   -0x1c(%ebp)
801072f0:	b9 00 10 00 00       	mov    $0x1000,%ecx
801072f5:	89 f2                	mov    %esi,%edx
801072f7:	50                   	push   %eax
801072f8:	8b 45 e0             	mov    -0x20(%ebp),%eax
801072fb:	e8 60 f8 ff ff       	call   80106b60 <mappages>
80107300:	83 c4 10             	add    $0x10,%esp
80107303:	85 c0                	test   %eax,%eax
80107305:	78 21                	js     80107328 <copyuvm+0xe8>
  for(i = 0; i < sz; i += PGSIZE){
80107307:	81 c6 00 10 00 00    	add    $0x1000,%esi
8010730d:	39 75 0c             	cmp    %esi,0xc(%ebp)
80107310:	0f 87 5a ff ff ff    	ja     80107270 <copyuvm+0x30>
  return d;

bad:
  freevm(d);
  return 0;
}
80107316:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107319:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010731c:	5b                   	pop    %ebx
8010731d:	5e                   	pop    %esi
8010731e:	5f                   	pop    %edi
8010731f:	5d                   	pop    %ebp
80107320:	c3                   	ret    
80107321:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      kfree(mem);
80107328:	83 ec 0c             	sub    $0xc,%esp
8010732b:	53                   	push   %ebx
8010732c:	e8 9f b4 ff ff       	call   801027d0 <kfree>
      goto bad;
80107331:	83 c4 10             	add    $0x10,%esp
  freevm(d);
80107334:	83 ec 0c             	sub    $0xc,%esp
80107337:	ff 75 e0             	push   -0x20(%ebp)
8010733a:	e8 91 fd ff ff       	call   801070d0 <freevm>
  return 0;
8010733f:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
80107346:	83 c4 10             	add    $0x10,%esp
}
80107349:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010734c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010734f:	5b                   	pop    %ebx
80107350:	5e                   	pop    %esi
80107351:	5f                   	pop    %edi
80107352:	5d                   	pop    %ebp
80107353:	c3                   	ret    
      panic("copyuvm: page not present");
80107354:	83 ec 0c             	sub    $0xc,%esp
80107357:	68 8e 7e 10 80       	push   $0x80107e8e
8010735c:	e8 1f 90 ff ff       	call   80100380 <panic>
80107361:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107368:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010736f:	90                   	nop

80107370 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80107370:	55                   	push   %ebp
80107371:	89 e5                	mov    %esp,%ebp
80107373:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(*pde & PTE_P){
80107376:	8b 55 08             	mov    0x8(%ebp),%edx
  pde = &pgdir[PDX(va)];
80107379:	89 c1                	mov    %eax,%ecx
8010737b:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
8010737e:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
80107381:	f6 c2 01             	test   $0x1,%dl
80107384:	0f 84 00 01 00 00    	je     8010748a <uva2ka.cold>
  return &pgtab[PTX(va)];
8010738a:	c1 e8 0c             	shr    $0xc,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
8010738d:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  if((*pte & PTE_P) == 0)
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
}
80107393:	5d                   	pop    %ebp
  return &pgtab[PTX(va)];
80107394:	25 ff 03 00 00       	and    $0x3ff,%eax
  if((*pte & PTE_P) == 0)
80107399:	8b 84 82 00 00 00 80 	mov    -0x80000000(%edx,%eax,4),%eax
  if((*pte & PTE_U) == 0)
801073a0:	89 c2                	mov    %eax,%edx
  return (char*)P2V(PTE_ADDR(*pte));
801073a2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((*pte & PTE_U) == 0)
801073a7:	83 e2 05             	and    $0x5,%edx
  return (char*)P2V(PTE_ADDR(*pte));
801073aa:	05 00 00 00 80       	add    $0x80000000,%eax
801073af:	83 fa 05             	cmp    $0x5,%edx
801073b2:	ba 00 00 00 00       	mov    $0x0,%edx
801073b7:	0f 45 c2             	cmovne %edx,%eax
}
801073ba:	c3                   	ret    
801073bb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801073bf:	90                   	nop

801073c0 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
801073c0:	55                   	push   %ebp
801073c1:	89 e5                	mov    %esp,%ebp
801073c3:	57                   	push   %edi
801073c4:	56                   	push   %esi
801073c5:	53                   	push   %ebx
801073c6:	83 ec 0c             	sub    $0xc,%esp
801073c9:	8b 75 14             	mov    0x14(%ebp),%esi
801073cc:	8b 45 0c             	mov    0xc(%ebp),%eax
801073cf:	8b 55 10             	mov    0x10(%ebp),%edx
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
801073d2:	85 f6                	test   %esi,%esi
801073d4:	75 51                	jne    80107427 <copyout+0x67>
801073d6:	e9 a5 00 00 00       	jmp    80107480 <copyout+0xc0>
801073db:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801073df:	90                   	nop
  return (char*)P2V(PTE_ADDR(*pte));
801073e0:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
801073e6:	8d 8b 00 00 00 80    	lea    -0x80000000(%ebx),%ecx
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
801073ec:	81 fb 00 00 00 80    	cmp    $0x80000000,%ebx
801073f2:	74 75                	je     80107469 <copyout+0xa9>
      return -1;
    n = PGSIZE - (va - va0);
801073f4:	89 fb                	mov    %edi,%ebx
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
801073f6:	89 55 10             	mov    %edx,0x10(%ebp)
    n = PGSIZE - (va - va0);
801073f9:	29 c3                	sub    %eax,%ebx
801073fb:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80107401:	39 f3                	cmp    %esi,%ebx
80107403:	0f 47 de             	cmova  %esi,%ebx
    memmove(pa0 + (va - va0), buf, n);
80107406:	29 f8                	sub    %edi,%eax
80107408:	83 ec 04             	sub    $0x4,%esp
8010740b:	01 c1                	add    %eax,%ecx
8010740d:	53                   	push   %ebx
8010740e:	52                   	push   %edx
8010740f:	51                   	push   %ecx
80107410:	e8 fb d5 ff ff       	call   80104a10 <memmove>
    len -= n;
    buf += n;
80107415:	8b 55 10             	mov    0x10(%ebp),%edx
    va = va0 + PGSIZE;
80107418:	8d 87 00 10 00 00    	lea    0x1000(%edi),%eax
  while(len > 0){
8010741e:	83 c4 10             	add    $0x10,%esp
    buf += n;
80107421:	01 da                	add    %ebx,%edx
  while(len > 0){
80107423:	29 de                	sub    %ebx,%esi
80107425:	74 59                	je     80107480 <copyout+0xc0>
  if(*pde & PTE_P){
80107427:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pde = &pgdir[PDX(va)];
8010742a:	89 c1                	mov    %eax,%ecx
    va0 = (uint)PGROUNDDOWN(va);
8010742c:	89 c7                	mov    %eax,%edi
  pde = &pgdir[PDX(va)];
8010742e:	c1 e9 16             	shr    $0x16,%ecx
    va0 = (uint)PGROUNDDOWN(va);
80107431:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
  if(*pde & PTE_P){
80107437:	8b 0c 8b             	mov    (%ebx,%ecx,4),%ecx
8010743a:	f6 c1 01             	test   $0x1,%cl
8010743d:	0f 84 4e 00 00 00    	je     80107491 <copyout.cold>
  return &pgtab[PTX(va)];
80107443:	89 fb                	mov    %edi,%ebx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107445:	81 e1 00 f0 ff ff    	and    $0xfffff000,%ecx
  return &pgtab[PTX(va)];
8010744b:	c1 eb 0c             	shr    $0xc,%ebx
8010744e:	81 e3 ff 03 00 00    	and    $0x3ff,%ebx
  if((*pte & PTE_P) == 0)
80107454:	8b 9c 99 00 00 00 80 	mov    -0x80000000(%ecx,%ebx,4),%ebx
  if((*pte & PTE_U) == 0)
8010745b:	89 d9                	mov    %ebx,%ecx
8010745d:	83 e1 05             	and    $0x5,%ecx
80107460:	83 f9 05             	cmp    $0x5,%ecx
80107463:	0f 84 77 ff ff ff    	je     801073e0 <copyout+0x20>
  }
  return 0;
}
80107469:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
8010746c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107471:	5b                   	pop    %ebx
80107472:	5e                   	pop    %esi
80107473:	5f                   	pop    %edi
80107474:	5d                   	pop    %ebp
80107475:	c3                   	ret    
80107476:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010747d:	8d 76 00             	lea    0x0(%esi),%esi
80107480:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80107483:	31 c0                	xor    %eax,%eax
}
80107485:	5b                   	pop    %ebx
80107486:	5e                   	pop    %esi
80107487:	5f                   	pop    %edi
80107488:	5d                   	pop    %ebp
80107489:	c3                   	ret    

8010748a <uva2ka.cold>:
  if((*pte & PTE_P) == 0)
8010748a:	a1 00 00 00 00       	mov    0x0,%eax
8010748f:	0f 0b                	ud2    

80107491 <copyout.cold>:
80107491:	a1 00 00 00 00       	mov    0x0,%eax
80107496:	0f 0b                	ud2    
