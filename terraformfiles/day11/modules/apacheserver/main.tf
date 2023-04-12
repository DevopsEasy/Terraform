
resource "aws_key_pair" "dekey" {
  key_name   = "demykey"
  public_key = file("~/.ssh/id_rsa.pub")
}


resource "aws_instance" "apache" {

    ami = "ami-0db245b76e5c21ca1"
    instance_type = "t2.micro"
    key_name= "demykey"
    vpc_security_group_ids = [aws_security_group.test.id]

   provisioner "remote-exec" {
       inline = ["sudo apt install apache2 -y", "sudo service apache2 start"]
    }
  provisioner "file" {
    source      = "/home/ubuntu/test-file.txt"
    destination = "/home/ubuntu/test-file.txt"
  }
  connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "ubuntu"
      private_key = file("/home/ubuntu/.ssh/id_rsa")
      timeout     = "4m"
   }
}

resource "aws_security_group" "test" {
  name = "ec2-login"

  ingress {
    from_port   = "22"
    to_port     = "22"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = "80"
    to_port     = "80"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "apacheip" {
  value = "${aws_instance.apache.public_ip}"
}