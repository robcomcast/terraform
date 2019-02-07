provider "aws" {
    region = "us-east-1"
}

module "webserver-cluster" {
    source = "../../../modules/services/webserver-cluster"

    cluster_name                =   "webservers-prod"
    cluster_remote_state_bucket =   "cap-sre-configs"
    cluster_remote_state_key    =   "prod/services/webserver-cluster/terraform.tfstate"
    db_remote_state_bucket      =   "cap-sre-configs"
    db_remote_state_key         =   "prod/data-stores/mysql/terraform.tfstate"

}

