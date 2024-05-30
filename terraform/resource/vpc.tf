module "vpc" {
    source = "../modules/vpc"
    vpc_name = "vpc"
    vpc_cidr_block = "x.x.x.x/x"
    public_subnet_cidr_blocks = ["x.x.x.x/x", "x.x.x.x/x"]
    private_subnet_cidr_blocks = ["x.x.x.x/x", "x.x.x.x/x"]
}


##The above resource will create vpc along with public and private subnets and internet gateway and route table for public subnet and nat gateway and route table for private subnet
