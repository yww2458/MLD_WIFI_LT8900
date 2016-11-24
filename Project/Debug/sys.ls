   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.8 - 03 Dec 2008
2859                     ; 14 void __WAIT_SYSTEM_STABLE(void)  
2859                     ; 15 {
2861                     	switch	.text
2862  0000               ___WAIT_SYSTEM_STABLE:
2864  0000 89            	pushw	x
2865       00000002      OFST:	set	2
2868                     ; 18 	for (i = 60000 ; i > 0; )
2870  0001 aeea60        	ldw	x,#60000
2871  0004 1f01          	ldw	(OFST-1,sp),x
2872  0006               L7202:
2873                     ; 20 		i--;
2875  0006 1e01          	ldw	x,(OFST-1,sp)
2876  0008 1d0001        	subw	x,#1
2877  000b 1f01          	ldw	(OFST-1,sp),x
2878                     ; 18 	for (i = 60000 ; i > 0; )
2880  000d 1e01          	ldw	x,(OFST-1,sp)
2881  000f 26f5          	jrne	L7202
2882                     ; 22 }
2885  0011 85            	popw	x
2886  0012 81            	ret
2912                     ; 30 void SYS_CLK_INI(void)
2912                     ; 31 {
2913                     	switch	.text
2914  0013               _SYS_CLK_INI:
2918                     ; 32 	CLK_ICKR 	= 0x01;		// HSI enable(default)
2920  0013 350150c0      	mov	_CLK_ICKR,#1
2921                     ; 33 	CLK_SWR 	= 0xE1;		// HSI selected(default)
2923  0017 35e150c4      	mov	_CLK_SWR,#225
2924                     ; 34 	CLK_CKDIVR	= 0x00;		// fHSI = fMASTER = fCPU = 16M
2926  001b 725f50c6      	clr	_CLK_CKDIVR
2927                     ; 35 }
2930  001f 81            	ret
2965                     ; 43 void GPIO_INI(void)
2965                     ; 44 {
2966                     	switch	.text
2967  0020               _GPIO_INI:
2971                     ; 60 	PA_DDR =0x00;
2973  0020 725f5002      	clr	_PA_DDR
2974                     ; 61 	PA_CR1 =0X00;
2976  0024 725f5003      	clr	_PA_CR1
2977                     ; 72 	PB_DDR = 0x00;
2979  0028 725f5007      	clr	_PB_DDR
2980                     ; 73 	PB_CR1 = 0x00;
2982  002c 725f5008      	clr	_PB_CR1
2983                     ; 85 	PC_DDR = 0x00;
2985  0030 725f500c      	clr	_PC_DDR
2986                     ; 86 	PC_CR1 = 0x00;
2988  0034 725f500d      	clr	_PC_CR1
2989                     ; 100 	PD_DDR = 0x3D;
2991  0038 353d5011      	mov	_PD_DDR,#61
2992                     ; 101 	PD_CR1 = 0x3D;
2994  003c 353d5012      	mov	_PD_CR1,#61
2995                     ; 107 	PE_DDR = 0x00; //0000 0111
2997  0040 725f5016      	clr	_PE_DDR
2998                     ; 108 	PE_CR1 = 0x00; //0000 0111
3000  0044 725f5017      	clr	_PE_CR1
3001                     ; 114 	PF_DDR = 0x00;
3003  0048 725f501b      	clr	_PF_DDR
3004                     ; 115 	PF_CR1 = 0x00;
3006  004c 725f501c      	clr	_PF_CR1
3007                     ; 116 }
3010  0050 81            	ret
3037                     ; 119 void  __TIM4_INI(void)
3037                     ; 120 {
3038                     	switch	.text
3039  0051               ___TIM4_INI:
3043                     ; 121 	TIM4_PSCR  = 0x05;			// fTIM4 = fMASTER(16M)/32, T = 2us
3045  0051 35055345      	mov	_TIM4_PSCR,#5
3046                     ; 122 	TIM4_ARR   = TIMER4_CNT;	// T=200us
3048  0055 35635346      	mov	_TIM4_ARR,#99
3049                     ; 123 	TIM4_IER   = 0x01;			// TIM4 interrrupt enable register
3051  0059 35015341      	mov	_TIM4_IER,#1
3052                     ; 124 	TIM4_CR1   = 0x01;			// TIM4 control register
3054  005d 35015340      	mov	_TIM4_CR1,#1
3055                     ; 125 }
3058  0061 81            	ret
3092                     ; 128 void SYS_INI(void)
3092                     ; 129 {
3093                     	switch	.text
3094  0062               _SYS_INI:
3098                     ; 130 	__WAIT_SYSTEM_STABLE();
3100  0062 ad9c          	call	___WAIT_SYSTEM_STABLE
3102                     ; 131 	disableInterrupts();
3105  0064 9b            sim
3107                     ; 132 	SYS_CLK_INI();
3110  0065 adac          	call	_SYS_CLK_INI
3112                     ; 133 	GPIO_INI();
3114  0067 adb7          	call	_GPIO_INI
3116                     ; 134 	UART2_Init();
3118  0069 cd0000        	call	_UART2_Init
3120                     ; 135 	__TIM4_INI();
3122  006c ade3          	call	___TIM4_INI
3124                     ; 136 	Init_LT8900();
3126  006e cd0000        	call	_Init_LT8900
3128                     ; 137 	InitBeep();
3130  0071 cd0000        	call	_InitBeep
3132                     ; 138 	GUART_init();
3134  0074 cd0000        	call	_GUART_init
3136                     ; 139 	delay_init(16);
3138  0077 a610          	ld	a,#16
3139  0079 cd0000        	call	_delay_init
3141                     ; 140 	enableInterrupts();
3144  007c 9a            rim
3146                     ; 141 }
3150  007d 81            	ret
3176                     ; 143 @far @interrupt void TIM4_isr (void)
3176                     ; 144 {
3178                     	switch	.text
3179  007e               f_TIM4_isr:
3181  007e 3b0002        	push	c_x+2
3182  0081 be00          	ldw	x,c_x
3183  0083 89            	pushw	x
3184  0084 3b0002        	push	c_y+2
3185  0087 be00          	ldw	x,c_y
3186  0089 89            	pushw	x
3189                     ; 145 	TIM4_SR &= 0x7E;
3191  008a c65342        	ld	a,_TIM4_SR
3192  008d a47e          	and	a,#126
3193  008f c75342        	ld	_TIM4_SR,a
3194                     ; 147 	if(mTIME.timer_1ms<250)
3196  0092 b603          	ld	a,_mTIME+3
3197  0094 a1fa          	cp	a,#250
3198  0096 2402          	jruge	L5012
3199                     ; 149 		mTIME.timer_1ms++;
3201  0098 3c03          	inc	_mTIME+3
3202  009a               L5012:
3203                     ; 152 	BeepInISR();
3205  009a cd0000        	call	_BeepInISR
3207                     ; 153 }
3210  009d 85            	popw	x
3211  009e bf00          	ldw	c_y,x
3212  00a0 320002        	pop	c_y+2
3213  00a3 85            	popw	x
3214  00a4 bf00          	ldw	c_x,x
3215  00a6 320002        	pop	c_x+2
3216  00a9 80            	iret
3239                     ; 155 void timer_proc(void)
3239                     ; 156 {
3241                     	switch	.text
3242  00aa               _timer_proc:
3246                     ; 157 	if(mTIME.sec>=TIME_BASE_SEC)			//one second base timer //
3248  00aa b604          	ld	a,_mTIME+4
3249  00ac a132          	cp	a,#50
3250  00ae 2504          	jrult	L7112
3251                     ; 159 		mTIME.sec=0;
3253  00b0 3f04          	clr	_mTIME+4
3255  00b2 2002          	jra	L1212
3256  00b4               L7112:
3257                     ; 163 		mTIME.sec++; 
3259  00b4 3c04          	inc	_mTIME+4
3260  00b6               L1212:
3261                     ; 165 }
3264  00b6 81            	ret
3622                     	xdef	f_TIM4_isr
3623                     	xdef	___TIM4_INI
3624                     	xdef	_GPIO_INI
3625                     	xdef	_SYS_CLK_INI
3626                     	xdef	___WAIT_SYSTEM_STABLE
3627                     	xdef	_timer_proc
3628                     	switch	.bss
3629  0000               _mWIFI:
3630  0000 000000000000  	ds.b	8
3631                     	xdef	_mWIFI
3632  0008               _mDEV:
3633  0008 000000000000  	ds.b	23
3634                     	xdef	_mDEV
3635                     	switch	.ubsct
3636  0000               _mTIME:
3637  0000 000000000000  	ds.b	9
3638                     	xdef	_mTIME
3639                     	xdef	_SYS_INI
3640                     	xref	_BeepInISR
3641                     	xref	_InitBeep
3642                     	xref	_Init_LT8900
3643                     	xref	_GUART_init
3644                     	xref	_UART2_Init
3645                     	xref	_delay_init
3646                     	xref.b	c_x
3647                     	xref.b	c_y
3667                     	end
