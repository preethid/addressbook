pipeline {
    agent none
    tools{
        jdk 'myjava'
        maven 'mymaven'
    }
     environment{
        IMAGE_NAME='devopstrainer/java-mvn-privaterepos:$BUILD_NUMBER'
        //image is built and pushed to docker hub from dev server
        DEV_SERVER_IP='ec2-user@3.109.209.70'
        ACM_IP='ec2-user@13.234.76.71'
        APP_NAME='java-mvn-app'
        AWS_ACCESS_KEY_ID =credentials("AWS_ACCESS_KEY_ID")
        AWS_SECRET_ACCESS_KEY=credentials("AWS_SECRET_ACCESS_KEY")
        //created a new credential of type secret text to store docker pwd
        DOCKER_REG_PASSWORD=credentials("DOCKER_REG_PASSWORD")
    }
    stages {
        stage('COMPILE') {
            agent any
            steps {
                script{
                    echo "COMPILING THE CODE"
                    sh 'mvn compile'
                }
                          }
            }
        stage('UNITTEST'){
            agent any
            steps {
                script{
                    echo "RUNNING THE UNIT TEST CASES"
                    sh 'mvn test'
                }
              
            }
            post{
                always{
                    junit 'target/surefire-reports/*.xml'
                }
            }
            }
            stage("Provision deploy target server with TF"){
    agent any
           steps{
               script{
                   dir('terraform'){
                   sh "terraform init"
                   sh "terraform apply --auto-approve"
                   ANSIBLE_TARGET_PUBLIC_IP = sh(
                    script: "terraform output ec2-ip",
                    returnStdout: true
                   ).trim()
                 echo "${ANSIBLE_TARGET_PUBLIC_IP}"   
               }
               }
           }
}
        stage('PACKAGE+BUILD DOCKER IMAGE ON BUILD SERVER'){
            agent any
           steps{
            script{
            sshagent(['ssh-Key']) {
        withCredentials([usernamePassword(credentialsId: 'docker-hub', passwordVariable: 'PASSWORD', usernameVariable: 'USERNAME')]) {
                     echo "PACKAGING THE CODE"
                     sh "scp -o StrictHostKeyChecking=no server-script.sh ${ANSIBLE_TARGET_PUBLIC_IP}:/home/ec2-user"
                     sh "ssh -o StrictHostKeyChecking=no ${ANSIBLE_TARGET_PUBLIC_IP} 'bash ~/server-script.sh'"
                     sh "ssh ${ANSIBLE_TARGET_PUBLIC_IP} sudo docker build -t  ${IMAGE_NAME} /home/ec2-user/addressbook"
                    sh "ssh ${ANSIBLE_TARGET_PUBLIC_IP} sudo docker login -u $USERNAME -p $PASSWORD"
                    sh "ssh ${ANSIBLE_TARGET_PUBLIC_IP} sudo docker push ${IMAGE_NAME}"
                    sh "ssh ${ANSIBLE_TARGET_PUBLIC_IP} sudo docker run -itd -p 8080:8080 ${IMAGE_NAME}"
                    }
                    }
                }
            }
        }
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
   }
}