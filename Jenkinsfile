pipeline {
    agent any
    tools {
        // Install the Maven version configured as "M3" and add it to the path.
        maven "mymaven"
    }
    stages {
        stage('compile') {
            steps {
                git 'https://github.com/naveen9650/addressbook.git'
                sh "mvn compile"
            } 
        }
        stage('unit-test') {
            steps {
                sh "mvn test"
            }
        }
        stage('package') {
            steps {
                sh "mvn package"
            }
        }
    }
}
