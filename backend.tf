terraform {

  backend "s3" {

    bucket  = "demo-bucket-for-terraform-1909" 
    key     = "dev/terraform.tfstate"

    region  = "us-east-1"

    profile = "default"

  }

}