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
    stage('Build image') {
    environment {
    DOCKER_IMAGE = "suprabhatcs/dockermule:${BUILD_NUMBER}"
    registryCredential = 'dockerhub-credentials'
     }
      steps{
        script {
	 println("Docker image build started")
	 bat 'docker build -t suprabhatcs/dockermule2 .'
	 println("Docker build successful")
	 println("Image push to DockerHub started")	
	 def dockerImage = docker.image("${DOCKER_IMAGE}")
         docker.withRegistry( 'https://registry.hub.docker.com', registryCredential ) 
	 {
            dockerImage.push()
	    println("Image push to DockerHub successfull")
          }
        }
      }
    }
  }
}
