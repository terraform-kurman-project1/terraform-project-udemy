provider "aws" {
  region = "us-east-2"
}

resource "aws_vpc" "myvpc" {
  tags = {
    Name = "TerraformVPC"
  }
  cidr_block = "192.168.0.0/24"
}