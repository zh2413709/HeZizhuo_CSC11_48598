	.global _start
_start:
	mov r0, #0
	mov r2, #11
	mov r3, #5
	mov r4, #1
	mov r5, r3
	mov r1, r2
divMod:
	cmp r1, r3
	beq case_equal 
	bmi end @end it if r1<r3
scaleLeft:
	mov r4, r4, lsl#1 @division counter
	mov r5, r5, lsl#1 @Mod/Remainder subtraction
 	cmp r1, r5
	bmi scaleLeft
addSub:
	add r0, r0, r4
	sub r1, r1, r5
scaleRight:
	mov r4, r4, lsr#1
	mov r5, r5, lsr#1
	cmp r1, r5
	bmi scaleRight
	cmp r4, #1
	bge addSub
end:
	mov r7, #1
	swi 0
case_equal:
	mov r0, #1
	b end

