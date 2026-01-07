#!/bin/bash
echo "Loading image into Kind..."
kind load docker-image muchtodo-backend:latest --name muchtodo-cluster

echo "Deploying resources..."
kubectl apply -f kubernetes/namespace.yaml
kubectl apply -f kubernetes/mongodb/
kubectl apply -f kubernetes/backend/
kubectl apply -f kubernetes/ingress.yaml

echo "Waiting for pods to be ready..."
kubectl wait --namespace much-to-do-ns \
  --for=condition=ready pod \
  --selector=app=backend \
  --timeout=90s
