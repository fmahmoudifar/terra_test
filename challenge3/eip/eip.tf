variable "instance_id" {
    type = string
  
}

resource "aws_eip" "Web_EIP" {
    instance = var.instance_id
  
}

output "PublicIP" {
  value = aws_eip.Web_EIP.public_ip
}