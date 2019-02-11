provider "aws" {
    region = "us-east-1"
}

terraform {
    backend "s3" {
        bucket  = "cap-sre-configs"
        key     = "prod/services/webserver-cluster/terraform.tfstate"
        region  = "us-east-1"
        encrypt = true
    }
}

module "webserver_cluster" {
    source = "git::git@github.com:robcomcast/terraform_modules.git//services/webserver-cluster?ref=v0.2.2"

    cluster_name                =   "webservers-prod"

    db_remote_state_bucket      =   "cap-sre-configs"
    db_remote_state_key         =   "prod/data-stores/mysql/terraform.tfstate"

    instance_type               =   "m4.large"
    min_size                    =   2
    max_size                    =   10
}

resource "aws_autoscaling_schedule" "scale_out_during_business_hours" {
    scheduled_action_name   =   "scale_out_during_business_hours"
    min_size                =   2
    max_size                =   10
    desired_capacity        =   10
    recurrence              =   "0 9 * * *"

    autoscaling_group_name  =   "${module.webserver_cluster.asg_name}"
}

resource "aws_autoscaling_schedule" "scale_in_at_night" {
    scheduled_action_name   =   "scale_in_at_night"
    min_size                =   2
    max_size                =   10
    desired_capacity        =   2
    recurrence              =   "0 17 * * *"

    autoscaling_group_name  =   "${module.webserver_cluster.asg_name}"

}
