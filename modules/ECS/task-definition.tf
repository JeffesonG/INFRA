resource "aws_ecs_task_definition" "task" {
  family = "${var.cluster_name}-taskDefinition"

  container_definitions = jsonencode([
    {
      "name" : "${var.cluster_name}-container",
      "image" : "${aws_ecr_repository.ecr.repository_url}:latest",
      "memory" : 512,
      "cpu" : 1,
      "enviroment" : []
    }
  ])

}