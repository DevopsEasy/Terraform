### Terraform Provisioners
* Terraform Provisioners

* A Provisioners can be used to model specific actions on the local machine or on a remote machine in order to prepare some tasks.

* For example if you are creating a server and after that some software need to installed on top it for example in our case we are installing Httpd server. Terraform wont recommend to use provisioners .

* “what if the provisioners Fails in this case “If a creation-time provisioner fails, the resource is marked as tainted. A tainted resource will be planned for destruction and recreation upon the next terraform apply . “Terraform does this because a failed provisioner can leave a resource in a semi-configured state”

* Types of provisioners:

* In day to day activities we use 3 types of provioners.

* 1. Local provisioners.
* 2. Remote Provisioners
* 3. File provisioners

## Local provisioners:
* The local-exec provisioner invokes a local executable code on our local machine after a resource is created.

* The following example shows we create a EC2 instance after that it will give us the attribute private IP address of the server.
* To create a aws key pair.

## Creation of key in local server
* command to generate key

```
ssh-keygen
```
```
resource "aws_key_pair" "dekey" {
  key_name   = "demykey"
  public_key = file("~/.ssh/id_rsa.pub")
}
```

```
provider "aws" {
access_key = ""
secret_key = ""
region = ""
}

resource aws_instance "myec2" {
ami = "ami-0e306788ff2473ccb"
instance_type = "t2.micro"
provisioner "local-exec" {
  command = "echo ${aws_instance.myec2.private_ip} >> private_ips.txt"
}
}
```
## Remote Provisioners:
* Remote provisioners help to execute the scripts on remote servers after they are created.

* For example if you are creating a server and after that some software need to installed on top it for example in our case we are installing Httpd server. Terraform wont recommend to use provisioners.
* When we work with remote provisioners we have to include the script to be executed under INLINE BLOCK.

```
resource "aws_instance" "ec2_example" {

    ami = "ami-0db245b76e5c21ca1"
    instance_type = "t2.micro"
    key_name= "mtckey"

  provisioner "remote-exec" {
    inline = [
        "touch demo.txt"
    ]
  }
  connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "ubuntu"
      private_key = file("/home/ubuntu/.ssh/mtckey")
      timeout     = "4m"
   }
}
```

* In the above we can see a Connection block .

* the default connection type is SSH.
* we need to specfify the path of private key pem file .In our case we are passing through File function.

## File Provioners:
* The file provisioner is used to copy files or directories from the machine executing Terraform to the newly created resource.

```
resource "aws_instance" "ec2_example" {

    ami = "ami-0db245b76e5c21ca1"
    instance_type = "t2.micro"
    key_name= "mtckey"

  provisioner "file" {
    source      = "/home/ubuntu/test-file.txt"
    destination = "/home/ubuntu/test-file.txt"
  }
  connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "ubuntu"
      private_key = file("/home/ubuntu/.ssh/mtckey")
      timeout     = "4m"
   }
}
```
## Null Resource:

* Null Resource means do nothing.
* We can use triggers to get excuted on alerts.

```
resource "null_resource" "sample" {
  provisioner "local-exec" {
      command = "echo hello world"
  }
}



resource "null_resource" "sample" {
    triggers = {
        id = timestamp()
    }
  provisioner "local-exec" {
      command = "echo hello world"
  }
}
```
