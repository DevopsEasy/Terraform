### Terraform Variables
* We have created the resource which look as shown below

```
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
    region = "us-west-2"
}

resource "aws_vpc" "primary_vpc" {
  cidr_block = "192.168.0.0/16"
  tags = {
      Name = "primary"
  }
}


resource "aws_subnet" "web_1" {
  vpc_id = aws_vpc.primary_vpc.id
  availability_zone = "us-west-2a"
  cidr_block = "192.168.0.0/24"
  tags = {
      Name = "Web1"
  }
}

resource "aws_subnet" "web_2" {
  vpc_id = aws_vpc.primary_vpc.id
  availability_zone = "us-west-2b"
  cidr_block = "192.168.1.0/24"
  tags = {
      Name = "Web2"
  }
}


resource "aws_subnet" "db_1" {
  vpc_id = aws_vpc.primary_vpc.id
  availability_zone = "us-west-2a"
  cidr_block = "192.168.2.0/24"
  tags = {
      Name = "db1"
  }
}

resource "aws_subnet" "db_2" {
  vpc_id = aws_vpc.primary_vpc.id
  availability_zone = "us-west-2b"
  cidr_block = "192.168.3.0/24"
  tags = {
      Name = "db2"
  }
}
```

* Lets try to parametrize the configuration, which gives the ability to the user pass information while running the template
* To parametrize we would use variables (input variables, terraform variables)
* [Refer Here](https://www.terraform.io/language/values/variables) for the docs
* To create a variable we need to define a variable block. Lets create a variable for vpc cidr

```
variable "vpc_cidr" {
    default = "192.168.0.0/16"
    description = "This is the VPC cidr"
    type = string
}
```
* To access/use this variable ``` var.<VARIABLE_NAME> ``` is the syntax

```
resource "aws_vpc" "primary_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
      Name = "primary"
  }
}
```

* To pass the variable value from cli ``` terraform apply -var="vpc_cidr=192.168.0.0/16" ```

* Lets create a variable for subnet cidr ranges 

```
variable "subnet_cidrs" {
    default = ["192.168.0.0/24","192.168.1.0/24","192.168.2.0/24","192.168.3.0/24"]
    description = "These are subnet cidr ranges"
}

variable "subnet_azs" {
    default = ["us-west-2a", "us-west-2b", "us-west-2a", "us-west-2b"]
    description = "Availability Zones for the subnets"
}

variable "subnet_names" {
    default = ["Web-1", "Web-2", "DB-1", "DB-2"]
    description = "Names of subnets"

}
```

* Now Lets try to create subnet resources by using the count-meta argument [Refer Here](https://www.terraform.io/language/meta-arguments/count)

```
resource "aws_vpc" "primary_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
      Name = "primary"
  }
}
resource "aws_subnet" "subnets" {
  count = length(var.subnet_cidrs)
  vpc_id = aws_vpc.primary_vpc.id
  availability_zone = var.subnet_azs[count.index]
  cidr_block = var.subnet_cidrs[count.index]

  tags = {
      Name = var.subnet_names[count.index]
  }
}
```

```
variable "vpc_cidr" {
    default = "192.168.0.0/16"
    description = "This is the VPC cidr"
    type = string
}

### first apply vpc after that below 

variable "subnet_cidrs" {
    default = ["192.168.0.0/24","192.168.1.0/24","192.168.2.0/24","192.168.3.0/24"]
    description = "These are subnet cidr ranges"
}

variable "subnet_azs" {
    default = ["us-west-2a", "us-west-2b", "us-west-2a", "us-west-2b"]
    description = "Availability Zones for the subnets"
}

variable "subnet_names" {
    default = ["Web-1", "Web-2", "DB-1", "DB-2"]
    description = "Names of subnets"

}
```

```
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-west-2"
}
```
