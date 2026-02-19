#include <stdio.h>

int main()
{
    // 1. Variable declarations
    int x = 0, y = 0, *px, *py; // 4 variables declared, 2 are pointers (px, py)
    int arr[10] = {0};          // initialize array to prevent garbage values

    // 2. Print values (after initialization to avoid garbage)
    printf("Values:\n");
    printf("x = %d\n", x);
    printf("y = %d\n", y);
    printf("arr[0] = %d\n\n", arr[0]);

    // 4. Print addresses of x and y
    printf("Addresses of x and y:\n");
    printf("&x = %p\n", (void *)&x);
    printf("&y = %p\n\n", (void *)&y);

    // 5. Make pointers point to x and y
    px = &x;
    py = &y;

    printf("Pointer values and addresses:\n");
    printf("px (value) = %p\n", (void *)px);
    printf("py (value) = %p\n", (void *)py);
    printf("*px (points to) = %d\n", *px);
    printf("*py (points to) = %d\n", *py);
    printf("&px (address of px) = %p\n", (void *)&px);
    printf("&py (address of py) = %p\n\n", (void *)&py);

    // 6. Print array using pointer arithmetic (no [])
    printf("Array contents using pointer arithmetic:\n");
    for (int i = 0; i < 10; i++)
    {
        printf("%d ", *(arr + i));
    }
    printf("\n\n");

    // 7. Verify arr and &arr[0] are the same
    printf("arr = %p\n", (void *)arr);
    printf("&arr[0] = %p\n\n", (void *)&arr[0]);

    // 8. Print address of whole array
    printf("&arr = %p\n", (void *)&arr);

    return 0;
}
