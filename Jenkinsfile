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
        BUILD_SERVER='ec2-user@172.31.41.81'
        IMAGE_NAME='devopstrainer/java-mvn-privaterepos'
    }

    stages {
        stage('Compile') {
            agent { label 'linux_slave' }
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
         stage('Containerising the build phase') {ssh ${BUILD_SERVER} sudo docker push ${IMAGE_NAME}:${BUILD_NUMBER}
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
                     echo "Containerising Hello World app verison ${params.APPVERSION}"
                     sh "scp -o StrictHostKeyChecking=no server-config.sh ${BUILD_SERVER}:/home/ec2-user"
                     sh "ssh -o StrictHostKeyChecking=no ${BUILD_SERVER} 'bash server-config.sh ${IMAGE_NAME} ${BUILD_NUMBER}'"
                     sh "ssh ${BUILD_SERVER} sudo docker login -u ${username} -p ${password}"
                     sh "ssh ${BUILD_SERVER} sudo docker push ${IMAGE_NAME}:${BUILD_NUMBER}"
                }
            }
            }
        }
    }
}
