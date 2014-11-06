	.global _start
_start:
	mov r0, #0
	mov r2, #111
	mov r3, #5
	mov r4, #0
	mov r1, r2
compare:
	cmp r1, r3
	beq equal
different:
	bmi negative
positive:
	add r0, r0, #1
	sub r1, r1, r3
	cmp r1, r3
	bge positive
	b compare_flag
negative:
	mov r1, r2
	b compare_flag
equal:
	add r0, r0, #1
compare_flag:
	cmp r4, #0
	beq end
swap:
	mov r0, r1
end:
	mov r7, #1
	swi 0
