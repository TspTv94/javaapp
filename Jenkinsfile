pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "simple-java-app"
        DOCKER_TAG = "latest"
        DOCKER_CONTAINER_NAME = "java-app"
        PORT = "9090"

        AWS_REGION = "ap-south-1"
        ECR_REGISTRY = "434748505869.dkr.ecr.ap-south-1.amazonaws.com"
        ECR_REPO = "simple-java-app"
    }

    stages {

        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/TspTv94/javaapp.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh "docker build -t ${DOCKER_IMAGE}:${DOCKER_TAG} ."
            }
        }

        stage('Stop Old Container') {
            steps {
                sh '''
                if [ "$(docker ps -aq -f name=${DOCKER_CONTAINER_NAME})" ]; then
                  docker rm -f ${DOCKER_CONTAINER_NAME}
                fi
                '''
            }
        }

        stage('Run Container') {
            steps {
                sh "docker run -d -p ${PORT}:${PORT} --name ${DOCKER_CONTAINER_NAME} ${DOCKER_IMAGE}:${DOCKER_TAG}"
            }
        }

        stage('Login to ECR') {
            steps {
                sh '''
                aws ecr get-login-password --region ${AWS_REGION} | \
                docker login --username AWS --password-stdin ${ECR_REGISTRY}
                '''
            }
        }

        stage('Tag & Push to ECR') {
            steps {
                sh '''
                docker tag ${DOCKER_IMAGE}:${DOCKER_TAG} \
                ${ECR_REGISTRY}/${ECR_REPO}:${DOCKER_TAG}

                docker push ${ECR_REGISTRY}/${ECR_REPO}:${DOCKER_TAG}
                '''
            }
        }

        stage('Cleanup Old Images') {
            steps {
                sh "docker image prune -f"
            }
        }
    }

    post {
        always {
            echo 'Pipeline finished'
        }
    }
}

