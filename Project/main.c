/* MAIN.C file
 * 
 * 
 */
#include "sys.h"

/*********************HEKR USER API*********************/
//Э���޸����� 2016.06.23 
//Э����ַ  http://docs.hekr.me/v4/resourceDownload/protocol/uart/
//BUG ����  zejun.zhao@hekr.me
//					387606503@qq.com
/*******************************************************/

main()
{
	SYS_INI();
	
	while(1)
	{
		timer_proc();
		WIFI_COMMU();
		GUART_commu();
		LT8900_DOWN_Deal();
		while(mTIME.timer_1ms<TIME_BASE_MAIN)
		{
				
		}
		mTIME.timer_1ms=0; 					
	}
}

