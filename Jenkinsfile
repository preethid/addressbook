pipeline {
    agent none
    tools{
        jdk 'myjava'
        maven 'mymaven'
    }

    parameters{
        string(name:'Env',defaultValue:'Test',description:'version to deploy')
        booleanParam(name:'executeTests',defaultValue: true,description:'decide to run tc')
        choice(name:'APPVERSION',choices:['1.1','1.2','1.3'])
    }
    environment{
        BUILD_SERVER_IP='ec2-user@172.31.46.168'
        DEPLOY_SERVER_IP='ec2-user@172.31.46.239'
        IMAGE_NAME='devopstrainer/java-mvn-privaterepos'
    }

    stages {
        stage('Compile') {
            agent any
            steps {
                echo 'Compiling the code'
                echo "Compiling in ${params.Env}"
                sh 'mvn compile'
            }
        }
        stage('UnitTest') {
            agent any
            when{
                expression{
                    params.executeTests == true
                }
            }
            steps {
                echo 'Testing the code'
                sh 'mvn test'
            }
            post{
                always{
                    junit 'target/surefire-reports/*.xml'
                }
            }
        }
        stage('DOCKER_BUILD') {
            //  agent {
            //     // Specify the label or name of the Jenkins agent (slave node) where you want to run the package stage
            //     label 'linux_slave'
            // }

            agent any       
           
            steps{
            script{
                sshagent(['build-server']) {
                    withCredentials([usernamePassword(credentialsId: 'docker-hub', passwordVariable: 'PASSWORD', usernameVariable: 'USERNAME')]) {
                    echo "Packaging the code"
                    sh "scp -o StrictHostKeyChecking=no server-config.sh  ${BUILD_SERVER_IP}:/home/ec2-user"
                    sh "ssh -o StrictHostKeyChecking=no ${BUILD_SERVER_IP} 'bash ~/server-config.sh ${IMAGE_NAME} ${BUILD_NUMBER}'"  
                    sh "ssh ${BUILD_SERVER_IP} sudo docker login -u ${USERNAME} -p ${PASSWORD}"
                    sh "ssh ${BUILD_SERVER_IP} sudo docker push ${IMAGE_NAME}:${BUILD_NUMBER}"
                                   
                    
                }
            }
            }
        }
        }
        stage('DEPLOY ON TEST SERVER'){
            agent any
             input{
                message "SELECT THE ENVIRONMENT TO DEPLOY"
                ok "DEPLOY"
                parameters{
                    choice(name:'NEWAPP',choices:['ONPREM','EKS','EC2'])

            }
             }
            steps{
                script{
                sshagent(['build-server']) {
                withCredentials([usernamePassword(credentialsId: 'docker-hub', passwordVariable: 'PASSWORD', usernameVariable: 'USERNAME')]) {
                sh "ssh  -o StrictHostKeyChecking=no ${DEPLOY_SERVER_IP} sudo yum install docker -y"
                sh "ssh  ${DEPLOY_SERVER_IP} sudo systemctl start docker"
                sh "ssh  ${DEPLOY_SERVER_IP} sudo docker login -u ${USERNAME} -p ${PASSWORD}"
                sh "ssh  ${DEPLOY_SERVER_IP} sudo docker run -itd -P ${IMAGE_NAME}:${BUILD_NUMBER}"

                }
            }

        }
    }
}
    }
}
}
