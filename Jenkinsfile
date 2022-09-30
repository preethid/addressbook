pipeline {
    agent any
      parameters{
        string(name:'ENV',defaultVlaue:'TEST',description:'env to deploy')
        booleanParam(name:'executeTests',defaultValue:true,description:'decide to run tc')
        choice(name:'APPVERSION',choices:['1.1','1.2','1.3'])
      }
       stages {
        stage('Compile') {
            steps {
                echo "COMPILING THE CODe"
                          
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
              }  
        }
    }
}