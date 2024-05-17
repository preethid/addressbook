pipeline {
    agent any

    parameters{
        string(name:'Env',defaultValue:'Test',description:'version to deploy')
        booleanParam(name:'executeTests',defaultValue: true,description:'decide to run tc')
        choice(name:'APPVERSION',choices:['1.1','1.2','1.3'])

    }

    stages {
        stage('Compile') {
            steps {
                echo "Compiling Hello World in ${params.Env}"
            }
        }
        stage('UnitTest') {
             when {
                expression{
                    params.executeTests == true
                }
             }
            steps {
                echo 'Testing Hello World'
            }
        }
         stage('Package') {
            steps {
                echo "Packaging Hello World app verisob ${params.APPVERSION}"
            }
        }
    }
}
