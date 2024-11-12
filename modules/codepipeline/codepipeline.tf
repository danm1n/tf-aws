resource "aws_codepipeline" "codepipeline" {
  for_each = toset(var.branches)
  name     = "${each.key}-example-pipeline"
  role_arn = var.codepipeline_role_arn
  pipeline_type    = "V2"

  artifact_store {
    location = var.s3_bucket_name
    type     = "S3"
  }

  trigger {
    provider_type = "CodeStarSourceConnection"
    git_configuration {
      source_action_name = "Source" 
      push {
        branches {
          includes = [each.key]
        } 
        file_paths {
            includes = ["app/**"]
          }
        }
      }
    }
  
  stage {
    name = "Source"
    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      output_artifacts = ["SourceOutput"]

      configuration = {
        ConnectionArn    = aws_codestarconnections_connection.github_connection.arn
        FullRepositoryId = var.repository_name
        BranchName       = each.key
      }
    }
  }


  stage {
    name = "Deploy"
    action {
      name             = "Deploy"
      category         = "Deploy"
      owner            = "AWS"
      provider         = "CodeDeploy"
      version          = "1"
      input_artifacts  = ["SourceOutput"]

      configuration = {
        ApplicationName     = "my-application"  
        DeploymentGroupName = "my-deployment-group"  
      }
    }
  }
}
