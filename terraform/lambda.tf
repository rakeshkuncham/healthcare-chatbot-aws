# ──────────────────────────────────────────────────────────────────────────
# AWS Lambda Function and Permissions (lambda.tf)
# This configuration supports deploying the code either locally OR from S3.
# ──────────────────────────────────────────────────────────────────────────

resource "aws_lambda_function" "chatbot" {
  function_name = var.lambda_function_name
  role          = aws_iam_role.lambda_role.arn
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.9"
  timeout       = 15
  memory_size   = 256 # Recommended memory size for Python/dependencies

  # --- CONDITIONAL ARGUMENTS ---
  # These arguments will be set to 'null' if the condition is false, and Terraform ignores null arguments.

  # 1. Local File Arguments (Used if var.lambda_s3_bucket is empty)
  filename         = var.lambda_s3_bucket == "" ? "${path.module}/../lambda/lambda_package.zip" : null
  source_code_hash = var.lambda_s3_bucket == "" ? filebase64sha256("${path.module}/../lambda/lambda_package.zip") : null

  # 2. S3 Deployment Arguments (Used if var.lambda_s3_bucket is NOT empty)
  s3_bucket = var.lambda_s3_bucket == "" ? null : var.lambda_s3_bucket
  s3_key    = var.lambda_s3_bucket == "" ? null : var.lambda_s3_key # Note: Checks s3_bucket var for simplicity

  # --- ENVIRONMENT VARIABLES ---
  environment {
    variables = {
      APPOINTMENTS_TABLE = aws_dynamodb_table.appointments.name
      QUERIES_TABLE      = aws_dynamodb_table.queries.name
      REGION             = var.aws_region
    }
  }

  tags = {
    Project = "HealthcareChatbot"
    Env     = "dev"
  }
}

# Permission for API Gateway to invoke Lambda
resource "aws_lambda_permission" "apigw_invoke" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.chatbot.function_name
  principal     = "apigateway.amazonaws.com"
}