	.global _start
_start:
	mov r0, #0
	mov r1, #0
	mov r2, #11
	mov r3, #5
	mov r4, #0 @flag a/b or a%b
compare:
	cmp r2, r3
	beq case_equal
case_different:
	bmi case_negative
case_positive:
	add r0, r0, #1
	sub r2, r2, r3
	b compare
case_negative:
	mov r1, r2
	b compare_flag
case_equal:
	add r0, r0, #1
compare_flag:
	cmp r4, #0
	beq end
	bne swap
swap:
	mov r0, r1
end:
	mov r7, #1
	swi 0
	
	
