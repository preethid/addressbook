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
        BUILD_SERVER='ec2-user@172.31.3.147'
        //DEPLOY_SERVER='ec2-user@172.31.37.123'
        IMAGE_NAME='devopstrainer/java-mvn-privaterepos'
         ACCESS_KEY=credentials('ACCESS_KEY')
        SECRET_ACCESS_KEY=credentials('SECRET_ACCESS_KEY')
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
                     sh "ssh -o StrictHostKeyChecking=no ${BUILD_SERVER} 'bash server-config.sh ${IMAGE_NAME} ${BUILD_NUMBER}'"
                     sh "ssh ${BUILD_SERVER} sudo docker login -u ${username} -p ${password}"
                     sh "ssh ${BUILD_SERVER} sudo docker push ${IMAGE_NAME}:${BUILD_NUMBER}"
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
                            sh 'aws configure set aws_access_key_id ${ACCESS_KEY}'
                            sh 'aws configure set aws_secret_access_key ${SECRET_ACCESS_KEY}'
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

        stage('Deploy the docker container') {
            input{
                message "Select the version to package"
                ok "Version selected"
                parameters{
                    choice(name:'NEWAPP',choices:['1.1','1.2','1.3'])
                }
            }
            agent any
            steps {
                sshagent(['slave2']) {
                    withCredentials([usernamePassword(credentialsId: 'docker-hub', passwordVariable: 'password', usernameVariable: 'username')]) {
                     echo "Deploying docker container on test/deploy server"
                    //  sh "scp -o StrictHostKeyChecking=no server-config.sh ${DEPLOY_SERVER}:/home/ec2-user"
                    //  sh "ssh -o StrictHostKeyChecking=no ${DEPLOY_SERVER} 'bash server-config.sh ${IMAGE_NAME} ${BUILD_NUMBER}'"
                    sh "ssh -o StrictHostKeyChecking=no ec2-user@${EC2_PUBLIC_IP} sudo yum install docker -y"
                     sh "ssh ec2-user@${EC2_PUBLIC_IP} sudo systemctl start docker"
                     sh "ssh ec2-user@${EC2_PUBLIC_IP} sudo docker login -u ${username} -p ${password}"
                     sh "ssh ec2-user@${EC2_PUBLIC_IP} sudo docker run -itd -p 8080:8080 ${IMAGE_NAME}:${BUILD_NUMBER}"
                }
            }
            }
        }
    }
}
