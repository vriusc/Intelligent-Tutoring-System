pipeline {

    agent any

    environment {
        registry = "xiaochili123/tomato-front-pro"
        registryCredentials = "dockerhub"
    }

    

        stage('BUILD DOCKER IMAGE'){
            steps {
                script {
                    dockerImage = docker.build registry + ":V$BUILD_NUMBER"
                }
            }
        }

        stage('UPLOAD IMAGE'){
            steps{
                script {
                    docker.withRegistry('',registryCredentials){
                        dockerImage.push("V$BUILD_NUMBER")
                        dockerImage.push("latest")
                    }
                }
            }
        }

        stage("REMOVE DOCKER IMAGE"){
            steps{
                sh "docker rmi $registry:V$BUILD_NUMBER"
            }
        }

        stage("KUBERNETES DEPLOY"){
            agent {label 'KOPS'}
            steps{
                sh "helm upgrade --install --force vprofile-stack helm/tomatocharts --set appimage=${registry}:V${BUILD_NUMBER} --namespace prod"
            }
        }
    }
}
