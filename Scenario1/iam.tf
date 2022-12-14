resource "aws_iam_role" "api_iam_role" {
  name = "api-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Sid    = "",
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role" "handler_iam_role" {
  name = "handler-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Sid    = "",
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "elasticache_all" {
  role       = aws_iam_role.api_iam_role.name
  policy_arn = aws_iam_policy.cache_all_policy.arn
}

resource "aws_iam_role_policy_attachment" "lambda_policy" {
  role       = aws_iam_role.api_iam_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy_attachment" "dynamodb_policy_attachment" {
  role       = aws_iam_role.api_iam_role.name
  policy_arn = aws_iam_policy.dynamodb_policy.arn
}

resource "aws_iam_role_policy_attachment" "stream_policy_attachment" {
  role       = aws_iam_role.handler_iam_role.name
  policy_arn = aws_iam_policy.stream_policy.arn
}

resource "aws_iam_role_policy_attachment" "api_elasticache_policy_attachment" {
  role       = aws_iam_role.api_iam_role.name
  policy_arn = aws_iam_policy.cache_all_policy.arn
}

resource "aws_iam_role_policy_attachment" "handler_elasticache_policy_attachment" {
  role       = aws_iam_role.handler_iam_role.name
  policy_arn = aws_iam_policy.cache_all_policy.arn
}

resource "aws_iam_role_policy_attachment" "api_networking" {
  role       = aws_iam_role.api_iam_role.name
  policy_arn = aws_iam_policy.network_policy.arn
}

resource "aws_iam_role_policy_attachment" "handler_networking" {
  role       = aws_iam_role.handler_iam_role.name
  policy_arn = aws_iam_policy.network_policy.arn
}

resource "aws_iam_policy" "dynamodb_policy" {
  policy = data.aws_iam_policy_document.dynamodb_access.json
}

resource "aws_iam_policy" "stream_policy" {
  policy = data.aws_iam_policy_document.dynamodb_stream.json
}

resource "aws_iam_policy" "cache_all_policy" {
  policy = data.aws_iam_policy_document.elasticache_all.json
}
resource "aws_iam_policy" "network_policy" {
  policy = data.aws_iam_policy_document.networking_document.json
}

data "aws_iam_policy_document" "elasticache_all" {
  statement {
    effect = "Allow"
    actions = [
      "elasticache:*",
      "redis:*"
    ]
    resources = [aws_elasticache_cluster.redis.arn]
  }
}

data "aws_iam_policy_document" "dynamodb_access" {
  statement {
    effect = "Allow"
    actions = [
      "dynamodb:BatchGetItem",
      "dynamodb:GetItem",
      "dynamodb:Query",
      "dynamodb:Scan",
      "dynamodb:BatchWriteItem",
      "dynamodb:PutItem",
      "dynamodb:UpdateItem"
    ]
    resources = ["arn:aws:dynamodb:${var.aws_region}:${local.account_id}:table/${aws_dynamodb_table.dynamodb_items_table.name}"]
  }
}

data "aws_iam_policy_document" "dynamodb_stream" {
  statement {
    effect = "Allow"
    actions = [
      "dynamodb:GetRecords",
      "dynamodb:GetShardIterator",
      "dynamodb:DescribeStream",
      "dynamodb:ListStreams"
    ]
    resources = ["arn:aws:dynamodb:${var.aws_region}:${local.account_id}:table/${aws_dynamodb_table.dynamodb_items_table.name}/stream/*"]
  }
}

data "aws_iam_policy_document" "networking_document" {
  statement {
    effect = "Allow"
    actions = [
      "ec2:CreateNetworkInterface",
      "ec2:DescribeNetworkInterfaces",
      "ec2:DeleteNetworkInterface"
    ]
    resources = ["*"]
  }
}