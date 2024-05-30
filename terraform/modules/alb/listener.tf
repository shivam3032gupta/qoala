locals {
    certificate = {
        "abc" = "arn:aws:acm:ap-south-1:1234567788:certificate/*********",
        "xyz" = "arn:aws:acm:ap-south-1:123453473:certificate/********"
    }
}


resource "aws_lb_listener" "http_listener" {
    count = var.http_listener_required == true  ? 1 : 0
    load_balancer_arn = aws_lb.lb.arn
    port= 80

    default_action {
        type = "forward"
        target_group_arn = aws_lb_target_group.tg[0].arn
      
    }
        depends_on = [ aws_lb.lb ]
        
}



resource "aws_lb_listener" "https_listener" {
    count = var.https_listener_required == true  ? 1 : 0
    load_balancer_arn = aws_lb.lb.arn
    port ="443"
    protocol = "HTTPS"
    certificate_arn = local.certificate["${var.domain_name}"]
    ssl_policy = "ELBSecurityPolicy-2016-08"

    default_action {
        type = "forward"
        target_group_arn = aws_lb_target_group.tg[0].arn
      
    }

    lifecycle {
      ignore_changes = [ default_action ]
    }


    depends_on = [ aws_lb.lb ]
}

output "http_listener_arn" {
    value = aws_lb_listener.http_listener[*].arn
}

output "https_listener_arn" {
    value = aws_lb_listener.https_listener[*].arn   
}






