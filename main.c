#include <stdio.h>

#define N 4
#define M 3

int findMax(int n, int m, int matrix[M][N]) {
    int result = matrix[0][0];
    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            int current = matrix[i][j];
            if (current > result) result = current;
        }
    }
    return result;
}

int main() {
    int matrix[M][N];
    int result;
    for (int i = 0; i < M; i++) {
        for (int j = 0; j < N; j++) {
            scanf("%d", &matrix[i][j]);
        }
    }
    result = findMax(N, M, matrix);
    printf("Max element is %d", result);
    return 0;
}
