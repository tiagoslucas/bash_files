#!/bin/bash
if ! command -v kubectl &>/dev/null;
then
	printf 'You have to install kubectl to use TaiLS!\n'
	exit 1
fi

pod=$(kubectl get po --sort-by=.metadata.creationTimestamp | grep tls-scan-cronjob | awk '{a=$2} END{print $a}')
kubectl exec -i $pod -- tail -f backup/$pod.log
