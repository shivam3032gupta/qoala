data "terraform_remote_state" "vpc_state" {
    backend = "s3"
     config = {
        bucket = var.state_file_bucket
        key = var.vpc_state_file_path
        region = var.aws_region
    }
}

data "aws_subnets" "subnets" {
    filter {
      name = "tag:role"
      values = [var.role]
    }

    filter {
        name = "vpc-id"
        values = [data.terraform_remote_state.vpc_state.outputs.vpc_id]
    }

}



