resource "aws_s3_bucket" "zip_bucket" {
  bucket = "zip-bucket"
  acl = "private"
}

resource "aws_s3_bucket" "unzip_bucket" {
  bucket = "unzip-bucket"
  acl = "private"
}

resource "aws_s3_bucket" "lambda_bucket" {
  bucket = "lambda-source"
  acl = "private"
}

resource "aws_s3_object" "lambda_source" {
  bucket = aws_s3_bucket.lambda_bucket.id

  key    = var.lambda_archive
  source = data.archive_file.lambda_zip.output_path

  etag = filemd5(data.archive_file.lambda_zip.output_path)
}

resource "aws_s3_bucket_notification" "zip_upload_notification" {
  bucket = aws_s3_bucket.zip_bucket.id

  lambda_function {
    lambda_function_arn = aws_lambda_function.unzip_lambda.arn
    events = ["s3:ObjectCreated:*"]
  }
}