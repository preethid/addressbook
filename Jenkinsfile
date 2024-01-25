pipeline {
    agent any

    tools {
        // Install the Maven version configured as "M3" and add it to the path.
        maven "mymaven"
    }

    stages {
        stage('Compile') {
            steps {              
              script{
                     echo "COMPILING"
                     sh "mvn compile"
              }             
            }
            
        }
        stage('Test') {
            steps {           
              script{
                   echo "RUNNING THE TC"
                   sh "mvn test"
                }              
             
            }            
        }
        post{
            always{
                junit 'target/surefire-reports/*.xml'
            }
        }
        stage('Package') {
            steps {              

                script{
                   echo "Creating the package"
                   sh "mvn package"
                }             
             
            }            
        }

    }
}
