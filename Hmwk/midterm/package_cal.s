.text

.global caseA
caseA:
	push {lr}

	cmp r1, #22
	ble lesser_equal_22_hours
	mov r3, #6
	sub r1, r1, #22
	mul r1, r3, r1
	add r2, r1, #63
endA:
	pop {lr}
	bx lr
lesser_equal_22_hours:
	cmp r1, #11
	ble lesser_equal_11_hours
	mov r3, #3
	sub r1, r1, #11
	mul r1, r3, r1
	add r2, r1, #30
	b endA
lesser_equal_11_hours:
	mov r2, #30
	b endA

.global caseB
caseB:
        push {lr}

        cmp r1, #44
        ble lesser_equal_44_hours
        mov r3, #4
        sub r1, r1, #44
        mul r1, r3, r1
        add r2, r1, #79
endB:
        pop {lr}
        bx lr
lesser_equal_44_hours:
        cmp r1, #22
        ble lesser_equal_22_hours_B
        mov r3, #2
        sub r1, r1, #22
        mul r1, r3, r1
        add r2, r1, #35
        b endB
lesser_equal_22_hours_B:
        mov r2, #35
        b endB

.global caseC
caseC:
        push {lr}

        cmp r1, #66
        ble lesser_equal_66_hours
        mov r3, #2
        sub r1, r1, #66
        mul r1, r3, r1
        add r2, r1, #73
endC:
        pop {lr}
        bx lr
lesser_equal_66_hours:
        cmp r1, #33
        ble lesser_equal_33_hours
        mov r3, #1
        sub r1, r1, #33
        mul r1, r3, r1
        add r2, r1, #40
        b endC
lesser_equal_33_hours:
        mov r2, #40
        b endC


