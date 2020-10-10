output "develop_sn_id" {
    value = aws_subnet.develop_sn[0].id
}

output "develop_sg_id" {
    value = aws_security_group.develop_sg.id
}