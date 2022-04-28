output "reposiry_url" {
  value = aws_ecr_repository.ecr.repository_url
}

output "ecs-cluster" {
  value = aws_ecs_cluster.cluster-ecs
}

output "task-definition" {
  value = aws_ecs_task_definition.task
}