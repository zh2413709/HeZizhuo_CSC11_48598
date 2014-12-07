.data
.align 4
array: .skip 12

.text
.global main
main:
	push {lr}

	mov r0, #2
	ldr r1, =array
	bl init_array

	mov r0, #2
	ldr r1, =array
	bl print

	pop {lr}
	bx lr

