#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int size;
int evenCount = 0, oddCount = 0;

int *arr;
int *arr_even;
int *arr_odd;

char *str1 = "Original array's contents: ";
char *str2 = "Contents of new array containing even elements from original: ";
char *str3 = "Contents of new array containing odd elements from original: ";

void printArr(int *a, int size, char *prompt)
{
    int i;

    printf("%s", prompt);

    if (size == 0)
    {
        printf("empty");
    }
    else
    {
        for (i = 0; i < size; i++)
        {
            printf("%d", *(a + i));
            if (i < size - 1)
                printf(" ");
        }
    }
    printf("\n");
}

void arrCopy()
{
    int i;
    int eIndex = 0, oIndex = 0;

    for (i = 0; i < size; i++)
    {
        if (*(arr + i) % 2 == 0)
        {
            *(arr_even + eIndex) = *(arr + i);
            eIndex++;
        }
        else
        {
            *(arr_odd + oIndex) = *(arr + i);
            oIndex++;
        }
    }
}

int main()
{
    int i;

    printf("Enter the size of array you wish to create: ");
    scanf("%d", &size);

    // Dynamically allocate memory for arr
    if (size > 0)
        arr = (int *)malloc(size * sizeof(int));
    else
        arr = NULL;

    // Ask user to input content and compute evenCount and oddCount
    for (i = 0; i < size; i++)
    {
        printf("Enter array element #%d: ", i + 1);
        scanf("%d", (arr + i));

        if (*(arr + i) % 2 == 0)
            evenCount++;
        else
            oddCount++;
    }

    // Dynamically allocate memory for arr_even and arr_odd
    if (evenCount > 0)
        arr_even = (int *)malloc(evenCount * sizeof(int));
    else
        arr_even = NULL;

    if (oddCount > 0)
        arr_odd = (int *)malloc(oddCount * sizeof(int));
    else
        arr_odd = NULL;

    printf("/n");
    /*************** YOU MUST NOT MAKE CHANGES BEYOND THIS LINE! ***********/

    printArr(arr, size, str1);

    arrCopy();

    printArr(arr_even, evenCount, str2);

    printArr(arr_odd, oddCount, str3);

    printf("\n");

    return 0;
}
