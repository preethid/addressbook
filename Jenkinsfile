pipeline {
    agent none
    tools{
        maven 'mymaven'
    }

    parameters{
        string(name:'Env',defaultValue:'Test',description:'version to deploy')
        booleanParam(name:'executeTests',defaultValue: true,description:'decide to run tc')
        choice(name:'APPVERSION',choices:['1.1','1.2','1.3'])

    }

    stages {
        stage('Compile') {
            agent { label 'linux_slave' }
            steps {
                echo "Compiling Hello World in ${params.Env}"
                sh 'mvn compile'
            }
        }
        stage('UnitTest') {
            agent any
             when {
                expression{
                    params.executeTests == true
                }
             }
            steps {
                echo 'Testing Hello World'
                sh 'mvn test'
            }
            post{
                always{
                    junit 'target/surefire-reports/*.xml'
                }
            }
        }
         stage('Package') {
            agent { label 'linux_slave' }
            steps {
                echo "Packaging Hello World app verisob ${params.APPVERSION}"
                sh 'mvn package'
            }
        }
    }
}
