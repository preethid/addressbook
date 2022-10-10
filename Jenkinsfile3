pipeline {
    agent none
    tools{
        jdk 'myjava'
        maven 'mymaven'
    }
    environment{
        BUILD_SERVER_IP="ec2-user@52.66.251.149"
    }
      stages {
        stage('Compile') {
            agent any
           steps {
            script{
                   echo "COMPILING THE CODE"
                    sh 'mvn compile'          
            }        
            }
        }
        stage('UnitTest') {
            agent {label 'linux_slave'}
           steps {
            script{
                echo "RUNNING UNIT TEST CASES"
                sh 'mvn test'
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
                echo "PACKAGING THE CODE"
                sshagent(['BUILD_SERVER_KEY']) {
                sh "scp -o StrictHostKeyChecking=no server-script.sh ${BUILD_SERVER_IP}:/home/ec2-user"
                sh "ssh -o StrictHostKeyChecking=no ${BUILD_SERVER_IP} 'bash ~/server-script.sh'"    
              }  
        }
    }
}
}