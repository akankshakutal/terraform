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
  region  = "ap-south-1"
}

resource "aws_instance" "nginx_server" {
  ami           = "ami-057752b3f1d6c4d6c"
  instance_type = "t2.micro"

  tags = {
    Name = "nginx-server"
  }
}
