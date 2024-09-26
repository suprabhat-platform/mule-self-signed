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
           git checkout -b seed-automation_v300
	   '''
	   println("Application feature branch checkout successful")	 
	   pom = readMavenPom file: 'pom.xml'
	   println("pom with readMavenPom" + pom) 
  
		 	 
           //Parent pom version update	 
	   println("pom.parent.version before" + pom.parent.version) 		 
           pom.parent.version="1.0.3"
	   println("pom.parent.version after " + pom.parent.version) 

	  //pom properties update	
          		
	   println("Properties update started") 	 

	   println("pom.properties.seed.version before " + pom.properties.'seed.version') 
      	   pom.properties.'seed.version'="1.0.7"	   
	   println("pom.properties.seed.version after " + pom.properties.'seed.version')	
		
           println("Properties update completed") 
		  
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
                    git push https://%GITHUB_TOKEN%@github.com/%GIT_USER_NAME%/%GIT_REPO_NAME% HEAD:seed-automation_v300
                '''
	  }
	 }		 
      }
    }  
  }
}
