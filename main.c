#include <stdio.h>

#define N 4
#define M 3

void findMax(int n, int m, int matrix[M][N], int* result) {
    int max=matrix[0][0];
    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            int current = matrix[i][j];
            if (current > max) {
                max = current;
                result[0]=i;
                result[1]=j;
            }
        }
    }
}

int main() {
    int matrix[M][N];
    int result[2]={0,0};
    for (int i = 0; i < M; i++) {
        for (int j = 0; j < N; j++) {
            scanf("%d", &matrix[i][j]);
        }
    }
    findMax(N,M,matrix,result);
    printf("Max element index is %d %d", result[0],result[1]);
    return 0;
}