resource "aws_instance" "WEB-server" {
  instance_type = var.instance_type
  ami = var.machine_image
  tags = {
    Name = var.ec2name
    description = var.description
  }
  
}