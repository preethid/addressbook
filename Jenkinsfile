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
        DEV_SERVER='ec2-user@172.31.33.136'
        IMAGE_NAME='devopstrainer/java-mvn-privaterepos:$BUILD_NUMBER'
    }

    stages {
        stage('Compile') {
            agent any
            steps {
                echo "Compiling the Code in ${params.Env}"
                sh "mvn compile"
                
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
              
                echo 'Test the Code'
                sh "mvn test"
            }
            
            post{
                always{
                    junit 'target/surefire-reports/*.xml'
                }
            }
        }
        
        stage('Dockerize and push the image') {
            agent any
            input{
                message "Select the version to deploy"
                ok "Version Selected"
                parameters{
                    choice(name:'NEWAPP',choices:['1.1','1.2','1.3'])
                }
            
            }
            steps {
                 script{
                sshagent(['slave2']) {
                    withCredentials([usernamePassword(credentialsId: 'docker-hub', passwordVariable: 'PASSWORD', usernameVariable: 'USERNAME')]) {
                echo "Package the Code ${params.APPVERSION}"
                 sh "scp -o StrictHostKeyChecking=no server-script.sh ${DEV_SERVER}:/home/ec2-user"
               sh "ssh -o StrictHostKeyChecking=no ${DEV_SERVER} bash /home/ec2-user/server-script.sh ${IMAGE_NAME}"
               sh "ssh ${DEV_SERVER} sudo docker login -u ${USERNAME} -p ${PASSWORD}"
               sh "ssh ${DEV_SERVER} sudo docker push ${IMAGE_NAME}"
                    }
            }
        }
    }
        }
    }
}
