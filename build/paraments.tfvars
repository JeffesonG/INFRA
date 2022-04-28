cluster_name = "k8s-demo"

aws_region = "us-west-2"

ECSInstanceIMA = "ami-0d96b0a3faa64aa79"

ECSInstanceType = "t2.medium"

k8s_version = "1.21"

nodes_instances_sizes = "t3.large"

auto_scale_options = {
    min     = 2
    max     = 4
    desired = 2
}

auto_scale_cpu = {

    scale_up_threshold  = 80
    scale_up_period     = 60
    scale_up_evaluation = 2
    scale_up_cooldown   = 300
    scale_up_add        = 2

    scale_down_threshold  = 40
    scale_down_period     = 120
    scale_down_evaluation = 2
    scale_down_cooldown   = 300
    scale_down_remove     = -1
}