resource "aws_s3_bucket" "demo" {
  bucket = var.demo_bucket_name

  tags = {
    Name        = "Remote State Demo"
    Environment = "local"
    ManagedBy   = "Terraform"
  }
}
