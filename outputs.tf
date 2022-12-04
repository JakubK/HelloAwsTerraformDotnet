# <Lambda>
output "lambda_bucket_name" {
  description = "Name of the S3 bucket used to store function code."

  value = aws_s3_bucket.lambda_bucket.id
}


output "function_name" {
  description = "Name of the Lambda function"
  value       = aws_lambda_function.hello_world.function_name
}

output "base_url" {
  description = "Base URL for API Gateway stage"

  value = aws_lambda_function_url.lambda_container_demo_dev.function_url
}

# </Lambda>

# <Frontend>


output "frontend_bucket" {
  description = "Name of bucket where frontend static files will go"
  value       = aws_s3_bucket.frontend_bucket.id
}

# </Frontend>

# <Database>

output "database_endpoint" {
  description = "Endpoint for database"
  value       = aws_db_instance.database.endpoint
}

output "database_name" {
  description = "Name of the database"
  value       = aws_db_instance.database.name
}

# </Database>
