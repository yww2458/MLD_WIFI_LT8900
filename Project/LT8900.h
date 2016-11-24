#ifndef __LT8900_H__
#define __LT8900_H__

//#include "declare.h"
/*-------------------------------------------------
 | SPI_CS  : PA3
 | SPI_CLK : PC5
 | SPI_MOSI: PC7
 | SPI_MISO: PC6
 | SPI_RST : PD2
 | SPI_PKT : PA1
 --------------------------------------------------*/
#define LT_CS_SetVal()  	(GPIOA->ODR |= (uint8_t)(1<<3))
#define LT_CS_ClrVal()  	(GPIOA->ODR &= (uint8_t)(~(1<<3)))

#define LT_CLK_SetVal() 	(GPIOC->ODR |= (uint8_t)(1<<5))
#define LT_CLK_ClrVal() 	(GPIOC->ODR &= (uint8_t)(~(1<<5)))
#define LT_MOSI_SetVal() 	(GPIOC->ODR |= (uint8_t)(1<<7))
#define LT_MOSI_ClrVal() 	(GPIOC->ODR &= (uint8_t)(~(1<<7)))
#define LT_RST_SetVal() 	(GPIOD->ODR |= (uint8_t)(1<<2))
#define LT_RST_ClrVal() 	(GPIOD->ODR &= (uint8_t)(~(1<<2)))
#define LT_MISO 			(GPIOC->IDR &= ((uint8_t)(1<<6)))

#define PKT_FLAG 			GET_BITFIELD(&PA_IDR).bit1

//===================================================
// LT8900 Parameter Definition
//===================================================
#define SYNCWORD_0	0x34
#define SYNCWORD_1	0x56
#define SYNCWORD_2	0x78
#define SYNCWORD_3	0x9A
#define SYNCWORD_4	0xBC
#define SYNCWORD_5	0xDE
#define SYNCWORD_6	0xF0
#define SYNCWORD_7	0x12

//Reg32 (0x20)
#define LT_PREAMBLE_LEN			7 // preamble = 4byte
#define LT_SYNCWORD_LEN 		3 // syncword = 64bit
#define	LT_TRAILER_LEN			0 // trailer = 4bit
#define LT_DATA_PACKET_TYPE		0 // data packet type = NRZ law
#define LT_FEC_TYPE				0 // No FEC
#define LT_BRCLK_SEL			0 // NO BRCLK clock output
#define LT_R32H					((LT_PREAMBLE_LEN << 5) + (LT_SYNCWORD_LEN << 3) + LT_TRAILER_LEN)
#define LT_R32L					((LT_DATA_PACKET_TYPE << 6) + (LT_FEC_TYPE << 4) + (LT_BRCLK_SEL << 1))

//Reg40 (0x28)
#define LT_FIFO_EMPTY_THRESHOLD	4
#define LT_FIFO_FULL_THRESHOLD	4
#define	LT_SYNCWORD_THRESHOLD	7
#define LT_R40H					((LT_FIFO_EMPTY_THRESHOLD << 3)+ (LT_FIFO_FULL_THRESHOLD >> 2))
#define LT_R40L					((LT_FIFO_FULL_THRESHOLD<<6) + LT_SYNCWORD_THRESHOLD)



//Reg41 (0x29)
#define	LT_CRC_ON			1 //CRC on
#define LT_SCRAMBLE_ON		1 //scrable off
#define	LT_PACK_LENGTH_EN	1 //first data byte is packet length
#define LT_FW_TERM_TX		1
#define LT_AUTO_ACK			0 //auto ACK
#define	LT_PKT_FIFO_POL 	0 //PKT_FLAG is active high
#define LT_CRC_INIT_DATA	0x00 //CRC initial data


// LT8900读写
#define WRITE		0x7F
#define READ		0x80

// ----------------------快速或者高低字节的位数---------------------
extern unsigned char RegH, RegL;
#define H7	GET_BITFIELD(&RegH).bit7
#define H6  GET_BITFIELD(&RegH).bit6
#define H5	GET_BITFIELD(&RegH).bit5
#define H4	GET_BITFIELD(&RegH).bit4
#define H3	GET_BITFIELD(&RegH).bit3
#define H2	GET_BITFIELD(&RegH).bit2
#define H1	GET_BITFIELD(&RegH).bit1
#define H0	GET_BITFIELD(&RegH).bit0

#define L7	GET_BITFIELD(&RegL).bit7
#define L6  GET_BITFIELD(&RegL).bit6
#define L5	GET_BITFIELD(&RegL).bit5
#define L4	GET_BITFIELD(&RegL).bit4
#define L3	GET_BITFIELD(&RegL).bit3
#define L2	GET_BITFIELD(&RegL).bit2
#define L1	GET_BITFIELD(&RegL).bit1
#define L0	GET_BITFIELD(&RegL).bit0

#define REG_8  	H0
#define REG_9  	H1
#define REG_10  H2
#define REG_11  H3
#define REG_12  H4
#define REG_13  H5
#define REG_14  H6
#define REG_15  H7
//----------------------------------------------------------

// 默认LT8900数据BUFF长度
//#define LT_BUFFLEN   15
#define TX_BUFFLEN   14
#define RX_BUFFLEN   12
// LT8900 状态
#define 	IDLE_Status  0x00
#define 	TX_Status    0x01
#define 	RX_Status    0x02

// LT8900下控发送控制命令
#define    LT_CMD_STSP   		0x01  // 开始停止命令位
#define    LT_CMD_STATUS 		0x02  // 状态请求位
#define    LT_CMD_SPEED  		0x03  // 速度请求位
#define    LT_CMD_CLRERR 		0x04  // 清除错位
#define    LT_CMD_VERSION       0x05  // 版本号请求
#define    LT_CMD_MODE          0x06  // 模式请求
#define    LT_CMD_BEEP          0x07  // 蜂鸣器请求

// 公用信道，当处于当前信道时处于搜索匹配模式
#define LT8900_CH_PUBLIC  		0x00
//#define BUFLEN					10


struct LT8900_DEV_TAG
{
	uchar status; 				// 当前状态, 0 空闲, 1发送 2,接收
	uint  commu_lost_cnt; 		// 通讯丢失次数
	uchar TBUF[TX_BUFFLEN];     // 数据发送BUF
	uchar RBUF[RX_BUFFLEN];     // 数据接收BUF
	uchar RLen;             	// 接收到数据长度
	uchar TLen;                 // 发送数据长度
	uchar matchStatus;          // LT8900匹配状态
	uchar CH;					// LT8900处于信道
	uchar time_out;             // 发送超时等待
	uchar index;                // 序号, 每次执行增加一次
	uchar request;              // 发送请求
	uchar ACK_Lost_cnt;         // 发送完成没有接收到ACK的次数
	uchar last_index;           // 最后一次index
	uint  match_time;		    // 匹配时间统计
	uchar up_id;				// 
	uchar down_id;
	uchar first_data;
	uchar new_request;
	uchar flag_version;
};


extern struct LT8900_DEV_TAG mLT8900;


typedef struct
{
	uchar flag_time_setting;
	uint  flag_sec;

	uchar machine_mode;	
	uint  setting_min;
	
	uint 	run_min;
	uchar	run_sec; 
	
	uint    cal;

	uint	hz;

	uu16 user_calories_100c_cnt;
	uu16 user_calories_100c_time;
}_USER;

extern _USER mUSER;

void mdelay(uint ms);
void Init_LT8900(void);
void LT8900_DOWN_Deal(void);
uchar eeprom_wrchar(uint addr, uchar ucdata);
uchar eeprom_rdchar(uint addr);

#endif
