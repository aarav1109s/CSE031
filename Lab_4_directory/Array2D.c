#include <stdio.h>
#include <stdlib.h>

void printArray(int **, int);

int main()
{
	int i = 0, j = 0, n = 5;
	int **arr = (int **)malloc(n * sizeof(int *));

	/* (3) Allocate each row and initialize to 0 */
	for (i = 0; i < n; i++)
	{
		*(arr + i) = (int *)malloc(n * sizeof(int));
		for (j = 0; j < n; j++)
		{
			*(*(arr + i) + j) = 0;
		}
	}

	/* Print initial array (all zeros) */
	printArray(arr, n);

	/* (6) Make diagonal matrix */
	for (i = 0; i < n; i++)
	{
		*(*(arr + i) + i) = i + 1;
	}

	/* (7) Print diagonal matrix */
	printArray(arr, n);

	/* Free memory */
	for (i = 0; i < n; i++)
	{
		free(*(arr + i));
	}
	free(arr);

	return 0;
}

void printArray(int **array, int size)
{
	int i, j;

	for (i = 0; i < size; i++)
	{
		for (j = 0; j < size; j++)
		{
			printf("%d ", *(*(array + i) + j));
		}
		printf("\n");
	}
	printf("\n");
}