#include <stdio.h>
#include <stdlib.h>

int **matMult(int **a, int **b, int size)
{
	int i, j, k;

	/* Allocate result matrix */
	int **result = (int **)malloc(size * sizeof(int *));
	for (i = 0; i < size; i++)
	{
		*(result + i) = (int *)malloc(size * sizeof(int));
	}

	/* Perform matrix multiplication */
	for (i = 0; i < size; i++)
	{
		for (j = 0; j < size; j++)
		{
			*(*(result + i) + j) = 0;
			for (k = 0; k < size; k++)
			{
				*(*(result + i) + j) +=
					(*(*(a + i) + k)) * (*(*(b + k) + j));
			}
		}
	}

	return result;
}

void printArray(int **arr, int n)
{
	int i, j;

	for (i = 0; i < n; i++)
	{
		for (j = 0; j < n; j++)
		{
			printf("%d ", *(*(arr + i) + j));
		}
		printf("\n");
	}
	printf("\n");
}

int main()
{
	int i, j;
	int n = 3; // You can change this size
	int **matA, **matB, **matC;

	/* Allocate matA */
	matA = (int **)malloc(n * sizeof(int *));
	for (i = 0; i < n; i++)
	{
		*(matA + i) = (int *)malloc(n * sizeof(int));
	}

	/* Allocate matB */
	matB = (int **)malloc(n * sizeof(int *));
	for (i = 0; i < n; i++)
	{
		*(matB + i) = (int *)malloc(n * sizeof(int));
	}

	/* Initialize matrices */
	for (i = 0; i < n; i++)
	{
		for (j = 0; j < n; j++)
		{
			*(*(matA + i) + j) = i + j + 1;
			*(*(matB + i) + j) = (i == j) ? 1 : 0;
		}
	}

	printf("Matrix A:\n");
	printArray(matA, n);

	printf("Matrix B:\n");
	printArray(matB, n);

	matC = matMult(matA, matB, n);

	printf("Matrix C (A * B):\n");
	printArray(matC, n);

	for (i = 0; i < n; i++)
	{
		free(*(matA + i));
		free(*(matB + i));
		free(*(matC + i));
	}
	free(matA);
	free(matB);
	free(matC);

	return 0;
}