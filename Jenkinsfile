pipeline {

  agent any

  stages {

    stage('Checkout Source') {
      steps {
	 script {     
           def pom = ''		 
           git 'https://github.com/suprabhat-platform/mule-self-signed.git'
	   println("Application checkout successful")
           echo "*** pom.xml before changes ***"
           sh "head pom.xml"
	   if(pom.parent != null) {
		   pom.parent.version="9.9.9"
	   }
           writeMavenPom model: pom
           echo "**** pom.xml after change"
	   sh "head pom.xml"	 
	 /*  def xmlContent = readFile('pom.xml')
	   println("XML Content ==" + xmlContent) 
	   def pom = new XmlParser().parseText(xmlContent)   
	   println("Parsed pom data == "+ pom)
	   if(pom.parent != null) { 
	   println("Inside if == ")
           pom.parent.version[0].setValue("9.9.9")
	   println("If End == ")	   
	   }    */
	  println("Update complete == ")    
	 }		 
      }
    }  
  }
}
