.data
msg: .asciz "The number is: %d\n"
.text

.global init_array
init_array:
	push {r4, lr}

	mov r4, #0
	mov r5, #0
	b check_loop_array
loop_array:
	str r5, [r1, r4, lsl #2]
	add r5, r5, #1
	add r4, r4, #1
check_loop_array:
	cmp r4, r0
	ble loop_array

	pop {r4, lr}
	bx lr

.global print
print:
	push {r4, r5, r6, r7, lr}

	mov r4, #0
	mov r6, r1
	mov r7, r0
	b check_loop_print
loop_print:
	ldr r1, [r6, r4, lsl #2]
	ldr r0, =msg
	bl printf

	add r4, r4, #1
check_loop_print:
	cmp r4, r7
	ble loop_print

	pop {r4, r5, r6, r7, lr}
	bx lr
.global printf
