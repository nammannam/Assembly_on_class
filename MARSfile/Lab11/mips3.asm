.eqv KEY_CODE 0xFFFF0004 # ASCII code from keyboard, 1 byte
.eqv KEY_READY 0xFFFF0000 # =1 if has a new keycode ?
# Auto clear after lw
.eqv DISPLAY_CODE 0xFFFF000C # ASCII code to show, 1 byte
.eqv DISPLAY_READY 0xFFFF0008 # =1 if the display has already to do
# Auto clear after sw

.eqv COUNTER 0xFFFF0013
.data

eol: .asciiz "\n"

.text

# Kích hoạt ngắt COUNTER
li $t0, COUNTER
sb $t0, 0($t0)	#Kích hoạt


li $k0, KEY_CODE
li $k1, KEY_READY
li $s0, DISPLAY_CODE
li $s1, DISPLAY_READY
loop: nop

WaitForKey: lw $t1, 0($k1) # $t1 = [$k1] = KEY_READY
nop
 

beq $t1, $zero, WaitForKey # if $t1 == 0 then Polling
nop



#-----------------------------------------------------
ReadKey: lw $t0, 0($k0) # $t0 = [$k0] = KEY_CODE
nop
#-----------------------------------------------------
WaitForDis: lw $t2, 0($s1) # $t2 = [$s1] = DISPLAY_READY
nop
beq $t2, $zero, WaitForDis # if $t2 == 0 then Polling
nop
#-----------------------------------------------------

#-----------------------------------------------------
ShowKey: sw $t0, 0($s0) # show key
nop
#-----------------------------------------------------
j loop
nop

.ktext 0x80000180
# STOP ngắt COUNTER
li $t0, COUNTER
sb $0, 0($t0)	#STOP
	

	
	addi $t7, $t7, 1
	li $v0, 1
	addi $a0, $t7, 0
	syscall
	
	li $v0, 4
	la $a0, eol
	syscall
	
	
end_interupt:	#Kết thúc chương trình ngắt quay về main cần tăng epc cho đúng về ctrinh main
# Kích hoạt ngắt COUNTER
li $t0, COUNTER
sb $t0, 0($t0)	#Kích hoạt


next_pc:
	mfc0 $at, $14
	addi $at, $at, 4
	mtc0 $at, $14
return_to_main: eret
