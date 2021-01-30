#!/bin/sh

mkdir target
mkdir target/test
cd src/test
for t in ./test_*.adb; do
  cp $t ..
done;
cd ..
for t in ./test_*.adb; do
  gnatmake -f -gnata -gnatwa $t;
done;
rm -f *.ali *.o test_*.adb
mv test_* ../target/test
cd ../

