
pipeline{
    agent any
    
    tools{
        jdk 'myjava'
        maven 'mymaven'
    }
       def gv = load 'script.groovy'
    stages{
       
        stage("COMPILE"){
            steps{
                script{
                 gv.compilecode()
            }
           }
        }
        stage("UNITTEST"){
            steps{
                script{
                 gv.testapp()
            }
         }
        }
        stage("BUILDING"){
            steps{
                script{
                  gv.buildapp()
                }
            }
        }
        stage("BUILD THE DOCKER IMAGE"){
            steps{
                script{
              gv.builddockerimage()
               }
                }
            }
         stage("DEPLOY"){
            steps{
                script{
               gv.deployApp()
                }
            }
        }
    }
}
