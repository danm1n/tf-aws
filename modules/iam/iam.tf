resource "aws_iam_role" "codepipeline_role" {
  for_each = toset(var.branches)
  name     = "${each.key}-codepipeline-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "codepipeline.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_policy" "codepipeline_policy" {
  name = "CodePipelineExecutionPolicy"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "s3:PutObject",
          "s3:GetObject",
          "s3:ListBucket"
        ],
        Resource = [
          var.s3_bucket_arn,             
          "${var.s3_bucket_arn}/*"        
        ]
      },
      {
        Effect = "Allow",
        Action = [
          "codestar-connections:UseConnection"
        ],
        Resource = "*"
      }
    ]
  })
}


resource "aws_iam_role_policy_attachment" "codepipeline_policy_attachment" {
  for_each   = toset(var.branches)
  role       = aws_iam_role.codepipeline_role[each.key].name
  policy_arn = aws_iam_policy.codepipeline_policy.arn
}


output "codepipeline_role_arn" {
  value = aws_iam_role.codepipeline_role["main"].arn
}
