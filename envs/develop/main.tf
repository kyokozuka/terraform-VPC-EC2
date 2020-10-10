# module "provider" {
#     source = "../../modules/provider"
# }

provider "aws" {
    version  = "2.70.0"
    region   = "ap-northeast-1"
}

module "vpc" {
    source = "../../modules/vpc"
}

module "ec2" {
    source          = "../../modules/ec2"
    develop_sn_id   = "${module.vpc.develop_sn_id}"
    develop_sg_id   = "${module.vpc.develop_sg_id}"
}