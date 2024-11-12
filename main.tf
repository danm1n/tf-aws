provider "aws" {
  region = var.aws_region
}

module "s3_bucket" {
  source         = "./modules/s3"
  s3_bucket_name = var.s3_bucket_name
}

module "iam" {
  source        = "./modules/iam"
  branches      = var.branches
  s3_bucket_arn = module.s3_bucket.s3_bucket_arn
}

module "codepipeline" {
  source                   = "./modules/codepipeline"
  branches                 = var.branches
  s3_bucket_name           = module.s3_bucket.s3_bucket_name
  codepipeline_role_arn    = module.iam.codepipeline_role_arn
  repository_name          = var.repository_name
}

output "s3_bucket_arn_check" {
  value = module.s3_bucket.s3_bucket_name
  description = "Check if s3_bucket_arn is a correctly formatted ARN."
}


output "codestar_connection_arn_check" {
  value = module.codepipeline.codestar_connection_arn
}
