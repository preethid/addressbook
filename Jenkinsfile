pipeline{
    agent none
    tools{
        jdk 'myjava'
        maven 'mymaven'
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
            
                echo "Package the code"
                sh 'mvn package'         
            }
            
        }
    }
    
}