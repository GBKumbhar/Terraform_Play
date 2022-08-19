# variables must be declared, here we do declaration

variable "img_id" {
}

variable "my_region" {
}

variable "instance_type" {
}

variable "env_name" {
}

variable "users" {
  description = "IAM Users "
  type        = list(string)
  default     = ["user1", "user2", "user3"]
}