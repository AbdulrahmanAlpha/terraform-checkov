terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  required_version = ">= 1.3.0"
}

provider "aws" {
  region = var.aws_region
  # For local scanning and CI the provider not required to actually authenticate.
  # In real use, configure credentials via environment or GitHub Secrets
}

resource "aws_s3_bucket" "insecure_bucket" {
  bucket = "demo-insecure-bucket-terraform-checkov"
  # intentionally missing server_side_encryption_configuration to trigger Checkov rule
  acl    = "public-read" # insecure for demo purposes
}

resource "aws_security_group" "open_http" {
  name        = "allow-http-open"
  description = "Allow HTTP from anywhere"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # This will be flagged as open in Checkov
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
