provider "aws" {
  region = "us-east-2"
  profile = "terra_test"
}

resource "aws_instance" "db" {
    ami = "ami-06e3c045d79fd65d9"
    instance_type = "t2.micro"
    tags = {
      Name = "DB Server"
    }
  
}

resource "aws_instance" "web" {
    ami = "ami-06e3c045d79fd65d9"
    instance_type = "t2.micro"
    tags = {
      Name = "Web Server"
    }
    depends_on = [ aws_instance.db ]
  
}

data "aws_instance" "dbsearch" {
  filter {
    name   = "tag:Name"
    values = ["DB Server"]
  }
}

output "dbservers" {
  value = data.aws_instance.dbsearch.availability_zone
  
}