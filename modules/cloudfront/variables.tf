variable "alb_domain_name" {
  description = "The DNS name of the ALB"
  type        = string
}

variable "project_name" {
  description = "Project name (for tagging)"
  type        = string
}
variable "web_acl_id" {
  type        = string
  description = "The ARN of the WAF Web ACL to attach to CloudFront"
}