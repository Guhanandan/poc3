variable "ami_id" {
  description = "The AMI ID for the EC2 instances."
  type        = string
  default     = "ami-039ee4c58100a4af0"
}

variable "jenkins_instance_type" {
  description = "The instance type for Jenkins."
  type        = string
  default     = "t2.micro"
}

variable "sonarqube_instance_type" {
  description = "The instance type for SonarQube."
  type        = string
  default     = "t2.medium"
}

variable "key_name" {
  description = "The key pair name for SSH access."
  type        = string
  default = "server"
}

variable "jenkins_app_port" {
  description = "The port for Jenkins."
  type        = number
  default     = 8080
}

variable "sonarqube_app_port" {
  description = "The port for SonarQube."
  type        = number
  default     = 9000
}

variable "private_key_path" {
  description = " path to the private key"
  type = string
  default = "server.pem"
}