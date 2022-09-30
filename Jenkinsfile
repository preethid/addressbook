pipeline {
    agent any
    tools{
        jdk 'myjava'
        maven 'mymaven'
    }
      stages {
        stage('Compile') {
           steps {
            script{
                   echo "COMPILING THE CODE"
                    sh 'mvn compile'          
            }        
            }
        }
        stage('UnitTest') {
           steps {
            script{
                echo "RUNNING UNIT TEST CASES"
                sh 'mvn test'
                    }
                   }
            
        }
        stage('Package') {
            steps {
                echo "PACKAGING THE CODE"
                sh 'mvn package'             
              }  
        }
    }
}