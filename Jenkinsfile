pipeline {
    agent any

    tools {
        maven 'mymaven'
    }

    environment {
        SERVER_IP = '172.31.40.77'
    }

    parameters {
        string(name: 'Env', defaultValue: 'Test', description: 'version to deploy')
        booleanParam(name: 'executeTests', defaultValue: true, description: 'decide to run tc')
        choice(name: 'APPVERSION', choices: ['1.1', '1.2', '1.3'])
    }

    stages {
        stage('compile') {
            agent any
            steps {
                echo "Compiling...................Compiling ${params.Env}"
                sh "mvn compile"
            }
        }
        stage('UnitTest') {
            agent any
            when {
                expression {
                    params.executeTests == true
                }
            }
            steps {
                script {
                    sshagent(['slave2']) {
                        echo 'testing...................testing'
                        sh "mvn test"
                        sh "scp -o StrictHostKeyChecking=no server-script.sh ec2-user@${env.SERVER_IP}:/home/ec2-user"
                        sh "ssh -o StrictHostKeyChecking=no ec2-user@${env.SERVER_IP} 'bash /home/ec2-user/server-script.sh'"
                    }
                }
            }
            post {
                always {
                    junit 'target/surefire-reports/*.xml'
                }
            }
        }
        stage('Package') {
            agent {
                label 'linux_slave'
            }
            input {
                message "select the version to continue"
                ok "selected the version"
                parameters {
                    choice(name: 'NEWAPP', choices: ['1.1', '1.2', '1.3'])
                }
            }
            steps {
                echo "Packaging...................Packaging ${params.APPVERSION}"
                sh "mvn package"
            }
        }
    }
}
