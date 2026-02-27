
#include <stdio.h>
#include <stdlib.h>
int main()
{
    int num;
    int *ptr;
    int **handle;
    num = 14;
    ptr = (int *)malloc(2 * sizeof(int));
    *ptr = num;
    handle = (int **)malloc(1 * sizeof(int *));
    *handle = ptr;
    // Insert code here
    printf("num = %d\n", num);
    printf("&num = %p\n", (void *)&num);

    printf("ptr = %p\n", (void *)ptr);
    printf("&ptr = %p\n", (void *)&ptr);
    printf("*ptr = %d\n", *ptr);

    printf("handle = %p\n", (void *)handle);
    printf("&handle = %p\n", (void *)&handle);
    printf("*handle = %p\n", (void *)*handle);
    printf("**handle = %d\n", **handle);

    free(ptr);
    free(handle);

    return 0;
}
