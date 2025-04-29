variable "jenkins_password" {
  description = "Initial admin password for Jenkins"
  type        = string
  sensitive   = true
}

# variables.tf
variable "domain_name" {
  description = "Base domain or IP for accessing services"
  type        = string
  default     = "localhost"  # Default fallback value
}
