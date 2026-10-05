
bin/membw:     file format elf64-x86-64


Disassembly of section .init:

0000000000002000 <_init>:
    2000:	endbr64
    2004:	sub    rsp,0x8
    2008:	mov    rax,QWORD PTR [rip+0x3fe1]        # 5ff0 <__gmon_start__@Base>
    200f:	test   rax,rax
    2012:	je     2016 <_init+0x16>
    2014:	call   rax
    2016:	add    rsp,0x8
    201a:	ret

Disassembly of section .plt:

0000000000002020 <.plt>:
    2020:	push   QWORD PTR [rip+0x3ea2]        # 5ec8 <_GLOBAL_OFFSET_TABLE_+0x8>
    2026:	jmp    QWORD PTR [rip+0x3ea4]        # 5ed0 <_GLOBAL_OFFSET_TABLE_+0x10>
    202c:	nop    DWORD PTR [rax+0x0]
    2030:	endbr64
    2034:	push   0x0
    2039:	jmp    2020 <_init+0x20>
    203e:	xchg   ax,ax
    2040:	endbr64
    2044:	push   0x1
    2049:	jmp    2020 <_init+0x20>
    204e:	xchg   ax,ax
    2050:	endbr64
    2054:	push   0x2
    2059:	jmp    2020 <_init+0x20>
    205e:	xchg   ax,ax
    2060:	endbr64
    2064:	push   0x3
    2069:	jmp    2020 <_init+0x20>
    206e:	xchg   ax,ax
    2070:	endbr64
    2074:	push   0x4
    2079:	jmp    2020 <_init+0x20>
    207e:	xchg   ax,ax
    2080:	endbr64
    2084:	push   0x5
    2089:	jmp    2020 <_init+0x20>
    208e:	xchg   ax,ax
    2090:	endbr64
    2094:	push   0x6
    2099:	jmp    2020 <_init+0x20>
    209e:	xchg   ax,ax
    20a0:	endbr64
    20a4:	push   0x7
    20a9:	jmp    2020 <_init+0x20>
    20ae:	xchg   ax,ax
    20b0:	endbr64
    20b4:	push   0x8
    20b9:	jmp    2020 <_init+0x20>
    20be:	xchg   ax,ax
    20c0:	endbr64
    20c4:	push   0x9
    20c9:	jmp    2020 <_init+0x20>
    20ce:	xchg   ax,ax
    20d0:	endbr64
    20d4:	push   0xa
    20d9:	jmp    2020 <_init+0x20>
    20de:	xchg   ax,ax
    20e0:	endbr64
    20e4:	push   0xb
    20e9:	jmp    2020 <_init+0x20>
    20ee:	xchg   ax,ax
    20f0:	endbr64
    20f4:	push   0xc
    20f9:	jmp    2020 <_init+0x20>
    20fe:	xchg   ax,ax
    2100:	endbr64
    2104:	push   0xd
    2109:	jmp    2020 <_init+0x20>
    210e:	xchg   ax,ax
    2110:	endbr64
    2114:	push   0xe
    2119:	jmp    2020 <_init+0x20>
    211e:	xchg   ax,ax
    2120:	endbr64
    2124:	push   0xf
    2129:	jmp    2020 <_init+0x20>
    212e:	xchg   ax,ax
    2130:	endbr64
    2134:	push   0x10
    2139:	jmp    2020 <_init+0x20>
    213e:	xchg   ax,ax
    2140:	endbr64
    2144:	push   0x11
    2149:	jmp    2020 <_init+0x20>
    214e:	xchg   ax,ax
    2150:	endbr64
    2154:	push   0x12
    2159:	jmp    2020 <_init+0x20>
    215e:	xchg   ax,ax
    2160:	endbr64
    2164:	push   0x13
    2169:	jmp    2020 <_init+0x20>
    216e:	xchg   ax,ax
    2170:	endbr64
    2174:	push   0x14
    2179:	jmp    2020 <_init+0x20>
    217e:	xchg   ax,ax
    2180:	endbr64
    2184:	push   0x15
    2189:	jmp    2020 <_init+0x20>
    218e:	xchg   ax,ax
    2190:	endbr64
    2194:	push   0x16
    2199:	jmp    2020 <_init+0x20>
    219e:	xchg   ax,ax
    21a0:	endbr64
    21a4:	push   0x17
    21a9:	jmp    2020 <_init+0x20>
    21ae:	xchg   ax,ax
    21b0:	endbr64
    21b4:	push   0x18
    21b9:	jmp    2020 <_init+0x20>
    21be:	xchg   ax,ax
    21c0:	endbr64
    21c4:	push   0x19
    21c9:	jmp    2020 <_init+0x20>
    21ce:	xchg   ax,ax
    21d0:	endbr64
    21d4:	push   0x1a
    21d9:	jmp    2020 <_init+0x20>
    21de:	xchg   ax,ax
    21e0:	endbr64
    21e4:	push   0x1b
    21e9:	jmp    2020 <_init+0x20>
    21ee:	xchg   ax,ax
    21f0:	endbr64
    21f4:	push   0x1c
    21f9:	jmp    2020 <_init+0x20>
    21fe:	xchg   ax,ax
    2200:	endbr64
    2204:	push   0x1d
    2209:	jmp    2020 <_init+0x20>
    220e:	xchg   ax,ax
    2210:	endbr64
    2214:	push   0x1e
    2219:	jmp    2020 <_init+0x20>
    221e:	xchg   ax,ax
    2220:	endbr64
    2224:	push   0x1f
    2229:	jmp    2020 <_init+0x20>
    222e:	xchg   ax,ax

Disassembly of section .plt.got:

0000000000002230 <__cxa_finalize@plt>:
    2230:	endbr64
    2234:	jmp    QWORD PTR [rip+0x3d9e]        # 5fd8 <__cxa_finalize@GLIBC_2.2.5>
    223a:	nop    WORD PTR [rax+rax*1+0x0]

Disassembly of section .plt.sec:

0000000000002240 <__printf_chk@plt>:
    2240:	endbr64
    2244:	jmp    QWORD PTR [rip+0x3c8e]        # 5ed8 <__printf_chk@GLIBC_2.3.4>
    224a:	nop    WORD PTR [rax+rax*1+0x0]

0000000000002250 <syscall@plt>:
    2250:	endbr64
    2254:	jmp    QWORD PTR [rip+0x3c86]        # 5ee0 <syscall@GLIBC_2.2.5>
    225a:	nop    WORD PTR [rax+rax*1+0x0]

0000000000002260 <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >::_M_append(char const*, unsigned long)@plt>:
    2260:	endbr64
    2264:	jmp    QWORD PTR [rip+0x3c7e]        # 5ee8 <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >::_M_append(char const*, unsigned long)@GLIBCXX_3.4.21>
    226a:	nop    WORD PTR [rax+rax*1+0x0]

0000000000002270 <strlen@plt>:
    2270:	endbr64
    2274:	jmp    QWORD PTR [rip+0x3c76]        # 5ef0 <strlen@GLIBC_2.2.5>
    227a:	nop    WORD PTR [rax+rax*1+0x0]

0000000000002280 <memcmp@plt>:
    2280:	endbr64
    2284:	jmp    QWORD PTR [rip+0x3c6e]        # 5ef8 <memcmp@GLIBC_2.2.5>
    228a:	nop    WORD PTR [rax+rax*1+0x0]

0000000000002290 <llround@plt>:
    2290:	endbr64
    2294:	jmp    QWORD PTR [rip+0x3c66]        # 5f00 <llround@GLIBC_2.2.5>
    229a:	nop    WORD PTR [rax+rax*1+0x0]

00000000000022a0 <std::__throw_length_error(char const*)@plt>:
    22a0:	endbr64
    22a4:	jmp    QWORD PTR [rip+0x3c5e]        # 5f08 <std::__throw_length_error(char const*)@GLIBCXX_3.4>
    22aa:	nop    WORD PTR [rax+rax*1+0x0]

00000000000022b0 <memset@plt>:
    22b0:	endbr64
    22b4:	jmp    QWORD PTR [rip+0x3c56]        # 5f10 <memset@GLIBC_2.2.5>
    22ba:	nop    WORD PTR [rax+rax*1+0x0]

00000000000022c0 <std::__throw_logic_error(char const*)@plt>:
    22c0:	endbr64
    22c4:	jmp    QWORD PTR [rip+0x3c4e]        # 5f18 <std::__throw_logic_error(char const*)@GLIBCXX_3.4>
    22ca:	nop    WORD PTR [rax+rax*1+0x0]

00000000000022d0 <aligned_alloc@plt>:
    22d0:	endbr64
    22d4:	jmp    QWORD PTR [rip+0x3c46]        # 5f20 <aligned_alloc@GLIBC_2.16>
    22da:	nop    WORD PTR [rax+rax*1+0x0]

00000000000022e0 <memcpy@plt>:
    22e0:	endbr64
    22e4:	jmp    QWORD PTR [rip+0x3c3e]        # 5f28 <memcpy@GLIBC_2.14>
    22ea:	nop    WORD PTR [rax+rax*1+0x0]

00000000000022f0 <perror@plt>:
    22f0:	endbr64
    22f4:	jmp    QWORD PTR [rip+0x3c36]        # 5f30 <perror@GLIBC_2.2.5>
    22fa:	nop    WORD PTR [rax+rax*1+0x0]

0000000000002300 <clock_gettime@plt>:
    2300:	endbr64
    2304:	jmp    QWORD PTR [rip+0x3c2e]        # 5f38 <clock_gettime@GLIBC_2.17>
    230a:	nop    WORD PTR [rax+rax*1+0x0]

0000000000002310 <operator new(unsigned long)@plt>:
    2310:	endbr64
    2314:	jmp    QWORD PTR [rip+0x3c26]        # 5f40 <operator new(unsigned long)@GLIBCXX_3.4>
    231a:	nop    WORD PTR [rax+rax*1+0x0]

0000000000002320 <operator delete(void*, unsigned long)@plt>:
    2320:	endbr64
    2324:	jmp    QWORD PTR [rip+0x3c1e]        # 5f48 <operator delete(void*, unsigned long)@CXXABI_1.3.9>
    232a:	nop    WORD PTR [rax+rax*1+0x0]

0000000000002330 <__stack_chk_fail@plt>:
    2330:	endbr64
    2334:	jmp    QWORD PTR [rip+0x3c16]        # 5f50 <__stack_chk_fail@GLIBC_2.4>
    233a:	nop    WORD PTR [rax+rax*1+0x0]

0000000000002340 <fflush@plt>:
    2340:	endbr64
    2344:	jmp    QWORD PTR [rip+0x3c0e]        # 5f58 <fflush@GLIBC_2.2.5>
    234a:	nop    WORD PTR [rax+rax*1+0x0]

0000000000002350 <free@plt>:
    2350:	endbr64
    2354:	jmp    QWORD PTR [rip+0x3c06]        # 5f60 <free@GLIBC_2.2.5>
    235a:	nop    WORD PTR [rax+rax*1+0x0]

0000000000002360 <madvise@plt>:
    2360:	endbr64
    2364:	jmp    QWORD PTR [rip+0x3bfe]        # 5f68 <madvise@GLIBC_2.2.5>
    236a:	nop    WORD PTR [rax+rax*1+0x0]

0000000000002370 <exit@plt>:
    2370:	endbr64
    2374:	jmp    QWORD PTR [rip+0x3bf6]        # 5f70 <exit@GLIBC_2.2.5>
    237a:	nop    WORD PTR [rax+rax*1+0x0]

0000000000002380 <getenv@plt>:
    2380:	endbr64
    2384:	jmp    QWORD PTR [rip+0x3bee]        # 5f78 <getenv@GLIBC_2.2.5>
    238a:	nop    WORD PTR [rax+rax*1+0x0]

0000000000002390 <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >::_M_dispose()@plt>:
    2390:	endbr64
    2394:	jmp    QWORD PTR [rip+0x3be6]        # 5f80 <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >::_M_dispose()@GLIBCXX_3.4.21>
    239a:	nop    WORD PTR [rax+rax*1+0x0]

00000000000023a0 <__memset_chk@plt>:
    23a0:	endbr64
    23a4:	jmp    QWORD PTR [rip+0x3bde]        # 5f88 <__memset_chk@GLIBC_2.3.4>
    23aa:	nop    WORD PTR [rax+rax*1+0x0]

00000000000023b0 <ioctl@plt>:
    23b0:	endbr64
    23b4:	jmp    QWORD PTR [rip+0x3bd6]        # 5f90 <ioctl@GLIBC_2.2.5>
    23ba:	nop    WORD PTR [rax+rax*1+0x0]

00000000000023c0 <read@plt>:
    23c0:	endbr64
    23c4:	jmp    QWORD PTR [rip+0x3bce]        # 5f98 <read@GLIBC_2.2.5>
    23ca:	nop    WORD PTR [rax+rax*1+0x0]

00000000000023d0 <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >::reserve(unsigned long)@plt>:
    23d0:	endbr64
    23d4:	jmp    QWORD PTR [rip+0x3bc6]        # 5fa0 <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >::reserve(unsigned long)@GLIBCXX_3.4.21>
    23da:	nop    WORD PTR [rax+rax*1+0x0]

00000000000023e0 <__fprintf_chk@plt>:
    23e0:	endbr64
    23e4:	jmp    QWORD PTR [rip+0x3bbe]        # 5fa8 <__fprintf_chk@GLIBC_2.3.4>
    23ea:	nop    WORD PTR [rax+rax*1+0x0]

00000000000023f0 <pow@plt>:
    23f0:	endbr64
    23f4:	jmp    QWORD PTR [rip+0x3bb6]        # 5fb0 <pow@GLIBC_2.29>
    23fa:	nop    WORD PTR [rax+rax*1+0x0]

0000000000002400 <_Unwind_Resume@plt>:
    2400:	endbr64
    2404:	jmp    QWORD PTR [rip+0x3bae]        # 5fb8 <_Unwind_Resume@GCC_3.0>
    240a:	nop    WORD PTR [rax+rax*1+0x0]

0000000000002410 <log2@plt>:
    2410:	endbr64
    2414:	jmp    QWORD PTR [rip+0x3ba6]        # 5fc0 <log2@GLIBC_2.29>
    241a:	nop    WORD PTR [rax+rax*1+0x0]

0000000000002420 <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >::_M_create(unsigned long&, unsigned long)@plt>:
    2420:	endbr64
    2424:	jmp    QWORD PTR [rip+0x3b9e]        # 5fc8 <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >::_M_create(unsigned long&, unsigned long)@GLIBCXX_3.4.21>
    242a:	nop    WORD PTR [rax+rax*1+0x0]

0000000000002430 <__isoc23_strtol@plt>:
    2430:	endbr64
    2434:	jmp    QWORD PTR [rip+0x3b96]        # 5fd0 <__isoc23_strtol@GLIBC_2.38>
    243a:	nop    WORD PTR [rax+rax*1+0x0]

Disassembly of section .text:

0000000000002440 <alloc_buffer(unsigned long, bool) [clone .part.0]>:
    2440:	push   rax
    2441:	pop    rax
    2442:	lea    rdi,[rip+0x1bbf]        # 4008 <_IO_stdin_used+0x8>
    2449:	push   rax
    244a:	call   22f0 <perror@plt>
    244f:	mov    edi,0x1
    2454:	call   2370 <exit@plt>

0000000000002459 <main.cold>:
    2459:	mov    rax,QWORD PTR [rbp-0x38]
    245d:	sub    rax,QWORD PTR fs:0x28
    2466:	jne    24a6 <main.cold+0x4d>
    2468:	call   2440 <alloc_buffer(unsigned long, bool) [clone .part.0]>
    246d:	mov    rax,QWORD PTR [rbp-0x38]
    2471:	sub    rax,QWORD PTR fs:0x28
    247a:	jne    24a6 <main.cold+0x4d>
    247c:	call   2440 <alloc_buffer(unsigned long, bool) [clone .part.0]>
    2481:	endbr64
    2485:	mov    rbx,rax
    2488:	vzeroupper
    248b:	mov    rdi,QWORD PTR [rbp-0xb70]
    2492:	call   2390 <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >::_M_dispose()@plt>
    2497:	mov    rax,QWORD PTR [rbp-0x38]
    249b:	sub    rax,QWORD PTR fs:0x28
    24a4:	je     24d7 <main.cold+0x7e>
    24a6:	call   2330 <__stack_chk_fail@plt>
    24ab:	mov    rdi,QWORD PTR [rbp-0xaf8]
    24b2:	vzeroupper
    24b5:	call   2390 <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >::_M_dispose()@plt>
    24ba:	mov    rdi,QWORD PTR [rbp-0xab0]
    24c1:	mov    rsi,QWORD PTR [rbp-0xaa0]
    24c8:	sub    rsi,rdi
    24cb:	test   rdi,rdi
    24ce:	je     248b <main.cold+0x32>
    24d0:	call   2320 <operator delete(void*, unsigned long)@plt>
    24d5:	jmp    248b <main.cold+0x32>
    24d7:	mov    rdi,rbx
    24da:	call   2400 <_Unwind_Resume@plt>
    24df:	mov    rax,QWORD PTR [rbp-0x38]
    24e3:	sub    rax,QWORD PTR fs:0x28
    24ec:	jne    24a6 <main.cold+0x4d>
    24ee:	call   2440 <alloc_buffer(unsigned long, bool) [clone .part.0]>
    24f3:	mov    rdi,QWORD PTR [rbp-0xaf8]
    24fa:	vzeroupper
    24fd:	call   2390 <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >::_M_dispose()@plt>
    2502:	jmp    24ba <main.cold+0x61>
    2504:	cs nop WORD PTR [rax+rax*1+0x0]
    250e:	xchg   ax,ax

0000000000002510 <main>:
    2510:	endbr64
    2514:	lea    r10,[rsp+0x8]
    2519:	and    rsp,0xffffffffffffffe0
    251d:	push   QWORD PTR [r10-0x8]
    2521:	push   rbp
    2522:	mov    rbp,rsp
    2525:	push   r15
    2527:	push   r14
    2529:	push   r13
    252b:	push   r12
    252d:	push   r10
    252f:	push   rbx
    2530:	sub    rsp,0xb80
    2537:	mov    rax,QWORD PTR fs:0x28
    2540:	mov    QWORD PTR [rbp-0x38],rax
    2544:	xor    eax,eax
    2546:	cmp    edi,0x1
    2549:	jle    2fc8 <main+0xab8>
    254f:	mov    r13,QWORD PTR [rsi+0x8]
    2553:	lea    rax,[rbp-0xa40]
    255a:	lea    r12,[rbp-0xa30]
    2561:	mov    QWORD PTR [rbp-0xb70],rax
    2568:	mov    QWORD PTR [rbp-0xa40],r12
    256f:	test   r13,r13
    2572:	je     302e <main+0xb1e>
    2578:	mov    rdi,r13
    257b:	call   2270 <strlen@plt>
    2580:	mov    QWORD PTR [rbp-0xa90],rax
    2587:	mov    rbx,rax
    258a:	cmp    rax,0xf
    258e:	ja     2c59 <main+0x749>
    2594:	cmp    rax,0x1
    2598:	jne    2fe7 <main+0xad7>
    259e:	movzx  eax,BYTE PTR [r13+0x0]
    25a3:	mov    BYTE PTR [rbp-0xa30],al
    25a9:	mov    rdx,QWORD PTR [rbp-0xa40]
    25b0:	mov    rax,QWORD PTR [rbp-0xa90]
    25b7:	xor    esi,esi
    25b9:	lea    rdi,[rip+0x1a6c]        # 402c <_IO_stdin_used+0x2c>
    25c0:	mov    QWORD PTR [rbp-0xa38],rax
    25c7:	mov    BYTE PTR [rdx+rax*1],0x0
    25cb:	call   3340 <env_long(char const*, long)>
    25d0:	mov    esi,0x5
    25d5:	lea    rdi,[rip+0x1a54]        # 4030 <_IO_stdin_used+0x30>
    25dc:	mov    QWORD PTR [rbp-0xb68],rax
    25e3:	call   3340 <env_long(char const*, long)>
    25e8:	mov    esi,0x4
    25ed:	lea    rdi,[rip+0x1a41]        # 4035 <_IO_stdin_used+0x35>
    25f4:	mov    DWORD PTR [rbp-0xb44],eax
    25fa:	call   3340 <env_long(char const*, long)>
    25ff:	mov    esi,0x400
    2604:	lea    rdi,[rip+0x1a31]        # 403c <_IO_stdin_used+0x3c>
    260b:	shl    rax,0xa
    260f:	mov    r12,rax
    2612:	call   3340 <env_long(char const*, long)>
    2617:	lea    rdi,[rip+0x1a25]        # 4043 <_IO_stdin_used+0x43>
    261e:	mov    esi,0x17d78400
    2623:	shl    rax,0x14
    2627:	mov    rbx,rax
    262a:	call   3340 <env_long(char const*, long)>
    262f:	vxorpd xmm2,xmm2,xmm2
    2633:	lea    rdi,[rbp-0xa50]
    263a:	vcvtsi2sd xmm0,xmm2,rax
    263f:	vmovsd QWORD PTR [rbp-0xb80],xmm0
    2647:	call   3740 <Counters::Counters()>
    264c:	lea    rsi,[rip+0x1ae5]        # 4138 <_IO_stdin_used+0x138>
    2653:	mov    edi,0x2
    2658:	xor    eax,eax
    265a:	call   2240 <__printf_chk@plt>
    265f:	lea    rdi,[rbp-0xa00]
    2666:	mov    QWORD PTR [rbp-0xa00],0x7
    2671:	mov    eax,0x7
    2676:	mov    ecx,0x1
    267b:	mov    QWORD PTR [rbp-0xb98],rdi
    2682:	movabs rsi,0x5851f42d4c957f2d
    268c:	mov    rdx,rax
    268f:	nop
    2690:	mov    rax,rdx
    2693:	shr    rax,0x3e
    2697:	xor    rax,rdx
    269a:	imul   rax,rsi
    269e:	lea    rdx,[rax+rcx*1]
    26a2:	mov    QWORD PTR [rdi+rcx*8],rdx
    26a6:	inc    rcx
    26a9:	cmp    rcx,0x138
    26b0:	jne    2690 <main+0x180>
    26b2:	mov    rdi,QWORD PTR [rbp-0xb70]
    26b9:	lea    rsi,[rip+0x1995]        # 4055 <_IO_stdin_used+0x55>
    26c0:	mov    QWORD PTR [rbp-0x40],0x138
    26c8:	call   38c0 <bool std::operator==<char, std::char_traits<char>, std::allocator<char> >(std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > const&, char const*)>
    26cd:	mov    DWORD PTR [rbp-0xb48],0x2
    26d7:	test   al,al
    26d9:	jne    26fe <main+0x1ee>
    26db:	mov    rdi,QWORD PTR [rbp-0xb70]
    26e2:	lea    rsi,[rip+0x1933]        # 401c <_IO_stdin_used+0x1c>
    26e9:	call   38c0 <bool std::operator==<char, std::char_traits<char>, std::allocator<char> >(std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > const&, char const*)>
    26ee:	cmp    al,0x1
    26f0:	sbb    eax,eax
    26f2:	and    eax,0xfffffffe
    26f5:	add    eax,0x3
    26f8:	mov    DWORD PTR [rbp-0xb48],eax
    26fe:	vxorpd xmm5,xmm5,xmm5
    2702:	vcvtusi2sd xmm0,xmm5,r12
    2708:	call   2410 <log2@plt>
    270d:	lea    rdx,[rip+0x1946]        # 405a <_IO_stdin_used+0x5a>
    2714:	cmp    QWORD PTR [rbp-0xb68],0x0
    271c:	lea    rax,[rip+0x193c]        # 405f <_IO_stdin_used+0x5f>
    2723:	vxorpd xmm5,xmm5,xmm5
    2727:	cmovne rax,rdx
    272b:	vmovsd QWORD PTR [rbp-0xb60],xmm0
    2733:	lea    rdx,[rbp-0xad0]
    273a:	vcvtusi2sd xmm0,xmm5,rbx
    2740:	vmovq  xmm4,rdx
    2745:	mov    QWORD PTR [rbp-0xb00],rax
    274c:	lea    rax,[rbp-0xac8]
    2753:	vpinsrq xmm3,xmm4,rax,0x1
    2759:	vmovdqa XMMWORD PTR [rbp-0xb90],xmm3
    2761:	vmovsd QWORD PTR [rbp-0xb78],xmm0
    2769:	nop    DWORD PTR [rax+0x0]
    2770:	vmovsd xmm0,QWORD PTR [rbp-0xb78]
    2778:	call   2410 <log2@plt>
    277d:	vaddsd xmm0,xmm0,QWORD PTR [rip+0x1a83]        # 4208 <_IO_stdin_used+0x208>
    2785:	vcomisd xmm0,QWORD PTR [rbp-0xb60]
    278d:	jb     2f65 <main+0xa55>
    2793:	vmovsd xmm1,QWORD PTR [rbp-0xb60]
    279b:	vmovsd xmm0,QWORD PTR [rip+0x1a3d]        # 41e0 <_IO_stdin_used+0x1e0>
    27a3:	mov    r14d,0x200
    27a9:	call   23f0 <pow@plt>
    27ae:	call   2290 <llround@plt>
    27b3:	movsxd rbx,DWORD PTR [rbp-0xb48]
    27ba:	xor    edx,edx
    27bc:	div    rbx
    27bf:	and    rax,0xfffffffffffffe00
    27c5:	cmp    rax,r14
    27c8:	mov    r13,rax
    27cb:	cmovae r14,rax
    27cf:	mov    rax,r14
    27d2:	shr    rax,0x2
    27d6:	cmp    QWORD PTR [rbp-0xb68],0x0
    27de:	mov    QWORD PTR [rbp-0xae0],rax
    27e5:	je     2d10 <main+0x800>
    27eb:	lea    r12,[r14+0x1fffff]
    27f2:	mov    edi,0x200000
    27f7:	and    r12,0xffffffffffe00000
    27fe:	mov    rsi,r12
    2801:	call   22d0 <aligned_alloc@plt>
    2806:	mov    r15,rax
    2809:	test   rax,rax
    280c:	je     3063 <main+0xb53>
    2812:	mov    edx,0xe
    2817:	mov    rsi,r12
    281a:	mov    rdi,r15
    281d:	call   2360 <madvise@plt>
    2822:	mov    QWORD PTR [rbp-0xaf8],0x200000
    282d:	mov    rcx,r12
    2830:	mov    rdx,r12
    2833:	mov    esi,0x1
    2838:	mov    rdi,r15
    283b:	call   23a0 <__memset_chk@plt>
    2840:	cmp    DWORD PTR [rbp-0xb48],0x1
    2847:	mov    QWORD PTR [rbp-0xad8],r15
    284e:	jne    2d50 <main+0x840>
    2854:	mov    QWORD PTR [rbp-0xad0],0x0
    285f:	xor    r15d,r15d
    2862:	imul   rbx,r14
    2866:	vpxor  xmm0,xmm0,xmm0
    286a:	cmp    QWORD PTR [rbp-0xa38],0x9
    2872:	mov    QWORD PTR [rbp-0xac8],r15
    2879:	mov    QWORD PTR [rbp-0xaa0],0x0
    2884:	vmovdqa XMMWORD PTR [rbp-0xab0],xmm0
    288c:	mov    QWORD PTR [rbp-0xb40],rbx
    2893:	je     2de8 <main+0x8d8>
    2899:	vxorpd xmm5,xmm5,xmm5
    289d:	vcvtusi2sd xmm0,xmm5,QWORD PTR [rbp-0xb40]
    28a7:	vmovsd QWORD PTR [rbp-0xb38],xmm0
    28af:	vmovq  xmm2,QWORD PTR [rbp-0xb70]
    28b7:	lea    rcx,[rbp-0xae0]
    28be:	vmovsd xmm3,QWORD PTR [rbp-0xb80]
    28c6:	lea    rax,[rbp-0xad8]
    28cd:	vmovq  xmm1,rcx
    28d2:	lea    rdx,[rbp-0xae4]
    28d9:	mov    r11d,0x1
    28df:	vpinsrq xmm1,xmm1,rdx,0x1
    28e5:	vpinsrq xmm0,xmm2,rax,0x1
    28eb:	vinserti128 ymm0,ymm0,xmm1,0x1
    28f1:	vdivsd xmm1,xmm3,QWORD PTR [rbp-0xb38]
    28f9:	vrndscalesd xmm1,xmm1,xmm1,0xa
    2900:	vcomisd xmm1,QWORD PTR [rip+0x18e8]        # 41f0 <_IO_stdin_used+0x1f0>
    2908:	jbe    290e <main+0x3fe>
    290a:	vcvttsd2si r11d,xmm1
    290e:	lea    rax,[rbp-0xab0]
    2915:	vmovdqa xmm2,XMMWORD PTR [rbp-0xb90]
    291d:	mov    DWORD PTR [rbp-0xae4],0x1
    2927:	mov    QWORD PTR [rbp-0xa60],rax
    292e:	lea    rax,[rbp-0xa90]
    2935:	mov    QWORD PTR [rbp-0xb50],rax
    293c:	mov    rdi,rax
    293f:	vmovdqa YMMWORD PTR [rbp-0xa90],ymm0
    2947:	vmovdqa XMMWORD PTR [rbp-0xa70],xmm2
    294f:	vzeroupper
    2952:	call   3590 <main::{lambda()#1}::operator()() const>
    2957:	mov    eax,DWORD PTR [rbp-0xb44]
    295d:	mov    DWORD PTR [rbp-0xae4],r11d
    2964:	test   eax,eax
    2966:	jle    2ca0 <main+0x790>
    296c:	lea    rax,[rbp-0xac0]
    2973:	xor    r12d,r12d
    2976:	mov    QWORD PTR [rbp-0xb58],rax
    297d:	lea    rax,[rbp-0xa20]
    2984:	mov    QWORD PTR [rbp-0xaf8],rax
    298b:	jmp    2b31 <main+0x621>
    2990:	mov    QWORD PTR [rbp-0xb20],0x0
    299b:	mov    QWORD PTR [rbp-0xb30],0x0
    29a6:	mov    QWORD PTR [rbp-0xb28],0x0
    29b1:	vmovq  xmm5,rbx
    29b6:	movsxd rbx,DWORD PTR [rbp-0xae4]
    29bd:	vxorpd xmm4,xmm4,xmm4
    29c1:	vmovq  xmm3,r13
    29c6:	vsubsd xmm7,xmm5,xmm3
    29ca:	mov    rax,QWORD PTR [rbp-0xa40]
    29d1:	mov    rdi,QWORD PTR [rbp-0xb00]
    29d8:	lea    r15,[rbp-0xa10]
    29df:	vcvtsi2sd xmm0,xmm4,ebx
    29e3:	mov    r14,QWORD PTR [rbp-0xa38]
    29ea:	mov    QWORD PTR [rbp-0xb10],rax
    29f1:	vmovsd QWORD PTR [rbp-0xb18],xmm7
    29f9:	vmulsd xmm2,xmm0,QWORD PTR [rbp-0xb38]
    2a01:	vmovsd QWORD PTR [rbp-0xb08],xmm2
    2a09:	call   2270 <strlen@plt>
    2a0e:	mov    rdi,QWORD PTR [rbp-0xaf8]
    2a15:	mov    QWORD PTR [rbp-0xa20],r15
    2a1c:	lea    rsi,[r14+rax*1]
    2a20:	mov    QWORD PTR [rbp-0xa18],0x0
    2a2b:	mov    r13,rax
    2a2e:	mov    BYTE PTR [rbp-0xa10],0x0
    2a35:	call   23d0 <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >::reserve(unsigned long)@plt>
    2a3a:	movabs rax,0x3fffffffffffffff
    2a44:	sub    rax,QWORD PTR [rbp-0xa18]
    2a4b:	cmp    rax,r14
    2a4e:	jb     3013 <main+0xb03>
    2a54:	mov    rsi,QWORD PTR [rbp-0xb10]
    2a5b:	mov    rdi,QWORD PTR [rbp-0xaf8]
    2a62:	mov    rdx,r14
    2a65:	call   2260 <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >::_M_append(char const*, unsigned long)@plt>
    2a6a:	movabs rax,0x3fffffffffffffff
    2a74:	sub    rax,QWORD PTR [rbp-0xa18]
    2a7b:	cmp    rax,r13
    2a7e:	jb     2ff8 <main+0xae8>
    2a84:	mov    rsi,QWORD PTR [rbp-0xb00]
    2a8b:	mov    rdi,QWORD PTR [rbp-0xaf8]
    2a92:	mov    rdx,r13
    2a95:	call   2260 <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >::_M_append(char const*, unsigned long)@plt>
    2a9a:	lea    rax,[rip+0x15dd]        # 407e <_IO_stdin_used+0x7e>
    2aa1:	vmovsd xmm1,QWORD PTR [rbp-0xb08]
    2aa9:	vmovsd xmm0,QWORD PTR [rbp-0xb18]
    2ab1:	mov    r9,rbx
    2ab4:	push   rax
    2ab5:	mov    r8,QWORD PTR [rbp-0xb40]
    2abc:	lea    rdx,[rip+0x15b5]        # 4078 <_IO_stdin_used+0x78>
    2ac3:	lea    rsi,[rip+0x16ce]        # 4198 <_IO_stdin_used+0x198>
    2aca:	mov    edi,0x2
    2acf:	mov    eax,0x2
    2ad4:	push   QWORD PTR [rbp-0xb20]
    2ada:	mov    rcx,QWORD PTR [rbp-0xa20]
    2ae1:	push   QWORD PTR [rbp-0xb30]
    2ae7:	push   QWORD PTR [rbp-0xb28]
    2aed:	push   rbx
    2aee:	push   r12
    2af0:	call   2240 <__printf_chk@plt>
    2af5:	mov    rdi,QWORD PTR [rip+0x3524]        # 6020 <stdout@GLIBC_2.2.5>
    2afc:	add    rsp,0x30
    2b00:	call   2340 <fflush@plt>
    2b05:	mov    rdi,QWORD PTR [rbp-0xa20]
    2b0c:	cmp    rdi,r15
    2b0f:	je     2b21 <main+0x611>
    2b11:	mov    rax,QWORD PTR [rbp-0xa10]
    2b18:	lea    rsi,[rax+0x1]
    2b1c:	call   2320 <operator delete(void*, unsigned long)@plt>
    2b21:	inc    r12d
    2b24:	cmp    DWORD PTR [rbp-0xb44],r12d
    2b2b:	je     2ca0 <main+0x790>
    2b31:	cmp    BYTE PTR [rbp-0xa44],0x0
    2b38:	je     2b68 <main+0x658>
    2b3a:	mov    edi,DWORD PTR [rbp-0xa50]
    2b40:	mov    edx,0x1
    2b45:	mov    esi,0x2403
    2b4a:	xor    eax,eax
    2b4c:	call   23b0 <ioctl@plt>
    2b51:	mov    edi,DWORD PTR [rbp-0xa50]
    2b57:	mov    edx,0x1
    2b5c:	mov    esi,0x2400
    2b61:	xor    eax,eax
    2b63:	call   23b0 <ioctl@plt>
    2b68:	mov    rbx,QWORD PTR [rbp-0xb58]
    2b6f:	mov    edi,0x4
    2b74:	mov    rsi,rbx
    2b77:	call   2300 <clock_gettime@plt>
    2b7c:	vxorpd xmm6,xmm6,xmm6
    2b80:	mov    rdi,QWORD PTR [rbp-0xb50]
    2b87:	vcvtsi2sd xmm0,xmm6,QWORD PTR [rbp-0xac0]
    2b90:	vmovsd xmm1,xmm0,xmm0
    2b94:	vcvtsi2sd xmm0,xmm6,QWORD PTR [rbp-0xab8]
    2b9d:	vfmadd132sd xmm1,xmm0,QWORD PTR [rip+0x1652]        # 41f8 <_IO_stdin_used+0x1f8>
    2ba6:	vmovq  r13,xmm1
    2bab:	call   3590 <main::{lambda()#1}::operator()() const>
    2bb0:	mov    rsi,rbx
    2bb3:	mov    edi,0x4
    2bb8:	call   2300 <clock_gettime@plt>
    2bbd:	vxorpd xmm6,xmm6,xmm6
    2bc1:	cmp    BYTE PTR [rbp-0xa44],0x0
    2bc8:	vcvtsi2sd xmm0,xmm6,QWORD PTR [rbp-0xac0]
    2bd1:	vmovsd xmm1,xmm0,xmm0
    2bd5:	vcvtsi2sd xmm0,xmm6,QWORD PTR [rbp-0xab8]
    2bde:	vfmadd132sd xmm1,xmm0,QWORD PTR [rip+0x1611]        # 41f8 <_IO_stdin_used+0x1f8>
    2be7:	vmovq  rbx,xmm1
    2bec:	je     2990 <main+0x480>
    2bf2:	mov    edi,DWORD PTR [rbp-0xa50]
    2bf8:	mov    edx,0x1
    2bfd:	mov    esi,0x2401
    2c02:	xor    eax,eax
    2c04:	call   23b0 <ioctl@plt>
    2c09:	mov    rsi,QWORD PTR [rbp-0xaf8]
    2c10:	mov    edi,DWORD PTR [rbp-0xa50]
    2c16:	mov    edx,0x20
    2c1b:	call   23c0 <read@plt>
    2c20:	cmp    rax,0x20
    2c24:	jne    2990 <main+0x480>
    2c2a:	mov    rax,QWORD PTR [rbp-0xa18]
    2c31:	mov    QWORD PTR [rbp-0xb28],rax
    2c38:	mov    rax,QWORD PTR [rbp-0xa10]
    2c3f:	mov    QWORD PTR [rbp-0xb30],rax
    2c46:	mov    rax,QWORD PTR [rbp-0xa08]
    2c4d:	mov    QWORD PTR [rbp-0xb20],rax
    2c54:	jmp    29b1 <main+0x4a1>
    2c59:	mov    rdi,QWORD PTR [rbp-0xb70]
    2c60:	lea    rsi,[rbp-0xa90]
    2c67:	xor    edx,edx
    2c69:	call   2420 <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >::_M_create(unsigned long&, unsigned long)@plt>
    2c6e:	mov    QWORD PTR [rbp-0xa40],rax
    2c75:	mov    rdi,rax
    2c78:	mov    rax,QWORD PTR [rbp-0xa90]
    2c7f:	mov    QWORD PTR [rbp-0xa30],rax
    2c86:	mov    rdx,rbx
    2c89:	mov    rsi,r13
    2c8c:	call   22e0 <memcpy@plt>
    2c91:	jmp    25a9 <main+0x99>
    2c96:	cs nop WORD PTR [rax+rax*1+0x0]
    2ca0:	mov    rdi,QWORD PTR [rbp-0xad8]
    2ca7:	call   2350 <free@plt>
    2cac:	mov    rdi,QWORD PTR [rbp-0xad0]
    2cb3:	test   rdi,rdi
    2cb6:	je     2cbd <main+0x7ad>
    2cb8:	call   2350 <free@plt>
    2cbd:	mov    rdi,QWORD PTR [rbp-0xac8]
    2cc4:	test   rdi,rdi
    2cc7:	je     2cce <main+0x7be>
    2cc9:	call   2350 <free@plt>
    2cce:	mov    rdi,QWORD PTR [rbp-0xab0]
    2cd5:	test   rdi,rdi
    2cd8:	je     2ce9 <main+0x7d9>
    2cda:	mov    rsi,QWORD PTR [rbp-0xaa0]
    2ce1:	sub    rsi,rdi
    2ce4:	call   2320 <operator delete(void*, unsigned long)@plt>
    2ce9:	vmovsd xmm4,QWORD PTR [rbp-0xb60]
    2cf1:	vaddsd xmm3,xmm4,QWORD PTR [rip+0x1507]        # 4200 <_IO_stdin_used+0x200>
    2cf9:	vmovsd QWORD PTR [rbp-0xb60],xmm3
    2d01:	jmp    2770 <main+0x260>
    2d06:	cs nop WORD PTR [rax+rax*1+0x0]
    2d10:	lea    r12,[r14+0xfff]
    2d17:	mov    edi,0x1000
    2d1c:	and    r12,0xfffffffffffff000
    2d23:	mov    rsi,r12
    2d26:	call   22d0 <aligned_alloc@plt>
    2d2b:	mov    r15,rax
    2d2e:	test   rax,rax
    2d31:	je     2459 <main.cold>
    2d37:	mov    QWORD PTR [rbp-0xaf8],0x1000
    2d42:	jmp    282d <main+0x31d>
    2d47:	nop    WORD PTR [rax+rax*1+0x0]
    2d50:	mov    rdi,QWORD PTR [rbp-0xaf8]
    2d57:	mov    rsi,r12
    2d5a:	call   22d0 <aligned_alloc@plt>
    2d5f:	mov    r15,rax
    2d62:	test   rax,rax
    2d65:	je     246d <main.cold+0x14>
    2d6b:	cmp    QWORD PTR [rbp-0xb68],0x0
    2d73:	jne    2f50 <main+0xa40>
    2d79:	mov    rcx,r12
    2d7c:	mov    rdx,r12
    2d7f:	mov    esi,0x1
    2d84:	mov    rdi,r15
    2d87:	call   23a0 <__memset_chk@plt>
    2d8c:	cmp    DWORD PTR [rbp-0xb48],0x3
    2d93:	mov    QWORD PTR [rbp-0xad0],r15
    2d9a:	jne    285f <main+0x34f>
    2da0:	mov    rdi,QWORD PTR [rbp-0xaf8]
    2da7:	mov    rsi,r12
    2daa:	call   22d0 <aligned_alloc@plt>
    2daf:	mov    r15,rax
    2db2:	test   rax,rax
    2db5:	je     24df <main.cold+0x86>
    2dbb:	cmp    QWORD PTR [rbp-0xb68],0x0
    2dc3:	jne    2fae <main+0xa9e>
    2dc9:	mov    rcx,r12
    2dcc:	mov    rdx,r12
    2dcf:	mov    esi,0x1
    2dd4:	mov    rdi,r15
    2dd7:	call   23a0 <__memset_chk@plt>
    2ddc:	jmp    2862 <main+0x352>
    2de1:	nop    DWORD PTR [rax+0x0]
    2de8:	mov    rdi,QWORD PTR [rbp-0xa40]
    2def:	mov    edx,0x9
    2df4:	lea    rsi,[rip+0x1227]        # 4022 <_IO_stdin_used+0x22>
    2dfb:	call   2280 <memcmp@plt>
    2e00:	test   eax,eax
    2e02:	jne    2899 <main+0x389>
    2e08:	shr    r14,0x6
    2e0c:	cmp    r13,0x1000003f
    2e13:	ja     2f9b <main+0xa8b>
    2e19:	mov    r13d,0x4000
    2e1f:	mov    r12d,0x1000
    2e25:	cmp    r14,0xfff
    2e2c:	ja     2fc3 <main+0xab3>
    2e32:	mov    rdi,r13
    2e35:	call   2310 <operator new(unsigned long)@plt>
    2e3a:	xor    edx,edx
    2e3c:	lea    rdi,[rax+0x4]
    2e40:	xor    esi,esi
    2e42:	mov    r15,rax
    2e45:	mov    DWORD PTR [rax],edx
    2e47:	lea    rdx,[r12*4-0x4]
    2e4f:	add    r13,r15
    2e52:	call   22b0 <memset@plt>
    2e57:	lea    eax,[r14-0x1]
    2e5b:	vmovq  xmm5,r15
    2e60:	mov    QWORD PTR [rbp-0xaa0],r13
    2e67:	lea    r12,[rax+0x1]
    2e6b:	not    rax
    2e6e:	vpinsrq xmm0,xmm5,r13,0x1
    2e74:	mov    rbx,QWORD PTR [rbp-0xb98]
    2e7b:	mov    QWORD PTR [rbp-0xaf8],rax
    2e82:	vmovdqa XMMWORD PTR [rbp-0xab0],xmm0
    2e8a:	nop    WORD PTR [rax+rax*1+0x0]
    2e90:	mov    rdi,rbx
    2e93:	call   3a50 <std::mersenne_twister_engine<unsigned long, 64ul, 312ul, 156ul, 31ul, 13043109905998158313ul, 29ul, 6148914691236517205ul, 17ul, 8202884508482404352ul, 37ul, 18444473444759240704ul, 43ul, 6364136223846793005ul>::operator()()>
    2e98:	mov    rdx,r12
    2e9b:	mulx   rdi,rsi,rax
    2ea0:	cmp    rsi,r12
    2ea3:	jae    2ed5 <main+0x9c5>
    2ea5:	mov    rax,QWORD PTR [rbp-0xaf8]
    2eac:	xor    edx,edx
    2eae:	div    r12
    2eb1:	mov    r14,rdx
    2eb4:	cmp    rsi,rdx
    2eb7:	jae    2ed5 <main+0x9c5>
    2eb9:	nop    DWORD PTR [rax+0x0]
    2ec0:	mov    rdi,rbx
    2ec3:	call   3a50 <std::mersenne_twister_engine<unsigned long, 64ul, 312ul, 156ul, 31ul, 13043109905998158313ul, 29ul, 6148914691236517205ul, 17ul, 8202884508482404352ul, 37ul, 18444473444759240704ul, 43ul, 6364136223846793005ul>::operator()()>
    2ec8:	mov    rdx,r12
    2ecb:	mulx   rdi,rsi,rax
    2ed0:	cmp    rsi,r14
    2ed3:	jb     2ec0 <main+0x9b0>
    2ed5:	mov    rax,rdi
    2ed8:	add    r15,0x4
    2edc:	shl    eax,0x4
    2edf:	mov    DWORD PTR [r15-0x4],eax
    2ee3:	cmp    r13,r15
    2ee6:	jne    2e90 <main+0x980>
    2ee8:	cmp    QWORD PTR [rbp-0xa38],0x9
    2ef0:	jne    2899 <main+0x389>
    2ef6:	mov    rax,QWORD PTR [rbp-0xa40]
    2efd:	movabs rdx,0x6165725f646e6172
    2f07:	cmp    QWORD PTR [rax],rdx
    2f0a:	jne    2899 <main+0x389>
    2f10:	cmp    BYTE PTR [rax+0x8],0x64
    2f14:	jne    2899 <main+0x389>
    2f1a:	mov    rax,QWORD PTR [rbp-0xaa8]
    2f21:	vxorpd xmm3,xmm3,xmm3
    2f25:	sub    rax,QWORD PTR [rbp-0xab0]
    2f2c:	sar    rax,0x2
    2f30:	vcvtusi2sd xmm0,xmm3,rax
    2f36:	vmulsd xmm4,xmm0,QWORD PTR [rip+0x12aa]        # 41e8 <_IO_stdin_used+0x1e8>
    2f3e:	vmovsd QWORD PTR [rbp-0xb38],xmm4
    2f46:	jmp    28af <main+0x39f>
    2f4b:	nop    DWORD PTR [rax+rax*1+0x0]
    2f50:	mov    edx,0xe
    2f55:	mov    rsi,r12
    2f58:	mov    rdi,rax
    2f5b:	call   2360 <madvise@plt>
    2f60:	jmp    2d79 <main+0x869>
    2f65:	mov    rdi,QWORD PTR [rbp-0xb70]
    2f6c:	call   2390 <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >::_M_dispose()@plt>
    2f71:	xor    eax,eax
    2f73:	mov    rdx,QWORD PTR [rbp-0x38]
    2f77:	sub    rdx,QWORD PTR fs:0x28
    2f80:	jne    3049 <main+0xb39>
    2f86:	lea    rsp,[rbp-0x30]
    2f8a:	pop    rbx
    2f8b:	pop    r10
    2f8d:	pop    r12
    2f8f:	pop    r13
    2f91:	pop    r14
    2f93:	pop    r15
    2f95:	pop    rbp
    2f96:	lea    rsp,[r10-0x8]
    2f9a:	ret
    2f9b:	mov    r12d,0x400000
    2fa1:	lea    r13,[r12*4+0x0]
    2fa9:	jmp    2e32 <main+0x922>
    2fae:	mov    edx,0xe
    2fb3:	mov    rsi,r12
    2fb6:	mov    rdi,rax
    2fb9:	call   2360 <madvise@plt>
    2fbe:	jmp    2dc9 <main+0x8b9>
    2fc3:	mov    r12,r14
    2fc6:	jmp    2fa1 <main+0xa91>
    2fc8:	mov    rdi,QWORD PTR [rip+0x3071]        # 6040 <stderr@GLIBC_2.2.5>
    2fcf:	lea    rdx,[rip+0x10ea]        # 40c0 <_IO_stdin_used+0xc0>
    2fd6:	mov    esi,0x2
    2fdb:	call   23e0 <__fprintf_chk@plt>
    2fe0:	mov    eax,0x1
    2fe5:	jmp    2f73 <main+0xa63>
    2fe7:	test   rax,rax
    2fea:	je     25a9 <main+0x99>
    2ff0:	mov    rdi,r12
    2ff3:	jmp    2c86 <main+0x776>
    2ff8:	mov    rax,QWORD PTR [rbp-0x38]
    2ffc:	sub    rax,QWORD PTR fs:0x28
    3005:	jne    3049 <main+0xb39>
    3007:	lea    rdi,[rip+0x1055]        # 4063 <_IO_stdin_used+0x63>
    300e:	call   22a0 <std::__throw_length_error(char const*)@plt>
    3013:	mov    rax,QWORD PTR [rbp-0x38]
    3017:	sub    rax,QWORD PTR fs:0x28
    3020:	jne    3049 <main+0xb39>
    3022:	lea    rdi,[rip+0x103a]        # 4063 <_IO_stdin_used+0x63>
    3029:	call   22a0 <std::__throw_length_error(char const*)@plt>
    302e:	mov    rax,QWORD PTR [rbp-0x38]
    3032:	sub    rax,QWORD PTR fs:0x28
    303b:	jne    3049 <main+0xb39>
    303d:	lea    rdi,[rip+0x10bc]        # 4100 <_IO_stdin_used+0x100>
    3044:	call   22c0 <std::__throw_logic_error(char const*)@plt>
    3049:	call   2330 <__stack_chk_fail@plt>
    304e:	endbr64
    3052:	jmp    2485 <main.cold+0x2c>
    3057:	endbr64
    305b:	mov    rbx,rax
    305e:	jmp    24ab <main.cold+0x52>
    3063:	jmp    2459 <main.cold>
    3068:	endbr64
    306c:	mov    rbx,rax
    306f:	vzeroupper
    3072:	jmp    24ba <main.cold+0x61>
    3077:	endbr64
    307b:	mov    rbx,rax
    307e:	jmp    24f3 <main.cold+0x9a>
    3083:	cs nop WORD PTR [rax+rax*1+0x0]
    308d:	nop    DWORD PTR [rax]

0000000000003090 <_start>:
    3090:	endbr64
    3094:	xor    ebp,ebp
    3096:	mov    r9,rdx
    3099:	pop    rsi
    309a:	mov    rdx,rsp
    309d:	and    rsp,0xfffffffffffffff0
    30a1:	push   rax
    30a2:	push   rsp
    30a3:	xor    r8d,r8d
    30a6:	xor    ecx,ecx
    30a8:	lea    rdi,[rip+0xfffffffffffff461]        # 2510 <main>
    30af:	call   QWORD PTR [rip+0x2f2b]        # 5fe0 <__libc_start_main@GLIBC_2.34>
    30b5:	hlt
    30b6:	cs nop WORD PTR [rax+rax*1+0x0]

00000000000030c0 <deregister_tm_clones>:
    30c0:	lea    rdi,[rip+0x2f51]        # 6018 <__TMC_END__>
    30c7:	lea    rax,[rip+0x2f4a]        # 6018 <__TMC_END__>
    30ce:	cmp    rax,rdi
    30d1:	je     30e8 <deregister_tm_clones+0x28>
    30d3:	mov    rax,QWORD PTR [rip+0x2f0e]        # 5fe8 <_ITM_deregisterTMCloneTable@Base>
    30da:	test   rax,rax
    30dd:	je     30e8 <deregister_tm_clones+0x28>
    30df:	jmp    rax
    30e1:	nop    DWORD PTR [rax+0x0]
    30e8:	ret
    30e9:	nop    DWORD PTR [rax+0x0]

00000000000030f0 <register_tm_clones>:
    30f0:	lea    rdi,[rip+0x2f21]        # 6018 <__TMC_END__>
    30f7:	lea    rsi,[rip+0x2f1a]        # 6018 <__TMC_END__>
    30fe:	sub    rsi,rdi
    3101:	mov    rax,rsi
    3104:	shr    rsi,0x3f
    3108:	sar    rax,0x3
    310c:	add    rsi,rax
    310f:	sar    rsi,1
    3112:	je     3128 <register_tm_clones+0x38>
    3114:	mov    rax,QWORD PTR [rip+0x2edd]        # 5ff8 <_ITM_registerTMCloneTable@Base>
    311b:	test   rax,rax
    311e:	je     3128 <register_tm_clones+0x38>
    3120:	jmp    rax
    3122:	nop    WORD PTR [rax+rax*1+0x0]
    3128:	ret
    3129:	nop    DWORD PTR [rax+0x0]

0000000000003130 <__do_global_dtors_aux>:
    3130:	endbr64
    3134:	cmp    BYTE PTR [rip+0x2f0d],0x0        # 6048 <completed.0>
    313b:	jne    3168 <__do_global_dtors_aux+0x38>
    313d:	push   rbp
    313e:	cmp    QWORD PTR [rip+0x2e92],0x0        # 5fd8 <__cxa_finalize@GLIBC_2.2.5>
    3146:	mov    rbp,rsp
    3149:	je     3157 <__do_global_dtors_aux+0x27>
    314b:	mov    rdi,QWORD PTR [rip+0x2eb6]        # 6008 <__dso_handle>
    3152:	call   2230 <__cxa_finalize@plt>
    3157:	call   30c0 <deregister_tm_clones>
    315c:	mov    BYTE PTR [rip+0x2ee5],0x1        # 6048 <completed.0>
    3163:	pop    rbp
    3164:	ret
    3165:	nop    DWORD PTR [rax]
    3168:	ret
    3169:	nop    DWORD PTR [rax+0x0]

0000000000003170 <frame_dummy>:
    3170:	endbr64
    3174:	jmp    30f0 <register_tm_clones>
    3179:	nop    DWORD PTR [rax+0x0]

0000000000003180 <k_write(float*, unsigned long, int)>:
    3180:	test   edx,edx
    3182:	jle    320b <k_write(float*, unsigned long, int)+0x8b>
    3188:	lea    rax,[rsi*4-0x4]
    3190:	xor    r8d,r8d
    3193:	xor    al,al
    3195:	lea    rcx,[rdi+rax*1+0x100]
    319d:	test   rsi,rsi
    31a0:	je     31f8 <k_write(float*, unsigned long, int)+0x78>
    31a2:	vxorps xmm1,xmm1,xmm1
    31a6:	vxorps xmm0,xmm0,xmm0
    31aa:	nop    WORD PTR [rax+rax*1+0x0]
    31b0:	mov    rax,rdi
    31b3:	nop    DWORD PTR [rax+rax*1+0x0]
    31b8:	vmovaps ZMMWORD PTR [rax],zmm0
    31be:	add    rax,0x100
    31c4:	vmovaps ZMMWORD PTR [rax-0xc0],zmm0
    31cb:	vmovaps ZMMWORD PTR [rax-0x80],zmm0
    31d2:	vmovaps ZMMWORD PTR [rax-0x40],zmm0
    31d9:	cmp    rax,rcx
    31dc:	jne    31b8 <k_write(float*, unsigned long, int)+0x38>
    31de:	inc    r8d
    31e1:	cmp    r8d,edx
    31e4:	je     3208 <k_write(float*, unsigned long, int)+0x88>
    31e6:	vcvtsi2ss xmm0,xmm1,r8d
    31eb:	vbroadcastss zmm0,xmm0
    31f1:	jmp    31b0 <k_write(float*, unsigned long, int)+0x30>
    31f3:	nop    DWORD PTR [rax+rax*1+0x0]
    31f8:	inc    r8d
    31fb:	cmp    edx,r8d
    31fe:	jne    31f8 <k_write(float*, unsigned long, int)+0x78>
    3200:	ret
    3201:	nop    DWORD PTR [rax+0x0]
    3208:	vzeroupper
    320b:	ret
    320c:	nop    DWORD PTR [rax+0x0]

0000000000003210 <k_copy(float const*, float*, unsigned long, int)>:
    3210:	mov    r9,rdi
    3213:	test   ecx,ecx
    3215:	jle    32a0 <k_copy(float const*, float*, unsigned long, int)+0x90>
    321b:	lea    rax,[rdx*4-0x4]
    3223:	xor    r8d,r8d
    3226:	xor    al,al
    3228:	lea    rdi,[rdi+rax*1+0x100]
    3230:	test   rdx,rdx
    3233:	je     3298 <k_copy(float const*, float*, unsigned long, int)+0x88>
    3235:	nop    DWORD PTR [rax]
    3238:	mov    rdx,rsi
    323b:	mov    rax,r9
    323e:	xchg   ax,ax
    3240:	vmovaps zmm0,ZMMWORD PTR [rax]
    3246:	add    rax,0x100
    324c:	add    rdx,0x100
    3253:	vmovaps ZMMWORD PTR [rdx-0x100],zmm0
    325a:	vmovaps zmm1,ZMMWORD PTR [rax-0xc0]
    3261:	vmovaps ZMMWORD PTR [rdx-0xc0],zmm1
    3268:	vmovaps zmm2,ZMMWORD PTR [rax-0x80]
    326f:	vmovaps ZMMWORD PTR [rdx-0x80],zmm2
    3276:	vmovaps zmm3,ZMMWORD PTR [rax-0x40]
    327d:	vmovaps ZMMWORD PTR [rdx-0x40],zmm3
    3284:	cmp    rax,rdi
    3287:	jne    3240 <k_copy(float const*, float*, unsigned long, int)+0x30>
    3289:	inc    r8d
    328c:	cmp    ecx,r8d
    328f:	jne    3238 <k_copy(float const*, float*, unsigned long, int)+0x28>
    3291:	vzeroupper
    3294:	ret
    3295:	nop    DWORD PTR [rax]
    3298:	inc    r8d
    329b:	cmp    ecx,r8d
    329e:	jne    3298 <k_copy(float const*, float*, unsigned long, int)+0x88>
    32a0:	ret
    32a1:	data16 cs nop WORD PTR [rax+rax*1+0x0]
    32ac:	nop    DWORD PTR [rax+0x0]

00000000000032b0 <k_rand_read(float const*, unsigned int const*, unsigned long, int)>:
    32b0:	mov    r8,rsi
    32b3:	mov    r9,rdx
    32b6:	mov    r10d,ecx
    32b9:	test   ecx,ecx
    32bb:	jle    332c <k_rand_read(float const*, unsigned int const*, unsigned long, int)+0x7c>
    32bd:	lea    rax,[rdx*4-0x4]
    32c5:	vxorps xmm3,xmm3,xmm3
    32c9:	vmovaps xmm2,xmm3
    32cd:	vmovaps xmm1,xmm3
    32d1:	vmovaps xmm0,xmm3
    32d5:	and    rax,0xfffffffffffffff0
    32d9:	lea    rcx,[rsi+rax*1+0x10]
    32de:	xor    esi,esi
    32e0:	mov    rax,r8
    32e3:	test   r9,r9
    32e6:	je     3318 <k_rand_read(float const*, unsigned int const*, unsigned long, int)+0x68>
    32e8:	nop    DWORD PTR [rax+rax*1+0x0]
    32f0:	mov    edx,DWORD PTR [rax]
    32f2:	add    rax,0x10
    32f6:	vaddss xmm0,xmm0,DWORD PTR [rdi+rdx*4]
    32fb:	mov    edx,DWORD PTR [rax-0xc]
    32fe:	vaddss xmm1,xmm1,DWORD PTR [rdi+rdx*4]
    3303:	mov    edx,DWORD PTR [rax-0x8]
    3306:	vaddss xmm2,xmm2,DWORD PTR [rdi+rdx*4]
    330b:	mov    edx,DWORD PTR [rax-0x4]
    330e:	vaddss xmm3,xmm3,DWORD PTR [rdi+rdx*4]
    3313:	cmp    rcx,rax
    3316:	jne    32f0 <k_rand_read(float const*, unsigned int const*, unsigned long, int)+0x40>
    3318:	inc    esi
    331a:	cmp    r10d,esi
    331d:	jne    32e0 <k_rand_read(float const*, unsigned int const*, unsigned long, int)+0x30>
    331f:	vaddss xmm0,xmm0,xmm1
    3323:	vaddss xmm0,xmm0,xmm2
    3327:	vaddss xmm0,xmm0,xmm3
    332b:	ret
    332c:	vxorps xmm0,xmm0,xmm0
    3330:	ret
    3331:	data16 cs nop WORD PTR [rax+rax*1+0x0]
    333c:	nop    DWORD PTR [rax+0x0]

0000000000003340 <env_long(char const*, long)>:
    3340:	push   rbx
    3341:	mov    rbx,rsi
    3344:	call   2380 <getenv@plt>
    3349:	test   rax,rax
    334c:	je     335e <env_long(char const*, long)+0x1e>
    334e:	mov    edx,0xa
    3353:	xor    esi,esi
    3355:	mov    rdi,rax
    3358:	pop    rbx
    3359:	jmp    2430 <__isoc23_strtol@plt>
    335e:	mov    rax,rbx
    3361:	pop    rbx
    3362:	ret
    3363:	data16 cs nop WORD PTR [rax+rax*1+0x0]
    336e:	xchg   ax,ax

0000000000003370 <k_read(float const*, unsigned long, int)>:
    3370:	vxorpd xmm0,xmm0,xmm0
    3374:	test   edx,edx
    3376:	jle    3444 <k_read(float const*, unsigned long, int)+0xd4>
    337c:	lea    rax,[rsi*4-0x4]
    3384:	vxorps xmm7,xmm7,xmm7
    3388:	xor    r8d,r8d
    338b:	vmovaps zmm3,zmm7
    3391:	vmovaps zmm6,zmm7
    3397:	vmovaps zmm1,zmm7
    339d:	and    rax,0xfffffffffffffe00
    33a3:	lea    rcx,[rdi+rax*1+0x200]
    33ab:	vmovaps zmm5,zmm7
    33b1:	vmovaps zmm2,zmm7
    33b7:	vmovaps zmm4,zmm7
    33bd:	vmovaps zmm0,zmm7
    33c3:	nop    DWORD PTR [rax+rax*1+0x0]
    33c8:	mov    rax,rdi
    33cb:	test   rsi,rsi
    33ce:	je     3412 <k_read(float const*, unsigned long, int)+0xa2>
    33d0:	vaddps zmm0,zmm0,ZMMWORD PTR [rax]
    33d6:	vaddps zmm4,zmm4,ZMMWORD PTR [rax+0x40]
    33dd:	add    rax,0x200
    33e3:	vaddps zmm2,zmm2,ZMMWORD PTR [rax-0x180]
    33ea:	vaddps zmm5,zmm5,ZMMWORD PTR [rax-0x140]
    33f1:	vaddps zmm1,zmm1,ZMMWORD PTR [rax-0x100]
    33f8:	vaddps zmm6,zmm6,ZMMWORD PTR [rax-0xc0]
    33ff:	vaddps zmm3,zmm3,ZMMWORD PTR [rax-0x80]
    3406:	vaddps zmm7,zmm7,ZMMWORD PTR [rax-0x40]
    340d:	cmp    rcx,rax
    3410:	jne    33d0 <k_read(float const*, unsigned long, int)+0x60>
    3412:	inc    r8d
    3415:	cmp    edx,r8d
    3418:	jne    33c8 <k_read(float const*, unsigned long, int)+0x58>
    341a:	vaddps zmm0,zmm0,zmm4
    3420:	vaddps zmm2,zmm2,zmm5
    3426:	vaddps zmm1,zmm1,zmm6
    342c:	vaddps zmm3,zmm3,zmm7
    3432:	vaddps zmm0,zmm0,zmm2
    3438:	vaddps zmm1,zmm1,zmm3
    343e:	vaddps zmm0,zmm0,zmm1
    3444:	vextractf64x4 ymm1,zmm0,0x1
    344b:	vaddps ymm0,ymm0,ymm1
    344f:	vextractf128 xmm1,ymm0,0x1
    3455:	vaddps xmm0,xmm1,xmm0
    3459:	vpermilps xmm1,xmm0,0x4e
    345f:	vaddps xmm1,xmm1,xmm0
    3463:	vmovaps xmm0,xmm1
    3467:	vshufps xmm1,xmm1,xmm1,0x55
    346c:	vaddss xmm0,xmm0,xmm1
    3470:	vzeroupper
    3473:	ret
    3474:	data16 cs nop WORD PTR [rax+rax*1+0x0]
    347f:	nop

0000000000003480 <k_write_nt(float*, unsigned long, int)>:
    3480:	test   edx,edx
    3482:	jle    34fb <k_write_nt(float*, unsigned long, int)+0x7b>
    3484:	xor    r8d,r8d
    3487:	test   rsi,rsi
    348a:	je     34e8 <k_write_nt(float*, unsigned long, int)+0x68>
    348c:	vxorps xmm1,xmm1,xmm1
    3490:	vxorps xmm0,xmm0,xmm0
    3494:	nop    DWORD PTR [rax+0x0]
    3498:	mov    rax,rdi
    349b:	xor    ecx,ecx
    349d:	nop    DWORD PTR [rax]
    34a0:	add    rcx,0x40
    34a4:	vmovntps ZMMWORD PTR [rax],zmm0
    34aa:	add    rax,0x100
    34b0:	vmovntps ZMMWORD PTR [rax-0xc0],zmm0
    34b7:	vmovntps ZMMWORD PTR [rax-0x80],zmm0
    34be:	vmovntps ZMMWORD PTR [rax-0x40],zmm0
    34c5:	cmp    rcx,rsi
    34c8:	jb     34a0 <k_write_nt(float*, unsigned long, int)+0x20>
    34ca:	sfence
    34cd:	inc    r8d
    34d0:	cmp    r8d,edx
    34d3:	je     34f8 <k_write_nt(float*, unsigned long, int)+0x78>
    34d5:	vcvtsi2ss xmm0,xmm1,r8d
    34da:	vbroadcastss zmm0,xmm0
    34e0:	jmp    3498 <k_write_nt(float*, unsigned long, int)+0x18>
    34e2:	nop    WORD PTR [rax+rax*1+0x0]
    34e8:	sfence
    34eb:	inc    r8d
    34ee:	cmp    edx,r8d
    34f1:	jne    34e8 <k_write_nt(float*, unsigned long, int)+0x68>
    34f3:	ret
    34f4:	nop    DWORD PTR [rax+0x0]
    34f8:	vzeroupper
    34fb:	ret
    34fc:	nop    DWORD PTR [rax+0x0]

0000000000003500 <k_triad(float*, float const*, float const*, unsigned long, int)>:
    3500:	xor    r9d,r9d
    3503:	test   r8d,r8d
    3506:	jle    3582 <k_triad(float*, float const*, float const*, unsigned long, int)+0x82>
    3508:	vbroadcastss zmm0,DWORD PTR [rip+0xaf2]        # 4004 <_IO_stdin_used+0x4>
    3512:	test   rcx,rcx
    3515:	je     3570 <k_triad(float*, float const*, float const*, unsigned long, int)+0x70>
    3517:	nop    WORD PTR [rax+rax*1+0x0]
    3520:	xor    eax,eax
    3522:	nop    WORD PTR [rax+rax*1+0x0]
    3528:	vmovaps zmm1,ZMMWORD PTR [rdx+rax*4]
    352f:	vfmadd213ps zmm1,zmm0,ZMMWORD PTR [rsi+rax*4]
    3536:	vmovaps ZMMWORD PTR [rdi+rax*4],zmm1
    353d:	vmovaps zmm1,ZMMWORD PTR [rdx+rax*4+0x40]
    3545:	vfmadd213ps zmm1,zmm0,ZMMWORD PTR [rsi+rax*4+0x40]
    354d:	vmovaps ZMMWORD PTR [rdi+rax*4+0x40],zmm1
    3555:	add    rax,0x20
    3559:	cmp    rax,rcx
    355c:	jb     3528 <k_triad(float*, float const*, float const*, unsigned long, int)+0x28>
    355e:	inc    r9d
    3561:	cmp    r9d,r8d
    3564:	jne    3520 <k_triad(float*, float const*, float const*, unsigned long, int)+0x20>
    3566:	vzeroupper
    3569:	ret
    356a:	nop    WORD PTR [rax+rax*1+0x0]
    3570:	inc    r9d
    3573:	cmp    r8d,r9d
    3576:	je     3566 <k_triad(float*, float const*, float const*, unsigned long, int)+0x66>
    3578:	inc    r9d
    357b:	cmp    r8d,r9d
    357e:	jne    3570 <k_triad(float*, float const*, float const*, unsigned long, int)+0x70>
    3580:	jmp    3566 <k_triad(float*, float const*, float const*, unsigned long, int)+0x66>
    3582:	ret
    3583:	nop
    3584:	data16 cs nop WORD PTR [rax+rax*1+0x0]
    358f:	nop

0000000000003590 <main::{lambda()#1}::operator()() const>:
    3590:	sub    rsp,0x8
    3594:	mov    rax,rdi
    3597:	mov    rcx,QWORD PTR [rdi]
    359a:	mov    rdx,QWORD PTR [rcx+0x8]
    359e:	cmp    rdx,0x4
    35a2:	je     3610 <main::{lambda()#1}::operator()() const+0x80>
    35a4:	cmp    rdx,0x5
    35a8:	jne    35d0 <main::{lambda()#1}::operator()() const+0x40>
    35aa:	mov    rdx,QWORD PTR [rcx]
    35ad:	cmp    DWORD PTR [rdx],0x74697277
    35b3:	je     36d0 <main::{lambda()#1}::operator()() const+0x140>
    35b9:	cmp    DWORD PTR [rdx],0x61697274
    35bf:	je     3700 <main::{lambda()#1}::operator()() const+0x170>
    35c5:	add    rsp,0x8
    35c9:	ret
    35ca:	nop    WORD PTR [rax+rax*1+0x0]
    35d0:	cmp    rdx,0x8
    35d4:	jne    3678 <main::{lambda()#1}::operator()() const+0xe8>
    35da:	mov    rcx,QWORD PTR [rcx]
    35dd:	movabs rdx,0x746e5f6574697277
    35e7:	cmp    QWORD PTR [rcx],rdx
    35ea:	jne    35c5 <main::{lambda()#1}::operator()() const+0x35>
    35ec:	mov    rdx,QWORD PTR [rdi+0x18]
    35f0:	mov    rcx,QWORD PTR [rdi+0x10]
    35f4:	mov    rax,QWORD PTR [rdi+0x8]
    35f8:	mov    edx,DWORD PTR [rdx]
    35fa:	mov    rsi,QWORD PTR [rcx]
    35fd:	mov    rdi,QWORD PTR [rax]
    3600:	add    rsp,0x8
    3604:	jmp    3480 <k_write_nt(float*, unsigned long, int)>
    3609:	nop    DWORD PTR [rax+0x0]
    3610:	mov    rdx,QWORD PTR [rcx]
    3613:	cmp    DWORD PTR [rdx],0x64616572
    3619:	je     3650 <main::{lambda()#1}::operator()() const+0xc0>
    361b:	cmp    DWORD PTR [rdx],0x79706f63
    3621:	jne    35c5 <main::{lambda()#1}::operator()() const+0x35>
    3623:	mov    rdx,QWORD PTR [rdi+0x18]
    3627:	mov    rsi,QWORD PTR [rdi+0x20]
    362b:	mov    rax,QWORD PTR [rdi+0x8]
    362f:	mov    ecx,DWORD PTR [rdx]
    3631:	mov    rdx,QWORD PTR [rdi+0x10]
    3635:	mov    rsi,QWORD PTR [rsi]
    3638:	mov    rdi,QWORD PTR [rax]
    363b:	mov    rdx,QWORD PTR [rdx]
    363e:	add    rsp,0x8
    3642:	jmp    3210 <k_copy(float const*, float*, unsigned long, int)>
    3647:	nop    WORD PTR [rax+rax*1+0x0]
    3650:	mov    rcx,QWORD PTR [rdi+0x10]
    3654:	mov    rdx,QWORD PTR [rdi+0x18]
    3658:	mov    rax,QWORD PTR [rdi+0x8]
    365c:	mov    edx,DWORD PTR [rdx]
    365e:	mov    rsi,QWORD PTR [rcx]
    3661:	mov    rdi,QWORD PTR [rax]
    3664:	call   3370 <k_read(float const*, unsigned long, int)>
    3669:	vmovd  eax,xmm0
    366d:	add    rsp,0x8
    3671:	ret
    3672:	nop    WORD PTR [rax+rax*1+0x0]
    3678:	cmp    rdx,0x9
    367c:	jne    35c5 <main::{lambda()#1}::operator()() const+0x35>
    3682:	mov    rdx,QWORD PTR [rcx]
    3685:	movabs rcx,0x6165725f646e6172
    368f:	cmp    QWORD PTR [rdx],rcx
    3692:	jne    35c5 <main::{lambda()#1}::operator()() const+0x35>
    3698:	cmp    BYTE PTR [rdx+0x8],0x64
    369c:	jne    35c5 <main::{lambda()#1}::operator()() const+0x35>
    36a2:	mov    rdx,QWORD PTR [rdi+0x30]
    36a6:	mov    rcx,QWORD PTR [rdi+0x18]
    36aa:	mov    rax,QWORD PTR [rdi+0x8]
    36ae:	mov    rsi,QWORD PTR [rdx]
    36b1:	mov    rdx,QWORD PTR [rdx+0x8]
    36b5:	mov    rdi,QWORD PTR [rax]
    36b8:	mov    ecx,DWORD PTR [rcx]
    36ba:	sub    rdx,rsi
    36bd:	sar    rdx,0x2
    36c1:	call   32b0 <k_rand_read(float const*, unsigned int const*, unsigned long, int)>
    36c6:	vmovd  eax,xmm0
    36ca:	jmp    35c5 <main::{lambda()#1}::operator()() const+0x35>
    36cf:	nop
    36d0:	cmp    BYTE PTR [rdx+0x4],0x65
    36d4:	jne    35b9 <main::{lambda()#1}::operator()() const+0x29>
    36da:	mov    rdx,QWORD PTR [rdi+0x18]
    36de:	mov    rcx,QWORD PTR [rdi+0x10]
    36e2:	mov    rax,QWORD PTR [rdi+0x8]
    36e6:	mov    edx,DWORD PTR [rdx]
    36e8:	mov    rsi,QWORD PTR [rcx]
    36eb:	mov    rdi,QWORD PTR [rax]
    36ee:	add    rsp,0x8
    36f2:	jmp    3180 <k_write(float*, unsigned long, int)>
    36f7:	nop    WORD PTR [rax+rax*1+0x0]
    3700:	cmp    BYTE PTR [rdx+0x4],0x64
    3704:	jne    35c5 <main::{lambda()#1}::operator()() const+0x35>
    370a:	mov    rdx,QWORD PTR [rax+0x10]
    370e:	mov    r8,QWORD PTR [rax+0x18]
    3712:	mov    rsi,QWORD PTR [rax+0x20]
    3716:	mov    rcx,QWORD PTR [rdx]
    3719:	mov    rdx,QWORD PTR [rax+0x28]
    371d:	mov    rax,QWORD PTR [rax+0x8]
    3721:	mov    rsi,QWORD PTR [rsi]
    3724:	mov    rdx,QWORD PTR [rdx]
    3727:	mov    r8d,DWORD PTR [r8]
    372a:	mov    rdi,QWORD PTR [rax]
    372d:	add    rsp,0x8
    3731:	jmp    3500 <k_triad(float*, float const*, float const*, unsigned long, int)>
    3736:	cs nop WORD PTR [rax+rax*1+0x0]

0000000000003740 <Counters::Counters()>:
    3740:	endbr64
    3744:	push   rbp
    3745:	mov    rbp,rsp
    3748:	push   r14
    374a:	push   r13
    374c:	mov    r13,rdi
    374f:	push   r12
    3751:	push   rbx
    3752:	xor    ebx,ebx
    3754:	sub    rsp,0xb0
    375b:	mov    rax,QWORD PTR fs:0x28
    3764:	mov    QWORD PTR [rsp+0xa8],rax
    376c:	xor    eax,eax
    376e:	vmovdqa xmm0,XMMWORD PTR [rip+0xa5a]        # 41d0 <_IO_stdin_used+0x1d0>
    3776:	mov    QWORD PTR [rdi],0xffffffffffffffff
    377d:	mov    r12,rsp
    3780:	mov    DWORD PTR [rdi+0x8],0xffffffff
    3787:	lea    r14,[rsp+0x90]
    378f:	mov    BYTE PTR [rdi+0xc],0x0
    3793:	mov    QWORD PTR [rsp+0xa0],0x1
    379f:	vmovdqa XMMWORD PTR [rsp+0x90],xmm0
    37a8:	vpxor  xmm0,xmm0,xmm0
    37ac:	mov    rax,QWORD PTR [r14+rbx*8]
    37b0:	test   ebx,ebx
    37b2:	vmovdqu8 ZMMWORD PTR [r12],zmm0
    37b9:	mov    QWORD PTR [r12+0x80],0x0
    37c5:	mov    QWORD PTR [rsp+0x8],rax
    37ca:	sete   al
    37cd:	xor    r9d,r9d
    37d0:	or     eax,0x40
    37d3:	mov    DWORD PTR [rsp+0x4],0x88
    37db:	mov    QWORD PTR [rsp+0x20],0x8
    37e4:	mov    BYTE PTR [rsp+0x28],al
    37e8:	vmovdqu8 ZMMWORD PTR [r12+0x40],zmm0
    37f0:	test   rbx,rbx
    37f3:	je     3830 <Counters::Counters()+0xf0>
    37f5:	mov    r8d,DWORD PTR [r13+0x0]
    37f9:	xor    edx,edx
    37fb:	xor    eax,eax
    37fd:	mov    ecx,0xffffffff
    3802:	mov    rsi,r12
    3805:	mov    edi,0x12a
    380a:	vzeroupper
    380d:	call   2250 <syscall@plt>
    3812:	vpxor  xmm0,xmm0,xmm0
    3816:	test   eax,eax
    3818:	mov    DWORD PTR [r13+rbx*4+0x0],eax
    381d:	js     3890 <Counters::Counters()+0x150>
    381f:	cmp    rbx,0x2
    3823:	je     3868 <Counters::Counters()+0x128>
    3825:	mov    ebx,0x2
    382a:	jmp    37ac <Counters::Counters()+0x6c>
    382c:	nop    DWORD PTR [rax+0x0]
    3830:	xor    edx,edx
    3832:	xor    eax,eax
    3834:	mov    r8d,0xffffffff
    383a:	mov    ecx,0xffffffff
    383f:	mov    rsi,r12
    3842:	mov    edi,0x12a
    3847:	vzeroupper
    384a:	call   2250 <syscall@plt>
    384f:	vpxor  xmm0,xmm0,xmm0
    3853:	test   eax,eax
    3855:	mov    DWORD PTR [r13+0x0],eax
    3859:	js     3890 <Counters::Counters()+0x150>
    385b:	mov    ebx,0x1
    3860:	jmp    37ac <Counters::Counters()+0x6c>
    3865:	nop    DWORD PTR [rax]
    3868:	mov    BYTE PTR [r13+0xc],0x1
    386d:	mov    rax,QWORD PTR [rsp+0xa8]
    3875:	sub    rax,QWORD PTR fs:0x28
    387e:	jne    38ac <Counters::Counters()+0x16c>
    3880:	add    rsp,0xb0
    3887:	pop    rbx
    3888:	pop    r12
    388a:	pop    r13
    388c:	pop    r14
    388e:	pop    rbp
    388f:	ret
    3890:	mov    rdi,QWORD PTR [rip+0x27a9]        # 6040 <stderr@GLIBC_2.2.5>
    3897:	lea    rdx,[rip+0x7ea]        # 4088 <_IO_stdin_used+0x88>
    389e:	mov    esi,0x2
    38a3:	xor    eax,eax
    38a5:	call   23e0 <__fprintf_chk@plt>
    38aa:	jmp    386d <Counters::Counters()+0x12d>
    38ac:	call   2330 <__stack_chk_fail@plt>
    38b1:	cs nop WORD PTR [rax+rax*1+0x0]
    38bb:	nop    DWORD PTR [rax+rax*1+0x0]

00000000000038c0 <bool std::operator==<char, std::char_traits<char>, std::allocator<char> >(std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > const&, char const*)>:
    38c0:	endbr64
    38c4:	push   r12
    38c6:	push   rbp
    38c7:	mov    rbp,rdi
    38ca:	push   rbx
    38cb:	mov    rbx,rsi
    38ce:	mov    r12,QWORD PTR [rdi+0x8]
    38d2:	mov    rdi,rsi
    38d5:	call   2270 <strlen@plt>
    38da:	mov    rdx,rax
    38dd:	xor    eax,eax
    38df:	cmp    r12,rdx
    38e2:	je     38f0 <bool std::operator==<char, std::char_traits<char>, std::allocator<char> >(std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > const&, char const*)+0x30>
    38e4:	pop    rbx
    38e5:	pop    rbp
    38e6:	pop    r12
    38e8:	ret
    38e9:	nop    DWORD PTR [rax+0x0]
    38f0:	mov    eax,0x1
    38f5:	test   r12,r12
    38f8:	je     38e4 <bool std::operator==<char, std::char_traits<char>, std::allocator<char> >(std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > const&, char const*)+0x24>
    38fa:	mov    rdi,QWORD PTR [rbp+0x0]
    38fe:	mov    rdx,r12
    3901:	mov    rsi,rbx
    3904:	call   2280 <memcmp@plt>
    3909:	pop    rbx
    390a:	test   eax,eax
    390c:	pop    rbp
    390d:	sete   al
    3910:	pop    r12
    3912:	ret
    3913:	cs nop WORD PTR [rax+rax*1+0x0]
    391d:	nop    DWORD PTR [rax]

0000000000003920 <std::mersenne_twister_engine<unsigned long, 64ul, 312ul, 156ul, 31ul, 13043109905998158313ul, 29ul, 6148914691236517205ul, 17ul, 8202884508482404352ul, 37ul, 18444473444759240704ul, 43ul, 6364136223846793005ul>::_M_gen_rand()>:
    3920:	endbr64
    3924:	mov    rcx,0xffffffff80000000
    392b:	mov    r8,rdi
    392e:	mov    rdx,rdi
    3931:	mov    rax,rdi
    3934:	vpbroadcastq ymm5,rcx
    393a:	lea    rsi,[rdi+0x4e0]
    3941:	vpxor  xmm6,xmm6,xmm6
    3945:	mov    ecx,0x7fffffff
    394a:	vpbroadcastq ymm4,rcx
    3950:	mov    ecx,0x1
    3955:	vpbroadcastq ymm3,rcx
    395b:	movabs rcx,0xb5026f5aa96619e9
    3965:	vpbroadcastq ymm2,rcx
    396b:	nop    DWORD PTR [rax+rax*1+0x0]
    3970:	vpand  ymm0,ymm4,YMMWORD PTR [rax+0x8]
    3975:	add    rax,0x20
    3979:	vpternlogq ymm0,ymm5,YMMWORD PTR [rax-0x20],0xf8
    3981:	vpsrlq ymm1,ymm0,0x1
    3986:	vpand  ymm0,ymm0,ymm3
    398a:	vpsubq ymm0,ymm6,ymm0
    398e:	vpand  ymm0,ymm0,ymm2
    3992:	vpternlogq ymm0,ymm1,YMMWORD PTR [rax+0x4c0],0x96
    399a:	vmovdqu YMMWORD PTR [rax-0x20],ymm0
    399f:	cmp    rax,rsi
    39a2:	jne    3970 <std::mersenne_twister_engine<unsigned long, 64ul, 312ul, 156ul, 31ul, 13043109905998158313ul, 29ul, 6148914691236517205ul, 17ul, 8202884508482404352ul, 37ul, 18444473444759240704ul, 43ul, 6364136223846793005ul>::_M_gen_rand()+0x50>
    39a4:	mov    rsi,QWORD PTR [r8+0x4e0]
    39ab:	lea    r9,[r8+0x4d8]
    39b2:	movabs rdi,0xb5026f5aa96619e9
    39bc:	nop    DWORD PTR [rax+0x0]
    39c0:	and    rsi,0xffffffff80000000
    39c7:	add    rdx,0x8
    39cb:	mov    rcx,rsi
    39ce:	mov    rsi,QWORD PTR [rdx+0x4e0]
    39d5:	mov    rax,rsi
    39d8:	and    eax,0x7fffffff
    39dd:	or     rax,rcx
    39e0:	mov    rcx,rax
    39e3:	and    eax,0x1
    39e6:	shr    rcx,1
    39e9:	neg    rax
    39ec:	xor    rcx,QWORD PTR [rdx-0x8]
    39f0:	and    rax,rdi
    39f3:	xor    rax,rcx
    39f6:	mov    QWORD PTR [rdx+0x4d8],rax
    39fd:	cmp    rdx,r9
    3a00:	jne    39c0 <std::mersenne_twister_engine<unsigned long, 64ul, 312ul, 156ul, 31ul, 13043109905998158313ul, 29ul, 6148914691236517205ul, 17ul, 8202884508482404352ul, 37ul, 18444473444759240704ul, 43ul, 6364136223846793005ul>::_M_gen_rand()+0xa0>
    3a02:	mov    rax,QWORD PTR [r8+0x9b8]
    3a09:	mov    rdx,QWORD PTR [r8]
    3a0c:	mov    QWORD PTR [r8+0x9c0],0x0
    3a17:	and    edx,0x7fffffff
    3a1d:	and    rax,0xffffffff80000000
    3a23:	or     rax,rdx
    3a26:	mov    rdx,rax
    3a29:	and    eax,0x1
    3a2c:	shr    rdx,1
    3a2f:	neg    rax
    3a32:	xor    rdx,QWORD PTR [r8+0x4d8]
    3a39:	and    rax,rdi
    3a3c:	xor    rax,rdx
    3a3f:	mov    QWORD PTR [r8+0x9b8],rax
    3a46:	vzeroupper
    3a49:	ret
    3a4a:	nop    WORD PTR [rax+rax*1+0x0]

0000000000003a50 <std::mersenne_twister_engine<unsigned long, 64ul, 312ul, 156ul, 31ul, 13043109905998158313ul, 29ul, 6148914691236517205ul, 17ul, 8202884508482404352ul, 37ul, 18444473444759240704ul, 43ul, 6364136223846793005ul>::operator()()>:
    3a50:	endbr64
    3a54:	mov    rax,QWORD PTR [rdi+0x9c0]
    3a5b:	push   rbx
    3a5c:	mov    rbx,rdi
    3a5f:	cmp    rax,0x137
    3a65:	ja     3ad0 <std::mersenne_twister_engine<unsigned long, 64ul, 312ul, 156ul, 31ul, 13043109905998158313ul, 29ul, 6148914691236517205ul, 17ul, 8202884508482404352ul, 37ul, 18444473444759240704ul, 43ul, 6364136223846793005ul>::operator()()+0x80>
    3a67:	lea    rdx,[rax+0x1]
    3a6b:	mov    rax,QWORD PTR [rbx+rax*8]
    3a6f:	movabs rcx,0x5555555555555555
    3a79:	mov    QWORD PTR [rbx+0x9c0],rdx
    3a80:	mov    rdx,rax
    3a83:	shr    rdx,0x1d
    3a87:	and    rdx,rcx
    3a8a:	movabs rcx,0x71d67fffeda60000
    3a94:	pop    rbx
    3a95:	xor    rdx,rax
    3a98:	mov    rax,rdx
    3a9b:	shl    rax,0x11
    3a9f:	and    rax,rcx
    3aa2:	movabs rcx,0xfff7eee000000000
    3aac:	xor    rax,rdx
    3aaf:	mov    rdx,rax
    3ab2:	shl    rdx,0x25
    3ab6:	and    rdx,rcx
    3ab9:	xor    rdx,rax
    3abc:	mov    rax,rdx
    3abf:	shr    rax,0x2b
    3ac3:	xor    rax,rdx
    3ac6:	ret
    3ac7:	nop    WORD PTR [rax+rax*1+0x0]
    3ad0:	call   3920 <std::mersenne_twister_engine<unsigned long, 64ul, 312ul, 156ul, 31ul, 13043109905998158313ul, 29ul, 6148914691236517205ul, 17ul, 8202884508482404352ul, 37ul, 18444473444759240704ul, 43ul, 6364136223846793005ul>::_M_gen_rand()>
    3ad5:	mov    rax,QWORD PTR [rbx+0x9c0]
    3adc:	jmp    3a67 <std::mersenne_twister_engine<unsigned long, 64ul, 312ul, 156ul, 31ul, 13043109905998158313ul, 29ul, 6148914691236517205ul, 17ul, 8202884508482404352ul, 37ul, 18444473444759240704ul, 43ul, 6364136223846793005ul>::operator()()+0x17>

Disassembly of section .fini:

0000000000003ae0 <_fini>:
    3ae0:	endbr64
    3ae4:	sub    rsp,0x8
    3ae8:	add    rsp,0x8
    3aec:	ret
