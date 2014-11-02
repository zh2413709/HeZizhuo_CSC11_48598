.data
.balign 4
spot1 : .word 0
.balign 4
spot2 : .word 0
.balign 4
spot3 : .word 0
.balign 4
message1 : .asciz "Please enter 3 numbers between 0 and 6 for each, press 'enter' key after each number\n"
.balign 4
message2 : .asciz "The result is RP: %d, WP: %d\n"
.balign 4
scan_format : .asciz " %d %d %d"
.balign 4
spot1_read : .word 0
.balign 4
spot2_read : .word 0
.balign 4
spot3_read : .word 0
.balign 4
message3 : .asciz "You have guessed all the number correct, congratulations!\n"

.text
.balign 4
.global main
main:
 	push {lr}

generate_random_number:
	bl rantest1
	ldr r0, addr_of_spot1
	str r1, [r0]

	bl rantest2
        ldr r0, addr_of_spot2
        str r1, [r0]

	bl rantest3
        ldr r0, addr_of_spot3
        str r1, [r0]

guess:
	ldr r0, addr_of_message1
	bl printf

	ldr r0, addr_of_scan_format
	ldr r1, addr_of_spot1_read
	ldr r2, addr_of_spot2_read
	ldr r3, addr_of_spot3_read
	bl scanf
	/* compare*/
	mov r0, #0
	mov r5, #0
	ldr r1, addr_of_spot1
	ldr r1, [r1]
	ldr r2, addr_of_spot2
	ldr r2, [r2]
	ldr r3, addr_of_spot3
	ldr r3, [r3]

	ldr r4, addr_of_spot1_read
	ldr r4, [r4]
	bl cmp1

	ldr r4, addr_of_spot2_read
	ldr r4, [r4]
	bl cmp2

	ldr r4, addr_of_spot3_read
	ldr r4, [r4]
	bl cmp3

	mov r4, r0
	mov r1, r0
	mov r2, r5
	ldr r0, addr_of_message2
	bl printf

	cmp r4, #3 @set up loop
	beq win
	b guess @loop back to input when user did not make the correct guess
win:
	ldr r0, addr_of_message3
	bl printf

	pop {lr}
	bx lr

addr_of_spot1 : .word spot1
addr_of_spot2 : .word spot2
addr_of_spot3 : .word spot3
addr_of_spot1_read : .word spot1_read
addr_of_spot2_read : .word spot2_read
addr_of_spot3_read : .word spot3_read
addr_of_message1 : .word message1
addr_of_message2 : .word message2
addr_of_message3 : .word message3
addr_of_scan_format : .word scan_format
.global printf
.global scanf
