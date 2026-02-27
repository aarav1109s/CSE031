#include <stdio.h>
#include <stdlib.h>

int main()
{

    int count = 1;
    int numbers;
    double odd = 0;
    double even = 0;
    int even_count = 0;
    int odd_count = 0;

    printf("Enter the 1st value: ");

    while ((scanf("%d", &numbers)) == 1 && numbers != 0)
    {
        int sum = 0;

        count++;
        if (count % 100 >= 11 && count % 100 <= 13)
            printf("Enter the %dth value: ", count);
        else if (count % 10 == 1)
            printf("Enter the %dst value: ", count);
        else if (count % 10 == 2)
            printf("Enter the %dnd value: ", count);
        else if (count % 10 == 3)
            printf("Enter the %drd value: ", count);
        else
            printf("Enter the %dth value: ", count);
        int temp = abs(numbers);
        while (temp > 0)
        {
            sum += temp % 10;
            temp /= 10;
        }

        if (sum % 2 == 0)
        {
            even += numbers;
            even_count++;
        }
        else
        {
            odd += numbers;
            odd_count++;
        }
    }

    printf("\n");

    if (even_count == 0 && odd_count == 0)
    {
        printf("There is no average to compute.\n");
        return 0;
    }

    if (even_count != 0)
    {
        even /= even_count;
    }
    if (odd_count != 0)
    {
        odd /= odd_count;
    }

    if (even_count > 0)
        printf("Average of input values whose digits sum up to an even number: %.2f\n", even);

    if (odd_count > 0)
        printf("Average of input values whose digits sum up to an odd number: %.2f\n", odd);

    return 0;
}
