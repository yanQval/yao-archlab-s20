#include "mystdio.h"

int main() {
    int a, b;
    a = _scanf_num();
    b = _scanf_num();
    _printf_num(a+b);
    _printf_char('\n');
    return 0;
}
