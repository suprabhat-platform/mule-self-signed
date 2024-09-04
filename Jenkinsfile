pipeline {

  agent any

  stages {

    stage('Checkout Source') {
	 environment {
            GIT_REPO_NAME = "mule-self-signed"
            GIT_USER_NAME = "suprabhat-platform"
        }
      steps {
	 script {     
		 
           def pom = ''
	   git 'https://github.com/suprabhat-platform/mule-self-signed.git'
	   println("Application master checkout successful")	
           bat '''		 
           git checkout -b seed-automation_v15
	   '''
	   println("Application feature branch checkout successful")	 
	   pom = readMavenPom file: 'pom.xml'
	   println("pom with readMavenPom" + pom) 

	if(pom.properties.'seed.version' == "1.0.11" || pom.properties.'seed.version' == "1.0.6" )
	{	 
           //Parent pom version update	 
	   println("pom.parent.version before" + pom.parent.version) 		 
           pom.parent.version="1.0.3"
	   println("pom.parent.version after " + pom.parent.version) 

	  //pom properties update	
          /*		
	   println("Properties update started") 	 

           println("pom.properties.'seed.version' before " + pom.properties.'seed.version')  	 
	   pom.properties.'seed.version'="1.0.12"	 
	   println("pom.properties.'seed.version' after " + pom.properties.'seed.version')
		
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
        println("mule-http-connector Dependency version before: " + dependency.version)
        dependency.version = "1.9.2"
        println("mule-http-connector Dependency version after: " + dependency.version)
    } 
     if (dependency.groupId == "org.mule.modules" && dependency.artifactId == "mule-apikit-module") {
        println("mule-apikit-module Dependency version before: " + dependency.version)
        dependency.version = "1.10.4"
        println("mule-apikit-module Dependency version after: " + dependency.version)	    
    }	 
    if (dependency.groupId == "org.mule.connectors" && dependency.artifactId == "mule-vm-connectors") {
        println("mule-vm-connectors Dependency version before: " + dependency.version)
        dependency.version = "2.0.1"
        println("mule-vm-connectors Dependency version after: " + dependency.version)	    
    }	 
     if (dependency.groupId == "org.mule.connectors" && dependency.artifactId == "mule-sockets-connector") {
        println("mule-sockets-connectors Dependency version before: " + dependency.version)
        dependency.version = "1.2.4"
        println("mule-sockets-connectors Dependency version after: " + dependency.version)	    
    }
     if (dependency.groupId == "com.mulesoft.connectors" && dependency.artifactId == "mule-kafka-connectors") {
        println("mule-kafka-connectors Dependency version before: " + dependency.version)
        dependency.version = "4.7.5"
        println("mule-kafka-connectors Dependency version after: " + dependency.version)	    
    }
    if (dependency.groupId == "com.mulesoft.modules" && dependency.artifactId == "mule-secure-configuration-property-module") {
        println("mule-secure-configuration-property-module Dependency version before: " + dependency.version)
        dependency.version = "1.2.7"
        println("mule-secure-configuration-property-module Dependency version after: " + dependency.version)	    
    }     
     if (dependency.groupId == "com.mulesoft.connectors" && dependency.artifactId == "mule-salesforce-connectors") {
  	println("mule-salesforce-connector Dependency version before: " + dependency.version)     
        dependency.version = "10.20.2"
        println("mule-salesforce-connector Dependency version after: " + dependency.version)	    
		}
     if (dependency.groupId == "com.mulesoft.connectors" && dependency.artifactId == "salesforce-core-common") {
        println("salesforce-core-common Dependency version before: " + dependency.version)
        dependency.version = "1.0.3"
        println("salesforce-core-common Dependency version after: " + dependency.version)	    
    }  
     if (dependency.groupId == "org.mulesoft.connectors" && dependency.artifactId == "mule.objectstore-connector") {
        println("mule-objectstore-connector Dependency version before: " + dependency.version)
        dependency.version = "1.2.2"
        println("mule-objectstore-connector Dependency version after: " + dependency.version)	    
    }  	    
	       
}	 */
		 
	   writeMavenPom model: pom 
	   println("pom with writeMavenPom" + pom)	

		
	   def filePath = '../src/main/resources/config/masking.txt'
	   writeFile file: filePath, text: ''
		def dataWeaveCode = '''%dw 2.0
		output application/json
		---
		{
			message: "Hello, DataWeave!"
		}'''
	   writeFile file: filePath, text: dataWeaveCode
	   println "DataWeave code added to ${filePath}"
       
	   
          withCredentials([string(credentialsId: 'github-token-credentials', variable: 'GITHUB_TOKEN')]) {
	      bat '''
                    git config user.email "suprabhatcs@gmail.com"
                    git config user.name "suprabhat-platform"
                    git add pom.xml
		    git add masking.txt
                    git commit -m "updated pom.xml"
                    git push https://%GITHUB_TOKEN%@github.com/%GIT_USER_NAME%/%GIT_REPO_NAME% HEAD:seed-automation_v15
                '''
	  }
	}
	else {
	  println("Seed version is not matched")		
	}
 
	 }		 
      }
    }  
  }
}
