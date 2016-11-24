/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 *
 *  Copyright (c) 2002 by MKS Controls
 *  
 *
 *  File name: eeprom.c
 *  Module:    
 *  Language:  ANSI C
 *  $Revision: 1 $
 *
 *  This is an embedded software module design for interrupt process routine.
 *
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

#include <sys.h>

#define EEPROM_PART_SIZE			5				//bytes in a part
#define EEPROM_ADR_INI				0x4000
@near  uchar eeprom_step;
@near  uchar eeprom_pt;
@near  uint	eeprom_addr;
@near  uchar eeprom_buffer[EEPROM_PART_SIZE];



/*---------------------------------------------------------------------------*
 |  eeprom_wrchar
 |
 |  write uchar to eeprom; if done, return 1, or 0
 *---------------------------------------------------------------------------*/
uchar eeprom_wrchar(uint addr, uchar ucdata)
{	
	while(EOP_FLAG==1)return(0); 
   FLASH->DUKR = 0xAE; 
   FLASH->DUKR = 0x56 ; //unlock
   //FLASH->CR2 = 0x00; //
   //FLASH->NCR2 = 0xFF; 
   addr+=EEPROM_ADR_INI;
   *((u8*)addr) = ucdata;
   FLASH->IAPSR = (u8)(~0x08);	//lock at last
   return(1); 
} 

/*---------------------------------------------------------------------------*
 |  eeprom_rdchar
 |
 |  read uchar from eeprom
 *---------------------------------------------------------------------------*/
uchar eeprom_rdchar(uint addr)
{
 	addr+=EEPROM_ADR_INI;	 
 	return(*((u8*) addr));
}

/*---------------------------------------------------------------------------*
 |  eeprom_rdpart
 |
 |  read one segment data from eeprom
 *---------------------------------------------------------------------------*/
/*****************************************************************************************/
uchar eeprom_rdpart(void)
{
	uchar i,sum,not_allzero;
	uchar tp;
	sum=0;
	not_allzero=0;
	for(i=0;i<EEPROM_PART_SIZE;i++)
	{
		tp=eeprom_rdchar(eeprom_step*EEPROM_PART_SIZE+i);
	   if(i<EEPROM_PART_SIZE-1)sum+=tp;					//sumcheck of a part 
	   eeprom_buffer[i]=tp;			
	   if(tp>0&&tp<255)not_allzero=1;
	}
	    
	if((sum==tp)&&(not_allzero==1))
	  return(1);
	else
	  return(0);  	    
}
/*****************************************************************************************/
void eeprom_read(void)
{
	// nothing to doing
}
/*****************************************************************************************/
void eeprom_write(void)
{
	//...
}
