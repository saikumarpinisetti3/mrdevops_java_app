pipeline {
    agent any

    parameters {
        choice(name: 'action', choices: 'create\ndestroy', description: 'Choose create/destroy') 
    }

    stages {
        stage('git checkout') {
            when {
                expression { params.action == 'create' }
            }
            steps {
                script {
                    git branch: 'main', url: 'https://github.com/saikumarpinisetti3/mrdevops_java_app.git'
                }
            }
        }
        
        stage('Unit testing') {
            when {
                expression { params.action == 'create' }
            }
            steps {
                script {
                    sh 'mvn clean'
                }
            }
        }
        
        stage('Integration testing') {
            when {
                expression { params.action == 'create' }
            }
            steps {
                script {
                    sh 'mvn verify -DskipUnitTests'
                }
            }
        }
        
        stage('Static code analysis') {
            when {
                expression { params.action == 'create' }
            }
            steps {
                script {
                    withSonarQubeEnv(credentialsId: 'sonarqube') {
                        sh 'mvn clean package sonar:sonar'
                    }
                }
            }
        }
        
        stage('Wait for quality gate') {
            when {
                expression { params.action == 'create' }
            }
            steps {
                script {
                    waitForQualityGate abortPipeline: false, credentialsId: 'sonarqube'
                }
            }
        }
        
        stage('Maven build') {
            when {
                expression { params.action == 'create' }
            }
            steps {
                script {
                    sh 'mvn clean install'
                }
            }
        }
        
        stage('Docker image build') {
            when {
                expression { params.action == 'create' }
            }
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'docker', passwordVariable: 'Pass', usernameVariable: 'User')]) {
                        sh "docker build -t saikumar ."
                        sh "docker image tag saikumar saikumarpinisetti/obama:latest"
                        sh 'docker login -u saikumarpinisetti -p Supershot#143'
                        sh 'docker image push saikumarpinisetti/obama:latest'
                    }
                }
            }
        }
        
        stage('Image scanning with Trivy') {
            steps {
                script {
                    sh 'trivy image saikumarpinisetti/obama:latest > scan.txt'
                    sh 'cat scan.txt'
                }
            }
        }
    }
}
