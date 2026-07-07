pipeline {
    agent any
    environment {
        REGISTRY = "docker.io"
        IMAGE_NAME = "guangqi99/rnaseq-pipeline"
        TAG = "${env.BUILD_NUMBER}"
        DOCKER_CREDS = credentials('dockerhub-token')
    }
    stages {
        stage('Checkout Code') {
            steps {
                git(
                    branch: 'main',
                    url: 'https://github.com/guangguangqi/rna-pipeline'
                )
            }
        }
        stage('Build & Push Container') {
            steps {
                sh "echo \${DOCKER_CREDS_PSW} | docker login -u \${DOCKER_CREDS_USR} --password-stdin"
                sh "docker build -t \${REGISTRY}/\${IMAGE_NAME}:\${TAG} ."
                sh "docker push \${REGISTRY}/\${IMAGE_NAME}:\${TAG}"
            }
        }

        stage('Deploy Workflow to Minikube') {
            steps {
                // Tells Snakemake to run rule pods safely inside Minikube with 1 core and 1.5GB RAM
                sh """
                snakemake --executor kubernetes \
                  --container-image ${REGISTRY}/${IMAGE_NAME}:${TAG} \
                  --jobs 1 \
                  --cores 1 \
                  --set-resources star_align:mem_mb=1500 fastqc:mem_mb=1000 \
                  --set-threads star_align=1 fastqc=1
                """
            }
        }
    }
}

