data "archive_file" "lambda_api_zip" {
  type = "zip"
  source_dir  = "${path.module}/SimpleAPI/bin/Debug/net6.0"
  output_path = "${path.module}/${var.api_archive}"
}

data "archive_file" "lambda_handler_zip" {
  type = "zip"

  source_dir  = "${path.module}/StreamHandler/bin/Debug/net6.0"
  output_path = "${path.module}/${var.handler_archive}"
}

