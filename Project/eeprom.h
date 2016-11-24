#ifndef __EEPROM_H__
#define __EEPROM_H__

uchar eeprom_wrchar(uint addr, uchar ucdata);
uchar eeprom_rdchar(uint addr);
uchar eeprom_rdpart(void);
#endif
