pipeline{
    agent any
    tools{
        jdk 'myjava'
        maven 'mymaven'
    }
    stages{
      
        stage("Compile"){
         steps{
                echo "COMPILING THE CODE"
                sh 'mvn compile'
            }
        }
        stage("UnitTest"){
          steps{
                echo "Run the TC"
                sh 'mvn test'
            }
        }
        stage("Package"){
      
           steps{
            
                echo "Package the code"
                sh 'mvn package'         
            }
            
        }
    
}