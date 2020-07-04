resource "aws_dynamodb_table" "this" {
  name           = var.dbname
  read_capacity  = var.read_capacity
  write_capacity = var.write_capacity
  hash_key       = "EventsId"

  attribute {
    name = "EventsId"
    type = "S"
  }
  tags = {
    Name       = var.dbname
    Enviroment = var.env
  }
}