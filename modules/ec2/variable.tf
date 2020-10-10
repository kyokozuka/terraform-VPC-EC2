variable "develop_sn_id" {}
variable "develop_sg_id" {}

variable "stage" {
    default = "develop"
}

variable "region" {
    default = "ap-northeast-1"
}

variable "ec2_key_name" {
    default = "develop"
}

variable "public_key_path" {
    default = "~/.ssh/develop.pub"
}