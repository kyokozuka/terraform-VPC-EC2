data "template_file" "user_data" {
  template = file("./terraform/modules/ec2/data.sh")
}

# ==================
# EC2 Instance
# ==================
resource "aws_instance" "develop" {
  ami                           = "ami-0cc75a8978fbbc969"
  instance_type                 = "t2.micro"
  availability_zone             = "ap-northeast-1a"
  subnet_id                     = var.develop_sn_id
  vpc_security_group_ids        = [var.develop_sg_id]
  key_name                      = aws_key_pair.auth.id
  associate_public_ip_address   = true
  
  user_data                     = data.template_file.user_data.template

  tags = {
    Name = "develop-ec2"
  }
}

# ==================
# Key Pair
# ==================
resource "aws_key_pair" "auth" {
    key_name    = ""  # my key pair
    public_key  = file("") # key pair pass
}

