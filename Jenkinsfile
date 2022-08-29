pipeline {
    agent any
     parameters{
        string(name:'Env',defaultValue:'Test',description:'Env to deploy')
        booleanParam(name:'executeTests',defaultValue:true,description:'descide to run tc')
        choice(name:'APPVERSION',choices:['1.1','1.2','1.3'])
     }
    stages {
        stage('Hello') {
            steps {
                script{
                echo 'Hello World'
                }
            }
        }
        stage('Compile') {
            steps {
                script{
                echo 'COMPILE THE CODE'
                }
            }
        }
        stage('UNITEST') {
            when{
                expression{
                    params.executeTests == true
                }
            }
            steps {
                script{
                echo 'RUN THE UNIT TC'
                echo "Run the tc in env: ${params.Env}"
                }
            }
        }
        stage('PACKAGE') {
            steps {
                script{
                echo 'PACKAGE THE CODE'
                echo "Deploying the app version ${params.APPVERSION}"
                }
            }
        }
    }
}