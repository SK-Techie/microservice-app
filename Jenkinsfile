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
                // Find shaded JAR or fallback to regular JAR
                sh '''
                    JAR_FILE=$(ls target/*-shaded.jar 2>/dev/null | head -n 1)
                    if [ -z "$JAR_FILE" ]; then
                        echo "⚠ Shaded JAR not found, using regular JAR"
                        JAR_FILE=$(ls target/*.jar | grep -v original | head -n 1)
                    fi
                    if [ -f "$JAR_FILE" ]; then
                        cp "$JAR_FILE" app.jar
                        echo "✅ JAR copied as app.jar: $JAR_FILE"
                    else
                        echo "❌ No JAR found to copy"
                        ls -l target/
                        exit 1
                    fi
                '''
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
                echo "🔑 Logging into ECR using EC2 IAM Role"
                sh '''
                    aws ecr get-login-password --region $AWS_REGION | \
                    docker login --username AWS --password-stdin $ECR_REPO
                    echo "✅ Logged in to ECR"
                '''
            }
        }

        stage('Push to ECR') {
            steps {
                echo "🚀 Pushing Docker image to ECR"
                sh '''
                    docker tag myapp:latest $ECR_REPO:latest
                    docker push $ECR_REPO:latest
                '''
                echo "✅ Docker image pushed to ECR"
            }
        }
    }
}
