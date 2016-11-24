/* MAIN.C file
 * 
 * 
 */
#include "sys.h"

/*********************HEKR USER API*********************/
//协议修改日期 2016.06.23 
//协议网址  http://docs.hekr.me/v4/resourceDownload/protocol/uart/
//BUG 反馈  zejun.zhao@hekr.me
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

