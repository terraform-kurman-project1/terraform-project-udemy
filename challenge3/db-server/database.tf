resource "aws_instance" "DB-server" {
  instance_type = var.instance_type
  ami = var.machine_image
  tags = {
    Name = var.ec2name
    description = "This description is inside the database.tf file"
  }
  
}