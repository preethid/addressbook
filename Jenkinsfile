pipeline {
    agent any
    
    parameters{
        string(name:'roshu' ,defaultValue:'Test' ,description: 'version to deploy')
        booleanParam(name: 'ExecuteTest', defaultValue: true, description: 'head of the family')
        choice(name: 'appversion', choices: ['manadev', 'nandi', 'parvathi'] )
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
            when {
                expressions{
                    params.executeTests == true
                }
            }
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
                    echo "packaging the code versio ${params.shiva}"
                }
            }
        }
    }
}
