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
  region = "eu-north-1"
}

# Security Group simple
resource "aws_security_group" "allow_all" {
  name        = "allow_all"
  description = "Allow all traffic"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_all"
  }
}

# Clé SSH
resource "aws_key_pair" "vm_key" {
  key_name   = "vm_key"
  public_key = file("terraform_ec2_key.pub")
}

# VM Frontend
resource "aws_instance" "frontend" {
  ami           = "ami-0989fb15ce71ba39e"
  instance_type = "t3.micro"
  key_name      = aws_key_pair.vm_key.key_name
  vpc_security_group_ids = [aws_security_group.allow_all.id]

  user_data = file("../scripts/frontend.sh")

  tags = {
    Name = "Frontend-VM"
  }
}

# VM Backend
resource "aws_instance" "backend" {
  ami           = "ami-0989fb15ce71ba39e"
  instance_type = "t3.micro"
  key_name      = aws_key_pair.vm_key.key_name
  vpc_security_group_ids = [aws_security_group.allow_all.id]

  user_data = file("../scripts/backend.sh")

  tags = {
    Name = "Backend-VM"
  }
}

# VM Database
resource "aws_instance" "database" {
  ami           = "ami-0989fb15ce71ba39e"
  instance_type = "t3.micro"
  key_name      = aws_key_pair.vm_key.key_name
  vpc_security_group_ids = [aws_security_group.allow_all.id]

  user_data = file("../scripts/database.sh")

  tags = {
    Name = "Database-VM"
  }
}

# Outputs pour obtenir les IPs
output "frontend_ip" {
  value = aws_instance.frontend.public_ip
}

output "backend_ip" {
  value = aws_instance.backend.public_ip
}

output "database_ip" {
  value = aws_instance.database.public_ip
}