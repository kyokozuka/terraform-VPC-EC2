provider "aws" {
    version  = "2.70.0"
    region   = "ap-northeast-1"
}

# ==================
# VPC
# ==================

resource "aws_vpc" "develop_vpc" {
    cidr_block                  = "192.100.0.0/16"
    enable_dns_hostnames        = true
    enable_dns_support          = true
    instance_tenancy            = "default"

    tags = {
        Name = "develop"
    }
}


# ==================
# Subnet
# ==================
resource "aws_subnet" "develop_sn" {
    count               = 1
    vpc_id              = aws_vpc.develop_vpc.id
    cidr_block          = "192.100.1.0/24"
    availability_zone   = "ap-northeast-1a"

    tags = {
        Name = "develop-pub_sub"
    }
}

# ==================
# Internet Gateway
# ==================
resource "aws_internet_gateway" "develop_igw" {
    vpc_id  = aws_vpc.develop_vpc.id
    tags    = {
        Name = "develop_igw"
    }
}

# ==================
# Route Table
# ==================
resource "aws_route_table" "develop_rtb_pub" {
    vpc_id  = aws_vpc.develop_vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.develop_igw.id
    }
    
    tags    = {
        Name = "develop_rtb_public"
    }
}

resource "aws_route_table_association" "develop_assoc_pub" {
    count          = 1
    route_table_id = aws_route_table.develop_rtb_pub.id
    subnet_id      = element([aws_subnet.develop_sn[0].id], count.index)
}

# ==================
# Default Network ACL
# ==================
resource "aws_default_network_acl" "develop_default_acl" {
    default_network_acl_id = aws_vpc.develop_vpc.default_network_acl_id

    egress {
        protocol    = "all"
        rule_no     = 100
        action      = "allow"
        cidr_block  = "0.0.0.0/0"
        from_port   = 0
        to_port     = 0
    }

    ingress { 
        protocol    = "all"
        rule_no     = 100
        action      = "allow"
        cidr_block  = "0.0.0.0/0"
        from_port   = 0
        to_port     = 0
    }
    
    tags = {
        Name = "develop_acl"
    }
}

# ==================
# Security Group
# ==================
resource "aws_security_group" "develop_sg" { 
    name               = "develop_pub"
    description        = "security group for develop public"
    vpc_id             = aws_vpc.develop_vpc.id
    tags               = {
        Name = "develop_public"
    }
}

# インバウンドルール(SSH接続用)
resource "aws_security_group_rule" "develop_ingress" {
    security_group_id   = aws_security_group.develop_sg.id
    type                = "ingress"
    cidr_blocks         = ["MyglobalIP/32"]
    from_port           = 22
    to_port             = 22
    protocol            = "tcp"
}

# アウトバウンドルール(全開放)
resource "aws_security_group_rule" "develop_egress" {
    security_group_id   = aws_security_group.develop_sg.id
    type                = "egress"
    cidr_blocks         = ["0.0.0.0/0"]
    from_port           = 0
    to_port             = 0
    protocol            = "-1"
}