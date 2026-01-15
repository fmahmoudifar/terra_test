# resource "aws_instance" "ubuntu" {
#     ami           = "ami-0f5fcdfbd140e4ab7" 
#     instance_type = "t2.small"

#     tags = {
#         Name = "Ubuntu"
#     }
  
# }

# resource "aws_instance" "proxy" {
#     ami           = "ami-0f5fcdfbd140e4ab7" 
#     instance_type = "t2.micro"

#     tags = {
#         Name = "Proxy"
#     }
  
# }


# import {
#   to = aws_instance.ubuntu
#   id = "i-0843ee57c41f913b5"
# }