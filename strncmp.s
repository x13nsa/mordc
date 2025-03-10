#                                     .-.	art by: 	cp97
#  ((_,...,_))   __ ___   ___  _ __ __| | ___ 	coded by: 	x13nsa
#     |o o|     '_ ` _ \ / _ \| '__/ _` |/ __|	last update:	july 15 2024 (happy birthday!!)
#     \   /     | | | | | (_) | | | (_| | (__
#      ^-^      | |_| |_|\___/|_|  \__,_|\___|	tabs: 8
.section	.text
.globl		strncmp_

# arguments:	str1 (rdi) ; str2 (rsi) ; n (rdx)
# return:	1 if they are equal the first n bytes (eax)
# regs:		rax, rdi, rsi, rdx, rcx
strncmp_:
	cmpq	$0, %rsi
	je	.strncmp_no
	cmpq	$0, %rdi
	je	.strncmp_no
	movq	$0, %rcx
.strncmp_loop:
	cmpq	%rcx, %rdx
	je	.strncmp_yes
	movzbl	(%rdi), %eax
	cmpb	%al, (%rsi)
	jne	.strncmp_no
	cmpb	$0, %al
	je	.strncmp_yes
	incq	%rdi
	incq	%rsi
	incq	%rcx
	jmp	.strncmp_loop
.strncmp_no:
	movl	$0, %eax
	jmp	.strncmp_end
.strncmp_yes:
	movl	$1, %eax
.strncmp_end:
	ret
