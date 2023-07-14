pipeline {
    agent any

    tools{
        jdk 'myjava'
        maven 'mymaven'
    }


    stages {
        stage('Compile') {
            steps {
                echo "Compile the code"
                sh 'mvn compile'
            }
        }
         stage('UnitTest') {
           
            steps {
                echo 'Run the test cases'
                sh 'mvn test'
            }
        }
        stage('Package') {
            steps {
                echo "Package the code"
                sh 'mvn package'
            }
        }
    }
}
