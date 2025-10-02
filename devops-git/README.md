# Devops-tasks
A collection of dev-ops tasks and hands-on projects

# Node.js CI/CD Pipeline

 # Objective
    This tasks is to automate the build and deployment of a Node.js webapp using GitHub actions and Docker Whenever this code is pushed to GitHub it automatically does the following actions
    1. builds the app.
    2. tests the docker image.
    3. packages it into a docker image.
    4. pushes it to DockerHub
    5. deployed on a Centos server (created this task from a CentOS9 Linux server)

 # Tools Used
    1. GitHub and GitHub Actions - for workflow automation
    2. Node.js - web application
    3. Docker - containerization of app
    4. DockerHub - docker image registry
    5. CentOS 9 server - optional deployment

# Step-by-Step Process
    Install the required tools
    1. sudo dnf update -y
    2. sudo dnf install -y git dnf-plugins-core
    3. sudo dnf module enable -y nodejs:18
    4. sudo dnf install -y nodejs
    5. dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
    6. dnf install -y docker-ce docker-ce-cli containerd.io
    7. systemctl enable --now docker
    8. usermod -aG docker $USER
    9. newgrp docker

 # Create a Node.js App
  create server.js
   
    const express = require("express");
    const app = express();
    const port = 3000;

    app.get("/", (req, res) => res.send("Hello from CI/CD Pipeline!"));
    app.listen(port, () => console.log(`App running on port ${port}`));

 # Initialized project and installed dependencies:
    1. npm init -y
    2. npm install express

 # Create Dockerfile
   dockerfile

    FROM node:18
    WORKDIR /app
    COPY package*.json ./
    RUN npm install
    COPY . .
    EXPOSE 3000
    CMD ["node", "server.js"]

 # Push project to GitHub
    git init
    git add .
    git commit -m "Initial commit"
    git branch -M main
    git remote add origin https://github.com/basith46/devops-tasks.git
    git push -u origin main

 # Setup GitHub Actions Workflow
   Created .github/workflows/main.yml

  yaml

    name: CI/CD Pipeline

    on:
      push:
        branches:
          - main

    jobs:
      build:
        runs-on: ubuntu-latest
        steps:
          - uses: actions/checkout@v3
          - uses: actions/setup-node@v3
            with:
              node-version: 18
          - run: npm install
          - run: echo "No tests yet"

    docker:
      runs-on: ubuntu-latest
      needs: build
      steps:
        - uses: actions/checkout@v3
        - uses: docker/login-action@v2
          with:
            username: ${{ secrets.DOCKERHUB_USERNAME }}
            password: ${{ secrets.DOCKERHUB_TOKEN }}
        - run: docker build -t ${{ secrets.DOCKERHUB_USERNAME }}/node-app:latest .
        - run: docker push ${{ secrets.DOCKERHUB_USERNAME }}/node-app:latest

 # Test the CI/CD Pipeline
    push changes to GitHub
    1. git add .
    2. git commit -m "Add CI/CD workflow"
    3. git push origin main
    * Checked GitHub Actions tab → workflow ran automatically
    * Docker image pushed to DockerHub

 # Deploy on CentOS Server
    Pull and run the Docker image:
    1. docker pull <your-dockerhub-username>/node-app:latest
    2. docker stop node-app || true
    3. docker rm node-app || true
    4. docker run -d --name node-app -p 3000:3000 basith46/node-app:latest
       * Access app in browser: http://<server-ip>:3000
       * Output: Hello from CI/CD Pipeline!

 # Key Learnings
    * How to create a Node.js app
    * How to containerize apps with Docker
    * How to set up CI/CD workflows using GitHub Actions
    * How to push images to DockerHub and optionally deploy them

 # Deliverables
    * GitHub repo with code, Dockerfile, workflow
    * DockerHub Image
    * Deployment on CentOS server

# Summary
  This project demonstrates a beginner-friendly CI/CD pipeline for a Node.js web application using GitHub Actions and Docker. The   workflow automatically builds the app, packages it as a Docker image and pushes it to DockerHub whenever code is pushed to        GitHub. Optionally, the Docker image can be deployed on a CentOS server. The pipeline includes a placeholder for automated        tests, showing how CI/CD can be extended as you add more features.
