pipeline {
    agent any
    environment {
        ARTIFACTORY_CREDS = credentials('my-artifactory-creds')
        DOCKER_IMAGE_NAME = 'krishnademo.jfrog.io/default-docker-local/krishna-pet-clinic'
    }
    stages {
        stage ('Build') {
            steps {
              sh './mvnw clean package -DskipTests=true'
            }
        }

//         stage ('Unit tests') {
//             steps {
//               sh './mvnw test'
//             }
//             post {
//                 success {
//                     junit 'target/surefire-reports/**/*.xml'
//                 }
//             }
//         }

        stage ('Package') {
            steps {
              sh "/usr/local/bin/docker login -u $ARTIFACTORY_CREDS_USR -p $ARTIFACTORY_CREDS_PSW  krishnademo.jfrog.io"
              sh "/usr/local/bin/docker build . -t $DOCKER_IMAGE_NAME && /usr/local/bin/docker push $DOCKER_IMAGE_NAME"
              //sh "./run.sh"
            }
        }
        stage ('Run') {
            steps {
              sh "chmod 755 run.sh"
              sh "./run.sh"
            }
        }
    }
}
