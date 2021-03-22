#include <stdio.h>

void add(int *ptr1, int *ptr2, int *val);

int main(int argc, char **argv) {
  FILE *f = fopen(argv[1], "r");
  int a, b, c;
  fscanf(f, "%d %d %d", &a, &b, &c);
  add(&a, &b, &c);
  printf("%d %d\n", a, b);
  fclose(f);

  return 0;
}
