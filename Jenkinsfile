pipeline {
    agent any

    stages {
        stage('Hello') {
            steps {
                script{
                echo 'Hello World'
                }
            }
        }
        stage('Compile') {
            steps {
                script{
                echo 'COMPILE THE CODE'
                }
            }
        }
        stage('UNITEST') {
            steps {
                script{
                echo 'RUN THE UNIT TC'
                }
            }
        }
        stage('PACKAGE') {
            steps {
                script{
                echo 'PACKAGE THE CODE'
                }
            }
        }
    }
}
