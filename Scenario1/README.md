# Scenario 1

This scenario contains implementation of the following AWS Infrastructure Diagram:

![](img/diagram.png)

1. API - Simple CRUD operations hosted as Lambda
2. DynamoDB - Amazon Document Database where API store data and fetch from it when cache miss happens 
3. StreamHandler - Lambda triggered by DynamoDB streams and writing data to ElastiCache
4. ElastiCache - Redis distributed Cache instance
5. S3 - Storage used here to provide source for Lambda functions

