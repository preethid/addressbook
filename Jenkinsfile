pipeline {
    agent none

    tools{
        jdk 'myjava'
        maven 'mymaven'
    }


    stages {
        stage('Compile') {
            agent any
            steps {
                echo "Compile the code"
                sh 'mvn compile'
            }
        }
         stage('UnitTest') {
            agent any
            steps {
                echo 'Run the test cases'
                sh 'mvn test'
            }
            post{
                always{
                    junit 'target/surefire-reports/*.xml'
                }
            }
        }
        stage('Package') {
            agent {label 'linux_slave'}
            steps {
                echo "Package the code"
                sh 'mvn package'
            }
        }

    }
}
