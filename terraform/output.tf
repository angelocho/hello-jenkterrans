
output "ec2_map" {
  description = "ID of the EC2 Instances"
  value       = { for i in aws_instance.app_server : i.id => "${i.id}:${i.public_ip}" }
}
