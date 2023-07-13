pipeline{

    agent any
    environment{

        ACCESS_KEY = credentials('AWS_ACCESS_KEY_ID')
        SECRET_KEY = credentials('AWS_SECRET_KEY_ID')
    }
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

         stage('pushing artifact to the nexus'){
            steps{
                script{
                    nexusArtifactUploader artifacts: 
                    [
                        [
                            artifactId: 'kubernetes-configmap-reload', 
                            classifier: '',
                             file: 'target/kubernetes-configmap-reload-0.0.1.jar',
                              type: 'jar'
                              ]
                        ], 
                        credentialsId: 'nexus',
                         groupId: 'com.minikube.sample',
                          nexusUrl: '3.7.45.84:8081',
                           nexusVersion: 'nexus3',
                            protocol: 'http', 
                            repository: 'maven',
                             version: '0.0.1'
                }
            }
        }

       stage('docker image build') {
    steps {
        script {
            sh 'docker build -t miniapp:V1 .'
            sh 'docker image tag miniapp:V1 saikumarpinisetti/miniapp:latest'
            //sh 'docker image tag saikumarpinisetti/miniapp:V1 saikumarpinisetti/miniapp:version1'
        }
    }
}


        stage('docker image push'){
            steps{
                script{
                    withCredentials([usernamePassword(credentialsId: 'dockerhub', passwordVariable: 'hub', usernameVariable: 'docker')]) {
                        sh 'docker login -u ${docker} -p ${hub}'
                        sh 'docker push saikumarpinisetti/miniapp:latest'
                       // sh 'docker push saikumarpinisetti/miniapp:version1'

                    }
                }
            }
        }
        
     stage('image scanning') {
    steps {
        script {
            sh 'trivy image saikumarpinisetti/miniapp:latest > scan.txt'
            sh 'cat scan.txt'
        }
    }
}
        stage('Connect to EKS '){
        steps{
               script{
                sh """
                aws configure set aws_access_key_id "$ACCESS_KEY"
                aws configure set aws_secret_access_key "$SECRET_KEY"
                aws configure set region "ap-south-1"
                aws eks --region ap-south-1 update-kubeconfig --name devopsthehardway-cluster
                """
            }
        }
        }
        stage ('deploying eks'){
            steps{
                script{
                    sh """
                      kubectl apply -f .
                    """
                }
            }
        }
    }

}
