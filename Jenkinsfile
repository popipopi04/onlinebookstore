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
        
        stage('Unit Tests') {
            steps {
                sh 'mvn test -DskipTests=true'
            }
        }
        
        stage('Build') {
            steps {
                sh 'mvn package -DskipTests=true'
            }
        }
        
        stage('Build-Docker-image') {
            steps {
                script {
                        sh 'sudo -i'
                        sh 'chmod 777 *' 
                       //  sh 'sudo docker build -t rupeshrk004/newrepoonline:$BUILD_NUMBER .'           
                     def customTag = "${env.BUILD_NUMBER}"
                    def dockerImage = docker.build("${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}:${customTag}", "--file ${DOCKERFILE_PATH} .")
                    dockerImage.push()
                }
            }
        }
        
        stage('Push to AWS ECR') {
            steps {
                script {
                    docker.withRegistry('https://${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com', 'ecr:752378938230') {
                        def customTag = "${env.BUILD_NUMBER}"
                        def dockerImage = docker.image("${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}:${customTag}")
                        dockerImage.push()
                    }
                }
            }
        }
        }
    }
