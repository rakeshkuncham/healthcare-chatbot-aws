# ─────────────────────────────────────────────
# Main AWS Infrastructure for Healthcare Chatbot
# ─────────────────────────────────────────────

# DynamoDB Table for chat conversation storage
resource "aws_dynamodb_table" "chat_table" {
  name           = "patient_chatbot_table"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "id"

  attribute {
    name = "id"
    type = "S"
  }

  tags = {
    Project = "HealthcareChatbot"
    Env     = "dev"
  }
}

# ⚠️ NOTE: The aws_lambda_permission block has been REMOVED from this file
# to resolve the "ResourceConflictException: The statement id (AllowAPIGatewayInvoke) provided already exists" error.
# This resource is already correctly defined in your 'lambda.tf' file.