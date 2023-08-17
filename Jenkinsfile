pipeline {
    agent none

    tools {
        // Install the Maven version configured as "M3" and add it to the path.
        maven "mymaven"
    }  
    environment{
        BUILD_SERVER_IP='ec2-user@172.31.42.41'
    }

    stages {
        stage('Compile') {
            agent any
            steps {
                
                git 'https://github.com/naveen9650/addressbook.git'                
                sh "mvn compile"    
                           
            }           
        }
        stage('UnitTest') {
            agent any
            steps {                
                sh "mvn test"
            }
            post{
                always{
                    junit 'target/surefire-reports/*.xml'
                }
            }           
        }
        stage('package') {
            // agent {label 'linux_slave'}
            // when{
            //     expression{
            //         BRANCH_NAME == 'dev' || BRANCH_NAME == 'develop'
            //     }
            // }
            agent any
            steps {
                script{
                sshagent(['build-server-key']) {
                    echo "Packaging the code on new slave"
                    sh "scp -o StrictHostKeyChecking=no server-config.sh ${BUILD_SERVER_IP}:/home/ec2-user"
                    sh "ssh -o StrictHostKeyChecking=no ${BUILD_SERVER_IP} 'bash ~/server-config.sh'"
                }
               
              
            }           
        }
        }
        stage('Deploy'){
            agent {label 'linux_slave'}
            input{
                    message "Please approve to deploy"
                    ok "yes, to deploy"
                    parameters{
                        choice(name:'NEWVERSION',choices:['1.2','1.3','1.4'])
                    }
                }
            steps{
                
                echo "Deploying to Test"
            }
        }
    }
           
