
resource "aws_instance" "myec2" {
  ami             = var.img_id
  instance_type   = var.instance_type
  key_name        = "aws-key"
  count           = 1
  vpc_security_group_ids = [aws_security_group.main.id]

  tags = {
    Name = "${var.tag}-${var.env_name}-${terraform.workspace}"
  }


 /*  provisioner "file" {
    source      = "./resources/my-test.txt"
    destination = "/home/"
  }  */

  connection {
    host        = self.public_ip
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("resources/aws-key")

  }
}

resource "aws_security_group" "main" {
  egress = [
    {
      cidr_blocks      = [ "0.0.0.0/0", ]
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    }
  ]
 ingress                = [
   {
     cidr_blocks      = [ "0.0.0.0/0", ]
     description      = ""
     from_port        = 22
     ipv6_cidr_blocks = []
     prefix_list_ids  = []
     protocol         = "tcp"
     security_groups  = []
     self             = false
     to_port          = 22
  }
  ]
}

resource "aws_key_pair" "my-key" {
  key_name   = "aws-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC1OdgRflLcuXV+8TYrQUZkOL/XHP3VJOG02YhXyE++l3hnOkmttJ9yheBUHZfcvxud4AVx3qIDl/+l/zVnSQ0qYorGrE1Wix6Y+FT+7jfpz7rMTniiBdAePq0v4cFaqLLU8y2qMFqWj9eTJ5iQ6EDpMEnPmOayTs2qPAvKq37xHvD90yhsZVnIN6r2Lu2jDF1O2EH0eDY/+T8vIVDZCOQqv+qTGQQsxqWr4G2znODIwO8uzIjPtFyAjLHUfhha/GCLrviC1MksoxJtoyvvAvrmd+2bhJWLDXTVIGEfICycgROpXMepl0dIIjTjh+76fmvwketon+EMLG/iMPXG1WVx cw01\\uidj7362@OZL1112W"

}

resource "aws_iam_user" "ExList" {

  #count = length(var.users)
  count = 0
  name  = var.users[count.index]

}

/*

resource "aws_iam_user" "forLoop_iam" {
  for_each = var.users
  name = each.value
} */

output "iamuser" {
  value = [for user in var.users : user]

}

variable "tag" {
  type    = string
  default = "tf_instance"

}

