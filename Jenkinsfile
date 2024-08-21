pipeline {

  agent any

  stages {

    stage('Checkout Source') {
      steps {
	 script {     
	   println("Application checkout successful")
           git 'https://github.com/suprabhat-platform/mule-self-signed.git'
	   println("Application checkout successful")
	   def xmlContent = readFile('pom.xml')
	   println("XML Content ==" + xmlContent) 
	   def pom = new XmlParser().parse(xmlContent)   
	   println("Parsed pom data == "+ pom)
	   if(pom.parent != null) { 
	   println("Inside if == ")
           pom.parent.version = "9.9.9"
	   println("If End == ")	   
	   }   
	  println("Update complete == " + pom)    
	 }		 
      }
    }  
  }
}
