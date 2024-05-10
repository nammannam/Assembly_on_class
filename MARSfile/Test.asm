.data
	test: .word 0x0000897A
	temp: .word 0x12005678
	temp1: .asciiz "Nam"

.text 
	
	add $s0, $s0, 0x00008944
	la $s0, test
	lw $t0, ($s0)
	add $t0, $t0, -52
	lh $t0, ($s0)
	