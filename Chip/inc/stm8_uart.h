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
	UART_SEND_REQUEST_MODULE_STATUS  = 0x0001,  // 模块查询
	UART_SEND_REQUEST_MODULE_REBOOT  = 0x0002,  // 模块重启
	UART_SEND_REQUEST_MODULE_RESET   = 0x0004,  // 模块复位
	UART_SEND_REQUEST_MODULE_CONFIG  = 0x0010,  // 模块配置
	UART_SEND_REQUEST_MODULE_SLEEP   = 0x0020,  // 进入低功耗模式
	UART_SEND_REQUEST_MODULE_WAKEUP  = 0x0040,  // 唤醒
	UART_SEND_REQUEST_MODULE_TEST    = 0x0080,  // 测试模式
	UART_SEND_REQUEST_MODULE_VERSION = 0x0100,  // 查看版本
	UART_SEND_MODULE_GET_PRODKEY 	 = 0x0200,  // 获取Prodkey
	UART_SEND_MODULE_SET_PRODKEY	 = 0x0400,  // 设置prodkey
	UART_SEND_UPLOAD_DATA     		 = 0x0800,  // 上传数据, 没有动作请求
	UART_SEND_REQUEST_UPDATE_DATE    = 0x1000  //  更新数据, 主动更新，请求上控处理
}UART_SEND_TYPE;


#define TXD			GET_BITFIELD(&PD_ODR).bit5
#define RXD			GET_BITFIELD(&PD_IDR).bit6


typedef struct
{
	UART_STATUS_TYPE  status;

	// 接受数据相关的变量
	uchar	RecvCount;		// 已经接受的数据长度
	uchar	RecvFlag;		// 是否接收到正确的数据
	uchar	RecvLen; 		// 应该接受的长度	
	uchar   RecvBuffer[UART_RECV_LEN_MAX];
	AllFrameType   RecvFrameType;

	// 发送数据相关的变量
	UART_SEND_TYPE    SendRequest;
	uint 	SendRequestBuff;
	uchar	SendBuffer[UART_SEND_LEN_MAX];
	AllFrameLength   SendLen;		// 需要发送数据的长度
	uchar   SendCount;		// 已经发送数据的长度
	uchar   SendIndex;      // 发送数据帧序号, 每次发送数据自动增加1
	AllFrameType   SendFrameType;       // 帧类型

	uchar  	error_code;

	// 通讯相关参数 
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
