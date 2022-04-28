resource "aws_ecs_cluster" "cluster-ecs" {
  name = var.cluster_name

  tags = {
    Name = format("%s-Cluster", var.cluster_name)
  }
}