#!/bin/bash

yell() { echo "$0: $*" >&2; }

die() {
  yell "$*"
  cat yarn.log
  exit 111
}

try() { "$@" &> yarn.log || die "cannot $*"; }

rm -f yarn.log
try make build

if cat yarn.log | grep "Compiled with warnings"; then
  echo "There are warnings in the code"
  exit 1
fi
