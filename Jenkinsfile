pipeline {
    agent any

    tools {
        // Install the Maven version configured as "M3" and add it to the path.
        maven "mymaven"
    }

    stages {
        stage('Compile') {
            steps {
               echo "compiling teh code"
            }
        }
        stage('UnitTest') {
            steps {
               echo "Test teh code"
            }
        }
        stage('Package') {
            steps {
               echo "Package teh code"
            }
        }
    }
}
