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
                    println("Application master checkout successful")

                    // Create and switch to the new branch
                    bat 'git checkout -b seed-automation_v109'
                    println("Application feature branch checkout successful")

                    // Define the path to the pom.xml file
                    def pomFile = "${env.WORKSPACE}/pom.xml"

                    // Parse the POM file
                    def pom = new XmlParser().parse(pomFile)

                        println("Updating Parent Version and Seed Version")

                        // Update parent version
                        println("Parent version before: " + pom.parent.version.text())
                        pom.parent.version[0].value = '1.0.3'
                        println("Parent version after: " + pom.parent.version.text())

                        // Update seed version based on conditions
                        if (seedVersion == "1.0.6" && pom.dependencies.dependency.find {
                            it.groupId.text() == "com.mulesoft.connectors" &&
                            it.artifactId.text() == "mule-salesforce-connectors"
                        }) {
                            seedVersionNode.value = '1.0.7'
                        } else {
                            seedVersionNode.value = '1.0.12'
                        }
                        println("Updated seed version: " + seedVersionNode.text())

                        // Update dependency version for mule-http-connector
                        pom.dependencies.dependency.findAll {
                            it.groupId.text() == "org.mule.connectors" &&
                            it.artifactId.text() == "mule-http-connector"
                        }.each {
                            println("mule-http-connector version before: " + it.version.text())
                            it.version[0].value = '1.9.2'
                            println("mule-http-connector version after: " + it.version.text())
                        }

                        // Remove mule-latency-connector dependency
                        def latencyConnector = pom.dependencies.dependency.find {
                            it.groupId.text() == "com.mulesoft.modules" &&
                            it.artifactId.text() == "mule-latency-connector"
                        }
                        if (latencyConnector) {
                            pom.dependencies[0].remove(latencyConnector)
                            println("mule-latency-connector dependency removed.")
                        } else {
                            println("mule-latency-connector dependency not found.")
                        }

                        // Write the updated pom.xml back
                        def writer = new FileWriter(pomFile)
                        def xmlOutput = new XmlNodePrinter(new PrintWriter(writer))
                        xmlOutput.setPreserveWhitespace(true)
                        xmlOutput.print(pom)
                        writer.close()

                        println("Updated pom.xml written successfully.")

                        // Push the changes to the repository
                        withCredentials([string(credentialsId: 'github-token-credentials', variable: 'GITHUB_TOKEN')]) {
                            bat '''
                                git config user.email "suprabhatcs@gmail.com"
                                git config user.name "suprabhat-platform"
                                git add pom.xml
                                git commit -m "Updated pom.xml with specific attributes"
                                git push https://%GITHUB_TOKEN%@github.com/%GIT_USER_NAME%/%GIT_REPO_NAME% HEAD:seed-automation_v109
                            '''
                        }
                }
            }
        }
    }
}
