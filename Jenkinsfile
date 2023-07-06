pipeline{
    agent any
    stages{
        stage('git check out'){
            steps{
                git branch: 'main', url: 'https://github.com/saikumarpinisetti3/mrdevops_java_app.git'
            }
        }

        stage('unit testing:MAVEN'){
            steps{
                script{
                        sh 'mvn test'
                }
            }
        }
        stage('integration test with maven'){
            steps{
                script{
                    sh 'mvn verify -DskipUnitTests'
                }
            }
        }
        stage('static code  analysis:sonarqube'){
            steps{
                script{
                        withSonarQubeEnv(credentialsId: 'devops') {
                           sh 'mvn clean package sonar:sonar' 
                        }
                }
            }
        }
        stage('qualitygate analysis'){
            steps{
                script{
                    waitForQualityGate abortPipeline: false, credentialsId: 'devops'
                    
                }
            }
        }
        stage('creating the Maven build :MAVEN'){
            steps{
                script{
                    sh 'mvn clean install'
                }
            }
        }
    }
}
