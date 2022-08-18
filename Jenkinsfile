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
            agent any
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
    stage("Deploy ON K8S CLUSTER"){
    agent any
   steps{
     script{     
       
            echo "Deploying the app on k8s EKS cluster"
            sh 'envsubst < java-mvn-app.yml | sudo /usr/local/bin/kubectl apply -f -'
                }
    }
}
    }
}