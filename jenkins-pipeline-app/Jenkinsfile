pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo 'Building the Docker image...'
                sh 'docker build -t my-app:latest .'
            }
        }
        stage('Test') {
            steps {
                echo 'Running tests (placeholder)...'
                sh 'npm test || true'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying container...'
                sh 'docker rm -f my-app-container || true'
                sh 'docker run -d -p 3001:3000 --name my-app-container my-app:latest'
            }
        }
    }
}
