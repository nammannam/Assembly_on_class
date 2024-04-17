#Lab 4, Assignment 4

.text
	li $s0, 1
	li $s1, 2147483646
	li $t7, 0		#Overflow flag
	
	addu $s2, $s0, $s1	#SUM
	
	xor $t0, $s0, $s1
	bltz $t0, END		#If different sign -> END
	
	xor $t1, $s0, $s2	#If same sign -> Check overflow
	bgtz $t1, END
	
	#Overflow
	addi $t7, $t7, 1
	
END:
	
