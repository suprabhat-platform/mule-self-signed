pipeline {

  agent any

  stages {

    stage('Checkout Source') {
      steps {
	   println("Application checkout successful")
           git 'https://github.com/suprabhat-platform/mule-self-signed.git'
	   println("Application checkout successful")
      }
    }

 stage('Build Application') {
      steps{
        script {
	        println("Application build started")
                bat 'mvn clean package'
		println("Application build successful")
        }
      }
    }	  
    stage('Build image and Publish to DockerHub') {
    environment {
    DOCKER_IMAGE = "suprabhatcs/mule-gitops:${BUILD_NUMBER}"
    registryCredential = 'dockerhub-credentials'
     }
      steps{
        script {
	 println("Docker image build started")
	 println(DOCKER_IMAGE)
	 bat 'docker build -t %DOCKER_IMAGE% .'
	 println("Docker build successful")
	 println("Image push to DockerHub started")	
	 def dockerImage = docker.image(DOCKER_IMAGE)
         docker.withRegistry( 'https://registry.hub.docker.com', registryCredential ) 
	 {
            dockerImage.push()
	    println("Image push to DockerHub successfull")
          }
        }
      }
    }

   stage('Update Deployment File') {
        environment {
            GIT_REPO_NAME = "mule-self-signed"
            GIT_USER_NAME = "suprabhat-platform"
	    DOCKER_IMAGE = "suprabhatcs/mule-gitops:${BUILD_NUMBER}"
        }
     steps {
            withCredentials([string(credentialsId: 'github-token-credentials', variable: 'GITHUB_TOKEN')]) {
		println("Update manifests in GitHub started")   
               script {
		def buildNumber = env.BUILD_NUMBER    
		println(DOCKER_IMAGE)
		def deploymentYml = readFile('manifests/deployment.yaml').replaceAll(/(image:\s*).*/, "\$1${DOCKER_IMAGE}")
                writeFile file: 'manifests/deployment.yaml', text: deploymentYml    
                bat '''
                    git config user.email "suprabhatcs@gmail.com"
                    git config user.name "suprabhat-platform"
                    git add manifests/deployment.yaml
                    git commit -m "Update deployment image to version %BUILD_NUMBER%"
                    git push https://%GITHUB_TOKEN%@github.com/%GIT_USER_NAME%/%GIT_REPO_NAME% HEAD:master
                '''
	       }       
		 println("Update manifests in GitHub successfull")
            }
        }
     }	  
  }
}
