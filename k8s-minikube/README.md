# Kubernetes Minikube
This demo shows how to deploy and manage a simple Nginx app in a **local Kubernetes cluster** using Minikube on CentOS Linux.

## Objective
- Deploy and manage apps in Kubernetes locally.
- Learn basic operations: deployments, services, scaling and logs.

## Tools
- Minikube
- kubectl
- Docker

# Steps

## 1. Start Minikube
    minikube start --driver=docker
    kubectl get nodes
## 2. Deploy the App
    kubectl apply -f deployment.yaml
    kubectl get pods
## 3. Expose the App
    kubectl apply -f service.yaml
    kubectl get svc
## 4. Access the App
    minikube service myapp-service
## 5. Scale the Deployment
    kubectl scale deployment myapp-deployment --replicas=4
    kubectl get pods
## 6. Debugging & Logs
    kubectl describe pod <pod-name>
    kubectl logs <pod-name>

# Summary:
This task demonstrates how to set up a local Kubernetes cluster using Minikube on CentOS Linux. It deploys a simple Nginx application, exposes it via a service, scales the deployment and shows how to check logs and pod status.
