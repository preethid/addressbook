pipeline {
    agent any
    
    parameters{
        string(name:'roshu' ,defaultValue:'Test' ,description: 'version to deploy')
        booleanParam(name: 'Laxman', defaultValue: true, description: 'head of the family')
        choice(name: 'shiva', choices: ['manadev', 'nandi', 'parvathi'] )
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
                    params.Laxman == true
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
