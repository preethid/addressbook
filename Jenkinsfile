pipeline {
    agent any

    parameters{
        string(name:'Env',defaultValue:'Test',description:'env to compile')
        booleanParam(name:'executeTests',defaultValue: true,description:'decide to run tc')
        choice(name:'APPVERSION',choices:['1.1','1.2','1.3'])

    }

    stages {
        stage('Compile') {
            steps {
                script{
                     echo 'COMPIEL-Hello World'
                     echo "compile in env: ${params.Env}"
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
                     echo 'UNITTEST-Hello World'
                }
               
            }
        }
         stage('Package') {
            steps {
                script{
                     echo 'PACKAGE-Hello World'
                     echo "Packaging the code version ${params.APPVERSION}"
                }
               
            }
        }
        stage('Deploy') {
            input{
                message "Select the version to deploy"
                ok "Version selected"
                parameters{
                    choice(name:'NEWVERSION',choices:['3.4','3.5','3,6'])
                }
            }
            steps {
                script{
                     echo 'Deploy the app'
                     
                }
               
            }
        }

    }

}
