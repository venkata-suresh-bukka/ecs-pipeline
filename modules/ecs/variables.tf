# variable "private_subnets" {}
# variable "public_subnets" {}
# variable "vpc_id" {}
# variable "ssl_cert_arn" {}
variable "vpc_id" {}
variable "public_subnets" {}  
variable "private_subnets" {}
# variable "ssl_cert_arn" {}  

variable "task_cpu" {
  default = 512
}

variable "task_memory" {
  default = 1024
}

variable "db_endpoint" {}  
variable "db_username" {}  
variable "db_password" {}  

variable "aws_lb_target_group" {
  description = "Target group ARN for ALB"
  type        = string
}

variable "security_groups" {
  type = list(string)
}
variable "http_listener_arn" {
  description = "ARN of the ALB HTTP listener"
  type        = string
}
variable "aws_account_id" {
  default = "831926591252"
   type        = string
}
variable "alb_sg_id" {}

variable "nodejs_tg_arn" {}
