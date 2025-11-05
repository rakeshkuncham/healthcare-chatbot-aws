resource "aws_dynamodb_table" "appointments" {
  name         = var.dynamodb_appointments_table
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "appointment_id"

  attribute {
    name = "appointment_id"
    type = "S"
  }

  tags = {
    Project = "HealthcareChatbot"
    Env     = "dev"
  }
}

resource "aws_dynamodb_table" "queries" {
  name         = var.dynamodb_queries_table
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "query_id"

  attribute {
    name = "query_id"
    type = "S"
  }

  tags = {
    Project = "HealthcareChatbot"
    Env     = "dev"
  }
}
