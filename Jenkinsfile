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
                    // Checkout the repository
                    git 'https://github.com/suprabhat-platform/mule-self-signed.git'
                    echo "Application master checkout successful"

                    // Create and switch to the new branch
                    bat 'git checkout -b seed-automation_v113'
                    echo "Application feature branch checkout successful"

                    // Define the path to the pom.xml file
                    def pomFile = "${env.WORKSPACE}/pom.xml"

                    // Parse the POM file
                    def pom = new XmlParser().parse(pomFile)

                    // Update Parent Version
                    echo "Updating Parent Version"

                    // Update parent version
                    def parentVersionNode = pom.parent.version[0]
                    echo "Parent version before: ${parentVersionNode.text()}"
                    parentVersionNode.value = '1.0.3' // Set the new parent version
                    echo "Parent version after: ${parentVersionNode.text()}"

                    // Update seed version based on conditions
                    def seedVersionNode = pom.properties.'seed.version'[0] // Access the seed version
                    def currentSeedVersion = seedVersionNode.text()

                    if (currentSeedVersion == "1.0.6" && pom.dependencies.dependency.find {
                        it.groupId.text() == "com.mulesoft.connectors" &&
                        it.artifactId.text() == "mule-salesforce-connectors"
                    }) {
                        seedVersionNode.value = '1.0.7'
                    } else {
                        seedVersionNode.value = '1.0.12'
                    }
                    echo "Updated seed version: ${seedVersionNode.text()}"

                    // Update dependency version for mule-http-connector
                    pom.dependencies.dependency.findAll {
                        it.groupId.text() == "org.mule.connectors" &&
                        it.artifactId.text() == "mule-http-connector"
                    }.each { dep ->
                        def httpConnectorVersionNode = dep.'version'[0] // Use quotes for property access
                        if (httpConnectorVersionNode) {
                            echo "mule-http-connector version before: ${httpConnectorVersionNode.text()}"
                            httpConnectorVersionNode.value = '1.9.2'
                            echo "mule-http-connector version after: ${httpConnectorVersionNode.text()}"
                        } else {
                            echo "mule-http-connector version node not found."
                        }
                    }

                    // Remove mule-latency-connector dependency
                    def latencyConnector = pom.dependencies.dependency.find {
                        it.groupId.text() == "com.mulesoft.modules" &&
                        it.artifactId.text() == "mule-latency-connector"
                    }
                    if (latencyConnector) {
                        pom.dependencies[0].remove(latencyConnector)
                        echo "mule-latency-connector dependency removed."
                    } else {
                        echo "mule-latency-connector dependency not found."
                    }

                    // Write the updated pom.xml back
                    def writer = new FileWriter(pomFile)
                    def xmlOutput = new XmlNodePrinter(new PrintWriter(writer))
                    xmlOutput.setPreserveWhitespace(true)
                    xmlOutput.print(pom)
                    writer.close()

                    echo "Updated pom.xml written successfully."

                    // Push the changes to the repository
                    withCredentials([string(credentialsId: 'github-token-credentials', variable: 'GITHUB_TOKEN')]) {
                        bat '''
                            git config user.email "suprabhatcs@gmail.com"
                            git config user.name "suprabhat-platform"
                            git add pom.xml
                            git commit -m "Updated pom.xml with specific attributes"
                            git push https://%GITHUB_TOKEN%@github.com/%GIT_USER_NAME%/%GIT_REPO_NAME% HEAD:seed-automation_v113
                        '''
                    }
                }
            }
        }
    }
}
