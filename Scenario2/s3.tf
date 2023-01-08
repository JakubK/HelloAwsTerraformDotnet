resource "aws_s3_bucket" "zip_bucket" {
}

resource "aws_s3_bucket" "unzip_bucket" {
}

resource "aws_s3_bucket" "lambda_bucket" {
  
}

resource "aws_s3_object" "lambda_source" {
  bucket = aws_s3_bucket.lambda_bucket.id

  key    = var.lambda_archive
  source = data.archive_file.lambda_zip.output_path

  etag = filemd5(data.archive_file.lambda_zip.output_path)
}