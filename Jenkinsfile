pipeline{

    agent any
    stages{
        stage('gitcheckout:GIT'){
                steps{
                    script{
                       git branch: 'main', url: 'https://github.com/saikumarpinisetti3/mrdevops_java_app.git'
                    }
                }

        }
         stage('sonar'){
            steps{
                script{
                    withSonarQubeEnv(credentialsId: 'sonaq') {
                        sh 'mvn clean package sonar:sonar'
            }
                }
            }
        }
        stage('cleaning packages:MVN'){
            steps{
            script{
                sh 'mvn clean'
            }
        }
        }

        stage(' packages:MVN'){
            steps{

            script{
                sh 'mvn clean package'
            }
        }
        }
        stage('maven build'){
            steps{
                script{
                    sh 'mvn clean install'
                }
            }
        }
    }

}
