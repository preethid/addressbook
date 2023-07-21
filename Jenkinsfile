pipeline {
    agent none

    tools{
        //jdk 'myjava'
        maven 'mymaven'
    }


    stages {
        stage('Compile') {
            agent any
            steps {
                echo "Compile the code"
                sh 'mvn compile'
            }
        }
         stage('UnitTest') {
            agent any
            steps {
                echo 'Run the test cases'
                sh 'mvn test'
            }
            post{
                always{
                    junit 'target/surefire-reports/*.xml'
                }
            }
        }
        stage('Package') {
            //agent {label 'linux_slave'}
            agent any
            //on slave2
            steps {
                sshagent(['build-server-key']) {
                  
                    echo "Package the code"
                    //sh 'mvn package'
                    sh "scp -o StrictHostKeyChecking=no server-script.sh ec2-user@172.31.33.81:/home/ec2-user"
                    sh "ssh -o StrictHostKeyChecking=no ec2-user@172.31.33.81 bash ~/server-script.sh"
                    //sh "ssh ec2-user@172.31.33.81 sudo docker build -t imagename /home/ec2-user/addressbook"
                }
            }
        }

    }
}
