.eqv MONITOR_SCREEN 0x10010000 #Dia chi bat dau cua bo nho man hinh
.eqv RED 0x00FF0000 #Cac gia tri mau thuong su dung
.eqv GREEN 0x0000FF00
.eqv BLUE 0x000000FF
.eqv WHITE 0x00FFFFFF
.eqv YELLOW 0x00FFFF00
.text
	li $k0, MONITOR_SCREEN #Nap dia chi bat dau cua man hin
	
	
	Loop1:
	
	beq $t1, 256, end_loop1
	nop
	add $t2, $k0, $t1
	li $t0, BLUE
	sw $t0, 0($t2)
	nop
	addi $t1, $t1, 32
	j Loop1
	nop
end_loop1:

	li $t1, 28

	Loop2:
	beq $t1, 284, end_loop2
	nop
	add $t2, $k0, $t1
	
	li $t0, BLUE
	sw $t0, 0($t2)
	nop
	
	addi $t1, $t1, 32
	j Loop2
	nop
end_loop2:

	
	li $t1, 36
	
	Loop3:
	beq $t1, 252, end_loop3
	nop
	add $t2, $k0, $t1
	
	li $t0, BLUE
	sw $t0, 0($t2)
	nop
	
	addi $t1, $t1, 36
	j Loop3
	nop
	
end_loop3:
	

	


			