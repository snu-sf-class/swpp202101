#include<stdio.h>

int main() {
  printf("Type two positives to calculate average: ");
  int a, b;
  scanf("%d %d", &a, &b);

  // Safe version:
  //int average = a + (b - a) / 2;
  // Unsafe version:
  int average = (a + b) / 2;
  printf("Average: %d\n", average);

  return 0;
}
