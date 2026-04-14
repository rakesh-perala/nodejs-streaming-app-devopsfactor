# 🚀 Node.js Streaming App – DevOps Project

A complete **DevOps end-to-end project** using Node.js, Docker, Kubernetes (Minikube / AWS EKS), and CI/CD pipeline with Jenkins.

---

# 📌 Project Overview

This project demonstrates how to:

* Build a Node.js application
* Containerize using Docker
* Deploy on Kubernetes (Minikube / EKS)
* Automate CI/CD using Jenkins
* Expose application using Kubernetes Service
* Deploy using Docker Hub images
* Connect custom domain for production access

---

# 🌐 Live Project / Domain

🚀 Production Domain :

👉 [https://devopsfactory.in](https://devopsfactory.in)



---

# 🏗️ Architecture

```
GitHub → Jenkins → Docker Image → Docker Hub → Kubernetes → Service → Domain → Browser
```

For AWS version:

```
GitHub → Jenkins → Docker Hub → AWS EKS → Load Balancer → Route53 Domain → Browser
```

---

# 🛠️ Tech Stack

* Node.js
* Docker
* Kubernetes (Minikube / AWS EKS)
* Jenkins (CI/CD)
* Docker Hub
* AWS (EKS, LoadBalancer, Route53)
* Domain (devopsfactory.in)

---

# 📂 Project Structure

```
nodejs-streaming-app-devopsfactor/
│
├── k8s/
│   ├── deployment.yaml
│   ├── service.yaml
│
├── Dockerfile
├── Jenkinsfile
├── package.json
├── app.js
└── README.md
```

---

# 🚀 Features

✔ Node.js application
✔ Docker containerization
✔ Kubernetes deployment
✔ Load balancing with Service
✔ CI/CD pipeline ready
✔ Cloud deployment support (AWS EKS)
✔ Custom domain integration (devopsfactory.in)

---

# 🐳 Docker Setup

## Build Image

```
docker build -t dockerperala/nodejs-app:latest .
```

## Run Container

```
docker run -p 3000:3000 dockerperala/nodejs-app:latest
```

---

# ☸️ Kubernetes Deployment (Minikube / EKS)

## Apply Deployment

```
kubectl apply -f k8s/deployment.yaml
```

## Apply Service

```
kubectl apply -f k8s/service.yaml
```

## Check Pods

```
kubectl get pods
```

## Check Service

```
kubectl get svc
```

---

# 🌐 Access Application

### Minikube

```
minikube service nodejs-app-service
```

### AWS EKS

```
http://<LoadBalancer-DNS>
```

### Custom Domain (Production)

```
https://devopsfactory.in
```

---

# ⚙️ Jenkins CI/CD Pipeline

Pipeline stages:

1. Git Checkout
2. Install Dependencies
3. Build Application
4. Docker Build
5. Push to Docker Hub
6. Deploy to Kubernetes

---

# 📦 Kubernetes YAML Overview

## Deployment

* Runs Node.js app
* Manages replicas
* Pulls Docker image

## Service

* Exposes application
* NodePort / LoadBalancer
* Handles traffic routing

---

# ☁️ AWS Deployment (Optional)

For production:

* Use AWS EKS cluster
* Use LoadBalancer service type
* Map domain using Route53 / GoDaddy
* Point domain to Load Balancer or ingress controller

---

# 🔥 CI/CD Flow

```
Code Push → Jenkins → Docker Build → Push to Docker Hub → Kubernetes Deploy → Live App → Domain
```

---

# 📊 Commands Cheat Sheet

```
kubectl get pods
kubectl get svc
kubectl apply -f .
kubectl delete -f .
kubectl logs <pod>
kubectl describe pod <pod>
```

---

# 💡 Key Learning

* Docker containerization
* Kubernetes orchestration
* CI/CD automation
* Cloud deployment (AWS)
* Domain mapping & production exposure
* DevOps workflow understanding

---

# 🎯 Author

Rakesh Perala
DevOps Engineer 

---

# 🚀 Status

✔ Project Completed (DevOps Learners)
✔ LIVE: devopsfactory.in
