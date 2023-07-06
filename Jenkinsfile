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
        stage('Integration tests with: maven'){
            steps{
                script{
                    sh 'mvn verify -DskipUnitTests'
                }
            }
        }
    }
}
