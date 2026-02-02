provider "aws" {
  region = "us-east-2"
  profile = "terra_test"
}

# resource "aws_vpc" "test" {
#     cidr_block = "10.0.0.0/16"
  
# }

# variable "vpc_id" {
#   type = string
# }

# data "aws_vpc" "existing" {
#   id = var.vpc_id
# }

data "aws_vpc" "existing" {
    id = "vpc-0801888ba08b0e755"
}

output "vpc_cidr" {
  value = data.aws_vpc.existing.cidr_block
}