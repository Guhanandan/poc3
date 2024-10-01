variable "jenkins_ec2_public_ip" {
  description = "Public IP of the Jenkins EC2 instance."
  type        = string
}

variable "jenkins_image" {
  description = "The Docker image for Jenkins."
  type        = string
  default     = "jenkins/jenkins:lts"
}

variable "jenkins_container_name" {
  description = "The name of the Jenkins container."
  type        = string
  default     = "jenkins"
}

variable "jenkins_ports" {
  description = "Ports to expose for the Jenkins container."
  type        = map(number)
  default     = {
    "8080"  = 8080,
    "50000" = 50000
  }
}

variable "ami_id" {
  description = "The AMI ID for the EC2 instances."
  type        = string
  default     = "ami-0605eea6c0becbdb3"
}

variable "instance_type" {
  description = "The instance type for the EC2 instances."
  type        = string
}

variable "key_name" {
  description = "The key pair name for SSH access."
  type        = string
}

variable "instance_name" {
  description = "The name of the EC2 instance."
  type        = string
}

variable "app_port" {
  description = "The port for the application."
  type        = number
}

variable "private_key_path" {
  description = " path to the private key"
  type = string
}
