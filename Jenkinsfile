pipeline {
   agent none
   tools{
//     jdk "myjava"
        maven "mymaven"
   }
   parameters{
        string(name:'Env',defaultValue:'Test',description:'Environment to deploy')
        booleanParam(name:'executeTests',defaultValue: true,description:'decide to run tc')
        choice(name:'APPVERSION',choices:['1.1','1.2','1.3'])

   }
    stages {
        stage('Compile') { //prod
        agent any
            steps {
                echo "Compile the code in ${params.Env}"
                sh "mvn compile"
            }
        }
         stage('UnitTest') { //test
         when{
            expression{
                params.executeTests == true 
            }
         }
         agent any
            steps {
                echo "Test the code"
                sh "mvn test"
            }
            post{
                always{
                     junit 'target/surefire-reports/*.xml'
                }
            }
        }
         stage('Package') {//dev
        //agent {label 'linux_slave'}
        agent any
            steps {
                echo "Package the code ${params.APPVERSION}"
                sh "mvn package"
            }
        }
    }
}
