resource "aws_instance" "web_instance_1" {
  ami                           = "ami-03c983f9003cb9cd1"
  associate_public_ip_address   = true
  instance_type                 = "t2.micro" 
  key_name                      = "terraform" 
  vpc_security_group_ids        = [aws_security_group.websg.id]
  subnet_id                     = aws_subnet.subnets[0].id   
}
