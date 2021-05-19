// Comments work as in JS

// #include         // used to include header files (marked by .h ending)
#include <stdio.h>  // Stands for "Standard Input Output", holds info for input/output functions
#include <stdlib.h> // Stands for "Standard Library", holds info for memory allocation/freeing

// the same could be achieved without a header file by initializing printf directly // int printf(const char *text, ...);

int main()
{
    double num1, num2;

    printf("num1: ");
    scanf("%lf", &num1);

    printf("num2: ");
    scanf("%lf", &num2);

    printf("%f", num1 + num2);
}