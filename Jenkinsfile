pipeline {
    agent none
    tools{
        maven 'mymaven'
    }

    parameters{
        string(name:'Env',defaultValue:'Test',description:'version to deploy')
        booleanParam(name:'executeTests',defaultValue: true,description:'decide to run tc')
        choice(name:'APPVERSION',choices:['1.1','1.2','1.3'])

    }
    environment{
        BUILD_SERVER='ec2-user@172.31.40.239'
        //DEPLOY_SERVER='ec2-user@172.31.37.123'
        IMAGE_NAME='devopstrainer/java-mvn-privaterepos:$BUILD_NUMBER'
       AWS_ACCESS_KEY_ID=credentials('ACCESS_KEY')
       AWS_SECRET_ACCESS_KEY=credentials('SECRET_ACCESS_KEY')
        DOCKER_REG_PASSWORD=credentials("DOCKER_REG_PASSWORD")
       ACM_IP='ec2-user@172.31.35.218'
    }

    stages {
        stage('Compile') {
            //agent { label 'linux_slave' }
            agent any
            steps {
                echo "Compiling Hello World in ${params.Env}"
                sh 'mvn compile'
            }
        }
        stage('UnitTest') {
            agent any
             when {
                expression{
                    params.executeTests == true
                }
             }
            steps {
                echo 'Testing Hello World'
                sh 'mvn test'
            }
            post{
                always{
                    junit 'target/surefire-reports/*.xml'
                }
            }
        }
        //  stage('Package') {
        //     input{
        //         message "Select the version to package"
        //         ok "Version selected"
        //         parameters{
        //             choice(name:'NEWAPP',choices:['1.1','1.2','1.3'])
        //         }
        //     }
        //     agent any
        //     steps {
        //         sshagent(['slave2']) {
        //              echo "Packaging Hello World app verisob ${params.APPVERSION}"
        //              sh "scp -o StrictHostKeyChecking=no server-config.sh ${BUILD_SERVER}:/home/ec2-user"
        //              sh "ssh -o StrictHostKeyChecking=no ${BUILD_SERVER} 'bash server-config.sh'"
        //         }
        //     }
        // }
         stage('Containerising the build phase') {
            agent any
            steps {
                sshagent(['slave2']) {
                    withCredentials([usernamePassword(credentialsId: 'docker-hub', passwordVariable: 'password', usernameVariable: 'username')]) {
                     echo "Containerising Hello World app verison ${params.APPVERSION}"
                     sh "scp -o StrictHostKeyChecking=no server-config.sh ${BUILD_SERVER}:/home/ec2-user"
                     sh "ssh -o StrictHostKeyChecking=no ${BUILD_SERVER} bash server-config.sh ${IMAGE_NAME}"
                     sh "ssh ${BUILD_SERVER} sudo docker login -u ${username} -p ${password}"
                     sh "ssh ${BUILD_SERVER} sudo docker push ${IMAGE_NAME}"
                }
            }
            }
        }
        stage("Provision deploy server with TF"){
            // environment{
            //      ACCESS_KEY=credentials('ACCESS_KEY')
            //      SECRET_ACCESS_KEY=credentials('SECRET_ACCESS_KEY')
            // }
             agent any
                   steps{
                       script{
                           dir('terraform'){
                            sh 'aws configure set aws_access_key_id ${AWS_ACCESS_KEY_ID}'
                            sh 'aws configure set aws_secret_access_key ${AWS_SECRET_ACCESS_KEY}'
                           sh "terraform init"
                           sh "terraform apply --auto-approve"
                           EC2_PUBLIC_IP = sh(
                            script: "terraform output ec2_ip",
                            returnStdout: true
                           ).trim()
                       }
                       }
                   }
        }

        stage('Deploy the docker container with ansible playbook') {
            input{
                message "Select the version to package"
                ok "Version selected"
                parameters{
                    choice(name:'NEWAPP',choices:['1.1','1.2','1.3'])
                }
            }
            agent any
            steps {
                sshagent(['slave2']) { //ssh into deploy server
                    //withCredentials([usernamePassword(credentialsId: 'docker-hub', passwordVariable: 'password', usernameVariable: 'username')]) {
                     echo "Deploying docker container on test/deploy server"
                    //  sh "scp -o StrictHostKeyChecking=no ansible/* ec2-user@${EC2_PUBLIC_IP}:/home/ec2-user"
                    //  sh "ssh -o StrictHostKeyChecking=no ec2-user@${EC2_PUBLIC_IP} sudo docker run -itd -p 8001:8080 ${IMAGE_NAME}"
                    sh "scp -o StrictHostKeyChecking=no ansible/* ${ACM_IP}:/home/ec2-user"
                    //copy the ansible target key on ACM as private key file
                   withCredentials([sshUserPrivateKey(credentialsId: 'Ansible_target',keyFileVariable: 'keyfile',usernameVariable: 'user')]){ 
                   sh "scp -o StrictHostKeyChecking=no $keyfile ${ACM_IP}:/home/ec2-user/.ssh/id_rsa"    
                   }
                   sh "ssh -o StrictHostKeyChecking=no ${ACM_IP} bash /home/ec2-user/ansible-config.sh ${AWS_ACCESS_KEY_ID} ${AWS_SECRET_ACCESS_KEY} ${DOCKER_REG_PASSWORD} ${IMAGE_NAME}"
                    
                }
            }
            }
        }
    }
}
