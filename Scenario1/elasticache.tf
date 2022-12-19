resource "aws_elasticache_cluster" "redis" {
  cluster_id           = "cluster-example"
  engine               = "redis"
  node_type            = "cache.t4g.micro"
  num_cache_nodes      = 1
  engine_version       = "6.0"
  port                 = 6379
}