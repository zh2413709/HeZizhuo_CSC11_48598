/* -- randTest3.s */

.text

.global rantest3
rantest3:
    push {lr}                 /* Push lr onto the top of the stack */

        mov r0,#0                    /* Set time(0) */
        bl time                      /* Call time */
        bl srand                     /* Call srand */
        bl rand                      /* Call rand */
        mov r1,r0,ASR #1             /* In case random return is negative */
	mov r3, #7 		     /* move r3 number 7 */
	mul r1, r1, r3 	 	     /* mult r1 by 7 so that r1 will be different from rantest1 and rantest2 in order to avoid generating the same number */
        mov r2,#7                   /* Move 7 to r2 */
                                         /* We want rand()%7 so cal divMod with rand()%7 */
        bl divMod                    /* Call divMod function to get remainder */
        pop {lr}                     /* Pop the top of the stack and put it in lr */
        bx lr                        /* Leave main */

/*External Functions*/
.global time
.global srand
.global rand

