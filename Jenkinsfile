pipeline {
    agent any

    parameters{
        string(name:'Env',defaultValue:'Test',description:'Env to deploy')
    }

    stages {
        stage('Compile') {
            steps {
                echo 'Compile the code'
            }
        }
         stage('UnitTest') {
            steps {
                echo 'Run the test cases'
            }
        }
        stage('Package') {
            steps {
                echo 'Package the code'
            }
        }
    }
}
