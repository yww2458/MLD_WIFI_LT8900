
/*****************************************
 *  Copyright  2001-2004
 *   All Rights Reserved
 *  Proprietary and Confidential
 ******************************************/

#ifndef _BEEP_H_
#define _BEEP_H_


//beep mode
#define BEEP_NONE							0			//none
#define BEEP_KEY							1			//0.5s 1 time
#define BEEP_STOP							2			//
#define BEEP_FIND_WIRELESS					3			//�������ߣ�
#define BEEP_EEROR_HALL						4			// HALL����
#define BEEP_EEROR_POWER					5			// ��Դ����
#define BEEP_EEROR_DCMOTOR_CURRENT			6           // ����

#define BEEP_KEY_INVALID				2   //			//1s 1 time
#define BEEP_SAFETY_OFF					3	//		//0.2s 3 times
#define BEEP_ERROR						4	//		//1s 9 times

//requirement for each beep mode
#define BEEP_KEY_ON_CNT							5			//0.5s 1 time
#define BEEP_KEY_OFF_CNT						5			//0.5s 1 time
#define BEEP_KEY_NUMBER							0			//actual number = +1

#define BEEP_STOP_OFF_ON_CNT				6			//0.2s 3 times
#define BEEP_STOP_OFF_OFF_CNT				80			//0.2s 3 times
#define BEEP_STOP_OFF_NUMBER				2			//actual number = +1


#define BEEP_FIND_WIRELESS_OFF_ON_CNT				6			//0.2s 3 times
#define BEEP_FIND_WIRELESS_OFF_OFF_CNT				80			//0.2s 3 times
#define BEEP_FIND_WIRELESS_OFF_NUMBER				1			//actual number = +1


void InitBeep(void);

void TestBeep(void);


void BeepInISR(void);


void	Beep2KOn(void);//ʹ�ö�ʱ������.	//BEEP_ON;ʹ�õ�ƽ����,

void	Beep2KOff(void);//ʹ�ö�ʱ������.	//BEEP_OFF;;ʹ�õ�ƽ����,

void Beep(uchar beepm);


/*--------------------------------------------------------------------------*
 |
 | buzzcon
 | 
 | Description: To beeper drive
 |
 |  Entry:  None
 |  Exit:   None
 *--------------------------------------------------------------------------*/
void buzzcon(void);


#endif

