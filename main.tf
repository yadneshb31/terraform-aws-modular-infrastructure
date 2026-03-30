module "vpc" {
    source = "./vpc"

    vpc_cidr = "192.168.0.0/16"

    vpc_name = "Terraform-Mini-Project-VPC"

    subnets = {
        public-subnet-1 = {
            cidr_block = "192.168.0.0/24"
            availability_zone = "us-east-1a"
            public = true
        }

        public-subnet-2 = {
            cidr_block = "192.168.1.0/24"
            availability_zone = "us-east-1b"
            public = true
        }
        
        private-subnet-1 = {
            cidr_block = "192.168.2.0/24"
            availability_zone = "us-east-1a"
            public = false
        }

        private-subnet-2 = {
            cidr_block = "192.168.3.0/24"
            availability_zone = "us-east-1b"
            public = false
        }

    }
  
}


module "ec2" {
    source = "./ec2"

    ami_id = data.aws_ami.amazon_linux.id
    instance_type = "t2.micro"

    public_subnet_id = module.vpc.subnet_ids["public-subnet-1"]
    private_subnet_id = module.vpc.subnet_ids["private-subnet-1"]

    security_group_id = module.vpc.security_group_id
  
}