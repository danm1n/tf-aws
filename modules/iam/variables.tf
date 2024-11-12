variable "branches" {
  description = "List of branches for CodePipeline to monitor"
  type        = list(string)
}

variable "s3_bucket_arn" {
  description = "The ARN of the S3 bucket for artifacts"
  type        = string
}
