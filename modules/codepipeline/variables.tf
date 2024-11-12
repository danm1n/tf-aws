variable "s3_bucket_name" {
  description = "The name of the S3 bucket for artifacts"
  type        = string
}

variable "codepipeline_role_arn" {
  description = "The ARN of the IAM role for CodePipeline"
  type        = string
}

variable "repository_name" {
  description = "The name of the repository in 'owner/repo-name' format"
  type        = string
}

variable "branches" {
  description = "A list of branches for CodePipeline to monitor"
  type        = list(string)
}
