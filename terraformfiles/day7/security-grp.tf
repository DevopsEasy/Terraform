## allow ssh(22),http(80),https(443),postgress(5432)


# Web Security Groups

## locals also a variable used locally

resource "aws_security_group" "websg" {
  vpc_id = aws_vpc.primary_vpc.id

  ingress {
    description = "Open SSH For all"
    from_port = local.ssh_port
    to_port = local.ssh_port
    protocol = local.tcp
    cidr_blocks = [ local.anywhere ]

  }

  ingress {
    description = "Open HTTP For all"
     from_port = local.http_port
    to_port = local.http_port
    protocol = local.tcp
    cidr_blocks = [ local.anywhere ]
  }

  ingress {
    from_port = local.https_port
    to_port = local.https_port
    protocol = local.tcp
    cidr_blocks = [ local.anywhere ]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = [ local.anywhere ]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "WebSg" 
  }

}


resource "aws_security_group" "dbsg" {
  vpc_id = aws_vpc.primary_vpc.id

  ingress {
    description = "Open Postgres within VPC"
    from_port = local.pg_port
    to_port = local.pg_port
    protocol = local.tcp
    cidr_blocks = [ var.vpc_cidr ]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = [ local.anywhere ]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "DB Sg"
  }

}