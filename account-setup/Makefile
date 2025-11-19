.PHONY: init plan apply destroy

BIRD_ENV=dev-01
BACKEND_BUCKET=terraform-state-birdwatching-2025-${BIRD_ENV}
BACKEND_KEY=account-setup/terraform-state/terraform.tfstate
BACKEND_REGION=us-east-1

init:
	terraform init \
		-backend-config="bucket=${BACKEND_BUCKET}" \
		-backend-config="key=${BACKEND_KEY}" \
		-backend-config="region=${BACKEND_REGION}"
	terraform workspace select -or-create ${BIRD_ENV}

plan: init
	terraform plan -var-file=workspace_vars/${BIRD_ENV}.tfvars

apply: init
	terraform apply -var-file=workspace_vars/${BIRD_ENV}.tfvars -auto-approve

destroy: init
	terraform destroy -var-file=workspace_vars/${BIRD_ENV}.tfvars -auto-approve
