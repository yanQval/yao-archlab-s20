#define MAXN 500
#define MAXM 500

#define WINDOW_N 3 
#define WINDOW_M 3
#define WINDOW_SIZE ( WINDOW_N * WINDOW_M )

unsigned int n = 0,m = 0;

typedef unsigned short pixel;

pixel img[MAXN][MAXM] = {};

// TODO: complete kernel matrix
char kernelSmooth[WINDOW_N][WINDOW_M] = {};

#include "my_stdio_simple.h"

void ImageProcess() {
    // Image border (first and last row, column) is not considered.
	// TODO
}

void ImageOutput() {
    _printf_num(n);
    _printf_char(' ');
    _printf_num(m);
    _printf_char('\n');
    int i, j;
    for (i = 0; i < n; i++) {
        for (j = 0; j < m; j++) {
            _printf_num(img[i][j]);
            _printf_char(' ');
        }
        _printf_char('\n');
    }
}

int main() {
    n = _scanf_num();
    m = _scanf_num();

    ImageProcess();

    ImageOutput();

    return 0;
}

