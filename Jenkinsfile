pipeline {
    agent any
    
    environment {
        DOCKER_REGISTRY = "23127206"
        IMAGE_NAME = "yas-all-in-one"
        // Lấy mã Commit ID
        COMMIT_ID = sh(script: 'git rev-parse --short HEAD', returnStdout: true).trim()
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build & Push All-in-one Image') {
            steps {
                script {
                    echo "Đang build Image với tag: ${COMMIT_ID}"
                    
                    withCredentials([usernamePassword(credentialsId: 'docker-hub-creds', 
                                     passwordVariable: 'DOCKER_PASS', 
                                     usernameVariable: 'DOCKER_USER')]) {
                        
                        //Đăng nhập Docker Hub
                        sh 'echo \$DOCKER_PASS | docker login -u \$DOCKER_USER --password-stdin'
                        
                        //Build 1 image duy nhất chứa toàn bộ 19 file JAR
                        sh "docker build -t ${DOCKER_REGISTRY}/${IMAGE_NAME}:${COMMIT_ID} ."
                        
                        //Push image
                        sh "docker push ${DOCKER_REGISTRY}/${IMAGE_NAME}:${COMMIT_ID}"                        
                        }
                    }
                }
            }
        }
    }