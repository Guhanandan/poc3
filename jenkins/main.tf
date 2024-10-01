# terraform {
#   required_providers {
#     docker = {
#       source  = "kreuzwerker/docker"
#       version = "3.0.2"
#     }
#   }
# }

# provider "docker" {
#   host = "tcp://${var.jenkins_ec2_public_ip}:2375/"
# }

# resource "docker_image" "jenkins" {
#   name         = var.jenkins_image
#   keep_locally = false
# }

# resource "docker_container" "jenkins" {
#   image = docker_image.jenkins.name
#   name  = var.jenkins_container_name

#   ports {
#     internal = 8080
#     external = var.jenkins_ports["8080"]
#   }

#   ports {
#     internal = 50000
#     external = var.jenkins_ports["50000"]
#   }
# }

resource "aws_security_group" "ec2_security_group" {
  name        = "${var.instance_name}-SSSG"
  description = "Allow inbound traffic for ${var.instance_name} instance"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow SSH from anywhere (restrict in production)
  }

  ingress {
    from_port   = 2375
    to_port     = 2375
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow SSH from anywhere (restrict in production)
  }

  ingress {
    from_port   = var.app_port
    to_port     = var.app_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Open the app port
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] # Allow all outbound traffic
  }

  tags = {
    Name = "${var.instance_name}-sg"
  }
}

resource "aws_instance" "jenkins_instance" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.ec2_security_group.id]

  tags = {
    Name = var.instance_name
  }
}


resource "null_resource" "ansible_provision" {
  depends_on = [docker_container.jenkins]

  provisioner "local-exec" {
    command = <<EOT
      ansible-playbook -i ${var.jenkins_ec2_public_ip}, -u ubuntu --private-key ${var.private_key_path} ../ansible_script/jenkins-setup.yml
    EOT
  }
}

output "jenkins_url" {
  value = "http://${var.jenkins_ec2_public_ip}:${var.jenkins_ports["8080"]}"
}