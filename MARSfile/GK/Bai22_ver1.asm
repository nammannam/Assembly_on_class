.data
	input: .asciiz "adjourned" 
	Message_error_input: .asciiz "Error input\nWord only!" 
	Message_false: .asciiz "FALSE\nNot cyclone word!"
	Message_true: .asciiz "TRUE\nA cyclone word!"
	space: .asciiz " " 
	
.text

	la $s1, input		#save the begin address of string - $s1
	la $s0, input		#save the end address of string - $s0 
	li $t1, 0 		#count_characters cnt = 0 $t1
	
count_characters:
	lbu $t0, ($s0)
	beqz $t0, end_counting		#check for the end of a word
	nop
	
check_upper:
	blt $t0, 0x41, end_error 	#Check Upper A-Z
	nop
	bgt $t0, 0x5A, check_lower
	nop
	j skip_check_lower
	nop

check_lower:
	blt $t0, 0x61, end_error		#Check lower a-z
	nop
	bgt $t0, 0x7A, end_error
	nop

skip_check_lower:
	addi $t1, $t1, 1		#cnt++
	addi $s0, $s0, 1		#string[i++]
	
	j count_characters	
				
end_counting:
	
	addi $s2, $t1, -1		# $s2 = cnt - 1 
				# - check for number of comparisons
				
	addi $s0, $s0, -1	# = last character of the word
	
check_cyclone_word:
	lbu $t2, 0($s1)		# first half character
	lbu $t3, 0($s0)		# last half character
	
	slt $t4, $t3, $t2	# compare: $t4 = $t2 <= $t3 ? continue : end
	beq $t4, 1, end_not_cyclone_word
	nop
	
	addi $s2, $s2, -1		# number of comparisons - 1 after each comparison
	beq $s2, 0, end_check_cyclone_word # number of comparisons = 0 then stop check
	
	beq $ra, $0, skip	# Check $ra whether returns or not->skip
	nop
	jr $ra
	
	skip:

# Sau so sánh lần thứ 1, so sánh tiếp những lần tiếp theo

# Sau lần so sánh thứ lẻ, 
# địa chỉ s1 trỏ ở nửa TRÁI word cần check
# địa chỉ s0 trỏ ở nửa PHẢI word cần check

	addi $t5, $s0, 0		# temp = s0(Odd)	
	addi $s0, $s1, 1		# s0(Even) = s1(Odd) + 1
	addi $s1, $t5, 0		# s1(Even) = s0(Odd)
	
# phải giữ nguyên địa chỉ s0 của chữ cái STT nhỏ hơn
# để so sánh lần thứ 2 sau lần so sánh thứ 1
# nên cần jal so sánh luôn lần thứ chẵn (từ lần thứ 2 trở đi)
	
	jal check_cyclone_word
	nop
	add $ra, $0, $0		# Reset $ra after each Even - comparison
	
# Sau lần so sánh thứ CHẴN, 
# địa chỉ s1 trỏ ở nửa PHẢI word cần check
# địa chỉ s0 trỏ ở nửa TRÁI word cần check
	
	add $t5, $s0, 0		# temp = s0(Even)
	addi $s0, $s1, -1	# s0(Odd) = s1(Even) - 1
	addi $s1, $t5, 0		# s1(Odd) = s0(Even)
	
	
	j check_cyclone_word
	nop
	
end_check_cyclone_word:	
	li $v0, 55
	la $a0, Message_true
	li $a1, 1
	syscall 
	j end
	nop

		
end_not_cyclone_word:
	li $v0, 55
	la $a0, Message_false
	li $a1, 0
	syscall 
	j end
	nop
		
end_error:
	li $v0, 55
	la $a0, Message_error_input
	li $a1, 0
	syscall 
	j end
	nop
end:
	
	