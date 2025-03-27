variable "vpc_id" {
  description = "VPC ID"
}

variable "private_subnets" {
  description = "List of private subnet IDs"
  type        = list(string)
}

variable "db_username" {
  description = "Database username"
}

variable "db_password" {
  description = "Database password"
}
variable "bastion_sg_id" {
  description = "Bastion security group ID"
  type        = string
}
