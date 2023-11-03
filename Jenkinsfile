pipeline {
    agent any
    
    parameters{
        string(name:'roshu' ,defaultValue:'Test' ,description: 'version to deploy')
        booleanParam(name: 'ExecuteTest', defaultValue: true, description: 'head of the family')
        choice(name: 'appversion', choices: ['manadev', 'nandi', 'parvathi'] )
    }

    stages {
        stage('compile') {
            steps {
                script {
                    echo 'compile the code'
                    echo "roshan garu: ${params.roshu}"
                }
            }
        }
        stage('unit test') {
            when {
                expression {
                    params.ExecuteTest == true
                }
            }
            steps {
                script {
                    echo 'test the code'
                }
            }
        }
        stage('package') {
            steps {
                script {
                    echo 'package the code'
                    echo "packaging the code versio ${params.shiva}"
                }
            }
        }
     stage('deploy') {
        input {
            message "select the version to deploy"
            ok "version selected"
            parameters  {
                choice(name: 'newversion', choices: ['1', '2', '3'])
            }
        }
            steps {
                script {
                    echo 'deploy the app'
                   
                }
            }
        }

    }
}
