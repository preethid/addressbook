pipeline{
    agent none
    stages{
      
        stage("Compile"){
            agent label{'linux_slave'}
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
                echo "Package the code"
            }
            
        }
    
}
}
