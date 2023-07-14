pipeline {
    agent any

    parameters{
        string(name:'Env',defaultValue:'Test',description:'Env to deploy')
        booleanParam(name:'executeTests',defaultValue:true,description:'decide to run tc')
    }

    stages {
        stage('Compile') {
            steps {
                echo 'Compile the code'
            }
        }
         stage('UnitTest') {
            when{
                expression{
                    params.executeTests == true
                }
            }
            steps {
                echo 'Run the test cases'
            }
        }
        stage('Package') {
            steps {
                echo "Package the code in env:${params.Env}"

            }
        }
    }
}
