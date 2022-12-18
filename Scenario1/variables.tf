variable "handler_archive" {
  type        = string
  description = "Full name of archive file containing compiled Stream handler lambda source"
  default     = "handler.zip"
}

variable "api_archive" {
  type        = string
  description = "Full name of archive file containing compiled API lambda source"
  default     = "api.zip"
}

variable "aws_region" {
  description = "AWS region for all resources."

  type    = string
  default = "eu-west-3"
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
