pipeline {
    agent any
    
    parameters{
        string(name:'roshu' ,defaultValue:'Test' ,description: 'version to deploy')
    }

    stages {
        stage('compile') {
            steps {
                script {
                    echo 'compile the code'
                    echo "roshan garu: ${params.roshu}"
                }
            }
        }
        stage('unit test') {
            steps {
                script {
                    echo 'test the code'
                }
            }
        }
        stage('package') {
            steps {
                script {
                    echo 'package the code'
                }
            }
        }
    }
}
