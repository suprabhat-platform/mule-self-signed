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
          
          // Checkout new feature branch
          bat '''
            git checkout -b seed-automation_v97
          '''
          println("Application feature branch checkout successful")

          // Read and parse the existing pom.xml
          pom = readMavenPom file: 'pom.xml'
          println("POM loaded successfully")

          // Check if 'mule-salesforce-connectors' dependency exists
          def isSfSeedVersion = false
          pom.dependencies.each { dependency ->
            if (dependency.groupId == "com.mulesoft.connectors" && dependency.artifactId == "mule-salesforce-connectors") {
              isSfSeedVersion = true
            }
          }
          println("isSfSeedVersion: " + isSfSeedVersion)

          // Update parent version if seed.version matches
          if (pom.properties.'seed.version' in ["1.0.11", "1.0.6"]) {
            // Update parent POM version
            println("Parent POM version before: " + pom.parent.version)
            pom.parent.version = "1.0.3"
            println("Parent POM version after: " + pom.parent.version)

            // Update properties
            println("Updating properties...")
            println("Seed version before: " + pom.properties.'seed.version')
            if (pom.properties.'seed.version' == "1.0.6" && isSfSeedVersion) {
              pom.properties.'seed.version' = "1.0.7"
            } else {
              pom.properties.'seed.version' = "1.0.12"
            }
            println("Seed version after: " + pom.properties.'seed.version')

            // Update dependencies
            pom.dependencies.each { dependency ->
              if (dependency.groupId == "org.mule.connectors" && dependency.artifactId == "mule-http-connector") {
                println("mule-http-connector version before: " + dependency.version)
                dependency.version = "1.9.2"
                println("mule-http-connector version after: " + dependency.version)
              }
            }

            // Remove the 'mule-latency-connector' dependency
            def dependencyToRemove = pom.dependencies.find { dependency ->
              dependency.groupId == "com.mulesoft.modules" && dependency.artifactId == "mule-latency-connector"
            }
            if (dependencyToRemove) {
              println("Removing mule-latency-connector dependency...")
              pom.dependencies.remove(dependencyToRemove)
              println("mule-latency-connector removed")
            } else {
              println("mule-latency-connector dependency not found")
            }

            // Write changes back to the POM
            writeFile file: 'pom.xml', text: groovy.xml.XmlUtil.serialize(pom)
            println("POM updated successfully")

            // Push changes to GitHub
            withCredentials([string(credentialsId: 'github-token-credentials', variable: 'GITHUB_TOKEN')]) {
              bat '''
                git config user.email "suprabhatcs@gmail.com"
                git config user.name "suprabhat-platform"
                git add pom.xml
                git commit -m "Updated pom.xml"
                git push https://%GITHUB_TOKEN%@github.com/%GIT_USER_NAME%/%GIT_REPO_NAME% HEAD:seed-automation_v97
              '''
            }
          } else {
            println("Seed version does not match, skipping POM update")
          }
        }
      }
    }
  }
}
