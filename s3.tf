resource "aws_s3_bucket" "event" {
  bucket        = var.bucket_name
  force_destroy = true
}

resource "aws_s3_bucket_policy" "CloudTrailS3Bucket" {
  bucket = aws_s3_bucket.event.id
  depends_on = ["aws_s3_bucket.event"]
  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [{
            "Sid": "AWSCloudTrailAclCheck",
            "Effect": "Allow",
            "Principal": { "Service": "cloudtrail.amazonaws.com" },
            "Action": "s3:GetBucketAcl",
            "Resource": "arn:aws:s3:::${var.bucket_name}"
        },
        {
            "Sid": "AWSCloudTrailWrite",
            "Effect": "Allow",
            "Principal": { "Service": "cloudtrail.amazonaws.com" },
            "Action": "s3:PutObject",
            "Resource": ["arn:aws:s3:::${var.bucket_name}/AWSLogs/${var.account_id}/*"],
            "Condition": { "StringEquals": { "s3:x-amz-acl": "bucket-owner-full-control" } }
        }]

}
POLICY
}

resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = aws_s3_bucket.event.id

  lambda_function {
    lambda_function_arn = aws_lambda_function.dynamo.arn
    events              = ["s3:ObjectCreated:*"]
    filter_prefix       = "AWSLogs/${var.account_id}/CloudTrail/${var.region}/2020/07/07"
    filter_suffix       = ".json.gz"
  }
    depends_on = [aws_lambda_permission.allow_bucket]
}