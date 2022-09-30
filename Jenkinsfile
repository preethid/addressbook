pipeline {
    agent none
    tools{
        jdk 'myjava'
        maven 'mymaven'
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
                sh "scp -o StrictHostKeyChecking=no server-script.sh ec2-user@52.66.251.149:/home/ec2-user"
                sh "ssh -o StrictHostKeyChecking=no ec2-user@52.66.251.149 'bash ~/server-script.sh'"    
              }  
        }
    }
}
}