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
            steps {
                // Always wrap checkout in steps {}
                checkout scm
            }
        }
        stage('SonarQube Analysis') {
            steps {
                script {
                    // 'sq1' should match the name of your SonarQube Installation in Jenkins Global Tool Configuration
                    def scannerHome = tool 'sonar-scanner'
                    
                    // Also pass the same installation name to withSonarQubeEnv
                    withSonarQubeEnv('sonar-scanner') {
                        sh "${scannerHome}/bin/sonar-scanner"
                    }
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
