//本文在linux平台,使用GCC形成的汇编代码.遵从AT&T汇编语法
//本文结构
//	第一部分:C语句->汇编  的对应代码
//	第二部分:一个完整的hellword汇编程序及
//		可执行文件见的反汇编结果.(包含使用的命令)

//使用汇编的目的:减少代码尺寸,优化代码性能
//应用场景: C语言内联汇编:
//		形式: ASM(语句:输出:输入); 
//经验:
//		没有分支循环,只有线性执行+跳转
//		子函数和都是代码快
//		所有的变量都是数字


//				时间;2019年春
//				作者:Jonson Sun
//				协议:GPL

//================不同c语句的对应汇编格式======================


#include<stdio.h> //由于该语句无效,所以使用as编译后的代码不能执行
#include<stdlib.h>

struct {
	int a;char b;double c;
} s1;
/*结构体  
	.comm	s1,16,16
*/

union Data
{
   int i;
   float f;
   char  str[20];
} data;
//联合体   .comm	 data,20,16


char* subfunction1(){
	return "result";
}
/*
.LC0:
	.string	"result"
	.text
	.globl	subfunction1
	.type	subfunction1, @function


subfunction1:
.LFB0:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	leaq	.LC0(%rip), %rax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc

*/
int subfunction2(int i,long j){
	int tmp=i+j;
	return tmp;
}
/*
subfunction2:
.LFB1:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	%edi, -20(%rbp)
	movq	%rsi, -32(%rbp)
	movq	-32(%rbp), %rax
	movl	%eax, %edx
	movl	-20(%rbp), %eax
	addl	%edx, %eax
	movl	%eax, -4(%rbp)
	movl	-4(%rbp), %eax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1:
	.size	subfunction2, .-subfunction2
	.globl	main
	.type	main, @function
*/
int subfunction3(int i,long j);  //函数声明

int main()
{	// 源文件中的相关注释自动省略
	int var=100;  //movl	$100, -4(%rbp)
	//var+=1;		//	addl	$1, -4(%rbp) 三种加法的汇编代码相同
	//var++;		//	addl	$1, -4(%rbp)
	//var=var+1;	//	addl	$1, -4(%rbp)
	//var--;		//	subl	$1, -4(%rbp) 减法的汇编语句
	//var*=2;		//	sall	-4(%rbp)  移位
	//var*=3;
		/*	
		movl	-4(%rbp), %edx  #将var的值存到edx中
		movl	%edx, %eax		#edx的值再放到eax中
		addl	%eax, %eax		#eax相加
		addl	%edx, %eax		#eax+edx->eax
		movl	%eax, -4(%rbp)	#将eax的值写进var
		*/
	//var*=var;
		/*	
		movl	-4(%rbp), %eax
		imull	-4(%rbp), %eax  #64位有符号乘法;无符号乘法:mull
		movl	%eax, -4(%rbp)
		*/
	//var/=2;
		/*	
		movl	-4(%rbp), %eax
		movl	%eax, %edx
		shrl	$31, %edx
		addl	%edx, %eax
		sarl	%eax
		movl	%eax, -4(%rbp)
		*/
	//var/=3;
		/*	
		movl	-4(%rbp), %ecx
		movl	$1431655766, %edx
		movl	%ecx, %eax
		imull	%edx
		movl	%ecx, %eax
		sarl	$31, %eax
		subl	%eax, %edx
		movl	%edx, %eax
		movl	%eax, -4(%rbp)
		*/
	//var%=3;
		/*
		movl	-4(%rbp), %ecx
		movl	$1431655766, %edx
		movl	%ecx, %eax
		imull	%edx
		movl	%ecx, %eax
		sarl	$31, %eax
		subl	%eax, %edx
		movl	%edx, %eax
		addl	%eax, %eax
		addl	%edx, %eax
		subl	%eax, %ecx
		movl	%ecx, %eax
		movl	%eax, -4(%rbp)
		*/
	//var=var&4;//	andl	$4, -4(%rbp)
	//var=var|5; //	orl	$5, -4(%rbp)
	//var=!var;
		/*
		cmpl	$0, -4(%rbp)
		sete	%al
		movzbl	%al, %eax
		movl	%eax, -4(%rbp)
		*/
	//var=(var == 4)?100:10 ;
		/*三元运算符比较
		cmpl	$4, -4(%rbp)
		jne	.L2  				#不等于跳转
		movl	$100, %eax
		jmp	.L3
	.L2:
		movl	$10, %eax
	.L3:
		movl	%eax, -4(%rbp)
		*/
	if(var==204){var=100;}else{var=200;}
		/* 条件语句就是比较跳转
			cmpl	$204, -4(%rbp)
			jne	.L2
			movl	$100, -4(%rbp)
			jmp	.L3
		.L2:
			movl	$200, -4(%rbp)
		.L3:
		
		*/
	var=200;
	while(var>10){var-=1;}
		/*	循环就是向前跳转
			movl	$200, -4(%rbp)  //赋值
			jmp	.L4					//跳转
		.L5:
			subl	$1, -4(%rbp)   //减法
		.L4:
			cmpl	$10, -4(%rbp)   //条件检测
			jg	.L5
		*/
	subfunction1(); //子函数调用方式相似  call	subfunction1
	var=subfunction2(var,3);
		/*
		movl	-4(%rbp), %eax
		movl	$3, %esi
		movl	%eax, %edi
		call	subfunction2
		movl	%eax, -4(%rbp)
		*/
	var=subfunction3(var,3);  /* 代码与subfunction2完全相同*/
//补充:		
	//int* ptr_1=&var;	
		/*指针  ???
			leaq	-20(%rbp), %rax
			movq	%rax, -16(%rbp)
			movl	-20(%rbp), %eax
			movq	-8(%rbp), %rdx
			xorq	%fs:40, %rdx
			je	.L11
			call	__stack_chk_fail@PLT
		.L11:
			leave
		*/
	//float num=3.1415001;	
		/*浮点数  3.14...????
			movss	.LC1(%rip), %xmm0
			movss	%xmm0, -4(%rbp)
		.LC1:
			.long	1078529622
		*/
	//double num_d=1234345.12341234;	/*双精度浮点数*/
		/* 疑惑同上
			movsd	.LC1(%rip), %xmm0
			movsd	%xmm0, -8(%rbp)
		.LC1:
			.long	530051964
			.long	1093850537
		*/
	//long array[10]={1,2,3,4,5,6,7,8,8,9}; 
		/*数组
			movq	$1, -96(%rbp)
			movq	$2, -88(%rbp)
			movq	$3, -80(%rbp)
			movq	$4, -72(%rbp)
			movq	$5, -64(%rbp)
			movq	$6, -56(%rbp)
			movq	$7, -48(%rbp)
			movq	$8, -40(%rbp)
			movq	$8, -32(%rbp)
			movq	$9, -24(%rbp)
		*/
	//void* asd=&var; //同上文int*?	
	//const int BigInt=10000;	 /*常量 movl	$10000, -4(%rbp)  */
	//enum DAY{MON=1, TUE, WED, THU, FRI, SAT, SUN} day;	day=MON;var=day;
		/*枚举
		movl	$1, -4(%rbp)
		movl	-4(%rbp), %eax
		movl	%eax, -8(%rbp)
		*/
	//s1.a=var;
		/*结构体调用
			movl	-4(%rbp), %eax
			movl	%eax, s1(%rip)
		*/
	//data.i=var;
		/*联合体调用
			movl	-4(%rbp), %eax
			movl	%eax, data(%rip)
		*/
	return var;
}


int subfunction3(int i,long j){
	int tmp=i-j;
	return tmp;
}
/*
	.globl	subfunction3
	.type	subfunction3, @function
subfunction3:
.LFB3:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	%edi, -20(%rbp)
	movq	%rsi, -32(%rbp)
	movl	-20(%rbp), %eax
	movq	-32(%rbp), %rdx
	subl	%edx, %eax
	movl	%eax, -4(%rbp)
	movl	-4(%rbp), %eax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
*/



//================两个完整的程序===============================




/*

hello world的完整汇编程序


命令:
	>>>gcc -S tmp.c
结果:
	.file	"tmp.c"  #文件名
	.text
	.section	.rodata  #数据段
.LC0:
	.string	"hello word."
	.text
	.globl	main
	.type	main, @function
main:
.LFB0:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp		#	main的两个参数处理0
	movl	%edi, -4(%rbp)	#	main的两个参数处理1
	movq	%rsi, -16(%rbp)	#	main的两个参数处理2
	leaq	.LC0(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$0, %eax  #  return 0; //返回值
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0"   #编译器版本
	.section	.note.GNU-stack,"",@progbits


*/




/*
objdump反编译可执行的hello的全部内容



命令:
	>>>gcc -s tmp.c
	>>>objdump -S a.out >> tmp.s
结果:


a.out：     文件格式 elf64-x86-64


Disassembly of section .init:

00000000000004f0 <.init>:
 4f0:	48 83 ec 08          	sub    $0x8,%rsp
 4f4:	48 8b 05 ed 0a 20 00 	mov    0x200aed(%rip),%rax        # 200fe8 <__cxa_finalize@plt+0x200ab8>
 4fb:	48 85 c0             	test   %rax,%rax
 4fe:	74 02                	je     502 <printf@plt-0x1e>
 500:	ff d0                	callq  *%rax
 502:	48 83 c4 08          	add    $0x8,%rsp
 506:	c3                   	retq   

Disassembly of section .plt:

0000000000000510 <printf@plt-0x10>:
 510:	ff 35 aa 0a 20 00    	pushq  0x200aaa(%rip)        # 200fc0 <__cxa_finalize@plt+0x200a90>
 516:	ff 25 ac 0a 20 00    	jmpq   *0x200aac(%rip)        # 200fc8 <__cxa_finalize@plt+0x200a98>
 51c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000000520 <printf@plt>:
 520:	ff 25 aa 0a 20 00    	jmpq   *0x200aaa(%rip)        # 200fd0 <__cxa_finalize@plt+0x200aa0>
 526:	68 00 00 00 00       	pushq  $0x0
 52b:	e9 e0 ff ff ff       	jmpq   510 <printf@plt-0x10>

Disassembly of section .plt.got:

0000000000000530 <__cxa_finalize@plt>:
 530:	ff 25 c2 0a 20 00    	jmpq   *0x200ac2(%rip)        # 200ff8 <__cxa_finalize@plt+0x200ac8>
 536:	66 90                	xchg   %ax,%ax

Disassembly of section .text:

0000000000000540 <.text>:
 540:	31 ed                	xor    %ebp,%ebp
 542:	49 89 d1             	mov    %rdx,%r9
 545:	5e                   	pop    %rsi
 546:	48 89 e2             	mov    %rsp,%rdx
 549:	48 83 e4 f0          	and    $0xfffffffffffffff0,%rsp
 54d:	50                   	push   %rax
 54e:	54                   	push   %rsp
 54f:	4c 8d 05 9a 01 00 00 	lea    0x19a(%rip),%r8        # 6f0 <__cxa_finalize@plt+0x1c0>
 556:	48 8d 0d 23 01 00 00 	lea    0x123(%rip),%rcx        # 680 <__cxa_finalize@plt+0x150>
 55d:	48 8d 3d e6 00 00 00 	lea    0xe6(%rip),%rdi        # 64a <__cxa_finalize@plt+0x11a>
 564:	ff 15 76 0a 20 00    	callq  *0x200a76(%rip)        # 200fe0 <__cxa_finalize@plt+0x200ab0>
 56a:	f4                   	hlt    
 56b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
 570:	48 8d 3d 99 0a 20 00 	lea    0x200a99(%rip),%rdi        # 201010 <__cxa_finalize@plt+0x200ae0>
 577:	55                   	push   %rbp
 578:	48 8d 05 91 0a 20 00 	lea    0x200a91(%rip),%rax        # 201010 <__cxa_finalize@plt+0x200ae0>
 57f:	48 39 f8             	cmp    %rdi,%rax
 582:	48 89 e5             	mov    %rsp,%rbp
 585:	74 19                	je     5a0 <__cxa_finalize@plt+0x70>
 587:	48 8b 05 4a 0a 20 00 	mov    0x200a4a(%rip),%rax        # 200fd8 <__cxa_finalize@plt+0x200aa8>
 58e:	48 85 c0             	test   %rax,%rax
 591:	74 0d                	je     5a0 <__cxa_finalize@plt+0x70>
 593:	5d                   	pop    %rbp
 594:	ff e0                	jmpq   *%rax
 596:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
 59d:	00 00 00 
 5a0:	5d                   	pop    %rbp
 5a1:	c3                   	retq   
 5a2:	0f 1f 40 00          	nopl   0x0(%rax)
 5a6:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
 5ad:	00 00 00 
 5b0:	48 8d 3d 59 0a 20 00 	lea    0x200a59(%rip),%rdi        # 201010 <__cxa_finalize@plt+0x200ae0>
 5b7:	48 8d 35 52 0a 20 00 	lea    0x200a52(%rip),%rsi        # 201010 <__cxa_finalize@plt+0x200ae0>
 5be:	55                   	push   %rbp
 5bf:	48 29 fe             	sub    %rdi,%rsi
 5c2:	48 89 e5             	mov    %rsp,%rbp
 5c5:	48 c1 fe 03          	sar    $0x3,%rsi
 5c9:	48 89 f0             	mov    %rsi,%rax
 5cc:	48 c1 e8 3f          	shr    $0x3f,%rax
 5d0:	48 01 c6             	add    %rax,%rsi
 5d3:	48 d1 fe             	sar    %rsi
 5d6:	74 18                	je     5f0 <__cxa_finalize@plt+0xc0>
 5d8:	48 8b 05 11 0a 20 00 	mov    0x200a11(%rip),%rax        # 200ff0 <__cxa_finalize@plt+0x200ac0>
 5df:	48 85 c0             	test   %rax,%rax
 5e2:	74 0c                	je     5f0 <__cxa_finalize@plt+0xc0>
 5e4:	5d                   	pop    %rbp
 5e5:	ff e0                	jmpq   *%rax
 5e7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
 5ee:	00 00 
 5f0:	5d                   	pop    %rbp
 5f1:	c3                   	retq   
 5f2:	0f 1f 40 00          	nopl   0x0(%rax)
 5f6:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
 5fd:	00 00 00 
 600:	80 3d 09 0a 20 00 00 	cmpb   $0x0,0x200a09(%rip)        # 201010 <__cxa_finalize@plt+0x200ae0>
 607:	75 2f                	jne    638 <__cxa_finalize@plt+0x108>
 609:	48 83 3d e7 09 20 00 	cmpq   $0x0,0x2009e7(%rip)        # 200ff8 <__cxa_finalize@plt+0x200ac8>
 610:	00 
 611:	55                   	push   %rbp
 612:	48 89 e5             	mov    %rsp,%rbp
 615:	74 0c                	je     623 <__cxa_finalize@plt+0xf3>
 617:	48 8b 3d ea 09 20 00 	mov    0x2009ea(%rip),%rdi        # 201008 <__cxa_finalize@plt+0x200ad8>
 61e:	e8 0d ff ff ff       	callq  530 <__cxa_finalize@plt>
 623:	e8 48 ff ff ff       	callq  570 <__cxa_finalize@plt+0x40>
 628:	c6 05 e1 09 20 00 01 	movb   $0x1,0x2009e1(%rip)        # 201010 <__cxa_finalize@plt+0x200ae0>
 62f:	5d                   	pop    %rbp
 630:	c3                   	retq   
 631:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
 638:	f3 c3                	repz retq 
 63a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
 640:	55                   	push   %rbp
 641:	48 89 e5             	mov    %rsp,%rbp
 644:	5d                   	pop    %rbp
 645:	e9 66 ff ff ff       	jmpq   5b0 <__cxa_finalize@plt+0x80>
 64a:	55                   	push   %rbp
 64b:	48 89 e5             	mov    %rsp,%rbp
 64e:	48 83 ec 10          	sub    $0x10,%rsp
 652:	89 7d fc             	mov    %edi,-0x4(%rbp)
 655:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
 659:	48 8d 3d a4 00 00 00 	lea    0xa4(%rip),%rdi        # 704 <__cxa_finalize@plt+0x1d4>
 660:	b8 00 00 00 00       	mov    $0x0,%eax
 665:	e8 b6 fe ff ff       	callq  520 <printf@plt>
 66a:	b8 00 00 00 00       	mov    $0x0,%eax
 66f:	c9                   	leaveq 
 670:	c3                   	retq   
 671:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
 678:	00 00 00 
 67b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
 680:	41 57                	push   %r15
 682:	41 56                	push   %r14
 684:	49 89 d7             	mov    %rdx,%r15
 687:	41 55                	push   %r13
 689:	41 54                	push   %r12
 68b:	4c 8d 25 26 07 20 00 	lea    0x200726(%rip),%r12        # 200db8 <__cxa_finalize@plt+0x200888>
 692:	55                   	push   %rbp
 693:	48 8d 2d 26 07 20 00 	lea    0x200726(%rip),%rbp        # 200dc0 <__cxa_finalize@plt+0x200890>
 69a:	53                   	push   %rbx
 69b:	41 89 fd             	mov    %edi,%r13d
 69e:	49 89 f6             	mov    %rsi,%r14
 6a1:	4c 29 e5             	sub    %r12,%rbp
 6a4:	48 83 ec 08          	sub    $0x8,%rsp
 6a8:	48 c1 fd 03          	sar    $0x3,%rbp
 6ac:	e8 3f fe ff ff       	callq  4f0 <printf@plt-0x30>
 6b1:	48 85 ed             	test   %rbp,%rbp
 6b4:	74 20                	je     6d6 <__cxa_finalize@plt+0x1a6>
 6b6:	31 db                	xor    %ebx,%ebx
 6b8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
 6bf:	00 
 6c0:	4c 89 fa             	mov    %r15,%rdx
 6c3:	4c 89 f6             	mov    %r14,%rsi
 6c6:	44 89 ef             	mov    %r13d,%edi
 6c9:	41 ff 14 dc          	callq  *(%r12,%rbx,8)
 6cd:	48 83 c3 01          	add    $0x1,%rbx
 6d1:	48 39 dd             	cmp    %rbx,%rbp
 6d4:	75 ea                	jne    6c0 <__cxa_finalize@plt+0x190>
 6d6:	48 83 c4 08          	add    $0x8,%rsp
 6da:	5b                   	pop    %rbx
 6db:	5d                   	pop    %rbp
 6dc:	41 5c                	pop    %r12
 6de:	41 5d                	pop    %r13
 6e0:	41 5e                	pop    %r14
 6e2:	41 5f                	pop    %r15
 6e4:	c3                   	retq   
 6e5:	90                   	nop
 6e6:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
 6ed:	00 00 00 
 6f0:	f3 c3                	repz retq 

Disassembly of section .fini:

00000000000006f4 <.fini>:
 6f4:	48 83 ec 08          	sub    $0x8,%rsp
 6f8:	48 83 c4 08          	add    $0x8,%rsp
 6fc:	c3                   	retq   

*/