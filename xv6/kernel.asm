
kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4                   	.byte 0xe4

8010000c <entry>:
8010000c:	0f 20 e0             	mov    %cr4,%eax
8010000f:	83 c8 10             	or     $0x10,%eax
80100012:	0f 22 e0             	mov    %eax,%cr4
80100015:	b8 00 a0 10 00       	mov    $0x10a000,%eax
8010001a:	0f 22 d8             	mov    %eax,%cr3
8010001d:	0f 20 c0             	mov    %cr0,%eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
80100025:	0f 22 c0             	mov    %eax,%cr0
80100028:	bc 10 71 11 80       	mov    $0x80117110,%esp
8010002d:	b8 30 38 10 80       	mov    $0x80103830,%eax
80100032:	ff e0                	jmp    *%eax
80100034:	66 90                	xchg   %ax,%ax
80100036:	66 90                	xchg   %ax,%ax
80100038:	66 90                	xchg   %ax,%ax
8010003a:	66 90                	xchg   %ax,%ax
8010003c:	66 90                	xchg   %ax,%ax
8010003e:	66 90                	xchg   %ax,%ax

80100040 <binit>:
80100040:	55                   	push   %ebp
80100041:	89 e5                	mov    %esp,%ebp
80100043:	53                   	push   %ebx
80100044:	bb 54 b5 10 80       	mov    $0x8010b554,%ebx
80100049:	83 ec 0c             	sub    $0xc,%esp
8010004c:	68 20 7c 10 80       	push   $0x80107c20
80100051:	68 20 b5 10 80       	push   $0x8010b520
80100056:	e8 45 4b 00 00       	call   80104ba0 <initlock>
8010005b:	83 c4 10             	add    $0x10,%esp
8010005e:	b8 1c fc 10 80       	mov    $0x8010fc1c,%eax
80100063:	c7 05 6c fc 10 80 1c 	movl   $0x8010fc1c,0x8010fc6c
8010006a:	fc 10 80 
8010006d:	c7 05 70 fc 10 80 1c 	movl   $0x8010fc1c,0x8010fc70
80100074:	fc 10 80 
80100077:	eb 09                	jmp    80100082 <binit+0x42>
80100079:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100080:	89 d3                	mov    %edx,%ebx
80100082:	89 43 54             	mov    %eax,0x54(%ebx)
80100085:	83 ec 08             	sub    $0x8,%esp
80100088:	8d 43 0c             	lea    0xc(%ebx),%eax
8010008b:	c7 43 50 1c fc 10 80 	movl   $0x8010fc1c,0x50(%ebx)
80100092:	68 27 7c 10 80       	push   $0x80107c27
80100097:	50                   	push   %eax
80100098:	e8 d3 49 00 00       	call   80104a70 <initsleeplock>
8010009d:	a1 70 fc 10 80       	mov    0x8010fc70,%eax
801000a2:	8d 93 5c 02 00 00    	lea    0x25c(%ebx),%edx
801000a8:	83 c4 10             	add    $0x10,%esp
801000ab:	89 58 50             	mov    %ebx,0x50(%eax)
801000ae:	89 d8                	mov    %ebx,%eax
801000b0:	89 1d 70 fc 10 80    	mov    %ebx,0x8010fc70
801000b6:	81 fb c0 f9 10 80    	cmp    $0x8010f9c0,%ebx
801000bc:	75 c2                	jne    80100080 <binit+0x40>
801000be:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801000c1:	c9                   	leave  
801000c2:	c3                   	ret    
801000c3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801000ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801000d0 <bread>:
801000d0:	55                   	push   %ebp
801000d1:	89 e5                	mov    %esp,%ebp
801000d3:	57                   	push   %edi
801000d4:	56                   	push   %esi
801000d5:	53                   	push   %ebx
801000d6:	83 ec 18             	sub    $0x18,%esp
801000d9:	8b 75 08             	mov    0x8(%ebp),%esi
801000dc:	8b 7d 0c             	mov    0xc(%ebp),%edi
801000df:	68 20 b5 10 80       	push   $0x8010b520
801000e4:	e8 87 4c 00 00       	call   80104d70 <acquire>
801000e9:	8b 1d 70 fc 10 80    	mov    0x8010fc70,%ebx
801000ef:	83 c4 10             	add    $0x10,%esp
801000f2:	81 fb 1c fc 10 80    	cmp    $0x8010fc1c,%ebx
801000f8:	75 11                	jne    8010010b <bread+0x3b>
801000fa:	eb 24                	jmp    80100120 <bread+0x50>
801000fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100100:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100103:	81 fb 1c fc 10 80    	cmp    $0x8010fc1c,%ebx
80100109:	74 15                	je     80100120 <bread+0x50>
8010010b:	3b 73 04             	cmp    0x4(%ebx),%esi
8010010e:	75 f0                	jne    80100100 <bread+0x30>
80100110:	3b 7b 08             	cmp    0x8(%ebx),%edi
80100113:	75 eb                	jne    80100100 <bread+0x30>
80100115:	83 43 4c 01          	addl   $0x1,0x4c(%ebx)
80100119:	eb 3f                	jmp    8010015a <bread+0x8a>
8010011b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010011f:	90                   	nop
80100120:	8b 1d 6c fc 10 80    	mov    0x8010fc6c,%ebx
80100126:	81 fb 1c fc 10 80    	cmp    $0x8010fc1c,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x6b>
8010012e:	eb 6e                	jmp    8010019e <bread+0xce>
80100130:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100133:	81 fb 1c fc 10 80    	cmp    $0x8010fc1c,%ebx
80100139:	74 63                	je     8010019e <bread+0xce>
8010013b:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010013e:	85 c0                	test   %eax,%eax
80100140:	75 ee                	jne    80100130 <bread+0x60>
80100142:	f6 03 04             	testb  $0x4,(%ebx)
80100145:	75 e9                	jne    80100130 <bread+0x60>
80100147:	89 73 04             	mov    %esi,0x4(%ebx)
8010014a:	89 7b 08             	mov    %edi,0x8(%ebx)
8010014d:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80100153:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
8010015a:	83 ec 0c             	sub    $0xc,%esp
8010015d:	68 20 b5 10 80       	push   $0x8010b520
80100162:	e8 a9 4b 00 00       	call   80104d10 <release>
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 3e 49 00 00       	call   80104ab0 <acquiresleep>
80100172:	83 c4 10             	add    $0x10,%esp
80100175:	f6 03 02             	testb  $0x2,(%ebx)
80100178:	74 0e                	je     80100188 <bread+0xb8>
8010017a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010017d:	89 d8                	mov    %ebx,%eax
8010017f:	5b                   	pop    %ebx
80100180:	5e                   	pop    %esi
80100181:	5f                   	pop    %edi
80100182:	5d                   	pop    %ebp
80100183:	c3                   	ret    
80100184:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100188:	83 ec 0c             	sub    $0xc,%esp
8010018b:	53                   	push   %ebx
8010018c:	e8 1f 29 00 00       	call   80102ab0 <iderw>
80100191:	83 c4 10             	add    $0x10,%esp
80100194:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100197:	89 d8                	mov    %ebx,%eax
80100199:	5b                   	pop    %ebx
8010019a:	5e                   	pop    %esi
8010019b:	5f                   	pop    %edi
8010019c:	5d                   	pop    %ebp
8010019d:	c3                   	ret    
8010019e:	83 ec 0c             	sub    $0xc,%esp
801001a1:	68 2e 7c 10 80       	push   $0x80107c2e
801001a6:	e8 f5 01 00 00       	call   801003a0 <panic>
801001ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801001af:	90                   	nop

801001b0 <bwrite>:
801001b0:	55                   	push   %ebp
801001b1:	89 e5                	mov    %esp,%ebp
801001b3:	53                   	push   %ebx
801001b4:	83 ec 10             	sub    $0x10,%esp
801001b7:	8b 5d 08             	mov    0x8(%ebp),%ebx
801001ba:	8d 43 0c             	lea    0xc(%ebx),%eax
801001bd:	50                   	push   %eax
801001be:	e8 8d 49 00 00       	call   80104b50 <holdingsleep>
801001c3:	83 c4 10             	add    $0x10,%esp
801001c6:	85 c0                	test   %eax,%eax
801001c8:	74 0f                	je     801001d9 <bwrite+0x29>
801001ca:	83 0b 04             	orl    $0x4,(%ebx)
801001cd:	89 5d 08             	mov    %ebx,0x8(%ebp)
801001d0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801001d3:	c9                   	leave  
801001d4:	e9 d7 28 00 00       	jmp    80102ab0 <iderw>
801001d9:	83 ec 0c             	sub    $0xc,%esp
801001dc:	68 3f 7c 10 80       	push   $0x80107c3f
801001e1:	e8 ba 01 00 00       	call   801003a0 <panic>
801001e6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801001ed:	8d 76 00             	lea    0x0(%esi),%esi

801001f0 <brelse>:
801001f0:	55                   	push   %ebp
801001f1:	89 e5                	mov    %esp,%ebp
801001f3:	56                   	push   %esi
801001f4:	53                   	push   %ebx
801001f5:	8b 5d 08             	mov    0x8(%ebp),%ebx
801001f8:	8d 73 0c             	lea    0xc(%ebx),%esi
801001fb:	83 ec 0c             	sub    $0xc,%esp
801001fe:	56                   	push   %esi
801001ff:	e8 4c 49 00 00       	call   80104b50 <holdingsleep>
80100204:	83 c4 10             	add    $0x10,%esp
80100207:	85 c0                	test   %eax,%eax
80100209:	74 66                	je     80100271 <brelse+0x81>
8010020b:	83 ec 0c             	sub    $0xc,%esp
8010020e:	56                   	push   %esi
8010020f:	e8 fc 48 00 00       	call   80104b10 <releasesleep>
80100214:	c7 04 24 20 b5 10 80 	movl   $0x8010b520,(%esp)
8010021b:	e8 50 4b 00 00       	call   80104d70 <acquire>
80100220:	8b 43 4c             	mov    0x4c(%ebx),%eax
80100223:	83 c4 10             	add    $0x10,%esp
80100226:	83 e8 01             	sub    $0x1,%eax
80100229:	89 43 4c             	mov    %eax,0x4c(%ebx)
8010022c:	85 c0                	test   %eax,%eax
8010022e:	75 2f                	jne    8010025f <brelse+0x6f>
80100230:	8b 43 54             	mov    0x54(%ebx),%eax
80100233:	8b 53 50             	mov    0x50(%ebx),%edx
80100236:	89 50 50             	mov    %edx,0x50(%eax)
80100239:	8b 43 50             	mov    0x50(%ebx),%eax
8010023c:	8b 53 54             	mov    0x54(%ebx),%edx
8010023f:	89 50 54             	mov    %edx,0x54(%eax)
80100242:	a1 70 fc 10 80       	mov    0x8010fc70,%eax
80100247:	c7 43 50 1c fc 10 80 	movl   $0x8010fc1c,0x50(%ebx)
8010024e:	89 43 54             	mov    %eax,0x54(%ebx)
80100251:	a1 70 fc 10 80       	mov    0x8010fc70,%eax
80100256:	89 58 50             	mov    %ebx,0x50(%eax)
80100259:	89 1d 70 fc 10 80    	mov    %ebx,0x8010fc70
8010025f:	c7 45 08 20 b5 10 80 	movl   $0x8010b520,0x8(%ebp)
80100266:	8d 65 f8             	lea    -0x8(%ebp),%esp
80100269:	5b                   	pop    %ebx
8010026a:	5e                   	pop    %esi
8010026b:	5d                   	pop    %ebp
8010026c:	e9 9f 4a 00 00       	jmp    80104d10 <release>
80100271:	83 ec 0c             	sub    $0xc,%esp
80100274:	68 46 7c 10 80       	push   $0x80107c46
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
80100297:	e8 94 1d 00 00       	call   80102030 <iunlock>
  acquire(&cons.lock);
8010029c:	c7 04 24 60 0b 11 80 	movl   $0x80110b60,(%esp)
  target = n;
801002a3:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
  acquire(&cons.lock);
801002a6:	e8 c5 4a 00 00       	call   80104d70 <acquire>
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
801002dd:	e8 2e 45 00 00       	call   80104810 <sleep>
    while (input.r == input.w)
801002e2:	8b 0d d0 fe 10 80    	mov    0x8010fed0,%ecx
801002e8:	83 c4 10             	add    $0x10,%esp
801002eb:	3b 0d d4 fe 10 80    	cmp    0x8010fed4,%ecx
801002f1:	75 35                	jne    80100328 <consoleread+0xa8>
      if (myproc()->killed)
801002f3:	e8 48 3e 00 00       	call   80104140 <myproc>
801002f8:	8b 48 24             	mov    0x24(%eax),%ecx
801002fb:	85 c9                	test   %ecx,%ecx
801002fd:	74 d1                	je     801002d0 <consoleread+0x50>
        release(&cons.lock);
801002ff:	83 ec 0c             	sub    $0xc,%esp
80100302:	68 60 0b 11 80       	push   $0x80110b60
80100307:	e8 04 4a 00 00       	call   80104d10 <release>
        ilock(ip);
8010030c:	5a                   	pop    %edx
8010030d:	ff 75 08             	push   0x8(%ebp)
80100310:	e8 3b 1c 00 00       	call   80101f50 <ilock>
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
80100368:	e8 a3 49 00 00       	call   80104d10 <release>
  ilock(ip);
8010036d:	58                   	pop    %eax
8010036e:	ff 75 08             	push   0x8(%ebp)
80100371:	e8 da 1b 00 00       	call   80101f50 <ilock>
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
801003b9:	e8 02 2d 00 00       	call   801030c0 <lapicid>
801003be:	83 ec 08             	sub    $0x8,%esp
801003c1:	50                   	push   %eax
801003c2:	68 4d 7c 10 80       	push   $0x80107c4d
801003c7:	e8 84 03 00 00       	call   80100750 <cprintf>
  cprintf(s);
801003cc:	58                   	pop    %eax
801003cd:	ff 75 08             	push   0x8(%ebp)
801003d0:	e8 7b 03 00 00       	call   80100750 <cprintf>
  cprintf("\n");
801003d5:	c7 04 24 57 86 10 80 	movl   $0x80108657,(%esp)
801003dc:	e8 6f 03 00 00       	call   80100750 <cprintf>
  getcallerpcs(&s, pcs);
801003e1:	8d 45 08             	lea    0x8(%ebp),%eax
801003e4:	5a                   	pop    %edx
801003e5:	59                   	pop    %ecx
801003e6:	53                   	push   %ebx
801003e7:	50                   	push   %eax
801003e8:	e8 d3 47 00 00       	call   80104bc0 <getcallerpcs>
  for (i = 0; i < 10; i++)
801003ed:	83 c4 10             	add    $0x10,%esp
    cprintf(" %p", pcs[i]);
801003f0:	83 ec 08             	sub    $0x8,%esp
801003f3:	ff 33                	push   (%ebx)
  for (i = 0; i < 10; i++)
801003f5:	83 c3 04             	add    $0x4,%ebx
    cprintf(" %p", pcs[i]);
801003f8:	68 61 7c 10 80       	push   $0x80107c61
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
  asm volatile("out %0,%1" : : "a"(data), "d"(port));
80100424:	bf d4 03 00 00       	mov    $0x3d4,%edi
80100429:	56                   	push   %esi
8010042a:	89 fa                	mov    %edi,%edx
8010042c:	89 c6                	mov    %eax,%esi
8010042e:	b8 0e 00 00 00       	mov    $0xe,%eax
80100433:	53                   	push   %ebx
80100434:	83 ec 0c             	sub    $0xc,%esp
80100437:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a"(data) : "d"(port));
80100438:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
8010043d:	89 ca                	mov    %ecx,%edx
8010043f:	ec                   	in     (%dx),%al
  pos = inb(CRTPORT + 1) << 8;
80100440:	0f b6 d8             	movzbl %al,%ebx
  asm volatile("out %0,%1" : : "a"(data), "d"(port));
80100443:	89 fa                	mov    %edi,%edx
80100445:	b8 0f 00 00 00       	mov    $0xf,%eax
8010044a:	c1 e3 08             	shl    $0x8,%ebx
8010044d:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a"(data) : "d"(port));
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
801004fc:	e8 cf 49 00 00       	call   80104ed0 <memmove>
    memset(crt + pos, 0, sizeof(crt[0]) * (24 * 80 - pos));
80100501:	b8 80 07 00 00       	mov    $0x780,%eax
80100506:	83 c4 0c             	add    $0xc,%esp
80100509:	29 d8                	sub    %ebx,%eax
8010050b:	01 c0                	add    %eax,%eax
8010050d:	50                   	push   %eax
8010050e:	8d 84 1b 00 80 0b 80 	lea    -0x7ff48000(%ebx,%ebx,1),%eax
80100515:	6a 00                	push   $0x0
80100517:	50                   	push   %eax
80100518:	e8 13 49 00 00       	call   80104e30 <memset>
  outb(CRTPORT + 1, pos);
8010051d:	83 c4 10             	add    $0x10,%esp
  asm volatile("out %0,%1" : : "a"(data), "d"(port));
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
801005f1:	e8 da 48 00 00       	call   80104ed0 <memmove>
    memset(crt + pos, 0, sizeof(crt[0]) * (25 * 80 - pos));
801005f6:	83 c4 0c             	add    $0xc,%esp
801005f9:	68 9c 0f 00 00       	push   $0xf9c
801005fe:	6a 00                	push   $0x0
80100600:	68 04 80 0b 80       	push   $0x800b8004
80100605:	e8 26 48 00 00       	call   80104e30 <memset>
8010060a:	83 c4 10             	add    $0x10,%esp
8010060d:	e9 0e ff ff ff       	jmp    80100520 <cgaputc+0x100>
    panic("pos under/overflow");
80100612:	83 ec 0c             	sub    $0xc,%esp
80100615:	68 65 7c 10 80       	push   $0x80107c65
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
8010062f:	e8 fc 19 00 00       	call   80102030 <iunlock>
  acquire(&cons.lock);
80100634:	c7 04 24 60 0b 11 80 	movl   $0x80110b60,(%esp)
8010063b:	e8 30 47 00 00       	call   80104d70 <acquire>
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
8010066a:	e8 d1 60 00 00       	call   80106740 <uartputc>
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
80100686:	e8 85 46 00 00       	call   80104d10 <release>
  ilock(ip);
8010068b:	58                   	pop    %eax
8010068c:	ff 75 08             	push   0x8(%ebp)
8010068f:	e8 bc 18 00 00       	call   80101f50 <ilock>

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
801006d6:	0f b6 92 e8 7c 10 80 	movzbl -0x7fef8318(%edx),%edx
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
80100717:	e8 24 60 00 00       	call   80106740 <uartputc>
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
80100805:	bf 78 7c 10 80       	mov    $0x80107c78,%edi
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
8010087a:	e8 c1 5e 00 00       	call   80106740 <uartputc>
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
801008a8:	e8 c3 44 00 00       	call   80104d70 <acquire>
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
801008c7:	e8 74 5e 00 00       	call   80106740 <uartputc>
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
80100908:	e8 33 5e 00 00       	call   80106740 <uartputc>
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
80100953:	e8 e8 5d 00 00       	call   80106740 <uartputc>
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
8010097f:	e8 bc 5d 00 00       	call   80106740 <uartputc>
  cgaputc(c);
80100984:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100987:	e8 94 fa ff ff       	call   80100420 <cgaputc>
}
8010098c:	83 c4 10             	add    $0x10,%esp
8010098f:	e9 37 fe ff ff       	jmp    801007cb <cprintf+0x7b>
    release(&cons.lock);
80100994:	83 ec 0c             	sub    $0xc,%esp
80100997:	68 60 0b 11 80       	push   $0x80110b60
8010099c:	e8 6f 43 00 00       	call   80104d10 <release>
801009a1:	83 c4 10             	add    $0x10,%esp
}
801009a4:	e9 38 fe ff ff       	jmp    801007e1 <cprintf+0x91>
      if ((s = (char *)*argp++) == 0)
801009a9:	8b 7d e0             	mov    -0x20(%ebp),%edi
801009ac:	e9 1a fe ff ff       	jmp    801007cb <cprintf+0x7b>
    panic("null fmt");
801009b1:	83 ec 0c             	sub    $0xc,%esp
801009b4:	68 7f 7c 10 80       	push   $0x80107c7f
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

80100a80 <BackSpace>:
  return input.e - input.w;
80100a80:	8b 0d d8 fe 10 80    	mov    0x8010fed8,%ecx
80100a86:	a1 d4 fe 10 80       	mov    0x8010fed4,%eax
80100a8b:	89 ca                	mov    %ecx,%edx
80100a8d:	29 c2                	sub    %eax,%edx
  if (currentIndex() > 0)
80100a8f:	85 d2                	test   %edx,%edx
80100a91:	0f 8e b9 00 00 00    	jle    80100b50 <BackSpace+0xd0>
{
80100a97:	55                   	push   %ebp
    input.e--;
80100a98:	83 e9 01             	sub    $0x1,%ecx
{
80100a9b:	89 e5                	mov    %esp,%ebp
80100a9d:	57                   	push   %edi
80100a9e:	56                   	push   %esi
80100a9f:	53                   	push   %ebx
80100aa0:	83 ec 1c             	sub    $0x1c,%esp
    for (int i = input.e; i < input.w + lineLength - 1; i++)
80100aa3:	8b 35 54 0b 11 80    	mov    0x80110b54,%esi
    input.e--;
80100aa9:	89 0d d8 fe 10 80    	mov    %ecx,0x8010fed8
    for (int i = input.e; i < input.w + lineLength - 1; i++)
80100aaf:	8d 44 30 ff          	lea    -0x1(%eax,%esi,1),%eax
80100ab3:	89 75 e0             	mov    %esi,-0x20(%ebp)
80100ab6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100ab9:	39 c1                	cmp    %eax,%ecx
80100abb:	73 52                	jae    80100b0f <BackSpace+0x8f>
      input.buf[i % INPUT_BUF] = input.buf[(i + 1) % INPUT_BUF];
80100abd:	be d3 20 0d d2       	mov    $0xd20d20d3,%esi
80100ac2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100ac8:	89 cb                	mov    %ecx,%ebx
80100aca:	83 c1 01             	add    $0x1,%ecx
80100acd:	89 c8                	mov    %ecx,%eax
80100acf:	89 cf                	mov    %ecx,%edi
80100ad1:	f7 ee                	imul   %esi
80100ad3:	c1 ff 1f             	sar    $0x1f,%edi
80100ad6:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
80100ad9:	89 ca                	mov    %ecx,%edx
80100adb:	c1 f8 06             	sar    $0x6,%eax
80100ade:	29 f8                	sub    %edi,%eax
80100ae0:	6b c0 4e             	imul   $0x4e,%eax,%eax
80100ae3:	29 c2                	sub    %eax,%edx
80100ae5:	89 d8                	mov    %ebx,%eax
80100ae7:	0f b6 ba 80 fe 10 80 	movzbl -0x7fef0180(%edx),%edi
80100aee:	f7 ee                	imul   %esi
80100af0:	8d 04 1a             	lea    (%edx,%ebx,1),%eax
80100af3:	89 da                	mov    %ebx,%edx
80100af5:	c1 f8 06             	sar    $0x6,%eax
80100af8:	c1 fa 1f             	sar    $0x1f,%edx
80100afb:	29 d0                	sub    %edx,%eax
80100afd:	6b c0 4e             	imul   $0x4e,%eax,%eax
80100b00:	29 c3                	sub    %eax,%ebx
80100b02:	89 f8                	mov    %edi,%eax
80100b04:	88 83 80 fe 10 80    	mov    %al,-0x7fef0180(%ebx)
    for (int i = input.e; i < input.w + lineLength - 1; i++)
80100b0a:	3b 4d e4             	cmp    -0x1c(%ebp),%ecx
80100b0d:	75 b9                	jne    80100ac8 <BackSpace+0x48>
    lineLength--;
80100b0f:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100b12:	83 e8 01             	sub    $0x1,%eax
80100b15:	a3 54 0b 11 80       	mov    %eax,0x80110b54
  if (panicked)
80100b1a:	a1 98 0b 11 80       	mov    0x80110b98,%eax
80100b1f:	85 c0                	test   %eax,%eax
80100b21:	74 0d                	je     80100b30 <BackSpace+0xb0>
80100b23:	fa                   	cli    
    for (;;)
80100b24:	eb fe                	jmp    80100b24 <BackSpace+0xa4>
80100b26:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100b2d:	8d 76 00             	lea    0x0(%esi),%esi
    uartputc('\b');
80100b30:	83 ec 0c             	sub    $0xc,%esp
80100b33:	6a 08                	push   $0x8
80100b35:	e8 06 5c 00 00       	call   80106740 <uartputc>
  cgaputc(c);
80100b3a:	83 c4 10             	add    $0x10,%esp
}
80100b3d:	8d 65 f4             	lea    -0xc(%ebp),%esp
  cgaputc(c);
80100b40:	b8 00 01 00 00       	mov    $0x100,%eax
}
80100b45:	5b                   	pop    %ebx
80100b46:	5e                   	pop    %esi
80100b47:	5f                   	pop    %edi
80100b48:	5d                   	pop    %ebp
  cgaputc(c);
80100b49:	e9 d2 f8 ff ff       	jmp    80100420 <cgaputc>
80100b4e:	66 90                	xchg   %ax,%ax
80100b50:	c3                   	ret    
80100b51:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100b58:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100b5f:	90                   	nop

80100b60 <KillLine>:
{
80100b60:	55                   	push   %ebp
80100b61:	89 e5                	mov    %esp,%ebp
80100b63:	53                   	push   %ebx
80100b64:	83 ec 04             	sub    $0x4,%esp
  return input.e - input.w;
80100b67:	a1 d8 fe 10 80       	mov    0x8010fed8,%eax
80100b6c:	89 c3                	mov    %eax,%ebx
80100b6e:	2b 1d d4 fe 10 80    	sub    0x8010fed4,%ebx
  while (currentIndex() < lineLength)
80100b74:	3b 1d 54 0b 11 80    	cmp    0x80110b54,%ebx
80100b7a:	7d 28                	jge    80100ba4 <KillLine+0x44>
  if (panicked)
80100b7c:	8b 15 98 0b 11 80    	mov    0x80110b98,%edx
    input.e++;
80100b82:	83 c0 01             	add    $0x1,%eax
80100b85:	a3 d8 fe 10 80       	mov    %eax,0x8010fed8
  if (panicked)
80100b8a:	85 d2                	test   %edx,%edx
80100b8c:	74 0a                	je     80100b98 <KillLine+0x38>
80100b8e:	fa                   	cli    
    for (;;)
80100b8f:	eb fe                	jmp    80100b8f <KillLine+0x2f>
80100b91:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  cgaputc(c);
80100b98:	b8 02 01 00 00       	mov    $0x102,%eax
80100b9d:	e8 7e f8 ff ff       	call   80100420 <cgaputc>
  return input.e - input.w;
80100ba2:	eb c3                	jmp    80100b67 <KillLine+0x7>
  for (int i = currentIndex(); i > 0; i--)
80100ba4:	85 db                	test   %ebx,%ebx
80100ba6:	7e 2c                	jle    80100bd4 <KillLine+0x74>
  if (panicked)
80100ba8:	a1 98 0b 11 80       	mov    0x80110b98,%eax
80100bad:	85 c0                	test   %eax,%eax
80100baf:	74 07                	je     80100bb8 <KillLine+0x58>
80100bb1:	fa                   	cli    
    for (;;)
80100bb2:	eb fe                	jmp    80100bb2 <KillLine+0x52>
80100bb4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    uartputc('\b');
80100bb8:	83 ec 0c             	sub    $0xc,%esp
80100bbb:	6a 08                	push   $0x8
80100bbd:	e8 7e 5b 00 00       	call   80106740 <uartputc>
  cgaputc(c);
80100bc2:	b8 00 01 00 00       	mov    $0x100,%eax
80100bc7:	e8 54 f8 ff ff       	call   80100420 <cgaputc>
  for (int i = currentIndex(); i > 0; i--)
80100bcc:	83 c4 10             	add    $0x10,%esp
80100bcf:	83 eb 01             	sub    $0x1,%ebx
80100bd2:	75 d4                	jne    80100ba8 <KillLine+0x48>
  input.e = input.w;
80100bd4:	a1 d4 fe 10 80       	mov    0x8010fed4,%eax
}
80100bd9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  lineLength = 0;
80100bdc:	c7 05 54 0b 11 80 00 	movl   $0x0,0x80110b54
80100be3:	00 00 00 
  input.e = input.w;
80100be6:	a3 d8 fe 10 80       	mov    %eax,0x8010fed8
}
80100beb:	c9                   	leave  
80100bec:	c3                   	ret    
80100bed:	8d 76 00             	lea    0x0(%esi),%esi

80100bf0 <Change>:
{
80100bf0:	55                   	push   %ebp
80100bf1:	89 e5                	mov    %esp,%ebp
80100bf3:	57                   	push   %edi
80100bf4:	56                   	push   %esi
80100bf5:	53                   	push   %ebx
80100bf6:	83 ec 0c             	sub    $0xc,%esp
  KillLine();
80100bf9:	e8 62 ff ff ff       	call   80100b60 <KillLine>
  memset(input.buf, 0, INPUT_BUF * sizeof(input.buf[0]));
80100bfe:	83 ec 04             	sub    $0x4,%esp
  lineLength = lineLengths[current];
80100c01:	a1 00 90 10 80       	mov    0x80109000,%eax
  memset(input.buf, 0, INPUT_BUF * sizeof(input.buf[0]));
80100c06:	6a 4e                	push   $0x4e
80100c08:	6a 00                	push   $0x0
  lineLength = lineLengths[current];
80100c0a:	8b 04 85 e0 fe 10 80 	mov    -0x7fef0120(,%eax,4),%eax
  memset(input.buf, 0, INPUT_BUF * sizeof(input.buf[0]));
80100c11:	68 80 fe 10 80       	push   $0x8010fe80
  lineLength = lineLengths[current];
80100c16:	a3 54 0b 11 80       	mov    %eax,0x80110b54
  memset(input.buf, 0, INPUT_BUF * sizeof(input.buf[0]));
80100c1b:	e8 10 42 00 00       	call   80104e30 <memset>
  for (int i = 0; i < lineLength; i++)
80100c20:	a1 54 0b 11 80       	mov    0x80110b54,%eax
80100c25:	83 c4 10             	add    $0x10,%esp
80100c28:	85 c0                	test   %eax,%eax
80100c2a:	7e 68                	jle    80100c94 <Change+0xa4>
80100c2c:	31 db                	xor    %ebx,%ebx
    consputc(input.buf[(i + input.w) % INPUT_BUF] = commands[current][i]);
80100c2e:	bf d3 20 0d d2       	mov    $0xd20d20d3,%edi
80100c33:	8b 0d d4 fe 10 80    	mov    0x8010fed4,%ecx
80100c39:	6b 05 00 90 10 80 4e 	imul   $0x4e,0x80109000,%eax
80100c40:	01 d9                	add    %ebx,%ecx
80100c42:	89 ca                	mov    %ecx,%edx
80100c44:	01 d8                	add    %ebx,%eax
80100c46:	d1 ea                	shr    %edx
80100c48:	8b 34 85 20 ff 10 80 	mov    -0x7fef00e0(,%eax,4),%esi
80100c4f:	89 d0                	mov    %edx,%eax
80100c51:	f7 e7                	mul    %edi
80100c53:	89 f0                	mov    %esi,%eax
80100c55:	c1 ea 05             	shr    $0x5,%edx
80100c58:	6b d2 4e             	imul   $0x4e,%edx,%edx
80100c5b:	29 d1                	sub    %edx,%ecx
80100c5d:	88 81 80 fe 10 80    	mov    %al,-0x7fef0180(%ecx)
  if (panicked)
80100c63:	a1 98 0b 11 80       	mov    0x80110b98,%eax
80100c68:	85 c0                	test   %eax,%eax
80100c6a:	74 04                	je     80100c70 <Change+0x80>
80100c6c:	fa                   	cli    
    for (;;)
80100c6d:	eb fe                	jmp    80100c6d <Change+0x7d>
80100c6f:	90                   	nop
    consputc(input.buf[(i + input.w) % INPUT_BUF] = commands[current][i]);
80100c70:	89 f0                	mov    %esi,%eax
    uartputc(c);
80100c72:	83 ec 0c             	sub    $0xc,%esp
  for (int i = 0; i < lineLength; i++)
80100c75:	83 c3 01             	add    $0x1,%ebx
    consputc(input.buf[(i + input.w) % INPUT_BUF] = commands[current][i]);
80100c78:	0f be f0             	movsbl %al,%esi
    uartputc(c);
80100c7b:	56                   	push   %esi
80100c7c:	e8 bf 5a 00 00       	call   80106740 <uartputc>
  cgaputc(c);
80100c81:	89 f0                	mov    %esi,%eax
80100c83:	e8 98 f7 ff ff       	call   80100420 <cgaputc>
  for (int i = 0; i < lineLength; i++)
80100c88:	a1 54 0b 11 80       	mov    0x80110b54,%eax
80100c8d:	83 c4 10             	add    $0x10,%esp
80100c90:	39 d8                	cmp    %ebx,%eax
80100c92:	7f 9f                	jg     80100c33 <Change+0x43>
  input.e = input.w + lineLength;
80100c94:	03 05 d4 fe 10 80    	add    0x8010fed4,%eax
80100c9a:	a3 d8 fe 10 80       	mov    %eax,0x8010fed8
}
80100c9f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100ca2:	5b                   	pop    %ebx
80100ca3:	5e                   	pop    %esi
80100ca4:	5f                   	pop    %edi
80100ca5:	5d                   	pop    %ebp
80100ca6:	c3                   	ret    
80100ca7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100cae:	66 90                	xchg   %ax,%ax

80100cb0 <SubmitCommand>:
{
80100cb0:	55                   	push   %ebp
      commands[i][j] = commands[i - 1][j];
80100cb1:	b9 40 f6 ff ff       	mov    $0xfffff640,%ecx
{
80100cb6:	89 e5                	mov    %esp,%ebp
80100cb8:	57                   	push   %edi
  for (int i = MAXCOMMANDS - 1; i > 0; i--)
80100cb9:	bf 09 00 00 00       	mov    $0x9,%edi
{
80100cbe:	56                   	push   %esi
80100cbf:	53                   	push   %ebx
      commands[i][j] = commands[i - 1][j];
80100cc0:	bb f8 0a 00 00       	mov    $0xaf8,%ebx
{
80100cc5:	83 ec 1c             	sub    $0x1c,%esp
80100cc8:	8b 45 08             	mov    0x8(%ebp),%eax
80100ccb:	c7 45 e4 18 0a 11 80 	movl   $0x80110a18,-0x1c(%ebp)
80100cd2:	89 45 dc             	mov    %eax,-0x24(%ebp)
80100cd5:	8d 76 00             	lea    0x0(%esi),%esi
    for (int j = 0; j < INPUT_BUF; j++)
80100cd8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
      commands[i][j] = commands[i - 1][j];
80100cdb:	83 ef 01             	sub    $0x1,%edi
80100cde:	89 7d e0             	mov    %edi,-0x20(%ebp)
80100ce1:	89 c6                	mov    %eax,%esi
80100ce3:	2d 38 01 00 00       	sub    $0x138,%eax
80100ce8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100ceb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100cef:	90                   	nop
80100cf0:	8b 38                	mov    (%eax),%edi
80100cf2:	8d 14 08             	lea    (%eax,%ecx,1),%edx
    for (int j = 0; j < INPUT_BUF; j++)
80100cf5:	83 c0 04             	add    $0x4,%eax
      commands[i][j] = commands[i - 1][j];
80100cf8:	89 3c 1a             	mov    %edi,(%edx,%ebx,1)
    for (int j = 0; j < INPUT_BUF; j++)
80100cfb:	39 f0                	cmp    %esi,%eax
80100cfd:	75 f1                	jne    80100cf0 <SubmitCommand+0x40>
    lineLengths[i] = lineLengths[i - 1];
80100cff:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for (int i = MAXCOMMANDS - 1; i > 0; i--)
80100d02:	81 c1 38 01 00 00    	add    $0x138,%ecx
80100d08:	81 eb 38 01 00 00    	sub    $0x138,%ebx
    lineLengths[i] = lineLengths[i - 1];
80100d0e:	8b 04 bd e0 fe 10 80 	mov    -0x7fef0120(,%edi,4),%eax
80100d15:	89 04 bd e4 fe 10 80 	mov    %eax,-0x7fef011c(,%edi,4)
  for (int i = MAXCOMMANDS - 1; i > 0; i--)
80100d1c:	85 ff                	test   %edi,%edi
80100d1e:	75 b8                	jne    80100cd8 <SubmitCommand+0x28>
  memset(commands[0], 0, INPUT_BUF * sizeof(int));
80100d20:	83 ec 04             	sub    $0x4,%esp
80100d23:	68 38 01 00 00       	push   $0x138
80100d28:	6a 00                	push   $0x0
80100d2a:	68 20 ff 10 80       	push   $0x8010ff20
80100d2f:	e8 fc 40 00 00       	call   80104e30 <memset>
  for (int j = 0; j < lineLength; j++)
80100d34:	a1 54 0b 11 80       	mov    0x80110b54,%eax
80100d39:	83 c4 10             	add    $0x10,%esp
80100d3c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100d3f:	85 c0                	test   %eax,%eax
80100d41:	0f 8e b3 00 00 00    	jle    80100dfa <SubmitCommand+0x14a>
    commands[0][j] = input.buf[(j + input.w) % INPUT_BUF];
80100d47:	8b 0d d4 fe 10 80    	mov    0x8010fed4,%ecx
80100d4d:	bf d3 20 0d d2       	mov    $0xd20d20d3,%edi
80100d52:	89 ce                	mov    %ecx,%esi
80100d54:	8d 1c 08             	lea    (%eax,%ecx,1),%ebx
80100d57:	f7 de                	neg    %esi
80100d59:	c1 e6 02             	shl    $0x2,%esi
80100d5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100d60:	89 ca                	mov    %ecx,%edx
80100d62:	d1 ea                	shr    %edx
80100d64:	89 d0                	mov    %edx,%eax
80100d66:	f7 e7                	mul    %edi
80100d68:	c1 ea 05             	shr    $0x5,%edx
80100d6b:	6b c2 4e             	imul   $0x4e,%edx,%eax
80100d6e:	89 ca                	mov    %ecx,%edx
80100d70:	29 c2                	sub    %eax,%edx
80100d72:	0f be 82 80 fe 10 80 	movsbl -0x7fef0180(%edx),%eax
80100d79:	89 84 8e 20 ff 10 80 	mov    %eax,-0x7fef00e0(%esi,%ecx,4)
  for (int j = 0; j < lineLength; j++)
80100d80:	83 c1 01             	add    $0x1,%ecx
80100d83:	39 d9                	cmp    %ebx,%ecx
80100d85:	75 d9                	jne    80100d60 <SubmitCommand+0xb0>
  lineLengths[0] = lineLength;
80100d87:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  input.buf[input.e++ % INPUT_BUF] = c;
80100d8a:	89 da                	mov    %ebx,%edx
80100d8c:	be d3 20 0d d2       	mov    $0xd20d20d3,%esi
80100d91:	8d 4b 01             	lea    0x1(%ebx),%ecx
80100d94:	d1 ea                	shr    %edx
  wakeup(&input.r);
80100d96:	c7 45 08 d0 fe 10 80 	movl   $0x8010fed0,0x8(%ebp)
  lineLengths[0] = lineLength;
80100d9d:	a3 e0 fe 10 80       	mov    %eax,0x8010fee0
  input.buf[input.e++ % INPUT_BUF] = c;
80100da2:	89 d0                	mov    %edx,%eax
80100da4:	f7 e6                	mul    %esi
80100da6:	89 0d d8 fe 10 80    	mov    %ecx,0x8010fed8
  input.w = input.e;
80100dac:	89 0d d4 fe 10 80    	mov    %ecx,0x8010fed4
  lineLength = 0;
80100db2:	c7 05 54 0b 11 80 00 	movl   $0x0,0x80110b54
80100db9:	00 00 00 
  current = -1;
80100dbc:	c7 05 00 90 10 80 ff 	movl   $0xffffffff,0x80109000
80100dc3:	ff ff ff 
  input.buf[input.e++ % INPUT_BUF] = c;
80100dc6:	89 d0                	mov    %edx,%eax
  maxCommands = maxCommands == MAXCOMMANDS ? MAXCOMMANDS : (maxCommands + 1);
80100dc8:	31 d2                	xor    %edx,%edx
  input.buf[input.e++ % INPUT_BUF] = c;
80100dca:	c1 e8 05             	shr    $0x5,%eax
80100dcd:	6b c0 4e             	imul   $0x4e,%eax,%eax
80100dd0:	29 c3                	sub    %eax,%ebx
80100dd2:	0f b6 45 dc          	movzbl -0x24(%ebp),%eax
80100dd6:	88 83 80 fe 10 80    	mov    %al,-0x7fef0180(%ebx)
  maxCommands = maxCommands == MAXCOMMANDS ? MAXCOMMANDS : (maxCommands + 1);
80100ddc:	a1 50 0b 11 80       	mov    0x80110b50,%eax
80100de1:	83 f8 0a             	cmp    $0xa,%eax
80100de4:	0f 95 c2             	setne  %dl
80100de7:	01 d0                	add    %edx,%eax
80100de9:	a3 50 0b 11 80       	mov    %eax,0x80110b50
}
80100dee:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100df1:	5b                   	pop    %ebx
80100df2:	5e                   	pop    %esi
80100df3:	5f                   	pop    %edi
80100df4:	5d                   	pop    %ebp
  wakeup(&input.r);
80100df5:	e9 d6 3a 00 00       	jmp    801048d0 <wakeup>
80100dfa:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80100dfd:	03 1d d4 fe 10 80    	add    0x8010fed4,%ebx
80100e03:	eb 82                	jmp    80100d87 <SubmitCommand+0xd7>
80100e05:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100e0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100e10 <consoleintr>:
{
80100e10:	55                   	push   %ebp
80100e11:	89 e5                	mov    %esp,%ebp
80100e13:	57                   	push   %edi
  int c, doprocdump = 0;
80100e14:	31 ff                	xor    %edi,%edi
{
80100e16:	56                   	push   %esi
80100e17:	53                   	push   %ebx
80100e18:	83 ec 28             	sub    $0x28,%esp
80100e1b:	8b 75 08             	mov    0x8(%ebp),%esi
  acquire(&cons.lock);
80100e1e:	68 60 0b 11 80       	push   $0x80110b60
80100e23:	e8 48 3f 00 00       	call   80104d70 <acquire>
  while ((c = getc()) >= 0)
80100e28:	83 c4 10             	add    $0x10,%esp
80100e2b:	ff d6                	call   *%esi
80100e2d:	89 c3                	mov    %eax,%ebx
80100e2f:	85 c0                	test   %eax,%eax
80100e31:	78 6d                	js     80100ea0 <consoleintr+0x90>
    switch (c)
80100e33:	83 fb 15             	cmp    $0x15,%ebx
80100e36:	7f 18                	jg     80100e50 <consoleintr+0x40>
80100e38:	83 fb 01             	cmp    $0x1,%ebx
80100e3b:	0f 8e 7f 00 00 00    	jle    80100ec0 <consoleintr+0xb0>
80100e41:	83 fb 15             	cmp    $0x15,%ebx
80100e44:	77 7a                	ja     80100ec0 <consoleintr+0xb0>
80100e46:	ff 24 9d 90 7c 10 80 	jmp    *-0x7fef8370(,%ebx,4)
80100e4d:	8d 76 00             	lea    0x0(%esi),%esi
80100e50:	81 fb e2 00 00 00    	cmp    $0xe2,%ebx
80100e56:	0f 84 04 02 00 00    	je     80101060 <consoleintr+0x250>
80100e5c:	81 fb e3 00 00 00    	cmp    $0xe3,%ebx
80100e62:	75 24                	jne    80100e88 <consoleintr+0x78>
      if (current > 0)
80100e64:	a1 00 90 10 80       	mov    0x80109000,%eax
80100e69:	85 c0                	test   %eax,%eax
80100e6b:	0f 8f 59 02 00 00    	jg     801010ca <consoleintr+0x2ba>
      else if (current == 0)
80100e71:	75 b8                	jne    80100e2b <consoleintr+0x1b>
        KillLine();
80100e73:	e8 e8 fc ff ff       	call   80100b60 <KillLine>
        current--;
80100e78:	83 2d 00 90 10 80 01 	subl   $0x1,0x80109000
80100e7f:	eb aa                	jmp    80100e2b <consoleintr+0x1b>
80100e81:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    switch (c)
80100e88:	83 fb 7f             	cmp    $0x7f,%ebx
80100e8b:	75 3b                	jne    80100ec8 <consoleintr+0xb8>
      BackSpace();
80100e8d:	e8 ee fb ff ff       	call   80100a80 <BackSpace>
  while ((c = getc()) >= 0)
80100e92:	ff d6                	call   *%esi
80100e94:	89 c3                	mov    %eax,%ebx
80100e96:	85 c0                	test   %eax,%eax
80100e98:	79 99                	jns    80100e33 <consoleintr+0x23>
80100e9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  release(&cons.lock);
80100ea0:	83 ec 0c             	sub    $0xc,%esp
80100ea3:	68 60 0b 11 80       	push   $0x80110b60
80100ea8:	e8 63 3e 00 00       	call   80104d10 <release>
  if (doprocdump)
80100ead:	83 c4 10             	add    $0x10,%esp
80100eb0:	85 ff                	test   %edi,%edi
80100eb2:	0f 85 24 02 00 00    	jne    801010dc <consoleintr+0x2cc>
}
80100eb8:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100ebb:	5b                   	pop    %ebx
80100ebc:	5e                   	pop    %esi
80100ebd:	5f                   	pop    %edi
80100ebe:	5d                   	pop    %ebp
80100ebf:	c3                   	ret    
      if (c != 0 && input.e - input.r < INPUT_BUF)
80100ec0:	85 db                	test   %ebx,%ebx
80100ec2:	0f 84 63 ff ff ff    	je     80100e2b <consoleintr+0x1b>
80100ec8:	a1 d8 fe 10 80       	mov    0x8010fed8,%eax
80100ecd:	2b 05 d0 fe 10 80    	sub    0x8010fed0,%eax
80100ed3:	83 f8 4d             	cmp    $0x4d,%eax
80100ed6:	0f 87 4f ff ff ff    	ja     80100e2b <consoleintr+0x1b>
  if (panicked)
80100edc:	a1 98 0b 11 80       	mov    0x80110b98,%eax
        c = (c == '\r') ? '\n' : c;
80100ee1:	83 fb 0d             	cmp    $0xd,%ebx
80100ee4:	0f 84 1c 02 00 00    	je     80101106 <consoleintr+0x2f6>
  if (panicked)
80100eea:	85 c0                	test   %eax,%eax
80100eec:	0f 85 66 02 00 00    	jne    80101158 <consoleintr+0x348>
  if (c == BACKSPACE)
80100ef2:	81 fb 00 01 00 00    	cmp    $0x100,%ebx
80100ef8:	0f 84 00 03 00 00    	je     801011fe <consoleintr+0x3ee>
        if (c == '\n' || c == C('D') || isEnd)
80100efe:	83 fb 0a             	cmp    $0xa,%ebx
80100f01:	0f 94 c2             	sete   %dl
80100f04:	83 fb 04             	cmp    $0x4,%ebx
80100f07:	0f 94 c0             	sete   %al
80100f0a:	09 c2                	or     %eax,%edx
  else if (c < BACKSPACE)
80100f0c:	81 fb ff 00 00 00    	cmp    $0xff,%ebx
80100f12:	0f 8e fc 01 00 00    	jle    80101114 <consoleintr+0x304>
  cgaputc(c);
80100f18:	89 d8                	mov    %ebx,%eax
80100f1a:	e8 01 f5 ff ff       	call   80100420 <cgaputc>
        int isEnd = input.e == input.r + INPUT_BUF - 2;
80100f1f:	a1 d8 fe 10 80       	mov    0x8010fed8,%eax
80100f24:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100f27:	a1 d0 fe 10 80       	mov    0x8010fed0,%eax
80100f2c:	83 c0 4c             	add    $0x4c,%eax
        if (c == '\n' || c == C('D') || isEnd)
80100f2f:	39 45 e4             	cmp    %eax,-0x1c(%ebp)
80100f32:	0f 85 28 02 00 00    	jne    80101160 <consoleintr+0x350>
          SubmitCommand(isEnd ? '\n' : c);
80100f38:	bb 0a 00 00 00       	mov    $0xa,%ebx
80100f3d:	83 ec 0c             	sub    $0xc,%esp
80100f40:	53                   	push   %ebx
80100f41:	e8 6a fd ff ff       	call   80100cb0 <SubmitCommand>
80100f46:	83 c4 10             	add    $0x10,%esp
80100f49:	e9 dd fe ff ff       	jmp    80100e2b <consoleintr+0x1b>
  cgaputc(c);
80100f4e:	b8 01 01 00 00       	mov    $0x101,%eax
80100f53:	e8 c8 f4 ff ff       	call   80100420 <cgaputc>
  return input.e - input.w;
80100f58:	a1 d8 fe 10 80       	mov    0x8010fed8,%eax
80100f5d:	89 c2                	mov    %eax,%edx
80100f5f:	2b 15 d4 fe 10 80    	sub    0x8010fed4,%edx
  while (currentIndex() > 0)
80100f65:	85 d2                	test   %edx,%edx
80100f67:	0f 8e be fe ff ff    	jle    80100e2b <consoleintr+0x1b>
    input.e--;
80100f6d:	83 e8 01             	sub    $0x1,%eax
80100f70:	a3 d8 fe 10 80       	mov    %eax,0x8010fed8
  if (panicked)
80100f75:	a1 98 0b 11 80       	mov    0x80110b98,%eax
80100f7a:	85 c0                	test   %eax,%eax
80100f7c:	74 d0                	je     80100f4e <consoleintr+0x13e>
80100f7e:	fa                   	cli    
    for (;;)
80100f7f:	eb fe                	jmp    80100f7f <consoleintr+0x16f>
80100f81:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      KillLine();
80100f88:	e8 d3 fb ff ff       	call   80100b60 <KillLine>
      break;
80100f8d:	e9 99 fe ff ff       	jmp    80100e2b <consoleintr+0x1b>
      input.e = input.w;
80100f92:	a1 d4 fe 10 80       	mov    0x8010fed4,%eax
  if (panicked)
80100f97:	8b 0d 98 0b 11 80    	mov    0x80110b98,%ecx
      lineLength = 0;
80100f9d:	c7 05 54 0b 11 80 00 	movl   $0x0,0x80110b54
80100fa4:	00 00 00 
      input.e = input.w;
80100fa7:	a3 d8 fe 10 80       	mov    %eax,0x8010fed8
  if (panicked)
80100fac:	85 c9                	test   %ecx,%ecx
80100fae:	0f 84 07 01 00 00    	je     801010bb <consoleintr+0x2ab>
80100fb4:	fa                   	cli    
    for (;;)
80100fb5:	eb fe                	jmp    80100fb5 <consoleintr+0x1a5>
80100fb7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100fbe:	66 90                	xchg   %ax,%ax
  return input.e - input.w;
80100fc0:	a1 d8 fe 10 80       	mov    0x8010fed8,%eax
80100fc5:	89 c2                	mov    %eax,%edx
80100fc7:	2b 15 d4 fe 10 80    	sub    0x8010fed4,%edx
      if (currentIndex() < lineLength) //
80100fcd:	39 15 54 0b 11 80    	cmp    %edx,0x80110b54
80100fd3:	0f 8e 52 fe ff ff    	jle    80100e2b <consoleintr+0x1b>
        input.e++;
80100fd9:	83 c0 01             	add    $0x1,%eax
80100fdc:	a3 d8 fe 10 80       	mov    %eax,0x8010fed8
  if (panicked)
80100fe1:	a1 98 0b 11 80       	mov    0x80110b98,%eax
80100fe6:	85 c0                	test   %eax,%eax
80100fe8:	0f 84 09 01 00 00    	je     801010f7 <consoleintr+0x2e7>
80100fee:	fa                   	cli    
    for (;;)
80100fef:	eb fe                	jmp    80100fef <consoleintr+0x1df>
80100ff1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return input.e - input.w;
80100ff8:	a1 d8 fe 10 80       	mov    0x8010fed8,%eax
80100ffd:	89 c2                	mov    %eax,%edx
80100fff:	2b 15 d4 fe 10 80    	sub    0x8010fed4,%edx
  while (currentIndex() < lineLength)
80101005:	39 15 54 0b 11 80    	cmp    %edx,0x80110b54
8010100b:	0f 8e 1a fe ff ff    	jle    80100e2b <consoleintr+0x1b>
  if (panicked)
80101011:	8b 1d 98 0b 11 80    	mov    0x80110b98,%ebx
    input.e++;
80101017:	83 c0 01             	add    $0x1,%eax
8010101a:	a3 d8 fe 10 80       	mov    %eax,0x8010fed8
  if (panicked)
8010101f:	85 db                	test   %ebx,%ebx
80101021:	74 66                	je     80101089 <consoleintr+0x279>
80101023:	fa                   	cli    
    for (;;)
80101024:	eb fe                	jmp    80101024 <consoleintr+0x214>
80101026:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010102d:	8d 76 00             	lea    0x0(%esi),%esi
  return input.e - input.w;
80101030:	a1 d8 fe 10 80       	mov    0x8010fed8,%eax
80101035:	89 c2                	mov    %eax,%edx
80101037:	2b 15 d4 fe 10 80    	sub    0x8010fed4,%edx
      if (currentIndex() > 0) //
8010103d:	85 d2                	test   %edx,%edx
8010103f:	0f 8e e6 fd ff ff    	jle    80100e2b <consoleintr+0x1b>
  if (panicked)
80101045:	8b 15 98 0b 11 80    	mov    0x80110b98,%edx
        input.e--;
8010104b:	83 e8 01             	sub    $0x1,%eax
8010104e:	a3 d8 fe 10 80       	mov    %eax,0x8010fed8
  if (panicked)
80101053:	85 d2                	test   %edx,%edx
80101055:	0f 84 8d 00 00 00    	je     801010e8 <consoleintr+0x2d8>
8010105b:	fa                   	cli    
    for (;;)
8010105c:	eb fe                	jmp    8010105c <consoleintr+0x24c>
8010105e:	66 90                	xchg   %ax,%ax
      if (current < maxCommands - 1)
80101060:	a1 50 0b 11 80       	mov    0x80110b50,%eax
80101065:	8b 15 00 90 10 80    	mov    0x80109000,%edx
8010106b:	83 e8 01             	sub    $0x1,%eax
8010106e:	39 d0                	cmp    %edx,%eax
80101070:	0f 8e b5 fd ff ff    	jle    80100e2b <consoleintr+0x1b>
        current++;
80101076:	83 c2 01             	add    $0x1,%edx
80101079:	89 15 00 90 10 80    	mov    %edx,0x80109000
        Change();
8010107f:	e8 6c fb ff ff       	call   80100bf0 <Change>
80101084:	e9 a2 fd ff ff       	jmp    80100e2b <consoleintr+0x1b>
  cgaputc(c);
80101089:	b8 02 01 00 00       	mov    $0x102,%eax
8010108e:	e8 8d f3 ff ff       	call   80100420 <cgaputc>
  return input.e - input.w;
80101093:	a1 d8 fe 10 80       	mov    0x8010fed8,%eax
80101098:	89 c2                	mov    %eax,%edx
8010109a:	2b 15 d4 fe 10 80    	sub    0x8010fed4,%edx
  while (currentIndex() < lineLength)
801010a0:	3b 15 54 0b 11 80    	cmp    0x80110b54,%edx
801010a6:	0f 8c 65 ff ff ff    	jl     80101011 <consoleintr+0x201>
801010ac:	e9 7a fd ff ff       	jmp    80100e2b <consoleintr+0x1b>
    switch (c)
801010b1:	bf 01 00 00 00       	mov    $0x1,%edi
801010b6:	e9 70 fd ff ff       	jmp    80100e2b <consoleintr+0x1b>
  cgaputc(c);
801010bb:	b8 03 01 00 00       	mov    $0x103,%eax
801010c0:	e8 5b f3 ff ff       	call   80100420 <cgaputc>
}
801010c5:	e9 61 fd ff ff       	jmp    80100e2b <consoleintr+0x1b>
        current--;
801010ca:	83 e8 01             	sub    $0x1,%eax
801010cd:	a3 00 90 10 80       	mov    %eax,0x80109000
        Change();
801010d2:	e8 19 fb ff ff       	call   80100bf0 <Change>
801010d7:	e9 4f fd ff ff       	jmp    80100e2b <consoleintr+0x1b>
}
801010dc:	8d 65 f4             	lea    -0xc(%ebp),%esp
801010df:	5b                   	pop    %ebx
801010e0:	5e                   	pop    %esi
801010e1:	5f                   	pop    %edi
801010e2:	5d                   	pop    %ebp
    procdump(); // now call procdump() wo. cons.lock held
801010e3:	e9 c8 38 00 00       	jmp    801049b0 <procdump>
  cgaputc(c);
801010e8:	b8 01 01 00 00       	mov    $0x101,%eax
801010ed:	e8 2e f3 ff ff       	call   80100420 <cgaputc>
}
801010f2:	e9 34 fd ff ff       	jmp    80100e2b <consoleintr+0x1b>
  cgaputc(c);
801010f7:	b8 02 01 00 00       	mov    $0x102,%eax
801010fc:	e8 1f f3 ff ff       	call   80100420 <cgaputc>
}
80101101:	e9 25 fd ff ff       	jmp    80100e2b <consoleintr+0x1b>
  if (panicked)
80101106:	85 c0                	test   %eax,%eax
80101108:	75 4e                	jne    80101158 <consoleintr+0x348>
8010110a:	ba 01 00 00 00       	mov    $0x1,%edx
        c = (c == '\r') ? '\n' : c;
8010110f:	bb 0a 00 00 00       	mov    $0xa,%ebx
    uartputc(c);
80101114:	83 ec 0c             	sub    $0xc,%esp
80101117:	88 55 e0             	mov    %dl,-0x20(%ebp)
8010111a:	53                   	push   %ebx
8010111b:	e8 20 56 00 00       	call   80106740 <uartputc>
  cgaputc(c);
80101120:	89 d8                	mov    %ebx,%eax
80101122:	e8 f9 f2 ff ff       	call   80100420 <cgaputc>
        int isEnd = input.e == input.r + INPUT_BUF - 2;
80101127:	a1 d8 fe 10 80       	mov    0x8010fed8,%eax
        if (c == '\n' || c == C('D') || isEnd)
8010112c:	0f b6 55 e0          	movzbl -0x20(%ebp),%edx
80101130:	83 c4 10             	add    $0x10,%esp
        int isEnd = input.e == input.r + INPUT_BUF - 2;
80101133:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101136:	a1 d0 fe 10 80       	mov    0x8010fed0,%eax
8010113b:	83 c0 4c             	add    $0x4c,%eax
        if (c == '\n' || c == C('D') || isEnd)
8010113e:	84 d2                	test   %dl,%dl
80101140:	0f 84 e9 fd ff ff    	je     80100f2f <consoleintr+0x11f>
          SubmitCommand(isEnd ? '\n' : c);
80101146:	39 45 e4             	cmp    %eax,-0x1c(%ebp)
80101149:	0f 85 ee fd ff ff    	jne    80100f3d <consoleintr+0x12d>
8010114f:	e9 e4 fd ff ff       	jmp    80100f38 <consoleintr+0x128>
80101154:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101158:	fa                   	cli    
    for (;;)
80101159:	eb fe                	jmp    80101159 <consoleintr+0x349>
8010115b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010115f:	90                   	nop
          lineLength++;
80101160:	a1 54 0b 11 80       	mov    0x80110b54,%eax
80101165:	83 c0 01             	add    $0x1,%eax
80101168:	a3 54 0b 11 80       	mov    %eax,0x80110b54
          for (int i = input.w + lineLength; i > input.e; i--)
8010116d:	03 05 d4 fe 10 80    	add    0x8010fed4,%eax
80101173:	89 c1                	mov    %eax,%ecx
80101175:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
80101178:	76 59                	jbe    801011d3 <consoleintr+0x3c3>
8010117a:	89 7d e0             	mov    %edi,-0x20(%ebp)
8010117d:	89 5d dc             	mov    %ebx,-0x24(%ebp)
            input.buf[i % INPUT_BUF] = input.buf[(i - 1) % INPUT_BUF];
80101180:	89 cb                	mov    %ecx,%ebx
80101182:	b8 d3 20 0d d2       	mov    $0xd20d20d3,%eax
80101187:	83 e9 01             	sub    $0x1,%ecx
8010118a:	f7 e9                	imul   %ecx
8010118c:	89 cf                	mov    %ecx,%edi
8010118e:	c1 ff 1f             	sar    $0x1f,%edi
80101191:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
80101194:	89 ca                	mov    %ecx,%edx
80101196:	c1 f8 06             	sar    $0x6,%eax
80101199:	29 f8                	sub    %edi,%eax
8010119b:	6b c0 4e             	imul   $0x4e,%eax,%eax
8010119e:	29 c2                	sub    %eax,%edx
801011a0:	b8 d3 20 0d d2       	mov    $0xd20d20d3,%eax
801011a5:	0f b6 ba 80 fe 10 80 	movzbl -0x7fef0180(%edx),%edi
801011ac:	f7 eb                	imul   %ebx
801011ae:	8d 04 1a             	lea    (%edx,%ebx,1),%eax
801011b1:	89 da                	mov    %ebx,%edx
801011b3:	c1 f8 06             	sar    $0x6,%eax
801011b6:	c1 fa 1f             	sar    $0x1f,%edx
801011b9:	29 d0                	sub    %edx,%eax
801011bb:	6b c0 4e             	imul   $0x4e,%eax,%eax
801011be:	29 c3                	sub    %eax,%ebx
801011c0:	89 f8                	mov    %edi,%eax
801011c2:	88 83 80 fe 10 80    	mov    %al,-0x7fef0180(%ebx)
          for (int i = input.w + lineLength; i > input.e; i--)
801011c8:	3b 4d e4             	cmp    -0x1c(%ebp),%ecx
801011cb:	77 b3                	ja     80101180 <consoleintr+0x370>
801011cd:	8b 7d e0             	mov    -0x20(%ebp),%edi
801011d0:	8b 5d dc             	mov    -0x24(%ebp),%ebx
          input.buf[input.e++ % INPUT_BUF] = c;
801011d3:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801011d6:	8d 41 01             	lea    0x1(%ecx),%eax
801011d9:	89 ca                	mov    %ecx,%edx
801011db:	a3 d8 fe 10 80       	mov    %eax,0x8010fed8
801011e0:	d1 ea                	shr    %edx
801011e2:	b8 d3 20 0d d2       	mov    $0xd20d20d3,%eax
801011e7:	f7 e2                	mul    %edx
801011e9:	89 d0                	mov    %edx,%eax
801011eb:	c1 e8 05             	shr    $0x5,%eax
801011ee:	6b c0 4e             	imul   $0x4e,%eax,%eax
801011f1:	29 c1                	sub    %eax,%ecx
801011f3:	88 99 80 fe 10 80    	mov    %bl,-0x7fef0180(%ecx)
801011f9:	e9 2d fc ff ff       	jmp    80100e2b <consoleintr+0x1b>
    uartputc('\b');
801011fe:	83 ec 0c             	sub    $0xc,%esp
80101201:	6a 08                	push   $0x8
80101203:	e8 38 55 00 00       	call   80106740 <uartputc>
  cgaputc(c);
80101208:	b8 00 01 00 00       	mov    $0x100,%eax
8010120d:	e8 0e f2 ff ff       	call   80100420 <cgaputc>
        int isEnd = input.e == input.r + INPUT_BUF - 2;
80101212:	a1 d8 fe 10 80       	mov    0x8010fed8,%eax
80101217:	83 c4 10             	add    $0x10,%esp
8010121a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010121d:	a1 d0 fe 10 80       	mov    0x8010fed0,%eax
80101222:	83 c0 4c             	add    $0x4c,%eax
        if (c == '\n' || c == C('D') || isEnd)
80101225:	e9 05 fd ff ff       	jmp    80100f2f <consoleintr+0x11f>
8010122a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101230 <consoleinit>:

void consoleinit(void)
{
80101230:	55                   	push   %ebp
80101231:	89 e5                	mov    %esp,%ebp
80101233:	83 ec 10             	sub    $0x10,%esp
  initlock(&cons.lock, "console");
80101236:	68 88 7c 10 80       	push   $0x80107c88
8010123b:	68 60 0b 11 80       	push   $0x80110b60
80101240:	e8 5b 39 00 00       	call   80104ba0 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  ioapicenable(IRQ_KBD, 0);
80101245:	58                   	pop    %eax
80101246:	5a                   	pop    %edx
80101247:	6a 00                	push   $0x0
80101249:	6a 01                	push   $0x1
  devsw[CONSOLE].write = consolewrite;
8010124b:	c7 05 4c 15 11 80 20 	movl   $0x80100620,0x8011154c
80101252:	06 10 80 
  devsw[CONSOLE].read = consoleread;
80101255:	c7 05 48 15 11 80 80 	movl   $0x80100280,0x80111548
8010125c:	02 10 80 
  cons.locking = 1;
8010125f:	c7 05 94 0b 11 80 01 	movl   $0x1,0x80110b94
80101266:	00 00 00 
  ioapicenable(IRQ_KBD, 0);
80101269:	e8 e2 19 00 00       	call   80102c50 <ioapicenable>
}
8010126e:	83 c4 10             	add    $0x10,%esp
80101271:	c9                   	leave  
80101272:	c3                   	ret    
80101273:	66 90                	xchg   %ax,%ax
80101275:	66 90                	xchg   %ax,%ax
80101277:	66 90                	xchg   %ax,%ax
80101279:	66 90                	xchg   %ax,%ax
8010127b:	66 90                	xchg   %ax,%ax
8010127d:	66 90                	xchg   %ax,%ax
8010127f:	90                   	nop

80101280 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
80101280:	55                   	push   %ebp
80101281:	89 e5                	mov    %esp,%ebp
80101283:	57                   	push   %edi
80101284:	56                   	push   %esi
80101285:	53                   	push   %ebx
80101286:	81 ec 0c 01 00 00    	sub    $0x10c,%esp
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
8010128c:	e8 af 2e 00 00       	call   80104140 <myproc>
80101291:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)

  begin_op();
80101297:	e8 94 22 00 00       	call   80103530 <begin_op>

  if((ip = namei(path)) == 0){
8010129c:	83 ec 0c             	sub    $0xc,%esp
8010129f:	ff 75 08             	push   0x8(%ebp)
801012a2:	e8 c9 15 00 00       	call   80102870 <namei>
801012a7:	83 c4 10             	add    $0x10,%esp
801012aa:	85 c0                	test   %eax,%eax
801012ac:	0f 84 02 03 00 00    	je     801015b4 <exec+0x334>
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
801012b2:	83 ec 0c             	sub    $0xc,%esp
801012b5:	89 c3                	mov    %eax,%ebx
801012b7:	50                   	push   %eax
801012b8:	e8 93 0c 00 00       	call   80101f50 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
801012bd:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
801012c3:	6a 34                	push   $0x34
801012c5:	6a 00                	push   $0x0
801012c7:	50                   	push   %eax
801012c8:	53                   	push   %ebx
801012c9:	e8 92 0f 00 00       	call   80102260 <readi>
801012ce:	83 c4 20             	add    $0x20,%esp
801012d1:	83 f8 34             	cmp    $0x34,%eax
801012d4:	74 22                	je     801012f8 <exec+0x78>

 bad:
  if(pgdir)
    freevm(pgdir);
  if(ip){
    iunlockput(ip);
801012d6:	83 ec 0c             	sub    $0xc,%esp
801012d9:	53                   	push   %ebx
801012da:	e8 01 0f 00 00       	call   801021e0 <iunlockput>
    end_op();
801012df:	e8 bc 22 00 00       	call   801035a0 <end_op>
801012e4:	83 c4 10             	add    $0x10,%esp
  }
  return -1;
801012e7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801012ec:	8d 65 f4             	lea    -0xc(%ebp),%esp
801012ef:	5b                   	pop    %ebx
801012f0:	5e                   	pop    %esi
801012f1:	5f                   	pop    %edi
801012f2:	5d                   	pop    %ebp
801012f3:	c3                   	ret    
801012f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(elf.magic != ELF_MAGIC)
801012f8:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
801012ff:	45 4c 46 
80101302:	75 d2                	jne    801012d6 <exec+0x56>
  if((pgdir = setupkvm()) == 0)
80101304:	e8 c7 65 00 00       	call   801078d0 <setupkvm>
80101309:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)
8010130f:	85 c0                	test   %eax,%eax
80101311:	74 c3                	je     801012d6 <exec+0x56>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80101313:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
8010131a:	00 
8010131b:	8b b5 40 ff ff ff    	mov    -0xc0(%ebp),%esi
80101321:	0f 84 ac 02 00 00    	je     801015d3 <exec+0x353>
  sz = 0;
80101327:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
8010132e:	00 00 00 
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80101331:	31 ff                	xor    %edi,%edi
80101333:	e9 8e 00 00 00       	jmp    801013c6 <exec+0x146>
80101338:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010133f:	90                   	nop
    if(ph.type != ELF_PROG_LOAD)
80101340:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80101347:	75 6c                	jne    801013b5 <exec+0x135>
    if(ph.memsz < ph.filesz)
80101349:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
8010134f:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80101355:	0f 82 87 00 00 00    	jb     801013e2 <exec+0x162>
    if(ph.vaddr + ph.memsz < ph.vaddr)
8010135b:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80101361:	72 7f                	jb     801013e2 <exec+0x162>
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80101363:	83 ec 04             	sub    $0x4,%esp
80101366:	50                   	push   %eax
80101367:	ff b5 f0 fe ff ff    	push   -0x110(%ebp)
8010136d:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80101373:	e8 78 63 00 00       	call   801076f0 <allocuvm>
80101378:	83 c4 10             	add    $0x10,%esp
8010137b:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80101381:	85 c0                	test   %eax,%eax
80101383:	74 5d                	je     801013e2 <exec+0x162>
    if(ph.vaddr % PGSIZE != 0)
80101385:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
8010138b:	a9 ff 0f 00 00       	test   $0xfff,%eax
80101390:	75 50                	jne    801013e2 <exec+0x162>
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80101392:	83 ec 0c             	sub    $0xc,%esp
80101395:	ff b5 14 ff ff ff    	push   -0xec(%ebp)
8010139b:	ff b5 08 ff ff ff    	push   -0xf8(%ebp)
801013a1:	53                   	push   %ebx
801013a2:	50                   	push   %eax
801013a3:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
801013a9:	e8 52 62 00 00       	call   80107600 <loaduvm>
801013ae:	83 c4 20             	add    $0x20,%esp
801013b1:	85 c0                	test   %eax,%eax
801013b3:	78 2d                	js     801013e2 <exec+0x162>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
801013b5:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
801013bc:	83 c7 01             	add    $0x1,%edi
801013bf:	83 c6 20             	add    $0x20,%esi
801013c2:	39 f8                	cmp    %edi,%eax
801013c4:	7e 3a                	jle    80101400 <exec+0x180>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
801013c6:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
801013cc:	6a 20                	push   $0x20
801013ce:	56                   	push   %esi
801013cf:	50                   	push   %eax
801013d0:	53                   	push   %ebx
801013d1:	e8 8a 0e 00 00       	call   80102260 <readi>
801013d6:	83 c4 10             	add    $0x10,%esp
801013d9:	83 f8 20             	cmp    $0x20,%eax
801013dc:	0f 84 5e ff ff ff    	je     80101340 <exec+0xc0>
    freevm(pgdir);
801013e2:	83 ec 0c             	sub    $0xc,%esp
801013e5:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
801013eb:	e8 60 64 00 00       	call   80107850 <freevm>
  if(ip){
801013f0:	83 c4 10             	add    $0x10,%esp
801013f3:	e9 de fe ff ff       	jmp    801012d6 <exec+0x56>
801013f8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801013ff:	90                   	nop
  sz = PGROUNDUP(sz);
80101400:	8b bd f0 fe ff ff    	mov    -0x110(%ebp),%edi
80101406:	81 c7 ff 0f 00 00    	add    $0xfff,%edi
8010140c:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80101412:	8d b7 00 20 00 00    	lea    0x2000(%edi),%esi
  iunlockput(ip);
80101418:	83 ec 0c             	sub    $0xc,%esp
8010141b:	53                   	push   %ebx
8010141c:	e8 bf 0d 00 00       	call   801021e0 <iunlockput>
  end_op();
80101421:	e8 7a 21 00 00       	call   801035a0 <end_op>
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80101426:	83 c4 0c             	add    $0xc,%esp
80101429:	56                   	push   %esi
8010142a:	57                   	push   %edi
8010142b:	8b bd f4 fe ff ff    	mov    -0x10c(%ebp),%edi
80101431:	57                   	push   %edi
80101432:	e8 b9 62 00 00       	call   801076f0 <allocuvm>
80101437:	83 c4 10             	add    $0x10,%esp
8010143a:	89 c6                	mov    %eax,%esi
8010143c:	85 c0                	test   %eax,%eax
8010143e:	0f 84 94 00 00 00    	je     801014d8 <exec+0x258>
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80101444:	83 ec 08             	sub    $0x8,%esp
80101447:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
  for(argc = 0; argv[argc]; argc++) {
8010144d:	89 f3                	mov    %esi,%ebx
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
8010144f:	50                   	push   %eax
80101450:	57                   	push   %edi
  for(argc = 0; argv[argc]; argc++) {
80101451:	31 ff                	xor    %edi,%edi
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80101453:	e8 18 65 00 00       	call   80107970 <clearpteu>
  for(argc = 0; argv[argc]; argc++) {
80101458:	8b 45 0c             	mov    0xc(%ebp),%eax
8010145b:	83 c4 10             	add    $0x10,%esp
8010145e:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
80101464:	8b 00                	mov    (%eax),%eax
80101466:	85 c0                	test   %eax,%eax
80101468:	0f 84 8b 00 00 00    	je     801014f9 <exec+0x279>
8010146e:	89 b5 f0 fe ff ff    	mov    %esi,-0x110(%ebp)
80101474:	8b b5 f4 fe ff ff    	mov    -0x10c(%ebp),%esi
8010147a:	eb 23                	jmp    8010149f <exec+0x21f>
8010147c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101480:	8b 45 0c             	mov    0xc(%ebp),%eax
    ustack[3+argc] = sp;
80101483:	89 9c bd 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%edi,4)
  for(argc = 0; argv[argc]; argc++) {
8010148a:	83 c7 01             	add    $0x1,%edi
    ustack[3+argc] = sp;
8010148d:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
  for(argc = 0; argv[argc]; argc++) {
80101493:	8b 04 b8             	mov    (%eax,%edi,4),%eax
80101496:	85 c0                	test   %eax,%eax
80101498:	74 59                	je     801014f3 <exec+0x273>
    if(argc >= MAXARG)
8010149a:	83 ff 20             	cmp    $0x20,%edi
8010149d:	74 39                	je     801014d8 <exec+0x258>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
8010149f:	83 ec 0c             	sub    $0xc,%esp
801014a2:	50                   	push   %eax
801014a3:	e8 88 3b 00 00       	call   80105030 <strlen>
801014a8:	29 c3                	sub    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
801014aa:	58                   	pop    %eax
801014ab:	8b 45 0c             	mov    0xc(%ebp),%eax
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
801014ae:	83 eb 01             	sub    $0x1,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
801014b1:	ff 34 b8             	push   (%eax,%edi,4)
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
801014b4:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
801014b7:	e8 74 3b 00 00       	call   80105030 <strlen>
801014bc:	83 c0 01             	add    $0x1,%eax
801014bf:	50                   	push   %eax
801014c0:	8b 45 0c             	mov    0xc(%ebp),%eax
801014c3:	ff 34 b8             	push   (%eax,%edi,4)
801014c6:	53                   	push   %ebx
801014c7:	56                   	push   %esi
801014c8:	e8 73 66 00 00       	call   80107b40 <copyout>
801014cd:	83 c4 20             	add    $0x20,%esp
801014d0:	85 c0                	test   %eax,%eax
801014d2:	79 ac                	jns    80101480 <exec+0x200>
801014d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    freevm(pgdir);
801014d8:	83 ec 0c             	sub    $0xc,%esp
801014db:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
801014e1:	e8 6a 63 00 00       	call   80107850 <freevm>
801014e6:	83 c4 10             	add    $0x10,%esp
  return -1;
801014e9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801014ee:	e9 f9 fd ff ff       	jmp    801012ec <exec+0x6c>
801014f3:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
  ustack[2] = sp - (argc+1)*4;  // argv pointer
801014f9:	8d 04 bd 04 00 00 00 	lea    0x4(,%edi,4),%eax
80101500:	89 d9                	mov    %ebx,%ecx
  ustack[3+argc] = 0;
80101502:	c7 84 bd 64 ff ff ff 	movl   $0x0,-0x9c(%ebp,%edi,4)
80101509:	00 00 00 00 
  ustack[2] = sp - (argc+1)*4;  // argv pointer
8010150d:	29 c1                	sub    %eax,%ecx
  sp -= (3+argc+1) * 4;
8010150f:	83 c0 0c             	add    $0xc,%eax
  ustack[1] = argc;
80101512:	89 bd 5c ff ff ff    	mov    %edi,-0xa4(%ebp)
  sp -= (3+argc+1) * 4;
80101518:	29 c3                	sub    %eax,%ebx
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
8010151a:	50                   	push   %eax
8010151b:	52                   	push   %edx
8010151c:	53                   	push   %ebx
8010151d:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
  ustack[0] = 0xffffffff;  // fake return PC
80101523:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
8010152a:	ff ff ff 
  ustack[2] = sp - (argc+1)*4;  // argv pointer
8010152d:	89 8d 60 ff ff ff    	mov    %ecx,-0xa0(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80101533:	e8 08 66 00 00       	call   80107b40 <copyout>
80101538:	83 c4 10             	add    $0x10,%esp
8010153b:	85 c0                	test   %eax,%eax
8010153d:	78 99                	js     801014d8 <exec+0x258>
  for(last=s=path; *s; s++)
8010153f:	8b 45 08             	mov    0x8(%ebp),%eax
80101542:	8b 55 08             	mov    0x8(%ebp),%edx
80101545:	0f b6 00             	movzbl (%eax),%eax
80101548:	84 c0                	test   %al,%al
8010154a:	74 13                	je     8010155f <exec+0x2df>
8010154c:	89 d1                	mov    %edx,%ecx
8010154e:	66 90                	xchg   %ax,%ax
      last = s+1;
80101550:	83 c1 01             	add    $0x1,%ecx
80101553:	3c 2f                	cmp    $0x2f,%al
  for(last=s=path; *s; s++)
80101555:	0f b6 01             	movzbl (%ecx),%eax
      last = s+1;
80101558:	0f 44 d1             	cmove  %ecx,%edx
  for(last=s=path; *s; s++)
8010155b:	84 c0                	test   %al,%al
8010155d:	75 f1                	jne    80101550 <exec+0x2d0>
  safestrcpy(curproc->name, last, sizeof(curproc->name));
8010155f:	8b bd ec fe ff ff    	mov    -0x114(%ebp),%edi
80101565:	83 ec 04             	sub    $0x4,%esp
80101568:	6a 10                	push   $0x10
8010156a:	89 f8                	mov    %edi,%eax
8010156c:	52                   	push   %edx
8010156d:	83 c0 6c             	add    $0x6c,%eax
80101570:	50                   	push   %eax
80101571:	e8 7a 3a 00 00       	call   80104ff0 <safestrcpy>
  curproc->pgdir = pgdir;
80101576:	8b 8d f4 fe ff ff    	mov    -0x10c(%ebp),%ecx
  oldpgdir = curproc->pgdir;
8010157c:	89 f8                	mov    %edi,%eax
8010157e:	8b 7f 04             	mov    0x4(%edi),%edi
  curproc->sz = sz;
80101581:	89 30                	mov    %esi,(%eax)
  curproc->pgdir = pgdir;
80101583:	89 48 04             	mov    %ecx,0x4(%eax)
  curproc->tf->eip = elf.entry;  // main
80101586:	89 c1                	mov    %eax,%ecx
80101588:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
8010158e:	8b 40 18             	mov    0x18(%eax),%eax
80101591:	89 50 38             	mov    %edx,0x38(%eax)
  curproc->tf->esp = sp;
80101594:	8b 41 18             	mov    0x18(%ecx),%eax
80101597:	89 58 44             	mov    %ebx,0x44(%eax)
  switchuvm(curproc);
8010159a:	89 0c 24             	mov    %ecx,(%esp)
8010159d:	e8 ce 5e 00 00       	call   80107470 <switchuvm>
  freevm(oldpgdir);
801015a2:	89 3c 24             	mov    %edi,(%esp)
801015a5:	e8 a6 62 00 00       	call   80107850 <freevm>
  return 0;
801015aa:	83 c4 10             	add    $0x10,%esp
801015ad:	31 c0                	xor    %eax,%eax
801015af:	e9 38 fd ff ff       	jmp    801012ec <exec+0x6c>
    end_op();
801015b4:	e8 e7 1f 00 00       	call   801035a0 <end_op>
    cprintf("exec: fail\n");
801015b9:	83 ec 0c             	sub    $0xc,%esp
801015bc:	68 f9 7c 10 80       	push   $0x80107cf9
801015c1:	e8 8a f1 ff ff       	call   80100750 <cprintf>
    return -1;
801015c6:	83 c4 10             	add    $0x10,%esp
801015c9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801015ce:	e9 19 fd ff ff       	jmp    801012ec <exec+0x6c>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
801015d3:	be 00 20 00 00       	mov    $0x2000,%esi
801015d8:	31 ff                	xor    %edi,%edi
801015da:	e9 39 fe ff ff       	jmp    80101418 <exec+0x198>
801015df:	90                   	nop

801015e0 <fileinit>:
  struct spinlock lock;
  struct file file[NFILE];
} ftable;

void fileinit(void)
{
801015e0:	55                   	push   %ebp
801015e1:	89 e5                	mov    %esp,%ebp
801015e3:	83 ec 10             	sub    $0x10,%esp
  initlock(&ftable.lock, "ftable");
801015e6:	68 05 7d 10 80       	push   $0x80107d05
801015eb:	68 a0 0b 11 80       	push   $0x80110ba0
801015f0:	e8 ab 35 00 00       	call   80104ba0 <initlock>
}
801015f5:	83 c4 10             	add    $0x10,%esp
801015f8:	c9                   	leave  
801015f9:	c3                   	ret    
801015fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101600 <filealloc>:

// Allocate a file structure.
struct file *filealloc(void)
{
80101600:	55                   	push   %ebp
80101601:	89 e5                	mov    %esp,%ebp
80101603:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for (f = ftable.file; f < ftable.file + NFILE; f++)
80101604:	bb d4 0b 11 80       	mov    $0x80110bd4,%ebx
{
80101609:	83 ec 10             	sub    $0x10,%esp
  acquire(&ftable.lock);
8010160c:	68 a0 0b 11 80       	push   $0x80110ba0
80101611:	e8 5a 37 00 00       	call   80104d70 <acquire>
80101616:	83 c4 10             	add    $0x10,%esp
80101619:	eb 10                	jmp    8010162b <filealloc+0x2b>
8010161b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010161f:	90                   	nop
  for (f = ftable.file; f < ftable.file + NFILE; f++)
80101620:	83 c3 18             	add    $0x18,%ebx
80101623:	81 fb 34 15 11 80    	cmp    $0x80111534,%ebx
80101629:	74 25                	je     80101650 <filealloc+0x50>
  {
    if (f->ref == 0)
8010162b:	8b 43 04             	mov    0x4(%ebx),%eax
8010162e:	85 c0                	test   %eax,%eax
80101630:	75 ee                	jne    80101620 <filealloc+0x20>
    {
      f->ref = 1;
      release(&ftable.lock);
80101632:	83 ec 0c             	sub    $0xc,%esp
      f->ref = 1;
80101635:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
8010163c:	68 a0 0b 11 80       	push   $0x80110ba0
80101641:	e8 ca 36 00 00       	call   80104d10 <release>
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
}
80101646:	89 d8                	mov    %ebx,%eax
      return f;
80101648:	83 c4 10             	add    $0x10,%esp
}
8010164b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010164e:	c9                   	leave  
8010164f:	c3                   	ret    
  release(&ftable.lock);
80101650:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80101653:	31 db                	xor    %ebx,%ebx
  release(&ftable.lock);
80101655:	68 a0 0b 11 80       	push   $0x80110ba0
8010165a:	e8 b1 36 00 00       	call   80104d10 <release>
}
8010165f:	89 d8                	mov    %ebx,%eax
  return 0;
80101661:	83 c4 10             	add    $0x10,%esp
}
80101664:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101667:	c9                   	leave  
80101668:	c3                   	ret    
80101669:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101670 <filedup>:

// Increment ref count for file f.
struct file *
filedup(struct file *f)
{
80101670:	55                   	push   %ebp
80101671:	89 e5                	mov    %esp,%ebp
80101673:	53                   	push   %ebx
80101674:	83 ec 10             	sub    $0x10,%esp
80101677:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
8010167a:	68 a0 0b 11 80       	push   $0x80110ba0
8010167f:	e8 ec 36 00 00       	call   80104d70 <acquire>
  if (f->ref < 1)
80101684:	8b 43 04             	mov    0x4(%ebx),%eax
80101687:	83 c4 10             	add    $0x10,%esp
8010168a:	85 c0                	test   %eax,%eax
8010168c:	7e 1a                	jle    801016a8 <filedup+0x38>
    panic("filedup");
  f->ref++;
8010168e:	83 c0 01             	add    $0x1,%eax
  release(&ftable.lock);
80101691:	83 ec 0c             	sub    $0xc,%esp
  f->ref++;
80101694:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80101697:	68 a0 0b 11 80       	push   $0x80110ba0
8010169c:	e8 6f 36 00 00       	call   80104d10 <release>
  return f;
}
801016a1:	89 d8                	mov    %ebx,%eax
801016a3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801016a6:	c9                   	leave  
801016a7:	c3                   	ret    
    panic("filedup");
801016a8:	83 ec 0c             	sub    $0xc,%esp
801016ab:	68 0c 7d 10 80       	push   $0x80107d0c
801016b0:	e8 eb ec ff ff       	call   801003a0 <panic>
801016b5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801016bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801016c0 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void fileclose(struct file *f)
{
801016c0:	55                   	push   %ebp
801016c1:	89 e5                	mov    %esp,%ebp
801016c3:	57                   	push   %edi
801016c4:	56                   	push   %esi
801016c5:	53                   	push   %ebx
801016c6:	83 ec 28             	sub    $0x28,%esp
801016c9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct file ff;

  acquire(&ftable.lock);
801016cc:	68 a0 0b 11 80       	push   $0x80110ba0
801016d1:	e8 9a 36 00 00       	call   80104d70 <acquire>
  if (f->ref < 1)
801016d6:	8b 53 04             	mov    0x4(%ebx),%edx
801016d9:	83 c4 10             	add    $0x10,%esp
801016dc:	85 d2                	test   %edx,%edx
801016de:	0f 8e a5 00 00 00    	jle    80101789 <fileclose+0xc9>
    panic("fileclose");
  if (--f->ref > 0)
801016e4:	83 ea 01             	sub    $0x1,%edx
801016e7:	89 53 04             	mov    %edx,0x4(%ebx)
801016ea:	75 44                	jne    80101730 <fileclose+0x70>
  {
    release(&ftable.lock);
    return;
  }
  ff = *f;
801016ec:	0f b6 43 09          	movzbl 0x9(%ebx),%eax
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
801016f0:	83 ec 0c             	sub    $0xc,%esp
  ff = *f;
801016f3:	8b 3b                	mov    (%ebx),%edi
  f->type = FD_NONE;
801016f5:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  ff = *f;
801016fb:	8b 73 0c             	mov    0xc(%ebx),%esi
801016fe:	88 45 e7             	mov    %al,-0x19(%ebp)
80101701:	8b 43 10             	mov    0x10(%ebx),%eax
  release(&ftable.lock);
80101704:	68 a0 0b 11 80       	push   $0x80110ba0
  ff = *f;
80101709:	89 45 e0             	mov    %eax,-0x20(%ebp)
  release(&ftable.lock);
8010170c:	e8 ff 35 00 00       	call   80104d10 <release>

  if (ff.type == FD_PIPE)
80101711:	83 c4 10             	add    $0x10,%esp
80101714:	83 ff 01             	cmp    $0x1,%edi
80101717:	74 57                	je     80101770 <fileclose+0xb0>
    pipeclose(ff.pipe, ff.writable);
  else if (ff.type == FD_INODE)
80101719:	83 ff 02             	cmp    $0x2,%edi
8010171c:	74 2a                	je     80101748 <fileclose+0x88>
  {
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
8010171e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101721:	5b                   	pop    %ebx
80101722:	5e                   	pop    %esi
80101723:	5f                   	pop    %edi
80101724:	5d                   	pop    %ebp
80101725:	c3                   	ret    
80101726:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010172d:	8d 76 00             	lea    0x0(%esi),%esi
    release(&ftable.lock);
80101730:	c7 45 08 a0 0b 11 80 	movl   $0x80110ba0,0x8(%ebp)
}
80101737:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010173a:	5b                   	pop    %ebx
8010173b:	5e                   	pop    %esi
8010173c:	5f                   	pop    %edi
8010173d:	5d                   	pop    %ebp
    release(&ftable.lock);
8010173e:	e9 cd 35 00 00       	jmp    80104d10 <release>
80101743:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101747:	90                   	nop
    begin_op();
80101748:	e8 e3 1d 00 00       	call   80103530 <begin_op>
    iput(ff.ip);
8010174d:	83 ec 0c             	sub    $0xc,%esp
80101750:	ff 75 e0             	push   -0x20(%ebp)
80101753:	e8 28 09 00 00       	call   80102080 <iput>
    end_op();
80101758:	83 c4 10             	add    $0x10,%esp
}
8010175b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010175e:	5b                   	pop    %ebx
8010175f:	5e                   	pop    %esi
80101760:	5f                   	pop    %edi
80101761:	5d                   	pop    %ebp
    end_op();
80101762:	e9 39 1e 00 00       	jmp    801035a0 <end_op>
80101767:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010176e:	66 90                	xchg   %ax,%ax
    pipeclose(ff.pipe, ff.writable);
80101770:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
80101774:	83 ec 08             	sub    $0x8,%esp
80101777:	53                   	push   %ebx
80101778:	56                   	push   %esi
80101779:	e8 82 25 00 00       	call   80103d00 <pipeclose>
8010177e:	83 c4 10             	add    $0x10,%esp
}
80101781:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101784:	5b                   	pop    %ebx
80101785:	5e                   	pop    %esi
80101786:	5f                   	pop    %edi
80101787:	5d                   	pop    %ebp
80101788:	c3                   	ret    
    panic("fileclose");
80101789:	83 ec 0c             	sub    $0xc,%esp
8010178c:	68 14 7d 10 80       	push   $0x80107d14
80101791:	e8 0a ec ff ff       	call   801003a0 <panic>
80101796:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010179d:	8d 76 00             	lea    0x0(%esi),%esi

801017a0 <filestat>:

// Get metadata about file f.
int filestat(struct file *f, struct stat *st)
{
801017a0:	55                   	push   %ebp
801017a1:	89 e5                	mov    %esp,%ebp
801017a3:	53                   	push   %ebx
801017a4:	83 ec 04             	sub    $0x4,%esp
801017a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (f->type == FD_INODE)
801017aa:	83 3b 02             	cmpl   $0x2,(%ebx)
801017ad:	75 31                	jne    801017e0 <filestat+0x40>
  {
    ilock(f->ip);
801017af:	83 ec 0c             	sub    $0xc,%esp
801017b2:	ff 73 10             	push   0x10(%ebx)
801017b5:	e8 96 07 00 00       	call   80101f50 <ilock>
    stati(f->ip, st);
801017ba:	58                   	pop    %eax
801017bb:	5a                   	pop    %edx
801017bc:	ff 75 0c             	push   0xc(%ebp)
801017bf:	ff 73 10             	push   0x10(%ebx)
801017c2:	e8 69 0a 00 00       	call   80102230 <stati>
    iunlock(f->ip);
801017c7:	59                   	pop    %ecx
801017c8:	ff 73 10             	push   0x10(%ebx)
801017cb:	e8 60 08 00 00       	call   80102030 <iunlock>
    return 0;
  }
  return -1;
}
801017d0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return 0;
801017d3:	83 c4 10             	add    $0x10,%esp
801017d6:	31 c0                	xor    %eax,%eax
}
801017d8:	c9                   	leave  
801017d9:	c3                   	ret    
801017da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801017e0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return -1;
801017e3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801017e8:	c9                   	leave  
801017e9:	c3                   	ret    
801017ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801017f0 <fileread>:

// Read from file f.
int fileread(struct file *f, char *addr, int n)
{
801017f0:	55                   	push   %ebp
801017f1:	89 e5                	mov    %esp,%ebp
801017f3:	57                   	push   %edi
801017f4:	56                   	push   %esi
801017f5:	53                   	push   %ebx
801017f6:	83 ec 0c             	sub    $0xc,%esp
801017f9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801017fc:	8b 75 0c             	mov    0xc(%ebp),%esi
801017ff:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if (f->readable == 0)
80101802:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
80101806:	74 60                	je     80101868 <fileread+0x78>
    return -1;
  if (f->type == FD_PIPE)
80101808:	8b 03                	mov    (%ebx),%eax
8010180a:	83 f8 01             	cmp    $0x1,%eax
8010180d:	74 41                	je     80101850 <fileread+0x60>
    return piperead(f->pipe, addr, n);
  if (f->type == FD_INODE)
8010180f:	83 f8 02             	cmp    $0x2,%eax
80101812:	75 5b                	jne    8010186f <fileread+0x7f>
  {
    ilock(f->ip);
80101814:	83 ec 0c             	sub    $0xc,%esp
80101817:	ff 73 10             	push   0x10(%ebx)
8010181a:	e8 31 07 00 00       	call   80101f50 <ilock>
    if ((r = readi(f->ip, addr, f->off, n)) > 0)
8010181f:	57                   	push   %edi
80101820:	ff 73 14             	push   0x14(%ebx)
80101823:	56                   	push   %esi
80101824:	ff 73 10             	push   0x10(%ebx)
80101827:	e8 34 0a 00 00       	call   80102260 <readi>
8010182c:	83 c4 20             	add    $0x20,%esp
8010182f:	89 c6                	mov    %eax,%esi
80101831:	85 c0                	test   %eax,%eax
80101833:	7e 03                	jle    80101838 <fileread+0x48>
      f->off += r;
80101835:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
80101838:	83 ec 0c             	sub    $0xc,%esp
8010183b:	ff 73 10             	push   0x10(%ebx)
8010183e:	e8 ed 07 00 00       	call   80102030 <iunlock>
    return r;
80101843:	83 c4 10             	add    $0x10,%esp
  }
  panic("fileread");
}
80101846:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101849:	89 f0                	mov    %esi,%eax
8010184b:	5b                   	pop    %ebx
8010184c:	5e                   	pop    %esi
8010184d:	5f                   	pop    %edi
8010184e:	5d                   	pop    %ebp
8010184f:	c3                   	ret    
    return piperead(f->pipe, addr, n);
80101850:	8b 43 0c             	mov    0xc(%ebx),%eax
80101853:	89 45 08             	mov    %eax,0x8(%ebp)
}
80101856:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101859:	5b                   	pop    %ebx
8010185a:	5e                   	pop    %esi
8010185b:	5f                   	pop    %edi
8010185c:	5d                   	pop    %ebp
    return piperead(f->pipe, addr, n);
8010185d:	e9 3e 26 00 00       	jmp    80103ea0 <piperead>
80101862:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80101868:	be ff ff ff ff       	mov    $0xffffffff,%esi
8010186d:	eb d7                	jmp    80101846 <fileread+0x56>
  panic("fileread");
8010186f:	83 ec 0c             	sub    $0xc,%esp
80101872:	68 1e 7d 10 80       	push   $0x80107d1e
80101877:	e8 24 eb ff ff       	call   801003a0 <panic>
8010187c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101880 <filewrite>:

// PAGEBREAK!
//  Write to file f.
int filewrite(struct file *f, char *addr, int n)
{
80101880:	55                   	push   %ebp
80101881:	89 e5                	mov    %esp,%ebp
80101883:	57                   	push   %edi
80101884:	56                   	push   %esi
80101885:	53                   	push   %ebx
80101886:	83 ec 1c             	sub    $0x1c,%esp
80101889:	8b 45 0c             	mov    0xc(%ebp),%eax
8010188c:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010188f:	89 45 dc             	mov    %eax,-0x24(%ebp)
80101892:	8b 45 10             	mov    0x10(%ebp),%eax
  int r;

  if (f->writable == 0)
80101895:	80 7b 09 00          	cmpb   $0x0,0x9(%ebx)
{
80101899:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if (f->writable == 0)
8010189c:	0f 84 bd 00 00 00    	je     8010195f <filewrite+0xdf>
    return -1;
  if (f->type == FD_PIPE)
801018a2:	8b 03                	mov    (%ebx),%eax
801018a4:	83 f8 01             	cmp    $0x1,%eax
801018a7:	0f 84 bf 00 00 00    	je     8010196c <filewrite+0xec>
    return pipewrite(f->pipe, addr, n);
  if (f->type == FD_INODE)
801018ad:	83 f8 02             	cmp    $0x2,%eax
801018b0:	0f 85 c8 00 00 00    	jne    8010197e <filewrite+0xfe>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS - 1 - 1 - 2) / 2) * 512;
    int i = 0;
    while (i < n)
801018b6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    int i = 0;
801018b9:	31 f6                	xor    %esi,%esi
    while (i < n)
801018bb:	85 c0                	test   %eax,%eax
801018bd:	7f 30                	jg     801018ef <filewrite+0x6f>
801018bf:	e9 94 00 00 00       	jmp    80101958 <filewrite+0xd8>
801018c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
801018c8:	01 43 14             	add    %eax,0x14(%ebx)
      iunlock(f->ip);
801018cb:	83 ec 0c             	sub    $0xc,%esp
801018ce:	ff 73 10             	push   0x10(%ebx)
        f->off += r;
801018d1:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
801018d4:	e8 57 07 00 00       	call   80102030 <iunlock>
      end_op();
801018d9:	e8 c2 1c 00 00       	call   801035a0 <end_op>

      if (r < 0)
        break;
      if (r != n1)
801018de:	8b 45 e0             	mov    -0x20(%ebp),%eax
801018e1:	83 c4 10             	add    $0x10,%esp
801018e4:	39 c7                	cmp    %eax,%edi
801018e6:	75 5c                	jne    80101944 <filewrite+0xc4>
        panic("short filewrite");
      i += r;
801018e8:	01 fe                	add    %edi,%esi
    while (i < n)
801018ea:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
801018ed:	7e 69                	jle    80101958 <filewrite+0xd8>
      int n1 = n - i;
801018ef:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801018f2:	b8 00 06 00 00       	mov    $0x600,%eax
801018f7:	29 f7                	sub    %esi,%edi
801018f9:	39 c7                	cmp    %eax,%edi
801018fb:	0f 4f f8             	cmovg  %eax,%edi
      begin_op();
801018fe:	e8 2d 1c 00 00       	call   80103530 <begin_op>
      ilock(f->ip);
80101903:	83 ec 0c             	sub    $0xc,%esp
80101906:	ff 73 10             	push   0x10(%ebx)
80101909:	e8 42 06 00 00       	call   80101f50 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
8010190e:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101911:	57                   	push   %edi
80101912:	ff 73 14             	push   0x14(%ebx)
80101915:	01 f0                	add    %esi,%eax
80101917:	50                   	push   %eax
80101918:	ff 73 10             	push   0x10(%ebx)
8010191b:	e8 40 0a 00 00       	call   80102360 <writei>
80101920:	83 c4 20             	add    $0x20,%esp
80101923:	85 c0                	test   %eax,%eax
80101925:	7f a1                	jg     801018c8 <filewrite+0x48>
      iunlock(f->ip);
80101927:	83 ec 0c             	sub    $0xc,%esp
8010192a:	ff 73 10             	push   0x10(%ebx)
8010192d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101930:	e8 fb 06 00 00       	call   80102030 <iunlock>
      end_op();
80101935:	e8 66 1c 00 00       	call   801035a0 <end_op>
      if (r < 0)
8010193a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010193d:	83 c4 10             	add    $0x10,%esp
80101940:	85 c0                	test   %eax,%eax
80101942:	75 1b                	jne    8010195f <filewrite+0xdf>
        panic("short filewrite");
80101944:	83 ec 0c             	sub    $0xc,%esp
80101947:	68 27 7d 10 80       	push   $0x80107d27
8010194c:	e8 4f ea ff ff       	call   801003a0 <panic>
80101951:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    }
    return i == n ? n : -1;
80101958:	89 f0                	mov    %esi,%eax
8010195a:	3b 75 e4             	cmp    -0x1c(%ebp),%esi
8010195d:	74 05                	je     80101964 <filewrite+0xe4>
8010195f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  panic("filewrite");
}
80101964:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101967:	5b                   	pop    %ebx
80101968:	5e                   	pop    %esi
80101969:	5f                   	pop    %edi
8010196a:	5d                   	pop    %ebp
8010196b:	c3                   	ret    
    return pipewrite(f->pipe, addr, n);
8010196c:	8b 43 0c             	mov    0xc(%ebx),%eax
8010196f:	89 45 08             	mov    %eax,0x8(%ebp)
}
80101972:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101975:	5b                   	pop    %ebx
80101976:	5e                   	pop    %esi
80101977:	5f                   	pop    %edi
80101978:	5d                   	pop    %ebp
    return pipewrite(f->pipe, addr, n);
80101979:	e9 22 24 00 00       	jmp    80103da0 <pipewrite>
  panic("filewrite");
8010197e:	83 ec 0c             	sub    $0xc,%esp
80101981:	68 2d 7d 10 80       	push   $0x80107d2d
80101986:	e8 15 ea ff ff       	call   801003a0 <panic>
8010198b:	66 90                	xchg   %ax,%ax
8010198d:	66 90                	xchg   %ax,%ax
8010198f:	90                   	nop

80101990 <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
80101990:	55                   	push   %ebp
80101991:	89 c1                	mov    %eax,%ecx
  struct buf *bp;
  int bi, m;

  bp = bread(dev, BBLOCK(b, sb));
80101993:	89 d0                	mov    %edx,%eax
80101995:	c1 e8 0c             	shr    $0xc,%eax
80101998:	03 05 0c 32 11 80    	add    0x8011320c,%eax
{
8010199e:	89 e5                	mov    %esp,%ebp
801019a0:	56                   	push   %esi
801019a1:	53                   	push   %ebx
801019a2:	89 d3                	mov    %edx,%ebx
  bp = bread(dev, BBLOCK(b, sb));
801019a4:	83 ec 08             	sub    $0x8,%esp
801019a7:	50                   	push   %eax
801019a8:	51                   	push   %ecx
801019a9:	e8 22 e7 ff ff       	call   801000d0 <bread>
  bi = b % BPB;
  m = 1 << (bi % 8);
801019ae:	89 d9                	mov    %ebx,%ecx
  if ((bp->data[bi / 8] & m) == 0)
801019b0:	c1 fb 03             	sar    $0x3,%ebx
801019b3:	83 c4 10             	add    $0x10,%esp
  bp = bread(dev, BBLOCK(b, sb));
801019b6:	89 c6                	mov    %eax,%esi
  m = 1 << (bi % 8);
801019b8:	83 e1 07             	and    $0x7,%ecx
801019bb:	b8 01 00 00 00       	mov    $0x1,%eax
  if ((bp->data[bi / 8] & m) == 0)
801019c0:	81 e3 ff 01 00 00    	and    $0x1ff,%ebx
  m = 1 << (bi % 8);
801019c6:	d3 e0                	shl    %cl,%eax
  if ((bp->data[bi / 8] & m) == 0)
801019c8:	0f b6 4c 1e 5c       	movzbl 0x5c(%esi,%ebx,1),%ecx
801019cd:	85 c1                	test   %eax,%ecx
801019cf:	74 23                	je     801019f4 <bfree+0x64>
    panic("freeing free block");
  bp->data[bi / 8] &= ~m;
801019d1:	f7 d0                	not    %eax
  log_write(bp);
801019d3:	83 ec 0c             	sub    $0xc,%esp
  bp->data[bi / 8] &= ~m;
801019d6:	21 c8                	and    %ecx,%eax
801019d8:	88 44 1e 5c          	mov    %al,0x5c(%esi,%ebx,1)
  log_write(bp);
801019dc:	56                   	push   %esi
801019dd:	e8 2e 1d 00 00       	call   80103710 <log_write>
  brelse(bp);
801019e2:	89 34 24             	mov    %esi,(%esp)
801019e5:	e8 06 e8 ff ff       	call   801001f0 <brelse>
}
801019ea:	83 c4 10             	add    $0x10,%esp
801019ed:	8d 65 f8             	lea    -0x8(%ebp),%esp
801019f0:	5b                   	pop    %ebx
801019f1:	5e                   	pop    %esi
801019f2:	5d                   	pop    %ebp
801019f3:	c3                   	ret    
    panic("freeing free block");
801019f4:	83 ec 0c             	sub    $0xc,%esp
801019f7:	68 37 7d 10 80       	push   $0x80107d37
801019fc:	e8 9f e9 ff ff       	call   801003a0 <panic>
80101a01:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101a08:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101a0f:	90                   	nop

80101a10 <balloc>:
{
80101a10:	55                   	push   %ebp
80101a11:	89 e5                	mov    %esp,%ebp
80101a13:	57                   	push   %edi
80101a14:	56                   	push   %esi
80101a15:	53                   	push   %ebx
80101a16:	83 ec 1c             	sub    $0x1c,%esp
  for (b = 0; b < sb.size; b += BPB)
80101a19:	8b 0d f4 31 11 80    	mov    0x801131f4,%ecx
{
80101a1f:	89 45 d8             	mov    %eax,-0x28(%ebp)
  for (b = 0; b < sb.size; b += BPB)
80101a22:	85 c9                	test   %ecx,%ecx
80101a24:	0f 84 87 00 00 00    	je     80101ab1 <balloc+0xa1>
80101a2a:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    bp = bread(dev, BBLOCK(b, sb));
80101a31:	8b 75 dc             	mov    -0x24(%ebp),%esi
80101a34:	83 ec 08             	sub    $0x8,%esp
80101a37:	89 f0                	mov    %esi,%eax
80101a39:	c1 f8 0c             	sar    $0xc,%eax
80101a3c:	03 05 0c 32 11 80    	add    0x8011320c,%eax
80101a42:	50                   	push   %eax
80101a43:	ff 75 d8             	push   -0x28(%ebp)
80101a46:	e8 85 e6 ff ff       	call   801000d0 <bread>
80101a4b:	83 c4 10             	add    $0x10,%esp
80101a4e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for (bi = 0; bi < BPB && b + bi < sb.size; bi++)
80101a51:	a1 f4 31 11 80       	mov    0x801131f4,%eax
80101a56:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101a59:	31 c0                	xor    %eax,%eax
80101a5b:	eb 2f                	jmp    80101a8c <balloc+0x7c>
80101a5d:	8d 76 00             	lea    0x0(%esi),%esi
      m = 1 << (bi % 8);
80101a60:	89 c1                	mov    %eax,%ecx
80101a62:	bb 01 00 00 00       	mov    $0x1,%ebx
      if ((bp->data[bi / 8] & m) == 0)
80101a67:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      m = 1 << (bi % 8);
80101a6a:	83 e1 07             	and    $0x7,%ecx
80101a6d:	d3 e3                	shl    %cl,%ebx
      if ((bp->data[bi / 8] & m) == 0)
80101a6f:	89 c1                	mov    %eax,%ecx
80101a71:	c1 f9 03             	sar    $0x3,%ecx
80101a74:	0f b6 7c 0a 5c       	movzbl 0x5c(%edx,%ecx,1),%edi
80101a79:	89 fa                	mov    %edi,%edx
80101a7b:	85 df                	test   %ebx,%edi
80101a7d:	74 41                	je     80101ac0 <balloc+0xb0>
    for (bi = 0; bi < BPB && b + bi < sb.size; bi++)
80101a7f:	83 c0 01             	add    $0x1,%eax
80101a82:	83 c6 01             	add    $0x1,%esi
80101a85:	3d 00 10 00 00       	cmp    $0x1000,%eax
80101a8a:	74 05                	je     80101a91 <balloc+0x81>
80101a8c:	39 75 e0             	cmp    %esi,-0x20(%ebp)
80101a8f:	77 cf                	ja     80101a60 <balloc+0x50>
    brelse(bp);
80101a91:	83 ec 0c             	sub    $0xc,%esp
80101a94:	ff 75 e4             	push   -0x1c(%ebp)
80101a97:	e8 54 e7 ff ff       	call   801001f0 <brelse>
  for (b = 0; b < sb.size; b += BPB)
80101a9c:	81 45 dc 00 10 00 00 	addl   $0x1000,-0x24(%ebp)
80101aa3:	83 c4 10             	add    $0x10,%esp
80101aa6:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101aa9:	39 05 f4 31 11 80    	cmp    %eax,0x801131f4
80101aaf:	77 80                	ja     80101a31 <balloc+0x21>
  panic("balloc: out of blocks");
80101ab1:	83 ec 0c             	sub    $0xc,%esp
80101ab4:	68 4a 7d 10 80       	push   $0x80107d4a
80101ab9:	e8 e2 e8 ff ff       	call   801003a0 <panic>
80101abe:	66 90                	xchg   %ax,%ax
        bp->data[bi / 8] |= m; // Mark block in use.
80101ac0:	8b 7d e4             	mov    -0x1c(%ebp),%edi
        log_write(bp);
80101ac3:	83 ec 0c             	sub    $0xc,%esp
        bp->data[bi / 8] |= m; // Mark block in use.
80101ac6:	09 da                	or     %ebx,%edx
80101ac8:	88 54 0f 5c          	mov    %dl,0x5c(%edi,%ecx,1)
        log_write(bp);
80101acc:	57                   	push   %edi
80101acd:	e8 3e 1c 00 00       	call   80103710 <log_write>
        brelse(bp);
80101ad2:	89 3c 24             	mov    %edi,(%esp)
80101ad5:	e8 16 e7 ff ff       	call   801001f0 <brelse>
  bp = bread(dev, bno);
80101ada:	58                   	pop    %eax
80101adb:	5a                   	pop    %edx
80101adc:	56                   	push   %esi
80101add:	ff 75 d8             	push   -0x28(%ebp)
80101ae0:	e8 eb e5 ff ff       	call   801000d0 <bread>
  memset(bp->data, 0, BSIZE);
80101ae5:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, bno);
80101ae8:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
80101aea:	8d 40 5c             	lea    0x5c(%eax),%eax
80101aed:	68 00 02 00 00       	push   $0x200
80101af2:	6a 00                	push   $0x0
80101af4:	50                   	push   %eax
80101af5:	e8 36 33 00 00       	call   80104e30 <memset>
  log_write(bp);
80101afa:	89 1c 24             	mov    %ebx,(%esp)
80101afd:	e8 0e 1c 00 00       	call   80103710 <log_write>
  brelse(bp);
80101b02:	89 1c 24             	mov    %ebx,(%esp)
80101b05:	e8 e6 e6 ff ff       	call   801001f0 <brelse>
}
80101b0a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b0d:	89 f0                	mov    %esi,%eax
80101b0f:	5b                   	pop    %ebx
80101b10:	5e                   	pop    %esi
80101b11:	5f                   	pop    %edi
80101b12:	5d                   	pop    %ebp
80101b13:	c3                   	ret    
80101b14:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101b1b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101b1f:	90                   	nop

80101b20 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode *
iget(uint dev, uint inum)
{
80101b20:	55                   	push   %ebp
80101b21:	89 e5                	mov    %esp,%ebp
80101b23:	57                   	push   %edi
80101b24:	89 c7                	mov    %eax,%edi
80101b26:	56                   	push   %esi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
80101b27:	31 f6                	xor    %esi,%esi
{
80101b29:	53                   	push   %ebx
  for (ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++)
80101b2a:	bb d4 15 11 80       	mov    $0x801115d4,%ebx
{
80101b2f:	83 ec 28             	sub    $0x28,%esp
80101b32:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  acquire(&icache.lock);
80101b35:	68 a0 15 11 80       	push   $0x801115a0
80101b3a:	e8 31 32 00 00       	call   80104d70 <acquire>
  for (ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++)
80101b3f:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  acquire(&icache.lock);
80101b42:	83 c4 10             	add    $0x10,%esp
80101b45:	eb 1b                	jmp    80101b62 <iget+0x42>
80101b47:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101b4e:	66 90                	xchg   %ax,%ax
  {
    if (ip->ref > 0 && ip->dev == dev && ip->inum == inum)
80101b50:	39 3b                	cmp    %edi,(%ebx)
80101b52:	74 6c                	je     80101bc0 <iget+0xa0>
  for (ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++)
80101b54:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101b5a:	81 fb f4 31 11 80    	cmp    $0x801131f4,%ebx
80101b60:	73 26                	jae    80101b88 <iget+0x68>
    if (ip->ref > 0 && ip->dev == dev && ip->inum == inum)
80101b62:	8b 43 08             	mov    0x8(%ebx),%eax
80101b65:	85 c0                	test   %eax,%eax
80101b67:	7f e7                	jg     80101b50 <iget+0x30>
    {
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if (empty == 0 && ip->ref == 0) // Remember empty slot.
80101b69:	85 f6                	test   %esi,%esi
80101b6b:	75 e7                	jne    80101b54 <iget+0x34>
80101b6d:	85 c0                	test   %eax,%eax
80101b6f:	75 76                	jne    80101be7 <iget+0xc7>
80101b71:	89 de                	mov    %ebx,%esi
  for (ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++)
80101b73:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101b79:	81 fb f4 31 11 80    	cmp    $0x801131f4,%ebx
80101b7f:	72 e1                	jb     80101b62 <iget+0x42>
80101b81:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      empty = ip;
  }

  // Recycle an inode cache entry.
  if (empty == 0)
80101b88:	85 f6                	test   %esi,%esi
80101b8a:	74 79                	je     80101c05 <iget+0xe5>
  ip = empty;
  ip->dev = dev;
  ip->inum = inum;
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);
80101b8c:	83 ec 0c             	sub    $0xc,%esp
  ip->dev = dev;
80101b8f:	89 3e                	mov    %edi,(%esi)
  ip->inum = inum;
80101b91:	89 56 04             	mov    %edx,0x4(%esi)
  ip->ref = 1;
80101b94:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->valid = 0;
80101b9b:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
  release(&icache.lock);
80101ba2:	68 a0 15 11 80       	push   $0x801115a0
80101ba7:	e8 64 31 00 00       	call   80104d10 <release>

  return ip;
80101bac:	83 c4 10             	add    $0x10,%esp
}
80101baf:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101bb2:	89 f0                	mov    %esi,%eax
80101bb4:	5b                   	pop    %ebx
80101bb5:	5e                   	pop    %esi
80101bb6:	5f                   	pop    %edi
80101bb7:	5d                   	pop    %ebp
80101bb8:	c3                   	ret    
80101bb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if (ip->ref > 0 && ip->dev == dev && ip->inum == inum)
80101bc0:	39 53 04             	cmp    %edx,0x4(%ebx)
80101bc3:	75 8f                	jne    80101b54 <iget+0x34>
      release(&icache.lock);
80101bc5:	83 ec 0c             	sub    $0xc,%esp
      ip->ref++;
80101bc8:	83 c0 01             	add    $0x1,%eax
      return ip;
80101bcb:	89 de                	mov    %ebx,%esi
      release(&icache.lock);
80101bcd:	68 a0 15 11 80       	push   $0x801115a0
      ip->ref++;
80101bd2:	89 43 08             	mov    %eax,0x8(%ebx)
      release(&icache.lock);
80101bd5:	e8 36 31 00 00       	call   80104d10 <release>
      return ip;
80101bda:	83 c4 10             	add    $0x10,%esp
}
80101bdd:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101be0:	89 f0                	mov    %esi,%eax
80101be2:	5b                   	pop    %ebx
80101be3:	5e                   	pop    %esi
80101be4:	5f                   	pop    %edi
80101be5:	5d                   	pop    %ebp
80101be6:	c3                   	ret    
  for (ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++)
80101be7:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101bed:	81 fb f4 31 11 80    	cmp    $0x801131f4,%ebx
80101bf3:	73 10                	jae    80101c05 <iget+0xe5>
    if (ip->ref > 0 && ip->dev == dev && ip->inum == inum)
80101bf5:	8b 43 08             	mov    0x8(%ebx),%eax
80101bf8:	85 c0                	test   %eax,%eax
80101bfa:	0f 8f 50 ff ff ff    	jg     80101b50 <iget+0x30>
80101c00:	e9 68 ff ff ff       	jmp    80101b6d <iget+0x4d>
    panic("iget: no inodes");
80101c05:	83 ec 0c             	sub    $0xc,%esp
80101c08:	68 60 7d 10 80       	push   $0x80107d60
80101c0d:	e8 8e e7 ff ff       	call   801003a0 <panic>
80101c12:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101c19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101c20 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
80101c20:	55                   	push   %ebp
80101c21:	89 e5                	mov    %esp,%ebp
80101c23:	57                   	push   %edi
80101c24:	56                   	push   %esi
80101c25:	89 c6                	mov    %eax,%esi
80101c27:	53                   	push   %ebx
80101c28:	83 ec 1c             	sub    $0x1c,%esp
  uint addr, *a;
  struct buf *bp;

  if (bn < NDIRECT)
80101c2b:	83 fa 0b             	cmp    $0xb,%edx
80101c2e:	0f 86 8c 00 00 00    	jbe    80101cc0 <bmap+0xa0>
  {
    if ((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
    return addr;
  }
  bn -= NDIRECT;
80101c34:	8d 5a f4             	lea    -0xc(%edx),%ebx

  if (bn < NINDIRECT)
80101c37:	83 fb 7f             	cmp    $0x7f,%ebx
80101c3a:	0f 87 a2 00 00 00    	ja     80101ce2 <bmap+0xc2>
  {
    // Load indirect block, allocating if necessary.
    if ((addr = ip->addrs[NDIRECT]) == 0)
80101c40:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
80101c46:	85 c0                	test   %eax,%eax
80101c48:	74 5e                	je     80101ca8 <bmap+0x88>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
80101c4a:	83 ec 08             	sub    $0x8,%esp
80101c4d:	50                   	push   %eax
80101c4e:	ff 36                	push   (%esi)
80101c50:	e8 7b e4 ff ff       	call   801000d0 <bread>
    a = (uint *)bp->data;
    if ((addr = a[bn]) == 0)
80101c55:	83 c4 10             	add    $0x10,%esp
80101c58:	8d 5c 98 5c          	lea    0x5c(%eax,%ebx,4),%ebx
    bp = bread(ip->dev, addr);
80101c5c:	89 c2                	mov    %eax,%edx
    if ((addr = a[bn]) == 0)
80101c5e:	8b 3b                	mov    (%ebx),%edi
80101c60:	85 ff                	test   %edi,%edi
80101c62:	74 1c                	je     80101c80 <bmap+0x60>
    {
      a[bn] = addr = balloc(ip->dev);
      log_write(bp);
    }
    brelse(bp);
80101c64:	83 ec 0c             	sub    $0xc,%esp
80101c67:	52                   	push   %edx
80101c68:	e8 83 e5 ff ff       	call   801001f0 <brelse>
80101c6d:	83 c4 10             	add    $0x10,%esp
    return addr;
  }

  panic("bmap: out of range");
}
80101c70:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101c73:	89 f8                	mov    %edi,%eax
80101c75:	5b                   	pop    %ebx
80101c76:	5e                   	pop    %esi
80101c77:	5f                   	pop    %edi
80101c78:	5d                   	pop    %ebp
80101c79:	c3                   	ret    
80101c7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101c80:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      a[bn] = addr = balloc(ip->dev);
80101c83:	8b 06                	mov    (%esi),%eax
80101c85:	e8 86 fd ff ff       	call   80101a10 <balloc>
      log_write(bp);
80101c8a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101c8d:	83 ec 0c             	sub    $0xc,%esp
      a[bn] = addr = balloc(ip->dev);
80101c90:	89 03                	mov    %eax,(%ebx)
80101c92:	89 c7                	mov    %eax,%edi
      log_write(bp);
80101c94:	52                   	push   %edx
80101c95:	e8 76 1a 00 00       	call   80103710 <log_write>
80101c9a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101c9d:	83 c4 10             	add    $0x10,%esp
80101ca0:	eb c2                	jmp    80101c64 <bmap+0x44>
80101ca2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
80101ca8:	8b 06                	mov    (%esi),%eax
80101caa:	e8 61 fd ff ff       	call   80101a10 <balloc>
80101caf:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
80101cb5:	eb 93                	jmp    80101c4a <bmap+0x2a>
80101cb7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101cbe:	66 90                	xchg   %ax,%ax
    if ((addr = ip->addrs[bn]) == 0)
80101cc0:	8d 5a 14             	lea    0x14(%edx),%ebx
80101cc3:	8b 7c 98 0c          	mov    0xc(%eax,%ebx,4),%edi
80101cc7:	85 ff                	test   %edi,%edi
80101cc9:	75 a5                	jne    80101c70 <bmap+0x50>
      ip->addrs[bn] = addr = balloc(ip->dev);
80101ccb:	8b 00                	mov    (%eax),%eax
80101ccd:	e8 3e fd ff ff       	call   80101a10 <balloc>
80101cd2:	89 44 9e 0c          	mov    %eax,0xc(%esi,%ebx,4)
80101cd6:	89 c7                	mov    %eax,%edi
}
80101cd8:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101cdb:	5b                   	pop    %ebx
80101cdc:	89 f8                	mov    %edi,%eax
80101cde:	5e                   	pop    %esi
80101cdf:	5f                   	pop    %edi
80101ce0:	5d                   	pop    %ebp
80101ce1:	c3                   	ret    
  panic("bmap: out of range");
80101ce2:	83 ec 0c             	sub    $0xc,%esp
80101ce5:	68 70 7d 10 80       	push   $0x80107d70
80101cea:	e8 b1 e6 ff ff       	call   801003a0 <panic>
80101cef:	90                   	nop

80101cf0 <readsb>:
{
80101cf0:	55                   	push   %ebp
80101cf1:	89 e5                	mov    %esp,%ebp
80101cf3:	56                   	push   %esi
80101cf4:	53                   	push   %ebx
80101cf5:	8b 75 0c             	mov    0xc(%ebp),%esi
  bp = bread(dev, 1);
80101cf8:	83 ec 08             	sub    $0x8,%esp
80101cfb:	6a 01                	push   $0x1
80101cfd:	ff 75 08             	push   0x8(%ebp)
80101d00:	e8 cb e3 ff ff       	call   801000d0 <bread>
  memmove(sb, bp->data, sizeof(*sb));
80101d05:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, 1);
80101d08:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
80101d0a:	8d 40 5c             	lea    0x5c(%eax),%eax
80101d0d:	6a 1c                	push   $0x1c
80101d0f:	50                   	push   %eax
80101d10:	56                   	push   %esi
80101d11:	e8 ba 31 00 00       	call   80104ed0 <memmove>
  brelse(bp);
80101d16:	89 5d 08             	mov    %ebx,0x8(%ebp)
80101d19:	83 c4 10             	add    $0x10,%esp
}
80101d1c:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101d1f:	5b                   	pop    %ebx
80101d20:	5e                   	pop    %esi
80101d21:	5d                   	pop    %ebp
  brelse(bp);
80101d22:	e9 c9 e4 ff ff       	jmp    801001f0 <brelse>
80101d27:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101d2e:	66 90                	xchg   %ax,%ax

80101d30 <iinit>:
{
80101d30:	55                   	push   %ebp
80101d31:	89 e5                	mov    %esp,%ebp
80101d33:	53                   	push   %ebx
80101d34:	bb e0 15 11 80       	mov    $0x801115e0,%ebx
80101d39:	83 ec 0c             	sub    $0xc,%esp
  initlock(&icache.lock, "icache");
80101d3c:	68 83 7d 10 80       	push   $0x80107d83
80101d41:	68 a0 15 11 80       	push   $0x801115a0
80101d46:	e8 55 2e 00 00       	call   80104ba0 <initlock>
  for (i = 0; i < NINODE; i++)
80101d4b:	83 c4 10             	add    $0x10,%esp
80101d4e:	66 90                	xchg   %ax,%ax
    initsleeplock(&icache.inode[i].lock, "inode");
80101d50:	83 ec 08             	sub    $0x8,%esp
80101d53:	68 8a 7d 10 80       	push   $0x80107d8a
80101d58:	53                   	push   %ebx
  for (i = 0; i < NINODE; i++)
80101d59:	81 c3 90 00 00 00    	add    $0x90,%ebx
    initsleeplock(&icache.inode[i].lock, "inode");
80101d5f:	e8 0c 2d 00 00       	call   80104a70 <initsleeplock>
  for (i = 0; i < NINODE; i++)
80101d64:	83 c4 10             	add    $0x10,%esp
80101d67:	81 fb 00 32 11 80    	cmp    $0x80113200,%ebx
80101d6d:	75 e1                	jne    80101d50 <iinit+0x20>
  bp = bread(dev, 1);
80101d6f:	83 ec 08             	sub    $0x8,%esp
80101d72:	6a 01                	push   $0x1
80101d74:	ff 75 08             	push   0x8(%ebp)
80101d77:	e8 54 e3 ff ff       	call   801000d0 <bread>
  memmove(sb, bp->data, sizeof(*sb));
80101d7c:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, 1);
80101d7f:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
80101d81:	8d 40 5c             	lea    0x5c(%eax),%eax
80101d84:	6a 1c                	push   $0x1c
80101d86:	50                   	push   %eax
80101d87:	68 f4 31 11 80       	push   $0x801131f4
80101d8c:	e8 3f 31 00 00       	call   80104ed0 <memmove>
  brelse(bp);
80101d91:	89 1c 24             	mov    %ebx,(%esp)
80101d94:	e8 57 e4 ff ff       	call   801001f0 <brelse>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
80101d99:	ff 35 0c 32 11 80    	push   0x8011320c
80101d9f:	ff 35 08 32 11 80    	push   0x80113208
80101da5:	ff 35 04 32 11 80    	push   0x80113204
80101dab:	ff 35 00 32 11 80    	push   0x80113200
80101db1:	ff 35 fc 31 11 80    	push   0x801131fc
80101db7:	ff 35 f8 31 11 80    	push   0x801131f8
80101dbd:	ff 35 f4 31 11 80    	push   0x801131f4
80101dc3:	68 f0 7d 10 80       	push   $0x80107df0
80101dc8:	e8 83 e9 ff ff       	call   80100750 <cprintf>
}
80101dcd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101dd0:	83 c4 30             	add    $0x30,%esp
80101dd3:	c9                   	leave  
80101dd4:	c3                   	ret    
80101dd5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101ddc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101de0 <ialloc>:
{
80101de0:	55                   	push   %ebp
80101de1:	89 e5                	mov    %esp,%ebp
80101de3:	57                   	push   %edi
80101de4:	56                   	push   %esi
80101de5:	53                   	push   %ebx
80101de6:	83 ec 1c             	sub    $0x1c,%esp
80101de9:	8b 45 0c             	mov    0xc(%ebp),%eax
  for (inum = 1; inum < sb.ninodes; inum++)
80101dec:	83 3d fc 31 11 80 01 	cmpl   $0x1,0x801131fc
{
80101df3:	8b 75 08             	mov    0x8(%ebp),%esi
80101df6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for (inum = 1; inum < sb.ninodes; inum++)
80101df9:	0f 86 91 00 00 00    	jbe    80101e90 <ialloc+0xb0>
80101dff:	bf 01 00 00 00       	mov    $0x1,%edi
80101e04:	eb 21                	jmp    80101e27 <ialloc+0x47>
80101e06:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101e0d:	8d 76 00             	lea    0x0(%esi),%esi
    brelse(bp);
80101e10:	83 ec 0c             	sub    $0xc,%esp
  for (inum = 1; inum < sb.ninodes; inum++)
80101e13:	83 c7 01             	add    $0x1,%edi
    brelse(bp);
80101e16:	53                   	push   %ebx
80101e17:	e8 d4 e3 ff ff       	call   801001f0 <brelse>
  for (inum = 1; inum < sb.ninodes; inum++)
80101e1c:	83 c4 10             	add    $0x10,%esp
80101e1f:	3b 3d fc 31 11 80    	cmp    0x801131fc,%edi
80101e25:	73 69                	jae    80101e90 <ialloc+0xb0>
    bp = bread(dev, IBLOCK(inum, sb));
80101e27:	89 f8                	mov    %edi,%eax
80101e29:	83 ec 08             	sub    $0x8,%esp
80101e2c:	c1 e8 03             	shr    $0x3,%eax
80101e2f:	03 05 08 32 11 80    	add    0x80113208,%eax
80101e35:	50                   	push   %eax
80101e36:	56                   	push   %esi
80101e37:	e8 94 e2 ff ff       	call   801000d0 <bread>
    if (dip->type == 0)
80101e3c:	83 c4 10             	add    $0x10,%esp
    bp = bread(dev, IBLOCK(inum, sb));
80101e3f:	89 c3                	mov    %eax,%ebx
    dip = (struct dinode *)bp->data + inum % IPB;
80101e41:	89 f8                	mov    %edi,%eax
80101e43:	83 e0 07             	and    $0x7,%eax
80101e46:	c1 e0 06             	shl    $0x6,%eax
80101e49:	8d 4c 03 5c          	lea    0x5c(%ebx,%eax,1),%ecx
    if (dip->type == 0)
80101e4d:	66 83 39 00          	cmpw   $0x0,(%ecx)
80101e51:	75 bd                	jne    80101e10 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
80101e53:	83 ec 04             	sub    $0x4,%esp
80101e56:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80101e59:	6a 40                	push   $0x40
80101e5b:	6a 00                	push   $0x0
80101e5d:	51                   	push   %ecx
80101e5e:	e8 cd 2f 00 00       	call   80104e30 <memset>
      dip->type = type;
80101e63:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
80101e67:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80101e6a:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp); // mark it allocated on the disk
80101e6d:	89 1c 24             	mov    %ebx,(%esp)
80101e70:	e8 9b 18 00 00       	call   80103710 <log_write>
      brelse(bp);
80101e75:	89 1c 24             	mov    %ebx,(%esp)
80101e78:	e8 73 e3 ff ff       	call   801001f0 <brelse>
      return iget(dev, inum);
80101e7d:	83 c4 10             	add    $0x10,%esp
}
80101e80:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return iget(dev, inum);
80101e83:	89 fa                	mov    %edi,%edx
}
80101e85:	5b                   	pop    %ebx
      return iget(dev, inum);
80101e86:	89 f0                	mov    %esi,%eax
}
80101e88:	5e                   	pop    %esi
80101e89:	5f                   	pop    %edi
80101e8a:	5d                   	pop    %ebp
      return iget(dev, inum);
80101e8b:	e9 90 fc ff ff       	jmp    80101b20 <iget>
  panic("ialloc: no inodes");
80101e90:	83 ec 0c             	sub    $0xc,%esp
80101e93:	68 90 7d 10 80       	push   $0x80107d90
80101e98:	e8 03 e5 ff ff       	call   801003a0 <panic>
80101e9d:	8d 76 00             	lea    0x0(%esi),%esi

80101ea0 <iupdate>:
{
80101ea0:	55                   	push   %ebp
80101ea1:	89 e5                	mov    %esp,%ebp
80101ea3:	56                   	push   %esi
80101ea4:	53                   	push   %ebx
80101ea5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101ea8:	8b 43 04             	mov    0x4(%ebx),%eax
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101eab:	83 c3 5c             	add    $0x5c,%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101eae:	83 ec 08             	sub    $0x8,%esp
80101eb1:	c1 e8 03             	shr    $0x3,%eax
80101eb4:	03 05 08 32 11 80    	add    0x80113208,%eax
80101eba:	50                   	push   %eax
80101ebb:	ff 73 a4             	push   -0x5c(%ebx)
80101ebe:	e8 0d e2 ff ff       	call   801000d0 <bread>
  dip->type = ip->type;
80101ec3:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101ec7:	83 c4 0c             	add    $0xc,%esp
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101eca:	89 c6                	mov    %eax,%esi
  dip = (struct dinode *)bp->data + ip->inum % IPB;
80101ecc:	8b 43 a8             	mov    -0x58(%ebx),%eax
80101ecf:	83 e0 07             	and    $0x7,%eax
80101ed2:	c1 e0 06             	shl    $0x6,%eax
80101ed5:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
  dip->type = ip->type;
80101ed9:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
80101edc:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101ee0:	83 c0 0c             	add    $0xc,%eax
  dip->major = ip->major;
80101ee3:	66 89 50 f6          	mov    %dx,-0xa(%eax)
  dip->minor = ip->minor;
80101ee7:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
80101eeb:	66 89 50 f8          	mov    %dx,-0x8(%eax)
  dip->nlink = ip->nlink;
80101eef:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
80101ef3:	66 89 50 fa          	mov    %dx,-0x6(%eax)
  dip->size = ip->size;
80101ef7:	8b 53 fc             	mov    -0x4(%ebx),%edx
80101efa:	89 50 fc             	mov    %edx,-0x4(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101efd:	6a 34                	push   $0x34
80101eff:	53                   	push   %ebx
80101f00:	50                   	push   %eax
80101f01:	e8 ca 2f 00 00       	call   80104ed0 <memmove>
  log_write(bp);
80101f06:	89 34 24             	mov    %esi,(%esp)
80101f09:	e8 02 18 00 00       	call   80103710 <log_write>
  brelse(bp);
80101f0e:	89 75 08             	mov    %esi,0x8(%ebp)
80101f11:	83 c4 10             	add    $0x10,%esp
}
80101f14:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101f17:	5b                   	pop    %ebx
80101f18:	5e                   	pop    %esi
80101f19:	5d                   	pop    %ebp
  brelse(bp);
80101f1a:	e9 d1 e2 ff ff       	jmp    801001f0 <brelse>
80101f1f:	90                   	nop

80101f20 <idup>:
{
80101f20:	55                   	push   %ebp
80101f21:	89 e5                	mov    %esp,%ebp
80101f23:	53                   	push   %ebx
80101f24:	83 ec 10             	sub    $0x10,%esp
80101f27:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
80101f2a:	68 a0 15 11 80       	push   $0x801115a0
80101f2f:	e8 3c 2e 00 00       	call   80104d70 <acquire>
  ip->ref++;
80101f34:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
80101f38:	c7 04 24 a0 15 11 80 	movl   $0x801115a0,(%esp)
80101f3f:	e8 cc 2d 00 00       	call   80104d10 <release>
}
80101f44:	89 d8                	mov    %ebx,%eax
80101f46:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101f49:	c9                   	leave  
80101f4a:	c3                   	ret    
80101f4b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101f4f:	90                   	nop

80101f50 <ilock>:
{
80101f50:	55                   	push   %ebp
80101f51:	89 e5                	mov    %esp,%ebp
80101f53:	56                   	push   %esi
80101f54:	53                   	push   %ebx
80101f55:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (ip == 0 || ip->ref < 1)
80101f58:	85 db                	test   %ebx,%ebx
80101f5a:	0f 84 b7 00 00 00    	je     80102017 <ilock+0xc7>
80101f60:	8b 53 08             	mov    0x8(%ebx),%edx
80101f63:	85 d2                	test   %edx,%edx
80101f65:	0f 8e ac 00 00 00    	jle    80102017 <ilock+0xc7>
  acquiresleep(&ip->lock);
80101f6b:	83 ec 0c             	sub    $0xc,%esp
80101f6e:	8d 43 0c             	lea    0xc(%ebx),%eax
80101f71:	50                   	push   %eax
80101f72:	e8 39 2b 00 00       	call   80104ab0 <acquiresleep>
  if (ip->valid == 0)
80101f77:	8b 43 4c             	mov    0x4c(%ebx),%eax
80101f7a:	83 c4 10             	add    $0x10,%esp
80101f7d:	85 c0                	test   %eax,%eax
80101f7f:	74 0f                	je     80101f90 <ilock+0x40>
}
80101f81:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101f84:	5b                   	pop    %ebx
80101f85:	5e                   	pop    %esi
80101f86:	5d                   	pop    %ebp
80101f87:	c3                   	ret    
80101f88:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101f8f:	90                   	nop
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101f90:	8b 43 04             	mov    0x4(%ebx),%eax
80101f93:	83 ec 08             	sub    $0x8,%esp
80101f96:	c1 e8 03             	shr    $0x3,%eax
80101f99:	03 05 08 32 11 80    	add    0x80113208,%eax
80101f9f:	50                   	push   %eax
80101fa0:	ff 33                	push   (%ebx)
80101fa2:	e8 29 e1 ff ff       	call   801000d0 <bread>
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101fa7:	83 c4 0c             	add    $0xc,%esp
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101faa:	89 c6                	mov    %eax,%esi
    dip = (struct dinode *)bp->data + ip->inum % IPB;
80101fac:	8b 43 04             	mov    0x4(%ebx),%eax
80101faf:	83 e0 07             	and    $0x7,%eax
80101fb2:	c1 e0 06             	shl    $0x6,%eax
80101fb5:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    ip->type = dip->type;
80101fb9:	0f b7 10             	movzwl (%eax),%edx
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101fbc:	83 c0 0c             	add    $0xc,%eax
    ip->type = dip->type;
80101fbf:	66 89 53 50          	mov    %dx,0x50(%ebx)
    ip->major = dip->major;
80101fc3:	0f b7 50 f6          	movzwl -0xa(%eax),%edx
80101fc7:	66 89 53 52          	mov    %dx,0x52(%ebx)
    ip->minor = dip->minor;
80101fcb:	0f b7 50 f8          	movzwl -0x8(%eax),%edx
80101fcf:	66 89 53 54          	mov    %dx,0x54(%ebx)
    ip->nlink = dip->nlink;
80101fd3:	0f b7 50 fa          	movzwl -0x6(%eax),%edx
80101fd7:	66 89 53 56          	mov    %dx,0x56(%ebx)
    ip->size = dip->size;
80101fdb:	8b 50 fc             	mov    -0x4(%eax),%edx
80101fde:	89 53 58             	mov    %edx,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101fe1:	6a 34                	push   $0x34
80101fe3:	50                   	push   %eax
80101fe4:	8d 43 5c             	lea    0x5c(%ebx),%eax
80101fe7:	50                   	push   %eax
80101fe8:	e8 e3 2e 00 00       	call   80104ed0 <memmove>
    brelse(bp);
80101fed:	89 34 24             	mov    %esi,(%esp)
80101ff0:	e8 fb e1 ff ff       	call   801001f0 <brelse>
    if (ip->type == 0)
80101ff5:	83 c4 10             	add    $0x10,%esp
80101ff8:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
    ip->valid = 1;
80101ffd:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if (ip->type == 0)
80102004:	0f 85 77 ff ff ff    	jne    80101f81 <ilock+0x31>
      panic("ilock: no type");
8010200a:	83 ec 0c             	sub    $0xc,%esp
8010200d:	68 a8 7d 10 80       	push   $0x80107da8
80102012:	e8 89 e3 ff ff       	call   801003a0 <panic>
    panic("ilock");
80102017:	83 ec 0c             	sub    $0xc,%esp
8010201a:	68 a2 7d 10 80       	push   $0x80107da2
8010201f:	e8 7c e3 ff ff       	call   801003a0 <panic>
80102024:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010202b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010202f:	90                   	nop

80102030 <iunlock>:
{
80102030:	55                   	push   %ebp
80102031:	89 e5                	mov    %esp,%ebp
80102033:	56                   	push   %esi
80102034:	53                   	push   %ebx
80102035:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80102038:	85 db                	test   %ebx,%ebx
8010203a:	74 28                	je     80102064 <iunlock+0x34>
8010203c:	83 ec 0c             	sub    $0xc,%esp
8010203f:	8d 73 0c             	lea    0xc(%ebx),%esi
80102042:	56                   	push   %esi
80102043:	e8 08 2b 00 00       	call   80104b50 <holdingsleep>
80102048:	83 c4 10             	add    $0x10,%esp
8010204b:	85 c0                	test   %eax,%eax
8010204d:	74 15                	je     80102064 <iunlock+0x34>
8010204f:	8b 43 08             	mov    0x8(%ebx),%eax
80102052:	85 c0                	test   %eax,%eax
80102054:	7e 0e                	jle    80102064 <iunlock+0x34>
  releasesleep(&ip->lock);
80102056:	89 75 08             	mov    %esi,0x8(%ebp)
}
80102059:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010205c:	5b                   	pop    %ebx
8010205d:	5e                   	pop    %esi
8010205e:	5d                   	pop    %ebp
  releasesleep(&ip->lock);
8010205f:	e9 ac 2a 00 00       	jmp    80104b10 <releasesleep>
    panic("iunlock");
80102064:	83 ec 0c             	sub    $0xc,%esp
80102067:	68 b7 7d 10 80       	push   $0x80107db7
8010206c:	e8 2f e3 ff ff       	call   801003a0 <panic>
80102071:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102078:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010207f:	90                   	nop

80102080 <iput>:
{
80102080:	55                   	push   %ebp
80102081:	89 e5                	mov    %esp,%ebp
80102083:	57                   	push   %edi
80102084:	56                   	push   %esi
80102085:	53                   	push   %ebx
80102086:	83 ec 28             	sub    $0x28,%esp
80102089:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquiresleep(&ip->lock);
8010208c:	8d 7b 0c             	lea    0xc(%ebx),%edi
8010208f:	57                   	push   %edi
80102090:	e8 1b 2a 00 00       	call   80104ab0 <acquiresleep>
  if (ip->valid && ip->nlink == 0)
80102095:	8b 53 4c             	mov    0x4c(%ebx),%edx
80102098:	83 c4 10             	add    $0x10,%esp
8010209b:	85 d2                	test   %edx,%edx
8010209d:	74 07                	je     801020a6 <iput+0x26>
8010209f:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
801020a4:	74 32                	je     801020d8 <iput+0x58>
  releasesleep(&ip->lock);
801020a6:	83 ec 0c             	sub    $0xc,%esp
801020a9:	57                   	push   %edi
801020aa:	e8 61 2a 00 00       	call   80104b10 <releasesleep>
  acquire(&icache.lock);
801020af:	c7 04 24 a0 15 11 80 	movl   $0x801115a0,(%esp)
801020b6:	e8 b5 2c 00 00       	call   80104d70 <acquire>
  ip->ref--;
801020bb:	83 6b 08 01          	subl   $0x1,0x8(%ebx)
  release(&icache.lock);
801020bf:	83 c4 10             	add    $0x10,%esp
801020c2:	c7 45 08 a0 15 11 80 	movl   $0x801115a0,0x8(%ebp)
}
801020c9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801020cc:	5b                   	pop    %ebx
801020cd:	5e                   	pop    %esi
801020ce:	5f                   	pop    %edi
801020cf:	5d                   	pop    %ebp
  release(&icache.lock);
801020d0:	e9 3b 2c 00 00       	jmp    80104d10 <release>
801020d5:	8d 76 00             	lea    0x0(%esi),%esi
    acquire(&icache.lock);
801020d8:	83 ec 0c             	sub    $0xc,%esp
801020db:	68 a0 15 11 80       	push   $0x801115a0
801020e0:	e8 8b 2c 00 00       	call   80104d70 <acquire>
    int r = ip->ref;
801020e5:	8b 73 08             	mov    0x8(%ebx),%esi
    release(&icache.lock);
801020e8:	c7 04 24 a0 15 11 80 	movl   $0x801115a0,(%esp)
801020ef:	e8 1c 2c 00 00       	call   80104d10 <release>
    if (r == 1)
801020f4:	83 c4 10             	add    $0x10,%esp
801020f7:	83 fe 01             	cmp    $0x1,%esi
801020fa:	75 aa                	jne    801020a6 <iput+0x26>
801020fc:	8d 8b 8c 00 00 00    	lea    0x8c(%ebx),%ecx
80102102:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80102105:	8d 73 5c             	lea    0x5c(%ebx),%esi
80102108:	89 cf                	mov    %ecx,%edi
8010210a:	eb 0b                	jmp    80102117 <iput+0x97>
8010210c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
  int i, j;
  struct buf *bp;
  uint *a;

  for (i = 0; i < NDIRECT; i++)
80102110:	83 c6 04             	add    $0x4,%esi
80102113:	39 fe                	cmp    %edi,%esi
80102115:	74 19                	je     80102130 <iput+0xb0>
  {
    if (ip->addrs[i])
80102117:	8b 16                	mov    (%esi),%edx
80102119:	85 d2                	test   %edx,%edx
8010211b:	74 f3                	je     80102110 <iput+0x90>
    {
      bfree(ip->dev, ip->addrs[i]);
8010211d:	8b 03                	mov    (%ebx),%eax
8010211f:	e8 6c f8 ff ff       	call   80101990 <bfree>
      ip->addrs[i] = 0;
80102124:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
8010212a:	eb e4                	jmp    80102110 <iput+0x90>
8010212c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  if (ip->addrs[NDIRECT])
80102130:	8b 83 8c 00 00 00    	mov    0x8c(%ebx),%eax
80102136:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80102139:	85 c0                	test   %eax,%eax
8010213b:	75 2d                	jne    8010216a <iput+0xea>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
  iupdate(ip);
8010213d:	83 ec 0c             	sub    $0xc,%esp
  ip->size = 0;
80102140:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  iupdate(ip);
80102147:	53                   	push   %ebx
80102148:	e8 53 fd ff ff       	call   80101ea0 <iupdate>
      ip->type = 0;
8010214d:	31 c0                	xor    %eax,%eax
8010214f:	66 89 43 50          	mov    %ax,0x50(%ebx)
      iupdate(ip);
80102153:	89 1c 24             	mov    %ebx,(%esp)
80102156:	e8 45 fd ff ff       	call   80101ea0 <iupdate>
      ip->valid = 0;
8010215b:	c7 43 4c 00 00 00 00 	movl   $0x0,0x4c(%ebx)
80102162:	83 c4 10             	add    $0x10,%esp
80102165:	e9 3c ff ff ff       	jmp    801020a6 <iput+0x26>
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
8010216a:	83 ec 08             	sub    $0x8,%esp
8010216d:	50                   	push   %eax
8010216e:	ff 33                	push   (%ebx)
80102170:	e8 5b df ff ff       	call   801000d0 <bread>
80102175:	89 7d e0             	mov    %edi,-0x20(%ebp)
80102178:	83 c4 10             	add    $0x10,%esp
8010217b:	8d 88 5c 02 00 00    	lea    0x25c(%eax),%ecx
80102181:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for (j = 0; j < NINDIRECT; j++)
80102184:	8d 70 5c             	lea    0x5c(%eax),%esi
80102187:	89 cf                	mov    %ecx,%edi
80102189:	eb 0c                	jmp    80102197 <iput+0x117>
8010218b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010218f:	90                   	nop
80102190:	83 c6 04             	add    $0x4,%esi
80102193:	39 f7                	cmp    %esi,%edi
80102195:	74 0f                	je     801021a6 <iput+0x126>
      if (a[j])
80102197:	8b 16                	mov    (%esi),%edx
80102199:	85 d2                	test   %edx,%edx
8010219b:	74 f3                	je     80102190 <iput+0x110>
        bfree(ip->dev, a[j]);
8010219d:	8b 03                	mov    (%ebx),%eax
8010219f:	e8 ec f7 ff ff       	call   80101990 <bfree>
801021a4:	eb ea                	jmp    80102190 <iput+0x110>
    brelse(bp);
801021a6:	83 ec 0c             	sub    $0xc,%esp
801021a9:	ff 75 e4             	push   -0x1c(%ebp)
801021ac:	8b 7d e0             	mov    -0x20(%ebp),%edi
801021af:	e8 3c e0 ff ff       	call   801001f0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
801021b4:	8b 93 8c 00 00 00    	mov    0x8c(%ebx),%edx
801021ba:	8b 03                	mov    (%ebx),%eax
801021bc:	e8 cf f7 ff ff       	call   80101990 <bfree>
    ip->addrs[NDIRECT] = 0;
801021c1:	83 c4 10             	add    $0x10,%esp
801021c4:	c7 83 8c 00 00 00 00 	movl   $0x0,0x8c(%ebx)
801021cb:	00 00 00 
801021ce:	e9 6a ff ff ff       	jmp    8010213d <iput+0xbd>
801021d3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801021da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801021e0 <iunlockput>:
{
801021e0:	55                   	push   %ebp
801021e1:	89 e5                	mov    %esp,%ebp
801021e3:	56                   	push   %esi
801021e4:	53                   	push   %ebx
801021e5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
801021e8:	85 db                	test   %ebx,%ebx
801021ea:	74 34                	je     80102220 <iunlockput+0x40>
801021ec:	83 ec 0c             	sub    $0xc,%esp
801021ef:	8d 73 0c             	lea    0xc(%ebx),%esi
801021f2:	56                   	push   %esi
801021f3:	e8 58 29 00 00       	call   80104b50 <holdingsleep>
801021f8:	83 c4 10             	add    $0x10,%esp
801021fb:	85 c0                	test   %eax,%eax
801021fd:	74 21                	je     80102220 <iunlockput+0x40>
801021ff:	8b 43 08             	mov    0x8(%ebx),%eax
80102202:	85 c0                	test   %eax,%eax
80102204:	7e 1a                	jle    80102220 <iunlockput+0x40>
  releasesleep(&ip->lock);
80102206:	83 ec 0c             	sub    $0xc,%esp
80102209:	56                   	push   %esi
8010220a:	e8 01 29 00 00       	call   80104b10 <releasesleep>
  iput(ip);
8010220f:	89 5d 08             	mov    %ebx,0x8(%ebp)
80102212:	83 c4 10             	add    $0x10,%esp
}
80102215:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102218:	5b                   	pop    %ebx
80102219:	5e                   	pop    %esi
8010221a:	5d                   	pop    %ebp
  iput(ip);
8010221b:	e9 60 fe ff ff       	jmp    80102080 <iput>
    panic("iunlock");
80102220:	83 ec 0c             	sub    $0xc,%esp
80102223:	68 b7 7d 10 80       	push   $0x80107db7
80102228:	e8 73 e1 ff ff       	call   801003a0 <panic>
8010222d:	8d 76 00             	lea    0x0(%esi),%esi

80102230 <stati>:
}

// Copy stat information from inode.
// Caller must hold ip->lock.
void stati(struct inode *ip, struct stat *st)
{
80102230:	55                   	push   %ebp
80102231:	89 e5                	mov    %esp,%ebp
80102233:	8b 55 08             	mov    0x8(%ebp),%edx
80102236:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
80102239:	8b 0a                	mov    (%edx),%ecx
8010223b:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
8010223e:	8b 4a 04             	mov    0x4(%edx),%ecx
80102241:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
80102244:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
80102248:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
8010224b:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
8010224f:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
80102253:	8b 52 58             	mov    0x58(%edx),%edx
80102256:	89 50 10             	mov    %edx,0x10(%eax)
}
80102259:	5d                   	pop    %ebp
8010225a:	c3                   	ret    
8010225b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010225f:	90                   	nop

80102260 <readi>:

// PAGEBREAK!
//  Read data from inode.
//  Caller must hold ip->lock.
int readi(struct inode *ip, char *dst, uint off, uint n)
{
80102260:	55                   	push   %ebp
80102261:	89 e5                	mov    %esp,%ebp
80102263:	57                   	push   %edi
80102264:	56                   	push   %esi
80102265:	53                   	push   %ebx
80102266:	83 ec 1c             	sub    $0x1c,%esp
80102269:	8b 7d 0c             	mov    0xc(%ebp),%edi
8010226c:	8b 45 08             	mov    0x8(%ebp),%eax
8010226f:	8b 75 10             	mov    0x10(%ebp),%esi
80102272:	89 7d e0             	mov    %edi,-0x20(%ebp)
80102275:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if (ip->type == T_DEV)
80102278:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
8010227d:	89 45 d8             	mov    %eax,-0x28(%ebp)
80102280:	89 7d e4             	mov    %edi,-0x1c(%ebp)
  if (ip->type == T_DEV)
80102283:	0f 84 a7 00 00 00    	je     80102330 <readi+0xd0>
    if (ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if (off > ip->size || off + n < off)
80102289:	8b 45 d8             	mov    -0x28(%ebp),%eax
8010228c:	8b 40 58             	mov    0x58(%eax),%eax
8010228f:	39 c6                	cmp    %eax,%esi
80102291:	0f 87 ba 00 00 00    	ja     80102351 <readi+0xf1>
80102297:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
8010229a:	31 c9                	xor    %ecx,%ecx
8010229c:	89 da                	mov    %ebx,%edx
8010229e:	01 f2                	add    %esi,%edx
801022a0:	0f 92 c1             	setb   %cl
801022a3:	89 cf                	mov    %ecx,%edi
801022a5:	0f 82 a6 00 00 00    	jb     80102351 <readi+0xf1>
    return -1;
  if (off + n > ip->size)
    n = ip->size - off;
801022ab:	89 c1                	mov    %eax,%ecx
801022ad:	29 f1                	sub    %esi,%ecx
801022af:	39 d0                	cmp    %edx,%eax
801022b1:	0f 43 cb             	cmovae %ebx,%ecx
801022b4:	89 4d e4             	mov    %ecx,-0x1c(%ebp)

  for (tot = 0; tot < n; tot += m, off += m, dst += m)
801022b7:	85 c9                	test   %ecx,%ecx
801022b9:	74 67                	je     80102322 <readi+0xc2>
801022bb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801022bf:	90                   	nop
  {
    bp = bread(ip->dev, bmap(ip, off / BSIZE));
801022c0:	8b 5d d8             	mov    -0x28(%ebp),%ebx
801022c3:	89 f2                	mov    %esi,%edx
801022c5:	c1 ea 09             	shr    $0x9,%edx
801022c8:	89 d8                	mov    %ebx,%eax
801022ca:	e8 51 f9 ff ff       	call   80101c20 <bmap>
801022cf:	83 ec 08             	sub    $0x8,%esp
801022d2:	50                   	push   %eax
801022d3:	ff 33                	push   (%ebx)
801022d5:	e8 f6 dd ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off % BSIZE);
801022da:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
801022dd:	b9 00 02 00 00       	mov    $0x200,%ecx
    bp = bread(ip->dev, bmap(ip, off / BSIZE));
801022e2:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off % BSIZE);
801022e4:	89 f0                	mov    %esi,%eax
801022e6:	25 ff 01 00 00       	and    $0x1ff,%eax
801022eb:	29 fb                	sub    %edi,%ebx
    memmove(dst, bp->data + off % BSIZE, m);
801022ed:	89 55 dc             	mov    %edx,-0x24(%ebp)
    m = min(n - tot, BSIZE - off % BSIZE);
801022f0:	29 c1                	sub    %eax,%ecx
    memmove(dst, bp->data + off % BSIZE, m);
801022f2:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
    m = min(n - tot, BSIZE - off % BSIZE);
801022f6:	39 d9                	cmp    %ebx,%ecx
801022f8:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(dst, bp->data + off % BSIZE, m);
801022fb:	83 c4 0c             	add    $0xc,%esp
801022fe:	53                   	push   %ebx
  for (tot = 0; tot < n; tot += m, off += m, dst += m)
801022ff:	01 df                	add    %ebx,%edi
80102301:	01 de                	add    %ebx,%esi
    memmove(dst, bp->data + off % BSIZE, m);
80102303:	50                   	push   %eax
80102304:	ff 75 e0             	push   -0x20(%ebp)
80102307:	e8 c4 2b 00 00       	call   80104ed0 <memmove>
    brelse(bp);
8010230c:	8b 55 dc             	mov    -0x24(%ebp),%edx
8010230f:	89 14 24             	mov    %edx,(%esp)
80102312:	e8 d9 de ff ff       	call   801001f0 <brelse>
  for (tot = 0; tot < n; tot += m, off += m, dst += m)
80102317:	01 5d e0             	add    %ebx,-0x20(%ebp)
8010231a:	83 c4 10             	add    $0x10,%esp
8010231d:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80102320:	77 9e                	ja     801022c0 <readi+0x60>
  }
  return n;
80102322:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
80102325:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102328:	5b                   	pop    %ebx
80102329:	5e                   	pop    %esi
8010232a:	5f                   	pop    %edi
8010232b:	5d                   	pop    %ebp
8010232c:	c3                   	ret    
8010232d:	8d 76 00             	lea    0x0(%esi),%esi
    if (ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80102330:	0f bf 40 52          	movswl 0x52(%eax),%eax
80102334:	66 83 f8 09          	cmp    $0x9,%ax
80102338:	77 17                	ja     80102351 <readi+0xf1>
8010233a:	8b 04 c5 40 15 11 80 	mov    -0x7feeeac0(,%eax,8),%eax
80102341:	85 c0                	test   %eax,%eax
80102343:	74 0c                	je     80102351 <readi+0xf1>
    return devsw[ip->major].read(ip, dst, n);
80102345:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80102348:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010234b:	5b                   	pop    %ebx
8010234c:	5e                   	pop    %esi
8010234d:	5f                   	pop    %edi
8010234e:	5d                   	pop    %ebp
    return devsw[ip->major].read(ip, dst, n);
8010234f:	ff e0                	jmp    *%eax
      return -1;
80102351:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102356:	eb cd                	jmp    80102325 <readi+0xc5>
80102358:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010235f:	90                   	nop

80102360 <writei>:

// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int writei(struct inode *ip, char *src, uint off, uint n)
{
80102360:	55                   	push   %ebp
80102361:	89 e5                	mov    %esp,%ebp
80102363:	57                   	push   %edi
80102364:	56                   	push   %esi
80102365:	53                   	push   %ebx
80102366:	83 ec 1c             	sub    $0x1c,%esp
80102369:	8b 45 08             	mov    0x8(%ebp),%eax
8010236c:	8b 75 0c             	mov    0xc(%ebp),%esi
8010236f:	8b 55 14             	mov    0x14(%ebp),%edx
  uint tot, m;
  struct buf *bp;

  if (ip->type == T_DEV)
80102372:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80102377:	89 75 dc             	mov    %esi,-0x24(%ebp)
8010237a:	89 45 d8             	mov    %eax,-0x28(%ebp)
8010237d:	8b 75 10             	mov    0x10(%ebp),%esi
80102380:	89 55 e0             	mov    %edx,-0x20(%ebp)
  if (ip->type == T_DEV)
80102383:	0f 84 b7 00 00 00    	je     80102440 <writei+0xe0>
    if (ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if (off > ip->size || off + n < off)
80102389:	8b 45 d8             	mov    -0x28(%ebp),%eax
8010238c:	3b 70 58             	cmp    0x58(%eax),%esi
8010238f:	0f 87 e7 00 00 00    	ja     8010247c <writei+0x11c>
80102395:	8b 7d e0             	mov    -0x20(%ebp),%edi
80102398:	31 d2                	xor    %edx,%edx
8010239a:	89 f8                	mov    %edi,%eax
8010239c:	01 f0                	add    %esi,%eax
8010239e:	0f 92 c2             	setb   %dl
    return -1;
  if (off + n > MAXFILE * BSIZE)
801023a1:	3d 00 18 01 00       	cmp    $0x11800,%eax
801023a6:	0f 87 d0 00 00 00    	ja     8010247c <writei+0x11c>
801023ac:	85 d2                	test   %edx,%edx
801023ae:	0f 85 c8 00 00 00    	jne    8010247c <writei+0x11c>
    return -1;

  for (tot = 0; tot < n; tot += m, off += m, src += m)
801023b4:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
801023bb:	85 ff                	test   %edi,%edi
801023bd:	74 72                	je     80102431 <writei+0xd1>
801023bf:	90                   	nop
  {
    bp = bread(ip->dev, bmap(ip, off / BSIZE));
801023c0:	8b 7d d8             	mov    -0x28(%ebp),%edi
801023c3:	89 f2                	mov    %esi,%edx
801023c5:	c1 ea 09             	shr    $0x9,%edx
801023c8:	89 f8                	mov    %edi,%eax
801023ca:	e8 51 f8 ff ff       	call   80101c20 <bmap>
801023cf:	83 ec 08             	sub    $0x8,%esp
801023d2:	50                   	push   %eax
801023d3:	ff 37                	push   (%edi)
801023d5:	e8 f6 dc ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off % BSIZE);
801023da:	b9 00 02 00 00       	mov    $0x200,%ecx
801023df:	8b 5d e0             	mov    -0x20(%ebp),%ebx
801023e2:	2b 5d e4             	sub    -0x1c(%ebp),%ebx
    bp = bread(ip->dev, bmap(ip, off / BSIZE));
801023e5:	89 c7                	mov    %eax,%edi
    m = min(n - tot, BSIZE - off % BSIZE);
801023e7:	89 f0                	mov    %esi,%eax
801023e9:	25 ff 01 00 00       	and    $0x1ff,%eax
801023ee:	29 c1                	sub    %eax,%ecx
    memmove(bp->data + off % BSIZE, src, m);
801023f0:	8d 44 07 5c          	lea    0x5c(%edi,%eax,1),%eax
    m = min(n - tot, BSIZE - off % BSIZE);
801023f4:	39 d9                	cmp    %ebx,%ecx
801023f6:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(bp->data + off % BSIZE, src, m);
801023f9:	83 c4 0c             	add    $0xc,%esp
801023fc:	53                   	push   %ebx
  for (tot = 0; tot < n; tot += m, off += m, src += m)
801023fd:	01 de                	add    %ebx,%esi
    memmove(bp->data + off % BSIZE, src, m);
801023ff:	ff 75 dc             	push   -0x24(%ebp)
80102402:	50                   	push   %eax
80102403:	e8 c8 2a 00 00       	call   80104ed0 <memmove>
    log_write(bp);
80102408:	89 3c 24             	mov    %edi,(%esp)
8010240b:	e8 00 13 00 00       	call   80103710 <log_write>
    brelse(bp);
80102410:	89 3c 24             	mov    %edi,(%esp)
80102413:	e8 d8 dd ff ff       	call   801001f0 <brelse>
  for (tot = 0; tot < n; tot += m, off += m, src += m)
80102418:	01 5d e4             	add    %ebx,-0x1c(%ebp)
8010241b:	83 c4 10             	add    $0x10,%esp
8010241e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80102421:	01 5d dc             	add    %ebx,-0x24(%ebp)
80102424:	39 45 e0             	cmp    %eax,-0x20(%ebp)
80102427:	77 97                	ja     801023c0 <writei+0x60>
  }

  if (n > 0 && off > ip->size)
80102429:	8b 45 d8             	mov    -0x28(%ebp),%eax
8010242c:	3b 70 58             	cmp    0x58(%eax),%esi
8010242f:	77 37                	ja     80102468 <writei+0x108>
  {
    ip->size = off;
    iupdate(ip);
  }
  return n;
80102431:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80102434:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102437:	5b                   	pop    %ebx
80102438:	5e                   	pop    %esi
80102439:	5f                   	pop    %edi
8010243a:	5d                   	pop    %ebp
8010243b:	c3                   	ret    
8010243c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if (ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80102440:	0f bf 40 52          	movswl 0x52(%eax),%eax
80102444:	66 83 f8 09          	cmp    $0x9,%ax
80102448:	77 32                	ja     8010247c <writei+0x11c>
8010244a:	8b 04 c5 44 15 11 80 	mov    -0x7feeeabc(,%eax,8),%eax
80102451:	85 c0                	test   %eax,%eax
80102453:	74 27                	je     8010247c <writei+0x11c>
    return devsw[ip->major].write(ip, src, n);
80102455:	89 55 10             	mov    %edx,0x10(%ebp)
}
80102458:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010245b:	5b                   	pop    %ebx
8010245c:	5e                   	pop    %esi
8010245d:	5f                   	pop    %edi
8010245e:	5d                   	pop    %ebp
    return devsw[ip->major].write(ip, src, n);
8010245f:	ff e0                	jmp    *%eax
80102461:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    ip->size = off;
80102468:	8b 45 d8             	mov    -0x28(%ebp),%eax
    iupdate(ip);
8010246b:	83 ec 0c             	sub    $0xc,%esp
    ip->size = off;
8010246e:	89 70 58             	mov    %esi,0x58(%eax)
    iupdate(ip);
80102471:	50                   	push   %eax
80102472:	e8 29 fa ff ff       	call   80101ea0 <iupdate>
80102477:	83 c4 10             	add    $0x10,%esp
8010247a:	eb b5                	jmp    80102431 <writei+0xd1>
      return -1;
8010247c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102481:	eb b1                	jmp    80102434 <writei+0xd4>
80102483:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010248a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102490 <namecmp>:

// PAGEBREAK!
//  Directories

int namecmp(const char *s, const char *t)
{
80102490:	55                   	push   %ebp
80102491:	89 e5                	mov    %esp,%ebp
80102493:	83 ec 0c             	sub    $0xc,%esp
  return strncmp(s, t, DIRSIZ);
80102496:	6a 0e                	push   $0xe
80102498:	ff 75 0c             	push   0xc(%ebp)
8010249b:	ff 75 08             	push   0x8(%ebp)
8010249e:	e8 9d 2a 00 00       	call   80104f40 <strncmp>
}
801024a3:	c9                   	leave  
801024a4:	c3                   	ret    
801024a5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801024ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801024b0 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode *
dirlookup(struct inode *dp, char *name, uint *poff)
{
801024b0:	55                   	push   %ebp
801024b1:	89 e5                	mov    %esp,%ebp
801024b3:	57                   	push   %edi
801024b4:	56                   	push   %esi
801024b5:	53                   	push   %ebx
801024b6:	83 ec 1c             	sub    $0x1c,%esp
801024b9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if (dp->type != T_DIR)
801024bc:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801024c1:	0f 85 85 00 00 00    	jne    8010254c <dirlookup+0x9c>
    panic("dirlookup not DIR");

  for (off = 0; off < dp->size; off += sizeof(de))
801024c7:	8b 53 58             	mov    0x58(%ebx),%edx
801024ca:	31 ff                	xor    %edi,%edi
801024cc:	8d 75 d8             	lea    -0x28(%ebp),%esi
801024cf:	85 d2                	test   %edx,%edx
801024d1:	74 3e                	je     80102511 <dirlookup+0x61>
801024d3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801024d7:	90                   	nop
  {
    if (readi(dp, (char *)&de, off, sizeof(de)) != sizeof(de))
801024d8:	6a 10                	push   $0x10
801024da:	57                   	push   %edi
801024db:	56                   	push   %esi
801024dc:	53                   	push   %ebx
801024dd:	e8 7e fd ff ff       	call   80102260 <readi>
801024e2:	83 c4 10             	add    $0x10,%esp
801024e5:	83 f8 10             	cmp    $0x10,%eax
801024e8:	75 55                	jne    8010253f <dirlookup+0x8f>
      panic("dirlookup read");
    if (de.inum == 0)
801024ea:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
801024ef:	74 18                	je     80102509 <dirlookup+0x59>
  return strncmp(s, t, DIRSIZ);
801024f1:	83 ec 04             	sub    $0x4,%esp
801024f4:	8d 45 da             	lea    -0x26(%ebp),%eax
801024f7:	6a 0e                	push   $0xe
801024f9:	50                   	push   %eax
801024fa:	ff 75 0c             	push   0xc(%ebp)
801024fd:	e8 3e 2a 00 00       	call   80104f40 <strncmp>
      continue;
    if (namecmp(name, de.name) == 0)
80102502:	83 c4 10             	add    $0x10,%esp
80102505:	85 c0                	test   %eax,%eax
80102507:	74 17                	je     80102520 <dirlookup+0x70>
  for (off = 0; off < dp->size; off += sizeof(de))
80102509:	83 c7 10             	add    $0x10,%edi
8010250c:	3b 7b 58             	cmp    0x58(%ebx),%edi
8010250f:	72 c7                	jb     801024d8 <dirlookup+0x28>
      return iget(dp->dev, inum);
    }
  }

  return 0;
}
80102511:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80102514:	31 c0                	xor    %eax,%eax
}
80102516:	5b                   	pop    %ebx
80102517:	5e                   	pop    %esi
80102518:	5f                   	pop    %edi
80102519:	5d                   	pop    %ebp
8010251a:	c3                   	ret    
8010251b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010251f:	90                   	nop
      if (poff)
80102520:	8b 45 10             	mov    0x10(%ebp),%eax
80102523:	85 c0                	test   %eax,%eax
80102525:	74 05                	je     8010252c <dirlookup+0x7c>
        *poff = off;
80102527:	8b 45 10             	mov    0x10(%ebp),%eax
8010252a:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
8010252c:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
      return iget(dp->dev, inum);
80102530:	8b 03                	mov    (%ebx),%eax
80102532:	e8 e9 f5 ff ff       	call   80101b20 <iget>
}
80102537:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010253a:	5b                   	pop    %ebx
8010253b:	5e                   	pop    %esi
8010253c:	5f                   	pop    %edi
8010253d:	5d                   	pop    %ebp
8010253e:	c3                   	ret    
      panic("dirlookup read");
8010253f:	83 ec 0c             	sub    $0xc,%esp
80102542:	68 d1 7d 10 80       	push   $0x80107dd1
80102547:	e8 54 de ff ff       	call   801003a0 <panic>
    panic("dirlookup not DIR");
8010254c:	83 ec 0c             	sub    $0xc,%esp
8010254f:	68 bf 7d 10 80       	push   $0x80107dbf
80102554:	e8 47 de ff ff       	call   801003a0 <panic>
80102559:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102560 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode *
namex(char *path, int nameiparent, char *name)
{
80102560:	55                   	push   %ebp
80102561:	89 e5                	mov    %esp,%ebp
80102563:	57                   	push   %edi
80102564:	56                   	push   %esi
80102565:	53                   	push   %ebx
80102566:	89 c3                	mov    %eax,%ebx
80102568:	83 ec 1c             	sub    $0x1c,%esp
  struct inode *ip, *next;

  if (*path == '/')
8010256b:	80 38 2f             	cmpb   $0x2f,(%eax)
{
8010256e:	89 55 dc             	mov    %edx,-0x24(%ebp)
80102571:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  if (*path == '/')
80102574:	0f 84 64 01 00 00    	je     801026de <namex+0x17e>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
8010257a:	e8 c1 1b 00 00       	call   80104140 <myproc>
  acquire(&icache.lock);
8010257f:	83 ec 0c             	sub    $0xc,%esp
    ip = idup(myproc()->cwd);
80102582:	8b 70 68             	mov    0x68(%eax),%esi
  acquire(&icache.lock);
80102585:	68 a0 15 11 80       	push   $0x801115a0
8010258a:	e8 e1 27 00 00       	call   80104d70 <acquire>
  ip->ref++;
8010258f:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80102593:	c7 04 24 a0 15 11 80 	movl   $0x801115a0,(%esp)
8010259a:	e8 71 27 00 00       	call   80104d10 <release>
8010259f:	83 c4 10             	add    $0x10,%esp
801025a2:	eb 07                	jmp    801025ab <namex+0x4b>
801025a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
801025a8:	83 c3 01             	add    $0x1,%ebx
  while (*path == '/')
801025ab:	0f b6 03             	movzbl (%ebx),%eax
801025ae:	3c 2f                	cmp    $0x2f,%al
801025b0:	74 f6                	je     801025a8 <namex+0x48>
  if (*path == 0)
801025b2:	84 c0                	test   %al,%al
801025b4:	0f 84 06 01 00 00    	je     801026c0 <namex+0x160>
  while (*path != '/' && *path != 0)
801025ba:	0f b6 03             	movzbl (%ebx),%eax
801025bd:	84 c0                	test   %al,%al
801025bf:	0f 84 10 01 00 00    	je     801026d5 <namex+0x175>
801025c5:	89 df                	mov    %ebx,%edi
801025c7:	3c 2f                	cmp    $0x2f,%al
801025c9:	0f 84 06 01 00 00    	je     801026d5 <namex+0x175>
801025cf:	90                   	nop
801025d0:	0f b6 47 01          	movzbl 0x1(%edi),%eax
    path++;
801025d4:	83 c7 01             	add    $0x1,%edi
  while (*path != '/' && *path != 0)
801025d7:	3c 2f                	cmp    $0x2f,%al
801025d9:	74 04                	je     801025df <namex+0x7f>
801025db:	84 c0                	test   %al,%al
801025dd:	75 f1                	jne    801025d0 <namex+0x70>
  len = path - s;
801025df:	89 f8                	mov    %edi,%eax
801025e1:	29 d8                	sub    %ebx,%eax
  if (len >= DIRSIZ)
801025e3:	83 f8 0d             	cmp    $0xd,%eax
801025e6:	0f 8e ac 00 00 00    	jle    80102698 <namex+0x138>
    memmove(name, s, DIRSIZ);
801025ec:	83 ec 04             	sub    $0x4,%esp
801025ef:	6a 0e                	push   $0xe
801025f1:	53                   	push   %ebx
    path++;
801025f2:	89 fb                	mov    %edi,%ebx
    memmove(name, s, DIRSIZ);
801025f4:	ff 75 e4             	push   -0x1c(%ebp)
801025f7:	e8 d4 28 00 00       	call   80104ed0 <memmove>
801025fc:	83 c4 10             	add    $0x10,%esp
  while (*path == '/')
801025ff:	80 3f 2f             	cmpb   $0x2f,(%edi)
80102602:	75 0c                	jne    80102610 <namex+0xb0>
80102604:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
80102608:	83 c3 01             	add    $0x1,%ebx
  while (*path == '/')
8010260b:	80 3b 2f             	cmpb   $0x2f,(%ebx)
8010260e:	74 f8                	je     80102608 <namex+0xa8>

  while ((path = skipelem(path, name)) != 0)
  {
    ilock(ip);
80102610:	83 ec 0c             	sub    $0xc,%esp
80102613:	56                   	push   %esi
80102614:	e8 37 f9 ff ff       	call   80101f50 <ilock>
    if (ip->type != T_DIR)
80102619:	83 c4 10             	add    $0x10,%esp
8010261c:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80102621:	0f 85 cd 00 00 00    	jne    801026f4 <namex+0x194>
    {
      iunlockput(ip);
      return 0;
    }
    if (nameiparent && *path == '\0')
80102627:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010262a:	85 c0                	test   %eax,%eax
8010262c:	74 09                	je     80102637 <namex+0xd7>
8010262e:	80 3b 00             	cmpb   $0x0,(%ebx)
80102631:	0f 84 22 01 00 00    	je     80102759 <namex+0x1f9>
    {
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if ((next = dirlookup(ip, name, 0)) == 0)
80102637:	83 ec 04             	sub    $0x4,%esp
8010263a:	6a 00                	push   $0x0
8010263c:	ff 75 e4             	push   -0x1c(%ebp)
8010263f:	56                   	push   %esi
80102640:	e8 6b fe ff ff       	call   801024b0 <dirlookup>
  if (ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80102645:	8d 56 0c             	lea    0xc(%esi),%edx
    if ((next = dirlookup(ip, name, 0)) == 0)
80102648:	83 c4 10             	add    $0x10,%esp
8010264b:	89 c7                	mov    %eax,%edi
8010264d:	85 c0                	test   %eax,%eax
8010264f:	0f 84 e1 00 00 00    	je     80102736 <namex+0x1d6>
  if (ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80102655:	83 ec 0c             	sub    $0xc,%esp
80102658:	89 55 e0             	mov    %edx,-0x20(%ebp)
8010265b:	52                   	push   %edx
8010265c:	e8 ef 24 00 00       	call   80104b50 <holdingsleep>
80102661:	83 c4 10             	add    $0x10,%esp
80102664:	85 c0                	test   %eax,%eax
80102666:	0f 84 30 01 00 00    	je     8010279c <namex+0x23c>
8010266c:	8b 56 08             	mov    0x8(%esi),%edx
8010266f:	85 d2                	test   %edx,%edx
80102671:	0f 8e 25 01 00 00    	jle    8010279c <namex+0x23c>
  releasesleep(&ip->lock);
80102677:	8b 55 e0             	mov    -0x20(%ebp),%edx
8010267a:	83 ec 0c             	sub    $0xc,%esp
8010267d:	52                   	push   %edx
8010267e:	e8 8d 24 00 00       	call   80104b10 <releasesleep>
  iput(ip);
80102683:	89 34 24             	mov    %esi,(%esp)
80102686:	89 fe                	mov    %edi,%esi
80102688:	e8 f3 f9 ff ff       	call   80102080 <iput>
8010268d:	83 c4 10             	add    $0x10,%esp
80102690:	e9 16 ff ff ff       	jmp    801025ab <namex+0x4b>
80102695:	8d 76 00             	lea    0x0(%esi),%esi
    name[len] = 0;
80102698:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
8010269b:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    memmove(name, s, len);
8010269e:	83 ec 04             	sub    $0x4,%esp
801026a1:	89 55 e0             	mov    %edx,-0x20(%ebp)
801026a4:	50                   	push   %eax
801026a5:	53                   	push   %ebx
    name[len] = 0;
801026a6:	89 fb                	mov    %edi,%ebx
    memmove(name, s, len);
801026a8:	ff 75 e4             	push   -0x1c(%ebp)
801026ab:	e8 20 28 00 00       	call   80104ed0 <memmove>
    name[len] = 0;
801026b0:	8b 55 e0             	mov    -0x20(%ebp),%edx
801026b3:	83 c4 10             	add    $0x10,%esp
801026b6:	c6 02 00             	movb   $0x0,(%edx)
801026b9:	e9 41 ff ff ff       	jmp    801025ff <namex+0x9f>
801026be:	66 90                	xchg   %ax,%ax
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if (nameiparent)
801026c0:	8b 45 dc             	mov    -0x24(%ebp),%eax
801026c3:	85 c0                	test   %eax,%eax
801026c5:	0f 85 be 00 00 00    	jne    80102789 <namex+0x229>
  {
    iput(ip);
    return 0;
  }
  return ip;
}
801026cb:	8d 65 f4             	lea    -0xc(%ebp),%esp
801026ce:	89 f0                	mov    %esi,%eax
801026d0:	5b                   	pop    %ebx
801026d1:	5e                   	pop    %esi
801026d2:	5f                   	pop    %edi
801026d3:	5d                   	pop    %ebp
801026d4:	c3                   	ret    
  while (*path != '/' && *path != 0)
801026d5:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801026d8:	89 df                	mov    %ebx,%edi
801026da:	31 c0                	xor    %eax,%eax
801026dc:	eb c0                	jmp    8010269e <namex+0x13e>
    ip = iget(ROOTDEV, ROOTINO);
801026de:	ba 01 00 00 00       	mov    $0x1,%edx
801026e3:	b8 01 00 00 00       	mov    $0x1,%eax
801026e8:	e8 33 f4 ff ff       	call   80101b20 <iget>
801026ed:	89 c6                	mov    %eax,%esi
801026ef:	e9 b7 fe ff ff       	jmp    801025ab <namex+0x4b>
  if (ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
801026f4:	83 ec 0c             	sub    $0xc,%esp
801026f7:	8d 5e 0c             	lea    0xc(%esi),%ebx
801026fa:	53                   	push   %ebx
801026fb:	e8 50 24 00 00       	call   80104b50 <holdingsleep>
80102700:	83 c4 10             	add    $0x10,%esp
80102703:	85 c0                	test   %eax,%eax
80102705:	0f 84 91 00 00 00    	je     8010279c <namex+0x23c>
8010270b:	8b 46 08             	mov    0x8(%esi),%eax
8010270e:	85 c0                	test   %eax,%eax
80102710:	0f 8e 86 00 00 00    	jle    8010279c <namex+0x23c>
  releasesleep(&ip->lock);
80102716:	83 ec 0c             	sub    $0xc,%esp
80102719:	53                   	push   %ebx
8010271a:	e8 f1 23 00 00       	call   80104b10 <releasesleep>
  iput(ip);
8010271f:	89 34 24             	mov    %esi,(%esp)
      return 0;
80102722:	31 f6                	xor    %esi,%esi
  iput(ip);
80102724:	e8 57 f9 ff ff       	call   80102080 <iput>
      return 0;
80102729:	83 c4 10             	add    $0x10,%esp
}
8010272c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010272f:	89 f0                	mov    %esi,%eax
80102731:	5b                   	pop    %ebx
80102732:	5e                   	pop    %esi
80102733:	5f                   	pop    %edi
80102734:	5d                   	pop    %ebp
80102735:	c3                   	ret    
  if (ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80102736:	83 ec 0c             	sub    $0xc,%esp
80102739:	89 55 e4             	mov    %edx,-0x1c(%ebp)
8010273c:	52                   	push   %edx
8010273d:	e8 0e 24 00 00       	call   80104b50 <holdingsleep>
80102742:	83 c4 10             	add    $0x10,%esp
80102745:	85 c0                	test   %eax,%eax
80102747:	74 53                	je     8010279c <namex+0x23c>
80102749:	8b 4e 08             	mov    0x8(%esi),%ecx
8010274c:	85 c9                	test   %ecx,%ecx
8010274e:	7e 4c                	jle    8010279c <namex+0x23c>
  releasesleep(&ip->lock);
80102750:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80102753:	83 ec 0c             	sub    $0xc,%esp
80102756:	52                   	push   %edx
80102757:	eb c1                	jmp    8010271a <namex+0x1ba>
  if (ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80102759:	83 ec 0c             	sub    $0xc,%esp
8010275c:	8d 5e 0c             	lea    0xc(%esi),%ebx
8010275f:	53                   	push   %ebx
80102760:	e8 eb 23 00 00       	call   80104b50 <holdingsleep>
80102765:	83 c4 10             	add    $0x10,%esp
80102768:	85 c0                	test   %eax,%eax
8010276a:	74 30                	je     8010279c <namex+0x23c>
8010276c:	8b 7e 08             	mov    0x8(%esi),%edi
8010276f:	85 ff                	test   %edi,%edi
80102771:	7e 29                	jle    8010279c <namex+0x23c>
  releasesleep(&ip->lock);
80102773:	83 ec 0c             	sub    $0xc,%esp
80102776:	53                   	push   %ebx
80102777:	e8 94 23 00 00       	call   80104b10 <releasesleep>
}
8010277c:	83 c4 10             	add    $0x10,%esp
}
8010277f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102782:	89 f0                	mov    %esi,%eax
80102784:	5b                   	pop    %ebx
80102785:	5e                   	pop    %esi
80102786:	5f                   	pop    %edi
80102787:	5d                   	pop    %ebp
80102788:	c3                   	ret    
    iput(ip);
80102789:	83 ec 0c             	sub    $0xc,%esp
8010278c:	56                   	push   %esi
    return 0;
8010278d:	31 f6                	xor    %esi,%esi
    iput(ip);
8010278f:	e8 ec f8 ff ff       	call   80102080 <iput>
    return 0;
80102794:	83 c4 10             	add    $0x10,%esp
80102797:	e9 2f ff ff ff       	jmp    801026cb <namex+0x16b>
    panic("iunlock");
8010279c:	83 ec 0c             	sub    $0xc,%esp
8010279f:	68 b7 7d 10 80       	push   $0x80107db7
801027a4:	e8 f7 db ff ff       	call   801003a0 <panic>
801027a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801027b0 <dirlink>:
{
801027b0:	55                   	push   %ebp
801027b1:	89 e5                	mov    %esp,%ebp
801027b3:	57                   	push   %edi
801027b4:	56                   	push   %esi
801027b5:	53                   	push   %ebx
801027b6:	83 ec 20             	sub    $0x20,%esp
801027b9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if ((ip = dirlookup(dp, name, 0)) != 0)
801027bc:	6a 00                	push   $0x0
801027be:	ff 75 0c             	push   0xc(%ebp)
801027c1:	53                   	push   %ebx
801027c2:	e8 e9 fc ff ff       	call   801024b0 <dirlookup>
801027c7:	83 c4 10             	add    $0x10,%esp
801027ca:	85 c0                	test   %eax,%eax
801027cc:	75 67                	jne    80102835 <dirlink+0x85>
  for (off = 0; off < dp->size; off += sizeof(de))
801027ce:	8b 7b 58             	mov    0x58(%ebx),%edi
801027d1:	8d 75 d8             	lea    -0x28(%ebp),%esi
801027d4:	85 ff                	test   %edi,%edi
801027d6:	74 29                	je     80102801 <dirlink+0x51>
801027d8:	31 ff                	xor    %edi,%edi
801027da:	8d 75 d8             	lea    -0x28(%ebp),%esi
801027dd:	eb 09                	jmp    801027e8 <dirlink+0x38>
801027df:	90                   	nop
801027e0:	83 c7 10             	add    $0x10,%edi
801027e3:	3b 7b 58             	cmp    0x58(%ebx),%edi
801027e6:	73 19                	jae    80102801 <dirlink+0x51>
    if (readi(dp, (char *)&de, off, sizeof(de)) != sizeof(de))
801027e8:	6a 10                	push   $0x10
801027ea:	57                   	push   %edi
801027eb:	56                   	push   %esi
801027ec:	53                   	push   %ebx
801027ed:	e8 6e fa ff ff       	call   80102260 <readi>
801027f2:	83 c4 10             	add    $0x10,%esp
801027f5:	83 f8 10             	cmp    $0x10,%eax
801027f8:	75 4e                	jne    80102848 <dirlink+0x98>
    if (de.inum == 0)
801027fa:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
801027ff:	75 df                	jne    801027e0 <dirlink+0x30>
  strncpy(de.name, name, DIRSIZ);
80102801:	83 ec 04             	sub    $0x4,%esp
80102804:	8d 45 da             	lea    -0x26(%ebp),%eax
80102807:	6a 0e                	push   $0xe
80102809:	ff 75 0c             	push   0xc(%ebp)
8010280c:	50                   	push   %eax
8010280d:	e8 7e 27 00 00       	call   80104f90 <strncpy>
  if (writei(dp, (char *)&de, off, sizeof(de)) != sizeof(de))
80102812:	6a 10                	push   $0x10
  de.inum = inum;
80102814:	8b 45 10             	mov    0x10(%ebp),%eax
  if (writei(dp, (char *)&de, off, sizeof(de)) != sizeof(de))
80102817:	57                   	push   %edi
80102818:	56                   	push   %esi
80102819:	53                   	push   %ebx
  de.inum = inum;
8010281a:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if (writei(dp, (char *)&de, off, sizeof(de)) != sizeof(de))
8010281e:	e8 3d fb ff ff       	call   80102360 <writei>
80102823:	83 c4 20             	add    $0x20,%esp
80102826:	83 f8 10             	cmp    $0x10,%eax
80102829:	75 2a                	jne    80102855 <dirlink+0xa5>
  return 0;
8010282b:	31 c0                	xor    %eax,%eax
}
8010282d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102830:	5b                   	pop    %ebx
80102831:	5e                   	pop    %esi
80102832:	5f                   	pop    %edi
80102833:	5d                   	pop    %ebp
80102834:	c3                   	ret    
    iput(ip);
80102835:	83 ec 0c             	sub    $0xc,%esp
80102838:	50                   	push   %eax
80102839:	e8 42 f8 ff ff       	call   80102080 <iput>
    return -1;
8010283e:	83 c4 10             	add    $0x10,%esp
80102841:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102846:	eb e5                	jmp    8010282d <dirlink+0x7d>
      panic("dirlink read");
80102848:	83 ec 0c             	sub    $0xc,%esp
8010284b:	68 e0 7d 10 80       	push   $0x80107de0
80102850:	e8 4b db ff ff       	call   801003a0 <panic>
    panic("dirlink");
80102855:	83 ec 0c             	sub    $0xc,%esp
80102858:	68 c6 83 10 80       	push   $0x801083c6
8010285d:	e8 3e db ff ff       	call   801003a0 <panic>
80102862:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102869:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102870 <namei>:

struct inode *
namei(char *path)
{
80102870:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
80102871:	31 d2                	xor    %edx,%edx
{
80102873:	89 e5                	mov    %esp,%ebp
80102875:	83 ec 18             	sub    $0x18,%esp
  return namex(path, 0, name);
80102878:	8b 45 08             	mov    0x8(%ebp),%eax
8010287b:	8d 4d ea             	lea    -0x16(%ebp),%ecx
8010287e:	e8 dd fc ff ff       	call   80102560 <namex>
}
80102883:	c9                   	leave  
80102884:	c3                   	ret    
80102885:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010288c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102890 <nameiparent>:

struct inode *
nameiparent(char *path, char *name)
{
80102890:	55                   	push   %ebp
  return namex(path, 1, name);
80102891:	ba 01 00 00 00       	mov    $0x1,%edx
{
80102896:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
80102898:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010289b:	8b 45 08             	mov    0x8(%ebp),%eax
}
8010289e:	5d                   	pop    %ebp
  return namex(path, 1, name);
8010289f:	e9 bc fc ff ff       	jmp    80102560 <namex>
801028a4:	66 90                	xchg   %ax,%ax
801028a6:	66 90                	xchg   %ax,%ax
801028a8:	66 90                	xchg   %ax,%ax
801028aa:	66 90                	xchg   %ax,%ax
801028ac:	66 90                	xchg   %ax,%ax
801028ae:	66 90                	xchg   %ax,%ax

801028b0 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
801028b0:	55                   	push   %ebp
801028b1:	89 e5                	mov    %esp,%ebp
801028b3:	57                   	push   %edi
801028b4:	56                   	push   %esi
801028b5:	53                   	push   %ebx
801028b6:	83 ec 0c             	sub    $0xc,%esp
  if(b == 0)
801028b9:	85 c0                	test   %eax,%eax
801028bb:	0f 84 b4 00 00 00    	je     80102975 <idestart+0xc5>
    panic("idestart");
  if(b->blockno >= FSSIZE)
801028c1:	8b 70 08             	mov    0x8(%eax),%esi
801028c4:	89 c3                	mov    %eax,%ebx
801028c6:	81 fe e7 03 00 00    	cmp    $0x3e7,%esi
801028cc:	0f 87 96 00 00 00    	ja     80102968 <idestart+0xb8>
  asm volatile("in %1,%0" : "=a"(data) : "d"(port));
801028d2:	b9 f7 01 00 00       	mov    $0x1f7,%ecx
801028d7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801028de:	66 90                	xchg   %ax,%ax
801028e0:	89 ca                	mov    %ecx,%edx
801028e2:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
801028e3:	83 e0 c0             	and    $0xffffffc0,%eax
801028e6:	3c 40                	cmp    $0x40,%al
801028e8:	75 f6                	jne    801028e0 <idestart+0x30>
  asm volatile("out %0,%1" : : "a"(data), "d"(port));
801028ea:	31 ff                	xor    %edi,%edi
801028ec:	ba f6 03 00 00       	mov    $0x3f6,%edx
801028f1:	89 f8                	mov    %edi,%eax
801028f3:	ee                   	out    %al,(%dx)
801028f4:	b8 01 00 00 00       	mov    $0x1,%eax
801028f9:	ba f2 01 00 00       	mov    $0x1f2,%edx
801028fe:	ee                   	out    %al,(%dx)
801028ff:	ba f3 01 00 00       	mov    $0x1f3,%edx
80102904:	89 f0                	mov    %esi,%eax
80102906:	ee                   	out    %al,(%dx)

  idewait(0);
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
80102907:	89 f0                	mov    %esi,%eax
80102909:	ba f4 01 00 00       	mov    $0x1f4,%edx
8010290e:	c1 f8 08             	sar    $0x8,%eax
80102911:	ee                   	out    %al,(%dx)
80102912:	ba f5 01 00 00       	mov    $0x1f5,%edx
80102917:	89 f8                	mov    %edi,%eax
80102919:	ee                   	out    %al,(%dx)
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
8010291a:	0f b6 43 04          	movzbl 0x4(%ebx),%eax
8010291e:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102923:	c1 e0 04             	shl    $0x4,%eax
80102926:	83 e0 10             	and    $0x10,%eax
80102929:	83 c8 e0             	or     $0xffffffe0,%eax
8010292c:	ee                   	out    %al,(%dx)
  if(b->flags & B_DIRTY){
8010292d:	f6 03 04             	testb  $0x4,(%ebx)
80102930:	75 16                	jne    80102948 <idestart+0x98>
80102932:	b8 20 00 00 00       	mov    $0x20,%eax
80102937:	89 ca                	mov    %ecx,%edx
80102939:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
8010293a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010293d:	5b                   	pop    %ebx
8010293e:	5e                   	pop    %esi
8010293f:	5f                   	pop    %edi
80102940:	5d                   	pop    %ebp
80102941:	c3                   	ret    
80102942:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102948:	b8 30 00 00 00       	mov    $0x30,%eax
8010294d:	89 ca                	mov    %ecx,%edx
8010294f:	ee                   	out    %al,(%dx)
  asm volatile("cld; rep outsl" : "=S"(addr), "=c"(cnt) : "d"(port), "0"(addr), "1"(cnt) : "cc");
80102950:	b9 80 00 00 00       	mov    $0x80,%ecx
    outsl(0x1f0, b->data, BSIZE/4);
80102955:	8d 73 5c             	lea    0x5c(%ebx),%esi
80102958:	ba f0 01 00 00       	mov    $0x1f0,%edx
8010295d:	fc                   	cld    
8010295e:	f3 6f                	rep outsl %ds:(%esi),(%dx)
}
80102960:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102963:	5b                   	pop    %ebx
80102964:	5e                   	pop    %esi
80102965:	5f                   	pop    %edi
80102966:	5d                   	pop    %ebp
80102967:	c3                   	ret    
    panic("incorrect blockno");
80102968:	83 ec 0c             	sub    $0xc,%esp
8010296b:	68 4c 7e 10 80       	push   $0x80107e4c
80102970:	e8 2b da ff ff       	call   801003a0 <panic>
    panic("idestart");
80102975:	83 ec 0c             	sub    $0xc,%esp
80102978:	68 43 7e 10 80       	push   $0x80107e43
8010297d:	e8 1e da ff ff       	call   801003a0 <panic>
80102982:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102989:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102990 <ideinit>:
{
80102990:	55                   	push   %ebp
80102991:	89 e5                	mov    %esp,%ebp
80102993:	83 ec 10             	sub    $0x10,%esp
  initlock(&idelock, "ide");
80102996:	68 5e 7e 10 80       	push   $0x80107e5e
8010299b:	68 40 32 11 80       	push   $0x80113240
801029a0:	e8 fb 21 00 00       	call   80104ba0 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
801029a5:	58                   	pop    %eax
801029a6:	a1 c4 33 11 80       	mov    0x801133c4,%eax
801029ab:	5a                   	pop    %edx
801029ac:	83 e8 01             	sub    $0x1,%eax
801029af:	50                   	push   %eax
801029b0:	6a 0e                	push   $0xe
801029b2:	e8 99 02 00 00       	call   80102c50 <ioapicenable>
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
801029b7:	83 c4 10             	add    $0x10,%esp
  asm volatile("in %1,%0" : "=a"(data) : "d"(port));
801029ba:	ba f7 01 00 00       	mov    $0x1f7,%edx
801029bf:	90                   	nop
801029c0:	ec                   	in     (%dx),%al
801029c1:	83 e0 c0             	and    $0xffffffc0,%eax
801029c4:	3c 40                	cmp    $0x40,%al
801029c6:	75 f8                	jne    801029c0 <ideinit+0x30>
  asm volatile("out %0,%1" : : "a"(data), "d"(port));
801029c8:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
801029cd:	ba f6 01 00 00       	mov    $0x1f6,%edx
801029d2:	ee                   	out    %al,(%dx)
801029d3:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
  asm volatile("in %1,%0" : "=a"(data) : "d"(port));
801029d8:	ba f7 01 00 00       	mov    $0x1f7,%edx
801029dd:	eb 06                	jmp    801029e5 <ideinit+0x55>
801029df:	90                   	nop
  for(i=0; i<1000; i++){
801029e0:	83 e9 01             	sub    $0x1,%ecx
801029e3:	74 0f                	je     801029f4 <ideinit+0x64>
801029e5:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
801029e6:	84 c0                	test   %al,%al
801029e8:	74 f6                	je     801029e0 <ideinit+0x50>
      havedisk1 = 1;
801029ea:	c7 05 20 32 11 80 01 	movl   $0x1,0x80113220
801029f1:	00 00 00 
  asm volatile("out %0,%1" : : "a"(data), "d"(port));
801029f4:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
801029f9:	ba f6 01 00 00       	mov    $0x1f6,%edx
801029fe:	ee                   	out    %al,(%dx)
}
801029ff:	c9                   	leave  
80102a00:	c3                   	ret    
80102a01:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102a08:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102a0f:	90                   	nop

80102a10 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
80102a10:	55                   	push   %ebp
80102a11:	89 e5                	mov    %esp,%ebp
80102a13:	57                   	push   %edi
80102a14:	56                   	push   %esi
80102a15:	53                   	push   %ebx
80102a16:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
80102a19:	68 40 32 11 80       	push   $0x80113240
80102a1e:	e8 4d 23 00 00       	call   80104d70 <acquire>

  if((b = idequeue) == 0){
80102a23:	8b 1d 24 32 11 80    	mov    0x80113224,%ebx
80102a29:	83 c4 10             	add    $0x10,%esp
80102a2c:	85 db                	test   %ebx,%ebx
80102a2e:	74 63                	je     80102a93 <ideintr+0x83>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
80102a30:	8b 43 58             	mov    0x58(%ebx),%eax
80102a33:	a3 24 32 11 80       	mov    %eax,0x80113224

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
80102a38:	8b 33                	mov    (%ebx),%esi
80102a3a:	f7 c6 04 00 00 00    	test   $0x4,%esi
80102a40:	75 2f                	jne    80102a71 <ideintr+0x61>
  asm volatile("in %1,%0" : "=a"(data) : "d"(port));
80102a42:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102a47:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102a4e:	66 90                	xchg   %ax,%ax
80102a50:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102a51:	89 c1                	mov    %eax,%ecx
80102a53:	83 e1 c0             	and    $0xffffffc0,%ecx
80102a56:	80 f9 40             	cmp    $0x40,%cl
80102a59:	75 f5                	jne    80102a50 <ideintr+0x40>
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
80102a5b:	a8 21                	test   $0x21,%al
80102a5d:	75 12                	jne    80102a71 <ideintr+0x61>
    insl(0x1f0, b->data, BSIZE/4);
80102a5f:	8d 7b 5c             	lea    0x5c(%ebx),%edi
  asm volatile("cld; rep insl" : "=D"(addr), "=c"(cnt) : "d"(port), "0"(addr), "1"(cnt) : "memory", "cc");
80102a62:	b9 80 00 00 00       	mov    $0x80,%ecx
80102a67:	ba f0 01 00 00       	mov    $0x1f0,%edx
80102a6c:	fc                   	cld    
80102a6d:	f3 6d                	rep insl (%dx),%es:(%edi)

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
80102a6f:	8b 33                	mov    (%ebx),%esi
  b->flags &= ~B_DIRTY;
80102a71:	83 e6 fb             	and    $0xfffffffb,%esi
  wakeup(b);
80102a74:	83 ec 0c             	sub    $0xc,%esp
  b->flags &= ~B_DIRTY;
80102a77:	83 ce 02             	or     $0x2,%esi
80102a7a:	89 33                	mov    %esi,(%ebx)
  wakeup(b);
80102a7c:	53                   	push   %ebx
80102a7d:	e8 4e 1e 00 00       	call   801048d0 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
80102a82:	a1 24 32 11 80       	mov    0x80113224,%eax
80102a87:	83 c4 10             	add    $0x10,%esp
80102a8a:	85 c0                	test   %eax,%eax
80102a8c:	74 05                	je     80102a93 <ideintr+0x83>
    idestart(idequeue);
80102a8e:	e8 1d fe ff ff       	call   801028b0 <idestart>
    release(&idelock);
80102a93:	83 ec 0c             	sub    $0xc,%esp
80102a96:	68 40 32 11 80       	push   $0x80113240
80102a9b:	e8 70 22 00 00       	call   80104d10 <release>

  release(&idelock);
}
80102aa0:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102aa3:	5b                   	pop    %ebx
80102aa4:	5e                   	pop    %esi
80102aa5:	5f                   	pop    %edi
80102aa6:	5d                   	pop    %ebp
80102aa7:	c3                   	ret    
80102aa8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102aaf:	90                   	nop

80102ab0 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
80102ab0:	55                   	push   %ebp
80102ab1:	89 e5                	mov    %esp,%ebp
80102ab3:	53                   	push   %ebx
80102ab4:	83 ec 10             	sub    $0x10,%esp
80102ab7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
80102aba:	8d 43 0c             	lea    0xc(%ebx),%eax
80102abd:	50                   	push   %eax
80102abe:	e8 8d 20 00 00       	call   80104b50 <holdingsleep>
80102ac3:	83 c4 10             	add    $0x10,%esp
80102ac6:	85 c0                	test   %eax,%eax
80102ac8:	0f 84 c3 00 00 00    	je     80102b91 <iderw+0xe1>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
80102ace:	8b 03                	mov    (%ebx),%eax
80102ad0:	83 e0 06             	and    $0x6,%eax
80102ad3:	83 f8 02             	cmp    $0x2,%eax
80102ad6:	0f 84 a8 00 00 00    	je     80102b84 <iderw+0xd4>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
80102adc:	8b 53 04             	mov    0x4(%ebx),%edx
80102adf:	85 d2                	test   %edx,%edx
80102ae1:	74 0d                	je     80102af0 <iderw+0x40>
80102ae3:	a1 20 32 11 80       	mov    0x80113220,%eax
80102ae8:	85 c0                	test   %eax,%eax
80102aea:	0f 84 87 00 00 00    	je     80102b77 <iderw+0xc7>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
80102af0:	83 ec 0c             	sub    $0xc,%esp
80102af3:	68 40 32 11 80       	push   $0x80113240
80102af8:	e8 73 22 00 00       	call   80104d70 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102afd:	a1 24 32 11 80       	mov    0x80113224,%eax
  b->qnext = 0;
80102b02:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102b09:	83 c4 10             	add    $0x10,%esp
80102b0c:	85 c0                	test   %eax,%eax
80102b0e:	74 60                	je     80102b70 <iderw+0xc0>
80102b10:	89 c2                	mov    %eax,%edx
80102b12:	8b 40 58             	mov    0x58(%eax),%eax
80102b15:	85 c0                	test   %eax,%eax
80102b17:	75 f7                	jne    80102b10 <iderw+0x60>
80102b19:	83 c2 58             	add    $0x58,%edx
    ;
  *pp = b;
80102b1c:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
80102b1e:	39 1d 24 32 11 80    	cmp    %ebx,0x80113224
80102b24:	74 3a                	je     80102b60 <iderw+0xb0>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
80102b26:	8b 03                	mov    (%ebx),%eax
80102b28:	83 e0 06             	and    $0x6,%eax
80102b2b:	83 f8 02             	cmp    $0x2,%eax
80102b2e:	74 1b                	je     80102b4b <iderw+0x9b>
    sleep(b, &idelock);
80102b30:	83 ec 08             	sub    $0x8,%esp
80102b33:	68 40 32 11 80       	push   $0x80113240
80102b38:	53                   	push   %ebx
80102b39:	e8 d2 1c 00 00       	call   80104810 <sleep>
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
80102b3e:	8b 03                	mov    (%ebx),%eax
80102b40:	83 c4 10             	add    $0x10,%esp
80102b43:	83 e0 06             	and    $0x6,%eax
80102b46:	83 f8 02             	cmp    $0x2,%eax
80102b49:	75 e5                	jne    80102b30 <iderw+0x80>
  }


  release(&idelock);
80102b4b:	c7 45 08 40 32 11 80 	movl   $0x80113240,0x8(%ebp)
}
80102b52:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102b55:	c9                   	leave  
  release(&idelock);
80102b56:	e9 b5 21 00 00       	jmp    80104d10 <release>
80102b5b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102b5f:	90                   	nop
    idestart(b);
80102b60:	89 d8                	mov    %ebx,%eax
80102b62:	e8 49 fd ff ff       	call   801028b0 <idestart>
80102b67:	eb bd                	jmp    80102b26 <iderw+0x76>
80102b69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102b70:	ba 24 32 11 80       	mov    $0x80113224,%edx
80102b75:	eb a5                	jmp    80102b1c <iderw+0x6c>
    panic("iderw: ide disk 1 not present");
80102b77:	83 ec 0c             	sub    $0xc,%esp
80102b7a:	68 8d 7e 10 80       	push   $0x80107e8d
80102b7f:	e8 1c d8 ff ff       	call   801003a0 <panic>
    panic("iderw: nothing to do");
80102b84:	83 ec 0c             	sub    $0xc,%esp
80102b87:	68 78 7e 10 80       	push   $0x80107e78
80102b8c:	e8 0f d8 ff ff       	call   801003a0 <panic>
    panic("iderw: buf not locked");
80102b91:	83 ec 0c             	sub    $0xc,%esp
80102b94:	68 62 7e 10 80       	push   $0x80107e62
80102b99:	e8 02 d8 ff ff       	call   801003a0 <panic>
80102b9e:	66 90                	xchg   %ax,%ax

80102ba0 <ioapicinit>:
80102ba0:	55                   	push   %ebp
80102ba1:	c7 05 74 32 11 80 00 	movl   $0xfec00000,0x80113274
80102ba8:	00 c0 fe 
80102bab:	89 e5                	mov    %esp,%ebp
80102bad:	56                   	push   %esi
80102bae:	53                   	push   %ebx
80102baf:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
80102bb6:	00 00 00 
80102bb9:	8b 15 74 32 11 80    	mov    0x80113274,%edx
80102bbf:	8b 72 10             	mov    0x10(%edx),%esi
80102bc2:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
80102bc8:	8b 0d 74 32 11 80    	mov    0x80113274,%ecx
80102bce:	0f b6 15 c0 33 11 80 	movzbl 0x801133c0,%edx
80102bd5:	c1 ee 10             	shr    $0x10,%esi
80102bd8:	89 f0                	mov    %esi,%eax
80102bda:	0f b6 f0             	movzbl %al,%esi
80102bdd:	8b 41 10             	mov    0x10(%ecx),%eax
80102be0:	c1 e8 18             	shr    $0x18,%eax
80102be3:	39 c2                	cmp    %eax,%edx
80102be5:	74 16                	je     80102bfd <ioapicinit+0x5d>
80102be7:	83 ec 0c             	sub    $0xc,%esp
80102bea:	68 ac 7e 10 80       	push   $0x80107eac
80102bef:	e8 5c db ff ff       	call   80100750 <cprintf>
80102bf4:	8b 0d 74 32 11 80    	mov    0x80113274,%ecx
80102bfa:	83 c4 10             	add    $0x10,%esp
80102bfd:	83 c6 21             	add    $0x21,%esi
80102c00:	ba 10 00 00 00       	mov    $0x10,%edx
80102c05:	b8 20 00 00 00       	mov    $0x20,%eax
80102c0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102c10:	89 11                	mov    %edx,(%ecx)
80102c12:	89 c3                	mov    %eax,%ebx
80102c14:	8b 0d 74 32 11 80    	mov    0x80113274,%ecx
80102c1a:	83 c0 01             	add    $0x1,%eax
80102c1d:	81 cb 00 00 01 00    	or     $0x10000,%ebx
80102c23:	89 59 10             	mov    %ebx,0x10(%ecx)
80102c26:	8d 5a 01             	lea    0x1(%edx),%ebx
80102c29:	83 c2 02             	add    $0x2,%edx
80102c2c:	89 19                	mov    %ebx,(%ecx)
80102c2e:	8b 0d 74 32 11 80    	mov    0x80113274,%ecx
80102c34:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
80102c3b:	39 f0                	cmp    %esi,%eax
80102c3d:	75 d1                	jne    80102c10 <ioapicinit+0x70>
80102c3f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102c42:	5b                   	pop    %ebx
80102c43:	5e                   	pop    %esi
80102c44:	5d                   	pop    %ebp
80102c45:	c3                   	ret    
80102c46:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102c4d:	8d 76 00             	lea    0x0(%esi),%esi

80102c50 <ioapicenable>:
80102c50:	55                   	push   %ebp
80102c51:	8b 0d 74 32 11 80    	mov    0x80113274,%ecx
80102c57:	89 e5                	mov    %esp,%ebp
80102c59:	8b 45 08             	mov    0x8(%ebp),%eax
80102c5c:	8d 50 20             	lea    0x20(%eax),%edx
80102c5f:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
80102c63:	89 01                	mov    %eax,(%ecx)
80102c65:	8b 0d 74 32 11 80    	mov    0x80113274,%ecx
80102c6b:	83 c0 01             	add    $0x1,%eax
80102c6e:	89 51 10             	mov    %edx,0x10(%ecx)
80102c71:	8b 55 0c             	mov    0xc(%ebp),%edx
80102c74:	89 01                	mov    %eax,(%ecx)
80102c76:	a1 74 32 11 80       	mov    0x80113274,%eax
80102c7b:	c1 e2 18             	shl    $0x18,%edx
80102c7e:	89 50 10             	mov    %edx,0x10(%eax)
80102c81:	5d                   	pop    %ebp
80102c82:	c3                   	ret    
80102c83:	66 90                	xchg   %ax,%ax
80102c85:	66 90                	xchg   %ax,%ax
80102c87:	66 90                	xchg   %ax,%ax
80102c89:	66 90                	xchg   %ax,%ax
80102c8b:	66 90                	xchg   %ax,%ax
80102c8d:	66 90                	xchg   %ax,%ax
80102c8f:	90                   	nop

80102c90 <kfree>:
80102c90:	55                   	push   %ebp
80102c91:	89 e5                	mov    %esp,%ebp
80102c93:	53                   	push   %ebx
80102c94:	83 ec 04             	sub    $0x4,%esp
80102c97:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102c9a:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
80102ca0:	75 76                	jne    80102d18 <kfree+0x88>
80102ca2:	81 fb 10 71 11 80    	cmp    $0x80117110,%ebx
80102ca8:	72 6e                	jb     80102d18 <kfree+0x88>
80102caa:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80102cb0:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80102cb5:	77 61                	ja     80102d18 <kfree+0x88>
80102cb7:	83 ec 04             	sub    $0x4,%esp
80102cba:	68 00 10 00 00       	push   $0x1000
80102cbf:	6a 01                	push   $0x1
80102cc1:	53                   	push   %ebx
80102cc2:	e8 69 21 00 00       	call   80104e30 <memset>
80102cc7:	8b 15 b4 32 11 80    	mov    0x801132b4,%edx
80102ccd:	83 c4 10             	add    $0x10,%esp
80102cd0:	85 d2                	test   %edx,%edx
80102cd2:	75 1c                	jne    80102cf0 <kfree+0x60>
80102cd4:	a1 b8 32 11 80       	mov    0x801132b8,%eax
80102cd9:	89 03                	mov    %eax,(%ebx)
80102cdb:	a1 b4 32 11 80       	mov    0x801132b4,%eax
80102ce0:	89 1d b8 32 11 80    	mov    %ebx,0x801132b8
80102ce6:	85 c0                	test   %eax,%eax
80102ce8:	75 1e                	jne    80102d08 <kfree+0x78>
80102cea:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102ced:	c9                   	leave  
80102cee:	c3                   	ret    
80102cef:	90                   	nop
80102cf0:	83 ec 0c             	sub    $0xc,%esp
80102cf3:	68 80 32 11 80       	push   $0x80113280
80102cf8:	e8 73 20 00 00       	call   80104d70 <acquire>
80102cfd:	83 c4 10             	add    $0x10,%esp
80102d00:	eb d2                	jmp    80102cd4 <kfree+0x44>
80102d02:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102d08:	c7 45 08 80 32 11 80 	movl   $0x80113280,0x8(%ebp)
80102d0f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102d12:	c9                   	leave  
80102d13:	e9 f8 1f 00 00       	jmp    80104d10 <release>
80102d18:	83 ec 0c             	sub    $0xc,%esp
80102d1b:	68 de 7e 10 80       	push   $0x80107ede
80102d20:	e8 7b d6 ff ff       	call   801003a0 <panic>
80102d25:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102d2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102d30 <freerange>:
80102d30:	55                   	push   %ebp
80102d31:	89 e5                	mov    %esp,%ebp
80102d33:	56                   	push   %esi
80102d34:	8b 45 08             	mov    0x8(%ebp),%eax
80102d37:	8b 75 0c             	mov    0xc(%ebp),%esi
80102d3a:	53                   	push   %ebx
80102d3b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102d41:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
80102d47:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80102d4d:	39 de                	cmp    %ebx,%esi
80102d4f:	72 23                	jb     80102d74 <freerange+0x44>
80102d51:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102d58:	83 ec 0c             	sub    $0xc,%esp
80102d5b:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
80102d61:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80102d67:	50                   	push   %eax
80102d68:	e8 23 ff ff ff       	call   80102c90 <kfree>
80102d6d:	83 c4 10             	add    $0x10,%esp
80102d70:	39 f3                	cmp    %esi,%ebx
80102d72:	76 e4                	jbe    80102d58 <freerange+0x28>
80102d74:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102d77:	5b                   	pop    %ebx
80102d78:	5e                   	pop    %esi
80102d79:	5d                   	pop    %ebp
80102d7a:	c3                   	ret    
80102d7b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102d7f:	90                   	nop

80102d80 <kinit2>:
80102d80:	55                   	push   %ebp
80102d81:	89 e5                	mov    %esp,%ebp
80102d83:	56                   	push   %esi
80102d84:	8b 45 08             	mov    0x8(%ebp),%eax
80102d87:	8b 75 0c             	mov    0xc(%ebp),%esi
80102d8a:	53                   	push   %ebx
80102d8b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102d91:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
80102d97:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80102d9d:	39 de                	cmp    %ebx,%esi
80102d9f:	72 23                	jb     80102dc4 <kinit2+0x44>
80102da1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102da8:	83 ec 0c             	sub    $0xc,%esp
80102dab:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
80102db1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80102db7:	50                   	push   %eax
80102db8:	e8 d3 fe ff ff       	call   80102c90 <kfree>
80102dbd:	83 c4 10             	add    $0x10,%esp
80102dc0:	39 de                	cmp    %ebx,%esi
80102dc2:	73 e4                	jae    80102da8 <kinit2+0x28>
80102dc4:	c7 05 b4 32 11 80 01 	movl   $0x1,0x801132b4
80102dcb:	00 00 00 
80102dce:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102dd1:	5b                   	pop    %ebx
80102dd2:	5e                   	pop    %esi
80102dd3:	5d                   	pop    %ebp
80102dd4:	c3                   	ret    
80102dd5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102ddc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102de0 <kinit1>:
80102de0:	55                   	push   %ebp
80102de1:	89 e5                	mov    %esp,%ebp
80102de3:	56                   	push   %esi
80102de4:	53                   	push   %ebx
80102de5:	8b 75 0c             	mov    0xc(%ebp),%esi
80102de8:	83 ec 08             	sub    $0x8,%esp
80102deb:	68 e4 7e 10 80       	push   $0x80107ee4
80102df0:	68 80 32 11 80       	push   $0x80113280
80102df5:	e8 a6 1d 00 00       	call   80104ba0 <initlock>
80102dfa:	8b 45 08             	mov    0x8(%ebp),%eax
80102dfd:	83 c4 10             	add    $0x10,%esp
80102e00:	c7 05 b4 32 11 80 00 	movl   $0x0,0x801132b4
80102e07:	00 00 00 
80102e0a:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102e10:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
80102e16:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80102e1c:	39 de                	cmp    %ebx,%esi
80102e1e:	72 1c                	jb     80102e3c <kinit1+0x5c>
80102e20:	83 ec 0c             	sub    $0xc,%esp
80102e23:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
80102e29:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80102e2f:	50                   	push   %eax
80102e30:	e8 5b fe ff ff       	call   80102c90 <kfree>
80102e35:	83 c4 10             	add    $0x10,%esp
80102e38:	39 de                	cmp    %ebx,%esi
80102e3a:	73 e4                	jae    80102e20 <kinit1+0x40>
80102e3c:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102e3f:	5b                   	pop    %ebx
80102e40:	5e                   	pop    %esi
80102e41:	5d                   	pop    %ebp
80102e42:	c3                   	ret    
80102e43:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102e4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102e50 <kalloc>:
80102e50:	a1 b4 32 11 80       	mov    0x801132b4,%eax
80102e55:	85 c0                	test   %eax,%eax
80102e57:	75 1f                	jne    80102e78 <kalloc+0x28>
80102e59:	a1 b8 32 11 80       	mov    0x801132b8,%eax
80102e5e:	85 c0                	test   %eax,%eax
80102e60:	74 0e                	je     80102e70 <kalloc+0x20>
80102e62:	8b 10                	mov    (%eax),%edx
80102e64:	89 15 b8 32 11 80    	mov    %edx,0x801132b8
80102e6a:	c3                   	ret    
80102e6b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102e6f:	90                   	nop
80102e70:	c3                   	ret    
80102e71:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102e78:	55                   	push   %ebp
80102e79:	89 e5                	mov    %esp,%ebp
80102e7b:	83 ec 24             	sub    $0x24,%esp
80102e7e:	68 80 32 11 80       	push   $0x80113280
80102e83:	e8 e8 1e 00 00       	call   80104d70 <acquire>
80102e88:	a1 b8 32 11 80       	mov    0x801132b8,%eax
80102e8d:	8b 15 b4 32 11 80    	mov    0x801132b4,%edx
80102e93:	83 c4 10             	add    $0x10,%esp
80102e96:	85 c0                	test   %eax,%eax
80102e98:	74 08                	je     80102ea2 <kalloc+0x52>
80102e9a:	8b 08                	mov    (%eax),%ecx
80102e9c:	89 0d b8 32 11 80    	mov    %ecx,0x801132b8
80102ea2:	85 d2                	test   %edx,%edx
80102ea4:	74 16                	je     80102ebc <kalloc+0x6c>
80102ea6:	83 ec 0c             	sub    $0xc,%esp
80102ea9:	89 45 f4             	mov    %eax,-0xc(%ebp)
80102eac:	68 80 32 11 80       	push   $0x80113280
80102eb1:	e8 5a 1e 00 00       	call   80104d10 <release>
80102eb6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102eb9:	83 c4 10             	add    $0x10,%esp
80102ebc:	c9                   	leave  
80102ebd:	c3                   	ret    
80102ebe:	66 90                	xchg   %ax,%ax

80102ec0 <kbdgetc>:
  asm volatile("in %1,%0" : "=a"(data) : "d"(port));
80102ec0:	ba 64 00 00 00       	mov    $0x64,%edx
80102ec5:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
80102ec6:	a8 01                	test   $0x1,%al
80102ec8:	0f 84 c2 00 00 00    	je     80102f90 <kbdgetc+0xd0>
{
80102ece:	55                   	push   %ebp
80102ecf:	ba 60 00 00 00       	mov    $0x60,%edx
80102ed4:	89 e5                	mov    %esp,%ebp
80102ed6:	53                   	push   %ebx
80102ed7:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
80102ed8:	8b 1d bc 32 11 80    	mov    0x801132bc,%ebx
  data = inb(KBDATAP);
80102ede:	0f b6 c8             	movzbl %al,%ecx
  if(data == 0xE0){
80102ee1:	3c e0                	cmp    $0xe0,%al
80102ee3:	74 5b                	je     80102f40 <kbdgetc+0x80>
    return 0;
  } else if(data & 0x80){
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
80102ee5:	89 da                	mov    %ebx,%edx
80102ee7:	83 e2 40             	and    $0x40,%edx
  } else if(data & 0x80){
80102eea:	84 c0                	test   %al,%al
80102eec:	78 62                	js     80102f50 <kbdgetc+0x90>
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
80102eee:	85 d2                	test   %edx,%edx
80102ef0:	74 09                	je     80102efb <kbdgetc+0x3b>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
80102ef2:	83 c8 80             	or     $0xffffff80,%eax
    shift &= ~E0ESC;
80102ef5:	83 e3 bf             	and    $0xffffffbf,%ebx
    data |= 0x80;
80102ef8:	0f b6 c8             	movzbl %al,%ecx
  }

  shift |= shiftcode[data];
80102efb:	0f b6 91 20 80 10 80 	movzbl -0x7fef7fe0(%ecx),%edx
  shift ^= togglecode[data];
80102f02:	0f b6 81 20 7f 10 80 	movzbl -0x7fef80e0(%ecx),%eax
  shift |= shiftcode[data];
80102f09:	09 da                	or     %ebx,%edx
  shift ^= togglecode[data];
80102f0b:	31 c2                	xor    %eax,%edx
  c = charcode[shift & (CTL | SHIFT)][data];
80102f0d:	89 d0                	mov    %edx,%eax
  shift ^= togglecode[data];
80102f0f:	89 15 bc 32 11 80    	mov    %edx,0x801132bc
  c = charcode[shift & (CTL | SHIFT)][data];
80102f15:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
80102f18:	83 e2 08             	and    $0x8,%edx
  c = charcode[shift & (CTL | SHIFT)][data];
80102f1b:	8b 04 85 00 7f 10 80 	mov    -0x7fef8100(,%eax,4),%eax
80102f22:	0f b6 04 08          	movzbl (%eax,%ecx,1),%eax
  if(shift & CAPSLOCK){
80102f26:	74 0b                	je     80102f33 <kbdgetc+0x73>
    if('a' <= c && c <= 'z')
80102f28:	8d 50 9f             	lea    -0x61(%eax),%edx
80102f2b:	83 fa 19             	cmp    $0x19,%edx
80102f2e:	77 48                	ja     80102f78 <kbdgetc+0xb8>
      c += 'A' - 'a';
80102f30:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
80102f33:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102f36:	c9                   	leave  
80102f37:	c3                   	ret    
80102f38:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102f3f:	90                   	nop
    shift |= E0ESC;
80102f40:	83 cb 40             	or     $0x40,%ebx
    return 0;
80102f43:	31 c0                	xor    %eax,%eax
    shift |= E0ESC;
80102f45:	89 1d bc 32 11 80    	mov    %ebx,0x801132bc
}
80102f4b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102f4e:	c9                   	leave  
80102f4f:	c3                   	ret    
    data = (shift & E0ESC ? data : data & 0x7F);
80102f50:	83 e0 7f             	and    $0x7f,%eax
80102f53:	85 d2                	test   %edx,%edx
80102f55:	0f 44 c8             	cmove  %eax,%ecx
    shift &= ~(shiftcode[data] | E0ESC);
80102f58:	0f b6 81 20 80 10 80 	movzbl -0x7fef7fe0(%ecx),%eax
80102f5f:	83 c8 40             	or     $0x40,%eax
80102f62:	0f b6 c0             	movzbl %al,%eax
80102f65:	f7 d0                	not    %eax
80102f67:	21 d8                	and    %ebx,%eax
}
80102f69:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    shift &= ~(shiftcode[data] | E0ESC);
80102f6c:	a3 bc 32 11 80       	mov    %eax,0x801132bc
    return 0;
80102f71:	31 c0                	xor    %eax,%eax
}
80102f73:	c9                   	leave  
80102f74:	c3                   	ret    
80102f75:	8d 76 00             	lea    0x0(%esi),%esi
    else if('A' <= c && c <= 'Z')
80102f78:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
80102f7b:	8d 50 20             	lea    0x20(%eax),%edx
}
80102f7e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102f81:	c9                   	leave  
      c += 'a' - 'A';
80102f82:	83 f9 1a             	cmp    $0x1a,%ecx
80102f85:	0f 42 c2             	cmovb  %edx,%eax
}
80102f88:	c3                   	ret    
80102f89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80102f90:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80102f95:	c3                   	ret    
80102f96:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102f9d:	8d 76 00             	lea    0x0(%esi),%esi

80102fa0 <kbdintr>:

void
kbdintr(void)
{
80102fa0:	55                   	push   %ebp
80102fa1:	89 e5                	mov    %esp,%ebp
80102fa3:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
80102fa6:	68 c0 2e 10 80       	push   $0x80102ec0
80102fab:	e8 60 de ff ff       	call   80100e10 <consoleintr>
}
80102fb0:	83 c4 10             	add    $0x10,%esp
80102fb3:	c9                   	leave  
80102fb4:	c3                   	ret    
80102fb5:	66 90                	xchg   %ax,%ax
80102fb7:	66 90                	xchg   %ax,%ax
80102fb9:	66 90                	xchg   %ax,%ax
80102fbb:	66 90                	xchg   %ax,%ax
80102fbd:	66 90                	xchg   %ax,%ax
80102fbf:	90                   	nop

80102fc0 <lapicinit>:
}

void
lapicinit(void)
{
  if(!lapic)
80102fc0:	a1 c0 32 11 80       	mov    0x801132c0,%eax
80102fc5:	85 c0                	test   %eax,%eax
80102fc7:	0f 84 cb 00 00 00    	je     80103098 <lapicinit+0xd8>
  lapic[index] = value;
80102fcd:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
80102fd4:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102fd7:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102fda:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
80102fe1:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102fe4:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102fe7:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
80102fee:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
80102ff1:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102ff4:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
80102ffb:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
80102ffe:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80103001:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
80103008:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010300b:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010300e:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
80103015:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80103018:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
8010301b:	8b 50 30             	mov    0x30(%eax),%edx
8010301e:	c1 ea 10             	shr    $0x10,%edx
80103021:	81 e2 fc 00 00 00    	and    $0xfc,%edx
80103027:	75 77                	jne    801030a0 <lapicinit+0xe0>
  lapic[index] = value;
80103029:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
80103030:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80103033:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80103036:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
8010303d:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80103040:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80103043:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
8010304a:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010304d:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80103050:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80103057:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010305a:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010305d:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
80103064:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80103067:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010306a:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
80103071:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
80103074:	8b 50 20             	mov    0x20(%eax),%edx
80103077:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010307e:	66 90                	xchg   %ax,%ax
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
80103080:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
80103086:	80 e6 10             	and    $0x10,%dh
80103089:	75 f5                	jne    80103080 <lapicinit+0xc0>
  lapic[index] = value;
8010308b:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
80103092:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80103095:	8b 40 20             	mov    0x20(%eax),%eax
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
80103098:	c3                   	ret    
80103099:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  lapic[index] = value;
801030a0:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
801030a7:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
801030aa:	8b 50 20             	mov    0x20(%eax),%edx
}
801030ad:	e9 77 ff ff ff       	jmp    80103029 <lapicinit+0x69>
801030b2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801030b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801030c0 <lapicid>:

int
lapicid(void)
{
  if (!lapic)
801030c0:	a1 c0 32 11 80       	mov    0x801132c0,%eax
801030c5:	85 c0                	test   %eax,%eax
801030c7:	74 07                	je     801030d0 <lapicid+0x10>
    return 0;
  return lapic[ID] >> 24;
801030c9:	8b 40 20             	mov    0x20(%eax),%eax
801030cc:	c1 e8 18             	shr    $0x18,%eax
801030cf:	c3                   	ret    
    return 0;
801030d0:	31 c0                	xor    %eax,%eax
}
801030d2:	c3                   	ret    
801030d3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801030da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801030e0 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
801030e0:	a1 c0 32 11 80       	mov    0x801132c0,%eax
801030e5:	85 c0                	test   %eax,%eax
801030e7:	74 0d                	je     801030f6 <lapiceoi+0x16>
  lapic[index] = value;
801030e9:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
801030f0:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801030f3:	8b 40 20             	mov    0x20(%eax),%eax
    lapicw(EOI, 0);
}
801030f6:	c3                   	ret    
801030f7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801030fe:	66 90                	xchg   %ax,%ax

80103100 <microdelay>:
// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
}
80103100:	c3                   	ret    
80103101:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103108:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010310f:	90                   	nop

80103110 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80103110:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a"(data), "d"(port));
80103111:	b8 0f 00 00 00       	mov    $0xf,%eax
80103116:	ba 70 00 00 00       	mov    $0x70,%edx
8010311b:	89 e5                	mov    %esp,%ebp
8010311d:	53                   	push   %ebx
8010311e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80103121:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103124:	ee                   	out    %al,(%dx)
80103125:	b8 0a 00 00 00       	mov    $0xa,%eax
8010312a:	ba 71 00 00 00       	mov    $0x71,%edx
8010312f:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
80103130:	31 c0                	xor    %eax,%eax
  wrv[1] = addr >> 4;

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
80103132:	c1 e3 18             	shl    $0x18,%ebx
  wrv[0] = 0;
80103135:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
8010313b:	89 c8                	mov    %ecx,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
8010313d:	c1 e9 0c             	shr    $0xc,%ecx
  lapicw(ICRHI, apicid<<24);
80103140:	89 da                	mov    %ebx,%edx
  wrv[1] = addr >> 4;
80103142:	c1 e8 04             	shr    $0x4,%eax
    lapicw(ICRLO, STARTUP | (addr>>12));
80103145:	80 cd 06             	or     $0x6,%ch
  wrv[1] = addr >> 4;
80103148:	66 a3 69 04 00 80    	mov    %ax,0x80000469
  lapic[index] = value;
8010314e:	a1 c0 32 11 80       	mov    0x801132c0,%eax
80103153:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80103159:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
8010315c:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
80103163:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
80103166:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80103169:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
80103170:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
80103173:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80103176:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
8010317c:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
8010317f:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80103185:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80103188:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
8010318e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80103191:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80103197:	8b 40 20             	mov    0x20(%eax),%eax
    microdelay(200);
  }
}
8010319a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010319d:	c9                   	leave  
8010319e:	c3                   	ret    
8010319f:	90                   	nop

801031a0 <cmostime>:
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void
cmostime(struct rtcdate *r)
{
801031a0:	55                   	push   %ebp
801031a1:	b8 0b 00 00 00       	mov    $0xb,%eax
801031a6:	ba 70 00 00 00       	mov    $0x70,%edx
801031ab:	89 e5                	mov    %esp,%ebp
801031ad:	57                   	push   %edi
801031ae:	56                   	push   %esi
801031af:	53                   	push   %ebx
801031b0:	83 ec 4c             	sub    $0x4c,%esp
801031b3:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a"(data) : "d"(port));
801031b4:	ba 71 00 00 00       	mov    $0x71,%edx
801031b9:	ec                   	in     (%dx),%al
  struct rtcdate t1, t2;
  int sb, bcd;

  sb = cmos_read(CMOS_STATB);

  bcd = (sb & (1 << 2)) == 0;
801031ba:	83 e0 04             	and    $0x4,%eax
  asm volatile("out %0,%1" : : "a"(data), "d"(port));
801031bd:	bb 70 00 00 00       	mov    $0x70,%ebx
801031c2:	88 45 b3             	mov    %al,-0x4d(%ebp)
801031c5:	8d 76 00             	lea    0x0(%esi),%esi
801031c8:	31 c0                	xor    %eax,%eax
801031ca:	89 da                	mov    %ebx,%edx
801031cc:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a"(data) : "d"(port));
801031cd:	b9 71 00 00 00       	mov    $0x71,%ecx
801031d2:	89 ca                	mov    %ecx,%edx
801031d4:	ec                   	in     (%dx),%al
801031d5:	88 45 b7             	mov    %al,-0x49(%ebp)
  asm volatile("out %0,%1" : : "a"(data), "d"(port));
801031d8:	89 da                	mov    %ebx,%edx
801031da:	b8 02 00 00 00       	mov    $0x2,%eax
801031df:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a"(data) : "d"(port));
801031e0:	89 ca                	mov    %ecx,%edx
801031e2:	ec                   	in     (%dx),%al
801031e3:	88 45 b6             	mov    %al,-0x4a(%ebp)
  asm volatile("out %0,%1" : : "a"(data), "d"(port));
801031e6:	89 da                	mov    %ebx,%edx
801031e8:	b8 04 00 00 00       	mov    $0x4,%eax
801031ed:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a"(data) : "d"(port));
801031ee:	89 ca                	mov    %ecx,%edx
801031f0:	ec                   	in     (%dx),%al
801031f1:	88 45 b5             	mov    %al,-0x4b(%ebp)
  asm volatile("out %0,%1" : : "a"(data), "d"(port));
801031f4:	89 da                	mov    %ebx,%edx
801031f6:	b8 07 00 00 00       	mov    $0x7,%eax
801031fb:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a"(data) : "d"(port));
801031fc:	89 ca                	mov    %ecx,%edx
801031fe:	ec                   	in     (%dx),%al
801031ff:	88 45 b4             	mov    %al,-0x4c(%ebp)
  asm volatile("out %0,%1" : : "a"(data), "d"(port));
80103202:	89 da                	mov    %ebx,%edx
80103204:	b8 08 00 00 00       	mov    $0x8,%eax
80103209:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a"(data) : "d"(port));
8010320a:	89 ca                	mov    %ecx,%edx
8010320c:	ec                   	in     (%dx),%al
8010320d:	89 c7                	mov    %eax,%edi
  asm volatile("out %0,%1" : : "a"(data), "d"(port));
8010320f:	89 da                	mov    %ebx,%edx
80103211:	b8 09 00 00 00       	mov    $0x9,%eax
80103216:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a"(data) : "d"(port));
80103217:	89 ca                	mov    %ecx,%edx
80103219:	ec                   	in     (%dx),%al
8010321a:	89 c6                	mov    %eax,%esi
  asm volatile("out %0,%1" : : "a"(data), "d"(port));
8010321c:	89 da                	mov    %ebx,%edx
8010321e:	b8 0a 00 00 00       	mov    $0xa,%eax
80103223:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a"(data) : "d"(port));
80103224:	89 ca                	mov    %ecx,%edx
80103226:	ec                   	in     (%dx),%al

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
80103227:	84 c0                	test   %al,%al
80103229:	78 9d                	js     801031c8 <cmostime+0x28>
  return inb(CMOS_RETURN);
8010322b:	0f b6 45 b7          	movzbl -0x49(%ebp),%eax
8010322f:	89 fa                	mov    %edi,%edx
80103231:	0f b6 fa             	movzbl %dl,%edi
80103234:	89 f2                	mov    %esi,%edx
80103236:	89 45 b8             	mov    %eax,-0x48(%ebp)
80103239:	0f b6 45 b6          	movzbl -0x4a(%ebp),%eax
8010323d:	0f b6 f2             	movzbl %dl,%esi
  asm volatile("out %0,%1" : : "a"(data), "d"(port));
80103240:	89 da                	mov    %ebx,%edx
80103242:	89 7d c8             	mov    %edi,-0x38(%ebp)
80103245:	89 45 bc             	mov    %eax,-0x44(%ebp)
80103248:	0f b6 45 b5          	movzbl -0x4b(%ebp),%eax
8010324c:	89 75 cc             	mov    %esi,-0x34(%ebp)
8010324f:	89 45 c0             	mov    %eax,-0x40(%ebp)
80103252:	0f b6 45 b4          	movzbl -0x4c(%ebp),%eax
80103256:	89 45 c4             	mov    %eax,-0x3c(%ebp)
80103259:	31 c0                	xor    %eax,%eax
8010325b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a"(data) : "d"(port));
8010325c:	89 ca                	mov    %ecx,%edx
8010325e:	ec                   	in     (%dx),%al
8010325f:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a"(data), "d"(port));
80103262:	89 da                	mov    %ebx,%edx
80103264:	89 45 d0             	mov    %eax,-0x30(%ebp)
80103267:	b8 02 00 00 00       	mov    $0x2,%eax
8010326c:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a"(data) : "d"(port));
8010326d:	89 ca                	mov    %ecx,%edx
8010326f:	ec                   	in     (%dx),%al
80103270:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a"(data), "d"(port));
80103273:	89 da                	mov    %ebx,%edx
80103275:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80103278:	b8 04 00 00 00       	mov    $0x4,%eax
8010327d:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a"(data) : "d"(port));
8010327e:	89 ca                	mov    %ecx,%edx
80103280:	ec                   	in     (%dx),%al
80103281:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a"(data), "d"(port));
80103284:	89 da                	mov    %ebx,%edx
80103286:	89 45 d8             	mov    %eax,-0x28(%ebp)
80103289:	b8 07 00 00 00       	mov    $0x7,%eax
8010328e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a"(data) : "d"(port));
8010328f:	89 ca                	mov    %ecx,%edx
80103291:	ec                   	in     (%dx),%al
80103292:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a"(data), "d"(port));
80103295:	89 da                	mov    %ebx,%edx
80103297:	89 45 dc             	mov    %eax,-0x24(%ebp)
8010329a:	b8 08 00 00 00       	mov    $0x8,%eax
8010329f:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a"(data) : "d"(port));
801032a0:	89 ca                	mov    %ecx,%edx
801032a2:	ec                   	in     (%dx),%al
801032a3:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a"(data), "d"(port));
801032a6:	89 da                	mov    %ebx,%edx
801032a8:	89 45 e0             	mov    %eax,-0x20(%ebp)
801032ab:	b8 09 00 00 00       	mov    $0x9,%eax
801032b0:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a"(data) : "d"(port));
801032b1:	89 ca                	mov    %ecx,%edx
801032b3:	ec                   	in     (%dx),%al
801032b4:	0f b6 c0             	movzbl %al,%eax
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
801032b7:	83 ec 04             	sub    $0x4,%esp
  return inb(CMOS_RETURN);
801032ba:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
801032bd:	8d 45 d0             	lea    -0x30(%ebp),%eax
801032c0:	6a 18                	push   $0x18
801032c2:	50                   	push   %eax
801032c3:	8d 45 b8             	lea    -0x48(%ebp),%eax
801032c6:	50                   	push   %eax
801032c7:	e8 b4 1b 00 00       	call   80104e80 <memcmp>
801032cc:	83 c4 10             	add    $0x10,%esp
801032cf:	85 c0                	test   %eax,%eax
801032d1:	0f 85 f1 fe ff ff    	jne    801031c8 <cmostime+0x28>
      break;
  }

  // convert
  if(bcd) {
801032d7:	80 7d b3 00          	cmpb   $0x0,-0x4d(%ebp)
801032db:	75 78                	jne    80103355 <cmostime+0x1b5>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
801032dd:	8b 45 b8             	mov    -0x48(%ebp),%eax
801032e0:	89 c2                	mov    %eax,%edx
801032e2:	83 e0 0f             	and    $0xf,%eax
801032e5:	c1 ea 04             	shr    $0x4,%edx
801032e8:	8d 14 92             	lea    (%edx,%edx,4),%edx
801032eb:	8d 04 50             	lea    (%eax,%edx,2),%eax
801032ee:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
801032f1:	8b 45 bc             	mov    -0x44(%ebp),%eax
801032f4:	89 c2                	mov    %eax,%edx
801032f6:	83 e0 0f             	and    $0xf,%eax
801032f9:	c1 ea 04             	shr    $0x4,%edx
801032fc:	8d 14 92             	lea    (%edx,%edx,4),%edx
801032ff:	8d 04 50             	lea    (%eax,%edx,2),%eax
80103302:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
80103305:	8b 45 c0             	mov    -0x40(%ebp),%eax
80103308:	89 c2                	mov    %eax,%edx
8010330a:	83 e0 0f             	and    $0xf,%eax
8010330d:	c1 ea 04             	shr    $0x4,%edx
80103310:	8d 14 92             	lea    (%edx,%edx,4),%edx
80103313:	8d 04 50             	lea    (%eax,%edx,2),%eax
80103316:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
80103319:	8b 45 c4             	mov    -0x3c(%ebp),%eax
8010331c:	89 c2                	mov    %eax,%edx
8010331e:	83 e0 0f             	and    $0xf,%eax
80103321:	c1 ea 04             	shr    $0x4,%edx
80103324:	8d 14 92             	lea    (%edx,%edx,4),%edx
80103327:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010332a:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
8010332d:	8b 45 c8             	mov    -0x38(%ebp),%eax
80103330:	89 c2                	mov    %eax,%edx
80103332:	83 e0 0f             	and    $0xf,%eax
80103335:	c1 ea 04             	shr    $0x4,%edx
80103338:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010333b:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010333e:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
80103341:	8b 45 cc             	mov    -0x34(%ebp),%eax
80103344:	89 c2                	mov    %eax,%edx
80103346:	83 e0 0f             	and    $0xf,%eax
80103349:	c1 ea 04             	shr    $0x4,%edx
8010334c:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010334f:	8d 04 50             	lea    (%eax,%edx,2),%eax
80103352:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
80103355:	8b 75 08             	mov    0x8(%ebp),%esi
80103358:	8b 45 b8             	mov    -0x48(%ebp),%eax
8010335b:	89 06                	mov    %eax,(%esi)
8010335d:	8b 45 bc             	mov    -0x44(%ebp),%eax
80103360:	89 46 04             	mov    %eax,0x4(%esi)
80103363:	8b 45 c0             	mov    -0x40(%ebp),%eax
80103366:	89 46 08             	mov    %eax,0x8(%esi)
80103369:	8b 45 c4             	mov    -0x3c(%ebp),%eax
8010336c:	89 46 0c             	mov    %eax,0xc(%esi)
8010336f:	8b 45 c8             	mov    -0x38(%ebp),%eax
80103372:	89 46 10             	mov    %eax,0x10(%esi)
80103375:	8b 45 cc             	mov    -0x34(%ebp),%eax
80103378:	89 46 14             	mov    %eax,0x14(%esi)
  r->year += 2000;
8010337b:	81 46 14 d0 07 00 00 	addl   $0x7d0,0x14(%esi)
}
80103382:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103385:	5b                   	pop    %ebx
80103386:	5e                   	pop    %esi
80103387:	5f                   	pop    %edi
80103388:	5d                   	pop    %ebp
80103389:	c3                   	ret    
8010338a:	66 90                	xchg   %ax,%ax
8010338c:	66 90                	xchg   %ax,%ax
8010338e:	66 90                	xchg   %ax,%ax

80103390 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++)
80103390:	8b 0d 28 33 11 80    	mov    0x80113328,%ecx
80103396:	85 c9                	test   %ecx,%ecx
80103398:	0f 8e 8a 00 00 00    	jle    80103428 <install_trans+0x98>
{
8010339e:	55                   	push   %ebp
8010339f:	89 e5                	mov    %esp,%ebp
801033a1:	57                   	push   %edi
  for (tail = 0; tail < log.lh.n; tail++)
801033a2:	31 ff                	xor    %edi,%edi
{
801033a4:	56                   	push   %esi
801033a5:	53                   	push   %ebx
801033a6:	83 ec 0c             	sub    $0xc,%esp
801033a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  {
    struct buf *lbuf = bread(log.dev, log.start + tail + 1); // read log block
801033b0:	a1 14 33 11 80       	mov    0x80113314,%eax
801033b5:	83 ec 08             	sub    $0x8,%esp
801033b8:	01 f8                	add    %edi,%eax
801033ba:	83 c0 01             	add    $0x1,%eax
801033bd:	50                   	push   %eax
801033be:	ff 35 24 33 11 80    	push   0x80113324
801033c4:	e8 07 cd ff ff       	call   801000d0 <bread>
801033c9:	89 c6                	mov    %eax,%esi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]);   // read dst
801033cb:	58                   	pop    %eax
801033cc:	5a                   	pop    %edx
801033cd:	ff 34 bd 2c 33 11 80 	push   -0x7feeccd4(,%edi,4)
801033d4:	ff 35 24 33 11 80    	push   0x80113324
  for (tail = 0; tail < log.lh.n; tail++)
801033da:	83 c7 01             	add    $0x1,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]);   // read dst
801033dd:	e8 ee cc ff ff       	call   801000d0 <bread>
    memmove(dbuf->data, lbuf->data, BSIZE);                  // copy block to dst
801033e2:	83 c4 0c             	add    $0xc,%esp
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]);   // read dst
801033e5:	89 c3                	mov    %eax,%ebx
    memmove(dbuf->data, lbuf->data, BSIZE);                  // copy block to dst
801033e7:	8d 46 5c             	lea    0x5c(%esi),%eax
801033ea:	68 00 02 00 00       	push   $0x200
801033ef:	50                   	push   %eax
801033f0:	8d 43 5c             	lea    0x5c(%ebx),%eax
801033f3:	50                   	push   %eax
801033f4:	e8 d7 1a 00 00       	call   80104ed0 <memmove>
    bwrite(dbuf);                                            // write dst to disk
801033f9:	89 1c 24             	mov    %ebx,(%esp)
801033fc:	e8 af cd ff ff       	call   801001b0 <bwrite>
    brelse(lbuf);
80103401:	89 34 24             	mov    %esi,(%esp)
80103404:	e8 e7 cd ff ff       	call   801001f0 <brelse>
    brelse(dbuf);
80103409:	89 1c 24             	mov    %ebx,(%esp)
8010340c:	e8 df cd ff ff       	call   801001f0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++)
80103411:	83 c4 10             	add    $0x10,%esp
80103414:	39 3d 28 33 11 80    	cmp    %edi,0x80113328
8010341a:	7f 94                	jg     801033b0 <install_trans+0x20>
  }
}
8010341c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010341f:	5b                   	pop    %ebx
80103420:	5e                   	pop    %esi
80103421:	5f                   	pop    %edi
80103422:	5d                   	pop    %ebp
80103423:	c3                   	ret    
80103424:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103428:	c3                   	ret    
80103429:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103430 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80103430:	55                   	push   %ebp
80103431:	89 e5                	mov    %esp,%ebp
80103433:	53                   	push   %ebx
80103434:	83 ec 0c             	sub    $0xc,%esp
  struct buf *buf = bread(log.dev, log.start);
80103437:	ff 35 14 33 11 80    	push   0x80113314
8010343d:	ff 35 24 33 11 80    	push   0x80113324
80103443:	e8 88 cc ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *)(buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++)
80103448:	83 c4 10             	add    $0x10,%esp
  struct buf *buf = bread(log.dev, log.start);
8010344b:	89 c3                	mov    %eax,%ebx
  hb->n = log.lh.n;
8010344d:	a1 28 33 11 80       	mov    0x80113328,%eax
80103452:	89 43 5c             	mov    %eax,0x5c(%ebx)
  for (i = 0; i < log.lh.n; i++)
80103455:	85 c0                	test   %eax,%eax
80103457:	7e 19                	jle    80103472 <write_head+0x42>
80103459:	31 d2                	xor    %edx,%edx
8010345b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010345f:	90                   	nop
  {
    hb->block[i] = log.lh.block[i];
80103460:	8b 0c 95 2c 33 11 80 	mov    -0x7feeccd4(,%edx,4),%ecx
80103467:	89 4c 93 60          	mov    %ecx,0x60(%ebx,%edx,4)
  for (i = 0; i < log.lh.n; i++)
8010346b:	83 c2 01             	add    $0x1,%edx
8010346e:	39 d0                	cmp    %edx,%eax
80103470:	75 ee                	jne    80103460 <write_head+0x30>
  }
  bwrite(buf);
80103472:	83 ec 0c             	sub    $0xc,%esp
80103475:	53                   	push   %ebx
80103476:	e8 35 cd ff ff       	call   801001b0 <bwrite>
  brelse(buf);
8010347b:	89 1c 24             	mov    %ebx,(%esp)
8010347e:	e8 6d cd ff ff       	call   801001f0 <brelse>
}
80103483:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103486:	83 c4 10             	add    $0x10,%esp
80103489:	c9                   	leave  
8010348a:	c3                   	ret    
8010348b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010348f:	90                   	nop

80103490 <initlog>:
{
80103490:	55                   	push   %ebp
80103491:	89 e5                	mov    %esp,%ebp
80103493:	53                   	push   %ebx
80103494:	83 ec 2c             	sub    $0x2c,%esp
80103497:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&log.lock, "log");
8010349a:	68 20 81 10 80       	push   $0x80108120
8010349f:	68 e0 32 11 80       	push   $0x801132e0
801034a4:	e8 f7 16 00 00       	call   80104ba0 <initlock>
  readsb(dev, &sb);
801034a9:	58                   	pop    %eax
801034aa:	8d 45 dc             	lea    -0x24(%ebp),%eax
801034ad:	5a                   	pop    %edx
801034ae:	50                   	push   %eax
801034af:	53                   	push   %ebx
801034b0:	e8 3b e8 ff ff       	call   80101cf0 <readsb>
  log.start = sb.logstart;
801034b5:	8b 45 ec             	mov    -0x14(%ebp),%eax
  struct buf *buf = bread(log.dev, log.start);
801034b8:	59                   	pop    %ecx
  log.dev = dev;
801034b9:	89 1d 24 33 11 80    	mov    %ebx,0x80113324
  log.size = sb.nlog;
801034bf:	8b 55 e8             	mov    -0x18(%ebp),%edx
  log.start = sb.logstart;
801034c2:	a3 14 33 11 80       	mov    %eax,0x80113314
  log.size = sb.nlog;
801034c7:	89 15 18 33 11 80    	mov    %edx,0x80113318
  struct buf *buf = bread(log.dev, log.start);
801034cd:	5a                   	pop    %edx
801034ce:	50                   	push   %eax
801034cf:	53                   	push   %ebx
801034d0:	e8 fb cb ff ff       	call   801000d0 <bread>
  for (i = 0; i < log.lh.n; i++)
801034d5:	83 c4 10             	add    $0x10,%esp
  log.lh.n = lh->n;
801034d8:	8b 58 5c             	mov    0x5c(%eax),%ebx
801034db:	89 1d 28 33 11 80    	mov    %ebx,0x80113328
  for (i = 0; i < log.lh.n; i++)
801034e1:	85 db                	test   %ebx,%ebx
801034e3:	7e 1d                	jle    80103502 <initlog+0x72>
801034e5:	31 d2                	xor    %edx,%edx
801034e7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801034ee:	66 90                	xchg   %ax,%ax
    log.lh.block[i] = lh->block[i];
801034f0:	8b 4c 90 60          	mov    0x60(%eax,%edx,4),%ecx
801034f4:	89 0c 95 2c 33 11 80 	mov    %ecx,-0x7feeccd4(,%edx,4)
  for (i = 0; i < log.lh.n; i++)
801034fb:	83 c2 01             	add    $0x1,%edx
801034fe:	39 d3                	cmp    %edx,%ebx
80103500:	75 ee                	jne    801034f0 <initlog+0x60>
  brelse(buf);
80103502:	83 ec 0c             	sub    $0xc,%esp
80103505:	50                   	push   %eax
80103506:	e8 e5 cc ff ff       	call   801001f0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
8010350b:	e8 80 fe ff ff       	call   80103390 <install_trans>
  log.lh.n = 0;
80103510:	c7 05 28 33 11 80 00 	movl   $0x0,0x80113328
80103517:	00 00 00 
  write_head(); // clear the log
8010351a:	e8 11 ff ff ff       	call   80103430 <write_head>
}
8010351f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103522:	83 c4 10             	add    $0x10,%esp
80103525:	c9                   	leave  
80103526:	c3                   	ret    
80103527:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010352e:	66 90                	xchg   %ax,%ax

80103530 <begin_op>:
}

// called at the start of each FS system call.
void begin_op(void)
{
80103530:	55                   	push   %ebp
80103531:	89 e5                	mov    %esp,%ebp
80103533:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
80103536:	68 e0 32 11 80       	push   $0x801132e0
8010353b:	e8 30 18 00 00       	call   80104d70 <acquire>
80103540:	83 c4 10             	add    $0x10,%esp
80103543:	eb 18                	jmp    8010355d <begin_op+0x2d>
80103545:	8d 76 00             	lea    0x0(%esi),%esi
  while (1)
  {
    if (log.committing)
    {
      sleep(&log, &log.lock);
80103548:	83 ec 08             	sub    $0x8,%esp
8010354b:	68 e0 32 11 80       	push   $0x801132e0
80103550:	68 e0 32 11 80       	push   $0x801132e0
80103555:	e8 b6 12 00 00       	call   80104810 <sleep>
8010355a:	83 c4 10             	add    $0x10,%esp
    if (log.committing)
8010355d:	a1 20 33 11 80       	mov    0x80113320,%eax
80103562:	85 c0                	test   %eax,%eax
80103564:	75 e2                	jne    80103548 <begin_op+0x18>
    }
    else if (log.lh.n + (log.outstanding + 1) * MAXOPBLOCKS > LOGSIZE)
80103566:	a1 1c 33 11 80       	mov    0x8011331c,%eax
8010356b:	8b 15 28 33 11 80    	mov    0x80113328,%edx
80103571:	83 c0 01             	add    $0x1,%eax
80103574:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80103577:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
8010357a:	83 fa 1e             	cmp    $0x1e,%edx
8010357d:	7f c9                	jg     80103548 <begin_op+0x18>
      sleep(&log, &log.lock);
    }
    else
    {
      log.outstanding += 1;
      release(&log.lock);
8010357f:	83 ec 0c             	sub    $0xc,%esp
      log.outstanding += 1;
80103582:	a3 1c 33 11 80       	mov    %eax,0x8011331c
      release(&log.lock);
80103587:	68 e0 32 11 80       	push   $0x801132e0
8010358c:	e8 7f 17 00 00       	call   80104d10 <release>
      break;
    }
  }
}
80103591:	83 c4 10             	add    $0x10,%esp
80103594:	c9                   	leave  
80103595:	c3                   	ret    
80103596:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010359d:	8d 76 00             	lea    0x0(%esi),%esi

801035a0 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void end_op(void)
{
801035a0:	55                   	push   %ebp
801035a1:	89 e5                	mov    %esp,%ebp
801035a3:	57                   	push   %edi
801035a4:	56                   	push   %esi
801035a5:	53                   	push   %ebx
801035a6:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;

  acquire(&log.lock);
801035a9:	68 e0 32 11 80       	push   $0x801132e0
801035ae:	e8 bd 17 00 00       	call   80104d70 <acquire>
  log.outstanding -= 1;
801035b3:	a1 1c 33 11 80       	mov    0x8011331c,%eax
  if (log.committing)
801035b8:	8b 35 20 33 11 80    	mov    0x80113320,%esi
801035be:	83 c4 10             	add    $0x10,%esp
  log.outstanding -= 1;
801035c1:	8d 58 ff             	lea    -0x1(%eax),%ebx
801035c4:	89 1d 1c 33 11 80    	mov    %ebx,0x8011331c
  if (log.committing)
801035ca:	85 f6                	test   %esi,%esi
801035cc:	0f 85 22 01 00 00    	jne    801036f4 <end_op+0x154>
    panic("log.committing");
  if (log.outstanding == 0)
801035d2:	85 db                	test   %ebx,%ebx
801035d4:	0f 85 f6 00 00 00    	jne    801036d0 <end_op+0x130>
  {
    do_commit = 1;
    log.committing = 1;
801035da:	c7 05 20 33 11 80 01 	movl   $0x1,0x80113320
801035e1:	00 00 00 
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
801035e4:	83 ec 0c             	sub    $0xc,%esp
801035e7:	68 e0 32 11 80       	push   $0x801132e0
801035ec:	e8 1f 17 00 00       	call   80104d10 <release>
}

static void
commit()
{
  if (log.lh.n > 0)
801035f1:	8b 0d 28 33 11 80    	mov    0x80113328,%ecx
801035f7:	83 c4 10             	add    $0x10,%esp
801035fa:	85 c9                	test   %ecx,%ecx
801035fc:	7f 42                	jg     80103640 <end_op+0xa0>
    acquire(&log.lock);
801035fe:	83 ec 0c             	sub    $0xc,%esp
80103601:	68 e0 32 11 80       	push   $0x801132e0
80103606:	e8 65 17 00 00       	call   80104d70 <acquire>
    wakeup(&log);
8010360b:	c7 04 24 e0 32 11 80 	movl   $0x801132e0,(%esp)
    log.committing = 0;
80103612:	c7 05 20 33 11 80 00 	movl   $0x0,0x80113320
80103619:	00 00 00 
    wakeup(&log);
8010361c:	e8 af 12 00 00       	call   801048d0 <wakeup>
    release(&log.lock);
80103621:	c7 04 24 e0 32 11 80 	movl   $0x801132e0,(%esp)
80103628:	e8 e3 16 00 00       	call   80104d10 <release>
8010362d:	83 c4 10             	add    $0x10,%esp
}
80103630:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103633:	5b                   	pop    %ebx
80103634:	5e                   	pop    %esi
80103635:	5f                   	pop    %edi
80103636:	5d                   	pop    %ebp
80103637:	c3                   	ret    
80103638:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010363f:	90                   	nop
    struct buf *to = bread(log.dev, log.start + tail + 1); // log block
80103640:	a1 14 33 11 80       	mov    0x80113314,%eax
80103645:	83 ec 08             	sub    $0x8,%esp
80103648:	01 d8                	add    %ebx,%eax
8010364a:	83 c0 01             	add    $0x1,%eax
8010364d:	50                   	push   %eax
8010364e:	ff 35 24 33 11 80    	push   0x80113324
80103654:	e8 77 ca ff ff       	call   801000d0 <bread>
80103659:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
8010365b:	58                   	pop    %eax
8010365c:	5a                   	pop    %edx
8010365d:	ff 34 9d 2c 33 11 80 	push   -0x7feeccd4(,%ebx,4)
80103664:	ff 35 24 33 11 80    	push   0x80113324
  for (tail = 0; tail < log.lh.n; tail++)
8010366a:	83 c3 01             	add    $0x1,%ebx
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
8010366d:	e8 5e ca ff ff       	call   801000d0 <bread>
    memmove(to->data, from->data, BSIZE);
80103672:	83 c4 0c             	add    $0xc,%esp
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80103675:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80103677:	8d 40 5c             	lea    0x5c(%eax),%eax
8010367a:	68 00 02 00 00       	push   $0x200
8010367f:	50                   	push   %eax
80103680:	8d 46 5c             	lea    0x5c(%esi),%eax
80103683:	50                   	push   %eax
80103684:	e8 47 18 00 00       	call   80104ed0 <memmove>
    bwrite(to); // write the log
80103689:	89 34 24             	mov    %esi,(%esp)
8010368c:	e8 1f cb ff ff       	call   801001b0 <bwrite>
    brelse(from);
80103691:	89 3c 24             	mov    %edi,(%esp)
80103694:	e8 57 cb ff ff       	call   801001f0 <brelse>
    brelse(to);
80103699:	89 34 24             	mov    %esi,(%esp)
8010369c:	e8 4f cb ff ff       	call   801001f0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++)
801036a1:	83 c4 10             	add    $0x10,%esp
801036a4:	3b 1d 28 33 11 80    	cmp    0x80113328,%ebx
801036aa:	7c 94                	jl     80103640 <end_op+0xa0>
  {
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
801036ac:	e8 7f fd ff ff       	call   80103430 <write_head>
    install_trans(); // Now install writes to home locations
801036b1:	e8 da fc ff ff       	call   80103390 <install_trans>
    log.lh.n = 0;
801036b6:	c7 05 28 33 11 80 00 	movl   $0x0,0x80113328
801036bd:	00 00 00 
    write_head(); // Erase the transaction from the log
801036c0:	e8 6b fd ff ff       	call   80103430 <write_head>
801036c5:	e9 34 ff ff ff       	jmp    801035fe <end_op+0x5e>
801036ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    wakeup(&log);
801036d0:	83 ec 0c             	sub    $0xc,%esp
801036d3:	68 e0 32 11 80       	push   $0x801132e0
801036d8:	e8 f3 11 00 00       	call   801048d0 <wakeup>
  release(&log.lock);
801036dd:	c7 04 24 e0 32 11 80 	movl   $0x801132e0,(%esp)
801036e4:	e8 27 16 00 00       	call   80104d10 <release>
801036e9:	83 c4 10             	add    $0x10,%esp
}
801036ec:	8d 65 f4             	lea    -0xc(%ebp),%esp
801036ef:	5b                   	pop    %ebx
801036f0:	5e                   	pop    %esi
801036f1:	5f                   	pop    %edi
801036f2:	5d                   	pop    %ebp
801036f3:	c3                   	ret    
    panic("log.committing");
801036f4:	83 ec 0c             	sub    $0xc,%esp
801036f7:	68 24 81 10 80       	push   $0x80108124
801036fc:	e8 9f cc ff ff       	call   801003a0 <panic>
80103701:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103708:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010370f:	90                   	nop

80103710 <log_write>:
//   bp = bread(...)
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void log_write(struct buf *b)
{
80103710:	55                   	push   %ebp
80103711:	89 e5                	mov    %esp,%ebp
80103713:	53                   	push   %ebx
80103714:	83 ec 04             	sub    $0x4,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80103717:	8b 15 28 33 11 80    	mov    0x80113328,%edx
{
8010371d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80103720:	83 fa 1d             	cmp    $0x1d,%edx
80103723:	0f 8f 85 00 00 00    	jg     801037ae <log_write+0x9e>
80103729:	a1 18 33 11 80       	mov    0x80113318,%eax
8010372e:	83 e8 01             	sub    $0x1,%eax
80103731:	39 c2                	cmp    %eax,%edx
80103733:	7d 79                	jge    801037ae <log_write+0x9e>
    panic("too big a transaction");
  if (log.outstanding < 1)
80103735:	a1 1c 33 11 80       	mov    0x8011331c,%eax
8010373a:	85 c0                	test   %eax,%eax
8010373c:	7e 7d                	jle    801037bb <log_write+0xab>
    panic("log_write outside of trans");

  acquire(&log.lock);
8010373e:	83 ec 0c             	sub    $0xc,%esp
80103741:	68 e0 32 11 80       	push   $0x801132e0
80103746:	e8 25 16 00 00       	call   80104d70 <acquire>
  for (i = 0; i < log.lh.n; i++)
8010374b:	8b 15 28 33 11 80    	mov    0x80113328,%edx
80103751:	83 c4 10             	add    $0x10,%esp
80103754:	85 d2                	test   %edx,%edx
80103756:	7e 4a                	jle    801037a2 <log_write+0x92>
  {
    if (log.lh.block[i] == b->blockno) // log absorbtion
80103758:	8b 4b 08             	mov    0x8(%ebx),%ecx
  for (i = 0; i < log.lh.n; i++)
8010375b:	31 c0                	xor    %eax,%eax
8010375d:	eb 08                	jmp    80103767 <log_write+0x57>
8010375f:	90                   	nop
80103760:	83 c0 01             	add    $0x1,%eax
80103763:	39 c2                	cmp    %eax,%edx
80103765:	74 29                	je     80103790 <log_write+0x80>
    if (log.lh.block[i] == b->blockno) // log absorbtion
80103767:	39 0c 85 2c 33 11 80 	cmp    %ecx,-0x7feeccd4(,%eax,4)
8010376e:	75 f0                	jne    80103760 <log_write+0x50>
      break;
  }
  log.lh.block[i] = b->blockno;
80103770:	89 0c 85 2c 33 11 80 	mov    %ecx,-0x7feeccd4(,%eax,4)
  if (i == log.lh.n)
    log.lh.n++;
  b->flags |= B_DIRTY; // prevent eviction
80103777:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
}
8010377a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  release(&log.lock);
8010377d:	c7 45 08 e0 32 11 80 	movl   $0x801132e0,0x8(%ebp)
}
80103784:	c9                   	leave  
  release(&log.lock);
80103785:	e9 86 15 00 00       	jmp    80104d10 <release>
8010378a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  log.lh.block[i] = b->blockno;
80103790:	89 0c 95 2c 33 11 80 	mov    %ecx,-0x7feeccd4(,%edx,4)
    log.lh.n++;
80103797:	83 c2 01             	add    $0x1,%edx
8010379a:	89 15 28 33 11 80    	mov    %edx,0x80113328
801037a0:	eb d5                	jmp    80103777 <log_write+0x67>
  log.lh.block[i] = b->blockno;
801037a2:	8b 43 08             	mov    0x8(%ebx),%eax
801037a5:	a3 2c 33 11 80       	mov    %eax,0x8011332c
  if (i == log.lh.n)
801037aa:	75 cb                	jne    80103777 <log_write+0x67>
801037ac:	eb e9                	jmp    80103797 <log_write+0x87>
    panic("too big a transaction");
801037ae:	83 ec 0c             	sub    $0xc,%esp
801037b1:	68 33 81 10 80       	push   $0x80108133
801037b6:	e8 e5 cb ff ff       	call   801003a0 <panic>
    panic("log_write outside of trans");
801037bb:	83 ec 0c             	sub    $0xc,%esp
801037be:	68 49 81 10 80       	push   $0x80108149
801037c3:	e8 d8 cb ff ff       	call   801003a0 <panic>
801037c8:	66 90                	xchg   %ax,%ax
801037ca:	66 90                	xchg   %ax,%ax
801037cc:	66 90                	xchg   %ax,%ax
801037ce:	66 90                	xchg   %ax,%ax

801037d0 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
801037d0:	55                   	push   %ebp
801037d1:	89 e5                	mov    %esp,%ebp
801037d3:	53                   	push   %ebx
801037d4:	83 ec 04             	sub    $0x4,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
801037d7:	e8 44 09 00 00       	call   80104120 <cpuid>
801037dc:	89 c3                	mov    %eax,%ebx
801037de:	e8 3d 09 00 00       	call   80104120 <cpuid>
801037e3:	83 ec 04             	sub    $0x4,%esp
801037e6:	53                   	push   %ebx
801037e7:	50                   	push   %eax
801037e8:	68 64 81 10 80       	push   $0x80108164
801037ed:	e8 5e cf ff ff       	call   80100750 <cprintf>
  idtinit();       // load idt register
801037f2:	e8 79 2b 00 00       	call   80106370 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
801037f7:	e8 c4 08 00 00       	call   801040c0 <mycpu>
801037fc:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" : "+m"(*addr), "=a"(result) : "1"(newval) : "cc");
801037fe:	b8 01 00 00 00       	mov    $0x1,%eax
80103803:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
8010380a:	e8 f1 0b 00 00       	call   80104400 <scheduler>
8010380f:	90                   	nop

80103810 <mpenter>:
{
80103810:	55                   	push   %ebp
80103811:	89 e5                	mov    %esp,%ebp
80103813:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80103816:	e8 45 3c 00 00       	call   80107460 <switchkvm>
  seginit();
8010381b:	e8 b0 3b 00 00       	call   801073d0 <seginit>
  lapicinit();
80103820:	e8 9b f7 ff ff       	call   80102fc0 <lapicinit>
  mpmain();
80103825:	e8 a6 ff ff ff       	call   801037d0 <mpmain>
8010382a:	66 90                	xchg   %ax,%ax
8010382c:	66 90                	xchg   %ax,%ax
8010382e:	66 90                	xchg   %ax,%ax

80103830 <main>:
{
80103830:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80103834:	83 e4 f0             	and    $0xfffffff0,%esp
80103837:	ff 71 fc             	push   -0x4(%ecx)
8010383a:	55                   	push   %ebp
8010383b:	89 e5                	mov    %esp,%ebp
8010383d:	53                   	push   %ebx
8010383e:	51                   	push   %ecx
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
8010383f:	83 ec 08             	sub    $0x8,%esp
80103842:	68 00 00 40 80       	push   $0x80400000
80103847:	68 10 71 11 80       	push   $0x80117110
8010384c:	e8 8f f5 ff ff       	call   80102de0 <kinit1>
  kvmalloc();      // kernel page table
80103851:	e8 fa 40 00 00       	call   80107950 <kvmalloc>
  mpinit();        // detect other processors
80103856:	e8 85 01 00 00       	call   801039e0 <mpinit>
  lapicinit();     // interrupt controller
8010385b:	e8 60 f7 ff ff       	call   80102fc0 <lapicinit>
  seginit();       // segment descriptors
80103860:	e8 6b 3b 00 00       	call   801073d0 <seginit>
  picinit();       // disable pic
80103865:	e8 76 03 00 00       	call   80103be0 <picinit>
  ioapicinit();    // another interrupt controller
8010386a:	e8 31 f3 ff ff       	call   80102ba0 <ioapicinit>
  consoleinit();   // console hardware
8010386f:	e8 bc d9 ff ff       	call   80101230 <consoleinit>
  uartinit();      // serial port
80103874:	e8 e7 2d 00 00       	call   80106660 <uartinit>
  pinit();         // process table
80103879:	e8 22 08 00 00       	call   801040a0 <pinit>
  tvinit();        // trap vectors
8010387e:	e8 6d 2a 00 00       	call   801062f0 <tvinit>
  binit();         // buffer cache
80103883:	e8 b8 c7 ff ff       	call   80100040 <binit>
  fileinit();      // file table
80103888:	e8 53 dd ff ff       	call   801015e0 <fileinit>
  ideinit();       // disk 
8010388d:	e8 fe f0 ff ff       	call   80102990 <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80103892:	83 c4 0c             	add    $0xc,%esp
80103895:	68 8a 00 00 00       	push   $0x8a
8010389a:	68 8c b4 10 80       	push   $0x8010b48c
8010389f:	68 00 70 00 80       	push   $0x80007000
801038a4:	e8 27 16 00 00       	call   80104ed0 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
801038a9:	83 c4 10             	add    $0x10,%esp
801038ac:	69 05 c4 33 11 80 b0 	imul   $0xb0,0x801133c4,%eax
801038b3:	00 00 00 
801038b6:	05 e0 33 11 80       	add    $0x801133e0,%eax
801038bb:	3d e0 33 11 80       	cmp    $0x801133e0,%eax
801038c0:	76 7e                	jbe    80103940 <main+0x110>
801038c2:	bb e0 33 11 80       	mov    $0x801133e0,%ebx
801038c7:	eb 20                	jmp    801038e9 <main+0xb9>
801038c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801038d0:	69 05 c4 33 11 80 b0 	imul   $0xb0,0x801133c4,%eax
801038d7:	00 00 00 
801038da:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
801038e0:	05 e0 33 11 80       	add    $0x801133e0,%eax
801038e5:	39 c3                	cmp    %eax,%ebx
801038e7:	73 57                	jae    80103940 <main+0x110>
    if(c == mycpu())  // We've started already.
801038e9:	e8 d2 07 00 00       	call   801040c0 <mycpu>
801038ee:	39 c3                	cmp    %eax,%ebx
801038f0:	74 de                	je     801038d0 <main+0xa0>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
801038f2:	e8 59 f5 ff ff       	call   80102e50 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
    *(void(**)(void))(code-8) = mpenter;
    *(int**)(code-12) = (void *) V2P(entrypgdir);

    lapicstartap(c->apicid, V2P(code));
801038f7:	83 ec 08             	sub    $0x8,%esp
    *(void(**)(void))(code-8) = mpenter;
801038fa:	c7 05 f8 6f 00 80 10 	movl   $0x80103810,0x80006ff8
80103901:	38 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
80103904:	c7 05 f4 6f 00 80 00 	movl   $0x10a000,0x80006ff4
8010390b:	a0 10 00 
    *(void**)(code-4) = stack + KSTACKSIZE;
8010390e:	05 00 10 00 00       	add    $0x1000,%eax
80103913:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc
    lapicstartap(c->apicid, V2P(code));
80103918:	0f b6 03             	movzbl (%ebx),%eax
8010391b:	68 00 70 00 00       	push   $0x7000
80103920:	50                   	push   %eax
80103921:	e8 ea f7 ff ff       	call   80103110 <lapicstartap>

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80103926:	83 c4 10             	add    $0x10,%esp
80103929:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103930:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80103936:	85 c0                	test   %eax,%eax
80103938:	74 f6                	je     80103930 <main+0x100>
8010393a:	eb 94                	jmp    801038d0 <main+0xa0>
8010393c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80103940:	83 ec 08             	sub    $0x8,%esp
80103943:	68 00 00 00 8e       	push   $0x8e000000
80103948:	68 00 00 40 80       	push   $0x80400000
8010394d:	e8 2e f4 ff ff       	call   80102d80 <kinit2>
  userinit();      // first user process
80103952:	e8 19 08 00 00       	call   80104170 <userinit>
  mpmain();        // finish this processor's setup
80103957:	e8 74 fe ff ff       	call   801037d0 <mpmain>
8010395c:	66 90                	xchg   %ax,%ax
8010395e:	66 90                	xchg   %ax,%ax

80103960 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80103960:	55                   	push   %ebp
80103961:	89 e5                	mov    %esp,%ebp
80103963:	57                   	push   %edi
80103964:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
80103965:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
{
8010396b:	53                   	push   %ebx
  e = addr+len;
8010396c:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
{
8010396f:	83 ec 0c             	sub    $0xc,%esp
  for(p = addr; p < e; p += sizeof(struct mp))
80103972:	39 de                	cmp    %ebx,%esi
80103974:	72 10                	jb     80103986 <mpsearch1+0x26>
80103976:	eb 50                	jmp    801039c8 <mpsearch1+0x68>
80103978:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010397f:	90                   	nop
80103980:	89 fe                	mov    %edi,%esi
80103982:	39 fb                	cmp    %edi,%ebx
80103984:	76 42                	jbe    801039c8 <mpsearch1+0x68>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103986:	83 ec 04             	sub    $0x4,%esp
80103989:	8d 7e 10             	lea    0x10(%esi),%edi
8010398c:	6a 04                	push   $0x4
8010398e:	68 78 81 10 80       	push   $0x80108178
80103993:	56                   	push   %esi
80103994:	e8 e7 14 00 00       	call   80104e80 <memcmp>
80103999:	83 c4 10             	add    $0x10,%esp
8010399c:	85 c0                	test   %eax,%eax
8010399e:	75 e0                	jne    80103980 <mpsearch1+0x20>
801039a0:	89 f2                	mov    %esi,%edx
801039a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    sum += addr[i];
801039a8:	0f b6 0a             	movzbl (%edx),%ecx
  for(i=0; i<len; i++)
801039ab:	83 c2 01             	add    $0x1,%edx
    sum += addr[i];
801039ae:	01 c8                	add    %ecx,%eax
  for(i=0; i<len; i++)
801039b0:	39 fa                	cmp    %edi,%edx
801039b2:	75 f4                	jne    801039a8 <mpsearch1+0x48>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801039b4:	84 c0                	test   %al,%al
801039b6:	75 c8                	jne    80103980 <mpsearch1+0x20>
      return (struct mp*)p;
  return 0;
}
801039b8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801039bb:	89 f0                	mov    %esi,%eax
801039bd:	5b                   	pop    %ebx
801039be:	5e                   	pop    %esi
801039bf:	5f                   	pop    %edi
801039c0:	5d                   	pop    %ebp
801039c1:	c3                   	ret    
801039c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801039c8:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801039cb:	31 f6                	xor    %esi,%esi
}
801039cd:	5b                   	pop    %ebx
801039ce:	89 f0                	mov    %esi,%eax
801039d0:	5e                   	pop    %esi
801039d1:	5f                   	pop    %edi
801039d2:	5d                   	pop    %ebp
801039d3:	c3                   	ret    
801039d4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801039db:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801039df:	90                   	nop

801039e0 <mpinit>:
  return conf;
}

void
mpinit(void)
{
801039e0:	55                   	push   %ebp
801039e1:	89 e5                	mov    %esp,%ebp
801039e3:	57                   	push   %edi
801039e4:	56                   	push   %esi
801039e5:	53                   	push   %ebx
801039e6:	83 ec 1c             	sub    $0x1c,%esp
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
801039e9:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
801039f0:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
801039f7:	c1 e0 08             	shl    $0x8,%eax
801039fa:	09 d0                	or     %edx,%eax
801039fc:	c1 e0 04             	shl    $0x4,%eax
801039ff:	75 1b                	jne    80103a1c <mpinit+0x3c>
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
80103a01:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
80103a08:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
80103a0f:	c1 e0 08             	shl    $0x8,%eax
80103a12:	09 d0                	or     %edx,%eax
80103a14:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
80103a17:	2d 00 04 00 00       	sub    $0x400,%eax
    if((mp = mpsearch1(p, 1024)))
80103a1c:	ba 00 04 00 00       	mov    $0x400,%edx
80103a21:	e8 3a ff ff ff       	call   80103960 <mpsearch1>
80103a26:	89 c3                	mov    %eax,%ebx
80103a28:	85 c0                	test   %eax,%eax
80103a2a:	0f 84 40 01 00 00    	je     80103b70 <mpinit+0x190>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103a30:	8b 73 04             	mov    0x4(%ebx),%esi
80103a33:	85 f6                	test   %esi,%esi
80103a35:	0f 84 25 01 00 00    	je     80103b60 <mpinit+0x180>
  if(memcmp(conf, "PCMP", 4) != 0)
80103a3b:	83 ec 04             	sub    $0x4,%esp
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
80103a3e:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
  if(memcmp(conf, "PCMP", 4) != 0)
80103a44:	6a 04                	push   $0x4
80103a46:	68 7d 81 10 80       	push   $0x8010817d
80103a4b:	50                   	push   %eax
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
80103a4c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(memcmp(conf, "PCMP", 4) != 0)
80103a4f:	e8 2c 14 00 00       	call   80104e80 <memcmp>
80103a54:	83 c4 10             	add    $0x10,%esp
80103a57:	85 c0                	test   %eax,%eax
80103a59:	0f 85 01 01 00 00    	jne    80103b60 <mpinit+0x180>
  if(conf->version != 1 && conf->version != 4)
80103a5f:	0f b6 86 06 00 00 80 	movzbl -0x7ffffffa(%esi),%eax
80103a66:	3c 01                	cmp    $0x1,%al
80103a68:	74 08                	je     80103a72 <mpinit+0x92>
80103a6a:	3c 04                	cmp    $0x4,%al
80103a6c:	0f 85 ee 00 00 00    	jne    80103b60 <mpinit+0x180>
  if(sum((uchar*)conf, conf->length) != 0)
80103a72:	0f b7 96 04 00 00 80 	movzwl -0x7ffffffc(%esi),%edx
  for(i=0; i<len; i++)
80103a79:	66 85 d2             	test   %dx,%dx
80103a7c:	74 22                	je     80103aa0 <mpinit+0xc0>
80103a7e:	8d 3c 32             	lea    (%edx,%esi,1),%edi
80103a81:	89 f0                	mov    %esi,%eax
  sum = 0;
80103a83:	31 d2                	xor    %edx,%edx
80103a85:	8d 76 00             	lea    0x0(%esi),%esi
    sum += addr[i];
80103a88:	0f b6 88 00 00 00 80 	movzbl -0x80000000(%eax),%ecx
  for(i=0; i<len; i++)
80103a8f:	83 c0 01             	add    $0x1,%eax
    sum += addr[i];
80103a92:	01 ca                	add    %ecx,%edx
  for(i=0; i<len; i++)
80103a94:	39 c7                	cmp    %eax,%edi
80103a96:	75 f0                	jne    80103a88 <mpinit+0xa8>
  if(sum((uchar*)conf, conf->length) != 0)
80103a98:	84 d2                	test   %dl,%dl
80103a9a:	0f 85 c0 00 00 00    	jne    80103b60 <mpinit+0x180>
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
80103aa0:	8b 86 24 00 00 80    	mov    -0x7fffffdc(%esi),%eax
80103aa6:	a3 c0 32 11 80       	mov    %eax,0x801132c0
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103aab:	0f b7 96 04 00 00 80 	movzwl -0x7ffffffc(%esi),%edx
80103ab2:	8d 86 2c 00 00 80    	lea    -0x7fffffd4(%esi),%eax
  ismp = 1;
80103ab8:	be 01 00 00 00       	mov    $0x1,%esi
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103abd:	03 55 e4             	add    -0x1c(%ebp),%edx
80103ac0:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
80103ac3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103ac7:	90                   	nop
80103ac8:	39 d0                	cmp    %edx,%eax
80103aca:	73 15                	jae    80103ae1 <mpinit+0x101>
    switch(*p){
80103acc:	0f b6 08             	movzbl (%eax),%ecx
80103acf:	80 f9 02             	cmp    $0x2,%cl
80103ad2:	74 4c                	je     80103b20 <mpinit+0x140>
80103ad4:	77 3a                	ja     80103b10 <mpinit+0x130>
80103ad6:	84 c9                	test   %cl,%cl
80103ad8:	74 56                	je     80103b30 <mpinit+0x150>
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
80103ada:	83 c0 08             	add    $0x8,%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103add:	39 d0                	cmp    %edx,%eax
80103adf:	72 eb                	jb     80103acc <mpinit+0xec>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
80103ae1:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80103ae4:	85 f6                	test   %esi,%esi
80103ae6:	0f 84 d9 00 00 00    	je     80103bc5 <mpinit+0x1e5>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
80103aec:	80 7b 0c 00          	cmpb   $0x0,0xc(%ebx)
80103af0:	74 15                	je     80103b07 <mpinit+0x127>
  asm volatile("out %0,%1" : : "a"(data), "d"(port));
80103af2:	b8 70 00 00 00       	mov    $0x70,%eax
80103af7:	ba 22 00 00 00       	mov    $0x22,%edx
80103afc:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a"(data) : "d"(port));
80103afd:	ba 23 00 00 00       	mov    $0x23,%edx
80103b02:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
80103b03:	83 c8 01             	or     $0x1,%eax
  asm volatile("out %0,%1" : : "a"(data), "d"(port));
80103b06:	ee                   	out    %al,(%dx)
  }
}
80103b07:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103b0a:	5b                   	pop    %ebx
80103b0b:	5e                   	pop    %esi
80103b0c:	5f                   	pop    %edi
80103b0d:	5d                   	pop    %ebp
80103b0e:	c3                   	ret    
80103b0f:	90                   	nop
    switch(*p){
80103b10:	83 e9 03             	sub    $0x3,%ecx
80103b13:	80 f9 01             	cmp    $0x1,%cl
80103b16:	76 c2                	jbe    80103ada <mpinit+0xfa>
80103b18:	31 f6                	xor    %esi,%esi
80103b1a:	eb ac                	jmp    80103ac8 <mpinit+0xe8>
80103b1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      ioapicid = ioapic->apicno;
80103b20:	0f b6 48 01          	movzbl 0x1(%eax),%ecx
      p += sizeof(struct mpioapic);
80103b24:	83 c0 08             	add    $0x8,%eax
      ioapicid = ioapic->apicno;
80103b27:	88 0d c0 33 11 80    	mov    %cl,0x801133c0
      continue;
80103b2d:	eb 99                	jmp    80103ac8 <mpinit+0xe8>
80103b2f:	90                   	nop
      if(ncpu < NCPU) {
80103b30:	8b 0d c4 33 11 80    	mov    0x801133c4,%ecx
80103b36:	83 f9 07             	cmp    $0x7,%ecx
80103b39:	7f 19                	jg     80103b54 <mpinit+0x174>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80103b3b:	69 f9 b0 00 00 00    	imul   $0xb0,%ecx,%edi
80103b41:	0f b6 58 01          	movzbl 0x1(%eax),%ebx
        ncpu++;
80103b45:	83 c1 01             	add    $0x1,%ecx
80103b48:	89 0d c4 33 11 80    	mov    %ecx,0x801133c4
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80103b4e:	88 9f e0 33 11 80    	mov    %bl,-0x7feecc20(%edi)
      p += sizeof(struct mpproc);
80103b54:	83 c0 14             	add    $0x14,%eax
      continue;
80103b57:	e9 6c ff ff ff       	jmp    80103ac8 <mpinit+0xe8>
80103b5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    panic("Expect to run on an SMP");
80103b60:	83 ec 0c             	sub    $0xc,%esp
80103b63:	68 82 81 10 80       	push   $0x80108182
80103b68:	e8 33 c8 ff ff       	call   801003a0 <panic>
80103b6d:	8d 76 00             	lea    0x0(%esi),%esi
{
80103b70:	bb 00 00 0f 80       	mov    $0x800f0000,%ebx
80103b75:	eb 13                	jmp    80103b8a <mpinit+0x1aa>
80103b77:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103b7e:	66 90                	xchg   %ax,%ax
  for(p = addr; p < e; p += sizeof(struct mp))
80103b80:	89 f3                	mov    %esi,%ebx
80103b82:	81 fe 00 00 10 80    	cmp    $0x80100000,%esi
80103b88:	74 d6                	je     80103b60 <mpinit+0x180>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103b8a:	83 ec 04             	sub    $0x4,%esp
80103b8d:	8d 73 10             	lea    0x10(%ebx),%esi
80103b90:	6a 04                	push   $0x4
80103b92:	68 78 81 10 80       	push   $0x80108178
80103b97:	53                   	push   %ebx
80103b98:	e8 e3 12 00 00       	call   80104e80 <memcmp>
80103b9d:	83 c4 10             	add    $0x10,%esp
80103ba0:	85 c0                	test   %eax,%eax
80103ba2:	75 dc                	jne    80103b80 <mpinit+0x1a0>
80103ba4:	89 da                	mov    %ebx,%edx
80103ba6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103bad:	8d 76 00             	lea    0x0(%esi),%esi
    sum += addr[i];
80103bb0:	0f b6 0a             	movzbl (%edx),%ecx
  for(i=0; i<len; i++)
80103bb3:	83 c2 01             	add    $0x1,%edx
    sum += addr[i];
80103bb6:	01 c8                	add    %ecx,%eax
  for(i=0; i<len; i++)
80103bb8:	39 d6                	cmp    %edx,%esi
80103bba:	75 f4                	jne    80103bb0 <mpinit+0x1d0>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103bbc:	84 c0                	test   %al,%al
80103bbe:	75 c0                	jne    80103b80 <mpinit+0x1a0>
80103bc0:	e9 6b fe ff ff       	jmp    80103a30 <mpinit+0x50>
    panic("Didn't find a suitable machine");
80103bc5:	83 ec 0c             	sub    $0xc,%esp
80103bc8:	68 9c 81 10 80       	push   $0x8010819c
80103bcd:	e8 ce c7 ff ff       	call   801003a0 <panic>
80103bd2:	66 90                	xchg   %ax,%ax
80103bd4:	66 90                	xchg   %ax,%ax
80103bd6:	66 90                	xchg   %ax,%ax
80103bd8:	66 90                	xchg   %ax,%ax
80103bda:	66 90                	xchg   %ax,%ax
80103bdc:	66 90                	xchg   %ax,%ax
80103bde:	66 90                	xchg   %ax,%ax

80103be0 <picinit>:
80103be0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103be5:	ba 21 00 00 00       	mov    $0x21,%edx
80103bea:	ee                   	out    %al,(%dx)
80103beb:	ba a1 00 00 00       	mov    $0xa1,%edx
80103bf0:	ee                   	out    %al,(%dx)
picinit(void)
{
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
80103bf1:	c3                   	ret    
80103bf2:	66 90                	xchg   %ax,%ax
80103bf4:	66 90                	xchg   %ax,%ax
80103bf6:	66 90                	xchg   %ax,%ax
80103bf8:	66 90                	xchg   %ax,%ax
80103bfa:	66 90                	xchg   %ax,%ax
80103bfc:	66 90                	xchg   %ax,%ax
80103bfe:	66 90                	xchg   %ax,%ax

80103c00 <pipealloc>:
80103c00:	55                   	push   %ebp
80103c01:	89 e5                	mov    %esp,%ebp
80103c03:	57                   	push   %edi
80103c04:	56                   	push   %esi
80103c05:	53                   	push   %ebx
80103c06:	83 ec 0c             	sub    $0xc,%esp
80103c09:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103c0c:	8b 75 0c             	mov    0xc(%ebp),%esi
80103c0f:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80103c15:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80103c1b:	e8 e0 d9 ff ff       	call   80101600 <filealloc>
80103c20:	89 03                	mov    %eax,(%ebx)
80103c22:	85 c0                	test   %eax,%eax
80103c24:	0f 84 a8 00 00 00    	je     80103cd2 <pipealloc+0xd2>
80103c2a:	e8 d1 d9 ff ff       	call   80101600 <filealloc>
80103c2f:	89 06                	mov    %eax,(%esi)
80103c31:	85 c0                	test   %eax,%eax
80103c33:	0f 84 87 00 00 00    	je     80103cc0 <pipealloc+0xc0>
80103c39:	e8 12 f2 ff ff       	call   80102e50 <kalloc>
80103c3e:	89 c7                	mov    %eax,%edi
80103c40:	85 c0                	test   %eax,%eax
80103c42:	0f 84 b0 00 00 00    	je     80103cf8 <pipealloc+0xf8>
80103c48:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
80103c4f:	00 00 00 
80103c52:	83 ec 08             	sub    $0x8,%esp
80103c55:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
80103c5c:	00 00 00 
80103c5f:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
80103c66:	00 00 00 
80103c69:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
80103c70:	00 00 00 
80103c73:	68 bb 81 10 80       	push   $0x801081bb
80103c78:	50                   	push   %eax
80103c79:	e8 22 0f 00 00       	call   80104ba0 <initlock>
80103c7e:	8b 03                	mov    (%ebx),%eax
80103c80:	83 c4 10             	add    $0x10,%esp
80103c83:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
80103c89:	8b 03                	mov    (%ebx),%eax
80103c8b:	c6 40 08 01          	movb   $0x1,0x8(%eax)
80103c8f:	8b 03                	mov    (%ebx),%eax
80103c91:	c6 40 09 00          	movb   $0x0,0x9(%eax)
80103c95:	8b 03                	mov    (%ebx),%eax
80103c97:	89 78 0c             	mov    %edi,0xc(%eax)
80103c9a:	8b 06                	mov    (%esi),%eax
80103c9c:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
80103ca2:	8b 06                	mov    (%esi),%eax
80103ca4:	c6 40 08 00          	movb   $0x0,0x8(%eax)
80103ca8:	8b 06                	mov    (%esi),%eax
80103caa:	c6 40 09 01          	movb   $0x1,0x9(%eax)
80103cae:	8b 06                	mov    (%esi),%eax
80103cb0:	89 78 0c             	mov    %edi,0xc(%eax)
80103cb3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103cb6:	31 c0                	xor    %eax,%eax
80103cb8:	5b                   	pop    %ebx
80103cb9:	5e                   	pop    %esi
80103cba:	5f                   	pop    %edi
80103cbb:	5d                   	pop    %ebp
80103cbc:	c3                   	ret    
80103cbd:	8d 76 00             	lea    0x0(%esi),%esi
80103cc0:	8b 03                	mov    (%ebx),%eax
80103cc2:	85 c0                	test   %eax,%eax
80103cc4:	74 1e                	je     80103ce4 <pipealloc+0xe4>
80103cc6:	83 ec 0c             	sub    $0xc,%esp
80103cc9:	50                   	push   %eax
80103cca:	e8 f1 d9 ff ff       	call   801016c0 <fileclose>
80103ccf:	83 c4 10             	add    $0x10,%esp
80103cd2:	8b 06                	mov    (%esi),%eax
80103cd4:	85 c0                	test   %eax,%eax
80103cd6:	74 0c                	je     80103ce4 <pipealloc+0xe4>
80103cd8:	83 ec 0c             	sub    $0xc,%esp
80103cdb:	50                   	push   %eax
80103cdc:	e8 df d9 ff ff       	call   801016c0 <fileclose>
80103ce1:	83 c4 10             	add    $0x10,%esp
80103ce4:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103ce7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103cec:	5b                   	pop    %ebx
80103ced:	5e                   	pop    %esi
80103cee:	5f                   	pop    %edi
80103cef:	5d                   	pop    %ebp
80103cf0:	c3                   	ret    
80103cf1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103cf8:	8b 03                	mov    (%ebx),%eax
80103cfa:	85 c0                	test   %eax,%eax
80103cfc:	75 c8                	jne    80103cc6 <pipealloc+0xc6>
80103cfe:	eb d2                	jmp    80103cd2 <pipealloc+0xd2>

80103d00 <pipeclose>:
80103d00:	55                   	push   %ebp
80103d01:	89 e5                	mov    %esp,%ebp
80103d03:	56                   	push   %esi
80103d04:	53                   	push   %ebx
80103d05:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103d08:	8b 75 0c             	mov    0xc(%ebp),%esi
80103d0b:	83 ec 0c             	sub    $0xc,%esp
80103d0e:	53                   	push   %ebx
80103d0f:	e8 5c 10 00 00       	call   80104d70 <acquire>
80103d14:	83 c4 10             	add    $0x10,%esp
80103d17:	85 f6                	test   %esi,%esi
80103d19:	74 65                	je     80103d80 <pipeclose+0x80>
80103d1b:	83 ec 0c             	sub    $0xc,%esp
80103d1e:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80103d24:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
80103d2b:	00 00 00 
80103d2e:	50                   	push   %eax
80103d2f:	e8 9c 0b 00 00       	call   801048d0 <wakeup>
80103d34:	83 c4 10             	add    $0x10,%esp
80103d37:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
80103d3d:	85 d2                	test   %edx,%edx
80103d3f:	75 0a                	jne    80103d4b <pipeclose+0x4b>
80103d41:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
80103d47:	85 c0                	test   %eax,%eax
80103d49:	74 15                	je     80103d60 <pipeclose+0x60>
80103d4b:	89 5d 08             	mov    %ebx,0x8(%ebp)
80103d4e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103d51:	5b                   	pop    %ebx
80103d52:	5e                   	pop    %esi
80103d53:	5d                   	pop    %ebp
80103d54:	e9 b7 0f 00 00       	jmp    80104d10 <release>
80103d59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103d60:	83 ec 0c             	sub    $0xc,%esp
80103d63:	53                   	push   %ebx
80103d64:	e8 a7 0f 00 00       	call   80104d10 <release>
80103d69:	89 5d 08             	mov    %ebx,0x8(%ebp)
80103d6c:	83 c4 10             	add    $0x10,%esp
80103d6f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103d72:	5b                   	pop    %ebx
80103d73:	5e                   	pop    %esi
80103d74:	5d                   	pop    %ebp
80103d75:	e9 16 ef ff ff       	jmp    80102c90 <kfree>
80103d7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103d80:	83 ec 0c             	sub    $0xc,%esp
80103d83:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
80103d89:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
80103d90:	00 00 00 
80103d93:	50                   	push   %eax
80103d94:	e8 37 0b 00 00       	call   801048d0 <wakeup>
80103d99:	83 c4 10             	add    $0x10,%esp
80103d9c:	eb 99                	jmp    80103d37 <pipeclose+0x37>
80103d9e:	66 90                	xchg   %ax,%ax

80103da0 <pipewrite>:
80103da0:	55                   	push   %ebp
80103da1:	89 e5                	mov    %esp,%ebp
80103da3:	57                   	push   %edi
80103da4:	56                   	push   %esi
80103da5:	53                   	push   %ebx
80103da6:	83 ec 28             	sub    $0x28,%esp
80103da9:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103dac:	53                   	push   %ebx
80103dad:	e8 be 0f 00 00       	call   80104d70 <acquire>
80103db2:	8b 45 10             	mov    0x10(%ebp),%eax
80103db5:	83 c4 10             	add    $0x10,%esp
80103db8:	85 c0                	test   %eax,%eax
80103dba:	0f 8e c0 00 00 00    	jle    80103e80 <pipewrite+0xe0>
80103dc0:	8b 45 0c             	mov    0xc(%ebp),%eax
80103dc3:	8b 8b 38 02 00 00    	mov    0x238(%ebx),%ecx
80103dc9:	8d bb 34 02 00 00    	lea    0x234(%ebx),%edi
80103dcf:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103dd2:	03 45 10             	add    0x10(%ebp),%eax
80103dd5:	89 45 e0             	mov    %eax,-0x20(%ebp)
80103dd8:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
80103dde:	8d b3 38 02 00 00    	lea    0x238(%ebx),%esi
80103de4:	89 ca                	mov    %ecx,%edx
80103de6:	05 00 02 00 00       	add    $0x200,%eax
80103deb:	39 c1                	cmp    %eax,%ecx
80103ded:	74 3f                	je     80103e2e <pipewrite+0x8e>
80103def:	eb 67                	jmp    80103e58 <pipewrite+0xb8>
80103df1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103df8:	e8 43 03 00 00       	call   80104140 <myproc>
80103dfd:	8b 48 24             	mov    0x24(%eax),%ecx
80103e00:	85 c9                	test   %ecx,%ecx
80103e02:	75 34                	jne    80103e38 <pipewrite+0x98>
80103e04:	83 ec 0c             	sub    $0xc,%esp
80103e07:	57                   	push   %edi
80103e08:	e8 c3 0a 00 00       	call   801048d0 <wakeup>
80103e0d:	58                   	pop    %eax
80103e0e:	5a                   	pop    %edx
80103e0f:	53                   	push   %ebx
80103e10:	56                   	push   %esi
80103e11:	e8 fa 09 00 00       	call   80104810 <sleep>
80103e16:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
80103e1c:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
80103e22:	83 c4 10             	add    $0x10,%esp
80103e25:	05 00 02 00 00       	add    $0x200,%eax
80103e2a:	39 c2                	cmp    %eax,%edx
80103e2c:	75 2a                	jne    80103e58 <pipewrite+0xb8>
80103e2e:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
80103e34:	85 c0                	test   %eax,%eax
80103e36:	75 c0                	jne    80103df8 <pipewrite+0x58>
80103e38:	83 ec 0c             	sub    $0xc,%esp
80103e3b:	53                   	push   %ebx
80103e3c:	e8 cf 0e 00 00       	call   80104d10 <release>
80103e41:	83 c4 10             	add    $0x10,%esp
80103e44:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103e49:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103e4c:	5b                   	pop    %ebx
80103e4d:	5e                   	pop    %esi
80103e4e:	5f                   	pop    %edi
80103e4f:	5d                   	pop    %ebp
80103e50:	c3                   	ret    
80103e51:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103e58:	8b 75 e4             	mov    -0x1c(%ebp),%esi
80103e5b:	8d 4a 01             	lea    0x1(%edx),%ecx
80103e5e:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
80103e64:	89 8b 38 02 00 00    	mov    %ecx,0x238(%ebx)
80103e6a:	0f b6 06             	movzbl (%esi),%eax
80103e6d:	83 c6 01             	add    $0x1,%esi
80103e70:	89 75 e4             	mov    %esi,-0x1c(%ebp)
80103e73:	88 44 13 34          	mov    %al,0x34(%ebx,%edx,1)
80103e77:	3b 75 e0             	cmp    -0x20(%ebp),%esi
80103e7a:	0f 85 58 ff ff ff    	jne    80103dd8 <pipewrite+0x38>
80103e80:	83 ec 0c             	sub    $0xc,%esp
80103e83:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80103e89:	50                   	push   %eax
80103e8a:	e8 41 0a 00 00       	call   801048d0 <wakeup>
80103e8f:	89 1c 24             	mov    %ebx,(%esp)
80103e92:	e8 79 0e 00 00       	call   80104d10 <release>
80103e97:	8b 45 10             	mov    0x10(%ebp),%eax
80103e9a:	83 c4 10             	add    $0x10,%esp
80103e9d:	eb aa                	jmp    80103e49 <pipewrite+0xa9>
80103e9f:	90                   	nop

80103ea0 <piperead>:
80103ea0:	55                   	push   %ebp
80103ea1:	89 e5                	mov    %esp,%ebp
80103ea3:	57                   	push   %edi
80103ea4:	56                   	push   %esi
80103ea5:	53                   	push   %ebx
80103ea6:	83 ec 18             	sub    $0x18,%esp
80103ea9:	8b 75 08             	mov    0x8(%ebp),%esi
80103eac:	8b 7d 0c             	mov    0xc(%ebp),%edi
80103eaf:	56                   	push   %esi
80103eb0:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
80103eb6:	e8 b5 0e 00 00       	call   80104d70 <acquire>
80103ebb:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
80103ec1:	83 c4 10             	add    $0x10,%esp
80103ec4:	39 86 38 02 00 00    	cmp    %eax,0x238(%esi)
80103eca:	74 2f                	je     80103efb <piperead+0x5b>
80103ecc:	eb 37                	jmp    80103f05 <piperead+0x65>
80103ece:	66 90                	xchg   %ax,%ax
80103ed0:	e8 6b 02 00 00       	call   80104140 <myproc>
80103ed5:	8b 48 24             	mov    0x24(%eax),%ecx
80103ed8:	85 c9                	test   %ecx,%ecx
80103eda:	0f 85 80 00 00 00    	jne    80103f60 <piperead+0xc0>
80103ee0:	83 ec 08             	sub    $0x8,%esp
80103ee3:	56                   	push   %esi
80103ee4:	53                   	push   %ebx
80103ee5:	e8 26 09 00 00       	call   80104810 <sleep>
80103eea:	8b 86 38 02 00 00    	mov    0x238(%esi),%eax
80103ef0:	83 c4 10             	add    $0x10,%esp
80103ef3:	39 86 34 02 00 00    	cmp    %eax,0x234(%esi)
80103ef9:	75 0a                	jne    80103f05 <piperead+0x65>
80103efb:	8b 86 40 02 00 00    	mov    0x240(%esi),%eax
80103f01:	85 c0                	test   %eax,%eax
80103f03:	75 cb                	jne    80103ed0 <piperead+0x30>
80103f05:	8b 55 10             	mov    0x10(%ebp),%edx
80103f08:	31 db                	xor    %ebx,%ebx
80103f0a:	85 d2                	test   %edx,%edx
80103f0c:	7f 20                	jg     80103f2e <piperead+0x8e>
80103f0e:	eb 2c                	jmp    80103f3c <piperead+0x9c>
80103f10:	8d 48 01             	lea    0x1(%eax),%ecx
80103f13:	25 ff 01 00 00       	and    $0x1ff,%eax
80103f18:	89 8e 34 02 00 00    	mov    %ecx,0x234(%esi)
80103f1e:	0f b6 44 06 34       	movzbl 0x34(%esi,%eax,1),%eax
80103f23:	88 04 1f             	mov    %al,(%edi,%ebx,1)
80103f26:	83 c3 01             	add    $0x1,%ebx
80103f29:	39 5d 10             	cmp    %ebx,0x10(%ebp)
80103f2c:	74 0e                	je     80103f3c <piperead+0x9c>
80103f2e:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
80103f34:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
80103f3a:	75 d4                	jne    80103f10 <piperead+0x70>
80103f3c:	83 ec 0c             	sub    $0xc,%esp
80103f3f:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
80103f45:	50                   	push   %eax
80103f46:	e8 85 09 00 00       	call   801048d0 <wakeup>
80103f4b:	89 34 24             	mov    %esi,(%esp)
80103f4e:	e8 bd 0d 00 00       	call   80104d10 <release>
80103f53:	83 c4 10             	add    $0x10,%esp
80103f56:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103f59:	89 d8                	mov    %ebx,%eax
80103f5b:	5b                   	pop    %ebx
80103f5c:	5e                   	pop    %esi
80103f5d:	5f                   	pop    %edi
80103f5e:	5d                   	pop    %ebp
80103f5f:	c3                   	ret    
80103f60:	83 ec 0c             	sub    $0xc,%esp
80103f63:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80103f68:	56                   	push   %esi
80103f69:	e8 a2 0d 00 00       	call   80104d10 <release>
80103f6e:	83 c4 10             	add    $0x10,%esp
80103f71:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103f74:	89 d8                	mov    %ebx,%eax
80103f76:	5b                   	pop    %ebx
80103f77:	5e                   	pop    %esi
80103f78:	5f                   	pop    %edi
80103f79:	5d                   	pop    %ebp
80103f7a:	c3                   	ret    
80103f7b:	66 90                	xchg   %ax,%ax
80103f7d:	66 90                	xchg   %ax,%ax
80103f7f:	90                   	nop

80103f80 <allocproc>:
//  If found, change state to EMBRYO and initialize
//  state required to run in the kernel.
//  Otherwise return 0.
static struct proc *
allocproc(void)
{
80103f80:	55                   	push   %ebp
80103f81:	89 e5                	mov    %esp,%ebp
80103f83:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103f84:	bb 94 39 11 80       	mov    $0x80113994,%ebx
{
80103f89:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);
80103f8c:	68 60 39 11 80       	push   $0x80113960
80103f91:	e8 da 0d 00 00       	call   80104d70 <acquire>
80103f96:	83 c4 10             	add    $0x10,%esp
80103f99:	eb 10                	jmp    80103fab <allocproc+0x2b>
80103f9b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103f9f:	90                   	nop
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103fa0:	83 c3 7c             	add    $0x7c,%ebx
80103fa3:	81 fb 94 58 11 80    	cmp    $0x80115894,%ebx
80103fa9:	74 75                	je     80104020 <allocproc+0xa0>
    if (p->state == UNUSED)
80103fab:	8b 43 0c             	mov    0xc(%ebx),%eax
80103fae:	85 c0                	test   %eax,%eax
80103fb0:	75 ee                	jne    80103fa0 <allocproc+0x20>
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
80103fb2:	a1 04 b0 10 80       	mov    0x8010b004,%eax

  release(&ptable.lock);
80103fb7:	83 ec 0c             	sub    $0xc,%esp
  p->state = EMBRYO;
80103fba:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->pid = nextpid++;
80103fc1:	89 43 10             	mov    %eax,0x10(%ebx)
80103fc4:	8d 50 01             	lea    0x1(%eax),%edx
  release(&ptable.lock);
80103fc7:	68 60 39 11 80       	push   $0x80113960
  p->pid = nextpid++;
80103fcc:	89 15 04 b0 10 80    	mov    %edx,0x8010b004
  release(&ptable.lock);
80103fd2:	e8 39 0d 00 00       	call   80104d10 <release>

  // Allocate kernel stack.
  if ((p->kstack = kalloc()) == 0)
80103fd7:	e8 74 ee ff ff       	call   80102e50 <kalloc>
80103fdc:	83 c4 10             	add    $0x10,%esp
80103fdf:	89 43 08             	mov    %eax,0x8(%ebx)
80103fe2:	85 c0                	test   %eax,%eax
80103fe4:	74 53                	je     80104039 <allocproc+0xb9>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
80103fe6:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint *)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context *)sp;
  memset(p->context, 0, sizeof *p->context);
80103fec:	83 ec 04             	sub    $0x4,%esp
  sp -= sizeof *p->context;
80103fef:	05 9c 0f 00 00       	add    $0xf9c,%eax
  sp -= sizeof *p->tf;
80103ff4:	89 53 18             	mov    %edx,0x18(%ebx)
  *(uint *)sp = (uint)trapret;
80103ff7:	c7 40 14 dd 62 10 80 	movl   $0x801062dd,0x14(%eax)
  p->context = (struct context *)sp;
80103ffe:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
80104001:	6a 14                	push   $0x14
80104003:	6a 00                	push   $0x0
80104005:	50                   	push   %eax
80104006:	e8 25 0e 00 00       	call   80104e30 <memset>
  p->context->eip = (uint)forkret;
8010400b:	8b 43 1c             	mov    0x1c(%ebx),%eax

  return p;
8010400e:	83 c4 10             	add    $0x10,%esp
  p->context->eip = (uint)forkret;
80104011:	c7 40 10 50 40 10 80 	movl   $0x80104050,0x10(%eax)
}
80104018:	89 d8                	mov    %ebx,%eax
8010401a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010401d:	c9                   	leave  
8010401e:	c3                   	ret    
8010401f:	90                   	nop
  release(&ptable.lock);
80104020:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80104023:	31 db                	xor    %ebx,%ebx
  release(&ptable.lock);
80104025:	68 60 39 11 80       	push   $0x80113960
8010402a:	e8 e1 0c 00 00       	call   80104d10 <release>
}
8010402f:	89 d8                	mov    %ebx,%eax
  return 0;
80104031:	83 c4 10             	add    $0x10,%esp
}
80104034:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104037:	c9                   	leave  
80104038:	c3                   	ret    
    p->state = UNUSED;
80104039:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return 0;
80104040:	31 db                	xor    %ebx,%ebx
}
80104042:	89 d8                	mov    %ebx,%eax
80104044:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104047:	c9                   	leave  
80104048:	c3                   	ret    
80104049:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104050 <forkret>:
}

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void forkret(void)
{
80104050:	55                   	push   %ebp
80104051:	89 e5                	mov    %esp,%ebp
80104053:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
80104056:	68 60 39 11 80       	push   $0x80113960
8010405b:	e8 b0 0c 00 00       	call   80104d10 <release>

  if (first)
80104060:	a1 00 b0 10 80       	mov    0x8010b000,%eax
80104065:	83 c4 10             	add    $0x10,%esp
80104068:	85 c0                	test   %eax,%eax
8010406a:	75 04                	jne    80104070 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
8010406c:	c9                   	leave  
8010406d:	c3                   	ret    
8010406e:	66 90                	xchg   %ax,%ax
    first = 0;
80104070:	c7 05 00 b0 10 80 00 	movl   $0x0,0x8010b000
80104077:	00 00 00 
    iinit(ROOTDEV);
8010407a:	83 ec 0c             	sub    $0xc,%esp
8010407d:	6a 01                	push   $0x1
8010407f:	e8 ac dc ff ff       	call   80101d30 <iinit>
    initlog(ROOTDEV);
80104084:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
8010408b:	e8 00 f4 ff ff       	call   80103490 <initlog>
}
80104090:	83 c4 10             	add    $0x10,%esp
80104093:	c9                   	leave  
80104094:	c3                   	ret    
80104095:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010409c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801040a0 <pinit>:
{
801040a0:	55                   	push   %ebp
801040a1:	89 e5                	mov    %esp,%ebp
801040a3:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
801040a6:	68 c0 81 10 80       	push   $0x801081c0
801040ab:	68 60 39 11 80       	push   $0x80113960
801040b0:	e8 eb 0a 00 00       	call   80104ba0 <initlock>
}
801040b5:	83 c4 10             	add    $0x10,%esp
801040b8:	c9                   	leave  
801040b9:	c3                   	ret    
801040ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801040c0 <mycpu>:
{
801040c0:	55                   	push   %ebp
801040c1:	89 e5                	mov    %esp,%ebp
801040c3:	56                   	push   %esi
801040c4:	53                   	push   %ebx
  asm volatile("pushfl; popl %0" : "=r"(eflags));
801040c5:	9c                   	pushf  
801040c6:	58                   	pop    %eax
  if (readeflags() & FL_IF)
801040c7:	f6 c4 02             	test   $0x2,%ah
801040ca:	75 46                	jne    80104112 <mycpu+0x52>
  apicid = lapicid();
801040cc:	e8 ef ef ff ff       	call   801030c0 <lapicid>
  for (i = 0; i < ncpu; ++i)
801040d1:	8b 35 c4 33 11 80    	mov    0x801133c4,%esi
801040d7:	85 f6                	test   %esi,%esi
801040d9:	7e 2a                	jle    80104105 <mycpu+0x45>
801040db:	31 d2                	xor    %edx,%edx
801040dd:	eb 08                	jmp    801040e7 <mycpu+0x27>
801040df:	90                   	nop
801040e0:	83 c2 01             	add    $0x1,%edx
801040e3:	39 f2                	cmp    %esi,%edx
801040e5:	74 1e                	je     80104105 <mycpu+0x45>
    if (cpus[i].apicid == apicid)
801040e7:	69 ca b0 00 00 00    	imul   $0xb0,%edx,%ecx
801040ed:	0f b6 99 e0 33 11 80 	movzbl -0x7feecc20(%ecx),%ebx
801040f4:	39 c3                	cmp    %eax,%ebx
801040f6:	75 e8                	jne    801040e0 <mycpu+0x20>
}
801040f8:	8d 65 f8             	lea    -0x8(%ebp),%esp
      return &cpus[i];
801040fb:	8d 81 e0 33 11 80    	lea    -0x7feecc20(%ecx),%eax
}
80104101:	5b                   	pop    %ebx
80104102:	5e                   	pop    %esi
80104103:	5d                   	pop    %ebp
80104104:	c3                   	ret    
  panic("unknown apicid\n");
80104105:	83 ec 0c             	sub    $0xc,%esp
80104108:	68 c7 81 10 80       	push   $0x801081c7
8010410d:	e8 8e c2 ff ff       	call   801003a0 <panic>
    panic("mycpu called with interrupts enabled\n");
80104112:	83 ec 0c             	sub    $0xc,%esp
80104115:	68 a4 82 10 80       	push   $0x801082a4
8010411a:	e8 81 c2 ff ff       	call   801003a0 <panic>
8010411f:	90                   	nop

80104120 <cpuid>:
{
80104120:	55                   	push   %ebp
80104121:	89 e5                	mov    %esp,%ebp
80104123:	83 ec 08             	sub    $0x8,%esp
  return mycpu() - cpus;
80104126:	e8 95 ff ff ff       	call   801040c0 <mycpu>
}
8010412b:	c9                   	leave  
  return mycpu() - cpus;
8010412c:	2d e0 33 11 80       	sub    $0x801133e0,%eax
80104131:	c1 f8 04             	sar    $0x4,%eax
80104134:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
8010413a:	c3                   	ret    
8010413b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010413f:	90                   	nop

80104140 <myproc>:
{
80104140:	55                   	push   %ebp
80104141:	89 e5                	mov    %esp,%ebp
80104143:	53                   	push   %ebx
80104144:	83 ec 04             	sub    $0x4,%esp
  pushcli();
80104147:	e8 d4 0a 00 00       	call   80104c20 <pushcli>
  c = mycpu();
8010414c:	e8 6f ff ff ff       	call   801040c0 <mycpu>
  p = c->proc;
80104151:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104157:	e8 14 0b 00 00       	call   80104c70 <popcli>
}
8010415c:	89 d8                	mov    %ebx,%eax
8010415e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104161:	c9                   	leave  
80104162:	c3                   	ret    
80104163:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010416a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104170 <userinit>:
{
80104170:	55                   	push   %ebp
80104171:	89 e5                	mov    %esp,%ebp
80104173:	53                   	push   %ebx
80104174:	83 ec 04             	sub    $0x4,%esp
  p = allocproc();
80104177:	e8 04 fe ff ff       	call   80103f80 <allocproc>
8010417c:	89 c3                	mov    %eax,%ebx
  initproc = p;
8010417e:	a3 94 58 11 80       	mov    %eax,0x80115894
  if ((p->pgdir = setupkvm()) == 0)
80104183:	e8 48 37 00 00       	call   801078d0 <setupkvm>
80104188:	89 43 04             	mov    %eax,0x4(%ebx)
8010418b:	85 c0                	test   %eax,%eax
8010418d:	0f 84 bd 00 00 00    	je     80104250 <userinit+0xe0>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80104193:	83 ec 04             	sub    $0x4,%esp
80104196:	68 2c 00 00 00       	push   $0x2c
8010419b:	68 60 b4 10 80       	push   $0x8010b460
801041a0:	50                   	push   %eax
801041a1:	e8 da 33 00 00       	call   80107580 <inituvm>
  memset(p->tf, 0, sizeof(*p->tf));
801041a6:	83 c4 0c             	add    $0xc,%esp
  p->sz = PGSIZE;
801041a9:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
801041af:	6a 4c                	push   $0x4c
801041b1:	6a 00                	push   $0x0
801041b3:	ff 73 18             	push   0x18(%ebx)
801041b6:	e8 75 0c 00 00       	call   80104e30 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
801041bb:	8b 43 18             	mov    0x18(%ebx),%eax
801041be:	ba 1b 00 00 00       	mov    $0x1b,%edx
  safestrcpy(p->name, "initcode", sizeof(p->name));
801041c3:	83 c4 0c             	add    $0xc,%esp
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
801041c6:	b9 23 00 00 00       	mov    $0x23,%ecx
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
801041cb:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
801041cf:	8b 43 18             	mov    0x18(%ebx),%eax
801041d2:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
801041d6:	8b 43 18             	mov    0x18(%ebx),%eax
801041d9:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
801041dd:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
801041e1:	8b 43 18             	mov    0x18(%ebx),%eax
801041e4:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
801041e8:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
801041ec:	8b 43 18             	mov    0x18(%ebx),%eax
801041ef:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
801041f6:	8b 43 18             	mov    0x18(%ebx),%eax
801041f9:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0; // beginning of initcode.S
80104200:	8b 43 18             	mov    0x18(%ebx),%eax
80104203:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  safestrcpy(p->name, "initcode", sizeof(p->name));
8010420a:	8d 43 6c             	lea    0x6c(%ebx),%eax
8010420d:	6a 10                	push   $0x10
8010420f:	68 f0 81 10 80       	push   $0x801081f0
80104214:	50                   	push   %eax
80104215:	e8 d6 0d 00 00       	call   80104ff0 <safestrcpy>
  p->cwd = namei("/");
8010421a:	c7 04 24 f9 81 10 80 	movl   $0x801081f9,(%esp)
80104221:	e8 4a e6 ff ff       	call   80102870 <namei>
80104226:	89 43 68             	mov    %eax,0x68(%ebx)
  acquire(&ptable.lock);
80104229:	c7 04 24 60 39 11 80 	movl   $0x80113960,(%esp)
80104230:	e8 3b 0b 00 00       	call   80104d70 <acquire>
  p->state = RUNNABLE;
80104235:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
8010423c:	c7 04 24 60 39 11 80 	movl   $0x80113960,(%esp)
80104243:	e8 c8 0a 00 00       	call   80104d10 <release>
}
80104248:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010424b:	83 c4 10             	add    $0x10,%esp
8010424e:	c9                   	leave  
8010424f:	c3                   	ret    
    panic("userinit: out of memory?");
80104250:	83 ec 0c             	sub    $0xc,%esp
80104253:	68 d7 81 10 80       	push   $0x801081d7
80104258:	e8 43 c1 ff ff       	call   801003a0 <panic>
8010425d:	8d 76 00             	lea    0x0(%esi),%esi

80104260 <growproc>:
{
80104260:	55                   	push   %ebp
80104261:	89 e5                	mov    %esp,%ebp
80104263:	56                   	push   %esi
80104264:	53                   	push   %ebx
80104265:	8b 75 08             	mov    0x8(%ebp),%esi
  pushcli();
80104268:	e8 b3 09 00 00       	call   80104c20 <pushcli>
  c = mycpu();
8010426d:	e8 4e fe ff ff       	call   801040c0 <mycpu>
  p = c->proc;
80104272:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104278:	e8 f3 09 00 00       	call   80104c70 <popcli>
  sz = curproc->sz;
8010427d:	8b 03                	mov    (%ebx),%eax
  if (n > 0)
8010427f:	85 f6                	test   %esi,%esi
80104281:	7f 1d                	jg     801042a0 <growproc+0x40>
  else if (n < 0)
80104283:	75 3b                	jne    801042c0 <growproc+0x60>
  switchuvm(curproc);
80104285:	83 ec 0c             	sub    $0xc,%esp
  curproc->sz = sz;
80104288:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
8010428a:	53                   	push   %ebx
8010428b:	e8 e0 31 00 00       	call   80107470 <switchuvm>
  return 0;
80104290:	83 c4 10             	add    $0x10,%esp
80104293:	31 c0                	xor    %eax,%eax
}
80104295:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104298:	5b                   	pop    %ebx
80104299:	5e                   	pop    %esi
8010429a:	5d                   	pop    %ebp
8010429b:	c3                   	ret    
8010429c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if ((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
801042a0:	83 ec 04             	sub    $0x4,%esp
801042a3:	01 c6                	add    %eax,%esi
801042a5:	56                   	push   %esi
801042a6:	50                   	push   %eax
801042a7:	ff 73 04             	push   0x4(%ebx)
801042aa:	e8 41 34 00 00       	call   801076f0 <allocuvm>
801042af:	83 c4 10             	add    $0x10,%esp
801042b2:	85 c0                	test   %eax,%eax
801042b4:	75 cf                	jne    80104285 <growproc+0x25>
      return -1;
801042b6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801042bb:	eb d8                	jmp    80104295 <growproc+0x35>
801042bd:	8d 76 00             	lea    0x0(%esi),%esi
    if ((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
801042c0:	83 ec 04             	sub    $0x4,%esp
801042c3:	01 c6                	add    %eax,%esi
801042c5:	56                   	push   %esi
801042c6:	50                   	push   %eax
801042c7:	ff 73 04             	push   0x4(%ebx)
801042ca:	e8 51 35 00 00       	call   80107820 <deallocuvm>
801042cf:	83 c4 10             	add    $0x10,%esp
801042d2:	85 c0                	test   %eax,%eax
801042d4:	75 af                	jne    80104285 <growproc+0x25>
801042d6:	eb de                	jmp    801042b6 <growproc+0x56>
801042d8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801042df:	90                   	nop

801042e0 <fork>:
{
801042e0:	55                   	push   %ebp
801042e1:	89 e5                	mov    %esp,%ebp
801042e3:	57                   	push   %edi
801042e4:	56                   	push   %esi
801042e5:	53                   	push   %ebx
801042e6:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
801042e9:	e8 32 09 00 00       	call   80104c20 <pushcli>
  c = mycpu();
801042ee:	e8 cd fd ff ff       	call   801040c0 <mycpu>
  p = c->proc;
801042f3:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801042f9:	e8 72 09 00 00       	call   80104c70 <popcli>
  if ((np = allocproc()) == 0)
801042fe:	e8 7d fc ff ff       	call   80103f80 <allocproc>
80104303:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80104306:	85 c0                	test   %eax,%eax
80104308:	0f 84 b7 00 00 00    	je     801043c5 <fork+0xe5>
  if ((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0)
8010430e:	83 ec 08             	sub    $0x8,%esp
80104311:	ff 33                	push   (%ebx)
80104313:	89 c7                	mov    %eax,%edi
80104315:	ff 73 04             	push   0x4(%ebx)
80104318:	e8 a3 36 00 00       	call   801079c0 <copyuvm>
8010431d:	83 c4 10             	add    $0x10,%esp
80104320:	89 47 04             	mov    %eax,0x4(%edi)
80104323:	85 c0                	test   %eax,%eax
80104325:	0f 84 a1 00 00 00    	je     801043cc <fork+0xec>
  np->sz = curproc->sz;
8010432b:	8b 03                	mov    (%ebx),%eax
8010432d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80104330:	89 01                	mov    %eax,(%ecx)
  *np->tf = *curproc->tf;
80104332:	8b 79 18             	mov    0x18(%ecx),%edi
  np->parent = curproc;
80104335:	89 c8                	mov    %ecx,%eax
80104337:	89 59 14             	mov    %ebx,0x14(%ecx)
  *np->tf = *curproc->tf;
8010433a:	b9 13 00 00 00       	mov    $0x13,%ecx
8010433f:	8b 73 18             	mov    0x18(%ebx),%esi
80104342:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  for (i = 0; i < NOFILE; i++)
80104344:	31 f6                	xor    %esi,%esi
  np->tf->eax = 0;
80104346:	8b 40 18             	mov    0x18(%eax),%eax
80104349:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
    if (curproc->ofile[i])
80104350:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
80104354:	85 c0                	test   %eax,%eax
80104356:	74 13                	je     8010436b <fork+0x8b>
      np->ofile[i] = filedup(curproc->ofile[i]);
80104358:	83 ec 0c             	sub    $0xc,%esp
8010435b:	50                   	push   %eax
8010435c:	e8 0f d3 ff ff       	call   80101670 <filedup>
80104361:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80104364:	83 c4 10             	add    $0x10,%esp
80104367:	89 44 b2 28          	mov    %eax,0x28(%edx,%esi,4)
  for (i = 0; i < NOFILE; i++)
8010436b:	83 c6 01             	add    $0x1,%esi
8010436e:	83 fe 10             	cmp    $0x10,%esi
80104371:	75 dd                	jne    80104350 <fork+0x70>
  np->cwd = idup(curproc->cwd);
80104373:	83 ec 0c             	sub    $0xc,%esp
80104376:	ff 73 68             	push   0x68(%ebx)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80104379:	83 c3 6c             	add    $0x6c,%ebx
  np->cwd = idup(curproc->cwd);
8010437c:	e8 9f db ff ff       	call   80101f20 <idup>
80104381:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80104384:	83 c4 0c             	add    $0xc,%esp
  np->cwd = idup(curproc->cwd);
80104387:	89 47 68             	mov    %eax,0x68(%edi)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
8010438a:	8d 47 6c             	lea    0x6c(%edi),%eax
8010438d:	6a 10                	push   $0x10
8010438f:	53                   	push   %ebx
80104390:	50                   	push   %eax
80104391:	e8 5a 0c 00 00       	call   80104ff0 <safestrcpy>
  pid = np->pid;
80104396:	8b 5f 10             	mov    0x10(%edi),%ebx
  acquire(&ptable.lock);
80104399:	c7 04 24 60 39 11 80 	movl   $0x80113960,(%esp)
801043a0:	e8 cb 09 00 00       	call   80104d70 <acquire>
  np->state = RUNNABLE;
801043a5:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)
  release(&ptable.lock);
801043ac:	c7 04 24 60 39 11 80 	movl   $0x80113960,(%esp)
801043b3:	e8 58 09 00 00       	call   80104d10 <release>
  return pid;
801043b8:	83 c4 10             	add    $0x10,%esp
}
801043bb:	8d 65 f4             	lea    -0xc(%ebp),%esp
801043be:	89 d8                	mov    %ebx,%eax
801043c0:	5b                   	pop    %ebx
801043c1:	5e                   	pop    %esi
801043c2:	5f                   	pop    %edi
801043c3:	5d                   	pop    %ebp
801043c4:	c3                   	ret    
    return -1;
801043c5:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801043ca:	eb ef                	jmp    801043bb <fork+0xdb>
    kfree(np->kstack);
801043cc:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
801043cf:	83 ec 0c             	sub    $0xc,%esp
801043d2:	ff 73 08             	push   0x8(%ebx)
801043d5:	e8 b6 e8 ff ff       	call   80102c90 <kfree>
    np->kstack = 0;
801043da:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
    return -1;
801043e1:	83 c4 10             	add    $0x10,%esp
    np->state = UNUSED;
801043e4:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return -1;
801043eb:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801043f0:	eb c9                	jmp    801043bb <fork+0xdb>
801043f2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801043f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104400 <scheduler>:
{
80104400:	55                   	push   %ebp
80104401:	89 e5                	mov    %esp,%ebp
80104403:	57                   	push   %edi
80104404:	56                   	push   %esi
80104405:	53                   	push   %ebx
80104406:	83 ec 0c             	sub    $0xc,%esp
  struct cpu *c = mycpu();
80104409:	e8 b2 fc ff ff       	call   801040c0 <mycpu>
  c->proc = 0;
8010440e:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80104415:	00 00 00 
  struct cpu *c = mycpu();
80104418:	89 c6                	mov    %eax,%esi
  c->proc = 0;
8010441a:	8d 78 04             	lea    0x4(%eax),%edi
8010441d:	8d 76 00             	lea    0x0(%esi),%esi
  asm volatile("sti");
80104420:	fb                   	sti    
    acquire(&ptable.lock);
80104421:	83 ec 0c             	sub    $0xc,%esp
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104424:	bb 94 39 11 80       	mov    $0x80113994,%ebx
    acquire(&ptable.lock);
80104429:	68 60 39 11 80       	push   $0x80113960
8010442e:	e8 3d 09 00 00       	call   80104d70 <acquire>
80104433:	83 c4 10             	add    $0x10,%esp
80104436:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010443d:	8d 76 00             	lea    0x0(%esi),%esi
      if (p->state != RUNNABLE)
80104440:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
80104444:	75 33                	jne    80104479 <scheduler+0x79>
      switchuvm(p);
80104446:	83 ec 0c             	sub    $0xc,%esp
      c->proc = p;
80104449:	89 9e ac 00 00 00    	mov    %ebx,0xac(%esi)
      switchuvm(p);
8010444f:	53                   	push   %ebx
80104450:	e8 1b 30 00 00       	call   80107470 <switchuvm>
      swtch(&(c->scheduler), p->context);
80104455:	58                   	pop    %eax
80104456:	5a                   	pop    %edx
80104457:	ff 73 1c             	push   0x1c(%ebx)
8010445a:	57                   	push   %edi
      p->state = RUNNING;
8010445b:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
      swtch(&(c->scheduler), p->context);
80104462:	e8 e4 0b 00 00       	call   8010504b <swtch>
      switchkvm();
80104467:	e8 f4 2f 00 00       	call   80107460 <switchkvm>
      c->proc = 0;
8010446c:	83 c4 10             	add    $0x10,%esp
8010446f:	c7 86 ac 00 00 00 00 	movl   $0x0,0xac(%esi)
80104476:	00 00 00 
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104479:	83 c3 7c             	add    $0x7c,%ebx
8010447c:	81 fb 94 58 11 80    	cmp    $0x80115894,%ebx
80104482:	75 bc                	jne    80104440 <scheduler+0x40>
    release(&ptable.lock);
80104484:	83 ec 0c             	sub    $0xc,%esp
80104487:	68 60 39 11 80       	push   $0x80113960
8010448c:	e8 7f 08 00 00       	call   80104d10 <release>
    sti();
80104491:	83 c4 10             	add    $0x10,%esp
80104494:	eb 8a                	jmp    80104420 <scheduler+0x20>
80104496:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010449d:	8d 76 00             	lea    0x0(%esi),%esi

801044a0 <sched>:
{
801044a0:	55                   	push   %ebp
801044a1:	89 e5                	mov    %esp,%ebp
801044a3:	56                   	push   %esi
801044a4:	53                   	push   %ebx
  pushcli();
801044a5:	e8 76 07 00 00       	call   80104c20 <pushcli>
  c = mycpu();
801044aa:	e8 11 fc ff ff       	call   801040c0 <mycpu>
  p = c->proc;
801044af:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801044b5:	e8 b6 07 00 00       	call   80104c70 <popcli>
  if (!holding(&ptable.lock))
801044ba:	83 ec 0c             	sub    $0xc,%esp
801044bd:	68 60 39 11 80       	push   $0x80113960
801044c2:	e8 09 08 00 00       	call   80104cd0 <holding>
801044c7:	83 c4 10             	add    $0x10,%esp
801044ca:	85 c0                	test   %eax,%eax
801044cc:	74 4f                	je     8010451d <sched+0x7d>
  if (mycpu()->ncli != 1)
801044ce:	e8 ed fb ff ff       	call   801040c0 <mycpu>
801044d3:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
801044da:	75 68                	jne    80104544 <sched+0xa4>
  if (p->state == RUNNING)
801044dc:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
801044e0:	74 55                	je     80104537 <sched+0x97>
  asm volatile("pushfl; popl %0" : "=r"(eflags));
801044e2:	9c                   	pushf  
801044e3:	58                   	pop    %eax
  if (readeflags() & FL_IF)
801044e4:	f6 c4 02             	test   $0x2,%ah
801044e7:	75 41                	jne    8010452a <sched+0x8a>
  intena = mycpu()->intena;
801044e9:	e8 d2 fb ff ff       	call   801040c0 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
801044ee:	83 c3 1c             	add    $0x1c,%ebx
  intena = mycpu()->intena;
801044f1:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
801044f7:	e8 c4 fb ff ff       	call   801040c0 <mycpu>
801044fc:	83 ec 08             	sub    $0x8,%esp
801044ff:	ff 70 04             	push   0x4(%eax)
80104502:	53                   	push   %ebx
80104503:	e8 43 0b 00 00       	call   8010504b <swtch>
  mycpu()->intena = intena;
80104508:	e8 b3 fb ff ff       	call   801040c0 <mycpu>
}
8010450d:	83 c4 10             	add    $0x10,%esp
  mycpu()->intena = intena;
80104510:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80104516:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104519:	5b                   	pop    %ebx
8010451a:	5e                   	pop    %esi
8010451b:	5d                   	pop    %ebp
8010451c:	c3                   	ret    
    panic("sched ptable.lock");
8010451d:	83 ec 0c             	sub    $0xc,%esp
80104520:	68 fb 81 10 80       	push   $0x801081fb
80104525:	e8 76 be ff ff       	call   801003a0 <panic>
    panic("sched interruptible");
8010452a:	83 ec 0c             	sub    $0xc,%esp
8010452d:	68 27 82 10 80       	push   $0x80108227
80104532:	e8 69 be ff ff       	call   801003a0 <panic>
    panic("sched running");
80104537:	83 ec 0c             	sub    $0xc,%esp
8010453a:	68 19 82 10 80       	push   $0x80108219
8010453f:	e8 5c be ff ff       	call   801003a0 <panic>
    panic("sched locks");
80104544:	83 ec 0c             	sub    $0xc,%esp
80104547:	68 0d 82 10 80       	push   $0x8010820d
8010454c:	e8 4f be ff ff       	call   801003a0 <panic>
80104551:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104558:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010455f:	90                   	nop

80104560 <exit>:
{
80104560:	55                   	push   %ebp
80104561:	89 e5                	mov    %esp,%ebp
80104563:	57                   	push   %edi
80104564:	56                   	push   %esi
80104565:	53                   	push   %ebx
80104566:	83 ec 0c             	sub    $0xc,%esp
  struct proc *curproc = myproc();
80104569:	e8 d2 fb ff ff       	call   80104140 <myproc>
  if (curproc == initproc)
8010456e:	39 05 94 58 11 80    	cmp    %eax,0x80115894
80104574:	0f 84 fd 00 00 00    	je     80104677 <exit+0x117>
8010457a:	89 c3                	mov    %eax,%ebx
8010457c:	8d 70 28             	lea    0x28(%eax),%esi
8010457f:	8d 78 68             	lea    0x68(%eax),%edi
80104582:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if (curproc->ofile[fd])
80104588:	8b 06                	mov    (%esi),%eax
8010458a:	85 c0                	test   %eax,%eax
8010458c:	74 12                	je     801045a0 <exit+0x40>
      fileclose(curproc->ofile[fd]);
8010458e:	83 ec 0c             	sub    $0xc,%esp
80104591:	50                   	push   %eax
80104592:	e8 29 d1 ff ff       	call   801016c0 <fileclose>
      curproc->ofile[fd] = 0;
80104597:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
8010459d:	83 c4 10             	add    $0x10,%esp
  for (fd = 0; fd < NOFILE; fd++)
801045a0:	83 c6 04             	add    $0x4,%esi
801045a3:	39 f7                	cmp    %esi,%edi
801045a5:	75 e1                	jne    80104588 <exit+0x28>
  begin_op();
801045a7:	e8 84 ef ff ff       	call   80103530 <begin_op>
  iput(curproc->cwd);
801045ac:	83 ec 0c             	sub    $0xc,%esp
801045af:	ff 73 68             	push   0x68(%ebx)
801045b2:	e8 c9 da ff ff       	call   80102080 <iput>
  end_op();
801045b7:	e8 e4 ef ff ff       	call   801035a0 <end_op>
  curproc->cwd = 0;
801045bc:	c7 43 68 00 00 00 00 	movl   $0x0,0x68(%ebx)
  acquire(&ptable.lock);
801045c3:	c7 04 24 60 39 11 80 	movl   $0x80113960,(%esp)
801045ca:	e8 a1 07 00 00       	call   80104d70 <acquire>
  wakeup1(curproc->parent);
801045cf:	8b 53 14             	mov    0x14(%ebx),%edx
801045d2:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801045d5:	b8 94 39 11 80       	mov    $0x80113994,%eax
801045da:	eb 0e                	jmp    801045ea <exit+0x8a>
801045dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801045e0:	83 c0 7c             	add    $0x7c,%eax
801045e3:	3d 94 58 11 80       	cmp    $0x80115894,%eax
801045e8:	74 1c                	je     80104606 <exit+0xa6>
    if (p->state == SLEEPING && p->chan == chan)
801045ea:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
801045ee:	75 f0                	jne    801045e0 <exit+0x80>
801045f0:	3b 50 20             	cmp    0x20(%eax),%edx
801045f3:	75 eb                	jne    801045e0 <exit+0x80>
      p->state = RUNNABLE;
801045f5:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801045fc:	83 c0 7c             	add    $0x7c,%eax
801045ff:	3d 94 58 11 80       	cmp    $0x80115894,%eax
80104604:	75 e4                	jne    801045ea <exit+0x8a>
      p->parent = initproc;
80104606:	8b 0d 94 58 11 80    	mov    0x80115894,%ecx
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010460c:	ba 94 39 11 80       	mov    $0x80113994,%edx
80104611:	eb 10                	jmp    80104623 <exit+0xc3>
80104613:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104617:	90                   	nop
80104618:	83 c2 7c             	add    $0x7c,%edx
8010461b:	81 fa 94 58 11 80    	cmp    $0x80115894,%edx
80104621:	74 3b                	je     8010465e <exit+0xfe>
    if (p->parent == curproc)
80104623:	39 5a 14             	cmp    %ebx,0x14(%edx)
80104626:	75 f0                	jne    80104618 <exit+0xb8>
      if (p->state == ZOMBIE)
80104628:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
      p->parent = initproc;
8010462c:	89 4a 14             	mov    %ecx,0x14(%edx)
      if (p->state == ZOMBIE)
8010462f:	75 e7                	jne    80104618 <exit+0xb8>
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104631:	b8 94 39 11 80       	mov    $0x80113994,%eax
80104636:	eb 12                	jmp    8010464a <exit+0xea>
80104638:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010463f:	90                   	nop
80104640:	83 c0 7c             	add    $0x7c,%eax
80104643:	3d 94 58 11 80       	cmp    $0x80115894,%eax
80104648:	74 ce                	je     80104618 <exit+0xb8>
    if (p->state == SLEEPING && p->chan == chan)
8010464a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
8010464e:	75 f0                	jne    80104640 <exit+0xe0>
80104650:	3b 48 20             	cmp    0x20(%eax),%ecx
80104653:	75 eb                	jne    80104640 <exit+0xe0>
      p->state = RUNNABLE;
80104655:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
8010465c:	eb e2                	jmp    80104640 <exit+0xe0>
  curproc->state = ZOMBIE;
8010465e:	c7 43 0c 05 00 00 00 	movl   $0x5,0xc(%ebx)
  sched();
80104665:	e8 36 fe ff ff       	call   801044a0 <sched>
  panic("zombie exit");
8010466a:	83 ec 0c             	sub    $0xc,%esp
8010466d:	68 48 82 10 80       	push   $0x80108248
80104672:	e8 29 bd ff ff       	call   801003a0 <panic>
    panic("init exiting");
80104677:	83 ec 0c             	sub    $0xc,%esp
8010467a:	68 3b 82 10 80       	push   $0x8010823b
8010467f:	e8 1c bd ff ff       	call   801003a0 <panic>
80104684:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010468b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010468f:	90                   	nop

80104690 <wait>:
{
80104690:	55                   	push   %ebp
80104691:	89 e5                	mov    %esp,%ebp
80104693:	56                   	push   %esi
80104694:	53                   	push   %ebx
  pushcli();
80104695:	e8 86 05 00 00       	call   80104c20 <pushcli>
  c = mycpu();
8010469a:	e8 21 fa ff ff       	call   801040c0 <mycpu>
  p = c->proc;
8010469f:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
801046a5:	e8 c6 05 00 00       	call   80104c70 <popcli>
  acquire(&ptable.lock);
801046aa:	83 ec 0c             	sub    $0xc,%esp
801046ad:	68 60 39 11 80       	push   $0x80113960
801046b2:	e8 b9 06 00 00       	call   80104d70 <acquire>
801046b7:	83 c4 10             	add    $0x10,%esp
    havekids = 0;
801046ba:	31 c0                	xor    %eax,%eax
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801046bc:	bb 94 39 11 80       	mov    $0x80113994,%ebx
801046c1:	eb 10                	jmp    801046d3 <wait+0x43>
801046c3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801046c7:	90                   	nop
801046c8:	83 c3 7c             	add    $0x7c,%ebx
801046cb:	81 fb 94 58 11 80    	cmp    $0x80115894,%ebx
801046d1:	74 1b                	je     801046ee <wait+0x5e>
      if (p->parent != curproc)
801046d3:	39 73 14             	cmp    %esi,0x14(%ebx)
801046d6:	75 f0                	jne    801046c8 <wait+0x38>
      if (p->state == ZOMBIE)
801046d8:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
801046dc:	74 62                	je     80104740 <wait+0xb0>
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801046de:	83 c3 7c             	add    $0x7c,%ebx
      havekids = 1;
801046e1:	b8 01 00 00 00       	mov    $0x1,%eax
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801046e6:	81 fb 94 58 11 80    	cmp    $0x80115894,%ebx
801046ec:	75 e5                	jne    801046d3 <wait+0x43>
    if (!havekids || curproc->killed)
801046ee:	85 c0                	test   %eax,%eax
801046f0:	0f 84 a0 00 00 00    	je     80104796 <wait+0x106>
801046f6:	8b 46 24             	mov    0x24(%esi),%eax
801046f9:	85 c0                	test   %eax,%eax
801046fb:	0f 85 95 00 00 00    	jne    80104796 <wait+0x106>
  pushcli();
80104701:	e8 1a 05 00 00       	call   80104c20 <pushcli>
  c = mycpu();
80104706:	e8 b5 f9 ff ff       	call   801040c0 <mycpu>
  p = c->proc;
8010470b:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104711:	e8 5a 05 00 00       	call   80104c70 <popcli>
  if (p == 0)
80104716:	85 db                	test   %ebx,%ebx
80104718:	0f 84 8f 00 00 00    	je     801047ad <wait+0x11d>
  p->chan = chan;
8010471e:	89 73 20             	mov    %esi,0x20(%ebx)
  p->state = SLEEPING;
80104721:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80104728:	e8 73 fd ff ff       	call   801044a0 <sched>
  p->chan = 0;
8010472d:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
80104734:	eb 84                	jmp    801046ba <wait+0x2a>
80104736:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010473d:	8d 76 00             	lea    0x0(%esi),%esi
        kfree(p->kstack);
80104740:	83 ec 0c             	sub    $0xc,%esp
        pid = p->pid;
80104743:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80104746:	ff 73 08             	push   0x8(%ebx)
80104749:	e8 42 e5 ff ff       	call   80102c90 <kfree>
        p->kstack = 0;
8010474e:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80104755:	5a                   	pop    %edx
80104756:	ff 73 04             	push   0x4(%ebx)
80104759:	e8 f2 30 00 00       	call   80107850 <freevm>
        p->pid = 0;
8010475e:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
80104765:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
8010476c:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
80104770:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
80104777:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
8010477e:	c7 04 24 60 39 11 80 	movl   $0x80113960,(%esp)
80104785:	e8 86 05 00 00       	call   80104d10 <release>
        return pid;
8010478a:	83 c4 10             	add    $0x10,%esp
}
8010478d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104790:	89 f0                	mov    %esi,%eax
80104792:	5b                   	pop    %ebx
80104793:	5e                   	pop    %esi
80104794:	5d                   	pop    %ebp
80104795:	c3                   	ret    
      release(&ptable.lock);
80104796:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80104799:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
8010479e:	68 60 39 11 80       	push   $0x80113960
801047a3:	e8 68 05 00 00       	call   80104d10 <release>
      return -1;
801047a8:	83 c4 10             	add    $0x10,%esp
801047ab:	eb e0                	jmp    8010478d <wait+0xfd>
    panic("sleep");
801047ad:	83 ec 0c             	sub    $0xc,%esp
801047b0:	68 54 82 10 80       	push   $0x80108254
801047b5:	e8 e6 bb ff ff       	call   801003a0 <panic>
801047ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801047c0 <yield>:
{
801047c0:	55                   	push   %ebp
801047c1:	89 e5                	mov    %esp,%ebp
801047c3:	53                   	push   %ebx
801047c4:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock); // DOC: yieldlock
801047c7:	68 60 39 11 80       	push   $0x80113960
801047cc:	e8 9f 05 00 00       	call   80104d70 <acquire>
  pushcli();
801047d1:	e8 4a 04 00 00       	call   80104c20 <pushcli>
  c = mycpu();
801047d6:	e8 e5 f8 ff ff       	call   801040c0 <mycpu>
  p = c->proc;
801047db:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801047e1:	e8 8a 04 00 00       	call   80104c70 <popcli>
  myproc()->state = RUNNABLE;
801047e6:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  sched();
801047ed:	e8 ae fc ff ff       	call   801044a0 <sched>
  release(&ptable.lock);
801047f2:	c7 04 24 60 39 11 80 	movl   $0x80113960,(%esp)
801047f9:	e8 12 05 00 00       	call   80104d10 <release>
}
801047fe:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104801:	83 c4 10             	add    $0x10,%esp
80104804:	c9                   	leave  
80104805:	c3                   	ret    
80104806:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010480d:	8d 76 00             	lea    0x0(%esi),%esi

80104810 <sleep>:
{
80104810:	55                   	push   %ebp
80104811:	89 e5                	mov    %esp,%ebp
80104813:	57                   	push   %edi
80104814:	56                   	push   %esi
80104815:	53                   	push   %ebx
80104816:	83 ec 0c             	sub    $0xc,%esp
80104819:	8b 7d 08             	mov    0x8(%ebp),%edi
8010481c:	8b 75 0c             	mov    0xc(%ebp),%esi
  pushcli();
8010481f:	e8 fc 03 00 00       	call   80104c20 <pushcli>
  c = mycpu();
80104824:	e8 97 f8 ff ff       	call   801040c0 <mycpu>
  p = c->proc;
80104829:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
8010482f:	e8 3c 04 00 00       	call   80104c70 <popcli>
  if (p == 0)
80104834:	85 db                	test   %ebx,%ebx
80104836:	0f 84 87 00 00 00    	je     801048c3 <sleep+0xb3>
  if (lk == 0)
8010483c:	85 f6                	test   %esi,%esi
8010483e:	74 76                	je     801048b6 <sleep+0xa6>
  if (lk != &ptable.lock)
80104840:	81 fe 60 39 11 80    	cmp    $0x80113960,%esi
80104846:	74 50                	je     80104898 <sleep+0x88>
    acquire(&ptable.lock); // DOC: sleeplock1
80104848:	83 ec 0c             	sub    $0xc,%esp
8010484b:	68 60 39 11 80       	push   $0x80113960
80104850:	e8 1b 05 00 00       	call   80104d70 <acquire>
    release(lk);
80104855:	89 34 24             	mov    %esi,(%esp)
80104858:	e8 b3 04 00 00       	call   80104d10 <release>
  p->chan = chan;
8010485d:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80104860:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80104867:	e8 34 fc ff ff       	call   801044a0 <sched>
  p->chan = 0;
8010486c:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
    release(&ptable.lock);
80104873:	c7 04 24 60 39 11 80 	movl   $0x80113960,(%esp)
8010487a:	e8 91 04 00 00       	call   80104d10 <release>
    acquire(lk);
8010487f:	89 75 08             	mov    %esi,0x8(%ebp)
80104882:	83 c4 10             	add    $0x10,%esp
}
80104885:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104888:	5b                   	pop    %ebx
80104889:	5e                   	pop    %esi
8010488a:	5f                   	pop    %edi
8010488b:	5d                   	pop    %ebp
    acquire(lk);
8010488c:	e9 df 04 00 00       	jmp    80104d70 <acquire>
80104891:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  p->chan = chan;
80104898:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
8010489b:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
801048a2:	e8 f9 fb ff ff       	call   801044a0 <sched>
  p->chan = 0;
801048a7:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
801048ae:	8d 65 f4             	lea    -0xc(%ebp),%esp
801048b1:	5b                   	pop    %ebx
801048b2:	5e                   	pop    %esi
801048b3:	5f                   	pop    %edi
801048b4:	5d                   	pop    %ebp
801048b5:	c3                   	ret    
    panic("sleep without lk");
801048b6:	83 ec 0c             	sub    $0xc,%esp
801048b9:	68 5a 82 10 80       	push   $0x8010825a
801048be:	e8 dd ba ff ff       	call   801003a0 <panic>
    panic("sleep");
801048c3:	83 ec 0c             	sub    $0xc,%esp
801048c6:	68 54 82 10 80       	push   $0x80108254
801048cb:	e8 d0 ba ff ff       	call   801003a0 <panic>

801048d0 <wakeup>:
}

// Wake up all processes sleeping on chan.
void wakeup(void *chan)
{
801048d0:	55                   	push   %ebp
801048d1:	89 e5                	mov    %esp,%ebp
801048d3:	53                   	push   %ebx
801048d4:	83 ec 10             	sub    $0x10,%esp
801048d7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
801048da:	68 60 39 11 80       	push   $0x80113960
801048df:	e8 8c 04 00 00       	call   80104d70 <acquire>
801048e4:	83 c4 10             	add    $0x10,%esp
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801048e7:	b8 94 39 11 80       	mov    $0x80113994,%eax
801048ec:	eb 0c                	jmp    801048fa <wakeup+0x2a>
801048ee:	66 90                	xchg   %ax,%ax
801048f0:	83 c0 7c             	add    $0x7c,%eax
801048f3:	3d 94 58 11 80       	cmp    $0x80115894,%eax
801048f8:	74 1c                	je     80104916 <wakeup+0x46>
    if (p->state == SLEEPING && p->chan == chan)
801048fa:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
801048fe:	75 f0                	jne    801048f0 <wakeup+0x20>
80104900:	3b 58 20             	cmp    0x20(%eax),%ebx
80104903:	75 eb                	jne    801048f0 <wakeup+0x20>
      p->state = RUNNABLE;
80104905:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010490c:	83 c0 7c             	add    $0x7c,%eax
8010490f:	3d 94 58 11 80       	cmp    $0x80115894,%eax
80104914:	75 e4                	jne    801048fa <wakeup+0x2a>
  wakeup1(chan);
  release(&ptable.lock);
80104916:	c7 45 08 60 39 11 80 	movl   $0x80113960,0x8(%ebp)
}
8010491d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104920:	c9                   	leave  
  release(&ptable.lock);
80104921:	e9 ea 03 00 00       	jmp    80104d10 <release>
80104926:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010492d:	8d 76 00             	lea    0x0(%esi),%esi

80104930 <kill>:

// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int kill(int pid)
{
80104930:	55                   	push   %ebp
80104931:	89 e5                	mov    %esp,%ebp
80104933:	53                   	push   %ebx
80104934:	83 ec 10             	sub    $0x10,%esp
80104937:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
8010493a:	68 60 39 11 80       	push   $0x80113960
8010493f:	e8 2c 04 00 00       	call   80104d70 <acquire>
80104944:	83 c4 10             	add    $0x10,%esp
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104947:	b8 94 39 11 80       	mov    $0x80113994,%eax
8010494c:	eb 0c                	jmp    8010495a <kill+0x2a>
8010494e:	66 90                	xchg   %ax,%ax
80104950:	83 c0 7c             	add    $0x7c,%eax
80104953:	3d 94 58 11 80       	cmp    $0x80115894,%eax
80104958:	74 36                	je     80104990 <kill+0x60>
  {
    if (p->pid == pid)
8010495a:	39 58 10             	cmp    %ebx,0x10(%eax)
8010495d:	75 f1                	jne    80104950 <kill+0x20>
    {
      p->killed = 1;
      // Wake process from sleep if necessary.
      if (p->state == SLEEPING)
8010495f:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
      p->killed = 1;
80104963:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      if (p->state == SLEEPING)
8010496a:	75 07                	jne    80104973 <kill+0x43>
        p->state = RUNNABLE;
8010496c:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      release(&ptable.lock);
80104973:	83 ec 0c             	sub    $0xc,%esp
80104976:	68 60 39 11 80       	push   $0x80113960
8010497b:	e8 90 03 00 00       	call   80104d10 <release>
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
}
80104980:	8b 5d fc             	mov    -0x4(%ebp),%ebx
      return 0;
80104983:	83 c4 10             	add    $0x10,%esp
80104986:	31 c0                	xor    %eax,%eax
}
80104988:	c9                   	leave  
80104989:	c3                   	ret    
8010498a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  release(&ptable.lock);
80104990:	83 ec 0c             	sub    $0xc,%esp
80104993:	68 60 39 11 80       	push   $0x80113960
80104998:	e8 73 03 00 00       	call   80104d10 <release>
}
8010499d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return -1;
801049a0:	83 c4 10             	add    $0x10,%esp
801049a3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801049a8:	c9                   	leave  
801049a9:	c3                   	ret    
801049aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801049b0 <procdump>:
// PAGEBREAK: 36
//  Print a process listing to console.  For debugging.
//  Runs when user types ^P on console.
//  No lock to avoid wedging a stuck machine further.
void procdump(void)
{
801049b0:	55                   	push   %ebp
801049b1:	89 e5                	mov    %esp,%ebp
801049b3:	57                   	push   %edi
801049b4:	56                   	push   %esi
801049b5:	8d 75 e8             	lea    -0x18(%ebp),%esi
801049b8:	53                   	push   %ebx
801049b9:	bb 00 3a 11 80       	mov    $0x80113a00,%ebx
801049be:	83 ec 3c             	sub    $0x3c,%esp
801049c1:	eb 24                	jmp    801049e7 <procdump+0x37>
801049c3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801049c7:	90                   	nop
    {
      getcallerpcs((uint *)p->context->ebp + 2, pc);
      for (i = 0; i < 10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
801049c8:	83 ec 0c             	sub    $0xc,%esp
801049cb:	68 57 86 10 80       	push   $0x80108657
801049d0:	e8 7b bd ff ff       	call   80100750 <cprintf>
801049d5:	83 c4 10             	add    $0x10,%esp
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801049d8:	83 c3 7c             	add    $0x7c,%ebx
801049db:	81 fb 00 59 11 80    	cmp    $0x80115900,%ebx
801049e1:	0f 84 81 00 00 00    	je     80104a68 <procdump+0xb8>
    if (p->state == UNUSED)
801049e7:	8b 43 a0             	mov    -0x60(%ebx),%eax
801049ea:	85 c0                	test   %eax,%eax
801049ec:	74 ea                	je     801049d8 <procdump+0x28>
      state = "???";
801049ee:	ba 6b 82 10 80       	mov    $0x8010826b,%edx
    if (p->state >= 0 && p->state < NELEM(states) && states[p->state])
801049f3:	83 f8 05             	cmp    $0x5,%eax
801049f6:	77 11                	ja     80104a09 <procdump+0x59>
801049f8:	8b 14 85 cc 82 10 80 	mov    -0x7fef7d34(,%eax,4),%edx
      state = "???";
801049ff:	b8 6b 82 10 80       	mov    $0x8010826b,%eax
80104a04:	85 d2                	test   %edx,%edx
80104a06:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
80104a09:	53                   	push   %ebx
80104a0a:	52                   	push   %edx
80104a0b:	ff 73 a4             	push   -0x5c(%ebx)
80104a0e:	68 6f 82 10 80       	push   $0x8010826f
80104a13:	e8 38 bd ff ff       	call   80100750 <cprintf>
    if (p->state == SLEEPING)
80104a18:	83 c4 10             	add    $0x10,%esp
80104a1b:	83 7b a0 02          	cmpl   $0x2,-0x60(%ebx)
80104a1f:	75 a7                	jne    801049c8 <procdump+0x18>
      getcallerpcs((uint *)p->context->ebp + 2, pc);
80104a21:	83 ec 08             	sub    $0x8,%esp
80104a24:	8d 45 c0             	lea    -0x40(%ebp),%eax
80104a27:	8d 7d c0             	lea    -0x40(%ebp),%edi
80104a2a:	50                   	push   %eax
80104a2b:	8b 43 b0             	mov    -0x50(%ebx),%eax
80104a2e:	8b 40 0c             	mov    0xc(%eax),%eax
80104a31:	83 c0 08             	add    $0x8,%eax
80104a34:	50                   	push   %eax
80104a35:	e8 86 01 00 00       	call   80104bc0 <getcallerpcs>
      for (i = 0; i < 10 && pc[i] != 0; i++)
80104a3a:	83 c4 10             	add    $0x10,%esp
80104a3d:	8d 76 00             	lea    0x0(%esi),%esi
80104a40:	8b 17                	mov    (%edi),%edx
80104a42:	85 d2                	test   %edx,%edx
80104a44:	74 82                	je     801049c8 <procdump+0x18>
        cprintf(" %p", pc[i]);
80104a46:	83 ec 08             	sub    $0x8,%esp
      for (i = 0; i < 10 && pc[i] != 0; i++)
80104a49:	83 c7 04             	add    $0x4,%edi
        cprintf(" %p", pc[i]);
80104a4c:	52                   	push   %edx
80104a4d:	68 61 7c 10 80       	push   $0x80107c61
80104a52:	e8 f9 bc ff ff       	call   80100750 <cprintf>
      for (i = 0; i < 10 && pc[i] != 0; i++)
80104a57:	83 c4 10             	add    $0x10,%esp
80104a5a:	39 fe                	cmp    %edi,%esi
80104a5c:	75 e2                	jne    80104a40 <procdump+0x90>
80104a5e:	e9 65 ff ff ff       	jmp    801049c8 <procdump+0x18>
80104a63:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104a67:	90                   	nop
  }
}
80104a68:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104a6b:	5b                   	pop    %ebx
80104a6c:	5e                   	pop    %esi
80104a6d:	5f                   	pop    %edi
80104a6e:	5d                   	pop    %ebp
80104a6f:	c3                   	ret    

80104a70 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80104a70:	55                   	push   %ebp
80104a71:	89 e5                	mov    %esp,%ebp
80104a73:	53                   	push   %ebx
80104a74:	83 ec 0c             	sub    $0xc,%esp
80104a77:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
80104a7a:	68 e4 82 10 80       	push   $0x801082e4
80104a7f:	8d 43 04             	lea    0x4(%ebx),%eax
80104a82:	50                   	push   %eax
80104a83:	e8 18 01 00 00       	call   80104ba0 <initlock>
  lk->name = name;
80104a88:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
80104a8b:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
80104a91:	83 c4 10             	add    $0x10,%esp
  lk->pid = 0;
80104a94:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
80104a9b:	89 43 38             	mov    %eax,0x38(%ebx)
}
80104a9e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104aa1:	c9                   	leave  
80104aa2:	c3                   	ret    
80104aa3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104aaa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104ab0 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80104ab0:	55                   	push   %ebp
80104ab1:	89 e5                	mov    %esp,%ebp
80104ab3:	56                   	push   %esi
80104ab4:	53                   	push   %ebx
80104ab5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104ab8:	8d 73 04             	lea    0x4(%ebx),%esi
80104abb:	83 ec 0c             	sub    $0xc,%esp
80104abe:	56                   	push   %esi
80104abf:	e8 ac 02 00 00       	call   80104d70 <acquire>
  while (lk->locked) {
80104ac4:	8b 13                	mov    (%ebx),%edx
80104ac6:	83 c4 10             	add    $0x10,%esp
80104ac9:	85 d2                	test   %edx,%edx
80104acb:	74 16                	je     80104ae3 <acquiresleep+0x33>
80104acd:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
80104ad0:	83 ec 08             	sub    $0x8,%esp
80104ad3:	56                   	push   %esi
80104ad4:	53                   	push   %ebx
80104ad5:	e8 36 fd ff ff       	call   80104810 <sleep>
  while (lk->locked) {
80104ada:	8b 03                	mov    (%ebx),%eax
80104adc:	83 c4 10             	add    $0x10,%esp
80104adf:	85 c0                	test   %eax,%eax
80104ae1:	75 ed                	jne    80104ad0 <acquiresleep+0x20>
  }
  lk->locked = 1;
80104ae3:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
80104ae9:	e8 52 f6 ff ff       	call   80104140 <myproc>
80104aee:	8b 40 10             	mov    0x10(%eax),%eax
80104af1:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
80104af4:	89 75 08             	mov    %esi,0x8(%ebp)
}
80104af7:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104afa:	5b                   	pop    %ebx
80104afb:	5e                   	pop    %esi
80104afc:	5d                   	pop    %ebp
  release(&lk->lk);
80104afd:	e9 0e 02 00 00       	jmp    80104d10 <release>
80104b02:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104b09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104b10 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
80104b10:	55                   	push   %ebp
80104b11:	89 e5                	mov    %esp,%ebp
80104b13:	56                   	push   %esi
80104b14:	53                   	push   %ebx
80104b15:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104b18:	8d 73 04             	lea    0x4(%ebx),%esi
80104b1b:	83 ec 0c             	sub    $0xc,%esp
80104b1e:	56                   	push   %esi
80104b1f:	e8 4c 02 00 00       	call   80104d70 <acquire>
  lk->locked = 0;
80104b24:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
80104b2a:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
80104b31:	89 1c 24             	mov    %ebx,(%esp)
80104b34:	e8 97 fd ff ff       	call   801048d0 <wakeup>
  release(&lk->lk);
80104b39:	89 75 08             	mov    %esi,0x8(%ebp)
80104b3c:	83 c4 10             	add    $0x10,%esp
}
80104b3f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104b42:	5b                   	pop    %ebx
80104b43:	5e                   	pop    %esi
80104b44:	5d                   	pop    %ebp
  release(&lk->lk);
80104b45:	e9 c6 01 00 00       	jmp    80104d10 <release>
80104b4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104b50 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
80104b50:	55                   	push   %ebp
80104b51:	89 e5                	mov    %esp,%ebp
80104b53:	57                   	push   %edi
80104b54:	31 ff                	xor    %edi,%edi
80104b56:	56                   	push   %esi
80104b57:	53                   	push   %ebx
80104b58:	83 ec 18             	sub    $0x18,%esp
80104b5b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;
  
  acquire(&lk->lk);
80104b5e:	8d 73 04             	lea    0x4(%ebx),%esi
80104b61:	56                   	push   %esi
80104b62:	e8 09 02 00 00       	call   80104d70 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
80104b67:	8b 03                	mov    (%ebx),%eax
80104b69:	83 c4 10             	add    $0x10,%esp
80104b6c:	85 c0                	test   %eax,%eax
80104b6e:	75 18                	jne    80104b88 <holdingsleep+0x38>
  release(&lk->lk);
80104b70:	83 ec 0c             	sub    $0xc,%esp
80104b73:	56                   	push   %esi
80104b74:	e8 97 01 00 00       	call   80104d10 <release>
  return r;
}
80104b79:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104b7c:	89 f8                	mov    %edi,%eax
80104b7e:	5b                   	pop    %ebx
80104b7f:	5e                   	pop    %esi
80104b80:	5f                   	pop    %edi
80104b81:	5d                   	pop    %ebp
80104b82:	c3                   	ret    
80104b83:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104b87:	90                   	nop
  r = lk->locked && (lk->pid == myproc()->pid);
80104b88:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
80104b8b:	e8 b0 f5 ff ff       	call   80104140 <myproc>
80104b90:	39 58 10             	cmp    %ebx,0x10(%eax)
80104b93:	0f 94 c0             	sete   %al
80104b96:	0f b6 c0             	movzbl %al,%eax
80104b99:	89 c7                	mov    %eax,%edi
80104b9b:	eb d3                	jmp    80104b70 <holdingsleep+0x20>
80104b9d:	66 90                	xchg   %ax,%ax
80104b9f:	90                   	nop

80104ba0 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80104ba0:	55                   	push   %ebp
80104ba1:	89 e5                	mov    %esp,%ebp
80104ba3:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80104ba6:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
80104ba9:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
80104baf:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
80104bb2:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80104bb9:	5d                   	pop    %ebp
80104bba:	c3                   	ret    
80104bbb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104bbf:	90                   	nop

80104bc0 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80104bc0:	55                   	push   %ebp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104bc1:	31 d2                	xor    %edx,%edx
{
80104bc3:	89 e5                	mov    %esp,%ebp
80104bc5:	53                   	push   %ebx
  ebp = (uint*)v - 2;
80104bc6:	8b 45 08             	mov    0x8(%ebp),%eax
{
80104bc9:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  ebp = (uint*)v - 2;
80104bcc:	83 e8 08             	sub    $0x8,%eax
  for(i = 0; i < 10; i++){
80104bcf:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104bd0:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
80104bd6:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
80104bdc:	77 1a                	ja     80104bf8 <getcallerpcs+0x38>
      break;
    pcs[i] = ebp[1];     // saved %eip
80104bde:	8b 58 04             	mov    0x4(%eax),%ebx
80104be1:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
80104be4:	83 c2 01             	add    $0x1,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
80104be7:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80104be9:	83 fa 0a             	cmp    $0xa,%edx
80104bec:	75 e2                	jne    80104bd0 <getcallerpcs+0x10>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
80104bee:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104bf1:	c9                   	leave  
80104bf2:	c3                   	ret    
80104bf3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104bf7:	90                   	nop
  for(; i < 10; i++)
80104bf8:	8d 04 91             	lea    (%ecx,%edx,4),%eax
80104bfb:	8d 51 28             	lea    0x28(%ecx),%edx
80104bfe:	66 90                	xchg   %ax,%ax
    pcs[i] = 0;
80104c00:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
80104c06:	83 c0 04             	add    $0x4,%eax
80104c09:	39 d0                	cmp    %edx,%eax
80104c0b:	75 f3                	jne    80104c00 <getcallerpcs+0x40>
}
80104c0d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104c10:	c9                   	leave  
80104c11:	c3                   	ret    
80104c12:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104c19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104c20 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80104c20:	55                   	push   %ebp
80104c21:	89 e5                	mov    %esp,%ebp
80104c23:	53                   	push   %ebx
80104c24:	83 ec 04             	sub    $0x4,%esp
80104c27:	9c                   	pushf  
80104c28:	5b                   	pop    %ebx
  asm volatile("cli");
80104c29:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
80104c2a:	e8 91 f4 ff ff       	call   801040c0 <mycpu>
80104c2f:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
80104c35:	85 c0                	test   %eax,%eax
80104c37:	74 17                	je     80104c50 <pushcli+0x30>
    mycpu()->intena = eflags & FL_IF;
  mycpu()->ncli += 1;
80104c39:	e8 82 f4 ff ff       	call   801040c0 <mycpu>
80104c3e:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
80104c45:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104c48:	c9                   	leave  
80104c49:	c3                   	ret    
80104c4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    mycpu()->intena = eflags & FL_IF;
80104c50:	e8 6b f4 ff ff       	call   801040c0 <mycpu>
80104c55:	81 e3 00 02 00 00    	and    $0x200,%ebx
80104c5b:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
80104c61:	eb d6                	jmp    80104c39 <pushcli+0x19>
80104c63:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104c6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104c70 <popcli>:

void
popcli(void)
{
80104c70:	55                   	push   %ebp
80104c71:	89 e5                	mov    %esp,%ebp
80104c73:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r"(eflags));
80104c76:	9c                   	pushf  
80104c77:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104c78:	f6 c4 02             	test   $0x2,%ah
80104c7b:	75 35                	jne    80104cb2 <popcli+0x42>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
80104c7d:	e8 3e f4 ff ff       	call   801040c0 <mycpu>
80104c82:	83 a8 a4 00 00 00 01 	subl   $0x1,0xa4(%eax)
80104c89:	78 34                	js     80104cbf <popcli+0x4f>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104c8b:	e8 30 f4 ff ff       	call   801040c0 <mycpu>
80104c90:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80104c96:	85 d2                	test   %edx,%edx
80104c98:	74 06                	je     80104ca0 <popcli+0x30>
    sti();
}
80104c9a:	c9                   	leave  
80104c9b:	c3                   	ret    
80104c9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104ca0:	e8 1b f4 ff ff       	call   801040c0 <mycpu>
80104ca5:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
80104cab:	85 c0                	test   %eax,%eax
80104cad:	74 eb                	je     80104c9a <popcli+0x2a>
  asm volatile("sti");
80104caf:	fb                   	sti    
}
80104cb0:	c9                   	leave  
80104cb1:	c3                   	ret    
    panic("popcli - interruptible");
80104cb2:	83 ec 0c             	sub    $0xc,%esp
80104cb5:	68 ef 82 10 80       	push   $0x801082ef
80104cba:	e8 e1 b6 ff ff       	call   801003a0 <panic>
    panic("popcli");
80104cbf:	83 ec 0c             	sub    $0xc,%esp
80104cc2:	68 06 83 10 80       	push   $0x80108306
80104cc7:	e8 d4 b6 ff ff       	call   801003a0 <panic>
80104ccc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104cd0 <holding>:
{
80104cd0:	55                   	push   %ebp
80104cd1:	89 e5                	mov    %esp,%ebp
80104cd3:	56                   	push   %esi
80104cd4:	53                   	push   %ebx
80104cd5:	8b 75 08             	mov    0x8(%ebp),%esi
80104cd8:	31 db                	xor    %ebx,%ebx
  pushcli();
80104cda:	e8 41 ff ff ff       	call   80104c20 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
80104cdf:	8b 06                	mov    (%esi),%eax
80104ce1:	85 c0                	test   %eax,%eax
80104ce3:	75 0b                	jne    80104cf0 <holding+0x20>
  popcli();
80104ce5:	e8 86 ff ff ff       	call   80104c70 <popcli>
}
80104cea:	89 d8                	mov    %ebx,%eax
80104cec:	5b                   	pop    %ebx
80104ced:	5e                   	pop    %esi
80104cee:	5d                   	pop    %ebp
80104cef:	c3                   	ret    
  r = lock->locked && lock->cpu == mycpu();
80104cf0:	8b 5e 08             	mov    0x8(%esi),%ebx
80104cf3:	e8 c8 f3 ff ff       	call   801040c0 <mycpu>
80104cf8:	39 c3                	cmp    %eax,%ebx
80104cfa:	0f 94 c3             	sete   %bl
  popcli();
80104cfd:	e8 6e ff ff ff       	call   80104c70 <popcli>
  r = lock->locked && lock->cpu == mycpu();
80104d02:	0f b6 db             	movzbl %bl,%ebx
}
80104d05:	89 d8                	mov    %ebx,%eax
80104d07:	5b                   	pop    %ebx
80104d08:	5e                   	pop    %esi
80104d09:	5d                   	pop    %ebp
80104d0a:	c3                   	ret    
80104d0b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104d0f:	90                   	nop

80104d10 <release>:
{
80104d10:	55                   	push   %ebp
80104d11:	89 e5                	mov    %esp,%ebp
80104d13:	56                   	push   %esi
80104d14:	53                   	push   %ebx
80104d15:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pushcli();
80104d18:	e8 03 ff ff ff       	call   80104c20 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
80104d1d:	8b 03                	mov    (%ebx),%eax
80104d1f:	85 c0                	test   %eax,%eax
80104d21:	75 15                	jne    80104d38 <release+0x28>
  popcli();
80104d23:	e8 48 ff ff ff       	call   80104c70 <popcli>
    panic("release");
80104d28:	83 ec 0c             	sub    $0xc,%esp
80104d2b:	68 0d 83 10 80       	push   $0x8010830d
80104d30:	e8 6b b6 ff ff       	call   801003a0 <panic>
80104d35:	8d 76 00             	lea    0x0(%esi),%esi
  r = lock->locked && lock->cpu == mycpu();
80104d38:	8b 73 08             	mov    0x8(%ebx),%esi
80104d3b:	e8 80 f3 ff ff       	call   801040c0 <mycpu>
80104d40:	39 c6                	cmp    %eax,%esi
80104d42:	75 df                	jne    80104d23 <release+0x13>
  popcli();
80104d44:	e8 27 ff ff ff       	call   80104c70 <popcli>
  lk->pcs[0] = 0;
80104d49:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
80104d50:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
80104d57:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
80104d5c:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
80104d62:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104d65:	5b                   	pop    %ebx
80104d66:	5e                   	pop    %esi
80104d67:	5d                   	pop    %ebp
  popcli();
80104d68:	e9 03 ff ff ff       	jmp    80104c70 <popcli>
80104d6d:	8d 76 00             	lea    0x0(%esi),%esi

80104d70 <acquire>:
{
80104d70:	55                   	push   %ebp
80104d71:	89 e5                	mov    %esp,%ebp
80104d73:	53                   	push   %ebx
80104d74:	83 ec 04             	sub    $0x4,%esp
  pushcli(); // disable interrupts to avoid deadlock.
80104d77:	e8 a4 fe ff ff       	call   80104c20 <pushcli>
  if(holding(lk))
80104d7c:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pushcli();
80104d7f:	e8 9c fe ff ff       	call   80104c20 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
80104d84:	8b 03                	mov    (%ebx),%eax
80104d86:	85 c0                	test   %eax,%eax
80104d88:	75 7e                	jne    80104e08 <acquire+0x98>
  popcli();
80104d8a:	e8 e1 fe ff ff       	call   80104c70 <popcli>
  asm volatile("lock; xchgl %0, %1" : "+m"(*addr), "=a"(result) : "1"(newval) : "cc");
80104d8f:	b9 01 00 00 00       	mov    $0x1,%ecx
80104d94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while(xchg(&lk->locked, 1) != 0)
80104d98:	8b 55 08             	mov    0x8(%ebp),%edx
80104d9b:	89 c8                	mov    %ecx,%eax
80104d9d:	f0 87 02             	lock xchg %eax,(%edx)
80104da0:	85 c0                	test   %eax,%eax
80104da2:	75 f4                	jne    80104d98 <acquire+0x28>
  __sync_synchronize();
80104da4:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
80104da9:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104dac:	e8 0f f3 ff ff       	call   801040c0 <mycpu>
  getcallerpcs(&lk, lk->pcs);
80104db1:	8b 4d 08             	mov    0x8(%ebp),%ecx
  ebp = (uint*)v - 2;
80104db4:	89 ea                	mov    %ebp,%edx
  lk->cpu = mycpu();
80104db6:	89 43 08             	mov    %eax,0x8(%ebx)
  for(i = 0; i < 10; i++){
80104db9:	31 c0                	xor    %eax,%eax
80104dbb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104dbf:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104dc0:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
80104dc6:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
80104dcc:	77 1a                	ja     80104de8 <acquire+0x78>
    pcs[i] = ebp[1];     // saved %eip
80104dce:	8b 5a 04             	mov    0x4(%edx),%ebx
80104dd1:	89 5c 81 0c          	mov    %ebx,0xc(%ecx,%eax,4)
  for(i = 0; i < 10; i++){
80104dd5:	83 c0 01             	add    $0x1,%eax
    ebp = (uint*)ebp[0]; // saved %ebp
80104dd8:	8b 12                	mov    (%edx),%edx
  for(i = 0; i < 10; i++){
80104dda:	83 f8 0a             	cmp    $0xa,%eax
80104ddd:	75 e1                	jne    80104dc0 <acquire+0x50>
}
80104ddf:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104de2:	c9                   	leave  
80104de3:	c3                   	ret    
80104de4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(; i < 10; i++)
80104de8:	8d 44 81 0c          	lea    0xc(%ecx,%eax,4),%eax
80104dec:	8d 51 34             	lea    0x34(%ecx),%edx
80104def:	90                   	nop
    pcs[i] = 0;
80104df0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
80104df6:	83 c0 04             	add    $0x4,%eax
80104df9:	39 c2                	cmp    %eax,%edx
80104dfb:	75 f3                	jne    80104df0 <acquire+0x80>
}
80104dfd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104e00:	c9                   	leave  
80104e01:	c3                   	ret    
80104e02:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  r = lock->locked && lock->cpu == mycpu();
80104e08:	8b 5b 08             	mov    0x8(%ebx),%ebx
80104e0b:	e8 b0 f2 ff ff       	call   801040c0 <mycpu>
80104e10:	39 c3                	cmp    %eax,%ebx
80104e12:	0f 85 72 ff ff ff    	jne    80104d8a <acquire+0x1a>
  popcli();
80104e18:	e8 53 fe ff ff       	call   80104c70 <popcli>
    panic("acquire");
80104e1d:	83 ec 0c             	sub    $0xc,%esp
80104e20:	68 15 83 10 80       	push   $0x80108315
80104e25:	e8 76 b5 ff ff       	call   801003a0 <panic>
80104e2a:	66 90                	xchg   %ax,%ax
80104e2c:	66 90                	xchg   %ax,%ax
80104e2e:	66 90                	xchg   %ax,%ax

80104e30 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80104e30:	55                   	push   %ebp
80104e31:	89 e5                	mov    %esp,%ebp
80104e33:	57                   	push   %edi
80104e34:	8b 55 08             	mov    0x8(%ebp),%edx
80104e37:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104e3a:	53                   	push   %ebx
80104e3b:	8b 45 0c             	mov    0xc(%ebp),%eax
  if ((int)dst%4 == 0 && n%4 == 0){
80104e3e:	89 d7                	mov    %edx,%edi
80104e40:	09 cf                	or     %ecx,%edi
80104e42:	83 e7 03             	and    $0x3,%edi
80104e45:	75 29                	jne    80104e70 <memset+0x40>
    c &= 0xFF;
80104e47:	0f b6 f8             	movzbl %al,%edi
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
80104e4a:	c1 e0 18             	shl    $0x18,%eax
80104e4d:	89 fb                	mov    %edi,%ebx
80104e4f:	c1 e9 02             	shr    $0x2,%ecx
80104e52:	c1 e3 10             	shl    $0x10,%ebx
80104e55:	09 d8                	or     %ebx,%eax
80104e57:	09 f8                	or     %edi,%eax
80104e59:	c1 e7 08             	shl    $0x8,%edi
80104e5c:	09 f8                	or     %edi,%eax
  asm volatile("cld; rep stosl" : "=D"(addr), "=c"(cnt) : "0"(addr), "1"(cnt), "a"(data) : "memory", "cc");
80104e5e:	89 d7                	mov    %edx,%edi
80104e60:	fc                   	cld    
80104e61:	f3 ab                	rep stos %eax,%es:(%edi)
  } else
    stosb(dst, c, n);
  return dst;
}
80104e63:	5b                   	pop    %ebx
80104e64:	89 d0                	mov    %edx,%eax
80104e66:	5f                   	pop    %edi
80104e67:	5d                   	pop    %ebp
80104e68:	c3                   	ret    
80104e69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  asm volatile("cld; rep stosb" : "=D"(addr), "=c"(cnt) : "0"(addr), "1"(cnt), "a"(data) : "memory", "cc");
80104e70:	89 d7                	mov    %edx,%edi
80104e72:	fc                   	cld    
80104e73:	f3 aa                	rep stos %al,%es:(%edi)
80104e75:	5b                   	pop    %ebx
80104e76:	89 d0                	mov    %edx,%eax
80104e78:	5f                   	pop    %edi
80104e79:	5d                   	pop    %ebp
80104e7a:	c3                   	ret    
80104e7b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104e7f:	90                   	nop

80104e80 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80104e80:	55                   	push   %ebp
80104e81:	89 e5                	mov    %esp,%ebp
80104e83:	56                   	push   %esi
80104e84:	8b 75 10             	mov    0x10(%ebp),%esi
80104e87:	8b 55 08             	mov    0x8(%ebp),%edx
80104e8a:	53                   	push   %ebx
80104e8b:	8b 45 0c             	mov    0xc(%ebp),%eax
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
80104e8e:	85 f6                	test   %esi,%esi
80104e90:	74 2e                	je     80104ec0 <memcmp+0x40>
80104e92:	01 c6                	add    %eax,%esi
80104e94:	eb 14                	jmp    80104eaa <memcmp+0x2a>
80104e96:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104e9d:	8d 76 00             	lea    0x0(%esi),%esi
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
80104ea0:	83 c0 01             	add    $0x1,%eax
80104ea3:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0){
80104ea6:	39 f0                	cmp    %esi,%eax
80104ea8:	74 16                	je     80104ec0 <memcmp+0x40>
    if(*s1 != *s2)
80104eaa:	0f b6 0a             	movzbl (%edx),%ecx
80104ead:	0f b6 18             	movzbl (%eax),%ebx
80104eb0:	38 d9                	cmp    %bl,%cl
80104eb2:	74 ec                	je     80104ea0 <memcmp+0x20>
      return *s1 - *s2;
80104eb4:	0f b6 c1             	movzbl %cl,%eax
80104eb7:	29 d8                	sub    %ebx,%eax
  }

  return 0;
}
80104eb9:	5b                   	pop    %ebx
80104eba:	5e                   	pop    %esi
80104ebb:	5d                   	pop    %ebp
80104ebc:	c3                   	ret    
80104ebd:	8d 76 00             	lea    0x0(%esi),%esi
80104ec0:	5b                   	pop    %ebx
  return 0;
80104ec1:	31 c0                	xor    %eax,%eax
}
80104ec3:	5e                   	pop    %esi
80104ec4:	5d                   	pop    %ebp
80104ec5:	c3                   	ret    
80104ec6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104ecd:	8d 76 00             	lea    0x0(%esi),%esi

80104ed0 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80104ed0:	55                   	push   %ebp
80104ed1:	89 e5                	mov    %esp,%ebp
80104ed3:	57                   	push   %edi
80104ed4:	8b 55 08             	mov    0x8(%ebp),%edx
80104ed7:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104eda:	56                   	push   %esi
80104edb:	8b 75 0c             	mov    0xc(%ebp),%esi
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
80104ede:	39 d6                	cmp    %edx,%esi
80104ee0:	73 26                	jae    80104f08 <memmove+0x38>
80104ee2:	8d 3c 0e             	lea    (%esi,%ecx,1),%edi
80104ee5:	39 fa                	cmp    %edi,%edx
80104ee7:	73 1f                	jae    80104f08 <memmove+0x38>
80104ee9:	8d 41 ff             	lea    -0x1(%ecx),%eax
    s += n;
    d += n;
    while(n-- > 0)
80104eec:	85 c9                	test   %ecx,%ecx
80104eee:	74 0c                	je     80104efc <memmove+0x2c>
      *--d = *--s;
80104ef0:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
80104ef4:	88 0c 02             	mov    %cl,(%edx,%eax,1)
    while(n-- > 0)
80104ef7:	83 e8 01             	sub    $0x1,%eax
80104efa:	73 f4                	jae    80104ef0 <memmove+0x20>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
80104efc:	5e                   	pop    %esi
80104efd:	89 d0                	mov    %edx,%eax
80104eff:	5f                   	pop    %edi
80104f00:	5d                   	pop    %ebp
80104f01:	c3                   	ret    
80104f02:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    while(n-- > 0)
80104f08:	8d 04 0e             	lea    (%esi,%ecx,1),%eax
80104f0b:	89 d7                	mov    %edx,%edi
80104f0d:	85 c9                	test   %ecx,%ecx
80104f0f:	74 eb                	je     80104efc <memmove+0x2c>
80104f11:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      *d++ = *s++;
80104f18:	a4                   	movsb  %ds:(%esi),%es:(%edi)
    while(n-- > 0)
80104f19:	39 c6                	cmp    %eax,%esi
80104f1b:	75 fb                	jne    80104f18 <memmove+0x48>
}
80104f1d:	5e                   	pop    %esi
80104f1e:	89 d0                	mov    %edx,%eax
80104f20:	5f                   	pop    %edi
80104f21:	5d                   	pop    %ebp
80104f22:	c3                   	ret    
80104f23:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104f2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104f30 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
  return memmove(dst, src, n);
80104f30:	eb 9e                	jmp    80104ed0 <memmove>
80104f32:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104f39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104f40 <strncmp>:
}

int
strncmp(const char *p, const char *q, uint n)
{
80104f40:	55                   	push   %ebp
80104f41:	89 e5                	mov    %esp,%ebp
80104f43:	56                   	push   %esi
80104f44:	8b 75 10             	mov    0x10(%ebp),%esi
80104f47:	8b 4d 08             	mov    0x8(%ebp),%ecx
80104f4a:	53                   	push   %ebx
80104f4b:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(n > 0 && *p && *p == *q)
80104f4e:	85 f6                	test   %esi,%esi
80104f50:	74 2e                	je     80104f80 <strncmp+0x40>
80104f52:	01 d6                	add    %edx,%esi
80104f54:	eb 18                	jmp    80104f6e <strncmp+0x2e>
80104f56:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104f5d:	8d 76 00             	lea    0x0(%esi),%esi
80104f60:	38 d8                	cmp    %bl,%al
80104f62:	75 14                	jne    80104f78 <strncmp+0x38>
    n--, p++, q++;
80104f64:	83 c2 01             	add    $0x1,%edx
80104f67:	83 c1 01             	add    $0x1,%ecx
  while(n > 0 && *p && *p == *q)
80104f6a:	39 f2                	cmp    %esi,%edx
80104f6c:	74 12                	je     80104f80 <strncmp+0x40>
80104f6e:	0f b6 01             	movzbl (%ecx),%eax
80104f71:	0f b6 1a             	movzbl (%edx),%ebx
80104f74:	84 c0                	test   %al,%al
80104f76:	75 e8                	jne    80104f60 <strncmp+0x20>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
80104f78:	29 d8                	sub    %ebx,%eax
}
80104f7a:	5b                   	pop    %ebx
80104f7b:	5e                   	pop    %esi
80104f7c:	5d                   	pop    %ebp
80104f7d:	c3                   	ret    
80104f7e:	66 90                	xchg   %ax,%ax
80104f80:	5b                   	pop    %ebx
    return 0;
80104f81:	31 c0                	xor    %eax,%eax
}
80104f83:	5e                   	pop    %esi
80104f84:	5d                   	pop    %ebp
80104f85:	c3                   	ret    
80104f86:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104f8d:	8d 76 00             	lea    0x0(%esi),%esi

80104f90 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80104f90:	55                   	push   %ebp
80104f91:	89 e5                	mov    %esp,%ebp
80104f93:	57                   	push   %edi
80104f94:	56                   	push   %esi
80104f95:	8b 75 08             	mov    0x8(%ebp),%esi
80104f98:	53                   	push   %ebx
80104f99:	8b 4d 10             	mov    0x10(%ebp),%ecx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
80104f9c:	89 f0                	mov    %esi,%eax
80104f9e:	eb 15                	jmp    80104fb5 <strncpy+0x25>
80104fa0:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
80104fa4:	8b 7d 0c             	mov    0xc(%ebp),%edi
80104fa7:	83 c0 01             	add    $0x1,%eax
80104faa:	0f b6 57 ff          	movzbl -0x1(%edi),%edx
80104fae:	88 50 ff             	mov    %dl,-0x1(%eax)
80104fb1:	84 d2                	test   %dl,%dl
80104fb3:	74 09                	je     80104fbe <strncpy+0x2e>
80104fb5:	89 cb                	mov    %ecx,%ebx
80104fb7:	83 e9 01             	sub    $0x1,%ecx
80104fba:	85 db                	test   %ebx,%ebx
80104fbc:	7f e2                	jg     80104fa0 <strncpy+0x10>
    ;
  while(n-- > 0)
80104fbe:	89 c2                	mov    %eax,%edx
80104fc0:	85 c9                	test   %ecx,%ecx
80104fc2:	7e 17                	jle    80104fdb <strncpy+0x4b>
80104fc4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *s++ = 0;
80104fc8:	83 c2 01             	add    $0x1,%edx
80104fcb:	89 c1                	mov    %eax,%ecx
80104fcd:	c6 42 ff 00          	movb   $0x0,-0x1(%edx)
  while(n-- > 0)
80104fd1:	29 d1                	sub    %edx,%ecx
80104fd3:	8d 4c 0b ff          	lea    -0x1(%ebx,%ecx,1),%ecx
80104fd7:	85 c9                	test   %ecx,%ecx
80104fd9:	7f ed                	jg     80104fc8 <strncpy+0x38>
  return os;
}
80104fdb:	5b                   	pop    %ebx
80104fdc:	89 f0                	mov    %esi,%eax
80104fde:	5e                   	pop    %esi
80104fdf:	5f                   	pop    %edi
80104fe0:	5d                   	pop    %ebp
80104fe1:	c3                   	ret    
80104fe2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104fe9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104ff0 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80104ff0:	55                   	push   %ebp
80104ff1:	89 e5                	mov    %esp,%ebp
80104ff3:	56                   	push   %esi
80104ff4:	8b 55 10             	mov    0x10(%ebp),%edx
80104ff7:	8b 75 08             	mov    0x8(%ebp),%esi
80104ffa:	53                   	push   %ebx
80104ffb:	8b 45 0c             	mov    0xc(%ebp),%eax
  char *os;

  os = s;
  if(n <= 0)
80104ffe:	85 d2                	test   %edx,%edx
80105000:	7e 25                	jle    80105027 <safestrcpy+0x37>
80105002:	8d 5c 10 ff          	lea    -0x1(%eax,%edx,1),%ebx
80105006:	89 f2                	mov    %esi,%edx
80105008:	eb 16                	jmp    80105020 <safestrcpy+0x30>
8010500a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80105010:	0f b6 08             	movzbl (%eax),%ecx
80105013:	83 c0 01             	add    $0x1,%eax
80105016:	83 c2 01             	add    $0x1,%edx
80105019:	88 4a ff             	mov    %cl,-0x1(%edx)
8010501c:	84 c9                	test   %cl,%cl
8010501e:	74 04                	je     80105024 <safestrcpy+0x34>
80105020:	39 d8                	cmp    %ebx,%eax
80105022:	75 ec                	jne    80105010 <safestrcpy+0x20>
    ;
  *s = 0;
80105024:	c6 02 00             	movb   $0x0,(%edx)
  return os;
}
80105027:	89 f0                	mov    %esi,%eax
80105029:	5b                   	pop    %ebx
8010502a:	5e                   	pop    %esi
8010502b:	5d                   	pop    %ebp
8010502c:	c3                   	ret    
8010502d:	8d 76 00             	lea    0x0(%esi),%esi

80105030 <strlen>:

int
strlen(const char *s)
{
80105030:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80105031:	31 c0                	xor    %eax,%eax
{
80105033:	89 e5                	mov    %esp,%ebp
80105035:	8b 55 08             	mov    0x8(%ebp),%edx
  for(n = 0; s[n]; n++)
80105038:	80 3a 00             	cmpb   $0x0,(%edx)
8010503b:	74 0c                	je     80105049 <strlen+0x19>
8010503d:	8d 76 00             	lea    0x0(%esi),%esi
80105040:	83 c0 01             	add    $0x1,%eax
80105043:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80105047:	75 f7                	jne    80105040 <strlen+0x10>
    ;
  return n;
}
80105049:	5d                   	pop    %ebp
8010504a:	c3                   	ret    

8010504b <swtch>:
8010504b:	8b 44 24 04          	mov    0x4(%esp),%eax
8010504f:	8b 54 24 08          	mov    0x8(%esp),%edx
80105053:	55                   	push   %ebp
80105054:	53                   	push   %ebx
80105055:	56                   	push   %esi
80105056:	57                   	push   %edi
80105057:	89 20                	mov    %esp,(%eax)
80105059:	89 d4                	mov    %edx,%esp
8010505b:	5f                   	pop    %edi
8010505c:	5e                   	pop    %esi
8010505d:	5b                   	pop    %ebx
8010505e:	5d                   	pop    %ebp
8010505f:	c3                   	ret    

80105060 <fetchint>:
// library system call function. The saved user %esp points
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int fetchint(uint addr, int *ip)
{
80105060:	55                   	push   %ebp
80105061:	89 e5                	mov    %esp,%ebp
80105063:	53                   	push   %ebx
80105064:	83 ec 04             	sub    $0x4,%esp
80105067:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
8010506a:	e8 d1 f0 ff ff       	call   80104140 <myproc>

  if (addr >= curproc->sz || addr + 4 > curproc->sz)
8010506f:	8b 00                	mov    (%eax),%eax
80105071:	39 d8                	cmp    %ebx,%eax
80105073:	76 1b                	jbe    80105090 <fetchint+0x30>
80105075:	8d 53 04             	lea    0x4(%ebx),%edx
80105078:	39 d0                	cmp    %edx,%eax
8010507a:	72 14                	jb     80105090 <fetchint+0x30>
    return -1;
  *ip = *(int *)(addr);
8010507c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010507f:	8b 13                	mov    (%ebx),%edx
80105081:	89 10                	mov    %edx,(%eax)
  return 0;
80105083:	31 c0                	xor    %eax,%eax
}
80105085:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105088:	c9                   	leave  
80105089:	c3                   	ret    
8010508a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80105090:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105095:	eb ee                	jmp    80105085 <fetchint+0x25>
80105097:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010509e:	66 90                	xchg   %ax,%ax

801050a0 <fetchstr>:

// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int fetchstr(uint addr, char **pp)
{
801050a0:	55                   	push   %ebp
801050a1:	89 e5                	mov    %esp,%ebp
801050a3:	53                   	push   %ebx
801050a4:	83 ec 04             	sub    $0x4,%esp
801050a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
801050aa:	e8 91 f0 ff ff       	call   80104140 <myproc>

  if (addr >= curproc->sz)
801050af:	39 18                	cmp    %ebx,(%eax)
801050b1:	76 2d                	jbe    801050e0 <fetchstr+0x40>
    return -1;
  *pp = (char *)addr;
801050b3:	8b 55 0c             	mov    0xc(%ebp),%edx
801050b6:	89 1a                	mov    %ebx,(%edx)
  ep = (char *)curproc->sz;
801050b8:	8b 10                	mov    (%eax),%edx
  for (s = *pp; s < ep; s++)
801050ba:	39 d3                	cmp    %edx,%ebx
801050bc:	73 22                	jae    801050e0 <fetchstr+0x40>
801050be:	89 d8                	mov    %ebx,%eax
801050c0:	eb 0d                	jmp    801050cf <fetchstr+0x2f>
801050c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801050c8:	83 c0 01             	add    $0x1,%eax
801050cb:	39 c2                	cmp    %eax,%edx
801050cd:	76 11                	jbe    801050e0 <fetchstr+0x40>
  {
    if (*s == 0)
801050cf:	80 38 00             	cmpb   $0x0,(%eax)
801050d2:	75 f4                	jne    801050c8 <fetchstr+0x28>
      return s - *pp;
801050d4:	29 d8                	sub    %ebx,%eax
  }
  return -1;
}
801050d6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801050d9:	c9                   	leave  
801050da:	c3                   	ret    
801050db:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801050df:	90                   	nop
801050e0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return -1;
801050e3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801050e8:	c9                   	leave  
801050e9:	c3                   	ret    
801050ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801050f0 <argint>:

// Fetch the nth 32-bit system call argument.
int argint(int n, int *ip)
{
801050f0:	55                   	push   %ebp
801050f1:	89 e5                	mov    %esp,%ebp
801050f3:	56                   	push   %esi
801050f4:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4 * n, ip);
801050f5:	e8 46 f0 ff ff       	call   80104140 <myproc>
801050fa:	8b 55 08             	mov    0x8(%ebp),%edx
801050fd:	8b 40 18             	mov    0x18(%eax),%eax
80105100:	8b 40 44             	mov    0x44(%eax),%eax
80105103:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80105106:	e8 35 f0 ff ff       	call   80104140 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4 * n, ip);
8010510b:	8d 73 04             	lea    0x4(%ebx),%esi
  if (addr >= curproc->sz || addr + 4 > curproc->sz)
8010510e:	8b 00                	mov    (%eax),%eax
80105110:	39 c6                	cmp    %eax,%esi
80105112:	73 1c                	jae    80105130 <argint+0x40>
80105114:	8d 53 08             	lea    0x8(%ebx),%edx
80105117:	39 d0                	cmp    %edx,%eax
80105119:	72 15                	jb     80105130 <argint+0x40>
  *ip = *(int *)(addr);
8010511b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010511e:	8b 53 04             	mov    0x4(%ebx),%edx
80105121:	89 10                	mov    %edx,(%eax)
  return 0;
80105123:	31 c0                	xor    %eax,%eax
}
80105125:	5b                   	pop    %ebx
80105126:	5e                   	pop    %esi
80105127:	5d                   	pop    %ebp
80105128:	c3                   	ret    
80105129:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105130:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchint((myproc()->tf->esp) + 4 + 4 * n, ip);
80105135:	eb ee                	jmp    80105125 <argint+0x35>
80105137:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010513e:	66 90                	xchg   %ax,%ax

80105140 <argptr>:

// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int argptr(int n, char **pp, int size)
{
80105140:	55                   	push   %ebp
80105141:	89 e5                	mov    %esp,%ebp
80105143:	57                   	push   %edi
80105144:	56                   	push   %esi
80105145:	53                   	push   %ebx
80105146:	83 ec 0c             	sub    $0xc,%esp
  int i;
  struct proc *curproc = myproc();
80105149:	e8 f2 ef ff ff       	call   80104140 <myproc>
8010514e:	89 c6                	mov    %eax,%esi
  return fetchint((myproc()->tf->esp) + 4 + 4 * n, ip);
80105150:	e8 eb ef ff ff       	call   80104140 <myproc>
80105155:	8b 55 08             	mov    0x8(%ebp),%edx
80105158:	8b 40 18             	mov    0x18(%eax),%eax
8010515b:	8b 40 44             	mov    0x44(%eax),%eax
8010515e:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80105161:	e8 da ef ff ff       	call   80104140 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4 * n, ip);
80105166:	8d 7b 04             	lea    0x4(%ebx),%edi
  if (addr >= curproc->sz || addr + 4 > curproc->sz)
80105169:	8b 00                	mov    (%eax),%eax
8010516b:	39 c7                	cmp    %eax,%edi
8010516d:	73 31                	jae    801051a0 <argptr+0x60>
8010516f:	8d 4b 08             	lea    0x8(%ebx),%ecx
80105172:	39 c8                	cmp    %ecx,%eax
80105174:	72 2a                	jb     801051a0 <argptr+0x60>

  if (argint(n, &i) < 0)
    return -1;
  if (size < 0 || (uint)i >= curproc->sz || (uint)i + size > curproc->sz)
80105176:	8b 55 10             	mov    0x10(%ebp),%edx
  *ip = *(int *)(addr);
80105179:	8b 43 04             	mov    0x4(%ebx),%eax
  if (size < 0 || (uint)i >= curproc->sz || (uint)i + size > curproc->sz)
8010517c:	85 d2                	test   %edx,%edx
8010517e:	78 20                	js     801051a0 <argptr+0x60>
80105180:	8b 16                	mov    (%esi),%edx
80105182:	39 c2                	cmp    %eax,%edx
80105184:	76 1a                	jbe    801051a0 <argptr+0x60>
80105186:	8b 5d 10             	mov    0x10(%ebp),%ebx
80105189:	01 c3                	add    %eax,%ebx
8010518b:	39 da                	cmp    %ebx,%edx
8010518d:	72 11                	jb     801051a0 <argptr+0x60>
    return -1;
  *pp = (char *)i;
8010518f:	8b 55 0c             	mov    0xc(%ebp),%edx
80105192:	89 02                	mov    %eax,(%edx)
  return 0;
80105194:	31 c0                	xor    %eax,%eax
}
80105196:	83 c4 0c             	add    $0xc,%esp
80105199:	5b                   	pop    %ebx
8010519a:	5e                   	pop    %esi
8010519b:	5f                   	pop    %edi
8010519c:	5d                   	pop    %ebp
8010519d:	c3                   	ret    
8010519e:	66 90                	xchg   %ax,%ax
    return -1;
801051a0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801051a5:	eb ef                	jmp    80105196 <argptr+0x56>
801051a7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801051ae:	66 90                	xchg   %ax,%ax

801051b0 <argstr>:
// Fetch the nth word-sized system call argument as a string pointer.
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int argstr(int n, char **pp)
{
801051b0:	55                   	push   %ebp
801051b1:	89 e5                	mov    %esp,%ebp
801051b3:	56                   	push   %esi
801051b4:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4 * n, ip);
801051b5:	e8 86 ef ff ff       	call   80104140 <myproc>
801051ba:	8b 55 08             	mov    0x8(%ebp),%edx
801051bd:	8b 40 18             	mov    0x18(%eax),%eax
801051c0:	8b 40 44             	mov    0x44(%eax),%eax
801051c3:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
801051c6:	e8 75 ef ff ff       	call   80104140 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4 * n, ip);
801051cb:	8d 73 04             	lea    0x4(%ebx),%esi
  if (addr >= curproc->sz || addr + 4 > curproc->sz)
801051ce:	8b 00                	mov    (%eax),%eax
801051d0:	39 c6                	cmp    %eax,%esi
801051d2:	73 44                	jae    80105218 <argstr+0x68>
801051d4:	8d 53 08             	lea    0x8(%ebx),%edx
801051d7:	39 d0                	cmp    %edx,%eax
801051d9:	72 3d                	jb     80105218 <argstr+0x68>
  *ip = *(int *)(addr);
801051db:	8b 5b 04             	mov    0x4(%ebx),%ebx
  struct proc *curproc = myproc();
801051de:	e8 5d ef ff ff       	call   80104140 <myproc>
  if (addr >= curproc->sz)
801051e3:	3b 18                	cmp    (%eax),%ebx
801051e5:	73 31                	jae    80105218 <argstr+0x68>
  *pp = (char *)addr;
801051e7:	8b 55 0c             	mov    0xc(%ebp),%edx
801051ea:	89 1a                	mov    %ebx,(%edx)
  ep = (char *)curproc->sz;
801051ec:	8b 10                	mov    (%eax),%edx
  for (s = *pp; s < ep; s++)
801051ee:	39 d3                	cmp    %edx,%ebx
801051f0:	73 26                	jae    80105218 <argstr+0x68>
801051f2:	89 d8                	mov    %ebx,%eax
801051f4:	eb 11                	jmp    80105207 <argstr+0x57>
801051f6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801051fd:	8d 76 00             	lea    0x0(%esi),%esi
80105200:	83 c0 01             	add    $0x1,%eax
80105203:	39 c2                	cmp    %eax,%edx
80105205:	76 11                	jbe    80105218 <argstr+0x68>
    if (*s == 0)
80105207:	80 38 00             	cmpb   $0x0,(%eax)
8010520a:	75 f4                	jne    80105200 <argstr+0x50>
      return s - *pp;
8010520c:	29 d8                	sub    %ebx,%eax
  int addr;
  if (argint(n, &addr) < 0)
    return -1;
  return fetchstr(addr, pp);
}
8010520e:	5b                   	pop    %ebx
8010520f:	5e                   	pop    %esi
80105210:	5d                   	pop    %ebp
80105211:	c3                   	ret    
80105212:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105218:	5b                   	pop    %ebx
    return -1;
80105219:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010521e:	5e                   	pop    %esi
8010521f:	5d                   	pop    %ebp
80105220:	c3                   	ret    
80105221:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105228:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010522f:	90                   	nop

80105230 <syscall>:
    [SYS_find_digital_root] sys_find_digital_root,
    [SYS_copy_file] sys_copy_file,
};

void syscall(void)
{
80105230:	55                   	push   %ebp
80105231:	89 e5                	mov    %esp,%ebp
80105233:	53                   	push   %ebx
80105234:	83 ec 04             	sub    $0x4,%esp
  int num;
  struct proc *curproc = myproc();
80105237:	e8 04 ef ff ff       	call   80104140 <myproc>
8010523c:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax;
8010523e:	8b 40 18             	mov    0x18(%eax),%eax
80105241:	8b 40 1c             	mov    0x1c(%eax),%eax
  if (num > 0 && num < NELEM(syscalls) && syscalls[num])
80105244:	8d 50 ff             	lea    -0x1(%eax),%edx
80105247:	83 fa 16             	cmp    $0x16,%edx
8010524a:	77 24                	ja     80105270 <syscall+0x40>
8010524c:	8b 14 85 40 83 10 80 	mov    -0x7fef7cc0(,%eax,4),%edx
80105253:	85 d2                	test   %edx,%edx
80105255:	74 19                	je     80105270 <syscall+0x40>
  {
    curproc->tf->eax = syscalls[num]();
80105257:	ff d2                	call   *%edx
80105259:	89 c2                	mov    %eax,%edx
8010525b:	8b 43 18             	mov    0x18(%ebx),%eax
8010525e:	89 50 1c             	mov    %edx,0x1c(%eax)
  {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
80105261:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105264:	c9                   	leave  
80105265:	c3                   	ret    
80105266:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010526d:	8d 76 00             	lea    0x0(%esi),%esi
    cprintf("%d %s: unknown sys call %d\n",
80105270:	50                   	push   %eax
            curproc->pid, curproc->name, num);
80105271:	8d 43 6c             	lea    0x6c(%ebx),%eax
    cprintf("%d %s: unknown sys call %d\n",
80105274:	50                   	push   %eax
80105275:	ff 73 10             	push   0x10(%ebx)
80105278:	68 1d 83 10 80       	push   $0x8010831d
8010527d:	e8 ce b4 ff ff       	call   80100750 <cprintf>
    curproc->tf->eax = -1;
80105282:	8b 43 18             	mov    0x18(%ebx),%eax
80105285:	83 c4 10             	add    $0x10,%esp
80105288:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
8010528f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105292:	c9                   	leave  
80105293:	c3                   	ret    
80105294:	66 90                	xchg   %ax,%ax
80105296:	66 90                	xchg   %ax,%ax
80105298:	66 90                	xchg   %ax,%ax
8010529a:	66 90                	xchg   %ax,%ax
8010529c:	66 90                	xchg   %ax,%ax
8010529e:	66 90                	xchg   %ax,%ax

801052a0 <create>:
  return -1;
}

static struct inode *
create(char *path, short type, short major, short minor)
{
801052a0:	55                   	push   %ebp
801052a1:	89 e5                	mov    %esp,%ebp
801052a3:	57                   	push   %edi
801052a4:	56                   	push   %esi
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if ((dp = nameiparent(path, name)) == 0)
801052a5:	8d 7d da             	lea    -0x26(%ebp),%edi
{
801052a8:	53                   	push   %ebx
801052a9:	83 ec 34             	sub    $0x34,%esp
801052ac:	89 4d d0             	mov    %ecx,-0x30(%ebp)
801052af:	8b 4d 08             	mov    0x8(%ebp),%ecx
  if ((dp = nameiparent(path, name)) == 0)
801052b2:	57                   	push   %edi
801052b3:	50                   	push   %eax
{
801052b4:	89 55 d4             	mov    %edx,-0x2c(%ebp)
801052b7:	89 4d cc             	mov    %ecx,-0x34(%ebp)
  if ((dp = nameiparent(path, name)) == 0)
801052ba:	e8 d1 d5 ff ff       	call   80102890 <nameiparent>
801052bf:	83 c4 10             	add    $0x10,%esp
801052c2:	85 c0                	test   %eax,%eax
801052c4:	0f 84 46 01 00 00    	je     80105410 <create+0x170>
    return 0;
  ilock(dp);
801052ca:	83 ec 0c             	sub    $0xc,%esp
801052cd:	89 c3                	mov    %eax,%ebx
801052cf:	50                   	push   %eax
801052d0:	e8 7b cc ff ff       	call   80101f50 <ilock>

  if ((ip = dirlookup(dp, name, 0)) != 0)
801052d5:	83 c4 0c             	add    $0xc,%esp
801052d8:	6a 00                	push   $0x0
801052da:	57                   	push   %edi
801052db:	53                   	push   %ebx
801052dc:	e8 cf d1 ff ff       	call   801024b0 <dirlookup>
801052e1:	83 c4 10             	add    $0x10,%esp
801052e4:	89 c6                	mov    %eax,%esi
801052e6:	85 c0                	test   %eax,%eax
801052e8:	74 56                	je     80105340 <create+0xa0>
  {
    iunlockput(dp);
801052ea:	83 ec 0c             	sub    $0xc,%esp
801052ed:	53                   	push   %ebx
801052ee:	e8 ed ce ff ff       	call   801021e0 <iunlockput>
    ilock(ip);
801052f3:	89 34 24             	mov    %esi,(%esp)
801052f6:	e8 55 cc ff ff       	call   80101f50 <ilock>
    if (type == T_FILE && ip->type == T_FILE)
801052fb:	83 c4 10             	add    $0x10,%esp
801052fe:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
80105303:	75 1b                	jne    80105320 <create+0x80>
80105305:	66 83 7e 50 02       	cmpw   $0x2,0x50(%esi)
8010530a:	75 14                	jne    80105320 <create+0x80>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
8010530c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010530f:	89 f0                	mov    %esi,%eax
80105311:	5b                   	pop    %ebx
80105312:	5e                   	pop    %esi
80105313:	5f                   	pop    %edi
80105314:	5d                   	pop    %ebp
80105315:	c3                   	ret    
80105316:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010531d:	8d 76 00             	lea    0x0(%esi),%esi
    iunlockput(ip);
80105320:	83 ec 0c             	sub    $0xc,%esp
80105323:	56                   	push   %esi
    return 0;
80105324:	31 f6                	xor    %esi,%esi
    iunlockput(ip);
80105326:	e8 b5 ce ff ff       	call   801021e0 <iunlockput>
    return 0;
8010532b:	83 c4 10             	add    $0x10,%esp
}
8010532e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105331:	89 f0                	mov    %esi,%eax
80105333:	5b                   	pop    %ebx
80105334:	5e                   	pop    %esi
80105335:	5f                   	pop    %edi
80105336:	5d                   	pop    %ebp
80105337:	c3                   	ret    
80105338:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010533f:	90                   	nop
  if ((ip = ialloc(dp->dev, type)) == 0)
80105340:	0f bf 45 d4          	movswl -0x2c(%ebp),%eax
80105344:	83 ec 08             	sub    $0x8,%esp
80105347:	50                   	push   %eax
80105348:	ff 33                	push   (%ebx)
8010534a:	e8 91 ca ff ff       	call   80101de0 <ialloc>
8010534f:	83 c4 10             	add    $0x10,%esp
80105352:	89 c6                	mov    %eax,%esi
80105354:	85 c0                	test   %eax,%eax
80105356:	0f 84 cd 00 00 00    	je     80105429 <create+0x189>
  ilock(ip);
8010535c:	83 ec 0c             	sub    $0xc,%esp
8010535f:	50                   	push   %eax
80105360:	e8 eb cb ff ff       	call   80101f50 <ilock>
  ip->major = major;
80105365:	0f b7 45 d0          	movzwl -0x30(%ebp),%eax
80105369:	66 89 46 52          	mov    %ax,0x52(%esi)
  ip->minor = minor;
8010536d:	0f b7 45 cc          	movzwl -0x34(%ebp),%eax
80105371:	66 89 46 54          	mov    %ax,0x54(%esi)
  ip->nlink = 1;
80105375:	b8 01 00 00 00       	mov    $0x1,%eax
8010537a:	66 89 46 56          	mov    %ax,0x56(%esi)
  iupdate(ip);
8010537e:	89 34 24             	mov    %esi,(%esp)
80105381:	e8 1a cb ff ff       	call   80101ea0 <iupdate>
  if (type == T_DIR)
80105386:	83 c4 10             	add    $0x10,%esp
80105389:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
8010538e:	74 30                	je     801053c0 <create+0x120>
  if (dirlink(dp, name, ip->inum) < 0)
80105390:	83 ec 04             	sub    $0x4,%esp
80105393:	ff 76 04             	push   0x4(%esi)
80105396:	57                   	push   %edi
80105397:	53                   	push   %ebx
80105398:	e8 13 d4 ff ff       	call   801027b0 <dirlink>
8010539d:	83 c4 10             	add    $0x10,%esp
801053a0:	85 c0                	test   %eax,%eax
801053a2:	78 78                	js     8010541c <create+0x17c>
  iunlockput(dp);
801053a4:	83 ec 0c             	sub    $0xc,%esp
801053a7:	53                   	push   %ebx
801053a8:	e8 33 ce ff ff       	call   801021e0 <iunlockput>
  return ip;
801053ad:	83 c4 10             	add    $0x10,%esp
}
801053b0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801053b3:	89 f0                	mov    %esi,%eax
801053b5:	5b                   	pop    %ebx
801053b6:	5e                   	pop    %esi
801053b7:	5f                   	pop    %edi
801053b8:	5d                   	pop    %ebp
801053b9:	c3                   	ret    
801053ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iupdate(dp);
801053c0:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink++; // for ".."
801053c3:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
    iupdate(dp);
801053c8:	53                   	push   %ebx
801053c9:	e8 d2 ca ff ff       	call   80101ea0 <iupdate>
    if (dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
801053ce:	83 c4 0c             	add    $0xc,%esp
801053d1:	ff 76 04             	push   0x4(%esi)
801053d4:	68 bc 83 10 80       	push   $0x801083bc
801053d9:	56                   	push   %esi
801053da:	e8 d1 d3 ff ff       	call   801027b0 <dirlink>
801053df:	83 c4 10             	add    $0x10,%esp
801053e2:	85 c0                	test   %eax,%eax
801053e4:	78 18                	js     801053fe <create+0x15e>
801053e6:	83 ec 04             	sub    $0x4,%esp
801053e9:	ff 73 04             	push   0x4(%ebx)
801053ec:	68 bb 83 10 80       	push   $0x801083bb
801053f1:	56                   	push   %esi
801053f2:	e8 b9 d3 ff ff       	call   801027b0 <dirlink>
801053f7:	83 c4 10             	add    $0x10,%esp
801053fa:	85 c0                	test   %eax,%eax
801053fc:	79 92                	jns    80105390 <create+0xf0>
      panic("create dots");
801053fe:	83 ec 0c             	sub    $0xc,%esp
80105401:	68 af 83 10 80       	push   $0x801083af
80105406:	e8 95 af ff ff       	call   801003a0 <panic>
8010540b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010540f:	90                   	nop
}
80105410:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
80105413:	31 f6                	xor    %esi,%esi
}
80105415:	5b                   	pop    %ebx
80105416:	89 f0                	mov    %esi,%eax
80105418:	5e                   	pop    %esi
80105419:	5f                   	pop    %edi
8010541a:	5d                   	pop    %ebp
8010541b:	c3                   	ret    
    panic("create: dirlink");
8010541c:	83 ec 0c             	sub    $0xc,%esp
8010541f:	68 be 83 10 80       	push   $0x801083be
80105424:	e8 77 af ff ff       	call   801003a0 <panic>
    panic("create: ialloc");
80105429:	83 ec 0c             	sub    $0xc,%esp
8010542c:	68 a0 83 10 80       	push   $0x801083a0
80105431:	e8 6a af ff ff       	call   801003a0 <panic>
80105436:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010543d:	8d 76 00             	lea    0x0(%esi),%esi

80105440 <sys_dup>:
{
80105440:	55                   	push   %ebp
80105441:	89 e5                	mov    %esp,%ebp
80105443:	56                   	push   %esi
80105444:	53                   	push   %ebx
  if (argint(n, &fd) < 0)
80105445:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105448:	83 ec 18             	sub    $0x18,%esp
  if (argint(n, &fd) < 0)
8010544b:	50                   	push   %eax
8010544c:	6a 00                	push   $0x0
8010544e:	e8 9d fc ff ff       	call   801050f0 <argint>
80105453:	83 c4 10             	add    $0x10,%esp
80105456:	85 c0                	test   %eax,%eax
80105458:	78 36                	js     80105490 <sys_dup+0x50>
  if (fd < 0 || fd >= NOFILE || (f = myproc()->ofile[fd]) == 0)
8010545a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
8010545e:	77 30                	ja     80105490 <sys_dup+0x50>
80105460:	e8 db ec ff ff       	call   80104140 <myproc>
80105465:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105468:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
8010546c:	85 f6                	test   %esi,%esi
8010546e:	74 20                	je     80105490 <sys_dup+0x50>
  struct proc *curproc = myproc();
80105470:	e8 cb ec ff ff       	call   80104140 <myproc>
  for (fd = 0; fd < NOFILE; fd++)
80105475:	31 db                	xor    %ebx,%ebx
80105477:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010547e:	66 90                	xchg   %ax,%ax
    if (curproc->ofile[fd] == 0)
80105480:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105484:	85 d2                	test   %edx,%edx
80105486:	74 18                	je     801054a0 <sys_dup+0x60>
  for (fd = 0; fd < NOFILE; fd++)
80105488:	83 c3 01             	add    $0x1,%ebx
8010548b:	83 fb 10             	cmp    $0x10,%ebx
8010548e:	75 f0                	jne    80105480 <sys_dup+0x40>
}
80105490:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return -1;
80105493:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
80105498:	89 d8                	mov    %ebx,%eax
8010549a:	5b                   	pop    %ebx
8010549b:	5e                   	pop    %esi
8010549c:	5d                   	pop    %ebp
8010549d:	c3                   	ret    
8010549e:	66 90                	xchg   %ax,%ax
  filedup(f);
801054a0:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
801054a3:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)
  filedup(f);
801054a7:	56                   	push   %esi
801054a8:	e8 c3 c1 ff ff       	call   80101670 <filedup>
  return fd;
801054ad:	83 c4 10             	add    $0x10,%esp
}
801054b0:	8d 65 f8             	lea    -0x8(%ebp),%esp
801054b3:	89 d8                	mov    %ebx,%eax
801054b5:	5b                   	pop    %ebx
801054b6:	5e                   	pop    %esi
801054b7:	5d                   	pop    %ebp
801054b8:	c3                   	ret    
801054b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801054c0 <sys_read>:
{
801054c0:	55                   	push   %ebp
801054c1:	89 e5                	mov    %esp,%ebp
801054c3:	56                   	push   %esi
801054c4:	53                   	push   %ebx
  if (argint(n, &fd) < 0)
801054c5:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
801054c8:	83 ec 18             	sub    $0x18,%esp
  if (argint(n, &fd) < 0)
801054cb:	53                   	push   %ebx
801054cc:	6a 00                	push   $0x0
801054ce:	e8 1d fc ff ff       	call   801050f0 <argint>
801054d3:	83 c4 10             	add    $0x10,%esp
801054d6:	85 c0                	test   %eax,%eax
801054d8:	78 5e                	js     80105538 <sys_read+0x78>
  if (fd < 0 || fd >= NOFILE || (f = myproc()->ofile[fd]) == 0)
801054da:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
801054de:	77 58                	ja     80105538 <sys_read+0x78>
801054e0:	e8 5b ec ff ff       	call   80104140 <myproc>
801054e5:	8b 55 f4             	mov    -0xc(%ebp),%edx
801054e8:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
801054ec:	85 f6                	test   %esi,%esi
801054ee:	74 48                	je     80105538 <sys_read+0x78>
  if (argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
801054f0:	83 ec 08             	sub    $0x8,%esp
801054f3:	8d 45 f0             	lea    -0x10(%ebp),%eax
801054f6:	50                   	push   %eax
801054f7:	6a 02                	push   $0x2
801054f9:	e8 f2 fb ff ff       	call   801050f0 <argint>
801054fe:	83 c4 10             	add    $0x10,%esp
80105501:	85 c0                	test   %eax,%eax
80105503:	78 33                	js     80105538 <sys_read+0x78>
80105505:	83 ec 04             	sub    $0x4,%esp
80105508:	ff 75 f0             	push   -0x10(%ebp)
8010550b:	53                   	push   %ebx
8010550c:	6a 01                	push   $0x1
8010550e:	e8 2d fc ff ff       	call   80105140 <argptr>
80105513:	83 c4 10             	add    $0x10,%esp
80105516:	85 c0                	test   %eax,%eax
80105518:	78 1e                	js     80105538 <sys_read+0x78>
  return fileread(f, p, n);
8010551a:	83 ec 04             	sub    $0x4,%esp
8010551d:	ff 75 f0             	push   -0x10(%ebp)
80105520:	ff 75 f4             	push   -0xc(%ebp)
80105523:	56                   	push   %esi
80105524:	e8 c7 c2 ff ff       	call   801017f0 <fileread>
80105529:	83 c4 10             	add    $0x10,%esp
}
8010552c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010552f:	5b                   	pop    %ebx
80105530:	5e                   	pop    %esi
80105531:	5d                   	pop    %ebp
80105532:	c3                   	ret    
80105533:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105537:	90                   	nop
    return -1;
80105538:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010553d:	eb ed                	jmp    8010552c <sys_read+0x6c>
8010553f:	90                   	nop

80105540 <sys_write>:
{
80105540:	55                   	push   %ebp
80105541:	89 e5                	mov    %esp,%ebp
80105543:	56                   	push   %esi
80105544:	53                   	push   %ebx
  if (argint(n, &fd) < 0)
80105545:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
80105548:	83 ec 18             	sub    $0x18,%esp
  if (argint(n, &fd) < 0)
8010554b:	53                   	push   %ebx
8010554c:	6a 00                	push   $0x0
8010554e:	e8 9d fb ff ff       	call   801050f0 <argint>
80105553:	83 c4 10             	add    $0x10,%esp
80105556:	85 c0                	test   %eax,%eax
80105558:	78 5e                	js     801055b8 <sys_write+0x78>
  if (fd < 0 || fd >= NOFILE || (f = myproc()->ofile[fd]) == 0)
8010555a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
8010555e:	77 58                	ja     801055b8 <sys_write+0x78>
80105560:	e8 db eb ff ff       	call   80104140 <myproc>
80105565:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105568:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
8010556c:	85 f6                	test   %esi,%esi
8010556e:	74 48                	je     801055b8 <sys_write+0x78>
  if (argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105570:	83 ec 08             	sub    $0x8,%esp
80105573:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105576:	50                   	push   %eax
80105577:	6a 02                	push   $0x2
80105579:	e8 72 fb ff ff       	call   801050f0 <argint>
8010557e:	83 c4 10             	add    $0x10,%esp
80105581:	85 c0                	test   %eax,%eax
80105583:	78 33                	js     801055b8 <sys_write+0x78>
80105585:	83 ec 04             	sub    $0x4,%esp
80105588:	ff 75 f0             	push   -0x10(%ebp)
8010558b:	53                   	push   %ebx
8010558c:	6a 01                	push   $0x1
8010558e:	e8 ad fb ff ff       	call   80105140 <argptr>
80105593:	83 c4 10             	add    $0x10,%esp
80105596:	85 c0                	test   %eax,%eax
80105598:	78 1e                	js     801055b8 <sys_write+0x78>
  return filewrite(f, p, n);
8010559a:	83 ec 04             	sub    $0x4,%esp
8010559d:	ff 75 f0             	push   -0x10(%ebp)
801055a0:	ff 75 f4             	push   -0xc(%ebp)
801055a3:	56                   	push   %esi
801055a4:	e8 d7 c2 ff ff       	call   80101880 <filewrite>
801055a9:	83 c4 10             	add    $0x10,%esp
}
801055ac:	8d 65 f8             	lea    -0x8(%ebp),%esp
801055af:	5b                   	pop    %ebx
801055b0:	5e                   	pop    %esi
801055b1:	5d                   	pop    %ebp
801055b2:	c3                   	ret    
801055b3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801055b7:	90                   	nop
    return -1;
801055b8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801055bd:	eb ed                	jmp    801055ac <sys_write+0x6c>
801055bf:	90                   	nop

801055c0 <sys_close>:
{
801055c0:	55                   	push   %ebp
801055c1:	89 e5                	mov    %esp,%ebp
801055c3:	56                   	push   %esi
801055c4:	53                   	push   %ebx
  if (argint(n, &fd) < 0)
801055c5:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
801055c8:	83 ec 18             	sub    $0x18,%esp
  if (argint(n, &fd) < 0)
801055cb:	50                   	push   %eax
801055cc:	6a 00                	push   $0x0
801055ce:	e8 1d fb ff ff       	call   801050f0 <argint>
801055d3:	83 c4 10             	add    $0x10,%esp
801055d6:	85 c0                	test   %eax,%eax
801055d8:	78 3e                	js     80105618 <sys_close+0x58>
  if (fd < 0 || fd >= NOFILE || (f = myproc()->ofile[fd]) == 0)
801055da:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
801055de:	77 38                	ja     80105618 <sys_close+0x58>
801055e0:	e8 5b eb ff ff       	call   80104140 <myproc>
801055e5:	8b 55 f4             	mov    -0xc(%ebp),%edx
801055e8:	8d 5a 08             	lea    0x8(%edx),%ebx
801055eb:	8b 74 98 08          	mov    0x8(%eax,%ebx,4),%esi
801055ef:	85 f6                	test   %esi,%esi
801055f1:	74 25                	je     80105618 <sys_close+0x58>
  myproc()->ofile[fd] = 0;
801055f3:	e8 48 eb ff ff       	call   80104140 <myproc>
  fileclose(f);
801055f8:	83 ec 0c             	sub    $0xc,%esp
  myproc()->ofile[fd] = 0;
801055fb:	c7 44 98 08 00 00 00 	movl   $0x0,0x8(%eax,%ebx,4)
80105602:	00 
  fileclose(f);
80105603:	56                   	push   %esi
80105604:	e8 b7 c0 ff ff       	call   801016c0 <fileclose>
  return 0;
80105609:	83 c4 10             	add    $0x10,%esp
8010560c:	31 c0                	xor    %eax,%eax
}
8010560e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105611:	5b                   	pop    %ebx
80105612:	5e                   	pop    %esi
80105613:	5d                   	pop    %ebp
80105614:	c3                   	ret    
80105615:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80105618:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010561d:	eb ef                	jmp    8010560e <sys_close+0x4e>
8010561f:	90                   	nop

80105620 <sys_fstat>:
{
80105620:	55                   	push   %ebp
80105621:	89 e5                	mov    %esp,%ebp
80105623:	56                   	push   %esi
80105624:	53                   	push   %ebx
  if (argint(n, &fd) < 0)
80105625:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
80105628:	83 ec 18             	sub    $0x18,%esp
  if (argint(n, &fd) < 0)
8010562b:	53                   	push   %ebx
8010562c:	6a 00                	push   $0x0
8010562e:	e8 bd fa ff ff       	call   801050f0 <argint>
80105633:	83 c4 10             	add    $0x10,%esp
80105636:	85 c0                	test   %eax,%eax
80105638:	78 46                	js     80105680 <sys_fstat+0x60>
  if (fd < 0 || fd >= NOFILE || (f = myproc()->ofile[fd]) == 0)
8010563a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
8010563e:	77 40                	ja     80105680 <sys_fstat+0x60>
80105640:	e8 fb ea ff ff       	call   80104140 <myproc>
80105645:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105648:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
8010564c:	85 f6                	test   %esi,%esi
8010564e:	74 30                	je     80105680 <sys_fstat+0x60>
  if (argfd(0, 0, &f) < 0 || argptr(1, (void *)&st, sizeof(*st)) < 0)
80105650:	83 ec 04             	sub    $0x4,%esp
80105653:	6a 14                	push   $0x14
80105655:	53                   	push   %ebx
80105656:	6a 01                	push   $0x1
80105658:	e8 e3 fa ff ff       	call   80105140 <argptr>
8010565d:	83 c4 10             	add    $0x10,%esp
80105660:	85 c0                	test   %eax,%eax
80105662:	78 1c                	js     80105680 <sys_fstat+0x60>
  return filestat(f, st);
80105664:	83 ec 08             	sub    $0x8,%esp
80105667:	ff 75 f4             	push   -0xc(%ebp)
8010566a:	56                   	push   %esi
8010566b:	e8 30 c1 ff ff       	call   801017a0 <filestat>
80105670:	83 c4 10             	add    $0x10,%esp
}
80105673:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105676:	5b                   	pop    %ebx
80105677:	5e                   	pop    %esi
80105678:	5d                   	pop    %ebp
80105679:	c3                   	ret    
8010567a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80105680:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105685:	eb ec                	jmp    80105673 <sys_fstat+0x53>
80105687:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010568e:	66 90                	xchg   %ax,%ax

80105690 <sys_link>:
{
80105690:	55                   	push   %ebp
80105691:	89 e5                	mov    %esp,%ebp
80105693:	57                   	push   %edi
80105694:	56                   	push   %esi
  if (argstr(0, &old) < 0 || argstr(1, &new) < 0)
80105695:	8d 45 d4             	lea    -0x2c(%ebp),%eax
{
80105698:	53                   	push   %ebx
80105699:	83 ec 34             	sub    $0x34,%esp
  if (argstr(0, &old) < 0 || argstr(1, &new) < 0)
8010569c:	50                   	push   %eax
8010569d:	6a 00                	push   $0x0
8010569f:	e8 0c fb ff ff       	call   801051b0 <argstr>
801056a4:	83 c4 10             	add    $0x10,%esp
801056a7:	85 c0                	test   %eax,%eax
801056a9:	0f 88 fb 00 00 00    	js     801057aa <sys_link+0x11a>
801056af:	83 ec 08             	sub    $0x8,%esp
801056b2:	8d 45 d0             	lea    -0x30(%ebp),%eax
801056b5:	50                   	push   %eax
801056b6:	6a 01                	push   $0x1
801056b8:	e8 f3 fa ff ff       	call   801051b0 <argstr>
801056bd:	83 c4 10             	add    $0x10,%esp
801056c0:	85 c0                	test   %eax,%eax
801056c2:	0f 88 e2 00 00 00    	js     801057aa <sys_link+0x11a>
  begin_op();
801056c8:	e8 63 de ff ff       	call   80103530 <begin_op>
  if ((ip = namei(old)) == 0)
801056cd:	83 ec 0c             	sub    $0xc,%esp
801056d0:	ff 75 d4             	push   -0x2c(%ebp)
801056d3:	e8 98 d1 ff ff       	call   80102870 <namei>
801056d8:	83 c4 10             	add    $0x10,%esp
801056db:	89 c3                	mov    %eax,%ebx
801056dd:	85 c0                	test   %eax,%eax
801056df:	0f 84 e4 00 00 00    	je     801057c9 <sys_link+0x139>
  ilock(ip);
801056e5:	83 ec 0c             	sub    $0xc,%esp
801056e8:	50                   	push   %eax
801056e9:	e8 62 c8 ff ff       	call   80101f50 <ilock>
  if (ip->type == T_DIR)
801056ee:	83 c4 10             	add    $0x10,%esp
801056f1:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801056f6:	0f 84 b5 00 00 00    	je     801057b1 <sys_link+0x121>
  iupdate(ip);
801056fc:	83 ec 0c             	sub    $0xc,%esp
  ip->nlink++;
801056ff:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  if ((dp = nameiparent(new, name)) == 0)
80105704:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
80105707:	53                   	push   %ebx
80105708:	e8 93 c7 ff ff       	call   80101ea0 <iupdate>
  iunlock(ip);
8010570d:	89 1c 24             	mov    %ebx,(%esp)
80105710:	e8 1b c9 ff ff       	call   80102030 <iunlock>
  if ((dp = nameiparent(new, name)) == 0)
80105715:	58                   	pop    %eax
80105716:	5a                   	pop    %edx
80105717:	57                   	push   %edi
80105718:	ff 75 d0             	push   -0x30(%ebp)
8010571b:	e8 70 d1 ff ff       	call   80102890 <nameiparent>
80105720:	83 c4 10             	add    $0x10,%esp
80105723:	89 c6                	mov    %eax,%esi
80105725:	85 c0                	test   %eax,%eax
80105727:	74 5b                	je     80105784 <sys_link+0xf4>
  ilock(dp);
80105729:	83 ec 0c             	sub    $0xc,%esp
8010572c:	50                   	push   %eax
8010572d:	e8 1e c8 ff ff       	call   80101f50 <ilock>
  if (dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0)
80105732:	8b 03                	mov    (%ebx),%eax
80105734:	83 c4 10             	add    $0x10,%esp
80105737:	39 06                	cmp    %eax,(%esi)
80105739:	75 3d                	jne    80105778 <sys_link+0xe8>
8010573b:	83 ec 04             	sub    $0x4,%esp
8010573e:	ff 73 04             	push   0x4(%ebx)
80105741:	57                   	push   %edi
80105742:	56                   	push   %esi
80105743:	e8 68 d0 ff ff       	call   801027b0 <dirlink>
80105748:	83 c4 10             	add    $0x10,%esp
8010574b:	85 c0                	test   %eax,%eax
8010574d:	78 29                	js     80105778 <sys_link+0xe8>
  iunlockput(dp);
8010574f:	83 ec 0c             	sub    $0xc,%esp
80105752:	56                   	push   %esi
80105753:	e8 88 ca ff ff       	call   801021e0 <iunlockput>
  iput(ip);
80105758:	89 1c 24             	mov    %ebx,(%esp)
8010575b:	e8 20 c9 ff ff       	call   80102080 <iput>
  end_op();
80105760:	e8 3b de ff ff       	call   801035a0 <end_op>
  return 0;
80105765:	83 c4 10             	add    $0x10,%esp
80105768:	31 c0                	xor    %eax,%eax
}
8010576a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010576d:	5b                   	pop    %ebx
8010576e:	5e                   	pop    %esi
8010576f:	5f                   	pop    %edi
80105770:	5d                   	pop    %ebp
80105771:	c3                   	ret    
80105772:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(dp);
80105778:	83 ec 0c             	sub    $0xc,%esp
8010577b:	56                   	push   %esi
8010577c:	e8 5f ca ff ff       	call   801021e0 <iunlockput>
    goto bad;
80105781:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
80105784:	83 ec 0c             	sub    $0xc,%esp
80105787:	53                   	push   %ebx
80105788:	e8 c3 c7 ff ff       	call   80101f50 <ilock>
  ip->nlink--;
8010578d:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80105792:	89 1c 24             	mov    %ebx,(%esp)
80105795:	e8 06 c7 ff ff       	call   80101ea0 <iupdate>
  iunlockput(ip);
8010579a:	89 1c 24             	mov    %ebx,(%esp)
8010579d:	e8 3e ca ff ff       	call   801021e0 <iunlockput>
  end_op();
801057a2:	e8 f9 dd ff ff       	call   801035a0 <end_op>
  return -1;
801057a7:	83 c4 10             	add    $0x10,%esp
801057aa:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801057af:	eb b9                	jmp    8010576a <sys_link+0xda>
    iunlockput(ip);
801057b1:	83 ec 0c             	sub    $0xc,%esp
801057b4:	53                   	push   %ebx
801057b5:	e8 26 ca ff ff       	call   801021e0 <iunlockput>
    end_op();
801057ba:	e8 e1 dd ff ff       	call   801035a0 <end_op>
    return -1;
801057bf:	83 c4 10             	add    $0x10,%esp
801057c2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801057c7:	eb a1                	jmp    8010576a <sys_link+0xda>
    end_op();
801057c9:	e8 d2 dd ff ff       	call   801035a0 <end_op>
    return -1;
801057ce:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801057d3:	eb 95                	jmp    8010576a <sys_link+0xda>
801057d5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801057dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801057e0 <sys_unlink>:
{
801057e0:	55                   	push   %ebp
801057e1:	89 e5                	mov    %esp,%ebp
801057e3:	57                   	push   %edi
801057e4:	56                   	push   %esi
  if (argstr(0, &path) < 0)
801057e5:	8d 45 c0             	lea    -0x40(%ebp),%eax
{
801057e8:	53                   	push   %ebx
801057e9:	83 ec 54             	sub    $0x54,%esp
  if (argstr(0, &path) < 0)
801057ec:	50                   	push   %eax
801057ed:	6a 00                	push   $0x0
801057ef:	e8 bc f9 ff ff       	call   801051b0 <argstr>
801057f4:	83 c4 10             	add    $0x10,%esp
801057f7:	85 c0                	test   %eax,%eax
801057f9:	0f 88 7a 01 00 00    	js     80105979 <sys_unlink+0x199>
  begin_op();
801057ff:	e8 2c dd ff ff       	call   80103530 <begin_op>
  if ((dp = nameiparent(path, name)) == 0)
80105804:	8d 5d ca             	lea    -0x36(%ebp),%ebx
80105807:	83 ec 08             	sub    $0x8,%esp
8010580a:	53                   	push   %ebx
8010580b:	ff 75 c0             	push   -0x40(%ebp)
8010580e:	e8 7d d0 ff ff       	call   80102890 <nameiparent>
80105813:	83 c4 10             	add    $0x10,%esp
80105816:	89 45 b4             	mov    %eax,-0x4c(%ebp)
80105819:	85 c0                	test   %eax,%eax
8010581b:	0f 84 62 01 00 00    	je     80105983 <sys_unlink+0x1a3>
  ilock(dp);
80105821:	8b 7d b4             	mov    -0x4c(%ebp),%edi
80105824:	83 ec 0c             	sub    $0xc,%esp
80105827:	57                   	push   %edi
80105828:	e8 23 c7 ff ff       	call   80101f50 <ilock>
  if (namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
8010582d:	58                   	pop    %eax
8010582e:	5a                   	pop    %edx
8010582f:	68 bc 83 10 80       	push   $0x801083bc
80105834:	53                   	push   %ebx
80105835:	e8 56 cc ff ff       	call   80102490 <namecmp>
8010583a:	83 c4 10             	add    $0x10,%esp
8010583d:	85 c0                	test   %eax,%eax
8010583f:	0f 84 fb 00 00 00    	je     80105940 <sys_unlink+0x160>
80105845:	83 ec 08             	sub    $0x8,%esp
80105848:	68 bb 83 10 80       	push   $0x801083bb
8010584d:	53                   	push   %ebx
8010584e:	e8 3d cc ff ff       	call   80102490 <namecmp>
80105853:	83 c4 10             	add    $0x10,%esp
80105856:	85 c0                	test   %eax,%eax
80105858:	0f 84 e2 00 00 00    	je     80105940 <sys_unlink+0x160>
  if ((ip = dirlookup(dp, name, &off)) == 0)
8010585e:	83 ec 04             	sub    $0x4,%esp
80105861:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80105864:	50                   	push   %eax
80105865:	53                   	push   %ebx
80105866:	57                   	push   %edi
80105867:	e8 44 cc ff ff       	call   801024b0 <dirlookup>
8010586c:	83 c4 10             	add    $0x10,%esp
8010586f:	89 c3                	mov    %eax,%ebx
80105871:	85 c0                	test   %eax,%eax
80105873:	0f 84 c7 00 00 00    	je     80105940 <sys_unlink+0x160>
  ilock(ip);
80105879:	83 ec 0c             	sub    $0xc,%esp
8010587c:	50                   	push   %eax
8010587d:	e8 ce c6 ff ff       	call   80101f50 <ilock>
  if (ip->nlink < 1)
80105882:	83 c4 10             	add    $0x10,%esp
80105885:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
8010588a:	0f 8e 1c 01 00 00    	jle    801059ac <sys_unlink+0x1cc>
  if (ip->type == T_DIR && !isdirempty(ip))
80105890:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105895:	8d 7d d8             	lea    -0x28(%ebp),%edi
80105898:	74 66                	je     80105900 <sys_unlink+0x120>
  memset(&de, 0, sizeof(de));
8010589a:	83 ec 04             	sub    $0x4,%esp
8010589d:	6a 10                	push   $0x10
8010589f:	6a 00                	push   $0x0
801058a1:	57                   	push   %edi
801058a2:	e8 89 f5 ff ff       	call   80104e30 <memset>
  if (writei(dp, (char *)&de, off, sizeof(de)) != sizeof(de))
801058a7:	6a 10                	push   $0x10
801058a9:	ff 75 c4             	push   -0x3c(%ebp)
801058ac:	57                   	push   %edi
801058ad:	ff 75 b4             	push   -0x4c(%ebp)
801058b0:	e8 ab ca ff ff       	call   80102360 <writei>
801058b5:	83 c4 20             	add    $0x20,%esp
801058b8:	83 f8 10             	cmp    $0x10,%eax
801058bb:	0f 85 de 00 00 00    	jne    8010599f <sys_unlink+0x1bf>
  if (ip->type == T_DIR)
801058c1:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801058c6:	0f 84 94 00 00 00    	je     80105960 <sys_unlink+0x180>
  iunlockput(dp);
801058cc:	83 ec 0c             	sub    $0xc,%esp
801058cf:	ff 75 b4             	push   -0x4c(%ebp)
801058d2:	e8 09 c9 ff ff       	call   801021e0 <iunlockput>
  ip->nlink--;
801058d7:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
801058dc:	89 1c 24             	mov    %ebx,(%esp)
801058df:	e8 bc c5 ff ff       	call   80101ea0 <iupdate>
  iunlockput(ip);
801058e4:	89 1c 24             	mov    %ebx,(%esp)
801058e7:	e8 f4 c8 ff ff       	call   801021e0 <iunlockput>
  end_op();
801058ec:	e8 af dc ff ff       	call   801035a0 <end_op>
  return 0;
801058f1:	83 c4 10             	add    $0x10,%esp
801058f4:	31 c0                	xor    %eax,%eax
}
801058f6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801058f9:	5b                   	pop    %ebx
801058fa:	5e                   	pop    %esi
801058fb:	5f                   	pop    %edi
801058fc:	5d                   	pop    %ebp
801058fd:	c3                   	ret    
801058fe:	66 90                	xchg   %ax,%ax
  for (off = 2 * sizeof(de); off < dp->size; off += sizeof(de))
80105900:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
80105904:	76 94                	jbe    8010589a <sys_unlink+0xba>
80105906:	be 20 00 00 00       	mov    $0x20,%esi
8010590b:	eb 0b                	jmp    80105918 <sys_unlink+0x138>
8010590d:	8d 76 00             	lea    0x0(%esi),%esi
80105910:	83 c6 10             	add    $0x10,%esi
80105913:	3b 73 58             	cmp    0x58(%ebx),%esi
80105916:	73 82                	jae    8010589a <sys_unlink+0xba>
    if (readi(dp, (char *)&de, off, sizeof(de)) != sizeof(de))
80105918:	6a 10                	push   $0x10
8010591a:	56                   	push   %esi
8010591b:	57                   	push   %edi
8010591c:	53                   	push   %ebx
8010591d:	e8 3e c9 ff ff       	call   80102260 <readi>
80105922:	83 c4 10             	add    $0x10,%esp
80105925:	83 f8 10             	cmp    $0x10,%eax
80105928:	75 68                	jne    80105992 <sys_unlink+0x1b2>
    if (de.inum != 0)
8010592a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
8010592f:	74 df                	je     80105910 <sys_unlink+0x130>
    iunlockput(ip);
80105931:	83 ec 0c             	sub    $0xc,%esp
80105934:	53                   	push   %ebx
80105935:	e8 a6 c8 ff ff       	call   801021e0 <iunlockput>
    goto bad;
8010593a:	83 c4 10             	add    $0x10,%esp
8010593d:	8d 76 00             	lea    0x0(%esi),%esi
  iunlockput(dp);
80105940:	83 ec 0c             	sub    $0xc,%esp
80105943:	ff 75 b4             	push   -0x4c(%ebp)
80105946:	e8 95 c8 ff ff       	call   801021e0 <iunlockput>
  end_op();
8010594b:	e8 50 dc ff ff       	call   801035a0 <end_op>
  return -1;
80105950:	83 c4 10             	add    $0x10,%esp
80105953:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105958:	eb 9c                	jmp    801058f6 <sys_unlink+0x116>
8010595a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    dp->nlink--;
80105960:	8b 45 b4             	mov    -0x4c(%ebp),%eax
    iupdate(dp);
80105963:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink--;
80105966:	66 83 68 56 01       	subw   $0x1,0x56(%eax)
    iupdate(dp);
8010596b:	50                   	push   %eax
8010596c:	e8 2f c5 ff ff       	call   80101ea0 <iupdate>
80105971:	83 c4 10             	add    $0x10,%esp
80105974:	e9 53 ff ff ff       	jmp    801058cc <sys_unlink+0xec>
    return -1;
80105979:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010597e:	e9 73 ff ff ff       	jmp    801058f6 <sys_unlink+0x116>
    end_op();
80105983:	e8 18 dc ff ff       	call   801035a0 <end_op>
    return -1;
80105988:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010598d:	e9 64 ff ff ff       	jmp    801058f6 <sys_unlink+0x116>
      panic("isdirempty: readi");
80105992:	83 ec 0c             	sub    $0xc,%esp
80105995:	68 e0 83 10 80       	push   $0x801083e0
8010599a:	e8 01 aa ff ff       	call   801003a0 <panic>
    panic("unlink: writei");
8010599f:	83 ec 0c             	sub    $0xc,%esp
801059a2:	68 f2 83 10 80       	push   $0x801083f2
801059a7:	e8 f4 a9 ff ff       	call   801003a0 <panic>
    panic("unlink: nlink < 1");
801059ac:	83 ec 0c             	sub    $0xc,%esp
801059af:	68 ce 83 10 80       	push   $0x801083ce
801059b4:	e8 e7 a9 ff ff       	call   801003a0 <panic>
801059b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801059c0 <sys_copy_file>:

// copy src to dest
// return 0 on success and -1 on error
int sys_copy_file(void)
{
801059c0:	55                   	push   %ebp
801059c1:	89 e5                	mov    %esp,%ebp
801059c3:	57                   	push   %edi
801059c4:	56                   	push   %esi
  char *src, *dest;
  struct file *fsrc, *fdest;
  struct inode *isrc, *idest;

  if (argstr(0, &src) < 0 || argstr(1, &dest) < 0)
801059c5:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
801059c8:	53                   	push   %ebx
801059c9:	83 ec 34             	sub    $0x34,%esp
  if (argstr(0, &src) < 0 || argstr(1, &dest) < 0)
801059cc:	50                   	push   %eax
801059cd:	6a 00                	push   $0x0
801059cf:	e8 dc f7 ff ff       	call   801051b0 <argstr>
801059d4:	83 c4 10             	add    $0x10,%esp
801059d7:	85 c0                	test   %eax,%eax
801059d9:	0f 88 43 01 00 00    	js     80105b22 <sys_copy_file+0x162>
801059df:	83 ec 08             	sub    $0x8,%esp
801059e2:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801059e5:	50                   	push   %eax
801059e6:	6a 01                	push   $0x1
801059e8:	e8 c3 f7 ff ff       	call   801051b0 <argstr>
801059ed:	83 c4 10             	add    $0x10,%esp
801059f0:	85 c0                	test   %eax,%eax
801059f2:	0f 88 2a 01 00 00    	js     80105b22 <sys_copy_file+0x162>
    return -1;

  begin_op();
801059f8:	e8 33 db ff ff       	call   80103530 <begin_op>

  if ((isrc = namei(src)) == 0) // check src exist
801059fd:	83 ec 0c             	sub    $0xc,%esp
80105a00:	ff 75 e0             	push   -0x20(%ebp)
80105a03:	e8 68 ce ff ff       	call   80102870 <namei>
80105a08:	83 c4 10             	add    $0x10,%esp
80105a0b:	89 c3                	mov    %eax,%ebx
80105a0d:	85 c0                	test   %eax,%eax
80105a0f:	0f 84 dc 01 00 00    	je     80105bf1 <sys_copy_file+0x231>
  {
    cprintf("src not exist.\n");
    end_op();
    return -1;
  }
  if ((idest = namei(dest)) != 0) // check dest not exist
80105a15:	83 ec 0c             	sub    $0xc,%esp
80105a18:	ff 75 e4             	push   -0x1c(%ebp)
80105a1b:	e8 50 ce ff ff       	call   80102870 <namei>
80105a20:	83 c4 10             	add    $0x10,%esp
80105a23:	85 c0                	test   %eax,%eax
80105a25:	0f 85 39 01 00 00    	jne    80105b64 <sys_copy_file+0x1a4>
    cprintf("dest exist.\n");
    end_op();
    return -1;
  }

  ilock(isrc); // lock src
80105a2b:	83 ec 0c             	sub    $0xc,%esp
80105a2e:	53                   	push   %ebx
80105a2f:	e8 1c c5 ff ff       	call   80101f50 <ilock>

  if (isrc->type == T_DIR) // check src is not dir
80105a34:	83 c4 10             	add    $0x10,%esp
80105a37:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105a3c:	0f 84 3e 01 00 00    	je     80105b80 <sys_copy_file+0x1c0>
    iunlockput(isrc);
    end_op();
    return -1;
  }

  if ((fsrc = filealloc()) == 0) // aloc src file
80105a42:	e8 b9 bb ff ff       	call   80101600 <filealloc>
80105a47:	89 c6                	mov    %eax,%esi
80105a49:	85 c0                	test   %eax,%eax
80105a4b:	0f 84 53 01 00 00    	je     80105ba4 <sys_copy_file+0x1e4>
    iunlockput(isrc);
    end_op();
    return -1;
  }

  iunlock(isrc); // unlock src node
80105a51:	83 ec 0c             	sub    $0xc,%esp
80105a54:	53                   	push   %ebx
80105a55:	e8 d6 c5 ff ff       	call   80102030 <iunlock>

  idest = create(dest, T_FILE, 0, 0); // create dest node
80105a5a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105a5d:	31 c9                	xor    %ecx,%ecx
80105a5f:	ba 02 00 00 00       	mov    $0x2,%edx
80105a64:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105a6b:	e8 30 f8 ff ff       	call   801052a0 <create>
  if (idest == 0)
80105a70:	83 c4 10             	add    $0x10,%esp
  idest = create(dest, T_FILE, 0, 0); // create dest node
80105a73:	89 c3                	mov    %eax,%ebx
  if (idest == 0)
80105a75:	85 c0                	test   %eax,%eax
80105a77:	0f 84 36 01 00 00    	je     80105bb3 <sys_copy_file+0x1f3>
    fileclose(fsrc);
    end_op();
    return -1;
  }

  if ((fdest = filealloc()) == 0) // aloc dest file
80105a7d:	e8 7e bb ff ff       	call   80101600 <filealloc>
80105a82:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80105a85:	85 c0                	test   %eax,%eax
80105a87:	0f 84 4d 01 00 00    	je     80105bda <sys_copy_file+0x21a>
    iunlockput(idest);
    end_op();
    return -1;
  }

  iunlock(idest); // unlock dest node
80105a8d:	83 ec 0c             	sub    $0xc,%esp
80105a90:	53                   	push   %ebx
80105a91:	e8 9a c5 ff ff       	call   80102030 <iunlock>

  int size = 1024, n, m;
  char buff[size];
80105a96:	83 c4 10             	add    $0x10,%esp
80105a99:	89 e0                	mov    %esp,%eax
80105a9b:	39 c4                	cmp    %eax,%esp
80105a9d:	74 12                	je     80105ab1 <sys_copy_file+0xf1>
80105a9f:	81 ec 00 10 00 00    	sub    $0x1000,%esp
80105aa5:	83 8c 24 fc 0f 00 00 	orl    $0x0,0xffc(%esp)
80105aac:	00 
80105aad:	39 c4                	cmp    %eax,%esp
80105aaf:	75 ee                	jne    80105a9f <sys_copy_file+0xdf>
80105ab1:	81 ec 00 04 00 00    	sub    $0x400,%esp
80105ab7:	83 8c 24 fc 03 00 00 	orl    $0x0,0x3fc(%esp)
80105abe:	00 
80105abf:	89 e3                	mov    %esp,%ebx
80105ac1:	eb 21                	jmp    80105ae4 <sys_copy_file+0x124>
80105ac3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105ac7:	90                   	nop
      fileclose(fsrc);
      fileclose(fdest);
      end_op();
      return -1;
    }
    m = filewrite(fdest, buff, n);
80105ac8:	83 ec 04             	sub    $0x4,%esp
80105acb:	50                   	push   %eax
80105acc:	53                   	push   %ebx
80105acd:	ff 75 d4             	push   -0x2c(%ebp)
80105ad0:	e8 ab bd ff ff       	call   80101880 <filewrite>
    if (m < n)
80105ad5:	83 c4 10             	add    $0x10,%esp
80105ad8:	39 c7                	cmp    %eax,%edi
80105ada:	7f 54                	jg     80105b30 <sys_copy_file+0x170>
      fileclose(fsrc);
      fileclose(fdest);
      end_op();
      return -1;
    }
  } while (n == size);
80105adc:	81 ff 00 04 00 00    	cmp    $0x400,%edi
80105ae2:	75 5c                	jne    80105b40 <sys_copy_file+0x180>
    n = fileread(fsrc, buff, sizeof(char) * size);
80105ae4:	83 ec 04             	sub    $0x4,%esp
80105ae7:	68 00 04 00 00       	push   $0x400
80105aec:	53                   	push   %ebx
80105aed:	56                   	push   %esi
80105aee:	e8 fd bc ff ff       	call   801017f0 <fileread>
    if (n < 0)
80105af3:	83 c4 10             	add    $0x10,%esp
    n = fileread(fsrc, buff, sizeof(char) * size);
80105af6:	89 c7                	mov    %eax,%edi
    if (n < 0)
80105af8:	85 c0                	test   %eax,%eax
80105afa:	79 cc                	jns    80105ac8 <sys_copy_file+0x108>
      cprintf("read fail.\n");
80105afc:	83 ec 0c             	sub    $0xc,%esp
80105aff:	68 5f 84 10 80       	push   $0x8010845f
      cprintf("write fail.\n");
80105b04:	e8 47 ac ff ff       	call   80100750 <cprintf>
      fileclose(fsrc);
80105b09:	89 34 24             	mov    %esi,(%esp)
80105b0c:	e8 af bb ff ff       	call   801016c0 <fileclose>
      fileclose(fdest);
80105b11:	5a                   	pop    %edx
80105b12:	ff 75 d4             	push   -0x2c(%ebp)
80105b15:	e8 a6 bb ff ff       	call   801016c0 <fileclose>
      end_op();
80105b1a:	e8 81 da ff ff       	call   801035a0 <end_op>
      return -1;
80105b1f:	83 c4 10             	add    $0x10,%esp
80105b22:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  fileclose(fsrc);
  fileclose(fdest);
  end_op();

  return 0;
}
80105b27:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105b2a:	5b                   	pop    %ebx
80105b2b:	5e                   	pop    %esi
80105b2c:	5f                   	pop    %edi
80105b2d:	5d                   	pop    %ebp
80105b2e:	c3                   	ret    
80105b2f:	90                   	nop
      cprintf("write fail.\n");
80105b30:	83 ec 0c             	sub    $0xc,%esp
80105b33:	68 6b 84 10 80       	push   $0x8010846b
80105b38:	eb ca                	jmp    80105b04 <sys_copy_file+0x144>
80105b3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  fileclose(fsrc);
80105b40:	83 ec 0c             	sub    $0xc,%esp
80105b43:	56                   	push   %esi
80105b44:	e8 77 bb ff ff       	call   801016c0 <fileclose>
  fileclose(fdest);
80105b49:	58                   	pop    %eax
80105b4a:	ff 75 d4             	push   -0x2c(%ebp)
80105b4d:	e8 6e bb ff ff       	call   801016c0 <fileclose>
  end_op();
80105b52:	e8 49 da ff ff       	call   801035a0 <end_op>
  return 0;
80105b57:	83 c4 10             	add    $0x10,%esp
}
80105b5a:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80105b5d:	31 c0                	xor    %eax,%eax
}
80105b5f:	5b                   	pop    %ebx
80105b60:	5e                   	pop    %esi
80105b61:	5f                   	pop    %edi
80105b62:	5d                   	pop    %ebp
80105b63:	c3                   	ret    
    cprintf("dest exist.\n");
80105b64:	83 ec 0c             	sub    $0xc,%esp
80105b67:	68 11 84 10 80       	push   $0x80108411
80105b6c:	e8 df ab ff ff       	call   80100750 <cprintf>
    end_op();
80105b71:	e8 2a da ff ff       	call   801035a0 <end_op>
    return -1;
80105b76:	83 c4 10             	add    $0x10,%esp
80105b79:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105b7e:	eb a7                	jmp    80105b27 <sys_copy_file+0x167>
    cprintf("src is dir.\n");
80105b80:	83 ec 0c             	sub    $0xc,%esp
80105b83:	68 1e 84 10 80       	push   $0x8010841e
80105b88:	e8 c3 ab ff ff       	call   80100750 <cprintf>
    iunlockput(idest);
80105b8d:	89 1c 24             	mov    %ebx,(%esp)
80105b90:	e8 4b c6 ff ff       	call   801021e0 <iunlockput>
    end_op();
80105b95:	e8 06 da ff ff       	call   801035a0 <end_op>
    return -1;
80105b9a:	83 c4 10             	add    $0x10,%esp
80105b9d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105ba2:	eb 83                	jmp    80105b27 <sys_copy_file+0x167>
    cprintf("src aloc fail.\n");
80105ba4:	83 ec 0c             	sub    $0xc,%esp
80105ba7:	68 2b 84 10 80       	push   $0x8010842b
80105bac:	e8 9f ab ff ff       	call   80100750 <cprintf>
    iunlockput(isrc);
80105bb1:	eb da                	jmp    80105b8d <sys_copy_file+0x1cd>
    cprintf("create dest fail.\n");
80105bb3:	83 ec 0c             	sub    $0xc,%esp
80105bb6:	68 3b 84 10 80       	push   $0x8010843b
80105bbb:	e8 90 ab ff ff       	call   80100750 <cprintf>
    fileclose(fsrc);
80105bc0:	89 34 24             	mov    %esi,(%esp)
80105bc3:	e8 f8 ba ff ff       	call   801016c0 <fileclose>
    end_op();
80105bc8:	e8 d3 d9 ff ff       	call   801035a0 <end_op>
    return -1;
80105bcd:	83 c4 10             	add    $0x10,%esp
80105bd0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105bd5:	e9 4d ff ff ff       	jmp    80105b27 <sys_copy_file+0x167>
    cprintf("aloc dest fail.\n");
80105bda:	83 ec 0c             	sub    $0xc,%esp
80105bdd:	68 4e 84 10 80       	push   $0x8010844e
80105be2:	e8 69 ab ff ff       	call   80100750 <cprintf>
    fileclose(fsrc);
80105be7:	89 34 24             	mov    %esi,(%esp)
80105bea:	e8 d1 ba ff ff       	call   801016c0 <fileclose>
80105bef:	eb 9c                	jmp    80105b8d <sys_copy_file+0x1cd>
    cprintf("src not exist.\n");
80105bf1:	83 ec 0c             	sub    $0xc,%esp
80105bf4:	68 01 84 10 80       	push   $0x80108401
80105bf9:	e8 52 ab ff ff       	call   80100750 <cprintf>
    end_op();
80105bfe:	e8 9d d9 ff ff       	call   801035a0 <end_op>
    return -1;
80105c03:	83 c4 10             	add    $0x10,%esp
80105c06:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105c0b:	e9 17 ff ff ff       	jmp    80105b27 <sys_copy_file+0x167>

80105c10 <sys_open>:

int sys_open(void)
{
80105c10:	55                   	push   %ebp
80105c11:	89 e5                	mov    %esp,%ebp
80105c13:	57                   	push   %edi
80105c14:	56                   	push   %esi
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if (argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105c15:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
80105c18:	53                   	push   %ebx
80105c19:	83 ec 24             	sub    $0x24,%esp
  if (argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105c1c:	50                   	push   %eax
80105c1d:	6a 00                	push   $0x0
80105c1f:	e8 8c f5 ff ff       	call   801051b0 <argstr>
80105c24:	83 c4 10             	add    $0x10,%esp
80105c27:	85 c0                	test   %eax,%eax
80105c29:	0f 88 8e 00 00 00    	js     80105cbd <sys_open+0xad>
80105c2f:	83 ec 08             	sub    $0x8,%esp
80105c32:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105c35:	50                   	push   %eax
80105c36:	6a 01                	push   $0x1
80105c38:	e8 b3 f4 ff ff       	call   801050f0 <argint>
80105c3d:	83 c4 10             	add    $0x10,%esp
80105c40:	85 c0                	test   %eax,%eax
80105c42:	78 79                	js     80105cbd <sys_open+0xad>
    return -1;

  begin_op();
80105c44:	e8 e7 d8 ff ff       	call   80103530 <begin_op>

  if (omode & O_CREATE)
80105c49:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
80105c4d:	75 79                	jne    80105cc8 <sys_open+0xb8>
      return -1;
    }
  }
  else
  {
    if ((ip = namei(path)) == 0)
80105c4f:	83 ec 0c             	sub    $0xc,%esp
80105c52:	ff 75 e0             	push   -0x20(%ebp)
80105c55:	e8 16 cc ff ff       	call   80102870 <namei>
80105c5a:	83 c4 10             	add    $0x10,%esp
80105c5d:	89 c6                	mov    %eax,%esi
80105c5f:	85 c0                	test   %eax,%eax
80105c61:	0f 84 7e 00 00 00    	je     80105ce5 <sys_open+0xd5>
    {
      end_op();
      return -1;
    }
    ilock(ip);
80105c67:	83 ec 0c             	sub    $0xc,%esp
80105c6a:	50                   	push   %eax
80105c6b:	e8 e0 c2 ff ff       	call   80101f50 <ilock>
    if (ip->type == T_DIR && omode != O_RDONLY)
80105c70:	83 c4 10             	add    $0x10,%esp
80105c73:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80105c78:	0f 84 c2 00 00 00    	je     80105d40 <sys_open+0x130>
      end_op();
      return -1;
    }
  }

  if ((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0)
80105c7e:	e8 7d b9 ff ff       	call   80101600 <filealloc>
80105c83:	89 c7                	mov    %eax,%edi
80105c85:	85 c0                	test   %eax,%eax
80105c87:	74 23                	je     80105cac <sys_open+0x9c>
  struct proc *curproc = myproc();
80105c89:	e8 b2 e4 ff ff       	call   80104140 <myproc>
  for (fd = 0; fd < NOFILE; fd++)
80105c8e:	31 db                	xor    %ebx,%ebx
    if (curproc->ofile[fd] == 0)
80105c90:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105c94:	85 d2                	test   %edx,%edx
80105c96:	74 60                	je     80105cf8 <sys_open+0xe8>
  for (fd = 0; fd < NOFILE; fd++)
80105c98:	83 c3 01             	add    $0x1,%ebx
80105c9b:	83 fb 10             	cmp    $0x10,%ebx
80105c9e:	75 f0                	jne    80105c90 <sys_open+0x80>
  {
    if (f)
      fileclose(f);
80105ca0:	83 ec 0c             	sub    $0xc,%esp
80105ca3:	57                   	push   %edi
80105ca4:	e8 17 ba ff ff       	call   801016c0 <fileclose>
80105ca9:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
80105cac:	83 ec 0c             	sub    $0xc,%esp
80105caf:	56                   	push   %esi
80105cb0:	e8 2b c5 ff ff       	call   801021e0 <iunlockput>
    end_op();
80105cb5:	e8 e6 d8 ff ff       	call   801035a0 <end_op>
    return -1;
80105cba:	83 c4 10             	add    $0x10,%esp
80105cbd:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105cc2:	eb 6d                	jmp    80105d31 <sys_open+0x121>
80105cc4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ip = create(path, T_FILE, 0, 0);
80105cc8:	83 ec 0c             	sub    $0xc,%esp
80105ccb:	8b 45 e0             	mov    -0x20(%ebp),%eax
80105cce:	31 c9                	xor    %ecx,%ecx
80105cd0:	ba 02 00 00 00       	mov    $0x2,%edx
80105cd5:	6a 00                	push   $0x0
80105cd7:	e8 c4 f5 ff ff       	call   801052a0 <create>
    if (ip == 0)
80105cdc:	83 c4 10             	add    $0x10,%esp
    ip = create(path, T_FILE, 0, 0);
80105cdf:	89 c6                	mov    %eax,%esi
    if (ip == 0)
80105ce1:	85 c0                	test   %eax,%eax
80105ce3:	75 99                	jne    80105c7e <sys_open+0x6e>
      end_op();
80105ce5:	e8 b6 d8 ff ff       	call   801035a0 <end_op>
      return -1;
80105cea:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105cef:	eb 40                	jmp    80105d31 <sys_open+0x121>
80105cf1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  }
  iunlock(ip);
80105cf8:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
80105cfb:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
  iunlock(ip);
80105cff:	56                   	push   %esi
80105d00:	e8 2b c3 ff ff       	call   80102030 <iunlock>
  end_op();
80105d05:	e8 96 d8 ff ff       	call   801035a0 <end_op>

  f->type = FD_INODE;
80105d0a:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
80105d10:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105d13:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
80105d16:	89 77 10             	mov    %esi,0x10(%edi)
  f->readable = !(omode & O_WRONLY);
80105d19:	89 d0                	mov    %edx,%eax
  f->off = 0;
80105d1b:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
80105d22:	f7 d0                	not    %eax
80105d24:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105d27:	83 e2 03             	and    $0x3,%edx
  f->readable = !(omode & O_WRONLY);
80105d2a:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105d2d:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
}
80105d31:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105d34:	89 d8                	mov    %ebx,%eax
80105d36:	5b                   	pop    %ebx
80105d37:	5e                   	pop    %esi
80105d38:	5f                   	pop    %edi
80105d39:	5d                   	pop    %ebp
80105d3a:	c3                   	ret    
80105d3b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105d3f:	90                   	nop
    if (ip->type == T_DIR && omode != O_RDONLY)
80105d40:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80105d43:	85 c9                	test   %ecx,%ecx
80105d45:	0f 84 33 ff ff ff    	je     80105c7e <sys_open+0x6e>
80105d4b:	e9 5c ff ff ff       	jmp    80105cac <sys_open+0x9c>

80105d50 <sys_mkdir>:

int sys_mkdir(void)
{
80105d50:	55                   	push   %ebp
80105d51:	89 e5                	mov    %esp,%ebp
80105d53:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
80105d56:	e8 d5 d7 ff ff       	call   80103530 <begin_op>
  if (argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0)
80105d5b:	83 ec 08             	sub    $0x8,%esp
80105d5e:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105d61:	50                   	push   %eax
80105d62:	6a 00                	push   $0x0
80105d64:	e8 47 f4 ff ff       	call   801051b0 <argstr>
80105d69:	83 c4 10             	add    $0x10,%esp
80105d6c:	85 c0                	test   %eax,%eax
80105d6e:	78 30                	js     80105da0 <sys_mkdir+0x50>
80105d70:	83 ec 0c             	sub    $0xc,%esp
80105d73:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105d76:	31 c9                	xor    %ecx,%ecx
80105d78:	ba 01 00 00 00       	mov    $0x1,%edx
80105d7d:	6a 00                	push   $0x0
80105d7f:	e8 1c f5 ff ff       	call   801052a0 <create>
80105d84:	83 c4 10             	add    $0x10,%esp
80105d87:	85 c0                	test   %eax,%eax
80105d89:	74 15                	je     80105da0 <sys_mkdir+0x50>
  {
    end_op();
    return -1;
  }
  iunlockput(ip);
80105d8b:	83 ec 0c             	sub    $0xc,%esp
80105d8e:	50                   	push   %eax
80105d8f:	e8 4c c4 ff ff       	call   801021e0 <iunlockput>
  end_op();
80105d94:	e8 07 d8 ff ff       	call   801035a0 <end_op>
  return 0;
80105d99:	83 c4 10             	add    $0x10,%esp
80105d9c:	31 c0                	xor    %eax,%eax
}
80105d9e:	c9                   	leave  
80105d9f:	c3                   	ret    
    end_op();
80105da0:	e8 fb d7 ff ff       	call   801035a0 <end_op>
    return -1;
80105da5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105daa:	c9                   	leave  
80105dab:	c3                   	ret    
80105dac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105db0 <sys_mknod>:

int sys_mknod(void)
{
80105db0:	55                   	push   %ebp
80105db1:	89 e5                	mov    %esp,%ebp
80105db3:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80105db6:	e8 75 d7 ff ff       	call   80103530 <begin_op>
  if ((argstr(0, &path)) < 0 ||
80105dbb:	83 ec 08             	sub    $0x8,%esp
80105dbe:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105dc1:	50                   	push   %eax
80105dc2:	6a 00                	push   $0x0
80105dc4:	e8 e7 f3 ff ff       	call   801051b0 <argstr>
80105dc9:	83 c4 10             	add    $0x10,%esp
80105dcc:	85 c0                	test   %eax,%eax
80105dce:	78 60                	js     80105e30 <sys_mknod+0x80>
      argint(1, &major) < 0 ||
80105dd0:	83 ec 08             	sub    $0x8,%esp
80105dd3:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105dd6:	50                   	push   %eax
80105dd7:	6a 01                	push   $0x1
80105dd9:	e8 12 f3 ff ff       	call   801050f0 <argint>
  if ((argstr(0, &path)) < 0 ||
80105dde:	83 c4 10             	add    $0x10,%esp
80105de1:	85 c0                	test   %eax,%eax
80105de3:	78 4b                	js     80105e30 <sys_mknod+0x80>
      argint(2, &minor) < 0 ||
80105de5:	83 ec 08             	sub    $0x8,%esp
80105de8:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105deb:	50                   	push   %eax
80105dec:	6a 02                	push   $0x2
80105dee:	e8 fd f2 ff ff       	call   801050f0 <argint>
      argint(1, &major) < 0 ||
80105df3:	83 c4 10             	add    $0x10,%esp
80105df6:	85 c0                	test   %eax,%eax
80105df8:	78 36                	js     80105e30 <sys_mknod+0x80>
      (ip = create(path, T_DEV, major, minor)) == 0)
80105dfa:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
80105dfe:	83 ec 0c             	sub    $0xc,%esp
80105e01:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
80105e05:	ba 03 00 00 00       	mov    $0x3,%edx
80105e0a:	50                   	push   %eax
80105e0b:	8b 45 ec             	mov    -0x14(%ebp),%eax
80105e0e:	e8 8d f4 ff ff       	call   801052a0 <create>
      argint(2, &minor) < 0 ||
80105e13:	83 c4 10             	add    $0x10,%esp
80105e16:	85 c0                	test   %eax,%eax
80105e18:	74 16                	je     80105e30 <sys_mknod+0x80>
  {
    end_op();
    return -1;
  }
  iunlockput(ip);
80105e1a:	83 ec 0c             	sub    $0xc,%esp
80105e1d:	50                   	push   %eax
80105e1e:	e8 bd c3 ff ff       	call   801021e0 <iunlockput>
  end_op();
80105e23:	e8 78 d7 ff ff       	call   801035a0 <end_op>
  return 0;
80105e28:	83 c4 10             	add    $0x10,%esp
80105e2b:	31 c0                	xor    %eax,%eax
}
80105e2d:	c9                   	leave  
80105e2e:	c3                   	ret    
80105e2f:	90                   	nop
    end_op();
80105e30:	e8 6b d7 ff ff       	call   801035a0 <end_op>
    return -1;
80105e35:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105e3a:	c9                   	leave  
80105e3b:	c3                   	ret    
80105e3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105e40 <sys_chdir>:

int sys_chdir(void)
{
80105e40:	55                   	push   %ebp
80105e41:	89 e5                	mov    %esp,%ebp
80105e43:	56                   	push   %esi
80105e44:	53                   	push   %ebx
80105e45:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
80105e48:	e8 f3 e2 ff ff       	call   80104140 <myproc>
80105e4d:	89 c6                	mov    %eax,%esi

  begin_op();
80105e4f:	e8 dc d6 ff ff       	call   80103530 <begin_op>
  if (argstr(0, &path) < 0 || (ip = namei(path)) == 0)
80105e54:	83 ec 08             	sub    $0x8,%esp
80105e57:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105e5a:	50                   	push   %eax
80105e5b:	6a 00                	push   $0x0
80105e5d:	e8 4e f3 ff ff       	call   801051b0 <argstr>
80105e62:	83 c4 10             	add    $0x10,%esp
80105e65:	85 c0                	test   %eax,%eax
80105e67:	78 77                	js     80105ee0 <sys_chdir+0xa0>
80105e69:	83 ec 0c             	sub    $0xc,%esp
80105e6c:	ff 75 f4             	push   -0xc(%ebp)
80105e6f:	e8 fc c9 ff ff       	call   80102870 <namei>
80105e74:	83 c4 10             	add    $0x10,%esp
80105e77:	89 c3                	mov    %eax,%ebx
80105e79:	85 c0                	test   %eax,%eax
80105e7b:	74 63                	je     80105ee0 <sys_chdir+0xa0>
  {
    end_op();
    return -1;
  }
  ilock(ip);
80105e7d:	83 ec 0c             	sub    $0xc,%esp
80105e80:	50                   	push   %eax
80105e81:	e8 ca c0 ff ff       	call   80101f50 <ilock>
  if (ip->type != T_DIR)
80105e86:	83 c4 10             	add    $0x10,%esp
80105e89:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105e8e:	75 30                	jne    80105ec0 <sys_chdir+0x80>
  {
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105e90:	83 ec 0c             	sub    $0xc,%esp
80105e93:	53                   	push   %ebx
80105e94:	e8 97 c1 ff ff       	call   80102030 <iunlock>
  iput(curproc->cwd);
80105e99:	58                   	pop    %eax
80105e9a:	ff 76 68             	push   0x68(%esi)
80105e9d:	e8 de c1 ff ff       	call   80102080 <iput>
  end_op();
80105ea2:	e8 f9 d6 ff ff       	call   801035a0 <end_op>
  curproc->cwd = ip;
80105ea7:	89 5e 68             	mov    %ebx,0x68(%esi)
  return 0;
80105eaa:	83 c4 10             	add    $0x10,%esp
80105ead:	31 c0                	xor    %eax,%eax
}
80105eaf:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105eb2:	5b                   	pop    %ebx
80105eb3:	5e                   	pop    %esi
80105eb4:	5d                   	pop    %ebp
80105eb5:	c3                   	ret    
80105eb6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105ebd:	8d 76 00             	lea    0x0(%esi),%esi
    iunlockput(ip);
80105ec0:	83 ec 0c             	sub    $0xc,%esp
80105ec3:	53                   	push   %ebx
80105ec4:	e8 17 c3 ff ff       	call   801021e0 <iunlockput>
    end_op();
80105ec9:	e8 d2 d6 ff ff       	call   801035a0 <end_op>
    return -1;
80105ece:	83 c4 10             	add    $0x10,%esp
80105ed1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105ed6:	eb d7                	jmp    80105eaf <sys_chdir+0x6f>
80105ed8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105edf:	90                   	nop
    end_op();
80105ee0:	e8 bb d6 ff ff       	call   801035a0 <end_op>
    return -1;
80105ee5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105eea:	eb c3                	jmp    80105eaf <sys_chdir+0x6f>
80105eec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105ef0 <sys_exec>:

int sys_exec(void)
{
80105ef0:	55                   	push   %ebp
80105ef1:	89 e5                	mov    %esp,%ebp
80105ef3:	57                   	push   %edi
80105ef4:	56                   	push   %esi
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if (argstr(0, &path) < 0 || argint(1, (int *)&uargv) < 0)
80105ef5:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
{
80105efb:	53                   	push   %ebx
80105efc:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  if (argstr(0, &path) < 0 || argint(1, (int *)&uargv) < 0)
80105f02:	50                   	push   %eax
80105f03:	6a 00                	push   $0x0
80105f05:	e8 a6 f2 ff ff       	call   801051b0 <argstr>
80105f0a:	83 c4 10             	add    $0x10,%esp
80105f0d:	85 c0                	test   %eax,%eax
80105f0f:	0f 88 87 00 00 00    	js     80105f9c <sys_exec+0xac>
80105f15:	83 ec 08             	sub    $0x8,%esp
80105f18:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
80105f1e:	50                   	push   %eax
80105f1f:	6a 01                	push   $0x1
80105f21:	e8 ca f1 ff ff       	call   801050f0 <argint>
80105f26:	83 c4 10             	add    $0x10,%esp
80105f29:	85 c0                	test   %eax,%eax
80105f2b:	78 6f                	js     80105f9c <sys_exec+0xac>
  {
    return -1;
  }
  memset(argv, 0, sizeof(argv));
80105f2d:	83 ec 04             	sub    $0x4,%esp
80105f30:	8d b5 68 ff ff ff    	lea    -0x98(%ebp),%esi
  for (i = 0;; i++)
80105f36:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
80105f38:	68 80 00 00 00       	push   $0x80
80105f3d:	6a 00                	push   $0x0
80105f3f:	56                   	push   %esi
80105f40:	e8 eb ee ff ff       	call   80104e30 <memset>
80105f45:	83 c4 10             	add    $0x10,%esp
80105f48:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105f4f:	90                   	nop
  {
    if (i >= NELEM(argv))
      return -1;
    if (fetchint(uargv + 4 * i, (int *)&uarg) < 0)
80105f50:	83 ec 08             	sub    $0x8,%esp
80105f53:	8d 85 64 ff ff ff    	lea    -0x9c(%ebp),%eax
80105f59:	8d 3c 9d 00 00 00 00 	lea    0x0(,%ebx,4),%edi
80105f60:	50                   	push   %eax
80105f61:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
80105f67:	01 f8                	add    %edi,%eax
80105f69:	50                   	push   %eax
80105f6a:	e8 f1 f0 ff ff       	call   80105060 <fetchint>
80105f6f:	83 c4 10             	add    $0x10,%esp
80105f72:	85 c0                	test   %eax,%eax
80105f74:	78 26                	js     80105f9c <sys_exec+0xac>
      return -1;
    if (uarg == 0)
80105f76:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80105f7c:	85 c0                	test   %eax,%eax
80105f7e:	74 30                	je     80105fb0 <sys_exec+0xc0>
    {
      argv[i] = 0;
      break;
    }
    if (fetchstr(uarg, &argv[i]) < 0)
80105f80:	83 ec 08             	sub    $0x8,%esp
80105f83:	8d 14 3e             	lea    (%esi,%edi,1),%edx
80105f86:	52                   	push   %edx
80105f87:	50                   	push   %eax
80105f88:	e8 13 f1 ff ff       	call   801050a0 <fetchstr>
80105f8d:	83 c4 10             	add    $0x10,%esp
80105f90:	85 c0                	test   %eax,%eax
80105f92:	78 08                	js     80105f9c <sys_exec+0xac>
  for (i = 0;; i++)
80105f94:	83 c3 01             	add    $0x1,%ebx
    if (i >= NELEM(argv))
80105f97:	83 fb 20             	cmp    $0x20,%ebx
80105f9a:	75 b4                	jne    80105f50 <sys_exec+0x60>
      return -1;
  }
  return exec(path, argv);
}
80105f9c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
80105f9f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105fa4:	5b                   	pop    %ebx
80105fa5:	5e                   	pop    %esi
80105fa6:	5f                   	pop    %edi
80105fa7:	5d                   	pop    %ebp
80105fa8:	c3                   	ret    
80105fa9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      argv[i] = 0;
80105fb0:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
80105fb7:	00 00 00 00 
  return exec(path, argv);
80105fbb:	83 ec 08             	sub    $0x8,%esp
80105fbe:	56                   	push   %esi
80105fbf:	ff b5 5c ff ff ff    	push   -0xa4(%ebp)
80105fc5:	e8 b6 b2 ff ff       	call   80101280 <exec>
80105fca:	83 c4 10             	add    $0x10,%esp
}
80105fcd:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105fd0:	5b                   	pop    %ebx
80105fd1:	5e                   	pop    %esi
80105fd2:	5f                   	pop    %edi
80105fd3:	5d                   	pop    %ebp
80105fd4:	c3                   	ret    
80105fd5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105fdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105fe0 <sys_pipe>:

int sys_pipe(void)
{
80105fe0:	55                   	push   %ebp
80105fe1:	89 e5                	mov    %esp,%ebp
80105fe3:	57                   	push   %edi
80105fe4:	56                   	push   %esi
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if (argptr(0, (void *)&fd, 2 * sizeof(fd[0])) < 0)
80105fe5:	8d 45 dc             	lea    -0x24(%ebp),%eax
{
80105fe8:	53                   	push   %ebx
80105fe9:	83 ec 20             	sub    $0x20,%esp
  if (argptr(0, (void *)&fd, 2 * sizeof(fd[0])) < 0)
80105fec:	6a 08                	push   $0x8
80105fee:	50                   	push   %eax
80105fef:	6a 00                	push   $0x0
80105ff1:	e8 4a f1 ff ff       	call   80105140 <argptr>
80105ff6:	83 c4 10             	add    $0x10,%esp
80105ff9:	85 c0                	test   %eax,%eax
80105ffb:	78 4a                	js     80106047 <sys_pipe+0x67>
    return -1;
  if (pipealloc(&rf, &wf) < 0)
80105ffd:	83 ec 08             	sub    $0x8,%esp
80106000:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80106003:	50                   	push   %eax
80106004:	8d 45 e0             	lea    -0x20(%ebp),%eax
80106007:	50                   	push   %eax
80106008:	e8 f3 db ff ff       	call   80103c00 <pipealloc>
8010600d:	83 c4 10             	add    $0x10,%esp
80106010:	85 c0                	test   %eax,%eax
80106012:	78 33                	js     80106047 <sys_pipe+0x67>
    return -1;
  fd0 = -1;
  if ((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0)
80106014:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for (fd = 0; fd < NOFILE; fd++)
80106017:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
80106019:	e8 22 e1 ff ff       	call   80104140 <myproc>
  for (fd = 0; fd < NOFILE; fd++)
8010601e:	66 90                	xchg   %ax,%ax
    if (curproc->ofile[fd] == 0)
80106020:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
80106024:	85 f6                	test   %esi,%esi
80106026:	74 28                	je     80106050 <sys_pipe+0x70>
  for (fd = 0; fd < NOFILE; fd++)
80106028:	83 c3 01             	add    $0x1,%ebx
8010602b:	83 fb 10             	cmp    $0x10,%ebx
8010602e:	75 f0                	jne    80106020 <sys_pipe+0x40>
  {
    if (fd0 >= 0)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
80106030:	83 ec 0c             	sub    $0xc,%esp
80106033:	ff 75 e0             	push   -0x20(%ebp)
80106036:	e8 85 b6 ff ff       	call   801016c0 <fileclose>
    fileclose(wf);
8010603b:	58                   	pop    %eax
8010603c:	ff 75 e4             	push   -0x1c(%ebp)
8010603f:	e8 7c b6 ff ff       	call   801016c0 <fileclose>
    return -1;
80106044:	83 c4 10             	add    $0x10,%esp
80106047:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010604c:	eb 53                	jmp    801060a1 <sys_pipe+0xc1>
8010604e:	66 90                	xchg   %ax,%ax
      curproc->ofile[fd] = f;
80106050:	8d 73 08             	lea    0x8(%ebx),%esi
80106053:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if ((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0)
80106057:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  struct proc *curproc = myproc();
8010605a:	e8 e1 e0 ff ff       	call   80104140 <myproc>
  for (fd = 0; fd < NOFILE; fd++)
8010605f:	31 d2                	xor    %edx,%edx
80106061:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if (curproc->ofile[fd] == 0)
80106068:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
8010606c:	85 c9                	test   %ecx,%ecx
8010606e:	74 20                	je     80106090 <sys_pipe+0xb0>
  for (fd = 0; fd < NOFILE; fd++)
80106070:	83 c2 01             	add    $0x1,%edx
80106073:	83 fa 10             	cmp    $0x10,%edx
80106076:	75 f0                	jne    80106068 <sys_pipe+0x88>
      myproc()->ofile[fd0] = 0;
80106078:	e8 c3 e0 ff ff       	call   80104140 <myproc>
8010607d:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
80106084:	00 
80106085:	eb a9                	jmp    80106030 <sys_pipe+0x50>
80106087:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010608e:	66 90                	xchg   %ax,%ax
      curproc->ofile[fd] = f;
80106090:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
  }
  fd[0] = fd0;
80106094:	8b 45 dc             	mov    -0x24(%ebp),%eax
80106097:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
80106099:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010609c:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
8010609f:	31 c0                	xor    %eax,%eax
}
801060a1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801060a4:	5b                   	pop    %ebx
801060a5:	5e                   	pop    %esi
801060a6:	5f                   	pop    %edi
801060a7:	5d                   	pop    %ebp
801060a8:	c3                   	ret    
801060a9:	66 90                	xchg   %ax,%ax
801060ab:	66 90                	xchg   %ax,%ax
801060ad:	66 90                	xchg   %ax,%ax
801060af:	90                   	nop

801060b0 <sys_fork>:
#include "mmu.h"
#include "proc.h"

int sys_fork(void)
{
  return fork();
801060b0:	e9 2b e2 ff ff       	jmp    801042e0 <fork>
801060b5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801060bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801060c0 <sys_exit>:
}

int sys_exit(void)
{
801060c0:	55                   	push   %ebp
801060c1:	89 e5                	mov    %esp,%ebp
801060c3:	83 ec 08             	sub    $0x8,%esp
  exit();
801060c6:	e8 95 e4 ff ff       	call   80104560 <exit>
  return 0; // not reached
}
801060cb:	31 c0                	xor    %eax,%eax
801060cd:	c9                   	leave  
801060ce:	c3                   	ret    
801060cf:	90                   	nop

801060d0 <sys_wait>:

int sys_wait(void)
{
  return wait();
801060d0:	e9 bb e5 ff ff       	jmp    80104690 <wait>
801060d5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801060dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801060e0 <sys_kill>:
}

int sys_kill(void)
{
801060e0:	55                   	push   %ebp
801060e1:	89 e5                	mov    %esp,%ebp
801060e3:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if (argint(0, &pid) < 0)
801060e6:	8d 45 f4             	lea    -0xc(%ebp),%eax
801060e9:	50                   	push   %eax
801060ea:	6a 00                	push   $0x0
801060ec:	e8 ff ef ff ff       	call   801050f0 <argint>
801060f1:	83 c4 10             	add    $0x10,%esp
801060f4:	85 c0                	test   %eax,%eax
801060f6:	78 18                	js     80106110 <sys_kill+0x30>
    return -1;
  return kill(pid);
801060f8:	83 ec 0c             	sub    $0xc,%esp
801060fb:	ff 75 f4             	push   -0xc(%ebp)
801060fe:	e8 2d e8 ff ff       	call   80104930 <kill>
80106103:	83 c4 10             	add    $0x10,%esp
}
80106106:	c9                   	leave  
80106107:	c3                   	ret    
80106108:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010610f:	90                   	nop
80106110:	c9                   	leave  
    return -1;
80106111:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106116:	c3                   	ret    
80106117:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010611e:	66 90                	xchg   %ax,%ax

80106120 <sys_getpid>:

int sys_getpid(void)
{
80106120:	55                   	push   %ebp
80106121:	89 e5                	mov    %esp,%ebp
80106123:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
80106126:	e8 15 e0 ff ff       	call   80104140 <myproc>
8010612b:	8b 40 10             	mov    0x10(%eax),%eax
}
8010612e:	c9                   	leave  
8010612f:	c3                   	ret    

80106130 <sys_sbrk>:

int sys_sbrk(void)
{
80106130:	55                   	push   %ebp
80106131:	89 e5                	mov    %esp,%ebp
80106133:	53                   	push   %ebx
  int addr;
  int n;

  if (argint(0, &n) < 0)
80106134:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80106137:	83 ec 1c             	sub    $0x1c,%esp
  if (argint(0, &n) < 0)
8010613a:	50                   	push   %eax
8010613b:	6a 00                	push   $0x0
8010613d:	e8 ae ef ff ff       	call   801050f0 <argint>
80106142:	83 c4 10             	add    $0x10,%esp
80106145:	85 c0                	test   %eax,%eax
80106147:	78 27                	js     80106170 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
80106149:	e8 f2 df ff ff       	call   80104140 <myproc>
  if (growproc(n) < 0)
8010614e:	83 ec 0c             	sub    $0xc,%esp
  addr = myproc()->sz;
80106151:	8b 18                	mov    (%eax),%ebx
  if (growproc(n) < 0)
80106153:	ff 75 f4             	push   -0xc(%ebp)
80106156:	e8 05 e1 ff ff       	call   80104260 <growproc>
8010615b:	83 c4 10             	add    $0x10,%esp
8010615e:	85 c0                	test   %eax,%eax
80106160:	78 0e                	js     80106170 <sys_sbrk+0x40>
    return -1;
  return addr;
}
80106162:	89 d8                	mov    %ebx,%eax
80106164:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106167:	c9                   	leave  
80106168:	c3                   	ret    
80106169:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80106170:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80106175:	eb eb                	jmp    80106162 <sys_sbrk+0x32>
80106177:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010617e:	66 90                	xchg   %ax,%ax

80106180 <sys_sleep>:

int sys_sleep(void)
{
80106180:	55                   	push   %ebp
80106181:	89 e5                	mov    %esp,%ebp
80106183:	53                   	push   %ebx
  int n;
  uint ticks0;

  if (argint(0, &n) < 0)
80106184:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80106187:	83 ec 1c             	sub    $0x1c,%esp
  if (argint(0, &n) < 0)
8010618a:	50                   	push   %eax
8010618b:	6a 00                	push   $0x0
8010618d:	e8 5e ef ff ff       	call   801050f0 <argint>
80106192:	83 c4 10             	add    $0x10,%esp
80106195:	85 c0                	test   %eax,%eax
80106197:	0f 88 8a 00 00 00    	js     80106227 <sys_sleep+0xa7>
    return -1;
  acquire(&tickslock);
8010619d:	83 ec 0c             	sub    $0xc,%esp
801061a0:	68 c0 58 11 80       	push   $0x801158c0
801061a5:	e8 c6 eb ff ff       	call   80104d70 <acquire>
  ticks0 = ticks;
  while (ticks - ticks0 < n)
801061aa:	8b 55 f4             	mov    -0xc(%ebp),%edx
  ticks0 = ticks;
801061ad:	8b 1d a0 58 11 80    	mov    0x801158a0,%ebx
  while (ticks - ticks0 < n)
801061b3:	83 c4 10             	add    $0x10,%esp
801061b6:	85 d2                	test   %edx,%edx
801061b8:	75 27                	jne    801061e1 <sys_sleep+0x61>
801061ba:	eb 54                	jmp    80106210 <sys_sleep+0x90>
801061bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if (myproc()->killed)
    {
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
801061c0:	83 ec 08             	sub    $0x8,%esp
801061c3:	68 c0 58 11 80       	push   $0x801158c0
801061c8:	68 a0 58 11 80       	push   $0x801158a0
801061cd:	e8 3e e6 ff ff       	call   80104810 <sleep>
  while (ticks - ticks0 < n)
801061d2:	a1 a0 58 11 80       	mov    0x801158a0,%eax
801061d7:	83 c4 10             	add    $0x10,%esp
801061da:	29 d8                	sub    %ebx,%eax
801061dc:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801061df:	73 2f                	jae    80106210 <sys_sleep+0x90>
    if (myproc()->killed)
801061e1:	e8 5a df ff ff       	call   80104140 <myproc>
801061e6:	8b 40 24             	mov    0x24(%eax),%eax
801061e9:	85 c0                	test   %eax,%eax
801061eb:	74 d3                	je     801061c0 <sys_sleep+0x40>
      release(&tickslock);
801061ed:	83 ec 0c             	sub    $0xc,%esp
801061f0:	68 c0 58 11 80       	push   $0x801158c0
801061f5:	e8 16 eb ff ff       	call   80104d10 <release>
  }
  release(&tickslock);
  return 0;
}
801061fa:	8b 5d fc             	mov    -0x4(%ebp),%ebx
      return -1;
801061fd:	83 c4 10             	add    $0x10,%esp
80106200:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106205:	c9                   	leave  
80106206:	c3                   	ret    
80106207:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010620e:	66 90                	xchg   %ax,%ax
  release(&tickslock);
80106210:	83 ec 0c             	sub    $0xc,%esp
80106213:	68 c0 58 11 80       	push   $0x801158c0
80106218:	e8 f3 ea ff ff       	call   80104d10 <release>
  return 0;
8010621d:	83 c4 10             	add    $0x10,%esp
80106220:	31 c0                	xor    %eax,%eax
}
80106222:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106225:	c9                   	leave  
80106226:	c3                   	ret    
    return -1;
80106227:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010622c:	eb f4                	jmp    80106222 <sys_sleep+0xa2>
8010622e:	66 90                	xchg   %ax,%ax

80106230 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int sys_uptime(void)
{
80106230:	55                   	push   %ebp
80106231:	89 e5                	mov    %esp,%ebp
80106233:	53                   	push   %ebx
80106234:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
80106237:	68 c0 58 11 80       	push   $0x801158c0
8010623c:	e8 2f eb ff ff       	call   80104d70 <acquire>
  xticks = ticks;
80106241:	8b 1d a0 58 11 80    	mov    0x801158a0,%ebx
  release(&tickslock);
80106247:	c7 04 24 c0 58 11 80 	movl   $0x801158c0,(%esp)
8010624e:	e8 bd ea ff ff       	call   80104d10 <release>
  return xticks;
}
80106253:	89 d8                	mov    %ebx,%eax
80106255:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106258:	c9                   	leave  
80106259:	c3                   	ret    
8010625a:	66 90                	xchg   %ax,%ax
8010625c:	66 90                	xchg   %ax,%ax
8010625e:	66 90                	xchg   %ax,%ax

80106260 <sys_find_digital_root>:
#include "mmu.h"
#include "proc.h"

// return digital root of number given
int sys_find_digital_root(void)
{
80106260:	55                   	push   %ebp
80106261:	89 e5                	mov    %esp,%ebp
80106263:	56                   	push   %esi
80106264:	53                   	push   %ebx
    int n = myproc()->tf->ebx;
80106265:	e8 d6 de ff ff       	call   80104140 <myproc>
    int res = 0;
8010626a:	31 c9                	xor    %ecx,%ecx
    int n = myproc()->tf->ebx;
8010626c:	8b 40 18             	mov    0x18(%eax),%eax
8010626f:	8b 70 10             	mov    0x10(%eax),%esi
    while (n > 0)
80106272:	85 f6                	test   %esi,%esi
80106274:	7e 49                	jle    801062bf <sys_find_digital_root+0x5f>
    {
        res += n % 10;
80106276:	89 f0                	mov    %esi,%eax
80106278:	ba 67 66 66 66       	mov    $0x66666667,%edx
8010627d:	f7 ea                	imul   %edx
8010627f:	89 f0                	mov    %esi,%eax
80106281:	c1 f8 1f             	sar    $0x1f,%eax
80106284:	c1 fa 02             	sar    $0x2,%edx
80106287:	89 d1                	mov    %edx,%ecx
80106289:	29 c1                	sub    %eax,%ecx
8010628b:	8d 04 89             	lea    (%ecx,%ecx,4),%eax
8010628e:	89 cb                	mov    %ecx,%ebx
80106290:	01 c0                	add    %eax,%eax
80106292:	29 c6                	sub    %eax,%esi
80106294:	89 f1                	mov    %esi,%ecx
80106296:	be cd cc cc cc       	mov    $0xcccccccd,%esi
8010629b:	eb 1e                	jmp    801062bb <sys_find_digital_root+0x5b>
8010629d:	8d 76 00             	lea    0x0(%esi),%esi
801062a0:	89 d8                	mov    %ebx,%eax
801062a2:	f7 e6                	mul    %esi
801062a4:	c1 ea 03             	shr    $0x3,%edx
801062a7:	8d 04 92             	lea    (%edx,%edx,4),%eax
801062aa:	01 c0                	add    %eax,%eax
801062ac:	29 c3                	sub    %eax,%ebx
801062ae:	01 d9                	add    %ebx,%ecx
        n /= 10;
801062b0:	89 d3                	mov    %edx,%ebx
        if (res > 9)
            res -= 9;
801062b2:	8d 41 f7             	lea    -0x9(%ecx),%eax
801062b5:	83 f9 09             	cmp    $0x9,%ecx
801062b8:	0f 4f c8             	cmovg  %eax,%ecx
    while (n > 0)
801062bb:	85 db                	test   %ebx,%ebx
801062bd:	75 e1                	jne    801062a0 <sys_find_digital_root+0x40>
    }
    return res;
801062bf:	5b                   	pop    %ebx
801062c0:	89 c8                	mov    %ecx,%eax
801062c2:	5e                   	pop    %esi
801062c3:	5d                   	pop    %ebp
801062c4:	c3                   	ret    

801062c5 <alltraps>:
801062c5:	1e                   	push   %ds
801062c6:	06                   	push   %es
801062c7:	0f a0                	push   %fs
801062c9:	0f a8                	push   %gs
801062cb:	60                   	pusha  
801062cc:	66 b8 10 00          	mov    $0x10,%ax
801062d0:	8e d8                	mov    %eax,%ds
801062d2:	8e c0                	mov    %eax,%es
801062d4:	54                   	push   %esp
801062d5:	e8 c6 00 00 00       	call   801063a0 <trap>
801062da:	83 c4 04             	add    $0x4,%esp

801062dd <trapret>:
801062dd:	61                   	popa   
801062de:	0f a9                	pop    %gs
801062e0:	0f a1                	pop    %fs
801062e2:	07                   	pop    %es
801062e3:	1f                   	pop    %ds
801062e4:	83 c4 08             	add    $0x8,%esp
801062e7:	cf                   	iret   
801062e8:	66 90                	xchg   %ax,%ax
801062ea:	66 90                	xchg   %ax,%ax
801062ec:	66 90                	xchg   %ax,%ax
801062ee:	66 90                	xchg   %ax,%ax

801062f0 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
801062f0:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
801062f1:	31 c0                	xor    %eax,%eax
{
801062f3:	89 e5                	mov    %esp,%ebp
801062f5:	83 ec 08             	sub    $0x8,%esp
801062f8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801062ff:	90                   	nop
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80106300:	8b 14 85 08 b0 10 80 	mov    -0x7fef4ff8(,%eax,4),%edx
80106307:	c7 04 c5 02 59 11 80 	movl   $0x8e000008,-0x7feea6fe(,%eax,8)
8010630e:	08 00 00 8e 
80106312:	66 89 14 c5 00 59 11 	mov    %dx,-0x7feea700(,%eax,8)
80106319:	80 
8010631a:	c1 ea 10             	shr    $0x10,%edx
8010631d:	66 89 14 c5 06 59 11 	mov    %dx,-0x7feea6fa(,%eax,8)
80106324:	80 
  for(i = 0; i < 256; i++)
80106325:	83 c0 01             	add    $0x1,%eax
80106328:	3d 00 01 00 00       	cmp    $0x100,%eax
8010632d:	75 d1                	jne    80106300 <tvinit+0x10>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);

  initlock(&tickslock, "time");
8010632f:	83 ec 08             	sub    $0x8,%esp
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80106332:	a1 08 b1 10 80       	mov    0x8010b108,%eax
80106337:	c7 05 02 5b 11 80 08 	movl   $0xef000008,0x80115b02
8010633e:	00 00 ef 
  initlock(&tickslock, "time");
80106341:	68 78 84 10 80       	push   $0x80108478
80106346:	68 c0 58 11 80       	push   $0x801158c0
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
8010634b:	66 a3 00 5b 11 80    	mov    %ax,0x80115b00
80106351:	c1 e8 10             	shr    $0x10,%eax
80106354:	66 a3 06 5b 11 80    	mov    %ax,0x80115b06
  initlock(&tickslock, "time");
8010635a:	e8 41 e8 ff ff       	call   80104ba0 <initlock>
}
8010635f:	83 c4 10             	add    $0x10,%esp
80106362:	c9                   	leave  
80106363:	c3                   	ret    
80106364:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010636b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010636f:	90                   	nop

80106370 <idtinit>:

void
idtinit(void)
{
80106370:	55                   	push   %ebp
  pd[0] = size - 1;
80106371:	b8 ff 07 00 00       	mov    $0x7ff,%eax
80106376:	89 e5                	mov    %esp,%ebp
80106378:	83 ec 10             	sub    $0x10,%esp
8010637b:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
8010637f:	b8 00 59 11 80       	mov    $0x80115900,%eax
80106384:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80106388:	c1 e8 10             	shr    $0x10,%eax
8010638b:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r"(pd));
8010638f:	8d 45 fa             	lea    -0x6(%ebp),%eax
80106392:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80106395:	c9                   	leave  
80106396:	c3                   	ret    
80106397:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010639e:	66 90                	xchg   %ax,%ax

801063a0 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
801063a0:	55                   	push   %ebp
801063a1:	89 e5                	mov    %esp,%ebp
801063a3:	57                   	push   %edi
801063a4:	56                   	push   %esi
801063a5:	53                   	push   %ebx
801063a6:	83 ec 1c             	sub    $0x1c,%esp
801063a9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(tf->trapno == T_SYSCALL){
801063ac:	8b 43 30             	mov    0x30(%ebx),%eax
801063af:	83 f8 40             	cmp    $0x40,%eax
801063b2:	0f 84 68 01 00 00    	je     80106520 <trap+0x180>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
801063b8:	83 e8 20             	sub    $0x20,%eax
801063bb:	83 f8 1f             	cmp    $0x1f,%eax
801063be:	0f 87 8c 00 00 00    	ja     80106450 <trap+0xb0>
801063c4:	ff 24 85 20 85 10 80 	jmp    *-0x7fef7ae0(,%eax,4)
801063cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801063cf:	90                   	nop
      release(&tickslock);
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
801063d0:	e8 3b c6 ff ff       	call   80102a10 <ideintr>
    lapiceoi();
801063d5:	e8 06 cd ff ff       	call   801030e0 <lapiceoi>
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801063da:	e8 61 dd ff ff       	call   80104140 <myproc>
801063df:	85 c0                	test   %eax,%eax
801063e1:	74 1d                	je     80106400 <trap+0x60>
801063e3:	e8 58 dd ff ff       	call   80104140 <myproc>
801063e8:	8b 50 24             	mov    0x24(%eax),%edx
801063eb:	85 d2                	test   %edx,%edx
801063ed:	74 11                	je     80106400 <trap+0x60>
801063ef:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
801063f3:	83 e0 03             	and    $0x3,%eax
801063f6:	66 83 f8 03          	cmp    $0x3,%ax
801063fa:	0f 84 e8 01 00 00    	je     801065e8 <trap+0x248>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80106400:	e8 3b dd ff ff       	call   80104140 <myproc>
80106405:	85 c0                	test   %eax,%eax
80106407:	74 0f                	je     80106418 <trap+0x78>
80106409:	e8 32 dd ff ff       	call   80104140 <myproc>
8010640e:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80106412:	0f 84 b8 00 00 00    	je     801064d0 <trap+0x130>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106418:	e8 23 dd ff ff       	call   80104140 <myproc>
8010641d:	85 c0                	test   %eax,%eax
8010641f:	74 1d                	je     8010643e <trap+0x9e>
80106421:	e8 1a dd ff ff       	call   80104140 <myproc>
80106426:	8b 40 24             	mov    0x24(%eax),%eax
80106429:	85 c0                	test   %eax,%eax
8010642b:	74 11                	je     8010643e <trap+0x9e>
8010642d:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80106431:	83 e0 03             	and    $0x3,%eax
80106434:	66 83 f8 03          	cmp    $0x3,%ax
80106438:	0f 84 0f 01 00 00    	je     8010654d <trap+0x1ad>
    exit();
}
8010643e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106441:	5b                   	pop    %ebx
80106442:	5e                   	pop    %esi
80106443:	5f                   	pop    %edi
80106444:	5d                   	pop    %ebp
80106445:	c3                   	ret    
80106446:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010644d:	8d 76 00             	lea    0x0(%esi),%esi
    if(myproc() == 0 || (tf->cs&3) == 0){
80106450:	e8 eb dc ff ff       	call   80104140 <myproc>
80106455:	8b 7b 38             	mov    0x38(%ebx),%edi
80106458:	85 c0                	test   %eax,%eax
8010645a:	0f 84 a2 01 00 00    	je     80106602 <trap+0x262>
80106460:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
80106464:	0f 84 98 01 00 00    	je     80106602 <trap+0x262>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r"(val));
8010646a:	0f 20 d1             	mov    %cr2,%ecx
8010646d:	89 4d d8             	mov    %ecx,-0x28(%ebp)
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106470:	e8 ab dc ff ff       	call   80104120 <cpuid>
80106475:	8b 73 30             	mov    0x30(%ebx),%esi
80106478:	89 45 dc             	mov    %eax,-0x24(%ebp)
8010647b:	8b 43 34             	mov    0x34(%ebx),%eax
8010647e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            myproc()->pid, myproc()->name, tf->trapno,
80106481:	e8 ba dc ff ff       	call   80104140 <myproc>
80106486:	89 45 e0             	mov    %eax,-0x20(%ebp)
80106489:	e8 b2 dc ff ff       	call   80104140 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
8010648e:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80106491:	8b 55 dc             	mov    -0x24(%ebp),%edx
80106494:	51                   	push   %ecx
80106495:	57                   	push   %edi
80106496:	52                   	push   %edx
80106497:	ff 75 e4             	push   -0x1c(%ebp)
8010649a:	56                   	push   %esi
            myproc()->pid, myproc()->name, tf->trapno,
8010649b:	8b 75 e0             	mov    -0x20(%ebp),%esi
8010649e:	83 c6 6c             	add    $0x6c,%esi
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801064a1:	56                   	push   %esi
801064a2:	ff 70 10             	push   0x10(%eax)
801064a5:	68 dc 84 10 80       	push   $0x801084dc
801064aa:	e8 a1 a2 ff ff       	call   80100750 <cprintf>
    myproc()->killed = 1;
801064af:	83 c4 20             	add    $0x20,%esp
801064b2:	e8 89 dc ff ff       	call   80104140 <myproc>
801064b7:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801064be:	e8 7d dc ff ff       	call   80104140 <myproc>
801064c3:	85 c0                	test   %eax,%eax
801064c5:	0f 85 18 ff ff ff    	jne    801063e3 <trap+0x43>
801064cb:	e9 30 ff ff ff       	jmp    80106400 <trap+0x60>
  if(myproc() && myproc()->state == RUNNING &&
801064d0:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
801064d4:	0f 85 3e ff ff ff    	jne    80106418 <trap+0x78>
    yield();
801064da:	e8 e1 e2 ff ff       	call   801047c0 <yield>
801064df:	e9 34 ff ff ff       	jmp    80106418 <trap+0x78>
801064e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
801064e8:	8b 7b 38             	mov    0x38(%ebx),%edi
801064eb:	0f b7 73 3c          	movzwl 0x3c(%ebx),%esi
801064ef:	e8 2c dc ff ff       	call   80104120 <cpuid>
801064f4:	57                   	push   %edi
801064f5:	56                   	push   %esi
801064f6:	50                   	push   %eax
801064f7:	68 84 84 10 80       	push   $0x80108484
801064fc:	e8 4f a2 ff ff       	call   80100750 <cprintf>
    lapiceoi();
80106501:	e8 da cb ff ff       	call   801030e0 <lapiceoi>
    break;
80106506:	83 c4 10             	add    $0x10,%esp
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106509:	e8 32 dc ff ff       	call   80104140 <myproc>
8010650e:	85 c0                	test   %eax,%eax
80106510:	0f 85 cd fe ff ff    	jne    801063e3 <trap+0x43>
80106516:	e9 e5 fe ff ff       	jmp    80106400 <trap+0x60>
8010651b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010651f:	90                   	nop
    if(myproc()->killed)
80106520:	e8 1b dc ff ff       	call   80104140 <myproc>
80106525:	8b 70 24             	mov    0x24(%eax),%esi
80106528:	85 f6                	test   %esi,%esi
8010652a:	0f 85 c8 00 00 00    	jne    801065f8 <trap+0x258>
    myproc()->tf = tf;
80106530:	e8 0b dc ff ff       	call   80104140 <myproc>
80106535:	89 58 18             	mov    %ebx,0x18(%eax)
    syscall();
80106538:	e8 f3 ec ff ff       	call   80105230 <syscall>
    if(myproc()->killed)
8010653d:	e8 fe db ff ff       	call   80104140 <myproc>
80106542:	8b 48 24             	mov    0x24(%eax),%ecx
80106545:	85 c9                	test   %ecx,%ecx
80106547:	0f 84 f1 fe ff ff    	je     8010643e <trap+0x9e>
}
8010654d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106550:	5b                   	pop    %ebx
80106551:	5e                   	pop    %esi
80106552:	5f                   	pop    %edi
80106553:	5d                   	pop    %ebp
      exit();
80106554:	e9 07 e0 ff ff       	jmp    80104560 <exit>
80106559:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    uartintr();
80106560:	e8 3b 02 00 00       	call   801067a0 <uartintr>
    lapiceoi();
80106565:	e8 76 cb ff ff       	call   801030e0 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010656a:	e8 d1 db ff ff       	call   80104140 <myproc>
8010656f:	85 c0                	test   %eax,%eax
80106571:	0f 85 6c fe ff ff    	jne    801063e3 <trap+0x43>
80106577:	e9 84 fe ff ff       	jmp    80106400 <trap+0x60>
8010657c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    kbdintr();
80106580:	e8 1b ca ff ff       	call   80102fa0 <kbdintr>
    lapiceoi();
80106585:	e8 56 cb ff ff       	call   801030e0 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010658a:	e8 b1 db ff ff       	call   80104140 <myproc>
8010658f:	85 c0                	test   %eax,%eax
80106591:	0f 85 4c fe ff ff    	jne    801063e3 <trap+0x43>
80106597:	e9 64 fe ff ff       	jmp    80106400 <trap+0x60>
8010659c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(cpuid() == 0){
801065a0:	e8 7b db ff ff       	call   80104120 <cpuid>
801065a5:	85 c0                	test   %eax,%eax
801065a7:	0f 85 28 fe ff ff    	jne    801063d5 <trap+0x35>
      acquire(&tickslock);
801065ad:	83 ec 0c             	sub    $0xc,%esp
801065b0:	68 c0 58 11 80       	push   $0x801158c0
801065b5:	e8 b6 e7 ff ff       	call   80104d70 <acquire>
      wakeup(&ticks);
801065ba:	c7 04 24 a0 58 11 80 	movl   $0x801158a0,(%esp)
      ticks++;
801065c1:	83 05 a0 58 11 80 01 	addl   $0x1,0x801158a0
      wakeup(&ticks);
801065c8:	e8 03 e3 ff ff       	call   801048d0 <wakeup>
      release(&tickslock);
801065cd:	c7 04 24 c0 58 11 80 	movl   $0x801158c0,(%esp)
801065d4:	e8 37 e7 ff ff       	call   80104d10 <release>
801065d9:	83 c4 10             	add    $0x10,%esp
    lapiceoi();
801065dc:	e9 f4 fd ff ff       	jmp    801063d5 <trap+0x35>
801065e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    exit();
801065e8:	e8 73 df ff ff       	call   80104560 <exit>
801065ed:	e9 0e fe ff ff       	jmp    80106400 <trap+0x60>
801065f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      exit();
801065f8:	e8 63 df ff ff       	call   80104560 <exit>
801065fd:	e9 2e ff ff ff       	jmp    80106530 <trap+0x190>
80106602:	0f 20 d6             	mov    %cr2,%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80106605:	e8 16 db ff ff       	call   80104120 <cpuid>
8010660a:	83 ec 0c             	sub    $0xc,%esp
8010660d:	56                   	push   %esi
8010660e:	57                   	push   %edi
8010660f:	50                   	push   %eax
80106610:	ff 73 30             	push   0x30(%ebx)
80106613:	68 a8 84 10 80       	push   $0x801084a8
80106618:	e8 33 a1 ff ff       	call   80100750 <cprintf>
      panic("trap");
8010661d:	83 c4 14             	add    $0x14,%esp
80106620:	68 7d 84 10 80       	push   $0x8010847d
80106625:	e8 76 9d ff ff       	call   801003a0 <panic>
8010662a:	66 90                	xchg   %ax,%ax
8010662c:	66 90                	xchg   %ax,%ax
8010662e:	66 90                	xchg   %ax,%ax

80106630 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80106630:	a1 00 61 11 80       	mov    0x80116100,%eax
80106635:	85 c0                	test   %eax,%eax
80106637:	74 17                	je     80106650 <uartgetc+0x20>
  asm volatile("in %1,%0" : "=a"(data) : "d"(port));
80106639:	ba fd 03 00 00       	mov    $0x3fd,%edx
8010663e:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
8010663f:	a8 01                	test   $0x1,%al
80106641:	74 0d                	je     80106650 <uartgetc+0x20>
80106643:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106648:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
80106649:	0f b6 c0             	movzbl %al,%eax
8010664c:	c3                   	ret    
8010664d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80106650:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106655:	c3                   	ret    
80106656:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010665d:	8d 76 00             	lea    0x0(%esi),%esi

80106660 <uartinit>:
{
80106660:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a"(data), "d"(port));
80106661:	31 c9                	xor    %ecx,%ecx
80106663:	89 c8                	mov    %ecx,%eax
80106665:	89 e5                	mov    %esp,%ebp
80106667:	57                   	push   %edi
80106668:	bf fa 03 00 00       	mov    $0x3fa,%edi
8010666d:	56                   	push   %esi
8010666e:	89 fa                	mov    %edi,%edx
80106670:	53                   	push   %ebx
80106671:	83 ec 1c             	sub    $0x1c,%esp
80106674:	ee                   	out    %al,(%dx)
80106675:	be fb 03 00 00       	mov    $0x3fb,%esi
8010667a:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
8010667f:	89 f2                	mov    %esi,%edx
80106681:	ee                   	out    %al,(%dx)
80106682:	b8 0c 00 00 00       	mov    $0xc,%eax
80106687:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010668c:	ee                   	out    %al,(%dx)
8010668d:	bb f9 03 00 00       	mov    $0x3f9,%ebx
80106692:	89 c8                	mov    %ecx,%eax
80106694:	89 da                	mov    %ebx,%edx
80106696:	ee                   	out    %al,(%dx)
80106697:	b8 03 00 00 00       	mov    $0x3,%eax
8010669c:	89 f2                	mov    %esi,%edx
8010669e:	ee                   	out    %al,(%dx)
8010669f:	ba fc 03 00 00       	mov    $0x3fc,%edx
801066a4:	89 c8                	mov    %ecx,%eax
801066a6:	ee                   	out    %al,(%dx)
801066a7:	b8 01 00 00 00       	mov    $0x1,%eax
801066ac:	89 da                	mov    %ebx,%edx
801066ae:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a"(data) : "d"(port));
801066af:	ba fd 03 00 00       	mov    $0x3fd,%edx
801066b4:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
801066b5:	3c ff                	cmp    $0xff,%al
801066b7:	74 78                	je     80106731 <uartinit+0xd1>
  uart = 1;
801066b9:	c7 05 00 61 11 80 01 	movl   $0x1,0x80116100
801066c0:	00 00 00 
801066c3:	89 fa                	mov    %edi,%edx
801066c5:	ec                   	in     (%dx),%al
801066c6:	ba f8 03 00 00       	mov    $0x3f8,%edx
801066cb:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
801066cc:	83 ec 08             	sub    $0x8,%esp
  for(p="xv6...\n"; *p; p++)
801066cf:	bf a0 85 10 80       	mov    $0x801085a0,%edi
801066d4:	be fd 03 00 00       	mov    $0x3fd,%esi
  ioapicenable(IRQ_COM1, 0);
801066d9:	6a 00                	push   $0x0
801066db:	6a 04                	push   $0x4
801066dd:	e8 6e c5 ff ff       	call   80102c50 <ioapicenable>
  for(p="xv6...\n"; *p; p++)
801066e2:	c6 45 e7 78          	movb   $0x78,-0x19(%ebp)
  ioapicenable(IRQ_COM1, 0);
801066e6:	83 c4 10             	add    $0x10,%esp
801066e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(!uart)
801066f0:	a1 00 61 11 80       	mov    0x80116100,%eax
801066f5:	bb 80 00 00 00       	mov    $0x80,%ebx
801066fa:	85 c0                	test   %eax,%eax
801066fc:	75 14                	jne    80106712 <uartinit+0xb2>
801066fe:	eb 23                	jmp    80106723 <uartinit+0xc3>
    microdelay(10);
80106700:	83 ec 0c             	sub    $0xc,%esp
80106703:	6a 0a                	push   $0xa
80106705:	e8 f6 c9 ff ff       	call   80103100 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
8010670a:	83 c4 10             	add    $0x10,%esp
8010670d:	83 eb 01             	sub    $0x1,%ebx
80106710:	74 07                	je     80106719 <uartinit+0xb9>
80106712:	89 f2                	mov    %esi,%edx
80106714:	ec                   	in     (%dx),%al
80106715:	a8 20                	test   $0x20,%al
80106717:	74 e7                	je     80106700 <uartinit+0xa0>
  asm volatile("out %0,%1" : : "a"(data), "d"(port));
80106719:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
8010671d:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106722:	ee                   	out    %al,(%dx)
  for(p="xv6...\n"; *p; p++)
80106723:	0f b6 47 01          	movzbl 0x1(%edi),%eax
80106727:	83 c7 01             	add    $0x1,%edi
8010672a:	88 45 e7             	mov    %al,-0x19(%ebp)
8010672d:	84 c0                	test   %al,%al
8010672f:	75 bf                	jne    801066f0 <uartinit+0x90>
}
80106731:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106734:	5b                   	pop    %ebx
80106735:	5e                   	pop    %esi
80106736:	5f                   	pop    %edi
80106737:	5d                   	pop    %ebp
80106738:	c3                   	ret    
80106739:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106740 <uartputc>:
  if(!uart)
80106740:	a1 00 61 11 80       	mov    0x80116100,%eax
80106745:	85 c0                	test   %eax,%eax
80106747:	74 47                	je     80106790 <uartputc+0x50>
{
80106749:	55                   	push   %ebp
8010674a:	89 e5                	mov    %esp,%ebp
8010674c:	56                   	push   %esi
  asm volatile("in %1,%0" : "=a"(data) : "d"(port));
8010674d:	be fd 03 00 00       	mov    $0x3fd,%esi
80106752:	53                   	push   %ebx
80106753:	bb 80 00 00 00       	mov    $0x80,%ebx
80106758:	eb 18                	jmp    80106772 <uartputc+0x32>
8010675a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    microdelay(10);
80106760:	83 ec 0c             	sub    $0xc,%esp
80106763:	6a 0a                	push   $0xa
80106765:	e8 96 c9 ff ff       	call   80103100 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
8010676a:	83 c4 10             	add    $0x10,%esp
8010676d:	83 eb 01             	sub    $0x1,%ebx
80106770:	74 07                	je     80106779 <uartputc+0x39>
80106772:	89 f2                	mov    %esi,%edx
80106774:	ec                   	in     (%dx),%al
80106775:	a8 20                	test   $0x20,%al
80106777:	74 e7                	je     80106760 <uartputc+0x20>
  asm volatile("out %0,%1" : : "a"(data), "d"(port));
80106779:	8b 45 08             	mov    0x8(%ebp),%eax
8010677c:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106781:	ee                   	out    %al,(%dx)
}
80106782:	8d 65 f8             	lea    -0x8(%ebp),%esp
80106785:	5b                   	pop    %ebx
80106786:	5e                   	pop    %esi
80106787:	5d                   	pop    %ebp
80106788:	c3                   	ret    
80106789:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106790:	c3                   	ret    
80106791:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106798:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010679f:	90                   	nop

801067a0 <uartintr>:

void
uartintr(void)
{
801067a0:	55                   	push   %ebp
801067a1:	89 e5                	mov    %esp,%ebp
801067a3:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
801067a6:	68 30 66 10 80       	push   $0x80106630
801067ab:	e8 60 a6 ff ff       	call   80100e10 <consoleintr>
}
801067b0:	83 c4 10             	add    $0x10,%esp
801067b3:	c9                   	leave  
801067b4:	c3                   	ret    

801067b5 <vector0>:
801067b5:	6a 00                	push   $0x0
801067b7:	6a 00                	push   $0x0
801067b9:	e9 07 fb ff ff       	jmp    801062c5 <alltraps>

801067be <vector1>:
801067be:	6a 00                	push   $0x0
801067c0:	6a 01                	push   $0x1
801067c2:	e9 fe fa ff ff       	jmp    801062c5 <alltraps>

801067c7 <vector2>:
801067c7:	6a 00                	push   $0x0
801067c9:	6a 02                	push   $0x2
801067cb:	e9 f5 fa ff ff       	jmp    801062c5 <alltraps>

801067d0 <vector3>:
801067d0:	6a 00                	push   $0x0
801067d2:	6a 03                	push   $0x3
801067d4:	e9 ec fa ff ff       	jmp    801062c5 <alltraps>

801067d9 <vector4>:
801067d9:	6a 00                	push   $0x0
801067db:	6a 04                	push   $0x4
801067dd:	e9 e3 fa ff ff       	jmp    801062c5 <alltraps>

801067e2 <vector5>:
801067e2:	6a 00                	push   $0x0
801067e4:	6a 05                	push   $0x5
801067e6:	e9 da fa ff ff       	jmp    801062c5 <alltraps>

801067eb <vector6>:
801067eb:	6a 00                	push   $0x0
801067ed:	6a 06                	push   $0x6
801067ef:	e9 d1 fa ff ff       	jmp    801062c5 <alltraps>

801067f4 <vector7>:
801067f4:	6a 00                	push   $0x0
801067f6:	6a 07                	push   $0x7
801067f8:	e9 c8 fa ff ff       	jmp    801062c5 <alltraps>

801067fd <vector8>:
801067fd:	6a 08                	push   $0x8
801067ff:	e9 c1 fa ff ff       	jmp    801062c5 <alltraps>

80106804 <vector9>:
80106804:	6a 00                	push   $0x0
80106806:	6a 09                	push   $0x9
80106808:	e9 b8 fa ff ff       	jmp    801062c5 <alltraps>

8010680d <vector10>:
8010680d:	6a 0a                	push   $0xa
8010680f:	e9 b1 fa ff ff       	jmp    801062c5 <alltraps>

80106814 <vector11>:
80106814:	6a 0b                	push   $0xb
80106816:	e9 aa fa ff ff       	jmp    801062c5 <alltraps>

8010681b <vector12>:
8010681b:	6a 0c                	push   $0xc
8010681d:	e9 a3 fa ff ff       	jmp    801062c5 <alltraps>

80106822 <vector13>:
80106822:	6a 0d                	push   $0xd
80106824:	e9 9c fa ff ff       	jmp    801062c5 <alltraps>

80106829 <vector14>:
80106829:	6a 0e                	push   $0xe
8010682b:	e9 95 fa ff ff       	jmp    801062c5 <alltraps>

80106830 <vector15>:
80106830:	6a 00                	push   $0x0
80106832:	6a 0f                	push   $0xf
80106834:	e9 8c fa ff ff       	jmp    801062c5 <alltraps>

80106839 <vector16>:
80106839:	6a 00                	push   $0x0
8010683b:	6a 10                	push   $0x10
8010683d:	e9 83 fa ff ff       	jmp    801062c5 <alltraps>

80106842 <vector17>:
80106842:	6a 11                	push   $0x11
80106844:	e9 7c fa ff ff       	jmp    801062c5 <alltraps>

80106849 <vector18>:
80106849:	6a 00                	push   $0x0
8010684b:	6a 12                	push   $0x12
8010684d:	e9 73 fa ff ff       	jmp    801062c5 <alltraps>

80106852 <vector19>:
80106852:	6a 00                	push   $0x0
80106854:	6a 13                	push   $0x13
80106856:	e9 6a fa ff ff       	jmp    801062c5 <alltraps>

8010685b <vector20>:
8010685b:	6a 00                	push   $0x0
8010685d:	6a 14                	push   $0x14
8010685f:	e9 61 fa ff ff       	jmp    801062c5 <alltraps>

80106864 <vector21>:
80106864:	6a 00                	push   $0x0
80106866:	6a 15                	push   $0x15
80106868:	e9 58 fa ff ff       	jmp    801062c5 <alltraps>

8010686d <vector22>:
8010686d:	6a 00                	push   $0x0
8010686f:	6a 16                	push   $0x16
80106871:	e9 4f fa ff ff       	jmp    801062c5 <alltraps>

80106876 <vector23>:
80106876:	6a 00                	push   $0x0
80106878:	6a 17                	push   $0x17
8010687a:	e9 46 fa ff ff       	jmp    801062c5 <alltraps>

8010687f <vector24>:
8010687f:	6a 00                	push   $0x0
80106881:	6a 18                	push   $0x18
80106883:	e9 3d fa ff ff       	jmp    801062c5 <alltraps>

80106888 <vector25>:
80106888:	6a 00                	push   $0x0
8010688a:	6a 19                	push   $0x19
8010688c:	e9 34 fa ff ff       	jmp    801062c5 <alltraps>

80106891 <vector26>:
80106891:	6a 00                	push   $0x0
80106893:	6a 1a                	push   $0x1a
80106895:	e9 2b fa ff ff       	jmp    801062c5 <alltraps>

8010689a <vector27>:
8010689a:	6a 00                	push   $0x0
8010689c:	6a 1b                	push   $0x1b
8010689e:	e9 22 fa ff ff       	jmp    801062c5 <alltraps>

801068a3 <vector28>:
801068a3:	6a 00                	push   $0x0
801068a5:	6a 1c                	push   $0x1c
801068a7:	e9 19 fa ff ff       	jmp    801062c5 <alltraps>

801068ac <vector29>:
801068ac:	6a 00                	push   $0x0
801068ae:	6a 1d                	push   $0x1d
801068b0:	e9 10 fa ff ff       	jmp    801062c5 <alltraps>

801068b5 <vector30>:
801068b5:	6a 00                	push   $0x0
801068b7:	6a 1e                	push   $0x1e
801068b9:	e9 07 fa ff ff       	jmp    801062c5 <alltraps>

801068be <vector31>:
801068be:	6a 00                	push   $0x0
801068c0:	6a 1f                	push   $0x1f
801068c2:	e9 fe f9 ff ff       	jmp    801062c5 <alltraps>

801068c7 <vector32>:
801068c7:	6a 00                	push   $0x0
801068c9:	6a 20                	push   $0x20
801068cb:	e9 f5 f9 ff ff       	jmp    801062c5 <alltraps>

801068d0 <vector33>:
801068d0:	6a 00                	push   $0x0
801068d2:	6a 21                	push   $0x21
801068d4:	e9 ec f9 ff ff       	jmp    801062c5 <alltraps>

801068d9 <vector34>:
801068d9:	6a 00                	push   $0x0
801068db:	6a 22                	push   $0x22
801068dd:	e9 e3 f9 ff ff       	jmp    801062c5 <alltraps>

801068e2 <vector35>:
801068e2:	6a 00                	push   $0x0
801068e4:	6a 23                	push   $0x23
801068e6:	e9 da f9 ff ff       	jmp    801062c5 <alltraps>

801068eb <vector36>:
801068eb:	6a 00                	push   $0x0
801068ed:	6a 24                	push   $0x24
801068ef:	e9 d1 f9 ff ff       	jmp    801062c5 <alltraps>

801068f4 <vector37>:
801068f4:	6a 00                	push   $0x0
801068f6:	6a 25                	push   $0x25
801068f8:	e9 c8 f9 ff ff       	jmp    801062c5 <alltraps>

801068fd <vector38>:
801068fd:	6a 00                	push   $0x0
801068ff:	6a 26                	push   $0x26
80106901:	e9 bf f9 ff ff       	jmp    801062c5 <alltraps>

80106906 <vector39>:
80106906:	6a 00                	push   $0x0
80106908:	6a 27                	push   $0x27
8010690a:	e9 b6 f9 ff ff       	jmp    801062c5 <alltraps>

8010690f <vector40>:
8010690f:	6a 00                	push   $0x0
80106911:	6a 28                	push   $0x28
80106913:	e9 ad f9 ff ff       	jmp    801062c5 <alltraps>

80106918 <vector41>:
80106918:	6a 00                	push   $0x0
8010691a:	6a 29                	push   $0x29
8010691c:	e9 a4 f9 ff ff       	jmp    801062c5 <alltraps>

80106921 <vector42>:
80106921:	6a 00                	push   $0x0
80106923:	6a 2a                	push   $0x2a
80106925:	e9 9b f9 ff ff       	jmp    801062c5 <alltraps>

8010692a <vector43>:
8010692a:	6a 00                	push   $0x0
8010692c:	6a 2b                	push   $0x2b
8010692e:	e9 92 f9 ff ff       	jmp    801062c5 <alltraps>

80106933 <vector44>:
80106933:	6a 00                	push   $0x0
80106935:	6a 2c                	push   $0x2c
80106937:	e9 89 f9 ff ff       	jmp    801062c5 <alltraps>

8010693c <vector45>:
8010693c:	6a 00                	push   $0x0
8010693e:	6a 2d                	push   $0x2d
80106940:	e9 80 f9 ff ff       	jmp    801062c5 <alltraps>

80106945 <vector46>:
80106945:	6a 00                	push   $0x0
80106947:	6a 2e                	push   $0x2e
80106949:	e9 77 f9 ff ff       	jmp    801062c5 <alltraps>

8010694e <vector47>:
8010694e:	6a 00                	push   $0x0
80106950:	6a 2f                	push   $0x2f
80106952:	e9 6e f9 ff ff       	jmp    801062c5 <alltraps>

80106957 <vector48>:
80106957:	6a 00                	push   $0x0
80106959:	6a 30                	push   $0x30
8010695b:	e9 65 f9 ff ff       	jmp    801062c5 <alltraps>

80106960 <vector49>:
80106960:	6a 00                	push   $0x0
80106962:	6a 31                	push   $0x31
80106964:	e9 5c f9 ff ff       	jmp    801062c5 <alltraps>

80106969 <vector50>:
80106969:	6a 00                	push   $0x0
8010696b:	6a 32                	push   $0x32
8010696d:	e9 53 f9 ff ff       	jmp    801062c5 <alltraps>

80106972 <vector51>:
80106972:	6a 00                	push   $0x0
80106974:	6a 33                	push   $0x33
80106976:	e9 4a f9 ff ff       	jmp    801062c5 <alltraps>

8010697b <vector52>:
8010697b:	6a 00                	push   $0x0
8010697d:	6a 34                	push   $0x34
8010697f:	e9 41 f9 ff ff       	jmp    801062c5 <alltraps>

80106984 <vector53>:
80106984:	6a 00                	push   $0x0
80106986:	6a 35                	push   $0x35
80106988:	e9 38 f9 ff ff       	jmp    801062c5 <alltraps>

8010698d <vector54>:
8010698d:	6a 00                	push   $0x0
8010698f:	6a 36                	push   $0x36
80106991:	e9 2f f9 ff ff       	jmp    801062c5 <alltraps>

80106996 <vector55>:
80106996:	6a 00                	push   $0x0
80106998:	6a 37                	push   $0x37
8010699a:	e9 26 f9 ff ff       	jmp    801062c5 <alltraps>

8010699f <vector56>:
8010699f:	6a 00                	push   $0x0
801069a1:	6a 38                	push   $0x38
801069a3:	e9 1d f9 ff ff       	jmp    801062c5 <alltraps>

801069a8 <vector57>:
801069a8:	6a 00                	push   $0x0
801069aa:	6a 39                	push   $0x39
801069ac:	e9 14 f9 ff ff       	jmp    801062c5 <alltraps>

801069b1 <vector58>:
801069b1:	6a 00                	push   $0x0
801069b3:	6a 3a                	push   $0x3a
801069b5:	e9 0b f9 ff ff       	jmp    801062c5 <alltraps>

801069ba <vector59>:
801069ba:	6a 00                	push   $0x0
801069bc:	6a 3b                	push   $0x3b
801069be:	e9 02 f9 ff ff       	jmp    801062c5 <alltraps>

801069c3 <vector60>:
801069c3:	6a 00                	push   $0x0
801069c5:	6a 3c                	push   $0x3c
801069c7:	e9 f9 f8 ff ff       	jmp    801062c5 <alltraps>

801069cc <vector61>:
801069cc:	6a 00                	push   $0x0
801069ce:	6a 3d                	push   $0x3d
801069d0:	e9 f0 f8 ff ff       	jmp    801062c5 <alltraps>

801069d5 <vector62>:
801069d5:	6a 00                	push   $0x0
801069d7:	6a 3e                	push   $0x3e
801069d9:	e9 e7 f8 ff ff       	jmp    801062c5 <alltraps>

801069de <vector63>:
801069de:	6a 00                	push   $0x0
801069e0:	6a 3f                	push   $0x3f
801069e2:	e9 de f8 ff ff       	jmp    801062c5 <alltraps>

801069e7 <vector64>:
801069e7:	6a 00                	push   $0x0
801069e9:	6a 40                	push   $0x40
801069eb:	e9 d5 f8 ff ff       	jmp    801062c5 <alltraps>

801069f0 <vector65>:
801069f0:	6a 00                	push   $0x0
801069f2:	6a 41                	push   $0x41
801069f4:	e9 cc f8 ff ff       	jmp    801062c5 <alltraps>

801069f9 <vector66>:
801069f9:	6a 00                	push   $0x0
801069fb:	6a 42                	push   $0x42
801069fd:	e9 c3 f8 ff ff       	jmp    801062c5 <alltraps>

80106a02 <vector67>:
80106a02:	6a 00                	push   $0x0
80106a04:	6a 43                	push   $0x43
80106a06:	e9 ba f8 ff ff       	jmp    801062c5 <alltraps>

80106a0b <vector68>:
80106a0b:	6a 00                	push   $0x0
80106a0d:	6a 44                	push   $0x44
80106a0f:	e9 b1 f8 ff ff       	jmp    801062c5 <alltraps>

80106a14 <vector69>:
80106a14:	6a 00                	push   $0x0
80106a16:	6a 45                	push   $0x45
80106a18:	e9 a8 f8 ff ff       	jmp    801062c5 <alltraps>

80106a1d <vector70>:
80106a1d:	6a 00                	push   $0x0
80106a1f:	6a 46                	push   $0x46
80106a21:	e9 9f f8 ff ff       	jmp    801062c5 <alltraps>

80106a26 <vector71>:
80106a26:	6a 00                	push   $0x0
80106a28:	6a 47                	push   $0x47
80106a2a:	e9 96 f8 ff ff       	jmp    801062c5 <alltraps>

80106a2f <vector72>:
80106a2f:	6a 00                	push   $0x0
80106a31:	6a 48                	push   $0x48
80106a33:	e9 8d f8 ff ff       	jmp    801062c5 <alltraps>

80106a38 <vector73>:
80106a38:	6a 00                	push   $0x0
80106a3a:	6a 49                	push   $0x49
80106a3c:	e9 84 f8 ff ff       	jmp    801062c5 <alltraps>

80106a41 <vector74>:
80106a41:	6a 00                	push   $0x0
80106a43:	6a 4a                	push   $0x4a
80106a45:	e9 7b f8 ff ff       	jmp    801062c5 <alltraps>

80106a4a <vector75>:
80106a4a:	6a 00                	push   $0x0
80106a4c:	6a 4b                	push   $0x4b
80106a4e:	e9 72 f8 ff ff       	jmp    801062c5 <alltraps>

80106a53 <vector76>:
80106a53:	6a 00                	push   $0x0
80106a55:	6a 4c                	push   $0x4c
80106a57:	e9 69 f8 ff ff       	jmp    801062c5 <alltraps>

80106a5c <vector77>:
80106a5c:	6a 00                	push   $0x0
80106a5e:	6a 4d                	push   $0x4d
80106a60:	e9 60 f8 ff ff       	jmp    801062c5 <alltraps>

80106a65 <vector78>:
80106a65:	6a 00                	push   $0x0
80106a67:	6a 4e                	push   $0x4e
80106a69:	e9 57 f8 ff ff       	jmp    801062c5 <alltraps>

80106a6e <vector79>:
80106a6e:	6a 00                	push   $0x0
80106a70:	6a 4f                	push   $0x4f
80106a72:	e9 4e f8 ff ff       	jmp    801062c5 <alltraps>

80106a77 <vector80>:
80106a77:	6a 00                	push   $0x0
80106a79:	6a 50                	push   $0x50
80106a7b:	e9 45 f8 ff ff       	jmp    801062c5 <alltraps>

80106a80 <vector81>:
80106a80:	6a 00                	push   $0x0
80106a82:	6a 51                	push   $0x51
80106a84:	e9 3c f8 ff ff       	jmp    801062c5 <alltraps>

80106a89 <vector82>:
80106a89:	6a 00                	push   $0x0
80106a8b:	6a 52                	push   $0x52
80106a8d:	e9 33 f8 ff ff       	jmp    801062c5 <alltraps>

80106a92 <vector83>:
80106a92:	6a 00                	push   $0x0
80106a94:	6a 53                	push   $0x53
80106a96:	e9 2a f8 ff ff       	jmp    801062c5 <alltraps>

80106a9b <vector84>:
80106a9b:	6a 00                	push   $0x0
80106a9d:	6a 54                	push   $0x54
80106a9f:	e9 21 f8 ff ff       	jmp    801062c5 <alltraps>

80106aa4 <vector85>:
80106aa4:	6a 00                	push   $0x0
80106aa6:	6a 55                	push   $0x55
80106aa8:	e9 18 f8 ff ff       	jmp    801062c5 <alltraps>

80106aad <vector86>:
80106aad:	6a 00                	push   $0x0
80106aaf:	6a 56                	push   $0x56
80106ab1:	e9 0f f8 ff ff       	jmp    801062c5 <alltraps>

80106ab6 <vector87>:
80106ab6:	6a 00                	push   $0x0
80106ab8:	6a 57                	push   $0x57
80106aba:	e9 06 f8 ff ff       	jmp    801062c5 <alltraps>

80106abf <vector88>:
80106abf:	6a 00                	push   $0x0
80106ac1:	6a 58                	push   $0x58
80106ac3:	e9 fd f7 ff ff       	jmp    801062c5 <alltraps>

80106ac8 <vector89>:
80106ac8:	6a 00                	push   $0x0
80106aca:	6a 59                	push   $0x59
80106acc:	e9 f4 f7 ff ff       	jmp    801062c5 <alltraps>

80106ad1 <vector90>:
80106ad1:	6a 00                	push   $0x0
80106ad3:	6a 5a                	push   $0x5a
80106ad5:	e9 eb f7 ff ff       	jmp    801062c5 <alltraps>

80106ada <vector91>:
80106ada:	6a 00                	push   $0x0
80106adc:	6a 5b                	push   $0x5b
80106ade:	e9 e2 f7 ff ff       	jmp    801062c5 <alltraps>

80106ae3 <vector92>:
80106ae3:	6a 00                	push   $0x0
80106ae5:	6a 5c                	push   $0x5c
80106ae7:	e9 d9 f7 ff ff       	jmp    801062c5 <alltraps>

80106aec <vector93>:
80106aec:	6a 00                	push   $0x0
80106aee:	6a 5d                	push   $0x5d
80106af0:	e9 d0 f7 ff ff       	jmp    801062c5 <alltraps>

80106af5 <vector94>:
80106af5:	6a 00                	push   $0x0
80106af7:	6a 5e                	push   $0x5e
80106af9:	e9 c7 f7 ff ff       	jmp    801062c5 <alltraps>

80106afe <vector95>:
80106afe:	6a 00                	push   $0x0
80106b00:	6a 5f                	push   $0x5f
80106b02:	e9 be f7 ff ff       	jmp    801062c5 <alltraps>

80106b07 <vector96>:
80106b07:	6a 00                	push   $0x0
80106b09:	6a 60                	push   $0x60
80106b0b:	e9 b5 f7 ff ff       	jmp    801062c5 <alltraps>

80106b10 <vector97>:
80106b10:	6a 00                	push   $0x0
80106b12:	6a 61                	push   $0x61
80106b14:	e9 ac f7 ff ff       	jmp    801062c5 <alltraps>

80106b19 <vector98>:
80106b19:	6a 00                	push   $0x0
80106b1b:	6a 62                	push   $0x62
80106b1d:	e9 a3 f7 ff ff       	jmp    801062c5 <alltraps>

80106b22 <vector99>:
80106b22:	6a 00                	push   $0x0
80106b24:	6a 63                	push   $0x63
80106b26:	e9 9a f7 ff ff       	jmp    801062c5 <alltraps>

80106b2b <vector100>:
80106b2b:	6a 00                	push   $0x0
80106b2d:	6a 64                	push   $0x64
80106b2f:	e9 91 f7 ff ff       	jmp    801062c5 <alltraps>

80106b34 <vector101>:
80106b34:	6a 00                	push   $0x0
80106b36:	6a 65                	push   $0x65
80106b38:	e9 88 f7 ff ff       	jmp    801062c5 <alltraps>

80106b3d <vector102>:
80106b3d:	6a 00                	push   $0x0
80106b3f:	6a 66                	push   $0x66
80106b41:	e9 7f f7 ff ff       	jmp    801062c5 <alltraps>

80106b46 <vector103>:
80106b46:	6a 00                	push   $0x0
80106b48:	6a 67                	push   $0x67
80106b4a:	e9 76 f7 ff ff       	jmp    801062c5 <alltraps>

80106b4f <vector104>:
80106b4f:	6a 00                	push   $0x0
80106b51:	6a 68                	push   $0x68
80106b53:	e9 6d f7 ff ff       	jmp    801062c5 <alltraps>

80106b58 <vector105>:
80106b58:	6a 00                	push   $0x0
80106b5a:	6a 69                	push   $0x69
80106b5c:	e9 64 f7 ff ff       	jmp    801062c5 <alltraps>

80106b61 <vector106>:
80106b61:	6a 00                	push   $0x0
80106b63:	6a 6a                	push   $0x6a
80106b65:	e9 5b f7 ff ff       	jmp    801062c5 <alltraps>

80106b6a <vector107>:
80106b6a:	6a 00                	push   $0x0
80106b6c:	6a 6b                	push   $0x6b
80106b6e:	e9 52 f7 ff ff       	jmp    801062c5 <alltraps>

80106b73 <vector108>:
80106b73:	6a 00                	push   $0x0
80106b75:	6a 6c                	push   $0x6c
80106b77:	e9 49 f7 ff ff       	jmp    801062c5 <alltraps>

80106b7c <vector109>:
80106b7c:	6a 00                	push   $0x0
80106b7e:	6a 6d                	push   $0x6d
80106b80:	e9 40 f7 ff ff       	jmp    801062c5 <alltraps>

80106b85 <vector110>:
80106b85:	6a 00                	push   $0x0
80106b87:	6a 6e                	push   $0x6e
80106b89:	e9 37 f7 ff ff       	jmp    801062c5 <alltraps>

80106b8e <vector111>:
80106b8e:	6a 00                	push   $0x0
80106b90:	6a 6f                	push   $0x6f
80106b92:	e9 2e f7 ff ff       	jmp    801062c5 <alltraps>

80106b97 <vector112>:
80106b97:	6a 00                	push   $0x0
80106b99:	6a 70                	push   $0x70
80106b9b:	e9 25 f7 ff ff       	jmp    801062c5 <alltraps>

80106ba0 <vector113>:
80106ba0:	6a 00                	push   $0x0
80106ba2:	6a 71                	push   $0x71
80106ba4:	e9 1c f7 ff ff       	jmp    801062c5 <alltraps>

80106ba9 <vector114>:
80106ba9:	6a 00                	push   $0x0
80106bab:	6a 72                	push   $0x72
80106bad:	e9 13 f7 ff ff       	jmp    801062c5 <alltraps>

80106bb2 <vector115>:
80106bb2:	6a 00                	push   $0x0
80106bb4:	6a 73                	push   $0x73
80106bb6:	e9 0a f7 ff ff       	jmp    801062c5 <alltraps>

80106bbb <vector116>:
80106bbb:	6a 00                	push   $0x0
80106bbd:	6a 74                	push   $0x74
80106bbf:	e9 01 f7 ff ff       	jmp    801062c5 <alltraps>

80106bc4 <vector117>:
80106bc4:	6a 00                	push   $0x0
80106bc6:	6a 75                	push   $0x75
80106bc8:	e9 f8 f6 ff ff       	jmp    801062c5 <alltraps>

80106bcd <vector118>:
80106bcd:	6a 00                	push   $0x0
80106bcf:	6a 76                	push   $0x76
80106bd1:	e9 ef f6 ff ff       	jmp    801062c5 <alltraps>

80106bd6 <vector119>:
80106bd6:	6a 00                	push   $0x0
80106bd8:	6a 77                	push   $0x77
80106bda:	e9 e6 f6 ff ff       	jmp    801062c5 <alltraps>

80106bdf <vector120>:
80106bdf:	6a 00                	push   $0x0
80106be1:	6a 78                	push   $0x78
80106be3:	e9 dd f6 ff ff       	jmp    801062c5 <alltraps>

80106be8 <vector121>:
80106be8:	6a 00                	push   $0x0
80106bea:	6a 79                	push   $0x79
80106bec:	e9 d4 f6 ff ff       	jmp    801062c5 <alltraps>

80106bf1 <vector122>:
80106bf1:	6a 00                	push   $0x0
80106bf3:	6a 7a                	push   $0x7a
80106bf5:	e9 cb f6 ff ff       	jmp    801062c5 <alltraps>

80106bfa <vector123>:
80106bfa:	6a 00                	push   $0x0
80106bfc:	6a 7b                	push   $0x7b
80106bfe:	e9 c2 f6 ff ff       	jmp    801062c5 <alltraps>

80106c03 <vector124>:
80106c03:	6a 00                	push   $0x0
80106c05:	6a 7c                	push   $0x7c
80106c07:	e9 b9 f6 ff ff       	jmp    801062c5 <alltraps>

80106c0c <vector125>:
80106c0c:	6a 00                	push   $0x0
80106c0e:	6a 7d                	push   $0x7d
80106c10:	e9 b0 f6 ff ff       	jmp    801062c5 <alltraps>

80106c15 <vector126>:
80106c15:	6a 00                	push   $0x0
80106c17:	6a 7e                	push   $0x7e
80106c19:	e9 a7 f6 ff ff       	jmp    801062c5 <alltraps>

80106c1e <vector127>:
80106c1e:	6a 00                	push   $0x0
80106c20:	6a 7f                	push   $0x7f
80106c22:	e9 9e f6 ff ff       	jmp    801062c5 <alltraps>

80106c27 <vector128>:
80106c27:	6a 00                	push   $0x0
80106c29:	68 80 00 00 00       	push   $0x80
80106c2e:	e9 92 f6 ff ff       	jmp    801062c5 <alltraps>

80106c33 <vector129>:
80106c33:	6a 00                	push   $0x0
80106c35:	68 81 00 00 00       	push   $0x81
80106c3a:	e9 86 f6 ff ff       	jmp    801062c5 <alltraps>

80106c3f <vector130>:
80106c3f:	6a 00                	push   $0x0
80106c41:	68 82 00 00 00       	push   $0x82
80106c46:	e9 7a f6 ff ff       	jmp    801062c5 <alltraps>

80106c4b <vector131>:
80106c4b:	6a 00                	push   $0x0
80106c4d:	68 83 00 00 00       	push   $0x83
80106c52:	e9 6e f6 ff ff       	jmp    801062c5 <alltraps>

80106c57 <vector132>:
80106c57:	6a 00                	push   $0x0
80106c59:	68 84 00 00 00       	push   $0x84
80106c5e:	e9 62 f6 ff ff       	jmp    801062c5 <alltraps>

80106c63 <vector133>:
80106c63:	6a 00                	push   $0x0
80106c65:	68 85 00 00 00       	push   $0x85
80106c6a:	e9 56 f6 ff ff       	jmp    801062c5 <alltraps>

80106c6f <vector134>:
80106c6f:	6a 00                	push   $0x0
80106c71:	68 86 00 00 00       	push   $0x86
80106c76:	e9 4a f6 ff ff       	jmp    801062c5 <alltraps>

80106c7b <vector135>:
80106c7b:	6a 00                	push   $0x0
80106c7d:	68 87 00 00 00       	push   $0x87
80106c82:	e9 3e f6 ff ff       	jmp    801062c5 <alltraps>

80106c87 <vector136>:
80106c87:	6a 00                	push   $0x0
80106c89:	68 88 00 00 00       	push   $0x88
80106c8e:	e9 32 f6 ff ff       	jmp    801062c5 <alltraps>

80106c93 <vector137>:
80106c93:	6a 00                	push   $0x0
80106c95:	68 89 00 00 00       	push   $0x89
80106c9a:	e9 26 f6 ff ff       	jmp    801062c5 <alltraps>

80106c9f <vector138>:
80106c9f:	6a 00                	push   $0x0
80106ca1:	68 8a 00 00 00       	push   $0x8a
80106ca6:	e9 1a f6 ff ff       	jmp    801062c5 <alltraps>

80106cab <vector139>:
80106cab:	6a 00                	push   $0x0
80106cad:	68 8b 00 00 00       	push   $0x8b
80106cb2:	e9 0e f6 ff ff       	jmp    801062c5 <alltraps>

80106cb7 <vector140>:
80106cb7:	6a 00                	push   $0x0
80106cb9:	68 8c 00 00 00       	push   $0x8c
80106cbe:	e9 02 f6 ff ff       	jmp    801062c5 <alltraps>

80106cc3 <vector141>:
80106cc3:	6a 00                	push   $0x0
80106cc5:	68 8d 00 00 00       	push   $0x8d
80106cca:	e9 f6 f5 ff ff       	jmp    801062c5 <alltraps>

80106ccf <vector142>:
80106ccf:	6a 00                	push   $0x0
80106cd1:	68 8e 00 00 00       	push   $0x8e
80106cd6:	e9 ea f5 ff ff       	jmp    801062c5 <alltraps>

80106cdb <vector143>:
80106cdb:	6a 00                	push   $0x0
80106cdd:	68 8f 00 00 00       	push   $0x8f
80106ce2:	e9 de f5 ff ff       	jmp    801062c5 <alltraps>

80106ce7 <vector144>:
80106ce7:	6a 00                	push   $0x0
80106ce9:	68 90 00 00 00       	push   $0x90
80106cee:	e9 d2 f5 ff ff       	jmp    801062c5 <alltraps>

80106cf3 <vector145>:
80106cf3:	6a 00                	push   $0x0
80106cf5:	68 91 00 00 00       	push   $0x91
80106cfa:	e9 c6 f5 ff ff       	jmp    801062c5 <alltraps>

80106cff <vector146>:
80106cff:	6a 00                	push   $0x0
80106d01:	68 92 00 00 00       	push   $0x92
80106d06:	e9 ba f5 ff ff       	jmp    801062c5 <alltraps>

80106d0b <vector147>:
80106d0b:	6a 00                	push   $0x0
80106d0d:	68 93 00 00 00       	push   $0x93
80106d12:	e9 ae f5 ff ff       	jmp    801062c5 <alltraps>

80106d17 <vector148>:
80106d17:	6a 00                	push   $0x0
80106d19:	68 94 00 00 00       	push   $0x94
80106d1e:	e9 a2 f5 ff ff       	jmp    801062c5 <alltraps>

80106d23 <vector149>:
80106d23:	6a 00                	push   $0x0
80106d25:	68 95 00 00 00       	push   $0x95
80106d2a:	e9 96 f5 ff ff       	jmp    801062c5 <alltraps>

80106d2f <vector150>:
80106d2f:	6a 00                	push   $0x0
80106d31:	68 96 00 00 00       	push   $0x96
80106d36:	e9 8a f5 ff ff       	jmp    801062c5 <alltraps>

80106d3b <vector151>:
80106d3b:	6a 00                	push   $0x0
80106d3d:	68 97 00 00 00       	push   $0x97
80106d42:	e9 7e f5 ff ff       	jmp    801062c5 <alltraps>

80106d47 <vector152>:
80106d47:	6a 00                	push   $0x0
80106d49:	68 98 00 00 00       	push   $0x98
80106d4e:	e9 72 f5 ff ff       	jmp    801062c5 <alltraps>

80106d53 <vector153>:
80106d53:	6a 00                	push   $0x0
80106d55:	68 99 00 00 00       	push   $0x99
80106d5a:	e9 66 f5 ff ff       	jmp    801062c5 <alltraps>

80106d5f <vector154>:
80106d5f:	6a 00                	push   $0x0
80106d61:	68 9a 00 00 00       	push   $0x9a
80106d66:	e9 5a f5 ff ff       	jmp    801062c5 <alltraps>

80106d6b <vector155>:
80106d6b:	6a 00                	push   $0x0
80106d6d:	68 9b 00 00 00       	push   $0x9b
80106d72:	e9 4e f5 ff ff       	jmp    801062c5 <alltraps>

80106d77 <vector156>:
80106d77:	6a 00                	push   $0x0
80106d79:	68 9c 00 00 00       	push   $0x9c
80106d7e:	e9 42 f5 ff ff       	jmp    801062c5 <alltraps>

80106d83 <vector157>:
80106d83:	6a 00                	push   $0x0
80106d85:	68 9d 00 00 00       	push   $0x9d
80106d8a:	e9 36 f5 ff ff       	jmp    801062c5 <alltraps>

80106d8f <vector158>:
80106d8f:	6a 00                	push   $0x0
80106d91:	68 9e 00 00 00       	push   $0x9e
80106d96:	e9 2a f5 ff ff       	jmp    801062c5 <alltraps>

80106d9b <vector159>:
80106d9b:	6a 00                	push   $0x0
80106d9d:	68 9f 00 00 00       	push   $0x9f
80106da2:	e9 1e f5 ff ff       	jmp    801062c5 <alltraps>

80106da7 <vector160>:
80106da7:	6a 00                	push   $0x0
80106da9:	68 a0 00 00 00       	push   $0xa0
80106dae:	e9 12 f5 ff ff       	jmp    801062c5 <alltraps>

80106db3 <vector161>:
80106db3:	6a 00                	push   $0x0
80106db5:	68 a1 00 00 00       	push   $0xa1
80106dba:	e9 06 f5 ff ff       	jmp    801062c5 <alltraps>

80106dbf <vector162>:
80106dbf:	6a 00                	push   $0x0
80106dc1:	68 a2 00 00 00       	push   $0xa2
80106dc6:	e9 fa f4 ff ff       	jmp    801062c5 <alltraps>

80106dcb <vector163>:
80106dcb:	6a 00                	push   $0x0
80106dcd:	68 a3 00 00 00       	push   $0xa3
80106dd2:	e9 ee f4 ff ff       	jmp    801062c5 <alltraps>

80106dd7 <vector164>:
80106dd7:	6a 00                	push   $0x0
80106dd9:	68 a4 00 00 00       	push   $0xa4
80106dde:	e9 e2 f4 ff ff       	jmp    801062c5 <alltraps>

80106de3 <vector165>:
80106de3:	6a 00                	push   $0x0
80106de5:	68 a5 00 00 00       	push   $0xa5
80106dea:	e9 d6 f4 ff ff       	jmp    801062c5 <alltraps>

80106def <vector166>:
80106def:	6a 00                	push   $0x0
80106df1:	68 a6 00 00 00       	push   $0xa6
80106df6:	e9 ca f4 ff ff       	jmp    801062c5 <alltraps>

80106dfb <vector167>:
80106dfb:	6a 00                	push   $0x0
80106dfd:	68 a7 00 00 00       	push   $0xa7
80106e02:	e9 be f4 ff ff       	jmp    801062c5 <alltraps>

80106e07 <vector168>:
80106e07:	6a 00                	push   $0x0
80106e09:	68 a8 00 00 00       	push   $0xa8
80106e0e:	e9 b2 f4 ff ff       	jmp    801062c5 <alltraps>

80106e13 <vector169>:
80106e13:	6a 00                	push   $0x0
80106e15:	68 a9 00 00 00       	push   $0xa9
80106e1a:	e9 a6 f4 ff ff       	jmp    801062c5 <alltraps>

80106e1f <vector170>:
80106e1f:	6a 00                	push   $0x0
80106e21:	68 aa 00 00 00       	push   $0xaa
80106e26:	e9 9a f4 ff ff       	jmp    801062c5 <alltraps>

80106e2b <vector171>:
80106e2b:	6a 00                	push   $0x0
80106e2d:	68 ab 00 00 00       	push   $0xab
80106e32:	e9 8e f4 ff ff       	jmp    801062c5 <alltraps>

80106e37 <vector172>:
80106e37:	6a 00                	push   $0x0
80106e39:	68 ac 00 00 00       	push   $0xac
80106e3e:	e9 82 f4 ff ff       	jmp    801062c5 <alltraps>

80106e43 <vector173>:
80106e43:	6a 00                	push   $0x0
80106e45:	68 ad 00 00 00       	push   $0xad
80106e4a:	e9 76 f4 ff ff       	jmp    801062c5 <alltraps>

80106e4f <vector174>:
80106e4f:	6a 00                	push   $0x0
80106e51:	68 ae 00 00 00       	push   $0xae
80106e56:	e9 6a f4 ff ff       	jmp    801062c5 <alltraps>

80106e5b <vector175>:
80106e5b:	6a 00                	push   $0x0
80106e5d:	68 af 00 00 00       	push   $0xaf
80106e62:	e9 5e f4 ff ff       	jmp    801062c5 <alltraps>

80106e67 <vector176>:
80106e67:	6a 00                	push   $0x0
80106e69:	68 b0 00 00 00       	push   $0xb0
80106e6e:	e9 52 f4 ff ff       	jmp    801062c5 <alltraps>

80106e73 <vector177>:
80106e73:	6a 00                	push   $0x0
80106e75:	68 b1 00 00 00       	push   $0xb1
80106e7a:	e9 46 f4 ff ff       	jmp    801062c5 <alltraps>

80106e7f <vector178>:
80106e7f:	6a 00                	push   $0x0
80106e81:	68 b2 00 00 00       	push   $0xb2
80106e86:	e9 3a f4 ff ff       	jmp    801062c5 <alltraps>

80106e8b <vector179>:
80106e8b:	6a 00                	push   $0x0
80106e8d:	68 b3 00 00 00       	push   $0xb3
80106e92:	e9 2e f4 ff ff       	jmp    801062c5 <alltraps>

80106e97 <vector180>:
80106e97:	6a 00                	push   $0x0
80106e99:	68 b4 00 00 00       	push   $0xb4
80106e9e:	e9 22 f4 ff ff       	jmp    801062c5 <alltraps>

80106ea3 <vector181>:
80106ea3:	6a 00                	push   $0x0
80106ea5:	68 b5 00 00 00       	push   $0xb5
80106eaa:	e9 16 f4 ff ff       	jmp    801062c5 <alltraps>

80106eaf <vector182>:
80106eaf:	6a 00                	push   $0x0
80106eb1:	68 b6 00 00 00       	push   $0xb6
80106eb6:	e9 0a f4 ff ff       	jmp    801062c5 <alltraps>

80106ebb <vector183>:
80106ebb:	6a 00                	push   $0x0
80106ebd:	68 b7 00 00 00       	push   $0xb7
80106ec2:	e9 fe f3 ff ff       	jmp    801062c5 <alltraps>

80106ec7 <vector184>:
80106ec7:	6a 00                	push   $0x0
80106ec9:	68 b8 00 00 00       	push   $0xb8
80106ece:	e9 f2 f3 ff ff       	jmp    801062c5 <alltraps>

80106ed3 <vector185>:
80106ed3:	6a 00                	push   $0x0
80106ed5:	68 b9 00 00 00       	push   $0xb9
80106eda:	e9 e6 f3 ff ff       	jmp    801062c5 <alltraps>

80106edf <vector186>:
80106edf:	6a 00                	push   $0x0
80106ee1:	68 ba 00 00 00       	push   $0xba
80106ee6:	e9 da f3 ff ff       	jmp    801062c5 <alltraps>

80106eeb <vector187>:
80106eeb:	6a 00                	push   $0x0
80106eed:	68 bb 00 00 00       	push   $0xbb
80106ef2:	e9 ce f3 ff ff       	jmp    801062c5 <alltraps>

80106ef7 <vector188>:
80106ef7:	6a 00                	push   $0x0
80106ef9:	68 bc 00 00 00       	push   $0xbc
80106efe:	e9 c2 f3 ff ff       	jmp    801062c5 <alltraps>

80106f03 <vector189>:
80106f03:	6a 00                	push   $0x0
80106f05:	68 bd 00 00 00       	push   $0xbd
80106f0a:	e9 b6 f3 ff ff       	jmp    801062c5 <alltraps>

80106f0f <vector190>:
80106f0f:	6a 00                	push   $0x0
80106f11:	68 be 00 00 00       	push   $0xbe
80106f16:	e9 aa f3 ff ff       	jmp    801062c5 <alltraps>

80106f1b <vector191>:
80106f1b:	6a 00                	push   $0x0
80106f1d:	68 bf 00 00 00       	push   $0xbf
80106f22:	e9 9e f3 ff ff       	jmp    801062c5 <alltraps>

80106f27 <vector192>:
80106f27:	6a 00                	push   $0x0
80106f29:	68 c0 00 00 00       	push   $0xc0
80106f2e:	e9 92 f3 ff ff       	jmp    801062c5 <alltraps>

80106f33 <vector193>:
80106f33:	6a 00                	push   $0x0
80106f35:	68 c1 00 00 00       	push   $0xc1
80106f3a:	e9 86 f3 ff ff       	jmp    801062c5 <alltraps>

80106f3f <vector194>:
80106f3f:	6a 00                	push   $0x0
80106f41:	68 c2 00 00 00       	push   $0xc2
80106f46:	e9 7a f3 ff ff       	jmp    801062c5 <alltraps>

80106f4b <vector195>:
80106f4b:	6a 00                	push   $0x0
80106f4d:	68 c3 00 00 00       	push   $0xc3
80106f52:	e9 6e f3 ff ff       	jmp    801062c5 <alltraps>

80106f57 <vector196>:
80106f57:	6a 00                	push   $0x0
80106f59:	68 c4 00 00 00       	push   $0xc4
80106f5e:	e9 62 f3 ff ff       	jmp    801062c5 <alltraps>

80106f63 <vector197>:
80106f63:	6a 00                	push   $0x0
80106f65:	68 c5 00 00 00       	push   $0xc5
80106f6a:	e9 56 f3 ff ff       	jmp    801062c5 <alltraps>

80106f6f <vector198>:
80106f6f:	6a 00                	push   $0x0
80106f71:	68 c6 00 00 00       	push   $0xc6
80106f76:	e9 4a f3 ff ff       	jmp    801062c5 <alltraps>

80106f7b <vector199>:
80106f7b:	6a 00                	push   $0x0
80106f7d:	68 c7 00 00 00       	push   $0xc7
80106f82:	e9 3e f3 ff ff       	jmp    801062c5 <alltraps>

80106f87 <vector200>:
80106f87:	6a 00                	push   $0x0
80106f89:	68 c8 00 00 00       	push   $0xc8
80106f8e:	e9 32 f3 ff ff       	jmp    801062c5 <alltraps>

80106f93 <vector201>:
80106f93:	6a 00                	push   $0x0
80106f95:	68 c9 00 00 00       	push   $0xc9
80106f9a:	e9 26 f3 ff ff       	jmp    801062c5 <alltraps>

80106f9f <vector202>:
80106f9f:	6a 00                	push   $0x0
80106fa1:	68 ca 00 00 00       	push   $0xca
80106fa6:	e9 1a f3 ff ff       	jmp    801062c5 <alltraps>

80106fab <vector203>:
80106fab:	6a 00                	push   $0x0
80106fad:	68 cb 00 00 00       	push   $0xcb
80106fb2:	e9 0e f3 ff ff       	jmp    801062c5 <alltraps>

80106fb7 <vector204>:
80106fb7:	6a 00                	push   $0x0
80106fb9:	68 cc 00 00 00       	push   $0xcc
80106fbe:	e9 02 f3 ff ff       	jmp    801062c5 <alltraps>

80106fc3 <vector205>:
80106fc3:	6a 00                	push   $0x0
80106fc5:	68 cd 00 00 00       	push   $0xcd
80106fca:	e9 f6 f2 ff ff       	jmp    801062c5 <alltraps>

80106fcf <vector206>:
80106fcf:	6a 00                	push   $0x0
80106fd1:	68 ce 00 00 00       	push   $0xce
80106fd6:	e9 ea f2 ff ff       	jmp    801062c5 <alltraps>

80106fdb <vector207>:
80106fdb:	6a 00                	push   $0x0
80106fdd:	68 cf 00 00 00       	push   $0xcf
80106fe2:	e9 de f2 ff ff       	jmp    801062c5 <alltraps>

80106fe7 <vector208>:
80106fe7:	6a 00                	push   $0x0
80106fe9:	68 d0 00 00 00       	push   $0xd0
80106fee:	e9 d2 f2 ff ff       	jmp    801062c5 <alltraps>

80106ff3 <vector209>:
80106ff3:	6a 00                	push   $0x0
80106ff5:	68 d1 00 00 00       	push   $0xd1
80106ffa:	e9 c6 f2 ff ff       	jmp    801062c5 <alltraps>

80106fff <vector210>:
80106fff:	6a 00                	push   $0x0
80107001:	68 d2 00 00 00       	push   $0xd2
80107006:	e9 ba f2 ff ff       	jmp    801062c5 <alltraps>

8010700b <vector211>:
8010700b:	6a 00                	push   $0x0
8010700d:	68 d3 00 00 00       	push   $0xd3
80107012:	e9 ae f2 ff ff       	jmp    801062c5 <alltraps>

80107017 <vector212>:
80107017:	6a 00                	push   $0x0
80107019:	68 d4 00 00 00       	push   $0xd4
8010701e:	e9 a2 f2 ff ff       	jmp    801062c5 <alltraps>

80107023 <vector213>:
80107023:	6a 00                	push   $0x0
80107025:	68 d5 00 00 00       	push   $0xd5
8010702a:	e9 96 f2 ff ff       	jmp    801062c5 <alltraps>

8010702f <vector214>:
8010702f:	6a 00                	push   $0x0
80107031:	68 d6 00 00 00       	push   $0xd6
80107036:	e9 8a f2 ff ff       	jmp    801062c5 <alltraps>

8010703b <vector215>:
8010703b:	6a 00                	push   $0x0
8010703d:	68 d7 00 00 00       	push   $0xd7
80107042:	e9 7e f2 ff ff       	jmp    801062c5 <alltraps>

80107047 <vector216>:
80107047:	6a 00                	push   $0x0
80107049:	68 d8 00 00 00       	push   $0xd8
8010704e:	e9 72 f2 ff ff       	jmp    801062c5 <alltraps>

80107053 <vector217>:
80107053:	6a 00                	push   $0x0
80107055:	68 d9 00 00 00       	push   $0xd9
8010705a:	e9 66 f2 ff ff       	jmp    801062c5 <alltraps>

8010705f <vector218>:
8010705f:	6a 00                	push   $0x0
80107061:	68 da 00 00 00       	push   $0xda
80107066:	e9 5a f2 ff ff       	jmp    801062c5 <alltraps>

8010706b <vector219>:
8010706b:	6a 00                	push   $0x0
8010706d:	68 db 00 00 00       	push   $0xdb
80107072:	e9 4e f2 ff ff       	jmp    801062c5 <alltraps>

80107077 <vector220>:
80107077:	6a 00                	push   $0x0
80107079:	68 dc 00 00 00       	push   $0xdc
8010707e:	e9 42 f2 ff ff       	jmp    801062c5 <alltraps>

80107083 <vector221>:
80107083:	6a 00                	push   $0x0
80107085:	68 dd 00 00 00       	push   $0xdd
8010708a:	e9 36 f2 ff ff       	jmp    801062c5 <alltraps>

8010708f <vector222>:
8010708f:	6a 00                	push   $0x0
80107091:	68 de 00 00 00       	push   $0xde
80107096:	e9 2a f2 ff ff       	jmp    801062c5 <alltraps>

8010709b <vector223>:
8010709b:	6a 00                	push   $0x0
8010709d:	68 df 00 00 00       	push   $0xdf
801070a2:	e9 1e f2 ff ff       	jmp    801062c5 <alltraps>

801070a7 <vector224>:
801070a7:	6a 00                	push   $0x0
801070a9:	68 e0 00 00 00       	push   $0xe0
801070ae:	e9 12 f2 ff ff       	jmp    801062c5 <alltraps>

801070b3 <vector225>:
801070b3:	6a 00                	push   $0x0
801070b5:	68 e1 00 00 00       	push   $0xe1
801070ba:	e9 06 f2 ff ff       	jmp    801062c5 <alltraps>

801070bf <vector226>:
801070bf:	6a 00                	push   $0x0
801070c1:	68 e2 00 00 00       	push   $0xe2
801070c6:	e9 fa f1 ff ff       	jmp    801062c5 <alltraps>

801070cb <vector227>:
801070cb:	6a 00                	push   $0x0
801070cd:	68 e3 00 00 00       	push   $0xe3
801070d2:	e9 ee f1 ff ff       	jmp    801062c5 <alltraps>

801070d7 <vector228>:
801070d7:	6a 00                	push   $0x0
801070d9:	68 e4 00 00 00       	push   $0xe4
801070de:	e9 e2 f1 ff ff       	jmp    801062c5 <alltraps>

801070e3 <vector229>:
801070e3:	6a 00                	push   $0x0
801070e5:	68 e5 00 00 00       	push   $0xe5
801070ea:	e9 d6 f1 ff ff       	jmp    801062c5 <alltraps>

801070ef <vector230>:
801070ef:	6a 00                	push   $0x0
801070f1:	68 e6 00 00 00       	push   $0xe6
801070f6:	e9 ca f1 ff ff       	jmp    801062c5 <alltraps>

801070fb <vector231>:
801070fb:	6a 00                	push   $0x0
801070fd:	68 e7 00 00 00       	push   $0xe7
80107102:	e9 be f1 ff ff       	jmp    801062c5 <alltraps>

80107107 <vector232>:
80107107:	6a 00                	push   $0x0
80107109:	68 e8 00 00 00       	push   $0xe8
8010710e:	e9 b2 f1 ff ff       	jmp    801062c5 <alltraps>

80107113 <vector233>:
80107113:	6a 00                	push   $0x0
80107115:	68 e9 00 00 00       	push   $0xe9
8010711a:	e9 a6 f1 ff ff       	jmp    801062c5 <alltraps>

8010711f <vector234>:
8010711f:	6a 00                	push   $0x0
80107121:	68 ea 00 00 00       	push   $0xea
80107126:	e9 9a f1 ff ff       	jmp    801062c5 <alltraps>

8010712b <vector235>:
8010712b:	6a 00                	push   $0x0
8010712d:	68 eb 00 00 00       	push   $0xeb
80107132:	e9 8e f1 ff ff       	jmp    801062c5 <alltraps>

80107137 <vector236>:
80107137:	6a 00                	push   $0x0
80107139:	68 ec 00 00 00       	push   $0xec
8010713e:	e9 82 f1 ff ff       	jmp    801062c5 <alltraps>

80107143 <vector237>:
80107143:	6a 00                	push   $0x0
80107145:	68 ed 00 00 00       	push   $0xed
8010714a:	e9 76 f1 ff ff       	jmp    801062c5 <alltraps>

8010714f <vector238>:
8010714f:	6a 00                	push   $0x0
80107151:	68 ee 00 00 00       	push   $0xee
80107156:	e9 6a f1 ff ff       	jmp    801062c5 <alltraps>

8010715b <vector239>:
8010715b:	6a 00                	push   $0x0
8010715d:	68 ef 00 00 00       	push   $0xef
80107162:	e9 5e f1 ff ff       	jmp    801062c5 <alltraps>

80107167 <vector240>:
80107167:	6a 00                	push   $0x0
80107169:	68 f0 00 00 00       	push   $0xf0
8010716e:	e9 52 f1 ff ff       	jmp    801062c5 <alltraps>

80107173 <vector241>:
80107173:	6a 00                	push   $0x0
80107175:	68 f1 00 00 00       	push   $0xf1
8010717a:	e9 46 f1 ff ff       	jmp    801062c5 <alltraps>

8010717f <vector242>:
8010717f:	6a 00                	push   $0x0
80107181:	68 f2 00 00 00       	push   $0xf2
80107186:	e9 3a f1 ff ff       	jmp    801062c5 <alltraps>

8010718b <vector243>:
8010718b:	6a 00                	push   $0x0
8010718d:	68 f3 00 00 00       	push   $0xf3
80107192:	e9 2e f1 ff ff       	jmp    801062c5 <alltraps>

80107197 <vector244>:
80107197:	6a 00                	push   $0x0
80107199:	68 f4 00 00 00       	push   $0xf4
8010719e:	e9 22 f1 ff ff       	jmp    801062c5 <alltraps>

801071a3 <vector245>:
801071a3:	6a 00                	push   $0x0
801071a5:	68 f5 00 00 00       	push   $0xf5
801071aa:	e9 16 f1 ff ff       	jmp    801062c5 <alltraps>

801071af <vector246>:
801071af:	6a 00                	push   $0x0
801071b1:	68 f6 00 00 00       	push   $0xf6
801071b6:	e9 0a f1 ff ff       	jmp    801062c5 <alltraps>

801071bb <vector247>:
801071bb:	6a 00                	push   $0x0
801071bd:	68 f7 00 00 00       	push   $0xf7
801071c2:	e9 fe f0 ff ff       	jmp    801062c5 <alltraps>

801071c7 <vector248>:
801071c7:	6a 00                	push   $0x0
801071c9:	68 f8 00 00 00       	push   $0xf8
801071ce:	e9 f2 f0 ff ff       	jmp    801062c5 <alltraps>

801071d3 <vector249>:
801071d3:	6a 00                	push   $0x0
801071d5:	68 f9 00 00 00       	push   $0xf9
801071da:	e9 e6 f0 ff ff       	jmp    801062c5 <alltraps>

801071df <vector250>:
801071df:	6a 00                	push   $0x0
801071e1:	68 fa 00 00 00       	push   $0xfa
801071e6:	e9 da f0 ff ff       	jmp    801062c5 <alltraps>

801071eb <vector251>:
801071eb:	6a 00                	push   $0x0
801071ed:	68 fb 00 00 00       	push   $0xfb
801071f2:	e9 ce f0 ff ff       	jmp    801062c5 <alltraps>

801071f7 <vector252>:
801071f7:	6a 00                	push   $0x0
801071f9:	68 fc 00 00 00       	push   $0xfc
801071fe:	e9 c2 f0 ff ff       	jmp    801062c5 <alltraps>

80107203 <vector253>:
80107203:	6a 00                	push   $0x0
80107205:	68 fd 00 00 00       	push   $0xfd
8010720a:	e9 b6 f0 ff ff       	jmp    801062c5 <alltraps>

8010720f <vector254>:
8010720f:	6a 00                	push   $0x0
80107211:	68 fe 00 00 00       	push   $0xfe
80107216:	e9 aa f0 ff ff       	jmp    801062c5 <alltraps>

8010721b <vector255>:
8010721b:	6a 00                	push   $0x0
8010721d:	68 ff 00 00 00       	push   $0xff
80107222:	e9 9e f0 ff ff       	jmp    801062c5 <alltraps>
80107227:	66 90                	xchg   %ax,%ax
80107229:	66 90                	xchg   %ax,%ax
8010722b:	66 90                	xchg   %ax,%ax
8010722d:	66 90                	xchg   %ax,%ax
8010722f:	90                   	nop

80107230 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80107230:	55                   	push   %ebp
80107231:	89 e5                	mov    %esp,%ebp
80107233:	57                   	push   %edi
80107234:	56                   	push   %esi
80107235:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80107236:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
8010723c:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80107242:	83 ec 1c             	sub    $0x1c,%esp
80107245:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  for(; a  < oldsz; a += PGSIZE){
80107248:	39 d3                	cmp    %edx,%ebx
8010724a:	73 49                	jae    80107295 <deallocuvm.part.0+0x65>
8010724c:	89 c7                	mov    %eax,%edi
8010724e:	eb 0c                	jmp    8010725c <deallocuvm.part.0+0x2c>
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
80107250:	83 c0 01             	add    $0x1,%eax
80107253:	c1 e0 16             	shl    $0x16,%eax
80107256:	89 c3                	mov    %eax,%ebx
  for(; a  < oldsz; a += PGSIZE){
80107258:	39 da                	cmp    %ebx,%edx
8010725a:	76 39                	jbe    80107295 <deallocuvm.part.0+0x65>
  pde = &pgdir[PDX(va)];
8010725c:	89 d8                	mov    %ebx,%eax
8010725e:	c1 e8 16             	shr    $0x16,%eax
  if(*pde & PTE_P){
80107261:	8b 0c 87             	mov    (%edi,%eax,4),%ecx
80107264:	f6 c1 01             	test   $0x1,%cl
80107267:	74 e7                	je     80107250 <deallocuvm.part.0+0x20>
  return &pgtab[PTX(va)];
80107269:	89 de                	mov    %ebx,%esi
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
8010726b:	81 e1 00 f0 ff ff    	and    $0xfffff000,%ecx
  return &pgtab[PTX(va)];
80107271:	c1 ee 0a             	shr    $0xa,%esi
80107274:	81 e6 fc 0f 00 00    	and    $0xffc,%esi
8010727a:	8d b4 31 00 00 00 80 	lea    -0x80000000(%ecx,%esi,1),%esi
    if(!pte)
80107281:	85 f6                	test   %esi,%esi
80107283:	74 cb                	je     80107250 <deallocuvm.part.0+0x20>
    else if((*pte & PTE_P) != 0){
80107285:	8b 06                	mov    (%esi),%eax
80107287:	a8 01                	test   $0x1,%al
80107289:	75 15                	jne    801072a0 <deallocuvm.part.0+0x70>
  for(; a  < oldsz; a += PGSIZE){
8010728b:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80107291:	39 da                	cmp    %ebx,%edx
80107293:	77 c7                	ja     8010725c <deallocuvm.part.0+0x2c>
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
}
80107295:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107298:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010729b:	5b                   	pop    %ebx
8010729c:	5e                   	pop    %esi
8010729d:	5f                   	pop    %edi
8010729e:	5d                   	pop    %ebp
8010729f:	c3                   	ret    
      if(pa == 0)
801072a0:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801072a5:	74 25                	je     801072cc <deallocuvm.part.0+0x9c>
      kfree(v);
801072a7:	83 ec 0c             	sub    $0xc,%esp
      char *v = P2V(pa);
801072aa:	05 00 00 00 80       	add    $0x80000000,%eax
801072af:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  for(; a  < oldsz; a += PGSIZE){
801072b2:	81 c3 00 10 00 00    	add    $0x1000,%ebx
      kfree(v);
801072b8:	50                   	push   %eax
801072b9:	e8 d2 b9 ff ff       	call   80102c90 <kfree>
      *pte = 0;
801072be:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
  for(; a  < oldsz; a += PGSIZE){
801072c4:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801072c7:	83 c4 10             	add    $0x10,%esp
801072ca:	eb 8c                	jmp    80107258 <deallocuvm.part.0+0x28>
        panic("kfree");
801072cc:	83 ec 0c             	sub    $0xc,%esp
801072cf:	68 de 7e 10 80       	push   $0x80107ede
801072d4:	e8 c7 90 ff ff       	call   801003a0 <panic>
801072d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801072e0 <mappages>:
{
801072e0:	55                   	push   %ebp
801072e1:	89 e5                	mov    %esp,%ebp
801072e3:	57                   	push   %edi
801072e4:	56                   	push   %esi
801072e5:	53                   	push   %ebx
  a = (char*)PGROUNDDOWN((uint)va);
801072e6:	89 d3                	mov    %edx,%ebx
801072e8:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
{
801072ee:	83 ec 1c             	sub    $0x1c,%esp
801072f1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
801072f4:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
801072f8:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801072fd:	89 45 dc             	mov    %eax,-0x24(%ebp)
80107300:	8b 45 08             	mov    0x8(%ebp),%eax
80107303:	29 d8                	sub    %ebx,%eax
80107305:	89 45 e0             	mov    %eax,-0x20(%ebp)
80107308:	eb 3d                	jmp    80107347 <mappages+0x67>
8010730a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return &pgtab[PTX(va)];
80107310:	89 da                	mov    %ebx,%edx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107312:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
80107317:	c1 ea 0a             	shr    $0xa,%edx
8010731a:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80107320:	8d 84 10 00 00 00 80 	lea    -0x80000000(%eax,%edx,1),%eax
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80107327:	85 c0                	test   %eax,%eax
80107329:	74 75                	je     801073a0 <mappages+0xc0>
    if(*pte & PTE_P)
8010732b:	f6 00 01             	testb  $0x1,(%eax)
8010732e:	0f 85 86 00 00 00    	jne    801073ba <mappages+0xda>
    *pte = pa | perm | PTE_P;
80107334:	0b 75 0c             	or     0xc(%ebp),%esi
80107337:	83 ce 01             	or     $0x1,%esi
8010733a:	89 30                	mov    %esi,(%eax)
    if(a == last)
8010733c:	3b 5d dc             	cmp    -0x24(%ebp),%ebx
8010733f:	74 6f                	je     801073b0 <mappages+0xd0>
    a += PGSIZE;
80107341:	81 c3 00 10 00 00    	add    $0x1000,%ebx
  for(;;){
80107347:	8b 45 e0             	mov    -0x20(%ebp),%eax
  pde = &pgdir[PDX(va)];
8010734a:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
8010734d:	8d 34 18             	lea    (%eax,%ebx,1),%esi
80107350:	89 d8                	mov    %ebx,%eax
80107352:	c1 e8 16             	shr    $0x16,%eax
80107355:	8d 3c 81             	lea    (%ecx,%eax,4),%edi
  if(*pde & PTE_P){
80107358:	8b 07                	mov    (%edi),%eax
8010735a:	a8 01                	test   $0x1,%al
8010735c:	75 b2                	jne    80107310 <mappages+0x30>
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
8010735e:	e8 ed ba ff ff       	call   80102e50 <kalloc>
80107363:	85 c0                	test   %eax,%eax
80107365:	74 39                	je     801073a0 <mappages+0xc0>
    memset(pgtab, 0, PGSIZE);
80107367:	83 ec 04             	sub    $0x4,%esp
8010736a:	89 45 d8             	mov    %eax,-0x28(%ebp)
8010736d:	68 00 10 00 00       	push   $0x1000
80107372:	6a 00                	push   $0x0
80107374:	50                   	push   %eax
80107375:	e8 b6 da ff ff       	call   80104e30 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
8010737a:	8b 55 d8             	mov    -0x28(%ebp),%edx
  return &pgtab[PTX(va)];
8010737d:	83 c4 10             	add    $0x10,%esp
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
80107380:	8d 82 00 00 00 80    	lea    -0x80000000(%edx),%eax
80107386:	83 c8 07             	or     $0x7,%eax
80107389:	89 07                	mov    %eax,(%edi)
  return &pgtab[PTX(va)];
8010738b:	89 d8                	mov    %ebx,%eax
8010738d:	c1 e8 0a             	shr    $0xa,%eax
80107390:	25 fc 0f 00 00       	and    $0xffc,%eax
80107395:	01 d0                	add    %edx,%eax
80107397:	eb 92                	jmp    8010732b <mappages+0x4b>
80107399:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
}
801073a0:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
801073a3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801073a8:	5b                   	pop    %ebx
801073a9:	5e                   	pop    %esi
801073aa:	5f                   	pop    %edi
801073ab:	5d                   	pop    %ebp
801073ac:	c3                   	ret    
801073ad:	8d 76 00             	lea    0x0(%esi),%esi
801073b0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801073b3:	31 c0                	xor    %eax,%eax
}
801073b5:	5b                   	pop    %ebx
801073b6:	5e                   	pop    %esi
801073b7:	5f                   	pop    %edi
801073b8:	5d                   	pop    %ebp
801073b9:	c3                   	ret    
      panic("remap");
801073ba:	83 ec 0c             	sub    $0xc,%esp
801073bd:	68 a8 85 10 80       	push   $0x801085a8
801073c2:	e8 d9 8f ff ff       	call   801003a0 <panic>
801073c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801073ce:	66 90                	xchg   %ax,%ax

801073d0 <seginit>:
{
801073d0:	55                   	push   %ebp
801073d1:	89 e5                	mov    %esp,%ebp
801073d3:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
801073d6:	e8 45 cd ff ff       	call   80104120 <cpuid>
  pd[0] = size - 1;
801073db:	ba 2f 00 00 00       	mov    $0x2f,%edx
801073e0:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
801073e6:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
801073ea:	c7 80 58 34 11 80 ff 	movl   $0xffff,-0x7feecba8(%eax)
801073f1:	ff 00 00 
801073f4:	c7 80 5c 34 11 80 00 	movl   $0xcf9a00,-0x7feecba4(%eax)
801073fb:	9a cf 00 
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
801073fe:	c7 80 60 34 11 80 ff 	movl   $0xffff,-0x7feecba0(%eax)
80107405:	ff 00 00 
80107408:	c7 80 64 34 11 80 00 	movl   $0xcf9200,-0x7feecb9c(%eax)
8010740f:	92 cf 00 
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80107412:	c7 80 68 34 11 80 ff 	movl   $0xffff,-0x7feecb98(%eax)
80107419:	ff 00 00 
8010741c:	c7 80 6c 34 11 80 00 	movl   $0xcffa00,-0x7feecb94(%eax)
80107423:	fa cf 00 
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80107426:	c7 80 70 34 11 80 ff 	movl   $0xffff,-0x7feecb90(%eax)
8010742d:	ff 00 00 
80107430:	c7 80 74 34 11 80 00 	movl   $0xcff200,-0x7feecb8c(%eax)
80107437:	f2 cf 00 
  lgdt(c->gdt, sizeof(c->gdt));
8010743a:	05 50 34 11 80       	add    $0x80113450,%eax
  pd[1] = (uint)p;
8010743f:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80107443:	c1 e8 10             	shr    $0x10,%eax
80107446:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r"(pd));
8010744a:	8d 45 f2             	lea    -0xe(%ebp),%eax
8010744d:	0f 01 10             	lgdtl  (%eax)
}
80107450:	c9                   	leave  
80107451:	c3                   	ret    
80107452:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107459:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107460 <switchkvm>:
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80107460:	a1 04 61 11 80       	mov    0x80116104,%eax
80107465:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r"(val));
8010746a:	0f 22 d8             	mov    %eax,%cr3
}
8010746d:	c3                   	ret    
8010746e:	66 90                	xchg   %ax,%ax

80107470 <switchuvm>:
{
80107470:	55                   	push   %ebp
80107471:	89 e5                	mov    %esp,%ebp
80107473:	57                   	push   %edi
80107474:	56                   	push   %esi
80107475:	53                   	push   %ebx
80107476:	83 ec 1c             	sub    $0x1c,%esp
80107479:	8b 75 08             	mov    0x8(%ebp),%esi
  if(p == 0)
8010747c:	85 f6                	test   %esi,%esi
8010747e:	0f 84 cb 00 00 00    	je     8010754f <switchuvm+0xdf>
  if(p->kstack == 0)
80107484:	8b 46 08             	mov    0x8(%esi),%eax
80107487:	85 c0                	test   %eax,%eax
80107489:	0f 84 da 00 00 00    	je     80107569 <switchuvm+0xf9>
  if(p->pgdir == 0)
8010748f:	8b 46 04             	mov    0x4(%esi),%eax
80107492:	85 c0                	test   %eax,%eax
80107494:	0f 84 c2 00 00 00    	je     8010755c <switchuvm+0xec>
  pushcli();
8010749a:	e8 81 d7 ff ff       	call   80104c20 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
8010749f:	e8 1c cc ff ff       	call   801040c0 <mycpu>
801074a4:	89 c3                	mov    %eax,%ebx
801074a6:	e8 15 cc ff ff       	call   801040c0 <mycpu>
801074ab:	89 c7                	mov    %eax,%edi
801074ad:	e8 0e cc ff ff       	call   801040c0 <mycpu>
801074b2:	83 c7 08             	add    $0x8,%edi
801074b5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801074b8:	e8 03 cc ff ff       	call   801040c0 <mycpu>
801074bd:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801074c0:	ba 67 00 00 00       	mov    $0x67,%edx
801074c5:	66 89 bb 9a 00 00 00 	mov    %di,0x9a(%ebx)
801074cc:	83 c0 08             	add    $0x8,%eax
801074cf:	66 89 93 98 00 00 00 	mov    %dx,0x98(%ebx)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
801074d6:	bf ff ff ff ff       	mov    $0xffffffff,%edi
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
801074db:	83 c1 08             	add    $0x8,%ecx
801074de:	c1 e8 18             	shr    $0x18,%eax
801074e1:	c1 e9 10             	shr    $0x10,%ecx
801074e4:	88 83 9f 00 00 00    	mov    %al,0x9f(%ebx)
801074ea:	88 8b 9c 00 00 00    	mov    %cl,0x9c(%ebx)
801074f0:	b9 99 40 00 00       	mov    $0x4099,%ecx
801074f5:	66 89 8b 9d 00 00 00 	mov    %cx,0x9d(%ebx)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
801074fc:	bb 10 00 00 00       	mov    $0x10,%ebx
  mycpu()->gdt[SEG_TSS].s = 0;
80107501:	e8 ba cb ff ff       	call   801040c0 <mycpu>
80107506:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
8010750d:	e8 ae cb ff ff       	call   801040c0 <mycpu>
80107512:	66 89 58 10          	mov    %bx,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
80107516:	8b 5e 08             	mov    0x8(%esi),%ebx
80107519:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010751f:	e8 9c cb ff ff       	call   801040c0 <mycpu>
80107524:	89 58 0c             	mov    %ebx,0xc(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80107527:	e8 94 cb ff ff       	call   801040c0 <mycpu>
8010752c:	66 89 78 6e          	mov    %di,0x6e(%eax)
  asm volatile("ltr %0" : : "r"(sel));
80107530:	b8 28 00 00 00       	mov    $0x28,%eax
80107535:	0f 00 d8             	ltr    %ax
  lcr3(V2P(p->pgdir));  // switch to process's address space
80107538:	8b 46 04             	mov    0x4(%esi),%eax
8010753b:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r"(val));
80107540:	0f 22 d8             	mov    %eax,%cr3
}
80107543:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107546:	5b                   	pop    %ebx
80107547:	5e                   	pop    %esi
80107548:	5f                   	pop    %edi
80107549:	5d                   	pop    %ebp
  popcli();
8010754a:	e9 21 d7 ff ff       	jmp    80104c70 <popcli>
    panic("switchuvm: no process");
8010754f:	83 ec 0c             	sub    $0xc,%esp
80107552:	68 ae 85 10 80       	push   $0x801085ae
80107557:	e8 44 8e ff ff       	call   801003a0 <panic>
    panic("switchuvm: no pgdir");
8010755c:	83 ec 0c             	sub    $0xc,%esp
8010755f:	68 d9 85 10 80       	push   $0x801085d9
80107564:	e8 37 8e ff ff       	call   801003a0 <panic>
    panic("switchuvm: no kstack");
80107569:	83 ec 0c             	sub    $0xc,%esp
8010756c:	68 c4 85 10 80       	push   $0x801085c4
80107571:	e8 2a 8e ff ff       	call   801003a0 <panic>
80107576:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010757d:	8d 76 00             	lea    0x0(%esi),%esi

80107580 <inituvm>:
{
80107580:	55                   	push   %ebp
80107581:	89 e5                	mov    %esp,%ebp
80107583:	57                   	push   %edi
80107584:	56                   	push   %esi
80107585:	53                   	push   %ebx
80107586:	83 ec 1c             	sub    $0x1c,%esp
80107589:	8b 45 0c             	mov    0xc(%ebp),%eax
8010758c:	8b 75 10             	mov    0x10(%ebp),%esi
8010758f:	8b 7d 08             	mov    0x8(%ebp),%edi
80107592:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(sz >= PGSIZE)
80107595:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
8010759b:	77 4b                	ja     801075e8 <inituvm+0x68>
  mem = kalloc();
8010759d:	e8 ae b8 ff ff       	call   80102e50 <kalloc>
  memset(mem, 0, PGSIZE);
801075a2:	83 ec 04             	sub    $0x4,%esp
801075a5:	68 00 10 00 00       	push   $0x1000
  mem = kalloc();
801075aa:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
801075ac:	6a 00                	push   $0x0
801075ae:	50                   	push   %eax
801075af:	e8 7c d8 ff ff       	call   80104e30 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
801075b4:	58                   	pop    %eax
801075b5:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801075bb:	5a                   	pop    %edx
801075bc:	6a 06                	push   $0x6
801075be:	b9 00 10 00 00       	mov    $0x1000,%ecx
801075c3:	31 d2                	xor    %edx,%edx
801075c5:	50                   	push   %eax
801075c6:	89 f8                	mov    %edi,%eax
801075c8:	e8 13 fd ff ff       	call   801072e0 <mappages>
  memmove(mem, init, sz);
801075cd:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801075d0:	89 75 10             	mov    %esi,0x10(%ebp)
801075d3:	83 c4 10             	add    $0x10,%esp
801075d6:	89 5d 08             	mov    %ebx,0x8(%ebp)
801075d9:	89 45 0c             	mov    %eax,0xc(%ebp)
}
801075dc:	8d 65 f4             	lea    -0xc(%ebp),%esp
801075df:	5b                   	pop    %ebx
801075e0:	5e                   	pop    %esi
801075e1:	5f                   	pop    %edi
801075e2:	5d                   	pop    %ebp
  memmove(mem, init, sz);
801075e3:	e9 e8 d8 ff ff       	jmp    80104ed0 <memmove>
    panic("inituvm: more than a page");
801075e8:	83 ec 0c             	sub    $0xc,%esp
801075eb:	68 ed 85 10 80       	push   $0x801085ed
801075f0:	e8 ab 8d ff ff       	call   801003a0 <panic>
801075f5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801075fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80107600 <loaduvm>:
{
80107600:	55                   	push   %ebp
80107601:	89 e5                	mov    %esp,%ebp
80107603:	57                   	push   %edi
80107604:	56                   	push   %esi
80107605:	53                   	push   %ebx
80107606:	83 ec 1c             	sub    $0x1c,%esp
80107609:	8b 45 0c             	mov    0xc(%ebp),%eax
8010760c:	8b 75 18             	mov    0x18(%ebp),%esi
  if((uint) addr % PGSIZE != 0)
8010760f:	a9 ff 0f 00 00       	test   $0xfff,%eax
80107614:	0f 85 bb 00 00 00    	jne    801076d5 <loaduvm+0xd5>
  for(i = 0; i < sz; i += PGSIZE){
8010761a:	01 f0                	add    %esi,%eax
8010761c:	89 f3                	mov    %esi,%ebx
8010761e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(readi(ip, P2V(pa), offset+i, n) != n)
80107621:	8b 45 14             	mov    0x14(%ebp),%eax
80107624:	01 f0                	add    %esi,%eax
80107626:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(i = 0; i < sz; i += PGSIZE){
80107629:	85 f6                	test   %esi,%esi
8010762b:	0f 84 87 00 00 00    	je     801076b8 <loaduvm+0xb8>
80107631:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  pde = &pgdir[PDX(va)];
80107638:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  if(*pde & PTE_P){
8010763b:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010763e:	29 d8                	sub    %ebx,%eax
  pde = &pgdir[PDX(va)];
80107640:	89 c2                	mov    %eax,%edx
80107642:	c1 ea 16             	shr    $0x16,%edx
  if(*pde & PTE_P){
80107645:	8b 14 91             	mov    (%ecx,%edx,4),%edx
80107648:	f6 c2 01             	test   $0x1,%dl
8010764b:	75 13                	jne    80107660 <loaduvm+0x60>
      panic("loaduvm: address should exist");
8010764d:	83 ec 0c             	sub    $0xc,%esp
80107650:	68 07 86 10 80       	push   $0x80108607
80107655:	e8 46 8d ff ff       	call   801003a0 <panic>
8010765a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return &pgtab[PTX(va)];
80107660:	c1 e8 0a             	shr    $0xa,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107663:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  return &pgtab[PTX(va)];
80107669:	25 fc 0f 00 00       	and    $0xffc,%eax
8010766e:	8d 84 02 00 00 00 80 	lea    -0x80000000(%edx,%eax,1),%eax
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80107675:	85 c0                	test   %eax,%eax
80107677:	74 d4                	je     8010764d <loaduvm+0x4d>
    pa = PTE_ADDR(*pte);
80107679:	8b 00                	mov    (%eax),%eax
    if(readi(ip, P2V(pa), offset+i, n) != n)
8010767b:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    if(sz - i < PGSIZE)
8010767e:	bf 00 10 00 00       	mov    $0x1000,%edi
    pa = PTE_ADDR(*pte);
80107683:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
80107688:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
8010768e:	0f 46 fb             	cmovbe %ebx,%edi
    if(readi(ip, P2V(pa), offset+i, n) != n)
80107691:	29 d9                	sub    %ebx,%ecx
80107693:	05 00 00 00 80       	add    $0x80000000,%eax
80107698:	57                   	push   %edi
80107699:	51                   	push   %ecx
8010769a:	50                   	push   %eax
8010769b:	ff 75 10             	push   0x10(%ebp)
8010769e:	e8 bd ab ff ff       	call   80102260 <readi>
801076a3:	83 c4 10             	add    $0x10,%esp
801076a6:	39 f8                	cmp    %edi,%eax
801076a8:	75 1e                	jne    801076c8 <loaduvm+0xc8>
  for(i = 0; i < sz; i += PGSIZE){
801076aa:	81 eb 00 10 00 00    	sub    $0x1000,%ebx
801076b0:	89 f0                	mov    %esi,%eax
801076b2:	29 d8                	sub    %ebx,%eax
801076b4:	39 c6                	cmp    %eax,%esi
801076b6:	77 80                	ja     80107638 <loaduvm+0x38>
}
801076b8:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801076bb:	31 c0                	xor    %eax,%eax
}
801076bd:	5b                   	pop    %ebx
801076be:	5e                   	pop    %esi
801076bf:	5f                   	pop    %edi
801076c0:	5d                   	pop    %ebp
801076c1:	c3                   	ret    
801076c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801076c8:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
801076cb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801076d0:	5b                   	pop    %ebx
801076d1:	5e                   	pop    %esi
801076d2:	5f                   	pop    %edi
801076d3:	5d                   	pop    %ebp
801076d4:	c3                   	ret    
    panic("loaduvm: addr must be page aligned");
801076d5:	83 ec 0c             	sub    $0xc,%esp
801076d8:	68 a8 86 10 80       	push   $0x801086a8
801076dd:	e8 be 8c ff ff       	call   801003a0 <panic>
801076e2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801076e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801076f0 <allocuvm>:
{
801076f0:	55                   	push   %ebp
801076f1:	89 e5                	mov    %esp,%ebp
801076f3:	57                   	push   %edi
801076f4:	56                   	push   %esi
801076f5:	53                   	push   %ebx
801076f6:	83 ec 1c             	sub    $0x1c,%esp
  if(newsz >= KERNBASE)
801076f9:	8b 45 10             	mov    0x10(%ebp),%eax
{
801076fc:	8b 7d 08             	mov    0x8(%ebp),%edi
  if(newsz >= KERNBASE)
801076ff:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107702:	85 c0                	test   %eax,%eax
80107704:	0f 88 b6 00 00 00    	js     801077c0 <allocuvm+0xd0>
  if(newsz < oldsz)
8010770a:	3b 45 0c             	cmp    0xc(%ebp),%eax
    return oldsz;
8010770d:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(newsz < oldsz)
80107710:	0f 82 9a 00 00 00    	jb     801077b0 <allocuvm+0xc0>
  a = PGROUNDUP(oldsz);
80107716:	8d b0 ff 0f 00 00    	lea    0xfff(%eax),%esi
8010771c:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
  for(; a < newsz; a += PGSIZE){
80107722:	39 75 10             	cmp    %esi,0x10(%ebp)
80107725:	77 44                	ja     8010776b <allocuvm+0x7b>
80107727:	e9 87 00 00 00       	jmp    801077b3 <allocuvm+0xc3>
8010772c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    memset(mem, 0, PGSIZE);
80107730:	83 ec 04             	sub    $0x4,%esp
80107733:	68 00 10 00 00       	push   $0x1000
80107738:	6a 00                	push   $0x0
8010773a:	50                   	push   %eax
8010773b:	e8 f0 d6 ff ff       	call   80104e30 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80107740:	58                   	pop    %eax
80107741:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80107747:	5a                   	pop    %edx
80107748:	6a 06                	push   $0x6
8010774a:	b9 00 10 00 00       	mov    $0x1000,%ecx
8010774f:	89 f2                	mov    %esi,%edx
80107751:	50                   	push   %eax
80107752:	89 f8                	mov    %edi,%eax
80107754:	e8 87 fb ff ff       	call   801072e0 <mappages>
80107759:	83 c4 10             	add    $0x10,%esp
8010775c:	85 c0                	test   %eax,%eax
8010775e:	78 78                	js     801077d8 <allocuvm+0xe8>
  for(; a < newsz; a += PGSIZE){
80107760:	81 c6 00 10 00 00    	add    $0x1000,%esi
80107766:	39 75 10             	cmp    %esi,0x10(%ebp)
80107769:	76 48                	jbe    801077b3 <allocuvm+0xc3>
    mem = kalloc();
8010776b:	e8 e0 b6 ff ff       	call   80102e50 <kalloc>
80107770:	89 c3                	mov    %eax,%ebx
    if(mem == 0){
80107772:	85 c0                	test   %eax,%eax
80107774:	75 ba                	jne    80107730 <allocuvm+0x40>
      cprintf("allocuvm out of memory\n");
80107776:	83 ec 0c             	sub    $0xc,%esp
80107779:	68 25 86 10 80       	push   $0x80108625
8010777e:	e8 cd 8f ff ff       	call   80100750 <cprintf>
  if(newsz >= oldsz)
80107783:	8b 45 0c             	mov    0xc(%ebp),%eax
80107786:	83 c4 10             	add    $0x10,%esp
80107789:	39 45 10             	cmp    %eax,0x10(%ebp)
8010778c:	74 32                	je     801077c0 <allocuvm+0xd0>
8010778e:	8b 55 10             	mov    0x10(%ebp),%edx
80107791:	89 c1                	mov    %eax,%ecx
80107793:	89 f8                	mov    %edi,%eax
80107795:	e8 96 fa ff ff       	call   80107230 <deallocuvm.part.0>
      return 0;
8010779a:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
}
801077a1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801077a4:	8d 65 f4             	lea    -0xc(%ebp),%esp
801077a7:	5b                   	pop    %ebx
801077a8:	5e                   	pop    %esi
801077a9:	5f                   	pop    %edi
801077aa:	5d                   	pop    %ebp
801077ab:	c3                   	ret    
801077ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return oldsz;
801077b0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
}
801077b3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801077b6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801077b9:	5b                   	pop    %ebx
801077ba:	5e                   	pop    %esi
801077bb:	5f                   	pop    %edi
801077bc:	5d                   	pop    %ebp
801077bd:	c3                   	ret    
801077be:	66 90                	xchg   %ax,%ax
    return 0;
801077c0:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
}
801077c7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801077ca:	8d 65 f4             	lea    -0xc(%ebp),%esp
801077cd:	5b                   	pop    %ebx
801077ce:	5e                   	pop    %esi
801077cf:	5f                   	pop    %edi
801077d0:	5d                   	pop    %ebp
801077d1:	c3                   	ret    
801077d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      cprintf("allocuvm out of memory (2)\n");
801077d8:	83 ec 0c             	sub    $0xc,%esp
801077db:	68 3d 86 10 80       	push   $0x8010863d
801077e0:	e8 6b 8f ff ff       	call   80100750 <cprintf>
  if(newsz >= oldsz)
801077e5:	8b 45 0c             	mov    0xc(%ebp),%eax
801077e8:	83 c4 10             	add    $0x10,%esp
801077eb:	39 45 10             	cmp    %eax,0x10(%ebp)
801077ee:	74 0c                	je     801077fc <allocuvm+0x10c>
801077f0:	8b 55 10             	mov    0x10(%ebp),%edx
801077f3:	89 c1                	mov    %eax,%ecx
801077f5:	89 f8                	mov    %edi,%eax
801077f7:	e8 34 fa ff ff       	call   80107230 <deallocuvm.part.0>
      kfree(mem);
801077fc:	83 ec 0c             	sub    $0xc,%esp
801077ff:	53                   	push   %ebx
80107800:	e8 8b b4 ff ff       	call   80102c90 <kfree>
      return 0;
80107805:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
8010780c:	83 c4 10             	add    $0x10,%esp
}
8010780f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107812:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107815:	5b                   	pop    %ebx
80107816:	5e                   	pop    %esi
80107817:	5f                   	pop    %edi
80107818:	5d                   	pop    %ebp
80107819:	c3                   	ret    
8010781a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107820 <deallocuvm>:
{
80107820:	55                   	push   %ebp
80107821:	89 e5                	mov    %esp,%ebp
80107823:	8b 55 0c             	mov    0xc(%ebp),%edx
80107826:	8b 4d 10             	mov    0x10(%ebp),%ecx
80107829:	8b 45 08             	mov    0x8(%ebp),%eax
  if(newsz >= oldsz)
8010782c:	39 d1                	cmp    %edx,%ecx
8010782e:	73 10                	jae    80107840 <deallocuvm+0x20>
}
80107830:	5d                   	pop    %ebp
80107831:	e9 fa f9 ff ff       	jmp    80107230 <deallocuvm.part.0>
80107836:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010783d:	8d 76 00             	lea    0x0(%esi),%esi
80107840:	89 d0                	mov    %edx,%eax
80107842:	5d                   	pop    %ebp
80107843:	c3                   	ret    
80107844:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010784b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010784f:	90                   	nop

80107850 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80107850:	55                   	push   %ebp
80107851:	89 e5                	mov    %esp,%ebp
80107853:	57                   	push   %edi
80107854:	56                   	push   %esi
80107855:	53                   	push   %ebx
80107856:	83 ec 0c             	sub    $0xc,%esp
80107859:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
8010785c:	85 f6                	test   %esi,%esi
8010785e:	74 59                	je     801078b9 <freevm+0x69>
  if(newsz >= oldsz)
80107860:	31 c9                	xor    %ecx,%ecx
80107862:	ba 00 00 00 80       	mov    $0x80000000,%edx
80107867:	89 f0                	mov    %esi,%eax
80107869:	89 f3                	mov    %esi,%ebx
8010786b:	e8 c0 f9 ff ff       	call   80107230 <deallocuvm.part.0>
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80107870:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
80107876:	eb 0f                	jmp    80107887 <freevm+0x37>
80107878:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010787f:	90                   	nop
80107880:	83 c3 04             	add    $0x4,%ebx
80107883:	39 df                	cmp    %ebx,%edi
80107885:	74 23                	je     801078aa <freevm+0x5a>
    if(pgdir[i] & PTE_P){
80107887:	8b 03                	mov    (%ebx),%eax
80107889:	a8 01                	test   $0x1,%al
8010788b:	74 f3                	je     80107880 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
8010788d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
      kfree(v);
80107892:	83 ec 0c             	sub    $0xc,%esp
  for(i = 0; i < NPDENTRIES; i++){
80107895:	83 c3 04             	add    $0x4,%ebx
      char * v = P2V(PTE_ADDR(pgdir[i]));
80107898:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
8010789d:	50                   	push   %eax
8010789e:	e8 ed b3 ff ff       	call   80102c90 <kfree>
801078a3:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
801078a6:	39 df                	cmp    %ebx,%edi
801078a8:	75 dd                	jne    80107887 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
801078aa:	89 75 08             	mov    %esi,0x8(%ebp)
}
801078ad:	8d 65 f4             	lea    -0xc(%ebp),%esp
801078b0:	5b                   	pop    %ebx
801078b1:	5e                   	pop    %esi
801078b2:	5f                   	pop    %edi
801078b3:	5d                   	pop    %ebp
  kfree((char*)pgdir);
801078b4:	e9 d7 b3 ff ff       	jmp    80102c90 <kfree>
    panic("freevm: no pgdir");
801078b9:	83 ec 0c             	sub    $0xc,%esp
801078bc:	68 59 86 10 80       	push   $0x80108659
801078c1:	e8 da 8a ff ff       	call   801003a0 <panic>
801078c6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801078cd:	8d 76 00             	lea    0x0(%esi),%esi

801078d0 <setupkvm>:
{
801078d0:	55                   	push   %ebp
801078d1:	89 e5                	mov    %esp,%ebp
801078d3:	56                   	push   %esi
801078d4:	53                   	push   %ebx
  if((pgdir = (pde_t*)kalloc()) == 0)
801078d5:	e8 76 b5 ff ff       	call   80102e50 <kalloc>
801078da:	89 c6                	mov    %eax,%esi
801078dc:	85 c0                	test   %eax,%eax
801078de:	74 42                	je     80107922 <setupkvm+0x52>
  memset(pgdir, 0, PGSIZE);
801078e0:	83 ec 04             	sub    $0x4,%esp
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
801078e3:	bb 20 b4 10 80       	mov    $0x8010b420,%ebx
  memset(pgdir, 0, PGSIZE);
801078e8:	68 00 10 00 00       	push   $0x1000
801078ed:	6a 00                	push   $0x0
801078ef:	50                   	push   %eax
801078f0:	e8 3b d5 ff ff       	call   80104e30 <memset>
801078f5:	83 c4 10             	add    $0x10,%esp
                (uint)k->phys_start, k->perm) < 0) {
801078f8:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
801078fb:	83 ec 08             	sub    $0x8,%esp
801078fe:	8b 4b 08             	mov    0x8(%ebx),%ecx
80107901:	ff 73 0c             	push   0xc(%ebx)
80107904:	8b 13                	mov    (%ebx),%edx
80107906:	50                   	push   %eax
80107907:	29 c1                	sub    %eax,%ecx
80107909:	89 f0                	mov    %esi,%eax
8010790b:	e8 d0 f9 ff ff       	call   801072e0 <mappages>
80107910:	83 c4 10             	add    $0x10,%esp
80107913:	85 c0                	test   %eax,%eax
80107915:	78 19                	js     80107930 <setupkvm+0x60>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107917:	83 c3 10             	add    $0x10,%ebx
8010791a:	81 fb 60 b4 10 80    	cmp    $0x8010b460,%ebx
80107920:	75 d6                	jne    801078f8 <setupkvm+0x28>
}
80107922:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107925:	89 f0                	mov    %esi,%eax
80107927:	5b                   	pop    %ebx
80107928:	5e                   	pop    %esi
80107929:	5d                   	pop    %ebp
8010792a:	c3                   	ret    
8010792b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010792f:	90                   	nop
      freevm(pgdir);
80107930:	83 ec 0c             	sub    $0xc,%esp
80107933:	56                   	push   %esi
      return 0;
80107934:	31 f6                	xor    %esi,%esi
      freevm(pgdir);
80107936:	e8 15 ff ff ff       	call   80107850 <freevm>
      return 0;
8010793b:	83 c4 10             	add    $0x10,%esp
}
8010793e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107941:	89 f0                	mov    %esi,%eax
80107943:	5b                   	pop    %ebx
80107944:	5e                   	pop    %esi
80107945:	5d                   	pop    %ebp
80107946:	c3                   	ret    
80107947:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010794e:	66 90                	xchg   %ax,%ax

80107950 <kvmalloc>:
{
80107950:	55                   	push   %ebp
80107951:	89 e5                	mov    %esp,%ebp
80107953:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80107956:	e8 75 ff ff ff       	call   801078d0 <setupkvm>
8010795b:	a3 04 61 11 80       	mov    %eax,0x80116104
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80107960:	05 00 00 00 80       	add    $0x80000000,%eax
80107965:	0f 22 d8             	mov    %eax,%cr3
}
80107968:	c9                   	leave  
80107969:	c3                   	ret    
8010796a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107970 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80107970:	55                   	push   %ebp
80107971:	89 e5                	mov    %esp,%ebp
80107973:	83 ec 08             	sub    $0x8,%esp
80107976:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(*pde & PTE_P){
80107979:	8b 55 08             	mov    0x8(%ebp),%edx
  pde = &pgdir[PDX(va)];
8010797c:	89 c1                	mov    %eax,%ecx
8010797e:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
80107981:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
80107984:	f6 c2 01             	test   $0x1,%dl
80107987:	75 17                	jne    801079a0 <clearpteu+0x30>
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
  if(pte == 0)
    panic("clearpteu");
80107989:	83 ec 0c             	sub    $0xc,%esp
8010798c:	68 6a 86 10 80       	push   $0x8010866a
80107991:	e8 0a 8a ff ff       	call   801003a0 <panic>
80107996:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010799d:	8d 76 00             	lea    0x0(%esi),%esi
  return &pgtab[PTX(va)];
801079a0:	c1 e8 0a             	shr    $0xa,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
801079a3:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  return &pgtab[PTX(va)];
801079a9:	25 fc 0f 00 00       	and    $0xffc,%eax
801079ae:	8d 84 02 00 00 00 80 	lea    -0x80000000(%edx,%eax,1),%eax
  if(pte == 0)
801079b5:	85 c0                	test   %eax,%eax
801079b7:	74 d0                	je     80107989 <clearpteu+0x19>
  *pte &= ~PTE_U;
801079b9:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
801079bc:	c9                   	leave  
801079bd:	c3                   	ret    
801079be:	66 90                	xchg   %ax,%ax

801079c0 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
801079c0:	55                   	push   %ebp
801079c1:	89 e5                	mov    %esp,%ebp
801079c3:	57                   	push   %edi
801079c4:	56                   	push   %esi
801079c5:	53                   	push   %ebx
801079c6:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
801079c9:	e8 02 ff ff ff       	call   801078d0 <setupkvm>
801079ce:	89 45 e0             	mov    %eax,-0x20(%ebp)
801079d1:	85 c0                	test   %eax,%eax
801079d3:	0f 84 bd 00 00 00    	je     80107a96 <copyuvm+0xd6>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
801079d9:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801079dc:	85 c9                	test   %ecx,%ecx
801079de:	0f 84 b2 00 00 00    	je     80107a96 <copyuvm+0xd6>
801079e4:	31 f6                	xor    %esi,%esi
801079e6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801079ed:	8d 76 00             	lea    0x0(%esi),%esi
  if(*pde & PTE_P){
801079f0:	8b 4d 08             	mov    0x8(%ebp),%ecx
  pde = &pgdir[PDX(va)];
801079f3:	89 f0                	mov    %esi,%eax
801079f5:	c1 e8 16             	shr    $0x16,%eax
  if(*pde & PTE_P){
801079f8:	8b 04 81             	mov    (%ecx,%eax,4),%eax
801079fb:	a8 01                	test   $0x1,%al
801079fd:	75 11                	jne    80107a10 <copyuvm+0x50>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
801079ff:	83 ec 0c             	sub    $0xc,%esp
80107a02:	68 74 86 10 80       	push   $0x80108674
80107a07:	e8 94 89 ff ff       	call   801003a0 <panic>
80107a0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  return &pgtab[PTX(va)];
80107a10:	89 f2                	mov    %esi,%edx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107a12:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
80107a17:	c1 ea 0a             	shr    $0xa,%edx
80107a1a:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80107a20:	8d 84 10 00 00 00 80 	lea    -0x80000000(%eax,%edx,1),%eax
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80107a27:	85 c0                	test   %eax,%eax
80107a29:	74 d4                	je     801079ff <copyuvm+0x3f>
    if(!(*pte & PTE_P))
80107a2b:	8b 00                	mov    (%eax),%eax
80107a2d:	a8 01                	test   $0x1,%al
80107a2f:	0f 84 9f 00 00 00    	je     80107ad4 <copyuvm+0x114>
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
80107a35:	89 c7                	mov    %eax,%edi
    flags = PTE_FLAGS(*pte);
80107a37:	25 ff 0f 00 00       	and    $0xfff,%eax
80107a3c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    pa = PTE_ADDR(*pte);
80107a3f:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
    if((mem = kalloc()) == 0)
80107a45:	e8 06 b4 ff ff       	call   80102e50 <kalloc>
80107a4a:	89 c3                	mov    %eax,%ebx
80107a4c:	85 c0                	test   %eax,%eax
80107a4e:	74 64                	je     80107ab4 <copyuvm+0xf4>
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80107a50:	83 ec 04             	sub    $0x4,%esp
80107a53:	81 c7 00 00 00 80    	add    $0x80000000,%edi
80107a59:	68 00 10 00 00       	push   $0x1000
80107a5e:	57                   	push   %edi
80107a5f:	50                   	push   %eax
80107a60:	e8 6b d4 ff ff       	call   80104ed0 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
80107a65:	58                   	pop    %eax
80107a66:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80107a6c:	5a                   	pop    %edx
80107a6d:	ff 75 e4             	push   -0x1c(%ebp)
80107a70:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107a75:	89 f2                	mov    %esi,%edx
80107a77:	50                   	push   %eax
80107a78:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107a7b:	e8 60 f8 ff ff       	call   801072e0 <mappages>
80107a80:	83 c4 10             	add    $0x10,%esp
80107a83:	85 c0                	test   %eax,%eax
80107a85:	78 21                	js     80107aa8 <copyuvm+0xe8>
  for(i = 0; i < sz; i += PGSIZE){
80107a87:	81 c6 00 10 00 00    	add    $0x1000,%esi
80107a8d:	39 75 0c             	cmp    %esi,0xc(%ebp)
80107a90:	0f 87 5a ff ff ff    	ja     801079f0 <copyuvm+0x30>
  return d;

bad:
  freevm(d);
  return 0;
}
80107a96:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107a99:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107a9c:	5b                   	pop    %ebx
80107a9d:	5e                   	pop    %esi
80107a9e:	5f                   	pop    %edi
80107a9f:	5d                   	pop    %ebp
80107aa0:	c3                   	ret    
80107aa1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      kfree(mem);
80107aa8:	83 ec 0c             	sub    $0xc,%esp
80107aab:	53                   	push   %ebx
80107aac:	e8 df b1 ff ff       	call   80102c90 <kfree>
      goto bad;
80107ab1:	83 c4 10             	add    $0x10,%esp
  freevm(d);
80107ab4:	83 ec 0c             	sub    $0xc,%esp
80107ab7:	ff 75 e0             	push   -0x20(%ebp)
80107aba:	e8 91 fd ff ff       	call   80107850 <freevm>
  return 0;
80107abf:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
80107ac6:	83 c4 10             	add    $0x10,%esp
}
80107ac9:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107acc:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107acf:	5b                   	pop    %ebx
80107ad0:	5e                   	pop    %esi
80107ad1:	5f                   	pop    %edi
80107ad2:	5d                   	pop    %ebp
80107ad3:	c3                   	ret    
      panic("copyuvm: page not present");
80107ad4:	83 ec 0c             	sub    $0xc,%esp
80107ad7:	68 8e 86 10 80       	push   $0x8010868e
80107adc:	e8 bf 88 ff ff       	call   801003a0 <panic>
80107ae1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107ae8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107aef:	90                   	nop

80107af0 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80107af0:	55                   	push   %ebp
80107af1:	89 e5                	mov    %esp,%ebp
80107af3:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(*pde & PTE_P){
80107af6:	8b 55 08             	mov    0x8(%ebp),%edx
  pde = &pgdir[PDX(va)];
80107af9:	89 c1                	mov    %eax,%ecx
80107afb:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
80107afe:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
80107b01:	f6 c2 01             	test   $0x1,%dl
80107b04:	0f 84 00 01 00 00    	je     80107c0a <uva2ka.cold>
  return &pgtab[PTX(va)];
80107b0a:	c1 e8 0c             	shr    $0xc,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107b0d:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  if((*pte & PTE_P) == 0)
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
}
80107b13:	5d                   	pop    %ebp
  return &pgtab[PTX(va)];
80107b14:	25 ff 03 00 00       	and    $0x3ff,%eax
  if((*pte & PTE_P) == 0)
80107b19:	8b 84 82 00 00 00 80 	mov    -0x80000000(%edx,%eax,4),%eax
  if((*pte & PTE_U) == 0)
80107b20:	89 c2                	mov    %eax,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80107b22:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((*pte & PTE_U) == 0)
80107b27:	83 e2 05             	and    $0x5,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80107b2a:	05 00 00 00 80       	add    $0x80000000,%eax
80107b2f:	83 fa 05             	cmp    $0x5,%edx
80107b32:	ba 00 00 00 00       	mov    $0x0,%edx
80107b37:	0f 45 c2             	cmovne %edx,%eax
}
80107b3a:	c3                   	ret    
80107b3b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107b3f:	90                   	nop

80107b40 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80107b40:	55                   	push   %ebp
80107b41:	89 e5                	mov    %esp,%ebp
80107b43:	57                   	push   %edi
80107b44:	56                   	push   %esi
80107b45:	53                   	push   %ebx
80107b46:	83 ec 0c             	sub    $0xc,%esp
80107b49:	8b 75 14             	mov    0x14(%ebp),%esi
80107b4c:	8b 45 0c             	mov    0xc(%ebp),%eax
80107b4f:	8b 55 10             	mov    0x10(%ebp),%edx
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80107b52:	85 f6                	test   %esi,%esi
80107b54:	75 51                	jne    80107ba7 <copyout+0x67>
80107b56:	e9 a5 00 00 00       	jmp    80107c00 <copyout+0xc0>
80107b5b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107b5f:	90                   	nop
  return (char*)P2V(PTE_ADDR(*pte));
80107b60:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
80107b66:	8d 8b 00 00 00 80    	lea    -0x80000000(%ebx),%ecx
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
80107b6c:	81 fb 00 00 00 80    	cmp    $0x80000000,%ebx
80107b72:	74 75                	je     80107be9 <copyout+0xa9>
      return -1;
    n = PGSIZE - (va - va0);
80107b74:	89 fb                	mov    %edi,%ebx
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80107b76:	89 55 10             	mov    %edx,0x10(%ebp)
    n = PGSIZE - (va - va0);
80107b79:	29 c3                	sub    %eax,%ebx
80107b7b:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80107b81:	39 f3                	cmp    %esi,%ebx
80107b83:	0f 47 de             	cmova  %esi,%ebx
    memmove(pa0 + (va - va0), buf, n);
80107b86:	29 f8                	sub    %edi,%eax
80107b88:	83 ec 04             	sub    $0x4,%esp
80107b8b:	01 c1                	add    %eax,%ecx
80107b8d:	53                   	push   %ebx
80107b8e:	52                   	push   %edx
80107b8f:	51                   	push   %ecx
80107b90:	e8 3b d3 ff ff       	call   80104ed0 <memmove>
    len -= n;
    buf += n;
80107b95:	8b 55 10             	mov    0x10(%ebp),%edx
    va = va0 + PGSIZE;
80107b98:	8d 87 00 10 00 00    	lea    0x1000(%edi),%eax
  while(len > 0){
80107b9e:	83 c4 10             	add    $0x10,%esp
    buf += n;
80107ba1:	01 da                	add    %ebx,%edx
  while(len > 0){
80107ba3:	29 de                	sub    %ebx,%esi
80107ba5:	74 59                	je     80107c00 <copyout+0xc0>
  if(*pde & PTE_P){
80107ba7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pde = &pgdir[PDX(va)];
80107baa:	89 c1                	mov    %eax,%ecx
    va0 = (uint)PGROUNDDOWN(va);
80107bac:	89 c7                	mov    %eax,%edi
  pde = &pgdir[PDX(va)];
80107bae:	c1 e9 16             	shr    $0x16,%ecx
    va0 = (uint)PGROUNDDOWN(va);
80107bb1:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
  if(*pde & PTE_P){
80107bb7:	8b 0c 8b             	mov    (%ebx,%ecx,4),%ecx
80107bba:	f6 c1 01             	test   $0x1,%cl
80107bbd:	0f 84 4e 00 00 00    	je     80107c11 <copyout.cold>
  return &pgtab[PTX(va)];
80107bc3:	89 fb                	mov    %edi,%ebx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107bc5:	81 e1 00 f0 ff ff    	and    $0xfffff000,%ecx
  return &pgtab[PTX(va)];
80107bcb:	c1 eb 0c             	shr    $0xc,%ebx
80107bce:	81 e3 ff 03 00 00    	and    $0x3ff,%ebx
  if((*pte & PTE_P) == 0)
80107bd4:	8b 9c 99 00 00 00 80 	mov    -0x80000000(%ecx,%ebx,4),%ebx
  if((*pte & PTE_U) == 0)
80107bdb:	89 d9                	mov    %ebx,%ecx
80107bdd:	83 e1 05             	and    $0x5,%ecx
80107be0:	83 f9 05             	cmp    $0x5,%ecx
80107be3:	0f 84 77 ff ff ff    	je     80107b60 <copyout+0x20>
  }
  return 0;
}
80107be9:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80107bec:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107bf1:	5b                   	pop    %ebx
80107bf2:	5e                   	pop    %esi
80107bf3:	5f                   	pop    %edi
80107bf4:	5d                   	pop    %ebp
80107bf5:	c3                   	ret    
80107bf6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107bfd:	8d 76 00             	lea    0x0(%esi),%esi
80107c00:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80107c03:	31 c0                	xor    %eax,%eax
}
80107c05:	5b                   	pop    %ebx
80107c06:	5e                   	pop    %esi
80107c07:	5f                   	pop    %edi
80107c08:	5d                   	pop    %ebp
80107c09:	c3                   	ret    

80107c0a <uva2ka.cold>:
  if((*pte & PTE_P) == 0)
80107c0a:	a1 00 00 00 00       	mov    0x0,%eax
80107c0f:	0f 0b                	ud2    

80107c11 <copyout.cold>:
80107c11:	a1 00 00 00 00       	mov    0x0,%eax
80107c16:	0f 0b                	ud2    
