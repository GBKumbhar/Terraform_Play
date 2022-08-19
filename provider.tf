terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

  backend "s3" {
    bucket = "gk-terrafrom-state"
    key    = "state-file/terraform.tfstate"
    region = "ap-south-1"
    dynamodb_table = "tf-state-locking"
  }
}

provider "aws" {
  region = var.my_region


}