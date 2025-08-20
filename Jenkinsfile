pipeline {
    agent any

    tools {
        maven 'Maven3.9.5'   // 👈 this name must match the Maven installation name in Jenkins
    }

    environment {
        AWS_REGION     = 'us-east-1'
        AWS_ACCOUNT_ID = '923965563225'
        ECR_REPO       = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/myapp"
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/malir001/microservice-app.git'
                echo "✅ Stage: Checkout done"
            }
        }

        stage('Build with Maven') {
            steps {
                sh 'mvn clean package -DskipTests'
                echo "✅ Stage: Maven build done"
            }
        }

        stage('Docker Build') {
            steps {
                sh 'docker build -t myapp .'
                echo "✅ Stage: Docker build done"
            }
        }

        stage('Login to ECR') {
            steps {
                wi
