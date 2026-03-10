resource "aws_vpc" "yadnesh_vpc" {
    cidr_block = var.vpc_cidr

    tags = {
        Name = var.vpc_name
    }
  
}


resource "aws_subnet" "subnets" {
    for_each = var.subnets
    vpc_id = aws_vpc.yadnesh_vpc.id

    cidr_block = each.value.cidr_block
    availability_zone = each.value.availability_zone

    map_public_ip_on_launch = each.value.public

    tags = {
      Name = each.key
    }
  
}


resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.yadnesh_vpc.id
  
}


resource "aws_route_table" "public_rt" {
    vpc_id = aws_vpc.yadnesh_vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }
  
}


resource "aws_route_table" "private_rt" {
    vpc_id = aws_vpc.yadnesh_vpc.id
  
}


resource "aws_route_table_association" "public_assoc" {
    for_each = {
      for name, subnet in var.subnets:
      name => subnet
      if subnet.public == true 
    }

    subnet_id = aws_subnet.subnets[each.key].id
    route_table_id = aws_route_table.public_rt.id
  
}


resource "aws_route_table_association" "private_assoc" {
    for_each = {
      for name, subnet in var.subnets:
      name => subnet
      if subnet.public == false 
    }

    subnet_id = aws_subnet.subnets[each.key].id
    route_table_id = aws_route_table.private_rt.id
  
}


resource "aws_security_group" "main_sg" {
    vpc_id = aws_vpc.yadnesh_vpc.id

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"

        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"

        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"

        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"

        cidr_blocks = ["0.0.0.0/0"]    
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"

        cidr_blocks = ["0.0.0.0/0"]    
    }
  
}