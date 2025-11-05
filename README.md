🏥 Healthcare AI Chatbot — AWS Serverless | Terraform | NLP












✅ Overview

This project implements a Healthcare AI Chatbot that:

✔ Assists users with basic medical queries
✔ Books and logs appointment requests
✔ Stores chat history for analytics
✔ Runs fully serverless on AWS
✔ Frontend deployed on S3 + Backend on API Gateway + Lambda

A real-world cloud-based healthcare support assistant with end-to-end deployment.

🎯 Features
Feature	Description
AI Chatbot	Answers symptom, medication & general queries
Appointment System	Stores patient requests in DynamoDB
Serverless Backend	Lambda + API Gateway
No-Server Hosting	S3 static hosting
Monitoring	CloudWatch logs
IaC	Entire infra on Terraform
🧠 Architecture
End-to-End Flow

User → Web UI (S3) → API Gateway → Lambda → DynamoDB → CloudWatch

flowchart LR
A["User Browser"] --> B["S3 Static Website"]
B --> C["API Gateway"]
C --> D["Lambda Function (Python)"]
D --> E["DynamoDB (Chats & Appointments)"]
D --> F["CloudWatch Logs"]

🛠️ Tech Stack
Frontend

HTML, CSS, JavaScript (Vanilla)

Hosted on AWS S3 (Static Website Hosting)

Backend

Python Lambda function

API Gateway HTTP endpoint

DynamoDB for storage

Infra Automation

Terraform (IAM, Lambda, API, DynamoDB, S3)

📂 Folder Structure
/healthcare-chatbot
 ├── frontend
 │   ├── index.html
 │   ├── style.css
 │   └── script.js
 ├── lambda
 │   └── lambda_function.py
 ├── terraform
 │   ├── main.tf
 │   ├── api.tf
 │   ├── lambda.tf
 │   ├── dynamodb.tf
 │   ├── iam.tf
 │   └── variables.tf
 └── README.md

⚙️ Deployment Guide
✅ 1. Clone Repo
git clone https://github.com/your-username/healthcare-chatbot.git
cd healthcare-chatbot/terraform

✅ 2. Deploy AWS Resources (Terraform)
terraform init
terraform apply -auto-approve

✅ 3. Upload Frontend to S3
cd ../frontend
aws s3 sync . s3://YOUR_S3_BUCKET_NAME --acl public-read

🧪 Testing the API
Send Test Message
curl -X POST "https://API-ID.execute-api.us-east-1.amazonaws.com/chat" \
-H "Content-Type: application/json" \
-d '{"message":"I have fever"}'


Expected output ✅:

{
  "response": "Take rest and drink fluids..."
}

📊 DynamoDB Tables
Table	Purpose	Key
patient_chatbot_table	Chat history	query_id
appointments_table	Bookings	appointment_id
🎥 Screenshots & Demo

✅ Working healthcare UI
✅ API response in browser
✅ DynamoDB records proof
✅ CloudWatch logs

🔒 Security

IAM Role for Lambda (least privilege)

Input validation in Lambda

Future: Cognito user authentication

📈 Future Enhancements
Feature	Benefit
Replace rule-based with Amazon Bedrock LLM	Real conversational AI
Add Cognito login	Secure patient portal
Use CloudFront + HTTPS	Production-grade hosting
Admin Dashboard (QuickSight)	View chat & appointment analytics
🧠 Learning Goals Achieved

✔ AWS Serverless Architecture
✔ Terraform Infrastructure as Code
✔ DynamoDB No-SQL Design
✔ API development & testing
✔ Real-world deployment experience

🙋‍♂️ Author

Rakesh Kuncham
DevOps & Cloud Engineer

⭐ Support This Project

If you found this useful — Star ⭐ the repo and connect with me!

✅ READY for GitHub ✅