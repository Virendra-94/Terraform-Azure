pipeline {
    agent any
    environment {
        AZURE_CREDENTIALS = credentials('AZURE_CREDENTIALS')
    }
    stages {
        stage('Checkout') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'GITHUB_CREDENTIALS', usernameVariable: 'GIT_USER', passwordVariable: 'GIT_PASS')]) {
                    git branch: 'master', url: 'https://github.com/Virendra-94/Terraform-Azure'
                }
            }
        }
        stage('Terraform Init') {
            steps {
                withEnv(["ARM_CLIENT_ID=${AZURE_CREDENTIALS.client_id}",
                         "ARM_CLIENT_SECRET=${AZURE_CREDENTIALS.client_secret}",
                         "ARM_SUBSCRIPTION_ID=${AZURE_CREDENTIALS.subscription_id}",
                         "ARM_TENANT_ID=${AZURE_CREDENTIALS.tenant_id}"]) {
                    script {
                        if (isUnix()) {
                            sh 'terraform init'
                        } else {
                            bat 'terraform init'
                        }
                    }
                }
            }
        }
        stage('Terraform Plan') {
            steps {
                script {
                    if (isUnix()) {
                        sh 'terraform plan'
                    } else {
                        bat 'terraform plan'
                    }
                }
            }
        }
        stage('Terraform Apply') {
            steps {
                input message: 'Apply Terraform Changes?', ok: 'Yes'
                script {
                    if (isUnix()) {
                        sh 'terraform apply -auto-approve'
                    } else {
                        bat 'terraform apply -auto-approve'
                    }
                }
            }
        }
    }
}
