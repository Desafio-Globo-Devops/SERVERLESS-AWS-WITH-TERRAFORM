resource "aws_dynamodb_table" "this" {
  name           = var.dbname
  read_capacity  = var.read_capacity
  write_capacity = var.write_capacity
  hash_key       = "EventsId"
  stream_enabled   = false
  billing_mode     = "PAY_PER_REQUEST"

  attribute {
    name = "EventsId"
    type = "S"
  }
  tags = {
    Name       = var.dbname
    Enviroment = var.env
  }
}