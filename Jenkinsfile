pipeline {
    agent any

       stages {
        stage('Compile') {
            steps {
                echo "COMPILING THE CODe"
                // Get some code from a GitHub repository
                //git 'https://github.com/jglick/simple-maven-project-with-tests.git'

                // Run Maven on a Unix agent.
                //sh "mvn -Dmaven.test.failure.ignore=true clean package"//

               }
            
        }
        stage('UnitTest') {
            steps {
                echo "RUNNING UNIT TEST CASES"
                // Run Maven on a Unix agent.
                //sh "mvn -Dmaven.test.failure.ignore=true clean package"
            }
            
        }
        stage('Package') {
            steps {
                echo "PACKAGING THE CODE"
               // Run Maven on a Unix agent.
                //sh "mvn -Dmaven.test.failure.ignore=true clean package"
            }
            
        }
    }
}
