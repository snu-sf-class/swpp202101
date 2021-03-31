### Assignment 3

To submit your code:

```
./package.sh
# Now, upload submit.tar.gz to ETL
```

To score your assignments, TAs will add & run more tests.


#### 1. polygon.cpp

Fix an incorrect algorithm that evaluates the area of a polygon using the undefined
behavior sanitizer.

The area of a polygon can be calculated by accumulating the result of cross
products of two adjacent points.
Let's assume that a polygon consists of vertices (x1, y1), (x2, y2), .., (xn, yn).
For example, (0, 0), (1, 0), (1, 1), (0, 1) will describe a square with lower-left
point located at (0, 0) and upper-right point located at (1, 1).

If the points are placed in counter clockwise order (반시계방향), the area is
equivalent to 0.5 * (cross((x1, y1), (x2, y2)) + cross((x2, y2), (x3, y3)) +
.. + cross((xn, yn), (x1, y1))).
Here, cross((xa, ya), (xb, yb)) is xa * yb - ya * xb.
If the points are in clockwise order, the result is negation of the summation.

For example, consider the square:

- cross((0,0), (1,0)) = 0
- cross((1,0), (1,1)) = 1
- cross((1,1), (0,1)) = 1
- cross((0,1), (0,0)) = 0

So adding all of those & multiplying 0.5 results in 1, which is exactly the area. :)

`polygon.cpp` already has this algorithm implemented, but running it raises signed
overflow in certain inputs. Please fix `polygon.cpp` so

(1) UB Sanitizer does not raise failure

(2) It prints the correct area.

##### Input Conditions

The number of coordinates is not greater than 100.
Each coordinate (x, y) will fit in 32bit signed integer range
(-2147483648 ~ 2147483647).
The calculated area will fit in 64bit unsigned integer range (`uint64_t`).
It is guaranteed that

(1) The polygon is convex

(2) The calculated area has an integral value (the area cannot be, e.g., 0.5)

(3) the points are given in the counter clockwise order.

##### How to check

`polygon.sh` will compile your solution with UB sanitizer enabled and
run the inputs.

```
./polygon.sh <LLVM bin directory(e.g: ~/my-llvm-releaseassert/bin)>
```


#### 2. unreachable.cpp

Update `unreachable.cpp` so it enumerates unreachable blocks from the given IR.
For example,

```
define void @f(i1 %cond) {
entry:
  br i1 %cond, label %bb1, label %bb2
bb1:
  br label %bb2
bb2:
  ret void
bb_unreachable:
  ret void
}
```

The block `bb_unreachable` cannot be executed whatever `%cond` is.
Your pass should print the name of the blocks that are unreachable per each line.
If there are more than one unreachable blocks, please print them in
lexicographical order (사전순).

It is assumed that names of basic blocks are unique and lower-cased.
All branch conditions are given from a function argument (`%cond` in
the above example).
A branch condition cannot be constant such as `true` and `false`.

Some blocks may be logically unreachable but syntactically reachable. For example,

```
entry:
if (flag) {
  if (!flag) {
  BB1: ... // logically speaking, BB1 is unreachable from entry.
  }
}
```

BB1 should not be reported because there (syntactically) exists a path
from the entry to BB1.


##### How to check

```
./unreachable.sh <LLVM bin directory(e.g: ~/my-llvm-releaseassert/bin)>
```

##### Setting VSCode

Setting VSCode to successfully find header files will be very helpful.
You will need to update your includePath
( https://stackoverflow.com/a/48015407 ).
Please add these two paths to the includePath:

```
..(your path)../my-llvm-project/llvm/include
..(your path)../my-llvm-releaseassert/include
```
