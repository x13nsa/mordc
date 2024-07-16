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
