#                                     .-.	art by: 	cp97
#  ((_,...,_))   __ ___   ___  _ __ __| | ___ 	coded by: 	x13nsa
#     |o o|     '_ ` _ \ / _ \| '__/ _` |/ __|	last update:	July 15 2024 (happy birthday!!)
#     \   /     | | | | | (_) | | | (_| | (__
#      ^-^      | |_| |_|\___/|_|  \__,_|\___|	Tabs: 8
.section	.rodata
	usage_m:	.string "[usage]: mordc [mode] \"msg\"\n"
	usage_l: 	.long   28
	.globl		usage_m
	.globl		usage_l

	helpchars:	.string	"abcdefghijklmnopqrstuvwxyz /\n"
	.globl		helpchars

	unknown_m:	.string "<?>"
	unknown_l:	.long	4
	.globl		unknown_m
	.globl		unknown_l
