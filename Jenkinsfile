pipeline {
    agent none


    tools {
        // Install the Maven version configured as "M3" and add it to the path.
        maven "maven"
    }
    stages {
        agent {label "Jenkins_Node1"}
        stage('compile') {
            steps {
                script{

                    // Run Maven on a Unix agent.
                    echo "Compiling the code in this stage"
                    sh "mvn compile"
                }               
            }
        }
        stage('test') {
            agent any
            steps {
                script{
                    // Run Maven on a Unix agent.
                    echo "Testing the code in this stage."
                    sh "mvn test"
                }            
            }
            post{ 
                always{
                    junit 'target/surefire-reports/*.xml'
                }
            }
        }
        stage('Package') {
            agent any
            steps {
                script{
                    // Run Maven on a Unix agent.
                    echo "Creating war file in this stage."
                    sh "mvn package"

                }
            }
        }
    }
}
