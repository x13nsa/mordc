.section	.text
.globl		_start


.macro	_PRINT, a, b, c
	movq	$1, %rax
	movq	\a, %rdi
	leaq	\b, %rsi
	movl	\c, %edx
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


	_EXIT	$0

.print_usage:
	_PRINT	$1, usage_m(%rip), usage_l(%rip)
	_EXIT	$1
