
bin/flags_O3_native_zmm:     file format elf64-x86-64


Disassembly of section .init:

0000000000001000 <_init>:
    1000:	endbr64
    1004:	sub    rsp,0x8
    1008:	mov    rax,QWORD PTR [rip+0x3fd9]        # 4fe8 <__gmon_start__@Base>
    100f:	test   rax,rax
    1012:	je     1016 <_init+0x16>
    1014:	call   rax
    1016:	add    rsp,0x8
    101a:	ret

Disassembly of section .plt:

0000000000001020 <.plt>:
    1020:	push   QWORD PTR [rip+0x3f5a]        # 4f80 <_GLOBAL_OFFSET_TABLE_+0x8>
    1026:	jmp    QWORD PTR [rip+0x3f5c]        # 4f88 <_GLOBAL_OFFSET_TABLE_+0x10>
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
    10c4:	jmp    QWORD PTR [rip+0x3f2e]        # 4ff8 <__cxa_finalize@GLIBC_2.2.5>
    10ca:	nop    WORD PTR [rax+rax*1+0x0]

Disassembly of section .plt.sec:

00000000000010d0 <getenv@plt>:
    10d0:	endbr64
    10d4:	jmp    QWORD PTR [rip+0x3eb6]        # 4f90 <getenv@GLIBC_2.2.5>
    10da:	nop    WORD PTR [rax+rax*1+0x0]

00000000000010e0 <clock_gettime@plt>:
    10e0:	endbr64
    10e4:	jmp    QWORD PTR [rip+0x3eae]        # 4f98 <clock_gettime@GLIBC_2.17>
    10ea:	nop    WORD PTR [rax+rax*1+0x0]

00000000000010f0 <__stack_chk_fail@plt>:
    10f0:	endbr64
    10f4:	jmp    QWORD PTR [rip+0x3ea6]        # 4fa0 <__stack_chk_fail@GLIBC_2.4>
    10fa:	nop    WORD PTR [rax+rax*1+0x0]

0000000000001100 <ioctl@plt>:
    1100:	endbr64
    1104:	jmp    QWORD PTR [rip+0x3e9e]        # 4fa8 <ioctl@GLIBC_2.2.5>
    110a:	nop    WORD PTR [rax+rax*1+0x0]

0000000000001110 <read@plt>:
    1110:	endbr64
    1114:	jmp    QWORD PTR [rip+0x3e96]        # 4fb0 <read@GLIBC_2.2.5>
    111a:	nop    WORD PTR [rax+rax*1+0x0]

0000000000001120 <syscall@plt>:
    1120:	endbr64
    1124:	jmp    QWORD PTR [rip+0x3e8e]        # 4fb8 <syscall@GLIBC_2.2.5>
    112a:	nop    WORD PTR [rax+rax*1+0x0]

0000000000001130 <__isoc23_strtol@plt>:
    1130:	endbr64
    1134:	jmp    QWORD PTR [rip+0x3e86]        # 4fc0 <__isoc23_strtol@GLIBC_2.38>
    113a:	nop    WORD PTR [rax+rax*1+0x0]

0000000000001140 <__printf_chk@plt>:
    1140:	endbr64
    1144:	jmp    QWORD PTR [rip+0x3e7e]        # 4fc8 <__printf_chk@GLIBC_2.3.4>
    114a:	nop    WORD PTR [rax+rax*1+0x0]

0000000000001150 <aligned_alloc@plt>:
    1150:	endbr64
    1154:	jmp    QWORD PTR [rip+0x3e76]        # 4fd0 <aligned_alloc@GLIBC_2.16>
    115a:	nop    WORD PTR [rax+rax*1+0x0]

Disassembly of section .text:

0000000000001160 <main>:
    1160:	endbr64
    1164:	push   rbp
    1165:	lea    rdi,[rip+0x1eae]        # 301a <_IO_stdin_used+0x1a>
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
    11bb:	lea    rdi,[rip+0x1e5d]        # 301f <_IO_stdin_used+0x1f>
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
    1205:	vmovss xmm2,DWORD PTR [rip+0x1dfb]        # 3008 <_IO_stdin_used+0x8>
    120d:	vmovss xmm1,DWORD PTR [rip+0x1df7]        # 300c <_IO_stdin_used+0xc>
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
    1276:	vmovdqa xmm0,XMMWORD PTR [rip+0x1e62]        # 30e0 <_IO_stdin_used+0xe0>
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
    137e:	lea    rbx,[rip+0x1c8b]        # 3010 <_IO_stdin_used+0x10>
    1385:	lea    rsi,[rip+0x1cac]        # 3038 <_IO_stdin_used+0x38>
    138c:	mov    edi,0x2
    1391:	mov    r13,QWORD PTR [rbp-0x140]
    1398:	call   1140 <__printf_chk@plt>
    139d:	lea    rax,[rip+0x1c72]        # 3016 <_IO_stdin_used+0x16>
    13a4:	vmovq  xmm0,rbx
    13a9:	mov    DWORD PTR [rbp-0x124],0x0
    13b3:	vpinsrq xmm0,xmm0,rax,0x1
    13b9:	lea    rax,[rip+0x1c65]        # 3025 <_IO_stdin_used+0x25>
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
    1556:	lea    rdx,[rip+0x1acd]        # 302a <_IO_stdin_used+0x2a>
    155d:	mov    edi,0x2
    1562:	vcvtsi2sd xmm1,xmm4,QWORD PTR [rbp-0x160]
    156b:	mov    rcx,QWORD PTR [rbp+rax*8-0x80]
    1570:	lea    rsi,[rip+0x1b21]        # 3098 <_IO_stdin_used+0x98>
    1577:	mov    eax,0x1
    157c:	vcvtsi2sd xmm2,xmm4,QWORD PTR [rbp-0x150]
    1585:	vmulsd xmm0,xmm0,QWORD PTR [rip+0x1b63]        # 30f0 <_IO_stdin_used+0xf0>
    158d:	vaddsd xmm0,xmm0,xmm1
    1591:	vcvtsi2sd xmm1,xmm4,QWORD PTR [rbp-0x148]
    159a:	push   QWORD PTR [rbp-0x190]
    15a0:	push   QWORD PTR [rbp-0x178]
    15a6:	vmulsd xmm1,xmm1,QWORD PTR [rip+0x1b42]        # 30f0 <_IO_stdin_used+0xf0>
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
    16b8:	lea    rdx,[rip+0x196b]        # 302a <_IO_stdin_used+0x2a>
    16bf:	mov    edi,0x2
    16c4:	mov    eax,0x1
    16c9:	vcvtsi2sd xmm1,xmm6,QWORD PTR [rbp-0x158]
    16d2:	lea    rsi,[rip+0x19bf]        # 3098 <_IO_stdin_used+0x98>
    16d9:	vcvtsi2sd xmm2,xmm6,QWORD PTR [rbp-0x148]
    16e2:	vmulsd xmm0,xmm0,QWORD PTR [rip+0x1a06]        # 30f0 <_IO_stdin_used+0xf0>
    16ea:	vaddsd xmm0,xmm0,xmm1
    16ee:	vcvtsi2sd xmm1,xmm6,QWORD PTR [rbp-0x140]
    16f7:	push   QWORD PTR [rbp-0x190]
    16fd:	push   QWORD PTR [rbp-0x178]
    1703:	vmulsd xmm1,xmm1,QWORD PTR [rip+0x19e5]        # 30f0 <_IO_stdin_used+0xf0>
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
    17a6:	call   1a70 <saxpy.constprop.0>
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
    188f:	call   QWORD PTR [rip+0x3743]        # 4fd8 <__libc_start_main@GLIBC_2.34>
    1895:	hlt
    1896:	cs nop WORD PTR [rax+rax*1+0x0]

00000000000018a0 <deregister_tm_clones>:
    18a0:	lea    rdi,[rip+0x3769]        # 5010 <__TMC_END__>
    18a7:	lea    rax,[rip+0x3762]        # 5010 <__TMC_END__>
    18ae:	cmp    rax,rdi
    18b1:	je     18c8 <deregister_tm_clones+0x28>
    18b3:	mov    rax,QWORD PTR [rip+0x3726]        # 4fe0 <_ITM_deregisterTMCloneTable@Base>
    18ba:	test   rax,rax
    18bd:	je     18c8 <deregister_tm_clones+0x28>
    18bf:	jmp    rax
    18c1:	nop    DWORD PTR [rax+0x0]
    18c8:	ret
    18c9:	nop    DWORD PTR [rax+0x0]

00000000000018d0 <register_tm_clones>:
    18d0:	lea    rdi,[rip+0x3739]        # 5010 <__TMC_END__>
    18d7:	lea    rsi,[rip+0x3732]        # 5010 <__TMC_END__>
    18de:	sub    rsi,rdi
    18e1:	mov    rax,rsi
    18e4:	shr    rsi,0x3f
    18e8:	sar    rax,0x3
    18ec:	add    rsi,rax
    18ef:	sar    rsi,1
    18f2:	je     1908 <register_tm_clones+0x38>
    18f4:	mov    rax,QWORD PTR [rip+0x36f5]        # 4ff0 <_ITM_registerTMCloneTable@Base>
    18fb:	test   rax,rax
    18fe:	je     1908 <register_tm_clones+0x38>
    1900:	jmp    rax
    1902:	nop    WORD PTR [rax+rax*1+0x0]
    1908:	ret
    1909:	nop    DWORD PTR [rax+0x0]

0000000000001910 <__do_global_dtors_aux>:
    1910:	endbr64
    1914:	cmp    BYTE PTR [rip+0x36f5],0x0        # 5010 <__TMC_END__>
    191b:	jne    1948 <__do_global_dtors_aux+0x38>
    191d:	push   rbp
    191e:	cmp    QWORD PTR [rip+0x36d2],0x0        # 4ff8 <__cxa_finalize@GLIBC_2.2.5>
    1926:	mov    rbp,rsp
    1929:	je     1937 <__do_global_dtors_aux+0x27>
    192b:	mov    rdi,QWORD PTR [rip+0x36d6]        # 5008 <__dso_handle>
    1932:	call   10c0 <__cxa_finalize@plt>
    1937:	call   18a0 <deregister_tm_clones>
    193c:	mov    BYTE PTR [rip+0x36cd],0x1        # 5010 <__TMC_END__>
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
    1970:	vmovups zmm0,ZMMWORD PTR [rsi+rax*1]
    1977:	vcmpltps k1,zmm2,zmm0
    197e:	vmovaps zmm1{k1}{z},zmm0
    1984:	vmovups ZMMWORD PTR [rdi+rax*1],zmm1
    198b:	add    rax,0x40
    198f:	cmp    rax,0x2000
    1995:	jne    1970 <relu.constprop.0+0x10>
    1997:	vzeroupper
    199a:	ret
    199b:	nop    DWORD PTR [rax+rax*1+0x0]

00000000000019a0 <dot.constprop.0>:
    19a0:	mov    rdx,rdi
    19a3:	mov    rcx,rsi
    19a6:	vxorps xmm0,xmm0,xmm0
    19aa:	xor    eax,eax
    19ac:	nop    DWORD PTR [rax+0x0]
    19b0:	vmovups zmm5,ZMMWORD PTR [rcx+rax*1]
    19b7:	vmulps zmm1,zmm5,ZMMWORD PTR [rdx+rax*1]
    19be:	add    rax,0x40
    19c2:	vshufps xmm4,xmm1,xmm1,0x55
    19c7:	vshufps xmm2,xmm1,xmm1,0xff
    19cc:	valignd ymm3,ymm1,ymm1,0x7
    19d3:	vaddss xmm0,xmm0,xmm1
    19d7:	vaddss xmm4,xmm4,xmm0
    19db:	vunpckhps xmm0,xmm1,xmm1
    19df:	vaddss xmm0,xmm0,xmm4
    19e3:	vaddss xmm2,xmm2,xmm0
    19e7:	vextractf32x4 xmm0,ymm1,0x1
    19ee:	vaddss xmm0,xmm0,xmm2
    19f2:	valignd ymm2,ymm1,ymm1,0x5
    19f9:	vaddss xmm0,xmm0,xmm2
    19fd:	valignd ymm2,ymm1,ymm1,0x6
    1a04:	vextractf32x8 ymm1,zmm1,0x1
    1a0b:	vaddss xmm0,xmm0,xmm2
    1a0f:	vshufps xmm2,xmm1,xmm1,0xff
    1a14:	vaddss xmm0,xmm0,xmm3
    1a18:	vshufps xmm3,xmm1,xmm1,0x55
    1a1d:	vaddss xmm0,xmm0,xmm1
    1a21:	vaddss xmm0,xmm0,xmm3
    1a25:	vunpckhps xmm3,xmm1,xmm1
    1a29:	vaddss xmm0,xmm0,xmm3
    1a2d:	vaddss xmm0,xmm0,xmm2
    1a31:	vextractf32x4 xmm2,ymm1,0x1
    1a38:	vaddss xmm0,xmm0,xmm2
    1a3c:	valignd ymm2,ymm1,ymm1,0x5
    1a43:	vaddss xmm0,xmm0,xmm2
    1a47:	valignd ymm2,ymm1,ymm1,0x6
    1a4e:	valignd ymm1,ymm1,ymm1,0x7
    1a55:	vaddss xmm0,xmm0,xmm2
    1a59:	vaddss xmm0,xmm0,xmm1
    1a5d:	cmp    rax,0x2000
    1a63:	jne    19b0 <dot.constprop.0+0x10>
    1a69:	vzeroupper
    1a6c:	ret
    1a6d:	nop    DWORD PTR [rax]

0000000000001a70 <saxpy.constprop.0>:
    1a70:	vbroadcastss zmm1,DWORD PTR [rip+0x158a]        # 3004 <_IO_stdin_used+0x4>
    1a7a:	xor    eax,eax
    1a7c:	nop    DWORD PTR [rax+0x0]
    1a80:	vmulps zmm0,zmm1,ZMMWORD PTR [rsi+rax*1]
    1a87:	vaddps zmm0,zmm0,ZMMWORD PTR [rdi+rax*1]
    1a8e:	vmovups ZMMWORD PTR [rdi+rax*1],zmm0
    1a95:	add    rax,0x40
    1a99:	cmp    rax,0x2000
    1a9f:	jne    1a80 <saxpy.constprop.0+0x10>
    1aa1:	vzeroupper
    1aa4:	ret
    1aa5:	data16 cs nop WORD PTR [rax+rax*1+0x0]

0000000000001ab0 <saxpy>:
    1ab0:	endbr64
    1ab4:	mov    rcx,rdi
    1ab7:	test   rdx,rdx
    1aba:	jle    1c33 <saxpy+0x183>
    1ac0:	lea    rax,[rdx-0x1]
    1ac4:	cmp    rax,0xe
    1ac8:	jbe    1c34 <saxpy+0x184>
    1ace:	mov    rdi,rdx
    1ad1:	vbroadcastss zmm2,xmm0
    1ad7:	xor    eax,eax
    1ad9:	shr    rdi,0x4
    1add:	shl    rdi,0x6
    1ae1:	nop    DWORD PTR [rax+0x0]
    1ae8:	vmulps zmm1,zmm2,ZMMWORD PTR [rsi+rax*1]
    1aef:	vaddps zmm1,zmm1,ZMMWORD PTR [rcx+rax*1]
    1af6:	vmovups ZMMWORD PTR [rcx+rax*1],zmm1
    1afd:	add    rax,0x40
    1b01:	cmp    rax,rdi
    1b04:	jne    1ae8 <saxpy+0x38>
    1b06:	mov    rax,rdx
    1b09:	and    rax,0xfffffffffffffff0
    1b0d:	mov    rdi,rax
    1b10:	cmp    rdx,rax
    1b13:	je     1c30 <saxpy+0x180>
    1b19:	mov    r8,rdx
    1b1c:	sub    r8,rdi
    1b1f:	lea    r9,[r8-0x1]
    1b23:	cmp    r9,0x6
    1b27:	jbe    1b55 <saxpy+0xa5>
    1b29:	vbroadcastss ymm1,xmm0
    1b2e:	lea    r9,[rcx+rdi*4]
    1b32:	vmulps ymm1,ymm1,YMMWORD PTR [rsi+rdi*4]
    1b37:	mov    rdi,r8
    1b3a:	and    rdi,0xfffffffffffffff8
    1b3e:	add    rax,rdi
    1b41:	and    r8d,0x7
    1b45:	vaddps ymm1,ymm1,YMMWORD PTR [r9]
    1b4a:	vmovups YMMWORD PTR [r9],ymm1
    1b4f:	je     1c30 <saxpy+0x180>
    1b55:	vmulss xmm1,xmm0,DWORD PTR [rsi+rax*4]
    1b5a:	lea    rdi,[rax*4+0x0]
    1b62:	lea    r8,[rcx+rdi*1]
    1b66:	vaddss xmm1,xmm1,DWORD PTR [r8]
    1b6b:	vmovss DWORD PTR [r8],xmm1
    1b70:	lea    r8,[rax+0x1]
    1b74:	cmp    rdx,r8
    1b77:	jle    1c30 <saxpy+0x180>
    1b7d:	vmulss xmm1,xmm0,DWORD PTR [rsi+rdi*1+0x4]
    1b83:	lea    r8,[rcx+rdi*1+0x4]
    1b88:	vaddss xmm1,xmm1,DWORD PTR [r8]
    1b8d:	vmovss DWORD PTR [r8],xmm1
    1b92:	lea    r8,[rax+0x2]
    1b96:	cmp    rdx,r8
    1b99:	jle    1c30 <saxpy+0x180>
    1b9f:	vmulss xmm1,xmm0,DWORD PTR [rsi+rdi*1+0x8]
    1ba5:	lea    r8,[rcx+rdi*1+0x8]
    1baa:	vaddss xmm1,xmm1,DWORD PTR [r8]
    1baf:	vmovss DWORD PTR [r8],xmm1
    1bb4:	lea    r8,[rax+0x3]
    1bb8:	cmp    rdx,r8
    1bbb:	jle    1c30 <saxpy+0x180>
    1bbd:	vmulss xmm1,xmm0,DWORD PTR [rsi+rdi*1+0xc]
    1bc3:	lea    r8,[rcx+rdi*1+0xc]
    1bc8:	vaddss xmm1,xmm1,DWORD PTR [r8]
    1bcd:	vmovss DWORD PTR [r8],xmm1
    1bd2:	lea    r8,[rax+0x4]
    1bd6:	cmp    rdx,r8
    1bd9:	jle    1c30 <saxpy+0x180>
    1bdb:	vmulss xmm1,xmm0,DWORD PTR [rsi+rdi*1+0x10]
    1be1:	lea    r8,[rcx+rdi*1+0x10]
    1be6:	vaddss xmm1,xmm1,DWORD PTR [r8]
    1beb:	vmovss DWORD PTR [r8],xmm1
    1bf0:	lea    r8,[rax+0x5]
    1bf4:	cmp    rdx,r8
    1bf7:	jle    1c30 <saxpy+0x180>
    1bf9:	vmulss xmm1,xmm0,DWORD PTR [rsi+rdi*1+0x14]
    1bff:	lea    r8,[rcx+rdi*1+0x14]
    1c04:	add    rax,0x6
    1c08:	vaddss xmm1,xmm1,DWORD PTR [r8]
    1c0d:	vmovss DWORD PTR [r8],xmm1
    1c12:	cmp    rdx,rax
    1c15:	jle    1c30 <saxpy+0x180>
    1c17:	vmulss xmm0,xmm0,DWORD PTR [rsi+rdi*1+0x18]
    1c1d:	lea    rax,[rcx+rdi*1+0x18]
    1c22:	vaddss xmm0,xmm0,DWORD PTR [rax]
    1c26:	vmovss DWORD PTR [rax],xmm0
    1c2a:	vzeroupper
    1c2d:	ret
    1c2e:	xchg   ax,ax
    1c30:	vzeroupper
    1c33:	ret
    1c34:	xor    edi,edi
    1c36:	xor    eax,eax
    1c38:	jmp    1b19 <saxpy+0x69>
    1c3d:	nop    DWORD PTR [rax]

0000000000001c40 <dot>:
    1c40:	endbr64
    1c44:	mov    rcx,rsi
    1c47:	test   rdx,rdx
    1c4a:	jle    1e78 <dot+0x238>
    1c50:	lea    rax,[rdx-0x1]
    1c54:	cmp    rax,0xe
    1c58:	jbe    1e7d <dot+0x23d>
    1c5e:	mov    rsi,rdx
    1c61:	xor    eax,eax
    1c63:	vxorps xmm0,xmm0,xmm0
    1c67:	shr    rsi,0x4
    1c6b:	shl    rsi,0x6
    1c6f:	nop
    1c70:	vmovups zmm5,ZMMWORD PTR [rdi+rax*1]
    1c77:	vmulps zmm1,zmm5,ZMMWORD PTR [rcx+rax*1]
    1c7e:	add    rax,0x40
    1c82:	vshufps xmm4,xmm1,xmm1,0x55
    1c87:	vshufps xmm3,xmm1,xmm1,0xff
    1c8c:	valignd ymm2,ymm1,ymm1,0x7
    1c93:	vaddss xmm0,xmm0,xmm1
    1c97:	vaddss xmm0,xmm0,xmm4
    1c9b:	vunpckhps xmm4,xmm1,xmm1
    1c9f:	vaddss xmm0,xmm0,xmm4
    1ca3:	vaddss xmm0,xmm0,xmm3
    1ca7:	vextractf32x4 xmm3,ymm1,0x1
    1cae:	vaddss xmm0,xmm0,xmm3
    1cb2:	valignd ymm3,ymm1,ymm1,0x5
    1cb9:	vaddss xmm0,xmm0,xmm3
    1cbd:	valignd ymm3,ymm1,ymm1,0x6
    1cc4:	vextractf32x8 ymm1,zmm1,0x1
    1ccb:	vaddss xmm0,xmm0,xmm3
    1ccf:	vshufps xmm3,xmm1,xmm1,0x55
    1cd4:	vaddss xmm0,xmm0,xmm2
    1cd8:	vshufps xmm2,xmm1,xmm1,0xff
    1cdd:	vaddss xmm0,xmm0,xmm1
    1ce1:	vaddss xmm0,xmm0,xmm3
    1ce5:	vunpckhps xmm3,xmm1,xmm1
    1ce9:	vaddss xmm0,xmm0,xmm3
    1ced:	vaddss xmm0,xmm0,xmm2
    1cf1:	vextractf32x4 xmm2,ymm1,0x1
    1cf8:	vaddss xmm0,xmm0,xmm2
    1cfc:	valignd ymm2,ymm1,ymm1,0x5
    1d03:	vaddss xmm0,xmm0,xmm2
    1d07:	valignd ymm2,ymm1,ymm1,0x6
    1d0e:	valignd ymm1,ymm1,ymm1,0x7
    1d15:	vaddss xmm0,xmm0,xmm2
    1d19:	vaddss xmm0,xmm0,xmm1
    1d1d:	cmp    rsi,rax
    1d20:	jne    1c70 <dot+0x30>
    1d26:	mov    rax,rdx
    1d29:	and    rax,0xfffffffffffffff0
    1d2d:	mov    r8,rax
    1d30:	cmp    rdx,rax
    1d33:	je     1e70 <dot+0x230>
    1d39:	mov    rsi,rdx
    1d3c:	sub    rsi,r8
    1d3f:	lea    r9,[rsi-0x1]
    1d43:	cmp    r9,0x6
    1d47:	jbe    1db2 <dot+0x172>
    1d49:	vmovups ymm6,YMMWORD PTR [rdi+r8*4]
    1d4f:	vmulps ymm1,ymm6,YMMWORD PTR [rcx+r8*4]
    1d55:	mov    r8,rsi
    1d58:	and    r8,0xfffffffffffffff8
    1d5c:	add    rax,r8
    1d5f:	and    esi,0x7
    1d62:	vaddss xmm0,xmm0,xmm1
    1d66:	vshufps xmm3,xmm1,xmm1,0x55
    1d6b:	vshufps xmm2,xmm1,xmm1,0xff
    1d70:	vaddss xmm0,xmm0,xmm3
    1d74:	vunpckhps xmm3,xmm1,xmm1
    1d78:	vaddss xmm0,xmm0,xmm3
    1d7c:	vaddss xmm0,xmm0,xmm2
    1d80:	vextractf32x4 xmm2,ymm1,0x1
    1d87:	vaddss xmm0,xmm0,xmm2
    1d8b:	valignd ymm2,ymm1,ymm1,0x5
    1d92:	vaddss xmm0,xmm0,xmm2
    1d96:	valignd ymm2,ymm1,ymm1,0x6
    1d9d:	valignd ymm1,ymm1,ymm1,0x7
    1da4:	vaddss xmm0,xmm0,xmm2
    1da8:	vaddss xmm0,xmm0,xmm1
    1dac:	je     1e70 <dot+0x230>
    1db2:	vmovss xmm1,DWORD PTR [rdi+rax*4]
    1db7:	lea    r8,[rax+0x1]
    1dbb:	lea    rsi,[rax*4+0x0]
    1dc3:	vmulss xmm1,xmm1,DWORD PTR [rcx+rax*4]
    1dc8:	vaddss xmm0,xmm0,xmm1
    1dcc:	cmp    rdx,r8
    1dcf:	jle    1e70 <dot+0x230>
    1dd5:	vmovss xmm1,DWORD PTR [rdi+rsi*1+0x4]
    1ddb:	lea    r8,[rax+0x2]
    1ddf:	vmulss xmm1,xmm1,DWORD PTR [rcx+rsi*1+0x4]
    1de5:	vaddss xmm0,xmm0,xmm1
    1de9:	cmp    rdx,r8
    1dec:	jle    1e70 <dot+0x230>
    1df2:	vmovss xmm1,DWORD PTR [rdi+rsi*1+0x8]
    1df8:	lea    r8,[rax+0x3]
    1dfc:	vmulss xmm1,xmm1,DWORD PTR [rcx+rsi*1+0x8]
    1e02:	vaddss xmm0,xmm0,xmm1
    1e06:	cmp    rdx,r8
    1e09:	jle    1e70 <dot+0x230>
    1e0b:	vmovss xmm1,DWORD PTR [rdi+rsi*1+0xc]
    1e11:	lea    r8,[rax+0x4]
    1e15:	vmulss xmm1,xmm1,DWORD PTR [rcx+rsi*1+0xc]
    1e1b:	vaddss xmm0,xmm0,xmm1
    1e1f:	cmp    rdx,r8
    1e22:	jle    1e70 <dot+0x230>
    1e24:	vmovss xmm1,DWORD PTR [rdi+rsi*1+0x10]
    1e2a:	lea    r8,[rax+0x5]
    1e2e:	vmulss xmm1,xmm1,DWORD PTR [rcx+rsi*1+0x10]
    1e34:	vaddss xmm0,xmm0,xmm1
    1e38:	cmp    rdx,r8
    1e3b:	jle    1e70 <dot+0x230>
    1e3d:	vmovss xmm1,DWORD PTR [rdi+rsi*1+0x14]
    1e43:	add    rax,0x6
    1e47:	vmulss xmm1,xmm1,DWORD PTR [rcx+rsi*1+0x14]
    1e4d:	vaddss xmm0,xmm0,xmm1
    1e51:	cmp    rdx,rax
    1e54:	jle    1e70 <dot+0x230>
    1e56:	vmovss xmm1,DWORD PTR [rdi+rsi*1+0x18]
    1e5c:	vmulss xmm1,xmm1,DWORD PTR [rcx+rsi*1+0x18]
    1e62:	vaddss xmm0,xmm0,xmm1
    1e66:	vzeroupper
    1e69:	ret
    1e6a:	nop    WORD PTR [rax+rax*1+0x0]
    1e70:	vzeroupper
    1e73:	ret
    1e74:	nop    DWORD PTR [rax+0x0]
    1e78:	vxorps xmm0,xmm0,xmm0
    1e7c:	ret
    1e7d:	xor    r8d,r8d
    1e80:	xor    eax,eax
    1e82:	vxorps xmm0,xmm0,xmm0
    1e86:	jmp    1d39 <dot+0xf9>
    1e8b:	nop    DWORD PTR [rax+rax*1+0x0]

0000000000001e90 <relu>:
    1e90:	endbr64
    1e94:	mov    rcx,rdi
    1e97:	test   rdx,rdx
    1e9a:	jle    2023 <relu+0x193>
    1ea0:	lea    rax,[rdx-0x1]
    1ea4:	cmp    rax,0xe
    1ea8:	jbe    2024 <relu+0x194>
    1eae:	mov    rdi,rdx
    1eb1:	xor    eax,eax
    1eb3:	vxorps xmm2,xmm2,xmm2
    1eb7:	shr    rdi,0x4
    1ebb:	shl    rdi,0x6
    1ebf:	nop
    1ec0:	vmovups zmm0,ZMMWORD PTR [rsi+rax*1]
    1ec7:	vcmpltps k1,zmm2,zmm0
    1ece:	vmovaps zmm1{k1}{z},zmm0
    1ed4:	vmovups ZMMWORD PTR [rcx+rax*1],zmm1
    1edb:	add    rax,0x40
    1edf:	cmp    rdi,rax
    1ee2:	jne    1ec0 <relu+0x30>
    1ee4:	mov    rax,rdx
    1ee7:	and    rax,0xfffffffffffffff0
    1eeb:	mov    rdi,rax
    1eee:	cmp    rdx,rax
    1ef1:	je     2020 <relu+0x190>
    1ef7:	mov    r8,rdx
    1efa:	sub    r8,rdi
    1efd:	lea    r9,[r8-0x1]
    1f01:	cmp    r9,0x6
    1f05:	jbe    1f32 <relu+0xa2>
    1f07:	vmovups ymm1,YMMWORD PTR [rsi+rdi*4]
    1f0c:	vxorps xmm0,xmm0,xmm0
    1f10:	vcmpltps ymm0,ymm0,ymm1
    1f15:	vandps ymm0,ymm0,ymm1
    1f19:	vmovups YMMWORD PTR [rcx+rdi*4],ymm0
    1f1e:	mov    rdi,r8
    1f21:	and    rdi,0xfffffffffffffff8
    1f25:	add    rax,rdi
    1f28:	and    r8d,0x7
    1f2c:	je     2020 <relu+0x190>
    1f32:	vmovss xmm1,DWORD PTR [rsi+rax*4]
    1f37:	vxorps xmm0,xmm0,xmm0
    1f3b:	lea    rdi,[rax*4+0x0]
    1f43:	lea    r8,[rax+0x1]
    1f47:	vcmpltss xmm2,xmm0,xmm1
    1f4c:	vblendvps xmm1,xmm0,xmm1,xmm2
    1f52:	vmovss DWORD PTR [rcx+rdi*1],xmm1
    1f57:	cmp    rdx,r8
    1f5a:	jle    2020 <relu+0x190>
    1f60:	vmovss xmm1,DWORD PTR [rsi+rdi*1+0x4]
    1f66:	lea    r8,[rax+0x2]
    1f6a:	vcmpltss xmm2,xmm0,xmm1
    1f6f:	vblendvps xmm1,xmm0,xmm1,xmm2
    1f75:	vmovss DWORD PTR [rcx+rdi*1+0x4],xmm1
    1f7b:	cmp    rdx,r8
    1f7e:	jle    2020 <relu+0x190>
    1f84:	vmovss xmm1,DWORD PTR [rsi+rdi*1+0x8]
    1f8a:	lea    r8,[rax+0x3]
    1f8e:	vcmpltss xmm2,xmm0,xmm1
    1f93:	vblendvps xmm1,xmm0,xmm1,xmm2
    1f99:	vmovss DWORD PTR [rcx+rdi*1+0x8],xmm1
    1f9f:	cmp    rdx,r8
    1fa2:	jle    2020 <relu+0x190>
    1fa4:	vmovss xmm1,DWORD PTR [rsi+rdi*1+0xc]
    1faa:	lea    r8,[rax+0x4]
    1fae:	vcmpltss xmm2,xmm0,xmm1
    1fb3:	vblendvps xmm1,xmm0,xmm1,xmm2
    1fb9:	vmovss DWORD PTR [rcx+rdi*1+0xc],xmm1
    1fbf:	cmp    rdx,r8
    1fc2:	jle    2020 <relu+0x190>
    1fc4:	vmovss xmm1,DWORD PTR [rsi+rdi*1+0x10]
    1fca:	lea    r8,[rax+0x5]
    1fce:	vcmpltss xmm2,xmm0,xmm1
    1fd3:	vblendvps xmm1,xmm0,xmm1,xmm2
    1fd9:	vmovss DWORD PTR [rcx+rdi*1+0x10],xmm1
    1fdf:	cmp    rdx,r8
    1fe2:	jle    2020 <relu+0x190>
    1fe4:	vmovss xmm1,DWORD PTR [rsi+rdi*1+0x14]
    1fea:	add    rax,0x6
    1fee:	vcmpltss xmm2,xmm0,xmm1
    1ff3:	vblendvps xmm1,xmm0,xmm1,xmm2
    1ff9:	vmovss DWORD PTR [rcx+rdi*1+0x14],xmm1
    1fff:	cmp    rdx,rax
    2002:	jle    2020 <relu+0x190>
    2004:	vmovss xmm1,DWORD PTR [rsi+rdi*1+0x18]
    200a:	vcmpltss xmm2,xmm0,xmm1
    200f:	vblendvps xmm1,xmm0,xmm1,xmm2
    2015:	vmovss DWORD PTR [rcx+rdi*1+0x18],xmm1
    201b:	vzeroupper
    201e:	ret
    201f:	nop
    2020:	vzeroupper
    2023:	ret
    2024:	xor    edi,edi
    2026:	xor    eax,eax
    2028:	jmp    1ef7 <relu+0x67>

Disassembly of section .fini:

0000000000002030 <_fini>:
    2030:	endbr64
    2034:	sub    rsp,0x8
    2038:	add    rsp,0x8
    203c:	ret
