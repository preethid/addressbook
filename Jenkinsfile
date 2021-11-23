pipeline{
    agent any
    tools{
        jdk 'myjava'
        maven 'mymaven'
    }
    environment{
        APP_NAME='java-mvn-app'
    }
    parameters{
        choice(name:'VERSION',choices:['1.1.0','1.2.0','1.3.0'],description:'version of the code')
        booleanParam(name: 'executeTests',defaultValue: true,description:'tc validity')
    }
    stages{
        stage("COMPILE"){          
            steps{
                script{
                    echo "Compiling the code"
                    sh 'mvn compile'
                }
            }
        }
        stage("UNITTEST"){           
            when{
                expression{
                    params.executeTests == true
                }
            }
            steps{
                script{
                    echo "Testing the code"
                    sh 'mvn test'
                }
            }
            post{
                always{
                    junit 'target/surefire-reports/*.xml'
                }
            }
        }
         stage("PACKAGE"){
                     steps{
                script{
                    echo "Packaging the code"
                    sh 'mvn package'
                }
            }
        }
         stage("BUILD THE DOCKER IMAGE"){       
            steps{
                script{
                    echo "BUILDING THE DOCKER IMAGE"
                   sh 'sudo systemctl start docker'
                    withCredentials([usernamePassword(credentialsId: 'docker-hub', passwordVariable: 'PASS', usernameVariable: 'USER')]) {
                        
                        sh 'sudo docker build -t devopstrainer/java-mvn-privaterepos:$BUILD_NUMBER .'
                        sh 'sudo docker login -u $USER -p $PASS'
                        sh 'sudo docker push devopstrainer/java-mvn-privaterepos:$BUILD_NUMBER'
                }
            }
        }
         }
         stage("Provision ec2-server with TF"){
             environment{
                 AWS_ACCESS_KEY_ID =credentials("jenkins_aws_access_key_id")
                 AWS_SECRET_ACCESS_KEY =credentials("jenkins_aws_secret_access_key")
             }
             steps{
                 script{
                     dir('terraform'){
                      sh "terraform init"
                      sh "terraform apply --auto-approve"
                       EC2_PUBLIC_IP = sh(
                     script: "terraform output ec2-ip",
                     returnStdout: true
                   ).trim()
                }
          }
        }   
         }
        stage("DEPLOYONec2"){
            steps{
                script{
                    sleep(time: 90, unit: "SECONDS")
                    echo "ec2-instance created"
                    echo "${EC2_PUBLIC_IP}"
                    echo "deploying on an ec2-instance created by TF"
                    echo "Deploying version ${params.VERSION}"
                   sshagent(['deploy-server-key']) {
                withCredentials([usernamePassword(credentialsId: 'docker-hub', passwordVariable: 'PASS', usernameVariable: 'USER')]) {
            sh "ssh -o StrictHostKeyChecking=no ec2-user@${EC2_PUBLIC_IP} 'sudo docker login -u $USER -p $PASS'"
            sh "ssh -o StrictHostKeyChecking=no ec2-user@${EC2_PUBLIC_IP} 'sudo docker run -itd -P devopstrainer/java-mvn-privaterepos:$BUILD_NUMBER'"
}
                }
            }
    }
}
}
}