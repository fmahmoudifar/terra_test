terraform {
  required_version = ">= 1.3"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
}

variable "region" {
  type    = string
  default = "us-east-2"
}

# Optional: set to null and use AWS_PROFILE env var instead (recommended).
variable "profile" {
  type    = string
  default = null
}

provider "aws" {
  region  = var.region
  profile = var.profile
}

data "aws_caller_identity" "current" {}
data "aws_region" "current" {}
data "aws_partition" "current" {}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "caller_arn" {
  value = data.aws_caller_identity.current.arn
}

output "caller_user_id" {
  value = data.aws_caller_identity.current.user_id
}

output "region" {
  value = var.region
}

output "partition" {
  value = data.aws_partition.current.partition
}