#!/bin/sh
if [ -z $(command -v shc) ];
then
	printf "You have to install shc to make from source!\n"
	exit 1
fi

source=$(cd "$( dirname "$0" )" && pwd)

if [ $# -gt 0 ];
then
	list=$(ls $source/src | grep $1.*\.sh$)
else
	list=$(ls $source/src | grep \.sh$)
fi

for i in $list;
do
  name=${i%.*}
  printf "Building $name\n"
  shc -rf $source/src/$i -o $source/target/$name
done
