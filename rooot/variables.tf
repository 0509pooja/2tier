variable region {}
variable project_name {}
variable vpc_cidr {}       
variable pub_sub_1a_cidr {}
variable pub_sub_2b_cidr {}
variable pri_sub_3a_cidr {}
variable pri_sub_4b_cidr {}
variable pri_sub_5a_cidr {}
variable pri_sub_6b_cidr {}
variable db_username {}
variable db_password {}
variable "alb_domain_name" {
  description = "The DNS name of the Application Load Balancer"
  type        = string
}
variable "waf_name" {
  type        = string
  description = "Name for the WAF Web ACL"
}

variable "waf_description" {
  type        = string
  description = "Description for the WAF Web ACL"
}

variable "waf_scope" {
  type        = string
  description = "Scope: CLOUDFRONT or REGIONAL"
}

variable "waf_metric_name" {
  type        = string
  description = "CloudWatch metric name for WAF"
}

variable "enable_managed_rules" {
  type        = bool
  description = "Enable AWS Managed Rule group"
}

variable "db_name" {
  type        = string
  description = "Name of the RDS database"
}



