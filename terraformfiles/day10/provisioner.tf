## aws key pair create

resource "aws_key_pair" "dekey" {
  key_name   = "demykey"
  public_key = file("~/.ssh/id_rsa.pub")
}



## file provisioner

resource "aws_instance" "ec2_example" {

    ami = "ami-0db245b76e5c21ca1"
    instance_type = "t2.micro"
    key_name= "dekey"

  provisioner "file" {
    source      = "/home/ubuntu/test-file.txt"
    destination = "/home/ubuntu/test-file.txt"
  }
  connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "ubuntu"
      private_key = file("/home/ubuntu/.ssh/dekey")
      timeout     = "4m"
   }
}

## local & remote exec

resource "aws_instance" "ec2_example" {

    ami = "ami-0db245b76e5c21ca1"
    instance_type = "t2.micro"
    key_name= "dekey"

  provisioner "file" {
    source      = "/home/ubuntu/test-file.txt"
    destination = "/home/ubuntu/test-file.txt"
  }
  provisioner "remote-exec" {
    inline = [
      "touch demo.txt",
      "chmod 600 demo.txt",
    ]
  }
  provisioner "local-exec" {
      command = "echo hello"
    
  }
  connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "ubuntu"
      private_key = file("/home/ubuntu/.ssh/dekey")
      timeout     = "4m"
   }
}
