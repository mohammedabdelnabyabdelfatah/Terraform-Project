output "public_alb_dns" {
  value = aws_lb.public.dns_name
}

output "public_tg_arn" {
  value = aws_lb_target_group.public_tg.arn
}

output "private_tg_arn" {
  value = aws_lb_target_group.private_tg.arn
}
