pipeline{
    agent any
       tools{
        jdk 'myjava'
        maven 'mymaven'
    }
    stages{
        stage("COMPILE"){
            steps{
               script{
                echo "compiling the code"
                git 'https://github.com/preethid/addressbook.git'
                sh 'mvn compile'
            }
}
        }
        stage("UNITTEST"){
             steps{
               script{
              echo  "testing the app"
              sh 'mvn test'
            }
}
        }
        stage("BUILDING"){
            steps{
          script{
               echo "building the app"
               sh 'mvn package'
            }
}
        }
        stage("BUILD THE DOCKER IMAGE"){
            steps{
             script{
               echo "building the docker image"
               withCredentials([usernamePassword(credentialsId: 'docker-hub',
                    passwordVariable: 'PASS', usernameVariable: 'USER')]){
                   sh 'sudo docker build -t devopstrainer/myrepoprivate:$BUILD_NUMBER .'
                   sh 'sudo docker login -u $USER -p $PASS'
                   sh 'sudo docker push devopstrainer/myrepoprivate:$BUILD_NUMBER'
               }
            }
          }
        }
        stage("DEPLOY"){
            steps{
           script{
               echo "deploying the app"
            }
        }
     }
    }
}
