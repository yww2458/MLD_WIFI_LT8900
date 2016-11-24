   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.8 - 03 Dec 2008
2820                     .const:	section	.text
2821  0000               _ProdKey:
2822  0000 01            	dc.b	1
2823  0001 33            	dc.b	51
2824  0002 a8            	dc.b	168
2825  0003 21            	dc.b	33
2826  0004 97            	dc.b	151
2827  0005 1b            	dc.b	27
2828  0006 40            	dc.b	64
2829  0007 5e            	dc.b	94
2830  0008 92            	dc.b	146
2831  0009 4f            	dc.b	79
2832  000a 01            	dc.b	1
2833  000b 60            	dc.b	96
2834  000c 4f            	dc.b	79
2835  000d 33            	dc.b	51
2836  000e d7            	dc.b	215
2837  000f c0            	dc.b	192
2870                     ; 41 void UART2_Init(void)
2870                     ; 42 {	
2872                     	switch	.text
2873  0000               _UART2_Init:
2877                     ; 43 	UART2_BRR2 = 0x02;    
2879  0000 35025243      	mov	_UART2_BRR2,#2
2880                     ; 44 	UART2_BRR1 = 0x68;	// 16M 2400  1A0B      
2882  0004 35685242      	mov	_UART2_BRR1,#104
2883                     ; 45 	UART2_CR2  = 0x60;  // 发送，接收中断都使能     
2885  0008 35605245      	mov	_UART2_CR2,#96
2886                     ; 47 	TXEN_FLAG=0;		// txd disable
2888  000c 72175245      	bres	_UART2_CR2,#3
2889                     ; 48 	RXEN_FLAG=1;		// rxd enable
2891  0010 72145245      	bset	_UART2_CR2,#2
2892                     ; 49 	TXD=1;
2894  0014 721a500f      	bset	_PD_ODR,#5
2895                     ; 50 }
2898  0018 81            	ret
2960                     ; 53 static uchar DataBuffCalculate(unsigned char* data)
2960                     ; 54 {
2961                     	switch	.text
2962  0019               L1202_DataBuffCalculate:
2964  0019 89            	pushw	x
2965  001a 5203          	subw	sp,#3
2966       00000003      OFST:	set	3
2969                     ; 57 	unsigned char len = data[1] - 1;
2971  001c e601          	ld	a,(1,x)
2972  001e 4a            	dec	a
2973  001f 6b01          	ld	(OFST-2,sp),a
2974                     ; 58 	temp = 0;
2976  0021 0f02          	clr	(OFST-1,sp)
2977                     ; 59 	for(i = 0;i < len; i++)
2979  0023 0f03          	clr	(OFST+0,sp)
2981  0025 2012          	jra	L1602
2982  0027               L5502:
2983                     ; 61 			temp += data[i];
2985  0027 7b04          	ld	a,(OFST+1,sp)
2986  0029 97            	ld	xl,a
2987  002a 7b05          	ld	a,(OFST+2,sp)
2988  002c 1b03          	add	a,(OFST+0,sp)
2989  002e 2401          	jrnc	L01
2990  0030 5c            	incw	x
2991  0031               L01:
2992  0031 02            	rlwa	x,a
2993  0032 7b02          	ld	a,(OFST-1,sp)
2994  0034 fb            	add	a,(x)
2995  0035 6b02          	ld	(OFST-1,sp),a
2996                     ; 59 	for(i = 0;i < len; i++)
2998  0037 0c03          	inc	(OFST+0,sp)
2999  0039               L1602:
3002  0039 7b03          	ld	a,(OFST+0,sp)
3003  003b 1101          	cp	a,(OFST-2,sp)
3004  003d 25e8          	jrult	L5502
3005                     ; 63 	return temp;
3007  003f 7b02          	ld	a,(OFST-1,sp)
3010  0041 5b05          	addw	sp,#5
3011  0043 81            	ret
3065                     ; 66 static uchar DataBuffCheckIsErr(unsigned char* data)
3065                     ; 67 {
3066                     	switch	.text
3067  0044               L5602_DataBuffCheckIsErr:
3069  0044 89            	pushw	x
3070  0045 89            	pushw	x
3071       00000002      OFST:	set	2
3074                     ; 68 	unsigned char temp = DataBuffCalculate(data);
3076  0046 add1          	call	L1202_DataBuffCalculate
3078  0048 6b01          	ld	(OFST-1,sp),a
3079                     ; 69 	unsigned char len = data[1] - 1;
3081  004a 1e03          	ldw	x,(OFST+1,sp)
3082  004c e601          	ld	a,(1,x)
3083  004e 4a            	dec	a
3084  004f 6b02          	ld	(OFST+0,sp),a
3085                     ; 70 	if(temp == data[len])
3087  0051 7b03          	ld	a,(OFST+1,sp)
3088  0053 97            	ld	xl,a
3089  0054 7b04          	ld	a,(OFST+2,sp)
3090  0056 1b02          	add	a,(OFST+0,sp)
3091  0058 2401          	jrnc	L41
3092  005a 5c            	incw	x
3093  005b               L41:
3094  005b 02            	rlwa	x,a
3095  005c f6            	ld	a,(x)
3096  005d 1101          	cp	a,(OFST-1,sp)
3097  005f 2603          	jrne	L5112
3098                     ; 72 		return 0;
3100  0061 4f            	clr	a
3102  0062 2002          	jra	L61
3103  0064               L5112:
3104                     ; 74 	return 1;
3106  0064 a601          	ld	a,#1
3108  0066               L61:
3110  0066 5b04          	addw	sp,#4
3111  0068 81            	ret
3153                     ; 78 void WIFI_COMMU (void)
3153                     ; 79 {
3154                     	switch	.text
3155  0069               _WIFI_COMMU:
3157  0069 88            	push	a
3158       00000001      OFST:	set	1
3161                     ; 91 	if(mUART.status == UART_STATUS_SEND)
3163  006a c60000        	ld	a,_mUART
3164  006d a101          	cp	a,#1
3165  006f 2703          	jreq	L22
3166  0071 cc0351        	jp	L5222
3167  0074               L22:
3168                     ; 93 		mUART.status = UART_STATUS_RECV;
3170  0074 35020000      	mov	_mUART,#2
3171                     ; 95 		if((mUART.SendRequestBuff&UART_SEND_REQUEST_MODULE_STATUS)==UART_SEND_REQUEST_MODULE_STATUS )
3173  0078 c60025        	ld	a,_mUART+37
3174  007b 97            	ld	xl,a
3175  007c c60026        	ld	a,_mUART+38
3176  007f a401          	and	a,#1
3177  0081 5f            	clrw	x
3178  0082 02            	rlwa	x,a
3179  0083 a30001        	cpw	x,#1
3180  0086 260a          	jrne	L7222
3181                     ; 97 			mUART.SendRequest = UART_SEND_REQUEST_MODULE_STATUS;
3183  0088 ae0001        	ldw	x,#1
3184  008b cf0023        	ldw	_mUART+35,x
3186  008e acb401b4      	jpf	L1322
3187  0092               L7222:
3188                     ; 99 		else if((mUART.SendRequestBuff&UART_SEND_REQUEST_MODULE_REBOOT)==UART_SEND_REQUEST_MODULE_REBOOT )
3190  0092 c60025        	ld	a,_mUART+37
3191  0095 97            	ld	xl,a
3192  0096 c60026        	ld	a,_mUART+38
3193  0099 a402          	and	a,#2
3194  009b 5f            	clrw	x
3195  009c 02            	rlwa	x,a
3196  009d a30002        	cpw	x,#2
3197  00a0 260a          	jrne	L3322
3198                     ; 101 			mUART.SendRequest = UART_SEND_REQUEST_MODULE_REBOOT;
3200  00a2 ae0002        	ldw	x,#2
3201  00a5 cf0023        	ldw	_mUART+35,x
3203  00a8 acb401b4      	jpf	L1322
3204  00ac               L3322:
3205                     ; 103 		else if((mUART.SendRequestBuff&UART_SEND_REQUEST_MODULE_RESET)==UART_SEND_REQUEST_MODULE_RESET )
3207  00ac c60025        	ld	a,_mUART+37
3208  00af 97            	ld	xl,a
3209  00b0 c60026        	ld	a,_mUART+38
3210  00b3 a404          	and	a,#4
3211  00b5 5f            	clrw	x
3212  00b6 02            	rlwa	x,a
3213  00b7 a30004        	cpw	x,#4
3214  00ba 260a          	jrne	L7322
3215                     ; 105 			mUART.SendRequest = UART_SEND_REQUEST_MODULE_RESET;
3217  00bc ae0004        	ldw	x,#4
3218  00bf cf0023        	ldw	_mUART+35,x
3220  00c2 acb401b4      	jpf	L1322
3221  00c6               L7322:
3222                     ; 107 		else if((mUART.SendRequestBuff&UART_SEND_REQUEST_MODULE_CONFIG)==UART_SEND_REQUEST_MODULE_CONFIG )
3224  00c6 c60025        	ld	a,_mUART+37
3225  00c9 97            	ld	xl,a
3226  00ca c60026        	ld	a,_mUART+38
3227  00cd a410          	and	a,#16
3228  00cf 5f            	clrw	x
3229  00d0 02            	rlwa	x,a
3230  00d1 a30010        	cpw	x,#16
3231  00d4 260a          	jrne	L3422
3232                     ; 109 			mUART.SendRequest = UART_SEND_REQUEST_MODULE_CONFIG;
3234  00d6 ae0010        	ldw	x,#16
3235  00d9 cf0023        	ldw	_mUART+35,x
3237  00dc acb401b4      	jpf	L1322
3238  00e0               L3422:
3239                     ; 111 		else if((mUART.SendRequestBuff&UART_SEND_REQUEST_MODULE_SLEEP)==UART_SEND_REQUEST_MODULE_SLEEP )
3241  00e0 c60025        	ld	a,_mUART+37
3242  00e3 97            	ld	xl,a
3243  00e4 c60026        	ld	a,_mUART+38
3244  00e7 a420          	and	a,#32
3245  00e9 5f            	clrw	x
3246  00ea 02            	rlwa	x,a
3247  00eb a30020        	cpw	x,#32
3248  00ee 260a          	jrne	L7422
3249                     ; 113 			mUART.SendRequest = UART_SEND_REQUEST_MODULE_SLEEP;
3251  00f0 ae0020        	ldw	x,#32
3252  00f3 cf0023        	ldw	_mUART+35,x
3254  00f6 acb401b4      	jpf	L1322
3255  00fa               L7422:
3256                     ; 115 		else if((mUART.SendRequestBuff&UART_SEND_REQUEST_MODULE_WAKEUP)==UART_SEND_REQUEST_MODULE_WAKEUP )
3258  00fa c60025        	ld	a,_mUART+37
3259  00fd 97            	ld	xl,a
3260  00fe c60026        	ld	a,_mUART+38
3261  0101 a440          	and	a,#64
3262  0103 5f            	clrw	x
3263  0104 02            	rlwa	x,a
3264  0105 a30040        	cpw	x,#64
3265  0108 260a          	jrne	L3522
3266                     ; 117 			mUART.SendRequest = UART_SEND_REQUEST_MODULE_WAKEUP;
3268  010a ae0040        	ldw	x,#64
3269  010d cf0023        	ldw	_mUART+35,x
3271  0110 acb401b4      	jpf	L1322
3272  0114               L3522:
3273                     ; 119 		else if((mUART.SendRequestBuff&UART_SEND_REQUEST_MODULE_TEST)==UART_SEND_REQUEST_MODULE_TEST )
3275  0114 c60025        	ld	a,_mUART+37
3276  0117 97            	ld	xl,a
3277  0118 c60026        	ld	a,_mUART+38
3278  011b a480          	and	a,#128
3279  011d 5f            	clrw	x
3280  011e 02            	rlwa	x,a
3281  011f a30080        	cpw	x,#128
3282  0122 260a          	jrne	L7522
3283                     ; 121 			mUART.SendRequest = UART_SEND_REQUEST_MODULE_TEST;
3285  0124 ae0080        	ldw	x,#128
3286  0127 cf0023        	ldw	_mUART+35,x
3288  012a acb401b4      	jpf	L1322
3289  012e               L7522:
3290                     ; 123 		else if((mUART.SendRequestBuff&UART_SEND_REQUEST_MODULE_VERSION)==UART_SEND_REQUEST_MODULE_VERSION )
3292  012e c60025        	ld	a,_mUART+37
3293  0131 97            	ld	xl,a
3294  0132 c60026        	ld	a,_mUART+38
3295  0135 9f            	ld	a,xl
3296  0136 a401          	and	a,#1
3297  0138 97            	ld	xl,a
3298  0139 4f            	clr	a
3299  013a 02            	rlwa	x,a
3300  013b a30100        	cpw	x,#256
3301  013e 2608          	jrne	L3622
3302                     ; 125 			mUART.SendRequest = UART_SEND_REQUEST_MODULE_VERSION;
3304  0140 ae0100        	ldw	x,#256
3305  0143 cf0023        	ldw	_mUART+35,x
3307  0146 206c          	jra	L1322
3308  0148               L3622:
3309                     ; 127 		else if((mUART.SendRequestBuff&UART_SEND_MODULE_GET_PRODKEY)==UART_SEND_MODULE_GET_PRODKEY )
3311  0148 c60025        	ld	a,_mUART+37
3312  014b 97            	ld	xl,a
3313  014c c60026        	ld	a,_mUART+38
3314  014f 9f            	ld	a,xl
3315  0150 a402          	and	a,#2
3316  0152 97            	ld	xl,a
3317  0153 4f            	clr	a
3318  0154 02            	rlwa	x,a
3319  0155 a30200        	cpw	x,#512
3320  0158 260a          	jrne	L7622
3321                     ; 130 			mUART.SendRequestBuff &= ~UART_SEND_MODULE_GET_PRODKEY;
3323  015a 72130025      	bres	_mUART+37,#1
3324                     ; 131 			mUART.status = UART_STATUS_RECV;
3326  015e 35020000      	mov	_mUART,#2
3327                     ; 133 			return;
3330  0162 84            	pop	a
3331  0163 81            	ret
3332  0164               L7622:
3333                     ; 135 		else if((mUART.SendRequestBuff&UART_SEND_MODULE_SET_PRODKEY)==UART_SEND_MODULE_SET_PRODKEY )
3335  0164 c60025        	ld	a,_mUART+37
3336  0167 97            	ld	xl,a
3337  0168 c60026        	ld	a,_mUART+38
3338  016b 9f            	ld	a,xl
3339  016c a404          	and	a,#4
3340  016e 97            	ld	xl,a
3341  016f 4f            	clr	a
3342  0170 02            	rlwa	x,a
3343  0171 a30400        	cpw	x,#1024
3344  0174 2608          	jrne	L3722
3345                     ; 137 			mUART.SendRequest = UART_SEND_MODULE_SET_PRODKEY;
3347  0176 ae0400        	ldw	x,#1024
3348  0179 cf0023        	ldw	_mUART+35,x
3350  017c 2036          	jra	L1322
3351  017e               L3722:
3352                     ; 139 		else if((mUART.SendRequestBuff&UART_SEND_UPLOAD_DATA)==UART_SEND_UPLOAD_DATA )
3354  017e c60025        	ld	a,_mUART+37
3355  0181 97            	ld	xl,a
3356  0182 c60026        	ld	a,_mUART+38
3357  0185 9f            	ld	a,xl
3358  0186 a408          	and	a,#8
3359  0188 97            	ld	xl,a
3360  0189 4f            	clr	a
3361  018a 02            	rlwa	x,a
3362  018b a30800        	cpw	x,#2048
3363  018e 260c          	jrne	L7722
3364                     ; 141 			mUART.SendRequest = UART_SEND_UPLOAD_DATA;
3366  0190 ae0800        	ldw	x,#2048
3367  0193 cf0023        	ldw	_mUART+35,x
3368                     ; 142 			mUART.SendRequestBuff  &= ~UART_SEND_UPLOAD_DATA;
3370  0196 72170025      	bres	_mUART+37,#3
3372  019a 2018          	jra	L1322
3373  019c               L7722:
3374                     ; 144 		else if((mUART.SendRequestBuff&UART_SEND_REQUEST_UPDATE_DATE)==UART_SEND_REQUEST_UPDATE_DATE )
3376  019c c60025        	ld	a,_mUART+37
3377  019f 97            	ld	xl,a
3378  01a0 c60026        	ld	a,_mUART+38
3379  01a3 9f            	ld	a,xl
3380  01a4 a410          	and	a,#16
3381  01a6 97            	ld	xl,a
3382  01a7 4f            	clr	a
3383  01a8 02            	rlwa	x,a
3384  01a9 a31000        	cpw	x,#4096
3385  01ac 2666          	jrne	L3032
3386                     ; 146 			mUART.SendRequest = UART_SEND_REQUEST_UPDATE_DATE;
3388  01ae ae1000        	ldw	x,#4096
3389  01b1 cf0023        	ldw	_mUART+35,x
3391  01b4               L1322:
3392                     ; 154 		mUART.SendBuffer[0] = HEKR_FRAME_HEADER;
3394  01b4 35480027      	mov	_mUART+39,#72
3395                     ; 155 		mUART.SendBuffer[3] = mUART.SendIndex++;
3397  01b8 c60047        	ld	a,_mUART+71
3398  01bb 725c0047      	inc	_mUART+71
3399  01bf c7002a        	ld	_mUART+42,a
3400                     ; 156 		switch(mUART.SendRequest)
3402  01c2 ce0023        	ldw	x,_mUART+35
3404                     ; 240 			default:
3404                     ; 241 				break;
3405  01c5 5a            	decw	x
3406  01c6 2752          	jreq	L7112
3407  01c8 5a            	decw	x
3408  01c9 2763          	jreq	L1212
3409  01cb 1d0002        	subw	x,#2
3410  01ce 2772          	jreq	L3212
3411  01d0 1d000c        	subw	x,#12
3412  01d3 2603cc0256    	jreq	L5212
3413  01d8 1d0010        	subw	x,#16
3414  01db 2603          	jrne	L42
3415  01dd cc026a        	jp	L7212
3416  01e0               L42:
3417  01e0 1d0020        	subw	x,#32
3418  01e3 2603          	jrne	L62
3419  01e5 cc027e        	jp	L1312
3420  01e8               L62:
3421  01e8 1d0040        	subw	x,#64
3422  01eb 2603          	jrne	L03
3423  01ed cc0292        	jp	L3312
3424  01f0               L03:
3425  01f0 1d0080        	subw	x,#128
3426  01f3 2603          	jrne	L23
3427  01f5 cc02a6        	jp	L5312
3428  01f8               L23:
3429  01f8 1d0100        	subw	x,#256
3430  01fb 2603          	jrne	L43
3431  01fd cc02b8        	jp	L7312
3432  0200               L43:
3433  0200 1d0200        	subw	x,#512
3434  0203 2603          	jrne	L63
3435  0205 cc02ca        	jp	L1412
3436  0208               L63:
3437  0208 1d0400        	subw	x,#1024
3438  020b 2603          	jrne	L04
3439  020d cc02ec        	jp	L3412
3440  0210               L04:
3441  0210 ac2a032a      	jpf	L1132
3442  0214               L3032:
3443                     ; 150 			mUART.status = UART_STATUS_RECV;
3445  0214 35020000      	mov	_mUART,#2
3446                     ; 151 			return;
3449  0218 84            	pop	a
3450  0219 81            	ret
3451  021a               L7112:
3452                     ; 158 			case UART_SEND_REQUEST_MODULE_STATUS:
3452                     ; 159 				mUART.SendLen = ModuleQueryFrameLength;
3454  021a 35070045      	mov	_mUART+69,#7
3455                     ; 160 				mUART.SendBuffer[2] = ModuleOperationType;
3457  021e 35fe0029      	mov	_mUART+41,#254
3458                     ; 161 				mUART.SendBuffer[4] = Module_Statue;
3460  0222 3501002b      	mov	_mUART+43,#1
3461                     ; 162 				mUART.SendBuffer[5] = 0x00;
3463  0226 725f002c      	clr	_mUART+44
3464                     ; 163 				break;
3466  022a ac2a032a      	jpf	L1132
3467  022e               L1212:
3468                     ; 164 			case UART_SEND_REQUEST_MODULE_REBOOT:
3468                     ; 165 				mUART.SendLen = ModuleQueryFrameLength;
3470  022e 35070045      	mov	_mUART+69,#7
3471                     ; 166 				mUART.SendBuffer[2] = ModuleOperationType;
3473  0232 35fe0029      	mov	_mUART+41,#254
3474                     ; 167 				mUART.SendBuffer[4] = Module_Soft_Reboot;
3476  0236 3502002b      	mov	_mUART+43,#2
3477                     ; 168 				mUART.SendBuffer[5] = 0x00;
3479  023a 725f002c      	clr	_mUART+44
3480                     ; 169 				break;
3482  023e ac2a032a      	jpf	L1132
3483  0242               L3212:
3484                     ; 170 			case UART_SEND_REQUEST_MODULE_RESET:
3484                     ; 171 				mUART.SendLen = ModuleQueryFrameLength;
3486  0242 35070045      	mov	_mUART+69,#7
3487                     ; 172 				mUART.SendBuffer[2] = ModuleOperationType;
3489  0246 35fe0029      	mov	_mUART+41,#254
3490                     ; 173 				mUART.SendBuffer[4] = Module_Factory_Reset;
3492  024a 3503002b      	mov	_mUART+43,#3
3493                     ; 174 				mUART.SendBuffer[5] = 0x00;
3495  024e 725f002c      	clr	_mUART+44
3496                     ; 175 				break;
3498  0252 ac2a032a      	jpf	L1132
3499  0256               L5212:
3500                     ; 176 			case UART_SEND_REQUEST_MODULE_CONFIG:
3500                     ; 177 				mUART.SendLen = ModuleQueryFrameLength;
3502  0256 35070045      	mov	_mUART+69,#7
3503                     ; 178 				mUART.SendBuffer[2] = ModuleOperationType;
3505  025a 35fe0029      	mov	_mUART+41,#254
3506                     ; 179 				mUART.SendBuffer[4] = Hekr_Config;
3508  025e 3504002b      	mov	_mUART+43,#4
3509                     ; 180 				mUART.SendBuffer[5] = 0x00;
3511  0262 725f002c      	clr	_mUART+44
3512                     ; 181 				break;
3514  0266 ac2a032a      	jpf	L1132
3515  026a               L7212:
3516                     ; 182 			case UART_SEND_REQUEST_MODULE_SLEEP:
3516                     ; 183 				mUART.SendLen = ModuleQueryFrameLength;
3518  026a 35070045      	mov	_mUART+69,#7
3519                     ; 184 				mUART.SendBuffer[2] = ModuleOperationType;
3521  026e 35fe0029      	mov	_mUART+41,#254
3522                     ; 185 				mUART.SendBuffer[4] = Module_Set_Sleep;
3524  0272 3505002b      	mov	_mUART+43,#5
3525                     ; 186 				mUART.SendBuffer[5] = 0x00;
3527  0276 725f002c      	clr	_mUART+44
3528                     ; 187 				break;
3530  027a ac2a032a      	jpf	L1132
3531  027e               L1312:
3532                     ; 188 			case UART_SEND_REQUEST_MODULE_WAKEUP:
3532                     ; 189 				mUART.SendLen = ModuleQueryFrameLength;
3534  027e 35070045      	mov	_mUART+69,#7
3535                     ; 190 				mUART.SendBuffer[2] = ModuleOperationType;
3537  0282 35fe0029      	mov	_mUART+41,#254
3538                     ; 191 				mUART.SendBuffer[4] = Module_Weakup;
3540  0286 3506002b      	mov	_mUART+43,#6
3541                     ; 192 				mUART.SendBuffer[5] = 0x00;
3543  028a 725f002c      	clr	_mUART+44
3544                     ; 193 				break;
3546  028e ac2a032a      	jpf	L1132
3547  0292               L3312:
3548                     ; 194 			case UART_SEND_REQUEST_MODULE_TEST:
3548                     ; 195 				mUART.SendLen = ModuleQueryFrameLength;
3550  0292 35070045      	mov	_mUART+69,#7
3551                     ; 196 				mUART.SendBuffer[2] = ModuleOperationType;
3553  0296 35fe0029      	mov	_mUART+41,#254
3554                     ; 197 				mUART.SendBuffer[4] = Module_Factory_Test;
3556  029a 3520002b      	mov	_mUART+43,#32
3557                     ; 198 				mUART.SendBuffer[5] = 0x00;
3559  029e 725f002c      	clr	_mUART+44
3560                     ; 199 				break;
3562  02a2 ac2a032a      	jpf	L1132
3563  02a6               L5312:
3564                     ; 200 			case UART_SEND_REQUEST_MODULE_VERSION:
3564                     ; 201 				mUART.SendLen = ModuleQueryFrameLength;
3566  02a6 35070045      	mov	_mUART+69,#7
3567                     ; 202 				mUART.SendBuffer[2] = ModuleOperationType;
3569  02aa 35fe0029      	mov	_mUART+41,#254
3570                     ; 203 				mUART.SendBuffer[4] = Module_Firmware_Versions;
3572  02ae 3510002b      	mov	_mUART+43,#16
3573                     ; 204 				mUART.SendBuffer[5] = 0x00;
3575  02b2 725f002c      	clr	_mUART+44
3576                     ; 205 				break;
3578  02b6 2072          	jra	L1132
3579  02b8               L7312:
3580                     ; 206 			case UART_SEND_MODULE_GET_PRODKEY:
3580                     ; 207 				mUART.SendLen = ModuleQueryFrameLength;
3582  02b8 35070045      	mov	_mUART+69,#7
3583                     ; 208 				mUART.SendBuffer[2] = ModuleOperationType;
3585  02bc 35fe0029      	mov	_mUART+41,#254
3586                     ; 209 				mUART.SendBuffer[4] = Module_ProdKey_Get;
3588  02c0 3511002b      	mov	_mUART+43,#17
3589                     ; 210 				mUART.SendBuffer[5] = 0x00;
3591  02c4 725f002c      	clr	_mUART+44
3592                     ; 211 				break;
3594  02c8 2060          	jra	L1132
3595  02ca               L1412:
3596                     ; 212 			case UART_SEND_MODULE_SET_PRODKEY:
3596                     ; 213 				mUART.SendLen = ProdKeyLenth;
3598  02ca 35160045      	mov	_mUART+69,#22
3599                     ; 214 				mUART.SendBuffer[2] = ModuleOperationType;
3601  02ce 35fe0029      	mov	_mUART+41,#254
3602                     ; 215 				mUART.SendBuffer[4] = Module_Set_ProdKey;
3604  02d2 3521002b      	mov	_mUART+43,#33
3605                     ; 216 				for(temp8 = 0; temp8 < 16; temp8++)
3607  02d6 0f01          	clr	(OFST+0,sp)
3608  02d8               L3132:
3609                     ; 218 					mUART.SendBuffer[5+temp8] = ProdKey[temp8];
3611  02d8 7b01          	ld	a,(OFST+0,sp)
3612  02da 5f            	clrw	x
3613  02db 97            	ld	xl,a
3614  02dc d60000        	ld	a,(_ProdKey,x)
3615  02df d7002c        	ld	(_mUART+44,x),a
3616                     ; 216 				for(temp8 = 0; temp8 < 16; temp8++)
3618  02e2 0c01          	inc	(OFST+0,sp)
3621  02e4 7b01          	ld	a,(OFST+0,sp)
3622  02e6 a110          	cp	a,#16
3623  02e8 25ee          	jrult	L3132
3624                     ; 220 				break;
3626  02ea 203e          	jra	L1132
3627  02ec               L3412:
3628                     ; 221 			case UART_SEND_UPLOAD_DATA:
3628                     ; 222 				mUART.SendLen = UpdateDataLenth;
3630  02ec 35110045      	mov	_mUART+69,#17
3631                     ; 223 				mUART.SendBuffer[2] = DeviceUploadType;
3633  02f0 35010029      	mov	_mUART+41,#1
3634                     ; 225 				mUART.SendBuffer[5] = 0x04;
3636  02f4 3504002c      	mov	_mUART+44,#4
3637                     ; 226 				mUART.SendBuffer[6] = mDEV.status;
3639  02f8 550000002d    	mov	_mUART+45,_mDEV
3640                     ; 227 				mUART.SendBuffer[7] = (uchar)(mDEV.HZ>>8);
3642  02fd 550001002e    	mov	_mUART+46,_mDEV+1
3643                     ; 228 				mUART.SendBuffer[8] = (uchar)mDEV.HZ;
3645  0302 550002002f    	mov	_mUART+47,_mDEV+2
3646                     ; 229 				mUART.SendBuffer[9] = (uchar)(mDEV.rpm>>8);
3648  0307 5500050030    	mov	_mUART+48,_mDEV+5
3649                     ; 230 				mUART.SendBuffer[10]= (uchar)mDEV.rpm;
3651  030c 5500060031    	mov	_mUART+49,_mDEV+6
3652                     ; 231 				mUART.SendBuffer[11]= mDEV.error_code;
3654  0311 5500070032    	mov	_mUART+50,_mDEV+7
3655                     ; 232 				mUART.SendBuffer[12]= mUART.SendBuffer[12]; // 预留
3657  0316 c60033        	ld	a,_mUART+51
3658  0319 97            	ld	xl,a
3659                     ; 233 				mUART.SendBuffer[13]= mUART.SendBuffer[13]; // 预留
3661  031a c60034        	ld	a,_mUART+52
3662  031d 97            	ld	xl,a
3663                     ; 234 				mUART.SendBuffer[14]= mUART.SendBuffer[14]; // 预留
3665  031e c60035        	ld	a,_mUART+53
3666  0321 97            	ld	xl,a
3667                     ; 235 				mUART.SendBuffer[15]= mUART.SendBuffer[15]; // 预留
3669  0322 c60036        	ld	a,_mUART+54
3670  0325 97            	ld	xl,a
3671                     ; 236 				mUART.SendBuffer[16]= mUART.SendBuffer[16]; // 预留
3673  0326 c60037        	ld	a,_mUART+55
3674  0329 97            	ld	xl,a
3675                     ; 237 				break;
3677  032a               L5412:
3678                     ; 238 			case UART_SEND_REQUEST_UPDATE_DATE:
3678                     ; 239 				break;
3680  032a               L7412:
3681                     ; 240 			default:
3681                     ; 241 				break;
3683  032a               L1132:
3684                     ; 244 		mUART.SendBuffer[1] = mUART.SendLen;
3686  032a 5500450028    	mov	_mUART+40,_mUART+69
3687                     ; 245 		mUART.SendBuffer[mUART.SendLen-1]= DataBuffCalculate(mUART.SendBuffer);
3689  032f c60045        	ld	a,_mUART+69
3690  0332 5f            	clrw	x
3691  0333 97            	ld	xl,a
3692  0334 5a            	decw	x
3693  0335 89            	pushw	x
3694  0336 ae0027        	ldw	x,#_mUART+39
3695  0339 cd0019        	call	L1202_DataBuffCalculate
3697  033c 85            	popw	x
3698  033d d70027        	ld	(_mUART+39,x),a
3699                     ; 247 		TXEN_FLAG=1;	//txd enable
3701  0340 72165245      	bset	_UART2_CR2,#3
3702                     ; 248 		UART2_DR=mUART.SendBuffer[0];
3704  0344 5500275241    	mov	_UART2_DR,_mUART+39
3705                     ; 249 		mUART.pccom_cnt = 0;
3707  0349 725f004b      	clr	_mUART+75
3709  034d ac640464      	jpf	L1232
3710  0351               L5222:
3711                     ; 251 	else if(mUART.status == UART_STATUS_RECV)
3713  0351 c60000        	ld	a,_mUART
3714  0354 a102          	cp	a,#2
3715  0356 2703          	jreq	L24
3716  0358 cc0458        	jp	L3232
3717  035b               L24:
3718                     ; 253 		if(mUART.RecvFlag)
3720  035b 725d0002      	tnz	_mUART+2
3721  035f 2603          	jrne	L44
3722  0361 cc043d        	jp	L5232
3723  0364               L44:
3724                     ; 255 			mUART.RecvFlag  = 0;
3726  0364 725f0002      	clr	_mUART+2
3727                     ; 256 			mUART.pccom_cnt = 0;
3729  0368 725f004b      	clr	_mUART+75
3730                     ; 257 			mUART.RecvCount = 0;
3732  036c 725f0001      	clr	_mUART+1
3733                     ; 258 			mUART.status    = UART_STATUS_SEND;
3735  0370 35010000      	mov	_mUART,#1
3736                     ; 261 			if(DataBuffCheckIsErr(mUART.RecvBuffer))
3738  0374 ae0004        	ldw	x,#_mUART+4
3739  0377 cd0044        	call	L5602_DataBuffCheckIsErr
3741  037a 4d            	tnz	a
3742  037b 2702          	jreq	L7232
3743                     ; 263 				return;  // 校验出错
3746  037d 84            	pop	a
3747  037e 81            	ret
3748  037f               L7232:
3749                     ; 266 			mUART.RecvFrameType = mUART.RecvBuffer[2];
3751  037f 5500060022    	mov	_mUART+34,_mUART+6
3752                     ; 267 			switch(mUART.RecvFrameType)
3754  0384 c60022        	ld	a,_mUART+34
3756                     ; 366 				default:
3756                     ; 367 					break;
3757  0387 a002          	sub	a,#2
3758  0389 2712          	jreq	L3512
3759  038b a0fc          	sub	a,#252
3760  038d 2716          	jreq	L5512
3761  038f 4a            	dec	a
3762  0390 2603          	jrne	L64
3763  0392 cc0432        	jp	L3022
3764  0395               L64:
3765  0395 ac640464      	jpf	L1232
3766  0399               L1512:
3767                     ; 269 				case DeviceUploadType:
3767                     ; 270 					// nothing to do ....
3767                     ; 271 					break;
3769  0399 ac640464      	jpf	L1232
3770  039d               L3512:
3771                     ; 272 				case ModuleDownloadType:  // 主动下发数据
3771                     ; 273 					mUART.SendRequestBuff |= UART_SEND_UPLOAD_DATA;
3773  039d 72160025      	bset	_mUART+37,#3
3774                     ; 308 					break;
3776  03a1 ac640464      	jpf	L1232
3777  03a5               L5512:
3778                     ; 309 				case ModuleOperationType:
3778                     ; 310 					switch(mUART.RecvBuffer[4])
3780  03a5 c60008        	ld	a,_mUART+8
3782                     ; 359 							break;
3783  03a8 4a            	dec	a
3784  03a9 2721          	jreq	L7512
3785  03ab 4a            	dec	a
3786  03ac 2738          	jreq	L1612
3787  03ae 4a            	dec	a
3788  03af 273b          	jreq	L3612
3789  03b1 4a            	dec	a
3790  03b2 273e          	jreq	L5612
3791  03b4 4a            	dec	a
3792  03b5 2741          	jreq	L7612
3793  03b7 4a            	dec	a
3794  03b8 2744          	jreq	L1712
3795  03ba a00a          	sub	a,#10
3796  03bc 274c          	jreq	L5712
3797  03be 4a            	dec	a
3798  03bf 2763          	jreq	L7712
3799  03c1 a00f          	sub	a,#15
3800  03c3 273f          	jreq	L3712
3801  03c5 4a            	dec	a
3802  03c6 2762          	jreq	L1022
3803  03c8 ac640464      	jpf	L1232
3804  03cc               L7512:
3805                     ; 312 						case Module_Statue:
3805                     ; 313 							mUART.SendRequestBuff  &= ~UART_SEND_REQUEST_MODULE_STATUS;
3807  03cc 72110026      	bres	_mUART+38,#0
3808                     ; 315 							mWIFI.mode           = mUART.RecvBuffer[5];
3810  03d0 5500090000    	mov	_mWIFI,_mUART+9
3811                     ; 316 							mWIFI.WIFI_status    = mUART.RecvBuffer[6];
3813  03d5 55000a0001    	mov	_mWIFI+1,_mUART+10
3814                     ; 317 							mWIFI.CloudStatus    = mUART.RecvBuffer[7];
3816  03da 55000b0002    	mov	_mWIFI+2,_mUART+11
3817                     ; 318 							mWIFI.SignalStrength = mUART.RecvBuffer[8];
3819  03df 55000c0003    	mov	_mWIFI+3,_mUART+12
3820                     ; 328 							break;
3822  03e4 207e          	jra	L1232
3823  03e6               L1612:
3824                     ; 329 						case Module_Soft_Reboot:
3824                     ; 330 							mUART.SendRequestBuff  &= ~UART_SEND_REQUEST_MODULE_REBOOT;
3826  03e6 72130026      	bres	_mUART+38,#1
3827                     ; 331 							break;
3829  03ea 2078          	jra	L1232
3830  03ec               L3612:
3831                     ; 332 						case Module_Factory_Reset:
3831                     ; 333 							mUART.SendRequestBuff  &= ~UART_SEND_REQUEST_MODULE_RESET;
3833  03ec 72150026      	bres	_mUART+38,#2
3834                     ; 334 							break;
3836  03f0 2072          	jra	L1232
3837  03f2               L5612:
3838                     ; 335 						case Hekr_Config:
3838                     ; 336 							mUART.SendRequestBuff  &= ~UART_SEND_REQUEST_MODULE_CONFIG;
3840  03f2 72190026      	bres	_mUART+38,#4
3841                     ; 337 							break;
3843  03f6 206c          	jra	L1232
3844  03f8               L7612:
3845                     ; 338 						case Module_Set_Sleep:
3845                     ; 339 							mUART.SendRequestBuff  &= ~UART_SEND_REQUEST_MODULE_SLEEP;
3847  03f8 721b0026      	bres	_mUART+38,#5
3848                     ; 340 							break;
3850  03fc 2066          	jra	L1232
3851  03fe               L1712:
3852                     ; 341 						case Module_Weakup:
3852                     ; 342 							mUART.SendRequestBuff  &= ~UART_SEND_REQUEST_MODULE_WAKEUP;
3854  03fe 721d0026      	bres	_mUART+38,#6
3855                     ; 343 							break;
3857  0402 2060          	jra	L1232
3858  0404               L3712:
3859                     ; 344 						case Module_Factory_Test:
3859                     ; 345 							mUART.SendRequestBuff  &= ~UART_SEND_REQUEST_MODULE_TEST;
3861  0404 721f0026      	bres	_mUART+38,#7
3862                     ; 346 							break;
3864  0408 205a          	jra	L1232
3865  040a               L5712:
3866                     ; 347 						case Module_Firmware_Versions:
3866                     ; 348 							mUART.SendRequestBuff  &= ~UART_SEND_REQUEST_MODULE_VERSION;
3868  040a 72110025      	bres	_mUART+37,#0
3869                     ; 349 							mWIFI.version_main  = mUART.RecvBuffer[5];
3871  040e 5500090004    	mov	_mWIFI+4,_mUART+9
3872                     ; 350 							mWIFI.version_minor = mUART.RecvBuffer[6];
3874  0413 55000a0005    	mov	_mWIFI+5,_mUART+10
3875                     ; 351 							mWIFI.version_debug = mUART.RecvBuffer[7];
3877  0418 55000b0006    	mov	_mWIFI+6,_mUART+11
3878                     ; 352 							mWIFI.version_type  = mUART.RecvBuffer[8];
3880  041d 55000c0007    	mov	_mWIFI+7,_mUART+12
3881                     ; 353 							break;
3883  0422 2040          	jra	L1232
3884  0424               L7712:
3885                     ; 354 						case Module_ProdKey_Get:
3885                     ; 355 							mUART.SendRequestBuff  &= ~UART_SEND_MODULE_GET_PRODKEY;
3887  0424 72130025      	bres	_mUART+37,#1
3888                     ; 356 							break;
3890  0428 203a          	jra	L1232
3891  042a               L1022:
3892                     ; 357 						case Module_Set_ProdKey:
3892                     ; 358 							mUART.SendRequestBuff  &= ~UART_SEND_MODULE_SET_PRODKEY;
3894  042a 72150025      	bres	_mUART+37,#2
3895                     ; 359 							break;
3897  042e 2034          	jra	L1232
3898  0430               L7332:
3899                     ; 361 					break;
3901  0430 2032          	jra	L1232
3902  0432               L3022:
3903                     ; 362 				case ErrorFrameType:
3903                     ; 363 					mUART.error_code = mUART.RecvBuffer[4];
3905  0432 5500080049    	mov	_mUART+73,_mUART+8
3906                     ; 365 					break;
3908  0437 202b          	jra	L1232
3909  0439               L5022:
3910                     ; 366 				default:
3910                     ; 367 					break;
3912  0439 2029          	jra	L1232
3913  043b               L3332:
3915  043b 2027          	jra	L1232
3916  043d               L5232:
3917                     ; 372 			if(mUART.pccom_cnt >= WAIT_FEEDBACK_TIME)
3919  043d c6004b        	ld	a,_mUART+75
3920  0440 a119          	cp	a,#25
3921  0442 250e          	jrult	L3432
3922                     ; 374 				mUART.pccom_cnt = 0;
3924  0444 725f004b      	clr	_mUART+75
3925                     ; 375 				mUART.RecvCount = 0;
3927  0448 725f0001      	clr	_mUART+1
3928                     ; 376 				mUART.status = UART_STATUS_SEND;
3930  044c 35010000      	mov	_mUART,#1
3932  0450 2012          	jra	L1232
3933  0452               L3432:
3934                     ; 380 				mUART.pccom_cnt++;
3936  0452 725c004b      	inc	_mUART+75
3937  0456 200c          	jra	L1232
3938  0458               L3232:
3939                     ; 386 		mUART.status = UART_STATUS_SEND;
3941  0458 35010000      	mov	_mUART,#1
3942                     ; 387 		mUART.SendRequestBuff |= UART_SEND_REQUEST_MODULE_STATUS;
3944  045c 72100026      	bset	_mUART+38,#0
3945                     ; 388 		mUART.SendRequestBuff |= UART_SEND_MODULE_SET_PRODKEY;
3947  0460 72140025      	bset	_mUART+37,#2
3948  0464               L1232:
3949                     ; 390 }
3952  0464 84            	pop	a
3953  0465 81            	ret
3981                     ; 393 @far @interrupt void UART2_Send_IRQHandler(void)
3981                     ; 394 {
3983                     	switch	.text
3984  0466               f_UART2_Send_IRQHandler:
3988                     ; 396 	if (mUART.SendCount < mUART.SendLen)
3990  0466 c60046        	ld	a,_mUART+70
3991  0469 c10045        	cp	a,_mUART+69
3992  046c 2411          	jruge	L1632
3993                     ; 398 		mUART.SendCount++;
3995  046e 725c0046      	inc	_mUART+70
3996                     ; 399 		UART2_DR=mUART.SendBuffer[mUART.SendCount];
3998  0472 c60046        	ld	a,_mUART+70
3999  0475 5f            	clrw	x
4000  0476 97            	ld	xl,a
4001  0477 d60027        	ld	a,(_mUART+39,x)
4002  047a c75241        	ld	_UART2_DR,a
4004  047d 2008          	jra	L3632
4005  047f               L1632:
4006                     ; 403 		mUART.SendCount=0;	
4008  047f 725f0046      	clr	_mUART+70
4009                     ; 404 		TXEN_FLAG=0;	//txd disable
4011  0483 72175245      	bres	_UART2_CR2,#3
4012  0487               L3632:
4013                     ; 406 	TC_FLAG=0;
4015  0487 721d5240      	bres	_UART2_SR,#6
4016                     ; 408 	return;
4019  048b 80            	iret
4056                     ; 412 @far @interrupt void UART2_Recv_IRQHandler(void)
4056                     ; 413 {
4057                     	switch	.text
4058  048c               f_UART2_Recv_IRQHandler:
4060       00000001      OFST:	set	1
4061  048c 88            	push	a
4064                     ; 416 	ch = UART2_DR;
4066  048d c65241        	ld	a,_UART2_DR
4067  0490 6b01          	ld	(OFST+0,sp),a
4068                     ; 418 	if(mUART.RecvCount == 0)
4070  0492 725d0001      	tnz	_mUART+1
4071  0496 261c          	jrne	L3042
4072                     ; 420 		if(ch == HEKR_FRAME_HEADER)
4074  0498 7b01          	ld	a,(OFST+0,sp)
4075  049a a148          	cp	a,#72
4076  049c 2610          	jrne	L5042
4077                     ; 422 			mUART.RecvBuffer[mUART.RecvCount] = ch;
4079  049e c60001        	ld	a,_mUART+1
4080  04a1 5f            	clrw	x
4081  04a2 97            	ld	xl,a
4082  04a3 7b01          	ld	a,(OFST+0,sp)
4083  04a5 d70004        	ld	(_mUART+4,x),a
4084                     ; 423 			mUART.RecvCount++;
4086  04a8 725c0001      	inc	_mUART+1
4088  04ac 2058          	jra	L1142
4089  04ae               L5042:
4090                     ; 427 			mUART.RecvCount = 0;
4092  04ae 725f0001      	clr	_mUART+1
4093  04b2 2052          	jra	L1142
4094  04b4               L3042:
4095                     ; 430 	else if (mUART.RecvCount == 1)
4097  04b4 c60001        	ld	a,_mUART+1
4098  04b7 a101          	cp	a,#1
4099  04b9 262d          	jrne	L3142
4100                     ; 432 		if((ch >= UART_RECV_LEN_MIN) && (ch < UART_RECV_LEN_MAX))
4102  04bb 7b01          	ld	a,(OFST+0,sp)
4103  04bd a105          	cp	a,#5
4104  04bf 2521          	jrult	L5142
4106  04c1 7b01          	ld	a,(OFST+0,sp)
4107  04c3 a11e          	cp	a,#30
4108  04c5 241b          	jruge	L5142
4109                     ; 434 			mUART.RecvBuffer[mUART.RecvCount] = ch;
4111  04c7 c60001        	ld	a,_mUART+1
4112  04ca 5f            	clrw	x
4113  04cb 97            	ld	xl,a
4114  04cc 7b01          	ld	a,(OFST+0,sp)
4115  04ce d70004        	ld	(_mUART+4,x),a
4116                     ; 435 			mUART.RecvLen = mUART.RecvBuffer[mUART.RecvCount];
4118  04d1 c60001        	ld	a,_mUART+1
4119  04d4 5f            	clrw	x
4120  04d5 97            	ld	xl,a
4121  04d6 d60004        	ld	a,(_mUART+4,x)
4122  04d9 c70003        	ld	_mUART+3,a
4123                     ; 436 			mUART.RecvCount++;
4125  04dc 725c0001      	inc	_mUART+1
4127  04e0 2024          	jra	L1142
4128  04e2               L5142:
4129                     ; 440 			mUART.RecvCount = 0;
4131  04e2 725f0001      	clr	_mUART+1
4132  04e6 201e          	jra	L1142
4133  04e8               L3142:
4134                     ; 445 		mUART.RecvBuffer[mUART.RecvCount] = ch;
4136  04e8 c60001        	ld	a,_mUART+1
4137  04eb 5f            	clrw	x
4138  04ec 97            	ld	xl,a
4139  04ed 7b01          	ld	a,(OFST+0,sp)
4140  04ef d70004        	ld	(_mUART+4,x),a
4141                     ; 446 		mUART.RecvCount++;
4143  04f2 725c0001      	inc	_mUART+1
4144                     ; 448 		if(mUART.RecvCount >= mUART.RecvBuffer[1])
4146  04f6 c60001        	ld	a,_mUART+1
4147  04f9 c10005        	cp	a,_mUART+5
4148  04fc 2508          	jrult	L1142
4149                     ; 450 			mUART.RecvFlag  = 1; //  表示接收到了完整的数据
4151  04fe 35010002      	mov	_mUART+2,#1
4152                     ; 451 			mUART.RecvCount = 0;
4154  0502 725f0001      	clr	_mUART+1
4155  0506               L1142:
4156                     ; 455 	RXNE_FLAG	= 0;
4158  0506 721b5240      	bres	_UART2_SR,#5
4159                     ; 456 	OR_FLAG		= 0;	
4161  050a 72175240      	bres	_UART2_SR,#3
4162                     ; 457 	return;
4165  050e 84            	pop	a
4166  050f 80            	iret
4569                     	xdef	f_UART2_Recv_IRQHandler
4570                     	xdef	f_UART2_Send_IRQHandler
4571                     	xdef	_ProdKey
4572                     	xref	_mWIFI
4573                     	xref	_mDEV
4574                     	xdef	_WIFI_COMMU
4575                     	xdef	_UART2_Init
4576                     	switch	.bss
4577  0000               _mUART:
4578  0000 000000000000  	ds.b	78
4579                     	xdef	_mUART
4599                     	end
