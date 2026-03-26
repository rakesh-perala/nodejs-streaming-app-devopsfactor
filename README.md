# 🚀 DevOpsFactor Streaming App

A full-stack Node.js streaming-style web application built with Express and EJS, containerized using Docker, and deployed on AWS.

This project demonstrates a real-world DevOps and DevSecOps workflow including CI/CD, containerization, security scanning, and Kubernetes deployment using AWS EKS (Fargate).

---

## 📸 Project Overview

- 🎬 Movie streaming UI (Netflix-style)
- 📦 Backend with Node.js & Express
- 🎨 Frontend using EJS templates
- 🐳 Containerized using Docker
- ☁️ Deployed on AWS EC2
- 🚀 Kubernetes deployment using AWS EKS (Fargate)
- 🔐 DevSecOps pipeline with security tools

---

## 🛠️ Tech Stack

- Node.js
- Express.js
- EJS
- Docker
- AWS EC2
- AWS EKS (Fargate)
- Jenkins (CI/CD)
- SonarQube (Code Quality)
- Trivy (Container Security)
- OWASP ZAP (Security Testing)

---

## ⚙️ Project Architecture
Developer → GitHub → Jenkins Pipeline → SonarQube → Docker Build → Trivy Scan → Docker Hub → EKS (Fargate) Deployment
## Project Structure
├── app.js
├── package.json
├── data/
│ └── movies.json
├── public/
│ ├── css/
│ │ └── style.css
│ └── images/
├── views/
│ ├── layout.ejs
│ ├── index.ejs
│ ├── movie.ejs
│ ├── login.ejs
│ └── signup.ejs
# 🚀 DevOpsFactor Streaming App

A full-stack Node.js streaming-style web application built with Express and EJS, containerized using Docker, and deployed on AWS.

This project demonstrates a real-world DevOps and DevSecOps workflow including CI/CD, containerization, security scanning, and Kubernetes deployment using AWS EKS (Fargate).

---

## 📸 Project Overview

- 🎬 Movie streaming UI (Netflix-style)
- 📦 Backend with Node.js & Express
- 🎨 Frontend using EJS templates
- 🐳 Containerized using Docker
- ☁️ Deployed on AWS EC2
- 🚀 Kubernetes deployment using AWS EKS (Fargate)
- 🔐 DevSecOps pipeline with security tools

---

---

## 🚀 Run Locally

```bash
git clone https://github.com/rakesh-perala/nodejs-streaming-app-devopsfactor.git
cd nodejs-streaming-app-devopsfactor
npm install
node app.js


---

## 🚀 Run Locally

Open:

http://localhost:3000
🐳 Docker Setup
Build Image
docker build -t devopsfactor-app .
Run Container
docker run -d -p 3000:3000 devopsfactor-app
☁️ AWS EC2 Deployment
Launch EC2 instance
Install Docker
Clone repository
Build and run container
Access app via public IP
☸️ Kubernetes Deployment (EKS Fargate)
Deployment
kubectl apply -f deployment.yaml
Service
kubectl apply -f service.yaml
🔐 DevSecOps Pipeline
✔ Jenkins for CI/CD automation
✔ SonarQube for code quality analysis
✔ Trivy for container vulnerability scanning
✔ OWASP ZAP for application security testing
🎯 Features
Movie listing with posters
Movie detail pages
Responsive UI
Clean project structure
Cloud deployment ready
📌 Future Enhancements
Add authentication (JWT)
Upload custom videos
CI/CD with GitHub Actions
Domain + HTTPS (SSL)
Monitoring with CloudWatch
👨‍💻 Author

DevOpsFactor (Rakesh)

⭐ Support

If you like this project:

⭐ Star this repo
📢 Share with others
🎥 Watch the YouTube tutorial

