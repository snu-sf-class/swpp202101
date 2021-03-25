#include <stdio.h>
#include <stdlib.h>

int main() {
  char *p = (char*)malloc(4);
  free(p);
  free(p); // double free
  return 0;
}
