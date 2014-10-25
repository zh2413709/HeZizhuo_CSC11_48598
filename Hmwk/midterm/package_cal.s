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
end:
	pop {lr}
	bx lr
lesser_equal_22_hours:
	cmp r1, #11
	ble lesser_equal_11_hours
	mov r3, #3
	sub r1, r1, #11
	mul r1, r3, r1
	add r2, r1, #30
	b end
lesser_equal_11_hours:
	mov r2, #30
	b end

.global caseB
caseB:
        push {lr}

        cmp r1, #44
        ble lesser_equal_44_hours
        mov r3, #4
        sub r1, r1, #44
        mul r1, r3, r1
        add r2, r1, #79
end:
        pop {lr}
        bx lr
lesser_equal_44_hours:
        cmp r1, #22
        ble lesser_equal_22_hours
        mov r3, #2
        sub r1, r1, #22
        mul r1, r3, r1
        add r2, r1, #35
        b end
lesser_equal_22_hours:
        mov r2, #35
        b end

.global caseC
caseC:
        push {lr}

        cmp r1, #66
        ble lesser_equal_66_hours
        mov r3, #2
        sub r1, r1, #66
        mul r1, r3, r1
        add r2, r1, #73
end:
        pop {lr}
        bx lr
lesser_equal_66_hours:
        cmp r1, #33
        ble lesser_equal_33_hours
        mov r3, #1
        sub r1, r1, #33
        mul r1, r3, r1
        add r2, r1, #40
        b end
lesser_equal_33_hours:
        mov r2, #40
        b end


