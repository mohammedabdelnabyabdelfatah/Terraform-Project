output "proxy_instance_ids" {
  value = [aws_instance.proxy_az1.id, aws_instance.proxy_az2.id]
}

output "backend_instance_ids" {
  value = [aws_instance.backend_az1.id, aws_instance.backend_az2.id]
}
output "proxy_az1_public_ip" {
  description = "Public IP of Proxy Instance in AZ1"
  value       = aws_instance.proxy_az1.public_ip
}

output "proxy_az2_public_ip" {
  description = "Public IP of Proxy Instance in AZ2"
  value       = aws_instance.proxy_az2.public_ip
}

output "proxy_az1_private_ip" {
  description = "Private IP of Proxy Instance in AZ1"
  value       = aws_instance.proxy_az1.private_ip
}

output "proxy_az2_private_ip" {
  description = "Private IP of Proxy Instance in AZ2"
  value       = aws_instance.proxy_az2.private_ip
}

output "backend_az1_private_ip" {
  description = "Private IP of Backend Instance in AZ1"
  value       = aws_instance.backend_az1.private_ip
}

output "backend_az2_private_ip" {
  description = "Private IP of Backend Instance in AZ2"
  value       = aws_instance.backend_az2.private_ip
}
