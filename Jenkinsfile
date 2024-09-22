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
                    bat 'git checkout -b seed-automation_v152'
                    echo "Application feature branch checkout successful"

                    def xmlContent = readFile('pom.xml')
                    def pom = new XmlParser().parseText(xmlContent)
                    println("pom.parent "+ pom.parent)
                    if(pom.parent != null) {
                    pom.parent.version[0].setValue = "1.0.3"
                    }

                   // pom.properties.'seed.version'[0].setValue = "1.0.12"

                    echo "Updated pom.xml written successfully."

                    // Push the changes to the repository
                    withCredentials([string(credentialsId: 'github-token-credentials', variable: 'GITHUB_TOKEN')]) {
                        bat '''
                            git config user.email "suprabhatcs@gmail.com"
                            git config user.name "suprabhat-platform"
                            git add pom.xml
                            git commit -m "Updated pom.xml with specific attributes"
                            git push https://%GITHUB_TOKEN%@github.com/%GIT_USER_NAME%/%GIT_REPO_NAME% HEAD:seed-automation_v152
                        '''
                    }
                }
            }
        }
    }
}
