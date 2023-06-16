resource "aws_instance" "nginx_server" {
  ami                         = "ami-057752b3f1d6c4d6c"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.private_subnet.id
  tags                        = local.common_tags
  key_name                    = "deployer-key"
  associate_public_ip_address = false
  depends_on                  = [aws_internet_gateway.internet_gateway]
}
