pipeline {
    agent any

    parameters {
        string 'DEPLOY_ARTIFACT_ID'
    }

    stages {
        stage('Deploy artifact') {
            steps {
                echo "Deploying artifact ID: ${params.DEPLOY_ARTIFACT_ID}"
            }
        }
        stage('Register deployed artifact') {
            steps {
                registerDeployedArtifactMetadata(
                    artifactId: params.DEPLOY_ARTIFACT_ID,
                    targetEnvironment: "dora-env"
                )
            }
        }
    }
}
