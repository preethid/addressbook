pipeline {
    agent none
    tools{
        jdk 'myjava'
        maven 'mymaven'
    }
     environment{
        IMAGE_NAME='devopstrainer/java-mvn-privaterepos:$BUILD_NUMBER'
        DEV_SERVER_IP='ec2-user@3.111.198.154'
        APP_NAME='java-mvn-app'
    }
    stages {
        stage('COMPILE') {
            agent any
            steps {
                script{
                    echo "COMPILING THE CODE"
                    git 'https://github.com/preethid/addressbook.git'
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
        stage('PACKAGE+BUILD DOCKER IMAGE ON BUILD SERVER'){
            agent any
           steps{
            script{
            sshagent(['Test_server-Key']) {
        withCredentials([usernamePassword(credentialsId: 'docker-hub', passwordVariable: 'PASSWORD', usernameVariable: 'USERNAME')]) {
                     echo "PACKAGING THE CODE"
                     sh "scp -o StrictHostKeyChecking=no server-script.sh ${DEV_SERVER_IP}:/home/ec2-user"
                     sh "ssh -o StrictHostKeyChecking=no ${DEV_SERVER_IP} 'bash ~/server-script.sh'"
                     sh "ssh ${DEV_SERVER_IP} sudo docker build -t  ${IMAGE_NAME} /home/ec2-user/addressbook"
                    sh "ssh ${DEV_SERVER_IP} sudo docker login -u $USERNAME -p $PASSWORD"
                    sh "ssh ${DEV_SERVER_IP} sudo docker push ${IMAGE_NAME}"
                    }
                    }
                }
            }
        }
        stage("Provision deploy server with TF"){
            environment{
                  AWS_ACCESS_KEY_ID =credentials("AWS_ACCESS_KEY_ID")
            AWS_SECRET_ACCESS_KEY=credentials("AWS_SECRET_ACCESS_KEY")
            }
             agent any
                   steps{
                       script{
                           dir('terraform'){
                           sh "terraform init"
                           sh "terraform apply --auto-approve"
                           EC2_PUBLIC_IP = sh(
                            script: "terraform output ec2-ip",
                            returnStdout: true
                           ).trim()
                       }
                       }
                   }
        }
        stage('DEPLOY ON EC2 instance'){
            agent any
                steps{
                    script{
            echo "RUN THE APP ON ec2 instance"
               echo "Waiting for ec2 instance to initialise"
               sleep(time: 90, unit: "SECONDS")
               echo "Deploying the app to ec2-instance provisioned bt TF"
               echo "${EC2_PUBLIC_IP}"
               sshagent(['Test_server-Key']) {
                withCredentials([usernamePassword(credentialsId: 'docker-hub', passwordVariable: 'PASSWORD', usernameVariable: 'USERNAME')]) {
                      sh "ssh ${EC2_PUBLIC_IP} sudo docker login -u $USERNAME -p $PASSWORD"
                      sh "ssh ${EC2_PUBLIC_IP} sudo docker run -itd -p 8001:8080 ${IMAGE_NAME}"
                      
                }
            }
            }
                }}    
    }
}