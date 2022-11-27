# Input variable definitions

variable "aws_region" {
  description = "AWS region for all resources."

  type    = string
  default = "us-east-1"
}

variable "aws_access_key" {
  type        = string
  description = "aws access key"
  sensitive   = true
}

variable "aws_secret_key" {
  type        = string
  description = "aws secret key"
  sensitive   = true
}

variable "lambda_archive" {
  type        = string
  description = "Full name of archive file containing compiled lambda source"
  default     = "lambda.zip"
}
