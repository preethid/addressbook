pipeline {
   agent none
   tools{
//     jdk "myjava"
        maven "mymaven"
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
        agent any
             when{
            expression{
                BRANCH_NAME == 'b1'
            }
        }
            steps {
                echo "Package the code"
                sh "mvn package"
            }
        }
    }
}
