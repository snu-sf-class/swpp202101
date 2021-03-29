#!/bin/bash

if [ "$#" -ne 1 ]; then
  echo "unreachable.sh <LLVM bin dir>"
  echo "ex)  ./unreachable.sh ~/my-llvm-releaseassert/bin"
  exit 1
fi

if [[ "$OSTYPE" == "darwin"* ]]; then
  EXT=".dylib"
  ISYSROOT="-isysroot `xcrun --show-sdk-path`"
else
  EXT=".so"
  ISYSROOT=
fi

LLVMCONFIG=$1/llvm-config
CXXFLAGS=`$LLVMCONFIG --cxxflags`
LDFLAGS=`$LLVMCONFIG --ldflags`
LIBS=`$LLVMCONFIG --libs core irreader bitreader support --system-libs`
SRCROOT=`$LLVMCONFIG --src-root`

CXX=$1/clang++
CXXFLAGS="$CXXFLAGS -std=c++17 -I\"${SRCROOT}/include\""
set -e

$CXX $ISYSROOT $CXXFLAGS $LDFLAGS $LIBS unreachable.cpp -o ./libUnreachable$EXT -shared

set +e
SCORE=0
TOTAL=0

for i in {1..7} ; do
echo "Testing data-unreachable/input${i}.ll.."

$1/opt -disable-output \
-load-pass-plugin=./libUnreachable$EXT \
-passes="my-unreachable" data-unreachable/input${i}.ll >tmp 2>&1

diff tmp ./data-unreachable/output${i}.txt
if [ "$?" -eq 0 ]; then
SCORE=$((SCORE+10))
fi
TOTAL=$((TOTAL+10))
done

echo "Score: $SCORE / $TOTAL"
