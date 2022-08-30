pipeline {
    agent none
    tools{
        jdk 'myjava'
        maven 'mymaven'
        }
    environment{
        BUILD_SERVER_IP='ec2-user@13.232.33.59'
    }
    stages {
        stage('COMPILE') {
            agent {label 'linux_slave'}
            steps {
                script{
                echo 'COMPILE THE CODE'
                sh 'mvn compile'
                }
            }
        }
        stage('UNITEST') {
            agent any
            steps {
                script{
                echo 'RUN THE UNIT TC'
                sh 'mvn test'
                }
            }
            post{
                always{
                    junit 'target/surefire-reports/*.xml'
                }
            }
        }
        stage('PACKAGE') {
            agent any
           steps {
                script{
                sshagent(['ssh-key']) {
                echo "PACKAGE THE CODE"
                sh "scp -o StrictHostKeyChecking=no server-script.sh ${BUILD_SERVER_IP}:/home/ec2-user"
                sh "ssh -o StrictHostKeyChecking=no ${BUILD_SERVER_IP} 'bash ~/server-script.sh'"
                  }
                }
            }
        }
    }
}