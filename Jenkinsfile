pipeline {
   agent any
   tools{
    jdk "myjava"
   }
    stages {
        stage('Compile') { //prod
            steps {
                echo "Compile the code"
                sh "mvn compile"
            }
        }
         stage('UnitTest') { //test
            steps {
                echo "Test the code"
                sh "mvn test"
            }
        }
         stage('Package') {//dev
            steps {
                echo "Package the code"
                sh "mvn package"
            }
        }
    }
}
