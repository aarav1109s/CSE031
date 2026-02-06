#include <stdio.h>

// int main(void)
// {
//     int x;
//     int number;

//     printf("Enter the repetition count for the punishment phrase: ");

//     x = scanf("%d", number);

//     if (scanf("%d", number) == 1 && number > 0) {

//     }
//     else {
//         int c;
//         c == getchar
//     }

//     return 0;
// }
int main()
{
    int count;
    int line;
    int typo;
    printf("Enter the repition count for the punishment phrase: ");
    while (1)
    {
        if ((scanf("%d", &count) == 1) && count > 0)
        {
            // Start the next set here
            printf("Enter the line where you want to insert the typo: ");
            scanf("%d", typo);
        }
        else
        {
            int c;
            while ((c = getchar()) != '\n' && c != EOF)
            {
                // gets the next char in buffer and it removes it
                printf("You entered an invalid value for the repetition count! Please re-enter: ");
            }
        }
    }
}