#Lab Ex 3, Assigment 1
.data
	I: .word 2
	J: .word 1
.text
	#Load i and j 
	la $t8, I
	la $t9, J
	lw $s1, 0($t8)
	lw $s2, 0($t9)


	start:
	slt $t0, $s2, $s1
	bne $t0, $zero, else
	addi $t1, $t1, 1
	addi $t3, $zero, 1
	j endif  
	
	else:
	addi $t2, $t2, -1
	add $t3, $t3, $t3
	
	endif:  
