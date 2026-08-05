pipeline {
    agent any

    stages {
        stage('Hello') {
            steps {
                echo 'Hello World'
                sh 'echo "This is my archive" > archive.txt'
                archiveArtifacts artifacts: 'archive.txt', followSymlinks: false
            }
        }
        stage('Register build artifact') {
            steps {
                script {
                    env.ARTIFACT_ID = registerBuildArtifactMetadata(
                        name: "my-artifact",
                        version: "1.0.0",
                        url: "https://test.com/dse-team-amer/archive.txt"
                    )
                }
            }
        }
        stage('Run Deploy artifact downstream') {
            steps {
                build job: 'build_deploy_no_scm/test2', 
                    parameters: [
                        string(name: 'DEPLOY_ARTIFACT_ID', value: env.ARTIFACT_ID)
                    ]
            }
        }
    }
}
