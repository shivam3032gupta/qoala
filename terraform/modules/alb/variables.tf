variable "lb_name" {
  description = "name of load balancer"
  type = string
}

variable "internal_load_balancer" {
  description = "A boolean to determine if the load balancer is internal"
  type = bool
  default = false
  
}

variable "idle_timeout" {
  default = 300
  type = number
}

variable "access_logs_bucket" {
  description = "The name of the S3 bucket where the access logs are stored"
  type = string 
  default = "access-logs-bucket"
  
}


variable "access_logs_enable" {
  description = "A boolean to determine if access logs are enabled"
  type = bool
  default = false
}

variable "state_file_bucket" {
  description = "The name of the S3 bucket where the state file is stored"
  type = string
}



variable "aws_region" {
  description = "The AWS region"
  type = string
  default = "ap-south-1"
}

variable "role" {
  description = "The role of the subnets"
  type = string
  default = "public"
}


variable "host_based_rules" {
  description = "A boolean to determine if host based rules are to be created"
  type = bool
  default = false
  
}

variable "path_based_rules" {
  description = "A boolean to determine if path based rules are to be created"
  type = bool
  default = false
}


variable "http_listener_required" {
  description = "A boolean to determine if an HTTP listener is required"
  type = bool
  default = false
}

variable "https_listener_required" {
  description = "A boolean to determine if an HTTPS listener is required"
  type = bool
  default = false
}


variable "domain_name" {
  description = "The domain name for the certificate"
  type = string
  default = "paytmpayments"
}

variable "vpc_state_file_path" {
  description = "The path to the state file for the VPC"
  type = string
  default = "vpc/terraform.tfstate"
}



variable "target_group" {
  description = "List of target group configurations"
  type        = list(object({
    name                     = string
    port                     = number
    protocol                 = string
    health_check_enabled     = bool
    healthy_threshold        = number
    interval                 = number
    health_check_path        = string
    health_check_protocol    = string
    unhealthy_threshold      = number
    timeout                  = number
    health_check_status_code = string
  }))
}



variable "host_listener_rules" {
    description = "map of listener rules with domain name and target group" 
    type = list(map(string))
    default = [ {
        domain_name = "paytm.com"
        target_group = "paytm"  
    } ]
}

variable "path" {
    default = "/"
    description = "path at which domain name is to be routed"
    type = string
}

variable "path_listener_rules" {
    description = "map of listener rules with path and target group" 
    type = list(map(string))
  
}