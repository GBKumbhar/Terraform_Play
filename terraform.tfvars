# by default, values for vars vl be read form here, must also be declares in variables
# but if we have diff file names xyz.tfvars then theses files need to be passed as parameter as -var-file = xyz.tfvars

my_region     = "ap-south-1"
instance_type = "t2.micro"
img_id        = "ami-068257025f72f470d"
env_name      = "My_tag"