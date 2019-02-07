provider "aws" {
  region = "us-east-1"
}
terraform {
    backend "s3" {
        bucket  = "cap-sre-configs"
        key     = "global/s3/terraform.tfstate"
        region  = "us-east-1"
        encrypt = true
    }
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "cap-sre-configs"

  versioning {
      enabled = true
  }

  lifecycle {
      prevent_destroy = true
  }
}