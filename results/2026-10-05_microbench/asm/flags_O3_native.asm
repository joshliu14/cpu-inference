
bin/flags_O3_native:     file format elf64-x86-64


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
    1385:	lea    rsi,[rip+0xcac]        # 2038 <_IO_stdin_used+0x38>
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
    13ee:	js     1836 <main+0x6d6>
    13f4:	nop    DWORD PTR [rax+0x0]
    13f8:	cmp    QWORD PTR [rbp-0x140],0x0
    1400:	mov    r13d,DWORD PTR [rbp-0x8c]
    1407:	mov    r15,0xffffffffffffffff
    140e:	je     173b <main+0x5db>
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
    147c:	je     17f0 <main+0x690>
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
    1530:	je     17d0 <main+0x670>
    1536:	vxorpd xmm4,xmm4,xmm4
    153a:	mov    rax,QWORD PTR [rbp-0x140]
    1541:	mov    r9d,0x800
    1547:	mov    r8d,0x4000
    154d:	vcvtsi2sd xmm0,xmm4,QWORD PTR [rbp-0x158]
    1556:	lea    rdx,[rip+0xacd]        # 202a <_IO_stdin_used+0x2a>
    155d:	mov    edi,0x2
    1562:	vcvtsi2sd xmm1,xmm4,QWORD PTR [rbp-0x160]
    156b:	mov    rcx,QWORD PTR [rbp+rax*8-0x80]
    1570:	lea    rsi,[rip+0xb21]        # 2098 <_IO_stdin_used+0x98>
    1577:	mov    eax,0x1
    157c:	vcvtsi2sd xmm2,xmm4,QWORD PTR [rbp-0x150]
    1585:	vmulsd xmm0,xmm0,QWORD PTR [rip+0xb63]        # 20f0 <_IO_stdin_used+0xf0>
    158d:	vaddsd xmm0,xmm0,xmm1
    1591:	vcvtsi2sd xmm1,xmm4,QWORD PTR [rbp-0x148]
    159a:	push   QWORD PTR [rbp-0x190]
    15a0:	push   QWORD PTR [rbp-0x178]
    15a6:	vmulsd xmm1,xmm1,QWORD PTR [rip+0xb42]        # 20f0 <_IO_stdin_used+0xf0>
    15ae:	push   QWORD PTR [rbp-0x180]
    15b4:	push   QWORD PTR [rbp-0x188]
    15ba:	vaddsd xmm1,xmm1,xmm2
    15be:	push   r14
    15c0:	vsubsd xmm0,xmm0,xmm1
    15c4:	push   r15
    15c6:	inc    r15
    15c9:	call   1140 <__printf_chk@plt>
    15ce:	add    rsp,0x30
    15d2:	cmp    QWORD PTR [rbp-0x170],r15
    15d9:	jne    1418 <main+0x2b8>
    15df:	cmp    QWORD PTR [rbp-0x140],0x2
    15e7:	je     1836 <main+0x6d6>
    15ed:	mov    QWORD PTR [rbp-0x140],0x2
    15f8:	jmp    13f8 <main+0x298>
    15fd:	nop    DWORD PTR [rax]
    1600:	mov    r13d,DWORD PTR [rbp-0x8c]
    1607:	mov    rsi,QWORD PTR [rbp-0x138]
    160e:	mov    edi,0x4
    1613:	call   10e0 <clock_gettime@plt>
    1618:	mov    rax,QWORD PTR [rbp-0x120]
    161f:	mov    edx,0x1
    1624:	mov    esi,0x2401
    1629:	mov    edi,r13d
    162c:	mov    QWORD PTR [rbp-0x150],rax
    1633:	mov    rax,QWORD PTR [rbp-0x118]
    163a:	mov    QWORD PTR [rbp-0x158],rax
    1641:	xor    eax,eax
    1643:	call   1100 <ioctl@plt>
    1648:	vpxor  xmm7,xmm7,xmm7
    164c:	mov    rsi,QWORD PTR [rbp-0x168]
    1653:	mov    edx,0x20
    1658:	vmovdqu8 YMMWORD PTR [rbp-0x60],ymm7
    165f:	mov    edi,r13d
    1662:	vzeroupper
    1665:	call   1110 <read@plt>
    166a:	cmp    rax,0x20
    166e:	jne    1691 <main+0x531>
    1670:	mov    rax,QWORD PTR [rbp-0x58]
    1674:	mov    QWORD PTR [rbp-0x188],rax
    167b:	mov    rax,QWORD PTR [rbp-0x50]
    167f:	mov    QWORD PTR [rbp-0x180],rax
    1686:	mov    rax,QWORD PTR [rbp-0x48]
    168a:	mov    QWORD PTR [rbp-0x178],rax
    1691:	cmp    r15,0xffffffffffffffff
    1695:	je     1824 <main+0x6c4>
    169b:	vxorpd xmm6,xmm6,xmm6
    169f:	mov    rcx,QWORD PTR [rbp-0x80]
    16a3:	mov    r9d,0x800
    16a9:	mov    r8d,0x4000
    16af:	vcvtsi2sd xmm0,xmm6,QWORD PTR [rbp-0x150]
    16b8:	lea    rdx,[rip+0x96b]        # 202a <_IO_stdin_used+0x2a>
    16bf:	mov    edi,0x2
    16c4:	mov    eax,0x1
    16c9:	vcvtsi2sd xmm1,xmm6,QWORD PTR [rbp-0x158]
    16d2:	lea    rsi,[rip+0x9bf]        # 2098 <_IO_stdin_used+0x98>
    16d9:	vcvtsi2sd xmm2,xmm6,QWORD PTR [rbp-0x148]
    16e2:	vmulsd xmm0,xmm0,QWORD PTR [rip+0xa06]        # 20f0 <_IO_stdin_used+0xf0>
    16ea:	vaddsd xmm0,xmm0,xmm1
    16ee:	vcvtsi2sd xmm1,xmm6,QWORD PTR [rbp-0x140]
    16f7:	push   QWORD PTR [rbp-0x190]
    16fd:	push   QWORD PTR [rbp-0x178]
    1703:	vmulsd xmm1,xmm1,QWORD PTR [rip+0x9e5]        # 20f0 <_IO_stdin_used+0xf0>
    170b:	push   QWORD PTR [rbp-0x180]
    1711:	push   QWORD PTR [rbp-0x188]
    1717:	vaddsd xmm1,xmm1,xmm2
    171b:	push   r14
    171d:	vsubsd xmm0,xmm0,xmm1
    1721:	push   r15
    1723:	inc    r15
    1726:	call   1140 <__printf_chk@plt>
    172b:	mov    rax,QWORD PTR [rbp-0x170]
    1732:	add    rsp,0x30
    1736:	cmp    r15,rax
    1739:	je     17b8 <main+0x658>
    173b:	mov    edx,0x1
    1740:	mov    esi,0x2403
    1745:	mov    edi,r13d
    1748:	xor    eax,eax
    174a:	call   1100 <ioctl@plt>
    174f:	mov    edx,0x1
    1754:	mov    esi,0x2400
    1759:	mov    edi,r13d
    175c:	xor    eax,eax
    175e:	call   1100 <ioctl@plt>
    1763:	mov    rsi,QWORD PTR [rbp-0x138]
    176a:	mov    edi,0x4
    176f:	call   10e0 <clock_gettime@plt>
    1774:	mov    rax,QWORD PTR [rbp-0x120]
    177b:	mov    QWORD PTR [rbp-0x140],rax
    1782:	mov    rax,QWORD PTR [rbp-0x118]
    1789:	mov    QWORD PTR [rbp-0x148],rax
    1790:	test   r14,r14
    1793:	jle    1607 <main+0x4a7>
    1799:	xor    edx,edx
    179b:	nop    DWORD PTR [rax+rax*1+0x0]
    17a0:	mov    rsi,rbx
    17a3:	mov    rdi,r12
    17a6:	call   1a20 <saxpy.constprop.0>
    17ab:	inc    rdx
    17ae:	cmp    rdx,r14
    17b1:	jne    17a0 <main+0x640>
    17b3:	jmp    1600 <main+0x4a0>
    17b8:	mov    QWORD PTR [rbp-0x140],0x1
    17c3:	jmp    13f8 <main+0x298>
    17c8:	nop    DWORD PTR [rax+rax*1+0x0]
    17d0:	cmp    QWORD PTR [rbp-0x170],0x0
    17d8:	je     15df <main+0x47f>
    17de:	xor    r15d,r15d
    17e1:	jmp    1418 <main+0x2b8>
    17e6:	cs nop WORD PTR [rax+rax*1+0x0]
    17f0:	xor    r8d,r8d
    17f3:	nop    DWORD PTR [rax+rax*1+0x0]
    17f8:	mov    rsi,r12
    17fb:	mov    rdi,rbx
    17fe:	call   19a0 <dot.constprop.0>
    1803:	vmovss xmm1,DWORD PTR [rbp-0x124]
    180b:	vaddss xmm0,xmm0,xmm1
    180f:	vmovss DWORD PTR [rbp-0x124],xmm0
    1817:	inc    r8
    181a:	cmp    r14,r8
    181d:	jne    17f8 <main+0x698>
    181f:	jmp    149b <main+0x33b>
    1824:	cmp    QWORD PTR [rbp-0x170],0x0
    182c:	je     17b8 <main+0x658>
    182e:	xor    r15d,r15d
    1831:	jmp    173b <main+0x5db>
    1836:	vmovss xmm0,DWORD PTR [rbp-0x124]
    183e:	mov    rax,QWORD PTR [rbp-0x38]
    1842:	sub    rax,QWORD PTR fs:0x28
    184b:	jne    1860 <main+0x700>
    184d:	lea    rsp,[rbp-0x30]
    1851:	xor    eax,eax
    1853:	pop    rbx
    1854:	pop    r10
    1856:	pop    r12
    1858:	pop    r13
    185a:	pop    r14
    185c:	pop    r15
    185e:	pop    rbp
    185f:	ret
    1860:	call   10f0 <__stack_chk_fail@plt>
    1865:	cs nop WORD PTR [rax+rax*1+0x0]
    186f:	nop

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
    1962:	vxorps xmm2,xmm2,xmm2
    1966:	cs nop WORD PTR [rax+rax*1+0x0]
    1970:	vmovups ymm1,YMMWORD PTR [rsi+rax*1]
    1975:	vcmpltps ymm0,ymm2,ymm1
    197a:	vandps ymm0,ymm0,ymm1
    197e:	vmovups YMMWORD PTR [rdi+rax*1],ymm0
    1983:	add    rax,0x20
    1987:	cmp    rax,0x2000
    198d:	jne    1970 <relu.constprop.0+0x10>
    198f:	vzeroupper
    1992:	ret
    1993:	data16 cs nop WORD PTR [rax+rax*1+0x0]
    199e:	xchg   ax,ax

00000000000019a0 <dot.constprop.0>:
    19a0:	mov    rdx,rdi
    19a3:	mov    rcx,rsi
    19a6:	vxorps xmm0,xmm0,xmm0
    19aa:	xor    eax,eax
    19ac:	nop    DWORD PTR [rax+0x0]
    19b0:	vmovups ymm4,YMMWORD PTR [rcx+rax*1]
    19b5:	vmulps ymm1,ymm4,YMMWORD PTR [rdx+rax*1]
    19ba:	add    rax,0x20
    19be:	vaddss xmm0,xmm0,xmm1
    19c2:	vshufps xmm3,xmm1,xmm1,0x55
    19c7:	vshufps xmm2,xmm1,xmm1,0xff
    19cc:	vaddss xmm3,xmm3,xmm0
    19d0:	vunpckhps xmm0,xmm1,xmm1
    19d4:	vaddss xmm0,xmm0,xmm3
    19d8:	vaddss xmm2,xmm2,xmm0
    19dc:	vextractf32x4 xmm0,ymm1,0x1
    19e3:	vaddss xmm0,xmm0,xmm2
    19e7:	valignd ymm2,ymm1,ymm1,0x5
    19ee:	vaddss xmm0,xmm0,xmm2
    19f2:	valignd ymm2,ymm1,ymm1,0x6
    19f9:	valignd ymm1,ymm1,ymm1,0x7
    1a00:	vaddss xmm0,xmm0,xmm2
    1a04:	vaddss xmm0,xmm0,xmm1
    1a08:	cmp    rax,0x2000
    1a0e:	jne    19b0 <dot.constprop.0+0x10>
    1a10:	vzeroupper
    1a13:	ret
    1a14:	data16 cs nop WORD PTR [rax+rax*1+0x0]
    1a1f:	nop

0000000000001a20 <saxpy.constprop.0>:
    1a20:	vbroadcastss ymm1,DWORD PTR [rip+0x5db]        # 2004 <_IO_stdin_used+0x4>
    1a29:	xor    eax,eax
    1a2b:	nop    DWORD PTR [rax+rax*1+0x0]
    1a30:	vmulps ymm0,ymm1,YMMWORD PTR [rsi+rax*1]
    1a35:	vaddps ymm0,ymm0,YMMWORD PTR [rdi+rax*1]
    1a3a:	vmovups YMMWORD PTR [rdi+rax*1],ymm0
    1a3f:	add    rax,0x20
    1a43:	cmp    rax,0x2000
    1a49:	jne    1a30 <saxpy.constprop.0+0x10>
    1a4b:	vzeroupper
    1a4e:	ret
    1a4f:	nop

0000000000001a50 <saxpy>:
    1a50:	endbr64
    1a54:	mov    rcx,rdi
    1a57:	test   rdx,rdx
    1a5a:	jle    1b3b <saxpy+0xeb>
    1a60:	lea    rax,[rdx-0x1]
    1a64:	cmp    rax,0x6
    1a68:	jbe    1b44 <saxpy+0xf4>
    1a6e:	mov    rdi,rdx
    1a71:	vbroadcastss ymm2,xmm0
    1a76:	xor    eax,eax
    1a78:	shr    rdi,0x3
    1a7c:	shl    rdi,0x5
    1a80:	vmulps ymm1,ymm2,YMMWORD PTR [rsi+rax*1]
    1a85:	vaddps ymm1,ymm1,YMMWORD PTR [rcx+rax*1]
    1a8a:	vmovups YMMWORD PTR [rcx+rax*1],ymm1
    1a8f:	add    rax,0x20
    1a93:	cmp    rax,rdi
    1a96:	jne    1a80 <saxpy+0x30>
    1a98:	mov    rax,rdx
    1a9b:	and    rax,0xfffffffffffffff8
    1a9f:	mov    rdi,rax
    1aa2:	cmp    rdx,rax
    1aa5:	je     1b40 <saxpy+0xf0>
    1aab:	vzeroupper
    1aae:	mov    r8,rdx
    1ab1:	sub    r8,rdi
    1ab4:	lea    r9,[r8-0x1]
    1ab8:	cmp    r9,0x2
    1abc:	jbe    1ae6 <saxpy+0x96>
    1abe:	vbroadcastss xmm1,xmm0
    1ac3:	lea    r9,[rcx+rdi*4]
    1ac7:	vmulps xmm1,xmm1,XMMWORD PTR [rsi+rdi*4]
    1acc:	mov    rdi,r8
    1acf:	and    rdi,0xfffffffffffffffc
    1ad3:	add    rax,rdi
    1ad6:	and    r8d,0x3
    1ada:	vaddps xmm1,xmm1,XMMWORD PTR [r9]
    1adf:	vmovups XMMWORD PTR [r9],xmm1
    1ae4:	je     1b3b <saxpy+0xeb>
    1ae6:	vmulss xmm1,xmm0,DWORD PTR [rsi+rax*4]
    1aeb:	lea    rdi,[rax*4+0x0]
    1af3:	lea    r8,[rcx+rdi*1]
    1af7:	vaddss xmm1,xmm1,DWORD PTR [r8]
    1afc:	vmovss DWORD PTR [r8],xmm1
    1b01:	lea    r8,[rax+0x1]
    1b05:	cmp    rdx,r8
    1b08:	jle    1b3b <saxpy+0xeb>
    1b0a:	vmulss xmm1,xmm0,DWORD PTR [rsi+rdi*1+0x4]
    1b10:	lea    r8,[rcx+rdi*1+0x4]
    1b15:	add    rax,0x2
    1b19:	vaddss xmm1,xmm1,DWORD PTR [r8]
    1b1e:	vmovss DWORD PTR [r8],xmm1
    1b23:	cmp    rdx,rax
    1b26:	jle    1b3b <saxpy+0xeb>
    1b28:	vmulss xmm0,xmm0,DWORD PTR [rsi+rdi*1+0x8]
    1b2e:	lea    rax,[rcx+rdi*1+0x8]
    1b33:	vaddss xmm0,xmm0,DWORD PTR [rax]
    1b37:	vmovss DWORD PTR [rax],xmm0
    1b3b:	ret
    1b3c:	nop    DWORD PTR [rax+0x0]
    1b40:	vzeroupper
    1b43:	ret
    1b44:	xor    edi,edi
    1b46:	xor    eax,eax
    1b48:	jmp    1aae <saxpy+0x5e>
    1b4d:	nop    DWORD PTR [rax]

0000000000001b50 <dot>:
    1b50:	endbr64
    1b54:	mov    rax,rdi
    1b57:	mov    rcx,rsi
    1b5a:	test   rdx,rdx
    1b5d:	jle    1c90 <dot+0x140>
    1b63:	lea    rsi,[rdx-0x1]
    1b67:	cmp    rsi,0x6
    1b6b:	jbe    1c9c <dot+0x14c>
    1b71:	mov    rdi,rdx
    1b74:	xor    esi,esi
    1b76:	vxorps xmm0,xmm0,xmm0
    1b7a:	shr    rdi,0x3
    1b7e:	shl    rdi,0x5
    1b82:	nop    WORD PTR [rax+rax*1+0x0]
    1b88:	vmovups ymm4,YMMWORD PTR [rax+rsi*1]
    1b8d:	vmulps ymm1,ymm4,YMMWORD PTR [rcx+rsi*1]
    1b92:	add    rsi,0x20
    1b96:	vaddss xmm0,xmm0,xmm1
    1b9a:	vshufps xmm3,xmm1,xmm1,0x55
    1b9f:	vshufps xmm2,xmm1,xmm1,0xff
    1ba4:	vaddss xmm0,xmm0,xmm3
    1ba8:	vunpckhps xmm3,xmm1,xmm1
    1bac:	vaddss xmm0,xmm0,xmm3
    1bb0:	vaddss xmm0,xmm0,xmm2
    1bb4:	vextractf32x4 xmm2,ymm1,0x1
    1bbb:	vaddss xmm0,xmm0,xmm2
    1bbf:	valignd ymm2,ymm1,ymm1,0x5
    1bc6:	vaddss xmm0,xmm0,xmm2
    1bca:	valignd ymm2,ymm1,ymm1,0x6
    1bd1:	valignd ymm1,ymm1,ymm1,0x7
    1bd8:	vaddss xmm0,xmm0,xmm2
    1bdc:	vaddss xmm0,xmm0,xmm1
    1be0:	cmp    rdi,rsi
    1be3:	jne    1b88 <dot+0x38>
    1be5:	mov    rsi,rdx
    1be8:	and    rsi,0xfffffffffffffff8
    1bec:	mov    rdi,rsi
    1bef:	cmp    rdx,rsi
    1bf2:	je     1c98 <dot+0x148>
    1bf8:	vzeroupper
    1bfb:	mov    r8,rdx
    1bfe:	sub    r8,rdi
    1c01:	lea    r9,[r8-0x1]
    1c05:	cmp    r9,0x2
    1c09:	jbe    1c43 <dot+0xf3>
    1c0b:	vmovups xmm5,XMMWORD PTR [rax+rdi*4]
    1c10:	vmulps xmm1,xmm5,XMMWORD PTR [rcx+rdi*4]
    1c15:	mov    rdi,r8
    1c18:	and    rdi,0xfffffffffffffffc
    1c1c:	add    rsi,rdi
    1c1f:	and    r8d,0x3
    1c23:	vaddss xmm0,xmm0,xmm1
    1c27:	vshufps xmm2,xmm1,xmm1,0x55
    1c2c:	vaddss xmm0,xmm0,xmm2
    1c30:	vunpckhps xmm2,xmm1,xmm1
    1c34:	vshufps xmm1,xmm1,xmm1,0xff
    1c39:	vaddss xmm0,xmm0,xmm2
    1c3d:	vaddss xmm0,xmm0,xmm1
    1c41:	je     1c94 <dot+0x144>
    1c43:	vmovss xmm1,DWORD PTR [rax+rsi*4]
    1c48:	lea    r8,[rsi+0x1]
    1c4c:	lea    rdi,[rsi*4+0x0]
    1c54:	vmulss xmm1,xmm1,DWORD PTR [rcx+rsi*4]
    1c59:	vaddss xmm0,xmm0,xmm1
    1c5d:	cmp    rdx,r8
    1c60:	jle    1c94 <dot+0x144>
    1c62:	vmovss xmm1,DWORD PTR [rax+rdi*1+0x4]
    1c68:	add    rsi,0x2
    1c6c:	vmulss xmm1,xmm1,DWORD PTR [rcx+rdi*1+0x4]
    1c72:	vaddss xmm0,xmm0,xmm1
    1c76:	cmp    rdx,rsi
    1c79:	jle    1c94 <dot+0x144>
    1c7b:	vmovss xmm1,DWORD PTR [rax+rdi*1+0x8]
    1c81:	vmulss xmm1,xmm1,DWORD PTR [rcx+rdi*1+0x8]
    1c87:	vaddss xmm0,xmm0,xmm1
    1c8b:	ret
    1c8c:	nop    DWORD PTR [rax+0x0]
    1c90:	vxorps xmm0,xmm0,xmm0
    1c94:	ret
    1c95:	nop    DWORD PTR [rax]
    1c98:	vzeroupper
    1c9b:	ret
    1c9c:	xor    edi,edi
    1c9e:	xor    esi,esi
    1ca0:	vxorps xmm0,xmm0,xmm0
    1ca4:	jmp    1bfb <dot+0xab>
    1ca9:	nop    DWORD PTR [rax+0x0]

0000000000001cb0 <relu>:
    1cb0:	endbr64
    1cb4:	mov    rcx,rdi
    1cb7:	test   rdx,rdx
    1cba:	jle    1daa <relu+0xfa>
    1cc0:	lea    rax,[rdx-0x1]
    1cc4:	cmp    rax,0x6
    1cc8:	jbe    1db4 <relu+0x104>
    1cce:	mov    rdi,rdx
    1cd1:	xor    eax,eax
    1cd3:	vxorps xmm2,xmm2,xmm2
    1cd7:	shr    rdi,0x3
    1cdb:	shl    rdi,0x5
    1cdf:	nop
    1ce0:	vmovups ymm1,YMMWORD PTR [rsi+rax*1]
    1ce5:	vcmpltps ymm0,ymm2,ymm1
    1cea:	vandps ymm0,ymm0,ymm1
    1cee:	vmovups YMMWORD PTR [rcx+rax*1],ymm0
    1cf3:	add    rax,0x20
    1cf7:	cmp    rdi,rax
    1cfa:	jne    1ce0 <relu+0x30>
    1cfc:	mov    rax,rdx
    1cff:	and    rax,0xfffffffffffffff8
    1d03:	mov    rdi,rax
    1d06:	cmp    rdx,rax
    1d09:	je     1db0 <relu+0x100>
    1d0f:	vzeroupper
    1d12:	mov    r8,rdx
    1d15:	sub    r8,rdi
    1d18:	lea    r9,[r8-0x1]
    1d1c:	cmp    r9,0x2
    1d20:	jbe    1d49 <relu+0x99>
    1d22:	vmovups xmm1,XMMWORD PTR [rsi+rdi*4]
    1d27:	vxorps xmm0,xmm0,xmm0
    1d2b:	vcmpltps xmm0,xmm0,xmm1
    1d30:	vandps xmm0,xmm0,xmm1
    1d34:	vmovups XMMWORD PTR [rcx+rdi*4],xmm0
    1d39:	mov    rdi,r8
    1d3c:	and    rdi,0xfffffffffffffffc
    1d40:	add    rax,rdi
    1d43:	and    r8d,0x3
    1d47:	je     1daa <relu+0xfa>
    1d49:	vmovss xmm1,DWORD PTR [rsi+rax*4]
    1d4e:	vxorps xmm0,xmm0,xmm0
    1d52:	lea    rdi,[rax*4+0x0]
    1d5a:	lea    r8,[rax+0x1]
    1d5e:	vcmpltss xmm2,xmm0,xmm1
    1d63:	vblendvps xmm1,xmm0,xmm1,xmm2
    1d69:	vmovss DWORD PTR [rcx+rdi*1],xmm1
    1d6e:	cmp    rdx,r8
    1d71:	jle    1daa <relu+0xfa>
    1d73:	vmovss xmm1,DWORD PTR [rsi+rdi*1+0x4]
    1d79:	add    rax,0x2
    1d7d:	vcmpltss xmm2,xmm0,xmm1
    1d82:	vblendvps xmm1,xmm0,xmm1,xmm2
    1d88:	vmovss DWORD PTR [rcx+rdi*1+0x4],xmm1
    1d8e:	cmp    rdx,rax
    1d91:	jle    1daa <relu+0xfa>
    1d93:	vmovss xmm1,DWORD PTR [rsi+rdi*1+0x8]
    1d99:	vcmpltss xmm2,xmm0,xmm1
    1d9e:	vblendvps xmm1,xmm0,xmm1,xmm2
    1da4:	vmovss DWORD PTR [rcx+rdi*1+0x8],xmm1
    1daa:	ret
    1dab:	nop    DWORD PTR [rax+rax*1+0x0]
    1db0:	vzeroupper
    1db3:	ret
    1db4:	xor    edi,edi
    1db6:	xor    eax,eax
    1db8:	jmp    1d12 <relu+0x62>

Disassembly of section .fini:

0000000000001dc0 <_fini>:
    1dc0:	endbr64
    1dc4:	sub    rsp,0x8
    1dc8:	add    rsp,0x8
    1dcc:	ret
