pipeline{
    agent none
    stages{
      
        stage("Compile"){
         agent { label 'linux_slave'}
          steps{
                echo "Compile the code v1"
            }
        }
        stage("UnitTest"){
            agent any
           steps{
                echo "Run the TC"
            }
        }
        stage("Package"){
            agent any
           steps{
              sshagent(['jenkins-slave']) {
                    echo "Package the code"
               sh "ssh -o StrictHostKeyChecking=no ec2-user@172.31.46.17 'echo 'hi'"
            }              
            }
            
        }
    
}
}
