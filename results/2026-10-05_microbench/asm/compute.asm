
bin/compute:     file format elf64-x86-64


Disassembly of section .init:

0000000000001000 <_init>:
    1000:	endbr64
    1004:	sub    rsp,0x8
    1008:	mov    rax,QWORD PTR [rip+0xafe1]        # bff0 <__gmon_start__@Base>
    100f:	test   rax,rax
    1012:	je     1016 <_init+0x16>
    1014:	call   rax
    1016:	add    rsp,0x8
    101a:	ret

Disassembly of section .plt:

0000000000001020 <.plt>:
    1020:	push   QWORD PTR [rip+0xaf1a]        # bf40 <_GLOBAL_OFFSET_TABLE_+0x8>
    1026:	jmp    QWORD PTR [rip+0xaf1c]        # bf48 <_GLOBAL_OFFSET_TABLE_+0x10>
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
    10c0:	endbr64
    10c4:	push   0x9
    10c9:	jmp    1020 <_init+0x20>
    10ce:	xchg   ax,ax
    10d0:	endbr64
    10d4:	push   0xa
    10d9:	jmp    1020 <_init+0x20>
    10de:	xchg   ax,ax
    10e0:	endbr64
    10e4:	push   0xb
    10e9:	jmp    1020 <_init+0x20>
    10ee:	xchg   ax,ax
    10f0:	endbr64
    10f4:	push   0xc
    10f9:	jmp    1020 <_init+0x20>
    10fe:	xchg   ax,ax
    1100:	endbr64
    1104:	push   0xd
    1109:	jmp    1020 <_init+0x20>
    110e:	xchg   ax,ax
    1110:	endbr64
    1114:	push   0xe
    1119:	jmp    1020 <_init+0x20>
    111e:	xchg   ax,ax
    1120:	endbr64
    1124:	push   0xf
    1129:	jmp    1020 <_init+0x20>
    112e:	xchg   ax,ax
    1130:	endbr64
    1134:	push   0x10
    1139:	jmp    1020 <_init+0x20>
    113e:	xchg   ax,ax

Disassembly of section .plt.got:

0000000000001140 <__cxa_finalize@plt>:
    1140:	endbr64
    1144:	jmp    QWORD PTR [rip+0xae8e]        # bfd8 <__cxa_finalize@GLIBC_2.2.5>
    114a:	nop    WORD PTR [rax+rax*1+0x0]

Disassembly of section .plt.sec:

0000000000001150 <__printf_chk@plt>:
    1150:	endbr64
    1154:	jmp    QWORD PTR [rip+0xadf6]        # bf50 <__printf_chk@GLIBC_2.3.4>
    115a:	nop    WORD PTR [rax+rax*1+0x0]

0000000000001160 <syscall@plt>:
    1160:	endbr64
    1164:	jmp    QWORD PTR [rip+0xadee]        # bf58 <syscall@GLIBC_2.2.5>
    116a:	nop    WORD PTR [rax+rax*1+0x0]

0000000000001170 <strlen@plt>:
    1170:	endbr64
    1174:	jmp    QWORD PTR [rip+0xade6]        # bf60 <strlen@GLIBC_2.2.5>
    117a:	nop    WORD PTR [rax+rax*1+0x0]

0000000000001180 <std::__throw_logic_error(char const*)@plt>:
    1180:	endbr64
    1184:	jmp    QWORD PTR [rip+0xadde]        # bf68 <std::__throw_logic_error(char const*)@GLIBCXX_3.4>
    118a:	nop    WORD PTR [rax+rax*1+0x0]

0000000000001190 <memcpy@plt>:
    1190:	endbr64
    1194:	jmp    QWORD PTR [rip+0xadd6]        # bf70 <memcpy@GLIBC_2.14>
    119a:	nop    WORD PTR [rax+rax*1+0x0]

00000000000011a0 <clock_gettime@plt>:
    11a0:	endbr64
    11a4:	jmp    QWORD PTR [rip+0xadce]        # bf78 <clock_gettime@GLIBC_2.17>
    11aa:	nop    WORD PTR [rax+rax*1+0x0]

00000000000011b0 <operator delete(void*, unsigned long)@plt>:
    11b0:	endbr64
    11b4:	jmp    QWORD PTR [rip+0xadc6]        # bf80 <operator delete(void*, unsigned long)@CXXABI_1.3.9>
    11ba:	nop    WORD PTR [rax+rax*1+0x0]

00000000000011c0 <__stack_chk_fail@plt>:
    11c0:	endbr64
    11c4:	jmp    QWORD PTR [rip+0xadbe]        # bf88 <__stack_chk_fail@GLIBC_2.4>
    11ca:	nop    WORD PTR [rax+rax*1+0x0]

00000000000011d0 <fflush@plt>:
    11d0:	endbr64
    11d4:	jmp    QWORD PTR [rip+0xadb6]        # bf90 <fflush@GLIBC_2.2.5>
    11da:	nop    WORD PTR [rax+rax*1+0x0]

00000000000011e0 <getenv@plt>:
    11e0:	endbr64
    11e4:	jmp    QWORD PTR [rip+0xadae]        # bf98 <getenv@GLIBC_2.2.5>
    11ea:	nop    WORD PTR [rax+rax*1+0x0]

00000000000011f0 <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >::_M_dispose()@plt>:
    11f0:	endbr64
    11f4:	jmp    QWORD PTR [rip+0xada6]        # bfa0 <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >::_M_dispose()@GLIBCXX_3.4.21>
    11fa:	nop    WORD PTR [rax+rax*1+0x0]

0000000000001200 <ioctl@plt>:
    1200:	endbr64
    1204:	jmp    QWORD PTR [rip+0xad9e]        # bfa8 <ioctl@GLIBC_2.2.5>
    120a:	nop    WORD PTR [rax+rax*1+0x0]

0000000000001210 <read@plt>:
    1210:	endbr64
    1214:	jmp    QWORD PTR [rip+0xad96]        # bfb0 <read@GLIBC_2.2.5>
    121a:	nop    WORD PTR [rax+rax*1+0x0]

0000000000001220 <__fprintf_chk@plt>:
    1220:	endbr64
    1224:	jmp    QWORD PTR [rip+0xad8e]        # bfb8 <__fprintf_chk@GLIBC_2.3.4>
    122a:	nop    WORD PTR [rax+rax*1+0x0]

0000000000001230 <_Unwind_Resume@plt>:
    1230:	endbr64
    1234:	jmp    QWORD PTR [rip+0xad86]        # bfc0 <_Unwind_Resume@GCC_3.0>
    123a:	nop    WORD PTR [rax+rax*1+0x0]

0000000000001240 <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >::_M_create(unsigned long&, unsigned long)@plt>:
    1240:	endbr64
    1244:	jmp    QWORD PTR [rip+0xad7e]        # bfc8 <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >::_M_create(unsigned long&, unsigned long)@GLIBCXX_3.4.21>
    124a:	nop    WORD PTR [rax+rax*1+0x0]

0000000000001250 <__isoc23_strtol@plt>:
    1250:	endbr64
    1254:	jmp    QWORD PTR [rip+0xad76]        # bfd0 <__isoc23_strtol@GLIBC_2.38>
    125a:	nop    WORD PTR [rax+rax*1+0x0]

Disassembly of section .text:

0000000000001260 <main.cold>:
    1260:	mov    rdi,QWORD PTR [rbp-0x510]
    1267:	vzeroupper
    126a:	call   11f0 <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >::_M_dispose()@plt>
    126f:	mov    rax,QWORD PTR [rbp-0x38]
    1273:	sub    rax,QWORD PTR fs:0x28
    127c:	jne    1286 <main.cold+0x26>
    127e:	mov    rdi,rbx
    1281:	call   1230 <_Unwind_Resume@plt>
    1286:	call   11c0 <__stack_chk_fail@plt>
    128b:	nop    DWORD PTR [rax+rax*1+0x0]

0000000000001290 <main>:
    1290:	endbr64
    1294:	lea    r10,[rsp+0x8]
    1299:	and    rsp,0xffffffffffffffe0
    129d:	lea    rdx,[rip+0x7b6c]        # 8e10 <void fp32_avx512_fma<4>(unsigned long)>
    12a4:	push   QWORD PTR [r10-0x8]
    12a8:	vmovq  xmm0,rdx
    12ad:	lea    rdx,[rip+0x7a2c]        # 8ce0 <void fp32_avx512_fma<1>(unsigned long)>
    12b4:	lea    rdi,[rip+0x8e4c]        # a107 <_IO_stdin_used+0x107>
    12bb:	vmovq  xmm1,rdx
    12c0:	lea    rdx,[rip+0x82e9]        # 95b0 <void fp32_avx512_fma<12>(unsigned long)>
    12c7:	push   rbp
    12c8:	mov    rbp,rsp
    12cb:	push   r15
    12cd:	push   r14
    12cf:	push   r13
    12d1:	push   r12
    12d3:	push   r10
    12d5:	push   rbx
    12d6:	sub    rsp,0x5e0
    12dd:	mov    rax,QWORD PTR fs:0x28
    12e6:	mov    QWORD PTR [rbp-0x38],rax
    12ea:	lea    rax,[rip+0x7c4f]        # 8f40 <void fp32_avx512_fma<6>(unsigned long)>
    12f1:	vpinsrq xmm0,xmm0,rax,0x1
    12f7:	lea    rax,[rip+0x7a62]        # 8d60 <void fp32_avx512_fma<2>(unsigned long)>
    12fe:	vpinsrq xmm1,xmm1,rax,0x1
    1304:	lea    rax,[rip+0x85b5]        # 98c0 <void fp32_avx512_fma<16>(unsigned long)>
    130b:	vinserti128 ymm2,ymm1,xmm0,0x1
    1311:	vmovq  xmm0,rdx
    1316:	lea    rdx,[rip+0x7dd3]        # 90f0 <void fp32_avx512_fma<8>(unsigned long)>
    131d:	vpinsrq xmm0,xmm0,rax,0x1
    1323:	vmovq  xmm1,rdx
    1328:	lea    rax,[rip+0x7fe1]        # 9310 <void fp32_avx512_fma<10>(unsigned long)>
    132f:	vmovdqa YMMWORD PTR [rbp-0x610],ymm2
    1337:	vpinsrq xmm1,xmm1,rax,0x1
    133d:	lea    rdx,[rip+0x6aec]        # 7e30 <void fp32_avx512_mul<4>(unsigned long)>
    1344:	lea    rax,[rip+0x6c15]        # 7f60 <void fp32_avx512_mul<6>(unsigned long)>
    134b:	vinserti128 ymm3,ymm1,xmm0,0x1
    1351:	vmovq  xmm0,rdx
    1356:	lea    rdx,[rip+0x69a3]        # 7d00 <void fp32_avx512_mul<1>(unsigned long)>
    135d:	vpinsrq xmm0,xmm0,rax,0x1
    1363:	vmovq  xmm1,rdx
    1368:	lea    rax,[rip+0x6a11]        # 7d80 <void fp32_avx512_mul<2>(unsigned long)>
    136f:	vmovdqa YMMWORD PTR [rbp-0x5f0],ymm3
    1377:	vpinsrq xmm1,xmm1,rax,0x1
    137d:	lea    rdx,[rip+0x724c]        # 85d0 <void fp32_avx512_mul<12>(unsigned long)>
    1384:	lea    rax,[rip+0x7555]        # 88e0 <void fp32_avx512_mul<16>(unsigned long)>
    138b:	vinserti128 ymm4,ymm1,xmm0,0x1
    1391:	vmovq  xmm0,rdx
    1396:	lea    rdx,[rip+0x6d73]        # 8110 <void fp32_avx512_mul<8>(unsigned long)>
    139d:	vpinsrq xmm0,xmm0,rax,0x1
    13a3:	vmovq  xmm1,rdx
    13a8:	lea    rax,[rip+0x6f81]        # 8330 <void fp32_avx512_mul<10>(unsigned long)>
    13af:	vmovdqa YMMWORD PTR [rbp-0x5d0],ymm4
    13b7:	vpinsrq xmm1,xmm1,rax,0x1
    13bd:	lea    rdx,[rip+0x5a8c]        # 6e50 <void fp32_avx512_add<4>(unsigned long)>
    13c4:	lea    rax,[rip+0x5bb5]        # 6f80 <void fp32_avx512_add<6>(unsigned long)>
    13cb:	vinserti128 ymm5,ymm1,xmm0,0x1
    13d1:	vmovq  xmm0,rdx
    13d6:	lea    rdx,[rip+0x5943]        # 6d20 <void fp32_avx512_add<1>(unsigned long)>
    13dd:	vpinsrq xmm0,xmm0,rax,0x1
    13e3:	vmovq  xmm1,rdx
    13e8:	lea    rax,[rip+0x59b1]        # 6da0 <void fp32_avx512_add<2>(unsigned long)>
    13ef:	vmovdqa YMMWORD PTR [rbp-0x5b0],ymm5
    13f7:	vpinsrq xmm1,xmm1,rax,0x1
    13fd:	lea    rdx,[rip+0x61ec]        # 75f0 <void fp32_avx512_add<12>(unsigned long)>
    1404:	lea    rax,[rip+0x64f5]        # 7900 <void fp32_avx512_add<16>(unsigned long)>
    140b:	vinserti128 ymm6,ymm1,xmm0,0x1
    1411:	vmovq  xmm0,rdx
    1416:	lea    rdx,[rip+0x5d13]        # 7130 <void fp32_avx512_add<8>(unsigned long)>
    141d:	vpinsrq xmm0,xmm0,rax,0x1
    1423:	vmovq  xmm1,rdx
    1428:	lea    rax,[rip+0x5f21]        # 7350 <void fp32_avx512_add<10>(unsigned long)>
    142f:	vmovdqa YMMWORD PTR [rbp-0x590],ymm6
    1437:	vpinsrq xmm1,xmm1,rax,0x1
    143d:	lea    rdx,[rip+0x4c6c]        # 60b0 <void fp32_avx2_fma<4>(unsigned long)>
    1444:	lea    rax,[rip+0x4d75]        # 61c0 <void fp32_avx2_fma<6>(unsigned long)>
    144b:	vinserti128 ymm7,ymm1,xmm0,0x1
    1451:	vmovq  xmm0,rdx
    1456:	lea    rdx,[rip+0x4b43]        # 5fa0 <void fp32_avx2_fma<1>(unsigned long)>
    145d:	vpinsrq xmm0,xmm0,rax,0x1
    1463:	vmovq  xmm1,rdx
    1468:	lea    rax,[rip+0x4ba1]        # 6010 <void fp32_avx2_fma<2>(unsigned long)>
    146f:	vmovdqa YMMWORD PTR [rbp-0x570],ymm7
    1477:	vpinsrq xmm1,xmm1,rax,0x1
    147d:	lea    rdx,[rip+0x52ac]        # 6730 <void fp32_avx2_fma<12>(unsigned long)>
    1484:	lea    rax,[rip+0x5535]        # 69c0 <void fp32_avx2_fma<16>(unsigned long)>
    148b:	vinserti128 ymm2,ymm1,xmm0,0x1
    1491:	vmovq  xmm0,rdx
    1496:	lea    rdx,[rip+0x4e93]        # 6330 <void fp32_avx2_fma<8>(unsigned long)>
    149d:	vpinsrq xmm0,xmm0,rax,0x1
    14a3:	vmovq  xmm1,rdx
    14a8:	lea    rax,[rip+0x5051]        # 6500 <void fp32_avx2_fma<10>(unsigned long)>
    14af:	vmovdqa YMMWORD PTR [rbp-0x550],ymm2
    14b7:	vpinsrq xmm1,xmm1,rax,0x1
    14bd:	lea    rdx,[rip+0x3ecc]        # 5390 <void fp32_sse_fma<4>(unsigned long)>
    14c4:	lea    rax,[rip+0x3fc5]        # 5490 <void fp32_sse_fma<6>(unsigned long)>
    14cb:	vinserti128 ymm3,ymm1,xmm0,0x1
    14d1:	vmovq  xmm0,rdx
    14d6:	lea    rdx,[rip+0x3db3]        # 5290 <void fp32_sse_fma<1>(unsigned long)>
    14dd:	vpinsrq xmm0,xmm0,rax,0x1
    14e3:	vmovq  xmm1,rdx
    14e8:	lea    rax,[rip+0x3e11]        # 5300 <void fp32_sse_fma<2>(unsigned long)>
    14ef:	vmovdqa YMMWORD PTR [rbp-0x530],ymm3
    14f7:	vpinsrq xmm1,xmm1,rax,0x1
    14fd:	lea    rdx,[rip+0x44cc]        # 59d0 <void fp32_sse_fma<12>(unsigned long)>
    1504:	lea    rax,[rip+0x4745]        # 5c50 <void fp32_sse_fma<16>(unsigned long)>
    150b:	vinserti128 ymm4,ymm1,xmm0,0x1
    1511:	vmovq  xmm0,rdx
    1516:	lea    rdx,[rip+0x40d3]        # 55f0 <void fp32_sse_fma<8>(unsigned long)>
    151d:	vpinsrq xmm0,xmm0,rax,0x1
    1523:	vmovq  xmm1,rdx
    1528:	lea    rax,[rip+0x4281]        # 57b0 <void fp32_sse_fma<10>(unsigned long)>
    152f:	vmovdqa YMMWORD PTR [rbp-0x510],ymm4
    1537:	vpinsrq xmm1,xmm1,rax,0x1
    153d:	lea    rdx,[rip+0x313c]        # 4680 <void fp32_scalar_fma<4>(unsigned long)>
    1544:	lea    rax,[rip+0x3235]        # 4780 <void fp32_scalar_fma<6>(unsigned long)>
    154b:	vinserti128 ymm5,ymm1,xmm0,0x1
    1551:	vmovq  xmm0,rdx
    1556:	lea    rdx,[rip+0x3033]        # 4590 <void fp32_scalar_fma<1>(unsigned long)>
    155d:	vpinsrq xmm0,xmm0,rax,0x1
    1563:	vmovq  xmm1,rdx
    1568:	lea    rax,[rip+0x3081]        # 45f0 <void fp32_scalar_fma<2>(unsigned long)>
    156f:	vmovdqa YMMWORD PTR [rbp-0x4f0],ymm5
    1577:	vpinsrq xmm1,xmm1,rax,0x1
    157d:	lea    rdx,[rip+0x373c]        # 4cc0 <void fp32_scalar_fma<12>(unsigned long)>
    1584:	lea    rax,[rip+0x39b5]        # 4f40 <void fp32_scalar_fma<16>(unsigned long)>
    158b:	vinserti128 ymm6,ymm1,xmm0,0x1
    1591:	vmovq  xmm0,rdx
    1596:	lea    rdx,[rip+0x3343]        # 48e0 <void fp32_scalar_fma<8>(unsigned long)>
    159d:	vpinsrq xmm0,xmm0,rax,0x1
    15a3:	vmovq  xmm1,rdx
    15a8:	lea    rax,[rip+0x34f1]        # 4aa0 <void fp32_scalar_fma<10>(unsigned long)>
    15af:	vmovdqa YMMWORD PTR [rbp-0x4d0],ymm6
    15b7:	vpinsrq xmm1,xmm1,rax,0x1
    15bd:	lea    rdx,[rip+0x256c]        # 3b30 <void fp32_scalar_mul<4>(unsigned long)>
    15c4:	lea    rax,[rip+0x2645]        # 3c10 <void fp32_scalar_mul<6>(unsigned long)>
    15cb:	vinserti128 ymm7,ymm1,xmm0,0x1
    15d1:	vmovq  xmm0,rdx
    15d6:	lea    rdx,[rip+0x2473]        # 3a50 <void fp32_scalar_mul<1>(unsigned long)>
    15dd:	vpinsrq xmm0,xmm0,rax,0x1
    15e3:	vmovq  xmm1,rdx
    15e8:	lea    rax,[rip+0x24c1]        # 3ab0 <void fp32_scalar_mul<2>(unsigned long)>
    15ef:	vmovdqa YMMWORD PTR [rbp-0x490],ymm7
    15f7:	vpinsrq xmm1,xmm1,rax,0x1
    15fd:	lea    rdx,[rip+0x2a8c]        # 4090 <void fp32_scalar_mul<12>(unsigned long)>
    1604:	lea    rax,[rip+0x2ca5]        # 42b0 <void fp32_scalar_mul<16>(unsigned long)>
    160b:	vinserti128 ymm2,ymm1,xmm0,0x1
    1611:	vmovq  xmm0,rdx
    1616:	lea    rdx,[rip+0x2723]        # 3d40 <void fp32_scalar_mul<8>(unsigned long)>
    161d:	vpinsrq xmm0,xmm0,rax,0x1
    1623:	vmovq  xmm1,rdx
    1628:	lea    rax,[rip+0x2891]        # 3ec0 <void fp32_scalar_mul<10>(unsigned long)>
    162f:	vmovdqa YMMWORD PTR [rbp-0x470],ymm2
    1637:	vpinsrq xmm1,xmm1,rax,0x1
    163d:	lea    rdx,[rip+0x19ac]        # 2ff0 <void fp32_scalar_add<4>(unsigned long)>
    1644:	lea    rax,[rip+0x1a85]        # 30d0 <void fp32_scalar_add<6>(unsigned long)>
    164b:	vinserti128 ymm3,ymm1,xmm0,0x1
    1651:	vmovq  xmm0,rdx
    1656:	lea    rdx,[rip+0x18b3]        # 2f10 <void fp32_scalar_add<1>(unsigned long)>
    165d:	vpinsrq xmm0,xmm0,rax,0x1
    1663:	vmovq  xmm1,rdx
    1668:	lea    rax,[rip+0x1901]        # 2f70 <void fp32_scalar_add<2>(unsigned long)>
    166f:	vmovdqa YMMWORD PTR [rbp-0x450],ymm3
    1677:	vpinsrq xmm1,xmm1,rax,0x1
    167d:	lea    rdx,[rip+0x1ecc]        # 3550 <void fp32_scalar_add<12>(unsigned long)>
    1684:	lea    rax,[rip+0x20e5]        # 3770 <void fp32_scalar_add<16>(unsigned long)>
    168b:	vinserti128 ymm4,ymm1,xmm0,0x1
    1691:	vmovq  xmm0,rdx
    1696:	lea    rdx,[rip+0x1b63]        # 3200 <void fp32_scalar_add<8>(unsigned long)>
    169d:	vpinsrq xmm0,xmm0,rax,0x1
    16a3:	vmovq  xmm1,rdx
    16a8:	lea    rax,[rip+0x1cd1]        # 3380 <void fp32_scalar_add<10>(unsigned long)>
    16af:	vmovdqa YMMWORD PTR [rbp-0x3d0],ymm4
    16b7:	vpinsrq xmm1,xmm1,rax,0x1
    16bd:	lea    rdx,[rip+0x10ac]        # 2770 <void int_imul<4>(unsigned long)>
    16c4:	lea    rax,[rip+0x1165]        # 2830 <void int_imul<6>(unsigned long)>
    16cb:	vinserti128 ymm5,ymm1,xmm0,0x1
    16d1:	vmovq  xmm0,rdx
    16d6:	lea    rdx,[rip+0xfd3]        # 26b0 <void int_imul<1>(unsigned long)>
    16dd:	vpinsrq xmm0,xmm0,rax,0x1
    16e3:	vmovq  xmm1,rdx
    16e8:	lea    rax,[rip+0x1011]        # 2700 <void int_imul<2>(unsigned long)>
    16ef:	vmovdqa YMMWORD PTR [rbp-0x410],ymm5
    16f7:	vpinsrq xmm1,xmm1,rax,0x1
    16fd:	lea    rdx,[rip+0x91c]        # 2020 <void int_add<4>(unsigned long)>
    1704:	lea    rax,[rip+0x9c5]        # 20d0 <void int_add<6>(unsigned long)>
    170b:	vinserti128 ymm6,ymm1,xmm0,0x1
    1711:	vmovq  xmm0,rdx
    1716:	lea    rdx,[rip+0x853]        # 1f70 <void int_add<1>(unsigned long)>
    171d:	vpinsrq xmm0,xmm0,rax,0x1
    1723:	vmovq  xmm1,rdx
    1728:	lea    rax,[rip+0x881]        # 1fb0 <void int_add<2>(unsigned long)>
    172f:	vmovdqa YMMWORD PTR [rbp-0x430],ymm6
    1737:	vpinsrq xmm1,xmm1,rax,0x1
    173d:	vinserti128 ymm7,ymm1,xmm0,0x1
    1743:	vmovdqa YMMWORD PTR [rbp-0x3f0],ymm7
    174b:	vzeroupper
    174e:	call   11e0 <getenv@plt>
    1753:	mov    rdi,rax
    1756:	mov    eax,0x7
    175b:	test   rdi,rdi
    175e:	je     176c <main+0x4dc>
    1760:	mov    edx,0xa
    1765:	xor    esi,esi
    1767:	call   1250 <__isoc23_strtol@plt>
    176c:	lea    rdi,[rip+0x8999]        # a10c <_IO_stdin_used+0x10c>
    1773:	mov    DWORD PTR [rbp-0x494],eax
    1779:	call   11e0 <getenv@plt>
    177e:	mov    QWORD PTR [rbp-0x4a0],0xbebc200
    1789:	test   rax,rax
    178c:	je     17a4 <main+0x514>
    178e:	mov    edx,0xa
    1793:	xor    esi,esi
    1795:	mov    rdi,rax
    1798:	call   1250 <__isoc23_strtol@plt>
    179d:	mov    QWORD PTR [rbp-0x4a0],rax
    17a4:	lea    rsi,[rip+0xa25]        # 21d0 <void int_add<8>(unsigned long)>
    17ab:	lea    rdx,[rip+0xb6e]        # 2320 <void int_add<10>(unsigned long)>
    17b2:	vmovdqa ymm6,YMMWORD PTR [rbp-0x3f0]
    17ba:	vmovdqa ymm7,YMMWORD PTR [rbp-0x430]
    17c2:	vmovq  xmm0,rsi
    17c7:	lea    rax,[rip+0x8949]        # a117 <_IO_stdin_used+0x117>
    17ce:	mov    QWORD PTR [rbp-0x328],0x0
    17d9:	lea    rdi,[rbp-0x3a0]
    17e0:	vpinsrq xmm0,xmm0,rdx,0x1
    17e6:	lea    rdx,[rip+0xcd3]        # 24c0 <void int_add<12>(unsigned long)>
    17ed:	mov    QWORD PTR [rbp-0x370],rax
    17f4:	mov    rax,QWORD PTR [rip+0x8a15]        # a210 <K_VALUES+0x50>
    17fb:	mov    QWORD PTR [rbp-0x330],rdx
    1802:	lea    rdx,[rip+0x8916]        # a11f <_IO_stdin_used+0x11f>
    1809:	mov    QWORD PTR [rbp-0x320],rdx
    1810:	lea    rdx,[rip+0x1129]        # 2940 <void int_imul<8>(unsigned long)>
    1817:	mov    QWORD PTR [rbp-0x368],rax
    181e:	mov    QWORD PTR [rbp-0x318],rax
    1825:	lea    rax,[rip+0x12a4]        # 2ad0 <void int_imul<10>(unsigned long)>
    182c:	vmovdqa XMMWORD PTR [rbp-0x340],xmm0
    1834:	vmovq  xmm0,rdx
    1839:	lea    rdx,[rip+0x88f8]        # a138 <_IO_stdin_used+0x138>
    1840:	vpinsrq xmm0,xmm0,rax,0x1
    1846:	lea    rax,[rip+0x1473]        # 2cc0 <void int_imul<12>(unsigned long)>
    184d:	vmovdqu YMMWORD PTR [rbp-0x360],ymm6
    1855:	vmovdqa ymm6,YMMWORD PTR [rbp-0x3d0]
    185d:	mov    QWORD PTR [rbp-0x2e0],rax
    1864:	lea    rax,[rip+0x88bd]        # a128 <_IO_stdin_used+0x128>
    186b:	mov    QWORD PTR [rbp-0x2d0],rax
    1872:	mov    rax,QWORD PTR [rip+0x899f]        # a218 <K_VALUES+0x58>
    1879:	vmovdqa YMMWORD PTR [rbp-0x310],ymm7
    1881:	vmovdqa ymm7,YMMWORD PTR [rbp-0x410]
    1889:	mov    QWORD PTR [rbp-0x2c8],rax
    1890:	mov    QWORD PTR [rbp-0x278],rax
    1897:	lea    rax,[rip+0x88aa]        # a148 <_IO_stdin_used+0x148>
    189e:	vmovdqu YMMWORD PTR [rbp-0x2c0],ymm6
    18a6:	vmovdqa ymm6,YMMWORD PTR [rbp-0x470]
    18ae:	mov    QWORD PTR [rbp-0x230],rax
    18b5:	mov    rax,QWORD PTR [rip+0x8964]        # a220 <K_VALUES+0x60>
    18bc:	vmovdqu YMMWORD PTR [rbp-0x2a0],ymm7
    18c4:	vmovdqa ymm7,YMMWORD PTR [rbp-0x450]
    18cc:	vmovdqa YMMWORD PTR [rbp-0x270],ymm6
    18d4:	vmovdqa ymm6,YMMWORD PTR [rbp-0x4d0]
    18dc:	mov    QWORD PTR [rbp-0x228],rax
    18e3:	lea    rax,[rip+0x886e]        # a158 <_IO_stdin_used+0x158>
    18ea:	vmovdqa XMMWORD PTR [rbp-0x2f0],xmm0
    18f2:	mov    QWORD PTR [rbp-0x280],rdx
    18f9:	lea    rdx,[rip+0x8883]        # a183 <_IO_stdin_used+0x183>
    1900:	vmovdqa YMMWORD PTR [rbp-0x250],ymm7
    1908:	mov    QWORD PTR [rbp-0x2d8],0x0
    1913:	vmovdqu YMMWORD PTR [rbp-0x220],ymm6
    191b:	vmovdqa ymm7,YMMWORD PTR [rbp-0x490]
    1923:	vmovdqa ymm6,YMMWORD PTR [rbp-0x510]
    192b:	mov    QWORD PTR [rbp-0x1e0],rax
    1932:	mov    rax,QWORD PTR [rip+0x88ef]        # a228 <K_VALUES+0x68>
    1939:	vmovdqu YMMWORD PTR [rbp-0x200],ymm7
    1941:	vmovdqa ymm7,YMMWORD PTR [rbp-0x4f0]
    1949:	mov    QWORD PTR [rbp-0x1d8],rax
    1950:	lea    rax,[rip+0x880e]        # a165 <_IO_stdin_used+0x165>
    1957:	mov    QWORD PTR [rbp-0x190],rax
    195e:	mov    rax,QWORD PTR [rip+0x88cb]        # a230 <K_VALUES+0x70>
    1965:	vmovdqa YMMWORD PTR [rbp-0x1d0],ymm6
    196d:	vmovdqa ymm6,YMMWORD PTR [rbp-0x550]
    1975:	mov    QWORD PTR [rbp-0x188],rax
    197c:	lea    rax,[rip+0x87f0]        # a173 <_IO_stdin_used+0x173>
    1983:	vmovdqa YMMWORD PTR [rbp-0x1b0],ymm7
    198b:	vmovdqa ymm7,YMMWORD PTR [rbp-0x530]
    1993:	mov    QWORD PTR [rbp-0x140],rax
    199a:	mov    rax,QWORD PTR [rip+0x8897]        # a238 <K_VALUES+0x78>
    19a1:	vmovdqu YMMWORD PTR [rbp-0x180],ymm6
    19a9:	vmovdqa ymm6,YMMWORD PTR [rbp-0x590]
    19b1:	vmovdqu YMMWORD PTR [rbp-0x160],ymm7
    19b9:	vmovdqa ymm7,YMMWORD PTR [rbp-0x570]
    19c1:	mov    QWORD PTR [rbp-0x138],rax
    19c8:	mov    QWORD PTR [rbp-0xe8],rax
    19cf:	lea    rax,[rip+0x87bd]        # a193 <_IO_stdin_used+0x193>
    19d6:	mov    QWORD PTR [rbp-0xa0],rax
    19dd:	mov    rax,QWORD PTR [rip+0x885c]        # a240 <K_VALUES+0x80>
    19e4:	vmovdqa YMMWORD PTR [rbp-0x130],ymm6
    19ec:	vmovdqa ymm6,YMMWORD PTR [rbp-0x5d0]
    19f4:	vmovdqa YMMWORD PTR [rbp-0x110],ymm7
    19fc:	vmovdqa ymm7,YMMWORD PTR [rbp-0x5b0]
    1a04:	mov    QWORD PTR [rbp-0xf0],rdx
    1a0b:	mov    QWORD PTR [rbp-0x98],rax
    1a12:	vmovdqu YMMWORD PTR [rbp-0xc0],ymm7
    1a1a:	vmovdqu YMMWORD PTR [rbp-0xe0],ymm6
    1a22:	vmovdqa ymm6,YMMWORD PTR [rbp-0x610]
    1a2a:	vmovdqa ymm7,YMMWORD PTR [rbp-0x5f0]
    1a32:	vmovdqa YMMWORD PTR [rbp-0x90],ymm6
    1a3a:	vmovdqa YMMWORD PTR [rbp-0x70],ymm7
    1a3f:	vzeroupper
    1a42:	call   9cc0 <Counters::Counters()>
    1a47:	lea    rsi,[rip+0x85f2]        # a040 <_IO_stdin_used+0x40>
    1a4e:	mov    edi,0x2
    1a53:	xor    eax,eax
    1a55:	call   1150 <__printf_chk@plt>
    1a5a:	lea    rax,[rbp-0x370]
    1a61:	mov    QWORD PTR [rbp-0x470],rax
    1a68:	nop    DWORD PTR [rax+rax*1+0x0]
    1a70:	mov    QWORD PTR [rbp-0x530],0x0
    1a7b:	nop    DWORD PTR [rax+rax*1+0x0]
    1a80:	mov    rdx,QWORD PTR [rbp-0x470]
    1a87:	mov    rax,QWORD PTR [rbp-0x530]
    1a8e:	mov    rcx,QWORD PTR [rdx+rax*8+0x10]
    1a93:	mov    QWORD PTR [rbp-0x490],rcx
    1a9a:	test   rcx,rcx
    1a9d:	je     1dc0 <main+0xb30>
    1aa3:	lea    rdx,[rip+0x8716]        # a1c0 <K_VALUES>
    1aaa:	mov    r12d,DWORD PTR [rdx+rax*4]
    1aae:	mov    rax,QWORD PTR [rbp-0x4a0]
    1ab5:	xor    edx,edx
    1ab7:	lea    ebx,[r12*8+0x0]
    1abf:	movsxd rbx,ebx
    1ac2:	div    rbx
    1ac5:	movabs rdx,0xcccccccccccccccd
    1acf:	mov    QWORD PTR [rbp-0x3d0],rax
    1ad6:	imul   rbx,rax
    1ada:	mul    rdx
    1add:	shr    rdx,0x3
    1ae1:	mov    rdi,rdx
    1ae4:	call   rcx
    1ae6:	mov    eax,DWORD PTR [rbp-0x494]
    1aec:	test   eax,eax
    1aee:	jle    1dc0 <main+0xb30>
    1af4:	vxorpd xmm5,xmm5,xmm5
    1af8:	movsxd rax,r12d
    1afb:	movzx  r13d,BYTE PTR [rbp-0x394]
    1b03:	xor    r12d,r12d
    1b06:	vcvtusi2sd xmm0,xmm5,rbx
    1b0c:	mov    QWORD PTR [rbp-0x4d0],rax
    1b13:	lea    rax,[rbp-0x3b0]
    1b1a:	mov    QWORD PTR [rbp-0x450],rax
    1b21:	lea    rax,[rbp-0x390]
    1b28:	lea    r14,[rbp-0x380]
    1b2f:	mov    QWORD PTR [rbp-0x510],rax
    1b36:	vmovsd QWORD PTR [rbp-0x4f0],xmm0
    1b3e:	jmp    1c01 <main+0x971>
    1b43:	nop    DWORD PTR [rax+rax*1+0x0]
    1b48:	cmp    rax,0x1
    1b4c:	jne    1db0 <main+0xb20>
    1b52:	movzx  edx,BYTE PTR [rbx]
    1b55:	mov    BYTE PTR [rbp-0x380],dl
    1b5b:	mov    rdx,r14
    1b5e:	mov    QWORD PTR [rbp-0x388],rax
    1b65:	vmovsd xmm1,QWORD PTR [rbp-0x4f0]
    1b6d:	xor    r8d,r8d
    1b70:	lea    rsi,[rip+0x8561]        # a0d8 <_IO_stdin_used+0xd8>
    1b77:	vmovsd xmm0,QWORD PTR [rbp-0x3f0]
    1b7f:	mov    r9,QWORD PTR [rbp-0x4d0]
    1b86:	mov    BYTE PTR [rdx+rax*1],0x0
    1b8a:	lea    rax,[rip+0x861a]        # a1ab <_IO_stdin_used+0x1ab>
    1b91:	push   rax
    1b92:	lea    rdx,[rip+0x860a]        # a1a3 <_IO_stdin_used+0x1a3>
    1b99:	mov    edi,0x2
    1b9e:	mov    eax,0x2
    1ba3:	push   r15
    1ba5:	mov    rcx,QWORD PTR [rbp-0x390]
    1bac:	push   QWORD PTR [rbp-0x430]
    1bb2:	push   QWORD PTR [rbp-0x410]
    1bb8:	push   QWORD PTR [rbp-0x3d0]
    1bbe:	push   r12
    1bc0:	call   1150 <__printf_chk@plt>
    1bc5:	mov    rdi,QWORD PTR [rip+0xa454]        # c020 <stdout@GLIBC_2.2.5>
    1bcc:	add    rsp,0x30
    1bd0:	call   11d0 <fflush@plt>
    1bd5:	mov    rdi,QWORD PTR [rbp-0x390]
    1bdc:	cmp    rdi,r14
    1bdf:	je     1bf1 <main+0x961>
    1be1:	mov    rax,QWORD PTR [rbp-0x380]
    1be8:	lea    rsi,[rax+0x1]
    1bec:	call   11b0 <operator delete(void*, unsigned long)@plt>
    1bf1:	inc    r12d
    1bf4:	cmp    DWORD PTR [rbp-0x494],r12d
    1bfb:	je     1dc0 <main+0xb30>
    1c01:	test   r13b,r13b
    1c04:	je     1c32 <main+0x9a2>
    1c06:	mov    ebx,DWORD PTR [rbp-0x3a0]
    1c0c:	mov    edx,0x1
    1c11:	mov    esi,0x2403
    1c16:	xor    eax,eax
    1c18:	mov    edi,ebx
    1c1a:	call   1200 <ioctl@plt>
    1c1f:	mov    edx,0x1
    1c24:	mov    esi,0x2400
    1c29:	mov    edi,ebx
    1c2b:	xor    eax,eax
    1c2d:	call   1200 <ioctl@plt>
    1c32:	mov    rbx,QWORD PTR [rbp-0x450]
    1c39:	mov    edi,0x4
    1c3e:	mov    rsi,rbx
    1c41:	call   11a0 <clock_gettime@plt>
    1c46:	vxorpd xmm2,xmm2,xmm2
    1c4a:	mov    rdi,QWORD PTR [rbp-0x3d0]
    1c51:	mov    rax,QWORD PTR [rbp-0x490]
    1c58:	vcvtsi2sd xmm0,xmm2,QWORD PTR [rbp-0x3b0]
    1c61:	vmovsd xmm1,xmm0,xmm0
    1c65:	vcvtsi2sd xmm0,xmm2,QWORD PTR [rbp-0x3a8]
    1c6e:	vfmadd132sd xmm1,xmm0,QWORD PTR [rip+0x85d1]        # a248 <K_VALUES+0x88>
    1c77:	vmovsd QWORD PTR [rbp-0x3f0],xmm1
    1c7f:	call   rax
    1c81:	mov    rsi,rbx
    1c84:	mov    edi,0x4
    1c89:	call   11a0 <clock_gettime@plt>
    1c8e:	vxorpd xmm2,xmm2,xmm2
    1c92:	vcvtsi2sd xmm0,xmm2,QWORD PTR [rbp-0x3b0]
    1c9b:	vcvtsi2sd xmm1,xmm2,QWORD PTR [rbp-0x3a8]
    1ca4:	vfmadd132sd xmm0,xmm1,QWORD PTR [rip+0x859b]        # a248 <K_VALUES+0x88>
    1cad:	test   r13b,r13b
    1cb0:	je     1cf8 <main+0xa68>
    1cb2:	mov    ebx,DWORD PTR [rbp-0x3a0]
    1cb8:	mov    edx,0x1
    1cbd:	mov    esi,0x2401
    1cc2:	xor    eax,eax
    1cc4:	vmovsd QWORD PTR [rbp-0x410],xmm0
    1ccc:	mov    edi,ebx
    1cce:	call   1200 <ioctl@plt>
    1cd3:	mov    rsi,QWORD PTR [rbp-0x510]
    1cda:	mov    edx,0x20
    1cdf:	mov    edi,ebx
    1ce1:	call   1210 <read@plt>
    1ce6:	vmovsd xmm0,QWORD PTR [rbp-0x410]
    1cee:	cmp    rax,0x20
    1cf2:	je     1e20 <main+0xb90>
    1cf8:	mov    QWORD PTR [rbp-0x430],0x0
    1d03:	xor    r15d,r15d
    1d06:	mov    QWORD PTR [rbp-0x410],0x0
    1d11:	mov    rax,QWORD PTR [rbp-0x470]
    1d18:	vsubsd xmm3,xmm0,QWORD PTR [rbp-0x3f0]
    1d20:	mov    QWORD PTR [rbp-0x390],r14
    1d27:	mov    rbx,QWORD PTR [rax]
    1d2a:	vmovsd QWORD PTR [rbp-0x3f0],xmm3
    1d32:	test   rbx,rbx
    1d35:	je     1e48 <main+0xbb8>
    1d3b:	mov    rdi,rbx
    1d3e:	call   1170 <strlen@plt>
    1d43:	mov    QWORD PTR [rbp-0x3b0],rax
    1d4a:	mov    rcx,rax
    1d4d:	cmp    rax,0xf
    1d51:	jbe    1b48 <main+0x8b8>
    1d57:	mov    rdi,QWORD PTR [rbp-0x510]
    1d5e:	mov    rsi,QWORD PTR [rbp-0x450]
    1d65:	xor    edx,edx
    1d67:	mov    QWORD PTR [rbp-0x550],rax
    1d6e:	call   1240 <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >::_M_create(unsigned long&, unsigned long)@plt>
    1d73:	mov    rcx,QWORD PTR [rbp-0x550]
    1d7a:	mov    QWORD PTR [rbp-0x390],rax
    1d81:	mov    rdi,rax
    1d84:	mov    rax,QWORD PTR [rbp-0x3b0]
    1d8b:	mov    QWORD PTR [rbp-0x380],rax
    1d92:	mov    rdx,rcx
    1d95:	mov    rsi,rbx
    1d98:	call   1190 <memcpy@plt>
    1d9d:	mov    rax,QWORD PTR [rbp-0x3b0]
    1da4:	mov    rdx,QWORD PTR [rbp-0x390]
    1dab:	jmp    1b5e <main+0x8ce>
    1db0:	test   rax,rax
    1db3:	je     1b5b <main+0x8cb>
    1db9:	mov    rdi,r14
    1dbc:	jmp    1d92 <main+0xb02>
    1dbe:	xchg   ax,ax
    1dc0:	inc    QWORD PTR [rbp-0x530]
    1dc7:	mov    rax,QWORD PTR [rbp-0x530]
    1dce:	cmp    rax,0x8
    1dd2:	jne    1a80 <main+0x7f0>
    1dd8:	add    QWORD PTR [rbp-0x470],0x50
    1de0:	lea    rax,[rbp-0x50]
    1de4:	mov    rdx,QWORD PTR [rbp-0x470]
    1deb:	cmp    rdx,rax
    1dee:	jne    1a70 <main+0x7e0>
    1df4:	mov    rax,QWORD PTR [rbp-0x38]
    1df8:	sub    rax,QWORD PTR fs:0x28
    1e01:	jne    1e63 <main+0xbd3>
    1e03:	lea    rsp,[rbp-0x30]
    1e07:	xor    eax,eax
    1e09:	pop    rbx
    1e0a:	pop    r10
    1e0c:	pop    r12
    1e0e:	pop    r13
    1e10:	pop    r14
    1e12:	pop    r15
    1e14:	pop    rbp
    1e15:	lea    rsp,[r10-0x8]
    1e19:	ret
    1e1a:	nop    WORD PTR [rax+rax*1+0x0]
    1e20:	mov    rax,QWORD PTR [rbp-0x388]
    1e27:	mov    r15,QWORD PTR [rbp-0x378]
    1e2e:	mov    QWORD PTR [rbp-0x410],rax
    1e35:	mov    rax,QWORD PTR [rbp-0x380]
    1e3c:	mov    QWORD PTR [rbp-0x430],rax
    1e43:	jmp    1d11 <main+0xa81>
    1e48:	mov    rax,QWORD PTR [rbp-0x38]
    1e4c:	sub    rax,QWORD PTR fs:0x28
    1e55:	jne    1e63 <main+0xbd3>
    1e57:	lea    rdi,[rip+0x8242]        # a0a0 <_IO_stdin_used+0xa0>
    1e5e:	call   1180 <std::__throw_logic_error(char const*)@plt>
    1e63:	call   11c0 <__stack_chk_fail@plt>
    1e68:	endbr64
    1e6c:	mov    rbx,rax
    1e6f:	jmp    1260 <main.cold>
    1e74:	cs nop WORD PTR [rax+rax*1+0x0]
    1e7e:	xchg   ax,ax

0000000000001e80 <_start>:
    1e80:	endbr64
    1e84:	xor    ebp,ebp
    1e86:	mov    r9,rdx
    1e89:	pop    rsi
    1e8a:	mov    rdx,rsp
    1e8d:	and    rsp,0xfffffffffffffff0
    1e91:	push   rax
    1e92:	push   rsp
    1e93:	xor    r8d,r8d
    1e96:	xor    ecx,ecx
    1e98:	lea    rdi,[rip+0xfffffffffffff3f1]        # 1290 <main>
    1e9f:	call   QWORD PTR [rip+0xa13b]        # bfe0 <__libc_start_main@GLIBC_2.34>
    1ea5:	hlt
    1ea6:	cs nop WORD PTR [rax+rax*1+0x0]

0000000000001eb0 <deregister_tm_clones>:
    1eb0:	lea    rdi,[rip+0xa161]        # c018 <__TMC_END__>
    1eb7:	lea    rax,[rip+0xa15a]        # c018 <__TMC_END__>
    1ebe:	cmp    rax,rdi
    1ec1:	je     1ed8 <deregister_tm_clones+0x28>
    1ec3:	mov    rax,QWORD PTR [rip+0xa11e]        # bfe8 <_ITM_deregisterTMCloneTable@Base>
    1eca:	test   rax,rax
    1ecd:	je     1ed8 <deregister_tm_clones+0x28>
    1ecf:	jmp    rax
    1ed1:	nop    DWORD PTR [rax+0x0]
    1ed8:	ret
    1ed9:	nop    DWORD PTR [rax+0x0]

0000000000001ee0 <register_tm_clones>:
    1ee0:	lea    rdi,[rip+0xa131]        # c018 <__TMC_END__>
    1ee7:	lea    rsi,[rip+0xa12a]        # c018 <__TMC_END__>
    1eee:	sub    rsi,rdi
    1ef1:	mov    rax,rsi
    1ef4:	shr    rsi,0x3f
    1ef8:	sar    rax,0x3
    1efc:	add    rsi,rax
    1eff:	sar    rsi,1
    1f02:	je     1f18 <register_tm_clones+0x38>
    1f04:	mov    rax,QWORD PTR [rip+0xa0ed]        # bff8 <_ITM_registerTMCloneTable@Base>
    1f0b:	test   rax,rax
    1f0e:	je     1f18 <register_tm_clones+0x38>
    1f10:	jmp    rax
    1f12:	nop    WORD PTR [rax+rax*1+0x0]
    1f18:	ret
    1f19:	nop    DWORD PTR [rax+0x0]

0000000000001f20 <__do_global_dtors_aux>:
    1f20:	endbr64
    1f24:	cmp    BYTE PTR [rip+0xa11d],0x0        # c048 <completed.0>
    1f2b:	jne    1f58 <__do_global_dtors_aux+0x38>
    1f2d:	push   rbp
    1f2e:	cmp    QWORD PTR [rip+0xa0a2],0x0        # bfd8 <__cxa_finalize@GLIBC_2.2.5>
    1f36:	mov    rbp,rsp
    1f39:	je     1f47 <__do_global_dtors_aux+0x27>
    1f3b:	mov    rdi,QWORD PTR [rip+0xa0c6]        # c008 <__dso_handle>
    1f42:	call   1140 <__cxa_finalize@plt>
    1f47:	call   1eb0 <deregister_tm_clones>
    1f4c:	mov    BYTE PTR [rip+0xa0f5],0x1        # c048 <completed.0>
    1f53:	pop    rbp
    1f54:	ret
    1f55:	nop    DWORD PTR [rax]
    1f58:	ret
    1f59:	nop    DWORD PTR [rax+0x0]

0000000000001f60 <frame_dummy>:
    1f60:	endbr64
    1f64:	jmp    1ee0 <register_tm_clones>
    1f69:	nop    DWORD PTR [rax+0x0]

0000000000001f70 <void int_add<1>(unsigned long)>:
    1f70:	endbr64
    1f74:	xor    eax,eax
    1f76:	test   rdi,rdi
    1f79:	je     1fa8 <void int_add<1>(unsigned long)+0x38>
    1f7b:	xor    ecx,ecx
    1f7d:	mov    edx,0x3
    1f82:	nop    WORD PTR [rax+rax*1+0x0]
    1f88:	add    rax,rdx
    1f8b:	add    rax,rdx
    1f8e:	add    rax,rdx
    1f91:	add    rax,rdx
    1f94:	add    rax,rdx
    1f97:	add    rax,rdx
    1f9a:	add    rax,rdx
    1f9d:	add    rax,rdx
    1fa0:	inc    rcx
    1fa3:	cmp    rdi,rcx
    1fa6:	jne    1f88 <void int_add<1>(unsigned long)+0x18>
    1fa8:	ret
    1fa9:	nop    DWORD PTR [rax+0x0]

0000000000001fb0 <void int_add<2>(unsigned long)>:
    1fb0:	endbr64
    1fb4:	test   rdi,rdi
    1fb7:	je     2009 <void int_add<2>(unsigned long)+0x59>
    1fb9:	mov    eax,0x1
    1fbe:	xor    edx,edx
    1fc0:	xor    esi,esi
    1fc2:	mov    ecx,0x3
    1fc7:	nop    WORD PTR [rax+rax*1+0x0]
    1fd0:	add    rdx,rcx
    1fd3:	add    rax,rcx
    1fd6:	add    rdx,rcx
    1fd9:	add    rax,rcx
    1fdc:	add    rdx,rcx
    1fdf:	add    rax,rcx
    1fe2:	add    rdx,rcx
    1fe5:	add    rax,rcx
    1fe8:	add    rdx,rcx
    1feb:	add    rax,rcx
    1fee:	add    rdx,rcx
    1ff1:	add    rax,rcx
    1ff4:	add    rdx,rcx
    1ff7:	add    rax,rcx
    1ffa:	add    rdx,rcx
    1ffd:	add    rax,rcx
    2000:	inc    rsi
    2003:	cmp    rdi,rsi
    2006:	jne    1fd0 <void int_add<2>(unsigned long)+0x20>
    2008:	ret
    2009:	xor    edx,edx
    200b:	mov    eax,0x1
    2010:	ret
    2011:	data16 cs nop WORD PTR [rax+rax*1+0x0]
    201c:	nop    DWORD PTR [rax+0x0]

0000000000002020 <void int_add<4>(unsigned long)>:
    2020:	endbr64
    2024:	test   rdi,rdi
    2027:	je     20b9 <void int_add<4>(unsigned long)+0x99>
    202d:	mov    eax,0x3
    2032:	mov    edx,0x2
    2037:	mov    r8d,0x1
    203d:	xor    r9d,r9d
    2040:	xor    esi,esi
    2042:	mov    ecx,0x3
    2047:	nop    WORD PTR [rax+rax*1+0x0]
    2050:	add    r9,rcx
    2053:	add    r8,rcx
    2056:	add    rdx,rcx
    2059:	add    rax,rcx
    205c:	add    r9,rcx
    205f:	add    r8,rcx
    2062:	add    rdx,rcx
    2065:	add    rax,rcx
    2068:	add    r9,rcx
    206b:	add    r8,rcx
    206e:	add    rdx,rcx
    2071:	add    rax,rcx
    2074:	add    r9,rcx
    2077:	add    r8,rcx
    207a:	add    rdx,rcx
    207d:	add    rax,rcx
    2080:	add    r9,rcx
    2083:	add    r8,rcx
    2086:	add    rdx,rcx
    2089:	add    rax,rcx
    208c:	add    r9,rcx
    208f:	add    r8,rcx
    2092:	add    rdx,rcx
    2095:	add    rax,rcx
    2098:	add    r9,rcx
    209b:	add    r8,rcx
    209e:	add    rdx,rcx
    20a1:	add    rax,rcx
    20a4:	add    r9,rcx
    20a7:	add    r8,rcx
    20aa:	add    rdx,rcx
    20ad:	add    rax,rcx
    20b0:	inc    rsi
    20b3:	cmp    rdi,rsi
    20b6:	jne    2050 <void int_add<4>(unsigned long)+0x30>
    20b8:	ret
    20b9:	xor    r9d,r9d
    20bc:	mov    eax,0x3
    20c1:	mov    edx,0x2
    20c6:	mov    r8d,0x1
    20cc:	ret
    20cd:	nop    DWORD PTR [rax]

00000000000020d0 <void int_add<6>(unsigned long)>:
    20d0:	endbr64
    20d4:	test   rdi,rdi
    20d7:	je     21a5 <void int_add<6>(unsigned long)+0xd5>
    20dd:	mov    r8d,0x5
    20e3:	mov    r9d,0x4
    20e9:	mov    r10d,0x3
    20ef:	mov    r11d,0x2
    20f5:	mov    edx,0x1
    20fa:	xor    ecx,ecx
    20fc:	xor    esi,esi
    20fe:	mov    eax,0x3
    2103:	nop    DWORD PTR [rax+rax*1+0x0]
    2108:	add    rcx,rax
    210b:	add    rdx,rax
    210e:	add    r11,rax
    2111:	add    r10,rax
    2114:	add    r9,rax
    2117:	add    r8,rax
    211a:	add    rcx,rax
    211d:	add    rdx,rax
    2120:	add    r11,rax
    2123:	add    r10,rax
    2126:	add    r9,rax
    2129:	add    r8,rax
    212c:	add    rcx,rax
    212f:	add    rdx,rax
    2132:	add    r11,rax
    2135:	add    r10,rax
    2138:	add    r9,rax
    213b:	add    r8,rax
    213e:	add    rcx,rax
    2141:	add    rdx,rax
    2144:	add    r11,rax
    2147:	add    r10,rax
    214a:	add    r9,rax
    214d:	add    r8,rax
    2150:	add    rcx,rax
    2153:	add    rdx,rax
    2156:	add    r11,rax
    2159:	add    r10,rax
    215c:	add    r9,rax
    215f:	add    r8,rax
    2162:	add    rcx,rax
    2165:	add    rdx,rax
    2168:	add    r11,rax
    216b:	add    r10,rax
    216e:	add    r9,rax
    2171:	add    r8,rax
    2174:	add    rcx,rax
    2177:	add    rdx,rax
    217a:	add    r11,rax
    217d:	add    r10,rax
    2180:	add    r9,rax
    2183:	add    r8,rax
    2186:	add    rcx,rax
    2189:	add    rdx,rax
    218c:	add    r11,rax
    218f:	add    r10,rax
    2192:	add    r9,rax
    2195:	add    r8,rax
    2198:	inc    rsi
    219b:	cmp    rdi,rsi
    219e:	jne    2108 <void int_add<6>(unsigned long)+0x38>
    21a4:	ret
    21a5:	xor    ecx,ecx
    21a7:	mov    r8d,0x5
    21ad:	mov    r9d,0x4
    21b3:	mov    r10d,0x3
    21b9:	mov    r11d,0x2
    21bf:	mov    edx,0x1
    21c4:	ret
    21c5:	data16 cs nop WORD PTR [rax+rax*1+0x0]

00000000000021d0 <void int_add<8>(unsigned long)>:
    21d0:	endbr64
    21d4:	push   rbp
    21d5:	push   rbx
    21d6:	test   rdi,rdi
    21d9:	je     22e7 <void int_add<8>(unsigned long)+0x117>
    21df:	mov    rbp,rdi
    21e2:	mov    r11d,0x7
    21e8:	mov    ebx,0x6
    21ed:	mov    edx,0x5
    21f2:	mov    ecx,0x4
    21f7:	mov    edi,0x3
    21fc:	mov    r8d,0x2
    2202:	mov    r9d,0x1
    2208:	xor    r10d,r10d
    220b:	xor    esi,esi
    220d:	mov    eax,0x3
    2212:	nop    WORD PTR [rax+rax*1+0x0]
    2218:	add    r10,rax
    221b:	add    r9,rax
    221e:	add    r8,rax
    2221:	add    rdi,rax
    2224:	add    rcx,rax
    2227:	add    rdx,rax
    222a:	add    rbx,rax
    222d:	add    r11,rax
    2230:	add    r10,rax
    2233:	add    r9,rax
    2236:	add    r8,rax
    2239:	add    rdi,rax
    223c:	add    rcx,rax
    223f:	add    rdx,rax
    2242:	add    rbx,rax
    2245:	add    r11,rax
    2248:	add    r10,rax
    224b:	add    r9,rax
    224e:	add    r8,rax
    2251:	add    rdi,rax
    2254:	add    rcx,rax
    2257:	add    rdx,rax
    225a:	add    rbx,rax
    225d:	add    r11,rax
    2260:	add    r10,rax
    2263:	add    r9,rax
    2266:	add    r8,rax
    2269:	add    rdi,rax
    226c:	add    rcx,rax
    226f:	add    rdx,rax
    2272:	add    rbx,rax
    2275:	add    r11,rax
    2278:	add    r10,rax
    227b:	add    r9,rax
    227e:	add    r8,rax
    2281:	add    rdi,rax
    2284:	add    rcx,rax
    2287:	add    rdx,rax
    228a:	add    rbx,rax
    228d:	add    r11,rax
    2290:	add    r10,rax
    2293:	add    r9,rax
    2296:	add    r8,rax
    2299:	add    rdi,rax
    229c:	add    rcx,rax
    229f:	add    rdx,rax
    22a2:	add    rbx,rax
    22a5:	add    r11,rax
    22a8:	add    r10,rax
    22ab:	add    r9,rax
    22ae:	add    r8,rax
    22b1:	add    rdi,rax
    22b4:	add    rcx,rax
    22b7:	add    rdx,rax
    22ba:	add    rbx,rax
    22bd:	add    r11,rax
    22c0:	add    r10,rax
    22c3:	add    r9,rax
    22c6:	add    r8,rax
    22c9:	add    rdi,rax
    22cc:	add    rcx,rax
    22cf:	add    rdx,rax
    22d2:	add    rbx,rax
    22d5:	add    r11,rax
    22d8:	inc    rsi
    22db:	cmp    rbp,rsi
    22de:	jne    2218 <void int_add<8>(unsigned long)+0x48>
    22e4:	pop    rbx
    22e5:	pop    rbp
    22e6:	ret
    22e7:	xor    r10d,r10d
    22ea:	mov    r11d,0x7
    22f0:	mov    ebx,0x6
    22f5:	mov    edx,0x5
    22fa:	mov    ecx,0x4
    22ff:	mov    edi,0x3
    2304:	mov    r8d,0x2
    230a:	mov    r9d,0x1
    2310:	pop    rbx
    2311:	pop    rbp
    2312:	ret
    2313:	data16 cs nop WORD PTR [rax+rax*1+0x0]
    231e:	xchg   ax,ax

0000000000002320 <void int_add<10>(unsigned long)>:
    2320:	endbr64
    2324:	push   r13
    2326:	push   r12
    2328:	push   rbp
    2329:	push   rbx
    232a:	test   rdi,rdi
    232d:	je     247b <void int_add<10>(unsigned long)+0x15b>
    2333:	mov    r13,rdi
    2336:	mov    r9d,0x9
    233c:	mov    r10d,0x8
    2342:	mov    r11d,0x7
    2348:	mov    ebx,0x6
    234d:	mov    ebp,0x5
    2352:	mov    r12d,0x4
    2358:	mov    edx,0x3
    235d:	mov    ecx,0x2
    2362:	mov    edi,0x1
    2367:	xor    r8d,r8d
    236a:	xor    esi,esi
    236c:	mov    eax,0x3
    2371:	nop    DWORD PTR [rax+0x0]
    2378:	add    r8,rax
    237b:	add    rdi,rax
    237e:	add    rcx,rax
    2381:	add    rdx,rax
    2384:	add    r12,rax
    2387:	add    rbp,rax
    238a:	add    rbx,rax
    238d:	add    r11,rax
    2390:	add    r10,rax
    2393:	add    r9,rax
    2396:	add    r8,rax
    2399:	add    rdi,rax
    239c:	add    rcx,rax
    239f:	add    rdx,rax
    23a2:	add    r12,rax
    23a5:	add    rbp,rax
    23a8:	add    rbx,rax
    23ab:	add    r11,rax
    23ae:	add    r10,rax
    23b1:	add    r9,rax
    23b4:	add    r8,rax
    23b7:	add    rdi,rax
    23ba:	add    rcx,rax
    23bd:	add    rdx,rax
    23c0:	add    r12,rax
    23c3:	add    rbp,rax
    23c6:	add    rbx,rax
    23c9:	add    r11,rax
    23cc:	add    r10,rax
    23cf:	add    r9,rax
    23d2:	add    r8,rax
    23d5:	add    rdi,rax
    23d8:	add    rcx,rax
    23db:	add    rdx,rax
    23de:	add    r12,rax
    23e1:	add    rbp,rax
    23e4:	add    rbx,rax
    23e7:	add    r11,rax
    23ea:	add    r10,rax
    23ed:	add    r9,rax
    23f0:	add    r8,rax
    23f3:	add    rdi,rax
    23f6:	add    rcx,rax
    23f9:	add    rdx,rax
    23fc:	add    r12,rax
    23ff:	add    rbp,rax
    2402:	add    rbx,rax
    2405:	add    r11,rax
    2408:	add    r10,rax
    240b:	add    r9,rax
    240e:	add    r8,rax
    2411:	add    rdi,rax
    2414:	add    rcx,rax
    2417:	add    rdx,rax
    241a:	add    r12,rax
    241d:	add    rbp,rax
    2420:	add    rbx,rax
    2423:	add    r11,rax
    2426:	add    r10,rax
    2429:	add    r9,rax
    242c:	add    r8,rax
    242f:	add    rdi,rax
    2432:	add    rcx,rax
    2435:	add    rdx,rax
    2438:	add    r12,rax
    243b:	add    rbp,rax
    243e:	add    rbx,rax
    2441:	add    r11,rax
    2444:	add    r10,rax
    2447:	add    r9,rax
    244a:	add    r8,rax
    244d:	add    rdi,rax
    2450:	add    rcx,rax
    2453:	add    rdx,rax
    2456:	add    r12,rax
    2459:	add    rbp,rax
    245c:	add    rbx,rax
    245f:	add    r11,rax
    2462:	add    r10,rax
    2465:	add    r9,rax
    2468:	inc    rsi
    246b:	cmp    r13,rsi
    246e:	jne    2378 <void int_add<10>(unsigned long)+0x58>
    2474:	pop    rbx
    2475:	pop    rbp
    2476:	pop    r12
    2478:	pop    r13
    247a:	ret
    247b:	xor    r8d,r8d
    247e:	mov    r9d,0x9
    2484:	mov    r10d,0x8
    248a:	mov    r11d,0x7
    2490:	mov    ebx,0x6
    2495:	mov    ebp,0x5
    249a:	mov    r12d,0x4
    24a0:	mov    edx,0x3
    24a5:	mov    ecx,0x2
    24aa:	mov    edi,0x1
    24af:	pop    rbx
    24b0:	pop    rbp
    24b1:	pop    r12
    24b3:	pop    r13
    24b5:	ret
    24b6:	cs nop WORD PTR [rax+rax*1+0x0]

00000000000024c0 <void int_add<12>(unsigned long)>:
    24c0:	endbr64
    24c4:	push   r15
    24c6:	push   r14
    24c8:	push   r13
    24ca:	push   r12
    24cc:	push   rbp
    24cd:	push   rbx
    24ce:	test   rdi,rdi
    24d1:	je     265f <void int_add<12>(unsigned long)+0x19f>
    24d7:	mov    r15,rdi
    24da:	mov    esi,0xb
    24df:	mov    edi,0xa
    24e4:	mov    r8d,0x9
    24ea:	mov    r9d,0x8
    24f0:	mov    r11d,0x7
    24f6:	mov    ebx,0x6
    24fb:	mov    ebp,0x5
    2500:	mov    r12d,0x4
    2506:	mov    r13d,0x3
    250c:	mov    r14d,0x2
    2512:	mov    edx,0x1
    2517:	xor    ecx,ecx
    2519:	xor    r10d,r10d
    251c:	mov    eax,0x3
    2521:	nop    DWORD PTR [rax+0x0]
    2528:	add    rcx,rax
    252b:	add    rdx,rax
    252e:	add    r14,rax
    2531:	add    r13,rax
    2534:	add    r12,rax
    2537:	add    rbp,rax
    253a:	add    rbx,rax
    253d:	add    r11,rax
    2540:	add    r9,rax
    2543:	add    r8,rax
    2546:	add    rdi,rax
    2549:	add    rsi,rax
    254c:	add    rcx,rax
    254f:	add    rdx,rax
    2552:	add    r14,rax
    2555:	add    r13,rax
    2558:	add    r12,rax
    255b:	add    rbp,rax
    255e:	add    rbx,rax
    2561:	add    r11,rax
    2564:	add    r9,rax
    2567:	add    r8,rax
    256a:	add    rdi,rax
    256d:	add    rsi,rax
    2570:	add    rcx,rax
    2573:	add    rdx,rax
    2576:	add    r14,rax
    2579:	add    r13,rax
    257c:	add    r12,rax
    257f:	add    rbp,rax
    2582:	add    rbx,rax
    2585:	add    r11,rax
    2588:	add    r9,rax
    258b:	add    r8,rax
    258e:	add    rdi,rax
    2591:	add    rsi,rax
    2594:	add    rcx,rax
    2597:	add    rdx,rax
    259a:	add    r14,rax
    259d:	add    r13,rax
    25a0:	add    r12,rax
    25a3:	add    rbp,rax
    25a6:	add    rbx,rax
    25a9:	add    r11,rax
    25ac:	add    r9,rax
    25af:	add    r8,rax
    25b2:	add    rdi,rax
    25b5:	add    rsi,rax
    25b8:	add    rcx,rax
    25bb:	add    rdx,rax
    25be:	add    r14,rax
    25c1:	add    r13,rax
    25c4:	add    r12,rax
    25c7:	add    rbp,rax
    25ca:	add    rbx,rax
    25cd:	add    r11,rax
    25d0:	add    r9,rax
    25d3:	add    r8,rax
    25d6:	add    rdi,rax
    25d9:	add    rsi,rax
    25dc:	add    rcx,rax
    25df:	add    rdx,rax
    25e2:	add    r14,rax
    25e5:	add    r13,rax
    25e8:	add    r12,rax
    25eb:	add    rbp,rax
    25ee:	add    rbx,rax
    25f1:	add    r11,rax
    25f4:	add    r9,rax
    25f7:	add    r8,rax
    25fa:	add    rdi,rax
    25fd:	add    rsi,rax
    2600:	add    rcx,rax
    2603:	add    rdx,rax
    2606:	add    r14,rax
    2609:	add    r13,rax
    260c:	add    r12,rax
    260f:	add    rbp,rax
    2612:	add    rbx,rax
    2615:	add    r11,rax
    2618:	add    r9,rax
    261b:	add    r8,rax
    261e:	add    rdi,rax
    2621:	add    rsi,rax
    2624:	add    rcx,rax
    2627:	add    rdx,rax
    262a:	add    r14,rax
    262d:	add    r13,rax
    2630:	add    r12,rax
    2633:	add    rbp,rax
    2636:	add    rbx,rax
    2639:	add    r11,rax
    263c:	add    r9,rax
    263f:	add    r8,rax
    2642:	add    rdi,rax
    2645:	add    rsi,rax
    2648:	inc    r10
    264b:	cmp    r15,r10
    264e:	jne    2528 <void int_add<12>(unsigned long)+0x68>
    2654:	pop    rbx
    2655:	pop    rbp
    2656:	pop    r12
    2658:	pop    r13
    265a:	pop    r14
    265c:	pop    r15
    265e:	ret
    265f:	xor    ecx,ecx
    2661:	mov    esi,0xb
    2666:	mov    edi,0xa
    266b:	mov    r8d,0x9
    2671:	mov    r9d,0x8
    2677:	mov    r11d,0x7
    267d:	mov    ebx,0x6
    2682:	mov    ebp,0x5
    2687:	mov    r12d,0x4
    268d:	mov    r13d,0x3
    2693:	mov    r14d,0x2
    2699:	mov    edx,0x1
    269e:	pop    rbx
    269f:	pop    rbp
    26a0:	pop    r12
    26a2:	pop    r13
    26a4:	pop    r14
    26a6:	pop    r15
    26a8:	ret
    26a9:	nop    DWORD PTR [rax+0x0]

00000000000026b0 <void int_imul<1>(unsigned long)>:
    26b0:	endbr64
    26b4:	mov    eax,0x1
    26b9:	test   rdi,rdi
    26bc:	je     26f0 <void int_imul<1>(unsigned long)+0x40>
    26be:	xor    ecx,ecx
    26c0:	mov    edx,0x3
    26c5:	nop    DWORD PTR [rax]
    26c8:	imul   rax,rdx
    26cc:	imul   rax,rdx
    26d0:	imul   rax,rdx
    26d4:	imul   rax,rdx
    26d8:	imul   rax,rdx
    26dc:	imul   rax,rdx
    26e0:	imul   rax,rdx
    26e4:	imul   rax,rdx
    26e8:	inc    rcx
    26eb:	cmp    rdi,rcx
    26ee:	jne    26c8 <void int_imul<1>(unsigned long)+0x18>
    26f0:	ret
    26f1:	data16 cs nop WORD PTR [rax+rax*1+0x0]
    26fc:	nop    DWORD PTR [rax+0x0]

0000000000002700 <void int_imul<2>(unsigned long)>:
    2700:	endbr64
    2704:	mov    eax,0x2
    2709:	mov    edx,0x1
    270e:	test   rdi,rdi
    2711:	je     2768 <void int_imul<2>(unsigned long)+0x68>
    2713:	xor    esi,esi
    2715:	mov    ecx,0x3
    271a:	nop    WORD PTR [rax+rax*1+0x0]
    2720:	imul   rdx,rcx
    2724:	imul   rax,rcx
    2728:	imul   rdx,rcx
    272c:	imul   rax,rcx
    2730:	imul   rdx,rcx
    2734:	imul   rax,rcx
    2738:	imul   rdx,rcx
    273c:	imul   rax,rcx
    2740:	imul   rdx,rcx
    2744:	imul   rax,rcx
    2748:	imul   rdx,rcx
    274c:	imul   rax,rcx
    2750:	imul   rdx,rcx
    2754:	imul   rax,rcx
    2758:	imul   rdx,rcx
    275c:	imul   rax,rcx
    2760:	inc    rsi
    2763:	cmp    rdi,rsi
    2766:	jne    2720 <void int_imul<2>(unsigned long)+0x20>
    2768:	ret
    2769:	nop    DWORD PTR [rax+0x0]

0000000000002770 <void int_imul<4>(unsigned long)>:
    2770:	endbr64
    2774:	mov    eax,0x4
    2779:	mov    edx,0x3
    277e:	mov    r8d,0x2
    2784:	mov    r9d,0x1
    278a:	test   rdi,rdi
    278d:	je     282c <void int_imul<4>(unsigned long)+0xbc>
    2793:	xor    esi,esi
    2795:	mov    ecx,0x3
    279a:	nop    WORD PTR [rax+rax*1+0x0]
    27a0:	imul   r9,rcx
    27a4:	imul   r8,rcx
    27a8:	imul   rdx,rcx
    27ac:	imul   rax,rcx
    27b0:	imul   r9,rcx
    27b4:	imul   r8,rcx
    27b8:	imul   rdx,rcx
    27bc:	imul   rax,rcx
    27c0:	imul   r9,rcx
    27c4:	imul   r8,rcx
    27c8:	imul   rdx,rcx
    27cc:	imul   rax,rcx
    27d0:	imul   r9,rcx
    27d4:	imul   r8,rcx
    27d8:	imul   rdx,rcx
    27dc:	imul   rax,rcx
    27e0:	imul   r9,rcx
    27e4:	imul   r8,rcx
    27e8:	imul   rdx,rcx
    27ec:	imul   rax,rcx
    27f0:	imul   r9,rcx
    27f4:	imul   r8,rcx
    27f8:	imul   rdx,rcx
    27fc:	imul   rax,rcx
    2800:	imul   r9,rcx
    2804:	imul   r8,rcx
    2808:	imul   rdx,rcx
    280c:	imul   rax,rcx
    2810:	imul   r9,rcx
    2814:	imul   r8,rcx
    2818:	imul   rdx,rcx
    281c:	imul   rax,rcx
    2820:	inc    rsi
    2823:	cmp    rdi,rsi
    2826:	jne    27a0 <void int_imul<4>(unsigned long)+0x30>
    282c:	ret
    282d:	nop    DWORD PTR [rax]

0000000000002830 <void int_imul<6>(unsigned long)>:
    2830:	endbr64
    2834:	mov    r8d,0x6
    283a:	mov    r9d,0x5
    2840:	mov    r10d,0x4
    2846:	mov    r11d,0x3
    284c:	mov    edx,0x2
    2851:	mov    ecx,0x1
    2856:	test   rdi,rdi
    2859:	je     293c <void int_imul<6>(unsigned long)+0x10c>
    285f:	xor    esi,esi
    2861:	mov    eax,0x3
    2866:	cs nop WORD PTR [rax+rax*1+0x0]
    2870:	imul   rcx,rax
    2874:	imul   rdx,rax
    2878:	imul   r11,rax
    287c:	imul   r10,rax
    2880:	imul   r9,rax
    2884:	imul   r8,rax
    2888:	imul   rcx,rax
    288c:	imul   rdx,rax
    2890:	imul   r11,rax
    2894:	imul   r10,rax
    2898:	imul   r9,rax
    289c:	imul   r8,rax
    28a0:	imul   rcx,rax
    28a4:	imul   rdx,rax
    28a8:	imul   r11,rax
    28ac:	imul   r10,rax
    28b0:	imul   r9,rax
    28b4:	imul   r8,rax
    28b8:	imul   rcx,rax
    28bc:	imul   rdx,rax
    28c0:	imul   r11,rax
    28c4:	imul   r10,rax
    28c8:	imul   r9,rax
    28cc:	imul   r8,rax
    28d0:	imul   rcx,rax
    28d4:	imul   rdx,rax
    28d8:	imul   r11,rax
    28dc:	imul   r10,rax
    28e0:	imul   r9,rax
    28e4:	imul   r8,rax
    28e8:	imul   rcx,rax
    28ec:	imul   rdx,rax
    28f0:	imul   r11,rax
    28f4:	imul   r10,rax
    28f8:	imul   r9,rax
    28fc:	imul   r8,rax
    2900:	imul   rcx,rax
    2904:	imul   rdx,rax
    2908:	imul   r11,rax
    290c:	imul   r10,rax
    2910:	imul   r9,rax
    2914:	imul   r8,rax
    2918:	imul   rcx,rax
    291c:	imul   rdx,rax
    2920:	imul   r11,rax
    2924:	imul   r10,rax
    2928:	imul   r9,rax
    292c:	imul   r8,rax
    2930:	inc    rsi
    2933:	cmp    rdi,rsi
    2936:	jne    2870 <void int_imul<6>(unsigned long)+0x40>
    293c:	ret
    293d:	nop    DWORD PTR [rax]

0000000000002940 <void int_imul<8>(unsigned long)>:
    2940:	endbr64
    2944:	push   rbp
    2945:	push   rbx
    2946:	test   rdi,rdi
    2949:	je     2a97 <void int_imul<8>(unsigned long)+0x157>
    294f:	mov    rbp,rdi
    2952:	mov    r11d,0x8
    2958:	mov    ebx,0x7
    295d:	mov    edx,0x6
    2962:	mov    ecx,0x5
    2967:	mov    edi,0x4
    296c:	mov    r8d,0x3
    2972:	mov    r9d,0x2
    2978:	mov    r10d,0x1
    297e:	xor    esi,esi
    2980:	mov    eax,0x3
    2985:	nop    DWORD PTR [rax]
    2988:	imul   r10,rax
    298c:	imul   r9,rax
    2990:	imul   r8,rax
    2994:	imul   rdi,rax
    2998:	imul   rcx,rax
    299c:	imul   rdx,rax
    29a0:	imul   rbx,rax
    29a4:	imul   r11,rax
    29a8:	imul   r10,rax
    29ac:	imul   r9,rax
    29b0:	imul   r8,rax
    29b4:	imul   rdi,rax
    29b8:	imul   rcx,rax
    29bc:	imul   rdx,rax
    29c0:	imul   rbx,rax
    29c4:	imul   r11,rax
    29c8:	imul   r10,rax
    29cc:	imul   r9,rax
    29d0:	imul   r8,rax
    29d4:	imul   rdi,rax
    29d8:	imul   rcx,rax
    29dc:	imul   rdx,rax
    29e0:	imul   rbx,rax
    29e4:	imul   r11,rax
    29e8:	imul   r10,rax
    29ec:	imul   r9,rax
    29f0:	imul   r8,rax
    29f4:	imul   rdi,rax
    29f8:	imul   rcx,rax
    29fc:	imul   rdx,rax
    2a00:	imul   rbx,rax
    2a04:	imul   r11,rax
    2a08:	imul   r10,rax
    2a0c:	imul   r9,rax
    2a10:	imul   r8,rax
    2a14:	imul   rdi,rax
    2a18:	imul   rcx,rax
    2a1c:	imul   rdx,rax
    2a20:	imul   rbx,rax
    2a24:	imul   r11,rax
    2a28:	imul   r10,rax
    2a2c:	imul   r9,rax
    2a30:	imul   r8,rax
    2a34:	imul   rdi,rax
    2a38:	imul   rcx,rax
    2a3c:	imul   rdx,rax
    2a40:	imul   rbx,rax
    2a44:	imul   r11,rax
    2a48:	imul   r10,rax
    2a4c:	imul   r9,rax
    2a50:	imul   r8,rax
    2a54:	imul   rdi,rax
    2a58:	imul   rcx,rax
    2a5c:	imul   rdx,rax
    2a60:	imul   rbx,rax
    2a64:	imul   r11,rax
    2a68:	imul   r10,rax
    2a6c:	imul   r9,rax
    2a70:	imul   r8,rax
    2a74:	imul   rdi,rax
    2a78:	imul   rcx,rax
    2a7c:	imul   rdx,rax
    2a80:	imul   rbx,rax
    2a84:	imul   r11,rax
    2a88:	inc    rsi
    2a8b:	cmp    rbp,rsi
    2a8e:	jne    2988 <void int_imul<8>(unsigned long)+0x48>
    2a94:	pop    rbx
    2a95:	pop    rbp
    2a96:	ret
    2a97:	mov    r11d,0x8
    2a9d:	mov    ebx,0x7
    2aa2:	mov    edx,0x6
    2aa7:	mov    ecx,0x5
    2aac:	mov    edi,0x4
    2ab1:	mov    r8d,0x3
    2ab7:	mov    r9d,0x2
    2abd:	mov    r10d,0x1
    2ac3:	pop    rbx
    2ac4:	pop    rbp
    2ac5:	ret
    2ac6:	cs nop WORD PTR [rax+rax*1+0x0]

0000000000002ad0 <void int_imul<10>(unsigned long)>:
    2ad0:	endbr64
    2ad4:	push   r13
    2ad6:	push   r12
    2ad8:	push   rbp
    2ad9:	push   rbx
    2ada:	test   rdi,rdi
    2add:	je     2c7b <void int_imul<10>(unsigned long)+0x1ab>
    2ae3:	mov    r13,rdi
    2ae6:	mov    r9d,0xa
    2aec:	mov    r10d,0x9
    2af2:	mov    r11d,0x8
    2af8:	mov    ebx,0x7
    2afd:	mov    ebp,0x6
    2b02:	mov    r12d,0x5
    2b08:	mov    edx,0x4
    2b0d:	mov    ecx,0x3
    2b12:	mov    edi,0x2
    2b17:	mov    r8d,0x1
    2b1d:	xor    esi,esi
    2b1f:	mov    eax,0x3
    2b24:	nop    DWORD PTR [rax+0x0]
    2b28:	imul   r8,rax
    2b2c:	imul   rdi,rax
    2b30:	imul   rcx,rax
    2b34:	imul   rdx,rax
    2b38:	imul   r12,rax
    2b3c:	imul   rbp,rax
    2b40:	imul   rbx,rax
    2b44:	imul   r11,rax
    2b48:	imul   r10,rax
    2b4c:	imul   r9,rax
    2b50:	imul   r8,rax
    2b54:	imul   rdi,rax
    2b58:	imul   rcx,rax
    2b5c:	imul   rdx,rax
    2b60:	imul   r12,rax
    2b64:	imul   rbp,rax
    2b68:	imul   rbx,rax
    2b6c:	imul   r11,rax
    2b70:	imul   r10,rax
    2b74:	imul   r9,rax
    2b78:	imul   r8,rax
    2b7c:	imul   rdi,rax
    2b80:	imul   rcx,rax
    2b84:	imul   rdx,rax
    2b88:	imul   r12,rax
    2b8c:	imul   rbp,rax
    2b90:	imul   rbx,rax
    2b94:	imul   r11,rax
    2b98:	imul   r10,rax
    2b9c:	imul   r9,rax
    2ba0:	imul   r8,rax
    2ba4:	imul   rdi,rax
    2ba8:	imul   rcx,rax
    2bac:	imul   rdx,rax
    2bb0:	imul   r12,rax
    2bb4:	imul   rbp,rax
    2bb8:	imul   rbx,rax
    2bbc:	imul   r11,rax
    2bc0:	imul   r10,rax
    2bc4:	imul   r9,rax
    2bc8:	imul   r8,rax
    2bcc:	imul   rdi,rax
    2bd0:	imul   rcx,rax
    2bd4:	imul   rdx,rax
    2bd8:	imul   r12,rax
    2bdc:	imul   rbp,rax
    2be0:	imul   rbx,rax
    2be4:	imul   r11,rax
    2be8:	imul   r10,rax
    2bec:	imul   r9,rax
    2bf0:	imul   r8,rax
    2bf4:	imul   rdi,rax
    2bf8:	imul   rcx,rax
    2bfc:	imul   rdx,rax
    2c00:	imul   r12,rax
    2c04:	imul   rbp,rax
    2c08:	imul   rbx,rax
    2c0c:	imul   r11,rax
    2c10:	imul   r10,rax
    2c14:	imul   r9,rax
    2c18:	imul   r8,rax
    2c1c:	imul   rdi,rax
    2c20:	imul   rcx,rax
    2c24:	imul   rdx,rax
    2c28:	imul   r12,rax
    2c2c:	imul   rbp,rax
    2c30:	imul   rbx,rax
    2c34:	imul   r11,rax
    2c38:	imul   r10,rax
    2c3c:	imul   r9,rax
    2c40:	imul   r8,rax
    2c44:	imul   rdi,rax
    2c48:	imul   rcx,rax
    2c4c:	imul   rdx,rax
    2c50:	imul   r12,rax
    2c54:	imul   rbp,rax
    2c58:	imul   rbx,rax
    2c5c:	imul   r11,rax
    2c60:	imul   r10,rax
    2c64:	imul   r9,rax
    2c68:	inc    rsi
    2c6b:	cmp    r13,rsi
    2c6e:	jne    2b28 <void int_imul<10>(unsigned long)+0x58>
    2c74:	pop    rbx
    2c75:	pop    rbp
    2c76:	pop    r12
    2c78:	pop    r13
    2c7a:	ret
    2c7b:	mov    r9d,0xa
    2c81:	mov    r10d,0x9
    2c87:	mov    r11d,0x8
    2c8d:	mov    ebx,0x7
    2c92:	mov    ebp,0x6
    2c97:	mov    r12d,0x5
    2c9d:	mov    edx,0x4
    2ca2:	mov    ecx,0x3
    2ca7:	mov    edi,0x2
    2cac:	mov    r8d,0x1
    2cb2:	pop    rbx
    2cb3:	pop    rbp
    2cb4:	pop    r12
    2cb6:	pop    r13
    2cb8:	ret
    2cb9:	nop    DWORD PTR [rax+0x0]

0000000000002cc0 <void int_imul<12>(unsigned long)>:
    2cc0:	endbr64
    2cc4:	push   r15
    2cc6:	push   r14
    2cc8:	push   r13
    2cca:	push   r12
    2ccc:	push   rbp
    2ccd:	push   rbx
    2cce:	test   rdi,rdi
    2cd1:	je     2ebf <void int_imul<12>(unsigned long)+0x1ff>
    2cd7:	mov    r15,rdi
    2cda:	mov    esi,0xc
    2cdf:	mov    edi,0xb
    2ce4:	mov    r8d,0xa
    2cea:	mov    r9d,0x9
    2cf0:	mov    r11d,0x8
    2cf6:	mov    ebx,0x7
    2cfb:	mov    ebp,0x6
    2d00:	mov    r12d,0x5
    2d06:	mov    r13d,0x4
    2d0c:	mov    r14d,0x3
    2d12:	mov    edx,0x2
    2d17:	mov    ecx,0x1
    2d1c:	xor    r10d,r10d
    2d1f:	mov    eax,0x3
    2d24:	nop    DWORD PTR [rax+0x0]
    2d28:	imul   rcx,rax
    2d2c:	imul   rdx,rax
    2d30:	imul   r14,rax
    2d34:	imul   r13,rax
    2d38:	imul   r12,rax
    2d3c:	imul   rbp,rax
    2d40:	imul   rbx,rax
    2d44:	imul   r11,rax
    2d48:	imul   r9,rax
    2d4c:	imul   r8,rax
    2d50:	imul   rdi,rax
    2d54:	imul   rsi,rax
    2d58:	imul   rcx,rax
    2d5c:	imul   rdx,rax
    2d60:	imul   r14,rax
    2d64:	imul   r13,rax
    2d68:	imul   r12,rax
    2d6c:	imul   rbp,rax
    2d70:	imul   rbx,rax
    2d74:	imul   r11,rax
    2d78:	imul   r9,rax
    2d7c:	imul   r8,rax
    2d80:	imul   rdi,rax
    2d84:	imul   rsi,rax
    2d88:	imul   rcx,rax
    2d8c:	imul   rdx,rax
    2d90:	imul   r14,rax
    2d94:	imul   r13,rax
    2d98:	imul   r12,rax
    2d9c:	imul   rbp,rax
    2da0:	imul   rbx,rax
    2da4:	imul   r11,rax
    2da8:	imul   r9,rax
    2dac:	imul   r8,rax
    2db0:	imul   rdi,rax
    2db4:	imul   rsi,rax
    2db8:	imul   rcx,rax
    2dbc:	imul   rdx,rax
    2dc0:	imul   r14,rax
    2dc4:	imul   r13,rax
    2dc8:	imul   r12,rax
    2dcc:	imul   rbp,rax
    2dd0:	imul   rbx,rax
    2dd4:	imul   r11,rax
    2dd8:	imul   r9,rax
    2ddc:	imul   r8,rax
    2de0:	imul   rdi,rax
    2de4:	imul   rsi,rax
    2de8:	imul   rcx,rax
    2dec:	imul   rdx,rax
    2df0:	imul   r14,rax
    2df4:	imul   r13,rax
    2df8:	imul   r12,rax
    2dfc:	imul   rbp,rax
    2e00:	imul   rbx,rax
    2e04:	imul   r11,rax
    2e08:	imul   r9,rax
    2e0c:	imul   r8,rax
    2e10:	imul   rdi,rax
    2e14:	imul   rsi,rax
    2e18:	imul   rcx,rax
    2e1c:	imul   rdx,rax
    2e20:	imul   r14,rax
    2e24:	imul   r13,rax
    2e28:	imul   r12,rax
    2e2c:	imul   rbp,rax
    2e30:	imul   rbx,rax
    2e34:	imul   r11,rax
    2e38:	imul   r9,rax
    2e3c:	imul   r8,rax
    2e40:	imul   rdi,rax
    2e44:	imul   rsi,rax
    2e48:	imul   rcx,rax
    2e4c:	imul   rdx,rax
    2e50:	imul   r14,rax
    2e54:	imul   r13,rax
    2e58:	imul   r12,rax
    2e5c:	imul   rbp,rax
    2e60:	imul   rbx,rax
    2e64:	imul   r11,rax
    2e68:	imul   r9,rax
    2e6c:	imul   r8,rax
    2e70:	imul   rdi,rax
    2e74:	imul   rsi,rax
    2e78:	imul   rcx,rax
    2e7c:	imul   rdx,rax
    2e80:	imul   r14,rax
    2e84:	imul   r13,rax
    2e88:	imul   r12,rax
    2e8c:	imul   rbp,rax
    2e90:	imul   rbx,rax
    2e94:	imul   r11,rax
    2e98:	imul   r9,rax
    2e9c:	imul   r8,rax
    2ea0:	imul   rdi,rax
    2ea4:	imul   rsi,rax
    2ea8:	inc    r10
    2eab:	cmp    r15,r10
    2eae:	jne    2d28 <void int_imul<12>(unsigned long)+0x68>
    2eb4:	pop    rbx
    2eb5:	pop    rbp
    2eb6:	pop    r12
    2eb8:	pop    r13
    2eba:	pop    r14
    2ebc:	pop    r15
    2ebe:	ret
    2ebf:	mov    esi,0xc
    2ec4:	mov    edi,0xb
    2ec9:	mov    r8d,0xa
    2ecf:	mov    r9d,0x9
    2ed5:	mov    r11d,0x8
    2edb:	mov    ebx,0x7
    2ee0:	mov    ebp,0x6
    2ee5:	mov    r12d,0x5
    2eeb:	mov    r13d,0x4
    2ef1:	mov    r14d,0x3
    2ef7:	mov    edx,0x2
    2efc:	mov    ecx,0x1
    2f01:	pop    rbx
    2f02:	pop    rbp
    2f03:	pop    r12
    2f05:	pop    r13
    2f07:	pop    r14
    2f09:	pop    r15
    2f0b:	ret
    2f0c:	nop    DWORD PTR [rax+0x0]

0000000000002f10 <void fp32_scalar_add<1>(unsigned long)>:
    2f10:	endbr64
    2f14:	test   rdi,rdi
    2f17:	je     2f59 <void fp32_scalar_add<1>(unsigned long)+0x49>
    2f19:	vmovss xmm1,DWORD PTR [rip+0x72bf]        # a1e0 <K_VALUES+0x20>
    2f21:	xor    eax,eax
    2f23:	vmovss xmm2,DWORD PTR [rip+0x72c5]        # a1f0 <K_VALUES+0x30>
    2f2b:	vmovaps xmm0,xmm1
    2f2f:	nop
    2f30:	vaddss xmm0,xmm0,xmm2
    2f34:	vaddss xmm0,xmm0,xmm2
    2f38:	vaddss xmm0,xmm0,xmm2
    2f3c:	vaddss xmm0,xmm0,xmm2
    2f40:	vaddss xmm0,xmm0,xmm2
    2f44:	vaddss xmm0,xmm0,xmm2
    2f48:	vaddss xmm0,xmm0,xmm2
    2f4c:	vaddss xmm0,xmm0,xmm2
    2f50:	inc    rax
    2f53:	cmp    rdi,rax
    2f56:	jne    2f30 <void fp32_scalar_add<1>(unsigned long)+0x20>
    2f58:	ret
    2f59:	vmovss xmm0,DWORD PTR [rip+0x727f]        # a1e0 <K_VALUES+0x20>
    2f61:	ret
    2f62:	data16 cs nop WORD PTR [rax+rax*1+0x0]
    2f6d:	nop    DWORD PTR [rax]

0000000000002f70 <void fp32_scalar_add<2>(unsigned long)>:
    2f70:	endbr64
    2f74:	test   rdi,rdi
    2f77:	je     2fe1 <void fp32_scalar_add<2>(unsigned long)+0x71>
    2f79:	vmovss xmm2,DWORD PTR [rip+0x725f]        # a1e0 <K_VALUES+0x20>
    2f81:	xor    eax,eax
    2f83:	vmovss xmm3,DWORD PTR [rip+0x7265]        # a1f0 <K_VALUES+0x30>
    2f8b:	vmovaps xmm0,xmm2
    2f8f:	vmovaps xmm1,xmm2
    2f93:	nop    DWORD PTR [rax+rax*1+0x0]
    2f98:	vaddss xmm1,xmm1,xmm3
    2f9c:	vaddss xmm0,xmm0,xmm3
    2fa0:	vaddss xmm1,xmm1,xmm3
    2fa4:	vaddss xmm0,xmm0,xmm3
    2fa8:	vaddss xmm1,xmm1,xmm3
    2fac:	vaddss xmm0,xmm0,xmm3
    2fb0:	vaddss xmm1,xmm1,xmm3
    2fb4:	vaddss xmm0,xmm0,xmm3
    2fb8:	vaddss xmm1,xmm1,xmm3
    2fbc:	vaddss xmm0,xmm0,xmm3
    2fc0:	vaddss xmm1,xmm1,xmm3
    2fc4:	vaddss xmm0,xmm0,xmm3
    2fc8:	vaddss xmm1,xmm1,xmm3
    2fcc:	vaddss xmm0,xmm0,xmm3
    2fd0:	vaddss xmm1,xmm1,xmm3
    2fd4:	vaddss xmm0,xmm0,xmm3
    2fd8:	inc    rax
    2fdb:	cmp    rdi,rax
    2fde:	jne    2f98 <void fp32_scalar_add<2>(unsigned long)+0x28>
    2fe0:	ret
    2fe1:	vmovss xmm0,DWORD PTR [rip+0x71f7]        # a1e0 <K_VALUES+0x20>
    2fe9:	vmovaps xmm1,xmm0
    2fed:	ret
    2fee:	xchg   ax,ax

0000000000002ff0 <void fp32_scalar_add<4>(unsigned long)>:
    2ff0:	endbr64
    2ff4:	test   rdi,rdi
    2ff7:	je     30ad <void fp32_scalar_add<4>(unsigned long)+0xbd>
    2ffd:	vmovss xmm4,DWORD PTR [rip+0x71db]        # a1e0 <K_VALUES+0x20>
    3005:	xor    eax,eax
    3007:	vmovss xmm5,DWORD PTR [rip+0x71e1]        # a1f0 <K_VALUES+0x30>
    300f:	vmovaps xmm0,xmm4
    3013:	vmovaps xmm1,xmm4
    3017:	vmovaps xmm2,xmm4
    301b:	vmovaps xmm3,xmm4
    301f:	nop
    3020:	vaddss xmm3,xmm3,xmm5
    3024:	vaddss xmm2,xmm2,xmm5
    3028:	vaddss xmm1,xmm1,xmm5
    302c:	vaddss xmm0,xmm0,xmm5
    3030:	vaddss xmm3,xmm3,xmm5
    3034:	vaddss xmm2,xmm2,xmm5
    3038:	vaddss xmm1,xmm1,xmm5
    303c:	vaddss xmm0,xmm0,xmm5
    3040:	vaddss xmm3,xmm3,xmm5
    3044:	vaddss xmm2,xmm2,xmm5
    3048:	vaddss xmm1,xmm1,xmm5
    304c:	vaddss xmm0,xmm0,xmm5
    3050:	vaddss xmm3,xmm3,xmm5
    3054:	vaddss xmm2,xmm2,xmm5
    3058:	vaddss xmm1,xmm1,xmm5
    305c:	vaddss xmm0,xmm0,xmm5
    3060:	vaddss xmm3,xmm3,xmm5
    3064:	vaddss xmm2,xmm2,xmm5
    3068:	vaddss xmm1,xmm1,xmm5
    306c:	vaddss xmm0,xmm0,xmm5
    3070:	vaddss xmm3,xmm3,xmm5
    3074:	vaddss xmm2,xmm2,xmm5
    3078:	vaddss xmm1,xmm1,xmm5
    307c:	vaddss xmm0,xmm0,xmm5
    3080:	vaddss xmm3,xmm3,xmm5
    3084:	vaddss xmm2,xmm2,xmm5
    3088:	vaddss xmm1,xmm1,xmm5
    308c:	vaddss xmm0,xmm0,xmm5
    3090:	vaddss xmm3,xmm3,xmm5
    3094:	vaddss xmm2,xmm2,xmm5
    3098:	vaddss xmm1,xmm1,xmm5
    309c:	vaddss xmm0,xmm0,xmm5
    30a0:	inc    rax
    30a3:	cmp    rdi,rax
    30a6:	jne    3020 <void fp32_scalar_add<4>(unsigned long)+0x30>
    30ac:	ret
    30ad:	vmovss xmm0,DWORD PTR [rip+0x712b]        # a1e0 <K_VALUES+0x20>
    30b5:	vmovaps xmm1,xmm0
    30b9:	vmovaps xmm2,xmm0
    30bd:	vmovaps xmm3,xmm0
    30c1:	ret
    30c2:	data16 cs nop WORD PTR [rax+rax*1+0x0]
    30cd:	nop    DWORD PTR [rax]

00000000000030d0 <void fp32_scalar_add<6>(unsigned long)>:
    30d0:	endbr64
    30d4:	test   rdi,rdi
    30d7:	je     31dd <void fp32_scalar_add<6>(unsigned long)+0x10d>
    30dd:	vmovss xmm0,DWORD PTR [rip+0x70fb]        # a1e0 <K_VALUES+0x20>
    30e5:	xor    eax,eax
    30e7:	vmovss xmm1,DWORD PTR [rip+0x7101]        # a1f0 <K_VALUES+0x30>
    30ef:	vmovaps xmm2,xmm0
    30f3:	vmovaps xmm3,xmm0
    30f7:	vmovaps xmm4,xmm0
    30fb:	vmovaps xmm5,xmm0
    30ff:	vmovaps xmm6,xmm0
    3103:	vmovaps xmm7,xmm0
    3107:	nop    WORD PTR [rax+rax*1+0x0]
    3110:	vaddss xmm7,xmm7,xmm1
    3114:	vaddss xmm6,xmm6,xmm1
    3118:	vaddss xmm5,xmm5,xmm1
    311c:	vaddss xmm4,xmm4,xmm1
    3120:	vaddss xmm3,xmm3,xmm1
    3124:	vaddss xmm2,xmm2,xmm1
    3128:	vaddss xmm7,xmm7,xmm1
    312c:	vaddss xmm6,xmm6,xmm1
    3130:	vaddss xmm5,xmm5,xmm1
    3134:	vaddss xmm4,xmm4,xmm1
    3138:	vaddss xmm3,xmm3,xmm1
    313c:	vaddss xmm2,xmm2,xmm1
    3140:	vaddss xmm7,xmm7,xmm1
    3144:	vaddss xmm6,xmm6,xmm1
    3148:	vaddss xmm5,xmm5,xmm1
    314c:	vaddss xmm4,xmm4,xmm1
    3150:	vaddss xmm3,xmm3,xmm1
    3154:	vaddss xmm2,xmm2,xmm1
    3158:	vaddss xmm7,xmm7,xmm1
    315c:	vaddss xmm6,xmm6,xmm1
    3160:	vaddss xmm5,xmm5,xmm1
    3164:	vaddss xmm4,xmm4,xmm1
    3168:	vaddss xmm3,xmm3,xmm1
    316c:	vaddss xmm2,xmm2,xmm1
    3170:	vaddss xmm7,xmm7,xmm1
    3174:	vaddss xmm6,xmm6,xmm1
    3178:	vaddss xmm5,xmm5,xmm1
    317c:	vaddss xmm4,xmm4,xmm1
    3180:	vaddss xmm3,xmm3,xmm1
    3184:	vaddss xmm2,xmm2,xmm1
    3188:	vaddss xmm7,xmm7,xmm1
    318c:	vaddss xmm6,xmm6,xmm1
    3190:	vaddss xmm5,xmm5,xmm1
    3194:	vaddss xmm4,xmm4,xmm1
    3198:	vaddss xmm3,xmm3,xmm1
    319c:	vaddss xmm2,xmm2,xmm1
    31a0:	vaddss xmm7,xmm7,xmm1
    31a4:	vaddss xmm6,xmm6,xmm1
    31a8:	vaddss xmm5,xmm5,xmm1
    31ac:	vaddss xmm4,xmm4,xmm1
    31b0:	vaddss xmm3,xmm3,xmm1
    31b4:	vaddss xmm2,xmm2,xmm1
    31b8:	vaddss xmm7,xmm7,xmm1
    31bc:	vaddss xmm6,xmm6,xmm1
    31c0:	vaddss xmm5,xmm5,xmm1
    31c4:	vaddss xmm4,xmm4,xmm1
    31c8:	vaddss xmm3,xmm3,xmm1
    31cc:	vaddss xmm2,xmm2,xmm1
    31d0:	inc    rax
    31d3:	cmp    rdi,rax
    31d6:	jne    3110 <void fp32_scalar_add<6>(unsigned long)+0x40>
    31dc:	ret
    31dd:	vmovss xmm2,DWORD PTR [rip+0x6ffb]        # a1e0 <K_VALUES+0x20>
    31e5:	vmovaps xmm3,xmm2
    31e9:	vmovaps xmm4,xmm2
    31ed:	vmovaps xmm5,xmm2
    31f1:	vmovaps xmm6,xmm2
    31f5:	vmovaps xmm7,xmm2
    31f9:	ret
    31fa:	nop    WORD PTR [rax+rax*1+0x0]

0000000000003200 <void fp32_scalar_add<8>(unsigned long)>:
    3200:	endbr64
    3204:	test   rdi,rdi
    3207:	je     334d <void fp32_scalar_add<8>(unsigned long)+0x14d>
    320d:	vmovss xmm0,DWORD PTR [rip+0x6fcb]        # a1e0 <K_VALUES+0x20>
    3215:	xor    eax,eax
    3217:	vmovss xmm1,DWORD PTR [rip+0x6fd1]        # a1f0 <K_VALUES+0x30>
    321f:	vmovaps xmm2,xmm0
    3223:	vmovaps xmm3,xmm0
    3227:	vmovaps xmm4,xmm0
    322b:	vmovaps xmm5,xmm0
    322f:	vmovaps xmm6,xmm0
    3233:	vmovaps xmm7,xmm0
    3237:	vmovaps xmm8,xmm0
    323b:	vmovaps xmm9,xmm0
    323f:	nop
    3240:	vaddss xmm9,xmm9,xmm1
    3244:	vaddss xmm8,xmm8,xmm1
    3248:	vaddss xmm7,xmm7,xmm1
    324c:	vaddss xmm6,xmm6,xmm1
    3250:	vaddss xmm5,xmm5,xmm1
    3254:	vaddss xmm4,xmm4,xmm1
    3258:	vaddss xmm3,xmm3,xmm1
    325c:	vaddss xmm2,xmm2,xmm1
    3260:	vaddss xmm9,xmm9,xmm1
    3264:	vaddss xmm8,xmm8,xmm1
    3268:	vaddss xmm7,xmm7,xmm1
    326c:	vaddss xmm6,xmm6,xmm1
    3270:	vaddss xmm5,xmm5,xmm1
    3274:	vaddss xmm4,xmm4,xmm1
    3278:	vaddss xmm3,xmm3,xmm1
    327c:	vaddss xmm2,xmm2,xmm1
    3280:	vaddss xmm9,xmm9,xmm1
    3284:	vaddss xmm8,xmm8,xmm1
    3288:	vaddss xmm7,xmm7,xmm1
    328c:	vaddss xmm6,xmm6,xmm1
    3290:	vaddss xmm5,xmm5,xmm1
    3294:	vaddss xmm4,xmm4,xmm1
    3298:	vaddss xmm3,xmm3,xmm1
    329c:	vaddss xmm2,xmm2,xmm1
    32a0:	vaddss xmm9,xmm9,xmm1
    32a4:	vaddss xmm8,xmm8,xmm1
    32a8:	vaddss xmm7,xmm7,xmm1
    32ac:	vaddss xmm6,xmm6,xmm1
    32b0:	vaddss xmm5,xmm5,xmm1
    32b4:	vaddss xmm4,xmm4,xmm1
    32b8:	vaddss xmm3,xmm3,xmm1
    32bc:	vaddss xmm2,xmm2,xmm1
    32c0:	vaddss xmm9,xmm9,xmm1
    32c4:	vaddss xmm8,xmm8,xmm1
    32c8:	vaddss xmm7,xmm7,xmm1
    32cc:	vaddss xmm6,xmm6,xmm1
    32d0:	vaddss xmm5,xmm5,xmm1
    32d4:	vaddss xmm4,xmm4,xmm1
    32d8:	vaddss xmm3,xmm3,xmm1
    32dc:	vaddss xmm2,xmm2,xmm1
    32e0:	vaddss xmm9,xmm9,xmm1
    32e4:	vaddss xmm8,xmm8,xmm1
    32e8:	vaddss xmm7,xmm7,xmm1
    32ec:	vaddss xmm6,xmm6,xmm1
    32f0:	vaddss xmm5,xmm5,xmm1
    32f4:	vaddss xmm4,xmm4,xmm1
    32f8:	vaddss xmm3,xmm3,xmm1
    32fc:	vaddss xmm2,xmm2,xmm1
    3300:	vaddss xmm9,xmm9,xmm1
    3304:	vaddss xmm8,xmm8,xmm1
    3308:	vaddss xmm7,xmm7,xmm1
    330c:	vaddss xmm6,xmm6,xmm1
    3310:	vaddss xmm5,xmm5,xmm1
    3314:	vaddss xmm4,xmm4,xmm1
    3318:	vaddss xmm3,xmm3,xmm1
    331c:	vaddss xmm2,xmm2,xmm1
    3320:	vaddss xmm9,xmm9,xmm1
    3324:	vaddss xmm8,xmm8,xmm1
    3328:	vaddss xmm7,xmm7,xmm1
    332c:	vaddss xmm6,xmm6,xmm1
    3330:	vaddss xmm5,xmm5,xmm1
    3334:	vaddss xmm4,xmm4,xmm1
    3338:	vaddss xmm3,xmm3,xmm1
    333c:	vaddss xmm2,xmm2,xmm1
    3340:	inc    rax
    3343:	cmp    rdi,rax
    3346:	jne    3240 <void fp32_scalar_add<8>(unsigned long)+0x40>
    334c:	ret
    334d:	vmovss xmm2,DWORD PTR [rip+0x6e8b]        # a1e0 <K_VALUES+0x20>
    3355:	vmovaps xmm3,xmm2
    3359:	vmovaps xmm4,xmm2
    335d:	vmovaps xmm5,xmm2
    3361:	vmovaps xmm6,xmm2
    3365:	vmovaps xmm7,xmm2
    3369:	vmovaps xmm8,xmm2
    336d:	vmovaps xmm9,xmm2
    3371:	ret
    3372:	data16 cs nop WORD PTR [rax+rax*1+0x0]
    337d:	nop    DWORD PTR [rax]

0000000000003380 <void fp32_scalar_add<10>(unsigned long)>:
    3380:	endbr64
    3384:	test   rdi,rdi
    3387:	je     351d <void fp32_scalar_add<10>(unsigned long)+0x19d>
    338d:	vmovss xmm0,DWORD PTR [rip+0x6e4b]        # a1e0 <K_VALUES+0x20>
    3395:	xor    eax,eax
    3397:	vmovss xmm1,DWORD PTR [rip+0x6e51]        # a1f0 <K_VALUES+0x30>
    339f:	vmovaps xmm2,xmm0
    33a3:	vmovaps xmm3,xmm0
    33a7:	vmovaps xmm4,xmm0
    33ab:	vmovaps xmm5,xmm0
    33af:	vmovaps xmm6,xmm0
    33b3:	vmovaps xmm7,xmm0
    33b7:	vmovaps xmm8,xmm0
    33bb:	vmovaps xmm9,xmm0
    33bf:	vmovaps xmm10,xmm0
    33c3:	vmovaps xmm11,xmm0
    33c7:	nop    WORD PTR [rax+rax*1+0x0]
    33d0:	vaddss xmm11,xmm11,xmm1
    33d4:	vaddss xmm10,xmm10,xmm1
    33d8:	vaddss xmm9,xmm9,xmm1
    33dc:	vaddss xmm8,xmm8,xmm1
    33e0:	vaddss xmm7,xmm7,xmm1
    33e4:	vaddss xmm6,xmm6,xmm1
    33e8:	vaddss xmm5,xmm5,xmm1
    33ec:	vaddss xmm4,xmm4,xmm1
    33f0:	vaddss xmm3,xmm3,xmm1
    33f4:	vaddss xmm2,xmm2,xmm1
    33f8:	vaddss xmm11,xmm11,xmm1
    33fc:	vaddss xmm10,xmm10,xmm1
    3400:	vaddss xmm9,xmm9,xmm1
    3404:	vaddss xmm8,xmm8,xmm1
    3408:	vaddss xmm7,xmm7,xmm1
    340c:	vaddss xmm6,xmm6,xmm1
    3410:	vaddss xmm5,xmm5,xmm1
    3414:	vaddss xmm4,xmm4,xmm1
    3418:	vaddss xmm3,xmm3,xmm1
    341c:	vaddss xmm2,xmm2,xmm1
    3420:	vaddss xmm11,xmm11,xmm1
    3424:	vaddss xmm10,xmm10,xmm1
    3428:	vaddss xmm9,xmm9,xmm1
    342c:	vaddss xmm8,xmm8,xmm1
    3430:	vaddss xmm7,xmm7,xmm1
    3434:	vaddss xmm6,xmm6,xmm1
    3438:	vaddss xmm5,xmm5,xmm1
    343c:	vaddss xmm4,xmm4,xmm1
    3440:	vaddss xmm3,xmm3,xmm1
    3444:	vaddss xmm2,xmm2,xmm1
    3448:	vaddss xmm11,xmm11,xmm1
    344c:	vaddss xmm10,xmm10,xmm1
    3450:	vaddss xmm9,xmm9,xmm1
    3454:	vaddss xmm8,xmm8,xmm1
    3458:	vaddss xmm7,xmm7,xmm1
    345c:	vaddss xmm6,xmm6,xmm1
    3460:	vaddss xmm5,xmm5,xmm1
    3464:	vaddss xmm4,xmm4,xmm1
    3468:	vaddss xmm3,xmm3,xmm1
    346c:	vaddss xmm2,xmm2,xmm1
    3470:	vaddss xmm11,xmm11,xmm1
    3474:	vaddss xmm10,xmm10,xmm1
    3478:	vaddss xmm9,xmm9,xmm1
    347c:	vaddss xmm8,xmm8,xmm1
    3480:	vaddss xmm7,xmm7,xmm1
    3484:	vaddss xmm6,xmm6,xmm1
    3488:	vaddss xmm5,xmm5,xmm1
    348c:	vaddss xmm4,xmm4,xmm1
    3490:	vaddss xmm3,xmm3,xmm1
    3494:	vaddss xmm2,xmm2,xmm1
    3498:	vaddss xmm11,xmm11,xmm1
    349c:	vaddss xmm10,xmm10,xmm1
    34a0:	vaddss xmm9,xmm9,xmm1
    34a4:	vaddss xmm8,xmm8,xmm1
    34a8:	vaddss xmm7,xmm7,xmm1
    34ac:	vaddss xmm6,xmm6,xmm1
    34b0:	vaddss xmm5,xmm5,xmm1
    34b4:	vaddss xmm4,xmm4,xmm1
    34b8:	vaddss xmm3,xmm3,xmm1
    34bc:	vaddss xmm2,xmm2,xmm1
    34c0:	vaddss xmm11,xmm11,xmm1
    34c4:	vaddss xmm10,xmm10,xmm1
    34c8:	vaddss xmm9,xmm9,xmm1
    34cc:	vaddss xmm8,xmm8,xmm1
    34d0:	vaddss xmm7,xmm7,xmm1
    34d4:	vaddss xmm6,xmm6,xmm1
    34d8:	vaddss xmm5,xmm5,xmm1
    34dc:	vaddss xmm4,xmm4,xmm1
    34e0:	vaddss xmm3,xmm3,xmm1
    34e4:	vaddss xmm2,xmm2,xmm1
    34e8:	vaddss xmm11,xmm11,xmm1
    34ec:	vaddss xmm10,xmm10,xmm1
    34f0:	vaddss xmm9,xmm9,xmm1
    34f4:	vaddss xmm8,xmm8,xmm1
    34f8:	vaddss xmm7,xmm7,xmm1
    34fc:	vaddss xmm6,xmm6,xmm1
    3500:	vaddss xmm5,xmm5,xmm1
    3504:	vaddss xmm4,xmm4,xmm1
    3508:	vaddss xmm3,xmm3,xmm1
    350c:	vaddss xmm2,xmm2,xmm1
    3510:	inc    rax
    3513:	cmp    rdi,rax
    3516:	jne    33d0 <void fp32_scalar_add<10>(unsigned long)+0x50>
    351c:	ret
    351d:	vmovss xmm2,DWORD PTR [rip+0x6cbb]        # a1e0 <K_VALUES+0x20>
    3525:	vmovaps xmm3,xmm2
    3529:	vmovaps xmm4,xmm2
    352d:	vmovaps xmm5,xmm2
    3531:	vmovaps xmm6,xmm2
    3535:	vmovaps xmm7,xmm2
    3539:	vmovaps xmm8,xmm2
    353d:	vmovaps xmm9,xmm2
    3541:	vmovaps xmm10,xmm2
    3545:	vmovaps xmm11,xmm2
    3549:	ret
    354a:	nop    WORD PTR [rax+rax*1+0x0]

0000000000003550 <void fp32_scalar_add<12>(unsigned long)>:
    3550:	endbr64
    3554:	test   rdi,rdi
    3557:	je     372d <void fp32_scalar_add<12>(unsigned long)+0x1dd>
    355d:	vmovss xmm0,DWORD PTR [rip+0x6c7b]        # a1e0 <K_VALUES+0x20>
    3565:	xor    eax,eax
    3567:	vmovss xmm1,DWORD PTR [rip+0x6c81]        # a1f0 <K_VALUES+0x30>
    356f:	vmovaps xmm10,xmm0
    3573:	vmovaps xmm11,xmm0
    3577:	vmovaps xmm12,xmm0
    357b:	vmovaps xmm13,xmm0
    357f:	vmovaps xmm2,xmm0
    3583:	vmovaps xmm3,xmm0
    3587:	vmovaps xmm4,xmm0
    358b:	vmovaps xmm5,xmm0
    358f:	vmovaps xmm6,xmm0
    3593:	vmovaps xmm7,xmm0
    3597:	vmovaps xmm8,xmm0
    359b:	vmovaps xmm9,xmm0
    359f:	nop
    35a0:	vaddss xmm9,xmm9,xmm1
    35a4:	vaddss xmm8,xmm8,xmm1
    35a8:	vaddss xmm7,xmm7,xmm1
    35ac:	vaddss xmm6,xmm6,xmm1
    35b0:	vaddss xmm5,xmm5,xmm1
    35b4:	vaddss xmm4,xmm4,xmm1
    35b8:	vaddss xmm3,xmm3,xmm1
    35bc:	vaddss xmm2,xmm2,xmm1
    35c0:	vaddss xmm13,xmm13,xmm1
    35c4:	vaddss xmm12,xmm12,xmm1
    35c8:	vaddss xmm11,xmm11,xmm1
    35cc:	vaddss xmm10,xmm10,xmm1
    35d0:	vaddss xmm9,xmm9,xmm1
    35d4:	vaddss xmm8,xmm8,xmm1
    35d8:	vaddss xmm7,xmm7,xmm1
    35dc:	vaddss xmm6,xmm6,xmm1
    35e0:	vaddss xmm5,xmm5,xmm1
    35e4:	vaddss xmm4,xmm4,xmm1
    35e8:	vaddss xmm3,xmm3,xmm1
    35ec:	vaddss xmm2,xmm2,xmm1
    35f0:	vaddss xmm13,xmm13,xmm1
    35f4:	vaddss xmm12,xmm12,xmm1
    35f8:	vaddss xmm11,xmm11,xmm1
    35fc:	vaddss xmm10,xmm10,xmm1
    3600:	vaddss xmm9,xmm9,xmm1
    3604:	vaddss xmm8,xmm8,xmm1
    3608:	vaddss xmm7,xmm7,xmm1
    360c:	vaddss xmm6,xmm6,xmm1
    3610:	vaddss xmm5,xmm5,xmm1
    3614:	vaddss xmm4,xmm4,xmm1
    3618:	vaddss xmm3,xmm3,xmm1
    361c:	vaddss xmm2,xmm2,xmm1
    3620:	vaddss xmm13,xmm13,xmm1
    3624:	vaddss xmm12,xmm12,xmm1
    3628:	vaddss xmm11,xmm11,xmm1
    362c:	vaddss xmm10,xmm10,xmm1
    3630:	vaddss xmm9,xmm9,xmm1
    3634:	vaddss xmm8,xmm8,xmm1
    3638:	vaddss xmm7,xmm7,xmm1
    363c:	vaddss xmm6,xmm6,xmm1
    3640:	vaddss xmm5,xmm5,xmm1
    3644:	vaddss xmm4,xmm4,xmm1
    3648:	vaddss xmm3,xmm3,xmm1
    364c:	vaddss xmm2,xmm2,xmm1
    3650:	vaddss xmm13,xmm13,xmm1
    3654:	vaddss xmm12,xmm12,xmm1
    3658:	vaddss xmm11,xmm11,xmm1
    365c:	vaddss xmm10,xmm10,xmm1
    3660:	vaddss xmm9,xmm9,xmm1
    3664:	vaddss xmm8,xmm8,xmm1
    3668:	vaddss xmm7,xmm7,xmm1
    366c:	vaddss xmm6,xmm6,xmm1
    3670:	vaddss xmm5,xmm5,xmm1
    3674:	vaddss xmm4,xmm4,xmm1
    3678:	vaddss xmm3,xmm3,xmm1
    367c:	vaddss xmm2,xmm2,xmm1
    3680:	vaddss xmm13,xmm13,xmm1
    3684:	vaddss xmm12,xmm12,xmm1
    3688:	vaddss xmm11,xmm11,xmm1
    368c:	vaddss xmm10,xmm10,xmm1
    3690:	vaddss xmm9,xmm9,xmm1
    3694:	vaddss xmm8,xmm8,xmm1
    3698:	vaddss xmm7,xmm7,xmm1
    369c:	vaddss xmm6,xmm6,xmm1
    36a0:	vaddss xmm5,xmm5,xmm1
    36a4:	vaddss xmm4,xmm4,xmm1
    36a8:	vaddss xmm3,xmm3,xmm1
    36ac:	vaddss xmm2,xmm2,xmm1
    36b0:	vaddss xmm13,xmm13,xmm1
    36b4:	vaddss xmm12,xmm12,xmm1
    36b8:	vaddss xmm11,xmm11,xmm1
    36bc:	vaddss xmm10,xmm10,xmm1
    36c0:	vaddss xmm9,xmm9,xmm1
    36c4:	vaddss xmm8,xmm8,xmm1
    36c8:	vaddss xmm7,xmm7,xmm1
    36cc:	vaddss xmm6,xmm6,xmm1
    36d0:	vaddss xmm5,xmm5,xmm1
    36d4:	vaddss xmm4,xmm4,xmm1
    36d8:	vaddss xmm3,xmm3,xmm1
    36dc:	vaddss xmm2,xmm2,xmm1
    36e0:	vaddss xmm13,xmm13,xmm1
    36e4:	vaddss xmm12,xmm12,xmm1
    36e8:	vaddss xmm11,xmm11,xmm1
    36ec:	vaddss xmm10,xmm10,xmm1
    36f0:	vaddss xmm9,xmm9,xmm1
    36f4:	vaddss xmm8,xmm8,xmm1
    36f8:	vaddss xmm7,xmm7,xmm1
    36fc:	vaddss xmm6,xmm6,xmm1
    3700:	vaddss xmm5,xmm5,xmm1
    3704:	vaddss xmm4,xmm4,xmm1
    3708:	vaddss xmm3,xmm3,xmm1
    370c:	vaddss xmm2,xmm2,xmm1
    3710:	vaddss xmm13,xmm13,xmm1
    3714:	vaddss xmm12,xmm12,xmm1
    3718:	vaddss xmm11,xmm11,xmm1
    371c:	vaddss xmm10,xmm10,xmm1
    3720:	inc    rax
    3723:	cmp    rdi,rax
    3726:	jne    35a0 <void fp32_scalar_add<12>(unsigned long)+0x50>
    372c:	ret
    372d:	vmovss xmm10,DWORD PTR [rip+0x6aab]        # a1e0 <K_VALUES+0x20>
    3735:	vmovaps xmm11,xmm10
    373a:	vmovaps xmm12,xmm10
    373f:	vmovaps xmm13,xmm10
    3744:	vmovaps xmm2,xmm10
    3748:	vmovaps xmm3,xmm10
    374c:	vmovaps xmm4,xmm10
    3750:	vmovaps xmm5,xmm10
    3754:	vmovaps xmm6,xmm10
    3758:	vmovaps xmm7,xmm10
    375c:	vmovaps xmm8,xmm10
    3761:	vmovaps xmm9,xmm10
    3766:	ret
    3767:	nop    WORD PTR [rax+rax*1+0x0]

0000000000003770 <void fp32_scalar_add<16>(unsigned long)>:
    3770:	endbr64
    3774:	test   rdi,rdi
    3777:	je     3a05 <void fp32_scalar_add<16>(unsigned long)+0x295>
    377d:	vmovss xmm0,DWORD PTR [rip+0x6a5b]        # a1e0 <K_VALUES+0x20>
    3785:	xor    eax,eax
    3787:	vmovss xmm1,DWORD PTR [rip+0x6a61]        # a1f0 <K_VALUES+0x30>
    378f:	vmovaps xmm2,xmm0
    3793:	vmovaps xmm17,xmm0
    3799:	vmovaps xmm3,xmm0
    379d:	vmovaps xmm4,xmm0
    37a1:	vmovaps xmm5,xmm0
    37a5:	vmovaps xmm6,xmm0
    37a9:	vmovaps xmm7,xmm0
    37ad:	vmovaps xmm8,xmm0
    37b1:	vmovaps xmm9,xmm0
    37b5:	vmovaps xmm10,xmm0
    37b9:	vmovaps xmm11,xmm0
    37bd:	vmovaps xmm12,xmm0
    37c1:	vmovaps xmm13,xmm0
    37c5:	vmovaps xmm14,xmm0
    37c9:	vmovaps xmm15,xmm0
    37cd:	vmovaps xmm16,xmm0
    37d3:	nop    DWORD PTR [rax+rax*1+0x0]
    37d8:	vaddss xmm16,xmm16,xmm1
    37de:	vaddss xmm15,xmm15,xmm1
    37e2:	vaddss xmm14,xmm14,xmm1
    37e6:	vaddss xmm13,xmm13,xmm1
    37ea:	vaddss xmm12,xmm12,xmm1
    37ee:	vaddss xmm11,xmm11,xmm1
    37f2:	vaddss xmm10,xmm10,xmm1
    37f6:	vaddss xmm9,xmm9,xmm1
    37fa:	vaddss xmm8,xmm8,xmm1
    37fe:	vaddss xmm7,xmm7,xmm1
    3802:	vaddss xmm6,xmm6,xmm1
    3806:	vaddss xmm5,xmm5,xmm1
    380a:	vaddss xmm4,xmm4,xmm1
    380e:	vaddss xmm3,xmm3,xmm1
    3812:	vaddss xmm17,xmm17,xmm1
    3818:	vaddss xmm2,xmm2,xmm1
    381c:	vaddss xmm16,xmm16,xmm1
    3822:	vaddss xmm15,xmm15,xmm1
    3826:	vaddss xmm14,xmm14,xmm1
    382a:	vaddss xmm13,xmm13,xmm1
    382e:	vaddss xmm12,xmm12,xmm1
    3832:	vaddss xmm11,xmm11,xmm1
    3836:	vaddss xmm10,xmm10,xmm1
    383a:	vaddss xmm9,xmm9,xmm1
    383e:	vaddss xmm8,xmm8,xmm1
    3842:	vaddss xmm7,xmm7,xmm1
    3846:	vaddss xmm6,xmm6,xmm1
    384a:	vaddss xmm5,xmm5,xmm1
    384e:	vaddss xmm4,xmm4,xmm1
    3852:	vaddss xmm3,xmm3,xmm1
    3856:	vaddss xmm17,xmm17,xmm1
    385c:	vaddss xmm2,xmm2,xmm1
    3860:	vaddss xmm16,xmm16,xmm1
    3866:	vaddss xmm15,xmm15,xmm1
    386a:	vaddss xmm14,xmm14,xmm1
    386e:	vaddss xmm13,xmm13,xmm1
    3872:	vaddss xmm12,xmm12,xmm1
    3876:	vaddss xmm11,xmm11,xmm1
    387a:	vaddss xmm10,xmm10,xmm1
    387e:	vaddss xmm9,xmm9,xmm1
    3882:	vaddss xmm8,xmm8,xmm1
    3886:	vaddss xmm7,xmm7,xmm1
    388a:	vaddss xmm6,xmm6,xmm1
    388e:	vaddss xmm5,xmm5,xmm1
    3892:	vaddss xmm4,xmm4,xmm1
    3896:	vaddss xmm3,xmm3,xmm1
    389a:	vaddss xmm17,xmm17,xmm1
    38a0:	vaddss xmm2,xmm2,xmm1
    38a4:	vaddss xmm16,xmm16,xmm1
    38aa:	vaddss xmm15,xmm15,xmm1
    38ae:	vaddss xmm14,xmm14,xmm1
    38b2:	vaddss xmm13,xmm13,xmm1
    38b6:	vaddss xmm12,xmm12,xmm1
    38ba:	vaddss xmm11,xmm11,xmm1
    38be:	vaddss xmm10,xmm10,xmm1
    38c2:	vaddss xmm9,xmm9,xmm1
    38c6:	vaddss xmm8,xmm8,xmm1
    38ca:	vaddss xmm7,xmm7,xmm1
    38ce:	vaddss xmm6,xmm6,xmm1
    38d2:	vaddss xmm5,xmm5,xmm1
    38d6:	vaddss xmm4,xmm4,xmm1
    38da:	vaddss xmm3,xmm3,xmm1
    38de:	vaddss xmm17,xmm17,xmm1
    38e4:	vaddss xmm2,xmm2,xmm1
    38e8:	vaddss xmm16,xmm16,xmm1
    38ee:	vaddss xmm15,xmm15,xmm1
    38f2:	vaddss xmm14,xmm14,xmm1
    38f6:	vaddss xmm13,xmm13,xmm1
    38fa:	vaddss xmm12,xmm12,xmm1
    38fe:	vaddss xmm11,xmm11,xmm1
    3902:	vaddss xmm10,xmm10,xmm1
    3906:	vaddss xmm9,xmm9,xmm1
    390a:	vaddss xmm8,xmm8,xmm1
    390e:	vaddss xmm7,xmm7,xmm1
    3912:	vaddss xmm6,xmm6,xmm1
    3916:	vaddss xmm5,xmm5,xmm1
    391a:	vaddss xmm4,xmm4,xmm1
    391e:	vaddss xmm3,xmm3,xmm1
    3922:	vaddss xmm17,xmm17,xmm1
    3928:	vaddss xmm2,xmm2,xmm1
    392c:	vaddss xmm16,xmm16,xmm1
    3932:	vaddss xmm15,xmm15,xmm1
    3936:	vaddss xmm14,xmm14,xmm1
    393a:	vaddss xmm13,xmm13,xmm1
    393e:	vaddss xmm12,xmm12,xmm1
    3942:	vaddss xmm11,xmm11,xmm1
    3946:	vaddss xmm10,xmm10,xmm1
    394a:	vaddss xmm9,xmm9,xmm1
    394e:	vaddss xmm8,xmm8,xmm1
    3952:	vaddss xmm7,xmm7,xmm1
    3956:	vaddss xmm6,xmm6,xmm1
    395a:	vaddss xmm5,xmm5,xmm1
    395e:	vaddss xmm4,xmm4,xmm1
    3962:	vaddss xmm3,xmm3,xmm1
    3966:	vaddss xmm17,xmm17,xmm1
    396c:	vaddss xmm2,xmm2,xmm1
    3970:	vaddss xmm16,xmm16,xmm1
    3976:	vaddss xmm15,xmm15,xmm1
    397a:	vaddss xmm14,xmm14,xmm1
    397e:	vaddss xmm13,xmm13,xmm1
    3982:	vaddss xmm12,xmm12,xmm1
    3986:	vaddss xmm11,xmm11,xmm1
    398a:	vaddss xmm10,xmm10,xmm1
    398e:	vaddss xmm9,xmm9,xmm1
    3992:	vaddss xmm8,xmm8,xmm1
    3996:	vaddss xmm7,xmm7,xmm1
    399a:	vaddss xmm6,xmm6,xmm1
    399e:	vaddss xmm5,xmm5,xmm1
    39a2:	vaddss xmm4,xmm4,xmm1
    39a6:	vaddss xmm3,xmm3,xmm1
    39aa:	vaddss xmm17,xmm17,xmm1
    39b0:	vaddss xmm2,xmm2,xmm1
    39b4:	vaddss xmm16,xmm16,xmm1
    39ba:	vaddss xmm15,xmm15,xmm1
    39be:	vaddss xmm14,xmm14,xmm1
    39c2:	vaddss xmm13,xmm13,xmm1
    39c6:	vaddss xmm12,xmm12,xmm1
    39ca:	vaddss xmm11,xmm11,xmm1
    39ce:	vaddss xmm10,xmm10,xmm1
    39d2:	vaddss xmm9,xmm9,xmm1
    39d6:	vaddss xmm8,xmm8,xmm1
    39da:	vaddss xmm7,xmm7,xmm1
    39de:	vaddss xmm6,xmm6,xmm1
    39e2:	vaddss xmm5,xmm5,xmm1
    39e6:	vaddss xmm4,xmm4,xmm1
    39ea:	vaddss xmm3,xmm3,xmm1
    39ee:	vaddss xmm17,xmm17,xmm1
    39f4:	vaddss xmm2,xmm2,xmm1
    39f8:	inc    rax
    39fb:	cmp    rdi,rax
    39fe:	jne    37d8 <void fp32_scalar_add<16>(unsigned long)+0x68>
    3a04:	ret
    3a05:	vmovss xmm2,DWORD PTR [rip+0x67d3]        # a1e0 <K_VALUES+0x20>
    3a0d:	vmovaps xmm17,xmm2
    3a13:	vmovaps xmm3,xmm2
    3a17:	vmovaps xmm4,xmm2
    3a1b:	vmovaps xmm5,xmm2
    3a1f:	vmovaps xmm6,xmm2
    3a23:	vmovaps xmm7,xmm2
    3a27:	vmovaps xmm8,xmm2
    3a2b:	vmovaps xmm9,xmm2
    3a2f:	vmovaps xmm10,xmm2
    3a33:	vmovaps xmm11,xmm2
    3a37:	vmovaps xmm12,xmm2
    3a3b:	vmovaps xmm13,xmm2
    3a3f:	vmovaps xmm14,xmm2
    3a43:	vmovaps xmm15,xmm2
    3a47:	vmovaps xmm16,xmm2
    3a4d:	ret
    3a4e:	xchg   ax,ax

0000000000003a50 <void fp32_scalar_mul<1>(unsigned long)>:
    3a50:	endbr64
    3a54:	test   rdi,rdi
    3a57:	je     3a99 <void fp32_scalar_mul<1>(unsigned long)+0x49>
    3a59:	vmovss xmm1,DWORD PTR [rip+0x677f]        # a1e0 <K_VALUES+0x20>
    3a61:	xor    eax,eax
    3a63:	vmovss xmm2,DWORD PTR [rip+0x6785]        # a1f0 <K_VALUES+0x30>
    3a6b:	vmovaps xmm0,xmm1
    3a6f:	nop
    3a70:	vmulss xmm0,xmm0,xmm1
    3a74:	vmulss xmm0,xmm0,xmm1
    3a78:	vmulss xmm0,xmm0,xmm1
    3a7c:	vmulss xmm0,xmm0,xmm1
    3a80:	vmulss xmm0,xmm0,xmm1
    3a84:	vmulss xmm0,xmm0,xmm1
    3a88:	vmulss xmm0,xmm0,xmm1
    3a8c:	vmulss xmm0,xmm0,xmm1
    3a90:	inc    rax
    3a93:	cmp    rdi,rax
    3a96:	jne    3a70 <void fp32_scalar_mul<1>(unsigned long)+0x20>
    3a98:	ret
    3a99:	vmovss xmm0,DWORD PTR [rip+0x673f]        # a1e0 <K_VALUES+0x20>
    3aa1:	ret
    3aa2:	data16 cs nop WORD PTR [rax+rax*1+0x0]
    3aad:	nop    DWORD PTR [rax]

0000000000003ab0 <void fp32_scalar_mul<2>(unsigned long)>:
    3ab0:	endbr64
    3ab4:	test   rdi,rdi
    3ab7:	je     3b21 <void fp32_scalar_mul<2>(unsigned long)+0x71>
    3ab9:	vmovss xmm2,DWORD PTR [rip+0x671f]        # a1e0 <K_VALUES+0x20>
    3ac1:	xor    eax,eax
    3ac3:	vmovss xmm3,DWORD PTR [rip+0x6725]        # a1f0 <K_VALUES+0x30>
    3acb:	vmovaps xmm0,xmm2
    3acf:	vmovaps xmm1,xmm2
    3ad3:	nop    DWORD PTR [rax+rax*1+0x0]
    3ad8:	vmulss xmm1,xmm1,xmm2
    3adc:	vmulss xmm0,xmm0,xmm2
    3ae0:	vmulss xmm1,xmm1,xmm2
    3ae4:	vmulss xmm0,xmm0,xmm2
    3ae8:	vmulss xmm1,xmm1,xmm2
    3aec:	vmulss xmm0,xmm0,xmm2
    3af0:	vmulss xmm1,xmm1,xmm2
    3af4:	vmulss xmm0,xmm0,xmm2
    3af8:	vmulss xmm1,xmm1,xmm2
    3afc:	vmulss xmm0,xmm0,xmm2
    3b00:	vmulss xmm1,xmm1,xmm2
    3b04:	vmulss xmm0,xmm0,xmm2
    3b08:	vmulss xmm1,xmm1,xmm2
    3b0c:	vmulss xmm0,xmm0,xmm2
    3b10:	vmulss xmm1,xmm1,xmm2
    3b14:	vmulss xmm0,xmm0,xmm2
    3b18:	inc    rax
    3b1b:	cmp    rdi,rax
    3b1e:	jne    3ad8 <void fp32_scalar_mul<2>(unsigned long)+0x28>
    3b20:	ret
    3b21:	vmovss xmm0,DWORD PTR [rip+0x66b7]        # a1e0 <K_VALUES+0x20>
    3b29:	vmovaps xmm1,xmm0
    3b2d:	ret
    3b2e:	xchg   ax,ax

0000000000003b30 <void fp32_scalar_mul<4>(unsigned long)>:
    3b30:	endbr64
    3b34:	test   rdi,rdi
    3b37:	je     3bed <void fp32_scalar_mul<4>(unsigned long)+0xbd>
    3b3d:	vmovss xmm4,DWORD PTR [rip+0x669b]        # a1e0 <K_VALUES+0x20>
    3b45:	xor    eax,eax
    3b47:	vmovss xmm5,DWORD PTR [rip+0x66a1]        # a1f0 <K_VALUES+0x30>
    3b4f:	vmovaps xmm0,xmm4
    3b53:	vmovaps xmm1,xmm4
    3b57:	vmovaps xmm2,xmm4
    3b5b:	vmovaps xmm3,xmm4
    3b5f:	nop
    3b60:	vmulss xmm3,xmm3,xmm4
    3b64:	vmulss xmm2,xmm2,xmm4
    3b68:	vmulss xmm1,xmm1,xmm4
    3b6c:	vmulss xmm0,xmm0,xmm4
    3b70:	vmulss xmm3,xmm3,xmm4
    3b74:	vmulss xmm2,xmm2,xmm4
    3b78:	vmulss xmm1,xmm1,xmm4
    3b7c:	vmulss xmm0,xmm0,xmm4
    3b80:	vmulss xmm3,xmm3,xmm4
    3b84:	vmulss xmm2,xmm2,xmm4
    3b88:	vmulss xmm1,xmm1,xmm4
    3b8c:	vmulss xmm0,xmm0,xmm4
    3b90:	vmulss xmm3,xmm3,xmm4
    3b94:	vmulss xmm2,xmm2,xmm4
    3b98:	vmulss xmm1,xmm1,xmm4
    3b9c:	vmulss xmm0,xmm0,xmm4
    3ba0:	vmulss xmm3,xmm3,xmm4
    3ba4:	vmulss xmm2,xmm2,xmm4
    3ba8:	vmulss xmm1,xmm1,xmm4
    3bac:	vmulss xmm0,xmm0,xmm4
    3bb0:	vmulss xmm3,xmm3,xmm4
    3bb4:	vmulss xmm2,xmm2,xmm4
    3bb8:	vmulss xmm1,xmm1,xmm4
    3bbc:	vmulss xmm0,xmm0,xmm4
    3bc0:	vmulss xmm3,xmm3,xmm4
    3bc4:	vmulss xmm2,xmm2,xmm4
    3bc8:	vmulss xmm1,xmm1,xmm4
    3bcc:	vmulss xmm0,xmm0,xmm4
    3bd0:	vmulss xmm3,xmm3,xmm4
    3bd4:	vmulss xmm2,xmm2,xmm4
    3bd8:	vmulss xmm1,xmm1,xmm4
    3bdc:	vmulss xmm0,xmm0,xmm4
    3be0:	inc    rax
    3be3:	cmp    rdi,rax
    3be6:	jne    3b60 <void fp32_scalar_mul<4>(unsigned long)+0x30>
    3bec:	ret
    3bed:	vmovss xmm0,DWORD PTR [rip+0x65eb]        # a1e0 <K_VALUES+0x20>
    3bf5:	vmovaps xmm1,xmm0
    3bf9:	vmovaps xmm2,xmm0
    3bfd:	vmovaps xmm3,xmm0
    3c01:	ret
    3c02:	data16 cs nop WORD PTR [rax+rax*1+0x0]
    3c0d:	nop    DWORD PTR [rax]

0000000000003c10 <void fp32_scalar_mul<6>(unsigned long)>:
    3c10:	endbr64
    3c14:	test   rdi,rdi
    3c17:	je     3d1d <void fp32_scalar_mul<6>(unsigned long)+0x10d>
    3c1d:	vmovss xmm0,DWORD PTR [rip+0x65bb]        # a1e0 <K_VALUES+0x20>
    3c25:	xor    eax,eax
    3c27:	vmovss xmm1,DWORD PTR [rip+0x65c1]        # a1f0 <K_VALUES+0x30>
    3c2f:	vmovaps xmm2,xmm0
    3c33:	vmovaps xmm3,xmm0
    3c37:	vmovaps xmm4,xmm0
    3c3b:	vmovaps xmm5,xmm0
    3c3f:	vmovaps xmm6,xmm0
    3c43:	vmovaps xmm7,xmm0
    3c47:	nop    WORD PTR [rax+rax*1+0x0]
    3c50:	vmulss xmm7,xmm7,xmm0
    3c54:	vmulss xmm6,xmm6,xmm0
    3c58:	vmulss xmm5,xmm5,xmm0
    3c5c:	vmulss xmm4,xmm4,xmm0
    3c60:	vmulss xmm3,xmm3,xmm0
    3c64:	vmulss xmm2,xmm2,xmm0
    3c68:	vmulss xmm7,xmm7,xmm0
    3c6c:	vmulss xmm6,xmm6,xmm0
    3c70:	vmulss xmm5,xmm5,xmm0
    3c74:	vmulss xmm4,xmm4,xmm0
    3c78:	vmulss xmm3,xmm3,xmm0
    3c7c:	vmulss xmm2,xmm2,xmm0
    3c80:	vmulss xmm7,xmm7,xmm0
    3c84:	vmulss xmm6,xmm6,xmm0
    3c88:	vmulss xmm5,xmm5,xmm0
    3c8c:	vmulss xmm4,xmm4,xmm0
    3c90:	vmulss xmm3,xmm3,xmm0
    3c94:	vmulss xmm2,xmm2,xmm0
    3c98:	vmulss xmm7,xmm7,xmm0
    3c9c:	vmulss xmm6,xmm6,xmm0
    3ca0:	vmulss xmm5,xmm5,xmm0
    3ca4:	vmulss xmm4,xmm4,xmm0
    3ca8:	vmulss xmm3,xmm3,xmm0
    3cac:	vmulss xmm2,xmm2,xmm0
    3cb0:	vmulss xmm7,xmm7,xmm0
    3cb4:	vmulss xmm6,xmm6,xmm0
    3cb8:	vmulss xmm5,xmm5,xmm0
    3cbc:	vmulss xmm4,xmm4,xmm0
    3cc0:	vmulss xmm3,xmm3,xmm0
    3cc4:	vmulss xmm2,xmm2,xmm0
    3cc8:	vmulss xmm7,xmm7,xmm0
    3ccc:	vmulss xmm6,xmm6,xmm0
    3cd0:	vmulss xmm5,xmm5,xmm0
    3cd4:	vmulss xmm4,xmm4,xmm0
    3cd8:	vmulss xmm3,xmm3,xmm0
    3cdc:	vmulss xmm2,xmm2,xmm0
    3ce0:	vmulss xmm7,xmm7,xmm0
    3ce4:	vmulss xmm6,xmm6,xmm0
    3ce8:	vmulss xmm5,xmm5,xmm0
    3cec:	vmulss xmm4,xmm4,xmm0
    3cf0:	vmulss xmm3,xmm3,xmm0
    3cf4:	vmulss xmm2,xmm2,xmm0
    3cf8:	vmulss xmm7,xmm7,xmm0
    3cfc:	vmulss xmm6,xmm6,xmm0
    3d00:	vmulss xmm5,xmm5,xmm0
    3d04:	vmulss xmm4,xmm4,xmm0
    3d08:	vmulss xmm3,xmm3,xmm0
    3d0c:	vmulss xmm2,xmm2,xmm0
    3d10:	inc    rax
    3d13:	cmp    rdi,rax
    3d16:	jne    3c50 <void fp32_scalar_mul<6>(unsigned long)+0x40>
    3d1c:	ret
    3d1d:	vmovss xmm2,DWORD PTR [rip+0x64bb]        # a1e0 <K_VALUES+0x20>
    3d25:	vmovaps xmm3,xmm2
    3d29:	vmovaps xmm4,xmm2
    3d2d:	vmovaps xmm5,xmm2
    3d31:	vmovaps xmm6,xmm2
    3d35:	vmovaps xmm7,xmm2
    3d39:	ret
    3d3a:	nop    WORD PTR [rax+rax*1+0x0]

0000000000003d40 <void fp32_scalar_mul<8>(unsigned long)>:
    3d40:	endbr64
    3d44:	test   rdi,rdi
    3d47:	je     3e8d <void fp32_scalar_mul<8>(unsigned long)+0x14d>
    3d4d:	vmovss xmm0,DWORD PTR [rip+0x648b]        # a1e0 <K_VALUES+0x20>
    3d55:	xor    eax,eax
    3d57:	vmovss xmm1,DWORD PTR [rip+0x6491]        # a1f0 <K_VALUES+0x30>
    3d5f:	vmovaps xmm2,xmm0
    3d63:	vmovaps xmm3,xmm0
    3d67:	vmovaps xmm4,xmm0
    3d6b:	vmovaps xmm5,xmm0
    3d6f:	vmovaps xmm6,xmm0
    3d73:	vmovaps xmm7,xmm0
    3d77:	vmovaps xmm8,xmm0
    3d7b:	vmovaps xmm9,xmm0
    3d7f:	nop
    3d80:	vmulss xmm9,xmm9,xmm0
    3d84:	vmulss xmm8,xmm8,xmm0
    3d88:	vmulss xmm7,xmm7,xmm0
    3d8c:	vmulss xmm6,xmm6,xmm0
    3d90:	vmulss xmm5,xmm5,xmm0
    3d94:	vmulss xmm4,xmm4,xmm0
    3d98:	vmulss xmm3,xmm3,xmm0
    3d9c:	vmulss xmm2,xmm2,xmm0
    3da0:	vmulss xmm9,xmm9,xmm0
    3da4:	vmulss xmm8,xmm8,xmm0
    3da8:	vmulss xmm7,xmm7,xmm0
    3dac:	vmulss xmm6,xmm6,xmm0
    3db0:	vmulss xmm5,xmm5,xmm0
    3db4:	vmulss xmm4,xmm4,xmm0
    3db8:	vmulss xmm3,xmm3,xmm0
    3dbc:	vmulss xmm2,xmm2,xmm0
    3dc0:	vmulss xmm9,xmm9,xmm0
    3dc4:	vmulss xmm8,xmm8,xmm0
    3dc8:	vmulss xmm7,xmm7,xmm0
    3dcc:	vmulss xmm6,xmm6,xmm0
    3dd0:	vmulss xmm5,xmm5,xmm0
    3dd4:	vmulss xmm4,xmm4,xmm0
    3dd8:	vmulss xmm3,xmm3,xmm0
    3ddc:	vmulss xmm2,xmm2,xmm0
    3de0:	vmulss xmm9,xmm9,xmm0
    3de4:	vmulss xmm8,xmm8,xmm0
    3de8:	vmulss xmm7,xmm7,xmm0
    3dec:	vmulss xmm6,xmm6,xmm0
    3df0:	vmulss xmm5,xmm5,xmm0
    3df4:	vmulss xmm4,xmm4,xmm0
    3df8:	vmulss xmm3,xmm3,xmm0
    3dfc:	vmulss xmm2,xmm2,xmm0
    3e00:	vmulss xmm9,xmm9,xmm0
    3e04:	vmulss xmm8,xmm8,xmm0
    3e08:	vmulss xmm7,xmm7,xmm0
    3e0c:	vmulss xmm6,xmm6,xmm0
    3e10:	vmulss xmm5,xmm5,xmm0
    3e14:	vmulss xmm4,xmm4,xmm0
    3e18:	vmulss xmm3,xmm3,xmm0
    3e1c:	vmulss xmm2,xmm2,xmm0
    3e20:	vmulss xmm9,xmm9,xmm0
    3e24:	vmulss xmm8,xmm8,xmm0
    3e28:	vmulss xmm7,xmm7,xmm0
    3e2c:	vmulss xmm6,xmm6,xmm0
    3e30:	vmulss xmm5,xmm5,xmm0
    3e34:	vmulss xmm4,xmm4,xmm0
    3e38:	vmulss xmm3,xmm3,xmm0
    3e3c:	vmulss xmm2,xmm2,xmm0
    3e40:	vmulss xmm9,xmm9,xmm0
    3e44:	vmulss xmm8,xmm8,xmm0
    3e48:	vmulss xmm7,xmm7,xmm0
    3e4c:	vmulss xmm6,xmm6,xmm0
    3e50:	vmulss xmm5,xmm5,xmm0
    3e54:	vmulss xmm4,xmm4,xmm0
    3e58:	vmulss xmm3,xmm3,xmm0
    3e5c:	vmulss xmm2,xmm2,xmm0
    3e60:	vmulss xmm9,xmm9,xmm0
    3e64:	vmulss xmm8,xmm8,xmm0
    3e68:	vmulss xmm7,xmm7,xmm0
    3e6c:	vmulss xmm6,xmm6,xmm0
    3e70:	vmulss xmm5,xmm5,xmm0
    3e74:	vmulss xmm4,xmm4,xmm0
    3e78:	vmulss xmm3,xmm3,xmm0
    3e7c:	vmulss xmm2,xmm2,xmm0
    3e80:	inc    rax
    3e83:	cmp    rdi,rax
    3e86:	jne    3d80 <void fp32_scalar_mul<8>(unsigned long)+0x40>
    3e8c:	ret
    3e8d:	vmovss xmm2,DWORD PTR [rip+0x634b]        # a1e0 <K_VALUES+0x20>
    3e95:	vmovaps xmm3,xmm2
    3e99:	vmovaps xmm4,xmm2
    3e9d:	vmovaps xmm5,xmm2
    3ea1:	vmovaps xmm6,xmm2
    3ea5:	vmovaps xmm7,xmm2
    3ea9:	vmovaps xmm8,xmm2
    3ead:	vmovaps xmm9,xmm2
    3eb1:	ret
    3eb2:	data16 cs nop WORD PTR [rax+rax*1+0x0]
    3ebd:	nop    DWORD PTR [rax]

0000000000003ec0 <void fp32_scalar_mul<10>(unsigned long)>:
    3ec0:	endbr64
    3ec4:	test   rdi,rdi
    3ec7:	je     405d <void fp32_scalar_mul<10>(unsigned long)+0x19d>
    3ecd:	vmovss xmm0,DWORD PTR [rip+0x630b]        # a1e0 <K_VALUES+0x20>
    3ed5:	xor    eax,eax
    3ed7:	vmovss xmm1,DWORD PTR [rip+0x6311]        # a1f0 <K_VALUES+0x30>
    3edf:	vmovaps xmm2,xmm0
    3ee3:	vmovaps xmm3,xmm0
    3ee7:	vmovaps xmm4,xmm0
    3eeb:	vmovaps xmm5,xmm0
    3eef:	vmovaps xmm6,xmm0
    3ef3:	vmovaps xmm7,xmm0
    3ef7:	vmovaps xmm8,xmm0
    3efb:	vmovaps xmm9,xmm0
    3eff:	vmovaps xmm10,xmm0
    3f03:	vmovaps xmm11,xmm0
    3f07:	nop    WORD PTR [rax+rax*1+0x0]
    3f10:	vmulss xmm11,xmm11,xmm0
    3f14:	vmulss xmm10,xmm10,xmm0
    3f18:	vmulss xmm9,xmm9,xmm0
    3f1c:	vmulss xmm8,xmm8,xmm0
    3f20:	vmulss xmm7,xmm7,xmm0
    3f24:	vmulss xmm6,xmm6,xmm0
    3f28:	vmulss xmm5,xmm5,xmm0
    3f2c:	vmulss xmm4,xmm4,xmm0
    3f30:	vmulss xmm3,xmm3,xmm0
    3f34:	vmulss xmm2,xmm2,xmm0
    3f38:	vmulss xmm11,xmm11,xmm0
    3f3c:	vmulss xmm10,xmm10,xmm0
    3f40:	vmulss xmm9,xmm9,xmm0
    3f44:	vmulss xmm8,xmm8,xmm0
    3f48:	vmulss xmm7,xmm7,xmm0
    3f4c:	vmulss xmm6,xmm6,xmm0
    3f50:	vmulss xmm5,xmm5,xmm0
    3f54:	vmulss xmm4,xmm4,xmm0
    3f58:	vmulss xmm3,xmm3,xmm0
    3f5c:	vmulss xmm2,xmm2,xmm0
    3f60:	vmulss xmm11,xmm11,xmm0
    3f64:	vmulss xmm10,xmm10,xmm0
    3f68:	vmulss xmm9,xmm9,xmm0
    3f6c:	vmulss xmm8,xmm8,xmm0
    3f70:	vmulss xmm7,xmm7,xmm0
    3f74:	vmulss xmm6,xmm6,xmm0
    3f78:	vmulss xmm5,xmm5,xmm0
    3f7c:	vmulss xmm4,xmm4,xmm0
    3f80:	vmulss xmm3,xmm3,xmm0
    3f84:	vmulss xmm2,xmm2,xmm0
    3f88:	vmulss xmm11,xmm11,xmm0
    3f8c:	vmulss xmm10,xmm10,xmm0
    3f90:	vmulss xmm9,xmm9,xmm0
    3f94:	vmulss xmm8,xmm8,xmm0
    3f98:	vmulss xmm7,xmm7,xmm0
    3f9c:	vmulss xmm6,xmm6,xmm0
    3fa0:	vmulss xmm5,xmm5,xmm0
    3fa4:	vmulss xmm4,xmm4,xmm0
    3fa8:	vmulss xmm3,xmm3,xmm0
    3fac:	vmulss xmm2,xmm2,xmm0
    3fb0:	vmulss xmm11,xmm11,xmm0
    3fb4:	vmulss xmm10,xmm10,xmm0
    3fb8:	vmulss xmm9,xmm9,xmm0
    3fbc:	vmulss xmm8,xmm8,xmm0
    3fc0:	vmulss xmm7,xmm7,xmm0
    3fc4:	vmulss xmm6,xmm6,xmm0
    3fc8:	vmulss xmm5,xmm5,xmm0
    3fcc:	vmulss xmm4,xmm4,xmm0
    3fd0:	vmulss xmm3,xmm3,xmm0
    3fd4:	vmulss xmm2,xmm2,xmm0
    3fd8:	vmulss xmm11,xmm11,xmm0
    3fdc:	vmulss xmm10,xmm10,xmm0
    3fe0:	vmulss xmm9,xmm9,xmm0
    3fe4:	vmulss xmm8,xmm8,xmm0
    3fe8:	vmulss xmm7,xmm7,xmm0
    3fec:	vmulss xmm6,xmm6,xmm0
    3ff0:	vmulss xmm5,xmm5,xmm0
    3ff4:	vmulss xmm4,xmm4,xmm0
    3ff8:	vmulss xmm3,xmm3,xmm0
    3ffc:	vmulss xmm2,xmm2,xmm0
    4000:	vmulss xmm11,xmm11,xmm0
    4004:	vmulss xmm10,xmm10,xmm0
    4008:	vmulss xmm9,xmm9,xmm0
    400c:	vmulss xmm8,xmm8,xmm0
    4010:	vmulss xmm7,xmm7,xmm0
    4014:	vmulss xmm6,xmm6,xmm0
    4018:	vmulss xmm5,xmm5,xmm0
    401c:	vmulss xmm4,xmm4,xmm0
    4020:	vmulss xmm3,xmm3,xmm0
    4024:	vmulss xmm2,xmm2,xmm0
    4028:	vmulss xmm11,xmm11,xmm0
    402c:	vmulss xmm10,xmm10,xmm0
    4030:	vmulss xmm9,xmm9,xmm0
    4034:	vmulss xmm8,xmm8,xmm0
    4038:	vmulss xmm7,xmm7,xmm0
    403c:	vmulss xmm6,xmm6,xmm0
    4040:	vmulss xmm5,xmm5,xmm0
    4044:	vmulss xmm4,xmm4,xmm0
    4048:	vmulss xmm3,xmm3,xmm0
    404c:	vmulss xmm2,xmm2,xmm0
    4050:	inc    rax
    4053:	cmp    rdi,rax
    4056:	jne    3f10 <void fp32_scalar_mul<10>(unsigned long)+0x50>
    405c:	ret
    405d:	vmovss xmm2,DWORD PTR [rip+0x617b]        # a1e0 <K_VALUES+0x20>
    4065:	vmovaps xmm3,xmm2
    4069:	vmovaps xmm4,xmm2
    406d:	vmovaps xmm5,xmm2
    4071:	vmovaps xmm6,xmm2
    4075:	vmovaps xmm7,xmm2
    4079:	vmovaps xmm8,xmm2
    407d:	vmovaps xmm9,xmm2
    4081:	vmovaps xmm10,xmm2
    4085:	vmovaps xmm11,xmm2
    4089:	ret
    408a:	nop    WORD PTR [rax+rax*1+0x0]

0000000000004090 <void fp32_scalar_mul<12>(unsigned long)>:
    4090:	endbr64
    4094:	test   rdi,rdi
    4097:	je     426d <void fp32_scalar_mul<12>(unsigned long)+0x1dd>
    409d:	vmovss xmm0,DWORD PTR [rip+0x613b]        # a1e0 <K_VALUES+0x20>
    40a5:	xor    eax,eax
    40a7:	vmovss xmm1,DWORD PTR [rip+0x6141]        # a1f0 <K_VALUES+0x30>
    40af:	vmovaps xmm10,xmm0
    40b3:	vmovaps xmm11,xmm0
    40b7:	vmovaps xmm12,xmm0
    40bb:	vmovaps xmm13,xmm0
    40bf:	vmovaps xmm2,xmm0
    40c3:	vmovaps xmm3,xmm0
    40c7:	vmovaps xmm4,xmm0
    40cb:	vmovaps xmm5,xmm0
    40cf:	vmovaps xmm6,xmm0
    40d3:	vmovaps xmm7,xmm0
    40d7:	vmovaps xmm8,xmm0
    40db:	vmovaps xmm9,xmm0
    40df:	nop
    40e0:	vmulss xmm9,xmm9,xmm0
    40e4:	vmulss xmm8,xmm8,xmm0
    40e8:	vmulss xmm7,xmm7,xmm0
    40ec:	vmulss xmm6,xmm6,xmm0
    40f0:	vmulss xmm5,xmm5,xmm0
    40f4:	vmulss xmm4,xmm4,xmm0
    40f8:	vmulss xmm3,xmm3,xmm0
    40fc:	vmulss xmm2,xmm2,xmm0
    4100:	vmulss xmm13,xmm13,xmm0
    4104:	vmulss xmm12,xmm12,xmm0
    4108:	vmulss xmm11,xmm11,xmm0
    410c:	vmulss xmm10,xmm10,xmm0
    4110:	vmulss xmm9,xmm9,xmm0
    4114:	vmulss xmm8,xmm8,xmm0
    4118:	vmulss xmm7,xmm7,xmm0
    411c:	vmulss xmm6,xmm6,xmm0
    4120:	vmulss xmm5,xmm5,xmm0
    4124:	vmulss xmm4,xmm4,xmm0
    4128:	vmulss xmm3,xmm3,xmm0
    412c:	vmulss xmm2,xmm2,xmm0
    4130:	vmulss xmm13,xmm13,xmm0
    4134:	vmulss xmm12,xmm12,xmm0
    4138:	vmulss xmm11,xmm11,xmm0
    413c:	vmulss xmm10,xmm10,xmm0
    4140:	vmulss xmm9,xmm9,xmm0
    4144:	vmulss xmm8,xmm8,xmm0
    4148:	vmulss xmm7,xmm7,xmm0
    414c:	vmulss xmm6,xmm6,xmm0
    4150:	vmulss xmm5,xmm5,xmm0
    4154:	vmulss xmm4,xmm4,xmm0
    4158:	vmulss xmm3,xmm3,xmm0
    415c:	vmulss xmm2,xmm2,xmm0
    4160:	vmulss xmm13,xmm13,xmm0
    4164:	vmulss xmm12,xmm12,xmm0
    4168:	vmulss xmm11,xmm11,xmm0
    416c:	vmulss xmm10,xmm10,xmm0
    4170:	vmulss xmm9,xmm9,xmm0
    4174:	vmulss xmm8,xmm8,xmm0
    4178:	vmulss xmm7,xmm7,xmm0
    417c:	vmulss xmm6,xmm6,xmm0
    4180:	vmulss xmm5,xmm5,xmm0
    4184:	vmulss xmm4,xmm4,xmm0
    4188:	vmulss xmm3,xmm3,xmm0
    418c:	vmulss xmm2,xmm2,xmm0
    4190:	vmulss xmm13,xmm13,xmm0
    4194:	vmulss xmm12,xmm12,xmm0
    4198:	vmulss xmm11,xmm11,xmm0
    419c:	vmulss xmm10,xmm10,xmm0
    41a0:	vmulss xmm9,xmm9,xmm0
    41a4:	vmulss xmm8,xmm8,xmm0
    41a8:	vmulss xmm7,xmm7,xmm0
    41ac:	vmulss xmm6,xmm6,xmm0
    41b0:	vmulss xmm5,xmm5,xmm0
    41b4:	vmulss xmm4,xmm4,xmm0
    41b8:	vmulss xmm3,xmm3,xmm0
    41bc:	vmulss xmm2,xmm2,xmm0
    41c0:	vmulss xmm13,xmm13,xmm0
    41c4:	vmulss xmm12,xmm12,xmm0
    41c8:	vmulss xmm11,xmm11,xmm0
    41cc:	vmulss xmm10,xmm10,xmm0
    41d0:	vmulss xmm9,xmm9,xmm0
    41d4:	vmulss xmm8,xmm8,xmm0
    41d8:	vmulss xmm7,xmm7,xmm0
    41dc:	vmulss xmm6,xmm6,xmm0
    41e0:	vmulss xmm5,xmm5,xmm0
    41e4:	vmulss xmm4,xmm4,xmm0
    41e8:	vmulss xmm3,xmm3,xmm0
    41ec:	vmulss xmm2,xmm2,xmm0
    41f0:	vmulss xmm13,xmm13,xmm0
    41f4:	vmulss xmm12,xmm12,xmm0
    41f8:	vmulss xmm11,xmm11,xmm0
    41fc:	vmulss xmm10,xmm10,xmm0
    4200:	vmulss xmm9,xmm9,xmm0
    4204:	vmulss xmm8,xmm8,xmm0
    4208:	vmulss xmm7,xmm7,xmm0
    420c:	vmulss xmm6,xmm6,xmm0
    4210:	vmulss xmm5,xmm5,xmm0
    4214:	vmulss xmm4,xmm4,xmm0
    4218:	vmulss xmm3,xmm3,xmm0
    421c:	vmulss xmm2,xmm2,xmm0
    4220:	vmulss xmm13,xmm13,xmm0
    4224:	vmulss xmm12,xmm12,xmm0
    4228:	vmulss xmm11,xmm11,xmm0
    422c:	vmulss xmm10,xmm10,xmm0
    4230:	vmulss xmm9,xmm9,xmm0
    4234:	vmulss xmm8,xmm8,xmm0
    4238:	vmulss xmm7,xmm7,xmm0
    423c:	vmulss xmm6,xmm6,xmm0
    4240:	vmulss xmm5,xmm5,xmm0
    4244:	vmulss xmm4,xmm4,xmm0
    4248:	vmulss xmm3,xmm3,xmm0
    424c:	vmulss xmm2,xmm2,xmm0
    4250:	vmulss xmm13,xmm13,xmm0
    4254:	vmulss xmm12,xmm12,xmm0
    4258:	vmulss xmm11,xmm11,xmm0
    425c:	vmulss xmm10,xmm10,xmm0
    4260:	inc    rax
    4263:	cmp    rdi,rax
    4266:	jne    40e0 <void fp32_scalar_mul<12>(unsigned long)+0x50>
    426c:	ret
    426d:	vmovss xmm10,DWORD PTR [rip+0x5f6b]        # a1e0 <K_VALUES+0x20>
    4275:	vmovaps xmm11,xmm10
    427a:	vmovaps xmm12,xmm10
    427f:	vmovaps xmm13,xmm10
    4284:	vmovaps xmm2,xmm10
    4288:	vmovaps xmm3,xmm10
    428c:	vmovaps xmm4,xmm10
    4290:	vmovaps xmm5,xmm10
    4294:	vmovaps xmm6,xmm10
    4298:	vmovaps xmm7,xmm10
    429c:	vmovaps xmm8,xmm10
    42a1:	vmovaps xmm9,xmm10
    42a6:	ret
    42a7:	nop    WORD PTR [rax+rax*1+0x0]

00000000000042b0 <void fp32_scalar_mul<16>(unsigned long)>:
    42b0:	endbr64
    42b4:	test   rdi,rdi
    42b7:	je     4545 <void fp32_scalar_mul<16>(unsigned long)+0x295>
    42bd:	vmovss xmm0,DWORD PTR [rip+0x5f1b]        # a1e0 <K_VALUES+0x20>
    42c5:	xor    eax,eax
    42c7:	vmovss xmm1,DWORD PTR [rip+0x5f21]        # a1f0 <K_VALUES+0x30>
    42cf:	vmovaps xmm2,xmm0
    42d3:	vmovaps xmm17,xmm0
    42d9:	vmovaps xmm3,xmm0
    42dd:	vmovaps xmm4,xmm0
    42e1:	vmovaps xmm5,xmm0
    42e5:	vmovaps xmm6,xmm0
    42e9:	vmovaps xmm7,xmm0
    42ed:	vmovaps xmm8,xmm0
    42f1:	vmovaps xmm9,xmm0
    42f5:	vmovaps xmm10,xmm0
    42f9:	vmovaps xmm11,xmm0
    42fd:	vmovaps xmm12,xmm0
    4301:	vmovaps xmm13,xmm0
    4305:	vmovaps xmm14,xmm0
    4309:	vmovaps xmm15,xmm0
    430d:	vmovaps xmm16,xmm0
    4313:	nop    DWORD PTR [rax+rax*1+0x0]
    4318:	vmulss xmm16,xmm16,xmm0
    431e:	vmulss xmm15,xmm15,xmm0
    4322:	vmulss xmm14,xmm14,xmm0
    4326:	vmulss xmm13,xmm13,xmm0
    432a:	vmulss xmm12,xmm12,xmm0
    432e:	vmulss xmm11,xmm11,xmm0
    4332:	vmulss xmm10,xmm10,xmm0
    4336:	vmulss xmm9,xmm9,xmm0
    433a:	vmulss xmm8,xmm8,xmm0
    433e:	vmulss xmm7,xmm7,xmm0
    4342:	vmulss xmm6,xmm6,xmm0
    4346:	vmulss xmm5,xmm5,xmm0
    434a:	vmulss xmm4,xmm4,xmm0
    434e:	vmulss xmm3,xmm3,xmm0
    4352:	vmulss xmm17,xmm17,xmm0
    4358:	vmulss xmm2,xmm2,xmm0
    435c:	vmulss xmm16,xmm16,xmm0
    4362:	vmulss xmm15,xmm15,xmm0
    4366:	vmulss xmm14,xmm14,xmm0
    436a:	vmulss xmm13,xmm13,xmm0
    436e:	vmulss xmm12,xmm12,xmm0
    4372:	vmulss xmm11,xmm11,xmm0
    4376:	vmulss xmm10,xmm10,xmm0
    437a:	vmulss xmm9,xmm9,xmm0
    437e:	vmulss xmm8,xmm8,xmm0
    4382:	vmulss xmm7,xmm7,xmm0
    4386:	vmulss xmm6,xmm6,xmm0
    438a:	vmulss xmm5,xmm5,xmm0
    438e:	vmulss xmm4,xmm4,xmm0
    4392:	vmulss xmm3,xmm3,xmm0
    4396:	vmulss xmm17,xmm17,xmm0
    439c:	vmulss xmm2,xmm2,xmm0
    43a0:	vmulss xmm16,xmm16,xmm0
    43a6:	vmulss xmm15,xmm15,xmm0
    43aa:	vmulss xmm14,xmm14,xmm0
    43ae:	vmulss xmm13,xmm13,xmm0
    43b2:	vmulss xmm12,xmm12,xmm0
    43b6:	vmulss xmm11,xmm11,xmm0
    43ba:	vmulss xmm10,xmm10,xmm0
    43be:	vmulss xmm9,xmm9,xmm0
    43c2:	vmulss xmm8,xmm8,xmm0
    43c6:	vmulss xmm7,xmm7,xmm0
    43ca:	vmulss xmm6,xmm6,xmm0
    43ce:	vmulss xmm5,xmm5,xmm0
    43d2:	vmulss xmm4,xmm4,xmm0
    43d6:	vmulss xmm3,xmm3,xmm0
    43da:	vmulss xmm17,xmm17,xmm0
    43e0:	vmulss xmm2,xmm2,xmm0
    43e4:	vmulss xmm16,xmm16,xmm0
    43ea:	vmulss xmm15,xmm15,xmm0
    43ee:	vmulss xmm14,xmm14,xmm0
    43f2:	vmulss xmm13,xmm13,xmm0
    43f6:	vmulss xmm12,xmm12,xmm0
    43fa:	vmulss xmm11,xmm11,xmm0
    43fe:	vmulss xmm10,xmm10,xmm0
    4402:	vmulss xmm9,xmm9,xmm0
    4406:	vmulss xmm8,xmm8,xmm0
    440a:	vmulss xmm7,xmm7,xmm0
    440e:	vmulss xmm6,xmm6,xmm0
    4412:	vmulss xmm5,xmm5,xmm0
    4416:	vmulss xmm4,xmm4,xmm0
    441a:	vmulss xmm3,xmm3,xmm0
    441e:	vmulss xmm17,xmm17,xmm0
    4424:	vmulss xmm2,xmm2,xmm0
    4428:	vmulss xmm16,xmm16,xmm0
    442e:	vmulss xmm15,xmm15,xmm0
    4432:	vmulss xmm14,xmm14,xmm0
    4436:	vmulss xmm13,xmm13,xmm0
    443a:	vmulss xmm12,xmm12,xmm0
    443e:	vmulss xmm11,xmm11,xmm0
    4442:	vmulss xmm10,xmm10,xmm0
    4446:	vmulss xmm9,xmm9,xmm0
    444a:	vmulss xmm8,xmm8,xmm0
    444e:	vmulss xmm7,xmm7,xmm0
    4452:	vmulss xmm6,xmm6,xmm0
    4456:	vmulss xmm5,xmm5,xmm0
    445a:	vmulss xmm4,xmm4,xmm0
    445e:	vmulss xmm3,xmm3,xmm0
    4462:	vmulss xmm17,xmm17,xmm0
    4468:	vmulss xmm2,xmm2,xmm0
    446c:	vmulss xmm16,xmm16,xmm0
    4472:	vmulss xmm15,xmm15,xmm0
    4476:	vmulss xmm14,xmm14,xmm0
    447a:	vmulss xmm13,xmm13,xmm0
    447e:	vmulss xmm12,xmm12,xmm0
    4482:	vmulss xmm11,xmm11,xmm0
    4486:	vmulss xmm10,xmm10,xmm0
    448a:	vmulss xmm9,xmm9,xmm0
    448e:	vmulss xmm8,xmm8,xmm0
    4492:	vmulss xmm7,xmm7,xmm0
    4496:	vmulss xmm6,xmm6,xmm0
    449a:	vmulss xmm5,xmm5,xmm0
    449e:	vmulss xmm4,xmm4,xmm0
    44a2:	vmulss xmm3,xmm3,xmm0
    44a6:	vmulss xmm17,xmm17,xmm0
    44ac:	vmulss xmm2,xmm2,xmm0
    44b0:	vmulss xmm16,xmm16,xmm0
    44b6:	vmulss xmm15,xmm15,xmm0
    44ba:	vmulss xmm14,xmm14,xmm0
    44be:	vmulss xmm13,xmm13,xmm0
    44c2:	vmulss xmm12,xmm12,xmm0
    44c6:	vmulss xmm11,xmm11,xmm0
    44ca:	vmulss xmm10,xmm10,xmm0
    44ce:	vmulss xmm9,xmm9,xmm0
    44d2:	vmulss xmm8,xmm8,xmm0
    44d6:	vmulss xmm7,xmm7,xmm0
    44da:	vmulss xmm6,xmm6,xmm0
    44de:	vmulss xmm5,xmm5,xmm0
    44e2:	vmulss xmm4,xmm4,xmm0
    44e6:	vmulss xmm3,xmm3,xmm0
    44ea:	vmulss xmm17,xmm17,xmm0
    44f0:	vmulss xmm2,xmm2,xmm0
    44f4:	vmulss xmm16,xmm16,xmm0
    44fa:	vmulss xmm15,xmm15,xmm0
    44fe:	vmulss xmm14,xmm14,xmm0
    4502:	vmulss xmm13,xmm13,xmm0
    4506:	vmulss xmm12,xmm12,xmm0
    450a:	vmulss xmm11,xmm11,xmm0
    450e:	vmulss xmm10,xmm10,xmm0
    4512:	vmulss xmm9,xmm9,xmm0
    4516:	vmulss xmm8,xmm8,xmm0
    451a:	vmulss xmm7,xmm7,xmm0
    451e:	vmulss xmm6,xmm6,xmm0
    4522:	vmulss xmm5,xmm5,xmm0
    4526:	vmulss xmm4,xmm4,xmm0
    452a:	vmulss xmm3,xmm3,xmm0
    452e:	vmulss xmm17,xmm17,xmm0
    4534:	vmulss xmm2,xmm2,xmm0
    4538:	inc    rax
    453b:	cmp    rdi,rax
    453e:	jne    4318 <void fp32_scalar_mul<16>(unsigned long)+0x68>
    4544:	ret
    4545:	vmovss xmm2,DWORD PTR [rip+0x5c93]        # a1e0 <K_VALUES+0x20>
    454d:	vmovaps xmm17,xmm2
    4553:	vmovaps xmm3,xmm2
    4557:	vmovaps xmm4,xmm2
    455b:	vmovaps xmm5,xmm2
    455f:	vmovaps xmm6,xmm2
    4563:	vmovaps xmm7,xmm2
    4567:	vmovaps xmm8,xmm2
    456b:	vmovaps xmm9,xmm2
    456f:	vmovaps xmm10,xmm2
    4573:	vmovaps xmm11,xmm2
    4577:	vmovaps xmm12,xmm2
    457b:	vmovaps xmm13,xmm2
    457f:	vmovaps xmm14,xmm2
    4583:	vmovaps xmm15,xmm2
    4587:	vmovaps xmm16,xmm2
    458d:	ret
    458e:	xchg   ax,ax

0000000000004590 <void fp32_scalar_fma<1>(unsigned long)>:
    4590:	endbr64
    4594:	test   rdi,rdi
    4597:	je     45e1 <void fp32_scalar_fma<1>(unsigned long)+0x51>
    4599:	vmovss xmm1,DWORD PTR [rip+0x5c3f]        # a1e0 <K_VALUES+0x20>
    45a1:	xor    eax,eax
    45a3:	vmovss xmm2,DWORD PTR [rip+0x5c45]        # a1f0 <K_VALUES+0x30>
    45ab:	vmovaps xmm0,xmm1
    45af:	nop
    45b0:	vfmadd231ss xmm0,xmm2,xmm1
    45b5:	vfmadd231ss xmm0,xmm2,xmm1
    45ba:	vfmadd231ss xmm0,xmm2,xmm1
    45bf:	vfmadd231ss xmm0,xmm2,xmm1
    45c4:	vfmadd231ss xmm0,xmm2,xmm1
    45c9:	vfmadd231ss xmm0,xmm2,xmm1
    45ce:	vfmadd231ss xmm0,xmm2,xmm1
    45d3:	vfmadd231ss xmm0,xmm2,xmm1
    45d8:	inc    rax
    45db:	cmp    rdi,rax
    45de:	jne    45b0 <void fp32_scalar_fma<1>(unsigned long)+0x20>
    45e0:	ret
    45e1:	vmovss xmm0,DWORD PTR [rip+0x5bf7]        # a1e0 <K_VALUES+0x20>
    45e9:	ret
    45ea:	nop    WORD PTR [rax+rax*1+0x0]

00000000000045f0 <void fp32_scalar_fma<2>(unsigned long)>:
    45f0:	endbr64
    45f4:	test   rdi,rdi
    45f7:	je     4671 <void fp32_scalar_fma<2>(unsigned long)+0x81>
    45f9:	vmovss xmm2,DWORD PTR [rip+0x5bdf]        # a1e0 <K_VALUES+0x20>
    4601:	xor    eax,eax
    4603:	vmovss xmm3,DWORD PTR [rip+0x5be5]        # a1f0 <K_VALUES+0x30>
    460b:	vmovaps xmm0,xmm2
    460f:	vmovaps xmm1,xmm2
    4613:	nop    DWORD PTR [rax+rax*1+0x0]
    4618:	vfmadd231ss xmm1,xmm3,xmm2
    461d:	vfmadd231ss xmm0,xmm3,xmm2
    4622:	vfmadd231ss xmm1,xmm3,xmm2
    4627:	vfmadd231ss xmm0,xmm3,xmm2
    462c:	vfmadd231ss xmm1,xmm3,xmm2
    4631:	vfmadd231ss xmm0,xmm3,xmm2
    4636:	vfmadd231ss xmm1,xmm3,xmm2
    463b:	vfmadd231ss xmm0,xmm3,xmm2
    4640:	vfmadd231ss xmm1,xmm3,xmm2
    4645:	vfmadd231ss xmm0,xmm3,xmm2
    464a:	vfmadd231ss xmm1,xmm3,xmm2
    464f:	vfmadd231ss xmm0,xmm3,xmm2
    4654:	vfmadd231ss xmm1,xmm3,xmm2
    4659:	vfmadd231ss xmm0,xmm3,xmm2
    465e:	vfmadd231ss xmm1,xmm3,xmm2
    4663:	vfmadd231ss xmm0,xmm3,xmm2
    4668:	inc    rax
    466b:	cmp    rdi,rax
    466e:	jne    4618 <void fp32_scalar_fma<2>(unsigned long)+0x28>
    4670:	ret
    4671:	vmovss xmm0,DWORD PTR [rip+0x5b67]        # a1e0 <K_VALUES+0x20>
    4679:	vmovaps xmm1,xmm0
    467d:	ret
    467e:	xchg   ax,ax

0000000000004680 <void fp32_scalar_fma<4>(unsigned long)>:
    4680:	endbr64
    4684:	test   rdi,rdi
    4687:	je     475d <void fp32_scalar_fma<4>(unsigned long)+0xdd>
    468d:	vmovss xmm4,DWORD PTR [rip+0x5b4b]        # a1e0 <K_VALUES+0x20>
    4695:	xor    eax,eax
    4697:	vmovss xmm5,DWORD PTR [rip+0x5b51]        # a1f0 <K_VALUES+0x30>
    469f:	vmovaps xmm0,xmm4
    46a3:	vmovaps xmm1,xmm4
    46a7:	vmovaps xmm2,xmm4
    46ab:	vmovaps xmm3,xmm4
    46af:	nop
    46b0:	vfmadd231ss xmm3,xmm5,xmm4
    46b5:	vfmadd231ss xmm2,xmm5,xmm4
    46ba:	vfmadd231ss xmm1,xmm5,xmm4
    46bf:	vfmadd231ss xmm0,xmm5,xmm4
    46c4:	vfmadd231ss xmm3,xmm5,xmm4
    46c9:	vfmadd231ss xmm2,xmm5,xmm4
    46ce:	vfmadd231ss xmm1,xmm5,xmm4
    46d3:	vfmadd231ss xmm0,xmm5,xmm4
    46d8:	vfmadd231ss xmm3,xmm5,xmm4
    46dd:	vfmadd231ss xmm2,xmm5,xmm4
    46e2:	vfmadd231ss xmm1,xmm5,xmm4
    46e7:	vfmadd231ss xmm0,xmm5,xmm4
    46ec:	vfmadd231ss xmm3,xmm5,xmm4
    46f1:	vfmadd231ss xmm2,xmm5,xmm4
    46f6:	vfmadd231ss xmm1,xmm5,xmm4
    46fb:	vfmadd231ss xmm0,xmm5,xmm4
    4700:	vfmadd231ss xmm3,xmm5,xmm4
    4705:	vfmadd231ss xmm2,xmm5,xmm4
    470a:	vfmadd231ss xmm1,xmm5,xmm4
    470f:	vfmadd231ss xmm0,xmm5,xmm4
    4714:	vfmadd231ss xmm3,xmm5,xmm4
    4719:	vfmadd231ss xmm2,xmm5,xmm4
    471e:	vfmadd231ss xmm1,xmm5,xmm4
    4723:	vfmadd231ss xmm0,xmm5,xmm4
    4728:	vfmadd231ss xmm3,xmm5,xmm4
    472d:	vfmadd231ss xmm2,xmm5,xmm4
    4732:	vfmadd231ss xmm1,xmm5,xmm4
    4737:	vfmadd231ss xmm0,xmm5,xmm4
    473c:	vfmadd231ss xmm3,xmm5,xmm4
    4741:	vfmadd231ss xmm2,xmm5,xmm4
    4746:	vfmadd231ss xmm1,xmm5,xmm4
    474b:	vfmadd231ss xmm0,xmm5,xmm4
    4750:	inc    rax
    4753:	cmp    rdi,rax
    4756:	jne    46b0 <void fp32_scalar_fma<4>(unsigned long)+0x30>
    475c:	ret
    475d:	vmovss xmm0,DWORD PTR [rip+0x5a7b]        # a1e0 <K_VALUES+0x20>
    4765:	vmovaps xmm1,xmm0
    4769:	vmovaps xmm2,xmm0
    476d:	vmovaps xmm3,xmm0
    4771:	ret
    4772:	data16 cs nop WORD PTR [rax+rax*1+0x0]
    477d:	nop    DWORD PTR [rax]

0000000000004780 <void fp32_scalar_fma<6>(unsigned long)>:
    4780:	endbr64
    4784:	test   rdi,rdi
    4787:	je     48bd <void fp32_scalar_fma<6>(unsigned long)+0x13d>
    478d:	vmovss xmm0,DWORD PTR [rip+0x5a4b]        # a1e0 <K_VALUES+0x20>
    4795:	xor    eax,eax
    4797:	vmovss xmm1,DWORD PTR [rip+0x5a51]        # a1f0 <K_VALUES+0x30>
    479f:	vmovaps xmm2,xmm0
    47a3:	vmovaps xmm3,xmm0
    47a7:	vmovaps xmm4,xmm0
    47ab:	vmovaps xmm5,xmm0
    47af:	vmovaps xmm6,xmm0
    47b3:	vmovaps xmm7,xmm0
    47b7:	nop    WORD PTR [rax+rax*1+0x0]
    47c0:	vfmadd231ss xmm7,xmm1,xmm0
    47c5:	vfmadd231ss xmm6,xmm1,xmm0
    47ca:	vfmadd231ss xmm5,xmm1,xmm0
    47cf:	vfmadd231ss xmm4,xmm1,xmm0
    47d4:	vfmadd231ss xmm3,xmm1,xmm0
    47d9:	vfmadd231ss xmm2,xmm1,xmm0
    47de:	vfmadd231ss xmm7,xmm1,xmm0
    47e3:	vfmadd231ss xmm6,xmm1,xmm0
    47e8:	vfmadd231ss xmm5,xmm1,xmm0
    47ed:	vfmadd231ss xmm4,xmm1,xmm0
    47f2:	vfmadd231ss xmm3,xmm1,xmm0
    47f7:	vfmadd231ss xmm2,xmm1,xmm0
    47fc:	vfmadd231ss xmm7,xmm1,xmm0
    4801:	vfmadd231ss xmm6,xmm1,xmm0
    4806:	vfmadd231ss xmm5,xmm1,xmm0
    480b:	vfmadd231ss xmm4,xmm1,xmm0
    4810:	vfmadd231ss xmm3,xmm1,xmm0
    4815:	vfmadd231ss xmm2,xmm1,xmm0
    481a:	vfmadd231ss xmm7,xmm1,xmm0
    481f:	vfmadd231ss xmm6,xmm1,xmm0
    4824:	vfmadd231ss xmm5,xmm1,xmm0
    4829:	vfmadd231ss xmm4,xmm1,xmm0
    482e:	vfmadd231ss xmm3,xmm1,xmm0
    4833:	vfmadd231ss xmm2,xmm1,xmm0
    4838:	vfmadd231ss xmm7,xmm1,xmm0
    483d:	vfmadd231ss xmm6,xmm1,xmm0
    4842:	vfmadd231ss xmm5,xmm1,xmm0
    4847:	vfmadd231ss xmm4,xmm1,xmm0
    484c:	vfmadd231ss xmm3,xmm1,xmm0
    4851:	vfmadd231ss xmm2,xmm1,xmm0
    4856:	vfmadd231ss xmm7,xmm1,xmm0
    485b:	vfmadd231ss xmm6,xmm1,xmm0
    4860:	vfmadd231ss xmm5,xmm1,xmm0
    4865:	vfmadd231ss xmm4,xmm1,xmm0
    486a:	vfmadd231ss xmm3,xmm1,xmm0
    486f:	vfmadd231ss xmm2,xmm1,xmm0
    4874:	vfmadd231ss xmm7,xmm1,xmm0
    4879:	vfmadd231ss xmm6,xmm1,xmm0
    487e:	vfmadd231ss xmm5,xmm1,xmm0
    4883:	vfmadd231ss xmm4,xmm1,xmm0
    4888:	vfmadd231ss xmm3,xmm1,xmm0
    488d:	vfmadd231ss xmm2,xmm1,xmm0
    4892:	vfmadd231ss xmm7,xmm1,xmm0
    4897:	vfmadd231ss xmm6,xmm1,xmm0
    489c:	vfmadd231ss xmm5,xmm1,xmm0
    48a1:	vfmadd231ss xmm4,xmm1,xmm0
    48a6:	vfmadd231ss xmm3,xmm1,xmm0
    48ab:	vfmadd231ss xmm2,xmm1,xmm0
    48b0:	inc    rax
    48b3:	cmp    rdi,rax
    48b6:	jne    47c0 <void fp32_scalar_fma<6>(unsigned long)+0x40>
    48bc:	ret
    48bd:	vmovss xmm2,DWORD PTR [rip+0x591b]        # a1e0 <K_VALUES+0x20>
    48c5:	vmovaps xmm3,xmm2
    48c9:	vmovaps xmm4,xmm2
    48cd:	vmovaps xmm5,xmm2
    48d1:	vmovaps xmm6,xmm2
    48d5:	vmovaps xmm7,xmm2
    48d9:	ret
    48da:	nop    WORD PTR [rax+rax*1+0x0]

00000000000048e0 <void fp32_scalar_fma<8>(unsigned long)>:
    48e0:	endbr64
    48e4:	test   rdi,rdi
    48e7:	je     4a6d <void fp32_scalar_fma<8>(unsigned long)+0x18d>
    48ed:	vmovss xmm0,DWORD PTR [rip+0x58eb]        # a1e0 <K_VALUES+0x20>
    48f5:	xor    eax,eax
    48f7:	vmovss xmm1,DWORD PTR [rip+0x58f1]        # a1f0 <K_VALUES+0x30>
    48ff:	vmovaps xmm2,xmm0
    4903:	vmovaps xmm3,xmm0
    4907:	vmovaps xmm4,xmm0
    490b:	vmovaps xmm5,xmm0
    490f:	vmovaps xmm6,xmm0
    4913:	vmovaps xmm7,xmm0
    4917:	vmovaps xmm8,xmm0
    491b:	vmovaps xmm9,xmm0
    491f:	nop
    4920:	vfmadd231ss xmm9,xmm1,xmm0
    4925:	vfmadd231ss xmm8,xmm1,xmm0
    492a:	vfmadd231ss xmm7,xmm1,xmm0
    492f:	vfmadd231ss xmm6,xmm1,xmm0
    4934:	vfmadd231ss xmm5,xmm1,xmm0
    4939:	vfmadd231ss xmm4,xmm1,xmm0
    493e:	vfmadd231ss xmm3,xmm1,xmm0
    4943:	vfmadd231ss xmm2,xmm1,xmm0
    4948:	vfmadd231ss xmm9,xmm1,xmm0
    494d:	vfmadd231ss xmm8,xmm1,xmm0
    4952:	vfmadd231ss xmm7,xmm1,xmm0
    4957:	vfmadd231ss xmm6,xmm1,xmm0
    495c:	vfmadd231ss xmm5,xmm1,xmm0
    4961:	vfmadd231ss xmm4,xmm1,xmm0
    4966:	vfmadd231ss xmm3,xmm1,xmm0
    496b:	vfmadd231ss xmm2,xmm1,xmm0
    4970:	vfmadd231ss xmm9,xmm1,xmm0
    4975:	vfmadd231ss xmm8,xmm1,xmm0
    497a:	vfmadd231ss xmm7,xmm1,xmm0
    497f:	vfmadd231ss xmm6,xmm1,xmm0
    4984:	vfmadd231ss xmm5,xmm1,xmm0
    4989:	vfmadd231ss xmm4,xmm1,xmm0
    498e:	vfmadd231ss xmm3,xmm1,xmm0
    4993:	vfmadd231ss xmm2,xmm1,xmm0
    4998:	vfmadd231ss xmm9,xmm1,xmm0
    499d:	vfmadd231ss xmm8,xmm1,xmm0
    49a2:	vfmadd231ss xmm7,xmm1,xmm0
    49a7:	vfmadd231ss xmm6,xmm1,xmm0
    49ac:	vfmadd231ss xmm5,xmm1,xmm0
    49b1:	vfmadd231ss xmm4,xmm1,xmm0
    49b6:	vfmadd231ss xmm3,xmm1,xmm0
    49bb:	vfmadd231ss xmm2,xmm1,xmm0
    49c0:	vfmadd231ss xmm9,xmm1,xmm0
    49c5:	vfmadd231ss xmm8,xmm1,xmm0
    49ca:	vfmadd231ss xmm7,xmm1,xmm0
    49cf:	vfmadd231ss xmm6,xmm1,xmm0
    49d4:	vfmadd231ss xmm5,xmm1,xmm0
    49d9:	vfmadd231ss xmm4,xmm1,xmm0
    49de:	vfmadd231ss xmm3,xmm1,xmm0
    49e3:	vfmadd231ss xmm2,xmm1,xmm0
    49e8:	vfmadd231ss xmm9,xmm1,xmm0
    49ed:	vfmadd231ss xmm8,xmm1,xmm0
    49f2:	vfmadd231ss xmm7,xmm1,xmm0
    49f7:	vfmadd231ss xmm6,xmm1,xmm0
    49fc:	vfmadd231ss xmm5,xmm1,xmm0
    4a01:	vfmadd231ss xmm4,xmm1,xmm0
    4a06:	vfmadd231ss xmm3,xmm1,xmm0
    4a0b:	vfmadd231ss xmm2,xmm1,xmm0
    4a10:	vfmadd231ss xmm9,xmm1,xmm0
    4a15:	vfmadd231ss xmm8,xmm1,xmm0
    4a1a:	vfmadd231ss xmm7,xmm1,xmm0
    4a1f:	vfmadd231ss xmm6,xmm1,xmm0
    4a24:	vfmadd231ss xmm5,xmm1,xmm0
    4a29:	vfmadd231ss xmm4,xmm1,xmm0
    4a2e:	vfmadd231ss xmm3,xmm1,xmm0
    4a33:	vfmadd231ss xmm2,xmm1,xmm0
    4a38:	vfmadd231ss xmm9,xmm1,xmm0
    4a3d:	vfmadd231ss xmm8,xmm1,xmm0
    4a42:	vfmadd231ss xmm7,xmm1,xmm0
    4a47:	vfmadd231ss xmm6,xmm1,xmm0
    4a4c:	vfmadd231ss xmm5,xmm1,xmm0
    4a51:	vfmadd231ss xmm4,xmm1,xmm0
    4a56:	vfmadd231ss xmm3,xmm1,xmm0
    4a5b:	vfmadd231ss xmm2,xmm1,xmm0
    4a60:	inc    rax
    4a63:	cmp    rdi,rax
    4a66:	jne    4920 <void fp32_scalar_fma<8>(unsigned long)+0x40>
    4a6c:	ret
    4a6d:	vmovss xmm2,DWORD PTR [rip+0x576b]        # a1e0 <K_VALUES+0x20>
    4a75:	vmovaps xmm3,xmm2
    4a79:	vmovaps xmm4,xmm2
    4a7d:	vmovaps xmm5,xmm2
    4a81:	vmovaps xmm6,xmm2
    4a85:	vmovaps xmm7,xmm2
    4a89:	vmovaps xmm8,xmm2
    4a8d:	vmovaps xmm9,xmm2
    4a91:	ret
    4a92:	data16 cs nop WORD PTR [rax+rax*1+0x0]
    4a9d:	nop    DWORD PTR [rax]

0000000000004aa0 <void fp32_scalar_fma<10>(unsigned long)>:
    4aa0:	endbr64
    4aa4:	test   rdi,rdi
    4aa7:	je     4c8d <void fp32_scalar_fma<10>(unsigned long)+0x1ed>
    4aad:	vmovss xmm0,DWORD PTR [rip+0x572b]        # a1e0 <K_VALUES+0x20>
    4ab5:	xor    eax,eax
    4ab7:	vmovss xmm1,DWORD PTR [rip+0x5731]        # a1f0 <K_VALUES+0x30>
    4abf:	vmovaps xmm2,xmm0
    4ac3:	vmovaps xmm3,xmm0
    4ac7:	vmovaps xmm4,xmm0
    4acb:	vmovaps xmm5,xmm0
    4acf:	vmovaps xmm6,xmm0
    4ad3:	vmovaps xmm7,xmm0
    4ad7:	vmovaps xmm8,xmm0
    4adb:	vmovaps xmm9,xmm0
    4adf:	vmovaps xmm10,xmm0
    4ae3:	vmovaps xmm11,xmm0
    4ae7:	nop    WORD PTR [rax+rax*1+0x0]
    4af0:	vfmadd231ss xmm11,xmm1,xmm0
    4af5:	vfmadd231ss xmm10,xmm1,xmm0
    4afa:	vfmadd231ss xmm9,xmm1,xmm0
    4aff:	vfmadd231ss xmm8,xmm1,xmm0
    4b04:	vfmadd231ss xmm7,xmm1,xmm0
    4b09:	vfmadd231ss xmm6,xmm1,xmm0
    4b0e:	vfmadd231ss xmm5,xmm1,xmm0
    4b13:	vfmadd231ss xmm4,xmm1,xmm0
    4b18:	vfmadd231ss xmm3,xmm1,xmm0
    4b1d:	vfmadd231ss xmm2,xmm1,xmm0
    4b22:	vfmadd231ss xmm11,xmm1,xmm0
    4b27:	vfmadd231ss xmm10,xmm1,xmm0
    4b2c:	vfmadd231ss xmm9,xmm1,xmm0
    4b31:	vfmadd231ss xmm8,xmm1,xmm0
    4b36:	vfmadd231ss xmm7,xmm1,xmm0
    4b3b:	vfmadd231ss xmm6,xmm1,xmm0
    4b40:	vfmadd231ss xmm5,xmm1,xmm0
    4b45:	vfmadd231ss xmm4,xmm1,xmm0
    4b4a:	vfmadd231ss xmm3,xmm1,xmm0
    4b4f:	vfmadd231ss xmm2,xmm1,xmm0
    4b54:	vfmadd231ss xmm11,xmm1,xmm0
    4b59:	vfmadd231ss xmm10,xmm1,xmm0
    4b5e:	vfmadd231ss xmm9,xmm1,xmm0
    4b63:	vfmadd231ss xmm8,xmm1,xmm0
    4b68:	vfmadd231ss xmm7,xmm1,xmm0
    4b6d:	vfmadd231ss xmm6,xmm1,xmm0
    4b72:	vfmadd231ss xmm5,xmm1,xmm0
    4b77:	vfmadd231ss xmm4,xmm1,xmm0
    4b7c:	vfmadd231ss xmm3,xmm1,xmm0
    4b81:	vfmadd231ss xmm2,xmm1,xmm0
    4b86:	vfmadd231ss xmm11,xmm1,xmm0
    4b8b:	vfmadd231ss xmm10,xmm1,xmm0
    4b90:	vfmadd231ss xmm9,xmm1,xmm0
    4b95:	vfmadd231ss xmm8,xmm1,xmm0
    4b9a:	vfmadd231ss xmm7,xmm1,xmm0
    4b9f:	vfmadd231ss xmm6,xmm1,xmm0
    4ba4:	vfmadd231ss xmm5,xmm1,xmm0
    4ba9:	vfmadd231ss xmm4,xmm1,xmm0
    4bae:	vfmadd231ss xmm3,xmm1,xmm0
    4bb3:	vfmadd231ss xmm2,xmm1,xmm0
    4bb8:	vfmadd231ss xmm11,xmm1,xmm0
    4bbd:	vfmadd231ss xmm10,xmm1,xmm0
    4bc2:	vfmadd231ss xmm9,xmm1,xmm0
    4bc7:	vfmadd231ss xmm8,xmm1,xmm0
    4bcc:	vfmadd231ss xmm7,xmm1,xmm0
    4bd1:	vfmadd231ss xmm6,xmm1,xmm0
    4bd6:	vfmadd231ss xmm5,xmm1,xmm0
    4bdb:	vfmadd231ss xmm4,xmm1,xmm0
    4be0:	vfmadd231ss xmm3,xmm1,xmm0
    4be5:	vfmadd231ss xmm2,xmm1,xmm0
    4bea:	vfmadd231ss xmm11,xmm1,xmm0
    4bef:	vfmadd231ss xmm10,xmm1,xmm0
    4bf4:	vfmadd231ss xmm9,xmm1,xmm0
    4bf9:	vfmadd231ss xmm8,xmm1,xmm0
    4bfe:	vfmadd231ss xmm7,xmm1,xmm0
    4c03:	vfmadd231ss xmm6,xmm1,xmm0
    4c08:	vfmadd231ss xmm5,xmm1,xmm0
    4c0d:	vfmadd231ss xmm4,xmm1,xmm0
    4c12:	vfmadd231ss xmm3,xmm1,xmm0
    4c17:	vfmadd231ss xmm2,xmm1,xmm0
    4c1c:	vfmadd231ss xmm11,xmm1,xmm0
    4c21:	vfmadd231ss xmm10,xmm1,xmm0
    4c26:	vfmadd231ss xmm9,xmm1,xmm0
    4c2b:	vfmadd231ss xmm8,xmm1,xmm0
    4c30:	vfmadd231ss xmm7,xmm1,xmm0
    4c35:	vfmadd231ss xmm6,xmm1,xmm0
    4c3a:	vfmadd231ss xmm5,xmm1,xmm0
    4c3f:	vfmadd231ss xmm4,xmm1,xmm0
    4c44:	vfmadd231ss xmm3,xmm1,xmm0
    4c49:	vfmadd231ss xmm2,xmm1,xmm0
    4c4e:	vfmadd231ss xmm11,xmm1,xmm0
    4c53:	vfmadd231ss xmm10,xmm1,xmm0
    4c58:	vfmadd231ss xmm9,xmm1,xmm0
    4c5d:	vfmadd231ss xmm8,xmm1,xmm0
    4c62:	vfmadd231ss xmm7,xmm1,xmm0
    4c67:	vfmadd231ss xmm6,xmm1,xmm0
    4c6c:	vfmadd231ss xmm5,xmm1,xmm0
    4c71:	vfmadd231ss xmm4,xmm1,xmm0
    4c76:	vfmadd231ss xmm3,xmm1,xmm0
    4c7b:	vfmadd231ss xmm2,xmm1,xmm0
    4c80:	inc    rax
    4c83:	cmp    rdi,rax
    4c86:	jne    4af0 <void fp32_scalar_fma<10>(unsigned long)+0x50>
    4c8c:	ret
    4c8d:	vmovss xmm2,DWORD PTR [rip+0x554b]        # a1e0 <K_VALUES+0x20>
    4c95:	vmovaps xmm3,xmm2
    4c99:	vmovaps xmm4,xmm2
    4c9d:	vmovaps xmm5,xmm2
    4ca1:	vmovaps xmm6,xmm2
    4ca5:	vmovaps xmm7,xmm2
    4ca9:	vmovaps xmm8,xmm2
    4cad:	vmovaps xmm9,xmm2
    4cb1:	vmovaps xmm10,xmm2
    4cb5:	vmovaps xmm11,xmm2
    4cb9:	ret
    4cba:	nop    WORD PTR [rax+rax*1+0x0]

0000000000004cc0 <void fp32_scalar_fma<12>(unsigned long)>:
    4cc0:	endbr64
    4cc4:	test   rdi,rdi
    4cc7:	je     4efd <void fp32_scalar_fma<12>(unsigned long)+0x23d>
    4ccd:	vmovss xmm0,DWORD PTR [rip+0x550b]        # a1e0 <K_VALUES+0x20>
    4cd5:	xor    eax,eax
    4cd7:	vmovss xmm1,DWORD PTR [rip+0x5511]        # a1f0 <K_VALUES+0x30>
    4cdf:	vmovaps xmm10,xmm0
    4ce3:	vmovaps xmm11,xmm0
    4ce7:	vmovaps xmm12,xmm0
    4ceb:	vmovaps xmm13,xmm0
    4cef:	vmovaps xmm2,xmm0
    4cf3:	vmovaps xmm3,xmm0
    4cf7:	vmovaps xmm4,xmm0
    4cfb:	vmovaps xmm5,xmm0
    4cff:	vmovaps xmm6,xmm0
    4d03:	vmovaps xmm7,xmm0
    4d07:	vmovaps xmm8,xmm0
    4d0b:	vmovaps xmm9,xmm0
    4d0f:	nop
    4d10:	vfmadd231ss xmm9,xmm1,xmm0
    4d15:	vfmadd231ss xmm8,xmm1,xmm0
    4d1a:	vfmadd231ss xmm7,xmm1,xmm0
    4d1f:	vfmadd231ss xmm6,xmm1,xmm0
    4d24:	vfmadd231ss xmm5,xmm1,xmm0
    4d29:	vfmadd231ss xmm4,xmm1,xmm0
    4d2e:	vfmadd231ss xmm3,xmm1,xmm0
    4d33:	vfmadd231ss xmm2,xmm1,xmm0
    4d38:	vfmadd231ss xmm13,xmm1,xmm0
    4d3d:	vfmadd231ss xmm12,xmm1,xmm0
    4d42:	vfmadd231ss xmm11,xmm1,xmm0
    4d47:	vfmadd231ss xmm10,xmm1,xmm0
    4d4c:	vfmadd231ss xmm9,xmm1,xmm0
    4d51:	vfmadd231ss xmm8,xmm1,xmm0
    4d56:	vfmadd231ss xmm7,xmm1,xmm0
    4d5b:	vfmadd231ss xmm6,xmm1,xmm0
    4d60:	vfmadd231ss xmm5,xmm1,xmm0
    4d65:	vfmadd231ss xmm4,xmm1,xmm0
    4d6a:	vfmadd231ss xmm3,xmm1,xmm0
    4d6f:	vfmadd231ss xmm2,xmm1,xmm0
    4d74:	vfmadd231ss xmm13,xmm1,xmm0
    4d79:	vfmadd231ss xmm12,xmm1,xmm0
    4d7e:	vfmadd231ss xmm11,xmm1,xmm0
    4d83:	vfmadd231ss xmm10,xmm1,xmm0
    4d88:	vfmadd231ss xmm9,xmm1,xmm0
    4d8d:	vfmadd231ss xmm8,xmm1,xmm0
    4d92:	vfmadd231ss xmm7,xmm1,xmm0
    4d97:	vfmadd231ss xmm6,xmm1,xmm0
    4d9c:	vfmadd231ss xmm5,xmm1,xmm0
    4da1:	vfmadd231ss xmm4,xmm1,xmm0
    4da6:	vfmadd231ss xmm3,xmm1,xmm0
    4dab:	vfmadd231ss xmm2,xmm1,xmm0
    4db0:	vfmadd231ss xmm13,xmm1,xmm0
    4db5:	vfmadd231ss xmm12,xmm1,xmm0
    4dba:	vfmadd231ss xmm11,xmm1,xmm0
    4dbf:	vfmadd231ss xmm10,xmm1,xmm0
    4dc4:	vfmadd231ss xmm9,xmm1,xmm0
    4dc9:	vfmadd231ss xmm8,xmm1,xmm0
    4dce:	vfmadd231ss xmm7,xmm1,xmm0
    4dd3:	vfmadd231ss xmm6,xmm1,xmm0
    4dd8:	vfmadd231ss xmm5,xmm1,xmm0
    4ddd:	vfmadd231ss xmm4,xmm1,xmm0
    4de2:	vfmadd231ss xmm3,xmm1,xmm0
    4de7:	vfmadd231ss xmm2,xmm1,xmm0
    4dec:	vfmadd231ss xmm13,xmm1,xmm0
    4df1:	vfmadd231ss xmm12,xmm1,xmm0
    4df6:	vfmadd231ss xmm11,xmm1,xmm0
    4dfb:	vfmadd231ss xmm10,xmm1,xmm0
    4e00:	vfmadd231ss xmm9,xmm1,xmm0
    4e05:	vfmadd231ss xmm8,xmm1,xmm0
    4e0a:	vfmadd231ss xmm7,xmm1,xmm0
    4e0f:	vfmadd231ss xmm6,xmm1,xmm0
    4e14:	vfmadd231ss xmm5,xmm1,xmm0
    4e19:	vfmadd231ss xmm4,xmm1,xmm0
    4e1e:	vfmadd231ss xmm3,xmm1,xmm0
    4e23:	vfmadd231ss xmm2,xmm1,xmm0
    4e28:	vfmadd231ss xmm13,xmm1,xmm0
    4e2d:	vfmadd231ss xmm12,xmm1,xmm0
    4e32:	vfmadd231ss xmm11,xmm1,xmm0
    4e37:	vfmadd231ss xmm10,xmm1,xmm0
    4e3c:	vfmadd231ss xmm9,xmm1,xmm0
    4e41:	vfmadd231ss xmm8,xmm1,xmm0
    4e46:	vfmadd231ss xmm7,xmm1,xmm0
    4e4b:	vfmadd231ss xmm6,xmm1,xmm0
    4e50:	vfmadd231ss xmm5,xmm1,xmm0
    4e55:	vfmadd231ss xmm4,xmm1,xmm0
    4e5a:	vfmadd231ss xmm3,xmm1,xmm0
    4e5f:	vfmadd231ss xmm2,xmm1,xmm0
    4e64:	vfmadd231ss xmm13,xmm1,xmm0
    4e69:	vfmadd231ss xmm12,xmm1,xmm0
    4e6e:	vfmadd231ss xmm11,xmm1,xmm0
    4e73:	vfmadd231ss xmm10,xmm1,xmm0
    4e78:	vfmadd231ss xmm9,xmm1,xmm0
    4e7d:	vfmadd231ss xmm8,xmm1,xmm0
    4e82:	vfmadd231ss xmm7,xmm1,xmm0
    4e87:	vfmadd231ss xmm6,xmm1,xmm0
    4e8c:	vfmadd231ss xmm5,xmm1,xmm0
    4e91:	vfmadd231ss xmm4,xmm1,xmm0
    4e96:	vfmadd231ss xmm3,xmm1,xmm0
    4e9b:	vfmadd231ss xmm2,xmm1,xmm0
    4ea0:	vfmadd231ss xmm13,xmm1,xmm0
    4ea5:	vfmadd231ss xmm12,xmm1,xmm0
    4eaa:	vfmadd231ss xmm11,xmm1,xmm0
    4eaf:	vfmadd231ss xmm10,xmm1,xmm0
    4eb4:	vfmadd231ss xmm9,xmm1,xmm0
    4eb9:	vfmadd231ss xmm8,xmm1,xmm0
    4ebe:	vfmadd231ss xmm7,xmm1,xmm0
    4ec3:	vfmadd231ss xmm6,xmm1,xmm0
    4ec8:	vfmadd231ss xmm5,xmm1,xmm0
    4ecd:	vfmadd231ss xmm4,xmm1,xmm0
    4ed2:	vfmadd231ss xmm3,xmm1,xmm0
    4ed7:	vfmadd231ss xmm2,xmm1,xmm0
    4edc:	vfmadd231ss xmm13,xmm1,xmm0
    4ee1:	vfmadd231ss xmm12,xmm1,xmm0
    4ee6:	vfmadd231ss xmm11,xmm1,xmm0
    4eeb:	vfmadd231ss xmm10,xmm1,xmm0
    4ef0:	inc    rax
    4ef3:	cmp    rdi,rax
    4ef6:	jne    4d10 <void fp32_scalar_fma<12>(unsigned long)+0x50>
    4efc:	ret
    4efd:	vmovss xmm10,DWORD PTR [rip+0x52db]        # a1e0 <K_VALUES+0x20>
    4f05:	vmovaps xmm11,xmm10
    4f0a:	vmovaps xmm12,xmm10
    4f0f:	vmovaps xmm13,xmm10
    4f14:	vmovaps xmm2,xmm10
    4f18:	vmovaps xmm3,xmm10
    4f1c:	vmovaps xmm4,xmm10
    4f20:	vmovaps xmm5,xmm10
    4f24:	vmovaps xmm6,xmm10
    4f28:	vmovaps xmm7,xmm10
    4f2c:	vmovaps xmm8,xmm10
    4f31:	vmovaps xmm9,xmm10
    4f36:	ret
    4f37:	nop    WORD PTR [rax+rax*1+0x0]

0000000000004f40 <void fp32_scalar_fma<16>(unsigned long)>:
    4f40:	endbr64
    4f44:	test   rdi,rdi
    4f47:	je     5245 <void fp32_scalar_fma<16>(unsigned long)+0x305>
    4f4d:	vmovss xmm0,DWORD PTR [rip+0x528b]        # a1e0 <K_VALUES+0x20>
    4f55:	xor    eax,eax
    4f57:	vmovss xmm1,DWORD PTR [rip+0x5291]        # a1f0 <K_VALUES+0x30>
    4f5f:	vmovaps xmm2,xmm0
    4f63:	vmovaps xmm17,xmm0
    4f69:	vmovaps xmm3,xmm0
    4f6d:	vmovaps xmm4,xmm0
    4f71:	vmovaps xmm5,xmm0
    4f75:	vmovaps xmm6,xmm0
    4f79:	vmovaps xmm7,xmm0
    4f7d:	vmovaps xmm8,xmm0
    4f81:	vmovaps xmm9,xmm0
    4f85:	vmovaps xmm10,xmm0
    4f89:	vmovaps xmm11,xmm0
    4f8d:	vmovaps xmm12,xmm0
    4f91:	vmovaps xmm13,xmm0
    4f95:	vmovaps xmm14,xmm0
    4f99:	vmovaps xmm15,xmm0
    4f9d:	vmovaps xmm16,xmm0
    4fa3:	nop    DWORD PTR [rax+rax*1+0x0]
    4fa8:	vfmadd231ss xmm16,xmm1,xmm0
    4fae:	vfmadd231ss xmm15,xmm1,xmm0
    4fb3:	vfmadd231ss xmm14,xmm1,xmm0
    4fb8:	vfmadd231ss xmm13,xmm1,xmm0
    4fbd:	vfmadd231ss xmm12,xmm1,xmm0
    4fc2:	vfmadd231ss xmm11,xmm1,xmm0
    4fc7:	vfmadd231ss xmm10,xmm1,xmm0
    4fcc:	vfmadd231ss xmm9,xmm1,xmm0
    4fd1:	vfmadd231ss xmm8,xmm1,xmm0
    4fd6:	vfmadd231ss xmm7,xmm1,xmm0
    4fdb:	vfmadd231ss xmm6,xmm1,xmm0
    4fe0:	vfmadd231ss xmm5,xmm1,xmm0
    4fe5:	vfmadd231ss xmm4,xmm1,xmm0
    4fea:	vfmadd231ss xmm3,xmm1,xmm0
    4fef:	vfmadd231ss xmm17,xmm1,xmm0
    4ff5:	vfmadd231ss xmm2,xmm1,xmm0
    4ffa:	vfmadd231ss xmm16,xmm1,xmm0
    5000:	vfmadd231ss xmm15,xmm1,xmm0
    5005:	vfmadd231ss xmm14,xmm1,xmm0
    500a:	vfmadd231ss xmm13,xmm1,xmm0
    500f:	vfmadd231ss xmm12,xmm1,xmm0
    5014:	vfmadd231ss xmm11,xmm1,xmm0
    5019:	vfmadd231ss xmm10,xmm1,xmm0
    501e:	vfmadd231ss xmm9,xmm1,xmm0
    5023:	vfmadd231ss xmm8,xmm1,xmm0
    5028:	vfmadd231ss xmm7,xmm1,xmm0
    502d:	vfmadd231ss xmm6,xmm1,xmm0
    5032:	vfmadd231ss xmm5,xmm1,xmm0
    5037:	vfmadd231ss xmm4,xmm1,xmm0
    503c:	vfmadd231ss xmm3,xmm1,xmm0
    5041:	vfmadd231ss xmm17,xmm1,xmm0
    5047:	vfmadd231ss xmm2,xmm1,xmm0
    504c:	vfmadd231ss xmm16,xmm1,xmm0
    5052:	vfmadd231ss xmm15,xmm1,xmm0
    5057:	vfmadd231ss xmm14,xmm1,xmm0
    505c:	vfmadd231ss xmm13,xmm1,xmm0
    5061:	vfmadd231ss xmm12,xmm1,xmm0
    5066:	vfmadd231ss xmm11,xmm1,xmm0
    506b:	vfmadd231ss xmm10,xmm1,xmm0
    5070:	vfmadd231ss xmm9,xmm1,xmm0
    5075:	vfmadd231ss xmm8,xmm1,xmm0
    507a:	vfmadd231ss xmm7,xmm1,xmm0
    507f:	vfmadd231ss xmm6,xmm1,xmm0
    5084:	vfmadd231ss xmm5,xmm1,xmm0
    5089:	vfmadd231ss xmm4,xmm1,xmm0
    508e:	vfmadd231ss xmm3,xmm1,xmm0
    5093:	vfmadd231ss xmm17,xmm1,xmm0
    5099:	vfmadd231ss xmm2,xmm1,xmm0
    509e:	vfmadd231ss xmm16,xmm1,xmm0
    50a4:	vfmadd231ss xmm15,xmm1,xmm0
    50a9:	vfmadd231ss xmm14,xmm1,xmm0
    50ae:	vfmadd231ss xmm13,xmm1,xmm0
    50b3:	vfmadd231ss xmm12,xmm1,xmm0
    50b8:	vfmadd231ss xmm11,xmm1,xmm0
    50bd:	vfmadd231ss xmm10,xmm1,xmm0
    50c2:	vfmadd231ss xmm9,xmm1,xmm0
    50c7:	vfmadd231ss xmm8,xmm1,xmm0
    50cc:	vfmadd231ss xmm7,xmm1,xmm0
    50d1:	vfmadd231ss xmm6,xmm1,xmm0
    50d6:	vfmadd231ss xmm5,xmm1,xmm0
    50db:	vfmadd231ss xmm4,xmm1,xmm0
    50e0:	vfmadd231ss xmm3,xmm1,xmm0
    50e5:	vfmadd231ss xmm17,xmm1,xmm0
    50eb:	vfmadd231ss xmm2,xmm1,xmm0
    50f0:	vfmadd231ss xmm16,xmm1,xmm0
    50f6:	vfmadd231ss xmm15,xmm1,xmm0
    50fb:	vfmadd231ss xmm14,xmm1,xmm0
    5100:	vfmadd231ss xmm13,xmm1,xmm0
    5105:	vfmadd231ss xmm12,xmm1,xmm0
    510a:	vfmadd231ss xmm11,xmm1,xmm0
    510f:	vfmadd231ss xmm10,xmm1,xmm0
    5114:	vfmadd231ss xmm9,xmm1,xmm0
    5119:	vfmadd231ss xmm8,xmm1,xmm0
    511e:	vfmadd231ss xmm7,xmm1,xmm0
    5123:	vfmadd231ss xmm6,xmm1,xmm0
    5128:	vfmadd231ss xmm5,xmm1,xmm0
    512d:	vfmadd231ss xmm4,xmm1,xmm0
    5132:	vfmadd231ss xmm3,xmm1,xmm0
    5137:	vfmadd231ss xmm17,xmm1,xmm0
    513d:	vfmadd231ss xmm2,xmm1,xmm0
    5142:	vfmadd231ss xmm16,xmm1,xmm0
    5148:	vfmadd231ss xmm15,xmm1,xmm0
    514d:	vfmadd231ss xmm14,xmm1,xmm0
    5152:	vfmadd231ss xmm13,xmm1,xmm0
    5157:	vfmadd231ss xmm12,xmm1,xmm0
    515c:	vfmadd231ss xmm11,xmm1,xmm0
    5161:	vfmadd231ss xmm10,xmm1,xmm0
    5166:	vfmadd231ss xmm9,xmm1,xmm0
    516b:	vfmadd231ss xmm8,xmm1,xmm0
    5170:	vfmadd231ss xmm7,xmm1,xmm0
    5175:	vfmadd231ss xmm6,xmm1,xmm0
    517a:	vfmadd231ss xmm5,xmm1,xmm0
    517f:	vfmadd231ss xmm4,xmm1,xmm0
    5184:	vfmadd231ss xmm3,xmm1,xmm0
    5189:	vfmadd231ss xmm17,xmm1,xmm0
    518f:	vfmadd231ss xmm2,xmm1,xmm0
    5194:	vfmadd231ss xmm16,xmm1,xmm0
    519a:	vfmadd231ss xmm15,xmm1,xmm0
    519f:	vfmadd231ss xmm14,xmm1,xmm0
    51a4:	vfmadd231ss xmm13,xmm1,xmm0
    51a9:	vfmadd231ss xmm12,xmm1,xmm0
    51ae:	vfmadd231ss xmm11,xmm1,xmm0
    51b3:	vfmadd231ss xmm10,xmm1,xmm0
    51b8:	vfmadd231ss xmm9,xmm1,xmm0
    51bd:	vfmadd231ss xmm8,xmm1,xmm0
    51c2:	vfmadd231ss xmm7,xmm1,xmm0
    51c7:	vfmadd231ss xmm6,xmm1,xmm0
    51cc:	vfmadd231ss xmm5,xmm1,xmm0
    51d1:	vfmadd231ss xmm4,xmm1,xmm0
    51d6:	vfmadd231ss xmm3,xmm1,xmm0
    51db:	vfmadd231ss xmm17,xmm1,xmm0
    51e1:	vfmadd231ss xmm2,xmm1,xmm0
    51e6:	vfmadd231ss xmm16,xmm1,xmm0
    51ec:	vfmadd231ss xmm15,xmm1,xmm0
    51f1:	vfmadd231ss xmm14,xmm1,xmm0
    51f6:	vfmadd231ss xmm13,xmm1,xmm0
    51fb:	vfmadd231ss xmm12,xmm1,xmm0
    5200:	vfmadd231ss xmm11,xmm1,xmm0
    5205:	vfmadd231ss xmm10,xmm1,xmm0
    520a:	vfmadd231ss xmm9,xmm1,xmm0
    520f:	vfmadd231ss xmm8,xmm1,xmm0
    5214:	vfmadd231ss xmm7,xmm1,xmm0
    5219:	vfmadd231ss xmm6,xmm1,xmm0
    521e:	vfmadd231ss xmm5,xmm1,xmm0
    5223:	vfmadd231ss xmm4,xmm1,xmm0
    5228:	vfmadd231ss xmm3,xmm1,xmm0
    522d:	vfmadd231ss xmm17,xmm1,xmm0
    5233:	vfmadd231ss xmm2,xmm1,xmm0
    5238:	inc    rax
    523b:	cmp    rdi,rax
    523e:	jne    4fa8 <void fp32_scalar_fma<16>(unsigned long)+0x68>
    5244:	ret
    5245:	vmovss xmm2,DWORD PTR [rip+0x4f93]        # a1e0 <K_VALUES+0x20>
    524d:	vmovaps xmm17,xmm2
    5253:	vmovaps xmm3,xmm2
    5257:	vmovaps xmm4,xmm2
    525b:	vmovaps xmm5,xmm2
    525f:	vmovaps xmm6,xmm2
    5263:	vmovaps xmm7,xmm2
    5267:	vmovaps xmm8,xmm2
    526b:	vmovaps xmm9,xmm2
    526f:	vmovaps xmm10,xmm2
    5273:	vmovaps xmm11,xmm2
    5277:	vmovaps xmm12,xmm2
    527b:	vmovaps xmm13,xmm2
    527f:	vmovaps xmm14,xmm2
    5283:	vmovaps xmm15,xmm2
    5287:	vmovaps xmm16,xmm2
    528d:	ret
    528e:	xchg   ax,ax

0000000000005290 <void fp32_sse_fma<1>(unsigned long)>:
    5290:	endbr64
    5294:	test   rdi,rdi
    5297:	je     52e9 <void fp32_sse_fma<1>(unsigned long)+0x59>
    5299:	vbroadcastss xmm1,DWORD PTR [rip+0x4f3e]        # a1e0 <K_VALUES+0x20>
    52a2:	vbroadcastss xmm2,DWORD PTR [rip+0x4f45]        # a1f0 <K_VALUES+0x30>
    52ab:	xor    eax,eax
    52ad:	vmovaps xmm0,xmm1
    52b1:	nop    DWORD PTR [rax+0x0]
    52b8:	vfmadd231ps xmm0,xmm2,xmm1
    52bd:	vfmadd231ps xmm0,xmm2,xmm1
    52c2:	vfmadd231ps xmm0,xmm2,xmm1
    52c7:	vfmadd231ps xmm0,xmm2,xmm1
    52cc:	vfmadd231ps xmm0,xmm2,xmm1
    52d1:	vfmadd231ps xmm0,xmm2,xmm1
    52d6:	vfmadd231ps xmm0,xmm2,xmm1
    52db:	vfmadd231ps xmm0,xmm2,xmm1
    52e0:	inc    rax
    52e3:	cmp    rdi,rax
    52e6:	jne    52b8 <void fp32_sse_fma<1>(unsigned long)+0x28>
    52e8:	ret
    52e9:	vbroadcastss xmm0,DWORD PTR [rip+0x4eee]        # a1e0 <K_VALUES+0x20>
    52f2:	ret
    52f3:	data16 cs nop WORD PTR [rax+rax*1+0x0]
    52fe:	xchg   ax,ax

0000000000005300 <void fp32_sse_fma<2>(unsigned long)>:
    5300:	endbr64
    5304:	test   rdi,rdi
    5307:	je     5381 <void fp32_sse_fma<2>(unsigned long)+0x81>
    5309:	vbroadcastss xmm2,DWORD PTR [rip+0x4ece]        # a1e0 <K_VALUES+0x20>
    5312:	vbroadcastss xmm3,DWORD PTR [rip+0x4ed5]        # a1f0 <K_VALUES+0x30>
    531b:	xor    eax,eax
    531d:	vmovaps xmm0,xmm2
    5321:	vmovaps xmm1,xmm2
    5325:	nop    DWORD PTR [rax]
    5328:	vfmadd231ps xmm1,xmm3,xmm2
    532d:	vfmadd231ps xmm0,xmm3,xmm2
    5332:	vfmadd231ps xmm1,xmm3,xmm2
    5337:	vfmadd231ps xmm0,xmm3,xmm2
    533c:	vfmadd231ps xmm1,xmm3,xmm2
    5341:	vfmadd231ps xmm0,xmm3,xmm2
    5346:	vfmadd231ps xmm1,xmm3,xmm2
    534b:	vfmadd231ps xmm0,xmm3,xmm2
    5350:	vfmadd231ps xmm1,xmm3,xmm2
    5355:	vfmadd231ps xmm0,xmm3,xmm2
    535a:	vfmadd231ps xmm1,xmm3,xmm2
    535f:	vfmadd231ps xmm0,xmm3,xmm2
    5364:	vfmadd231ps xmm1,xmm3,xmm2
    5369:	vfmadd231ps xmm0,xmm3,xmm2
    536e:	vfmadd231ps xmm1,xmm3,xmm2
    5373:	vfmadd231ps xmm0,xmm3,xmm2
    5378:	inc    rax
    537b:	cmp    rdi,rax
    537e:	jne    5328 <void fp32_sse_fma<2>(unsigned long)+0x28>
    5380:	ret
    5381:	vbroadcastss xmm0,DWORD PTR [rip+0x4e56]        # a1e0 <K_VALUES+0x20>
    538a:	vmovaps xmm1,xmm0
    538e:	ret
    538f:	nop

0000000000005390 <void fp32_sse_fma<4>(unsigned long)>:
    5390:	endbr64
    5394:	test   rdi,rdi
    5397:	je     5475 <void fp32_sse_fma<4>(unsigned long)+0xe5>
    539d:	vbroadcastss xmm4,DWORD PTR [rip+0x4e3a]        # a1e0 <K_VALUES+0x20>
    53a6:	vbroadcastss xmm5,DWORD PTR [rip+0x4e41]        # a1f0 <K_VALUES+0x30>
    53af:	xor    eax,eax
    53b1:	vmovaps xmm0,xmm4
    53b5:	vmovaps xmm1,xmm4
    53b9:	vmovaps xmm2,xmm4
    53bd:	vmovaps xmm3,xmm4
    53c1:	nop    DWORD PTR [rax+0x0]
    53c8:	vfmadd231ps xmm3,xmm5,xmm4
    53cd:	vfmadd231ps xmm2,xmm5,xmm4
    53d2:	vfmadd231ps xmm1,xmm5,xmm4
    53d7:	vfmadd231ps xmm0,xmm5,xmm4
    53dc:	vfmadd231ps xmm3,xmm5,xmm4
    53e1:	vfmadd231ps xmm2,xmm5,xmm4
    53e6:	vfmadd231ps xmm1,xmm5,xmm4
    53eb:	vfmadd231ps xmm0,xmm5,xmm4
    53f0:	vfmadd231ps xmm3,xmm5,xmm4
    53f5:	vfmadd231ps xmm2,xmm5,xmm4
    53fa:	vfmadd231ps xmm1,xmm5,xmm4
    53ff:	vfmadd231ps xmm0,xmm5,xmm4
    5404:	vfmadd231ps xmm3,xmm5,xmm4
    5409:	vfmadd231ps xmm2,xmm5,xmm4
    540e:	vfmadd231ps xmm1,xmm5,xmm4
    5413:	vfmadd231ps xmm0,xmm5,xmm4
    5418:	vfmadd231ps xmm3,xmm5,xmm4
    541d:	vfmadd231ps xmm2,xmm5,xmm4
    5422:	vfmadd231ps xmm1,xmm5,xmm4
    5427:	vfmadd231ps xmm0,xmm5,xmm4
    542c:	vfmadd231ps xmm3,xmm5,xmm4
    5431:	vfmadd231ps xmm2,xmm5,xmm4
    5436:	vfmadd231ps xmm1,xmm5,xmm4
    543b:	vfmadd231ps xmm0,xmm5,xmm4
    5440:	vfmadd231ps xmm3,xmm5,xmm4
    5445:	vfmadd231ps xmm2,xmm5,xmm4
    544a:	vfmadd231ps xmm1,xmm5,xmm4
    544f:	vfmadd231ps xmm0,xmm5,xmm4
    5454:	vfmadd231ps xmm3,xmm5,xmm4
    5459:	vfmadd231ps xmm2,xmm5,xmm4
    545e:	vfmadd231ps xmm1,xmm5,xmm4
    5463:	vfmadd231ps xmm0,xmm5,xmm4
    5468:	inc    rax
    546b:	cmp    rdi,rax
    546e:	jne    53c8 <void fp32_sse_fma<4>(unsigned long)+0x38>
    5474:	ret
    5475:	vbroadcastss xmm0,DWORD PTR [rip+0x4d62]        # a1e0 <K_VALUES+0x20>
    547e:	vmovaps xmm1,xmm0
    5482:	vmovaps xmm2,xmm0
    5486:	vmovaps xmm3,xmm0
    548a:	ret
    548b:	nop    DWORD PTR [rax+rax*1+0x0]

0000000000005490 <void fp32_sse_fma<6>(unsigned long)>:
    5490:	endbr64
    5494:	test   rdi,rdi
    5497:	je     55cd <void fp32_sse_fma<6>(unsigned long)+0x13d>
    549d:	vbroadcastss xmm0,DWORD PTR [rip+0x4d3a]        # a1e0 <K_VALUES+0x20>
    54a6:	vbroadcastss xmm1,DWORD PTR [rip+0x4d41]        # a1f0 <K_VALUES+0x30>
    54af:	xor    eax,eax
    54b1:	vmovaps xmm2,xmm0
    54b5:	vmovaps xmm3,xmm0
    54b9:	vmovaps xmm4,xmm0
    54bd:	vmovaps xmm5,xmm0
    54c1:	vmovaps xmm6,xmm0
    54c5:	vmovaps xmm7,xmm0
    54c9:	nop    DWORD PTR [rax+0x0]
    54d0:	vfmadd231ps xmm7,xmm1,xmm0
    54d5:	vfmadd231ps xmm6,xmm1,xmm0
    54da:	vfmadd231ps xmm5,xmm1,xmm0
    54df:	vfmadd231ps xmm4,xmm1,xmm0
    54e4:	vfmadd231ps xmm3,xmm1,xmm0
    54e9:	vfmadd231ps xmm2,xmm1,xmm0
    54ee:	vfmadd231ps xmm7,xmm1,xmm0
    54f3:	vfmadd231ps xmm6,xmm1,xmm0
    54f8:	vfmadd231ps xmm5,xmm1,xmm0
    54fd:	vfmadd231ps xmm4,xmm1,xmm0
    5502:	vfmadd231ps xmm3,xmm1,xmm0
    5507:	vfmadd231ps xmm2,xmm1,xmm0
    550c:	vfmadd231ps xmm7,xmm1,xmm0
    5511:	vfmadd231ps xmm6,xmm1,xmm0
    5516:	vfmadd231ps xmm5,xmm1,xmm0
    551b:	vfmadd231ps xmm4,xmm1,xmm0
    5520:	vfmadd231ps xmm3,xmm1,xmm0
    5525:	vfmadd231ps xmm2,xmm1,xmm0
    552a:	vfmadd231ps xmm7,xmm1,xmm0
    552f:	vfmadd231ps xmm6,xmm1,xmm0
    5534:	vfmadd231ps xmm5,xmm1,xmm0
    5539:	vfmadd231ps xmm4,xmm1,xmm0
    553e:	vfmadd231ps xmm3,xmm1,xmm0
    5543:	vfmadd231ps xmm2,xmm1,xmm0
    5548:	vfmadd231ps xmm7,xmm1,xmm0
    554d:	vfmadd231ps xmm6,xmm1,xmm0
    5552:	vfmadd231ps xmm5,xmm1,xmm0
    5557:	vfmadd231ps xmm4,xmm1,xmm0
    555c:	vfmadd231ps xmm3,xmm1,xmm0
    5561:	vfmadd231ps xmm2,xmm1,xmm0
    5566:	vfmadd231ps xmm7,xmm1,xmm0
    556b:	vfmadd231ps xmm6,xmm1,xmm0
    5570:	vfmadd231ps xmm5,xmm1,xmm0
    5575:	vfmadd231ps xmm4,xmm1,xmm0
    557a:	vfmadd231ps xmm3,xmm1,xmm0
    557f:	vfmadd231ps xmm2,xmm1,xmm0
    5584:	vfmadd231ps xmm7,xmm1,xmm0
    5589:	vfmadd231ps xmm6,xmm1,xmm0
    558e:	vfmadd231ps xmm5,xmm1,xmm0
    5593:	vfmadd231ps xmm4,xmm1,xmm0
    5598:	vfmadd231ps xmm3,xmm1,xmm0
    559d:	vfmadd231ps xmm2,xmm1,xmm0
    55a2:	vfmadd231ps xmm7,xmm1,xmm0
    55a7:	vfmadd231ps xmm6,xmm1,xmm0
    55ac:	vfmadd231ps xmm5,xmm1,xmm0
    55b1:	vfmadd231ps xmm4,xmm1,xmm0
    55b6:	vfmadd231ps xmm3,xmm1,xmm0
    55bb:	vfmadd231ps xmm2,xmm1,xmm0
    55c0:	inc    rax
    55c3:	cmp    rdi,rax
    55c6:	jne    54d0 <void fp32_sse_fma<6>(unsigned long)+0x40>
    55cc:	ret
    55cd:	vbroadcastss xmm2,DWORD PTR [rip+0x4c0a]        # a1e0 <K_VALUES+0x20>
    55d6:	vmovaps xmm3,xmm2
    55da:	vmovaps xmm4,xmm2
    55de:	vmovaps xmm5,xmm2
    55e2:	vmovaps xmm6,xmm2
    55e6:	vmovaps xmm7,xmm2
    55ea:	ret
    55eb:	nop    DWORD PTR [rax+rax*1+0x0]

00000000000055f0 <void fp32_sse_fma<8>(unsigned long)>:
    55f0:	endbr64
    55f4:	test   rdi,rdi
    55f7:	je     5785 <void fp32_sse_fma<8>(unsigned long)+0x195>
    55fd:	vbroadcastss xmm0,DWORD PTR [rip+0x4bda]        # a1e0 <K_VALUES+0x20>
    5606:	vbroadcastss xmm1,DWORD PTR [rip+0x4be1]        # a1f0 <K_VALUES+0x30>
    560f:	xor    eax,eax
    5611:	vmovaps xmm2,xmm0
    5615:	vmovaps xmm3,xmm0
    5619:	vmovaps xmm4,xmm0
    561d:	vmovaps xmm5,xmm0
    5621:	vmovaps xmm6,xmm0
    5625:	vmovaps xmm7,xmm0
    5629:	vmovaps xmm8,xmm0
    562d:	vmovaps xmm9,xmm0
    5631:	nop    DWORD PTR [rax+0x0]
    5638:	vfmadd231ps xmm9,xmm1,xmm0
    563d:	vfmadd231ps xmm8,xmm1,xmm0
    5642:	vfmadd231ps xmm7,xmm1,xmm0
    5647:	vfmadd231ps xmm6,xmm1,xmm0
    564c:	vfmadd231ps xmm5,xmm1,xmm0
    5651:	vfmadd231ps xmm4,xmm1,xmm0
    5656:	vfmadd231ps xmm3,xmm1,xmm0
    565b:	vfmadd231ps xmm2,xmm1,xmm0
    5660:	vfmadd231ps xmm9,xmm1,xmm0
    5665:	vfmadd231ps xmm8,xmm1,xmm0
    566a:	vfmadd231ps xmm7,xmm1,xmm0
    566f:	vfmadd231ps xmm6,xmm1,xmm0
    5674:	vfmadd231ps xmm5,xmm1,xmm0
    5679:	vfmadd231ps xmm4,xmm1,xmm0
    567e:	vfmadd231ps xmm3,xmm1,xmm0
    5683:	vfmadd231ps xmm2,xmm1,xmm0
    5688:	vfmadd231ps xmm9,xmm1,xmm0
    568d:	vfmadd231ps xmm8,xmm1,xmm0
    5692:	vfmadd231ps xmm7,xmm1,xmm0
    5697:	vfmadd231ps xmm6,xmm1,xmm0
    569c:	vfmadd231ps xmm5,xmm1,xmm0
    56a1:	vfmadd231ps xmm4,xmm1,xmm0
    56a6:	vfmadd231ps xmm3,xmm1,xmm0
    56ab:	vfmadd231ps xmm2,xmm1,xmm0
    56b0:	vfmadd231ps xmm9,xmm1,xmm0
    56b5:	vfmadd231ps xmm8,xmm1,xmm0
    56ba:	vfmadd231ps xmm7,xmm1,xmm0
    56bf:	vfmadd231ps xmm6,xmm1,xmm0
    56c4:	vfmadd231ps xmm5,xmm1,xmm0
    56c9:	vfmadd231ps xmm4,xmm1,xmm0
    56ce:	vfmadd231ps xmm3,xmm1,xmm0
    56d3:	vfmadd231ps xmm2,xmm1,xmm0
    56d8:	vfmadd231ps xmm9,xmm1,xmm0
    56dd:	vfmadd231ps xmm8,xmm1,xmm0
    56e2:	vfmadd231ps xmm7,xmm1,xmm0
    56e7:	vfmadd231ps xmm6,xmm1,xmm0
    56ec:	vfmadd231ps xmm5,xmm1,xmm0
    56f1:	vfmadd231ps xmm4,xmm1,xmm0
    56f6:	vfmadd231ps xmm3,xmm1,xmm0
    56fb:	vfmadd231ps xmm2,xmm1,xmm0
    5700:	vfmadd231ps xmm9,xmm1,xmm0
    5705:	vfmadd231ps xmm8,xmm1,xmm0
    570a:	vfmadd231ps xmm7,xmm1,xmm0
    570f:	vfmadd231ps xmm6,xmm1,xmm0
    5714:	vfmadd231ps xmm5,xmm1,xmm0
    5719:	vfmadd231ps xmm4,xmm1,xmm0
    571e:	vfmadd231ps xmm3,xmm1,xmm0
    5723:	vfmadd231ps xmm2,xmm1,xmm0
    5728:	vfmadd231ps xmm9,xmm1,xmm0
    572d:	vfmadd231ps xmm8,xmm1,xmm0
    5732:	vfmadd231ps xmm7,xmm1,xmm0
    5737:	vfmadd231ps xmm6,xmm1,xmm0
    573c:	vfmadd231ps xmm5,xmm1,xmm0
    5741:	vfmadd231ps xmm4,xmm1,xmm0
    5746:	vfmadd231ps xmm3,xmm1,xmm0
    574b:	vfmadd231ps xmm2,xmm1,xmm0
    5750:	vfmadd231ps xmm9,xmm1,xmm0
    5755:	vfmadd231ps xmm8,xmm1,xmm0
    575a:	vfmadd231ps xmm7,xmm1,xmm0
    575f:	vfmadd231ps xmm6,xmm1,xmm0
    5764:	vfmadd231ps xmm5,xmm1,xmm0
    5769:	vfmadd231ps xmm4,xmm1,xmm0
    576e:	vfmadd231ps xmm3,xmm1,xmm0
    5773:	vfmadd231ps xmm2,xmm1,xmm0
    5778:	inc    rax
    577b:	cmp    rdi,rax
    577e:	jne    5638 <void fp32_sse_fma<8>(unsigned long)+0x48>
    5784:	ret
    5785:	vbroadcastss xmm2,DWORD PTR [rip+0x4a52]        # a1e0 <K_VALUES+0x20>
    578e:	vmovaps xmm3,xmm2
    5792:	vmovaps xmm4,xmm2
    5796:	vmovaps xmm5,xmm2
    579a:	vmovaps xmm6,xmm2
    579e:	vmovaps xmm7,xmm2
    57a2:	vmovaps xmm8,xmm2
    57a6:	vmovaps xmm9,xmm2
    57aa:	ret
    57ab:	nop    DWORD PTR [rax+rax*1+0x0]

00000000000057b0 <void fp32_sse_fma<10>(unsigned long)>:
    57b0:	endbr64
    57b4:	test   rdi,rdi
    57b7:	je     599d <void fp32_sse_fma<10>(unsigned long)+0x1ed>
    57bd:	vbroadcastss xmm0,DWORD PTR [rip+0x4a1a]        # a1e0 <K_VALUES+0x20>
    57c6:	vbroadcastss xmm1,DWORD PTR [rip+0x4a21]        # a1f0 <K_VALUES+0x30>
    57cf:	xor    eax,eax
    57d1:	vmovaps xmm2,xmm0
    57d5:	vmovaps xmm3,xmm0
    57d9:	vmovaps xmm4,xmm0
    57dd:	vmovaps xmm5,xmm0
    57e1:	vmovaps xmm6,xmm0
    57e5:	vmovaps xmm7,xmm0
    57e9:	vmovaps xmm8,xmm0
    57ed:	vmovaps xmm9,xmm0
    57f1:	vmovaps xmm10,xmm0
    57f5:	vmovaps xmm11,xmm0
    57f9:	nop    DWORD PTR [rax+0x0]
    5800:	vfmadd231ps xmm11,xmm1,xmm0
    5805:	vfmadd231ps xmm10,xmm1,xmm0
    580a:	vfmadd231ps xmm9,xmm1,xmm0
    580f:	vfmadd231ps xmm8,xmm1,xmm0
    5814:	vfmadd231ps xmm7,xmm1,xmm0
    5819:	vfmadd231ps xmm6,xmm1,xmm0
    581e:	vfmadd231ps xmm5,xmm1,xmm0
    5823:	vfmadd231ps xmm4,xmm1,xmm0
    5828:	vfmadd231ps xmm3,xmm1,xmm0
    582d:	vfmadd231ps xmm2,xmm1,xmm0
    5832:	vfmadd231ps xmm11,xmm1,xmm0
    5837:	vfmadd231ps xmm10,xmm1,xmm0
    583c:	vfmadd231ps xmm9,xmm1,xmm0
    5841:	vfmadd231ps xmm8,xmm1,xmm0
    5846:	vfmadd231ps xmm7,xmm1,xmm0
    584b:	vfmadd231ps xmm6,xmm1,xmm0
    5850:	vfmadd231ps xmm5,xmm1,xmm0
    5855:	vfmadd231ps xmm4,xmm1,xmm0
    585a:	vfmadd231ps xmm3,xmm1,xmm0
    585f:	vfmadd231ps xmm2,xmm1,xmm0
    5864:	vfmadd231ps xmm11,xmm1,xmm0
    5869:	vfmadd231ps xmm10,xmm1,xmm0
    586e:	vfmadd231ps xmm9,xmm1,xmm0
    5873:	vfmadd231ps xmm8,xmm1,xmm0
    5878:	vfmadd231ps xmm7,xmm1,xmm0
    587d:	vfmadd231ps xmm6,xmm1,xmm0
    5882:	vfmadd231ps xmm5,xmm1,xmm0
    5887:	vfmadd231ps xmm4,xmm1,xmm0
    588c:	vfmadd231ps xmm3,xmm1,xmm0
    5891:	vfmadd231ps xmm2,xmm1,xmm0
    5896:	vfmadd231ps xmm11,xmm1,xmm0
    589b:	vfmadd231ps xmm10,xmm1,xmm0
    58a0:	vfmadd231ps xmm9,xmm1,xmm0
    58a5:	vfmadd231ps xmm8,xmm1,xmm0
    58aa:	vfmadd231ps xmm7,xmm1,xmm0
    58af:	vfmadd231ps xmm6,xmm1,xmm0
    58b4:	vfmadd231ps xmm5,xmm1,xmm0
    58b9:	vfmadd231ps xmm4,xmm1,xmm0
    58be:	vfmadd231ps xmm3,xmm1,xmm0
    58c3:	vfmadd231ps xmm2,xmm1,xmm0
    58c8:	vfmadd231ps xmm11,xmm1,xmm0
    58cd:	vfmadd231ps xmm10,xmm1,xmm0
    58d2:	vfmadd231ps xmm9,xmm1,xmm0
    58d7:	vfmadd231ps xmm8,xmm1,xmm0
    58dc:	vfmadd231ps xmm7,xmm1,xmm0
    58e1:	vfmadd231ps xmm6,xmm1,xmm0
    58e6:	vfmadd231ps xmm5,xmm1,xmm0
    58eb:	vfmadd231ps xmm4,xmm1,xmm0
    58f0:	vfmadd231ps xmm3,xmm1,xmm0
    58f5:	vfmadd231ps xmm2,xmm1,xmm0
    58fa:	vfmadd231ps xmm11,xmm1,xmm0
    58ff:	vfmadd231ps xmm10,xmm1,xmm0
    5904:	vfmadd231ps xmm9,xmm1,xmm0
    5909:	vfmadd231ps xmm8,xmm1,xmm0
    590e:	vfmadd231ps xmm7,xmm1,xmm0
    5913:	vfmadd231ps xmm6,xmm1,xmm0
    5918:	vfmadd231ps xmm5,xmm1,xmm0
    591d:	vfmadd231ps xmm4,xmm1,xmm0
    5922:	vfmadd231ps xmm3,xmm1,xmm0
    5927:	vfmadd231ps xmm2,xmm1,xmm0
    592c:	vfmadd231ps xmm11,xmm1,xmm0
    5931:	vfmadd231ps xmm10,xmm1,xmm0
    5936:	vfmadd231ps xmm9,xmm1,xmm0
    593b:	vfmadd231ps xmm8,xmm1,xmm0
    5940:	vfmadd231ps xmm7,xmm1,xmm0
    5945:	vfmadd231ps xmm6,xmm1,xmm0
    594a:	vfmadd231ps xmm5,xmm1,xmm0
    594f:	vfmadd231ps xmm4,xmm1,xmm0
    5954:	vfmadd231ps xmm3,xmm1,xmm0
    5959:	vfmadd231ps xmm2,xmm1,xmm0
    595e:	vfmadd231ps xmm11,xmm1,xmm0
    5963:	vfmadd231ps xmm10,xmm1,xmm0
    5968:	vfmadd231ps xmm9,xmm1,xmm0
    596d:	vfmadd231ps xmm8,xmm1,xmm0
    5972:	vfmadd231ps xmm7,xmm1,xmm0
    5977:	vfmadd231ps xmm6,xmm1,xmm0
    597c:	vfmadd231ps xmm5,xmm1,xmm0
    5981:	vfmadd231ps xmm4,xmm1,xmm0
    5986:	vfmadd231ps xmm3,xmm1,xmm0
    598b:	vfmadd231ps xmm2,xmm1,xmm0
    5990:	inc    rax
    5993:	cmp    rdi,rax
    5996:	jne    5800 <void fp32_sse_fma<10>(unsigned long)+0x50>
    599c:	ret
    599d:	vbroadcastss xmm2,DWORD PTR [rip+0x483a]        # a1e0 <K_VALUES+0x20>
    59a6:	vmovaps xmm3,xmm2
    59aa:	vmovaps xmm4,xmm2
    59ae:	vmovaps xmm5,xmm2
    59b2:	vmovaps xmm6,xmm2
    59b6:	vmovaps xmm7,xmm2
    59ba:	vmovaps xmm8,xmm2
    59be:	vmovaps xmm9,xmm2
    59c2:	vmovaps xmm10,xmm2
    59c6:	vmovaps xmm11,xmm2
    59ca:	ret
    59cb:	nop    DWORD PTR [rax+rax*1+0x0]

00000000000059d0 <void fp32_sse_fma<12>(unsigned long)>:
    59d0:	endbr64
    59d4:	test   rdi,rdi
    59d7:	je     5c15 <void fp32_sse_fma<12>(unsigned long)+0x245>
    59dd:	vbroadcastss xmm0,DWORD PTR [rip+0x47fa]        # a1e0 <K_VALUES+0x20>
    59e6:	vbroadcastss xmm1,DWORD PTR [rip+0x4801]        # a1f0 <K_VALUES+0x30>
    59ef:	xor    eax,eax
    59f1:	vmovaps xmm10,xmm0
    59f5:	vmovaps xmm11,xmm0
    59f9:	vmovaps xmm12,xmm0
    59fd:	vmovaps xmm13,xmm0
    5a01:	vmovaps xmm2,xmm0
    5a05:	vmovaps xmm3,xmm0
    5a09:	vmovaps xmm4,xmm0
    5a0d:	vmovaps xmm5,xmm0
    5a11:	vmovaps xmm6,xmm0
    5a15:	vmovaps xmm7,xmm0
    5a19:	vmovaps xmm8,xmm0
    5a1d:	vmovaps xmm9,xmm0
    5a21:	nop    DWORD PTR [rax+0x0]
    5a28:	vfmadd231ps xmm9,xmm1,xmm0
    5a2d:	vfmadd231ps xmm8,xmm1,xmm0
    5a32:	vfmadd231ps xmm7,xmm1,xmm0
    5a37:	vfmadd231ps xmm6,xmm1,xmm0
    5a3c:	vfmadd231ps xmm5,xmm1,xmm0
    5a41:	vfmadd231ps xmm4,xmm1,xmm0
    5a46:	vfmadd231ps xmm3,xmm1,xmm0
    5a4b:	vfmadd231ps xmm2,xmm1,xmm0
    5a50:	vfmadd231ps xmm13,xmm1,xmm0
    5a55:	vfmadd231ps xmm12,xmm1,xmm0
    5a5a:	vfmadd231ps xmm11,xmm1,xmm0
    5a5f:	vfmadd231ps xmm10,xmm1,xmm0
    5a64:	vfmadd231ps xmm9,xmm1,xmm0
    5a69:	vfmadd231ps xmm8,xmm1,xmm0
    5a6e:	vfmadd231ps xmm7,xmm1,xmm0
    5a73:	vfmadd231ps xmm6,xmm1,xmm0
    5a78:	vfmadd231ps xmm5,xmm1,xmm0
    5a7d:	vfmadd231ps xmm4,xmm1,xmm0
    5a82:	vfmadd231ps xmm3,xmm1,xmm0
    5a87:	vfmadd231ps xmm2,xmm1,xmm0
    5a8c:	vfmadd231ps xmm13,xmm1,xmm0
    5a91:	vfmadd231ps xmm12,xmm1,xmm0
    5a96:	vfmadd231ps xmm11,xmm1,xmm0
    5a9b:	vfmadd231ps xmm10,xmm1,xmm0
    5aa0:	vfmadd231ps xmm9,xmm1,xmm0
    5aa5:	vfmadd231ps xmm8,xmm1,xmm0
    5aaa:	vfmadd231ps xmm7,xmm1,xmm0
    5aaf:	vfmadd231ps xmm6,xmm1,xmm0
    5ab4:	vfmadd231ps xmm5,xmm1,xmm0
    5ab9:	vfmadd231ps xmm4,xmm1,xmm0
    5abe:	vfmadd231ps xmm3,xmm1,xmm0
    5ac3:	vfmadd231ps xmm2,xmm1,xmm0
    5ac8:	vfmadd231ps xmm13,xmm1,xmm0
    5acd:	vfmadd231ps xmm12,xmm1,xmm0
    5ad2:	vfmadd231ps xmm11,xmm1,xmm0
    5ad7:	vfmadd231ps xmm10,xmm1,xmm0
    5adc:	vfmadd231ps xmm9,xmm1,xmm0
    5ae1:	vfmadd231ps xmm8,xmm1,xmm0
    5ae6:	vfmadd231ps xmm7,xmm1,xmm0
    5aeb:	vfmadd231ps xmm6,xmm1,xmm0
    5af0:	vfmadd231ps xmm5,xmm1,xmm0
    5af5:	vfmadd231ps xmm4,xmm1,xmm0
    5afa:	vfmadd231ps xmm3,xmm1,xmm0
    5aff:	vfmadd231ps xmm2,xmm1,xmm0
    5b04:	vfmadd231ps xmm13,xmm1,xmm0
    5b09:	vfmadd231ps xmm12,xmm1,xmm0
    5b0e:	vfmadd231ps xmm11,xmm1,xmm0
    5b13:	vfmadd231ps xmm10,xmm1,xmm0
    5b18:	vfmadd231ps xmm9,xmm1,xmm0
    5b1d:	vfmadd231ps xmm8,xmm1,xmm0
    5b22:	vfmadd231ps xmm7,xmm1,xmm0
    5b27:	vfmadd231ps xmm6,xmm1,xmm0
    5b2c:	vfmadd231ps xmm5,xmm1,xmm0
    5b31:	vfmadd231ps xmm4,xmm1,xmm0
    5b36:	vfmadd231ps xmm3,xmm1,xmm0
    5b3b:	vfmadd231ps xmm2,xmm1,xmm0
    5b40:	vfmadd231ps xmm13,xmm1,xmm0
    5b45:	vfmadd231ps xmm12,xmm1,xmm0
    5b4a:	vfmadd231ps xmm11,xmm1,xmm0
    5b4f:	vfmadd231ps xmm10,xmm1,xmm0
    5b54:	vfmadd231ps xmm9,xmm1,xmm0
    5b59:	vfmadd231ps xmm8,xmm1,xmm0
    5b5e:	vfmadd231ps xmm7,xmm1,xmm0
    5b63:	vfmadd231ps xmm6,xmm1,xmm0
    5b68:	vfmadd231ps xmm5,xmm1,xmm0
    5b6d:	vfmadd231ps xmm4,xmm1,xmm0
    5b72:	vfmadd231ps xmm3,xmm1,xmm0
    5b77:	vfmadd231ps xmm2,xmm1,xmm0
    5b7c:	vfmadd231ps xmm13,xmm1,xmm0
    5b81:	vfmadd231ps xmm12,xmm1,xmm0
    5b86:	vfmadd231ps xmm11,xmm1,xmm0
    5b8b:	vfmadd231ps xmm10,xmm1,xmm0
    5b90:	vfmadd231ps xmm9,xmm1,xmm0
    5b95:	vfmadd231ps xmm8,xmm1,xmm0
    5b9a:	vfmadd231ps xmm7,xmm1,xmm0
    5b9f:	vfmadd231ps xmm6,xmm1,xmm0
    5ba4:	vfmadd231ps xmm5,xmm1,xmm0
    5ba9:	vfmadd231ps xmm4,xmm1,xmm0
    5bae:	vfmadd231ps xmm3,xmm1,xmm0
    5bb3:	vfmadd231ps xmm2,xmm1,xmm0
    5bb8:	vfmadd231ps xmm13,xmm1,xmm0
    5bbd:	vfmadd231ps xmm12,xmm1,xmm0
    5bc2:	vfmadd231ps xmm11,xmm1,xmm0
    5bc7:	vfmadd231ps xmm10,xmm1,xmm0
    5bcc:	vfmadd231ps xmm9,xmm1,xmm0
    5bd1:	vfmadd231ps xmm8,xmm1,xmm0
    5bd6:	vfmadd231ps xmm7,xmm1,xmm0
    5bdb:	vfmadd231ps xmm6,xmm1,xmm0
    5be0:	vfmadd231ps xmm5,xmm1,xmm0
    5be5:	vfmadd231ps xmm4,xmm1,xmm0
    5bea:	vfmadd231ps xmm3,xmm1,xmm0
    5bef:	vfmadd231ps xmm2,xmm1,xmm0
    5bf4:	vfmadd231ps xmm13,xmm1,xmm0
    5bf9:	vfmadd231ps xmm12,xmm1,xmm0
    5bfe:	vfmadd231ps xmm11,xmm1,xmm0
    5c03:	vfmadd231ps xmm10,xmm1,xmm0
    5c08:	inc    rax
    5c0b:	cmp    rdi,rax
    5c0e:	jne    5a28 <void fp32_sse_fma<12>(unsigned long)+0x58>
    5c14:	ret
    5c15:	vbroadcastss xmm10,DWORD PTR [rip+0x45c2]        # a1e0 <K_VALUES+0x20>
    5c1e:	vmovaps xmm11,xmm10
    5c23:	vmovaps xmm12,xmm10
    5c28:	vmovaps xmm13,xmm10
    5c2d:	vmovaps xmm2,xmm10
    5c31:	vmovaps xmm3,xmm10
    5c35:	vmovaps xmm4,xmm10
    5c39:	vmovaps xmm5,xmm10
    5c3d:	vmovaps xmm6,xmm10
    5c41:	vmovaps xmm7,xmm10
    5c45:	vmovaps xmm8,xmm10
    5c4a:	vmovaps xmm9,xmm10
    5c4f:	ret

0000000000005c50 <void fp32_sse_fma<16>(unsigned long)>:
    5c50:	endbr64
    5c54:	test   rdi,rdi
    5c57:	je     5f55 <void fp32_sse_fma<16>(unsigned long)+0x305>
    5c5d:	vbroadcastss xmm0,DWORD PTR [rip+0x457a]        # a1e0 <K_VALUES+0x20>
    5c66:	vbroadcastss xmm1,DWORD PTR [rip+0x4581]        # a1f0 <K_VALUES+0x30>
    5c6f:	xor    eax,eax
    5c71:	vmovaps xmm2,xmm0
    5c75:	vmovaps xmm17,xmm0
    5c7b:	vmovaps xmm3,xmm0
    5c7f:	vmovaps xmm4,xmm0
    5c83:	vmovaps xmm5,xmm0
    5c87:	vmovaps xmm6,xmm0
    5c8b:	vmovaps xmm7,xmm0
    5c8f:	vmovaps xmm8,xmm0
    5c93:	vmovaps xmm9,xmm0
    5c97:	vmovaps xmm10,xmm0
    5c9b:	vmovaps xmm11,xmm0
    5c9f:	vmovaps xmm12,xmm0
    5ca3:	vmovaps xmm13,xmm0
    5ca7:	vmovaps xmm14,xmm0
    5cab:	vmovaps xmm15,xmm0
    5caf:	vmovaps xmm16,xmm0
    5cb5:	nop    DWORD PTR [rax]
    5cb8:	vfmadd231ps xmm16,xmm1,xmm0
    5cbe:	vfmadd231ps xmm15,xmm1,xmm0
    5cc3:	vfmadd231ps xmm14,xmm1,xmm0
    5cc8:	vfmadd231ps xmm13,xmm1,xmm0
    5ccd:	vfmadd231ps xmm12,xmm1,xmm0
    5cd2:	vfmadd231ps xmm11,xmm1,xmm0
    5cd7:	vfmadd231ps xmm10,xmm1,xmm0
    5cdc:	vfmadd231ps xmm9,xmm1,xmm0
    5ce1:	vfmadd231ps xmm8,xmm1,xmm0
    5ce6:	vfmadd231ps xmm7,xmm1,xmm0
    5ceb:	vfmadd231ps xmm6,xmm1,xmm0
    5cf0:	vfmadd231ps xmm5,xmm1,xmm0
    5cf5:	vfmadd231ps xmm4,xmm1,xmm0
    5cfa:	vfmadd231ps xmm3,xmm1,xmm0
    5cff:	vfmadd231ps xmm17,xmm1,xmm0
    5d05:	vfmadd231ps xmm2,xmm1,xmm0
    5d0a:	vfmadd231ps xmm16,xmm1,xmm0
    5d10:	vfmadd231ps xmm15,xmm1,xmm0
    5d15:	vfmadd231ps xmm14,xmm1,xmm0
    5d1a:	vfmadd231ps xmm13,xmm1,xmm0
    5d1f:	vfmadd231ps xmm12,xmm1,xmm0
    5d24:	vfmadd231ps xmm11,xmm1,xmm0
    5d29:	vfmadd231ps xmm10,xmm1,xmm0
    5d2e:	vfmadd231ps xmm9,xmm1,xmm0
    5d33:	vfmadd231ps xmm8,xmm1,xmm0
    5d38:	vfmadd231ps xmm7,xmm1,xmm0
    5d3d:	vfmadd231ps xmm6,xmm1,xmm0
    5d42:	vfmadd231ps xmm5,xmm1,xmm0
    5d47:	vfmadd231ps xmm4,xmm1,xmm0
    5d4c:	vfmadd231ps xmm3,xmm1,xmm0
    5d51:	vfmadd231ps xmm17,xmm1,xmm0
    5d57:	vfmadd231ps xmm2,xmm1,xmm0
    5d5c:	vfmadd231ps xmm16,xmm1,xmm0
    5d62:	vfmadd231ps xmm15,xmm1,xmm0
    5d67:	vfmadd231ps xmm14,xmm1,xmm0
    5d6c:	vfmadd231ps xmm13,xmm1,xmm0
    5d71:	vfmadd231ps xmm12,xmm1,xmm0
    5d76:	vfmadd231ps xmm11,xmm1,xmm0
    5d7b:	vfmadd231ps xmm10,xmm1,xmm0
    5d80:	vfmadd231ps xmm9,xmm1,xmm0
    5d85:	vfmadd231ps xmm8,xmm1,xmm0
    5d8a:	vfmadd231ps xmm7,xmm1,xmm0
    5d8f:	vfmadd231ps xmm6,xmm1,xmm0
    5d94:	vfmadd231ps xmm5,xmm1,xmm0
    5d99:	vfmadd231ps xmm4,xmm1,xmm0
    5d9e:	vfmadd231ps xmm3,xmm1,xmm0
    5da3:	vfmadd231ps xmm17,xmm1,xmm0
    5da9:	vfmadd231ps xmm2,xmm1,xmm0
    5dae:	vfmadd231ps xmm16,xmm1,xmm0
    5db4:	vfmadd231ps xmm15,xmm1,xmm0
    5db9:	vfmadd231ps xmm14,xmm1,xmm0
    5dbe:	vfmadd231ps xmm13,xmm1,xmm0
    5dc3:	vfmadd231ps xmm12,xmm1,xmm0
    5dc8:	vfmadd231ps xmm11,xmm1,xmm0
    5dcd:	vfmadd231ps xmm10,xmm1,xmm0
    5dd2:	vfmadd231ps xmm9,xmm1,xmm0
    5dd7:	vfmadd231ps xmm8,xmm1,xmm0
    5ddc:	vfmadd231ps xmm7,xmm1,xmm0
    5de1:	vfmadd231ps xmm6,xmm1,xmm0
    5de6:	vfmadd231ps xmm5,xmm1,xmm0
    5deb:	vfmadd231ps xmm4,xmm1,xmm0
    5df0:	vfmadd231ps xmm3,xmm1,xmm0
    5df5:	vfmadd231ps xmm17,xmm1,xmm0
    5dfb:	vfmadd231ps xmm2,xmm1,xmm0
    5e00:	vfmadd231ps xmm16,xmm1,xmm0
    5e06:	vfmadd231ps xmm15,xmm1,xmm0
    5e0b:	vfmadd231ps xmm14,xmm1,xmm0
    5e10:	vfmadd231ps xmm13,xmm1,xmm0
    5e15:	vfmadd231ps xmm12,xmm1,xmm0
    5e1a:	vfmadd231ps xmm11,xmm1,xmm0
    5e1f:	vfmadd231ps xmm10,xmm1,xmm0
    5e24:	vfmadd231ps xmm9,xmm1,xmm0
    5e29:	vfmadd231ps xmm8,xmm1,xmm0
    5e2e:	vfmadd231ps xmm7,xmm1,xmm0
    5e33:	vfmadd231ps xmm6,xmm1,xmm0
    5e38:	vfmadd231ps xmm5,xmm1,xmm0
    5e3d:	vfmadd231ps xmm4,xmm1,xmm0
    5e42:	vfmadd231ps xmm3,xmm1,xmm0
    5e47:	vfmadd231ps xmm17,xmm1,xmm0
    5e4d:	vfmadd231ps xmm2,xmm1,xmm0
    5e52:	vfmadd231ps xmm16,xmm1,xmm0
    5e58:	vfmadd231ps xmm15,xmm1,xmm0
    5e5d:	vfmadd231ps xmm14,xmm1,xmm0
    5e62:	vfmadd231ps xmm13,xmm1,xmm0
    5e67:	vfmadd231ps xmm12,xmm1,xmm0
    5e6c:	vfmadd231ps xmm11,xmm1,xmm0
    5e71:	vfmadd231ps xmm10,xmm1,xmm0
    5e76:	vfmadd231ps xmm9,xmm1,xmm0
    5e7b:	vfmadd231ps xmm8,xmm1,xmm0
    5e80:	vfmadd231ps xmm7,xmm1,xmm0
    5e85:	vfmadd231ps xmm6,xmm1,xmm0
    5e8a:	vfmadd231ps xmm5,xmm1,xmm0
    5e8f:	vfmadd231ps xmm4,xmm1,xmm0
    5e94:	vfmadd231ps xmm3,xmm1,xmm0
    5e99:	vfmadd231ps xmm17,xmm1,xmm0
    5e9f:	vfmadd231ps xmm2,xmm1,xmm0
    5ea4:	vfmadd231ps xmm16,xmm1,xmm0
    5eaa:	vfmadd231ps xmm15,xmm1,xmm0
    5eaf:	vfmadd231ps xmm14,xmm1,xmm0
    5eb4:	vfmadd231ps xmm13,xmm1,xmm0
    5eb9:	vfmadd231ps xmm12,xmm1,xmm0
    5ebe:	vfmadd231ps xmm11,xmm1,xmm0
    5ec3:	vfmadd231ps xmm10,xmm1,xmm0
    5ec8:	vfmadd231ps xmm9,xmm1,xmm0
    5ecd:	vfmadd231ps xmm8,xmm1,xmm0
    5ed2:	vfmadd231ps xmm7,xmm1,xmm0
    5ed7:	vfmadd231ps xmm6,xmm1,xmm0
    5edc:	vfmadd231ps xmm5,xmm1,xmm0
    5ee1:	vfmadd231ps xmm4,xmm1,xmm0
    5ee6:	vfmadd231ps xmm3,xmm1,xmm0
    5eeb:	vfmadd231ps xmm17,xmm1,xmm0
    5ef1:	vfmadd231ps xmm2,xmm1,xmm0
    5ef6:	vfmadd231ps xmm16,xmm1,xmm0
    5efc:	vfmadd231ps xmm15,xmm1,xmm0
    5f01:	vfmadd231ps xmm14,xmm1,xmm0
    5f06:	vfmadd231ps xmm13,xmm1,xmm0
    5f0b:	vfmadd231ps xmm12,xmm1,xmm0
    5f10:	vfmadd231ps xmm11,xmm1,xmm0
    5f15:	vfmadd231ps xmm10,xmm1,xmm0
    5f1a:	vfmadd231ps xmm9,xmm1,xmm0
    5f1f:	vfmadd231ps xmm8,xmm1,xmm0
    5f24:	vfmadd231ps xmm7,xmm1,xmm0
    5f29:	vfmadd231ps xmm6,xmm1,xmm0
    5f2e:	vfmadd231ps xmm5,xmm1,xmm0
    5f33:	vfmadd231ps xmm4,xmm1,xmm0
    5f38:	vfmadd231ps xmm3,xmm1,xmm0
    5f3d:	vfmadd231ps xmm17,xmm1,xmm0
    5f43:	vfmadd231ps xmm2,xmm1,xmm0
    5f48:	inc    rax
    5f4b:	cmp    rdi,rax
    5f4e:	jne    5cb8 <void fp32_sse_fma<16>(unsigned long)+0x68>
    5f54:	ret
    5f55:	vbroadcastss xmm2,DWORD PTR [rip+0x4282]        # a1e0 <K_VALUES+0x20>
    5f5e:	vmovaps xmm17,xmm2
    5f64:	vmovaps xmm3,xmm2
    5f68:	vmovaps xmm4,xmm2
    5f6c:	vmovaps xmm5,xmm2
    5f70:	vmovaps xmm6,xmm2
    5f74:	vmovaps xmm7,xmm2
    5f78:	vmovaps xmm8,xmm2
    5f7c:	vmovaps xmm9,xmm2
    5f80:	vmovaps xmm10,xmm2
    5f84:	vmovaps xmm11,xmm2
    5f88:	vmovaps xmm12,xmm2
    5f8c:	vmovaps xmm13,xmm2
    5f90:	vmovaps xmm14,xmm2
    5f94:	vmovaps xmm15,xmm2
    5f98:	vmovaps xmm16,xmm2
    5f9e:	ret
    5f9f:	nop

0000000000005fa0 <void fp32_avx2_fma<1>(unsigned long)>:
    5fa0:	endbr64
    5fa4:	test   rdi,rdi
    5fa7:	je     5ffc <void fp32_avx2_fma<1>(unsigned long)+0x5c>
    5fa9:	vbroadcastss ymm1,DWORD PTR [rip+0x422e]        # a1e0 <K_VALUES+0x20>
    5fb2:	vbroadcastss ymm2,DWORD PTR [rip+0x4235]        # a1f0 <K_VALUES+0x30>
    5fbb:	xor    eax,eax
    5fbd:	vmovaps ymm0,ymm1
    5fc1:	nop    DWORD PTR [rax+0x0]
    5fc8:	vfmadd231ps ymm0,ymm2,ymm1
    5fcd:	vfmadd231ps ymm0,ymm2,ymm1
    5fd2:	vfmadd231ps ymm0,ymm2,ymm1
    5fd7:	vfmadd231ps ymm0,ymm2,ymm1
    5fdc:	vfmadd231ps ymm0,ymm2,ymm1
    5fe1:	vfmadd231ps ymm0,ymm2,ymm1
    5fe6:	vfmadd231ps ymm0,ymm2,ymm1
    5feb:	vfmadd231ps ymm0,ymm2,ymm1
    5ff0:	inc    rax
    5ff3:	cmp    rdi,rax
    5ff6:	jne    5fc8 <void fp32_avx2_fma<1>(unsigned long)+0x28>
    5ff8:	vzeroupper
    5ffb:	ret
    5ffc:	vbroadcastss ymm0,DWORD PTR [rip+0x41db]        # a1e0 <K_VALUES+0x20>
    6005:	vzeroupper
    6008:	ret
    6009:	nop    DWORD PTR [rax+0x0]

0000000000006010 <void fp32_avx2_fma<2>(unsigned long)>:
    6010:	endbr64
    6014:	test   rdi,rdi
    6017:	je     6094 <void fp32_avx2_fma<2>(unsigned long)+0x84>
    6019:	vbroadcastss ymm2,DWORD PTR [rip+0x41be]        # a1e0 <K_VALUES+0x20>
    6022:	vbroadcastss ymm3,DWORD PTR [rip+0x41c5]        # a1f0 <K_VALUES+0x30>
    602b:	xor    eax,eax
    602d:	vmovaps ymm0,ymm2
    6031:	vmovaps ymm1,ymm2
    6035:	nop    DWORD PTR [rax]
    6038:	vfmadd231ps ymm1,ymm3,ymm2
    603d:	vfmadd231ps ymm0,ymm3,ymm2
    6042:	vfmadd231ps ymm1,ymm3,ymm2
    6047:	vfmadd231ps ymm0,ymm3,ymm2
    604c:	vfmadd231ps ymm1,ymm3,ymm2
    6051:	vfmadd231ps ymm0,ymm3,ymm2
    6056:	vfmadd231ps ymm1,ymm3,ymm2
    605b:	vfmadd231ps ymm0,ymm3,ymm2
    6060:	vfmadd231ps ymm1,ymm3,ymm2
    6065:	vfmadd231ps ymm0,ymm3,ymm2
    606a:	vfmadd231ps ymm1,ymm3,ymm2
    606f:	vfmadd231ps ymm0,ymm3,ymm2
    6074:	vfmadd231ps ymm1,ymm3,ymm2
    6079:	vfmadd231ps ymm0,ymm3,ymm2
    607e:	vfmadd231ps ymm1,ymm3,ymm2
    6083:	vfmadd231ps ymm0,ymm3,ymm2
    6088:	inc    rax
    608b:	cmp    rdi,rax
    608e:	jne    6038 <void fp32_avx2_fma<2>(unsigned long)+0x28>
    6090:	vzeroupper
    6093:	ret
    6094:	vbroadcastss ymm0,DWORD PTR [rip+0x4143]        # a1e0 <K_VALUES+0x20>
    609d:	vmovaps ymm1,ymm0
    60a1:	vzeroupper
    60a4:	ret
    60a5:	data16 cs nop WORD PTR [rax+rax*1+0x0]

00000000000060b0 <void fp32_avx2_fma<4>(unsigned long)>:
    60b0:	endbr64
    60b4:	test   rdi,rdi
    60b7:	je     6198 <void fp32_avx2_fma<4>(unsigned long)+0xe8>
    60bd:	vbroadcastss ymm4,DWORD PTR [rip+0x411a]        # a1e0 <K_VALUES+0x20>
    60c6:	vbroadcastss ymm5,DWORD PTR [rip+0x4121]        # a1f0 <K_VALUES+0x30>
    60cf:	xor    eax,eax
    60d1:	vmovaps ymm0,ymm4
    60d5:	vmovaps ymm1,ymm4
    60d9:	vmovaps ymm2,ymm4
    60dd:	vmovaps ymm3,ymm4
    60e1:	nop    DWORD PTR [rax+0x0]
    60e8:	vfmadd231ps ymm3,ymm5,ymm4
    60ed:	vfmadd231ps ymm2,ymm5,ymm4
    60f2:	vfmadd231ps ymm1,ymm5,ymm4
    60f7:	vfmadd231ps ymm0,ymm5,ymm4
    60fc:	vfmadd231ps ymm3,ymm5,ymm4
    6101:	vfmadd231ps ymm2,ymm5,ymm4
    6106:	vfmadd231ps ymm1,ymm5,ymm4
    610b:	vfmadd231ps ymm0,ymm5,ymm4
    6110:	vfmadd231ps ymm3,ymm5,ymm4
    6115:	vfmadd231ps ymm2,ymm5,ymm4
    611a:	vfmadd231ps ymm1,ymm5,ymm4
    611f:	vfmadd231ps ymm0,ymm5,ymm4
    6124:	vfmadd231ps ymm3,ymm5,ymm4
    6129:	vfmadd231ps ymm2,ymm5,ymm4
    612e:	vfmadd231ps ymm1,ymm5,ymm4
    6133:	vfmadd231ps ymm0,ymm5,ymm4
    6138:	vfmadd231ps ymm3,ymm5,ymm4
    613d:	vfmadd231ps ymm2,ymm5,ymm4
    6142:	vfmadd231ps ymm1,ymm5,ymm4
    6147:	vfmadd231ps ymm0,ymm5,ymm4
    614c:	vfmadd231ps ymm3,ymm5,ymm4
    6151:	vfmadd231ps ymm2,ymm5,ymm4
    6156:	vfmadd231ps ymm1,ymm5,ymm4
    615b:	vfmadd231ps ymm0,ymm5,ymm4
    6160:	vfmadd231ps ymm3,ymm5,ymm4
    6165:	vfmadd231ps ymm2,ymm5,ymm4
    616a:	vfmadd231ps ymm1,ymm5,ymm4
    616f:	vfmadd231ps ymm0,ymm5,ymm4
    6174:	vfmadd231ps ymm3,ymm5,ymm4
    6179:	vfmadd231ps ymm2,ymm5,ymm4
    617e:	vfmadd231ps ymm1,ymm5,ymm4
    6183:	vfmadd231ps ymm0,ymm5,ymm4
    6188:	inc    rax
    618b:	cmp    rdi,rax
    618e:	jne    60e8 <void fp32_avx2_fma<4>(unsigned long)+0x38>
    6194:	vzeroupper
    6197:	ret
    6198:	vbroadcastss ymm0,DWORD PTR [rip+0x403f]        # a1e0 <K_VALUES+0x20>
    61a1:	vmovaps ymm1,ymm0
    61a5:	vmovaps ymm2,ymm0
    61a9:	vmovaps ymm3,ymm0
    61ad:	vzeroupper
    61b0:	ret
    61b1:	data16 cs nop WORD PTR [rax+rax*1+0x0]
    61bc:	nop    DWORD PTR [rax+0x0]

00000000000061c0 <void fp32_avx2_fma<6>(unsigned long)>:
    61c0:	endbr64
    61c4:	test   rdi,rdi
    61c7:	je     6300 <void fp32_avx2_fma<6>(unsigned long)+0x140>
    61cd:	vbroadcastss ymm0,DWORD PTR [rip+0x400a]        # a1e0 <K_VALUES+0x20>
    61d6:	vbroadcastss ymm1,DWORD PTR [rip+0x4011]        # a1f0 <K_VALUES+0x30>
    61df:	xor    eax,eax
    61e1:	vmovaps ymm2,ymm0
    61e5:	vmovaps ymm3,ymm0
    61e9:	vmovaps ymm4,ymm0
    61ed:	vmovaps ymm5,ymm0
    61f1:	vmovaps ymm6,ymm0
    61f5:	vmovaps ymm7,ymm0
    61f9:	nop    DWORD PTR [rax+0x0]
    6200:	vfmadd231ps ymm7,ymm1,ymm0
    6205:	vfmadd231ps ymm6,ymm1,ymm0
    620a:	vfmadd231ps ymm5,ymm1,ymm0
    620f:	vfmadd231ps ymm4,ymm1,ymm0
    6214:	vfmadd231ps ymm3,ymm1,ymm0
    6219:	vfmadd231ps ymm2,ymm1,ymm0
    621e:	vfmadd231ps ymm7,ymm1,ymm0
    6223:	vfmadd231ps ymm6,ymm1,ymm0
    6228:	vfmadd231ps ymm5,ymm1,ymm0
    622d:	vfmadd231ps ymm4,ymm1,ymm0
    6232:	vfmadd231ps ymm3,ymm1,ymm0
    6237:	vfmadd231ps ymm2,ymm1,ymm0
    623c:	vfmadd231ps ymm7,ymm1,ymm0
    6241:	vfmadd231ps ymm6,ymm1,ymm0
    6246:	vfmadd231ps ymm5,ymm1,ymm0
    624b:	vfmadd231ps ymm4,ymm1,ymm0
    6250:	vfmadd231ps ymm3,ymm1,ymm0
    6255:	vfmadd231ps ymm2,ymm1,ymm0
    625a:	vfmadd231ps ymm7,ymm1,ymm0
    625f:	vfmadd231ps ymm6,ymm1,ymm0
    6264:	vfmadd231ps ymm5,ymm1,ymm0
    6269:	vfmadd231ps ymm4,ymm1,ymm0
    626e:	vfmadd231ps ymm3,ymm1,ymm0
    6273:	vfmadd231ps ymm2,ymm1,ymm0
    6278:	vfmadd231ps ymm7,ymm1,ymm0
    627d:	vfmadd231ps ymm6,ymm1,ymm0
    6282:	vfmadd231ps ymm5,ymm1,ymm0
    6287:	vfmadd231ps ymm4,ymm1,ymm0
    628c:	vfmadd231ps ymm3,ymm1,ymm0
    6291:	vfmadd231ps ymm2,ymm1,ymm0
    6296:	vfmadd231ps ymm7,ymm1,ymm0
    629b:	vfmadd231ps ymm6,ymm1,ymm0
    62a0:	vfmadd231ps ymm5,ymm1,ymm0
    62a5:	vfmadd231ps ymm4,ymm1,ymm0
    62aa:	vfmadd231ps ymm3,ymm1,ymm0
    62af:	vfmadd231ps ymm2,ymm1,ymm0
    62b4:	vfmadd231ps ymm7,ymm1,ymm0
    62b9:	vfmadd231ps ymm6,ymm1,ymm0
    62be:	vfmadd231ps ymm5,ymm1,ymm0
    62c3:	vfmadd231ps ymm4,ymm1,ymm0
    62c8:	vfmadd231ps ymm3,ymm1,ymm0
    62cd:	vfmadd231ps ymm2,ymm1,ymm0
    62d2:	vfmadd231ps ymm7,ymm1,ymm0
    62d7:	vfmadd231ps ymm6,ymm1,ymm0
    62dc:	vfmadd231ps ymm5,ymm1,ymm0
    62e1:	vfmadd231ps ymm4,ymm1,ymm0
    62e6:	vfmadd231ps ymm3,ymm1,ymm0
    62eb:	vfmadd231ps ymm2,ymm1,ymm0
    62f0:	inc    rax
    62f3:	cmp    rdi,rax
    62f6:	jne    6200 <void fp32_avx2_fma<6>(unsigned long)+0x40>
    62fc:	vzeroupper
    62ff:	ret
    6300:	vbroadcastss ymm2,DWORD PTR [rip+0x3ed7]        # a1e0 <K_VALUES+0x20>
    6309:	vmovaps ymm3,ymm2
    630d:	vmovaps ymm4,ymm2
    6311:	vmovaps ymm5,ymm2
    6315:	vmovaps ymm6,ymm2
    6319:	vmovaps ymm7,ymm2
    631d:	vzeroupper
    6320:	ret
    6321:	data16 cs nop WORD PTR [rax+rax*1+0x0]
    632c:	nop    DWORD PTR [rax+0x0]

0000000000006330 <void fp32_avx2_fma<8>(unsigned long)>:
    6330:	endbr64
    6334:	test   rdi,rdi
    6337:	je     64c8 <void fp32_avx2_fma<8>(unsigned long)+0x198>
    633d:	vbroadcastss ymm0,DWORD PTR [rip+0x3e9a]        # a1e0 <K_VALUES+0x20>
    6346:	vbroadcastss ymm1,DWORD PTR [rip+0x3ea1]        # a1f0 <K_VALUES+0x30>
    634f:	xor    eax,eax
    6351:	vmovaps ymm2,ymm0
    6355:	vmovaps ymm3,ymm0
    6359:	vmovaps ymm4,ymm0
    635d:	vmovaps ymm5,ymm0
    6361:	vmovaps ymm6,ymm0
    6365:	vmovaps ymm7,ymm0
    6369:	vmovaps ymm8,ymm0
    636d:	vmovaps ymm9,ymm0
    6371:	nop    DWORD PTR [rax+0x0]
    6378:	vfmadd231ps ymm9,ymm1,ymm0
    637d:	vfmadd231ps ymm8,ymm1,ymm0
    6382:	vfmadd231ps ymm7,ymm1,ymm0
    6387:	vfmadd231ps ymm6,ymm1,ymm0
    638c:	vfmadd231ps ymm5,ymm1,ymm0
    6391:	vfmadd231ps ymm4,ymm1,ymm0
    6396:	vfmadd231ps ymm3,ymm1,ymm0
    639b:	vfmadd231ps ymm2,ymm1,ymm0
    63a0:	vfmadd231ps ymm9,ymm1,ymm0
    63a5:	vfmadd231ps ymm8,ymm1,ymm0
    63aa:	vfmadd231ps ymm7,ymm1,ymm0
    63af:	vfmadd231ps ymm6,ymm1,ymm0
    63b4:	vfmadd231ps ymm5,ymm1,ymm0
    63b9:	vfmadd231ps ymm4,ymm1,ymm0
    63be:	vfmadd231ps ymm3,ymm1,ymm0
    63c3:	vfmadd231ps ymm2,ymm1,ymm0
    63c8:	vfmadd231ps ymm9,ymm1,ymm0
    63cd:	vfmadd231ps ymm8,ymm1,ymm0
    63d2:	vfmadd231ps ymm7,ymm1,ymm0
    63d7:	vfmadd231ps ymm6,ymm1,ymm0
    63dc:	vfmadd231ps ymm5,ymm1,ymm0
    63e1:	vfmadd231ps ymm4,ymm1,ymm0
    63e6:	vfmadd231ps ymm3,ymm1,ymm0
    63eb:	vfmadd231ps ymm2,ymm1,ymm0
    63f0:	vfmadd231ps ymm9,ymm1,ymm0
    63f5:	vfmadd231ps ymm8,ymm1,ymm0
    63fa:	vfmadd231ps ymm7,ymm1,ymm0
    63ff:	vfmadd231ps ymm6,ymm1,ymm0
    6404:	vfmadd231ps ymm5,ymm1,ymm0
    6409:	vfmadd231ps ymm4,ymm1,ymm0
    640e:	vfmadd231ps ymm3,ymm1,ymm0
    6413:	vfmadd231ps ymm2,ymm1,ymm0
    6418:	vfmadd231ps ymm9,ymm1,ymm0
    641d:	vfmadd231ps ymm8,ymm1,ymm0
    6422:	vfmadd231ps ymm7,ymm1,ymm0
    6427:	vfmadd231ps ymm6,ymm1,ymm0
    642c:	vfmadd231ps ymm5,ymm1,ymm0
    6431:	vfmadd231ps ymm4,ymm1,ymm0
    6436:	vfmadd231ps ymm3,ymm1,ymm0
    643b:	vfmadd231ps ymm2,ymm1,ymm0
    6440:	vfmadd231ps ymm9,ymm1,ymm0
    6445:	vfmadd231ps ymm8,ymm1,ymm0
    644a:	vfmadd231ps ymm7,ymm1,ymm0
    644f:	vfmadd231ps ymm6,ymm1,ymm0
    6454:	vfmadd231ps ymm5,ymm1,ymm0
    6459:	vfmadd231ps ymm4,ymm1,ymm0
    645e:	vfmadd231ps ymm3,ymm1,ymm0
    6463:	vfmadd231ps ymm2,ymm1,ymm0
    6468:	vfmadd231ps ymm9,ymm1,ymm0
    646d:	vfmadd231ps ymm8,ymm1,ymm0
    6472:	vfmadd231ps ymm7,ymm1,ymm0
    6477:	vfmadd231ps ymm6,ymm1,ymm0
    647c:	vfmadd231ps ymm5,ymm1,ymm0
    6481:	vfmadd231ps ymm4,ymm1,ymm0
    6486:	vfmadd231ps ymm3,ymm1,ymm0
    648b:	vfmadd231ps ymm2,ymm1,ymm0
    6490:	vfmadd231ps ymm9,ymm1,ymm0
    6495:	vfmadd231ps ymm8,ymm1,ymm0
    649a:	vfmadd231ps ymm7,ymm1,ymm0
    649f:	vfmadd231ps ymm6,ymm1,ymm0
    64a4:	vfmadd231ps ymm5,ymm1,ymm0
    64a9:	vfmadd231ps ymm4,ymm1,ymm0
    64ae:	vfmadd231ps ymm3,ymm1,ymm0
    64b3:	vfmadd231ps ymm2,ymm1,ymm0
    64b8:	inc    rax
    64bb:	cmp    rdi,rax
    64be:	jne    6378 <void fp32_avx2_fma<8>(unsigned long)+0x48>
    64c4:	vzeroupper
    64c7:	ret
    64c8:	vbroadcastss ymm2,DWORD PTR [rip+0x3d0f]        # a1e0 <K_VALUES+0x20>
    64d1:	vmovaps ymm3,ymm2
    64d5:	vmovaps ymm4,ymm2
    64d9:	vmovaps ymm5,ymm2
    64dd:	vmovaps ymm6,ymm2
    64e1:	vmovaps ymm7,ymm2
    64e5:	vmovaps ymm8,ymm2
    64e9:	vmovaps ymm9,ymm2
    64ed:	vzeroupper
    64f0:	ret
    64f1:	data16 cs nop WORD PTR [rax+rax*1+0x0]
    64fc:	nop    DWORD PTR [rax+0x0]

0000000000006500 <void fp32_avx2_fma<10>(unsigned long)>:
    6500:	endbr64
    6504:	test   rdi,rdi
    6507:	je     66f0 <void fp32_avx2_fma<10>(unsigned long)+0x1f0>
    650d:	vbroadcastss ymm0,DWORD PTR [rip+0x3cca]        # a1e0 <K_VALUES+0x20>
    6516:	vbroadcastss ymm1,DWORD PTR [rip+0x3cd1]        # a1f0 <K_VALUES+0x30>
    651f:	xor    eax,eax
    6521:	vmovaps ymm2,ymm0
    6525:	vmovaps ymm3,ymm0
    6529:	vmovaps ymm4,ymm0
    652d:	vmovaps ymm5,ymm0
    6531:	vmovaps ymm6,ymm0
    6535:	vmovaps ymm7,ymm0
    6539:	vmovaps ymm8,ymm0
    653d:	vmovaps ymm9,ymm0
    6541:	vmovaps ymm10,ymm0
    6545:	vmovaps ymm11,ymm0
    6549:	nop    DWORD PTR [rax+0x0]
    6550:	vfmadd231ps ymm11,ymm1,ymm0
    6555:	vfmadd231ps ymm10,ymm1,ymm0
    655a:	vfmadd231ps ymm9,ymm1,ymm0
    655f:	vfmadd231ps ymm8,ymm1,ymm0
    6564:	vfmadd231ps ymm7,ymm1,ymm0
    6569:	vfmadd231ps ymm6,ymm1,ymm0
    656e:	vfmadd231ps ymm5,ymm1,ymm0
    6573:	vfmadd231ps ymm4,ymm1,ymm0
    6578:	vfmadd231ps ymm3,ymm1,ymm0
    657d:	vfmadd231ps ymm2,ymm1,ymm0
    6582:	vfmadd231ps ymm11,ymm1,ymm0
    6587:	vfmadd231ps ymm10,ymm1,ymm0
    658c:	vfmadd231ps ymm9,ymm1,ymm0
    6591:	vfmadd231ps ymm8,ymm1,ymm0
    6596:	vfmadd231ps ymm7,ymm1,ymm0
    659b:	vfmadd231ps ymm6,ymm1,ymm0
    65a0:	vfmadd231ps ymm5,ymm1,ymm0
    65a5:	vfmadd231ps ymm4,ymm1,ymm0
    65aa:	vfmadd231ps ymm3,ymm1,ymm0
    65af:	vfmadd231ps ymm2,ymm1,ymm0
    65b4:	vfmadd231ps ymm11,ymm1,ymm0
    65b9:	vfmadd231ps ymm10,ymm1,ymm0
    65be:	vfmadd231ps ymm9,ymm1,ymm0
    65c3:	vfmadd231ps ymm8,ymm1,ymm0
    65c8:	vfmadd231ps ymm7,ymm1,ymm0
    65cd:	vfmadd231ps ymm6,ymm1,ymm0
    65d2:	vfmadd231ps ymm5,ymm1,ymm0
    65d7:	vfmadd231ps ymm4,ymm1,ymm0
    65dc:	vfmadd231ps ymm3,ymm1,ymm0
    65e1:	vfmadd231ps ymm2,ymm1,ymm0
    65e6:	vfmadd231ps ymm11,ymm1,ymm0
    65eb:	vfmadd231ps ymm10,ymm1,ymm0
    65f0:	vfmadd231ps ymm9,ymm1,ymm0
    65f5:	vfmadd231ps ymm8,ymm1,ymm0
    65fa:	vfmadd231ps ymm7,ymm1,ymm0
    65ff:	vfmadd231ps ymm6,ymm1,ymm0
    6604:	vfmadd231ps ymm5,ymm1,ymm0
    6609:	vfmadd231ps ymm4,ymm1,ymm0
    660e:	vfmadd231ps ymm3,ymm1,ymm0
    6613:	vfmadd231ps ymm2,ymm1,ymm0
    6618:	vfmadd231ps ymm11,ymm1,ymm0
    661d:	vfmadd231ps ymm10,ymm1,ymm0
    6622:	vfmadd231ps ymm9,ymm1,ymm0
    6627:	vfmadd231ps ymm8,ymm1,ymm0
    662c:	vfmadd231ps ymm7,ymm1,ymm0
    6631:	vfmadd231ps ymm6,ymm1,ymm0
    6636:	vfmadd231ps ymm5,ymm1,ymm0
    663b:	vfmadd231ps ymm4,ymm1,ymm0
    6640:	vfmadd231ps ymm3,ymm1,ymm0
    6645:	vfmadd231ps ymm2,ymm1,ymm0
    664a:	vfmadd231ps ymm11,ymm1,ymm0
    664f:	vfmadd231ps ymm10,ymm1,ymm0
    6654:	vfmadd231ps ymm9,ymm1,ymm0
    6659:	vfmadd231ps ymm8,ymm1,ymm0
    665e:	vfmadd231ps ymm7,ymm1,ymm0
    6663:	vfmadd231ps ymm6,ymm1,ymm0
    6668:	vfmadd231ps ymm5,ymm1,ymm0
    666d:	vfmadd231ps ymm4,ymm1,ymm0
    6672:	vfmadd231ps ymm3,ymm1,ymm0
    6677:	vfmadd231ps ymm2,ymm1,ymm0
    667c:	vfmadd231ps ymm11,ymm1,ymm0
    6681:	vfmadd231ps ymm10,ymm1,ymm0
    6686:	vfmadd231ps ymm9,ymm1,ymm0
    668b:	vfmadd231ps ymm8,ymm1,ymm0
    6690:	vfmadd231ps ymm7,ymm1,ymm0
    6695:	vfmadd231ps ymm6,ymm1,ymm0
    669a:	vfmadd231ps ymm5,ymm1,ymm0
    669f:	vfmadd231ps ymm4,ymm1,ymm0
    66a4:	vfmadd231ps ymm3,ymm1,ymm0
    66a9:	vfmadd231ps ymm2,ymm1,ymm0
    66ae:	vfmadd231ps ymm11,ymm1,ymm0
    66b3:	vfmadd231ps ymm10,ymm1,ymm0
    66b8:	vfmadd231ps ymm9,ymm1,ymm0
    66bd:	vfmadd231ps ymm8,ymm1,ymm0
    66c2:	vfmadd231ps ymm7,ymm1,ymm0
    66c7:	vfmadd231ps ymm6,ymm1,ymm0
    66cc:	vfmadd231ps ymm5,ymm1,ymm0
    66d1:	vfmadd231ps ymm4,ymm1,ymm0
    66d6:	vfmadd231ps ymm3,ymm1,ymm0
    66db:	vfmadd231ps ymm2,ymm1,ymm0
    66e0:	inc    rax
    66e3:	cmp    rdi,rax
    66e6:	jne    6550 <void fp32_avx2_fma<10>(unsigned long)+0x50>
    66ec:	vzeroupper
    66ef:	ret
    66f0:	vbroadcastss ymm2,DWORD PTR [rip+0x3ae7]        # a1e0 <K_VALUES+0x20>
    66f9:	vmovaps ymm3,ymm2
    66fd:	vmovaps ymm4,ymm2
    6701:	vmovaps ymm5,ymm2
    6705:	vmovaps ymm6,ymm2
    6709:	vmovaps ymm7,ymm2
    670d:	vmovaps ymm8,ymm2
    6711:	vmovaps ymm9,ymm2
    6715:	vmovaps ymm10,ymm2
    6719:	vmovaps ymm11,ymm2
    671d:	vzeroupper
    6720:	ret
    6721:	data16 cs nop WORD PTR [rax+rax*1+0x0]
    672c:	nop    DWORD PTR [rax+0x0]

0000000000006730 <void fp32_avx2_fma<12>(unsigned long)>:
    6730:	endbr64
    6734:	test   rdi,rdi
    6737:	je     6978 <void fp32_avx2_fma<12>(unsigned long)+0x248>
    673d:	vbroadcastss ymm0,DWORD PTR [rip+0x3a9a]        # a1e0 <K_VALUES+0x20>
    6746:	vbroadcastss ymm1,DWORD PTR [rip+0x3aa1]        # a1f0 <K_VALUES+0x30>
    674f:	xor    eax,eax
    6751:	vmovaps ymm10,ymm0
    6755:	vmovaps ymm11,ymm0
    6759:	vmovaps ymm12,ymm0
    675d:	vmovaps ymm13,ymm0
    6761:	vmovaps ymm2,ymm0
    6765:	vmovaps ymm3,ymm0
    6769:	vmovaps ymm4,ymm0
    676d:	vmovaps ymm5,ymm0
    6771:	vmovaps ymm6,ymm0
    6775:	vmovaps ymm7,ymm0
    6779:	vmovaps ymm8,ymm0
    677d:	vmovaps ymm9,ymm0
    6781:	nop    DWORD PTR [rax+0x0]
    6788:	vfmadd231ps ymm9,ymm1,ymm0
    678d:	vfmadd231ps ymm8,ymm1,ymm0
    6792:	vfmadd231ps ymm7,ymm1,ymm0
    6797:	vfmadd231ps ymm6,ymm1,ymm0
    679c:	vfmadd231ps ymm5,ymm1,ymm0
    67a1:	vfmadd231ps ymm4,ymm1,ymm0
    67a6:	vfmadd231ps ymm3,ymm1,ymm0
    67ab:	vfmadd231ps ymm2,ymm1,ymm0
    67b0:	vfmadd231ps ymm13,ymm1,ymm0
    67b5:	vfmadd231ps ymm12,ymm1,ymm0
    67ba:	vfmadd231ps ymm11,ymm1,ymm0
    67bf:	vfmadd231ps ymm10,ymm1,ymm0
    67c4:	vfmadd231ps ymm9,ymm1,ymm0
    67c9:	vfmadd231ps ymm8,ymm1,ymm0
    67ce:	vfmadd231ps ymm7,ymm1,ymm0
    67d3:	vfmadd231ps ymm6,ymm1,ymm0
    67d8:	vfmadd231ps ymm5,ymm1,ymm0
    67dd:	vfmadd231ps ymm4,ymm1,ymm0
    67e2:	vfmadd231ps ymm3,ymm1,ymm0
    67e7:	vfmadd231ps ymm2,ymm1,ymm0
    67ec:	vfmadd231ps ymm13,ymm1,ymm0
    67f1:	vfmadd231ps ymm12,ymm1,ymm0
    67f6:	vfmadd231ps ymm11,ymm1,ymm0
    67fb:	vfmadd231ps ymm10,ymm1,ymm0
    6800:	vfmadd231ps ymm9,ymm1,ymm0
    6805:	vfmadd231ps ymm8,ymm1,ymm0
    680a:	vfmadd231ps ymm7,ymm1,ymm0
    680f:	vfmadd231ps ymm6,ymm1,ymm0
    6814:	vfmadd231ps ymm5,ymm1,ymm0
    6819:	vfmadd231ps ymm4,ymm1,ymm0
    681e:	vfmadd231ps ymm3,ymm1,ymm0
    6823:	vfmadd231ps ymm2,ymm1,ymm0
    6828:	vfmadd231ps ymm13,ymm1,ymm0
    682d:	vfmadd231ps ymm12,ymm1,ymm0
    6832:	vfmadd231ps ymm11,ymm1,ymm0
    6837:	vfmadd231ps ymm10,ymm1,ymm0
    683c:	vfmadd231ps ymm9,ymm1,ymm0
    6841:	vfmadd231ps ymm8,ymm1,ymm0
    6846:	vfmadd231ps ymm7,ymm1,ymm0
    684b:	vfmadd231ps ymm6,ymm1,ymm0
    6850:	vfmadd231ps ymm5,ymm1,ymm0
    6855:	vfmadd231ps ymm4,ymm1,ymm0
    685a:	vfmadd231ps ymm3,ymm1,ymm0
    685f:	vfmadd231ps ymm2,ymm1,ymm0
    6864:	vfmadd231ps ymm13,ymm1,ymm0
    6869:	vfmadd231ps ymm12,ymm1,ymm0
    686e:	vfmadd231ps ymm11,ymm1,ymm0
    6873:	vfmadd231ps ymm10,ymm1,ymm0
    6878:	vfmadd231ps ymm9,ymm1,ymm0
    687d:	vfmadd231ps ymm8,ymm1,ymm0
    6882:	vfmadd231ps ymm7,ymm1,ymm0
    6887:	vfmadd231ps ymm6,ymm1,ymm0
    688c:	vfmadd231ps ymm5,ymm1,ymm0
    6891:	vfmadd231ps ymm4,ymm1,ymm0
    6896:	vfmadd231ps ymm3,ymm1,ymm0
    689b:	vfmadd231ps ymm2,ymm1,ymm0
    68a0:	vfmadd231ps ymm13,ymm1,ymm0
    68a5:	vfmadd231ps ymm12,ymm1,ymm0
    68aa:	vfmadd231ps ymm11,ymm1,ymm0
    68af:	vfmadd231ps ymm10,ymm1,ymm0
    68b4:	vfmadd231ps ymm9,ymm1,ymm0
    68b9:	vfmadd231ps ymm8,ymm1,ymm0
    68be:	vfmadd231ps ymm7,ymm1,ymm0
    68c3:	vfmadd231ps ymm6,ymm1,ymm0
    68c8:	vfmadd231ps ymm5,ymm1,ymm0
    68cd:	vfmadd231ps ymm4,ymm1,ymm0
    68d2:	vfmadd231ps ymm3,ymm1,ymm0
    68d7:	vfmadd231ps ymm2,ymm1,ymm0
    68dc:	vfmadd231ps ymm13,ymm1,ymm0
    68e1:	vfmadd231ps ymm12,ymm1,ymm0
    68e6:	vfmadd231ps ymm11,ymm1,ymm0
    68eb:	vfmadd231ps ymm10,ymm1,ymm0
    68f0:	vfmadd231ps ymm9,ymm1,ymm0
    68f5:	vfmadd231ps ymm8,ymm1,ymm0
    68fa:	vfmadd231ps ymm7,ymm1,ymm0
    68ff:	vfmadd231ps ymm6,ymm1,ymm0
    6904:	vfmadd231ps ymm5,ymm1,ymm0
    6909:	vfmadd231ps ymm4,ymm1,ymm0
    690e:	vfmadd231ps ymm3,ymm1,ymm0
    6913:	vfmadd231ps ymm2,ymm1,ymm0
    6918:	vfmadd231ps ymm13,ymm1,ymm0
    691d:	vfmadd231ps ymm12,ymm1,ymm0
    6922:	vfmadd231ps ymm11,ymm1,ymm0
    6927:	vfmadd231ps ymm10,ymm1,ymm0
    692c:	vfmadd231ps ymm9,ymm1,ymm0
    6931:	vfmadd231ps ymm8,ymm1,ymm0
    6936:	vfmadd231ps ymm7,ymm1,ymm0
    693b:	vfmadd231ps ymm6,ymm1,ymm0
    6940:	vfmadd231ps ymm5,ymm1,ymm0
    6945:	vfmadd231ps ymm4,ymm1,ymm0
    694a:	vfmadd231ps ymm3,ymm1,ymm0
    694f:	vfmadd231ps ymm2,ymm1,ymm0
    6954:	vfmadd231ps ymm13,ymm1,ymm0
    6959:	vfmadd231ps ymm12,ymm1,ymm0
    695e:	vfmadd231ps ymm11,ymm1,ymm0
    6963:	vfmadd231ps ymm10,ymm1,ymm0
    6968:	inc    rax
    696b:	cmp    rdi,rax
    696e:	jne    6788 <void fp32_avx2_fma<12>(unsigned long)+0x58>
    6974:	vzeroupper
    6977:	ret
    6978:	vbroadcastss ymm10,DWORD PTR [rip+0x385f]        # a1e0 <K_VALUES+0x20>
    6981:	vmovaps ymm11,ymm10
    6986:	vmovaps ymm12,ymm10
    698b:	vmovaps ymm13,ymm10
    6990:	vmovaps ymm2,ymm10
    6994:	vmovaps ymm3,ymm10
    6998:	vmovaps ymm4,ymm10
    699c:	vmovaps ymm5,ymm10
    69a0:	vmovaps ymm6,ymm10
    69a4:	vmovaps ymm7,ymm10
    69a8:	vmovaps ymm8,ymm10
    69ad:	vmovaps ymm9,ymm10
    69b2:	vzeroupper
    69b5:	ret
    69b6:	cs nop WORD PTR [rax+rax*1+0x0]

00000000000069c0 <void fp32_avx2_fma<16>(unsigned long)>:
    69c0:	endbr64
    69c4:	test   rdi,rdi
    69c7:	je     6cc8 <void fp32_avx2_fma<16>(unsigned long)+0x308>
    69cd:	vbroadcastss ymm0,DWORD PTR [rip+0x380a]        # a1e0 <K_VALUES+0x20>
    69d6:	vbroadcastss ymm1,DWORD PTR [rip+0x3811]        # a1f0 <K_VALUES+0x30>
    69df:	xor    eax,eax
    69e1:	vmovaps ymm2,ymm0
    69e5:	vmovaps ymm17,ymm0
    69eb:	vmovaps ymm3,ymm0
    69ef:	vmovaps ymm4,ymm0
    69f3:	vmovaps ymm5,ymm0
    69f7:	vmovaps ymm6,ymm0
    69fb:	vmovaps ymm7,ymm0
    69ff:	vmovaps ymm8,ymm0
    6a03:	vmovaps ymm9,ymm0
    6a07:	vmovaps ymm10,ymm0
    6a0b:	vmovaps ymm11,ymm0
    6a0f:	vmovaps ymm12,ymm0
    6a13:	vmovaps ymm13,ymm0
    6a17:	vmovaps ymm14,ymm0
    6a1b:	vmovaps ymm15,ymm0
    6a1f:	vmovaps ymm16,ymm0
    6a25:	nop    DWORD PTR [rax]
    6a28:	vfmadd231ps ymm16,ymm1,ymm0
    6a2e:	vfmadd231ps ymm15,ymm1,ymm0
    6a33:	vfmadd231ps ymm14,ymm1,ymm0
    6a38:	vfmadd231ps ymm13,ymm1,ymm0
    6a3d:	vfmadd231ps ymm12,ymm1,ymm0
    6a42:	vfmadd231ps ymm11,ymm1,ymm0
    6a47:	vfmadd231ps ymm10,ymm1,ymm0
    6a4c:	vfmadd231ps ymm9,ymm1,ymm0
    6a51:	vfmadd231ps ymm8,ymm1,ymm0
    6a56:	vfmadd231ps ymm7,ymm1,ymm0
    6a5b:	vfmadd231ps ymm6,ymm1,ymm0
    6a60:	vfmadd231ps ymm5,ymm1,ymm0
    6a65:	vfmadd231ps ymm4,ymm1,ymm0
    6a6a:	vfmadd231ps ymm3,ymm1,ymm0
    6a6f:	vfmadd231ps ymm17,ymm1,ymm0
    6a75:	vfmadd231ps ymm2,ymm1,ymm0
    6a7a:	vfmadd231ps ymm16,ymm1,ymm0
    6a80:	vfmadd231ps ymm15,ymm1,ymm0
    6a85:	vfmadd231ps ymm14,ymm1,ymm0
    6a8a:	vfmadd231ps ymm13,ymm1,ymm0
    6a8f:	vfmadd231ps ymm12,ymm1,ymm0
    6a94:	vfmadd231ps ymm11,ymm1,ymm0
    6a99:	vfmadd231ps ymm10,ymm1,ymm0
    6a9e:	vfmadd231ps ymm9,ymm1,ymm0
    6aa3:	vfmadd231ps ymm8,ymm1,ymm0
    6aa8:	vfmadd231ps ymm7,ymm1,ymm0
    6aad:	vfmadd231ps ymm6,ymm1,ymm0
    6ab2:	vfmadd231ps ymm5,ymm1,ymm0
    6ab7:	vfmadd231ps ymm4,ymm1,ymm0
    6abc:	vfmadd231ps ymm3,ymm1,ymm0
    6ac1:	vfmadd231ps ymm17,ymm1,ymm0
    6ac7:	vfmadd231ps ymm2,ymm1,ymm0
    6acc:	vfmadd231ps ymm16,ymm1,ymm0
    6ad2:	vfmadd231ps ymm15,ymm1,ymm0
    6ad7:	vfmadd231ps ymm14,ymm1,ymm0
    6adc:	vfmadd231ps ymm13,ymm1,ymm0
    6ae1:	vfmadd231ps ymm12,ymm1,ymm0
    6ae6:	vfmadd231ps ymm11,ymm1,ymm0
    6aeb:	vfmadd231ps ymm10,ymm1,ymm0
    6af0:	vfmadd231ps ymm9,ymm1,ymm0
    6af5:	vfmadd231ps ymm8,ymm1,ymm0
    6afa:	vfmadd231ps ymm7,ymm1,ymm0
    6aff:	vfmadd231ps ymm6,ymm1,ymm0
    6b04:	vfmadd231ps ymm5,ymm1,ymm0
    6b09:	vfmadd231ps ymm4,ymm1,ymm0
    6b0e:	vfmadd231ps ymm3,ymm1,ymm0
    6b13:	vfmadd231ps ymm17,ymm1,ymm0
    6b19:	vfmadd231ps ymm2,ymm1,ymm0
    6b1e:	vfmadd231ps ymm16,ymm1,ymm0
    6b24:	vfmadd231ps ymm15,ymm1,ymm0
    6b29:	vfmadd231ps ymm14,ymm1,ymm0
    6b2e:	vfmadd231ps ymm13,ymm1,ymm0
    6b33:	vfmadd231ps ymm12,ymm1,ymm0
    6b38:	vfmadd231ps ymm11,ymm1,ymm0
    6b3d:	vfmadd231ps ymm10,ymm1,ymm0
    6b42:	vfmadd231ps ymm9,ymm1,ymm0
    6b47:	vfmadd231ps ymm8,ymm1,ymm0
    6b4c:	vfmadd231ps ymm7,ymm1,ymm0
    6b51:	vfmadd231ps ymm6,ymm1,ymm0
    6b56:	vfmadd231ps ymm5,ymm1,ymm0
    6b5b:	vfmadd231ps ymm4,ymm1,ymm0
    6b60:	vfmadd231ps ymm3,ymm1,ymm0
    6b65:	vfmadd231ps ymm17,ymm1,ymm0
    6b6b:	vfmadd231ps ymm2,ymm1,ymm0
    6b70:	vfmadd231ps ymm16,ymm1,ymm0
    6b76:	vfmadd231ps ymm15,ymm1,ymm0
    6b7b:	vfmadd231ps ymm14,ymm1,ymm0
    6b80:	vfmadd231ps ymm13,ymm1,ymm0
    6b85:	vfmadd231ps ymm12,ymm1,ymm0
    6b8a:	vfmadd231ps ymm11,ymm1,ymm0
    6b8f:	vfmadd231ps ymm10,ymm1,ymm0
    6b94:	vfmadd231ps ymm9,ymm1,ymm0
    6b99:	vfmadd231ps ymm8,ymm1,ymm0
    6b9e:	vfmadd231ps ymm7,ymm1,ymm0
    6ba3:	vfmadd231ps ymm6,ymm1,ymm0
    6ba8:	vfmadd231ps ymm5,ymm1,ymm0
    6bad:	vfmadd231ps ymm4,ymm1,ymm0
    6bb2:	vfmadd231ps ymm3,ymm1,ymm0
    6bb7:	vfmadd231ps ymm17,ymm1,ymm0
    6bbd:	vfmadd231ps ymm2,ymm1,ymm0
    6bc2:	vfmadd231ps ymm16,ymm1,ymm0
    6bc8:	vfmadd231ps ymm15,ymm1,ymm0
    6bcd:	vfmadd231ps ymm14,ymm1,ymm0
    6bd2:	vfmadd231ps ymm13,ymm1,ymm0
    6bd7:	vfmadd231ps ymm12,ymm1,ymm0
    6bdc:	vfmadd231ps ymm11,ymm1,ymm0
    6be1:	vfmadd231ps ymm10,ymm1,ymm0
    6be6:	vfmadd231ps ymm9,ymm1,ymm0
    6beb:	vfmadd231ps ymm8,ymm1,ymm0
    6bf0:	vfmadd231ps ymm7,ymm1,ymm0
    6bf5:	vfmadd231ps ymm6,ymm1,ymm0
    6bfa:	vfmadd231ps ymm5,ymm1,ymm0
    6bff:	vfmadd231ps ymm4,ymm1,ymm0
    6c04:	vfmadd231ps ymm3,ymm1,ymm0
    6c09:	vfmadd231ps ymm17,ymm1,ymm0
    6c0f:	vfmadd231ps ymm2,ymm1,ymm0
    6c14:	vfmadd231ps ymm16,ymm1,ymm0
    6c1a:	vfmadd231ps ymm15,ymm1,ymm0
    6c1f:	vfmadd231ps ymm14,ymm1,ymm0
    6c24:	vfmadd231ps ymm13,ymm1,ymm0
    6c29:	vfmadd231ps ymm12,ymm1,ymm0
    6c2e:	vfmadd231ps ymm11,ymm1,ymm0
    6c33:	vfmadd231ps ymm10,ymm1,ymm0
    6c38:	vfmadd231ps ymm9,ymm1,ymm0
    6c3d:	vfmadd231ps ymm8,ymm1,ymm0
    6c42:	vfmadd231ps ymm7,ymm1,ymm0
    6c47:	vfmadd231ps ymm6,ymm1,ymm0
    6c4c:	vfmadd231ps ymm5,ymm1,ymm0
    6c51:	vfmadd231ps ymm4,ymm1,ymm0
    6c56:	vfmadd231ps ymm3,ymm1,ymm0
    6c5b:	vfmadd231ps ymm17,ymm1,ymm0
    6c61:	vfmadd231ps ymm2,ymm1,ymm0
    6c66:	vfmadd231ps ymm16,ymm1,ymm0
    6c6c:	vfmadd231ps ymm15,ymm1,ymm0
    6c71:	vfmadd231ps ymm14,ymm1,ymm0
    6c76:	vfmadd231ps ymm13,ymm1,ymm0
    6c7b:	vfmadd231ps ymm12,ymm1,ymm0
    6c80:	vfmadd231ps ymm11,ymm1,ymm0
    6c85:	vfmadd231ps ymm10,ymm1,ymm0
    6c8a:	vfmadd231ps ymm9,ymm1,ymm0
    6c8f:	vfmadd231ps ymm8,ymm1,ymm0
    6c94:	vfmadd231ps ymm7,ymm1,ymm0
    6c99:	vfmadd231ps ymm6,ymm1,ymm0
    6c9e:	vfmadd231ps ymm5,ymm1,ymm0
    6ca3:	vfmadd231ps ymm4,ymm1,ymm0
    6ca8:	vfmadd231ps ymm3,ymm1,ymm0
    6cad:	vfmadd231ps ymm17,ymm1,ymm0
    6cb3:	vfmadd231ps ymm2,ymm1,ymm0
    6cb8:	inc    rax
    6cbb:	cmp    rdi,rax
    6cbe:	jne    6a28 <void fp32_avx2_fma<16>(unsigned long)+0x68>
    6cc4:	vzeroupper
    6cc7:	ret
    6cc8:	vbroadcastss ymm2,DWORD PTR [rip+0x350f]        # a1e0 <K_VALUES+0x20>
    6cd1:	vmovaps ymm17,ymm2
    6cd7:	vmovaps ymm3,ymm2
    6cdb:	vmovaps ymm4,ymm2
    6cdf:	vmovaps ymm5,ymm2
    6ce3:	vmovaps ymm6,ymm2
    6ce7:	vmovaps ymm7,ymm2
    6ceb:	vmovaps ymm8,ymm2
    6cef:	vmovaps ymm9,ymm2
    6cf3:	vmovaps ymm10,ymm2
    6cf7:	vmovaps ymm11,ymm2
    6cfb:	vmovaps ymm12,ymm2
    6cff:	vmovaps ymm13,ymm2
    6d03:	vmovaps ymm14,ymm2
    6d07:	vmovaps ymm15,ymm2
    6d0b:	vmovaps ymm16,ymm2
    6d11:	vzeroupper
    6d14:	ret
    6d15:	data16 cs nop WORD PTR [rax+rax*1+0x0]

0000000000006d20 <void fp32_avx512_add<1>(unsigned long)>:
    6d20:	endbr64
    6d24:	test   rdi,rdi
    6d27:	je     6d84 <void fp32_avx512_add<1>(unsigned long)+0x64>
    6d29:	vbroadcastss zmm1,DWORD PTR [rip+0x34ad]        # a1e0 <K_VALUES+0x20>
    6d33:	vbroadcastss zmm2,DWORD PTR [rip+0x34b3]        # a1f0 <K_VALUES+0x30>
    6d3d:	xor    eax,eax
    6d3f:	vmovaps zmm0,zmm1
    6d45:	nop    DWORD PTR [rax]
    6d48:	vaddps zmm0,zmm0,zmm2
    6d4e:	vaddps zmm0,zmm0,zmm2
    6d54:	vaddps zmm0,zmm0,zmm2
    6d5a:	vaddps zmm0,zmm0,zmm2
    6d60:	vaddps zmm0,zmm0,zmm2
    6d66:	vaddps zmm0,zmm0,zmm2
    6d6c:	vaddps zmm0,zmm0,zmm2
    6d72:	vaddps zmm0,zmm0,zmm2
    6d78:	inc    rax
    6d7b:	cmp    rdi,rax
    6d7e:	jne    6d48 <void fp32_avx512_add<1>(unsigned long)+0x28>
    6d80:	vzeroupper
    6d83:	ret
    6d84:	vbroadcastss zmm0,DWORD PTR [rip+0x3452]        # a1e0 <K_VALUES+0x20>
    6d8e:	vzeroupper
    6d91:	ret
    6d92:	data16 cs nop WORD PTR [rax+rax*1+0x0]
    6d9d:	nop    DWORD PTR [rax]

0000000000006da0 <void fp32_avx512_add<2>(unsigned long)>:
    6da0:	endbr64
    6da4:	test   rdi,rdi
    6da7:	je     6e3c <void fp32_avx512_add<2>(unsigned long)+0x9c>
    6dad:	vbroadcastss zmm2,DWORD PTR [rip+0x3429]        # a1e0 <K_VALUES+0x20>
    6db7:	vbroadcastss zmm3,DWORD PTR [rip+0x342f]        # a1f0 <K_VALUES+0x30>
    6dc1:	xor    eax,eax
    6dc3:	vmovaps zmm0,zmm2
    6dc9:	vmovaps zmm1,zmm2
    6dcf:	nop
    6dd0:	vaddps zmm1,zmm1,zmm3
    6dd6:	vaddps zmm0,zmm0,zmm3
    6ddc:	vaddps zmm1,zmm1,zmm3
    6de2:	vaddps zmm0,zmm0,zmm3
    6de8:	vaddps zmm1,zmm1,zmm3
    6dee:	vaddps zmm0,zmm0,zmm3
    6df4:	vaddps zmm1,zmm1,zmm3
    6dfa:	vaddps zmm0,zmm0,zmm3
    6e00:	vaddps zmm1,zmm1,zmm3
    6e06:	vaddps zmm0,zmm0,zmm3
    6e0c:	vaddps zmm1,zmm1,zmm3
    6e12:	vaddps zmm0,zmm0,zmm3
    6e18:	vaddps zmm1,zmm1,zmm3
    6e1e:	vaddps zmm0,zmm0,zmm3
    6e24:	vaddps zmm1,zmm1,zmm3
    6e2a:	vaddps zmm0,zmm0,zmm3
    6e30:	inc    rax
    6e33:	cmp    rdi,rax
    6e36:	jne    6dd0 <void fp32_avx512_add<2>(unsigned long)+0x30>
    6e38:	vzeroupper
    6e3b:	ret
    6e3c:	vbroadcastss zmm0,DWORD PTR [rip+0x339a]        # a1e0 <K_VALUES+0x20>
    6e46:	vmovaps zmm1,zmm0
    6e4c:	vzeroupper
    6e4f:	ret

0000000000006e50 <void fp32_avx512_add<4>(unsigned long)>:
    6e50:	endbr64
    6e54:	test   rdi,rdi
    6e57:	je     6f60 <void fp32_avx512_add<4>(unsigned long)+0x110>
    6e5d:	vbroadcastss zmm4,DWORD PTR [rip+0x3379]        # a1e0 <K_VALUES+0x20>
    6e67:	vbroadcastss zmm5,DWORD PTR [rip+0x337f]        # a1f0 <K_VALUES+0x30>
    6e71:	xor    eax,eax
    6e73:	vmovaps zmm0,zmm4
    6e79:	vmovaps zmm1,zmm4
    6e7f:	vmovaps zmm2,zmm4
    6e85:	vmovaps zmm3,zmm4
    6e8b:	nop    DWORD PTR [rax+rax*1+0x0]
    6e90:	vaddps zmm3,zmm3,zmm5
    6e96:	vaddps zmm2,zmm2,zmm5
    6e9c:	vaddps zmm1,zmm1,zmm5
    6ea2:	vaddps zmm0,zmm0,zmm5
    6ea8:	vaddps zmm3,zmm3,zmm5
    6eae:	vaddps zmm2,zmm2,zmm5
    6eb4:	vaddps zmm1,zmm1,zmm5
    6eba:	vaddps zmm0,zmm0,zmm5
    6ec0:	vaddps zmm3,zmm3,zmm5
    6ec6:	vaddps zmm2,zmm2,zmm5
    6ecc:	vaddps zmm1,zmm1,zmm5
    6ed2:	vaddps zmm0,zmm0,zmm5
    6ed8:	vaddps zmm3,zmm3,zmm5
    6ede:	vaddps zmm2,zmm2,zmm5
    6ee4:	vaddps zmm1,zmm1,zmm5
    6eea:	vaddps zmm0,zmm0,zmm5
    6ef0:	vaddps zmm3,zmm3,zmm5
    6ef6:	vaddps zmm2,zmm2,zmm5
    6efc:	vaddps zmm1,zmm1,zmm5
    6f02:	vaddps zmm0,zmm0,zmm5
    6f08:	vaddps zmm3,zmm3,zmm5
    6f0e:	vaddps zmm2,zmm2,zmm5
    6f14:	vaddps zmm1,zmm1,zmm5
    6f1a:	vaddps zmm0,zmm0,zmm5
    6f20:	vaddps zmm3,zmm3,zmm5
    6f26:	vaddps zmm2,zmm2,zmm5
    6f2c:	vaddps zmm1,zmm1,zmm5
    6f32:	vaddps zmm0,zmm0,zmm5
    6f38:	vaddps zmm3,zmm3,zmm5
    6f3e:	vaddps zmm2,zmm2,zmm5
    6f44:	vaddps zmm1,zmm1,zmm5
    6f4a:	vaddps zmm0,zmm0,zmm5
    6f50:	inc    rax
    6f53:	cmp    rdi,rax
    6f56:	jne    6e90 <void fp32_avx512_add<4>(unsigned long)+0x40>
    6f5c:	vzeroupper
    6f5f:	ret
    6f60:	vbroadcastss zmm0,DWORD PTR [rip+0x3276]        # a1e0 <K_VALUES+0x20>
    6f6a:	vmovaps zmm1,zmm0
    6f70:	vmovaps zmm2,zmm0
    6f76:	vmovaps zmm3,zmm0
    6f7c:	vzeroupper
    6f7f:	ret

0000000000006f80 <void fp32_avx512_add<6>(unsigned long)>:
    6f80:	endbr64
    6f84:	test   rdi,rdi
    6f87:	je     7100 <void fp32_avx512_add<6>(unsigned long)+0x180>
    6f8d:	vbroadcastss zmm0,DWORD PTR [rip+0x3249]        # a1e0 <K_VALUES+0x20>
    6f97:	vbroadcastss zmm1,DWORD PTR [rip+0x324f]        # a1f0 <K_VALUES+0x30>
    6fa1:	xor    eax,eax
    6fa3:	vmovaps zmm2,zmm0
    6fa9:	vmovaps zmm3,zmm0
    6faf:	vmovaps zmm4,zmm0
    6fb5:	vmovaps zmm5,zmm0
    6fbb:	vmovaps zmm6,zmm0
    6fc1:	vmovaps zmm7,zmm0
    6fc7:	nop    WORD PTR [rax+rax*1+0x0]
    6fd0:	vaddps zmm7,zmm7,zmm1
    6fd6:	vaddps zmm6,zmm6,zmm1
    6fdc:	vaddps zmm5,zmm5,zmm1
    6fe2:	vaddps zmm4,zmm4,zmm1
    6fe8:	vaddps zmm3,zmm3,zmm1
    6fee:	vaddps zmm2,zmm2,zmm1
    6ff4:	vaddps zmm7,zmm7,zmm1
    6ffa:	vaddps zmm6,zmm6,zmm1
    7000:	vaddps zmm5,zmm5,zmm1
    7006:	vaddps zmm4,zmm4,zmm1
    700c:	vaddps zmm3,zmm3,zmm1
    7012:	vaddps zmm2,zmm2,zmm1
    7018:	vaddps zmm7,zmm7,zmm1
    701e:	vaddps zmm6,zmm6,zmm1
    7024:	vaddps zmm5,zmm5,zmm1
    702a:	vaddps zmm4,zmm4,zmm1
    7030:	vaddps zmm3,zmm3,zmm1
    7036:	vaddps zmm2,zmm2,zmm1
    703c:	vaddps zmm7,zmm7,zmm1
    7042:	vaddps zmm6,zmm6,zmm1
    7048:	vaddps zmm5,zmm5,zmm1
    704e:	vaddps zmm4,zmm4,zmm1
    7054:	vaddps zmm3,zmm3,zmm1
    705a:	vaddps zmm2,zmm2,zmm1
    7060:	vaddps zmm7,zmm7,zmm1
    7066:	vaddps zmm6,zmm6,zmm1
    706c:	vaddps zmm5,zmm5,zmm1
    7072:	vaddps zmm4,zmm4,zmm1
    7078:	vaddps zmm3,zmm3,zmm1
    707e:	vaddps zmm2,zmm2,zmm1
    7084:	vaddps zmm7,zmm7,zmm1
    708a:	vaddps zmm6,zmm6,zmm1
    7090:	vaddps zmm5,zmm5,zmm1
    7096:	vaddps zmm4,zmm4,zmm1
    709c:	vaddps zmm3,zmm3,zmm1
    70a2:	vaddps zmm2,zmm2,zmm1
    70a8:	vaddps zmm7,zmm7,zmm1
    70ae:	vaddps zmm6,zmm6,zmm1
    70b4:	vaddps zmm5,zmm5,zmm1
    70ba:	vaddps zmm4,zmm4,zmm1
    70c0:	vaddps zmm3,zmm3,zmm1
    70c6:	vaddps zmm2,zmm2,zmm1
    70cc:	vaddps zmm7,zmm7,zmm1
    70d2:	vaddps zmm6,zmm6,zmm1
    70d8:	vaddps zmm5,zmm5,zmm1
    70de:	vaddps zmm4,zmm4,zmm1
    70e4:	vaddps zmm3,zmm3,zmm1
    70ea:	vaddps zmm2,zmm2,zmm1
    70f0:	inc    rax
    70f3:	cmp    rdi,rax
    70f6:	jne    6fd0 <void fp32_avx512_add<6>(unsigned long)+0x50>
    70fc:	vzeroupper
    70ff:	ret
    7100:	vbroadcastss zmm2,DWORD PTR [rip+0x30d6]        # a1e0 <K_VALUES+0x20>
    710a:	vmovaps zmm3,zmm2
    7110:	vmovaps zmm4,zmm2
    7116:	vmovaps zmm5,zmm2
    711c:	vmovaps zmm6,zmm2
    7122:	vmovaps zmm7,zmm2
    7128:	vzeroupper
    712b:	ret
    712c:	nop    DWORD PTR [rax+0x0]

0000000000007130 <void fp32_avx512_add<8>(unsigned long)>:
    7130:	endbr64
    7134:	test   rdi,rdi
    7137:	je     7318 <void fp32_avx512_add<8>(unsigned long)+0x1e8>
    713d:	vbroadcastss zmm0,DWORD PTR [rip+0x3099]        # a1e0 <K_VALUES+0x20>
    7147:	vbroadcastss zmm1,DWORD PTR [rip+0x309f]        # a1f0 <K_VALUES+0x30>
    7151:	xor    eax,eax
    7153:	vmovaps zmm2,zmm0
    7159:	vmovaps zmm3,zmm0
    715f:	vmovaps zmm4,zmm0
    7165:	vmovaps zmm5,zmm0
    716b:	vmovaps zmm6,zmm0
    7171:	vmovaps zmm7,zmm0
    7177:	vmovaps zmm8,zmm0
    717d:	vmovaps zmm9,zmm0
    7183:	nop    DWORD PTR [rax+rax*1+0x0]
    7188:	vaddps zmm9,zmm9,zmm1
    718e:	vaddps zmm8,zmm8,zmm1
    7194:	vaddps zmm7,zmm7,zmm1
    719a:	vaddps zmm6,zmm6,zmm1
    71a0:	vaddps zmm5,zmm5,zmm1
    71a6:	vaddps zmm4,zmm4,zmm1
    71ac:	vaddps zmm3,zmm3,zmm1
    71b2:	vaddps zmm2,zmm2,zmm1
    71b8:	vaddps zmm9,zmm9,zmm1
    71be:	vaddps zmm8,zmm8,zmm1
    71c4:	vaddps zmm7,zmm7,zmm1
    71ca:	vaddps zmm6,zmm6,zmm1
    71d0:	vaddps zmm5,zmm5,zmm1
    71d6:	vaddps zmm4,zmm4,zmm1
    71dc:	vaddps zmm3,zmm3,zmm1
    71e2:	vaddps zmm2,zmm2,zmm1
    71e8:	vaddps zmm9,zmm9,zmm1
    71ee:	vaddps zmm8,zmm8,zmm1
    71f4:	vaddps zmm7,zmm7,zmm1
    71fa:	vaddps zmm6,zmm6,zmm1
    7200:	vaddps zmm5,zmm5,zmm1
    7206:	vaddps zmm4,zmm4,zmm1
    720c:	vaddps zmm3,zmm3,zmm1
    7212:	vaddps zmm2,zmm2,zmm1
    7218:	vaddps zmm9,zmm9,zmm1
    721e:	vaddps zmm8,zmm8,zmm1
    7224:	vaddps zmm7,zmm7,zmm1
    722a:	vaddps zmm6,zmm6,zmm1
    7230:	vaddps zmm5,zmm5,zmm1
    7236:	vaddps zmm4,zmm4,zmm1
    723c:	vaddps zmm3,zmm3,zmm1
    7242:	vaddps zmm2,zmm2,zmm1
    7248:	vaddps zmm9,zmm9,zmm1
    724e:	vaddps zmm8,zmm8,zmm1
    7254:	vaddps zmm7,zmm7,zmm1
    725a:	vaddps zmm6,zmm6,zmm1
    7260:	vaddps zmm5,zmm5,zmm1
    7266:	vaddps zmm4,zmm4,zmm1
    726c:	vaddps zmm3,zmm3,zmm1
    7272:	vaddps zmm2,zmm2,zmm1
    7278:	vaddps zmm9,zmm9,zmm1
    727e:	vaddps zmm8,zmm8,zmm1
    7284:	vaddps zmm7,zmm7,zmm1
    728a:	vaddps zmm6,zmm6,zmm1
    7290:	vaddps zmm5,zmm5,zmm1
    7296:	vaddps zmm4,zmm4,zmm1
    729c:	vaddps zmm3,zmm3,zmm1
    72a2:	vaddps zmm2,zmm2,zmm1
    72a8:	vaddps zmm9,zmm9,zmm1
    72ae:	vaddps zmm8,zmm8,zmm1
    72b4:	vaddps zmm7,zmm7,zmm1
    72ba:	vaddps zmm6,zmm6,zmm1
    72c0:	vaddps zmm5,zmm5,zmm1
    72c6:	vaddps zmm4,zmm4,zmm1
    72cc:	vaddps zmm3,zmm3,zmm1
    72d2:	vaddps zmm2,zmm2,zmm1
    72d8:	vaddps zmm9,zmm9,zmm1
    72de:	vaddps zmm8,zmm8,zmm1
    72e4:	vaddps zmm7,zmm7,zmm1
    72ea:	vaddps zmm6,zmm6,zmm1
    72f0:	vaddps zmm5,zmm5,zmm1
    72f6:	vaddps zmm4,zmm4,zmm1
    72fc:	vaddps zmm3,zmm3,zmm1
    7302:	vaddps zmm2,zmm2,zmm1
    7308:	inc    rax
    730b:	cmp    rdi,rax
    730e:	jne    7188 <void fp32_avx512_add<8>(unsigned long)+0x58>
    7314:	vzeroupper
    7317:	ret
    7318:	vbroadcastss zmm2,DWORD PTR [rip+0x2ebe]        # a1e0 <K_VALUES+0x20>
    7322:	vmovaps zmm3,zmm2
    7328:	vmovaps zmm4,zmm2
    732e:	vmovaps zmm5,zmm2
    7334:	vmovaps zmm6,zmm2
    733a:	vmovaps zmm7,zmm2
    7340:	vmovaps zmm8,zmm2
    7346:	vmovaps zmm9,zmm2
    734c:	vzeroupper
    734f:	ret

0000000000007350 <void fp32_avx512_add<10>(unsigned long)>:
    7350:	endbr64
    7354:	test   rdi,rdi
    7357:	je     75a0 <void fp32_avx512_add<10>(unsigned long)+0x250>
    735d:	vbroadcastss zmm0,DWORD PTR [rip+0x2e79]        # a1e0 <K_VALUES+0x20>
    7367:	vbroadcastss zmm1,DWORD PTR [rip+0x2e7f]        # a1f0 <K_VALUES+0x30>
    7371:	xor    eax,eax
    7373:	vmovaps zmm2,zmm0
    7379:	vmovaps zmm3,zmm0
    737f:	vmovaps zmm4,zmm0
    7385:	vmovaps zmm5,zmm0
    738b:	vmovaps zmm6,zmm0
    7391:	vmovaps zmm7,zmm0
    7397:	vmovaps zmm8,zmm0
    739d:	vmovaps zmm9,zmm0
    73a3:	vmovaps zmm10,zmm0
    73a9:	vmovaps zmm11,zmm0
    73af:	nop
    73b0:	vaddps zmm11,zmm11,zmm1
    73b6:	vaddps zmm10,zmm10,zmm1
    73bc:	vaddps zmm9,zmm9,zmm1
    73c2:	vaddps zmm8,zmm8,zmm1
    73c8:	vaddps zmm7,zmm7,zmm1
    73ce:	vaddps zmm6,zmm6,zmm1
    73d4:	vaddps zmm5,zmm5,zmm1
    73da:	vaddps zmm4,zmm4,zmm1
    73e0:	vaddps zmm3,zmm3,zmm1
    73e6:	vaddps zmm2,zmm2,zmm1
    73ec:	vaddps zmm11,zmm11,zmm1
    73f2:	vaddps zmm10,zmm10,zmm1
    73f8:	vaddps zmm9,zmm9,zmm1
    73fe:	vaddps zmm8,zmm8,zmm1
    7404:	vaddps zmm7,zmm7,zmm1
    740a:	vaddps zmm6,zmm6,zmm1
    7410:	vaddps zmm5,zmm5,zmm1
    7416:	vaddps zmm4,zmm4,zmm1
    741c:	vaddps zmm3,zmm3,zmm1
    7422:	vaddps zmm2,zmm2,zmm1
    7428:	vaddps zmm11,zmm11,zmm1
    742e:	vaddps zmm10,zmm10,zmm1
    7434:	vaddps zmm9,zmm9,zmm1
    743a:	vaddps zmm8,zmm8,zmm1
    7440:	vaddps zmm7,zmm7,zmm1
    7446:	vaddps zmm6,zmm6,zmm1
    744c:	vaddps zmm5,zmm5,zmm1
    7452:	vaddps zmm4,zmm4,zmm1
    7458:	vaddps zmm3,zmm3,zmm1
    745e:	vaddps zmm2,zmm2,zmm1
    7464:	vaddps zmm11,zmm11,zmm1
    746a:	vaddps zmm10,zmm10,zmm1
    7470:	vaddps zmm9,zmm9,zmm1
    7476:	vaddps zmm8,zmm8,zmm1
    747c:	vaddps zmm7,zmm7,zmm1
    7482:	vaddps zmm6,zmm6,zmm1
    7488:	vaddps zmm5,zmm5,zmm1
    748e:	vaddps zmm4,zmm4,zmm1
    7494:	vaddps zmm3,zmm3,zmm1
    749a:	vaddps zmm2,zmm2,zmm1
    74a0:	vaddps zmm11,zmm11,zmm1
    74a6:	vaddps zmm10,zmm10,zmm1
    74ac:	vaddps zmm9,zmm9,zmm1
    74b2:	vaddps zmm8,zmm8,zmm1
    74b8:	vaddps zmm7,zmm7,zmm1
    74be:	vaddps zmm6,zmm6,zmm1
    74c4:	vaddps zmm5,zmm5,zmm1
    74ca:	vaddps zmm4,zmm4,zmm1
    74d0:	vaddps zmm3,zmm3,zmm1
    74d6:	vaddps zmm2,zmm2,zmm1
    74dc:	vaddps zmm11,zmm11,zmm1
    74e2:	vaddps zmm10,zmm10,zmm1
    74e8:	vaddps zmm9,zmm9,zmm1
    74ee:	vaddps zmm8,zmm8,zmm1
    74f4:	vaddps zmm7,zmm7,zmm1
    74fa:	vaddps zmm6,zmm6,zmm1
    7500:	vaddps zmm5,zmm5,zmm1
    7506:	vaddps zmm4,zmm4,zmm1
    750c:	vaddps zmm3,zmm3,zmm1
    7512:	vaddps zmm2,zmm2,zmm1
    7518:	vaddps zmm11,zmm11,zmm1
    751e:	vaddps zmm10,zmm10,zmm1
    7524:	vaddps zmm9,zmm9,zmm1
    752a:	vaddps zmm8,zmm8,zmm1
    7530:	vaddps zmm7,zmm7,zmm1
    7536:	vaddps zmm6,zmm6,zmm1
    753c:	vaddps zmm5,zmm5,zmm1
    7542:	vaddps zmm4,zmm4,zmm1
    7548:	vaddps zmm3,zmm3,zmm1
    754e:	vaddps zmm2,zmm2,zmm1
    7554:	vaddps zmm11,zmm11,zmm1
    755a:	vaddps zmm10,zmm10,zmm1
    7560:	vaddps zmm9,zmm9,zmm1
    7566:	vaddps zmm8,zmm8,zmm1
    756c:	vaddps zmm7,zmm7,zmm1
    7572:	vaddps zmm6,zmm6,zmm1
    7578:	vaddps zmm5,zmm5,zmm1
    757e:	vaddps zmm4,zmm4,zmm1
    7584:	vaddps zmm3,zmm3,zmm1
    758a:	vaddps zmm2,zmm2,zmm1
    7590:	inc    rax
    7593:	cmp    rdi,rax
    7596:	jne    73b0 <void fp32_avx512_add<10>(unsigned long)+0x60>
    759c:	vzeroupper
    759f:	ret
    75a0:	vbroadcastss zmm2,DWORD PTR [rip+0x2c36]        # a1e0 <K_VALUES+0x20>
    75aa:	vmovaps zmm3,zmm2
    75b0:	vmovaps zmm4,zmm2
    75b6:	vmovaps zmm5,zmm2
    75bc:	vmovaps zmm6,zmm2
    75c2:	vmovaps zmm7,zmm2
    75c8:	vmovaps zmm8,zmm2
    75ce:	vmovaps zmm9,zmm2
    75d4:	vmovaps zmm10,zmm2
    75da:	vmovaps zmm11,zmm2
    75e0:	vzeroupper
    75e3:	ret
    75e4:	data16 cs nop WORD PTR [rax+rax*1+0x0]
    75ef:	nop

00000000000075f0 <void fp32_avx512_add<12>(unsigned long)>:
    75f0:	endbr64
    75f4:	test   rdi,rdi
    75f7:	je     78b0 <void fp32_avx512_add<12>(unsigned long)+0x2c0>
    75fd:	vbroadcastss zmm0,DWORD PTR [rip+0x2bd9]        # a1e0 <K_VALUES+0x20>
    7607:	vbroadcastss zmm1,DWORD PTR [rip+0x2bdf]        # a1f0 <K_VALUES+0x30>
    7611:	xor    eax,eax
    7613:	vmovaps zmm10,zmm0
    7619:	vmovaps zmm11,zmm0
    761f:	vmovaps zmm12,zmm0
    7625:	vmovaps zmm13,zmm0
    762b:	vmovaps zmm2,zmm0
    7631:	vmovaps zmm3,zmm0
    7637:	vmovaps zmm4,zmm0
    763d:	vmovaps zmm5,zmm0
    7643:	vmovaps zmm6,zmm0
    7649:	vmovaps zmm7,zmm0
    764f:	vmovaps zmm8,zmm0
    7655:	vmovaps zmm9,zmm0
    765b:	nop    DWORD PTR [rax+rax*1+0x0]
    7660:	vaddps zmm9,zmm9,zmm1
    7666:	vaddps zmm8,zmm8,zmm1
    766c:	vaddps zmm7,zmm7,zmm1
    7672:	vaddps zmm6,zmm6,zmm1
    7678:	vaddps zmm5,zmm5,zmm1
    767e:	vaddps zmm4,zmm4,zmm1
    7684:	vaddps zmm3,zmm3,zmm1
    768a:	vaddps zmm2,zmm2,zmm1
    7690:	vaddps zmm13,zmm13,zmm1
    7696:	vaddps zmm12,zmm12,zmm1
    769c:	vaddps zmm11,zmm11,zmm1
    76a2:	vaddps zmm10,zmm10,zmm1
    76a8:	vaddps zmm9,zmm9,zmm1
    76ae:	vaddps zmm8,zmm8,zmm1
    76b4:	vaddps zmm7,zmm7,zmm1
    76ba:	vaddps zmm6,zmm6,zmm1
    76c0:	vaddps zmm5,zmm5,zmm1
    76c6:	vaddps zmm4,zmm4,zmm1
    76cc:	vaddps zmm3,zmm3,zmm1
    76d2:	vaddps zmm2,zmm2,zmm1
    76d8:	vaddps zmm13,zmm13,zmm1
    76de:	vaddps zmm12,zmm12,zmm1
    76e4:	vaddps zmm11,zmm11,zmm1
    76ea:	vaddps zmm10,zmm10,zmm1
    76f0:	vaddps zmm9,zmm9,zmm1
    76f6:	vaddps zmm8,zmm8,zmm1
    76fc:	vaddps zmm7,zmm7,zmm1
    7702:	vaddps zmm6,zmm6,zmm1
    7708:	vaddps zmm5,zmm5,zmm1
    770e:	vaddps zmm4,zmm4,zmm1
    7714:	vaddps zmm3,zmm3,zmm1
    771a:	vaddps zmm2,zmm2,zmm1
    7720:	vaddps zmm13,zmm13,zmm1
    7726:	vaddps zmm12,zmm12,zmm1
    772c:	vaddps zmm11,zmm11,zmm1
    7732:	vaddps zmm10,zmm10,zmm1
    7738:	vaddps zmm9,zmm9,zmm1
    773e:	vaddps zmm8,zmm8,zmm1
    7744:	vaddps zmm7,zmm7,zmm1
    774a:	vaddps zmm6,zmm6,zmm1
    7750:	vaddps zmm5,zmm5,zmm1
    7756:	vaddps zmm4,zmm4,zmm1
    775c:	vaddps zmm3,zmm3,zmm1
    7762:	vaddps zmm2,zmm2,zmm1
    7768:	vaddps zmm13,zmm13,zmm1
    776e:	vaddps zmm12,zmm12,zmm1
    7774:	vaddps zmm11,zmm11,zmm1
    777a:	vaddps zmm10,zmm10,zmm1
    7780:	vaddps zmm9,zmm9,zmm1
    7786:	vaddps zmm8,zmm8,zmm1
    778c:	vaddps zmm7,zmm7,zmm1
    7792:	vaddps zmm6,zmm6,zmm1
    7798:	vaddps zmm5,zmm5,zmm1
    779e:	vaddps zmm4,zmm4,zmm1
    77a4:	vaddps zmm3,zmm3,zmm1
    77aa:	vaddps zmm2,zmm2,zmm1
    77b0:	vaddps zmm13,zmm13,zmm1
    77b6:	vaddps zmm12,zmm12,zmm1
    77bc:	vaddps zmm11,zmm11,zmm1
    77c2:	vaddps zmm10,zmm10,zmm1
    77c8:	vaddps zmm9,zmm9,zmm1
    77ce:	vaddps zmm8,zmm8,zmm1
    77d4:	vaddps zmm7,zmm7,zmm1
    77da:	vaddps zmm6,zmm6,zmm1
    77e0:	vaddps zmm5,zmm5,zmm1
    77e6:	vaddps zmm4,zmm4,zmm1
    77ec:	vaddps zmm3,zmm3,zmm1
    77f2:	vaddps zmm2,zmm2,zmm1
    77f8:	vaddps zmm13,zmm13,zmm1
    77fe:	vaddps zmm12,zmm12,zmm1
    7804:	vaddps zmm11,zmm11,zmm1
    780a:	vaddps zmm10,zmm10,zmm1
    7810:	vaddps zmm9,zmm9,zmm1
    7816:	vaddps zmm8,zmm8,zmm1
    781c:	vaddps zmm7,zmm7,zmm1
    7822:	vaddps zmm6,zmm6,zmm1
    7828:	vaddps zmm5,zmm5,zmm1
    782e:	vaddps zmm4,zmm4,zmm1
    7834:	vaddps zmm3,zmm3,zmm1
    783a:	vaddps zmm2,zmm2,zmm1
    7840:	vaddps zmm13,zmm13,zmm1
    7846:	vaddps zmm12,zmm12,zmm1
    784c:	vaddps zmm11,zmm11,zmm1
    7852:	vaddps zmm10,zmm10,zmm1
    7858:	vaddps zmm9,zmm9,zmm1
    785e:	vaddps zmm8,zmm8,zmm1
    7864:	vaddps zmm7,zmm7,zmm1
    786a:	vaddps zmm6,zmm6,zmm1
    7870:	vaddps zmm5,zmm5,zmm1
    7876:	vaddps zmm4,zmm4,zmm1
    787c:	vaddps zmm3,zmm3,zmm1
    7882:	vaddps zmm2,zmm2,zmm1
    7888:	vaddps zmm13,zmm13,zmm1
    788e:	vaddps zmm12,zmm12,zmm1
    7894:	vaddps zmm11,zmm11,zmm1
    789a:	vaddps zmm10,zmm10,zmm1
    78a0:	inc    rax
    78a3:	cmp    rdi,rax
    78a6:	jne    7660 <void fp32_avx512_add<12>(unsigned long)+0x70>
    78ac:	vzeroupper
    78af:	ret
    78b0:	vbroadcastss zmm10,DWORD PTR [rip+0x2926]        # a1e0 <K_VALUES+0x20>
    78ba:	vmovaps zmm11,zmm10
    78c0:	vmovaps zmm12,zmm10
    78c6:	vmovaps zmm13,zmm10
    78cc:	vmovaps zmm2,zmm10
    78d2:	vmovaps zmm3,zmm10
    78d8:	vmovaps zmm4,zmm10
    78de:	vmovaps zmm5,zmm10
    78e4:	vmovaps zmm6,zmm10
    78ea:	vmovaps zmm7,zmm10
    78f0:	vmovaps zmm8,zmm10
    78f6:	vmovaps zmm9,zmm10
    78fc:	vzeroupper
    78ff:	ret

0000000000007900 <void fp32_avx512_add<16>(unsigned long)>:
    7900:	endbr64
    7904:	test   rdi,rdi
    7907:	je     7c98 <void fp32_avx512_add<16>(unsigned long)+0x398>
    790d:	vbroadcastss zmm0,DWORD PTR [rip+0x28c9]        # a1e0 <K_VALUES+0x20>
    7917:	vbroadcastss zmm1,DWORD PTR [rip+0x28cf]        # a1f0 <K_VALUES+0x30>
    7921:	xor    eax,eax
    7923:	vmovaps zmm2,zmm0
    7929:	vmovaps zmm17,zmm0
    792f:	vmovaps zmm3,zmm0
    7935:	vmovaps zmm4,zmm0
    793b:	vmovaps zmm5,zmm0
    7941:	vmovaps zmm6,zmm0
    7947:	vmovaps zmm7,zmm0
    794d:	vmovaps zmm8,zmm0
    7953:	vmovaps zmm9,zmm0
    7959:	vmovaps zmm10,zmm0
    795f:	vmovaps zmm11,zmm0
    7965:	vmovaps zmm12,zmm0
    796b:	vmovaps zmm13,zmm0
    7971:	vmovaps zmm14,zmm0
    7977:	vmovaps zmm15,zmm0
    797d:	vmovaps zmm16,zmm0
    7983:	nop    DWORD PTR [rax+rax*1+0x0]
    7988:	vaddps zmm16,zmm16,zmm1
    798e:	vaddps zmm15,zmm15,zmm1
    7994:	vaddps zmm14,zmm14,zmm1
    799a:	vaddps zmm13,zmm13,zmm1
    79a0:	vaddps zmm12,zmm12,zmm1
    79a6:	vaddps zmm11,zmm11,zmm1
    79ac:	vaddps zmm10,zmm10,zmm1
    79b2:	vaddps zmm9,zmm9,zmm1
    79b8:	vaddps zmm8,zmm8,zmm1
    79be:	vaddps zmm7,zmm7,zmm1
    79c4:	vaddps zmm6,zmm6,zmm1
    79ca:	vaddps zmm5,zmm5,zmm1
    79d0:	vaddps zmm4,zmm4,zmm1
    79d6:	vaddps zmm3,zmm3,zmm1
    79dc:	vaddps zmm17,zmm17,zmm1
    79e2:	vaddps zmm2,zmm2,zmm1
    79e8:	vaddps zmm16,zmm16,zmm1
    79ee:	vaddps zmm15,zmm15,zmm1
    79f4:	vaddps zmm14,zmm14,zmm1
    79fa:	vaddps zmm13,zmm13,zmm1
    7a00:	vaddps zmm12,zmm12,zmm1
    7a06:	vaddps zmm11,zmm11,zmm1
    7a0c:	vaddps zmm10,zmm10,zmm1
    7a12:	vaddps zmm9,zmm9,zmm1
    7a18:	vaddps zmm8,zmm8,zmm1
    7a1e:	vaddps zmm7,zmm7,zmm1
    7a24:	vaddps zmm6,zmm6,zmm1
    7a2a:	vaddps zmm5,zmm5,zmm1
    7a30:	vaddps zmm4,zmm4,zmm1
    7a36:	vaddps zmm3,zmm3,zmm1
    7a3c:	vaddps zmm17,zmm17,zmm1
    7a42:	vaddps zmm2,zmm2,zmm1
    7a48:	vaddps zmm16,zmm16,zmm1
    7a4e:	vaddps zmm15,zmm15,zmm1
    7a54:	vaddps zmm14,zmm14,zmm1
    7a5a:	vaddps zmm13,zmm13,zmm1
    7a60:	vaddps zmm12,zmm12,zmm1
    7a66:	vaddps zmm11,zmm11,zmm1
    7a6c:	vaddps zmm10,zmm10,zmm1
    7a72:	vaddps zmm9,zmm9,zmm1
    7a78:	vaddps zmm8,zmm8,zmm1
    7a7e:	vaddps zmm7,zmm7,zmm1
    7a84:	vaddps zmm6,zmm6,zmm1
    7a8a:	vaddps zmm5,zmm5,zmm1
    7a90:	vaddps zmm4,zmm4,zmm1
    7a96:	vaddps zmm3,zmm3,zmm1
    7a9c:	vaddps zmm17,zmm17,zmm1
    7aa2:	vaddps zmm2,zmm2,zmm1
    7aa8:	vaddps zmm16,zmm16,zmm1
    7aae:	vaddps zmm15,zmm15,zmm1
    7ab4:	vaddps zmm14,zmm14,zmm1
    7aba:	vaddps zmm13,zmm13,zmm1
    7ac0:	vaddps zmm12,zmm12,zmm1
    7ac6:	vaddps zmm11,zmm11,zmm1
    7acc:	vaddps zmm10,zmm10,zmm1
    7ad2:	vaddps zmm9,zmm9,zmm1
    7ad8:	vaddps zmm8,zmm8,zmm1
    7ade:	vaddps zmm7,zmm7,zmm1
    7ae4:	vaddps zmm6,zmm6,zmm1
    7aea:	vaddps zmm5,zmm5,zmm1
    7af0:	vaddps zmm4,zmm4,zmm1
    7af6:	vaddps zmm3,zmm3,zmm1
    7afc:	vaddps zmm17,zmm17,zmm1
    7b02:	vaddps zmm2,zmm2,zmm1
    7b08:	vaddps zmm16,zmm16,zmm1
    7b0e:	vaddps zmm15,zmm15,zmm1
    7b14:	vaddps zmm14,zmm14,zmm1
    7b1a:	vaddps zmm13,zmm13,zmm1
    7b20:	vaddps zmm12,zmm12,zmm1
    7b26:	vaddps zmm11,zmm11,zmm1
    7b2c:	vaddps zmm10,zmm10,zmm1
    7b32:	vaddps zmm9,zmm9,zmm1
    7b38:	vaddps zmm8,zmm8,zmm1
    7b3e:	vaddps zmm7,zmm7,zmm1
    7b44:	vaddps zmm6,zmm6,zmm1
    7b4a:	vaddps zmm5,zmm5,zmm1
    7b50:	vaddps zmm4,zmm4,zmm1
    7b56:	vaddps zmm3,zmm3,zmm1
    7b5c:	vaddps zmm17,zmm17,zmm1
    7b62:	vaddps zmm2,zmm2,zmm1
    7b68:	vaddps zmm16,zmm16,zmm1
    7b6e:	vaddps zmm15,zmm15,zmm1
    7b74:	vaddps zmm14,zmm14,zmm1
    7b7a:	vaddps zmm13,zmm13,zmm1
    7b80:	vaddps zmm12,zmm12,zmm1
    7b86:	vaddps zmm11,zmm11,zmm1
    7b8c:	vaddps zmm10,zmm10,zmm1
    7b92:	vaddps zmm9,zmm9,zmm1
    7b98:	vaddps zmm8,zmm8,zmm1
    7b9e:	vaddps zmm7,zmm7,zmm1
    7ba4:	vaddps zmm6,zmm6,zmm1
    7baa:	vaddps zmm5,zmm5,zmm1
    7bb0:	vaddps zmm4,zmm4,zmm1
    7bb6:	vaddps zmm3,zmm3,zmm1
    7bbc:	vaddps zmm17,zmm17,zmm1
    7bc2:	vaddps zmm2,zmm2,zmm1
    7bc8:	vaddps zmm16,zmm16,zmm1
    7bce:	vaddps zmm15,zmm15,zmm1
    7bd4:	vaddps zmm14,zmm14,zmm1
    7bda:	vaddps zmm13,zmm13,zmm1
    7be0:	vaddps zmm12,zmm12,zmm1
    7be6:	vaddps zmm11,zmm11,zmm1
    7bec:	vaddps zmm10,zmm10,zmm1
    7bf2:	vaddps zmm9,zmm9,zmm1
    7bf8:	vaddps zmm8,zmm8,zmm1
    7bfe:	vaddps zmm7,zmm7,zmm1
    7c04:	vaddps zmm6,zmm6,zmm1
    7c0a:	vaddps zmm5,zmm5,zmm1
    7c10:	vaddps zmm4,zmm4,zmm1
    7c16:	vaddps zmm3,zmm3,zmm1
    7c1c:	vaddps zmm17,zmm17,zmm1
    7c22:	vaddps zmm2,zmm2,zmm1
    7c28:	vaddps zmm16,zmm16,zmm1
    7c2e:	vaddps zmm15,zmm15,zmm1
    7c34:	vaddps zmm14,zmm14,zmm1
    7c3a:	vaddps zmm13,zmm13,zmm1
    7c40:	vaddps zmm12,zmm12,zmm1
    7c46:	vaddps zmm11,zmm11,zmm1
    7c4c:	vaddps zmm10,zmm10,zmm1
    7c52:	vaddps zmm9,zmm9,zmm1
    7c58:	vaddps zmm8,zmm8,zmm1
    7c5e:	vaddps zmm7,zmm7,zmm1
    7c64:	vaddps zmm6,zmm6,zmm1
    7c6a:	vaddps zmm5,zmm5,zmm1
    7c70:	vaddps zmm4,zmm4,zmm1
    7c76:	vaddps zmm3,zmm3,zmm1
    7c7c:	vaddps zmm17,zmm17,zmm1
    7c82:	vaddps zmm2,zmm2,zmm1
    7c88:	inc    rax
    7c8b:	cmp    rdi,rax
    7c8e:	jne    7988 <void fp32_avx512_add<16>(unsigned long)+0x88>
    7c94:	vzeroupper
    7c97:	ret
    7c98:	vbroadcastss zmm2,DWORD PTR [rip+0x253e]        # a1e0 <K_VALUES+0x20>
    7ca2:	vmovaps zmm17,zmm2
    7ca8:	vmovaps zmm3,zmm2
    7cae:	vmovaps zmm4,zmm2
    7cb4:	vmovaps zmm5,zmm2
    7cba:	vmovaps zmm6,zmm2
    7cc0:	vmovaps zmm7,zmm2
    7cc6:	vmovaps zmm8,zmm2
    7ccc:	vmovaps zmm9,zmm2
    7cd2:	vmovaps zmm10,zmm2
    7cd8:	vmovaps zmm11,zmm2
    7cde:	vmovaps zmm12,zmm2
    7ce4:	vmovaps zmm13,zmm2
    7cea:	vmovaps zmm14,zmm2
    7cf0:	vmovaps zmm15,zmm2
    7cf6:	vmovaps zmm16,zmm2
    7cfc:	vzeroupper
    7cff:	ret

0000000000007d00 <void fp32_avx512_mul<1>(unsigned long)>:
    7d00:	endbr64
    7d04:	test   rdi,rdi
    7d07:	je     7d64 <void fp32_avx512_mul<1>(unsigned long)+0x64>
    7d09:	vbroadcastss zmm1,DWORD PTR [rip+0x24cd]        # a1e0 <K_VALUES+0x20>
    7d13:	vbroadcastss zmm2,DWORD PTR [rip+0x24d3]        # a1f0 <K_VALUES+0x30>
    7d1d:	xor    eax,eax
    7d1f:	vmovaps zmm0,zmm1
    7d25:	nop    DWORD PTR [rax]
    7d28:	vmulps zmm0,zmm0,zmm1
    7d2e:	vmulps zmm0,zmm0,zmm1
    7d34:	vmulps zmm0,zmm0,zmm1
    7d3a:	vmulps zmm0,zmm0,zmm1
    7d40:	vmulps zmm0,zmm0,zmm1
    7d46:	vmulps zmm0,zmm0,zmm1
    7d4c:	vmulps zmm0,zmm0,zmm1
    7d52:	vmulps zmm0,zmm0,zmm1
    7d58:	inc    rax
    7d5b:	cmp    rdi,rax
    7d5e:	jne    7d28 <void fp32_avx512_mul<1>(unsigned long)+0x28>
    7d60:	vzeroupper
    7d63:	ret
    7d64:	vbroadcastss zmm0,DWORD PTR [rip+0x2472]        # a1e0 <K_VALUES+0x20>
    7d6e:	vzeroupper
    7d71:	ret
    7d72:	data16 cs nop WORD PTR [rax+rax*1+0x0]
    7d7d:	nop    DWORD PTR [rax]

0000000000007d80 <void fp32_avx512_mul<2>(unsigned long)>:
    7d80:	endbr64
    7d84:	test   rdi,rdi
    7d87:	je     7e1c <void fp32_avx512_mul<2>(unsigned long)+0x9c>
    7d8d:	vbroadcastss zmm2,DWORD PTR [rip+0x2449]        # a1e0 <K_VALUES+0x20>
    7d97:	vbroadcastss zmm3,DWORD PTR [rip+0x244f]        # a1f0 <K_VALUES+0x30>
    7da1:	xor    eax,eax
    7da3:	vmovaps zmm0,zmm2
    7da9:	vmovaps zmm1,zmm2
    7daf:	nop
    7db0:	vmulps zmm1,zmm1,zmm2
    7db6:	vmulps zmm0,zmm0,zmm2
    7dbc:	vmulps zmm1,zmm1,zmm2
    7dc2:	vmulps zmm0,zmm0,zmm2
    7dc8:	vmulps zmm1,zmm1,zmm2
    7dce:	vmulps zmm0,zmm0,zmm2
    7dd4:	vmulps zmm1,zmm1,zmm2
    7dda:	vmulps zmm0,zmm0,zmm2
    7de0:	vmulps zmm1,zmm1,zmm2
    7de6:	vmulps zmm0,zmm0,zmm2
    7dec:	vmulps zmm1,zmm1,zmm2
    7df2:	vmulps zmm0,zmm0,zmm2
    7df8:	vmulps zmm1,zmm1,zmm2
    7dfe:	vmulps zmm0,zmm0,zmm2
    7e04:	vmulps zmm1,zmm1,zmm2
    7e0a:	vmulps zmm0,zmm0,zmm2
    7e10:	inc    rax
    7e13:	cmp    rdi,rax
    7e16:	jne    7db0 <void fp32_avx512_mul<2>(unsigned long)+0x30>
    7e18:	vzeroupper
    7e1b:	ret
    7e1c:	vbroadcastss zmm0,DWORD PTR [rip+0x23ba]        # a1e0 <K_VALUES+0x20>
    7e26:	vmovaps zmm1,zmm0
    7e2c:	vzeroupper
    7e2f:	ret

0000000000007e30 <void fp32_avx512_mul<4>(unsigned long)>:
    7e30:	endbr64
    7e34:	test   rdi,rdi
    7e37:	je     7f40 <void fp32_avx512_mul<4>(unsigned long)+0x110>
    7e3d:	vbroadcastss zmm4,DWORD PTR [rip+0x2399]        # a1e0 <K_VALUES+0x20>
    7e47:	vbroadcastss zmm5,DWORD PTR [rip+0x239f]        # a1f0 <K_VALUES+0x30>
    7e51:	xor    eax,eax
    7e53:	vmovaps zmm0,zmm4
    7e59:	vmovaps zmm1,zmm4
    7e5f:	vmovaps zmm2,zmm4
    7e65:	vmovaps zmm3,zmm4
    7e6b:	nop    DWORD PTR [rax+rax*1+0x0]
    7e70:	vmulps zmm3,zmm3,zmm4
    7e76:	vmulps zmm2,zmm2,zmm4
    7e7c:	vmulps zmm1,zmm1,zmm4
    7e82:	vmulps zmm0,zmm0,zmm4
    7e88:	vmulps zmm3,zmm3,zmm4
    7e8e:	vmulps zmm2,zmm2,zmm4
    7e94:	vmulps zmm1,zmm1,zmm4
    7e9a:	vmulps zmm0,zmm0,zmm4
    7ea0:	vmulps zmm3,zmm3,zmm4
    7ea6:	vmulps zmm2,zmm2,zmm4
    7eac:	vmulps zmm1,zmm1,zmm4
    7eb2:	vmulps zmm0,zmm0,zmm4
    7eb8:	vmulps zmm3,zmm3,zmm4
    7ebe:	vmulps zmm2,zmm2,zmm4
    7ec4:	vmulps zmm1,zmm1,zmm4
    7eca:	vmulps zmm0,zmm0,zmm4
    7ed0:	vmulps zmm3,zmm3,zmm4
    7ed6:	vmulps zmm2,zmm2,zmm4
    7edc:	vmulps zmm1,zmm1,zmm4
    7ee2:	vmulps zmm0,zmm0,zmm4
    7ee8:	vmulps zmm3,zmm3,zmm4
    7eee:	vmulps zmm2,zmm2,zmm4
    7ef4:	vmulps zmm1,zmm1,zmm4
    7efa:	vmulps zmm0,zmm0,zmm4
    7f00:	vmulps zmm3,zmm3,zmm4
    7f06:	vmulps zmm2,zmm2,zmm4
    7f0c:	vmulps zmm1,zmm1,zmm4
    7f12:	vmulps zmm0,zmm0,zmm4
    7f18:	vmulps zmm3,zmm3,zmm4
    7f1e:	vmulps zmm2,zmm2,zmm4
    7f24:	vmulps zmm1,zmm1,zmm4
    7f2a:	vmulps zmm0,zmm0,zmm4
    7f30:	inc    rax
    7f33:	cmp    rdi,rax
    7f36:	jne    7e70 <void fp32_avx512_mul<4>(unsigned long)+0x40>
    7f3c:	vzeroupper
    7f3f:	ret
    7f40:	vbroadcastss zmm0,DWORD PTR [rip+0x2296]        # a1e0 <K_VALUES+0x20>
    7f4a:	vmovaps zmm1,zmm0
    7f50:	vmovaps zmm2,zmm0
    7f56:	vmovaps zmm3,zmm0
    7f5c:	vzeroupper
    7f5f:	ret

0000000000007f60 <void fp32_avx512_mul<6>(unsigned long)>:
    7f60:	endbr64
    7f64:	test   rdi,rdi
    7f67:	je     80e0 <void fp32_avx512_mul<6>(unsigned long)+0x180>
    7f6d:	vbroadcastss zmm0,DWORD PTR [rip+0x2269]        # a1e0 <K_VALUES+0x20>
    7f77:	vbroadcastss zmm1,DWORD PTR [rip+0x226f]        # a1f0 <K_VALUES+0x30>
    7f81:	xor    eax,eax
    7f83:	vmovaps zmm2,zmm0
    7f89:	vmovaps zmm3,zmm0
    7f8f:	vmovaps zmm4,zmm0
    7f95:	vmovaps zmm5,zmm0
    7f9b:	vmovaps zmm6,zmm0
    7fa1:	vmovaps zmm7,zmm0
    7fa7:	nop    WORD PTR [rax+rax*1+0x0]
    7fb0:	vmulps zmm7,zmm7,zmm0
    7fb6:	vmulps zmm6,zmm6,zmm0
    7fbc:	vmulps zmm5,zmm5,zmm0
    7fc2:	vmulps zmm4,zmm4,zmm0
    7fc8:	vmulps zmm3,zmm3,zmm0
    7fce:	vmulps zmm2,zmm2,zmm0
    7fd4:	vmulps zmm7,zmm7,zmm0
    7fda:	vmulps zmm6,zmm6,zmm0
    7fe0:	vmulps zmm5,zmm5,zmm0
    7fe6:	vmulps zmm4,zmm4,zmm0
    7fec:	vmulps zmm3,zmm3,zmm0
    7ff2:	vmulps zmm2,zmm2,zmm0
    7ff8:	vmulps zmm7,zmm7,zmm0
    7ffe:	vmulps zmm6,zmm6,zmm0
    8004:	vmulps zmm5,zmm5,zmm0
    800a:	vmulps zmm4,zmm4,zmm0
    8010:	vmulps zmm3,zmm3,zmm0
    8016:	vmulps zmm2,zmm2,zmm0
    801c:	vmulps zmm7,zmm7,zmm0
    8022:	vmulps zmm6,zmm6,zmm0
    8028:	vmulps zmm5,zmm5,zmm0
    802e:	vmulps zmm4,zmm4,zmm0
    8034:	vmulps zmm3,zmm3,zmm0
    803a:	vmulps zmm2,zmm2,zmm0
    8040:	vmulps zmm7,zmm7,zmm0
    8046:	vmulps zmm6,zmm6,zmm0
    804c:	vmulps zmm5,zmm5,zmm0
    8052:	vmulps zmm4,zmm4,zmm0
    8058:	vmulps zmm3,zmm3,zmm0
    805e:	vmulps zmm2,zmm2,zmm0
    8064:	vmulps zmm7,zmm7,zmm0
    806a:	vmulps zmm6,zmm6,zmm0
    8070:	vmulps zmm5,zmm5,zmm0
    8076:	vmulps zmm4,zmm4,zmm0
    807c:	vmulps zmm3,zmm3,zmm0
    8082:	vmulps zmm2,zmm2,zmm0
    8088:	vmulps zmm7,zmm7,zmm0
    808e:	vmulps zmm6,zmm6,zmm0
    8094:	vmulps zmm5,zmm5,zmm0
    809a:	vmulps zmm4,zmm4,zmm0
    80a0:	vmulps zmm3,zmm3,zmm0
    80a6:	vmulps zmm2,zmm2,zmm0
    80ac:	vmulps zmm7,zmm7,zmm0
    80b2:	vmulps zmm6,zmm6,zmm0
    80b8:	vmulps zmm5,zmm5,zmm0
    80be:	vmulps zmm4,zmm4,zmm0
    80c4:	vmulps zmm3,zmm3,zmm0
    80ca:	vmulps zmm2,zmm2,zmm0
    80d0:	inc    rax
    80d3:	cmp    rdi,rax
    80d6:	jne    7fb0 <void fp32_avx512_mul<6>(unsigned long)+0x50>
    80dc:	vzeroupper
    80df:	ret
    80e0:	vbroadcastss zmm2,DWORD PTR [rip+0x20f6]        # a1e0 <K_VALUES+0x20>
    80ea:	vmovaps zmm3,zmm2
    80f0:	vmovaps zmm4,zmm2
    80f6:	vmovaps zmm5,zmm2
    80fc:	vmovaps zmm6,zmm2
    8102:	vmovaps zmm7,zmm2
    8108:	vzeroupper
    810b:	ret
    810c:	nop    DWORD PTR [rax+0x0]

0000000000008110 <void fp32_avx512_mul<8>(unsigned long)>:
    8110:	endbr64
    8114:	test   rdi,rdi
    8117:	je     82f8 <void fp32_avx512_mul<8>(unsigned long)+0x1e8>
    811d:	vbroadcastss zmm0,DWORD PTR [rip+0x20b9]        # a1e0 <K_VALUES+0x20>
    8127:	vbroadcastss zmm1,DWORD PTR [rip+0x20bf]        # a1f0 <K_VALUES+0x30>
    8131:	xor    eax,eax
    8133:	vmovaps zmm2,zmm0
    8139:	vmovaps zmm3,zmm0
    813f:	vmovaps zmm4,zmm0
    8145:	vmovaps zmm5,zmm0
    814b:	vmovaps zmm6,zmm0
    8151:	vmovaps zmm7,zmm0
    8157:	vmovaps zmm8,zmm0
    815d:	vmovaps zmm9,zmm0
    8163:	nop    DWORD PTR [rax+rax*1+0x0]
    8168:	vmulps zmm9,zmm9,zmm0
    816e:	vmulps zmm8,zmm8,zmm0
    8174:	vmulps zmm7,zmm7,zmm0
    817a:	vmulps zmm6,zmm6,zmm0
    8180:	vmulps zmm5,zmm5,zmm0
    8186:	vmulps zmm4,zmm4,zmm0
    818c:	vmulps zmm3,zmm3,zmm0
    8192:	vmulps zmm2,zmm2,zmm0
    8198:	vmulps zmm9,zmm9,zmm0
    819e:	vmulps zmm8,zmm8,zmm0
    81a4:	vmulps zmm7,zmm7,zmm0
    81aa:	vmulps zmm6,zmm6,zmm0
    81b0:	vmulps zmm5,zmm5,zmm0
    81b6:	vmulps zmm4,zmm4,zmm0
    81bc:	vmulps zmm3,zmm3,zmm0
    81c2:	vmulps zmm2,zmm2,zmm0
    81c8:	vmulps zmm9,zmm9,zmm0
    81ce:	vmulps zmm8,zmm8,zmm0
    81d4:	vmulps zmm7,zmm7,zmm0
    81da:	vmulps zmm6,zmm6,zmm0
    81e0:	vmulps zmm5,zmm5,zmm0
    81e6:	vmulps zmm4,zmm4,zmm0
    81ec:	vmulps zmm3,zmm3,zmm0
    81f2:	vmulps zmm2,zmm2,zmm0
    81f8:	vmulps zmm9,zmm9,zmm0
    81fe:	vmulps zmm8,zmm8,zmm0
    8204:	vmulps zmm7,zmm7,zmm0
    820a:	vmulps zmm6,zmm6,zmm0
    8210:	vmulps zmm5,zmm5,zmm0
    8216:	vmulps zmm4,zmm4,zmm0
    821c:	vmulps zmm3,zmm3,zmm0
    8222:	vmulps zmm2,zmm2,zmm0
    8228:	vmulps zmm9,zmm9,zmm0
    822e:	vmulps zmm8,zmm8,zmm0
    8234:	vmulps zmm7,zmm7,zmm0
    823a:	vmulps zmm6,zmm6,zmm0
    8240:	vmulps zmm5,zmm5,zmm0
    8246:	vmulps zmm4,zmm4,zmm0
    824c:	vmulps zmm3,zmm3,zmm0
    8252:	vmulps zmm2,zmm2,zmm0
    8258:	vmulps zmm9,zmm9,zmm0
    825e:	vmulps zmm8,zmm8,zmm0
    8264:	vmulps zmm7,zmm7,zmm0
    826a:	vmulps zmm6,zmm6,zmm0
    8270:	vmulps zmm5,zmm5,zmm0
    8276:	vmulps zmm4,zmm4,zmm0
    827c:	vmulps zmm3,zmm3,zmm0
    8282:	vmulps zmm2,zmm2,zmm0
    8288:	vmulps zmm9,zmm9,zmm0
    828e:	vmulps zmm8,zmm8,zmm0
    8294:	vmulps zmm7,zmm7,zmm0
    829a:	vmulps zmm6,zmm6,zmm0
    82a0:	vmulps zmm5,zmm5,zmm0
    82a6:	vmulps zmm4,zmm4,zmm0
    82ac:	vmulps zmm3,zmm3,zmm0
    82b2:	vmulps zmm2,zmm2,zmm0
    82b8:	vmulps zmm9,zmm9,zmm0
    82be:	vmulps zmm8,zmm8,zmm0
    82c4:	vmulps zmm7,zmm7,zmm0
    82ca:	vmulps zmm6,zmm6,zmm0
    82d0:	vmulps zmm5,zmm5,zmm0
    82d6:	vmulps zmm4,zmm4,zmm0
    82dc:	vmulps zmm3,zmm3,zmm0
    82e2:	vmulps zmm2,zmm2,zmm0
    82e8:	inc    rax
    82eb:	cmp    rdi,rax
    82ee:	jne    8168 <void fp32_avx512_mul<8>(unsigned long)+0x58>
    82f4:	vzeroupper
    82f7:	ret
    82f8:	vbroadcastss zmm2,DWORD PTR [rip+0x1ede]        # a1e0 <K_VALUES+0x20>
    8302:	vmovaps zmm3,zmm2
    8308:	vmovaps zmm4,zmm2
    830e:	vmovaps zmm5,zmm2
    8314:	vmovaps zmm6,zmm2
    831a:	vmovaps zmm7,zmm2
    8320:	vmovaps zmm8,zmm2
    8326:	vmovaps zmm9,zmm2
    832c:	vzeroupper
    832f:	ret

0000000000008330 <void fp32_avx512_mul<10>(unsigned long)>:
    8330:	endbr64
    8334:	test   rdi,rdi
    8337:	je     8580 <void fp32_avx512_mul<10>(unsigned long)+0x250>
    833d:	vbroadcastss zmm0,DWORD PTR [rip+0x1e99]        # a1e0 <K_VALUES+0x20>
    8347:	vbroadcastss zmm1,DWORD PTR [rip+0x1e9f]        # a1f0 <K_VALUES+0x30>
    8351:	xor    eax,eax
    8353:	vmovaps zmm2,zmm0
    8359:	vmovaps zmm3,zmm0
    835f:	vmovaps zmm4,zmm0
    8365:	vmovaps zmm5,zmm0
    836b:	vmovaps zmm6,zmm0
    8371:	vmovaps zmm7,zmm0
    8377:	vmovaps zmm8,zmm0
    837d:	vmovaps zmm9,zmm0
    8383:	vmovaps zmm10,zmm0
    8389:	vmovaps zmm11,zmm0
    838f:	nop
    8390:	vmulps zmm11,zmm11,zmm0
    8396:	vmulps zmm10,zmm10,zmm0
    839c:	vmulps zmm9,zmm9,zmm0
    83a2:	vmulps zmm8,zmm8,zmm0
    83a8:	vmulps zmm7,zmm7,zmm0
    83ae:	vmulps zmm6,zmm6,zmm0
    83b4:	vmulps zmm5,zmm5,zmm0
    83ba:	vmulps zmm4,zmm4,zmm0
    83c0:	vmulps zmm3,zmm3,zmm0
    83c6:	vmulps zmm2,zmm2,zmm0
    83cc:	vmulps zmm11,zmm11,zmm0
    83d2:	vmulps zmm10,zmm10,zmm0
    83d8:	vmulps zmm9,zmm9,zmm0
    83de:	vmulps zmm8,zmm8,zmm0
    83e4:	vmulps zmm7,zmm7,zmm0
    83ea:	vmulps zmm6,zmm6,zmm0
    83f0:	vmulps zmm5,zmm5,zmm0
    83f6:	vmulps zmm4,zmm4,zmm0
    83fc:	vmulps zmm3,zmm3,zmm0
    8402:	vmulps zmm2,zmm2,zmm0
    8408:	vmulps zmm11,zmm11,zmm0
    840e:	vmulps zmm10,zmm10,zmm0
    8414:	vmulps zmm9,zmm9,zmm0
    841a:	vmulps zmm8,zmm8,zmm0
    8420:	vmulps zmm7,zmm7,zmm0
    8426:	vmulps zmm6,zmm6,zmm0
    842c:	vmulps zmm5,zmm5,zmm0
    8432:	vmulps zmm4,zmm4,zmm0
    8438:	vmulps zmm3,zmm3,zmm0
    843e:	vmulps zmm2,zmm2,zmm0
    8444:	vmulps zmm11,zmm11,zmm0
    844a:	vmulps zmm10,zmm10,zmm0
    8450:	vmulps zmm9,zmm9,zmm0
    8456:	vmulps zmm8,zmm8,zmm0
    845c:	vmulps zmm7,zmm7,zmm0
    8462:	vmulps zmm6,zmm6,zmm0
    8468:	vmulps zmm5,zmm5,zmm0
    846e:	vmulps zmm4,zmm4,zmm0
    8474:	vmulps zmm3,zmm3,zmm0
    847a:	vmulps zmm2,zmm2,zmm0
    8480:	vmulps zmm11,zmm11,zmm0
    8486:	vmulps zmm10,zmm10,zmm0
    848c:	vmulps zmm9,zmm9,zmm0
    8492:	vmulps zmm8,zmm8,zmm0
    8498:	vmulps zmm7,zmm7,zmm0
    849e:	vmulps zmm6,zmm6,zmm0
    84a4:	vmulps zmm5,zmm5,zmm0
    84aa:	vmulps zmm4,zmm4,zmm0
    84b0:	vmulps zmm3,zmm3,zmm0
    84b6:	vmulps zmm2,zmm2,zmm0
    84bc:	vmulps zmm11,zmm11,zmm0
    84c2:	vmulps zmm10,zmm10,zmm0
    84c8:	vmulps zmm9,zmm9,zmm0
    84ce:	vmulps zmm8,zmm8,zmm0
    84d4:	vmulps zmm7,zmm7,zmm0
    84da:	vmulps zmm6,zmm6,zmm0
    84e0:	vmulps zmm5,zmm5,zmm0
    84e6:	vmulps zmm4,zmm4,zmm0
    84ec:	vmulps zmm3,zmm3,zmm0
    84f2:	vmulps zmm2,zmm2,zmm0
    84f8:	vmulps zmm11,zmm11,zmm0
    84fe:	vmulps zmm10,zmm10,zmm0
    8504:	vmulps zmm9,zmm9,zmm0
    850a:	vmulps zmm8,zmm8,zmm0
    8510:	vmulps zmm7,zmm7,zmm0
    8516:	vmulps zmm6,zmm6,zmm0
    851c:	vmulps zmm5,zmm5,zmm0
    8522:	vmulps zmm4,zmm4,zmm0
    8528:	vmulps zmm3,zmm3,zmm0
    852e:	vmulps zmm2,zmm2,zmm0
    8534:	vmulps zmm11,zmm11,zmm0
    853a:	vmulps zmm10,zmm10,zmm0
    8540:	vmulps zmm9,zmm9,zmm0
    8546:	vmulps zmm8,zmm8,zmm0
    854c:	vmulps zmm7,zmm7,zmm0
    8552:	vmulps zmm6,zmm6,zmm0
    8558:	vmulps zmm5,zmm5,zmm0
    855e:	vmulps zmm4,zmm4,zmm0
    8564:	vmulps zmm3,zmm3,zmm0
    856a:	vmulps zmm2,zmm2,zmm0
    8570:	inc    rax
    8573:	cmp    rdi,rax
    8576:	jne    8390 <void fp32_avx512_mul<10>(unsigned long)+0x60>
    857c:	vzeroupper
    857f:	ret
    8580:	vbroadcastss zmm2,DWORD PTR [rip+0x1c56]        # a1e0 <K_VALUES+0x20>
    858a:	vmovaps zmm3,zmm2
    8590:	vmovaps zmm4,zmm2
    8596:	vmovaps zmm5,zmm2
    859c:	vmovaps zmm6,zmm2
    85a2:	vmovaps zmm7,zmm2
    85a8:	vmovaps zmm8,zmm2
    85ae:	vmovaps zmm9,zmm2
    85b4:	vmovaps zmm10,zmm2
    85ba:	vmovaps zmm11,zmm2
    85c0:	vzeroupper
    85c3:	ret
    85c4:	data16 cs nop WORD PTR [rax+rax*1+0x0]
    85cf:	nop

00000000000085d0 <void fp32_avx512_mul<12>(unsigned long)>:
    85d0:	endbr64
    85d4:	test   rdi,rdi
    85d7:	je     8890 <void fp32_avx512_mul<12>(unsigned long)+0x2c0>
    85dd:	vbroadcastss zmm0,DWORD PTR [rip+0x1bf9]        # a1e0 <K_VALUES+0x20>
    85e7:	vbroadcastss zmm1,DWORD PTR [rip+0x1bff]        # a1f0 <K_VALUES+0x30>
    85f1:	xor    eax,eax
    85f3:	vmovaps zmm10,zmm0
    85f9:	vmovaps zmm11,zmm0
    85ff:	vmovaps zmm12,zmm0
    8605:	vmovaps zmm13,zmm0
    860b:	vmovaps zmm2,zmm0
    8611:	vmovaps zmm3,zmm0
    8617:	vmovaps zmm4,zmm0
    861d:	vmovaps zmm5,zmm0
    8623:	vmovaps zmm6,zmm0
    8629:	vmovaps zmm7,zmm0
    862f:	vmovaps zmm8,zmm0
    8635:	vmovaps zmm9,zmm0
    863b:	nop    DWORD PTR [rax+rax*1+0x0]
    8640:	vmulps zmm9,zmm9,zmm0
    8646:	vmulps zmm8,zmm8,zmm0
    864c:	vmulps zmm7,zmm7,zmm0
    8652:	vmulps zmm6,zmm6,zmm0
    8658:	vmulps zmm5,zmm5,zmm0
    865e:	vmulps zmm4,zmm4,zmm0
    8664:	vmulps zmm3,zmm3,zmm0
    866a:	vmulps zmm2,zmm2,zmm0
    8670:	vmulps zmm13,zmm13,zmm0
    8676:	vmulps zmm12,zmm12,zmm0
    867c:	vmulps zmm11,zmm11,zmm0
    8682:	vmulps zmm10,zmm10,zmm0
    8688:	vmulps zmm9,zmm9,zmm0
    868e:	vmulps zmm8,zmm8,zmm0
    8694:	vmulps zmm7,zmm7,zmm0
    869a:	vmulps zmm6,zmm6,zmm0
    86a0:	vmulps zmm5,zmm5,zmm0
    86a6:	vmulps zmm4,zmm4,zmm0
    86ac:	vmulps zmm3,zmm3,zmm0
    86b2:	vmulps zmm2,zmm2,zmm0
    86b8:	vmulps zmm13,zmm13,zmm0
    86be:	vmulps zmm12,zmm12,zmm0
    86c4:	vmulps zmm11,zmm11,zmm0
    86ca:	vmulps zmm10,zmm10,zmm0
    86d0:	vmulps zmm9,zmm9,zmm0
    86d6:	vmulps zmm8,zmm8,zmm0
    86dc:	vmulps zmm7,zmm7,zmm0
    86e2:	vmulps zmm6,zmm6,zmm0
    86e8:	vmulps zmm5,zmm5,zmm0
    86ee:	vmulps zmm4,zmm4,zmm0
    86f4:	vmulps zmm3,zmm3,zmm0
    86fa:	vmulps zmm2,zmm2,zmm0
    8700:	vmulps zmm13,zmm13,zmm0
    8706:	vmulps zmm12,zmm12,zmm0
    870c:	vmulps zmm11,zmm11,zmm0
    8712:	vmulps zmm10,zmm10,zmm0
    8718:	vmulps zmm9,zmm9,zmm0
    871e:	vmulps zmm8,zmm8,zmm0
    8724:	vmulps zmm7,zmm7,zmm0
    872a:	vmulps zmm6,zmm6,zmm0
    8730:	vmulps zmm5,zmm5,zmm0
    8736:	vmulps zmm4,zmm4,zmm0
    873c:	vmulps zmm3,zmm3,zmm0
    8742:	vmulps zmm2,zmm2,zmm0
    8748:	vmulps zmm13,zmm13,zmm0
    874e:	vmulps zmm12,zmm12,zmm0
    8754:	vmulps zmm11,zmm11,zmm0
    875a:	vmulps zmm10,zmm10,zmm0
    8760:	vmulps zmm9,zmm9,zmm0
    8766:	vmulps zmm8,zmm8,zmm0
    876c:	vmulps zmm7,zmm7,zmm0
    8772:	vmulps zmm6,zmm6,zmm0
    8778:	vmulps zmm5,zmm5,zmm0
    877e:	vmulps zmm4,zmm4,zmm0
    8784:	vmulps zmm3,zmm3,zmm0
    878a:	vmulps zmm2,zmm2,zmm0
    8790:	vmulps zmm13,zmm13,zmm0
    8796:	vmulps zmm12,zmm12,zmm0
    879c:	vmulps zmm11,zmm11,zmm0
    87a2:	vmulps zmm10,zmm10,zmm0
    87a8:	vmulps zmm9,zmm9,zmm0
    87ae:	vmulps zmm8,zmm8,zmm0
    87b4:	vmulps zmm7,zmm7,zmm0
    87ba:	vmulps zmm6,zmm6,zmm0
    87c0:	vmulps zmm5,zmm5,zmm0
    87c6:	vmulps zmm4,zmm4,zmm0
    87cc:	vmulps zmm3,zmm3,zmm0
    87d2:	vmulps zmm2,zmm2,zmm0
    87d8:	vmulps zmm13,zmm13,zmm0
    87de:	vmulps zmm12,zmm12,zmm0
    87e4:	vmulps zmm11,zmm11,zmm0
    87ea:	vmulps zmm10,zmm10,zmm0
    87f0:	vmulps zmm9,zmm9,zmm0
    87f6:	vmulps zmm8,zmm8,zmm0
    87fc:	vmulps zmm7,zmm7,zmm0
    8802:	vmulps zmm6,zmm6,zmm0
    8808:	vmulps zmm5,zmm5,zmm0
    880e:	vmulps zmm4,zmm4,zmm0
    8814:	vmulps zmm3,zmm3,zmm0
    881a:	vmulps zmm2,zmm2,zmm0
    8820:	vmulps zmm13,zmm13,zmm0
    8826:	vmulps zmm12,zmm12,zmm0
    882c:	vmulps zmm11,zmm11,zmm0
    8832:	vmulps zmm10,zmm10,zmm0
    8838:	vmulps zmm9,zmm9,zmm0
    883e:	vmulps zmm8,zmm8,zmm0
    8844:	vmulps zmm7,zmm7,zmm0
    884a:	vmulps zmm6,zmm6,zmm0
    8850:	vmulps zmm5,zmm5,zmm0
    8856:	vmulps zmm4,zmm4,zmm0
    885c:	vmulps zmm3,zmm3,zmm0
    8862:	vmulps zmm2,zmm2,zmm0
    8868:	vmulps zmm13,zmm13,zmm0
    886e:	vmulps zmm12,zmm12,zmm0
    8874:	vmulps zmm11,zmm11,zmm0
    887a:	vmulps zmm10,zmm10,zmm0
    8880:	inc    rax
    8883:	cmp    rdi,rax
    8886:	jne    8640 <void fp32_avx512_mul<12>(unsigned long)+0x70>
    888c:	vzeroupper
    888f:	ret
    8890:	vbroadcastss zmm10,DWORD PTR [rip+0x1946]        # a1e0 <K_VALUES+0x20>
    889a:	vmovaps zmm11,zmm10
    88a0:	vmovaps zmm12,zmm10
    88a6:	vmovaps zmm13,zmm10
    88ac:	vmovaps zmm2,zmm10
    88b2:	vmovaps zmm3,zmm10
    88b8:	vmovaps zmm4,zmm10
    88be:	vmovaps zmm5,zmm10
    88c4:	vmovaps zmm6,zmm10
    88ca:	vmovaps zmm7,zmm10
    88d0:	vmovaps zmm8,zmm10
    88d6:	vmovaps zmm9,zmm10
    88dc:	vzeroupper
    88df:	ret

00000000000088e0 <void fp32_avx512_mul<16>(unsigned long)>:
    88e0:	endbr64
    88e4:	test   rdi,rdi
    88e7:	je     8c78 <void fp32_avx512_mul<16>(unsigned long)+0x398>
    88ed:	vbroadcastss zmm0,DWORD PTR [rip+0x18e9]        # a1e0 <K_VALUES+0x20>
    88f7:	vbroadcastss zmm1,DWORD PTR [rip+0x18ef]        # a1f0 <K_VALUES+0x30>
    8901:	xor    eax,eax
    8903:	vmovaps zmm2,zmm0
    8909:	vmovaps zmm17,zmm0
    890f:	vmovaps zmm3,zmm0
    8915:	vmovaps zmm4,zmm0
    891b:	vmovaps zmm5,zmm0
    8921:	vmovaps zmm6,zmm0
    8927:	vmovaps zmm7,zmm0
    892d:	vmovaps zmm8,zmm0
    8933:	vmovaps zmm9,zmm0
    8939:	vmovaps zmm10,zmm0
    893f:	vmovaps zmm11,zmm0
    8945:	vmovaps zmm12,zmm0
    894b:	vmovaps zmm13,zmm0
    8951:	vmovaps zmm14,zmm0
    8957:	vmovaps zmm15,zmm0
    895d:	vmovaps zmm16,zmm0
    8963:	nop    DWORD PTR [rax+rax*1+0x0]
    8968:	vmulps zmm16,zmm16,zmm0
    896e:	vmulps zmm15,zmm15,zmm0
    8974:	vmulps zmm14,zmm14,zmm0
    897a:	vmulps zmm13,zmm13,zmm0
    8980:	vmulps zmm12,zmm12,zmm0
    8986:	vmulps zmm11,zmm11,zmm0
    898c:	vmulps zmm10,zmm10,zmm0
    8992:	vmulps zmm9,zmm9,zmm0
    8998:	vmulps zmm8,zmm8,zmm0
    899e:	vmulps zmm7,zmm7,zmm0
    89a4:	vmulps zmm6,zmm6,zmm0
    89aa:	vmulps zmm5,zmm5,zmm0
    89b0:	vmulps zmm4,zmm4,zmm0
    89b6:	vmulps zmm3,zmm3,zmm0
    89bc:	vmulps zmm17,zmm17,zmm0
    89c2:	vmulps zmm2,zmm2,zmm0
    89c8:	vmulps zmm16,zmm16,zmm0
    89ce:	vmulps zmm15,zmm15,zmm0
    89d4:	vmulps zmm14,zmm14,zmm0
    89da:	vmulps zmm13,zmm13,zmm0
    89e0:	vmulps zmm12,zmm12,zmm0
    89e6:	vmulps zmm11,zmm11,zmm0
    89ec:	vmulps zmm10,zmm10,zmm0
    89f2:	vmulps zmm9,zmm9,zmm0
    89f8:	vmulps zmm8,zmm8,zmm0
    89fe:	vmulps zmm7,zmm7,zmm0
    8a04:	vmulps zmm6,zmm6,zmm0
    8a0a:	vmulps zmm5,zmm5,zmm0
    8a10:	vmulps zmm4,zmm4,zmm0
    8a16:	vmulps zmm3,zmm3,zmm0
    8a1c:	vmulps zmm17,zmm17,zmm0
    8a22:	vmulps zmm2,zmm2,zmm0
    8a28:	vmulps zmm16,zmm16,zmm0
    8a2e:	vmulps zmm15,zmm15,zmm0
    8a34:	vmulps zmm14,zmm14,zmm0
    8a3a:	vmulps zmm13,zmm13,zmm0
    8a40:	vmulps zmm12,zmm12,zmm0
    8a46:	vmulps zmm11,zmm11,zmm0
    8a4c:	vmulps zmm10,zmm10,zmm0
    8a52:	vmulps zmm9,zmm9,zmm0
    8a58:	vmulps zmm8,zmm8,zmm0
    8a5e:	vmulps zmm7,zmm7,zmm0
    8a64:	vmulps zmm6,zmm6,zmm0
    8a6a:	vmulps zmm5,zmm5,zmm0
    8a70:	vmulps zmm4,zmm4,zmm0
    8a76:	vmulps zmm3,zmm3,zmm0
    8a7c:	vmulps zmm17,zmm17,zmm0
    8a82:	vmulps zmm2,zmm2,zmm0
    8a88:	vmulps zmm16,zmm16,zmm0
    8a8e:	vmulps zmm15,zmm15,zmm0
    8a94:	vmulps zmm14,zmm14,zmm0
    8a9a:	vmulps zmm13,zmm13,zmm0
    8aa0:	vmulps zmm12,zmm12,zmm0
    8aa6:	vmulps zmm11,zmm11,zmm0
    8aac:	vmulps zmm10,zmm10,zmm0
    8ab2:	vmulps zmm9,zmm9,zmm0
    8ab8:	vmulps zmm8,zmm8,zmm0
    8abe:	vmulps zmm7,zmm7,zmm0
    8ac4:	vmulps zmm6,zmm6,zmm0
    8aca:	vmulps zmm5,zmm5,zmm0
    8ad0:	vmulps zmm4,zmm4,zmm0
    8ad6:	vmulps zmm3,zmm3,zmm0
    8adc:	vmulps zmm17,zmm17,zmm0
    8ae2:	vmulps zmm2,zmm2,zmm0
    8ae8:	vmulps zmm16,zmm16,zmm0
    8aee:	vmulps zmm15,zmm15,zmm0
    8af4:	vmulps zmm14,zmm14,zmm0
    8afa:	vmulps zmm13,zmm13,zmm0
    8b00:	vmulps zmm12,zmm12,zmm0
    8b06:	vmulps zmm11,zmm11,zmm0
    8b0c:	vmulps zmm10,zmm10,zmm0
    8b12:	vmulps zmm9,zmm9,zmm0
    8b18:	vmulps zmm8,zmm8,zmm0
    8b1e:	vmulps zmm7,zmm7,zmm0
    8b24:	vmulps zmm6,zmm6,zmm0
    8b2a:	vmulps zmm5,zmm5,zmm0
    8b30:	vmulps zmm4,zmm4,zmm0
    8b36:	vmulps zmm3,zmm3,zmm0
    8b3c:	vmulps zmm17,zmm17,zmm0
    8b42:	vmulps zmm2,zmm2,zmm0
    8b48:	vmulps zmm16,zmm16,zmm0
    8b4e:	vmulps zmm15,zmm15,zmm0
    8b54:	vmulps zmm14,zmm14,zmm0
    8b5a:	vmulps zmm13,zmm13,zmm0
    8b60:	vmulps zmm12,zmm12,zmm0
    8b66:	vmulps zmm11,zmm11,zmm0
    8b6c:	vmulps zmm10,zmm10,zmm0
    8b72:	vmulps zmm9,zmm9,zmm0
    8b78:	vmulps zmm8,zmm8,zmm0
    8b7e:	vmulps zmm7,zmm7,zmm0
    8b84:	vmulps zmm6,zmm6,zmm0
    8b8a:	vmulps zmm5,zmm5,zmm0
    8b90:	vmulps zmm4,zmm4,zmm0
    8b96:	vmulps zmm3,zmm3,zmm0
    8b9c:	vmulps zmm17,zmm17,zmm0
    8ba2:	vmulps zmm2,zmm2,zmm0
    8ba8:	vmulps zmm16,zmm16,zmm0
    8bae:	vmulps zmm15,zmm15,zmm0
    8bb4:	vmulps zmm14,zmm14,zmm0
    8bba:	vmulps zmm13,zmm13,zmm0
    8bc0:	vmulps zmm12,zmm12,zmm0
    8bc6:	vmulps zmm11,zmm11,zmm0
    8bcc:	vmulps zmm10,zmm10,zmm0
    8bd2:	vmulps zmm9,zmm9,zmm0
    8bd8:	vmulps zmm8,zmm8,zmm0
    8bde:	vmulps zmm7,zmm7,zmm0
    8be4:	vmulps zmm6,zmm6,zmm0
    8bea:	vmulps zmm5,zmm5,zmm0
    8bf0:	vmulps zmm4,zmm4,zmm0
    8bf6:	vmulps zmm3,zmm3,zmm0
    8bfc:	vmulps zmm17,zmm17,zmm0
    8c02:	vmulps zmm2,zmm2,zmm0
    8c08:	vmulps zmm16,zmm16,zmm0
    8c0e:	vmulps zmm15,zmm15,zmm0
    8c14:	vmulps zmm14,zmm14,zmm0
    8c1a:	vmulps zmm13,zmm13,zmm0
    8c20:	vmulps zmm12,zmm12,zmm0
    8c26:	vmulps zmm11,zmm11,zmm0
    8c2c:	vmulps zmm10,zmm10,zmm0
    8c32:	vmulps zmm9,zmm9,zmm0
    8c38:	vmulps zmm8,zmm8,zmm0
    8c3e:	vmulps zmm7,zmm7,zmm0
    8c44:	vmulps zmm6,zmm6,zmm0
    8c4a:	vmulps zmm5,zmm5,zmm0
    8c50:	vmulps zmm4,zmm4,zmm0
    8c56:	vmulps zmm3,zmm3,zmm0
    8c5c:	vmulps zmm17,zmm17,zmm0
    8c62:	vmulps zmm2,zmm2,zmm0
    8c68:	inc    rax
    8c6b:	cmp    rdi,rax
    8c6e:	jne    8968 <void fp32_avx512_mul<16>(unsigned long)+0x88>
    8c74:	vzeroupper
    8c77:	ret
    8c78:	vbroadcastss zmm2,DWORD PTR [rip+0x155e]        # a1e0 <K_VALUES+0x20>
    8c82:	vmovaps zmm17,zmm2
    8c88:	vmovaps zmm3,zmm2
    8c8e:	vmovaps zmm4,zmm2
    8c94:	vmovaps zmm5,zmm2
    8c9a:	vmovaps zmm6,zmm2
    8ca0:	vmovaps zmm7,zmm2
    8ca6:	vmovaps zmm8,zmm2
    8cac:	vmovaps zmm9,zmm2
    8cb2:	vmovaps zmm10,zmm2
    8cb8:	vmovaps zmm11,zmm2
    8cbe:	vmovaps zmm12,zmm2
    8cc4:	vmovaps zmm13,zmm2
    8cca:	vmovaps zmm14,zmm2
    8cd0:	vmovaps zmm15,zmm2
    8cd6:	vmovaps zmm16,zmm2
    8cdc:	vzeroupper
    8cdf:	ret

0000000000008ce0 <void fp32_avx512_fma<1>(unsigned long)>:
    8ce0:	endbr64
    8ce4:	test   rdi,rdi
    8ce7:	je     8d44 <void fp32_avx512_fma<1>(unsigned long)+0x64>
    8ce9:	vbroadcastss zmm1,DWORD PTR [rip+0x14ed]        # a1e0 <K_VALUES+0x20>
    8cf3:	vbroadcastss zmm2,DWORD PTR [rip+0x14f3]        # a1f0 <K_VALUES+0x30>
    8cfd:	xor    eax,eax
    8cff:	vmovaps zmm0,zmm1
    8d05:	nop    DWORD PTR [rax]
    8d08:	vfmadd231ps zmm0,zmm2,zmm1
    8d0e:	vfmadd231ps zmm0,zmm2,zmm1
    8d14:	vfmadd231ps zmm0,zmm2,zmm1
    8d1a:	vfmadd231ps zmm0,zmm2,zmm1
    8d20:	vfmadd231ps zmm0,zmm2,zmm1
    8d26:	vfmadd231ps zmm0,zmm2,zmm1
    8d2c:	vfmadd231ps zmm0,zmm2,zmm1
    8d32:	vfmadd231ps zmm0,zmm2,zmm1
    8d38:	inc    rax
    8d3b:	cmp    rdi,rax
    8d3e:	jne    8d08 <void fp32_avx512_fma<1>(unsigned long)+0x28>
    8d40:	vzeroupper
    8d43:	ret
    8d44:	vbroadcastss zmm0,DWORD PTR [rip+0x1492]        # a1e0 <K_VALUES+0x20>
    8d4e:	vzeroupper
    8d51:	ret
    8d52:	data16 cs nop WORD PTR [rax+rax*1+0x0]
    8d5d:	nop    DWORD PTR [rax]

0000000000008d60 <void fp32_avx512_fma<2>(unsigned long)>:
    8d60:	endbr64
    8d64:	test   rdi,rdi
    8d67:	je     8dfc <void fp32_avx512_fma<2>(unsigned long)+0x9c>
    8d6d:	vbroadcastss zmm2,DWORD PTR [rip+0x1469]        # a1e0 <K_VALUES+0x20>
    8d77:	vbroadcastss zmm3,DWORD PTR [rip+0x146f]        # a1f0 <K_VALUES+0x30>
    8d81:	xor    eax,eax
    8d83:	vmovaps zmm0,zmm2
    8d89:	vmovaps zmm1,zmm2
    8d8f:	nop
    8d90:	vfmadd231ps zmm1,zmm3,zmm2
    8d96:	vfmadd231ps zmm0,zmm3,zmm2
    8d9c:	vfmadd231ps zmm1,zmm3,zmm2
    8da2:	vfmadd231ps zmm0,zmm3,zmm2
    8da8:	vfmadd231ps zmm1,zmm3,zmm2
    8dae:	vfmadd231ps zmm0,zmm3,zmm2
    8db4:	vfmadd231ps zmm1,zmm3,zmm2
    8dba:	vfmadd231ps zmm0,zmm3,zmm2
    8dc0:	vfmadd231ps zmm1,zmm3,zmm2
    8dc6:	vfmadd231ps zmm0,zmm3,zmm2
    8dcc:	vfmadd231ps zmm1,zmm3,zmm2
    8dd2:	vfmadd231ps zmm0,zmm3,zmm2
    8dd8:	vfmadd231ps zmm1,zmm3,zmm2
    8dde:	vfmadd231ps zmm0,zmm3,zmm2
    8de4:	vfmadd231ps zmm1,zmm3,zmm2
    8dea:	vfmadd231ps zmm0,zmm3,zmm2
    8df0:	inc    rax
    8df3:	cmp    rdi,rax
    8df6:	jne    8d90 <void fp32_avx512_fma<2>(unsigned long)+0x30>
    8df8:	vzeroupper
    8dfb:	ret
    8dfc:	vbroadcastss zmm0,DWORD PTR [rip+0x13da]        # a1e0 <K_VALUES+0x20>
    8e06:	vmovaps zmm1,zmm0
    8e0c:	vzeroupper
    8e0f:	ret

0000000000008e10 <void fp32_avx512_fma<4>(unsigned long)>:
    8e10:	endbr64
    8e14:	test   rdi,rdi
    8e17:	je     8f20 <void fp32_avx512_fma<4>(unsigned long)+0x110>
    8e1d:	vbroadcastss zmm4,DWORD PTR [rip+0x13b9]        # a1e0 <K_VALUES+0x20>
    8e27:	vbroadcastss zmm5,DWORD PTR [rip+0x13bf]        # a1f0 <K_VALUES+0x30>
    8e31:	xor    eax,eax
    8e33:	vmovaps zmm0,zmm4
    8e39:	vmovaps zmm1,zmm4
    8e3f:	vmovaps zmm2,zmm4
    8e45:	vmovaps zmm3,zmm4
    8e4b:	nop    DWORD PTR [rax+rax*1+0x0]
    8e50:	vfmadd231ps zmm3,zmm5,zmm4
    8e56:	vfmadd231ps zmm2,zmm5,zmm4
    8e5c:	vfmadd231ps zmm1,zmm5,zmm4
    8e62:	vfmadd231ps zmm0,zmm5,zmm4
    8e68:	vfmadd231ps zmm3,zmm5,zmm4
    8e6e:	vfmadd231ps zmm2,zmm5,zmm4
    8e74:	vfmadd231ps zmm1,zmm5,zmm4
    8e7a:	vfmadd231ps zmm0,zmm5,zmm4
    8e80:	vfmadd231ps zmm3,zmm5,zmm4
    8e86:	vfmadd231ps zmm2,zmm5,zmm4
    8e8c:	vfmadd231ps zmm1,zmm5,zmm4
    8e92:	vfmadd231ps zmm0,zmm5,zmm4
    8e98:	vfmadd231ps zmm3,zmm5,zmm4
    8e9e:	vfmadd231ps zmm2,zmm5,zmm4
    8ea4:	vfmadd231ps zmm1,zmm5,zmm4
    8eaa:	vfmadd231ps zmm0,zmm5,zmm4
    8eb0:	vfmadd231ps zmm3,zmm5,zmm4
    8eb6:	vfmadd231ps zmm2,zmm5,zmm4
    8ebc:	vfmadd231ps zmm1,zmm5,zmm4
    8ec2:	vfmadd231ps zmm0,zmm5,zmm4
    8ec8:	vfmadd231ps zmm3,zmm5,zmm4
    8ece:	vfmadd231ps zmm2,zmm5,zmm4
    8ed4:	vfmadd231ps zmm1,zmm5,zmm4
    8eda:	vfmadd231ps zmm0,zmm5,zmm4
    8ee0:	vfmadd231ps zmm3,zmm5,zmm4
    8ee6:	vfmadd231ps zmm2,zmm5,zmm4
    8eec:	vfmadd231ps zmm1,zmm5,zmm4
    8ef2:	vfmadd231ps zmm0,zmm5,zmm4
    8ef8:	vfmadd231ps zmm3,zmm5,zmm4
    8efe:	vfmadd231ps zmm2,zmm5,zmm4
    8f04:	vfmadd231ps zmm1,zmm5,zmm4
    8f0a:	vfmadd231ps zmm0,zmm5,zmm4
    8f10:	inc    rax
    8f13:	cmp    rdi,rax
    8f16:	jne    8e50 <void fp32_avx512_fma<4>(unsigned long)+0x40>
    8f1c:	vzeroupper
    8f1f:	ret
    8f20:	vbroadcastss zmm0,DWORD PTR [rip+0x12b6]        # a1e0 <K_VALUES+0x20>
    8f2a:	vmovaps zmm1,zmm0
    8f30:	vmovaps zmm2,zmm0
    8f36:	vmovaps zmm3,zmm0
    8f3c:	vzeroupper
    8f3f:	ret

0000000000008f40 <void fp32_avx512_fma<6>(unsigned long)>:
    8f40:	endbr64
    8f44:	test   rdi,rdi
    8f47:	je     90c0 <void fp32_avx512_fma<6>(unsigned long)+0x180>
    8f4d:	vbroadcastss zmm0,DWORD PTR [rip+0x1289]        # a1e0 <K_VALUES+0x20>
    8f57:	vbroadcastss zmm1,DWORD PTR [rip+0x128f]        # a1f0 <K_VALUES+0x30>
    8f61:	xor    eax,eax
    8f63:	vmovaps zmm2,zmm0
    8f69:	vmovaps zmm3,zmm0
    8f6f:	vmovaps zmm4,zmm0
    8f75:	vmovaps zmm5,zmm0
    8f7b:	vmovaps zmm6,zmm0
    8f81:	vmovaps zmm7,zmm0
    8f87:	nop    WORD PTR [rax+rax*1+0x0]
    8f90:	vfmadd231ps zmm7,zmm1,zmm0
    8f96:	vfmadd231ps zmm6,zmm1,zmm0
    8f9c:	vfmadd231ps zmm5,zmm1,zmm0
    8fa2:	vfmadd231ps zmm4,zmm1,zmm0
    8fa8:	vfmadd231ps zmm3,zmm1,zmm0
    8fae:	vfmadd231ps zmm2,zmm1,zmm0
    8fb4:	vfmadd231ps zmm7,zmm1,zmm0
    8fba:	vfmadd231ps zmm6,zmm1,zmm0
    8fc0:	vfmadd231ps zmm5,zmm1,zmm0
    8fc6:	vfmadd231ps zmm4,zmm1,zmm0
    8fcc:	vfmadd231ps zmm3,zmm1,zmm0
    8fd2:	vfmadd231ps zmm2,zmm1,zmm0
    8fd8:	vfmadd231ps zmm7,zmm1,zmm0
    8fde:	vfmadd231ps zmm6,zmm1,zmm0
    8fe4:	vfmadd231ps zmm5,zmm1,zmm0
    8fea:	vfmadd231ps zmm4,zmm1,zmm0
    8ff0:	vfmadd231ps zmm3,zmm1,zmm0
    8ff6:	vfmadd231ps zmm2,zmm1,zmm0
    8ffc:	vfmadd231ps zmm7,zmm1,zmm0
    9002:	vfmadd231ps zmm6,zmm1,zmm0
    9008:	vfmadd231ps zmm5,zmm1,zmm0
    900e:	vfmadd231ps zmm4,zmm1,zmm0
    9014:	vfmadd231ps zmm3,zmm1,zmm0
    901a:	vfmadd231ps zmm2,zmm1,zmm0
    9020:	vfmadd231ps zmm7,zmm1,zmm0
    9026:	vfmadd231ps zmm6,zmm1,zmm0
    902c:	vfmadd231ps zmm5,zmm1,zmm0
    9032:	vfmadd231ps zmm4,zmm1,zmm0
    9038:	vfmadd231ps zmm3,zmm1,zmm0
    903e:	vfmadd231ps zmm2,zmm1,zmm0
    9044:	vfmadd231ps zmm7,zmm1,zmm0
    904a:	vfmadd231ps zmm6,zmm1,zmm0
    9050:	vfmadd231ps zmm5,zmm1,zmm0
    9056:	vfmadd231ps zmm4,zmm1,zmm0
    905c:	vfmadd231ps zmm3,zmm1,zmm0
    9062:	vfmadd231ps zmm2,zmm1,zmm0
    9068:	vfmadd231ps zmm7,zmm1,zmm0
    906e:	vfmadd231ps zmm6,zmm1,zmm0
    9074:	vfmadd231ps zmm5,zmm1,zmm0
    907a:	vfmadd231ps zmm4,zmm1,zmm0
    9080:	vfmadd231ps zmm3,zmm1,zmm0
    9086:	vfmadd231ps zmm2,zmm1,zmm0
    908c:	vfmadd231ps zmm7,zmm1,zmm0
    9092:	vfmadd231ps zmm6,zmm1,zmm0
    9098:	vfmadd231ps zmm5,zmm1,zmm0
    909e:	vfmadd231ps zmm4,zmm1,zmm0
    90a4:	vfmadd231ps zmm3,zmm1,zmm0
    90aa:	vfmadd231ps zmm2,zmm1,zmm0
    90b0:	inc    rax
    90b3:	cmp    rdi,rax
    90b6:	jne    8f90 <void fp32_avx512_fma<6>(unsigned long)+0x50>
    90bc:	vzeroupper
    90bf:	ret
    90c0:	vbroadcastss zmm2,DWORD PTR [rip+0x1116]        # a1e0 <K_VALUES+0x20>
    90ca:	vmovaps zmm3,zmm2
    90d0:	vmovaps zmm4,zmm2
    90d6:	vmovaps zmm5,zmm2
    90dc:	vmovaps zmm6,zmm2
    90e2:	vmovaps zmm7,zmm2
    90e8:	vzeroupper
    90eb:	ret
    90ec:	nop    DWORD PTR [rax+0x0]

00000000000090f0 <void fp32_avx512_fma<8>(unsigned long)>:
    90f0:	endbr64
    90f4:	test   rdi,rdi
    90f7:	je     92d8 <void fp32_avx512_fma<8>(unsigned long)+0x1e8>
    90fd:	vbroadcastss zmm0,DWORD PTR [rip+0x10d9]        # a1e0 <K_VALUES+0x20>
    9107:	vbroadcastss zmm1,DWORD PTR [rip+0x10df]        # a1f0 <K_VALUES+0x30>
    9111:	xor    eax,eax
    9113:	vmovaps zmm2,zmm0
    9119:	vmovaps zmm3,zmm0
    911f:	vmovaps zmm4,zmm0
    9125:	vmovaps zmm5,zmm0
    912b:	vmovaps zmm6,zmm0
    9131:	vmovaps zmm7,zmm0
    9137:	vmovaps zmm8,zmm0
    913d:	vmovaps zmm9,zmm0
    9143:	nop    DWORD PTR [rax+rax*1+0x0]
    9148:	vfmadd231ps zmm9,zmm1,zmm0
    914e:	vfmadd231ps zmm8,zmm1,zmm0
    9154:	vfmadd231ps zmm7,zmm1,zmm0
    915a:	vfmadd231ps zmm6,zmm1,zmm0
    9160:	vfmadd231ps zmm5,zmm1,zmm0
    9166:	vfmadd231ps zmm4,zmm1,zmm0
    916c:	vfmadd231ps zmm3,zmm1,zmm0
    9172:	vfmadd231ps zmm2,zmm1,zmm0
    9178:	vfmadd231ps zmm9,zmm1,zmm0
    917e:	vfmadd231ps zmm8,zmm1,zmm0
    9184:	vfmadd231ps zmm7,zmm1,zmm0
    918a:	vfmadd231ps zmm6,zmm1,zmm0
    9190:	vfmadd231ps zmm5,zmm1,zmm0
    9196:	vfmadd231ps zmm4,zmm1,zmm0
    919c:	vfmadd231ps zmm3,zmm1,zmm0
    91a2:	vfmadd231ps zmm2,zmm1,zmm0
    91a8:	vfmadd231ps zmm9,zmm1,zmm0
    91ae:	vfmadd231ps zmm8,zmm1,zmm0
    91b4:	vfmadd231ps zmm7,zmm1,zmm0
    91ba:	vfmadd231ps zmm6,zmm1,zmm0
    91c0:	vfmadd231ps zmm5,zmm1,zmm0
    91c6:	vfmadd231ps zmm4,zmm1,zmm0
    91cc:	vfmadd231ps zmm3,zmm1,zmm0
    91d2:	vfmadd231ps zmm2,zmm1,zmm0
    91d8:	vfmadd231ps zmm9,zmm1,zmm0
    91de:	vfmadd231ps zmm8,zmm1,zmm0
    91e4:	vfmadd231ps zmm7,zmm1,zmm0
    91ea:	vfmadd231ps zmm6,zmm1,zmm0
    91f0:	vfmadd231ps zmm5,zmm1,zmm0
    91f6:	vfmadd231ps zmm4,zmm1,zmm0
    91fc:	vfmadd231ps zmm3,zmm1,zmm0
    9202:	vfmadd231ps zmm2,zmm1,zmm0
    9208:	vfmadd231ps zmm9,zmm1,zmm0
    920e:	vfmadd231ps zmm8,zmm1,zmm0
    9214:	vfmadd231ps zmm7,zmm1,zmm0
    921a:	vfmadd231ps zmm6,zmm1,zmm0
    9220:	vfmadd231ps zmm5,zmm1,zmm0
    9226:	vfmadd231ps zmm4,zmm1,zmm0
    922c:	vfmadd231ps zmm3,zmm1,zmm0
    9232:	vfmadd231ps zmm2,zmm1,zmm0
    9238:	vfmadd231ps zmm9,zmm1,zmm0
    923e:	vfmadd231ps zmm8,zmm1,zmm0
    9244:	vfmadd231ps zmm7,zmm1,zmm0
    924a:	vfmadd231ps zmm6,zmm1,zmm0
    9250:	vfmadd231ps zmm5,zmm1,zmm0
    9256:	vfmadd231ps zmm4,zmm1,zmm0
    925c:	vfmadd231ps zmm3,zmm1,zmm0
    9262:	vfmadd231ps zmm2,zmm1,zmm0
    9268:	vfmadd231ps zmm9,zmm1,zmm0
    926e:	vfmadd231ps zmm8,zmm1,zmm0
    9274:	vfmadd231ps zmm7,zmm1,zmm0
    927a:	vfmadd231ps zmm6,zmm1,zmm0
    9280:	vfmadd231ps zmm5,zmm1,zmm0
    9286:	vfmadd231ps zmm4,zmm1,zmm0
    928c:	vfmadd231ps zmm3,zmm1,zmm0
    9292:	vfmadd231ps zmm2,zmm1,zmm0
    9298:	vfmadd231ps zmm9,zmm1,zmm0
    929e:	vfmadd231ps zmm8,zmm1,zmm0
    92a4:	vfmadd231ps zmm7,zmm1,zmm0
    92aa:	vfmadd231ps zmm6,zmm1,zmm0
    92b0:	vfmadd231ps zmm5,zmm1,zmm0
    92b6:	vfmadd231ps zmm4,zmm1,zmm0
    92bc:	vfmadd231ps zmm3,zmm1,zmm0
    92c2:	vfmadd231ps zmm2,zmm1,zmm0
    92c8:	inc    rax
    92cb:	cmp    rdi,rax
    92ce:	jne    9148 <void fp32_avx512_fma<8>(unsigned long)+0x58>
    92d4:	vzeroupper
    92d7:	ret
    92d8:	vbroadcastss zmm2,DWORD PTR [rip+0xefe]        # a1e0 <K_VALUES+0x20>
    92e2:	vmovaps zmm3,zmm2
    92e8:	vmovaps zmm4,zmm2
    92ee:	vmovaps zmm5,zmm2
    92f4:	vmovaps zmm6,zmm2
    92fa:	vmovaps zmm7,zmm2
    9300:	vmovaps zmm8,zmm2
    9306:	vmovaps zmm9,zmm2
    930c:	vzeroupper
    930f:	ret

0000000000009310 <void fp32_avx512_fma<10>(unsigned long)>:
    9310:	endbr64
    9314:	test   rdi,rdi
    9317:	je     9560 <void fp32_avx512_fma<10>(unsigned long)+0x250>
    931d:	vbroadcastss zmm0,DWORD PTR [rip+0xeb9]        # a1e0 <K_VALUES+0x20>
    9327:	vbroadcastss zmm1,DWORD PTR [rip+0xebf]        # a1f0 <K_VALUES+0x30>
    9331:	xor    eax,eax
    9333:	vmovaps zmm2,zmm0
    9339:	vmovaps zmm3,zmm0
    933f:	vmovaps zmm4,zmm0
    9345:	vmovaps zmm5,zmm0
    934b:	vmovaps zmm6,zmm0
    9351:	vmovaps zmm7,zmm0
    9357:	vmovaps zmm8,zmm0
    935d:	vmovaps zmm9,zmm0
    9363:	vmovaps zmm10,zmm0
    9369:	vmovaps zmm11,zmm0
    936f:	nop
    9370:	vfmadd231ps zmm11,zmm1,zmm0
    9376:	vfmadd231ps zmm10,zmm1,zmm0
    937c:	vfmadd231ps zmm9,zmm1,zmm0
    9382:	vfmadd231ps zmm8,zmm1,zmm0
    9388:	vfmadd231ps zmm7,zmm1,zmm0
    938e:	vfmadd231ps zmm6,zmm1,zmm0
    9394:	vfmadd231ps zmm5,zmm1,zmm0
    939a:	vfmadd231ps zmm4,zmm1,zmm0
    93a0:	vfmadd231ps zmm3,zmm1,zmm0
    93a6:	vfmadd231ps zmm2,zmm1,zmm0
    93ac:	vfmadd231ps zmm11,zmm1,zmm0
    93b2:	vfmadd231ps zmm10,zmm1,zmm0
    93b8:	vfmadd231ps zmm9,zmm1,zmm0
    93be:	vfmadd231ps zmm8,zmm1,zmm0
    93c4:	vfmadd231ps zmm7,zmm1,zmm0
    93ca:	vfmadd231ps zmm6,zmm1,zmm0
    93d0:	vfmadd231ps zmm5,zmm1,zmm0
    93d6:	vfmadd231ps zmm4,zmm1,zmm0
    93dc:	vfmadd231ps zmm3,zmm1,zmm0
    93e2:	vfmadd231ps zmm2,zmm1,zmm0
    93e8:	vfmadd231ps zmm11,zmm1,zmm0
    93ee:	vfmadd231ps zmm10,zmm1,zmm0
    93f4:	vfmadd231ps zmm9,zmm1,zmm0
    93fa:	vfmadd231ps zmm8,zmm1,zmm0
    9400:	vfmadd231ps zmm7,zmm1,zmm0
    9406:	vfmadd231ps zmm6,zmm1,zmm0
    940c:	vfmadd231ps zmm5,zmm1,zmm0
    9412:	vfmadd231ps zmm4,zmm1,zmm0
    9418:	vfmadd231ps zmm3,zmm1,zmm0
    941e:	vfmadd231ps zmm2,zmm1,zmm0
    9424:	vfmadd231ps zmm11,zmm1,zmm0
    942a:	vfmadd231ps zmm10,zmm1,zmm0
    9430:	vfmadd231ps zmm9,zmm1,zmm0
    9436:	vfmadd231ps zmm8,zmm1,zmm0
    943c:	vfmadd231ps zmm7,zmm1,zmm0
    9442:	vfmadd231ps zmm6,zmm1,zmm0
    9448:	vfmadd231ps zmm5,zmm1,zmm0
    944e:	vfmadd231ps zmm4,zmm1,zmm0
    9454:	vfmadd231ps zmm3,zmm1,zmm0
    945a:	vfmadd231ps zmm2,zmm1,zmm0
    9460:	vfmadd231ps zmm11,zmm1,zmm0
    9466:	vfmadd231ps zmm10,zmm1,zmm0
    946c:	vfmadd231ps zmm9,zmm1,zmm0
    9472:	vfmadd231ps zmm8,zmm1,zmm0
    9478:	vfmadd231ps zmm7,zmm1,zmm0
    947e:	vfmadd231ps zmm6,zmm1,zmm0
    9484:	vfmadd231ps zmm5,zmm1,zmm0
    948a:	vfmadd231ps zmm4,zmm1,zmm0
    9490:	vfmadd231ps zmm3,zmm1,zmm0
    9496:	vfmadd231ps zmm2,zmm1,zmm0
    949c:	vfmadd231ps zmm11,zmm1,zmm0
    94a2:	vfmadd231ps zmm10,zmm1,zmm0
    94a8:	vfmadd231ps zmm9,zmm1,zmm0
    94ae:	vfmadd231ps zmm8,zmm1,zmm0
    94b4:	vfmadd231ps zmm7,zmm1,zmm0
    94ba:	vfmadd231ps zmm6,zmm1,zmm0
    94c0:	vfmadd231ps zmm5,zmm1,zmm0
    94c6:	vfmadd231ps zmm4,zmm1,zmm0
    94cc:	vfmadd231ps zmm3,zmm1,zmm0
    94d2:	vfmadd231ps zmm2,zmm1,zmm0
    94d8:	vfmadd231ps zmm11,zmm1,zmm0
    94de:	vfmadd231ps zmm10,zmm1,zmm0
    94e4:	vfmadd231ps zmm9,zmm1,zmm0
    94ea:	vfmadd231ps zmm8,zmm1,zmm0
    94f0:	vfmadd231ps zmm7,zmm1,zmm0
    94f6:	vfmadd231ps zmm6,zmm1,zmm0
    94fc:	vfmadd231ps zmm5,zmm1,zmm0
    9502:	vfmadd231ps zmm4,zmm1,zmm0
    9508:	vfmadd231ps zmm3,zmm1,zmm0
    950e:	vfmadd231ps zmm2,zmm1,zmm0
    9514:	vfmadd231ps zmm11,zmm1,zmm0
    951a:	vfmadd231ps zmm10,zmm1,zmm0
    9520:	vfmadd231ps zmm9,zmm1,zmm0
    9526:	vfmadd231ps zmm8,zmm1,zmm0
    952c:	vfmadd231ps zmm7,zmm1,zmm0
    9532:	vfmadd231ps zmm6,zmm1,zmm0
    9538:	vfmadd231ps zmm5,zmm1,zmm0
    953e:	vfmadd231ps zmm4,zmm1,zmm0
    9544:	vfmadd231ps zmm3,zmm1,zmm0
    954a:	vfmadd231ps zmm2,zmm1,zmm0
    9550:	inc    rax
    9553:	cmp    rdi,rax
    9556:	jne    9370 <void fp32_avx512_fma<10>(unsigned long)+0x60>
    955c:	vzeroupper
    955f:	ret
    9560:	vbroadcastss zmm2,DWORD PTR [rip+0xc76]        # a1e0 <K_VALUES+0x20>
    956a:	vmovaps zmm3,zmm2
    9570:	vmovaps zmm4,zmm2
    9576:	vmovaps zmm5,zmm2
    957c:	vmovaps zmm6,zmm2
    9582:	vmovaps zmm7,zmm2
    9588:	vmovaps zmm8,zmm2
    958e:	vmovaps zmm9,zmm2
    9594:	vmovaps zmm10,zmm2
    959a:	vmovaps zmm11,zmm2
    95a0:	vzeroupper
    95a3:	ret
    95a4:	data16 cs nop WORD PTR [rax+rax*1+0x0]
    95af:	nop

00000000000095b0 <void fp32_avx512_fma<12>(unsigned long)>:
    95b0:	endbr64
    95b4:	test   rdi,rdi
    95b7:	je     9870 <void fp32_avx512_fma<12>(unsigned long)+0x2c0>
    95bd:	vbroadcastss zmm0,DWORD PTR [rip+0xc19]        # a1e0 <K_VALUES+0x20>
    95c7:	vbroadcastss zmm1,DWORD PTR [rip+0xc1f]        # a1f0 <K_VALUES+0x30>
    95d1:	xor    eax,eax
    95d3:	vmovaps zmm10,zmm0
    95d9:	vmovaps zmm11,zmm0
    95df:	vmovaps zmm12,zmm0
    95e5:	vmovaps zmm13,zmm0
    95eb:	vmovaps zmm2,zmm0
    95f1:	vmovaps zmm3,zmm0
    95f7:	vmovaps zmm4,zmm0
    95fd:	vmovaps zmm5,zmm0
    9603:	vmovaps zmm6,zmm0
    9609:	vmovaps zmm7,zmm0
    960f:	vmovaps zmm8,zmm0
    9615:	vmovaps zmm9,zmm0
    961b:	nop    DWORD PTR [rax+rax*1+0x0]
    9620:	vfmadd231ps zmm9,zmm1,zmm0
    9626:	vfmadd231ps zmm8,zmm1,zmm0
    962c:	vfmadd231ps zmm7,zmm1,zmm0
    9632:	vfmadd231ps zmm6,zmm1,zmm0
    9638:	vfmadd231ps zmm5,zmm1,zmm0
    963e:	vfmadd231ps zmm4,zmm1,zmm0
    9644:	vfmadd231ps zmm3,zmm1,zmm0
    964a:	vfmadd231ps zmm2,zmm1,zmm0
    9650:	vfmadd231ps zmm13,zmm1,zmm0
    9656:	vfmadd231ps zmm12,zmm1,zmm0
    965c:	vfmadd231ps zmm11,zmm1,zmm0
    9662:	vfmadd231ps zmm10,zmm1,zmm0
    9668:	vfmadd231ps zmm9,zmm1,zmm0
    966e:	vfmadd231ps zmm8,zmm1,zmm0
    9674:	vfmadd231ps zmm7,zmm1,zmm0
    967a:	vfmadd231ps zmm6,zmm1,zmm0
    9680:	vfmadd231ps zmm5,zmm1,zmm0
    9686:	vfmadd231ps zmm4,zmm1,zmm0
    968c:	vfmadd231ps zmm3,zmm1,zmm0
    9692:	vfmadd231ps zmm2,zmm1,zmm0
    9698:	vfmadd231ps zmm13,zmm1,zmm0
    969e:	vfmadd231ps zmm12,zmm1,zmm0
    96a4:	vfmadd231ps zmm11,zmm1,zmm0
    96aa:	vfmadd231ps zmm10,zmm1,zmm0
    96b0:	vfmadd231ps zmm9,zmm1,zmm0
    96b6:	vfmadd231ps zmm8,zmm1,zmm0
    96bc:	vfmadd231ps zmm7,zmm1,zmm0
    96c2:	vfmadd231ps zmm6,zmm1,zmm0
    96c8:	vfmadd231ps zmm5,zmm1,zmm0
    96ce:	vfmadd231ps zmm4,zmm1,zmm0
    96d4:	vfmadd231ps zmm3,zmm1,zmm0
    96da:	vfmadd231ps zmm2,zmm1,zmm0
    96e0:	vfmadd231ps zmm13,zmm1,zmm0
    96e6:	vfmadd231ps zmm12,zmm1,zmm0
    96ec:	vfmadd231ps zmm11,zmm1,zmm0
    96f2:	vfmadd231ps zmm10,zmm1,zmm0
    96f8:	vfmadd231ps zmm9,zmm1,zmm0
    96fe:	vfmadd231ps zmm8,zmm1,zmm0
    9704:	vfmadd231ps zmm7,zmm1,zmm0
    970a:	vfmadd231ps zmm6,zmm1,zmm0
    9710:	vfmadd231ps zmm5,zmm1,zmm0
    9716:	vfmadd231ps zmm4,zmm1,zmm0
    971c:	vfmadd231ps zmm3,zmm1,zmm0
    9722:	vfmadd231ps zmm2,zmm1,zmm0
    9728:	vfmadd231ps zmm13,zmm1,zmm0
    972e:	vfmadd231ps zmm12,zmm1,zmm0
    9734:	vfmadd231ps zmm11,zmm1,zmm0
    973a:	vfmadd231ps zmm10,zmm1,zmm0
    9740:	vfmadd231ps zmm9,zmm1,zmm0
    9746:	vfmadd231ps zmm8,zmm1,zmm0
    974c:	vfmadd231ps zmm7,zmm1,zmm0
    9752:	vfmadd231ps zmm6,zmm1,zmm0
    9758:	vfmadd231ps zmm5,zmm1,zmm0
    975e:	vfmadd231ps zmm4,zmm1,zmm0
    9764:	vfmadd231ps zmm3,zmm1,zmm0
    976a:	vfmadd231ps zmm2,zmm1,zmm0
    9770:	vfmadd231ps zmm13,zmm1,zmm0
    9776:	vfmadd231ps zmm12,zmm1,zmm0
    977c:	vfmadd231ps zmm11,zmm1,zmm0
    9782:	vfmadd231ps zmm10,zmm1,zmm0
    9788:	vfmadd231ps zmm9,zmm1,zmm0
    978e:	vfmadd231ps zmm8,zmm1,zmm0
    9794:	vfmadd231ps zmm7,zmm1,zmm0
    979a:	vfmadd231ps zmm6,zmm1,zmm0
    97a0:	vfmadd231ps zmm5,zmm1,zmm0
    97a6:	vfmadd231ps zmm4,zmm1,zmm0
    97ac:	vfmadd231ps zmm3,zmm1,zmm0
    97b2:	vfmadd231ps zmm2,zmm1,zmm0
    97b8:	vfmadd231ps zmm13,zmm1,zmm0
    97be:	vfmadd231ps zmm12,zmm1,zmm0
    97c4:	vfmadd231ps zmm11,zmm1,zmm0
    97ca:	vfmadd231ps zmm10,zmm1,zmm0
    97d0:	vfmadd231ps zmm9,zmm1,zmm0
    97d6:	vfmadd231ps zmm8,zmm1,zmm0
    97dc:	vfmadd231ps zmm7,zmm1,zmm0
    97e2:	vfmadd231ps zmm6,zmm1,zmm0
    97e8:	vfmadd231ps zmm5,zmm1,zmm0
    97ee:	vfmadd231ps zmm4,zmm1,zmm0
    97f4:	vfmadd231ps zmm3,zmm1,zmm0
    97fa:	vfmadd231ps zmm2,zmm1,zmm0
    9800:	vfmadd231ps zmm13,zmm1,zmm0
    9806:	vfmadd231ps zmm12,zmm1,zmm0
    980c:	vfmadd231ps zmm11,zmm1,zmm0
    9812:	vfmadd231ps zmm10,zmm1,zmm0
    9818:	vfmadd231ps zmm9,zmm1,zmm0
    981e:	vfmadd231ps zmm8,zmm1,zmm0
    9824:	vfmadd231ps zmm7,zmm1,zmm0
    982a:	vfmadd231ps zmm6,zmm1,zmm0
    9830:	vfmadd231ps zmm5,zmm1,zmm0
    9836:	vfmadd231ps zmm4,zmm1,zmm0
    983c:	vfmadd231ps zmm3,zmm1,zmm0
    9842:	vfmadd231ps zmm2,zmm1,zmm0
    9848:	vfmadd231ps zmm13,zmm1,zmm0
    984e:	vfmadd231ps zmm12,zmm1,zmm0
    9854:	vfmadd231ps zmm11,zmm1,zmm0
    985a:	vfmadd231ps zmm10,zmm1,zmm0
    9860:	inc    rax
    9863:	cmp    rdi,rax
    9866:	jne    9620 <void fp32_avx512_fma<12>(unsigned long)+0x70>
    986c:	vzeroupper
    986f:	ret
    9870:	vbroadcastss zmm10,DWORD PTR [rip+0x966]        # a1e0 <K_VALUES+0x20>
    987a:	vmovaps zmm11,zmm10
    9880:	vmovaps zmm12,zmm10
    9886:	vmovaps zmm13,zmm10
    988c:	vmovaps zmm2,zmm10
    9892:	vmovaps zmm3,zmm10
    9898:	vmovaps zmm4,zmm10
    989e:	vmovaps zmm5,zmm10
    98a4:	vmovaps zmm6,zmm10
    98aa:	vmovaps zmm7,zmm10
    98b0:	vmovaps zmm8,zmm10
    98b6:	vmovaps zmm9,zmm10
    98bc:	vzeroupper
    98bf:	ret

00000000000098c0 <void fp32_avx512_fma<16>(unsigned long)>:
    98c0:	endbr64
    98c4:	test   rdi,rdi
    98c7:	je     9c58 <void fp32_avx512_fma<16>(unsigned long)+0x398>
    98cd:	vbroadcastss zmm0,DWORD PTR [rip+0x909]        # a1e0 <K_VALUES+0x20>
    98d7:	vbroadcastss zmm1,DWORD PTR [rip+0x90f]        # a1f0 <K_VALUES+0x30>
    98e1:	xor    eax,eax
    98e3:	vmovaps zmm2,zmm0
    98e9:	vmovaps zmm17,zmm0
    98ef:	vmovaps zmm3,zmm0
    98f5:	vmovaps zmm4,zmm0
    98fb:	vmovaps zmm5,zmm0
    9901:	vmovaps zmm6,zmm0
    9907:	vmovaps zmm7,zmm0
    990d:	vmovaps zmm8,zmm0
    9913:	vmovaps zmm9,zmm0
    9919:	vmovaps zmm10,zmm0
    991f:	vmovaps zmm11,zmm0
    9925:	vmovaps zmm12,zmm0
    992b:	vmovaps zmm13,zmm0
    9931:	vmovaps zmm14,zmm0
    9937:	vmovaps zmm15,zmm0
    993d:	vmovaps zmm16,zmm0
    9943:	nop    DWORD PTR [rax+rax*1+0x0]
    9948:	vfmadd231ps zmm16,zmm1,zmm0
    994e:	vfmadd231ps zmm15,zmm1,zmm0
    9954:	vfmadd231ps zmm14,zmm1,zmm0
    995a:	vfmadd231ps zmm13,zmm1,zmm0
    9960:	vfmadd231ps zmm12,zmm1,zmm0
    9966:	vfmadd231ps zmm11,zmm1,zmm0
    996c:	vfmadd231ps zmm10,zmm1,zmm0
    9972:	vfmadd231ps zmm9,zmm1,zmm0
    9978:	vfmadd231ps zmm8,zmm1,zmm0
    997e:	vfmadd231ps zmm7,zmm1,zmm0
    9984:	vfmadd231ps zmm6,zmm1,zmm0
    998a:	vfmadd231ps zmm5,zmm1,zmm0
    9990:	vfmadd231ps zmm4,zmm1,zmm0
    9996:	vfmadd231ps zmm3,zmm1,zmm0
    999c:	vfmadd231ps zmm17,zmm1,zmm0
    99a2:	vfmadd231ps zmm2,zmm1,zmm0
    99a8:	vfmadd231ps zmm16,zmm1,zmm0
    99ae:	vfmadd231ps zmm15,zmm1,zmm0
    99b4:	vfmadd231ps zmm14,zmm1,zmm0
    99ba:	vfmadd231ps zmm13,zmm1,zmm0
    99c0:	vfmadd231ps zmm12,zmm1,zmm0
    99c6:	vfmadd231ps zmm11,zmm1,zmm0
    99cc:	vfmadd231ps zmm10,zmm1,zmm0
    99d2:	vfmadd231ps zmm9,zmm1,zmm0
    99d8:	vfmadd231ps zmm8,zmm1,zmm0
    99de:	vfmadd231ps zmm7,zmm1,zmm0
    99e4:	vfmadd231ps zmm6,zmm1,zmm0
    99ea:	vfmadd231ps zmm5,zmm1,zmm0
    99f0:	vfmadd231ps zmm4,zmm1,zmm0
    99f6:	vfmadd231ps zmm3,zmm1,zmm0
    99fc:	vfmadd231ps zmm17,zmm1,zmm0
    9a02:	vfmadd231ps zmm2,zmm1,zmm0
    9a08:	vfmadd231ps zmm16,zmm1,zmm0
    9a0e:	vfmadd231ps zmm15,zmm1,zmm0
    9a14:	vfmadd231ps zmm14,zmm1,zmm0
    9a1a:	vfmadd231ps zmm13,zmm1,zmm0
    9a20:	vfmadd231ps zmm12,zmm1,zmm0
    9a26:	vfmadd231ps zmm11,zmm1,zmm0
    9a2c:	vfmadd231ps zmm10,zmm1,zmm0
    9a32:	vfmadd231ps zmm9,zmm1,zmm0
    9a38:	vfmadd231ps zmm8,zmm1,zmm0
    9a3e:	vfmadd231ps zmm7,zmm1,zmm0
    9a44:	vfmadd231ps zmm6,zmm1,zmm0
    9a4a:	vfmadd231ps zmm5,zmm1,zmm0
    9a50:	vfmadd231ps zmm4,zmm1,zmm0
    9a56:	vfmadd231ps zmm3,zmm1,zmm0
    9a5c:	vfmadd231ps zmm17,zmm1,zmm0
    9a62:	vfmadd231ps zmm2,zmm1,zmm0
    9a68:	vfmadd231ps zmm16,zmm1,zmm0
    9a6e:	vfmadd231ps zmm15,zmm1,zmm0
    9a74:	vfmadd231ps zmm14,zmm1,zmm0
    9a7a:	vfmadd231ps zmm13,zmm1,zmm0
    9a80:	vfmadd231ps zmm12,zmm1,zmm0
    9a86:	vfmadd231ps zmm11,zmm1,zmm0
    9a8c:	vfmadd231ps zmm10,zmm1,zmm0
    9a92:	vfmadd231ps zmm9,zmm1,zmm0
    9a98:	vfmadd231ps zmm8,zmm1,zmm0
    9a9e:	vfmadd231ps zmm7,zmm1,zmm0
    9aa4:	vfmadd231ps zmm6,zmm1,zmm0
    9aaa:	vfmadd231ps zmm5,zmm1,zmm0
    9ab0:	vfmadd231ps zmm4,zmm1,zmm0
    9ab6:	vfmadd231ps zmm3,zmm1,zmm0
    9abc:	vfmadd231ps zmm17,zmm1,zmm0
    9ac2:	vfmadd231ps zmm2,zmm1,zmm0
    9ac8:	vfmadd231ps zmm16,zmm1,zmm0
    9ace:	vfmadd231ps zmm15,zmm1,zmm0
    9ad4:	vfmadd231ps zmm14,zmm1,zmm0
    9ada:	vfmadd231ps zmm13,zmm1,zmm0
    9ae0:	vfmadd231ps zmm12,zmm1,zmm0
    9ae6:	vfmadd231ps zmm11,zmm1,zmm0
    9aec:	vfmadd231ps zmm10,zmm1,zmm0
    9af2:	vfmadd231ps zmm9,zmm1,zmm0
    9af8:	vfmadd231ps zmm8,zmm1,zmm0
    9afe:	vfmadd231ps zmm7,zmm1,zmm0
    9b04:	vfmadd231ps zmm6,zmm1,zmm0
    9b0a:	vfmadd231ps zmm5,zmm1,zmm0
    9b10:	vfmadd231ps zmm4,zmm1,zmm0
    9b16:	vfmadd231ps zmm3,zmm1,zmm0
    9b1c:	vfmadd231ps zmm17,zmm1,zmm0
    9b22:	vfmadd231ps zmm2,zmm1,zmm0
    9b28:	vfmadd231ps zmm16,zmm1,zmm0
    9b2e:	vfmadd231ps zmm15,zmm1,zmm0
    9b34:	vfmadd231ps zmm14,zmm1,zmm0
    9b3a:	vfmadd231ps zmm13,zmm1,zmm0
    9b40:	vfmadd231ps zmm12,zmm1,zmm0
    9b46:	vfmadd231ps zmm11,zmm1,zmm0
    9b4c:	vfmadd231ps zmm10,zmm1,zmm0
    9b52:	vfmadd231ps zmm9,zmm1,zmm0
    9b58:	vfmadd231ps zmm8,zmm1,zmm0
    9b5e:	vfmadd231ps zmm7,zmm1,zmm0
    9b64:	vfmadd231ps zmm6,zmm1,zmm0
    9b6a:	vfmadd231ps zmm5,zmm1,zmm0
    9b70:	vfmadd231ps zmm4,zmm1,zmm0
    9b76:	vfmadd231ps zmm3,zmm1,zmm0
    9b7c:	vfmadd231ps zmm17,zmm1,zmm0
    9b82:	vfmadd231ps zmm2,zmm1,zmm0
    9b88:	vfmadd231ps zmm16,zmm1,zmm0
    9b8e:	vfmadd231ps zmm15,zmm1,zmm0
    9b94:	vfmadd231ps zmm14,zmm1,zmm0
    9b9a:	vfmadd231ps zmm13,zmm1,zmm0
    9ba0:	vfmadd231ps zmm12,zmm1,zmm0
    9ba6:	vfmadd231ps zmm11,zmm1,zmm0
    9bac:	vfmadd231ps zmm10,zmm1,zmm0
    9bb2:	vfmadd231ps zmm9,zmm1,zmm0
    9bb8:	vfmadd231ps zmm8,zmm1,zmm0
    9bbe:	vfmadd231ps zmm7,zmm1,zmm0
    9bc4:	vfmadd231ps zmm6,zmm1,zmm0
    9bca:	vfmadd231ps zmm5,zmm1,zmm0
    9bd0:	vfmadd231ps zmm4,zmm1,zmm0
    9bd6:	vfmadd231ps zmm3,zmm1,zmm0
    9bdc:	vfmadd231ps zmm17,zmm1,zmm0
    9be2:	vfmadd231ps zmm2,zmm1,zmm0
    9be8:	vfmadd231ps zmm16,zmm1,zmm0
    9bee:	vfmadd231ps zmm15,zmm1,zmm0
    9bf4:	vfmadd231ps zmm14,zmm1,zmm0
    9bfa:	vfmadd231ps zmm13,zmm1,zmm0
    9c00:	vfmadd231ps zmm12,zmm1,zmm0
    9c06:	vfmadd231ps zmm11,zmm1,zmm0
    9c0c:	vfmadd231ps zmm10,zmm1,zmm0
    9c12:	vfmadd231ps zmm9,zmm1,zmm0
    9c18:	vfmadd231ps zmm8,zmm1,zmm0
    9c1e:	vfmadd231ps zmm7,zmm1,zmm0
    9c24:	vfmadd231ps zmm6,zmm1,zmm0
    9c2a:	vfmadd231ps zmm5,zmm1,zmm0
    9c30:	vfmadd231ps zmm4,zmm1,zmm0
    9c36:	vfmadd231ps zmm3,zmm1,zmm0
    9c3c:	vfmadd231ps zmm17,zmm1,zmm0
    9c42:	vfmadd231ps zmm2,zmm1,zmm0
    9c48:	inc    rax
    9c4b:	cmp    rdi,rax
    9c4e:	jne    9948 <void fp32_avx512_fma<16>(unsigned long)+0x88>
    9c54:	vzeroupper
    9c57:	ret
    9c58:	vbroadcastss zmm2,DWORD PTR [rip+0x57e]        # a1e0 <K_VALUES+0x20>
    9c62:	vmovaps zmm17,zmm2
    9c68:	vmovaps zmm3,zmm2
    9c6e:	vmovaps zmm4,zmm2
    9c74:	vmovaps zmm5,zmm2
    9c7a:	vmovaps zmm6,zmm2
    9c80:	vmovaps zmm7,zmm2
    9c86:	vmovaps zmm8,zmm2
    9c8c:	vmovaps zmm9,zmm2
    9c92:	vmovaps zmm10,zmm2
    9c98:	vmovaps zmm11,zmm2
    9c9e:	vmovaps zmm12,zmm2
    9ca4:	vmovaps zmm13,zmm2
    9caa:	vmovaps zmm14,zmm2
    9cb0:	vmovaps zmm15,zmm2
    9cb6:	vmovaps zmm16,zmm2
    9cbc:	vzeroupper
    9cbf:	ret

0000000000009cc0 <Counters::Counters()>:
    9cc0:	endbr64
    9cc4:	push   rbp
    9cc5:	mov    rbp,rsp
    9cc8:	push   r14
    9cca:	push   r13
    9ccc:	mov    r13,rdi
    9ccf:	push   r12
    9cd1:	push   rbx
    9cd2:	xor    ebx,ebx
    9cd4:	sub    rsp,0xb0
    9cdb:	mov    rax,QWORD PTR fs:0x28
    9ce4:	mov    QWORD PTR [rsp+0xa8],rax
    9cec:	xor    eax,eax
    9cee:	vmovdqa xmm0,XMMWORD PTR [rip+0x50a]        # a200 <K_VALUES+0x40>
    9cf6:	mov    QWORD PTR [rdi],0xffffffffffffffff
    9cfd:	mov    r12,rsp
    9d00:	mov    DWORD PTR [rdi+0x8],0xffffffff
    9d07:	lea    r14,[rsp+0x90]
    9d0f:	mov    BYTE PTR [rdi+0xc],0x0
    9d13:	mov    QWORD PTR [rsp+0xa0],0x1
    9d1f:	vmovdqa XMMWORD PTR [rsp+0x90],xmm0
    9d28:	vpxor  xmm0,xmm0,xmm0
    9d2c:	mov    rax,QWORD PTR [r14+rbx*8]
    9d30:	test   ebx,ebx
    9d32:	vmovdqu8 ZMMWORD PTR [r12],zmm0
    9d39:	mov    QWORD PTR [r12+0x80],0x0
    9d45:	mov    QWORD PTR [rsp+0x8],rax
    9d4a:	sete   al
    9d4d:	xor    r9d,r9d
    9d50:	or     eax,0x40
    9d53:	mov    DWORD PTR [rsp+0x4],0x88
    9d5b:	mov    QWORD PTR [rsp+0x20],0x8
    9d64:	mov    BYTE PTR [rsp+0x28],al
    9d68:	vmovdqu8 ZMMWORD PTR [r12+0x40],zmm0
    9d70:	test   rbx,rbx
    9d73:	je     9db0 <Counters::Counters()+0xf0>
    9d75:	mov    r8d,DWORD PTR [r13+0x0]
    9d79:	xor    edx,edx
    9d7b:	xor    eax,eax
    9d7d:	mov    ecx,0xffffffff
    9d82:	mov    rsi,r12
    9d85:	mov    edi,0x12a
    9d8a:	vzeroupper
    9d8d:	call   1160 <syscall@plt>
    9d92:	vpxor  xmm0,xmm0,xmm0
    9d96:	test   eax,eax
    9d98:	mov    DWORD PTR [r13+rbx*4+0x0],eax
    9d9d:	js     9e10 <Counters::Counters()+0x150>
    9d9f:	cmp    rbx,0x2
    9da3:	je     9de8 <Counters::Counters()+0x128>
    9da5:	mov    ebx,0x2
    9daa:	jmp    9d2c <Counters::Counters()+0x6c>
    9dac:	nop    DWORD PTR [rax+0x0]
    9db0:	xor    edx,edx
    9db2:	xor    eax,eax
    9db4:	mov    r8d,0xffffffff
    9dba:	mov    ecx,0xffffffff
    9dbf:	mov    rsi,r12
    9dc2:	mov    edi,0x12a
    9dc7:	vzeroupper
    9dca:	call   1160 <syscall@plt>
    9dcf:	vpxor  xmm0,xmm0,xmm0
    9dd3:	test   eax,eax
    9dd5:	mov    DWORD PTR [r13+0x0],eax
    9dd9:	js     9e10 <Counters::Counters()+0x150>
    9ddb:	mov    ebx,0x1
    9de0:	jmp    9d2c <Counters::Counters()+0x6c>
    9de5:	nop    DWORD PTR [rax]
    9de8:	mov    BYTE PTR [r13+0xc],0x1
    9ded:	mov    rax,QWORD PTR [rsp+0xa8]
    9df5:	sub    rax,QWORD PTR fs:0x28
    9dfe:	jne    9e2c <Counters::Counters()+0x16c>
    9e00:	add    rsp,0xb0
    9e07:	pop    rbx
    9e08:	pop    r12
    9e0a:	pop    r13
    9e0c:	pop    r14
    9e0e:	pop    rbp
    9e0f:	ret
    9e10:	mov    rdi,QWORD PTR [rip+0x2229]        # c040 <stderr@GLIBC_2.2.5>
    9e17:	lea    rdx,[rip+0x1ea]        # a008 <_IO_stdin_used+0x8>
    9e1e:	mov    esi,0x2
    9e23:	xor    eax,eax
    9e25:	call   1220 <__fprintf_chk@plt>
    9e2a:	jmp    9ded <Counters::Counters()+0x12d>
    9e2c:	call   11c0 <__stack_chk_fail@plt>

Disassembly of section .fini:

0000000000009e34 <_fini>:
    9e34:	endbr64
    9e38:	sub    rsp,0x8
    9e3c:	add    rsp,0x8
    9e40:	ret
