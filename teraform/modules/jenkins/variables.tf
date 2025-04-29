# modules/jenkins/variables.tf
variable "admin_user" {
  description = "Jenkins admin username"
  type        = string
  default     = "admin"
}

variable "admin_password" {
  description = "Jenkins admin password"
  type        = string
  sensitive   = true
}

variable "jenkins_port" {
  description = "Jenkins web UI port"
  type        = number
  default     = 8080
}

variable "agent_port" {
  description = "Jenkins agent communication port"
  type        = number
  default     = 50000
}

variable "docker_sock_path" {
  description = "Path to Docker socket for Docker-in-Docker"
  type        = string
  default     = "/var/run/docker.sock"
}
