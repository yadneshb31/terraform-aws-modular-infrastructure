variable "vpc_cidr" {
    type = string
  
}


variable "vpc_name" {
    type = string
  
}

variable "subnets" {
    type = map(object({
      cidr_block = string
      availability_zone = string
      public = bool
    }))
  
}