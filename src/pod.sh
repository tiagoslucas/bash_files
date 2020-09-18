#!/bin/sh
dependencies="kubectl grep awk"
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

kubectl exec -it $(kubectl get pods -A | grep $1 | awk 'END{print $2}') "${@:2}" -- /bin/sh
