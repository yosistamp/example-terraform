resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = {
    Name = var.project
  } 
}

resource "aws_subnet" "public" {
  for_each = { for i in var.public_subnet : i.name => i }
  vpc_id     = aws_vpc.main.id
  cidr_block = each.value.cidr
  availability_zone = each.value.az
  tags = {
    Name = each.value.name
  }
}

resource "aws_subnet" "private" {
  for_each = { for i in var.private_subnet : i.name => i }
  vpc_id     = aws_vpc.main.id
  cidr_block = each.value.cidr
  availability_zone = each.value.az
  tags = {
    Name = each.value.name
  }
}

resource "aws_route_table" "private" {
  count  = length(aws_subnet.private)
  vpc_id = aws_vpc.main.id
}

resource "aws_route_table_association" "private" {
  count          = length(aws_subnet.private)
  subnet_id      = aws_subnet.private[var.private_subnet[count.index].name].id
  route_table_id = aws_route_table.private[count.index].id
}
