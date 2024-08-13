    .eqv HEADING 0xffff8010                       # Integer: An angle between 0 and 359
    # 0 : North (up)
    # 90: East (right)
    # 180: South (down)
    # 270: West (left)
    .eqv MOVING 0xffff8050                        # Boolean: whether or not to move
    .eqv LEAVETRACK 0xffff8020                    # Boolean (0 or non-0):
    # whether or not to leave a track
    .eqv WHEREX 0xffff8030                        # Integer: Current x-location of MarsBot
    .eqv WHEREY 0xffff8040                        # Integer: Current y-location of MarsBot
.text
main:   
	

moving1:	addi $a0, $0, 180
	jal ROTATE
	nop
	jal GO
	nop
sleep1:
	addi $v0, $0, 32
	li $a0, 5000
	syscall
	
moving2: addi $a0, $0, 90
	jal ROTATE
	nop
	jal GO
	nop

sleep2:
	addi $v0, $0, 32
	li $a0, 5000
	syscall
	
draw1:
	addi $a0, $0, 0
	jal ROTATE
	nop
	jal GO
	nop
	jal TRACK
	nop

sleep3:
	addi $v0, $0, 32
	li $a0, 5000
	syscall	

	jal UNTRACK
	nop
	
draw2:
	addi $a0, $0, 135
	jal ROTATE
	nop
	jal GO
	nop
	jal TRACK 
	nop

sleep4:
	addi $v0, $0, 32
	li $a0, 7150
	syscall	

	jal UNTRACK
	nop
#ratio of N : 2000/2860
draw3:
	addi $a0, $0, 0
	jal ROTATE
	nop
	jal GO
	nop
	jal TRACK 
	nop

sleep5:
	addi $v0, $0, 32
	li $a0, 5000
	syscall	

	jal UNTRACK
	nop
moving3: addi $a0, $0, 90
	jal ROTATE
	nop
	jal GO
	nop

sleep6:
	addi $v0, $0, 32
	li $a0, 5000
	syscall
	
	jal STOP
	nop 
	j end
	nop



end_main:
    #-----------------------------------------------------------
    # GO procedure, to start running
    # param[in] none
    #-----------------------------------------------------------
GO:     li      $at,        MOVING              # change MOVING port
    addi    $k0,        $zero,      1           # to logic 1,
    sb      $k0,        0($at)                  # to start running
    nop     
    jr      $ra
    nop     
    #-----------------------------------------------------------
    # STOP procedure, to stop running
    # param[in] none
    #-----------------------------------------------------------

STOP:    li      $at,        MOVING             # change MOVING port to 0
    sb      $zero,      0($at)                  # to stop
    nop     
    jr      $ra
    nop     
    #-----------------------------------------------------------
    # TRACK procedure, to start drawing line
    # param[in] none
    #-----------------------------------------------------------
TRACK:    li      $at,        LEAVETRACK        # change LEAVETRACK port
    addi    $k0,        $zero,      1           # to logic 1,
    sb      $k0,        0($at)                  # to start tracking
    nop     
    jr      $ra
    nop     
    #-----------------------------------------------------------
    # UNTRACK procedure, to stop drawing line
    # param[in] none
    #-----------------------------------------------------------
UNTRACK:    li      $at,        LEAVETRACK      # change LEAVETRACK port to 0
    sb      $zero,      0($at)                  # to stop drawing tail
    nop     
    jr      $ra
    nop     
    #-----------------------------------------------------------
    # ROTATE procedure, to rotate the robot
    # param[in] $a0, An angle between 0 and 359
    # 0 : North (up)
    # 90: East (right)
    # 180: South (down)
    # 270: West (left)
    #-----------------------------------------------------------
ROTATE:    li      $at,        HEADING          # change HEADING port
    sw      $a0,        0($at)                  # to rotate robot
    nop     
    jr      $ra
    nop     

end: