pipeline {
    agent none
    tools{
        jdk 'myjava'
        maven 'mymaven'
    }
     environment{
        IMAGE_NAME='devopstrainer/java-mvn-privaterepos:$BUILD_NUMBER'
        //image is built and pushed to docker hub from dev server
        DEV_SERVER_IP='ec2-user@13.235.238.57'
        ACM_IP='ec2-user@13.235.99.39'
        APP_NAME='java-mvn-app'
        AWS_ACCESS_KEY_ID =credentials("jenkins_aws_access_key_id")
        AWS_SECRET_ACCESS_KEY=credentials("jenkins_aws_secret_access_key")
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
        stage('PACKAGE+BUILD DOCKER IMAGE ON BUILD SERVER'){
            agent any
           steps{
            script{
            sshagent(['ssh-key']) {
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
        stage("Provision anisble target server with TF"){
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
        stage("RUN ansible playbook on ACM"){
            agent any
            steps{
            script{
                echo "copy ansible files on ACM and run the playbook"
               sshagent(['ssh-key']) {
    sh "scp -o StrictHostKeyChecking=no ansible/* ${ACM_IP}:/home/ec2-user"
    //copy the ansible target key on ACM as private key file
    withCredentials([sshUserPrivateKey(credentialsId: 'Ansible_target',keyFileVariable: 'keyfile',usernameVariable: 'user')]){ 
    sh "scp $keyfile ${ACM_IP}:/home/ec2-user/.ssh/id_rsa"    
    }
    //install aws credetials plugin in jenkins --another way
    //withCredentials([aws(accessKeyVariable:'AWS_ACCESS_KEY_ID',credentialsId:'AWS_CONFIGURE',secretKeyVariable:'AWS_SECRET_ACCESS_KEY')]) {
    sh "ssh -o StrictHostKeyChecking=no ${ACM_IP} bash /home/ec2-user/prepare-ACM.sh ${AWS_ACCESS_KEY_ID} ${AWS_SECRET_ACCESS_KEY} ${DOCKER_REG_PASSWORD} ${IMAGE_NAME}"
       //     }
        }
        }
        }    
    }
    }
}