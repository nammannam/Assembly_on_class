#Lab 4, Assignment 3

.text
	li $s1, -5
	li $s2, 10	
	
	#abs $s0, $s1
	sra $t0, $s1, 31 #abs $s0, $s1
	xor $s0, $t0, $s1
	subu $s0, $s0, $t0
	j skip
label:
	addi $t1, $0, 100
	j end
skip:
	#move $s0, $s1
	addu $s0, $0, $s1 #move $s0, $s1
	
	#not $s0, $s1
	nor $s0, $s1, $0 #not $s0, $s1
	
	#ble $s1, $s2, label
	slt $t2, $s2, $s1 #ble $s1, $s2, label
	beq $t2, $0, label
		j end
		
end:
	
	
	 
