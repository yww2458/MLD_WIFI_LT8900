#ifndef _SYS_H__
#define _SYS_H__

#include "newtype.h"
#include "stm8s.h"
#include "stm8s105K.h"
#include "sys.h"
#include "delay.h"
#include "stm8_uart.h"
#include "hekr_protocol.h"
#include "commu.h"
#include "user.h"
#include "LT8900.h"
#include "beep.h"
void SYS_INI(void);

typedef struct
{
	//uchar disp_all_time_cnt;
	uchar flag_1s;
	volatile uint  timer_1s;
	volatile uchar timer_1ms;
	uchar sec;
	u32 countWhile;

}__TIME;

extern __TIME mTIME;

typedef enum
{
	DEV_STATUS_NONE = 0,
	DEV_STATUS_IDLE,
	DEV_STATUS_RUN
}DEV_STATUS_TYPE;

typedef enum
{
	MACHINE_STATE_IDLE = 0,
	MACHINE_STATE_RUN
}_MACHINE_STATE;

typedef enum
{
	STATE_REQUEST_IDLE = 0,
	STATE_REQUEST_RUN
}_MACHINE_REQUEST;

typedef struct
{
	DEV_STATUS_TYPE status;
	uint HZ;
	uint scale;
	uint rpm;
	uchar error_code;
	
	uchar flag_sensor_no;
	uchar flag_incline_vr_err;
	_MACHINE_STATE machine_state;
	uchar user_request;
	uint rpm_target;
	uchar incline_target;
	uchar version_machine;
	uint rpm_machine;
	uchar machine_mode;
	uint rpm_target_new;
	_MACHINE_REQUEST machine_state_request;
	uchar newStatusToBT;
}__DEV;

extern NEAR __DEV mDEV;


typedef struct
{
	// 状态相关数据
	uchar  mode;			// 模块模式
	uchar  WIFI_status;		// WIFI 状态
	uchar  CloudStatus;		// 云连接状态
	uchar  SignalStrength;  //信号强度

	// 版本相关数据
	uchar  version_main;  		// 主版本
	uchar  version_minor;       // 次版本
	uchar  version_debug;       // 编译版本
	uchar  version_type;        // 版本类型
}__WIFI;

extern NEAR __WIFI  mWIFI;


void timer_proc(void);

#endif
