pipeline {

  agent any

  stages {

    stage('Checkout Source') {
      steps {
	 script {     
           def pom = ''
	   git 'https://github.com/suprabhat-platform/mule-self-signed.git'
	   println("Application checkout successful")	
		 
	   pom = readMavenPom file: 'pom.xml'
	   println("pom with readMavenPom" + pom) 
		 
           //Parent pom version update	 
	   println("pom.parent.version before" + pom.parent.version) 		 
           pom.parent.version="8.8.8"
	   println("pom.parent.version after " + pom.parent.version) 

	  //pom properties update	
	   println("Properties update started") 	 
	   println("pom.properties.'app.runtime' before " + pom.properties.'app.runtime')  	 
	   pom.properties.'app.runtime'="4.5.0"	 
	   println("pom.properties.'app.runtime' after " + pom.properties.'app.runtime')

	   println("pom.properties.'mule.maven.plugin.version' before " + pom.properties.'mule.maven.plugin.version')  	 
	   pom.properties.'mule.maven.plugin.version'="3.8.7"	 
	   println("pom.properties.'mule.maven.plugin.version' after " + pom.properties.'mule.maven.plugin.version')	 

	   println("pom.properties.muleHttpConnector before " + pom.properties.muleHttpConnector)  	 
	   pom.properties.muleHttpConnector="1.9.2"	 
	   println("pom.properties.muleHttpConnector after " + pom.properties.muleHttpConnector)

	   println("pom.properties.'munit.version' before " + pom.properties.'munit.version')  	 
	   pom.properties.'munit.version'="2.3.13"	 
	   println("pom.properties.'munit.versionn' after " + pom.properties.'munit.version')
           println("Properties update completed") 
		 
           //pom dependencies update
	  // Iterate through dependencies
       pom.dependencies.each { dependency ->
       if (dependency.groupId == "org.mule.connectors" && dependency.artifactId == "mule-http-connector") {
        println("Dependency version before: " + dependency.version)
        dependency.version = "1.9.2"
        println("Dependency version after: " + dependency.version)
    } 
    else if (dependency.groupId == "org.mule.modules" && dependency.artifactId == "mule-apikit-module") {
        println("Dependency version before: " + dependency.version)
        dependency.version = "1.10.4"
        println("Dependency version after: " + dependency.version)	    
    }	 
    else if (dependency.groupId == "org.mule.connectors" && dependency.artifactId == "mule-vm-connectors") {
        println("Dependency version before: " + dependency.version)
        dependency.version = "2.0.1"
        println("Dependency version after: " + dependency.version)	    
    }	 
      else if (dependency.groupId == "org.mule.connectors" && dependency.artifactId == "mule-sockets-connectors") {
        println("Dependency version before: " + dependency.version)
        dependency.version = "1.2.4"
        println("Dependency version after: " + dependency.version)	    
    }
     else if (dependency.groupId == "com.mulesoft.connectors" && dependency.artifactId == "mule-kafka-connectors") {
        println("Dependency version before: " + dependency.version)
        dependency.version = "4.7.5"
        println("Dependency version after: " + dependency.version)	    
    }
    else if (dependency.groupId == "com.mulesoft.modules" && dependency.artifactId == "mule-secure-configuration-property-module") {
        println("Dependency version before: " + dependency.version)
        dependency.version = "1.2.7"
        println("Dependency version after: " + dependency.version)	    
    }	 else {
	    println("No Dependencies to update")
    }       
}	 
		 
	   writeMavenPom model: pom 
	   println("pom with writeMavenPom" + pom)		
  /*	  sh 'git add .'
	  sh 'git commit -m "created test file"'
	  println("Commit successful")
          sh "git push origin"	
	  println("Changes pushed to codecloud") */

		 
	   	 
	/*	 
            //import groovy.util.Node	
	    //import groovy.xml.*	 
           // def pom = ''		 
           git 'https://github.com/suprabhat-platform/mule-self-signed.git'
	   println("Application checkout successful")
	   def pom = readMavenPom file: 'pom.xml'
	    println("pom data before == " + pom)
            println("pom.version == " + pom.version)
	    println("pom.parent.version == " + pom.parent.version) 
          // def version = pom.version.replace("-SNAPSHOT", "")
           // pom.version = version
           def version = pom.version.replace("1.0.3","9.9.9")
	   pom.version = version
	   writeMavenPom model: pom
	   println("pom data after == " + pom)	 */

    
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
	   def pom = new XmlParser().parse(xmlContent)   
	   println("Parsed pom data == "+ pom)
	   println("pom.parent == "+ pom.parent)	
           println("pom.parent.version[0] == "+ pom.parent.version[0])	
	   if(pom.parent != null) { 
	   println("Inside if == ")
           pom.parent.version[0].setValue("9.9.9")
	   println("If End == ")	   
	   }    */
	 
	  /*  def xmlContent = readFile('pom.xml')	 
           println("xmlContent == " + xmlContent)	 
           def pomdata = new XmlSlurper().parseText(xmlContent)
           println("pomdata == " + pomdata)
            pomdata = pomdata.declareNamespace('': 'http://maven.apache.org/POM/4.0.0')
	   println("pomdata after declaration == " + pomdata)	 
	    println("pomdata.project.parent.version.text() == " + pomdata.project.parent.version.text())	 
	   println("pomdata.project.parent == " + pomdata.project.parent)
	  println("Update complete == ")    */

 /*
    //version working code 
	 def xmlContent = readFile('pom.xml')
println("xmlContent == " + xmlContent)
def pomdata = new XmlSlurper().parseText(xmlContent)
pomdata = pomdata.declareNamespace('pom': 'http://maven.apache.org/POM/4.0.0')
// Print the parsed XML structure to debug
println("Parsed pomdata == \n" + groovy.xml.XmlUtil.serialize(pomdata))
// Access the parent and version elements
def parentVersion = pomdata.parent.version.text()
println("pomdata.parent.version.text() == " + parentVersion)
pomdata.parent.version.replaceBody('9.9.9')			 
def parentElement = pomdata.parent
println("Serialized parent element == \n" + groovy.xml.XmlUtil.serialize(parentElement))
println("pomdata after== " + pomdata)
// Serialize the modified XML back to a string
def updatedXmlContent = groovy.xml.XmlUtil.serialize(pomdata)
println("Updated xmlContent == \n" + updatedXmlContent)
// Write the updated content back to the file
writeFile(file: 'pom.xml', text: updatedXmlContent)

println("Update complete == ") */

//def pom = readMavenPom file: 'pom.xml'
//println("pom data == " + pom) 
	 }		 
      }
    }  
  }
}
