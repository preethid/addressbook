pipeline {
    agent none


    tools {
        // Install the Maven version configured as "M3" and add it to the path.
        maven "maven"
    }
    stages {
        stage('compile') {
            agent {label "Jenkins_Node1"}
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
                    sshagent(['Jenkins_Slave2_SSh_Key']) {
                        sh "scp -o StrictHostKeyChecking=no Jenkins_Slave2_Config.sh ec2-user@172.31.83.91:/home/ec2-user"
                        sh "scp -o StrictHostKeyChecking=no ec2-user@172.31.83.91 'bash Jenkins_Slave2_Config.sh'"
                    // Run Maven on a Unix agent.
                    echo "Creating war file in this stage."
                    sh "mvn package"
                              
                    }
                    

                }
            }
        }
    }
}
