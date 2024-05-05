pipeline {
    agent any

    tools {
        // Install the Maven version configured as "M3" and add it to the path.
        maven "mymaven"
    }

    stages {
        stage('Compile') {
            steps {
               echo "compiling the code"
            }
        }
        stage('UnitTest') {
            steps {
               echo "Test the code"
            }
        }
        stage('Package') {
            steps {
               echo "Package the code"
            }
        }
    }
}
