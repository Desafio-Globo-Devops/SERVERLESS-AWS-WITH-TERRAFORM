resource "aws_dynamodb_table" "this" {
  name           = var.dbname
  read_capacity  = var.read_capacity
  write_capacity = var.write_capacity
  hash_key       = "ID"
  stream_enabled   = false
  billing_mode     = "PAY_PER_REQUEST"

  attribute {
    name = "ID"
    type = "S"
  }
  tags = {
    Name       = var.dbname
  }
}