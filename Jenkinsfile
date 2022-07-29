pipeline{
    agent none
    tools{
        jdk 'myjava'
        maven 'mymaven'
    }
    environment{
        BUILD_SERVER_IP='ec2-user@65.2.10.194'
        DEPLOY_SERVER_IP='ec2-user@65.2.29.56'
        IMAGE_NAME='devopstrainer/java-mvn-privaterepos:$BUILD_NUMBER'
    }
    stages{
      
        stage("Compile"){
            agent { label 'linux_slave'}
         steps{
                echo "COMPILING THE CODE"
                sh 'mvn compile'
            }
        }
        stage("UnitTest"){
            agent any
          steps{
                echo "Run the TC"
                sh 'mvn test'
            }
          post{
            always{
                junit 'target/surefire-reports/*.xml'
            }
          }
        }
        stage("Containerise the app"){
            agent any
           steps{
             script{
                sshagent(['jenkins-slave']) {
                    withCredentials([usernamePassword(credentialsId: 'docker-hub', passwordVariable: 'PASSWORD', usernameVariable: 'USERNAME')]) {
                 echo "Package the code"
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
    stage("Deploy the app"){
    agent any
   steps{
     script{
        sshagent(['jenkins-slave']) {
        withCredentials([usernamePassword(credentialsId: 'docker-hub', passwordVariable: 'PASSWORD', usernameVariable: 'USERNAME')]) {
            echo "Deploying the app"
            sh "ssh -o StrictHostKeyChecking=no ${DEPLOY_SERVER_IP} sudo yum install docker -y"
            sh "ssh  ${DEPLOY_SERVER_IP} sudo start docker"
            sh "ssh ${DEPLOY_SERVER_IP} sudo docker login -u $USERNAME -p $PASSWORD"
            sh "ssh ${DEPLOY_SERVER_IP} sudo docker run -itd -P ${IMAGE_NAME}"
   }
}
     }
   }
    }
    }
}