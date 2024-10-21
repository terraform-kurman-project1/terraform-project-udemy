provider "aws" {
  region = "us-east-2"
}

variable "environment" {
  type = string
}

resource "aws_instance" "ec2" {
  ami = "ami-050cd642fd83388e4"
  instance_type = "t2.micro"
  count = var.environment == "prod" ? 1 : 0
}