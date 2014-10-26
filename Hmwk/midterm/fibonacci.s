.data
.balign 4
message1 : .asciz "Type in the 'n'th term of the Fibonacci Sequence: \n"
.balign 4
message2 : .asciz " Term %d is the # %d term of the Fibonacci Sequence \n "
.balign 4
scan_format : .asciz " %d "
.balign 4
read_term : .word 0

.text
calculation:
	push {lr}

	mov r0, #0 @counter
	mov r2, #0 @first term
	mov r3, #1 @second term
compare:
	/* r4 will store the value of the 'n'th terms */
	sub r4, r4, #2
	cmp r0, r4
	bmi sequence
end:
	pop {lr}
	bx lr
sequence:
	ldr r4, address_of_read_term
	ldr r4, [r4]
	cmp r4, #2
	beq less_equal_2

	add r1, r2, r3
	mov r2, r3
	mov r3, r1
	b compare
less_equal_2:
	cmp r4, #0
	bgr gr1_but_lr2
	mov r1, #0
	b end
gr1_but_lr2:
	sub r1, r4, #1

.global main
main:
	push {lr}

	ldr r0, address_of_message1
	bl printf

	ldr r0, address_of_scan_format
	ldr r1, address_of_read_term
	bl scanf

	ldr r4, address_of_read_term
        ldr r4, [r4]
	bl calculation

	ldr r0, address_of_message2
	ldr r2, address_of_read_term
	ldr r2, [r2]
	bl printf

	pop {lr}
	bx lr

address_of_message1 : .word message1
address_of_message2 : .word message2
address_of_scan_format : .word scan_format
address_of_read_term : .word read_term

.global printf
.global scanf
