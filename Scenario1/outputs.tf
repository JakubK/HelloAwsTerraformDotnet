output "api_url" {
  value = aws_lambda_function_url.api_lambda_url.function_url
}