#!/bin/bash
kubectl exec -it $(kubectl get pods -A | grep $1 | awk '{print $2}') "${@:2}" -- /bin/sh
