   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.8 - 03 Dec 2008
2868                     ; 31 uchar eeprom_wrchar(uint addr, uchar ucdata)
2868                     ; 32 {	
2870                     	switch	.text
2871  0000               _eeprom_wrchar:
2873  0000 89            	pushw	x
2874       00000000      OFST:	set	0
2877  0001 2003          	jra	L5302
2878  0003               L3302:
2879                     ; 33 	while(EOP_FLAG==1)return(0); 
2881  0003 4f            	clr	a
2883  0004 2021          	jra	L6
2884  0006               L5302:
2887  0006 c6505f        	ld	a,_FLASH_IAPSR
2888  0009 a504          	bcp	a,#4
2889  000b 26f6          	jrne	L3302
2890                     ; 34    FLASH->DUKR = 0xAE; 
2892  000d 35ae5064      	mov	20580,#174
2893                     ; 35    FLASH->DUKR = 0x56 ; //unlock
2895  0011 35565064      	mov	20580,#86
2896                     ; 38    addr+=EEPROM_ADR_INI;
2898  0015 1e01          	ldw	x,(OFST+1,sp)
2899  0017 1c4000        	addw	x,#16384
2900  001a 1f01          	ldw	(OFST+1,sp),x
2901                     ; 39    *((u8*)addr) = ucdata;
2903  001c 7b05          	ld	a,(OFST+5,sp)
2904  001e 1e01          	ldw	x,(OFST+1,sp)
2905  0020 f7            	ld	(x),a
2906                     ; 40    FLASH->IAPSR = (u8)(~0x08);	//lock at last
2908  0021 35f7505f      	mov	20575,#247
2909                     ; 41    return(1); 
2911  0025 a601          	ld	a,#1
2913  0027               L6:
2915  0027 85            	popw	x
2916  0028 81            	ret
2950                     ; 49 uchar eeprom_rdchar(uint addr)
2950                     ; 50 {
2951                     	switch	.text
2952  0029               _eeprom_rdchar:
2954  0029 89            	pushw	x
2955       00000000      OFST:	set	0
2958                     ; 51  	addr+=EEPROM_ADR_INI;	 
2960  002a 1e01          	ldw	x,(OFST+1,sp)
2961  002c 1c4000        	addw	x,#16384
2962  002f 1f01          	ldw	(OFST+1,sp),x
2963                     ; 52  	return(*((u8*) addr));
2965  0031 1e01          	ldw	x,(OFST+1,sp)
2966  0033 f6            	ld	a,(x)
2969  0034 85            	popw	x
2970  0035 81            	ret
3034                     ; 61 uchar eeprom_rdpart(void)
3034                     ; 62 {
3035                     	switch	.text
3036  0036               _eeprom_rdpart:
3038  0036 5204          	subw	sp,#4
3039       00000004      OFST:	set	4
3042                     ; 65 	sum=0;
3044  0038 0f01          	clr	(OFST-3,sp)
3045                     ; 66 	not_allzero=0;
3047  003a 0f02          	clr	(OFST-2,sp)
3048                     ; 67 	for(i=0;i<EEPROM_PART_SIZE;i++)
3050  003c 0f03          	clr	(OFST-1,sp)
3051  003e               L1112:
3052                     ; 69 		tp=eeprom_rdchar(eeprom_step*EEPROM_PART_SIZE+i);
3054  003e c60008        	ld	a,_eeprom_step
3055  0041 97            	ld	xl,a
3056  0042 a605          	ld	a,#5
3057  0044 42            	mul	x,a
3058  0045 01            	rrwa	x,a
3059  0046 1b03          	add	a,(OFST-1,sp)
3060  0048 2401          	jrnc	L41
3061  004a 5c            	incw	x
3062  004b               L41:
3063  004b 02            	rlwa	x,a
3064  004c addb          	call	_eeprom_rdchar
3066  004e 6b04          	ld	(OFST+0,sp),a
3067                     ; 70 	   if(i<EEPROM_PART_SIZE-1)sum+=tp;					//sumcheck of a part 
3069  0050 7b03          	ld	a,(OFST-1,sp)
3070  0052 a104          	cp	a,#4
3071  0054 2406          	jruge	L7112
3074  0056 7b01          	ld	a,(OFST-3,sp)
3075  0058 1b04          	add	a,(OFST+0,sp)
3076  005a 6b01          	ld	(OFST-3,sp),a
3077  005c               L7112:
3078                     ; 71 	   eeprom_buffer[i]=tp;			
3080  005c 7b03          	ld	a,(OFST-1,sp)
3081  005e 5f            	clrw	x
3082  005f 97            	ld	xl,a
3083  0060 7b04          	ld	a,(OFST+0,sp)
3084  0062 d70000        	ld	(_eeprom_buffer,x),a
3085                     ; 72 	   if(tp>0&&tp<255)not_allzero=1;
3087  0065 0d04          	tnz	(OFST+0,sp)
3088  0067 270a          	jreq	L1212
3090  0069 7b04          	ld	a,(OFST+0,sp)
3091  006b a1ff          	cp	a,#255
3092  006d 2404          	jruge	L1212
3095  006f a601          	ld	a,#1
3096  0071 6b02          	ld	(OFST-2,sp),a
3097  0073               L1212:
3098                     ; 67 	for(i=0;i<EEPROM_PART_SIZE;i++)
3100  0073 0c03          	inc	(OFST-1,sp)
3103  0075 7b03          	ld	a,(OFST-1,sp)
3104  0077 a105          	cp	a,#5
3105  0079 25c3          	jrult	L1112
3106                     ; 75 	if((sum==tp)&&(not_allzero==1))
3108  007b 7b01          	ld	a,(OFST-3,sp)
3109  007d 1104          	cp	a,(OFST+0,sp)
3110  007f 260a          	jrne	L3212
3112  0081 7b02          	ld	a,(OFST-2,sp)
3113  0083 a101          	cp	a,#1
3114  0085 2604          	jrne	L3212
3115                     ; 76 	  return(1);
3117  0087 a601          	ld	a,#1
3119  0089 2001          	jra	L61
3120  008b               L3212:
3121                     ; 78 	  return(0);  	    
3123  008b 4f            	clr	a
3125  008c               L61:
3127  008c 5b04          	addw	sp,#4
3128  008e 81            	ret
3151                     ; 81 void eeprom_read(void)
3151                     ; 82 {
3152                     	switch	.text
3153  008f               _eeprom_read:
3157                     ; 84 }
3160  008f 81            	ret
3183                     ; 86 void eeprom_write(void)
3183                     ; 87 {
3184                     	switch	.text
3185  0090               _eeprom_write:
3189                     ; 89 }
3192  0090 81            	ret
3244                     	xdef	_eeprom_write
3245                     	xdef	_eeprom_read
3246                     	xdef	_eeprom_rdpart
3247                     	switch	.bss
3248  0000               _eeprom_buffer:
3249  0000 0000000000    	ds.b	5
3250                     	xdef	_eeprom_buffer
3251  0005               _eeprom_addr:
3252  0005 0000          	ds.b	2
3253                     	xdef	_eeprom_addr
3254  0007               _eeprom_pt:
3255  0007 00            	ds.b	1
3256                     	xdef	_eeprom_pt
3257  0008               _eeprom_step:
3258  0008 00            	ds.b	1
3259                     	xdef	_eeprom_step
3260                     	xdef	_eeprom_rdchar
3261                     	xdef	_eeprom_wrchar
3281                     	end
