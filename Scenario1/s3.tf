resource "aws_s3_bucket" "lambda_bucket" {
  bucket = "jk-scenario1-bucket"
}

resource "aws_s3_bucket_acl" "bucket_acl" {
  bucket = aws_s3_bucket.lambda_bucket.id
  acl    = "private"
}

resource "aws_s3_bucket_public_access_block" "lambda_bucket_access_block" {
  bucket = aws_s3_bucket.lambda_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_object" "api_lambda_source" {
  bucket = aws_s3_bucket.lambda_bucket.id

  key    = var.api_archive
  source = data.archive_file.lambda_api_zip.output_path

  etag = filemd5(data.archive_file.lambda_api_zip.output_path)
}

resource "aws_s3_object" "handler_lambda_source" {
  bucket = aws_s3_bucket.lambda_bucket.id

  key    = var.handler_archive
  source = data.archive_file.lambda_handler_zip.output_path

  etag = filemd5(data.archive_file.lambda_handler_zip.output_path)
}