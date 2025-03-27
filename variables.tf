variable "aws_region" {
  description = "AWS region"
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "VPC CIDR Block"
  default     = "10.0.0.0/16"
}

variable "public_subnets" {
  description = "List of public subnet CIDRs"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnets" {
  description = "List of private subnet CIDRs"
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "azs" {
  description = "Availability Zones"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}
variable "db_username" {
  description = "Database username"
}

variable "db_password" {
  description = "Database password"
}

variable "db_name" {
  description = "Database password"
}
variable "bastion_ssh_key" {
  description = "Public SSH key for the bastion host"
  type        = string
}
variable "image_url" {
  description = "ECR Image URL for the Node.js application"
  type        = string
}

# variable "docker_secret_arn" {
  
# }
# variable "wordpress_image" {
  
# }
# variable "security_group_id" {
#   type = string
# }

