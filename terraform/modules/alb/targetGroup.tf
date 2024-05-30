resource "aws_lb_target_group" "tg" {

    count  = length(var.target_group)
    vpc_id = data.terraform_remote_state.vpc_state.outputs.vpc_id
    name = var.target_group[count.index].name
    target_type = "instance"
    port= var.target_group[count.index].port
    protocol = var.target_group[count.index].protocol
    
    health_check  {
        enabled = var.target_group[count.index].health_check_enabled
        healthy_threshold  = var.target_group[count.index].healthy_threshold
        interval = var.target_group[count.index].interval
        path = var.target_group[count.index].health_check_path
        protocol = var.target_group[count.index].health_check_protocol
        unhealthy_threshold = var.target_group[count.index].unhealthy_threshold
        timeout = var.target_group[count.index].timeout
        matcher = var.target_group[count.index].health_check_status_code
    }
}


output "target_groups_arn" {
    value = aws_lb_target_group.tg[*].arn
}

