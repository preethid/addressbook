def buildwar(){
    echo "building the application..."
    git 'https://github.com/preethid/addressbook.git'
    sh 'mvn package'
}
def buildImage(){
    echo "deploying the application..."
    withCredentials([usernamePassword(credentialsId: 'dockerhub',passwordVariable: 'PASS',usernameVariable: 'USER')]){
    sh 'sudo docker build -t devopstrainer/myrepoprivate:jenkinsjob .'
    sh 'sudo docker login -u $USER -p $PASS'
    //sh "echo $PASS | sudo docker login -u $USER --password-stdin"
    sh 'sudo docker push devopstrainer/myrepoprivate:jenkinsjob'
}
def deployApp(){
    echo 'deploying the app..'
}

return this
