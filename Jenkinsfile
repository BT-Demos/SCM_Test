
pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                echo 'Building the application...'
                sleep 3
            }
        }
        stage('Registering build artifact') {
            steps {
                script {
                    echo 'Registering the metadata'
                    def artifactId = registerBuildArtifactMetadata(
                        name: "My TestApp",
                        version: "1.0.0",
                        type: "docker",
                        url: "http://localhost:1112",
                        digest: "6u637064707039346163693930",
                        label: "pre-prod"
                    )
                    echo "Artifact Id is: ${artifactId}"
                    env.ARTIFACT_ID = artifactId
                    sleep 3
                }
            }
        }
        stage('Deploy to Preprod') {
            steps {
                echo 'Deploying...'
                registerDeployedArtifactMetadata(
                    artifactId: "${env.ARTIFACT_ID}",
                    targetEnvironment: "pre-prod",
                    labels: "pre-prod"
                )
            }
        }
        stage('Deploy to QA') {
            steps {
                echo 'Deploying...'
                registerDeployedArtifactMetadata(
                    artifactId: "${env.ARTIFACT_ID}",
                    targetEnvironment: "qa",
                    labels: "qa"
                )
            }
        }
    }
}
