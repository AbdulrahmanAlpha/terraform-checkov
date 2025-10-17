variable "aws_region" {
  description = "The AWS region to deploy resources into"
  type        = string
  default     = "us-east-1"
}

variable "app_name" {
  description = "A unique prefix for resources"
  type        = string
  default     = "secure-app"
}
