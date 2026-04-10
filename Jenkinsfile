pipeline {
    agent any

    environment {
        AWS_DEFAULT_REGION = 'us-east-1'
    }

    stages {

        stage('Checkout Code') {
            steps {
                git branch: 'main',
                url: 'https://github.com/yadneshb31/terraform-aws-modular-infrastructure.git'
            }
        }

        stage('Terraform Init') {
            steps {
                sh 'terraform init -input=false'
            }
        }

        stage('Terraform Validate') {
            steps {
                sh 'terraform validate'
            }
        }

        stage('Terraform Plan') {
            steps {
                sh 'terraform plan'
            }
        }

        stage('Terraform Apply') {
            steps {
                input message: 'Approve Terraform Apply?', ok: 'Apply Now'
                sh 'terraform apply -auto-approve'
            }
        }

        stage('Terraform Destroy') {
    steps {
        input message: 'Are you sure you want to DESTROY infra?', ok: 'Destroy Now'
        sh 'terraform destroy -auto-approve'
    }
}
    }

    post {
        success {
            echo 'Infrastructure deployed successfully 🚀'
        }
        failure {
            echo 'Something broke, check logs ❌'
        }
    }
}