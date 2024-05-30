resource "aws_lb" "lb" {

    name = var.lb_name
    internal = var.internal_load_balancer
    enable_cross_zone_load_balancing =  true
    idle_timeout = var.idle_timeout
    load_balancer_type = "application"

    
    
    access_logs {
        bucket = var.access_logs_bucket
        enabled = var.access_logs_enable
    }

    subnets = "${data.aws_subnets.subnets.ids}"


    lifecycle {
      ignore_changes = [ idle_timeout ,subnets]
    }



    depends_on = [ aws_lb_target_group.tg ]

}