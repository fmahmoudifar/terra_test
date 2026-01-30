# variable "ec2name" {
#     type = string
  
# }

resource "aws_instance" "web" {
    ami = "ami-06e3c045d79fd65d9"
    instance_type = "t2.micro"
    # security_groups = [ aws_security_group.Web_SG.name ]
    vpc_security_group_ids = [module.sg.sg_name]
    user_data = file("./web/server-script.sh")
    user_data_replace_on_change = true
    tags = {
      Name = "Web Server"
    }
  
}

output "PublicIP" {
  value = module.eip.PublicIP
}

module "eip" {
    source = "../eip"
    instance_id = aws_instance.web.id
  
}

module "sg" {
  source = "../sg"
}
