resource "aws_iam_role" "dynamo" {
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}
// anexando policy de role DYNAMO
//resource "aws_iam_role_policy_attachment" "dynamo" {
//  policy_arn = aws_iam_policy.dynamo.arn
//  role = aws_iam_role.dynamo.name
//}
//// Policy
//resource "aws_iam_policy" "dynamo" {
//  policy = data.aws_iam_policy_document.dynamo.json
//}
////Descriçao da Policy DYNAMO
//data "aws_iam_policy_document" "dynamo" {
//  statement {
//    sid = "AllowDynamoPermissions"
//    effect = "Allow"
//    resources = ["*"]
//
//    actions = ["dynamodb:*"]
//  }
//  statement {
//    sid = "AllowInvokingLambdas"
//    effect = "Allow"
//    resources = ["arn:aws:lambda:*:*:function:*"]
//    actions = ["lambda:InvokerFunction"]
//  }
//}