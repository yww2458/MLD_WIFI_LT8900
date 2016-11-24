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


// LT8900��д
#define WRITE		0x7F
#define READ		0x80

// ----------------------���ٻ��߸ߵ��ֽڵ�λ��---------------------
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

// Ĭ��LT8900����BUFF����
//#define LT_BUFFLEN   15
#define TX_BUFFLEN   14
#define RX_BUFFLEN   12
// LT8900 ״̬
#define 	IDLE_Status  0x00
#define 	TX_Status    0x01
#define 	RX_Status    0x02

// LT8900�¿ط��Ϳ�������
#define    LT_CMD_STSP   		0x01  // ��ʼֹͣ����λ
#define    LT_CMD_STATUS 		0x02  // ״̬����λ
#define    LT_CMD_SPEED  		0x03  // �ٶ�����λ
#define    LT_CMD_CLRERR 		0x04  // �����λ
#define    LT_CMD_VERSION       0x05  // �汾������
#define    LT_CMD_MODE          0x06  // ģʽ����
#define    LT_CMD_BEEP          0x07  // ����������

// �����ŵ��������ڵ�ǰ�ŵ�ʱ��������ƥ��ģʽ
#define LT8900_CH_PUBLIC  		0x00
//#define BUFLEN					10


struct LT8900_DEV_TAG
{
	uchar status; 				// ��ǰ״̬, 0 ����, 1���� 2,����
	uint  commu_lost_cnt; 		// ͨѶ��ʧ����
	uchar TBUF[TX_BUFFLEN];     // ���ݷ���BUF
	uchar RBUF[RX_BUFFLEN];     // ���ݽ���BUF
	uchar RLen;             	// ���յ����ݳ���
	uchar TLen;                 // �������ݳ���
	uchar matchStatus;          // LT8900ƥ��״̬
	uchar CH;					// LT8900�����ŵ�
	uchar time_out;             // ���ͳ�ʱ�ȴ�
	uchar index;                // ���, ÿ��ִ������һ��
	uchar request;              // ��������
	uchar ACK_Lost_cnt;         // �������û�н��յ�ACK�Ĵ���
	uchar last_index;           // ���һ��index
	uint  match_time;		    // ƥ��ʱ��ͳ��
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
