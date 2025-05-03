resource "aws_vpc" "ce10-vpc-sankari" {
  cidr_block = "10.0.0.0/24"

  tags = {
    Name = "ce10-vpc-sankari"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "ce10-sankari-IGW" {
  vpc_id = aws_vpc.ce10-vpc-sankari.id

  tags = {
    Name = "ce10-sankari-IGW"
  }
}

# Public Route Table
resource "aws_route_table" "ce10-sankari-public" {
  vpc_id = aws_vpc.ce10-vpc-sankari.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ce10-sankari-IGW.id
  }

  tags = {
    Name = "PublicRouteTable"
  }
}

# Subnet
resource "aws_subnet" "ce10_sankari_publicSubnet1" {
  vpc_id                  = aws_vpc.ce10-vpc-sankari.id
  cidr_block              = "10.0.0.0/28"
  availability_zone       = "ap-southeast-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "ce10_sankari_publicSubnet1"
  }
}


# Associate Public Subnet with Route Table
resource "aws_route_table_association" "ce10-publicRT" {
  subnet_id      = aws_subnet.ce10_sankari_publicSubnet1.id
  route_table_id = aws_route_table.ce10-publicRT.id
}

# Security Group (Allow SSH)
resource "aws_security_group" "ce10_sg_sankari_allow_ssh" {
  name        = "ce10_sg_sankari_allow_ssh"
  description = "Allow SSH"
  vpc_id      = aws_vpc.ce10-vpc-sankari.id

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
