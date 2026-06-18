variable "aws_region" {
  default = "us-east-1"
}

variable "instance_type" {
  default = "t3.micro"
}

variable "instance_name" {
  default = "terraform-ec2"
}
variable "key_name" {
  description = "AWS EC2 Key Pair Name"
  default     = "my-ec2-key"
}