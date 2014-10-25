.data
.balign 4
message1 :.ascizr "Hey, choose one of the packag ('a', 'b', 'c'):"
.balign 4
scan_pattern : .asciz "%c"
.balign 4
message2 : .asciz "You just entered an invaluable value: %c, please enter again. \n"
.balign 4
read : .word 0

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
	cmp r1, 'C'
	beq case_c

	ldr r0, address_of_message2
        bl printf
	b options
case_a:
	ldr r0, address_of_message2
	bl printf
end:
	pop {lr}
	bx lr

address_of_message1 : .word message1
address_of_message2 : .word message2
address_of_scan_pattern : .word scan_pattern
address_of_read : .word read
.global printf
.global scanf
