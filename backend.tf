terraform {
  backend "s3" {
    bucket = "sctp-ce9-tfstate" 
    #at the end of terraform apply or terrafrom destroy
    #tfstate will be updated.
    key    = "joseph-ce9-module2-lesson2.tfstate" # Replace the value of key to <your suggested name>.tfstate for example terraform-ex-ec2-<NAME>.tfstate
    region = "us-east-1"
  }
}