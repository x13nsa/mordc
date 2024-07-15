.section	.text
.globl		_start

.macro	_SHMSG, a, b
	leaq	\a, %rsi
	movl	\b, %edx
	movq	$1, %rax
	movq	$1, %rdi
	syscall
.endm

.macro	_PRINT, a, b
	movq	\a, %rsi
	movq	\b, %rdx
	movq	$1, %rax
	movq	$1, %rdi
	syscall
.endm

.macro	_EXIT, a
	movl	\a, %edi
	movl	$60, %eax
	syscall
.endm

.macro	_HELPCH, a
	leaq	helpchars(%rip), %rsi
	addq	\a, %rsi
	movq	$1, %rax
	movq	$1, %rdi
	movq	$1, %rdx
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
	# r15 reg is gonna be used to save the
	# message throughout the whole program
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
	movl	%eax, %edi
	call	is_alpha_
	testl	%eax, %eax
	jnz	.encode_translate
	cmpb	$' ', %dil
	je	.encode_space
	# if the current character is neither
	# alphabetic nor space then print what it is.
	_PRINT	%r15, $1
	jmp	.encode_continue
.encode_translate:
	call	to_lower_
	subl	$'a', %eax
	cltq
	leaq	codes(%rip), %rbx
	movq	(%rbx, %rax, 8), %rbx
	movq	%rbx, %rdi
	call	strlen_
	_PRINT	%rbx, %rax
	jmp	.encode_continue
.encode_space:
	_HELPCH	$27
.encode_continue:
	_HELPCH	$26
	incq	%r15
	jmp	.encode_mode

.decode_mode:
.byebye:
	_HELPCH	$28
	_EXIT	$0
