variable "project_name"{}
variable "ami" {
    default = "ami-053b0d53c279acc90"
}
variable "cpu" {
    default = "t2.micro"
}
variable "key_name" {}
variable "client_sg_id" {}
variable "max_size" {
    default = 6
}
variable "min_size" {
    default = 2
}
variable "desired_cap" {
    default = 3
}
variable "asg_health_check_type" {
    default = "ELB"
}
variable "pri_sub_3a_id" {}
variable "pri_sub_4b_id" {}
variable "tg_arn" {}
variable "db_username" {
  description = "Database username"
  type        = string
}

variable "db_password" {
  description = "Database password"
  type        = string
}

variable "db_name" {
  description = "Database name"
  type        = string
}

variable "db_host" {
  description = "Database endpoint/host"
  type        = string
}