pipeline {
    agent any

    tools {
        // Install the Maven version configured as "M3" and add it to the path.
        maven "mymaven"
    }
    parameters{
        string(name:'ENV', defaultValue: 'Test', description: 'Version of deploy')
        booleanParam(name:'ExecuteTests', defaultValue: true, description: 'decide to run tc')
        choice(name: 'Appversion', choices: ['1.1', '1.2', '1.3'])
         }

    stages {
        stage('Compile') {
            steps {
               echo "compiling the code ${params.Appversion}"
            }
        }
        stage('UnitTest') {
            steps {
               echo "Test the code"
            }
        }
        stage('Package') {
            steps {
               echo "Package the code ${params.ENV}"
            }
        }
    }
}
