#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Declarations of the two functions you will implement
// Feel free to declare any helper functions or global variables
void printPuzzle(char** arr);
void searchPuzzle(char** arr, char* word);
int bSize;

/* Helper: convert char to lowercase without library (A-Z -> a-z) */
static char toLower(char c) {
    if (c >= 'A' && c <= 'Z') return (char)(c + 32);
    return c;
}

/* Helper: get length of word using pointer arithmetic */
static int wordLen(char* word) {
    int len = 0;
    while (*(word + len)) len++;
    return len;
}

/* Merge position into path cell value (digits in descending order, e.g. 642) */
static int mergePosition(int current, int pos) {
    int* digits = (int*)malloc(20 * sizeof(int));
    int nd = 0;
    int v = current;
    while (v) { *(digits + nd) = v % 10; nd++; v /= 10; }
    *(digits + nd) = pos;
    nd++;
    int i, j, t;
    for (i = 0; i < nd; i++)
        for (j = i + 1; j < nd; j++)
            if (*(digits + i) < *(digits + j)) {
                t = *(digits + i);
                *(digits + i) = *(digits + j);
                *(digits + j) = t;
            }
    v = 0;
    for (i = 0; i < nd; i++) v = v * 10 + *(digits + i);
    free(digits);
    return v;
}

/* 8 directions: row and column deltas (initialized on first use) */
static int* dr = NULL;
static int* dc = NULL;
#define NDIR 8

static void initDirections(void) {
    if (dr != NULL) return;
    dr = (int*)malloc(NDIR * sizeof(int));
    dc = (int*)malloc(NDIR * sizeof(int));
    *(dr + 0) = -1; *(dr + 1) = -1; *(dr + 2) = -1; *(dr + 3) = 0;
    *(dr + 4) = 0;  *(dr + 5) = 1;  *(dr + 6) = 1;  *(dr + 7) = 1;
    *(dc + 0) = -1; *(dc + 1) = 0;  *(dc + 2) = 1;  *(dc + 3) = -1;
    *(dc + 4) = 1;  *(dc + 5) = -1; *(dc + 6) = 0;  *(dc + 7) = 1;
}

// Main function, DO NOT MODIFY 	
int main(int argc, char **argv) {
    if (argc != 2) {
        fprintf(stderr, "Usage: %s <puzzle file name>\n", argv[0]);
        return 2;
    }
    int i, j;
    FILE *fptr;

    // Open file for reading puzzle
    fptr = fopen(argv[1], "r");
    if (fptr == NULL) {
        printf("Cannot Open Puzzle File!\n");
        return 0;
    }

    // Read the size of the puzzle block
    fscanf(fptr, "%d\n", &bSize);
    
    // Allocate space for the puzzle block and the word to be searched
    char **block = (char**)malloc(bSize * sizeof(char*));
    char *word = (char*)malloc(20 * sizeof(char));

    // Read puzzle block into 2D arrays
    for(i = 0; i < bSize; i++) {
        *(block + i) = (char*)malloc(bSize * sizeof(char));
        for (j = 0; j < bSize - 1; ++j) {
            fscanf(fptr, "%c ", *(block + i) + j);            
        }
        fscanf(fptr, "%c \n", *(block + i) + j);
    }
    fclose(fptr);

    printf("Enter the word to search: ");
    scanf("%19s", word);
    
    // Print out original puzzle grid
    printf("\nPrinting puzzle before search:\n");
    printPuzzle(block);
    
    // Call searchPuzzle to the word in the puzzle
    searchPuzzle(block, word);
    
     // Free allocated memory
    for (i = 0; i < bSize; i++)
        free(*(block + i));
    free(block);
    free(word);

    return 0;
}

void printPuzzle(char** arr) {
    int i, j;
    for (i = 0; i < bSize; i++) {
        for (j = 0; j < bSize; j++) {
            printf("%c", *(*(arr + i) + j));
            if (j < bSize - 1) printf(" ");
        }
        printf("\n");
    }
}

/* DFS: search for word from (r,c) at character index; record path in pathR, pathC. */
static int dfs(char** arr, char* word, int len, int r, int c, int index,
               int* pathR, int* pathC) {
    if (r < 0 || r >= bSize || c < 0 || c >= bSize) return 0;
    if (toLower(*(*(arr + r) + c)) != toLower(*(word + index))) return 0;

    *(pathR + index) = r;
    *(pathC + index) = c;

    if (index == len - 1) return 1;

    int d;
    for (d = 0; d < NDIR; d++) {
        int nr = r + *(dr + d);
        int nc = c + *(dc + d);
        if (dfs(arr, word, len, nr, nc, index + 1, pathR, pathC)) return 1;
    }
    return 0;
}

void searchPuzzle(char** arr, char* word) {
    initDirections();
    int len = wordLen(word);
    if (len <= 0) {
        printf("Word not found!\n");
        return;
    }

    int i, j;
    int** pathGrid = (int**)malloc((size_t)bSize * sizeof(int*));
    for (i = 0; i < bSize; i++) {
        *(pathGrid + i) = (int*)malloc((size_t)bSize * sizeof(int));
        for (j = 0; j < bSize; j++) *(*(pathGrid + i) + j) = 0;
    }

    int* pathR = (int*)malloc(25 * sizeof(int));
    int* pathC = (int*)malloc(25 * sizeof(int));
    int found = 0;

    /* Bonus: find all paths (each starting at a different cell for the first letter) */
    for (i = 0; i < bSize; i++) {
        for (j = 0; j < bSize; j++) {
            if (dfs(arr, word, len, i, j, 0, pathR, pathC)) {
                found = 1;
                int k;
                for (k = 0; k < len; k++) {
                    int r = *(pathR + k);
                    int c = *(pathC + k);
                    *(*(pathGrid + r) + c) = mergePosition(*(*(pathGrid + r) + c), k + 1);
                }
            }
        }
    }

    if (found) {
        printf("Word found!\n");
        printf("Printing the search path:\n");
        for (i = 0; i < bSize; i++) {
            for (j = 0; j < bSize; j++) {
                printf("%d", *(*(pathGrid + i) + j));
                if (j < bSize - 1) printf(" ");
            }
            printf("\n");
        }
    } else {
        printf("Word not found!\n");
    }

    free(pathR);
    free(pathC);
    for (i = 0; i < bSize; i++) free(*(pathGrid + i));
    free(pathGrid);
}
