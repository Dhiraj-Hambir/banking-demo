terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = "us-east-1"
  profile = "prod-server"
}

resource "aws_instance" "example_server" {
  ami           = "ami-0a0e5d9c7acc336f1"
  instance_type = "t2.micro"

  tags = {
    Name = "prod-server"
  }
}
