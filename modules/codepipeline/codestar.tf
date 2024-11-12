resource "aws_codestarconnections_connection" "github_connection" {
  provider_type = "GitHub"

  name = "my-github-connection" 

  tags = {
    Environment = "Production"
  }
}

output "codestar_connection_arn" {
  value = aws_codestarconnections_connection.github_connection.arn
}
