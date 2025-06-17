variable "name" {}
variable "description" {}
variable "metric_name" {}

variable "scope" {
  description = "WAF scope - must be CLOUDFRONT"
  type        = string
}

variable "enable_managed_rules" {
  description = "Enable AWS Managed Rules"
  type        = bool
  default     = true
}
