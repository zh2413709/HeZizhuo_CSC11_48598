.data
msg: .asciz "This program calculates a quadratic equation ax^2+bx by using shifting\nLet x be an integer from 0 to 255:"
input: .word 0
msg2: .asciz "The result is %d\n"
scan_format: .asciz "%d"
.text
.global quadratic
quadratic:
	push {lr}

	ldr r0, =msg
	bl printf

	ldr r0, =scan_format
	ldr r1, =input
	bl scanf

	ldr r1, =input
	ldr r1, [r1]
	ldr r2, =0x12b02
	ldr r3, =0xe0419

	mul r2, r2, r1
	mul r2, r2, r1
	mov r2, r2, lsr #20

	mul r3, r1, r3
	mov r3, r3, lsr #20

	add r1, r2, r3
@	add r1, r1, #1		/* I tried to figure out why all the numbers I entered result to a -1 off of the actual value. I know that it must be the accuracy of the hex number but I just don't know how to solve this problem.So I leave this line here */
	ldr r0, =msg2
	bl printf

	pop {lr}
	bx lr

