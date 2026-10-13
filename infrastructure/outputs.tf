output "demo_bucket_name" {
  description = "Name of the demo S3 bucket managed by Terraform"
  value       = aws_s3_bucket.demo.bucket
}

output "demo_bucket_arn" {
  description = "ARN of the demo S3 bucket"
  value       = aws_s3_bucket.demo.arn
}
