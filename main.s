.section	.text
.globl		_start

.macro	_SHMSG, a, b
	movq	$1, %rax
	movq	$1, %rdi
	leaq	\a, %rsi
	movl	\b, %edx
	syscall
.endm

.macro	_PRINT, a, b
	movq	$1, %rax
	movq	$1, %rdi
	movq	\a, %rsi
	movl	\b, %edx
	syscall
.endm

.macro	_EXIT, a
	movq	$60, %rax
	movq	\a, %rdi
	syscall
.endm

_start:
	# Getting number of arguments.
	popq	%rax
	cmpq	$3, %rax
	jne	.print_usage
	# 1. executable name
	# 2. mode.
	# 3. message.
	popq	%rax
	popq	%rax
	popq	%r15
	movzbl	(%rax), %eax
	cmpl	$'e', %eax
	je	.encode_mode
	cmpl	$'d', %eax
	je	.decode_mode

.print_usage:
	_SHMSG	usage_m(%rip), usage_l(%rip)
	_EXIT	$1

.encode_mode:
	movzbl	(%r15), %eax
	testl	%eax, %eax	
	jz	.byebye

	_PRINT	%r15, $1

	incq	%r15
	jmp	.encode_mode

.decode_mode:
	_EXIT	$69

.byebye:
	_EXIT	$0
