include .env

init:
	terraform init

apply:
	terraform apply -auto-approve -var-file=terraform.tfvars

plan:
	terraform plan -var-file=terraform.tfvars

