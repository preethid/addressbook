pipeline {
    agent none
    tools{
        jdk 'myjava'
        maven 'mymaven'
    }

    parameters{
        string(name:'Env',defaultValue:'Test',description:'env to compile')
        booleanParam(name:'executeTests',defaultValue: true,description:'decide to run tc')
        choice(name:'APPVERSION',choices:['1.1','1.2','1.3'])

    }

    stages {
        stage('Compile') {
            agent any
            steps {
                script{
                     echo 'COMPIEL-Hello World'
                     echo "compile in env: ${params.Env}"
                     sh "mvn compile"
                }
               
            }
        }
         stage('UnitTest') {
            agent any
            when{
                expression{
                    params.executeTests == true
                }
            }
            steps {
                script{
                     echo 'UNITTEST-Hello World'
                     sh "mvn test"
                }
               
            }
            post{
                always{
                    junit 'target/surefile-reports/*.xml'
                }
            }
        }
         stage('Package') {
            agent {label 'linux_slave'}
            steps {
                script{
                     echo 'PACKAGE-Hello World'
                     echo "Packaging the code version ${params.APPVERSION}"
                     sh "mvn package"
                }
               
            }
        }
        stage('Deploy') {
            agent any
            input{
                message "Select the version to deploy"
                ok "Version selected"
                parameters{
                    choice(name:'NEWVERSION',choices:['3.4','3.5','3,6'])
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
