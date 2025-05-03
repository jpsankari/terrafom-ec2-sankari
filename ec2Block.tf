resource "aws_instance" "sankari_bastionServer" {
  ami                    = "ami-0e8ebb0ab254bb563"
  instance_type          = "t2.micro"
  subnet_id                   = aws_subnet.ce10_sankari_publicSubnet1.id
  vpc_security_group_ids = [aws_security_group.ce10_sg_sankari_allow_ssh.id]
  key_name                    = "sankariKPMay2.pem" # Replace with your actual EC2 key pair name
}
