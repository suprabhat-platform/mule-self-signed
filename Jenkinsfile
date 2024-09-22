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
                    // Checkout the repository and create a new branch
                    git 'https://github.com/suprabhat-platform/mule-self-signed.git'
                    println("Application master checkout successful")

                    bat '''
                        git checkout -b seed-automation_v98
                    '''
                    println("Application feature branch checkout successful")

                    // Load the pom.xml file as text
                    def pomFile = readFile file: 'pom.xml'
                    def pom = new XmlParser().parseText(pomFile)
                    
                    // Update the parent version
                    def parentVersion = pom.parent.version.text()
                    println("Parent version before: " + parentVersion)

                    if (parentVersion != "1.0.3") {
                        pom.parent.version[0].value = '1.0.3'
                        println("Parent version updated to: 1.0.3")
                    }

                    // Update the seed.version property
                    def seedVersion = pom.properties.'seed.version'.text()
                    println("Seed version before: " + seedVersion)

                    if (seedVersion == "1.0.6" || seedVersion == "1.0.11") {
                        pom.properties.'seed.version'[0].value = seedVersion == "1.0.6" ? "1.0.7" : "1.0.12"
                        println("Seed version updated to: " + pom.properties.'seed.version'.text())
                    }

                    // Update the 'mule-http-connector' dependency
                    pom.dependencies.dependency.findAll {
                        it.groupId.text() == 'org.mule.connectors' && it.artifactId.text() == 'mule-http-connector'
                    }.each {
                        println("Updating mule-http-connector version from " + it.version.text() + " to 1.9.2")
                        it.version[0].value = '1.9.2'
                    }

                    // Remove the 'mule-latency-connector' dependency
                    def toRemove = pom.dependencies.dependency.find {
                        it.groupId.text() == 'com.mulesoft.modules' && it.artifactId.text() == 'mule-latency-connector'
                    }

                    if (toRemove) {
                        println("Removing mule-latency-connector dependency")
                        pom.dependencies.remove(toRemove)
                    } else {
                        println("mule-latency-connector dependency not found")
                    }

                    // Write the modified pom.xml back to the file
                    def newPomContent = groovy.xml.XmlUtil.serialize(pom)
                    writeFile file: 'pom.xml', text: newPomContent

                    println("POM updated successfully!")

                    // Commit and push the changes to GitHub
                    withCredentials([string(credentialsId: 'github-token-credentials', variable: 'GITHUB_TOKEN')]) {
                        bat '''
                            git config user.email "suprabhatcs@gmail.com"
                            git config user.name "suprabhat-platform"
                            git add pom.xml
                            git commit -m "Updated pom.xml with specific changes"
                            git push https://%GITHUB_TOKEN%@github.com/%GIT_USER_NAME%/%GIT_REPO_NAME% HEAD:seed-automation_v98
                        '''
                    }
                }
            }
        }
    }
}
