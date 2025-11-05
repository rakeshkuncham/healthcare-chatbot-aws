output "lambda_function_name" {
  value = aws_lambda_function.chatbot.function_name
}

output "http_api_endpoint" {
  value = aws_apigatewayv2_stage.default.invoke_url
}

output "appointments_table" {
  value = aws_dynamodb_table.appointments.name
}

output "queries_table" {
  value = aws_dynamodb_table.queries.name
}

output "frontend_bucket" {
  value = aws_s3_bucket.frontend.bucket
}
