variable "vpc_cidr" {
    default = "192.168.0.0/16"
    description = "This is the VPC cidr"
    type = string
}

variable "subnet_cidrs" {
    default = ["192.168.0.0/24","192.168.1.0/24","192.168.2.0/24","192.168.3.0/24"]
    description = "These are subnet cidr ranges"
}