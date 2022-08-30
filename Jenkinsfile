pipeline {
    agent none
    tools{
        jdk 'myjava'
        maven 'mymaven'
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
                echo "PACKAGE THE CODE"
                sh 'mvn package'
                }
            }
        }
    }
}