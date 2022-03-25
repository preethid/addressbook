pipeline {
   agent none
   tools{
         jdk 'Myjava'
         maven 'mymaven'
   }
   environment{
       BUILD_SERVER_IP='ec2-user@172.31.43.56'
   }
    stages {
        stage('Compile') {
           agent any
            steps {
              script{
                  echo "BUILDING THE CODE"
                  sh 'mvn compile'
              }
            }
            }
            stage('UnitTest') {
              agent {label 'linux_slave'}
            steps {
              script{
                  sshagent(['TEST_SERVER']) {
                   echo "TESTING THE CODE"
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
             sshagent(['BUILD_SERVER']) {
            steps {
              script{
                  echo "Packaging the apps"
                   sh "scp -o StrictHostKeyChecking=no server-script.sh ${BUILD_SERVER_IP}:/home/ec2-user"
                sh "ssh -o StrictHostKeyChecking=no ${BUILD_SERVER_IP} 'bash ~/server-script.sh'"
              }
            }
            }
        }
    
}