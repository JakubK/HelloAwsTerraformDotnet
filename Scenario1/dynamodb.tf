resource "aws_dynamodb_table" "dynamodb_items_table" {
  name = "items"
  billing_mode = "PROVISIONED"
  stream_enabled = true
  stream_view_type = "NEW_AND_OLD_IMAGES"
  read_capacity = 1
  write_capacity = 1
}