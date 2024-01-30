pipeline {
    agent any


    tools {
        // Install the Maven version configured as "M3" and add it to the path.
        maven "maven"
    }

    stages {
        stage('compile') {
            steps {

                // Run Maven on a Unix agent.
                echo "Compiling the code in this stage"
            }
        }
        stage('test') {
            steps {

                // Run Maven on a Unix agent.
                echo "Testing the code in this stage."
            }
        }
    }
}
