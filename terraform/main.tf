# Default VPC
data "aws_vpc" "default" {
  default = true
}

# Default Subnet
data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

# Ubuntu 26.04
data "aws_ami" "ubuntu_26_04" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp*/*ubuntu-resolute-26.04-amd64-server-*"]
  }
}

# Security Group
resource "aws_security_group" "web_sg" {
  name        = "web-sg"
  description = "Allow HTTP and SSH"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["27.34.66.51/32"]  #cidr_blocks = ["YOUR_IP/32"] You need to use your ip through this command "curl -4 ifconfig.me"
  }

ingress {
  from_port   = 5000
  to_port     = 5000
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
} 
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 Instance
resource "aws_instance" "ec2" {
  ami                        = data.aws_ami.ubuntu_26_04.id
  instance_type              = var.instance_type
  subnet_id                  = data.aws_subnets.default.ids[0]
  vpc_security_group_ids     = [aws_security_group.web_sg.id]

 key_name = var.key_name

  associate_public_ip_address = true

  tags = {
    Name = var.instance_name
  }
}