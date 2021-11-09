pipeline{
    agent any
    tools{
        jdk'myjava'
        maven 'MYMAVEN'
    }
    environment{
         NEW_VERSION='1.4.0'
    }
    stages{

         stage("compiling"){
             steps{

                 script{
                      echo "compiling the code"
                      git 'https://github.com/reddyilluri/addressbook-1.git'
                      sh 'mvn compile'


                 }
             }
           

        }
        stage("unit test adressbook"){
            steps{
                script{
                    echo "run unit test"
                    sh 'mvn test'
                }
            }
            post{
                always{
                    junit'target/surefire-reports/*.xml'
                }
            }
            

        }
        stage("package"){
            steps{
                script{
                    echo "building app"
            echo "building version ${NEW_VERSION}"
            sh 'mvn package'
            }
            }
            

        }

        
    }
}
