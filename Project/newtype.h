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
 * 使用下面的宏定义可以快速的配置某组GPIO的具体Pin的功能
 * 当有对单个GPIO脚操作的时候，建议使用如下的宏定义
 *********************************************************************/
#define GPIO_IDR(x,n)	GET_BITFIELD(&P##x##_IDR).bit##n//(GPIO##x->IDR.bit##n) //(GPIO##x->IDR.field.B##n) //GPIO输入寄存器
#define GPIO_ODR(x,n)	GET_BITFIELD(&P##x##_ODR).bit##n//(GPIO##x->ODR.bit##n) //(GPIO##x->ODR.field.B##n) //GPIO输出寄存器
#define GPIO_CR1(x,n)	GET_BITFIELD(&P##x##_CR1).bit##n//(GPIO##x->CR1.bit##n) //(GPIO##x->CR1.field.B##n) //配置寄存器1
#define GPIO_CR2(x,n)	GET_BITFIELD(&P##x##_CR2).bit##n//(GPIO##x->CR2.bit##n) //(GPIO##x->CR2.field.B##n) //配置寄存器2
#define GPIO_DDR(x,n)	GET_BITFIELD(&P##x##_DDR).bit##n//(GPIO##x->DDR.bit##n) //(GPIO##x->DDR.field.B##n) //配置GPIO脚方向



#define TXEN_FLAG		GET_BITFIELD(&UART2_CR2).bit3 //发送使能标志位
#define RXEN_FLAG		GET_BITFIELD(&UART2_CR2).bit2 //接收使能标志位
#define TXE_FLAG		GET_BITFIELD(&UART2_SR).bit6 //发送数据寄存器空标志位
#define TC_FLAG			GET_BITFIELD(&UART2_SR).bit6 //发送完成标志位
#define RXNE_FLAG		GET_BITFIELD(&UART2_SR).bit5 //读数据寄存器非空标志位
#define OR_FLAG			GET_BITFIELD(&UART2_SR).bit3 //错误标志位

#define EOP_FLAG		GET_BITFIELD(&FLASH_IAPSR).bit2 //
#define PUL_FLAG		GET_BITFIELD(&FLASH_IAPSR).bit1 //
#define WR_PG_DIS		GET_BITFIELD(&FLASH_IAPSR).bit0 //
#define UNLOCK_FLAG		GET_BITFIELD(&FLASH_IAPSR).bit3 //


// 模拟GPIO相关操作
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
