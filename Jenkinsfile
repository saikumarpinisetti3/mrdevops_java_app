pipeline{

    agent any
    stages{
        stage('git checkout'){
        steps{
            script{
                git branch: 'main', url: 'https://github.com/saikumarpinisetti3/mrdevops_java_app.git'

             }
         }
     }
        stage('Unit testing'){
        steps{
            script{
                sh 'mvn test'
            }
        }
     }
         stage('integration testing'){
        steps{
            script{
                    sh 'mvn verify -DskipUnitTests'
            }
        }
     }
    }
}
