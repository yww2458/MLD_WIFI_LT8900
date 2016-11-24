/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 *
 *  Copyright (c) 2008 by MKS Controls
 *  
 *	 
 *  File name: commu.c
 *  Module:    
 *  Language:  ANSI C
 *  $Revision: 1 $
 *
 *  
 *
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
#include "sys.h"

NEAR GUART mGUART;

//----------------------------------------------------------------------
// ������Ϊʹ��PB4  PB5 ģ��GPIO����ͨѶ
// ���²���ʹ�ô��ں���ʾ�������Ľ���ͨѶ
//----------------------------------------------------------------------
void GUART_init(void)
{
	// ��ʼ��TX PC1, ����Ϊ���,���߼���
	GUART_TX_DDR = 1;
	GUART_TX_CR1 = 1;	
	GUART_TX_ODR = 1;
	

	disableInterrupts();
	// ��ʼ��RX PB5, ����Ϊ����,ʹ���ж�, �½��ش���
	GUART_RX_DDR = 0; //11111110
	GUART_RX_CR1 = 1; //11111110 1.45v ʹ������,��������ʽ
    GUART_RX_CR2 = 1; //  �ж�

	EXTI->CR1 &= (uint8_t)(~EXTI_CR1_PBIS);
    EXTI->CR1 |= 0x08; 

	//���ö�ʱ�� 

	TIM2->PSCR = 0x05;  // fTIM4 = fMASTER(16M)/32, T = 2us
	TIM2->ARRH = (uint8_t)BAUDTATE_TIME_CNT>>8;//TIMER4_CNT;				// T=200us
	TIM2->ARRL = (uint8_t)BAUDTATE_TIME_CNT;
		
	TIM2->IER  = 0x01;			// TIM4 interrrupt enable register
	//TIM2->CR1  = 0x01;			// TIM4 control register
	TIM2->CR1 = 0x00; 

	TIM2->SR1 &= 0x7E;

	
	// ʹ������ж����ȼ�����TIM2������TIM4���е�ʱ�����
	ITC->ISPR2 &= ~(0x03);  // INT_B
	ITC->ISPR4 &= ~(0x0C);  // INT_TIM2
	ITC->ISPR6 &= ~(0xC0);  // INT_TIM4
	ITC->ISPR6 |= 0x40;
	enableInterrupts();


	mGUART.status		= GUART_STATUS_TX;   // ��ʼ��Ϊ��ȡ״̬
	mGUART.RxTxDone		= 0;
	mGUART.RxTxBit 		= 0;
	mGUART.RxTxStSpFlag	= 0;
	mGUART.flagTimeOn	= 0;
	mGUART.funcCode 	= MACHINE_INFO_QUERY;

}

void BTSendData(void)
{
	mGUART.RxTxDone = 0;
	mGUART.RxTxBit  = 0;
	mGUART.RxTxStSpFlag = 0;
	mGUART.status = GUART_STATUS_TX;

	mGUART.RxTxData = mGUART.TxBuf[0]; 
	// ��ֹ��ȡ����
	GUART_RX_CR2 = 0;

 	// ���ö�ʱ��
 	GUART_TX_DDR = 1;  // ��Ҫ����TX����
 	GUART_TX_ODR = 0; // ���͵�һ���ֽڵ���ʼλ
	TIM2->CR1 = 0x01;
	
	mGUART.flagTimeOn = 1;
}

@far @interrupt void EXTI_PORTB_IRQHandler()
{
	GUART_RX_CR2 = 0; // ��ֹ�ж�
	
	mGUART.RxTxStSpFlag = 1;
	TIM2->CNTRH = (uint8_t)(BAUDTATE_TIME_CNT/2>>8);
	TIM2->CNTRL = (uint8_t)(BAUDTATE_TIME_CNT/2); 
	
	TIM2->CR1 = 0x01; // ��ʼ����
	mGUART.flagTimeOn = 1;
	mGUART.status = GUART_STATUS_RX;
}

/*********************************************************************
 * @brief  : TIM2�жϺ���,ʹ��TIM2��ΪGPIOģ�⴮�ڵĶ�ʱ��
 * @param  :
 * @retval :
 *********************************************************************/
@far @interrupt void TIM2_isr(void)
{		
	u8 temp8;
	unsigned char tempi,tempj;

	TIM2->SR1 &= 0x7E;
	TIM2->CNTRH = 0;
	TIM2->CNTRL = 0; 

	if(mGUART.status == GUART_STATUS_TX)  // ����
	{	
		//mGUART.offCounts = 0; // ���ڴ������ݣ� ��ʧ�˴�����
		if(mGUART.RxTxStSpFlag == 0)
		{
			if (mGUART.RxTxBit == 0)
			{
				mGUART.RxTxData = mGUART.TxBuf[mGUART.RxTxDone];
			}
	
			if (mGUART.RxTxData & 0x01) 	
			{
				GUART_TX_ODR = 1;
			}
			else
			{
				GUART_TX_ODR = 0;
			}
			
			mGUART.RxTxBit++;
			if(mGUART.RxTxBit >= 8)
			{
				mGUART.RxTxBit = 0;
				mGUART.RxTxStSpFlag = 3;
				mGUART.RxTxDone++;
			}
			else
			{
				mGUART.RxTxData >>= 1;
			}
			
			TIM2->CNTRH = 0;
			TIM2->CNTRL = 0; 

		}
		else if (mGUART.RxTxStSpFlag == 1)  // 1->0-3-1
		{
			GUART_TX_ODR = 0;
			mGUART.RxTxStSpFlag = 0;  
		}
		else if (mGUART.RxTxStSpFlag == 3)// ����ֹͣ����, ��������ʱ�䣬��֤��ʼʱ�����
		{
			GUART_TX_ODR = 1;
			
			mGUART.RxTxStSpFlag = 1;  //���Ϳ�ʼλ

			if (mGUART.RxTxDone >= mGUART.Txlen) //���������һ���ֽ�
			{
				mGUART.RxTxDone	= 0;
				mGUART.RxTxBit  = 0;

				mGUART.status = GUART_STATUS_RX;  // ������ɣ��л�Ϊ����״̬
				GUART_RX_CR2 = 1;
				
				TIM2->CR1 = 0x00; // �رն�ʱ������	
				mGUART.flagTimeOn = 0;
			}
		}
	}
	else if (mGUART.status == GUART_STATUS_RX)  // ��ȡ
	{
		//mGUART.offCounts = 0; //���յ����ݣ����
		
		if (mGUART.RxTxStSpFlag == 0)
		{
			if (GUART_RX_IDR == 1)//���ڶ����ȴ����λ��Ȼ���Ǹ�λ
			{
				mGUART.RxTxData |= 1<<(mGUART.RxTxBit);
			}
			
			mGUART.RxTxBit++;

			if(mGUART.RxTxBit >= 8)
			{
				mGUART.RxTxStSpFlag = 3;
				mGUART.RxTxBit = 0;
			}
		}
		else if (mGUART.RxTxStSpFlag == 1)// ��ʼλ
		{
			mGUART.RxTxStSpFlag = 0;
			mGUART.RxTxBit  = 0;
			mGUART.RxTxData = 0;
		}
		else if (mGUART.RxTxStSpFlag == 3) // ֹͣλ
		{
			mGUART.RxBuf[mGUART.RxTxDone] =  mGUART.RxTxData;
			
			// ����ͷ
			if (mGUART.RxTxDone == 0)
			{
				if(mGUART.RxBuf[0] == 0xF7)
				{
					mGUART.RxTxDone++;
				}
				else
				{
					mGUART.RxTxDone = 0;
				}
			}
			else if (mGUART.RxTxDone == 1)
			{
				if(mGUART.RxBuf[1] == 0xF8)
				{
					mGUART.RxTxDone++;
				}
				else
				{
					mGUART.RxTxDone = 0;
				}
			}
			else if (mGUART.RxTxDone == 4)
			{			
				if(mGUART.RxBuf[3] == 0x01 && mGUART.RxBuf[4] == 0x02)
				{
					mGUART.RxTxDone++;
				}
				else
				{
					mGUART.RxTxDone = 0;
				}
			}
			else if (mGUART.RxTxDone==(mGUART.RxBuf[2]+3))
			{
				if (mGUART.RxBuf[mGUART.RxTxDone]==0xfd)
				{
					#if 1
					tempj=0;
					for (tempi=2;tempi<(mGUART.RxTxDone-1);tempi++)
					{
						tempj+= mGUART.RxBuf[tempi];
					}
					
					if (tempj==mGUART.RxBuf[mGUART.RxTxDone-1])
					{
						mGUART.flagNew =1;
						//mGUART.Rxlen=mGUART.RxBuf[2];
					}
					else 
					{
						mGUART.RxTxDone=0;	
					}
					#else
					mGUART.flagNew =1;
					
					//mGUART.Rxlen=mGUART.RxBuf[2];
					#endif
				}
				else 
				{
					mGUART.RxTxDone=0;
				}
			}
			else
			{
				mGUART.RxTxDone++;
			}
			
			mGUART.Rxlen = mGUART.RxTxDone;
			
			if (mGUART.RxTxDone >= GUART_BUF_LEN)
			{
				mGUART.RxTxDone = 0;
			}

			GUART_RX_CR2 = 1;// IO���ж�ʹ��
			TIM2_CR1 = 0x00;// ֹͣ�Ĵ�������
			mGUART.flagTimeOn = 0;
		}
	}
	else  // �����Ϊʲô��һ�δ򿪼��������ܹ����붨ʱ�������ӿ��Դ����һ��ȡ������λ����
	{
		TIM2->CR1  = 0x00;
		// request_bt_flag = MCU2BT_DEFINE_ARG;
		mGUART.flagTimeOn = 0;
	}
}

void GUART_commu(void)
{
	uchar i;
	uchar temp8;
	uint temp16;
	u32  templ;
	
	mGUART.offCounts++;
	if (mGUART.offCounts>BT_COMMU_LOST_CNT) // 100ms
	{
		mGUART.offCounts = BT_COMMU_LOST_CNT;
	}


	if (mGUART.flagTimeOn == 1) // ��ʱ���Ѿ��򿪣����ڴ�������
	{
		return;
	}


	if (mGUART.status == GUART_STATUS_TX) // ����
	{
		//mGUART.funcCode = GUART_FUNCCODE_CONTROL;
  		mGUART.TxBuf[0] = COMMU_HEAD1;						//answer basing the order function
		mGUART.TxBuf[1] = COMMU_HEAD2;						//pctxd[2]=command_size-4;		//command size
		mGUART.TxBuf[3] = 0x01;
		mGUART.TxBuf[4] = 0x01;//�)�Ͽط��͵���1,�¿ط��͵���2,�������־ʶ�����Ͽػ����¿�
		mGUART.TxBuf[5] = mGUART.funcCode;

		switch(mGUART.funcCode) 
		{
			case MACHINE_INFO_QUERY:			//query product information
				
				mGUART.Txlen=0x08;
				break;
			case MACHINE_CONTROL:				//machine control
				mGUART.Txlen= 0x16;
				mGUART.TxBuf[6] = mDEV.user_request;
				mDEV.user_request= USER_REQUEST_NONE;						
				mGUART.TxBuf[7] = mDEV.rpm_target>>8;		//user_speed_target;
				mGUART.TxBuf[8] = mDEV.rpm_target;
				mGUART.TxBuf[9] = mDEV.incline_target;
				
				mGUART.TxBuf[10]= 130; //DC_MOTOR_CURRENT_MAX;
				mGUART.TxBuf[12]= 15;//LIFT_MOTOR_GRADIENT_MAX;
				templ=833333;//RPM_MEASURED_SCALE;
				mGUART.TxBuf[13]=templ>>24;
				mGUART.TxBuf[14]=templ>>16;				
				mGUART.TxBuf[15]=templ>>8;
				mGUART.TxBuf[16]=templ;

				break;
						
			default:
			
				break;								
		}

		mGUART.TxBuf[2]=mGUART.Txlen-4;
		temp8 = mGUART.TxBuf[2];
		for(i = 3; i < mGUART.Txlen-2; i++)
		{
			temp8 +=mGUART.TxBuf[i];
		}
		
		mGUART.TxBuf[mGUART.Txlen-2] = temp8;	//checksum
		mGUART.TxBuf[mGUART.Txlen-1] = 0xfd;	//end code
		BTSendData();
	}
	else
	{
		if(mGUART.flagNew == 1)
		{
			// �յ���ȷ������
			mGUART.offCounts   = 0; //���յ����ݣ����
			mGUART.flagNew     = 0;
			mGUART.pctra_delay = 2;
			mGUART.flag_ack    = 1;
			mGUART.err_cnt     = 0;

			mGUART.funcCode = mGUART.RxBuf[5];
			
			switch(mGUART.funcCode)
			{
				case MACHINE_INFO_QUERY:			//inquiring product information
				{
					mDEV.version_machine = mGUART.RxBuf[8];

					mGUART.funcCode=MACHINE_CONTROL;
					break;
				}
				case MACHINE_SET_ARG:
				{
					if (mGUART.RxBuf[7] == 1)
					{
						mGUART.funcCode=MACHINE_CONTROL;
					}
					else
					{
						mGUART.funcCode=MACHINE_SET_ARG;
					}
					break;
				}
				case MACHINE_CONTROL:
				{
					mDEV.rpm_machine= mGUART.RxBuf[7]<<8 | mGUART.RxBuf[8];

					if ((mDEV.user_request&USER_REQUEST_ERROR_RESET)==0)
					{
						mGUART.error_code = mGUART.RxBuf[19]<<8|mGUART.RxBuf[18];
					}
					
					if(mGUART.RxBuf[20]&0x40)
					{
						mDEV.flag_sensor_no=1;
					}
					else
					{
						mDEV.flag_sensor_no=0;
					}
					
					temp8=mGUART.RxBuf[20]&0x01;
					
					if (temp8==0x01)
					{
						mDEV.machine_state=MACHINE_STATE_RUN;
					}
					else 
					{
						mDEV.machine_state=MACHINE_STATE_IDLE;
					}

					temp8 = mGUART.RxBuf[20]&0x80;
					if (temp8 == 0x80)
					{
						mDEV.flag_incline_vr_err = 1;
					}
					else
					{
						mDEV.flag_incline_vr_err = 0;
					}

					
					// temp16 =  mGUART.RxBuf[24];
					// temp16 = temp16<<8;
					// mDEV.step = temp16+ mGUART.RxBuf[25];
					break;
				}
				default:
				{
					mGUART.funcCode=MACHINE_INFO_QUERY;	
					break;
				}

			}
		}
		else 
		{
			if(mGUART.err_cnt >= 10)
			{
				mGUART.err_cnt = 0;
				//mGUART.status = GUART_STATUS_TX;
			}
			else if (mTIME.sec == 0)
			{
				mGUART.err_cnt++;
				mGUART.status = GUART_STATUS_TX;
			}

			if(mGUART.pctra_delay)
			{
				mGUART.pctra_delay--;
			}
			else if (mGUART.flag_ack == 1)
			{
				mGUART.flag_ack =0;
				mGUART.status = GUART_STATUS_TX;
			}
		}		
	}
}
