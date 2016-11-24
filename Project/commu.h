#ifndef __COMMU_H__
#define __COMMU_H__


#define GUART_COMMU_BAUDRATE    2400   

#if GUART_COMMU_BAUDRATE==2400
#define  BAUDTATE_TIME_CNT   208//208//932//208 
#elif GUART_COMMU_BAUDRATE==9600
#define  BAUDTATE_TIME_CNT   52//416//208 
#elif GUART_COMMU_BAUDRATE==115200
#define  BAUDTATE_TIME_CNT   4//208 
#endif

// 每次最大传输数据量不超过30 个字节
#define GUART_BUF_LEN   30

#define BT_COMMU_LOST_CNT   500//25  // 10000/20 = 500


//  通讯状态
#define GUART_STATUS_TX   0x02
#define GUART_STATUS_RX   0x01


//--COMMUNICATION COMMAND ID 
#define MACHINE_INFO_QUERY	   0x01
#define MACHINE_CONTROL		   0x02
#define VARIABLE_READ		   0x03
#define VARIABLE_WIRTE		   0x33
#define MACHINE_SET_ARG		   0x44       // 发送配置参数

//-- USER REQUEST
#define USER_REQUEST_NONE							0x00
#define USER_REQUEST_START							0x01
#define USER_REQUEST_PAUSE							0x02
#define USER_REQUEST_STOP							0x02
#define USER_REQUEST_NEW_SPEED						0x04
#define USER_REQUEST_NEW_GRADIENT					0x08
#define USER_REQUEST_ERROR_RESET					0x10
//#define USER_REQUEST_PARAMETER_SET			0x20
#define USER_REQUEST_STOP_GRADIENT					0x20
#define USER_REQUEST_SELF_TEST						0x40
#define USER_REQUEST_BURNIN_TEST					0x80



// 功能码状态
#define GUART_FUNCCODE_PARAMETER			0x01   //  显示部分获取必要的参数
#define GUART_FUNCCODE_CONTROL				0x02   // 显示部分发送控制部分
#define GUART_FUNCCODE_FACTORY_PARA			0x03   // 工厂模式设置参数


#define COMMU_HEAD1  0xF7
#define COMMU_HEAD2  0xF8
#define COMMU_TAIL   0xFD
#define GUART_HEAD_TO_MCU			COMMU_HEAD1  
#define GUART_HEAD_TO_DISP          COMMU_HEAD2
#define GUART_TAIL					COMMU_TAIL   // 尾部使用相同的



typedef struct GUART_TAG
{
	u8	status;			// 1-表示正在接收数据,0-表示空闲状态, 2-表示正在发送数据
	u8	flagNew;		// 1- 表示接收到了完整的数据包需要处理， 0- 表示没有数据需要进行处理
    u16 pulseTime;  	// 记录接收到开始位后时间长度，
	u8	flagTimeOn;		//  =1时打开了定时器
	u8	offCounts;		//  从接收到最后一个完整数据后，没有接收到数据次数统计
	u8	flagKeyDeal;	//  
	// 2400, 每个字节时间= 1000000/2400 = 416us
	// 9600              = 1000000/9600 = 104us
	// 115200            = 1000000/115200=8.6us
	
	u8  baudRate;       // 波特率  2400/9600/115200...
	u8  TxBuf[GUART_BUF_LEN];        // 传输数据BUF
	u8  Txlen;			// 需要传输数据长度

	u8  RxTxStSpFlag;     // 发送开始，停止标志位标记, 1-发送开始， 2发送停止  0，发送正常数据
	
	u8  RxTxDone;         // 已经接收或者发送完成的字节长度
	u8  RxTxBit;          // 正在接收或者发送的字节位数

	u8  RxBuf[GUART_BUF_LEN]; 
	u8  Rxlen;
	u8  RxLenNeed;      // 如要接收到的数据长度

	u8  TxCmd;
	u8  IsNeedRepeat;   //没有接收到是否需要重新发送
	u8  RxTxData;        // 正在传输的数据
	u8  funcCode;        // 请求功能码


	u16  err_cnt;
	
	uchar pctra_delay;
	uchar flag_ack;
	uint  error_code;
}GUART;

extern NEAR GUART mGUART;


// public 
void UART_Commu_Init(void);
void GUART_init(void);
void GUART_commu(void);


#endif
