variable "vpc_cidr" {
  description = "VPC CIDR Block"
  type        = string
}

variable "public_subnets" {
  description = "List of public subnet CIDRs"
  type        = list(string)
}

variable "private_subnets" {
  description = "List of private subnet CIDRs"
  type        = list(string)
}

variable "azs" {
  description = "Availability Zones"
  type        = list(string)
}
# variable "key_pair_name" {
#   description = "Name of the key pair for SSH access"
#   type        = string
#   default     = "my-key-pair.pem"
# }
variable "security_group_id" {
  description = "Security group ID for the network"
  type        = string
}
variable "db_sg_id" {}
