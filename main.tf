resource "random_pet" "lambda_bucket_name" {
  prefix = "learn-terraform-functions"
  length = 4
}

resource "random_pet" "frontend_bucket_name" {
  prefix = "learn-terraform-functions"
  length = 4
}