pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "simple-java-app"
        DOCKER_TAG = "latest"
        DOCKER_CONTAINER_NAME = "java-app"
        PORT = "9090"
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/TspTv94/javaapp.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("${DOCKER_IMAGE}:${DOCKER_TAG}")
                }
            }
        }

        stage('Stop Old Container') {
            steps {
                script {
                    sh """
                    if [ \$(docker ps -q -f name=${DOCKER_CONTAINER_NAME}) ]; then
                        docker stop ${DOCKER_CONTAINER_NAME}
                        docker rm ${DOCKER_CONTAINER_NAME}
                    fi
                    """
                }
            }
        }

        stage('Run Container') {
            steps {
                script {
                    sh """
                    docker run -d -p ${PORT}:${PORT} --name ${DOCKER_CONTAINER_NAME} ${DOCKER_IMAGE}:${DOCKER_TAG}
                    """
                }
            }
        }
    }

    post {
        always {
            echo 'Pipeline finished'
        }
    }
}

