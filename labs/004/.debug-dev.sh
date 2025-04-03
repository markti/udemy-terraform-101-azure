# set the subscription
export ARM_SUBSCRIPTION_ID="72ad441d-0ca9-4cba-a820-d62a9794e49b"

# set the application / environment
export TF_VAR_application_name="observability"
export TF_VAR_environment_name="dev"

# set the backend
export BACKEND_RESOURCE_GROUP="rg-terraform-state-dev"
export BACKEND_STORAGE_ACCOUNT="stu61sgc8i9d"
export BACKEND_STORAGE_CONTAINER="tfstate"
export BACKEND_KEY=$TF_VAR_application_name-$TF_VAR_environment_name

# run terraform
terraform init \
    -backend-config="resource_group_name=${BACKEND_RESOURCE_GROUP}" \
    -backend-config="storage_account_name=${BACKEND_STORAGE_ACCOUNT}" \
    -backend-config="container_name=${BACKEND_STORAGE_CONTAINER}" \
    -backend-config="key=${BACKEND_KEY}" \
    -reconfigure

terraform $*

# clean up the local environment
rm -rf .terraform