    #Laboratory Exercise 5,Assignment 3 
.data   
x:  .space  32                              # destination string x, empty
y:  .asciiz "Nguyen Khanh Nam \nHi"                         # source string y
.text   
strcpy:
    add     $s0,    $zero,  $zero           # $s0 = i = 0
    
    la $a0, x
    la $a1, y
L1: 
    add     $t1,    $s0,    $a1             # $t1 = $s0 + $a1 = i + y[0]
    # = address of y[i]
    lb      $t2,    0($t1)                  # $t2 = value at $t1 = y[i]
    add     $t3,    $s0,    $a0             # $t3 = $s0 + $a0 = i + x[0]
    # = address of x[i]
    sb      $t2,    0($t3)                  # x[i]= $t2 = y[i]
    beq     $t2,    $zero,  end_of_strcpy   # if y[i] == 0, exit
    nop     
    addi    $s0,    $s0,    1               # $s0 = $s0 + 1 <-> i = i + 1
    j       L1                              # next character
    nop     
end_of_strcpy:

	li $v0, 4
	syscall