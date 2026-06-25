#!/bin/bash

set -e

echo "Installing CloudNativePG operator..."
helm repo add cnpg https://cloudnative-pg.github.io/charts
helm repo update
helm install cnpg cnpg/cloudnative-pg

echo "Removing old Bitnami PostgreSQL deployment..."
helm uninstall mypgsql-postgresql

echo "Applying CloudNativePG secret and cluster files..."
kubectl apply -f secret.yaml
kubectl apply -f cluster.yaml

echo "Waiting for CloudNativePG database pods to be ready..."
kubectl wait --for=condition=ready pod -l cnpg.io/cluster=books-pg-cluster --timeout=300s

echo "Deploying updated Books application workloads..."
kubectl apply -f spbooks-deployment.yaml
kubectl apply -f spbooksro-deployment.yaml

echo "Checking deployed resources..."
kubectl get pods
kubectl get services
kubectl get deployments
kubectl get cluster

echo "Task 3 deployment completed."