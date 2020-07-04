//resource "aws_iam_role" "dynamo" {
//  assume_role_policy = <<EOF
//{
//  "Version": "2012-10-17",
//  "Statement": [
//    {
//      "Action": "sts:AssumeRole",
//      "Principal": {
//        "Service": "lambda.amazonaws.com"
//      },
//      "Effect": "Allow",
//      "Sid": ""
//    }
//  ]
//}
//EOF
//
//  tags = {
//    tag-key = "tag-value"
//  }
//}
//// anexando policy de role DYNAMO
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
//  statement {
//    sid = "AllowCreatingLogGroups"
//    effect = "Allow"
//    resources = ["arn:aws:logs:*:*:*"]
//    actions = ["logs:CreateLogGroup"]
//  }
//  statement {
//    sid = "AllowWritingLogs"
//    effect = "Allow"
//    resources = ["arn:aws:logs:*:*:log-group:/aws/lambda/*:*"]
//
//    actions = [
//      "logs:CreateLogStream",
//      "Logs:PutLogEvents",
//    ]
//  }
//}

data "aws_iam_policy_document" "default" {
  count = var.enabled ? 1 : 0

  statement {
    sid = "AWSCloudTrailAclCheck"

    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }

    actions = [
      "s3:GetBucketAcl",
    ]

    resources = [
      "${var.arn_format}:s3:::${aws_s3_bucket.event.id}",
    ]
  }

  statement {
    sid = "AWSCloudTrailWrite"

    principals {
      type        = "Service"
      identifiers = ["config.amazonaws.com", "cloudtrail.amazonaws.com"]
    }

    actions = [
      "s3:PutObject",
    ]

    resources = [
      "${var.arn_format}:s3:::${aws_s3_bucket.event.id}/*",
    ]

    condition {
      test     = "StringEquals"
      variable = "s3:x-amz-acl"

      values = [
        "bucket-owner-full-control",
      ]
    }
  }
}
