pipeline {
    agent any
    tools {
        // Install the Maven version configured as "M3" and add it to the path.
        maven 'mymaven'
    }
    parameters{
        string(name: 'ENV', defaultValue: 'TEST', description: 'Env to Deploy')
        booleanParam(name: 'executeTests', defaultValue: true, description: 'decide to run tc')
        choice(name: 'APPVERSION', choices: ['1.1', '1.2', '1.3'])
    }
    stages {
        stage('compile') {
            steps {
                git 'https://github.com/naveen9650/addressbook.git'
                sh "mvn compile"
                echo "Env to deploy: ${parms.ENV}"
            } 
        }
        stage('unit-test') {
            when {
                expression{
                    params.executeTests == true
                }
            }
            steps {
                sh "mvn test"
            }
        }
        stage('package') {
            steps {
                sh "mvn package"
                echo "deploy app version: ${params.APPVERSION}"
            }
        }
    }
}
