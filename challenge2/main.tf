#1 create a DB Server and output the private IP
#2 create a web server and ensure it has a fixed public IP
#3 Create a Security Group for the web server opening ports 80 and 443 (HTTP and HTTPS)
#4 Run the provided script on the web server

provider "aws" {
  region = "us-east-2"
}

variable "machine_image" {
  type        = string
  default     = "ami-050cd642fd83388e4"
  description = "This is the image for an EC2"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

resource "aws_instance" "DB-server" {
  ami           = var.machine_image
  instance_type = var.instance_type

  tags = {
    Name = "DB-server"
  }
}

resource "aws_instance" "web-server" {
  ami           = var.machine_image
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.web-server.id]

  tags = {
    Name = "web-server"
  }

  user_data = <<-EOL
  #!/bin/bash
  sudo yum update -y
  sudo yum install -y httpd
  sudo systemctl start httpd
  sudo systemctl enable httpd
  echo "<h1>Hello from Terraform</h1>" | sudo tee /var/www/html/index.html
  EOL
}

resource "aws_eip" "elasticeip" {
  instance = aws_instance.web-server.id
}

variable "ingressrules" {
  type = list(number)
  default = [80, 443, 22]
}

variable "egressrules" {
  type = list(number)
  default = [80, 443, 22]
}

resource "aws_security_group" "web-server" {
  name = "Allow HTTPS and HTTP for a Web Server"

  dynamic "ingress" {
    iterator = port
    for_each = var.ingressrules
    content {
      description      = "Allow web traffic"
      from_port        = port.value
      to_port          = port.value
      protocol         = "TCP"
      cidr_blocks      = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"  # Allow all outbound traffic
    cidr_blocks      = ["0.0.0.0/0"]
  }
}

output "EIP" {
  value = aws_eip.elasticeip.public_ip
}

output "DB_Server_Private_IP" {
  value = aws_instance.DB-server.private_ip
}

output "DNS_Web_Server" {
  value = aws_instance.web-server.public_dns
}
