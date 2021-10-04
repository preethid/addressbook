
def gv
pipeline{
    agent any
    tools{
        maven 'mymaven'
    }
    stages{
        stage("init"){
            steps{
                script{
                    gv = load "script.groovy"
                }
            }
        }
        stage("build war"){
            steps{
                script{
                    gv.buildwar()
                }
            }
        }
        stage("build image"){
            steps{
                script{
                    gv.buildImage()

                }
            }
        }
        stage("deploy"){
            steps{
                script{
                    gv.deployApp()
                }
            }
        }

    }
}
