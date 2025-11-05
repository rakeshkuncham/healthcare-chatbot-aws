variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
}

variable "lambda_s3_bucket" {
  description = "S3 bucket where lambda zip will be uploaded (or leave empty to use local file)"
  type        = string
  default     = ""
}

variable "lambda_s3_key" {
  description = "S3 key (object name) for the lambda zip"
  type        = string
  default     = "lambda_package.zip"
}

variable "frontend_bucket_name" {
  description = "S3 bucket name for frontend hosting"
  type        = string
  default     = ""
}

variable "dynamodb_appointments_table" {
  description = "DynamoDB table name for appointments"
  type        = string
  default     = "Appointments"
}

variable "dynamodb_queries_table" {
  description = "DynamoDB table for chat queries / logs"
  type        = string
  default     = "ChatQueries"
}

variable "lambda_function_name" {
  type    = string
  default = "healthcare_chatbot_lambda"
}
