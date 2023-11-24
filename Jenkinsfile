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
        stage('Package') {
            //  agent {
            //     // Specify the label or name of the Jenkins agent (slave node) where you want to run the package stage
            //     label 'linux_slave'
            // }

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
                sshagent(['deploy-server']) {
                    echo "Packaging the code"
                    sh "scp -o StrictHostKeyChecking=no server-script.sh  ec2-user@172.31.11.212:/home/ec2-user"
                    sh "ssh -o StrictHostKeyChecking=no ec2-user@172.31.11.212 'bash ~/server-config.sh'"  
                    // sh 'mvn package'
                    // sh "ssh "
                   
                    
                }
            }
            }
        }
    }
}

