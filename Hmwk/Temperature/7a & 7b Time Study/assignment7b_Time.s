.data
msg1 : .asciz "Please enter a # in F:"
scan_format : .asciz "%d"
Temp_C : .word 0
Temp_F : .word 0x8e38f
msg : .asciz "The temp is: %d\n"
.text
.global main
main:
	push {lr}
	ldr r0, addr_of_msg1
	bl printf

	ldr r0, addr_of_scan_format
	ldr r1, addr_of_Temp_C
	bl scanf

	mov r5, #1 /* setup loop */
	ldr r6, =15000000 /* let the program loop 15000000 times */

loop:
	ldr r0, addr_of_Temp_C
	ldr r0, [r0]
	sub r0, r0, #32

	cmp r6, r5
	bgt scale

	ldr r1, addr_of_Temp_F
	ldr r1, [r1]
	mul r3, r1, r0
	mov r1, r3, lsr #20
	ldr r0, addr_of_msg
	bl printf
	pop {lr}
	bx lr
scale:
	add r5, r5, #1
	b loop
addr_of_msg1 : .word msg1
addr_of_scan_format : .word scan_format
addr_of_Temp_C : .word Temp_C
addr_of_Temp_F : .word Temp_F
addr_of_msg : .word msg
.global printf
.global scanf
