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

        stage('docker image build'){
            steps{
                script{
                     def jobName = env.JOB_NAME.replaceAll('/', '-')
            def buildNumber = env.BUILD_NUMBER
                    sh 'docker build -t miniapp:V1 .'
                }
            }
        }

        stage('docker image push'){
            steps{
                script{
                    withCredentials([usernamePassword(credentialsId: 'dockerhub', passwordVariable: 'hub', usernameVariable: 'docker')]) {
                        sh 'docker login -u ${docker} -p ${hub}'
                        sh 'docker push miniapp:latest'
                        sh 'docker push miniapp:version1'

                    }
                }
            }
        }

    }

}
