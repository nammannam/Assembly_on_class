.eqv LEFT_SEGS 0xFFFF0011
.eqv RIGHT_SEGS 0xFFFF0010

.eqv COUNTER 0xFFFF0013
.eqv MASK_CAUSE_COUNTER 0x00000400

.eqv KEY_CODE 0xFFFF0004
.eqv KEY_READY 0xFFFF0000

.data
segsdisplay_number_arr: .byte 63, 6, 91, 79, 102, 109, 125, 7, 127, 111 #mảng chứa số 0-9 để hiển thị ra 7segs LED (mỗi số 1 byte)

string: .asciiz "bo mon ky thuat may tinh"

msg1: .asciiz "Toc do go phim: "
msg2: .asciiz " words/minute\n"
msg3: .asciiz "Tong thoi gian chay chuong trinh: "
msg4: .asciiz " (s)\n"

.text

li $k0, KEY_CODE
li $k1, KEY_READY

# Kích hoạt ngắt COUNTER
li $t0, COUNTER
sb $t0, 0($t0)	#Kích hoạt

la $a1, string	#Lưu add của string test case
la $a2, segsdisplay_number_arr # Lưu add của mảng chứa số 7-segs Display

li $t8, LEFT_SEGS
li $t9, RIGHT_SEGS


li $s1, 0 	#Số ký tự đúng
li $s2, 0 	#Tổng số ký tự nhập vào
li $s3, 0	#Tổng thời gian chạy chương trình
li $s4, 0	#Tổng số lần ngắt Counter
li $s5, 0	#Chứa ký tự đứng trước ký tự đang được check
li $s6, 0	#Số từ

Wait4keyboard:
	lb $t1, 0($k1)
	nop
	bne $t1, 0, check_string
	nop
	li $v0, 32	#Sleep
	li $a0, 5
	syscall
	nop
	beq $t1, 0, Wait4keyboard
	nop
keyboard_intr: #-----------------------------------------
check_string:
# Dừng ngắt COUNTER để không ảnh hưởng khi chạy ctrinh 
li $t0, COUNTER
sb $0, 0($t0)	#STOP
	lb $t3, 0($a1)		#Get char string test case 
	beq $t3, 0, end_prog	#Check ở string test case tới NULL thì dừng
	nop
	lb $t4, 0($k0)		#Get Key code
	
	bne $t3, $t4, continue1	#Kiểm tra ký tự đúng hay không
	nop
	addi $s1, $s1, 1		# Số ký tự đúng ++
continue1:
#-----------------------------------------------------------------  
# Kiểm tra để đếm số TỪ nhập vào:
# Nếu nhập vào space cần kiểm tra 2 TH
# TH1: trước space vừa nhập là 1 char -> Tính +1 từ
# TH2: trước space vừa nhập cũng là 1 space -> Không tính từ -> về main
# Nếu KHÔNG nhập vào space thì tiếp tục đọc ký tự nhập vào tiếp (về main)
#-----------------------------------------------------------------  
	bne $t4, ' ', continue2
	nop
	beq $s5, ' ', continue2
	nop
	addi $s6 , $s6, 1		#Tăng số từ +1
	
continue2:
	addi $s5, $t4, 0		# Save lại char vừa check
	addi $a1, $a1, 1		# Tăng con trỏ string test case thêm 1 byte

# Kích hoạt lại ngắt COUNTER
li $t0, COUNTER
sb $t0, 0($t0)	#Kích hoạt
	
	j Wait4keyboard	
	nop
#------------------------------------------------------------------------------------

.ktext 0x80000180
# Dừng ngắt COUNTER để không ảnh hưởng khi chạy ctrinh ngắt
li $t0, COUNTER
sb $0, 0($t0)	#STOP
	
counterIntr:

	blt $s4, 200, continue3	# Chưa đủ số lần ngắt Counter thì chưa đếm giây 
	nop
	addi $s4, $0, 0		# reset số lần ngắt
	addi $s3, $s3, 1		# Tăng thời gian chạy
	j end_interrupt
	nop
	
	continue3:
	addi $s4, $s4, 1		# Tăng số lần ngắt
	
	j end_interrupt
	nop
		

end_interrupt:	#Kết thúc chương trình ngắt quay về main cần tăng epc cho đúng về ctrinh main
# VÀ kích hoạt trở lại ngắt COUNTER

# Kích hoạt lại ngắt COUNTER
li $t0, COUNTER
sb $t0, 0($t0)	#Kích hoạt

	mtc0 $0, $13		#RESET cause reg

next_pc:
	mfc0 $at, $14
	addi $at, $at, 4
	mtc0 $at, $14
return_to_main: eret

#---------------------------------------------------------
show_7segsLed:
	
	addi $t5, $s1, 0
	addi $t6, $0, 10
	div $t5, $t6
	
	mflo $t5		# Lấy số hàng chục
	mfhi $t6		# Lấy số hàng đơn vị

#SHOW LEFT LED
	add $t5, $a2, $t5	# $t5 chứa address của số hàng chục trong mảng 7-segs display
	lb $t5, 0($t5)
	sb $t5, 0($t8)		# Show số hàng chục ra LED

#SHOW RIGHT LED
	add $t6, $a2, $t6 	# $t6 chứa address của số hàng đơn vị trong mảng
	lb $t6, 0($t6)
	sb $t6, 0($t9)		# Show số hàng đơn vị ra LED
	
	jr $ra			#Return về ngắt
	nop

#--------------------------------------------------------------------------------------
end_prog:
				
	jal show_7segsLed
	nop	
	li $v0, 4
	la $a0, msg1
	syscall
	
	li $v0, 1
	addi $s6, $s6, 1
	addi $t2, $0, 60		
	mult $s6, $t2		#Số từ x 60
	mflo $s6
	div $s6, $s3		# (số từ x 60)/tổng số thời gian (s)
	mflo $a0			# wpm
	syscall
	
	li $v0, 4
	la $a0, msg2
	syscall
	
	li $v0, 4
	la $a0, msg3
	syscall
	
	li $v0, 1
	addi $a0, $s3, 0
	syscall
	
	li $v0, 4
	la $a0, msg4
	syscall
	
	li $v0, 10
	syscall
end:
	



