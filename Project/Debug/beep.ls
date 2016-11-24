   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.8 - 03 Dec 2008
2820                     	switch	.data
2821  0000               _flagBeep:
2822  0000 00            	dc.b	0
2853                     ; 11 void InitBeep(void)
2853                     ; 12 {
2855                     	switch	.text
2856  0000               _InitBeep:
2860                     ; 14 	PD_DDR |= (u8)1<<4;
2862  0000 72185011      	bset	_PD_DDR,#4
2863                     ; 15 	PD_CR1 |= (u8)1<<4;
2865  0004 72185012      	bset	_PD_CR1,#4
2866                     ; 16 }
2869  0008 81            	ret
2872                     	bsct
2873  0000               _indexTestBeep:
2874  0000 00            	dc.b	0
2898                     ; 18 void TestBeep(void)
2898                     ; 19 {
2899                     	switch	.text
2900  0009               _TestBeep:
2904  0009               L1302:
2905                     ; 24 		buzzcon();
2907  0009 ad33          	call	_buzzcon
2909                     ; 25 		if(indexTestBeep)
2911  000b 3d00          	tnz	_indexTestBeep
2912  000d 27fa          	jreq	L1302
2913                     ; 27 			Beep(indexTestBeep);
2915  000f b600          	ld	a,_indexTestBeep
2916  0011 ad23          	call	_Beep
2918                     ; 28 			indexTestBeep=0;
2920  0013 3f00          	clr	_indexTestBeep
2921  0015 20f2          	jra	L1302
2946                     ; 35 void BeepInISR(void)
2946                     ; 36 {
2947                     	switch	.text
2948  0017               _BeepInISR:
2952                     ; 38 	if(flagBeep)
2954  0017 725d0000      	tnz	_flagBeep
2955  001b 270a          	jreq	L7402
2956                     ; 40 		PD_ODR ^=1<<4;
2958  001d c6500f        	ld	a,_PD_ODR
2959  0020 a810          	xor	a,	#16
2960  0022 c7500f        	ld	_PD_ODR,a
2962  0025 2004          	jra	L1502
2963  0027               L7402:
2964                     ; 44 		PD_ODR &=(~(1<<4));
2966  0027 7219500f      	bres	_PD_ODR,#4
2967  002b               L1502:
2968                     ; 46 }
2971  002b 81            	ret
2995                     ; 48 void	Beep2KOn(void)//使用定时器驱动.	//BEEP_ON;使用电平驱动,
2995                     ; 49 {//
2996                     	switch	.text
2997  002c               _Beep2KOn:
3001                     ; 51 	flagBeep=1;
3003  002c 35010000      	mov	_flagBeep,#1
3004                     ; 53 }
3007  0030 81            	ret
3031                     ; 54 void	Beep2KOff(void)//使用定时器驱动.	//BEEP_OFF;;使用电平驱动,
3031                     ; 55 {
3032                     	switch	.text
3033  0031               _Beep2KOff:
3037                     ; 57 	flagBeep=0;
3039  0031 725f0000      	clr	_flagBeep
3040                     ; 59 }
3043  0035 81            	ret
3079                     ; 60 void Beep(uchar beepm)
3079                     ; 61 {
3080                     	switch	.text
3081  0036               _Beep:
3085                     ; 62 	beepmode=beepm;
3087  0036 c7000a        	ld	_beepmode,a
3088                     ; 63 	beep_request=1;
3090  0039 35010000      	mov	_beep_request,#1
3091                     ; 64 }
3094  003d 81            	ret
3126                     ; 75 void buzzcon(void)
3126                     ; 76 {
3127                     	switch	.text
3128  003e               _buzzcon:
3132                     ; 77 	if (beep_request)
3134  003e 725d0000      	tnz	_beep_request
3135  0042 275d          	jreq	L1312
3136                     ; 79 		beep_request=0;
3138  0044 725f0000      	clr	_beep_request
3139                     ; 80 		switch (beepmode)
3141  0048 c6000a        	ld	a,_beepmode
3143                     ; 146 				beep_number=0;
3144  004b 4d            	tnz	a
3145  004c 2741          	jreq	L7112
3146  004e 4a            	dec	a
3147  004f 2708          	jreq	L1112
3148  0051 4a            	dec	a
3149  0052 2717          	jreq	L3112
3150  0054 4a            	dec	a
3151  0055 2726          	jreq	L5112
3152  0057 2036          	jra	L7112
3153  0059               L1112:
3154                     ; 82 			case BEEP_KEY:
3154                     ; 83 				beep_on_cnt_setting		= BEEP_KEY_ON_CNT*4;
3156  0059 ae0014        	ldw	x,#20
3157  005c cf0004        	ldw	_beep_on_cnt_setting,x
3158                     ; 84 				beep_off_cnt_setting	= BEEP_KEY_OFF_CNT*4;
3160  005f ae0014        	ldw	x,#20
3161  0062 cf0002        	ldw	_beep_off_cnt_setting,x
3162                     ; 85 				beep_number				= BEEP_KEY_NUMBER;				
3164  0065 725f0001      	clr	_beep_number
3165                     ; 86 				break;
3167  0069 2030          	jra	L5312
3168  006b               L3112:
3169                     ; 88 			case BEEP_STOP:
3169                     ; 89 				beep_on_cnt_setting	 	= BEEP_STOP_OFF_ON_CNT*4;
3171  006b ae0018        	ldw	x,#24
3172  006e cf0004        	ldw	_beep_on_cnt_setting,x
3173                     ; 90 				beep_off_cnt_setting 	= BEEP_STOP_OFF_OFF_CNT*4;
3175  0071 ae0140        	ldw	x,#320
3176  0074 cf0002        	ldw	_beep_off_cnt_setting,x
3177                     ; 91 				beep_number			 	= BEEP_STOP_OFF_NUMBER;					
3179  0077 35020001      	mov	_beep_number,#2
3180                     ; 92 				break;
3182  007b 201e          	jra	L5312
3183  007d               L5112:
3184                     ; 94 			case BEEP_FIND_WIRELESS:
3184                     ; 95 				beep_on_cnt_setting		= BEEP_FIND_WIRELESS_OFF_ON_CNT*4;
3186  007d ae0018        	ldw	x,#24
3187  0080 cf0004        	ldw	_beep_on_cnt_setting,x
3188                     ; 96 				beep_off_cnt_setting	= BEEP_FIND_WIRELESS_OFF_OFF_CNT*4;
3190  0083 ae0140        	ldw	x,#320
3191  0086 cf0002        	ldw	_beep_off_cnt_setting,x
3192                     ; 97 				beep_number				= BEEP_FIND_WIRELESS_OFF_NUMBER;					
3194  0089 35010001      	mov	_beep_number,#1
3195                     ; 98 				break;
3197  008d 200c          	jra	L5312
3198  008f               L7112:
3199                     ; 142 			case BEEP_NONE:
3199                     ; 143 			default:			
3199                     ; 144 				beep_on_cnt_setting=0;
3201  008f 5f            	clrw	x
3202  0090 cf0004        	ldw	_beep_on_cnt_setting,x
3203                     ; 145 				beep_off_cnt_setting=0;				
3205  0093 5f            	clrw	x
3206  0094 cf0002        	ldw	_beep_off_cnt_setting,x
3207                     ; 146 				beep_number=0;
3209  0097 725f0001      	clr	_beep_number
3210  009b               L5312:
3211                     ; 148 		beep_on_cnt=beep_on_cnt_setting;			//set the time for first beep on				
3213  009b ce0004        	ldw	x,_beep_on_cnt_setting
3214  009e cf0008        	ldw	_beep_on_cnt,x
3215  00a1               L1312:
3216                     ; 150 	if (beep_on_cnt>0)
3218  00a1 ce0008        	ldw	x,_beep_on_cnt
3219  00a4 2713          	jreq	L7312
3220                     ; 152 		Beep2KOn();//使用定时器驱动.	//BEEP_ON;使用电平驱动,
3222  00a6 ad84          	call	_Beep2KOn
3224                     ; 153 		beep_on_cnt--;	
3226  00a8 ce0008        	ldw	x,_beep_on_cnt
3227  00ab 1d0001        	subw	x,#1
3228  00ae cf0008        	ldw	_beep_on_cnt,x
3229                     ; 154 		beep_off_cnt=beep_off_cnt_setting;
3231  00b1 ce0002        	ldw	x,_beep_off_cnt_setting
3232  00b4 cf0006        	ldw	_beep_off_cnt,x
3234  00b7 202d          	jra	L1412
3235  00b9               L7312:
3236                     ; 158 		Beep2KOff();//使用定时器驱动.	//BEEP_OFF;;使用电平驱动,
3238  00b9 cd0031        	call	_Beep2KOff
3240                     ; 159 		if (beep_number>0)
3242  00bc 725d0001      	tnz	_beep_number
3243  00c0 271c          	jreq	L3412
3244                     ; 161 			if (beep_off_cnt>0)
3246  00c2 ce0006        	ldw	x,_beep_off_cnt
3247  00c5 270b          	jreq	L5412
3248                     ; 163 				beep_off_cnt--;
3250  00c7 ce0006        	ldw	x,_beep_off_cnt
3251  00ca 1d0001        	subw	x,#1
3252  00cd cf0006        	ldw	_beep_off_cnt,x
3254  00d0 2014          	jra	L1412
3255  00d2               L5412:
3256                     ; 167                 beep_number--;		//beep all the time if safty off
3258  00d2 725a0001      	dec	_beep_number
3259                     ; 168 				beep_on_cnt=beep_on_cnt_setting;			//reload on time
3261  00d6 ce0004        	ldw	x,_beep_on_cnt_setting
3262  00d9 cf0008        	ldw	_beep_on_cnt,x
3263  00dc 2008          	jra	L1412
3264  00de               L3412:
3265                     ; 173 			beep_on_cnt=0;
3267  00de 5f            	clrw	x
3268  00df cf0008        	ldw	_beep_on_cnt,x
3269                     ; 174 			beep_off_cnt=0;	
3271  00e2 5f            	clrw	x
3272  00e3 cf0006        	ldw	_beep_off_cnt,x
3273  00e6               L1412:
3274                     ; 177 }
3277  00e6 81            	ret
3375                     	xdef	_indexTestBeep
3376                     	xdef	_flagBeep
3377                     	switch	.bss
3378  0000               _beep_request:
3379  0000 00            	ds.b	1
3380                     	xdef	_beep_request
3381  0001               _beep_number:
3382  0001 00            	ds.b	1
3383                     	xdef	_beep_number
3384  0002               _beep_off_cnt_setting:
3385  0002 0000          	ds.b	2
3386                     	xdef	_beep_off_cnt_setting
3387  0004               _beep_on_cnt_setting:
3388  0004 0000          	ds.b	2
3389                     	xdef	_beep_on_cnt_setting
3390  0006               _beep_off_cnt:
3391  0006 0000          	ds.b	2
3392                     	xdef	_beep_off_cnt
3393  0008               _beep_on_cnt:
3394  0008 0000          	ds.b	2
3395                     	xdef	_beep_on_cnt
3396  000a               _beepmode:
3397  000a 00            	ds.b	1
3398                     	xdef	_beepmode
3399                     	xdef	_buzzcon
3400                     	xdef	_Beep
3401                     	xdef	_Beep2KOff
3402                     	xdef	_Beep2KOn
3403                     	xdef	_BeepInISR
3404                     	xdef	_TestBeep
3405                     	xdef	_InitBeep
3425                     	end
