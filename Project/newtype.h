#ifndef __NEWTYPEDEF_H__
#define __NEWTYPEDEF_H__

//system clock definition
#define CLOCK				16000				//16Mhz
#define TIMER4_CNT    		(100-1) 
#define TIME_BASE_MAIN      (100-1)
#define TIME_BASE_SEC		50					//base on time_base_main, 1s
#define TIME_ISR_SEC        5000   				// base on time4_isr ,  1s

#define RPM_STEP_USER   	400
#define VERSION         	10
/*********************************************************************
 * ʹ������ĺ궨����Կ��ٵ�����ĳ��GPIO�ľ���Pin�Ĺ���
 * ���жԵ���GPIO�Ų�����ʱ�򣬽���ʹ�����µĺ궨��
 *********************************************************************/
#define GPIO_IDR(x,n)	GET_BITFIELD(&P##x##_IDR).bit##n//(GPIO##x->IDR.bit##n) //(GPIO##x->IDR.field.B##n) //GPIO����Ĵ���
#define GPIO_ODR(x,n)	GET_BITFIELD(&P##x##_ODR).bit##n//(GPIO##x->ODR.bit##n) //(GPIO##x->ODR.field.B##n) //GPIO����Ĵ���
#define GPIO_CR1(x,n)	GET_BITFIELD(&P##x##_CR1).bit##n//(GPIO##x->CR1.bit##n) //(GPIO##x->CR1.field.B##n) //���üĴ���1
#define GPIO_CR2(x,n)	GET_BITFIELD(&P##x##_CR2).bit##n//(GPIO##x->CR2.bit##n) //(GPIO##x->CR2.field.B##n) //���üĴ���2
#define GPIO_DDR(x,n)	GET_BITFIELD(&P##x##_DDR).bit##n//(GPIO##x->DDR.bit##n) //(GPIO##x->DDR.field.B##n) //����GPIO�ŷ���



#define TXEN_FLAG		GET_BITFIELD(&UART2_CR2).bit3 //����ʹ�ܱ�־λ
#define RXEN_FLAG		GET_BITFIELD(&UART2_CR2).bit2 //����ʹ�ܱ�־λ
#define TXE_FLAG		GET_BITFIELD(&UART2_SR).bit6 //�������ݼĴ����ձ�־λ
#define TC_FLAG			GET_BITFIELD(&UART2_SR).bit6 //������ɱ�־λ
#define RXNE_FLAG		GET_BITFIELD(&UART2_SR).bit5 //�����ݼĴ����ǿձ�־λ
#define OR_FLAG			GET_BITFIELD(&UART2_SR).bit3 //�����־λ

#define EOP_FLAG		GET_BITFIELD(&FLASH_IAPSR).bit2 //
#define PUL_FLAG		GET_BITFIELD(&FLASH_IAPSR).bit1 //
#define WR_PG_DIS		GET_BITFIELD(&FLASH_IAPSR).bit0 //
#define UNLOCK_FLAG		GET_BITFIELD(&FLASH_IAPSR).bit3 //


// ģ��GPIO��ز���
// RX PB4
#define GUART_RX_DDR 	GPIO_DDR(B,0)//GET_BITFIELD(&PB_DDR).bit5
#define GUART_RX_ODR	GPIO_ODR(B,0)//GET_BITFIELD(&PB_ODR).bit5
#define GUART_RX_IDR	GPIO_IDR(B,0)//GET_BITFIELD(&PB_IDR).bit5
#define GUART_RX_CR1	GPIO_CR1(B,0)//GET_BITFIELD(&PB_CR1).bit5
#define GUART_RX_CR2	GPIO_CR2(B,0)//GET_BITFIELD(&PB_CR2).bit5


// TX PB5
#define GUART_TX_DDR 	GPIO_DDR(B,4)//GET_BITFIELD(&PB_DDR).bit5
#define GUART_TX_ODR	GPIO_ODR(B,4)//GET_BITFIELD(&PB_ODR).bit5
#define GUART_TX_IDR	GPIO_IDR(B,4)//GET_BITFIELD(&PB_IDR).bit5
#define GUART_TX_CR1	GPIO_CR1(B,4)//GET_BITFIELD(&PB_CR1).bit5
#define GUART_TX_CR2	GPIO_CR2(B,4)//GET_BITFIELD(&PB_CR2).bit5

#endif
