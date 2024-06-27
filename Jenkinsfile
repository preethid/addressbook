pipeline {
    agent any
    parameters {
        string(name: 'Env', defaultValue: 'Test', description: 'version to deploy')
        booleanParam(name: 'executeTests', defaultValue: true, description: 'decide to run')
        choice(name: 'APPVERSION', choices: ['1.1', '1.2', '1.3'], description: 'Pick something')
    }
    stages {
        stage('Compile') {
            steps {
                echo "Compiling the Code in the ${params.Env}"
            }
        }
        stage('UnitTest') {
            when {
                expression {
                    return params.executeTests == true
                }
            }
            steps {
                echo 'UnitTesting the Code'
            }
        }
        stage('Package') {
            input {
                message "select the version you want to deploy"
                ok "version selected"
                submitter "alice,bob"
                parameters {
                    choice(name: 'NEWAPP', choices: ['1.1', '1.2', '1.3'], description: 'Pick something')
                }
            }
            steps {
                echo "Packaging the Code ${params.NEWAPP}"
            }
        }
    }
}
