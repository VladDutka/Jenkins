pipeline {
    agent {
        node {
            label 'docker-test'
        }

    }

    environment {
        SCANNER_HOME = tool 'sonar-scanner'
    }

    stages {
        stage('Debug Network') {
            steps {
                sh '''
                echo "Testing hostname resolution and connectivity:"
                ping -c 4 sonarqube-custom
                curl -v http://sonarqube-custom:9000
                '''
            }
        }

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
                checkout scm
            }
        }
        stage('Sonar Scan') {
            steps {
                sh """
                    \${SCANNER_HOME}/bin/sonar-scanner \\
                      -Dsonar.host.url=http://sonarqube-custom:9000 \\
                      -Dsonar.login=squ_192e7a99bd3188ffcfdbf8647c113a5a478032b7 \\
                      -Dsonar.projectName=hellworld-project \\
                      -Dsonar.java.binaries=. \\
                      -Dsonar.projectKey=helloworld-project \\
                      -Dsonar.nodejs.executable=/usr/bin/node
                """
            }
        }

        stage('OWASP Scan') {
            steps {
                dependencyCheck additionalArguments: '''
                  --nvdApiKey 4035da93-f4f9-485f-bcd7-cbb003d04105 \
                  --scan ./ \
                  -n
                ''', odcInstallation: 'DP-check'
                dependencyCheckPublisher pattern: '**/dependency-check-report.xml'
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
