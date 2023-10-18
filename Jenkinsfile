pipeline {
    agent any
    
    parameters{ 
        string(name: 'DEPLOY_ENV', defaultValue: 'staging', description: '')
         }.

    stages {
        stage('compile') {
            steps {
                script{
                echo ' COMPILE-Hello World'
                echo "Compile in env: ${params.DEPLOY_ENV}"
                }
            }
            
        }
         stage('UnitTest') {
            steps {
                script{
                echo 'UNIT-TESTHello World'
                }
            }
            
        }
         stage('package') {
            steps {
                script{
                echo 'PACKAGE-Hello World'
                }
            }
            
        }

    }
}