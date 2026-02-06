#include <stdio.h>


int main()
{
    int count;
    int line;
    int typo;
    printf("Enter the repetition count for the punishment phrase: ");
    while (1)
    {
        if ((scanf("%d", &count) == 1) && count > 0)
        {
            printf("\nEnter the line where you want to insert the typo: ");
            while(1) {
                // Start the next set here
                
                if((scanf("%d", &typo)) == 1 && typo > 0 && typo <= count) {
                    printf("\n");
                    for (int i = 1; i <= count; i++) {
                        if (i == typo) {
                            printf("Cading wiht is C avesone!\n");
                        }
                        else {
                            printf("Coding with C is awesome!\n");
                        }
                    }
                    return 0;
                }
                else {
                    int f;
                    printf("You entered an invalid value for the typo placement! Please re-enter: ");
                    while ((f = getchar()) != '\n' && f != EOF);
                    
                }
            }
        }
        else
        {
            int c;
            printf("You entered an invalid value for the repetition count! Please re-enter: ");
            while ((c = getchar()) != '\n' && c != EOF);
            
        }
    }
}