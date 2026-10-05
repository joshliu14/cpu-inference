
bin/flags_O3:     file format elf64-x86-64


Disassembly of section .init:

0000000000001000 <_init>:
    1000:	endbr64
    1004:	sub    rsp,0x8
    1008:	mov    rax,QWORD PTR [rip+0x2fd9]        # 3fe8 <__gmon_start__@Base>
    100f:	test   rax,rax
    1012:	je     1016 <_init+0x16>
    1014:	call   rax
    1016:	add    rsp,0x8
    101a:	ret

Disassembly of section .plt:

0000000000001020 <.plt>:
    1020:	push   QWORD PTR [rip+0x2f5a]        # 3f80 <_GLOBAL_OFFSET_TABLE_+0x8>
    1026:	jmp    QWORD PTR [rip+0x2f5c]        # 3f88 <_GLOBAL_OFFSET_TABLE_+0x10>
    102c:	nop    DWORD PTR [rax+0x0]
    1030:	endbr64
    1034:	push   0x0
    1039:	jmp    1020 <_init+0x20>
    103e:	xchg   ax,ax
    1040:	endbr64
    1044:	push   0x1
    1049:	jmp    1020 <_init+0x20>
    104e:	xchg   ax,ax
    1050:	endbr64
    1054:	push   0x2
    1059:	jmp    1020 <_init+0x20>
    105e:	xchg   ax,ax
    1060:	endbr64
    1064:	push   0x3
    1069:	jmp    1020 <_init+0x20>
    106e:	xchg   ax,ax
    1070:	endbr64
    1074:	push   0x4
    1079:	jmp    1020 <_init+0x20>
    107e:	xchg   ax,ax
    1080:	endbr64
    1084:	push   0x5
    1089:	jmp    1020 <_init+0x20>
    108e:	xchg   ax,ax
    1090:	endbr64
    1094:	push   0x6
    1099:	jmp    1020 <_init+0x20>
    109e:	xchg   ax,ax
    10a0:	endbr64
    10a4:	push   0x7
    10a9:	jmp    1020 <_init+0x20>
    10ae:	xchg   ax,ax
    10b0:	endbr64
    10b4:	push   0x8
    10b9:	jmp    1020 <_init+0x20>
    10be:	xchg   ax,ax

Disassembly of section .plt.got:

00000000000010c0 <__cxa_finalize@plt>:
    10c0:	endbr64
    10c4:	jmp    QWORD PTR [rip+0x2f2e]        # 3ff8 <__cxa_finalize@GLIBC_2.2.5>
    10ca:	nop    WORD PTR [rax+rax*1+0x0]

Disassembly of section .plt.sec:

00000000000010d0 <getenv@plt>:
    10d0:	endbr64
    10d4:	jmp    QWORD PTR [rip+0x2eb6]        # 3f90 <getenv@GLIBC_2.2.5>
    10da:	nop    WORD PTR [rax+rax*1+0x0]

00000000000010e0 <clock_gettime@plt>:
    10e0:	endbr64
    10e4:	jmp    QWORD PTR [rip+0x2eae]        # 3f98 <clock_gettime@GLIBC_2.17>
    10ea:	nop    WORD PTR [rax+rax*1+0x0]

00000000000010f0 <__stack_chk_fail@plt>:
    10f0:	endbr64
    10f4:	jmp    QWORD PTR [rip+0x2ea6]        # 3fa0 <__stack_chk_fail@GLIBC_2.4>
    10fa:	nop    WORD PTR [rax+rax*1+0x0]

0000000000001100 <ioctl@plt>:
    1100:	endbr64
    1104:	jmp    QWORD PTR [rip+0x2e9e]        # 3fa8 <ioctl@GLIBC_2.2.5>
    110a:	nop    WORD PTR [rax+rax*1+0x0]

0000000000001110 <read@plt>:
    1110:	endbr64
    1114:	jmp    QWORD PTR [rip+0x2e96]        # 3fb0 <read@GLIBC_2.2.5>
    111a:	nop    WORD PTR [rax+rax*1+0x0]

0000000000001120 <syscall@plt>:
    1120:	endbr64
    1124:	jmp    QWORD PTR [rip+0x2e8e]        # 3fb8 <syscall@GLIBC_2.2.5>
    112a:	nop    WORD PTR [rax+rax*1+0x0]

0000000000001130 <__isoc23_strtol@plt>:
    1130:	endbr64
    1134:	jmp    QWORD PTR [rip+0x2e86]        # 3fc0 <__isoc23_strtol@GLIBC_2.38>
    113a:	nop    WORD PTR [rax+rax*1+0x0]

0000000000001140 <__printf_chk@plt>:
    1140:	endbr64
    1144:	jmp    QWORD PTR [rip+0x2e7e]        # 3fc8 <__printf_chk@GLIBC_2.3.4>
    114a:	nop    WORD PTR [rax+rax*1+0x0]

0000000000001150 <aligned_alloc@plt>:
    1150:	endbr64
    1154:	jmp    QWORD PTR [rip+0x2e76]        # 3fd0 <aligned_alloc@GLIBC_2.16>
    115a:	nop    WORD PTR [rax+rax*1+0x0]

Disassembly of section .text:

0000000000001160 <main>:
    1160:	endbr64
    1164:	push   r15
    1166:	lea    rdi,[rip+0xead]        # 201a <_IO_stdin_used+0x1a>
    116d:	push   r14
    116f:	push   r13
    1171:	push   r12
    1173:	push   rbp
    1174:	push   rbx
    1175:	sub    rsp,0x168
    117c:	mov    rax,QWORD PTR fs:0x28
    1185:	mov    QWORD PTR [rsp+0x158],rax
    118d:	xor    eax,eax
    118f:	call   10d0 <getenv@plt>
    1194:	mov    QWORD PTR [rsp+0x38],0x7
    119d:	test   rax,rax
    11a0:	je     11b6 <main+0x56>
    11a2:	mov    edx,0xa
    11a7:	xor    esi,esi
    11a9:	mov    rdi,rax
    11ac:	call   1130 <__isoc23_strtol@plt>
    11b1:	mov    QWORD PTR [rsp+0x38],rax
    11b6:	lea    rdi,[rip+0xe62]        # 201f <_IO_stdin_used+0x1f>
    11bd:	mov    r13d,0x30d40
    11c3:	call   10d0 <getenv@plt>
    11c8:	test   rax,rax
    11cb:	je     11df <main+0x7f>
    11cd:	mov    edx,0xa
    11d2:	xor    esi,esi
    11d4:	mov    rdi,rax
    11d7:	call   1130 <__isoc23_strtol@plt>
    11dc:	mov    r13,rax
    11df:	mov    esi,0x2000
    11e4:	mov    edi,0x40
    11e9:	call   1150 <aligned_alloc@plt>
    11ee:	mov    esi,0x2000
    11f3:	mov    edi,0x40
    11f8:	mov    r14,rax
    11fb:	call   1150 <aligned_alloc@plt>
    1200:	movss  xmm2,DWORD PTR [rip+0xe00]        # 2008 <_IO_stdin_used+0x8>
    1208:	movss  xmm1,DWORD PTR [rip+0xdfc]        # 200c <_IO_stdin_used+0xc>
    1210:	xor    ecx,ecx
    1212:	movabs rsi,0x4ec4ec4ec4ec4ec5
    121c:	mov    r15,rax
    121f:	nop
    1220:	mov    rax,rcx
    1223:	pxor   xmm0,xmm0
    1227:	mul    rsi
    122a:	shr    rdx,0x2
    122e:	lea    rax,[rdx+rdx*2]
    1232:	lea    rdx,[rdx+rax*4]
    1236:	mov    rax,rcx
    1239:	sub    rax,rdx
    123c:	cvtsi2ss xmm0,rax
    1241:	subss  xmm0,xmm2
    1245:	movss  DWORD PTR [r14+rcx*4],xmm0
    124b:	pxor   xmm0,xmm0
    124f:	cvtsi2ss xmm0,rcx
    1254:	mulss  xmm0,xmm1
    1258:	movss  DWORD PTR [r15+rcx*4],xmm0
    125e:	add    rcx,0x1
    1262:	cmp    rcx,0x800
    1269:	jne    1220 <main+0xc0>
    126b:	lea    rax,[rsp+0x70]
    1270:	movdqa xmm0,XMMWORD PTR [rip+0xe58]        # 20d0 <_IO_stdin_used+0xd0>
    1278:	xor    r12d,r12d
    127b:	xor    ebx,ebx
    127d:	mov    QWORD PTR [rsp+0x8],rax
    1282:	lea    rax,[rsp+0x130]
    128a:	lea    rbp,[rsp+0x104]
    1292:	mov    QWORD PTR [rsp+0x140],0x1
    129e:	mov    QWORD PTR [rsp+0x30],rax
    12a3:	movaps XMMWORD PTR [rsp+0x130],xmm0
    12ab:	mov    rdi,QWORD PTR [rsp+0x8]
    12b0:	mov    rax,rbx
    12b3:	mov    ecx,0x11
    12b8:	test   r12d,r12d
    12bb:	rep stos QWORD PTR es:[rdi],rax
    12be:	mov    rax,QWORD PTR [rsp+0x30]
    12c3:	mov    DWORD PTR [rsp+0x74],0x88
    12cb:	mov    QWORD PTR [rsp+0x90],0x8
    12d7:	mov    rax,QWORD PTR [rax+r12*8]
    12db:	mov    QWORD PTR [rsp+0x78],rax
    12e0:	sete   al
    12e3:	xor    r9d,r9d
    12e6:	or     eax,0x40
    12e9:	mov    BYTE PTR [rsp+0x98],al
    12f0:	test   r12,r12
    12f3:	je     1328 <main+0x1c8>
    12f5:	mov    rsi,QWORD PTR [rsp+0x8]
    12fa:	mov    ecx,0xffffffff
    12ff:	xor    edx,edx
    1301:	xor    eax,eax
    1303:	mov    r8d,DWORD PTR [rsp+0x104]
    130b:	mov    edi,0x12a
    1310:	call   1120 <syscall@plt>
    1315:	mov    DWORD PTR [rbp+r12*4+0x0],eax
    131a:	cmp    r12,0x2
    131e:	je     1358 <main+0x1f8>
    1320:	mov    r12d,0x2
    1326:	jmp    12ab <main+0x14b>
    1328:	mov    rsi,QWORD PTR [rsp+0x8]
    132d:	mov    r8d,0xffffffff
    1333:	xor    edx,edx
    1335:	xor    eax,eax
    1337:	mov    ecx,0xffffffff
    133c:	mov    edi,0x12a
    1341:	mov    r12d,0x1
    1347:	call   1120 <syscall@plt>
    134c:	mov    DWORD PTR [rsp+0x104],eax
    1353:	jmp    12ab <main+0x14b>
    1358:	xor    eax,eax
    135a:	mov    edi,0x2
    135f:	xor    r12d,r12d
    1362:	lea    rsi,[rip+0xcc7]        # 2030 <_IO_stdin_used+0x30>
    1369:	lea    rbx,[rip+0xca0]        # 2010 <_IO_stdin_used+0x10>
    1370:	mov    rbp,r12
    1373:	call   1140 <__printf_chk@plt>
    1378:	lea    rax,[rip+0xc97]        # 2016 <_IO_stdin_used+0x16>
    137f:	movq   xmm0,rbx
    1384:	mov    rbx,r14
    1387:	movq   xmm5,rax
    138c:	lea    rax,[rip+0xc92]        # 2025 <_IO_stdin_used+0x25>
    1393:	mov    DWORD PTR [rsp+0x6c],0x0
    139b:	mov    QWORD PTR [rsp+0x120],rax
    13a3:	mov    rax,r13
    13a6:	punpcklqdq xmm0,xmm5
    13aa:	shl    rax,0xb
    13ae:	cmp    QWORD PTR [rsp+0x38],0x0
    13b4:	movaps XMMWORD PTR [rsp+0x110],xmm0
    13bc:	mov    QWORD PTR [rsp+0x58],rax
    13c1:	js     17c4 <main+0x664>
    13c7:	mov    r12d,DWORD PTR [rsp+0x104]
    13cf:	test   rbp,rbp
    13d2:	je     15c6 <main+0x466>
    13d8:	mov    rax,rbp
    13db:	mov    r14,0xffffffffffffffff
    13e2:	mov    rbp,r15
    13e5:	mov    r15,rax
    13e8:	nop    DWORD PTR [rax+rax*1+0x0]
    13f0:	mov    edx,0x1
    13f5:	mov    esi,0x2403
    13fa:	mov    edi,r12d
    13fd:	xor    eax,eax
    13ff:	call   1100 <ioctl@plt>
    1404:	mov    edx,0x1
    1409:	mov    edi,r12d
    140c:	xor    eax,eax
    140e:	mov    esi,0x2400
    1413:	call   1100 <ioctl@plt>
    1418:	mov    rsi,QWORD PTR [rsp+0x8]
    141d:	mov    edi,0x4
    1422:	call   10e0 <clock_gettime@plt>
    1427:	mov    rax,QWORD PTR [rsp+0x70]
    142c:	mov    QWORD PTR [rsp+0x10],rax
    1431:	mov    rax,QWORD PTR [rsp+0x78]
    1436:	mov    QWORD PTR [rsp+0x18],rax
    143b:	test   r13,r13
    143e:	jle    146c <main+0x30c>
    1440:	xor    edx,edx
    1442:	cmp    r15,0x1
    1446:	je     1780 <main+0x620>
    144c:	nop    DWORD PTR [rax+0x0]
    1450:	mov    rsi,rbx
    1453:	mov    rdi,rbp
    1456:	call   1900 <relu.constprop.0>
    145b:	add    rdx,0x1
    145f:	cmp    r13,rdx
    1462:	jne    1450 <main+0x2f0>
    1464:	mov    r12d,DWORD PTR [rsp+0x104]
    146c:	mov    rsi,QWORD PTR [rsp+0x8]
    1471:	mov    edi,0x4
    1476:	call   10e0 <clock_gettime@plt>
    147b:	mov    rax,QWORD PTR [rsp+0x70]
    1480:	mov    edx,0x1
    1485:	mov    edi,r12d
    1488:	mov    esi,0x2401
    148d:	mov    QWORD PTR [rsp+0x20],rax
    1492:	mov    rax,QWORD PTR [rsp+0x78]
    1497:	mov    QWORD PTR [rsp+0x28],rax
    149c:	xor    eax,eax
    149e:	call   1100 <ioctl@plt>
    14a3:	mov    rsi,QWORD PTR [rsp+0x30]
    14a8:	pxor   xmm3,xmm3
    14ac:	mov    edi,r12d
    14af:	mov    edx,0x20
    14b4:	movaps XMMWORD PTR [rsp+0x130],xmm3
    14bc:	movaps XMMWORD PTR [rsp+0x140],xmm3
    14c4:	call   1110 <read@plt>
    14c9:	cmp    rax,0x20
    14cd:	jne    14f6 <main+0x396>
    14cf:	mov    rax,QWORD PTR [rsp+0x138]
    14d7:	mov    QWORD PTR [rsp+0x50],rax
    14dc:	mov    rax,QWORD PTR [rsp+0x140]
    14e4:	mov    QWORD PTR [rsp+0x48],rax
    14e9:	mov    rax,QWORD PTR [rsp+0x148]
    14f1:	mov    QWORD PTR [rsp+0x40],rax
    14f6:	cmp    r14,0xffffffffffffffff
    14fa:	je     17b0 <main+0x650>
    1500:	pxor   xmm0,xmm0
    1504:	pxor   xmm1,xmm1
    1508:	pxor   xmm2,xmm2
    150c:	mov    rcx,QWORD PTR [rsp+r15*8+0x110]
    1514:	cvtsi2sd xmm0,QWORD PTR [rsp+0x20]
    151b:	mulsd  xmm0,QWORD PTR [rip+0xbbd]        # 20e0 <_IO_stdin_used+0xe0>
    1523:	mov    r9d,0x800
    1529:	mov    r8d,0x4000
    152f:	cvtsi2sd xmm1,QWORD PTR [rsp+0x28]
    1536:	lea    rdx,[rip+0xaed]        # 202a <_IO_stdin_used+0x2a>
    153d:	mov    edi,0x2
    1542:	mov    eax,0x1
    1547:	cvtsi2sd xmm2,QWORD PTR [rsp+0x18]
    154e:	lea    rsi,[rip+0xb3b]        # 2090 <_IO_stdin_used+0x90>
    1555:	addsd  xmm0,xmm1
    1559:	pxor   xmm1,xmm1
    155d:	cvtsi2sd xmm1,QWORD PTR [rsp+0x10]
    1564:	mulsd  xmm1,QWORD PTR [rip+0xb74]        # 20e0 <_IO_stdin_used+0xe0>
    156c:	push   QWORD PTR [rsp+0x58]
    1570:	push   QWORD PTR [rsp+0x48]
    1574:	push   QWORD PTR [rsp+0x58]
    1578:	push   QWORD PTR [rsp+0x68]
    157c:	push   r13
    157e:	addsd  xmm1,xmm2
    1582:	push   r14
    1584:	add    r14,0x1
    1588:	subsd  xmm0,xmm1
    158c:	call   1140 <__printf_chk@plt>
    1591:	add    rsp,0x30
    1595:	cmp    QWORD PTR [rsp+0x38],r14
    159a:	jne    13f0 <main+0x290>
    15a0:	mov    rax,r15
    15a3:	mov    r15,rbp
    15a6:	cmp    rax,0x2
    15aa:	je     17c4 <main+0x664>
    15b0:	mov    ebp,0x2
    15b5:	mov    r12d,DWORD PTR [rsp+0x104]
    15bd:	test   rbp,rbp
    15c0:	jne    13d8 <main+0x278>
    15c6:	or     rbp,0xffffffffffffffff
    15ca:	mov    r14,r15
    15cd:	nop    DWORD PTR [rax]
    15d0:	mov    edx,0x1
    15d5:	mov    esi,0x2403
    15da:	mov    edi,r12d
    15dd:	xor    eax,eax
    15df:	call   1100 <ioctl@plt>
    15e4:	mov    edx,0x1
    15e9:	mov    edi,r12d
    15ec:	xor    eax,eax
    15ee:	mov    esi,0x2400
    15f3:	call   1100 <ioctl@plt>
    15f8:	mov    rsi,QWORD PTR [rsp+0x8]
    15fd:	mov    edi,0x4
    1602:	call   10e0 <clock_gettime@plt>
    1607:	mov    rax,QWORD PTR [rsp+0x70]
    160c:	mov    QWORD PTR [rsp+0x10],rax
    1611:	mov    rax,QWORD PTR [rsp+0x78]
    1616:	mov    QWORD PTR [rsp+0x18],rax
    161b:	test   r13,r13
    161e:	jle    1644 <main+0x4e4>
    1620:	xor    edx,edx
    1622:	nop    WORD PTR [rax+rax*1+0x0]
    1628:	mov    rsi,rbx
    162b:	mov    rdi,r14
    162e:	call   1980 <saxpy.constprop.0>
    1633:	add    rdx,0x1
    1637:	cmp    rdx,r13
    163a:	jne    1628 <main+0x4c8>
    163c:	mov    r12d,DWORD PTR [rsp+0x104]
    1644:	mov    rsi,QWORD PTR [rsp+0x8]
    1649:	mov    edi,0x4
    164e:	call   10e0 <clock_gettime@plt>
    1653:	mov    rax,QWORD PTR [rsp+0x78]
    1658:	mov    edx,0x1
    165d:	mov    edi,r12d
    1660:	mov    esi,0x2401
    1665:	mov    r15,QWORD PTR [rsp+0x70]
    166a:	mov    QWORD PTR [rsp+0x20],rax
    166f:	xor    eax,eax
    1671:	call   1100 <ioctl@plt>
    1676:	mov    rsi,QWORD PTR [rsp+0x30]
    167b:	pxor   xmm4,xmm4
    167f:	mov    edi,r12d
    1682:	mov    edx,0x20
    1687:	movaps XMMWORD PTR [rsp+0x130],xmm4
    168f:	movaps XMMWORD PTR [rsp+0x140],xmm4
    1697:	call   1110 <read@plt>
    169c:	cmp    rax,0x20
    16a0:	jne    16c9 <main+0x569>
    16a2:	mov    rax,QWORD PTR [rsp+0x138]
    16aa:	mov    QWORD PTR [rsp+0x50],rax
    16af:	mov    rax,QWORD PTR [rsp+0x140]
    16b7:	mov    QWORD PTR [rsp+0x48],rax
    16bc:	mov    rax,QWORD PTR [rsp+0x148]
    16c4:	mov    QWORD PTR [rsp+0x40],rax
    16c9:	cmp    rbp,0xffffffffffffffff
    16cd:	je     17f1 <main+0x691>
    16d3:	pxor   xmm0,xmm0
    16d7:	pxor   xmm1,xmm1
    16db:	pxor   xmm2,xmm2
    16df:	mov    r9d,0x800
    16e5:	cvtsi2sd xmm0,r15
    16ea:	mulsd  xmm0,QWORD PTR [rip+0x9ee]        # 20e0 <_IO_stdin_used+0xe0>
    16f2:	mov    r8d,0x4000
    16f8:	mov    edi,0x2
    16fd:	cvtsi2sd xmm1,QWORD PTR [rsp+0x20]
    1704:	lea    rdx,[rip+0x91f]        # 202a <_IO_stdin_used+0x2a>
    170b:	mov    eax,0x1
    1710:	cvtsi2sd xmm2,QWORD PTR [rsp+0x18]
    1717:	lea    rsi,[rip+0x972]        # 2090 <_IO_stdin_used+0x90>
    171e:	addsd  xmm0,xmm1
    1722:	pxor   xmm1,xmm1
    1726:	cvtsi2sd xmm1,QWORD PTR [rsp+0x10]
    172d:	mulsd  xmm1,QWORD PTR [rip+0x9ab]        # 20e0 <_IO_stdin_used+0xe0>
    1735:	push   QWORD PTR [rsp+0x58]
    1739:	push   QWORD PTR [rsp+0x48]
    173d:	push   QWORD PTR [rsp+0x58]
    1741:	push   QWORD PTR [rsp+0x68]
    1745:	push   r13
    1747:	addsd  xmm1,xmm2
    174b:	push   rbp
    174c:	mov    rcx,QWORD PTR [rsp+0x140]
    1754:	add    rbp,0x1
    1758:	subsd  xmm0,xmm1
    175c:	call   1140 <__printf_chk@plt>
    1761:	mov    rax,QWORD PTR [rsp+0x68]
    1766:	add    rsp,0x30
    176a:	cmp    rbp,rax
    176d:	jne    15d0 <main+0x470>
    1773:	mov    r15,r14
    1776:	mov    ebp,0x1
    177b:	jmp    13c7 <main+0x267>
    1780:	mov    rsi,rbp
    1783:	mov    rdi,rbx
    1786:	call   1930 <dot.constprop.0>
    178b:	movss  xmm1,DWORD PTR [rsp+0x6c]
    1791:	addss  xmm0,xmm1
    1795:	movss  DWORD PTR [rsp+0x6c],xmm0
    179b:	add    rdx,0x1
    179f:	cmp    r13,rdx
    17a2:	jne    1780 <main+0x620>
    17a4:	jmp    1464 <main+0x304>
    17a9:	nop    DWORD PTR [rax+0x0]
    17b0:	cmp    QWORD PTR [rsp+0x38],0x0
    17b6:	je     15a0 <main+0x440>
    17bc:	xor    r14d,r14d
    17bf:	jmp    13f0 <main+0x290>
    17c4:	movss  xmm0,DWORD PTR [rsp+0x6c]
    17ca:	mov    rax,QWORD PTR [rsp+0x158]
    17d2:	sub    rax,QWORD PTR fs:0x28
    17db:	jne    1804 <main+0x6a4>
    17dd:	add    rsp,0x168
    17e4:	xor    eax,eax
    17e6:	pop    rbx
    17e7:	pop    rbp
    17e8:	pop    r12
    17ea:	pop    r13
    17ec:	pop    r14
    17ee:	pop    r15
    17f0:	ret
    17f1:	cmp    QWORD PTR [rsp+0x38],0x0
    17f7:	je     1773 <main+0x613>
    17fd:	xor    ebp,ebp
    17ff:	jmp    15d0 <main+0x470>
    1804:	call   10f0 <__stack_chk_fail@plt>
    1809:	nop    DWORD PTR [rax+0x0]

0000000000001810 <_start>:
    1810:	endbr64
    1814:	xor    ebp,ebp
    1816:	mov    r9,rdx
    1819:	pop    rsi
    181a:	mov    rdx,rsp
    181d:	and    rsp,0xfffffffffffffff0
    1821:	push   rax
    1822:	push   rsp
    1823:	xor    r8d,r8d
    1826:	xor    ecx,ecx
    1828:	lea    rdi,[rip+0xfffffffffffff931]        # 1160 <main>
    182f:	call   QWORD PTR [rip+0x27a3]        # 3fd8 <__libc_start_main@GLIBC_2.34>
    1835:	hlt
    1836:	cs nop WORD PTR [rax+rax*1+0x0]

0000000000001840 <deregister_tm_clones>:
    1840:	lea    rdi,[rip+0x27c9]        # 4010 <__TMC_END__>
    1847:	lea    rax,[rip+0x27c2]        # 4010 <__TMC_END__>
    184e:	cmp    rax,rdi
    1851:	je     1868 <deregister_tm_clones+0x28>
    1853:	mov    rax,QWORD PTR [rip+0x2786]        # 3fe0 <_ITM_deregisterTMCloneTable@Base>
    185a:	test   rax,rax
    185d:	je     1868 <deregister_tm_clones+0x28>
    185f:	jmp    rax
    1861:	nop    DWORD PTR [rax+0x0]
    1868:	ret
    1869:	nop    DWORD PTR [rax+0x0]

0000000000001870 <register_tm_clones>:
    1870:	lea    rdi,[rip+0x2799]        # 4010 <__TMC_END__>
    1877:	lea    rsi,[rip+0x2792]        # 4010 <__TMC_END__>
    187e:	sub    rsi,rdi
    1881:	mov    rax,rsi
    1884:	shr    rsi,0x3f
    1888:	sar    rax,0x3
    188c:	add    rsi,rax
    188f:	sar    rsi,1
    1892:	je     18a8 <register_tm_clones+0x38>
    1894:	mov    rax,QWORD PTR [rip+0x2755]        # 3ff0 <_ITM_registerTMCloneTable@Base>
    189b:	test   rax,rax
    189e:	je     18a8 <register_tm_clones+0x38>
    18a0:	jmp    rax
    18a2:	nop    WORD PTR [rax+rax*1+0x0]
    18a8:	ret
    18a9:	nop    DWORD PTR [rax+0x0]

00000000000018b0 <__do_global_dtors_aux>:
    18b0:	endbr64
    18b4:	cmp    BYTE PTR [rip+0x2755],0x0        # 4010 <__TMC_END__>
    18bb:	jne    18e8 <__do_global_dtors_aux+0x38>
    18bd:	push   rbp
    18be:	cmp    QWORD PTR [rip+0x2732],0x0        # 3ff8 <__cxa_finalize@GLIBC_2.2.5>
    18c6:	mov    rbp,rsp
    18c9:	je     18d7 <__do_global_dtors_aux+0x27>
    18cb:	mov    rdi,QWORD PTR [rip+0x2736]        # 4008 <__dso_handle>
    18d2:	call   10c0 <__cxa_finalize@plt>
    18d7:	call   1840 <deregister_tm_clones>
    18dc:	mov    BYTE PTR [rip+0x272d],0x1        # 4010 <__TMC_END__>
    18e3:	pop    rbp
    18e4:	ret
    18e5:	nop    DWORD PTR [rax]
    18e8:	ret
    18e9:	nop    DWORD PTR [rax+0x0]

00000000000018f0 <frame_dummy>:
    18f0:	endbr64
    18f4:	jmp    1870 <register_tm_clones>
    18f9:	nop    DWORD PTR [rax+0x0]

0000000000001900 <relu.constprop.0>:
    1900:	xor    eax,eax
    1902:	pxor   xmm1,xmm1
    1906:	cs nop WORD PTR [rax+rax*1+0x0]
    1910:	movups xmm2,XMMWORD PTR [rsi+rax*1]
    1914:	movaps xmm0,xmm1
    1917:	cmpltps xmm0,xmm2
    191b:	andps  xmm0,xmm2
    191e:	movups XMMWORD PTR [rdi+rax*1],xmm0
    1922:	add    rax,0x10
    1926:	cmp    rax,0x2000
    192c:	jne    1910 <relu.constprop.0+0x10>
    192e:	ret
    192f:	nop

0000000000001930 <dot.constprop.0>:
    1930:	xor    eax,eax
    1932:	pxor   xmm0,xmm0
    1936:	cs nop WORD PTR [rax+rax*1+0x0]
    1940:	movups xmm1,XMMWORD PTR [rsi+rax*1]
    1944:	movups xmm3,XMMWORD PTR [rdi+rax*1]
    1948:	add    rax,0x10
    194c:	mulps  xmm1,xmm3
    194f:	addss  xmm0,xmm1
    1953:	movaps xmm2,xmm1
    1956:	shufps xmm2,xmm1,0x55
    195a:	addss  xmm2,xmm0
    195e:	movaps xmm0,xmm1
    1961:	unpckhps xmm0,xmm1
    1964:	shufps xmm1,xmm1,0xff
    1968:	addss  xmm0,xmm2
    196c:	addss  xmm0,xmm1
    1970:	cmp    rax,0x2000
    1976:	jne    1940 <dot.constprop.0+0x10>
    1978:	ret
    1979:	nop    DWORD PTR [rax+0x0]

0000000000001980 <saxpy.constprop.0>:
    1980:	movss  xmm1,DWORD PTR [rip+0x67c]        # 2004 <_IO_stdin_used+0x4>
    1988:	xor    eax,eax
    198a:	shufps xmm1,xmm1,0x0
    198e:	xchg   ax,ax
    1990:	movups xmm0,XMMWORD PTR [rsi+rax*1]
    1994:	movups xmm2,XMMWORD PTR [rdi+rax*1]
    1998:	mulps  xmm0,xmm1
    199b:	addps  xmm0,xmm2
    199e:	movups XMMWORD PTR [rdi+rax*1],xmm0
    19a2:	add    rax,0x10
    19a6:	cmp    rax,0x2000
    19ac:	jne    1990 <saxpy.constprop.0+0x10>
    19ae:	ret
    19af:	nop

00000000000019b0 <saxpy>:
    19b0:	endbr64
    19b4:	mov    rcx,rdi
    19b7:	test   rdx,rdx
    19ba:	jle    1a57 <saxpy+0xa7>
    19c0:	lea    rax,[rdx-0x1]
    19c4:	cmp    rax,0x2
    19c8:	jbe    1a61 <saxpy+0xb1>
    19ce:	mov    rdi,rdx
    19d1:	movaps xmm2,xmm0
    19d4:	xor    eax,eax
    19d6:	shr    rdi,0x2
    19da:	shufps xmm2,xmm2,0x0
    19de:	shl    rdi,0x4
    19e2:	nop    WORD PTR [rax+rax*1+0x0]
    19e8:	movups xmm1,XMMWORD PTR [rsi+rax*1]
    19ec:	movups xmm3,XMMWORD PTR [rcx+rax*1]
    19f0:	mulps  xmm1,xmm2
    19f3:	addps  xmm1,xmm3
    19f6:	movups XMMWORD PTR [rcx+rax*1],xmm1
    19fa:	add    rax,0x10
    19fe:	cmp    rax,rdi
    1a01:	jne    19e8 <saxpy+0x38>
    1a03:	mov    rdi,rdx
    1a06:	and    rdi,0xfffffffffffffffc
    1a0a:	mov    rax,rdi
    1a0d:	cmp    rdx,rdi
    1a10:	je     1a60 <saxpy+0xb0>
    1a12:	sub    rdx,rax
    1a15:	cmp    rdx,0x1
    1a19:	je     1a46 <saxpy+0x96>
    1a1b:	movq   xmm1,QWORD PTR [rsi+rax*4]
    1a20:	movaps xmm2,xmm0
    1a23:	lea    r8,[rcx+rax*4]
    1a27:	shufps xmm2,xmm2,0xe0
    1a2b:	mulps  xmm1,xmm2
    1a2e:	movq   xmm2,QWORD PTR [r8]
    1a33:	addps  xmm1,xmm2
    1a36:	movlps QWORD PTR [r8],xmm1
    1a3a:	test   dl,0x1
    1a3d:	je     1a57 <saxpy+0xa7>
    1a3f:	and    rdx,0xfffffffffffffffe
    1a43:	add    rdi,rdx
    1a46:	lea    rax,[rcx+rdi*4]
    1a4a:	mulss  xmm0,DWORD PTR [rsi+rdi*4]
    1a4f:	addss  xmm0,DWORD PTR [rax]
    1a53:	movss  DWORD PTR [rax],xmm0
    1a57:	ret
    1a58:	nop    DWORD PTR [rax+rax*1+0x0]
    1a60:	ret
    1a61:	xor    eax,eax
    1a63:	xor    edi,edi
    1a65:	jmp    1a12 <saxpy+0x62>
    1a67:	nop    WORD PTR [rax+rax*1+0x0]

0000000000001a70 <dot>:
    1a70:	endbr64
    1a74:	mov    rcx,rdi
    1a77:	test   rdx,rdx
    1a7a:	jle    1b30 <dot+0xc0>
    1a80:	lea    rax,[rdx-0x1]
    1a84:	cmp    rax,0x2
    1a88:	jbe    1b39 <dot+0xc9>
    1a8e:	mov    rdi,rdx
    1a91:	xor    eax,eax
    1a93:	pxor   xmm0,xmm0
    1a97:	shr    rdi,0x2
    1a9b:	shl    rdi,0x4
    1a9f:	nop
    1aa0:	movups xmm1,XMMWORD PTR [rcx+rax*1]
    1aa4:	movups xmm3,XMMWORD PTR [rsi+rax*1]
    1aa8:	add    rax,0x10
    1aac:	mulps  xmm1,xmm3
    1aaf:	addss  xmm0,xmm1
    1ab3:	movaps xmm2,xmm1
    1ab6:	shufps xmm2,xmm1,0x55
    1aba:	addss  xmm0,xmm2
    1abe:	movaps xmm2,xmm1
    1ac1:	unpckhps xmm2,xmm1
    1ac4:	shufps xmm1,xmm1,0xff
    1ac8:	addss  xmm0,xmm2
    1acc:	addss  xmm0,xmm1
    1ad0:	cmp    rax,rdi
    1ad3:	jne    1aa0 <dot+0x30>
    1ad5:	mov    rax,rdx
    1ad8:	and    rax,0xfffffffffffffffc
    1adc:	test   dl,0x3
    1adf:	je     1b38 <dot+0xc8>
    1ae1:	movss  xmm1,DWORD PTR [rcx+rax*4]
    1ae6:	mulss  xmm1,DWORD PTR [rsi+rax*4]
    1aeb:	lea    r8,[rax+0x1]
    1aef:	lea    rdi,[rax*4+0x0]
    1af7:	addss  xmm0,xmm1
    1afb:	cmp    rdx,r8
    1afe:	jle    1b34 <dot+0xc4>
    1b00:	movss  xmm1,DWORD PTR [rcx+rdi*1+0x4]
    1b06:	mulss  xmm1,DWORD PTR [rsi+rdi*1+0x4]
    1b0c:	add    rax,0x2
    1b10:	addss  xmm0,xmm1
    1b14:	cmp    rdx,rax
    1b17:	jle    1b34 <dot+0xc4>
    1b19:	movss  xmm1,DWORD PTR [rsi+rdi*1+0x8]
    1b1f:	mulss  xmm1,DWORD PTR [rcx+rdi*1+0x8]
    1b25:	addss  xmm0,xmm1
    1b29:	ret
    1b2a:	nop    WORD PTR [rax+rax*1+0x0]
    1b30:	pxor   xmm0,xmm0
    1b34:	ret
    1b35:	nop    DWORD PTR [rax]
    1b38:	ret
    1b39:	xor    eax,eax
    1b3b:	pxor   xmm0,xmm0
    1b3f:	jmp    1ae1 <dot+0x71>
    1b41:	data16 cs nop WORD PTR [rax+rax*1+0x0]
    1b4c:	nop    DWORD PTR [rax+0x0]

0000000000001b50 <relu>:
    1b50:	endbr64
    1b54:	mov    rcx,rdi
    1b57:	test   rdx,rdx
    1b5a:	jle    1bf0 <relu+0xa0>
    1b60:	lea    rax,[rdx-0x1]
    1b64:	cmp    rax,0x2
    1b68:	jbe    1bf9 <relu+0xa9>
    1b6e:	mov    rdi,rdx
    1b71:	xor    eax,eax
    1b73:	pxor   xmm1,xmm1
    1b77:	shr    rdi,0x2
    1b7b:	shl    rdi,0x4
    1b7f:	nop
    1b80:	movups xmm2,XMMWORD PTR [rsi+rax*1]
    1b84:	movaps xmm0,xmm1
    1b87:	cmpltps xmm0,xmm2
    1b8b:	andps  xmm0,xmm2
    1b8e:	movups XMMWORD PTR [rcx+rax*1],xmm0
    1b92:	add    rax,0x10
    1b96:	cmp    rdi,rax
    1b99:	jne    1b80 <relu+0x30>
    1b9b:	mov    rax,rdx
    1b9e:	and    rax,0xfffffffffffffffc
    1ba2:	mov    rdi,rax
    1ba5:	cmp    rdx,rax
    1ba8:	je     1bf8 <relu+0xa8>
    1baa:	sub    rdx,rdi
    1bad:	cmp    rdx,0x1
    1bb1:	je     1bd2 <relu+0x82>
    1bb3:	movq   xmm1,QWORD PTR [rsi+rdi*4]
    1bb8:	xorps  xmm0,xmm0
    1bbb:	cmpltps xmm0,xmm1
    1bbf:	andps  xmm0,xmm1
    1bc2:	movlps QWORD PTR [rcx+rdi*4],xmm0
    1bc6:	test   dl,0x1
    1bc9:	je     1bf0 <relu+0xa0>
    1bcb:	and    rdx,0xfffffffffffffffe
    1bcf:	add    rax,rdx
    1bd2:	movss  xmm0,DWORD PTR [rsi+rax*4]
    1bd7:	pxor   xmm1,xmm1
    1bdb:	lea    rdx,[rax*4+0x0]
    1be3:	comiss xmm0,xmm1
    1be6:	ja     1beb <relu+0x9b>
    1be8:	movaps xmm0,xmm1
    1beb:	movss  DWORD PTR [rcx+rdx*1],xmm0
    1bf0:	ret
    1bf1:	nop    DWORD PTR [rax+0x0]
    1bf8:	ret
    1bf9:	xor    edi,edi
    1bfb:	xor    eax,eax
    1bfd:	jmp    1baa <relu+0x5a>

Disassembly of section .fini:

0000000000001c00 <_fini>:
    1c00:	endbr64
    1c04:	sub    rsp,0x8
    1c08:	add    rsp,0x8
    1c0c:	ret
