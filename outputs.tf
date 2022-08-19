
output "private_ip_addr" {

  value     = aws_instance.myec2.*.private_ip
  sensitive = true
}

output "pub_ip_addr" {
  value = aws_instance.myec2.*.public_ip
}