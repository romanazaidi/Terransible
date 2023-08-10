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
resource "aws_instance" "myec2" {
  ami                    = "ami-024e6efaf93d85776"
  instance_type          = "t2.micro"
  availability_zone = "us-east-2a"
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  key_name = "insurance_ohio"
  tags = {
    Name = "test-server"
  }

  provisioner "local-exec" {
    command = "echo ${aws_instance.myec2.public_ip} > /etc/ansible/hosts"
  }
}
resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = "ssh-rsa MIIEpAIBAAKCAQEAmcOhKoKFgIDJYaXkdwr3pvg0ePbB4rjsiivRIQmolgXAbQSsCwysa6bx1Je/BcIuf98SIDypSnZ6Q5z1lI0VyE+YIiFKf0nJbPk+Ao4wXrsF+K0Edwyfhob1AKXc/DkH+aKKr6lGOjCZWn0qoWMkzG+mNYigjKagM5Gn6TuAZH1GhD73gqdv3PQZVefAxwgplbLby7JGWhLGOtyMPTf3CVWkXDXw3OONfP/xkKpOncrHfR4TRG+p6YBR895HX+zWa3HXzCL0/uNTcf6GiDVP9PTB1NpSHKHiq0yPfAYIYs1R6q+trZIx0YGWA6d0+zx+8476gTXkDpZU+YFzbwvtMQIDAQABAoIBAQCAGLa6GFQpkqCx5abn+U4JXnswTrmFLHN6RDiLomU83fvJlnvRFLTLVh/e8K/llzhvtKGAE6kg7IS8sRTxtXtxDcX6oOtUEV9pllYvgM8RDBNUcKbomq6HPwT6jjMEOGrJb7zDzGxB69zFwsJyAotUeKrprDG8GtAZRf2xUq2KiHss4HVNpYGPxsSTfsqnCxYuqYfJz19edAIrC5xiKP86d1HM7IWldBJGQWoA5red12GIsklsd/vP3Z7zETO/2jl1t1yjSSmcIimEFURMvVjnOC3llWnKzRFuvfgtklhM9gjznzCrLbtUecLUOR/azdfDcDlV+QFM5m8X1uIr4DwxAoGBANe1+cgL/EMNpvmRnqS8mFX3IYryvVXP15uCICLG4GmcGXlr7lCTxvxPlauxPYRbC5UxwMr8gK0xyyWBKJ1hwgcUwbELynFvWmYkBCiNSSsjnJG1PbqtYGMkXdKyKjX6QcE5dFZIqv4285ubtbrupKsfmsMTTAdX0YZsijwedZfNAoGBALZ7uoFuBL3RQ63SC7jDbxp+S5b36reK4F0GH2btOP9rzpnUek97WsCqQjR+hBsGQpGAj5H8q4k3cgi6v8wwUeGOJ2l1E2P+XOLA4DmE7FVCxfkwfYMBCNO1NJkIeMnHhG8NEWcI26yCwz9Ro6zHqbaELB+UptGnPFYcN2lqtj71AoGBAKANexdOpU9PauxUewS6lsF6S94gPBHW1KCjDZsgO1TBKTmptrr82zFND73EFeQF9fMuZmF2tzdK8fOTAQK9jUzZvtnR6NUADXAqGxfHtVmX481NUE8Z46HMUv1Jiv5gALgRHFwFMTLMrTZxc4cPGQmLurYxtEDijSmTkYIIC7KlAoGAQiZV9Ic6RsjuHLuQrjiCNPtlUWOrfT9ll7MZfQkvaT/eU9s3P0q7Gi5d84ONRfKd/Pq6kLQkRoiH2OxBjLZTaE1MsijTj6LsbvJ2FcO+nCWpeGyAgxXD6mK8n2D30EV4F32IOm52m3GHb5Obno1+UwBUsloDoupZr+lomNkrGWUCgYAzCTe19vBS79XVMAoTP+5UmuyLNNf0DpZ3qxHVKYqyrIPts7+rVX3XKZFV4QjdvV7zBl1twNvTMsbWjWhVRxnRA5iUo0k1XB6HEoMvuQDQpUeiKlq9hjEcChjs0AXLE6fjDki+Nvwd6MI0abmdPc04DuUrbAe6ZtzCuM8ekcf1kA=="
}
