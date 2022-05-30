resource "aws_lb" "elb" {
  name               = "${var.cluster_name}-elb"
  internal           = false
  load_balancer_type = "application"
  subnets            = [var.public_subnet_1a, var.public_subnet_1c]
  security_groups    = [aws_security_group.elb-security-group.id]

  tags = {
    name = "${var.cluster_name}-elb"
  }
}
resource "aws_lb_target_group" "target-group" {
  name     = "${var.cluster_name}-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.cluster_vpc

  health_check {
    path              = "/"
    healthy_threshold = 2
  }
}
resource "aws_alb_listener" "listener_http_to_https" {
  load_balancer_arn = aws_lb.elb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type = "redirect"
    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_alb_listener" "listener_https" {
  load_balancer_arn = aws_lb.elb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.certificateSSL

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target-group.arn
  }

}


