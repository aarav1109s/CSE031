#include <stdio.h>

int main() {

    int count = 1;
    int numbers;
    int odd = 0;
    int even = 0;
    int even_count = 0;
    int odd_count = 0;


    printf("Enter the 1st value: ");
    
    while ((scanf("%d", &numbers)) == 1 && numbers != 0) {
        int sum = 0;
        if (numbers == 0) {
            break;
        }
        count++;
        if (count == 2) {
            printf("Enter the 2nd value: ");
        }
        else if (count == 3) {
            printf("Enter the 3rd value: ");
        }
        else {
            printf("Enter the %dth value: ", count);
        }
        int temp = numbers;
        while (temp > 0) {
            sum += temp % 10;
            temp /= 10;
        }

        

        if (sum % 2 == 0) {
            even += numbers;
            even_count++;
        }
        else {
            odd += numbers;
            odd_count++;
        }
    }

    even /= even_count;
    odd /= odd_count;

    printf("Average of input values whose digits sum up to an even number: %d\n", even);
    printf("Average of input values whose digits sum up to an odd number: %d\n", odd);
    

    return 0;
}