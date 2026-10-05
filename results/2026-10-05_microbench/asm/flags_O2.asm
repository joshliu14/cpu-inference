
bin/flags_O2:     file format elf64-x86-64


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
    1194:	mov    QWORD PTR [rsp+0x30],0x7
    119d:	test   rax,rax
    11a0:	je     11b6 <main+0x56>
    11a2:	mov    edx,0xa
    11a7:	xor    esi,esi
    11a9:	mov    rdi,rax
    11ac:	call   1130 <__isoc23_strtol@plt>
    11b1:	mov    QWORD PTR [rsp+0x30],rax
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
    1200:	movss  xmm2,DWORD PTR [rip+0xdfc]        # 2004 <_IO_stdin_used+0x4>
    1208:	movss  xmm1,DWORD PTR [rip+0xdf8]        # 2008 <_IO_stdin_used+0x8>
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
    1270:	xor    r12d,r12d
    1273:	xor    ebx,ebx
    1275:	movdqa xmm0,XMMWORD PTR [rip+0xe53]        # 20d0 <_IO_stdin_used+0xd0>
    127d:	lea    rbp,[rsp+0x104]
    1285:	mov    QWORD PTR [rsp+0x8],rax
    128a:	lea    rax,[rsp+0x130]
    1292:	mov    QWORD PTR [rsp+0x140],0x1
    129e:	mov    QWORD PTR [rsp+0x38],rax
    12a3:	mov    rax,rbp
    12a6:	mov    rbp,r12
    12a9:	movaps XMMWORD PTR [rsp+0x130],xmm0
    12b1:	mov    r12,rax
    12b4:	mov    rdi,QWORD PTR [rsp+0x8]
    12b9:	mov    rax,rbx
    12bc:	mov    ecx,0x11
    12c1:	test   ebp,ebp
    12c3:	rep stos QWORD PTR es:[rdi],rax
    12c6:	mov    rax,QWORD PTR [rsp+0x38]
    12cb:	mov    DWORD PTR [rsp+0x74],0x88
    12d3:	mov    QWORD PTR [rsp+0x90],0x8
    12df:	mov    rax,QWORD PTR [rax+rbp*8]
    12e3:	mov    QWORD PTR [rsp+0x78],rax
    12e8:	sete   al
    12eb:	xor    r9d,r9d
    12ee:	or     eax,0x40
    12f1:	mov    BYTE PTR [rsp+0x98],al
    12f8:	test   rbp,rbp
    12fb:	je     132e <main+0x1ce>
    12fd:	mov    rsi,QWORD PTR [rsp+0x8]
    1302:	mov    ecx,0xffffffff
    1307:	xor    edx,edx
    1309:	xor    eax,eax
    130b:	mov    r8d,DWORD PTR [rsp+0x104]
    1313:	mov    edi,0x12a
    1318:	call   1120 <syscall@plt>
    131d:	mov    DWORD PTR [r12+rbp*4],eax
    1321:	cmp    rbp,0x2
    1325:	je     135d <main+0x1fd>
    1327:	mov    ebp,0x2
    132c:	jmp    12b4 <main+0x154>
    132e:	mov    rsi,QWORD PTR [rsp+0x8]
    1333:	mov    r8d,0xffffffff
    1339:	xor    edx,edx
    133b:	xor    eax,eax
    133d:	mov    ecx,0xffffffff
    1342:	mov    edi,0x12a
    1347:	mov    ebp,0x1
    134c:	call   1120 <syscall@plt>
    1351:	mov    DWORD PTR [rsp+0x104],eax
    1358:	jmp    12b4 <main+0x154>
    135d:	lea    rsi,[rip+0xccc]        # 2030 <_IO_stdin_used+0x30>
    1364:	xor    eax,eax
    1366:	xor    r12d,r12d
    1369:	mov    rbp,r15
    136c:	mov    edi,0x2
    1371:	lea    rbx,[rip+0xc98]        # 2010 <_IO_stdin_used+0x10>
    1378:	call   1140 <__printf_chk@plt>
    137d:	lea    rax,[rip+0xc92]        # 2016 <_IO_stdin_used+0x16>
    1384:	movq   xmm0,rbx
    1389:	mov    rbx,r14
    138c:	movq   xmm3,rax
    1391:	lea    rax,[rip+0xc8d]        # 2025 <_IO_stdin_used+0x25>
    1398:	mov    DWORD PTR [rsp+0x6c],0x0
    13a0:	mov    QWORD PTR [rsp+0x120],rax
    13a8:	mov    rax,r13
    13ab:	punpcklqdq xmm0,xmm3
    13af:	shl    rax,0xb
    13b3:	movaps XMMWORD PTR [rsp+0x110],xmm0
    13bb:	mov    QWORD PTR [rsp+0x58],rax
    13c0:	cmp    QWORD PTR [rsp+0x30],0x0
    13c6:	js     15c6 <main+0x466>
    13cc:	mov    r14d,DWORD PTR [rsp+0x104]
    13d4:	mov    r15,0xffffffffffffffff
    13db:	nop    DWORD PTR [rax+rax*1+0x0]
    13e0:	mov    edx,0x1
    13e5:	mov    esi,0x2403
    13ea:	mov    edi,r14d
    13ed:	xor    eax,eax
    13ef:	call   1100 <ioctl@plt>
    13f4:	mov    edx,0x1
    13f9:	mov    edi,r14d
    13fc:	xor    eax,eax
    13fe:	mov    esi,0x2400
    1403:	call   1100 <ioctl@plt>
    1408:	mov    rsi,QWORD PTR [rsp+0x8]
    140d:	mov    edi,0x4
    1412:	call   10e0 <clock_gettime@plt>
    1417:	mov    rax,QWORD PTR [rsp+0x70]
    141c:	mov    QWORD PTR [rsp+0x10],rax
    1421:	mov    rax,QWORD PTR [rsp+0x78]
    1426:	mov    QWORD PTR [rsp+0x18],rax
    142b:	test   r13,r13
    142e:	jle    148f <main+0x32f>
    1430:	xor    ecx,ecx
    1432:	jmp    144c <main+0x2ec>
    1434:	nop    DWORD PTR [rax+0x0]
    1438:	mov    rsi,rbx
    143b:	mov    rdi,rbp
    143e:	call   1790 <relu>
    1443:	add    rcx,0x1
    1447:	cmp    rcx,r13
    144a:	je     1487 <main+0x327>
    144c:	mov    edx,0x800
    1451:	test   r12,r12
    1454:	je     1608 <main+0x4a8>
    145a:	cmp    r12,0x1
    145e:	jne    1438 <main+0x2d8>
    1460:	mov    rsi,rbp
    1463:	mov    rdi,rbx
    1466:	call   1750 <dot>
    146b:	movaps xmm1,xmm0
    146e:	movss  xmm0,DWORD PTR [rsp+0x6c]
    1474:	addss  xmm0,xmm1
    1478:	movss  DWORD PTR [rsp+0x6c],xmm0
    147e:	add    rcx,0x1
    1482:	cmp    rcx,r13
    1485:	jne    144c <main+0x2ec>
    1487:	mov    r14d,DWORD PTR [rsp+0x104]
    148f:	mov    rsi,QWORD PTR [rsp+0x8]
    1494:	mov    edi,0x4
    1499:	call   10e0 <clock_gettime@plt>
    149e:	mov    rax,QWORD PTR [rsp+0x70]
    14a3:	mov    edx,0x1
    14a8:	mov    edi,r14d
    14ab:	mov    esi,0x2401
    14b0:	mov    QWORD PTR [rsp+0x20],rax
    14b5:	mov    rax,QWORD PTR [rsp+0x78]
    14ba:	mov    QWORD PTR [rsp+0x28],rax
    14bf:	xor    eax,eax
    14c1:	call   1100 <ioctl@plt>
    14c6:	mov    rsi,QWORD PTR [rsp+0x38]
    14cb:	pxor   xmm0,xmm0
    14cf:	mov    edi,r14d
    14d2:	mov    edx,0x20
    14d7:	movaps XMMWORD PTR [rsp+0x130],xmm0
    14df:	movaps XMMWORD PTR [rsp+0x140],xmm0
    14e7:	call   1110 <read@plt>
    14ec:	cmp    rax,0x20
    14f0:	jne    1519 <main+0x3b9>
    14f2:	mov    rax,QWORD PTR [rsp+0x138]
    14fa:	mov    QWORD PTR [rsp+0x40],rax
    14ff:	mov    rax,QWORD PTR [rsp+0x140]
    1507:	mov    QWORD PTR [rsp+0x48],rax
    150c:	mov    rax,QWORD PTR [rsp+0x148]
    1514:	mov    QWORD PTR [rsp+0x50],rax
    1519:	cmp    r15,0xffffffffffffffff
    151d:	je     15b4 <main+0x454>
    1523:	pxor   xmm0,xmm0
    1527:	pxor   xmm1,xmm1
    152b:	pxor   xmm2,xmm2
    152f:	mov    rcx,QWORD PTR [rsp+r12*8+0x110]
    1537:	cvtsi2sd xmm0,QWORD PTR [rsp+0x20]
    153e:	mulsd  xmm0,QWORD PTR [rip+0xb9a]        # 20e0 <_IO_stdin_used+0xe0>
    1546:	mov    r9d,0x800
    154c:	mov    r8d,0x4000
    1552:	cvtsi2sd xmm1,QWORD PTR [rsp+0x28]
    1559:	lea    rdx,[rip+0xaca]        # 202a <_IO_stdin_used+0x2a>
    1560:	mov    edi,0x2
    1565:	mov    eax,0x1
    156a:	cvtsi2sd xmm2,QWORD PTR [rsp+0x18]
    1571:	lea    rsi,[rip+0xb18]        # 2090 <_IO_stdin_used+0x90>
    1578:	addsd  xmm0,xmm1
    157c:	pxor   xmm1,xmm1
    1580:	cvtsi2sd xmm1,QWORD PTR [rsp+0x10]
    1587:	mulsd  xmm1,QWORD PTR [rip+0xb51]        # 20e0 <_IO_stdin_used+0xe0>
    158f:	push   QWORD PTR [rsp+0x58]
    1593:	push   QWORD PTR [rsp+0x58]
    1597:	push   QWORD PTR [rsp+0x58]
    159b:	push   QWORD PTR [rsp+0x58]
    159f:	push   r13
    15a1:	addsd  xmm1,xmm2
    15a5:	push   r15
    15a7:	subsd  xmm0,xmm1
    15ab:	call   1140 <__printf_chk@plt>
    15b0:	add    rsp,0x30
    15b4:	mov    rax,QWORD PTR [rsp+0x30]
    15b9:	add    r15,0x1
    15bd:	cmp    r15,rax
    15c0:	jne    13e0 <main+0x280>
    15c6:	add    r12,0x1
    15ca:	cmp    r12,0x3
    15ce:	jne    13c0 <main+0x260>
    15d4:	movss  xmm0,DWORD PTR [rsp+0x6c]
    15da:	mov    rax,QWORD PTR [rsp+0x158]
    15e2:	sub    rax,QWORD PTR fs:0x28
    15eb:	jne    1620 <main+0x4c0>
    15ed:	add    rsp,0x168
    15f4:	xor    eax,eax
    15f6:	pop    rbx
    15f7:	pop    rbp
    15f8:	pop    r12
    15fa:	pop    r13
    15fc:	pop    r14
    15fe:	pop    r15
    1600:	ret
    1601:	nop    DWORD PTR [rax+0x0]
    1608:	movss  xmm0,DWORD PTR [rip+0x9fc]        # 200c <_IO_stdin_used+0xc>
    1610:	mov    rsi,rbx
    1613:	mov    rdi,rbp
    1616:	call   1720 <saxpy>
    161b:	jmp    1443 <main+0x2e3>
    1620:	call   10f0 <__stack_chk_fail@plt>
    1625:	cs nop WORD PTR [rax+rax*1+0x0]
    162f:	nop

0000000000001630 <_start>:
    1630:	endbr64
    1634:	xor    ebp,ebp
    1636:	mov    r9,rdx
    1639:	pop    rsi
    163a:	mov    rdx,rsp
    163d:	and    rsp,0xfffffffffffffff0
    1641:	push   rax
    1642:	push   rsp
    1643:	xor    r8d,r8d
    1646:	xor    ecx,ecx
    1648:	lea    rdi,[rip+0xfffffffffffffb11]        # 1160 <main>
    164f:	call   QWORD PTR [rip+0x2983]        # 3fd8 <__libc_start_main@GLIBC_2.34>
    1655:	hlt
    1656:	cs nop WORD PTR [rax+rax*1+0x0]

0000000000001660 <deregister_tm_clones>:
    1660:	lea    rdi,[rip+0x29a9]        # 4010 <__TMC_END__>
    1667:	lea    rax,[rip+0x29a2]        # 4010 <__TMC_END__>
    166e:	cmp    rax,rdi
    1671:	je     1688 <deregister_tm_clones+0x28>
    1673:	mov    rax,QWORD PTR [rip+0x2966]        # 3fe0 <_ITM_deregisterTMCloneTable@Base>
    167a:	test   rax,rax
    167d:	je     1688 <deregister_tm_clones+0x28>
    167f:	jmp    rax
    1681:	nop    DWORD PTR [rax+0x0]
    1688:	ret
    1689:	nop    DWORD PTR [rax+0x0]

0000000000001690 <register_tm_clones>:
    1690:	lea    rdi,[rip+0x2979]        # 4010 <__TMC_END__>
    1697:	lea    rsi,[rip+0x2972]        # 4010 <__TMC_END__>
    169e:	sub    rsi,rdi
    16a1:	mov    rax,rsi
    16a4:	shr    rsi,0x3f
    16a8:	sar    rax,0x3
    16ac:	add    rsi,rax
    16af:	sar    rsi,1
    16b2:	je     16c8 <register_tm_clones+0x38>
    16b4:	mov    rax,QWORD PTR [rip+0x2935]        # 3ff0 <_ITM_registerTMCloneTable@Base>
    16bb:	test   rax,rax
    16be:	je     16c8 <register_tm_clones+0x38>
    16c0:	jmp    rax
    16c2:	nop    WORD PTR [rax+rax*1+0x0]
    16c8:	ret
    16c9:	nop    DWORD PTR [rax+0x0]

00000000000016d0 <__do_global_dtors_aux>:
    16d0:	endbr64
    16d4:	cmp    BYTE PTR [rip+0x2935],0x0        # 4010 <__TMC_END__>
    16db:	jne    1708 <__do_global_dtors_aux+0x38>
    16dd:	push   rbp
    16de:	cmp    QWORD PTR [rip+0x2912],0x0        # 3ff8 <__cxa_finalize@GLIBC_2.2.5>
    16e6:	mov    rbp,rsp
    16e9:	je     16f7 <__do_global_dtors_aux+0x27>
    16eb:	mov    rdi,QWORD PTR [rip+0x2916]        # 4008 <__dso_handle>
    16f2:	call   10c0 <__cxa_finalize@plt>
    16f7:	call   1660 <deregister_tm_clones>
    16fc:	mov    BYTE PTR [rip+0x290d],0x1        # 4010 <__TMC_END__>
    1703:	pop    rbp
    1704:	ret
    1705:	nop    DWORD PTR [rax]
    1708:	ret
    1709:	nop    DWORD PTR [rax+0x0]

0000000000001710 <frame_dummy>:
    1710:	endbr64
    1714:	jmp    1690 <register_tm_clones>
    1719:	nop    DWORD PTR [rax+0x0]

0000000000001720 <saxpy>:
    1720:	endbr64
    1724:	test   rdx,rdx
    1727:	jle    174c <saxpy+0x2c>
    1729:	xor    eax,eax
    172b:	nop    DWORD PTR [rax+rax*1+0x0]
    1730:	movss  xmm1,DWORD PTR [rsi+rax*4]
    1735:	mulss  xmm1,xmm0
    1739:	addss  xmm1,DWORD PTR [rdi+rax*4]
    173e:	movss  DWORD PTR [rdi+rax*4],xmm1
    1743:	add    rax,0x1
    1747:	cmp    rdx,rax
    174a:	jne    1730 <saxpy+0x10>
    174c:	ret
    174d:	nop    DWORD PTR [rax]

0000000000001750 <dot>:
    1750:	endbr64
    1754:	test   rdx,rdx
    1757:	jle    1780 <dot+0x30>
    1759:	xor    eax,eax
    175b:	pxor   xmm1,xmm1
    175f:	nop
    1760:	movss  xmm0,DWORD PTR [rdi+rax*4]
    1765:	mulss  xmm0,DWORD PTR [rsi+rax*4]
    176a:	add    rax,0x1
    176e:	addss  xmm1,xmm0
    1772:	cmp    rdx,rax
    1775:	jne    1760 <dot+0x10>
    1777:	movaps xmm0,xmm1
    177a:	ret
    177b:	nop    DWORD PTR [rax+rax*1+0x0]
    1780:	pxor   xmm1,xmm1
    1784:	movaps xmm0,xmm1
    1787:	ret
    1788:	nop    DWORD PTR [rax+rax*1+0x0]

0000000000001790 <relu>:
    1790:	endbr64
    1794:	test   rdx,rdx
    1797:	jle    17bc <relu+0x2c>
    1799:	xor    eax,eax
    179b:	pxor   xmm1,xmm1
    179f:	nop
    17a0:	movss  xmm0,DWORD PTR [rsi+rax*4]
    17a5:	comiss xmm0,xmm1
    17a8:	ja     17ae <relu+0x1e>
    17aa:	pxor   xmm0,xmm0
    17ae:	movss  DWORD PTR [rdi+rax*4],xmm0
    17b3:	add    rax,0x1
    17b7:	cmp    rdx,rax
    17ba:	jne    17a0 <relu+0x10>
    17bc:	ret

Disassembly of section .fini:

00000000000017c0 <_fini>:
    17c0:	endbr64
    17c4:	sub    rsp,0x8
    17c8:	add    rsp,0x8
    17cc:	ret
