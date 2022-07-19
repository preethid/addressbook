pipeline{
    agent any
    parameters{
        string(name:'ENV',defaultValue:'TEST',description:'versiontoeploy')
        booleanParam(name:'executeTests',defaultValue: true,description:'decidetorunthetc')
        choice(name:'APPVERSION',choices:['1.1','1.2','1.3'])
    }
    stages{
      
        stage("Compile"){
         
          steps{
                echo "Compile the code v1"
            }
        }
        stage("UnitTest"){
          when{
            expression{
                params.executeTests == true
            }
          }
           steps{
                echo "Run the TC"
            }
        }
        stage("Package"){
            
           steps{
            
                    echo "Package the code"
                  echo "Deploying to env: ${params.ENV}"
                  echo "Deploying the app version: ${params.APPVERSION}"
            }              
            }
            
        }
    
}
}
