pipeline {
    agent { 
        node {
            label 'docker-jdk-test'
            }
      }
    stages {
        stage('Build') {
            steps {
                echo "Building.."
                sh '''
                apt-get update
                apt-get install -y python3-venv
                python3 -m venv venv
                . venv/bin/activate
                cd myapp
                pip install -r requirements.txt
                '''
            }
        }
        stage('SCM') {
                checkout scm
            }
        stage('SonarQube Analysis') {
                def scannerHome = tool 'sq1';
                    withSonarQubeEnv() {
                        sh "${scannerHome}/bin/sonar-scanner"
                }
            }
        }
        stage('Test') {
            steps {
                echo "Testing.."
                sh '''
                . venv/bin/activate
                cd myapp
                python3 hello.py
                python3 hello.py --name=Brad
                '''
            }
        }
        stage('Deliver') {
            steps {
                echo 'Deliver....'
                sh '''
                echo "doing delivery stuff.."
                '''
            }
        }
    }
}