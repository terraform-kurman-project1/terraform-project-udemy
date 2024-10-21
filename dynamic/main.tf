provider "aws" {
  region = "us-east-2"
}

variable "ingressrules" {
  type = list(number)
  default = [ 80,443 ]
}

variable "egressrules" {
  type = list(number)
  default = [ 80,443,25,3306,54,8080 ]
}

resource "aws_instance" "ec2" {
  ami           = "ami-050cd642fd83388e4"
  instance_type = "t2.micro"
  security_groups = [aws_security_group.webtraffic.name]
}

resource "aws_security_group" "webtraffic" {
  name = "Allow HTTPS"

  dynamic "ingress" {
      iterator = port
      for_each = var.ingressrules
      content {
      description      = "Allow HTTPS traffic"
      from_port        = port.value
      to_port          = port.value
      protocol         = "TCP"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  }

  dynamic egress {
      iterator = port
      for_each = var.egressrules
      content {
      description      = "Allow HTTPS traffic"
      from_port        = port.value
      to_port          = port.value
      protocol         = "TCP"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  }
}