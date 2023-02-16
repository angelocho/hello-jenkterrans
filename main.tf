terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "eu-west-1"
}

resource "aws_instance" "app_server" {
  ami           = "ami-0b752bf1df193a6c4"
  instance_type = "t2.micro"
  vpc_security_group_ids = [
    "sg-0d2b1e710a2281426",
  ]
  count = "1"
  subnet_id = "subnet-0f79bf7d4bc65f63b"
  key_name  = "clave-lucatic"
  tags = {
    Name = var.instance_name
    APP  = "vue2048"
  }
    provisioner "local-exec" {
    command = "ansible-playbook -i aws_ec2.yaml httpd_2048.yml"
  }
    provisioner "local-exec" {
    command = "ansible-playbook -i aws_ec2.yaml dockercompup.yaml"
  }
}
