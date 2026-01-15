data "aws_vpc" "name" {
    id = "vpc-0801888ba08b0e755"
}

output "vpc_cidr" {
    value = data.aws_vpc.name.cidr_block
}