pipeline {

  agent any

  stages {

    stage('Checkout Source') {
      steps {
	 script {     
            //import groovy.util.Node	
	    //import groovy.xml.*	 
          // def pom = ''		 
           git 'https://github.com/suprabhat-platform/mule-self-signed.git'
	   println("Application checkout successful")
      /*     echo "*** pom.xml before changes ***"
          // sh "head pom.xml"
	    powershell '''
                    Get-Content pom.xml -First 10
                    '''	 
           echo "**** sh pom completed"
	   if(pom.parent != null) {
		   echo "**** Inside If"
		   pom.parent.version="9.9.9"
		   echo "****  If complete"
	   }
	   echo "****  outside if:writeMavenPom started " 
           writeMavenPom model: pom
           echo "**** pom.xml after change"
	   sh "head pom.xml"	 */

           /*	 
	   def xmlContent = readFile('pom.xml')
	   println("XML Content ==" + xmlContent) 
	   def pom = new XmlParser().parseText(xmlContent)   
	   println("Parsed pom data == "+ pom)
	   println("pom.parent == "+ pom.parent)	
           println("pom.parent.version[0] == "+ pom.parent.version[0])	
	   if(pom.parent != null) { 
	   println("Inside if == ")
           pom.parent.version[0].setValue("9.9.9")
	   println("If End == ")	   
	   }    */

	  def newVersion = '2.0.0'
          def pomFile = new File('pom.xml')
	  def pom = new XmlParser().parse(pomFile) 
	  def parentNode = pom.'parent'
		if (parentNode) {
		    def versionNode = parentNode.'version'
		    if (versionNode) {
		        versionNode[0].setValue(newVersion)
		    } else {
		        println "version element not found in parent."
		    }
		} else {
		    println "parent element not found."
		}	 
	  println("Update complete == ")    
	 }		 
      }
    }  
  }
}
