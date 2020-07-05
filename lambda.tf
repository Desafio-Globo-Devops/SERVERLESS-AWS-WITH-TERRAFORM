// gera um zip atraves do arquivo app.js DYNAMO
data "archive_file" "dynamo" {
  type = "zip"
  source_file = "${path.module}/importFunction/app.js"
  output_path = "${path.module}/importFunction/app.js.zip"
}

// lambda DYNAMO
resource "aws_lambda_function" "dynamo" {
  function_name = "s3_to_dynamo"
  handler = "app.handler"
  role = aws_iam_role.dynamo.arn
  runtime = "nodejs12.x"

  filename = data.archive_file.dynamo.output_path
  source_code_hash = data.archive_file.dynamo.output_base64sha256

  timeout = 30
  memory_size = 512

  environment {
    variables = {
      TABLE = aws_dynamodb_table.this.name
    }
  }

}
