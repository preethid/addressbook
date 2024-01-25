pipeline {
    agent none

    tools {
        // Install the Maven version configured as "M3" and add it to the path.
        maven "mymaven"
    }

    stages {
        stage('Compile') {
            agent {label "linux_slave"}
            steps {              
              script{
                     echo "COMPILING"
                     sh "mvn compile"
              }             
            }
            
        }
        stage('Test') {
            agent any
            steps {           
              script{
                   echo "RUNNING THE TC"
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
            agent any
            steps {              

                script{
                    sshagent(['slave2']) {
                    sh "scp -o StrictHostKeyChecking=no server-script.sh ec2-user@172.31.43.237:/home/ec2-user"
                    sh "ssh -o StrictHostKeyChecking=no ec2-user@172.31.43.237 'bash server-script.sh'"
                   echo "Creating the package"
                   sh "mvn package"
                }             
                }
            }            
        }

    }
}