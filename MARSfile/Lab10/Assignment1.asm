.eqv SEVENSEG_LEFT 0xFFFF0010 # ??a ch? c?a ?�n LED 7 ?o?n tr�i. # Bit 0 = ?o?n a; # Bit 1 = ?o?n b; ... # Bit 7 = d?u .
.eqv SEVENSEG_RIGHT 0xFFFF0011 # ??a ch? c?a ?�n LED 7 ?o?n ph?i
.data
arr: .word 0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x07, 0x7F, 0x6F, 0x77, 0x7C, 0x39, 0x5E, 0x79, 0x71
.text
main:
    # L?p t? 0 ??n 15
    la $t7, arr
    add $t8, $0, $t7
    add $t9, $0, $t7
    li $t1, 0 # Kh?i t?o bi?n ??m
loop:
    subi $t3, $t1, 10
    slt $t4, $t3, $0
    beq $t4, 0, exit
SO_TRUOC_9:
    lw $t2, 0($t8)
    addi $a0, $0, 0x3F
    jal SHOW_7SEG_RIGHT # Hi?n th?
   
    add $a0, $0, $t2
    jal SHOW_7SEG_LEFT 
    addi $t8, $t8, 4
    addi $t1, $t1, 1
    li $v0, 32
# ??t gi� tr? cho $a0 l� 1000 ?? ch? ??nh th?i gian ng? l� 1000 milliseconds (1 gi�y)
li $a0, 1000
# G?i syscall ?? th?c hi?n ?? tr?
syscall
    j loop

    # Ki?m tra n?u bi?n ??m v?n nh? h?n 16, ti?p t?c v�ng l?p
exit: 
    li $v0, 10
    syscall
endmain:
#---------------------------------------------------------------
# Function SHOW_7SEG_LEFT: B?t/t?t ?�n LED 7 ?o?n tr�i
# param[in] $a0 gi� tr? c?n hi?n th?
# remark $t0 thay ??i
#---------------------------------------------------------------
SHOW_7SEG_LEFT:
    li $t0, SEVENSEG_LEFT # G�n ??a ch? c?ng
    sb $a0, 0($t0) # G�n gi� tr? m?i
    jr $ra
#---------------------------------------------------------------
# Function SHOW_7SEG_RIGHT: B?t/t?t ?�n LED 7 ?o?n ph?i
# param[in] $a0 gi� tr? c?n hi?n th?
# remark $t0 thay ??i
#---------------------------------------------------------------
SHOW_7SEG_RIGHT:
    li $t0, SEVENSEG_RIGHT # G�n ??a ch? c?ng
    sb $a0, 0($t0) # G�n gi� tr? m?i
    jr $ra
