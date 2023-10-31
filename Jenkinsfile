pipeline {
    agent none
    tools{
        jdk 'myjava'
        maven 'mymaven'
    }
    
    parameters{ 
        string(name: 'ENV', defaultValue: 'staging', description: 'env to compile')
        booleanParam(name: 'executeTests', defaultValue: true, description: 'decide to rum tc')
        choice(name: 'APPVERSION', choices: ['1.1', '1.2', '1.3'], description: 'Pick something')

         }

environment{
    DEV_SERVER='ec2-user@172.31.0.186'
    DEPLOY_SERVER='ec2-user@172.31.12.151'
    IMAGE_NAME='anoop5843/java-mvn-privaterepos'
}
    stages {
        stage('compile') {
            agent any
            steps {
                script{
                echo ' COMPILE-Hello World'
                echo "Compile in env: ${params.ENV}"
                sh "mvn compile"
                }
            }
            
        }
         stage('UnitTest') {
            //agent {label 'linux_slave'}
           agent any            
         when {
            expression{
                params.executeTests == true
            }
         }        
        steps {
                script{
                echo 'UNIT-TESTHello World'
                sh "mvn test"
                }
            }
          post{
            always{
              junit 'target/surefire-reports/*.xml'  
            }
          }  
            
        }
         stage('package') {
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
        message "select the version to deploy"
        ok "Version selected"
        parameters{
            choice(name: 'NEWVERSION', choices: ['3.4','3.5','3.6'])
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