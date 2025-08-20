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
                sh 'cp target/*-shaded.jar .'   // copy JAR to root
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
                withCredentials([usernamePassword(credentialsId: 'aws-ecr-creds',
                                                  usernameVariable: 'AWS_ACCESS_KEY_ID',
                                                  passwordVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                    sh '''
                        aws configure set aws_access_key_id $AWS_ACCESS_KEY_ID
                        aws configure set aws_secret_access_key $AWS_SECRET_ACCESS_KEY
                        aws configure set region $AWS_REGION

                        aws ecr get-login-password --region $AWS_REGION | \
                          docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com
                    '''
                }
            }
        }

        stage('Push to ECR') {
            steps {
                echo "✅ Stage: Push to ECR started"
                sh '''
                    docker tag myapp:latest $ECR_REPO:latest
                    docker push $ECR_REPO:latest
                '''
                echo "✅ Stage: Push to ECR done"
            }
        }
    }
}
