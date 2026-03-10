output "subnet_ids" {
    value = {
        for name, subnet in aws_subnet.subnets:
        name => subnet.id
    }
  
}

output "security_group_id" {
    value = aws_security_group.main_sg.id
  
}