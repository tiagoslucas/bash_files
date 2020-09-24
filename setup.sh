#!/bin/sh
dependencies="dirname pwd ls grep sudo cp"
for dependency in $dependencies;
do
	if [ -z $(command -v $dependency) ];
	then
		printf "You have to install $dependency to install bash_files!\n"
		exit 1
	fi
done

source=$(cd "$( dirname "$0" )" && pwd)
if [ $# -gt 0 ];
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
