.data
msg1 : .asciz "=====================This is a temperature converter=====================\n"
msg2 : .asciz "Please enter an integer  between and including 32 to 212 in farenheit:"
msg3 : .asciz "The temperature you entered is: %d °F, which is: %d °C\n"
temp_read : .word 0
scan_format : .asciz "%d"

.text

/* Temperature converter function */
temp_convert:
	push {lr}

	sub r1, r1, #32 /* r1 - 32 */
	add r1, r1, r1, LSL #2 /* r1 ← r1 + (r1*4) equivalent to r1 ← r1*5 */
	mov r2, #9 /* #9 is the denominator */
	bl divMod /* call divMod function to do the division */

	pop {lr}
	bx lr
.global main
main:
	push {lr}

	ldr r0, addr_of_msg1 /* load the address of the first message */
	bl printf /* call printf*/
ask_for_input:
	ldr r0, addr_of_msg2 /* load the address of the second message */
	bl printf /* call printf */

	ldr r0, addr_of_scan_format /* load the address of the scan format */
	ldr r1, addr_of_temp_read /* load the address of the temperature that user entered */
	bl scanf /* call scanf */

	mov r6, #1 /*set up loop */
	ldr r7, =15000000 /* let the program loop 15000000 times */
loop:
	ldr r0, addr_of_temp_read /* load the address of the user entered temperature */
	ldr r1, [r0] /* load the content of the address */

	bl temp_convert /* call the temperature converter function */

	cmp r7, r6
	bgt scale

	mov r2, r0  /* save the result in Celsius to r2 */
	ldr r1, addr_of_temp_read /* load the address of entered number */
	ldr r1, [r1] /* load the content of address */
	ldr r0, addr_of_msg3 /* load the address of message3 */
	bl printf /* call printf */

	pop {lr}
	bx lr
scale:
	add r6, r6, #1
	b loop
addr_of_msg1 : .word msg1
addr_of_msg2 : .word msg2
addr_of_msg3 : .word msg3
addr_of_temp_read : .word temp_read
addr_of_scan_format : .word scan_format

.global printf
.global scanf
