## Assignment 2

### 1. Add an integer

Please fill `add` function at `add.ll` that does the following operation:

```c
void add(int *ptr1, int *ptr2, int *val) {
  *ptr1 += *val;
  *ptr2 += *val;
}
```

It is guaranteed that `ptr1`, `ptr2`, and `val` point to different addresses.

NOTE: You may want to use https://godbolt.org to see the output of `x86-64 clang (trunk)`
from the C program above.
Do you think your code and the generated code have different behavior? If yes, why?
(you don't need to write a report, just have a thought :)

### 2. Sum of floats

Please fill `sum` function at `sum.ll` that does the following operation:

```c
double sum(double *input, int n) {
  double result = input[0] + ... + input[n-1]
  return result
}
```

It is guaranteed that 0 < `n` <= 20, and the result is non-negative.

NOTE: You'll notice that a naive implementation will make the last two tests
fail! Think why these tests fail, and smartly add the numbers to correctly calculate the
answer. :)

The score printed by `check.sh` will be your score, unless the
implementation contains a hack that simply maps an input to a fixed output.

### How to check

```
./check.sh <clang path (e.g: ~/my-llvm-release/bin/clang)>
```

### How to submit

```
./package.sh
# Now, upload submit.tar.gz to ETL
```

### Note

TAs will run a copy checker; please don't share your homework with other students!

You can use godbolt, but don't rely on it too much. The goal of this homework is to be
familiar with IR.
