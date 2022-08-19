
resource "aws_instance" "myec2" {
  ami             = var.img_id
  instance_type   = var.instance_type
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

