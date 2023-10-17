pipeline {
    agent any

    parameters{
        string(name:'Env',defaultValue:'Test',description:'env to compile')
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
                }
               
            }
        }
    }

}
