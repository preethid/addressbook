pipeline {
    agent any
    tools{
        jdk 'myjava'
        maven 'mymaven'
    }
    
    parameters{ 
        string(name: 'ENV', defaultValue: 'staging', description: 'env to compile')
        booleanParam(name: 'executeTests', defaultValue: true, description: 'decide to rum tc')
        choice(name: 'APPVERSION', choices: ['1.1', '1.2', '1.3'], description: 'Pick something')

         }

    stages {
        stage('compile') {
            steps {
                script{
                echo ' COMPILE-Hello World'
                echo "Compile in env: ${params.ENV}"
                sh "mvn compile"
                }
            }
            
        }
         stage('UnitTest') {
         when {
            expression{
                params.executeTests == true
            }
         }        
        steps {
                script{
                echo 'UNIT-TESTHello World'
                sh "mvn test"
                }
            }
            
        }
         stage('package') {
            steps {
                script{
                echo 'PACKAGE-Hello World'
                echo "Packaging the code version ${params.APPVERSION}"
                sh "mvn package"
                }
            }
            
        }
stage('Deploy') {
    input{
        message "select the version to deploy"
        ok "Version selected"
        parameters{
            choice(name: 'NEWVERSION', choices: ['3.4','3.5','3.6'])
        }

    }
            steps {
                script{
                echo 'Deploy the app'                
                }
            }
            
        }


    }
}