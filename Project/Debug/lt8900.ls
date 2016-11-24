   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.8 - 03 Dec 2008
2876                     ; 10 void mdelay(uint ms)
2876                     ; 11 {
2878                     	switch	.text
2879  0000               _mdelay:
2881  0000 89            	pushw	x
2882  0001 5204          	subw	sp,#4
2883       00000004      OFST:	set	4
2886                     ; 12 	unsigned int j=0;	
2888  0003 1e03          	ldw	x,(OFST-1,sp)
2889                     ; 15     for(i=0;i<ms;i++)
2891  0005 5f            	clrw	x
2892  0006 1f01          	ldw	(OFST-3,sp),x
2894  0008 2017          	jra	L3402
2895  000a               L7302:
2896                     ; 17     	j= 315;//315;//16M	
2898  000a ae013b        	ldw	x,#315
2899  000d 1f03          	ldw	(OFST-1,sp),x
2900  000f               L7402:
2901                     ; 20     	    j--;
2903  000f 1e03          	ldw	x,(OFST-1,sp)
2904  0011 1d0001        	subw	x,#1
2905  0014 1f03          	ldw	(OFST-1,sp),x
2906                     ; 18         while(j)
2908  0016 1e03          	ldw	x,(OFST-1,sp)
2909  0018 26f5          	jrne	L7402
2910                     ; 15     for(i=0;i<ms;i++)
2912  001a 1e01          	ldw	x,(OFST-3,sp)
2913  001c 1c0001        	addw	x,#1
2914  001f 1f01          	ldw	(OFST-3,sp),x
2915  0021               L3402:
2918  0021 1e01          	ldw	x,(OFST-3,sp)
2919  0023 1305          	cpw	x,(OFST+1,sp)
2920  0025 25e3          	jrult	L7302
2921                     ; 23 }
2924  0027 5b06          	addw	sp,#6
2925  0029 81            	ret
2959                     ; 25 void delay2_5US_1(u16 nCount)
2959                     ; 26 {
2960                     	switch	.text
2961  002a               _delay2_5US_1:
2963  002a 89            	pushw	x
2964       00000000      OFST:	set	0
2967  002b 2007          	jra	L5702
2968  002d               L3702:
2969                     ; 29     nCount--;
2971  002d 1e01          	ldw	x,(OFST+1,sp)
2972  002f 1d0001        	subw	x,#1
2973  0032 1f01          	ldw	(OFST+1,sp),x
2974  0034               L5702:
2975                     ; 27   while (nCount != 0)
2977  0034 1e01          	ldw	x,(OFST+1,sp)
2978  0036 26f5          	jrne	L3702
2979                     ; 31 }
2982  0038 85            	popw	x
2983  0039 81            	ret
3036                     ; 33 u8  SPI_SendByte(unsigned char bcdVal)
3036                     ; 34 {
3037                     	switch	.text
3038  003a               _SPI_SendByte:
3040  003a 88            	push	a
3041  003b 5203          	subw	sp,#3
3042       00000003      OFST:	set	3
3045                     ; 35 	int i = 0;
3047  003d 1e01          	ldw	x,(OFST-2,sp)
3048                     ; 36 	u8 dataR=0;
3050  003f 0f03          	clr	(OFST+0,sp)
3051                     ; 38 	for(i=0;i<8;i++)
3053  0041 5f            	clrw	x
3054  0042 1f01          	ldw	(OFST-2,sp),x
3055  0044               L7212:
3056                     ; 41     	if(bcdVal&0x80)
3058  0044 7b04          	ld	a,(OFST+1,sp)
3059  0046 a580          	bcp	a,#128
3060  0048 2706          	jreq	L5312
3061                     ; 43         	LT_MOSI_SetVal();
3063  004a 721e500a      	bset	20490,#7
3065  004e 2004          	jra	L7312
3066  0050               L5312:
3067                     ; 47         	LT_MOSI_ClrVal();   
3069  0050 721f500a      	bres	20490,#7
3070  0054               L7312:
3071                     ; 50     	LT_CLK_SetVal();
3073  0054 721a500a      	bset	20490,#5
3074                     ; 51     	delay2_5US_1(4);  //  4
3076  0058 ae0004        	ldw	x,#4
3077  005b adcd          	call	_delay2_5US_1
3079                     ; 53     	bcdVal<<=1;
3081  005d 0804          	sll	(OFST+1,sp)
3082                     ; 55         dataR<<=1;
3084  005f 0803          	sll	(OFST+0,sp)
3085                     ; 56     	if(LT_MISO)
3087  0061 c6500b        	ld	a,20491
3088  0064 a440          	and	a,#64
3089  0066 c7500b        	ld	20491,a
3090  0069 2706          	jreq	L1412
3091                     ; 58         	dataR|=((u8)0x01);
3093  006b 7b03          	ld	a,(OFST+0,sp)
3094  006d aa01          	or	a,#1
3095  006f 6b03          	ld	(OFST+0,sp),a
3096  0071               L1412:
3097                     ; 61     	LT_CLK_ClrVal();    	
3099  0071 721b500a      	bres	20490,#5
3100                     ; 62     	delay2_5US_1(4);
3102  0075 ae0004        	ldw	x,#4
3103  0078 adb0          	call	_delay2_5US_1
3105                     ; 38 	for(i=0;i<8;i++)
3107  007a 1e01          	ldw	x,(OFST-2,sp)
3108  007c 1c0001        	addw	x,#1
3109  007f 1f01          	ldw	(OFST-2,sp),x
3112  0081 9c            	rvf
3113  0082 1e01          	ldw	x,(OFST-2,sp)
3114  0084 a30008        	cpw	x,#8
3115  0087 2fbb          	jrslt	L7212
3116                     ; 65     return (dataR);
3118  0089 7b03          	ld	a,(OFST+0,sp)
3121  008b 5b04          	addw	sp,#4
3122  008d 81            	ret
3176                     ; 69 void LT_WriteReg(unsigned char reg, unsigned char H, unsigned char L)
3176                     ; 70 {
3177                     	switch	.text
3178  008e               _LT_WriteReg:
3180  008e 89            	pushw	x
3181       00000000      OFST:	set	0
3184                     ; 71 	LT_CS_ClrVal();
3186  008f 72175000      	bres	20480,#3
3187                     ; 72 	delay2_5US_1(4);
3189  0093 ae0004        	ldw	x,#4
3190  0096 ad92          	call	_delay2_5US_1
3192                     ; 74 	SPI_SendByte(WRITE & reg);
3194  0098 7b01          	ld	a,(OFST+1,sp)
3195  009a a47f          	and	a,#127
3196  009c ad9c          	call	_SPI_SendByte
3198                     ; 75 	delay2_5US_1(4);
3200  009e ae0004        	ldw	x,#4
3201  00a1 ad87          	call	_delay2_5US_1
3203                     ; 76 	SPI_SendByte(H);
3205  00a3 7b02          	ld	a,(OFST+2,sp)
3206  00a5 ad93          	call	_SPI_SendByte
3208                     ; 77 	delay2_5US_1(4);
3210  00a7 ae0004        	ldw	x,#4
3211  00aa cd002a        	call	_delay2_5US_1
3213                     ; 78 	SPI_SendByte(L);
3215  00ad 7b05          	ld	a,(OFST+5,sp)
3216  00af ad89          	call	_SPI_SendByte
3218                     ; 79 	delay2_5US_1(4);
3220  00b1 ae0004        	ldw	x,#4
3221  00b4 cd002a        	call	_delay2_5US_1
3223                     ; 81 	LT_CS_SetVal();
3225  00b7 72165000      	bset	20480,#3
3226                     ; 83 }
3229  00bb 85            	popw	x
3230  00bc 81            	ret
3275                     ; 85 void Get_chipId(void)
3275                     ; 86 {
3276                     	switch	.text
3277  00bd               _Get_chipId:
3279  00bd 520d          	subw	sp,#13
3280       0000000d      OFST:	set	13
3283                     ; 89 	mLT8900.down_id = 0;
3285  00bf 3f3a          	clr	_mLT8900+41
3286                     ; 90 	for(i = 0; i <12; i++)
3288  00c1 0f0d          	clr	(OFST+0,sp)
3289  00c3               L3122:
3290                     ; 94 		chipUniqueID[i] = *(volatile u16 *)(0x4865+i);
3292  00c3 96            	ldw	x,sp
3293  00c4 1c0001        	addw	x,#OFST-12
3294  00c7 9f            	ld	a,xl
3295  00c8 5e            	swapw	x
3296  00c9 1b0d          	add	a,(OFST+0,sp)
3297  00cb 2401          	jrnc	L61
3298  00cd 5c            	incw	x
3299  00ce               L61:
3300  00ce 02            	rlwa	x,a
3301  00cf 7b0d          	ld	a,(OFST+0,sp)
3302  00d1 905f          	clrw	y
3303  00d3 9097          	ld	yl,a
3304  00d5 90d64866      	ld	a,(18534,y)
3305  00d9 f7            	ld	(x),a
3306                     ; 95 		mLT8900.down_id ^=  chipUniqueID[i];
3308  00da 96            	ldw	x,sp
3309  00db 1c0001        	addw	x,#OFST-12
3310  00de 9f            	ld	a,xl
3311  00df 5e            	swapw	x
3312  00e0 1b0d          	add	a,(OFST+0,sp)
3313  00e2 2401          	jrnc	L02
3314  00e4 5c            	incw	x
3315  00e5               L02:
3316  00e5 02            	rlwa	x,a
3317  00e6 b63a          	ld	a,_mLT8900+41
3318  00e8 f8            	xor	a,	(x)
3319  00e9 b73a          	ld	_mLT8900+41,a
3320                     ; 90 	for(i = 0; i <12; i++)
3322  00eb 0c0d          	inc	(OFST+0,sp)
3325  00ed 7b0d          	ld	a,(OFST+0,sp)
3326  00ef a10c          	cp	a,#12
3327  00f1 25d0          	jrult	L3122
3328                     ; 98 	if (mLT8900.down_id == 0){  // 由于 0是公共信道，所以不会采用0
3330  00f3 3d3a          	tnz	_mLT8900+41
3331  00f5 2604          	jrne	L1222
3332                     ; 99 		mLT8900.down_id = 0xFF;
3334  00f7 35ff003a      	mov	_mLT8900+41,#255
3335  00fb               L1222:
3336                     ; 101 }
3339  00fb 5b0d          	addw	sp,#13
3340  00fd 81            	ret
3368                     ; 113 void Init_LT8900(void)
3368                     ; 114 {
3369                     	switch	.text
3370  00fe               _Init_LT8900:
3374                     ; 118 	GPIOA->DDR |= (1<<3);//11111110
3376  00fe 72165002      	bset	20482,#3
3377                     ; 119 	GPIOA->CR1 |= (1<<3);//11111110 1.45v 使用输入,无上拉方式
3379  0102 72165003      	bset	20483,#3
3380                     ; 121 	GPIOC->DDR |= (1<<5);//11111110
3382  0106 721a500c      	bset	20492,#5
3383                     ; 122 	GPIOC->CR1 |= (1<<5);//11111110 1.45v 使用输入,无上拉方式
3385  010a 721a500d      	bset	20493,#5
3386                     ; 124 	GPIOC->DDR |= (1<<7);//11111110
3388  010e 721e500c      	bset	20492,#7
3389                     ; 125 	GPIOC->CR1 |= (1<<7);//11111110 1.45v 使用输入,无上拉方式
3391  0112 721e500d      	bset	20493,#7
3392                     ; 127 	GPIOC->DDR &= ~(1<<6);//11111110
3394  0116 721d500c      	bres	20492,#6
3395                     ; 128 	GPIOC->CR1 |= (1<<6);//11111110 1.45v 使用输入,无上拉方式
3397  011a 721c500d      	bset	20493,#6
3398                     ; 130 	GPIOD->DDR |= (1<<2);//11111110
3400  011e 72145011      	bset	20497,#2
3401                     ; 131 	GPIOD->CR1 |= (1<<2);//11111110 1.45v 使用输入,无上拉方式
3403  0122 72145012      	bset	20498,#2
3404                     ; 133 	GPIOA->DDR &= ~(1<<1);//11111110
3406  0126 72135002      	bres	20482,#1
3407                     ; 134 	GPIOA->CR1 |= (1<<1);//11111110 1.45v 使用输入,无上拉方式
3409  012a 72125003      	bset	20483,#1
3410                     ; 137 	LT_RST_ClrVal();
3412  012e 7215500f      	bres	20495,#2
3413                     ; 138 	mdelay(100);
3415  0132 ae0064        	ldw	x,#100
3416  0135 cd0000        	call	_mdelay
3418                     ; 139 	LT_RST_SetVal();
3420  0138 7214500f      	bset	20495,#2
3421                     ; 140 	mdelay(200);
3423  013c ae00c8        	ldw	x,#200
3424  013f cd0000        	call	_mdelay
3426                     ; 142 	LT_CLK_ClrVal(); //set SPI clock to low
3428  0142 721b500a      	bres	20490,#5
3429                     ; 148     LT_WriteReg(0, 0x6f, 0xe0);
3431  0146 4be0          	push	#224
3432  0148 ae006f        	ldw	x,#111
3433  014b 4f            	clr	a
3434  014c 95            	ld	xh,a
3435  014d cd008e        	call	_LT_WriteReg
3437  0150 84            	pop	a
3438                     ; 149     LT_WriteReg(1, 0x56, 0x81);
3440  0151 4b81          	push	#129
3441  0153 ae0056        	ldw	x,#86
3442  0156 a601          	ld	a,#1
3443  0158 95            	ld	xh,a
3444  0159 cd008e        	call	_LT_WriteReg
3446  015c 84            	pop	a
3447                     ; 150     LT_WriteReg(2, 0x66, 0x17);
3449  015d 4b17          	push	#23
3450  015f ae0066        	ldw	x,#102
3451  0162 a602          	ld	a,#2
3452  0164 95            	ld	xh,a
3453  0165 cd008e        	call	_LT_WriteReg
3455  0168 84            	pop	a
3456                     ; 151     LT_WriteReg(4, 0x9c, 0xc9);
3458  0169 4bc9          	push	#201
3459  016b ae009c        	ldw	x,#156
3460  016e a604          	ld	a,#4
3461  0170 95            	ld	xh,a
3462  0171 cd008e        	call	_LT_WriteReg
3464  0174 84            	pop	a
3465                     ; 152     LT_WriteReg(5, 0x66, 0x37);
3467  0175 4b37          	push	#55
3468  0177 ae0066        	ldw	x,#102
3469  017a a605          	ld	a,#5
3470  017c 95            	ld	xh,a
3471  017d cd008e        	call	_LT_WriteReg
3473  0180 84            	pop	a
3474                     ; 153     LT_WriteReg(7, 0x00, 0x30); //  0x00 0x30
3476  0181 4b30          	push	#48
3477  0183 5f            	clrw	x
3478  0184 a607          	ld	a,#7
3479  0186 95            	ld	xh,a
3480  0187 cd008e        	call	_LT_WriteReg
3482  018a 84            	pop	a
3483                     ; 154     LT_WriteReg(8, 0x6c, 0x90);
3485  018b 4b90          	push	#144
3486  018d ae006c        	ldw	x,#108
3487  0190 a608          	ld	a,#8
3488  0192 95            	ld	xh,a
3489  0193 cd008e        	call	_LT_WriteReg
3491  0196 84            	pop	a
3492                     ; 155     LT_WriteReg(9, 0x18, 0x40);		//  0x18 0x40			// 5.5dBm
3494  0197 4b40          	push	#64
3495  0199 ae0018        	ldw	x,#24
3496  019c a609          	ld	a,#9
3497  019e 95            	ld	xh,a
3498  019f cd008e        	call	_LT_WriteReg
3500  01a2 84            	pop	a
3501                     ; 156     LT_WriteReg(10, 0x7f, 0xfd);
3503  01a3 4bfd          	push	#253
3504  01a5 ae007f        	ldw	x,#127
3505  01a8 a60a          	ld	a,#10
3506  01aa 95            	ld	xh,a
3507  01ab cd008e        	call	_LT_WriteReg
3509  01ae 84            	pop	a
3510                     ; 157     LT_WriteReg(11, 0x00, 0x08);
3512  01af 4b08          	push	#8
3513  01b1 5f            	clrw	x
3514  01b2 a60b          	ld	a,#11
3515  01b4 95            	ld	xh,a
3516  01b5 cd008e        	call	_LT_WriteReg
3518  01b8 84            	pop	a
3519                     ; 158     LT_WriteReg(12, 0x00, 0x00);
3521  01b9 4b00          	push	#0
3522  01bb 5f            	clrw	x
3523  01bc a60c          	ld	a,#12
3524  01be 95            	ld	xh,a
3525  01bf cd008e        	call	_LT_WriteReg
3527  01c2 84            	pop	a
3528                     ; 159     LT_WriteReg(13, 0x48, 0xbd);
3530  01c3 4bbd          	push	#189
3531  01c5 ae0048        	ldw	x,#72
3532  01c8 a60d          	ld	a,#13
3533  01ca 95            	ld	xh,a
3534  01cb cd008e        	call	_LT_WriteReg
3536  01ce 84            	pop	a
3537                     ; 161     LT_WriteReg(22, 0x00, 0xff);
3539  01cf 4bff          	push	#255
3540  01d1 5f            	clrw	x
3541  01d2 a616          	ld	a,#22
3542  01d4 95            	ld	xh,a
3543  01d5 cd008e        	call	_LT_WriteReg
3545  01d8 84            	pop	a
3546                     ; 162     LT_WriteReg(23, 0x80, 0x05);
3548  01d9 4b05          	push	#5
3549  01db ae0080        	ldw	x,#128
3550  01de a617          	ld	a,#23
3551  01e0 95            	ld	xh,a
3552  01e1 cd008e        	call	_LT_WriteReg
3554  01e4 84            	pop	a
3555                     ; 163     LT_WriteReg(24, 0x00, 0x67);
3557  01e5 4b67          	push	#103
3558  01e7 5f            	clrw	x
3559  01e8 a618          	ld	a,#24
3560  01ea 95            	ld	xh,a
3561  01eb cd008e        	call	_LT_WriteReg
3563  01ee 84            	pop	a
3564                     ; 164     LT_WriteReg(25, 0x16, 0x59);
3566  01ef 4b59          	push	#89
3567  01f1 ae0016        	ldw	x,#22
3568  01f4 a619          	ld	a,#25
3569  01f6 95            	ld	xh,a
3570  01f7 cd008e        	call	_LT_WriteReg
3572  01fa 84            	pop	a
3573                     ; 165     LT_WriteReg(26, 0x19, 0xe0);
3575  01fb 4be0          	push	#224
3576  01fd ae0019        	ldw	x,#25
3577  0200 a61a          	ld	a,#26
3578  0202 95            	ld	xh,a
3579  0203 cd008e        	call	_LT_WriteReg
3581  0206 84            	pop	a
3582                     ; 166     LT_WriteReg(27, 0x13, 0x00);
3584  0207 4b00          	push	#0
3585  0209 ae0013        	ldw	x,#19
3586  020c a61b          	ld	a,#27
3587  020e 95            	ld	xh,a
3588  020f cd008e        	call	_LT_WriteReg
3590  0212 84            	pop	a
3591                     ; 167     LT_WriteReg(28, 0x18, 0x00);
3593  0213 4b00          	push	#0
3594  0215 ae0018        	ldw	x,#24
3595  0218 a61c          	ld	a,#28
3596  021a 95            	ld	xh,a
3597  021b cd008e        	call	_LT_WriteReg
3599  021e 84            	pop	a
3600                     ; 170     LT_WriteReg(32, 0x48, 0x00); //  0x40 0x00   8  f1==48
3602  021f 4b00          	push	#0
3603  0221 ae0048        	ldw	x,#72
3604  0224 a620          	ld	a,#32
3605  0226 95            	ld	xh,a
3606  0227 cd008e        	call	_LT_WriteReg
3608  022a 84            	pop	a
3609                     ; 171     LT_WriteReg(33, 0x3f, 0xc7);
3611  022b 4bc7          	push	#199
3612  022d ae003f        	ldw	x,#63
3613  0230 a621          	ld	a,#33
3614  0232 95            	ld	xh,a
3615  0233 cd008e        	call	_LT_WriteReg
3617  0236 84            	pop	a
3618                     ; 172     LT_WriteReg(34, 0x20, 0x00);
3620  0237 4b00          	push	#0
3621  0239 ae0020        	ldw	x,#32
3622  023c a622          	ld	a,#34
3623  023e 95            	ld	xh,a
3624  023f cd008e        	call	_LT_WriteReg
3626  0242 84            	pop	a
3627                     ; 173     LT_WriteReg(35, 0x03, 0x00); //  3
3629  0243 4b00          	push	#0
3630  0245 ae0003        	ldw	x,#3
3631  0248 a623          	ld	a,#35
3632  024a 95            	ld	xh,a
3633  024b cd008e        	call	_LT_WriteReg
3635  024e 84            	pop	a
3636                     ; 174     LT_WriteReg(36, 0x03, 0x80); //  start ID
3638  024f 4b80          	push	#128
3639  0251 ae0003        	ldw	x,#3
3640  0254 a624          	ld	a,#36
3641  0256 95            	ld	xh,a
3642  0257 cd008e        	call	_LT_WriteReg
3644  025a 84            	pop	a
3645                     ; 175     LT_WriteReg(37, 0x03, 0x80);
3647  025b 4b80          	push	#128
3648  025d ae0003        	ldw	x,#3
3649  0260 a625          	ld	a,#37
3650  0262 95            	ld	xh,a
3651  0263 cd008e        	call	_LT_WriteReg
3653  0266 84            	pop	a
3654                     ; 176     LT_WriteReg(38, 0x5a, 0x5a);
3656  0267 4b5a          	push	#90
3657  0269 ae005a        	ldw	x,#90
3658  026c a626          	ld	a,#38
3659  026e 95            	ld	xh,a
3660  026f cd008e        	call	_LT_WriteReg
3662  0272 84            	pop	a
3663                     ; 177     LT_WriteReg(39, 0x03, 0x80); //  end ID
3665  0273 4b80          	push	#128
3666  0275 ae0003        	ldw	x,#3
3667  0278 a627          	ld	a,#39
3668  027a 95            	ld	xh,a
3669  027b cd008e        	call	_LT_WriteReg
3671  027e 84            	pop	a
3672                     ; 178     LT_WriteReg(40, 0x44, 0x02);
3674  027f 4b02          	push	#2
3675  0281 ae0044        	ldw	x,#68
3676  0284 a628          	ld	a,#40
3677  0286 95            	ld	xh,a
3678  0287 cd008e        	call	_LT_WriteReg
3680  028a 84            	pop	a
3681                     ; 180     LT_WriteReg(41, 0xB8, 0x00); // 修改为低有效 ,防止无效的时候就是高电平
3683  028b 4b00          	push	#0
3684  028d ae00b8        	ldw	x,#184
3685  0290 a629          	ld	a,#41
3686  0292 95            	ld	xh,a
3687  0293 cd008e        	call	_LT_WriteReg
3689  0296 84            	pop	a
3690                     ; 181     LT_WriteReg(42, 0xfd, 0xb0);  //
3692  0297 4bb0          	push	#176
3693  0299 ae00fd        	ldw	x,#253
3694  029c a62a          	ld	a,#42
3695  029e 95            	ld	xh,a
3696  029f cd008e        	call	_LT_WriteReg
3698  02a2 84            	pop	a
3699                     ; 182     LT_WriteReg(43, 0x00, 0x0f);
3701  02a3 4b0f          	push	#15
3702  02a5 5f            	clrw	x
3703  02a6 a62b          	ld	a,#43
3704  02a8 95            	ld	xh,a
3705  02a9 cd008e        	call	_LT_WriteReg
3707  02ac 84            	pop	a
3708                     ; 183     LT_WriteReg(50, 0x00, 0x00);
3710  02ad 4b00          	push	#0
3711  02af 5f            	clrw	x
3712  02b0 a632          	ld	a,#50
3713  02b2 95            	ld	xh,a
3714  02b3 cd008e        	call	_LT_WriteReg
3716  02b6 84            	pop	a
3717                     ; 184     mdelay(200);
3719  02b7 ae00c8        	ldw	x,#200
3720  02ba cd0000        	call	_mdelay
3722                     ; 185     LT_WriteReg(7, 0x00, 0x30);
3724  02bd 4b30          	push	#48
3725  02bf 5f            	clrw	x
3726  02c0 a607          	ld	a,#7
3727  02c2 95            	ld	xh,a
3728  02c3 cd008e        	call	_LT_WriteReg
3730  02c6 84            	pop	a
3731                     ; 186 	mdelay(50); //delay 10ms to let LT8900 for operation
3733  02c7 ae0032        	ldw	x,#50
3734  02ca cd0000        	call	_mdelay
3736                     ; 191 	mLT8900.up_id = eeprom_rdchar(0);
3738  02cd 5f            	clrw	x
3739  02ce cd0000        	call	_eeprom_rdchar
3741  02d1 b739          	ld	_mLT8900+40,a
3742                     ; 192 	mLT8900.CH = mLT8900.up_id; //idUser;
3744  02d3 453931        	mov	_mLT8900+32,_mLT8900+40
3745                     ; 193 	mLT8900.status = RX_Status;
3747  02d6 35020011      	mov	_mLT8900,#2
3748                     ; 194 	mLT8900.matchStatus = 0; //设置成未匹配状态
3750  02da 3f30          	clr	_mLT8900+31
3751                     ; 195 	Get_chipId(); // mLT8900.down_id;
3753  02dc cd00bd        	call	_Get_chipId
3755                     ; 198 	LT_WriteReg(7,  0x00, 0x00);
3757  02df 4b00          	push	#0
3758  02e1 5f            	clrw	x
3759  02e2 a607          	ld	a,#7
3760  02e4 95            	ld	xh,a
3761  02e5 cd008e        	call	_LT_WriteReg
3763  02e8 84            	pop	a
3764                     ; 199 	LT_WriteReg(52, 0x80, 0x80);			// 清空接收缓存区
3766  02e9 4b80          	push	#128
3767  02eb ae0080        	ldw	x,#128
3768  02ee a634          	ld	a,#52
3769  02f0 95            	ld	xh,a
3770  02f1 cd008e        	call	_LT_WriteReg
3772  02f4 84            	pop	a
3773                     ; 200 	LT_WriteReg(7,  0x00, 0x80|mLT8900.CH);	// 允许接收使能
3775  02f5 b631          	ld	a,_mLT8900+32
3776  02f7 aa80          	or	a,#128
3777  02f9 88            	push	a
3778  02fa 5f            	clrw	x
3779  02fb a607          	ld	a,#7
3780  02fd 95            	ld	xh,a
3781  02fe cd008e        	call	_LT_WriteReg
3783  0301 84            	pop	a
3784                     ; 202 }
3787  0302 81            	ret
3831                     ; 206 void SPI_WriteByte(unsigned char bcdVal)
3831                     ; 207 {
3832                     	switch	.text
3833  0303               _SPI_WriteByte:
3835  0303 88            	push	a
3836  0304 89            	pushw	x
3837       00000002      OFST:	set	2
3840                     ; 208 	int i = 0;
3842  0305 5f            	clrw	x
3843  0306 1f01          	ldw	(OFST-1,sp),x
3844                     ; 210 	LT_CS_ClrVal();
3846  0308 72175000      	bres	20480,#3
3847                     ; 212 	for(i=0;i<8;i++)
3849  030c 5f            	clrw	x
3850  030d 1f01          	ldw	(OFST-1,sp),x
3851  030f               L5522:
3852                     ; 215     	if(bcdVal&0x80)
3854  030f 7b03          	ld	a,(OFST+1,sp)
3855  0311 a580          	bcp	a,#128
3856  0313 2706          	jreq	L3622
3857                     ; 217         	LT_MOSI_SetVal();
3859  0315 721e500a      	bset	20490,#7
3861  0319 2004          	jra	L5622
3862  031b               L3622:
3863                     ; 221         	LT_MOSI_ClrVal();   
3865  031b 721f500a      	bres	20490,#7
3866  031f               L5622:
3867                     ; 224     	bcdVal<<=1;
3869  031f 0803          	sll	(OFST+1,sp)
3870                     ; 225     	delay2_5US_1(1);
3872  0321 ae0001        	ldw	x,#1
3873  0324 cd002a        	call	_delay2_5US_1
3875                     ; 226     	LT_CLK_ClrVal();
3877  0327 721b500a      	bres	20490,#5
3878                     ; 227     	delay2_5US_1(1);
3880  032b ae0001        	ldw	x,#1
3881  032e cd002a        	call	_delay2_5US_1
3883                     ; 228     	LT_CLK_SetVal();
3885  0331 721a500a      	bset	20490,#5
3886                     ; 212 	for(i=0;i<8;i++)
3888  0335 1e01          	ldw	x,(OFST-1,sp)
3889  0337 1c0001        	addw	x,#1
3890  033a 1f01          	ldw	(OFST-1,sp),x
3893  033c 9c            	rvf
3894  033d 1e01          	ldw	x,(OFST-1,sp)
3895  033f a30008        	cpw	x,#8
3896  0342 2fcb          	jrslt	L5522
3897                     ; 231 	LT_CS_SetVal();
3899  0344 72165000      	bset	20480,#3
3900                     ; 232 }
3903  0348 5b03          	addw	sp,#3
3904  034a 81            	ret
3948                     ; 235 u8  SPI_ReadByte(void)
3948                     ; 236 {
3949                     	switch	.text
3950  034b               _SPI_ReadByte:
3952  034b 5203          	subw	sp,#3
3953       00000003      OFST:	set	3
3956                     ; 237 	int i = 0;
3958  034d 1e01          	ldw	x,(OFST-2,sp)
3959                     ; 238 	u8 data=0;
3961  034f 0f03          	clr	(OFST+0,sp)
3962                     ; 240 	for(i=0;i<8;i++)
3964  0351 5f            	clrw	x
3965  0352 1f01          	ldw	(OFST-2,sp),x
3966  0354               L1132:
3967                     ; 242     	delay2_5US_1(1);
3969  0354 ae0001        	ldw	x,#1
3970  0357 cd002a        	call	_delay2_5US_1
3972                     ; 243     	LT_CLK_SetVal();
3974  035a 721a500a      	bset	20490,#5
3975                     ; 244         data<<=1;
3977  035e 0803          	sll	(OFST+0,sp)
3978                     ; 245     	if(LT_MISO)
3980  0360 c6500b        	ld	a,20491
3981  0363 a440          	and	a,#64
3982  0365 c7500b        	ld	20491,a
3983  0368 2706          	jreq	L7132
3984                     ; 247         	data|=(0x01);     	
3986  036a 7b03          	ld	a,(OFST+0,sp)
3987  036c aa01          	or	a,#1
3988  036e 6b03          	ld	(OFST+0,sp),a
3989  0370               L7132:
3990                     ; 249     	delay2_5US_1(1);
3992  0370 ae0001        	ldw	x,#1
3993  0373 cd002a        	call	_delay2_5US_1
3995                     ; 250     	LT_CLK_ClrVal();
3997  0376 721b500a      	bres	20490,#5
3998                     ; 240 	for(i=0;i<8;i++)
4000  037a 1e01          	ldw	x,(OFST-2,sp)
4001  037c 1c0001        	addw	x,#1
4002  037f 1f01          	ldw	(OFST-2,sp),x
4005  0381 9c            	rvf
4006  0382 1e01          	ldw	x,(OFST-2,sp)
4007  0384 a30008        	cpw	x,#8
4008  0387 2fcb          	jrslt	L1132
4009                     ; 253 	return data;
4011  0389 7b03          	ld	a,(OFST+0,sp)
4014  038b 5b03          	addw	sp,#3
4015  038d 81            	ret
4018                     	bsct
4019  0000               _dataStatus:
4020  0000 00            	dc.b	0
4057                     ; 261 void LT_ReadReg(unsigned char reg)
4057                     ; 262 {
4058                     	switch	.text
4059  038e               _LT_ReadReg:
4061  038e 88            	push	a
4062       00000000      OFST:	set	0
4065                     ; 263 	LT_CS_ClrVal();
4067  038f 72175000      	bres	20480,#3
4068                     ; 264 	delay2_5US_1(4);
4070  0393 ae0004        	ldw	x,#4
4071  0396 cd002a        	call	_delay2_5US_1
4073                     ; 265 	dataStatus=SPI_SendByte(READ | reg);
4075  0399 7b01          	ld	a,(OFST+1,sp)
4076  039b aa80          	or	a,#128
4077  039d cd003a        	call	_SPI_SendByte
4079  03a0 b700          	ld	_dataStatus,a
4080                     ; 266 	delay2_5US_1(4);
4082  03a2 ae0004        	ldw	x,#4
4083  03a5 cd002a        	call	_delay2_5US_1
4085                     ; 267 	RegH = SPI_SendByte(0xFF);//  0xFF  0
4087  03a8 a6ff          	ld	a,#255
4088  03aa cd003a        	call	_SPI_SendByte
4090  03ad b73f          	ld	_RegH,a
4091                     ; 268 	delay2_5US_1(4);
4093  03af ae0004        	ldw	x,#4
4094  03b2 cd002a        	call	_delay2_5US_1
4096                     ; 269 	RegL = SPI_SendByte(0xFF);//  0xFF  0
4098  03b5 a6ff          	ld	a,#255
4099  03b7 cd003a        	call	_SPI_SendByte
4101  03ba b73e          	ld	_RegL,a
4102                     ; 270 	delay2_5US_1(4);
4104  03bc ae0004        	ldw	x,#4
4105  03bf cd002a        	call	_delay2_5US_1
4107                     ; 271 	LT_CS_SetVal();
4109  03c2 72165000      	bset	20480,#3
4110                     ; 273 }  
4113  03c6 84            	pop	a
4114  03c7 81            	ret
4138                     ; 275 void LT_TO_IDLE(void)
4138                     ; 276 {
4139                     	switch	.text
4140  03c8               _LT_TO_IDLE:
4144                     ; 277 	LT_WriteReg(7, 0x00, 0x00);			  //goto idle mode
4146  03c8 4b00          	push	#0
4147  03ca 5f            	clrw	x
4148  03cb a607          	ld	a,#7
4149  03cd 95            	ld	xh,a
4150  03ce cd008e        	call	_LT_WriteReg
4152  03d1 84            	pop	a
4153                     ; 278 }
4156  03d2 81            	ret
4181                     ; 280 void LT_StartRx(void)
4181                     ; 281 {
4182                     	switch	.text
4183  03d3               _LT_StartRx:
4187                     ; 282 	LT_WriteReg( 7, 0x00, 0x00); 
4189  03d3 4b00          	push	#0
4190  03d5 5f            	clrw	x
4191  03d6 a607          	ld	a,#7
4192  03d8 95            	ld	xh,a
4193  03d9 cd008e        	call	_LT_WriteReg
4195  03dc 84            	pop	a
4196                     ; 283 	LT_WriteReg(52, 0x80, 0x80);			// 清空发送缓存区
4198  03dd 4b80          	push	#128
4199  03df ae0080        	ldw	x,#128
4200  03e2 a634          	ld	a,#52
4201  03e4 95            	ld	xh,a
4202  03e5 cd008e        	call	_LT_WriteReg
4204  03e8 84            	pop	a
4205                     ; 284 	LT_WriteReg(7, 0x00, 0x80|mLT8900.CH);  // 允许接收使能
4207  03e9 b631          	ld	a,_mLT8900+32
4208  03eb aa80          	or	a,#128
4209  03ed 88            	push	a
4210  03ee 5f            	clrw	x
4211  03ef a607          	ld	a,#7
4212  03f1 95            	ld	xh,a
4213  03f2 cd008e        	call	_LT_WriteReg
4215  03f5 84            	pop	a
4216                     ; 285 	mLT8900.status = RX_Status;
4218  03f6 35020011      	mov	_mLT8900,#2
4219                     ; 286 	mLT8900.ACK_Lost_cnt = 0;
4221  03fa 3f35          	clr	_mLT8900+36
4222                     ; 287 }
4225  03fc 81            	ret
4260                     ; 289 void mdelay_1(u16 ms)
4260                     ; 290 {
4261                     	switch	.text
4262  03fd               _mdelay_1:
4266                     ; 291   mdelay(ms);
4268  03fd cd0000        	call	_mdelay
4270                     ; 292 }
4273  0400 81            	ret
4299                     ; 294 void LT_comm_status_pack(void)
4299                     ; 295 {
4300                     	switch	.text
4301  0401               _LT_comm_status_pack:
4305                     ; 296 	mLT8900.TLen = 5;
4307  0401 3505002f      	mov	_mLT8900+30,#5
4308                     ; 298 	mLT8900.TBUF[1] = 0xF8;
4310  0405 35f80015      	mov	_mLT8900+4,#248
4311                     ; 300 	if (mDEV.error_code == 0)
4313  0409 725d0007      	tnz	_mDEV+7
4314  040d 261e          	jrne	L5042
4315                     ; 302 		mLT8900.TBUF[3] = mDEV.machine_state;
4317  040f 55000a0017    	mov	_mLT8900+6,_mDEV+10
4318                     ; 304 		if (mDEV.machine_state  == MACHINE_STATE_RUN)
4320  0414 c6000a        	ld	a,_mDEV+10
4321  0417 a101          	cp	a,#1
4322  0419 260e          	jrne	L7042
4323                     ; 306 			mLT8900.TBUF[4] = (mDEV.rpm_target_new/RPM_STEP_USER);
4325  041b ce0013        	ldw	x,_mDEV+19
4326  041e 90ae0190      	ldw	y,#400
4327  0422 65            	divw	x,y
4328  0423 01            	rrwa	x,a
4329  0424 b718          	ld	_mLT8900+7,a
4330  0426 02            	rlwa	x,a
4332  0427 200d          	jra	L3142
4333  0429               L7042:
4334                     ; 310 			mLT8900.TBUF[4] = 0;
4336  0429 3f18          	clr	_mLT8900+7
4337  042b 2009          	jra	L3142
4338  042d               L5042:
4339                     ; 315 		mLT8900.TBUF[3] = 0x3;  // 出错
4341  042d 35030017      	mov	_mLT8900+6,#3
4342                     ; 316 		mLT8900.TBUF[4] = mDEV.error_code;
4344  0431 5500070018    	mov	_mLT8900+7,_mDEV+7
4345  0436               L3142:
4346                     ; 320 	mLT8900.TBUF[5] = mDEV.machine_mode; //模式 
4348  0436 5500120019    	mov	_mLT8900+8,_mDEV+18
4349                     ; 321 	mLT8900.TBUF[2] = LT_CMD_STATUS;
4351  043b 35020016      	mov	_mLT8900+5,#2
4352                     ; 323 }
4355  043f 81            	ret
4408                     ; 326 u8 LT8900_check_data(void)
4408                     ; 327 {
4409                     	switch	.text
4410  0440               _LT8900_check_data:
4412  0440 5203          	subw	sp,#3
4413       00000003      OFST:	set	3
4416                     ; 330 	xor_crc = 0;
4418  0442 7b01          	ld	a,(OFST-2,sp)
4419  0444 97            	ld	xl,a
4420                     ; 331 	add_crc = 0;
4422  0445 0f02          	clr	(OFST-1,sp)
4423                     ; 334 	for (i=1;i<10;i++)
4425  0447 a601          	ld	a,#1
4426  0449 6b03          	ld	(OFST+0,sp),a
4427  044b               L3442:
4428                     ; 336 		add_crc=add_crc + mLT8900.RBUF[i];
4430  044b 7b03          	ld	a,(OFST+0,sp)
4431  044d 5f            	clrw	x
4432  044e 97            	ld	xl,a
4433  044f 7b02          	ld	a,(OFST-1,sp)
4434  0451 eb22          	add	a,(_mLT8900+17,x)
4435  0453 6b02          	ld	(OFST-1,sp),a
4436                     ; 334 	for (i=1;i<10;i++)
4438  0455 0c03          	inc	(OFST+0,sp)
4441  0457 7b03          	ld	a,(OFST+0,sp)
4442  0459 a10a          	cp	a,#10
4443  045b 25ee          	jrult	L3442
4444                     ; 340 	if ((mLT8900.RBUF[1] == 0xF7)&&
4444                     ; 341 		(mLT8900.RBUF[10] == add_crc)&&
4444                     ; 342 		(mLT8900.RBUF[11] == 0xFD))
4446  045d b623          	ld	a,_mLT8900+18
4447  045f a1f7          	cp	a,#247
4448  0461 262b          	jrne	L1542
4450  0463 b62c          	ld	a,_mLT8900+27
4451  0465 1102          	cp	a,(OFST-1,sp)
4452  0467 2625          	jrne	L1542
4454  0469 b62d          	ld	a,_mLT8900+28
4455  046b a1fd          	cp	a,#253
4456  046d 261f          	jrne	L1542
4457                     ; 345 		if (mLT8900.matchStatus == 0)
4459  046f 3d30          	tnz	_mLT8900+31
4460  0471 260d          	jrne	L3542
4461                     ; 347 			if (mLT8900.RBUF[2] != mLT8900.up_id)
4463  0473 b624          	ld	a,_mLT8900+19
4464  0475 b139          	cp	a,_mLT8900+40
4465  0477 2703          	jreq	L5542
4466                     ; 349 				mLT8900.up_id = mLT8900.RBUF[2];
4468  0479 452439        	mov	_mLT8900+40,_mLT8900+19
4469  047c               L5542:
4470                     ; 352 			return 1;
4472  047c a601          	ld	a,#1
4474  047e 2007          	jra	L44
4475  0480               L3542:
4476                     ; 356 			if (mLT8900.RBUF[2] != mLT8900.up_id)
4478  0480 b624          	ld	a,_mLT8900+19
4479  0482 b139          	cp	a,_mLT8900+40
4480  0484 2704          	jreq	L1642
4481                     ; 358 				return 0;
4483  0486 4f            	clr	a
4485  0487               L44:
4487  0487 5b03          	addw	sp,#3
4488  0489 81            	ret
4489  048a               L1642:
4490                     ; 362 				return 1;
4492  048a a601          	ld	a,#1
4494  048c 20f9          	jra	L44
4495  048e               L1542:
4496                     ; 369 		return 0;
4498  048e 4f            	clr	a
4500  048f 20f6          	jra	L44
4547                     ; 374 void LT8900_unpack_data(void)
4547                     ; 375 {
4548                     	switch	.text
4549  0491               _LT8900_unpack_data:
4551  0491 5205          	subw	sp,#5
4552       00000005      OFST:	set	5
4555                     ; 379 	if (mLT8900.RBUF[7] == mLT8900.down_id)
4557  0493 b629          	ld	a,_mLT8900+24
4558  0495 b13a          	cp	a,_mLT8900+41
4559  0497 2703          	jreq	L25
4560  0499 cc056a        	jp	L1152
4561  049c               L25:
4562                     ; 382 		temp8 =  mLT8900.RBUF[3] &0x80;
4564  049c b625          	ld	a,_mLT8900+20
4565  049e a480          	and	a,#128
4566  04a0 6b05          	ld	(OFST+0,sp),a
4567                     ; 383 		if (temp8 == 0x80)
4569  04a2 7b05          	ld	a,(OFST+0,sp)
4570  04a4 a180          	cp	a,#128
4571  04a6 2604          	jrne	L3152
4572                     ; 385 			mLT8900.new_request = 0;
4574  04a8 3f3c          	clr	_mLT8900+43
4576  04aa 2009          	jra	L5152
4577  04ac               L3152:
4578                     ; 390 			if(mLT8900.new_request == 1)
4580  04ac b63c          	ld	a,_mLT8900+43
4581  04ae a101          	cp	a,#1
4582  04b0 2603          	jrne	L45
4583  04b2 cc056a        	jp	L05
4584  04b5               L45:
4585                     ; 392 				return;
4587  04b5               L5152:
4588                     ; 396 		temp8 = mLT8900.RBUF[3] & 0x01;
4590  04b5 b625          	ld	a,_mLT8900+20
4591  04b7 a401          	and	a,#1
4592  04b9 6b05          	ld	(OFST+0,sp),a
4593                     ; 397 		if (temp8 == 0x01)
4595  04bb 7b05          	ld	a,(OFST+0,sp)
4596  04bd a101          	cp	a,#1
4597  04bf 2611          	jrne	L1252
4598                     ; 399 			if(mDEV.machine_state != MACHINE_STATE_RUN)
4600  04c1 c6000a        	ld	a,_mDEV+10
4601  04c4 a101          	cp	a,#1
4602  04c6 2718          	jreq	L5252
4603                     ; 401 				mDEV.machine_state_request=STATE_REQUEST_RUN;
4605  04c8 35010015      	mov	_mDEV+21,#1
4606                     ; 402 				mDEV.newStatusToBT = 1;
4608  04cc 35010016      	mov	_mDEV+22,#1
4609  04d0 200e          	jra	L5252
4610  04d2               L1252:
4611                     ; 407 			if(mDEV.machine_state != MACHINE_STATE_IDLE)
4613  04d2 725d000a      	tnz	_mDEV+10
4614  04d6 2708          	jreq	L5252
4615                     ; 409 				mDEV.machine_state_request=STATE_REQUEST_IDLE;
4617  04d8 725f0015      	clr	_mDEV+21
4618                     ; 410 				mDEV.newStatusToBT = 1;
4620  04dc 35010016      	mov	_mDEV+22,#1
4621  04e0               L5252:
4622                     ; 414 		temp8 =  mLT8900.RBUF[3] &0x02;
4624  04e0 b625          	ld	a,_mLT8900+20
4625  04e2 a402          	and	a,#2
4626  04e4 6b05          	ld	(OFST+0,sp),a
4627                     ; 415 		if (temp8 == 0x02)
4629  04e6 7b05          	ld	a,(OFST+0,sp)
4630  04e8 a102          	cp	a,#2
4631  04ea 2606          	jrne	L1352
4632                     ; 417 			mLT8900.flag_version = 1;
4634  04ec 3501003d      	mov	_mLT8900+44,#1
4636  04f0 2002          	jra	L3352
4637  04f2               L1352:
4638                     ; 421 			mLT8900.flag_version = 0;
4640  04f2 3f3d          	clr	_mLT8900+44
4641  04f4               L3352:
4642                     ; 428 			temp8= mLT8900.RBUF[4];
4644  04f4 b626          	ld	a,_mLT8900+21
4645  04f6 6b05          	ld	(OFST+0,sp),a
4646                     ; 429 			if (mUSER.hz!= temp8 && temp8 <= 60)
4648  04f8 7b05          	ld	a,(OFST+0,sp)
4649  04fa 5f            	clrw	x
4650  04fb 97            	ld	xl,a
4651  04fc bf00          	ldw	c_x,x
4652  04fe be0b          	ldw	x,_mUSER+11
4653  0500 b300          	cpw	x,c_x
4654  0502 270c          	jreq	L5352
4656  0504 7b05          	ld	a,(OFST+0,sp)
4657  0506 a13d          	cp	a,#61
4658  0508 2406          	jruge	L5352
4659                     ; 431 				mUSER.hz = temp8;
4661  050a 7b05          	ld	a,(OFST+0,sp)
4662  050c 5f            	clrw	x
4663  050d 97            	ld	xl,a
4664  050e bf0b          	ldw	_mUSER+11,x
4665  0510               L5352:
4666                     ; 435 		if(mDEV.machine_state == MACHINE_STATE_RUN)
4668  0510 c6000a        	ld	a,_mDEV+10
4669  0513 a101          	cp	a,#1
4670  0515 260c          	jrne	L7352
4671                     ; 437 			mDEV.rpm_target_new = mUSER.hz * RPM_STEP_USER;
4673  0517 be0b          	ldw	x,_mUSER+11
4674  0519 90ae0190      	ldw	y,#400
4675  051d cd0000        	call	c_imul
4677  0520 cf0013        	ldw	_mDEV+19,x
4678  0523               L7352:
4679                     ; 441 		temp8 = mLT8900.RBUF[5]>>4;
4681  0523 b627          	ld	a,_mLT8900+22
4682  0525 4e            	swap	a
4683  0526 a40f          	and	a,#15
4684  0528 6b05          	ld	(OFST+0,sp),a
4685                     ; 442 		if (temp8 != mLT8900.last_index)
4687  052a 7b05          	ld	a,(OFST+0,sp)
4688  052c b136          	cp	a,_mLT8900+37
4689  052e 2709          	jreq	L1452
4690                     ; 444 			mLT8900.last_index = temp8;
4692  0530 7b05          	ld	a,(OFST+0,sp)
4693  0532 b736          	ld	_mLT8900+37,a
4694                     ; 445 			Beep(BEEP_KEY);
4696  0534 a601          	ld	a,#1
4697  0536 cd0000        	call	_Beep
4699  0539               L1452:
4700                     ; 449 		temp8 = mLT8900.RBUF[5] & 0x0F;  // 低四位表示模式
4702  0539 b627          	ld	a,_mLT8900+22
4703  053b a40f          	and	a,#15
4704  053d 6b05          	ld	(OFST+0,sp),a
4705                     ; 450 		if (mDEV.machine_state != MACHINE_STATE_RUN)
4707  053f c6000a        	ld	a,_mDEV+10
4708  0542 a101          	cp	a,#1
4709  0544 2708          	jreq	L3452
4710                     ; 452 			mUSER.machine_mode = temp8;
4712  0546 7b05          	ld	a,(OFST+0,sp)
4713  0548 b703          	ld	_mUSER+3,a
4714                     ; 453 			mDEV.newStatusToBT = 1;
4716  054a 35010016      	mov	_mDEV+22,#1
4717  054e               L3452:
4718                     ; 456 		temp16 = mLT8900.RBUF[8]>>8;
4720  054e 5f            	clrw	x
4721  054f 1f03          	ldw	(OFST-2,sp),x
4722                     ; 457 		temp16 += mLT8900.RBUF[9];
4724  0551 b62b          	ld	a,_mLT8900+26
4725  0553 5f            	clrw	x
4726  0554 97            	ld	xl,a
4727  0555 1f01          	ldw	(OFST-4,sp),x
4728  0557 1e03          	ldw	x,(OFST-2,sp)
4729  0559 72fb01        	addw	x,(OFST-4,sp)
4730  055c 1f03          	ldw	(OFST-2,sp),x
4731                     ; 458 		if(temp16 != 0)
4733  055e 1e03          	ldw	x,(OFST-2,sp)
4734  0560 2708          	jreq	L1152
4735                     ; 460 			mUSER.setting_min   = temp16;
4737  0562 1e03          	ldw	x,(OFST-2,sp)
4738  0564 bf04          	ldw	_mUSER+4,x
4739                     ; 461 			mUSER.flag_time_setting = 1;
4741  0566 35010000      	mov	_mUSER,#1
4742  056a               L1152:
4743                     ; 465 }
4744  056a               L05:
4747  056a 5b05          	addw	sp,#5
4748  056c 81            	ret
4794                     ; 468 void LT8900_pack_data(void)
4794                     ; 469 {
4795                     	switch	.text
4796  056d               _LT8900_pack_data:
4798  056d 89            	pushw	x
4799       00000002      OFST:	set	2
4802                     ; 474 	mLT8900.TBUF[0] =13;
4804  056e 350d0014      	mov	_mLT8900+3,#13
4805                     ; 476 	mLT8900.TBUF[1] =mLT8900.up_id;
4807  0572 453915        	mov	_mLT8900+4,_mLT8900+40
4808                     ; 477 	mLT8900.TBUF[2] =mLT8900.down_id;  	// 下控ID	
4810  0575 453a16        	mov	_mLT8900+5,_mLT8900+41
4811                     ; 478 	if(mUSER.hz < 10)
4813  0578 be0b          	ldw	x,_mUSER+11
4814  057a a3000a        	cpw	x,#10
4815  057d 2405          	jruge	L1752
4816                     ; 480 		mUSER.hz = 10;
4818  057f ae000a        	ldw	x,#10
4819  0582 bf0b          	ldw	_mUSER+11,x
4820  0584               L1752:
4821                     ; 482 	tempc =(mUSER.hz)|(mDEV.machine_state<<7);		
4823  0584 c6000a        	ld	a,_mDEV+10
4824  0587 97            	ld	xl,a
4825  0588 a680          	ld	a,#128
4826  058a 42            	mul	x,a
4827  058b 9f            	ld	a,xl
4828  058c ba0c          	or	a,_mUSER+12
4829  058e 6b02          	ld	(OFST+0,sp),a
4830                     ; 483 	mLT8900.TBUF[3] =tempc;  //  key
4832  0590 7b02          	ld	a,(OFST+0,sp)
4833  0592 b717          	ld	_mLT8900+6,a
4834                     ; 486 	mLT8900.TBUF[4] = mLT8900.new_request<<7;
4836  0594 b63c          	ld	a,_mLT8900+43
4837  0596 97            	ld	xl,a
4838  0597 a680          	ld	a,#128
4839  0599 42            	mul	x,a
4840  059a 9f            	ld	a,xl
4841  059b b718          	ld	_mLT8900+7,a
4842                     ; 487 	mLT8900.TBUF[4] += mUSER.machine_mode;
4844  059d b618          	ld	a,_mLT8900+7
4845  059f bb03          	add	a,_mUSER+3
4846  05a1 b718          	ld	_mLT8900+7,a
4847                     ; 490 	if(mLT8900.flag_version)
4849  05a3 3d3d          	tnz	_mLT8900+44
4850  05a5 2706          	jreq	L3752
4851                     ; 492 		mLT8900.TBUF[5] = VERSION;// 返回下控版本号
4853  05a7 350a0019      	mov	_mLT8900+8,#10
4855  05ab 2005          	jra	L5752
4856  05ad               L3752:
4857                     ; 496 		mLT8900.TBUF[5] = mDEV.error_code;//返回错误
4859  05ad 5500070019    	mov	_mLT8900+8,_mDEV+7
4860  05b2               L5752:
4861                     ; 501 	mLT8900.TBUF[6]= mUSER.setting_min>> 8;
4863  05b2 45041a        	mov	_mLT8900+9,_mUSER+4
4864                     ; 502 	mLT8900.TBUF[7]= mUSER.setting_min;
4866  05b5 45051b        	mov	_mLT8900+10,_mUSER+5
4867                     ; 505 	mLT8900.TBUF[8]= mUSER.run_min >> 8;
4869  05b8 45061c        	mov	_mLT8900+11,_mUSER+6
4870                     ; 506 	mLT8900.TBUF[9]= mUSER.run_min;
4872  05bb 45071d        	mov	_mLT8900+12,_mUSER+7
4873                     ; 509 	mLT8900.TBUF[10]= mUSER.cal>> 8;
4875  05be 45091e        	mov	_mLT8900+13,_mUSER+9
4876                     ; 510 	mLT8900.TBUF[11]= mUSER.cal;
4878  05c1 450a1f        	mov	_mLT8900+14,_mUSER+10
4879                     ; 513 	temp8=0;
4881  05c4 0f01          	clr	(OFST-1,sp)
4882                     ; 514 	for (tempc=1;tempc<12;tempc++)
4884  05c6 a601          	ld	a,#1
4885  05c8 6b02          	ld	(OFST+0,sp),a
4886  05ca               L7752:
4887                     ; 516 		temp8=temp8+mLT8900.TBUF[tempc];
4889  05ca 7b02          	ld	a,(OFST+0,sp)
4890  05cc 5f            	clrw	x
4891  05cd 97            	ld	xl,a
4892  05ce 7b01          	ld	a,(OFST-1,sp)
4893  05d0 eb14          	add	a,(_mLT8900+3,x)
4894  05d2 6b01          	ld	(OFST-1,sp),a
4895                     ; 514 	for (tempc=1;tempc<12;tempc++)
4897  05d4 0c02          	inc	(OFST+0,sp)
4900  05d6 7b02          	ld	a,(OFST+0,sp)
4901  05d8 a10c          	cp	a,#12
4902  05da 25ee          	jrult	L7752
4903                     ; 518 	mLT8900.TBUF[12]=temp8; //checksum
4905  05dc 7b01          	ld	a,(OFST-1,sp)
4906  05de b720          	ld	_mLT8900+15,a
4907                     ; 519 	mLT8900.TBUF[13]=mUSER.run_sec;
4909  05e0 450821        	mov	_mLT8900+16,_mUSER+8
4910                     ; 520 }
4913  05e3 85            	popw	x
4914  05e4 81            	ret
4952                     ; 523 void LT8900_read_data(void)
4952                     ; 524 {
4953                     	switch	.text
4954  05e5               _LT8900_read_data:
4956  05e5 88            	push	a
4957       00000001      OFST:	set	1
4960                     ; 527 	LT_ReadReg(48);
4962  05e6 a630          	ld	a,#48
4963  05e8 cd038e        	call	_LT_ReadReg
4965                     ; 528 	if(!(RegH & 0x80)) // CRC
4967  05eb b63f          	ld	a,_RegH
4968  05ed a580          	bcp	a,#128
4969  05ef 2621          	jrne	L3262
4970                     ; 530 		for(i=0; i<(RX_BUFFLEN/2); i++)
4972  05f1 0f01          	clr	(OFST+0,sp)
4973  05f3               L5262:
4974                     ; 532 			LT_ReadReg(50);
4976  05f3 a632          	ld	a,#50
4977  05f5 cd038e        	call	_LT_ReadReg
4979                     ; 533 			mLT8900.RBUF[i*2]	= RegH;
4981  05f8 7b01          	ld	a,(OFST+0,sp)
4982  05fa 5f            	clrw	x
4983  05fb 97            	ld	xl,a
4984  05fc 58            	sllw	x
4985  05fd b63f          	ld	a,_RegH
4986  05ff e722          	ld	(_mLT8900+17,x),a
4987                     ; 534 			mLT8900.RBUF[i*2+1]	= RegL;
4989  0601 7b01          	ld	a,(OFST+0,sp)
4990  0603 5f            	clrw	x
4991  0604 97            	ld	xl,a
4992  0605 58            	sllw	x
4993  0606 b63e          	ld	a,_RegL
4994  0608 e723          	ld	(_mLT8900+18,x),a
4995                     ; 530 		for(i=0; i<(RX_BUFFLEN/2); i++)
4997  060a 0c01          	inc	(OFST+0,sp)
5000  060c 7b01          	ld	a,(OFST+0,sp)
5001  060e a106          	cp	a,#6
5002  0610 25e1          	jrult	L5262
5003  0612               L3262:
5004                     ; 537 }
5007  0612 84            	pop	a
5008  0613 81            	ret
5045                     ; 539 void LT8900_send_data(void)
5045                     ; 540 {
5046                     	switch	.text
5047  0614               _LT8900_send_data:
5049  0614 88            	push	a
5050       00000001      OFST:	set	1
5053                     ; 543 	LT_WriteReg(7, 0x00, 0x00);
5055  0615 4b00          	push	#0
5056  0617 5f            	clrw	x
5057  0618 a607          	ld	a,#7
5058  061a 95            	ld	xh,a
5059  061b cd008e        	call	_LT_WriteReg
5061  061e 84            	pop	a
5062                     ; 544 	LT_WriteReg(52, 0x80, 0x00);			// 清空发送缓存区
5064  061f 4b00          	push	#0
5065  0621 ae0080        	ldw	x,#128
5066  0624 a634          	ld	a,#52
5067  0626 95            	ld	xh,a
5068  0627 cd008e        	call	_LT_WriteReg
5070  062a 84            	pop	a
5071                     ; 546 	for(i=0; i<=TX_BUFFLEN/2; i++)
5073  062b 0f01          	clr	(OFST+0,sp)
5074  062d               L1562:
5075                     ; 548 		LT_WriteReg(50, mLT8900.TBUF[i*2], mLT8900.TBUF[i*2+1]);
5077  062d 7b01          	ld	a,(OFST+0,sp)
5078  062f 5f            	clrw	x
5079  0630 97            	ld	xl,a
5080  0631 58            	sllw	x
5081  0632 e615          	ld	a,(_mLT8900+4,x)
5082  0634 88            	push	a
5083  0635 7b02          	ld	a,(OFST+1,sp)
5084  0637 5f            	clrw	x
5085  0638 97            	ld	xl,a
5086  0639 58            	sllw	x
5087  063a e614          	ld	a,(_mLT8900+3,x)
5088  063c 97            	ld	xl,a
5089  063d a632          	ld	a,#50
5090  063f 95            	ld	xh,a
5091  0640 cd008e        	call	_LT_WriteReg
5093  0643 84            	pop	a
5094                     ; 546 	for(i=0; i<=TX_BUFFLEN/2; i++)
5096  0644 0c01          	inc	(OFST+0,sp)
5099  0646 7b01          	ld	a,(OFST+0,sp)
5100  0648 a108          	cp	a,#8
5101  064a 25e1          	jrult	L1562
5102                     ; 550 	LT_WriteReg(7, 0x01, mLT8900.CH); // 允许发射使能
5104  064c 3b0031        	push	_mLT8900+32
5105  064f ae0001        	ldw	x,#1
5106  0652 a607          	ld	a,#7
5107  0654 95            	ld	xh,a
5108  0655 cd008e        	call	_LT_WriteReg
5110  0658 84            	pop	a
5111                     ; 553 	mLT8900.time_out = 10; // 10*200us = 2ms
5113  0659 350a0032      	mov	_mLT8900+33,#10
5115  065d 2006          	jra	L3662
5116  065f               L7562:
5117                     ; 556 		if(mLT8900.time_out == 0) // 2ms
5119  065f 3d32          	tnz	_mLT8900+33
5120  0661 2602          	jrne	L3662
5121                     ; 558 			break; // 跳出while
5122  0663               L5662:
5123                     ; 561 }
5126  0663 84            	pop	a
5127  0664 81            	ret
5128  0665               L3662:
5129                     ; 554 	while(PKT_FLAG != 0x01)
5131  0665 c65001        	ld	a,_PA_IDR
5132  0668 a502          	bcp	a,#2
5133  066a 27f3          	jreq	L7562
5134  066c 20f5          	jra	L5662
5165                     ; 563 void LT8900_match_Deal(void)
5165                     ; 564 {
5166                     	switch	.text
5167  066e               _LT8900_match_Deal:
5171                     ; 566 	mLT8900.match_time++;
5173  066e be37          	ldw	x,_mLT8900+38
5174  0670 1c0001        	addw	x,#1
5175  0673 bf37          	ldw	_mLT8900+38,x
5176                     ; 568 	if (mLT8900.match_time > 6000)
5178  0675 be37          	ldw	x,_mLT8900+38
5179  0677 a31771        	cpw	x,#6001
5180  067a 2508          	jrult	L1072
5181                     ; 570 		mLT8900.match_time = 0;
5183  067c 5f            	clrw	x
5184  067d bf37          	ldw	_mLT8900+38,x
5185                     ; 571 		mLT8900.matchStatus = 1;
5187  067f 35010030      	mov	_mLT8900+31,#1
5188                     ; 572 		return;
5191  0683 81            	ret
5192  0684               L1072:
5193                     ; 575 	if (mLT8900.match_time%200==0 && mLT8900.match_time>400)
5195  0684 be37          	ldw	x,_mLT8900+38
5196  0686 a6c8          	ld	a,#200
5197  0688 62            	div	x,a
5198  0689 5f            	clrw	x
5199  068a 97            	ld	xl,a
5200  068b a30000        	cpw	x,#0
5201  068e 2615          	jrne	L3072
5203  0690 be37          	ldw	x,_mLT8900+38
5204  0692 a30191        	cpw	x,#401
5205  0695 250e          	jrult	L3072
5206                     ; 577 		if (mLT8900.CH == LT8900_CH_PUBLIC)
5208  0697 3d31          	tnz	_mLT8900+32
5209  0699 2605          	jrne	L5072
5210                     ; 579 			mLT8900.CH = mLT8900.up_id;
5212  069b 453931        	mov	_mLT8900+32,_mLT8900+40
5214  069e 2002          	jra	L7072
5215  06a0               L5072:
5216                     ; 583 			mLT8900.CH = LT8900_CH_PUBLIC;
5218  06a0 3f31          	clr	_mLT8900+32
5219  06a2               L7072:
5220                     ; 586 		LT_StartRx();
5222  06a2 cd03d3        	call	_LT_StartRx
5224  06a5               L3072:
5225                     ; 589 	if (PKT_FLAG > 0)
5227  06a5 c65001        	ld	a,_PA_IDR
5228  06a8 a502          	bcp	a,#2
5229  06aa 2727          	jreq	L1172
5230                     ; 591 		LT_TO_IDLE();
5232  06ac cd03c8        	call	_LT_TO_IDLE
5234                     ; 592 		LT8900_read_data();
5236  06af cd05e5        	call	_LT8900_read_data
5238                     ; 594 		if (LT8900_check_data() == 1)
5240  06b2 cd0440        	call	_LT8900_check_data
5242  06b5 a101          	cp	a,#1
5243  06b7 261a          	jrne	L1172
5244                     ; 596 			Beep(BEEP_FIND_WIRELESS);
5246  06b9 a603          	ld	a,#3
5247  06bb cd0000        	call	_Beep
5249                     ; 597 			mLT8900.CH=mLT8900.up_id;
5251  06be 453931        	mov	_mLT8900+32,_mLT8900+40
5252                     ; 598 			mLT8900.matchStatus = 1;
5254  06c1 35010030      	mov	_mLT8900+31,#1
5255                     ; 599 			mLT8900.match_time = 0;
5257  06c5 5f            	clrw	x
5258  06c6 bf37          	ldw	_mLT8900+38,x
5259                     ; 601 			eeprom_wrchar(0, mLT8900.up_id);
5261  06c8 3b0039        	push	_mLT8900+40
5262  06cb 5f            	clrw	x
5263  06cc cd0000        	call	_eeprom_wrchar
5265  06cf 84            	pop	a
5266                     ; 602 			LT_StartRx();
5268  06d0 cd03d3        	call	_LT_StartRx
5270  06d3               L1172:
5271                     ; 606 }
5274  06d3 81            	ret
5318                     ; 609 void LT8900_DOWN_Deal(void)
5318                     ; 610 {
5319                     	switch	.text
5320  06d4               _LT8900_DOWN_Deal:
5322  06d4 88            	push	a
5323       00000001      OFST:	set	1
5326                     ; 611 	unsigned char i = 0;
5328  06d5 0f01          	clr	(OFST+0,sp)
5329                     ; 617 	mLT8900.commu_lost_cnt++;
5331  06d7 be12          	ldw	x,_mLT8900+1
5332  06d9 1c0001        	addw	x,#1
5333  06dc bf12          	ldw	_mLT8900+1,x
5334                     ; 619 	if (mLT8900.matchStatus == 0)
5336  06de 3d30          	tnz	_mLT8900+31
5337  06e0 2608          	jrne	L1472
5338                     ; 621 		mLT8900.new_request = 1;
5340  06e2 3501003c      	mov	_mLT8900+43,#1
5341                     ; 622 		LT8900_match_Deal();
5343  06e6 ad86          	call	_LT8900_match_Deal
5345                     ; 623 		return;
5348  06e8 84            	pop	a
5349  06e9 81            	ret
5350  06ea               L1472:
5351                     ; 626 	switch(mLT8900.status)
5353  06ea b611          	ld	a,_mLT8900
5355                     ; 654 		default:
5355                     ; 655 			break;
5356  06ec 4a            	dec	a
5357  06ed 2737          	jreq	L7172
5358  06ef 4a            	dec	a
5359  06f0 263d          	jrne	L5472
5360                     ; 628 		case RX_Status:
5360                     ; 629 			if (PKT_FLAG > 0)// 接收到数据
5362  06f2 c65001        	ld	a,_PA_IDR
5363  06f5 a502          	bcp	a,#2
5364  06f7 271a          	jreq	L7472
5365                     ; 631 				LT_TO_IDLE();
5367  06f9 cd03c8        	call	_LT_TO_IDLE
5369                     ; 632 				LT8900_read_data();
5371  06fc cd05e5        	call	_LT8900_read_data
5373                     ; 633 				if (LT8900_check_data() == 1)
5375  06ff cd0440        	call	_LT8900_check_data
5377  0702 a101          	cp	a,#1
5378  0704 260d          	jrne	L7472
5379                     ; 635 					LT8900_unpack_data();
5381  0706 cd0491        	call	_LT8900_unpack_data
5383                     ; 636 					mLT8900.status = TX_Status;	
5385  0709 35010011      	mov	_mLT8900,#1
5386                     ; 637 					mLT8900.commu_lost_cnt = 0;
5388  070d 5f            	clrw	x
5389  070e bf12          	ldw	_mLT8900+1,x
5390                     ; 638 					LT_TO_IDLE();
5392  0710 cd03c8        	call	_LT_TO_IDLE
5394  0713               L7472:
5395                     ; 642 			if (mLT8900.commu_lost_cnt >= 150) // 150*5=750ms
5397  0713 be12          	ldw	x,_mLT8900+1
5398  0715 a30096        	cpw	x,#150
5399  0718 2515          	jrult	L5472
5400                     ; 644 				mLT8900.commu_lost_cnt  = 0;
5402  071a 5f            	clrw	x
5403  071b bf12          	ldw	_mLT8900+1,x
5404                     ; 645 				mLT8900.new_request = 1;
5406  071d 3501003c      	mov	_mLT8900+43,#1
5407                     ; 646 				LT_StartRx();
5409  0721 cd03d3        	call	_LT_StartRx
5411  0724 2009          	jra	L5472
5412  0726               L7172:
5413                     ; 649 		case TX_Status:
5413                     ; 650 			LT8900_pack_data();
5415  0726 cd056d        	call	_LT8900_pack_data
5417                     ; 651 			LT8900_send_data();
5419  0729 cd0614        	call	_LT8900_send_data
5421                     ; 652 			LT_StartRx();
5423  072c cd03d3        	call	_LT_StartRx
5425                     ; 653 			break;
5427  072f               L1272:
5428                     ; 654 		default:
5428                     ; 655 			break;
5430  072f               L5472:
5431                     ; 657 }
5434  072f 84            	pop	a
5435  0730 81            	ret
5726                     	xdef	_LT8900_match_Deal
5727                     	xdef	_LT8900_send_data
5728                     	xdef	_LT8900_read_data
5729                     	xdef	_LT8900_pack_data
5730                     	xdef	_LT8900_unpack_data
5731                     	xdef	_LT8900_check_data
5732                     	xdef	_LT_comm_status_pack
5733                     	xdef	_mdelay_1
5734                     	xdef	_LT_StartRx
5735                     	xdef	_LT_TO_IDLE
5736                     	xdef	_LT_ReadReg
5737                     	xdef	_dataStatus
5738                     	xdef	_SPI_ReadByte
5739                     	xdef	_SPI_WriteByte
5740                     	xdef	_Get_chipId
5741                     	xdef	_LT_WriteReg
5742                     	xdef	_SPI_SendByte
5743                     	xdef	_delay2_5US_1
5744                     	xref	_mDEV
5745                     	xref	_Beep
5746                     	xref	_eeprom_rdchar
5747                     	xref	_eeprom_wrchar
5748                     	xdef	_LT8900_DOWN_Deal
5749                     	xdef	_Init_LT8900
5750                     	xdef	_mdelay
5751                     	switch	.ubsct
5752  0000               _mUSER:
5753  0000 000000000000  	ds.b	17
5754                     	xdef	_mUSER
5755  0011               _mLT8900:
5756  0011 000000000000  	ds.b	45
5757                     	xdef	_mLT8900
5758  003e               _RegL:
5759  003e 00            	ds.b	1
5760                     	xdef	_RegL
5761  003f               _RegH:
5762  003f 00            	ds.b	1
5763                     	xdef	_RegH
5764                     	xref.b	c_x
5784                     	xref	c_imul
5785                     	end
