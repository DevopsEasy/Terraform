variable primary_region {
    type        = string
    default     = "us-west-2"
    description = "The primary region for deploying aws resource"
}

variable primary_network_cidr {
    type        = string
    default     = "10.10.0.0/16"
    description = "address range of primary"
}

variable primary_subnets {
    type        = list(string)
    default     = ["web","app","db","mgmt"]
    description = "subnet name of primary"
}