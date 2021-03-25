#!/bin/bash

if [ "$#" -ne 1 ]; then
  echo "Please give the directory where clang resides in"
  echo "ex) ./build-sans.sh ~/my-llvm-releaseassert/bin"
  exit 1
fi

CC=$1/clang
CXX=$1/clang++
set -e

if [[ "$OSTYPE" == "darwin"* ]]; then
  ISYSROOT="-isysroot `xcrun --show-sdk-path`"
else
  ISYSROOT=
fi

$CC $ISYSROOT -fsanitize=undefined ubsan.c -o ubsan
$CC $ISYSROOT -fsanitize=address addrsan.c -o addrsan
$CXX $ISYSROOT -fsanitize=memory memsan.cpp -o memsan -fno-omit-frame-pointer -g -O2 
$CXX $ISYSROOT -D_GLIBCXX_DEBUG containerchk.cpp -o containerchk
