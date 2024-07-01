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
        DEV_SERVER='ec2-user@172.31.39.193'
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
                script{
                sshagent(['slave2']) {
                echo 'Test the Code'
               sh "scp -o StrictHostKeyChecking=no server-script.sh ${DEV_SERVER}:/home/ec2-user"
               sh "ssh -o StrictHostKeyChecking=no ${DEV_SERVER} 'bash ~/server-script.sh'"
            }
            }
            }
            post{
                always{
                    junit 'target/surefire-reports/*.xml'
                }
            }
        }
        stage('Package') {
            agent {label 'linux_slave'}
            input{
                message "Select the version to deploy"
                ok "Version Selected"
                parameters{
                    choice(name:'NEWAPP',choices:['1.1','1.2','1.3'])
                }
            
            }
            steps {
                echo "Package the Code ${params.APPVERSION}"
                sh "mvn package"
                
            }
        }
    }
}