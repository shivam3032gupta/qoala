data "terraform_remote_state" "vpc" {

    backend = "s3"
    config = {
        bucket = var.state_file_bucket
        key = var.vpc_state_file_path
        region = var.aws_region
    }
}


data "aws_subnets" "subnet_id" {


    filter {
      name = "tag:role"
      values = [var.role]
    }

    filter {
        name = "vpc-id"
        values = [data.terraform_remote_state.vpc.outputs.vpc_id]
    }
}

data "aws_security_groups" "common_security_group" {
    tags = {
        "role" = "commonsg"
        "component" = "common"
        "subcomponent" = "common"
    }
}


output "subnet_id"{
    description = "value of subnet ids"
    value = data.aws_subnets.subnet_id.ids
}