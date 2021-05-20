#include <stdio.h>  // Stands for "Standard Input Output", holds info for input/output functions
#include <stdlib.h> // Stands for "Standard Library", holds info for memory allocation/freeing

void print_bytes(void *ptr, int size) 
{
    unsigned char *p = ptr;
    int i;
    for (i=0; i<size; i++) {
        printf("%02hhX ", p[i]);
    }
    printf("\n");
}

int main() {
    int x = 255;
    double y = 3.14;
    print_bytes(&x, sizeof(x));
    print_bytes(&y, sizeof(y));

    return 0;
}