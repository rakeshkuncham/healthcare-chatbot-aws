resource "aws_iam_role" "lambda_role" {
  name = "healthcare_lambda_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_policy_attachment" "lambda_basic_policy" {
  name       = "lambda_basic_policy"
  roles      = [aws_iam_role.lambda_role.name]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# --------------------------------------------------------------------------
# FIX: DynamoDB Access Policy (Added to resolve AccessDeniedException)
# --------------------------------------------------------------------------
resource "aws_iam_policy" "lambda_dynamodb_policy" {
  name        = "lambda-dynamodb-policy"
  description = "Allow Lambda to access DynamoDB tables"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "dynamodb:PutItem",
          "dynamodb:GetItem",
          "dynamodb:UpdateItem",
          "dynamodb:Scan",
          "dynamodb:Query"
        ]
        Resource = [
          aws_dynamodb_table.chat_table.arn,
          aws_dynamodb_table.queries.arn,
          aws_dynamodb_table.appointments.arn
        ]
      }
    ]
  })
}

resource "aws_iam_policy_attachment" "lambda_dynamodb_attach" {
  name       = "lambda-dynamodb-attachment"
  roles      = [aws_iam_role.lambda_role.name]
  policy_arn = aws_iam_policy.lambda_dynamodb_policy.arn
}