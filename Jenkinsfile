pipeline {
    agent any  // Added the top-level agent

    parameters {
        string(name: 'Env', defaultValue: 'Test', description: 'version to deploy')
        booleanParam(name: 'executeTests', defaultValue: true, description: 'decide to run tc')
        choice(name: 'APPVERSION', choices: ['1.1', '1.2', '1.3'])
    }

    stages {
        stage('compile') {
            agent any
            steps {
                echo "Compiling...................Compiling ${params.Env}"
            }
        }
        stage('UnitTest') {
            agent any
            when {
                expression {
                    params.executeTests == true
                }
            }
            steps {
                echo 'testing...................testing'
            }
        }
        stage('Package') {
            agent {
                label 'linux_slave'
            }
            input {
                message "select the version to continue"
                ok "selected the version"
                parameters {
                    choice(name: 'NEWAPP', choices: ['1.1', '1.2', '1.3'])
                }
            }
            steps {
                echo "Packaging...................Packaging ${params.APPVERSION}"
            }
        }
    }
}
