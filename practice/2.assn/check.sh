#!/bin/bash
if [ "$#" -ne 1 ]; then
  echo "check.sh <clang dir>"
  echo "(ex: check.sh my-llvm-releaseassert/bin/)"
  exit 1
fi

if [[ "$OSTYPE" == "darwin"* ]]; then
  ISYSROOT="-isysroot `xcrun --show-sdk-path`"
else
  ISYSROOT=
fi

CLANGDIR=$1

check() {
  set -e
  problem=$1
  echo "-- $problem --"
  $CLANGDIR/clang $ISYSROOT ${problem}.ll ${problem}-main.c -o ${problem}.out -Wno-override-module

  set +e
  n=0
  if [[ $problem == "add" ]]; then
    n=3
  else
    n=7
  fi

  SCORE=0
  TOTAL=0

  for (( i=1; i<=$n; i++)) ; do
    echo "- input${i}.txt"
    ./${problem}.out data-${problem}/input${i}.txt > tmp.txt
    diff tmp.txt data-${problem}/output${i}.txt
    if [[ "$?" -eq 0 ]]; then
      echo "<OK>"
      SCORE=$((SCORE+10))
    fi
    TOTAL=$((TOTAL+10))
  done

  echo "<<score: ${SCORE}/${TOTAL}>>"
  rm -f tmp.txt
}

check "add"
check "sum"
