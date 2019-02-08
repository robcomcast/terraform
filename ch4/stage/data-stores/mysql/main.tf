provider "aws" {
    region = "us-east-1"
}

module "mysql" {
    source = "../../../modules/data-stores/mysql"
  
    db_remote_state_bucket      =   "cap-sre-configs"
    db_remote_state_key         =   "stage/data-stores/mysql/terraform.tfstate"
    db_password                 =   "db_password" # Ansible here!
}
