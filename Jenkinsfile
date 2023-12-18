pipeline {
    agent any

    parameters{
         string(name: 'ENV', defaultValue: 'DEV', description: 'env to compile')
         booleanParam(name: 'executeTest', defaultValue: true, description: 'decide to run tc')
         choice(name: 'APPVERSION', choices: ['1.1', '1.2', '1.3'], description: 'Pick app version')
    }

    stages {
        stage('Compile') {
            steps {
                script{
                
                 echo "COmpile the Code"
                echo "Compiling in ${params.ENV} environment"
            }
            }
            
        }
        stage("UnitTest"){
            when{
                expression{
                    params.executeTest == true
                }
            }
            steps{
                script{
                echo "Run the Unit test cases"
            }
            }
        }
        stage("Package"){
            steps{
                script{
                echo "Package the Code"
                echo "Packing the app version ${params.APPVERSION}"
                }
            }
        }
        stage("Deploy"){
            input{
                message "Select the version to deploy"
                ok "Version selected"
                parameters{
                    choice(name: 'NEWAPP',choices:['1.2','1.3','1.4'])
                }
            }
            steps{
                script{
                echo "Package the Code"
                echo "Packing the app version ${params.APPVERSION}"
                }
            }

        }
    }
}
