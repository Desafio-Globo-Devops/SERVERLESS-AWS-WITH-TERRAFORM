//locals {
//  layer_name = "terraform_layer.zip"
//  layers_path = "${path.module}/lambda-layers/nodejs"
//}
//  trigger check se tem alteraçao no package.json
//resource "null_resource" "build_lambda_layers" {
//  triggers = {
//    layer_build = md5(file("${local.layers_path}/package.json"))
//  }
////  vai instalar com produçao e zipar a pasta nodejs e vira uma layer
//  provisioner "local-exec" {
//    working_dir = local.layers_path
//    command = "npm install --production && cd ../ && zip -9 -r --quiet ${local.layer_name} *"
//  }
//}
//// da o nome da layer que irá upar na aws com as dependencias e ocorrerá apos null_resource
//resource "aws_lambda_layer_version" "this" {
//  filename = "${local.layers_path}/../${local.layer_name}"
//  layer_name = "terraform-layer"
//  description = "uuid: ^3.3.3"
//
//  compatible_runtimes = ["nodejs12.x"]
//
//  depends_on = ["null_resource.build_lambda_layers"]
//}

// gera um zip atraves do arquivo app.js DYNAMO
data "archive_file" "dynamo" {
  type = "zip"
  source_file = "${path.module}/importFunction/app.js"
  output_path = "${path.module}/importFunction/app.js.zip"
}

// lambda DYNAMO
resource "aws_lambda_function" "dynamo" {
  function_name = "dynamo"
  handler = "app.handler"
  role = aws_iam_role.dynamo.arn
  runtime = "nodejs12.x"
//  layers = [aws_lambda_layer_version.this.arn]

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

// Permissao para invocar lambda DYNAMO
//resource "aws_lambda_permission" "dynamo" {
//  statement_id = "AllowExecutionFromAPITGateway"
//  action = "lambda:InvokerFunction"
//  function_name = aws_lambda_function.dynamo.arn
//  principal = "apigateway.amazonaws.com"
//  source_arn = "arn:aws:execute-api:${var.region}:${var.account_id}:*/*"
//}