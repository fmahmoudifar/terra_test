variable "server_names" {
    type = list(string)
  
}

resource "aws_instance" "db" {
    ami = "ami-06e3c045d79fd65d9"
    instance_type = "t2.micro"
    count = length(var.server_names)
    tags = {
      Name = var.server_names[count.index]
    }
  
}

output "PrivateIP" {
  value = [aws_instance.db.*.private_ip]
}
