.data
Message: .asciiz "Ho va ten sinh vien:”
string: .space 100
.text
li $v0, 54
la $a0, Message
la $a1, string
la $a2, 100
syscall

la $a0, string
li $v0, 4
syscall