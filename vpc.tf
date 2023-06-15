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

locals {
  common_tags = {
    creatorName = "akanksha Kutal"
    reason      = "CapDev infra"
  }
}
