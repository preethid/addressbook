pipeline {
    agent any

   stages {
        stage('Compile') {
            steps {
                script{
                    echo "COMPILING THE CODE"
                }
            }

           }
        stage('UnitTest') {
            steps {
                script{
                    echo "RUN THE UNIT TEST CASES"
                }
            }

           }
           stage('Package') {
            steps {
                script{
                    echo "PACKAGE THE CODE"
                }
            }

           }
    }
}
