
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
8010002d:	b8 f0 37 10 80       	mov    $0x801037f0,%eax
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
8010004c:	68 20 79 10 80       	push   $0x80107920
80100051:	68 20 b5 10 80       	push   $0x8010b520
80100056:	e8 05 4b 00 00       	call   80104b60 <initlock>
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
80100092:	68 27 79 10 80       	push   $0x80107927
80100097:	50                   	push   %eax
80100098:	e8 93 49 00 00       	call   80104a30 <initsleeplock>
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
801000e4:	e8 47 4c 00 00       	call   80104d30 <acquire>
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
80100162:	e8 69 4b 00 00       	call   80104cd0 <release>
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 fe 48 00 00       	call   80104a70 <acquiresleep>
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
8010018c:	e8 df 28 00 00       	call   80102a70 <iderw>
80100191:	83 c4 10             	add    $0x10,%esp
80100194:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100197:	89 d8                	mov    %ebx,%eax
80100199:	5b                   	pop    %ebx
8010019a:	5e                   	pop    %esi
8010019b:	5f                   	pop    %edi
8010019c:	5d                   	pop    %ebp
8010019d:	c3                   	ret    
8010019e:	83 ec 0c             	sub    $0xc,%esp
801001a1:	68 2e 79 10 80       	push   $0x8010792e
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
801001be:	e8 4d 49 00 00       	call   80104b10 <holdingsleep>
801001c3:	83 c4 10             	add    $0x10,%esp
801001c6:	85 c0                	test   %eax,%eax
801001c8:	74 0f                	je     801001d9 <bwrite+0x29>
801001ca:	83 0b 04             	orl    $0x4,(%ebx)
801001cd:	89 5d 08             	mov    %ebx,0x8(%ebp)
801001d0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801001d3:	c9                   	leave  
801001d4:	e9 97 28 00 00       	jmp    80102a70 <iderw>
801001d9:	83 ec 0c             	sub    $0xc,%esp
801001dc:	68 3f 79 10 80       	push   $0x8010793f
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
801001ff:	e8 0c 49 00 00       	call   80104b10 <holdingsleep>
80100204:	83 c4 10             	add    $0x10,%esp
80100207:	85 c0                	test   %eax,%eax
80100209:	74 66                	je     80100271 <brelse+0x81>
8010020b:	83 ec 0c             	sub    $0xc,%esp
8010020e:	56                   	push   %esi
8010020f:	e8 bc 48 00 00       	call   80104ad0 <releasesleep>
80100214:	c7 04 24 20 b5 10 80 	movl   $0x8010b520,(%esp)
8010021b:	e8 10 4b 00 00       	call   80104d30 <acquire>
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
8010026c:	e9 5f 4a 00 00       	jmp    80104cd0 <release>
80100271:	83 ec 0c             	sub    $0xc,%esp
80100274:	68 46 79 10 80       	push   $0x80107946
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
80100297:	e8 54 1d 00 00       	call   80101ff0 <iunlock>
  acquire(&cons.lock);
8010029c:	c7 04 24 60 0b 11 80 	movl   $0x80110b60,(%esp)
  target = n;
801002a3:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
  acquire(&cons.lock);
801002a6:	e8 85 4a 00 00       	call   80104d30 <acquire>
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
801002dd:	e8 ee 44 00 00       	call   801047d0 <sleep>
    while (input.r == input.w)
801002e2:	8b 0d d0 fe 10 80    	mov    0x8010fed0,%ecx
801002e8:	83 c4 10             	add    $0x10,%esp
801002eb:	3b 0d d4 fe 10 80    	cmp    0x8010fed4,%ecx
801002f1:	75 35                	jne    80100328 <consoleread+0xa8>
      if (myproc()->killed)
801002f3:	e8 08 3e 00 00       	call   80104100 <myproc>
801002f8:	8b 48 24             	mov    0x24(%eax),%ecx
801002fb:	85 c9                	test   %ecx,%ecx
801002fd:	74 d1                	je     801002d0 <consoleread+0x50>
        release(&cons.lock);
801002ff:	83 ec 0c             	sub    $0xc,%esp
80100302:	68 60 0b 11 80       	push   $0x80110b60
80100307:	e8 c4 49 00 00       	call   80104cd0 <release>
        ilock(ip);
8010030c:	5a                   	pop    %edx
8010030d:	ff 75 08             	push   0x8(%ebp)
80100310:	e8 fb 1b 00 00       	call   80101f10 <ilock>
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
80100368:	e8 63 49 00 00       	call   80104cd0 <release>
  ilock(ip);
8010036d:	58                   	pop    %eax
8010036e:	ff 75 08             	push   0x8(%ebp)
80100371:	e8 9a 1b 00 00       	call   80101f10 <ilock>
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
801003b9:	e8 c2 2c 00 00       	call   80103080 <lapicid>
801003be:	83 ec 08             	sub    $0x8,%esp
801003c1:	50                   	push   %eax
801003c2:	68 4d 79 10 80       	push   $0x8010794d
801003c7:	e8 84 03 00 00       	call   80100750 <cprintf>
  cprintf(s);
801003cc:	58                   	pop    %eax
801003cd:	ff 75 08             	push   0x8(%ebp)
801003d0:	e8 7b 03 00 00       	call   80100750 <cprintf>
  cprintf("\n");
801003d5:	c7 04 24 d7 82 10 80 	movl   $0x801082d7,(%esp)
801003dc:	e8 6f 03 00 00       	call   80100750 <cprintf>
  getcallerpcs(&s, pcs);
801003e1:	8d 45 08             	lea    0x8(%ebp),%eax
801003e4:	5a                   	pop    %edx
801003e5:	59                   	pop    %ecx
801003e6:	53                   	push   %ebx
801003e7:	50                   	push   %eax
801003e8:	e8 93 47 00 00       	call   80104b80 <getcallerpcs>
  for (i = 0; i < 10; i++)
801003ed:	83 c4 10             	add    $0x10,%esp
    cprintf(" %p", pcs[i]);
801003f0:	83 ec 08             	sub    $0x8,%esp
801003f3:	ff 33                	push   (%ebx)
  for (i = 0; i < 10; i++)
801003f5:	83 c3 04             	add    $0x4,%ebx
    cprintf(" %p", pcs[i]);
801003f8:	68 61 79 10 80       	push   $0x80107961
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
801004fc:	e8 8f 49 00 00       	call   80104e90 <memmove>
    memset(crt + pos, 0, sizeof(crt[0]) * (24 * 80 - pos));
80100501:	b8 80 07 00 00       	mov    $0x780,%eax
80100506:	83 c4 0c             	add    $0xc,%esp
80100509:	29 d8                	sub    %ebx,%eax
8010050b:	01 c0                	add    %eax,%eax
8010050d:	50                   	push   %eax
8010050e:	8d 84 1b 00 80 0b 80 	lea    -0x7ff48000(%ebx,%ebx,1),%eax
80100515:	6a 00                	push   $0x0
80100517:	50                   	push   %eax
80100518:	e8 d3 48 00 00       	call   80104df0 <memset>
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
801005f1:	e8 9a 48 00 00       	call   80104e90 <memmove>
    memset(crt + pos, 0, sizeof(crt[0]) * (25 * 80 - pos));
801005f6:	83 c4 0c             	add    $0xc,%esp
801005f9:	68 9c 0f 00 00       	push   $0xf9c
801005fe:	6a 00                	push   $0x0
80100600:	68 04 80 0b 80       	push   $0x800b8004
80100605:	e8 e6 47 00 00       	call   80104df0 <memset>
8010060a:	83 c4 10             	add    $0x10,%esp
8010060d:	e9 0e ff ff ff       	jmp    80100520 <cgaputc+0x100>
    panic("pos under/overflow");
80100612:	83 ec 0c             	sub    $0xc,%esp
80100615:	68 65 79 10 80       	push   $0x80107965
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
8010062f:	e8 bc 19 00 00       	call   80101ff0 <iunlock>
  acquire(&cons.lock);
80100634:	c7 04 24 60 0b 11 80 	movl   $0x80110b60,(%esp)
8010063b:	e8 f0 46 00 00       	call   80104d30 <acquire>
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
8010066a:	e8 d1 5d 00 00       	call   80106440 <uartputc>
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
80100686:	e8 45 46 00 00       	call   80104cd0 <release>
  ilock(ip);
8010068b:	58                   	pop    %eax
8010068c:	ff 75 08             	push   0x8(%ebp)
8010068f:	e8 7c 18 00 00       	call   80101f10 <ilock>

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
801006d6:	0f b6 92 e8 79 10 80 	movzbl -0x7fef8618(%edx),%edx
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
80100717:	e8 24 5d 00 00       	call   80106440 <uartputc>
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
80100805:	bf 78 79 10 80       	mov    $0x80107978,%edi
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
8010087a:	e8 c1 5b 00 00       	call   80106440 <uartputc>
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
801008a8:	e8 83 44 00 00       	call   80104d30 <acquire>
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
801008c7:	e8 74 5b 00 00       	call   80106440 <uartputc>
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
80100908:	e8 33 5b 00 00       	call   80106440 <uartputc>
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
80100953:	e8 e8 5a 00 00       	call   80106440 <uartputc>
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
8010097f:	e8 bc 5a 00 00       	call   80106440 <uartputc>
  cgaputc(c);
80100984:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100987:	e8 94 fa ff ff       	call   80100420 <cgaputc>
}
8010098c:	83 c4 10             	add    $0x10,%esp
8010098f:	e9 37 fe ff ff       	jmp    801007cb <cprintf+0x7b>
    release(&cons.lock);
80100994:	83 ec 0c             	sub    $0xc,%esp
80100997:	68 60 0b 11 80       	push   $0x80110b60
8010099c:	e8 2f 43 00 00       	call   80104cd0 <release>
801009a1:	83 c4 10             	add    $0x10,%esp
}
801009a4:	e9 38 fe ff ff       	jmp    801007e1 <cprintf+0x91>
      if ((s = (char *)*argp++) == 0)
801009a9:	8b 7d e0             	mov    -0x20(%ebp),%edi
801009ac:	e9 1a fe ff ff       	jmp    801007cb <cprintf+0x7b>
    panic("null fmt");
801009b1:	83 ec 0c             	sub    $0xc,%esp
801009b4:	68 7f 79 10 80       	push   $0x8010797f
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
80100b35:	e8 06 59 00 00       	call   80106440 <uartputc>
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
80100bbd:	e8 7e 58 00 00       	call   80106440 <uartputc>
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
80100c1b:	e8 d0 41 00 00       	call   80104df0 <memset>
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
80100c7c:	e8 bf 57 00 00       	call   80106440 <uartputc>
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
80100d2f:	e8 bc 40 00 00       	call   80104df0 <memset>
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
80100df5:	e9 96 3a 00 00       	jmp    80104890 <wakeup>
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
80100e23:	e8 08 3f 00 00       	call   80104d30 <acquire>
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
80100e46:	ff 24 9d 90 79 10 80 	jmp    *-0x7fef8670(,%ebx,4)
80100e4d:	8d 76 00             	lea    0x0(%esi),%esi
80100e50:	81 fb e2 00 00 00    	cmp    $0xe2,%ebx
80100e56:	0f 84 e4 01 00 00    	je     80101040 <consoleintr+0x230>
80100e5c:	81 fb e3 00 00 00    	cmp    $0xe3,%ebx
80100e62:	75 24                	jne    80100e88 <consoleintr+0x78>
      if (current > 0)
80100e64:	a1 00 90 10 80       	mov    0x80109000,%eax
80100e69:	85 c0                	test   %eax,%eax
80100e6b:	0f 8f 39 02 00 00    	jg     801010aa <consoleintr+0x29a>
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
80100ea8:	e8 23 3e 00 00       	call   80104cd0 <release>
  if (doprocdump)
80100ead:	83 c4 10             	add    $0x10,%esp
80100eb0:	85 ff                	test   %edi,%edi
80100eb2:	0f 85 04 02 00 00    	jne    801010bc <consoleintr+0x2ac>
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
80100ee4:	0f 84 fc 01 00 00    	je     801010e6 <consoleintr+0x2d6>
  if (panicked)
80100eea:	85 c0                	test   %eax,%eax
80100eec:	0f 85 19 02 00 00    	jne    8010110b <consoleintr+0x2fb>
  if (c == BACKSPACE)
80100ef2:	81 fb 00 01 00 00    	cmp    $0x100,%ebx
80100ef8:	0f 84 b0 02 00 00    	je     801011ae <consoleintr+0x39e>
        if (c == '\n' || c == C('D') || input.e == input.r + INPUT_BUF - 1)
80100efe:	83 fb 0a             	cmp    $0xa,%ebx
80100f01:	0f 94 c2             	sete   %dl
80100f04:	83 fb 04             	cmp    $0x4,%ebx
80100f07:	0f 94 c0             	sete   %al
80100f0a:	09 c2                	or     %eax,%edx
80100f0c:	88 55 e4             	mov    %dl,-0x1c(%ebp)
  else if (c < BACKSPACE)
80100f0f:	81 fb ff 00 00 00    	cmp    $0xff,%ebx
80100f15:	0f 8e af 02 00 00    	jle    801011ca <consoleintr+0x3ba>
  cgaputc(c);
80100f1b:	89 d8                	mov    %ebx,%eax
80100f1d:	e8 fe f4 ff ff       	call   80100420 <cgaputc>
        if (c == '\n' || c == C('D') || input.e == input.r + INPUT_BUF - 1)
80100f22:	a1 d0 fe 10 80       	mov    0x8010fed0,%eax
80100f27:	8b 0d d8 fe 10 80    	mov    0x8010fed8,%ecx
80100f2d:	83 c0 4d             	add    $0x4d,%eax
80100f30:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80100f33:	39 c1                	cmp    %eax,%ecx
80100f35:	0f 85 d5 01 00 00    	jne    80101110 <consoleintr+0x300>
          SubmitCommand(c);
80100f3b:	83 ec 0c             	sub    $0xc,%esp
80100f3e:	53                   	push   %ebx
80100f3f:	e8 6c fd ff ff       	call   80100cb0 <SubmitCommand>
80100f44:	83 c4 10             	add    $0x10,%esp
80100f47:	e9 df fe ff ff       	jmp    80100e2b <consoleintr+0x1b>
  cgaputc(c);
80100f4c:	b8 01 01 00 00       	mov    $0x101,%eax
80100f51:	e8 ca f4 ff ff       	call   80100420 <cgaputc>
  return input.e - input.w;
80100f56:	a1 d8 fe 10 80       	mov    0x8010fed8,%eax
80100f5b:	89 c2                	mov    %eax,%edx
80100f5d:	2b 15 d4 fe 10 80    	sub    0x8010fed4,%edx
  while (currentIndex() > 0)
80100f63:	85 d2                	test   %edx,%edx
80100f65:	0f 8e c0 fe ff ff    	jle    80100e2b <consoleintr+0x1b>
    input.e--;
80100f6b:	83 e8 01             	sub    $0x1,%eax
80100f6e:	a3 d8 fe 10 80       	mov    %eax,0x8010fed8
  if (panicked)
80100f73:	a1 98 0b 11 80       	mov    0x80110b98,%eax
80100f78:	85 c0                	test   %eax,%eax
80100f7a:	74 d0                	je     80100f4c <consoleintr+0x13c>
80100f7c:	fa                   	cli    
    for (;;)
80100f7d:	eb fe                	jmp    80100f7d <consoleintr+0x16d>
80100f7f:	90                   	nop
      KillLine();
80100f80:	e8 db fb ff ff       	call   80100b60 <KillLine>
      break;
80100f85:	e9 a1 fe ff ff       	jmp    80100e2b <consoleintr+0x1b>
      input.e = input.w;
80100f8a:	a1 d4 fe 10 80       	mov    0x8010fed4,%eax
  if (panicked)
80100f8f:	8b 0d 98 0b 11 80    	mov    0x80110b98,%ecx
      input.e = input.w;
80100f95:	a3 d8 fe 10 80       	mov    %eax,0x8010fed8
  if (panicked)
80100f9a:	85 c9                	test   %ecx,%ecx
80100f9c:	0f 84 f9 00 00 00    	je     8010109b <consoleintr+0x28b>
80100fa2:	fa                   	cli    
    for (;;)
80100fa3:	eb fe                	jmp    80100fa3 <consoleintr+0x193>
80100fa5:	8d 76 00             	lea    0x0(%esi),%esi
  return input.e - input.w;
80100fa8:	a1 d8 fe 10 80       	mov    0x8010fed8,%eax
80100fad:	89 c2                	mov    %eax,%edx
80100faf:	2b 15 d4 fe 10 80    	sub    0x8010fed4,%edx
      if (currentIndex() < lineLength) //
80100fb5:	39 15 54 0b 11 80    	cmp    %edx,0x80110b54
80100fbb:	0f 8e 6a fe ff ff    	jle    80100e2b <consoleintr+0x1b>
        input.e++;
80100fc1:	83 c0 01             	add    $0x1,%eax
80100fc4:	a3 d8 fe 10 80       	mov    %eax,0x8010fed8
  if (panicked)
80100fc9:	a1 98 0b 11 80       	mov    0x80110b98,%eax
80100fce:	85 c0                	test   %eax,%eax
80100fd0:	0f 84 01 01 00 00    	je     801010d7 <consoleintr+0x2c7>
80100fd6:	fa                   	cli    
    for (;;)
80100fd7:	eb fe                	jmp    80100fd7 <consoleintr+0x1c7>
80100fd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return input.e - input.w;
80100fe0:	a1 d8 fe 10 80       	mov    0x8010fed8,%eax
80100fe5:	89 c2                	mov    %eax,%edx
80100fe7:	2b 15 d4 fe 10 80    	sub    0x8010fed4,%edx
  while (currentIndex() < lineLength)
80100fed:	39 15 54 0b 11 80    	cmp    %edx,0x80110b54
80100ff3:	0f 8e 32 fe ff ff    	jle    80100e2b <consoleintr+0x1b>
  if (panicked)
80100ff9:	8b 1d 98 0b 11 80    	mov    0x80110b98,%ebx
    input.e++;
80100fff:	83 c0 01             	add    $0x1,%eax
80101002:	a3 d8 fe 10 80       	mov    %eax,0x8010fed8
  if (panicked)
80101007:	85 db                	test   %ebx,%ebx
80101009:	74 5e                	je     80101069 <consoleintr+0x259>
8010100b:	fa                   	cli    
    for (;;)
8010100c:	eb fe                	jmp    8010100c <consoleintr+0x1fc>
8010100e:	66 90                	xchg   %ax,%ax
  return input.e - input.w;
80101010:	a1 d8 fe 10 80       	mov    0x8010fed8,%eax
80101015:	89 c2                	mov    %eax,%edx
80101017:	2b 15 d4 fe 10 80    	sub    0x8010fed4,%edx
      if (currentIndex() > 0) //
8010101d:	85 d2                	test   %edx,%edx
8010101f:	0f 8e 06 fe ff ff    	jle    80100e2b <consoleintr+0x1b>
  if (panicked)
80101025:	8b 15 98 0b 11 80    	mov    0x80110b98,%edx
        input.e--;
8010102b:	83 e8 01             	sub    $0x1,%eax
8010102e:	a3 d8 fe 10 80       	mov    %eax,0x8010fed8
  if (panicked)
80101033:	85 d2                	test   %edx,%edx
80101035:	0f 84 8d 00 00 00    	je     801010c8 <consoleintr+0x2b8>
8010103b:	fa                   	cli    
    for (;;)
8010103c:	eb fe                	jmp    8010103c <consoleintr+0x22c>
8010103e:	66 90                	xchg   %ax,%ax
      if (current < maxCommands - 1)
80101040:	a1 50 0b 11 80       	mov    0x80110b50,%eax
80101045:	8b 15 00 90 10 80    	mov    0x80109000,%edx
8010104b:	83 e8 01             	sub    $0x1,%eax
8010104e:	39 d0                	cmp    %edx,%eax
80101050:	0f 8e d5 fd ff ff    	jle    80100e2b <consoleintr+0x1b>
        current++;
80101056:	83 c2 01             	add    $0x1,%edx
80101059:	89 15 00 90 10 80    	mov    %edx,0x80109000
        Change();
8010105f:	e8 8c fb ff ff       	call   80100bf0 <Change>
80101064:	e9 c2 fd ff ff       	jmp    80100e2b <consoleintr+0x1b>
  cgaputc(c);
80101069:	b8 02 01 00 00       	mov    $0x102,%eax
8010106e:	e8 ad f3 ff ff       	call   80100420 <cgaputc>
  return input.e - input.w;
80101073:	a1 d8 fe 10 80       	mov    0x8010fed8,%eax
80101078:	89 c2                	mov    %eax,%edx
8010107a:	2b 15 d4 fe 10 80    	sub    0x8010fed4,%edx
  while (currentIndex() < lineLength)
80101080:	3b 15 54 0b 11 80    	cmp    0x80110b54,%edx
80101086:	0f 8c 6d ff ff ff    	jl     80100ff9 <consoleintr+0x1e9>
8010108c:	e9 9a fd ff ff       	jmp    80100e2b <consoleintr+0x1b>
    switch (c)
80101091:	bf 01 00 00 00       	mov    $0x1,%edi
80101096:	e9 90 fd ff ff       	jmp    80100e2b <consoleintr+0x1b>
  cgaputc(c);
8010109b:	b8 03 01 00 00       	mov    $0x103,%eax
801010a0:	e8 7b f3 ff ff       	call   80100420 <cgaputc>
}
801010a5:	e9 81 fd ff ff       	jmp    80100e2b <consoleintr+0x1b>
        current--;
801010aa:	83 e8 01             	sub    $0x1,%eax
801010ad:	a3 00 90 10 80       	mov    %eax,0x80109000
        Change();
801010b2:	e8 39 fb ff ff       	call   80100bf0 <Change>
801010b7:	e9 6f fd ff ff       	jmp    80100e2b <consoleintr+0x1b>
}
801010bc:	8d 65 f4             	lea    -0xc(%ebp),%esp
801010bf:	5b                   	pop    %ebx
801010c0:	5e                   	pop    %esi
801010c1:	5f                   	pop    %edi
801010c2:	5d                   	pop    %ebp
    procdump(); // now call procdump() wo. cons.lock held
801010c3:	e9 a8 38 00 00       	jmp    80104970 <procdump>
  cgaputc(c);
801010c8:	b8 01 01 00 00       	mov    $0x101,%eax
801010cd:	e8 4e f3 ff ff       	call   80100420 <cgaputc>
}
801010d2:	e9 54 fd ff ff       	jmp    80100e2b <consoleintr+0x1b>
  cgaputc(c);
801010d7:	b8 02 01 00 00       	mov    $0x102,%eax
801010dc:	e8 3f f3 ff ff       	call   80100420 <cgaputc>
}
801010e1:	e9 45 fd ff ff       	jmp    80100e2b <consoleintr+0x1b>
  if (panicked)
801010e6:	85 c0                	test   %eax,%eax
801010e8:	75 21                	jne    8010110b <consoleintr+0x2fb>
    uartputc(c);
801010ea:	83 ec 0c             	sub    $0xc,%esp
        c = (c == '\r') ? '\n' : c;
801010ed:	bb 0a 00 00 00       	mov    $0xa,%ebx
    uartputc(c);
801010f2:	6a 0a                	push   $0xa
801010f4:	e8 47 53 00 00       	call   80106440 <uartputc>
  cgaputc(c);
801010f9:	b8 0a 00 00 00       	mov    $0xa,%eax
801010fe:	e8 1d f3 ff ff       	call   80100420 <cgaputc>
80101103:	83 c4 10             	add    $0x10,%esp
80101106:	e9 30 fe ff ff       	jmp    80100f3b <consoleintr+0x12b>
8010110b:	fa                   	cli    
    for (;;)
8010110c:	eb fe                	jmp    8010110c <consoleintr+0x2fc>
8010110e:	66 90                	xchg   %ax,%ax
          lineLength++;
80101110:	a1 54 0b 11 80       	mov    0x80110b54,%eax
80101115:	83 c0 01             	add    $0x1,%eax
80101118:	a3 54 0b 11 80       	mov    %eax,0x80110b54
          for (int i = input.w + lineLength; i > input.e; i--)
8010111d:	03 05 d4 fe 10 80    	add    0x8010fed4,%eax
80101123:	89 c1                	mov    %eax,%ecx
80101125:	39 45 e4             	cmp    %eax,-0x1c(%ebp)
80101128:	73 59                	jae    80101183 <consoleintr+0x373>
8010112a:	89 7d e0             	mov    %edi,-0x20(%ebp)
8010112d:	89 5d dc             	mov    %ebx,-0x24(%ebp)
            input.buf[i % INPUT_BUF] = input.buf[(i - 1) % INPUT_BUF];
80101130:	89 cb                	mov    %ecx,%ebx
80101132:	b8 d3 20 0d d2       	mov    $0xd20d20d3,%eax
80101137:	83 e9 01             	sub    $0x1,%ecx
8010113a:	f7 e9                	imul   %ecx
8010113c:	89 cf                	mov    %ecx,%edi
8010113e:	c1 ff 1f             	sar    $0x1f,%edi
80101141:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
80101144:	89 ca                	mov    %ecx,%edx
80101146:	c1 f8 06             	sar    $0x6,%eax
80101149:	29 f8                	sub    %edi,%eax
8010114b:	6b c0 4e             	imul   $0x4e,%eax,%eax
8010114e:	29 c2                	sub    %eax,%edx
80101150:	b8 d3 20 0d d2       	mov    $0xd20d20d3,%eax
80101155:	0f b6 ba 80 fe 10 80 	movzbl -0x7fef0180(%edx),%edi
8010115c:	f7 eb                	imul   %ebx
8010115e:	8d 04 1a             	lea    (%edx,%ebx,1),%eax
80101161:	89 da                	mov    %ebx,%edx
80101163:	c1 f8 06             	sar    $0x6,%eax
80101166:	c1 fa 1f             	sar    $0x1f,%edx
80101169:	29 d0                	sub    %edx,%eax
8010116b:	6b c0 4e             	imul   $0x4e,%eax,%eax
8010116e:	29 c3                	sub    %eax,%ebx
80101170:	89 f8                	mov    %edi,%eax
80101172:	88 83 80 fe 10 80    	mov    %al,-0x7fef0180(%ebx)
          for (int i = input.w + lineLength; i > input.e; i--)
80101178:	39 4d e4             	cmp    %ecx,-0x1c(%ebp)
8010117b:	72 b3                	jb     80101130 <consoleintr+0x320>
8010117d:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101180:	8b 5d dc             	mov    -0x24(%ebp),%ebx
          input.buf[input.e++ % INPUT_BUF] = c;
80101183:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80101186:	8d 41 01             	lea    0x1(%ecx),%eax
80101189:	89 ca                	mov    %ecx,%edx
8010118b:	a3 d8 fe 10 80       	mov    %eax,0x8010fed8
80101190:	d1 ea                	shr    %edx
80101192:	b8 d3 20 0d d2       	mov    $0xd20d20d3,%eax
80101197:	f7 e2                	mul    %edx
80101199:	89 d0                	mov    %edx,%eax
8010119b:	c1 e8 05             	shr    $0x5,%eax
8010119e:	6b c0 4e             	imul   $0x4e,%eax,%eax
801011a1:	29 c1                	sub    %eax,%ecx
801011a3:	88 99 80 fe 10 80    	mov    %bl,-0x7fef0180(%ecx)
801011a9:	e9 7d fc ff ff       	jmp    80100e2b <consoleintr+0x1b>
    uartputc('\b');
801011ae:	83 ec 0c             	sub    $0xc,%esp
801011b1:	6a 08                	push   $0x8
801011b3:	e8 88 52 00 00       	call   80106440 <uartputc>
  cgaputc(c);
801011b8:	b8 00 01 00 00       	mov    $0x100,%eax
801011bd:	e8 5e f2 ff ff       	call   80100420 <cgaputc>
801011c2:	83 c4 10             	add    $0x10,%esp
801011c5:	e9 58 fd ff ff       	jmp    80100f22 <consoleintr+0x112>
    uartputc(c);
801011ca:	83 ec 0c             	sub    $0xc,%esp
801011cd:	53                   	push   %ebx
801011ce:	e8 6d 52 00 00       	call   80106440 <uartputc>
  cgaputc(c);
801011d3:	89 d8                	mov    %ebx,%eax
801011d5:	e8 46 f2 ff ff       	call   80100420 <cgaputc>
        if (c == '\n' || c == C('D') || input.e == input.r + INPUT_BUF - 1)
801011da:	83 c4 10             	add    $0x10,%esp
801011dd:	80 7d e4 00          	cmpb   $0x0,-0x1c(%ebp)
801011e1:	0f 85 54 fd ff ff    	jne    80100f3b <consoleintr+0x12b>
801011e7:	e9 36 fd ff ff       	jmp    80100f22 <consoleintr+0x112>
801011ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801011f0 <consoleinit>:

void consoleinit(void)
{
801011f0:	55                   	push   %ebp
801011f1:	89 e5                	mov    %esp,%ebp
801011f3:	83 ec 10             	sub    $0x10,%esp
  initlock(&cons.lock, "console");
801011f6:	68 88 79 10 80       	push   $0x80107988
801011fb:	68 60 0b 11 80       	push   $0x80110b60
80101200:	e8 5b 39 00 00       	call   80104b60 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  ioapicenable(IRQ_KBD, 0);
80101205:	58                   	pop    %eax
80101206:	5a                   	pop    %edx
80101207:	6a 00                	push   $0x0
80101209:	6a 01                	push   $0x1
  devsw[CONSOLE].write = consolewrite;
8010120b:	c7 05 4c 15 11 80 20 	movl   $0x80100620,0x8011154c
80101212:	06 10 80 
  devsw[CONSOLE].read = consoleread;
80101215:	c7 05 48 15 11 80 80 	movl   $0x80100280,0x80111548
8010121c:	02 10 80 
  cons.locking = 1;
8010121f:	c7 05 94 0b 11 80 01 	movl   $0x1,0x80110b94
80101226:	00 00 00 
  ioapicenable(IRQ_KBD, 0);
80101229:	e8 e2 19 00 00       	call   80102c10 <ioapicenable>
}
8010122e:	83 c4 10             	add    $0x10,%esp
80101231:	c9                   	leave  
80101232:	c3                   	ret    
80101233:	66 90                	xchg   %ax,%ax
80101235:	66 90                	xchg   %ax,%ax
80101237:	66 90                	xchg   %ax,%ax
80101239:	66 90                	xchg   %ax,%ax
8010123b:	66 90                	xchg   %ax,%ax
8010123d:	66 90                	xchg   %ax,%ax
8010123f:	90                   	nop

80101240 <exec>:
80101240:	55                   	push   %ebp
80101241:	89 e5                	mov    %esp,%ebp
80101243:	57                   	push   %edi
80101244:	56                   	push   %esi
80101245:	53                   	push   %ebx
80101246:	81 ec 0c 01 00 00    	sub    $0x10c,%esp
8010124c:	e8 af 2e 00 00       	call   80104100 <myproc>
80101251:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)
80101257:	e8 94 22 00 00       	call   801034f0 <begin_op>
8010125c:	83 ec 0c             	sub    $0xc,%esp
8010125f:	ff 75 08             	push   0x8(%ebp)
80101262:	e8 c9 15 00 00       	call   80102830 <namei>
80101267:	83 c4 10             	add    $0x10,%esp
8010126a:	85 c0                	test   %eax,%eax
8010126c:	0f 84 02 03 00 00    	je     80101574 <exec+0x334>
80101272:	83 ec 0c             	sub    $0xc,%esp
80101275:	89 c3                	mov    %eax,%ebx
80101277:	50                   	push   %eax
80101278:	e8 93 0c 00 00       	call   80101f10 <ilock>
8010127d:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80101283:	6a 34                	push   $0x34
80101285:	6a 00                	push   $0x0
80101287:	50                   	push   %eax
80101288:	53                   	push   %ebx
80101289:	e8 92 0f 00 00       	call   80102220 <readi>
8010128e:	83 c4 20             	add    $0x20,%esp
80101291:	83 f8 34             	cmp    $0x34,%eax
80101294:	74 22                	je     801012b8 <exec+0x78>
80101296:	83 ec 0c             	sub    $0xc,%esp
80101299:	53                   	push   %ebx
8010129a:	e8 01 0f 00 00       	call   801021a0 <iunlockput>
8010129f:	e8 bc 22 00 00       	call   80103560 <end_op>
801012a4:	83 c4 10             	add    $0x10,%esp
801012a7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801012ac:	8d 65 f4             	lea    -0xc(%ebp),%esp
801012af:	5b                   	pop    %ebx
801012b0:	5e                   	pop    %esi
801012b1:	5f                   	pop    %edi
801012b2:	5d                   	pop    %ebp
801012b3:	c3                   	ret    
801012b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801012b8:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
801012bf:	45 4c 46 
801012c2:	75 d2                	jne    80101296 <exec+0x56>
801012c4:	e8 07 63 00 00       	call   801075d0 <setupkvm>
801012c9:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)
801012cf:	85 c0                	test   %eax,%eax
801012d1:	74 c3                	je     80101296 <exec+0x56>
801012d3:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
801012da:	00 
801012db:	8b b5 40 ff ff ff    	mov    -0xc0(%ebp),%esi
801012e1:	0f 84 ac 02 00 00    	je     80101593 <exec+0x353>
801012e7:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
801012ee:	00 00 00 
801012f1:	31 ff                	xor    %edi,%edi
801012f3:	e9 8e 00 00 00       	jmp    80101386 <exec+0x146>
801012f8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801012ff:	90                   	nop
80101300:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80101307:	75 6c                	jne    80101375 <exec+0x135>
80101309:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
8010130f:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80101315:	0f 82 87 00 00 00    	jb     801013a2 <exec+0x162>
8010131b:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80101321:	72 7f                	jb     801013a2 <exec+0x162>
80101323:	83 ec 04             	sub    $0x4,%esp
80101326:	50                   	push   %eax
80101327:	ff b5 f0 fe ff ff    	push   -0x110(%ebp)
8010132d:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80101333:	e8 b8 60 00 00       	call   801073f0 <allocuvm>
80101338:	83 c4 10             	add    $0x10,%esp
8010133b:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80101341:	85 c0                	test   %eax,%eax
80101343:	74 5d                	je     801013a2 <exec+0x162>
80101345:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
8010134b:	a9 ff 0f 00 00       	test   $0xfff,%eax
80101350:	75 50                	jne    801013a2 <exec+0x162>
80101352:	83 ec 0c             	sub    $0xc,%esp
80101355:	ff b5 14 ff ff ff    	push   -0xec(%ebp)
8010135b:	ff b5 08 ff ff ff    	push   -0xf8(%ebp)
80101361:	53                   	push   %ebx
80101362:	50                   	push   %eax
80101363:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80101369:	e8 92 5f 00 00       	call   80107300 <loaduvm>
8010136e:	83 c4 20             	add    $0x20,%esp
80101371:	85 c0                	test   %eax,%eax
80101373:	78 2d                	js     801013a2 <exec+0x162>
80101375:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
8010137c:	83 c7 01             	add    $0x1,%edi
8010137f:	83 c6 20             	add    $0x20,%esi
80101382:	39 f8                	cmp    %edi,%eax
80101384:	7e 3a                	jle    801013c0 <exec+0x180>
80101386:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
8010138c:	6a 20                	push   $0x20
8010138e:	56                   	push   %esi
8010138f:	50                   	push   %eax
80101390:	53                   	push   %ebx
80101391:	e8 8a 0e 00 00       	call   80102220 <readi>
80101396:	83 c4 10             	add    $0x10,%esp
80101399:	83 f8 20             	cmp    $0x20,%eax
8010139c:	0f 84 5e ff ff ff    	je     80101300 <exec+0xc0>
801013a2:	83 ec 0c             	sub    $0xc,%esp
801013a5:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
801013ab:	e8 a0 61 00 00       	call   80107550 <freevm>
801013b0:	83 c4 10             	add    $0x10,%esp
801013b3:	e9 de fe ff ff       	jmp    80101296 <exec+0x56>
801013b8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801013bf:	90                   	nop
801013c0:	8b bd f0 fe ff ff    	mov    -0x110(%ebp),%edi
801013c6:	81 c7 ff 0f 00 00    	add    $0xfff,%edi
801013cc:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
801013d2:	8d b7 00 20 00 00    	lea    0x2000(%edi),%esi
801013d8:	83 ec 0c             	sub    $0xc,%esp
801013db:	53                   	push   %ebx
801013dc:	e8 bf 0d 00 00       	call   801021a0 <iunlockput>
801013e1:	e8 7a 21 00 00       	call   80103560 <end_op>
801013e6:	83 c4 0c             	add    $0xc,%esp
801013e9:	56                   	push   %esi
801013ea:	57                   	push   %edi
801013eb:	8b bd f4 fe ff ff    	mov    -0x10c(%ebp),%edi
801013f1:	57                   	push   %edi
801013f2:	e8 f9 5f 00 00       	call   801073f0 <allocuvm>
801013f7:	83 c4 10             	add    $0x10,%esp
801013fa:	89 c6                	mov    %eax,%esi
801013fc:	85 c0                	test   %eax,%eax
801013fe:	0f 84 94 00 00 00    	je     80101498 <exec+0x258>
80101404:	83 ec 08             	sub    $0x8,%esp
80101407:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
8010140d:	89 f3                	mov    %esi,%ebx
8010140f:	50                   	push   %eax
80101410:	57                   	push   %edi
80101411:	31 ff                	xor    %edi,%edi
80101413:	e8 58 62 00 00       	call   80107670 <clearpteu>
80101418:	8b 45 0c             	mov    0xc(%ebp),%eax
8010141b:	83 c4 10             	add    $0x10,%esp
8010141e:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
80101424:	8b 00                	mov    (%eax),%eax
80101426:	85 c0                	test   %eax,%eax
80101428:	0f 84 8b 00 00 00    	je     801014b9 <exec+0x279>
8010142e:	89 b5 f0 fe ff ff    	mov    %esi,-0x110(%ebp)
80101434:	8b b5 f4 fe ff ff    	mov    -0x10c(%ebp),%esi
8010143a:	eb 23                	jmp    8010145f <exec+0x21f>
8010143c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101440:	8b 45 0c             	mov    0xc(%ebp),%eax
80101443:	89 9c bd 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%edi,4)
8010144a:	83 c7 01             	add    $0x1,%edi
8010144d:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
80101453:	8b 04 b8             	mov    (%eax,%edi,4),%eax
80101456:	85 c0                	test   %eax,%eax
80101458:	74 59                	je     801014b3 <exec+0x273>
8010145a:	83 ff 20             	cmp    $0x20,%edi
8010145d:	74 39                	je     80101498 <exec+0x258>
8010145f:	83 ec 0c             	sub    $0xc,%esp
80101462:	50                   	push   %eax
80101463:	e8 88 3b 00 00       	call   80104ff0 <strlen>
80101468:	29 c3                	sub    %eax,%ebx
8010146a:	58                   	pop    %eax
8010146b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010146e:	83 eb 01             	sub    $0x1,%ebx
80101471:	ff 34 b8             	push   (%eax,%edi,4)
80101474:	83 e3 fc             	and    $0xfffffffc,%ebx
80101477:	e8 74 3b 00 00       	call   80104ff0 <strlen>
8010147c:	83 c0 01             	add    $0x1,%eax
8010147f:	50                   	push   %eax
80101480:	8b 45 0c             	mov    0xc(%ebp),%eax
80101483:	ff 34 b8             	push   (%eax,%edi,4)
80101486:	53                   	push   %ebx
80101487:	56                   	push   %esi
80101488:	e8 b3 63 00 00       	call   80107840 <copyout>
8010148d:	83 c4 20             	add    $0x20,%esp
80101490:	85 c0                	test   %eax,%eax
80101492:	79 ac                	jns    80101440 <exec+0x200>
80101494:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101498:	83 ec 0c             	sub    $0xc,%esp
8010149b:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
801014a1:	e8 aa 60 00 00       	call   80107550 <freevm>
801014a6:	83 c4 10             	add    $0x10,%esp
801014a9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801014ae:	e9 f9 fd ff ff       	jmp    801012ac <exec+0x6c>
801014b3:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
801014b9:	8d 04 bd 04 00 00 00 	lea    0x4(,%edi,4),%eax
801014c0:	89 d9                	mov    %ebx,%ecx
801014c2:	c7 84 bd 64 ff ff ff 	movl   $0x0,-0x9c(%ebp,%edi,4)
801014c9:	00 00 00 00 
801014cd:	29 c1                	sub    %eax,%ecx
801014cf:	83 c0 0c             	add    $0xc,%eax
801014d2:	89 bd 5c ff ff ff    	mov    %edi,-0xa4(%ebp)
801014d8:	29 c3                	sub    %eax,%ebx
801014da:	50                   	push   %eax
801014db:	52                   	push   %edx
801014dc:	53                   	push   %ebx
801014dd:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
801014e3:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
801014ea:	ff ff ff 
801014ed:	89 8d 60 ff ff ff    	mov    %ecx,-0xa0(%ebp)
801014f3:	e8 48 63 00 00       	call   80107840 <copyout>
801014f8:	83 c4 10             	add    $0x10,%esp
801014fb:	85 c0                	test   %eax,%eax
801014fd:	78 99                	js     80101498 <exec+0x258>
801014ff:	8b 45 08             	mov    0x8(%ebp),%eax
80101502:	8b 55 08             	mov    0x8(%ebp),%edx
80101505:	0f b6 00             	movzbl (%eax),%eax
80101508:	84 c0                	test   %al,%al
8010150a:	74 13                	je     8010151f <exec+0x2df>
8010150c:	89 d1                	mov    %edx,%ecx
8010150e:	66 90                	xchg   %ax,%ax
80101510:	83 c1 01             	add    $0x1,%ecx
80101513:	3c 2f                	cmp    $0x2f,%al
80101515:	0f b6 01             	movzbl (%ecx),%eax
80101518:	0f 44 d1             	cmove  %ecx,%edx
8010151b:	84 c0                	test   %al,%al
8010151d:	75 f1                	jne    80101510 <exec+0x2d0>
8010151f:	8b bd ec fe ff ff    	mov    -0x114(%ebp),%edi
80101525:	83 ec 04             	sub    $0x4,%esp
80101528:	6a 10                	push   $0x10
8010152a:	89 f8                	mov    %edi,%eax
8010152c:	52                   	push   %edx
8010152d:	83 c0 6c             	add    $0x6c,%eax
80101530:	50                   	push   %eax
80101531:	e8 7a 3a 00 00       	call   80104fb0 <safestrcpy>
80101536:	8b 8d f4 fe ff ff    	mov    -0x10c(%ebp),%ecx
8010153c:	89 f8                	mov    %edi,%eax
8010153e:	8b 7f 04             	mov    0x4(%edi),%edi
80101541:	89 30                	mov    %esi,(%eax)
80101543:	89 48 04             	mov    %ecx,0x4(%eax)
80101546:	89 c1                	mov    %eax,%ecx
80101548:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
8010154e:	8b 40 18             	mov    0x18(%eax),%eax
80101551:	89 50 38             	mov    %edx,0x38(%eax)
80101554:	8b 41 18             	mov    0x18(%ecx),%eax
80101557:	89 58 44             	mov    %ebx,0x44(%eax)
8010155a:	89 0c 24             	mov    %ecx,(%esp)
8010155d:	e8 0e 5c 00 00       	call   80107170 <switchuvm>
80101562:	89 3c 24             	mov    %edi,(%esp)
80101565:	e8 e6 5f 00 00       	call   80107550 <freevm>
8010156a:	83 c4 10             	add    $0x10,%esp
8010156d:	31 c0                	xor    %eax,%eax
8010156f:	e9 38 fd ff ff       	jmp    801012ac <exec+0x6c>
80101574:	e8 e7 1f 00 00       	call   80103560 <end_op>
80101579:	83 ec 0c             	sub    $0xc,%esp
8010157c:	68 f9 79 10 80       	push   $0x801079f9
80101581:	e8 ca f1 ff ff       	call   80100750 <cprintf>
80101586:	83 c4 10             	add    $0x10,%esp
80101589:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010158e:	e9 19 fd ff ff       	jmp    801012ac <exec+0x6c>
80101593:	be 00 20 00 00       	mov    $0x2000,%esi
80101598:	31 ff                	xor    %edi,%edi
8010159a:	e9 39 fe ff ff       	jmp    801013d8 <exec+0x198>
8010159f:	90                   	nop

801015a0 <fileinit>:
801015a0:	55                   	push   %ebp
801015a1:	89 e5                	mov    %esp,%ebp
801015a3:	83 ec 10             	sub    $0x10,%esp
801015a6:	68 05 7a 10 80       	push   $0x80107a05
801015ab:	68 a0 0b 11 80       	push   $0x80110ba0
801015b0:	e8 ab 35 00 00       	call   80104b60 <initlock>
801015b5:	83 c4 10             	add    $0x10,%esp
801015b8:	c9                   	leave  
801015b9:	c3                   	ret    
801015ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801015c0 <filealloc>:
801015c0:	55                   	push   %ebp
801015c1:	89 e5                	mov    %esp,%ebp
801015c3:	53                   	push   %ebx
801015c4:	bb d4 0b 11 80       	mov    $0x80110bd4,%ebx
801015c9:	83 ec 10             	sub    $0x10,%esp
801015cc:	68 a0 0b 11 80       	push   $0x80110ba0
801015d1:	e8 5a 37 00 00       	call   80104d30 <acquire>
801015d6:	83 c4 10             	add    $0x10,%esp
801015d9:	eb 10                	jmp    801015eb <filealloc+0x2b>
801015db:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801015df:	90                   	nop
801015e0:	83 c3 18             	add    $0x18,%ebx
801015e3:	81 fb 34 15 11 80    	cmp    $0x80111534,%ebx
801015e9:	74 25                	je     80101610 <filealloc+0x50>
801015eb:	8b 43 04             	mov    0x4(%ebx),%eax
801015ee:	85 c0                	test   %eax,%eax
801015f0:	75 ee                	jne    801015e0 <filealloc+0x20>
801015f2:	83 ec 0c             	sub    $0xc,%esp
801015f5:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
801015fc:	68 a0 0b 11 80       	push   $0x80110ba0
80101601:	e8 ca 36 00 00       	call   80104cd0 <release>
80101606:	89 d8                	mov    %ebx,%eax
80101608:	83 c4 10             	add    $0x10,%esp
8010160b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010160e:	c9                   	leave  
8010160f:	c3                   	ret    
80101610:	83 ec 0c             	sub    $0xc,%esp
80101613:	31 db                	xor    %ebx,%ebx
80101615:	68 a0 0b 11 80       	push   $0x80110ba0
8010161a:	e8 b1 36 00 00       	call   80104cd0 <release>
8010161f:	89 d8                	mov    %ebx,%eax
80101621:	83 c4 10             	add    $0x10,%esp
80101624:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101627:	c9                   	leave  
80101628:	c3                   	ret    
80101629:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101630 <filedup>:
80101630:	55                   	push   %ebp
80101631:	89 e5                	mov    %esp,%ebp
80101633:	53                   	push   %ebx
80101634:	83 ec 10             	sub    $0x10,%esp
80101637:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010163a:	68 a0 0b 11 80       	push   $0x80110ba0
8010163f:	e8 ec 36 00 00       	call   80104d30 <acquire>
80101644:	8b 43 04             	mov    0x4(%ebx),%eax
80101647:	83 c4 10             	add    $0x10,%esp
8010164a:	85 c0                	test   %eax,%eax
8010164c:	7e 1a                	jle    80101668 <filedup+0x38>
8010164e:	83 c0 01             	add    $0x1,%eax
80101651:	83 ec 0c             	sub    $0xc,%esp
80101654:	89 43 04             	mov    %eax,0x4(%ebx)
80101657:	68 a0 0b 11 80       	push   $0x80110ba0
8010165c:	e8 6f 36 00 00       	call   80104cd0 <release>
80101661:	89 d8                	mov    %ebx,%eax
80101663:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101666:	c9                   	leave  
80101667:	c3                   	ret    
80101668:	83 ec 0c             	sub    $0xc,%esp
8010166b:	68 0c 7a 10 80       	push   $0x80107a0c
80101670:	e8 2b ed ff ff       	call   801003a0 <panic>
80101675:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010167c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101680 <fileclose>:
80101680:	55                   	push   %ebp
80101681:	89 e5                	mov    %esp,%ebp
80101683:	57                   	push   %edi
80101684:	56                   	push   %esi
80101685:	53                   	push   %ebx
80101686:	83 ec 28             	sub    $0x28,%esp
80101689:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010168c:	68 a0 0b 11 80       	push   $0x80110ba0
80101691:	e8 9a 36 00 00       	call   80104d30 <acquire>
80101696:	8b 53 04             	mov    0x4(%ebx),%edx
80101699:	83 c4 10             	add    $0x10,%esp
8010169c:	85 d2                	test   %edx,%edx
8010169e:	0f 8e a5 00 00 00    	jle    80101749 <fileclose+0xc9>
801016a4:	83 ea 01             	sub    $0x1,%edx
801016a7:	89 53 04             	mov    %edx,0x4(%ebx)
801016aa:	75 44                	jne    801016f0 <fileclose+0x70>
801016ac:	0f b6 43 09          	movzbl 0x9(%ebx),%eax
801016b0:	83 ec 0c             	sub    $0xc,%esp
801016b3:	8b 3b                	mov    (%ebx),%edi
801016b5:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
801016bb:	8b 73 0c             	mov    0xc(%ebx),%esi
801016be:	88 45 e7             	mov    %al,-0x19(%ebp)
801016c1:	8b 43 10             	mov    0x10(%ebx),%eax
801016c4:	68 a0 0b 11 80       	push   $0x80110ba0
801016c9:	89 45 e0             	mov    %eax,-0x20(%ebp)
801016cc:	e8 ff 35 00 00       	call   80104cd0 <release>
801016d1:	83 c4 10             	add    $0x10,%esp
801016d4:	83 ff 01             	cmp    $0x1,%edi
801016d7:	74 57                	je     80101730 <fileclose+0xb0>
801016d9:	83 ff 02             	cmp    $0x2,%edi
801016dc:	74 2a                	je     80101708 <fileclose+0x88>
801016de:	8d 65 f4             	lea    -0xc(%ebp),%esp
801016e1:	5b                   	pop    %ebx
801016e2:	5e                   	pop    %esi
801016e3:	5f                   	pop    %edi
801016e4:	5d                   	pop    %ebp
801016e5:	c3                   	ret    
801016e6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801016ed:	8d 76 00             	lea    0x0(%esi),%esi
801016f0:	c7 45 08 a0 0b 11 80 	movl   $0x80110ba0,0x8(%ebp)
801016f7:	8d 65 f4             	lea    -0xc(%ebp),%esp
801016fa:	5b                   	pop    %ebx
801016fb:	5e                   	pop    %esi
801016fc:	5f                   	pop    %edi
801016fd:	5d                   	pop    %ebp
801016fe:	e9 cd 35 00 00       	jmp    80104cd0 <release>
80101703:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101707:	90                   	nop
80101708:	e8 e3 1d 00 00       	call   801034f0 <begin_op>
8010170d:	83 ec 0c             	sub    $0xc,%esp
80101710:	ff 75 e0             	push   -0x20(%ebp)
80101713:	e8 28 09 00 00       	call   80102040 <iput>
80101718:	83 c4 10             	add    $0x10,%esp
8010171b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010171e:	5b                   	pop    %ebx
8010171f:	5e                   	pop    %esi
80101720:	5f                   	pop    %edi
80101721:	5d                   	pop    %ebp
80101722:	e9 39 1e 00 00       	jmp    80103560 <end_op>
80101727:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010172e:	66 90                	xchg   %ax,%ax
80101730:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
80101734:	83 ec 08             	sub    $0x8,%esp
80101737:	53                   	push   %ebx
80101738:	56                   	push   %esi
80101739:	e8 82 25 00 00       	call   80103cc0 <pipeclose>
8010173e:	83 c4 10             	add    $0x10,%esp
80101741:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101744:	5b                   	pop    %ebx
80101745:	5e                   	pop    %esi
80101746:	5f                   	pop    %edi
80101747:	5d                   	pop    %ebp
80101748:	c3                   	ret    
80101749:	83 ec 0c             	sub    $0xc,%esp
8010174c:	68 14 7a 10 80       	push   $0x80107a14
80101751:	e8 4a ec ff ff       	call   801003a0 <panic>
80101756:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010175d:	8d 76 00             	lea    0x0(%esi),%esi

80101760 <filestat>:
80101760:	55                   	push   %ebp
80101761:	89 e5                	mov    %esp,%ebp
80101763:	53                   	push   %ebx
80101764:	83 ec 04             	sub    $0x4,%esp
80101767:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010176a:	83 3b 02             	cmpl   $0x2,(%ebx)
8010176d:	75 31                	jne    801017a0 <filestat+0x40>
8010176f:	83 ec 0c             	sub    $0xc,%esp
80101772:	ff 73 10             	push   0x10(%ebx)
80101775:	e8 96 07 00 00       	call   80101f10 <ilock>
8010177a:	58                   	pop    %eax
8010177b:	5a                   	pop    %edx
8010177c:	ff 75 0c             	push   0xc(%ebp)
8010177f:	ff 73 10             	push   0x10(%ebx)
80101782:	e8 69 0a 00 00       	call   801021f0 <stati>
80101787:	59                   	pop    %ecx
80101788:	ff 73 10             	push   0x10(%ebx)
8010178b:	e8 60 08 00 00       	call   80101ff0 <iunlock>
80101790:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101793:	83 c4 10             	add    $0x10,%esp
80101796:	31 c0                	xor    %eax,%eax
80101798:	c9                   	leave  
80101799:	c3                   	ret    
8010179a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801017a0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801017a3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801017a8:	c9                   	leave  
801017a9:	c3                   	ret    
801017aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801017b0 <fileread>:
801017b0:	55                   	push   %ebp
801017b1:	89 e5                	mov    %esp,%ebp
801017b3:	57                   	push   %edi
801017b4:	56                   	push   %esi
801017b5:	53                   	push   %ebx
801017b6:	83 ec 0c             	sub    $0xc,%esp
801017b9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801017bc:	8b 75 0c             	mov    0xc(%ebp),%esi
801017bf:	8b 7d 10             	mov    0x10(%ebp),%edi
801017c2:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
801017c6:	74 60                	je     80101828 <fileread+0x78>
801017c8:	8b 03                	mov    (%ebx),%eax
801017ca:	83 f8 01             	cmp    $0x1,%eax
801017cd:	74 41                	je     80101810 <fileread+0x60>
801017cf:	83 f8 02             	cmp    $0x2,%eax
801017d2:	75 5b                	jne    8010182f <fileread+0x7f>
801017d4:	83 ec 0c             	sub    $0xc,%esp
801017d7:	ff 73 10             	push   0x10(%ebx)
801017da:	e8 31 07 00 00       	call   80101f10 <ilock>
801017df:	57                   	push   %edi
801017e0:	ff 73 14             	push   0x14(%ebx)
801017e3:	56                   	push   %esi
801017e4:	ff 73 10             	push   0x10(%ebx)
801017e7:	e8 34 0a 00 00       	call   80102220 <readi>
801017ec:	83 c4 20             	add    $0x20,%esp
801017ef:	89 c6                	mov    %eax,%esi
801017f1:	85 c0                	test   %eax,%eax
801017f3:	7e 03                	jle    801017f8 <fileread+0x48>
801017f5:	01 43 14             	add    %eax,0x14(%ebx)
801017f8:	83 ec 0c             	sub    $0xc,%esp
801017fb:	ff 73 10             	push   0x10(%ebx)
801017fe:	e8 ed 07 00 00       	call   80101ff0 <iunlock>
80101803:	83 c4 10             	add    $0x10,%esp
80101806:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101809:	89 f0                	mov    %esi,%eax
8010180b:	5b                   	pop    %ebx
8010180c:	5e                   	pop    %esi
8010180d:	5f                   	pop    %edi
8010180e:	5d                   	pop    %ebp
8010180f:	c3                   	ret    
80101810:	8b 43 0c             	mov    0xc(%ebx),%eax
80101813:	89 45 08             	mov    %eax,0x8(%ebp)
80101816:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101819:	5b                   	pop    %ebx
8010181a:	5e                   	pop    %esi
8010181b:	5f                   	pop    %edi
8010181c:	5d                   	pop    %ebp
8010181d:	e9 3e 26 00 00       	jmp    80103e60 <piperead>
80101822:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101828:	be ff ff ff ff       	mov    $0xffffffff,%esi
8010182d:	eb d7                	jmp    80101806 <fileread+0x56>
8010182f:	83 ec 0c             	sub    $0xc,%esp
80101832:	68 1e 7a 10 80       	push   $0x80107a1e
80101837:	e8 64 eb ff ff       	call   801003a0 <panic>
8010183c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101840 <filewrite>:
80101840:	55                   	push   %ebp
80101841:	89 e5                	mov    %esp,%ebp
80101843:	57                   	push   %edi
80101844:	56                   	push   %esi
80101845:	53                   	push   %ebx
80101846:	83 ec 1c             	sub    $0x1c,%esp
80101849:	8b 45 0c             	mov    0xc(%ebp),%eax
8010184c:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010184f:	89 45 dc             	mov    %eax,-0x24(%ebp)
80101852:	8b 45 10             	mov    0x10(%ebp),%eax
80101855:	80 7b 09 00          	cmpb   $0x0,0x9(%ebx)
80101859:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010185c:	0f 84 bd 00 00 00    	je     8010191f <filewrite+0xdf>
80101862:	8b 03                	mov    (%ebx),%eax
80101864:	83 f8 01             	cmp    $0x1,%eax
80101867:	0f 84 bf 00 00 00    	je     8010192c <filewrite+0xec>
8010186d:	83 f8 02             	cmp    $0x2,%eax
80101870:	0f 85 c8 00 00 00    	jne    8010193e <filewrite+0xfe>
80101876:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101879:	31 f6                	xor    %esi,%esi
8010187b:	85 c0                	test   %eax,%eax
8010187d:	7f 30                	jg     801018af <filewrite+0x6f>
8010187f:	e9 94 00 00 00       	jmp    80101918 <filewrite+0xd8>
80101884:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101888:	01 43 14             	add    %eax,0x14(%ebx)
8010188b:	83 ec 0c             	sub    $0xc,%esp
8010188e:	ff 73 10             	push   0x10(%ebx)
80101891:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101894:	e8 57 07 00 00       	call   80101ff0 <iunlock>
80101899:	e8 c2 1c 00 00       	call   80103560 <end_op>
8010189e:	8b 45 e0             	mov    -0x20(%ebp),%eax
801018a1:	83 c4 10             	add    $0x10,%esp
801018a4:	39 c7                	cmp    %eax,%edi
801018a6:	75 5c                	jne    80101904 <filewrite+0xc4>
801018a8:	01 fe                	add    %edi,%esi
801018aa:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
801018ad:	7e 69                	jle    80101918 <filewrite+0xd8>
801018af:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801018b2:	b8 00 06 00 00       	mov    $0x600,%eax
801018b7:	29 f7                	sub    %esi,%edi
801018b9:	39 c7                	cmp    %eax,%edi
801018bb:	0f 4f f8             	cmovg  %eax,%edi
801018be:	e8 2d 1c 00 00       	call   801034f0 <begin_op>
801018c3:	83 ec 0c             	sub    $0xc,%esp
801018c6:	ff 73 10             	push   0x10(%ebx)
801018c9:	e8 42 06 00 00       	call   80101f10 <ilock>
801018ce:	8b 45 dc             	mov    -0x24(%ebp),%eax
801018d1:	57                   	push   %edi
801018d2:	ff 73 14             	push   0x14(%ebx)
801018d5:	01 f0                	add    %esi,%eax
801018d7:	50                   	push   %eax
801018d8:	ff 73 10             	push   0x10(%ebx)
801018db:	e8 40 0a 00 00       	call   80102320 <writei>
801018e0:	83 c4 20             	add    $0x20,%esp
801018e3:	85 c0                	test   %eax,%eax
801018e5:	7f a1                	jg     80101888 <filewrite+0x48>
801018e7:	83 ec 0c             	sub    $0xc,%esp
801018ea:	ff 73 10             	push   0x10(%ebx)
801018ed:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801018f0:	e8 fb 06 00 00       	call   80101ff0 <iunlock>
801018f5:	e8 66 1c 00 00       	call   80103560 <end_op>
801018fa:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801018fd:	83 c4 10             	add    $0x10,%esp
80101900:	85 c0                	test   %eax,%eax
80101902:	75 1b                	jne    8010191f <filewrite+0xdf>
80101904:	83 ec 0c             	sub    $0xc,%esp
80101907:	68 27 7a 10 80       	push   $0x80107a27
8010190c:	e8 8f ea ff ff       	call   801003a0 <panic>
80101911:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101918:	89 f0                	mov    %esi,%eax
8010191a:	3b 75 e4             	cmp    -0x1c(%ebp),%esi
8010191d:	74 05                	je     80101924 <filewrite+0xe4>
8010191f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101924:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101927:	5b                   	pop    %ebx
80101928:	5e                   	pop    %esi
80101929:	5f                   	pop    %edi
8010192a:	5d                   	pop    %ebp
8010192b:	c3                   	ret    
8010192c:	8b 43 0c             	mov    0xc(%ebx),%eax
8010192f:	89 45 08             	mov    %eax,0x8(%ebp)
80101932:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101935:	5b                   	pop    %ebx
80101936:	5e                   	pop    %esi
80101937:	5f                   	pop    %edi
80101938:	5d                   	pop    %ebp
80101939:	e9 22 24 00 00       	jmp    80103d60 <pipewrite>
8010193e:	83 ec 0c             	sub    $0xc,%esp
80101941:	68 2d 7a 10 80       	push   $0x80107a2d
80101946:	e8 55 ea ff ff       	call   801003a0 <panic>
8010194b:	66 90                	xchg   %ax,%ax
8010194d:	66 90                	xchg   %ax,%ax
8010194f:	90                   	nop

80101950 <bfree>:
80101950:	55                   	push   %ebp
80101951:	89 c1                	mov    %eax,%ecx
80101953:	89 d0                	mov    %edx,%eax
80101955:	c1 e8 0c             	shr    $0xc,%eax
80101958:	03 05 0c 32 11 80    	add    0x8011320c,%eax
8010195e:	89 e5                	mov    %esp,%ebp
80101960:	56                   	push   %esi
80101961:	53                   	push   %ebx
80101962:	89 d3                	mov    %edx,%ebx
80101964:	83 ec 08             	sub    $0x8,%esp
80101967:	50                   	push   %eax
80101968:	51                   	push   %ecx
80101969:	e8 62 e7 ff ff       	call   801000d0 <bread>
8010196e:	89 d9                	mov    %ebx,%ecx
80101970:	c1 fb 03             	sar    $0x3,%ebx
80101973:	83 c4 10             	add    $0x10,%esp
80101976:	89 c6                	mov    %eax,%esi
80101978:	83 e1 07             	and    $0x7,%ecx
8010197b:	b8 01 00 00 00       	mov    $0x1,%eax
80101980:	81 e3 ff 01 00 00    	and    $0x1ff,%ebx
80101986:	d3 e0                	shl    %cl,%eax
80101988:	0f b6 4c 1e 5c       	movzbl 0x5c(%esi,%ebx,1),%ecx
8010198d:	85 c1                	test   %eax,%ecx
8010198f:	74 23                	je     801019b4 <bfree+0x64>
80101991:	f7 d0                	not    %eax
80101993:	83 ec 0c             	sub    $0xc,%esp
80101996:	21 c8                	and    %ecx,%eax
80101998:	88 44 1e 5c          	mov    %al,0x5c(%esi,%ebx,1)
8010199c:	56                   	push   %esi
8010199d:	e8 2e 1d 00 00       	call   801036d0 <log_write>
801019a2:	89 34 24             	mov    %esi,(%esp)
801019a5:	e8 46 e8 ff ff       	call   801001f0 <brelse>
801019aa:	83 c4 10             	add    $0x10,%esp
801019ad:	8d 65 f8             	lea    -0x8(%ebp),%esp
801019b0:	5b                   	pop    %ebx
801019b1:	5e                   	pop    %esi
801019b2:	5d                   	pop    %ebp
801019b3:	c3                   	ret    
801019b4:	83 ec 0c             	sub    $0xc,%esp
801019b7:	68 37 7a 10 80       	push   $0x80107a37
801019bc:	e8 df e9 ff ff       	call   801003a0 <panic>
801019c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801019c8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801019cf:	90                   	nop

801019d0 <balloc>:
801019d0:	55                   	push   %ebp
801019d1:	89 e5                	mov    %esp,%ebp
801019d3:	57                   	push   %edi
801019d4:	56                   	push   %esi
801019d5:	53                   	push   %ebx
801019d6:	83 ec 1c             	sub    $0x1c,%esp
801019d9:	8b 0d f4 31 11 80    	mov    0x801131f4,%ecx
801019df:	89 45 d8             	mov    %eax,-0x28(%ebp)
801019e2:	85 c9                	test   %ecx,%ecx
801019e4:	0f 84 87 00 00 00    	je     80101a71 <balloc+0xa1>
801019ea:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
801019f1:	8b 75 dc             	mov    -0x24(%ebp),%esi
801019f4:	83 ec 08             	sub    $0x8,%esp
801019f7:	89 f0                	mov    %esi,%eax
801019f9:	c1 f8 0c             	sar    $0xc,%eax
801019fc:	03 05 0c 32 11 80    	add    0x8011320c,%eax
80101a02:	50                   	push   %eax
80101a03:	ff 75 d8             	push   -0x28(%ebp)
80101a06:	e8 c5 e6 ff ff       	call   801000d0 <bread>
80101a0b:	83 c4 10             	add    $0x10,%esp
80101a0e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101a11:	a1 f4 31 11 80       	mov    0x801131f4,%eax
80101a16:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101a19:	31 c0                	xor    %eax,%eax
80101a1b:	eb 2f                	jmp    80101a4c <balloc+0x7c>
80101a1d:	8d 76 00             	lea    0x0(%esi),%esi
80101a20:	89 c1                	mov    %eax,%ecx
80101a22:	bb 01 00 00 00       	mov    $0x1,%ebx
80101a27:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101a2a:	83 e1 07             	and    $0x7,%ecx
80101a2d:	d3 e3                	shl    %cl,%ebx
80101a2f:	89 c1                	mov    %eax,%ecx
80101a31:	c1 f9 03             	sar    $0x3,%ecx
80101a34:	0f b6 7c 0a 5c       	movzbl 0x5c(%edx,%ecx,1),%edi
80101a39:	89 fa                	mov    %edi,%edx
80101a3b:	85 df                	test   %ebx,%edi
80101a3d:	74 41                	je     80101a80 <balloc+0xb0>
80101a3f:	83 c0 01             	add    $0x1,%eax
80101a42:	83 c6 01             	add    $0x1,%esi
80101a45:	3d 00 10 00 00       	cmp    $0x1000,%eax
80101a4a:	74 05                	je     80101a51 <balloc+0x81>
80101a4c:	39 75 e0             	cmp    %esi,-0x20(%ebp)
80101a4f:	77 cf                	ja     80101a20 <balloc+0x50>
80101a51:	83 ec 0c             	sub    $0xc,%esp
80101a54:	ff 75 e4             	push   -0x1c(%ebp)
80101a57:	e8 94 e7 ff ff       	call   801001f0 <brelse>
80101a5c:	81 45 dc 00 10 00 00 	addl   $0x1000,-0x24(%ebp)
80101a63:	83 c4 10             	add    $0x10,%esp
80101a66:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101a69:	39 05 f4 31 11 80    	cmp    %eax,0x801131f4
80101a6f:	77 80                	ja     801019f1 <balloc+0x21>
80101a71:	83 ec 0c             	sub    $0xc,%esp
80101a74:	68 4a 7a 10 80       	push   $0x80107a4a
80101a79:	e8 22 e9 ff ff       	call   801003a0 <panic>
80101a7e:	66 90                	xchg   %ax,%ax
80101a80:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101a83:	83 ec 0c             	sub    $0xc,%esp
80101a86:	09 da                	or     %ebx,%edx
80101a88:	88 54 0f 5c          	mov    %dl,0x5c(%edi,%ecx,1)
80101a8c:	57                   	push   %edi
80101a8d:	e8 3e 1c 00 00       	call   801036d0 <log_write>
80101a92:	89 3c 24             	mov    %edi,(%esp)
80101a95:	e8 56 e7 ff ff       	call   801001f0 <brelse>
80101a9a:	58                   	pop    %eax
80101a9b:	5a                   	pop    %edx
80101a9c:	56                   	push   %esi
80101a9d:	ff 75 d8             	push   -0x28(%ebp)
80101aa0:	e8 2b e6 ff ff       	call   801000d0 <bread>
80101aa5:	83 c4 0c             	add    $0xc,%esp
80101aa8:	89 c3                	mov    %eax,%ebx
80101aaa:	8d 40 5c             	lea    0x5c(%eax),%eax
80101aad:	68 00 02 00 00       	push   $0x200
80101ab2:	6a 00                	push   $0x0
80101ab4:	50                   	push   %eax
80101ab5:	e8 36 33 00 00       	call   80104df0 <memset>
80101aba:	89 1c 24             	mov    %ebx,(%esp)
80101abd:	e8 0e 1c 00 00       	call   801036d0 <log_write>
80101ac2:	89 1c 24             	mov    %ebx,(%esp)
80101ac5:	e8 26 e7 ff ff       	call   801001f0 <brelse>
80101aca:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101acd:	89 f0                	mov    %esi,%eax
80101acf:	5b                   	pop    %ebx
80101ad0:	5e                   	pop    %esi
80101ad1:	5f                   	pop    %edi
80101ad2:	5d                   	pop    %ebp
80101ad3:	c3                   	ret    
80101ad4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101adb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101adf:	90                   	nop

80101ae0 <iget>:
80101ae0:	55                   	push   %ebp
80101ae1:	89 e5                	mov    %esp,%ebp
80101ae3:	57                   	push   %edi
80101ae4:	89 c7                	mov    %eax,%edi
80101ae6:	56                   	push   %esi
80101ae7:	31 f6                	xor    %esi,%esi
80101ae9:	53                   	push   %ebx
80101aea:	bb d4 15 11 80       	mov    $0x801115d4,%ebx
80101aef:	83 ec 28             	sub    $0x28,%esp
80101af2:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101af5:	68 a0 15 11 80       	push   $0x801115a0
80101afa:	e8 31 32 00 00       	call   80104d30 <acquire>
80101aff:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101b02:	83 c4 10             	add    $0x10,%esp
80101b05:	eb 1b                	jmp    80101b22 <iget+0x42>
80101b07:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101b0e:	66 90                	xchg   %ax,%ax
80101b10:	39 3b                	cmp    %edi,(%ebx)
80101b12:	74 6c                	je     80101b80 <iget+0xa0>
80101b14:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101b1a:	81 fb f4 31 11 80    	cmp    $0x801131f4,%ebx
80101b20:	73 26                	jae    80101b48 <iget+0x68>
80101b22:	8b 43 08             	mov    0x8(%ebx),%eax
80101b25:	85 c0                	test   %eax,%eax
80101b27:	7f e7                	jg     80101b10 <iget+0x30>
80101b29:	85 f6                	test   %esi,%esi
80101b2b:	75 e7                	jne    80101b14 <iget+0x34>
80101b2d:	85 c0                	test   %eax,%eax
80101b2f:	75 76                	jne    80101ba7 <iget+0xc7>
80101b31:	89 de                	mov    %ebx,%esi
80101b33:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101b39:	81 fb f4 31 11 80    	cmp    $0x801131f4,%ebx
80101b3f:	72 e1                	jb     80101b22 <iget+0x42>
80101b41:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101b48:	85 f6                	test   %esi,%esi
80101b4a:	74 79                	je     80101bc5 <iget+0xe5>
80101b4c:	83 ec 0c             	sub    $0xc,%esp
80101b4f:	89 3e                	mov    %edi,(%esi)
80101b51:	89 56 04             	mov    %edx,0x4(%esi)
80101b54:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
80101b5b:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
80101b62:	68 a0 15 11 80       	push   $0x801115a0
80101b67:	e8 64 31 00 00       	call   80104cd0 <release>
80101b6c:	83 c4 10             	add    $0x10,%esp
80101b6f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b72:	89 f0                	mov    %esi,%eax
80101b74:	5b                   	pop    %ebx
80101b75:	5e                   	pop    %esi
80101b76:	5f                   	pop    %edi
80101b77:	5d                   	pop    %ebp
80101b78:	c3                   	ret    
80101b79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101b80:	39 53 04             	cmp    %edx,0x4(%ebx)
80101b83:	75 8f                	jne    80101b14 <iget+0x34>
80101b85:	83 ec 0c             	sub    $0xc,%esp
80101b88:	83 c0 01             	add    $0x1,%eax
80101b8b:	89 de                	mov    %ebx,%esi
80101b8d:	68 a0 15 11 80       	push   $0x801115a0
80101b92:	89 43 08             	mov    %eax,0x8(%ebx)
80101b95:	e8 36 31 00 00       	call   80104cd0 <release>
80101b9a:	83 c4 10             	add    $0x10,%esp
80101b9d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101ba0:	89 f0                	mov    %esi,%eax
80101ba2:	5b                   	pop    %ebx
80101ba3:	5e                   	pop    %esi
80101ba4:	5f                   	pop    %edi
80101ba5:	5d                   	pop    %ebp
80101ba6:	c3                   	ret    
80101ba7:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101bad:	81 fb f4 31 11 80    	cmp    $0x801131f4,%ebx
80101bb3:	73 10                	jae    80101bc5 <iget+0xe5>
80101bb5:	8b 43 08             	mov    0x8(%ebx),%eax
80101bb8:	85 c0                	test   %eax,%eax
80101bba:	0f 8f 50 ff ff ff    	jg     80101b10 <iget+0x30>
80101bc0:	e9 68 ff ff ff       	jmp    80101b2d <iget+0x4d>
80101bc5:	83 ec 0c             	sub    $0xc,%esp
80101bc8:	68 60 7a 10 80       	push   $0x80107a60
80101bcd:	e8 ce e7 ff ff       	call   801003a0 <panic>
80101bd2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101bd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101be0 <bmap>:
80101be0:	55                   	push   %ebp
80101be1:	89 e5                	mov    %esp,%ebp
80101be3:	57                   	push   %edi
80101be4:	56                   	push   %esi
80101be5:	89 c6                	mov    %eax,%esi
80101be7:	53                   	push   %ebx
80101be8:	83 ec 1c             	sub    $0x1c,%esp
80101beb:	83 fa 0b             	cmp    $0xb,%edx
80101bee:	0f 86 8c 00 00 00    	jbe    80101c80 <bmap+0xa0>
80101bf4:	8d 5a f4             	lea    -0xc(%edx),%ebx
80101bf7:	83 fb 7f             	cmp    $0x7f,%ebx
80101bfa:	0f 87 a2 00 00 00    	ja     80101ca2 <bmap+0xc2>
80101c00:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
80101c06:	85 c0                	test   %eax,%eax
80101c08:	74 5e                	je     80101c68 <bmap+0x88>
80101c0a:	83 ec 08             	sub    $0x8,%esp
80101c0d:	50                   	push   %eax
80101c0e:	ff 36                	push   (%esi)
80101c10:	e8 bb e4 ff ff       	call   801000d0 <bread>
80101c15:	83 c4 10             	add    $0x10,%esp
80101c18:	8d 5c 98 5c          	lea    0x5c(%eax,%ebx,4),%ebx
80101c1c:	89 c2                	mov    %eax,%edx
80101c1e:	8b 3b                	mov    (%ebx),%edi
80101c20:	85 ff                	test   %edi,%edi
80101c22:	74 1c                	je     80101c40 <bmap+0x60>
80101c24:	83 ec 0c             	sub    $0xc,%esp
80101c27:	52                   	push   %edx
80101c28:	e8 c3 e5 ff ff       	call   801001f0 <brelse>
80101c2d:	83 c4 10             	add    $0x10,%esp
80101c30:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101c33:	89 f8                	mov    %edi,%eax
80101c35:	5b                   	pop    %ebx
80101c36:	5e                   	pop    %esi
80101c37:	5f                   	pop    %edi
80101c38:	5d                   	pop    %ebp
80101c39:	c3                   	ret    
80101c3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101c40:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101c43:	8b 06                	mov    (%esi),%eax
80101c45:	e8 86 fd ff ff       	call   801019d0 <balloc>
80101c4a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101c4d:	83 ec 0c             	sub    $0xc,%esp
80101c50:	89 03                	mov    %eax,(%ebx)
80101c52:	89 c7                	mov    %eax,%edi
80101c54:	52                   	push   %edx
80101c55:	e8 76 1a 00 00       	call   801036d0 <log_write>
80101c5a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101c5d:	83 c4 10             	add    $0x10,%esp
80101c60:	eb c2                	jmp    80101c24 <bmap+0x44>
80101c62:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101c68:	8b 06                	mov    (%esi),%eax
80101c6a:	e8 61 fd ff ff       	call   801019d0 <balloc>
80101c6f:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
80101c75:	eb 93                	jmp    80101c0a <bmap+0x2a>
80101c77:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101c7e:	66 90                	xchg   %ax,%ax
80101c80:	8d 5a 14             	lea    0x14(%edx),%ebx
80101c83:	8b 7c 98 0c          	mov    0xc(%eax,%ebx,4),%edi
80101c87:	85 ff                	test   %edi,%edi
80101c89:	75 a5                	jne    80101c30 <bmap+0x50>
80101c8b:	8b 00                	mov    (%eax),%eax
80101c8d:	e8 3e fd ff ff       	call   801019d0 <balloc>
80101c92:	89 44 9e 0c          	mov    %eax,0xc(%esi,%ebx,4)
80101c96:	89 c7                	mov    %eax,%edi
80101c98:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101c9b:	5b                   	pop    %ebx
80101c9c:	89 f8                	mov    %edi,%eax
80101c9e:	5e                   	pop    %esi
80101c9f:	5f                   	pop    %edi
80101ca0:	5d                   	pop    %ebp
80101ca1:	c3                   	ret    
80101ca2:	83 ec 0c             	sub    $0xc,%esp
80101ca5:	68 70 7a 10 80       	push   $0x80107a70
80101caa:	e8 f1 e6 ff ff       	call   801003a0 <panic>
80101caf:	90                   	nop

80101cb0 <readsb>:
80101cb0:	55                   	push   %ebp
80101cb1:	89 e5                	mov    %esp,%ebp
80101cb3:	56                   	push   %esi
80101cb4:	53                   	push   %ebx
80101cb5:	8b 75 0c             	mov    0xc(%ebp),%esi
80101cb8:	83 ec 08             	sub    $0x8,%esp
80101cbb:	6a 01                	push   $0x1
80101cbd:	ff 75 08             	push   0x8(%ebp)
80101cc0:	e8 0b e4 ff ff       	call   801000d0 <bread>
80101cc5:	83 c4 0c             	add    $0xc,%esp
80101cc8:	89 c3                	mov    %eax,%ebx
80101cca:	8d 40 5c             	lea    0x5c(%eax),%eax
80101ccd:	6a 1c                	push   $0x1c
80101ccf:	50                   	push   %eax
80101cd0:	56                   	push   %esi
80101cd1:	e8 ba 31 00 00       	call   80104e90 <memmove>
80101cd6:	89 5d 08             	mov    %ebx,0x8(%ebp)
80101cd9:	83 c4 10             	add    $0x10,%esp
80101cdc:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101cdf:	5b                   	pop    %ebx
80101ce0:	5e                   	pop    %esi
80101ce1:	5d                   	pop    %ebp
80101ce2:	e9 09 e5 ff ff       	jmp    801001f0 <brelse>
80101ce7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101cee:	66 90                	xchg   %ax,%ax

80101cf0 <iinit>:
80101cf0:	55                   	push   %ebp
80101cf1:	89 e5                	mov    %esp,%ebp
80101cf3:	53                   	push   %ebx
80101cf4:	bb e0 15 11 80       	mov    $0x801115e0,%ebx
80101cf9:	83 ec 0c             	sub    $0xc,%esp
80101cfc:	68 83 7a 10 80       	push   $0x80107a83
80101d01:	68 a0 15 11 80       	push   $0x801115a0
80101d06:	e8 55 2e 00 00       	call   80104b60 <initlock>
80101d0b:	83 c4 10             	add    $0x10,%esp
80101d0e:	66 90                	xchg   %ax,%ax
80101d10:	83 ec 08             	sub    $0x8,%esp
80101d13:	68 8a 7a 10 80       	push   $0x80107a8a
80101d18:	53                   	push   %ebx
80101d19:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101d1f:	e8 0c 2d 00 00       	call   80104a30 <initsleeplock>
80101d24:	83 c4 10             	add    $0x10,%esp
80101d27:	81 fb 00 32 11 80    	cmp    $0x80113200,%ebx
80101d2d:	75 e1                	jne    80101d10 <iinit+0x20>
80101d2f:	83 ec 08             	sub    $0x8,%esp
80101d32:	6a 01                	push   $0x1
80101d34:	ff 75 08             	push   0x8(%ebp)
80101d37:	e8 94 e3 ff ff       	call   801000d0 <bread>
80101d3c:	83 c4 0c             	add    $0xc,%esp
80101d3f:	89 c3                	mov    %eax,%ebx
80101d41:	8d 40 5c             	lea    0x5c(%eax),%eax
80101d44:	6a 1c                	push   $0x1c
80101d46:	50                   	push   %eax
80101d47:	68 f4 31 11 80       	push   $0x801131f4
80101d4c:	e8 3f 31 00 00       	call   80104e90 <memmove>
80101d51:	89 1c 24             	mov    %ebx,(%esp)
80101d54:	e8 97 e4 ff ff       	call   801001f0 <brelse>
80101d59:	ff 35 0c 32 11 80    	push   0x8011320c
80101d5f:	ff 35 08 32 11 80    	push   0x80113208
80101d65:	ff 35 04 32 11 80    	push   0x80113204
80101d6b:	ff 35 00 32 11 80    	push   0x80113200
80101d71:	ff 35 fc 31 11 80    	push   0x801131fc
80101d77:	ff 35 f8 31 11 80    	push   0x801131f8
80101d7d:	ff 35 f4 31 11 80    	push   0x801131f4
80101d83:	68 f0 7a 10 80       	push   $0x80107af0
80101d88:	e8 c3 e9 ff ff       	call   80100750 <cprintf>
80101d8d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101d90:	83 c4 30             	add    $0x30,%esp
80101d93:	c9                   	leave  
80101d94:	c3                   	ret    
80101d95:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101d9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101da0 <ialloc>:
80101da0:	55                   	push   %ebp
80101da1:	89 e5                	mov    %esp,%ebp
80101da3:	57                   	push   %edi
80101da4:	56                   	push   %esi
80101da5:	53                   	push   %ebx
80101da6:	83 ec 1c             	sub    $0x1c,%esp
80101da9:	8b 45 0c             	mov    0xc(%ebp),%eax
80101dac:	83 3d fc 31 11 80 01 	cmpl   $0x1,0x801131fc
80101db3:	8b 75 08             	mov    0x8(%ebp),%esi
80101db6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101db9:	0f 86 91 00 00 00    	jbe    80101e50 <ialloc+0xb0>
80101dbf:	bf 01 00 00 00       	mov    $0x1,%edi
80101dc4:	eb 21                	jmp    80101de7 <ialloc+0x47>
80101dc6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101dcd:	8d 76 00             	lea    0x0(%esi),%esi
80101dd0:	83 ec 0c             	sub    $0xc,%esp
80101dd3:	83 c7 01             	add    $0x1,%edi
80101dd6:	53                   	push   %ebx
80101dd7:	e8 14 e4 ff ff       	call   801001f0 <brelse>
80101ddc:	83 c4 10             	add    $0x10,%esp
80101ddf:	3b 3d fc 31 11 80    	cmp    0x801131fc,%edi
80101de5:	73 69                	jae    80101e50 <ialloc+0xb0>
80101de7:	89 f8                	mov    %edi,%eax
80101de9:	83 ec 08             	sub    $0x8,%esp
80101dec:	c1 e8 03             	shr    $0x3,%eax
80101def:	03 05 08 32 11 80    	add    0x80113208,%eax
80101df5:	50                   	push   %eax
80101df6:	56                   	push   %esi
80101df7:	e8 d4 e2 ff ff       	call   801000d0 <bread>
80101dfc:	83 c4 10             	add    $0x10,%esp
80101dff:	89 c3                	mov    %eax,%ebx
80101e01:	89 f8                	mov    %edi,%eax
80101e03:	83 e0 07             	and    $0x7,%eax
80101e06:	c1 e0 06             	shl    $0x6,%eax
80101e09:	8d 4c 03 5c          	lea    0x5c(%ebx,%eax,1),%ecx
80101e0d:	66 83 39 00          	cmpw   $0x0,(%ecx)
80101e11:	75 bd                	jne    80101dd0 <ialloc+0x30>
80101e13:	83 ec 04             	sub    $0x4,%esp
80101e16:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80101e19:	6a 40                	push   $0x40
80101e1b:	6a 00                	push   $0x0
80101e1d:	51                   	push   %ecx
80101e1e:	e8 cd 2f 00 00       	call   80104df0 <memset>
80101e23:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
80101e27:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80101e2a:	66 89 01             	mov    %ax,(%ecx)
80101e2d:	89 1c 24             	mov    %ebx,(%esp)
80101e30:	e8 9b 18 00 00       	call   801036d0 <log_write>
80101e35:	89 1c 24             	mov    %ebx,(%esp)
80101e38:	e8 b3 e3 ff ff       	call   801001f0 <brelse>
80101e3d:	83 c4 10             	add    $0x10,%esp
80101e40:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101e43:	89 fa                	mov    %edi,%edx
80101e45:	5b                   	pop    %ebx
80101e46:	89 f0                	mov    %esi,%eax
80101e48:	5e                   	pop    %esi
80101e49:	5f                   	pop    %edi
80101e4a:	5d                   	pop    %ebp
80101e4b:	e9 90 fc ff ff       	jmp    80101ae0 <iget>
80101e50:	83 ec 0c             	sub    $0xc,%esp
80101e53:	68 90 7a 10 80       	push   $0x80107a90
80101e58:	e8 43 e5 ff ff       	call   801003a0 <panic>
80101e5d:	8d 76 00             	lea    0x0(%esi),%esi

80101e60 <iupdate>:
80101e60:	55                   	push   %ebp
80101e61:	89 e5                	mov    %esp,%ebp
80101e63:	56                   	push   %esi
80101e64:	53                   	push   %ebx
80101e65:	8b 5d 08             	mov    0x8(%ebp),%ebx
80101e68:	8b 43 04             	mov    0x4(%ebx),%eax
80101e6b:	83 c3 5c             	add    $0x5c,%ebx
80101e6e:	83 ec 08             	sub    $0x8,%esp
80101e71:	c1 e8 03             	shr    $0x3,%eax
80101e74:	03 05 08 32 11 80    	add    0x80113208,%eax
80101e7a:	50                   	push   %eax
80101e7b:	ff 73 a4             	push   -0x5c(%ebx)
80101e7e:	e8 4d e2 ff ff       	call   801000d0 <bread>
80101e83:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
80101e87:	83 c4 0c             	add    $0xc,%esp
80101e8a:	89 c6                	mov    %eax,%esi
80101e8c:	8b 43 a8             	mov    -0x58(%ebx),%eax
80101e8f:	83 e0 07             	and    $0x7,%eax
80101e92:	c1 e0 06             	shl    $0x6,%eax
80101e95:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
80101e99:	66 89 10             	mov    %dx,(%eax)
80101e9c:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
80101ea0:	83 c0 0c             	add    $0xc,%eax
80101ea3:	66 89 50 f6          	mov    %dx,-0xa(%eax)
80101ea7:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
80101eab:	66 89 50 f8          	mov    %dx,-0x8(%eax)
80101eaf:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
80101eb3:	66 89 50 fa          	mov    %dx,-0x6(%eax)
80101eb7:	8b 53 fc             	mov    -0x4(%ebx),%edx
80101eba:	89 50 fc             	mov    %edx,-0x4(%eax)
80101ebd:	6a 34                	push   $0x34
80101ebf:	53                   	push   %ebx
80101ec0:	50                   	push   %eax
80101ec1:	e8 ca 2f 00 00       	call   80104e90 <memmove>
80101ec6:	89 34 24             	mov    %esi,(%esp)
80101ec9:	e8 02 18 00 00       	call   801036d0 <log_write>
80101ece:	89 75 08             	mov    %esi,0x8(%ebp)
80101ed1:	83 c4 10             	add    $0x10,%esp
80101ed4:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101ed7:	5b                   	pop    %ebx
80101ed8:	5e                   	pop    %esi
80101ed9:	5d                   	pop    %ebp
80101eda:	e9 11 e3 ff ff       	jmp    801001f0 <brelse>
80101edf:	90                   	nop

80101ee0 <idup>:
80101ee0:	55                   	push   %ebp
80101ee1:	89 e5                	mov    %esp,%ebp
80101ee3:	53                   	push   %ebx
80101ee4:	83 ec 10             	sub    $0x10,%esp
80101ee7:	8b 5d 08             	mov    0x8(%ebp),%ebx
80101eea:	68 a0 15 11 80       	push   $0x801115a0
80101eef:	e8 3c 2e 00 00       	call   80104d30 <acquire>
80101ef4:	83 43 08 01          	addl   $0x1,0x8(%ebx)
80101ef8:	c7 04 24 a0 15 11 80 	movl   $0x801115a0,(%esp)
80101eff:	e8 cc 2d 00 00       	call   80104cd0 <release>
80101f04:	89 d8                	mov    %ebx,%eax
80101f06:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101f09:	c9                   	leave  
80101f0a:	c3                   	ret    
80101f0b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101f0f:	90                   	nop

80101f10 <ilock>:
80101f10:	55                   	push   %ebp
80101f11:	89 e5                	mov    %esp,%ebp
80101f13:	56                   	push   %esi
80101f14:	53                   	push   %ebx
80101f15:	8b 5d 08             	mov    0x8(%ebp),%ebx
80101f18:	85 db                	test   %ebx,%ebx
80101f1a:	0f 84 b7 00 00 00    	je     80101fd7 <ilock+0xc7>
80101f20:	8b 53 08             	mov    0x8(%ebx),%edx
80101f23:	85 d2                	test   %edx,%edx
80101f25:	0f 8e ac 00 00 00    	jle    80101fd7 <ilock+0xc7>
80101f2b:	83 ec 0c             	sub    $0xc,%esp
80101f2e:	8d 43 0c             	lea    0xc(%ebx),%eax
80101f31:	50                   	push   %eax
80101f32:	e8 39 2b 00 00       	call   80104a70 <acquiresleep>
80101f37:	8b 43 4c             	mov    0x4c(%ebx),%eax
80101f3a:	83 c4 10             	add    $0x10,%esp
80101f3d:	85 c0                	test   %eax,%eax
80101f3f:	74 0f                	je     80101f50 <ilock+0x40>
80101f41:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101f44:	5b                   	pop    %ebx
80101f45:	5e                   	pop    %esi
80101f46:	5d                   	pop    %ebp
80101f47:	c3                   	ret    
80101f48:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101f4f:	90                   	nop
80101f50:	8b 43 04             	mov    0x4(%ebx),%eax
80101f53:	83 ec 08             	sub    $0x8,%esp
80101f56:	c1 e8 03             	shr    $0x3,%eax
80101f59:	03 05 08 32 11 80    	add    0x80113208,%eax
80101f5f:	50                   	push   %eax
80101f60:	ff 33                	push   (%ebx)
80101f62:	e8 69 e1 ff ff       	call   801000d0 <bread>
80101f67:	83 c4 0c             	add    $0xc,%esp
80101f6a:	89 c6                	mov    %eax,%esi
80101f6c:	8b 43 04             	mov    0x4(%ebx),%eax
80101f6f:	83 e0 07             	and    $0x7,%eax
80101f72:	c1 e0 06             	shl    $0x6,%eax
80101f75:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
80101f79:	0f b7 10             	movzwl (%eax),%edx
80101f7c:	83 c0 0c             	add    $0xc,%eax
80101f7f:	66 89 53 50          	mov    %dx,0x50(%ebx)
80101f83:	0f b7 50 f6          	movzwl -0xa(%eax),%edx
80101f87:	66 89 53 52          	mov    %dx,0x52(%ebx)
80101f8b:	0f b7 50 f8          	movzwl -0x8(%eax),%edx
80101f8f:	66 89 53 54          	mov    %dx,0x54(%ebx)
80101f93:	0f b7 50 fa          	movzwl -0x6(%eax),%edx
80101f97:	66 89 53 56          	mov    %dx,0x56(%ebx)
80101f9b:	8b 50 fc             	mov    -0x4(%eax),%edx
80101f9e:	89 53 58             	mov    %edx,0x58(%ebx)
80101fa1:	6a 34                	push   $0x34
80101fa3:	50                   	push   %eax
80101fa4:	8d 43 5c             	lea    0x5c(%ebx),%eax
80101fa7:	50                   	push   %eax
80101fa8:	e8 e3 2e 00 00       	call   80104e90 <memmove>
80101fad:	89 34 24             	mov    %esi,(%esp)
80101fb0:	e8 3b e2 ff ff       	call   801001f0 <brelse>
80101fb5:	83 c4 10             	add    $0x10,%esp
80101fb8:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
80101fbd:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
80101fc4:	0f 85 77 ff ff ff    	jne    80101f41 <ilock+0x31>
80101fca:	83 ec 0c             	sub    $0xc,%esp
80101fcd:	68 a8 7a 10 80       	push   $0x80107aa8
80101fd2:	e8 c9 e3 ff ff       	call   801003a0 <panic>
80101fd7:	83 ec 0c             	sub    $0xc,%esp
80101fda:	68 a2 7a 10 80       	push   $0x80107aa2
80101fdf:	e8 bc e3 ff ff       	call   801003a0 <panic>
80101fe4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101feb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101fef:	90                   	nop

80101ff0 <iunlock>:
80101ff0:	55                   	push   %ebp
80101ff1:	89 e5                	mov    %esp,%ebp
80101ff3:	56                   	push   %esi
80101ff4:	53                   	push   %ebx
80101ff5:	8b 5d 08             	mov    0x8(%ebp),%ebx
80101ff8:	85 db                	test   %ebx,%ebx
80101ffa:	74 28                	je     80102024 <iunlock+0x34>
80101ffc:	83 ec 0c             	sub    $0xc,%esp
80101fff:	8d 73 0c             	lea    0xc(%ebx),%esi
80102002:	56                   	push   %esi
80102003:	e8 08 2b 00 00       	call   80104b10 <holdingsleep>
80102008:	83 c4 10             	add    $0x10,%esp
8010200b:	85 c0                	test   %eax,%eax
8010200d:	74 15                	je     80102024 <iunlock+0x34>
8010200f:	8b 43 08             	mov    0x8(%ebx),%eax
80102012:	85 c0                	test   %eax,%eax
80102014:	7e 0e                	jle    80102024 <iunlock+0x34>
80102016:	89 75 08             	mov    %esi,0x8(%ebp)
80102019:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010201c:	5b                   	pop    %ebx
8010201d:	5e                   	pop    %esi
8010201e:	5d                   	pop    %ebp
8010201f:	e9 ac 2a 00 00       	jmp    80104ad0 <releasesleep>
80102024:	83 ec 0c             	sub    $0xc,%esp
80102027:	68 b7 7a 10 80       	push   $0x80107ab7
8010202c:	e8 6f e3 ff ff       	call   801003a0 <panic>
80102031:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102038:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010203f:	90                   	nop

80102040 <iput>:
80102040:	55                   	push   %ebp
80102041:	89 e5                	mov    %esp,%ebp
80102043:	57                   	push   %edi
80102044:	56                   	push   %esi
80102045:	53                   	push   %ebx
80102046:	83 ec 28             	sub    $0x28,%esp
80102049:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010204c:	8d 7b 0c             	lea    0xc(%ebx),%edi
8010204f:	57                   	push   %edi
80102050:	e8 1b 2a 00 00       	call   80104a70 <acquiresleep>
80102055:	8b 53 4c             	mov    0x4c(%ebx),%edx
80102058:	83 c4 10             	add    $0x10,%esp
8010205b:	85 d2                	test   %edx,%edx
8010205d:	74 07                	je     80102066 <iput+0x26>
8010205f:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80102064:	74 32                	je     80102098 <iput+0x58>
80102066:	83 ec 0c             	sub    $0xc,%esp
80102069:	57                   	push   %edi
8010206a:	e8 61 2a 00 00       	call   80104ad0 <releasesleep>
8010206f:	c7 04 24 a0 15 11 80 	movl   $0x801115a0,(%esp)
80102076:	e8 b5 2c 00 00       	call   80104d30 <acquire>
8010207b:	83 6b 08 01          	subl   $0x1,0x8(%ebx)
8010207f:	83 c4 10             	add    $0x10,%esp
80102082:	c7 45 08 a0 15 11 80 	movl   $0x801115a0,0x8(%ebp)
80102089:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010208c:	5b                   	pop    %ebx
8010208d:	5e                   	pop    %esi
8010208e:	5f                   	pop    %edi
8010208f:	5d                   	pop    %ebp
80102090:	e9 3b 2c 00 00       	jmp    80104cd0 <release>
80102095:	8d 76 00             	lea    0x0(%esi),%esi
80102098:	83 ec 0c             	sub    $0xc,%esp
8010209b:	68 a0 15 11 80       	push   $0x801115a0
801020a0:	e8 8b 2c 00 00       	call   80104d30 <acquire>
801020a5:	8b 73 08             	mov    0x8(%ebx),%esi
801020a8:	c7 04 24 a0 15 11 80 	movl   $0x801115a0,(%esp)
801020af:	e8 1c 2c 00 00       	call   80104cd0 <release>
801020b4:	83 c4 10             	add    $0x10,%esp
801020b7:	83 fe 01             	cmp    $0x1,%esi
801020ba:	75 aa                	jne    80102066 <iput+0x26>
801020bc:	8d 8b 8c 00 00 00    	lea    0x8c(%ebx),%ecx
801020c2:	89 7d e4             	mov    %edi,-0x1c(%ebp)
801020c5:	8d 73 5c             	lea    0x5c(%ebx),%esi
801020c8:	89 cf                	mov    %ecx,%edi
801020ca:	eb 0b                	jmp    801020d7 <iput+0x97>
801020cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801020d0:	83 c6 04             	add    $0x4,%esi
801020d3:	39 fe                	cmp    %edi,%esi
801020d5:	74 19                	je     801020f0 <iput+0xb0>
801020d7:	8b 16                	mov    (%esi),%edx
801020d9:	85 d2                	test   %edx,%edx
801020db:	74 f3                	je     801020d0 <iput+0x90>
801020dd:	8b 03                	mov    (%ebx),%eax
801020df:	e8 6c f8 ff ff       	call   80101950 <bfree>
801020e4:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
801020ea:	eb e4                	jmp    801020d0 <iput+0x90>
801020ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801020f0:	8b 83 8c 00 00 00    	mov    0x8c(%ebx),%eax
801020f6:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801020f9:	85 c0                	test   %eax,%eax
801020fb:	75 2d                	jne    8010212a <iput+0xea>
801020fd:	83 ec 0c             	sub    $0xc,%esp
80102100:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
80102107:	53                   	push   %ebx
80102108:	e8 53 fd ff ff       	call   80101e60 <iupdate>
8010210d:	31 c0                	xor    %eax,%eax
8010210f:	66 89 43 50          	mov    %ax,0x50(%ebx)
80102113:	89 1c 24             	mov    %ebx,(%esp)
80102116:	e8 45 fd ff ff       	call   80101e60 <iupdate>
8010211b:	c7 43 4c 00 00 00 00 	movl   $0x0,0x4c(%ebx)
80102122:	83 c4 10             	add    $0x10,%esp
80102125:	e9 3c ff ff ff       	jmp    80102066 <iput+0x26>
8010212a:	83 ec 08             	sub    $0x8,%esp
8010212d:	50                   	push   %eax
8010212e:	ff 33                	push   (%ebx)
80102130:	e8 9b df ff ff       	call   801000d0 <bread>
80102135:	89 7d e0             	mov    %edi,-0x20(%ebp)
80102138:	83 c4 10             	add    $0x10,%esp
8010213b:	8d 88 5c 02 00 00    	lea    0x25c(%eax),%ecx
80102141:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80102144:	8d 70 5c             	lea    0x5c(%eax),%esi
80102147:	89 cf                	mov    %ecx,%edi
80102149:	eb 0c                	jmp    80102157 <iput+0x117>
8010214b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010214f:	90                   	nop
80102150:	83 c6 04             	add    $0x4,%esi
80102153:	39 f7                	cmp    %esi,%edi
80102155:	74 0f                	je     80102166 <iput+0x126>
80102157:	8b 16                	mov    (%esi),%edx
80102159:	85 d2                	test   %edx,%edx
8010215b:	74 f3                	je     80102150 <iput+0x110>
8010215d:	8b 03                	mov    (%ebx),%eax
8010215f:	e8 ec f7 ff ff       	call   80101950 <bfree>
80102164:	eb ea                	jmp    80102150 <iput+0x110>
80102166:	83 ec 0c             	sub    $0xc,%esp
80102169:	ff 75 e4             	push   -0x1c(%ebp)
8010216c:	8b 7d e0             	mov    -0x20(%ebp),%edi
8010216f:	e8 7c e0 ff ff       	call   801001f0 <brelse>
80102174:	8b 93 8c 00 00 00    	mov    0x8c(%ebx),%edx
8010217a:	8b 03                	mov    (%ebx),%eax
8010217c:	e8 cf f7 ff ff       	call   80101950 <bfree>
80102181:	83 c4 10             	add    $0x10,%esp
80102184:	c7 83 8c 00 00 00 00 	movl   $0x0,0x8c(%ebx)
8010218b:	00 00 00 
8010218e:	e9 6a ff ff ff       	jmp    801020fd <iput+0xbd>
80102193:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010219a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801021a0 <iunlockput>:
801021a0:	55                   	push   %ebp
801021a1:	89 e5                	mov    %esp,%ebp
801021a3:	56                   	push   %esi
801021a4:	53                   	push   %ebx
801021a5:	8b 5d 08             	mov    0x8(%ebp),%ebx
801021a8:	85 db                	test   %ebx,%ebx
801021aa:	74 34                	je     801021e0 <iunlockput+0x40>
801021ac:	83 ec 0c             	sub    $0xc,%esp
801021af:	8d 73 0c             	lea    0xc(%ebx),%esi
801021b2:	56                   	push   %esi
801021b3:	e8 58 29 00 00       	call   80104b10 <holdingsleep>
801021b8:	83 c4 10             	add    $0x10,%esp
801021bb:	85 c0                	test   %eax,%eax
801021bd:	74 21                	je     801021e0 <iunlockput+0x40>
801021bf:	8b 43 08             	mov    0x8(%ebx),%eax
801021c2:	85 c0                	test   %eax,%eax
801021c4:	7e 1a                	jle    801021e0 <iunlockput+0x40>
801021c6:	83 ec 0c             	sub    $0xc,%esp
801021c9:	56                   	push   %esi
801021ca:	e8 01 29 00 00       	call   80104ad0 <releasesleep>
801021cf:	89 5d 08             	mov    %ebx,0x8(%ebp)
801021d2:	83 c4 10             	add    $0x10,%esp
801021d5:	8d 65 f8             	lea    -0x8(%ebp),%esp
801021d8:	5b                   	pop    %ebx
801021d9:	5e                   	pop    %esi
801021da:	5d                   	pop    %ebp
801021db:	e9 60 fe ff ff       	jmp    80102040 <iput>
801021e0:	83 ec 0c             	sub    $0xc,%esp
801021e3:	68 b7 7a 10 80       	push   $0x80107ab7
801021e8:	e8 b3 e1 ff ff       	call   801003a0 <panic>
801021ed:	8d 76 00             	lea    0x0(%esi),%esi

801021f0 <stati>:
801021f0:	55                   	push   %ebp
801021f1:	89 e5                	mov    %esp,%ebp
801021f3:	8b 55 08             	mov    0x8(%ebp),%edx
801021f6:	8b 45 0c             	mov    0xc(%ebp),%eax
801021f9:	8b 0a                	mov    (%edx),%ecx
801021fb:	89 48 04             	mov    %ecx,0x4(%eax)
801021fe:	8b 4a 04             	mov    0x4(%edx),%ecx
80102201:	89 48 08             	mov    %ecx,0x8(%eax)
80102204:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
80102208:	66 89 08             	mov    %cx,(%eax)
8010220b:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
8010220f:	66 89 48 0c          	mov    %cx,0xc(%eax)
80102213:	8b 52 58             	mov    0x58(%edx),%edx
80102216:	89 50 10             	mov    %edx,0x10(%eax)
80102219:	5d                   	pop    %ebp
8010221a:	c3                   	ret    
8010221b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010221f:	90                   	nop

80102220 <readi>:
80102220:	55                   	push   %ebp
80102221:	89 e5                	mov    %esp,%ebp
80102223:	57                   	push   %edi
80102224:	56                   	push   %esi
80102225:	53                   	push   %ebx
80102226:	83 ec 1c             	sub    $0x1c,%esp
80102229:	8b 7d 0c             	mov    0xc(%ebp),%edi
8010222c:	8b 45 08             	mov    0x8(%ebp),%eax
8010222f:	8b 75 10             	mov    0x10(%ebp),%esi
80102232:	89 7d e0             	mov    %edi,-0x20(%ebp)
80102235:	8b 7d 14             	mov    0x14(%ebp),%edi
80102238:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
8010223d:	89 45 d8             	mov    %eax,-0x28(%ebp)
80102240:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80102243:	0f 84 a7 00 00 00    	je     801022f0 <readi+0xd0>
80102249:	8b 45 d8             	mov    -0x28(%ebp),%eax
8010224c:	8b 40 58             	mov    0x58(%eax),%eax
8010224f:	39 c6                	cmp    %eax,%esi
80102251:	0f 87 ba 00 00 00    	ja     80102311 <readi+0xf1>
80102257:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
8010225a:	31 c9                	xor    %ecx,%ecx
8010225c:	89 da                	mov    %ebx,%edx
8010225e:	01 f2                	add    %esi,%edx
80102260:	0f 92 c1             	setb   %cl
80102263:	89 cf                	mov    %ecx,%edi
80102265:	0f 82 a6 00 00 00    	jb     80102311 <readi+0xf1>
8010226b:	89 c1                	mov    %eax,%ecx
8010226d:	29 f1                	sub    %esi,%ecx
8010226f:	39 d0                	cmp    %edx,%eax
80102271:	0f 43 cb             	cmovae %ebx,%ecx
80102274:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80102277:	85 c9                	test   %ecx,%ecx
80102279:	74 67                	je     801022e2 <readi+0xc2>
8010227b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010227f:	90                   	nop
80102280:	8b 5d d8             	mov    -0x28(%ebp),%ebx
80102283:	89 f2                	mov    %esi,%edx
80102285:	c1 ea 09             	shr    $0x9,%edx
80102288:	89 d8                	mov    %ebx,%eax
8010228a:	e8 51 f9 ff ff       	call   80101be0 <bmap>
8010228f:	83 ec 08             	sub    $0x8,%esp
80102292:	50                   	push   %eax
80102293:	ff 33                	push   (%ebx)
80102295:	e8 36 de ff ff       	call   801000d0 <bread>
8010229a:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
8010229d:	b9 00 02 00 00       	mov    $0x200,%ecx
801022a2:	89 c2                	mov    %eax,%edx
801022a4:	89 f0                	mov    %esi,%eax
801022a6:	25 ff 01 00 00       	and    $0x1ff,%eax
801022ab:	29 fb                	sub    %edi,%ebx
801022ad:	89 55 dc             	mov    %edx,-0x24(%ebp)
801022b0:	29 c1                	sub    %eax,%ecx
801022b2:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
801022b6:	39 d9                	cmp    %ebx,%ecx
801022b8:	0f 46 d9             	cmovbe %ecx,%ebx
801022bb:	83 c4 0c             	add    $0xc,%esp
801022be:	53                   	push   %ebx
801022bf:	01 df                	add    %ebx,%edi
801022c1:	01 de                	add    %ebx,%esi
801022c3:	50                   	push   %eax
801022c4:	ff 75 e0             	push   -0x20(%ebp)
801022c7:	e8 c4 2b 00 00       	call   80104e90 <memmove>
801022cc:	8b 55 dc             	mov    -0x24(%ebp),%edx
801022cf:	89 14 24             	mov    %edx,(%esp)
801022d2:	e8 19 df ff ff       	call   801001f0 <brelse>
801022d7:	01 5d e0             	add    %ebx,-0x20(%ebp)
801022da:	83 c4 10             	add    $0x10,%esp
801022dd:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
801022e0:	77 9e                	ja     80102280 <readi+0x60>
801022e2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801022e5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801022e8:	5b                   	pop    %ebx
801022e9:	5e                   	pop    %esi
801022ea:	5f                   	pop    %edi
801022eb:	5d                   	pop    %ebp
801022ec:	c3                   	ret    
801022ed:	8d 76 00             	lea    0x0(%esi),%esi
801022f0:	0f bf 40 52          	movswl 0x52(%eax),%eax
801022f4:	66 83 f8 09          	cmp    $0x9,%ax
801022f8:	77 17                	ja     80102311 <readi+0xf1>
801022fa:	8b 04 c5 40 15 11 80 	mov    -0x7feeeac0(,%eax,8),%eax
80102301:	85 c0                	test   %eax,%eax
80102303:	74 0c                	je     80102311 <readi+0xf1>
80102305:	89 7d 10             	mov    %edi,0x10(%ebp)
80102308:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010230b:	5b                   	pop    %ebx
8010230c:	5e                   	pop    %esi
8010230d:	5f                   	pop    %edi
8010230e:	5d                   	pop    %ebp
8010230f:	ff e0                	jmp    *%eax
80102311:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102316:	eb cd                	jmp    801022e5 <readi+0xc5>
80102318:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010231f:	90                   	nop

80102320 <writei>:
80102320:	55                   	push   %ebp
80102321:	89 e5                	mov    %esp,%ebp
80102323:	57                   	push   %edi
80102324:	56                   	push   %esi
80102325:	53                   	push   %ebx
80102326:	83 ec 1c             	sub    $0x1c,%esp
80102329:	8b 45 08             	mov    0x8(%ebp),%eax
8010232c:	8b 75 0c             	mov    0xc(%ebp),%esi
8010232f:	8b 55 14             	mov    0x14(%ebp),%edx
80102332:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
80102337:	89 75 dc             	mov    %esi,-0x24(%ebp)
8010233a:	89 45 d8             	mov    %eax,-0x28(%ebp)
8010233d:	8b 75 10             	mov    0x10(%ebp),%esi
80102340:	89 55 e0             	mov    %edx,-0x20(%ebp)
80102343:	0f 84 b7 00 00 00    	je     80102400 <writei+0xe0>
80102349:	8b 45 d8             	mov    -0x28(%ebp),%eax
8010234c:	3b 70 58             	cmp    0x58(%eax),%esi
8010234f:	0f 87 e7 00 00 00    	ja     8010243c <writei+0x11c>
80102355:	8b 7d e0             	mov    -0x20(%ebp),%edi
80102358:	31 d2                	xor    %edx,%edx
8010235a:	89 f8                	mov    %edi,%eax
8010235c:	01 f0                	add    %esi,%eax
8010235e:	0f 92 c2             	setb   %dl
80102361:	3d 00 18 01 00       	cmp    $0x11800,%eax
80102366:	0f 87 d0 00 00 00    	ja     8010243c <writei+0x11c>
8010236c:	85 d2                	test   %edx,%edx
8010236e:	0f 85 c8 00 00 00    	jne    8010243c <writei+0x11c>
80102374:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
8010237b:	85 ff                	test   %edi,%edi
8010237d:	74 72                	je     801023f1 <writei+0xd1>
8010237f:	90                   	nop
80102380:	8b 7d d8             	mov    -0x28(%ebp),%edi
80102383:	89 f2                	mov    %esi,%edx
80102385:	c1 ea 09             	shr    $0x9,%edx
80102388:	89 f8                	mov    %edi,%eax
8010238a:	e8 51 f8 ff ff       	call   80101be0 <bmap>
8010238f:	83 ec 08             	sub    $0x8,%esp
80102392:	50                   	push   %eax
80102393:	ff 37                	push   (%edi)
80102395:	e8 36 dd ff ff       	call   801000d0 <bread>
8010239a:	b9 00 02 00 00       	mov    $0x200,%ecx
8010239f:	8b 5d e0             	mov    -0x20(%ebp),%ebx
801023a2:	2b 5d e4             	sub    -0x1c(%ebp),%ebx
801023a5:	89 c7                	mov    %eax,%edi
801023a7:	89 f0                	mov    %esi,%eax
801023a9:	25 ff 01 00 00       	and    $0x1ff,%eax
801023ae:	29 c1                	sub    %eax,%ecx
801023b0:	8d 44 07 5c          	lea    0x5c(%edi,%eax,1),%eax
801023b4:	39 d9                	cmp    %ebx,%ecx
801023b6:	0f 46 d9             	cmovbe %ecx,%ebx
801023b9:	83 c4 0c             	add    $0xc,%esp
801023bc:	53                   	push   %ebx
801023bd:	01 de                	add    %ebx,%esi
801023bf:	ff 75 dc             	push   -0x24(%ebp)
801023c2:	50                   	push   %eax
801023c3:	e8 c8 2a 00 00       	call   80104e90 <memmove>
801023c8:	89 3c 24             	mov    %edi,(%esp)
801023cb:	e8 00 13 00 00       	call   801036d0 <log_write>
801023d0:	89 3c 24             	mov    %edi,(%esp)
801023d3:	e8 18 de ff ff       	call   801001f0 <brelse>
801023d8:	01 5d e4             	add    %ebx,-0x1c(%ebp)
801023db:	83 c4 10             	add    $0x10,%esp
801023de:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801023e1:	01 5d dc             	add    %ebx,-0x24(%ebp)
801023e4:	39 45 e0             	cmp    %eax,-0x20(%ebp)
801023e7:	77 97                	ja     80102380 <writei+0x60>
801023e9:	8b 45 d8             	mov    -0x28(%ebp),%eax
801023ec:	3b 70 58             	cmp    0x58(%eax),%esi
801023ef:	77 37                	ja     80102428 <writei+0x108>
801023f1:	8b 45 e0             	mov    -0x20(%ebp),%eax
801023f4:	8d 65 f4             	lea    -0xc(%ebp),%esp
801023f7:	5b                   	pop    %ebx
801023f8:	5e                   	pop    %esi
801023f9:	5f                   	pop    %edi
801023fa:	5d                   	pop    %ebp
801023fb:	c3                   	ret    
801023fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102400:	0f bf 40 52          	movswl 0x52(%eax),%eax
80102404:	66 83 f8 09          	cmp    $0x9,%ax
80102408:	77 32                	ja     8010243c <writei+0x11c>
8010240a:	8b 04 c5 44 15 11 80 	mov    -0x7feeeabc(,%eax,8),%eax
80102411:	85 c0                	test   %eax,%eax
80102413:	74 27                	je     8010243c <writei+0x11c>
80102415:	89 55 10             	mov    %edx,0x10(%ebp)
80102418:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010241b:	5b                   	pop    %ebx
8010241c:	5e                   	pop    %esi
8010241d:	5f                   	pop    %edi
8010241e:	5d                   	pop    %ebp
8010241f:	ff e0                	jmp    *%eax
80102421:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102428:	8b 45 d8             	mov    -0x28(%ebp),%eax
8010242b:	83 ec 0c             	sub    $0xc,%esp
8010242e:	89 70 58             	mov    %esi,0x58(%eax)
80102431:	50                   	push   %eax
80102432:	e8 29 fa ff ff       	call   80101e60 <iupdate>
80102437:	83 c4 10             	add    $0x10,%esp
8010243a:	eb b5                	jmp    801023f1 <writei+0xd1>
8010243c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102441:	eb b1                	jmp    801023f4 <writei+0xd4>
80102443:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010244a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102450 <namecmp>:
80102450:	55                   	push   %ebp
80102451:	89 e5                	mov    %esp,%ebp
80102453:	83 ec 0c             	sub    $0xc,%esp
80102456:	6a 0e                	push   $0xe
80102458:	ff 75 0c             	push   0xc(%ebp)
8010245b:	ff 75 08             	push   0x8(%ebp)
8010245e:	e8 9d 2a 00 00       	call   80104f00 <strncmp>
80102463:	c9                   	leave  
80102464:	c3                   	ret    
80102465:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010246c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102470 <dirlookup>:
80102470:	55                   	push   %ebp
80102471:	89 e5                	mov    %esp,%ebp
80102473:	57                   	push   %edi
80102474:	56                   	push   %esi
80102475:	53                   	push   %ebx
80102476:	83 ec 1c             	sub    $0x1c,%esp
80102479:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010247c:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80102481:	0f 85 85 00 00 00    	jne    8010250c <dirlookup+0x9c>
80102487:	8b 53 58             	mov    0x58(%ebx),%edx
8010248a:	31 ff                	xor    %edi,%edi
8010248c:	8d 75 d8             	lea    -0x28(%ebp),%esi
8010248f:	85 d2                	test   %edx,%edx
80102491:	74 3e                	je     801024d1 <dirlookup+0x61>
80102493:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102497:	90                   	nop
80102498:	6a 10                	push   $0x10
8010249a:	57                   	push   %edi
8010249b:	56                   	push   %esi
8010249c:	53                   	push   %ebx
8010249d:	e8 7e fd ff ff       	call   80102220 <readi>
801024a2:	83 c4 10             	add    $0x10,%esp
801024a5:	83 f8 10             	cmp    $0x10,%eax
801024a8:	75 55                	jne    801024ff <dirlookup+0x8f>
801024aa:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
801024af:	74 18                	je     801024c9 <dirlookup+0x59>
801024b1:	83 ec 04             	sub    $0x4,%esp
801024b4:	8d 45 da             	lea    -0x26(%ebp),%eax
801024b7:	6a 0e                	push   $0xe
801024b9:	50                   	push   %eax
801024ba:	ff 75 0c             	push   0xc(%ebp)
801024bd:	e8 3e 2a 00 00       	call   80104f00 <strncmp>
801024c2:	83 c4 10             	add    $0x10,%esp
801024c5:	85 c0                	test   %eax,%eax
801024c7:	74 17                	je     801024e0 <dirlookup+0x70>
801024c9:	83 c7 10             	add    $0x10,%edi
801024cc:	3b 7b 58             	cmp    0x58(%ebx),%edi
801024cf:	72 c7                	jb     80102498 <dirlookup+0x28>
801024d1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801024d4:	31 c0                	xor    %eax,%eax
801024d6:	5b                   	pop    %ebx
801024d7:	5e                   	pop    %esi
801024d8:	5f                   	pop    %edi
801024d9:	5d                   	pop    %ebp
801024da:	c3                   	ret    
801024db:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801024df:	90                   	nop
801024e0:	8b 45 10             	mov    0x10(%ebp),%eax
801024e3:	85 c0                	test   %eax,%eax
801024e5:	74 05                	je     801024ec <dirlookup+0x7c>
801024e7:	8b 45 10             	mov    0x10(%ebp),%eax
801024ea:	89 38                	mov    %edi,(%eax)
801024ec:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
801024f0:	8b 03                	mov    (%ebx),%eax
801024f2:	e8 e9 f5 ff ff       	call   80101ae0 <iget>
801024f7:	8d 65 f4             	lea    -0xc(%ebp),%esp
801024fa:	5b                   	pop    %ebx
801024fb:	5e                   	pop    %esi
801024fc:	5f                   	pop    %edi
801024fd:	5d                   	pop    %ebp
801024fe:	c3                   	ret    
801024ff:	83 ec 0c             	sub    $0xc,%esp
80102502:	68 d1 7a 10 80       	push   $0x80107ad1
80102507:	e8 94 de ff ff       	call   801003a0 <panic>
8010250c:	83 ec 0c             	sub    $0xc,%esp
8010250f:	68 bf 7a 10 80       	push   $0x80107abf
80102514:	e8 87 de ff ff       	call   801003a0 <panic>
80102519:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102520 <namex>:
80102520:	55                   	push   %ebp
80102521:	89 e5                	mov    %esp,%ebp
80102523:	57                   	push   %edi
80102524:	56                   	push   %esi
80102525:	53                   	push   %ebx
80102526:	89 c3                	mov    %eax,%ebx
80102528:	83 ec 1c             	sub    $0x1c,%esp
8010252b:	80 38 2f             	cmpb   $0x2f,(%eax)
8010252e:	89 55 dc             	mov    %edx,-0x24(%ebp)
80102531:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80102534:	0f 84 64 01 00 00    	je     8010269e <namex+0x17e>
8010253a:	e8 c1 1b 00 00       	call   80104100 <myproc>
8010253f:	83 ec 0c             	sub    $0xc,%esp
80102542:	8b 70 68             	mov    0x68(%eax),%esi
80102545:	68 a0 15 11 80       	push   $0x801115a0
8010254a:	e8 e1 27 00 00       	call   80104d30 <acquire>
8010254f:	83 46 08 01          	addl   $0x1,0x8(%esi)
80102553:	c7 04 24 a0 15 11 80 	movl   $0x801115a0,(%esp)
8010255a:	e8 71 27 00 00       	call   80104cd0 <release>
8010255f:	83 c4 10             	add    $0x10,%esp
80102562:	eb 07                	jmp    8010256b <namex+0x4b>
80102564:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102568:	83 c3 01             	add    $0x1,%ebx
8010256b:	0f b6 03             	movzbl (%ebx),%eax
8010256e:	3c 2f                	cmp    $0x2f,%al
80102570:	74 f6                	je     80102568 <namex+0x48>
80102572:	84 c0                	test   %al,%al
80102574:	0f 84 06 01 00 00    	je     80102680 <namex+0x160>
8010257a:	0f b6 03             	movzbl (%ebx),%eax
8010257d:	84 c0                	test   %al,%al
8010257f:	0f 84 10 01 00 00    	je     80102695 <namex+0x175>
80102585:	89 df                	mov    %ebx,%edi
80102587:	3c 2f                	cmp    $0x2f,%al
80102589:	0f 84 06 01 00 00    	je     80102695 <namex+0x175>
8010258f:	90                   	nop
80102590:	0f b6 47 01          	movzbl 0x1(%edi),%eax
80102594:	83 c7 01             	add    $0x1,%edi
80102597:	3c 2f                	cmp    $0x2f,%al
80102599:	74 04                	je     8010259f <namex+0x7f>
8010259b:	84 c0                	test   %al,%al
8010259d:	75 f1                	jne    80102590 <namex+0x70>
8010259f:	89 f8                	mov    %edi,%eax
801025a1:	29 d8                	sub    %ebx,%eax
801025a3:	83 f8 0d             	cmp    $0xd,%eax
801025a6:	0f 8e ac 00 00 00    	jle    80102658 <namex+0x138>
801025ac:	83 ec 04             	sub    $0x4,%esp
801025af:	6a 0e                	push   $0xe
801025b1:	53                   	push   %ebx
801025b2:	89 fb                	mov    %edi,%ebx
801025b4:	ff 75 e4             	push   -0x1c(%ebp)
801025b7:	e8 d4 28 00 00       	call   80104e90 <memmove>
801025bc:	83 c4 10             	add    $0x10,%esp
801025bf:	80 3f 2f             	cmpb   $0x2f,(%edi)
801025c2:	75 0c                	jne    801025d0 <namex+0xb0>
801025c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801025c8:	83 c3 01             	add    $0x1,%ebx
801025cb:	80 3b 2f             	cmpb   $0x2f,(%ebx)
801025ce:	74 f8                	je     801025c8 <namex+0xa8>
801025d0:	83 ec 0c             	sub    $0xc,%esp
801025d3:	56                   	push   %esi
801025d4:	e8 37 f9 ff ff       	call   80101f10 <ilock>
801025d9:	83 c4 10             	add    $0x10,%esp
801025dc:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
801025e1:	0f 85 cd 00 00 00    	jne    801026b4 <namex+0x194>
801025e7:	8b 45 dc             	mov    -0x24(%ebp),%eax
801025ea:	85 c0                	test   %eax,%eax
801025ec:	74 09                	je     801025f7 <namex+0xd7>
801025ee:	80 3b 00             	cmpb   $0x0,(%ebx)
801025f1:	0f 84 22 01 00 00    	je     80102719 <namex+0x1f9>
801025f7:	83 ec 04             	sub    $0x4,%esp
801025fa:	6a 00                	push   $0x0
801025fc:	ff 75 e4             	push   -0x1c(%ebp)
801025ff:	56                   	push   %esi
80102600:	e8 6b fe ff ff       	call   80102470 <dirlookup>
80102605:	8d 56 0c             	lea    0xc(%esi),%edx
80102608:	83 c4 10             	add    $0x10,%esp
8010260b:	89 c7                	mov    %eax,%edi
8010260d:	85 c0                	test   %eax,%eax
8010260f:	0f 84 e1 00 00 00    	je     801026f6 <namex+0x1d6>
80102615:	83 ec 0c             	sub    $0xc,%esp
80102618:	89 55 e0             	mov    %edx,-0x20(%ebp)
8010261b:	52                   	push   %edx
8010261c:	e8 ef 24 00 00       	call   80104b10 <holdingsleep>
80102621:	83 c4 10             	add    $0x10,%esp
80102624:	85 c0                	test   %eax,%eax
80102626:	0f 84 30 01 00 00    	je     8010275c <namex+0x23c>
8010262c:	8b 56 08             	mov    0x8(%esi),%edx
8010262f:	85 d2                	test   %edx,%edx
80102631:	0f 8e 25 01 00 00    	jle    8010275c <namex+0x23c>
80102637:	8b 55 e0             	mov    -0x20(%ebp),%edx
8010263a:	83 ec 0c             	sub    $0xc,%esp
8010263d:	52                   	push   %edx
8010263e:	e8 8d 24 00 00       	call   80104ad0 <releasesleep>
80102643:	89 34 24             	mov    %esi,(%esp)
80102646:	89 fe                	mov    %edi,%esi
80102648:	e8 f3 f9 ff ff       	call   80102040 <iput>
8010264d:	83 c4 10             	add    $0x10,%esp
80102650:	e9 16 ff ff ff       	jmp    8010256b <namex+0x4b>
80102655:	8d 76 00             	lea    0x0(%esi),%esi
80102658:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
8010265b:	8d 14 01             	lea    (%ecx,%eax,1),%edx
8010265e:	83 ec 04             	sub    $0x4,%esp
80102661:	89 55 e0             	mov    %edx,-0x20(%ebp)
80102664:	50                   	push   %eax
80102665:	53                   	push   %ebx
80102666:	89 fb                	mov    %edi,%ebx
80102668:	ff 75 e4             	push   -0x1c(%ebp)
8010266b:	e8 20 28 00 00       	call   80104e90 <memmove>
80102670:	8b 55 e0             	mov    -0x20(%ebp),%edx
80102673:	83 c4 10             	add    $0x10,%esp
80102676:	c6 02 00             	movb   $0x0,(%edx)
80102679:	e9 41 ff ff ff       	jmp    801025bf <namex+0x9f>
8010267e:	66 90                	xchg   %ax,%ax
80102680:	8b 45 dc             	mov    -0x24(%ebp),%eax
80102683:	85 c0                	test   %eax,%eax
80102685:	0f 85 be 00 00 00    	jne    80102749 <namex+0x229>
8010268b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010268e:	89 f0                	mov    %esi,%eax
80102690:	5b                   	pop    %ebx
80102691:	5e                   	pop    %esi
80102692:	5f                   	pop    %edi
80102693:	5d                   	pop    %ebp
80102694:	c3                   	ret    
80102695:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80102698:	89 df                	mov    %ebx,%edi
8010269a:	31 c0                	xor    %eax,%eax
8010269c:	eb c0                	jmp    8010265e <namex+0x13e>
8010269e:	ba 01 00 00 00       	mov    $0x1,%edx
801026a3:	b8 01 00 00 00       	mov    $0x1,%eax
801026a8:	e8 33 f4 ff ff       	call   80101ae0 <iget>
801026ad:	89 c6                	mov    %eax,%esi
801026af:	e9 b7 fe ff ff       	jmp    8010256b <namex+0x4b>
801026b4:	83 ec 0c             	sub    $0xc,%esp
801026b7:	8d 5e 0c             	lea    0xc(%esi),%ebx
801026ba:	53                   	push   %ebx
801026bb:	e8 50 24 00 00       	call   80104b10 <holdingsleep>
801026c0:	83 c4 10             	add    $0x10,%esp
801026c3:	85 c0                	test   %eax,%eax
801026c5:	0f 84 91 00 00 00    	je     8010275c <namex+0x23c>
801026cb:	8b 46 08             	mov    0x8(%esi),%eax
801026ce:	85 c0                	test   %eax,%eax
801026d0:	0f 8e 86 00 00 00    	jle    8010275c <namex+0x23c>
801026d6:	83 ec 0c             	sub    $0xc,%esp
801026d9:	53                   	push   %ebx
801026da:	e8 f1 23 00 00       	call   80104ad0 <releasesleep>
801026df:	89 34 24             	mov    %esi,(%esp)
801026e2:	31 f6                	xor    %esi,%esi
801026e4:	e8 57 f9 ff ff       	call   80102040 <iput>
801026e9:	83 c4 10             	add    $0x10,%esp
801026ec:	8d 65 f4             	lea    -0xc(%ebp),%esp
801026ef:	89 f0                	mov    %esi,%eax
801026f1:	5b                   	pop    %ebx
801026f2:	5e                   	pop    %esi
801026f3:	5f                   	pop    %edi
801026f4:	5d                   	pop    %ebp
801026f5:	c3                   	ret    
801026f6:	83 ec 0c             	sub    $0xc,%esp
801026f9:	89 55 e4             	mov    %edx,-0x1c(%ebp)
801026fc:	52                   	push   %edx
801026fd:	e8 0e 24 00 00       	call   80104b10 <holdingsleep>
80102702:	83 c4 10             	add    $0x10,%esp
80102705:	85 c0                	test   %eax,%eax
80102707:	74 53                	je     8010275c <namex+0x23c>
80102709:	8b 4e 08             	mov    0x8(%esi),%ecx
8010270c:	85 c9                	test   %ecx,%ecx
8010270e:	7e 4c                	jle    8010275c <namex+0x23c>
80102710:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80102713:	83 ec 0c             	sub    $0xc,%esp
80102716:	52                   	push   %edx
80102717:	eb c1                	jmp    801026da <namex+0x1ba>
80102719:	83 ec 0c             	sub    $0xc,%esp
8010271c:	8d 5e 0c             	lea    0xc(%esi),%ebx
8010271f:	53                   	push   %ebx
80102720:	e8 eb 23 00 00       	call   80104b10 <holdingsleep>
80102725:	83 c4 10             	add    $0x10,%esp
80102728:	85 c0                	test   %eax,%eax
8010272a:	74 30                	je     8010275c <namex+0x23c>
8010272c:	8b 7e 08             	mov    0x8(%esi),%edi
8010272f:	85 ff                	test   %edi,%edi
80102731:	7e 29                	jle    8010275c <namex+0x23c>
80102733:	83 ec 0c             	sub    $0xc,%esp
80102736:	53                   	push   %ebx
80102737:	e8 94 23 00 00       	call   80104ad0 <releasesleep>
8010273c:	83 c4 10             	add    $0x10,%esp
8010273f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102742:	89 f0                	mov    %esi,%eax
80102744:	5b                   	pop    %ebx
80102745:	5e                   	pop    %esi
80102746:	5f                   	pop    %edi
80102747:	5d                   	pop    %ebp
80102748:	c3                   	ret    
80102749:	83 ec 0c             	sub    $0xc,%esp
8010274c:	56                   	push   %esi
8010274d:	31 f6                	xor    %esi,%esi
8010274f:	e8 ec f8 ff ff       	call   80102040 <iput>
80102754:	83 c4 10             	add    $0x10,%esp
80102757:	e9 2f ff ff ff       	jmp    8010268b <namex+0x16b>
8010275c:	83 ec 0c             	sub    $0xc,%esp
8010275f:	68 b7 7a 10 80       	push   $0x80107ab7
80102764:	e8 37 dc ff ff       	call   801003a0 <panic>
80102769:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102770 <dirlink>:
80102770:	55                   	push   %ebp
80102771:	89 e5                	mov    %esp,%ebp
80102773:	57                   	push   %edi
80102774:	56                   	push   %esi
80102775:	53                   	push   %ebx
80102776:	83 ec 20             	sub    $0x20,%esp
80102779:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010277c:	6a 00                	push   $0x0
8010277e:	ff 75 0c             	push   0xc(%ebp)
80102781:	53                   	push   %ebx
80102782:	e8 e9 fc ff ff       	call   80102470 <dirlookup>
80102787:	83 c4 10             	add    $0x10,%esp
8010278a:	85 c0                	test   %eax,%eax
8010278c:	75 67                	jne    801027f5 <dirlink+0x85>
8010278e:	8b 7b 58             	mov    0x58(%ebx),%edi
80102791:	8d 75 d8             	lea    -0x28(%ebp),%esi
80102794:	85 ff                	test   %edi,%edi
80102796:	74 29                	je     801027c1 <dirlink+0x51>
80102798:	31 ff                	xor    %edi,%edi
8010279a:	8d 75 d8             	lea    -0x28(%ebp),%esi
8010279d:	eb 09                	jmp    801027a8 <dirlink+0x38>
8010279f:	90                   	nop
801027a0:	83 c7 10             	add    $0x10,%edi
801027a3:	3b 7b 58             	cmp    0x58(%ebx),%edi
801027a6:	73 19                	jae    801027c1 <dirlink+0x51>
801027a8:	6a 10                	push   $0x10
801027aa:	57                   	push   %edi
801027ab:	56                   	push   %esi
801027ac:	53                   	push   %ebx
801027ad:	e8 6e fa ff ff       	call   80102220 <readi>
801027b2:	83 c4 10             	add    $0x10,%esp
801027b5:	83 f8 10             	cmp    $0x10,%eax
801027b8:	75 4e                	jne    80102808 <dirlink+0x98>
801027ba:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
801027bf:	75 df                	jne    801027a0 <dirlink+0x30>
801027c1:	83 ec 04             	sub    $0x4,%esp
801027c4:	8d 45 da             	lea    -0x26(%ebp),%eax
801027c7:	6a 0e                	push   $0xe
801027c9:	ff 75 0c             	push   0xc(%ebp)
801027cc:	50                   	push   %eax
801027cd:	e8 7e 27 00 00       	call   80104f50 <strncpy>
801027d2:	6a 10                	push   $0x10
801027d4:	8b 45 10             	mov    0x10(%ebp),%eax
801027d7:	57                   	push   %edi
801027d8:	56                   	push   %esi
801027d9:	53                   	push   %ebx
801027da:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
801027de:	e8 3d fb ff ff       	call   80102320 <writei>
801027e3:	83 c4 20             	add    $0x20,%esp
801027e6:	83 f8 10             	cmp    $0x10,%eax
801027e9:	75 2a                	jne    80102815 <dirlink+0xa5>
801027eb:	31 c0                	xor    %eax,%eax
801027ed:	8d 65 f4             	lea    -0xc(%ebp),%esp
801027f0:	5b                   	pop    %ebx
801027f1:	5e                   	pop    %esi
801027f2:	5f                   	pop    %edi
801027f3:	5d                   	pop    %ebp
801027f4:	c3                   	ret    
801027f5:	83 ec 0c             	sub    $0xc,%esp
801027f8:	50                   	push   %eax
801027f9:	e8 42 f8 ff ff       	call   80102040 <iput>
801027fe:	83 c4 10             	add    $0x10,%esp
80102801:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102806:	eb e5                	jmp    801027ed <dirlink+0x7d>
80102808:	83 ec 0c             	sub    $0xc,%esp
8010280b:	68 e0 7a 10 80       	push   $0x80107ae0
80102810:	e8 8b db ff ff       	call   801003a0 <panic>
80102815:	83 ec 0c             	sub    $0xc,%esp
80102818:	68 be 80 10 80       	push   $0x801080be
8010281d:	e8 7e db ff ff       	call   801003a0 <panic>
80102822:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102829:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102830 <namei>:
80102830:	55                   	push   %ebp
80102831:	31 d2                	xor    %edx,%edx
80102833:	89 e5                	mov    %esp,%ebp
80102835:	83 ec 18             	sub    $0x18,%esp
80102838:	8b 45 08             	mov    0x8(%ebp),%eax
8010283b:	8d 4d ea             	lea    -0x16(%ebp),%ecx
8010283e:	e8 dd fc ff ff       	call   80102520 <namex>
80102843:	c9                   	leave  
80102844:	c3                   	ret    
80102845:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010284c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102850 <nameiparent>:
80102850:	55                   	push   %ebp
80102851:	ba 01 00 00 00       	mov    $0x1,%edx
80102856:	89 e5                	mov    %esp,%ebp
80102858:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010285b:	8b 45 08             	mov    0x8(%ebp),%eax
8010285e:	5d                   	pop    %ebp
8010285f:	e9 bc fc ff ff       	jmp    80102520 <namex>
80102864:	66 90                	xchg   %ax,%ax
80102866:	66 90                	xchg   %ax,%ax
80102868:	66 90                	xchg   %ax,%ax
8010286a:	66 90                	xchg   %ax,%ax
8010286c:	66 90                	xchg   %ax,%ax
8010286e:	66 90                	xchg   %ax,%ax

80102870 <idestart>:
80102870:	55                   	push   %ebp
80102871:	89 e5                	mov    %esp,%ebp
80102873:	57                   	push   %edi
80102874:	56                   	push   %esi
80102875:	53                   	push   %ebx
80102876:	83 ec 0c             	sub    $0xc,%esp
80102879:	85 c0                	test   %eax,%eax
8010287b:	0f 84 b4 00 00 00    	je     80102935 <idestart+0xc5>
80102881:	8b 70 08             	mov    0x8(%eax),%esi
80102884:	89 c3                	mov    %eax,%ebx
80102886:	81 fe e7 03 00 00    	cmp    $0x3e7,%esi
8010288c:	0f 87 96 00 00 00    	ja     80102928 <idestart+0xb8>
80102892:	b9 f7 01 00 00       	mov    $0x1f7,%ecx
80102897:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010289e:	66 90                	xchg   %ax,%ax
801028a0:	89 ca                	mov    %ecx,%edx
801028a2:	ec                   	in     (%dx),%al
801028a3:	83 e0 c0             	and    $0xffffffc0,%eax
801028a6:	3c 40                	cmp    $0x40,%al
801028a8:	75 f6                	jne    801028a0 <idestart+0x30>
801028aa:	31 ff                	xor    %edi,%edi
801028ac:	ba f6 03 00 00       	mov    $0x3f6,%edx
801028b1:	89 f8                	mov    %edi,%eax
801028b3:	ee                   	out    %al,(%dx)
801028b4:	b8 01 00 00 00       	mov    $0x1,%eax
801028b9:	ba f2 01 00 00       	mov    $0x1f2,%edx
801028be:	ee                   	out    %al,(%dx)
801028bf:	ba f3 01 00 00       	mov    $0x1f3,%edx
801028c4:	89 f0                	mov    %esi,%eax
801028c6:	ee                   	out    %al,(%dx)
801028c7:	89 f0                	mov    %esi,%eax
801028c9:	ba f4 01 00 00       	mov    $0x1f4,%edx
801028ce:	c1 f8 08             	sar    $0x8,%eax
801028d1:	ee                   	out    %al,(%dx)
801028d2:	ba f5 01 00 00       	mov    $0x1f5,%edx
801028d7:	89 f8                	mov    %edi,%eax
801028d9:	ee                   	out    %al,(%dx)
801028da:	0f b6 43 04          	movzbl 0x4(%ebx),%eax
801028de:	ba f6 01 00 00       	mov    $0x1f6,%edx
801028e3:	c1 e0 04             	shl    $0x4,%eax
801028e6:	83 e0 10             	and    $0x10,%eax
801028e9:	83 c8 e0             	or     $0xffffffe0,%eax
801028ec:	ee                   	out    %al,(%dx)
801028ed:	f6 03 04             	testb  $0x4,(%ebx)
801028f0:	75 16                	jne    80102908 <idestart+0x98>
801028f2:	b8 20 00 00 00       	mov    $0x20,%eax
801028f7:	89 ca                	mov    %ecx,%edx
801028f9:	ee                   	out    %al,(%dx)
801028fa:	8d 65 f4             	lea    -0xc(%ebp),%esp
801028fd:	5b                   	pop    %ebx
801028fe:	5e                   	pop    %esi
801028ff:	5f                   	pop    %edi
80102900:	5d                   	pop    %ebp
80102901:	c3                   	ret    
80102902:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102908:	b8 30 00 00 00       	mov    $0x30,%eax
8010290d:	89 ca                	mov    %ecx,%edx
8010290f:	ee                   	out    %al,(%dx)
80102910:	b9 80 00 00 00       	mov    $0x80,%ecx
80102915:	8d 73 5c             	lea    0x5c(%ebx),%esi
80102918:	ba f0 01 00 00       	mov    $0x1f0,%edx
8010291d:	fc                   	cld    
8010291e:	f3 6f                	rep outsl %ds:(%esi),(%dx)
80102920:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102923:	5b                   	pop    %ebx
80102924:	5e                   	pop    %esi
80102925:	5f                   	pop    %edi
80102926:	5d                   	pop    %ebp
80102927:	c3                   	ret    
80102928:	83 ec 0c             	sub    $0xc,%esp
8010292b:	68 4c 7b 10 80       	push   $0x80107b4c
80102930:	e8 6b da ff ff       	call   801003a0 <panic>
80102935:	83 ec 0c             	sub    $0xc,%esp
80102938:	68 43 7b 10 80       	push   $0x80107b43
8010293d:	e8 5e da ff ff       	call   801003a0 <panic>
80102942:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102949:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102950 <ideinit>:
80102950:	55                   	push   %ebp
80102951:	89 e5                	mov    %esp,%ebp
80102953:	83 ec 10             	sub    $0x10,%esp
80102956:	68 5e 7b 10 80       	push   $0x80107b5e
8010295b:	68 40 32 11 80       	push   $0x80113240
80102960:	e8 fb 21 00 00       	call   80104b60 <initlock>
80102965:	58                   	pop    %eax
80102966:	a1 c4 33 11 80       	mov    0x801133c4,%eax
8010296b:	5a                   	pop    %edx
8010296c:	83 e8 01             	sub    $0x1,%eax
8010296f:	50                   	push   %eax
80102970:	6a 0e                	push   $0xe
80102972:	e8 99 02 00 00       	call   80102c10 <ioapicenable>
80102977:	83 c4 10             	add    $0x10,%esp
8010297a:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010297f:	90                   	nop
80102980:	ec                   	in     (%dx),%al
80102981:	83 e0 c0             	and    $0xffffffc0,%eax
80102984:	3c 40                	cmp    $0x40,%al
80102986:	75 f8                	jne    80102980 <ideinit+0x30>
80102988:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
8010298d:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102992:	ee                   	out    %al,(%dx)
80102993:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
80102998:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010299d:	eb 06                	jmp    801029a5 <ideinit+0x55>
8010299f:	90                   	nop
801029a0:	83 e9 01             	sub    $0x1,%ecx
801029a3:	74 0f                	je     801029b4 <ideinit+0x64>
801029a5:	ec                   	in     (%dx),%al
801029a6:	84 c0                	test   %al,%al
801029a8:	74 f6                	je     801029a0 <ideinit+0x50>
801029aa:	c7 05 20 32 11 80 01 	movl   $0x1,0x80113220
801029b1:	00 00 00 
801029b4:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
801029b9:	ba f6 01 00 00       	mov    $0x1f6,%edx
801029be:	ee                   	out    %al,(%dx)
801029bf:	c9                   	leave  
801029c0:	c3                   	ret    
801029c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801029c8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801029cf:	90                   	nop

801029d0 <ideintr>:
801029d0:	55                   	push   %ebp
801029d1:	89 e5                	mov    %esp,%ebp
801029d3:	57                   	push   %edi
801029d4:	56                   	push   %esi
801029d5:	53                   	push   %ebx
801029d6:	83 ec 18             	sub    $0x18,%esp
801029d9:	68 40 32 11 80       	push   $0x80113240
801029de:	e8 4d 23 00 00       	call   80104d30 <acquire>
801029e3:	8b 1d 24 32 11 80    	mov    0x80113224,%ebx
801029e9:	83 c4 10             	add    $0x10,%esp
801029ec:	85 db                	test   %ebx,%ebx
801029ee:	74 63                	je     80102a53 <ideintr+0x83>
801029f0:	8b 43 58             	mov    0x58(%ebx),%eax
801029f3:	a3 24 32 11 80       	mov    %eax,0x80113224
801029f8:	8b 33                	mov    (%ebx),%esi
801029fa:	f7 c6 04 00 00 00    	test   $0x4,%esi
80102a00:	75 2f                	jne    80102a31 <ideintr+0x61>
80102a02:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102a07:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102a0e:	66 90                	xchg   %ax,%ax
80102a10:	ec                   	in     (%dx),%al
80102a11:	89 c1                	mov    %eax,%ecx
80102a13:	83 e1 c0             	and    $0xffffffc0,%ecx
80102a16:	80 f9 40             	cmp    $0x40,%cl
80102a19:	75 f5                	jne    80102a10 <ideintr+0x40>
80102a1b:	a8 21                	test   $0x21,%al
80102a1d:	75 12                	jne    80102a31 <ideintr+0x61>
80102a1f:	8d 7b 5c             	lea    0x5c(%ebx),%edi
80102a22:	b9 80 00 00 00       	mov    $0x80,%ecx
80102a27:	ba f0 01 00 00       	mov    $0x1f0,%edx
80102a2c:	fc                   	cld    
80102a2d:	f3 6d                	rep insl (%dx),%es:(%edi)
80102a2f:	8b 33                	mov    (%ebx),%esi
80102a31:	83 e6 fb             	and    $0xfffffffb,%esi
80102a34:	83 ec 0c             	sub    $0xc,%esp
80102a37:	83 ce 02             	or     $0x2,%esi
80102a3a:	89 33                	mov    %esi,(%ebx)
80102a3c:	53                   	push   %ebx
80102a3d:	e8 4e 1e 00 00       	call   80104890 <wakeup>
80102a42:	a1 24 32 11 80       	mov    0x80113224,%eax
80102a47:	83 c4 10             	add    $0x10,%esp
80102a4a:	85 c0                	test   %eax,%eax
80102a4c:	74 05                	je     80102a53 <ideintr+0x83>
80102a4e:	e8 1d fe ff ff       	call   80102870 <idestart>
80102a53:	83 ec 0c             	sub    $0xc,%esp
80102a56:	68 40 32 11 80       	push   $0x80113240
80102a5b:	e8 70 22 00 00       	call   80104cd0 <release>
80102a60:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102a63:	5b                   	pop    %ebx
80102a64:	5e                   	pop    %esi
80102a65:	5f                   	pop    %edi
80102a66:	5d                   	pop    %ebp
80102a67:	c3                   	ret    
80102a68:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102a6f:	90                   	nop

80102a70 <iderw>:
80102a70:	55                   	push   %ebp
80102a71:	89 e5                	mov    %esp,%ebp
80102a73:	53                   	push   %ebx
80102a74:	83 ec 10             	sub    $0x10,%esp
80102a77:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102a7a:	8d 43 0c             	lea    0xc(%ebx),%eax
80102a7d:	50                   	push   %eax
80102a7e:	e8 8d 20 00 00       	call   80104b10 <holdingsleep>
80102a83:	83 c4 10             	add    $0x10,%esp
80102a86:	85 c0                	test   %eax,%eax
80102a88:	0f 84 c3 00 00 00    	je     80102b51 <iderw+0xe1>
80102a8e:	8b 03                	mov    (%ebx),%eax
80102a90:	83 e0 06             	and    $0x6,%eax
80102a93:	83 f8 02             	cmp    $0x2,%eax
80102a96:	0f 84 a8 00 00 00    	je     80102b44 <iderw+0xd4>
80102a9c:	8b 53 04             	mov    0x4(%ebx),%edx
80102a9f:	85 d2                	test   %edx,%edx
80102aa1:	74 0d                	je     80102ab0 <iderw+0x40>
80102aa3:	a1 20 32 11 80       	mov    0x80113220,%eax
80102aa8:	85 c0                	test   %eax,%eax
80102aaa:	0f 84 87 00 00 00    	je     80102b37 <iderw+0xc7>
80102ab0:	83 ec 0c             	sub    $0xc,%esp
80102ab3:	68 40 32 11 80       	push   $0x80113240
80102ab8:	e8 73 22 00 00       	call   80104d30 <acquire>
80102abd:	a1 24 32 11 80       	mov    0x80113224,%eax
80102ac2:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
80102ac9:	83 c4 10             	add    $0x10,%esp
80102acc:	85 c0                	test   %eax,%eax
80102ace:	74 60                	je     80102b30 <iderw+0xc0>
80102ad0:	89 c2                	mov    %eax,%edx
80102ad2:	8b 40 58             	mov    0x58(%eax),%eax
80102ad5:	85 c0                	test   %eax,%eax
80102ad7:	75 f7                	jne    80102ad0 <iderw+0x60>
80102ad9:	83 c2 58             	add    $0x58,%edx
80102adc:	89 1a                	mov    %ebx,(%edx)
80102ade:	39 1d 24 32 11 80    	cmp    %ebx,0x80113224
80102ae4:	74 3a                	je     80102b20 <iderw+0xb0>
80102ae6:	8b 03                	mov    (%ebx),%eax
80102ae8:	83 e0 06             	and    $0x6,%eax
80102aeb:	83 f8 02             	cmp    $0x2,%eax
80102aee:	74 1b                	je     80102b0b <iderw+0x9b>
80102af0:	83 ec 08             	sub    $0x8,%esp
80102af3:	68 40 32 11 80       	push   $0x80113240
80102af8:	53                   	push   %ebx
80102af9:	e8 d2 1c 00 00       	call   801047d0 <sleep>
80102afe:	8b 03                	mov    (%ebx),%eax
80102b00:	83 c4 10             	add    $0x10,%esp
80102b03:	83 e0 06             	and    $0x6,%eax
80102b06:	83 f8 02             	cmp    $0x2,%eax
80102b09:	75 e5                	jne    80102af0 <iderw+0x80>
80102b0b:	c7 45 08 40 32 11 80 	movl   $0x80113240,0x8(%ebp)
80102b12:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102b15:	c9                   	leave  
80102b16:	e9 b5 21 00 00       	jmp    80104cd0 <release>
80102b1b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102b1f:	90                   	nop
80102b20:	89 d8                	mov    %ebx,%eax
80102b22:	e8 49 fd ff ff       	call   80102870 <idestart>
80102b27:	eb bd                	jmp    80102ae6 <iderw+0x76>
80102b29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102b30:	ba 24 32 11 80       	mov    $0x80113224,%edx
80102b35:	eb a5                	jmp    80102adc <iderw+0x6c>
80102b37:	83 ec 0c             	sub    $0xc,%esp
80102b3a:	68 8d 7b 10 80       	push   $0x80107b8d
80102b3f:	e8 5c d8 ff ff       	call   801003a0 <panic>
80102b44:	83 ec 0c             	sub    $0xc,%esp
80102b47:	68 78 7b 10 80       	push   $0x80107b78
80102b4c:	e8 4f d8 ff ff       	call   801003a0 <panic>
80102b51:	83 ec 0c             	sub    $0xc,%esp
80102b54:	68 62 7b 10 80       	push   $0x80107b62
80102b59:	e8 42 d8 ff ff       	call   801003a0 <panic>
80102b5e:	66 90                	xchg   %ax,%ax

80102b60 <ioapicinit>:
80102b60:	55                   	push   %ebp
80102b61:	c7 05 74 32 11 80 00 	movl   $0xfec00000,0x80113274
80102b68:	00 c0 fe 
80102b6b:	89 e5                	mov    %esp,%ebp
80102b6d:	56                   	push   %esi
80102b6e:	53                   	push   %ebx
80102b6f:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
80102b76:	00 00 00 
80102b79:	8b 15 74 32 11 80    	mov    0x80113274,%edx
80102b7f:	8b 72 10             	mov    0x10(%edx),%esi
80102b82:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
80102b88:	8b 0d 74 32 11 80    	mov    0x80113274,%ecx
80102b8e:	0f b6 15 c0 33 11 80 	movzbl 0x801133c0,%edx
80102b95:	c1 ee 10             	shr    $0x10,%esi
80102b98:	89 f0                	mov    %esi,%eax
80102b9a:	0f b6 f0             	movzbl %al,%esi
80102b9d:	8b 41 10             	mov    0x10(%ecx),%eax
80102ba0:	c1 e8 18             	shr    $0x18,%eax
80102ba3:	39 c2                	cmp    %eax,%edx
80102ba5:	74 16                	je     80102bbd <ioapicinit+0x5d>
80102ba7:	83 ec 0c             	sub    $0xc,%esp
80102baa:	68 ac 7b 10 80       	push   $0x80107bac
80102baf:	e8 9c db ff ff       	call   80100750 <cprintf>
80102bb4:	8b 0d 74 32 11 80    	mov    0x80113274,%ecx
80102bba:	83 c4 10             	add    $0x10,%esp
80102bbd:	83 c6 21             	add    $0x21,%esi
80102bc0:	ba 10 00 00 00       	mov    $0x10,%edx
80102bc5:	b8 20 00 00 00       	mov    $0x20,%eax
80102bca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102bd0:	89 11                	mov    %edx,(%ecx)
80102bd2:	89 c3                	mov    %eax,%ebx
80102bd4:	8b 0d 74 32 11 80    	mov    0x80113274,%ecx
80102bda:	83 c0 01             	add    $0x1,%eax
80102bdd:	81 cb 00 00 01 00    	or     $0x10000,%ebx
80102be3:	89 59 10             	mov    %ebx,0x10(%ecx)
80102be6:	8d 5a 01             	lea    0x1(%edx),%ebx
80102be9:	83 c2 02             	add    $0x2,%edx
80102bec:	89 19                	mov    %ebx,(%ecx)
80102bee:	8b 0d 74 32 11 80    	mov    0x80113274,%ecx
80102bf4:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
80102bfb:	39 f0                	cmp    %esi,%eax
80102bfd:	75 d1                	jne    80102bd0 <ioapicinit+0x70>
80102bff:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102c02:	5b                   	pop    %ebx
80102c03:	5e                   	pop    %esi
80102c04:	5d                   	pop    %ebp
80102c05:	c3                   	ret    
80102c06:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102c0d:	8d 76 00             	lea    0x0(%esi),%esi

80102c10 <ioapicenable>:
80102c10:	55                   	push   %ebp
80102c11:	8b 0d 74 32 11 80    	mov    0x80113274,%ecx
80102c17:	89 e5                	mov    %esp,%ebp
80102c19:	8b 45 08             	mov    0x8(%ebp),%eax
80102c1c:	8d 50 20             	lea    0x20(%eax),%edx
80102c1f:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
80102c23:	89 01                	mov    %eax,(%ecx)
80102c25:	8b 0d 74 32 11 80    	mov    0x80113274,%ecx
80102c2b:	83 c0 01             	add    $0x1,%eax
80102c2e:	89 51 10             	mov    %edx,0x10(%ecx)
80102c31:	8b 55 0c             	mov    0xc(%ebp),%edx
80102c34:	89 01                	mov    %eax,(%ecx)
80102c36:	a1 74 32 11 80       	mov    0x80113274,%eax
80102c3b:	c1 e2 18             	shl    $0x18,%edx
80102c3e:	89 50 10             	mov    %edx,0x10(%eax)
80102c41:	5d                   	pop    %ebp
80102c42:	c3                   	ret    
80102c43:	66 90                	xchg   %ax,%ax
80102c45:	66 90                	xchg   %ax,%ax
80102c47:	66 90                	xchg   %ax,%ax
80102c49:	66 90                	xchg   %ax,%ax
80102c4b:	66 90                	xchg   %ax,%ax
80102c4d:	66 90                	xchg   %ax,%ax
80102c4f:	90                   	nop

80102c50 <kfree>:
80102c50:	55                   	push   %ebp
80102c51:	89 e5                	mov    %esp,%ebp
80102c53:	53                   	push   %ebx
80102c54:	83 ec 04             	sub    $0x4,%esp
80102c57:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102c5a:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
80102c60:	75 76                	jne    80102cd8 <kfree+0x88>
80102c62:	81 fb 10 71 11 80    	cmp    $0x80117110,%ebx
80102c68:	72 6e                	jb     80102cd8 <kfree+0x88>
80102c6a:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80102c70:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80102c75:	77 61                	ja     80102cd8 <kfree+0x88>
80102c77:	83 ec 04             	sub    $0x4,%esp
80102c7a:	68 00 10 00 00       	push   $0x1000
80102c7f:	6a 01                	push   $0x1
80102c81:	53                   	push   %ebx
80102c82:	e8 69 21 00 00       	call   80104df0 <memset>
80102c87:	8b 15 b4 32 11 80    	mov    0x801132b4,%edx
80102c8d:	83 c4 10             	add    $0x10,%esp
80102c90:	85 d2                	test   %edx,%edx
80102c92:	75 1c                	jne    80102cb0 <kfree+0x60>
80102c94:	a1 b8 32 11 80       	mov    0x801132b8,%eax
80102c99:	89 03                	mov    %eax,(%ebx)
80102c9b:	a1 b4 32 11 80       	mov    0x801132b4,%eax
80102ca0:	89 1d b8 32 11 80    	mov    %ebx,0x801132b8
80102ca6:	85 c0                	test   %eax,%eax
80102ca8:	75 1e                	jne    80102cc8 <kfree+0x78>
80102caa:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102cad:	c9                   	leave  
80102cae:	c3                   	ret    
80102caf:	90                   	nop
80102cb0:	83 ec 0c             	sub    $0xc,%esp
80102cb3:	68 80 32 11 80       	push   $0x80113280
80102cb8:	e8 73 20 00 00       	call   80104d30 <acquire>
80102cbd:	83 c4 10             	add    $0x10,%esp
80102cc0:	eb d2                	jmp    80102c94 <kfree+0x44>
80102cc2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102cc8:	c7 45 08 80 32 11 80 	movl   $0x80113280,0x8(%ebp)
80102ccf:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102cd2:	c9                   	leave  
80102cd3:	e9 f8 1f 00 00       	jmp    80104cd0 <release>
80102cd8:	83 ec 0c             	sub    $0xc,%esp
80102cdb:	68 de 7b 10 80       	push   $0x80107bde
80102ce0:	e8 bb d6 ff ff       	call   801003a0 <panic>
80102ce5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102cec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102cf0 <freerange>:
80102cf0:	55                   	push   %ebp
80102cf1:	89 e5                	mov    %esp,%ebp
80102cf3:	56                   	push   %esi
80102cf4:	8b 45 08             	mov    0x8(%ebp),%eax
80102cf7:	8b 75 0c             	mov    0xc(%ebp),%esi
80102cfa:	53                   	push   %ebx
80102cfb:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102d01:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
80102d07:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80102d0d:	39 de                	cmp    %ebx,%esi
80102d0f:	72 23                	jb     80102d34 <freerange+0x44>
80102d11:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102d18:	83 ec 0c             	sub    $0xc,%esp
80102d1b:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
80102d21:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80102d27:	50                   	push   %eax
80102d28:	e8 23 ff ff ff       	call   80102c50 <kfree>
80102d2d:	83 c4 10             	add    $0x10,%esp
80102d30:	39 f3                	cmp    %esi,%ebx
80102d32:	76 e4                	jbe    80102d18 <freerange+0x28>
80102d34:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102d37:	5b                   	pop    %ebx
80102d38:	5e                   	pop    %esi
80102d39:	5d                   	pop    %ebp
80102d3a:	c3                   	ret    
80102d3b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102d3f:	90                   	nop

80102d40 <kinit2>:
80102d40:	55                   	push   %ebp
80102d41:	89 e5                	mov    %esp,%ebp
80102d43:	56                   	push   %esi
80102d44:	8b 45 08             	mov    0x8(%ebp),%eax
80102d47:	8b 75 0c             	mov    0xc(%ebp),%esi
80102d4a:	53                   	push   %ebx
80102d4b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102d51:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
80102d57:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80102d5d:	39 de                	cmp    %ebx,%esi
80102d5f:	72 23                	jb     80102d84 <kinit2+0x44>
80102d61:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102d68:	83 ec 0c             	sub    $0xc,%esp
80102d6b:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
80102d71:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80102d77:	50                   	push   %eax
80102d78:	e8 d3 fe ff ff       	call   80102c50 <kfree>
80102d7d:	83 c4 10             	add    $0x10,%esp
80102d80:	39 de                	cmp    %ebx,%esi
80102d82:	73 e4                	jae    80102d68 <kinit2+0x28>
80102d84:	c7 05 b4 32 11 80 01 	movl   $0x1,0x801132b4
80102d8b:	00 00 00 
80102d8e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102d91:	5b                   	pop    %ebx
80102d92:	5e                   	pop    %esi
80102d93:	5d                   	pop    %ebp
80102d94:	c3                   	ret    
80102d95:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102d9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102da0 <kinit1>:
80102da0:	55                   	push   %ebp
80102da1:	89 e5                	mov    %esp,%ebp
80102da3:	56                   	push   %esi
80102da4:	53                   	push   %ebx
80102da5:	8b 75 0c             	mov    0xc(%ebp),%esi
80102da8:	83 ec 08             	sub    $0x8,%esp
80102dab:	68 e4 7b 10 80       	push   $0x80107be4
80102db0:	68 80 32 11 80       	push   $0x80113280
80102db5:	e8 a6 1d 00 00       	call   80104b60 <initlock>
80102dba:	8b 45 08             	mov    0x8(%ebp),%eax
80102dbd:	83 c4 10             	add    $0x10,%esp
80102dc0:	c7 05 b4 32 11 80 00 	movl   $0x0,0x801132b4
80102dc7:	00 00 00 
80102dca:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102dd0:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
80102dd6:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80102ddc:	39 de                	cmp    %ebx,%esi
80102dde:	72 1c                	jb     80102dfc <kinit1+0x5c>
80102de0:	83 ec 0c             	sub    $0xc,%esp
80102de3:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
80102de9:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80102def:	50                   	push   %eax
80102df0:	e8 5b fe ff ff       	call   80102c50 <kfree>
80102df5:	83 c4 10             	add    $0x10,%esp
80102df8:	39 de                	cmp    %ebx,%esi
80102dfa:	73 e4                	jae    80102de0 <kinit1+0x40>
80102dfc:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102dff:	5b                   	pop    %ebx
80102e00:	5e                   	pop    %esi
80102e01:	5d                   	pop    %ebp
80102e02:	c3                   	ret    
80102e03:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102e0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102e10 <kalloc>:
80102e10:	a1 b4 32 11 80       	mov    0x801132b4,%eax
80102e15:	85 c0                	test   %eax,%eax
80102e17:	75 1f                	jne    80102e38 <kalloc+0x28>
80102e19:	a1 b8 32 11 80       	mov    0x801132b8,%eax
80102e1e:	85 c0                	test   %eax,%eax
80102e20:	74 0e                	je     80102e30 <kalloc+0x20>
80102e22:	8b 10                	mov    (%eax),%edx
80102e24:	89 15 b8 32 11 80    	mov    %edx,0x801132b8
80102e2a:	c3                   	ret    
80102e2b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102e2f:	90                   	nop
80102e30:	c3                   	ret    
80102e31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102e38:	55                   	push   %ebp
80102e39:	89 e5                	mov    %esp,%ebp
80102e3b:	83 ec 24             	sub    $0x24,%esp
80102e3e:	68 80 32 11 80       	push   $0x80113280
80102e43:	e8 e8 1e 00 00       	call   80104d30 <acquire>
80102e48:	a1 b8 32 11 80       	mov    0x801132b8,%eax
80102e4d:	8b 15 b4 32 11 80    	mov    0x801132b4,%edx
80102e53:	83 c4 10             	add    $0x10,%esp
80102e56:	85 c0                	test   %eax,%eax
80102e58:	74 08                	je     80102e62 <kalloc+0x52>
80102e5a:	8b 08                	mov    (%eax),%ecx
80102e5c:	89 0d b8 32 11 80    	mov    %ecx,0x801132b8
80102e62:	85 d2                	test   %edx,%edx
80102e64:	74 16                	je     80102e7c <kalloc+0x6c>
80102e66:	83 ec 0c             	sub    $0xc,%esp
80102e69:	89 45 f4             	mov    %eax,-0xc(%ebp)
80102e6c:	68 80 32 11 80       	push   $0x80113280
80102e71:	e8 5a 1e 00 00       	call   80104cd0 <release>
80102e76:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102e79:	83 c4 10             	add    $0x10,%esp
80102e7c:	c9                   	leave  
80102e7d:	c3                   	ret    
80102e7e:	66 90                	xchg   %ax,%ax

80102e80 <kbdgetc>:
80102e80:	ba 64 00 00 00       	mov    $0x64,%edx
80102e85:	ec                   	in     (%dx),%al
80102e86:	a8 01                	test   $0x1,%al
80102e88:	0f 84 c2 00 00 00    	je     80102f50 <kbdgetc+0xd0>
80102e8e:	55                   	push   %ebp
80102e8f:	ba 60 00 00 00       	mov    $0x60,%edx
80102e94:	89 e5                	mov    %esp,%ebp
80102e96:	53                   	push   %ebx
80102e97:	ec                   	in     (%dx),%al
80102e98:	8b 1d bc 32 11 80    	mov    0x801132bc,%ebx
80102e9e:	0f b6 c8             	movzbl %al,%ecx
80102ea1:	3c e0                	cmp    $0xe0,%al
80102ea3:	74 5b                	je     80102f00 <kbdgetc+0x80>
80102ea5:	89 da                	mov    %ebx,%edx
80102ea7:	83 e2 40             	and    $0x40,%edx
80102eaa:	84 c0                	test   %al,%al
80102eac:	78 62                	js     80102f10 <kbdgetc+0x90>
80102eae:	85 d2                	test   %edx,%edx
80102eb0:	74 09                	je     80102ebb <kbdgetc+0x3b>
80102eb2:	83 c8 80             	or     $0xffffff80,%eax
80102eb5:	83 e3 bf             	and    $0xffffffbf,%ebx
80102eb8:	0f b6 c8             	movzbl %al,%ecx
80102ebb:	0f b6 91 20 7d 10 80 	movzbl -0x7fef82e0(%ecx),%edx
80102ec2:	0f b6 81 20 7c 10 80 	movzbl -0x7fef83e0(%ecx),%eax
80102ec9:	09 da                	or     %ebx,%edx
80102ecb:	31 c2                	xor    %eax,%edx
80102ecd:	89 d0                	mov    %edx,%eax
80102ecf:	89 15 bc 32 11 80    	mov    %edx,0x801132bc
80102ed5:	83 e0 03             	and    $0x3,%eax
80102ed8:	83 e2 08             	and    $0x8,%edx
80102edb:	8b 04 85 00 7c 10 80 	mov    -0x7fef8400(,%eax,4),%eax
80102ee2:	0f b6 04 08          	movzbl (%eax,%ecx,1),%eax
80102ee6:	74 0b                	je     80102ef3 <kbdgetc+0x73>
80102ee8:	8d 50 9f             	lea    -0x61(%eax),%edx
80102eeb:	83 fa 19             	cmp    $0x19,%edx
80102eee:	77 48                	ja     80102f38 <kbdgetc+0xb8>
80102ef0:	83 e8 20             	sub    $0x20,%eax
80102ef3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102ef6:	c9                   	leave  
80102ef7:	c3                   	ret    
80102ef8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102eff:	90                   	nop
80102f00:	83 cb 40             	or     $0x40,%ebx
80102f03:	31 c0                	xor    %eax,%eax
80102f05:	89 1d bc 32 11 80    	mov    %ebx,0x801132bc
80102f0b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102f0e:	c9                   	leave  
80102f0f:	c3                   	ret    
80102f10:	83 e0 7f             	and    $0x7f,%eax
80102f13:	85 d2                	test   %edx,%edx
80102f15:	0f 44 c8             	cmove  %eax,%ecx
80102f18:	0f b6 81 20 7d 10 80 	movzbl -0x7fef82e0(%ecx),%eax
80102f1f:	83 c8 40             	or     $0x40,%eax
80102f22:	0f b6 c0             	movzbl %al,%eax
80102f25:	f7 d0                	not    %eax
80102f27:	21 d8                	and    %ebx,%eax
80102f29:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102f2c:	a3 bc 32 11 80       	mov    %eax,0x801132bc
80102f31:	31 c0                	xor    %eax,%eax
80102f33:	c9                   	leave  
80102f34:	c3                   	ret    
80102f35:	8d 76 00             	lea    0x0(%esi),%esi
80102f38:	8d 48 bf             	lea    -0x41(%eax),%ecx
80102f3b:	8d 50 20             	lea    0x20(%eax),%edx
80102f3e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102f41:	c9                   	leave  
80102f42:	83 f9 1a             	cmp    $0x1a,%ecx
80102f45:	0f 42 c2             	cmovb  %edx,%eax
80102f48:	c3                   	ret    
80102f49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102f50:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102f55:	c3                   	ret    
80102f56:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102f5d:	8d 76 00             	lea    0x0(%esi),%esi

80102f60 <kbdintr>:
80102f60:	55                   	push   %ebp
80102f61:	89 e5                	mov    %esp,%ebp
80102f63:	83 ec 14             	sub    $0x14,%esp
80102f66:	68 80 2e 10 80       	push   $0x80102e80
80102f6b:	e8 a0 de ff ff       	call   80100e10 <consoleintr>
80102f70:	83 c4 10             	add    $0x10,%esp
80102f73:	c9                   	leave  
80102f74:	c3                   	ret    
80102f75:	66 90                	xchg   %ax,%ax
80102f77:	66 90                	xchg   %ax,%ax
80102f79:	66 90                	xchg   %ax,%ax
80102f7b:	66 90                	xchg   %ax,%ax
80102f7d:	66 90                	xchg   %ax,%ax
80102f7f:	90                   	nop

80102f80 <lapicinit>:
80102f80:	a1 c0 32 11 80       	mov    0x801132c0,%eax
80102f85:	85 c0                	test   %eax,%eax
80102f87:	0f 84 cb 00 00 00    	je     80103058 <lapicinit+0xd8>
80102f8d:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
80102f94:	01 00 00 
80102f97:	8b 50 20             	mov    0x20(%eax),%edx
80102f9a:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
80102fa1:	00 00 00 
80102fa4:	8b 50 20             	mov    0x20(%eax),%edx
80102fa7:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
80102fae:	00 02 00 
80102fb1:	8b 50 20             	mov    0x20(%eax),%edx
80102fb4:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
80102fbb:	96 98 00 
80102fbe:	8b 50 20             	mov    0x20(%eax),%edx
80102fc1:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
80102fc8:	00 01 00 
80102fcb:	8b 50 20             	mov    0x20(%eax),%edx
80102fce:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
80102fd5:	00 01 00 
80102fd8:	8b 50 20             	mov    0x20(%eax),%edx
80102fdb:	8b 50 30             	mov    0x30(%eax),%edx
80102fde:	c1 ea 10             	shr    $0x10,%edx
80102fe1:	81 e2 fc 00 00 00    	and    $0xfc,%edx
80102fe7:	75 77                	jne    80103060 <lapicinit+0xe0>
80102fe9:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
80102ff0:	00 00 00 
80102ff3:	8b 50 20             	mov    0x20(%eax),%edx
80102ff6:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
80102ffd:	00 00 00 
80103000:	8b 50 20             	mov    0x20(%eax),%edx
80103003:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
8010300a:	00 00 00 
8010300d:	8b 50 20             	mov    0x20(%eax),%edx
80103010:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80103017:	00 00 00 
8010301a:	8b 50 20             	mov    0x20(%eax),%edx
8010301d:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
80103024:	00 00 00 
80103027:	8b 50 20             	mov    0x20(%eax),%edx
8010302a:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
80103031:	85 08 00 
80103034:	8b 50 20             	mov    0x20(%eax),%edx
80103037:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010303e:	66 90                	xchg   %ax,%ax
80103040:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
80103046:	80 e6 10             	and    $0x10,%dh
80103049:	75 f5                	jne    80103040 <lapicinit+0xc0>
8010304b:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
80103052:	00 00 00 
80103055:	8b 40 20             	mov    0x20(%eax),%eax
80103058:	c3                   	ret    
80103059:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103060:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
80103067:	00 01 00 
8010306a:	8b 50 20             	mov    0x20(%eax),%edx
8010306d:	e9 77 ff ff ff       	jmp    80102fe9 <lapicinit+0x69>
80103072:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103079:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103080 <lapicid>:
80103080:	a1 c0 32 11 80       	mov    0x801132c0,%eax
80103085:	85 c0                	test   %eax,%eax
80103087:	74 07                	je     80103090 <lapicid+0x10>
80103089:	8b 40 20             	mov    0x20(%eax),%eax
8010308c:	c1 e8 18             	shr    $0x18,%eax
8010308f:	c3                   	ret    
80103090:	31 c0                	xor    %eax,%eax
80103092:	c3                   	ret    
80103093:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010309a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801030a0 <lapiceoi>:
801030a0:	a1 c0 32 11 80       	mov    0x801132c0,%eax
801030a5:	85 c0                	test   %eax,%eax
801030a7:	74 0d                	je     801030b6 <lapiceoi+0x16>
801030a9:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
801030b0:	00 00 00 
801030b3:	8b 40 20             	mov    0x20(%eax),%eax
801030b6:	c3                   	ret    
801030b7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801030be:	66 90                	xchg   %ax,%ax

801030c0 <microdelay>:
801030c0:	c3                   	ret    
801030c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801030c8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801030cf:	90                   	nop

801030d0 <lapicstartap>:
801030d0:	55                   	push   %ebp
801030d1:	b8 0f 00 00 00       	mov    $0xf,%eax
801030d6:	ba 70 00 00 00       	mov    $0x70,%edx
801030db:	89 e5                	mov    %esp,%ebp
801030dd:	53                   	push   %ebx
801030de:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801030e1:	8b 5d 08             	mov    0x8(%ebp),%ebx
801030e4:	ee                   	out    %al,(%dx)
801030e5:	b8 0a 00 00 00       	mov    $0xa,%eax
801030ea:	ba 71 00 00 00       	mov    $0x71,%edx
801030ef:	ee                   	out    %al,(%dx)
801030f0:	31 c0                	xor    %eax,%eax
801030f2:	c1 e3 18             	shl    $0x18,%ebx
801030f5:	66 a3 67 04 00 80    	mov    %ax,0x80000467
801030fb:	89 c8                	mov    %ecx,%eax
801030fd:	c1 e9 0c             	shr    $0xc,%ecx
80103100:	89 da                	mov    %ebx,%edx
80103102:	c1 e8 04             	shr    $0x4,%eax
80103105:	80 cd 06             	or     $0x6,%ch
80103108:	66 a3 69 04 00 80    	mov    %ax,0x80000469
8010310e:	a1 c0 32 11 80       	mov    0x801132c0,%eax
80103113:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
80103119:	8b 58 20             	mov    0x20(%eax),%ebx
8010311c:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
80103123:	c5 00 00 
80103126:	8b 58 20             	mov    0x20(%eax),%ebx
80103129:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
80103130:	85 00 00 
80103133:	8b 58 20             	mov    0x20(%eax),%ebx
80103136:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
8010313c:	8b 58 20             	mov    0x20(%eax),%ebx
8010313f:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
80103145:	8b 58 20             	mov    0x20(%eax),%ebx
80103148:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
8010314e:	8b 50 20             	mov    0x20(%eax),%edx
80103151:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
80103157:	8b 40 20             	mov    0x20(%eax),%eax
8010315a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010315d:	c9                   	leave  
8010315e:	c3                   	ret    
8010315f:	90                   	nop

80103160 <cmostime>:
80103160:	55                   	push   %ebp
80103161:	b8 0b 00 00 00       	mov    $0xb,%eax
80103166:	ba 70 00 00 00       	mov    $0x70,%edx
8010316b:	89 e5                	mov    %esp,%ebp
8010316d:	57                   	push   %edi
8010316e:	56                   	push   %esi
8010316f:	53                   	push   %ebx
80103170:	83 ec 4c             	sub    $0x4c,%esp
80103173:	ee                   	out    %al,(%dx)
80103174:	ba 71 00 00 00       	mov    $0x71,%edx
80103179:	ec                   	in     (%dx),%al
8010317a:	83 e0 04             	and    $0x4,%eax
8010317d:	bb 70 00 00 00       	mov    $0x70,%ebx
80103182:	88 45 b3             	mov    %al,-0x4d(%ebp)
80103185:	8d 76 00             	lea    0x0(%esi),%esi
80103188:	31 c0                	xor    %eax,%eax
8010318a:	89 da                	mov    %ebx,%edx
8010318c:	ee                   	out    %al,(%dx)
8010318d:	b9 71 00 00 00       	mov    $0x71,%ecx
80103192:	89 ca                	mov    %ecx,%edx
80103194:	ec                   	in     (%dx),%al
80103195:	88 45 b7             	mov    %al,-0x49(%ebp)
80103198:	89 da                	mov    %ebx,%edx
8010319a:	b8 02 00 00 00       	mov    $0x2,%eax
8010319f:	ee                   	out    %al,(%dx)
801031a0:	89 ca                	mov    %ecx,%edx
801031a2:	ec                   	in     (%dx),%al
801031a3:	88 45 b6             	mov    %al,-0x4a(%ebp)
801031a6:	89 da                	mov    %ebx,%edx
801031a8:	b8 04 00 00 00       	mov    $0x4,%eax
801031ad:	ee                   	out    %al,(%dx)
801031ae:	89 ca                	mov    %ecx,%edx
801031b0:	ec                   	in     (%dx),%al
801031b1:	88 45 b5             	mov    %al,-0x4b(%ebp)
801031b4:	89 da                	mov    %ebx,%edx
801031b6:	b8 07 00 00 00       	mov    $0x7,%eax
801031bb:	ee                   	out    %al,(%dx)
801031bc:	89 ca                	mov    %ecx,%edx
801031be:	ec                   	in     (%dx),%al
801031bf:	88 45 b4             	mov    %al,-0x4c(%ebp)
801031c2:	89 da                	mov    %ebx,%edx
801031c4:	b8 08 00 00 00       	mov    $0x8,%eax
801031c9:	ee                   	out    %al,(%dx)
801031ca:	89 ca                	mov    %ecx,%edx
801031cc:	ec                   	in     (%dx),%al
801031cd:	89 c7                	mov    %eax,%edi
801031cf:	89 da                	mov    %ebx,%edx
801031d1:	b8 09 00 00 00       	mov    $0x9,%eax
801031d6:	ee                   	out    %al,(%dx)
801031d7:	89 ca                	mov    %ecx,%edx
801031d9:	ec                   	in     (%dx),%al
801031da:	89 c6                	mov    %eax,%esi
801031dc:	89 da                	mov    %ebx,%edx
801031de:	b8 0a 00 00 00       	mov    $0xa,%eax
801031e3:	ee                   	out    %al,(%dx)
801031e4:	89 ca                	mov    %ecx,%edx
801031e6:	ec                   	in     (%dx),%al
801031e7:	84 c0                	test   %al,%al
801031e9:	78 9d                	js     80103188 <cmostime+0x28>
801031eb:	0f b6 45 b7          	movzbl -0x49(%ebp),%eax
801031ef:	89 fa                	mov    %edi,%edx
801031f1:	0f b6 fa             	movzbl %dl,%edi
801031f4:	89 f2                	mov    %esi,%edx
801031f6:	89 45 b8             	mov    %eax,-0x48(%ebp)
801031f9:	0f b6 45 b6          	movzbl -0x4a(%ebp),%eax
801031fd:	0f b6 f2             	movzbl %dl,%esi
80103200:	89 da                	mov    %ebx,%edx
80103202:	89 7d c8             	mov    %edi,-0x38(%ebp)
80103205:	89 45 bc             	mov    %eax,-0x44(%ebp)
80103208:	0f b6 45 b5          	movzbl -0x4b(%ebp),%eax
8010320c:	89 75 cc             	mov    %esi,-0x34(%ebp)
8010320f:	89 45 c0             	mov    %eax,-0x40(%ebp)
80103212:	0f b6 45 b4          	movzbl -0x4c(%ebp),%eax
80103216:	89 45 c4             	mov    %eax,-0x3c(%ebp)
80103219:	31 c0                	xor    %eax,%eax
8010321b:	ee                   	out    %al,(%dx)
8010321c:	89 ca                	mov    %ecx,%edx
8010321e:	ec                   	in     (%dx),%al
8010321f:	0f b6 c0             	movzbl %al,%eax
80103222:	89 da                	mov    %ebx,%edx
80103224:	89 45 d0             	mov    %eax,-0x30(%ebp)
80103227:	b8 02 00 00 00       	mov    $0x2,%eax
8010322c:	ee                   	out    %al,(%dx)
8010322d:	89 ca                	mov    %ecx,%edx
8010322f:	ec                   	in     (%dx),%al
80103230:	0f b6 c0             	movzbl %al,%eax
80103233:	89 da                	mov    %ebx,%edx
80103235:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80103238:	b8 04 00 00 00       	mov    $0x4,%eax
8010323d:	ee                   	out    %al,(%dx)
8010323e:	89 ca                	mov    %ecx,%edx
80103240:	ec                   	in     (%dx),%al
80103241:	0f b6 c0             	movzbl %al,%eax
80103244:	89 da                	mov    %ebx,%edx
80103246:	89 45 d8             	mov    %eax,-0x28(%ebp)
80103249:	b8 07 00 00 00       	mov    $0x7,%eax
8010324e:	ee                   	out    %al,(%dx)
8010324f:	89 ca                	mov    %ecx,%edx
80103251:	ec                   	in     (%dx),%al
80103252:	0f b6 c0             	movzbl %al,%eax
80103255:	89 da                	mov    %ebx,%edx
80103257:	89 45 dc             	mov    %eax,-0x24(%ebp)
8010325a:	b8 08 00 00 00       	mov    $0x8,%eax
8010325f:	ee                   	out    %al,(%dx)
80103260:	89 ca                	mov    %ecx,%edx
80103262:	ec                   	in     (%dx),%al
80103263:	0f b6 c0             	movzbl %al,%eax
80103266:	89 da                	mov    %ebx,%edx
80103268:	89 45 e0             	mov    %eax,-0x20(%ebp)
8010326b:	b8 09 00 00 00       	mov    $0x9,%eax
80103270:	ee                   	out    %al,(%dx)
80103271:	89 ca                	mov    %ecx,%edx
80103273:	ec                   	in     (%dx),%al
80103274:	0f b6 c0             	movzbl %al,%eax
80103277:	83 ec 04             	sub    $0x4,%esp
8010327a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010327d:	8d 45 d0             	lea    -0x30(%ebp),%eax
80103280:	6a 18                	push   $0x18
80103282:	50                   	push   %eax
80103283:	8d 45 b8             	lea    -0x48(%ebp),%eax
80103286:	50                   	push   %eax
80103287:	e8 b4 1b 00 00       	call   80104e40 <memcmp>
8010328c:	83 c4 10             	add    $0x10,%esp
8010328f:	85 c0                	test   %eax,%eax
80103291:	0f 85 f1 fe ff ff    	jne    80103188 <cmostime+0x28>
80103297:	80 7d b3 00          	cmpb   $0x0,-0x4d(%ebp)
8010329b:	75 78                	jne    80103315 <cmostime+0x1b5>
8010329d:	8b 45 b8             	mov    -0x48(%ebp),%eax
801032a0:	89 c2                	mov    %eax,%edx
801032a2:	83 e0 0f             	and    $0xf,%eax
801032a5:	c1 ea 04             	shr    $0x4,%edx
801032a8:	8d 14 92             	lea    (%edx,%edx,4),%edx
801032ab:	8d 04 50             	lea    (%eax,%edx,2),%eax
801032ae:	89 45 b8             	mov    %eax,-0x48(%ebp)
801032b1:	8b 45 bc             	mov    -0x44(%ebp),%eax
801032b4:	89 c2                	mov    %eax,%edx
801032b6:	83 e0 0f             	and    $0xf,%eax
801032b9:	c1 ea 04             	shr    $0x4,%edx
801032bc:	8d 14 92             	lea    (%edx,%edx,4),%edx
801032bf:	8d 04 50             	lea    (%eax,%edx,2),%eax
801032c2:	89 45 bc             	mov    %eax,-0x44(%ebp)
801032c5:	8b 45 c0             	mov    -0x40(%ebp),%eax
801032c8:	89 c2                	mov    %eax,%edx
801032ca:	83 e0 0f             	and    $0xf,%eax
801032cd:	c1 ea 04             	shr    $0x4,%edx
801032d0:	8d 14 92             	lea    (%edx,%edx,4),%edx
801032d3:	8d 04 50             	lea    (%eax,%edx,2),%eax
801032d6:	89 45 c0             	mov    %eax,-0x40(%ebp)
801032d9:	8b 45 c4             	mov    -0x3c(%ebp),%eax
801032dc:	89 c2                	mov    %eax,%edx
801032de:	83 e0 0f             	and    $0xf,%eax
801032e1:	c1 ea 04             	shr    $0x4,%edx
801032e4:	8d 14 92             	lea    (%edx,%edx,4),%edx
801032e7:	8d 04 50             	lea    (%eax,%edx,2),%eax
801032ea:	89 45 c4             	mov    %eax,-0x3c(%ebp)
801032ed:	8b 45 c8             	mov    -0x38(%ebp),%eax
801032f0:	89 c2                	mov    %eax,%edx
801032f2:	83 e0 0f             	and    $0xf,%eax
801032f5:	c1 ea 04             	shr    $0x4,%edx
801032f8:	8d 14 92             	lea    (%edx,%edx,4),%edx
801032fb:	8d 04 50             	lea    (%eax,%edx,2),%eax
801032fe:	89 45 c8             	mov    %eax,-0x38(%ebp)
80103301:	8b 45 cc             	mov    -0x34(%ebp),%eax
80103304:	89 c2                	mov    %eax,%edx
80103306:	83 e0 0f             	and    $0xf,%eax
80103309:	c1 ea 04             	shr    $0x4,%edx
8010330c:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010330f:	8d 04 50             	lea    (%eax,%edx,2),%eax
80103312:	89 45 cc             	mov    %eax,-0x34(%ebp)
80103315:	8b 75 08             	mov    0x8(%ebp),%esi
80103318:	8b 45 b8             	mov    -0x48(%ebp),%eax
8010331b:	89 06                	mov    %eax,(%esi)
8010331d:	8b 45 bc             	mov    -0x44(%ebp),%eax
80103320:	89 46 04             	mov    %eax,0x4(%esi)
80103323:	8b 45 c0             	mov    -0x40(%ebp),%eax
80103326:	89 46 08             	mov    %eax,0x8(%esi)
80103329:	8b 45 c4             	mov    -0x3c(%ebp),%eax
8010332c:	89 46 0c             	mov    %eax,0xc(%esi)
8010332f:	8b 45 c8             	mov    -0x38(%ebp),%eax
80103332:	89 46 10             	mov    %eax,0x10(%esi)
80103335:	8b 45 cc             	mov    -0x34(%ebp),%eax
80103338:	89 46 14             	mov    %eax,0x14(%esi)
8010333b:	81 46 14 d0 07 00 00 	addl   $0x7d0,0x14(%esi)
80103342:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103345:	5b                   	pop    %ebx
80103346:	5e                   	pop    %esi
80103347:	5f                   	pop    %edi
80103348:	5d                   	pop    %ebp
80103349:	c3                   	ret    
8010334a:	66 90                	xchg   %ax,%ax
8010334c:	66 90                	xchg   %ax,%ax
8010334e:	66 90                	xchg   %ax,%ax

80103350 <install_trans>:
80103350:	8b 0d 28 33 11 80    	mov    0x80113328,%ecx
80103356:	85 c9                	test   %ecx,%ecx
80103358:	0f 8e 8a 00 00 00    	jle    801033e8 <install_trans+0x98>
8010335e:	55                   	push   %ebp
8010335f:	89 e5                	mov    %esp,%ebp
80103361:	57                   	push   %edi
80103362:	31 ff                	xor    %edi,%edi
80103364:	56                   	push   %esi
80103365:	53                   	push   %ebx
80103366:	83 ec 0c             	sub    $0xc,%esp
80103369:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103370:	a1 14 33 11 80       	mov    0x80113314,%eax
80103375:	83 ec 08             	sub    $0x8,%esp
80103378:	01 f8                	add    %edi,%eax
8010337a:	83 c0 01             	add    $0x1,%eax
8010337d:	50                   	push   %eax
8010337e:	ff 35 24 33 11 80    	push   0x80113324
80103384:	e8 47 cd ff ff       	call   801000d0 <bread>
80103389:	89 c6                	mov    %eax,%esi
8010338b:	58                   	pop    %eax
8010338c:	5a                   	pop    %edx
8010338d:	ff 34 bd 2c 33 11 80 	push   -0x7feeccd4(,%edi,4)
80103394:	ff 35 24 33 11 80    	push   0x80113324
8010339a:	83 c7 01             	add    $0x1,%edi
8010339d:	e8 2e cd ff ff       	call   801000d0 <bread>
801033a2:	83 c4 0c             	add    $0xc,%esp
801033a5:	89 c3                	mov    %eax,%ebx
801033a7:	8d 46 5c             	lea    0x5c(%esi),%eax
801033aa:	68 00 02 00 00       	push   $0x200
801033af:	50                   	push   %eax
801033b0:	8d 43 5c             	lea    0x5c(%ebx),%eax
801033b3:	50                   	push   %eax
801033b4:	e8 d7 1a 00 00       	call   80104e90 <memmove>
801033b9:	89 1c 24             	mov    %ebx,(%esp)
801033bc:	e8 ef cd ff ff       	call   801001b0 <bwrite>
801033c1:	89 34 24             	mov    %esi,(%esp)
801033c4:	e8 27 ce ff ff       	call   801001f0 <brelse>
801033c9:	89 1c 24             	mov    %ebx,(%esp)
801033cc:	e8 1f ce ff ff       	call   801001f0 <brelse>
801033d1:	83 c4 10             	add    $0x10,%esp
801033d4:	39 3d 28 33 11 80    	cmp    %edi,0x80113328
801033da:	7f 94                	jg     80103370 <install_trans+0x20>
801033dc:	8d 65 f4             	lea    -0xc(%ebp),%esp
801033df:	5b                   	pop    %ebx
801033e0:	5e                   	pop    %esi
801033e1:	5f                   	pop    %edi
801033e2:	5d                   	pop    %ebp
801033e3:	c3                   	ret    
801033e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801033e8:	c3                   	ret    
801033e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801033f0 <write_head>:
801033f0:	55                   	push   %ebp
801033f1:	89 e5                	mov    %esp,%ebp
801033f3:	53                   	push   %ebx
801033f4:	83 ec 0c             	sub    $0xc,%esp
801033f7:	ff 35 14 33 11 80    	push   0x80113314
801033fd:	ff 35 24 33 11 80    	push   0x80113324
80103403:	e8 c8 cc ff ff       	call   801000d0 <bread>
80103408:	83 c4 10             	add    $0x10,%esp
8010340b:	89 c3                	mov    %eax,%ebx
8010340d:	a1 28 33 11 80       	mov    0x80113328,%eax
80103412:	89 43 5c             	mov    %eax,0x5c(%ebx)
80103415:	85 c0                	test   %eax,%eax
80103417:	7e 19                	jle    80103432 <write_head+0x42>
80103419:	31 d2                	xor    %edx,%edx
8010341b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010341f:	90                   	nop
80103420:	8b 0c 95 2c 33 11 80 	mov    -0x7feeccd4(,%edx,4),%ecx
80103427:	89 4c 93 60          	mov    %ecx,0x60(%ebx,%edx,4)
8010342b:	83 c2 01             	add    $0x1,%edx
8010342e:	39 d0                	cmp    %edx,%eax
80103430:	75 ee                	jne    80103420 <write_head+0x30>
80103432:	83 ec 0c             	sub    $0xc,%esp
80103435:	53                   	push   %ebx
80103436:	e8 75 cd ff ff       	call   801001b0 <bwrite>
8010343b:	89 1c 24             	mov    %ebx,(%esp)
8010343e:	e8 ad cd ff ff       	call   801001f0 <brelse>
80103443:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103446:	83 c4 10             	add    $0x10,%esp
80103449:	c9                   	leave  
8010344a:	c3                   	ret    
8010344b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010344f:	90                   	nop

80103450 <initlog>:
80103450:	55                   	push   %ebp
80103451:	89 e5                	mov    %esp,%ebp
80103453:	53                   	push   %ebx
80103454:	83 ec 2c             	sub    $0x2c,%esp
80103457:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010345a:	68 20 7e 10 80       	push   $0x80107e20
8010345f:	68 e0 32 11 80       	push   $0x801132e0
80103464:	e8 f7 16 00 00       	call   80104b60 <initlock>
80103469:	58                   	pop    %eax
8010346a:	8d 45 dc             	lea    -0x24(%ebp),%eax
8010346d:	5a                   	pop    %edx
8010346e:	50                   	push   %eax
8010346f:	53                   	push   %ebx
80103470:	e8 3b e8 ff ff       	call   80101cb0 <readsb>
80103475:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103478:	59                   	pop    %ecx
80103479:	89 1d 24 33 11 80    	mov    %ebx,0x80113324
8010347f:	8b 55 e8             	mov    -0x18(%ebp),%edx
80103482:	a3 14 33 11 80       	mov    %eax,0x80113314
80103487:	89 15 18 33 11 80    	mov    %edx,0x80113318
8010348d:	5a                   	pop    %edx
8010348e:	50                   	push   %eax
8010348f:	53                   	push   %ebx
80103490:	e8 3b cc ff ff       	call   801000d0 <bread>
80103495:	83 c4 10             	add    $0x10,%esp
80103498:	8b 58 5c             	mov    0x5c(%eax),%ebx
8010349b:	89 1d 28 33 11 80    	mov    %ebx,0x80113328
801034a1:	85 db                	test   %ebx,%ebx
801034a3:	7e 1d                	jle    801034c2 <initlog+0x72>
801034a5:	31 d2                	xor    %edx,%edx
801034a7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801034ae:	66 90                	xchg   %ax,%ax
801034b0:	8b 4c 90 60          	mov    0x60(%eax,%edx,4),%ecx
801034b4:	89 0c 95 2c 33 11 80 	mov    %ecx,-0x7feeccd4(,%edx,4)
801034bb:	83 c2 01             	add    $0x1,%edx
801034be:	39 d3                	cmp    %edx,%ebx
801034c0:	75 ee                	jne    801034b0 <initlog+0x60>
801034c2:	83 ec 0c             	sub    $0xc,%esp
801034c5:	50                   	push   %eax
801034c6:	e8 25 cd ff ff       	call   801001f0 <brelse>
801034cb:	e8 80 fe ff ff       	call   80103350 <install_trans>
801034d0:	c7 05 28 33 11 80 00 	movl   $0x0,0x80113328
801034d7:	00 00 00 
801034da:	e8 11 ff ff ff       	call   801033f0 <write_head>
801034df:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801034e2:	83 c4 10             	add    $0x10,%esp
801034e5:	c9                   	leave  
801034e6:	c3                   	ret    
801034e7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801034ee:	66 90                	xchg   %ax,%ax

801034f0 <begin_op>:
801034f0:	55                   	push   %ebp
801034f1:	89 e5                	mov    %esp,%ebp
801034f3:	83 ec 14             	sub    $0x14,%esp
801034f6:	68 e0 32 11 80       	push   $0x801132e0
801034fb:	e8 30 18 00 00       	call   80104d30 <acquire>
80103500:	83 c4 10             	add    $0x10,%esp
80103503:	eb 18                	jmp    8010351d <begin_op+0x2d>
80103505:	8d 76 00             	lea    0x0(%esi),%esi
80103508:	83 ec 08             	sub    $0x8,%esp
8010350b:	68 e0 32 11 80       	push   $0x801132e0
80103510:	68 e0 32 11 80       	push   $0x801132e0
80103515:	e8 b6 12 00 00       	call   801047d0 <sleep>
8010351a:	83 c4 10             	add    $0x10,%esp
8010351d:	a1 20 33 11 80       	mov    0x80113320,%eax
80103522:	85 c0                	test   %eax,%eax
80103524:	75 e2                	jne    80103508 <begin_op+0x18>
80103526:	a1 1c 33 11 80       	mov    0x8011331c,%eax
8010352b:	8b 15 28 33 11 80    	mov    0x80113328,%edx
80103531:	83 c0 01             	add    $0x1,%eax
80103534:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80103537:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
8010353a:	83 fa 1e             	cmp    $0x1e,%edx
8010353d:	7f c9                	jg     80103508 <begin_op+0x18>
8010353f:	83 ec 0c             	sub    $0xc,%esp
80103542:	a3 1c 33 11 80       	mov    %eax,0x8011331c
80103547:	68 e0 32 11 80       	push   $0x801132e0
8010354c:	e8 7f 17 00 00       	call   80104cd0 <release>
80103551:	83 c4 10             	add    $0x10,%esp
80103554:	c9                   	leave  
80103555:	c3                   	ret    
80103556:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010355d:	8d 76 00             	lea    0x0(%esi),%esi

80103560 <end_op>:
80103560:	55                   	push   %ebp
80103561:	89 e5                	mov    %esp,%ebp
80103563:	57                   	push   %edi
80103564:	56                   	push   %esi
80103565:	53                   	push   %ebx
80103566:	83 ec 18             	sub    $0x18,%esp
80103569:	68 e0 32 11 80       	push   $0x801132e0
8010356e:	e8 bd 17 00 00       	call   80104d30 <acquire>
80103573:	a1 1c 33 11 80       	mov    0x8011331c,%eax
80103578:	8b 35 20 33 11 80    	mov    0x80113320,%esi
8010357e:	83 c4 10             	add    $0x10,%esp
80103581:	8d 58 ff             	lea    -0x1(%eax),%ebx
80103584:	89 1d 1c 33 11 80    	mov    %ebx,0x8011331c
8010358a:	85 f6                	test   %esi,%esi
8010358c:	0f 85 22 01 00 00    	jne    801036b4 <end_op+0x154>
80103592:	85 db                	test   %ebx,%ebx
80103594:	0f 85 f6 00 00 00    	jne    80103690 <end_op+0x130>
8010359a:	c7 05 20 33 11 80 01 	movl   $0x1,0x80113320
801035a1:	00 00 00 
801035a4:	83 ec 0c             	sub    $0xc,%esp
801035a7:	68 e0 32 11 80       	push   $0x801132e0
801035ac:	e8 1f 17 00 00       	call   80104cd0 <release>
801035b1:	8b 0d 28 33 11 80    	mov    0x80113328,%ecx
801035b7:	83 c4 10             	add    $0x10,%esp
801035ba:	85 c9                	test   %ecx,%ecx
801035bc:	7f 42                	jg     80103600 <end_op+0xa0>
801035be:	83 ec 0c             	sub    $0xc,%esp
801035c1:	68 e0 32 11 80       	push   $0x801132e0
801035c6:	e8 65 17 00 00       	call   80104d30 <acquire>
801035cb:	c7 04 24 e0 32 11 80 	movl   $0x801132e0,(%esp)
801035d2:	c7 05 20 33 11 80 00 	movl   $0x0,0x80113320
801035d9:	00 00 00 
801035dc:	e8 af 12 00 00       	call   80104890 <wakeup>
801035e1:	c7 04 24 e0 32 11 80 	movl   $0x801132e0,(%esp)
801035e8:	e8 e3 16 00 00       	call   80104cd0 <release>
801035ed:	83 c4 10             	add    $0x10,%esp
801035f0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801035f3:	5b                   	pop    %ebx
801035f4:	5e                   	pop    %esi
801035f5:	5f                   	pop    %edi
801035f6:	5d                   	pop    %ebp
801035f7:	c3                   	ret    
801035f8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801035ff:	90                   	nop
80103600:	a1 14 33 11 80       	mov    0x80113314,%eax
80103605:	83 ec 08             	sub    $0x8,%esp
80103608:	01 d8                	add    %ebx,%eax
8010360a:	83 c0 01             	add    $0x1,%eax
8010360d:	50                   	push   %eax
8010360e:	ff 35 24 33 11 80    	push   0x80113324
80103614:	e8 b7 ca ff ff       	call   801000d0 <bread>
80103619:	89 c6                	mov    %eax,%esi
8010361b:	58                   	pop    %eax
8010361c:	5a                   	pop    %edx
8010361d:	ff 34 9d 2c 33 11 80 	push   -0x7feeccd4(,%ebx,4)
80103624:	ff 35 24 33 11 80    	push   0x80113324
8010362a:	83 c3 01             	add    $0x1,%ebx
8010362d:	e8 9e ca ff ff       	call   801000d0 <bread>
80103632:	83 c4 0c             	add    $0xc,%esp
80103635:	89 c7                	mov    %eax,%edi
80103637:	8d 40 5c             	lea    0x5c(%eax),%eax
8010363a:	68 00 02 00 00       	push   $0x200
8010363f:	50                   	push   %eax
80103640:	8d 46 5c             	lea    0x5c(%esi),%eax
80103643:	50                   	push   %eax
80103644:	e8 47 18 00 00       	call   80104e90 <memmove>
80103649:	89 34 24             	mov    %esi,(%esp)
8010364c:	e8 5f cb ff ff       	call   801001b0 <bwrite>
80103651:	89 3c 24             	mov    %edi,(%esp)
80103654:	e8 97 cb ff ff       	call   801001f0 <brelse>
80103659:	89 34 24             	mov    %esi,(%esp)
8010365c:	e8 8f cb ff ff       	call   801001f0 <brelse>
80103661:	83 c4 10             	add    $0x10,%esp
80103664:	3b 1d 28 33 11 80    	cmp    0x80113328,%ebx
8010366a:	7c 94                	jl     80103600 <end_op+0xa0>
8010366c:	e8 7f fd ff ff       	call   801033f0 <write_head>
80103671:	e8 da fc ff ff       	call   80103350 <install_trans>
80103676:	c7 05 28 33 11 80 00 	movl   $0x0,0x80113328
8010367d:	00 00 00 
80103680:	e8 6b fd ff ff       	call   801033f0 <write_head>
80103685:	e9 34 ff ff ff       	jmp    801035be <end_op+0x5e>
8010368a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103690:	83 ec 0c             	sub    $0xc,%esp
80103693:	68 e0 32 11 80       	push   $0x801132e0
80103698:	e8 f3 11 00 00       	call   80104890 <wakeup>
8010369d:	c7 04 24 e0 32 11 80 	movl   $0x801132e0,(%esp)
801036a4:	e8 27 16 00 00       	call   80104cd0 <release>
801036a9:	83 c4 10             	add    $0x10,%esp
801036ac:	8d 65 f4             	lea    -0xc(%ebp),%esp
801036af:	5b                   	pop    %ebx
801036b0:	5e                   	pop    %esi
801036b1:	5f                   	pop    %edi
801036b2:	5d                   	pop    %ebp
801036b3:	c3                   	ret    
801036b4:	83 ec 0c             	sub    $0xc,%esp
801036b7:	68 24 7e 10 80       	push   $0x80107e24
801036bc:	e8 df cc ff ff       	call   801003a0 <panic>
801036c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801036c8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801036cf:	90                   	nop

801036d0 <log_write>:
801036d0:	55                   	push   %ebp
801036d1:	89 e5                	mov    %esp,%ebp
801036d3:	53                   	push   %ebx
801036d4:	83 ec 04             	sub    $0x4,%esp
801036d7:	8b 15 28 33 11 80    	mov    0x80113328,%edx
801036dd:	8b 5d 08             	mov    0x8(%ebp),%ebx
801036e0:	83 fa 1d             	cmp    $0x1d,%edx
801036e3:	0f 8f 85 00 00 00    	jg     8010376e <log_write+0x9e>
801036e9:	a1 18 33 11 80       	mov    0x80113318,%eax
801036ee:	83 e8 01             	sub    $0x1,%eax
801036f1:	39 c2                	cmp    %eax,%edx
801036f3:	7d 79                	jge    8010376e <log_write+0x9e>
801036f5:	a1 1c 33 11 80       	mov    0x8011331c,%eax
801036fa:	85 c0                	test   %eax,%eax
801036fc:	7e 7d                	jle    8010377b <log_write+0xab>
801036fe:	83 ec 0c             	sub    $0xc,%esp
80103701:	68 e0 32 11 80       	push   $0x801132e0
80103706:	e8 25 16 00 00       	call   80104d30 <acquire>
8010370b:	8b 15 28 33 11 80    	mov    0x80113328,%edx
80103711:	83 c4 10             	add    $0x10,%esp
80103714:	85 d2                	test   %edx,%edx
80103716:	7e 4a                	jle    80103762 <log_write+0x92>
80103718:	8b 4b 08             	mov    0x8(%ebx),%ecx
8010371b:	31 c0                	xor    %eax,%eax
8010371d:	eb 08                	jmp    80103727 <log_write+0x57>
8010371f:	90                   	nop
80103720:	83 c0 01             	add    $0x1,%eax
80103723:	39 c2                	cmp    %eax,%edx
80103725:	74 29                	je     80103750 <log_write+0x80>
80103727:	39 0c 85 2c 33 11 80 	cmp    %ecx,-0x7feeccd4(,%eax,4)
8010372e:	75 f0                	jne    80103720 <log_write+0x50>
80103730:	89 0c 85 2c 33 11 80 	mov    %ecx,-0x7feeccd4(,%eax,4)
80103737:	83 0b 04             	orl    $0x4,(%ebx)
8010373a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010373d:	c7 45 08 e0 32 11 80 	movl   $0x801132e0,0x8(%ebp)
80103744:	c9                   	leave  
80103745:	e9 86 15 00 00       	jmp    80104cd0 <release>
8010374a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103750:	89 0c 95 2c 33 11 80 	mov    %ecx,-0x7feeccd4(,%edx,4)
80103757:	83 c2 01             	add    $0x1,%edx
8010375a:	89 15 28 33 11 80    	mov    %edx,0x80113328
80103760:	eb d5                	jmp    80103737 <log_write+0x67>
80103762:	8b 43 08             	mov    0x8(%ebx),%eax
80103765:	a3 2c 33 11 80       	mov    %eax,0x8011332c
8010376a:	75 cb                	jne    80103737 <log_write+0x67>
8010376c:	eb e9                	jmp    80103757 <log_write+0x87>
8010376e:	83 ec 0c             	sub    $0xc,%esp
80103771:	68 33 7e 10 80       	push   $0x80107e33
80103776:	e8 25 cc ff ff       	call   801003a0 <panic>
8010377b:	83 ec 0c             	sub    $0xc,%esp
8010377e:	68 49 7e 10 80       	push   $0x80107e49
80103783:	e8 18 cc ff ff       	call   801003a0 <panic>
80103788:	66 90                	xchg   %ax,%ax
8010378a:	66 90                	xchg   %ax,%ax
8010378c:	66 90                	xchg   %ax,%ax
8010378e:	66 90                	xchg   %ax,%ax

80103790 <mpmain>:
80103790:	55                   	push   %ebp
80103791:	89 e5                	mov    %esp,%ebp
80103793:	53                   	push   %ebx
80103794:	83 ec 04             	sub    $0x4,%esp
80103797:	e8 44 09 00 00       	call   801040e0 <cpuid>
8010379c:	89 c3                	mov    %eax,%ebx
8010379e:	e8 3d 09 00 00       	call   801040e0 <cpuid>
801037a3:	83 ec 04             	sub    $0x4,%esp
801037a6:	53                   	push   %ebx
801037a7:	50                   	push   %eax
801037a8:	68 64 7e 10 80       	push   $0x80107e64
801037ad:	e8 9e cf ff ff       	call   80100750 <cprintf>
801037b2:	e8 b9 28 00 00       	call   80106070 <idtinit>
801037b7:	e8 c4 08 00 00       	call   80104080 <mycpu>
801037bc:	89 c2                	mov    %eax,%edx
801037be:	b8 01 00 00 00       	mov    $0x1,%eax
801037c3:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
801037ca:	e8 f1 0b 00 00       	call   801043c0 <scheduler>
801037cf:	90                   	nop

801037d0 <mpenter>:
801037d0:	55                   	push   %ebp
801037d1:	89 e5                	mov    %esp,%ebp
801037d3:	83 ec 08             	sub    $0x8,%esp
801037d6:	e8 85 39 00 00       	call   80107160 <switchkvm>
801037db:	e8 f0 38 00 00       	call   801070d0 <seginit>
801037e0:	e8 9b f7 ff ff       	call   80102f80 <lapicinit>
801037e5:	e8 a6 ff ff ff       	call   80103790 <mpmain>
801037ea:	66 90                	xchg   %ax,%ax
801037ec:	66 90                	xchg   %ax,%ax
801037ee:	66 90                	xchg   %ax,%ax

801037f0 <main>:
801037f0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
801037f4:	83 e4 f0             	and    $0xfffffff0,%esp
801037f7:	ff 71 fc             	push   -0x4(%ecx)
801037fa:	55                   	push   %ebp
801037fb:	89 e5                	mov    %esp,%ebp
801037fd:	53                   	push   %ebx
801037fe:	51                   	push   %ecx
801037ff:	83 ec 08             	sub    $0x8,%esp
80103802:	68 00 00 40 80       	push   $0x80400000
80103807:	68 10 71 11 80       	push   $0x80117110
8010380c:	e8 8f f5 ff ff       	call   80102da0 <kinit1>
80103811:	e8 3a 3e 00 00       	call   80107650 <kvmalloc>
80103816:	e8 85 01 00 00       	call   801039a0 <mpinit>
8010381b:	e8 60 f7 ff ff       	call   80102f80 <lapicinit>
80103820:	e8 ab 38 00 00       	call   801070d0 <seginit>
80103825:	e8 76 03 00 00       	call   80103ba0 <picinit>
8010382a:	e8 31 f3 ff ff       	call   80102b60 <ioapicinit>
8010382f:	e8 bc d9 ff ff       	call   801011f0 <consoleinit>
80103834:	e8 27 2b 00 00       	call   80106360 <uartinit>
80103839:	e8 22 08 00 00       	call   80104060 <pinit>
8010383e:	e8 ad 27 00 00       	call   80105ff0 <tvinit>
80103843:	e8 f8 c7 ff ff       	call   80100040 <binit>
80103848:	e8 53 dd ff ff       	call   801015a0 <fileinit>
8010384d:	e8 fe f0 ff ff       	call   80102950 <ideinit>
80103852:	83 c4 0c             	add    $0xc,%esp
80103855:	68 8a 00 00 00       	push   $0x8a
8010385a:	68 8c b4 10 80       	push   $0x8010b48c
8010385f:	68 00 70 00 80       	push   $0x80007000
80103864:	e8 27 16 00 00       	call   80104e90 <memmove>
80103869:	83 c4 10             	add    $0x10,%esp
8010386c:	69 05 c4 33 11 80 b0 	imul   $0xb0,0x801133c4,%eax
80103873:	00 00 00 
80103876:	05 e0 33 11 80       	add    $0x801133e0,%eax
8010387b:	3d e0 33 11 80       	cmp    $0x801133e0,%eax
80103880:	76 7e                	jbe    80103900 <main+0x110>
80103882:	bb e0 33 11 80       	mov    $0x801133e0,%ebx
80103887:	eb 20                	jmp    801038a9 <main+0xb9>
80103889:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103890:	69 05 c4 33 11 80 b0 	imul   $0xb0,0x801133c4,%eax
80103897:	00 00 00 
8010389a:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
801038a0:	05 e0 33 11 80       	add    $0x801133e0,%eax
801038a5:	39 c3                	cmp    %eax,%ebx
801038a7:	73 57                	jae    80103900 <main+0x110>
801038a9:	e8 d2 07 00 00       	call   80104080 <mycpu>
801038ae:	39 c3                	cmp    %eax,%ebx
801038b0:	74 de                	je     80103890 <main+0xa0>
801038b2:	e8 59 f5 ff ff       	call   80102e10 <kalloc>
801038b7:	83 ec 08             	sub    $0x8,%esp
801038ba:	c7 05 f8 6f 00 80 d0 	movl   $0x801037d0,0x80006ff8
801038c1:	37 10 80 
801038c4:	c7 05 f4 6f 00 80 00 	movl   $0x10a000,0x80006ff4
801038cb:	a0 10 00 
801038ce:	05 00 10 00 00       	add    $0x1000,%eax
801038d3:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc
801038d8:	0f b6 03             	movzbl (%ebx),%eax
801038db:	68 00 70 00 00       	push   $0x7000
801038e0:	50                   	push   %eax
801038e1:	e8 ea f7 ff ff       	call   801030d0 <lapicstartap>
801038e6:	83 c4 10             	add    $0x10,%esp
801038e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801038f0:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
801038f6:	85 c0                	test   %eax,%eax
801038f8:	74 f6                	je     801038f0 <main+0x100>
801038fa:	eb 94                	jmp    80103890 <main+0xa0>
801038fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103900:	83 ec 08             	sub    $0x8,%esp
80103903:	68 00 00 00 8e       	push   $0x8e000000
80103908:	68 00 00 40 80       	push   $0x80400000
8010390d:	e8 2e f4 ff ff       	call   80102d40 <kinit2>
80103912:	e8 19 08 00 00       	call   80104130 <userinit>
80103917:	e8 74 fe ff ff       	call   80103790 <mpmain>
8010391c:	66 90                	xchg   %ax,%ax
8010391e:	66 90                	xchg   %ax,%ax

80103920 <mpsearch1>:
80103920:	55                   	push   %ebp
80103921:	89 e5                	mov    %esp,%ebp
80103923:	57                   	push   %edi
80103924:	56                   	push   %esi
80103925:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
8010392b:	53                   	push   %ebx
8010392c:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
8010392f:	83 ec 0c             	sub    $0xc,%esp
80103932:	39 de                	cmp    %ebx,%esi
80103934:	72 10                	jb     80103946 <mpsearch1+0x26>
80103936:	eb 50                	jmp    80103988 <mpsearch1+0x68>
80103938:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010393f:	90                   	nop
80103940:	89 fe                	mov    %edi,%esi
80103942:	39 fb                	cmp    %edi,%ebx
80103944:	76 42                	jbe    80103988 <mpsearch1+0x68>
80103946:	83 ec 04             	sub    $0x4,%esp
80103949:	8d 7e 10             	lea    0x10(%esi),%edi
8010394c:	6a 04                	push   $0x4
8010394e:	68 78 7e 10 80       	push   $0x80107e78
80103953:	56                   	push   %esi
80103954:	e8 e7 14 00 00       	call   80104e40 <memcmp>
80103959:	83 c4 10             	add    $0x10,%esp
8010395c:	85 c0                	test   %eax,%eax
8010395e:	75 e0                	jne    80103940 <mpsearch1+0x20>
80103960:	89 f2                	mov    %esi,%edx
80103962:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103968:	0f b6 0a             	movzbl (%edx),%ecx
8010396b:	83 c2 01             	add    $0x1,%edx
8010396e:	01 c8                	add    %ecx,%eax
80103970:	39 fa                	cmp    %edi,%edx
80103972:	75 f4                	jne    80103968 <mpsearch1+0x48>
80103974:	84 c0                	test   %al,%al
80103976:	75 c8                	jne    80103940 <mpsearch1+0x20>
80103978:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010397b:	89 f0                	mov    %esi,%eax
8010397d:	5b                   	pop    %ebx
8010397e:	5e                   	pop    %esi
8010397f:	5f                   	pop    %edi
80103980:	5d                   	pop    %ebp
80103981:	c3                   	ret    
80103982:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103988:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010398b:	31 f6                	xor    %esi,%esi
8010398d:	5b                   	pop    %ebx
8010398e:	89 f0                	mov    %esi,%eax
80103990:	5e                   	pop    %esi
80103991:	5f                   	pop    %edi
80103992:	5d                   	pop    %ebp
80103993:	c3                   	ret    
80103994:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010399b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010399f:	90                   	nop

801039a0 <mpinit>:
801039a0:	55                   	push   %ebp
801039a1:	89 e5                	mov    %esp,%ebp
801039a3:	57                   	push   %edi
801039a4:	56                   	push   %esi
801039a5:	53                   	push   %ebx
801039a6:	83 ec 1c             	sub    $0x1c,%esp
801039a9:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
801039b0:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
801039b7:	c1 e0 08             	shl    $0x8,%eax
801039ba:	09 d0                	or     %edx,%eax
801039bc:	c1 e0 04             	shl    $0x4,%eax
801039bf:	75 1b                	jne    801039dc <mpinit+0x3c>
801039c1:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
801039c8:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
801039cf:	c1 e0 08             	shl    $0x8,%eax
801039d2:	09 d0                	or     %edx,%eax
801039d4:	c1 e0 0a             	shl    $0xa,%eax
801039d7:	2d 00 04 00 00       	sub    $0x400,%eax
801039dc:	ba 00 04 00 00       	mov    $0x400,%edx
801039e1:	e8 3a ff ff ff       	call   80103920 <mpsearch1>
801039e6:	89 c3                	mov    %eax,%ebx
801039e8:	85 c0                	test   %eax,%eax
801039ea:	0f 84 40 01 00 00    	je     80103b30 <mpinit+0x190>
801039f0:	8b 73 04             	mov    0x4(%ebx),%esi
801039f3:	85 f6                	test   %esi,%esi
801039f5:	0f 84 25 01 00 00    	je     80103b20 <mpinit+0x180>
801039fb:	83 ec 04             	sub    $0x4,%esp
801039fe:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80103a04:	6a 04                	push   $0x4
80103a06:	68 7d 7e 10 80       	push   $0x80107e7d
80103a0b:	50                   	push   %eax
80103a0c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103a0f:	e8 2c 14 00 00       	call   80104e40 <memcmp>
80103a14:	83 c4 10             	add    $0x10,%esp
80103a17:	85 c0                	test   %eax,%eax
80103a19:	0f 85 01 01 00 00    	jne    80103b20 <mpinit+0x180>
80103a1f:	0f b6 86 06 00 00 80 	movzbl -0x7ffffffa(%esi),%eax
80103a26:	3c 01                	cmp    $0x1,%al
80103a28:	74 08                	je     80103a32 <mpinit+0x92>
80103a2a:	3c 04                	cmp    $0x4,%al
80103a2c:	0f 85 ee 00 00 00    	jne    80103b20 <mpinit+0x180>
80103a32:	0f b7 96 04 00 00 80 	movzwl -0x7ffffffc(%esi),%edx
80103a39:	66 85 d2             	test   %dx,%dx
80103a3c:	74 22                	je     80103a60 <mpinit+0xc0>
80103a3e:	8d 3c 32             	lea    (%edx,%esi,1),%edi
80103a41:	89 f0                	mov    %esi,%eax
80103a43:	31 d2                	xor    %edx,%edx
80103a45:	8d 76 00             	lea    0x0(%esi),%esi
80103a48:	0f b6 88 00 00 00 80 	movzbl -0x80000000(%eax),%ecx
80103a4f:	83 c0 01             	add    $0x1,%eax
80103a52:	01 ca                	add    %ecx,%edx
80103a54:	39 c7                	cmp    %eax,%edi
80103a56:	75 f0                	jne    80103a48 <mpinit+0xa8>
80103a58:	84 d2                	test   %dl,%dl
80103a5a:	0f 85 c0 00 00 00    	jne    80103b20 <mpinit+0x180>
80103a60:	8b 86 24 00 00 80    	mov    -0x7fffffdc(%esi),%eax
80103a66:	a3 c0 32 11 80       	mov    %eax,0x801132c0
80103a6b:	0f b7 96 04 00 00 80 	movzwl -0x7ffffffc(%esi),%edx
80103a72:	8d 86 2c 00 00 80    	lea    -0x7fffffd4(%esi),%eax
80103a78:	be 01 00 00 00       	mov    $0x1,%esi
80103a7d:	03 55 e4             	add    -0x1c(%ebp),%edx
80103a80:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
80103a83:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103a87:	90                   	nop
80103a88:	39 d0                	cmp    %edx,%eax
80103a8a:	73 15                	jae    80103aa1 <mpinit+0x101>
80103a8c:	0f b6 08             	movzbl (%eax),%ecx
80103a8f:	80 f9 02             	cmp    $0x2,%cl
80103a92:	74 4c                	je     80103ae0 <mpinit+0x140>
80103a94:	77 3a                	ja     80103ad0 <mpinit+0x130>
80103a96:	84 c9                	test   %cl,%cl
80103a98:	74 56                	je     80103af0 <mpinit+0x150>
80103a9a:	83 c0 08             	add    $0x8,%eax
80103a9d:	39 d0                	cmp    %edx,%eax
80103a9f:	72 eb                	jb     80103a8c <mpinit+0xec>
80103aa1:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80103aa4:	85 f6                	test   %esi,%esi
80103aa6:	0f 84 d9 00 00 00    	je     80103b85 <mpinit+0x1e5>
80103aac:	80 7b 0c 00          	cmpb   $0x0,0xc(%ebx)
80103ab0:	74 15                	je     80103ac7 <mpinit+0x127>
80103ab2:	b8 70 00 00 00       	mov    $0x70,%eax
80103ab7:	ba 22 00 00 00       	mov    $0x22,%edx
80103abc:	ee                   	out    %al,(%dx)
80103abd:	ba 23 00 00 00       	mov    $0x23,%edx
80103ac2:	ec                   	in     (%dx),%al
80103ac3:	83 c8 01             	or     $0x1,%eax
80103ac6:	ee                   	out    %al,(%dx)
80103ac7:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103aca:	5b                   	pop    %ebx
80103acb:	5e                   	pop    %esi
80103acc:	5f                   	pop    %edi
80103acd:	5d                   	pop    %ebp
80103ace:	c3                   	ret    
80103acf:	90                   	nop
80103ad0:	83 e9 03             	sub    $0x3,%ecx
80103ad3:	80 f9 01             	cmp    $0x1,%cl
80103ad6:	76 c2                	jbe    80103a9a <mpinit+0xfa>
80103ad8:	31 f6                	xor    %esi,%esi
80103ada:	eb ac                	jmp    80103a88 <mpinit+0xe8>
80103adc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103ae0:	0f b6 48 01          	movzbl 0x1(%eax),%ecx
80103ae4:	83 c0 08             	add    $0x8,%eax
80103ae7:	88 0d c0 33 11 80    	mov    %cl,0x801133c0
80103aed:	eb 99                	jmp    80103a88 <mpinit+0xe8>
80103aef:	90                   	nop
80103af0:	8b 0d c4 33 11 80    	mov    0x801133c4,%ecx
80103af6:	83 f9 07             	cmp    $0x7,%ecx
80103af9:	7f 19                	jg     80103b14 <mpinit+0x174>
80103afb:	69 f9 b0 00 00 00    	imul   $0xb0,%ecx,%edi
80103b01:	0f b6 58 01          	movzbl 0x1(%eax),%ebx
80103b05:	83 c1 01             	add    $0x1,%ecx
80103b08:	89 0d c4 33 11 80    	mov    %ecx,0x801133c4
80103b0e:	88 9f e0 33 11 80    	mov    %bl,-0x7feecc20(%edi)
80103b14:	83 c0 14             	add    $0x14,%eax
80103b17:	e9 6c ff ff ff       	jmp    80103a88 <mpinit+0xe8>
80103b1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103b20:	83 ec 0c             	sub    $0xc,%esp
80103b23:	68 82 7e 10 80       	push   $0x80107e82
80103b28:	e8 73 c8 ff ff       	call   801003a0 <panic>
80103b2d:	8d 76 00             	lea    0x0(%esi),%esi
80103b30:	bb 00 00 0f 80       	mov    $0x800f0000,%ebx
80103b35:	eb 13                	jmp    80103b4a <mpinit+0x1aa>
80103b37:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103b3e:	66 90                	xchg   %ax,%ax
80103b40:	89 f3                	mov    %esi,%ebx
80103b42:	81 fe 00 00 10 80    	cmp    $0x80100000,%esi
80103b48:	74 d6                	je     80103b20 <mpinit+0x180>
80103b4a:	83 ec 04             	sub    $0x4,%esp
80103b4d:	8d 73 10             	lea    0x10(%ebx),%esi
80103b50:	6a 04                	push   $0x4
80103b52:	68 78 7e 10 80       	push   $0x80107e78
80103b57:	53                   	push   %ebx
80103b58:	e8 e3 12 00 00       	call   80104e40 <memcmp>
80103b5d:	83 c4 10             	add    $0x10,%esp
80103b60:	85 c0                	test   %eax,%eax
80103b62:	75 dc                	jne    80103b40 <mpinit+0x1a0>
80103b64:	89 da                	mov    %ebx,%edx
80103b66:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103b6d:	8d 76 00             	lea    0x0(%esi),%esi
80103b70:	0f b6 0a             	movzbl (%edx),%ecx
80103b73:	83 c2 01             	add    $0x1,%edx
80103b76:	01 c8                	add    %ecx,%eax
80103b78:	39 d6                	cmp    %edx,%esi
80103b7a:	75 f4                	jne    80103b70 <mpinit+0x1d0>
80103b7c:	84 c0                	test   %al,%al
80103b7e:	75 c0                	jne    80103b40 <mpinit+0x1a0>
80103b80:	e9 6b fe ff ff       	jmp    801039f0 <mpinit+0x50>
80103b85:	83 ec 0c             	sub    $0xc,%esp
80103b88:	68 9c 7e 10 80       	push   $0x80107e9c
80103b8d:	e8 0e c8 ff ff       	call   801003a0 <panic>
80103b92:	66 90                	xchg   %ax,%ax
80103b94:	66 90                	xchg   %ax,%ax
80103b96:	66 90                	xchg   %ax,%ax
80103b98:	66 90                	xchg   %ax,%ax
80103b9a:	66 90                	xchg   %ax,%ax
80103b9c:	66 90                	xchg   %ax,%ax
80103b9e:	66 90                	xchg   %ax,%ax

80103ba0 <picinit>:
80103ba0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103ba5:	ba 21 00 00 00       	mov    $0x21,%edx
80103baa:	ee                   	out    %al,(%dx)
80103bab:	ba a1 00 00 00       	mov    $0xa1,%edx
80103bb0:	ee                   	out    %al,(%dx)
80103bb1:	c3                   	ret    
80103bb2:	66 90                	xchg   %ax,%ax
80103bb4:	66 90                	xchg   %ax,%ax
80103bb6:	66 90                	xchg   %ax,%ax
80103bb8:	66 90                	xchg   %ax,%ax
80103bba:	66 90                	xchg   %ax,%ax
80103bbc:	66 90                	xchg   %ax,%ax
80103bbe:	66 90                	xchg   %ax,%ax

80103bc0 <pipealloc>:
80103bc0:	55                   	push   %ebp
80103bc1:	89 e5                	mov    %esp,%ebp
80103bc3:	57                   	push   %edi
80103bc4:	56                   	push   %esi
80103bc5:	53                   	push   %ebx
80103bc6:	83 ec 0c             	sub    $0xc,%esp
80103bc9:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103bcc:	8b 75 0c             	mov    0xc(%ebp),%esi
80103bcf:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80103bd5:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80103bdb:	e8 e0 d9 ff ff       	call   801015c0 <filealloc>
80103be0:	89 03                	mov    %eax,(%ebx)
80103be2:	85 c0                	test   %eax,%eax
80103be4:	0f 84 a8 00 00 00    	je     80103c92 <pipealloc+0xd2>
80103bea:	e8 d1 d9 ff ff       	call   801015c0 <filealloc>
80103bef:	89 06                	mov    %eax,(%esi)
80103bf1:	85 c0                	test   %eax,%eax
80103bf3:	0f 84 87 00 00 00    	je     80103c80 <pipealloc+0xc0>
80103bf9:	e8 12 f2 ff ff       	call   80102e10 <kalloc>
80103bfe:	89 c7                	mov    %eax,%edi
80103c00:	85 c0                	test   %eax,%eax
80103c02:	0f 84 b0 00 00 00    	je     80103cb8 <pipealloc+0xf8>
80103c08:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
80103c0f:	00 00 00 
80103c12:	83 ec 08             	sub    $0x8,%esp
80103c15:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
80103c1c:	00 00 00 
80103c1f:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
80103c26:	00 00 00 
80103c29:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
80103c30:	00 00 00 
80103c33:	68 bb 7e 10 80       	push   $0x80107ebb
80103c38:	50                   	push   %eax
80103c39:	e8 22 0f 00 00       	call   80104b60 <initlock>
80103c3e:	8b 03                	mov    (%ebx),%eax
80103c40:	83 c4 10             	add    $0x10,%esp
80103c43:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
80103c49:	8b 03                	mov    (%ebx),%eax
80103c4b:	c6 40 08 01          	movb   $0x1,0x8(%eax)
80103c4f:	8b 03                	mov    (%ebx),%eax
80103c51:	c6 40 09 00          	movb   $0x0,0x9(%eax)
80103c55:	8b 03                	mov    (%ebx),%eax
80103c57:	89 78 0c             	mov    %edi,0xc(%eax)
80103c5a:	8b 06                	mov    (%esi),%eax
80103c5c:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
80103c62:	8b 06                	mov    (%esi),%eax
80103c64:	c6 40 08 00          	movb   $0x0,0x8(%eax)
80103c68:	8b 06                	mov    (%esi),%eax
80103c6a:	c6 40 09 01          	movb   $0x1,0x9(%eax)
80103c6e:	8b 06                	mov    (%esi),%eax
80103c70:	89 78 0c             	mov    %edi,0xc(%eax)
80103c73:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103c76:	31 c0                	xor    %eax,%eax
80103c78:	5b                   	pop    %ebx
80103c79:	5e                   	pop    %esi
80103c7a:	5f                   	pop    %edi
80103c7b:	5d                   	pop    %ebp
80103c7c:	c3                   	ret    
80103c7d:	8d 76 00             	lea    0x0(%esi),%esi
80103c80:	8b 03                	mov    (%ebx),%eax
80103c82:	85 c0                	test   %eax,%eax
80103c84:	74 1e                	je     80103ca4 <pipealloc+0xe4>
80103c86:	83 ec 0c             	sub    $0xc,%esp
80103c89:	50                   	push   %eax
80103c8a:	e8 f1 d9 ff ff       	call   80101680 <fileclose>
80103c8f:	83 c4 10             	add    $0x10,%esp
80103c92:	8b 06                	mov    (%esi),%eax
80103c94:	85 c0                	test   %eax,%eax
80103c96:	74 0c                	je     80103ca4 <pipealloc+0xe4>
80103c98:	83 ec 0c             	sub    $0xc,%esp
80103c9b:	50                   	push   %eax
80103c9c:	e8 df d9 ff ff       	call   80101680 <fileclose>
80103ca1:	83 c4 10             	add    $0x10,%esp
80103ca4:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103ca7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103cac:	5b                   	pop    %ebx
80103cad:	5e                   	pop    %esi
80103cae:	5f                   	pop    %edi
80103caf:	5d                   	pop    %ebp
80103cb0:	c3                   	ret    
80103cb1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103cb8:	8b 03                	mov    (%ebx),%eax
80103cba:	85 c0                	test   %eax,%eax
80103cbc:	75 c8                	jne    80103c86 <pipealloc+0xc6>
80103cbe:	eb d2                	jmp    80103c92 <pipealloc+0xd2>

80103cc0 <pipeclose>:
80103cc0:	55                   	push   %ebp
80103cc1:	89 e5                	mov    %esp,%ebp
80103cc3:	56                   	push   %esi
80103cc4:	53                   	push   %ebx
80103cc5:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103cc8:	8b 75 0c             	mov    0xc(%ebp),%esi
80103ccb:	83 ec 0c             	sub    $0xc,%esp
80103cce:	53                   	push   %ebx
80103ccf:	e8 5c 10 00 00       	call   80104d30 <acquire>
80103cd4:	83 c4 10             	add    $0x10,%esp
80103cd7:	85 f6                	test   %esi,%esi
80103cd9:	74 65                	je     80103d40 <pipeclose+0x80>
80103cdb:	83 ec 0c             	sub    $0xc,%esp
80103cde:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80103ce4:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
80103ceb:	00 00 00 
80103cee:	50                   	push   %eax
80103cef:	e8 9c 0b 00 00       	call   80104890 <wakeup>
80103cf4:	83 c4 10             	add    $0x10,%esp
80103cf7:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
80103cfd:	85 d2                	test   %edx,%edx
80103cff:	75 0a                	jne    80103d0b <pipeclose+0x4b>
80103d01:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
80103d07:	85 c0                	test   %eax,%eax
80103d09:	74 15                	je     80103d20 <pipeclose+0x60>
80103d0b:	89 5d 08             	mov    %ebx,0x8(%ebp)
80103d0e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103d11:	5b                   	pop    %ebx
80103d12:	5e                   	pop    %esi
80103d13:	5d                   	pop    %ebp
80103d14:	e9 b7 0f 00 00       	jmp    80104cd0 <release>
80103d19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103d20:	83 ec 0c             	sub    $0xc,%esp
80103d23:	53                   	push   %ebx
80103d24:	e8 a7 0f 00 00       	call   80104cd0 <release>
80103d29:	89 5d 08             	mov    %ebx,0x8(%ebp)
80103d2c:	83 c4 10             	add    $0x10,%esp
80103d2f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103d32:	5b                   	pop    %ebx
80103d33:	5e                   	pop    %esi
80103d34:	5d                   	pop    %ebp
80103d35:	e9 16 ef ff ff       	jmp    80102c50 <kfree>
80103d3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103d40:	83 ec 0c             	sub    $0xc,%esp
80103d43:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
80103d49:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
80103d50:	00 00 00 
80103d53:	50                   	push   %eax
80103d54:	e8 37 0b 00 00       	call   80104890 <wakeup>
80103d59:	83 c4 10             	add    $0x10,%esp
80103d5c:	eb 99                	jmp    80103cf7 <pipeclose+0x37>
80103d5e:	66 90                	xchg   %ax,%ax

80103d60 <pipewrite>:
80103d60:	55                   	push   %ebp
80103d61:	89 e5                	mov    %esp,%ebp
80103d63:	57                   	push   %edi
80103d64:	56                   	push   %esi
80103d65:	53                   	push   %ebx
80103d66:	83 ec 28             	sub    $0x28,%esp
80103d69:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103d6c:	53                   	push   %ebx
80103d6d:	e8 be 0f 00 00       	call   80104d30 <acquire>
80103d72:	8b 45 10             	mov    0x10(%ebp),%eax
80103d75:	83 c4 10             	add    $0x10,%esp
80103d78:	85 c0                	test   %eax,%eax
80103d7a:	0f 8e c0 00 00 00    	jle    80103e40 <pipewrite+0xe0>
80103d80:	8b 45 0c             	mov    0xc(%ebp),%eax
80103d83:	8b 8b 38 02 00 00    	mov    0x238(%ebx),%ecx
80103d89:	8d bb 34 02 00 00    	lea    0x234(%ebx),%edi
80103d8f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103d92:	03 45 10             	add    0x10(%ebp),%eax
80103d95:	89 45 e0             	mov    %eax,-0x20(%ebp)
80103d98:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
80103d9e:	8d b3 38 02 00 00    	lea    0x238(%ebx),%esi
80103da4:	89 ca                	mov    %ecx,%edx
80103da6:	05 00 02 00 00       	add    $0x200,%eax
80103dab:	39 c1                	cmp    %eax,%ecx
80103dad:	74 3f                	je     80103dee <pipewrite+0x8e>
80103daf:	eb 67                	jmp    80103e18 <pipewrite+0xb8>
80103db1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103db8:	e8 43 03 00 00       	call   80104100 <myproc>
80103dbd:	8b 48 24             	mov    0x24(%eax),%ecx
80103dc0:	85 c9                	test   %ecx,%ecx
80103dc2:	75 34                	jne    80103df8 <pipewrite+0x98>
80103dc4:	83 ec 0c             	sub    $0xc,%esp
80103dc7:	57                   	push   %edi
80103dc8:	e8 c3 0a 00 00       	call   80104890 <wakeup>
80103dcd:	58                   	pop    %eax
80103dce:	5a                   	pop    %edx
80103dcf:	53                   	push   %ebx
80103dd0:	56                   	push   %esi
80103dd1:	e8 fa 09 00 00       	call   801047d0 <sleep>
80103dd6:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
80103ddc:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
80103de2:	83 c4 10             	add    $0x10,%esp
80103de5:	05 00 02 00 00       	add    $0x200,%eax
80103dea:	39 c2                	cmp    %eax,%edx
80103dec:	75 2a                	jne    80103e18 <pipewrite+0xb8>
80103dee:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
80103df4:	85 c0                	test   %eax,%eax
80103df6:	75 c0                	jne    80103db8 <pipewrite+0x58>
80103df8:	83 ec 0c             	sub    $0xc,%esp
80103dfb:	53                   	push   %ebx
80103dfc:	e8 cf 0e 00 00       	call   80104cd0 <release>
80103e01:	83 c4 10             	add    $0x10,%esp
80103e04:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103e09:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103e0c:	5b                   	pop    %ebx
80103e0d:	5e                   	pop    %esi
80103e0e:	5f                   	pop    %edi
80103e0f:	5d                   	pop    %ebp
80103e10:	c3                   	ret    
80103e11:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103e18:	8b 75 e4             	mov    -0x1c(%ebp),%esi
80103e1b:	8d 4a 01             	lea    0x1(%edx),%ecx
80103e1e:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
80103e24:	89 8b 38 02 00 00    	mov    %ecx,0x238(%ebx)
80103e2a:	0f b6 06             	movzbl (%esi),%eax
80103e2d:	83 c6 01             	add    $0x1,%esi
80103e30:	89 75 e4             	mov    %esi,-0x1c(%ebp)
80103e33:	88 44 13 34          	mov    %al,0x34(%ebx,%edx,1)
80103e37:	3b 75 e0             	cmp    -0x20(%ebp),%esi
80103e3a:	0f 85 58 ff ff ff    	jne    80103d98 <pipewrite+0x38>
80103e40:	83 ec 0c             	sub    $0xc,%esp
80103e43:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80103e49:	50                   	push   %eax
80103e4a:	e8 41 0a 00 00       	call   80104890 <wakeup>
80103e4f:	89 1c 24             	mov    %ebx,(%esp)
80103e52:	e8 79 0e 00 00       	call   80104cd0 <release>
80103e57:	8b 45 10             	mov    0x10(%ebp),%eax
80103e5a:	83 c4 10             	add    $0x10,%esp
80103e5d:	eb aa                	jmp    80103e09 <pipewrite+0xa9>
80103e5f:	90                   	nop

80103e60 <piperead>:
80103e60:	55                   	push   %ebp
80103e61:	89 e5                	mov    %esp,%ebp
80103e63:	57                   	push   %edi
80103e64:	56                   	push   %esi
80103e65:	53                   	push   %ebx
80103e66:	83 ec 18             	sub    $0x18,%esp
80103e69:	8b 75 08             	mov    0x8(%ebp),%esi
80103e6c:	8b 7d 0c             	mov    0xc(%ebp),%edi
80103e6f:	56                   	push   %esi
80103e70:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
80103e76:	e8 b5 0e 00 00       	call   80104d30 <acquire>
80103e7b:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
80103e81:	83 c4 10             	add    $0x10,%esp
80103e84:	39 86 38 02 00 00    	cmp    %eax,0x238(%esi)
80103e8a:	74 2f                	je     80103ebb <piperead+0x5b>
80103e8c:	eb 37                	jmp    80103ec5 <piperead+0x65>
80103e8e:	66 90                	xchg   %ax,%ax
80103e90:	e8 6b 02 00 00       	call   80104100 <myproc>
80103e95:	8b 48 24             	mov    0x24(%eax),%ecx
80103e98:	85 c9                	test   %ecx,%ecx
80103e9a:	0f 85 80 00 00 00    	jne    80103f20 <piperead+0xc0>
80103ea0:	83 ec 08             	sub    $0x8,%esp
80103ea3:	56                   	push   %esi
80103ea4:	53                   	push   %ebx
80103ea5:	e8 26 09 00 00       	call   801047d0 <sleep>
80103eaa:	8b 86 38 02 00 00    	mov    0x238(%esi),%eax
80103eb0:	83 c4 10             	add    $0x10,%esp
80103eb3:	39 86 34 02 00 00    	cmp    %eax,0x234(%esi)
80103eb9:	75 0a                	jne    80103ec5 <piperead+0x65>
80103ebb:	8b 86 40 02 00 00    	mov    0x240(%esi),%eax
80103ec1:	85 c0                	test   %eax,%eax
80103ec3:	75 cb                	jne    80103e90 <piperead+0x30>
80103ec5:	8b 55 10             	mov    0x10(%ebp),%edx
80103ec8:	31 db                	xor    %ebx,%ebx
80103eca:	85 d2                	test   %edx,%edx
80103ecc:	7f 20                	jg     80103eee <piperead+0x8e>
80103ece:	eb 2c                	jmp    80103efc <piperead+0x9c>
80103ed0:	8d 48 01             	lea    0x1(%eax),%ecx
80103ed3:	25 ff 01 00 00       	and    $0x1ff,%eax
80103ed8:	89 8e 34 02 00 00    	mov    %ecx,0x234(%esi)
80103ede:	0f b6 44 06 34       	movzbl 0x34(%esi,%eax,1),%eax
80103ee3:	88 04 1f             	mov    %al,(%edi,%ebx,1)
80103ee6:	83 c3 01             	add    $0x1,%ebx
80103ee9:	39 5d 10             	cmp    %ebx,0x10(%ebp)
80103eec:	74 0e                	je     80103efc <piperead+0x9c>
80103eee:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
80103ef4:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
80103efa:	75 d4                	jne    80103ed0 <piperead+0x70>
80103efc:	83 ec 0c             	sub    $0xc,%esp
80103eff:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
80103f05:	50                   	push   %eax
80103f06:	e8 85 09 00 00       	call   80104890 <wakeup>
80103f0b:	89 34 24             	mov    %esi,(%esp)
80103f0e:	e8 bd 0d 00 00       	call   80104cd0 <release>
80103f13:	83 c4 10             	add    $0x10,%esp
80103f16:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103f19:	89 d8                	mov    %ebx,%eax
80103f1b:	5b                   	pop    %ebx
80103f1c:	5e                   	pop    %esi
80103f1d:	5f                   	pop    %edi
80103f1e:	5d                   	pop    %ebp
80103f1f:	c3                   	ret    
80103f20:	83 ec 0c             	sub    $0xc,%esp
80103f23:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80103f28:	56                   	push   %esi
80103f29:	e8 a2 0d 00 00       	call   80104cd0 <release>
80103f2e:	83 c4 10             	add    $0x10,%esp
80103f31:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103f34:	89 d8                	mov    %ebx,%eax
80103f36:	5b                   	pop    %ebx
80103f37:	5e                   	pop    %esi
80103f38:	5f                   	pop    %edi
80103f39:	5d                   	pop    %ebp
80103f3a:	c3                   	ret    
80103f3b:	66 90                	xchg   %ax,%ax
80103f3d:	66 90                	xchg   %ax,%ax
80103f3f:	90                   	nop

80103f40 <allocproc>:
80103f40:	55                   	push   %ebp
80103f41:	89 e5                	mov    %esp,%ebp
80103f43:	53                   	push   %ebx
80103f44:	bb 94 39 11 80       	mov    $0x80113994,%ebx
80103f49:	83 ec 10             	sub    $0x10,%esp
80103f4c:	68 60 39 11 80       	push   $0x80113960
80103f51:	e8 da 0d 00 00       	call   80104d30 <acquire>
80103f56:	83 c4 10             	add    $0x10,%esp
80103f59:	eb 10                	jmp    80103f6b <allocproc+0x2b>
80103f5b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103f5f:	90                   	nop
80103f60:	83 c3 7c             	add    $0x7c,%ebx
80103f63:	81 fb 94 58 11 80    	cmp    $0x80115894,%ebx
80103f69:	74 75                	je     80103fe0 <allocproc+0xa0>
80103f6b:	8b 43 0c             	mov    0xc(%ebx),%eax
80103f6e:	85 c0                	test   %eax,%eax
80103f70:	75 ee                	jne    80103f60 <allocproc+0x20>
80103f72:	a1 04 b0 10 80       	mov    0x8010b004,%eax
80103f77:	83 ec 0c             	sub    $0xc,%esp
80103f7a:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
80103f81:	89 43 10             	mov    %eax,0x10(%ebx)
80103f84:	8d 50 01             	lea    0x1(%eax),%edx
80103f87:	68 60 39 11 80       	push   $0x80113960
80103f8c:	89 15 04 b0 10 80    	mov    %edx,0x8010b004
80103f92:	e8 39 0d 00 00       	call   80104cd0 <release>
80103f97:	e8 74 ee ff ff       	call   80102e10 <kalloc>
80103f9c:	83 c4 10             	add    $0x10,%esp
80103f9f:	89 43 08             	mov    %eax,0x8(%ebx)
80103fa2:	85 c0                	test   %eax,%eax
80103fa4:	74 53                	je     80103ff9 <allocproc+0xb9>
80103fa6:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
80103fac:	83 ec 04             	sub    $0x4,%esp
80103faf:	05 9c 0f 00 00       	add    $0xf9c,%eax
80103fb4:	89 53 18             	mov    %edx,0x18(%ebx)
80103fb7:	c7 40 14 e2 5f 10 80 	movl   $0x80105fe2,0x14(%eax)
80103fbe:	89 43 1c             	mov    %eax,0x1c(%ebx)
80103fc1:	6a 14                	push   $0x14
80103fc3:	6a 00                	push   $0x0
80103fc5:	50                   	push   %eax
80103fc6:	e8 25 0e 00 00       	call   80104df0 <memset>
80103fcb:	8b 43 1c             	mov    0x1c(%ebx),%eax
80103fce:	83 c4 10             	add    $0x10,%esp
80103fd1:	c7 40 10 10 40 10 80 	movl   $0x80104010,0x10(%eax)
80103fd8:	89 d8                	mov    %ebx,%eax
80103fda:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103fdd:	c9                   	leave  
80103fde:	c3                   	ret    
80103fdf:	90                   	nop
80103fe0:	83 ec 0c             	sub    $0xc,%esp
80103fe3:	31 db                	xor    %ebx,%ebx
80103fe5:	68 60 39 11 80       	push   $0x80113960
80103fea:	e8 e1 0c 00 00       	call   80104cd0 <release>
80103fef:	89 d8                	mov    %ebx,%eax
80103ff1:	83 c4 10             	add    $0x10,%esp
80103ff4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103ff7:	c9                   	leave  
80103ff8:	c3                   	ret    
80103ff9:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
80104000:	31 db                	xor    %ebx,%ebx
80104002:	89 d8                	mov    %ebx,%eax
80104004:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104007:	c9                   	leave  
80104008:	c3                   	ret    
80104009:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104010 <forkret>:
80104010:	55                   	push   %ebp
80104011:	89 e5                	mov    %esp,%ebp
80104013:	83 ec 14             	sub    $0x14,%esp
80104016:	68 60 39 11 80       	push   $0x80113960
8010401b:	e8 b0 0c 00 00       	call   80104cd0 <release>
80104020:	a1 00 b0 10 80       	mov    0x8010b000,%eax
80104025:	83 c4 10             	add    $0x10,%esp
80104028:	85 c0                	test   %eax,%eax
8010402a:	75 04                	jne    80104030 <forkret+0x20>
8010402c:	c9                   	leave  
8010402d:	c3                   	ret    
8010402e:	66 90                	xchg   %ax,%ax
80104030:	c7 05 00 b0 10 80 00 	movl   $0x0,0x8010b000
80104037:	00 00 00 
8010403a:	83 ec 0c             	sub    $0xc,%esp
8010403d:	6a 01                	push   $0x1
8010403f:	e8 ac dc ff ff       	call   80101cf0 <iinit>
80104044:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
8010404b:	e8 00 f4 ff ff       	call   80103450 <initlog>
80104050:	83 c4 10             	add    $0x10,%esp
80104053:	c9                   	leave  
80104054:	c3                   	ret    
80104055:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010405c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104060 <pinit>:
80104060:	55                   	push   %ebp
80104061:	89 e5                	mov    %esp,%ebp
80104063:	83 ec 10             	sub    $0x10,%esp
80104066:	68 c0 7e 10 80       	push   $0x80107ec0
8010406b:	68 60 39 11 80       	push   $0x80113960
80104070:	e8 eb 0a 00 00       	call   80104b60 <initlock>
80104075:	83 c4 10             	add    $0x10,%esp
80104078:	c9                   	leave  
80104079:	c3                   	ret    
8010407a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104080 <mycpu>:
80104080:	55                   	push   %ebp
80104081:	89 e5                	mov    %esp,%ebp
80104083:	56                   	push   %esi
80104084:	53                   	push   %ebx
80104085:	9c                   	pushf  
80104086:	58                   	pop    %eax
80104087:	f6 c4 02             	test   $0x2,%ah
8010408a:	75 46                	jne    801040d2 <mycpu+0x52>
8010408c:	e8 ef ef ff ff       	call   80103080 <lapicid>
80104091:	8b 35 c4 33 11 80    	mov    0x801133c4,%esi
80104097:	85 f6                	test   %esi,%esi
80104099:	7e 2a                	jle    801040c5 <mycpu+0x45>
8010409b:	31 d2                	xor    %edx,%edx
8010409d:	eb 08                	jmp    801040a7 <mycpu+0x27>
8010409f:	90                   	nop
801040a0:	83 c2 01             	add    $0x1,%edx
801040a3:	39 f2                	cmp    %esi,%edx
801040a5:	74 1e                	je     801040c5 <mycpu+0x45>
801040a7:	69 ca b0 00 00 00    	imul   $0xb0,%edx,%ecx
801040ad:	0f b6 99 e0 33 11 80 	movzbl -0x7feecc20(%ecx),%ebx
801040b4:	39 c3                	cmp    %eax,%ebx
801040b6:	75 e8                	jne    801040a0 <mycpu+0x20>
801040b8:	8d 65 f8             	lea    -0x8(%ebp),%esp
801040bb:	8d 81 e0 33 11 80    	lea    -0x7feecc20(%ecx),%eax
801040c1:	5b                   	pop    %ebx
801040c2:	5e                   	pop    %esi
801040c3:	5d                   	pop    %ebp
801040c4:	c3                   	ret    
801040c5:	83 ec 0c             	sub    $0xc,%esp
801040c8:	68 c7 7e 10 80       	push   $0x80107ec7
801040cd:	e8 ce c2 ff ff       	call   801003a0 <panic>
801040d2:	83 ec 0c             	sub    $0xc,%esp
801040d5:	68 a4 7f 10 80       	push   $0x80107fa4
801040da:	e8 c1 c2 ff ff       	call   801003a0 <panic>
801040df:	90                   	nop

801040e0 <cpuid>:
801040e0:	55                   	push   %ebp
801040e1:	89 e5                	mov    %esp,%ebp
801040e3:	83 ec 08             	sub    $0x8,%esp
801040e6:	e8 95 ff ff ff       	call   80104080 <mycpu>
801040eb:	c9                   	leave  
801040ec:	2d e0 33 11 80       	sub    $0x801133e0,%eax
801040f1:	c1 f8 04             	sar    $0x4,%eax
801040f4:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
801040fa:	c3                   	ret    
801040fb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801040ff:	90                   	nop

80104100 <myproc>:
80104100:	55                   	push   %ebp
80104101:	89 e5                	mov    %esp,%ebp
80104103:	53                   	push   %ebx
80104104:	83 ec 04             	sub    $0x4,%esp
80104107:	e8 d4 0a 00 00       	call   80104be0 <pushcli>
8010410c:	e8 6f ff ff ff       	call   80104080 <mycpu>
80104111:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
80104117:	e8 14 0b 00 00       	call   80104c30 <popcli>
8010411c:	89 d8                	mov    %ebx,%eax
8010411e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104121:	c9                   	leave  
80104122:	c3                   	ret    
80104123:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010412a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104130 <userinit>:
80104130:	55                   	push   %ebp
80104131:	89 e5                	mov    %esp,%ebp
80104133:	53                   	push   %ebx
80104134:	83 ec 04             	sub    $0x4,%esp
80104137:	e8 04 fe ff ff       	call   80103f40 <allocproc>
8010413c:	89 c3                	mov    %eax,%ebx
8010413e:	a3 94 58 11 80       	mov    %eax,0x80115894
80104143:	e8 88 34 00 00       	call   801075d0 <setupkvm>
80104148:	89 43 04             	mov    %eax,0x4(%ebx)
8010414b:	85 c0                	test   %eax,%eax
8010414d:	0f 84 bd 00 00 00    	je     80104210 <userinit+0xe0>
80104153:	83 ec 04             	sub    $0x4,%esp
80104156:	68 2c 00 00 00       	push   $0x2c
8010415b:	68 60 b4 10 80       	push   $0x8010b460
80104160:	50                   	push   %eax
80104161:	e8 1a 31 00 00       	call   80107280 <inituvm>
80104166:	83 c4 0c             	add    $0xc,%esp
80104169:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
8010416f:	6a 4c                	push   $0x4c
80104171:	6a 00                	push   $0x0
80104173:	ff 73 18             	push   0x18(%ebx)
80104176:	e8 75 0c 00 00       	call   80104df0 <memset>
8010417b:	8b 43 18             	mov    0x18(%ebx),%eax
8010417e:	ba 1b 00 00 00       	mov    $0x1b,%edx
80104183:	83 c4 0c             	add    $0xc,%esp
80104186:	b9 23 00 00 00       	mov    $0x23,%ecx
8010418b:	66 89 50 3c          	mov    %dx,0x3c(%eax)
8010418f:	8b 43 18             	mov    0x18(%ebx),%eax
80104192:	66 89 48 2c          	mov    %cx,0x2c(%eax)
80104196:	8b 43 18             	mov    0x18(%ebx),%eax
80104199:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
8010419d:	66 89 50 28          	mov    %dx,0x28(%eax)
801041a1:	8b 43 18             	mov    0x18(%ebx),%eax
801041a4:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
801041a8:	66 89 50 48          	mov    %dx,0x48(%eax)
801041ac:	8b 43 18             	mov    0x18(%ebx),%eax
801041af:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
801041b6:	8b 43 18             	mov    0x18(%ebx),%eax
801041b9:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
801041c0:	8b 43 18             	mov    0x18(%ebx),%eax
801041c3:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
801041ca:	8d 43 6c             	lea    0x6c(%ebx),%eax
801041cd:	6a 10                	push   $0x10
801041cf:	68 f0 7e 10 80       	push   $0x80107ef0
801041d4:	50                   	push   %eax
801041d5:	e8 d6 0d 00 00       	call   80104fb0 <safestrcpy>
801041da:	c7 04 24 f9 7e 10 80 	movl   $0x80107ef9,(%esp)
801041e1:	e8 4a e6 ff ff       	call   80102830 <namei>
801041e6:	89 43 68             	mov    %eax,0x68(%ebx)
801041e9:	c7 04 24 60 39 11 80 	movl   $0x80113960,(%esp)
801041f0:	e8 3b 0b 00 00       	call   80104d30 <acquire>
801041f5:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
801041fc:	c7 04 24 60 39 11 80 	movl   $0x80113960,(%esp)
80104203:	e8 c8 0a 00 00       	call   80104cd0 <release>
80104208:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010420b:	83 c4 10             	add    $0x10,%esp
8010420e:	c9                   	leave  
8010420f:	c3                   	ret    
80104210:	83 ec 0c             	sub    $0xc,%esp
80104213:	68 d7 7e 10 80       	push   $0x80107ed7
80104218:	e8 83 c1 ff ff       	call   801003a0 <panic>
8010421d:	8d 76 00             	lea    0x0(%esi),%esi

80104220 <growproc>:
80104220:	55                   	push   %ebp
80104221:	89 e5                	mov    %esp,%ebp
80104223:	56                   	push   %esi
80104224:	53                   	push   %ebx
80104225:	8b 75 08             	mov    0x8(%ebp),%esi
80104228:	e8 b3 09 00 00       	call   80104be0 <pushcli>
8010422d:	e8 4e fe ff ff       	call   80104080 <mycpu>
80104232:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
80104238:	e8 f3 09 00 00       	call   80104c30 <popcli>
8010423d:	8b 03                	mov    (%ebx),%eax
8010423f:	85 f6                	test   %esi,%esi
80104241:	7f 1d                	jg     80104260 <growproc+0x40>
80104243:	75 3b                	jne    80104280 <growproc+0x60>
80104245:	83 ec 0c             	sub    $0xc,%esp
80104248:	89 03                	mov    %eax,(%ebx)
8010424a:	53                   	push   %ebx
8010424b:	e8 20 2f 00 00       	call   80107170 <switchuvm>
80104250:	83 c4 10             	add    $0x10,%esp
80104253:	31 c0                	xor    %eax,%eax
80104255:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104258:	5b                   	pop    %ebx
80104259:	5e                   	pop    %esi
8010425a:	5d                   	pop    %ebp
8010425b:	c3                   	ret    
8010425c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104260:	83 ec 04             	sub    $0x4,%esp
80104263:	01 c6                	add    %eax,%esi
80104265:	56                   	push   %esi
80104266:	50                   	push   %eax
80104267:	ff 73 04             	push   0x4(%ebx)
8010426a:	e8 81 31 00 00       	call   801073f0 <allocuvm>
8010426f:	83 c4 10             	add    $0x10,%esp
80104272:	85 c0                	test   %eax,%eax
80104274:	75 cf                	jne    80104245 <growproc+0x25>
80104276:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010427b:	eb d8                	jmp    80104255 <growproc+0x35>
8010427d:	8d 76 00             	lea    0x0(%esi),%esi
80104280:	83 ec 04             	sub    $0x4,%esp
80104283:	01 c6                	add    %eax,%esi
80104285:	56                   	push   %esi
80104286:	50                   	push   %eax
80104287:	ff 73 04             	push   0x4(%ebx)
8010428a:	e8 91 32 00 00       	call   80107520 <deallocuvm>
8010428f:	83 c4 10             	add    $0x10,%esp
80104292:	85 c0                	test   %eax,%eax
80104294:	75 af                	jne    80104245 <growproc+0x25>
80104296:	eb de                	jmp    80104276 <growproc+0x56>
80104298:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010429f:	90                   	nop

801042a0 <fork>:
801042a0:	55                   	push   %ebp
801042a1:	89 e5                	mov    %esp,%ebp
801042a3:	57                   	push   %edi
801042a4:	56                   	push   %esi
801042a5:	53                   	push   %ebx
801042a6:	83 ec 1c             	sub    $0x1c,%esp
801042a9:	e8 32 09 00 00       	call   80104be0 <pushcli>
801042ae:	e8 cd fd ff ff       	call   80104080 <mycpu>
801042b3:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
801042b9:	e8 72 09 00 00       	call   80104c30 <popcli>
801042be:	e8 7d fc ff ff       	call   80103f40 <allocproc>
801042c3:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801042c6:	85 c0                	test   %eax,%eax
801042c8:	0f 84 b7 00 00 00    	je     80104385 <fork+0xe5>
801042ce:	83 ec 08             	sub    $0x8,%esp
801042d1:	ff 33                	push   (%ebx)
801042d3:	89 c7                	mov    %eax,%edi
801042d5:	ff 73 04             	push   0x4(%ebx)
801042d8:	e8 e3 33 00 00       	call   801076c0 <copyuvm>
801042dd:	83 c4 10             	add    $0x10,%esp
801042e0:	89 47 04             	mov    %eax,0x4(%edi)
801042e3:	85 c0                	test   %eax,%eax
801042e5:	0f 84 a1 00 00 00    	je     8010438c <fork+0xec>
801042eb:	8b 03                	mov    (%ebx),%eax
801042ed:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801042f0:	89 01                	mov    %eax,(%ecx)
801042f2:	8b 79 18             	mov    0x18(%ecx),%edi
801042f5:	89 c8                	mov    %ecx,%eax
801042f7:	89 59 14             	mov    %ebx,0x14(%ecx)
801042fa:	b9 13 00 00 00       	mov    $0x13,%ecx
801042ff:	8b 73 18             	mov    0x18(%ebx),%esi
80104302:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
80104304:	31 f6                	xor    %esi,%esi
80104306:	8b 40 18             	mov    0x18(%eax),%eax
80104309:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
80104310:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
80104314:	85 c0                	test   %eax,%eax
80104316:	74 13                	je     8010432b <fork+0x8b>
80104318:	83 ec 0c             	sub    $0xc,%esp
8010431b:	50                   	push   %eax
8010431c:	e8 0f d3 ff ff       	call   80101630 <filedup>
80104321:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80104324:	83 c4 10             	add    $0x10,%esp
80104327:	89 44 b2 28          	mov    %eax,0x28(%edx,%esi,4)
8010432b:	83 c6 01             	add    $0x1,%esi
8010432e:	83 fe 10             	cmp    $0x10,%esi
80104331:	75 dd                	jne    80104310 <fork+0x70>
80104333:	83 ec 0c             	sub    $0xc,%esp
80104336:	ff 73 68             	push   0x68(%ebx)
80104339:	83 c3 6c             	add    $0x6c,%ebx
8010433c:	e8 9f db ff ff       	call   80101ee0 <idup>
80104341:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80104344:	83 c4 0c             	add    $0xc,%esp
80104347:	89 47 68             	mov    %eax,0x68(%edi)
8010434a:	8d 47 6c             	lea    0x6c(%edi),%eax
8010434d:	6a 10                	push   $0x10
8010434f:	53                   	push   %ebx
80104350:	50                   	push   %eax
80104351:	e8 5a 0c 00 00       	call   80104fb0 <safestrcpy>
80104356:	8b 5f 10             	mov    0x10(%edi),%ebx
80104359:	c7 04 24 60 39 11 80 	movl   $0x80113960,(%esp)
80104360:	e8 cb 09 00 00       	call   80104d30 <acquire>
80104365:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)
8010436c:	c7 04 24 60 39 11 80 	movl   $0x80113960,(%esp)
80104373:	e8 58 09 00 00       	call   80104cd0 <release>
80104378:	83 c4 10             	add    $0x10,%esp
8010437b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010437e:	89 d8                	mov    %ebx,%eax
80104380:	5b                   	pop    %ebx
80104381:	5e                   	pop    %esi
80104382:	5f                   	pop    %edi
80104383:	5d                   	pop    %ebp
80104384:	c3                   	ret    
80104385:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
8010438a:	eb ef                	jmp    8010437b <fork+0xdb>
8010438c:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
8010438f:	83 ec 0c             	sub    $0xc,%esp
80104392:	ff 73 08             	push   0x8(%ebx)
80104395:	e8 b6 e8 ff ff       	call   80102c50 <kfree>
8010439a:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
801043a1:	83 c4 10             	add    $0x10,%esp
801043a4:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
801043ab:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801043b0:	eb c9                	jmp    8010437b <fork+0xdb>
801043b2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801043b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801043c0 <scheduler>:
801043c0:	55                   	push   %ebp
801043c1:	89 e5                	mov    %esp,%ebp
801043c3:	57                   	push   %edi
801043c4:	56                   	push   %esi
801043c5:	53                   	push   %ebx
801043c6:	83 ec 0c             	sub    $0xc,%esp
801043c9:	e8 b2 fc ff ff       	call   80104080 <mycpu>
801043ce:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
801043d5:	00 00 00 
801043d8:	89 c6                	mov    %eax,%esi
801043da:	8d 78 04             	lea    0x4(%eax),%edi
801043dd:	8d 76 00             	lea    0x0(%esi),%esi
801043e0:	fb                   	sti    
801043e1:	83 ec 0c             	sub    $0xc,%esp
801043e4:	bb 94 39 11 80       	mov    $0x80113994,%ebx
801043e9:	68 60 39 11 80       	push   $0x80113960
801043ee:	e8 3d 09 00 00       	call   80104d30 <acquire>
801043f3:	83 c4 10             	add    $0x10,%esp
801043f6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801043fd:	8d 76 00             	lea    0x0(%esi),%esi
80104400:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
80104404:	75 33                	jne    80104439 <scheduler+0x79>
80104406:	83 ec 0c             	sub    $0xc,%esp
80104409:	89 9e ac 00 00 00    	mov    %ebx,0xac(%esi)
8010440f:	53                   	push   %ebx
80104410:	e8 5b 2d 00 00       	call   80107170 <switchuvm>
80104415:	58                   	pop    %eax
80104416:	5a                   	pop    %edx
80104417:	ff 73 1c             	push   0x1c(%ebx)
8010441a:	57                   	push   %edi
8010441b:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
80104422:	e8 e4 0b 00 00       	call   8010500b <swtch>
80104427:	e8 34 2d 00 00       	call   80107160 <switchkvm>
8010442c:	83 c4 10             	add    $0x10,%esp
8010442f:	c7 86 ac 00 00 00 00 	movl   $0x0,0xac(%esi)
80104436:	00 00 00 
80104439:	83 c3 7c             	add    $0x7c,%ebx
8010443c:	81 fb 94 58 11 80    	cmp    $0x80115894,%ebx
80104442:	75 bc                	jne    80104400 <scheduler+0x40>
80104444:	83 ec 0c             	sub    $0xc,%esp
80104447:	68 60 39 11 80       	push   $0x80113960
8010444c:	e8 7f 08 00 00       	call   80104cd0 <release>
80104451:	83 c4 10             	add    $0x10,%esp
80104454:	eb 8a                	jmp    801043e0 <scheduler+0x20>
80104456:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010445d:	8d 76 00             	lea    0x0(%esi),%esi

80104460 <sched>:
80104460:	55                   	push   %ebp
80104461:	89 e5                	mov    %esp,%ebp
80104463:	56                   	push   %esi
80104464:	53                   	push   %ebx
80104465:	e8 76 07 00 00       	call   80104be0 <pushcli>
8010446a:	e8 11 fc ff ff       	call   80104080 <mycpu>
8010446f:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
80104475:	e8 b6 07 00 00       	call   80104c30 <popcli>
8010447a:	83 ec 0c             	sub    $0xc,%esp
8010447d:	68 60 39 11 80       	push   $0x80113960
80104482:	e8 09 08 00 00       	call   80104c90 <holding>
80104487:	83 c4 10             	add    $0x10,%esp
8010448a:	85 c0                	test   %eax,%eax
8010448c:	74 4f                	je     801044dd <sched+0x7d>
8010448e:	e8 ed fb ff ff       	call   80104080 <mycpu>
80104493:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
8010449a:	75 68                	jne    80104504 <sched+0xa4>
8010449c:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
801044a0:	74 55                	je     801044f7 <sched+0x97>
801044a2:	9c                   	pushf  
801044a3:	58                   	pop    %eax
801044a4:	f6 c4 02             	test   $0x2,%ah
801044a7:	75 41                	jne    801044ea <sched+0x8a>
801044a9:	e8 d2 fb ff ff       	call   80104080 <mycpu>
801044ae:	83 c3 1c             	add    $0x1c,%ebx
801044b1:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
801044b7:	e8 c4 fb ff ff       	call   80104080 <mycpu>
801044bc:	83 ec 08             	sub    $0x8,%esp
801044bf:	ff 70 04             	push   0x4(%eax)
801044c2:	53                   	push   %ebx
801044c3:	e8 43 0b 00 00       	call   8010500b <swtch>
801044c8:	e8 b3 fb ff ff       	call   80104080 <mycpu>
801044cd:	83 c4 10             	add    $0x10,%esp
801044d0:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
801044d6:	8d 65 f8             	lea    -0x8(%ebp),%esp
801044d9:	5b                   	pop    %ebx
801044da:	5e                   	pop    %esi
801044db:	5d                   	pop    %ebp
801044dc:	c3                   	ret    
801044dd:	83 ec 0c             	sub    $0xc,%esp
801044e0:	68 fb 7e 10 80       	push   $0x80107efb
801044e5:	e8 b6 be ff ff       	call   801003a0 <panic>
801044ea:	83 ec 0c             	sub    $0xc,%esp
801044ed:	68 27 7f 10 80       	push   $0x80107f27
801044f2:	e8 a9 be ff ff       	call   801003a0 <panic>
801044f7:	83 ec 0c             	sub    $0xc,%esp
801044fa:	68 19 7f 10 80       	push   $0x80107f19
801044ff:	e8 9c be ff ff       	call   801003a0 <panic>
80104504:	83 ec 0c             	sub    $0xc,%esp
80104507:	68 0d 7f 10 80       	push   $0x80107f0d
8010450c:	e8 8f be ff ff       	call   801003a0 <panic>
80104511:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104518:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010451f:	90                   	nop

80104520 <exit>:
80104520:	55                   	push   %ebp
80104521:	89 e5                	mov    %esp,%ebp
80104523:	57                   	push   %edi
80104524:	56                   	push   %esi
80104525:	53                   	push   %ebx
80104526:	83 ec 0c             	sub    $0xc,%esp
80104529:	e8 d2 fb ff ff       	call   80104100 <myproc>
8010452e:	39 05 94 58 11 80    	cmp    %eax,0x80115894
80104534:	0f 84 fd 00 00 00    	je     80104637 <exit+0x117>
8010453a:	89 c3                	mov    %eax,%ebx
8010453c:	8d 70 28             	lea    0x28(%eax),%esi
8010453f:	8d 78 68             	lea    0x68(%eax),%edi
80104542:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104548:	8b 06                	mov    (%esi),%eax
8010454a:	85 c0                	test   %eax,%eax
8010454c:	74 12                	je     80104560 <exit+0x40>
8010454e:	83 ec 0c             	sub    $0xc,%esp
80104551:	50                   	push   %eax
80104552:	e8 29 d1 ff ff       	call   80101680 <fileclose>
80104557:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
8010455d:	83 c4 10             	add    $0x10,%esp
80104560:	83 c6 04             	add    $0x4,%esi
80104563:	39 f7                	cmp    %esi,%edi
80104565:	75 e1                	jne    80104548 <exit+0x28>
80104567:	e8 84 ef ff ff       	call   801034f0 <begin_op>
8010456c:	83 ec 0c             	sub    $0xc,%esp
8010456f:	ff 73 68             	push   0x68(%ebx)
80104572:	e8 c9 da ff ff       	call   80102040 <iput>
80104577:	e8 e4 ef ff ff       	call   80103560 <end_op>
8010457c:	c7 43 68 00 00 00 00 	movl   $0x0,0x68(%ebx)
80104583:	c7 04 24 60 39 11 80 	movl   $0x80113960,(%esp)
8010458a:	e8 a1 07 00 00       	call   80104d30 <acquire>
8010458f:	8b 53 14             	mov    0x14(%ebx),%edx
80104592:	83 c4 10             	add    $0x10,%esp
80104595:	b8 94 39 11 80       	mov    $0x80113994,%eax
8010459a:	eb 0e                	jmp    801045aa <exit+0x8a>
8010459c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801045a0:	83 c0 7c             	add    $0x7c,%eax
801045a3:	3d 94 58 11 80       	cmp    $0x80115894,%eax
801045a8:	74 1c                	je     801045c6 <exit+0xa6>
801045aa:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
801045ae:	75 f0                	jne    801045a0 <exit+0x80>
801045b0:	3b 50 20             	cmp    0x20(%eax),%edx
801045b3:	75 eb                	jne    801045a0 <exit+0x80>
801045b5:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
801045bc:	83 c0 7c             	add    $0x7c,%eax
801045bf:	3d 94 58 11 80       	cmp    $0x80115894,%eax
801045c4:	75 e4                	jne    801045aa <exit+0x8a>
801045c6:	8b 0d 94 58 11 80    	mov    0x80115894,%ecx
801045cc:	ba 94 39 11 80       	mov    $0x80113994,%edx
801045d1:	eb 10                	jmp    801045e3 <exit+0xc3>
801045d3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801045d7:	90                   	nop
801045d8:	83 c2 7c             	add    $0x7c,%edx
801045db:	81 fa 94 58 11 80    	cmp    $0x80115894,%edx
801045e1:	74 3b                	je     8010461e <exit+0xfe>
801045e3:	39 5a 14             	cmp    %ebx,0x14(%edx)
801045e6:	75 f0                	jne    801045d8 <exit+0xb8>
801045e8:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
801045ec:	89 4a 14             	mov    %ecx,0x14(%edx)
801045ef:	75 e7                	jne    801045d8 <exit+0xb8>
801045f1:	b8 94 39 11 80       	mov    $0x80113994,%eax
801045f6:	eb 12                	jmp    8010460a <exit+0xea>
801045f8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801045ff:	90                   	nop
80104600:	83 c0 7c             	add    $0x7c,%eax
80104603:	3d 94 58 11 80       	cmp    $0x80115894,%eax
80104608:	74 ce                	je     801045d8 <exit+0xb8>
8010460a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
8010460e:	75 f0                	jne    80104600 <exit+0xe0>
80104610:	3b 48 20             	cmp    0x20(%eax),%ecx
80104613:	75 eb                	jne    80104600 <exit+0xe0>
80104615:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
8010461c:	eb e2                	jmp    80104600 <exit+0xe0>
8010461e:	c7 43 0c 05 00 00 00 	movl   $0x5,0xc(%ebx)
80104625:	e8 36 fe ff ff       	call   80104460 <sched>
8010462a:	83 ec 0c             	sub    $0xc,%esp
8010462d:	68 48 7f 10 80       	push   $0x80107f48
80104632:	e8 69 bd ff ff       	call   801003a0 <panic>
80104637:	83 ec 0c             	sub    $0xc,%esp
8010463a:	68 3b 7f 10 80       	push   $0x80107f3b
8010463f:	e8 5c bd ff ff       	call   801003a0 <panic>
80104644:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010464b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010464f:	90                   	nop

80104650 <wait>:
80104650:	55                   	push   %ebp
80104651:	89 e5                	mov    %esp,%ebp
80104653:	56                   	push   %esi
80104654:	53                   	push   %ebx
80104655:	e8 86 05 00 00       	call   80104be0 <pushcli>
8010465a:	e8 21 fa ff ff       	call   80104080 <mycpu>
8010465f:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
80104665:	e8 c6 05 00 00       	call   80104c30 <popcli>
8010466a:	83 ec 0c             	sub    $0xc,%esp
8010466d:	68 60 39 11 80       	push   $0x80113960
80104672:	e8 b9 06 00 00       	call   80104d30 <acquire>
80104677:	83 c4 10             	add    $0x10,%esp
8010467a:	31 c0                	xor    %eax,%eax
8010467c:	bb 94 39 11 80       	mov    $0x80113994,%ebx
80104681:	eb 10                	jmp    80104693 <wait+0x43>
80104683:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104687:	90                   	nop
80104688:	83 c3 7c             	add    $0x7c,%ebx
8010468b:	81 fb 94 58 11 80    	cmp    $0x80115894,%ebx
80104691:	74 1b                	je     801046ae <wait+0x5e>
80104693:	39 73 14             	cmp    %esi,0x14(%ebx)
80104696:	75 f0                	jne    80104688 <wait+0x38>
80104698:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
8010469c:	74 62                	je     80104700 <wait+0xb0>
8010469e:	83 c3 7c             	add    $0x7c,%ebx
801046a1:	b8 01 00 00 00       	mov    $0x1,%eax
801046a6:	81 fb 94 58 11 80    	cmp    $0x80115894,%ebx
801046ac:	75 e5                	jne    80104693 <wait+0x43>
801046ae:	85 c0                	test   %eax,%eax
801046b0:	0f 84 a0 00 00 00    	je     80104756 <wait+0x106>
801046b6:	8b 46 24             	mov    0x24(%esi),%eax
801046b9:	85 c0                	test   %eax,%eax
801046bb:	0f 85 95 00 00 00    	jne    80104756 <wait+0x106>
801046c1:	e8 1a 05 00 00       	call   80104be0 <pushcli>
801046c6:	e8 b5 f9 ff ff       	call   80104080 <mycpu>
801046cb:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
801046d1:	e8 5a 05 00 00       	call   80104c30 <popcli>
801046d6:	85 db                	test   %ebx,%ebx
801046d8:	0f 84 8f 00 00 00    	je     8010476d <wait+0x11d>
801046de:	89 73 20             	mov    %esi,0x20(%ebx)
801046e1:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
801046e8:	e8 73 fd ff ff       	call   80104460 <sched>
801046ed:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
801046f4:	eb 84                	jmp    8010467a <wait+0x2a>
801046f6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801046fd:	8d 76 00             	lea    0x0(%esi),%esi
80104700:	83 ec 0c             	sub    $0xc,%esp
80104703:	8b 73 10             	mov    0x10(%ebx),%esi
80104706:	ff 73 08             	push   0x8(%ebx)
80104709:	e8 42 e5 ff ff       	call   80102c50 <kfree>
8010470e:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
80104715:	5a                   	pop    %edx
80104716:	ff 73 04             	push   0x4(%ebx)
80104719:	e8 32 2e 00 00       	call   80107550 <freevm>
8010471e:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
80104725:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
8010472c:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
80104730:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
80104737:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
8010473e:	c7 04 24 60 39 11 80 	movl   $0x80113960,(%esp)
80104745:	e8 86 05 00 00       	call   80104cd0 <release>
8010474a:	83 c4 10             	add    $0x10,%esp
8010474d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104750:	89 f0                	mov    %esi,%eax
80104752:	5b                   	pop    %ebx
80104753:	5e                   	pop    %esi
80104754:	5d                   	pop    %ebp
80104755:	c3                   	ret    
80104756:	83 ec 0c             	sub    $0xc,%esp
80104759:	be ff ff ff ff       	mov    $0xffffffff,%esi
8010475e:	68 60 39 11 80       	push   $0x80113960
80104763:	e8 68 05 00 00       	call   80104cd0 <release>
80104768:	83 c4 10             	add    $0x10,%esp
8010476b:	eb e0                	jmp    8010474d <wait+0xfd>
8010476d:	83 ec 0c             	sub    $0xc,%esp
80104770:	68 54 7f 10 80       	push   $0x80107f54
80104775:	e8 26 bc ff ff       	call   801003a0 <panic>
8010477a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104780 <yield>:
80104780:	55                   	push   %ebp
80104781:	89 e5                	mov    %esp,%ebp
80104783:	53                   	push   %ebx
80104784:	83 ec 10             	sub    $0x10,%esp
80104787:	68 60 39 11 80       	push   $0x80113960
8010478c:	e8 9f 05 00 00       	call   80104d30 <acquire>
80104791:	e8 4a 04 00 00       	call   80104be0 <pushcli>
80104796:	e8 e5 f8 ff ff       	call   80104080 <mycpu>
8010479b:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
801047a1:	e8 8a 04 00 00       	call   80104c30 <popcli>
801047a6:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
801047ad:	e8 ae fc ff ff       	call   80104460 <sched>
801047b2:	c7 04 24 60 39 11 80 	movl   $0x80113960,(%esp)
801047b9:	e8 12 05 00 00       	call   80104cd0 <release>
801047be:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801047c1:	83 c4 10             	add    $0x10,%esp
801047c4:	c9                   	leave  
801047c5:	c3                   	ret    
801047c6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801047cd:	8d 76 00             	lea    0x0(%esi),%esi

801047d0 <sleep>:
801047d0:	55                   	push   %ebp
801047d1:	89 e5                	mov    %esp,%ebp
801047d3:	57                   	push   %edi
801047d4:	56                   	push   %esi
801047d5:	53                   	push   %ebx
801047d6:	83 ec 0c             	sub    $0xc,%esp
801047d9:	8b 7d 08             	mov    0x8(%ebp),%edi
801047dc:	8b 75 0c             	mov    0xc(%ebp),%esi
801047df:	e8 fc 03 00 00       	call   80104be0 <pushcli>
801047e4:	e8 97 f8 ff ff       	call   80104080 <mycpu>
801047e9:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
801047ef:	e8 3c 04 00 00       	call   80104c30 <popcli>
801047f4:	85 db                	test   %ebx,%ebx
801047f6:	0f 84 87 00 00 00    	je     80104883 <sleep+0xb3>
801047fc:	85 f6                	test   %esi,%esi
801047fe:	74 76                	je     80104876 <sleep+0xa6>
80104800:	81 fe 60 39 11 80    	cmp    $0x80113960,%esi
80104806:	74 50                	je     80104858 <sleep+0x88>
80104808:	83 ec 0c             	sub    $0xc,%esp
8010480b:	68 60 39 11 80       	push   $0x80113960
80104810:	e8 1b 05 00 00       	call   80104d30 <acquire>
80104815:	89 34 24             	mov    %esi,(%esp)
80104818:	e8 b3 04 00 00       	call   80104cd0 <release>
8010481d:	89 7b 20             	mov    %edi,0x20(%ebx)
80104820:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
80104827:	e8 34 fc ff ff       	call   80104460 <sched>
8010482c:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
80104833:	c7 04 24 60 39 11 80 	movl   $0x80113960,(%esp)
8010483a:	e8 91 04 00 00       	call   80104cd0 <release>
8010483f:	89 75 08             	mov    %esi,0x8(%ebp)
80104842:	83 c4 10             	add    $0x10,%esp
80104845:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104848:	5b                   	pop    %ebx
80104849:	5e                   	pop    %esi
8010484a:	5f                   	pop    %edi
8010484b:	5d                   	pop    %ebp
8010484c:	e9 df 04 00 00       	jmp    80104d30 <acquire>
80104851:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104858:	89 7b 20             	mov    %edi,0x20(%ebx)
8010485b:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
80104862:	e8 f9 fb ff ff       	call   80104460 <sched>
80104867:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
8010486e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104871:	5b                   	pop    %ebx
80104872:	5e                   	pop    %esi
80104873:	5f                   	pop    %edi
80104874:	5d                   	pop    %ebp
80104875:	c3                   	ret    
80104876:	83 ec 0c             	sub    $0xc,%esp
80104879:	68 5a 7f 10 80       	push   $0x80107f5a
8010487e:	e8 1d bb ff ff       	call   801003a0 <panic>
80104883:	83 ec 0c             	sub    $0xc,%esp
80104886:	68 54 7f 10 80       	push   $0x80107f54
8010488b:	e8 10 bb ff ff       	call   801003a0 <panic>

80104890 <wakeup>:
80104890:	55                   	push   %ebp
80104891:	89 e5                	mov    %esp,%ebp
80104893:	53                   	push   %ebx
80104894:	83 ec 10             	sub    $0x10,%esp
80104897:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010489a:	68 60 39 11 80       	push   $0x80113960
8010489f:	e8 8c 04 00 00       	call   80104d30 <acquire>
801048a4:	83 c4 10             	add    $0x10,%esp
801048a7:	b8 94 39 11 80       	mov    $0x80113994,%eax
801048ac:	eb 0c                	jmp    801048ba <wakeup+0x2a>
801048ae:	66 90                	xchg   %ax,%ax
801048b0:	83 c0 7c             	add    $0x7c,%eax
801048b3:	3d 94 58 11 80       	cmp    $0x80115894,%eax
801048b8:	74 1c                	je     801048d6 <wakeup+0x46>
801048ba:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
801048be:	75 f0                	jne    801048b0 <wakeup+0x20>
801048c0:	3b 58 20             	cmp    0x20(%eax),%ebx
801048c3:	75 eb                	jne    801048b0 <wakeup+0x20>
801048c5:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
801048cc:	83 c0 7c             	add    $0x7c,%eax
801048cf:	3d 94 58 11 80       	cmp    $0x80115894,%eax
801048d4:	75 e4                	jne    801048ba <wakeup+0x2a>
801048d6:	c7 45 08 60 39 11 80 	movl   $0x80113960,0x8(%ebp)
801048dd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801048e0:	c9                   	leave  
801048e1:	e9 ea 03 00 00       	jmp    80104cd0 <release>
801048e6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801048ed:	8d 76 00             	lea    0x0(%esi),%esi

801048f0 <kill>:
801048f0:	55                   	push   %ebp
801048f1:	89 e5                	mov    %esp,%ebp
801048f3:	53                   	push   %ebx
801048f4:	83 ec 10             	sub    $0x10,%esp
801048f7:	8b 5d 08             	mov    0x8(%ebp),%ebx
801048fa:	68 60 39 11 80       	push   $0x80113960
801048ff:	e8 2c 04 00 00       	call   80104d30 <acquire>
80104904:	83 c4 10             	add    $0x10,%esp
80104907:	b8 94 39 11 80       	mov    $0x80113994,%eax
8010490c:	eb 0c                	jmp    8010491a <kill+0x2a>
8010490e:	66 90                	xchg   %ax,%ax
80104910:	83 c0 7c             	add    $0x7c,%eax
80104913:	3d 94 58 11 80       	cmp    $0x80115894,%eax
80104918:	74 36                	je     80104950 <kill+0x60>
8010491a:	39 58 10             	cmp    %ebx,0x10(%eax)
8010491d:	75 f1                	jne    80104910 <kill+0x20>
8010491f:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104923:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
8010492a:	75 07                	jne    80104933 <kill+0x43>
8010492c:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80104933:	83 ec 0c             	sub    $0xc,%esp
80104936:	68 60 39 11 80       	push   $0x80113960
8010493b:	e8 90 03 00 00       	call   80104cd0 <release>
80104940:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104943:	83 c4 10             	add    $0x10,%esp
80104946:	31 c0                	xor    %eax,%eax
80104948:	c9                   	leave  
80104949:	c3                   	ret    
8010494a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104950:	83 ec 0c             	sub    $0xc,%esp
80104953:	68 60 39 11 80       	push   $0x80113960
80104958:	e8 73 03 00 00       	call   80104cd0 <release>
8010495d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104960:	83 c4 10             	add    $0x10,%esp
80104963:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104968:	c9                   	leave  
80104969:	c3                   	ret    
8010496a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104970 <procdump>:
80104970:	55                   	push   %ebp
80104971:	89 e5                	mov    %esp,%ebp
80104973:	57                   	push   %edi
80104974:	56                   	push   %esi
80104975:	8d 75 e8             	lea    -0x18(%ebp),%esi
80104978:	53                   	push   %ebx
80104979:	bb 00 3a 11 80       	mov    $0x80113a00,%ebx
8010497e:	83 ec 3c             	sub    $0x3c,%esp
80104981:	eb 24                	jmp    801049a7 <procdump+0x37>
80104983:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104987:	90                   	nop
80104988:	83 ec 0c             	sub    $0xc,%esp
8010498b:	68 d7 82 10 80       	push   $0x801082d7
80104990:	e8 bb bd ff ff       	call   80100750 <cprintf>
80104995:	83 c4 10             	add    $0x10,%esp
80104998:	83 c3 7c             	add    $0x7c,%ebx
8010499b:	81 fb 00 59 11 80    	cmp    $0x80115900,%ebx
801049a1:	0f 84 81 00 00 00    	je     80104a28 <procdump+0xb8>
801049a7:	8b 43 a0             	mov    -0x60(%ebx),%eax
801049aa:	85 c0                	test   %eax,%eax
801049ac:	74 ea                	je     80104998 <procdump+0x28>
801049ae:	ba 6b 7f 10 80       	mov    $0x80107f6b,%edx
801049b3:	83 f8 05             	cmp    $0x5,%eax
801049b6:	77 11                	ja     801049c9 <procdump+0x59>
801049b8:	8b 14 85 cc 7f 10 80 	mov    -0x7fef8034(,%eax,4),%edx
801049bf:	b8 6b 7f 10 80       	mov    $0x80107f6b,%eax
801049c4:	85 d2                	test   %edx,%edx
801049c6:	0f 44 d0             	cmove  %eax,%edx
801049c9:	53                   	push   %ebx
801049ca:	52                   	push   %edx
801049cb:	ff 73 a4             	push   -0x5c(%ebx)
801049ce:	68 6f 7f 10 80       	push   $0x80107f6f
801049d3:	e8 78 bd ff ff       	call   80100750 <cprintf>
801049d8:	83 c4 10             	add    $0x10,%esp
801049db:	83 7b a0 02          	cmpl   $0x2,-0x60(%ebx)
801049df:	75 a7                	jne    80104988 <procdump+0x18>
801049e1:	83 ec 08             	sub    $0x8,%esp
801049e4:	8d 45 c0             	lea    -0x40(%ebp),%eax
801049e7:	8d 7d c0             	lea    -0x40(%ebp),%edi
801049ea:	50                   	push   %eax
801049eb:	8b 43 b0             	mov    -0x50(%ebx),%eax
801049ee:	8b 40 0c             	mov    0xc(%eax),%eax
801049f1:	83 c0 08             	add    $0x8,%eax
801049f4:	50                   	push   %eax
801049f5:	e8 86 01 00 00       	call   80104b80 <getcallerpcs>
801049fa:	83 c4 10             	add    $0x10,%esp
801049fd:	8d 76 00             	lea    0x0(%esi),%esi
80104a00:	8b 17                	mov    (%edi),%edx
80104a02:	85 d2                	test   %edx,%edx
80104a04:	74 82                	je     80104988 <procdump+0x18>
80104a06:	83 ec 08             	sub    $0x8,%esp
80104a09:	83 c7 04             	add    $0x4,%edi
80104a0c:	52                   	push   %edx
80104a0d:	68 61 79 10 80       	push   $0x80107961
80104a12:	e8 39 bd ff ff       	call   80100750 <cprintf>
80104a17:	83 c4 10             	add    $0x10,%esp
80104a1a:	39 fe                	cmp    %edi,%esi
80104a1c:	75 e2                	jne    80104a00 <procdump+0x90>
80104a1e:	e9 65 ff ff ff       	jmp    80104988 <procdump+0x18>
80104a23:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104a27:	90                   	nop
80104a28:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104a2b:	5b                   	pop    %ebx
80104a2c:	5e                   	pop    %esi
80104a2d:	5f                   	pop    %edi
80104a2e:	5d                   	pop    %ebp
80104a2f:	c3                   	ret    

80104a30 <initsleeplock>:
80104a30:	55                   	push   %ebp
80104a31:	89 e5                	mov    %esp,%ebp
80104a33:	53                   	push   %ebx
80104a34:	83 ec 0c             	sub    $0xc,%esp
80104a37:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104a3a:	68 e4 7f 10 80       	push   $0x80107fe4
80104a3f:	8d 43 04             	lea    0x4(%ebx),%eax
80104a42:	50                   	push   %eax
80104a43:	e8 18 01 00 00       	call   80104b60 <initlock>
80104a48:	8b 45 0c             	mov    0xc(%ebp),%eax
80104a4b:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80104a51:	83 c4 10             	add    $0x10,%esp
80104a54:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
80104a5b:	89 43 38             	mov    %eax,0x38(%ebx)
80104a5e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104a61:	c9                   	leave  
80104a62:	c3                   	ret    
80104a63:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104a6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104a70 <acquiresleep>:
80104a70:	55                   	push   %ebp
80104a71:	89 e5                	mov    %esp,%ebp
80104a73:	56                   	push   %esi
80104a74:	53                   	push   %ebx
80104a75:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104a78:	8d 73 04             	lea    0x4(%ebx),%esi
80104a7b:	83 ec 0c             	sub    $0xc,%esp
80104a7e:	56                   	push   %esi
80104a7f:	e8 ac 02 00 00       	call   80104d30 <acquire>
80104a84:	8b 13                	mov    (%ebx),%edx
80104a86:	83 c4 10             	add    $0x10,%esp
80104a89:	85 d2                	test   %edx,%edx
80104a8b:	74 16                	je     80104aa3 <acquiresleep+0x33>
80104a8d:	8d 76 00             	lea    0x0(%esi),%esi
80104a90:	83 ec 08             	sub    $0x8,%esp
80104a93:	56                   	push   %esi
80104a94:	53                   	push   %ebx
80104a95:	e8 36 fd ff ff       	call   801047d0 <sleep>
80104a9a:	8b 03                	mov    (%ebx),%eax
80104a9c:	83 c4 10             	add    $0x10,%esp
80104a9f:	85 c0                	test   %eax,%eax
80104aa1:	75 ed                	jne    80104a90 <acquiresleep+0x20>
80104aa3:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
80104aa9:	e8 52 f6 ff ff       	call   80104100 <myproc>
80104aae:	8b 40 10             	mov    0x10(%eax),%eax
80104ab1:	89 43 3c             	mov    %eax,0x3c(%ebx)
80104ab4:	89 75 08             	mov    %esi,0x8(%ebp)
80104ab7:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104aba:	5b                   	pop    %ebx
80104abb:	5e                   	pop    %esi
80104abc:	5d                   	pop    %ebp
80104abd:	e9 0e 02 00 00       	jmp    80104cd0 <release>
80104ac2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104ac9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104ad0 <releasesleep>:
80104ad0:	55                   	push   %ebp
80104ad1:	89 e5                	mov    %esp,%ebp
80104ad3:	56                   	push   %esi
80104ad4:	53                   	push   %ebx
80104ad5:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104ad8:	8d 73 04             	lea    0x4(%ebx),%esi
80104adb:	83 ec 0c             	sub    $0xc,%esp
80104ade:	56                   	push   %esi
80104adf:	e8 4c 02 00 00       	call   80104d30 <acquire>
80104ae4:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80104aea:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
80104af1:	89 1c 24             	mov    %ebx,(%esp)
80104af4:	e8 97 fd ff ff       	call   80104890 <wakeup>
80104af9:	89 75 08             	mov    %esi,0x8(%ebp)
80104afc:	83 c4 10             	add    $0x10,%esp
80104aff:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104b02:	5b                   	pop    %ebx
80104b03:	5e                   	pop    %esi
80104b04:	5d                   	pop    %ebp
80104b05:	e9 c6 01 00 00       	jmp    80104cd0 <release>
80104b0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104b10 <holdingsleep>:
80104b10:	55                   	push   %ebp
80104b11:	89 e5                	mov    %esp,%ebp
80104b13:	57                   	push   %edi
80104b14:	31 ff                	xor    %edi,%edi
80104b16:	56                   	push   %esi
80104b17:	53                   	push   %ebx
80104b18:	83 ec 18             	sub    $0x18,%esp
80104b1b:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104b1e:	8d 73 04             	lea    0x4(%ebx),%esi
80104b21:	56                   	push   %esi
80104b22:	e8 09 02 00 00       	call   80104d30 <acquire>
80104b27:	8b 03                	mov    (%ebx),%eax
80104b29:	83 c4 10             	add    $0x10,%esp
80104b2c:	85 c0                	test   %eax,%eax
80104b2e:	75 18                	jne    80104b48 <holdingsleep+0x38>
80104b30:	83 ec 0c             	sub    $0xc,%esp
80104b33:	56                   	push   %esi
80104b34:	e8 97 01 00 00       	call   80104cd0 <release>
80104b39:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104b3c:	89 f8                	mov    %edi,%eax
80104b3e:	5b                   	pop    %ebx
80104b3f:	5e                   	pop    %esi
80104b40:	5f                   	pop    %edi
80104b41:	5d                   	pop    %ebp
80104b42:	c3                   	ret    
80104b43:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104b47:	90                   	nop
80104b48:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
80104b4b:	e8 b0 f5 ff ff       	call   80104100 <myproc>
80104b50:	39 58 10             	cmp    %ebx,0x10(%eax)
80104b53:	0f 94 c0             	sete   %al
80104b56:	0f b6 c0             	movzbl %al,%eax
80104b59:	89 c7                	mov    %eax,%edi
80104b5b:	eb d3                	jmp    80104b30 <holdingsleep+0x20>
80104b5d:	66 90                	xchg   %ax,%ax
80104b5f:	90                   	nop

80104b60 <initlock>:
80104b60:	55                   	push   %ebp
80104b61:	89 e5                	mov    %esp,%ebp
80104b63:	8b 45 08             	mov    0x8(%ebp),%eax
80104b66:	8b 55 0c             	mov    0xc(%ebp),%edx
80104b69:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80104b6f:	89 50 04             	mov    %edx,0x4(%eax)
80104b72:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
80104b79:	5d                   	pop    %ebp
80104b7a:	c3                   	ret    
80104b7b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104b7f:	90                   	nop

80104b80 <getcallerpcs>:
80104b80:	55                   	push   %ebp
80104b81:	31 d2                	xor    %edx,%edx
80104b83:	89 e5                	mov    %esp,%ebp
80104b85:	53                   	push   %ebx
80104b86:	8b 45 08             	mov    0x8(%ebp),%eax
80104b89:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80104b8c:	83 e8 08             	sub    $0x8,%eax
80104b8f:	90                   	nop
80104b90:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
80104b96:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
80104b9c:	77 1a                	ja     80104bb8 <getcallerpcs+0x38>
80104b9e:	8b 58 04             	mov    0x4(%eax),%ebx
80104ba1:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
80104ba4:	83 c2 01             	add    $0x1,%edx
80104ba7:	8b 00                	mov    (%eax),%eax
80104ba9:	83 fa 0a             	cmp    $0xa,%edx
80104bac:	75 e2                	jne    80104b90 <getcallerpcs+0x10>
80104bae:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104bb1:	c9                   	leave  
80104bb2:	c3                   	ret    
80104bb3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104bb7:	90                   	nop
80104bb8:	8d 04 91             	lea    (%ecx,%edx,4),%eax
80104bbb:	8d 51 28             	lea    0x28(%ecx),%edx
80104bbe:	66 90                	xchg   %ax,%ax
80104bc0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80104bc6:	83 c0 04             	add    $0x4,%eax
80104bc9:	39 d0                	cmp    %edx,%eax
80104bcb:	75 f3                	jne    80104bc0 <getcallerpcs+0x40>
80104bcd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104bd0:	c9                   	leave  
80104bd1:	c3                   	ret    
80104bd2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104bd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104be0 <pushcli>:
80104be0:	55                   	push   %ebp
80104be1:	89 e5                	mov    %esp,%ebp
80104be3:	53                   	push   %ebx
80104be4:	83 ec 04             	sub    $0x4,%esp
80104be7:	9c                   	pushf  
80104be8:	5b                   	pop    %ebx
80104be9:	fa                   	cli    
80104bea:	e8 91 f4 ff ff       	call   80104080 <mycpu>
80104bef:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
80104bf5:	85 c0                	test   %eax,%eax
80104bf7:	74 17                	je     80104c10 <pushcli+0x30>
80104bf9:	e8 82 f4 ff ff       	call   80104080 <mycpu>
80104bfe:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
80104c05:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104c08:	c9                   	leave  
80104c09:	c3                   	ret    
80104c0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104c10:	e8 6b f4 ff ff       	call   80104080 <mycpu>
80104c15:	81 e3 00 02 00 00    	and    $0x200,%ebx
80104c1b:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
80104c21:	eb d6                	jmp    80104bf9 <pushcli+0x19>
80104c23:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104c2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104c30 <popcli>:
80104c30:	55                   	push   %ebp
80104c31:	89 e5                	mov    %esp,%ebp
80104c33:	83 ec 08             	sub    $0x8,%esp
80104c36:	9c                   	pushf  
80104c37:	58                   	pop    %eax
80104c38:	f6 c4 02             	test   $0x2,%ah
80104c3b:	75 35                	jne    80104c72 <popcli+0x42>
80104c3d:	e8 3e f4 ff ff       	call   80104080 <mycpu>
80104c42:	83 a8 a4 00 00 00 01 	subl   $0x1,0xa4(%eax)
80104c49:	78 34                	js     80104c7f <popcli+0x4f>
80104c4b:	e8 30 f4 ff ff       	call   80104080 <mycpu>
80104c50:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80104c56:	85 d2                	test   %edx,%edx
80104c58:	74 06                	je     80104c60 <popcli+0x30>
80104c5a:	c9                   	leave  
80104c5b:	c3                   	ret    
80104c5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104c60:	e8 1b f4 ff ff       	call   80104080 <mycpu>
80104c65:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
80104c6b:	85 c0                	test   %eax,%eax
80104c6d:	74 eb                	je     80104c5a <popcli+0x2a>
80104c6f:	fb                   	sti    
80104c70:	c9                   	leave  
80104c71:	c3                   	ret    
80104c72:	83 ec 0c             	sub    $0xc,%esp
80104c75:	68 ef 7f 10 80       	push   $0x80107fef
80104c7a:	e8 21 b7 ff ff       	call   801003a0 <panic>
80104c7f:	83 ec 0c             	sub    $0xc,%esp
80104c82:	68 06 80 10 80       	push   $0x80108006
80104c87:	e8 14 b7 ff ff       	call   801003a0 <panic>
80104c8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104c90 <holding>:
80104c90:	55                   	push   %ebp
80104c91:	89 e5                	mov    %esp,%ebp
80104c93:	56                   	push   %esi
80104c94:	53                   	push   %ebx
80104c95:	8b 75 08             	mov    0x8(%ebp),%esi
80104c98:	31 db                	xor    %ebx,%ebx
80104c9a:	e8 41 ff ff ff       	call   80104be0 <pushcli>
80104c9f:	8b 06                	mov    (%esi),%eax
80104ca1:	85 c0                	test   %eax,%eax
80104ca3:	75 0b                	jne    80104cb0 <holding+0x20>
80104ca5:	e8 86 ff ff ff       	call   80104c30 <popcli>
80104caa:	89 d8                	mov    %ebx,%eax
80104cac:	5b                   	pop    %ebx
80104cad:	5e                   	pop    %esi
80104cae:	5d                   	pop    %ebp
80104caf:	c3                   	ret    
80104cb0:	8b 5e 08             	mov    0x8(%esi),%ebx
80104cb3:	e8 c8 f3 ff ff       	call   80104080 <mycpu>
80104cb8:	39 c3                	cmp    %eax,%ebx
80104cba:	0f 94 c3             	sete   %bl
80104cbd:	e8 6e ff ff ff       	call   80104c30 <popcli>
80104cc2:	0f b6 db             	movzbl %bl,%ebx
80104cc5:	89 d8                	mov    %ebx,%eax
80104cc7:	5b                   	pop    %ebx
80104cc8:	5e                   	pop    %esi
80104cc9:	5d                   	pop    %ebp
80104cca:	c3                   	ret    
80104ccb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104ccf:	90                   	nop

80104cd0 <release>:
80104cd0:	55                   	push   %ebp
80104cd1:	89 e5                	mov    %esp,%ebp
80104cd3:	56                   	push   %esi
80104cd4:	53                   	push   %ebx
80104cd5:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104cd8:	e8 03 ff ff ff       	call   80104be0 <pushcli>
80104cdd:	8b 03                	mov    (%ebx),%eax
80104cdf:	85 c0                	test   %eax,%eax
80104ce1:	75 15                	jne    80104cf8 <release+0x28>
80104ce3:	e8 48 ff ff ff       	call   80104c30 <popcli>
80104ce8:	83 ec 0c             	sub    $0xc,%esp
80104ceb:	68 0d 80 10 80       	push   $0x8010800d
80104cf0:	e8 ab b6 ff ff       	call   801003a0 <panic>
80104cf5:	8d 76 00             	lea    0x0(%esi),%esi
80104cf8:	8b 73 08             	mov    0x8(%ebx),%esi
80104cfb:	e8 80 f3 ff ff       	call   80104080 <mycpu>
80104d00:	39 c6                	cmp    %eax,%esi
80104d02:	75 df                	jne    80104ce3 <release+0x13>
80104d04:	e8 27 ff ff ff       	call   80104c30 <popcli>
80104d09:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
80104d10:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
80104d17:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
80104d1c:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80104d22:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104d25:	5b                   	pop    %ebx
80104d26:	5e                   	pop    %esi
80104d27:	5d                   	pop    %ebp
80104d28:	e9 03 ff ff ff       	jmp    80104c30 <popcli>
80104d2d:	8d 76 00             	lea    0x0(%esi),%esi

80104d30 <acquire>:
80104d30:	55                   	push   %ebp
80104d31:	89 e5                	mov    %esp,%ebp
80104d33:	53                   	push   %ebx
80104d34:	83 ec 04             	sub    $0x4,%esp
80104d37:	e8 a4 fe ff ff       	call   80104be0 <pushcli>
80104d3c:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104d3f:	e8 9c fe ff ff       	call   80104be0 <pushcli>
80104d44:	8b 03                	mov    (%ebx),%eax
80104d46:	85 c0                	test   %eax,%eax
80104d48:	75 7e                	jne    80104dc8 <acquire+0x98>
80104d4a:	e8 e1 fe ff ff       	call   80104c30 <popcli>
80104d4f:	b9 01 00 00 00       	mov    $0x1,%ecx
80104d54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104d58:	8b 55 08             	mov    0x8(%ebp),%edx
80104d5b:	89 c8                	mov    %ecx,%eax
80104d5d:	f0 87 02             	lock xchg %eax,(%edx)
80104d60:	85 c0                	test   %eax,%eax
80104d62:	75 f4                	jne    80104d58 <acquire+0x28>
80104d64:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
80104d69:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104d6c:	e8 0f f3 ff ff       	call   80104080 <mycpu>
80104d71:	8b 4d 08             	mov    0x8(%ebp),%ecx
80104d74:	89 ea                	mov    %ebp,%edx
80104d76:	89 43 08             	mov    %eax,0x8(%ebx)
80104d79:	31 c0                	xor    %eax,%eax
80104d7b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104d7f:	90                   	nop
80104d80:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
80104d86:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
80104d8c:	77 1a                	ja     80104da8 <acquire+0x78>
80104d8e:	8b 5a 04             	mov    0x4(%edx),%ebx
80104d91:	89 5c 81 0c          	mov    %ebx,0xc(%ecx,%eax,4)
80104d95:	83 c0 01             	add    $0x1,%eax
80104d98:	8b 12                	mov    (%edx),%edx
80104d9a:	83 f8 0a             	cmp    $0xa,%eax
80104d9d:	75 e1                	jne    80104d80 <acquire+0x50>
80104d9f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104da2:	c9                   	leave  
80104da3:	c3                   	ret    
80104da4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104da8:	8d 44 81 0c          	lea    0xc(%ecx,%eax,4),%eax
80104dac:	8d 51 34             	lea    0x34(%ecx),%edx
80104daf:	90                   	nop
80104db0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80104db6:	83 c0 04             	add    $0x4,%eax
80104db9:	39 c2                	cmp    %eax,%edx
80104dbb:	75 f3                	jne    80104db0 <acquire+0x80>
80104dbd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104dc0:	c9                   	leave  
80104dc1:	c3                   	ret    
80104dc2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104dc8:	8b 5b 08             	mov    0x8(%ebx),%ebx
80104dcb:	e8 b0 f2 ff ff       	call   80104080 <mycpu>
80104dd0:	39 c3                	cmp    %eax,%ebx
80104dd2:	0f 85 72 ff ff ff    	jne    80104d4a <acquire+0x1a>
80104dd8:	e8 53 fe ff ff       	call   80104c30 <popcli>
80104ddd:	83 ec 0c             	sub    $0xc,%esp
80104de0:	68 15 80 10 80       	push   $0x80108015
80104de5:	e8 b6 b5 ff ff       	call   801003a0 <panic>
80104dea:	66 90                	xchg   %ax,%ax
80104dec:	66 90                	xchg   %ax,%ax
80104dee:	66 90                	xchg   %ax,%ax

80104df0 <memset>:
80104df0:	55                   	push   %ebp
80104df1:	89 e5                	mov    %esp,%ebp
80104df3:	57                   	push   %edi
80104df4:	8b 55 08             	mov    0x8(%ebp),%edx
80104df7:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104dfa:	53                   	push   %ebx
80104dfb:	8b 45 0c             	mov    0xc(%ebp),%eax
80104dfe:	89 d7                	mov    %edx,%edi
80104e00:	09 cf                	or     %ecx,%edi
80104e02:	83 e7 03             	and    $0x3,%edi
80104e05:	75 29                	jne    80104e30 <memset+0x40>
80104e07:	0f b6 f8             	movzbl %al,%edi
80104e0a:	c1 e0 18             	shl    $0x18,%eax
80104e0d:	89 fb                	mov    %edi,%ebx
80104e0f:	c1 e9 02             	shr    $0x2,%ecx
80104e12:	c1 e3 10             	shl    $0x10,%ebx
80104e15:	09 d8                	or     %ebx,%eax
80104e17:	09 f8                	or     %edi,%eax
80104e19:	c1 e7 08             	shl    $0x8,%edi
80104e1c:	09 f8                	or     %edi,%eax
80104e1e:	89 d7                	mov    %edx,%edi
80104e20:	fc                   	cld    
80104e21:	f3 ab                	rep stos %eax,%es:(%edi)
80104e23:	5b                   	pop    %ebx
80104e24:	89 d0                	mov    %edx,%eax
80104e26:	5f                   	pop    %edi
80104e27:	5d                   	pop    %ebp
80104e28:	c3                   	ret    
80104e29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104e30:	89 d7                	mov    %edx,%edi
80104e32:	fc                   	cld    
80104e33:	f3 aa                	rep stos %al,%es:(%edi)
80104e35:	5b                   	pop    %ebx
80104e36:	89 d0                	mov    %edx,%eax
80104e38:	5f                   	pop    %edi
80104e39:	5d                   	pop    %ebp
80104e3a:	c3                   	ret    
80104e3b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104e3f:	90                   	nop

80104e40 <memcmp>:
80104e40:	55                   	push   %ebp
80104e41:	89 e5                	mov    %esp,%ebp
80104e43:	56                   	push   %esi
80104e44:	8b 75 10             	mov    0x10(%ebp),%esi
80104e47:	8b 55 08             	mov    0x8(%ebp),%edx
80104e4a:	53                   	push   %ebx
80104e4b:	8b 45 0c             	mov    0xc(%ebp),%eax
80104e4e:	85 f6                	test   %esi,%esi
80104e50:	74 2e                	je     80104e80 <memcmp+0x40>
80104e52:	01 c6                	add    %eax,%esi
80104e54:	eb 14                	jmp    80104e6a <memcmp+0x2a>
80104e56:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104e5d:	8d 76 00             	lea    0x0(%esi),%esi
80104e60:	83 c0 01             	add    $0x1,%eax
80104e63:	83 c2 01             	add    $0x1,%edx
80104e66:	39 f0                	cmp    %esi,%eax
80104e68:	74 16                	je     80104e80 <memcmp+0x40>
80104e6a:	0f b6 0a             	movzbl (%edx),%ecx
80104e6d:	0f b6 18             	movzbl (%eax),%ebx
80104e70:	38 d9                	cmp    %bl,%cl
80104e72:	74 ec                	je     80104e60 <memcmp+0x20>
80104e74:	0f b6 c1             	movzbl %cl,%eax
80104e77:	29 d8                	sub    %ebx,%eax
80104e79:	5b                   	pop    %ebx
80104e7a:	5e                   	pop    %esi
80104e7b:	5d                   	pop    %ebp
80104e7c:	c3                   	ret    
80104e7d:	8d 76 00             	lea    0x0(%esi),%esi
80104e80:	5b                   	pop    %ebx
80104e81:	31 c0                	xor    %eax,%eax
80104e83:	5e                   	pop    %esi
80104e84:	5d                   	pop    %ebp
80104e85:	c3                   	ret    
80104e86:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104e8d:	8d 76 00             	lea    0x0(%esi),%esi

80104e90 <memmove>:
80104e90:	55                   	push   %ebp
80104e91:	89 e5                	mov    %esp,%ebp
80104e93:	57                   	push   %edi
80104e94:	8b 55 08             	mov    0x8(%ebp),%edx
80104e97:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104e9a:	56                   	push   %esi
80104e9b:	8b 75 0c             	mov    0xc(%ebp),%esi
80104e9e:	39 d6                	cmp    %edx,%esi
80104ea0:	73 26                	jae    80104ec8 <memmove+0x38>
80104ea2:	8d 3c 0e             	lea    (%esi,%ecx,1),%edi
80104ea5:	39 fa                	cmp    %edi,%edx
80104ea7:	73 1f                	jae    80104ec8 <memmove+0x38>
80104ea9:	8d 41 ff             	lea    -0x1(%ecx),%eax
80104eac:	85 c9                	test   %ecx,%ecx
80104eae:	74 0c                	je     80104ebc <memmove+0x2c>
80104eb0:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
80104eb4:	88 0c 02             	mov    %cl,(%edx,%eax,1)
80104eb7:	83 e8 01             	sub    $0x1,%eax
80104eba:	73 f4                	jae    80104eb0 <memmove+0x20>
80104ebc:	5e                   	pop    %esi
80104ebd:	89 d0                	mov    %edx,%eax
80104ebf:	5f                   	pop    %edi
80104ec0:	5d                   	pop    %ebp
80104ec1:	c3                   	ret    
80104ec2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104ec8:	8d 04 0e             	lea    (%esi,%ecx,1),%eax
80104ecb:	89 d7                	mov    %edx,%edi
80104ecd:	85 c9                	test   %ecx,%ecx
80104ecf:	74 eb                	je     80104ebc <memmove+0x2c>
80104ed1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104ed8:	a4                   	movsb  %ds:(%esi),%es:(%edi)
80104ed9:	39 c6                	cmp    %eax,%esi
80104edb:	75 fb                	jne    80104ed8 <memmove+0x48>
80104edd:	5e                   	pop    %esi
80104ede:	89 d0                	mov    %edx,%eax
80104ee0:	5f                   	pop    %edi
80104ee1:	5d                   	pop    %ebp
80104ee2:	c3                   	ret    
80104ee3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104eea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104ef0 <memcpy>:
80104ef0:	eb 9e                	jmp    80104e90 <memmove>
80104ef2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104ef9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104f00 <strncmp>:
80104f00:	55                   	push   %ebp
80104f01:	89 e5                	mov    %esp,%ebp
80104f03:	56                   	push   %esi
80104f04:	8b 75 10             	mov    0x10(%ebp),%esi
80104f07:	8b 4d 08             	mov    0x8(%ebp),%ecx
80104f0a:	53                   	push   %ebx
80104f0b:	8b 55 0c             	mov    0xc(%ebp),%edx
80104f0e:	85 f6                	test   %esi,%esi
80104f10:	74 2e                	je     80104f40 <strncmp+0x40>
80104f12:	01 d6                	add    %edx,%esi
80104f14:	eb 18                	jmp    80104f2e <strncmp+0x2e>
80104f16:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104f1d:	8d 76 00             	lea    0x0(%esi),%esi
80104f20:	38 d8                	cmp    %bl,%al
80104f22:	75 14                	jne    80104f38 <strncmp+0x38>
80104f24:	83 c2 01             	add    $0x1,%edx
80104f27:	83 c1 01             	add    $0x1,%ecx
80104f2a:	39 f2                	cmp    %esi,%edx
80104f2c:	74 12                	je     80104f40 <strncmp+0x40>
80104f2e:	0f b6 01             	movzbl (%ecx),%eax
80104f31:	0f b6 1a             	movzbl (%edx),%ebx
80104f34:	84 c0                	test   %al,%al
80104f36:	75 e8                	jne    80104f20 <strncmp+0x20>
80104f38:	29 d8                	sub    %ebx,%eax
80104f3a:	5b                   	pop    %ebx
80104f3b:	5e                   	pop    %esi
80104f3c:	5d                   	pop    %ebp
80104f3d:	c3                   	ret    
80104f3e:	66 90                	xchg   %ax,%ax
80104f40:	5b                   	pop    %ebx
80104f41:	31 c0                	xor    %eax,%eax
80104f43:	5e                   	pop    %esi
80104f44:	5d                   	pop    %ebp
80104f45:	c3                   	ret    
80104f46:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104f4d:	8d 76 00             	lea    0x0(%esi),%esi

80104f50 <strncpy>:
80104f50:	55                   	push   %ebp
80104f51:	89 e5                	mov    %esp,%ebp
80104f53:	57                   	push   %edi
80104f54:	56                   	push   %esi
80104f55:	8b 75 08             	mov    0x8(%ebp),%esi
80104f58:	53                   	push   %ebx
80104f59:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104f5c:	89 f0                	mov    %esi,%eax
80104f5e:	eb 15                	jmp    80104f75 <strncpy+0x25>
80104f60:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
80104f64:	8b 7d 0c             	mov    0xc(%ebp),%edi
80104f67:	83 c0 01             	add    $0x1,%eax
80104f6a:	0f b6 57 ff          	movzbl -0x1(%edi),%edx
80104f6e:	88 50 ff             	mov    %dl,-0x1(%eax)
80104f71:	84 d2                	test   %dl,%dl
80104f73:	74 09                	je     80104f7e <strncpy+0x2e>
80104f75:	89 cb                	mov    %ecx,%ebx
80104f77:	83 e9 01             	sub    $0x1,%ecx
80104f7a:	85 db                	test   %ebx,%ebx
80104f7c:	7f e2                	jg     80104f60 <strncpy+0x10>
80104f7e:	89 c2                	mov    %eax,%edx
80104f80:	85 c9                	test   %ecx,%ecx
80104f82:	7e 17                	jle    80104f9b <strncpy+0x4b>
80104f84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104f88:	83 c2 01             	add    $0x1,%edx
80104f8b:	89 c1                	mov    %eax,%ecx
80104f8d:	c6 42 ff 00          	movb   $0x0,-0x1(%edx)
80104f91:	29 d1                	sub    %edx,%ecx
80104f93:	8d 4c 0b ff          	lea    -0x1(%ebx,%ecx,1),%ecx
80104f97:	85 c9                	test   %ecx,%ecx
80104f99:	7f ed                	jg     80104f88 <strncpy+0x38>
80104f9b:	5b                   	pop    %ebx
80104f9c:	89 f0                	mov    %esi,%eax
80104f9e:	5e                   	pop    %esi
80104f9f:	5f                   	pop    %edi
80104fa0:	5d                   	pop    %ebp
80104fa1:	c3                   	ret    
80104fa2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104fa9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104fb0 <safestrcpy>:
80104fb0:	55                   	push   %ebp
80104fb1:	89 e5                	mov    %esp,%ebp
80104fb3:	56                   	push   %esi
80104fb4:	8b 55 10             	mov    0x10(%ebp),%edx
80104fb7:	8b 75 08             	mov    0x8(%ebp),%esi
80104fba:	53                   	push   %ebx
80104fbb:	8b 45 0c             	mov    0xc(%ebp),%eax
80104fbe:	85 d2                	test   %edx,%edx
80104fc0:	7e 25                	jle    80104fe7 <safestrcpy+0x37>
80104fc2:	8d 5c 10 ff          	lea    -0x1(%eax,%edx,1),%ebx
80104fc6:	89 f2                	mov    %esi,%edx
80104fc8:	eb 16                	jmp    80104fe0 <safestrcpy+0x30>
80104fca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104fd0:	0f b6 08             	movzbl (%eax),%ecx
80104fd3:	83 c0 01             	add    $0x1,%eax
80104fd6:	83 c2 01             	add    $0x1,%edx
80104fd9:	88 4a ff             	mov    %cl,-0x1(%edx)
80104fdc:	84 c9                	test   %cl,%cl
80104fde:	74 04                	je     80104fe4 <safestrcpy+0x34>
80104fe0:	39 d8                	cmp    %ebx,%eax
80104fe2:	75 ec                	jne    80104fd0 <safestrcpy+0x20>
80104fe4:	c6 02 00             	movb   $0x0,(%edx)
80104fe7:	89 f0                	mov    %esi,%eax
80104fe9:	5b                   	pop    %ebx
80104fea:	5e                   	pop    %esi
80104feb:	5d                   	pop    %ebp
80104fec:	c3                   	ret    
80104fed:	8d 76 00             	lea    0x0(%esi),%esi

80104ff0 <strlen>:
80104ff0:	55                   	push   %ebp
80104ff1:	31 c0                	xor    %eax,%eax
80104ff3:	89 e5                	mov    %esp,%ebp
80104ff5:	8b 55 08             	mov    0x8(%ebp),%edx
80104ff8:	80 3a 00             	cmpb   $0x0,(%edx)
80104ffb:	74 0c                	je     80105009 <strlen+0x19>
80104ffd:	8d 76 00             	lea    0x0(%esi),%esi
80105000:	83 c0 01             	add    $0x1,%eax
80105003:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80105007:	75 f7                	jne    80105000 <strlen+0x10>
80105009:	5d                   	pop    %ebp
8010500a:	c3                   	ret    

8010500b <swtch>:
8010500b:	8b 44 24 04          	mov    0x4(%esp),%eax
8010500f:	8b 54 24 08          	mov    0x8(%esp),%edx
80105013:	55                   	push   %ebp
80105014:	53                   	push   %ebx
80105015:	56                   	push   %esi
80105016:	57                   	push   %edi
80105017:	89 20                	mov    %esp,(%eax)
80105019:	89 d4                	mov    %edx,%esp
8010501b:	5f                   	pop    %edi
8010501c:	5e                   	pop    %esi
8010501d:	5b                   	pop    %ebx
8010501e:	5d                   	pop    %ebp
8010501f:	c3                   	ret    

80105020 <fetchint>:
80105020:	55                   	push   %ebp
80105021:	89 e5                	mov    %esp,%ebp
80105023:	53                   	push   %ebx
80105024:	83 ec 04             	sub    $0x4,%esp
80105027:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010502a:	e8 d1 f0 ff ff       	call   80104100 <myproc>
8010502f:	8b 00                	mov    (%eax),%eax
80105031:	39 d8                	cmp    %ebx,%eax
80105033:	76 1b                	jbe    80105050 <fetchint+0x30>
80105035:	8d 53 04             	lea    0x4(%ebx),%edx
80105038:	39 d0                	cmp    %edx,%eax
8010503a:	72 14                	jb     80105050 <fetchint+0x30>
8010503c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010503f:	8b 13                	mov    (%ebx),%edx
80105041:	89 10                	mov    %edx,(%eax)
80105043:	31 c0                	xor    %eax,%eax
80105045:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105048:	c9                   	leave  
80105049:	c3                   	ret    
8010504a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105050:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105055:	eb ee                	jmp    80105045 <fetchint+0x25>
80105057:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010505e:	66 90                	xchg   %ax,%ax

80105060 <fetchstr>:
80105060:	55                   	push   %ebp
80105061:	89 e5                	mov    %esp,%ebp
80105063:	53                   	push   %ebx
80105064:	83 ec 04             	sub    $0x4,%esp
80105067:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010506a:	e8 91 f0 ff ff       	call   80104100 <myproc>
8010506f:	39 18                	cmp    %ebx,(%eax)
80105071:	76 2d                	jbe    801050a0 <fetchstr+0x40>
80105073:	8b 55 0c             	mov    0xc(%ebp),%edx
80105076:	89 1a                	mov    %ebx,(%edx)
80105078:	8b 10                	mov    (%eax),%edx
8010507a:	39 d3                	cmp    %edx,%ebx
8010507c:	73 22                	jae    801050a0 <fetchstr+0x40>
8010507e:	89 d8                	mov    %ebx,%eax
80105080:	eb 0d                	jmp    8010508f <fetchstr+0x2f>
80105082:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105088:	83 c0 01             	add    $0x1,%eax
8010508b:	39 c2                	cmp    %eax,%edx
8010508d:	76 11                	jbe    801050a0 <fetchstr+0x40>
8010508f:	80 38 00             	cmpb   $0x0,(%eax)
80105092:	75 f4                	jne    80105088 <fetchstr+0x28>
80105094:	29 d8                	sub    %ebx,%eax
80105096:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105099:	c9                   	leave  
8010509a:	c3                   	ret    
8010509b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010509f:	90                   	nop
801050a0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801050a3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801050a8:	c9                   	leave  
801050a9:	c3                   	ret    
801050aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801050b0 <argint>:
801050b0:	55                   	push   %ebp
801050b1:	89 e5                	mov    %esp,%ebp
801050b3:	56                   	push   %esi
801050b4:	53                   	push   %ebx
801050b5:	e8 46 f0 ff ff       	call   80104100 <myproc>
801050ba:	8b 55 08             	mov    0x8(%ebp),%edx
801050bd:	8b 40 18             	mov    0x18(%eax),%eax
801050c0:	8b 40 44             	mov    0x44(%eax),%eax
801050c3:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
801050c6:	e8 35 f0 ff ff       	call   80104100 <myproc>
801050cb:	8d 73 04             	lea    0x4(%ebx),%esi
801050ce:	8b 00                	mov    (%eax),%eax
801050d0:	39 c6                	cmp    %eax,%esi
801050d2:	73 1c                	jae    801050f0 <argint+0x40>
801050d4:	8d 53 08             	lea    0x8(%ebx),%edx
801050d7:	39 d0                	cmp    %edx,%eax
801050d9:	72 15                	jb     801050f0 <argint+0x40>
801050db:	8b 45 0c             	mov    0xc(%ebp),%eax
801050de:	8b 53 04             	mov    0x4(%ebx),%edx
801050e1:	89 10                	mov    %edx,(%eax)
801050e3:	31 c0                	xor    %eax,%eax
801050e5:	5b                   	pop    %ebx
801050e6:	5e                   	pop    %esi
801050e7:	5d                   	pop    %ebp
801050e8:	c3                   	ret    
801050e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801050f0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801050f5:	eb ee                	jmp    801050e5 <argint+0x35>
801050f7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801050fe:	66 90                	xchg   %ax,%ax

80105100 <argptr>:
80105100:	55                   	push   %ebp
80105101:	89 e5                	mov    %esp,%ebp
80105103:	57                   	push   %edi
80105104:	56                   	push   %esi
80105105:	53                   	push   %ebx
80105106:	83 ec 0c             	sub    $0xc,%esp
80105109:	e8 f2 ef ff ff       	call   80104100 <myproc>
8010510e:	89 c6                	mov    %eax,%esi
80105110:	e8 eb ef ff ff       	call   80104100 <myproc>
80105115:	8b 55 08             	mov    0x8(%ebp),%edx
80105118:	8b 40 18             	mov    0x18(%eax),%eax
8010511b:	8b 40 44             	mov    0x44(%eax),%eax
8010511e:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
80105121:	e8 da ef ff ff       	call   80104100 <myproc>
80105126:	8d 7b 04             	lea    0x4(%ebx),%edi
80105129:	8b 00                	mov    (%eax),%eax
8010512b:	39 c7                	cmp    %eax,%edi
8010512d:	73 31                	jae    80105160 <argptr+0x60>
8010512f:	8d 4b 08             	lea    0x8(%ebx),%ecx
80105132:	39 c8                	cmp    %ecx,%eax
80105134:	72 2a                	jb     80105160 <argptr+0x60>
80105136:	8b 55 10             	mov    0x10(%ebp),%edx
80105139:	8b 43 04             	mov    0x4(%ebx),%eax
8010513c:	85 d2                	test   %edx,%edx
8010513e:	78 20                	js     80105160 <argptr+0x60>
80105140:	8b 16                	mov    (%esi),%edx
80105142:	39 c2                	cmp    %eax,%edx
80105144:	76 1a                	jbe    80105160 <argptr+0x60>
80105146:	8b 5d 10             	mov    0x10(%ebp),%ebx
80105149:	01 c3                	add    %eax,%ebx
8010514b:	39 da                	cmp    %ebx,%edx
8010514d:	72 11                	jb     80105160 <argptr+0x60>
8010514f:	8b 55 0c             	mov    0xc(%ebp),%edx
80105152:	89 02                	mov    %eax,(%edx)
80105154:	31 c0                	xor    %eax,%eax
80105156:	83 c4 0c             	add    $0xc,%esp
80105159:	5b                   	pop    %ebx
8010515a:	5e                   	pop    %esi
8010515b:	5f                   	pop    %edi
8010515c:	5d                   	pop    %ebp
8010515d:	c3                   	ret    
8010515e:	66 90                	xchg   %ax,%ax
80105160:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105165:	eb ef                	jmp    80105156 <argptr+0x56>
80105167:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010516e:	66 90                	xchg   %ax,%ax

80105170 <argstr>:
80105170:	55                   	push   %ebp
80105171:	89 e5                	mov    %esp,%ebp
80105173:	56                   	push   %esi
80105174:	53                   	push   %ebx
80105175:	e8 86 ef ff ff       	call   80104100 <myproc>
8010517a:	8b 55 08             	mov    0x8(%ebp),%edx
8010517d:	8b 40 18             	mov    0x18(%eax),%eax
80105180:	8b 40 44             	mov    0x44(%eax),%eax
80105183:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
80105186:	e8 75 ef ff ff       	call   80104100 <myproc>
8010518b:	8d 73 04             	lea    0x4(%ebx),%esi
8010518e:	8b 00                	mov    (%eax),%eax
80105190:	39 c6                	cmp    %eax,%esi
80105192:	73 44                	jae    801051d8 <argstr+0x68>
80105194:	8d 53 08             	lea    0x8(%ebx),%edx
80105197:	39 d0                	cmp    %edx,%eax
80105199:	72 3d                	jb     801051d8 <argstr+0x68>
8010519b:	8b 5b 04             	mov    0x4(%ebx),%ebx
8010519e:	e8 5d ef ff ff       	call   80104100 <myproc>
801051a3:	3b 18                	cmp    (%eax),%ebx
801051a5:	73 31                	jae    801051d8 <argstr+0x68>
801051a7:	8b 55 0c             	mov    0xc(%ebp),%edx
801051aa:	89 1a                	mov    %ebx,(%edx)
801051ac:	8b 10                	mov    (%eax),%edx
801051ae:	39 d3                	cmp    %edx,%ebx
801051b0:	73 26                	jae    801051d8 <argstr+0x68>
801051b2:	89 d8                	mov    %ebx,%eax
801051b4:	eb 11                	jmp    801051c7 <argstr+0x57>
801051b6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801051bd:	8d 76 00             	lea    0x0(%esi),%esi
801051c0:	83 c0 01             	add    $0x1,%eax
801051c3:	39 c2                	cmp    %eax,%edx
801051c5:	76 11                	jbe    801051d8 <argstr+0x68>
801051c7:	80 38 00             	cmpb   $0x0,(%eax)
801051ca:	75 f4                	jne    801051c0 <argstr+0x50>
801051cc:	29 d8                	sub    %ebx,%eax
801051ce:	5b                   	pop    %ebx
801051cf:	5e                   	pop    %esi
801051d0:	5d                   	pop    %ebp
801051d1:	c3                   	ret    
801051d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801051d8:	5b                   	pop    %ebx
801051d9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801051de:	5e                   	pop    %esi
801051df:	5d                   	pop    %ebp
801051e0:	c3                   	ret    
801051e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801051e8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801051ef:	90                   	nop

801051f0 <syscall>:
801051f0:	55                   	push   %ebp
801051f1:	89 e5                	mov    %esp,%ebp
801051f3:	53                   	push   %ebx
801051f4:	83 ec 04             	sub    $0x4,%esp
801051f7:	e8 04 ef ff ff       	call   80104100 <myproc>
801051fc:	89 c3                	mov    %eax,%ebx
801051fe:	8b 40 18             	mov    0x18(%eax),%eax
80105201:	8b 40 1c             	mov    0x1c(%eax),%eax
80105204:	8d 50 ff             	lea    -0x1(%eax),%edx
80105207:	83 fa 14             	cmp    $0x14,%edx
8010520a:	77 24                	ja     80105230 <syscall+0x40>
8010520c:	8b 14 85 40 80 10 80 	mov    -0x7fef7fc0(,%eax,4),%edx
80105213:	85 d2                	test   %edx,%edx
80105215:	74 19                	je     80105230 <syscall+0x40>
80105217:	ff d2                	call   *%edx
80105219:	89 c2                	mov    %eax,%edx
8010521b:	8b 43 18             	mov    0x18(%ebx),%eax
8010521e:	89 50 1c             	mov    %edx,0x1c(%eax)
80105221:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105224:	c9                   	leave  
80105225:	c3                   	ret    
80105226:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010522d:	8d 76 00             	lea    0x0(%esi),%esi
80105230:	50                   	push   %eax
80105231:	8d 43 6c             	lea    0x6c(%ebx),%eax
80105234:	50                   	push   %eax
80105235:	ff 73 10             	push   0x10(%ebx)
80105238:	68 1d 80 10 80       	push   $0x8010801d
8010523d:	e8 0e b5 ff ff       	call   80100750 <cprintf>
80105242:	8b 43 18             	mov    0x18(%ebx),%eax
80105245:	83 c4 10             	add    $0x10,%esp
80105248:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
8010524f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105252:	c9                   	leave  
80105253:	c3                   	ret    
80105254:	66 90                	xchg   %ax,%ax
80105256:	66 90                	xchg   %ax,%ax
80105258:	66 90                	xchg   %ax,%ax
8010525a:	66 90                	xchg   %ax,%ax
8010525c:	66 90                	xchg   %ax,%ax
8010525e:	66 90                	xchg   %ax,%ax

80105260 <create>:
80105260:	55                   	push   %ebp
80105261:	89 e5                	mov    %esp,%ebp
80105263:	57                   	push   %edi
80105264:	56                   	push   %esi
80105265:	8d 7d da             	lea    -0x26(%ebp),%edi
80105268:	53                   	push   %ebx
80105269:	83 ec 34             	sub    $0x34,%esp
8010526c:	89 4d d0             	mov    %ecx,-0x30(%ebp)
8010526f:	8b 4d 08             	mov    0x8(%ebp),%ecx
80105272:	57                   	push   %edi
80105273:	50                   	push   %eax
80105274:	89 55 d4             	mov    %edx,-0x2c(%ebp)
80105277:	89 4d cc             	mov    %ecx,-0x34(%ebp)
8010527a:	e8 d1 d5 ff ff       	call   80102850 <nameiparent>
8010527f:	83 c4 10             	add    $0x10,%esp
80105282:	85 c0                	test   %eax,%eax
80105284:	0f 84 46 01 00 00    	je     801053d0 <create+0x170>
8010528a:	83 ec 0c             	sub    $0xc,%esp
8010528d:	89 c3                	mov    %eax,%ebx
8010528f:	50                   	push   %eax
80105290:	e8 7b cc ff ff       	call   80101f10 <ilock>
80105295:	83 c4 0c             	add    $0xc,%esp
80105298:	6a 00                	push   $0x0
8010529a:	57                   	push   %edi
8010529b:	53                   	push   %ebx
8010529c:	e8 cf d1 ff ff       	call   80102470 <dirlookup>
801052a1:	83 c4 10             	add    $0x10,%esp
801052a4:	89 c6                	mov    %eax,%esi
801052a6:	85 c0                	test   %eax,%eax
801052a8:	74 56                	je     80105300 <create+0xa0>
801052aa:	83 ec 0c             	sub    $0xc,%esp
801052ad:	53                   	push   %ebx
801052ae:	e8 ed ce ff ff       	call   801021a0 <iunlockput>
801052b3:	89 34 24             	mov    %esi,(%esp)
801052b6:	e8 55 cc ff ff       	call   80101f10 <ilock>
801052bb:	83 c4 10             	add    $0x10,%esp
801052be:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
801052c3:	75 1b                	jne    801052e0 <create+0x80>
801052c5:	66 83 7e 50 02       	cmpw   $0x2,0x50(%esi)
801052ca:	75 14                	jne    801052e0 <create+0x80>
801052cc:	8d 65 f4             	lea    -0xc(%ebp),%esp
801052cf:	89 f0                	mov    %esi,%eax
801052d1:	5b                   	pop    %ebx
801052d2:	5e                   	pop    %esi
801052d3:	5f                   	pop    %edi
801052d4:	5d                   	pop    %ebp
801052d5:	c3                   	ret    
801052d6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801052dd:	8d 76 00             	lea    0x0(%esi),%esi
801052e0:	83 ec 0c             	sub    $0xc,%esp
801052e3:	56                   	push   %esi
801052e4:	31 f6                	xor    %esi,%esi
801052e6:	e8 b5 ce ff ff       	call   801021a0 <iunlockput>
801052eb:	83 c4 10             	add    $0x10,%esp
801052ee:	8d 65 f4             	lea    -0xc(%ebp),%esp
801052f1:	89 f0                	mov    %esi,%eax
801052f3:	5b                   	pop    %ebx
801052f4:	5e                   	pop    %esi
801052f5:	5f                   	pop    %edi
801052f6:	5d                   	pop    %ebp
801052f7:	c3                   	ret    
801052f8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801052ff:	90                   	nop
80105300:	0f bf 45 d4          	movswl -0x2c(%ebp),%eax
80105304:	83 ec 08             	sub    $0x8,%esp
80105307:	50                   	push   %eax
80105308:	ff 33                	push   (%ebx)
8010530a:	e8 91 ca ff ff       	call   80101da0 <ialloc>
8010530f:	83 c4 10             	add    $0x10,%esp
80105312:	89 c6                	mov    %eax,%esi
80105314:	85 c0                	test   %eax,%eax
80105316:	0f 84 cd 00 00 00    	je     801053e9 <create+0x189>
8010531c:	83 ec 0c             	sub    $0xc,%esp
8010531f:	50                   	push   %eax
80105320:	e8 eb cb ff ff       	call   80101f10 <ilock>
80105325:	0f b7 45 d0          	movzwl -0x30(%ebp),%eax
80105329:	66 89 46 52          	mov    %ax,0x52(%esi)
8010532d:	0f b7 45 cc          	movzwl -0x34(%ebp),%eax
80105331:	66 89 46 54          	mov    %ax,0x54(%esi)
80105335:	b8 01 00 00 00       	mov    $0x1,%eax
8010533a:	66 89 46 56          	mov    %ax,0x56(%esi)
8010533e:	89 34 24             	mov    %esi,(%esp)
80105341:	e8 1a cb ff ff       	call   80101e60 <iupdate>
80105346:	83 c4 10             	add    $0x10,%esp
80105349:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
8010534e:	74 30                	je     80105380 <create+0x120>
80105350:	83 ec 04             	sub    $0x4,%esp
80105353:	ff 76 04             	push   0x4(%esi)
80105356:	57                   	push   %edi
80105357:	53                   	push   %ebx
80105358:	e8 13 d4 ff ff       	call   80102770 <dirlink>
8010535d:	83 c4 10             	add    $0x10,%esp
80105360:	85 c0                	test   %eax,%eax
80105362:	78 78                	js     801053dc <create+0x17c>
80105364:	83 ec 0c             	sub    $0xc,%esp
80105367:	53                   	push   %ebx
80105368:	e8 33 ce ff ff       	call   801021a0 <iunlockput>
8010536d:	83 c4 10             	add    $0x10,%esp
80105370:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105373:	89 f0                	mov    %esi,%eax
80105375:	5b                   	pop    %ebx
80105376:	5e                   	pop    %esi
80105377:	5f                   	pop    %edi
80105378:	5d                   	pop    %ebp
80105379:	c3                   	ret    
8010537a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105380:	83 ec 0c             	sub    $0xc,%esp
80105383:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
80105388:	53                   	push   %ebx
80105389:	e8 d2 ca ff ff       	call   80101e60 <iupdate>
8010538e:	83 c4 0c             	add    $0xc,%esp
80105391:	ff 76 04             	push   0x4(%esi)
80105394:	68 b4 80 10 80       	push   $0x801080b4
80105399:	56                   	push   %esi
8010539a:	e8 d1 d3 ff ff       	call   80102770 <dirlink>
8010539f:	83 c4 10             	add    $0x10,%esp
801053a2:	85 c0                	test   %eax,%eax
801053a4:	78 18                	js     801053be <create+0x15e>
801053a6:	83 ec 04             	sub    $0x4,%esp
801053a9:	ff 73 04             	push   0x4(%ebx)
801053ac:	68 b3 80 10 80       	push   $0x801080b3
801053b1:	56                   	push   %esi
801053b2:	e8 b9 d3 ff ff       	call   80102770 <dirlink>
801053b7:	83 c4 10             	add    $0x10,%esp
801053ba:	85 c0                	test   %eax,%eax
801053bc:	79 92                	jns    80105350 <create+0xf0>
801053be:	83 ec 0c             	sub    $0xc,%esp
801053c1:	68 a7 80 10 80       	push   $0x801080a7
801053c6:	e8 d5 af ff ff       	call   801003a0 <panic>
801053cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801053cf:	90                   	nop
801053d0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801053d3:	31 f6                	xor    %esi,%esi
801053d5:	5b                   	pop    %ebx
801053d6:	89 f0                	mov    %esi,%eax
801053d8:	5e                   	pop    %esi
801053d9:	5f                   	pop    %edi
801053da:	5d                   	pop    %ebp
801053db:	c3                   	ret    
801053dc:	83 ec 0c             	sub    $0xc,%esp
801053df:	68 b6 80 10 80       	push   $0x801080b6
801053e4:	e8 b7 af ff ff       	call   801003a0 <panic>
801053e9:	83 ec 0c             	sub    $0xc,%esp
801053ec:	68 98 80 10 80       	push   $0x80108098
801053f1:	e8 aa af ff ff       	call   801003a0 <panic>
801053f6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801053fd:	8d 76 00             	lea    0x0(%esi),%esi

80105400 <sys_dup>:
80105400:	55                   	push   %ebp
80105401:	89 e5                	mov    %esp,%ebp
80105403:	56                   	push   %esi
80105404:	53                   	push   %ebx
80105405:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105408:	83 ec 18             	sub    $0x18,%esp
8010540b:	50                   	push   %eax
8010540c:	6a 00                	push   $0x0
8010540e:	e8 9d fc ff ff       	call   801050b0 <argint>
80105413:	83 c4 10             	add    $0x10,%esp
80105416:	85 c0                	test   %eax,%eax
80105418:	78 36                	js     80105450 <sys_dup+0x50>
8010541a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
8010541e:	77 30                	ja     80105450 <sys_dup+0x50>
80105420:	e8 db ec ff ff       	call   80104100 <myproc>
80105425:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105428:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
8010542c:	85 f6                	test   %esi,%esi
8010542e:	74 20                	je     80105450 <sys_dup+0x50>
80105430:	e8 cb ec ff ff       	call   80104100 <myproc>
80105435:	31 db                	xor    %ebx,%ebx
80105437:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010543e:	66 90                	xchg   %ax,%ax
80105440:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105444:	85 d2                	test   %edx,%edx
80105446:	74 18                	je     80105460 <sys_dup+0x60>
80105448:	83 c3 01             	add    $0x1,%ebx
8010544b:	83 fb 10             	cmp    $0x10,%ebx
8010544e:	75 f0                	jne    80105440 <sys_dup+0x40>
80105450:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105453:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105458:	89 d8                	mov    %ebx,%eax
8010545a:	5b                   	pop    %ebx
8010545b:	5e                   	pop    %esi
8010545c:	5d                   	pop    %ebp
8010545d:	c3                   	ret    
8010545e:	66 90                	xchg   %ax,%ax
80105460:	83 ec 0c             	sub    $0xc,%esp
80105463:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)
80105467:	56                   	push   %esi
80105468:	e8 c3 c1 ff ff       	call   80101630 <filedup>
8010546d:	83 c4 10             	add    $0x10,%esp
80105470:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105473:	89 d8                	mov    %ebx,%eax
80105475:	5b                   	pop    %ebx
80105476:	5e                   	pop    %esi
80105477:	5d                   	pop    %ebp
80105478:	c3                   	ret    
80105479:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105480 <sys_read>:
80105480:	55                   	push   %ebp
80105481:	89 e5                	mov    %esp,%ebp
80105483:	56                   	push   %esi
80105484:	53                   	push   %ebx
80105485:	8d 5d f4             	lea    -0xc(%ebp),%ebx
80105488:	83 ec 18             	sub    $0x18,%esp
8010548b:	53                   	push   %ebx
8010548c:	6a 00                	push   $0x0
8010548e:	e8 1d fc ff ff       	call   801050b0 <argint>
80105493:	83 c4 10             	add    $0x10,%esp
80105496:	85 c0                	test   %eax,%eax
80105498:	78 5e                	js     801054f8 <sys_read+0x78>
8010549a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
8010549e:	77 58                	ja     801054f8 <sys_read+0x78>
801054a0:	e8 5b ec ff ff       	call   80104100 <myproc>
801054a5:	8b 55 f4             	mov    -0xc(%ebp),%edx
801054a8:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
801054ac:	85 f6                	test   %esi,%esi
801054ae:	74 48                	je     801054f8 <sys_read+0x78>
801054b0:	83 ec 08             	sub    $0x8,%esp
801054b3:	8d 45 f0             	lea    -0x10(%ebp),%eax
801054b6:	50                   	push   %eax
801054b7:	6a 02                	push   $0x2
801054b9:	e8 f2 fb ff ff       	call   801050b0 <argint>
801054be:	83 c4 10             	add    $0x10,%esp
801054c1:	85 c0                	test   %eax,%eax
801054c3:	78 33                	js     801054f8 <sys_read+0x78>
801054c5:	83 ec 04             	sub    $0x4,%esp
801054c8:	ff 75 f0             	push   -0x10(%ebp)
801054cb:	53                   	push   %ebx
801054cc:	6a 01                	push   $0x1
801054ce:	e8 2d fc ff ff       	call   80105100 <argptr>
801054d3:	83 c4 10             	add    $0x10,%esp
801054d6:	85 c0                	test   %eax,%eax
801054d8:	78 1e                	js     801054f8 <sys_read+0x78>
801054da:	83 ec 04             	sub    $0x4,%esp
801054dd:	ff 75 f0             	push   -0x10(%ebp)
801054e0:	ff 75 f4             	push   -0xc(%ebp)
801054e3:	56                   	push   %esi
801054e4:	e8 c7 c2 ff ff       	call   801017b0 <fileread>
801054e9:	83 c4 10             	add    $0x10,%esp
801054ec:	8d 65 f8             	lea    -0x8(%ebp),%esp
801054ef:	5b                   	pop    %ebx
801054f0:	5e                   	pop    %esi
801054f1:	5d                   	pop    %ebp
801054f2:	c3                   	ret    
801054f3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801054f7:	90                   	nop
801054f8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801054fd:	eb ed                	jmp    801054ec <sys_read+0x6c>
801054ff:	90                   	nop

80105500 <sys_write>:
80105500:	55                   	push   %ebp
80105501:	89 e5                	mov    %esp,%ebp
80105503:	56                   	push   %esi
80105504:	53                   	push   %ebx
80105505:	8d 5d f4             	lea    -0xc(%ebp),%ebx
80105508:	83 ec 18             	sub    $0x18,%esp
8010550b:	53                   	push   %ebx
8010550c:	6a 00                	push   $0x0
8010550e:	e8 9d fb ff ff       	call   801050b0 <argint>
80105513:	83 c4 10             	add    $0x10,%esp
80105516:	85 c0                	test   %eax,%eax
80105518:	78 5e                	js     80105578 <sys_write+0x78>
8010551a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
8010551e:	77 58                	ja     80105578 <sys_write+0x78>
80105520:	e8 db eb ff ff       	call   80104100 <myproc>
80105525:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105528:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
8010552c:	85 f6                	test   %esi,%esi
8010552e:	74 48                	je     80105578 <sys_write+0x78>
80105530:	83 ec 08             	sub    $0x8,%esp
80105533:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105536:	50                   	push   %eax
80105537:	6a 02                	push   $0x2
80105539:	e8 72 fb ff ff       	call   801050b0 <argint>
8010553e:	83 c4 10             	add    $0x10,%esp
80105541:	85 c0                	test   %eax,%eax
80105543:	78 33                	js     80105578 <sys_write+0x78>
80105545:	83 ec 04             	sub    $0x4,%esp
80105548:	ff 75 f0             	push   -0x10(%ebp)
8010554b:	53                   	push   %ebx
8010554c:	6a 01                	push   $0x1
8010554e:	e8 ad fb ff ff       	call   80105100 <argptr>
80105553:	83 c4 10             	add    $0x10,%esp
80105556:	85 c0                	test   %eax,%eax
80105558:	78 1e                	js     80105578 <sys_write+0x78>
8010555a:	83 ec 04             	sub    $0x4,%esp
8010555d:	ff 75 f0             	push   -0x10(%ebp)
80105560:	ff 75 f4             	push   -0xc(%ebp)
80105563:	56                   	push   %esi
80105564:	e8 d7 c2 ff ff       	call   80101840 <filewrite>
80105569:	83 c4 10             	add    $0x10,%esp
8010556c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010556f:	5b                   	pop    %ebx
80105570:	5e                   	pop    %esi
80105571:	5d                   	pop    %ebp
80105572:	c3                   	ret    
80105573:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105577:	90                   	nop
80105578:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010557d:	eb ed                	jmp    8010556c <sys_write+0x6c>
8010557f:	90                   	nop

80105580 <sys_close>:
80105580:	55                   	push   %ebp
80105581:	89 e5                	mov    %esp,%ebp
80105583:	56                   	push   %esi
80105584:	53                   	push   %ebx
80105585:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105588:	83 ec 18             	sub    $0x18,%esp
8010558b:	50                   	push   %eax
8010558c:	6a 00                	push   $0x0
8010558e:	e8 1d fb ff ff       	call   801050b0 <argint>
80105593:	83 c4 10             	add    $0x10,%esp
80105596:	85 c0                	test   %eax,%eax
80105598:	78 3e                	js     801055d8 <sys_close+0x58>
8010559a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
8010559e:	77 38                	ja     801055d8 <sys_close+0x58>
801055a0:	e8 5b eb ff ff       	call   80104100 <myproc>
801055a5:	8b 55 f4             	mov    -0xc(%ebp),%edx
801055a8:	8d 5a 08             	lea    0x8(%edx),%ebx
801055ab:	8b 74 98 08          	mov    0x8(%eax,%ebx,4),%esi
801055af:	85 f6                	test   %esi,%esi
801055b1:	74 25                	je     801055d8 <sys_close+0x58>
801055b3:	e8 48 eb ff ff       	call   80104100 <myproc>
801055b8:	83 ec 0c             	sub    $0xc,%esp
801055bb:	c7 44 98 08 00 00 00 	movl   $0x0,0x8(%eax,%ebx,4)
801055c2:	00 
801055c3:	56                   	push   %esi
801055c4:	e8 b7 c0 ff ff       	call   80101680 <fileclose>
801055c9:	83 c4 10             	add    $0x10,%esp
801055cc:	31 c0                	xor    %eax,%eax
801055ce:	8d 65 f8             	lea    -0x8(%ebp),%esp
801055d1:	5b                   	pop    %ebx
801055d2:	5e                   	pop    %esi
801055d3:	5d                   	pop    %ebp
801055d4:	c3                   	ret    
801055d5:	8d 76 00             	lea    0x0(%esi),%esi
801055d8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801055dd:	eb ef                	jmp    801055ce <sys_close+0x4e>
801055df:	90                   	nop

801055e0 <sys_fstat>:
801055e0:	55                   	push   %ebp
801055e1:	89 e5                	mov    %esp,%ebp
801055e3:	56                   	push   %esi
801055e4:	53                   	push   %ebx
801055e5:	8d 5d f4             	lea    -0xc(%ebp),%ebx
801055e8:	83 ec 18             	sub    $0x18,%esp
801055eb:	53                   	push   %ebx
801055ec:	6a 00                	push   $0x0
801055ee:	e8 bd fa ff ff       	call   801050b0 <argint>
801055f3:	83 c4 10             	add    $0x10,%esp
801055f6:	85 c0                	test   %eax,%eax
801055f8:	78 46                	js     80105640 <sys_fstat+0x60>
801055fa:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
801055fe:	77 40                	ja     80105640 <sys_fstat+0x60>
80105600:	e8 fb ea ff ff       	call   80104100 <myproc>
80105605:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105608:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
8010560c:	85 f6                	test   %esi,%esi
8010560e:	74 30                	je     80105640 <sys_fstat+0x60>
80105610:	83 ec 04             	sub    $0x4,%esp
80105613:	6a 14                	push   $0x14
80105615:	53                   	push   %ebx
80105616:	6a 01                	push   $0x1
80105618:	e8 e3 fa ff ff       	call   80105100 <argptr>
8010561d:	83 c4 10             	add    $0x10,%esp
80105620:	85 c0                	test   %eax,%eax
80105622:	78 1c                	js     80105640 <sys_fstat+0x60>
80105624:	83 ec 08             	sub    $0x8,%esp
80105627:	ff 75 f4             	push   -0xc(%ebp)
8010562a:	56                   	push   %esi
8010562b:	e8 30 c1 ff ff       	call   80101760 <filestat>
80105630:	83 c4 10             	add    $0x10,%esp
80105633:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105636:	5b                   	pop    %ebx
80105637:	5e                   	pop    %esi
80105638:	5d                   	pop    %ebp
80105639:	c3                   	ret    
8010563a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105640:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105645:	eb ec                	jmp    80105633 <sys_fstat+0x53>
80105647:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010564e:	66 90                	xchg   %ax,%ax

80105650 <sys_link>:
80105650:	55                   	push   %ebp
80105651:	89 e5                	mov    %esp,%ebp
80105653:	57                   	push   %edi
80105654:	56                   	push   %esi
80105655:	8d 45 d4             	lea    -0x2c(%ebp),%eax
80105658:	53                   	push   %ebx
80105659:	83 ec 34             	sub    $0x34,%esp
8010565c:	50                   	push   %eax
8010565d:	6a 00                	push   $0x0
8010565f:	e8 0c fb ff ff       	call   80105170 <argstr>
80105664:	83 c4 10             	add    $0x10,%esp
80105667:	85 c0                	test   %eax,%eax
80105669:	0f 88 fb 00 00 00    	js     8010576a <sys_link+0x11a>
8010566f:	83 ec 08             	sub    $0x8,%esp
80105672:	8d 45 d0             	lea    -0x30(%ebp),%eax
80105675:	50                   	push   %eax
80105676:	6a 01                	push   $0x1
80105678:	e8 f3 fa ff ff       	call   80105170 <argstr>
8010567d:	83 c4 10             	add    $0x10,%esp
80105680:	85 c0                	test   %eax,%eax
80105682:	0f 88 e2 00 00 00    	js     8010576a <sys_link+0x11a>
80105688:	e8 63 de ff ff       	call   801034f0 <begin_op>
8010568d:	83 ec 0c             	sub    $0xc,%esp
80105690:	ff 75 d4             	push   -0x2c(%ebp)
80105693:	e8 98 d1 ff ff       	call   80102830 <namei>
80105698:	83 c4 10             	add    $0x10,%esp
8010569b:	89 c3                	mov    %eax,%ebx
8010569d:	85 c0                	test   %eax,%eax
8010569f:	0f 84 e4 00 00 00    	je     80105789 <sys_link+0x139>
801056a5:	83 ec 0c             	sub    $0xc,%esp
801056a8:	50                   	push   %eax
801056a9:	e8 62 c8 ff ff       	call   80101f10 <ilock>
801056ae:	83 c4 10             	add    $0x10,%esp
801056b1:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801056b6:	0f 84 b5 00 00 00    	je     80105771 <sys_link+0x121>
801056bc:	83 ec 0c             	sub    $0xc,%esp
801056bf:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
801056c4:	8d 7d da             	lea    -0x26(%ebp),%edi
801056c7:	53                   	push   %ebx
801056c8:	e8 93 c7 ff ff       	call   80101e60 <iupdate>
801056cd:	89 1c 24             	mov    %ebx,(%esp)
801056d0:	e8 1b c9 ff ff       	call   80101ff0 <iunlock>
801056d5:	58                   	pop    %eax
801056d6:	5a                   	pop    %edx
801056d7:	57                   	push   %edi
801056d8:	ff 75 d0             	push   -0x30(%ebp)
801056db:	e8 70 d1 ff ff       	call   80102850 <nameiparent>
801056e0:	83 c4 10             	add    $0x10,%esp
801056e3:	89 c6                	mov    %eax,%esi
801056e5:	85 c0                	test   %eax,%eax
801056e7:	74 5b                	je     80105744 <sys_link+0xf4>
801056e9:	83 ec 0c             	sub    $0xc,%esp
801056ec:	50                   	push   %eax
801056ed:	e8 1e c8 ff ff       	call   80101f10 <ilock>
801056f2:	8b 03                	mov    (%ebx),%eax
801056f4:	83 c4 10             	add    $0x10,%esp
801056f7:	39 06                	cmp    %eax,(%esi)
801056f9:	75 3d                	jne    80105738 <sys_link+0xe8>
801056fb:	83 ec 04             	sub    $0x4,%esp
801056fe:	ff 73 04             	push   0x4(%ebx)
80105701:	57                   	push   %edi
80105702:	56                   	push   %esi
80105703:	e8 68 d0 ff ff       	call   80102770 <dirlink>
80105708:	83 c4 10             	add    $0x10,%esp
8010570b:	85 c0                	test   %eax,%eax
8010570d:	78 29                	js     80105738 <sys_link+0xe8>
8010570f:	83 ec 0c             	sub    $0xc,%esp
80105712:	56                   	push   %esi
80105713:	e8 88 ca ff ff       	call   801021a0 <iunlockput>
80105718:	89 1c 24             	mov    %ebx,(%esp)
8010571b:	e8 20 c9 ff ff       	call   80102040 <iput>
80105720:	e8 3b de ff ff       	call   80103560 <end_op>
80105725:	83 c4 10             	add    $0x10,%esp
80105728:	31 c0                	xor    %eax,%eax
8010572a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010572d:	5b                   	pop    %ebx
8010572e:	5e                   	pop    %esi
8010572f:	5f                   	pop    %edi
80105730:	5d                   	pop    %ebp
80105731:	c3                   	ret    
80105732:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105738:	83 ec 0c             	sub    $0xc,%esp
8010573b:	56                   	push   %esi
8010573c:	e8 5f ca ff ff       	call   801021a0 <iunlockput>
80105741:	83 c4 10             	add    $0x10,%esp
80105744:	83 ec 0c             	sub    $0xc,%esp
80105747:	53                   	push   %ebx
80105748:	e8 c3 c7 ff ff       	call   80101f10 <ilock>
8010574d:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
80105752:	89 1c 24             	mov    %ebx,(%esp)
80105755:	e8 06 c7 ff ff       	call   80101e60 <iupdate>
8010575a:	89 1c 24             	mov    %ebx,(%esp)
8010575d:	e8 3e ca ff ff       	call   801021a0 <iunlockput>
80105762:	e8 f9 dd ff ff       	call   80103560 <end_op>
80105767:	83 c4 10             	add    $0x10,%esp
8010576a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010576f:	eb b9                	jmp    8010572a <sys_link+0xda>
80105771:	83 ec 0c             	sub    $0xc,%esp
80105774:	53                   	push   %ebx
80105775:	e8 26 ca ff ff       	call   801021a0 <iunlockput>
8010577a:	e8 e1 dd ff ff       	call   80103560 <end_op>
8010577f:	83 c4 10             	add    $0x10,%esp
80105782:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105787:	eb a1                	jmp    8010572a <sys_link+0xda>
80105789:	e8 d2 dd ff ff       	call   80103560 <end_op>
8010578e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105793:	eb 95                	jmp    8010572a <sys_link+0xda>
80105795:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010579c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801057a0 <sys_unlink>:
801057a0:	55                   	push   %ebp
801057a1:	89 e5                	mov    %esp,%ebp
801057a3:	57                   	push   %edi
801057a4:	56                   	push   %esi
801057a5:	8d 45 c0             	lea    -0x40(%ebp),%eax
801057a8:	53                   	push   %ebx
801057a9:	83 ec 54             	sub    $0x54,%esp
801057ac:	50                   	push   %eax
801057ad:	6a 00                	push   $0x0
801057af:	e8 bc f9 ff ff       	call   80105170 <argstr>
801057b4:	83 c4 10             	add    $0x10,%esp
801057b7:	85 c0                	test   %eax,%eax
801057b9:	0f 88 7a 01 00 00    	js     80105939 <sys_unlink+0x199>
801057bf:	e8 2c dd ff ff       	call   801034f0 <begin_op>
801057c4:	8d 5d ca             	lea    -0x36(%ebp),%ebx
801057c7:	83 ec 08             	sub    $0x8,%esp
801057ca:	53                   	push   %ebx
801057cb:	ff 75 c0             	push   -0x40(%ebp)
801057ce:	e8 7d d0 ff ff       	call   80102850 <nameiparent>
801057d3:	83 c4 10             	add    $0x10,%esp
801057d6:	89 45 b4             	mov    %eax,-0x4c(%ebp)
801057d9:	85 c0                	test   %eax,%eax
801057db:	0f 84 62 01 00 00    	je     80105943 <sys_unlink+0x1a3>
801057e1:	8b 7d b4             	mov    -0x4c(%ebp),%edi
801057e4:	83 ec 0c             	sub    $0xc,%esp
801057e7:	57                   	push   %edi
801057e8:	e8 23 c7 ff ff       	call   80101f10 <ilock>
801057ed:	58                   	pop    %eax
801057ee:	5a                   	pop    %edx
801057ef:	68 b4 80 10 80       	push   $0x801080b4
801057f4:	53                   	push   %ebx
801057f5:	e8 56 cc ff ff       	call   80102450 <namecmp>
801057fa:	83 c4 10             	add    $0x10,%esp
801057fd:	85 c0                	test   %eax,%eax
801057ff:	0f 84 fb 00 00 00    	je     80105900 <sys_unlink+0x160>
80105805:	83 ec 08             	sub    $0x8,%esp
80105808:	68 b3 80 10 80       	push   $0x801080b3
8010580d:	53                   	push   %ebx
8010580e:	e8 3d cc ff ff       	call   80102450 <namecmp>
80105813:	83 c4 10             	add    $0x10,%esp
80105816:	85 c0                	test   %eax,%eax
80105818:	0f 84 e2 00 00 00    	je     80105900 <sys_unlink+0x160>
8010581e:	83 ec 04             	sub    $0x4,%esp
80105821:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80105824:	50                   	push   %eax
80105825:	53                   	push   %ebx
80105826:	57                   	push   %edi
80105827:	e8 44 cc ff ff       	call   80102470 <dirlookup>
8010582c:	83 c4 10             	add    $0x10,%esp
8010582f:	89 c3                	mov    %eax,%ebx
80105831:	85 c0                	test   %eax,%eax
80105833:	0f 84 c7 00 00 00    	je     80105900 <sys_unlink+0x160>
80105839:	83 ec 0c             	sub    $0xc,%esp
8010583c:	50                   	push   %eax
8010583d:	e8 ce c6 ff ff       	call   80101f10 <ilock>
80105842:	83 c4 10             	add    $0x10,%esp
80105845:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
8010584a:	0f 8e 1c 01 00 00    	jle    8010596c <sys_unlink+0x1cc>
80105850:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105855:	8d 7d d8             	lea    -0x28(%ebp),%edi
80105858:	74 66                	je     801058c0 <sys_unlink+0x120>
8010585a:	83 ec 04             	sub    $0x4,%esp
8010585d:	6a 10                	push   $0x10
8010585f:	6a 00                	push   $0x0
80105861:	57                   	push   %edi
80105862:	e8 89 f5 ff ff       	call   80104df0 <memset>
80105867:	6a 10                	push   $0x10
80105869:	ff 75 c4             	push   -0x3c(%ebp)
8010586c:	57                   	push   %edi
8010586d:	ff 75 b4             	push   -0x4c(%ebp)
80105870:	e8 ab ca ff ff       	call   80102320 <writei>
80105875:	83 c4 20             	add    $0x20,%esp
80105878:	83 f8 10             	cmp    $0x10,%eax
8010587b:	0f 85 de 00 00 00    	jne    8010595f <sys_unlink+0x1bf>
80105881:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105886:	0f 84 94 00 00 00    	je     80105920 <sys_unlink+0x180>
8010588c:	83 ec 0c             	sub    $0xc,%esp
8010588f:	ff 75 b4             	push   -0x4c(%ebp)
80105892:	e8 09 c9 ff ff       	call   801021a0 <iunlockput>
80105897:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
8010589c:	89 1c 24             	mov    %ebx,(%esp)
8010589f:	e8 bc c5 ff ff       	call   80101e60 <iupdate>
801058a4:	89 1c 24             	mov    %ebx,(%esp)
801058a7:	e8 f4 c8 ff ff       	call   801021a0 <iunlockput>
801058ac:	e8 af dc ff ff       	call   80103560 <end_op>
801058b1:	83 c4 10             	add    $0x10,%esp
801058b4:	31 c0                	xor    %eax,%eax
801058b6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801058b9:	5b                   	pop    %ebx
801058ba:	5e                   	pop    %esi
801058bb:	5f                   	pop    %edi
801058bc:	5d                   	pop    %ebp
801058bd:	c3                   	ret    
801058be:	66 90                	xchg   %ax,%ax
801058c0:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
801058c4:	76 94                	jbe    8010585a <sys_unlink+0xba>
801058c6:	be 20 00 00 00       	mov    $0x20,%esi
801058cb:	eb 0b                	jmp    801058d8 <sys_unlink+0x138>
801058cd:	8d 76 00             	lea    0x0(%esi),%esi
801058d0:	83 c6 10             	add    $0x10,%esi
801058d3:	3b 73 58             	cmp    0x58(%ebx),%esi
801058d6:	73 82                	jae    8010585a <sys_unlink+0xba>
801058d8:	6a 10                	push   $0x10
801058da:	56                   	push   %esi
801058db:	57                   	push   %edi
801058dc:	53                   	push   %ebx
801058dd:	e8 3e c9 ff ff       	call   80102220 <readi>
801058e2:	83 c4 10             	add    $0x10,%esp
801058e5:	83 f8 10             	cmp    $0x10,%eax
801058e8:	75 68                	jne    80105952 <sys_unlink+0x1b2>
801058ea:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
801058ef:	74 df                	je     801058d0 <sys_unlink+0x130>
801058f1:	83 ec 0c             	sub    $0xc,%esp
801058f4:	53                   	push   %ebx
801058f5:	e8 a6 c8 ff ff       	call   801021a0 <iunlockput>
801058fa:	83 c4 10             	add    $0x10,%esp
801058fd:	8d 76 00             	lea    0x0(%esi),%esi
80105900:	83 ec 0c             	sub    $0xc,%esp
80105903:	ff 75 b4             	push   -0x4c(%ebp)
80105906:	e8 95 c8 ff ff       	call   801021a0 <iunlockput>
8010590b:	e8 50 dc ff ff       	call   80103560 <end_op>
80105910:	83 c4 10             	add    $0x10,%esp
80105913:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105918:	eb 9c                	jmp    801058b6 <sys_unlink+0x116>
8010591a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105920:	8b 45 b4             	mov    -0x4c(%ebp),%eax
80105923:	83 ec 0c             	sub    $0xc,%esp
80105926:	66 83 68 56 01       	subw   $0x1,0x56(%eax)
8010592b:	50                   	push   %eax
8010592c:	e8 2f c5 ff ff       	call   80101e60 <iupdate>
80105931:	83 c4 10             	add    $0x10,%esp
80105934:	e9 53 ff ff ff       	jmp    8010588c <sys_unlink+0xec>
80105939:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010593e:	e9 73 ff ff ff       	jmp    801058b6 <sys_unlink+0x116>
80105943:	e8 18 dc ff ff       	call   80103560 <end_op>
80105948:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010594d:	e9 64 ff ff ff       	jmp    801058b6 <sys_unlink+0x116>
80105952:	83 ec 0c             	sub    $0xc,%esp
80105955:	68 d8 80 10 80       	push   $0x801080d8
8010595a:	e8 41 aa ff ff       	call   801003a0 <panic>
8010595f:	83 ec 0c             	sub    $0xc,%esp
80105962:	68 ea 80 10 80       	push   $0x801080ea
80105967:	e8 34 aa ff ff       	call   801003a0 <panic>
8010596c:	83 ec 0c             	sub    $0xc,%esp
8010596f:	68 c6 80 10 80       	push   $0x801080c6
80105974:	e8 27 aa ff ff       	call   801003a0 <panic>
80105979:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105980 <sys_open>:
80105980:	55                   	push   %ebp
80105981:	89 e5                	mov    %esp,%ebp
80105983:	57                   	push   %edi
80105984:	56                   	push   %esi
80105985:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105988:	53                   	push   %ebx
80105989:	83 ec 24             	sub    $0x24,%esp
8010598c:	50                   	push   %eax
8010598d:	6a 00                	push   $0x0
8010598f:	e8 dc f7 ff ff       	call   80105170 <argstr>
80105994:	83 c4 10             	add    $0x10,%esp
80105997:	85 c0                	test   %eax,%eax
80105999:	0f 88 8e 00 00 00    	js     80105a2d <sys_open+0xad>
8010599f:	83 ec 08             	sub    $0x8,%esp
801059a2:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801059a5:	50                   	push   %eax
801059a6:	6a 01                	push   $0x1
801059a8:	e8 03 f7 ff ff       	call   801050b0 <argint>
801059ad:	83 c4 10             	add    $0x10,%esp
801059b0:	85 c0                	test   %eax,%eax
801059b2:	78 79                	js     80105a2d <sys_open+0xad>
801059b4:	e8 37 db ff ff       	call   801034f0 <begin_op>
801059b9:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
801059bd:	75 79                	jne    80105a38 <sys_open+0xb8>
801059bf:	83 ec 0c             	sub    $0xc,%esp
801059c2:	ff 75 e0             	push   -0x20(%ebp)
801059c5:	e8 66 ce ff ff       	call   80102830 <namei>
801059ca:	83 c4 10             	add    $0x10,%esp
801059cd:	89 c6                	mov    %eax,%esi
801059cf:	85 c0                	test   %eax,%eax
801059d1:	0f 84 7e 00 00 00    	je     80105a55 <sys_open+0xd5>
801059d7:	83 ec 0c             	sub    $0xc,%esp
801059da:	50                   	push   %eax
801059db:	e8 30 c5 ff ff       	call   80101f10 <ilock>
801059e0:	83 c4 10             	add    $0x10,%esp
801059e3:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
801059e8:	0f 84 c2 00 00 00    	je     80105ab0 <sys_open+0x130>
801059ee:	e8 cd bb ff ff       	call   801015c0 <filealloc>
801059f3:	89 c7                	mov    %eax,%edi
801059f5:	85 c0                	test   %eax,%eax
801059f7:	74 23                	je     80105a1c <sys_open+0x9c>
801059f9:	e8 02 e7 ff ff       	call   80104100 <myproc>
801059fe:	31 db                	xor    %ebx,%ebx
80105a00:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105a04:	85 d2                	test   %edx,%edx
80105a06:	74 60                	je     80105a68 <sys_open+0xe8>
80105a08:	83 c3 01             	add    $0x1,%ebx
80105a0b:	83 fb 10             	cmp    $0x10,%ebx
80105a0e:	75 f0                	jne    80105a00 <sys_open+0x80>
80105a10:	83 ec 0c             	sub    $0xc,%esp
80105a13:	57                   	push   %edi
80105a14:	e8 67 bc ff ff       	call   80101680 <fileclose>
80105a19:	83 c4 10             	add    $0x10,%esp
80105a1c:	83 ec 0c             	sub    $0xc,%esp
80105a1f:	56                   	push   %esi
80105a20:	e8 7b c7 ff ff       	call   801021a0 <iunlockput>
80105a25:	e8 36 db ff ff       	call   80103560 <end_op>
80105a2a:	83 c4 10             	add    $0x10,%esp
80105a2d:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105a32:	eb 6d                	jmp    80105aa1 <sys_open+0x121>
80105a34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105a38:	83 ec 0c             	sub    $0xc,%esp
80105a3b:	8b 45 e0             	mov    -0x20(%ebp),%eax
80105a3e:	31 c9                	xor    %ecx,%ecx
80105a40:	ba 02 00 00 00       	mov    $0x2,%edx
80105a45:	6a 00                	push   $0x0
80105a47:	e8 14 f8 ff ff       	call   80105260 <create>
80105a4c:	83 c4 10             	add    $0x10,%esp
80105a4f:	89 c6                	mov    %eax,%esi
80105a51:	85 c0                	test   %eax,%eax
80105a53:	75 99                	jne    801059ee <sys_open+0x6e>
80105a55:	e8 06 db ff ff       	call   80103560 <end_op>
80105a5a:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105a5f:	eb 40                	jmp    80105aa1 <sys_open+0x121>
80105a61:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105a68:	83 ec 0c             	sub    $0xc,%esp
80105a6b:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
80105a6f:	56                   	push   %esi
80105a70:	e8 7b c5 ff ff       	call   80101ff0 <iunlock>
80105a75:	e8 e6 da ff ff       	call   80103560 <end_op>
80105a7a:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
80105a80:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80105a83:	83 c4 10             	add    $0x10,%esp
80105a86:	89 77 10             	mov    %esi,0x10(%edi)
80105a89:	89 d0                	mov    %edx,%eax
80105a8b:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
80105a92:	f7 d0                	not    %eax
80105a94:	83 e0 01             	and    $0x1,%eax
80105a97:	83 e2 03             	and    $0x3,%edx
80105a9a:	88 47 08             	mov    %al,0x8(%edi)
80105a9d:	0f 95 47 09          	setne  0x9(%edi)
80105aa1:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105aa4:	89 d8                	mov    %ebx,%eax
80105aa6:	5b                   	pop    %ebx
80105aa7:	5e                   	pop    %esi
80105aa8:	5f                   	pop    %edi
80105aa9:	5d                   	pop    %ebp
80105aaa:	c3                   	ret    
80105aab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105aaf:	90                   	nop
80105ab0:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80105ab3:	85 c9                	test   %ecx,%ecx
80105ab5:	0f 84 33 ff ff ff    	je     801059ee <sys_open+0x6e>
80105abb:	e9 5c ff ff ff       	jmp    80105a1c <sys_open+0x9c>

80105ac0 <sys_mkdir>:
80105ac0:	55                   	push   %ebp
80105ac1:	89 e5                	mov    %esp,%ebp
80105ac3:	83 ec 18             	sub    $0x18,%esp
80105ac6:	e8 25 da ff ff       	call   801034f0 <begin_op>
80105acb:	83 ec 08             	sub    $0x8,%esp
80105ace:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105ad1:	50                   	push   %eax
80105ad2:	6a 00                	push   $0x0
80105ad4:	e8 97 f6 ff ff       	call   80105170 <argstr>
80105ad9:	83 c4 10             	add    $0x10,%esp
80105adc:	85 c0                	test   %eax,%eax
80105ade:	78 30                	js     80105b10 <sys_mkdir+0x50>
80105ae0:	83 ec 0c             	sub    $0xc,%esp
80105ae3:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105ae6:	31 c9                	xor    %ecx,%ecx
80105ae8:	ba 01 00 00 00       	mov    $0x1,%edx
80105aed:	6a 00                	push   $0x0
80105aef:	e8 6c f7 ff ff       	call   80105260 <create>
80105af4:	83 c4 10             	add    $0x10,%esp
80105af7:	85 c0                	test   %eax,%eax
80105af9:	74 15                	je     80105b10 <sys_mkdir+0x50>
80105afb:	83 ec 0c             	sub    $0xc,%esp
80105afe:	50                   	push   %eax
80105aff:	e8 9c c6 ff ff       	call   801021a0 <iunlockput>
80105b04:	e8 57 da ff ff       	call   80103560 <end_op>
80105b09:	83 c4 10             	add    $0x10,%esp
80105b0c:	31 c0                	xor    %eax,%eax
80105b0e:	c9                   	leave  
80105b0f:	c3                   	ret    
80105b10:	e8 4b da ff ff       	call   80103560 <end_op>
80105b15:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105b1a:	c9                   	leave  
80105b1b:	c3                   	ret    
80105b1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105b20 <sys_mknod>:
80105b20:	55                   	push   %ebp
80105b21:	89 e5                	mov    %esp,%ebp
80105b23:	83 ec 18             	sub    $0x18,%esp
80105b26:	e8 c5 d9 ff ff       	call   801034f0 <begin_op>
80105b2b:	83 ec 08             	sub    $0x8,%esp
80105b2e:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105b31:	50                   	push   %eax
80105b32:	6a 00                	push   $0x0
80105b34:	e8 37 f6 ff ff       	call   80105170 <argstr>
80105b39:	83 c4 10             	add    $0x10,%esp
80105b3c:	85 c0                	test   %eax,%eax
80105b3e:	78 60                	js     80105ba0 <sys_mknod+0x80>
80105b40:	83 ec 08             	sub    $0x8,%esp
80105b43:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105b46:	50                   	push   %eax
80105b47:	6a 01                	push   $0x1
80105b49:	e8 62 f5 ff ff       	call   801050b0 <argint>
80105b4e:	83 c4 10             	add    $0x10,%esp
80105b51:	85 c0                	test   %eax,%eax
80105b53:	78 4b                	js     80105ba0 <sys_mknod+0x80>
80105b55:	83 ec 08             	sub    $0x8,%esp
80105b58:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105b5b:	50                   	push   %eax
80105b5c:	6a 02                	push   $0x2
80105b5e:	e8 4d f5 ff ff       	call   801050b0 <argint>
80105b63:	83 c4 10             	add    $0x10,%esp
80105b66:	85 c0                	test   %eax,%eax
80105b68:	78 36                	js     80105ba0 <sys_mknod+0x80>
80105b6a:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
80105b6e:	83 ec 0c             	sub    $0xc,%esp
80105b71:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
80105b75:	ba 03 00 00 00       	mov    $0x3,%edx
80105b7a:	50                   	push   %eax
80105b7b:	8b 45 ec             	mov    -0x14(%ebp),%eax
80105b7e:	e8 dd f6 ff ff       	call   80105260 <create>
80105b83:	83 c4 10             	add    $0x10,%esp
80105b86:	85 c0                	test   %eax,%eax
80105b88:	74 16                	je     80105ba0 <sys_mknod+0x80>
80105b8a:	83 ec 0c             	sub    $0xc,%esp
80105b8d:	50                   	push   %eax
80105b8e:	e8 0d c6 ff ff       	call   801021a0 <iunlockput>
80105b93:	e8 c8 d9 ff ff       	call   80103560 <end_op>
80105b98:	83 c4 10             	add    $0x10,%esp
80105b9b:	31 c0                	xor    %eax,%eax
80105b9d:	c9                   	leave  
80105b9e:	c3                   	ret    
80105b9f:	90                   	nop
80105ba0:	e8 bb d9 ff ff       	call   80103560 <end_op>
80105ba5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105baa:	c9                   	leave  
80105bab:	c3                   	ret    
80105bac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105bb0 <sys_chdir>:
80105bb0:	55                   	push   %ebp
80105bb1:	89 e5                	mov    %esp,%ebp
80105bb3:	56                   	push   %esi
80105bb4:	53                   	push   %ebx
80105bb5:	83 ec 10             	sub    $0x10,%esp
80105bb8:	e8 43 e5 ff ff       	call   80104100 <myproc>
80105bbd:	89 c6                	mov    %eax,%esi
80105bbf:	e8 2c d9 ff ff       	call   801034f0 <begin_op>
80105bc4:	83 ec 08             	sub    $0x8,%esp
80105bc7:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105bca:	50                   	push   %eax
80105bcb:	6a 00                	push   $0x0
80105bcd:	e8 9e f5 ff ff       	call   80105170 <argstr>
80105bd2:	83 c4 10             	add    $0x10,%esp
80105bd5:	85 c0                	test   %eax,%eax
80105bd7:	78 77                	js     80105c50 <sys_chdir+0xa0>
80105bd9:	83 ec 0c             	sub    $0xc,%esp
80105bdc:	ff 75 f4             	push   -0xc(%ebp)
80105bdf:	e8 4c cc ff ff       	call   80102830 <namei>
80105be4:	83 c4 10             	add    $0x10,%esp
80105be7:	89 c3                	mov    %eax,%ebx
80105be9:	85 c0                	test   %eax,%eax
80105beb:	74 63                	je     80105c50 <sys_chdir+0xa0>
80105bed:	83 ec 0c             	sub    $0xc,%esp
80105bf0:	50                   	push   %eax
80105bf1:	e8 1a c3 ff ff       	call   80101f10 <ilock>
80105bf6:	83 c4 10             	add    $0x10,%esp
80105bf9:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105bfe:	75 30                	jne    80105c30 <sys_chdir+0x80>
80105c00:	83 ec 0c             	sub    $0xc,%esp
80105c03:	53                   	push   %ebx
80105c04:	e8 e7 c3 ff ff       	call   80101ff0 <iunlock>
80105c09:	58                   	pop    %eax
80105c0a:	ff 76 68             	push   0x68(%esi)
80105c0d:	e8 2e c4 ff ff       	call   80102040 <iput>
80105c12:	e8 49 d9 ff ff       	call   80103560 <end_op>
80105c17:	89 5e 68             	mov    %ebx,0x68(%esi)
80105c1a:	83 c4 10             	add    $0x10,%esp
80105c1d:	31 c0                	xor    %eax,%eax
80105c1f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105c22:	5b                   	pop    %ebx
80105c23:	5e                   	pop    %esi
80105c24:	5d                   	pop    %ebp
80105c25:	c3                   	ret    
80105c26:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105c2d:	8d 76 00             	lea    0x0(%esi),%esi
80105c30:	83 ec 0c             	sub    $0xc,%esp
80105c33:	53                   	push   %ebx
80105c34:	e8 67 c5 ff ff       	call   801021a0 <iunlockput>
80105c39:	e8 22 d9 ff ff       	call   80103560 <end_op>
80105c3e:	83 c4 10             	add    $0x10,%esp
80105c41:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105c46:	eb d7                	jmp    80105c1f <sys_chdir+0x6f>
80105c48:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105c4f:	90                   	nop
80105c50:	e8 0b d9 ff ff       	call   80103560 <end_op>
80105c55:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105c5a:	eb c3                	jmp    80105c1f <sys_chdir+0x6f>
80105c5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105c60 <sys_exec>:
80105c60:	55                   	push   %ebp
80105c61:	89 e5                	mov    %esp,%ebp
80105c63:	57                   	push   %edi
80105c64:	56                   	push   %esi
80105c65:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
80105c6b:	53                   	push   %ebx
80105c6c:	81 ec a4 00 00 00    	sub    $0xa4,%esp
80105c72:	50                   	push   %eax
80105c73:	6a 00                	push   $0x0
80105c75:	e8 f6 f4 ff ff       	call   80105170 <argstr>
80105c7a:	83 c4 10             	add    $0x10,%esp
80105c7d:	85 c0                	test   %eax,%eax
80105c7f:	0f 88 87 00 00 00    	js     80105d0c <sys_exec+0xac>
80105c85:	83 ec 08             	sub    $0x8,%esp
80105c88:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
80105c8e:	50                   	push   %eax
80105c8f:	6a 01                	push   $0x1
80105c91:	e8 1a f4 ff ff       	call   801050b0 <argint>
80105c96:	83 c4 10             	add    $0x10,%esp
80105c99:	85 c0                	test   %eax,%eax
80105c9b:	78 6f                	js     80105d0c <sys_exec+0xac>
80105c9d:	83 ec 04             	sub    $0x4,%esp
80105ca0:	8d b5 68 ff ff ff    	lea    -0x98(%ebp),%esi
80105ca6:	31 db                	xor    %ebx,%ebx
80105ca8:	68 80 00 00 00       	push   $0x80
80105cad:	6a 00                	push   $0x0
80105caf:	56                   	push   %esi
80105cb0:	e8 3b f1 ff ff       	call   80104df0 <memset>
80105cb5:	83 c4 10             	add    $0x10,%esp
80105cb8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105cbf:	90                   	nop
80105cc0:	83 ec 08             	sub    $0x8,%esp
80105cc3:	8d 85 64 ff ff ff    	lea    -0x9c(%ebp),%eax
80105cc9:	8d 3c 9d 00 00 00 00 	lea    0x0(,%ebx,4),%edi
80105cd0:	50                   	push   %eax
80105cd1:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
80105cd7:	01 f8                	add    %edi,%eax
80105cd9:	50                   	push   %eax
80105cda:	e8 41 f3 ff ff       	call   80105020 <fetchint>
80105cdf:	83 c4 10             	add    $0x10,%esp
80105ce2:	85 c0                	test   %eax,%eax
80105ce4:	78 26                	js     80105d0c <sys_exec+0xac>
80105ce6:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80105cec:	85 c0                	test   %eax,%eax
80105cee:	74 30                	je     80105d20 <sys_exec+0xc0>
80105cf0:	83 ec 08             	sub    $0x8,%esp
80105cf3:	8d 14 3e             	lea    (%esi,%edi,1),%edx
80105cf6:	52                   	push   %edx
80105cf7:	50                   	push   %eax
80105cf8:	e8 63 f3 ff ff       	call   80105060 <fetchstr>
80105cfd:	83 c4 10             	add    $0x10,%esp
80105d00:	85 c0                	test   %eax,%eax
80105d02:	78 08                	js     80105d0c <sys_exec+0xac>
80105d04:	83 c3 01             	add    $0x1,%ebx
80105d07:	83 fb 20             	cmp    $0x20,%ebx
80105d0a:	75 b4                	jne    80105cc0 <sys_exec+0x60>
80105d0c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105d0f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105d14:	5b                   	pop    %ebx
80105d15:	5e                   	pop    %esi
80105d16:	5f                   	pop    %edi
80105d17:	5d                   	pop    %ebp
80105d18:	c3                   	ret    
80105d19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105d20:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
80105d27:	00 00 00 00 
80105d2b:	83 ec 08             	sub    $0x8,%esp
80105d2e:	56                   	push   %esi
80105d2f:	ff b5 5c ff ff ff    	push   -0xa4(%ebp)
80105d35:	e8 06 b5 ff ff       	call   80101240 <exec>
80105d3a:	83 c4 10             	add    $0x10,%esp
80105d3d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105d40:	5b                   	pop    %ebx
80105d41:	5e                   	pop    %esi
80105d42:	5f                   	pop    %edi
80105d43:	5d                   	pop    %ebp
80105d44:	c3                   	ret    
80105d45:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105d4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105d50 <sys_pipe>:
80105d50:	55                   	push   %ebp
80105d51:	89 e5                	mov    %esp,%ebp
80105d53:	57                   	push   %edi
80105d54:	56                   	push   %esi
80105d55:	8d 45 dc             	lea    -0x24(%ebp),%eax
80105d58:	53                   	push   %ebx
80105d59:	83 ec 20             	sub    $0x20,%esp
80105d5c:	6a 08                	push   $0x8
80105d5e:	50                   	push   %eax
80105d5f:	6a 00                	push   $0x0
80105d61:	e8 9a f3 ff ff       	call   80105100 <argptr>
80105d66:	83 c4 10             	add    $0x10,%esp
80105d69:	85 c0                	test   %eax,%eax
80105d6b:	78 4a                	js     80105db7 <sys_pipe+0x67>
80105d6d:	83 ec 08             	sub    $0x8,%esp
80105d70:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105d73:	50                   	push   %eax
80105d74:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105d77:	50                   	push   %eax
80105d78:	e8 43 de ff ff       	call   80103bc0 <pipealloc>
80105d7d:	83 c4 10             	add    $0x10,%esp
80105d80:	85 c0                	test   %eax,%eax
80105d82:	78 33                	js     80105db7 <sys_pipe+0x67>
80105d84:	8b 7d e0             	mov    -0x20(%ebp),%edi
80105d87:	31 db                	xor    %ebx,%ebx
80105d89:	e8 72 e3 ff ff       	call   80104100 <myproc>
80105d8e:	66 90                	xchg   %ax,%ax
80105d90:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
80105d94:	85 f6                	test   %esi,%esi
80105d96:	74 28                	je     80105dc0 <sys_pipe+0x70>
80105d98:	83 c3 01             	add    $0x1,%ebx
80105d9b:	83 fb 10             	cmp    $0x10,%ebx
80105d9e:	75 f0                	jne    80105d90 <sys_pipe+0x40>
80105da0:	83 ec 0c             	sub    $0xc,%esp
80105da3:	ff 75 e0             	push   -0x20(%ebp)
80105da6:	e8 d5 b8 ff ff       	call   80101680 <fileclose>
80105dab:	58                   	pop    %eax
80105dac:	ff 75 e4             	push   -0x1c(%ebp)
80105daf:	e8 cc b8 ff ff       	call   80101680 <fileclose>
80105db4:	83 c4 10             	add    $0x10,%esp
80105db7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105dbc:	eb 53                	jmp    80105e11 <sys_pipe+0xc1>
80105dbe:	66 90                	xchg   %ax,%ax
80105dc0:	8d 73 08             	lea    0x8(%ebx),%esi
80105dc3:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
80105dc7:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80105dca:	e8 31 e3 ff ff       	call   80104100 <myproc>
80105dcf:	31 d2                	xor    %edx,%edx
80105dd1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105dd8:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
80105ddc:	85 c9                	test   %ecx,%ecx
80105dde:	74 20                	je     80105e00 <sys_pipe+0xb0>
80105de0:	83 c2 01             	add    $0x1,%edx
80105de3:	83 fa 10             	cmp    $0x10,%edx
80105de6:	75 f0                	jne    80105dd8 <sys_pipe+0x88>
80105de8:	e8 13 e3 ff ff       	call   80104100 <myproc>
80105ded:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
80105df4:	00 
80105df5:	eb a9                	jmp    80105da0 <sys_pipe+0x50>
80105df7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105dfe:	66 90                	xchg   %ax,%ax
80105e00:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
80105e04:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105e07:	89 18                	mov    %ebx,(%eax)
80105e09:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105e0c:	89 50 04             	mov    %edx,0x4(%eax)
80105e0f:	31 c0                	xor    %eax,%eax
80105e11:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105e14:	5b                   	pop    %ebx
80105e15:	5e                   	pop    %esi
80105e16:	5f                   	pop    %edi
80105e17:	5d                   	pop    %ebp
80105e18:	c3                   	ret    
80105e19:	66 90                	xchg   %ax,%ax
80105e1b:	66 90                	xchg   %ax,%ax
80105e1d:	66 90                	xchg   %ax,%ax
80105e1f:	90                   	nop

80105e20 <sys_fork>:
80105e20:	e9 7b e4 ff ff       	jmp    801042a0 <fork>
80105e25:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105e2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105e30 <sys_exit>:
80105e30:	55                   	push   %ebp
80105e31:	89 e5                	mov    %esp,%ebp
80105e33:	83 ec 08             	sub    $0x8,%esp
80105e36:	e8 e5 e6 ff ff       	call   80104520 <exit>
80105e3b:	31 c0                	xor    %eax,%eax
80105e3d:	c9                   	leave  
80105e3e:	c3                   	ret    
80105e3f:	90                   	nop

80105e40 <sys_wait>:
80105e40:	e9 0b e8 ff ff       	jmp    80104650 <wait>
80105e45:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105e4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105e50 <sys_kill>:
80105e50:	55                   	push   %ebp
80105e51:	89 e5                	mov    %esp,%ebp
80105e53:	83 ec 20             	sub    $0x20,%esp
80105e56:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105e59:	50                   	push   %eax
80105e5a:	6a 00                	push   $0x0
80105e5c:	e8 4f f2 ff ff       	call   801050b0 <argint>
80105e61:	83 c4 10             	add    $0x10,%esp
80105e64:	85 c0                	test   %eax,%eax
80105e66:	78 18                	js     80105e80 <sys_kill+0x30>
80105e68:	83 ec 0c             	sub    $0xc,%esp
80105e6b:	ff 75 f4             	push   -0xc(%ebp)
80105e6e:	e8 7d ea ff ff       	call   801048f0 <kill>
80105e73:	83 c4 10             	add    $0x10,%esp
80105e76:	c9                   	leave  
80105e77:	c3                   	ret    
80105e78:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105e7f:	90                   	nop
80105e80:	c9                   	leave  
80105e81:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105e86:	c3                   	ret    
80105e87:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105e8e:	66 90                	xchg   %ax,%ax

80105e90 <sys_getpid>:
80105e90:	55                   	push   %ebp
80105e91:	89 e5                	mov    %esp,%ebp
80105e93:	83 ec 08             	sub    $0x8,%esp
80105e96:	e8 65 e2 ff ff       	call   80104100 <myproc>
80105e9b:	8b 40 10             	mov    0x10(%eax),%eax
80105e9e:	c9                   	leave  
80105e9f:	c3                   	ret    

80105ea0 <sys_sbrk>:
80105ea0:	55                   	push   %ebp
80105ea1:	89 e5                	mov    %esp,%ebp
80105ea3:	53                   	push   %ebx
80105ea4:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105ea7:	83 ec 1c             	sub    $0x1c,%esp
80105eaa:	50                   	push   %eax
80105eab:	6a 00                	push   $0x0
80105ead:	e8 fe f1 ff ff       	call   801050b0 <argint>
80105eb2:	83 c4 10             	add    $0x10,%esp
80105eb5:	85 c0                	test   %eax,%eax
80105eb7:	78 27                	js     80105ee0 <sys_sbrk+0x40>
80105eb9:	e8 42 e2 ff ff       	call   80104100 <myproc>
80105ebe:	83 ec 0c             	sub    $0xc,%esp
80105ec1:	8b 18                	mov    (%eax),%ebx
80105ec3:	ff 75 f4             	push   -0xc(%ebp)
80105ec6:	e8 55 e3 ff ff       	call   80104220 <growproc>
80105ecb:	83 c4 10             	add    $0x10,%esp
80105ece:	85 c0                	test   %eax,%eax
80105ed0:	78 0e                	js     80105ee0 <sys_sbrk+0x40>
80105ed2:	89 d8                	mov    %ebx,%eax
80105ed4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105ed7:	c9                   	leave  
80105ed8:	c3                   	ret    
80105ed9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105ee0:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105ee5:	eb eb                	jmp    80105ed2 <sys_sbrk+0x32>
80105ee7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105eee:	66 90                	xchg   %ax,%ax

80105ef0 <sys_sleep>:
80105ef0:	55                   	push   %ebp
80105ef1:	89 e5                	mov    %esp,%ebp
80105ef3:	53                   	push   %ebx
80105ef4:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105ef7:	83 ec 1c             	sub    $0x1c,%esp
80105efa:	50                   	push   %eax
80105efb:	6a 00                	push   $0x0
80105efd:	e8 ae f1 ff ff       	call   801050b0 <argint>
80105f02:	83 c4 10             	add    $0x10,%esp
80105f05:	85 c0                	test   %eax,%eax
80105f07:	0f 88 8a 00 00 00    	js     80105f97 <sys_sleep+0xa7>
80105f0d:	83 ec 0c             	sub    $0xc,%esp
80105f10:	68 c0 58 11 80       	push   $0x801158c0
80105f15:	e8 16 ee ff ff       	call   80104d30 <acquire>
80105f1a:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105f1d:	8b 1d a0 58 11 80    	mov    0x801158a0,%ebx
80105f23:	83 c4 10             	add    $0x10,%esp
80105f26:	85 d2                	test   %edx,%edx
80105f28:	75 27                	jne    80105f51 <sys_sleep+0x61>
80105f2a:	eb 54                	jmp    80105f80 <sys_sleep+0x90>
80105f2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105f30:	83 ec 08             	sub    $0x8,%esp
80105f33:	68 c0 58 11 80       	push   $0x801158c0
80105f38:	68 a0 58 11 80       	push   $0x801158a0
80105f3d:	e8 8e e8 ff ff       	call   801047d0 <sleep>
80105f42:	a1 a0 58 11 80       	mov    0x801158a0,%eax
80105f47:	83 c4 10             	add    $0x10,%esp
80105f4a:	29 d8                	sub    %ebx,%eax
80105f4c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80105f4f:	73 2f                	jae    80105f80 <sys_sleep+0x90>
80105f51:	e8 aa e1 ff ff       	call   80104100 <myproc>
80105f56:	8b 40 24             	mov    0x24(%eax),%eax
80105f59:	85 c0                	test   %eax,%eax
80105f5b:	74 d3                	je     80105f30 <sys_sleep+0x40>
80105f5d:	83 ec 0c             	sub    $0xc,%esp
80105f60:	68 c0 58 11 80       	push   $0x801158c0
80105f65:	e8 66 ed ff ff       	call   80104cd0 <release>
80105f6a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105f6d:	83 c4 10             	add    $0x10,%esp
80105f70:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105f75:	c9                   	leave  
80105f76:	c3                   	ret    
80105f77:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105f7e:	66 90                	xchg   %ax,%ax
80105f80:	83 ec 0c             	sub    $0xc,%esp
80105f83:	68 c0 58 11 80       	push   $0x801158c0
80105f88:	e8 43 ed ff ff       	call   80104cd0 <release>
80105f8d:	83 c4 10             	add    $0x10,%esp
80105f90:	31 c0                	xor    %eax,%eax
80105f92:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105f95:	c9                   	leave  
80105f96:	c3                   	ret    
80105f97:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105f9c:	eb f4                	jmp    80105f92 <sys_sleep+0xa2>
80105f9e:	66 90                	xchg   %ax,%ax

80105fa0 <sys_uptime>:
80105fa0:	55                   	push   %ebp
80105fa1:	89 e5                	mov    %esp,%ebp
80105fa3:	53                   	push   %ebx
80105fa4:	83 ec 10             	sub    $0x10,%esp
80105fa7:	68 c0 58 11 80       	push   $0x801158c0
80105fac:	e8 7f ed ff ff       	call   80104d30 <acquire>
80105fb1:	8b 1d a0 58 11 80    	mov    0x801158a0,%ebx
80105fb7:	c7 04 24 c0 58 11 80 	movl   $0x801158c0,(%esp)
80105fbe:	e8 0d ed ff ff       	call   80104cd0 <release>
80105fc3:	89 d8                	mov    %ebx,%eax
80105fc5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105fc8:	c9                   	leave  
80105fc9:	c3                   	ret    

80105fca <alltraps>:
80105fca:	1e                   	push   %ds
80105fcb:	06                   	push   %es
80105fcc:	0f a0                	push   %fs
80105fce:	0f a8                	push   %gs
80105fd0:	60                   	pusha  
80105fd1:	66 b8 10 00          	mov    $0x10,%ax
80105fd5:	8e d8                	mov    %eax,%ds
80105fd7:	8e c0                	mov    %eax,%es
80105fd9:	54                   	push   %esp
80105fda:	e8 c1 00 00 00       	call   801060a0 <trap>
80105fdf:	83 c4 04             	add    $0x4,%esp

80105fe2 <trapret>:
80105fe2:	61                   	popa   
80105fe3:	0f a9                	pop    %gs
80105fe5:	0f a1                	pop    %fs
80105fe7:	07                   	pop    %es
80105fe8:	1f                   	pop    %ds
80105fe9:	83 c4 08             	add    $0x8,%esp
80105fec:	cf                   	iret   
80105fed:	66 90                	xchg   %ax,%ax
80105fef:	90                   	nop

80105ff0 <tvinit>:
80105ff0:	55                   	push   %ebp
80105ff1:	31 c0                	xor    %eax,%eax
80105ff3:	89 e5                	mov    %esp,%ebp
80105ff5:	83 ec 08             	sub    $0x8,%esp
80105ff8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105fff:	90                   	nop
80106000:	8b 14 85 08 b0 10 80 	mov    -0x7fef4ff8(,%eax,4),%edx
80106007:	c7 04 c5 02 59 11 80 	movl   $0x8e000008,-0x7feea6fe(,%eax,8)
8010600e:	08 00 00 8e 
80106012:	66 89 14 c5 00 59 11 	mov    %dx,-0x7feea700(,%eax,8)
80106019:	80 
8010601a:	c1 ea 10             	shr    $0x10,%edx
8010601d:	66 89 14 c5 06 59 11 	mov    %dx,-0x7feea6fa(,%eax,8)
80106024:	80 
80106025:	83 c0 01             	add    $0x1,%eax
80106028:	3d 00 01 00 00       	cmp    $0x100,%eax
8010602d:	75 d1                	jne    80106000 <tvinit+0x10>
8010602f:	83 ec 08             	sub    $0x8,%esp
80106032:	a1 08 b1 10 80       	mov    0x8010b108,%eax
80106037:	c7 05 02 5b 11 80 08 	movl   $0xef000008,0x80115b02
8010603e:	00 00 ef 
80106041:	68 f9 80 10 80       	push   $0x801080f9
80106046:	68 c0 58 11 80       	push   $0x801158c0
8010604b:	66 a3 00 5b 11 80    	mov    %ax,0x80115b00
80106051:	c1 e8 10             	shr    $0x10,%eax
80106054:	66 a3 06 5b 11 80    	mov    %ax,0x80115b06
8010605a:	e8 01 eb ff ff       	call   80104b60 <initlock>
8010605f:	83 c4 10             	add    $0x10,%esp
80106062:	c9                   	leave  
80106063:	c3                   	ret    
80106064:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010606b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010606f:	90                   	nop

80106070 <idtinit>:
80106070:	55                   	push   %ebp
80106071:	b8 ff 07 00 00       	mov    $0x7ff,%eax
80106076:	89 e5                	mov    %esp,%ebp
80106078:	83 ec 10             	sub    $0x10,%esp
8010607b:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
8010607f:	b8 00 59 11 80       	mov    $0x80115900,%eax
80106084:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
80106088:	c1 e8 10             	shr    $0x10,%eax
8010608b:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
8010608f:	8d 45 fa             	lea    -0x6(%ebp),%eax
80106092:	0f 01 18             	lidtl  (%eax)
80106095:	c9                   	leave  
80106096:	c3                   	ret    
80106097:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010609e:	66 90                	xchg   %ax,%ax

801060a0 <trap>:
801060a0:	55                   	push   %ebp
801060a1:	89 e5                	mov    %esp,%ebp
801060a3:	57                   	push   %edi
801060a4:	56                   	push   %esi
801060a5:	53                   	push   %ebx
801060a6:	83 ec 1c             	sub    $0x1c,%esp
801060a9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801060ac:	8b 43 30             	mov    0x30(%ebx),%eax
801060af:	83 f8 40             	cmp    $0x40,%eax
801060b2:	0f 84 68 01 00 00    	je     80106220 <trap+0x180>
801060b8:	83 e8 20             	sub    $0x20,%eax
801060bb:	83 f8 1f             	cmp    $0x1f,%eax
801060be:	0f 87 8c 00 00 00    	ja     80106150 <trap+0xb0>
801060c4:	ff 24 85 a0 81 10 80 	jmp    *-0x7fef7e60(,%eax,4)
801060cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801060cf:	90                   	nop
801060d0:	e8 fb c8 ff ff       	call   801029d0 <ideintr>
801060d5:	e8 c6 cf ff ff       	call   801030a0 <lapiceoi>
801060da:	e8 21 e0 ff ff       	call   80104100 <myproc>
801060df:	85 c0                	test   %eax,%eax
801060e1:	74 1d                	je     80106100 <trap+0x60>
801060e3:	e8 18 e0 ff ff       	call   80104100 <myproc>
801060e8:	8b 50 24             	mov    0x24(%eax),%edx
801060eb:	85 d2                	test   %edx,%edx
801060ed:	74 11                	je     80106100 <trap+0x60>
801060ef:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
801060f3:	83 e0 03             	and    $0x3,%eax
801060f6:	66 83 f8 03          	cmp    $0x3,%ax
801060fa:	0f 84 e8 01 00 00    	je     801062e8 <trap+0x248>
80106100:	e8 fb df ff ff       	call   80104100 <myproc>
80106105:	85 c0                	test   %eax,%eax
80106107:	74 0f                	je     80106118 <trap+0x78>
80106109:	e8 f2 df ff ff       	call   80104100 <myproc>
8010610e:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80106112:	0f 84 b8 00 00 00    	je     801061d0 <trap+0x130>
80106118:	e8 e3 df ff ff       	call   80104100 <myproc>
8010611d:	85 c0                	test   %eax,%eax
8010611f:	74 1d                	je     8010613e <trap+0x9e>
80106121:	e8 da df ff ff       	call   80104100 <myproc>
80106126:	8b 40 24             	mov    0x24(%eax),%eax
80106129:	85 c0                	test   %eax,%eax
8010612b:	74 11                	je     8010613e <trap+0x9e>
8010612d:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80106131:	83 e0 03             	and    $0x3,%eax
80106134:	66 83 f8 03          	cmp    $0x3,%ax
80106138:	0f 84 0f 01 00 00    	je     8010624d <trap+0x1ad>
8010613e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106141:	5b                   	pop    %ebx
80106142:	5e                   	pop    %esi
80106143:	5f                   	pop    %edi
80106144:	5d                   	pop    %ebp
80106145:	c3                   	ret    
80106146:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010614d:	8d 76 00             	lea    0x0(%esi),%esi
80106150:	e8 ab df ff ff       	call   80104100 <myproc>
80106155:	8b 7b 38             	mov    0x38(%ebx),%edi
80106158:	85 c0                	test   %eax,%eax
8010615a:	0f 84 a2 01 00 00    	je     80106302 <trap+0x262>
80106160:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
80106164:	0f 84 98 01 00 00    	je     80106302 <trap+0x262>
8010616a:	0f 20 d1             	mov    %cr2,%ecx
8010616d:	89 4d d8             	mov    %ecx,-0x28(%ebp)
80106170:	e8 6b df ff ff       	call   801040e0 <cpuid>
80106175:	8b 73 30             	mov    0x30(%ebx),%esi
80106178:	89 45 dc             	mov    %eax,-0x24(%ebp)
8010617b:	8b 43 34             	mov    0x34(%ebx),%eax
8010617e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106181:	e8 7a df ff ff       	call   80104100 <myproc>
80106186:	89 45 e0             	mov    %eax,-0x20(%ebp)
80106189:	e8 72 df ff ff       	call   80104100 <myproc>
8010618e:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80106191:	8b 55 dc             	mov    -0x24(%ebp),%edx
80106194:	51                   	push   %ecx
80106195:	57                   	push   %edi
80106196:	52                   	push   %edx
80106197:	ff 75 e4             	push   -0x1c(%ebp)
8010619a:	56                   	push   %esi
8010619b:	8b 75 e0             	mov    -0x20(%ebp),%esi
8010619e:	83 c6 6c             	add    $0x6c,%esi
801061a1:	56                   	push   %esi
801061a2:	ff 70 10             	push   0x10(%eax)
801061a5:	68 5c 81 10 80       	push   $0x8010815c
801061aa:	e8 a1 a5 ff ff       	call   80100750 <cprintf>
801061af:	83 c4 20             	add    $0x20,%esp
801061b2:	e8 49 df ff ff       	call   80104100 <myproc>
801061b7:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
801061be:	e8 3d df ff ff       	call   80104100 <myproc>
801061c3:	85 c0                	test   %eax,%eax
801061c5:	0f 85 18 ff ff ff    	jne    801060e3 <trap+0x43>
801061cb:	e9 30 ff ff ff       	jmp    80106100 <trap+0x60>
801061d0:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
801061d4:	0f 85 3e ff ff ff    	jne    80106118 <trap+0x78>
801061da:	e8 a1 e5 ff ff       	call   80104780 <yield>
801061df:	e9 34 ff ff ff       	jmp    80106118 <trap+0x78>
801061e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801061e8:	8b 7b 38             	mov    0x38(%ebx),%edi
801061eb:	0f b7 73 3c          	movzwl 0x3c(%ebx),%esi
801061ef:	e8 ec de ff ff       	call   801040e0 <cpuid>
801061f4:	57                   	push   %edi
801061f5:	56                   	push   %esi
801061f6:	50                   	push   %eax
801061f7:	68 04 81 10 80       	push   $0x80108104
801061fc:	e8 4f a5 ff ff       	call   80100750 <cprintf>
80106201:	e8 9a ce ff ff       	call   801030a0 <lapiceoi>
80106206:	83 c4 10             	add    $0x10,%esp
80106209:	e8 f2 de ff ff       	call   80104100 <myproc>
8010620e:	85 c0                	test   %eax,%eax
80106210:	0f 85 cd fe ff ff    	jne    801060e3 <trap+0x43>
80106216:	e9 e5 fe ff ff       	jmp    80106100 <trap+0x60>
8010621b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010621f:	90                   	nop
80106220:	e8 db de ff ff       	call   80104100 <myproc>
80106225:	8b 70 24             	mov    0x24(%eax),%esi
80106228:	85 f6                	test   %esi,%esi
8010622a:	0f 85 c8 00 00 00    	jne    801062f8 <trap+0x258>
80106230:	e8 cb de ff ff       	call   80104100 <myproc>
80106235:	89 58 18             	mov    %ebx,0x18(%eax)
80106238:	e8 b3 ef ff ff       	call   801051f0 <syscall>
8010623d:	e8 be de ff ff       	call   80104100 <myproc>
80106242:	8b 48 24             	mov    0x24(%eax),%ecx
80106245:	85 c9                	test   %ecx,%ecx
80106247:	0f 84 f1 fe ff ff    	je     8010613e <trap+0x9e>
8010624d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106250:	5b                   	pop    %ebx
80106251:	5e                   	pop    %esi
80106252:	5f                   	pop    %edi
80106253:	5d                   	pop    %ebp
80106254:	e9 c7 e2 ff ff       	jmp    80104520 <exit>
80106259:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106260:	e8 3b 02 00 00       	call   801064a0 <uartintr>
80106265:	e8 36 ce ff ff       	call   801030a0 <lapiceoi>
8010626a:	e8 91 de ff ff       	call   80104100 <myproc>
8010626f:	85 c0                	test   %eax,%eax
80106271:	0f 85 6c fe ff ff    	jne    801060e3 <trap+0x43>
80106277:	e9 84 fe ff ff       	jmp    80106100 <trap+0x60>
8010627c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106280:	e8 db cc ff ff       	call   80102f60 <kbdintr>
80106285:	e8 16 ce ff ff       	call   801030a0 <lapiceoi>
8010628a:	e8 71 de ff ff       	call   80104100 <myproc>
8010628f:	85 c0                	test   %eax,%eax
80106291:	0f 85 4c fe ff ff    	jne    801060e3 <trap+0x43>
80106297:	e9 64 fe ff ff       	jmp    80106100 <trap+0x60>
8010629c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801062a0:	e8 3b de ff ff       	call   801040e0 <cpuid>
801062a5:	85 c0                	test   %eax,%eax
801062a7:	0f 85 28 fe ff ff    	jne    801060d5 <trap+0x35>
801062ad:	83 ec 0c             	sub    $0xc,%esp
801062b0:	68 c0 58 11 80       	push   $0x801158c0
801062b5:	e8 76 ea ff ff       	call   80104d30 <acquire>
801062ba:	c7 04 24 a0 58 11 80 	movl   $0x801158a0,(%esp)
801062c1:	83 05 a0 58 11 80 01 	addl   $0x1,0x801158a0
801062c8:	e8 c3 e5 ff ff       	call   80104890 <wakeup>
801062cd:	c7 04 24 c0 58 11 80 	movl   $0x801158c0,(%esp)
801062d4:	e8 f7 e9 ff ff       	call   80104cd0 <release>
801062d9:	83 c4 10             	add    $0x10,%esp
801062dc:	e9 f4 fd ff ff       	jmp    801060d5 <trap+0x35>
801062e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801062e8:	e8 33 e2 ff ff       	call   80104520 <exit>
801062ed:	e9 0e fe ff ff       	jmp    80106100 <trap+0x60>
801062f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801062f8:	e8 23 e2 ff ff       	call   80104520 <exit>
801062fd:	e9 2e ff ff ff       	jmp    80106230 <trap+0x190>
80106302:	0f 20 d6             	mov    %cr2,%esi
80106305:	e8 d6 dd ff ff       	call   801040e0 <cpuid>
8010630a:	83 ec 0c             	sub    $0xc,%esp
8010630d:	56                   	push   %esi
8010630e:	57                   	push   %edi
8010630f:	50                   	push   %eax
80106310:	ff 73 30             	push   0x30(%ebx)
80106313:	68 28 81 10 80       	push   $0x80108128
80106318:	e8 33 a4 ff ff       	call   80100750 <cprintf>
8010631d:	83 c4 14             	add    $0x14,%esp
80106320:	68 fe 80 10 80       	push   $0x801080fe
80106325:	e8 76 a0 ff ff       	call   801003a0 <panic>
8010632a:	66 90                	xchg   %ax,%ax
8010632c:	66 90                	xchg   %ax,%ax
8010632e:	66 90                	xchg   %ax,%ax

80106330 <uartgetc>:
80106330:	a1 00 61 11 80       	mov    0x80116100,%eax
80106335:	85 c0                	test   %eax,%eax
80106337:	74 17                	je     80106350 <uartgetc+0x20>
80106339:	ba fd 03 00 00       	mov    $0x3fd,%edx
8010633e:	ec                   	in     (%dx),%al
8010633f:	a8 01                	test   $0x1,%al
80106341:	74 0d                	je     80106350 <uartgetc+0x20>
80106343:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106348:	ec                   	in     (%dx),%al
80106349:	0f b6 c0             	movzbl %al,%eax
8010634c:	c3                   	ret    
8010634d:	8d 76 00             	lea    0x0(%esi),%esi
80106350:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106355:	c3                   	ret    
80106356:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010635d:	8d 76 00             	lea    0x0(%esi),%esi

80106360 <uartinit>:
80106360:	55                   	push   %ebp
80106361:	31 c9                	xor    %ecx,%ecx
80106363:	89 c8                	mov    %ecx,%eax
80106365:	89 e5                	mov    %esp,%ebp
80106367:	57                   	push   %edi
80106368:	bf fa 03 00 00       	mov    $0x3fa,%edi
8010636d:	56                   	push   %esi
8010636e:	89 fa                	mov    %edi,%edx
80106370:	53                   	push   %ebx
80106371:	83 ec 1c             	sub    $0x1c,%esp
80106374:	ee                   	out    %al,(%dx)
80106375:	be fb 03 00 00       	mov    $0x3fb,%esi
8010637a:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
8010637f:	89 f2                	mov    %esi,%edx
80106381:	ee                   	out    %al,(%dx)
80106382:	b8 0c 00 00 00       	mov    $0xc,%eax
80106387:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010638c:	ee                   	out    %al,(%dx)
8010638d:	bb f9 03 00 00       	mov    $0x3f9,%ebx
80106392:	89 c8                	mov    %ecx,%eax
80106394:	89 da                	mov    %ebx,%edx
80106396:	ee                   	out    %al,(%dx)
80106397:	b8 03 00 00 00       	mov    $0x3,%eax
8010639c:	89 f2                	mov    %esi,%edx
8010639e:	ee                   	out    %al,(%dx)
8010639f:	ba fc 03 00 00       	mov    $0x3fc,%edx
801063a4:	89 c8                	mov    %ecx,%eax
801063a6:	ee                   	out    %al,(%dx)
801063a7:	b8 01 00 00 00       	mov    $0x1,%eax
801063ac:	89 da                	mov    %ebx,%edx
801063ae:	ee                   	out    %al,(%dx)
801063af:	ba fd 03 00 00       	mov    $0x3fd,%edx
801063b4:	ec                   	in     (%dx),%al
801063b5:	3c ff                	cmp    $0xff,%al
801063b7:	74 78                	je     80106431 <uartinit+0xd1>
801063b9:	c7 05 00 61 11 80 01 	movl   $0x1,0x80116100
801063c0:	00 00 00 
801063c3:	89 fa                	mov    %edi,%edx
801063c5:	ec                   	in     (%dx),%al
801063c6:	ba f8 03 00 00       	mov    $0x3f8,%edx
801063cb:	ec                   	in     (%dx),%al
801063cc:	83 ec 08             	sub    $0x8,%esp
801063cf:	bf 20 82 10 80       	mov    $0x80108220,%edi
801063d4:	be fd 03 00 00       	mov    $0x3fd,%esi
801063d9:	6a 00                	push   $0x0
801063db:	6a 04                	push   $0x4
801063dd:	e8 2e c8 ff ff       	call   80102c10 <ioapicenable>
801063e2:	c6 45 e7 78          	movb   $0x78,-0x19(%ebp)
801063e6:	83 c4 10             	add    $0x10,%esp
801063e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801063f0:	a1 00 61 11 80       	mov    0x80116100,%eax
801063f5:	bb 80 00 00 00       	mov    $0x80,%ebx
801063fa:	85 c0                	test   %eax,%eax
801063fc:	75 14                	jne    80106412 <uartinit+0xb2>
801063fe:	eb 23                	jmp    80106423 <uartinit+0xc3>
80106400:	83 ec 0c             	sub    $0xc,%esp
80106403:	6a 0a                	push   $0xa
80106405:	e8 b6 cc ff ff       	call   801030c0 <microdelay>
8010640a:	83 c4 10             	add    $0x10,%esp
8010640d:	83 eb 01             	sub    $0x1,%ebx
80106410:	74 07                	je     80106419 <uartinit+0xb9>
80106412:	89 f2                	mov    %esi,%edx
80106414:	ec                   	in     (%dx),%al
80106415:	a8 20                	test   $0x20,%al
80106417:	74 e7                	je     80106400 <uartinit+0xa0>
80106419:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
8010641d:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106422:	ee                   	out    %al,(%dx)
80106423:	0f b6 47 01          	movzbl 0x1(%edi),%eax
80106427:	83 c7 01             	add    $0x1,%edi
8010642a:	88 45 e7             	mov    %al,-0x19(%ebp)
8010642d:	84 c0                	test   %al,%al
8010642f:	75 bf                	jne    801063f0 <uartinit+0x90>
80106431:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106434:	5b                   	pop    %ebx
80106435:	5e                   	pop    %esi
80106436:	5f                   	pop    %edi
80106437:	5d                   	pop    %ebp
80106438:	c3                   	ret    
80106439:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106440 <uartputc>:
80106440:	a1 00 61 11 80       	mov    0x80116100,%eax
80106445:	85 c0                	test   %eax,%eax
80106447:	74 47                	je     80106490 <uartputc+0x50>
80106449:	55                   	push   %ebp
8010644a:	89 e5                	mov    %esp,%ebp
8010644c:	56                   	push   %esi
8010644d:	be fd 03 00 00       	mov    $0x3fd,%esi
80106452:	53                   	push   %ebx
80106453:	bb 80 00 00 00       	mov    $0x80,%ebx
80106458:	eb 18                	jmp    80106472 <uartputc+0x32>
8010645a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106460:	83 ec 0c             	sub    $0xc,%esp
80106463:	6a 0a                	push   $0xa
80106465:	e8 56 cc ff ff       	call   801030c0 <microdelay>
8010646a:	83 c4 10             	add    $0x10,%esp
8010646d:	83 eb 01             	sub    $0x1,%ebx
80106470:	74 07                	je     80106479 <uartputc+0x39>
80106472:	89 f2                	mov    %esi,%edx
80106474:	ec                   	in     (%dx),%al
80106475:	a8 20                	test   $0x20,%al
80106477:	74 e7                	je     80106460 <uartputc+0x20>
80106479:	8b 45 08             	mov    0x8(%ebp),%eax
8010647c:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106481:	ee                   	out    %al,(%dx)
80106482:	8d 65 f8             	lea    -0x8(%ebp),%esp
80106485:	5b                   	pop    %ebx
80106486:	5e                   	pop    %esi
80106487:	5d                   	pop    %ebp
80106488:	c3                   	ret    
80106489:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106490:	c3                   	ret    
80106491:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106498:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010649f:	90                   	nop

801064a0 <uartintr>:
801064a0:	55                   	push   %ebp
801064a1:	89 e5                	mov    %esp,%ebp
801064a3:	83 ec 14             	sub    $0x14,%esp
801064a6:	68 30 63 10 80       	push   $0x80106330
801064ab:	e8 60 a9 ff ff       	call   80100e10 <consoleintr>
801064b0:	83 c4 10             	add    $0x10,%esp
801064b3:	c9                   	leave  
801064b4:	c3                   	ret    

801064b5 <vector0>:
801064b5:	6a 00                	push   $0x0
801064b7:	6a 00                	push   $0x0
801064b9:	e9 0c fb ff ff       	jmp    80105fca <alltraps>

801064be <vector1>:
801064be:	6a 00                	push   $0x0
801064c0:	6a 01                	push   $0x1
801064c2:	e9 03 fb ff ff       	jmp    80105fca <alltraps>

801064c7 <vector2>:
801064c7:	6a 00                	push   $0x0
801064c9:	6a 02                	push   $0x2
801064cb:	e9 fa fa ff ff       	jmp    80105fca <alltraps>

801064d0 <vector3>:
801064d0:	6a 00                	push   $0x0
801064d2:	6a 03                	push   $0x3
801064d4:	e9 f1 fa ff ff       	jmp    80105fca <alltraps>

801064d9 <vector4>:
801064d9:	6a 00                	push   $0x0
801064db:	6a 04                	push   $0x4
801064dd:	e9 e8 fa ff ff       	jmp    80105fca <alltraps>

801064e2 <vector5>:
801064e2:	6a 00                	push   $0x0
801064e4:	6a 05                	push   $0x5
801064e6:	e9 df fa ff ff       	jmp    80105fca <alltraps>

801064eb <vector6>:
801064eb:	6a 00                	push   $0x0
801064ed:	6a 06                	push   $0x6
801064ef:	e9 d6 fa ff ff       	jmp    80105fca <alltraps>

801064f4 <vector7>:
801064f4:	6a 00                	push   $0x0
801064f6:	6a 07                	push   $0x7
801064f8:	e9 cd fa ff ff       	jmp    80105fca <alltraps>

801064fd <vector8>:
801064fd:	6a 08                	push   $0x8
801064ff:	e9 c6 fa ff ff       	jmp    80105fca <alltraps>

80106504 <vector9>:
80106504:	6a 00                	push   $0x0
80106506:	6a 09                	push   $0x9
80106508:	e9 bd fa ff ff       	jmp    80105fca <alltraps>

8010650d <vector10>:
8010650d:	6a 0a                	push   $0xa
8010650f:	e9 b6 fa ff ff       	jmp    80105fca <alltraps>

80106514 <vector11>:
80106514:	6a 0b                	push   $0xb
80106516:	e9 af fa ff ff       	jmp    80105fca <alltraps>

8010651b <vector12>:
8010651b:	6a 0c                	push   $0xc
8010651d:	e9 a8 fa ff ff       	jmp    80105fca <alltraps>

80106522 <vector13>:
80106522:	6a 0d                	push   $0xd
80106524:	e9 a1 fa ff ff       	jmp    80105fca <alltraps>

80106529 <vector14>:
80106529:	6a 0e                	push   $0xe
8010652b:	e9 9a fa ff ff       	jmp    80105fca <alltraps>

80106530 <vector15>:
80106530:	6a 00                	push   $0x0
80106532:	6a 0f                	push   $0xf
80106534:	e9 91 fa ff ff       	jmp    80105fca <alltraps>

80106539 <vector16>:
80106539:	6a 00                	push   $0x0
8010653b:	6a 10                	push   $0x10
8010653d:	e9 88 fa ff ff       	jmp    80105fca <alltraps>

80106542 <vector17>:
80106542:	6a 11                	push   $0x11
80106544:	e9 81 fa ff ff       	jmp    80105fca <alltraps>

80106549 <vector18>:
80106549:	6a 00                	push   $0x0
8010654b:	6a 12                	push   $0x12
8010654d:	e9 78 fa ff ff       	jmp    80105fca <alltraps>

80106552 <vector19>:
80106552:	6a 00                	push   $0x0
80106554:	6a 13                	push   $0x13
80106556:	e9 6f fa ff ff       	jmp    80105fca <alltraps>

8010655b <vector20>:
8010655b:	6a 00                	push   $0x0
8010655d:	6a 14                	push   $0x14
8010655f:	e9 66 fa ff ff       	jmp    80105fca <alltraps>

80106564 <vector21>:
80106564:	6a 00                	push   $0x0
80106566:	6a 15                	push   $0x15
80106568:	e9 5d fa ff ff       	jmp    80105fca <alltraps>

8010656d <vector22>:
8010656d:	6a 00                	push   $0x0
8010656f:	6a 16                	push   $0x16
80106571:	e9 54 fa ff ff       	jmp    80105fca <alltraps>

80106576 <vector23>:
80106576:	6a 00                	push   $0x0
80106578:	6a 17                	push   $0x17
8010657a:	e9 4b fa ff ff       	jmp    80105fca <alltraps>

8010657f <vector24>:
8010657f:	6a 00                	push   $0x0
80106581:	6a 18                	push   $0x18
80106583:	e9 42 fa ff ff       	jmp    80105fca <alltraps>

80106588 <vector25>:
80106588:	6a 00                	push   $0x0
8010658a:	6a 19                	push   $0x19
8010658c:	e9 39 fa ff ff       	jmp    80105fca <alltraps>

80106591 <vector26>:
80106591:	6a 00                	push   $0x0
80106593:	6a 1a                	push   $0x1a
80106595:	e9 30 fa ff ff       	jmp    80105fca <alltraps>

8010659a <vector27>:
8010659a:	6a 00                	push   $0x0
8010659c:	6a 1b                	push   $0x1b
8010659e:	e9 27 fa ff ff       	jmp    80105fca <alltraps>

801065a3 <vector28>:
801065a3:	6a 00                	push   $0x0
801065a5:	6a 1c                	push   $0x1c
801065a7:	e9 1e fa ff ff       	jmp    80105fca <alltraps>

801065ac <vector29>:
801065ac:	6a 00                	push   $0x0
801065ae:	6a 1d                	push   $0x1d
801065b0:	e9 15 fa ff ff       	jmp    80105fca <alltraps>

801065b5 <vector30>:
801065b5:	6a 00                	push   $0x0
801065b7:	6a 1e                	push   $0x1e
801065b9:	e9 0c fa ff ff       	jmp    80105fca <alltraps>

801065be <vector31>:
801065be:	6a 00                	push   $0x0
801065c0:	6a 1f                	push   $0x1f
801065c2:	e9 03 fa ff ff       	jmp    80105fca <alltraps>

801065c7 <vector32>:
801065c7:	6a 00                	push   $0x0
801065c9:	6a 20                	push   $0x20
801065cb:	e9 fa f9 ff ff       	jmp    80105fca <alltraps>

801065d0 <vector33>:
801065d0:	6a 00                	push   $0x0
801065d2:	6a 21                	push   $0x21
801065d4:	e9 f1 f9 ff ff       	jmp    80105fca <alltraps>

801065d9 <vector34>:
801065d9:	6a 00                	push   $0x0
801065db:	6a 22                	push   $0x22
801065dd:	e9 e8 f9 ff ff       	jmp    80105fca <alltraps>

801065e2 <vector35>:
801065e2:	6a 00                	push   $0x0
801065e4:	6a 23                	push   $0x23
801065e6:	e9 df f9 ff ff       	jmp    80105fca <alltraps>

801065eb <vector36>:
801065eb:	6a 00                	push   $0x0
801065ed:	6a 24                	push   $0x24
801065ef:	e9 d6 f9 ff ff       	jmp    80105fca <alltraps>

801065f4 <vector37>:
801065f4:	6a 00                	push   $0x0
801065f6:	6a 25                	push   $0x25
801065f8:	e9 cd f9 ff ff       	jmp    80105fca <alltraps>

801065fd <vector38>:
801065fd:	6a 00                	push   $0x0
801065ff:	6a 26                	push   $0x26
80106601:	e9 c4 f9 ff ff       	jmp    80105fca <alltraps>

80106606 <vector39>:
80106606:	6a 00                	push   $0x0
80106608:	6a 27                	push   $0x27
8010660a:	e9 bb f9 ff ff       	jmp    80105fca <alltraps>

8010660f <vector40>:
8010660f:	6a 00                	push   $0x0
80106611:	6a 28                	push   $0x28
80106613:	e9 b2 f9 ff ff       	jmp    80105fca <alltraps>

80106618 <vector41>:
80106618:	6a 00                	push   $0x0
8010661a:	6a 29                	push   $0x29
8010661c:	e9 a9 f9 ff ff       	jmp    80105fca <alltraps>

80106621 <vector42>:
80106621:	6a 00                	push   $0x0
80106623:	6a 2a                	push   $0x2a
80106625:	e9 a0 f9 ff ff       	jmp    80105fca <alltraps>

8010662a <vector43>:
8010662a:	6a 00                	push   $0x0
8010662c:	6a 2b                	push   $0x2b
8010662e:	e9 97 f9 ff ff       	jmp    80105fca <alltraps>

80106633 <vector44>:
80106633:	6a 00                	push   $0x0
80106635:	6a 2c                	push   $0x2c
80106637:	e9 8e f9 ff ff       	jmp    80105fca <alltraps>

8010663c <vector45>:
8010663c:	6a 00                	push   $0x0
8010663e:	6a 2d                	push   $0x2d
80106640:	e9 85 f9 ff ff       	jmp    80105fca <alltraps>

80106645 <vector46>:
80106645:	6a 00                	push   $0x0
80106647:	6a 2e                	push   $0x2e
80106649:	e9 7c f9 ff ff       	jmp    80105fca <alltraps>

8010664e <vector47>:
8010664e:	6a 00                	push   $0x0
80106650:	6a 2f                	push   $0x2f
80106652:	e9 73 f9 ff ff       	jmp    80105fca <alltraps>

80106657 <vector48>:
80106657:	6a 00                	push   $0x0
80106659:	6a 30                	push   $0x30
8010665b:	e9 6a f9 ff ff       	jmp    80105fca <alltraps>

80106660 <vector49>:
80106660:	6a 00                	push   $0x0
80106662:	6a 31                	push   $0x31
80106664:	e9 61 f9 ff ff       	jmp    80105fca <alltraps>

80106669 <vector50>:
80106669:	6a 00                	push   $0x0
8010666b:	6a 32                	push   $0x32
8010666d:	e9 58 f9 ff ff       	jmp    80105fca <alltraps>

80106672 <vector51>:
80106672:	6a 00                	push   $0x0
80106674:	6a 33                	push   $0x33
80106676:	e9 4f f9 ff ff       	jmp    80105fca <alltraps>

8010667b <vector52>:
8010667b:	6a 00                	push   $0x0
8010667d:	6a 34                	push   $0x34
8010667f:	e9 46 f9 ff ff       	jmp    80105fca <alltraps>

80106684 <vector53>:
80106684:	6a 00                	push   $0x0
80106686:	6a 35                	push   $0x35
80106688:	e9 3d f9 ff ff       	jmp    80105fca <alltraps>

8010668d <vector54>:
8010668d:	6a 00                	push   $0x0
8010668f:	6a 36                	push   $0x36
80106691:	e9 34 f9 ff ff       	jmp    80105fca <alltraps>

80106696 <vector55>:
80106696:	6a 00                	push   $0x0
80106698:	6a 37                	push   $0x37
8010669a:	e9 2b f9 ff ff       	jmp    80105fca <alltraps>

8010669f <vector56>:
8010669f:	6a 00                	push   $0x0
801066a1:	6a 38                	push   $0x38
801066a3:	e9 22 f9 ff ff       	jmp    80105fca <alltraps>

801066a8 <vector57>:
801066a8:	6a 00                	push   $0x0
801066aa:	6a 39                	push   $0x39
801066ac:	e9 19 f9 ff ff       	jmp    80105fca <alltraps>

801066b1 <vector58>:
801066b1:	6a 00                	push   $0x0
801066b3:	6a 3a                	push   $0x3a
801066b5:	e9 10 f9 ff ff       	jmp    80105fca <alltraps>

801066ba <vector59>:
801066ba:	6a 00                	push   $0x0
801066bc:	6a 3b                	push   $0x3b
801066be:	e9 07 f9 ff ff       	jmp    80105fca <alltraps>

801066c3 <vector60>:
801066c3:	6a 00                	push   $0x0
801066c5:	6a 3c                	push   $0x3c
801066c7:	e9 fe f8 ff ff       	jmp    80105fca <alltraps>

801066cc <vector61>:
801066cc:	6a 00                	push   $0x0
801066ce:	6a 3d                	push   $0x3d
801066d0:	e9 f5 f8 ff ff       	jmp    80105fca <alltraps>

801066d5 <vector62>:
801066d5:	6a 00                	push   $0x0
801066d7:	6a 3e                	push   $0x3e
801066d9:	e9 ec f8 ff ff       	jmp    80105fca <alltraps>

801066de <vector63>:
801066de:	6a 00                	push   $0x0
801066e0:	6a 3f                	push   $0x3f
801066e2:	e9 e3 f8 ff ff       	jmp    80105fca <alltraps>

801066e7 <vector64>:
801066e7:	6a 00                	push   $0x0
801066e9:	6a 40                	push   $0x40
801066eb:	e9 da f8 ff ff       	jmp    80105fca <alltraps>

801066f0 <vector65>:
801066f0:	6a 00                	push   $0x0
801066f2:	6a 41                	push   $0x41
801066f4:	e9 d1 f8 ff ff       	jmp    80105fca <alltraps>

801066f9 <vector66>:
801066f9:	6a 00                	push   $0x0
801066fb:	6a 42                	push   $0x42
801066fd:	e9 c8 f8 ff ff       	jmp    80105fca <alltraps>

80106702 <vector67>:
80106702:	6a 00                	push   $0x0
80106704:	6a 43                	push   $0x43
80106706:	e9 bf f8 ff ff       	jmp    80105fca <alltraps>

8010670b <vector68>:
8010670b:	6a 00                	push   $0x0
8010670d:	6a 44                	push   $0x44
8010670f:	e9 b6 f8 ff ff       	jmp    80105fca <alltraps>

80106714 <vector69>:
80106714:	6a 00                	push   $0x0
80106716:	6a 45                	push   $0x45
80106718:	e9 ad f8 ff ff       	jmp    80105fca <alltraps>

8010671d <vector70>:
8010671d:	6a 00                	push   $0x0
8010671f:	6a 46                	push   $0x46
80106721:	e9 a4 f8 ff ff       	jmp    80105fca <alltraps>

80106726 <vector71>:
80106726:	6a 00                	push   $0x0
80106728:	6a 47                	push   $0x47
8010672a:	e9 9b f8 ff ff       	jmp    80105fca <alltraps>

8010672f <vector72>:
8010672f:	6a 00                	push   $0x0
80106731:	6a 48                	push   $0x48
80106733:	e9 92 f8 ff ff       	jmp    80105fca <alltraps>

80106738 <vector73>:
80106738:	6a 00                	push   $0x0
8010673a:	6a 49                	push   $0x49
8010673c:	e9 89 f8 ff ff       	jmp    80105fca <alltraps>

80106741 <vector74>:
80106741:	6a 00                	push   $0x0
80106743:	6a 4a                	push   $0x4a
80106745:	e9 80 f8 ff ff       	jmp    80105fca <alltraps>

8010674a <vector75>:
8010674a:	6a 00                	push   $0x0
8010674c:	6a 4b                	push   $0x4b
8010674e:	e9 77 f8 ff ff       	jmp    80105fca <alltraps>

80106753 <vector76>:
80106753:	6a 00                	push   $0x0
80106755:	6a 4c                	push   $0x4c
80106757:	e9 6e f8 ff ff       	jmp    80105fca <alltraps>

8010675c <vector77>:
8010675c:	6a 00                	push   $0x0
8010675e:	6a 4d                	push   $0x4d
80106760:	e9 65 f8 ff ff       	jmp    80105fca <alltraps>

80106765 <vector78>:
80106765:	6a 00                	push   $0x0
80106767:	6a 4e                	push   $0x4e
80106769:	e9 5c f8 ff ff       	jmp    80105fca <alltraps>

8010676e <vector79>:
8010676e:	6a 00                	push   $0x0
80106770:	6a 4f                	push   $0x4f
80106772:	e9 53 f8 ff ff       	jmp    80105fca <alltraps>

80106777 <vector80>:
80106777:	6a 00                	push   $0x0
80106779:	6a 50                	push   $0x50
8010677b:	e9 4a f8 ff ff       	jmp    80105fca <alltraps>

80106780 <vector81>:
80106780:	6a 00                	push   $0x0
80106782:	6a 51                	push   $0x51
80106784:	e9 41 f8 ff ff       	jmp    80105fca <alltraps>

80106789 <vector82>:
80106789:	6a 00                	push   $0x0
8010678b:	6a 52                	push   $0x52
8010678d:	e9 38 f8 ff ff       	jmp    80105fca <alltraps>

80106792 <vector83>:
80106792:	6a 00                	push   $0x0
80106794:	6a 53                	push   $0x53
80106796:	e9 2f f8 ff ff       	jmp    80105fca <alltraps>

8010679b <vector84>:
8010679b:	6a 00                	push   $0x0
8010679d:	6a 54                	push   $0x54
8010679f:	e9 26 f8 ff ff       	jmp    80105fca <alltraps>

801067a4 <vector85>:
801067a4:	6a 00                	push   $0x0
801067a6:	6a 55                	push   $0x55
801067a8:	e9 1d f8 ff ff       	jmp    80105fca <alltraps>

801067ad <vector86>:
801067ad:	6a 00                	push   $0x0
801067af:	6a 56                	push   $0x56
801067b1:	e9 14 f8 ff ff       	jmp    80105fca <alltraps>

801067b6 <vector87>:
801067b6:	6a 00                	push   $0x0
801067b8:	6a 57                	push   $0x57
801067ba:	e9 0b f8 ff ff       	jmp    80105fca <alltraps>

801067bf <vector88>:
801067bf:	6a 00                	push   $0x0
801067c1:	6a 58                	push   $0x58
801067c3:	e9 02 f8 ff ff       	jmp    80105fca <alltraps>

801067c8 <vector89>:
801067c8:	6a 00                	push   $0x0
801067ca:	6a 59                	push   $0x59
801067cc:	e9 f9 f7 ff ff       	jmp    80105fca <alltraps>

801067d1 <vector90>:
801067d1:	6a 00                	push   $0x0
801067d3:	6a 5a                	push   $0x5a
801067d5:	e9 f0 f7 ff ff       	jmp    80105fca <alltraps>

801067da <vector91>:
801067da:	6a 00                	push   $0x0
801067dc:	6a 5b                	push   $0x5b
801067de:	e9 e7 f7 ff ff       	jmp    80105fca <alltraps>

801067e3 <vector92>:
801067e3:	6a 00                	push   $0x0
801067e5:	6a 5c                	push   $0x5c
801067e7:	e9 de f7 ff ff       	jmp    80105fca <alltraps>

801067ec <vector93>:
801067ec:	6a 00                	push   $0x0
801067ee:	6a 5d                	push   $0x5d
801067f0:	e9 d5 f7 ff ff       	jmp    80105fca <alltraps>

801067f5 <vector94>:
801067f5:	6a 00                	push   $0x0
801067f7:	6a 5e                	push   $0x5e
801067f9:	e9 cc f7 ff ff       	jmp    80105fca <alltraps>

801067fe <vector95>:
801067fe:	6a 00                	push   $0x0
80106800:	6a 5f                	push   $0x5f
80106802:	e9 c3 f7 ff ff       	jmp    80105fca <alltraps>

80106807 <vector96>:
80106807:	6a 00                	push   $0x0
80106809:	6a 60                	push   $0x60
8010680b:	e9 ba f7 ff ff       	jmp    80105fca <alltraps>

80106810 <vector97>:
80106810:	6a 00                	push   $0x0
80106812:	6a 61                	push   $0x61
80106814:	e9 b1 f7 ff ff       	jmp    80105fca <alltraps>

80106819 <vector98>:
80106819:	6a 00                	push   $0x0
8010681b:	6a 62                	push   $0x62
8010681d:	e9 a8 f7 ff ff       	jmp    80105fca <alltraps>

80106822 <vector99>:
80106822:	6a 00                	push   $0x0
80106824:	6a 63                	push   $0x63
80106826:	e9 9f f7 ff ff       	jmp    80105fca <alltraps>

8010682b <vector100>:
8010682b:	6a 00                	push   $0x0
8010682d:	6a 64                	push   $0x64
8010682f:	e9 96 f7 ff ff       	jmp    80105fca <alltraps>

80106834 <vector101>:
80106834:	6a 00                	push   $0x0
80106836:	6a 65                	push   $0x65
80106838:	e9 8d f7 ff ff       	jmp    80105fca <alltraps>

8010683d <vector102>:
8010683d:	6a 00                	push   $0x0
8010683f:	6a 66                	push   $0x66
80106841:	e9 84 f7 ff ff       	jmp    80105fca <alltraps>

80106846 <vector103>:
80106846:	6a 00                	push   $0x0
80106848:	6a 67                	push   $0x67
8010684a:	e9 7b f7 ff ff       	jmp    80105fca <alltraps>

8010684f <vector104>:
8010684f:	6a 00                	push   $0x0
80106851:	6a 68                	push   $0x68
80106853:	e9 72 f7 ff ff       	jmp    80105fca <alltraps>

80106858 <vector105>:
80106858:	6a 00                	push   $0x0
8010685a:	6a 69                	push   $0x69
8010685c:	e9 69 f7 ff ff       	jmp    80105fca <alltraps>

80106861 <vector106>:
80106861:	6a 00                	push   $0x0
80106863:	6a 6a                	push   $0x6a
80106865:	e9 60 f7 ff ff       	jmp    80105fca <alltraps>

8010686a <vector107>:
8010686a:	6a 00                	push   $0x0
8010686c:	6a 6b                	push   $0x6b
8010686e:	e9 57 f7 ff ff       	jmp    80105fca <alltraps>

80106873 <vector108>:
80106873:	6a 00                	push   $0x0
80106875:	6a 6c                	push   $0x6c
80106877:	e9 4e f7 ff ff       	jmp    80105fca <alltraps>

8010687c <vector109>:
8010687c:	6a 00                	push   $0x0
8010687e:	6a 6d                	push   $0x6d
80106880:	e9 45 f7 ff ff       	jmp    80105fca <alltraps>

80106885 <vector110>:
80106885:	6a 00                	push   $0x0
80106887:	6a 6e                	push   $0x6e
80106889:	e9 3c f7 ff ff       	jmp    80105fca <alltraps>

8010688e <vector111>:
8010688e:	6a 00                	push   $0x0
80106890:	6a 6f                	push   $0x6f
80106892:	e9 33 f7 ff ff       	jmp    80105fca <alltraps>

80106897 <vector112>:
80106897:	6a 00                	push   $0x0
80106899:	6a 70                	push   $0x70
8010689b:	e9 2a f7 ff ff       	jmp    80105fca <alltraps>

801068a0 <vector113>:
801068a0:	6a 00                	push   $0x0
801068a2:	6a 71                	push   $0x71
801068a4:	e9 21 f7 ff ff       	jmp    80105fca <alltraps>

801068a9 <vector114>:
801068a9:	6a 00                	push   $0x0
801068ab:	6a 72                	push   $0x72
801068ad:	e9 18 f7 ff ff       	jmp    80105fca <alltraps>

801068b2 <vector115>:
801068b2:	6a 00                	push   $0x0
801068b4:	6a 73                	push   $0x73
801068b6:	e9 0f f7 ff ff       	jmp    80105fca <alltraps>

801068bb <vector116>:
801068bb:	6a 00                	push   $0x0
801068bd:	6a 74                	push   $0x74
801068bf:	e9 06 f7 ff ff       	jmp    80105fca <alltraps>

801068c4 <vector117>:
801068c4:	6a 00                	push   $0x0
801068c6:	6a 75                	push   $0x75
801068c8:	e9 fd f6 ff ff       	jmp    80105fca <alltraps>

801068cd <vector118>:
801068cd:	6a 00                	push   $0x0
801068cf:	6a 76                	push   $0x76
801068d1:	e9 f4 f6 ff ff       	jmp    80105fca <alltraps>

801068d6 <vector119>:
801068d6:	6a 00                	push   $0x0
801068d8:	6a 77                	push   $0x77
801068da:	e9 eb f6 ff ff       	jmp    80105fca <alltraps>

801068df <vector120>:
801068df:	6a 00                	push   $0x0
801068e1:	6a 78                	push   $0x78
801068e3:	e9 e2 f6 ff ff       	jmp    80105fca <alltraps>

801068e8 <vector121>:
801068e8:	6a 00                	push   $0x0
801068ea:	6a 79                	push   $0x79
801068ec:	e9 d9 f6 ff ff       	jmp    80105fca <alltraps>

801068f1 <vector122>:
801068f1:	6a 00                	push   $0x0
801068f3:	6a 7a                	push   $0x7a
801068f5:	e9 d0 f6 ff ff       	jmp    80105fca <alltraps>

801068fa <vector123>:
801068fa:	6a 00                	push   $0x0
801068fc:	6a 7b                	push   $0x7b
801068fe:	e9 c7 f6 ff ff       	jmp    80105fca <alltraps>

80106903 <vector124>:
80106903:	6a 00                	push   $0x0
80106905:	6a 7c                	push   $0x7c
80106907:	e9 be f6 ff ff       	jmp    80105fca <alltraps>

8010690c <vector125>:
8010690c:	6a 00                	push   $0x0
8010690e:	6a 7d                	push   $0x7d
80106910:	e9 b5 f6 ff ff       	jmp    80105fca <alltraps>

80106915 <vector126>:
80106915:	6a 00                	push   $0x0
80106917:	6a 7e                	push   $0x7e
80106919:	e9 ac f6 ff ff       	jmp    80105fca <alltraps>

8010691e <vector127>:
8010691e:	6a 00                	push   $0x0
80106920:	6a 7f                	push   $0x7f
80106922:	e9 a3 f6 ff ff       	jmp    80105fca <alltraps>

80106927 <vector128>:
80106927:	6a 00                	push   $0x0
80106929:	68 80 00 00 00       	push   $0x80
8010692e:	e9 97 f6 ff ff       	jmp    80105fca <alltraps>

80106933 <vector129>:
80106933:	6a 00                	push   $0x0
80106935:	68 81 00 00 00       	push   $0x81
8010693a:	e9 8b f6 ff ff       	jmp    80105fca <alltraps>

8010693f <vector130>:
8010693f:	6a 00                	push   $0x0
80106941:	68 82 00 00 00       	push   $0x82
80106946:	e9 7f f6 ff ff       	jmp    80105fca <alltraps>

8010694b <vector131>:
8010694b:	6a 00                	push   $0x0
8010694d:	68 83 00 00 00       	push   $0x83
80106952:	e9 73 f6 ff ff       	jmp    80105fca <alltraps>

80106957 <vector132>:
80106957:	6a 00                	push   $0x0
80106959:	68 84 00 00 00       	push   $0x84
8010695e:	e9 67 f6 ff ff       	jmp    80105fca <alltraps>

80106963 <vector133>:
80106963:	6a 00                	push   $0x0
80106965:	68 85 00 00 00       	push   $0x85
8010696a:	e9 5b f6 ff ff       	jmp    80105fca <alltraps>

8010696f <vector134>:
8010696f:	6a 00                	push   $0x0
80106971:	68 86 00 00 00       	push   $0x86
80106976:	e9 4f f6 ff ff       	jmp    80105fca <alltraps>

8010697b <vector135>:
8010697b:	6a 00                	push   $0x0
8010697d:	68 87 00 00 00       	push   $0x87
80106982:	e9 43 f6 ff ff       	jmp    80105fca <alltraps>

80106987 <vector136>:
80106987:	6a 00                	push   $0x0
80106989:	68 88 00 00 00       	push   $0x88
8010698e:	e9 37 f6 ff ff       	jmp    80105fca <alltraps>

80106993 <vector137>:
80106993:	6a 00                	push   $0x0
80106995:	68 89 00 00 00       	push   $0x89
8010699a:	e9 2b f6 ff ff       	jmp    80105fca <alltraps>

8010699f <vector138>:
8010699f:	6a 00                	push   $0x0
801069a1:	68 8a 00 00 00       	push   $0x8a
801069a6:	e9 1f f6 ff ff       	jmp    80105fca <alltraps>

801069ab <vector139>:
801069ab:	6a 00                	push   $0x0
801069ad:	68 8b 00 00 00       	push   $0x8b
801069b2:	e9 13 f6 ff ff       	jmp    80105fca <alltraps>

801069b7 <vector140>:
801069b7:	6a 00                	push   $0x0
801069b9:	68 8c 00 00 00       	push   $0x8c
801069be:	e9 07 f6 ff ff       	jmp    80105fca <alltraps>

801069c3 <vector141>:
801069c3:	6a 00                	push   $0x0
801069c5:	68 8d 00 00 00       	push   $0x8d
801069ca:	e9 fb f5 ff ff       	jmp    80105fca <alltraps>

801069cf <vector142>:
801069cf:	6a 00                	push   $0x0
801069d1:	68 8e 00 00 00       	push   $0x8e
801069d6:	e9 ef f5 ff ff       	jmp    80105fca <alltraps>

801069db <vector143>:
801069db:	6a 00                	push   $0x0
801069dd:	68 8f 00 00 00       	push   $0x8f
801069e2:	e9 e3 f5 ff ff       	jmp    80105fca <alltraps>

801069e7 <vector144>:
801069e7:	6a 00                	push   $0x0
801069e9:	68 90 00 00 00       	push   $0x90
801069ee:	e9 d7 f5 ff ff       	jmp    80105fca <alltraps>

801069f3 <vector145>:
801069f3:	6a 00                	push   $0x0
801069f5:	68 91 00 00 00       	push   $0x91
801069fa:	e9 cb f5 ff ff       	jmp    80105fca <alltraps>

801069ff <vector146>:
801069ff:	6a 00                	push   $0x0
80106a01:	68 92 00 00 00       	push   $0x92
80106a06:	e9 bf f5 ff ff       	jmp    80105fca <alltraps>

80106a0b <vector147>:
80106a0b:	6a 00                	push   $0x0
80106a0d:	68 93 00 00 00       	push   $0x93
80106a12:	e9 b3 f5 ff ff       	jmp    80105fca <alltraps>

80106a17 <vector148>:
80106a17:	6a 00                	push   $0x0
80106a19:	68 94 00 00 00       	push   $0x94
80106a1e:	e9 a7 f5 ff ff       	jmp    80105fca <alltraps>

80106a23 <vector149>:
80106a23:	6a 00                	push   $0x0
80106a25:	68 95 00 00 00       	push   $0x95
80106a2a:	e9 9b f5 ff ff       	jmp    80105fca <alltraps>

80106a2f <vector150>:
80106a2f:	6a 00                	push   $0x0
80106a31:	68 96 00 00 00       	push   $0x96
80106a36:	e9 8f f5 ff ff       	jmp    80105fca <alltraps>

80106a3b <vector151>:
80106a3b:	6a 00                	push   $0x0
80106a3d:	68 97 00 00 00       	push   $0x97
80106a42:	e9 83 f5 ff ff       	jmp    80105fca <alltraps>

80106a47 <vector152>:
80106a47:	6a 00                	push   $0x0
80106a49:	68 98 00 00 00       	push   $0x98
80106a4e:	e9 77 f5 ff ff       	jmp    80105fca <alltraps>

80106a53 <vector153>:
80106a53:	6a 00                	push   $0x0
80106a55:	68 99 00 00 00       	push   $0x99
80106a5a:	e9 6b f5 ff ff       	jmp    80105fca <alltraps>

80106a5f <vector154>:
80106a5f:	6a 00                	push   $0x0
80106a61:	68 9a 00 00 00       	push   $0x9a
80106a66:	e9 5f f5 ff ff       	jmp    80105fca <alltraps>

80106a6b <vector155>:
80106a6b:	6a 00                	push   $0x0
80106a6d:	68 9b 00 00 00       	push   $0x9b
80106a72:	e9 53 f5 ff ff       	jmp    80105fca <alltraps>

80106a77 <vector156>:
80106a77:	6a 00                	push   $0x0
80106a79:	68 9c 00 00 00       	push   $0x9c
80106a7e:	e9 47 f5 ff ff       	jmp    80105fca <alltraps>

80106a83 <vector157>:
80106a83:	6a 00                	push   $0x0
80106a85:	68 9d 00 00 00       	push   $0x9d
80106a8a:	e9 3b f5 ff ff       	jmp    80105fca <alltraps>

80106a8f <vector158>:
80106a8f:	6a 00                	push   $0x0
80106a91:	68 9e 00 00 00       	push   $0x9e
80106a96:	e9 2f f5 ff ff       	jmp    80105fca <alltraps>

80106a9b <vector159>:
80106a9b:	6a 00                	push   $0x0
80106a9d:	68 9f 00 00 00       	push   $0x9f
80106aa2:	e9 23 f5 ff ff       	jmp    80105fca <alltraps>

80106aa7 <vector160>:
80106aa7:	6a 00                	push   $0x0
80106aa9:	68 a0 00 00 00       	push   $0xa0
80106aae:	e9 17 f5 ff ff       	jmp    80105fca <alltraps>

80106ab3 <vector161>:
80106ab3:	6a 00                	push   $0x0
80106ab5:	68 a1 00 00 00       	push   $0xa1
80106aba:	e9 0b f5 ff ff       	jmp    80105fca <alltraps>

80106abf <vector162>:
80106abf:	6a 00                	push   $0x0
80106ac1:	68 a2 00 00 00       	push   $0xa2
80106ac6:	e9 ff f4 ff ff       	jmp    80105fca <alltraps>

80106acb <vector163>:
80106acb:	6a 00                	push   $0x0
80106acd:	68 a3 00 00 00       	push   $0xa3
80106ad2:	e9 f3 f4 ff ff       	jmp    80105fca <alltraps>

80106ad7 <vector164>:
80106ad7:	6a 00                	push   $0x0
80106ad9:	68 a4 00 00 00       	push   $0xa4
80106ade:	e9 e7 f4 ff ff       	jmp    80105fca <alltraps>

80106ae3 <vector165>:
80106ae3:	6a 00                	push   $0x0
80106ae5:	68 a5 00 00 00       	push   $0xa5
80106aea:	e9 db f4 ff ff       	jmp    80105fca <alltraps>

80106aef <vector166>:
80106aef:	6a 00                	push   $0x0
80106af1:	68 a6 00 00 00       	push   $0xa6
80106af6:	e9 cf f4 ff ff       	jmp    80105fca <alltraps>

80106afb <vector167>:
80106afb:	6a 00                	push   $0x0
80106afd:	68 a7 00 00 00       	push   $0xa7
80106b02:	e9 c3 f4 ff ff       	jmp    80105fca <alltraps>

80106b07 <vector168>:
80106b07:	6a 00                	push   $0x0
80106b09:	68 a8 00 00 00       	push   $0xa8
80106b0e:	e9 b7 f4 ff ff       	jmp    80105fca <alltraps>

80106b13 <vector169>:
80106b13:	6a 00                	push   $0x0
80106b15:	68 a9 00 00 00       	push   $0xa9
80106b1a:	e9 ab f4 ff ff       	jmp    80105fca <alltraps>

80106b1f <vector170>:
80106b1f:	6a 00                	push   $0x0
80106b21:	68 aa 00 00 00       	push   $0xaa
80106b26:	e9 9f f4 ff ff       	jmp    80105fca <alltraps>

80106b2b <vector171>:
80106b2b:	6a 00                	push   $0x0
80106b2d:	68 ab 00 00 00       	push   $0xab
80106b32:	e9 93 f4 ff ff       	jmp    80105fca <alltraps>

80106b37 <vector172>:
80106b37:	6a 00                	push   $0x0
80106b39:	68 ac 00 00 00       	push   $0xac
80106b3e:	e9 87 f4 ff ff       	jmp    80105fca <alltraps>

80106b43 <vector173>:
80106b43:	6a 00                	push   $0x0
80106b45:	68 ad 00 00 00       	push   $0xad
80106b4a:	e9 7b f4 ff ff       	jmp    80105fca <alltraps>

80106b4f <vector174>:
80106b4f:	6a 00                	push   $0x0
80106b51:	68 ae 00 00 00       	push   $0xae
80106b56:	e9 6f f4 ff ff       	jmp    80105fca <alltraps>

80106b5b <vector175>:
80106b5b:	6a 00                	push   $0x0
80106b5d:	68 af 00 00 00       	push   $0xaf
80106b62:	e9 63 f4 ff ff       	jmp    80105fca <alltraps>

80106b67 <vector176>:
80106b67:	6a 00                	push   $0x0
80106b69:	68 b0 00 00 00       	push   $0xb0
80106b6e:	e9 57 f4 ff ff       	jmp    80105fca <alltraps>

80106b73 <vector177>:
80106b73:	6a 00                	push   $0x0
80106b75:	68 b1 00 00 00       	push   $0xb1
80106b7a:	e9 4b f4 ff ff       	jmp    80105fca <alltraps>

80106b7f <vector178>:
80106b7f:	6a 00                	push   $0x0
80106b81:	68 b2 00 00 00       	push   $0xb2
80106b86:	e9 3f f4 ff ff       	jmp    80105fca <alltraps>

80106b8b <vector179>:
80106b8b:	6a 00                	push   $0x0
80106b8d:	68 b3 00 00 00       	push   $0xb3
80106b92:	e9 33 f4 ff ff       	jmp    80105fca <alltraps>

80106b97 <vector180>:
80106b97:	6a 00                	push   $0x0
80106b99:	68 b4 00 00 00       	push   $0xb4
80106b9e:	e9 27 f4 ff ff       	jmp    80105fca <alltraps>

80106ba3 <vector181>:
80106ba3:	6a 00                	push   $0x0
80106ba5:	68 b5 00 00 00       	push   $0xb5
80106baa:	e9 1b f4 ff ff       	jmp    80105fca <alltraps>

80106baf <vector182>:
80106baf:	6a 00                	push   $0x0
80106bb1:	68 b6 00 00 00       	push   $0xb6
80106bb6:	e9 0f f4 ff ff       	jmp    80105fca <alltraps>

80106bbb <vector183>:
80106bbb:	6a 00                	push   $0x0
80106bbd:	68 b7 00 00 00       	push   $0xb7
80106bc2:	e9 03 f4 ff ff       	jmp    80105fca <alltraps>

80106bc7 <vector184>:
80106bc7:	6a 00                	push   $0x0
80106bc9:	68 b8 00 00 00       	push   $0xb8
80106bce:	e9 f7 f3 ff ff       	jmp    80105fca <alltraps>

80106bd3 <vector185>:
80106bd3:	6a 00                	push   $0x0
80106bd5:	68 b9 00 00 00       	push   $0xb9
80106bda:	e9 eb f3 ff ff       	jmp    80105fca <alltraps>

80106bdf <vector186>:
80106bdf:	6a 00                	push   $0x0
80106be1:	68 ba 00 00 00       	push   $0xba
80106be6:	e9 df f3 ff ff       	jmp    80105fca <alltraps>

80106beb <vector187>:
80106beb:	6a 00                	push   $0x0
80106bed:	68 bb 00 00 00       	push   $0xbb
80106bf2:	e9 d3 f3 ff ff       	jmp    80105fca <alltraps>

80106bf7 <vector188>:
80106bf7:	6a 00                	push   $0x0
80106bf9:	68 bc 00 00 00       	push   $0xbc
80106bfe:	e9 c7 f3 ff ff       	jmp    80105fca <alltraps>

80106c03 <vector189>:
80106c03:	6a 00                	push   $0x0
80106c05:	68 bd 00 00 00       	push   $0xbd
80106c0a:	e9 bb f3 ff ff       	jmp    80105fca <alltraps>

80106c0f <vector190>:
80106c0f:	6a 00                	push   $0x0
80106c11:	68 be 00 00 00       	push   $0xbe
80106c16:	e9 af f3 ff ff       	jmp    80105fca <alltraps>

80106c1b <vector191>:
80106c1b:	6a 00                	push   $0x0
80106c1d:	68 bf 00 00 00       	push   $0xbf
80106c22:	e9 a3 f3 ff ff       	jmp    80105fca <alltraps>

80106c27 <vector192>:
80106c27:	6a 00                	push   $0x0
80106c29:	68 c0 00 00 00       	push   $0xc0
80106c2e:	e9 97 f3 ff ff       	jmp    80105fca <alltraps>

80106c33 <vector193>:
80106c33:	6a 00                	push   $0x0
80106c35:	68 c1 00 00 00       	push   $0xc1
80106c3a:	e9 8b f3 ff ff       	jmp    80105fca <alltraps>

80106c3f <vector194>:
80106c3f:	6a 00                	push   $0x0
80106c41:	68 c2 00 00 00       	push   $0xc2
80106c46:	e9 7f f3 ff ff       	jmp    80105fca <alltraps>

80106c4b <vector195>:
80106c4b:	6a 00                	push   $0x0
80106c4d:	68 c3 00 00 00       	push   $0xc3
80106c52:	e9 73 f3 ff ff       	jmp    80105fca <alltraps>

80106c57 <vector196>:
80106c57:	6a 00                	push   $0x0
80106c59:	68 c4 00 00 00       	push   $0xc4
80106c5e:	e9 67 f3 ff ff       	jmp    80105fca <alltraps>

80106c63 <vector197>:
80106c63:	6a 00                	push   $0x0
80106c65:	68 c5 00 00 00       	push   $0xc5
80106c6a:	e9 5b f3 ff ff       	jmp    80105fca <alltraps>

80106c6f <vector198>:
80106c6f:	6a 00                	push   $0x0
80106c71:	68 c6 00 00 00       	push   $0xc6
80106c76:	e9 4f f3 ff ff       	jmp    80105fca <alltraps>

80106c7b <vector199>:
80106c7b:	6a 00                	push   $0x0
80106c7d:	68 c7 00 00 00       	push   $0xc7
80106c82:	e9 43 f3 ff ff       	jmp    80105fca <alltraps>

80106c87 <vector200>:
80106c87:	6a 00                	push   $0x0
80106c89:	68 c8 00 00 00       	push   $0xc8
80106c8e:	e9 37 f3 ff ff       	jmp    80105fca <alltraps>

80106c93 <vector201>:
80106c93:	6a 00                	push   $0x0
80106c95:	68 c9 00 00 00       	push   $0xc9
80106c9a:	e9 2b f3 ff ff       	jmp    80105fca <alltraps>

80106c9f <vector202>:
80106c9f:	6a 00                	push   $0x0
80106ca1:	68 ca 00 00 00       	push   $0xca
80106ca6:	e9 1f f3 ff ff       	jmp    80105fca <alltraps>

80106cab <vector203>:
80106cab:	6a 00                	push   $0x0
80106cad:	68 cb 00 00 00       	push   $0xcb
80106cb2:	e9 13 f3 ff ff       	jmp    80105fca <alltraps>

80106cb7 <vector204>:
80106cb7:	6a 00                	push   $0x0
80106cb9:	68 cc 00 00 00       	push   $0xcc
80106cbe:	e9 07 f3 ff ff       	jmp    80105fca <alltraps>

80106cc3 <vector205>:
80106cc3:	6a 00                	push   $0x0
80106cc5:	68 cd 00 00 00       	push   $0xcd
80106cca:	e9 fb f2 ff ff       	jmp    80105fca <alltraps>

80106ccf <vector206>:
80106ccf:	6a 00                	push   $0x0
80106cd1:	68 ce 00 00 00       	push   $0xce
80106cd6:	e9 ef f2 ff ff       	jmp    80105fca <alltraps>

80106cdb <vector207>:
80106cdb:	6a 00                	push   $0x0
80106cdd:	68 cf 00 00 00       	push   $0xcf
80106ce2:	e9 e3 f2 ff ff       	jmp    80105fca <alltraps>

80106ce7 <vector208>:
80106ce7:	6a 00                	push   $0x0
80106ce9:	68 d0 00 00 00       	push   $0xd0
80106cee:	e9 d7 f2 ff ff       	jmp    80105fca <alltraps>

80106cf3 <vector209>:
80106cf3:	6a 00                	push   $0x0
80106cf5:	68 d1 00 00 00       	push   $0xd1
80106cfa:	e9 cb f2 ff ff       	jmp    80105fca <alltraps>

80106cff <vector210>:
80106cff:	6a 00                	push   $0x0
80106d01:	68 d2 00 00 00       	push   $0xd2
80106d06:	e9 bf f2 ff ff       	jmp    80105fca <alltraps>

80106d0b <vector211>:
80106d0b:	6a 00                	push   $0x0
80106d0d:	68 d3 00 00 00       	push   $0xd3
80106d12:	e9 b3 f2 ff ff       	jmp    80105fca <alltraps>

80106d17 <vector212>:
80106d17:	6a 00                	push   $0x0
80106d19:	68 d4 00 00 00       	push   $0xd4
80106d1e:	e9 a7 f2 ff ff       	jmp    80105fca <alltraps>

80106d23 <vector213>:
80106d23:	6a 00                	push   $0x0
80106d25:	68 d5 00 00 00       	push   $0xd5
80106d2a:	e9 9b f2 ff ff       	jmp    80105fca <alltraps>

80106d2f <vector214>:
80106d2f:	6a 00                	push   $0x0
80106d31:	68 d6 00 00 00       	push   $0xd6
80106d36:	e9 8f f2 ff ff       	jmp    80105fca <alltraps>

80106d3b <vector215>:
80106d3b:	6a 00                	push   $0x0
80106d3d:	68 d7 00 00 00       	push   $0xd7
80106d42:	e9 83 f2 ff ff       	jmp    80105fca <alltraps>

80106d47 <vector216>:
80106d47:	6a 00                	push   $0x0
80106d49:	68 d8 00 00 00       	push   $0xd8
80106d4e:	e9 77 f2 ff ff       	jmp    80105fca <alltraps>

80106d53 <vector217>:
80106d53:	6a 00                	push   $0x0
80106d55:	68 d9 00 00 00       	push   $0xd9
80106d5a:	e9 6b f2 ff ff       	jmp    80105fca <alltraps>

80106d5f <vector218>:
80106d5f:	6a 00                	push   $0x0
80106d61:	68 da 00 00 00       	push   $0xda
80106d66:	e9 5f f2 ff ff       	jmp    80105fca <alltraps>

80106d6b <vector219>:
80106d6b:	6a 00                	push   $0x0
80106d6d:	68 db 00 00 00       	push   $0xdb
80106d72:	e9 53 f2 ff ff       	jmp    80105fca <alltraps>

80106d77 <vector220>:
80106d77:	6a 00                	push   $0x0
80106d79:	68 dc 00 00 00       	push   $0xdc
80106d7e:	e9 47 f2 ff ff       	jmp    80105fca <alltraps>

80106d83 <vector221>:
80106d83:	6a 00                	push   $0x0
80106d85:	68 dd 00 00 00       	push   $0xdd
80106d8a:	e9 3b f2 ff ff       	jmp    80105fca <alltraps>

80106d8f <vector222>:
80106d8f:	6a 00                	push   $0x0
80106d91:	68 de 00 00 00       	push   $0xde
80106d96:	e9 2f f2 ff ff       	jmp    80105fca <alltraps>

80106d9b <vector223>:
80106d9b:	6a 00                	push   $0x0
80106d9d:	68 df 00 00 00       	push   $0xdf
80106da2:	e9 23 f2 ff ff       	jmp    80105fca <alltraps>

80106da7 <vector224>:
80106da7:	6a 00                	push   $0x0
80106da9:	68 e0 00 00 00       	push   $0xe0
80106dae:	e9 17 f2 ff ff       	jmp    80105fca <alltraps>

80106db3 <vector225>:
80106db3:	6a 00                	push   $0x0
80106db5:	68 e1 00 00 00       	push   $0xe1
80106dba:	e9 0b f2 ff ff       	jmp    80105fca <alltraps>

80106dbf <vector226>:
80106dbf:	6a 00                	push   $0x0
80106dc1:	68 e2 00 00 00       	push   $0xe2
80106dc6:	e9 ff f1 ff ff       	jmp    80105fca <alltraps>

80106dcb <vector227>:
80106dcb:	6a 00                	push   $0x0
80106dcd:	68 e3 00 00 00       	push   $0xe3
80106dd2:	e9 f3 f1 ff ff       	jmp    80105fca <alltraps>

80106dd7 <vector228>:
80106dd7:	6a 00                	push   $0x0
80106dd9:	68 e4 00 00 00       	push   $0xe4
80106dde:	e9 e7 f1 ff ff       	jmp    80105fca <alltraps>

80106de3 <vector229>:
80106de3:	6a 00                	push   $0x0
80106de5:	68 e5 00 00 00       	push   $0xe5
80106dea:	e9 db f1 ff ff       	jmp    80105fca <alltraps>

80106def <vector230>:
80106def:	6a 00                	push   $0x0
80106df1:	68 e6 00 00 00       	push   $0xe6
80106df6:	e9 cf f1 ff ff       	jmp    80105fca <alltraps>

80106dfb <vector231>:
80106dfb:	6a 00                	push   $0x0
80106dfd:	68 e7 00 00 00       	push   $0xe7
80106e02:	e9 c3 f1 ff ff       	jmp    80105fca <alltraps>

80106e07 <vector232>:
80106e07:	6a 00                	push   $0x0
80106e09:	68 e8 00 00 00       	push   $0xe8
80106e0e:	e9 b7 f1 ff ff       	jmp    80105fca <alltraps>

80106e13 <vector233>:
80106e13:	6a 00                	push   $0x0
80106e15:	68 e9 00 00 00       	push   $0xe9
80106e1a:	e9 ab f1 ff ff       	jmp    80105fca <alltraps>

80106e1f <vector234>:
80106e1f:	6a 00                	push   $0x0
80106e21:	68 ea 00 00 00       	push   $0xea
80106e26:	e9 9f f1 ff ff       	jmp    80105fca <alltraps>

80106e2b <vector235>:
80106e2b:	6a 00                	push   $0x0
80106e2d:	68 eb 00 00 00       	push   $0xeb
80106e32:	e9 93 f1 ff ff       	jmp    80105fca <alltraps>

80106e37 <vector236>:
80106e37:	6a 00                	push   $0x0
80106e39:	68 ec 00 00 00       	push   $0xec
80106e3e:	e9 87 f1 ff ff       	jmp    80105fca <alltraps>

80106e43 <vector237>:
80106e43:	6a 00                	push   $0x0
80106e45:	68 ed 00 00 00       	push   $0xed
80106e4a:	e9 7b f1 ff ff       	jmp    80105fca <alltraps>

80106e4f <vector238>:
80106e4f:	6a 00                	push   $0x0
80106e51:	68 ee 00 00 00       	push   $0xee
80106e56:	e9 6f f1 ff ff       	jmp    80105fca <alltraps>

80106e5b <vector239>:
80106e5b:	6a 00                	push   $0x0
80106e5d:	68 ef 00 00 00       	push   $0xef
80106e62:	e9 63 f1 ff ff       	jmp    80105fca <alltraps>

80106e67 <vector240>:
80106e67:	6a 00                	push   $0x0
80106e69:	68 f0 00 00 00       	push   $0xf0
80106e6e:	e9 57 f1 ff ff       	jmp    80105fca <alltraps>

80106e73 <vector241>:
80106e73:	6a 00                	push   $0x0
80106e75:	68 f1 00 00 00       	push   $0xf1
80106e7a:	e9 4b f1 ff ff       	jmp    80105fca <alltraps>

80106e7f <vector242>:
80106e7f:	6a 00                	push   $0x0
80106e81:	68 f2 00 00 00       	push   $0xf2
80106e86:	e9 3f f1 ff ff       	jmp    80105fca <alltraps>

80106e8b <vector243>:
80106e8b:	6a 00                	push   $0x0
80106e8d:	68 f3 00 00 00       	push   $0xf3
80106e92:	e9 33 f1 ff ff       	jmp    80105fca <alltraps>

80106e97 <vector244>:
80106e97:	6a 00                	push   $0x0
80106e99:	68 f4 00 00 00       	push   $0xf4
80106e9e:	e9 27 f1 ff ff       	jmp    80105fca <alltraps>

80106ea3 <vector245>:
80106ea3:	6a 00                	push   $0x0
80106ea5:	68 f5 00 00 00       	push   $0xf5
80106eaa:	e9 1b f1 ff ff       	jmp    80105fca <alltraps>

80106eaf <vector246>:
80106eaf:	6a 00                	push   $0x0
80106eb1:	68 f6 00 00 00       	push   $0xf6
80106eb6:	e9 0f f1 ff ff       	jmp    80105fca <alltraps>

80106ebb <vector247>:
80106ebb:	6a 00                	push   $0x0
80106ebd:	68 f7 00 00 00       	push   $0xf7
80106ec2:	e9 03 f1 ff ff       	jmp    80105fca <alltraps>

80106ec7 <vector248>:
80106ec7:	6a 00                	push   $0x0
80106ec9:	68 f8 00 00 00       	push   $0xf8
80106ece:	e9 f7 f0 ff ff       	jmp    80105fca <alltraps>

80106ed3 <vector249>:
80106ed3:	6a 00                	push   $0x0
80106ed5:	68 f9 00 00 00       	push   $0xf9
80106eda:	e9 eb f0 ff ff       	jmp    80105fca <alltraps>

80106edf <vector250>:
80106edf:	6a 00                	push   $0x0
80106ee1:	68 fa 00 00 00       	push   $0xfa
80106ee6:	e9 df f0 ff ff       	jmp    80105fca <alltraps>

80106eeb <vector251>:
80106eeb:	6a 00                	push   $0x0
80106eed:	68 fb 00 00 00       	push   $0xfb
80106ef2:	e9 d3 f0 ff ff       	jmp    80105fca <alltraps>

80106ef7 <vector252>:
80106ef7:	6a 00                	push   $0x0
80106ef9:	68 fc 00 00 00       	push   $0xfc
80106efe:	e9 c7 f0 ff ff       	jmp    80105fca <alltraps>

80106f03 <vector253>:
80106f03:	6a 00                	push   $0x0
80106f05:	68 fd 00 00 00       	push   $0xfd
80106f0a:	e9 bb f0 ff ff       	jmp    80105fca <alltraps>

80106f0f <vector254>:
80106f0f:	6a 00                	push   $0x0
80106f11:	68 fe 00 00 00       	push   $0xfe
80106f16:	e9 af f0 ff ff       	jmp    80105fca <alltraps>

80106f1b <vector255>:
80106f1b:	6a 00                	push   $0x0
80106f1d:	68 ff 00 00 00       	push   $0xff
80106f22:	e9 a3 f0 ff ff       	jmp    80105fca <alltraps>
80106f27:	66 90                	xchg   %ax,%ax
80106f29:	66 90                	xchg   %ax,%ax
80106f2b:	66 90                	xchg   %ax,%ax
80106f2d:	66 90                	xchg   %ax,%ax
80106f2f:	90                   	nop

80106f30 <deallocuvm.part.0>:
80106f30:	55                   	push   %ebp
80106f31:	89 e5                	mov    %esp,%ebp
80106f33:	57                   	push   %edi
80106f34:	56                   	push   %esi
80106f35:	53                   	push   %ebx
80106f36:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
80106f3c:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
80106f42:	83 ec 1c             	sub    $0x1c,%esp
80106f45:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80106f48:	39 d3                	cmp    %edx,%ebx
80106f4a:	73 49                	jae    80106f95 <deallocuvm.part.0+0x65>
80106f4c:	89 c7                	mov    %eax,%edi
80106f4e:	eb 0c                	jmp    80106f5c <deallocuvm.part.0+0x2c>
80106f50:	83 c0 01             	add    $0x1,%eax
80106f53:	c1 e0 16             	shl    $0x16,%eax
80106f56:	89 c3                	mov    %eax,%ebx
80106f58:	39 da                	cmp    %ebx,%edx
80106f5a:	76 39                	jbe    80106f95 <deallocuvm.part.0+0x65>
80106f5c:	89 d8                	mov    %ebx,%eax
80106f5e:	c1 e8 16             	shr    $0x16,%eax
80106f61:	8b 0c 87             	mov    (%edi,%eax,4),%ecx
80106f64:	f6 c1 01             	test   $0x1,%cl
80106f67:	74 e7                	je     80106f50 <deallocuvm.part.0+0x20>
80106f69:	89 de                	mov    %ebx,%esi
80106f6b:	81 e1 00 f0 ff ff    	and    $0xfffff000,%ecx
80106f71:	c1 ee 0a             	shr    $0xa,%esi
80106f74:	81 e6 fc 0f 00 00    	and    $0xffc,%esi
80106f7a:	8d b4 31 00 00 00 80 	lea    -0x80000000(%ecx,%esi,1),%esi
80106f81:	85 f6                	test   %esi,%esi
80106f83:	74 cb                	je     80106f50 <deallocuvm.part.0+0x20>
80106f85:	8b 06                	mov    (%esi),%eax
80106f87:	a8 01                	test   $0x1,%al
80106f89:	75 15                	jne    80106fa0 <deallocuvm.part.0+0x70>
80106f8b:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106f91:	39 da                	cmp    %ebx,%edx
80106f93:	77 c7                	ja     80106f5c <deallocuvm.part.0+0x2c>
80106f95:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106f98:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106f9b:	5b                   	pop    %ebx
80106f9c:	5e                   	pop    %esi
80106f9d:	5f                   	pop    %edi
80106f9e:	5d                   	pop    %ebp
80106f9f:	c3                   	ret    
80106fa0:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106fa5:	74 25                	je     80106fcc <deallocuvm.part.0+0x9c>
80106fa7:	83 ec 0c             	sub    $0xc,%esp
80106faa:	05 00 00 00 80       	add    $0x80000000,%eax
80106faf:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80106fb2:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106fb8:	50                   	push   %eax
80106fb9:	e8 92 bc ff ff       	call   80102c50 <kfree>
80106fbe:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80106fc4:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80106fc7:	83 c4 10             	add    $0x10,%esp
80106fca:	eb 8c                	jmp    80106f58 <deallocuvm.part.0+0x28>
80106fcc:	83 ec 0c             	sub    $0xc,%esp
80106fcf:	68 de 7b 10 80       	push   $0x80107bde
80106fd4:	e8 c7 93 ff ff       	call   801003a0 <panic>
80106fd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106fe0 <mappages>:
80106fe0:	55                   	push   %ebp
80106fe1:	89 e5                	mov    %esp,%ebp
80106fe3:	57                   	push   %edi
80106fe4:	56                   	push   %esi
80106fe5:	53                   	push   %ebx
80106fe6:	89 d3                	mov    %edx,%ebx
80106fe8:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
80106fee:	83 ec 1c             	sub    $0x1c,%esp
80106ff1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106ff4:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
80106ff8:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106ffd:	89 45 dc             	mov    %eax,-0x24(%ebp)
80107000:	8b 45 08             	mov    0x8(%ebp),%eax
80107003:	29 d8                	sub    %ebx,%eax
80107005:	89 45 e0             	mov    %eax,-0x20(%ebp)
80107008:	eb 3d                	jmp    80107047 <mappages+0x67>
8010700a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107010:	89 da                	mov    %ebx,%edx
80107012:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107017:	c1 ea 0a             	shr    $0xa,%edx
8010701a:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80107020:	8d 84 10 00 00 00 80 	lea    -0x80000000(%eax,%edx,1),%eax
80107027:	85 c0                	test   %eax,%eax
80107029:	74 75                	je     801070a0 <mappages+0xc0>
8010702b:	f6 00 01             	testb  $0x1,(%eax)
8010702e:	0f 85 86 00 00 00    	jne    801070ba <mappages+0xda>
80107034:	0b 75 0c             	or     0xc(%ebp),%esi
80107037:	83 ce 01             	or     $0x1,%esi
8010703a:	89 30                	mov    %esi,(%eax)
8010703c:	3b 5d dc             	cmp    -0x24(%ebp),%ebx
8010703f:	74 6f                	je     801070b0 <mappages+0xd0>
80107041:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80107047:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010704a:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
8010704d:	8d 34 18             	lea    (%eax,%ebx,1),%esi
80107050:	89 d8                	mov    %ebx,%eax
80107052:	c1 e8 16             	shr    $0x16,%eax
80107055:	8d 3c 81             	lea    (%ecx,%eax,4),%edi
80107058:	8b 07                	mov    (%edi),%eax
8010705a:	a8 01                	test   $0x1,%al
8010705c:	75 b2                	jne    80107010 <mappages+0x30>
8010705e:	e8 ad bd ff ff       	call   80102e10 <kalloc>
80107063:	85 c0                	test   %eax,%eax
80107065:	74 39                	je     801070a0 <mappages+0xc0>
80107067:	83 ec 04             	sub    $0x4,%esp
8010706a:	89 45 d8             	mov    %eax,-0x28(%ebp)
8010706d:	68 00 10 00 00       	push   $0x1000
80107072:	6a 00                	push   $0x0
80107074:	50                   	push   %eax
80107075:	e8 76 dd ff ff       	call   80104df0 <memset>
8010707a:	8b 55 d8             	mov    -0x28(%ebp),%edx
8010707d:	83 c4 10             	add    $0x10,%esp
80107080:	8d 82 00 00 00 80    	lea    -0x80000000(%edx),%eax
80107086:	83 c8 07             	or     $0x7,%eax
80107089:	89 07                	mov    %eax,(%edi)
8010708b:	89 d8                	mov    %ebx,%eax
8010708d:	c1 e8 0a             	shr    $0xa,%eax
80107090:	25 fc 0f 00 00       	and    $0xffc,%eax
80107095:	01 d0                	add    %edx,%eax
80107097:	eb 92                	jmp    8010702b <mappages+0x4b>
80107099:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801070a0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801070a3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801070a8:	5b                   	pop    %ebx
801070a9:	5e                   	pop    %esi
801070aa:	5f                   	pop    %edi
801070ab:	5d                   	pop    %ebp
801070ac:	c3                   	ret    
801070ad:	8d 76 00             	lea    0x0(%esi),%esi
801070b0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801070b3:	31 c0                	xor    %eax,%eax
801070b5:	5b                   	pop    %ebx
801070b6:	5e                   	pop    %esi
801070b7:	5f                   	pop    %edi
801070b8:	5d                   	pop    %ebp
801070b9:	c3                   	ret    
801070ba:	83 ec 0c             	sub    $0xc,%esp
801070bd:	68 28 82 10 80       	push   $0x80108228
801070c2:	e8 d9 92 ff ff       	call   801003a0 <panic>
801070c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801070ce:	66 90                	xchg   %ax,%ax

801070d0 <seginit>:
801070d0:	55                   	push   %ebp
801070d1:	89 e5                	mov    %esp,%ebp
801070d3:	83 ec 18             	sub    $0x18,%esp
801070d6:	e8 05 d0 ff ff       	call   801040e0 <cpuid>
801070db:	ba 2f 00 00 00       	mov    $0x2f,%edx
801070e0:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
801070e6:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
801070ea:	c7 80 58 34 11 80 ff 	movl   $0xffff,-0x7feecba8(%eax)
801070f1:	ff 00 00 
801070f4:	c7 80 5c 34 11 80 00 	movl   $0xcf9a00,-0x7feecba4(%eax)
801070fb:	9a cf 00 
801070fe:	c7 80 60 34 11 80 ff 	movl   $0xffff,-0x7feecba0(%eax)
80107105:	ff 00 00 
80107108:	c7 80 64 34 11 80 00 	movl   $0xcf9200,-0x7feecb9c(%eax)
8010710f:	92 cf 00 
80107112:	c7 80 68 34 11 80 ff 	movl   $0xffff,-0x7feecb98(%eax)
80107119:	ff 00 00 
8010711c:	c7 80 6c 34 11 80 00 	movl   $0xcffa00,-0x7feecb94(%eax)
80107123:	fa cf 00 
80107126:	c7 80 70 34 11 80 ff 	movl   $0xffff,-0x7feecb90(%eax)
8010712d:	ff 00 00 
80107130:	c7 80 74 34 11 80 00 	movl   $0xcff200,-0x7feecb8c(%eax)
80107137:	f2 cf 00 
8010713a:	05 50 34 11 80       	add    $0x80113450,%eax
8010713f:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
80107143:	c1 e8 10             	shr    $0x10,%eax
80107146:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
8010714a:	8d 45 f2             	lea    -0xe(%ebp),%eax
8010714d:	0f 01 10             	lgdtl  (%eax)
80107150:	c9                   	leave  
80107151:	c3                   	ret    
80107152:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107159:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107160 <switchkvm>:
80107160:	a1 04 61 11 80       	mov    0x80116104,%eax
80107165:	05 00 00 00 80       	add    $0x80000000,%eax
8010716a:	0f 22 d8             	mov    %eax,%cr3
8010716d:	c3                   	ret    
8010716e:	66 90                	xchg   %ax,%ax

80107170 <switchuvm>:
80107170:	55                   	push   %ebp
80107171:	89 e5                	mov    %esp,%ebp
80107173:	57                   	push   %edi
80107174:	56                   	push   %esi
80107175:	53                   	push   %ebx
80107176:	83 ec 1c             	sub    $0x1c,%esp
80107179:	8b 75 08             	mov    0x8(%ebp),%esi
8010717c:	85 f6                	test   %esi,%esi
8010717e:	0f 84 cb 00 00 00    	je     8010724f <switchuvm+0xdf>
80107184:	8b 46 08             	mov    0x8(%esi),%eax
80107187:	85 c0                	test   %eax,%eax
80107189:	0f 84 da 00 00 00    	je     80107269 <switchuvm+0xf9>
8010718f:	8b 46 04             	mov    0x4(%esi),%eax
80107192:	85 c0                	test   %eax,%eax
80107194:	0f 84 c2 00 00 00    	je     8010725c <switchuvm+0xec>
8010719a:	e8 41 da ff ff       	call   80104be0 <pushcli>
8010719f:	e8 dc ce ff ff       	call   80104080 <mycpu>
801071a4:	89 c3                	mov    %eax,%ebx
801071a6:	e8 d5 ce ff ff       	call   80104080 <mycpu>
801071ab:	89 c7                	mov    %eax,%edi
801071ad:	e8 ce ce ff ff       	call   80104080 <mycpu>
801071b2:	83 c7 08             	add    $0x8,%edi
801071b5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801071b8:	e8 c3 ce ff ff       	call   80104080 <mycpu>
801071bd:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801071c0:	ba 67 00 00 00       	mov    $0x67,%edx
801071c5:	66 89 bb 9a 00 00 00 	mov    %di,0x9a(%ebx)
801071cc:	83 c0 08             	add    $0x8,%eax
801071cf:	66 89 93 98 00 00 00 	mov    %dx,0x98(%ebx)
801071d6:	bf ff ff ff ff       	mov    $0xffffffff,%edi
801071db:	83 c1 08             	add    $0x8,%ecx
801071de:	c1 e8 18             	shr    $0x18,%eax
801071e1:	c1 e9 10             	shr    $0x10,%ecx
801071e4:	88 83 9f 00 00 00    	mov    %al,0x9f(%ebx)
801071ea:	88 8b 9c 00 00 00    	mov    %cl,0x9c(%ebx)
801071f0:	b9 99 40 00 00       	mov    $0x4099,%ecx
801071f5:	66 89 8b 9d 00 00 00 	mov    %cx,0x9d(%ebx)
801071fc:	bb 10 00 00 00       	mov    $0x10,%ebx
80107201:	e8 7a ce ff ff       	call   80104080 <mycpu>
80107206:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
8010720d:	e8 6e ce ff ff       	call   80104080 <mycpu>
80107212:	66 89 58 10          	mov    %bx,0x10(%eax)
80107216:	8b 5e 08             	mov    0x8(%esi),%ebx
80107219:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010721f:	e8 5c ce ff ff       	call   80104080 <mycpu>
80107224:	89 58 0c             	mov    %ebx,0xc(%eax)
80107227:	e8 54 ce ff ff       	call   80104080 <mycpu>
8010722c:	66 89 78 6e          	mov    %di,0x6e(%eax)
80107230:	b8 28 00 00 00       	mov    $0x28,%eax
80107235:	0f 00 d8             	ltr    %ax
80107238:	8b 46 04             	mov    0x4(%esi),%eax
8010723b:	05 00 00 00 80       	add    $0x80000000,%eax
80107240:	0f 22 d8             	mov    %eax,%cr3
80107243:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107246:	5b                   	pop    %ebx
80107247:	5e                   	pop    %esi
80107248:	5f                   	pop    %edi
80107249:	5d                   	pop    %ebp
8010724a:	e9 e1 d9 ff ff       	jmp    80104c30 <popcli>
8010724f:	83 ec 0c             	sub    $0xc,%esp
80107252:	68 2e 82 10 80       	push   $0x8010822e
80107257:	e8 44 91 ff ff       	call   801003a0 <panic>
8010725c:	83 ec 0c             	sub    $0xc,%esp
8010725f:	68 59 82 10 80       	push   $0x80108259
80107264:	e8 37 91 ff ff       	call   801003a0 <panic>
80107269:	83 ec 0c             	sub    $0xc,%esp
8010726c:	68 44 82 10 80       	push   $0x80108244
80107271:	e8 2a 91 ff ff       	call   801003a0 <panic>
80107276:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010727d:	8d 76 00             	lea    0x0(%esi),%esi

80107280 <inituvm>:
80107280:	55                   	push   %ebp
80107281:	89 e5                	mov    %esp,%ebp
80107283:	57                   	push   %edi
80107284:	56                   	push   %esi
80107285:	53                   	push   %ebx
80107286:	83 ec 1c             	sub    $0x1c,%esp
80107289:	8b 45 0c             	mov    0xc(%ebp),%eax
8010728c:	8b 75 10             	mov    0x10(%ebp),%esi
8010728f:	8b 7d 08             	mov    0x8(%ebp),%edi
80107292:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107295:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
8010729b:	77 4b                	ja     801072e8 <inituvm+0x68>
8010729d:	e8 6e bb ff ff       	call   80102e10 <kalloc>
801072a2:	83 ec 04             	sub    $0x4,%esp
801072a5:	68 00 10 00 00       	push   $0x1000
801072aa:	89 c3                	mov    %eax,%ebx
801072ac:	6a 00                	push   $0x0
801072ae:	50                   	push   %eax
801072af:	e8 3c db ff ff       	call   80104df0 <memset>
801072b4:	58                   	pop    %eax
801072b5:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801072bb:	5a                   	pop    %edx
801072bc:	6a 06                	push   $0x6
801072be:	b9 00 10 00 00       	mov    $0x1000,%ecx
801072c3:	31 d2                	xor    %edx,%edx
801072c5:	50                   	push   %eax
801072c6:	89 f8                	mov    %edi,%eax
801072c8:	e8 13 fd ff ff       	call   80106fe0 <mappages>
801072cd:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801072d0:	89 75 10             	mov    %esi,0x10(%ebp)
801072d3:	83 c4 10             	add    $0x10,%esp
801072d6:	89 5d 08             	mov    %ebx,0x8(%ebp)
801072d9:	89 45 0c             	mov    %eax,0xc(%ebp)
801072dc:	8d 65 f4             	lea    -0xc(%ebp),%esp
801072df:	5b                   	pop    %ebx
801072e0:	5e                   	pop    %esi
801072e1:	5f                   	pop    %edi
801072e2:	5d                   	pop    %ebp
801072e3:	e9 a8 db ff ff       	jmp    80104e90 <memmove>
801072e8:	83 ec 0c             	sub    $0xc,%esp
801072eb:	68 6d 82 10 80       	push   $0x8010826d
801072f0:	e8 ab 90 ff ff       	call   801003a0 <panic>
801072f5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801072fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80107300 <loaduvm>:
80107300:	55                   	push   %ebp
80107301:	89 e5                	mov    %esp,%ebp
80107303:	57                   	push   %edi
80107304:	56                   	push   %esi
80107305:	53                   	push   %ebx
80107306:	83 ec 1c             	sub    $0x1c,%esp
80107309:	8b 45 0c             	mov    0xc(%ebp),%eax
8010730c:	8b 75 18             	mov    0x18(%ebp),%esi
8010730f:	a9 ff 0f 00 00       	test   $0xfff,%eax
80107314:	0f 85 bb 00 00 00    	jne    801073d5 <loaduvm+0xd5>
8010731a:	01 f0                	add    %esi,%eax
8010731c:	89 f3                	mov    %esi,%ebx
8010731e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107321:	8b 45 14             	mov    0x14(%ebp),%eax
80107324:	01 f0                	add    %esi,%eax
80107326:	89 45 e0             	mov    %eax,-0x20(%ebp)
80107329:	85 f6                	test   %esi,%esi
8010732b:	0f 84 87 00 00 00    	je     801073b8 <loaduvm+0xb8>
80107331:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107338:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010733b:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010733e:	29 d8                	sub    %ebx,%eax
80107340:	89 c2                	mov    %eax,%edx
80107342:	c1 ea 16             	shr    $0x16,%edx
80107345:	8b 14 91             	mov    (%ecx,%edx,4),%edx
80107348:	f6 c2 01             	test   $0x1,%dl
8010734b:	75 13                	jne    80107360 <loaduvm+0x60>
8010734d:	83 ec 0c             	sub    $0xc,%esp
80107350:	68 87 82 10 80       	push   $0x80108287
80107355:	e8 46 90 ff ff       	call   801003a0 <panic>
8010735a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107360:	c1 e8 0a             	shr    $0xa,%eax
80107363:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80107369:	25 fc 0f 00 00       	and    $0xffc,%eax
8010736e:	8d 84 02 00 00 00 80 	lea    -0x80000000(%edx,%eax,1),%eax
80107375:	85 c0                	test   %eax,%eax
80107377:	74 d4                	je     8010734d <loaduvm+0x4d>
80107379:	8b 00                	mov    (%eax),%eax
8010737b:	8b 4d e0             	mov    -0x20(%ebp),%ecx
8010737e:	bf 00 10 00 00       	mov    $0x1000,%edi
80107383:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107388:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
8010738e:	0f 46 fb             	cmovbe %ebx,%edi
80107391:	29 d9                	sub    %ebx,%ecx
80107393:	05 00 00 00 80       	add    $0x80000000,%eax
80107398:	57                   	push   %edi
80107399:	51                   	push   %ecx
8010739a:	50                   	push   %eax
8010739b:	ff 75 10             	push   0x10(%ebp)
8010739e:	e8 7d ae ff ff       	call   80102220 <readi>
801073a3:	83 c4 10             	add    $0x10,%esp
801073a6:	39 f8                	cmp    %edi,%eax
801073a8:	75 1e                	jne    801073c8 <loaduvm+0xc8>
801073aa:	81 eb 00 10 00 00    	sub    $0x1000,%ebx
801073b0:	89 f0                	mov    %esi,%eax
801073b2:	29 d8                	sub    %ebx,%eax
801073b4:	39 c6                	cmp    %eax,%esi
801073b6:	77 80                	ja     80107338 <loaduvm+0x38>
801073b8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801073bb:	31 c0                	xor    %eax,%eax
801073bd:	5b                   	pop    %ebx
801073be:	5e                   	pop    %esi
801073bf:	5f                   	pop    %edi
801073c0:	5d                   	pop    %ebp
801073c1:	c3                   	ret    
801073c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801073c8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801073cb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801073d0:	5b                   	pop    %ebx
801073d1:	5e                   	pop    %esi
801073d2:	5f                   	pop    %edi
801073d3:	5d                   	pop    %ebp
801073d4:	c3                   	ret    
801073d5:	83 ec 0c             	sub    $0xc,%esp
801073d8:	68 28 83 10 80       	push   $0x80108328
801073dd:	e8 be 8f ff ff       	call   801003a0 <panic>
801073e2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801073e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801073f0 <allocuvm>:
801073f0:	55                   	push   %ebp
801073f1:	89 e5                	mov    %esp,%ebp
801073f3:	57                   	push   %edi
801073f4:	56                   	push   %esi
801073f5:	53                   	push   %ebx
801073f6:	83 ec 1c             	sub    $0x1c,%esp
801073f9:	8b 45 10             	mov    0x10(%ebp),%eax
801073fc:	8b 7d 08             	mov    0x8(%ebp),%edi
801073ff:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107402:	85 c0                	test   %eax,%eax
80107404:	0f 88 b6 00 00 00    	js     801074c0 <allocuvm+0xd0>
8010740a:	3b 45 0c             	cmp    0xc(%ebp),%eax
8010740d:	8b 45 0c             	mov    0xc(%ebp),%eax
80107410:	0f 82 9a 00 00 00    	jb     801074b0 <allocuvm+0xc0>
80107416:	8d b0 ff 0f 00 00    	lea    0xfff(%eax),%esi
8010741c:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
80107422:	39 75 10             	cmp    %esi,0x10(%ebp)
80107425:	77 44                	ja     8010746b <allocuvm+0x7b>
80107427:	e9 87 00 00 00       	jmp    801074b3 <allocuvm+0xc3>
8010742c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107430:	83 ec 04             	sub    $0x4,%esp
80107433:	68 00 10 00 00       	push   $0x1000
80107438:	6a 00                	push   $0x0
8010743a:	50                   	push   %eax
8010743b:	e8 b0 d9 ff ff       	call   80104df0 <memset>
80107440:	58                   	pop    %eax
80107441:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80107447:	5a                   	pop    %edx
80107448:	6a 06                	push   $0x6
8010744a:	b9 00 10 00 00       	mov    $0x1000,%ecx
8010744f:	89 f2                	mov    %esi,%edx
80107451:	50                   	push   %eax
80107452:	89 f8                	mov    %edi,%eax
80107454:	e8 87 fb ff ff       	call   80106fe0 <mappages>
80107459:	83 c4 10             	add    $0x10,%esp
8010745c:	85 c0                	test   %eax,%eax
8010745e:	78 78                	js     801074d8 <allocuvm+0xe8>
80107460:	81 c6 00 10 00 00    	add    $0x1000,%esi
80107466:	39 75 10             	cmp    %esi,0x10(%ebp)
80107469:	76 48                	jbe    801074b3 <allocuvm+0xc3>
8010746b:	e8 a0 b9 ff ff       	call   80102e10 <kalloc>
80107470:	89 c3                	mov    %eax,%ebx
80107472:	85 c0                	test   %eax,%eax
80107474:	75 ba                	jne    80107430 <allocuvm+0x40>
80107476:	83 ec 0c             	sub    $0xc,%esp
80107479:	68 a5 82 10 80       	push   $0x801082a5
8010747e:	e8 cd 92 ff ff       	call   80100750 <cprintf>
80107483:	8b 45 0c             	mov    0xc(%ebp),%eax
80107486:	83 c4 10             	add    $0x10,%esp
80107489:	39 45 10             	cmp    %eax,0x10(%ebp)
8010748c:	74 32                	je     801074c0 <allocuvm+0xd0>
8010748e:	8b 55 10             	mov    0x10(%ebp),%edx
80107491:	89 c1                	mov    %eax,%ecx
80107493:	89 f8                	mov    %edi,%eax
80107495:	e8 96 fa ff ff       	call   80106f30 <deallocuvm.part.0>
8010749a:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
801074a1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801074a4:	8d 65 f4             	lea    -0xc(%ebp),%esp
801074a7:	5b                   	pop    %ebx
801074a8:	5e                   	pop    %esi
801074a9:	5f                   	pop    %edi
801074aa:	5d                   	pop    %ebp
801074ab:	c3                   	ret    
801074ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801074b0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801074b3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801074b6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801074b9:	5b                   	pop    %ebx
801074ba:	5e                   	pop    %esi
801074bb:	5f                   	pop    %edi
801074bc:	5d                   	pop    %ebp
801074bd:	c3                   	ret    
801074be:	66 90                	xchg   %ax,%ax
801074c0:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
801074c7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801074ca:	8d 65 f4             	lea    -0xc(%ebp),%esp
801074cd:	5b                   	pop    %ebx
801074ce:	5e                   	pop    %esi
801074cf:	5f                   	pop    %edi
801074d0:	5d                   	pop    %ebp
801074d1:	c3                   	ret    
801074d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801074d8:	83 ec 0c             	sub    $0xc,%esp
801074db:	68 bd 82 10 80       	push   $0x801082bd
801074e0:	e8 6b 92 ff ff       	call   80100750 <cprintf>
801074e5:	8b 45 0c             	mov    0xc(%ebp),%eax
801074e8:	83 c4 10             	add    $0x10,%esp
801074eb:	39 45 10             	cmp    %eax,0x10(%ebp)
801074ee:	74 0c                	je     801074fc <allocuvm+0x10c>
801074f0:	8b 55 10             	mov    0x10(%ebp),%edx
801074f3:	89 c1                	mov    %eax,%ecx
801074f5:	89 f8                	mov    %edi,%eax
801074f7:	e8 34 fa ff ff       	call   80106f30 <deallocuvm.part.0>
801074fc:	83 ec 0c             	sub    $0xc,%esp
801074ff:	53                   	push   %ebx
80107500:	e8 4b b7 ff ff       	call   80102c50 <kfree>
80107505:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
8010750c:	83 c4 10             	add    $0x10,%esp
8010750f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107512:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107515:	5b                   	pop    %ebx
80107516:	5e                   	pop    %esi
80107517:	5f                   	pop    %edi
80107518:	5d                   	pop    %ebp
80107519:	c3                   	ret    
8010751a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107520 <deallocuvm>:
80107520:	55                   	push   %ebp
80107521:	89 e5                	mov    %esp,%ebp
80107523:	8b 55 0c             	mov    0xc(%ebp),%edx
80107526:	8b 4d 10             	mov    0x10(%ebp),%ecx
80107529:	8b 45 08             	mov    0x8(%ebp),%eax
8010752c:	39 d1                	cmp    %edx,%ecx
8010752e:	73 10                	jae    80107540 <deallocuvm+0x20>
80107530:	5d                   	pop    %ebp
80107531:	e9 fa f9 ff ff       	jmp    80106f30 <deallocuvm.part.0>
80107536:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010753d:	8d 76 00             	lea    0x0(%esi),%esi
80107540:	89 d0                	mov    %edx,%eax
80107542:	5d                   	pop    %ebp
80107543:	c3                   	ret    
80107544:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010754b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010754f:	90                   	nop

80107550 <freevm>:
80107550:	55                   	push   %ebp
80107551:	89 e5                	mov    %esp,%ebp
80107553:	57                   	push   %edi
80107554:	56                   	push   %esi
80107555:	53                   	push   %ebx
80107556:	83 ec 0c             	sub    $0xc,%esp
80107559:	8b 75 08             	mov    0x8(%ebp),%esi
8010755c:	85 f6                	test   %esi,%esi
8010755e:	74 59                	je     801075b9 <freevm+0x69>
80107560:	31 c9                	xor    %ecx,%ecx
80107562:	ba 00 00 00 80       	mov    $0x80000000,%edx
80107567:	89 f0                	mov    %esi,%eax
80107569:	89 f3                	mov    %esi,%ebx
8010756b:	e8 c0 f9 ff ff       	call   80106f30 <deallocuvm.part.0>
80107570:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
80107576:	eb 0f                	jmp    80107587 <freevm+0x37>
80107578:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010757f:	90                   	nop
80107580:	83 c3 04             	add    $0x4,%ebx
80107583:	39 df                	cmp    %ebx,%edi
80107585:	74 23                	je     801075aa <freevm+0x5a>
80107587:	8b 03                	mov    (%ebx),%eax
80107589:	a8 01                	test   $0x1,%al
8010758b:	74 f3                	je     80107580 <freevm+0x30>
8010758d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107592:	83 ec 0c             	sub    $0xc,%esp
80107595:	83 c3 04             	add    $0x4,%ebx
80107598:	05 00 00 00 80       	add    $0x80000000,%eax
8010759d:	50                   	push   %eax
8010759e:	e8 ad b6 ff ff       	call   80102c50 <kfree>
801075a3:	83 c4 10             	add    $0x10,%esp
801075a6:	39 df                	cmp    %ebx,%edi
801075a8:	75 dd                	jne    80107587 <freevm+0x37>
801075aa:	89 75 08             	mov    %esi,0x8(%ebp)
801075ad:	8d 65 f4             	lea    -0xc(%ebp),%esp
801075b0:	5b                   	pop    %ebx
801075b1:	5e                   	pop    %esi
801075b2:	5f                   	pop    %edi
801075b3:	5d                   	pop    %ebp
801075b4:	e9 97 b6 ff ff       	jmp    80102c50 <kfree>
801075b9:	83 ec 0c             	sub    $0xc,%esp
801075bc:	68 d9 82 10 80       	push   $0x801082d9
801075c1:	e8 da 8d ff ff       	call   801003a0 <panic>
801075c6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801075cd:	8d 76 00             	lea    0x0(%esi),%esi

801075d0 <setupkvm>:
801075d0:	55                   	push   %ebp
801075d1:	89 e5                	mov    %esp,%ebp
801075d3:	56                   	push   %esi
801075d4:	53                   	push   %ebx
801075d5:	e8 36 b8 ff ff       	call   80102e10 <kalloc>
801075da:	89 c6                	mov    %eax,%esi
801075dc:	85 c0                	test   %eax,%eax
801075de:	74 42                	je     80107622 <setupkvm+0x52>
801075e0:	83 ec 04             	sub    $0x4,%esp
801075e3:	bb 20 b4 10 80       	mov    $0x8010b420,%ebx
801075e8:	68 00 10 00 00       	push   $0x1000
801075ed:	6a 00                	push   $0x0
801075ef:	50                   	push   %eax
801075f0:	e8 fb d7 ff ff       	call   80104df0 <memset>
801075f5:	83 c4 10             	add    $0x10,%esp
801075f8:	8b 43 04             	mov    0x4(%ebx),%eax
801075fb:	83 ec 08             	sub    $0x8,%esp
801075fe:	8b 4b 08             	mov    0x8(%ebx),%ecx
80107601:	ff 73 0c             	push   0xc(%ebx)
80107604:	8b 13                	mov    (%ebx),%edx
80107606:	50                   	push   %eax
80107607:	29 c1                	sub    %eax,%ecx
80107609:	89 f0                	mov    %esi,%eax
8010760b:	e8 d0 f9 ff ff       	call   80106fe0 <mappages>
80107610:	83 c4 10             	add    $0x10,%esp
80107613:	85 c0                	test   %eax,%eax
80107615:	78 19                	js     80107630 <setupkvm+0x60>
80107617:	83 c3 10             	add    $0x10,%ebx
8010761a:	81 fb 60 b4 10 80    	cmp    $0x8010b460,%ebx
80107620:	75 d6                	jne    801075f8 <setupkvm+0x28>
80107622:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107625:	89 f0                	mov    %esi,%eax
80107627:	5b                   	pop    %ebx
80107628:	5e                   	pop    %esi
80107629:	5d                   	pop    %ebp
8010762a:	c3                   	ret    
8010762b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010762f:	90                   	nop
80107630:	83 ec 0c             	sub    $0xc,%esp
80107633:	56                   	push   %esi
80107634:	31 f6                	xor    %esi,%esi
80107636:	e8 15 ff ff ff       	call   80107550 <freevm>
8010763b:	83 c4 10             	add    $0x10,%esp
8010763e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107641:	89 f0                	mov    %esi,%eax
80107643:	5b                   	pop    %ebx
80107644:	5e                   	pop    %esi
80107645:	5d                   	pop    %ebp
80107646:	c3                   	ret    
80107647:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010764e:	66 90                	xchg   %ax,%ax

80107650 <kvmalloc>:
80107650:	55                   	push   %ebp
80107651:	89 e5                	mov    %esp,%ebp
80107653:	83 ec 08             	sub    $0x8,%esp
80107656:	e8 75 ff ff ff       	call   801075d0 <setupkvm>
8010765b:	a3 04 61 11 80       	mov    %eax,0x80116104
80107660:	05 00 00 00 80       	add    $0x80000000,%eax
80107665:	0f 22 d8             	mov    %eax,%cr3
80107668:	c9                   	leave  
80107669:	c3                   	ret    
8010766a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107670 <clearpteu>:
80107670:	55                   	push   %ebp
80107671:	89 e5                	mov    %esp,%ebp
80107673:	83 ec 08             	sub    $0x8,%esp
80107676:	8b 45 0c             	mov    0xc(%ebp),%eax
80107679:	8b 55 08             	mov    0x8(%ebp),%edx
8010767c:	89 c1                	mov    %eax,%ecx
8010767e:	c1 e9 16             	shr    $0x16,%ecx
80107681:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
80107684:	f6 c2 01             	test   $0x1,%dl
80107687:	75 17                	jne    801076a0 <clearpteu+0x30>
80107689:	83 ec 0c             	sub    $0xc,%esp
8010768c:	68 ea 82 10 80       	push   $0x801082ea
80107691:	e8 0a 8d ff ff       	call   801003a0 <panic>
80107696:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010769d:	8d 76 00             	lea    0x0(%esi),%esi
801076a0:	c1 e8 0a             	shr    $0xa,%eax
801076a3:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
801076a9:	25 fc 0f 00 00       	and    $0xffc,%eax
801076ae:	8d 84 02 00 00 00 80 	lea    -0x80000000(%edx,%eax,1),%eax
801076b5:	85 c0                	test   %eax,%eax
801076b7:	74 d0                	je     80107689 <clearpteu+0x19>
801076b9:	83 20 fb             	andl   $0xfffffffb,(%eax)
801076bc:	c9                   	leave  
801076bd:	c3                   	ret    
801076be:	66 90                	xchg   %ax,%ax

801076c0 <copyuvm>:
801076c0:	55                   	push   %ebp
801076c1:	89 e5                	mov    %esp,%ebp
801076c3:	57                   	push   %edi
801076c4:	56                   	push   %esi
801076c5:	53                   	push   %ebx
801076c6:	83 ec 1c             	sub    $0x1c,%esp
801076c9:	e8 02 ff ff ff       	call   801075d0 <setupkvm>
801076ce:	89 45 e0             	mov    %eax,-0x20(%ebp)
801076d1:	85 c0                	test   %eax,%eax
801076d3:	0f 84 bd 00 00 00    	je     80107796 <copyuvm+0xd6>
801076d9:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801076dc:	85 c9                	test   %ecx,%ecx
801076de:	0f 84 b2 00 00 00    	je     80107796 <copyuvm+0xd6>
801076e4:	31 f6                	xor    %esi,%esi
801076e6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801076ed:	8d 76 00             	lea    0x0(%esi),%esi
801076f0:	8b 4d 08             	mov    0x8(%ebp),%ecx
801076f3:	89 f0                	mov    %esi,%eax
801076f5:	c1 e8 16             	shr    $0x16,%eax
801076f8:	8b 04 81             	mov    (%ecx,%eax,4),%eax
801076fb:	a8 01                	test   $0x1,%al
801076fd:	75 11                	jne    80107710 <copyuvm+0x50>
801076ff:	83 ec 0c             	sub    $0xc,%esp
80107702:	68 f4 82 10 80       	push   $0x801082f4
80107707:	e8 94 8c ff ff       	call   801003a0 <panic>
8010770c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107710:	89 f2                	mov    %esi,%edx
80107712:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107717:	c1 ea 0a             	shr    $0xa,%edx
8010771a:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80107720:	8d 84 10 00 00 00 80 	lea    -0x80000000(%eax,%edx,1),%eax
80107727:	85 c0                	test   %eax,%eax
80107729:	74 d4                	je     801076ff <copyuvm+0x3f>
8010772b:	8b 00                	mov    (%eax),%eax
8010772d:	a8 01                	test   $0x1,%al
8010772f:	0f 84 9f 00 00 00    	je     801077d4 <copyuvm+0x114>
80107735:	89 c7                	mov    %eax,%edi
80107737:	25 ff 0f 00 00       	and    $0xfff,%eax
8010773c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010773f:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
80107745:	e8 c6 b6 ff ff       	call   80102e10 <kalloc>
8010774a:	89 c3                	mov    %eax,%ebx
8010774c:	85 c0                	test   %eax,%eax
8010774e:	74 64                	je     801077b4 <copyuvm+0xf4>
80107750:	83 ec 04             	sub    $0x4,%esp
80107753:	81 c7 00 00 00 80    	add    $0x80000000,%edi
80107759:	68 00 10 00 00       	push   $0x1000
8010775e:	57                   	push   %edi
8010775f:	50                   	push   %eax
80107760:	e8 2b d7 ff ff       	call   80104e90 <memmove>
80107765:	58                   	pop    %eax
80107766:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
8010776c:	5a                   	pop    %edx
8010776d:	ff 75 e4             	push   -0x1c(%ebp)
80107770:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107775:	89 f2                	mov    %esi,%edx
80107777:	50                   	push   %eax
80107778:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010777b:	e8 60 f8 ff ff       	call   80106fe0 <mappages>
80107780:	83 c4 10             	add    $0x10,%esp
80107783:	85 c0                	test   %eax,%eax
80107785:	78 21                	js     801077a8 <copyuvm+0xe8>
80107787:	81 c6 00 10 00 00    	add    $0x1000,%esi
8010778d:	39 75 0c             	cmp    %esi,0xc(%ebp)
80107790:	0f 87 5a ff ff ff    	ja     801076f0 <copyuvm+0x30>
80107796:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107799:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010779c:	5b                   	pop    %ebx
8010779d:	5e                   	pop    %esi
8010779e:	5f                   	pop    %edi
8010779f:	5d                   	pop    %ebp
801077a0:	c3                   	ret    
801077a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801077a8:	83 ec 0c             	sub    $0xc,%esp
801077ab:	53                   	push   %ebx
801077ac:	e8 9f b4 ff ff       	call   80102c50 <kfree>
801077b1:	83 c4 10             	add    $0x10,%esp
801077b4:	83 ec 0c             	sub    $0xc,%esp
801077b7:	ff 75 e0             	push   -0x20(%ebp)
801077ba:	e8 91 fd ff ff       	call   80107550 <freevm>
801077bf:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
801077c6:	83 c4 10             	add    $0x10,%esp
801077c9:	8b 45 e0             	mov    -0x20(%ebp),%eax
801077cc:	8d 65 f4             	lea    -0xc(%ebp),%esp
801077cf:	5b                   	pop    %ebx
801077d0:	5e                   	pop    %esi
801077d1:	5f                   	pop    %edi
801077d2:	5d                   	pop    %ebp
801077d3:	c3                   	ret    
801077d4:	83 ec 0c             	sub    $0xc,%esp
801077d7:	68 0e 83 10 80       	push   $0x8010830e
801077dc:	e8 bf 8b ff ff       	call   801003a0 <panic>
801077e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801077e8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801077ef:	90                   	nop

801077f0 <uva2ka>:
801077f0:	55                   	push   %ebp
801077f1:	89 e5                	mov    %esp,%ebp
801077f3:	8b 45 0c             	mov    0xc(%ebp),%eax
801077f6:	8b 55 08             	mov    0x8(%ebp),%edx
801077f9:	89 c1                	mov    %eax,%ecx
801077fb:	c1 e9 16             	shr    $0x16,%ecx
801077fe:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
80107801:	f6 c2 01             	test   $0x1,%dl
80107804:	0f 84 00 01 00 00    	je     8010790a <uva2ka.cold>
8010780a:	c1 e8 0c             	shr    $0xc,%eax
8010780d:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80107813:	5d                   	pop    %ebp
80107814:	25 ff 03 00 00       	and    $0x3ff,%eax
80107819:	8b 84 82 00 00 00 80 	mov    -0x80000000(%edx,%eax,4),%eax
80107820:	89 c2                	mov    %eax,%edx
80107822:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107827:	83 e2 05             	and    $0x5,%edx
8010782a:	05 00 00 00 80       	add    $0x80000000,%eax
8010782f:	83 fa 05             	cmp    $0x5,%edx
80107832:	ba 00 00 00 00       	mov    $0x0,%edx
80107837:	0f 45 c2             	cmovne %edx,%eax
8010783a:	c3                   	ret    
8010783b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010783f:	90                   	nop

80107840 <copyout>:
80107840:	55                   	push   %ebp
80107841:	89 e5                	mov    %esp,%ebp
80107843:	57                   	push   %edi
80107844:	56                   	push   %esi
80107845:	53                   	push   %ebx
80107846:	83 ec 0c             	sub    $0xc,%esp
80107849:	8b 75 14             	mov    0x14(%ebp),%esi
8010784c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010784f:	8b 55 10             	mov    0x10(%ebp),%edx
80107852:	85 f6                	test   %esi,%esi
80107854:	75 51                	jne    801078a7 <copyout+0x67>
80107856:	e9 a5 00 00 00       	jmp    80107900 <copyout+0xc0>
8010785b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010785f:	90                   	nop
80107860:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
80107866:	8d 8b 00 00 00 80    	lea    -0x80000000(%ebx),%ecx
8010786c:	81 fb 00 00 00 80    	cmp    $0x80000000,%ebx
80107872:	74 75                	je     801078e9 <copyout+0xa9>
80107874:	89 fb                	mov    %edi,%ebx
80107876:	89 55 10             	mov    %edx,0x10(%ebp)
80107879:	29 c3                	sub    %eax,%ebx
8010787b:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80107881:	39 f3                	cmp    %esi,%ebx
80107883:	0f 47 de             	cmova  %esi,%ebx
80107886:	29 f8                	sub    %edi,%eax
80107888:	83 ec 04             	sub    $0x4,%esp
8010788b:	01 c1                	add    %eax,%ecx
8010788d:	53                   	push   %ebx
8010788e:	52                   	push   %edx
8010788f:	51                   	push   %ecx
80107890:	e8 fb d5 ff ff       	call   80104e90 <memmove>
80107895:	8b 55 10             	mov    0x10(%ebp),%edx
80107898:	8d 87 00 10 00 00    	lea    0x1000(%edi),%eax
8010789e:	83 c4 10             	add    $0x10,%esp
801078a1:	01 da                	add    %ebx,%edx
801078a3:	29 de                	sub    %ebx,%esi
801078a5:	74 59                	je     80107900 <copyout+0xc0>
801078a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
801078aa:	89 c1                	mov    %eax,%ecx
801078ac:	89 c7                	mov    %eax,%edi
801078ae:	c1 e9 16             	shr    $0x16,%ecx
801078b1:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
801078b7:	8b 0c 8b             	mov    (%ebx,%ecx,4),%ecx
801078ba:	f6 c1 01             	test   $0x1,%cl
801078bd:	0f 84 4e 00 00 00    	je     80107911 <copyout.cold>
801078c3:	89 fb                	mov    %edi,%ebx
801078c5:	81 e1 00 f0 ff ff    	and    $0xfffff000,%ecx
801078cb:	c1 eb 0c             	shr    $0xc,%ebx
801078ce:	81 e3 ff 03 00 00    	and    $0x3ff,%ebx
801078d4:	8b 9c 99 00 00 00 80 	mov    -0x80000000(%ecx,%ebx,4),%ebx
801078db:	89 d9                	mov    %ebx,%ecx
801078dd:	83 e1 05             	and    $0x5,%ecx
801078e0:	83 f9 05             	cmp    $0x5,%ecx
801078e3:	0f 84 77 ff ff ff    	je     80107860 <copyout+0x20>
801078e9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801078ec:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801078f1:	5b                   	pop    %ebx
801078f2:	5e                   	pop    %esi
801078f3:	5f                   	pop    %edi
801078f4:	5d                   	pop    %ebp
801078f5:	c3                   	ret    
801078f6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801078fd:	8d 76 00             	lea    0x0(%esi),%esi
80107900:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107903:	31 c0                	xor    %eax,%eax
80107905:	5b                   	pop    %ebx
80107906:	5e                   	pop    %esi
80107907:	5f                   	pop    %edi
80107908:	5d                   	pop    %ebp
80107909:	c3                   	ret    

8010790a <uva2ka.cold>:
8010790a:	a1 00 00 00 00       	mov    0x0,%eax
8010790f:	0f 0b                	ud2    

80107911 <copyout.cold>:
80107911:	a1 00 00 00 00       	mov    0x0,%eax
80107916:	0f 0b                	ud2    
