#ifndef __MYSTDIO_H__
#define __MYSTDIO_H__

#include<stdarg.h>
void _printf_num(int num) {
  __asm__ __volatile__ ("li $v0, 1 \n\t"
                        "add $a0, %0, $zero \n\t"
                        "syscall \n\t"
                        : /* no output*/
                        : "r" (num)
                        : "v0"
                        /*: error*/);
}

int _scanf_num() {
  int res;
  __asm__ __volatile__ ("li $v0, 5 \n\t"
                        "syscall \n\t"
                        "add %0, $v0, $zero \n\t"
                        : "=r" (res)
                        : /* no input*/
                        : "v0"
                        /*: error*/);
  return res;
}

void _printf_char(const char ch) {
  __asm__ __volatile__ ("li $v0, 11 \n\t"
                        "add $a0, %0, $zero \n\t"
                        "syscall \n\t"
                        : /* no output*/
                        : "r" (ch)
                        : "v0"
                        /*: error*/);
}

#endif
