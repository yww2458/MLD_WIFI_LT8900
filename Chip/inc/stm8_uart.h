#ifndef _STM8_UART_H
#define _STM8_UART_H

#include "Hekr_protocol.h"

#define Baud_9600
//#define Baud_115200

#define PCCOM_FAIL_CNT_MAX			15			//when no feedback for 5 times continuously, communicaiton error
#define WAIT_FEEDBACK_TIME			25			//in 20ms, wait in receive state


#define UART_RECV_LEN_MAX	30
#define UART_RECV_LEN_MIN   5
#define UART_SEND_LEN_MAX	30

typedef enum
{
	UART_STATUS_NONE = 0,
	UART_STATUS_SEND = 1,
	UART_STATUS_RECV
}UART_STATUS_TYPE;

typedef enum
{
	UART_SEND_REQUEST_NONE    		 = 0x0000,
	UART_SEND_REQUEST_MODULE_STATUS  = 0x0001,  // ģ���ѯ
	UART_SEND_REQUEST_MODULE_REBOOT  = 0x0002,  // ģ������
	UART_SEND_REQUEST_MODULE_RESET   = 0x0004,  // ģ�鸴λ
	UART_SEND_REQUEST_MODULE_CONFIG  = 0x0010,  // ģ������
	UART_SEND_REQUEST_MODULE_SLEEP   = 0x0020,  // ����͹���ģʽ
	UART_SEND_REQUEST_MODULE_WAKEUP  = 0x0040,  // ����
	UART_SEND_REQUEST_MODULE_TEST    = 0x0080,  // ����ģʽ
	UART_SEND_REQUEST_MODULE_VERSION = 0x0100,  // �鿴�汾
	UART_SEND_MODULE_GET_PRODKEY 	 = 0x0200,  // ��ȡProdkey
	UART_SEND_MODULE_SET_PRODKEY	 = 0x0400,  // ����prodkey
	UART_SEND_UPLOAD_DATA     		 = 0x0800,  // �ϴ�����, û�ж�������
	UART_SEND_REQUEST_UPDATE_DATE    = 0x1000  //  ��������, �������£������Ͽش���
}UART_SEND_TYPE;


#define TXD			GET_BITFIELD(&PD_ODR).bit5
#define RXD			GET_BITFIELD(&PD_IDR).bit6


typedef struct
{
	UART_STATUS_TYPE  status;

	// ����������صı���
	uchar	RecvCount;		// �Ѿ����ܵ����ݳ���
	uchar	RecvFlag;		// �Ƿ���յ���ȷ������
	uchar	RecvLen; 		// Ӧ�ý��ܵĳ���	
	uchar   RecvBuffer[UART_RECV_LEN_MAX];
	AllFrameType   RecvFrameType;

	// ����������صı���
	UART_SEND_TYPE    SendRequest;
	uint 	SendRequestBuff;
	uchar	SendBuffer[UART_SEND_LEN_MAX];
	AllFrameLength   SendLen;		// ��Ҫ�������ݵĳ���
	uchar   SendCount;		// �Ѿ��������ݵĳ���
	uchar   SendIndex;      // ��������֡���, ÿ�η��������Զ�����1
	AllFrameType   SendFrameType;       // ֡����

	uchar  	error_code;

	// ͨѶ��ز��� 
	uchar   pcerr_com_cnt;
	uchar   pccom_cnt;
	uchar   pccom_fail_cnt;
	uchar   pcerr_com;
}__UART;

extern NEAR __UART mUART;


void UART1_Init(void);
void UART1_SendChar(unsigned char ch);

void UART2_Init(void);
//void UART2_SendChar(unsigned char ch);

char putchar(char ch);
void WIFI_COMMU (void);


#endif
