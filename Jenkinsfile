pipeline {
    agent any

    tools {
        maven 'MAVEN3'
    }

    environment {
        DOCKER_IMAGE = "kalla201/employee-app"
    }

    stages {

        stage('Checkout Code') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/kalladavid/Automated-CI-CD-Pipeline-for-Java-Spring-Boot-Application-using-Jenkins-Docker.git'
            }
        }

        stage('Build with Maven') {
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $DOCKER_IMAGE:latest .'
            }
        }

        stage('Push Image to Docker Hub') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-creds',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh '''
                      echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                      docker push $DOCKER_IMAGE:latest
                    '''
                }
            }
        }

        stage('Deploy Container') {
            steps {
                sh '''
                  docker rm -f employee-app || true
                  docker run -d -p 8080:8080 --name employee-app $DOCKER_IMAGE:latest
                '''
            }
        }
    }
}
