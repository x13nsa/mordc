#                                     .-.	art by: 	cp97
#  ((_,...,_))   __ ___   ___  _ __ __| | ___ 	coded by: 	x13nsa
#     |o o|     '_ ` _ \ / _ \| '__/ _` |/ __|	last update:	july 15 2024 (happy birthday!!)
#     \   /     | | | | | (_) | | | (_| | (__
#      ^-^      | |_| |_|\___/|_|  \__,_|\___|	tabs: 8
.section	.bss
	.type	.ccode, @object
	.size	.ccode, 5
	.ccode:	.zero	5

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

#  ____________
# < but is it? >
#  ------------
#         \   ^__^
#          \  (oo)\_______
#             (__)\       )\/\
#                 ||----w |
#                 ||     ||
morse_code_:
	movl	$1, %eax
	cmpb	$'.', %dil
	je	.morse_code_end
	cmpb	$'-', %dil
	je	.morse_code_end
	cmpb	$'/', %dil
	je	.morse_code_end
	movl	$0, %eax
.morse_code_end:
	ret

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
	leaq	.ccode(%rip), %r14
	movq	$0, %r13
.decode_loop:
	movzbl	(%r15), %eax
	testl	%eax, %eax
	jz	.byebye
	movl	%eax, %edi
	call	morse_code_
	testl	%eax, %eax
	jz	.decode_print_non_morse
	cmpb	$'/', %dil
	je	.decode_print_space
	movb	%dil, (%r14)
	incq	%r14
	incq	%r13
	jmp	.decode_continue
.decode_print_non_morse:
	cmpb	$' ', %dil
	je	.decode_decode
	_PRINT	%r15, $1
	jmp	.decode_continue
.decode_decode:
	testq	%r13, %r13
	jz	.decode_continue
	cmpq	$4, %r13
	jg	.decode_unknown
	movq	$0, %rbx
.decode_decode_find:
	cmpq	$26, %rbx
	je	.decode_unknown
	leaq	codes(%rip), %rax
	movq	(%rax, %rbx, 8), %r12
	movq	%r12, %rdi
	call	strlen_
	movq	%rax, %rdx
	cmpq	%rdx, %r13
	jne	.decode_decode_inc
	movq	%r12, %rdi
	leaq	.ccode(%rip), %rsi
	call	strncmp_
	testl	%eax, %eax
	jnz	.decode_decode_found
.decode_decode_inc:
	incq	%rbx
	jmp	.decode_decode_find
.decode_decode_found:
	_HELPCH	%rbx
	leaq	.ccode(%rip), %r14
	movq	$0, %r13
	jmp	.decode_continue
.decode_unknown:
	_SHMSG	unknown_m(%rip), unknown_l(%rip)
	jmp	.decode_continue
.decode_print_space:
	_HELPCH	$26
.decode_continue:
	incq	%r15
	jmp	.decode_loop

.byebye:
	_HELPCH	$28
	_EXIT	$0
