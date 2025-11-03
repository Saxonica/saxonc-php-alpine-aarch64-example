#!/bin/sh
set -eux

cd $1
phpize
LD_PRELOAD=/lib/libgcompat.so.0 ./configure --enable-option-checking=fatal --with-saxon
LD_PRELOAD=/lib/libgcompat.so.0 make
LD_PRELOAD=/lib/libgcompat.so.0 make install
