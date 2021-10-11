def compilecode(){
   echo 'compiling the code'
   sh 'mvn compile'
}
def testapp(){
   echo 'testing the app'
   sh 'mvn test'
}
def buildapp(){
   echo 'building the app'
   sh 'mvn package'
}
def builddockerimage(){
    echo 'building the docker image'
              
def deployApp(){
    echo 'building the app'
}
 
return this
