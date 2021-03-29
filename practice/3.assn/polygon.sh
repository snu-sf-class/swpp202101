#!/bin/bash

if [[ "$#" -ne 1 ]] ; then
  echo "polygon.sh <LLVM bin dir>"
  echo "ex)  ./polygon.sh ~/my-llvm-releaseassert/bin"
  exit 1
fi

CXX=$1/clang++
CXXFLAGS="-fsanitize=undefined -std=c++17"
set -e

if [[ "$OSTYPE" == "darwin"* ]]; then
ISYSROOT="-isysroot `xcrun --show-sdk-path`"
else
ISYSROOT=
fi

$CXX $ISYSROOT $CXXFLAGS polygon.cpp polygon_main.cpp -o polygon

set +e
SCORE=0
TOTAL=0

for i in {1..9} ; do
echo "Testing data-poly/input${i}.txt.."
./polygon data-poly/input${i}.txt 1>tmp 2>&1
diff tmp ./data-poly/output${i}.txt
if [ "$?" -eq 0 ]; then
SCORE=$((SCORE+10))
fi
TOTAL=$((TOTAL+10))
done

echo "Score: $SCORE / $TOTAL"
