
bin/flags_O3_native_fast:     file format elf64-x86-64


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
    1164:	push   rbp
    1165:	lea    rdi,[rip+0xeae]        # 201a <_IO_stdin_used+0x1a>
    116c:	mov    rbp,rsp
    116f:	push   r15
    1171:	push   r14
    1173:	push   r13
    1175:	push   r12
    1177:	push   r10
    1179:	push   rbx
    117a:	sub    rsp,0x160
    1181:	mov    rax,QWORD PTR fs:0x28
    118a:	mov    QWORD PTR [rbp-0x38],rax
    118e:	xor    eax,eax
    1190:	call   10d0 <getenv@plt>
    1195:	mov    QWORD PTR [rbp-0x170],0x7
    11a0:	test   rax,rax
    11a3:	je     11bb <main+0x5b>
    11a5:	mov    edx,0xa
    11aa:	xor    esi,esi
    11ac:	mov    rdi,rax
    11af:	call   1130 <__isoc23_strtol@plt>
    11b4:	mov    QWORD PTR [rbp-0x170],rax
    11bb:	lea    rdi,[rip+0xe5d]        # 201f <_IO_stdin_used+0x1f>
    11c2:	mov    r14d,0x30d40
    11c8:	call   10d0 <getenv@plt>
    11cd:	test   rax,rax
    11d0:	je     11e4 <main+0x84>
    11d2:	mov    edx,0xa
    11d7:	xor    esi,esi
    11d9:	mov    rdi,rax
    11dc:	call   1130 <__isoc23_strtol@plt>
    11e1:	mov    r14,rax
    11e4:	mov    esi,0x2000
    11e9:	mov    edi,0x40
    11ee:	call   1150 <aligned_alloc@plt>
    11f3:	mov    esi,0x2000
    11f8:	mov    edi,0x40
    11fd:	mov    r15,rax
    1200:	call   1150 <aligned_alloc@plt>
    1205:	vmovss xmm2,DWORD PTR [rip+0xdfb]        # 2008 <_IO_stdin_used+0x8>
    120d:	vmovss xmm1,DWORD PTR [rip+0xdf7]        # 200c <_IO_stdin_used+0xc>
    1215:	xor    ecx,ecx
    1217:	mov    r13,rax
    121a:	movabs rsi,0x4ec4ec4ec4ec4ec5
    1224:	nop    DWORD PTR [rax+0x0]
    1228:	mov    rax,rcx
    122b:	vxorps xmm3,xmm3,xmm3
    122f:	mul    rsi
    1232:	shr    rdx,0x2
    1236:	lea    rax,[rdx+rdx*2]
    123a:	lea    rdx,[rdx+rax*4]
    123e:	mov    rax,rcx
    1241:	sub    rax,rdx
    1244:	vcvtsi2ss xmm0,xmm3,rax
    1249:	vsubss xmm0,xmm0,xmm2
    124d:	vmovss DWORD PTR [r15+rcx*4],xmm0
    1253:	vcvtsi2ss xmm0,xmm3,rcx
    1258:	vmulss xmm0,xmm0,xmm1
    125c:	vmovss DWORD PTR [r13+rcx*4+0x0],xmm0
    1263:	inc    rcx
    1266:	cmp    rcx,0x800
    126d:	jne    1228 <main+0xc8>
    126f:	lea    rax,[rbp-0x120]
    1276:	vmovdqa xmm0,XMMWORD PTR [rip+0xe62]        # 20e0 <_IO_stdin_used+0xe0>
    127e:	lea    rbx,[rbp-0x60]
    1282:	mov    QWORD PTR [rbp-0x50],0x1
    128a:	mov    QWORD PTR [rbp-0x138],rax
    1291:	xor    r12d,r12d
    1294:	mov    QWORD PTR [rbp-0x168],rbx
    129b:	lea    rbx,[rbp-0x8c]
    12a2:	mov    QWORD PTR [rbp-0x140],r13
    12a9:	mov    r13,rbx
    12ac:	mov    rbx,rax
    12af:	vmovdqa XMMWORD PTR [rbp-0x60],xmm0
    12b4:	vpxor  xmm0,xmm0,xmm0
    12b8:	mov    rax,QWORD PTR [rbp-0x168]
    12bf:	test   r12d,r12d
    12c2:	mov    QWORD PTR [rbx+0x80],0x0
    12cd:	vmovdqu8 ZMMWORD PTR [rbx],zmm0
    12d3:	mov    rax,QWORD PTR [rax+r12*8]
    12d7:	vmovdqu8 ZMMWORD PTR [rbx+0x40],zmm0
    12de:	mov    DWORD PTR [rbp-0x11c],0x88
    12e8:	mov    QWORD PTR [rbp-0x118],rax
    12ef:	sete   al
    12f2:	xor    r9d,r9d
    12f5:	or     eax,0x40
    12f8:	mov    QWORD PTR [rbp-0x100],0x8
    1303:	mov    BYTE PTR [rbp-0xf8],al
    1309:	test   r12,r12
    130c:	je     1348 <main+0x1e8>
    130e:	mov    r8d,DWORD PTR [rbp-0x8c]
    1315:	xor    edx,edx
    1317:	xor    eax,eax
    1319:	mov    ecx,0xffffffff
    131e:	mov    rsi,rbx
    1321:	mov    edi,0x12a
    1326:	vzeroupper
    1329:	call   1120 <syscall@plt>
    132e:	cmp    r12,0x2
    1332:	vpxor  xmm0,xmm0,xmm0
    1336:	mov    DWORD PTR [r13+r12*4+0x0],eax
    133b:	je     137c <main+0x21c>
    133d:	mov    r12d,0x2
    1343:	jmp    12b8 <main+0x158>
    1348:	xor    edx,edx
    134a:	xor    eax,eax
    134c:	mov    r8d,0xffffffff
    1352:	mov    ecx,0xffffffff
    1357:	mov    rsi,rbx
    135a:	mov    edi,0x12a
    135f:	vzeroupper
    1362:	mov    r12d,0x1
    1368:	call   1120 <syscall@plt>
    136d:	vpxor  xmm0,xmm0,xmm0
    1371:	mov    DWORD PTR [rbp-0x8c],eax
    1377:	jmp    12b8 <main+0x158>
    137c:	xor    eax,eax
    137e:	lea    rbx,[rip+0xc8b]        # 2010 <_IO_stdin_used+0x10>
    1385:	lea    rsi,[rip+0xcb4]        # 2040 <_IO_stdin_used+0x40>
    138c:	mov    edi,0x2
    1391:	mov    r13,QWORD PTR [rbp-0x140]
    1398:	call   1140 <__printf_chk@plt>
    139d:	lea    rax,[rip+0xc72]        # 2016 <_IO_stdin_used+0x16>
    13a4:	vmovq  xmm0,rbx
    13a9:	mov    DWORD PTR [rbp-0x124],0x0
    13b3:	vpinsrq xmm0,xmm0,rax,0x1
    13b9:	lea    rax,[rip+0xc65]        # 2025 <_IO_stdin_used+0x25>
    13c0:	mov    rbx,r15
    13c3:	mov    r12,r13
    13c6:	mov    QWORD PTR [rbp-0x70],rax
    13ca:	mov    rax,r14
    13cd:	shl    rax,0xb
    13d1:	vmovdqa XMMWORD PTR [rbp-0x80],xmm0
    13d6:	mov    QWORD PTR [rbp-0x190],rax
    13dd:	xor    eax,eax
    13df:	cmp    QWORD PTR [rbp-0x170],0x0
    13e7:	mov    QWORD PTR [rbp-0x140],rax
    13ee:	js     1818 <main+0x6b8>
    13f4:	nop    DWORD PTR [rax+0x0]
    13f8:	cmp    QWORD PTR [rbp-0x140],0x0
    1400:	mov    r13d,DWORD PTR [rbp-0x8c]
    1407:	mov    r15,0xffffffffffffffff
    140e:	je     1765 <main+0x605>
    1414:	nop    DWORD PTR [rax+0x0]
    1418:	mov    edx,0x1
    141d:	mov    esi,0x2403
    1422:	mov    edi,r13d
    1425:	xor    eax,eax
    1427:	call   1100 <ioctl@plt>
    142c:	mov    edx,0x1
    1431:	mov    esi,0x2400
    1436:	mov    edi,r13d
    1439:	xor    eax,eax
    143b:	call   1100 <ioctl@plt>
    1440:	mov    rsi,QWORD PTR [rbp-0x138]
    1447:	mov    edi,0x4
    144c:	call   10e0 <clock_gettime@plt>
    1451:	mov    rax,QWORD PTR [rbp-0x120]
    1458:	mov    QWORD PTR [rbp-0x148],rax
    145f:	mov    rax,QWORD PTR [rbp-0x118]
    1466:	mov    QWORD PTR [rbp-0x150],rax
    146d:	test   r14,r14
    1470:	jle    14a2 <main+0x342>
    1472:	xor    edx,edx
    1474:	cmp    QWORD PTR [rbp-0x140],0x1
    147c:	je     1600 <main+0x4a0>
    1482:	nop    WORD PTR [rax+rax*1+0x0]
    1488:	mov    rsi,rbx
    148b:	mov    rdi,r12
    148e:	call   1960 <relu.constprop.0>
    1493:	inc    rdx
    1496:	cmp    r14,rdx
    1499:	jne    1488 <main+0x328>
    149b:	mov    r13d,DWORD PTR [rbp-0x8c]
    14a2:	mov    rsi,QWORD PTR [rbp-0x138]
    14a9:	mov    edi,0x4
    14ae:	call   10e0 <clock_gettime@plt>
    14b3:	mov    rax,QWORD PTR [rbp-0x120]
    14ba:	mov    edx,0x1
    14bf:	mov    esi,0x2401
    14c4:	mov    edi,r13d
    14c7:	mov    QWORD PTR [rbp-0x158],rax
    14ce:	mov    rax,QWORD PTR [rbp-0x118]
    14d5:	mov    QWORD PTR [rbp-0x160],rax
    14dc:	xor    eax,eax
    14de:	call   1100 <ioctl@plt>
    14e3:	vpxor  xmm5,xmm5,xmm5
    14e7:	mov    rsi,QWORD PTR [rbp-0x168]
    14ee:	mov    edx,0x20
    14f3:	vmovdqu8 YMMWORD PTR [rbp-0x60],ymm5
    14fa:	mov    edi,r13d
    14fd:	vzeroupper
    1500:	call   1110 <read@plt>
    1505:	cmp    rax,0x20
    1509:	jne    152c <main+0x3cc>
    150b:	mov    rax,QWORD PTR [rbp-0x58]
    150f:	mov    QWORD PTR [rbp-0x188],rax
    1516:	mov    rax,QWORD PTR [rbp-0x50]
    151a:	mov    QWORD PTR [rbp-0x180],rax
    1521:	mov    rax,QWORD PTR [rbp-0x48]
    1525:	mov    QWORD PTR [rbp-0x178],rax
    152c:	cmp    r15,0xffffffffffffffff
    1530:	je     17f0 <main+0x690>
    1536:	vxorpd xmm4,xmm4,xmm4
    153a:	mov    rax,QWORD PTR [rbp-0x140]
    1541:	mov    r9d,0x800
    1547:	mov    r8d,0x4000
    154d:	vcvtsi2sd xmm1,xmm4,QWORD PTR [rbp-0x150]
    1556:	lea    rdx,[rip+0xacd]        # 202a <_IO_stdin_used+0x2a>
    155d:	mov    edi,0x2
    1562:	vcvtsi2sd xmm0,xmm4,QWORD PTR [rbp-0x158]
    156b:	mov    rcx,QWORD PTR [rbp+rax*8-0x80]
    1570:	lea    rsi,[rip+0xb29]        # 20a0 <_IO_stdin_used+0xa0>
    1577:	mov    eax,0x1
    157c:	vcvtsi2sd xmm2,xmm4,QWORD PTR [rbp-0x160]
    1585:	vfmsub132sd xmm0,xmm1,QWORD PTR [rip+0xb62]        # 20f0 <_IO_stdin_used+0xf0>
    158e:	vcvtsi2sd xmm1,xmm4,QWORD PTR [rbp-0x148]
    1597:	push   QWORD PTR [rbp-0x190]
    159d:	push   QWORD PTR [rbp-0x178]
    15a3:	vfnmadd132sd xmm1,xmm2,QWORD PTR [rip+0xb44]        # 20f0 <_IO_stdin_used+0xf0>
    15ac:	push   QWORD PTR [rbp-0x180]
    15b2:	push   QWORD PTR [rbp-0x188]
    15b8:	vaddsd xmm0,xmm0,xmm1
    15bc:	push   r14
    15be:	push   r15
    15c0:	inc    r15
    15c3:	call   1140 <__printf_chk@plt>
    15c8:	mov    rax,QWORD PTR [rbp-0x170]
    15cf:	add    rsp,0x30
    15d3:	cmp    r15,rax
    15d6:	jne    1418 <main+0x2b8>
    15dc:	cmp    QWORD PTR [rbp-0x140],0x2
    15e4:	je     1818 <main+0x6b8>
    15ea:	mov    QWORD PTR [rbp-0x140],0x2
    15f5:	jmp    13f8 <main+0x298>
    15fa:	nop    WORD PTR [rax+rax*1+0x0]
    1600:	mov    rsi,r12
    1603:	mov    rdi,rbx
    1606:	call   1990 <dot.constprop.0>
    160b:	vmovss xmm1,DWORD PTR [rbp-0x124]
    1613:	vaddss xmm0,xmm0,xmm1
    1617:	vmovss DWORD PTR [rbp-0x124],xmm0
    161f:	inc    rdx
    1622:	cmp    r14,rdx
    1625:	jne    1600 <main+0x4a0>
    1627:	jmp    149b <main+0x33b>
    162c:	nop    DWORD PTR [rax+0x0]
    1630:	mov    r13d,DWORD PTR [rbp-0x8c]
    1637:	mov    rsi,QWORD PTR [rbp-0x138]
    163e:	mov    edi,0x4
    1643:	call   10e0 <clock_gettime@plt>
    1648:	mov    rax,QWORD PTR [rbp-0x120]
    164f:	mov    edx,0x1
    1654:	mov    esi,0x2401
    1659:	mov    edi,r13d
    165c:	mov    QWORD PTR [rbp-0x150],rax
    1663:	mov    rax,QWORD PTR [rbp-0x118]
    166a:	mov    QWORD PTR [rbp-0x158],rax
    1671:	xor    eax,eax
    1673:	call   1100 <ioctl@plt>
    1678:	vpxor  xmm7,xmm7,xmm7
    167c:	mov    rsi,QWORD PTR [rbp-0x168]
    1683:	mov    edx,0x20
    1688:	vmovdqu8 YMMWORD PTR [rbp-0x60],ymm7
    168f:	mov    edi,r13d
    1692:	vzeroupper
    1695:	call   1110 <read@plt>
    169a:	cmp    rax,0x20
    169e:	jne    16c1 <main+0x561>
    16a0:	mov    rax,QWORD PTR [rbp-0x58]
    16a4:	mov    QWORD PTR [rbp-0x188],rax
    16ab:	mov    rax,QWORD PTR [rbp-0x50]
    16af:	mov    QWORD PTR [rbp-0x180],rax
    16b6:	mov    rax,QWORD PTR [rbp-0x48]
    16ba:	mov    QWORD PTR [rbp-0x178],rax
    16c1:	cmp    r15,0xffffffffffffffff
    16c5:	je     1806 <main+0x6a6>
    16cb:	vxorpd xmm6,xmm6,xmm6
    16cf:	mov    rcx,QWORD PTR [rbp-0x80]
    16d3:	mov    r9d,0x800
    16d9:	mov    r8d,0x4000
    16df:	vcvtsi2sd xmm1,xmm6,QWORD PTR [rbp-0x148]
    16e8:	lea    rdx,[rip+0x93b]        # 202a <_IO_stdin_used+0x2a>
    16ef:	mov    edi,0x2
    16f4:	mov    eax,0x1
    16f9:	vcvtsi2sd xmm0,xmm6,QWORD PTR [rbp-0x150]
    1702:	lea    rsi,[rip+0x997]        # 20a0 <_IO_stdin_used+0xa0>
    1709:	vcvtsi2sd xmm2,xmm6,QWORD PTR [rbp-0x158]
    1712:	vfmsub132sd xmm0,xmm1,QWORD PTR [rip+0x9d5]        # 20f0 <_IO_stdin_used+0xf0>
    171b:	vcvtsi2sd xmm1,xmm6,QWORD PTR [rbp-0x140]
    1724:	push   QWORD PTR [rbp-0x190]
    172a:	push   QWORD PTR [rbp-0x178]
    1730:	vfnmadd132sd xmm1,xmm2,QWORD PTR [rip+0x9b7]        # 20f0 <_IO_stdin_used+0xf0>
    1739:	push   QWORD PTR [rbp-0x180]
    173f:	push   QWORD PTR [rbp-0x188]
    1745:	vaddsd xmm0,xmm0,xmm1
    1749:	push   r14
    174b:	push   r15
    174d:	inc    r15
    1750:	call   1140 <__printf_chk@plt>
    1755:	mov    rax,QWORD PTR [rbp-0x170]
    175c:	add    rsp,0x30
    1760:	cmp    r15,rax
    1763:	je     17e0 <main+0x680>
    1765:	mov    edx,0x1
    176a:	mov    esi,0x2403
    176f:	mov    edi,r13d
    1772:	xor    eax,eax
    1774:	call   1100 <ioctl@plt>
    1779:	mov    edx,0x1
    177e:	mov    esi,0x2400
    1783:	mov    edi,r13d
    1786:	xor    eax,eax
    1788:	call   1100 <ioctl@plt>
    178d:	mov    rsi,QWORD PTR [rbp-0x138]
    1794:	mov    edi,0x4
    1799:	call   10e0 <clock_gettime@plt>
    179e:	mov    rax,QWORD PTR [rbp-0x120]
    17a5:	mov    QWORD PTR [rbp-0x140],rax
    17ac:	mov    rax,QWORD PTR [rbp-0x118]
    17b3:	mov    QWORD PTR [rbp-0x148],rax
    17ba:	test   r14,r14
    17bd:	jle    1637 <main+0x4d7>
    17c3:	xor    edx,edx
    17c5:	nop    DWORD PTR [rax]
    17c8:	mov    rsi,rbx
    17cb:	mov    rdi,r12
    17ce:	call   19f0 <saxpy.constprop.0>
    17d3:	inc    rdx
    17d6:	cmp    rdx,r14
    17d9:	jne    17c8 <main+0x668>
    17db:	jmp    1630 <main+0x4d0>
    17e0:	mov    QWORD PTR [rbp-0x140],0x1
    17eb:	jmp    13f8 <main+0x298>
    17f0:	cmp    QWORD PTR [rbp-0x170],0x0
    17f8:	je     15dc <main+0x47c>
    17fe:	xor    r15d,r15d
    1801:	jmp    1418 <main+0x2b8>
    1806:	cmp    QWORD PTR [rbp-0x170],0x0
    180e:	je     17e0 <main+0x680>
    1810:	xor    r15d,r15d
    1813:	jmp    1765 <main+0x605>
    1818:	vmovss xmm0,DWORD PTR [rbp-0x124]
    1820:	mov    rax,QWORD PTR [rbp-0x38]
    1824:	sub    rax,QWORD PTR fs:0x28
    182d:	jne    1842 <main+0x6e2>
    182f:	lea    rsp,[rbp-0x30]
    1833:	xor    eax,eax
    1835:	pop    rbx
    1836:	pop    r10
    1838:	pop    r12
    183a:	pop    r13
    183c:	pop    r14
    183e:	pop    r15
    1840:	pop    rbp
    1841:	ret
    1842:	call   10f0 <__stack_chk_fail@plt>
    1847:	nop    WORD PTR [rax+rax*1+0x0]

0000000000001850 <set_fast_math>:
    1850:	endbr64
    1854:	push   rbp
    1855:	mov    rbp,rsp
    1858:	stmxcsr DWORD PTR [rbp-0x4]
    185c:	or     DWORD PTR [rbp-0x4],0x8040
    1863:	ldmxcsr DWORD PTR [rbp-0x4]
    1867:	pop    rbp
    1868:	ret
    1869:	nop    DWORD PTR [rax+0x0]

0000000000001870 <_start>:
    1870:	endbr64
    1874:	xor    ebp,ebp
    1876:	mov    r9,rdx
    1879:	pop    rsi
    187a:	mov    rdx,rsp
    187d:	and    rsp,0xfffffffffffffff0
    1881:	push   rax
    1882:	push   rsp
    1883:	xor    r8d,r8d
    1886:	xor    ecx,ecx
    1888:	lea    rdi,[rip+0xfffffffffffff8d1]        # 1160 <main>
    188f:	call   QWORD PTR [rip+0x2743]        # 3fd8 <__libc_start_main@GLIBC_2.34>
    1895:	hlt
    1896:	cs nop WORD PTR [rax+rax*1+0x0]

00000000000018a0 <deregister_tm_clones>:
    18a0:	lea    rdi,[rip+0x2769]        # 4010 <__TMC_END__>
    18a7:	lea    rax,[rip+0x2762]        # 4010 <__TMC_END__>
    18ae:	cmp    rax,rdi
    18b1:	je     18c8 <deregister_tm_clones+0x28>
    18b3:	mov    rax,QWORD PTR [rip+0x2726]        # 3fe0 <_ITM_deregisterTMCloneTable@Base>
    18ba:	test   rax,rax
    18bd:	je     18c8 <deregister_tm_clones+0x28>
    18bf:	jmp    rax
    18c1:	nop    DWORD PTR [rax+0x0]
    18c8:	ret
    18c9:	nop    DWORD PTR [rax+0x0]

00000000000018d0 <register_tm_clones>:
    18d0:	lea    rdi,[rip+0x2739]        # 4010 <__TMC_END__>
    18d7:	lea    rsi,[rip+0x2732]        # 4010 <__TMC_END__>
    18de:	sub    rsi,rdi
    18e1:	mov    rax,rsi
    18e4:	shr    rsi,0x3f
    18e8:	sar    rax,0x3
    18ec:	add    rsi,rax
    18ef:	sar    rsi,1
    18f2:	je     1908 <register_tm_clones+0x38>
    18f4:	mov    rax,QWORD PTR [rip+0x26f5]        # 3ff0 <_ITM_registerTMCloneTable@Base>
    18fb:	test   rax,rax
    18fe:	je     1908 <register_tm_clones+0x38>
    1900:	jmp    rax
    1902:	nop    WORD PTR [rax+rax*1+0x0]
    1908:	ret
    1909:	nop    DWORD PTR [rax+0x0]

0000000000001910 <__do_global_dtors_aux>:
    1910:	endbr64
    1914:	cmp    BYTE PTR [rip+0x26f5],0x0        # 4010 <__TMC_END__>
    191b:	jne    1948 <__do_global_dtors_aux+0x38>
    191d:	push   rbp
    191e:	cmp    QWORD PTR [rip+0x26d2],0x0        # 3ff8 <__cxa_finalize@GLIBC_2.2.5>
    1926:	mov    rbp,rsp
    1929:	je     1937 <__do_global_dtors_aux+0x27>
    192b:	mov    rdi,QWORD PTR [rip+0x26d6]        # 4008 <__dso_handle>
    1932:	call   10c0 <__cxa_finalize@plt>
    1937:	call   18a0 <deregister_tm_clones>
    193c:	mov    BYTE PTR [rip+0x26cd],0x1        # 4010 <__TMC_END__>
    1943:	pop    rbp
    1944:	ret
    1945:	nop    DWORD PTR [rax]
    1948:	ret
    1949:	nop    DWORD PTR [rax+0x0]

0000000000001950 <frame_dummy>:
    1950:	endbr64
    1954:	jmp    18d0 <register_tm_clones>
    1959:	nop    DWORD PTR [rax+0x0]

0000000000001960 <relu.constprop.0>:
    1960:	xor    eax,eax
    1962:	vxorps xmm1,xmm1,xmm1
    1966:	cs nop WORD PTR [rax+rax*1+0x0]
    1970:	vmaxps zmm0,zmm1,ZMMWORD PTR [rsi+rax*1]
    1977:	vmovups ZMMWORD PTR [rdi+rax*1],zmm0
    197e:	add    rax,0x40
    1982:	cmp    rax,0x2000
    1988:	jne    1970 <relu.constprop.0+0x10>
    198a:	vzeroupper
    198d:	ret
    198e:	xchg   ax,ax

0000000000001990 <dot.constprop.0>:
    1990:	xor    eax,eax
    1992:	vxorps xmm1,xmm1,xmm1
    1996:	cs nop WORD PTR [rax+rax*1+0x0]
    19a0:	vmovups zmm2,ZMMWORD PTR [rsi+rax*1]
    19a7:	vmulps zmm0,zmm2,ZMMWORD PTR [rdi+rax*1]
    19ae:	add    rax,0x40
    19b2:	vaddps zmm1,zmm1,zmm0
    19b8:	cmp    rax,0x2000
    19be:	jne    19a0 <dot.constprop.0+0x10>
    19c0:	vextractf32x8 ymm0,zmm1,0x1
    19c7:	vaddps ymm1,ymm0,ymm1
    19cb:	vextractf128 xmm0,ymm1,0x1
    19d1:	vaddps xmm0,xmm0,xmm1
    19d5:	vmovhlps xmm1,xmm0,xmm0
    19d9:	vaddps xmm1,xmm1,xmm0
    19dd:	vshufps xmm0,xmm1,xmm1,0x55
    19e2:	vaddps xmm0,xmm0,xmm1
    19e6:	vzeroupper
    19e9:	ret
    19ea:	nop    WORD PTR [rax+rax*1+0x0]

00000000000019f0 <saxpy.constprop.0>:
    19f0:	vbroadcastss zmm1,DWORD PTR [rip+0x60a]        # 2004 <_IO_stdin_used+0x4>
    19fa:	xor    eax,eax
    19fc:	nop    DWORD PTR [rax+0x0]
    1a00:	vmovups zmm0,ZMMWORD PTR [rsi+rax*1]
    1a07:	vfmadd213ps zmm0,zmm1,ZMMWORD PTR [rdi+rax*1]
    1a0e:	vmovups ZMMWORD PTR [rdi+rax*1],zmm0
    1a15:	add    rax,0x40
    1a19:	cmp    rax,0x2000
    1a1f:	jne    1a00 <saxpy.constprop.0+0x10>
    1a21:	vzeroupper
    1a24:	ret
    1a25:	data16 cs nop WORD PTR [rax+rax*1+0x0]

0000000000001a30 <saxpy>:
    1a30:	endbr64
    1a34:	mov    rcx,rdi
    1a37:	test   rdx,rdx
    1a3a:	jle    1bb3 <saxpy+0x183>
    1a40:	lea    rax,[rdx-0x1]
    1a44:	cmp    rax,0xe
    1a48:	jbe    1bb4 <saxpy+0x184>
    1a4e:	mov    rdi,rdx
    1a51:	vbroadcastss zmm2,xmm0
    1a57:	xor    eax,eax
    1a59:	shr    rdi,0x4
    1a5d:	shl    rdi,0x6
    1a61:	nop    DWORD PTR [rax+0x0]
    1a68:	vmovups zmm1,ZMMWORD PTR [rsi+rax*1]
    1a6f:	vfmadd213ps zmm1,zmm2,ZMMWORD PTR [rcx+rax*1]
    1a76:	vmovups ZMMWORD PTR [rcx+rax*1],zmm1
    1a7d:	add    rax,0x40
    1a81:	cmp    rax,rdi
    1a84:	jne    1a68 <saxpy+0x38>
    1a86:	mov    rax,rdx
    1a89:	and    rax,0xfffffffffffffff0
    1a8d:	mov    rdi,rax
    1a90:	cmp    rdx,rax
    1a93:	je     1bb0 <saxpy+0x180>
    1a99:	mov    r8,rdx
    1a9c:	sub    r8,rdi
    1a9f:	lea    r9,[r8-0x1]
    1aa3:	cmp    r9,0x6
    1aa7:	jbe    1ad6 <saxpy+0xa6>
    1aa9:	lea    r9,[rcx+rdi*4]
    1aad:	vbroadcastss ymm1,xmm0
    1ab2:	vmovups ymm3,YMMWORD PTR [r9]
    1ab7:	vfmadd132ps ymm1,ymm3,YMMWORD PTR [rsi+rdi*4]
    1abd:	mov    rdi,r8
    1ac0:	and    rdi,0xfffffffffffffff8
    1ac4:	add    rax,rdi
    1ac7:	and    r8d,0x7
    1acb:	vmovups YMMWORD PTR [r9],ymm1
    1ad0:	je     1bb0 <saxpy+0x180>
    1ad6:	vmovss xmm1,DWORD PTR [rsi+rax*4]
    1adb:	lea    rdi,[rax*4+0x0]
    1ae3:	lea    r8,[rcx+rdi*1]
    1ae7:	vfmadd213ss xmm1,xmm0,DWORD PTR [r8]
    1aec:	vmovss DWORD PTR [r8],xmm1
    1af1:	lea    r8,[rax+0x1]
    1af5:	cmp    rdx,r8
    1af8:	jle    1bb0 <saxpy+0x180>
    1afe:	vmovss xmm1,DWORD PTR [rsi+rdi*1+0x4]
    1b04:	lea    r8,[rcx+rdi*1+0x4]
    1b09:	vfmadd213ss xmm1,xmm0,DWORD PTR [r8]
    1b0e:	vmovss DWORD PTR [r8],xmm1
    1b13:	lea    r8,[rax+0x2]
    1b17:	cmp    rdx,r8
    1b1a:	jle    1bb0 <saxpy+0x180>
    1b20:	vmovss xmm1,DWORD PTR [rsi+rdi*1+0x8]
    1b26:	lea    r8,[rcx+rdi*1+0x8]
    1b2b:	vfmadd213ss xmm1,xmm0,DWORD PTR [r8]
    1b30:	vmovss DWORD PTR [r8],xmm1
    1b35:	lea    r8,[rax+0x3]
    1b39:	cmp    rdx,r8
    1b3c:	jle    1bb0 <saxpy+0x180>
    1b3e:	vmovss xmm1,DWORD PTR [rsi+rdi*1+0xc]
    1b44:	lea    r8,[rcx+rdi*1+0xc]
    1b49:	vfmadd213ss xmm1,xmm0,DWORD PTR [r8]
    1b4e:	vmovss DWORD PTR [r8],xmm1
    1b53:	lea    r8,[rax+0x4]
    1b57:	cmp    rdx,r8
    1b5a:	jle    1bb0 <saxpy+0x180>
    1b5c:	vmovss xmm1,DWORD PTR [rsi+rdi*1+0x10]
    1b62:	lea    r8,[rcx+rdi*1+0x10]
    1b67:	vfmadd213ss xmm1,xmm0,DWORD PTR [r8]
    1b6c:	vmovss DWORD PTR [r8],xmm1
    1b71:	lea    r8,[rax+0x5]
    1b75:	cmp    rdx,r8
    1b78:	jle    1bb0 <saxpy+0x180>
    1b7a:	vmovss xmm1,DWORD PTR [rsi+rdi*1+0x14]
    1b80:	lea    r8,[rcx+rdi*1+0x14]
    1b85:	add    rax,0x6
    1b89:	vfmadd213ss xmm1,xmm0,DWORD PTR [r8]
    1b8e:	vmovss DWORD PTR [r8],xmm1
    1b93:	cmp    rdx,rax
    1b96:	jle    1bb0 <saxpy+0x180>
    1b98:	lea    rax,[rcx+rdi*1+0x18]
    1b9d:	vmovss xmm4,DWORD PTR [rax]
    1ba1:	vfmadd132ss xmm0,xmm4,DWORD PTR [rsi+rdi*1+0x18]
    1ba8:	vmovss DWORD PTR [rax],xmm0
    1bac:	vzeroupper
    1baf:	ret
    1bb0:	vzeroupper
    1bb3:	ret
    1bb4:	xor    edi,edi
    1bb6:	xor    eax,eax
    1bb8:	jmp    1a99 <saxpy+0x69>
    1bbd:	nop    DWORD PTR [rax]

0000000000001bc0 <dot>:
    1bc0:	endbr64
    1bc4:	mov    rcx,rsi
    1bc7:	test   rdx,rdx
    1bca:	jle    1d40 <dot+0x180>
    1bd0:	lea    rax,[rdx-0x1]
    1bd4:	cmp    rax,0xe
    1bd8:	jbe    1d45 <dot+0x185>
    1bde:	mov    rsi,rdx
    1be1:	xor    eax,eax
    1be3:	vxorps xmm1,xmm1,xmm1
    1be7:	shr    rsi,0x4
    1beb:	shl    rsi,0x6
    1bef:	nop
    1bf0:	vmovups zmm4,ZMMWORD PTR [rdi+rax*1]
    1bf7:	vmulps zmm0,zmm4,ZMMWORD PTR [rcx+rax*1]
    1bfe:	add    rax,0x40
    1c02:	vaddps zmm1,zmm1,zmm0
    1c08:	cmp    rsi,rax
    1c0b:	jne    1bf0 <dot+0x30>
    1c0d:	vextractf32x8 ymm3,zmm1,0x1
    1c14:	mov    rax,rdx
    1c17:	vaddps ymm2,ymm3,ymm1
    1c1b:	and    rax,0xfffffffffffffff0
    1c1f:	vaddps ymm1,ymm1,ymm3
    1c23:	mov    rsi,rax
    1c26:	vextractf128 xmm0,ymm2,0x1
    1c2c:	vaddps xmm0,xmm0,xmm2
    1c30:	vmovhlps xmm2,xmm0,xmm0
    1c34:	vaddps xmm2,xmm2,xmm0
    1c38:	vshufps xmm0,xmm2,xmm2,0x55
    1c3d:	vaddps xmm0,xmm0,xmm2
    1c41:	cmp    rdx,rax
    1c44:	je     1d38 <dot+0x178>
    1c4a:	mov    r8,rdx
    1c4d:	sub    r8,rsi
    1c50:	lea    r9,[r8-0x1]
    1c54:	cmp    r9,0x6
    1c58:	jbe    1c94 <dot+0xd4>
    1c5a:	vmovups ymm5,YMMWORD PTR [rdi+rsi*4]
    1c5f:	vfmadd231ps ymm1,ymm5,YMMWORD PTR [rcx+rsi*4]
    1c65:	mov    rsi,r8
    1c68:	and    rsi,0xfffffffffffffff8
    1c6c:	add    rax,rsi
    1c6f:	and    r8d,0x7
    1c73:	vextractf128 xmm0,ymm1,0x1
    1c79:	vaddps xmm0,xmm0,xmm1
    1c7d:	vmovhlps xmm1,xmm0,xmm0
    1c81:	vaddps xmm1,xmm1,xmm0
    1c85:	vshufps xmm0,xmm1,xmm1,0x55
    1c8a:	vaddps xmm0,xmm0,xmm1
    1c8e:	je     1d38 <dot+0x178>
    1c94:	vmovss xmm6,DWORD PTR [rdi+rax*4]
    1c99:	lea    r8,[rax+0x1]
    1c9d:	lea    rsi,[rax*4+0x0]
    1ca5:	vfmadd231ss xmm0,xmm6,DWORD PTR [rcx+rax*4]
    1cab:	cmp    rdx,r8
    1cae:	jle    1d38 <dot+0x178>
    1cb4:	vmovss xmm7,DWORD PTR [rcx+rsi*1+0x4]
    1cba:	lea    r8,[rax+0x2]
    1cbe:	vfmadd231ss xmm0,xmm7,DWORD PTR [rdi+rsi*1+0x4]
    1cc5:	cmp    rdx,r8
    1cc8:	jle    1d38 <dot+0x178>
    1cca:	vmovss xmm7,DWORD PTR [rdi+rsi*1+0x8]
    1cd0:	lea    r8,[rax+0x3]
    1cd4:	vfmadd231ss xmm0,xmm7,DWORD PTR [rcx+rsi*1+0x8]
    1cdb:	cmp    rdx,r8
    1cde:	jle    1d38 <dot+0x178>
    1ce0:	vmovss xmm6,DWORD PTR [rdi+rsi*1+0xc]
    1ce6:	lea    r8,[rax+0x4]
    1cea:	vfmadd231ss xmm0,xmm6,DWORD PTR [rcx+rsi*1+0xc]
    1cf1:	cmp    rdx,r8
    1cf4:	jle    1d38 <dot+0x178>
    1cf6:	vmovss xmm3,DWORD PTR [rdi+rsi*1+0x10]
    1cfc:	lea    r8,[rax+0x5]
    1d00:	vfmadd231ss xmm0,xmm3,DWORD PTR [rcx+rsi*1+0x10]
    1d07:	cmp    rdx,r8
    1d0a:	jle    1d38 <dot+0x178>
    1d0c:	vmovss xmm7,DWORD PTR [rdi+rsi*1+0x14]
    1d12:	add    rax,0x6
    1d16:	vfmadd231ss xmm0,xmm7,DWORD PTR [rcx+rsi*1+0x14]
    1d1d:	cmp    rdx,rax
    1d20:	jle    1d38 <dot+0x178>
    1d22:	vmovss xmm6,DWORD PTR [rdi+rsi*1+0x18]
    1d28:	vfmadd231ss xmm0,xmm6,DWORD PTR [rcx+rsi*1+0x18]
    1d2f:	vzeroupper
    1d32:	ret
    1d33:	nop    DWORD PTR [rax+rax*1+0x0]
    1d38:	vzeroupper
    1d3b:	ret
    1d3c:	nop    DWORD PTR [rax+0x0]
    1d40:	vxorps xmm0,xmm0,xmm0
    1d44:	ret
    1d45:	vxorps xmm1,xmm1,xmm1
    1d49:	xor    esi,esi
    1d4b:	vxorps xmm0,xmm0,xmm0
    1d4f:	xor    eax,eax
    1d51:	jmp    1c4a <dot+0x8a>
    1d56:	cs nop WORD PTR [rax+rax*1+0x0]

0000000000001d60 <relu>:
    1d60:	endbr64
    1d64:	mov    rcx,rdi
    1d67:	test   rdx,rdx
    1d6a:	jle    1e8b <relu+0x12b>
    1d70:	lea    rax,[rdx-0x1]
    1d74:	cmp    rax,0xe
    1d78:	jbe    1e8c <relu+0x12c>
    1d7e:	mov    rdi,rdx
    1d81:	xor    eax,eax
    1d83:	vxorps xmm1,xmm1,xmm1
    1d87:	shr    rdi,0x4
    1d8b:	shl    rdi,0x6
    1d8f:	nop
    1d90:	vmaxps zmm0,zmm1,ZMMWORD PTR [rsi+rax*1]
    1d97:	vmovups ZMMWORD PTR [rcx+rax*1],zmm0
    1d9e:	add    rax,0x40
    1da2:	cmp    rdi,rax
    1da5:	jne    1d90 <relu+0x30>
    1da7:	mov    rax,rdx
    1daa:	and    rax,0xfffffffffffffff0
    1dae:	mov    rdi,rax
    1db1:	cmp    rdx,rax
    1db4:	je     1e88 <relu+0x128>
    1dba:	mov    r8,rdx
    1dbd:	sub    r8,rdi
    1dc0:	lea    r9,[r8-0x1]
    1dc4:	cmp    r9,0x6
    1dc8:	jbe    1dec <relu+0x8c>
    1dca:	vxorps xmm0,xmm0,xmm0
    1dce:	vmaxps ymm0,ymm0,YMMWORD PTR [rsi+rdi*4]
    1dd3:	vmovups YMMWORD PTR [rcx+rdi*4],ymm0
    1dd8:	mov    rdi,r8
    1ddb:	and    rdi,0xfffffffffffffff8
    1ddf:	add    rax,rdi
    1de2:	and    r8d,0x7
    1de6:	je     1e88 <relu+0x128>
    1dec:	vxorps xmm0,xmm0,xmm0
    1df0:	lea    r8,[rax+0x1]
    1df4:	lea    rdi,[rax*4+0x0]
    1dfc:	vmaxss xmm1,xmm0,DWORD PTR [rsi+rax*4]
    1e01:	vmovss DWORD PTR [rcx+rax*4],xmm1
    1e06:	cmp    rdx,r8
    1e09:	jle    1e88 <relu+0x128>
    1e0b:	vmaxss xmm1,xmm0,DWORD PTR [rsi+rdi*1+0x4]
    1e11:	lea    r8,[rax+0x2]
    1e15:	vmovss DWORD PTR [rcx+rdi*1+0x4],xmm1
    1e1b:	cmp    rdx,r8
    1e1e:	jle    1e88 <relu+0x128>
    1e20:	vmaxss xmm1,xmm0,DWORD PTR [rsi+rdi*1+0x8]
    1e26:	lea    r8,[rax+0x3]
    1e2a:	vmovss DWORD PTR [rcx+rdi*1+0x8],xmm1
    1e30:	cmp    rdx,r8
    1e33:	jle    1e88 <relu+0x128>
    1e35:	vmaxss xmm1,xmm0,DWORD PTR [rsi+rdi*1+0xc]
    1e3b:	lea    r8,[rax+0x4]
    1e3f:	vmovss DWORD PTR [rcx+rdi*1+0xc],xmm1
    1e45:	cmp    rdx,r8
    1e48:	jle    1e88 <relu+0x128>
    1e4a:	vmaxss xmm1,xmm0,DWORD PTR [rsi+rdi*1+0x10]
    1e50:	lea    r8,[rax+0x5]
    1e54:	vmovss DWORD PTR [rcx+rdi*1+0x10],xmm1
    1e5a:	cmp    rdx,r8
    1e5d:	jle    1e88 <relu+0x128>
    1e5f:	vmaxss xmm1,xmm0,DWORD PTR [rsi+rdi*1+0x14]
    1e65:	add    rax,0x6
    1e69:	vmovss DWORD PTR [rcx+rdi*1+0x14],xmm1
    1e6f:	cmp    rdx,rax
    1e72:	jle    1e88 <relu+0x128>
    1e74:	vmaxss xmm0,xmm0,DWORD PTR [rsi+rdi*1+0x18]
    1e7a:	vmovss DWORD PTR [rcx+rdi*1+0x18],xmm0
    1e80:	vzeroupper
    1e83:	ret
    1e84:	nop    DWORD PTR [rax+0x0]
    1e88:	vzeroupper
    1e8b:	ret
    1e8c:	xor    edi,edi
    1e8e:	xor    eax,eax
    1e90:	jmp    1dba <relu+0x5a>

Disassembly of section .fini:

0000000000001e98 <_fini>:
    1e98:	endbr64
    1e9c:	sub    rsp,0x8
    1ea0:	add    rsp,0x8
    1ea4:	ret
