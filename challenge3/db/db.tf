
resource "aws_instance" "db" {
    ami = "ami-06e3c045d79fd65d9"
    instance_type = "t2.micro"
    tags = {
      Name = "DB Server"
    }
  
}

output "PrivateIP" {
  value = aws_instance.db.private_ip
}
