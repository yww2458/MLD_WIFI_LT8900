#include "sys.h"

NEAR u8 beepmode;						//beep sound mode
NEAR u16 beep_on_cnt;						//on time in 1 beep, in 20ms
NEAR u16 beep_off_cnt;						//off time in 1 beep interval, in 20ms of main loop
NEAR u16 beep_on_cnt_setting;			//on time setting in 1 beep, in 20ms
NEAR u16 beep_off_cnt_setting;		//off time setting in 1 beep, in 20ms
NEAR u8 beep_number;					//number in a beep mode
NEAR u8 beep_request;					//request beep action, set with the beepmode
NEAR u8 flagBeep=0;
void InitBeep(void)
{
//PD4 是蜂鸣器
	PD_DDR |= (u8)1<<4;
	PD_CR1 |= (u8)1<<4;
}
	u8 indexTestBeep=0;
void TestBeep(void)
{

	while(1)
	{
		//mdelay(5);
		buzzcon();
		if(indexTestBeep)
		{
			Beep(indexTestBeep);
			indexTestBeep=0;
		}
	}


}

void BeepInISR(void)
{

	if(flagBeep)
	{
		PD_ODR ^=1<<4;
	}
	else
	{
		PD_ODR &=(~(1<<4));
	}
}

void	Beep2KOn(void)//使用定时器驱动.	//BEEP_ON;使用电平驱动,
{//
	//BEEP_Cmd(ENABLE);
	flagBeep=1;
	//PD_ODR |=0x80;
}
void	Beep2KOff(void)//使用定时器驱动.	//BEEP_OFF;;使用电平驱动,
{
	//BEEP_Cmd(DISABLE);
	flagBeep=0;
	//PD_ODR &=~0x80;
}
void Beep(uchar beepm)
{
	beepmode=beepm;
	beep_request=1;
}

/*--------------------------------------------------------------------------*
 |
 | buzzcon
 | 
 | Description: To beeper drive
 |
 |  Entry:  None
 |  Exit:   None
 *--------------------------------------------------------------------------*/
void buzzcon(void)
{
	if (beep_request)
	{
		beep_request=0;
		switch (beepmode)
		{
			case BEEP_KEY:
				beep_on_cnt_setting		= BEEP_KEY_ON_CNT*4;
				beep_off_cnt_setting	= BEEP_KEY_OFF_CNT*4;
				beep_number				= BEEP_KEY_NUMBER;				
				break;

			case BEEP_STOP:
				beep_on_cnt_setting	 	= BEEP_STOP_OFF_ON_CNT*4;
				beep_off_cnt_setting 	= BEEP_STOP_OFF_OFF_CNT*4;
				beep_number			 	= BEEP_STOP_OFF_NUMBER;					
				break;
				
			case BEEP_FIND_WIRELESS:
				beep_on_cnt_setting		= BEEP_FIND_WIRELESS_OFF_ON_CNT*4;
				beep_off_cnt_setting	= BEEP_FIND_WIRELESS_OFF_OFF_CNT*4;
				beep_number				= BEEP_FIND_WIRELESS_OFF_NUMBER;					
				break;
	// add by yww at 20150416	
	#if 0
			case BEEP_EEROR_HALL:
				beep_on_cnt_setting		= BEEP_EEROR_HALL_ON_CNT*4;
				beep_off_cnt_setting	= BEEP_EEROR_HALL_OFF_CNT*4;
				beep_number				= BEEP_EEROR_HALL_NUMBER;	
				break;
				
			case BEEP_EEROR_POWER:
				beep_on_cnt_setting		= BEEP_EEROR_POWER_ON_CNT*4;
				beep_off_cnt_setting	= BEEP_EEROR_POWER_OFF_CNT*4;
				beep_number				= BEEP_EEROR_POWER_NUMBER;	
				break;
	
			case BEEP_EEROR_DCMOTOR_CURRENT:
				beep_on_cnt_setting		= BEEP_ERROR_ON_CNT*4;
				beep_off_cnt_setting	= BEEP_ERROR_OFF_CNT*4;
				beep_number				= BEEP_ERROR_NUMBER;	
				break;
	#endif
	// end add


				
            /*    
			case BEEP_KEY_INVALID:
				beep_on_cnt_setting=BEEP_KEY_INVALID_ON_CNT*4;
				beep_off_cnt_setting=BEEP_KEY_INVALID_OFF_CNT*4;
				beep_number=BEEP_KEY_INVALID_NUMBER;
				break;
			case BEEP_SAFETY_OFF:
				beep_on_cnt_setting=BEEP_SAFETY_OFF_ON_CNT*4;
				beep_off_cnt_setting=BEEP_SAFETY_OFF_OFF_CNT*4;
				beep_number=BEEP_SAFETY_OFF_NUMBER;				
				break;
			case BEEP_ERROR:
				beep_on_cnt_setting=BEEP_ERROR_ON_CNT*4;
				beep_off_cnt_setting=BEEP_ERROR_OFF_CNT*4;
				beep_number=BEEP_ERROR_NUMBER;				
				break;
            */

				
			case BEEP_NONE:
			default:			
				beep_on_cnt_setting=0;
				beep_off_cnt_setting=0;				
				beep_number=0;
		}
		beep_on_cnt=beep_on_cnt_setting;			//set the time for first beep on				
	}
	if (beep_on_cnt>0)
	{
		Beep2KOn();//使用定时器驱动.	//BEEP_ON;使用电平驱动,
		beep_on_cnt--;	
		beep_off_cnt=beep_off_cnt_setting;
	}	
	else 
	{
		Beep2KOff();//使用定时器驱动.	//BEEP_OFF;;使用电平驱动,
		if (beep_number>0)
		{	
			if (beep_off_cnt>0)
			{
				beep_off_cnt--;
			}
			else
			{
                beep_number--;		//beep all the time if safty off
				beep_on_cnt=beep_on_cnt_setting;			//reload on time
			}		
		}
		else			//beep mode end
		{
			beep_on_cnt=0;
			beep_off_cnt=0;	
		}
	}
}
