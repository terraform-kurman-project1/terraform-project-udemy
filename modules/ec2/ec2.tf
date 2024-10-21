variable "machine_image" {
  type        = string
  default     = "ami-050cd642fd83388e4"
  description = "This is the image for an EC2"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "ec2name" {
  type = string
}

resource "aws_instance" "ec2" {
  ami           = var.machine_image
  instance_type = var.instance_type

  tags = {
    Name = var.ec2name  
  }
}

output "instance_id" {
  value = aws_instance.ec2.id
}