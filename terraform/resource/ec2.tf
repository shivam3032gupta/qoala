module "test_resource" {
    source = "../modules/ec2"
    state_file_bucket = "terraform-state-file"
    vpc_state_file_path = "models/ppsl/vpc/launch_infra/terraform.tfstate"
    aws_region = "ap-south-1"
    instance_count = 3
    ami_id = "ami-xxx"
    instance_type = "c6g.large"
    key_name = "test-prod"
    root_volume_delete_on_termination = true
    ebs_volume_delete_on_termination = true
    root_volume_size = 8
    root_volume_type = "gp3"
    
    ebs_volume_type = "gp3"
    ebs_volume_sizes = [100,100,200]
    role = "infra"
    component = "test"
    subcomponent = "test"
    ingress_rules = [["9200","9200","tcp","10.10.10.0/20"],["22","22","tcp","10.10.10.0/24"]]
    egress_rules = [["9200","9200","tcp","10.10.10.0/20"],["22","22","tcp","10.10.10.0/24"]]
    
}