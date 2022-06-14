pipeline {
    agent any 
    environment {
       DOCKER = tool 'docker' 
       DOCKER_EXEC = '$DOCKER/docker'
       SCA = '/Users/clagosu/Documents/dependency-check/bin/dependency-check.sh'
    }
    stages {
      
      stage('Git') {
         steps {
            checkout scm // clonacion de codigo en nodo
         }
      }
        
      stage('Build') {
         steps {
            echo '************** BUILD **************'
            sh 'set +x; chmod 777 gradlew'
            sh './gradlew clean build'
          //archiveArtifacts artifacts: "build/libs/testing-web-*.jar"
         }
      }
        
      stage('SAST') {
         steps {
            withCredentials([string(credentialsId: 'sonarcloud', variable: 'SONARPAT')]) {
                 echo '************** SAST SONARCLOUD **************'
                 sh('set +x; ./gradlew sonarqube -Dsonar.login=$SONARPAT -Dsonar.branch.name=feature-jenkins')
            }
         }
      }
        
      stage('SCA') {
        steps {
            sh "$SCA --project 'spring-clinic' --scan '${WORKSPACE}/build/libs/spring-petclinic-2.6.0.jar'"
            sh "./gradlew cyclonedxBom -info"
        }
     }
        
      stage('Build Image') {
         steps {
            echo '************** BUILD IMAGE **************'
          //sh '${DOCKER EXEC} build .'
            sh "$DOCKER_EXEC images"
          //sh "$DOCKER_EXEC push clagosu/spring-clinic:$currentBuild.number"
            }
        }
   }
}

