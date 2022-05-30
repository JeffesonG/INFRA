output "target-group" {
  value = aws_lb_target_group.target-group
}

output "elb_url" {
  value = aws_lb.elb.dns_name
}

output "elb-id" {
  value = aws_lb.elb.id
}

output "elb-arn" {
  value = aws_lb.elb.arn
}
