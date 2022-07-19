pipeline{
    agent any
    parameters{
        string(name:'ENV',defaultValue:'TEST',description:'versiontoeploy')
        booleanParam(name:'executeTests',defaultValue: true,description:'decidetorunthetc')
        choice(name:'APPVERSION',choices:['1.1','1.2','1.3'])
    }
    environment{
        NEW_VERSION='2.1'
    }
    stages{
      
        stage("Compile"){
         when{
            expression{
                BRANCH_NAME == 'test' || BRANCH_NAME == 'master'
            }
         }
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
             when{
    expression{
        BRANCH_NAME == 'master'
    }
 }
            input{
                message "select the version for package"
                ok "version selected"
                parameters{
                    choice(name:'NEWAPP',choices:['A','B','C'])
                }
            }
            
           steps{
            
                    echo "Package the code"
                  echo "Deploying to env: ${params.ENV}"
                  echo "Deploying the app version: ${params.APPVERSION}"
                  echo "Newapp version: ${NEW_VERSION}"
            }              
            }
            
        }
    
}