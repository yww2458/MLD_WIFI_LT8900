   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.8 - 03 Dec 2008
2854                     ; 22 void GUART_init(void)
2854                     ; 23 {
2856                     	switch	.text
2857  0000               _GUART_init:
2861                     ; 25 	GUART_TX_DDR = 1;
2863  0000 72185007      	bset	_PB_DDR,#4
2864                     ; 26 	GUART_TX_CR1 = 1;	
2866  0004 72185008      	bset	_PB_CR1,#4
2867                     ; 27 	GUART_TX_ODR = 1;
2869  0008 72185005      	bset	_PB_ODR,#4
2870                     ; 30 	disableInterrupts();
2873  000c 9b            sim
2875                     ; 32 	GUART_RX_DDR = 0; //11111110
2878  000d 72115007      	bres	_PB_DDR,#0
2879                     ; 33 	GUART_RX_CR1 = 1; //11111110 1.45v Ê¹ÓÃÊäÈë,ÎÞÉÏÀ­·½Ê½
2881  0011 72105008      	bset	_PB_CR1,#0
2882                     ; 34     GUART_RX_CR2 = 1; //  ÖÐ¶Ï
2884  0015 72105009      	bset	_PB_CR2,#0
2885                     ; 36 	EXTI->CR1 &= (uint8_t)(~EXTI_CR1_PBIS);
2887  0019 c650a0        	ld	a,20640
2888  001c a4f3          	and	a,#243
2889  001e c750a0        	ld	20640,a
2890                     ; 37     EXTI->CR1 |= 0x08; 
2892  0021 721650a0      	bset	20640,#3
2893                     ; 41 	TIM2->PSCR = 0x05;  // fTIM4 = fMASTER(16M)/32, T = 2us
2895  0025 3505530c      	mov	21260,#5
2896                     ; 42 	TIM2->ARRH = (uint8_t)BAUDTATE_TIME_CNT>>8;//TIMER4_CNT;				// T=200us
2898  0029 725f530d      	clr	21261
2899                     ; 43 	TIM2->ARRL = (uint8_t)BAUDTATE_TIME_CNT;
2901  002d 35d0530e      	mov	21262,#208
2902                     ; 45 	TIM2->IER  = 0x01;			// TIM4 interrrupt enable register
2904  0031 35015301      	mov	21249,#1
2905                     ; 47 	TIM2->CR1 = 0x00; 
2907  0035 725f5300      	clr	21248
2908                     ; 49 	TIM2->SR1 &= 0x7E;
2910  0039 c65302        	ld	a,21250
2911  003c a47e          	and	a,#126
2912  003e c75302        	ld	21250,a
2913                     ; 53 	ITC->ISPR2 &= ~(0x03);  // INT_B
2915  0041 c67f71        	ld	a,32625
2916  0044 a4fc          	and	a,#252
2917  0046 c77f71        	ld	32625,a
2918                     ; 54 	ITC->ISPR4 &= ~(0x0C);  // INT_TIM2
2920  0049 c67f73        	ld	a,32627
2921  004c a4f3          	and	a,#243
2922  004e c77f73        	ld	32627,a
2923                     ; 55 	ITC->ISPR6 &= ~(0xC0);  // INT_TIM4
2925  0051 c67f75        	ld	a,32629
2926  0054 a43f          	and	a,#63
2927  0056 c77f75        	ld	32629,a
2928                     ; 56 	ITC->ISPR6 |= 0x40;
2930  0059 721c7f75      	bset	32629,#6
2931                     ; 57 	enableInterrupts();
2934  005d 9a            rim
2936                     ; 60 	mGUART.status		= GUART_STATUS_TX;   // ³õÊ¼»¯Îª¶ÁÈ¡×´Ì¬
2939  005e 35020000      	mov	_mGUART,#2
2940                     ; 61 	mGUART.RxTxDone		= 0;
2942  0062 725f0028      	clr	_mGUART+40
2943                     ; 62 	mGUART.RxTxBit 		= 0;
2945  0066 725f0029      	clr	_mGUART+41
2946                     ; 63 	mGUART.RxTxStSpFlag	= 0;
2948  006a 725f0027      	clr	_mGUART+39
2949                     ; 64 	mGUART.flagTimeOn	= 0;
2951  006e 725f0004      	clr	_mGUART+4
2952                     ; 65 	mGUART.funcCode 	= MACHINE_INFO_QUERY;
2954  0072 3501004d      	mov	_mGUART+77,#1
2955                     ; 67 }
2958  0076 81            	ret
2985                     ; 69 void BTSendData(void)
2985                     ; 70 {
2986                     	switch	.text
2987  0077               _BTSendData:
2991                     ; 71 	mGUART.RxTxDone = 0;
2993  0077 725f0028      	clr	_mGUART+40
2994                     ; 72 	mGUART.RxTxBit  = 0;
2996  007b 725f0029      	clr	_mGUART+41
2997                     ; 73 	mGUART.RxTxStSpFlag = 0;
2999  007f 725f0027      	clr	_mGUART+39
3000                     ; 74 	mGUART.status = GUART_STATUS_TX;
3002  0083 35020000      	mov	_mGUART,#2
3003                     ; 76 	mGUART.RxTxData = mGUART.TxBuf[0]; 
3005  0087 550008004c    	mov	_mGUART+76,_mGUART+8
3006                     ; 78 	GUART_RX_CR2 = 0;
3008  008c 72115009      	bres	_PB_CR2,#0
3009                     ; 81  	GUART_TX_DDR = 1;  // ÐèÒªÉèÖÃTX·½Ïò
3011  0090 72185007      	bset	_PB_DDR,#4
3012                     ; 82  	GUART_TX_ODR = 0; // ·¢ËÍµÚÒ»¸ö×Ö½ÚµÄÆðÊ¼Î»
3014  0094 72195005      	bres	_PB_ODR,#4
3015                     ; 83 	TIM2->CR1 = 0x01;
3017  0098 35015300      	mov	21248,#1
3018                     ; 85 	mGUART.flagTimeOn = 1;
3020  009c 35010004      	mov	_mGUART+4,#1
3021                     ; 86 }
3024  00a0 81            	ret
3050                     ; 88 @far @interrupt void EXTI_PORTB_IRQHandler()
3050                     ; 89 {
3052                     	switch	.text
3053  00a1               f_EXTI_PORTB_IRQHandler:
3057                     ; 90 	GUART_RX_CR2 = 0; // ½ûÖ¹ÖÐ¶Ï
3059  00a1 72115009      	bres	_PB_CR2,#0
3060                     ; 92 	mGUART.RxTxStSpFlag = 1;
3062  00a5 35010027      	mov	_mGUART+39,#1
3063                     ; 93 	TIM2->CNTRH = (uint8_t)(BAUDTATE_TIME_CNT/2>>8);
3065  00a9 725f530a      	clr	21258
3066                     ; 94 	TIM2->CNTRL = (uint8_t)(BAUDTATE_TIME_CNT/2); 
3068  00ad 3568530b      	mov	21259,#104
3069                     ; 96 	TIM2->CR1 = 0x01; // ¿ªÊ¼¼ÆÊý
3071  00b1 35015300      	mov	21248,#1
3072                     ; 97 	mGUART.flagTimeOn = 1;
3074  00b5 35010004      	mov	_mGUART+4,#1
3075                     ; 98 	mGUART.status = GUART_STATUS_RX;
3077  00b9 35010000      	mov	_mGUART,#1
3078                     ; 99 }
3081  00bd 80            	iret
3128                     ; 106 @far @interrupt void TIM2_isr(void)
3128                     ; 107 {		
3129                     	switch	.text
3130  00be               f_TIM2_isr:
3132       00000002      OFST:	set	2
3133  00be be00          	ldw	x,c_x
3134  00c0 89            	pushw	x
3135  00c1 be00          	ldw	x,c_y
3136  00c3 89            	pushw	x
3137  00c4 89            	pushw	x
3140                     ; 111 	TIM2->SR1 &= 0x7E;
3142  00c5 c65302        	ld	a,21250
3143  00c8 a47e          	and	a,#126
3144  00ca c75302        	ld	21250,a
3145                     ; 112 	TIM2->CNTRH = 0;
3147  00cd 725f530a      	clr	21258
3148                     ; 113 	TIM2->CNTRL = 0; 
3150  00d1 725f530b      	clr	21259
3151                     ; 115 	if(mGUART.status == GUART_STATUS_TX)  // ´«Êä
3153  00d5 c60000        	ld	a,_mGUART
3154  00d8 a102          	cp	a,#2
3155  00da 2704          	jreq	L02
3156  00dc ac7f017f      	jpf	L3602
3157  00e0               L02:
3158                     ; 118 		if(mGUART.RxTxStSpFlag == 0)
3160  00e0 725d0027      	tnz	_mGUART+39
3161  00e4 264b          	jrne	L5602
3162                     ; 120 			if (mGUART.RxTxBit == 0)
3164  00e6 725d0029      	tnz	_mGUART+41
3165  00ea 260b          	jrne	L7602
3166                     ; 122 				mGUART.RxTxData = mGUART.TxBuf[mGUART.RxTxDone];
3168  00ec c60028        	ld	a,_mGUART+40
3169  00ef 5f            	clrw	x
3170  00f0 97            	ld	xl,a
3171  00f1 d60008        	ld	a,(_mGUART+8,x)
3172  00f4 c7004c        	ld	_mGUART+76,a
3173  00f7               L7602:
3174                     ; 125 			if (mGUART.RxTxData & 0x01) 	
3176  00f7 c6004c        	ld	a,_mGUART+76
3177  00fa a501          	bcp	a,#1
3178  00fc 2706          	jreq	L1702
3179                     ; 127 				GUART_TX_ODR = 1;
3181  00fe 72185005      	bset	_PB_ODR,#4
3183  0102 2004          	jra	L3702
3184  0104               L1702:
3185                     ; 131 				GUART_TX_ODR = 0;
3187  0104 72195005      	bres	_PB_ODR,#4
3188  0108               L3702:
3189                     ; 134 			mGUART.RxTxBit++;
3191  0108 725c0029      	inc	_mGUART+41
3192                     ; 135 			if(mGUART.RxTxBit >= 8)
3194  010c c60029        	ld	a,_mGUART+41
3195  010f a108          	cp	a,#8
3196  0111 250e          	jrult	L5702
3197                     ; 137 				mGUART.RxTxBit = 0;
3199  0113 725f0029      	clr	_mGUART+41
3200                     ; 138 				mGUART.RxTxStSpFlag = 3;
3202  0117 35030027      	mov	_mGUART+39,#3
3203                     ; 139 				mGUART.RxTxDone++;
3205  011b 725c0028      	inc	_mGUART+40
3207  011f 2004          	jra	L7702
3208  0121               L5702:
3209                     ; 143 				mGUART.RxTxData >>= 1;
3211  0121 7254004c      	srl	_mGUART+76
3212  0125               L7702:
3213                     ; 146 			TIM2->CNTRH = 0;
3215  0125 725f530a      	clr	21258
3216                     ; 147 			TIM2->CNTRL = 0; 
3218  0129 725f530b      	clr	21259
3220  012d ace402e4      	jpf	L3112
3221  0131               L5602:
3222                     ; 150 		else if (mGUART.RxTxStSpFlag == 1)  // 1->0-3-1
3224  0131 c60027        	ld	a,_mGUART+39
3225  0134 a101          	cp	a,#1
3226  0136 260c          	jrne	L3012
3227                     ; 152 			GUART_TX_ODR = 0;
3229  0138 72195005      	bres	_PB_ODR,#4
3230                     ; 153 			mGUART.RxTxStSpFlag = 0;  
3232  013c 725f0027      	clr	_mGUART+39
3234  0140 ace402e4      	jpf	L3112
3235  0144               L3012:
3236                     ; 155 		else if (mGUART.RxTxStSpFlag == 3)// ·¢ËÍÍ£Ö¹À­¸ß, À­¸ßÍêÕûÊ±¼ä£¬±£Ö¤¿ªÊ¼Ê±¼ä³ä×ã
3238  0144 c60027        	ld	a,_mGUART+39
3239  0147 a103          	cp	a,#3
3240  0149 2704          	jreq	L22
3241  014b ace402e4      	jpf	L3112
3242  014f               L22:
3243                     ; 157 			GUART_TX_ODR = 1;
3245  014f 72185005      	bset	_PB_ODR,#4
3246                     ; 159 			mGUART.RxTxStSpFlag = 1;  //·¢ËÍ¿ªÊ¼Î»
3248  0153 35010027      	mov	_mGUART+39,#1
3249                     ; 161 			if (mGUART.RxTxDone >= mGUART.Txlen) //·¢ËÍÍê×îºóÒ»¸ö×Ö½Ú
3251  0157 c60028        	ld	a,_mGUART+40
3252  015a c10026        	cp	a,_mGUART+38
3253  015d 2404          	jruge	L42
3254  015f ace402e4      	jpf	L3112
3255  0163               L42:
3256                     ; 163 				mGUART.RxTxDone	= 0;
3258  0163 725f0028      	clr	_mGUART+40
3259                     ; 164 				mGUART.RxTxBit  = 0;
3261  0167 725f0029      	clr	_mGUART+41
3262                     ; 166 				mGUART.status = GUART_STATUS_RX;  // ·¢ËÍÍê³É£¬ÇÐ»»Îª½ÓÊÕ×´Ì¬
3264  016b 35010000      	mov	_mGUART,#1
3265                     ; 167 				GUART_RX_CR2 = 1;
3267  016f 72105009      	bset	_PB_CR2,#0
3268                     ; 169 				TIM2->CR1 = 0x00; // ¹Ø±Õ¶¨Ê±Æ÷¼ÆÊý	
3270  0173 725f5300      	clr	21248
3271                     ; 170 				mGUART.flagTimeOn = 0;
3273  0177 725f0004      	clr	_mGUART+4
3274  017b ace402e4      	jpf	L3112
3275  017f               L3602:
3276                     ; 174 	else if (mGUART.status == GUART_STATUS_RX)  // ¶ÁÈ¡
3278  017f c60000        	ld	a,_mGUART
3279  0182 a101          	cp	a,#1
3280  0184 2704          	jreq	L62
3281  0186 acdc02dc      	jpf	L5112
3282  018a               L62:
3283                     ; 178 		if (mGUART.RxTxStSpFlag == 0)
3285  018a 725d0027      	tnz	_mGUART+39
3286  018e 2636          	jrne	L7112
3287                     ; 180 			if (GUART_RX_IDR == 1)//´®¿Ú¶¼ÊÇÏÈ´«ÊäµÍÎ»£¬È»ºóÊÇ¸ßÎ»
3289  0190 c65006        	ld	a,_PB_IDR
3290  0193 a501          	bcp	a,#1
3291  0195 2714          	jreq	L1212
3292                     ; 182 				mGUART.RxTxData |= 1<<(mGUART.RxTxBit);
3294  0197 c60029        	ld	a,_mGUART+41
3295  019a 5f            	clrw	x
3296  019b 97            	ld	xl,a
3297  019c a601          	ld	a,#1
3298  019e 5d            	tnzw	x
3299  019f 2704          	jreq	L41
3300  01a1               L61:
3301  01a1 48            	sll	a
3302  01a2 5a            	decw	x
3303  01a3 26fc          	jrne	L61
3304  01a5               L41:
3305  01a5 ca004c        	or	a,_mGUART+76
3306  01a8 c7004c        	ld	_mGUART+76,a
3307  01ab               L1212:
3308                     ; 185 			mGUART.RxTxBit++;
3310  01ab 725c0029      	inc	_mGUART+41
3311                     ; 187 			if(mGUART.RxTxBit >= 8)
3313  01af c60029        	ld	a,_mGUART+41
3314  01b2 a108          	cp	a,#8
3315  01b4 2404          	jruge	L03
3316  01b6 ace402e4      	jpf	L3112
3317  01ba               L03:
3318                     ; 189 				mGUART.RxTxStSpFlag = 3;
3320  01ba 35030027      	mov	_mGUART+39,#3
3321                     ; 190 				mGUART.RxTxBit = 0;
3323  01be 725f0029      	clr	_mGUART+41
3324  01c2 ace402e4      	jpf	L3112
3325  01c6               L7112:
3326                     ; 193 		else if (mGUART.RxTxStSpFlag == 1)// ÆðÊ¼Î»
3328  01c6 c60027        	ld	a,_mGUART+39
3329  01c9 a101          	cp	a,#1
3330  01cb 2610          	jrne	L7212
3331                     ; 195 			mGUART.RxTxStSpFlag = 0;
3333  01cd 725f0027      	clr	_mGUART+39
3334                     ; 196 			mGUART.RxTxBit  = 0;
3336  01d1 725f0029      	clr	_mGUART+41
3337                     ; 197 			mGUART.RxTxData = 0;
3339  01d5 725f004c      	clr	_mGUART+76
3341  01d9 ace402e4      	jpf	L3112
3342  01dd               L7212:
3343                     ; 199 		else if (mGUART.RxTxStSpFlag == 3) // Í£Ö¹Î»
3345  01dd c60027        	ld	a,_mGUART+39
3346  01e0 a103          	cp	a,#3
3347  01e2 2704          	jreq	L23
3348  01e4 ace402e4      	jpf	L3112
3349  01e8               L23:
3350                     ; 201 			mGUART.RxBuf[mGUART.RxTxDone] =  mGUART.RxTxData;
3352  01e8 c60028        	ld	a,_mGUART+40
3353  01eb 5f            	clrw	x
3354  01ec 97            	ld	xl,a
3355  01ed c6004c        	ld	a,_mGUART+76
3356  01f0 d7002a        	ld	(_mGUART+42,x),a
3357                     ; 204 			if (mGUART.RxTxDone == 0)
3359  01f3 725d0028      	tnz	_mGUART+40
3360  01f7 2617          	jrne	L5312
3361                     ; 206 				if(mGUART.RxBuf[0] == 0xF7)
3363  01f9 c6002a        	ld	a,_mGUART+42
3364  01fc a1f7          	cp	a,#247
3365  01fe 2608          	jrne	L7312
3366                     ; 208 					mGUART.RxTxDone++;
3368  0200 725c0028      	inc	_mGUART+40
3370  0204 acbe02be      	jpf	L3412
3371  0208               L7312:
3372                     ; 212 					mGUART.RxTxDone = 0;
3374  0208 725f0028      	clr	_mGUART+40
3375  020c acbe02be      	jpf	L3412
3376  0210               L5312:
3377                     ; 215 			else if (mGUART.RxTxDone == 1)
3379  0210 c60028        	ld	a,_mGUART+40
3380  0213 a101          	cp	a,#1
3381  0215 2617          	jrne	L5412
3382                     ; 217 				if(mGUART.RxBuf[1] == 0xF8)
3384  0217 c6002b        	ld	a,_mGUART+43
3385  021a a1f8          	cp	a,#248
3386  021c 2608          	jrne	L7412
3387                     ; 219 					mGUART.RxTxDone++;
3389  021e 725c0028      	inc	_mGUART+40
3391  0222 acbe02be      	jpf	L3412
3392  0226               L7412:
3393                     ; 223 					mGUART.RxTxDone = 0;
3395  0226 725f0028      	clr	_mGUART+40
3396  022a acbe02be      	jra	L3412
3397  022e               L5412:
3398                     ; 226 			else if (mGUART.RxTxDone == 4)
3400  022e c60028        	ld	a,_mGUART+40
3401  0231 a104          	cp	a,#4
3402  0233 261a          	jrne	L5512
3403                     ; 228 				if(mGUART.RxBuf[3] == 0x01 && mGUART.RxBuf[4] == 0x02)
3405  0235 c6002d        	ld	a,_mGUART+45
3406  0238 a101          	cp	a,#1
3407  023a 260d          	jrne	L7512
3409  023c c6002e        	ld	a,_mGUART+46
3410  023f a102          	cp	a,#2
3411  0241 2606          	jrne	L7512
3412                     ; 230 					mGUART.RxTxDone++;
3414  0243 725c0028      	inc	_mGUART+40
3416  0247 2075          	jra	L3412
3417  0249               L7512:
3418                     ; 234 					mGUART.RxTxDone = 0;
3420  0249 725f0028      	clr	_mGUART+40
3421  024d 206f          	jra	L3412
3422  024f               L5512:
3423                     ; 237 			else if (mGUART.RxTxDone==(mGUART.RxBuf[2]+3))
3425  024f c60028        	ld	a,_mGUART+40
3426  0252 5f            	clrw	x
3427  0253 97            	ld	xl,a
3428  0254 c6002c        	ld	a,_mGUART+44
3429  0257 905f          	clrw	y
3430  0259 9097          	ld	yl,a
3431  025b 72a90003      	addw	y,#3
3432  025f bf01          	ldw	c_x+1,x
3433  0261 90b301        	cpw	y,c_x+1
3434  0264 2654          	jrne	L5612
3435                     ; 239 				if (mGUART.RxBuf[mGUART.RxTxDone]==0xfd)
3437  0266 c60028        	ld	a,_mGUART+40
3438  0269 5f            	clrw	x
3439  026a 97            	ld	xl,a
3440  026b d6002a        	ld	a,(_mGUART+42,x)
3441  026e a1fd          	cp	a,#253
3442  0270 2642          	jrne	L7612
3443                     ; 242 					tempj=0;
3445  0272 0f01          	clr	(OFST-1,sp)
3446                     ; 243 					for (tempi=2;tempi<(mGUART.RxTxDone-1);tempi++)
3448  0274 a602          	ld	a,#2
3449  0276 6b02          	ld	(OFST+0,sp),a
3451  0278 200d          	jra	L5712
3452  027a               L1712:
3453                     ; 245 						tempj+= mGUART.RxBuf[tempi];
3455  027a 7b02          	ld	a,(OFST+0,sp)
3456  027c 5f            	clrw	x
3457  027d 97            	ld	xl,a
3458  027e 7b01          	ld	a,(OFST-1,sp)
3459  0280 db002a        	add	a,(_mGUART+42,x)
3460  0283 6b01          	ld	(OFST-1,sp),a
3461                     ; 243 					for (tempi=2;tempi<(mGUART.RxTxDone-1);tempi++)
3463  0285 0c02          	inc	(OFST+0,sp)
3464  0287               L5712:
3467  0287 9c            	rvf
3468  0288 c60028        	ld	a,_mGUART+40
3469  028b 5f            	clrw	x
3470  028c 97            	ld	xl,a
3471  028d 5a            	decw	x
3472  028e 7b02          	ld	a,(OFST+0,sp)
3473  0290 905f          	clrw	y
3474  0292 9097          	ld	yl,a
3475  0294 90bf01        	ldw	c_y+1,y
3476  0297 b301          	cpw	x,c_y+1
3477  0299 2cdf          	jrsgt	L1712
3478                     ; 248 					if (tempj==mGUART.RxBuf[mGUART.RxTxDone-1])
3480  029b c60028        	ld	a,_mGUART+40
3481  029e 5f            	clrw	x
3482  029f 97            	ld	xl,a
3483  02a0 5a            	decw	x
3484  02a1 d6002a        	ld	a,(_mGUART+42,x)
3485  02a4 1101          	cp	a,(OFST-1,sp)
3486  02a6 2606          	jrne	L1022
3487                     ; 250 						mGUART.flagNew =1;
3489  02a8 35010001      	mov	_mGUART+1,#1
3491  02ac 2010          	jra	L3412
3492  02ae               L1022:
3493                     ; 255 						mGUART.RxTxDone=0;	
3495  02ae 725f0028      	clr	_mGUART+40
3496  02b2 200a          	jra	L3412
3497  02b4               L7612:
3498                     ; 265 					mGUART.RxTxDone=0;
3500  02b4 725f0028      	clr	_mGUART+40
3501  02b8 2004          	jra	L3412
3502  02ba               L5612:
3503                     ; 270 				mGUART.RxTxDone++;
3505  02ba 725c0028      	inc	_mGUART+40
3506  02be               L3412:
3507                     ; 273 			mGUART.Rxlen = mGUART.RxTxDone;
3509  02be 5500280048    	mov	_mGUART+72,_mGUART+40
3510                     ; 275 			if (mGUART.RxTxDone >= GUART_BUF_LEN)
3512  02c3 c60028        	ld	a,_mGUART+40
3513  02c6 a11e          	cp	a,#30
3514  02c8 2504          	jrult	L1122
3515                     ; 277 				mGUART.RxTxDone = 0;
3517  02ca 725f0028      	clr	_mGUART+40
3518  02ce               L1122:
3519                     ; 280 			GUART_RX_CR2 = 1;// IO½ÅÖÐ¶ÏÊ¹ÄÜ
3521  02ce 72105009      	bset	_PB_CR2,#0
3522                     ; 281 			TIM2_CR1 = 0x00;// Í£Ö¹¼Ä´æÆ÷¼ÆÊý
3524  02d2 725f5300      	clr	_TIM2_CR1
3525                     ; 282 			mGUART.flagTimeOn = 0;
3527  02d6 725f0004      	clr	_mGUART+4
3528  02da 2008          	jra	L3112
3529  02dc               L5112:
3530                     ; 287 		TIM2->CR1  = 0x00;
3532  02dc 725f5300      	clr	21248
3533                     ; 289 		mGUART.flagTimeOn = 0;
3535  02e0 725f0004      	clr	_mGUART+4
3536  02e4               L3112:
3537                     ; 291 }
3540  02e4 5b02          	addw	sp,#2
3541  02e6 85            	popw	x
3542  02e7 bf00          	ldw	c_y,x
3543  02e9 85            	popw	x
3544  02ea bf00          	ldw	c_x,x
3545  02ec 80            	iret
3600                     ; 293 void GUART_commu(void)
3600                     ; 294 {
3602                     	switch	.text
3603  02ed               _GUART_commu:
3605  02ed 5206          	subw	sp,#6
3606       00000006      OFST:	set	6
3609                     ; 300 	mGUART.offCounts++;
3611  02ef 725c0005      	inc	_mGUART+5
3612                     ; 307 	if (mGUART.flagTimeOn == 1) // ¶¨Ê±Æ÷ÒÑ¾­´ò¿ª£¬ÕýÔÚ´¦ÀíÊý¾Ý
3614  02f3 c60004        	ld	a,_mGUART+4
3615  02f6 a101          	cp	a,#1
3616  02f8 2603          	jrne	L04
3617  02fa cc04bf        	jp	L63
3618  02fd               L04:
3619                     ; 309 		return;
3621                     ; 313 	if (mGUART.status == GUART_STATUS_TX) // ·¢ËÍ
3623  02fd c60000        	ld	a,_mGUART
3624  0300 a102          	cp	a,#2
3625  0302 2703          	jreq	L24
3626  0304 cc03bb        	jp	L3622
3627  0307               L24:
3628                     ; 316   		mGUART.TxBuf[0] = COMMU_HEAD1;						//answer basing the order function
3630  0307 35f70008      	mov	_mGUART+8,#247
3631                     ; 317 		mGUART.TxBuf[1] = COMMU_HEAD2;						//pctxd[2]=command_size-4;		//command size
3633  030b 35f80009      	mov	_mGUART+9,#248
3634                     ; 318 		mGUART.TxBuf[3] = 0x01;
3636  030f 3501000b      	mov	_mGUART+11,#1
3637                     ; 319 		mGUART.TxBuf[4] = 0x01;//å)ÉÏ¿Ø·¢ËÍµÄÊÇ1,ÏÂ¿Ø·¢ËÍµÄÊÇ2,ÓÃÕâ¸ö±êÖ¾Ê¶±ðÊÇÉÏ¿Ø»¹ÊÇÏÂ¿Ø
3639  0313 3501000c      	mov	_mGUART+12,#1
3640                     ; 320 		mGUART.TxBuf[5] = mGUART.funcCode;
3642  0317 55004d000d    	mov	_mGUART+13,_mGUART+77
3643                     ; 322 		switch(mGUART.funcCode) 
3645  031c c6004d        	ld	a,_mGUART+77
3647                     ; 346 			default:
3647                     ; 347 			
3647                     ; 348 				break;								
3648  031f 4a            	dec	a
3649  0320 2705          	jreq	L5122
3650  0322 4a            	dec	a
3651  0323 2708          	jreq	L7122
3652  0325 2041          	jra	L7622
3653  0327               L5122:
3654                     ; 324 			case MACHINE_INFO_QUERY:			//query product information
3654                     ; 325 				
3654                     ; 326 				mGUART.Txlen=0x08;
3656  0327 35080026      	mov	_mGUART+38,#8
3657                     ; 327 				break;
3659  032b 203b          	jra	L7622
3660  032d               L7122:
3661                     ; 328 			case MACHINE_CONTROL:				//machine control
3661                     ; 329 				mGUART.Txlen= 0x16;
3663  032d 35160026      	mov	_mGUART+38,#22
3664                     ; 330 				mGUART.TxBuf[6] = mDEV.user_request;
3666  0331 55000b000e    	mov	_mGUART+14,_mDEV+11
3667                     ; 331 				mDEV.user_request= USER_REQUEST_NONE;						
3669  0336 725f000b      	clr	_mDEV+11
3670                     ; 332 				mGUART.TxBuf[7] = mDEV.rpm_target>>8;		//user_speed_target;
3672  033a 55000c000f    	mov	_mGUART+15,_mDEV+12
3673                     ; 333 				mGUART.TxBuf[8] = mDEV.rpm_target;
3675  033f 55000d0010    	mov	_mGUART+16,_mDEV+13
3676                     ; 334 				mGUART.TxBuf[9] = mDEV.incline_target;
3678  0344 55000e0011    	mov	_mGUART+17,_mDEV+14
3679                     ; 336 				mGUART.TxBuf[10]= 130; //DC_MOTOR_CURRENT_MAX;
3681  0349 35820012      	mov	_mGUART+18,#130
3682                     ; 337 				mGUART.TxBuf[12]= 15;//LIFT_MOTOR_GRADIENT_MAX;
3684  034d 350f0014      	mov	_mGUART+20,#15
3685                     ; 338 				templ=833333;//RPM_MEASURED_SCALE;
3687  0351 96            	ldw	x,sp
3688  0352 1c0001        	addw	x,#OFST-5
3689  0355 cd0000        	call	c_ltor
3691                     ; 339 				mGUART.TxBuf[13]=templ>>24;
3693  0358 725f0015      	clr	_mGUART+21
3694                     ; 340 				mGUART.TxBuf[14]=templ>>16;				
3696  035c 350c0016      	mov	_mGUART+22,#12
3697                     ; 341 				mGUART.TxBuf[15]=templ>>8;
3699  0360 35b70017      	mov	_mGUART+23,#183
3700                     ; 342 				mGUART.TxBuf[16]=templ;
3702  0364 35350018      	mov	_mGUART+24,#53
3703                     ; 344 				break;
3705  0368               L1222:
3706                     ; 346 			default:
3706                     ; 347 			
3706                     ; 348 				break;								
3708  0368               L7622:
3709                     ; 351 		mGUART.TxBuf[2]=mGUART.Txlen-4;
3711  0368 c60026        	ld	a,_mGUART+38
3712  036b a004          	sub	a,#4
3713  036d c7000a        	ld	_mGUART+10,a
3714                     ; 352 		temp8 = mGUART.TxBuf[2];
3716  0370 c6000a        	ld	a,_mGUART+10
3717  0373 6b05          	ld	(OFST-1,sp),a
3718                     ; 353 		for(i = 3; i < mGUART.Txlen-2; i++)
3720  0375 a603          	ld	a,#3
3721  0377 6b06          	ld	(OFST+0,sp),a
3723  0379 200d          	jra	L5722
3724  037b               L1722:
3725                     ; 355 			temp8 +=mGUART.TxBuf[i];
3727  037b 7b06          	ld	a,(OFST+0,sp)
3728  037d 5f            	clrw	x
3729  037e 97            	ld	xl,a
3730  037f 7b05          	ld	a,(OFST-1,sp)
3731  0381 db0008        	add	a,(_mGUART+8,x)
3732  0384 6b05          	ld	(OFST-1,sp),a
3733                     ; 353 		for(i = 3; i < mGUART.Txlen-2; i++)
3735  0386 0c06          	inc	(OFST+0,sp)
3736  0388               L5722:
3739  0388 9c            	rvf
3740  0389 c60026        	ld	a,_mGUART+38
3741  038c 5f            	clrw	x
3742  038d 97            	ld	xl,a
3743  038e 5a            	decw	x
3744  038f 5a            	decw	x
3745  0390 7b06          	ld	a,(OFST+0,sp)
3746  0392 905f          	clrw	y
3747  0394 9097          	ld	yl,a
3748  0396 90bf01        	ldw	c_y+1,y
3749  0399 b301          	cpw	x,c_y+1
3750  039b 2cde          	jrsgt	L1722
3751                     ; 358 		mGUART.TxBuf[mGUART.Txlen-2] = temp8;	//checksum
3753  039d c60026        	ld	a,_mGUART+38
3754  03a0 5f            	clrw	x
3755  03a1 97            	ld	xl,a
3756  03a2 5a            	decw	x
3757  03a3 5a            	decw	x
3758  03a4 7b05          	ld	a,(OFST-1,sp)
3759  03a6 d70008        	ld	(_mGUART+8,x),a
3760                     ; 359 		mGUART.TxBuf[mGUART.Txlen-1] = 0xfd;	//end code
3762  03a9 c60026        	ld	a,_mGUART+38
3763  03ac 5f            	clrw	x
3764  03ad 97            	ld	xl,a
3765  03ae 5a            	decw	x
3766  03af a6fd          	ld	a,#253
3767  03b1 d70008        	ld	(_mGUART+8,x),a
3768                     ; 360 		BTSendData();
3770  03b4 cd0077        	call	_BTSendData
3773  03b7 acbf04bf      	jpf	L1032
3774  03bb               L3622:
3775                     ; 364 		if(mGUART.flagNew == 1)
3777  03bb c60001        	ld	a,_mGUART+1
3778  03be a101          	cp	a,#1
3779  03c0 2703          	jreq	L44
3780  03c2 cc0485        	jp	L3032
3781  03c5               L44:
3782                     ; 367 			mGUART.offCounts   = 0; //½ÓÊÕµ½Êý¾Ý£¬Çå¿Õ
3784  03c5 725f0005      	clr	_mGUART+5
3785                     ; 368 			mGUART.flagNew     = 0;
3787  03c9 725f0001      	clr	_mGUART+1
3788                     ; 369 			mGUART.pctra_delay = 2;
3790  03cd 35020050      	mov	_mGUART+80,#2
3791                     ; 370 			mGUART.flag_ack    = 1;
3793  03d1 35010051      	mov	_mGUART+81,#1
3794                     ; 371 			mGUART.err_cnt     = 0;
3796  03d5 5f            	clrw	x
3797  03d6 cf004e        	ldw	_mGUART+78,x
3798                     ; 373 			mGUART.funcCode = mGUART.RxBuf[5];
3800  03d9 55002f004d    	mov	_mGUART+77,_mGUART+47
3801                     ; 375 			switch(mGUART.funcCode)
3803  03de c6004d        	ld	a,_mGUART+77
3805                     ; 444 					break;
3806  03e1 4a            	dec	a
3807  03e2 270f          	jreq	L3222
3808  03e4 4a            	dec	a
3809  03e5 2730          	jreq	L7222
3810  03e7 a042          	sub	a,#66
3811  03e9 2715          	jreq	L5222
3812  03eb               L1322:
3813                     ; 443 					mGUART.funcCode=MACHINE_INFO_QUERY;	
3815  03eb 3501004d      	mov	_mGUART+77,#1
3816                     ; 444 					break;
3818  03ef acbf04bf      	jpf	L1032
3819  03f3               L3222:
3820                     ; 379 					mDEV.version_machine = mGUART.RxBuf[8];
3822  03f3 550032000f    	mov	_mDEV+15,_mGUART+50
3823                     ; 381 					mGUART.funcCode=MACHINE_CONTROL;
3825  03f8 3502004d      	mov	_mGUART+77,#2
3826                     ; 382 					break;
3828  03fc acbf04bf      	jpf	L1032
3829  0400               L5222:
3830                     ; 386 					if (mGUART.RxBuf[7] == 1)
3832  0400 c60031        	ld	a,_mGUART+49
3833  0403 a101          	cp	a,#1
3834  0405 2608          	jrne	L1132
3835                     ; 388 						mGUART.funcCode=MACHINE_CONTROL;
3837  0407 3502004d      	mov	_mGUART+77,#2
3839  040b acbf04bf      	jpf	L1032
3840  040f               L1132:
3841                     ; 392 						mGUART.funcCode=MACHINE_SET_ARG;
3843  040f 3544004d      	mov	_mGUART+77,#68
3844  0413 acbf04bf      	jpf	L1032
3845  0417               L7222:
3846                     ; 398 					mDEV.rpm_machine= mGUART.RxBuf[7]<<8 | mGUART.RxBuf[8];
3848  0417 c60031        	ld	a,_mGUART+49
3849  041a 5f            	clrw	x
3850  041b 97            	ld	xl,a
3851  041c 4f            	clr	a
3852  041d 02            	rlwa	x,a
3853  041e 01            	rrwa	x,a
3854  041f ca0032        	or	a,_mGUART+50
3855  0422 c70011        	ld	_mDEV+17,a
3856  0425 9f            	ld	a,xl
3857  0426 c70010        	ld	_mDEV+16,a
3858                     ; 400 					if ((mDEV.user_request&USER_REQUEST_ERROR_RESET)==0)
3860  0429 c6000b        	ld	a,_mDEV+11
3861  042c a510          	bcp	a,#16
3862  042e 2612          	jrne	L5132
3863                     ; 402 						mGUART.error_code = mGUART.RxBuf[19]<<8|mGUART.RxBuf[18];
3865  0430 c6003d        	ld	a,_mGUART+61
3866  0433 5f            	clrw	x
3867  0434 97            	ld	xl,a
3868  0435 4f            	clr	a
3869  0436 02            	rlwa	x,a
3870  0437 01            	rrwa	x,a
3871  0438 ca003c        	or	a,_mGUART+60
3872  043b c70053        	ld	_mGUART+83,a
3873  043e 9f            	ld	a,xl
3874  043f c70052        	ld	_mGUART+82,a
3875  0442               L5132:
3876                     ; 405 					if(mGUART.RxBuf[20]&0x40)
3878  0442 c6003e        	ld	a,_mGUART+62
3879  0445 a540          	bcp	a,#64
3880  0447 2706          	jreq	L7132
3881                     ; 407 						mDEV.flag_sensor_no=1;
3883  0449 35010008      	mov	_mDEV+8,#1
3885  044d 2004          	jra	L1232
3886  044f               L7132:
3887                     ; 411 						mDEV.flag_sensor_no=0;
3889  044f 725f0008      	clr	_mDEV+8
3890  0453               L1232:
3891                     ; 414 					temp8=mGUART.RxBuf[20]&0x01;
3893  0453 c6003e        	ld	a,_mGUART+62
3894  0456 a401          	and	a,#1
3895  0458 6b05          	ld	(OFST-1,sp),a
3896                     ; 416 					if (temp8==0x01)
3898  045a 7b05          	ld	a,(OFST-1,sp)
3899  045c a101          	cp	a,#1
3900  045e 2606          	jrne	L3232
3901                     ; 418 						mDEV.machine_state=MACHINE_STATE_RUN;
3903  0460 3501000a      	mov	_mDEV+10,#1
3905  0464 2004          	jra	L5232
3906  0466               L3232:
3907                     ; 422 						mDEV.machine_state=MACHINE_STATE_IDLE;
3909  0466 725f000a      	clr	_mDEV+10
3910  046a               L5232:
3911                     ; 425 					temp8 = mGUART.RxBuf[20]&0x80;
3913  046a c6003e        	ld	a,_mGUART+62
3914  046d a480          	and	a,#128
3915  046f 6b05          	ld	(OFST-1,sp),a
3916                     ; 426 					if (temp8 == 0x80)
3918  0471 7b05          	ld	a,(OFST-1,sp)
3919  0473 a180          	cp	a,#128
3920  0475 2606          	jrne	L7232
3921                     ; 428 						mDEV.flag_incline_vr_err = 1;
3923  0477 35010009      	mov	_mDEV+9,#1
3925  047b 2042          	jra	L1032
3926  047d               L7232:
3927                     ; 432 						mDEV.flag_incline_vr_err = 0;
3929  047d 725f0009      	clr	_mDEV+9
3930  0481 203c          	jra	L1032
3931  0483               L7032:
3932                     ; 444 					break;
3933  0483 203a          	jra	L1032
3934  0485               L3032:
3935                     ; 451 			if(mGUART.err_cnt >= 10)
3937  0485 ce004e        	ldw	x,_mGUART+78
3938  0488 a3000a        	cpw	x,#10
3939  048b 2506          	jrult	L5332
3940                     ; 453 				mGUART.err_cnt = 0;
3942  048d 5f            	clrw	x
3943  048e cf004e        	ldw	_mGUART+78,x
3945  0491 2011          	jra	L7332
3946  0493               L5332:
3947                     ; 456 			else if (mTIME.sec == 0)
3949  0493 3d04          	tnz	_mTIME+4
3950  0495 260d          	jrne	L7332
3951                     ; 458 				mGUART.err_cnt++;
3953  0497 ce004e        	ldw	x,_mGUART+78
3954  049a 1c0001        	addw	x,#1
3955  049d cf004e        	ldw	_mGUART+78,x
3956                     ; 459 				mGUART.status = GUART_STATUS_TX;
3958  04a0 35020000      	mov	_mGUART,#2
3959  04a4               L7332:
3960                     ; 462 			if(mGUART.pctra_delay)
3962  04a4 725d0050      	tnz	_mGUART+80
3963  04a8 2706          	jreq	L3432
3964                     ; 464 				mGUART.pctra_delay--;
3966  04aa 725a0050      	dec	_mGUART+80
3968  04ae 200f          	jra	L1032
3969  04b0               L3432:
3970                     ; 466 			else if (mGUART.flag_ack == 1)
3972  04b0 c60051        	ld	a,_mGUART+81
3973  04b3 a101          	cp	a,#1
3974  04b5 2608          	jrne	L1032
3975                     ; 468 				mGUART.flag_ack =0;
3977  04b7 725f0051      	clr	_mGUART+81
3978                     ; 469 				mGUART.status = GUART_STATUS_TX;
3980  04bb 35020000      	mov	_mGUART,#2
3981  04bf               L1032:
3982                     ; 473 }
3983  04bf               L63:
3986  04bf 5b06          	addw	sp,#6
3987  04c1 81            	ret
4186                     	xdef	f_TIM2_isr
4187                     	xdef	f_EXTI_PORTB_IRQHandler
4188                     	xdef	_BTSendData
4189                     	xref	_mDEV
4190                     	xref.b	_mTIME
4191                     	xdef	_GUART_commu
4192                     	xdef	_GUART_init
4193                     	switch	.bss
4194  0000               _mGUART:
4195  0000 000000000000  	ds.b	84
4196                     	xdef	_mGUART
4197                     	xref.b	c_x
4198                     	xref.b	c_y
4218                     	xref	c_ltor
4219                     	end
