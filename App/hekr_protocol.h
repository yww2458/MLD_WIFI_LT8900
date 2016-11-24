#ifndef	_HEKR_PROTOCOL_H_
#define	_HEKR_PROTOCOL_H_


//*************************************************************************
//Hekr ������ֵ
//*************************************************************************
//ͨ��֡ͷ��ʽ 
typedef struct
{
	unsigned char header;
	unsigned char length;
	unsigned char type;
	unsigned char number;
}GeneralHeader;


//Hekr��֡����
typedef	enum
{
	ModuleQueryFrameLength 		= 0x07,
	ModuleResponseFrameLength 	= 0x0B,
	ErrorFrameLength 			= 0x07,
	ProdKeyLenth 				= 0x16,
	UpdateDataLenth				= 0x11
}AllFrameLength;

//Hekr��֡����
typedef	enum
{
	DeviceUploadType 	= 0x01,  // MCU -->> WIFI ģ��
	ModuleDownloadType 	= 0x02,  // WIFI--->> MCU
	ModuleOperationType = 0xFE,  // ģ�����
	ErrorFrameType 		= 0xFF	 // �������
}AllFrameType;


//Hekr������ȡֵ
typedef	enum
{
	ErrorOperation 	= 0x01,
	ErrorSumCheck 	= 0x02,
	ErrorDataRange 	= 0x03,
	ErrorNoCMD 		= 0xFF
}AllErrorValue;


//ģ�����ָ���
typedef enum																					
{
	   Module_Statue			      = 0x01,    //״̬��ѯ
	   Module_Soft_Reboot             = 0x02,    //ģ��������
	   Module_Factory_Reset           = 0x03,    //�ָ�����
	   Hekr_Config                    = 0x04,    //һ������
	   Module_Set_Sleep			      = 0x05,    //��������
	   Module_Weakup                  = 0x06,    //���߻���
	   Module_Factory_Test            = 0x20,    //���볧��
	   Module_Firmware_Versions       = 0x10,    //�汾��ѯ
	   Module_ProdKey_Get             = 0x11,    //ProdKey��ѯ
	   Module_Set_ProdKey             = 0x21     //ProdKey����
			
}Module_Operation_TypeDef;


/*********************HEKR USER API*********************/

/*******************************************************/
//#define USER_MAX_LEN 0x64u
//ʹ��ǰҪȷ���û�����Ҫ��������� Ĭ��Ϊ100 ����100��Ҫ�����޸�
//�����С���������޸�Ϊ�����  
//����ж������ȳ�����  ȡ�����  Ϊ�û����ݳ���  ����֡����
/*******************************************************/


/*******************************************************/
//void HekrInit(void (*fun)(unsigned char));
//eg:  HekrInit(UART_SendChar);   
//HekrInit����:
//�������Ϊ�û����ڷ���һ��byte�����ĺ�����
//Hekr Э���ʼ��
//ʹ��HekrЭ��ǰ����ɳ�ʼ��
//��ʼ����Ҫ�û��д��ڷ���һ��byte�ĳ���
/*******************************************************/


/*******************************************************/
//eg:  void UART_SendChar(u8 ch); �����������ֻ��һ��8bit����
//     �ú�����Ҫ�û������ڳ����ж���
/*******************************************************/


/*******************************************************/
//unsigned char HekrRecvDataHandle(unsigned char* data);
//�������ݽ��մ���
//����ֵ��ͷ�ļ� RecvDataHandleCode
//���ݱ����ڶ�Ӧ������ valid_data �� ModuleStatus ָ��
//ģ��״ֵ̬������module_status������
/*******************************************************/


/*******************************************************/
//void HekrValidDataUpload(unsigned char len);
//�ϴ��û���Ч����
//���ݴ����valid_data�����У�len Ϊ�û����ݳ��ȣ�����֡����
/*******************************************************/


//Э���޸����� 2016.06.23 
//Э����ַ  http://docs.hekr.me/v4/resourceDownload/protocol/uart/
//BUG ����  zejun.zhao@hekr.me
//					387606503@qq.com
//*****************************************************************************


#define USER_MAX_LEN 		0x64u
#define HEKR_DATA_LEN 		0x05u
#define HEKR_FRAME_HEADER 	0x48u


//*************************************************************************
//
//ModuleStatus ָ�� ��������
//
//*************************************************************************

//ģ��Ӧ��֡��ʽ
typedef struct
{
	//��Ч����
	unsigned char CMD;				// ����
	unsigned char Mode;				// ģ��ģʽ
	unsigned char WIFI_Status;		// wifi ״̬
	unsigned char CloudStatus;		// ������״̬
	unsigned char SignalStrength;	// 0-5 �����ź�ǿ��
	unsigned char Reserved;			// ����λ
}ModuleStatusFrame; 


//*************************************************************************
//
//HekrRecvDataHandle  ��������ֵ
//
//*************************************************************************

typedef	enum
{
	RecvDataSumCheckErr 	= 0x01,  // У��ͳ���
	LastFrameSendErr 		= 0x02,
	MCU_UploadACK 			= 0x03,
	ValidDataUpdate 		= 0x04,
	RecvDataUseless 		= 0x05,
	HekrModuleStateUpdate 	= 0x06,
	MCU_ControlModuleACK 	= 0x07
}RecvDataHandleCode;

//*************************************************************************
//
//ModuleStatus ָ���и�����Чλ������ֵ
//
//*************************************************************************

//Hekrģ��״̬��
typedef	enum
{
	STA_Mode 		= 0x01,  // staģʽ, ��������ģʽ
	HekrConfig_Mode = 0x02,  // heker-config ģʽ
	AP_Mode 		= 0x03,  // AP ģʽ
	STA_AP_Mode 	= 0x04,  // ATA+AP ģʽ
	RF_OFF_Mode 	= 0x05   // ��Ƶ�ر�ģʽ-����
}HekrModuleWorkCode;

//Hekr WIFI״̬��
typedef	enum
{
	RouterConnected 	= 0x01,   // ��������·����
	RouterConnectedFail = 0x02,	  // ����·����ʧ��(δ֪ԭ��)
	RouterConnecting 	= 0x03,   // ��������·����
	PasswordErr 		= 0x04,	  // wifi�������
	NoRouter 			= 0x05,   // �Ҳ���·�����ź�
	RouterTimeOver 		= 0x06    // ����·������ʱ
}HekrModuleWIFICode;

//Hekr Cloud״̬��
typedef	enum
{
	CloudConnected 	= 0x01,		// �ƶ���������
	DNS_Fail 		= 0x02,     // DNS ����
	CloudTimeOver 	= 0x03		// �ƶ����ӳ�ʱ
}HekrModuleCloudCode;


//*************************************************************************
//�����б�
//*************************************************************************


#endif
