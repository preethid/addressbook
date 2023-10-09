pipeline{
    agent any
    parameters{
        string(name: 'DEPLOY_ENV', defaultValue: 'Test', description: 'Env to deploy') 
        booleanParam(name: 'executeTests', defaultValue: true, description: 'Decide to run tc')
        choice(name: 'APP_VERSION', choices: ['1', '2', '3'], description: 'Pick')
    }
    stages{
        stage('compile'){
            steps{
                script{
                    echo('compile the code')
                    echo "Deploying to Env: ${params.DEPLOY_ENV}"
                }
            }

            }
        stage('unittest'){
            when{
                expression{
                    params.executeTests==true
                }
            }
            steps{
                script{
                    echo('run the unit test cases')
                }
            }

            }
        stage('package'){
            steps{
                script{
                    echo('package')
                    echo"packing the code version ${params.APP_VERSION}"
                }
            }

            }
        }
}
    
