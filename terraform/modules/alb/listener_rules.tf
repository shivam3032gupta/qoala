data "aws_lb_target_group" "tg" {
    count = var.path_based_rules == true  ? length(var.path_listener_rules) : 0
    name = var.path_listener_rules[count.index].target_group_name

    depends_on = [ aws_lb_target_group.tg ]
}

resource "aws_lb_listener_rule" "host_based_rules" {
    count =  var.host_based_rules == true  ?  length(var.host_listener_rules) : 0
    listener_arn = var.http_listener_required ? aws_lb_listener.http_listener[count.index].arn : aws_lb_listener.https_listener[count.index].arn
    action {
        type = "forward"
        target_group_arn = "${data.aws_lb_target_group.tg[count.index].arn}"
    }
    condition {
        host_header {
            values = [var.host_listener_rules[count.index].host]
        }
    }


    depends_on = [ aws_lb_listener.https_listener]
}

output "listener_rule_arn" {
    value = aws_lb_listener_rule.host_based_rules[*].arn
}

resource "aws_lb_listener_rule" "path_based_rules" {
    count = var.path_based_rules == true ? length(var.path_listener_rules) : 0
    listener_arn = var.https_listener_required == true ? aws_lb_listener.https_listener[0].arn : aws_lb_listener.http_listener[0].arn
    action {
        type = "forward"
        target_group_arn = "${data.aws_lb_target_group.tg[count.index].arn}"
    }

    condition {
      path_pattern {
        values = [var.path_listener_rules[count.index].path]
      }
    }

    depends_on = [ aws_lb_listener.https_listener]
}


output "path_based_listener_rule_arn" {
    value = aws_lb_listener_rule.path_based_rules[*].arn
}