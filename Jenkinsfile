pipeline {
   agent none
   tools{
    jdk "myjava"
   }
    stages {
        stage('Compile') { //prod
        agent any
            steps {
                echo "Compile the code"
                sh "mvn compile"
            }
        }
         stage('UnitTest') { //test
         agent any
            steps {
                echo "Test the code"
                sh "mvn test"
            }
        }
         stage('Package') {//dev
         agent label{'linux_slave'}
            steps {
                echo "Package the code"
                sh "mvn package"
            }
        }
    }
}
