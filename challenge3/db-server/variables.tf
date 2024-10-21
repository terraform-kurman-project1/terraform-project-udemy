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
  default = "DB-server"
}