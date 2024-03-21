pipeline {
    agent none

    tools {
        // Install the Maven version configured as "M3" and add it to the path.
        maven "mymaven"
    }

    environment{
        BUILD_SERVER='ec2-user@172.31.0.234'
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
        stage('UnitTest') { // running on slave1
            //agent {label 'linux_slave'}
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
        stage('Package') { // running on slave2 via ssh-agent
            agent any
            steps {
                script{
                    sshagent(['slave2']) {
                    echo "Executing the code"
                    sh "scp  -o StrictHostKeyChecking=no server-config.sh ${BUILD_SERVER}:/home/ec2-user"
                    sh "ssh -o StrictHostKeyChecking=no ${BUILD_SERVER} 'bash server-config.sh'"
                }
                }
                
            }

            
        }
    }
}
