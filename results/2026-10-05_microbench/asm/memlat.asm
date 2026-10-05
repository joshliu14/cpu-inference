
bin/memlat:     file format elf64-x86-64


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
    2020:	push   QWORD PTR [rip+0x3eaa]        # 5ed0 <_GLOBAL_OFFSET_TABLE_+0x8>
    2026:	jmp    QWORD PTR [rip+0x3eac]        # 5ed8 <_GLOBAL_OFFSET_TABLE_+0x10>
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

Disassembly of section .plt.got:

0000000000002220 <__cxa_finalize@plt>:
    2220:	endbr64
    2224:	jmp    QWORD PTR [rip+0x3dae]        # 5fd8 <__cxa_finalize@GLIBC_2.2.5>
    222a:	nop    WORD PTR [rax+rax*1+0x0]

Disassembly of section .plt.sec:

0000000000002230 <__printf_chk@plt>:
    2230:	endbr64
    2234:	jmp    QWORD PTR [rip+0x3ca6]        # 5ee0 <__printf_chk@GLIBC_2.3.4>
    223a:	nop    WORD PTR [rax+rax*1+0x0]

0000000000002240 <syscall@plt>:
    2240:	endbr64
    2244:	jmp    QWORD PTR [rip+0x3c9e]        # 5ee8 <syscall@GLIBC_2.2.5>
    224a:	nop    WORD PTR [rax+rax*1+0x0]

0000000000002250 <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >::_M_append(char const*, unsigned long)@plt>:
    2250:	endbr64
    2254:	jmp    QWORD PTR [rip+0x3c96]        # 5ef0 <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >::_M_append(char const*, unsigned long)@GLIBCXX_3.4.21>
    225a:	nop    WORD PTR [rax+rax*1+0x0]

0000000000002260 <strlen@plt>:
    2260:	endbr64
    2264:	jmp    QWORD PTR [rip+0x3c8e]        # 5ef8 <strlen@GLIBC_2.2.5>
    226a:	nop    WORD PTR [rax+rax*1+0x0]

0000000000002270 <memcmp@plt>:
    2270:	endbr64
    2274:	jmp    QWORD PTR [rip+0x3c86]        # 5f00 <memcmp@GLIBC_2.2.5>
    227a:	nop    WORD PTR [rax+rax*1+0x0]

0000000000002280 <llround@plt>:
    2280:	endbr64
    2284:	jmp    QWORD PTR [rip+0x3c7e]        # 5f08 <llround@GLIBC_2.2.5>
    228a:	nop    WORD PTR [rax+rax*1+0x0]

0000000000002290 <std::__throw_length_error(char const*)@plt>:
    2290:	endbr64
    2294:	jmp    QWORD PTR [rip+0x3c76]        # 5f10 <std::__throw_length_error(char const*)@GLIBCXX_3.4>
    229a:	nop    WORD PTR [rax+rax*1+0x0]

00000000000022a0 <memset@plt>:
    22a0:	endbr64
    22a4:	jmp    QWORD PTR [rip+0x3c6e]        # 5f18 <memset@GLIBC_2.2.5>
    22aa:	nop    WORD PTR [rax+rax*1+0x0]

00000000000022b0 <std::__throw_logic_error(char const*)@plt>:
    22b0:	endbr64
    22b4:	jmp    QWORD PTR [rip+0x3c66]        # 5f20 <std::__throw_logic_error(char const*)@GLIBCXX_3.4>
    22ba:	nop    WORD PTR [rax+rax*1+0x0]

00000000000022c0 <aligned_alloc@plt>:
    22c0:	endbr64
    22c4:	jmp    QWORD PTR [rip+0x3c5e]        # 5f28 <aligned_alloc@GLIBC_2.16>
    22ca:	nop    WORD PTR [rax+rax*1+0x0]

00000000000022d0 <memcpy@plt>:
    22d0:	endbr64
    22d4:	jmp    QWORD PTR [rip+0x3c56]        # 5f30 <memcpy@GLIBC_2.14>
    22da:	nop    WORD PTR [rax+rax*1+0x0]

00000000000022e0 <perror@plt>:
    22e0:	endbr64
    22e4:	jmp    QWORD PTR [rip+0x3c4e]        # 5f38 <perror@GLIBC_2.2.5>
    22ea:	nop    WORD PTR [rax+rax*1+0x0]

00000000000022f0 <clock_gettime@plt>:
    22f0:	endbr64
    22f4:	jmp    QWORD PTR [rip+0x3c46]        # 5f40 <clock_gettime@GLIBC_2.17>
    22fa:	nop    WORD PTR [rax+rax*1+0x0]

0000000000002300 <operator new(unsigned long)@plt>:
    2300:	endbr64
    2304:	jmp    QWORD PTR [rip+0x3c3e]        # 5f48 <operator new(unsigned long)@GLIBCXX_3.4>
    230a:	nop    WORD PTR [rax+rax*1+0x0]

0000000000002310 <operator delete(void*, unsigned long)@plt>:
    2310:	endbr64
    2314:	jmp    QWORD PTR [rip+0x3c36]        # 5f50 <operator delete(void*, unsigned long)@CXXABI_1.3.9>
    231a:	nop    WORD PTR [rax+rax*1+0x0]

0000000000002320 <__stack_chk_fail@plt>:
    2320:	endbr64
    2324:	jmp    QWORD PTR [rip+0x3c2e]        # 5f58 <__stack_chk_fail@GLIBC_2.4>
    232a:	nop    WORD PTR [rax+rax*1+0x0]

0000000000002330 <fflush@plt>:
    2330:	endbr64
    2334:	jmp    QWORD PTR [rip+0x3c26]        # 5f60 <fflush@GLIBC_2.2.5>
    233a:	nop    WORD PTR [rax+rax*1+0x0]

0000000000002340 <free@plt>:
    2340:	endbr64
    2344:	jmp    QWORD PTR [rip+0x3c1e]        # 5f68 <free@GLIBC_2.2.5>
    234a:	nop    WORD PTR [rax+rax*1+0x0]

0000000000002350 <madvise@plt>:
    2350:	endbr64
    2354:	jmp    QWORD PTR [rip+0x3c16]        # 5f70 <madvise@GLIBC_2.2.5>
    235a:	nop    WORD PTR [rax+rax*1+0x0]

0000000000002360 <exit@plt>:
    2360:	endbr64
    2364:	jmp    QWORD PTR [rip+0x3c0e]        # 5f78 <exit@GLIBC_2.2.5>
    236a:	nop    WORD PTR [rax+rax*1+0x0]

0000000000002370 <getenv@plt>:
    2370:	endbr64
    2374:	jmp    QWORD PTR [rip+0x3c06]        # 5f80 <getenv@GLIBC_2.2.5>
    237a:	nop    WORD PTR [rax+rax*1+0x0]

0000000000002380 <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >::_M_dispose()@plt>:
    2380:	endbr64
    2384:	jmp    QWORD PTR [rip+0x3bfe]        # 5f88 <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >::_M_dispose()@GLIBCXX_3.4.21>
    238a:	nop    WORD PTR [rax+rax*1+0x0]

0000000000002390 <__memset_chk@plt>:
    2390:	endbr64
    2394:	jmp    QWORD PTR [rip+0x3bf6]        # 5f90 <__memset_chk@GLIBC_2.3.4>
    239a:	nop    WORD PTR [rax+rax*1+0x0]

00000000000023a0 <ioctl@plt>:
    23a0:	endbr64
    23a4:	jmp    QWORD PTR [rip+0x3bee]        # 5f98 <ioctl@GLIBC_2.2.5>
    23aa:	nop    WORD PTR [rax+rax*1+0x0]

00000000000023b0 <read@plt>:
    23b0:	endbr64
    23b4:	jmp    QWORD PTR [rip+0x3be6]        # 5fa0 <read@GLIBC_2.2.5>
    23ba:	nop    WORD PTR [rax+rax*1+0x0]

00000000000023c0 <__fprintf_chk@plt>:
    23c0:	endbr64
    23c4:	jmp    QWORD PTR [rip+0x3bde]        # 5fa8 <__fprintf_chk@GLIBC_2.3.4>
    23ca:	nop    WORD PTR [rax+rax*1+0x0]

00000000000023d0 <pow@plt>:
    23d0:	endbr64
    23d4:	jmp    QWORD PTR [rip+0x3bd6]        # 5fb0 <pow@GLIBC_2.29>
    23da:	nop    WORD PTR [rax+rax*1+0x0]

00000000000023e0 <_Unwind_Resume@plt>:
    23e0:	endbr64
    23e4:	jmp    QWORD PTR [rip+0x3bce]        # 5fb8 <_Unwind_Resume@GCC_3.0>
    23ea:	nop    WORD PTR [rax+rax*1+0x0]

00000000000023f0 <log2@plt>:
    23f0:	endbr64
    23f4:	jmp    QWORD PTR [rip+0x3bc6]        # 5fc0 <log2@GLIBC_2.29>
    23fa:	nop    WORD PTR [rax+rax*1+0x0]

0000000000002400 <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >::_M_create(unsigned long&, unsigned long)@plt>:
    2400:	endbr64
    2404:	jmp    QWORD PTR [rip+0x3bbe]        # 5fc8 <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >::_M_create(unsigned long&, unsigned long)@GLIBCXX_3.4.21>
    240a:	nop    WORD PTR [rax+rax*1+0x0]

0000000000002410 <__isoc23_strtol@plt>:
    2410:	endbr64
    2414:	jmp    QWORD PTR [rip+0x3bb6]        # 5fd0 <__isoc23_strtol@GLIBC_2.38>
    241a:	nop    WORD PTR [rax+rax*1+0x0]

Disassembly of section .text:

0000000000002420 <main.cold>:
    2420:	mov    rdi,QWORD PTR [rbp-0xa90]
    2427:	vzeroupper
    242a:	call   2380 <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >::_M_dispose()@plt>
    242f:	mov    rax,QWORD PTR [rbp-0x38]
    2433:	sub    rax,QWORD PTR fs:0x28
    243c:	jne    246b <main.cold+0x4b>
    243e:	mov    rdi,rbx
    2441:	call   23e0 <_Unwind_Resume@plt>
    2446:	endbr64
    244a:	lea    rdi,[rbp-0xa40]
    2451:	mov    rbx,rax
    2454:	vzeroupper
    2457:	call   2380 <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >::_M_dispose()@plt>
    245c:	mov    rax,QWORD PTR [rbp-0x38]
    2460:	sub    rax,QWORD PTR fs:0x28
    2469:	je     243e <main.cold+0x1e>
    246b:	call   2320 <__stack_chk_fail@plt>
    2470:	lea    rdi,[rip+0x1ce1]        # 4158 <_IO_stdin_used+0x158>
    2477:	call   22e0 <perror@plt>
    247c:	mov    edi,0x1
    2481:	call   2360 <exit@plt>
    2486:	cs nop WORD PTR [rax+rax*1+0x0]

0000000000002490 <main>:
    2490:	endbr64
    2494:	push   rbp
    2495:	mov    rbp,rsp
    2498:	push   r15
    249a:	push   r14
    249c:	push   r13
    249e:	push   r12
    24a0:	push   rbx
    24a1:	sub    rsp,0xaa8
    24a8:	mov    rax,QWORD PTR fs:0x28
    24b1:	mov    QWORD PTR [rbp-0x38],rax
    24b5:	xor    eax,eax
    24b7:	cmp    edi,0x1
    24ba:	jg     2c7e <main+0x7ee>
    24c0:	lea    rax,[rbp-0xa60]
    24c7:	mov    BYTE PTR [rbp-0xa85],0x1
    24ce:	mov    QWORD PTR [rbp-0xa68],rax
    24d5:	lea    rax,[rbp-0xa00]
    24dc:	mov    QWORD PTR [rbp-0xaa0],rax
    24e3:	xor    esi,esi
    24e5:	lea    rdi,[rip+0x1c36]        # 4122 <_IO_stdin_used+0x122>
    24ec:	call   2e70 <env_long(char const*, long)>
    24f1:	mov    esi,0x5
    24f6:	lea    rdi,[rip+0x1c29]        # 4126 <_IO_stdin_used+0x126>
    24fd:	mov    QWORD PTR [rbp-0xaa8],rax
    2504:	call   2e70 <env_long(char const*, long)>
    2509:	mov    esi,0x4
    250e:	lea    rdi,[rip+0x1c16]        # 412b <_IO_stdin_used+0x12b>
    2515:	mov    DWORD PTR [rbp-0xa84],eax
    251b:	call   2e70 <env_long(char const*, long)>
    2520:	mov    esi,0x400
    2525:	lea    rdi,[rip+0x1c06]        # 4132 <_IO_stdin_used+0x132>
    252c:	shl    rax,0xa
    2530:	mov    r13,rax
    2533:	call   2e70 <env_long(char const*, long)>
    2538:	mov    esi,0x7a1200
    253d:	lea    rdi,[rip+0x1bf5]        # 4139 <_IO_stdin_used+0x139>
    2544:	shl    rax,0x14
    2548:	mov    r12,rax
    254b:	call   2e70 <env_long(char const*, long)>
    2550:	mov    QWORD PTR [rbp-0xa00],0x2a
    255b:	mov    rbx,QWORD PTR [rbp-0xaa0]
    2562:	mov    ecx,0x1
    2567:	mov    QWORD PTR [rbp-0xab8],rax
    256e:	mov    eax,0x2a
    2573:	movabs rsi,0x5851f42d4c957f2d
    257d:	mov    rdx,rax
    2580:	mov    rax,rdx
    2583:	shr    rax,0x3e
    2587:	xor    rax,rdx
    258a:	imul   rax,rsi
    258e:	lea    rdx,[rcx+rax*1]
    2592:	mov    QWORD PTR [rbx+rcx*8],rdx
    2596:	inc    rcx
    2599:	cmp    rcx,0x138
    25a0:	jne    2580 <main+0xf0>
    25a2:	lea    rdi,[rbp-0xa50]
    25a9:	mov    QWORD PTR [rbp-0xaa0],rbx
    25b0:	lea    rbx,[rip+0x1b55]        # 410c <_IO_stdin_used+0x10c>
    25b7:	mov    QWORD PTR [rbp-0x40],0x138
    25bf:	call   2ea0 <Counters::Counters()>
    25c4:	lea    rsi,[rip+0x1aad]        # 4078 <_IO_stdin_used+0x78>
    25cb:	mov    edi,0x2
    25d0:	xor    eax,eax
    25d2:	call   2230 <__printf_chk@plt>
    25d7:	cmp    QWORD PTR [rbp-0xaa8],0x0
    25df:	lea    rax,[rip+0x1b21]        # 4107 <_IO_stdin_used+0x107>
    25e6:	lea    rsi,[rip+0x1b2a]        # 4117 <_IO_stdin_used+0x117>
    25ed:	cmovne rbx,rax
    25f1:	cmp    BYTE PTR [rbp-0xa85],0x0
    25f8:	lea    rax,[rip+0x1b11]        # 4110 <_IO_stdin_used+0x110>
    25ff:	mov    rdx,QWORD PTR [rbp-0xa68]
    2606:	cmovne rsi,rax
    260a:	lea    rax,[rbp-0xa20]
    2611:	mov    rdi,rax
    2614:	mov    QWORD PTR [rbp-0xa90],rax
    261b:	call   3020 <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >::basic_string<std::allocator<char> >(char const*, std::allocator<char> const&)>
    2620:	mov    rdi,rbx
    2623:	call   2260 <strlen@plt>
    2628:	mov    rdx,rax
    262b:	movabs rax,0x3fffffffffffffff
    2635:	sub    rax,QWORD PTR [rbp-0xa18]
    263c:	cmp    rax,rdx
    263f:	jb     2d01 <main+0x871>
    2645:	mov    rdi,QWORD PTR [rbp-0xa90]
    264c:	mov    rsi,rbx
    264f:	call   2250 <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >::_M_append(char const*, unsigned long)@plt>
    2654:	lea    r8,[rbp-0xa30]
    265b:	lea    r9,[rax+0x10]
    265f:	mov    rcx,QWORD PTR [rax+0x8]
    2663:	mov    QWORD PTR [rbp-0xa40],r8
    266a:	mov    rdx,QWORD PTR [rax]
    266d:	cmp    rdx,r9
    2670:	je     2ce9 <main+0x859>
    2676:	mov    QWORD PTR [rbp-0xa40],rdx
    267d:	mov    rdx,QWORD PTR [rax+0x10]
    2681:	mov    QWORD PTR [rbp-0xa30],rdx
    2688:	mov    QWORD PTR [rax],r9
    268b:	mov    rdi,QWORD PTR [rbp-0xa90]
    2692:	mov    QWORD PTR [rax+0x8],0x0
    269a:	mov    BYTE PTR [rax+0x10],0x0
    269e:	mov    QWORD PTR [rbp-0xa38],rcx
    26a5:	call   2380 <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >::_M_dispose()@plt>
    26aa:	vxorpd xmm6,xmm6,xmm6
    26ae:	vcvtusi2sd xmm0,xmm6,r13
    26b4:	call   23f0 <log2@plt>
    26b9:	vxorpd xmm6,xmm6,xmm6
    26bd:	vmovsd QWORD PTR [rbp-0xa98],xmm0
    26c5:	vcvtusi2sd xmm0,xmm6,r12
    26cb:	vmovsd QWORD PTR [rbp-0xab0],xmm0
    26d3:	nop    DWORD PTR [rax+rax*1+0x0]
    26d8:	vmovsd xmm0,QWORD PTR [rbp-0xab0]
    26e0:	call   23f0 <log2@plt>
    26e5:	vaddsd xmm0,xmm0,QWORD PTR [rip+0x1abb]        # 41a8 <_IO_stdin_used+0x1a8>
    26ed:	vcomisd xmm0,QWORD PTR [rbp-0xa98]
    26f5:	jb     2c3e <main+0x7ae>
    26fb:	vmovsd xmm1,QWORD PTR [rbp-0xa98]
    2703:	vmovsd xmm0,QWORD PTR [rip+0x1a85]        # 4190 <_IO_stdin_used+0x190>
    270b:	call   23d0 <pow@plt>
    2710:	call   2280 <llround@plt>
    2715:	mov    rbx,rax
    2718:	and    rax,0xffffffffffffffc0
    271c:	shr    rbx,0x6
    2720:	cmp    QWORD PTR [rbp-0xaa8],0x0
    2728:	mov    QWORD PTR [rbp-0xa80],rax
    272f:	je     2b98 <main+0x708>
    2735:	mov    rax,QWORD PTR [rbp-0xa80]
    273c:	mov    edi,0x200000
    2741:	lea    r12,[rax+0x1fffff]
    2748:	and    r12,0xffffffffffe00000
    274f:	mov    rsi,r12
    2752:	call   22c0 <aligned_alloc@plt>
    2757:	mov    r14,rax
    275a:	test   rax,rax
    275d:	je     2d31 <main+0x8a1>
    2763:	mov    edx,0xe
    2768:	mov    rsi,r12
    276b:	mov    rdi,r14
    276e:	call   2350 <madvise@plt>
    2773:	mov    rcx,r12
    2776:	mov    rdx,r12
    2779:	mov    esi,0x1
    277e:	mov    rdi,r14
    2781:	call   2390 <__memset_chk@plt>
    2786:	test   rbx,rbx
    2789:	je     2bd0 <main+0x740>
    278f:	lea    r13,[rbx*8+0x0]
    2797:	mov    rdi,r13
    279a:	mov    QWORD PTR [rbp-0xa78],r13
    27a1:	call   2300 <operator new(unsigned long)@plt>
    27a6:	mov    QWORD PTR [rax],0x0
    27ad:	mov    r15,rax
    27b0:	cmp    rbx,0x1
    27b4:	je     2c22 <main+0x792>
    27ba:	lea    rdi,[rax+0x8]
    27be:	lea    rax,[rax+r13*1]
    27c2:	cmp    rdi,rax
    27c5:	je     27d9 <main+0x349>
    27c7:	mov    rax,QWORD PTR [rbp-0xa78]
    27ce:	xor    esi,esi
    27d0:	lea    rdx,[rax-0x8]
    27d4:	call   22a0 <memset@plt>
    27d9:	xor    eax,eax
    27db:	test   bl,0x1
    27de:	jne    2c00 <main+0x770>
    27e4:	mov    rcx,QWORD PTR [rbp-0xaa0]
    27eb:	nop    DWORD PTR [rax+rax*1+0x0]
    27f0:	mov    QWORD PTR [r15+rax*8],rax
    27f4:	lea    rdx,[rax+0x1]
    27f8:	add    rax,0x2
    27fc:	mov    QWORD PTR [r15+rdx*8],rdx
    2800:	cmp    rbx,rax
    2803:	jne    27f0 <main+0x360>
    2805:	mov    QWORD PTR [rbp-0xaa0],rcx
    280c:	cmp    BYTE PTR [rbp-0xa85],0x0
    2813:	lea    rsi,[rbx-0x1]
    2817:	je     290f <main+0x47f>
    281d:	mov    rax,QWORD PTR [rbp-0xaa0]
    2824:	mov    QWORD PTR [rbp-0xac8],r14
    282b:	mov    r12,rsi
    282e:	xor    r13d,r13d
    2831:	mov    QWORD PTR [rbp-0xac0],rbx
    2838:	mov    rbx,r15
    283b:	mov    r15,rsi
    283e:	mov    QWORD PTR [rbp-0xa70],rax
    2845:	nop    DWORD PTR [rax]
    2848:	mov    rdi,QWORD PTR [rbp-0xa70]
    284f:	call   3240 <std::mersenne_twister_engine<unsigned long, 64ul, 312ul, 156ul, 31ul, 13043109905998158313ul, 29ul, 6148914691236517205ul, 17ul, 8202884508482404352ul, 37ul, 18444473444759240704ul, 43ul, 6364136223846793005ul>::operator()()>
    2854:	mov    r8,rax
    2857:	mov    rax,r13
    285a:	mov    rdx,r8
    285d:	imul   rax,r8
    2861:	mulx   r9,r8,r12
    2866:	add    r9,rax
    2869:	cmp    r8,r15
    286c:	jae    28c8 <main+0x438>
    286e:	mov    rax,r15
    2871:	xor    edx,edx
    2873:	neg    rax
    2876:	div    r15
    2879:	mov    r14,rdx
    287c:	cmp    r8,rdx
    287f:	jae    28c8 <main+0x438>
    2881:	nop    DWORD PTR [rax+0x0]
    2888:	mov    rdi,QWORD PTR [rbp-0xa70]
    288f:	call   3240 <std::mersenne_twister_engine<unsigned long, 64ul, 312ul, 156ul, 31ul, 13043109905998158313ul, 29ul, 6148914691236517205ul, 17ul, 8202884508482404352ul, 37ul, 18444473444759240704ul, 43ul, 6364136223846793005ul>::operator()()>
    2894:	mov    rsi,r13
    2897:	imul   rsi,rax
    289b:	mul    r12
    289e:	add    rsi,rdx
    28a1:	cmp    rax,r14
    28a4:	jb     2888 <main+0x3f8>
    28a6:	lea    rax,[rbx+rsi*8]
    28aa:	mov    rdx,QWORD PTR [rbx+r15*8]
    28ae:	mov    rsi,QWORD PTR [rax]
    28b1:	mov    QWORD PTR [rbx+r15*8],rsi
    28b5:	dec    r15
    28b8:	add    r12,0xffffffffffffffff
    28bc:	mov    QWORD PTR [rax],rdx
    28bf:	adc    r13,0xffffffffffffffff
    28c3:	jmp    2848 <main+0x3b8>
    28c5:	nop    DWORD PTR [rax]
    28c8:	lea    rax,[rbx+r9*8]
    28cc:	mov    rdx,QWORD PTR [rbx+r15*8]
    28d0:	add    r12,0xffffffffffffffff
    28d4:	mov    rsi,QWORD PTR [rax]
    28d7:	adc    r13,0xffffffffffffffff
    28db:	mov    QWORD PTR [rbx+r15*8],rsi
    28df:	mov    QWORD PTR [rax],rdx
    28e2:	dec    r15
    28e5:	jne    2848 <main+0x3b8>
    28eb:	mov    rax,QWORD PTR [rbp-0xa70]
    28f2:	mov    r15,rbx
    28f5:	mov    rbx,QWORD PTR [rbp-0xac0]
    28fc:	mov    r14,QWORD PTR [rbp-0xac8]
    2903:	mov    QWORD PTR [rbp-0xaa0],rax
    290a:	test   rbx,rbx
    290d:	je     2952 <main+0x4c2>
    290f:	mov    rdi,QWORD PTR [rbp-0xaa0]
    2916:	xor    esi,esi
    2918:	nop    DWORD PTR [rax+rax*1+0x0]
    2920:	inc    rsi
    2923:	mov    eax,0x6
    2928:	xor    edx,edx
    292a:	shlx   rcx,QWORD PTR [r15+rsi*8-0x8],rax
    2931:	mov    rax,rsi
    2934:	div    rbx
    2937:	mov    rax,QWORD PTR [r15+rdx*8]
    293b:	shl    rax,0x6
    293f:	add    rax,r14
    2942:	mov    QWORD PTR [r14+rcx*1],rax
    2946:	cmp    rsi,rbx
    2949:	jb     2920 <main+0x490>
    294b:	mov    QWORD PTR [rbp-0xaa0],rdi
    2952:	mov    rsi,QWORD PTR [rbp-0xa78]
    2959:	mov    eax,0x6
    295e:	mov    rdi,r15
    2961:	lea    r13,[rbx*4+0x0]
    2969:	shlx   r12,QWORD PTR [r15],rax
    296e:	add    r12,r14
    2971:	call   2310 <operator delete(void*, unsigned long)@plt>
    2976:	mov    rdi,QWORD PTR [rbp-0xab8]
    297d:	mov    eax,0xf4240
    2982:	cmp    r13,rdi
    2985:	cmova  r13,rdi
    2989:	cmp    r13,rax
    298c:	cmovb  r13,rax
    2990:	lea    rax,[rbx+rbx*1+0x8]
    2995:	add    r13,0x7
    2999:	and    r13,0xfffffffffffffff8
    299d:	cmp    rax,rdi
    29a0:	cmova  rax,rdi
    29a4:	mov    rdi,r12
    29a7:	and    rax,0xfffffffffffffff8
    29ab:	lea    rsi,[rax+0x8]
    29af:	call   2e30 <chase(Node*, unsigned long)>
    29b4:	mov    r12,rax
    29b7:	mov    eax,DWORD PTR [rbp-0xa84]
    29bd:	test   eax,eax
    29bf:	jle    2b6b <main+0x6db>
    29c5:	xor    r15d,r15d
    29c8:	lea    rbx,[rip+0x1797]        # 4166 <_IO_stdin_used+0x166>
    29cf:	vzeroupper
    29d2:	jmp    2a50 <main+0x5c0>
    29d4:	nop    DWORD PTR [rax+0x0]
    29d8:	xor    ecx,ecx
    29da:	xor    edx,edx
    29dc:	xor    eax,eax
    29de:	vmovsd xmm3,QWORD PTR [rbp-0xa70]
    29e6:	lea    rdi,[rip+0x1780]        # 416d <_IO_stdin_used+0x16d>
    29ed:	vxorpd xmm5,xmm5,xmm5
    29f1:	mov    r8,QWORD PTR [rbp-0xa80]
    29f8:	vcvtsi2sd xmm1,xmm5,r13
    29fd:	xor    r9d,r9d
    2a00:	lea    rsi,[rip+0x16d1]        # 40d8 <_IO_stdin_used+0xd8>
    2a07:	vsubsd xmm0,xmm3,QWORD PTR [rbp-0xa78]
    2a0f:	push   rdi
    2a10:	mov    edi,0x2
    2a15:	push   rcx
    2a16:	mov    rcx,QWORD PTR [rbp-0xa40]
    2a1d:	push   rdx
    2a1e:	mov    rdx,rbx
    2a21:	push   rax
    2a22:	mov    eax,0x2
    2a27:	push   r13
    2a29:	push   r15
    2a2b:	call   2230 <__printf_chk@plt>
    2a30:	mov    rdi,QWORD PTR [rip+0x35e9]        # 6020 <stdout@GLIBC_2.2.5>
    2a37:	add    rsp,0x30
    2a3b:	call   2330 <fflush@plt>
    2a40:	inc    r15d
    2a43:	cmp    DWORD PTR [rbp-0xa84],r15d
    2a4a:	je     2b70 <main+0x6e0>
    2a50:	cmp    BYTE PTR [rbp-0xa44],0x0
    2a57:	je     2a87 <main+0x5f7>
    2a59:	mov    edi,DWORD PTR [rbp-0xa50]
    2a5f:	mov    edx,0x1
    2a64:	mov    esi,0x2403
    2a69:	xor    eax,eax
    2a6b:	call   23a0 <ioctl@plt>
    2a70:	mov    edi,DWORD PTR [rbp-0xa50]
    2a76:	mov    edx,0x1
    2a7b:	mov    esi,0x2400
    2a80:	xor    eax,eax
    2a82:	call   23a0 <ioctl@plt>
    2a87:	mov    rsi,QWORD PTR [rbp-0xa68]
    2a8e:	mov    edi,0x4
    2a93:	call   22f0 <clock_gettime@plt>
    2a98:	vxorpd xmm2,xmm2,xmm2
    2a9c:	mov    rdi,r12
    2a9f:	mov    rsi,r13
    2aa2:	vcvtsi2sd xmm0,xmm2,QWORD PTR [rbp-0xa60]
    2aab:	vmovsd xmm1,xmm0,xmm0
    2aaf:	vcvtsi2sd xmm0,xmm2,QWORD PTR [rbp-0xa58]
    2ab8:	vfmadd132sd xmm1,xmm0,QWORD PTR [rip+0x16d7]        # 4198 <_IO_stdin_used+0x198>
    2ac1:	vmovsd QWORD PTR [rbp-0xa78],xmm1
    2ac9:	call   2e30 <chase(Node*, unsigned long)>
    2ace:	mov    rsi,QWORD PTR [rbp-0xa68]
    2ad5:	mov    edi,0x4
    2ada:	vzeroupper
    2add:	mov    r12,rax
    2ae0:	call   22f0 <clock_gettime@plt>
    2ae5:	vxorpd xmm2,xmm2,xmm2
    2ae9:	cmp    BYTE PTR [rbp-0xa44],0x0
    2af0:	vcvtsi2sd xmm0,xmm2,QWORD PTR [rbp-0xa60]
    2af9:	vcvtsi2sd xmm1,xmm2,QWORD PTR [rbp-0xa58]
    2b02:	vfmadd132sd xmm0,xmm1,QWORD PTR [rip+0x168d]        # 4198 <_IO_stdin_used+0x198>
    2b0b:	vmovsd QWORD PTR [rbp-0xa70],xmm0
    2b13:	je     29d8 <main+0x548>
    2b19:	mov    edi,DWORD PTR [rbp-0xa50]
    2b1f:	mov    edx,0x1
    2b24:	mov    esi,0x2401
    2b29:	xor    eax,eax
    2b2b:	call   23a0 <ioctl@plt>
    2b30:	mov    rsi,QWORD PTR [rbp-0xa90]
    2b37:	mov    edi,DWORD PTR [rbp-0xa50]
    2b3d:	mov    edx,0x20
    2b42:	call   23b0 <read@plt>
    2b47:	cmp    rax,0x20
    2b4b:	jne    29d8 <main+0x548>
    2b51:	mov    rax,QWORD PTR [rbp-0xa18]
    2b58:	mov    rdx,QWORD PTR [rbp-0xa10]
    2b5f:	mov    rcx,QWORD PTR [rbp-0xa08]
    2b66:	jmp    29de <main+0x54e>
    2b6b:	vzeroupper
    2b6e:	xchg   ax,ax
    2b70:	mov    rdi,r14
    2b73:	call   2340 <free@plt>
    2b78:	vmovsd xmm7,QWORD PTR [rbp-0xa98]
    2b80:	vaddsd xmm7,xmm7,QWORD PTR [rip+0x1618]        # 41a0 <_IO_stdin_used+0x1a0>
    2b88:	vmovsd QWORD PTR [rbp-0xa98],xmm7
    2b90:	jmp    26d8 <main+0x248>
    2b95:	nop    DWORD PTR [rax]
    2b98:	mov    rax,QWORD PTR [rbp-0xa80]
    2b9f:	mov    edi,0x1000
    2ba4:	lea    r12,[rax+0xfff]
    2bab:	and    r12,0xfffffffffffff000
    2bb2:	mov    rsi,r12
    2bb5:	call   22c0 <aligned_alloc@plt>
    2bba:	mov    r14,rax
    2bbd:	test   rax,rax
    2bc0:	jne    2773 <main+0x2e3>
    2bc6:	jmp    2470 <main.cold+0x50>
    2bcb:	nop    DWORD PTR [rax+rax*1+0x0]
    2bd0:	cmp    BYTE PTR [rbp-0xa85],0x0
    2bd7:	mov    QWORD PTR [rbp-0xa78],0x0
    2be2:	mov    r15d,0x0
    2be8:	je     2952 <main+0x4c2>
    2bee:	mov    rsi,0xffffffffffffffff
    2bf5:	jmp    281d <main+0x38d>
    2bfa:	nop    WORD PTR [rax+rax*1+0x0]
    2c00:	mov    QWORD PTR [r15],0x0
    2c07:	mov    rcx,QWORD PTR [rbp-0xaa0]
    2c0e:	mov    eax,0x1
    2c13:	cmp    rbx,0x1
    2c17:	jne    27f0 <main+0x360>
    2c1d:	jmp    280c <main+0x37c>
    2c22:	cmp    BYTE PTR [rbp-0xa85],0x0
    2c29:	je     2c6e <main+0x7de>
    2c2b:	mov    QWORD PTR [r14],r14
    2c2e:	mov    QWORD PTR [rbp-0xa78],0x8
    2c39:	jmp    2952 <main+0x4c2>
    2c3e:	lea    rdi,[rbp-0xa40]
    2c45:	call   2380 <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >::_M_dispose()@plt>
    2c4a:	mov    rax,QWORD PTR [rbp-0x38]
    2c4e:	sub    rax,QWORD PTR fs:0x28
    2c57:	jne    2cfc <main+0x86c>
    2c5d:	lea    rsp,[rbp-0x28]
    2c61:	xor    eax,eax
    2c63:	pop    rbx
    2c64:	pop    r12
    2c66:	pop    r13
    2c68:	pop    r14
    2c6a:	pop    r15
    2c6c:	pop    rbp
    2c6d:	ret
    2c6e:	mov    QWORD PTR [rbp-0xa78],0x8
    2c79:	jmp    290f <main+0x47f>
    2c7e:	lea    rax,[rbp-0xa00]
    2c85:	mov    rsi,QWORD PTR [rsi+0x8]
    2c89:	lea    rdx,[rbp-0xa60]
    2c90:	mov    rdi,rax
    2c93:	mov    QWORD PTR [rbp-0xa68],rdx
    2c9a:	mov    QWORD PTR [rbp-0xaa0],rax
    2ca1:	call   3020 <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >::basic_string<std::allocator<char> >(char const*, std::allocator<char> const&)>
    2ca6:	cmp    QWORD PTR [rbp-0x9f8],0xa
    2cae:	mov    BYTE PTR [rbp-0xa85],0x1
    2cb5:	jne    2cd8 <main+0x848>
    2cb7:	mov    rdi,QWORD PTR [rbp-0xa00]
    2cbe:	mov    edx,0xa
    2cc3:	lea    rsi,[rip+0x144d]        # 4117 <_IO_stdin_used+0x117>
    2cca:	call   2270 <memcmp@plt>
    2ccf:	test   eax,eax
    2cd1:	setne  BYTE PTR [rbp-0xa85]
    2cd8:	mov    rdi,QWORD PTR [rbp-0xaa0]
    2cdf:	call   2380 <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >::_M_dispose()@plt>
    2ce4:	jmp    24e3 <main+0x53>
    2ce9:	inc    ecx
    2ceb:	mov    rdi,r8
    2cee:	mov    rsi,r9
    2cf1:	rep movs BYTE PTR es:[rdi],BYTE PTR ds:[rsi]
    2cf3:	mov    rcx,QWORD PTR [rax+0x8]
    2cf7:	jmp    2688 <main+0x1f8>
    2cfc:	call   2320 <__stack_chk_fail@plt>
    2d01:	mov    rax,QWORD PTR [rbp-0x38]
    2d05:	sub    rax,QWORD PTR fs:0x28
    2d0e:	jne    2cfc <main+0x86c>
    2d10:	lea    rdi,[rip+0x142c]        # 4143 <_IO_stdin_used+0x143>
    2d17:	call   2290 <std::__throw_length_error(char const*)@plt>
    2d1c:	endbr64
    2d20:	mov    rbx,rax
    2d23:	jmp    2420 <main.cold>
    2d28:	endbr64
    2d2c:	jmp    244a <main.cold+0x2a>
    2d31:	jmp    2470 <main.cold+0x50>
    2d36:	cs nop WORD PTR [rax+rax*1+0x0]

0000000000002d40 <_start>:
    2d40:	endbr64
    2d44:	xor    ebp,ebp
    2d46:	mov    r9,rdx
    2d49:	pop    rsi
    2d4a:	mov    rdx,rsp
    2d4d:	and    rsp,0xfffffffffffffff0
    2d51:	push   rax
    2d52:	push   rsp
    2d53:	xor    r8d,r8d
    2d56:	xor    ecx,ecx
    2d58:	lea    rdi,[rip+0xfffffffffffff731]        # 2490 <main>
    2d5f:	call   QWORD PTR [rip+0x327b]        # 5fe0 <__libc_start_main@GLIBC_2.34>
    2d65:	hlt
    2d66:	cs nop WORD PTR [rax+rax*1+0x0]

0000000000002d70 <deregister_tm_clones>:
    2d70:	lea    rdi,[rip+0x32a1]        # 6018 <__TMC_END__>
    2d77:	lea    rax,[rip+0x329a]        # 6018 <__TMC_END__>
    2d7e:	cmp    rax,rdi
    2d81:	je     2d98 <deregister_tm_clones+0x28>
    2d83:	mov    rax,QWORD PTR [rip+0x325e]        # 5fe8 <_ITM_deregisterTMCloneTable@Base>
    2d8a:	test   rax,rax
    2d8d:	je     2d98 <deregister_tm_clones+0x28>
    2d8f:	jmp    rax
    2d91:	nop    DWORD PTR [rax+0x0]
    2d98:	ret
    2d99:	nop    DWORD PTR [rax+0x0]

0000000000002da0 <register_tm_clones>:
    2da0:	lea    rdi,[rip+0x3271]        # 6018 <__TMC_END__>
    2da7:	lea    rsi,[rip+0x326a]        # 6018 <__TMC_END__>
    2dae:	sub    rsi,rdi
    2db1:	mov    rax,rsi
    2db4:	shr    rsi,0x3f
    2db8:	sar    rax,0x3
    2dbc:	add    rsi,rax
    2dbf:	sar    rsi,1
    2dc2:	je     2dd8 <register_tm_clones+0x38>
    2dc4:	mov    rax,QWORD PTR [rip+0x322d]        # 5ff8 <_ITM_registerTMCloneTable@Base>
    2dcb:	test   rax,rax
    2dce:	je     2dd8 <register_tm_clones+0x38>
    2dd0:	jmp    rax
    2dd2:	nop    WORD PTR [rax+rax*1+0x0]
    2dd8:	ret
    2dd9:	nop    DWORD PTR [rax+0x0]

0000000000002de0 <__do_global_dtors_aux>:
    2de0:	endbr64
    2de4:	cmp    BYTE PTR [rip+0x325d],0x0        # 6048 <completed.0>
    2deb:	jne    2e18 <__do_global_dtors_aux+0x38>
    2ded:	push   rbp
    2dee:	cmp    QWORD PTR [rip+0x31e2],0x0        # 5fd8 <__cxa_finalize@GLIBC_2.2.5>
    2df6:	mov    rbp,rsp
    2df9:	je     2e07 <__do_global_dtors_aux+0x27>
    2dfb:	mov    rdi,QWORD PTR [rip+0x3206]        # 6008 <__dso_handle>
    2e02:	call   2220 <__cxa_finalize@plt>
    2e07:	call   2d70 <deregister_tm_clones>
    2e0c:	mov    BYTE PTR [rip+0x3235],0x1        # 6048 <completed.0>
    2e13:	pop    rbp
    2e14:	ret
    2e15:	nop    DWORD PTR [rax]
    2e18:	ret
    2e19:	nop    DWORD PTR [rax+0x0]

0000000000002e20 <frame_dummy>:
    2e20:	endbr64
    2e24:	jmp    2da0 <register_tm_clones>
    2e29:	nop    DWORD PTR [rax+0x0]

0000000000002e30 <chase(Node*, unsigned long)>:
    2e30:	mov    rax,rdi
    2e33:	test   rsi,rsi
    2e36:	je     2e61 <chase(Node*, unsigned long)+0x31>
    2e38:	xor    edx,edx
    2e3a:	nop    WORD PTR [rax+rax*1+0x0]
    2e40:	mov    rax,QWORD PTR [rax]
    2e43:	add    rdx,0x8
    2e47:	mov    rax,QWORD PTR [rax]
    2e4a:	mov    rax,QWORD PTR [rax]
    2e4d:	mov    rax,QWORD PTR [rax]
    2e50:	mov    rax,QWORD PTR [rax]
    2e53:	mov    rax,QWORD PTR [rax]
    2e56:	mov    rax,QWORD PTR [rax]
    2e59:	mov    rax,QWORD PTR [rax]
    2e5c:	cmp    rdx,rsi
    2e5f:	jb     2e40 <chase(Node*, unsigned long)+0x10>
    2e61:	ret
    2e62:	data16 cs nop WORD PTR [rax+rax*1+0x0]
    2e6d:	nop    DWORD PTR [rax]

0000000000002e70 <env_long(char const*, long)>:
    2e70:	push   rbx
    2e71:	mov    rbx,rsi
    2e74:	call   2370 <getenv@plt>
    2e79:	test   rax,rax
    2e7c:	je     2e8e <env_long(char const*, long)+0x1e>
    2e7e:	mov    edx,0xa
    2e83:	xor    esi,esi
    2e85:	mov    rdi,rax
    2e88:	pop    rbx
    2e89:	jmp    2410 <__isoc23_strtol@plt>
    2e8e:	mov    rax,rbx
    2e91:	pop    rbx
    2e92:	ret
    2e93:	cs nop WORD PTR [rax+rax*1+0x0]
    2e9d:	nop    DWORD PTR [rax]

0000000000002ea0 <Counters::Counters()>:
    2ea0:	endbr64
    2ea4:	push   rbp
    2ea5:	mov    rbp,rsp
    2ea8:	push   r14
    2eaa:	push   r13
    2eac:	mov    r13,rdi
    2eaf:	push   r12
    2eb1:	push   rbx
    2eb2:	xor    ebx,ebx
    2eb4:	sub    rsp,0xb0
    2ebb:	mov    rax,QWORD PTR fs:0x28
    2ec4:	mov    QWORD PTR [rsp+0xa8],rax
    2ecc:	xor    eax,eax
    2ece:	vmovdqa xmm0,XMMWORD PTR [rip+0x12aa]        # 4180 <_IO_stdin_used+0x180>
    2ed6:	mov    QWORD PTR [rdi],0xffffffffffffffff
    2edd:	mov    r12,rsp
    2ee0:	mov    DWORD PTR [rdi+0x8],0xffffffff
    2ee7:	lea    r14,[rsp+0x90]
    2eef:	mov    BYTE PTR [rdi+0xc],0x0
    2ef3:	mov    QWORD PTR [rsp+0xa0],0x1
    2eff:	vmovdqa XMMWORD PTR [rsp+0x90],xmm0
    2f08:	vpxor  xmm0,xmm0,xmm0
    2f0c:	mov    rax,QWORD PTR [r14+rbx*8]
    2f10:	test   ebx,ebx
    2f12:	vmovdqu8 ZMMWORD PTR [r12],zmm0
    2f19:	mov    QWORD PTR [r12+0x80],0x0
    2f25:	mov    QWORD PTR [rsp+0x8],rax
    2f2a:	sete   al
    2f2d:	xor    r9d,r9d
    2f30:	or     eax,0x40
    2f33:	mov    DWORD PTR [rsp+0x4],0x88
    2f3b:	mov    QWORD PTR [rsp+0x20],0x8
    2f44:	mov    BYTE PTR [rsp+0x28],al
    2f48:	vmovdqu8 ZMMWORD PTR [r12+0x40],zmm0
    2f50:	test   rbx,rbx
    2f53:	je     2f90 <Counters::Counters()+0xf0>
    2f55:	mov    r8d,DWORD PTR [r13+0x0]
    2f59:	xor    edx,edx
    2f5b:	xor    eax,eax
    2f5d:	mov    ecx,0xffffffff
    2f62:	mov    rsi,r12
    2f65:	mov    edi,0x12a
    2f6a:	vzeroupper
    2f6d:	call   2240 <syscall@plt>
    2f72:	vpxor  xmm0,xmm0,xmm0
    2f76:	test   eax,eax
    2f78:	mov    DWORD PTR [r13+rbx*4+0x0],eax
    2f7d:	js     2ff0 <Counters::Counters()+0x150>
    2f7f:	cmp    rbx,0x2
    2f83:	je     2fc8 <Counters::Counters()+0x128>
    2f85:	mov    ebx,0x2
    2f8a:	jmp    2f0c <Counters::Counters()+0x6c>
    2f8c:	nop    DWORD PTR [rax+0x0]
    2f90:	xor    edx,edx
    2f92:	xor    eax,eax
    2f94:	mov    r8d,0xffffffff
    2f9a:	mov    ecx,0xffffffff
    2f9f:	mov    rsi,r12
    2fa2:	mov    edi,0x12a
    2fa7:	vzeroupper
    2faa:	call   2240 <syscall@plt>
    2faf:	vpxor  xmm0,xmm0,xmm0
    2fb3:	test   eax,eax
    2fb5:	mov    DWORD PTR [r13+0x0],eax
    2fb9:	js     2ff0 <Counters::Counters()+0x150>
    2fbb:	mov    ebx,0x1
    2fc0:	jmp    2f0c <Counters::Counters()+0x6c>
    2fc5:	nop    DWORD PTR [rax]
    2fc8:	mov    BYTE PTR [r13+0xc],0x1
    2fcd:	mov    rax,QWORD PTR [rsp+0xa8]
    2fd5:	sub    rax,QWORD PTR fs:0x28
    2fde:	jne    300c <Counters::Counters()+0x16c>
    2fe0:	add    rsp,0xb0
    2fe7:	pop    rbx
    2fe8:	pop    r12
    2fea:	pop    r13
    2fec:	pop    r14
    2fee:	pop    rbp
    2fef:	ret
    2ff0:	mov    rdi,QWORD PTR [rip+0x3049]        # 6040 <stderr@GLIBC_2.2.5>
    2ff7:	lea    rdx,[rip+0x100a]        # 4008 <_IO_stdin_used+0x8>
    2ffe:	mov    esi,0x2
    3003:	xor    eax,eax
    3005:	call   23c0 <__fprintf_chk@plt>
    300a:	jmp    2fcd <Counters::Counters()+0x12d>
    300c:	call   2320 <__stack_chk_fail@plt>
    3011:	cs nop WORD PTR [rax+rax*1+0x0]
    301b:	nop    DWORD PTR [rax+rax*1+0x0]

0000000000003020 <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >::basic_string<std::allocator<char> >(char const*, std::allocator<char> const&)>:
    3020:	endbr64
    3024:	push   r13
    3026:	lea    r13,[rdi+0x10]
    302a:	push   r12
    302c:	push   rbp
    302d:	push   rbx
    302e:	sub    rsp,0x18
    3032:	mov    rax,QWORD PTR fs:0x28
    303b:	mov    QWORD PTR [rsp+0x8],rax
    3040:	xor    eax,eax
    3042:	mov    QWORD PTR [rdi],r13
    3045:	test   rsi,rsi
    3048:	je     30e7 <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >::basic_string<std::allocator<char> >(char const*, std::allocator<char> const&)+0xc7>
    304e:	mov    rbx,rdi
    3051:	mov    rdi,rsi
    3054:	mov    r12,rsi
    3057:	call   2260 <strlen@plt>
    305c:	mov    QWORD PTR [rsp],rax
    3060:	mov    rbp,rax
    3063:	cmp    rax,0xf
    3067:	ja     30b0 <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >::basic_string<std::allocator<char> >(char const*, std::allocator<char> const&)+0x90>
    3069:	cmp    rax,0x1
    306d:	jne    30a0 <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >::basic_string<std::allocator<char> >(char const*, std::allocator<char> const&)+0x80>
    306f:	movzx  edx,BYTE PTR [r12]
    3074:	mov    BYTE PTR [rbx+0x10],dl
    3077:	mov    QWORD PTR [rbx+0x8],rax
    307b:	mov    BYTE PTR [r13+rax*1+0x0],0x0
    3081:	mov    rax,QWORD PTR [rsp+0x8]
    3086:	sub    rax,QWORD PTR fs:0x28
    308f:	jne    30e2 <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >::basic_string<std::allocator<char> >(char const*, std::allocator<char> const&)+0xc2>
    3091:	add    rsp,0x18
    3095:	pop    rbx
    3096:	pop    rbp
    3097:	pop    r12
    3099:	pop    r13
    309b:	ret
    309c:	nop    DWORD PTR [rax+0x0]
    30a0:	test   rax,rax
    30a3:	je     3077 <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >::basic_string<std::allocator<char> >(char const*, std::allocator<char> const&)+0x57>
    30a5:	jmp    30cb <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >::basic_string<std::allocator<char> >(char const*, std::allocator<char> const&)+0xab>
    30a7:	nop    WORD PTR [rax+rax*1+0x0]
    30b0:	mov    rsi,rsp
    30b3:	xor    edx,edx
    30b5:	mov    rdi,rbx
    30b8:	call   2400 <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >::_M_create(unsigned long&, unsigned long)@plt>
    30bd:	mov    QWORD PTR [rbx],rax
    30c0:	mov    r13,rax
    30c3:	mov    rax,QWORD PTR [rsp]
    30c7:	mov    QWORD PTR [rbx+0x10],rax
    30cb:	mov    rdi,r13
    30ce:	mov    rdx,rbp
    30d1:	mov    rsi,r12
    30d4:	call   22d0 <memcpy@plt>
    30d9:	mov    rax,QWORD PTR [rsp]
    30dd:	mov    r13,QWORD PTR [rbx]
    30e0:	jmp    3077 <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >::basic_string<std::allocator<char> >(char const*, std::allocator<char> const&)+0x57>
    30e2:	call   2320 <__stack_chk_fail@plt>
    30e7:	mov    rax,QWORD PTR [rsp+0x8]
    30ec:	sub    rax,QWORD PTR fs:0x28
    30f5:	jne    30e2 <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >::basic_string<std::allocator<char> >(char const*, std::allocator<char> const&)+0xc2>
    30f7:	lea    rdi,[rip+0xf42]        # 4040 <_IO_stdin_used+0x40>
    30fe:	call   22b0 <std::__throw_logic_error(char const*)@plt>
    3103:	cs nop WORD PTR [rax+rax*1+0x0]
    310d:	nop    DWORD PTR [rax]

0000000000003110 <std::mersenne_twister_engine<unsigned long, 64ul, 312ul, 156ul, 31ul, 13043109905998158313ul, 29ul, 6148914691236517205ul, 17ul, 8202884508482404352ul, 37ul, 18444473444759240704ul, 43ul, 6364136223846793005ul>::_M_gen_rand()>:
    3110:	endbr64
    3114:	mov    rcx,0xffffffff80000000
    311b:	mov    r8,rdi
    311e:	mov    rdx,rdi
    3121:	mov    rax,rdi
    3124:	vpbroadcastq ymm5,rcx
    312a:	lea    rsi,[rdi+0x4e0]
    3131:	vpxor  xmm6,xmm6,xmm6
    3135:	mov    ecx,0x7fffffff
    313a:	vpbroadcastq ymm4,rcx
    3140:	mov    ecx,0x1
    3145:	vpbroadcastq ymm3,rcx
    314b:	movabs rcx,0xb5026f5aa96619e9
    3155:	vpbroadcastq ymm2,rcx
    315b:	nop    DWORD PTR [rax+rax*1+0x0]
    3160:	vpand  ymm0,ymm4,YMMWORD PTR [rax+0x8]
    3165:	add    rax,0x20
    3169:	vpternlogq ymm0,ymm5,YMMWORD PTR [rax-0x20],0xf8
    3171:	vpsrlq ymm1,ymm0,0x1
    3176:	vpand  ymm0,ymm0,ymm3
    317a:	vpsubq ymm0,ymm6,ymm0
    317e:	vpand  ymm0,ymm0,ymm2
    3182:	vpternlogq ymm0,ymm1,YMMWORD PTR [rax+0x4c0],0x96
    318a:	vmovdqu YMMWORD PTR [rax-0x20],ymm0
    318f:	cmp    rax,rsi
    3192:	jne    3160 <std::mersenne_twister_engine<unsigned long, 64ul, 312ul, 156ul, 31ul, 13043109905998158313ul, 29ul, 6148914691236517205ul, 17ul, 8202884508482404352ul, 37ul, 18444473444759240704ul, 43ul, 6364136223846793005ul>::_M_gen_rand()+0x50>
    3194:	mov    rsi,QWORD PTR [r8+0x4e0]
    319b:	lea    r9,[r8+0x4d8]
    31a2:	movabs rdi,0xb5026f5aa96619e9
    31ac:	nop    DWORD PTR [rax+0x0]
    31b0:	and    rsi,0xffffffff80000000
    31b7:	add    rdx,0x8
    31bb:	mov    rcx,rsi
    31be:	mov    rsi,QWORD PTR [rdx+0x4e0]
    31c5:	mov    rax,rsi
    31c8:	and    eax,0x7fffffff
    31cd:	or     rax,rcx
    31d0:	mov    rcx,rax
    31d3:	and    eax,0x1
    31d6:	shr    rcx,1
    31d9:	neg    rax
    31dc:	xor    rcx,QWORD PTR [rdx-0x8]
    31e0:	and    rax,rdi
    31e3:	xor    rax,rcx
    31e6:	mov    QWORD PTR [rdx+0x4d8],rax
    31ed:	cmp    rdx,r9
    31f0:	jne    31b0 <std::mersenne_twister_engine<unsigned long, 64ul, 312ul, 156ul, 31ul, 13043109905998158313ul, 29ul, 6148914691236517205ul, 17ul, 8202884508482404352ul, 37ul, 18444473444759240704ul, 43ul, 6364136223846793005ul>::_M_gen_rand()+0xa0>
    31f2:	mov    rax,QWORD PTR [r8+0x9b8]
    31f9:	mov    rdx,QWORD PTR [r8]
    31fc:	mov    QWORD PTR [r8+0x9c0],0x0
    3207:	and    edx,0x7fffffff
    320d:	and    rax,0xffffffff80000000
    3213:	or     rax,rdx
    3216:	mov    rdx,rax
    3219:	and    eax,0x1
    321c:	shr    rdx,1
    321f:	neg    rax
    3222:	xor    rdx,QWORD PTR [r8+0x4d8]
    3229:	and    rax,rdi
    322c:	xor    rax,rdx
    322f:	mov    QWORD PTR [r8+0x9b8],rax
    3236:	vzeroupper
    3239:	ret
    323a:	nop    WORD PTR [rax+rax*1+0x0]

0000000000003240 <std::mersenne_twister_engine<unsigned long, 64ul, 312ul, 156ul, 31ul, 13043109905998158313ul, 29ul, 6148914691236517205ul, 17ul, 8202884508482404352ul, 37ul, 18444473444759240704ul, 43ul, 6364136223846793005ul>::operator()()>:
    3240:	endbr64
    3244:	mov    rax,QWORD PTR [rdi+0x9c0]
    324b:	push   rbx
    324c:	mov    rbx,rdi
    324f:	cmp    rax,0x137
    3255:	ja     32c0 <std::mersenne_twister_engine<unsigned long, 64ul, 312ul, 156ul, 31ul, 13043109905998158313ul, 29ul, 6148914691236517205ul, 17ul, 8202884508482404352ul, 37ul, 18444473444759240704ul, 43ul, 6364136223846793005ul>::operator()()+0x80>
    3257:	lea    rdx,[rax+0x1]
    325b:	mov    rax,QWORD PTR [rbx+rax*8]
    325f:	movabs rcx,0x5555555555555555
    3269:	mov    QWORD PTR [rbx+0x9c0],rdx
    3270:	mov    rdx,rax
    3273:	shr    rdx,0x1d
    3277:	and    rdx,rcx
    327a:	movabs rcx,0x71d67fffeda60000
    3284:	pop    rbx
    3285:	xor    rdx,rax
    3288:	mov    rax,rdx
    328b:	shl    rax,0x11
    328f:	and    rax,rcx
    3292:	movabs rcx,0xfff7eee000000000
    329c:	xor    rax,rdx
    329f:	mov    rdx,rax
    32a2:	shl    rdx,0x25
    32a6:	and    rdx,rcx
    32a9:	xor    rdx,rax
    32ac:	mov    rax,rdx
    32af:	shr    rax,0x2b
    32b3:	xor    rax,rdx
    32b6:	ret
    32b7:	nop    WORD PTR [rax+rax*1+0x0]
    32c0:	call   3110 <std::mersenne_twister_engine<unsigned long, 64ul, 312ul, 156ul, 31ul, 13043109905998158313ul, 29ul, 6148914691236517205ul, 17ul, 8202884508482404352ul, 37ul, 18444473444759240704ul, 43ul, 6364136223846793005ul>::_M_gen_rand()>
    32c5:	mov    rax,QWORD PTR [rbx+0x9c0]
    32cc:	jmp    3257 <std::mersenne_twister_engine<unsigned long, 64ul, 312ul, 156ul, 31ul, 13043109905998158313ul, 29ul, 6148914691236517205ul, 17ul, 8202884508482404352ul, 37ul, 18444473444759240704ul, 43ul, 6364136223846793005ul>::operator()()+0x17>

Disassembly of section .fini:

00000000000032d0 <_fini>:
    32d0:	endbr64
    32d4:	sub    rsp,0x8
    32d8:	add    rsp,0x8
    32dc:	ret
