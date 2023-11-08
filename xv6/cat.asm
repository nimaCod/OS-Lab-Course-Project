
_cat:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
    exit();
  }
}

int main(int argc, char *argv[])
{
   0:	f3 0f 1e fb          	endbr32 
   4:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   8:	83 e4 f0             	and    $0xfffffff0,%esp
   b:	ff 71 fc             	pushl  -0x4(%ecx)
  int fd, i;

  if (argc <= 1)
   e:	83 39 01             	cmpl   $0x1,(%ecx)
{
  11:	55                   	push   %ebp
  12:	89 e5                	mov    %esp,%ebp
  14:	53                   	push   %ebx
  15:	51                   	push   %ecx
  16:	8b 59 04             	mov    0x4(%ecx),%ebx
  if (argc <= 1)
  19:	7e 31                	jle    4c <main+0x4c>
    exit();
  }

  for (i = 1; i < argc; i++)
  {
    if ((fd = open(argv[i], 0)) < 0)
  1b:	52                   	push   %edx
  1c:	52                   	push   %edx
  1d:	6a 00                	push   $0x0
  1f:	ff 73 04             	pushl  0x4(%ebx)
  22:	e8 5c 03 00 00       	call   383 <open>
  27:	83 c4 10             	add    $0x10,%esp
  2a:	85 c0                	test   %eax,%eax
  2c:	78 09                	js     37 <main+0x37>
    {
      printf(1, "cat: cannot open %s\n", argv[i]);
      exit();
    }
    cat(fd);
  2e:	83 ec 0c             	sub    $0xc,%esp
  31:	50                   	push   %eax
  32:	e8 29 00 00 00       	call   60 <cat>
      printf(1, "cat: cannot open %s\n", argv[i]);
  37:	50                   	push   %eax
  38:	ff 73 04             	pushl  0x4(%ebx)
  3b:	68 3b 08 00 00       	push   $0x83b
  40:	6a 01                	push   $0x1
  42:	e8 69 04 00 00       	call   4b0 <printf>
      exit();
  47:	e8 f7 02 00 00       	call   343 <exit>
    cat(0);
  4c:	83 ec 0c             	sub    $0xc,%esp
  4f:	6a 00                	push   $0x0
  51:	e8 0a 00 00 00       	call   60 <cat>
  56:	66 90                	xchg   %ax,%ax
  58:	66 90                	xchg   %ax,%ax
  5a:	66 90                	xchg   %ax,%ax
  5c:	66 90                	xchg   %ax,%ax
  5e:	66 90                	xchg   %ax,%ax

00000060 <cat>:
{
  60:	f3 0f 1e fb          	endbr32 
  64:	55                   	push   %ebp
  65:	89 e5                	mov    %esp,%ebp
  67:	56                   	push   %esi
  68:	8b 75 08             	mov    0x8(%ebp),%esi
  6b:	53                   	push   %ebx
  while ((n = read(fd, buf, sizeof(buf))) > 0)
  6c:	eb 19                	jmp    87 <cat+0x27>
  6e:	66 90                	xchg   %ax,%ax
    if (write(1, buf, n) != n)
  70:	83 ec 04             	sub    $0x4,%esp
  73:	53                   	push   %ebx
  74:	68 60 0b 00 00       	push   $0xb60
  79:	6a 01                	push   $0x1
  7b:	e8 e3 02 00 00       	call   363 <write>
  80:	83 c4 10             	add    $0x10,%esp
  83:	39 d8                	cmp    %ebx,%eax
  85:	75 44                	jne    cb <cat+0x6b>
  while ((n = read(fd, buf, sizeof(buf))) > 0)
  87:	83 ec 04             	sub    $0x4,%esp
  8a:	68 00 02 00 00       	push   $0x200
  8f:	68 60 0b 00 00       	push   $0xb60
  94:	56                   	push   %esi
  95:	e8 c1 02 00 00       	call   35b <read>
  9a:	83 c4 10             	add    $0x10,%esp
  9d:	89 c3                	mov    %eax,%ebx
  9f:	85 c0                	test   %eax,%eax
  a1:	7f cd                	jg     70 <cat+0x10>
  if (n < 0)
  a3:	74 13                	je     b8 <cat+0x58>
    printf(1, "cat: read error\n");
  a5:	52                   	push   %edx
  a6:	52                   	push   %edx
  a7:	68 2a 08 00 00       	push   $0x82a
  ac:	6a 01                	push   $0x1
  ae:	e8 fd 03 00 00       	call   4b0 <printf>
    exit();
  b3:	e8 8b 02 00 00       	call   343 <exit>
    printf(1, "\n");
  b8:	50                   	push   %eax
  b9:	50                   	push   %eax
  ba:	68 39 08 00 00       	push   $0x839
  bf:	6a 01                	push   $0x1
  c1:	e8 ea 03 00 00       	call   4b0 <printf>
    exit();
  c6:	e8 78 02 00 00       	call   343 <exit>
      printf(1, "cat: write error\n");
  cb:	51                   	push   %ecx
  cc:	51                   	push   %ecx
  cd:	68 18 08 00 00       	push   $0x818
  d2:	6a 01                	push   $0x1
  d4:	e8 d7 03 00 00       	call   4b0 <printf>
      exit();
  d9:	e8 65 02 00 00       	call   343 <exit>
  de:	66 90                	xchg   %ax,%ax

000000e0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  e0:	f3 0f 1e fb          	endbr32 
  e4:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  e5:	31 c0                	xor    %eax,%eax
{
  e7:	89 e5                	mov    %esp,%ebp
  e9:	53                   	push   %ebx
  ea:	8b 4d 08             	mov    0x8(%ebp),%ecx
  ed:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while((*s++ = *t++) != 0)
  f0:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
  f4:	88 14 01             	mov    %dl,(%ecx,%eax,1)
  f7:	83 c0 01             	add    $0x1,%eax
  fa:	84 d2                	test   %dl,%dl
  fc:	75 f2                	jne    f0 <strcpy+0x10>
    ;
  return os;
}
  fe:	89 c8                	mov    %ecx,%eax
 100:	5b                   	pop    %ebx
 101:	5d                   	pop    %ebp
 102:	c3                   	ret    
 103:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 10a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000110 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 110:	f3 0f 1e fb          	endbr32 
 114:	55                   	push   %ebp
 115:	89 e5                	mov    %esp,%ebp
 117:	53                   	push   %ebx
 118:	8b 4d 08             	mov    0x8(%ebp),%ecx
 11b:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
 11e:	0f b6 01             	movzbl (%ecx),%eax
 121:	0f b6 1a             	movzbl (%edx),%ebx
 124:	84 c0                	test   %al,%al
 126:	75 19                	jne    141 <strcmp+0x31>
 128:	eb 26                	jmp    150 <strcmp+0x40>
 12a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 130:	0f b6 41 01          	movzbl 0x1(%ecx),%eax
    p++, q++;
 134:	83 c1 01             	add    $0x1,%ecx
 137:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 13a:	0f b6 1a             	movzbl (%edx),%ebx
 13d:	84 c0                	test   %al,%al
 13f:	74 0f                	je     150 <strcmp+0x40>
 141:	38 d8                	cmp    %bl,%al
 143:	74 eb                	je     130 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
 145:	29 d8                	sub    %ebx,%eax
}
 147:	5b                   	pop    %ebx
 148:	5d                   	pop    %ebp
 149:	c3                   	ret    
 14a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 150:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 152:	29 d8                	sub    %ebx,%eax
}
 154:	5b                   	pop    %ebx
 155:	5d                   	pop    %ebp
 156:	c3                   	ret    
 157:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 15e:	66 90                	xchg   %ax,%ax

00000160 <strlen>:

uint
strlen(const char *s)
{
 160:	f3 0f 1e fb          	endbr32 
 164:	55                   	push   %ebp
 165:	89 e5                	mov    %esp,%ebp
 167:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 16a:	80 3a 00             	cmpb   $0x0,(%edx)
 16d:	74 21                	je     190 <strlen+0x30>
 16f:	31 c0                	xor    %eax,%eax
 171:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 178:	83 c0 01             	add    $0x1,%eax
 17b:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 17f:	89 c1                	mov    %eax,%ecx
 181:	75 f5                	jne    178 <strlen+0x18>
    ;
  return n;
}
 183:	89 c8                	mov    %ecx,%eax
 185:	5d                   	pop    %ebp
 186:	c3                   	ret    
 187:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 18e:	66 90                	xchg   %ax,%ax
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
 1a0:	f3 0f 1e fb          	endbr32 
 1a4:	55                   	push   %ebp
 1a5:	89 e5                	mov    %esp,%ebp
 1a7:	57                   	push   %edi
 1a8:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" : "=D"(addr), "=c"(cnt) : "0"(addr), "1"(cnt), "a"(data) : "memory", "cc");
 1ab:	8b 4d 10             	mov    0x10(%ebp),%ecx
 1ae:	8b 45 0c             	mov    0xc(%ebp),%eax
 1b1:	89 d7                	mov    %edx,%edi
 1b3:	fc                   	cld    
 1b4:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 1b6:	89 d0                	mov    %edx,%eax
 1b8:	5f                   	pop    %edi
 1b9:	5d                   	pop    %ebp
 1ba:	c3                   	ret    
 1bb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1bf:	90                   	nop

000001c0 <strchr>:

char*
strchr(const char *s, char c)
{
 1c0:	f3 0f 1e fb          	endbr32 
 1c4:	55                   	push   %ebp
 1c5:	89 e5                	mov    %esp,%ebp
 1c7:	8b 45 08             	mov    0x8(%ebp),%eax
 1ca:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 1ce:	0f b6 10             	movzbl (%eax),%edx
 1d1:	84 d2                	test   %dl,%dl
 1d3:	75 16                	jne    1eb <strchr+0x2b>
 1d5:	eb 21                	jmp    1f8 <strchr+0x38>
 1d7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1de:	66 90                	xchg   %ax,%ax
 1e0:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 1e4:	83 c0 01             	add    $0x1,%eax
 1e7:	84 d2                	test   %dl,%dl
 1e9:	74 0d                	je     1f8 <strchr+0x38>
    if(*s == c)
 1eb:	38 d1                	cmp    %dl,%cl
 1ed:	75 f1                	jne    1e0 <strchr+0x20>
      return (char*)s;
  return 0;
}
 1ef:	5d                   	pop    %ebp
 1f0:	c3                   	ret    
 1f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 1f8:	31 c0                	xor    %eax,%eax
}
 1fa:	5d                   	pop    %ebp
 1fb:	c3                   	ret    
 1fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000200 <gets>:

char*
gets(char *buf, int max)
{
 200:	f3 0f 1e fb          	endbr32 
 204:	55                   	push   %ebp
 205:	89 e5                	mov    %esp,%ebp
 207:	57                   	push   %edi
 208:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 209:	31 f6                	xor    %esi,%esi
{
 20b:	53                   	push   %ebx
 20c:	89 f3                	mov    %esi,%ebx
 20e:	83 ec 1c             	sub    $0x1c,%esp
 211:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
 214:	eb 33                	jmp    249 <gets+0x49>
 216:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 21d:	8d 76 00             	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 220:	83 ec 04             	sub    $0x4,%esp
 223:	8d 45 e7             	lea    -0x19(%ebp),%eax
 226:	6a 01                	push   $0x1
 228:	50                   	push   %eax
 229:	6a 00                	push   $0x0
 22b:	e8 2b 01 00 00       	call   35b <read>
    if(cc < 1)
 230:	83 c4 10             	add    $0x10,%esp
 233:	85 c0                	test   %eax,%eax
 235:	7e 1c                	jle    253 <gets+0x53>
      break;
    buf[i++] = c;
 237:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 23b:	83 c7 01             	add    $0x1,%edi
 23e:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
 241:	3c 0a                	cmp    $0xa,%al
 243:	74 23                	je     268 <gets+0x68>
 245:	3c 0d                	cmp    $0xd,%al
 247:	74 1f                	je     268 <gets+0x68>
  for(i=0; i+1 < max; ){
 249:	83 c3 01             	add    $0x1,%ebx
 24c:	89 fe                	mov    %edi,%esi
 24e:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 251:	7c cd                	jl     220 <gets+0x20>
 253:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
 255:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
 258:	c6 03 00             	movb   $0x0,(%ebx)
}
 25b:	8d 65 f4             	lea    -0xc(%ebp),%esp
 25e:	5b                   	pop    %ebx
 25f:	5e                   	pop    %esi
 260:	5f                   	pop    %edi
 261:	5d                   	pop    %ebp
 262:	c3                   	ret    
 263:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 267:	90                   	nop
 268:	8b 75 08             	mov    0x8(%ebp),%esi
 26b:	8b 45 08             	mov    0x8(%ebp),%eax
 26e:	01 de                	add    %ebx,%esi
 270:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
 272:	c6 03 00             	movb   $0x0,(%ebx)
}
 275:	8d 65 f4             	lea    -0xc(%ebp),%esp
 278:	5b                   	pop    %ebx
 279:	5e                   	pop    %esi
 27a:	5f                   	pop    %edi
 27b:	5d                   	pop    %ebp
 27c:	c3                   	ret    
 27d:	8d 76 00             	lea    0x0(%esi),%esi

00000280 <stat>:

int
stat(const char *n, struct stat *st)
{
 280:	f3 0f 1e fb          	endbr32 
 284:	55                   	push   %ebp
 285:	89 e5                	mov    %esp,%ebp
 287:	56                   	push   %esi
 288:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 289:	83 ec 08             	sub    $0x8,%esp
 28c:	6a 00                	push   $0x0
 28e:	ff 75 08             	pushl  0x8(%ebp)
 291:	e8 ed 00 00 00       	call   383 <open>
  if(fd < 0)
 296:	83 c4 10             	add    $0x10,%esp
 299:	85 c0                	test   %eax,%eax
 29b:	78 2b                	js     2c8 <stat+0x48>
    return -1;
  r = fstat(fd, st);
 29d:	83 ec 08             	sub    $0x8,%esp
 2a0:	ff 75 0c             	pushl  0xc(%ebp)
 2a3:	89 c3                	mov    %eax,%ebx
 2a5:	50                   	push   %eax
 2a6:	e8 f0 00 00 00       	call   39b <fstat>
  close(fd);
 2ab:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 2ae:	89 c6                	mov    %eax,%esi
  close(fd);
 2b0:	e8 b6 00 00 00       	call   36b <close>
  return r;
 2b5:	83 c4 10             	add    $0x10,%esp
}
 2b8:	8d 65 f8             	lea    -0x8(%ebp),%esp
 2bb:	89 f0                	mov    %esi,%eax
 2bd:	5b                   	pop    %ebx
 2be:	5e                   	pop    %esi
 2bf:	5d                   	pop    %ebp
 2c0:	c3                   	ret    
 2c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
 2c8:	be ff ff ff ff       	mov    $0xffffffff,%esi
 2cd:	eb e9                	jmp    2b8 <stat+0x38>
 2cf:	90                   	nop

000002d0 <atoi>:

int
atoi(const char *s)
{
 2d0:	f3 0f 1e fb          	endbr32 
 2d4:	55                   	push   %ebp
 2d5:	89 e5                	mov    %esp,%ebp
 2d7:	53                   	push   %ebx
 2d8:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2db:	0f be 02             	movsbl (%edx),%eax
 2de:	8d 48 d0             	lea    -0x30(%eax),%ecx
 2e1:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 2e4:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 2e9:	77 1a                	ja     305 <atoi+0x35>
 2eb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 2ef:	90                   	nop
    n = n*10 + *s++ - '0';
 2f0:	83 c2 01             	add    $0x1,%edx
 2f3:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 2f6:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 2fa:	0f be 02             	movsbl (%edx),%eax
 2fd:	8d 58 d0             	lea    -0x30(%eax),%ebx
 300:	80 fb 09             	cmp    $0x9,%bl
 303:	76 eb                	jbe    2f0 <atoi+0x20>
  return n;
}
 305:	89 c8                	mov    %ecx,%eax
 307:	5b                   	pop    %ebx
 308:	5d                   	pop    %ebp
 309:	c3                   	ret    
 30a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000310 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 310:	f3 0f 1e fb          	endbr32 
 314:	55                   	push   %ebp
 315:	89 e5                	mov    %esp,%ebp
 317:	57                   	push   %edi
 318:	8b 45 10             	mov    0x10(%ebp),%eax
 31b:	8b 55 08             	mov    0x8(%ebp),%edx
 31e:	56                   	push   %esi
 31f:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 322:	85 c0                	test   %eax,%eax
 324:	7e 0f                	jle    335 <memmove+0x25>
 326:	01 d0                	add    %edx,%eax
  dst = vdst;
 328:	89 d7                	mov    %edx,%edi
 32a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    *dst++ = *src++;
 330:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 331:	39 f8                	cmp    %edi,%eax
 333:	75 fb                	jne    330 <memmove+0x20>
  return vdst;
}
 335:	5e                   	pop    %esi
 336:	89 d0                	mov    %edx,%eax
 338:	5f                   	pop    %edi
 339:	5d                   	pop    %ebp
 33a:	c3                   	ret    

0000033b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 33b:	b8 01 00 00 00       	mov    $0x1,%eax
 340:	cd 40                	int    $0x40
 342:	c3                   	ret    

00000343 <exit>:
SYSCALL(exit)
 343:	b8 02 00 00 00       	mov    $0x2,%eax
 348:	cd 40                	int    $0x40
 34a:	c3                   	ret    

0000034b <wait>:
SYSCALL(wait)
 34b:	b8 03 00 00 00       	mov    $0x3,%eax
 350:	cd 40                	int    $0x40
 352:	c3                   	ret    

00000353 <pipe>:
SYSCALL(pipe)
 353:	b8 04 00 00 00       	mov    $0x4,%eax
 358:	cd 40                	int    $0x40
 35a:	c3                   	ret    

0000035b <read>:
SYSCALL(read)
 35b:	b8 05 00 00 00       	mov    $0x5,%eax
 360:	cd 40                	int    $0x40
 362:	c3                   	ret    

00000363 <write>:
SYSCALL(write)
 363:	b8 10 00 00 00       	mov    $0x10,%eax
 368:	cd 40                	int    $0x40
 36a:	c3                   	ret    

0000036b <close>:
SYSCALL(close)
 36b:	b8 15 00 00 00       	mov    $0x15,%eax
 370:	cd 40                	int    $0x40
 372:	c3                   	ret    

00000373 <kill>:
SYSCALL(kill)
 373:	b8 06 00 00 00       	mov    $0x6,%eax
 378:	cd 40                	int    $0x40
 37a:	c3                   	ret    

0000037b <exec>:
SYSCALL(exec)
 37b:	b8 07 00 00 00       	mov    $0x7,%eax
 380:	cd 40                	int    $0x40
 382:	c3                   	ret    

00000383 <open>:
SYSCALL(open)
 383:	b8 0f 00 00 00       	mov    $0xf,%eax
 388:	cd 40                	int    $0x40
 38a:	c3                   	ret    

0000038b <mknod>:
SYSCALL(mknod)
 38b:	b8 11 00 00 00       	mov    $0x11,%eax
 390:	cd 40                	int    $0x40
 392:	c3                   	ret    

00000393 <unlink>:
SYSCALL(unlink)
 393:	b8 12 00 00 00       	mov    $0x12,%eax
 398:	cd 40                	int    $0x40
 39a:	c3                   	ret    

0000039b <fstat>:
SYSCALL(fstat)
 39b:	b8 08 00 00 00       	mov    $0x8,%eax
 3a0:	cd 40                	int    $0x40
 3a2:	c3                   	ret    

000003a3 <link>:
SYSCALL(link)
 3a3:	b8 13 00 00 00       	mov    $0x13,%eax
 3a8:	cd 40                	int    $0x40
 3aa:	c3                   	ret    

000003ab <mkdir>:
SYSCALL(mkdir)
 3ab:	b8 14 00 00 00       	mov    $0x14,%eax
 3b0:	cd 40                	int    $0x40
 3b2:	c3                   	ret    

000003b3 <chdir>:
SYSCALL(chdir)
 3b3:	b8 09 00 00 00       	mov    $0x9,%eax
 3b8:	cd 40                	int    $0x40
 3ba:	c3                   	ret    

000003bb <dup>:
SYSCALL(dup)
 3bb:	b8 0a 00 00 00       	mov    $0xa,%eax
 3c0:	cd 40                	int    $0x40
 3c2:	c3                   	ret    

000003c3 <getpid>:
SYSCALL(getpid)
 3c3:	b8 0b 00 00 00       	mov    $0xb,%eax
 3c8:	cd 40                	int    $0x40
 3ca:	c3                   	ret    

000003cb <sbrk>:
SYSCALL(sbrk)
 3cb:	b8 0c 00 00 00       	mov    $0xc,%eax
 3d0:	cd 40                	int    $0x40
 3d2:	c3                   	ret    

000003d3 <sleep>:
SYSCALL(sleep)
 3d3:	b8 0d 00 00 00       	mov    $0xd,%eax
 3d8:	cd 40                	int    $0x40
 3da:	c3                   	ret    

000003db <uptime>:
SYSCALL(uptime)
 3db:	b8 0e 00 00 00       	mov    $0xe,%eax
 3e0:	cd 40                	int    $0x40
 3e2:	c3                   	ret    

000003e3 <find_digital_root>:
SYSCALL(find_digital_root)
 3e3:	b8 16 00 00 00       	mov    $0x16,%eax
 3e8:	cd 40                	int    $0x40
 3ea:	c3                   	ret    

000003eb <copy_file>:
SYSCALL(copy_file)
 3eb:	b8 17 00 00 00       	mov    $0x17,%eax
 3f0:	cd 40                	int    $0x40
 3f2:	c3                   	ret    

000003f3 <get_uncle_count>:
 3f3:	b8 18 00 00 00       	mov    $0x18,%eax
 3f8:	cd 40                	int    $0x40
 3fa:	c3                   	ret    
 3fb:	66 90                	xchg   %ax,%ax
 3fd:	66 90                	xchg   %ax,%ax
 3ff:	90                   	nop

00000400 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 400:	55                   	push   %ebp
 401:	89 e5                	mov    %esp,%ebp
 403:	57                   	push   %edi
 404:	56                   	push   %esi
 405:	53                   	push   %ebx
 406:	83 ec 3c             	sub    $0x3c,%esp
 409:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 40c:	89 d1                	mov    %edx,%ecx
{
 40e:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
 411:	85 d2                	test   %edx,%edx
 413:	0f 89 7f 00 00 00    	jns    498 <printint+0x98>
 419:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 41d:	74 79                	je     498 <printint+0x98>
    neg = 1;
 41f:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
 426:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
 428:	31 db                	xor    %ebx,%ebx
 42a:	8d 75 d7             	lea    -0x29(%ebp),%esi
 42d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 430:	89 c8                	mov    %ecx,%eax
 432:	31 d2                	xor    %edx,%edx
 434:	89 cf                	mov    %ecx,%edi
 436:	f7 75 c4             	divl   -0x3c(%ebp)
 439:	0f b6 92 58 08 00 00 	movzbl 0x858(%edx),%edx
 440:	89 45 c0             	mov    %eax,-0x40(%ebp)
 443:	89 d8                	mov    %ebx,%eax
 445:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
 448:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    buf[i++] = digits[x % base];
 44b:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
 44e:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
 451:	76 dd                	jbe    430 <printint+0x30>
  if(neg)
 453:	8b 4d bc             	mov    -0x44(%ebp),%ecx
 456:	85 c9                	test   %ecx,%ecx
 458:	74 0c                	je     466 <printint+0x66>
    buf[i++] = '-';
 45a:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
 45f:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
 461:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
 466:	8b 7d b8             	mov    -0x48(%ebp),%edi
 469:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
 46d:	eb 07                	jmp    476 <printint+0x76>
 46f:	90                   	nop
 470:	0f b6 13             	movzbl (%ebx),%edx
 473:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
 476:	83 ec 04             	sub    $0x4,%esp
 479:	88 55 d7             	mov    %dl,-0x29(%ebp)
 47c:	6a 01                	push   $0x1
 47e:	56                   	push   %esi
 47f:	57                   	push   %edi
 480:	e8 de fe ff ff       	call   363 <write>
  while(--i >= 0)
 485:	83 c4 10             	add    $0x10,%esp
 488:	39 de                	cmp    %ebx,%esi
 48a:	75 e4                	jne    470 <printint+0x70>
    putc(fd, buf[i]);
}
 48c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 48f:	5b                   	pop    %ebx
 490:	5e                   	pop    %esi
 491:	5f                   	pop    %edi
 492:	5d                   	pop    %ebp
 493:	c3                   	ret    
 494:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 498:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
 49f:	eb 87                	jmp    428 <printint+0x28>
 4a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 4a8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 4af:	90                   	nop

000004b0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 4b0:	f3 0f 1e fb          	endbr32 
 4b4:	55                   	push   %ebp
 4b5:	89 e5                	mov    %esp,%ebp
 4b7:	57                   	push   %edi
 4b8:	56                   	push   %esi
 4b9:	53                   	push   %ebx
 4ba:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 4bd:	8b 75 0c             	mov    0xc(%ebp),%esi
 4c0:	0f b6 1e             	movzbl (%esi),%ebx
 4c3:	84 db                	test   %bl,%bl
 4c5:	0f 84 b4 00 00 00    	je     57f <printf+0xcf>
  ap = (uint*)(void*)&fmt + 1;
 4cb:	8d 45 10             	lea    0x10(%ebp),%eax
 4ce:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
 4d1:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
 4d4:	31 d2                	xor    %edx,%edx
  ap = (uint*)(void*)&fmt + 1;
 4d6:	89 45 d0             	mov    %eax,-0x30(%ebp)
 4d9:	eb 33                	jmp    50e <printf+0x5e>
 4db:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 4df:	90                   	nop
 4e0:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 4e3:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 4e8:	83 f8 25             	cmp    $0x25,%eax
 4eb:	74 17                	je     504 <printf+0x54>
  write(fd, &c, 1);
 4ed:	83 ec 04             	sub    $0x4,%esp
 4f0:	88 5d e7             	mov    %bl,-0x19(%ebp)
 4f3:	6a 01                	push   $0x1
 4f5:	57                   	push   %edi
 4f6:	ff 75 08             	pushl  0x8(%ebp)
 4f9:	e8 65 fe ff ff       	call   363 <write>
 4fe:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
 501:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 504:	0f b6 1e             	movzbl (%esi),%ebx
 507:	83 c6 01             	add    $0x1,%esi
 50a:	84 db                	test   %bl,%bl
 50c:	74 71                	je     57f <printf+0xcf>
    c = fmt[i] & 0xff;
 50e:	0f be cb             	movsbl %bl,%ecx
 511:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 514:	85 d2                	test   %edx,%edx
 516:	74 c8                	je     4e0 <printf+0x30>
      }
    } else if(state == '%'){
 518:	83 fa 25             	cmp    $0x25,%edx
 51b:	75 e7                	jne    504 <printf+0x54>
      if(c == 'd'){
 51d:	83 f8 64             	cmp    $0x64,%eax
 520:	0f 84 9a 00 00 00    	je     5c0 <printf+0x110>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 526:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 52c:	83 f9 70             	cmp    $0x70,%ecx
 52f:	74 5f                	je     590 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 531:	83 f8 73             	cmp    $0x73,%eax
 534:	0f 84 d6 00 00 00    	je     610 <printf+0x160>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 53a:	83 f8 63             	cmp    $0x63,%eax
 53d:	0f 84 8d 00 00 00    	je     5d0 <printf+0x120>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 543:	83 f8 25             	cmp    $0x25,%eax
 546:	0f 84 b4 00 00 00    	je     600 <printf+0x150>
  write(fd, &c, 1);
 54c:	83 ec 04             	sub    $0x4,%esp
 54f:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 553:	6a 01                	push   $0x1
 555:	57                   	push   %edi
 556:	ff 75 08             	pushl  0x8(%ebp)
 559:	e8 05 fe ff ff       	call   363 <write>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 55e:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 561:	83 c4 0c             	add    $0xc,%esp
 564:	6a 01                	push   $0x1
 566:	83 c6 01             	add    $0x1,%esi
 569:	57                   	push   %edi
 56a:	ff 75 08             	pushl  0x8(%ebp)
 56d:	e8 f1 fd ff ff       	call   363 <write>
  for(i = 0; fmt[i]; i++){
 572:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
        putc(fd, c);
 576:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 579:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
 57b:	84 db                	test   %bl,%bl
 57d:	75 8f                	jne    50e <printf+0x5e>
    }
  }
}
 57f:	8d 65 f4             	lea    -0xc(%ebp),%esp
 582:	5b                   	pop    %ebx
 583:	5e                   	pop    %esi
 584:	5f                   	pop    %edi
 585:	5d                   	pop    %ebp
 586:	c3                   	ret    
 587:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 58e:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 16, 0);
 590:	83 ec 0c             	sub    $0xc,%esp
 593:	b9 10 00 00 00       	mov    $0x10,%ecx
 598:	6a 00                	push   $0x0
 59a:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 59d:	8b 45 08             	mov    0x8(%ebp),%eax
 5a0:	8b 13                	mov    (%ebx),%edx
 5a2:	e8 59 fe ff ff       	call   400 <printint>
        ap++;
 5a7:	89 d8                	mov    %ebx,%eax
 5a9:	83 c4 10             	add    $0x10,%esp
      state = 0;
 5ac:	31 d2                	xor    %edx,%edx
        ap++;
 5ae:	83 c0 04             	add    $0x4,%eax
 5b1:	89 45 d0             	mov    %eax,-0x30(%ebp)
 5b4:	e9 4b ff ff ff       	jmp    504 <printf+0x54>
 5b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 10, 1);
 5c0:	83 ec 0c             	sub    $0xc,%esp
 5c3:	b9 0a 00 00 00       	mov    $0xa,%ecx
 5c8:	6a 01                	push   $0x1
 5ca:	eb ce                	jmp    59a <printf+0xea>
 5cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        putc(fd, *ap);
 5d0:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
 5d3:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 5d6:	8b 03                	mov    (%ebx),%eax
  write(fd, &c, 1);
 5d8:	6a 01                	push   $0x1
        ap++;
 5da:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
 5dd:	57                   	push   %edi
 5de:	ff 75 08             	pushl  0x8(%ebp)
        putc(fd, *ap);
 5e1:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 5e4:	e8 7a fd ff ff       	call   363 <write>
        ap++;
 5e9:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 5ec:	83 c4 10             	add    $0x10,%esp
      state = 0;
 5ef:	31 d2                	xor    %edx,%edx
 5f1:	e9 0e ff ff ff       	jmp    504 <printf+0x54>
 5f6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5fd:	8d 76 00             	lea    0x0(%esi),%esi
        putc(fd, c);
 600:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 603:	83 ec 04             	sub    $0x4,%esp
 606:	e9 59 ff ff ff       	jmp    564 <printf+0xb4>
 60b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 60f:	90                   	nop
        s = (char*)*ap;
 610:	8b 45 d0             	mov    -0x30(%ebp),%eax
 613:	8b 18                	mov    (%eax),%ebx
        ap++;
 615:	83 c0 04             	add    $0x4,%eax
 618:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 61b:	85 db                	test   %ebx,%ebx
 61d:	74 17                	je     636 <printf+0x186>
        while(*s != 0){
 61f:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
 622:	31 d2                	xor    %edx,%edx
        while(*s != 0){
 624:	84 c0                	test   %al,%al
 626:	0f 84 d8 fe ff ff    	je     504 <printf+0x54>
 62c:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 62f:	89 de                	mov    %ebx,%esi
 631:	8b 5d 08             	mov    0x8(%ebp),%ebx
 634:	eb 1a                	jmp    650 <printf+0x1a0>
          s = "(null)";
 636:	bb 50 08 00 00       	mov    $0x850,%ebx
        while(*s != 0){
 63b:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 63e:	b8 28 00 00 00       	mov    $0x28,%eax
 643:	89 de                	mov    %ebx,%esi
 645:	8b 5d 08             	mov    0x8(%ebp),%ebx
 648:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 64f:	90                   	nop
  write(fd, &c, 1);
 650:	83 ec 04             	sub    $0x4,%esp
          s++;
 653:	83 c6 01             	add    $0x1,%esi
 656:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 659:	6a 01                	push   $0x1
 65b:	57                   	push   %edi
 65c:	53                   	push   %ebx
 65d:	e8 01 fd ff ff       	call   363 <write>
        while(*s != 0){
 662:	0f b6 06             	movzbl (%esi),%eax
 665:	83 c4 10             	add    $0x10,%esp
 668:	84 c0                	test   %al,%al
 66a:	75 e4                	jne    650 <printf+0x1a0>
 66c:	8b 75 d4             	mov    -0x2c(%ebp),%esi
      state = 0;
 66f:	31 d2                	xor    %edx,%edx
 671:	e9 8e fe ff ff       	jmp    504 <printf+0x54>
 676:	66 90                	xchg   %ax,%ax
 678:	66 90                	xchg   %ax,%ax
 67a:	66 90                	xchg   %ax,%ax
 67c:	66 90                	xchg   %ax,%ax
 67e:	66 90                	xchg   %ax,%ax

00000680 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 680:	f3 0f 1e fb          	endbr32 
 684:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 685:	a1 40 0b 00 00       	mov    0xb40,%eax
{
 68a:	89 e5                	mov    %esp,%ebp
 68c:	57                   	push   %edi
 68d:	56                   	push   %esi
 68e:	53                   	push   %ebx
 68f:	8b 5d 08             	mov    0x8(%ebp),%ebx
 692:	8b 10                	mov    (%eax),%edx
  bp = (Header*)ap - 1;
 694:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 697:	39 c8                	cmp    %ecx,%eax
 699:	73 15                	jae    6b0 <free+0x30>
 69b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 69f:	90                   	nop
 6a0:	39 d1                	cmp    %edx,%ecx
 6a2:	72 14                	jb     6b8 <free+0x38>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6a4:	39 d0                	cmp    %edx,%eax
 6a6:	73 10                	jae    6b8 <free+0x38>
{
 6a8:	89 d0                	mov    %edx,%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6aa:	8b 10                	mov    (%eax),%edx
 6ac:	39 c8                	cmp    %ecx,%eax
 6ae:	72 f0                	jb     6a0 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6b0:	39 d0                	cmp    %edx,%eax
 6b2:	72 f4                	jb     6a8 <free+0x28>
 6b4:	39 d1                	cmp    %edx,%ecx
 6b6:	73 f0                	jae    6a8 <free+0x28>
      break;
  if(bp + bp->s.size == p->s.ptr){
 6b8:	8b 73 fc             	mov    -0x4(%ebx),%esi
 6bb:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 6be:	39 fa                	cmp    %edi,%edx
 6c0:	74 1e                	je     6e0 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 6c2:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 6c5:	8b 50 04             	mov    0x4(%eax),%edx
 6c8:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 6cb:	39 f1                	cmp    %esi,%ecx
 6cd:	74 28                	je     6f7 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 6cf:	89 08                	mov    %ecx,(%eax)
  freep = p;
}
 6d1:	5b                   	pop    %ebx
  freep = p;
 6d2:	a3 40 0b 00 00       	mov    %eax,0xb40
}
 6d7:	5e                   	pop    %esi
 6d8:	5f                   	pop    %edi
 6d9:	5d                   	pop    %ebp
 6da:	c3                   	ret    
 6db:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 6df:	90                   	nop
    bp->s.size += p->s.ptr->s.size;
 6e0:	03 72 04             	add    0x4(%edx),%esi
 6e3:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 6e6:	8b 10                	mov    (%eax),%edx
 6e8:	8b 12                	mov    (%edx),%edx
 6ea:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 6ed:	8b 50 04             	mov    0x4(%eax),%edx
 6f0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 6f3:	39 f1                	cmp    %esi,%ecx
 6f5:	75 d8                	jne    6cf <free+0x4f>
    p->s.size += bp->s.size;
 6f7:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 6fa:	a3 40 0b 00 00       	mov    %eax,0xb40
    p->s.size += bp->s.size;
 6ff:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 702:	8b 53 f8             	mov    -0x8(%ebx),%edx
 705:	89 10                	mov    %edx,(%eax)
}
 707:	5b                   	pop    %ebx
 708:	5e                   	pop    %esi
 709:	5f                   	pop    %edi
 70a:	5d                   	pop    %ebp
 70b:	c3                   	ret    
 70c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000710 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 710:	f3 0f 1e fb          	endbr32 
 714:	55                   	push   %ebp
 715:	89 e5                	mov    %esp,%ebp
 717:	57                   	push   %edi
 718:	56                   	push   %esi
 719:	53                   	push   %ebx
 71a:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 71d:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 720:	8b 3d 40 0b 00 00    	mov    0xb40,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 726:	8d 70 07             	lea    0x7(%eax),%esi
 729:	c1 ee 03             	shr    $0x3,%esi
 72c:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
 72f:	85 ff                	test   %edi,%edi
 731:	0f 84 a9 00 00 00    	je     7e0 <malloc+0xd0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 737:	8b 07                	mov    (%edi),%eax
    if(p->s.size >= nunits){
 739:	8b 48 04             	mov    0x4(%eax),%ecx
 73c:	39 f1                	cmp    %esi,%ecx
 73e:	73 6d                	jae    7ad <malloc+0x9d>
 740:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
 746:	bb 00 10 00 00       	mov    $0x1000,%ebx
 74b:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
 74e:	8d 0c dd 00 00 00 00 	lea    0x0(,%ebx,8),%ecx
 755:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
 758:	eb 17                	jmp    771 <malloc+0x61>
 75a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 760:	8b 10                	mov    (%eax),%edx
    if(p->s.size >= nunits){
 762:	8b 4a 04             	mov    0x4(%edx),%ecx
 765:	39 f1                	cmp    %esi,%ecx
 767:	73 4f                	jae    7b8 <malloc+0xa8>
 769:	8b 3d 40 0b 00 00    	mov    0xb40,%edi
 76f:	89 d0                	mov    %edx,%eax
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 771:	39 c7                	cmp    %eax,%edi
 773:	75 eb                	jne    760 <malloc+0x50>
  p = sbrk(nu * sizeof(Header));
 775:	83 ec 0c             	sub    $0xc,%esp
 778:	ff 75 e4             	pushl  -0x1c(%ebp)
 77b:	e8 4b fc ff ff       	call   3cb <sbrk>
  if(p == (char*)-1)
 780:	83 c4 10             	add    $0x10,%esp
 783:	83 f8 ff             	cmp    $0xffffffff,%eax
 786:	74 1b                	je     7a3 <malloc+0x93>
  hp->s.size = nu;
 788:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 78b:	83 ec 0c             	sub    $0xc,%esp
 78e:	83 c0 08             	add    $0x8,%eax
 791:	50                   	push   %eax
 792:	e8 e9 fe ff ff       	call   680 <free>
  return freep;
 797:	a1 40 0b 00 00       	mov    0xb40,%eax
      if((p = morecore(nunits)) == 0)
 79c:	83 c4 10             	add    $0x10,%esp
 79f:	85 c0                	test   %eax,%eax
 7a1:	75 bd                	jne    760 <malloc+0x50>
        return 0;
  }
}
 7a3:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 7a6:	31 c0                	xor    %eax,%eax
}
 7a8:	5b                   	pop    %ebx
 7a9:	5e                   	pop    %esi
 7aa:	5f                   	pop    %edi
 7ab:	5d                   	pop    %ebp
 7ac:	c3                   	ret    
    if(p->s.size >= nunits){
 7ad:	89 c2                	mov    %eax,%edx
 7af:	89 f8                	mov    %edi,%eax
 7b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(p->s.size == nunits)
 7b8:	39 ce                	cmp    %ecx,%esi
 7ba:	74 54                	je     810 <malloc+0x100>
        p->s.size -= nunits;
 7bc:	29 f1                	sub    %esi,%ecx
 7be:	89 4a 04             	mov    %ecx,0x4(%edx)
        p += p->s.size;
 7c1:	8d 14 ca             	lea    (%edx,%ecx,8),%edx
        p->s.size = nunits;
 7c4:	89 72 04             	mov    %esi,0x4(%edx)
      freep = prevp;
 7c7:	a3 40 0b 00 00       	mov    %eax,0xb40
}
 7cc:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 7cf:	8d 42 08             	lea    0x8(%edx),%eax
}
 7d2:	5b                   	pop    %ebx
 7d3:	5e                   	pop    %esi
 7d4:	5f                   	pop    %edi
 7d5:	5d                   	pop    %ebp
 7d6:	c3                   	ret    
 7d7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 7de:	66 90                	xchg   %ax,%ax
    base.s.ptr = freep = prevp = &base;
 7e0:	c7 05 40 0b 00 00 44 	movl   $0xb44,0xb40
 7e7:	0b 00 00 
    base.s.size = 0;
 7ea:	bf 44 0b 00 00       	mov    $0xb44,%edi
    base.s.ptr = freep = prevp = &base;
 7ef:	c7 05 44 0b 00 00 44 	movl   $0xb44,0xb44
 7f6:	0b 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7f9:	89 f8                	mov    %edi,%eax
    base.s.size = 0;
 7fb:	c7 05 48 0b 00 00 00 	movl   $0x0,0xb48
 802:	00 00 00 
    if(p->s.size >= nunits){
 805:	e9 36 ff ff ff       	jmp    740 <malloc+0x30>
 80a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
 810:	8b 0a                	mov    (%edx),%ecx
 812:	89 08                	mov    %ecx,(%eax)
 814:	eb b1                	jmp    7c7 <malloc+0xb7>
