
resource "aws_vpc"  "vpc" {

    cidr_block = var.vpc_cidr_block
    tags = merge({
        Name = var.vpc_name

    },local.common_tags)
}


resource "aws_subnet" "private_subnet" {
    count = length(var.private_subnet_cidr_blocks)
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.private_subnet_cidr_blocks[count.index]
    availability_zone = element(var.availability_zone,count.index % length((var.private_subnet_cidr_blocks)))
    tags = local.tags

    depends_on = [ aws_vpc.vpc ]
}


resource "aws_subnet" "public_subnet" {
    count = length(var.public_subnet_cidr_blocks)
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.public_subnet_cidr_blocks[count.index]
    availability_zone = element(var.availability_zone,count.index % length((var.private_subnet_cidr_blocks)))
    tags = local.tags

    depends_on = [ aws_vpc.vpc ]
}



resource "aws_internet_gateway" "igw" {
  count = length(var.public_subnet_cidr_blocks)
  vpc_id = aws_vpc.vpc.id
  tags = local.tags
}



resource "aws_route_table" "route_table_public" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

    depends_on = [ aws_subent.private_subnet ]
}


resource "aws_route_table_association" "public_subnet_association" {
  count = length(var.public_subnet_cidr_blocks)

  subnet_id      = aws_subent.public_subnet[count.index].id
  route_table_id = aws_route_table.route_table_public.id
}



resource "aws_eip" "nat_eip" {
    count = length(var.private_subnet_cidr_blocks)
    vpc   = true
    tags  = local.tags
}


resource "aws_nat_gateway" "nat_gateway" {
    count         = length(var.private_subnet_cidr_blocks)
    subnet_id     = aws_subnet.private_subnet[count.index].id
    allocation_id = aws_eip.nat_eip[count.index].id
    tags          = local.tags
}


resource "aws_route_table" "route_table_private" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }
}

resource "aws_route_table_association" "private_subnet_association" {
    count = length(var.private_subnet_cidr_blocks)

    subnet_id      = aws_subnet.private_subnet[count.index].id
    route_table_id = aws_route_table.route_table_private.id

    depends_on = [ aws_nat_gateway.nat_gateway ]

  
}
