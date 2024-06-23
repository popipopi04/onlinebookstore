pipeline {
    agent any
    tools {
        maven 'maven'
        jdk 'jdk11'
        }
        // environment {
        //     SCANNER_HOME= tool 'sonar-scanner'
        // }
    stages {
        stage('Checkout ') {
            steps {
               git 'https://github.com/Rupeshkr004/onlinebookstore.git'
            }
        }
        //   stage('SonarQube Analysis') {
        //     steps {
                
        //         withSonarQubeEnv('sonar') {
        //             sh ''' $SCANNER_HOME/bin/sonar-scanner -Dsonar.projectKey=onlineBook -Dsonar.projectName=onlineBook \
        //             -Dsonar.java.binaries=. '''
        //         }
        //     }
        // }
        // //         node {
        //   stage('SCM') {
        //     checkout scm
        //   }
        //   stage('SonarQube Analysis') {
        //     def mvn = tool 'Default Maven';
        //     withSonarQubeEnv() {
        //       sh "${mvn}/bin/mvn sonar:sonar"
        //     }
        //   }
        // }
        stage('compile'){
            steps{
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
        // stage('Build-Docker-image') {
        //     steps {
        //         script {
        //             sh 'chmod 777 *' 
        //                 sh 'sudo docker build -t rupeshrk004/newrepoonline:$BUILD_NUMBER .'           
        //              echo 'Build Image Completed'  
        //             }
        //     }
        // }
        stage('Push to DockerHub'){
            steps{
                script{
                   
                   withDockerRegistry(credentialsId: 'rupeshrk004') {
                    // some block
                      sh 'docker build -t rupeshrk004/newrepoonline:$BUILD_NUMBER .'
                      sh 'docker push rupeshrk004/newrepoonline:$BUILD_NUMBER'
        }           
                
                    
                }
            }
        }
    }
}
