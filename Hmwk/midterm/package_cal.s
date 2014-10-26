.data
.balign 4
message_1 :.asciz "How many hours would  you like to access: \n "
.balign 4
scan_format : .asciz "%d"
.balign 4
message_2 : .asciz "You access %d hr, you have to pay %d  \n"
.balign 4
read_hr : .word 0

.global caseA
caseA:
	push {lr}

	ldr r0, address_of_message_1
	bl printf

	ldr r0, address_of_scan_format
	ldr r1, address_of_read_hr
	bl scanf

	ldr r1, address_of_read_hr
	ldr r1, [r1]

	cmp r1, #22
	ble lesser_equal_22_hours
	mov r3, #6
	sub r1, r1, #22
	mul r1, r3, r1
	add r2, r1, #63
endA:
	ldr r0, address_of_message_2
	ldr r1, address_of_read_hr
	ldr r1, [r1]
	bl printf
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
	 ldr r0, address_of_message_1
        bl printf

        ldr r0, address_of_scan_format
        ldr r1, address_of_read_hr
        bl scanf

        ldr r1, address_of_read_hr
        ldr r1, [r1]

        cmp r1, #44
        ble lesser_equal_44_hours
        mov r3, #4
        sub r1, r1, #44
        mul r1, r3, r1
        add r2, r1, #79
endB:
	ldr r0, address_of_message_2
	ldr r1, address_of_read_hr
        ldr r1, [r1]
        bl printf
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
	ldr r0, address_of_message_1
        bl printf

        ldr r0, address_of_scan_format
        ldr r1, address_of_read_hr
        bl scanf

        ldr r1, address_of_read_hr
        ldr r1, [r1]

        cmp r1, #66
        ble lesser_equal_66_hours
        mov r3, #2
        sub r1, r1, #66
        mul r1, r3, r1
        add r2, r1, #73
endC:
	ldr r0, address_of_message_2
	ldr r1, address_of_read_hr
        ldr r1, [r1]
        bl printf
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


address_of_message_1 : .word message_1
address_of_scan_format : .word scan_format
address_of_message_2 : .word message_2
address_of_read_hr : .word read_hr

.global printf
.global scanf
