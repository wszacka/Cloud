#!/bin/bash

# install postgres which was prepared before (changes in values.yaml)
helm install mypgsql-postgresql bitnami/postgresql -f postgresql-18.0.15/postgresql/values.yaml --version 18.0.15

# Wait for postgres to be ready
echo "Waiting for PostgreSQL to be ready..."
kubectl wait --for=condition=ready pod -l app.kubernetes.io/name=postgresql --timeout=120s

# Deploy apps
kubectl apply -f k8s/

echo "Waiting for Books deployments to be ready..."
kubectl wait --for=condition=available deployment/spbooks-deployment --timeout=120s
kubectl wait --for=condition=available deployment/spbooksro-deployment --timeout=120s

echo "Checking deployed resources..."
kubectl get pods
kubectl get services
kubectl get deployments

echo "Task 2 deployment completed."