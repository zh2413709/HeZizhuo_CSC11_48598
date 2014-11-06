	.global _start
_start:
	mov r0, #0
	mov r2, #11
	mov r3, #5
	mov r4, #1
	mov r5, #0
	mov r6, #0
	mov r7, #0
	mov r8, #10
	mov r9, #0
	mov r1, r2
compare:
	cmp r1, r3 
	beq case_equal
case_different:
	bmi case_negative
case_positive:
	b scale
	
case_negative:
	mul r5, r0, r3
	sub r1, r2, r5
	b compare_flag
case_equal:
	add r0, r0, #1
scale:
	mov r6, #1
	mul r7, r3, r6
	mul r9, r7, r8
check_scale:
	cmp r1, r9
	bge increase_scale
add_scale:
	add r0, r0, r6
	sub r1, r1, r7
	cmp r1, r7
	bgt add_scale
	ble compare

compare_flag:
	cmp r4, #0
	beq end
	bne swap
swap:
	mov r0, r1
end:
	mov r7, #1
	swi 0
increase_scale:
	mul r5, r6, r8
	mov r6, r5
	mul r7, r3, r6
	mul r9, r7, r8
	b check_scale	
	
