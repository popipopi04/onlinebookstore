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
        REPOSITORY_URI = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}"
        // SSH_CREDENTIALS_ID = 'minikube-ssh-key' // ID of the SSH key credential
        // MINIKUBE_SERVER = credentials('minikube-server-ip')
        DEPLOYMENT_FILE = 'Kubernetes/web-app/wbapp-onlinebookstore-deployment.yml'
    }
    
    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/popipopi04/onlinebookstore.git'
                // echo 'pushing kubernetes manifest files to minikuber server'
                //     sh ' scp -i /home/ubuntu/minikube-key/sshkey.pem /var/lib/jenkins/workspace/onlinebookstore/Kubernetes/* ubuntu@172.31.28.39:/Kubernetes-manifest/'                 
                //     echo 'pushed manfest files sucessfully'
            }
        }
        
        stage('Compile') {
            steps {
                sh 'pwd'
                sh 'mvn compile'
            }
        }
        stage('Unit Tests') {
            steps {
                sh "mvn test -DskipTests=true"
            }
        }
        stage('Build'){
            steps{
                sh 'mvn package -DskipTests=true'
            }
        }
        
        stage('Build-Docker-image') {
            steps {
                script {
                    // def customTag = "${env.BUILD_NUMBER}"
                    // def dockerImage = docker.build("${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}:${customTag}", " .")
                    //dockerImage.push()
                    dockerImage = docker.build "${IMAGE_REPO_NAME}:${env.BUILD_NUMBER}"
                    
                }
            }
        }
         stage('Logging into AWS ECR') {
            steps {
                script {
                sh "aws ecr get-login-password --region us-west-2 | docker login --username AWS --password-stdin 752378938230.dkr.ecr.us-west-2.amazonaws.com"
                }
                 
            }
        }
        
        stage('Push to AWS ECR') {
            steps {
                script {
                     sh "docker tag ${IMAGE_REPO_NAME}:${env.BUILD_NUMBER} ${REPOSITORY_URI}:$env.BUILD_NUMBER"
                     sh "docker push ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}:${env.BUILD_NUMBER}"
                    // sh 'aws ecr get-login-password --region us-west-2 | docker login --username AWS --password-stdin 752378938230.dkr.ecr.us-west-2.amazonaws.com'
                    // docker.withRegistry('https://${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com', 'ecr:aws-credentials') {
                    //     def customTag = "${env.BUILD_NUMBER}"
                    //     def dockerImage = docker.image("${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}:${customTag}")
                    //     dockerImage.push()
                }
                }
            }
        stage('Update Deployment File') {
            steps {
                script {
                            def buildNumber = env.BUILD_NUMBER
                            sh """
                             sed -i 's|\\(image: $REPOSITORY_URI:\\)[0-9]\\+|\\1$buildNumber|g' $DEPLOYMENT_FILE
                            """
                        }
                    }
                    
                        }
                }
        }
