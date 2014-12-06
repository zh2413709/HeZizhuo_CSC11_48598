.data
.align 4
array: .skip 8
.align 4
msg: .asciz "The float is :%f\n"

.text
init_array:
	push {r4, lr}

	mov r6, #88
	sub r6, r6, #32
	vmov s6, r6
	vcvt.f32.s32 s6, s6

	mov r5, #5
	vmov s1, r5
	vcvt.f32.s32 s2, s1

	mov r5, #9
	vmov s3, r5
	vcvt.f32.s32 s4, s3

	vdiv.f32 s5, s2, s4
	vmul.f32 s0, s6, s5

	vmov r2, s0
	str r2, [r1]

	pop {r4, lr}
	bx lr
print:
	push {r4, r5, r6, r7, r8, lr}

	mov r7, r1
	ldr r5, [r7]
	vmov s7, r5
	vcvt.f64.f32 d1, s7

	ldr r0, =msg
	vmov r2, r3, d1
	bl printf

	pop {r4, r5, r6, r7, r8, lr}
	bx lr
.global main
main:
	push {r4, lr}

	ldr r1, =array
	bl init_array

	ldr r1, =array
	bl print

	pop {r4, lr}
	bx lr
.global printf
