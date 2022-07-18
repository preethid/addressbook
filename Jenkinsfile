pipeline{
    agent any
    stages{
        stage("Checkout"){
            steps{
                echo "Clone the repo"
            }
            
        }   
        stage("Compile"){
          steps{
                echo "Compile the code"
            }
        }
        stage("UnitTest"){
           steps{
                echo "Run the TC"
            }
        }
        stage("Package"){
           steps{
                echo "Package the code"
            }
            
        }
    
}
}
