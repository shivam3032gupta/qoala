variable "instance_count" {
  default =  1
}

variable "state_file_bucket" {
  description = "Provide state file bucket name"
  type = string
}

variable "vpc_state_file_path" {
  description = "Provide vpc state file path"
  type = string
}

variable "aws_region" {
  default = "ap-south-1"
  type = string
}

variable "ami_id" {
  description = "Provide image id"
}

variable "instance_type" {
  description = "Provide instance type"
  default = "t2.micro"
}  

variable "key_name" {
  description = "Provide key name"
}

variable "root_volume_delete_on_termination" {
  description = "value of root volume delete on termination"
  default = true
}

variable "ebs_volume_delete_on_termination" {
  description = "value of ebs volume delete on termination"
  default = true
}

variable "root_volume_size" {
  description = "value of root volume size"
  type = number
  default = 8
}

variable "root_volume_type" {
  default = "gp3"
}

variable "device_name" {
  description = "value of device name"
  default = "/dev/sda1"
}


variable "ebs_volume_type" {
  description = "value of ebs volume type"
  type = string
  default = "gp3"
  
}


variable "ebs_volume_sizes" {
  description = "value of ebs volume sizes of instances in GB eg: [10,100,200] where 10 is for isntance1 , 100 is for instance 2"
  type = list(number)
  default = [ ]
}

variable "role" {
  description = "value of role"
  type = string
}

variable "subcomponent" {
  type = string
}

variable "component" {
  type = string
  
}

variable "environment" {
  type = string
  default = "nonprod"
}


variable "egress_rules" {
  
  default = [["0", "0", "-1", ""]]
}

variable "ingress_rules" {
  
  default = [
    ["22", "22", "tcp", ""]
  ]
}


variable "ebs_required" {
  type = bool
  default = false
}