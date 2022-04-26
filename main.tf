module "vpc" {
  source = "./modules/VPC"

  cluster_name = var.cluster_name
  aws_region   = var.aws_region
}

module "master" {
  source = "./modules/EKS/master"

  cluster_name      = var.cluster_name
  aws_region        = var.aws_region
  k8s_version       = var.k8s_version
  cluster_vpc       = module.vpc.cluster_vpc
  private_subnet_1a = module.vpc.private_subnet_1a
  private_subnet_1c = module.vpc.private_subnet_1c

  depends_on = [
    module.vpc
  ]

}

module "nodes" {
  source = "./modules/EKS/nodes"

  cluster_name = var.cluster_name
  aws_region   = var.aws_region
  k8s_version  = var.k8s_version

  cluster_vpc       = module.vpc.cluster_vpc
  private_subnet_1a = module.vpc.private_subnet_1a
  private_subnet_1c = module.vpc.private_subnet_1c

  eks_cluster    = module.master.eks_cluster
  eks_cluster_sg = module.master.security_group

  nodes_instances_sizes = var.nodes_instances_sizes
  auto_scale_options    = var.auto_scale_options
  auto_scale_cpu = var.auto_scale_cpu

  depends_on = [
    module.master
  ]

}