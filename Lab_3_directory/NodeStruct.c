
#include <stdio.h>
#include <stdlib.h>
struct Node
{
    int iValue;
    float fValue;
    struct Node *next;
};
int main()
{
    struct Node *head = (struct Node *)malloc(sizeof(struct Node));
    head->iValue = 5;
    head->fValue = 3.14;
    // Insert code here

    printf("head = %p\n", (void *)head);
    printf("&head = %p\n", (void *)&head);

    printf("iValue = %d\n", head->iValue);
    printf("&iValue = %p\n", (void *)&head->iValue);

    printf("fValue = %f\n", head->fValue);
    printf("&fValue = %p\n", (void *)&head->fValue);

    printf("next = %p\n", (void *)head->next);
    printf("&next = %p\n", (void *)&head->next);

    free(head);

    return 0;
}
