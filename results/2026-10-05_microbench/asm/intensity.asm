
bin/intensity:     file format elf64-x86-64


Disassembly of section .init:

0000000000002000 <_init>:
    2000:	endbr64
    2004:	sub    rsp,0x8
    2008:	mov    rax,QWORD PTR [rip+0x6fe1]        # 8ff0 <__gmon_start__@Base>
    200f:	test   rax,rax
    2012:	je     2016 <_init+0x16>
    2014:	call   rax
    2016:	add    rsp,0x8
    201a:	ret

Disassembly of section .plt:

0000000000002020 <.plt>:
    2020:	push   QWORD PTR [rip+0x6eb2]        # 8ed8 <_GLOBAL_OFFSET_TABLE_+0x8>
    2026:	jmp    QWORD PTR [rip+0x6eb4]        # 8ee0 <_GLOBAL_OFFSET_TABLE_+0x10>
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

Disassembly of section .plt.got:

0000000000002210 <__cxa_finalize@plt>:
    2210:	endbr64
    2214:	jmp    QWORD PTR [rip+0x6dbe]        # 8fd8 <__cxa_finalize@GLIBC_2.2.5>
    221a:	nop    WORD PTR [rax+rax*1+0x0]

Disassembly of section .plt.sec:

0000000000002220 <__printf_chk@plt>:
    2220:	endbr64
    2224:	jmp    QWORD PTR [rip+0x6cbe]        # 8ee8 <__printf_chk@GLIBC_2.3.4>
    222a:	nop    WORD PTR [rax+rax*1+0x0]

0000000000002230 <syscall@plt>:
    2230:	endbr64
    2234:	jmp    QWORD PTR [rip+0x6cb6]        # 8ef0 <syscall@GLIBC_2.2.5>
    223a:	nop    WORD PTR [rax+rax*1+0x0]

0000000000002240 <strlen@plt>:
    2240:	endbr64
    2244:	jmp    QWORD PTR [rip+0x6cae]        # 8ef8 <strlen@GLIBC_2.2.5>
    224a:	nop    WORD PTR [rax+rax*1+0x0]

0000000000002250 <std::__throw_length_error(char const*)@plt>:
    2250:	endbr64
    2254:	jmp    QWORD PTR [rip+0x6ca6]        # 8f00 <std::__throw_length_error(char const*)@GLIBCXX_3.4>
    225a:	nop    WORD PTR [rax+rax*1+0x0]

0000000000002260 <aligned_alloc@plt>:
    2260:	endbr64
    2264:	jmp    QWORD PTR [rip+0x6c9e]        # 8f08 <aligned_alloc@GLIBC_2.16>
    226a:	nop    WORD PTR [rax+rax*1+0x0]

0000000000002270 <std::__cxx11::basic_stringstream<char, std::char_traits<char>, std::allocator<char> >::~basic_stringstream()@plt>:
    2270:	endbr64
    2274:	jmp    QWORD PTR [rip+0x6c96]        # 8f10 <std::__cxx11::basic_stringstream<char, std::char_traits<char>, std::allocator<char> >::~basic_stringstream()@GLIBCXX_3.4.21>
    227a:	nop    WORD PTR [rax+rax*1+0x0]

0000000000002280 <memcpy@plt>:
    2280:	endbr64
    2284:	jmp    QWORD PTR [rip+0x6c8e]        # 8f18 <memcpy@GLIBC_2.14>
    228a:	nop    WORD PTR [rax+rax*1+0x0]

0000000000002290 <perror@plt>:
    2290:	endbr64
    2294:	jmp    QWORD PTR [rip+0x6c86]        # 8f20 <perror@GLIBC_2.2.5>
    229a:	nop    WORD PTR [rax+rax*1+0x0]

00000000000022a0 <clock_gettime@plt>:
    22a0:	endbr64
    22a4:	jmp    QWORD PTR [rip+0x6c7e]        # 8f28 <clock_gettime@GLIBC_2.17>
    22aa:	nop    WORD PTR [rax+rax*1+0x0]

00000000000022b0 <operator new(unsigned long)@plt>:
    22b0:	endbr64
    22b4:	jmp    QWORD PTR [rip+0x6c76]        # 8f30 <operator new(unsigned long)@GLIBCXX_3.4>
    22ba:	nop    WORD PTR [rax+rax*1+0x0]

00000000000022c0 <operator delete(void*, unsigned long)@plt>:
    22c0:	endbr64
    22c4:	jmp    QWORD PTR [rip+0x6c6e]        # 8f38 <operator delete(void*, unsigned long)@CXXABI_1.3.9>
    22ca:	nop    WORD PTR [rax+rax*1+0x0]

00000000000022d0 <__stack_chk_fail@plt>:
    22d0:	endbr64
    22d4:	jmp    QWORD PTR [rip+0x6c66]        # 8f40 <__stack_chk_fail@GLIBC_2.4>
    22da:	nop    WORD PTR [rax+rax*1+0x0]

00000000000022e0 <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >::_M_construct(unsigned long, char)@plt>:
    22e0:	endbr64
    22e4:	jmp    QWORD PTR [rip+0x6c5e]        # 8f48 <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >::_M_construct(unsigned long, char)@GLIBCXX_3.4.21>
    22ea:	nop    WORD PTR [rax+rax*1+0x0]

00000000000022f0 <fflush@plt>:
    22f0:	endbr64
    22f4:	jmp    QWORD PTR [rip+0x6c56]        # 8f50 <fflush@GLIBC_2.2.5>
    22fa:	nop    WORD PTR [rax+rax*1+0x0]

0000000000002300 <free@plt>:
    2300:	endbr64
    2304:	jmp    QWORD PTR [rip+0x6c4e]        # 8f58 <free@GLIBC_2.2.5>
    230a:	nop    WORD PTR [rax+rax*1+0x0]

0000000000002310 <madvise@plt>:
    2310:	endbr64
    2314:	jmp    QWORD PTR [rip+0x6c46]        # 8f60 <madvise@GLIBC_2.2.5>
    231a:	nop    WORD PTR [rax+rax*1+0x0]

0000000000002320 <exit@plt>:
    2320:	endbr64
    2324:	jmp    QWORD PTR [rip+0x6c3e]        # 8f68 <exit@GLIBC_2.2.5>
    232a:	nop    WORD PTR [rax+rax*1+0x0]

0000000000002330 <getenv@plt>:
    2330:	endbr64
    2334:	jmp    QWORD PTR [rip+0x6c36]        # 8f70 <getenv@GLIBC_2.2.5>
    233a:	nop    WORD PTR [rax+rax*1+0x0]

0000000000002340 <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >::_M_dispose()@plt>:
    2340:	endbr64
    2344:	jmp    QWORD PTR [rip+0x6c2e]        # 8f78 <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >::_M_dispose()@GLIBCXX_3.4.21>
    234a:	nop    WORD PTR [rax+rax*1+0x0]

0000000000002350 <__memset_chk@plt>:
    2350:	endbr64
    2354:	jmp    QWORD PTR [rip+0x6c26]        # 8f80 <__memset_chk@GLIBC_2.3.4>
    235a:	nop    WORD PTR [rax+rax*1+0x0]

0000000000002360 <ioctl@plt>:
    2360:	endbr64
    2364:	jmp    QWORD PTR [rip+0x6c1e]        # 8f88 <ioctl@GLIBC_2.2.5>
    236a:	nop    WORD PTR [rax+rax*1+0x0]

0000000000002370 <read@plt>:
    2370:	endbr64
    2374:	jmp    QWORD PTR [rip+0x6c16]        # 8f90 <read@GLIBC_2.2.5>
    237a:	nop    WORD PTR [rax+rax*1+0x0]

0000000000002380 <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >::_M_replace(unsigned long, unsigned long, char const*, unsigned long)@plt>:
    2380:	endbr64
    2384:	jmp    QWORD PTR [rip+0x6c0e]        # 8f98 <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >::_M_replace(unsigned long, unsigned long, char const*, unsigned long)@GLIBCXX_3.4.21>
    238a:	nop    WORD PTR [rax+rax*1+0x0]

0000000000002390 <std::__cxx11::basic_stringstream<char, std::char_traits<char>, std::allocator<char> >::basic_stringstream(std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > const&, std::_Ios_Openmode)@plt>:
    2390:	endbr64
    2394:	jmp    QWORD PTR [rip+0x6c06]        # 8fa0 <std::__cxx11::basic_stringstream<char, std::char_traits<char>, std::allocator<char> >::basic_stringstream(std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > const&, std::_Ios_Openmode)@GLIBCXX_3.4.21>
    239a:	nop    WORD PTR [rax+rax*1+0x0]

00000000000023a0 <memmove@plt>:
    23a0:	endbr64
    23a4:	jmp    QWORD PTR [rip+0x6bfe]        # 8fa8 <memmove@GLIBC_2.2.5>
    23aa:	nop    WORD PTR [rax+rax*1+0x0]

00000000000023b0 <__fprintf_chk@plt>:
    23b0:	endbr64
    23b4:	jmp    QWORD PTR [rip+0x6bf6]        # 8fb0 <__fprintf_chk@GLIBC_2.3.4>
    23ba:	nop    WORD PTR [rax+rax*1+0x0]

00000000000023c0 <_Unwind_Resume@plt>:
    23c0:	endbr64
    23c4:	jmp    QWORD PTR [rip+0x6bee]        # 8fb8 <_Unwind_Resume@GCC_3.0>
    23ca:	nop    WORD PTR [rax+rax*1+0x0]

00000000000023d0 <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >::_M_create(unsigned long&, unsigned long)@plt>:
    23d0:	endbr64
    23d4:	jmp    QWORD PTR [rip+0x6be6]        # 8fc0 <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >::_M_create(unsigned long&, unsigned long)@GLIBCXX_3.4.21>
    23da:	nop    WORD PTR [rax+rax*1+0x0]

00000000000023e0 <std::basic_istream<char, std::char_traits<char> >& std::getline<char, std::char_traits<char>, std::allocator<char> >(std::basic_istream<char, std::char_traits<char> >&, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&, char)@plt>:
    23e0:	endbr64
    23e4:	jmp    QWORD PTR [rip+0x6bde]        # 8fc8 <std::basic_istream<char, std::char_traits<char> >& std::getline<char, std::char_traits<char>, std::allocator<char> >(std::basic_istream<char, std::char_traits<char> >&, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&, char)@GLIBCXX_3.4.21>
    23ea:	nop    WORD PTR [rax+rax*1+0x0]

00000000000023f0 <__isoc23_strtol@plt>:
    23f0:	endbr64
    23f4:	jmp    QWORD PTR [rip+0x6bd6]        # 8fd0 <__isoc23_strtol@GLIBC_2.38>
    23fa:	nop    WORD PTR [rax+rax*1+0x0]

Disassembly of section .text:

0000000000002400 <parse_list(char const*, std::vector<long, std::allocator<long> >) [clone .cold]>:
    2400:	mov    rdi,rbp
    2403:	vzeroupper
    2406:	lea    r14,[rsp+0x20]
    240b:	call   2340 <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >::_M_dispose()@plt>
    2410:	mov    rdi,r14
    2413:	call   5da0 <std::vector<long, std::allocator<long> >::~vector()>
    2418:	mov    rax,QWORD PTR [rsp+0x1e8]
    2420:	sub    rax,QWORD PTR fs:0x28
    2429:	jne    2448 <parse_list(char const*, std::vector<long, std::allocator<long> >) [clone .cold]+0x48>
    242b:	mov    rdi,rbx
    242e:	call   23c0 <_Unwind_Resume@plt>
    2433:	mov    rdi,rbp
    2436:	vzeroupper
    2439:	call   2340 <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >::_M_dispose()@plt>
    243e:	mov    rdi,r12
    2441:	call   2270 <std::__cxx11::basic_stringstream<char, std::char_traits<char>, std::allocator<char> >::~basic_stringstream()@plt>
    2446:	jmp    2410 <parse_list(char const*, std::vector<long, std::allocator<long> >) [clone .cold]+0x10>
    2448:	call   22d0 <__stack_chk_fail@plt>

000000000000244d <main.cold>:
    244d:	mov    rdi,QWORD PTR [rbp-0x280]
    2454:	vzeroupper
    2457:	call   2340 <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >::_M_dispose()@plt>
    245c:	mov    rdi,QWORD PTR [rbp-0x208]
    2463:	call   2340 <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >::_M_dispose()@plt>
    2468:	mov    rdi,QWORD PTR [rbp-0x2b0]
    246f:	call   5da0 <std::vector<long, std::allocator<long> >::~vector()>
    2474:	mov    rdi,QWORD PTR [rbp-0x2a8]
    247b:	call   5da0 <std::vector<long, std::allocator<long> >::~vector()>
    2480:	mov    rax,QWORD PTR [rbp-0x38]
    2484:	sub    rax,QWORD PTR fs:0x28
    248d:	jne    24b9 <main.cold+0x6c>
    248f:	mov    rdi,rbx
    2492:	call   23c0 <_Unwind_Resume@plt>
    2497:	lea    rdi,[rip+0x4ca3]        # 7141 <_IO_stdin_used+0x141>
    249e:	call   2290 <perror@plt>
    24a3:	mov    edi,0x1
    24a8:	call   2320 <exit@plt>
    24ad:	endbr64
    24b1:	mov    rbx,rax
    24b4:	vzeroupper
    24b7:	jmp    2468 <main.cold+0x1b>
    24b9:	call   22d0 <__stack_chk_fail@plt>
    24be:	mov    rdi,QWORD PTR [rbp-0x268]
    24c5:	vzeroupper
    24c8:	call   5da0 <std::vector<long, std::allocator<long> >::~vector()>
    24cd:	jmp    2474 <main.cold+0x27>
    24cf:	mov    rdi,QWORD PTR [rbp-0x268]
    24d6:	vzeroupper
    24d9:	call   5da0 <std::vector<long, std::allocator<long> >::~vector()>
    24de:	mov    rax,QWORD PTR [rbp-0x38]
    24e2:	sub    rax,QWORD PTR fs:0x28
    24eb:	jne    24f5 <main.cold+0xa8>
    24ed:	mov    rdi,rbx
    24f0:	call   23c0 <_Unwind_Resume@plt>
    24f5:	call   22d0 <__stack_chk_fail@plt>
    24fa:	nop    WORD PTR [rax+rax*1+0x0]

0000000000002500 <main>:
    2500:	endbr64
    2504:	lea    r10,[rsp+0x8]
    2509:	and    rsp,0xffffffffffffffe0
    250d:	lea    rdi,[rip+0x4c15]        # 7129 <_IO_stdin_used+0x129>
    2514:	push   QWORD PTR [r10-0x8]
    2518:	push   rbp
    2519:	mov    rbp,rsp
    251c:	push   r15
    251e:	push   r14
    2520:	push   r13
    2522:	push   r12
    2524:	push   r10
    2526:	push   rbx
    2527:	sub    rsp,0x280
    252e:	mov    rax,QWORD PTR fs:0x28
    2537:	mov    QWORD PTR [rbp-0x38],rax
    253b:	xor    eax,eax
    253d:	call   2330 <getenv@plt>
    2542:	mov    rdi,rax
    2545:	mov    eax,0x5
    254a:	test   rdi,rdi
    254d:	je     255b <main+0x5b>
    254f:	mov    edx,0xa
    2554:	xor    esi,esi
    2556:	call   23f0 <__isoc23_strtol@plt>
    255b:	lea    rdi,[rip+0x4bcc]        # 712e <_IO_stdin_used+0x12e>
    2562:	mov    DWORD PTR [rbp-0x200],eax
    2568:	call   2330 <getenv@plt>
    256d:	mov    QWORD PTR [rbp-0x298],0x0
    2578:	mov    rdi,rax
    257b:	test   rax,rax
    257e:	je     2593 <main+0x93>
    2580:	mov    edx,0xa
    2585:	xor    esi,esi
    2587:	call   23f0 <__isoc23_strtol@plt>
    258c:	mov    QWORD PTR [rbp-0x298],rax
    2593:	lea    rbx,[rbp-0x1a0]
    259a:	lea    r15,[rbp-0x150]
    25a1:	vmovdqa ymm0,YMMWORD PTR [rip+0x4bf7]        # 71a0 <_IO_stdin_used+0x1a0>
    25a9:	mov    edx,0x4
    25ae:	lea    r14,[rbp-0x1c0]
    25b5:	mov    QWORD PTR [rbp-0x280],r15
    25bc:	mov    rsi,r15
    25bf:	mov    rdi,rbx
    25c2:	mov    QWORD PTR [rbp-0x2b0],r14
    25c9:	mov    rcx,r14
    25cc:	mov    QWORD PTR [rbp-0x268],rbx
    25d3:	vmovdqa YMMWORD PTR [rbp-0x150],ymm0
    25db:	vzeroupper
    25de:	call   5dd0 <std::vector<long, std::allocator<long> >::vector(std::initializer_list<long>, std::allocator<long> const&)>
    25e3:	lea    rdi,[rip+0x4b48]        # 7132 <_IO_stdin_used+0x132>
    25ea:	call   2330 <getenv@plt>
    25ef:	lea    rdi,[rbp-0x1e0]
    25f6:	mov    rdx,rbx
    25f9:	mov    rsi,rax
    25fc:	mov    QWORD PTR [rbp-0x2a8],rdi
    2603:	call   59e0 <parse_list(char const*, std::vector<long, std::allocator<long> >)>
    2608:	mov    rdi,rbx
    260b:	call   5da0 <std::vector<long, std::allocator<long> >::~vector()>
    2610:	vmovdqa ymm0,YMMWORD PTR [rip+0x4ba8]        # 71c0 <_IO_stdin_used+0x1c0>
    2618:	lea    rcx,[rbp-0x1e1]
    261f:	mov    rsi,r15
    2622:	mov    edx,0x8
    2627:	mov    rdi,rbx
    262a:	vmovdqa YMMWORD PTR [rbp-0x150],ymm0
    2632:	vmovdqa ymm0,YMMWORD PTR [rip+0x4ba6]        # 71e0 <_IO_stdin_used+0x1e0>
    263a:	vmovdqa YMMWORD PTR [rbp-0x130],ymm0
    2642:	vzeroupper
    2645:	call   5dd0 <std::vector<long, std::allocator<long> >::vector(std::initializer_list<long>, std::allocator<long> const&)>
    264a:	lea    rdi,[rip+0x4ae9]        # 713a <_IO_stdin_used+0x13a>
    2651:	call   2330 <getenv@plt>
    2656:	mov    rdx,rbx
    2659:	mov    rdi,r14
    265c:	mov    rsi,rax
    265f:	call   59e0 <parse_list(char const*, std::vector<long, std::allocator<long> >)>
    2664:	mov    rdi,rbx
    2667:	call   5da0 <std::vector<long, std::allocator<long> >::~vector()>
    266c:	lea    rdi,[rbp-0x180]
    2673:	call   5c20 <Counters::Counters()>
    2678:	lea    rsi,[rip+0x4a01]        # 7080 <_IO_stdin_used+0x80>
    267f:	mov    edi,0x2
    2684:	xor    eax,eax
    2686:	call   2220 <__printf_chk@plt>
    268b:	mov    rax,QWORD PTR [rbp-0x1d8]
    2692:	mov    rsi,QWORD PTR [rbp-0x1e0]
    2699:	mov    QWORD PTR [rbp-0x2a0],rax
    26a0:	mov    QWORD PTR [rbp-0x290],rsi
    26a7:	cmp    rax,rsi
    26aa:	je     2d3c <main+0x83c>
    26b0:	mov    rax,QWORD PTR [rbp-0x290]
    26b7:	mov    rax,QWORD PTR [rax]
    26ba:	mov    QWORD PTR [rbp-0x1f8],rax
    26c1:	shl    rax,0xa
    26c5:	mov    rbx,rax
    26c8:	mov    rsi,rax
    26cb:	shr    rsi,0x2
    26cf:	shr    rbx,0x9
    26d3:	cmp    QWORD PTR [rbp-0x298],0x0
    26db:	mov    QWORD PTR [rbp-0x248],rsi
    26e2:	je     2e8d <main+0x98d>
    26e8:	add    rax,0x1fffff
    26ee:	mov    edi,0x200000
    26f3:	and    rax,0xffffffffffe00000
    26f9:	mov    rsi,rax
    26fc:	mov    r12,rax
    26ff:	call   2260 <aligned_alloc@plt>
    2704:	mov    QWORD PTR [rbp-0x250],rax
    270b:	test   rax,rax
    270e:	je     2ede <main+0x9de>
    2714:	mov    rdi,QWORD PTR [rbp-0x250]
    271b:	mov    edx,0xe
    2720:	mov    rsi,r12
    2723:	call   2310 <madvise@plt>
    2728:	mov    rdi,QWORD PTR [rbp-0x250]
    272f:	mov    rcx,r12
    2732:	mov    rdx,r12
    2735:	mov    esi,0x1
    273a:	call   2350 <__memset_chk@plt>
    273f:	cmp    QWORD PTR [rbp-0x248],0x0
    2747:	je     277c <main+0x27c>
    2749:	mov    rsi,QWORD PTR [rbp-0x250]
    2750:	mov    rdi,QWORD PTR [rbp-0x248]
    2757:	vbroadcastss ymm0,DWORD PTR [rip+0x48ac]        # 700c <_IO_stdin_used+0xc>
    2760:	mov    rax,rsi
    2763:	lea    rdx,[rsi+rdi*4]
    2767:	vmovaps YMMWORD PTR [rax],ymm0
    276b:	add    rax,0x40
    276f:	vmovaps YMMWORD PTR [rax-0x20],ymm0
    2774:	cmp    rdx,rax
    2777:	jne    2767 <main+0x267>
    2779:	vzeroupper
    277c:	mov    rax,QWORD PTR [rbp-0x1b8]
    2783:	mov    rsi,QWORD PTR [rbp-0x1c0]
    278a:	shl    rbx,0x9
    278e:	mov    QWORD PTR [rbp-0x270],rbx
    2795:	mov    QWORD PTR [rbp-0x288],rax
    279c:	mov    QWORD PTR [rbp-0x278],rsi
    27a3:	cmp    rsi,rax
    27a6:	je     2d14 <main+0x814>
    27ac:	nop    DWORD PTR [rax+0x0]
    27b0:	mov    rax,QWORD PTR [rbp-0x278]
    27b7:	xor    r14d,r14d
    27ba:	mov    rcx,QWORD PTR [rax]
    27bd:	lea    rax,[rip+0x647c]        # 8c40 <KERNELS>
    27c4:	mov    QWORD PTR [rbp-0x240],rcx
    27cb:	nop    DWORD PTR [rax+rax*1+0x0]
    27d0:	movsxd rdx,DWORD PTR [rax]
    27d3:	lea    rsi,[rip+0x64e6]        # 8cc0 <_DYNAMIC>
    27da:	cmp    rcx,rdx
    27dd:	cmove  r14,rax
    27e1:	add    rax,0x10
    27e5:	cmp    rsi,rax
    27e8:	jne    27d0 <main+0x2d0>
    27ea:	test   r14,r14
    27ed:	je     2cf8 <main+0x7f8>
    27f3:	vxorpd xmm5,xmm5,xmm5
    27f7:	vmovsd xmm7,QWORD PTR [rip+0x4a01]        # 7200 <_IO_stdin_used+0x200>
    27ff:	vmovsd xmm6,QWORD PTR [rip+0x4a09]        # 7210 <_IO_stdin_used+0x210>
    2807:	vcvtsi2sd xmm1,xmm5,QWORD PTR [rbp-0x240]
    2810:	vcvtsi2sd xmm0,xmm5,QWORD PTR [rbp-0x248]
    2819:	vmovsd xmm5,QWORD PTR [rip+0x49f7]        # 7218 <_IO_stdin_used+0x218>
    2821:	vmovsd QWORD PTR [rbp-0x260],xmm1
    2829:	vmovsd QWORD PTR [rbp-0x258],xmm0
    2831:	vmulsd xmm0,xmm7,xmm0
    2835:	vmovsd xmm7,xmm1,xmm1
    2839:	vmovsd xmm1,QWORD PTR [rip+0x49c7]        # 7208 <_IO_stdin_used+0x208>
    2841:	vfmadd132sd xmm1,xmm6,xmm7
    2846:	vmulsd xmm0,xmm0,xmm1
    284a:	vdivsd xmm0,xmm5,xmm0
    284e:	vcomisd xmm0,xmm6
    2852:	ja     2e56 <main+0x956>
    2858:	mov    DWORD PTR [rbp-0x1f8],0x1
    2862:	mov    rsi,QWORD PTR [rbp-0x248]
    2869:	mov    rdi,QWORD PTR [rbp-0x250]
    2870:	mov    edx,0x1
    2875:	call   QWORD PTR [r14+0x8]
    2879:	vmovd  eax,xmm0
    287d:	mov    eax,DWORD PTR [rbp-0x200]
    2883:	test   eax,eax
    2885:	jle    2cf8 <main+0x7f8>
    288b:	mov    rsi,QWORD PTR [rbp-0x240]
    2892:	mov    rax,rsi
    2895:	mov    r13,rsi
    2898:	shr    rax,0x3f
    289c:	neg    r13
    289f:	mov    BYTE PTR [rbp-0x1f9],al
    28a5:	test   al,al
    28a7:	cmove  r13,rsi
    28ab:	xor    r15d,r15d
    28ae:	xchg   ax,ax
    28b0:	cmp    BYTE PTR [rbp-0x174],0x0
    28b7:	je     28e7 <main+0x3e7>
    28b9:	mov    edi,DWORD PTR [rbp-0x180]
    28bf:	mov    edx,0x1
    28c4:	mov    esi,0x2403
    28c9:	xor    eax,eax
    28cb:	call   2360 <ioctl@plt>
    28d0:	mov    edi,DWORD PTR [rbp-0x180]
    28d6:	mov    edx,0x1
    28db:	mov    esi,0x2400
    28e0:	xor    eax,eax
    28e2:	call   2360 <ioctl@plt>
    28e7:	mov    rbx,QWORD PTR [rbp-0x268]
    28ee:	mov    edi,0x4
    28f3:	mov    rsi,rbx
    28f6:	call   22a0 <clock_gettime@plt>
    28fb:	vxorpd xmm2,xmm2,xmm2
    28ff:	mov    edx,DWORD PTR [rbp-0x1f8]
    2905:	mov    rsi,QWORD PTR [rbp-0x248]
    290c:	vcvtsi2sd xmm0,xmm2,QWORD PTR [rbp-0x1a0]
    2915:	mov    rdi,QWORD PTR [rbp-0x250]
    291c:	vmovsd xmm1,xmm0,xmm0
    2920:	vcvtsi2sd xmm0,xmm2,QWORD PTR [rbp-0x198]
    2929:	vfmadd132sd xmm1,xmm0,QWORD PTR [rip+0x48ee]        # 7220 <_IO_stdin_used+0x220>
    2932:	vmovsd QWORD PTR [rbp-0x208],xmm1
    293a:	call   QWORD PTR [r14+0x8]
    293e:	mov    rsi,rbx
    2941:	mov    edi,0x4
    2946:	vmovd  r12d,xmm0
    294b:	call   22a0 <clock_gettime@plt>
    2950:	vxorpd xmm2,xmm2,xmm2
    2954:	cmp    BYTE PTR [rbp-0x174],0x0
    295b:	vcvtsi2sd xmm0,xmm2,QWORD PTR [rbp-0x1a0]
    2964:	vmovsd xmm1,xmm0,xmm0
    2968:	vcvtsi2sd xmm0,xmm2,QWORD PTR [rbp-0x198]
    2971:	vfmadd132sd xmm1,xmm0,QWORD PTR [rip+0x48a6]        # 7220 <_IO_stdin_used+0x220>
    297a:	vmovq  rbx,xmm1
    297f:	je     29b9 <main+0x4b9>
    2981:	mov    edi,DWORD PTR [rbp-0x180]
    2987:	mov    edx,0x1
    298c:	mov    esi,0x2401
    2991:	xor    eax,eax
    2993:	call   2360 <ioctl@plt>
    2998:	mov    rsi,QWORD PTR [rbp-0x280]
    299f:	mov    edi,DWORD PTR [rbp-0x180]
    29a5:	mov    edx,0x20
    29aa:	call   2370 <read@plt>
    29af:	cmp    rax,0x20
    29b3:	je     2e00 <main+0x900>
    29b9:	mov    QWORD PTR [rbp-0x218],0x0
    29c4:	mov    QWORD PTR [rbp-0x228],0x0
    29cf:	mov    QWORD PTR [rbp-0x230],0x0
    29da:	vmovq  xmm4,rbx
    29df:	vsubsd xmm3,xmm4,QWORD PTR [rbp-0x208]
    29e7:	vmovsd QWORD PTR [rbp-0x238],xmm3
    29ef:	movsxd rax,DWORD PTR [rbp-0x1f8]
    29f6:	vxorpd xmm6,xmm6,xmm6
    29fa:	vmovsd xmm1,QWORD PTR [rip+0x4826]        # 7228 <_IO_stdin_used+0x228>
    2a02:	vmovsd xmm4,QWORD PTR [rip+0x4806]        # 7210 <_IO_stdin_used+0x210>
    2a0a:	vcvtsi2sd xmm0,xmm6,eax
    2a0e:	mov    QWORD PTR [rbp-0x210],rax
    2a15:	vfmadd132sd xmm1,xmm4,QWORD PTR [rbp-0x260]
    2a1e:	vmulsd xmm0,xmm0,QWORD PTR [rbp-0x258]
    2a26:	vmulsd xmm5,xmm0,xmm1
    2a2a:	vmovsd QWORD PTR [rbp-0x220],xmm5
    2a32:	cmp    r13,0x9
    2a36:	jbe    2e65 <main+0x965>
    2a3c:	cmp    r13,0x63
    2a40:	jbe    2e6f <main+0x96f>
    2a46:	cmp    r13,0x3e7
    2a4d:	jbe    2e79 <main+0x979>
    2a53:	cmp    r13,0x270f
    2a5a:	jbe    2e83 <main+0x983>
    2a60:	mov    rdx,r13
    2a63:	mov    ebx,0x1
    2a68:	movabs rsi,0x346dc5d63886594b
    2a72:	jmp    2a9f <main+0x59f>
    2a74:	nop    DWORD PTR [rax+0x0]
    2a78:	cmp    rcx,0xf423f
    2a7f:	jbe    2d80 <main+0x880>
    2a85:	cmp    rcx,0x98967f
    2a8c:	jbe    2d90 <main+0x890>
    2a92:	cmp    rcx,0x5f5e0ff
    2a99:	jbe    2da0 <main+0x8a0>
    2a9f:	mov    rax,rdx
    2aa2:	mov    rcx,rdx
    2aa5:	mul    rsi
    2aa8:	mov    eax,ebx
    2aaa:	add    ebx,0x4
    2aad:	shr    rdx,0xb
    2ab1:	cmp    rcx,0x1869f
    2ab8:	ja     2a78 <main+0x578>
    2aba:	movzx  eax,BYTE PTR [rbp-0x1f9]
    2ac1:	lea    rdi,[rbp-0x170]
    2ac8:	lea    r12,[rbp-0x160]
    2acf:	mov    edx,0x2d
    2ad4:	mov    QWORD PTR [rbp-0x208],rdi
    2adb:	lea    esi,[rax+rbx*1]
    2ade:	mov    QWORD PTR [rbp-0x170],r12
    2ae5:	call   22e0 <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >::_M_construct(unsigned long, char)@plt>
    2aea:	movzx  edi,BYTE PTR [rbp-0x1f9]
    2af1:	vmovdqa64 zmm6,ZMMWORD PTR [rip+0x4745]        # 7240 <_IO_stdin_used+0x240>
    2afb:	dec    ebx
    2afd:	mov    rcx,r13
    2b00:	vmovdqa64 zmm7,ZMMWORD PTR [rip+0x4776]        # 7280 <_IO_stdin_used+0x280>
    2b0a:	vmovdqa64 zmm3,ZMMWORD PTR [rip+0x47ac]        # 72c0 <_IO_stdin_used+0x2c0>
    2b14:	vmovdqa xmm4,XMMWORD PTR [rip+0x4664]        # 7180 <_IO_stdin_used+0x180>
    2b1c:	add    rdi,QWORD PTR [rbp-0x170]
    2b23:	vmovdqu64 ZMMWORD PTR [rbp-0x110],zmm6
    2b2d:	vmovdqu64 ZMMWORD PTR [rbp-0x90],zmm3
    2b37:	vmovdqu64 ZMMWORD PTR [rbp-0xd0],zmm7
    2b41:	vmovdqu XMMWORD PTR [rbp-0x57],xmm4
    2b46:	cmp    r13,0x63
    2b4a:	jbe    2bad <main+0x6ad>
    2b4c:	movabs rsi,0x28f5c28f5c28f5c3
    2b56:	cs nop WORD PTR [rax+rax*1+0x0]
    2b60:	mov    rdx,rcx
    2b63:	shr    rdx,0x2
    2b67:	mov    rax,rdx
    2b6a:	mul    rsi
    2b6d:	mov    rax,rcx
    2b70:	shr    rdx,0x2
    2b74:	imul   r8,rdx,0x64
    2b78:	sub    rax,r8
    2b7b:	mov    r8,rcx
    2b7e:	mov    rcx,rdx
    2b81:	mov    edx,ebx
    2b83:	add    rax,rax
    2b86:	movzx  r9d,BYTE PTR [rbp+rax*1-0x10f]
    2b8f:	movzx  eax,BYTE PTR [rbp+rax*1-0x110]
    2b97:	mov    BYTE PTR [rdi+rdx*1],r9b
    2b9b:	lea    edx,[rbx-0x1]
    2b9e:	sub    ebx,0x2
    2ba1:	mov    BYTE PTR [rdi+rdx*1],al
    2ba4:	cmp    r8,0x270f
    2bab:	ja     2b60 <main+0x660>
    2bad:	lea    eax,[rcx+0x30]
    2bb0:	cmp    rcx,0x9
    2bb4:	jbe    2bcc <main+0x6cc>
    2bb6:	add    rcx,rcx
    2bb9:	movzx  eax,BYTE PTR [rbp+rcx*1-0x10f]
    2bc1:	mov    BYTE PTR [rdi+0x1],al
    2bc4:	movzx  eax,BYTE PTR [rbp+rcx*1-0x110]
    2bcc:	mov    BYTE PTR [rdi],al
    2bce:	mov    rdi,QWORD PTR [rbp-0x208]
    2bd5:	mov    r8d,0x8
    2bdb:	lea    rcx,[rip+0x456d]        # 714f <_IO_stdin_used+0x14f>
    2be2:	xor    edx,edx
    2be4:	xor    esi,esi
    2be6:	vzeroupper
    2be9:	call   2380 <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >::_M_replace(unsigned long, unsigned long, char const*, unsigned long)@plt>
    2bee:	lea    rbx,[rbp-0x140]
    2bf5:	lea    rcx,[rax+0x10]
    2bf9:	mov    rsi,QWORD PTR [rax+0x8]
    2bfd:	mov    QWORD PTR [rbp-0x150],rbx
    2c04:	mov    rdx,QWORD PTR [rax]
    2c07:	cmp    rdx,rcx
    2c0a:	je     2db0 <main+0x8b0>
    2c10:	mov    QWORD PTR [rbp-0x150],rdx
    2c17:	mov    rdx,QWORD PTR [rax+0x10]
    2c1b:	mov    QWORD PTR [rbp-0x140],rdx
    2c22:	mov    rdx,QWORD PTR [rax+0x8]
    2c26:	vmovsd xmm1,QWORD PTR [rbp-0x220]
    2c2e:	lea    rsi,[rip+0x44ab]        # 70e0 <_IO_stdin_used+0xe0>
    2c35:	mov    edi,0x2
    2c3a:	vmovsd xmm0,QWORD PTR [rbp-0x238]
    2c42:	mov    r9,QWORD PTR [rbp-0x240]
    2c49:	mov    QWORD PTR [rbp-0x148],rdx
    2c50:	mov    r8,QWORD PTR [rbp-0x270]
    2c57:	lea    rdx,[rip+0x44fa]        # 7158 <_IO_stdin_used+0x158>
    2c5e:	mov    QWORD PTR [rax],rcx
    2c61:	mov    BYTE PTR [rax+0x10],0x0
    2c65:	mov    QWORD PTR [rax+0x8],0x0
    2c6d:	lea    rax,[rip+0x44ee]        # 7162 <_IO_stdin_used+0x162>
    2c74:	push   rax
    2c75:	mov    eax,0x2
    2c7a:	push   QWORD PTR [rbp-0x218]
    2c80:	mov    rcx,QWORD PTR [rbp-0x150]
    2c87:	push   QWORD PTR [rbp-0x228]
    2c8d:	push   QWORD PTR [rbp-0x230]
    2c93:	push   QWORD PTR [rbp-0x210]
    2c99:	push   r15
    2c9b:	call   2220 <__printf_chk@plt>
    2ca0:	mov    rdi,QWORD PTR [rip+0x6379]        # 9020 <stdout@GLIBC_2.2.5>
    2ca7:	add    rsp,0x30
    2cab:	call   22f0 <fflush@plt>
    2cb0:	mov    rdi,QWORD PTR [rbp-0x150]
    2cb7:	cmp    rdi,rbx
    2cba:	je     2ccc <main+0x7cc>
    2cbc:	mov    rax,QWORD PTR [rbp-0x140]
    2cc3:	lea    rsi,[rax+0x1]
    2cc7:	call   22c0 <operator delete(void*, unsigned long)@plt>
    2ccc:	mov    rdi,QWORD PTR [rbp-0x170]
    2cd3:	cmp    rdi,r12
    2cd6:	je     2ce8 <main+0x7e8>
    2cd8:	mov    rax,QWORD PTR [rbp-0x160]
    2cdf:	lea    rsi,[rax+0x1]
    2ce3:	call   22c0 <operator delete(void*, unsigned long)@plt>
    2ce8:	inc    r15d
    2ceb:	cmp    DWORD PTR [rbp-0x200],r15d
    2cf2:	jne    28b0 <main+0x3b0>
    2cf8:	add    QWORD PTR [rbp-0x278],0x8
    2d00:	mov    rax,QWORD PTR [rbp-0x278]
    2d07:	cmp    QWORD PTR [rbp-0x288],rax
    2d0e:	jne    27b0 <main+0x2b0>
    2d14:	mov    rdi,QWORD PTR [rbp-0x250]
    2d1b:	call   2300 <free@plt>
    2d20:	add    QWORD PTR [rbp-0x290],0x8
    2d28:	mov    rax,QWORD PTR [rbp-0x290]
    2d2f:	cmp    QWORD PTR [rbp-0x2a0],rax
    2d36:	jne    26b0 <main+0x1b0>
    2d3c:	mov    rdi,QWORD PTR [rbp-0x2b0]
    2d43:	call   5da0 <std::vector<long, std::allocator<long> >::~vector()>
    2d48:	mov    rdi,QWORD PTR [rbp-0x2a8]
    2d4f:	call   5da0 <std::vector<long, std::allocator<long> >::~vector()>
    2d54:	mov    rax,QWORD PTR [rbp-0x38]
    2d58:	sub    rax,QWORD PTR fs:0x28
    2d61:	jne    2ebe <main+0x9be>
    2d67:	lea    rsp,[rbp-0x30]
    2d6b:	xor    eax,eax
    2d6d:	pop    rbx
    2d6e:	pop    r10
    2d70:	pop    r12
    2d72:	pop    r13
    2d74:	pop    r14
    2d76:	pop    r15
    2d78:	pop    rbp
    2d79:	lea    rsp,[r10-0x8]
    2d7d:	ret
    2d7e:	xchg   ax,ax
    2d80:	lea    ebx,[rax+0x5]
    2d83:	jmp    2aba <main+0x5ba>
    2d88:	nop    DWORD PTR [rax+rax*1+0x0]
    2d90:	lea    ebx,[rax+0x6]
    2d93:	jmp    2aba <main+0x5ba>
    2d98:	nop    DWORD PTR [rax+rax*1+0x0]
    2da0:	lea    ebx,[rax+0x7]
    2da3:	jmp    2aba <main+0x5ba>
    2da8:	nop    DWORD PTR [rax+rax*1+0x0]
    2db0:	inc    rsi
    2db3:	mov    r8,rbx
    2db6:	mov    rdx,rcx
    2db9:	cmp    esi,0x8
    2dbc:	jae    2e2f <main+0x92f>
    2dbe:	xor    edi,edi
    2dc0:	test   sil,0x4
    2dc4:	je     2dd0 <main+0x8d0>
    2dc6:	mov    edi,DWORD PTR [rdx]
    2dc8:	mov    DWORD PTR [r8],edi
    2dcb:	mov    edi,0x4
    2dd0:	test   sil,0x2
    2dd4:	je     2de4 <main+0x8e4>
    2dd6:	movzx  r9d,WORD PTR [rdx+rdi*1]
    2ddb:	mov    WORD PTR [r8+rdi*1],r9w
    2de0:	add    rdi,0x2
    2de4:	and    esi,0x1
    2de7:	je     2c22 <main+0x722>
    2ded:	movzx  edx,BYTE PTR [rdx+rdi*1]
    2df1:	mov    BYTE PTR [r8+rdi*1],dl
    2df5:	jmp    2c22 <main+0x722>
    2dfa:	nop    WORD PTR [rax+rax*1+0x0]
    2e00:	mov    rax,QWORD PTR [rbp-0x148]
    2e07:	mov    QWORD PTR [rbp-0x230],rax
    2e0e:	mov    rax,QWORD PTR [rbp-0x140]
    2e15:	mov    QWORD PTR [rbp-0x228],rax
    2e1c:	mov    rax,QWORD PTR [rbp-0x138]
    2e23:	mov    QWORD PTR [rbp-0x218],rax
    2e2a:	jmp    29da <main+0x4da>
    2e2f:	mov    r9d,esi
    2e32:	xor    edx,edx
    2e34:	and    r9d,0xfffffff8
    2e38:	mov    edi,edx
    2e3a:	add    edx,0x8
    2e3d:	mov    r8,QWORD PTR [rcx+rdi*1]
    2e41:	mov    QWORD PTR [rbx+rdi*1],r8
    2e45:	cmp    edx,r9d
    2e48:	jb     2e38 <main+0x938>
    2e4a:	lea    r8,[rbx+rdx*1]
    2e4e:	add    rdx,rcx
    2e51:	jmp    2dbe <main+0x8be>
    2e56:	vcvttsd2si eax,xmm0
    2e5a:	mov    DWORD PTR [rbp-0x1f8],eax
    2e60:	jmp    2862 <main+0x362>
    2e65:	mov    ebx,0x1
    2e6a:	jmp    2aba <main+0x5ba>
    2e6f:	mov    ebx,0x2
    2e74:	jmp    2aba <main+0x5ba>
    2e79:	mov    ebx,0x3
    2e7e:	jmp    2aba <main+0x5ba>
    2e83:	mov    ebx,0x4
    2e88:	jmp    2aba <main+0x5ba>
    2e8d:	add    rax,0xfff
    2e93:	mov    edi,0x1000
    2e98:	and    rax,0xfffffffffffff000
    2e9e:	mov    rsi,rax
    2ea1:	mov    r12,rax
    2ea4:	call   2260 <aligned_alloc@plt>
    2ea9:	mov    QWORD PTR [rbp-0x250],rax
    2eb0:	test   rax,rax
    2eb3:	jne    2728 <main+0x228>
    2eb9:	jmp    2497 <main.cold+0x4a>
    2ebe:	call   22d0 <__stack_chk_fail@plt>
    2ec3:	endbr64
    2ec7:	mov    rbx,rax
    2eca:	jmp    244d <main.cold>
    2ecf:	endbr64
    2ed3:	mov    rbx,rax
    2ed6:	vzeroupper
    2ed9:	jmp    245c <main.cold+0xf>
    2ede:	jmp    2497 <main.cold+0x4a>
    2ee3:	endbr64
    2ee7:	jmp    24b1 <main.cold+0x64>
    2eec:	endbr64
    2ef0:	mov    rbx,rax
    2ef3:	jmp    24be <main.cold+0x71>
    2ef8:	endbr64
    2efc:	mov    rbx,rax
    2eff:	vzeroupper
    2f02:	jmp    2474 <main.cold+0x27>
    2f07:	endbr64
    2f0b:	mov    rbx,rax
    2f0e:	jmp    24cf <main.cold+0x82>
    2f13:	cs nop WORD PTR [rax+rax*1+0x0]
    2f1d:	nop    DWORD PTR [rax]

0000000000002f20 <_start>:
    2f20:	endbr64
    2f24:	xor    ebp,ebp
    2f26:	mov    r9,rdx
    2f29:	pop    rsi
    2f2a:	mov    rdx,rsp
    2f2d:	and    rsp,0xfffffffffffffff0
    2f31:	push   rax
    2f32:	push   rsp
    2f33:	xor    r8d,r8d
    2f36:	xor    ecx,ecx
    2f38:	lea    rdi,[rip+0xfffffffffffff5c1]        # 2500 <main>
    2f3f:	call   QWORD PTR [rip+0x609b]        # 8fe0 <__libc_start_main@GLIBC_2.34>
    2f45:	hlt
    2f46:	cs nop WORD PTR [rax+rax*1+0x0]

0000000000002f50 <deregister_tm_clones>:
    2f50:	lea    rdi,[rip+0x60c1]        # 9018 <__TMC_END__>
    2f57:	lea    rax,[rip+0x60ba]        # 9018 <__TMC_END__>
    2f5e:	cmp    rax,rdi
    2f61:	je     2f78 <deregister_tm_clones+0x28>
    2f63:	mov    rax,QWORD PTR [rip+0x607e]        # 8fe8 <_ITM_deregisterTMCloneTable@Base>
    2f6a:	test   rax,rax
    2f6d:	je     2f78 <deregister_tm_clones+0x28>
    2f6f:	jmp    rax
    2f71:	nop    DWORD PTR [rax+0x0]
    2f78:	ret
    2f79:	nop    DWORD PTR [rax+0x0]

0000000000002f80 <register_tm_clones>:
    2f80:	lea    rdi,[rip+0x6091]        # 9018 <__TMC_END__>
    2f87:	lea    rsi,[rip+0x608a]        # 9018 <__TMC_END__>
    2f8e:	sub    rsi,rdi
    2f91:	mov    rax,rsi
    2f94:	shr    rsi,0x3f
    2f98:	sar    rax,0x3
    2f9c:	add    rsi,rax
    2f9f:	sar    rsi,1
    2fa2:	je     2fb8 <register_tm_clones+0x38>
    2fa4:	mov    rax,QWORD PTR [rip+0x604d]        # 8ff8 <_ITM_registerTMCloneTable@Base>
    2fab:	test   rax,rax
    2fae:	je     2fb8 <register_tm_clones+0x38>
    2fb0:	jmp    rax
    2fb2:	nop    WORD PTR [rax+rax*1+0x0]
    2fb8:	ret
    2fb9:	nop    DWORD PTR [rax+0x0]

0000000000002fc0 <__do_global_dtors_aux>:
    2fc0:	endbr64
    2fc4:	cmp    BYTE PTR [rip+0x607d],0x0        # 9048 <completed.0>
    2fcb:	jne    2ff8 <__do_global_dtors_aux+0x38>
    2fcd:	push   rbp
    2fce:	cmp    QWORD PTR [rip+0x6002],0x0        # 8fd8 <__cxa_finalize@GLIBC_2.2.5>
    2fd6:	mov    rbp,rsp
    2fd9:	je     2fe7 <__do_global_dtors_aux+0x27>
    2fdb:	mov    rdi,QWORD PTR [rip+0x6026]        # 9008 <__dso_handle>
    2fe2:	call   2210 <__cxa_finalize@plt>
    2fe7:	call   2f50 <deregister_tm_clones>
    2fec:	mov    BYTE PTR [rip+0x6055],0x1        # 9048 <completed.0>
    2ff3:	pop    rbp
    2ff4:	ret
    2ff5:	nop    DWORD PTR [rax]
    2ff8:	ret
    2ff9:	nop    DWORD PTR [rax+0x0]

0000000000003000 <frame_dummy>:
    3000:	endbr64
    3004:	jmp    2f80 <register_tm_clones>
    3009:	nop    DWORD PTR [rax+0x0]

0000000000003010 <float kernel<0>(float const*, unsigned long, int)>:
    3010:	endbr64
    3014:	push   rbp
    3015:	vpxor  xmm0,xmm0,xmm0
    3019:	mov    rax,rsi
    301c:	mov    esi,edx
    301e:	mov    rbp,rsp
    3021:	and    rsp,0xffffffffffffffc0
    3025:	sub    rsp,0x240
    302c:	mov    rdx,QWORD PTR fs:0x28
    3035:	mov    QWORD PTR [rsp+0x238],rdx
    303d:	xor    edx,edx
    303f:	vmovdqa64 ZMMWORD PTR [rsp],zmm0
    3046:	vmovdqa64 ZMMWORD PTR [rsp+0x40],zmm0
    304e:	vmovdqa64 ZMMWORD PTR [rsp+0x80],zmm0
    3056:	vmovdqa64 ZMMWORD PTR [rsp+0xc0],zmm0
    305e:	vmovdqa64 ZMMWORD PTR [rsp+0x100],zmm0
    3066:	vmovdqa64 ZMMWORD PTR [rsp+0x140],zmm0
    306e:	vmovdqa64 ZMMWORD PTR [rsp+0x180],zmm0
    3076:	vmovdqa64 ZMMWORD PTR [rsp+0x1c0],zmm0
    307e:	test   esi,esi
    3080:	jle    3183 <float kernel<0>(float const*, unsigned long, int)+0x173>
    3086:	lea    rdx,[rax*4-0x4]
    308e:	xor    ecx,ecx
    3090:	and    rdx,0xfffffffffffffe00
    3097:	lea    rdx,[rdi+rdx*1+0x200]
    309f:	test   rax,rax
    30a2:	je     31fc <float kernel<0>(float const*, unsigned long, int)+0x1ec>
    30a8:	nop    DWORD PTR [rax+rax*1+0x0]
    30b0:	vmovaps zmm7,ZMMWORD PTR [rsp]
    30b7:	vmovaps zmm6,ZMMWORD PTR [rsp+0x40]
    30bf:	mov    rax,rdi
    30c2:	vmovaps zmm5,ZMMWORD PTR [rsp+0x80]
    30ca:	vmovaps zmm4,ZMMWORD PTR [rsp+0xc0]
    30d2:	vmovaps zmm3,ZMMWORD PTR [rsp+0x100]
    30da:	vmovaps zmm2,ZMMWORD PTR [rsp+0x140]
    30e2:	vmovaps zmm1,ZMMWORD PTR [rsp+0x180]
    30ea:	vmovaps zmm0,ZMMWORD PTR [rsp+0x1c0]
    30f2:	nop    WORD PTR [rax+rax*1+0x0]
    30f8:	vaddps zmm7,zmm7,ZMMWORD PTR [rax]
    30fe:	vaddps zmm6,zmm6,ZMMWORD PTR [rax+0x40]
    3105:	add    rax,0x200
    310b:	vaddps zmm5,zmm5,ZMMWORD PTR [rax-0x180]
    3112:	vaddps zmm4,zmm4,ZMMWORD PTR [rax-0x140]
    3119:	vaddps zmm3,zmm3,ZMMWORD PTR [rax-0x100]
    3120:	vaddps zmm2,zmm2,ZMMWORD PTR [rax-0xc0]
    3127:	vaddps zmm1,zmm1,ZMMWORD PTR [rax-0x80]
    312e:	vaddps zmm0,zmm0,ZMMWORD PTR [rax-0x40]
    3135:	cmp    rdx,rax
    3138:	jne    30f8 <float kernel<0>(float const*, unsigned long, int)+0xe8>
    313a:	vmovaps ZMMWORD PTR [rsp],zmm7
    3141:	vmovaps ZMMWORD PTR [rsp+0x40],zmm6
    3149:	vmovaps ZMMWORD PTR [rsp+0x80],zmm5
    3151:	vmovaps ZMMWORD PTR [rsp+0xc0],zmm4
    3159:	vmovaps ZMMWORD PTR [rsp+0x100],zmm3
    3161:	vmovaps ZMMWORD PTR [rsp+0x140],zmm2
    3169:	vmovaps ZMMWORD PTR [rsp+0x180],zmm1
    3171:	vmovaps ZMMWORD PTR [rsp+0x1c0],zmm0
    3179:	inc    ecx
    317b:	cmp    esi,ecx
    317d:	jne    30b0 <float kernel<0>(float const*, unsigned long, int)+0xa0>
    3183:	vmovaps zmm0,ZMMWORD PTR [rsp]
    318a:	lea    rdx,[rsp+0x200]
    3192:	lea    rax,[rsp+0x80]
    319a:	vaddps zmm0,zmm0,ZMMWORD PTR [rsp+0x40]
    31a2:	vaddps zmm0,zmm0,ZMMWORD PTR [rax]
    31a8:	sub    rax,0xffffffffffffff80
    31ac:	vaddps zmm0,zmm0,ZMMWORD PTR [rax-0x40]
    31b3:	cmp    rdx,rax
    31b6:	jne    31a2 <float kernel<0>(float const*, unsigned long, int)+0x192>
    31b8:	vextractf64x4 ymm1,zmm0,0x1
    31bf:	vaddps ymm0,ymm1,ymm0
    31c3:	vextractf128 xmm1,ymm0,0x1
    31c9:	vaddps xmm0,xmm1,xmm0
    31cd:	vpermilps xmm1,xmm0,0x4e
    31d3:	vaddps xmm1,xmm1,xmm0
    31d7:	vmovaps xmm0,xmm1
    31db:	vshufps xmm1,xmm1,xmm1,0x55
    31e0:	vaddss xmm0,xmm0,xmm1
    31e4:	mov    rax,QWORD PTR [rsp+0x238]
    31ec:	sub    rax,QWORD PTR fs:0x28
    31f5:	jne    320d <float kernel<0>(float const*, unsigned long, int)+0x1fd>
    31f7:	vzeroupper
    31fa:	leave
    31fb:	ret
    31fc:	inc    ecx
    31fe:	cmp    esi,ecx
    3200:	je     3183 <float kernel<0>(float const*, unsigned long, int)+0x173>
    3202:	inc    ecx
    3204:	cmp    esi,ecx
    3206:	jne    31fc <float kernel<0>(float const*, unsigned long, int)+0x1ec>
    3208:	jmp    3183 <float kernel<0>(float const*, unsigned long, int)+0x173>
    320d:	vzeroupper
    3210:	call   22d0 <__stack_chk_fail@plt>
    3215:	data16 cs nop WORD PTR [rax+rax*1+0x0]

0000000000003220 <float kernel<1>(float const*, unsigned long, int)>:
    3220:	endbr64
    3224:	push   rbp
    3225:	vpxor  xmm0,xmm0,xmm0
    3229:	mov    rbp,rsp
    322c:	and    rsp,0xffffffffffffffc0
    3230:	sub    rsp,0x240
    3237:	mov    rax,QWORD PTR fs:0x28
    3240:	mov    QWORD PTR [rsp+0x238],rax
    3248:	xor    eax,eax
    324a:	vmovdqa64 ZMMWORD PTR [rsp],zmm0
    3251:	vmovdqa64 ZMMWORD PTR [rsp+0x40],zmm0
    3259:	vmovdqa64 ZMMWORD PTR [rsp+0x80],zmm0
    3261:	vmovdqa64 ZMMWORD PTR [rsp+0xc0],zmm0
    3269:	vmovdqa64 ZMMWORD PTR [rsp+0x100],zmm0
    3271:	vmovdqa64 ZMMWORD PTR [rsp+0x140],zmm0
    3279:	vmovdqa64 ZMMWORD PTR [rsp+0x180],zmm0
    3281:	vmovdqa64 ZMMWORD PTR [rsp+0x1c0],zmm0
    3289:	test   edx,edx
    328b:	jle    33fc <float kernel<1>(float const*, unsigned long, int)+0x1dc>
    3291:	mov    rcx,rsi
    3294:	mov    r8,rdi
    3297:	vbroadcastss zmm1,DWORD PTR [rip+0x3d63]        # 7004 <_IO_stdin_used+0x4>
    32a1:	vbroadcastss zmm0,DWORD PTR [rip+0x3d5d]        # 7008 <_IO_stdin_used+0x8>
    32ab:	mov    edi,edx
    32ad:	xor    esi,esi
    32af:	test   rcx,rcx
    32b2:	je     3475 <float kernel<1>(float const*, unsigned long, int)+0x255>
    32b8:	nop    DWORD PTR [rax+rax*1+0x0]
    32c0:	vmovaps zmm2,ZMMWORD PTR [rsp]
    32c7:	vmovaps zmm3,ZMMWORD PTR [rsp+0x40]
    32cf:	mov    rax,r8
    32d2:	xor    edx,edx
    32d4:	vmovaps zmm4,ZMMWORD PTR [rsp+0x80]
    32dc:	vmovaps zmm5,ZMMWORD PTR [rsp+0xc0]
    32e4:	vmovaps zmm6,ZMMWORD PTR [rsp+0x100]
    32ec:	vmovaps zmm7,ZMMWORD PTR [rsp+0x140]
    32f4:	vmovaps zmm8,ZMMWORD PTR [rsp+0x180]
    32fc:	vmovaps zmm9,ZMMWORD PTR [rsp+0x1c0]
    3304:	nop    DWORD PTR [rax+0x0]
    3308:	vmovaps zmm17,zmm1
    330e:	vmovaps zmm16,zmm1
    3314:	vmovaps zmm15,zmm1
    331a:	sub    rdx,0xffffffffffffff80
    331e:	vmovaps zmm14,zmm1
    3324:	vmovaps zmm13,zmm1
    332a:	vmovaps zmm12,zmm1
    3330:	add    rax,0x200
    3336:	vmovaps zmm11,zmm1
    333c:	vfmadd132ps zmm17,zmm0,ZMMWORD PTR [rax-0x200]
    3343:	vmovaps zmm10,zmm1
    3349:	vfmadd132ps zmm16,zmm0,ZMMWORD PTR [rax-0x1c0]
    3350:	vfmadd132ps zmm15,zmm0,ZMMWORD PTR [rax-0x180]
    3357:	vfmadd132ps zmm14,zmm0,ZMMWORD PTR [rax-0x140]
    335e:	vfmadd132ps zmm13,zmm0,ZMMWORD PTR [rax-0x100]
    3365:	vfmadd132ps zmm12,zmm0,ZMMWORD PTR [rax-0xc0]
    336c:	vfmadd132ps zmm11,zmm0,ZMMWORD PTR [rax-0x80]
    3373:	vfmadd132ps zmm10,zmm0,ZMMWORD PTR [rax-0x40]
    337a:	vaddps zmm2,zmm2,zmm17
    3380:	vaddps zmm3,zmm3,zmm16
    3386:	vaddps zmm4,zmm4,zmm15
    338c:	vaddps zmm5,zmm5,zmm14
    3392:	vaddps zmm6,zmm6,zmm13
    3398:	vaddps zmm7,zmm7,zmm12
    339e:	vaddps zmm8,zmm8,zmm11
    33a4:	vaddps zmm9,zmm9,zmm10
    33aa:	cmp    rdx,rcx
    33ad:	jb     3308 <float kernel<1>(float const*, unsigned long, int)+0xe8>
    33b3:	vmovaps ZMMWORD PTR [rsp+0x1c0],zmm9
    33bb:	vmovaps ZMMWORD PTR [rsp+0x180],zmm8
    33c3:	vmovaps ZMMWORD PTR [rsp+0x140],zmm7
    33cb:	vmovaps ZMMWORD PTR [rsp+0x100],zmm6
    33d3:	vmovaps ZMMWORD PTR [rsp+0xc0],zmm5
    33db:	vmovaps ZMMWORD PTR [rsp+0x80],zmm4
    33e3:	vmovaps ZMMWORD PTR [rsp+0x40],zmm3
    33eb:	vmovaps ZMMWORD PTR [rsp],zmm2
    33f2:	inc    esi
    33f4:	cmp    edi,esi
    33f6:	jne    32c0 <float kernel<1>(float const*, unsigned long, int)+0xa0>
    33fc:	vmovaps zmm0,ZMMWORD PTR [rsp]
    3403:	lea    rdx,[rsp+0x200]
    340b:	lea    rax,[rsp+0x80]
    3413:	vaddps zmm0,zmm0,ZMMWORD PTR [rsp+0x40]
    341b:	vaddps zmm0,zmm0,ZMMWORD PTR [rax]
    3421:	sub    rax,0xffffffffffffff80
    3425:	vaddps zmm0,zmm0,ZMMWORD PTR [rax-0x40]
    342c:	cmp    rdx,rax
    342f:	jne    341b <float kernel<1>(float const*, unsigned long, int)+0x1fb>
    3431:	vextractf64x4 ymm1,zmm0,0x1
    3438:	vaddps ymm0,ymm1,ymm0
    343c:	vextractf128 xmm1,ymm0,0x1
    3442:	vaddps xmm0,xmm1,xmm0
    3446:	vpermilps xmm1,xmm0,0x4e
    344c:	vaddps xmm1,xmm1,xmm0
    3450:	vmovaps xmm0,xmm1
    3454:	vshufps xmm1,xmm1,xmm1,0x55
    3459:	vaddss xmm0,xmm0,xmm1
    345d:	mov    rax,QWORD PTR [rsp+0x238]
    3465:	sub    rax,QWORD PTR fs:0x28
    346e:	jne    3486 <float kernel<1>(float const*, unsigned long, int)+0x266>
    3470:	vzeroupper
    3473:	leave
    3474:	ret
    3475:	inc    esi
    3477:	cmp    edi,esi
    3479:	je     33fc <float kernel<1>(float const*, unsigned long, int)+0x1dc>
    347b:	inc    esi
    347d:	cmp    edi,esi
    347f:	jne    3475 <float kernel<1>(float const*, unsigned long, int)+0x255>
    3481:	jmp    33fc <float kernel<1>(float const*, unsigned long, int)+0x1dc>
    3486:	vzeroupper
    3489:	call   22d0 <__stack_chk_fail@plt>
    348e:	xchg   ax,ax

0000000000003490 <float kernel<2>(float const*, unsigned long, int)>:
    3490:	endbr64
    3494:	push   rbp
    3495:	vpxor  xmm0,xmm0,xmm0
    3499:	mov    rbp,rsp
    349c:	and    rsp,0xffffffffffffffc0
    34a0:	sub    rsp,0x240
    34a7:	mov    rax,QWORD PTR fs:0x28
    34b0:	mov    QWORD PTR [rsp+0x238],rax
    34b8:	xor    eax,eax
    34ba:	vmovdqa64 ZMMWORD PTR [rsp],zmm0
    34c1:	vmovdqa64 ZMMWORD PTR [rsp+0x40],zmm0
    34c9:	vmovdqa64 ZMMWORD PTR [rsp+0x80],zmm0
    34d1:	vmovdqa64 ZMMWORD PTR [rsp+0xc0],zmm0
    34d9:	vmovdqa64 ZMMWORD PTR [rsp+0x100],zmm0
    34e1:	vmovdqa64 ZMMWORD PTR [rsp+0x140],zmm0
    34e9:	vmovdqa64 ZMMWORD PTR [rsp+0x180],zmm0
    34f1:	vmovdqa64 ZMMWORD PTR [rsp+0x1c0],zmm0
    34f9:	test   edx,edx
    34fb:	jle    3694 <float kernel<2>(float const*, unsigned long, int)+0x204>
    3501:	mov    rcx,rsi
    3504:	mov    r8,rdi
    3507:	vbroadcastss zmm1,DWORD PTR [rip+0x3af3]        # 7004 <_IO_stdin_used+0x4>
    3511:	vbroadcastss zmm0,DWORD PTR [rip+0x3aed]        # 7008 <_IO_stdin_used+0x8>
    351b:	mov    edi,edx
    351d:	xor    esi,esi
    351f:	test   rcx,rcx
    3522:	je     370d <float kernel<2>(float const*, unsigned long, int)+0x27d>
    3528:	vmovaps zmm17,ZMMWORD PTR [rsp]
    352f:	vmovaps zmm16,ZMMWORD PTR [rsp+0x40]
    3537:	mov    rax,r8
    353a:	xor    edx,edx
    353c:	vmovaps zmm15,ZMMWORD PTR [rsp+0x80]
    3544:	vmovaps zmm14,ZMMWORD PTR [rsp+0xc0]
    354c:	vmovaps zmm13,ZMMWORD PTR [rsp+0x100]
    3554:	vmovaps zmm12,ZMMWORD PTR [rsp+0x140]
    355c:	vmovaps zmm11,ZMMWORD PTR [rsp+0x180]
    3564:	vmovaps zmm10,ZMMWORD PTR [rsp+0x1c0]
    356c:	nop    DWORD PTR [rax+0x0]
    3570:	vmovaps zmm9,zmm1
    3576:	vmovaps zmm8,zmm1
    357c:	vmovaps zmm7,zmm1
    3582:	sub    rdx,0xffffffffffffff80
    3586:	vmovaps zmm6,zmm1
    358c:	vmovaps zmm5,zmm1
    3592:	vmovaps zmm4,zmm1
    3598:	add    rax,0x200
    359e:	vmovaps zmm3,zmm1
    35a4:	vfmadd132ps zmm9,zmm0,ZMMWORD PTR [rax-0x200]
    35ab:	vmovaps zmm2,zmm1
    35b1:	vfmadd132ps zmm8,zmm0,ZMMWORD PTR [rax-0x1c0]
    35b8:	vfmadd132ps zmm7,zmm0,ZMMWORD PTR [rax-0x180]
    35bf:	vfmadd132ps zmm6,zmm0,ZMMWORD PTR [rax-0x140]
    35c6:	vfmadd132ps zmm5,zmm0,ZMMWORD PTR [rax-0x100]
    35cd:	vfmadd132ps zmm4,zmm0,ZMMWORD PTR [rax-0xc0]
    35d4:	vfmadd132ps zmm3,zmm0,ZMMWORD PTR [rax-0x80]
    35db:	vfmadd132ps zmm2,zmm0,ZMMWORD PTR [rax-0x40]
    35e2:	vfmadd132ps zmm9,zmm0,zmm1
    35e8:	vfmadd132ps zmm8,zmm0,zmm1
    35ee:	vfmadd132ps zmm7,zmm0,zmm1
    35f4:	vfmadd132ps zmm6,zmm0,zmm1
    35fa:	vfmadd132ps zmm5,zmm0,zmm1
    3600:	vfmadd132ps zmm4,zmm0,zmm1
    3606:	vfmadd132ps zmm3,zmm0,zmm1
    360c:	vfmadd132ps zmm2,zmm0,zmm1
    3612:	vaddps zmm17,zmm17,zmm9
    3618:	vaddps zmm16,zmm16,zmm8
    361e:	vaddps zmm15,zmm15,zmm7
    3624:	vaddps zmm14,zmm14,zmm6
    362a:	vaddps zmm13,zmm13,zmm5
    3630:	vaddps zmm12,zmm12,zmm4
    3636:	vaddps zmm11,zmm11,zmm3
    363c:	vaddps zmm10,zmm10,zmm2
    3642:	cmp    rdx,rcx
    3645:	jb     3570 <float kernel<2>(float const*, unsigned long, int)+0xe0>
    364b:	vmovaps ZMMWORD PTR [rsp],zmm17
    3652:	vmovaps ZMMWORD PTR [rsp+0x40],zmm16
    365a:	vmovaps ZMMWORD PTR [rsp+0x80],zmm15
    3662:	vmovaps ZMMWORD PTR [rsp+0xc0],zmm14
    366a:	vmovaps ZMMWORD PTR [rsp+0x100],zmm13
    3672:	vmovaps ZMMWORD PTR [rsp+0x140],zmm12
    367a:	vmovaps ZMMWORD PTR [rsp+0x180],zmm11
    3682:	vmovaps ZMMWORD PTR [rsp+0x1c0],zmm10
    368a:	inc    esi
    368c:	cmp    edi,esi
    368e:	jne    3528 <float kernel<2>(float const*, unsigned long, int)+0x98>
    3694:	vmovaps zmm0,ZMMWORD PTR [rsp]
    369b:	lea    rdx,[rsp+0x200]
    36a3:	lea    rax,[rsp+0x80]
    36ab:	vaddps zmm0,zmm0,ZMMWORD PTR [rsp+0x40]
    36b3:	vaddps zmm0,zmm0,ZMMWORD PTR [rax]
    36b9:	sub    rax,0xffffffffffffff80
    36bd:	vaddps zmm0,zmm0,ZMMWORD PTR [rax-0x40]
    36c4:	cmp    rdx,rax
    36c7:	jne    36b3 <float kernel<2>(float const*, unsigned long, int)+0x223>
    36c9:	vextractf64x4 ymm1,zmm0,0x1
    36d0:	vaddps ymm0,ymm1,ymm0
    36d4:	vextractf128 xmm1,ymm0,0x1
    36da:	vaddps xmm0,xmm1,xmm0
    36de:	vpermilps xmm1,xmm0,0x4e
    36e4:	vaddps xmm1,xmm1,xmm0
    36e8:	vmovaps xmm0,xmm1
    36ec:	vshufps xmm1,xmm1,xmm1,0x55
    36f1:	vaddss xmm0,xmm0,xmm1
    36f5:	mov    rax,QWORD PTR [rsp+0x238]
    36fd:	sub    rax,QWORD PTR fs:0x28
    3706:	jne    371e <float kernel<2>(float const*, unsigned long, int)+0x28e>
    3708:	vzeroupper
    370b:	leave
    370c:	ret
    370d:	inc    esi
    370f:	cmp    edi,esi
    3711:	je     3694 <float kernel<2>(float const*, unsigned long, int)+0x204>
    3713:	inc    esi
    3715:	cmp    edi,esi
    3717:	jne    370d <float kernel<2>(float const*, unsigned long, int)+0x27d>
    3719:	jmp    3694 <float kernel<2>(float const*, unsigned long, int)+0x204>
    371e:	vzeroupper
    3721:	call   22d0 <__stack_chk_fail@plt>
    3726:	cs nop WORD PTR [rax+rax*1+0x0]

0000000000003730 <float kernel<4>(float const*, unsigned long, int)>:
    3730:	endbr64
    3734:	push   rbp
    3735:	vpxor  xmm0,xmm0,xmm0
    3739:	mov    rbp,rsp
    373c:	and    rsp,0xffffffffffffffc0
    3740:	sub    rsp,0x240
    3747:	mov    rax,QWORD PTR fs:0x28
    3750:	mov    QWORD PTR [rsp+0x238],rax
    3758:	xor    eax,eax
    375a:	vmovdqa64 ZMMWORD PTR [rsp],zmm0
    3761:	vmovdqa64 ZMMWORD PTR [rsp+0x40],zmm0
    3769:	vmovdqa64 ZMMWORD PTR [rsp+0x80],zmm0
    3771:	vmovdqa64 ZMMWORD PTR [rsp+0xc0],zmm0
    3779:	vmovdqa64 ZMMWORD PTR [rsp+0x100],zmm0
    3781:	vmovdqa64 ZMMWORD PTR [rsp+0x140],zmm0
    3789:	vmovdqa64 ZMMWORD PTR [rsp+0x180],zmm0
    3791:	vmovdqa64 ZMMWORD PTR [rsp+0x1c0],zmm0
    3799:	test   edx,edx
    379b:	jle    3994 <float kernel<4>(float const*, unsigned long, int)+0x264>
    37a1:	mov    rcx,rsi
    37a4:	mov    r8,rdi
    37a7:	vbroadcastss zmm1,DWORD PTR [rip+0x3853]        # 7004 <_IO_stdin_used+0x4>
    37b1:	vbroadcastss zmm0,DWORD PTR [rip+0x384d]        # 7008 <_IO_stdin_used+0x8>
    37bb:	mov    edi,edx
    37bd:	xor    esi,esi
    37bf:	test   rcx,rcx
    37c2:	je     3a0d <float kernel<4>(float const*, unsigned long, int)+0x2dd>
    37c8:	vmovaps zmm15,ZMMWORD PTR [rsp]
    37cf:	vmovaps zmm14,ZMMWORD PTR [rsp+0x40]
    37d7:	mov    rax,r8
    37da:	xor    edx,edx
    37dc:	vmovaps zmm13,ZMMWORD PTR [rsp+0x80]
    37e4:	vmovaps zmm12,ZMMWORD PTR [rsp+0xc0]
    37ec:	vmovaps zmm11,ZMMWORD PTR [rsp+0x100]
    37f4:	vmovaps zmm10,ZMMWORD PTR [rsp+0x140]
    37fc:	vmovaps zmm9,ZMMWORD PTR [rsp+0x180]
    3804:	vmovaps zmm8,ZMMWORD PTR [rsp+0x1c0]
    380c:	nop    DWORD PTR [rax+0x0]
    3810:	vmovaps zmm17,zmm1
    3816:	vmovaps zmm16,zmm1
    381c:	vmovaps zmm7,zmm1
    3822:	sub    rdx,0xffffffffffffff80
    3826:	vmovaps zmm6,zmm1
    382c:	vmovaps zmm5,zmm1
    3832:	vmovaps zmm4,zmm1
    3838:	add    rax,0x200
    383e:	vmovaps zmm3,zmm1
    3844:	vfmadd132ps zmm17,zmm0,ZMMWORD PTR [rax-0x200]
    384b:	vmovaps zmm2,zmm1
    3851:	vfmadd132ps zmm16,zmm0,ZMMWORD PTR [rax-0x1c0]
    3858:	vfmadd132ps zmm7,zmm0,ZMMWORD PTR [rax-0x180]
    385f:	vfmadd132ps zmm6,zmm0,ZMMWORD PTR [rax-0x140]
    3866:	vfmadd132ps zmm5,zmm0,ZMMWORD PTR [rax-0x100]
    386d:	vfmadd132ps zmm4,zmm0,ZMMWORD PTR [rax-0xc0]
    3874:	vfmadd132ps zmm3,zmm0,ZMMWORD PTR [rax-0x80]
    387b:	vfmadd132ps zmm2,zmm0,ZMMWORD PTR [rax-0x40]
    3882:	vfmadd132ps zmm17,zmm0,zmm1
    3888:	vfmadd132ps zmm16,zmm0,zmm1
    388e:	vfmadd132ps zmm7,zmm0,zmm1
    3894:	vfmadd132ps zmm6,zmm0,zmm1
    389a:	vfmadd132ps zmm5,zmm0,zmm1
    38a0:	vfmadd132ps zmm4,zmm0,zmm1
    38a6:	vfmadd132ps zmm3,zmm0,zmm1
    38ac:	vfmadd132ps zmm2,zmm0,zmm1
    38b2:	vfmadd132ps zmm17,zmm0,zmm1
    38b8:	vfmadd132ps zmm16,zmm0,zmm1
    38be:	vfmadd132ps zmm7,zmm0,zmm1
    38c4:	vfmadd132ps zmm6,zmm0,zmm1
    38ca:	vfmadd132ps zmm5,zmm0,zmm1
    38d0:	vfmadd132ps zmm4,zmm0,zmm1
    38d6:	vfmadd132ps zmm3,zmm0,zmm1
    38dc:	vfmadd132ps zmm2,zmm0,zmm1
    38e2:	vfmadd132ps zmm17,zmm0,zmm1
    38e8:	vfmadd132ps zmm16,zmm0,zmm1
    38ee:	vfmadd132ps zmm7,zmm0,zmm1
    38f4:	vfmadd132ps zmm6,zmm0,zmm1
    38fa:	vfmadd132ps zmm5,zmm0,zmm1
    3900:	vfmadd132ps zmm4,zmm0,zmm1
    3906:	vfmadd132ps zmm3,zmm0,zmm1
    390c:	vfmadd132ps zmm2,zmm0,zmm1
    3912:	vaddps zmm15,zmm15,zmm17
    3918:	vaddps zmm14,zmm14,zmm16
    391e:	vaddps zmm13,zmm13,zmm7
    3924:	vaddps zmm12,zmm12,zmm6
    392a:	vaddps zmm11,zmm11,zmm5
    3930:	vaddps zmm10,zmm10,zmm4
    3936:	vaddps zmm9,zmm9,zmm3
    393c:	vaddps zmm8,zmm8,zmm2
    3942:	cmp    rdx,rcx
    3945:	jb     3810 <float kernel<4>(float const*, unsigned long, int)+0xe0>
    394b:	vmovaps ZMMWORD PTR [rsp],zmm15
    3952:	vmovaps ZMMWORD PTR [rsp+0x40],zmm14
    395a:	vmovaps ZMMWORD PTR [rsp+0x80],zmm13
    3962:	vmovaps ZMMWORD PTR [rsp+0xc0],zmm12
    396a:	vmovaps ZMMWORD PTR [rsp+0x100],zmm11
    3972:	vmovaps ZMMWORD PTR [rsp+0x140],zmm10
    397a:	vmovaps ZMMWORD PTR [rsp+0x180],zmm9
    3982:	vmovaps ZMMWORD PTR [rsp+0x1c0],zmm8
    398a:	inc    esi
    398c:	cmp    edi,esi
    398e:	jne    37c8 <float kernel<4>(float const*, unsigned long, int)+0x98>
    3994:	vmovaps zmm0,ZMMWORD PTR [rsp]
    399b:	lea    rdx,[rsp+0x200]
    39a3:	lea    rax,[rsp+0x80]
    39ab:	vaddps zmm0,zmm0,ZMMWORD PTR [rsp+0x40]
    39b3:	vaddps zmm0,zmm0,ZMMWORD PTR [rax]
    39b9:	sub    rax,0xffffffffffffff80
    39bd:	vaddps zmm0,zmm0,ZMMWORD PTR [rax-0x40]
    39c4:	cmp    rdx,rax
    39c7:	jne    39b3 <float kernel<4>(float const*, unsigned long, int)+0x283>
    39c9:	vextractf64x4 ymm1,zmm0,0x1
    39d0:	vaddps ymm0,ymm1,ymm0
    39d4:	vextractf128 xmm1,ymm0,0x1
    39da:	vaddps xmm0,xmm1,xmm0
    39de:	vpermilps xmm1,xmm0,0x4e
    39e4:	vaddps xmm1,xmm1,xmm0
    39e8:	vmovaps xmm0,xmm1
    39ec:	vshufps xmm1,xmm1,xmm1,0x55
    39f1:	vaddss xmm0,xmm0,xmm1
    39f5:	mov    rax,QWORD PTR [rsp+0x238]
    39fd:	sub    rax,QWORD PTR fs:0x28
    3a06:	jne    3a1e <float kernel<4>(float const*, unsigned long, int)+0x2ee>
    3a08:	vzeroupper
    3a0b:	leave
    3a0c:	ret
    3a0d:	inc    esi
    3a0f:	cmp    edi,esi
    3a11:	je     3994 <float kernel<4>(float const*, unsigned long, int)+0x264>
    3a13:	inc    esi
    3a15:	cmp    edi,esi
    3a17:	jne    3a0d <float kernel<4>(float const*, unsigned long, int)+0x2dd>
    3a19:	jmp    3994 <float kernel<4>(float const*, unsigned long, int)+0x264>
    3a1e:	vzeroupper
    3a21:	call   22d0 <__stack_chk_fail@plt>
    3a26:	cs nop WORD PTR [rax+rax*1+0x0]

0000000000003a30 <float kernel<8>(float const*, unsigned long, int)>:
    3a30:	endbr64
    3a34:	push   rbp
    3a35:	vpxor  xmm0,xmm0,xmm0
    3a39:	mov    rbp,rsp
    3a3c:	and    rsp,0xffffffffffffffc0
    3a40:	sub    rsp,0x240
    3a47:	mov    rax,QWORD PTR fs:0x28
    3a50:	mov    QWORD PTR [rsp+0x238],rax
    3a58:	xor    eax,eax
    3a5a:	vmovdqa64 ZMMWORD PTR [rsp],zmm0
    3a61:	vmovdqa64 ZMMWORD PTR [rsp+0x40],zmm0
    3a69:	vmovdqa64 ZMMWORD PTR [rsp+0x80],zmm0
    3a71:	vmovdqa64 ZMMWORD PTR [rsp+0xc0],zmm0
    3a79:	vmovdqa64 ZMMWORD PTR [rsp+0x100],zmm0
    3a81:	vmovdqa64 ZMMWORD PTR [rsp+0x140],zmm0
    3a89:	vmovdqa64 ZMMWORD PTR [rsp+0x180],zmm0
    3a91:	vmovdqa64 ZMMWORD PTR [rsp+0x1c0],zmm0
    3a99:	test   edx,edx
    3a9b:	jle    3d54 <float kernel<8>(float const*, unsigned long, int)+0x324>
    3aa1:	mov    rcx,rsi
    3aa4:	mov    r8,rdi
    3aa7:	vbroadcastss zmm1,DWORD PTR [rip+0x3553]        # 7004 <_IO_stdin_used+0x4>
    3ab1:	vbroadcastss zmm0,DWORD PTR [rip+0x354d]        # 7008 <_IO_stdin_used+0x8>
    3abb:	mov    edi,edx
    3abd:	xor    esi,esi
    3abf:	test   rcx,rcx
    3ac2:	je     3dcd <float kernel<8>(float const*, unsigned long, int)+0x39d>
    3ac8:	vmovaps zmm12,ZMMWORD PTR [rsp]
    3acf:	vmovaps zmm11,ZMMWORD PTR [rsp+0x40]
    3ad7:	mov    rax,r8
    3ada:	xor    edx,edx
    3adc:	vmovaps zmm10,ZMMWORD PTR [rsp+0x80]
    3ae4:	vmovaps zmm9,ZMMWORD PTR [rsp+0xc0]
    3aec:	vmovaps zmm8,ZMMWORD PTR [rsp+0x100]
    3af4:	vmovaps zmm7,ZMMWORD PTR [rsp+0x140]
    3afc:	vmovaps zmm6,ZMMWORD PTR [rsp+0x180]
    3b04:	vmovaps zmm5,ZMMWORD PTR [rsp+0x1c0]
    3b0c:	nop    DWORD PTR [rax+0x0]
    3b10:	vmovaps zmm17,zmm1
    3b16:	vmovaps zmm16,zmm1
    3b1c:	vmovaps zmm15,zmm1
    3b22:	sub    rdx,0xffffffffffffff80
    3b26:	vmovaps zmm14,zmm1
    3b2c:	vmovaps zmm13,zmm1
    3b32:	vmovaps zmm4,zmm1
    3b38:	add    rax,0x200
    3b3e:	vmovaps zmm3,zmm1
    3b44:	vfmadd132ps zmm17,zmm0,ZMMWORD PTR [rax-0x200]
    3b4b:	vmovaps zmm2,zmm1
    3b51:	vfmadd132ps zmm16,zmm0,ZMMWORD PTR [rax-0x1c0]
    3b58:	vfmadd132ps zmm15,zmm0,ZMMWORD PTR [rax-0x180]
    3b5f:	vfmadd132ps zmm14,zmm0,ZMMWORD PTR [rax-0x140]
    3b66:	vfmadd132ps zmm13,zmm0,ZMMWORD PTR [rax-0x100]
    3b6d:	vfmadd132ps zmm4,zmm0,ZMMWORD PTR [rax-0xc0]
    3b74:	vfmadd132ps zmm3,zmm0,ZMMWORD PTR [rax-0x80]
    3b7b:	vfmadd132ps zmm2,zmm0,ZMMWORD PTR [rax-0x40]
    3b82:	vfmadd132ps zmm17,zmm0,zmm1
    3b88:	vfmadd132ps zmm16,zmm0,zmm1
    3b8e:	vfmadd132ps zmm15,zmm0,zmm1
    3b94:	vfmadd132ps zmm14,zmm0,zmm1
    3b9a:	vfmadd132ps zmm13,zmm0,zmm1
    3ba0:	vfmadd132ps zmm4,zmm0,zmm1
    3ba6:	vfmadd132ps zmm3,zmm0,zmm1
    3bac:	vfmadd132ps zmm2,zmm0,zmm1
    3bb2:	vfmadd132ps zmm17,zmm0,zmm1
    3bb8:	vfmadd132ps zmm16,zmm0,zmm1
    3bbe:	vfmadd132ps zmm15,zmm0,zmm1
    3bc4:	vfmadd132ps zmm14,zmm0,zmm1
    3bca:	vfmadd132ps zmm13,zmm0,zmm1
    3bd0:	vfmadd132ps zmm4,zmm0,zmm1
    3bd6:	vfmadd132ps zmm3,zmm0,zmm1
    3bdc:	vfmadd132ps zmm2,zmm0,zmm1
    3be2:	vfmadd132ps zmm17,zmm0,zmm1
    3be8:	vfmadd132ps zmm16,zmm0,zmm1
    3bee:	vfmadd132ps zmm15,zmm0,zmm1
    3bf4:	vfmadd132ps zmm14,zmm0,zmm1
    3bfa:	vfmadd132ps zmm13,zmm0,zmm1
    3c00:	vfmadd132ps zmm4,zmm0,zmm1
    3c06:	vfmadd132ps zmm3,zmm0,zmm1
    3c0c:	vfmadd132ps zmm2,zmm0,zmm1
    3c12:	vfmadd132ps zmm17,zmm0,zmm1
    3c18:	vfmadd132ps zmm16,zmm0,zmm1
    3c1e:	vfmadd132ps zmm15,zmm0,zmm1
    3c24:	vfmadd132ps zmm14,zmm0,zmm1
    3c2a:	vfmadd132ps zmm13,zmm0,zmm1
    3c30:	vfmadd132ps zmm4,zmm0,zmm1
    3c36:	vfmadd132ps zmm3,zmm0,zmm1
    3c3c:	vfmadd132ps zmm2,zmm0,zmm1
    3c42:	vfmadd132ps zmm17,zmm0,zmm1
    3c48:	vfmadd132ps zmm16,zmm0,zmm1
    3c4e:	vfmadd132ps zmm15,zmm0,zmm1
    3c54:	vfmadd132ps zmm14,zmm0,zmm1
    3c5a:	vfmadd132ps zmm13,zmm0,zmm1
    3c60:	vfmadd132ps zmm4,zmm0,zmm1
    3c66:	vfmadd132ps zmm3,zmm0,zmm1
    3c6c:	vfmadd132ps zmm2,zmm0,zmm1
    3c72:	vfmadd132ps zmm17,zmm0,zmm1
    3c78:	vfmadd132ps zmm16,zmm0,zmm1
    3c7e:	vfmadd132ps zmm15,zmm0,zmm1
    3c84:	vfmadd132ps zmm14,zmm0,zmm1
    3c8a:	vfmadd132ps zmm13,zmm0,zmm1
    3c90:	vfmadd132ps zmm4,zmm0,zmm1
    3c96:	vfmadd132ps zmm3,zmm0,zmm1
    3c9c:	vfmadd132ps zmm2,zmm0,zmm1
    3ca2:	vfmadd132ps zmm17,zmm0,zmm1
    3ca8:	vfmadd132ps zmm16,zmm0,zmm1
    3cae:	vfmadd132ps zmm15,zmm0,zmm1
    3cb4:	vfmadd132ps zmm14,zmm0,zmm1
    3cba:	vfmadd132ps zmm13,zmm0,zmm1
    3cc0:	vfmadd132ps zmm4,zmm0,zmm1
    3cc6:	vfmadd132ps zmm3,zmm0,zmm1
    3ccc:	vfmadd132ps zmm2,zmm0,zmm1
    3cd2:	vaddps zmm12,zmm12,zmm17
    3cd8:	vaddps zmm11,zmm11,zmm16
    3cde:	vaddps zmm10,zmm10,zmm15
    3ce4:	vaddps zmm9,zmm9,zmm14
    3cea:	vaddps zmm8,zmm8,zmm13
    3cf0:	vaddps zmm7,zmm7,zmm4
    3cf6:	vaddps zmm6,zmm6,zmm3
    3cfc:	vaddps zmm5,zmm5,zmm2
    3d02:	cmp    rdx,rcx
    3d05:	jb     3b10 <float kernel<8>(float const*, unsigned long, int)+0xe0>
    3d0b:	vmovaps ZMMWORD PTR [rsp],zmm12
    3d12:	vmovaps ZMMWORD PTR [rsp+0x40],zmm11
    3d1a:	vmovaps ZMMWORD PTR [rsp+0x80],zmm10
    3d22:	vmovaps ZMMWORD PTR [rsp+0xc0],zmm9
    3d2a:	vmovaps ZMMWORD PTR [rsp+0x100],zmm8
    3d32:	vmovaps ZMMWORD PTR [rsp+0x140],zmm7
    3d3a:	vmovaps ZMMWORD PTR [rsp+0x180],zmm6
    3d42:	vmovaps ZMMWORD PTR [rsp+0x1c0],zmm5
    3d4a:	inc    esi
    3d4c:	cmp    edi,esi
    3d4e:	jne    3ac8 <float kernel<8>(float const*, unsigned long, int)+0x98>
    3d54:	vmovaps zmm0,ZMMWORD PTR [rsp]
    3d5b:	lea    rdx,[rsp+0x200]
    3d63:	lea    rax,[rsp+0x80]
    3d6b:	vaddps zmm0,zmm0,ZMMWORD PTR [rsp+0x40]
    3d73:	vaddps zmm0,zmm0,ZMMWORD PTR [rax]
    3d79:	sub    rax,0xffffffffffffff80
    3d7d:	vaddps zmm0,zmm0,ZMMWORD PTR [rax-0x40]
    3d84:	cmp    rdx,rax
    3d87:	jne    3d73 <float kernel<8>(float const*, unsigned long, int)+0x343>
    3d89:	vextractf64x4 ymm1,zmm0,0x1
    3d90:	vaddps ymm0,ymm1,ymm0
    3d94:	vextractf128 xmm1,ymm0,0x1
    3d9a:	vaddps xmm0,xmm1,xmm0
    3d9e:	vpermilps xmm1,xmm0,0x4e
    3da4:	vaddps xmm1,xmm1,xmm0
    3da8:	vmovaps xmm0,xmm1
    3dac:	vshufps xmm1,xmm1,xmm1,0x55
    3db1:	vaddss xmm0,xmm0,xmm1
    3db5:	mov    rax,QWORD PTR [rsp+0x238]
    3dbd:	sub    rax,QWORD PTR fs:0x28
    3dc6:	jne    3dde <float kernel<8>(float const*, unsigned long, int)+0x3ae>
    3dc8:	vzeroupper
    3dcb:	leave
    3dcc:	ret
    3dcd:	inc    esi
    3dcf:	cmp    edi,esi
    3dd1:	je     3d54 <float kernel<8>(float const*, unsigned long, int)+0x324>
    3dd3:	inc    esi
    3dd5:	cmp    edi,esi
    3dd7:	jne    3dcd <float kernel<8>(float const*, unsigned long, int)+0x39d>
    3dd9:	jmp    3d54 <float kernel<8>(float const*, unsigned long, int)+0x324>
    3dde:	vzeroupper
    3de1:	call   22d0 <__stack_chk_fail@plt>
    3de6:	cs nop WORD PTR [rax+rax*1+0x0]

0000000000003df0 <float kernel<16>(float const*, unsigned long, int)>:
    3df0:	endbr64
    3df4:	push   rbp
    3df5:	vpxor  xmm0,xmm0,xmm0
    3df9:	mov    rbp,rsp
    3dfc:	and    rsp,0xffffffffffffffc0
    3e00:	sub    rsp,0x240
    3e07:	mov    rax,QWORD PTR fs:0x28
    3e10:	mov    QWORD PTR [rsp+0x238],rax
    3e18:	xor    eax,eax
    3e1a:	vmovdqa64 ZMMWORD PTR [rsp],zmm0
    3e21:	vmovdqa64 ZMMWORD PTR [rsp+0x40],zmm0
    3e29:	vmovdqa64 ZMMWORD PTR [rsp+0x80],zmm0
    3e31:	vmovdqa64 ZMMWORD PTR [rsp+0xc0],zmm0
    3e39:	vmovdqa64 ZMMWORD PTR [rsp+0x100],zmm0
    3e41:	vmovdqa64 ZMMWORD PTR [rsp+0x140],zmm0
    3e49:	vmovdqa64 ZMMWORD PTR [rsp+0x180],zmm0
    3e51:	vmovdqa64 ZMMWORD PTR [rsp+0x1c0],zmm0
    3e59:	test   edx,edx
    3e5b:	jle    42a8 <float kernel<16>(float const*, unsigned long, int)+0x4b8>
    3e61:	mov    rcx,rsi
    3e64:	mov    r8,rdi
    3e67:	xor    esi,esi
    3e69:	mov    edi,edx
    3e6b:	test   rcx,rcx
    3e6e:	je     4321 <float kernel<16>(float const*, unsigned long, int)+0x531>
    3e74:	vbroadcastss zmm1,DWORD PTR [rip+0x3186]        # 7004 <_IO_stdin_used+0x4>
    3e7e:	vbroadcastss zmm0,DWORD PTR [rip+0x3180]        # 7008 <_IO_stdin_used+0x8>
    3e88:	vmovaps zmm5,zmm1
    3e8e:	vmovaps zmm4,zmm0
    3e94:	vmovaps zmm13,ZMMWORD PTR [rsp]
    3e9b:	vmovaps zmm12,ZMMWORD PTR [rsp+0x40]
    3ea3:	mov    rax,r8
    3ea6:	xor    edx,edx
    3ea8:	vmovaps zmm11,ZMMWORD PTR [rsp+0x80]
    3eb0:	vmovaps zmm10,ZMMWORD PTR [rsp+0xc0]
    3eb8:	vmovaps zmm9,ZMMWORD PTR [rsp+0x100]
    3ec0:	vmovaps zmm8,ZMMWORD PTR [rsp+0x140]
    3ec8:	vmovaps zmm7,ZMMWORD PTR [rsp+0x180]
    3ed0:	vmovaps zmm6,ZMMWORD PTR [rsp+0x1c0]
    3ed8:	vmovaps zmm19,zmm1
    3ede:	vmovaps zmm18,zmm1
    3ee4:	vmovaps zmm17,zmm1
    3eea:	sub    rdx,0xffffffffffffff80
    3eee:	vmovaps zmm16,zmm1
    3ef4:	vmovaps zmm15,zmm1
    3efa:	vmovaps zmm14,zmm1
    3f00:	add    rax,0x200
    3f06:	vmovaps zmm3,zmm1
    3f0c:	vfmadd132ps zmm19,zmm0,ZMMWORD PTR [rax-0x200]
    3f13:	vmovaps zmm2,zmm1
    3f19:	vfmadd132ps zmm18,zmm0,ZMMWORD PTR [rax-0x1c0]
    3f20:	vfmadd132ps zmm17,zmm0,ZMMWORD PTR [rax-0x180]
    3f27:	vfmadd132ps zmm16,zmm0,ZMMWORD PTR [rax-0x140]
    3f2e:	vfmadd132ps zmm15,zmm0,ZMMWORD PTR [rax-0x100]
    3f35:	vfmadd132ps zmm14,zmm0,ZMMWORD PTR [rax-0xc0]
    3f3c:	vfmadd132ps zmm3,zmm0,ZMMWORD PTR [rax-0x80]
    3f43:	vfmadd132ps zmm2,zmm0,ZMMWORD PTR [rax-0x40]
    3f4a:	vfmadd132ps zmm19,zmm0,zmm1
    3f50:	vfmadd132ps zmm18,zmm0,zmm1
    3f56:	vfmadd132ps zmm17,zmm0,zmm1
    3f5c:	vfmadd132ps zmm16,zmm0,zmm1
    3f62:	vfmadd132ps zmm15,zmm0,zmm1
    3f68:	vfmadd132ps zmm14,zmm0,zmm1
    3f6e:	vfmadd132ps zmm3,zmm0,zmm1
    3f74:	vfmadd132ps zmm2,zmm0,zmm1
    3f7a:	vfmadd132ps zmm19,zmm0,zmm1
    3f80:	vfmadd132ps zmm18,zmm0,zmm1
    3f86:	vfmadd132ps zmm17,zmm0,zmm1
    3f8c:	vfmadd132ps zmm16,zmm0,zmm1
    3f92:	vfmadd132ps zmm15,zmm0,zmm1
    3f98:	vfmadd132ps zmm14,zmm0,zmm1
    3f9e:	vfmadd132ps zmm3,zmm0,zmm1
    3fa4:	vfmadd132ps zmm2,zmm0,zmm1
    3faa:	vfmadd132ps zmm19,zmm0,zmm1
    3fb0:	vfmadd132ps zmm18,zmm0,zmm1
    3fb6:	vfmadd132ps zmm17,zmm0,zmm1
    3fbc:	vfmadd132ps zmm16,zmm0,zmm1
    3fc2:	vfmadd132ps zmm15,zmm0,zmm1
    3fc8:	vfmadd132ps zmm14,zmm0,zmm1
    3fce:	vfmadd132ps zmm3,zmm0,zmm1
    3fd4:	vfmadd132ps zmm2,zmm0,zmm1
    3fda:	vfmadd132ps zmm19,zmm0,zmm1
    3fe0:	vfmadd132ps zmm18,zmm0,zmm1
    3fe6:	vfmadd132ps zmm17,zmm0,zmm1
    3fec:	vfmadd132ps zmm16,zmm0,zmm1
    3ff2:	vfmadd132ps zmm15,zmm0,zmm1
    3ff8:	vfmadd132ps zmm14,zmm0,zmm1
    3ffe:	vfmadd132ps zmm3,zmm0,zmm1
    4004:	vfmadd132ps zmm2,zmm0,zmm1
    400a:	vfmadd132ps zmm19,zmm0,zmm1
    4010:	vfmadd132ps zmm18,zmm0,zmm1
    4016:	vfmadd132ps zmm17,zmm0,zmm1
    401c:	vfmadd132ps zmm16,zmm0,zmm1
    4022:	vfmadd132ps zmm15,zmm0,zmm1
    4028:	vfmadd132ps zmm14,zmm0,zmm1
    402e:	vfmadd132ps zmm3,zmm0,zmm1
    4034:	vfmadd132ps zmm2,zmm0,zmm1
    403a:	vfmadd132ps zmm19,zmm0,zmm1
    4040:	vfmadd132ps zmm18,zmm0,zmm1
    4046:	vfmadd132ps zmm17,zmm0,zmm1
    404c:	vfmadd132ps zmm16,zmm0,zmm1
    4052:	vfmadd132ps zmm15,zmm0,zmm1
    4058:	vfmadd132ps zmm14,zmm0,zmm1
    405e:	vfmadd132ps zmm3,zmm0,zmm1
    4064:	vfmadd132ps zmm2,zmm0,zmm1
    406a:	vfmadd132ps zmm19,zmm0,zmm1
    4070:	vfmadd132ps zmm18,zmm0,zmm1
    4076:	vfmadd132ps zmm17,zmm0,zmm1
    407c:	vfmadd132ps zmm16,zmm0,zmm1
    4082:	vfmadd132ps zmm15,zmm0,zmm1
    4088:	vfmadd132ps zmm14,zmm0,zmm1
    408e:	vfmadd132ps zmm3,zmm0,zmm1
    4094:	vfmadd132ps zmm2,zmm0,zmm1
    409a:	vfmadd132ps zmm19,zmm0,zmm1
    40a0:	vfmadd132ps zmm18,zmm0,zmm1
    40a6:	vfmadd132ps zmm17,zmm0,zmm1
    40ac:	vfmadd132ps zmm16,zmm0,zmm1
    40b2:	vfmadd132ps zmm15,zmm0,zmm1
    40b8:	vfmadd132ps zmm14,zmm0,zmm1
    40be:	vfmadd132ps zmm3,zmm0,zmm1
    40c4:	vfmadd132ps zmm2,zmm0,zmm1
    40ca:	vfmadd132ps zmm19,zmm0,zmm1
    40d0:	vfmadd132ps zmm18,zmm0,zmm1
    40d6:	vfmadd132ps zmm17,zmm0,zmm1
    40dc:	vfmadd132ps zmm16,zmm0,zmm1
    40e2:	vfmadd132ps zmm15,zmm0,zmm1
    40e8:	vfmadd132ps zmm14,zmm0,zmm1
    40ee:	vfmadd132ps zmm3,zmm0,zmm1
    40f4:	vfmadd132ps zmm2,zmm0,zmm1
    40fa:	vfmadd132ps zmm19,zmm0,zmm1
    4100:	vfmadd132ps zmm18,zmm0,zmm1
    4106:	vfmadd132ps zmm17,zmm0,zmm1
    410c:	vfmadd132ps zmm16,zmm0,zmm1
    4112:	vfmadd132ps zmm15,zmm0,zmm1
    4118:	vfmadd132ps zmm14,zmm0,zmm1
    411e:	vfmadd132ps zmm3,zmm0,zmm1
    4124:	vfmadd132ps zmm2,zmm0,zmm1
    412a:	vfmadd132ps zmm19,zmm0,zmm1
    4130:	vfmadd132ps zmm18,zmm0,zmm1
    4136:	vfmadd132ps zmm17,zmm0,zmm1
    413c:	vfmadd132ps zmm16,zmm0,zmm1
    4142:	vfmadd132ps zmm15,zmm0,zmm1
    4148:	vfmadd132ps zmm14,zmm0,zmm1
    414e:	vfmadd132ps zmm3,zmm0,zmm1
    4154:	vfmadd132ps zmm2,zmm0,zmm1
    415a:	vfmadd132ps zmm19,zmm0,zmm1
    4160:	vfmadd132ps zmm18,zmm0,zmm1
    4166:	vfmadd132ps zmm17,zmm0,zmm1
    416c:	vfmadd132ps zmm16,zmm0,zmm1
    4172:	vfmadd132ps zmm15,zmm0,zmm1
    4178:	vfmadd132ps zmm14,zmm0,zmm1
    417e:	vfmadd132ps zmm3,zmm0,zmm1
    4184:	vfmadd132ps zmm2,zmm0,zmm1
    418a:	vfmadd132ps zmm19,zmm0,zmm1
    4190:	vfmadd132ps zmm18,zmm0,zmm1
    4196:	vfmadd132ps zmm17,zmm0,zmm1
    419c:	vfmadd132ps zmm16,zmm0,zmm1
    41a2:	vfmadd132ps zmm15,zmm0,zmm1
    41a8:	vfmadd132ps zmm14,zmm0,zmm1
    41ae:	vfmadd132ps zmm3,zmm0,zmm1
    41b4:	vfmadd132ps zmm2,zmm0,zmm1
    41ba:	vfmadd132ps zmm19,zmm0,zmm1
    41c0:	vfmadd132ps zmm18,zmm0,zmm1
    41c6:	vfmadd132ps zmm17,zmm0,zmm1
    41cc:	vfmadd132ps zmm16,zmm0,zmm1
    41d2:	vfmadd132ps zmm15,zmm0,zmm1
    41d8:	vfmadd132ps zmm14,zmm0,zmm1
    41de:	vfmadd132ps zmm3,zmm0,zmm1
    41e4:	vfmadd132ps zmm2,zmm0,zmm1
    41ea:	vfmadd132ps zmm19,zmm0,zmm1
    41f0:	vfmadd132ps zmm18,zmm0,zmm1
    41f6:	vfmadd132ps zmm17,zmm0,zmm1
    41fc:	vfmadd132ps zmm16,zmm0,zmm1
    4202:	vfmadd132ps zmm15,zmm0,zmm1
    4208:	vmovaps zmm1,zmm5
    420e:	vfmadd132ps zmm14,zmm4,zmm5
    4214:	vfmadd132ps zmm3,zmm4,zmm5
    421a:	vmovaps zmm0,zmm4
    4220:	vfmadd132ps zmm2,zmm4,zmm5
    4226:	vaddps zmm13,zmm13,zmm19
    422c:	vaddps zmm12,zmm12,zmm18
    4232:	vaddps zmm11,zmm11,zmm17
    4238:	vaddps zmm10,zmm10,zmm16
    423e:	vaddps zmm9,zmm9,zmm15
    4244:	vaddps zmm8,zmm8,zmm14
    424a:	vaddps zmm7,zmm7,zmm3
    4250:	vaddps zmm6,zmm6,zmm2
    4256:	cmp    rdx,rcx
    4259:	jb     3ed8 <float kernel<16>(float const*, unsigned long, int)+0xe8>
    425f:	vmovaps ZMMWORD PTR [rsp],zmm13
    4266:	vmovaps ZMMWORD PTR [rsp+0x40],zmm12
    426e:	vmovaps ZMMWORD PTR [rsp+0x80],zmm11
    4276:	vmovaps ZMMWORD PTR [rsp+0xc0],zmm10
    427e:	vmovaps ZMMWORD PTR [rsp+0x100],zmm9
    4286:	vmovaps ZMMWORD PTR [rsp+0x140],zmm8
    428e:	vmovaps ZMMWORD PTR [rsp+0x180],zmm7
    4296:	vmovaps ZMMWORD PTR [rsp+0x1c0],zmm6
    429e:	inc    esi
    42a0:	cmp    edi,esi
    42a2:	jne    3e94 <float kernel<16>(float const*, unsigned long, int)+0xa4>
    42a8:	vmovaps zmm0,ZMMWORD PTR [rsp]
    42af:	lea    rdx,[rsp+0x200]
    42b7:	lea    rax,[rsp+0x80]
    42bf:	vaddps zmm0,zmm0,ZMMWORD PTR [rsp+0x40]
    42c7:	vaddps zmm0,zmm0,ZMMWORD PTR [rax]
    42cd:	sub    rax,0xffffffffffffff80
    42d1:	vaddps zmm0,zmm0,ZMMWORD PTR [rax-0x40]
    42d8:	cmp    rdx,rax
    42db:	jne    42c7 <float kernel<16>(float const*, unsigned long, int)+0x4d7>
    42dd:	vextractf64x4 ymm1,zmm0,0x1
    42e4:	vaddps ymm0,ymm1,ymm0
    42e8:	vextractf128 xmm1,ymm0,0x1
    42ee:	vaddps xmm0,xmm1,xmm0
    42f2:	vpermilps xmm1,xmm0,0x4e
    42f8:	vaddps xmm1,xmm1,xmm0
    42fc:	vmovaps xmm0,xmm1
    4300:	vshufps xmm1,xmm1,xmm1,0x55
    4305:	vaddss xmm0,xmm0,xmm1
    4309:	mov    rax,QWORD PTR [rsp+0x238]
    4311:	sub    rax,QWORD PTR fs:0x28
    431a:	jne    4332 <float kernel<16>(float const*, unsigned long, int)+0x542>
    431c:	vzeroupper
    431f:	leave
    4320:	ret
    4321:	inc    esi
    4323:	cmp    edi,esi
    4325:	je     42a8 <float kernel<16>(float const*, unsigned long, int)+0x4b8>
    4327:	inc    esi
    4329:	cmp    edi,esi
    432b:	jne    4321 <float kernel<16>(float const*, unsigned long, int)+0x531>
    432d:	jmp    42a8 <float kernel<16>(float const*, unsigned long, int)+0x4b8>
    4332:	vzeroupper
    4335:	call   22d0 <__stack_chk_fail@plt>
    433a:	nop    WORD PTR [rax+rax*1+0x0]

0000000000004340 <float kernel<32>(float const*, unsigned long, int)>:
    4340:	endbr64
    4344:	push   rbp
    4345:	vpxor  xmm0,xmm0,xmm0
    4349:	mov    rbp,rsp
    434c:	and    rsp,0xffffffffffffffc0
    4350:	sub    rsp,0x240
    4357:	mov    rax,QWORD PTR fs:0x28
    4360:	mov    QWORD PTR [rsp+0x238],rax
    4368:	xor    eax,eax
    436a:	vmovdqa64 ZMMWORD PTR [rsp],zmm0
    4371:	vmovdqa64 ZMMWORD PTR [rsp+0x40],zmm0
    4379:	vmovdqa64 ZMMWORD PTR [rsp+0x80],zmm0
    4381:	vmovdqa64 ZMMWORD PTR [rsp+0xc0],zmm0
    4389:	vmovdqa64 ZMMWORD PTR [rsp+0x100],zmm0
    4391:	vmovdqa64 ZMMWORD PTR [rsp+0x140],zmm0
    4399:	vmovdqa64 ZMMWORD PTR [rsp+0x180],zmm0
    43a1:	vmovdqa64 ZMMWORD PTR [rsp+0x1c0],zmm0
    43a9:	test   edx,edx
    43ab:	jle    4af5 <float kernel<32>(float const*, unsigned long, int)+0x7b5>
    43b1:	mov    r8,rdi
    43b4:	xor    ecx,ecx
    43b6:	mov    edi,edx
    43b8:	test   rsi,rsi
    43bb:	je     4b6e <float kernel<32>(float const*, unsigned long, int)+0x82e>
    43c1:	vbroadcastss zmm3,DWORD PTR [rip+0x2c39]        # 7004 <_IO_stdin_used+0x4>
    43cb:	vbroadcastss zmm2,DWORD PTR [rip+0x2c33]        # 7008 <_IO_stdin_used+0x8>
    43d5:	vmovaps zmm1,zmm3
    43db:	vmovaps zmm0,zmm2
    43e1:	vmovaps zmm12,ZMMWORD PTR [rsp]
    43e8:	vmovaps zmm11,ZMMWORD PTR [rsp+0x40]
    43f0:	mov    rax,r8
    43f3:	xor    edx,edx
    43f5:	vmovaps zmm10,ZMMWORD PTR [rsp+0x80]
    43fd:	vmovaps zmm9,ZMMWORD PTR [rsp+0xc0]
    4405:	vmovaps zmm8,ZMMWORD PTR [rsp+0x100]
    440d:	vmovaps zmm7,ZMMWORD PTR [rsp+0x140]
    4415:	vmovaps zmm6,ZMMWORD PTR [rsp+0x180]
    441d:	vmovaps zmm5,ZMMWORD PTR [rsp+0x1c0]
    4425:	vmovaps zmm19,zmm3
    442b:	vmovaps zmm18,zmm3
    4431:	vmovaps zmm17,zmm3
    4437:	sub    rdx,0xffffffffffffff80
    443b:	vmovaps zmm16,zmm3
    4441:	vmovaps zmm15,zmm3
    4447:	vmovaps zmm14,zmm3
    444d:	add    rax,0x200
    4453:	vmovaps zmm13,zmm3
    4459:	vfmadd132ps zmm19,zmm2,ZMMWORD PTR [rax-0x200]
    4460:	vmovaps zmm4,zmm3
    4466:	vfmadd132ps zmm18,zmm2,ZMMWORD PTR [rax-0x1c0]
    446d:	vfmadd132ps zmm17,zmm2,ZMMWORD PTR [rax-0x180]
    4474:	vfmadd132ps zmm16,zmm2,ZMMWORD PTR [rax-0x140]
    447b:	vfmadd132ps zmm15,zmm2,ZMMWORD PTR [rax-0x100]
    4482:	vfmadd132ps zmm14,zmm2,ZMMWORD PTR [rax-0xc0]
    4489:	vfmadd132ps zmm13,zmm2,ZMMWORD PTR [rax-0x80]
    4490:	vfmadd132ps zmm4,zmm2,ZMMWORD PTR [rax-0x40]
    4497:	vfmadd132ps zmm19,zmm2,zmm3
    449d:	vfmadd132ps zmm18,zmm2,zmm3
    44a3:	vfmadd132ps zmm17,zmm2,zmm3
    44a9:	vfmadd132ps zmm16,zmm2,zmm3
    44af:	vfmadd132ps zmm15,zmm2,zmm3
    44b5:	vfmadd132ps zmm14,zmm2,zmm3
    44bb:	vfmadd132ps zmm13,zmm2,zmm3
    44c1:	vfmadd132ps zmm4,zmm2,zmm3
    44c7:	vfmadd132ps zmm19,zmm2,zmm3
    44cd:	vfmadd132ps zmm18,zmm2,zmm3
    44d3:	vfmadd132ps zmm17,zmm2,zmm3
    44d9:	vfmadd132ps zmm16,zmm2,zmm3
    44df:	vfmadd132ps zmm15,zmm2,zmm3
    44e5:	vfmadd132ps zmm14,zmm2,zmm3
    44eb:	vfmadd132ps zmm13,zmm2,zmm3
    44f1:	vfmadd132ps zmm4,zmm2,zmm3
    44f7:	vfmadd132ps zmm19,zmm2,zmm3
    44fd:	vfmadd132ps zmm18,zmm2,zmm3
    4503:	vfmadd132ps zmm17,zmm2,zmm3
    4509:	vfmadd132ps zmm16,zmm2,zmm3
    450f:	vfmadd132ps zmm15,zmm2,zmm3
    4515:	vfmadd132ps zmm14,zmm2,zmm3
    451b:	vfmadd132ps zmm13,zmm2,zmm3
    4521:	vfmadd132ps zmm4,zmm2,zmm3
    4527:	vfmadd132ps zmm19,zmm2,zmm3
    452d:	vfmadd132ps zmm18,zmm2,zmm3
    4533:	vfmadd132ps zmm17,zmm2,zmm3
    4539:	vfmadd132ps zmm16,zmm2,zmm3
    453f:	vfmadd132ps zmm15,zmm2,zmm3
    4545:	vfmadd132ps zmm14,zmm2,zmm3
    454b:	vfmadd132ps zmm13,zmm2,zmm3
    4551:	vfmadd132ps zmm4,zmm2,zmm3
    4557:	vfmadd132ps zmm19,zmm2,zmm3
    455d:	vfmadd132ps zmm18,zmm2,zmm3
    4563:	vfmadd132ps zmm17,zmm2,zmm3
    4569:	vfmadd132ps zmm16,zmm2,zmm3
    456f:	vfmadd132ps zmm15,zmm2,zmm3
    4575:	vfmadd132ps zmm14,zmm2,zmm3
    457b:	vfmadd132ps zmm13,zmm2,zmm3
    4581:	vfmadd132ps zmm4,zmm2,zmm3
    4587:	vfmadd132ps zmm19,zmm2,zmm3
    458d:	vfmadd132ps zmm18,zmm2,zmm3
    4593:	vfmadd132ps zmm17,zmm2,zmm3
    4599:	vfmadd132ps zmm16,zmm2,zmm3
    459f:	vfmadd132ps zmm15,zmm2,zmm3
    45a5:	vfmadd132ps zmm14,zmm2,zmm3
    45ab:	vfmadd132ps zmm13,zmm2,zmm3
    45b1:	vfmadd132ps zmm4,zmm2,zmm3
    45b7:	vfmadd132ps zmm19,zmm2,zmm3
    45bd:	vfmadd132ps zmm18,zmm2,zmm3
    45c3:	vfmadd132ps zmm17,zmm2,zmm3
    45c9:	vfmadd132ps zmm16,zmm2,zmm3
    45cf:	vfmadd132ps zmm15,zmm2,zmm3
    45d5:	vfmadd132ps zmm14,zmm2,zmm3
    45db:	vfmadd132ps zmm13,zmm2,zmm3
    45e1:	vfmadd132ps zmm4,zmm2,zmm3
    45e7:	vfmadd132ps zmm19,zmm2,zmm3
    45ed:	vfmadd132ps zmm18,zmm2,zmm3
    45f3:	vfmadd132ps zmm17,zmm2,zmm3
    45f9:	vfmadd132ps zmm16,zmm2,zmm3
    45ff:	vfmadd132ps zmm15,zmm2,zmm3
    4605:	vfmadd132ps zmm14,zmm2,zmm3
    460b:	vfmadd132ps zmm13,zmm2,zmm3
    4611:	vfmadd132ps zmm4,zmm2,zmm3
    4617:	vfmadd132ps zmm19,zmm2,zmm3
    461d:	vfmadd132ps zmm18,zmm2,zmm3
    4623:	vfmadd132ps zmm17,zmm2,zmm3
    4629:	vfmadd132ps zmm16,zmm2,zmm3
    462f:	vfmadd132ps zmm15,zmm2,zmm3
    4635:	vfmadd132ps zmm14,zmm2,zmm3
    463b:	vfmadd132ps zmm13,zmm2,zmm3
    4641:	vfmadd132ps zmm4,zmm2,zmm3
    4647:	vfmadd132ps zmm19,zmm2,zmm3
    464d:	vfmadd132ps zmm18,zmm2,zmm3
    4653:	vfmadd132ps zmm17,zmm2,zmm3
    4659:	vfmadd132ps zmm16,zmm2,zmm3
    465f:	vfmadd132ps zmm15,zmm2,zmm3
    4665:	vfmadd132ps zmm14,zmm2,zmm3
    466b:	vfmadd132ps zmm13,zmm2,zmm3
    4671:	vfmadd132ps zmm4,zmm2,zmm3
    4677:	vfmadd132ps zmm19,zmm2,zmm3
    467d:	vfmadd132ps zmm18,zmm2,zmm3
    4683:	vfmadd132ps zmm17,zmm2,zmm3
    4689:	vfmadd132ps zmm16,zmm2,zmm3
    468f:	vfmadd132ps zmm15,zmm2,zmm3
    4695:	vfmadd132ps zmm14,zmm2,zmm3
    469b:	vfmadd132ps zmm13,zmm2,zmm3
    46a1:	vfmadd132ps zmm4,zmm2,zmm3
    46a7:	vfmadd132ps zmm19,zmm2,zmm3
    46ad:	vfmadd132ps zmm18,zmm2,zmm3
    46b3:	vfmadd132ps zmm17,zmm2,zmm3
    46b9:	vfmadd132ps zmm16,zmm2,zmm3
    46bf:	vfmadd132ps zmm15,zmm2,zmm3
    46c5:	vfmadd132ps zmm14,zmm2,zmm3
    46cb:	vfmadd132ps zmm13,zmm2,zmm3
    46d1:	vfmadd132ps zmm4,zmm2,zmm3
    46d7:	vfmadd132ps zmm19,zmm2,zmm3
    46dd:	vfmadd132ps zmm18,zmm2,zmm3
    46e3:	vfmadd132ps zmm17,zmm2,zmm3
    46e9:	vfmadd132ps zmm16,zmm2,zmm3
    46ef:	vfmadd132ps zmm15,zmm2,zmm3
    46f5:	vfmadd132ps zmm14,zmm2,zmm3
    46fb:	vfmadd132ps zmm13,zmm2,zmm3
    4701:	vfmadd132ps zmm4,zmm2,zmm3
    4707:	vfmadd132ps zmm19,zmm2,zmm3
    470d:	vfmadd132ps zmm18,zmm2,zmm3
    4713:	vfmadd132ps zmm17,zmm2,zmm3
    4719:	vfmadd132ps zmm16,zmm2,zmm3
    471f:	vfmadd132ps zmm15,zmm2,zmm3
    4725:	vfmadd132ps zmm14,zmm2,zmm3
    472b:	vfmadd132ps zmm13,zmm2,zmm3
    4731:	vfmadd132ps zmm4,zmm2,zmm3
    4737:	vfmadd132ps zmm19,zmm2,zmm3
    473d:	vfmadd132ps zmm18,zmm2,zmm3
    4743:	vfmadd132ps zmm17,zmm2,zmm3
    4749:	vfmadd132ps zmm16,zmm2,zmm3
    474f:	vfmadd132ps zmm15,zmm2,zmm3
    4755:	vmovaps zmm3,zmm1
    475b:	vfmadd132ps zmm14,zmm0,zmm1
    4761:	vfmadd132ps zmm13,zmm0,zmm1
    4767:	vmovaps zmm2,zmm0
    476d:	vfmadd132ps zmm4,zmm0,zmm1
    4773:	vfmadd132ps zmm19,zmm0,zmm1
    4779:	vfmadd132ps zmm18,zmm0,zmm1
    477f:	vfmadd132ps zmm17,zmm0,zmm1
    4785:	vfmadd132ps zmm16,zmm0,zmm1
    478b:	vfmadd132ps zmm15,zmm0,zmm1
    4791:	vfmadd132ps zmm14,zmm0,zmm1
    4797:	vfmadd132ps zmm13,zmm0,zmm1
    479d:	vfmadd132ps zmm4,zmm0,zmm1
    47a3:	vfmadd132ps zmm19,zmm0,zmm1
    47a9:	vfmadd132ps zmm18,zmm0,zmm1
    47af:	vfmadd132ps zmm17,zmm0,zmm1
    47b5:	vfmadd132ps zmm16,zmm0,zmm1
    47bb:	vfmadd132ps zmm15,zmm0,zmm1
    47c1:	vfmadd132ps zmm14,zmm0,zmm1
    47c7:	vfmadd132ps zmm13,zmm0,zmm1
    47cd:	vfmadd132ps zmm4,zmm0,zmm1
    47d3:	vfmadd132ps zmm19,zmm0,zmm1
    47d9:	vfmadd132ps zmm18,zmm0,zmm1
    47df:	vfmadd132ps zmm17,zmm0,zmm1
    47e5:	vfmadd132ps zmm16,zmm0,zmm1
    47eb:	vfmadd132ps zmm15,zmm0,zmm1
    47f1:	vfmadd132ps zmm14,zmm0,zmm1
    47f7:	vfmadd132ps zmm13,zmm0,zmm1
    47fd:	vfmadd132ps zmm4,zmm0,zmm1
    4803:	vfmadd132ps zmm19,zmm0,zmm1
    4809:	vfmadd132ps zmm18,zmm0,zmm1
    480f:	vfmadd132ps zmm17,zmm0,zmm1
    4815:	vfmadd132ps zmm16,zmm0,zmm1
    481b:	vfmadd132ps zmm15,zmm0,zmm1
    4821:	vfmadd132ps zmm14,zmm0,zmm1
    4827:	vfmadd132ps zmm13,zmm0,zmm1
    482d:	vfmadd132ps zmm4,zmm0,zmm1
    4833:	vfmadd132ps zmm19,zmm0,zmm1
    4839:	vfmadd132ps zmm18,zmm0,zmm1
    483f:	vfmadd132ps zmm17,zmm0,zmm1
    4845:	vfmadd132ps zmm16,zmm0,zmm1
    484b:	vfmadd132ps zmm15,zmm0,zmm1
    4851:	vfmadd132ps zmm14,zmm0,zmm1
    4857:	vfmadd132ps zmm13,zmm0,zmm1
    485d:	vfmadd132ps zmm4,zmm0,zmm1
    4863:	vfmadd132ps zmm19,zmm0,zmm1
    4869:	vfmadd132ps zmm18,zmm0,zmm1
    486f:	vfmadd132ps zmm17,zmm0,zmm1
    4875:	vfmadd132ps zmm16,zmm0,zmm1
    487b:	vfmadd132ps zmm15,zmm0,zmm1
    4881:	vfmadd132ps zmm14,zmm0,zmm1
    4887:	vfmadd132ps zmm13,zmm0,zmm1
    488d:	vfmadd132ps zmm4,zmm0,zmm1
    4893:	vfmadd132ps zmm19,zmm0,zmm1
    4899:	vfmadd132ps zmm18,zmm0,zmm1
    489f:	vfmadd132ps zmm17,zmm0,zmm1
    48a5:	vfmadd132ps zmm16,zmm0,zmm1
    48ab:	vfmadd132ps zmm15,zmm0,zmm1
    48b1:	vfmadd132ps zmm14,zmm0,zmm1
    48b7:	vfmadd132ps zmm13,zmm0,zmm1
    48bd:	vfmadd132ps zmm4,zmm0,zmm1
    48c3:	vfmadd132ps zmm19,zmm0,zmm1
    48c9:	vfmadd132ps zmm18,zmm0,zmm1
    48cf:	vfmadd132ps zmm17,zmm0,zmm1
    48d5:	vfmadd132ps zmm16,zmm0,zmm1
    48db:	vfmadd132ps zmm15,zmm0,zmm1
    48e1:	vfmadd132ps zmm14,zmm0,zmm1
    48e7:	vfmadd132ps zmm13,zmm0,zmm1
    48ed:	vfmadd132ps zmm4,zmm0,zmm1
    48f3:	vfmadd132ps zmm19,zmm0,zmm1
    48f9:	vfmadd132ps zmm18,zmm0,zmm1
    48ff:	vfmadd132ps zmm17,zmm0,zmm1
    4905:	vfmadd132ps zmm16,zmm0,zmm1
    490b:	vfmadd132ps zmm15,zmm0,zmm1
    4911:	vfmadd132ps zmm14,zmm0,zmm1
    4917:	vfmadd132ps zmm13,zmm0,zmm1
    491d:	vfmadd132ps zmm4,zmm0,zmm1
    4923:	vfmadd132ps zmm19,zmm0,zmm1
    4929:	vfmadd132ps zmm18,zmm0,zmm1
    492f:	vfmadd132ps zmm17,zmm0,zmm1
    4935:	vfmadd132ps zmm16,zmm0,zmm1
    493b:	vfmadd132ps zmm15,zmm0,zmm1
    4941:	vfmadd132ps zmm14,zmm0,zmm1
    4947:	vfmadd132ps zmm13,zmm0,zmm1
    494d:	vfmadd132ps zmm4,zmm0,zmm1
    4953:	vfmadd132ps zmm19,zmm0,zmm1
    4959:	vfmadd132ps zmm18,zmm0,zmm1
    495f:	vfmadd132ps zmm17,zmm0,zmm1
    4965:	vfmadd132ps zmm16,zmm0,zmm1
    496b:	vfmadd132ps zmm15,zmm0,zmm1
    4971:	vfmadd132ps zmm14,zmm0,zmm1
    4977:	vfmadd132ps zmm13,zmm0,zmm1
    497d:	vfmadd132ps zmm4,zmm0,zmm1
    4983:	vfmadd132ps zmm19,zmm0,zmm1
    4989:	vfmadd132ps zmm18,zmm0,zmm1
    498f:	vfmadd132ps zmm17,zmm0,zmm1
    4995:	vfmadd132ps zmm16,zmm0,zmm1
    499b:	vfmadd132ps zmm15,zmm0,zmm1
    49a1:	vfmadd132ps zmm14,zmm0,zmm1
    49a7:	vfmadd132ps zmm13,zmm0,zmm1
    49ad:	vfmadd132ps zmm4,zmm0,zmm1
    49b3:	vfmadd132ps zmm19,zmm0,zmm1
    49b9:	vfmadd132ps zmm18,zmm0,zmm1
    49bf:	vfmadd132ps zmm17,zmm0,zmm1
    49c5:	vfmadd132ps zmm16,zmm0,zmm1
    49cb:	vfmadd132ps zmm15,zmm0,zmm1
    49d1:	vfmadd132ps zmm14,zmm0,zmm1
    49d7:	vfmadd132ps zmm13,zmm0,zmm1
    49dd:	vfmadd132ps zmm4,zmm0,zmm1
    49e3:	vfmadd132ps zmm19,zmm0,zmm1
    49e9:	vfmadd132ps zmm18,zmm0,zmm1
    49ef:	vfmadd132ps zmm17,zmm0,zmm1
    49f5:	vfmadd132ps zmm16,zmm0,zmm1
    49fb:	vfmadd132ps zmm15,zmm0,zmm1
    4a01:	vfmadd132ps zmm14,zmm0,zmm1
    4a07:	vfmadd132ps zmm13,zmm0,zmm1
    4a0d:	vfmadd132ps zmm4,zmm0,zmm1
    4a13:	vfmadd132ps zmm19,zmm0,zmm1
    4a19:	vfmadd132ps zmm18,zmm0,zmm1
    4a1f:	vfmadd132ps zmm17,zmm0,zmm1
    4a25:	vfmadd132ps zmm16,zmm0,zmm1
    4a2b:	vfmadd132ps zmm15,zmm0,zmm1
    4a31:	vfmadd132ps zmm14,zmm0,zmm1
    4a37:	vfmadd132ps zmm13,zmm0,zmm1
    4a3d:	vfmadd132ps zmm4,zmm0,zmm1
    4a43:	vfmadd132ps zmm19,zmm0,zmm1
    4a49:	vfmadd132ps zmm18,zmm0,zmm1
    4a4f:	vfmadd132ps zmm17,zmm0,zmm1
    4a55:	vfmadd132ps zmm16,zmm0,zmm1
    4a5b:	vfmadd132ps zmm15,zmm0,zmm1
    4a61:	vfmadd132ps zmm14,zmm0,zmm1
    4a67:	vfmadd132ps zmm13,zmm0,zmm1
    4a6d:	vfmadd132ps zmm4,zmm0,zmm1
    4a73:	vaddps zmm12,zmm12,zmm19
    4a79:	vaddps zmm11,zmm11,zmm18
    4a7f:	vaddps zmm10,zmm10,zmm17
    4a85:	vaddps zmm9,zmm9,zmm16
    4a8b:	vaddps zmm8,zmm8,zmm15
    4a91:	vaddps zmm7,zmm7,zmm14
    4a97:	vaddps zmm6,zmm6,zmm13
    4a9d:	vaddps zmm5,zmm5,zmm4
    4aa3:	cmp    rdx,rsi
    4aa6:	jb     4425 <float kernel<32>(float const*, unsigned long, int)+0xe5>
    4aac:	vmovaps ZMMWORD PTR [rsp],zmm12
    4ab3:	vmovaps ZMMWORD PTR [rsp+0x40],zmm11
    4abb:	vmovaps ZMMWORD PTR [rsp+0x80],zmm10
    4ac3:	vmovaps ZMMWORD PTR [rsp+0xc0],zmm9
    4acb:	vmovaps ZMMWORD PTR [rsp+0x100],zmm8
    4ad3:	vmovaps ZMMWORD PTR [rsp+0x140],zmm7
    4adb:	vmovaps ZMMWORD PTR [rsp+0x180],zmm6
    4ae3:	vmovaps ZMMWORD PTR [rsp+0x1c0],zmm5
    4aeb:	inc    ecx
    4aed:	cmp    edi,ecx
    4aef:	jne    43e1 <float kernel<32>(float const*, unsigned long, int)+0xa1>
    4af5:	vmovaps zmm0,ZMMWORD PTR [rsp]
    4afc:	lea    rdx,[rsp+0x200]
    4b04:	lea    rax,[rsp+0x80]
    4b0c:	vaddps zmm0,zmm0,ZMMWORD PTR [rsp+0x40]
    4b14:	vaddps zmm0,zmm0,ZMMWORD PTR [rax]
    4b1a:	sub    rax,0xffffffffffffff80
    4b1e:	vaddps zmm0,zmm0,ZMMWORD PTR [rax-0x40]
    4b25:	cmp    rdx,rax
    4b28:	jne    4b14 <float kernel<32>(float const*, unsigned long, int)+0x7d4>
    4b2a:	vextractf64x4 ymm1,zmm0,0x1
    4b31:	vaddps ymm0,ymm1,ymm0
    4b35:	vextractf128 xmm1,ymm0,0x1
    4b3b:	vaddps xmm0,xmm1,xmm0
    4b3f:	vpermilps xmm1,xmm0,0x4e
    4b45:	vaddps xmm1,xmm1,xmm0
    4b49:	vmovaps xmm0,xmm1
    4b4d:	vshufps xmm1,xmm1,xmm1,0x55
    4b52:	vaddss xmm0,xmm0,xmm1
    4b56:	mov    rax,QWORD PTR [rsp+0x238]
    4b5e:	sub    rax,QWORD PTR fs:0x28
    4b67:	jne    4b7f <float kernel<32>(float const*, unsigned long, int)+0x83f>
    4b69:	vzeroupper
    4b6c:	leave
    4b6d:	ret
    4b6e:	inc    ecx
    4b70:	cmp    edi,ecx
    4b72:	je     4af5 <float kernel<32>(float const*, unsigned long, int)+0x7b5>
    4b74:	inc    ecx
    4b76:	cmp    edi,ecx
    4b78:	jne    4b6e <float kernel<32>(float const*, unsigned long, int)+0x82e>
    4b7a:	jmp    4af5 <float kernel<32>(float const*, unsigned long, int)+0x7b5>
    4b7f:	vzeroupper
    4b82:	call   22d0 <__stack_chk_fail@plt>
    4b87:	nop    WORD PTR [rax+rax*1+0x0]

0000000000004b90 <float kernel<64>(float const*, unsigned long, int)>:
    4b90:	endbr64
    4b94:	push   rbp
    4b95:	vpxor  xmm0,xmm0,xmm0
    4b99:	mov    ecx,edx
    4b9b:	mov    rbp,rsp
    4b9e:	and    rsp,0xffffffffffffffc0
    4ba2:	sub    rsp,0x240
    4ba9:	mov    rax,QWORD PTR fs:0x28
    4bb2:	mov    QWORD PTR [rsp+0x238],rax
    4bba:	xor    eax,eax
    4bbc:	vmovdqa64 ZMMWORD PTR [rsp],zmm0
    4bc3:	vmovdqa64 ZMMWORD PTR [rsp+0x40],zmm0
    4bcb:	vmovdqa64 ZMMWORD PTR [rsp+0x80],zmm0
    4bd3:	vmovdqa64 ZMMWORD PTR [rsp+0xc0],zmm0
    4bdb:	vmovdqa64 ZMMWORD PTR [rsp+0x100],zmm0
    4be3:	vmovdqa64 ZMMWORD PTR [rsp+0x140],zmm0
    4beb:	vmovdqa64 ZMMWORD PTR [rsp+0x180],zmm0
    4bf3:	vmovdqa64 ZMMWORD PTR [rsp+0x1c0],zmm0
    4bfb:	test   edx,edx
    4bfd:	jle    5943 <float kernel<64>(float const*, unsigned long, int)+0xdb3>
    4c03:	xor    edx,edx
    4c05:	test   rsi,rsi
    4c08:	je     59bc <float kernel<64>(float const*, unsigned long, int)+0xe2c>
    4c0e:	vbroadcastss zmm3,DWORD PTR [rip+0x23ec]        # 7004 <_IO_stdin_used+0x4>
    4c18:	vbroadcastss zmm2,DWORD PTR [rip+0x23e6]        # 7008 <_IO_stdin_used+0x8>
    4c22:	vmovaps zmm1,zmm3
    4c28:	vmovaps zmm0,zmm2
    4c2e:	vmovaps zmm12,ZMMWORD PTR [rsp]
    4c35:	vmovaps zmm11,ZMMWORD PTR [rsp+0x40]
    4c3d:	mov    rax,rdi
    4c40:	xor    r8d,r8d
    4c43:	vmovaps zmm10,ZMMWORD PTR [rsp+0x80]
    4c4b:	vmovaps zmm9,ZMMWORD PTR [rsp+0xc0]
    4c53:	vmovaps zmm8,ZMMWORD PTR [rsp+0x100]
    4c5b:	vmovaps zmm7,ZMMWORD PTR [rsp+0x140]
    4c63:	vmovaps zmm6,ZMMWORD PTR [rsp+0x180]
    4c6b:	vmovaps zmm5,ZMMWORD PTR [rsp+0x1c0]
    4c73:	vmovaps zmm19,zmm3
    4c79:	vmovaps zmm18,zmm3
    4c7f:	vmovaps zmm17,zmm3
    4c85:	sub    r8,0xffffffffffffff80
    4c89:	vmovaps zmm16,zmm3
    4c8f:	vmovaps zmm15,zmm3
    4c95:	vmovaps zmm14,zmm3
    4c9b:	add    rax,0x200
    4ca1:	vmovaps zmm13,zmm3
    4ca7:	vfmadd132ps zmm19,zmm2,ZMMWORD PTR [rax-0x200]
    4cae:	vmovaps zmm4,zmm3
    4cb4:	vfmadd132ps zmm18,zmm2,ZMMWORD PTR [rax-0x1c0]
    4cbb:	vfmadd132ps zmm17,zmm2,ZMMWORD PTR [rax-0x180]
    4cc2:	vfmadd132ps zmm16,zmm2,ZMMWORD PTR [rax-0x140]
    4cc9:	vfmadd132ps zmm15,zmm2,ZMMWORD PTR [rax-0x100]
    4cd0:	vfmadd132ps zmm14,zmm2,ZMMWORD PTR [rax-0xc0]
    4cd7:	vfmadd132ps zmm13,zmm2,ZMMWORD PTR [rax-0x80]
    4cde:	vfmadd132ps zmm4,zmm2,ZMMWORD PTR [rax-0x40]
    4ce5:	vfmadd132ps zmm19,zmm2,zmm3
    4ceb:	vfmadd132ps zmm18,zmm2,zmm3
    4cf1:	vfmadd132ps zmm17,zmm2,zmm3
    4cf7:	vfmadd132ps zmm16,zmm2,zmm3
    4cfd:	vfmadd132ps zmm15,zmm2,zmm3
    4d03:	vfmadd132ps zmm14,zmm2,zmm3
    4d09:	vfmadd132ps zmm13,zmm2,zmm3
    4d0f:	vfmadd132ps zmm4,zmm2,zmm3
    4d15:	vfmadd132ps zmm19,zmm2,zmm3
    4d1b:	vfmadd132ps zmm18,zmm2,zmm3
    4d21:	vfmadd132ps zmm17,zmm2,zmm3
    4d27:	vfmadd132ps zmm16,zmm2,zmm3
    4d2d:	vfmadd132ps zmm15,zmm2,zmm3
    4d33:	vfmadd132ps zmm14,zmm2,zmm3
    4d39:	vfmadd132ps zmm13,zmm2,zmm3
    4d3f:	vfmadd132ps zmm4,zmm2,zmm3
    4d45:	vfmadd132ps zmm19,zmm2,zmm3
    4d4b:	vfmadd132ps zmm18,zmm2,zmm3
    4d51:	vfmadd132ps zmm17,zmm2,zmm3
    4d57:	vfmadd132ps zmm16,zmm2,zmm3
    4d5d:	vfmadd132ps zmm15,zmm2,zmm3
    4d63:	vfmadd132ps zmm14,zmm2,zmm3
    4d69:	vfmadd132ps zmm13,zmm2,zmm3
    4d6f:	vfmadd132ps zmm4,zmm2,zmm3
    4d75:	vfmadd132ps zmm19,zmm2,zmm3
    4d7b:	vfmadd132ps zmm18,zmm2,zmm3
    4d81:	vfmadd132ps zmm17,zmm2,zmm3
    4d87:	vfmadd132ps zmm16,zmm2,zmm3
    4d8d:	vfmadd132ps zmm15,zmm2,zmm3
    4d93:	vfmadd132ps zmm14,zmm2,zmm3
    4d99:	vfmadd132ps zmm13,zmm2,zmm3
    4d9f:	vfmadd132ps zmm4,zmm2,zmm3
    4da5:	vfmadd132ps zmm19,zmm2,zmm3
    4dab:	vfmadd132ps zmm18,zmm2,zmm3
    4db1:	vfmadd132ps zmm17,zmm2,zmm3
    4db7:	vfmadd132ps zmm16,zmm2,zmm3
    4dbd:	vfmadd132ps zmm15,zmm2,zmm3
    4dc3:	vfmadd132ps zmm14,zmm2,zmm3
    4dc9:	vfmadd132ps zmm13,zmm2,zmm3
    4dcf:	vfmadd132ps zmm4,zmm2,zmm3
    4dd5:	vfmadd132ps zmm19,zmm2,zmm3
    4ddb:	vfmadd132ps zmm18,zmm2,zmm3
    4de1:	vfmadd132ps zmm17,zmm2,zmm3
    4de7:	vfmadd132ps zmm16,zmm2,zmm3
    4ded:	vfmadd132ps zmm15,zmm2,zmm3
    4df3:	vfmadd132ps zmm14,zmm2,zmm3
    4df9:	vfmadd132ps zmm13,zmm2,zmm3
    4dff:	vfmadd132ps zmm4,zmm2,zmm3
    4e05:	vfmadd132ps zmm19,zmm2,zmm3
    4e0b:	vfmadd132ps zmm18,zmm2,zmm3
    4e11:	vfmadd132ps zmm17,zmm2,zmm3
    4e17:	vfmadd132ps zmm16,zmm2,zmm3
    4e1d:	vfmadd132ps zmm15,zmm2,zmm3
    4e23:	vfmadd132ps zmm14,zmm2,zmm3
    4e29:	vfmadd132ps zmm13,zmm2,zmm3
    4e2f:	vfmadd132ps zmm4,zmm2,zmm3
    4e35:	vfmadd132ps zmm19,zmm2,zmm3
    4e3b:	vfmadd132ps zmm18,zmm2,zmm3
    4e41:	vfmadd132ps zmm17,zmm2,zmm3
    4e47:	vfmadd132ps zmm16,zmm2,zmm3
    4e4d:	vfmadd132ps zmm15,zmm2,zmm3
    4e53:	vfmadd132ps zmm14,zmm2,zmm3
    4e59:	vfmadd132ps zmm13,zmm2,zmm3
    4e5f:	vfmadd132ps zmm4,zmm2,zmm3
    4e65:	vfmadd132ps zmm19,zmm2,zmm3
    4e6b:	vfmadd132ps zmm18,zmm2,zmm3
    4e71:	vfmadd132ps zmm17,zmm2,zmm3
    4e77:	vfmadd132ps zmm16,zmm2,zmm3
    4e7d:	vfmadd132ps zmm15,zmm2,zmm3
    4e83:	vfmadd132ps zmm14,zmm2,zmm3
    4e89:	vfmadd132ps zmm13,zmm2,zmm3
    4e8f:	vfmadd132ps zmm4,zmm2,zmm3
    4e95:	vfmadd132ps zmm19,zmm2,zmm3
    4e9b:	vfmadd132ps zmm18,zmm2,zmm3
    4ea1:	vfmadd132ps zmm17,zmm2,zmm3
    4ea7:	vfmadd132ps zmm16,zmm2,zmm3
    4ead:	vfmadd132ps zmm15,zmm2,zmm3
    4eb3:	vfmadd132ps zmm14,zmm2,zmm3
    4eb9:	vfmadd132ps zmm13,zmm2,zmm3
    4ebf:	vfmadd132ps zmm4,zmm2,zmm3
    4ec5:	vfmadd132ps zmm19,zmm2,zmm3
    4ecb:	vfmadd132ps zmm18,zmm2,zmm3
    4ed1:	vfmadd132ps zmm17,zmm2,zmm3
    4ed7:	vfmadd132ps zmm16,zmm2,zmm3
    4edd:	vfmadd132ps zmm15,zmm2,zmm3
    4ee3:	vfmadd132ps zmm14,zmm2,zmm3
    4ee9:	vfmadd132ps zmm13,zmm2,zmm3
    4eef:	vfmadd132ps zmm4,zmm2,zmm3
    4ef5:	vfmadd132ps zmm19,zmm2,zmm3
    4efb:	vfmadd132ps zmm18,zmm2,zmm3
    4f01:	vfmadd132ps zmm17,zmm2,zmm3
    4f07:	vfmadd132ps zmm16,zmm2,zmm3
    4f0d:	vfmadd132ps zmm15,zmm2,zmm3
    4f13:	vfmadd132ps zmm14,zmm2,zmm3
    4f19:	vfmadd132ps zmm13,zmm2,zmm3
    4f1f:	vfmadd132ps zmm4,zmm2,zmm3
    4f25:	vfmadd132ps zmm19,zmm2,zmm3
    4f2b:	vfmadd132ps zmm18,zmm2,zmm3
    4f31:	vfmadd132ps zmm17,zmm2,zmm3
    4f37:	vfmadd132ps zmm16,zmm2,zmm3
    4f3d:	vfmadd132ps zmm15,zmm2,zmm3
    4f43:	vfmadd132ps zmm14,zmm2,zmm3
    4f49:	vfmadd132ps zmm13,zmm2,zmm3
    4f4f:	vfmadd132ps zmm4,zmm2,zmm3
    4f55:	vfmadd132ps zmm19,zmm2,zmm3
    4f5b:	vfmadd132ps zmm18,zmm2,zmm3
    4f61:	vfmadd132ps zmm17,zmm2,zmm3
    4f67:	vfmadd132ps zmm16,zmm2,zmm3
    4f6d:	vfmadd132ps zmm15,zmm2,zmm3
    4f73:	vfmadd132ps zmm14,zmm2,zmm3
    4f79:	vfmadd132ps zmm13,zmm2,zmm3
    4f7f:	vfmadd132ps zmm4,zmm2,zmm3
    4f85:	vfmadd132ps zmm19,zmm2,zmm3
    4f8b:	vfmadd132ps zmm18,zmm2,zmm3
    4f91:	vfmadd132ps zmm17,zmm2,zmm3
    4f97:	vfmadd132ps zmm16,zmm2,zmm3
    4f9d:	vfmadd132ps zmm15,zmm2,zmm3
    4fa3:	vmovaps zmm3,zmm1
    4fa9:	vfmadd132ps zmm14,zmm0,zmm1
    4faf:	vfmadd132ps zmm13,zmm0,zmm1
    4fb5:	vmovaps zmm2,zmm0
    4fbb:	vfmadd132ps zmm4,zmm0,zmm1
    4fc1:	vfmadd132ps zmm19,zmm0,zmm1
    4fc7:	vfmadd132ps zmm18,zmm0,zmm1
    4fcd:	vfmadd132ps zmm17,zmm0,zmm1
    4fd3:	vfmadd132ps zmm16,zmm0,zmm1
    4fd9:	vfmadd132ps zmm15,zmm0,zmm1
    4fdf:	vfmadd132ps zmm14,zmm0,zmm1
    4fe5:	vfmadd132ps zmm13,zmm0,zmm1
    4feb:	vfmadd132ps zmm4,zmm0,zmm1
    4ff1:	vfmadd132ps zmm19,zmm0,zmm1
    4ff7:	vfmadd132ps zmm18,zmm0,zmm1
    4ffd:	vfmadd132ps zmm17,zmm0,zmm1
    5003:	vfmadd132ps zmm16,zmm0,zmm1
    5009:	vfmadd132ps zmm15,zmm0,zmm1
    500f:	vfmadd132ps zmm14,zmm0,zmm1
    5015:	vfmadd132ps zmm13,zmm0,zmm1
    501b:	vfmadd132ps zmm4,zmm0,zmm1
    5021:	vfmadd132ps zmm19,zmm0,zmm1
    5027:	vfmadd132ps zmm18,zmm0,zmm1
    502d:	vfmadd132ps zmm17,zmm0,zmm1
    5033:	vfmadd132ps zmm16,zmm0,zmm1
    5039:	vfmadd132ps zmm15,zmm0,zmm1
    503f:	vfmadd132ps zmm14,zmm0,zmm1
    5045:	vfmadd132ps zmm13,zmm0,zmm1
    504b:	vfmadd132ps zmm4,zmm0,zmm1
    5051:	vfmadd132ps zmm19,zmm0,zmm1
    5057:	vfmadd132ps zmm18,zmm0,zmm1
    505d:	vfmadd132ps zmm17,zmm0,zmm1
    5063:	vfmadd132ps zmm16,zmm0,zmm1
    5069:	vfmadd132ps zmm15,zmm0,zmm1
    506f:	vfmadd132ps zmm14,zmm0,zmm1
    5075:	vfmadd132ps zmm13,zmm0,zmm1
    507b:	vfmadd132ps zmm4,zmm0,zmm1
    5081:	vfmadd132ps zmm19,zmm0,zmm1
    5087:	vfmadd132ps zmm18,zmm0,zmm1
    508d:	vfmadd132ps zmm17,zmm0,zmm1
    5093:	vfmadd132ps zmm16,zmm0,zmm1
    5099:	vfmadd132ps zmm15,zmm0,zmm1
    509f:	vfmadd132ps zmm14,zmm0,zmm1
    50a5:	vfmadd132ps zmm13,zmm0,zmm1
    50ab:	vfmadd132ps zmm4,zmm0,zmm1
    50b1:	vfmadd132ps zmm19,zmm0,zmm1
    50b7:	vfmadd132ps zmm18,zmm0,zmm1
    50bd:	vfmadd132ps zmm17,zmm0,zmm1
    50c3:	vfmadd132ps zmm16,zmm0,zmm1
    50c9:	vfmadd132ps zmm15,zmm0,zmm1
    50cf:	vfmadd132ps zmm14,zmm0,zmm1
    50d5:	vfmadd132ps zmm13,zmm0,zmm1
    50db:	vfmadd132ps zmm4,zmm0,zmm1
    50e1:	vfmadd132ps zmm19,zmm0,zmm1
    50e7:	vfmadd132ps zmm18,zmm0,zmm1
    50ed:	vfmadd132ps zmm17,zmm0,zmm1
    50f3:	vfmadd132ps zmm16,zmm0,zmm1
    50f9:	vfmadd132ps zmm15,zmm0,zmm1
    50ff:	vfmadd132ps zmm14,zmm0,zmm1
    5105:	vfmadd132ps zmm13,zmm0,zmm1
    510b:	vfmadd132ps zmm4,zmm0,zmm1
    5111:	vfmadd132ps zmm19,zmm0,zmm1
    5117:	vfmadd132ps zmm18,zmm0,zmm1
    511d:	vfmadd132ps zmm17,zmm0,zmm1
    5123:	vfmadd132ps zmm16,zmm0,zmm1
    5129:	vfmadd132ps zmm15,zmm0,zmm1
    512f:	vfmadd132ps zmm14,zmm0,zmm1
    5135:	vfmadd132ps zmm13,zmm0,zmm1
    513b:	vfmadd132ps zmm4,zmm0,zmm1
    5141:	vfmadd132ps zmm19,zmm0,zmm1
    5147:	vfmadd132ps zmm18,zmm0,zmm1
    514d:	vfmadd132ps zmm17,zmm0,zmm1
    5153:	vfmadd132ps zmm16,zmm0,zmm1
    5159:	vfmadd132ps zmm15,zmm0,zmm1
    515f:	vfmadd132ps zmm14,zmm0,zmm1
    5165:	vfmadd132ps zmm13,zmm0,zmm1
    516b:	vfmadd132ps zmm4,zmm0,zmm1
    5171:	vfmadd132ps zmm19,zmm0,zmm1
    5177:	vfmadd132ps zmm18,zmm0,zmm1
    517d:	vfmadd132ps zmm17,zmm0,zmm1
    5183:	vfmadd132ps zmm16,zmm0,zmm1
    5189:	vfmadd132ps zmm15,zmm0,zmm1
    518f:	vfmadd132ps zmm14,zmm0,zmm1
    5195:	vfmadd132ps zmm13,zmm0,zmm1
    519b:	vfmadd132ps zmm4,zmm0,zmm1
    51a1:	vfmadd132ps zmm19,zmm0,zmm1
    51a7:	vfmadd132ps zmm18,zmm0,zmm1
    51ad:	vfmadd132ps zmm17,zmm0,zmm1
    51b3:	vfmadd132ps zmm16,zmm0,zmm1
    51b9:	vfmadd132ps zmm15,zmm0,zmm1
    51bf:	vfmadd132ps zmm14,zmm0,zmm1
    51c5:	vfmadd132ps zmm13,zmm0,zmm1
    51cb:	vfmadd132ps zmm4,zmm0,zmm1
    51d1:	vfmadd132ps zmm19,zmm0,zmm1
    51d7:	vfmadd132ps zmm18,zmm0,zmm1
    51dd:	vfmadd132ps zmm17,zmm0,zmm1
    51e3:	vfmadd132ps zmm16,zmm0,zmm1
    51e9:	vfmadd132ps zmm15,zmm0,zmm1
    51ef:	vfmadd132ps zmm14,zmm0,zmm1
    51f5:	vfmadd132ps zmm13,zmm0,zmm1
    51fb:	vfmadd132ps zmm4,zmm0,zmm1
    5201:	vfmadd132ps zmm19,zmm0,zmm1
    5207:	vfmadd132ps zmm18,zmm0,zmm1
    520d:	vfmadd132ps zmm17,zmm0,zmm1
    5213:	vfmadd132ps zmm16,zmm0,zmm1
    5219:	vfmadd132ps zmm15,zmm0,zmm1
    521f:	vfmadd132ps zmm14,zmm0,zmm1
    5225:	vfmadd132ps zmm13,zmm0,zmm1
    522b:	vfmadd132ps zmm4,zmm0,zmm1
    5231:	vfmadd132ps zmm19,zmm0,zmm1
    5237:	vfmadd132ps zmm18,zmm0,zmm1
    523d:	vfmadd132ps zmm17,zmm0,zmm1
    5243:	vfmadd132ps zmm16,zmm0,zmm1
    5249:	vfmadd132ps zmm15,zmm0,zmm1
    524f:	vfmadd132ps zmm14,zmm0,zmm1
    5255:	vfmadd132ps zmm13,zmm0,zmm1
    525b:	vfmadd132ps zmm4,zmm0,zmm1
    5261:	vfmadd132ps zmm19,zmm0,zmm1
    5267:	vfmadd132ps zmm18,zmm0,zmm1
    526d:	vfmadd132ps zmm17,zmm0,zmm1
    5273:	vfmadd132ps zmm16,zmm0,zmm1
    5279:	vfmadd132ps zmm15,zmm0,zmm1
    527f:	vfmadd132ps zmm14,zmm0,zmm1
    5285:	vfmadd132ps zmm13,zmm0,zmm1
    528b:	vfmadd132ps zmm4,zmm0,zmm1
    5291:	vfmadd132ps zmm19,zmm0,zmm1
    5297:	vfmadd132ps zmm18,zmm0,zmm1
    529d:	vfmadd132ps zmm17,zmm0,zmm1
    52a3:	vfmadd132ps zmm16,zmm0,zmm1
    52a9:	vfmadd132ps zmm15,zmm0,zmm1
    52af:	vfmadd132ps zmm14,zmm0,zmm1
    52b5:	vfmadd132ps zmm13,zmm0,zmm1
    52bb:	vfmadd132ps zmm4,zmm0,zmm1
    52c1:	vfmadd132ps zmm19,zmm0,zmm1
    52c7:	vfmadd132ps zmm18,zmm0,zmm1
    52cd:	vfmadd132ps zmm17,zmm0,zmm1
    52d3:	vfmadd132ps zmm16,zmm0,zmm1
    52d9:	vfmadd132ps zmm15,zmm0,zmm1
    52df:	vfmadd132ps zmm14,zmm0,zmm1
    52e5:	vfmadd132ps zmm13,zmm0,zmm1
    52eb:	vfmadd132ps zmm4,zmm0,zmm1
    52f1:	vfmadd132ps zmm19,zmm0,zmm1
    52f7:	vfmadd132ps zmm18,zmm0,zmm1
    52fd:	vfmadd132ps zmm17,zmm0,zmm1
    5303:	vfmadd132ps zmm16,zmm0,zmm1
    5309:	vfmadd132ps zmm15,zmm0,zmm1
    530f:	vfmadd132ps zmm14,zmm0,zmm1
    5315:	vfmadd132ps zmm13,zmm0,zmm1
    531b:	vfmadd132ps zmm4,zmm0,zmm1
    5321:	vfmadd132ps zmm19,zmm0,zmm1
    5327:	vfmadd132ps zmm18,zmm0,zmm1
    532d:	vfmadd132ps zmm17,zmm0,zmm1
    5333:	vfmadd132ps zmm16,zmm0,zmm1
    5339:	vfmadd132ps zmm15,zmm0,zmm1
    533f:	vfmadd132ps zmm14,zmm0,zmm1
    5345:	vfmadd132ps zmm13,zmm0,zmm1
    534b:	vfmadd132ps zmm4,zmm0,zmm1
    5351:	vfmadd132ps zmm19,zmm0,zmm1
    5357:	vfmadd132ps zmm18,zmm0,zmm1
    535d:	vfmadd132ps zmm17,zmm0,zmm1
    5363:	vfmadd132ps zmm16,zmm0,zmm1
    5369:	vfmadd132ps zmm15,zmm0,zmm1
    536f:	vfmadd132ps zmm14,zmm0,zmm1
    5375:	vfmadd132ps zmm13,zmm0,zmm1
    537b:	vfmadd132ps zmm4,zmm0,zmm1
    5381:	vfmadd132ps zmm19,zmm0,zmm1
    5387:	vfmadd132ps zmm18,zmm0,zmm1
    538d:	vfmadd132ps zmm17,zmm0,zmm1
    5393:	vfmadd132ps zmm16,zmm0,zmm1
    5399:	vfmadd132ps zmm15,zmm0,zmm1
    539f:	vfmadd132ps zmm14,zmm0,zmm1
    53a5:	vfmadd132ps zmm13,zmm0,zmm1
    53ab:	vfmadd132ps zmm4,zmm0,zmm1
    53b1:	vfmadd132ps zmm19,zmm0,zmm1
    53b7:	vfmadd132ps zmm18,zmm0,zmm1
    53bd:	vfmadd132ps zmm17,zmm0,zmm1
    53c3:	vfmadd132ps zmm16,zmm0,zmm1
    53c9:	vfmadd132ps zmm15,zmm0,zmm1
    53cf:	vfmadd132ps zmm14,zmm0,zmm1
    53d5:	vfmadd132ps zmm13,zmm0,zmm1
    53db:	vfmadd132ps zmm4,zmm0,zmm1
    53e1:	vfmadd132ps zmm19,zmm0,zmm1
    53e7:	vfmadd132ps zmm18,zmm0,zmm1
    53ed:	vfmadd132ps zmm17,zmm0,zmm1
    53f3:	vfmadd132ps zmm16,zmm0,zmm1
    53f9:	vfmadd132ps zmm15,zmm0,zmm1
    53ff:	vfmadd132ps zmm14,zmm0,zmm1
    5405:	vfmadd132ps zmm13,zmm0,zmm1
    540b:	vfmadd132ps zmm4,zmm0,zmm1
    5411:	vfmadd132ps zmm19,zmm0,zmm1
    5417:	vfmadd132ps zmm18,zmm0,zmm1
    541d:	vfmadd132ps zmm17,zmm0,zmm1
    5423:	vfmadd132ps zmm16,zmm0,zmm1
    5429:	vfmadd132ps zmm15,zmm0,zmm1
    542f:	vfmadd132ps zmm14,zmm0,zmm1
    5435:	vfmadd132ps zmm13,zmm0,zmm1
    543b:	vfmadd132ps zmm4,zmm0,zmm1
    5441:	vfmadd132ps zmm19,zmm0,zmm1
    5447:	vfmadd132ps zmm18,zmm0,zmm1
    544d:	vfmadd132ps zmm17,zmm0,zmm1
    5453:	vfmadd132ps zmm16,zmm0,zmm1
    5459:	vfmadd132ps zmm15,zmm0,zmm1
    545f:	vfmadd132ps zmm14,zmm0,zmm1
    5465:	vfmadd132ps zmm13,zmm0,zmm1
    546b:	vfmadd132ps zmm4,zmm0,zmm1
    5471:	vfmadd132ps zmm19,zmm0,zmm1
    5477:	vfmadd132ps zmm18,zmm0,zmm1
    547d:	vfmadd132ps zmm17,zmm0,zmm1
    5483:	vfmadd132ps zmm16,zmm0,zmm1
    5489:	vfmadd132ps zmm15,zmm0,zmm1
    548f:	vfmadd132ps zmm14,zmm0,zmm1
    5495:	vfmadd132ps zmm13,zmm0,zmm1
    549b:	vfmadd132ps zmm4,zmm0,zmm1
    54a1:	vfmadd132ps zmm19,zmm0,zmm1
    54a7:	vfmadd132ps zmm18,zmm0,zmm1
    54ad:	vfmadd132ps zmm17,zmm0,zmm1
    54b3:	vfmadd132ps zmm16,zmm0,zmm1
    54b9:	vfmadd132ps zmm15,zmm0,zmm1
    54bf:	vfmadd132ps zmm14,zmm0,zmm1
    54c5:	vfmadd132ps zmm13,zmm0,zmm1
    54cb:	vfmadd132ps zmm4,zmm0,zmm1
    54d1:	vfmadd132ps zmm19,zmm0,zmm1
    54d7:	vfmadd132ps zmm18,zmm0,zmm1
    54dd:	vfmadd132ps zmm17,zmm0,zmm1
    54e3:	vfmadd132ps zmm16,zmm0,zmm1
    54e9:	vfmadd132ps zmm15,zmm0,zmm1
    54ef:	vfmadd132ps zmm14,zmm0,zmm1
    54f5:	vfmadd132ps zmm13,zmm0,zmm1
    54fb:	vfmadd132ps zmm4,zmm0,zmm1
    5501:	vfmadd132ps zmm19,zmm0,zmm1
    5507:	vfmadd132ps zmm18,zmm0,zmm1
    550d:	vfmadd132ps zmm17,zmm0,zmm1
    5513:	vfmadd132ps zmm16,zmm0,zmm1
    5519:	vfmadd132ps zmm15,zmm0,zmm1
    551f:	vfmadd132ps zmm14,zmm0,zmm1
    5525:	vfmadd132ps zmm13,zmm0,zmm1
    552b:	vfmadd132ps zmm4,zmm0,zmm1
    5531:	vfmadd132ps zmm19,zmm0,zmm1
    5537:	vfmadd132ps zmm18,zmm0,zmm1
    553d:	vfmadd132ps zmm17,zmm0,zmm1
    5543:	vfmadd132ps zmm16,zmm0,zmm1
    5549:	vfmadd132ps zmm15,zmm0,zmm1
    554f:	vfmadd132ps zmm14,zmm0,zmm1
    5555:	vfmadd132ps zmm13,zmm0,zmm1
    555b:	vfmadd132ps zmm4,zmm0,zmm1
    5561:	vfmadd132ps zmm19,zmm0,zmm1
    5567:	vfmadd132ps zmm18,zmm0,zmm1
    556d:	vfmadd132ps zmm17,zmm0,zmm1
    5573:	vfmadd132ps zmm16,zmm0,zmm1
    5579:	vfmadd132ps zmm15,zmm0,zmm1
    557f:	vfmadd132ps zmm14,zmm0,zmm1
    5585:	vfmadd132ps zmm13,zmm0,zmm1
    558b:	vfmadd132ps zmm4,zmm0,zmm1
    5591:	vfmadd132ps zmm19,zmm0,zmm1
    5597:	vfmadd132ps zmm18,zmm0,zmm1
    559d:	vfmadd132ps zmm17,zmm0,zmm1
    55a3:	vfmadd132ps zmm16,zmm0,zmm1
    55a9:	vfmadd132ps zmm15,zmm0,zmm1
    55af:	vfmadd132ps zmm14,zmm0,zmm1
    55b5:	vfmadd132ps zmm13,zmm0,zmm1
    55bb:	vfmadd132ps zmm4,zmm0,zmm1
    55c1:	vfmadd132ps zmm19,zmm0,zmm1
    55c7:	vfmadd132ps zmm18,zmm0,zmm1
    55cd:	vfmadd132ps zmm17,zmm0,zmm1
    55d3:	vfmadd132ps zmm16,zmm0,zmm1
    55d9:	vfmadd132ps zmm15,zmm0,zmm1
    55df:	vfmadd132ps zmm14,zmm0,zmm1
    55e5:	vfmadd132ps zmm13,zmm0,zmm1
    55eb:	vfmadd132ps zmm4,zmm0,zmm1
    55f1:	vfmadd132ps zmm19,zmm0,zmm1
    55f7:	vfmadd132ps zmm18,zmm0,zmm1
    55fd:	vfmadd132ps zmm17,zmm0,zmm1
    5603:	vfmadd132ps zmm16,zmm0,zmm1
    5609:	vfmadd132ps zmm15,zmm0,zmm1
    560f:	vfmadd132ps zmm14,zmm0,zmm1
    5615:	vfmadd132ps zmm13,zmm0,zmm1
    561b:	vfmadd132ps zmm4,zmm0,zmm1
    5621:	vfmadd132ps zmm19,zmm0,zmm1
    5627:	vfmadd132ps zmm18,zmm0,zmm1
    562d:	vfmadd132ps zmm17,zmm0,zmm1
    5633:	vfmadd132ps zmm16,zmm0,zmm1
    5639:	vfmadd132ps zmm15,zmm0,zmm1
    563f:	vfmadd132ps zmm14,zmm0,zmm1
    5645:	vfmadd132ps zmm13,zmm0,zmm1
    564b:	vfmadd132ps zmm4,zmm0,zmm1
    5651:	vfmadd132ps zmm19,zmm0,zmm1
    5657:	vfmadd132ps zmm18,zmm0,zmm1
    565d:	vfmadd132ps zmm17,zmm0,zmm1
    5663:	vfmadd132ps zmm16,zmm0,zmm1
    5669:	vfmadd132ps zmm15,zmm0,zmm1
    566f:	vfmadd132ps zmm14,zmm0,zmm1
    5675:	vfmadd132ps zmm13,zmm0,zmm1
    567b:	vfmadd132ps zmm4,zmm0,zmm1
    5681:	vfmadd132ps zmm19,zmm0,zmm1
    5687:	vfmadd132ps zmm18,zmm0,zmm1
    568d:	vfmadd132ps zmm17,zmm0,zmm1
    5693:	vfmadd132ps zmm16,zmm0,zmm1
    5699:	vfmadd132ps zmm15,zmm0,zmm1
    569f:	vfmadd132ps zmm14,zmm0,zmm1
    56a5:	vfmadd132ps zmm13,zmm0,zmm1
    56ab:	vfmadd132ps zmm4,zmm0,zmm1
    56b1:	vfmadd132ps zmm19,zmm0,zmm1
    56b7:	vfmadd132ps zmm18,zmm0,zmm1
    56bd:	vfmadd132ps zmm17,zmm0,zmm1
    56c3:	vfmadd132ps zmm16,zmm0,zmm1
    56c9:	vfmadd132ps zmm15,zmm0,zmm1
    56cf:	vfmadd132ps zmm14,zmm0,zmm1
    56d5:	vfmadd132ps zmm13,zmm0,zmm1
    56db:	vfmadd132ps zmm4,zmm0,zmm1
    56e1:	vfmadd132ps zmm19,zmm0,zmm1
    56e7:	vfmadd132ps zmm18,zmm0,zmm1
    56ed:	vfmadd132ps zmm17,zmm0,zmm1
    56f3:	vfmadd132ps zmm16,zmm0,zmm1
    56f9:	vfmadd132ps zmm15,zmm0,zmm1
    56ff:	vfmadd132ps zmm14,zmm0,zmm1
    5705:	vfmadd132ps zmm13,zmm0,zmm1
    570b:	vfmadd132ps zmm4,zmm0,zmm1
    5711:	vfmadd132ps zmm19,zmm0,zmm1
    5717:	vfmadd132ps zmm18,zmm0,zmm1
    571d:	vfmadd132ps zmm17,zmm0,zmm1
    5723:	vfmadd132ps zmm16,zmm0,zmm1
    5729:	vfmadd132ps zmm15,zmm0,zmm1
    572f:	vfmadd132ps zmm14,zmm0,zmm1
    5735:	vfmadd132ps zmm13,zmm0,zmm1
    573b:	vfmadd132ps zmm4,zmm0,zmm1
    5741:	vfmadd132ps zmm19,zmm0,zmm1
    5747:	vfmadd132ps zmm18,zmm0,zmm1
    574d:	vfmadd132ps zmm17,zmm0,zmm1
    5753:	vfmadd132ps zmm16,zmm0,zmm1
    5759:	vfmadd132ps zmm15,zmm0,zmm1
    575f:	vfmadd132ps zmm14,zmm0,zmm1
    5765:	vfmadd132ps zmm13,zmm0,zmm1
    576b:	vfmadd132ps zmm4,zmm0,zmm1
    5771:	vfmadd132ps zmm19,zmm0,zmm1
    5777:	vfmadd132ps zmm18,zmm0,zmm1
    577d:	vfmadd132ps zmm17,zmm0,zmm1
    5783:	vfmadd132ps zmm16,zmm0,zmm1
    5789:	vfmadd132ps zmm15,zmm0,zmm1
    578f:	vfmadd132ps zmm14,zmm0,zmm1
    5795:	vfmadd132ps zmm13,zmm0,zmm1
    579b:	vfmadd132ps zmm4,zmm0,zmm1
    57a1:	vfmadd132ps zmm19,zmm0,zmm1
    57a7:	vfmadd132ps zmm18,zmm0,zmm1
    57ad:	vfmadd132ps zmm17,zmm0,zmm1
    57b3:	vfmadd132ps zmm16,zmm0,zmm1
    57b9:	vfmadd132ps zmm15,zmm0,zmm1
    57bf:	vfmadd132ps zmm14,zmm0,zmm1
    57c5:	vfmadd132ps zmm13,zmm0,zmm1
    57cb:	vfmadd132ps zmm4,zmm0,zmm1
    57d1:	vfmadd132ps zmm19,zmm0,zmm1
    57d7:	vfmadd132ps zmm18,zmm0,zmm1
    57dd:	vfmadd132ps zmm17,zmm0,zmm1
    57e3:	vfmadd132ps zmm16,zmm0,zmm1
    57e9:	vfmadd132ps zmm15,zmm0,zmm1
    57ef:	vfmadd132ps zmm14,zmm0,zmm1
    57f5:	vfmadd132ps zmm13,zmm0,zmm1
    57fb:	vfmadd132ps zmm4,zmm0,zmm1
    5801:	vfmadd132ps zmm19,zmm0,zmm1
    5807:	vfmadd132ps zmm18,zmm0,zmm1
    580d:	vfmadd132ps zmm17,zmm0,zmm1
    5813:	vfmadd132ps zmm16,zmm0,zmm1
    5819:	vfmadd132ps zmm15,zmm0,zmm1
    581f:	vfmadd132ps zmm14,zmm0,zmm1
    5825:	vfmadd132ps zmm13,zmm0,zmm1
    582b:	vfmadd132ps zmm4,zmm0,zmm1
    5831:	vfmadd132ps zmm19,zmm0,zmm1
    5837:	vfmadd132ps zmm18,zmm0,zmm1
    583d:	vfmadd132ps zmm17,zmm0,zmm1
    5843:	vfmadd132ps zmm16,zmm0,zmm1
    5849:	vfmadd132ps zmm15,zmm0,zmm1
    584f:	vfmadd132ps zmm14,zmm0,zmm1
    5855:	vfmadd132ps zmm13,zmm0,zmm1
    585b:	vfmadd132ps zmm4,zmm0,zmm1
    5861:	vfmadd132ps zmm19,zmm0,zmm1
    5867:	vfmadd132ps zmm18,zmm0,zmm1
    586d:	vfmadd132ps zmm17,zmm0,zmm1
    5873:	vfmadd132ps zmm16,zmm0,zmm1
    5879:	vfmadd132ps zmm15,zmm0,zmm1
    587f:	vfmadd132ps zmm14,zmm0,zmm1
    5885:	vfmadd132ps zmm13,zmm0,zmm1
    588b:	vfmadd132ps zmm4,zmm0,zmm1
    5891:	vfmadd132ps zmm19,zmm0,zmm1
    5897:	vfmadd132ps zmm18,zmm0,zmm1
    589d:	vfmadd132ps zmm17,zmm0,zmm1
    58a3:	vfmadd132ps zmm16,zmm0,zmm1
    58a9:	vfmadd132ps zmm15,zmm0,zmm1
    58af:	vfmadd132ps zmm14,zmm0,zmm1
    58b5:	vfmadd132ps zmm13,zmm0,zmm1
    58bb:	vfmadd132ps zmm4,zmm0,zmm1
    58c1:	vaddps zmm12,zmm12,zmm19
    58c7:	vaddps zmm11,zmm11,zmm18
    58cd:	vaddps zmm10,zmm10,zmm17
    58d3:	vaddps zmm9,zmm9,zmm16
    58d9:	vaddps zmm8,zmm8,zmm15
    58df:	vaddps zmm7,zmm7,zmm14
    58e5:	vaddps zmm6,zmm6,zmm13
    58eb:	vaddps zmm5,zmm5,zmm4
    58f1:	cmp    r8,rsi
    58f4:	jb     4c73 <float kernel<64>(float const*, unsigned long, int)+0xe3>
    58fa:	vmovaps ZMMWORD PTR [rsp],zmm12
    5901:	vmovaps ZMMWORD PTR [rsp+0x40],zmm11
    5909:	vmovaps ZMMWORD PTR [rsp+0x80],zmm10
    5911:	vmovaps ZMMWORD PTR [rsp+0xc0],zmm9
    5919:	vmovaps ZMMWORD PTR [rsp+0x100],zmm8
    5921:	vmovaps ZMMWORD PTR [rsp+0x140],zmm7
    5929:	vmovaps ZMMWORD PTR [rsp+0x180],zmm6
    5931:	vmovaps ZMMWORD PTR [rsp+0x1c0],zmm5
    5939:	inc    edx
    593b:	cmp    ecx,edx
    593d:	jne    4c2e <float kernel<64>(float const*, unsigned long, int)+0x9e>
    5943:	vmovaps zmm0,ZMMWORD PTR [rsp]
    594a:	lea    rdx,[rsp+0x200]
    5952:	lea    rax,[rsp+0x80]
    595a:	vaddps zmm0,zmm0,ZMMWORD PTR [rsp+0x40]
    5962:	vaddps zmm0,zmm0,ZMMWORD PTR [rax]
    5968:	sub    rax,0xffffffffffffff80
    596c:	vaddps zmm0,zmm0,ZMMWORD PTR [rax-0x40]
    5973:	cmp    rdx,rax
    5976:	jne    5962 <float kernel<64>(float const*, unsigned long, int)+0xdd2>
    5978:	vextractf64x4 ymm1,zmm0,0x1
    597f:	vaddps ymm0,ymm1,ymm0
    5983:	vextractf128 xmm1,ymm0,0x1
    5989:	vaddps xmm0,xmm1,xmm0
    598d:	vpermilps xmm1,xmm0,0x4e
    5993:	vaddps xmm1,xmm1,xmm0
    5997:	vmovaps xmm0,xmm1
    599b:	vshufps xmm1,xmm1,xmm1,0x55
    59a0:	vaddss xmm0,xmm0,xmm1
    59a4:	mov    rax,QWORD PTR [rsp+0x238]
    59ac:	sub    rax,QWORD PTR fs:0x28
    59b5:	jne    59cd <float kernel<64>(float const*, unsigned long, int)+0xe3d>
    59b7:	vzeroupper
    59ba:	leave
    59bb:	ret
    59bc:	inc    edx
    59be:	cmp    ecx,edx
    59c0:	je     5943 <float kernel<64>(float const*, unsigned long, int)+0xdb3>
    59c2:	inc    edx
    59c4:	cmp    ecx,edx
    59c6:	jne    59bc <float kernel<64>(float const*, unsigned long, int)+0xe2c>
    59c8:	jmp    5943 <float kernel<64>(float const*, unsigned long, int)+0xdb3>
    59cd:	vzeroupper
    59d0:	call   22d0 <__stack_chk_fail@plt>
    59d5:	data16 cs nop WORD PTR [rax+rax*1+0x0]

00000000000059e0 <parse_list(char const*, std::vector<long, std::allocator<long> >)>:
    59e0:	push   r15
    59e2:	push   r14
    59e4:	push   r13
    59e6:	mov    r13,rdi
    59e9:	push   r12
    59eb:	push   rbp
    59ec:	push   rbx
    59ed:	sub    rsp,0x1f8
    59f4:	mov    rax,QWORD PTR fs:0x28
    59fd:	mov    QWORD PTR [rsp+0x1e8],rax
    5a05:	xor    eax,eax
    5a07:	test   rsi,rsi
    5a0a:	je     5b89 <parse_list(char const*, std::vector<long, std::allocator<long> >)+0x1a9>
    5a10:	vpxor  xmm0,xmm0,xmm0
    5a14:	xor    ecx,ecx
    5a16:	lea    r14,[rsp+0x50]
    5a1b:	mov    rdi,rsi
    5a1e:	mov    QWORD PTR [rsp+0x30],rcx
    5a23:	mov    rbx,rsi
    5a26:	lea    rbp,[rsp+0x40]
    5a2b:	mov    QWORD PTR [rsp+0x40],r14
    5a30:	vmovdqa XMMWORD PTR [rsp+0x20],xmm0
    5a36:	call   2240 <strlen@plt>
    5a3b:	mov    QWORD PTR [rsp+0x18],rax
    5a40:	mov    r12,rax
    5a43:	cmp    rax,0xf
    5a47:	ja     5ba9 <parse_list(char const*, std::vector<long, std::allocator<long> >)+0x1c9>
    5a4d:	cmp    rax,0x1
    5a51:	jne    5bda <parse_list(char const*, std::vector<long, std::allocator<long> >)+0x1fa>
    5a57:	movzx  eax,BYTE PTR [rbx]
    5a5a:	mov    BYTE PTR [rsp+0x50],al
    5a5e:	mov    rax,QWORD PTR [rsp+0x18]
    5a63:	mov    rdx,QWORD PTR [rsp+0x40]
    5a68:	lea    r12,[rsp+0x60]
    5a6d:	mov    rsi,rbp
    5a70:	mov    rdi,r12
    5a73:	mov    QWORD PTR [rsp+0x48],rax
    5a78:	mov    BYTE PTR [rdx+rax*1],0x0
    5a7c:	mov    edx,0x18
    5a81:	call   2390 <std::__cxx11::basic_stringstream<char, std::char_traits<char>, std::allocator<char> >::basic_stringstream(std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > const&, std::_Ios_Openmode)@plt>
    5a86:	mov    rdi,rbp
    5a89:	call   2340 <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >::_M_dispose()@plt>
    5a8e:	xor    edx,edx
    5a90:	lea    rax,[rsp+0x18]
    5a95:	mov    BYTE PTR [rsp+0x50],0x0
    5a9a:	mov    QWORD PTR [rsp+0x48],rdx
    5a9f:	mov    QWORD PTR [rsp+0x8],rax
    5aa4:	mov    QWORD PTR [rsp+0x40],r14
    5aa9:	lea    r14,[rsp+0x20]
    5aae:	mov    edx,0x2c
    5ab3:	mov    rsi,rbp
    5ab6:	mov    rdi,r12
    5ab9:	call   23e0 <std::basic_istream<char, std::char_traits<char> >& std::getline<char, std::char_traits<char>, std::allocator<char> >(std::basic_istream<char, std::char_traits<char> >&, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&, char)@plt>
    5abe:	mov    rdx,QWORD PTR [rax]
    5ac1:	mov    rbx,QWORD PTR [rsp+0x28]
    5ac6:	mov    r15,QWORD PTR [rsp+0x30]
    5acb:	mov    rdx,QWORD PTR [rdx-0x18]
    5acf:	test   BYTE PTR [rax+rdx*1+0x20],0x5
    5ad4:	jne    5b22 <parse_list(char const*, std::vector<long, std::allocator<long> >)+0x142>
    5ad6:	mov    rdi,QWORD PTR [rsp+0x40]
    5adb:	mov    edx,0xa
    5ae0:	xor    esi,esi
    5ae2:	call   23f0 <__isoc23_strtol@plt>
    5ae7:	mov    QWORD PTR [rsp+0x18],rax
    5aec:	cmp    rbx,r15
    5aef:	je     5b10 <parse_list(char const*, std::vector<long, std::allocator<long> >)+0x130>
    5af1:	mov    QWORD PTR [rbx],rax
    5af4:	mov    edx,0x2c
    5af9:	add    rbx,0x8
    5afd:	mov    rsi,rbp
    5b00:	mov    rdi,r12
    5b03:	mov    QWORD PTR [rsp+0x28],rbx
    5b08:	call   23e0 <std::basic_istream<char, std::char_traits<char> >& std::getline<char, std::char_traits<char>, std::allocator<char> >(std::basic_istream<char, std::char_traits<char> >&, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&, char)@plt>
    5b0d:	jmp    5abe <parse_list(char const*, std::vector<long, std::allocator<long> >)+0xde>
    5b0f:	nop
    5b10:	mov    rdx,QWORD PTR [rsp+0x8]
    5b15:	mov    rsi,rbx
    5b18:	mov    rdi,r14
    5b1b:	call   5ec0 <void std::vector<long, std::allocator<long> >::_M_realloc_insert<long>(__gnu_cxx::__normal_iterator<long*, std::vector<long, std::allocator<long> > >, long&&)>
    5b20:	jmp    5aae <parse_list(char const*, std::vector<long, std::allocator<long> >)+0xce>
    5b22:	vmovq  xmm0,QWORD PTR [rsp+0x20]
    5b28:	mov    QWORD PTR [r13+0x10],r15
    5b2c:	xor    eax,eax
    5b2e:	mov    rdi,rbp
    5b31:	mov    QWORD PTR [rsp+0x30],rax
    5b36:	vpinsrq xmm0,xmm0,rbx,0x1
    5b3c:	vmovdqu XMMWORD PTR [r13+0x0],xmm0
    5b42:	vpxor  xmm0,xmm0,xmm0
    5b46:	vmovdqa XMMWORD PTR [rsp+0x20],xmm0
    5b4c:	call   2340 <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >::_M_dispose()@plt>
    5b51:	mov    rdi,r12
    5b54:	call   2270 <std::__cxx11::basic_stringstream<char, std::char_traits<char>, std::allocator<char> >::~basic_stringstream()@plt>
    5b59:	mov    rdi,r14
    5b5c:	call   5da0 <std::vector<long, std::allocator<long> >::~vector()>
    5b61:	mov    rax,QWORD PTR [rsp+0x1e8]
    5b69:	sub    rax,QWORD PTR fs:0x28
    5b72:	jne    5be8 <parse_list(char const*, std::vector<long, std::allocator<long> >)+0x208>
    5b74:	add    rsp,0x1f8
    5b7b:	mov    rax,r13
    5b7e:	pop    rbx
    5b7f:	pop    rbp
    5b80:	pop    r12
    5b82:	pop    r13
    5b84:	pop    r14
    5b86:	pop    r15
    5b88:	ret
    5b89:	vmovdqu xmm1,XMMWORD PTR [rdx]
    5b8d:	mov    rax,QWORD PTR [rdx+0x10]
    5b91:	xor    esi,esi
    5b93:	vpxor  xmm0,xmm0,xmm0
    5b97:	mov    QWORD PTR [rdx+0x10],rsi
    5b9b:	mov    QWORD PTR [rdi+0x10],rax
    5b9f:	vmovdqu XMMWORD PTR [rdi],xmm1
    5ba3:	vmovdqu XMMWORD PTR [rdx],xmm0
    5ba7:	jmp    5b61 <parse_list(char const*, std::vector<long, std::allocator<long> >)+0x181>
    5ba9:	lea    rsi,[rsp+0x18]
    5bae:	xor    edx,edx
    5bb0:	mov    rdi,rbp
    5bb3:	call   23d0 <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >::_M_create(unsigned long&, unsigned long)@plt>
    5bb8:	mov    QWORD PTR [rsp+0x40],rax
    5bbd:	mov    rdi,rax
    5bc0:	mov    rax,QWORD PTR [rsp+0x18]
    5bc5:	mov    QWORD PTR [rsp+0x50],rax
    5bca:	mov    rdx,r12
    5bcd:	mov    rsi,rbx
    5bd0:	call   2280 <memcpy@plt>
    5bd5:	jmp    5a5e <parse_list(char const*, std::vector<long, std::allocator<long> >)+0x7e>
    5bda:	test   rax,rax
    5bdd:	je     5a5e <parse_list(char const*, std::vector<long, std::allocator<long> >)+0x7e>
    5be3:	mov    rdi,r14
    5be6:	jmp    5bca <parse_list(char const*, std::vector<long, std::allocator<long> >)+0x1ea>
    5be8:	call   22d0 <__stack_chk_fail@plt>
    5bed:	endbr64
    5bf1:	mov    rbx,rax
    5bf4:	lea    r14,[rsp+0x20]
    5bf9:	vzeroupper
    5bfc:	jmp    2410 <parse_list(char const*, std::vector<long, std::allocator<long> >) [clone .cold]+0x10>
    5c01:	endbr64
    5c05:	mov    rbx,rax
    5c08:	jmp    2400 <parse_list(char const*, std::vector<long, std::allocator<long> >) [clone .cold]>
    5c0d:	endbr64
    5c11:	mov    rbx,rax
    5c14:	jmp    2433 <parse_list(char const*, std::vector<long, std::allocator<long> >) [clone .cold]+0x33>
    5c19:	nop    DWORD PTR [rax+0x0]

0000000000005c20 <Counters::Counters()>:
    5c20:	endbr64
    5c24:	push   rbp
    5c25:	mov    rbp,rsp
    5c28:	push   r14
    5c2a:	push   r13
    5c2c:	mov    r13,rdi
    5c2f:	push   r12
    5c31:	push   rbx
    5c32:	xor    ebx,ebx
    5c34:	sub    rsp,0xb0
    5c3b:	mov    rax,QWORD PTR fs:0x28
    5c44:	mov    QWORD PTR [rsp+0xa8],rax
    5c4c:	xor    eax,eax
    5c4e:	vmovdqa xmm0,XMMWORD PTR [rip+0x151a]        # 7170 <_IO_stdin_used+0x170>
    5c56:	mov    QWORD PTR [rdi],0xffffffffffffffff
    5c5d:	mov    r12,rsp
    5c60:	mov    DWORD PTR [rdi+0x8],0xffffffff
    5c67:	lea    r14,[rsp+0x90]
    5c6f:	mov    BYTE PTR [rdi+0xc],0x0
    5c73:	mov    QWORD PTR [rsp+0xa0],0x1
    5c7f:	vmovdqa XMMWORD PTR [rsp+0x90],xmm0
    5c88:	vpxor  xmm0,xmm0,xmm0
    5c8c:	mov    rax,QWORD PTR [r14+rbx*8]
    5c90:	test   ebx,ebx
    5c92:	vmovdqu8 ZMMWORD PTR [r12],zmm0
    5c99:	mov    QWORD PTR [r12+0x80],0x0
    5ca5:	mov    QWORD PTR [rsp+0x8],rax
    5caa:	sete   al
    5cad:	xor    r9d,r9d
    5cb0:	or     eax,0x40
    5cb3:	mov    DWORD PTR [rsp+0x4],0x88
    5cbb:	mov    QWORD PTR [rsp+0x20],0x8
    5cc4:	mov    BYTE PTR [rsp+0x28],al
    5cc8:	vmovdqu8 ZMMWORD PTR [r12+0x40],zmm0
    5cd0:	test   rbx,rbx
    5cd3:	je     5d10 <Counters::Counters()+0xf0>
    5cd5:	mov    r8d,DWORD PTR [r13+0x0]
    5cd9:	xor    edx,edx
    5cdb:	xor    eax,eax
    5cdd:	mov    ecx,0xffffffff
    5ce2:	mov    rsi,r12
    5ce5:	mov    edi,0x12a
    5cea:	vzeroupper
    5ced:	call   2230 <syscall@plt>
    5cf2:	vpxor  xmm0,xmm0,xmm0
    5cf6:	test   eax,eax
    5cf8:	mov    DWORD PTR [r13+rbx*4+0x0],eax
    5cfd:	js     5d70 <Counters::Counters()+0x150>
    5cff:	cmp    rbx,0x2
    5d03:	je     5d48 <Counters::Counters()+0x128>
    5d05:	mov    ebx,0x2
    5d0a:	jmp    5c8c <Counters::Counters()+0x6c>
    5d0c:	nop    DWORD PTR [rax+0x0]
    5d10:	xor    edx,edx
    5d12:	xor    eax,eax
    5d14:	mov    r8d,0xffffffff
    5d1a:	mov    ecx,0xffffffff
    5d1f:	mov    rsi,r12
    5d22:	mov    edi,0x12a
    5d27:	vzeroupper
    5d2a:	call   2230 <syscall@plt>
    5d2f:	vpxor  xmm0,xmm0,xmm0
    5d33:	test   eax,eax
    5d35:	mov    DWORD PTR [r13+0x0],eax
    5d39:	js     5d70 <Counters::Counters()+0x150>
    5d3b:	mov    ebx,0x1
    5d40:	jmp    5c8c <Counters::Counters()+0x6c>
    5d45:	nop    DWORD PTR [rax]
    5d48:	mov    BYTE PTR [r13+0xc],0x1
    5d4d:	mov    rax,QWORD PTR [rsp+0xa8]
    5d55:	sub    rax,QWORD PTR fs:0x28
    5d5e:	jne    5d8c <Counters::Counters()+0x16c>
    5d60:	add    rsp,0xb0
    5d67:	pop    rbx
    5d68:	pop    r12
    5d6a:	pop    r13
    5d6c:	pop    r14
    5d6e:	pop    rbp
    5d6f:	ret
    5d70:	mov    rdi,QWORD PTR [rip+0x32c9]        # 9040 <stderr@GLIBC_2.2.5>
    5d77:	lea    rdx,[rip+0x1292]        # 7010 <_IO_stdin_used+0x10>
    5d7e:	mov    esi,0x2
    5d83:	xor    eax,eax
    5d85:	call   23b0 <__fprintf_chk@plt>
    5d8a:	jmp    5d4d <Counters::Counters()+0x12d>
    5d8c:	call   22d0 <__stack_chk_fail@plt>
    5d91:	cs nop WORD PTR [rax+rax*1+0x0]
    5d9b:	nop    DWORD PTR [rax+rax*1+0x0]

0000000000005da0 <std::vector<long, std::allocator<long> >::~vector()>:
    5da0:	endbr64
    5da4:	mov    rax,QWORD PTR [rdi]
    5da7:	test   rax,rax
    5daa:	je     5dc0 <std::vector<long, std::allocator<long> >::~vector()+0x20>
    5dac:	mov    rsi,QWORD PTR [rdi+0x10]
    5db0:	mov    rdi,rax
    5db3:	sub    rsi,rax
    5db6:	jmp    22c0 <operator delete(void*, unsigned long)@plt>
    5dbb:	nop    DWORD PTR [rax+rax*1+0x0]
    5dc0:	ret
    5dc1:	cs nop WORD PTR [rax+rax*1+0x0]
    5dcb:	nop    DWORD PTR [rax+rax*1+0x0]

0000000000005dd0 <std::vector<long, std::allocator<long> >::vector(std::initializer_list<long>, std::allocator<long> const&)>:
    5dd0:	endbr64
    5dd4:	push   r13
    5dd6:	vpxor  xmm0,xmm0,xmm0
    5dda:	movabs rax,0x7ffffffffffffff8
    5de4:	push   r12
    5de6:	push   rbp
    5de7:	lea    rbp,[rdx*8+0x0]
    5def:	push   rbx
    5df0:	mov    rbx,rdi
    5df3:	sub    rsp,0x8
    5df7:	mov    QWORD PTR [rdi+0x10],0x0
    5dff:	vmovdqu XMMWORD PTR [rdi],xmm0
    5e03:	cmp    rax,rbp
    5e06:	jb     5e81 <std::vector<long, std::allocator<long> >::vector(std::initializer_list<long>, std::allocator<long> const&)+0xb1>
    5e08:	test   rbp,rbp
    5e0b:	je     5e50 <std::vector<long, std::allocator<long> >::vector(std::initializer_list<long>, std::allocator<long> const&)+0x80>
    5e0d:	mov    rdi,rbp
    5e10:	mov    r12,rsi
    5e13:	call   22b0 <operator new(unsigned long)@plt>
    5e18:	lea    r13,[rax+rbp*1]
    5e1c:	mov    QWORD PTR [rbx],rax
    5e1f:	mov    rdi,rax
    5e22:	mov    QWORD PTR [rbx+0x10],r13
    5e26:	cmp    rbp,0x8
    5e2a:	je     5e78 <std::vector<long, std::allocator<long> >::vector(std::initializer_list<long>, std::allocator<long> const&)+0xa8>
    5e2c:	mov    rdx,rbp
    5e2f:	mov    rsi,r12
    5e32:	call   2280 <memcpy@plt>
    5e37:	mov    QWORD PTR [rbx+0x8],r13
    5e3b:	add    rsp,0x8
    5e3f:	pop    rbx
    5e40:	pop    rbp
    5e41:	pop    r12
    5e43:	pop    r13
    5e45:	ret
    5e46:	cs nop WORD PTR [rax+rax*1+0x0]
    5e50:	xor    r13d,r13d
    5e53:	mov    QWORD PTR [rdi],0x0
    5e5a:	mov    QWORD PTR [rdi+0x10],0x0
    5e62:	mov    QWORD PTR [rbx+0x8],r13
    5e66:	add    rsp,0x8
    5e6a:	pop    rbx
    5e6b:	pop    rbp
    5e6c:	pop    r12
    5e6e:	pop    r13
    5e70:	ret
    5e71:	nop    DWORD PTR [rax+0x0]
    5e78:	mov    rax,QWORD PTR [r12]
    5e7c:	mov    QWORD PTR [rdi],rax
    5e7f:	jmp    5e37 <std::vector<long, std::allocator<long> >::vector(std::initializer_list<long>, std::allocator<long> const&)+0x67>
    5e81:	lea    rdi,[rip+0x11c0]        # 7048 <_IO_stdin_used+0x48>
    5e88:	call   2250 <std::__throw_length_error(char const*)@plt>
    5e8d:	endbr64
    5e91:	mov    rbp,rax
    5e94:	mov    rdi,QWORD PTR [rbx]
    5e97:	mov    rsi,QWORD PTR [rbx+0x10]
    5e9b:	sub    rsi,rdi
    5e9e:	test   rdi,rdi
    5ea1:	je     5eb3 <std::vector<long, std::allocator<long> >::vector(std::initializer_list<long>, std::allocator<long> const&)+0xe3>
    5ea3:	vzeroupper
    5ea6:	call   22c0 <operator delete(void*, unsigned long)@plt>
    5eab:	mov    rdi,rbp
    5eae:	call   23c0 <_Unwind_Resume@plt>
    5eb3:	vzeroupper
    5eb6:	jmp    5eab <std::vector<long, std::allocator<long> >::vector(std::initializer_list<long>, std::allocator<long> const&)+0xdb>
    5eb8:	nop    DWORD PTR [rax+rax*1+0x0]

0000000000005ec0 <void std::vector<long, std::allocator<long> >::_M_realloc_insert<long>(__gnu_cxx::__normal_iterator<long*, std::vector<long, std::allocator<long> > >, long&&)>:
    5ec0:	endbr64
    5ec4:	push   r15
    5ec6:	movabs rcx,0xfffffffffffffff
    5ed0:	push   r14
    5ed2:	push   r13
    5ed4:	push   r12
    5ed6:	push   rbp
    5ed7:	push   rbx
    5ed8:	sub    rsp,0x28
    5edc:	mov    r12,QWORD PTR [rdi+0x8]
    5ee0:	mov    r13,QWORD PTR [rdi]
    5ee3:	mov    rax,r12
    5ee6:	sub    rax,r13
    5ee9:	sar    rax,0x3
    5eed:	cmp    rax,rcx
    5ef0:	je     6032 <void std::vector<long, std::allocator<long> >::_M_realloc_insert<long>(__gnu_cxx::__normal_iterator<long*, std::vector<long, std::allocator<long> > >, long&&)+0x172>
    5ef6:	mov    r15,rsi
    5ef9:	mov    rbp,rdi
    5efc:	mov    r14,rsi
    5eff:	sub    r15,r13
    5f02:	cmp    r13,r12
    5f05:	je     5fd0 <void std::vector<long, std::allocator<long> >::_M_realloc_insert<long>(__gnu_cxx::__normal_iterator<long*, std::vector<long, std::allocator<long> > >, long&&)+0x110>
    5f0b:	lea    rcx,[rax+rax*1]
    5f0f:	cmp    rcx,rax
    5f12:	jb     5f80 <void std::vector<long, std::allocator<long> >::_M_realloc_insert<long>(__gnu_cxx::__normal_iterator<long*, std::vector<long, std::allocator<long> > >, long&&)+0xc0>
    5f14:	test   rcx,rcx
    5f17:	jne    6014 <void std::vector<long, std::allocator<long> >::_M_realloc_insert<long>(__gnu_cxx::__normal_iterator<long*, std::vector<long, std::allocator<long> > >, long&&)+0x154>
    5f1d:	xor    ebx,ebx
    5f1f:	xor    edi,edi
    5f21:	mov    rax,QWORD PTR [rdx]
    5f24:	lea    rcx,[rdi+r15*1+0x8]
    5f29:	sub    r12,r14
    5f2c:	vmovq  xmm1,rdi
    5f31:	mov    QWORD PTR [rdi+r15*1],rax
    5f35:	lea    rax,[rcx+r12*1]
    5f39:	vpinsrq xmm0,xmm1,rax,0x1
    5f3f:	vmovdqa XMMWORD PTR [rsp],xmm0
    5f44:	test   r15,r15
    5f47:	jg     5fa8 <void std::vector<long, std::allocator<long> >::_M_realloc_insert<long>(__gnu_cxx::__normal_iterator<long*, std::vector<long, std::allocator<long> > >, long&&)+0xe8>
    5f49:	test   r12,r12
    5f4c:	jle    5f5c <void std::vector<long, std::allocator<long> >::_M_realloc_insert<long>(__gnu_cxx::__normal_iterator<long*, std::vector<long, std::allocator<long> > >, long&&)+0x9c>
    5f4e:	mov    rdx,r12
    5f51:	mov    rsi,r14
    5f54:	mov    rdi,rcx
    5f57:	call   2280 <memcpy@plt>
    5f5c:	test   r13,r13
    5f5f:	jne    5fbd <void std::vector<long, std::allocator<long> >::_M_realloc_insert<long>(__gnu_cxx::__normal_iterator<long*, std::vector<long, std::allocator<long> > >, long&&)+0xfd>
    5f61:	mov    QWORD PTR [rbp+0x10],rbx
    5f65:	vmovdqa xmm2,XMMWORD PTR [rsp]
    5f6a:	vmovdqu XMMWORD PTR [rbp+0x0],xmm2
    5f6f:	add    rsp,0x28
    5f73:	pop    rbx
    5f74:	pop    rbp
    5f75:	pop    r12
    5f77:	pop    r13
    5f79:	pop    r14
    5f7b:	pop    r15
    5f7d:	ret
    5f7e:	xchg   ax,ax
    5f80:	movabs rbx,0x7ffffffffffffff8
    5f8a:	mov    rdi,rbx
    5f8d:	mov    QWORD PTR [rsp],rdx
    5f91:	call   22b0 <operator new(unsigned long)@plt>
    5f96:	mov    rdx,QWORD PTR [rsp]
    5f9a:	mov    rdi,rax
    5f9d:	add    rbx,rax
    5fa0:	jmp    5f21 <void std::vector<long, std::allocator<long> >::_M_realloc_insert<long>(__gnu_cxx::__normal_iterator<long*, std::vector<long, std::allocator<long> > >, long&&)+0x61>
    5fa5:	nop    DWORD PTR [rax]
    5fa8:	mov    rdx,r15
    5fab:	mov    rsi,r13
    5fae:	mov    QWORD PTR [rsp+0x18],rcx
    5fb3:	call   23a0 <memmove@plt>
    5fb8:	test   r12,r12
    5fbb:	jg     5ff0 <void std::vector<long, std::allocator<long> >::_M_realloc_insert<long>(__gnu_cxx::__normal_iterator<long*, std::vector<long, std::allocator<long> > >, long&&)+0x130>
    5fbd:	mov    rsi,QWORD PTR [rbp+0x10]
    5fc1:	mov    rdi,r13
    5fc4:	sub    rsi,r13
    5fc7:	call   22c0 <operator delete(void*, unsigned long)@plt>
    5fcc:	jmp    5f61 <void std::vector<long, std::allocator<long> >::_M_realloc_insert<long>(__gnu_cxx::__normal_iterator<long*, std::vector<long, std::allocator<long> > >, long&&)+0xa1>
    5fce:	xchg   ax,ax
    5fd0:	add    rax,0x1
    5fd4:	jb     5f80 <void std::vector<long, std::allocator<long> >::_M_realloc_insert<long>(__gnu_cxx::__normal_iterator<long*, std::vector<long, std::allocator<long> > >, long&&)+0xc0>
    5fd6:	movabs rcx,0xfffffffffffffff
    5fe0:	cmp    rax,rcx
    5fe3:	mov    rbx,rcx
    5fe6:	cmovbe rbx,rax
    5fea:	shl    rbx,0x3
    5fee:	jmp    5f8a <void std::vector<long, std::allocator<long> >::_M_realloc_insert<long>(__gnu_cxx::__normal_iterator<long*, std::vector<long, std::allocator<long> > >, long&&)+0xca>
    5ff0:	mov    rdi,QWORD PTR [rsp+0x18]
    5ff5:	mov    rsi,r14
    5ff8:	mov    rdx,r12
    5ffb:	call   2280 <memcpy@plt>
    6000:	mov    rsi,QWORD PTR [rbp+0x10]
    6004:	mov    rdi,r13
    6007:	sub    rsi,r13
    600a:	call   22c0 <operator delete(void*, unsigned long)@plt>
    600f:	jmp    5f61 <void std::vector<long, std::allocator<long> >::_M_realloc_insert<long>(__gnu_cxx::__normal_iterator<long*, std::vector<long, std::allocator<long> > >, long&&)+0xa1>
    6014:	movabs rax,0xfffffffffffffff
    601e:	cmp    rcx,rax
    6021:	cmova  rcx,rax
    6025:	lea    rbx,[rcx*8+0x0]
    602d:	jmp    5f8a <void std::vector<long, std::allocator<long> >::_M_realloc_insert<long>(__gnu_cxx::__normal_iterator<long*, std::vector<long, std::allocator<long> > >, long&&)+0xca>
    6032:	lea    rdi,[rip+0x10d6]        # 710f <_IO_stdin_used+0x10f>
    6039:	call   2250 <std::__throw_length_error(char const*)@plt>

Disassembly of section .fini:

0000000000006040 <_fini>:
    6040:	endbr64
    6044:	sub    rsp,0x8
    6048:	add    rsp,0x8
    604c:	ret
