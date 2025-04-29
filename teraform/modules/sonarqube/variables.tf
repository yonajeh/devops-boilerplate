# modules/sonarqube/variables.tf
variable "sonarqube_port" {
  description = "Port for SonarQube web interface"
  type        = number
  default     = 9001
}

variable "postgres_user" {
  description = "PostgreSQL username"
  type        = string
  default     = "sonar"
}

variable "postgres_password" {
  description = "PostgreSQL password"
  type        = string
  sensitive   = true
}

variable "sonarqube_host" {
  description = "SonarQube container hostname"
  type        = string
  default     = "sonarqube"
}
