#1 create a DB Server and output the private IP                                  [DONE]
#2 create a web server and ensure it has a fixed public IP
#3 Create a Security Group for the web server opening ports 80 and 443 (HTTP and HTTPS)
#4 Run the provided script on the web server

provider "aws" {
  region = var.region
}

module "database_server" {
  source = "./db-server"
  ec2name = "October-2024"
}

module "web_server" {
  source = "./web-server"
  ec2name = var.ec2-web-name
}

resource "aws_eip" "elasticeip" {
  instance = module.web_server.ec2id
}