#!/bin/sh
dependencies="kubectl awk"
for dependency in $dependencies;
do
	if [ -z $(command -v $dependency) ];
	then
		printf "You have to install $dependency to use pod!\n"
		exit 1
	fi
done

if [ $# -lt 1 ];
then
	printf "Please provide part of a pod name!\n"
	exit 1
fi

kubectl exec -it $(kubectl get pods -A | awk -v a=$1 '$2 ~ a {b=$2} END{print b}') "${@:2}" -- /bin/sh
