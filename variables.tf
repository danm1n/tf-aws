variable "aws_region" {
  description = "The AWS region to deploy resources to"
  type        = string
  default     = "us-west-2"  # Change this to your preferred region
}

variable "s3_bucket_name" {
  description = "The name of the S3 bucket for CodePipeline artifacts"
  type        = string
}

variable "repository_name" {
  description = "The name of the repository in 'owner/repo-name' format"
  type        = string
}

variable "branches" {
  description = "List of branches for CodePipeline to monitor"
  type        = list(string)
  default     = ["main", "dev"]  # Specify the branches you want to monitor, or leave empty if it will be set elsewhere
}
