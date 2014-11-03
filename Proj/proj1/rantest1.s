/* -- randTest1.s */ 
.text

.global rantest1
rantest1:
	push {lr}                 /* Push lr onto the top of the stack */

	mov r0,#0                    /* Set time(0) */
    	bl time                      /* Call time */
	bl srand                     /* Call srand */
	bl rand                      /* Call rand */
	mov r1,r0,ASR #1             /* In case random return is negative */
	mov r2,#7                   /* Move 7 to r2 */
		                         /* We want rand()%7 so cal divMod with rand()%7 */
	bl divMod                    /* Call divMod function to get remainder */

	pop {lr}                     /* Pop the top of the stack and put it in lr */
    	bx lr                        /* Leave main */

@address_of_message: .word message

/*External Functions*/
.global time
.global srand
.global rand

