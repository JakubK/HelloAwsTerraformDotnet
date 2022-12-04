provider "aws" {
  region = var.aws_region
}

resource "aws_s3_bucket" "terraform-state" {
  bucket = "hello-aws-tfstate"
  force_destroy = true
}