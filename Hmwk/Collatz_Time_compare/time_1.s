.data
msg : .asciz "Starting: %d\nEnding: %d\nDelta: %d\n"
start : .word 0

.text

.global starting
starting:
	push {lr}

	mov r0, #0
	bl time
	ldr r2, addr_of_start /* load the address of the variable */
	str r0, [r2] /* save the first time into a variable */

	pop {lr}
	bx lr

.global ending
ending:
	push {lr}

	mov r0, #0
	bl time
	mov r2, r0
	ldr r1, addr_of_start
	ldr r1, [r1]
	sub r3, r2, r1
	ldr r0, addr_of_msg
	bl printf

	pop {lr}
	bx lr
addr_of_start : .word start
addr_of_msg : .word msg
.global printf
