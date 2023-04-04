data "aws_vpc" "myvpc" {
    default = true
}

output "myvpc" {
  value = data.aws_vpc.myvpc
}



data "aws_vpc" "nt-demo" {
    filter {
        name = "tag:Name"
        values = ["vpcdemo"]
    }
  
}

resource "aws_subnet" "main" {
  vpc_id     = data.aws_vpc.mydemopvpc.id
  cidr_block = "192.168.5.0/24"

  tags = {
    Name = "Mydemo-vpc"
  }
}


data "aws_ami" "example" {
  most_recent      = true
  owners           = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-20230325"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

output "aws-ami-id" {
  values = data.aws_ami.example.id
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.example.id
  instance_type = "t2.micro"

  tags = {
    Name = "HelloWorld"
  }
}