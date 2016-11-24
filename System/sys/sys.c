#include "sys.h"


NEAR __DEV mDEV;
__TIME mTIME;
NEAR __WIFI  mWIFI;


/*********************************************************************
 * @brief  : 延时等待MCU稳定, about 0.3s
 * @param  : None
 * @retval : None
 *********************************************************************/
void __WAIT_SYSTEM_STABLE(void)  
{
	uint i;
	
	for (i = 60000 ; i > 0; )
	{
		i--;
	}
}


/*********************************************************************
 * @brief  : 配置系统时钟为HSI   fCPU=16M
 * @param  : None
 * @retval : None
 *********************************************************************/
void SYS_CLK_INI(void)
{
	CLK_ICKR 	= 0x01;		// HSI enable(default)
	CLK_SWR 	= 0xE1;		// HSI selected(default)
	CLK_CKDIVR	= 0x00;		// fHSI = fMASTER = fCPU = 16M
}


/*********************************************************************
 * @brief  : 配置系统GPIO
 * @param  : None
 * @retval : None
 *********************************************************************/
void GPIO_INI(void)
{
	/*
	DDR 	CR1   
	0		 0	  悬浮输入
	0		 1	  上拉输入
	1		 0	  开漏输出
	1		 1	  推挽输出
	  */

	
	//GPIO config			 DDR   0100 0000   0X40
	/*------------------------------------------ 
	  | PA1   WEER	 无线心跳 - INPUT
	  | PA2   BL_VCC 蓝牙电源控制 - OUTPUT
	  | // 0000 0100
	  -------------------------------------------*/
	PA_DDR =0x00;
	PA_CR1 =0X00;

	/*------------------------------------------ 
	  | PB0  BL_RX 实际为输出, OUTPUT
	  | PB1  CS LCD_CS	OUTPUT
	  | PB2  CK LCD_CLK OUTPUT
	  | PB3  DATA	LCD_DATA OUTPUT
	  | PB4  BL_TX 实际为输入, INPUT
	  | PB5  FAN  PWM输出, OUTPUT
	  | // 0010 1111
	  -------------------------------------------*/
	PB_DDR = 0x00;
	PB_CR1 = 0x00;

	/*------------------------------------------ 
	  | PC1  KO7
	  | PC2  KO6
	  | PC3  KO5
	  | PC4  KO4
	  | PC5  KO3
	  | PC6  KO2
	  | PC7  KO1
	  | // 0000 0000
	  -------------------------------------------*/
	PC_DDR = 0x00;
	PC_CR1 = 0x00;


	/*------------------------------------------	
	  | PD0  test - 实际为DA输出用于上一曲下一曲控制, OUTPUT
	  | PD1  SWIM
	  | PD2  VOL_UP 		OUTPUT
	  | PD3  VOL_DOWN		OUTPUT
	  | PD4  BUZZ				OUTPUT
	  | PD5  TXD				OUTPUT
	  | PD6  RXD				INPUT
	  | PD7  SAFT_KEY			INPUT
	  | // 0011 1101
	  -------------------------------------------*/
	PD_DDR = 0x3D;
	PD_CR1 = 0x3D;

	/*------------------------------------------ 
	  | PE5  HER --  INPUT 
	  | // 0000 0000
	  -------------------------------------------*/
	PE_DDR = 0x00; //0000 0111
	PE_CR1 = 0x00; //0000 0111

	/*------------------------------------------ 
	  | PF4  LCD_BL --	OUTPUT
	  | // 0001 0000
	  -------------------------------------------*/
	PF_DDR = 0x00;
	PF_CR1 = 0x00;
}


void  __TIM4_INI(void)
{
	TIM4_PSCR  = 0x05;			// fTIM4 = fMASTER(16M)/32, T = 2us
	TIM4_ARR   = TIMER4_CNT;	// T=200us
	TIM4_IER   = 0x01;			// TIM4 interrrupt enable register
	TIM4_CR1   = 0x01;			// TIM4 control register
}


void SYS_INI(void)
{
	__WAIT_SYSTEM_STABLE();
	disableInterrupts();
	SYS_CLK_INI();
	GPIO_INI();
	UART2_Init();
	__TIM4_INI();
	Init_LT8900();
	InitBeep();
	GUART_init();
	delay_init(16);
	enableInterrupts();
}

@far @interrupt void TIM4_isr (void)
{
	TIM4_SR &= 0x7E;

	if(mTIME.timer_1ms<250)
	{
		mTIME.timer_1ms++;
	}

	BeepInISR();
}

void timer_proc(void)
{
	if(mTIME.sec>=TIME_BASE_SEC)			//one second base timer //
	{
		mTIME.sec=0;
	}
	else 
	{
		mTIME.sec++; 
	} 
}


