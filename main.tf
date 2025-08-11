terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"  # or your preferred region
}

data "aws_ami" "app_ami" {
  most_recent = true
  filter {
    name   = "name"
    values = ["bitnami-tomcat-*-x86_64-hvm-ebs-nami"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["979382823631"] # Bitnami
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.app_ami.id
  instance_type = "t3.micro"
  tags = {
    Name = "HelloWorld"
  }
}
