#include "sys.h"


NEAR __UART mUART;

/*---------------------------------------------------------------
  * 产品秘钥设置，共16个字节,
  * 当前示例ProdKey值对应LED多彩体验页面。
  * ProdKey的获取和设置方法可参考：
  * http://docs.hekr.me/v4/resourceDownload/protocol/uart/#44prodkey
  ----------------------------------------------------------------*/
#if 0
const uchar ProdKey[16] = 
{
	0x01, 0x36, 0xA6, 0x6C, 
	0x12, 0x75, 0x4E, 0xE8,
	0x2F, 0xFF, 0x88, 0x04,
	0xB7, 0xFA, 0xA5, 0x3C
};
#elif 0
 //  自己创建的产品prodKey   
const uchar ProdKey[16] = 
{
	0x01, 0xe5, 0xa8, 0xbe,
	0x97, 0x31, 0xc0, 0xa2,
    0xb2, 0x37, 0x08, 0xd3,
    0x56, 0xaa, 0x36, 0x75
};
#else
// 穆拉德创建的产品 prodKey
const uchar ProdKey[16] = 
{
	0x01, 0x33, 0xa8, 0x21, 
	0x97, 0x1b, 0x40, 0x5e, 
	0x92, 0x4f, 0x01, 0x60, 
	0x4f, 0x33, 0xd7, 0xc0
};

#endif

void UART2_Init(void)
{	
	UART2_BRR2 = 0x02;    
	UART2_BRR1 = 0x68;	// 16M 2400  1A0B      
	UART2_CR2  = 0x60;  // 发送，接收中断都使能     
	
	TXEN_FLAG=0;		// txd disable
	RXEN_FLAG=1;		// rxd enable
	TXD=1;
}


static uchar DataBuffCalculate(unsigned char* data)
{
	unsigned char temp;
	unsigned char i;
	unsigned char len = data[1] - 1;
	temp = 0;
	for(i = 0;i < len; i++)
	{
			temp += data[i];
	}
	return temp;
}

static uchar DataBuffCheckIsErr(unsigned char* data)
{
	unsigned char temp = DataBuffCalculate(data);
	unsigned char len = data[1] - 1;
	if(temp == data[len])
	{
		return 0;
	}
	return 1;
}


void WIFI_COMMU (void)
{
	uchar temp8;
	uint  temp16;

	#if 0
	if(mTIME.sec == 0) // 每s检测一次wifi 状态
	{
		mUART.SendRequestBuff |= UART_SEND_REQUEST_MODULE_STATUS;
	}
	#endif


	if(mUART.status == UART_STATUS_SEND)
	{
		mUART.status = UART_STATUS_RECV;
		
		if((mUART.SendRequestBuff&UART_SEND_REQUEST_MODULE_STATUS)==UART_SEND_REQUEST_MODULE_STATUS )
		{
			mUART.SendRequest = UART_SEND_REQUEST_MODULE_STATUS;
		}
		else if((mUART.SendRequestBuff&UART_SEND_REQUEST_MODULE_REBOOT)==UART_SEND_REQUEST_MODULE_REBOOT )
		{
			mUART.SendRequest = UART_SEND_REQUEST_MODULE_REBOOT;
		}
		else if((mUART.SendRequestBuff&UART_SEND_REQUEST_MODULE_RESET)==UART_SEND_REQUEST_MODULE_RESET )
		{
			mUART.SendRequest = UART_SEND_REQUEST_MODULE_RESET;
		}
		else if((mUART.SendRequestBuff&UART_SEND_REQUEST_MODULE_CONFIG)==UART_SEND_REQUEST_MODULE_CONFIG )
		{
			mUART.SendRequest = UART_SEND_REQUEST_MODULE_CONFIG;
		}
		else if((mUART.SendRequestBuff&UART_SEND_REQUEST_MODULE_SLEEP)==UART_SEND_REQUEST_MODULE_SLEEP )
		{
			mUART.SendRequest = UART_SEND_REQUEST_MODULE_SLEEP;
		}
		else if((mUART.SendRequestBuff&UART_SEND_REQUEST_MODULE_WAKEUP)==UART_SEND_REQUEST_MODULE_WAKEUP )
		{
			mUART.SendRequest = UART_SEND_REQUEST_MODULE_WAKEUP;
		}
		else if((mUART.SendRequestBuff&UART_SEND_REQUEST_MODULE_TEST)==UART_SEND_REQUEST_MODULE_TEST )
		{
			mUART.SendRequest = UART_SEND_REQUEST_MODULE_TEST;
		}
		else if((mUART.SendRequestBuff&UART_SEND_REQUEST_MODULE_VERSION)==UART_SEND_REQUEST_MODULE_VERSION )
		{
			mUART.SendRequest = UART_SEND_REQUEST_MODULE_VERSION;
		}
		else if((mUART.SendRequestBuff&UART_SEND_MODULE_GET_PRODKEY)==UART_SEND_MODULE_GET_PRODKEY )
		{
			// 获取PK值会超出权限
			mUART.SendRequestBuff &= ~UART_SEND_MODULE_GET_PRODKEY;
			mUART.status = UART_STATUS_RECV;
			// 直接返回, 不发送数据
			return;
		}
		else if((mUART.SendRequestBuff&UART_SEND_MODULE_SET_PRODKEY)==UART_SEND_MODULE_SET_PRODKEY )
		{
			mUART.SendRequest = UART_SEND_MODULE_SET_PRODKEY;
		}
		else if((mUART.SendRequestBuff&UART_SEND_UPLOAD_DATA)==UART_SEND_UPLOAD_DATA )
		{
			mUART.SendRequest = UART_SEND_UPLOAD_DATA;
			mUART.SendRequestBuff  &= ~UART_SEND_UPLOAD_DATA;
		}
		else if((mUART.SendRequestBuff&UART_SEND_REQUEST_UPDATE_DATE)==UART_SEND_REQUEST_UPDATE_DATE )
		{
			mUART.SendRequest = UART_SEND_REQUEST_UPDATE_DATE;
		}
		else
		{
			mUART.status = UART_STATUS_RECV;
			return;
		}

		mUART.SendBuffer[0] = HEKR_FRAME_HEADER;
		mUART.SendBuffer[3] = mUART.SendIndex++;
		switch(mUART.SendRequest)
		{
			case UART_SEND_REQUEST_MODULE_STATUS:
				mUART.SendLen = ModuleQueryFrameLength;
				mUART.SendBuffer[2] = ModuleOperationType;
				mUART.SendBuffer[4] = Module_Statue;
				mUART.SendBuffer[5] = 0x00;
				break;
			case UART_SEND_REQUEST_MODULE_REBOOT:
				mUART.SendLen = ModuleQueryFrameLength;
				mUART.SendBuffer[2] = ModuleOperationType;
				mUART.SendBuffer[4] = Module_Soft_Reboot;
				mUART.SendBuffer[5] = 0x00;
				break;
			case UART_SEND_REQUEST_MODULE_RESET:
				mUART.SendLen = ModuleQueryFrameLength;
				mUART.SendBuffer[2] = ModuleOperationType;
				mUART.SendBuffer[4] = Module_Factory_Reset;
				mUART.SendBuffer[5] = 0x00;
				break;
			case UART_SEND_REQUEST_MODULE_CONFIG:
				mUART.SendLen = ModuleQueryFrameLength;
				mUART.SendBuffer[2] = ModuleOperationType;
				mUART.SendBuffer[4] = Hekr_Config;
				mUART.SendBuffer[5] = 0x00;
				break;
			case UART_SEND_REQUEST_MODULE_SLEEP:
				mUART.SendLen = ModuleQueryFrameLength;
				mUART.SendBuffer[2] = ModuleOperationType;
				mUART.SendBuffer[4] = Module_Set_Sleep;
				mUART.SendBuffer[5] = 0x00;
				break;
			case UART_SEND_REQUEST_MODULE_WAKEUP:
				mUART.SendLen = ModuleQueryFrameLength;
				mUART.SendBuffer[2] = ModuleOperationType;
				mUART.SendBuffer[4] = Module_Weakup;
				mUART.SendBuffer[5] = 0x00;
				break;
			case UART_SEND_REQUEST_MODULE_TEST:
				mUART.SendLen = ModuleQueryFrameLength;
				mUART.SendBuffer[2] = ModuleOperationType;
				mUART.SendBuffer[4] = Module_Factory_Test;
				mUART.SendBuffer[5] = 0x00;
				break;
			case UART_SEND_REQUEST_MODULE_VERSION:
				mUART.SendLen = ModuleQueryFrameLength;
				mUART.SendBuffer[2] = ModuleOperationType;
				mUART.SendBuffer[4] = Module_Firmware_Versions;
				mUART.SendBuffer[5] = 0x00;
				break;
			case UART_SEND_MODULE_GET_PRODKEY:
				mUART.SendLen = ModuleQueryFrameLength;
				mUART.SendBuffer[2] = ModuleOperationType;
				mUART.SendBuffer[4] = Module_ProdKey_Get;
				mUART.SendBuffer[5] = 0x00;
				break;
			case UART_SEND_MODULE_SET_PRODKEY:
				mUART.SendLen = ProdKeyLenth;
				mUART.SendBuffer[2] = ModuleOperationType;
				mUART.SendBuffer[4] = Module_Set_ProdKey;
				for(temp8 = 0; temp8 < 16; temp8++)
				{
					mUART.SendBuffer[5+temp8] = ProdKey[temp8];
				}
				break;
			case UART_SEND_UPLOAD_DATA:
				mUART.SendLen = UpdateDataLenth;
				mUART.SendBuffer[2] = DeviceUploadType;

				mUART.SendBuffer[5] = 0x04;
				mUART.SendBuffer[6] = mDEV.status;
				mUART.SendBuffer[7] = (uchar)(mDEV.HZ>>8);
				mUART.SendBuffer[8] = (uchar)mDEV.HZ;
				mUART.SendBuffer[9] = (uchar)(mDEV.rpm>>8);
				mUART.SendBuffer[10]= (uchar)mDEV.rpm;
				mUART.SendBuffer[11]= mDEV.error_code;
				mUART.SendBuffer[12]= mUART.SendBuffer[12]; // 预留
				mUART.SendBuffer[13]= mUART.SendBuffer[13]; // 预留
				mUART.SendBuffer[14]= mUART.SendBuffer[14]; // 预留
				mUART.SendBuffer[15]= mUART.SendBuffer[15]; // 预留
				mUART.SendBuffer[16]= mUART.SendBuffer[16]; // 预留
				break;
			case UART_SEND_REQUEST_UPDATE_DATE:
				break;
			default:
				break;
		}

		mUART.SendBuffer[1] = mUART.SendLen;
		mUART.SendBuffer[mUART.SendLen-1]= DataBuffCalculate(mUART.SendBuffer);

		TXEN_FLAG=1;	//txd enable
		UART2_DR=mUART.SendBuffer[0];
		mUART.pccom_cnt = 0;
	}
	else if(mUART.status == UART_STATUS_RECV)
	{
		if(mUART.RecvFlag)
		{
			mUART.RecvFlag  = 0;
			mUART.pccom_cnt = 0;
			mUART.RecvCount = 0;
			mUART.status    = UART_STATUS_SEND;
			
			//  
			if(DataBuffCheckIsErr(mUART.RecvBuffer))
			{
				return;  // 校验出错
			}

			mUART.RecvFrameType = mUART.RecvBuffer[2];
			switch(mUART.RecvFrameType)
			{
				case DeviceUploadType:
					// nothing to do ....
					break;
				case ModuleDownloadType:  // 主动下发数据
					mUART.SendRequestBuff |= UART_SEND_UPLOAD_DATA;
					//mUART.SendR
					#if 0
					switch(mUART.RecvBuffer[4])
					{
						case 0x01:
							mUART.SendRequestBuff  |= UART_SEND_UPLOAD_DATA;
							break;
						case 2:
							mUART.SendRequestBuff  |= UART_SEND_UPLOAD_DATA;
							if(mUART.RecvBuffer[5] == 0)
							{
								// 停止运行
							}
							else
							{
								// 开始运行 
								mDEV.status = mUART.RecvBuffer[5];
								temp16 = mUART.RecvBuffer[6]<<8;
								mDEV.HZ = temp16+mUART.RecvBuffer[7];
								
								temp16 = mUART.RecvBuffer[8]<<8;
								mDEV.scale = temp16+mUART.RecvBuffer[9];
							}
							break;
						case 3:
							break;
						case 4:
							break;
						case 5:
							break;
						default:
							break;
					}
					#endif
					break;
				case ModuleOperationType:
					switch(mUART.RecvBuffer[4])
					{
						case Module_Statue:
							mUART.SendRequestBuff  &= ~UART_SEND_REQUEST_MODULE_STATUS;
							// 模块状态
							mWIFI.mode           = mUART.RecvBuffer[5];
							mWIFI.WIFI_status    = mUART.RecvBuffer[6];
							mWIFI.CloudStatus    = mUART.RecvBuffer[7];
							mWIFI.SignalStrength = mUART.RecvBuffer[8];


							#if 0

							if((mWIFI.mode == 1)&& (mWIFI.WIFI_status == 0x02))
							{
								mUART.SendRequestBuff |= UART_SEND_REQUEST_MODULE_CONFIG;
							}
							#endif
							break;
						case Module_Soft_Reboot:
							mUART.SendRequestBuff  &= ~UART_SEND_REQUEST_MODULE_REBOOT;
							break;
						case Module_Factory_Reset:
							mUART.SendRequestBuff  &= ~UART_SEND_REQUEST_MODULE_RESET;
							break;
						case Hekr_Config:
							mUART.SendRequestBuff  &= ~UART_SEND_REQUEST_MODULE_CONFIG;
							break;
						case Module_Set_Sleep:
							mUART.SendRequestBuff  &= ~UART_SEND_REQUEST_MODULE_SLEEP;
							break;
						case Module_Weakup:
							mUART.SendRequestBuff  &= ~UART_SEND_REQUEST_MODULE_WAKEUP;
							break;
						case Module_Factory_Test:
							mUART.SendRequestBuff  &= ~UART_SEND_REQUEST_MODULE_TEST;
							break;
						case Module_Firmware_Versions:
							mUART.SendRequestBuff  &= ~UART_SEND_REQUEST_MODULE_VERSION;
							mWIFI.version_main  = mUART.RecvBuffer[5];
							mWIFI.version_minor = mUART.RecvBuffer[6];
							mWIFI.version_debug = mUART.RecvBuffer[7];
							mWIFI.version_type  = mUART.RecvBuffer[8];
							break;
						case Module_ProdKey_Get:
							mUART.SendRequestBuff  &= ~UART_SEND_MODULE_GET_PRODKEY;
							break;
						case Module_Set_ProdKey:
							mUART.SendRequestBuff  &= ~UART_SEND_MODULE_SET_PRODKEY;
							break;
					}
					break;
				case ErrorFrameType:
					mUART.error_code = mUART.RecvBuffer[4];
					// 是否需要清SendRequestBuff
					break;
				default:
					break;
			}
		}
		else
		{
			if(mUART.pccom_cnt >= WAIT_FEEDBACK_TIME)
			{
				mUART.pccom_cnt = 0;
				mUART.RecvCount = 0;
				mUART.status = UART_STATUS_SEND;
			}
			else
			{
				mUART.pccom_cnt++;
			}
		}
	}
	else
	{
		mUART.status = UART_STATUS_SEND;
		mUART.SendRequestBuff |= UART_SEND_REQUEST_MODULE_STATUS;
		mUART.SendRequestBuff |= UART_SEND_MODULE_SET_PRODKEY;
	}
}


@far @interrupt void UART2_Send_IRQHandler(void)
{
	#if 1	
	if (mUART.SendCount < mUART.SendLen)
	{
		mUART.SendCount++;
		UART2_DR=mUART.SendBuffer[mUART.SendCount];
	}
	else
	{
		mUART.SendCount=0;	
		TXEN_FLAG=0;	//txd disable
	}	
	TC_FLAG=0;
#endif
	return;
}


@far @interrupt void UART2_Recv_IRQHandler(void)
{
	uchar ch;

	ch = UART2_DR;

	if(mUART.RecvCount == 0)
	{
		if(ch == HEKR_FRAME_HEADER)
		{
			mUART.RecvBuffer[mUART.RecvCount] = ch;
			mUART.RecvCount++;
		}
		else
		{
			mUART.RecvCount = 0;
		}
	}
	else if (mUART.RecvCount == 1)
	{	
		if((ch >= UART_RECV_LEN_MIN) && (ch < UART_RECV_LEN_MAX))
		{
			mUART.RecvBuffer[mUART.RecvCount] = ch;
			mUART.RecvLen = mUART.RecvBuffer[mUART.RecvCount];
			mUART.RecvCount++;
		}
		else
		{
			mUART.RecvCount = 0;
		}
	}
	else
	{
		mUART.RecvBuffer[mUART.RecvCount] = ch;
		mUART.RecvCount++;
		
		if(mUART.RecvCount >= mUART.RecvBuffer[1])
		{
			mUART.RecvFlag  = 1; //  表示接收到了完整的数据
			mUART.RecvCount = 0;
		}
	}
	
	RXNE_FLAG	= 0;
	OR_FLAG		= 0;	
	return;
}

