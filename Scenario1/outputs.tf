output "api_url" {
  value = aws_lambda_function_url.api_lambda_url.function_url
}

output "redis_url" {
  value = aws_elasticache_cluster.redis.cache_nodes[0].address
}