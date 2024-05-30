resource "aws_instance" "ec2" {
    count = var.instance_count
    ami = var.ami_id
    instance_type = var.instance_type
    key_name = var.key_name
    subnet_id = element(data.aws_subnets.subnet_id.ids,count.index % length((data.aws_subnets.subnet_id)))
    security_groups = [aws_security_group.instance_security_group.id]
    
    root_block_device {
        delete_on_termination = var.root_volume_delete_on_termination
        volume_size = var.root_volume_size
        volume_type = var.root_volume_type
    }


    dynamic ebs_block_device {
        for_each = var.ebs_required ? [1] : []
        content {
            device_name = var.device_name
            volume_size = element(var.ebs_volume_sizes,count.index)
            volume_type = var.ebs_volume_type
            delete_on_termination = var.ebs_volume_delete_on_termination
        }

    }
        
    
}


output "instance_details" {
    value = aws_instance.ec2
}



