#include <stdio.h>
#include "../include/mystrfunctions.h"
#include "../include/myfilefunctions.h"

int main() {
    printf("--- Testing String Functions ---\n");
    char str1[50] = "Hello";
    printf("Length of '%s': %d\n", str1, mystrlen(str1));
    mystrcat(str1, " World");
    printf("Concatenated: %s\n", str1);

    printf("\n--- Testing File Functions ---\n");
    FILE* fp = fopen("README.md", "r");
    if (fp) {
        int l, w, c;
        if (wordCount(fp, &l, &w, &c) == 0) {
            printf("README.md -> Lines: %d, Words: %d, Chars: %d\n", l, w, c);
        }
        fclose(fp);
    }
    return 0;
}
