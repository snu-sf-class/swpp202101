#!/bin/bash

if [ "$#" -ne 2 ]; then
  echo "run.sh build <clang dir>"
  echo "run.sh run <clang dir>"
  echo "run.sh test <clang dir>"
  echo "run.sh all <clang dir>"
  echo "ex)  ./run.sh all ~/my-llvm-releaseassert/bin"
  exit 1
fi

if [[ "$OSTYPE" == "darwin"* ]]; then
  EXT=".dylib"
  ISYSROOT="-isysroot `xcrun --show-sdk-path`"
else
  EXT=".so"
  ISYSROOT=
fi

if [[ "$1" != "run" && "$1" != "test" ]]; then
  echo "----- build -----"
  LLVMCONFIG=$2/llvm-config
  CXXFLAGS=`$LLVMCONFIG --cxxflags`
  LDFLAGS=`$LLVMCONFIG --ldflags`
  LIBS=`$LLVMCONFIG --libs core irreader bitreader support --system-libs`
  SRCROOT=`$LLVMCONFIG --src-root`

  CXX=$2/clang++
  CXXFLAGS="$CXXFLAGS -std=c++17 -I\"${SRCROOT}/include\""
  set -e

  $CXX $ISYSROOT $CXXFLAGS $LDFLAGS $LIBS myopt.cpp -o ./libMyOpt$EXT -shared

fi

if [[ "$1" != "build" && "$1" != "test" ]]; then
  echo "----- run -----"
  set +e
  $2/opt -load-pass-plugin=./libMyOpt$EXT \
         -passes="my-opt" input.ll -S -o -
fi

if [[ "$1" != "build" && "$1" != "run" ]]; then
  echo "----- test -----"
  set +e
  for f in test test-fail ; do
    echo "== ${f}.ll =="
    $2/opt -load-pass-plugin=./libMyOpt$EXT \
           -passes="my-opt" ${f}.ll -S -o test.output.ll
    $2/FileCheck ${f}.ll < test.output.ll
  done
fi
