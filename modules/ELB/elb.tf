resource "aws_security_group" "elb-security-group" {
  name   = "${var.cluster_name}-AllowELB"
  vpc_id = var.vpc_id

  ingress {
    description = "HTTP from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "TLS from VPC"
    from_port   = 433
    to_port     = 433
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_lb" "vgurus-elb" {
  name               = "vgurus-elb-${var.env}"
  internal           = false
  load_balancer_type = "application"
  subnets            = var.subnets_ids
  security_groups    = [aws_security_group.elb-security-group.id]

  tags = var.tags
}
resource "aws_lb_target_group" "target_group" {
  name     = "public-tf-vgurus-${var.env}-default"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  health_check {
    path              = "/"
    protocol          = "HTTP"
    matcher           = 200
    interval          = 10
    timeout           = 5
    healthy_threshold = 2
  }
}
resource "aws_alb_listener" "listener_http_to_https" {
  load_balancer_arn = aws_lb.vgurus-elb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type = "redirect"
    redirect {
      port        = "433"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}