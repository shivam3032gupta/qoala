
variable "vpc_cidr_block" {
    description = "CIDR block for the VPC"
    type        = string
}

variable "vpc_name" {
    description = "Name of the VPC"
    type        = string
}

variable "private_subnet_cidr_blocks" {
    description = "CIDR blocks for the private subnets"
    type        = list(string)
}

variable "public_subnet_cidr_blocks" {
    description = "CIDR blocks for the public subnets"
    type        = list(string)
}

variable "availability_zone" {
    description = "Availability zones for the subnets"
    type        = list(string)
    default = [ "ap-south-1a", "ap-south-1b", "ap-south-1c" ]
}