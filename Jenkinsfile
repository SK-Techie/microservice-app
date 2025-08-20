pipeline {
    agent any

    tools {
        maven 'Maven3.9.5'
    }

    environment {
        AWS_REGION     = 'us-east-1'
        AWS_ACCOUNT_ID = '923965563225'
        ECR_REPO       = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/myapp"
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/SK-Techie/microservice-app.git'
                echo "✅ Stage: Checkout done"
            }
        }

        stage('Build with Maven') {
            steps {
                sh 'mvn clean package -DskipTests'
                // copy only shaded JAR to workspace root so Docker can access it
                sh 'cp target/*-shaded.jar .'
                echo "✅ Stage: Maven build done"
            }
