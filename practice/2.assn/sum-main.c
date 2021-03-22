#include <stdio.h>

double sum(double *ptr, int n);

int main(int argc, char **argv) {
  FILE *f = fopen(argv[1], "r");
  int N;
  double arr[20];
  fscanf(f, "%d", &N);

  for (int i = 0; i < N; ++i)
    fscanf(f, "%lf", &arr[i]);
  
  double res = sum(arr, N);
  printf("%lf\n", res);

  return 0;
}
