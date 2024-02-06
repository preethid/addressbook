pipeline {
    agent none


    tools {
        // Install the Maven version configured as "M3" and add it to the path.
        maven "maven"
    }
    environment{
        BUILD_SERVER='ec2-user/@172.31.83.91'
        IMAGE_NAME='vikranth2009/java-mvn-privaterepos'
    }
    stages {
        stage('compile') {
            //agent {label "Jenkins_Node1"}
            agent any
            steps {
                script{

                    // Run Maven on a Unix agent.
                    git 'https://github.com/chandra-kovvuri/addressbook.git'
                    echo "Compiling the code in this stage"
                    sh "mvn compile"
                }               
            }
        }

        stage('test') {  
            agent any
            steps {
                script{
        
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
        stage('Containerise-Build-Docker-Image') {
            agent any
            steps {
                script{
                    sshagent(['Jenkins_Slave2_SSh_Key']) {
                        withCredentials([usernamePassword(credentialsId: 'docker-hub-Jenkins-Credentials', passwordVariable: 'docker-hub-jenkins-password', usernameVariable: 'docker-hub-jenkins-credentials')]) {
                        //sh "scp -o StrictHostKeyChecking=no containerise-docker-build.sh ${BUILD_SERVER}:/home/ec2-user"
                        sh "scp -o StrictHostKeyChecking=no containerise-docker-build.sh ${BUILD_SERVER}:/home/ec2-user"
                        sh "scp -o StrictHostKeyChecking=no ${BUILD_SERVER} 'bash containerise-docker-build.sh ${BUILD_SERVER} ${BUILD_NUMBER}'"
                        sh "ssh ${BUILD_SERVER} sudo docker login -u ${docker-hub-jenkins-credentials} -p ${docker-hub-jenkins-password}"
                        sh "ssh ${BUILD_SERVER} sudo docker push ${IMAGE_NAME}:${BUILD_NUMBER}"
                    // Run Maven on a Unix agent.
                    //echo "Creating war file in this stage."
                    //sh "mvn package"
                              
                    }
                    }   

                }
            }
        }
    }
}
