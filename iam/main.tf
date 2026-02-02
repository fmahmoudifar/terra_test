# terraform {
# 	required_version = ">= 1.3"

# 	required_providers {
# 		aws = {
# 			source  = "hashicorp/aws"
# 			version = ">= 5.0"
# 		}
# 	}
# }

# variable "region" {
# 	type    = string
# 	default = "us-east-2"
# }

# variable "profile" {
# 	type    = string
# 	default = "terra_test"
# }

# provider "aws" {
# 	region  = var.region
# 	profile = var.profile
# }

provider "aws" {
	region  = "us-east-2"
	profile = "terra_test"
}

resource "aws_iam_user" "myUser" {
    name = "TJ"
}

resource "aws_iam_policy" "customPolicy" {
    name = "MyCustomPolicy"

    policy = <<EOF
{
	"Version": "2012-10-17",
	"Statement": [
		{
			"Sid": "VisualEditor0",
			"Effect": "Allow",
			"Action": [
				"elasticfilesystem:DescribeBackupPolicy",
				"elasticfilesystem:DescribeMountTargets",
				"elasticfilesystem:DescribeReplicationConfigurations",
				"elasticfilesystem:ListTagsForResource",
				"elasticfilesystem:DescribeAccessPoints",
				"elasticfilesystem:DescribeAccountPreferences",
				"elasticfilesystem:DescribeTags",
				"elasticfilesystem:DescribeLifecycleConfiguration",
				"elasticfilesystem:ClientMount",
				"elasticfilesystem:ReplicationRead",
				"elasticfilesystem:DescribeFileSystemPolicy",
				"elasticfilesystem:DescribeFileSystems",
				"elasticfilesystem:DescribeMountTargetSecurityGroups"
			],
			"Resource": "*"
		}
	]
}
EOF
}

resource "aws_iam_policy_attachment" "policyBind" {
    name = "attachment"
    users = [aws_iam_user.myUser.name]
    policy_arn = aws_iam_policy.customPolicy.arn
  
}