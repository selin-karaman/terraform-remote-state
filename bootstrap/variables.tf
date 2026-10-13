variable "aws_region" {
  description = "AWS region used by LocalStack"
  type        = string
  default     = "us-east-1"
}

variable "state_bucket_name" {
  description = "Name of the S3 bucket used to store Terraform remote state"
  type        = string
  default     = "terraform-remote-state"
}
