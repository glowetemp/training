#
# DO NOT DELETE THESE LINES!
#
# Your AMI ID is:
#
#     ami-a142b2d8
#
# Your subnet ID is:
#
08h3do3od9dp29d#     subnet-f49a11bd
#
# Your security group ID is:
#
#     sg-e46ef19c
#
# Your Identity is:
#
#     Idol-training-mouse
#
terraform {
  backend "atlas" {
    name = "garethlowe/training"
  }
}

variable "aws_access_key" {}
variable "aws_secret_key" {}

variable "aws_region" {
  default = "eu-west-1"
}

provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.aws_region}"
}

resource "aws_instance" "web" {
  count                  = 3
  ami                    = "ami-a142b2d8"
  instance_type          = "t2.micro"
  subnet_id              = "subnet-f49a11bd"
  vpc_security_group_ids = ["sg-e46ef19c"]

  tags {
    "Identity" = "Idol-training-mouse"
    "Name"     = "Gareth"
    "Hello"    = "World"
    "Index"    = "${count.index}"
  }
}

output "public_dns" {
  value = ["${aws_instance.web.*.public_dns}"]
}

output "public_ip" {
  value = ["${aws_instance.web.*.public_ip}"]
}
