provider "aws" {
  region = "us-east-2"
  profile = "terra_test"
}

module "db" {
  source = "./db"
  server_names = [ "mariadb", "mysql", "mssql"]
  
}

output "private_ip" {
  value = module.db.PrivateIP
  
}