pipeline {

  environment {
    dockerImage = ""
  }

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
      steps{
        script {
	 println("Docker image build started")
	 bat 'docker build -t suprabhatcs/dockermule2:${BUILD_NUMBER} .'
	 println("Docker build successful")
        }
      }
    }
    stage('Push Image to DockerHub') {
      environment {
                  registryCredential = 'dockerhub-credentials'
                  }
      steps{
        script {
	  println("Image push to DockerHub started")	
	   def dockerImage = docker.image("suprabhatcs/dockermule2:${BUILD_NUMBER}")
           docker.withRegistry( 'https://registry.hub.docker.com', registryCredential ) 
	   {
           dockerImage.push("latest")
	    println("Image push to DockerHub successfull")
          }
        }
      }
    }
  }
}
