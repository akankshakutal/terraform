locals {
  common_tags = {
    creatorName = "Akanksha Kutal"
    reason      = "CapDev infra"
  }
}

resource "aws_vpc" "capDev_infra" {
  cidr_block = "11.0.0.0/22"
  tags       = local.common_tags
}

resource "aws_subnet" "public_subnet" {
  count             = 2
  vpc_id            = aws_vpc.capDev_infra.id
  cidr_block        = element(["11.0.0.0/24", "11.0.1.0/24"], count.index)
  availability_zone = element(["ap-south-1a", "ap-south-1b"], count.index)
  tags              = local.common_tags
}

resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.capDev_infra.id
  cidr_block = "11.0.2.0/24"
  tags       = local.common_tags
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.capDev_infra.id
  tags   = local.common_tags
}

resource "aws_lb" "load_balencer" {
  name                       = "capDev-infra-load-balencer"
  internal                   = false
  load_balancer_type         = "application"
  subnets                    = [aws_subnet.public_subnet[0].id, aws_subnet.public_subnet[1].id]
  enable_deletion_protection = true
  tags                       = local.common_tags
}
