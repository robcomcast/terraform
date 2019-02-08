#!/bin/sh
terrafrom get data-stores/mysql
terraform init data-stores/mysql
terraform plan data-stores/mysql
terraform apply data-stores/mysql

terrafrom get services/webserver-cluster
terraform init services/webserver-cluster
terraform plan services/webserver-cluster
terraform apply services/webserver-cluster