pipeline {
  agent any
  stages {
    stage('Checkout') {
      steps { git 'https://github.com/rakeshkuncham/healthcare-chatbot-aws.git' }
    }
    stage('Terraform Init & Apply') {
      steps {
        sh 'cd terraform && terraform init'
        sh 'cd terraform && terraform apply -auto-approve'
      }
    }
    stage('Deploy Lambda') {
      steps {
        sh 'zip -j lambda.zip lambda/*'
        sh 'aws lambda update-function-code --function-name healthcare-bot --zip-file fileb://lambda.zip'
      }
    }
  }
}
