def compile() {
   
    sh 'mvn compile'
} 

def UnitTest() {
  
    sh 'mvn test'
} 

def package() {
 
  sh 'mvn package'
} 

return this
