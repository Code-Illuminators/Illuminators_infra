.PHONY: init plan apply destroy
ILLUM_ENV=stage-01
init:
	terraform init
	terraform workspace select -or-create ${ILLUM_ENV}

plan: init
	terraform plan -var-file=workspace_vars/${ILLUM_ENV}.tfvars

apply: init
	terraform apply -var-file=workspace_vars/${ILLUM_ENV}.tfvars -auto-approve

destroy: init
	terraform destroy -var-file=workspace_vars/${ILLUM_ENV}.tfvars -auto-approve