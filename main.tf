resource "random_pet" "lambda_bucket_name" {
  prefix = "learn-terraform-functions"
  length = 4
}

resource "random_pet" "frontend_bucket_name" {
  prefix = "learn-terraform-functions"
  length = 4
}

data "archive_file" "lambda_hello_world" {
  type = "zip"

  source_dir  = "${path.module}/SimpleAPI/bin/Debug/net6.0"
  output_path = "${path.module}/${var.lambda_archive}"
}
