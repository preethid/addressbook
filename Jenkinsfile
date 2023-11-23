pipeline {
    agent any

    parameters{
        string(name:'Env',defaultValue:'Test',description:'version to deploy')
        booleanParam(name:'executeTests',defaultValue: true,description:'decide to run tc')
        choice(name:'APPVERSION',choices:['1.1','1.2','1.3'])

    }

    stages {
        stage('Compile') {
            steps {
                echo 'Compiling the code'
                echo "Compiling in ${params.Env}"
            }
        }
        stage('UnitTest') {
            when{
                expression{
                    params.executeTests == true
                }
            }
            steps {
                echo 'Testing the code'
            }
        }
        stage('Package') {
            input{
                message "Select the version to package"
                ok "Version selected"
                parameters{
                    choice(name:'NEWAPP',choices:['1.2','2.1','3.1'])

            }
            steps {
                echo 'Packaging the code'
                echo "Packaging version ${params.APPVERSION}"
            }
        }
    }
}

