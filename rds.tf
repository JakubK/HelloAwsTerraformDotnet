resource "aws_db_instance" "database" {
  instance_class = "db.t3.micro"
  engine         = "mysql"
  engine_version = "5.7"
  name           = "mydb"
  username       = "user1"
  password       = "password"

  allocated_storage = 5
  skip_final_snapshot = true
}