.data 
	Message_error_input: .asciiz "Error input\nWords only!" 
	Message_false: .asciiz "FALSE "
	Message_true: .asciiz "TRUE "
	space: .asciiz " " 
	
	input_string: .space 100
.text

	li $v0, 8
	la $a0, input_string
	li $a1, 100
	syscall 
	
	addi $t6, $a0, 0		#t6 = string address
start:
	
	addi $s1, $sp, -1
	addi $s0, $sp, -1
	li $t1, 0 		#count_characters cnt = 0 $t1
	
input_loop:	# Each char
	
	addi $sp, $sp, -1
	lb $v0, ($t6)		#Load char from string
	addi $t6, $t6, 1 	#string_address++	
	
	beq $v0, 0x20, stop_input
	nop
	beq $v0, 0x0a, stop_input
	nop
	
check_upper:
	blt $v0, 0x41, end_error 	#Check Upper A-Z
	nop
	bgt $v0, 0x5A, check_lower
	nop
	addi $v0, $v0, 32		#Chuyển về lower-case
	j skip_check_lower
	nop

check_lower:
	blt $v0, 0x61, end_error		#Check lower a-z
	nop
	bgt $v0, 0x7A, end_error
	nop

skip_check_lower:
	sb $v0, 0($sp)
	addi $t1, $t1, 1			# cnt++
	addi $s0, $s0, -1		# string[i++]
					# dịch chuyển theo char cuối đc input
	j input_loop

stop_input:
	
	addi $s2, $t1, -1		# $s2 = cnt - 1 
					# - check for number of comparisons
				
	addi $s0, $s0, 1			# = last character of the word
	
check_cyclone_word:
	lbu $t2, 0($s1)		# first half character
	lbu $t3, 0($s0)		# last half character
	
	slt $t4, $t3, $t2	# compare: $t4 = $t2 <= $t3 ? continue : end
	beq $t4, 1, end_not_cyclone_word
	nop
	
	addi $s2, $s2, -1		  # number of comparisons - 1 after each comparison
	beq $s2, 0, end_check_cyclone_word # number of comparisons = 0 then stop check
	
	beq $ra, $0, skip	# Check $ra whether returns or not->skip
	nop
	jr $ra
	
	skip:

# Sau so sánh lần thứ 1, so sánh tiếp những lần tiếp theo

# Sau lần so sánh thứ lẻ, 
# địa chỉ s1 đang trỏ ở nửa TRÁI word cần check
# địa chỉ s0 đang trỏ ở nửa PHẢI word cần check

	addi $t5, $s0, 0		# temp = s0(Odd)	
	addi $s0, $s1, -1	# s0(Even) = s1(Odd) + 1
	addi $s1, $t5, 0		# s1(Even) = s0(Odd)
	
# phải giữ nguyên địa chỉ s0 của chữ cái STT nhỏ hơn
# để so sánh lần thứ 2 sau lần so sánh thứ 1
# nên cần jal so sánh luôn lần thứ chẵn (từ lần thứ 2 trở đi)
	
	jal check_cyclone_word
	nop
	add $ra, $0, $0		# Reset $ra after each Even - comparison
	
# Sau lần so sánh thứ CHẴN, 
# địa chỉ s1 đang trỏ ở nửa PHẢI word cần check
# địa chỉ s0 đang trỏ ở nửa TRÁI word cần check
	
	add $t5, $s0, 0		# temp = s0(Even)
	addi $s0, $s1, 1		# s0(Odd) = s1(Even) - 1
	addi $s1, $t5, 0		# s1(Odd) = s0(Even)
	
	
	j check_cyclone_word
	nop
	
end_check_cyclone_word:	
	li $v0, 4
	la $a0, Message_true
	
	syscall 
	
	addi $t7, $t1, 1		#t7 = cnt + 1
	add $sp, $sp, $t7	#reset $sp
	add $ra, $0, $0		#reset $ra
	
	lb $t8, ($t6)
	bne $t8, 0, start	# Quay về từ tiếp theo
	nop
	
	j end
	nop
			
end_not_cyclone_word:
	li $v0, 4
	la $a0, Message_false

	syscall 
	
	addi $t7, $t1, 1		# t7 = cnt + 1
	add $sp, $sp, $t7	#reset $sp
	add $ra, $0, $0		#reset $ra
				# Vì trong đó có những từ sẽ dừng ktra
				# ở lần kiểm tra thứ CHẴN và có jal sẽ
				# làm thay đổi ra -> làm khi chuyển tới
				# kiểm tra từ tiếp theo sẽ có lỗi ở jr ra
	
	lb $t8, ($t6)		# Quay về từ tiếp theo
	bne $t8, 0, start
	nop
	
	j end
	nop
	
end_error:
	li $v0, 4
	la $a0, Message_error_input

	syscall 
	
	addi $t7, $t1, 1		#t7 = cnt + 1
	add $sp, $sp, $t7	#reset $sp
	add $ra, $0, $0		#reset $ra
	
	j end
	nop
	
end:
	li $v0, 10
	syscall
