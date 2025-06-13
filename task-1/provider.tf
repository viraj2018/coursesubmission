terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.0.0-beta2"
    }
  }
}

provider "aws" {
  region  = "us-east-1"
}
terraform {
  backend "s3" {
    bucket = "automationbucketdevops"
    region = "us-east-1"
  }
}

