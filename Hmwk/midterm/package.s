.data
.balign 4
message1 :.asciz "Hey, choose one of the packag ('a', 'b', 'c'): \n "
.balign 4
scan_pattern : .asciz "%c"
.balign 4
message2 : .asciz "You entered an invaluable value: %c \n "
.balign 4
message3 : .asciz "You have entered: %c, thank you. \n"
.balign 4
read : .word 0

.text
caseA:
	push {lr}

	ldr r0, address_of_message3
	bl printf

	pop {lr}
	bx lr

caseB:
	push {lr}

        ldr r0, address_of_message3
        bl printf

        pop {lr}
        bx lr

caseC:
	push {lr}

        ldr r0, address_of_message3
        bl printf

        pop {lr}
        bx lr

.global main
main:
	push {lr}

options:
	ldr r0, address_of_message1
        bl printf

	ldr r0, address_of_scan_pattern
        ldr r1, address_of_read
        bl scanf

	ldr r1, address_of_read
        ldr r1, [r1]

	cmp r1, #'a'
	beq case_a
	cmp r1, #'A'
	beq case_a
	cmp r1, #'b'
	beq case_b
	cmp r1, #'B'
	beq case_b
	cmp r1, #'c'
	beq case_c
	cmp r2, #'C'
	beq case_c

	ldr r0, address_of_message2
	ldr r1, address_of_read
	ldr r1, [r1]
        bl printf
	b end
case_a:
	bl caseA
	b end
case_b:
	bl caseB
	b end
case_c:
	bl caseC
	b end
end:
	pop {lr}
	bx lr

address_of_message1 : .word message1
address_of_message2 : .word message2
address_of_message3 : .word message3
address_of_scan_pattern : .word scan_pattern
address_of_read : .word read
.global printf
.global scanf