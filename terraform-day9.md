## Terraform Import
* We can import manually create resources from aws cloud.

```
# to import 
## terraform import aws_vpc.myvpc <vpcid>

resource "aws_vpc" "myvpc" {}
```

## Terraform Lifecycle
* In terraform there are 3 types of lifecycle.
    * create_before_destroy
    * ignore_changes
    * prevent_destroy [Refer Here](https://developer.hashicorp.com/terraform/language/meta-arguments/lifecycle)


```

resource "aws_vpc" "primary_vpc" {
  cidr_block = var.vpc_cidr
  lifecycle {
    prevent_destroy = true
  }
  tags = {
      Name = "primary"
  }
}



resource "aws_vpc" "primary_vpc" {
  cidr_block = var.vpc_cidr
  lifecycle {
    create_before_destroy = true
  }
  tags = {
      Name = "primary"
  }
}


resource "aws_vpc" "primary_vpc" {
  cidr_block = var.vpc_cidr
  lifecycle {
    ignore_changes = [
      # Ignore changes to tags, e.g. because a management agent
      # updates these based on some ruleset managed elsewhere.
      tags,
    ]
  }
  tags = {
      Name = "primary"
  }
}
```

* Dynamic Block [Refer Here](https://developer.hashicorp.com/terraform/language/expressions/dynamic-blocks)

```
resource "aws_security_group" "websg" {
  vpc_id = aws_vpc.primary_vpc.id

  ingress {
    description = "Open SSH For all"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  ingress {
    description = "Open HTTP For all"
     from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
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

## dynamic block usage 

resource "aws_security_group" "websg" {
  vpc_id = aws_vpc.primary_vpc.id
  dynamic "ingress" {
    for_each = [22,80,443,3306]
    iterator = "port"
    content {
      description = "Open SSH For all"
      from_port = port.value
      to_port = port.value
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }

  ingress {
    description = "Open SSH For all"
    from_port = local.ssh_port
    to_port = local.ssh_port
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

```