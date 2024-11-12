
resource "aws_s3_bucket" "codepipeline_artifacts" {
  bucket = var.s3_bucket_name

  tags = {
    Name        = "codepipeline-artifacts"
    Environment = "Test"
  }
}
#
# resource "aws_s3_bucket_acl" "codepipeline_artifacts_acl" {
#   bucket = aws_s3_bucket.codepipeline_artifacts.id
#   acl    = "private"
# }


output "s3_bucket_name" {
  value = aws_s3_bucket.codepipeline_artifacts.bucket
}


output "s3_bucket_arn" {
  value = aws_s3_bucket.codepipeline_artifacts.arn
}
