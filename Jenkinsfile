pipeline {
    agent none

    tools {
        // Install the Maven version configured as "M3" and add it to the path.
        maven "mymaven"
    }

    stages {
        stage('Compile') {
            agent any
            steps {
                script{
                    echo "Compiling the code"
                    sh "mvn compile"
                }
                
            }

            
        }
        stage('UnitTest') {
            agent any
            steps {
                script{
                    echo "Executing the TC"
                    sh "mvn test"
                }
                
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
                script{
                    echo "PAckage the code"
                    sh "mvn package"
                }
                
            }

            
        }
    }
}
