# set the subscription
export ARM_SUBSCRIPTION_ID="dbe31db5-bd50-4652-861a-b4181874d60c"

# set the application / environment
export TF_VAR_application_name="linuxvm"
export TF_VAR_environment_name="prod"

# set the backend
export BACKEND_RESOURCE_GROUP="rg-terraform-state-prod"
export BACKEND_STORAGE_ACCOUNT="sti8xl0h5mwr"
export BACKEND_STORAGE_CONTAINER="tfstate"
export BACKEND_KEY=$TF_VAR_application_name-$TF_VAR_environment_name

# run terraform
terraform init \
    -backend-config="resource_group_name=${BACKEND_RESOURCE_GROUP}" \
    -backend-config="storage_account_name=${BACKEND_STORAGE_ACCOUNT}" \
    -backend-config="container_name=${BACKEND_STORAGE_CONTAINER}" \
    -backend-config="key=${BACKEND_KEY}"

terraform workspace new $TF_VAR_environment_name | terraform workspace select $TF_VAR_environment_name

terraform $* -var-file ./env/$TF_VAR_environment_name.tfvars

# clean up the local environment
rm -rf .terraform