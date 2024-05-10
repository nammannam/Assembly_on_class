//C
#include <stdio.h>

#define E 1000000007

long long arr[1000][1000];

long long C(int k, int n)
{
    if (k == 0 || k == n)
        return 1;

    if(arr[k][n] != -1)
        return arr[k][n]%E;

    long long C1 = C(k - 1, n - 1);
    long long C2 = C(k, n - 1);

    arr[k][n]= C1+C2;
    return arr[k][n]%E;
}

int main()
{
    int k,n;
    scanf("%d%d", &k, &n);

    int i,j;
    for(i = 0 ; i < 1000; i++){
        for(j = 0 ; j < 1000 ; j++){
            arr[i][j] = -1;
        }
    }

    printf("%lld", C(k,n));

    return 0;


}
