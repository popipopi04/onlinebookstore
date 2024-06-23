pipeline {
    agent any
    tools {
        maven 'maven'
        jdk 'jdk11'
    }
    environment {
        AWS_DEFAULT_REGION = 'us-west-2'  // Replace with your AWS region
        AWS_ACCOUNT_ID = '752378938230'   // Replace with your AWS account ID
        IMAGE_REPO_NAME = 'onlinebookstore' // Replace with your ECR repository name
        DOCKERFILE_PATH = './Dockerfile'  // Path to your Dockerfile
    }
    
    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/popipopi04/onlinebookstore.git'
            }
        }
        
        stage('Compile') {
            steps {
                sh 'mvn compile'
            }
        }
        
        stage('Build-Docker-image') {
            steps {
                script {
                    def customTag = "${env.BUILD_NUMBER}"
                    def dockerImage = docker.build("${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}:${customTag}", " .")
                    //dockerImage.push()
                }
            }
        }
        
        stage('Push to AWS ECR') {
            steps {
                script {
                    sh 'aws ecr get-login-password --region us-west-2 | docker login --username AWS --password-stdin 752378938230.dkr.ecr.us-west-2.amazonaws.com'
                    // def customTag = "${env.BUILD_NUMBER}"
                    // def dockerImage = docker.image("${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}:${customTag}")
                    
                     // Login to ECR using AWS credentials
                    // docker.withRegistry('', 'ecr:752378938230') {
                    //     dockerImage.push()
                    docker.withRegistry('https://752378938230.dkr.ecr.us-west-2.amazonaws.com', 'ecr:us-west-2:aws-credentials') {
                    app.push("${env.BUILD_NUMBER}")
                    app.push("latest")    
                }
                }
            }
        }
    }
}
