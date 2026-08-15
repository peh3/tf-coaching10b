variable "name" {
  type        = string
  default     = "tk-tf-s3"
  description = "Application subdomain prefix"
}

variable "domain_name" {
  type        = string
  default     = "sctp-sandbox.com"
  description = "Route 53 base hosted zone domain"
}