
_cat:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
    exit();
  }
}

int main(int argc, char *argv[])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	push   -0x4(%ecx)
  int fd, i;

  if (argc <= 1)
   a:	83 39 01             	cmpl   $0x1,(%ecx)
{
   d:	55                   	push   %ebp
   e:	89 e5                	mov    %esp,%ebp
  10:	53                   	push   %ebx
  11:	51                   	push   %ecx
  12:	8b 59 04             	mov    0x4(%ecx),%ebx
  if (argc <= 1)
  15:	7e 31                	jle    48 <main+0x48>
    exit();
  }

  for (i = 1; i < argc; i++)
  {
    if ((fd = open(argv[i], 0)) < 0)
  17:	52                   	push   %edx
  18:	52                   	push   %edx
  19:	6a 00                	push   $0x0
  1b:	ff 73 04             	push   0x4(%ebx)
  1e:	e8 50 03 00 00       	call   373 <open>
  23:	83 c4 10             	add    $0x10,%esp
  26:	85 c0                	test   %eax,%eax
  28:	78 09                	js     33 <main+0x33>
    {
      printf(1, "cat: cannot open %s\n", argv[i]);
      exit();
    }
    cat(fd);
  2a:	83 ec 0c             	sub    $0xc,%esp
  2d:	50                   	push   %eax
  2e:	e8 2d 00 00 00       	call   60 <cat>
      printf(1, "cat: cannot open %s\n", argv[i]);
  33:	50                   	push   %eax
  34:	ff 73 04             	push   0x4(%ebx)
  37:	68 db 07 00 00       	push   $0x7db
  3c:	6a 01                	push   $0x1
  3e:	e8 4d 04 00 00       	call   490 <printf>
      exit();
  43:	e8 eb 02 00 00       	call   333 <exit>
    cat(0);
  48:	83 ec 0c             	sub    $0xc,%esp
  4b:	6a 00                	push   $0x0
  4d:	e8 0e 00 00 00       	call   60 <cat>
  52:	66 90                	xchg   %ax,%ax
  54:	66 90                	xchg   %ax,%ax
  56:	66 90                	xchg   %ax,%ax
  58:	66 90                	xchg   %ax,%ax
  5a:	66 90                	xchg   %ax,%ax
  5c:	66 90                	xchg   %ax,%ax
  5e:	66 90                	xchg   %ax,%ax

00000060 <cat>:
{
  60:	55                   	push   %ebp
  61:	89 e5                	mov    %esp,%ebp
  63:	56                   	push   %esi
  64:	8b 75 08             	mov    0x8(%ebp),%esi
  67:	53                   	push   %ebx
  while ((n = read(fd, buf, sizeof(buf))) > 0)
  68:	eb 1d                	jmp    87 <cat+0x27>
  6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if (write(1, buf, n) != n)
  70:	83 ec 04             	sub    $0x4,%esp
  73:	53                   	push   %ebx
  74:	68 20 0b 00 00       	push   $0xb20
  79:	6a 01                	push   $0x1
  7b:	e8 d3 02 00 00       	call   353 <write>
  80:	83 c4 10             	add    $0x10,%esp
  83:	39 d8                	cmp    %ebx,%eax
  85:	75 44                	jne    cb <cat+0x6b>
  while ((n = read(fd, buf, sizeof(buf))) > 0)
  87:	83 ec 04             	sub    $0x4,%esp
  8a:	68 00 02 00 00       	push   $0x200
  8f:	68 20 0b 00 00       	push   $0xb20
  94:	56                   	push   %esi
  95:	e8 b1 02 00 00       	call   34b <read>
  9a:	83 c4 10             	add    $0x10,%esp
  9d:	89 c3                	mov    %eax,%ebx
  9f:	85 c0                	test   %eax,%eax
  a1:	7f cd                	jg     70 <cat+0x10>
  if (n < 0)
  a3:	74 13                	je     b8 <cat+0x58>
    printf(1, "cat: read error\n");
  a5:	52                   	push   %edx
  a6:	52                   	push   %edx
  a7:	68 ca 07 00 00       	push   $0x7ca
  ac:	6a 01                	push   $0x1
  ae:	e8 dd 03 00 00       	call   490 <printf>
    exit();
  b3:	e8 7b 02 00 00       	call   333 <exit>
    printf(1, "\n");
  b8:	50                   	push   %eax
  b9:	50                   	push   %eax
  ba:	68 d9 07 00 00       	push   $0x7d9
  bf:	6a 01                	push   $0x1
  c1:	e8 ca 03 00 00       	call   490 <printf>
    exit();
  c6:	e8 68 02 00 00       	call   333 <exit>
      printf(1, "cat: write error\n");
  cb:	51                   	push   %ecx
  cc:	51                   	push   %ecx
  cd:	68 b8 07 00 00       	push   $0x7b8
  d2:	6a 01                	push   $0x1
  d4:	e8 b7 03 00 00       	call   490 <printf>
      exit();
  d9:	e8 55 02 00 00       	call   333 <exit>
  de:	66 90                	xchg   %ax,%ax

000000e0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  e0:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  e1:	31 c0                	xor    %eax,%eax
{
  e3:	89 e5                	mov    %esp,%ebp
  e5:	53                   	push   %ebx
  e6:	8b 4d 08             	mov    0x8(%ebp),%ecx
  e9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
  f0:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
  f4:	88 14 01             	mov    %dl,(%ecx,%eax,1)
  f7:	83 c0 01             	add    $0x1,%eax
  fa:	84 d2                	test   %dl,%dl
  fc:	75 f2                	jne    f0 <strcpy+0x10>
    ;
  return os;
}
  fe:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 101:	89 c8                	mov    %ecx,%eax
 103:	c9                   	leave  
 104:	c3                   	ret    
 105:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 10c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000110 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 110:	55                   	push   %ebp
 111:	89 e5                	mov    %esp,%ebp
 113:	53                   	push   %ebx
 114:	8b 55 08             	mov    0x8(%ebp),%edx
 117:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 11a:	0f b6 02             	movzbl (%edx),%eax
 11d:	84 c0                	test   %al,%al
 11f:	75 17                	jne    138 <strcmp+0x28>
 121:	eb 3a                	jmp    15d <strcmp+0x4d>
 123:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 127:	90                   	nop
 128:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
 12c:	83 c2 01             	add    $0x1,%edx
 12f:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
 132:	84 c0                	test   %al,%al
 134:	74 1a                	je     150 <strcmp+0x40>
    p++, q++;
 136:	89 d9                	mov    %ebx,%ecx
  while(*p && *p == *q)
 138:	0f b6 19             	movzbl (%ecx),%ebx
 13b:	38 c3                	cmp    %al,%bl
 13d:	74 e9                	je     128 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
 13f:	29 d8                	sub    %ebx,%eax
}
 141:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 144:	c9                   	leave  
 145:	c3                   	ret    
 146:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 14d:	8d 76 00             	lea    0x0(%esi),%esi
  return (uchar)*p - (uchar)*q;
 150:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 154:	31 c0                	xor    %eax,%eax
 156:	29 d8                	sub    %ebx,%eax
}
 158:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 15b:	c9                   	leave  
 15c:	c3                   	ret    
  return (uchar)*p - (uchar)*q;
 15d:	0f b6 19             	movzbl (%ecx),%ebx
 160:	31 c0                	xor    %eax,%eax
 162:	eb db                	jmp    13f <strcmp+0x2f>
 164:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 16b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 16f:	90                   	nop

00000170 <strlen>:

uint
strlen(const char *s)
{
 170:	55                   	push   %ebp
 171:	89 e5                	mov    %esp,%ebp
 173:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 176:	80 3a 00             	cmpb   $0x0,(%edx)
 179:	74 15                	je     190 <strlen+0x20>
 17b:	31 c0                	xor    %eax,%eax
 17d:	8d 76 00             	lea    0x0(%esi),%esi
 180:	83 c0 01             	add    $0x1,%eax
 183:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 187:	89 c1                	mov    %eax,%ecx
 189:	75 f5                	jne    180 <strlen+0x10>
    ;
  return n;
}
 18b:	89 c8                	mov    %ecx,%eax
 18d:	5d                   	pop    %ebp
 18e:	c3                   	ret    
 18f:	90                   	nop
  for(n = 0; s[n]; n++)
 190:	31 c9                	xor    %ecx,%ecx
}
 192:	5d                   	pop    %ebp
 193:	89 c8                	mov    %ecx,%eax
 195:	c3                   	ret    
 196:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 19d:	8d 76 00             	lea    0x0(%esi),%esi

000001a0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1a0:	55                   	push   %ebp
 1a1:	89 e5                	mov    %esp,%ebp
 1a3:	57                   	push   %edi
 1a4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" : "=D"(addr), "=c"(cnt) : "0"(addr), "1"(cnt), "a"(data) : "memory", "cc");
 1a7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 1aa:	8b 45 0c             	mov    0xc(%ebp),%eax
 1ad:	89 d7                	mov    %edx,%edi
 1af:	fc                   	cld    
 1b0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 1b2:	8b 7d fc             	mov    -0x4(%ebp),%edi
 1b5:	89 d0                	mov    %edx,%eax
 1b7:	c9                   	leave  
 1b8:	c3                   	ret    
 1b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000001c0 <strchr>:

char*
strchr(const char *s, char c)
{
 1c0:	55                   	push   %ebp
 1c1:	89 e5                	mov    %esp,%ebp
 1c3:	8b 45 08             	mov    0x8(%ebp),%eax
 1c6:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 1ca:	0f b6 10             	movzbl (%eax),%edx
 1cd:	84 d2                	test   %dl,%dl
 1cf:	75 12                	jne    1e3 <strchr+0x23>
 1d1:	eb 1d                	jmp    1f0 <strchr+0x30>
 1d3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1d7:	90                   	nop
 1d8:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 1dc:	83 c0 01             	add    $0x1,%eax
 1df:	84 d2                	test   %dl,%dl
 1e1:	74 0d                	je     1f0 <strchr+0x30>
    if(*s == c)
 1e3:	38 d1                	cmp    %dl,%cl
 1e5:	75 f1                	jne    1d8 <strchr+0x18>
      return (char*)s;
  return 0;
}
 1e7:	5d                   	pop    %ebp
 1e8:	c3                   	ret    
 1e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 1f0:	31 c0                	xor    %eax,%eax
}
 1f2:	5d                   	pop    %ebp
 1f3:	c3                   	ret    
 1f4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1fb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1ff:	90                   	nop

00000200 <gets>:

char*
gets(char *buf, int max)
{
 200:	55                   	push   %ebp
 201:	89 e5                	mov    %esp,%ebp
 203:	57                   	push   %edi
 204:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 205:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
 208:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
 209:	31 db                	xor    %ebx,%ebx
{
 20b:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
 20e:	eb 27                	jmp    237 <gets+0x37>
    cc = read(0, &c, 1);
 210:	83 ec 04             	sub    $0x4,%esp
 213:	6a 01                	push   $0x1
 215:	57                   	push   %edi
 216:	6a 00                	push   $0x0
 218:	e8 2e 01 00 00       	call   34b <read>
    if(cc < 1)
 21d:	83 c4 10             	add    $0x10,%esp
 220:	85 c0                	test   %eax,%eax
 222:	7e 1d                	jle    241 <gets+0x41>
      break;
    buf[i++] = c;
 224:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 228:	8b 55 08             	mov    0x8(%ebp),%edx
 22b:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 22f:	3c 0a                	cmp    $0xa,%al
 231:	74 1d                	je     250 <gets+0x50>
 233:	3c 0d                	cmp    $0xd,%al
 235:	74 19                	je     250 <gets+0x50>
  for(i=0; i+1 < max; ){
 237:	89 de                	mov    %ebx,%esi
 239:	83 c3 01             	add    $0x1,%ebx
 23c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 23f:	7c cf                	jl     210 <gets+0x10>
      break;
  }
  buf[i] = '\0';
 241:	8b 45 08             	mov    0x8(%ebp),%eax
 244:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 248:	8d 65 f4             	lea    -0xc(%ebp),%esp
 24b:	5b                   	pop    %ebx
 24c:	5e                   	pop    %esi
 24d:	5f                   	pop    %edi
 24e:	5d                   	pop    %ebp
 24f:	c3                   	ret    
  buf[i] = '\0';
 250:	8b 45 08             	mov    0x8(%ebp),%eax
 253:	89 de                	mov    %ebx,%esi
 255:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
}
 259:	8d 65 f4             	lea    -0xc(%ebp),%esp
 25c:	5b                   	pop    %ebx
 25d:	5e                   	pop    %esi
 25e:	5f                   	pop    %edi
 25f:	5d                   	pop    %ebp
 260:	c3                   	ret    
 261:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 268:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 26f:	90                   	nop

00000270 <stat>:

int
stat(const char *n, struct stat *st)
{
 270:	55                   	push   %ebp
 271:	89 e5                	mov    %esp,%ebp
 273:	56                   	push   %esi
 274:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 275:	83 ec 08             	sub    $0x8,%esp
 278:	6a 00                	push   $0x0
 27a:	ff 75 08             	push   0x8(%ebp)
 27d:	e8 f1 00 00 00       	call   373 <open>
  if(fd < 0)
 282:	83 c4 10             	add    $0x10,%esp
 285:	85 c0                	test   %eax,%eax
 287:	78 27                	js     2b0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 289:	83 ec 08             	sub    $0x8,%esp
 28c:	ff 75 0c             	push   0xc(%ebp)
 28f:	89 c3                	mov    %eax,%ebx
 291:	50                   	push   %eax
 292:	e8 f4 00 00 00       	call   38b <fstat>
  close(fd);
 297:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 29a:	89 c6                	mov    %eax,%esi
  close(fd);
 29c:	e8 ba 00 00 00       	call   35b <close>
  return r;
 2a1:	83 c4 10             	add    $0x10,%esp
}
 2a4:	8d 65 f8             	lea    -0x8(%ebp),%esp
 2a7:	89 f0                	mov    %esi,%eax
 2a9:	5b                   	pop    %ebx
 2aa:	5e                   	pop    %esi
 2ab:	5d                   	pop    %ebp
 2ac:	c3                   	ret    
 2ad:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 2b0:	be ff ff ff ff       	mov    $0xffffffff,%esi
 2b5:	eb ed                	jmp    2a4 <stat+0x34>
 2b7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 2be:	66 90                	xchg   %ax,%ax

000002c0 <atoi>:

int
atoi(const char *s)
{
 2c0:	55                   	push   %ebp
 2c1:	89 e5                	mov    %esp,%ebp
 2c3:	53                   	push   %ebx
 2c4:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2c7:	0f be 02             	movsbl (%edx),%eax
 2ca:	8d 48 d0             	lea    -0x30(%eax),%ecx
 2cd:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 2d0:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 2d5:	77 1e                	ja     2f5 <atoi+0x35>
 2d7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 2de:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 2e0:	83 c2 01             	add    $0x1,%edx
 2e3:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 2e6:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 2ea:	0f be 02             	movsbl (%edx),%eax
 2ed:	8d 58 d0             	lea    -0x30(%eax),%ebx
 2f0:	80 fb 09             	cmp    $0x9,%bl
 2f3:	76 eb                	jbe    2e0 <atoi+0x20>
  return n;
}
 2f5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 2f8:	89 c8                	mov    %ecx,%eax
 2fa:	c9                   	leave  
 2fb:	c3                   	ret    
 2fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000300 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 300:	55                   	push   %ebp
 301:	89 e5                	mov    %esp,%ebp
 303:	57                   	push   %edi
 304:	8b 45 10             	mov    0x10(%ebp),%eax
 307:	8b 55 08             	mov    0x8(%ebp),%edx
 30a:	56                   	push   %esi
 30b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 30e:	85 c0                	test   %eax,%eax
 310:	7e 13                	jle    325 <memmove+0x25>
 312:	01 d0                	add    %edx,%eax
  dst = vdst;
 314:	89 d7                	mov    %edx,%edi
 316:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 31d:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
 320:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 321:	39 f8                	cmp    %edi,%eax
 323:	75 fb                	jne    320 <memmove+0x20>
  return vdst;
}
 325:	5e                   	pop    %esi
 326:	89 d0                	mov    %edx,%eax
 328:	5f                   	pop    %edi
 329:	5d                   	pop    %ebp
 32a:	c3                   	ret    

0000032b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 32b:	b8 01 00 00 00       	mov    $0x1,%eax
 330:	cd 40                	int    $0x40
 332:	c3                   	ret    

00000333 <exit>:
SYSCALL(exit)
 333:	b8 02 00 00 00       	mov    $0x2,%eax
 338:	cd 40                	int    $0x40
 33a:	c3                   	ret    

0000033b <wait>:
SYSCALL(wait)
 33b:	b8 03 00 00 00       	mov    $0x3,%eax
 340:	cd 40                	int    $0x40
 342:	c3                   	ret    

00000343 <pipe>:
SYSCALL(pipe)
 343:	b8 04 00 00 00       	mov    $0x4,%eax
 348:	cd 40                	int    $0x40
 34a:	c3                   	ret    

0000034b <read>:
SYSCALL(read)
 34b:	b8 05 00 00 00       	mov    $0x5,%eax
 350:	cd 40                	int    $0x40
 352:	c3                   	ret    

00000353 <write>:
SYSCALL(write)
 353:	b8 10 00 00 00       	mov    $0x10,%eax
 358:	cd 40                	int    $0x40
 35a:	c3                   	ret    

0000035b <close>:
SYSCALL(close)
 35b:	b8 15 00 00 00       	mov    $0x15,%eax
 360:	cd 40                	int    $0x40
 362:	c3                   	ret    

00000363 <kill>:
SYSCALL(kill)
 363:	b8 06 00 00 00       	mov    $0x6,%eax
 368:	cd 40                	int    $0x40
 36a:	c3                   	ret    

0000036b <exec>:
SYSCALL(exec)
 36b:	b8 07 00 00 00       	mov    $0x7,%eax
 370:	cd 40                	int    $0x40
 372:	c3                   	ret    

00000373 <open>:
SYSCALL(open)
 373:	b8 0f 00 00 00       	mov    $0xf,%eax
 378:	cd 40                	int    $0x40
 37a:	c3                   	ret    

0000037b <mknod>:
SYSCALL(mknod)
 37b:	b8 11 00 00 00       	mov    $0x11,%eax
 380:	cd 40                	int    $0x40
 382:	c3                   	ret    

00000383 <unlink>:
SYSCALL(unlink)
 383:	b8 12 00 00 00       	mov    $0x12,%eax
 388:	cd 40                	int    $0x40
 38a:	c3                   	ret    

0000038b <fstat>:
SYSCALL(fstat)
 38b:	b8 08 00 00 00       	mov    $0x8,%eax
 390:	cd 40                	int    $0x40
 392:	c3                   	ret    

00000393 <link>:
SYSCALL(link)
 393:	b8 13 00 00 00       	mov    $0x13,%eax
 398:	cd 40                	int    $0x40
 39a:	c3                   	ret    

0000039b <mkdir>:
SYSCALL(mkdir)
 39b:	b8 14 00 00 00       	mov    $0x14,%eax
 3a0:	cd 40                	int    $0x40
 3a2:	c3                   	ret    

000003a3 <chdir>:
SYSCALL(chdir)
 3a3:	b8 09 00 00 00       	mov    $0x9,%eax
 3a8:	cd 40                	int    $0x40
 3aa:	c3                   	ret    

000003ab <dup>:
SYSCALL(dup)
 3ab:	b8 0a 00 00 00       	mov    $0xa,%eax
 3b0:	cd 40                	int    $0x40
 3b2:	c3                   	ret    

000003b3 <getpid>:
SYSCALL(getpid)
 3b3:	b8 0b 00 00 00       	mov    $0xb,%eax
 3b8:	cd 40                	int    $0x40
 3ba:	c3                   	ret    

000003bb <sbrk>:
SYSCALL(sbrk)
 3bb:	b8 0c 00 00 00       	mov    $0xc,%eax
 3c0:	cd 40                	int    $0x40
 3c2:	c3                   	ret    

000003c3 <sleep>:
SYSCALL(sleep)
 3c3:	b8 0d 00 00 00       	mov    $0xd,%eax
 3c8:	cd 40                	int    $0x40
 3ca:	c3                   	ret    

000003cb <uptime>:
SYSCALL(uptime)
 3cb:	b8 0e 00 00 00       	mov    $0xe,%eax
 3d0:	cd 40                	int    $0x40
 3d2:	c3                   	ret    

000003d3 <find_digital_root>:
SYSCALL(find_digital_root)
 3d3:	b8 16 00 00 00       	mov    $0x16,%eax
 3d8:	cd 40                	int    $0x40
 3da:	c3                   	ret    
 3db:	66 90                	xchg   %ax,%ax
 3dd:	66 90                	xchg   %ax,%ax
 3df:	90                   	nop

000003e0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 3e0:	55                   	push   %ebp
 3e1:	89 e5                	mov    %esp,%ebp
 3e3:	57                   	push   %edi
 3e4:	56                   	push   %esi
 3e5:	53                   	push   %ebx
 3e6:	83 ec 3c             	sub    $0x3c,%esp
 3e9:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 3ec:	89 d1                	mov    %edx,%ecx
{
 3ee:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
 3f1:	85 d2                	test   %edx,%edx
 3f3:	0f 89 7f 00 00 00    	jns    478 <printint+0x98>
 3f9:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 3fd:	74 79                	je     478 <printint+0x98>
    neg = 1;
 3ff:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
 406:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
 408:	31 db                	xor    %ebx,%ebx
 40a:	8d 75 d7             	lea    -0x29(%ebp),%esi
 40d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 410:	89 c8                	mov    %ecx,%eax
 412:	31 d2                	xor    %edx,%edx
 414:	89 cf                	mov    %ecx,%edi
 416:	f7 75 c4             	divl   -0x3c(%ebp)
 419:	0f b6 92 50 08 00 00 	movzbl 0x850(%edx),%edx
 420:	89 45 c0             	mov    %eax,-0x40(%ebp)
 423:	89 d8                	mov    %ebx,%eax
 425:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
 428:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    buf[i++] = digits[x % base];
 42b:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
 42e:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
 431:	76 dd                	jbe    410 <printint+0x30>
  if(neg)
 433:	8b 4d bc             	mov    -0x44(%ebp),%ecx
 436:	85 c9                	test   %ecx,%ecx
 438:	74 0c                	je     446 <printint+0x66>
    buf[i++] = '-';
 43a:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
 43f:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
 441:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
 446:	8b 7d b8             	mov    -0x48(%ebp),%edi
 449:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
 44d:	eb 07                	jmp    456 <printint+0x76>
 44f:	90                   	nop
    putc(fd, buf[i]);
 450:	0f b6 13             	movzbl (%ebx),%edx
 453:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
 456:	83 ec 04             	sub    $0x4,%esp
 459:	88 55 d7             	mov    %dl,-0x29(%ebp)
 45c:	6a 01                	push   $0x1
 45e:	56                   	push   %esi
 45f:	57                   	push   %edi
 460:	e8 ee fe ff ff       	call   353 <write>
  while(--i >= 0)
 465:	83 c4 10             	add    $0x10,%esp
 468:	39 de                	cmp    %ebx,%esi
 46a:	75 e4                	jne    450 <printint+0x70>
}
 46c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 46f:	5b                   	pop    %ebx
 470:	5e                   	pop    %esi
 471:	5f                   	pop    %edi
 472:	5d                   	pop    %ebp
 473:	c3                   	ret    
 474:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 478:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
 47f:	eb 87                	jmp    408 <printint+0x28>
 481:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 488:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 48f:	90                   	nop

00000490 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 490:	55                   	push   %ebp
 491:	89 e5                	mov    %esp,%ebp
 493:	57                   	push   %edi
 494:	56                   	push   %esi
 495:	53                   	push   %ebx
 496:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 499:	8b 5d 0c             	mov    0xc(%ebp),%ebx
{
 49c:	8b 75 08             	mov    0x8(%ebp),%esi
  for(i = 0; fmt[i]; i++){
 49f:	0f b6 13             	movzbl (%ebx),%edx
 4a2:	84 d2                	test   %dl,%dl
 4a4:	74 6a                	je     510 <printf+0x80>
  ap = (uint*)(void*)&fmt + 1;
 4a6:	8d 45 10             	lea    0x10(%ebp),%eax
 4a9:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 4ac:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
 4af:	31 c9                	xor    %ecx,%ecx
  ap = (uint*)(void*)&fmt + 1;
 4b1:	89 45 d0             	mov    %eax,-0x30(%ebp)
 4b4:	eb 36                	jmp    4ec <printf+0x5c>
 4b6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 4bd:	8d 76 00             	lea    0x0(%esi),%esi
 4c0:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 4c3:	b9 25 00 00 00       	mov    $0x25,%ecx
      if(c == '%'){
 4c8:	83 f8 25             	cmp    $0x25,%eax
 4cb:	74 15                	je     4e2 <printf+0x52>
  write(fd, &c, 1);
 4cd:	83 ec 04             	sub    $0x4,%esp
 4d0:	88 55 e7             	mov    %dl,-0x19(%ebp)
 4d3:	6a 01                	push   $0x1
 4d5:	57                   	push   %edi
 4d6:	56                   	push   %esi
 4d7:	e8 77 fe ff ff       	call   353 <write>
 4dc:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
      } else {
        putc(fd, c);
 4df:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 4e2:	0f b6 13             	movzbl (%ebx),%edx
 4e5:	83 c3 01             	add    $0x1,%ebx
 4e8:	84 d2                	test   %dl,%dl
 4ea:	74 24                	je     510 <printf+0x80>
    c = fmt[i] & 0xff;
 4ec:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
 4ef:	85 c9                	test   %ecx,%ecx
 4f1:	74 cd                	je     4c0 <printf+0x30>
      }
    } else if(state == '%'){
 4f3:	83 f9 25             	cmp    $0x25,%ecx
 4f6:	75 ea                	jne    4e2 <printf+0x52>
      if(c == 'd'){
 4f8:	83 f8 25             	cmp    $0x25,%eax
 4fb:	0f 84 07 01 00 00    	je     608 <printf+0x178>
 501:	83 e8 63             	sub    $0x63,%eax
 504:	83 f8 15             	cmp    $0x15,%eax
 507:	77 17                	ja     520 <printf+0x90>
 509:	ff 24 85 f8 07 00 00 	jmp    *0x7f8(,%eax,4)
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 510:	8d 65 f4             	lea    -0xc(%ebp),%esp
 513:	5b                   	pop    %ebx
 514:	5e                   	pop    %esi
 515:	5f                   	pop    %edi
 516:	5d                   	pop    %ebp
 517:	c3                   	ret    
 518:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 51f:	90                   	nop
  write(fd, &c, 1);
 520:	83 ec 04             	sub    $0x4,%esp
 523:	88 55 d4             	mov    %dl,-0x2c(%ebp)
 526:	6a 01                	push   $0x1
 528:	57                   	push   %edi
 529:	56                   	push   %esi
 52a:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 52e:	e8 20 fe ff ff       	call   353 <write>
        putc(fd, c);
 533:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
  write(fd, &c, 1);
 537:	83 c4 0c             	add    $0xc,%esp
 53a:	88 55 e7             	mov    %dl,-0x19(%ebp)
 53d:	6a 01                	push   $0x1
 53f:	57                   	push   %edi
 540:	56                   	push   %esi
 541:	e8 0d fe ff ff       	call   353 <write>
        putc(fd, c);
 546:	83 c4 10             	add    $0x10,%esp
      state = 0;
 549:	31 c9                	xor    %ecx,%ecx
 54b:	eb 95                	jmp    4e2 <printf+0x52>
 54d:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 550:	83 ec 0c             	sub    $0xc,%esp
 553:	b9 10 00 00 00       	mov    $0x10,%ecx
 558:	6a 00                	push   $0x0
 55a:	8b 45 d0             	mov    -0x30(%ebp),%eax
 55d:	8b 10                	mov    (%eax),%edx
 55f:	89 f0                	mov    %esi,%eax
 561:	e8 7a fe ff ff       	call   3e0 <printint>
        ap++;
 566:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
 56a:	83 c4 10             	add    $0x10,%esp
      state = 0;
 56d:	31 c9                	xor    %ecx,%ecx
 56f:	e9 6e ff ff ff       	jmp    4e2 <printf+0x52>
 574:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 578:	8b 45 d0             	mov    -0x30(%ebp),%eax
 57b:	8b 10                	mov    (%eax),%edx
        ap++;
 57d:	83 c0 04             	add    $0x4,%eax
 580:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 583:	85 d2                	test   %edx,%edx
 585:	0f 84 8d 00 00 00    	je     618 <printf+0x188>
        while(*s != 0){
 58b:	0f b6 02             	movzbl (%edx),%eax
      state = 0;
 58e:	31 c9                	xor    %ecx,%ecx
        while(*s != 0){
 590:	84 c0                	test   %al,%al
 592:	0f 84 4a ff ff ff    	je     4e2 <printf+0x52>
 598:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 59b:	89 d3                	mov    %edx,%ebx
 59d:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 5a0:	83 ec 04             	sub    $0x4,%esp
          s++;
 5a3:	83 c3 01             	add    $0x1,%ebx
 5a6:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 5a9:	6a 01                	push   $0x1
 5ab:	57                   	push   %edi
 5ac:	56                   	push   %esi
 5ad:	e8 a1 fd ff ff       	call   353 <write>
        while(*s != 0){
 5b2:	0f b6 03             	movzbl (%ebx),%eax
 5b5:	83 c4 10             	add    $0x10,%esp
 5b8:	84 c0                	test   %al,%al
 5ba:	75 e4                	jne    5a0 <printf+0x110>
      state = 0;
 5bc:	8b 5d d4             	mov    -0x2c(%ebp),%ebx
 5bf:	31 c9                	xor    %ecx,%ecx
 5c1:	e9 1c ff ff ff       	jmp    4e2 <printf+0x52>
 5c6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5cd:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 5d0:	83 ec 0c             	sub    $0xc,%esp
 5d3:	b9 0a 00 00 00       	mov    $0xa,%ecx
 5d8:	6a 01                	push   $0x1
 5da:	e9 7b ff ff ff       	jmp    55a <printf+0xca>
 5df:	90                   	nop
        putc(fd, *ap);
 5e0:	8b 45 d0             	mov    -0x30(%ebp),%eax
  write(fd, &c, 1);
 5e3:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 5e6:	8b 00                	mov    (%eax),%eax
  write(fd, &c, 1);
 5e8:	6a 01                	push   $0x1
 5ea:	57                   	push   %edi
 5eb:	56                   	push   %esi
        putc(fd, *ap);
 5ec:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 5ef:	e8 5f fd ff ff       	call   353 <write>
        ap++;
 5f4:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
 5f8:	83 c4 10             	add    $0x10,%esp
      state = 0;
 5fb:	31 c9                	xor    %ecx,%ecx
 5fd:	e9 e0 fe ff ff       	jmp    4e2 <printf+0x52>
 602:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        putc(fd, c);
 608:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 60b:	83 ec 04             	sub    $0x4,%esp
 60e:	e9 2a ff ff ff       	jmp    53d <printf+0xad>
 613:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 617:	90                   	nop
          s = "(null)";
 618:	ba f0 07 00 00       	mov    $0x7f0,%edx
        while(*s != 0){
 61d:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 620:	b8 28 00 00 00       	mov    $0x28,%eax
 625:	89 d3                	mov    %edx,%ebx
 627:	e9 74 ff ff ff       	jmp    5a0 <printf+0x110>
 62c:	66 90                	xchg   %ax,%ax
 62e:	66 90                	xchg   %ax,%ax

00000630 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 630:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 631:	a1 20 0d 00 00       	mov    0xd20,%eax
{
 636:	89 e5                	mov    %esp,%ebp
 638:	57                   	push   %edi
 639:	56                   	push   %esi
 63a:	53                   	push   %ebx
 63b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 63e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 641:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 648:	89 c2                	mov    %eax,%edx
 64a:	8b 00                	mov    (%eax),%eax
 64c:	39 ca                	cmp    %ecx,%edx
 64e:	73 30                	jae    680 <free+0x50>
 650:	39 c1                	cmp    %eax,%ecx
 652:	72 04                	jb     658 <free+0x28>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 654:	39 c2                	cmp    %eax,%edx
 656:	72 f0                	jb     648 <free+0x18>
      break;
  if(bp + bp->s.size == p->s.ptr){
 658:	8b 73 fc             	mov    -0x4(%ebx),%esi
 65b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 65e:	39 f8                	cmp    %edi,%eax
 660:	74 30                	je     692 <free+0x62>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 662:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 665:	8b 42 04             	mov    0x4(%edx),%eax
 668:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 66b:	39 f1                	cmp    %esi,%ecx
 66d:	74 3a                	je     6a9 <free+0x79>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 66f:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 671:	5b                   	pop    %ebx
  freep = p;
 672:	89 15 20 0d 00 00    	mov    %edx,0xd20
}
 678:	5e                   	pop    %esi
 679:	5f                   	pop    %edi
 67a:	5d                   	pop    %ebp
 67b:	c3                   	ret    
 67c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 680:	39 c2                	cmp    %eax,%edx
 682:	72 c4                	jb     648 <free+0x18>
 684:	39 c1                	cmp    %eax,%ecx
 686:	73 c0                	jae    648 <free+0x18>
  if(bp + bp->s.size == p->s.ptr){
 688:	8b 73 fc             	mov    -0x4(%ebx),%esi
 68b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 68e:	39 f8                	cmp    %edi,%eax
 690:	75 d0                	jne    662 <free+0x32>
    bp->s.size += p->s.ptr->s.size;
 692:	03 70 04             	add    0x4(%eax),%esi
 695:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 698:	8b 02                	mov    (%edx),%eax
 69a:	8b 00                	mov    (%eax),%eax
 69c:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 69f:	8b 42 04             	mov    0x4(%edx),%eax
 6a2:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 6a5:	39 f1                	cmp    %esi,%ecx
 6a7:	75 c6                	jne    66f <free+0x3f>
    p->s.size += bp->s.size;
 6a9:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
 6ac:	89 15 20 0d 00 00    	mov    %edx,0xd20
    p->s.size += bp->s.size;
 6b2:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 6b5:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 6b8:	89 0a                	mov    %ecx,(%edx)
}
 6ba:	5b                   	pop    %ebx
 6bb:	5e                   	pop    %esi
 6bc:	5f                   	pop    %edi
 6bd:	5d                   	pop    %ebp
 6be:	c3                   	ret    
 6bf:	90                   	nop

000006c0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 6c0:	55                   	push   %ebp
 6c1:	89 e5                	mov    %esp,%ebp
 6c3:	57                   	push   %edi
 6c4:	56                   	push   %esi
 6c5:	53                   	push   %ebx
 6c6:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6c9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 6cc:	8b 3d 20 0d 00 00    	mov    0xd20,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6d2:	8d 70 07             	lea    0x7(%eax),%esi
 6d5:	c1 ee 03             	shr    $0x3,%esi
 6d8:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
 6db:	85 ff                	test   %edi,%edi
 6dd:	0f 84 9d 00 00 00    	je     780 <malloc+0xc0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 6e3:	8b 17                	mov    (%edi),%edx
    if(p->s.size >= nunits){
 6e5:	8b 4a 04             	mov    0x4(%edx),%ecx
 6e8:	39 f1                	cmp    %esi,%ecx
 6ea:	73 6a                	jae    756 <malloc+0x96>
 6ec:	bb 00 10 00 00       	mov    $0x1000,%ebx
 6f1:	39 de                	cmp    %ebx,%esi
 6f3:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
 6f6:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
 6fd:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 700:	eb 17                	jmp    719 <malloc+0x59>
 702:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 708:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 70a:	8b 48 04             	mov    0x4(%eax),%ecx
 70d:	39 f1                	cmp    %esi,%ecx
 70f:	73 4f                	jae    760 <malloc+0xa0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 711:	8b 3d 20 0d 00 00    	mov    0xd20,%edi
 717:	89 c2                	mov    %eax,%edx
 719:	39 d7                	cmp    %edx,%edi
 71b:	75 eb                	jne    708 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 71d:	83 ec 0c             	sub    $0xc,%esp
 720:	ff 75 e4             	push   -0x1c(%ebp)
 723:	e8 93 fc ff ff       	call   3bb <sbrk>
  if(p == (char*)-1)
 728:	83 c4 10             	add    $0x10,%esp
 72b:	83 f8 ff             	cmp    $0xffffffff,%eax
 72e:	74 1c                	je     74c <malloc+0x8c>
  hp->s.size = nu;
 730:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 733:	83 ec 0c             	sub    $0xc,%esp
 736:	83 c0 08             	add    $0x8,%eax
 739:	50                   	push   %eax
 73a:	e8 f1 fe ff ff       	call   630 <free>
  return freep;
 73f:	8b 15 20 0d 00 00    	mov    0xd20,%edx
      if((p = morecore(nunits)) == 0)
 745:	83 c4 10             	add    $0x10,%esp
 748:	85 d2                	test   %edx,%edx
 74a:	75 bc                	jne    708 <malloc+0x48>
        return 0;
  }
}
 74c:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 74f:	31 c0                	xor    %eax,%eax
}
 751:	5b                   	pop    %ebx
 752:	5e                   	pop    %esi
 753:	5f                   	pop    %edi
 754:	5d                   	pop    %ebp
 755:	c3                   	ret    
    if(p->s.size >= nunits){
 756:	89 d0                	mov    %edx,%eax
 758:	89 fa                	mov    %edi,%edx
 75a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 760:	39 ce                	cmp    %ecx,%esi
 762:	74 4c                	je     7b0 <malloc+0xf0>
        p->s.size -= nunits;
 764:	29 f1                	sub    %esi,%ecx
 766:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 769:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 76c:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
 76f:	89 15 20 0d 00 00    	mov    %edx,0xd20
}
 775:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 778:	83 c0 08             	add    $0x8,%eax
}
 77b:	5b                   	pop    %ebx
 77c:	5e                   	pop    %esi
 77d:	5f                   	pop    %edi
 77e:	5d                   	pop    %ebp
 77f:	c3                   	ret    
    base.s.ptr = freep = prevp = &base;
 780:	c7 05 20 0d 00 00 24 	movl   $0xd24,0xd20
 787:	0d 00 00 
    base.s.size = 0;
 78a:	bf 24 0d 00 00       	mov    $0xd24,%edi
    base.s.ptr = freep = prevp = &base;
 78f:	c7 05 24 0d 00 00 24 	movl   $0xd24,0xd24
 796:	0d 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 799:	89 fa                	mov    %edi,%edx
    base.s.size = 0;
 79b:	c7 05 28 0d 00 00 00 	movl   $0x0,0xd28
 7a2:	00 00 00 
    if(p->s.size >= nunits){
 7a5:	e9 42 ff ff ff       	jmp    6ec <malloc+0x2c>
 7aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
 7b0:	8b 08                	mov    (%eax),%ecx
 7b2:	89 0a                	mov    %ecx,(%edx)
 7b4:	eb b9                	jmp    76f <malloc+0xaf>
