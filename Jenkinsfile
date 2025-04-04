pipeline {
    agent any
    environment {
        AZURE_CREDENTIALS = credentials('AZURE_CREDENTIALS')
    }
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/Virendra-94/Terraform-Azure'
            }
        }
        stage('Terraform Init') {
            steps {
                withCredentials([string(credentialsId: 'AZURE_CREDENTIALS', variable: 'ARM_SERVICE_PRINCIPAL')]) {
                    bat """
                    echo Initializing Terraform...
                    terraform init
                    """
                }
            }
        }
        stage('Terraform Plan') {
            steps {
                bat "terraform plan"
            }
        }
        stage('Terraform Apply') {
            steps {
                input message: 'Apply Terraform Changes?', ok: 'Yes'
                bat "terraform apply -auto-approve"
            }
        }
    }
}
