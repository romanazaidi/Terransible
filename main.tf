//Security group creation and whitelisting the ip
resource "aws_security_group" "allow_tls" {
  name = "terraform-sg"

  ingress {
 description = "HTTPS traffic"
 from_port = 443
 to_port = 443
 protocol = "tcp"
 cidr_blocks = ["0.0.0.0/0"]
 }
ingress {
 description = "HTTP traffic"
 from_port = 0
 to_port = 65000
 protocol = "tcp"
 cidr_blocks = ["0.0.0.0/0"]
 }
 ingress {
 description = "SSH port"
 from_port = 22
 to_port = 22
 protocol = "tcp"
 cidr_blocks = ["0.0.0.0/0"]
 }
 egress {
 from_port = 0
 to_port = 0
 protocol = "-1"
 cidr_blocks = ["0.0.0.0/0"]
 ipv6_cidr_blocks = ["::/0"]
 }
}
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region     = "us-east-2"
}
resource "aws_instance" "myins" {
  ami                    = "ami-024e6efaf93d85776"
  instance_type          = "t2.micro"
  availability_zone = "us-east-2a"
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  key_name = "insurance_ohio"
  tags = {
    Name = "test-server"
  }

  provisioner "local-exec" {
    command = "echo ${aws_instance.myins.public_ip} > /etc/ansible/hosts"
  }
}
resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCZw6EqgoWAgMlhpeR3Cvem+DR49sHiuOyKK9EhCaiWBcBtBKwLDKxrpvHUl78Fwi5/3xIgPKlKdnpDnPWUjRXIT5giIUp/Scls+T4CjjBeuwX4rQR3DJ+GhvUApdz8OQf5ooqvqUY6MJlafSqhYyTMb6Y1iKCMpqAzkafpO4BkfUaEPveCp2/c9BlV58DHCCmVstvLskZaEsY63Iw9N/cJVaRcNfDc4418//GQqk6dysd9HhNEb6npgFHz3kdf7NZrcdfMIvT+41Nx/oaINU/09MHU2lIcoeKrTI98BghizVHqr62tkjHRgZYDp3T7PH7zjvqBNeQOllT5gXNvC+0x insurance_ohio"
}
