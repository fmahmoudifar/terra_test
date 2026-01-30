# terra_test

terraform plan
terraform apply
terraform plan -target aws_instance.ubuntu
terraform apply -target aws_instance.ubuntu
terraform import aws_instance.ubuntu i-0843ee57c41f913b5
terraform state rm aws_instance.ubuntu


## Dev Container (portable setup)

This repo includes a VS Code Dev Container that pre-installs Terraform + AWS CLI.

On another computer:
1) Install Docker + VS Code + the "Dev Containers" extension
2) Clone this repo
3) In VS Code: Command Palette  Dev Containers: Reopen in Container

Credentials are intentionally NOT stored in git.
Inside the container, create an isolated AWS profile:

aws configure --profile terra_test
aws sts get-caller-identity --profile terra_test