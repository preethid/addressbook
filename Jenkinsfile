pipeline {
    agent any
    tools{
        jdk 'myjava'
        maven 'mymaven'
    }
    stages {
        stage('Compile') {
            steps {
                script{
                    echo "COMPILING THE CODE"
                    sh 'mvn compile'
                }
            }

           }
        stage('UnitTest') {
            steps {
                script{
                    echo "RUN THE UNIT TEST CASES"
                    sh 'mvn test'
                }
            }

           }
           stage('Package') {
            steps {
                script{
                    echo "PACKAGE THE CODE"
                    sh 'mvn package'
                }       
            }

           }
    }
}
