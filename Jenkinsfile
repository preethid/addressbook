pipeline {
    agent none

    tools{
        jdk 'myjava'
        maven 'mymaven'
    }

    parameters{
        string(name:'Env',defaultValue:'Test',description:'env to compile')
        booleanParam(name:'executeTests',defaultValue: true,description:'decide to run tc')
        choice(name:'APPVERSION',choices:['1.1','1.2','1.3'])

    }

    environment{
        DEV_SERVER='ec2-user@172.31.8.237'
        DEPLOY_SERVER='ec2-user@172.31.14.64'
        IMAGE_NAME='devopstrainer/java-mvn-privaterepos'
    }

    stages {
        stage('Compile') {
            agent any
            steps {
                script{
                     echo 'COMPIEL-Hello World'
                     echo "compile in env: ${params.Env}"
                     sh "mvn compile"
                }
               
            }
        }
         stage('UnitTest') {
            //agent {label 'linux_slave'}
            agent any
            when{
                expression{
                    params.executeTests == true
                }
            }
            steps {
                script{
                     echo 'UNITTEST-Hello World'
                     sh "mvn test"
                }
               
            }
            post{
                always{
                    junit 'target/surefire-reports/*.xml'
                }
            }
        }
         stage('Package') {
            agent any
            steps {
                script{
                     sshagent(['aws-key']) {
                    withCredentials([usernamePassword(credentialsId: 'docker-hub', passwordVariable: 'dockerpassword', usernameVariable: 'dockeruser')]) {
                     echo 'PACKAGE-Hello World'
                     echo "Packaging the code version ${params.APPVERSION}"
                    sh "scp -o StrictHostKeyChecking=no server-config.sh ${DEV_SERVER}:/home/ec2-user"
                    sh "ssh -o StrictHostKeyChecking=no ${DEV_SERVER} 'bash ~/server-config.sh ${IMAGE_NAME} ${BUILD_NUMBER}'"
                    sh "ssh ${DEV_SERVER} sudo docker login -u ${dockeruser} -p ${dockerpassword}"
                    sh "ssh ${DEV_SERVER} sudo docker push ${IMAGE_NAME}:${BUILD_NUMBER}"
                }
                     }
            }
        }
         }
        stage('Deploy') {
            agent any
            input{
                message "Select the version to deploy"
                ok "Version selected"
                parameters{
                    choice(name:'NEWVERSION',choices:['3.4','3.5','3,6'])
                }
            }
            steps {
                script{
                     sshagent(['aws-key']) {
                    withCredentials([usernamePassword(credentialsId: 'docker-hub', passwordVariable: 'dockerpassword', usernameVariable: 'dockeruser')]) {
                     echo 'Deploy the app'
                     sh "ssh -o StrictHostKeyChecking=no ${DEPLOY_SERVER} sudo yum install docker -y"
                     sh "ssh  ${DEPLOY_SERVER} sudo systemctl start docker"
                     sh "ssh ${DEPLOY_SERVER} sudo docker login -u ${dockeruser} -p ${dockerpassword}"
                    sh "ssh  ${DEPLOY_SERVER} sudo docker run -itd -P ${IMAGE_NAME}:${BUILD_NUMBER}"
                }
                     }
            }
        }

    }

    }
}
