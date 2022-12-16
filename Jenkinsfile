pipeline {
    agent none
    tools{
        jdk 'myjava'
        maven 'mymaven'
    }
    environment{
        BUILD_SERVER_IP='ec2-user@13.233.27.159'
        IMAGE_NAME='devopstrainer/java-mvn-privaterepos:$BUILD_NUMBER'
        DEPLOY_SERVER_IP='ec2-user@43.205.126.36'
    }
    stages {
        stage('Compile') {
            //agent {label 'linux_slave'}
            agent any
            steps {
                script{
                    echo "COMPILING THE CODE"
                    sh 'mvn compile'
                }
            }

           }
        stage('UnitTest') {
            agent any
            steps {
                script{
                    echo "RUN THE UNIT TEST CASES"
                    sh 'mvn test'
                }
            }
            post{
                always{
                    junit 'target/surefire-reports/*.xml'
                }
            }

           }
           stage('Package and build the docker image') {
              agent any
            steps {
                script{
                    sshagent(['ssh-key']) {
                        withCredentials([usernamePassword(credentialsId: 'dockerhub', passwordVariable: 'PASSWORD', usernameVariable: 'USERNAME')]) {
                       echo "PACKAGE THE CODE"
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
    //   stage('Deploy the docker image'){
    //   agent any 
    //    steps{
    //     script{
    //         sshagent(['ssh-key']) {
    //          withCredentials([usernamePassword(credentialsId: 'dockerhub', passwordVariable: 'PASSWORD', usernameVariable: 'USERNAME')]) {
    //             sh "ssh  -o StrictHostKeyChecking=no ${DEPLOY_SERVER_IP} sudo yum install docker -y"
    //             sh "ssh   ${DEPLOY_SERVER_IP} sudo systemctl start docker"
    //                 sh "ssh ${DEPLOY_SERVER_IP} sudo docker login -u $USERNAME -p $PASSWORD"
    //                 sh "ssh ${DEPLOY_SERVER_IP} sudo docker run -itd -P ${IMAGE_NAME}"
            

    //     }
    //    }
    //     }
    //    }
    // }
      stage('Deploy on K8s'){
      agent any 
       steps{
        script{
            echo "Run the app on k8s cluster"
            sh 'envsubst < java-mvn-app.yml | kubectl apply -f -'
        }
       }
        }
       }
    }