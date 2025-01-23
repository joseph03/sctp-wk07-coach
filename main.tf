#public is a name so that i can use it as below
/*
output "public_ip" {
  value = aws_instance.public.subnet_id
}
*/
# create 3 resources
# hardcoded ami_id, subnet_id, vpc_id
resource "aws_instance" "public" {
  #look for the value from launch instance
  ami                         = "ami-0df8c184d5f6ae949" #find the AMI ID of Amazon Linux 2 in us-east-1
  instance_type               = "t2.micro"
  #check into vpc for more info

  #subnet_id                   = "subnet-002073ebc2bbb5eb8"  #Public Subnet ID, e.g. subnet-xxxxxxxxxxx
  # below is new in local, data, variable class
  # data block is used
  subnet_id                   = data.aws_subnet.existing_ce9_pub_subnet.id

  associate_public_ip_address = true
  #name of public key kept in aws
  key_name                    = "assign1.7key" #Change to your keyname, e.g. jazeel-key-pair
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
 
  tags = {

    #Name = "joseph-ec2-ex02coach"    #Prefix your own name, e.g. jazeel-ec2
    # below is new in local, data, variable class
    # local is used
    Name = "${ local.resource_prefix }-ec2-${ var.env }" # new

  }
}

# below is new in local, data, variable class
locals {
 resource_prefix = "joseph-local-data-variable-tf"
}

# below is new in local, data, variable class
#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance
#under Attribute Reference
output "public_dns" {
 value = aws_instance.public.public_dns
}

output "public_ip" {
 value = aws_instance.public.public_ip
}

#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group.html
resource "aws_security_group" "allow_ssh" {
  name        = "joseph-sg-ex02coach" #new security group name, e.g. jazeel-terraform-security-group
  description = "Allow SSH inbound"
  
  #vpc_id      = "vpc-06d46d59d5148ccd3"  #VPC ID (Same VPC as your EC2 subnet above), E.g. vpc-xxxxxxx
  # below is new in local, data, variable class
  # data block is used
  vpc_id      = data.aws_vpc.existing_ce9_vpc.id

}

#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_ingress_rule
resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.allow_ssh.id
  cidr_ipv4         = "0.0.0.0/0"  
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}
