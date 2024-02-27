pipeline {
    agent none

    tools {
        // Install the Maven version configured as "M3" and add it to the path.
        maven "mymaven"
    }
    parameters{
        string(name:'Env',defaultValue:'Test',description:'env to deploy')
        booleanParam(name:'executeTests',defaultValue: true,description:'decide to run tc')
        choice(name:'VERSION',choices:['1.1','1.2','1.3'])
    }
    environment{
        BUILD_SERVER='ec2-user@172.31.5.148'
        IMAGE_NAME='devopstrainer/java-mvn-privaterepos'
        DEPLOY_SERVER='ec2-user@172.31.3.142'
    }

    stages {
        stage('Compile') {
            agent any
            steps {
                script{
                    echo "Compiling the code ${params.Env}"
                    sh "mvn compile"
                }
                
            }

            
        }
        stage('UnitTest') { // running on slave1
            //agent {label 'linux_slave'}
            agent any
            when{
                expression{
                    params.executeTests == true
                }
            }
            steps {
                script{
                    echo "RUNNING THE TC"
                    sh "mvn test"
                }
                }
            
            post{
                always{
                    junit 'target/surefire-reports/*.xml'
                }
            }
            
        }
        stage('Containerize+push the image to registry') { // running on slave2 via ssh-agent
            agent any
            steps {
                script{
                    sshagent(['slave2']) {
                    withCredentials([usernamePassword(credentialsId: 'docker-hub', passwordVariable: 'PASSWORD', usernameVariable: 'USERNAME')]) {
                    echo "Containerising the code"
                    sh "scp  -o StrictHostKeyChecking=no server-config.sh ${BUILD_SERVER}:/home/ec2-user"
                    sh "ssh -o StrictHostKeyChecking=no ${BUILD_SERVER} 'bash server-config.sh ${IMAGE_NAME} ${BUILD_NUMBER}'"
                    sh "ssh ${BUILD_SERVER} sudo docker login -u ${USERNAME} -p ${PASSWORD}"
                    sh "ssh ${BUILD_SERVER} sudo docker push ${IMAGE_NAME}:${BUILD_NUMBER}"
                }
                }
                }
            }

            
        }
        stage('Deploy docker container'){
            agent any
            input{
                message "Please approve the deployment"
                ok "yes, to deploy"
                parameters{
                    choice(name: 'APPVERSION', choices:['1.1','1.2','1.3'])
                }
            }
            steps{
                script{
                    sshagent(['slave2']) {
                    withCredentials([usernamePassword(credentialsId: 'docker-hub', passwordVariable: 'PASSWORD', usernameVariable: 'USERNAME')]) {
                    echo "run the docker container"
                    sh "ssh -o StrictHostKeyChecking=no ${DEPLOY_SERVER} sudo yum install docker -y"
                     sh "ssh -o StrictHostKeyChecking=no ${DEPLOY_SERVER} sudo systemctl start docker"
                    sh "ssh ${DEPLOY_SERVER} sudo docker login -u ${USERNAME} -p ${PASSWORD}"
                    sh "ssh ${DEPLOY_SERVER} sudo docker run -itd -P ${IMAGE_NAME}:${BUILD_NUMBER}"
                    }
                }
            }
        }
    }
}
}