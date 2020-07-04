output "bucket_domain_name" {
  value       = aws_s3_bucket.event.bucket_domain_name
  description = "FQDN"
}

output "bucket_id" {
  value       = aws_s3_bucket.event.id
  description = "Bucket ID"
}

output "bucket_arn" {
  value       = aws_s3_bucket.event.arn
  description = "Bucket ARN"
}

output "prefix" {
  value       = aws_s3_bucket.event.bucket_prefix
  description = "Prefix"
}