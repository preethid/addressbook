pipeline {
    agent none

    tools{
        //jdk 'myjava'
        maven 'mymaven'
    }
    environment{
        IMAGE_NAME='devopstrainer/java-mvn-privaterepos:$BUILD_NUMBER'
        BUILD_SERVER_IP='ec2-user@172.31.33.81'
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
                  withCredentials([usernamePassword(credentialsId: 'docker-hub', passwordVariable: 'PASSWORD', usernameVariable: 'USERNAME')]) {
    
                    echo "Package the code"
                    //sh 'mvn package'
                    sh "scp -o StrictHostKeyChecking=no server-script.sh ${BUILD_SERVER_IP}:/home/ec2-user"
                    sh "ssh -o StrictHostKeyChecking=no ${BUILD_SERVER_IP} bash ~ec2-user/server-script.sh"
                    sh "ssh ${BUILD_SERVER_IP} sudo docker build -t ${IMAGE_NAME} /home/ec2-user/addressbook"
                    sh "ssh ${BUILD_SERVER_IP} sudo docker login -u $USERNAME -p $PASSWORD" 
                    sh "ssh ${BUILD_SERVER_IP} sudo docker push ${IMAGE_NAME}"
                }
                
}
            }
        }
        // stage('Deploy'){
        //     agent any
        //     steps{

        //     }
        // }

    }
}
