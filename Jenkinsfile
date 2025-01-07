pipeline {
    agent { 
        node {
            label 'docker-python'
        }
    }
    stages {
        stage('Setup') {
            steps {
                echo "Setting up environment..."
                sh '''
                su 
                cd myapp
                sudo apt-get update
                sudo apt-get install -y python3 python3-pip python3-venv
                '''
            }
        }
        stage('Build') {
            steps {
                echo "Creating virtual environment and installing dependencies..."
                sh '''
                su 
                cd myapp
                python3 -m venv venv
                source venv/bin/activate
                pip install -r requirements.txt
                deactivate
                '''
            }
        }
        stage('Test') {
            steps {
                echo "Testing..."
                sh '''
                su 
                cd myapp
                source venv/bin/activate
                python3 hello.py
                python3 hello.py --name=Brad
                deactivate
                '''
            }
        }
        stage('Deliver') {
            steps {
                echo "Delivering..."
                sh '''
                echo "Performing delivery tasks..."
                '''
            }
        }
    }
}
