pipeline{

    agent any

    parameters{
        choice(name: 'action', choices: 'create\ndestroy', description: 'choose create/destroy') 
    }

    stages{

        stage('git checkout'){
             when{expression{params.action == 'create'}
            }
        steps{
            script{
                git branch: 'main', url: 'https://github.com/saikumarpinisetti3/mrdevops_java_app.git'

             }
         }
     }
     stage('Unit testing'){
         when{expression{params.action == 'create'}
           }   
        steps{
            script{
                sh 'mvn clean   '
            }
        }
     }
     stage('integration testing'){
         when{expression{params.action == 'create'}
              }
        steps{
            script{
                    sh 'mvn verify -DskipUnitTests'
            }
        }
     }
     stage('static code analysis'){
        when{expression{params.action == 'create'}
              }
        steps{
            script{
                    withSonarQubeEnv(credentialsId: 'sonarqube') {
                        sh 'mvn clean package sonar:sonar'
                    }
            }
        }
     }
     stage('waitfor qualitygate'){
        when{expression{params.action == 'create'}
              }
        steps{
            script{
                waitForQualityGate abortPipeline: false, credentialsId: 'sonarqube'
            }
        }
     }
         stage('Maven build:maven'){
                when{expression{params.action == 'create'}
            }
        steps{
            script{
                      sh 'mvn clean install'
            }
        }
     }
    }
}
