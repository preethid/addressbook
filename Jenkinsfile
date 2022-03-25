pipeline {
   agent none
   tools{
         jdk 'Myjava'
         maven 'mymaven'
   }
   environment{
       BUILD_SERVER_IP='ec2-user@35.154.187.90'
       IMAGE_NAME='devopstrainer/java-mvn-privaterepos:$BUILD_NUMBER'
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
        stage('PACKAGE+BUILD DOCKERIMAGE AND PUSH TO DOKCERHUB') {
            agent any            
            steps {
                script{
                sshagent(['BUILD_SERVER_KEY']) {
                withCredentials([usernamePassword(credentialsId: 'docker-hub', passwordVariable: 'PASSWORD', usernameVariable: 'USERNAME')]) {
                echo "Packaging the apps"
                sh "scp -o StrictHostKeyChecking=no server-script.sh ${BUILD_SERVER_IP}:/home/ec2-user"
                sh "ssh -o StrictHostKeyChecking=no ${BUILD_SERVER_IP} 'bash ~/server-script.sh'"
                sh "ssh ${BUILD_SERVER_IP} sudo docker build -t ${IMAGE_NAME} /home/ec2-user/addressbook"
                sh "ssh ${BUILD_SERVER_IP} sudo docker login -u $USERNAME -p $PASSWORD"
                sh "ssh ${BUILD_SERVER_IP} sudo docker push ${IMAGE_NAME}"
              }
            }
            }
        }
        }
    }
}