output "alb_dns_name" {
  value = aws_lb.wordpress_alb.dns_name
}

output "alb_sg_id" {
  value = aws_security_group.alb_sg.id
}


output "target_group_arn" {
  value = aws_lb_target_group.wordpress_tg.arn
}

# output "http_listener_arn" {
#   value = aws_lb_listener.http_redirect.arn
# }
output "http_listener_arn" {
  value = aws_lb_listener.https_listener.arn  # Change to existing listener
}

output "nodejs_tg_arn" {
  value = aws_lb_target_group.nodejs_tg.arn
}
