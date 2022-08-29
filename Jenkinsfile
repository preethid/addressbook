pipeline {
    agent any
    tools{
        jdk 'myjava'
        maven 'mymaven'
        }
    stages {
        stage('COMPILE') {
            steps {
                script{
                echo 'COMPILE THE CODE'
                sh 'mvn compile'
                }
            }
        }
        stage('UNITEST') {
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
           steps {
                script{
                echo "PACKAGE THE CODE"
                sh 'mvn package'
                }
            }
        }
    }
}