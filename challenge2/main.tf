provider "aws" {
    region = "us-east-2"
  
}

resource "aws_instance" "DB_Server" {
    ami = "ami-06e3c045d79fd65d9"
    instance_type = "t2.micro"
    tags = {
      Name = "DB_server"
    }
  
}

resource "aws_instance" "Web_Server" {
    ami = "ami-06e3c045d79fd65d9"
    instance_type = "t2.micro"
    # security_groups = [ aws_security_group.Web_SG.name ]
    vpc_security_group_ids = [aws_security_group.Web_SG.id]
    user_data = file("server-script.sh")
    user_data_replace_on_change = true
    tags = {
      Name = "Web_Server"
    }
  
}

resource "aws_eip" "Web_EIP" {
    instance = aws_instance.Web_Server.id
  
}


variable "ingress" {
    type = list(number)
    default = [ 80, 443 ]
  
}

variable "egress" {
    type = list(number)
    default = [ 80, 443 ]
  
}

resource "aws_security_group" "Web_SG" {
    name = "Allow_Web_Traffic"

    dynamic "ingress" {
        iterator = port
        for_each = var.ingress
        content {
            from_port   = port.value
            to_port     = port.value
            protocol    = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
        }
    }

     dynamic "egress" {
        iterator = port
        for_each = var.egress
        content {
            from_port   = port.value
            to_port     = port.value
            protocol    = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
        }
    }  
}

output "DB_IP" {
  value = aws_instance.DB_Server.private_ip
}

output "Web_IP" {
  value = aws_eip.Web_EIP.public_ip
}