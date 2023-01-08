resource "aws_lambda_function" "unzip_lambda" {
  function_name = "zip-handler"
  s3_bucket = aws_s3_bucket.lambda_bucket.id
  s3_key    = aws_s3_object.lambda_source.key

  runtime = "dotnet6"
  handler = "ZipHandler::ZipHandler.Functions::FunctionHandler"

  source_code_hash = data.archive_file.lambda_zip.output_base64sha256
  role             = aws_iam_role.lambda_role.arn

  environment {
    variables = {
        unzip_bucket = "${aws_s3_bucket.unzip_bucket.id}"
    }
  }
}

