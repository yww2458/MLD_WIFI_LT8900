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

// ÿ�������������������30 ���ֽ�
#define GUART_BUF_LEN   30

#define BT_COMMU_LOST_CNT   500//25  // 10000/20 = 500


//  ͨѶ״̬
#define GUART_STATUS_TX   0x02
#define GUART_STATUS_RX   0x01


//--COMMUNICATION COMMAND ID 
#define MACHINE_INFO_QUERY	   0x01
#define MACHINE_CONTROL		   0x02
#define VARIABLE_READ		   0x03
#define VARIABLE_WIRTE		   0x33
#define MACHINE_SET_ARG		   0x44       // �������ò���

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



// ������״̬
#define GUART_FUNCCODE_PARAMETER			0x01   //  ��ʾ���ֻ�ȡ��Ҫ�Ĳ���
#define GUART_FUNCCODE_CONTROL				0x02   // ��ʾ���ַ��Ϳ��Ʋ���
#define GUART_FUNCCODE_FACTORY_PARA			0x03   // ����ģʽ���ò���


#define COMMU_HEAD1  0xF7
#define COMMU_HEAD2  0xF8
#define COMMU_TAIL   0xFD
#define GUART_HEAD_TO_MCU			COMMU_HEAD1  
#define GUART_HEAD_TO_DISP          COMMU_HEAD2
#define GUART_TAIL					COMMU_TAIL   // β��ʹ����ͬ��



typedef struct GUART_TAG
{
	u8	status;			// 1-��ʾ���ڽ�������,0-��ʾ����״̬, 2-��ʾ���ڷ�������
	u8	flagNew;		// 1- ��ʾ���յ������������ݰ���Ҫ���� 0- ��ʾû��������Ҫ���д���
    u16 pulseTime;  	// ��¼���յ���ʼλ��ʱ�䳤�ȣ�
	u8	flagTimeOn;		//  =1ʱ���˶�ʱ��
	u8	offCounts;		//  �ӽ��յ����һ���������ݺ�û�н��յ����ݴ���ͳ��
	u8	flagKeyDeal;	//  
	// 2400, ÿ���ֽ�ʱ��= 1000000/2400 = 416us
	// 9600              = 1000000/9600 = 104us
	// 115200            = 1000000/115200=8.6us
	
	u8  baudRate;       // ������  2400/9600/115200...
	u8  TxBuf[GUART_BUF_LEN];        // ��������BUF
	u8  Txlen;			// ��Ҫ�������ݳ���

	u8  RxTxStSpFlag;     // ���Ϳ�ʼ��ֹͣ��־λ���, 1-���Ϳ�ʼ�� 2����ֹͣ  0��������������
	
	u8  RxTxDone;         // �Ѿ����ջ��߷�����ɵ��ֽڳ���
	u8  RxTxBit;          // ���ڽ��ջ��߷��͵��ֽ�λ��

	u8  RxBuf[GUART_BUF_LEN]; 
	u8  Rxlen;
	u8  RxLenNeed;      // ��Ҫ���յ������ݳ���

	u8  TxCmd;
	u8  IsNeedRepeat;   //û�н��յ��Ƿ���Ҫ���·���
	u8  RxTxData;        // ���ڴ��������
	u8  funcCode;        // ��������


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
