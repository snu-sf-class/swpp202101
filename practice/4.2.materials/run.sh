#!/bin/bash

if [ "$#" -ne 2 ]; then
  echo "run.sh build <clang dir>"
  echo "run.sh run <clang dir>"
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

if [[ "$1" != "run" ]]; then
  echo "----- build -----"
  LLVMCONFIG=$2/llvm-config
  CXXFLAGS=`$LLVMCONFIG --cxxflags`
  LDFLAGS=`$LLVMCONFIG --ldflags`
  LIBS=`$LLVMCONFIG --libs core irreader bitreader support --system-libs`
  SRCROOT=`$LLVMCONFIG --src-root`

  CXX=$2/clang++
  CXXFLAGS="$CXXFLAGS -std=c++17 -I\"${SRCROOT}/include\""
  set -e

  $CXX $ISYSROOT $CXXFLAGS $LDFLAGS $LIBS fillundef.cpp -o ./libFillUndef$EXT -shared -fPIC -g
  $CXX $ISYSROOT $CXXFLAGS $LDFLAGS $LIBS instmatch.cpp -o ./libInstMatch$EXT -shared -fPIC -g
fi

if [[ "$1" != "build" ]]; then
  set +e
  echo "----- run fillundef with fillundef.ll -----"
  $2/opt -load-pass-plugin=./libFillUndef$EXT \
         -passes="fill-undef" fillundef.ll -S -o -
  echo "----- run instmatch with instmatch.ll -----"
  $2/opt -load-pass-plugin=./libInstMatch$EXT -disable-output \
         -passes="inst-match" instmatch.ll
fi
