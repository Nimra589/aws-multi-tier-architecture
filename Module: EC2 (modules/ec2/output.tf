output "alb_dns_name" {
  value = aws_lb.alb.dns_name
}

output "sg_id" {
  value = aws_security_group.web.id
}
