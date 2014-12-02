.data
iHalf : .word 1 @ 1 bit, >>1
iRho : .word 0x9b5 @12 bits, >>20
iVel : .word 200 @ 8bits
iPi : .word 0x3243f7 @ 24 bits, >>20
iRad : .word 6 @ 4 bits
iConv : .word 0x1c7 @12 bits, >>16
iCd : .word 0x666 @12 bits, >>12

iDynp : .word 0 @Dynamic Pressure
iArea : .word 0 @ Area
iDrag : .word 0 @ Drag

msg : .asciz "Integer Dynamic Pressure = %d lbs\nCross Sectional Area x32 = %d ft^2\nInteger Drag x 32 = %d lbs\n"
.text
.global main
main:
	push {lr}

	/* set up loop */
	mov r6, #1
	ldr r7, =15000000
loop:
	ldr r0, addr_of_iHalf
	ldr r1, [r0]
	ldr r0, addr_of_iRho
	ldr r2, [r0]
	ldr r0, addr_of_iVel
	ldr r3, [r0]
	mul r4, r1, r2 @iDynp=iRho*iHalf; xBit 12, BP-21
	mul r4, r3, r4 @iDynp*=iVel; xBit 20, BP-21
	mul r4, r3, r4 @iDynp*=iVel; xBit 20, BP-21
	mov r4, r4, lsr #12 @iDynp>>=12;  xBit 16, BP- 9
	ldr r0, addr_of_iDynp
	str r4, [r0]

	ldr r0, addr_of_iPi
	ldr r1, [r0] @ Pi
	ldr r0, addr_of_iRad
	ldr r2, [r0] @ Radius
	ldr r0, addr_of_iConv
	ldr r3, [r0]
	mul r4, r1, r2 @iArea*=iRad; xBit 28, BP-20
	mul r4, r2, r4 @iArea*=iRad; xBit 32, BP-20
	mov r4, r4, lsr #12 @iArea>>=12;  xBit 20, BP- 8
	mul r4, r3, r4 @iArea*=iConv; xBit 32, BP-24
	mov r4, r4, lsr #16 @iArea>>=16;  xBit 16  BP- 8
	ldr r0, addr_of_iArea
	str r4, [r0]

	ldr r0, addr_of_iDynp
	ldr r1, [r0] @Dynp
	ldr r0, addr_of_iArea
	ldr r2, [r0] @Area
	ldr r0, addr_of_iCd
	ldr r3, [r0] @Cd
	mul r4, r1, r2 @iDrag=iDynp*iArea; xBit 32 BP-17
	mov r4, r4, lsr #12 @iDrag>>=12; xBit 20  BP- 5
	mul r4, r3, r4 @iDrag*=iCd;  xBit 32  BP-17
	ldr r0, addr_of_iDrag
	str r4, [r0]

	cmp r7, r6
	bgt scale


	ldr r0, addr_of_iDynp
	ldr r1, [r0]
	ldr r0, addr_of_iArea
	ldr r2, [r0]
	ldr r0, addr_of_iDrag
	ldr r3, [r0]
	ldr r0, addr_of_msg
	mov r1, r1, lsr #9
	mov r2, r2, lsr #3
	mov r3, r3, lsr #12
	bl printf

	pop {lr}
	bx lr
scale:
	add r6, r6, #1
	b loop

addr_of_iHalf : .word iHalf
addr_of_iRho : .word iRho
addr_of_iVel : .word iVel
addr_of_iPi : .word iPi
addr_of_iRad : .word iRad
addr_of_iConv : .word iConv
addr_of_iCd : .word iCd
addr_of_iDynp : .word iDynp
addr_of_iArea : .word iArea
addr_of_iDrag : .word iDrag
addr_of_msg : .word msg
.global printf
