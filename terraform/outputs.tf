output "instance_id" {
  description = "The ID of the EC2 instance"
  value       = aws_instance.test_instance.id
}

output "instance_public_ip" {
  description = "The public IP address of the EC2 instance"
  value       = aws_instance.test_instance.public_ip
}

output "instance_public_dns" {
  description = "The public DNS name of the EC2 instance"
  value       = aws_instance.test_instance.public_dns
}

output "eip_public_ip" {
  description = "The public IP address of the Elastic IP"
  value       = aws_eip.test_eip.public_ip
}

output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.test_vpc.id
}

output "subnet_id" {
  description = "The ID of the subnet"
  value       = aws_subnet.test_subnet.id
}

output "security_group_id" {
  description = "The ID of the security group"
  value       = aws_security_group.test_sg.id
}

output "route_table_id" {
  description = "The ID of the route table"
  value       = aws_route_table.test_route_table.id
}

output "internet_gateway_id" {
  description = "The ID of the internet gateway"
  value       = aws_internet_gateway.test_igw.id
}
