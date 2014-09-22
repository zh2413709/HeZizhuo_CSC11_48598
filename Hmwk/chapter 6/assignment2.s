	.global _start
_start:
	mov r0, #0
	mov r1, #0
	mov r2, #11
	mov r3, #5
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
	sub r1, r2, r1
	b end
case_equal:
	add r0, r0, #1
end:
	mov r7, #1
	swi 0
	
	
