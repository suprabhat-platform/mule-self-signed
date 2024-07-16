pipeline {

  environment {
    dockerimagename = "suprabhatcs/dockermule"
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
	 bat 'docker build -t dockermule .'
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
          docker.withRegistry( 'https://registry.hub.docker.com', registryCredential ) {
            dockerImage.push("latest")
			println("Docker image push successfull")
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
