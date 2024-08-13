.eqv RIGHT_SEGS 0xFFFF0010
.eqv LEFT_SEGS 0xFFFF0011


.data
segsdisplay_number_arr: .byte 63, 6, 91, 79, 102, 109, 125, 7, 127, 111 #mảng chứa số 0-9 để hiển thị ra 7segs LED (mỗi số 1 byte)
.text
la $a2, segsdisplay_number_arr # Lưu add của mảng chứa số 7-segs Display	

	
		
li $t8, LEFT_SEGS
li $t9, RIGHT_SEGS

addi $t5, $t5, 2
addi $t6, $t6, 1

#SHOW LEFT LED
	add $t5, $a2, $t5	# $t5 chứa add của số hàng chục trong mảng 7-segs display
	lb $t5, 0($t5)
	sb $t5, 0($t8)		# Show số hàng chục ra LED

#SHOW RIGHT LED
	add $t6, $a2, $t6 	# $t6 chứa add của số hàng đơn vị trong mảng
	lb $t6, 0($t6)
	sb $t6, 0($t9)		# Show số hàng đơn vị ra LED		
	
	