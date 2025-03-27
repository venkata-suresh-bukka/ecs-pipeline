variable "public_subnets" {
    type        = list(string)
}
variable "vpc_id" {}
# variable "ssl_cert_arn" {}
variable "acm_certificate_arn" {
  description = "ARN of the SSL certificate imported into ACM"
  type        = string
  default = "arn:aws:acm:us-east-1:831926591252:certificate/06523101-84de-41a6-9df0-48fee43f29c0"
}

