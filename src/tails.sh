#!/bin/sh
dependencies="kubectl awk"
for dependency in $dependencies;
do
	if [ -z $(command -v $dependency) ];
	then
		printf "You have to install $dependency to use TaiLS!\n"
		exit 1
	fi
done

pod=$(kubectl get po --sort-by=.metadata.creationTimestamp | awk '/tls-scan-cronjob/ {a=$1} END{print a}')
kubectl exec -i $pod -- tail backup/$pod.log $@
