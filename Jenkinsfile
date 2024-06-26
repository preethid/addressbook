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
                echo "Compiling the Code in ${params.Env}"
                
            }
        }
        stage('UnitTest') {
            when{
                expression{
                    params.executeTests == true
                }
            }
            steps {
                echo 'Test the Code'
            }
        }
        stage('Package') {
            input{
                message "Select the version to deploy"
                OK "Version Selected"
                parameters{
                    choice(name:'NEWAPP',choices:['1.1','1.2','1.3'])
                }
            
            }
            steps {
                echo "Package the Code ${params.APPVERSION}"
                
            }
        }
    }
}
