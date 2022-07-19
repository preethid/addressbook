pipeline{
    agent none
    tools{
        jdk 'myjava'
        maven 'mymaven'
    }
    environment{
        SERVER_IP='ec2-user@65.0.169.71'
    }
    stages{
      
        stage("Compile"){
            agent { label 'linux_slave'}
         steps{
                echo "COMPILING THE CODE"
                sh 'mvn compile'
            }
        }
        stage("UnitTest"){
            agent any
          steps{
                echo "Run the TC"
                sh 'mvn test'
            }
        }
        stage("Package"){
             agent any
           steps{
             script{
                sshagent(['jenkins-slave']) {
                 echo "Package the code"
                 sh "ssh -o StrictHostKeyChecking=no ${SERVER_IP} 'mvn package'"     
             }
            
              
               
            }
            
        }
    }
    
}