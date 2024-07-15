variable "aws_region" {}
variable "access_key" {}
variable "secret_key" {}

provider "aws" {
  region     = var.aws_region
  access_key = var.access_key
  secret_key = var.secret_key
}

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

data aws_vpc "default" {
  default = true
}

resource "aws_security_group" "dg_web_server_sg_tf" {
  name        = "dg_web_server_sg_tf"
  description = "Allow HTTPS to web server"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "HTTPS ingress"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "dg_web_server_sg_tf"
  }
}
