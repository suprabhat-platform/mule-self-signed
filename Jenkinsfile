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
           git checkout -b seed-automation_v97
	   '''
	   println("Application feature branch checkout successful")	 
	   pom = readMavenPom file: 'pom.xml'
	   println("pom with readMavenPom" + pom) 
  
	   def isSfSeedVersion = false		 
	     pom.dependencies.each { dependency ->
	       if (dependency.groupId == "com.mulesoft.connectors" && dependency.artifactId == "mule-salesforce-connectors") {
	          isSfSeedVersion = true
	      } 
	    }	 
	    println("isSfSeedVersion " + isSfSeedVersion) 
		 
	if(pom.properties.'seed.version' == "1.0.11" || pom.properties.'seed.version' == "1.0.6" )
	{	 
           //Parent pom version update	 
	   println("pom.parent.version before" + pom.parent.version) 		 
           pom.parent.version="1.0.3"
	   println("pom.parent.version after " + pom.parent.version) 

	  //pom properties update	
          		
	   println("Properties update started") 	 

	   println("pom.properties.seed.version before " + pom.properties.'seed.version') 
           if((pom.properties.'seed.version' == "1.0.6") && isSfSeedVersion)	
      	   pom.properties.'seed.version'="1.0.7"
	   else 
	   pom.properties.'seed.version'="1.0.12"	   
	   println("pom.properties.seed.version after " + pom.properties.'seed.version')	
		
           println("Properties update completed") 
		 
           //pom dependencies update
	  // Iterate through dependencies
       pom.dependencies.each { dependency ->
       if (dependency.groupId == "org.mule.connectors" && dependency.artifactId == "mule-http-connector") {
        println("mule-http-connector Dependency version before: " + dependency.version)
        dependency.version = "1.9.2"
        println("mule-http-connector Dependency version after: " + dependency.version)
    }     	       
}	 
		// Remove a specific dependency
	def dependencyToRemove = pom.dependencies.find { dependency ->
	    dependency.groupId == "com.mulesoft.modules" && dependency.artifactId == "mule-latency-connector"
	}
	
	if (dependencyToRemove) {
	    println("Removing mule-latency-connector dependency...")
	    pom.dependencies.remove(dependencyToRemove)
	    println("mule-latency-connector dependency removed.")
	} else {
	    println("mule-latency-connector dependency not found.")
	}	 
	   writeMavenPom model: pom 
	   println("pom with writeMavenPom" + pom)	

		



	
    withCredentials([string(credentialsId: 'github-token-credentials', variable: 'GITHUB_TOKEN')]) {
	      bat '''
                    git config user.email "suprabhatcs@gmail.com"
                    git config user.name "suprabhat-platform"
                    git add .
		    //git add src/main/resources/config/masking.txt
		    //git add external-properties/config-dev.yaml
                    git commit -m "updated pom.xml"
                    git push https://%GITHUB_TOKEN%@github.com/%GIT_USER_NAME%/%GIT_REPO_NAME% HEAD:seed-automation_v97
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
