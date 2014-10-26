.data
.balign 4
message1 : .asciz "Type in the 'n'th term of the Fibonacci Sequence: \n"
.balign 4
message2 : .asciz " %d is the number %d term of the Fibonacci Sequence \n "
.balign 4
scan_format : .asciz "%d"
.balign 4
read_term : .word 0

.text
calculation:
	push {lr}

	mov r0, #0 @counter
	mov r2, #0 @first term
	mov r3, #1 @second term
/* r4 will store the value of the 'n'th terms */
	cmp r4, #2
	bmi less_than_two
	beq equal_two

	sub r5, r4, #2
compare:
	cmp r0, r5
	bmi sequence
	b end
sequence:
	add r1, r2, r3
	mov r2, r3
	mov r3, r1
	add r0, #1
	b compare
equal_two:
	mov r1, #1
	b end
less_than_two:
	mov r1, #0
end:
	pop {lr}
	bx lr

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
