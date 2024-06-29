pipeline {
    agent any
       parameters {
            string(name: 'Env', defaultValue: 'Test', description: 'version to deploy')

            booleanParam(name: 'executeTests', defaultValue: true, description: 'decide to run tc')

            choice(name: 'APPVERSION', choices: ['1.1','1.2','1.3'])
       
        }

    stages {
     
        stage('compile') {
            steps {
                echo "Compiling...................Compiling ${params.Env}"
            }
        }
        stage('UnitTest') {
            when{
                expression{
                    params.executeTests == true
                }
            }
            steps {
                echo 'testing...................testing'
            }
        }
        stage('Package') {
            steps {
                echo "Packaging...................Packaging ${params.APPVERSION}"
            }
        }
    }
}
