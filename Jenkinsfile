pipeline {
    agent none

    tools {
        // Install the Maven version configured as "M3" and add it to the path.
        maven "mymaven"
    }  
    stages {
        stage('Compile') {
            agent any
            steps {
                
                git 'https://github.com/naveen9650/addressbook.git'                
                sh "mvn compile"    
                           
            }           
        }
        stage('UnitTest') {
            agent any
            steps {                
                sh "mvn test"
            }
            post{
                always{
                    junit 'target/surefire-reports/*.xml'
                }
            }           
        }
        stage('package') {
             agent {label 'linux_slave'}
            // when{
            //     expression{
            //         BRANCH_NAME == 'dev' || BRANCH_NAME == 'develop'
            //     }
            // }
            steps {
                sh "mvn package"
                    
        }
        }
        stage('Deploy'){
            agent {label 'linux_slave'}
            input{
                    message "Please approve to deploy"
                    ok "yes, to deploy"
                    parameters{
                        choice(name:'NEWVERSION',choices:['1.2','1.3','1.4'])
                    }
                }
            steps{
                
                echo "Deploying to Test"
            }