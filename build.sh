#!/bin/sh

mkdir target
cd src/
gnatmake -f -gnata -gnatwa main
mv main ../target/
rm -f *.ali *.o
cd ../

