pipeline{
    agent any
    parameters { 
        string(name: 'ENV', defaultValue: 'Test', description: 'env to deploy')
        booleanParam(name: 'executeTests', defaultValue: true, description: 'decide to run tc')
        choice(name: 'APPVERSION', choices: ['one', 'two', 'three'])
         }
    stages{
        stage('compile'){
            steps{
                script{
                    echo ("compile the code")
                    echo "deploying to env ${params.ENV}"
                }
            }
        }
        stage('unittest'){
            when { 
                expression { 
                    params.executeTests == true
                    } 
                }
            steps{
                script{
                    echo ("run the unit test cases")  
                }
            }
        }
        stage('package'){
            steps{
                script{
                    echo ("package the code")  
                    echo "packing the code ${params.APPVERSION}"
                }
            }
        }
        stage('deploy'){
            input {
                message "select version to package"
                ok "Yes, we should."
                submitter "GANESH"
                parameters {
                   choice(name: 'NEWERSION', choices: ['1.1', '1.2', '1.3']) 
                }

                }
            steps{
                script{
                    echo ("package the code")  
                    echo "packing the code ${params.APPVERSION}"
                }
            }
        }


    }
}