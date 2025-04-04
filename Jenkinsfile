pipeline {
    agent any

    stages {
        stage('Clone Repo') {
            steps {
                git url: 'https://github.com/Virendra-94/Terraform-Azure', branch: 'master'
            }
        }

        stage('Terraform Init') {
            steps {
                withCredentials([azureServicePrincipal('jenkins-azure-sp')]) {
                    bat '''
                        set ARM_CLIENT_ID=%AZURE_CLIENT_ID%
                        set ARM_CLIENT_SECRET=%AZURE_CLIENT_SECRET%
                        set ARM_SUBSCRIPTION_ID=%AZURE_SUBSCRIPTION_ID%
                        set ARM_TENANT_ID=%AZURE_TENANT_ID%

                        terraform init
                    '''
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                withCredentials([azureServicePrincipal('jenkins-azure-sp')]) {
                    bat '''
                        set ARM_CLIENT_ID=%AZURE_CLIENT_ID%
                        set ARM_CLIENT_SECRET=%AZURE_CLIENT_SECRET%
                        set ARM_SUBSCRIPTION_ID=%AZURE_SUBSCRIPTION_ID%
                        set ARM_TENANT_ID=%AZURE_TENANT_ID%

                        terraform plan
                    '''
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                input message: 'Do you want to apply the changes?'
                withCredentials([azureServicePrincipal('jenkins-azure-sp')]) {
                    bat '''
                        set ARM_CLIENT_ID=%AZURE_CLIENT_ID%
                        set ARM_CLIENT_SECRET=%AZURE_CLIENT_SECRET%
                        set ARM_SUBSCRIPTION_ID=%AZURE_SUBSCRIPTION_ID%
                        set ARM_TENANT_ID=%AZURE_TENANT_ID%

                        terraform apply -auto-approve
                    '''
                }
            }
        }
    }
}
