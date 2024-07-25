#                                     .-.	art by: 	cp97
#  ((_,...,_))   __ ___   ___  _ __ __| | ___ 	coded by: 	x13nsa
#     |o o|     '_ ` _ \ / _ \| '__/ _` |/ __|	last update:	july 15 2024 (happy birthday!!)
#     \   /     | | | | | (_) | | | (_| | (__
#      ^-^      | |_| |_|\___/|_|  \__,_|\___|	tabs: 8
.section	.text

.globl	strlen_

strlen_:
	movq	$0, %rcx
	cmpq	$0, %rdi
	je	.strlen_end
.strlen_loop:
	movzbl	(%rdi), %eax
	cmpl	$0, %eax
	je	.strlen_end
	incq	%rdi
	incq	%rcx
	jmp	.strlen_loop
.strlen_end:
	movq	%rcx, %rax
	ret
