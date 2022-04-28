resource "aws_ecr_repository" "ecr" {
  name = var.cluster_name
  tags = {
    Name = format("%s-Repro", var.cluster_name)
  }
}
