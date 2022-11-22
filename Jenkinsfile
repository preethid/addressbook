pipeline {
    agent none
    tools{
        jdk 'myjava'
        maven 'mymaven'
    }
    stages {
        stage('Compile') {
            agent {label 'linux_slave'}
            steps {
                script{
                    echo "COMPILING THE CODE"
                    sh 'mvn compile'
                }
            }

           }
        stage('UnitTest') {
            agent any
            steps {
                script{
                    echo "RUN THE UNIT TEST CASES"
                    sh 'mvn test'
                }
            }
            post{
                always{
                    junit 'target/surefire-reports/*.xml'
                }
            }

           }
           stage('Package') {
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
