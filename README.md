# Terraform AWS Modular Infrastructure Project

This project demonstrates how to build modular infrastructure on AWS using Terraform.

The infrastructure follows a layered approach:

Network Layer → Security Layer → Compute Layer.

---

## Architecture

The Terraform configuration creates the following infrastructure:

- VPC
- Internet Gateway
- Public Route Table
- Private Route Table
- 2 Public Subnets
- 2 Private Subnets
- Security Group
- 1 Public EC2 Instance
- 1 Private EC2 Instance

### VPC Structure

VPC
│
├── Internet Gateway
│
├── Public Subnet 1 (AZ-a)
│      └── EC2 Instance
│
├── Public Subnet 2 (AZ-b)
│
├── Private Subnet 1 (AZ-a)
│      └── EC2 Instance
│
└── Private Subnet 2 (AZ-b)


#### Overall Project Structure

terraform-module-project
│
├── backend.tf
├── main.tf
├── providers.tf
│
├── vpc
│   ├── main.tf
│   ├── variables.tf
│   └── outputs.tf
│
└── ec2
    ├── main.tf
    └── variables.tf