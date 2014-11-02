/* all of the comparision functions are here */
.text

.global cmp1
cmp1:
	push {lr}

	cmp r4, r1
	addeq r0, r0, #1
	beq end1
	cmp r4, r2
	addeq r5, r5, #1
	beq end1
	cmp r4, r3
	addeq r5, r5, #1
end1:
	pop {lr}
	bx lr

.global cmp2
cmp2:
	push {lr}

	cmp r4, r1
	beq U2_equal_A1
	cmp r4, r2
	addeq r0, r0, #1
	beq end2
	cmp r4, r3
	addeq r5, r5, #1
end2:
	pop {lr}
	bx lr
U2_equal_A1:
	add r5, r5, #1
	cmp r1, r2
	addeq r0, r0, #1
	subeq r5, r5, #1
	b end2

.global cmp3
cmp3:
	push {lr}

	cmp r4, r1
	beq U3_equal_A1
	cmp r4, r2
	beq U3_equal_A2
	cmp r4, r3
	addeq r0, r0, #1
end3:
	pop {lr}
	bx lr
U3_equal_A2:
	add r5, r5, #1
	cmp r2, r3
	addeq r0, r0, #1
	subeq r5, r5, #1
	b end3
U3_equal_A1:
	add r5, r5, #1
	cmp r1, r3
	addeq r0, r0, #1
	subeq r5, r5, #1
	b end3


