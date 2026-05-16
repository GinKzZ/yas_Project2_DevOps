pipeline {
    agent any
    
    environment {
        DOCKER_REGISTRY = "23127206"
        IMAGE_NAME = "yas-all-in-one"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build & Push All-in-one Image') {
            // Điều kiện nếu chỉ thay đổi ở k8s thì không cần build image
            when {
                changeset pattern: '^(?!k8s/).*', comparator: 'REGEXP'
            }
            steps {
                script {
                    def commitId = sh(script: 'git rev-parse --short HEAD', returnStdout: true).trim()
                    echo "Phát hiện thay đổi ngoài thư mục k8s. Bắt đầu build Image với tag: ${commitId}"
                    
                    withCredentials([usernamePassword(credentialsId: 'docker-hub-creds', 
                                                     passwordVariable: 'DOCKER_PASS', 
                                                     usernameVariable: 'DOCKER_USER')]) {
                        
                        sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
                        sh "docker build -t ${DOCKER_REGISTRY}/${IMAGE_NAME}:${commitId} ."
                        sh "docker push ${DOCKER_REGISTRY}/${IMAGE_NAME}:${commitId}"
                        sh "docker rmi ${DOCKER_REGISTRY}/${IMAGE_NAME}:${commitId}"
                    }
                }
            }
        }
    }
    
    post {
        always {
            sh 'docker logout'
        }
    }
}