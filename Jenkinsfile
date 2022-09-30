pipeline {
    agent any
      parameters{
        string(name:'ENV',defaultValue:'TEST',description:'env to deploy')
        booleanParam(name:'executeTests',defaultValue:true,description:'decide to run tc')
        choice(name:'APPVERSION',choices:['1.1','1.2','1.3'])
      }
       stages {
        stage('Compile') {
            when{
                expression{
                    BRANCH_NAME == 'dev' || BRANCH_NAME == 'test'
                }
            }
            input{
                message "Select the version to compile"
                ok "Version selected"
                parameters{
                    choice(name:'NEWAPP',choices:['v1','v2','v3'])
                }
            }
            steps {
                echo "COMPILING THE CODE: ${NEWAPP}"
                          
        }
        }
        stage('UnitTest') {
            
            when{
                    expression{
                        params.executeTests ==true
                    }
                }
                steps {
                    script{
                          echo "RUNNING UNIT TEST CASES"
                    }
                   }
            
        }
        stage('Package') {
            steps {
                echo "PACKAGING THE CODE"
              echo "Deploying to env: ${params.ENV}"
              echo "Deploying version: ${params.APPVERSION}"
              }  
        }
    }
}