   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.8 - 03 Dec 2008
2853                     ; 14 main()
2853                     ; 15 {
2855                     	switch	.text
2856  0000               _main:
2860                     ; 16 	SYS_INI();
2862  0000 cd0000        	call	_SYS_INI
2864  0003               L1202:
2865                     ; 20 		timer_proc();
2867  0003 cd0000        	call	_timer_proc
2869                     ; 21 		WIFI_COMMU();
2871  0006 cd0000        	call	_WIFI_COMMU
2873                     ; 22 		GUART_commu();
2875  0009 cd0000        	call	_GUART_commu
2877                     ; 23 		LT8900_DOWN_Deal();
2879  000c cd0000        	call	_LT8900_DOWN_Deal
2882  000f               L7202:
2883                     ; 24 		while(mTIME.timer_1ms<TIME_BASE_MAIN)
2885  000f b603          	ld	a,_mTIME+3
2886  0011 a163          	cp	a,#99
2887  0013 25fa          	jrult	L7202
2888                     ; 28 		mTIME.timer_1ms=0; 					
2890  0015 3f03          	clr	_mTIME+3
2892  0017 20ea          	jra	L1202
2905                     	xdef	_main
2906                     	xref	_timer_proc
2907                     	xref.b	_mTIME
2908                     	xref	_SYS_INI
2909                     	xref	_LT8900_DOWN_Deal
2910                     	xref	_GUART_commu
2911                     	xref	_WIFI_COMMU
2930                     	end
