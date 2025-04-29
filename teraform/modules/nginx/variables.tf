# modules/nginx/variables.tf
variable "http_port" {
  description = "HTTP port for Nginx"
  type        = number
  default     = 80
}

variable "https_port" {
  description = "HTTPS port for Nginx (reserved for future SSL)"
  type        = number
  default     = 443
}

variable "jenkins_host" {
  description = "Docker service name for Jenkins"
  type        = string
  default     = "jenkins"
}

variable "sonarqube_port" {
  type    = number
  default = 9001
}

variable "domain_name" {
  type    = string
  default = "craftmanpro.online"
}

variable "docker_network_name" {
  type    = string
  default = "n22"
}

variable "jenkins_port" {
  type    = number
  default = 8080
}

variable "sonarqube_host" {
  description = "Docker service name for SonarQube"
  type        = string
  default     = "sonarqube"
}


variable "sonarqube_ready_check" {
  description = "Command to check SonarQube readiness"
  type        = string
}

variable "jenkins_ready_check" {
  description = "Command to check Jenkins readiness"
  type        = string
}

variable "sonarqube_dependency" {
  description = "SonarQube container reference"
  type        = any
}

variable "jenkins_dependency" {
  description = "Jenkins container reference"
  type        = any
}
