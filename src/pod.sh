#!/bin/sh
if [ -z $(command -v kubectl) ];
then
	printf "You have to install kubectl to use pod!\n"
	exit 1
elif [ $# -lt 1 ];
then
	printf "Please provide part of a pod name!\n"
	exit 1
fi

kubectl exec -it $(kubectl get pods -A | grep $1 | awk '{print $2}') "${@:2}" -- /bin/sh
