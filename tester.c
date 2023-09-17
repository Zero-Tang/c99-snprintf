#include <Windows.h>
#include <strsafe.h>
#include <stdarg.h>
#include "system.h"

HANDLE StdOut;

void rpl_puts(char* str)
{
	SIZE_T len;
	StringCbLengthA(str,STRSAFE_MAX_CCH,&len);
	WriteConsoleA(StdOut,str,(DWORD)len,NULL,NULL);
}

int rpl_snprintf(char* buf,size_t len,const char* fmt,...)
{
	va_list ap;
	int ret;
	va_start(ap,fmt);
	ret=rpl_vsnprintf(buf,len,fmt,ap);
	va_end(ap);
	return ret;
}

int rpl_printf(const char* fmt,...)
{
	char buff[512];
	va_list ap;
	int ret;
	va_start(ap,fmt);
	ret=rpl_vsnprintf(buff,sizeof(buff),fmt,ap);
	va_end(ap);
	rpl_puts(buff);
	return ret;
}

void init()
{
	StdOut=GetStdHandle(STD_OUTPUT_HANDLE);
}

void main()
{
	char buf[512];
	init();
	rpl_printf("sizeof long-long-int: %u\n",sizeof(long long int));
	rpl_snprintf(buf,sizeof(buf),"Here we are: %c, %d, %u\n",'d',0xFFFFFFFF,0x80000000);
	rpl_puts(buf);
	rpl_snprintf(buf,sizeof(buf),"Limited String: Send \"%.4s\" to 0x%p\n","Very Great!",buf);
	rpl_puts(buf);
	rpl_snprintf(buf,sizeof(buf),"Extension of Hexadecimal: 0x%08X, 0x%016X\n",12345,67890);
	rpl_puts(buf);
	rpl_snprintf(buf,sizeof(buf),"64-bit integer: %lld\t%llu\t0x%llX\n",0xfedcba9876543210,0xfedcba9876543210,0xfedcba9876543210);
	rpl_puts(buf);
	rpl_snprintf(buf,sizeof(buf),"NULL pointer: 0x%p\n",NULL);
	rpl_puts(buf);
}