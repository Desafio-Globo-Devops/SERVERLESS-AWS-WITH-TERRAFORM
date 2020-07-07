resource "aws_iam_role" "dynamo" {
  assume_role_policy = file("importFunction/lambda_iam.json")
}

resource "aws_lambda_permission" "allow_bucket" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.dynamo.arn
  principal     = "s3.amazonaws.com"
  source_arn    = aws_s3_bucket.event.arn
}