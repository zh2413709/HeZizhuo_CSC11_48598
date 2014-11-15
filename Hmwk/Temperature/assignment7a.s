.data
msg1 : .asciz "=====================This is a temperature converter=====================\n"
msg2 : .asciz "Please enter an integer  between and including 32 to 212 in farenheit:"
msg3 : .asciz "The temperature you entered is: %d °F, which is: %d °C\n"
temp_read : .word 0
scan_format : .asciz "%d"
msg4 : .asciz "====================Invalid number, please try again!====================\n" 

.text

/* Temperature converter function */
temp_convert:
	push {lr}

	sub r1, r1, #32
	add r1, r1, r1, LSL #2 /* r1 ← r1 + (r1*4) equivalent to r1 ← r1*5 */
	mov r2, #9
	bl divMod

	pop {lr}
	bx lr

.global main
main:
	push {lr}

	ldr r0, addr_of_msg1
	bl printf
ask_for_input:
	ldr r0, addr_of_msg2
	bl printf

	ldr r0, addr_of_scan_format
	ldr r1, addr_of_temp_read
	bl scanf

	ldr r0, addr_of_temp_read
	ldr r1, [r0]

	cmp r1, #32
	bmi invalid

	cmp r1, #212
	bgt invalid

	bl temp_convert

	mov r2, r0
	ldr r1, addr_of_temp_read
	ldr r1, [r1]
	ldr r0, addr_of_msg3
	bl printf

	pop {lr}
	bx lr
invalid:
	ldr r0, addr_of_msg4
	bl printf
	b ask_for_input

addr_of_msg1 : .word msg1
addr_of_msg2 : .word msg2
addr_of_msg3 : .word msg3
addr_of_msg4 : .word msg4
addr_of_temp_read : .word temp_read
addr_of_scan_format : .word scan_format

.global printf
.global scanf
