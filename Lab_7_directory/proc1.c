#include <stdio.h>

/* Equivalent to SUM in proc1.s: adds the two arguments. */
int sum(int m, int n) {
    return m + n;
}

int main(void) {
    int m = 10;
    int n = 5;

    int result = sum(m, n);
    printf("%d\n", result);
    return 0;
}
