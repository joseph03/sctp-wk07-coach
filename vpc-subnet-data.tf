# These blocks are for filtering existing VPC and Public Subnet
# this is new in local, data, variable class

#search for aws_vpc with Name = "vpc_ce9_learner"
data "aws_vpc" "existing_ce9_vpc" {
 filter {
   name   = "tag:Name"
   #values = ["vpc_ce9_learner"] #name is still hardcoded
   values = [var.vpc_name]
 }
}

data "aws_subnet" "existing_ce9_pub_subnet" {
 filter {
   name   = "tag:Name"
   #values = ["subnet_ce9_learner_us-east-1a"] #name is still hardcoded
   values = [var.subnet_name]
 }
}
