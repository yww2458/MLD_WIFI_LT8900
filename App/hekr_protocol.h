#ifndef	_HEKR_PROTOCOL_H_
#define	_HEKR_PROTOCOL_H_


//*************************************************************************
//Hekr 具体码值
//*************************************************************************
//通用帧头格式 
typedef struct
{
	unsigned char header;
	unsigned char length;
	unsigned char type;
	unsigned char number;
}GeneralHeader;


//Hekr各帧长度
typedef	enum
{
	ModuleQueryFrameLength 		= 0x07,
	ModuleResponseFrameLength 	= 0x0B,
	ErrorFrameLength 			= 0x07,
	ProdKeyLenth 				= 0x16,
	UpdateDataLenth				= 0x11
}AllFrameLength;

//Hekr各帧类型
typedef	enum
{
	DeviceUploadType 	= 0x01,  // MCU -->> WIFI 模组
	ModuleDownloadType 	= 0x02,  // WIFI--->> MCU
	ModuleOperationType = 0xFE,  // 模块操作
	ErrorFrameType 		= 0xFF	 // 出错代码
}AllFrameType;


//Hekr错误码取值
typedef	enum
{
	ErrorOperation 	= 0x01,
	ErrorSumCheck 	= 0x02,
	ErrorDataRange 	= 0x03,
	ErrorNoCMD 		= 0xFF
}AllErrorValue;


//模块操作指令定义
typedef enum																					
{
	   Module_Statue			      = 0x01,    //状态查询
	   Module_Soft_Reboot             = 0x02,    //模块软重启
	   Module_Factory_Reset           = 0x03,    //恢复出厂
	   Hekr_Config                    = 0x04,    //一键配置
	   Module_Set_Sleep			      = 0x05,    //进入休眠
	   Module_Weakup                  = 0x06,    //休眠唤醒
	   Module_Factory_Test            = 0x20,    //进入厂测
	   Module_Firmware_Versions       = 0x10,    //版本查询
	   Module_ProdKey_Get             = 0x11,    //ProdKey查询
	   Module_Set_ProdKey             = 0x21     //ProdKey设置
			
}Module_Operation_TypeDef;


/*********************HEKR USER API*********************/

/*******************************************************/
//#define USER_MAX_LEN 0x64u
//使用前要确定用户所需要的最大数组 默认为100 大于100需要自行修改
//数组大小可以自行修改为最长长度  
//如果有多条不等长命令  取最长长度  为用户数据长度  非整帧长度
/*******************************************************/


/*******************************************************/
//void HekrInit(void (*fun)(unsigned char));
//eg:  HekrInit(UART_SendChar);   
//HekrInit函数:
//传入参数为用户串口发送一个byte函数的函数名
//Hekr 协议初始化
//使用Hekr协议前需完成初始化
//初始化需要用户有串口发送一个byte的程序
/*******************************************************/


/*******************************************************/
//eg:  void UART_SendChar(u8 ch); 传输参数必须只是一个8bit的数
//     该函数需要用户自行在程序中定义
/*******************************************************/


/*******************************************************/
//unsigned char HekrRecvDataHandle(unsigned char* data);
//串口数据接收处理
//返回值见头文件 RecvDataHandleCode
//数据保存在对应数组中 valid_data 和 ModuleStatus 指针
//模块状态值保存在module_status数组中
/*******************************************************/


/*******************************************************/
//void HekrValidDataUpload(unsigned char len);
//上传用户有效数据
//数据存放在valid_data数组中，len 为用户数据长度，非整帧长度
/*******************************************************/


//协议修改日期 2016.06.23 
//协议网址  http://docs.hekr.me/v4/resourceDownload/protocol/uart/
//BUG 反馈  zejun.zhao@hekr.me
//					387606503@qq.com
//*****************************************************************************


#define USER_MAX_LEN 		0x64u
#define HEKR_DATA_LEN 		0x05u
#define HEKR_FRAME_HEADER 	0x48u


//*************************************************************************
//
//ModuleStatus 指针 包含内容
//
//*************************************************************************

//模块应答帧格式
typedef struct
{
	//有效数据
	unsigned char CMD;				// 命令
	unsigned char Mode;				// 模块模式
	unsigned char WIFI_Status;		// wifi 状态
	unsigned char CloudStatus;		// 云连接状态
	unsigned char SignalStrength;	// 0-5 代表信号强度
	unsigned char Reserved;			// 保留位
}ModuleStatusFrame; 


//*************************************************************************
//
//HekrRecvDataHandle  函数返回值
//
//*************************************************************************

typedef	enum
{
	RecvDataSumCheckErr 	= 0x01,  // 校验和出错
	LastFrameSendErr 		= 0x02,
	MCU_UploadACK 			= 0x03,
	ValidDataUpdate 		= 0x04,
	RecvDataUseless 		= 0x05,
	HekrModuleStateUpdate 	= 0x06,
	MCU_ControlModuleACK 	= 0x07
}RecvDataHandleCode;

//*************************************************************************
//
//ModuleStatus 指针中各个有效位具体码值
//
//*************************************************************************

//Hekr模块状态码
typedef	enum
{
	STA_Mode 		= 0x01,  // sta模式, 正常工作模式
	HekrConfig_Mode = 0x02,  // heker-config 模式
	AP_Mode 		= 0x03,  // AP 模式
	STA_AP_Mode 	= 0x04,  // ATA+AP 模式
	RF_OFF_Mode 	= 0x05   // 射频关闭模式-休眠
}HekrModuleWorkCode;

//Hekr WIFI状态码
typedef	enum
{
	RouterConnected 	= 0x01,   // 正常连接路由器
	RouterConnectedFail = 0x02,	  // 连接路由器失败(未知原因)
	RouterConnecting 	= 0x03,   // 正在连接路由器
	PasswordErr 		= 0x04,	  // wifi密码错误
	NoRouter 			= 0x05,   // 找不到路由器信号
	RouterTimeOver 		= 0x06    // 连接路由器超时
}HekrModuleWIFICode;

//Hekr Cloud状态码
typedef	enum
{
	CloudConnected 	= 0x01,		// 云端连接正常
	DNS_Fail 		= 0x02,     // DNS 错误
	CloudTimeOver 	= 0x03		// 云端连接超时
}HekrModuleCloudCode;


//*************************************************************************
//函数列表
//*************************************************************************


#endif
