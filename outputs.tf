# <Frontend>


output "frontend_bucket" {
  description = "Name of bucket where frontend static files will go"
  value       = aws_s3_bucket.frontend_bucket.id
}

# </Frontend>

# <Database>

output "database_endpoint" {
  description = "Endpoint for database"
  value       = aws_db_instance.database.endpoint
}

output "database_name" {
  description = "Name of the database"
  value       = aws_db_instance.database.name
}

# </Database>
