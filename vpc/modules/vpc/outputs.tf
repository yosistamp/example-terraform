output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_ids" {
  value = [for subnet in aws_subnet.public : subnet.id]
}

output "private_subnet_ids" {
  value = [for subnet in aws_subnet.private : subnet.id]
}

output "private_subnet_cidrs" {
  value = [for subnet in aws_subnet.private : subnet.cidr_block]
}

output "vpc_endpoint_sg_id" {
  value = aws_security_group.vpc_endpoint.id
}