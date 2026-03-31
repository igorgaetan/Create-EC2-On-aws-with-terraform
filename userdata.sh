#!/bin/bash
curl -sfL https://get.k3s.io | sh -
export KUBECONFIG=/etc/rancher/k3s/k3s.yaml

# Attente du démarrage de K3s
sleep 30

# Déploiement Nginx Hello World
kubectl create deployment hello-nginx --image=nginxdemos/hello
kubectl expose deployment hello-nginx --type=LoadBalancer --port=80