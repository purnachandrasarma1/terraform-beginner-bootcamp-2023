terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = ">= 3.5.1"
    }
  }
}

provider "aws" {
  region = "us-east-1"  # You can specify your desired AWS region here.
}

resource "aws_s3_bucket" "example" {
  bucket = random_string.random_bucket_name.result

  # You can specify other bucket settings here if needed, such as ACL and tags
  

  # acl = "private"

  tags = {
    Name       = "MyBucket"  # Replace with your desired bucket name prefix
    Environment = "Dev"
  }
}

resource "random_string" "random_bucket_name" {
  length           = 32
  special          = false
  upper            = false
  numeric          = true
  override_special = "/@"
}

output "aws_s3_bucket" {
  value = random_string.random_bucket_name.result
}
