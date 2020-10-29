#!/bin/bash
kubectl delete -f mysql-service.yaml
sleep 5
kubectl delete -f mysql-replicaset.yaml
sleep 5
kubectl delete -f nfs-volume-claim.yaml
sleep 5
kubectl delete -f nfs-volume.yaml
sleep 5
kubectl apply -f nfs-volume.yaml
sleep 5
kubectl apply -f nfs-volume-claim.yaml
sleep 5
kubectl apply -f mysql-replicaset.yaml
sleep 5
kubectl apply -f mysql-service.yaml
