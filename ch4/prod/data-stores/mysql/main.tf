provider "aws" {
    region = "us-east-1"
}

module "mysql" {
    source = "../../../modules/data-stores/mysql"
  
    db_remote_state_bucket      =   "cap-sre-configs"
    db_remote_state_key         =   "prod/data-stores/mysql/terraform.tfstate"
}
