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
          git 'https://github.com/suprabhat-platform/mule-self-signed.git'
          println("Application master checkout successful")
          bat '''
            git checkout -b seed-automation_v302
          '''
          println("Application feature branch checkout successful")

          // Update Parent pom version using xmlstarlet
          println("Updating parent pom version using xmlstarlet")
          bat '''
            xmlstarlet ed --inplace \
              -u "/project/parent/version" \
              -v "1.0.3" pom.xml
          '''
          println("Parent pom version updated to 1.0.3")

          // Update seed.version property using xmlstarlet
          println("Updating seed.version property using xmlstarlet")
          bat '''
            xmlstarlet ed --inplace \
              -u "/project/properties/seed.version" \
              -v "1.0.7" pom.xml
          '''
          println("seed.version property updated to 1.0.7")

          withCredentials([string(credentialsId: 'github-token-credentials', variable: 'GITHUB_TOKEN')]) {
            bat '''
              git config user.email "suprabhatcs@gmail.com"
              git config user.name "suprabhat-platform"
              git add pom.xml
              git commit -m "Updated pom.xml with xmlstarlet"
              git push https://%GITHUB_TOKEN%@github.com/%GIT_USER_NAME%/%GIT_REPO_NAME% HEAD:seed-automation_v302
            '''
          }
        }
      }
    }
  }
}
