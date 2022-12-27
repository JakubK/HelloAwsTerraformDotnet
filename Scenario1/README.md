# Scenario 1
This scenario contains implementation of the following AWS Infrastructure Diagram:

![](img/diagram.png)

The infrastructure should expose API hosted as Lambda which provides simple CRUD operations on DynamoDB table.
Every Create, Update or Delete operation is producing Stream which triggers the Stream handler lambda.
Stream handler lambda is separate from API and writes the records to the ElastiCache.
Every Read operation called on API is first handled by elasticache read. Cache miss results in calling the DynamoDB. 
Both Lambdas should be fed with the compiled source code placed in the special S3 bucket.

## Diagram elements

1. API - Simple CRUD operations hosted as Lambda
2. DynamoDB - Amazon Document Database where API store data and fetch from it when cache miss happens 
3. StreamHandler - Lambda triggered by DynamoDB streams and writing data to ElastiCache
4. ElastiCache - Redis distributed Cache instance
5. S3 - Storage used here to provide source for Lambda functions


### Get Started

To get started you need to clone this repository, provide `aws_access_key` and `aws_secret_key`
variable values and execute
```terraform
terraform init
terraform validate
``` 

### Running with LocalStack

To run the infrastructure locally you can can LocalStack as Docker Container.
At first you need to delete the `provider "aws"
` section and replace it with the following code:
```terraform
provider "aws" {
  access_key                  = "test"
  secret_key                  = "test"
  region                      = "us-east-1"
  s3_use_path_style           = false
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  endpoints {
    apigateway     = "http://localhost:4566"
    apigatewayv2   = "http://localhost:4566"
    cloudformation = "http://localhost:4566"
    cloudwatch     = "http://localhost:4566"
    dynamodb       = "http://localhost:4566"
    ec2            = "http://localhost:4566"
    es             = "http://localhost:4566"
    elasticache    = "http://localhost:4566"
    firehose       = "http://localhost:4566"
    iam            = "http://localhost:4566"
    kinesis        = "http://localhost:4566"
    lambda         = "http://localhost:4566"
    rds            = "http://localhost:4566"
    redshift       = "http://localhost:4566"
    route53        = "http://localhost:4566"
    s3             = "http://s3.localhost.localstack.cloud:4566"
    secretsmanager = "http://localhost:4566"
    ses            = "http://localhost:4566"
    sns            = "http://localhost:4566"
    sqs            = "http://localhost:4566"
    ssm            = "http://localhost:4566"
    stepfunctions  = "http://localhost:4566"
    sts            = "http://localhost:4566"
  }
}
```

Then visit the root of Scenario with CLI and run:

```
docker-compose up
```

Finally, you should be able to perform terraform commands and test infrastructure on localStack for free. 

### Caution

To actually deploy the infrastructure to the AWS, replace the `provider "aws" ` section with this

```terraform
provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = var.aws_region
}
```

Resources created with this scenario might cost money if you dont deploy to LocalStack.
Remember to destroy all resources when you're done

```terraform
terraform destroy
```

### Credits
Entry version of used C# source code for lambdas and Scenario idea was taken from
https://github.com/Elfocrash/aws-videos/tree/master/DynamoDbStreams 