terraform {
  required_providers {
    random = {
      source = "hashicorp/random"
      version = "3.5.1"
    }
  }
}


provider "random" {
  # Configuration options
}

resource "random_string" "random_bucket_name_id" {
  length = 8
  special = false
}

resource "random_string" "random_bucket_name" {
  length = 12
  special = false
}


output "random_bucket_name_result" {
    value = random_string.random_bucket_name.result
}

