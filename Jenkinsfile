pipeline {
    agent any

    environment {
        AWS_REGION = "us-east-1"
        TF_VERSION = "1.6.0"
    }

    stages {

        /*stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/yadneshb31/terraform-aws-modular-infrastructure.git'
            }
        }

        stage('Install Terraform') {
            steps {
                sh '''
                if ! command -v terraform &> /dev/null
                then
                    wget https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_${TF_VERSION}_linux_amd64.zip
                    unzip terraform_${TF_VERSION}_linux_amd64.zip
                    sudo mv terraform /usr/local/bin/
                fi
                terraform -version
                '''
            }
        }*/

        stage('Terraform Init') {
            steps {
                sh 'terraform init'
            }
        }

        stage('Terraform Format Check') {
            steps {
                sh 'terraform fmt -check'
            }
        }

        stage('Terraform Validate') {
            steps {
                sh 'terraform validate'
            }
        }

        stage('Terraform Plan') {
            steps {
                sh 'terraform plan -out=tfplan'
            }
        }

        stage('Manual Approval') {
            steps {
                input message: 'Apply Terraform changes?', ok: 'Yes, Apply'
            }
        }

        stage('Terraform Apply') {
            steps {
                sh 'terraform apply -auto-approve tfplan'
            }
        }
    }

    post {
        success {
            echo 'Infrastructure deployed successfully'
        }
        failure {
            echo 'Something broke, Check logs'
        }
    }
}