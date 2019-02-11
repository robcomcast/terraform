provider "aws" {
    region = "us-east-1"
}

terraform {
    backend "s3" {
        bucket  = "cap-sre-configs"
        key     = "prod/data-stores/mysql/terraform.tfstate"
        region  = "us-east-1"
        encrypt = true
    }
}

module "mysql" {
    source = "git::git@github.com:robcomcast/terraform_modules.git//data-stores/mysql?ref=v0.2.2"
  
      db_password                 =   "db_password" # Vault!
}
