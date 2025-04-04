pipeline {
    agent any
    environment {
        AZURE_CREDENTIALS = credentials('AZURE_CREDENTIALS')
    }
    stages {
        stage('Checkout') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'GITHUB_CREDENTIALS', usernameVariable: 'GIT_USER', passwordVariable: 'GIT_PASS')]) {
                    git branch: 'master', credentialsId: 'GITHUB_CREDENTIALS', url: 'https://github.com/Virendra-94/Terraform-Azure'
                }
            }
        }
        stage('Terraform Init') {
            steps {
                withCredentials([azureServicePrincipal(credentialsId: 'AZURE_CREDENTIALS')]) {
                    script {
                        def AZURE_CLIENT_ID = env.AZURE_CLIENT_ID
                        def AZURE_CLIENT_SECRET = env.AZURE_CLIENT_SECRET
                        def AZURE_SUBSCRIPTION_ID = env.AZURE_SUBSCRIPTION_ID
                        def AZURE_TENANT_ID = env.AZURE_TENANT_ID

                        if (isUnix()) {
                            sh """
                            export ARM_CLIENT_ID=$AZURE_CLIENT_ID
                            export ARM_CLIENT_SECRET=$AZURE_CLIENT_SECRET
                            export ARM_SUBSCRIPTION_ID=$AZURE_SUBSCRIPTION_ID
                            export ARM_TENANT_ID=$AZURE_TENANT_ID
                            terraform init
                            """
                        } else {
                            bat """
                            set ARM_CLIENT_ID=$AZURE_CLIENT_ID
                            set ARM_CLIENT_SECRET=$AZURE_CLIENT_SECRET
                            set ARM_SUBSCRIPTION_ID=$AZURE_SUBSCRIPTION_ID
                            set ARM_TENANT_ID=$AZURE_TENANT_ID
                            terraform init
                            """
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
