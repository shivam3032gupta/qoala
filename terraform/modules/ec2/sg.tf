resource "aws_security_group" "instance_security_group" {


    name = "${var.environment}-${var.component}-${var.subcomponent}-sg"
    vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id


    dynamic egress  {
        for_each = var.egress_rules
        iterator = rules
        content {
            from_port = rules.value[0]
            to_port = rules.value[1]
            protocol = rules.value[2]
            cidr_blocks = [rules.value[3]]
        }
    }

    dynamic ingress  {
        for_each = var.ingress_rules
        iterator = rules
        content {
            from_port = rules.value[0]
            to_port = rules.value[1]
            protocol = rules.value[2]
            cidr_blocks = [rules.value[3]]
        }
    }
}