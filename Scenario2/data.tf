data "archive_file" "lambda_zip" {
  type = "zip"

  source_dir  = "${path.module}/ZipHandler/bin/Debug/net6.0"
  output_path = "${path.module}/${var.lambda_archive}"
}