#!/bin/sh
dependencies="kubectl grep awk"
for dependency in $dependencies;
do
	if [ -z $(command -v $dependency) ];
	then
		printf "You have to install $dependency to use TaiLS!\n"
		exit 1
	fi
done

pod=$(kubectl get po --sort-by=.metadata.creationTimestamp | grep tls-scan-cronjob | awk '{a=$2} END{print $a}')
kubectl exec -i $pod -- tail -f backup/$pod.log
