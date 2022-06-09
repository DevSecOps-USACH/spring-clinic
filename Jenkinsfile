pipeline {
    agent any 
    environment {
       DOCKER = tool 'docker' 
       DOCKER_EXEC = '$DOCKER/docker'
    }
    stages {
      
      stage('Git') {
         steps {
            checkout scm // clonacion de codigo en nodo
         }
      }
        
      stage('Build') {
         steps {
            sh 'chmod 777 gradlew'
          //sh './gradlew clean build'
          //archiveArtifacts artifacts: "build/libs/testing-web-*.jar"
         }
      }
        
      stage('Code Quality') {
         steps {
            withCredentials([string(credentialsId: 'sonarcloud', variable: 'SONARPAT')]) {
                 sh('set -x; ./gradlew sonarqube -Dsonar.login=$SONARPAT -Dsonar.branch.name=feature-jenkins')
            }
            echo "$DOCKER"
            echo "$currentBuild.number"
         }
      }
        
      stage('Image Build') {
         steps {
          //sh '${DOCKER EXEC} build .'
            sh "$DOCKER_EXEC images"
          //sh "$DOCKER_EXEC push clagosu/spring-clinic:$currentBuild.number"
            }
        }
        
      stage('Deploy') {
        steps {
            echo "Hello"
        }
     }
   }
}

