#include "sys.h"

struct LT8900_DEV_TAG mLT8900;
_USER mUSER;


#define CNT_SNED_DELAY_5MS  1
uchar RegH, RegL;

void mdelay(uint ms)
{
	unsigned int j=0;	
    unsigned int i;

    for(i=0;i<ms;i++)
    {
    	j= 315;//315;//16M	
        while(j)
        {
    	    j--;
        }
    }
}

void delay2_5US_1(u16 nCount)
{
  while (nCount != 0)
  {
    nCount--;
  }
}

u8  SPI_SendByte(unsigned char bcdVal)
{
	int i = 0;
	u8 dataR=0;

	for(i=0;i<8;i++)
    {

    	if(bcdVal&0x80)
        {
        	LT_MOSI_SetVal();
    	}
		else 
        {
        	LT_MOSI_ClrVal();   
		}

    	LT_CLK_SetVal();
    	delay2_5US_1(4);  //  4

    	bcdVal<<=1;

        dataR<<=1;
    	if(LT_MISO)
        {
        	dataR|=((u8)0x01);
    	}

    	LT_CLK_ClrVal();    	
    	delay2_5US_1(4);
    	
    }	
    return (dataR);
}


void LT_WriteReg(unsigned char reg, unsigned char H, unsigned char L)
{
	LT_CS_ClrVal();
	delay2_5US_1(4);

	SPI_SendByte(WRITE & reg);
	delay2_5US_1(4);
	SPI_SendByte(H);
	delay2_5US_1(4);
	SPI_SendByte(L);
	delay2_5US_1(4);

	LT_CS_SetVal();

}

void Get_chipId(void)
{
	u8 chipUniqueID[12];
	u8 i;
	mLT8900.down_id = 0;
	for(i = 0; i <12; i++)
	{
		// stm8s105 chipUniqueID 起始地址为0x48CD
		// stm8s103 chipUniqueID 起始地址为0x4865
		chipUniqueID[i] = *(volatile u16 *)(0x4865+i);
		mLT8900.down_id ^=  chipUniqueID[i];
	}
	
	if (mLT8900.down_id == 0){  // 由于 0是公共信道，所以不会采用0
		mLT8900.down_id = 0xFF;
	}
}



/*-------------------------------------------------
 | SPI_CS  : PA3
 | SPI_CLK : PC5
 | SPI_MOSI: PC7
 | SPI_MISO: PC6
 | SPI_RST : PD2
 | SPI_PKT : PA1
 --------------------------------------------------*/
void Init_LT8900(void)
{

//------------初始化PGIO-------------------------------
//  cs
	GPIOA->DDR |= (1<<3);//11111110
	GPIOA->CR1 |= (1<<3);//11111110 1.45v 使用输入,无上拉方式
//  clk
	GPIOC->DDR |= (1<<5);//11111110
	GPIOC->CR1 |= (1<<5);//11111110 1.45v 使用输入,无上拉方式
//  mosi
	GPIOC->DDR |= (1<<7);//11111110
	GPIOC->CR1 |= (1<<7);//11111110 1.45v 使用输入,无上拉方式
//  miso
	GPIOC->DDR &= ~(1<<6);//11111110
	GPIOC->CR1 |= (1<<6);//11111110 1.45v 使用输入,无上拉方式
//  rst2
	GPIOD->DDR |= (1<<2);//11111110
	GPIOD->CR1 |= (1<<2);//11111110 1.45v 使用输入,无上拉方式
//  PKT1 ------>IN
	GPIOA->DDR &= ~(1<<1);//11111110
	GPIOA->CR1 |= (1<<1);//11111110 1.45v 使用输入,无上拉方式


	LT_RST_ClrVal();
	mdelay(100);
	LT_RST_SetVal();
	mdelay(200);

	LT_CLK_ClrVal(); //set SPI clock to low


//----------------------------------------------
// 以上为初始化LT8900代码, 请勿随意修改
//-----------------------------------------------
    LT_WriteReg(0, 0x6f, 0xe0);
    LT_WriteReg(1, 0x56, 0x81);
    LT_WriteReg(2, 0x66, 0x17);
    LT_WriteReg(4, 0x9c, 0xc9);
    LT_WriteReg(5, 0x66, 0x37);
    LT_WriteReg(7, 0x00, 0x30); //  0x00 0x30
    LT_WriteReg(8, 0x6c, 0x90);
    LT_WriteReg(9, 0x18, 0x40);		//  0x18 0x40			// 5.5dBm
    LT_WriteReg(10, 0x7f, 0xfd);
    LT_WriteReg(11, 0x00, 0x08);
    LT_WriteReg(12, 0x00, 0x00);
    LT_WriteReg(13, 0x48, 0xbd);
	
    LT_WriteReg(22, 0x00, 0xff);
    LT_WriteReg(23, 0x80, 0x05);
    LT_WriteReg(24, 0x00, 0x67);
    LT_WriteReg(25, 0x16, 0x59);
    LT_WriteReg(26, 0x19, 0xe0);
    LT_WriteReg(27, 0x13, 0x00);
    LT_WriteReg(28, 0x18, 0x00);

	
    LT_WriteReg(32, 0x48, 0x00); //  0x40 0x00   8  f1==48
    LT_WriteReg(33, 0x3f, 0xc7);
    LT_WriteReg(34, 0x20, 0x00);
    LT_WriteReg(35, 0x03, 0x00); //  3
    LT_WriteReg(36, 0x03, 0x80); //  start ID
    LT_WriteReg(37, 0x03, 0x80);
    LT_WriteReg(38, 0x5a, 0x5a);
    LT_WriteReg(39, 0x03, 0x80); //  end ID
    LT_WriteReg(40, 0x44, 0x02);
	
    LT_WriteReg(41, 0xB8, 0x00); // 修改为低有效 ,防止无效的时候就是高电平
    LT_WriteReg(42, 0xfd, 0xb0);  //
    LT_WriteReg(43, 0x00, 0x0f);
    LT_WriteReg(50, 0x00, 0x00);
    mdelay(200);
    LT_WriteReg(7, 0x00, 0x30);
	mdelay(50); //delay 10ms to let LT8900 for operation
/**************************************************/
// * 以上为初始化LT8900代码, 请勿随意修改
/**************************************************/

	mLT8900.up_id = eeprom_rdchar(0);
	mLT8900.CH = mLT8900.up_id; //idUser;
	mLT8900.status = RX_Status;
	mLT8900.matchStatus = 0; //设置成未匹配状态
	Get_chipId(); // mLT8900.down_id;

	// 初始化完成，使用私有信道进行扫描
	LT_WriteReg(7,  0x00, 0x00);
	LT_WriteReg(52, 0x80, 0x80);			// 清空接收缓存区
	LT_WriteReg(7,  0x00, 0x80|mLT8900.CH);	// 允许接收使能

}



void SPI_WriteByte(unsigned char bcdVal)
{
	int i = 0;
	
	LT_CS_ClrVal();

	for(i=0;i<8;i++)
    {

    	if(bcdVal&0x80)
        {
        	LT_MOSI_SetVal();
    	}
    	else 
        {
        	LT_MOSI_ClrVal();   
    	}
		
    	bcdVal<<=1;
    	delay2_5US_1(1);
    	LT_CLK_ClrVal();
    	delay2_5US_1(1);
    	LT_CLK_SetVal();
    }	

	LT_CS_SetVal();
}


u8  SPI_ReadByte(void)
{
	int i = 0;
	u8 data=0;

	for(i=0;i<8;i++)
    {
    	delay2_5US_1(1);
    	LT_CLK_SetVal();
        data<<=1;
    	if(LT_MISO)
        {
        	data|=(0x01);     	
    	}
    	delay2_5US_1(1);
    	LT_CLK_ClrVal();
    }	

	return data;
}





u8 dataStatus=0;
void LT_ReadReg(unsigned char reg)
{
	LT_CS_ClrVal();
	delay2_5US_1(4);
	dataStatus=SPI_SendByte(READ | reg);
	delay2_5US_1(4);
	RegH = SPI_SendByte(0xFF);//  0xFF  0
	delay2_5US_1(4);
	RegL = SPI_SendByte(0xFF);//  0xFF  0
	delay2_5US_1(4);
	LT_CS_SetVal();

}  

void LT_TO_IDLE(void)
{
	LT_WriteReg(7, 0x00, 0x00);			  //goto idle mode
}
 
void LT_StartRx(void)
{
	LT_WriteReg( 7, 0x00, 0x00); 
	LT_WriteReg(52, 0x80, 0x80);			// 清空发送缓存区
	LT_WriteReg(7, 0x00, 0x80|mLT8900.CH);  // 允许接收使能
	mLT8900.status = RX_Status;
	mLT8900.ACK_Lost_cnt = 0;
}

void mdelay_1(u16 ms)
{
  mdelay(ms);
}

void LT_comm_status_pack(void)
{
	mLT8900.TLen = 5;

	mLT8900.TBUF[1] = 0xF8;

	if (mDEV.error_code == 0)
	{
		mLT8900.TBUF[3] = mDEV.machine_state;

		if (mDEV.machine_state  == MACHINE_STATE_RUN)
		{
			mLT8900.TBUF[4] = (mDEV.rpm_target_new/RPM_STEP_USER);
		}
		else
		{
			mLT8900.TBUF[4] = 0;
		}
	}
	else
	{
		mLT8900.TBUF[3] = 0x3;  // 出错
		mLT8900.TBUF[4] = mDEV.error_code;
		
	}

	mLT8900.TBUF[5] = mDEV.machine_mode; //模式 
	mLT8900.TBUF[2] = LT_CMD_STATUS;

}


u8 LT8900_check_data(void)
{
	uchar xor_crc, add_crc;
	uchar i;
	xor_crc = 0;
	add_crc = 0;

	// 和校验
	for (i=1;i<10;i++)
	{
		add_crc=add_crc + mLT8900.RBUF[i];
	}

	// 包头、包尾、和校验正确
	if ((mLT8900.RBUF[1] == 0xF7)&&
		(mLT8900.RBUF[10] == add_crc)&&
		(mLT8900.RBUF[11] == 0xFD))
	{

		if (mLT8900.matchStatus == 0)
		{
			if (mLT8900.RBUF[2] != mLT8900.up_id)
			{
				mLT8900.up_id = mLT8900.RBUF[2];
				//EEPROM_write_8900_userid(idUser);
			}
			return 1;
		}
		else
		{
			if (mLT8900.RBUF[2] != mLT8900.up_id)
			{
				return 0;
			}
			else
			{
				return 1;
			}
	
		}
	}
	else
	{
		return 0;
	}
}


void LT8900_unpack_data(void)
{
	uchar temp8;
	uint  temp16;
	
	if (mLT8900.RBUF[7] == mLT8900.down_id)
	{
	
		temp8 =  mLT8900.RBUF[3] &0x80;
		if (temp8 == 0x80)
		{
			mLT8900.new_request = 0;
			//mLT8900.last_index =  mLT8900.RBUF[5]>>4;
		}
		else
		{
			if(mLT8900.new_request == 1)
			{
				return;
			}
		}

		temp8 = mLT8900.RBUF[3] & 0x01;
		if (temp8 == 0x01)
		{
			if(mDEV.machine_state != MACHINE_STATE_RUN)
			{
				mDEV.machine_state_request=STATE_REQUEST_RUN;
				mDEV.newStatusToBT = 1;
			}
		}
		else
		{
			if(mDEV.machine_state != MACHINE_STATE_IDLE)
			{
				mDEV.machine_state_request=STATE_REQUEST_IDLE;
				mDEV.newStatusToBT = 1;
			}
		}
		
		temp8 =  mLT8900.RBUF[3] &0x02;
		if (temp8 == 0x02)
		{
			mLT8900.flag_version = 1;
		}
		else
		{
			mLT8900.flag_version = 0;
		}

		// 有新的SPEED需要更新
		//temp8 =  mLT8900.RBUF[3] &0x04;
		//if (temp8 == 0x04)
		{
			temp8= mLT8900.RBUF[4];
			if (mUSER.hz!= temp8 && temp8 <= 60)
			{
				mUSER.hz = temp8;
			}
		}

		if(mDEV.machine_state == MACHINE_STATE_RUN)
		{
			mDEV.rpm_target_new = mUSER.hz * RPM_STEP_USER;
		}
		

		temp8 = mLT8900.RBUF[5]>>4;
		if (temp8 != mLT8900.last_index)
		{
			mLT8900.last_index = temp8;
			Beep(BEEP_KEY);
		}

		// 只有在非运动状态下才可以切换运动模式
		temp8 = mLT8900.RBUF[5] & 0x0F;  // 低四位表示模式
		if (mDEV.machine_state != MACHINE_STATE_RUN)
		{
			mUSER.machine_mode = temp8;
			mDEV.newStatusToBT = 1;
		}
		
		temp16 = mLT8900.RBUF[8]>>8;
		temp16 += mLT8900.RBUF[9];
		if(temp16 != 0)
		{
			mUSER.setting_min   = temp16;
			mUSER.flag_time_setting = 1;
		}
	}
	
}


void LT8900_pack_data(void)
{
	uchar tempc;
	uchar temp8;

	//TBUF_DOWN[0] = 9;
	mLT8900.TBUF[0] =13;
	//发送数据合成。
	mLT8900.TBUF[1] =mLT8900.up_id;
	mLT8900.TBUF[2] =mLT8900.down_id;  	// 下控ID	
	if(mUSER.hz < 10)
	{
		mUSER.hz = 10;
	}
	tempc =(mUSER.hz)|(mDEV.machine_state<<7);		
	mLT8900.TBUF[3] =tempc;  //  key

	// 运行秒数		
	mLT8900.TBUF[4] = mLT8900.new_request<<7;
	mLT8900.TBUF[4] += mUSER.machine_mode;


	if(mLT8900.flag_version)
	{
		mLT8900.TBUF[5] = VERSION;// 返回下控版本号
	}
	else
	{
		mLT8900.TBUF[5] = mDEV.error_code;//返回错误
	}

	
	// 设定时间
	mLT8900.TBUF[6]= mUSER.setting_min>> 8;
	mLT8900.TBUF[7]= mUSER.setting_min;

	// 运行时间
	mLT8900.TBUF[8]= mUSER.run_min >> 8;
	mLT8900.TBUF[9]= mUSER.run_min;

	// 卡路里
	mLT8900.TBUF[10]= mUSER.cal>> 8;
	mLT8900.TBUF[11]= mUSER.cal;
	
	//mLT8900.TBUF[11]= mLT8900.down_id;
	temp8=0;
	for (tempc=1;tempc<12;tempc++)
	{
		temp8=temp8+mLT8900.TBUF[tempc];
	}
	mLT8900.TBUF[12]=temp8; //checksum
	mLT8900.TBUF[13]=mUSER.run_sec;
}


void LT8900_read_data(void)
{
	uchar i;
	
	LT_ReadReg(48);
	if(!(RegH & 0x80)) // CRC
	{
		for(i=0; i<(RX_BUFFLEN/2); i++)
		{
			LT_ReadReg(50);
			mLT8900.RBUF[i*2]	= RegH;
			mLT8900.RBUF[i*2+1]	= RegL;
		}
	}
}

void LT8900_send_data(void)
{
	uchar i;
	
	LT_WriteReg(7, 0x00, 0x00);
	LT_WriteReg(52, 0x80, 0x00);			// 清空发送缓存区

	for(i=0; i<=TX_BUFFLEN/2; i++)
	{
		LT_WriteReg(50, mLT8900.TBUF[i*2], mLT8900.TBUF[i*2+1]);
	} 
	LT_WriteReg(7, 0x01, mLT8900.CH); // 允许发射使能

	// 等待发送完成
	mLT8900.time_out = 10; // 10*200us = 2ms
	while(PKT_FLAG != 0x01)
	{
		if(mLT8900.time_out == 0) // 2ms
		{
			break; // 跳出while
		}
	}
}

void LT8900_match_Deal(void)
{
	uchar i;
	mLT8900.match_time++;

	if (mLT8900.match_time > 6000)
	{
		mLT8900.match_time = 0;
		mLT8900.matchStatus = 1;
		return;
	}

	if (mLT8900.match_time%200==0 && mLT8900.match_time>400)
	{
		if (mLT8900.CH == LT8900_CH_PUBLIC)
		{
			mLT8900.CH = mLT8900.up_id;
		}
		else
		{
			mLT8900.CH = LT8900_CH_PUBLIC;
		}

		LT_StartRx();
	}
	
	if (PKT_FLAG > 0)
	{
		LT_TO_IDLE();
		LT8900_read_data();

		if (LT8900_check_data() == 1)
		{
			Beep(BEEP_FIND_WIRELESS);
			mLT8900.CH=mLT8900.up_id;
			mLT8900.matchStatus = 1;
			mLT8900.match_time = 0;
			
			eeprom_wrchar(0, mLT8900.up_id);
			LT_StartRx();
		}
	}			

}


void LT8900_DOWN_Deal(void)
{
	unsigned char i = 0;
	uchar temp8,tempc;
	ulong templ,templ1;
	u8 ret;
	uint temp16;

	mLT8900.commu_lost_cnt++;

	if (mLT8900.matchStatus == 0)
	{
		mLT8900.new_request = 1;
		LT8900_match_Deal();
		return;
	}

	switch(mLT8900.status)
	{
		case RX_Status:
			if (PKT_FLAG > 0)// 接收到数据
			{
				LT_TO_IDLE();
				LT8900_read_data();
				if (LT8900_check_data() == 1)
				{
					LT8900_unpack_data();
					mLT8900.status = TX_Status;	
					mLT8900.commu_lost_cnt = 0;
					LT_TO_IDLE();
				}
			}

			if (mLT8900.commu_lost_cnt >= 150) // 150*5=750ms
			{	
				mLT8900.commu_lost_cnt  = 0;
				mLT8900.new_request = 1;
				LT_StartRx();
			}
			break;
		case TX_Status:
			LT8900_pack_data();
			LT8900_send_data();
			LT_StartRx();
			break;
		default:
			break;
	}
}
