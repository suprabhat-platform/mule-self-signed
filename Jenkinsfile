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
		sh 'ls -ltr'
                sh 'mvn clean package'
		println("Application build successful")
        }
      }
    }	  
    stage('Build image') {
      steps{
        script {
          dockerImage = docker.build dockermule2
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
