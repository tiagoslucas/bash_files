#!/bin/bash
source=$(cd "$( dirname "$0" )" && pwd)
for i in `ls $source/src | grep \.sh$`;
do
  name=${i%.*}
  shc -f $source/src/$i -o $source/target/$name
  sudo cp $source/target/$name /usr/local/bin/
done
