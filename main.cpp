#include <stdio.h>
#define n1 10
#define n2 5
int main() {

	int sum[n1 + n2 - 1] = { 0,0,0,0,0,0,0,0,0,0,0,0,0 };
	int a[n1] = { 4,5,8,9,14,15,16,22,8,1 };
	int b[n2] = { 8,10,11,14,10 };
	for (int i = 0; i < (n1 + n2 - 1); i++)
		for (int j = 0; j < n1; j++)
			for (int k = 0; k < n2; k++)
			{
				if ((k + j) == i) {
					sum[i] += a[j] * b[k];
				}
			}
	for (int i = 0; i < (n1 + n2 - 1); i++)
	{
		printf("%d", sum[i]);
		printf(" ");
	};
	return 0;
}
