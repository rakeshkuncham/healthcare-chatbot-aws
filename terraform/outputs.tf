output "lambda_name" {
  value = aws_lambda_function.chatbot_lambda.function_name
}

output "dynamodb_table" {
  value = aws_dynamodb_table.chat_table.name
}
