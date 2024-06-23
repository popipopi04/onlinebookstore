pipeline {
    agent any
    tools {
        maven 'maven'
        jdk 'jdk11'
    }
    environment {
        AWS_DEFAULT_REGION = 'us-west-2'
        IMAGE_REPO_NAME = 'onlinebookstore'
        DOCKERFILE_PATH = './Dockerfile'  // Example path to Dockerfile
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
                       sh 'chmod 777 *' 
                        sh 'sudo docker build -t rupeshrk004/newrepoonline:$BUILD_NUMBER .'           
                        echo 'Build Image Completed'
                    // def customTag = "${env.BUILD_NUMBER}"
                    // docker.withRegistry('https://' + AWS_DEFAULT_REGION + '.dkr.ecr.' + AWS_DEFAULT_REGION + '.amazonaws.com', 'ecr:your-ecr-credentials') {
                    //     def customImage = docker.build("${AWS_DEFAULT_REGION}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}:${customTag}", "--file ${DOCKERFILE_PATH} .")
                    //     customImage.push()
                    }
                }
            }
        }
        
        stage('Push to DockerHub') {
            steps {
                script {
                    withDockerRegistry(credentialsId: 'rupeshrk004') {
                        sh 'docker build -t rupeshrk004/newrepoonline:$BUILD_NUMBER .'
                        sh 'docker push rupeshrk004/newrepoonline:$BUILD_NUMBER'
                    }
                }
            }
        }
    }
}
