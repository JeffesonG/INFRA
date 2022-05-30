resource "aws_eks_node_group" "cluster" {

  cluster_name    = var.eks_cluster.name
  node_group_name = format("%s-node-group", var.cluster_name)
  node_role_arn   = aws_iam_role.eks_nodes_role.arn

  subnet_ids = [
    var.private_subnet_1a,
    var.private_subnet_1c
  ]

  instance_types = var.nodes_instances_sizes
  remote_access {
    ec2_ssh_key = var.key-pair
  }

  scaling_config {
    desired_size = lookup(var.auto_scale_options, "desired")
    max_size     = lookup(var.auto_scale_options, "max")
    min_size     = lookup(var.auto_scale_options, "min")
  }

  tags = {
    Name                                        = format("%s-AutoScaling-Group", var.cluster_name)
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
  }

}