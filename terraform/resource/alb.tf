module "test_module" {
    source = "../modules/v1/alb/"
    state_file_bucket = "terraform-state-file"
    vpc_state_file_path = "vpc-terraform.tfstate"
    lb_name = "test-lb-module"
    internal_load_balancer = true
    access_logs_enable = false
    role = "elb"
    aws_region = "ap-south-1"
    https_listener_required = true
    domain_name = "xyz"
    target_group = [
        {
            health_check_enabled = true
            healthy_threshold = 3
            interval = 30
            health_check_path = "/"
            health_check_protocol = "HTTP"
            unhealthy_threshold = 3
            timeout = 5
            health_check_status_code = "200"
            name = "test-target-group"
            port = 8
            protocol = "HTTP"
            matcher = "200"
        },
        
            health_check_enabled = true
            healthy_threshold = 3
            interval = 30
            health_check_path = "/"
            health_check_protocol = "HTTP"
            unhealthy_threshold = 3
            timeout = 5
            health_check_status_code = "200"
            name = "test1-target-group"
            port = 8
            protocol = "HTTP"
            matcher = "200"
        },
    ]

    path_based_rules = true
       path_listener_rules = [
        {
            "path" = "/test",
            "target_group_name" = "test-target-group"
        },
        {
            "path" = "/test1",
            "target_group_name" = "test1-target-group"
        }
    ]


   
}