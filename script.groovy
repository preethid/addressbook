def compilecode(){
   echo "compiling the code"
   sh 'mvn compile'
}
def testapp(){
   echo "testing the app"
   sh 'mvn test'
}
def buildapp(){
   echo "building the app"
   sh 'mvn package'
}
def builddockerimage(){
    echo "building the docker image" 
               withCredentials([usernamePassword(credentialsId: 'docker-hub', 
                    passwordVariable: 'PASS', usernameVariable: 'USER')]){
                   sh 'sudo docker build -t devopstrainer/myrepoprivate:$BUILD_NUMBER .'
                   sh "sudo docker login -u $USER -p $PASS"
                   sh 'sudo docker push devopstrainer/myrepoprivate:$BUILD_NUMBER'
}
def deployApp(){
    echo "building the app"
}

return this
