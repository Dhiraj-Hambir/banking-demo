provider "aws" {
 region     = "us-east-1"
}
resource "aws_instance" "prod-server" {
  ami                    = "ami-0a0e5d9c7acc336f1"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.ownsg.id]
  key_name               = "dhiraj-mentor"
  tags = {
      Name = "prod-server"
  } 
}
resource "aws_security_group" "ownsg" {
  name = "own-sg"
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
    cidr_blocks = ["0.0.0.0/0"]
}
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
  resource "aws_key_pair" "dhiraj-mentor" {
    key_name   = "dhiraj-mentor"
  public_key = tls_private_key.rsa.public_key_openssh
  }
resource "tls_private_key" "rsa" {
    algorithm = "RSA"
  rsa_bits  = 4096
}
resource "local_file" "dhiraj-mentor" {
    content  = tls_private_key.rsa.private_key_pem
  filename = "dhiraj-mentor"
}
