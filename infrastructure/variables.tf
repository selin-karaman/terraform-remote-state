variable "aws_region" {
  description = "AWS region used by LocalStack"
  type        = string
  default     = "us-east-1"
}

variable "demo_bucket_name" {
  description = "Name of the example S3 bucket managed using remote Terraform state"
  type        = string
  default     = "terraform-remote-state-demo"
}
