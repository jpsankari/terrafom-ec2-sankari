resource "aws_vpc" "ce10-vpn-sankari" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "ce10-vpn-sankari"
  }
}

# Subnet
resource "aws_subnet" "subnet_sankari_public" {
  vpc_id                  = aws_vpc.ce10-vpn-sankari.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ap-southeast-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "subnet_sankari_public"
  }
}

# Security Group (Allow SSH)
resource "aws_security_group" "ce10_sg_sankari_allow_ssh" {
  name        = "sankari_allow_ssh"
  description = "Allow SSH"
  vpc_id      = aws_vpc.ce10-vpn-sankari.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

 
tags = {
    Name = "ce10_sg_sankari_allow_ssh"
  }
}

resource "aws_instance" "sankari_bastion_instance" {
  ami                    = "ami-0e8ebb0ab254bb563"
  instance_type          = "t2.micro"
  subnet_id                   = aws_subnet.subnet_sankari_public.id
  vpc_security_group_ids = [aws_security_group.ce10_sg_sankari_allow_ssh.id]
  key_name                    = "sankariKPMay2" # Replace with your actual EC2 key pair name
}
