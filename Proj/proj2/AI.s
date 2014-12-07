/* all of the comparision functions are here */
/* Note that user entered numbers are labled as 'U1' 'U2' 'U3' */
/* Also the generated numbers are labled as 'A1' 'A2' 'A3' */
.text

.global cmp1
cmp1:
	push {lr}

	cmp r4, r1 /* compare if U1 is equal to A1 */
	addeq r0, r0, #1 /* if U1 = A1, RP +1 */
	beq end1 /* then there is nothing more to do */
	cmp r4, r2 /* compare if U1 is equal to A2 */
	addeq r5, r5, #1 /* if U1 = A2, WP + 1 */
	beq end1 /* then there is nothing more to do */
	cmp r4, r3 /* compare if U1 is equal to A3 */
	addeq r5, r5, #1 /* if U1 = A3, WP + 1 */
end1:
	pop {lr}
	bx lr

.global cmp2
cmp2:
	push {lr}

	cmp r4, r1 /* compare if U2 = A1 */
	beq U2_equal_A1 /* if U2 = A1, branch to lable */
	cmp r4, r2 /* compare if U2 = A2 */
	addeq r0, r0, #1 /* if equal RP + 1 */
	beq end2 /* then there is nothing more to do */
	cmp r4, r3 /* compare if U2 = A3 */
	addeq r5, r5, #1 /* if equal WP + 1 */
end2:
	pop {lr}
	bx lr
U2_equal_A1:
	add r5, r5, #1 /* WP + 1 when U2 = A1 */
	cmp r1, r2 /* compare if A1 = A2 */
	addeq r0, r0, #1 /* if equal, that means U1 = A1 = A2, RP +1 */
	subeq r5, r5, #1 /* so, there is no need to add 1 to WP */
	b end2

.global cmp3
cmp3:
	push {lr}

	cmp r4, r1 /* compare if U3 = A1 */
	beq U3_equal_A1 /* if equal, branch to lable */
	cmp r4, r2 /* compare if U3 = A2 */
	beq U3_equal_A2 /* if equal, branch to lable */
	cmp r4, r3 /* compare if U3 = A3 */
	addeq r0, r0, #1 /* if equal, RP + 1 */
end3:
	pop {lr}
	bx lr
U3_equal_A2:
	add r5, r5, #1 /* when U3 = A1, WP + 1 */
	cmp r2, r3 /* compare if A1 = A3 */
	addeq r0, r0, #1 /* if equal, U3 = A1 = A3, RP +1 */
	subeq r5, r5, #1 /* so, there is no need to add 1 to WP */
	b end3
U3_equal_A1:
	add r5, r5, #1 /* when U3 = A2. WP + 1 */
	cmp r2, r3 /* compare if A2 = A3 */ 
	addeq r0, r0, #1 /* if equal, U1 = A2 =A3, RP + 1 */
	subeq r5, r5, #1 /* so, there is no need to add 1 to WP */
	b end3



