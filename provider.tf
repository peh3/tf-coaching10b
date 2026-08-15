terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Primary Region for S3 Bucket
provider "aws" {
  region = "us-east-1" # Or ap-southeast-1
}

# Required Aliased Provider for ACM & WAF
provider "aws" {
  alias  = "us_east_1"
  region = "us-east-1"
}