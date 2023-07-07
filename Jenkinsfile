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
       stage('push artifact to the nexus:NEXUS') {
    steps {
        script {
            nexusArtifactUploader artifacts: [
                [
                    artifactId: 'java-app',
                    classifier: '',
                    file: 'target/kubernetes-configmap-reload-0.0.1.jar',
                    type: 'jar'
                ]
            ],
            credentialsId: 'nexus',
            groupId: 'com.minikube.sample',
            nexusUrl: '65.0.127.111:8081',
            nexusVersion: 'nexus3',
            protocol: 'http',
            repository: 'java-app',
            version: '0.0.1'
        }
    }
}
    stage('pushing to docker hub: docker hub'){
        steps{
            script{
                sh 'docker build -t devops .'
                sh 'docker image tag devops saikumarpinisetti/devops:v1'
                sh 'docker image tag devops saikumarpinisetti/devops:latest'
                sh 'docker login -u saikumarpinisetti -p Supershot#143'
                sh 'docker push saikumarpinisetti/devops:v1'
                sh 'docker push saikumarpinisetti/devops:latest'
            }
        }
    }
        stage('scanning tje image fo r vulnerabilities: TRIVY'){
        steps{
            script{
                    sh 'trivy image saikumarpinisetti/devops:latest > scan.txt'
                    sh 'cat scan.txt'
            }
        }
    }

    }
}
