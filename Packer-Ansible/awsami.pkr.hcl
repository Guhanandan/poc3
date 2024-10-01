packer {
  required_plugins {
    amazon = {
      source  = "github.com/hashicorp/amazon"
      version = "~> 1"
    }
    ansible = {
      version = "~> 1"
      source = "github.com/hashicorp/ansible"
    }
  }
}
source "amazon-ebs" "ubuntu" {
  ami_name      = "custom-ami-new"
  instance_type = "t2.micro"
  region        = "ap-south-1"
  source_ami = "ami-039ee4c58100a4af0"
  ssh_username = "ubuntu"
}
build {
  name    = "docker-ami"
  sources = ["source.amazon-ebs.ubuntu"]
  provisioner "ansible" {
    playbook_file = "install_docker.yml"
  }
}
