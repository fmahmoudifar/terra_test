provider "aws" {
  region = "us-east-2"
  profile = "terra_test"
}

variable "number_of_servers" {
    type = number
  
}
resource "aws_instance" "ec2" {
    ami = "ami-06e3c045d79fd65d9"
    instance_type = "t2.micro"
    count = var.number_of_servers

}