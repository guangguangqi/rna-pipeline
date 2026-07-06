pipeline {
    agent any
    environment {
        REGISTRY = "docker.io"
        IMAGE_NAME = "guangqi99/rnaseq-pipeline"
        TAG = "${env.BUILD_NUMBER}"
        // Securely stores your dockerhub login details in Jenkins
        DOCKER_CREDS = credentials('dockerhub-login')
    }
    stages {
        stage('Checkout Code') {
            steps {
                git(
                    branch: 'main',
                    url: 'https://github.com'
                )
            }
        }
        stage('Build & Push Container') {
            steps {
                sh "echo ${DOCKER_CREDS_PSW} | docker login -u ${DOCKER_CREDS_USR} --password-stdin"
                sh "docker build -t ${REGISTRY}/${IMAGE_NAME}:${TAG} ."
                sh "docker push ${REGISTRY}/${IMAGE_NAME}:${TAG}"
            }
        }
        stage('Deploy Workflow to Minikube') {
            steps {
                // Tells Snakemake to run rule pods inside your local laptop Kubernetes node
                sh """
                snakemake --executor kubernetes \
                  --container-image ${REGISTRY}/${IMAGE_NAME}:${TAG} \
                  --jobs 4 \
                  --default-resources mem_mb=4000 disk_mb=10000
                """
            }
        }
    }
}

