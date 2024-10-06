pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                // Checkout code from the repository
                git 'https://github.com/Shyamsandeep28/Devops-project.git'
            }
        }

        stage('Build') {
            steps {
                // Build the project
                sh 'mvn clean' // Modify this based on your build command
                sh 'mvn package'
            }
        }

       
        stage('Deploy') {
            steps {
                // Deploy the application (Optional)
                sh 'docker build -t myfile .'
                sh 'docker run -dt --name appcontainer -p 8081:8080 myfile'
            }
        }
    }

    
}
