pipeline {

  environment {
    dockerimagename = "suprabhatcs/dockermule2"
    dockerImage = ""
  }

  agent any

  stages {

    stage('Checkout Source') {
      steps {
        git 'https://github.com/suprabhat-platform/mule-self-signed.git'
		println("Checkout successful")
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
	 bat 'docker build -t suprabhatcs/dockermule2 .'
          //dockerImage = docker.build dockermule
	   println("Docker build successful")
        }
      }
    }

    stage('Pushing Image') {
      environment {
               registryCredential = 'dockerhub-credentials'
           }
      steps{
        script {
	  println("Image push started")	
	  // docker.withRegistry('https://index.docker.io/v1/', registryCredential) 
	   def dockerImage = docker.image("suprabhatcs/dockermule2")
           docker.withRegistry( 'https://registry.hub.docker.com', registryCredential ) 
	   {
           dockerImage.push("latest")
	    println("Image push successfull")
          }
        }
      }
    }

    stage('Deploying Mule container to Kubernetes') {
      steps {
        script {
          kubernetesDeploy(configs: "deployment.yaml", "service.yaml")
		  println("Deployment successfull")
        }
      }
    }

  }

}
