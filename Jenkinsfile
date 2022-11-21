pipeline {
    agent any
    parameters{
        string(name:'ENV',defaultValue:'Test',description:'env to deploy')
        booleanParam(name:'executeTests',defaultValue: true,description:'decide to run tc')
        choice(name:'APPVERSION',choices:['1.1','1.2','1.3'])
    }
   stages {
        stage('Compile') {
            steps {
                script{
                    echo "COMPILING THE CODE"
                }
            }

           }
        stage('UnitTest') {
            when{
                expression{
                    params.executeTests == true
                }
            }
            steps {
                script{
                    echo "RUN THE UNIT TEST CASES"
                }
            }

           }
           stage('Package') {
            when{
                expression{
                    BRANCH_NAME == 'master' 
                }
            }
            steps {
                script{
                    echo "PACKAGE THE CODE"
                    echo "Deploy to env: ${params.ENV}"
                    echo "deploying the app version: ${params.APPVERSION}"
                }
            }

           }
    }
}
