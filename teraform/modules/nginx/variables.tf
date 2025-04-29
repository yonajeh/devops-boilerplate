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
  default = 9000
}

variable "domain_name" {
  type    = string
  default = "localhost"
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
