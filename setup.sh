#!/bin/sh
source=$(cd "$( dirname "$0" )" && pwd)

if [[ $# -gt 0 ]];
then
	list=$(ls $source/target | grep $1)
else
	list=$(ls $source/target)
fi

for i in $list;
do
  name=${i%.*}
  sudo cp $source/target/$name /usr/local/bin/
  printf "$name installed\n"
done
