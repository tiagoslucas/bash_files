#!/bin/bash
source=$(cd "$( dirname "$0" )" && pwd)

if [[ $# -gt 0 ]];
then
	list=$(ls $source/src | grep $1.*\.sh$)
else
	list=$(ls $source/src | grep \.sh$)
fi

for i in $list;
do
  name=${i%.*}
  printf "Building $name\n"
  shc -f $source/src/$i -o $source/target/$name
  sudo cp $source/target/$name /usr/local/bin/
done
