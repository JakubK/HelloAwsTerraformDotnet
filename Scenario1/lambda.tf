resource "aws_lambda_function" "api_lambda" {
  function_name = "API"

  s3_bucket = aws_s3_bucket.lambda_bucket.id
  s3_key    = aws_s3_object.api_lambda_source.key

  runtime = "dotnet6"
  handler = "SimpleAPI::SimpleAPI.LambdaEntryPoint::FunctionHandlerAsync"

  source_code_hash = data.archive_file.lambda_api_zip.output_base64sha256
  role             = aws_iam_role.api_iam_role.arn

  environment {
    variables = {
      "RedisConnectionString" = "${aws_elasticache_cluster.redis.cache_nodes[0].address}"
    }
  }
}

resource "aws_lambda_function_url" "api_lambda_url" {
  function_name      = aws_lambda_function.api_lambda.function_name
  authorization_type = "NONE"
  cors {
    allow_credentials = true
    allow_origins     = ["*"]
    allow_methods     = ["*"]
    allow_headers     = ["date", "keep-alive"]
    expose_headers    = ["keep-alive", "date"]
    max_age           = 300
  }
}

resource "aws_lambda_function" "handler_lambda" {
  function_name = "API"

  s3_bucket = aws_s3_bucket.lambda_bucket.id
  s3_key    = aws_s3_object.handler_lambda_source.key

  runtime = "dotnet6"
  handler = "StreamHandler::StreamHandler.Function::FunctionHandlerAsync"

  source_code_hash = data.archive_file.lambda_handler_zip.output_base64sha256
  role             = aws_iam_role.handler_iam_role.arn

  environment {
    variables = {
      "RedisConnectionString" = "${aws_elasticache_cluster.redis.cache_nodes[0].address}"
    }
  }
}

resource "aws_lambda_event_source_mapping" "dynamodb_trigger" {
  event_source_arn  = aws_dynamodb_table.dynamodb_items_table.stream_arn
  function_name     = aws_lambda_function.handler_lambda.arn
  starting_position = "LATEST"
  batch_size        = 100
}