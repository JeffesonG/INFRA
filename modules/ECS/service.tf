resource "aws_ecs_service" "service" {
  name            = "${var.cluster_name}-Service"
  cluster         = aws_ecs_cluster.cluster-ecs.id
  task_definition = aws_ecs_task_definition.task.arn
  desired_count   = 1
}