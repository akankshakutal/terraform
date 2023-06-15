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
  region = "ap-south-1"
}

locals {
  common_tags = {
    creatorName = "akanksha Kutal"
    reason      = "CapDev infra"
  }
}

resource "aws_vpc" "capDev_infra" {
  cidr_block = "11.0.0.0/23"
  tags       = local.common_tags
}

resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.capDev_infra.id
  cidr_block = "11.0.0.0/24"
  tags       = local.common_tags
}

resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.capDev_infra.id
  cidr_block = "11.0.1.0/24"
  tags       = local.common_tags
}

resource "aws_instance" "nginx_server" {
  ami           = "ami-057752b3f1d6c4d6c"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.private_subnet.id
  tags          = local.common_tags
}
