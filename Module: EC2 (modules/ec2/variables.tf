variable "public_subnet_ids" {
  description = "List of public subnet IDs"
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC ID where EC2 and ALB will be deployed"
  type        = string
}

variable "key_name" {
  description = "EC2 key pair name"
  type        = string
}
