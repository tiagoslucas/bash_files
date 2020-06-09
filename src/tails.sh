#!/bin/bash
pod=$(kubectl get po --sort-by=.metadata.creationTimestamp | grep tls-scan-cronjob | awk '{a=$2} END{print $a}')
kubectl exec -i $pod -- tail backup/$pod.log
